Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1DFC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 09:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6279E64F2D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 09:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6279E64F2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A256E9DE;
	Wed, 10 Mar 2021 09:07:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B4336E9DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 09:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQsbEBjU8p07JWQkFdO9OCcYuFmJcsdD72QaRsOPsMf1ogpTMsih9viF+hUe4Gbc7AB1rLtjV1sLCiAoJoR7rX1Sv04aFATYd7AHqVw7TlivES2AOxtlTs6pV7ynRyUOvNHYlhZBR4GF2u/6FMhgSyQJfyhthvvQm0OApL37AyF9L+D7E6UU015ED1PAb+hQAfEXuAs0jDju3Cj2mq0w15IGWGbb7iAO73b6poF+qiDAfALQh39jC2mhH69NOsX2AjFll8/1Enh8YgIo05egUnqIIRyjD/DM6wdGXQkGJiyAskf5ZGv3e6GmbqaK4sno6qwnXEtg/A9CNUaZ5J0Z7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBEBmUvoA1x0Gac0EfwMvf3mXYSK+ktFFllJBlKWXSg=;
 b=GHPWzU1rpQGkr7F8oZs+OlweAF8vUSY3JxvDtBC46ju65KS6i/V+F93HHhuxW3xSR6RNb6sr3QqPPBTXdjS2iU8GtliD8n0lVc9S1jIDhSFd+bfwngP6GjBmVHb5d5h4FI8CYrWJoRmTbjQGYU08E8AmOR3f7+R+q0mt7JWihSUGWDoq5CDhXNRwe4uWtqWi6o3EbxkEI6uBb2KSdSqIBAS3Rlwf2AYS5ZrcH0PLJJ7JwqPkenZF83RR8F06faIC0HJ34hagHXeFRr8WiOh5tVYWXJEOJrf58FkmbmDsXMzeya5ZCkDquQ5VbIgARSNwgQ288nO0n83TYYopmA+msw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBEBmUvoA1x0Gac0EfwMvf3mXYSK+ktFFllJBlKWXSg=;
 b=i7gYWKeaQdV4MOBvava8LYHfcwk3nqBMSsHl769sD6uiAe90GVqCyqcHKMf2aRibufGaaLQ7VxhQ5cM3f3veTnnj0n3w4rUBnlmp1vDJUBJ5lvdOk9l/Ql9/kzu47a2wtWe4VQVheHQyBm2caXLon9To0KNw7CA4MVfNDkXefvA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Wed, 10 Mar 2021 09:07:48 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 09:07:47 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: bug fix for pcie dpm
