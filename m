Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE89C624D4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 658A410EA98;
	Mon, 31 Aug 2026 18:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VrDcvYwk";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013013.outbound.protection.outlook.com
 [40.93.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F6F210EA67
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CITR2FLTpuPtLPxAX7ACS2mVL4HjaRRA9AqsIur6mH7Tny3CqDGV9IOATCO+ZGgi2PaC3sFW9IONT965pwje8hzZ2WGLyZNM9feQ2BYQPqOIB+vkONnSAUobqxwmHopzh+Ql5CGmKIkCAggPC+nyGEhw1agZNL90FLdlleMbfHOU1EzzdfjWHotGp0KUCoXNB1LnIiGrgyk2hB/AT90SrRm9Ug+bZ6zJMSy/IzB2nl0KJPH0IuWBCByO474g2CoNgmxKgPa6k/KoSNOp6moh91YWk1DglWPY8ixAaDkPXZpl45cOSW86El352xeXwnoVaS25yr4RROtajwwUHnLlgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNPsmBA4f00hsx3A5mgVZdcgZ4/+jHqFT8ok/+aUBuk=;
 b=DB/Vf1UOtp0sICXRzVtX93p36zIfZtkwqdI3CEoGz5uwVCNb5pRtB4jQYOO44Xmx7uBsNAnY8ltYyZmCgGEZ7sVFkMhUF2fh2Hj164PDwBtvIGXsJETR9GtuT2DYcdOv0hdVrwgDvhj2XIyFwR59W5QO+5gz63HI2bGI3dylqL+bZEL2kbEYdcYhY1aqfKnKg9ptV9Ny045vkVjYDOhlit498ZbQ565dat1rFLggpaUtMtxzvpzpflL6+VMftiry6LtO4GlTab/ZEn94yFNvd+wCTVKUE5l3xtqI5pJI/Ydum8mYOMvrA4WatCv91aQP+3ltFmijoILYHN44++drkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNPsmBA4f00hsx3A5mgVZdcgZ4/+jHqFT8ok/+aUBuk=;
 b=VrDcvYwkyToBUNsJau2Asvshcb8l/GhaGeu6tP3ZtaVmgvbttfgflJjWZTz8aPdJMWy/Of4aU3vEhC5+NKHXzy9405m0h7MrV1vR2ThtW2IibA3q9v+NNp8uKGAmvX7ElyP6+4LgQ4LjFwiGdE2XKelKun4kaakGMUTO2k8En7Q=
Received: from BN9PR03CA0687.namprd03.prod.outlook.com (2603:10b6:408:10e::32)
 by CY1PR12MB9675.namprd12.prod.outlook.com (2603:10b6:930:105::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:10 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::86) by BN9PR03CA0687.outlook.office365.com
 (2603:10b6:408:10e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:29:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 86/95] drm/amdgpu: Handle UALink vPod reconfiguration while
 ACTIVE
Date: Mon, 31 Aug 2026 14:27:45 -0400
Message-ID: <20260831182754.1089811-87-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CY1PR12MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b5803a-e958-44ae-c7f2-08df078dc00e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QxDk3MoLffoucH9R/hbiUX8MRgLsmP6NBHJvZeF6dJesdDp6Qfa8YJPmCLwu2MTYgAgJ3Jk7AX74GigUQ3WnKN28jGDJwGdIw1bSOOhXtJtMXSCJJJztDd67U5xHo9gYEel2fcGoGv60XIVt3Wga9KLwMsSgbJO02UFIM5nS6YezR9db1XBLTozgcjLAWQS2VAnrfA3Ypyf4Pr4JG+jD5zpQ1H+FT8jVwELIGniQNhpXAWA90uXNeRDBeSbr4vdOxy759buh2FSBWaE0VGRNdxbCkNBnQP1/obITJC6XRI2Kbc6evnCALIcKn6vInmBEeATA8hsAOA6XxQcRq/1FEWjgEIYpw8vqlRQI3gDSBoJx2rcfCcFdOGqH4N2aPxKUh4Tpl9RlkXsFErcLaJKSY18QPZKGv7+WFBEQnmSKNAkIGQQlDiElyjch3CEbxW4jk4GxkS/PWYooNzbORJC7uytknojLZNP/rkN5tYW+0I+fKFiqr7ESdFzADdatmDk3I3LSxHckAqifY24dBuHo//D74wreeyKX7HAmp8im3NZjt7tcwY/9V/L+YUZK4nRusW34YZ3Yh3fR3ELYJVAME5ZlPR5o9FFU75WQJ9puJLjlnu+0NNsB+DsuLZZnbNupn5VfPojEUHKKW4ixkJuJ8fOyYnLbBfqvfdt7d1pAtbB05ja04kXV8PZF83lXPzF4dPRzc7/HmfPKIRx/UUFIjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: boh3PVu3mpJxDNMs1/ylTxdqs6TH8JXMIGrUOOuRIElntDJE29L/qexjViwZQfI8LSELtMZ28+61G5rocn6oSTPUJjde632yCLgu/In201Opmra8ubzOcHQnCX8QbfwIu4PrHhoSXgdpS/Gr63VjSGfv8ETVGE9EjlcnAnuy363P7ZbiTJDUih2NrUEsTqK1ekoTfP5QItnFxEY1rs0K7g3KYP2WFfL/jexGrWtEZNolOrg7iZpkqfLdjX2fED5LDlIZ8ic7lWwe1mPan+iqZzH1tbfo6lWlbLRYEMd+zpC3IR3+stbhTvg1fiw/+qdN7aRzpNa1sG39mXor5K0/2m5F9R1tJfTGYvznKPnAl+EqAhSFgLZ5CodrORih+MAOrOfdlNZ8HH4xGf8JMx8ez1nhqTZjceGoQM/CXx8Kaj3jcJtpWgKxgyNwhGPzL2Hj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:10.3457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b5803a-e958-44ae-c7f2-08df078dc00e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9675
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

From: Mukul Joshi <mukul.joshi@amd.com>

An already-ACTIVE accelerator with an unchanged vpod_id skipped
re-activation, so growing or shrinking a live vPod left staying GPUs
with links/GART built for the old member set. Detect membership changes
(owned snapshot vs firmware read-back) and bounce affected ACTIVE peers
once the integrity check passes. Firmware requires a full metadata
reload while halted, so a full deactivate/activate is needed rather than
per-peer deltas.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 60 ++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 7a84d8ddbf867..7d2acf10123bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -54,6 +54,7 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
 					  u32 remote_accel_id, u64 addr,
 					  u32 size_in_pages, u32 flush_type);
 static void __amdgpu_ualink_activate_vpod_locked(struct amdgpu_device *adev);
