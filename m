Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4F2C2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 07:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226CB206A1
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 07:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WKJa7hxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226CB206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD6A6E192;
	Mon, 13 Apr 2020 07:03:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C23B46E192
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 07:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCAZAQT6CvWOmL0zsMX28tvURvm7Oo4T8g9RYu9vUbTQmns8MojxnoQpTMXiuAHjIbz4AhRtErCAkKGCR/6o9r/GXRBtQItu5/qa9Bk7dLvGsfQlkq4qPiXFhZZALDVKVchkuZk4d4hVr70FCy5GW/oevGeDg5Nssf2d02im/6Mucl7Uo2JDtfs0X1XNlg23UXVK0ABEsaXPTV1A7DFx37Z1pexomQntEjEuyLTPK3KwxomTj7D3hxsaLDvazzZ8qmnphoAKQC3jkotm4XtNYU8SOu2m6T/SeCPUeOMJQrFo+cqrtQ08adtUynhby31YWh5N2h/WWLtMsjBM9LUzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VxR32/q16OddDCbnXq86ain/XdXxOwOgGy6Nn1ukKc=;
 b=QdF/oUWqLdZcfHsHerEoXtW+XP21uV9CVjsE5JehB6PL1ilFO1UfnpXLnLMhn3gbM7ScfEjpy5QTLCgkNuUUm0g7gVaLJyjp9V50L4VPcAZNf/yOKN9JpzTdY55ejmawOp3ongJ76s52CYN9sAMFeap6yCPSRRcFr1XiSHqxjSiDtR67ebg8dq8GICsW69V1psj+w7YTacfjFKdiQTNGDBlWdjLPvpkDhh9tJWy81kep0ig/y3ZeuwMeosNphT9rBHcS3wf5cbhR+rETQo1Tuu8SOQuTvKoZNpkHUScTXTM3BJ4SOdtNReQ51AU9Y8ulai7m24B//PlkpLRAwsxjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VxR32/q16OddDCbnXq86ain/XdXxOwOgGy6Nn1ukKc=;
 b=WKJa7hxdrdzHLcaDT59kpR9zArCyQSPeLBknBnWx1Eothdf5jzyoSL+bmKJMpmCz8IXX6hqPYFpO+QpLKC14ruf+thEplfOrWRP0oXI3f/ZM2Laz0IDaf0a78Wh+CJTfCx+dPwlAeSS0BgWbmm1pxIUrXTA457ZlRcnKIy6uUa4=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1545.namprd12.prod.outlook.com (2603:10b6:4:7::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Mon, 13 Apr 2020 07:03:22 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd%8]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 07:03:22 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Tao, Yintian" <Yintian.Tao@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resume kiq access debugfs
Thread-Topic: [PATCH] drm/amdgpu: resume kiq access debugfs
Thread-Index: AQHWEWDv03mfGIKsYkuxKEtfZF7yHqh2oGRw
Date: Mon, 13 Apr 2020 07:03:22 +0000
Message-ID: <DM5PR12MB170828B901C4CD0354E67F7784DD0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200413065821.7409-1-yttao@amd.com>
In-Reply-To: <20200413065821.7409-1-yttao@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1f9fa9f-62fe-4cc2-a8ce-08d7df78c15a
x-ms-traffictypediagnostic: DM5PR12MB1545:|DM5PR12MB1545:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB154599BEE2274637E60535D884DD0@DM5PR12MB1545.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(76116006)(9686003)(8936002)(66946007)(52536014)(66556008)(71200400001)(64756008)(66476007)(66446008)(2906002)(81156014)(26005)(8676002)(54906003)(6636002)(186003)(6506007)(33656002)(4326008)(55016002)(53546011)(86362001)(5660300002)(7696005)(478600001)(6862004)(316002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SPlkXL8suf7z7/O8ieukDcnJpCyPNVzzd5DAm3v1eiPt5Z0USH8imBAj1E7/drtkaqCryC/Is5FhUh7B3PS45pYDtB9RYz8rAEOGwTZZYzeMKksY/qHn3sWc886/wxtmIkOYJ7T3YrggWtksD/H6xp2cyJT5zn1jo58cMvUUUpyMgICPmi/zBX6cACLMk0R96zvv3cIVXt8LmKL12PDKI+eLkz+PMrIWUhx7f0uQwXE5EX11XpfMIUNQpxvKQcKbCohXKrdHIGu2oCdAcjQvvLXRmVq+NRgfpXqRvp506U8C9NosBPdnM60yk5iW3YYrBEZxyJElIHRpR8OWeZNE6AGLHUDQb2xMeakjTh1yOY1auE5kL6trUN/iyEKkB5yT8BQ8lpEVbB81DRC5XS5rXUDrXsDo1laMdi7CMaF+md7tzQ00stYAr1d3TK6ZyLYe
x-ms-exchange-antispam-messagedata: YygDyawSgV7aYfezGXhs3gOjZpxGKGxIGcDIFh53PSrc1zA9HSiuGlIPWyIqAM7b+pApLaNibYg96Xsee5HxXhy18bw8WD4YP6EWFaL89awbI4dtZpzrgJEYtlbDtJ75iwcR9+NA8WCbgcAzT8034g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f9fa9f-62fe-4cc2-a8ce-08d7df78c15a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 07:03:22.7988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Xs/Ax5RgX5hNhWKwP1BgNM6Xz63U62jdEiso4Yq8guTeAuClMBm0pt1htelE0qP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1545
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
Cc: "Tao, Yintian" <Yintian.Tao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

@@ -152,11 +152,17 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	if (r < 0)
 		return r;
 
+	if (!amdgpu_virt_can_access_debugfs(adev))
+		return -EINVAL;
+	else
+		amdgpu_virt_enable_access_debugfs(adev);
 
Looks your patch didn't change above logic ///

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Yintian Tao <yttao@amd.com> 
Sent: Monday, April 13, 2020 2:58 PM
To: Liu, Monk <Monk.Liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Tao, Yintian <Yintian.Tao@amd.com>
Subject: [PATCH] drm/amdgpu: resume kiq access debugfs

If there is no GPU hang, user still can access debugfs through kiq.

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 +++++++++---  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 6a81c2ee7c7b..8c10084f44ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -335,17 +335,23 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 	}
 }
 
-bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev)
+bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev)
 {
 	return amdgpu_sriov_is_debug(adev) ? true : false;  }
 
+bool amdgpu_virt_access_debugfs_is_kiq(struct amdgpu_device *adev) {
+	return amdgpu_sriov_is_normal(adev) ? true : false; }
+
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev)  {
-	if (!amdgpu_sriov_vf(adev))
+	if (!amdgpu_sriov_vf(adev) ||
+	    amdgpu_virt_access_debugfs_is_kiq(adev))
 		return 0;
 
-	if (amdgpu_virt_can_access_debugfs(adev))
+	if (amdgpu_virt_access_debugfs_is_mmio(adev))
 		adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
 	else
 		return -EPERM;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 8f20e6dbd7a9..de27308802c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -299,6 +299,8 @@ static inline bool is_virtual_machine(void)
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_PP_ONE_VF)  #define amdgpu_sriov_is_debug(adev) \
 	((!adev->in_gpu_reset) && adev->virt.tdr_debug)
+#define amdgpu_sriov_is_normal(adev) \
+	((!adev->in_gpu_reset) && (!adev->virt.tdr_debug))
 
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);  void amdgpu_virt_init_setting(struct amdgpu_device *adev);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
