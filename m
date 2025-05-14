Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3233EC3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 17:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9D7D10E6BF;
	Wed, 14 May 2025 17:23:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Stxw0doa";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FBAD10E6BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 17:23:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2EyIfxNo35tZ+lzK/pncQw9FAQh3frZvXS7NXZzysj9PF7cOHvgNOz+lGCbCjMbWkhCE1ahBc/INz2KIS8SQPj9dsxtJFgzolD9RweE5jm0SA8Qc5xr4E69+qbb9zmPeJhg4Tj6ZKd7ogNJQQ0Cb3lTg9jR/ICsRk9zMttqOIeSqcW1AJi5mgsyRtJM6L71jCyGuiFZL8MThlBrED4SnzEppomZ1Bc+p6ux6rTysc5w7Fbp6p2qQon8qOecq3nSGcOqNAtNpQpEnDrmNJDSoO/DrEqG02u0guFCLxNCBJn05lrXMF6/lr5Zk3fd702IUtiKRfku5RqAEV4aGgu45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vfncZHf0mrniYV5Z41gXO2bglQv3OQhPKHWkT5kfnI=;
 b=UO0S+6Rx6eVMaghXm6d17fb5vKUTIcMAYQHyUnjby5xF1e5Idnoj8kqgMZD2ZQY749tWNoZRrTHWMEfQUfL8x8mCKv7VXsndkzecWbTtPvuIeO1PnHvpRtG1Ef+yFyFaKfwKu5+5ObXp+k3UFY7EO+btgbv69QfvCoBtI5bLkhBKK1x4mFyDOrFfNntlE4SlGomCPtubpP//G2NXdwsXRF12WxAt8lRfp0flXIPuEebD3oBZqh31KMys8i0tR/jfTSmN1mqQ5OzMr8iEIe9WdChDCmo3zSWyZPzvnRVGqaPPhUtjwWGlTZFgbBuM1HesAd5BSTnnylV/NdP/BnNryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vfncZHf0mrniYV5Z41gXO2bglQv3OQhPKHWkT5kfnI=;
 b=Stxw0doa8teNL7/TkzEvXHVeWxHNSsRpALQO9jKGVdrhpw8vILlhwA0jKdSa4mk7yJuc7RuEK9DUO5AZzMTLYPESQTqDCpBM+JOaKnpXBdGRiI3v6skf20WV7NOhxbKMFQImQ6TD8dR7Zkc6BSFIIiGMg0+XNVji2KLwWhbLoyc=
Received: from SJ0PR03CA0277.namprd03.prod.outlook.com (2603:10b6:a03:39e::12)
 by DS5PPF5E0E7945E.namprd12.prod.outlook.com (2603:10b6:f:fc00::650)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 14 May
 2025 17:23:10 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::98) by SJ0PR03CA0277.outlook.office365.com
 (2603:10b6:a03:39e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Wed,
 14 May 2025 17:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 17:23:10 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 May 2025 12:23:05 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Christian.Koenig@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v1 5/8] drm/amdgpu: read back register after written
