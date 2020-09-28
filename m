Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273DCC2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 10:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994CD2075A
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 10:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2tCuzDCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994CD2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0795F89F0A;
	Mon, 28 Sep 2020 10:43:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCFAD89F0A
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 10:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nw4KZxjVh61KpGviuGqeIVo+siN3wf5OzYv6qdd7CsKe9mPoV4karLV6QLr84rMYoA8ulQ2JA2Q/ulku9INcmGQRZQx5NRkEpit16JAZ9RLFTWs0lJ2lU25ieOpD8+rFMHVrlAvedZy49I3LIAEiFPWJIRLQfrjbkoU6+KTdUdefhOHIHSJf4f68XgqnPwhki7dxCAVD5+h9/mk1fN38lOb4jRH6fCj6Wa8PwbqcN+bUgi//0xuzD3N1M4sFGV4aEo7krX2EiipPzyexEspNMoS6hhkwBw+QWPAlQB/YiN1SMNwOho78hD/mEsPm3/HJLR9J5gpnwDOzzad1WIAskQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vi84QJj2ABHQLp79gjGG/IFywUrltN+uwStagRGFBM4=;
 b=ZeeDDyn1b9/1yr0gcpWARaw5+hIMFlqaECC7JyY4WQSLC6WcAFF2PuWbQbKzi4X1OiNuhvNbt0xW4ww60tZ3YLtRIecYdevJtGOe7vLbG8Gnr4V4UH1S0xAw8WlD5JvNFCib98R9sBPrH2Y0HCbt667HS5zYzd0XUZANeo+v46cjXmGx0ON9FaGwRqtglk+19GhWtTZ7eNjUSIvSaVI0WS4N7iw92n9oxUCCX4srCPve6fRf6KKJ8vhryFHORdRpjBbu0JITFSg2oThdtALWQ3NrJUdvkql3Ll6gK5honhdiFh6zEfr9Q6doIvwdzCdWsTSQ1ulISM41l+QgAazXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vi84QJj2ABHQLp79gjGG/IFywUrltN+uwStagRGFBM4=;
 b=2tCuzDCrpX3J2JVNAbek4/LjA73WkPlKG0Q7QXt/DVKCHeq1J6LLObHcBvFM8c3LxusXk6qZWLeNTqv6RSV1E5hgtjywZ0ZgfJYLKzT50gGcRqzGRjWrkvHuIX9SlfsqBDVs3ZHjIwS67ELMOu9qi/dyyQzJg22YrpkSv4ZE4Yo=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM5PR12MB1611.namprd12.prod.outlook.com (2603:10b6:4:c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20; Mon, 28 Sep 2020 10:43:27 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 10:43:27 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amd/amdgpu: Prepare implementation to support
 reporting of CU usage
Thread-Topic: [PATCH 1/3] drm/amd/amdgpu: Prepare implementation to support
 reporting of CU usage
Thread-Index: AQHWk4empk7fR2+OFk2aSOaLm92GF6l93/dA
Date: Mon, 28 Sep 2020 10:43:27 +0000
Message-ID: <DM6PR12MB37212127AD53B5F59625B26C85350@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200925220240.30957-1-Ramesh.Errabolu@amd.com>
In-Reply-To: <20200925220240.30957-1-Ramesh.Errabolu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-28T10:43:08Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b6e23acf-8245-4976-9ab3-000014bddba1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-28T10:42:59Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 57dbdfb2-0d79-4e73-bd27-0000e2ee665b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-28T10:43:24Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: f3915db9-97e0-455c-974e-000045a5c7a4
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1c80:6680:5c68:43d4:fbcf:8988]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6fd0529-3027-493d-3d0d-08d8639b552d
x-ms-traffictypediagnostic: DM5PR12MB1611:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1611AF4A7D71B6BCC0862ED685350@DM5PR12MB1611.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KY5SCnQ0+C68Amn6E5MD7iSwl35luZxNDOhH9qPZq19/JJjqnrKa+59mlGmm05AFcyL2QXGGV/SJkJYwEDRRgh8FjKo2zca62YDZNrWsh1g2pda68cZInbcAo5ensVmbRkH8IQpvk/Sbemsb2WFVryAZX7CzRQm8mOo32hqXZRpGQ1N/sSurxLJoKsh3GGG7fmkTcO1x6GnJ/aBVWwoAl8Et38EzOeqPP9ydviknROeF4U3Tnb1JPFAyRyqXfRCe+3nI9ZczM/3wgA7H9QQyUM3cKEI6x1L4slb86WzGrduFz5QGhosgko7AEBCUvrpR+OZo+SRlB5T36kEvLxMVUrNMD8Q4wWBVRt1mCIsNJx68wK+rsJLK+AuTS4atnX4E5ymcNzeMaTV3KL/5PpNZNaqqpXVMoljz5aTxMFIXa7V/s2Ka6mrWQpf2RUwEVLL6m6+g/OyjeQFeijbyu0WvPg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(45080400002)(8676002)(478600001)(316002)(110136005)(86362001)(52536014)(83080400001)(66476007)(76116006)(66946007)(966005)(66556008)(66446008)(64756008)(83380400001)(71200400001)(7696005)(4326008)(5660300002)(8936002)(2906002)(9686003)(33656002)(55016002)(186003)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: AdtaKVmBKUiC5X8MWW7E8F6qiLEf38Fniyq4T5i6w+tRED96tFpFSRC0v3jxr2NdtPX7fZHr68TZMBml5N3GONczjaMTxLWVXFg+jj8aIYevFJjIR9Lw1gvzowU8QIA6+3PvGUpbdURbsdsT4HE30rEMQlVsXC83ZooISlhIqs8X0I9Nw50fvggwuYAizqSEeZRAlh5DUu4pj8/i5ZQh7QaZkock3R47xYP/73Dmkn7n7wBpqJIFYsbuSUam9ng4tbWpJUKk/J1eRmOSakaN4HTmUvlVVQUFVAhEIf1bPi2X4l+nC8Z2xDUbhIwLtdrpMnF0cFrWkzeCii4HhDMcm0Rv7CP7HLXWR1Ka71q1pooDWZUxCRvc8KiD+Fyf9FA5WCxWnkpUamjU7NuUTsryZmDhssp0WyG8P/ekzZwClwyO2vE2smnQGx1JHkUbsf+rydma0K3CXIyKigpdDPi2nvZdiEo3J2CZiTQoeqaQoHSOHI9pRDYI4d9OFDmURtGMHts+QVK2o/b927+L+cHAoM+gI3z8dDUUs6aPkdea8Mq+AX+M6nKm3ADZGJAf+I8YULKN69oI62/6aGHhrUOl0j9BNM8eWOEJWGMT2cv7Iq2FtiYtWZMzuoiaWOdRPR3zQtUKR08Wo/ntM5rltBDpNz9yicupAVKWqQFOroPDXEEmRJ95cuo/gpW3MUKAdszu6j/2dDDyvOEc51SaibpaNw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fd0529-3027-493d-3d0d-08d8639b552d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 10:43:27.1424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGAWHOmWnERmrtPggOmFNibmOw/RUz7lpGlcWU8AsL1dDkZZ/zoTpMC3Srq2Mqa76GoF96II7u53FNqmlGTtwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1611
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Comments inline

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ramesh Errabolu
> Sent: Friday, September 25, 2020 6:03 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
> Subject: [PATCH 1/3] drm/amd/amdgpu: Prepare implementation to support reporting of
> CU usage
> 
> [Why]
> Allow user to know number of compute units (CU) that are in use at any
> given moment.
> 
> [How]
> Read registers of SQ that give number of waves that are in flight
> of various queues. Use this information to determine number of CU's
> in use.
> 
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 11 ++++++-----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h |  5 +----
>  2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 346d8288f6ab..75a17a4007ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -49,6 +49,7 @@
>  #include "amdgpu_ras.h"
> 
>  #include "gfx_v9_4.h"
> +#include "gfx_v9_0.h"
> 
>  #include "asic_reg/pwr/pwr_10_0_offset.h"
>  #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
> @@ -785,10 +786,9 @@ static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev);
>  static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev);
>  static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev);
>  static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
> -static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
> -                                 struct amdgpu_cu_info *cu_info);
>  static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
> -static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
> u32 instance);
> +static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
> +		struct amdgpu_cu_info *cu_info);
We don't need to move this function definition down here, do we? Keeping the diff as small as possible is ideal, and helps with the git history/blame functionality

