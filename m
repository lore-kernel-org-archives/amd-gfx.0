Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A43BC3ABBC
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 06:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE17710E2E1;
	Mon, 12 May 2025 06:42:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZQ4+Lhqn";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208DD10E2E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 06:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SijeYWMwlAejKS2BtNH7iM3M3MSl0GkzXwDxrQ4idMVdTZDt0XnGb4M6yqHBqKY65Tjl6dldIP8wEBbR6DTXl67i9yc8suBLULqp2GllFpOlu44sbSgxpxTWb87jP8RFuA6AV/vWwKfHTWnAtwcE0FpSKTvv71xX3apl5HDkVb9s9GgQp6BYFkdHUF5qiIK6rv7XoTj3MuA1DFdwbaBOUO4mRz4ZosmjKdgdsM/6Aq3fPGj6F+EzqinAQg27kgzwGY/igf9ymA7PruZifCtflvhcl4mBBkLd4LNrDFZQIxMGhPzFHd3PLrq1z3NjMnt3t6pLJx80NIN+/Ed+Uru2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SykivLDyv2TFVHZ05z2B3zfOfn+FHtiewxZOXIkt6yw=;
 b=aDuje6KDJLJ19cUXRzfo/Ikb+4cvnJGf+UGL1wBfvRrW/DN4BMY2aWYoRl0bgBrJ5SyYKESfyuj/u+/Fw+piPW3VKCtXf9MIPeGRIJFut8/zVeBtb8MSTBnt2wWiF1lHgvorlU2Z9sLhHF2s3f4hHV8HfLBQudAUFYRM/4mjCByz/qwChZPpzOIrD1BXdxlAW9iod4YWDvdLc2DHQ8sz1b/PF65NaRnDKYET2ZuL2sPByACGdpu+dtjM26dBqKNWE/OrSS2pAVBiJvdMwPgAXzinAVty79g74mhsSbx1/kFVf1TVZMnnvRV7Q7xFK2KpXBG2mXVIdiKhTMGC4URfdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SykivLDyv2TFVHZ05z2B3zfOfn+FHtiewxZOXIkt6yw=;
 b=ZQ4+Lhqn9vvCJrESYAe+8mZyYazh1fJNETWOpuc/XxVZFzXROqzFV0nm1+SeJ6cy9GvrPKHDfbi83oCwgYWYp4ksAepru+Li7m+Wtdpm8EA8U0QYpCLm2PyF/aKCPMLELCKq1Ku+dbb9o6LS4pnxPwvw5nrEBrr9nLlJEGKXDoc=