Thread-Topic: [PATCH] drm/amd/pm: bug fix for pcie dpm
Thread-Index: AQHXFOaUuC8mO1fcc0KRTR9ZCEcBlap878gQ
Date: Wed, 10 Mar 2021 09:07:47 +0000
Message-ID: <DM6PR12MB26198FFA56B8BDC0395A9D4FE4919@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210309131745.3866-1-kenneth.feng@amd.com>
In-Reply-To: <20210309131745.3866-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-10T09:07:44Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f216accd-2b53-4a46-b0f4-fa5458ff7e1e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1bfe729c-1468-42be-a738-08d8e3a3f99c
x-ms-traffictypediagnostic: DM6PR12MB3179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB31795C398FC38259FE892063E4919@DM6PR12MB3179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3tDaoCBQrr+9yOYvKVMhTKy8S/03IQnvCGlDOB/GSFnKTe7xICq999NTRKdwj1J9fMCPQCDlb1fsFOjYDksW+wHQ7KzbbO+WOizL0ybI/Qcd7yEkzjcIp63BkTOQ1XR779RjuC/YJJJ2q4iJiLgQulnCd9yQRA9G6RCWbuhyCQJrCZnJjMmnN0pEZSjlGA3kXUjzUqj3GlOCLKP3zyKMOUwaZlTvmoZKXlwJlLxVOl6+tBIpw50B/aPCWOEdA7pp3JCmLirg5iAXT1hSBLTejBmagdjHp9KP5UNe76WUwECOOdCJuFvbT3sZz+RRxhHDUVDjbrxwhgT69byveVNaeouq2p3bpcgP5Em8eSadYt2CMJPkUtHN3nYSOuzzgvPuJmfsJYe9ilWUqZEkBmAOd3hxgV2WsLFnHNSEkYkqtdUUwAedg96O1L8KOorUIz39qJUO0jxlqcRY/Y0p8gfRfrK12ckg9tKdff6uvdSyAePWN/2GZYBRAKSrui5K/L9R0y9vroOVUN1x08RtAHcIl3jpifGk5jrExIGCNjnfmLDkxuMkNc9DzlQEUbEBMjMk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(110136005)(71200400001)(478600001)(966005)(186003)(8936002)(66946007)(76116006)(52536014)(33656002)(53546011)(5660300002)(6506007)(2906002)(7696005)(66446008)(4326008)(66476007)(86362001)(66556008)(64756008)(316002)(26005)(9686003)(45080400002)(83380400001)(8676002)(55016002)(30864003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RlcrJm262n8rwEFemSp87oRm252IzXHS2hcr55waL8JKOzmOqNY0OA+mDmXw?=
 =?us-ascii?Q?2yo8qhEmoRwn1K0PJptetml64AIzTZxcKI/xVZ6CJXyoXTmqnqLpZGXVXr+g?=
 =?us-ascii?Q?pHdp3W+3jZOcMOuXEqBWmRyaLuzSxCp04Cvt/NtoV5pAli8BacsInamqmy5c?=
 =?us-ascii?Q?8BgABEssvoCiaN3Q8sMjgqV1SbDHVopQ9RSHBmWiMSrq59cZM8kWPSbrFAbU?=
 =?us-ascii?Q?/h/ic7qQhmCaaPDjxFoJaXnd39VQYw1hSFmCgSypjZj1EVwXAt3TmzwWBedb?=
 =?us-ascii?Q?+LkUw84GRENlsZ0c7Zixe1xJRKGUkT854IClSH5xwcmrnDQCZ5jQ4STUtnI1?=
 =?us-ascii?Q?Js/nEwF//HJVi0nBP+830YYUuGxSbmhMDu4NERNt9Vxd1Zq4Acy/F7NwiMin?=
 =?us-ascii?Q?PIOcCCg463C1KhEg8jgT0R0rhri9YOK44y6VOxRqEE89p8HvaHCZNQ+BvpzZ?=
 =?us-ascii?Q?zdQwZxHSazNBwjfODpmkx4Bg7eSEQycafVkekFM0ubwG2L3yVsIUza9BtsTo?=
 =?us-ascii?Q?REahmZBoUOPSupBKeKGQcYbJLnfgqwHnsBfCGpHvdYgWrx/b7kK4LjDjGFJI?=
 =?us-ascii?Q?XGjU5Q0N3o9hOpc7bfBLIbKVFH53s+xc1hfd2cI3mWS9c7VF6DNeHE1QUaL/?=
 =?us-ascii?Q?rPLgvfIWWUjraw+UEfL6ZHERQL+5TINAgu6FCxQG8J9jd8eJbMQce8glvfwj?=
 =?us-ascii?Q?IkVxLvXW2QtxU75ezu4lZ+nLlFGUvjPtjkGzAw+gHzuRP4GKTV44OFd812Ah?=
 =?us-ascii?Q?mJALyVkcPmZsY+ekXjl4fyTCrXnq2N3Off4QUw1iz1Ck+qXWZdvKvPa1GgBX?=
 =?us-ascii?Q?twzXqQ6/XFoOZvcSm7opgTy+swSnAYsv9rsGkPtml0z0Ke5zyLmkHSGQ+pXu?=
 =?us-ascii?Q?x2v2NGu23N7v8d+5/RTrzuNpx1OxA265zyVUFjQJ4S6afoGSS2UBuhkj922C?=
 =?us-ascii?Q?VeY8akqIIYrHmum46lIABH8oFfz3mDYaGj48zkno3iXGerysQhnA2fegmKNz?=
 =?us-ascii?Q?bKNSuiTBR8qhK6hn86DtOHpHy4S6IJNNDtk0wmP2K3P0BrqKbZs44BJQOyel?=
 =?us-ascii?Q?kAY6GZjl4NBmjjKI+dk97vV2f6c5WlRZBodT5Alc3MzN4WSnNBBZJR5OUmeo?=
 =?us-ascii?Q?D0XIt6CzKL0ffJsszxSdCZf0sVVVzLZ6tcCC8dqvlsYeC8MJlORxyTqJx6xS?=
 =?us-ascii?Q?3VaQ76CLQrGTNN8pxevttNzwTKEOi4fnnEXbj+g59WdNCpV0axvwmp42c2is?=
 =?us-ascii?Q?A897YZBRk6v5HYErQmxI8/KWdMQN+mDB91Ize2FDJHgT/3cYw6HPLsQgk3DJ?=
 =?us-ascii?Q?MT+HNLwg1oRHGbw5AX/CCspa?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfe729c-1468-42be-a738-08d8e3a3f99c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 09:07:47.8763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4nLnIFmEUBiUMKbTy/Jmv/9zmfwXypQEtMqM2gCZM8HNpmfdNi1ldgDNGYi97qbe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth Feng
Sent: Tuesday, March 9, 2021 9:18 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: bug fix for pcie dpm

Currently the pcie dpm has two problems.
1. Only the high dpm level speed/width can be overrided
if the requested values are out of the pcie capability.
2. The high dpm level is always overrided though sometimes
it's not necesarry.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 48 ++++++++++++++
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 66 +++++++++++++++++++
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 48 ++++++++------
 3 files changed, 141 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 5e875ad8d633..408b35866704 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -1505,6 +1505,48 @@ static int vega10_populate_single_lclk_level(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
+static int vega10_override_pcie_parameters(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
+	struct vega10_hwmgr *data =
+			(struct vega10_hwmgr *)(hwmgr->backend);
+	uint32_t pcie_gen = 0, pcie_width = 0;
+	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
+	int i;
+
+	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
+		pcie_gen = 3;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
+		pcie_gen = 2;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
+		pcie_gen = 1;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1)
+		pcie_gen = 0;
+
+	if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
+		pcie_width = 6;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)
+		pcie_width = 5;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8)
+		pcie_width = 4;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4)
+		pcie_width = 3;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2)
+		pcie_width = 2;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X1)
+		pcie_width = 1;
+
+	for (i = 0; i < NUM_LINK_LEVELS; i++) {
+		if (pp_table->PcieGenSpeed[i] > pcie_gen)
+			pp_table->PcieGenSpeed[i] = pcie_gen;
+
+		if (pp_table->PcieLaneCount[i] > pcie_width)
+			pp_table->PcieLaneCount[i] = pcie_width;
+	}
+
+	return 0;
+}
+
 static int vega10_populate_smc_link_levels(struct pp_hwmgr *hwmgr)
 {
 	int result = -1;
@@ -2556,6 +2598,11 @@ static int vega10_init_smc_table(struct pp_hwmgr *hwmgr)
 			"Failed to initialize Link Level!",
 			return result);
 
