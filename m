Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F3B606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=e6hPFSvC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C0B10E088;
	Wed, 21 Oct 2026 19:58:15 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3912510E088
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 19:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9/Koy3uB/3LRa6nKNDQUgOO+GMB2loUqZWHNLQr/h1l3S7K5ftDjfl/c68VM8JSomRcRVdqm7ZU9v6eBRTKN4/zXshaFp9EPeQ7TVDsUHi/cFAQzf7nVb0k2BGpNUylptavZcDdETmwNGIBdoRibg3SQrQz82AOJP06SbG8VAXJLiPiLik4Yrl7UWqHjGYMXAeJfZmQ1zml2dmrIJB0T+2n8HfI6R1+Bu1OaAY2gbUqdhksDf7VGTThjrWckih/G4DIq4DtR4KthOePTcDVlKnrPM3C0AUMfe9dTXw3VshQ7bu6F+U9gsn/bkSn3Tvt25Z4M0jtCaRFSL3cugtcNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmPW9gxDCjI4sAvYLPXt35tK5nVM6FfiVlq4tYNLckA=;
 b=pk9OmnVML+8tR3lKR9u0k9wWtnPKZr7/vrVyYh7kvCGGuStN2q2D7WJmKQwSDDDoziZHBkJbwZwLBcw3v8jH0PoSOperZU4g1uJrfdlwxSwx8kuai7fkltsLcYrCkUpitQ6haRCtyV8JC6omtKErijwHkpUQfoY3k95trZHkJB14rspMKs7hWcT7qC+JfBo4FaBd+k3J4hkrC4RNglzBYqGjqCXnPKXShIyrTpUvnsKoASkZjnqH/TkJgV/9xQCW09Bpa79sXsr3QviyCYdzMVXwjaOmQyQXgdlljvYPzMeocdYRatAYy1b3+RJ4cT0kshU+svwzsH13g/W5dLIAKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmPW9gxDCjI4sAvYLPXt35tK5nVM6FfiVlq4tYNLckA=;
 b=e6hPFSvCQiv6HsYBRecLQQrUjhRtU72gcvytBzYxt+yc+ZhTkoyUG/iz+iuIgyyexj5HSBCyREikuFWRybeeT3Bf4krwkbdlJT8iHmrMcIjzhp5wgGeKUDHlvwz5I+fPCUuRcTCWWsU0jUqN95XKSZL7i+fOZG8xOayb7bahoUg=
Received: from DS7PR05CA0034.namprd05.prod.outlook.com (2603:10b6:8:2f::35) by
 MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 19:58:05 +0000
Received: from CH2PEPF000166C9.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::3a) by DS7PR05CA0034.outlook.office365.com
 (2603:10b6:8:2f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 19:58:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166C9.mail.protection.outlook.com (10.167.244.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 19:58:05 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 14:58:04 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Lijo.Lazar@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdgpu: only tear down an active UALink accelerator
Date: Wed, 21 Oct 2026 15:57:46 -0400
Message-ID: <20261021195747.1119608-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C9:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b5d8bf-cbdf-45ec-a115-08df2fad9ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|261021123027099003|56012099006|11063799006|261009223027099003|18002099003|10067099003|6133799003|261021121427099003;
X-Microsoft-Antispam-Message-Info: MafLpN+W/EJkhlO5QNmQT9F1vXZEPCVeZi1f4bhDajQBT3gH9XVHETWexUIyIq1/uIuXD+f0n5zW5rJIDvkL4DvdwgYfYaWf3RikTSiKJYw+kyfBQuQ7YsMxpu7huUywVAS6/0VTxmQfFAm89vXYqeuepostzsX+nQdkVSDkxPc0K9hJmSYp8L44Ot2oeqHLonnXRJ3DAtAt2JH0a+wTMcG7cLBEcexkUqg09R5Ry83YBmgwRBKZbHRFF84pxeCbfWNqQSh4BvuIeol84wMlCtC6n0O236T+03qMtgjOkyU8i58BNyfAo+aNegJRc2zVvSnFC5ectM3cafmb3BS9GpKX+ayZnoYlIHVcnErqerKY9CL46mCy3lzWyT9SAugV3S6gf7/LaEs8RmJ2rXPA+hkPJTMR3WQhN0p27Q1WUhZEv2gHVRRkclhYmNk9R277AJ9G0h2JHSFeRoYWMOyyNYOx40Ud+f+sYGh8fsivonlSjp966XfG6nauqr421WgptxqEKdEva7FxYOgsQh7u2MMH1fEeoHuJq7ABh9KVX8FvT+y1koZ/G6ykoR5MEq8tB8NASXIAJRsgntLEKzAdtvaXfKkweJeISo5SPKLSdozcdnujAwbPXZWsH8d0F+8AkdL1YnIorGwtUqLv2k871/loqb5ShDzGoLyI0yPwwMz4dgz4HKuLMue7hZFYBTpxaiGcgAGYMb56P5/ZAkiiDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(261021123027099003)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(6133799003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SQp0rlNep8m0r2Bk1H1vsKnGaWxt03C4Job142OVkF6lyjI4pFc++Y1KvxPtgES9TAo9pHaUB0ftXq94Gaat1WF3ANBSmYe9RJhkccqGloEk+//Ov2RivJOaspPj+m7piHqUYzmecqhMNqcD/HRbpB9ld37BG6wAdkYvhvGoCGDH0LDai6pw2bfImix9fYEMR1BIbuR+2IZQdy8AtP0N066M0ceEe0gJKQ+kzGsA0ZnAD//koRbaVVQ2FVrsFuKv4LObixUzR/1wXg30Dl6OPoWNsdepdt8HtX3CNQUICLRTlyuDvwN7txy76zMUOHDFHJOB57EUnF9P1WAsVMIiXdAH2pAlkgJx6eK0aXcatpdk/lauVFTclLxIWhJiFa9dFu6l2aOflYpEXr4lOvf0M9J3ezGjZ5+oeIdF116h8352b1X5FwWgurzFk7bzPZUg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 19:58:05.0151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b5d8bf-cbdf-45ec-a115-08df2fad9ed8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
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

AMDGPU_UALINK_ACCEL_STATE_ERROR is ordered after ACTIVE, so the
"state < ACTIVE" check in deactivate_accelerator() lets an accelerator
in the error state through to the full teardown. The NPA VM and
workqueue are only created when the accelerator is activated, and an
accelerator in the error state either never got there (invalid pPod or
vPod configuration) or was already deactivated on the config update
error path.

Tearing it down again calls destroy_workqueue() on a NULL or freed
npa_wq and amdgpu_vm_fini() on an uninitialized or freed NPA VM. This
is reachable from driver unload (hw_fini), a later failing config
update, removal from the vPod and a pPod setup commit.

Only deactivate an accelerator that is actually active.

Fixes: ccd7fa696b74 ("drm/amdgpu: Assign accel state based on ASP config")
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 8d81efb28774..6ba745f37540 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1345,7 +1345,7 @@ static void activate_accelerator(struct amdgpu_device *adev)
 
 static void deactivate_accelerator(struct amdgpu_device *adev)
 {
-	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
+	if (adev->ualink.info->accel_state != AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
 		return;
 
 	dev_info(adev->dev,
-- 
2.55.0

