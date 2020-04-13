Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DC2C2BB55
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 03:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9244220678
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 03:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IscPivKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9244220678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E3B989EAC;
	Mon, 13 Apr 2020 03:08:48 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690063.outbound.protection.outlook.com [40.107.69.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0598089EAC
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 03:08:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM6BYVaPDnWs+uNWrEfxnIhk5uHRUUP92PcfmcXS+M+CJcg4C7/Yf1FpoG4dGuwNVCOoa+n3QZbY/fiLrTQZZcJzXpcGPvEx+CI/XQWqh9ZT4n+JWPQpbcHpk5G+Ou6ygy82VSbkyDiA1jqWjZMRauDn2lsb/F4eM0ygbaC7vnOkJ3sREaBv9QmG6QToDou/mX6f6jtSsXWZTwuJJ+kyTJv9zULwfds1weXxQH5nSTcoLFzBkh/03Pf2jaWaCffWfsitmn91AN20P3EuU/Bp0/+f/CNJAY60giMySPOiktfDQUdQA03ycG1D1r04ku0g7Flcn8pCaLH6xIoAZ+XGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vG9KQhfqvQbP48e/C/RTEX5MwtMj7IVA28XZqPyJJcQ=;
 b=lxsnpIgo16F9qW2fKATF2K485aqBTFG6MsrY2bgYUMwkoQVPNJJe7yy81+fJys/fY9u12Hrq8XC6KJwcZF6U6J5Do+tVJuqxR82tqeIFddi7yCqIbVYp8mY3GOsWOCpCmbousRTLGE4uLNW3EQWIil9QJV38p1gW3zWyZBtyZ9zs1uOguPyYZuTRGR6NJraK6/lYaihD4Xtl6aqTl98K5VkI+c8PPhPXJuMsSxrma6fjJGcrsDbzyXE/uNC5DsQ9SIL3rGZyE28Yv2jXd38cPjUovxXSYpUySb6e//EBJJiD7Z7uozlELoWKlDsq6AsLnkoOOjdCTj77i6xQDVlwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vG9KQhfqvQbP48e/C/RTEX5MwtMj7IVA28XZqPyJJcQ=;
 b=IscPivKs+NNYF/+JNsXZd91+L+Q90R/FkP2ppSVOy5nz931HIO9aTArypgPN30Prz01tmKzx3sFGb9uM167pz5thJ5igHyxnudiJqLYYwTb9+cdSok/j44bQ7VDgS+sC0FJdciTDpU2vO/Q68H3LVV2OWqMVN0bMVD2+pyU91GA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2811.namprd12.prod.outlook.com (2603:10b6:5:45::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Mon, 13 Apr 2020 03:08:42 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2878.022; Mon, 13 Apr 2020
 03:08:42 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix wrong vram lost counter increment V2
Date: Mon, 13 Apr 2020 11:08:23 +0800
Message-Id: <20200413030823.3506-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.5 via Frontend Transport; Mon, 13 Apr 2020 03:08:40 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76b83bd2-453c-42a9-3022-08d7df57f847
X-MS-TrafficTypeDiagnostic: DM6PR12MB2811:|DM6PR12MB2811:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28118C7ACE0282E870462860E4DD0@DM6PR12MB2811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(8936002)(4326008)(5660300002)(316002)(1076003)(2616005)(956004)(36756003)(478600001)(86362001)(44832011)(81156014)(8676002)(2906002)(16526019)(7696005)(186003)(52116002)(66476007)(66946007)(66556008)(6916009)(6486002)(26005)(6666004)(309714004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0cczkrawHXEkzPgkkiC9rPEvKY/h1+VdcAXnFHXHj3VMsHdmo7eEbsi1WqWb+23JKLUJsMzu8dEFWzxZLoRRs70Ys3eKUb/d2pNWM+vKo2D78ViYYQMkZX3AtK4yD5tYWMJb69lnEaBcWK06eZpvS0SAaAtiK6ugjRiYo6PdLdwsLPx4UxWPJeOZngVpMd42zU9r2dC7qiIqF0yudna9YwR8re/uYiiR4x004kwLxS7tPHwbuHSwg2IlDkBm0yEbrxsnMJ2ZrcOGejYzxk/Abn/VSmc6RCrpLbeO0UiF2ygYEn1jqOyuCchM2sli6GvZwP51A9rFYnLBUDHHbx3YeLlc2m+me+A3X9ctB3zkDHoNa1jSGpj/xkQv+1OO2Kx6XZMR5zX11oXYpvbPEOpGpxQxAwyaO56dl77mQOuCnQVQZGqemZ/zZ9N4nW7CzNSkVmWCp14YYRo36DBpuUgs6BhWeT8inrC8F0JAU/PlmYn15tO3K2s1JRqvaMxBDnJ
X-MS-Exchange-AntiSpam-MessageData: ihShddapUZKfYC+0e+AkGC5cEuouRXggKXBDEU/5kipboYoO7tq6f6NhlFwm2oMHhAfJeRX3dtpszyEUy1uNu0sNGBXGwTIGrctBOBYvl5A8qcpIVkcJrdsUmZtbzqfstD2rzdoVYgEMFx4j3ptWSg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b83bd2-453c-42a9-3022-08d7df57f847
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 03:08:41.9413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iyrm4jJTyTbcVrTSniY1lzsKActWgu8F5iASqkKQx0okPOg0vI13FRcXYnfqJ8qa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Vram lost counter is wrongly increased by two during baco reset.

V2: assumed vram lost for mode1 reset on all ASICs

Change-Id: I8b9959a5d1632abc774ba07d56cf295bdd8288eb
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/cik.c           |  2 --
 drivers/gpu/drm/amd/amdgpu/nv.c            |  4 ----
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 ----
 drivers/gpu/drm/amd/amdgpu/vi.c            |  2 --
 5 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a2a4e4b28d00..8f479a918f0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2087,8 +2087,24 @@ static void amdgpu_device_fill_reset_magic(struct amdgpu_device *adev)
  */
 static bool amdgpu_device_check_vram_lost(struct amdgpu_device *adev)
 {
-	return !!memcmp(adev->gart.ptr, adev->reset_magic,
-			AMDGPU_RESET_MAGIC_NUM);
+	if (memcmp(adev->gart.ptr, adev->reset_magic,
+			AMDGPU_RESET_MAGIC_NUM))
+		return true;
+
+	if (!adev->in_gpu_reset)
+		return false;
+
+	/*
+	 * For all ASICs with baco/mode1 reset, the VRAM is
+	 * always assumed to be lost.
+	 */
+	switch (amdgpu_asic_reset_method(adev)) {
+	case AMD_RESET_METHOD_BACO:
+	case AMD_RESET_METHOD_MODE1:
+		return true;
+	default:
+		return false;
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index db68ffa27984..fe306d0f73f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1358,8 +1358,6 @@ static int cik_asic_reset(struct amdgpu_device *adev)
 	int r;
 
 	if (cik_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
-		if (!adev->in_suspend)
-			amdgpu_inc_vram_lost(adev);
 		r = amdgpu_dpm_baco_reset(adev);
 	} else {
 		r = cik_asic_pci_config_reset(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 7768880fcccf..995bdec9fa7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -351,8 +351,6 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 	struct smu_context *smu = &adev->smu;
 
 	if (nv_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
-		if (!adev->in_suspend)
-			amdgpu_inc_vram_lost(adev);
 		ret = smu_baco_enter(smu);
 		if (ret)
 			return ret;
@@ -360,8 +358,6 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 		if (ret)
 			return ret;
 	} else {
-		if (!adev->in_suspend)
-			amdgpu_inc_vram_lost(adev);
 		ret = nv_asic_mode1_reset(adev);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index a597ad22b675..58a440a15525 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -569,14 +569,10 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
 
 	switch (soc15_asic_reset_method(adev)) {
 		case AMD_RESET_METHOD_BACO:
-			if (!adev->in_suspend)
-				amdgpu_inc_vram_lost(adev);
 			return soc15_asic_baco_reset(adev);
 		case AMD_RESET_METHOD_MODE2:
 			return amdgpu_dpm_mode2_reset(adev);
 		default:
-			if (!adev->in_suspend)
-				amdgpu_inc_vram_lost(adev);
 			return soc15_asic_mode1_reset(adev);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 0a90c296409b..af8986a55354 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -744,8 +744,6 @@ static int vi_asic_reset(struct amdgpu_device *adev)
 	int r;
 
 	if (vi_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
-		if (!adev->in_suspend)
-			amdgpu_inc_vram_lost(adev);
 		r = amdgpu_dpm_baco_reset(adev);
 	} else {
 		r = vi_asic_pci_config_reset(adev);
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