+	result = vega10_override_pcie_parameters(hwmgr);
+	PP_ASSERT_WITH_CODE(!result,
+			"Failed to override pcie parameters!",
+			return result);
+
 	result = vega10_populate_all_graphic_levels(hwmgr);
 	PP_ASSERT_WITH_CODE(!result,
 			"Failed to initialize Graphics Level!",
@@ -2922,6 +2969,7 @@ static int vega10_start_dpm(struct pp_hwmgr *hwmgr, uint32_t bitmap)
 	return 0;
 }
 
+
 static int vega10_enable_disable_PCC_limit_feature(struct pp_hwmgr *hwmgr, bool enable)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index a827f2bc7904..196ac2a4d145 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -481,6 +481,67 @@ static void vega12_init_dpm_state(struct vega12_dpm_state *dpm_state)
 	dpm_state->hard_max_level = 0xffff;
 }
 
+static int vega12_override_pcie_parameters(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
+	struct vega12_hwmgr *data =
+			(struct vega12_hwmgr *)(hwmgr->backend);
+	uint32_t pcie_gen = 0, pcie_width = 0, smu_pcie_arg, pcie_gen_arg, pcie_width_arg;
+	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
+	int i;
+	int ret;
+
+	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
+		pcie_gen = 3;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
+		pcie_gen = 2;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
+		pcie_gen = 1;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1)
+		pcie_gen = 0;
+
+	if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
+		pcie_width = 6;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)
+		pcie_width = 5;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8)
+		pcie_width = 4;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4)
+		pcie_width = 3;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2)
+		pcie_width = 2;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X1)
+		pcie_width = 1;
+
+	/* Bit 31:16: LCLK DPM level. 0 is DPM0, and 1 is DPM1
+	 * Bit 15:8:  PCIE GEN, 0 to 3 corresponds to GEN1 to GEN4
+	 * Bit 7:0:   PCIE lane width, 1 to 7 corresponds is x1 to x32
+	 */
+	for (i = 0; i < NUM_LINK_LEVELS; i++) {
+		pcie_gen_arg = (pp_table->PcieGenSpeed[i] > pcie_gen) ? pcie_gen :
+			pp_table->PcieGenSpeed[i];
+		pcie_width_arg = (pp_table->PcieLaneCount[i] > pcie_width) ? pcie_width :
+			pp_table->PcieLaneCount[i];
+
+		if (pcie_gen_arg != pp_table->PcieGenSpeed[i] || pcie_width_arg !=
+		    pp_table->PcieLaneCount[i]) {
+			smu_pcie_arg = (i << 16) | (pcie_gen_arg << 8) | pcie_width_arg;
+			ret = smum_send_msg_to_smc_with_parameter(hwmgr,
+				PPSMC_MSG_OverridePcieParameters, smu_pcie_arg,
+				NULL);
+			PP_ASSERT_WITH_CODE(!ret,
+				"[OverridePcieParameters] Attempt to override pcie params failed!",
+				return ret);
+		}
+
+		/* update the pptable */
+		pp_table->PcieGenSpeed[i] = pcie_gen_arg;
+		pp_table->PcieLaneCount[i] = pcie_width_arg;
+	}
+
+	return 0;
+}
+
 static int vega12_get_number_of_dpm_level(struct pp_hwmgr *hwmgr,
 		PPCLK_e clk_id, uint32_t *num_of_levels)
 {
@@ -968,6 +1029,11 @@ static int vega12_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 			"Failed to enable all smu features!",
 			return result);
 
