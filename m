Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D81C83004
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 16:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E7620787
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 16:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KHr/FPwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E7620787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9439E6EAB7;
	Wed, 29 Apr 2020 16:41:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD596EAB7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 16:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsYQKknonqbXZ7eOjscduGGiW9irNzanYfD/Hl4kgvaKtAki5hinDT3UNyF6XgDOtB9rUn8tMDBT0EbW3yUqUFyYxI4XE+CViO+Z56+2YZ8XUuJlLkb/zinDzrnzyK1oNz5j+Q8Z1/p+zxyPva4qddK/PWlZMM6/e50rUgQkkU6gTveeCN1/SB8CYtJ41zoM6iHygKbv4Dg6oQL/z1pUOK6if11KXPecPutVNfL+dPnT0yfFzEAK8Nf4dbyphsfEnx9VddcUrwyrMNgyo1rEVxLLJgKWGHk0gwG/XsMJPY5oFY/0JpBdpwskdmq6YJj26MTZ6rx+36Neijr98ONxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVcHxdGGa3XkNXdF3qd/0YgAmOzaLE3i9JvOjWYF9CI=;
 b=LUdnF1cybIDF3Hli10Py7PqnG4KAjWwHk8PmLE8iSqMg06gZ59zVC5dRLXW8+fYd8vCwSj3rVjKXQXLen5M9kMTSObJSRvphRGeGjCcwhS3lC26h3U5wnr6+MGY9A3US5NnjPCu2czWF/WiIq6DVlrviLoXPkRbi+x726/bTxEMh2PbGBoTSZ+vmFZqfw+At3omIwtYfDqiHjm5Ogj9zhI8jrQPRlwf1Bge1ZDUOGo643o0h4sqe3fwKwggj9Dkmr0v5KWiyTaLUutRz+rWZEuFR6wJqdsFZmhkvko1P38KdP0vN08zb7aVXwd9TpKUTG7JqqLWUdb781bQ3XtFwnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVcHxdGGa3XkNXdF3qd/0YgAmOzaLE3i9JvOjWYF9CI=;
 b=KHr/FPwETB0fMQ50bX3nPTIbVDzziqRo4TlMCGbr3u/GvlcvkHGPK4w1p6O4FhFM/Ng32UK4beyv+1m+q2sozTo0ykp7tzrgdnXFj31VOE6LG5qumXtj5DH+L4ixVW3bSiAZuozmw6/7F+Z1SpPBd63LzjbNQxSVw6K2iVq8IeQ=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 16:41:09 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 16:41:09 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Add ReadSerial defines for Arcturus