>  static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
>  static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
>  static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
> @@ -2397,7 +2397,8 @@ static void gfx_v9_0_tiling_mode_table_init(struct
> amdgpu_device *adev)
>  	/* TODO */
>  }
> 
> -static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
> u32 instance)
> +void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
> +			   u32 instance)
>  {
>  	u32 data;
> 
> @@ -6924,7 +6925,7 @@ static u32 gfx_v9_0_get_cu_active_bitmap(struct amdgpu_device
> *adev)
>  }
> 
>  static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
> -				 struct amdgpu_cu_info *cu_info)
> +			 struct amdgpu_cu_info *cu_info)

Keep the indentation where it was

>  {
>  	int i, j, k, counter, active_cu_number = 0;
>  	u32 mask, bitmap, ao_bitmap, ao_cu_mask = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> index fa5a3fbaf6ab..37eba971acb1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> @@ -26,9 +26,6 @@
> 
>  extern const struct amdgpu_ip_block_version gfx_v9_0_ip_block;
> 
> -void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num);
> -
> -uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
> -int gfx_v9_0_get_cu_info(struct amdgpu_device *adev, struct amdgpu_cu_info *cu_info);
> +void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32
> instance);

You shouldn't remove get_gpu_clock_counter . Also, the definition should stay where it was (above get_gpu_clock_counter). And get_cu_info should also stay.

 Kent

> 
>  #endif
> --
> 2.27.0
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.or
> g%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7C7d7719c7d79d42b0929b08d8619
> ec6d5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637366681875267026&amp
> ;sdata=uugTvQGeVADMxj06qT4LHriy3GEs2Zg3%2Bzpln0VX6b4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
