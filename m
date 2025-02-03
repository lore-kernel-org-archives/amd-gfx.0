Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FDBC02194
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 21:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0428510E583;
	Mon,  3 Feb 2025 21:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mDsrG+ut";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71FB310E583
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 21:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpyNHM0+YFCF18wmbhltKY4RBDYgKLB4R8xazolp2EZIbOYs0ID5D3PWXOve/Gn1ZU0/hF5NXgPvp9dNP7M69QXkmcF/f812OC+PlImlI10i5vdiU5cvygxSDnQ6XZyN3hFMqEvh31ztQul3kByoQcbE8e5+RsNmUkd5Ej1mEWPtv0QCEaIKsRmM8StbpTBZ/b0z45bpbdJHmRyuXMHPc07aVvV0DKZSknehAWJDJysQjW+2yZetIOBrYus9OQwI7z613MmuisHAzpIlOQrqS9M7BZ2ixlr9vFFm+K5PS4tY8r++VqAxHblMW+uOfjEokaQQa++UfVE6w9no2n+cjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WwlUwQBPYGpXMbYee4WvC/MWjwJfEfiJ33GKuF4teo=;
 b=NAz4SxEbe4lKDgqkhMTxJaL1iRU9EQ91HylmxNjZU/XJrqBB0WbXMRiB70nt//HtDhApwAc9Cb+j0gKahLg0E6swIob7cqm1OvT3PeNrJf1RenagMRRkEVH881MovGZpK4s4YeZuyUizgNqf6dp6rCCu56Wg5RjLe9xpH1XaAGpWmWB6NiU1KAePYeYTJht6ECtKDxDf9jMTKCMduu88+CvVrhg5SoWweU4ElzMlFpqKnCeLNOSsxucs/ne+dRhR+Ldzc8KKxdc6XC3wMfIhtK0DJyyvIqfrMAtQbA1o+fXD3ojceCGBH6oWbMcZHjMrj5IKLLRYAbnnyZNHkqLuiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WwlUwQBPYGpXMbYee4WvC/MWjwJfEfiJ33GKuF4teo=;
 b=mDsrG+ut4fwPRFkW81Wl1GwKBVELRf90zCeuY9QCxjpEFBDXzbMHo165Pf2pjZIAnw1vQLXTiguyAJSGyAkeFMAbYW4uouJNqcmW2wxsFnjgZQjRflKJIuEzrZPW1kx0dGuwbC7iiJWrd+FDU3JT9JYUc7Z7/ihFp8RVKq01/vg=
Received: from BN9PR03CA0579.namprd03.prod.outlook.com (2603:10b6:408:10d::14)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 21:44:11 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::ca) by BN9PR03CA0579.outlook.office365.com
 (2603:10b6:408:10d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Mon,
 3 Feb 2025 21:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:44:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 15:44:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/11] drm/amdgpu/sdma6.0: manually control gfxoff for CS
