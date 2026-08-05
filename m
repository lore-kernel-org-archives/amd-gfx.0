Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12231C55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 13:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D7EF10E223;
	Wed,  5 Aug 2026 13:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SQLVhb5b";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F72910E223
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 13:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZO/0IQB7pi5iHFTVnc82BLgGp4SHmYo1/m7v4Lso5t8t5/lDA1XwtPfAgkK9J8zrEduT4o85YEPiF1dsSjDlj54TnRoIVAV9OM+TxsEH/MYFvxN3VXDhT9FKfs+KejvIvsR9n2rqs1y6lwJCIBRGPTCHJWPbLAUsa3HiiCaLbeM7uKSfw1oYEMIwGKqh2RU+ExJezoWFEJAwXmIqJi8vTexq/GHb3zSkbxN9ccPuntCzvOMarLvsLLKMbMnKVXLrokSH+Xn4TYBKjZUSDTq+cIZs55Z09JRxyZvOJkBvhc0FAWfQ10fMe8mYwPqLlmsK47jqfMrDg7VRRGwTVyxc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMahe0641l5Sn9tRP0VKjipoqun8HNc+ywkceCEZUmI=;
 b=Us1vtgacaxvOVQuIqb2GLmxnDHWp+HWhKAfsBn+0Rd4Hy5Elxe/DGCHA/uP8yVeoc+8xA6XCMKd09/WeNMQjaqhLakZxfop+pYi2xVS4ELJxfy17vt/DB++pTDdkrNn1Ck+fmpi//DTrpGaNj95dhohDj0sZ/vFcg88k7QZ7VZiTJHXbaV1MUlFl0/D4qRbchP9HwJCghDUz7xfCm/qxDDTIo2+2f+x2OEQXGYvGDxEG+16P4qqoX591XZf7/LVnTeFh0E5cQTp+V0ccnJWZW/LZecky60kVtdsp4hS9MnOVhJC6txYS2eVCuMa10oIPo+pmcHQJKKxPoGDpRxqgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMahe0641l5Sn9tRP0VKjipoqun8HNc+ywkceCEZUmI=;
 b=SQLVhb5bPsyi4+7WhrGN4/NP6bOZ/HeJ3gd+1IXU432nAQQduhx0OmFAIf+PLESs79PnSEhT0ST0C4CCx2LQm60r1/MsuQy5Ehre54hQUgNL+NTRTkyLfRaQ1HHxE+kNN1vXyPbaI10X9vmIHg5f9wKyi9efffy5SphSXnpDSGA=
Received: from DS7PR03CA0140.namprd03.prod.outlook.com (2603:10b6:5:3b4::25)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 13:33:03 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::9d) by DS7PR03CA0140.outlook.office365.com
 (2603:10b6:5:3b4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 13:33:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 5 Aug 2026 13:33:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 08:32:57 -0500
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 06:31:43 -0700
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH] drm/amdkfd: Avoid integer underflow in EOP ring size
 calculation.
