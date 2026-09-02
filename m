Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42587C624D3
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AED9310E4E3;
	Wed,  2 Sep 2026 12:50:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xxHDvEn1";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29B7310E3FA
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aL0nsNt0egDFE0fwG5lHKOkxi+IpDs54Yameumf6yU8kCABlJksdQd2mIhnMPy68JEnX60VbEpqD48LeQPF2QaxBuR8Pl6PwQNF4+Slx86hYHfar5FnNkHYGQzaZbLki9QsJHQrPD1P8X86NWavsejrG69UFyLMqSkrE7xsuFse2jWxMOorpxTQAQsJbUQJseH5xzfy/uw3/fR5qAeNrOzOi8URU9kTxxhc84W21s3ouMQrJqpzEfi/oi/bv4MQ4oz0ZT3+TJwJHnbl9jywTUeGVLXx9Jkl7yy1ohk7uZQ1ioEAwc/ZMicHOd1Poqy3tCbIE8i6k9+hXN36WPJ1N5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcUPKBMQwVCSyddVYjIBvMlCeXMjW7UwiC5pZgKV/bs=;
 b=v02t9SeXQGHrKz299XaDSdbH2IQ2Wj3IoBlNvs8CHURaglRbXMaEl8PM7gjkXZjP/3zlMfqzAup4Mb9Rci//PCyOPJaf5Ij7LRpAxWZc90wcVqNaIDobbVjaWGCX64FjM0/bxTcZ/90sMicGZA1D5+RGOjmrO01/S6emhln8bfP59GQyohF7Nm1fEGCRkuvCn3Fmd+V+ET9fQF468aKdu1VyvHWi7LoSKRUY1KbdtlGAACiGQOTnn3gtUkmdR2P4Pam0BrzOAkCBfhPkKeDT8UvkuiOFRPoJFvdsB0rkuC85+bebH9X2hloI7zBEAsUkZh8p/4du7pqBF1L2BrgrPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcUPKBMQwVCSyddVYjIBvMlCeXMjW7UwiC5pZgKV/bs=;
 b=xxHDvEn1HgxNsX45opDXQ0ZD39geWh65z6aDMXO2tlXMbN2ZAnbtKLNEwfKPz2E7DZ8/nf6fIcOHo3dejnokgwMybaXfUNG7fXzyxUuqccmGSIUaCvqtc0u1p9xCNZF11oqhwBBW97dqkfpow2OviGnj+bN905Arzk4uKbW4IWE=
Received: from SJ0PR03CA0207.namprd03.prod.outlook.com (2603:10b6:a03:2ef::32)
 by MW4PR12MB6681.namprd12.prod.outlook.com (2603:10b6:303:1e1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Wed, 2 Sep
 2026 12:50:23 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::8f) by SJ0PR03CA0207.outlook.office365.com
 (2603:10b6:a03:2ef::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 12:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:22 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:11 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 02/18] drm/amdgpu: clean up the userq support redundant check
Date: Wed, 2 Sep 2026 20:49:45 +0800
Message-ID: <20260902125001.621629-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902125001.621629-1-Prike.Liang@amd.com>
References: <20260902125001.621629-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|MW4PR12MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf4388a-b9bd-49b9-1346-08df08f0c055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|10067099003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: /lS1TfdyD30c7t4VBVv3ScCdoYQaYH1uDihV0KUXd3NxiHTULZEK2biH6b4FX8Cw3mSiMV7hKVIzeE9Da8OTfoac+no5QZTc/Bwo8Iwj/jw8jL+pHkPLEeoJqd7KFNe2yKeOeTrmXGFskHjPomf+pAsP35dwd+axoPpP6V0K5eQknVpjAqY6fwdxqeyXGRWXqtYybvmCOcoR+eQyD+LG9Wnd5W/j2mNVHPzJo+3U2HEeasn1YhRudpAzuNRng2B2yHbs1PFkfqiiMUuTFtZzizMSk6Fo3jyQMdkzgAytxvGQk0yTcfcDW5SgcVjDI0U3PffyV7fmcb1/k9p0eY3v0y9QVD0o//deNMoEojWapJDZRun4eOnZcPN4WIiYzazOiGyRQOGybZcVvXgv+m+45FjMkhbFbNhLy3EKcUsnKP51ebqPf+49YIF4O1qt/cjjVPaam5YvxO0iTNDkCq8ft6p2toTEFP/QB1GE7SbtoNAfuQ//Nto4VTuneNIYov6q9Z52pADG436OoS/R5vDoFGp3XE+CPIMuDnE3xoaNtOORjccGZ0peYvLYzD++wOGlQhZOFA0/rvvKjFJUUZNX/m2JS7THcYGFWs63UOm1cghjOGpIIGg1UCPdW1B/nIjck1U0pPRIGDeEwa0E/UmWEcRGOwQLKHfspgQ8TxlC9fqAFPB/HvxWohs/TmaxtLUAw9gN7iHHUhsu3/Bbz9oSRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(10067099003)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c3yIQCd9Yd6WeZVNrk027gSVxf9K9AyEsDdn2wuOOz5OXBj3x6NARN3Xeycgcl61hN3rj2ir9nnHhxRu+OWpqHNt3nk99otFDw2w0Z1HrLpNSSLiLbdtvug719rX0Yb8QlsUNMhu/vD2zD1eAi77cev1F52YN61/Bq8mnRq36jfV6uc+I5kNIZgwZe160tY1LbUvUNcDgM+Gjxkn9xDQzW+POZ4F5YCCSclz3chbBdlMj29uaygd7EgCgB41fAJ0oNDrivAkIPTxIDIbT2VfL//nyAyQD0kZAmQiHWpbvjro9c7un22azQQAZZPRaZKCsvLTHX7AadR2ilNwewMcqNC3Sh2RpjQh76G4xeDqC6wnDr/6bWh5IJQDl4X4D/m4izGTxSSJOL+99YR1D7/6ldSoTM1kNsDkIasSq5KVDUFDUIUCrFhUczhf8Rlc51l6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:22.0591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf4388a-b9bd-49b9-1346-08df08f0c055
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6681
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the userq doesn't support in a system. then there's no
valid userq_doorbell_xa entry to walk over and then has a
no-op.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0a816b3c5ff9..ed329041a648 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1373,15 +1373,11 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 int amdgpu_userq_suspend(struct amdgpu_device *adev)
 {
-	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm;
 	unsigned long queue_id;
 	int r;
 
-	if (!ip_mask)
-		return 0;
-
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
 		uqm = queue->userq_mgr;
 		cancel_delayed_work_sync(&uqm->resume_work);
@@ -1398,15 +1394,11 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 
 int amdgpu_userq_resume(struct amdgpu_device *adev)
 {
-	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm;
 	unsigned long queue_id;
 	int r;
 
-	if (!ip_mask)
-		return 0;
-
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
 		uqm = queue->userq_mgr;
 		guard(mutex)(&uqm->userq_mutex);
-- 
2.34.1