Thread-Topic: [PATCH 1/2] drm/amdgpu: Add ReadSerial defines for Arcturus
Thread-Index: AQHWHLOT9Znco8RCBUOVWey7zA80HaiQUIhA
Date: Wed, 29 Apr 2020 16:41:09 +0000
Message-ID: <DM6PR12MB3721AF6163986B3C9D34E92485AD0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200427164735.27409-1-kent.russell@amd.com>
In-Reply-To: <20200427164735.27409-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-29T16:41:07Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4a7f4a8a-8ad4-47e1-9213-0000cfe57f62;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-29T16:41:07Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 67eb5be9-75fa-4571-9b9c-00003da8d70d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1ca0:aecb:d812:3a5e:6edb:851f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ce44c31-6a37-4f18-8c8b-08d7ec5c1f13
x-ms-traffictypediagnostic: DM6PR12MB2843:
x-microsoft-antispam-prvs: <DM6PR12MB2843F4CDBCF641CC65B1202B85AD0@DM6PR12MB2843.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(71200400001)(76116006)(6916009)(9686003)(55016002)(64756008)(8676002)(316002)(66476007)(66946007)(186003)(66446008)(66556008)(7696005)(6506007)(53546011)(33656002)(5660300002)(19627235002)(52536014)(2906002)(86362001)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GezR3zzJ2OY2KXt4RO7BEhA4n2Fqi0MjoOspHdW+5Uf51SJEcsZE+SxjXEz/i+yYhY4L6BcqxKg/LgAeKLnoYoptDT+VEYd7fm2TF/w+7W7+ldbokgdA9wVZSuEHXmDvaKoo20Vu7eLUkurSC3obI1DCGmP+LVqDl1CxyDiALWt7YlPzw/mED6OUTtLgLTsWWpX8Ji+KWdicBBcCjjaC/Z1aXwH0xCHd8hcH+WlmaDXik/mHsId7la+SxKqdQb94rzGc8XfmQEYQzptjnL6seoJ6Vs6wVJFYZpDhGPx2e6/sQ608mJDTPluC1Gd25cQI27kM5b9S1Vx4aPgwOM54FoCoLazZSBteL8UrwlNMgqugkSsClSwrwyxL3/Jd+Vr6uxKnVgcMnmstXbmR+4w4DX7Ke0G9UC7UU0Ay6V8tisPeV+jFQ313bUMYUHxZY0as
x-ms-exchange-antispam-messagedata: THKkXtQmUmv0FRubjXlVGgReFvPjOLlR4k0630J5OdjH+mm8ZhayK7wDr19Cmkd1EeQpstRrFs0ioerRIlOVr02UXxtkQVD/V5voyqSYs9yvcgDFLMjwaGmu7GSY5RFMoxAWruFbNdVNLQvuL8HaPEqn9b1lT/UA9V+tCDwvDVgHbG3WoKXk4usr62wGAGet6waODcpXsK9WGFDAcvtATpYBmNaOoAYpEBtiIm8Z8dxpVfkQQIJ9jEHVYPGXFNZW/1MuJiO81bYcE7VdM2FBk9Sb5XOu5/TfOcW9tEsFyllplOa3hs0HznvLnxd4F4KaAL/CI1QoKeSR7WeQ3usvXw07Dw1Mi7oAs7X99/0q2B+zBYLhATcT7elgdzSqxUnnfEYL2O14pd1IcODbBWE7/cEtq6HNp7EX/afhSyLkMWnmuT7ftFghX8k1AI5owD84QcJDUyF37xvsVNPdCaqOHUqqGOSI6dKRVT9FR6g9GqJvfolb2+cEAZqZI4y0B5okxzTewKrTAb+20wl3dGkKoOnmJ5IheOvBK4znsXjo+3tlE+l1DYkRT7ENYb3sojalyHQW8EZYtOqdZ4AYGp02WAFiL/GrstpLoIbLB6txUJpTHZFrdSbxH/kPLlbQLDWbSCMq7DFxiefYiJAIAA9y5awJ/9iPPdiUTyPWqD5VpyqM9PV6HIJn74wEk8Ie9TaxpJUI88e155ktoJSz+oENG8oTtUb164YzIxUy9jDKZnVgH+DxU2alIj5Dy39Tblhh3GY6afnMqViua/74HpvvoC+fm/ep323QZkC0y0Xv3mSkhzFvzTwzrgHtpF/auAjvhtqwXqE4y1xMwDS5W6r85oaFyC7gOiriwuy7w6x+OauUZABwHLCHyydXgrwYMnEh
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce44c31-6a37-4f18-8c8b-08d7ec5c1f13
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 16:41:09.6976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/6pmbJW/Z3AeXlUhalWMADMdccsIS+bm7+eIachSp8YiVW4HUixlz9yBIMzfSVJDYm/4rccY6QtsG+MOTOOPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2843
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Friendly ping

> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Monday, April 27, 2020 12:48 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: Add ReadSerial defines for Arcturus
> 
> Add the ReadSerial definitions for Arcturus to the arcturus_ppsmc.h header for
> use with unique_id
> 
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> Change-Id: I71849ec381730b1803e54cd6040aa3b245b53de8
> ---
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 2 ++
>  drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 1c66b7d7139c..e98d92ec1eac 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -128,6 +128,8 @@ static struct smu_11_0_cmn2aisc_mapping
> arcturus_message_map[SMU_MSG_MAX_COUNT]
>  	MSG_MAP(SetXgmiMode,
> PPSMC_MSG_SetXgmiMode),
>  	MSG_MAP(SetMemoryChannelEnable,
> PPSMC_MSG_SetMemoryChannelEnable),
>  	MSG_MAP(DFCstateControl,
> PPSMC_MSG_DFCstateControl),
> +	MSG_MAP(ReadSerialNumTop32,
> PPSMC_MSG_ReadSerialNumTop32),
> +	MSG_MAP(ReadSerialNumBottom32,
> PPSMC_MSG_ReadSerialNumBottom32),
>  };
> 
>  static struct smu_11_0_cmn2aisc_mapping
> arcturus_clk_map[SMU_CLK_COUNT] = { diff --git
> a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
> b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
> index f736d773f9d6..b426be7c76c6 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
> @@ -116,6 +116,9 @@
>  #define PPSMC_MSG_DFCstateControl		 0x3B
>  #define PPSMC_Message_Count			 0x3C
> 
> +#define PPSMC_MSG_ReadSerialNumTop32		 0x49
> +#define PPSMC_MSG_ReadSerialNumBottom32		 0x4A
> +
>  typedef uint32_t PPSMC_Result;
>  typedef uint32_t PPSMC_Msg;
>  #pragma pack(pop)
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