Date: Wed, 5 Aug 2026 09:31:31 -0400
Message-ID: <20260805133131.608299-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: b662bdc9-1173-4917-9fb0-08def2f61352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: HWHyP4uI5vw5FMPqCCj9LREBHGE1PIEWOp288gRawX15RO/QMn6lsq/yqHyxNCbspe9i4TE+xHwvTD8V6HwTwCDfuBYVEFSMK1+OSu9WtnGvP83oELaCIrWzlpCCi0lP3zG2+zgPKYTj5UjX9ZTPc4iviQmWgpOcJz94E4C+9npG8kqCW/+IGPgDPL7fGpuFuPIxEzaZcX0wR8M2H4J/eu/ecmuKXsUbdkVgXMYS3WSUIUjuMONO0v/B6rHnCbjZxZdH2ewE5qLqaZmfOolUfD6PVJkGczm5+zNjuagFVFVBwIk+98Oh++uvQzeDxNlTlgYXpBaF75BJ6i7mDoU3rK02e7t56U8h2Nnoeayh1cuAwM/9wM0GhN33EPNIYlxeYJxw5hXmsb2CkeAhtaSU/6uLN/ZBsO6U9DmqAAA1S6b8VLAjEZfxFlQzD2vgZr+Xf5RwSCXGjszj7ob1UWhu++Xzd/XF2Qtlc7DuqCcGxmujXCdFu6uV5AlkV+1+j1DVvXU4EIjpJPHV2nr/5n5OcVFbkCpwxy4BmFn+CNQ6tdhG3ch7qnNmfcjPeAh5f7OxXUxJbcO1WQze0Qk8KIfwNv4tisDszg80I1nPlyG0ekm5vc2Krue8pXGTvGo2a6SCy7xTwtofgp5N8yGoI7dcAteBYOeuzZAYDoKEBtfWeJDWTSboAxZSUzBsszERMFWVYHHiwYxaRs/jQBSxb6HTIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WA58gnxtzYhMzds42SID9ePp5gEJrVYWcN7C9qsJ6qV4071VSnSf66wCbu70WuRWKOy9I2JzkkvvB6T2q+mxxzxZDYuZKLw7Kp9MZefJpAUA5rY0bt7MH1zx7CYHUrbfirYmRsH0mki6kXSq6CqOWC1Zzr+1p0W3yGEVTX7SX+7CeOVOCv+JSm24aKSxzsj4ByA4YNWg4hiGsyTWaW917SxOl/GsuH8n1nugToIcM50cukbKWmeWls2gXv7AQT/iNQblicsc0RuRKSrxkYNl7nTBFBBiGWqmUx1lUEDFetkY+u28gdxzVG6ol8UpAL5S5OwNI10gnmNlRmgCGD1vkrdrHWm6jULANWq9sXOGTLa7eaZiVqsTdQglxB15CEb/iVm+lib/kZG7KSisvD7oF20+ABnd5LadjRqiHC22aOX3CGTwiOTqlgjTHSqYHcV6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 13:33:03.2641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b662bdc9-1173-4917-9fb0-08def2f61352
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784
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

The low 6 bits of cp_hqd_eop_control store the base-2 logarithm
of the EOP ring size. This was calculated as

order_base_2(q->eop_ring_buffer_size / 4) - 1

But order_base_2 can in theory return 0, so this could underflow
(although in practice the ring buffer size cannot be less than 4096).

Change this to

order_base_2(q->eop_ring_buffer_size / 8)

using properties of logarithms.

Also add to the above comment to make the mathematics more clear.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 6 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 75e5a9f67d50..2c0d501bf527 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -285,6 +285,10 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 		1 << CP_HQD_IB_CONTROL__IB_EXE_DISABLE__SHIFT;
 
 	/*
+	 * The lowest 6 bits of eop_control store the EOP ring size. If
+	 * their value is X, the ring size is 2^(X + 1) dwords, or
+	 * 2^(X + 3) bytes.
+	 *
 	 * HW does not clamp this field correctly. Maximum EOP queue size
 	 * is constrained by per-SE EOP done signal count, which is 8-bit.
 	 * Limit is 0xFF EOP entries (= 0x7F8 dwords). CP will not submit
@@ -296,7 +300,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	 *
 	 */
 	m->cp_hqd_eop_control = q->eop_ring_buffer_size ?
-		min(0xA, order_base_2(q->eop_ring_buffer_size / 4) - 1) : 0;
+		min(0xA, order_base_2(q->eop_ring_buffer_size / 8)) : 0;
 
 	m->cp_hqd_eop_base_addr_lo =
 			lower_32_bits(q->eop_ring_buffer_address >> 8);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 60b87a500698..029572548c14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -208,6 +208,9 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 			mtype << CP_HQD_IB_CONTROL__MTYPE__SHIFT;
 
 	/*
+	 * The lowest 6 bits of eop_control store the EOP ring size. If
+	 * their value is X, the ring size is 2^(X + 1) dwords, or
+	 * 2^(X + 3) bytes.
 	 * HW does not clamp this field correctly. Maximum EOP queue size
 	 * is constrained by per-SE EOP done signal count, which is 8-bit.
 	 * Limit is 0xFF EOP entries (= 0x7F8 dwords). CP will not submit
@@ -215,7 +218,7 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 	 * is safe, giving a maximum field value of 0xA.
 	 */
 	m->cp_hqd_eop_control |= q->eop_ring_buffer_size ? min(0xA,
-		order_base_2(q->eop_ring_buffer_size / 4) - 1) : 0;
+		order_base_2(q->eop_ring_buffer_size / 8)) : 0;
 	m->cp_hqd_eop_base_addr_lo =
 			lower_32_bits(q->eop_ring_buffer_address >> 8);
 	m->cp_hqd_eop_base_addr_hi =
-- 
2.34.1

