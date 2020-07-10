Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F14C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 06:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033432076A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 06:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ALm+3QRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033432076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984406EB6F;
	Fri, 10 Jul 2020 06:50:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 067906EB6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 06:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1DO1VIVUnmZqYwZR+FFuCLbdsJZypAZaXjy6L+FpJmvhgwH4kKo4jQSEo+axt/ORKp0SxcCOFvxuCMsJGXv1sr6CwxuMgHQCZyFVDOgHvVa/jPf0o0dJ+k2mDfLZ1XDyYC3Jn4ASGeLJXNtBeYRoziVxjX1u1ZAAjGPRHjzybJeLvtFYzAUacdNFCgmLxzj4O8C5VFnsrvHIlk2dhcY0JAkNPdTW9cvvsE5M6T+8mmAH/uhT7A/DyPegSWZcwRv0LZNDrSyLIIoJGgK4z1oNKpDqL+oNCG2akl2ud1YU+yt3TAsnFzEq8M8dsZ0RhPfdvq45ylXHrDMmnq60RMmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0WkxIwLud96W259pUdhWDFCohXH5/KwGJxUTWWgwBc=;
 b=If4wzbeo+/yvfXYHDq4p5b2kqcUPURt1k93EHMTXkkchizhtc0UCb3DVKrh5R5ShmsAt5Qmz6IHObkFzL2J854OD5UbIeyZXh3f413WEszBv0xopqhFkgpO5YL1/TVaq4z0esDEvqpLbnF1GPhnuPJc5pxJGViJpGKtiwN/+9SkK2FPnbNX2lnfFcEVJK97n7JcFf6JaX4TSeWr1V9cwRZuU02gtxmMnRQ1uWUeYkkou7Nzyq4mXR58cI/ph6C7B4zLYKf7JbLLoquGn6pE5UUlnZBuHELXQesIzz/RBgSkWXZgK6dcYqJQlLgCiyDgLIT0XFNPh3oaDTqgv7QODHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0WkxIwLud96W259pUdhWDFCohXH5/KwGJxUTWWgwBc=;
 b=ALm+3QRCv7ZDIgf+SC5TDXkxZ82GXpClc4oDLbzDUVz0ac6tHpTcWm+P7IBBEAfZIEr5X2s5kqhaAXH5ecnImg1tS9moVTBMU7lGNz4XFewYoOuexldMOeNZcovkysQ4NbBpENP0Ht+SZXmJUF/TrciLFZbnd0nv6TCueUlHDPk=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Fri, 10 Jul 2020 06:50:34 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%6]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 06:50:34 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Sheng, Wenhui"
 <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/4] drm/amd/powerplay: add SMU mode1 reset
Thread-Topic: [PATCH 1/4] drm/amd/powerplay: add SMU mode1 reset
Thread-Index: AQHWVn1770d7EliVgkSGxS2qdStqHqkAXIeQgAACzNA=
Date: Fri, 10 Jul 2020 06:50:34 +0000
Message-ID: <DM6PR12MB4075B9E30339BCFA5A4E57C5FC650@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200710054626.2487-1-Wenhui.Sheng@amd.com>
 <DM6PR12MB4075F988DB1E7B8592CD2CCEFC650@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075F988DB1E7B8592CD2CCEFC650@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-10T06:41:14Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=9bfb29e5-d0d4-41a9-a763-0000b6f3d607;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-10T06:50:31Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 62e9c53c-357e-4b62-a444-00000da57071
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0d0fc15-111e-4c23-7d33-08d8249d8ba5
x-ms-traffictypediagnostic: DM6PR12MB4092:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4092C3B209BB7D3DF9231E1BFC650@DM6PR12MB4092.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A6yE/Pnv0idB7l/9b4TWZqH26M6M+IYyxzLY6XQoQ+0geI7pcoSD/r8dEtzcOX5hYCTWVPMtxOqGbfWBnKNUCEA9lTsGAmZspk+5/KffyxWuLCCC93Z7V9OenWXe6oTueWiR+YRJmQKnFSDeovCmegA50SXK+L5ixF1oiPSx27630rB//CV/wLJ5l+YBtRCN42sg3yXb1ZC1E8IVonS3rviquaWBvWmIpsDk+Upyt98EwQQlmqbFSs/DQo8I3g60qPSH8cpXZ58ynCSESZ91hhmjgjldfmkJnpzUURPbLZcj4JwU16j16UTVDD9uDvGpmwU5nsUI+eicpL+4zzw8WhLkbcM3aiRdRuAaWWw+ENk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(4326008)(8936002)(8676002)(9686003)(55016002)(2906002)(5660300002)(71200400001)(33656002)(83380400001)(52536014)(110136005)(316002)(2940100002)(76116006)(966005)(45080400002)(478600001)(86362001)(186003)(26005)(66476007)(66946007)(66446008)(64756008)(66556008)(7696005)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: W4uaFdPI+r+d9OHgrUI7H0JWGVmhKz7dndqVQYsYrf9ylEcNsgDgnK8a48Mh78T8uhCML4lSu0AN/rGjwgcNyoQqtlLJ8PDiQ/Adl7jKUIugeqZJLAQHLX0mSRV3xFc/TNm3im3XVue6Qri8aBauVhLcO0etFW12frHmB46mgZwVry+xPXSfdmwnz4XTLW6DH6GdG12/ht9Qk4SD0CXgLcKJkwPvtQB6hBQFARYGM/I0UvYZP+FMye85fUQAujNSgT4tFazEJ2vN1C4HBa9iaeJqFMXqdeYmd+F1NZq1icwY3Zl5wkPIcKsiy8LJThhDl9EcngHl/Fi7aI7P/ZIU5859t1VvLo6gCmuX+4utZx8dvNbVbuuMjDgcJSTR0LmVv73ANttpE6EdcHTDd5oTAGtfKGZOQq0kEABxYOKenS7dnlJN4cBNUOzqxKzfXFRrvEhzRUNC4cpj0Lq/FuAMoys70k8ZmZEUgVMw/+vlCuHkR6vJQEmjZXTSDfhRe+Xi
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d0fc15-111e-4c23-7d33-08d8249d8ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 06:50:34.2198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3/3Zi8GDRHpvY7E9bCQNI1zQwf1U5NVt+MdmrAz+MSzDYe9r2kkcblIm5K/o289Nv9NQeEEHGvLwxGEVCXRGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

