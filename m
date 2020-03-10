Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3611FC10DCE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 06:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E960E2464B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 06:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DtYu12kq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E960E2464B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E6386E7D9;
	Tue, 10 Mar 2020 06:33:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE6E16E7D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 06:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QS9QQVqoL8fhSDir9fidbdoWmomGSjyjSaAtaeIfK+4QS2HAYwts9Vd5ziKNu7zhPT3cOh3Sh59G4GRmD107GDZn7HZz/xk4lGeVlUPRTAjyqthpRyauON/3FfAqnEdkqZAEi/+LnUsg0u97mE74LofEi3dykAXmcd/wjF+VPuW2K6KS+AGXuMIX6BwsjLFr8NN4atiuJLWsbFK69/ZHgBKcn5Ci51vfzVbXmQ26GeQrZWVvBHMj0lkSi4oJcS7/pGAotfS7PTS2/axIIT6VgQIMINfDtQ79sf0ZCgST0pmkBUiu9r98m4gPN3ZaxWF0r1O1ECnS1m8loFAn5Xr+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml4E2YCHwojeWj4RMcCEpROOLKSOvK0CXDuNmPt4qaQ=;
 b=nXpAoV/iRAwG75y0EMC27y9hQQkr2kBGxNiWPvBT2/BsCUURQQ5WYm1s7w8F4LjZZHyq70oSu/nUYewuwkoftD99ad9HktzJJH10E9+iXKMdYnnqE/aSNaRdRbGWl6FeexKFjeFWxVQ/fMCsKgtfosIDorCudPMBB41HN1jHDQZACTT69a2Ip4jj5fkFafkMHaJHdiUYcx71d7bhI/iUhcuTZBbF5Km8jhFjd7byWiuChX7M6q7TTPz+bb8RYj7TGYSA9ve9sX1jbb2OqzigiF4/Wk3vQQoHJokV0pFN0Abqp+r3gEGC7RocaQhRQMlfthuQMssQ9M38veXvhuzsmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml4E2YCHwojeWj4RMcCEpROOLKSOvK0CXDuNmPt4qaQ=;
 b=DtYu12kqLCiBdik7V39ZAk1+mKIyuTksm+D1EYxNOr2GRaxloM1+0N5INE198pCNtCE5ZQ6q6taSwEaE3tRfJxSB/wkllbple2IGVeGdaZFocsfz3dTGQOlod+anngq1N1UlusCjeo/epw9oFjObBJaeg2mdIClT4Bb1Dd1UuBE=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20)
 by BYAPR12MB3016.namprd12.prod.outlook.com (2603:10b6:a03:dc::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 06:33:46 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f%7]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 06:33:46 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: call ras_debugfs_create_all in
 debugfs_init
Thread-Topic: [PATCH 2/2] drm/amdgpu: call ras_debugfs_create_all in
 debugfs_init
