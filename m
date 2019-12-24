Return-Path: <SRS0=l0jK=2O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280D0C2D0CF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 09:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26E7206CB
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 09:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MmHqjX1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26E7206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF506E31A;
	Tue, 24 Dec 2019 09:40:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F28566E31A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 09:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+gBkIfGCDIKj2VazG8efxKsD016ziMJf8J1f7pCjigoqYc3ScFH2Az8qO+R6L2ycMxBOBmeSlmdz6a7dQUy5WYJiTZZ4IBpTeOIoBqz2vAUBvFOJJ6jR6dQ+ZgijfGTYuifSlDq4r+kMPVh9p459Blauu58pHmjmJC3nBa6/DUk42WKznoeoxkx5g7jZrFtof4awxg1bkPHUiE6wG5dIGHRhfxIlHegeBjpx1utUQYKVBFeIWOxwvUrygW1/ggQJd+PjVhKeOm5gn/1FahfzbZmPgyghfnJk02VPwrFkVKlbJwVpK7sCglrtaSGEtV6qj+PbSg0uHaJME51I5HrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1jK34Ac8+dPo8xLhMTP4qtlM2IsPvNpWWPPU+O9sCE=;
 b=NBqVHdL0oOWaoUEmtLuGeM66XoAkqa+Jyzr7y/Oni2N3X9gi01EomRpvk8kIv980R3QC2XQG/kWtxQLolVBDoQTAQ5CdHPJZUSx4RfZFo5GDCa7QGkhJ/dAMRKqwzIDQYTcfHpw3+uBpVLbvbSWbHGAV2Waq2lYDpXO4Z4Pz6om9YzqpRpTwXAZ4zRn8YeWEZfzooDJGaaGYR+C8MysDS5Yrk2CfLM1Jimxz9OG7df2GVKWOS7T6R0NmnO/cDnchqxXj0PexC6GSE59cA79jiXEqtKU561Sro+0NFt2zFz3rEnnXxu+3VhlWXMkg6VNDv6q/E4GmcmoGCGRyRTBVow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1jK34Ac8+dPo8xLhMTP4qtlM2IsPvNpWWPPU+O9sCE=;
 b=MmHqjX1ML8m0bfqlVEjzODAF4Dn4ZQXMTNOq/ei5hPvlbHQ5OjQjHsmqk+pheH7FPgFJNT4QmM6QPKswhKA607rTi8tJPQwesEGf5V8L6fac5TtNZCQvJo4id0ClY8WFBxBXIXLAg1hycGTp3dwlYDUipn/FhetqRgLFt6L1qsU=
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3198.namprd12.prod.outlook.com (20.179.82.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Tue, 24 Dec 2019 09:40:34 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7%6]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 09:40:34 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/smu: use unified variable smu->is_apu to check
 apu asic platform
Thread-Topic: [PATCH] drm/amdgpu/smu: use unified variable smu->is_apu to
 check apu asic platform
Thread-Index: AQHVuXutznAyOJc+HEOum2ZNpzs/s6fJCUsw
Date: Tue, 24 Dec 2019 09:40:34 +0000
Message-ID: <MN2PR12MB3309787420E7C61359B98517EC290@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <20191223102743.3836-1-kevin1.wang@amd.com>
In-Reply-To: <20191223102743.3836-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-24T09:40:30Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b55e85fa-fbc8-4b8a-9b7c-000044ef4ce1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-24T09:40:30Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: fff7c386-d655-4fa8-a6f8-0000cc04074e
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b54a6423-0327-43a8-5bf6-08d788555306
x-ms-traffictypediagnostic: MN2PR12MB3198:|MN2PR12MB3198:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB31980249EF04F97512B3EAFEEC290@MN2PR12MB3198.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(13464003)(26005)(186003)(478600001)(8936002)(33656002)(5660300002)(55016002)(2906002)(81166006)(86362001)(81156014)(8676002)(52536014)(4326008)(316002)(71200400001)(66476007)(66446008)(53546011)(9686003)(7696005)(6506007)(64756008)(54906003)(66946007)(66556008)(76116006)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3198;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: geCBht2iqOr0pTLC6Gi+gzcjuAqxCXUHqAyVz26qk8Aw5dz2V6aXKLUWN5KThp+tTDp5H+HrstbZ+6SVInYuUAoq8TTOAFZa30rRKBhPQmqYAhB6mY6c4ulEuctSu/kQ0EuxdkN5WzXwIKX1C6Jqbx57cDNkm1+6NhsgaQ7MIBKQptm+R8+CFyN5HH3L6750YuWwZnIE+tNPqw+2GjZTKFFz0d+NO8JG7dd3mJ03+HnvXl5FTZOP3M9BSgK+9a2jPGrd3JIhy20vqY5j1W3hoOfngNa0K4iQ3du4ph9ZqZx8fO8eLGyzub2aT/foKt7KoAOUgS2d7vHoDfFBzf9zSd7/BpXdwFsopCeHBItyybV3XmCFp1Tt6SjwM8MKgJurIK4GxkE5kafe2fCJPuEWM18gRfiswvKnDo80gm4aeX6/DbxenzNo0JTrEzzbowu/tfUVbmWKUjhHvYbJXauvNFGMJmQjmfgyRqx7L/w28rVx6bK6EB0Yh/gUDZCeOFHi
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54a6423-0327-43a8-5bf6-08d788555306
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 09:40:34.1278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7iO/wm0ijBQxGtqr5b3KvVdRnWEtfscAy68CgZrQ5JefivnpkzqDzc70rSEMBQytmr4fYwtCgf8/5KZH1hMAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3198
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com> 
Sent: Monday, December 23, 2019 6:28 PM
To: amd-gfx-bounces@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amdgpu/smu: use unified variable smu->is_apu to check apu asic platform