BTW, we'd better make the 500ms setting to be a MACRO. We haven't passed the stress test so might need to extend the waiting in near future.

+	ret = smu_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
+	if (!ret)
+		msleep(500);

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Hawking
Sent: Friday, July 10, 2020 14:41
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>
Subject: RE: [PATCH 1/4] drm/amd/powerplay: add SMU mode1 reset

[AMD Public Use]

We shall consider add smu mode 1 reset interface in amdgpu_dpm.c, where we have amdgpu_dpm_mode2_reset and amdgpu_dpm_baco_reset already.

So totally three interfaces there

amdgpu_dpm_baco_reset
amdgpu_dpm_mode2_reset
amdgpu_dpm_mode1_reset

Does it make sense to you? Thoughts?

Regards,
Hawking

-----Original Message-----
From: Sheng, Wenhui <Wenhui.Sheng@amd.com>
Sent: Friday, July 10, 2020 13:46
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH 1/4] drm/amd/powerplay: add SMU mode1 reset

From PM FW 58.26.0 for sienna cichlid, SMU mode1 reset is support, driver sends PPSMC_MSG_Mode1Reset message to PM FW could trigger this reset.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 37 +++++++++++++++++++
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  4 ++
 drivers/gpu/drm/amd/powerplay/inc/smu_types.h |  1 +  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 +
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 29 ++++++++++++++-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 11 ++++++
 6 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index fe4948aa662f..cae5aa792ac4 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2737,6 +2737,43 @@ int smu_baco_exit(struct smu_context *smu)
 	return ret;
 }
 
+bool smu_mode1_reset_is_support(struct smu_context *smu) {
+	bool ret = false;
+
+	if (!smu->pm_enabled)
+		return false;
+
+	mutex_lock(&smu->mutex);
+
+	if (smu->ppt_funcs && smu->ppt_funcs->mode1_reset_is_support)
+		ret = smu->ppt_funcs->mode1_reset_is_support(smu);
+
+	mutex_unlock(&smu->mutex);
+
+	return ret;
+}
+
+int smu_mode1_reset(struct smu_context *smu) {
+	int ret = 0;
+
+	if (!smu->pm_enabled)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&smu->mutex);
+
+	if (smu->ppt_funcs->mode1_reset)
+		ret = smu->ppt_funcs->mode1_reset(smu);
+
+	mutex_unlock(&smu->mutex);
+
+	if (ret)
+		dev_err(smu->adev->dev, "Mode1 reset failed!\n");
+
+	return ret;
+}
+
 int smu_mode2_reset(struct smu_context *smu)  {
 	int ret = 0;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 7b349e038972..ba59620950d7 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -561,6 +561,8 @@ struct pptable_funcs {
 	int (*baco_set_state)(struct smu_context *smu, enum smu_baco_state state);
 	int (*baco_enter)(struct smu_context *smu);
 	int (*baco_exit)(struct smu_context *smu);
+	bool (*mode1_reset_is_support)(struct smu_context *smu);
+	int (*mode1_reset)(struct smu_context *smu);
 	int (*mode2_reset)(struct smu_context *smu);
 	int (*get_dpm_ultimate_freq)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t *min, uint32_t *max);
 	int (*set_soft_freq_limited_range)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t min, uint32_t max); @@ -672,6 +674,8 @@ int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state);  int smu_baco_enter(struct smu_context *smu);  int smu_baco_exit(struct smu_context *smu);
 
