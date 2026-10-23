Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F58606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Yczs6hpp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B6110E54A;
	Fri, 23 Oct 2026 06:30:46 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C550A10E54A
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 06:30:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ab4TuT2ot+NoIm4Watsgnv7TUdRQlFRlttzeLcqGaneNzKuu23sj6QYaTR1txJ2a8T1FMAAzR0O3IiGi+T4Y9DV/+Bu4eR91ujo/A7MGryeOqVb3l4OAWihsoB1PLOrXQSRg0r1GNfgekRnkTNmGLbU00aOCZAGKPQzYFtIaqkItOqssE9fD6KZ5soZd/sTicO3B8+RwBHbtbXLPRK2SUYayg6qpl1JbL1Rn1U7YSzGB3ai0bkfzm1NG0aYc3iD+ZIDISUN9JV7Y0/BSv6XX9oeZbkzKrWjJ+lTR+XhX2Vk1KMeCS4MY5nizcccAm3wyQ/pBHQs1Xt7kRtXgU4yoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vtIE0c9zeYavnfBIJBBye3wCeG4n7dHfcAv7EBSVzU=;
 b=tGYBAO9nwC5YIFOMTQBljalAjIwuUOlXZZmODrs+4eEIt6O0ERbc3nJvZk7KW+OaSU4OsBfoOr8GgfDxzPtAuM+cWFOwaq//qlR3ouoFrvEH5+LrWWfM4tQRzqMkvRfeP6SLDRJLs9OAU+Y4AlE+Cl2slIj9w+/JV5kxEupVNTPvJgiuZ3rJH1ZixkQNco9uOl5EbYh/czk/gOVNkFxZ1UsojT+gH0elKyIrVIeoadqQ7PilsN1/xhwjPcvyzSFSJN6otwNbS7SR+7FO2OYYdk1i/fmSTZT1BqEFE7KVI4w7X7lhGm19cdPoDVrtK2upt2vTRI93QVajJoiTy+vpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vtIE0c9zeYavnfBIJBBye3wCeG4n7dHfcAv7EBSVzU=;
 b=Yczs6hppGkH1kDTKhQ+IUDrtELz3W9VWumeXjuomozbBwFHzHtkOxqodMi2cZWwe0YLcn8NQQ0a4EIX92mQR7oaxezPedVveLcouiFLsV7g7quHLzz5tiFGQZ62q/DkJhf/GGEadlo5dTz6aEyeB0Gc26PJ0wXwazq6b2V2TUL8=