use unified variable smu->is_apu to check apu asic in smu driver.

related patch:
drm/amd/powerplay: bypass dpm_context null pointer check guard for some smu series

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 9 ++++-----  drivers/gpu/drm/amd/powerplay/smu_v12_0.c  | 6 +++---
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index f76a1717ffbd..6aa27a1e9495 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -643,12 +643,11 @@ int smu_feature_init_dpm(struct smu_context *smu)
 
 int smu_feature_is_enabled(struct smu_context *smu, enum smu_feature_mask mask)  {
-	struct amdgpu_device *adev = smu->adev;
 	struct smu_feature *feature = &smu->smu_feature;
 	int feature_id;
 	int ret = 0;
 
-	if (adev->flags & AMD_IS_APU)
+	if (smu->is_apu)
 		return 1;
 
 	feature_id = smu_feature_get_index(smu, mask); @@ -1241,7 +1240,7 @@ static int smu_hw_init(void *handle)
 		return ret;
 	}
 
-	if (adev->flags & AMD_IS_APU) {
+	if (smu->is_apu) {
 		smu_powergate_sdma(&adev->smu, false);
 		smu_powergate_vcn(&adev->smu, false);
 		smu_powergate_jpeg(&adev->smu, false); @@ -1300,7 +1299,7 @@ static int smu_hw_fini(void *handle)
 	struct smu_table_context *table_context = &smu->smu_table;
 	int ret = 0;
 
-	if (adev->flags & AMD_IS_APU) {
+	if (smu->is_apu) {
 		smu_powergate_sdma(&adev->smu, true);
 		smu_powergate_vcn(&adev->smu, true);
 		smu_powergate_jpeg(&adev->smu, true); @@ -1376,7 +1375,7 @@ static int smu_suspend(void *handle)
 	struct smu_context *smu = &adev->smu;
 	bool baco_feature_is_enabled = false;
 
-	if(!(adev->flags & AMD_IS_APU))
+	if(!smu->is_apu)
 		baco_feature_is_enabled = smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT);
 
 	ret = smu_system_features_control(smu, false); diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 2ac7f2f231b6..9e27462d0f4e 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -159,7 +159,7 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
 
 int smu_v12_0_powergate_sdma(struct smu_context *smu, bool gate)  {
-	if (!(smu->adev->flags & AMD_IS_APU))
+	if (!smu->is_apu)
 		return 0;
 
 	if (gate)
@@ -170,7 +170,7 @@ int smu_v12_0_powergate_sdma(struct smu_context *smu, bool gate)
 
 int smu_v12_0_powergate_vcn(struct smu_context *smu, bool gate)  {
-	if (!(smu->adev->flags & AMD_IS_APU))
+	if (!smu->is_apu)
 		return 0;
 
 	if (gate)
@@ -181,7 +181,7 @@ int smu_v12_0_powergate_vcn(struct smu_context *smu, bool gate)
 
 int smu_v12_0_powergate_jpeg(struct smu_context *smu, bool gate)  {
-	if (!(smu->adev->flags & AMD_IS_APU))
+	if (!smu->is_apu)
 		return 0;
 
 	if (gate)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
