Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A76AD132A3
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 09:18:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C62710E39B;
	Mon,  4 Nov 2024 09:18:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EwlXXKuH";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D193F10E39B
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 09:18:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=An8xX/MX+r3cTNGNk37DYXVPGSyCV2MU9VGoy2uIVCcWiq12FNP+J+++fPb2X/4cPA5NLEkGfs9ZgBKd6i9QZaN2QBkRxJtV7D5j+IMxMc6+EWHDmL1NuD64EHE9AGty+rs1qn+e3+dDE/niyn7X7xKDTGKt+hdULAr+dBVolV8QsjaFFY1IIGJoGFGHX61yAiZQ4Q6zkF+PjeJbb3ul0IQHTJFjj/XIVVshXqnh0TMuNlisxDYd4lDBXFbPpWHVSKARO3XY4wSgVuXH7QjO2oub8iCk9XRmWwy4YHP1+9RznLDpnJ7FGyXF9TlqUm5+I5vgHDmdl6cZ24j+JFtNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuJKPLwIU/aem+gJxdaNJn8fo+ZgvF2BxX7qIvt50n8=;
 b=AzoplCjU2vwB4mPHNyNnwfqAfrVw7lc6TZ/V0Bz9ClV6LmpZHuNPT/S92/13Fz8tM4gR3OfJghXRfmpwvCiFe3+xPpV1CCJA0J7boBHxYFZ/eYmLfZTFdgBAFndw7v1SkPzXqAisLXAKEMh/bKWhrD7V06N3PFMD6Cp6ko26miRAXhJGMqpMMO/4ZW6ZT94KS0nEPxK/UXEQ3yv7sHtconFPv8DVQX9rbZ61ABXmlixIs9/bvccy1yMGj4NzjUIwHytjQBUPdpuNLIgy8Q8fqlABLpm3fIXVHbjDaIEHD48Zd9ivx71rPMX6YZoOBWYExxnv6O+O9o6wEGSKZYGx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuJKPLwIU/aem+gJxdaNJn8fo+ZgvF2BxX7qIvt50n8=;
 b=EwlXXKuH5z8n/WTB9AtTl+AspeOClKbl2eZjV6DPnKPkJoC/IynjRHQ5JS+e8AtzV3ZuV4Wn9Hss3u9yHTIdhJFPhTHRzYYSf6/iWDTGa/N+XWoC90Jk9a4A1KZw+KSv7ffaqEwnePB7wwC4bLgH41RR8ZWVATZRBEw+vCJA9oA=