Received: from CH5P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::14)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 06:30:34 +0000
Received: from CH01EPF000BE94F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::a9) by CH5P220CA0010.outlook.office365.com
 (2603:10b6:610:1ef::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Fri,
 23 Oct 2026 06:30:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE94F.mail.protection.outlook.com (10.167.244.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 06:30:34 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 01:30:33 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 23 Oct 2026 01:30:31 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Mario.Novales@amd.com>, <Igor.Caike@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/gfx12: flush the scratch register write in the
 ring test
Date: Fri, 23 Oct 2026 14:30:26 +0800
Message-ID: <20261023063031.849579-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94F:EE_|SN7PR12MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a57dd6-7641-4db7-4a0a-08df30cf24cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|261022105027099003|56012099006|11063799006|5023799004|261009223027099003|261021121427099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: udvyRtvYXQjPCLkvgbYaGEBKu7NDhueTPq/fjcPPSpRgFA4LNb+UTRxRug99DBEfhkEUtQg58y4fnDAAgQB8Acy/gt3Q6moPasYhV9eC6NVWAHOMH1+5+QgLkXVIiglvKeENogS3c4Z0URC6hjhU0qPlcvV8lF1r4khTFmoMx97oNFPlg6cbv1rn6bRLlp50wRi0UuRZK6QwsPz6uolG8LKHgtkeKnRZpb3Cr4x5E1veM6Z0xdxIoX0v6g8ym/S62EtIJZ2K5lWg9cIbrpyYy681VLpwqKSFWcxG1P1hVF6+89QPDM1zFab43adbfZ3MWRrOVrOQPG59AnqMp/nH8HNI/oA3/nwt6AH0REIB4zALcFwB5AuMTrvjgxIdwr+CWLDfODekThrEP7nepXTbzeaGH/l1eZdJYIs/timqNtX3R/PdDhs2pBTXDonieTkW7oMx4htMTj1YtYi6yLaOheWhH/ibYglCoXVr6Q3l0HZn1sV1BDH3k17vwOa6AbJCuF+/oRGZAcr/UhlauVK9bGQHV3kJkvxIlOdWBjXU03ZYjbZvo6RtMaPYooJD0maAIulVP3WMszzjzy8uG8YrX5aJl20FRC1fnXSoMf9ecEiexncLc1KE86avAzzPwbjg2D5mKwgha2emga9WWXojltnd0OTccIYNWonXtu/82mTHVYTkUe8EYTbjdxJllGF1NKBxkwrk3GLSKQc1/YopkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(261022105027099003)(56012099006)(11063799006)(5023799004)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kTDAA82jVxok9YRDjv600GfOASMSmrYx7xdC18r3wb0zoiEtdXLJ881eVsVXWh/ej/H9zX/eTWCxbgLDlmPvB0RkNSK478CqV+YN7vS5s9oEEqUDhdvzRp8wwSzCkbnPXQ9DJJ7+VCCCd9ktk0RtOXffYHcqDXHz05DvMSUGSwdkB2Uj8Fb49TkzUUtKWyMuWEVF2LenGSrkf79YxuyywbN6P650O/ASNXuxYYl7qpHVkFtFhLI8VT4FOclFpJ24eTV1MT1UXN8FlkQwnuaXEie/NID3cldjVz9CfgINHox3Ln0Ekz6qtuj680do4uRe+CjR1k6WE6pgDd4koobIJ9fo35G71rm8Hcvqg17mH2y1yAn+4ngqwh99krGCKuy5+MP9VTJL1vo8sAlb6HPQC5QwyDDdomNxOugiWa66Hh7jIxsdStqtIzqGwJvsAS8p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 06:30:34.3074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a57dd6-7641-4db7-4a0a-08df30cf24cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE94F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ring test writes 0xCAFEDEAD to SCRATCH_REG0 through MMIO, rings the
doorbell for the CP to write 0xDEADBEEF with SET_UCONFIG_REG, and polls
for the new value.

Nothing orders the posted MMIO write against the CP's write: the
doorbell reaches the CP on another path. With coarse grain clock gating,
a GC register access from the host takes about 2 us, and an awake CP can
execute the packet before the 0xCAFEDEAD write lands. The test then
reads 0xCAFEDEAD forever and fails, although the ring consumed the
packet (rptr == wptr).

On Navi48, 39 of 10000 back-to-back compute ring tests failed this way.
None failed when a GC register was read back after the write, or with
CGCG disabled.

Ring tests run on every queue, pipe and IP reset, and a false failure
there escalates the recovery to a full GPU reset.

Read the scratch register back before ringing the doorbell, as
commit 3f69d5860f5b ("drm/amdgpu: Add a read to GFX v9.4.3 ring test")
does for a similar race on gfx 9.4.3 with multiple XCCs.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d334fb805020..184e009c8e50 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -458,6 +458,11 @@ static int gfx_v12_0_ring_test_ring(struct amdgpu_ring *ring)
 	int r;
 
 	WREG32(scratch, 0xCAFEDEAD);
+	/*
+	 * Read the value back so the posted write reaches the register before
+	 * the CP writes the test value; otherwise it can overwrite the result.
+	 */
+	RREG32(scratch);
 	r = amdgpu_ring_alloc(ring, 5);
 	if (r) {
 		drm_err(adev_to_drm(adev),
-- 
2.50.1