+	result = vega12_override_pcie_parameters(hwmgr);
+	PP_ASSERT_WITH_CODE(!result,
+			"[EnableDPMTasks] Failed to override pcie parameters!",
+			return result);
+
 	tmp_result = vega12_power_control_set_level(hwmgr);
 	PP_ASSERT_WITH_CODE(!tmp_result,
 			"Failed to power control set level!",
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index e8eec2539c17..78bbd4d666f2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -831,7 +831,9 @@ static int vega20_override_pcie_parameters(struct pp_hwmgr *hwmgr)
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
-	uint32_t pcie_gen = 0, pcie_width = 0, smu_pcie_arg;
+	uint32_t pcie_gen = 0, pcie_width = 0, smu_pcie_arg, pcie_gen_arg, pcie_width_arg;
+	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
+	int i;
 	int ret;
 
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
@@ -860,17 +862,27 @@ static int vega20_override_pcie_parameters(struct pp_hwmgr *hwmgr)
 	 * Bit 15:8:  PCIE GEN, 0 to 3 corresponds to GEN1 to GEN4
 	 * Bit 7:0:   PCIE lane width, 1 to 7 corresponds is x1 to x32
 	 */
-	smu_pcie_arg = (1 << 16) | (pcie_gen << 8) | pcie_width;
-	ret = smum_send_msg_to_smc_with_parameter(hwmgr,
-			PPSMC_MSG_OverridePcieParameters, smu_pcie_arg,
-			NULL);
-	PP_ASSERT_WITH_CODE(!ret,
-		"[OverridePcieParameters] Attempt to override pcie params failed!",
-		return ret);
+	for (i = 0; i < NUM_LINK_LEVELS; i++) {
+		pcie_gen_arg = (pp_table->PcieGenSpeed[i] > pcie_gen) ? pcie_gen :
+			pp_table->PcieGenSpeed[i];
+		pcie_width_arg = (pp_table->PcieLaneCount[i] > pcie_width) ? pcie_width :
+			pp_table->PcieLaneCount[i];
+
+		if (pcie_gen_arg != pp_table->PcieGenSpeed[i] || pcie_width_arg !=
+		    pp_table->PcieLaneCount[i]) {
+			smu_pcie_arg = (i << 16) | (pcie_gen_arg << 8) | pcie_width_arg;
+			ret = smum_send_msg_to_smc_with_parameter(hwmgr,
+				PPSMC_MSG_OverridePcieParameters, smu_pcie_arg,
+				NULL);
+			PP_ASSERT_WITH_CODE(!ret,
+				"[OverridePcieParameters] Attempt to override pcie params failed!",
+				return ret);
+		}
 
-	data->pcie_parameters_override = true;
-	data->pcie_gen_level1 = pcie_gen;
-	data->pcie_width_level1 = pcie_width;
+		/* update the pptable */
+		pp_table->PcieGenSpeed[i] = pcie_gen_arg;
+		pp_table->PcieLaneCount[i] = pcie_width_arg;
+	}
 
 	return 0;
 }