Date: Mon, 3 Feb 2025 16:43:47 -0500
Message-ID: <20250203214349.1400867-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203214349.1400867-1-alexander.deucher@amd.com>
References: <20250203214349.1400867-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab4c7e1-9927-4f94-f7ac-08dd449be512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?huidDvIaiSWrB7uKF/zkTFn936IDH7mDYs9rNUmwzhlyh68hekE1NiVEzFcU?=
 =?us-ascii?Q?dKkaiyUyhnH4z7q32z34uwmB2mL+O4BYeAuH9yRZEHUnMaSDG8DUhwNLPd/H?=
 =?us-ascii?Q?VqkEtvXHfzHuOe/p0X1s0HpK69F1wudpLOfhBgr2VuU2YOVB+xxCKYwMFKMr?=
 =?us-ascii?Q?SAJLYbw1T04x13Qp+wRc3++6zFEstTDR/7MGTHGdPqriSJSYcpttpARnfkk0?=
 =?us-ascii?Q?GkwjIzgd21Jxj5R6cSCtxDEiKF+/UZJfjvciYbey8dlV9dpDwdNNNOnDVzXS?=
 =?us-ascii?Q?60siioZjOa5UrFsL47ly0LcP4P86P0kAcQAaTwf/8dUbwuxY+9N5OTzkmNqW?=
 =?us-ascii?Q?38/qsg19jWdWmv0i1bF9rLKHrsc78/YL91N6b80gnu08JDNE2r9Vb4Ninkyd?=
 =?us-ascii?Q?0H+occLv2B01m8VCpN1ilQP7oJXYK0TA27Q8enOfk8q5KaxrlDOs/7+qQtce?=
 =?us-ascii?Q?KhcELG1U0t7ruOwzo5nY6RUzj5UUaLZ9Qoan6wreKliEmg5jGyWYjn+cSC/U?=
 =?us-ascii?Q?8PbHiqMAFXqwEdKLY72pxRUmFHve/2Al/UzL0aCxKuSfrAIua0yvE9j85BLx?=
 =?us-ascii?Q?xn+vu6ddSWNN1jIty4cemjst234txTFG7WQJsZRXIgRiIQnmUqKAkY/qQj1L?=
 =?us-ascii?Q?O2GnJSlsHrSthEyrzxnphs1++swQouZEmMvgH6R7Zdf4n+TvgF+ly1Jf+cRk?=
 =?us-ascii?Q?I5f5AM/mBwh6mHCzb02LoPHF1BTCgIDaaqOyVNMyce0fOAMLBGiKuuAUjIXc?=
 =?us-ascii?Q?w8jkAbp/ourNBnSs8r12jHGLEqg8gb48vMwNpmKdwYIdxw6tUk5C+vpIDLUL?=
 =?us-ascii?Q?7EoE7FZEeQJEB50IR7aKDWyHSo+YZv4URiLTKYKmINyDPMH/OWKDUlQ4ccNA?=
 =?us-ascii?Q?whZ6xpg1OUYoyUMQQf2pXMJkWBM361OqYTHyZrMPhJRk+aLCuHKiIEvpD4Se?=
 =?us-ascii?Q?fdTKf/hqf2F/II4uUkqe4N1agq6hhfJWy8E2hu3fxLoU3rO7gWCksYacyL7M?=
 =?us-ascii?Q?nB97IMbtBDC9F4SFE3LmoobSmXPJfiRKctm4ReDIh5WA1pUAeDnSN2c7Yx1k?=
 =?us-ascii?Q?2N6vCHvs7HGRXzHocKe1zRWh8/rt2ofZAI5lt3SFOucvbvOG965Wvf+v9tpi?=
 =?us-ascii?Q?SPyvoWTJAPCpO9/zY+jEWxEw7GDWSu2g6f0s9AlRyxX/P2yJUh+XDT7ZLy/a?=
 =?us-ascii?Q?VU0EOJQlVzJnLjOWKv9hJ0uL7NhOKhYjdKoqBEa3IY3cFNoRzS08ucTAqtHd?=
 =?us-ascii?Q?xZ8qm9XARvqD7/lYY96DDSnSxXXj7to45DFYGRtVcVUBJUMBubJgzEErnoaE?=
 =?us-ascii?Q?rNitZudUjti00Tv29X8Glybao6Enl7ntz32hOotcV7f4cgTziQ0+kYXROVMg?=
 =?us-ascii?Q?J260GNqU8DTTnifSOB5tpqLK4wov2WEmW1LlczPEFxfqrelSRPd/D9uoeqfd?=
 =?us-ascii?Q?XMCf8DicLbcHgTWeqetTUx0/bsswTnsxtdL2IMs/25+ELeyghHUFz6dLcohq?=
 =?us-ascii?Q?770+5vV+CpGjKrg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:44:10.9542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab4c7e1-9927-4f94-f7ac-08dd449be512
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
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

Manually disallow and then allow gfxoff in begin_use
and end_use to avoid any potential FW races when
ringing the doorbell.  There are no known issues
with gfxoff that this solves, but it shouldn't hurt anything
and shouldn't affect power usage since we are only
toggling it around the doorbell update.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index b83a0a69ac5b4..a3e5b5ccadbcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1667,6 +1667,16 @@ static void sdma_v6_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
+static void sdma_v6_0_ring_begin_use(struct amdgpu_ring *ring)
+{
+	amdgpu_gfx_off_ctrl_immediate(ring->adev, false);
+}
+
+static void sdma_v6_0_ring_end_use(struct amdgpu_ring *ring)
+{
+	amdgpu_gfx_off_ctrl_immediate(ring->adev, true);
+}
+
 const struct amd_ip_funcs sdma_v6_0_ip_funcs = {
 	.name = "sdma_v6_0",
 	.early_init = sdma_v6_0_early_init,
@@ -1721,6 +1731,8 @@ static const struct amdgpu_ring_funcs sdma_v6_0_ring_funcs = {
 	.init_cond_exec = sdma_v6_0_ring_init_cond_exec,
 	.preempt_ib = sdma_v6_0_ring_preempt_ib,
 	.reset = sdma_v6_0_reset_queue,
+	.begin_use = sdma_v6_0_ring_begin_use,
+	.end_use = sdma_v6_0_ring_end_use,
 };
 
 static void sdma_v6_0_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.48.1

