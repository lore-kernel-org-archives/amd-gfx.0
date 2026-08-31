Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DECC624D3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 190D610EA69;
	Mon, 31 Aug 2026 18:29:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ibxIVmKs";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E19110EA67
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRt8vVN3GWfuAHln4Q50tKK2BkCRNQgrVmJ4sQMd6WeWU6d0RLLAKu1QPQsd4pgGuabRmOfzFznyT0K/DfnNAjTHz3OAyOZ8i/56wZ+WZFfXar5SZc8JCIKVMLh4k5XGxcTzeBXkRs4gdDFBYROym+WuNK13LqbqUyIbwzv2jKN6LAphnnGeTWIGaRo+Eux4SDy2GD65loz1RGpKdbm2EBvRG6cRv9WFvtE0saRU/EHyYF5ZJdEoDrR5wPsuHbwypAgLZwZQWnFPZDfXhPYfPG/Kv5Ew6PU8bArLZJeXlSo/eEtjrMy4IWye3GBAbM5ZlvuymmizgbmL1B54yNguYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvN3PqeuvvTTUmDO+qexio6gEHQMwrlnqJhPzJDs/38=;
 b=Phrkp5G8YgAhbhKGf2mvt0yEY+dOsoX5zKKWRi2BtwWNiN+p4TEmCEeAgHIHqPeqyCZQfdi/NmKhHh1JWSMlzmHUvc7b6+AM8efNfxdVzIkl/z1EUAnglxoliHjzoxiCNceYutB/Vd/CElcfE3+XQVCnqPnTqh+ReswOj9wt8xpHYcbQDSsStMi42Kru/4a5ATCrnhejtPZO24HOY068joZt9dt05zt/wonIMNHS1QJYVjWWLL8oi42z4LdJmW/DFXgFSzzLDNB32/esfEBM34VPldjkWbuydi9fLQM3DEztWtnRttT9jSvbuXTQkYrxAiJpxp3M/usbYQixmBI5EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvN3PqeuvvTTUmDO+qexio6gEHQMwrlnqJhPzJDs/38=;
 b=ibxIVmKs6XoghKEkeTySAfJzzerxJUBTw6DkfgJ40z6sBhrcR+Z7k/Es6p7ysqHqkJXyus3dGyshVCn27hutNpMsRNIh0o28QQ2TTdmKcSAqsYEtJE0BVeoScrkimXyP8U1ELk7NZQMDeMMJsnOBQeN+KoYXQiDtUx3B3I2FHsU=
Received: from CH0PR04CA0116.namprd04.prod.outlook.com (2603:10b6:610:75::31)
 by PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:00 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::33) by CH0PR04CA0116.outlook.office365.com
 (2603:10b6:610:75::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:44 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 59/95] drm/amdgpu: Add debugfs to drop UALink protocol messages
Date: Mon, 31 Aug 2026 14:27:18 -0400
Message-ID: <20260831182754.1089811-60-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 7efda0e3-cd23-4198-d6df-08df078db9c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|6133799003|22082099003|18002099003|56012099006|3023799007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: Iz6/DsRHCKNSkyJ5zS3Nh4fGYR7vVFYy4303L8mkDKqs4rYdAXw9EgryDj5X3eiw4JuScmrovjkPAb1oRaCA8o9m9i56PKlNfM0IEhiiA1uYuSrjaPw54kp91gAlN1kWh22Us9Gc81GU2UYM0T8TAijACgh6ADoiBRbMqTCVJ9eiAxu8bTDunUuTM508RBJYGYY/AQa3LYVlHbqbOqa94MFvkbO4kuNFXIQvLxUi/W7cKbULzLsBA/Sla/AzEODXo1AqNWih3Zg7fXRlawVdYKzlMQebWA0wB9t2id34MLp+o7qu0pb/QF32UsUexVtVCv8rcAALDOmwDhrouNl0AvTagDr2OrIHp+vvoKm7XntOqCREFJAm6e8T5yTUzILL+tMRZLIKA9HTM8t4kp8RwAiLJ3+BcJiiTLmZtP4+n0Hmunt7/m7DvM1rlOQ7Tvmsm/XmSfb5GnSMGPqIaJqWEXNu9a5FBYnwIplhZeR8fopObWk6jAKg2iwvJByfkM29MTyqv7ws1EgXWTCC0zTAQq6hpSZiL5T8NlTxtaStCk+GT6rOyCBdWGsYHslTmTfyZdxeDHOpVTbqhq9ee9tyU6hlU3aSeSu0ctVVCDpapv+AO7uW0S21uvVOaSWo4YsGAEuYS/dwV03hLPe1wTmGc1/g8iV+ZwRVelmjCOIcv1aH5DQoFsdd6aXYqWIueqA7h/VMEASawMtgU2E+u02GvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: chtarZZ0LuVhuMTHR5seO3pOfA5IsIq3i2eKtjU3AIFyivrnOrh5K5cAI/frA61eMp0bPAarrrP5Kb87Ls28RVtlApsWKClT4CsYlA4U8fKF9S1zmTRAjNm+rkJjr7XlSVDdC7I6Cm+ucot/Dm6L4LycdQz/MftJhlAioAwvJ+WN83Ho7wMs6+cLI1uqm6ap8DTyK60Togd3uYzW66rSsPR+PMR9t1AUsR6GAjgfCqhADGVyFPJTnB+OZqdkNZrRzClpSmurnh2xaFo+d5/7Vv3CW5oOm3f9cAOiffFFR9WCGRb6flNUHB5WWuJAmGFN3cNFZIFHMW2Zk4qK4g8zibt8YEDgzsUWae/Uk1BvVc5CUQvqRI0mVGkb7r4HUXgirAfWdmXddFJQewSTeNU17cCfSF9/lej7dj7nn2VB3X0W0BuMAn1wWN9sUy879CXD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:59.8062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7efda0e3-cd23-4198-d6df-08df078db9c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841
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