@@ -3319,9 +3331,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 			data->od8_settings.od8_settings_array;
 	OverDriveTable_t *od_table =
 			&(data->smc_state_table.overdrive_table);
-	struct phm_ppt_v3_information *pptable_information =
-		(struct phm_ppt_v3_information *)hwmgr->pptable;
-	PPTable_t *pptable = (PPTable_t *)pptable_information->smc_pptable;
+	PPTable_t *pptable = &(data->smc_state_table.pp_table);
 	struct pp_clock_levels_with_latency clocks;
 	struct vega20_single_dpm_table *fclk_dpm_table =
 			&(data->dpm_table.fclk_table);
@@ -3420,13 +3430,9 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 		current_lane_width =
 			vega20_get_current_pcie_link_width_level(hwmgr);
 		for (i = 0; i < NUM_LINK_LEVELS; i++) {
-			if (i == 1 && data->pcie_parameters_override) {
-				gen_speed = data->pcie_gen_level1;
-				lane_width = data->pcie_width_level1;
-			} else {
-				gen_speed = pptable->PcieGenSpeed[i];
-				lane_width = pptable->PcieLaneCount[i];
-			}
+			gen_speed = pptable->PcieGenSpeed[i];
+			lane_width = pptable->PcieLaneCount[i];
+
 			size += sprintf(buf + size, "%d: %s %s %dMhz %s\n", i,
 					(gen_speed == 0) ? "2.5GT/s," :
 					(gen_speed == 1) ? "5.0GT/s," :
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C472abf29b65a439753a608d8e2fdb608%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637508926602518249%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=04tGHvGnaeO8gpzB%2FUzJ0hi2dvLWl%2FjZ3Gs2wtOuSrY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