Date: Wed, 14 May 2025 13:22:48 -0400
Message-ID: <20250514172251.726484-6-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514172251.726484-1-David.Wu3@amd.com>
References: <20250514172251.726484-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|DS5PPF5E0E7945E:EE_
X-MS-Office365-Filtering-Correlation-Id: b3fe9c1f-5326-43b4-eae4-08dd930bffd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l+9CsMtoLrzMcTfqUFe06E7TAKTKYSZb5dq+8XYJhLEShJBc7171HpFLKtNK?=
 =?us-ascii?Q?JxMhYrrEh0CKfP1MapLo3FTieptHuJMgQQAFGgev2heonEy75VfWZMrp0916?=
 =?us-ascii?Q?v2edxxGxGdSJmS0++n93lajTiJY5/kDErj+EnYMDVV0G41dfLIR6YjzLv+hd?=
 =?us-ascii?Q?I8Wa5FbVs/EcYbEJX4bKR75nzhLRUJ4D4vpr76T3Hi7JXoMIhX1a94cjfzA8?=
 =?us-ascii?Q?mn5sYzXY/IIpfSDlhSLfSbULw7s33Y9ZDtI+ErOXMFG3TTVogmiRTsjFM5pp?=
 =?us-ascii?Q?Cnc5Ep5NISsBIxYkIzNlNwIC4GkF2HzwVXj93sFlj/yt0sI5/nTxOMICc4Hr?=
 =?us-ascii?Q?0jsBWBI2GgpxT4vliS1uwsfgOSArihNkBQ+vmxh1K4dahWBq5X9+LveK77sF?=
 =?us-ascii?Q?lmYN9GKX2ZpbM5gdPWNA9d7JklPxK1jOYKgHxVGuEwbmO/BPm4bxoewZWzvg?=
 =?us-ascii?Q?2ZLQsCpVRZz6vaINmvAG0fhtXxh4zcLZA6FZi6AmBFYX7SCAzEP1gBbPRaM9?=
 =?us-ascii?Q?JsYZLUv9FG8xkN3lhgg/NpExh6uuNj/nwmT6rbCmav6LZhk/CkOgGuE6cxw2?=
 =?us-ascii?Q?6J8nKLZI6RwwUEr9Niolwy4mqWRab7ESlHt+lA8vzzz4Mr8ROdI6RfJOGpYU?=
 =?us-ascii?Q?ktJAEBXQ2FM/Ehev9IDq7WkPe0hXeU/KaVGz5ZmgbzwOaIMLIQtKsL9UcsDo?=
 =?us-ascii?Q?CIsr//ldrzJVC/IUgHJC6AmdbnI5zdcED1pjspWdPU9F1PX11xZDAolpRzLT?=
 =?us-ascii?Q?+795ljSXUPwSpPiVPsMEOc5AQKjPyWZVe/oK4e2vEj1+/Z3mBPOVADlcmY6D?=
 =?us-ascii?Q?VK39J/mff0TyQ69GrWrwHaP0DUzD5s6M2US7IkxQwNphSL9f2sn/Q+zKvhxc?=
 =?us-ascii?Q?jaxx0WyNxZl21gsmx/UZvwYqtD814s5IiG5J9JsKqmrjxp+o3jo9fdDpskXK?=
 =?us-ascii?Q?igZ8104vHh70uNgrvXQKUM9/IVf5Bt1Ss5t+hKhyFuNLGMRN6sBeuOgiU7sN?=
 =?us-ascii?Q?WW37cY3x2E/eyD3zKGvXyOHh+AqbBFge+KpgRwC/TpT3ng6JnTuNghCLsp0q?=
 =?us-ascii?Q?8L+LHikXzA1vMiFK74JRDARacdWjc8jUBjMpvVGmuqEYDeMHADgaDDIcqEBk?=
 =?us-ascii?Q?bYdhm8fRmhGUcdU+wZJCFvn/5/XWIEtSEhLWR3ReMWoJaMgJfvonGK/7c2Br?=
 =?us-ascii?Q?kCkR86XBNP/2OPfA33+/Auaxa96AXEbRAEFpVVzMDRRD5Qu6mnnbrUniZw4u?=
 =?us-ascii?Q?ShFGlnkr6apvkUeF53xHpUVRx/Qp2ZbCQ504KbCuxhsi7mUXpQnGYAPRo4Mn?=
 =?us-ascii?Q?A7TlO0WX9/9eKjs6Eo7Vf3ew0GZ4bgqnHj3M7SRyCLTo4+cpM2VCjvAf6UO6?=
 =?us-ascii?Q?2OleaA8YB7zRrUFlQFKGyW04QRie1GS1U/E7b9+uOL5hNoSreK7JyFu9DrzJ?=
 =?us-ascii?Q?0TdCGCga7AsQvJppcg9Ct7+mU23Udg5FHGkYyock9tdB8Z/MQGj8tKFp6V52?=
 =?us-ascii?Q?tTod3ZAcDEP21PpVVz/WjtqmSuRIaGSk2uTl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 17:23:10.1340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fe9c1f-5326-43b4-eae4-08dd930bffd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5E0E7945E
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

The addition of register read-back in VCN v4.0.0 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 8fff470bce87..d3c5c30f35bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1122,6 +1122,11 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 			VCN_RB1_DB_CTRL__EN_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR);
+
 	return 0;
 }
 
@@ -1303,6 +1308,11 @@ static int vcn_v4_0_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
 	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
+
 	return 0;
 }
 
-- 
2.49.0