+static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev);
 
 #define STRIP_NPA(addr)						\
 	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
@@ -257,9 +258,24 @@ static int amdgpu_ualink_update_accel_state(
 	 */
 	if (prev_state == AMDGPU_UALINK_ACCEL_STATE_ACTIVE &&
 	    adev->ualink.info->vpod.id == prev_vpod_id) {
-		dev_info(adev->dev,
-			 "UALINK: update_accel_state: already ACTIVE, vpod_id unchanged\n");
 		amdgpu_ualink_update_vpod_config(adev);
+
+		/* Same vpod_id, but the member set may have changed (vPod grown
+		 * or shrunk while this GPU stayed ACTIVE). If so, run the local
+		 * vpod activation path: once every local peer has committed the
+		 * new config (integrity passes), it bounces the affected ACTIVE
+		 * peers to rebuild links/GART for the new member set.
+		 */
+		if (amdgpu_ualink_vpod_membership_changed(adev)) {
+			dev_info(adev->dev,
+				 "UALINK: update_accel_state: ACTIVE vpod_id=%u membership changed, reconfiguring\n",
+				 adev->ualink.info->vpod.id);
+			scoped_guard(mutex, &mgpu_info.mutex)
+				__amdgpu_ualink_activate_vpod_locked(adev);
+		} else {
+			dev_info(adev->dev,
+				 "UALINK: update_accel_state: already ACTIVE, vpod_id/membership unchanged\n");
+		}
 		return 0;
 	}
 
@@ -993,7 +1009,24 @@ static void activate_local_vpod(struct amdgpu_device *adev)
 			/* info->local_accels is corrupted? */
 			continue;
 
-		activate_accelerator(peer_adev);
+		/* Bring the peer up to match the current vPod membership.
+		 *
+		 * A peer that is not yet ACTIVE (or whose ACTIVE membership
+		 * changed on a grow/shrink) has its remote metadata, links and
+		 * GART mappings built for a stale member set (or none at all).
+		 * Firmware only accepts a full metadata reload while halted, so
+		 * surgical per-peer deltas are not possible: fully bounce the
+		 * accelerator. deactivate_accelerator() is a no-op when the peer
+		 * is not ACTIVE, so this handles first-time bring-up too.
+		 * Unchanged ACTIVE peers are left untouched.
+		 */
+		if (amdgpu_ualink_vpod_membership_changed(peer_adev)) {
+			dev_info(peer_adev->dev,
+				 "UALINK: (re)configuring vpod for accel_id=%u\n",
+				 peer_adev->ualink.info->ppod.accel_id);
+			deactivate_accelerator(peer_adev);
+			activate_accelerator(peer_adev);
+		}
 	}
 }
 
@@ -3981,6 +4014,27 @@ static inline struct amdgpu_ualink_remote *to_remote(struct amdgpu_device *adev)
 	return adev->ualink.remote;
 }
 
+/*
+ * Returns true if the vPod membership most recently reported by firmware
+ * (info->vpod.active_accel_bits, read back via psp_ual_query_info() on the
+ * committing GPU) differs from the owned snapshot captured when this
+ * accelerator was last activated (remote->active_accel_bits). Used to
+ * decide whether an accelerator must be (re)built to match the new member
+ * set. A NULL remote means the accelerator has never been activated (no
+ * snapshot yet), which also counts as "changed" so it gets brought up.
+ */
+static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+
+	if (!remote)
+		return true;
+
+	return !bitmap_equal(remote->active_accel_bits,
+			     adev->ualink.info->vpod.active_accel_bits,
+			     AMDGPU_UALINK_ACCEL_MAX);
+}
+
 static inline u32 ualink_accel_id(struct amdgpu_device *adev)
 {
 	return adev->ualink.info->ppod.accel_id;
-- 
2.55.0