Received: from MW3PR06CA0001.namprd06.prod.outlook.com (2603:10b6:303:2a::6)
 by CY5PR12MB9054.namprd12.prod.outlook.com (2603:10b6:930:36::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 09:18:16 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::f1) by MW3PR06CA0001.outlook.office365.com
 (2603:10b6:303:2a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29 via Frontend
 Transport; Mon, 4 Nov 2024 09:18:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 09:18:16 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 03:18:13 -0600
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <yubiwang@amd.com>, ZhenGuo Yin <zhenguo.yin@amd.com>
Subject: [PATCH] drm/amdgpu: fix identifying prefix and postfix SET_Q_MODE
 packet
Date: Mon, 4 Nov 2024 17:18:00 +0800
Message-ID: <20241104091800.97627-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|CY5PR12MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: bbaecf03-5405-471b-74ec-08dcfcb19d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hJ+CnnNwu49xPWffCEiE3tvz3VUEKwVnmESMa1YLzlKxde22l0lCeFys4cTv?=
 =?us-ascii?Q?N9nF1Seva5IPr1OdEgHKLmNQMoTAWQWdY3eqbqiK6uzveszkX18ddxkuklVB?=
 =?us-ascii?Q?mAZTH67shUJz/XUsTRCKN+xAFRk7F5B9/OWKizsVnFDjDP4wah2jz/bBqSAr?=
 =?us-ascii?Q?8rlsUP6iToObRguJyllNEhJL0MXUDjJFyNBiMtdZJlWAy0G5wTih3sBHLAwG?=
 =?us-ascii?Q?IgTqWD2gVB+3kyE5DpcdB/rMPra6dcXPLFHfxRmtkGiblpJuv1P/ElUidUVN?=
 =?us-ascii?Q?974Os3Gys/8NkjUqVjMBtQuWF/VAcJ5cBRP3/avsI4cfayzLst8MnBiXmLxn?=
 =?us-ascii?Q?6w0uaRQidzjnRkKDz03FHMAf99ovNWcbnMS9w03wLWuVGB9lzFim3EtHj1Yx?=
 =?us-ascii?Q?0Yqud2ZIuSFYDSJFoTN/TMvZTrL52lwtcesvCYBpO08LPv9ghzB8SLM//Ih0?=
 =?us-ascii?Q?O/7b/NjWxFTeUONu1M09BRwFuDDA8rDQI2LecjnLzGRRb0cSGzu3oKxgxUXX?=
 =?us-ascii?Q?vGW9e0HsNJ0INg3Jk3DxkDt8T/tXQPK/4vNKlwjKE0qzeS5sKDCUD0TqONFR?=
 =?us-ascii?Q?tL92bx8Xqx/I/AeHbuxD1+W7Q7rm+Do/uB+7LficdPyaR/TQafIKtF0Jv6A6?=
 =?us-ascii?Q?r8VzbhUZOak68SxnXMf7x+SkapNjMpyu0R0zqeTeiRFDk3frYGmDvVcV+6WX?=
 =?us-ascii?Q?GB1x8L3eDx+2QVg2nz1vHcaSB70sFS0sIUb3dczXASE2r9TFZXrwNd3ixl2H?=
 =?us-ascii?Q?+SrssBUXRgF4MtIiW7fH4AcZRhGYt7sQAA5n7trRmNRM2o8pJY3XDErKkBNH?=
 =?us-ascii?Q?vYtw2tulTfC/L5aKeOkWCmcv4vlZ6xVaYmGWrnetL6tNHl5mP8DzNTcz4n1e?=
 =?us-ascii?Q?j81DDBTkgMbCVNJJM7cNrzfPObq6KRNVW8Bc/5A2Yx4uDrc59LfgTUgGx8ji?=
 =?us-ascii?Q?ELhIbU/vmN+74RYAg5ehPHbdso88Jevmkk/b89f98ROhhP4n+k3qBQ0RwhB2?=
 =?us-ascii?Q?Bk1LTqmHuEbP4Bse2zRQipNJZsUSsEXJIWmVdKlAVkSNbf6M4X/4dWJLsFex?=
 =?us-ascii?Q?Pe8HfyPS0JeczU+5+JfGm1Q9Kub19m1XfVgO3PQ3XDPYgVtX78Wy9p5B728v?=
 =?us-ascii?Q?eY0z0VDFQ6lISLyO6hvlBmNJhYjpyvWrSNxWW7fIu7MoLl3h4/Re0aL1zQu7?=
 =?us-ascii?Q?O/jYTF2R0OW2g1aVOXBOnjWjNbBqeF3CPBekXM2YeTeUaO42x3H8ZW5OB2mi?=
 =?us-ascii?Q?My4iYgKZJcBSHb1xYUdg5jHUJBMZvK8SndZ+5aMPyEI012cPnb5aFilLXrVr?=
 =?us-ascii?Q?D+m7xNf6XCBlwegEd0m9fct34tggJYTHFm5a7e8LNhnum4krWeSmCDyWpI5y?=
 =?us-ascii?Q?85jEru5VvWm6ypvhQ2V8WdscbyC6+i+ctNZDt6W80CQgD5fmlQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 09:18:16.1867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbaecf03-5405-471b-74ec-08dcfcb19d9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9054
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

[Why]
In legacy mode(no MCBP support) shadow_va of prefix SET_Q_MODE
packet is set to 0, matching the value used in the postfix
SET_Q_MODE packet. A prefix SET_Q_MODE packet will be skipped
unexpectedly when mixed running jobs with shadowing on and off.

[How]
Both shadow_va and vmid should be set to 0 in postfix SET_Q_MODE
packet. Combined these two conditions together to identify the
prefix and postfix SET_Q_MODE packet.

Fixes: 8bc75586ea01 ("drm/amdgpu: workaround to avoid SET_Q_MODE packets v2")
Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5aff8f72de9c..01b9dfe5b307 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5862,6 +5862,7 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	unsigned int offs, end;
+	bool is_postfix = !shadow_va && !vmid;
 
 	if (!adev->gfx.cp_gfx_shadow || !ring->ring_obj)
 		return;
@@ -5886,7 +5887,7 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
 	 * the postfix SET_Q_MODE packet. This is changed below with a
 	 * WRITE_DATA command when the postfix executed.
 	 */
-	amdgpu_ring_write(ring, shadow_va ? 1 : 0);
+	amdgpu_ring_write(ring, is_postfix ? 0 : 1);
 	amdgpu_ring_write(ring, 0);
 
 	if (ring->set_q_mode_offs) {
@@ -5901,7 +5902,7 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
 	 * When the postfix SET_Q_MODE packet executes we need to make sure that the
 	 * next prefix SET_Q_MODE packet executes as well.
 	 */
-	if (!shadow_va) {
+	if (is_postfix) {
 		uint64_t addr;
 
 		addr = amdgpu_bo_gpu_offset(ring->ring_obj);
@@ -5928,7 +5929,7 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
 	if (ring->set_q_mode_offs)
 		amdgpu_ring_patch_cond_exec(ring, end);
 
-	if (shadow_va) {
+	if (!is_postfix) {
 		uint64_t token = shadow_va ^ csa_va ^ gds_va ^ vmid;
 
 		/*
-- 
2.35.1