Introduce a debugfs-controlled bitmap, amdgpu_ualink_drop_msg_bitmap,
where each bit corresponds to a value from
enum AMDGPU_UALINK_PROTOCOL_MESSAGES (e.g. NPA-REQ, NPA-RSP, NPA-FAIL,
NPA-REVOKE, NPA-RELEASE).

When a bit is set, the next incoming message of that type is dropped
in amdgpu_ualink_process_irq() and the bit is atomically cleared via
test_and_clear_bit(), so subsequent incoming messages are processed
normally. This allows exercising the UALink connection reset and
recovery paths (NPA-RSP timeout on the importer, retransmit/teardown
on the exporter, etc.) by injecting a single packet loss from
userspace, e.g.:

    # drop one NPA-REQ
    echo 0x08 > /sys/kernel/debug/dri/0/amdgpu_ualink_drop_msg_bitmap
    # drop one NPA-RSP
    echo 0x10 > /sys/kernel/debug/dri/0/amdgpu_ualink_drop_msg_bitmap

The bitmap lives in struct amdgpu_ualink_mgr and is exposed via
debugfs_create_ulong() next to the existing amdgpu_ualink_test entry.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c  | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h  | 16 ++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 132d054900b5b..d80fe17556dab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2229,6 +2229,20 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_file("amdgpu_benchmark", 0200, root, adev,
 			    &amdgpu_benchmark_fops);
 
+	/* Debug-only: bitmap of incoming UALink protocol messages to drop.
+	 * Each bit position corresponds to an enum AMDGPU_UALINK_PROTOCOL_MESSAGES
+	 * value. Setting a bit causes exactly one matching incoming packet to be
+	 * dropped, after which the bit auto-clears and traffic resumes. Used to
+	 * exercise the connection reset paths.
+	 *
+	 * Examples (drop one NPA-REQ):
+	 *   echo 0x8  > /sys/kernel/debug/dri/0/amdgpu_ualink_drop_msg_bitmap
+	 * (drop one NPA-RSP):
+	 *   echo 0x10 > /sys/kernel/debug/dri/0/amdgpu_ualink_drop_msg_bitmap
+	 */
+	debugfs_create_ulong("amdgpu_ualink_drop_msg_bitmap", 0600, root,
+			     &adev->ualink.drop_msg_bitmap);
+
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
 	debugfs_create_blob("amdgpu_vbios", 0444, root,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index e21c48212f0a4..4e49ff0be6e35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5394,6 +5394,19 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 	dev_dbg(adev->dev, "Got MSG: remote acc_id %u msg_type %u\n",
 		src_acc_id, msg_type);
 
+	/* Debug hook: if the bit corresponding to this msg_type is set in
+	 * drop_msg_bitmap, drop this single packet and clear the bit so that
+	 * any subsequent incoming messages are processed normally. Used to
+	 * exercise the connection reset/recovery paths via debugfs.
+	 */
+	if (msg_type < BITS_PER_LONG &&
+	    test_and_clear_bit(msg_type, &adev->ualink.drop_msg_bitmap)) {
+		dev_warn(adev->dev,
+			 "DROP MSG (debugfs): src acc_id %u msg_type %u dw[0-3] 0x%x 0x%x 0x%x 0x%x\n",
+			 src_acc_id, msg_type, dw0, dw1, dw2, dw3);
+		return handled;
+	}
+
 	switch (msg_type) {
 	case AMDGPU_UALINK_HELLO_MSG:
 		receiver_acc_id = (dw0 >> AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT) &
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index fa116ef44cb50..d4d4ca0199dc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -342,6 +342,22 @@ struct amdgpu_ualink_mgr {
 
 	/* Sequence number to track the need for TLB flushes */
 	atomic64_t last_flushed_tlb_seq;
+
+	/* Debug-only: bitmap of incoming UALink protocol messages to drop.
+	 *
+	 * Each bit position corresponds to a value from
+	 * enum AMDGPU_UALINK_PROTOCOL_MESSAGES:
+	 *   BIT(AMDGPU_UALINK_NPA_REQ_MSG) drops one incoming NPA-REQ.
+	 *   BIT(AMDGPU_UALINK_NPA_RSP_MSG) drops one incoming NPA-RSP.
+	 *
+	 *   On reception of a message whose corresponding bit is set, the bit
+	 *   is atomically cleared and the message is silently dropped. This
+	 *   means at most one packet per set bit is dropped; any further
+	 *   incoming packets of the same type are processed normally. This is
+	 *   intended to exercise the connection reset / recovery paths from a
+	 *   debugfs handle.
+	 */
+	unsigned long drop_msg_bitmap;
 };
 
 int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev);
-- 
2.55.0