Thread-Index: AQHV9fLbdxIrSy7yekesnjnJnnBtcag/+7fwgAAPswCAAVQyYA==
Date: Tue, 10 Mar 2020 06:33:46 +0000
Message-ID: <BYAPR12MB2806520C4DEF5CFF856D8255F1FF0@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <20200309091215.26768-1-Stanley.Yang@amd.com>
 <20200309091215.26768-2-Stanley.Yang@amd.com>
 <BYAPR12MB2806E9C6F7B8E2BEFF19B4F5F1FE0@BYAPR12MB2806.namprd12.prod.outlook.com>
 <MN2PR12MB305435876A1E6A162B974006B0FE0@MN2PR12MB3054.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB305435876A1E6A162B974006B0FE0@MN2PR12MB3054.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-09T09:19:20Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=14dd4b30-9321-4a3b-bfcb-00003ac7d245;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-03-10T06:33:45Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 60141b25-5629-4b78-926a-0000b30bfcf8
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [101.224.57.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2df4f82-c1d1-428f-90c7-08d7c4bcfca9
x-ms-traffictypediagnostic: BYAPR12MB3016:|BYAPR12MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3016A1F29C1F3CC34A85B665F1FF0@BYAPR12MB3016.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(4326008)(66946007)(186003)(86362001)(76116006)(71200400001)(110136005)(66556008)(66446008)(55016002)(66476007)(54906003)(64756008)(9686003)(498600001)(6506007)(7696005)(8676002)(8936002)(26005)(52536014)(33656002)(81166006)(81156014)(53546011)(5660300002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3016;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dveRNd+RCxQwb1ByF50YNmZEeCPxXIqrxl0AgSOM6ggQi1xIlQLFR6YPXeL9d8MTYY3LEshsSl92h9uenRu7C+YThk9A7JYThzNS2v8IZNEw03O9ten4hdlaNj8n9hLX1M9p9s1gu3VN6ep2S3zP8Yd1vL8950CLRQUWCMx6tl5cKGR7QCCCwIRSvI0eZPxrojU1vcBa7naQJc3G5jZM2ejjXqagOVsL5yXiMv9rpdB5m7WrpvPKyhv1BnyRrweI8Tw0vVeJTThTeGDOXAFTN+e4hJvJCq89RA/dCfLnMSe1nR7QsbyUGWD/8vzRwaeV6PoZLM1SSHoZMaU5CjxlUojYmsoMFvJb22HzztoV8H+T+K7ISfJF/BvmbHeqEroUBh6kz557Di4xYLb/tD787E2GwTg5CvjzYD3Eql9YpVo+tK0Wf1Gz9OU+L2CGrm+n
x-ms-exchange-antispam-messagedata: 2VUmYz9zJd/TAZhQCG+5wt397cMuyZ6XAXBG0XA1y7sYE74UhszdO9Dy/+NXIse0HKH1OBNgBO/NW1qw0Q7FurIMc/bRLfmVDFkXJ+mJNM3gTR6GPtLBNWxQ1uuuuKHcyRqe2545DA0X8DEYwCqhvw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2df4f82-c1d1-428f-90c7-08d7c4bcfca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 06:33:46.6072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DhJa6J/wG0n8yOpiLfyzQviRciZwmmImKlujqJjcd3FNgdQp+Ixppe3uAyDfscLKN0CI4N4XeKRGeO3uoxQW8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3016
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
Cc: "Yang,
 Stanley" <Stanley.Yang@amd.com>, "Clements, John" <John.Clements@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

That's fine. These two patches are:

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com> 
Sent: Monday, March 9, 2020 6:15 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: call ras_debugfs_create_all in debugfs_init

[AMD Public Use]

We already have amdgpu_ras_debugfs_remove and amdgpu_ras_debugfs_remove_all.
In fact, amdgpu_debugfs_fini has been dropped in the patch below, and we are also planning to delete amdgpu_ras_debugfs_remove and amdgpu_ras_debugfs_remove_all.

drm/amdgpu: no need to clean debugfs at amdgpu

drm_minor_unregister will invoke drm_debugfs_cleanup to clean all the child node under primary minor node.
We don't need to invoke amdgpu_debugfs_fini and amdgpu_debugfs_regs_cleanup to clean agian.
Otherwise, it will raise the NULL pointer like below.

v2: remove all debugfs cleanup/fini code at amdgpu

Signed-off-by: Yintian Tao <yttao@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Regards,
Tao

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: 2020年3月9日 17:21
> To: Yang, Stanley <Stanley.Yang@amd.com>; 
> amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis 
> <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; Zhou1, 
> Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH 2/2] drm/amdgpu: call ras_debugfs_create_all in 
> debugfs_init
> 
> [AMD Public Use]
> 
> Shall we need other codes to remove ras debugfs in debugfs_fini to 
> avoid leak?
> 
> Regards,
> Guchun
> 
> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Monday, March 9, 2020 5:12 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun 
> <Guchun.Chen@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John 
> <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley 
> <Stanley.Yang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: call ras_debugfs_create_all in 
> debugfs_init
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
> @@ -1315,6 +1315,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt,
> NULL,  DEFINE_SIMPLE_ATTRIBUTE(fops_sclk_set, NULL,
>  			amdgpu_debugfs_sclk_set, "%llu\n");
> 
> +extern void amdgpu_ras_debugfs_create_all(struct amdgpu_device 
> +*adev);
>  int amdgpu_debugfs_init(struct amdgpu_device *adev)  {
>  	int r, i;
> @@ -1387,6 +1388,8 @@ int amdgpu_debugfs_init(struct amdgpu_device
> *adev)
>  		}
>  	}
> 
> +	amdgpu_ras_debugfs_create_all(adev);
> +
>  	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
>  					ARRAY_SIZE(amdgpu_debugfs_list));  } diff --git 
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 7403588684b3..d12bb4a35780 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -565,7 +565,6 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device
> *adev)
>  	int r;
>  	struct ras_fs_if fs_info = {
>  		.sysfs_name = "gfx_err_count",
> -		.debugfs_name = "gfx_err_inject",
>  	};
>  	struct ras_ih_if ih_info = {
>  		.cb = amdgpu_gfx_process_ras_data_cb, diff --git 
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> index 676c48c02d77..ead3dc572ec5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> @@ -32,7 +32,6 @@ int amdgpu_mmhub_ras_late_init(struct amdgpu_device 
> *adev)
>  	};
>  	struct ras_fs_if fs_info = {
>  		.sysfs_name = "mmhub_err_count",
> -		.debugfs_name = "mmhub_err_inject",
>  	};
> 
>  	if (!adev->mmhub.ras_if) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> index 7d5c3a9de9ea..6201a5f4b4fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> @@ -30,7 +30,6 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device
> *adev)
>  	};
>  	struct ras_fs_if fs_info = {
>  		.sysfs_name = "pcie_bif_err_count",
> -		.debugfs_name = "pcie_bif_err_inject",
>  	};
> 
>  	if (!adev->nbio.ras_if) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 422cdd1ce3ad..57af4ea8fb58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1178,7 +1178,6 @@ static void
> amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)  static int 
> amdgpu_ras_fs_init(struct amdgpu_device *adev)  {
>  	amdgpu_ras_sysfs_create_feature_node(adev);
> -	amdgpu_ras_debugfs_create_ctrl_node(adev);
> 
>  	return 0;
>  }
> @@ -1882,8 +1881,6 @@ int amdgpu_ras_late_init(struct amdgpu_device 
> *adev,
>  			goto interrupt;
>  	}
> 
> -	amdgpu_ras_debugfs_create(adev, fs_info);
> -
>  	r = amdgpu_ras_sysfs_create(adev, fs_info);
>  	if (r)
>  		goto sysfs;
> @@ -1892,7 +1889,6 @@ int amdgpu_ras_late_init(struct amdgpu_device 
> *adev,
>  cleanup:
>  	amdgpu_ras_sysfs_remove(adev, ras_block);
>  sysfs:
> -	amdgpu_ras_debugfs_remove(adev, ras_block);
>  	if (ih_info->cb)
>  		amdgpu_ras_interrupt_remove_handler(adev, ih_info);
>  interrupt:
> @@ -1909,7 +1905,6 @@ void amdgpu_ras_late_fini(struct amdgpu_device 
> *adev,
>  		return;
> 
>  	amdgpu_ras_sysfs_remove(adev, ras_block);
> -	amdgpu_ras_debugfs_remove(adev, ras_block);
>  	if (ih_info->cb)
>                  amdgpu_ras_interrupt_remove_handler(adev, ih_info);
>  	amdgpu_ras_feature_enable(adev, ras_block, 0); diff --git 
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 7854c053e85d..250a309e4dee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -93,7 +93,6 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device 
> *adev,
>  	struct ras_ih_if *ih_info = (struct ras_ih_if *)ras_ih_info;
>  	struct ras_fs_if fs_info = {
>  		.sysfs_name = "sdma_err_count",
> -		.debugfs_name = "sdma_err_inject",
>  	};
> 
>  	if (!ih_info)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index f4d40855147b..9dd51f0d2c11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -28,7 +28,6 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device
> *adev)
>  	int r;
>  	struct ras_fs_if fs_info = {
>  		.sysfs_name = "umc_err_count",
> -		.debugfs_name = "umc_err_inject",
>  	};
>  	struct ras_ih_if ih_info = {
>  		.cb = amdgpu_umc_process_ras_data_cb, diff --git 
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index a54ce398ed77..0837f872741b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -598,7 +598,6 @@ int amdgpu_xgmi_ras_late_init(struct amdgpu_device 
> *adev)
>  	};
>  	struct ras_fs_if fs_info = {
>  		.sysfs_name = "xgmi_wafl_err_count",
> -		.debugfs_name = "xgmi_wafl_err_inject",
>  	};
> 
>  	if (!adev->gmc.xgmi.supported ||
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