Received: from CH0PR04CA0098.namprd04.prod.outlook.com (2603:10b6:610:75::13)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Mon, 12 May
 2025 06:42:21 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::e5) by CH0PR04CA0098.outlook.office365.com
 (2603:10b6:610:75::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Mon,
 12 May 2025 06:42:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 06:42:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 01:42:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 01:42:20 -0500
Received: from hjbog17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 12 May 2025 01:42:18 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>
Subject: [PATCH v5 4/4] drm/amdgpu: fix fence fallback timer expired error
Date: Mon, 12 May 2025 14:41:41 +0800
Message-ID: <20250512064141.387079-5-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250512064141.387079-1-guoqing.zhang@amd.com>
References: <20250512064141.387079-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: ea52a7a5-f0d1-481f-6c56-08dd912025d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mf5X3hkk5nPy1OAurEcxX8cORUxbIf/dYB4ib2W+HX03Qz3CL9UwPG8I/0wu?=
 =?us-ascii?Q?NqGGvQjI5f9h6QuKnXhwWvHMK3epdMcS0xcur3ulzM59FfOGNNDqTzM7RwTq?=
 =?us-ascii?Q?lgboRkPy6tC+qXn7B2+T0JP3GM74MRUFosZXpKwjcBV5Zhq0kv5+1eB7RdSZ?=
 =?us-ascii?Q?OMX0ZD2cexfBMEmV40NZ8N1lvrOPz5sTbWIzmkwrKpDpQpuaQxZAKJeJfa5P?=
 =?us-ascii?Q?f/J9bmughwmOFXDFAU0dEL1Wq8g0UWAHn0MsB5MO+Rp8vmOnP6V+0PbQJvRH?=
 =?us-ascii?Q?bPZ/2o5qMfYzWb2matW7dvfLT1aeIxFKTwgR5VDvLDonOZezjA1zj4e5RtII?=
 =?us-ascii?Q?nxsYJxnTRcSLEaRS+JNCI5MRyvFcz+xzbmKW1YIZNLBoori1TQov3vr33BvE?=
 =?us-ascii?Q?Q+y3BetLdV30z1ZPGPUvRrGWFFmxr7oar/0F0iyOgjq/+cNr5+nsRl6/wV4N?=
 =?us-ascii?Q?lOVsXdLHitnB1nIplpbOUflHsvzj/6sV0yFoDuUnZduHk0PnIvtxEDKELlTo?=
 =?us-ascii?Q?P9PESU6ikB1dSZMygPbGl4CTuInpzGLRqdpQTQhy9rDe4hq5ItqBVS45qHPa?=
 =?us-ascii?Q?JBrw3SlXqYSiivN+Qpu++6Y6DeXPAO+QhoQrZqTrjkRZX6G0Xe9I7m0Xx+id?=
 =?us-ascii?Q?eBK6snuBCSykYAdhkluSKkneao0kcKIENizqTXGDI0D9GbopPK/VJNklNu0a?=
 =?us-ascii?Q?O3HaCgs51RXXbFFQNPgVqizUaQgNhaY6AKNCJ/HHXmpUy3l6yPwXgyN9YdhT?=
 =?us-ascii?Q?fwHuA1lMDwx41X54N2MDx9ww6AzKDbEANEnM+W1altlNKmr0bUMLSjZrq7l/?=
 =?us-ascii?Q?ZVlp6rRDLQbXwmxUefX75JN80zKUfg4H7DwCv/CLpDg+XMqul2aKTsF8F/I8?=
 =?us-ascii?Q?SilD+EzJLtCXC1pLJI+Jp/V6QmIh9bL3FPbXuGMXNXP8/p87jbhut0w6Zb4W?=
 =?us-ascii?Q?U0YYRQ3MIbIDHkGBJqMryZKbcIATZcupj5eupK4qUkwgzeSCIE7IIAyI1uRa?=
 =?us-ascii?Q?AvUgDlgM/5x2Df8KMYWmFElm1KUOKggzr+PF4j12ocahtOAl6I2NznSCJlkS?=
 =?us-ascii?Q?jifRpIOlshEmcwjugL0pE5E1+SGRUm5Ba5rHF9m4r5gUx/GcKJHPmdbSwNRo?=
 =?us-ascii?Q?UagEajKkEFP5v3pT4azAXyeqNYy4p+fGW/CZt/IUNWgWWNsjudCZMseSx9Ke?=
 =?us-ascii?Q?S/ix1uKAHd1adG9zfHsoz9sRiEcd4QAcRSYdKbk5u2mGYXEyM4tEFoo80jJP?=
 =?us-ascii?Q?MfsJozjam8IaQkraVhfPAcFNvERICWhf9a4+cvyusX7lRM7aVz4+Qh7vRmn9?=
 =?us-ascii?Q?Jmnk00NED1wB/GDbe6Y7YRfX8U1TL/wYTaqa7LqAuzr/q0bJ3Tp3txabmfTD?=
 =?us-ascii?Q?fgx3RUUJQJMcKnluSRe1N2K1oXMjPqFo3shf/FfMl/2o0bqwLgM/uZ47YMcK?=
 =?us-ascii?Q?0PDjZW4c7/0rBn8eC+LlouQCgKPeSf5OHEvAeWBI3qXpIChVgFmCfAM+U1eI?=
 =?us-ascii?Q?ZfAFqwPbARomBmTxjU/OG5jKZZIuZHomJSm5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:42:21.5318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea52a7a5-f0d1-481f-6c56-08dd912025d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
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

IH is not working after switching a new gpu index for the first time.

The msix table in virtual machine is faked. The real msix table will be
programmed by QEMU when guest enable/disable msix interrupt. But QEMU
accessing VF msix table (register GFXMSIX_VECT0_ADDR_LO) is blocked
by nBIF protection if the VF isn't in exclusive access at that time.

call amdgpu_restore_msix on resume to restore msix table.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h | 1 +
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 0e890f2785b1..f080354efec8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -245,7 +245,7 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
-static void amdgpu_restore_msix(struct amdgpu_device *adev)
+void amdgpu_restore_msix(struct amdgpu_device *adev)
 {
 	u16 ctrl;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index aef5c216b191..f52bd7e6d988 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -149,5 +149,6 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev);
 int amdgpu_irq_add_domain(struct amdgpu_device *adev);
 void amdgpu_irq_remove_domain(struct amdgpu_device *adev);
 unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned src_id);
+void amdgpu_restore_msix(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index faa0dd75dd6d..53c253102449 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -648,6 +648,10 @@ static int vega20_ih_suspend(struct amdgpu_ip_block *ip_block)
 
 static int vega20_ih_resume(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_restore_msix(adev);
 	return vega20_ih_hw_init(ip_block);
 }
 
-- 
2.43.5