+bool smu_mode1_reset_is_support(struct smu_context *smu); int 
+smu_mode1_reset(struct smu_context *smu);
 int smu_mode2_reset(struct smu_context *smu);
 
 extern int smu_get_atom_data_table(struct smu_context *smu, uint32_t table, diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
index dff2295705be..7b585e205a5a 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
@@ -173,6 +173,7 @@
 	__SMU_DUMMY_MAP(GmiPwrDnControl), \
 	__SMU_DUMMY_MAP(DAL_DISABLE_DUMMY_PSTATE_CHANGE), \
 	__SMU_DUMMY_MAP(DAL_ENABLE_DUMMY_PSTATE_CHANGE), \
+	__SMU_DUMMY_MAP(Mode1Reset), \
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index d07bf4fe6e4a..38599112ae59 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -252,6 +252,8 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)  int smu_v11_0_baco_enter(struct smu_context *smu);  int smu_v11_0_baco_exit(struct smu_context *smu);
 
+int smu_v11_0_mode1_reset(struct smu_context *smu);
+
 int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
 						 uint32_t *min, uint32_t *max);
 
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index dc5ca9121db5..612788bbc6c3 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -39,8 +39,8 @@
 #include "nbio/nbio_2_3_sh_mask.h"
 #include "thm/thm_11_0_2_offset.h"
 #include "thm/thm_11_0_2_sh_mask.h"
-
-#include "asic_reg/mp/mp_11_0_sh_mask.h"
+#include "mp/mp_11_0_offset.h"
+#include "mp/mp_11_0_sh_mask.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -116,6 +116,7 @@ static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_message_map[SMU_MSG_MAX_C
 	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg),
 	MSG_MAP(BacoAudioD3PME,			PPSMC_MSG_BacoAudioD3PME),
 	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3),
+	MSG_MAP(Mode1Reset,			PPSMC_MSG_Mode1Reset),
 };
 
 static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = { @@ -1767,6 +1768,28 @@ static bool sienna_cichlid_is_baco_supported(struct smu_context *smu)
 	return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false;  }
 
+static bool sienna_cichlid_is_mode1_reset_supported(struct smu_context
+*smu) {
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t val;
+	u32 smu_version;
+
+	/**
+	 * SRIOV env will not support SMU mode1 reset
+	 * PM FW support mode1 reset from 58.26
+	 */
+	smu_get_smc_version(smu, NULL, &smu_version);
+	if (amdgpu_sriov_vf(adev) || (smu_version < 0x003a1a00))
+		return false;
+
+	/**
+	 * mode1 reset relies on PSP, so we should check if
+	 * PSP is alive.
+	 */
+	val = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
+	return val != 0x0;
+}
+
 static int sienna_cichlid_set_thermal_range(struct smu_context *smu,
 				       struct smu_temperature_range range)  { @@ -2538,6 +2561,8 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.baco_set_state = smu_v11_0_baco_set_state,
 	.baco_enter = smu_v11_0_baco_enter,
 	.baco_exit = smu_v11_0_baco_exit,
+	.mode1_reset_is_support = sienna_cichlid_is_mode1_reset_supported,
+	.mode1_reset = smu_v11_0_mode1_reset,
 	.get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = sienna_cichlid_set_soft_freq_limited_range,
 	.override_pcie_parameters = smu_v11_0_override_pcie_parameters,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 48e15885e9c3..91a9e6ab25c7 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1741,6 +1741,17 @@ int smu_v11_0_baco_exit(struct smu_context *smu)
 	return ret;
 }
 
+int smu_v11_0_mode1_reset(struct smu_context *smu) {
+	int ret = 0;
+
+	ret = smu_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
+	if (!ret)
+		msleep(500);
+
+	return ret;
+}
+
 int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
 						 uint32_t *min, uint32_t *max)
 {
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7Ca291cfb51ecb40a1cf0608d8249c4460%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637299600875655517&amp;sdata=XDn3x0%2FbPxccIUwQi4wRWCOyDdunP12Hq17vJZNA420%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
