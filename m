Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF8EC10DCE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 01:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE4A21655
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 01:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hej/4eSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE4A21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6180E6E91D;
	Wed, 11 Mar 2020 01:57:41 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750052.outbound.protection.outlook.com [40.107.75.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E66A6E903
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 01:57:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0jvIAYhtsbKKt2ohHHFBJp855NvKWdPqp3R7SoRHbObfNqp2Nr0fOfnl00BOSVwPDgiLwj0/LPdTGw0zrQYR5YN4fFuPAK982ZeHTmGvGEYTZ4Xn/Xa2VB1b25Dqx9BJtVWenPfkSJAxQR+e9QYmieEW91i4Uce2AEpn3RjCKLJ24aPil6zYmM1GSPGXqk83zDMTkOaCJ6O3l78ojgD7qpM1oxWLdjY9gtRTz0ZAjCUVFaIlKJYxc87PsoU5NgQxYuCWsKAXs6My6ZJX05bI7pHSOL1/9xTN+r5vWzEgMXtfQxv2+dXGo7vIWQosbYdwWwVyGLCND4sWWqRS6eCNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+ewYYevIH7er5JTDh1nDKLrlOct94pTZ1gBHXtdl2g=;
 b=UyWYxU5NNcVxf3k7r9GkaFkmoL4Otx1Zj/rVKLY6S5Ec+RCeilNAqS2vxwmlIlag5YBv89ce3ojoiSqj8yjfaQf/48eogijOWZ1F9V/t0mFmmdsD8LB+P7Dvz29KO3jl7A8BapIGMQMtR9aBsBDWVV5sVD+vf8wMfMowtMSyNWPr80tDXoybw9w2eFoJwOVq+l/1O6ebZzCyrPHtpvPr9wiqaWIOzAeH4InmlTLDr5S4hPw+gWX/8npaZY6QBZLKZWwHXRAV1t5UsNlD6w8y4RmrxjvZJeFJHouT2s1B7mC34N3SOhr42Ej4JSYLByxhk5y04APrE7T+1ZzkvuYPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+ewYYevIH7er5JTDh1nDKLrlOct94pTZ1gBHXtdl2g=;
 b=hej/4eSvXGnKxyiEZxO/zOpBFb7td5Mxm77d72z6Ovw/n6IJQ5wTgxFIsBthqse2/8ry3kx4f9UGCq0YXgD9i1nccr5v8IPEWOk/ha5qr/4Vp1O6Dqqbi6nLCA5/0ui1ZTN+8oM9qwZ3yzyzg6hvctkJw5mY6YW5FzQKF5RgQ50=
Received: from MWHPR12MB1837.namprd12.prod.outlook.com (2603:10b6:300:113::20)
 by MWHPR12MB1440.namprd12.prod.outlook.com (2603:10b6:300:13::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Wed, 11 Mar
 2020 01:57:37 +0000
Received: from MWHPR12MB1837.namprd12.prod.outlook.com
 ([fe80::84e2:7919:afcd:a928]) by MWHPR12MB1837.namprd12.prod.outlook.com
 ([fe80::84e2:7919:afcd:a928%10]) with mapi id 15.20.2793.013; Wed, 11 Mar
 2020 01:57:37 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: call ras_debugfs_create_all in
 debugfs_init
Thread-Topic: [PATCH 2/2] drm/amdgpu: call ras_debugfs_create_all in
 debugfs_init
Thread-Index: AQHV9fLb8JFQcYG0UkqUMNARmDeDM6hB0kAAgADR5QA=
Date: Wed, 11 Mar 2020 01:57:37 +0000
Message-ID: <MWHPR12MB18371D0BA20BC380AFAA36C79AFC0@MWHPR12MB1837.namprd12.prod.outlook.com>
References: <20200309091215.26768-1-Stanley.Yang@amd.com>
 <20200309091215.26768-2-Stanley.Yang@amd.com>
 <CADnq5_O9BV09fYr16fiRPWCrcCoUVkrXF6fdKdU9AkL6uz8Bjg@mail.gmail.com>
In-Reply-To: <CADnq5_O9BV09fYr16fiRPWCrcCoUVkrXF6fdKdU9AkL6uz8Bjg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-11T01:57:34Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6c2d1c73-469e-432c-bd4b-000006b51e28;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-11T01:57:34Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e9fe3d98-3a97-41df-a916-0000d553c0ef
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanley.Yang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3fe41496-87d6-431f-639b-08d7c55f9303
x-ms-traffictypediagnostic: MWHPR12MB1440:|MWHPR12MB1440:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB14406D7ECB3BB3179DA5ABDB9AFC0@MWHPR12MB1440.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:121;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(199004)(55016002)(966005)(26005)(52536014)(186003)(66446008)(66556008)(81166006)(478600001)(45080400002)(5660300002)(66946007)(8936002)(66476007)(76116006)(64756008)(9686003)(81156014)(71200400001)(8676002)(7696005)(316002)(2906002)(4326008)(86362001)(6506007)(53546011)(54906003)(6916009)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1440;
 H:MWHPR12MB1837.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p0bTMzdJ0bUz0zowwwVVG7Dkgj+YU1wEQwWfuopQpErvq8WVJpzEK033f+wm4Vf+1L5q4DIbGmAMppADrt/uhvlMxFRKoY5IKPMQGBmjrfObU2zqs2TwrUICB90c0aaAlJIQegqoRxOhx2aKeccNpipHQjc1lrcINlVNXZDqiatJQxpscYxb7FqKc2S8KJXlEkH4/aHdxNbSvdjzDBF6KyeTXOUp8aJfZ8g69sBZsOFmpmPn431052ncxMskRhbjX7JuDjb5REoUKc4xdyDFaFqGgsCkaBcW4SK2mCJmJeOd44q6/JAcrkusna49/bGGFpN595ePmvyQiaNkPWdUd0jHL0xDUuHPojUkQRZfLX/+87Bw1eYyB9xxQuSPqhCmIz8+TBaJs6fTBjb/rI5PyzWjun16I+WSevT+jaCSAitMX9UlcNrGJAhZ4iWJUHA4vVHWzLLn1/L+WLr26+swQzi54KqWb43/Vqf25Z5WNV4CBwAIRRxG8WBuNZKJ3jqVwyKKJLpivwxD+xXQ8h63JdvIh7OSwJUJYbjvkgc0T8i3hI9CcF/OJitMvFVQS6DoL5NwigyiOpZdd5CmS/XeN0ErCYEUE08MIgG7j+tDGl/ChpDA5bQhP6SaN04e18Sz
x-ms-exchange-antispam-messagedata: C3/UwyAz9a3d2hff/3ISiBWFQ7dUfXNELN4zxps0tvB1C2gYIF8zGgF3R2UcS8O15U0uP93VS4lgVLWrNt7Mb4m8pR3sPn8kFHqUE6yHP19ot4/l5APk6v9GD8E1UwbX6dD3sD5jgIANLrw2Ul2t8A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe41496-87d6-431f-639b-08d7c55f9303
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 01:57:37.2663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6tpiFg/ndhGhhe4sO2ueaBB9Is0+84Uv/ExxQvxcAaMSlHn3PjspoHCgpb3lVUS0WRdwz30E1PqCtn9hgnmvpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1440
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Clements,
 John" <John.Clements@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,

I will send another patch to make this change, because this patch is been pushed to branch.

Regards,
Stanley

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Tuesday, March 10, 2020 9:23 PM
To: Yang, Stanley <Stanley.Yang@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Chen, Guchun <Guchun.Chen@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: call ras_debugfs_create_all in debugfs_init

On Mon, Mar 9, 2020 at 5:12 AM Stanley.Yang <Stanley.Yang@amd.com> wrote:
>
> From: Tao Zhou <tao.zhou1@amd.com>
>
> and remove each ras IP's own debugfs creation
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> Change-Id: If3d16862afa0d97abad183dd6e60478b34029e95
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c   | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c    | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c     | 5 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c     | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c    | 1 -
>  8 files changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index deca6343d0cc..1d513e4f9934 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1315,6 +1315,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,  
> DEFINE_SIMPLE_ATTRIBUTE(fops_sclk_set, NULL,
>                         amdgpu_debugfs_sclk_set, "%llu\n");
>
> +extern void amdgpu_ras_debugfs_create_all(struct amdgpu_device 
> +*adev);

Can we put this in amdgpu_ras.h and include that instead?


>  int amdgpu_debugfs_init(struct amdgpu_device *adev)  {
>         int r, i;
> @@ -1387,6 +1388,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>                 }
>         }
>
> +       amdgpu_ras_debugfs_create_all(adev);
> +
>         return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
>                                         
> ARRAY_SIZE(amdgpu_debugfs_list));  } diff --git 
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 7403588684b3..d12bb4a35780 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -565,7 +565,6 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev)
>         int r;
>         struct ras_fs_if fs_info = {
>                 .sysfs_name = "gfx_err_count",
> -               .debugfs_name = "gfx_err_inject",
>         };
>         struct ras_ih_if ih_info = {
>                 .cb = amdgpu_gfx_process_ras_data_cb, diff --git 
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> index 676c48c02d77..ead3dc572ec5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> @@ -32,7 +32,6 @@ int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev)
>         };
>         struct ras_fs_if fs_info = {
>                 .sysfs_name = "mmhub_err_count",
> -               .debugfs_name = "mmhub_err_inject",
>         };
>
>         if (!adev->mmhub.ras_if) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> index 7d5c3a9de9ea..6201a5f4b4fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> @@ -30,7 +30,6 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev)
>         };
>         struct ras_fs_if fs_info = {
>                 .sysfs_name = "pcie_bif_err_count",
> -               .debugfs_name = "pcie_bif_err_inject",
>         };
>
>         if (!adev->nbio.ras_if) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 422cdd1ce3ad..57af4ea8fb58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1178,7 +1178,6 @@ static void amdgpu_ras_debugfs_remove_all(struct 
> amdgpu_device *adev)  static int amdgpu_ras_fs_init(struct 
> amdgpu_device *adev)  {
>         amdgpu_ras_sysfs_create_feature_node(adev);
> -       amdgpu_ras_debugfs_create_ctrl_node(adev);
>
>         return 0;
>  }
> @@ -1882,8 +1881,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
>                         goto interrupt;
>         }
>
> -       amdgpu_ras_debugfs_create(adev, fs_info);
> -
>         r = amdgpu_ras_sysfs_create(adev, fs_info);
>         if (r)
>                 goto sysfs;
> @@ -1892,7 +1889,6 @@ int amdgpu_ras_late_init(struct amdgpu_device 
> *adev,
>  cleanup:
>         amdgpu_ras_sysfs_remove(adev, ras_block);
>  sysfs:
> -       amdgpu_ras_debugfs_remove(adev, ras_block);
>         if (ih_info->cb)
>                 amdgpu_ras_interrupt_remove_handler(adev, ih_info);
>  interrupt:
> @@ -1909,7 +1905,6 @@ void amdgpu_ras_late_fini(struct amdgpu_device *adev,
>                 return;
>
>         amdgpu_ras_sysfs_remove(adev, ras_block);
> -       amdgpu_ras_debugfs_remove(adev, ras_block);
>         if (ih_info->cb)
>                  amdgpu_ras_interrupt_remove_handler(adev, ih_info);
>         amdgpu_ras_feature_enable(adev, ras_block, 0); diff --git 
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 7854c053e85d..250a309e4dee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -93,7 +93,6 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
>         struct ras_ih_if *ih_info = (struct ras_ih_if *)ras_ih_info;
>         struct ras_fs_if fs_info = {
>                 .sysfs_name = "sdma_err_count",
> -               .debugfs_name = "sdma_err_inject",
>         };
>
>         if (!ih_info)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index f4d40855147b..9dd51f0d2c11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -28,7 +28,6 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev)
>         int r;
>         struct ras_fs_if fs_info = {
>                 .sysfs_name = "umc_err_count",
> -               .debugfs_name = "umc_err_inject",
>         };
>         struct ras_ih_if ih_info = {
>                 .cb = amdgpu_umc_process_ras_data_cb, diff --git 
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index a54ce398ed77..0837f872741b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -598,7 +598,6 @@ int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev)
>         };
>         struct ras_fs_if fs_info = {
>                 .sysfs_name = "xgmi_wafl_err_count",
> -               .debugfs_name = "xgmi_wafl_err_inject",
>         };
>
>         if (!adev->gmc.xgmi.supported ||
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CSt
> anley.Yang%40amd.com%7C7bcd4010164046f818d408d7c4f63e27%7C3dd8961fe488
> 4e608e11a82d994e183d%7C0%7C0%7C637194434220278715&amp;sdata=GSrYIyxHb6
> qQtGi1E%2BSkgF6q8nyC6uSKgO%2BWE7cxGm8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
