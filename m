Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB54C52D71
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 17:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08B5910E3CC;
	Tue,  6 Aug 2024 17:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mNYXdo3k";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6200A10E3CC
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 17:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOZcSMdtEbAp+yfJU/EwDPvYl26Auk4yxQZnbn6J5FOn6UOvY3IlupcDp1dD1IKsKWRiiGvBhRT2QhHWZWIIwxao+mrGCeB+hT+MKovuSBOnk5lhDtW4DR9Mi4AyocXyAtYbBz9judKLaBdafH3jlhXJwitn7sj3lxI1qRQwTAEfCtUK1yQOOZlK+HIoF8EEM1lYyEom62RflsTyU0F9M3CZfbO1EJgKB3exMJ0kQkYVqs4HbhcVvAU4z5bhpOm6XPUmW5WsfFZN01baNAOc0dVYmkUiTpOSkyqk1U5xvbsg0N7tl009+EgiSEAsI2P5fIdkPvPlc8LTkb1uj85NwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3Rys7TJItRxbvTH5t3hBrZ0MTYp8xPd2Gx7UvBpUnc=;
 b=VNy6T5rLUDso/+y/taP5YJ1q1X+IBTEgfT2Hw0zxhdzmVe+GX9ZB8Ep4LjvbflW6fHRuMDZV9UXalIqpAuY0S5ygxyrGqCeHmIMgbgcAakothIbniRsTTBOxIfRLdinNuvuCxf+Zdrk4C+04NKb+FXjzInr3oPMO+Zf+DVSSSU3Pl5aSz888AH84ifS1ZXWikIsgaAdVoXbR2FSM4H0wc+o0Ce48XS1EB71SrQp2FfSAtF4Acxfh2aa5MAIHkmpwfZ+qjyLhZTdCOP0xnCld9nGFPtdby1KvAEMT2F8mvO7z7UrnWhk62PigKT7gnCeLtL7FPYYX9WfvYaZsdYYnrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3Rys7TJItRxbvTH5t3hBrZ0MTYp8xPd2Gx7UvBpUnc=;
 b=mNYXdo3kRqlqEinpRWf76OYGn6A8BaMPrmrSF/CLBlWZ91HrJ/1bu/NO4DVeoZufdOasWmteKtqoNyofoNrtEewY4BbLZLO4WXqwMgf8ZknbjruO+cVQlKku9tYwrJ9Lbaby5gHLElIMCeysIO8CulRhfLyuKz4J+QF8h/fZhiI=
Received: from BYAPR02CA0061.namprd02.prod.outlook.com (2603:10b6:a03:54::38)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Tue, 6 Aug
 2024 17:03:20 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::a5) by BYAPR02CA0061.outlook.office365.com
 (2603:10b6:a03:54::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Tue, 6 Aug 2024 17:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 17:03:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 12:03:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/2] drm/amdgpu/jpeg2: properly set atomics vmid field
Date: Tue, 6 Aug 2024 13:03:00 -0400
Message-ID: <20240806170301.2064080-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6305f7-e0cd-4d77-145a-08dcb639abca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?alQQEcIVzQn6zmLOqy9TvGbcsj94FcOdFbNSWA8ZTlnRr9shHwn3MXXJ3ZYk?=
 =?us-ascii?Q?4s9xnLMddnrTxnTVc0RoLgYY2lRnAdF8cskxXJ2ku4qb3Tq2s1i9YVQuk1yA?=
 =?us-ascii?Q?ETOMbsbePgTCNGwEH1HF9GmeHNfdmbUcjtZeoB+ve7vqDAMB22Qwyu/jQ2VQ?=
 =?us-ascii?Q?iEvUM4Y8ETblekPzl0GSrHzWorXwgBPRLUVMXkYFdGGnP0xEtp2WNHPpKKjO?=
 =?us-ascii?Q?VF/bo2sHUg7mTQfKge7PeEzZR26qFPNozQYEIjgYJ8nqcMmffTElZaGkPY35?=
 =?us-ascii?Q?840dZsrvbAUog1CSePNNSkTpgL/QVkT/x11H+bicCTBkuhHoTi6N6qmy2ESt?=
 =?us-ascii?Q?TKSk5i0LuIphRt62aEVuusmAD7cXiRnsl25fKvDUCsjDY6v9YaFZw/3vRc/T?=
 =?us-ascii?Q?nbkeWHrGXTBqIznEmqoL9jn7fQ8qwMRtYmFd3kPOwEqTUHFDKpJ2fwqn1GBf?=
 =?us-ascii?Q?7F/KLPhDeydyTN76hirKoKLVdpYtv6Jzn+ZlC/eBODy1VxDsJixoYrZbuHWe?=
 =?us-ascii?Q?QgT3y3CQb++k3hbHigpwS00kFrYyjepRGJjyXbgTHbOGyfdz3zlPC+mp7j4y?=
 =?us-ascii?Q?gm+Y05tinzCreK0vf5rptJ3zsbdlMUzZYXTN3cj94lupC1C0FEq2oQK62JqC?=
 =?us-ascii?Q?gIUt0rRBqy+iFaKOgtH4zzDmMF9QRHMn1Du//MvdyWiA/YkbicBKYXfKVtas?=
 =?us-ascii?Q?KdrSA/Vu/jZyiwwYi58LCEF+Q6ByY19cESgkZ+2oTv3PbCqEQmuZ5YszddH4?=
 =?us-ascii?Q?L/IieRLLoETWpfEM6LwRlRCrVCLM6sCBbjzqobWPjxdIG2+n0U0wUclV43Rl?=
 =?us-ascii?Q?NQ4i3wVhgBPMLQMjnv1uQ6poWVGo+0TPI8OacS79uG725cOwsGIGXEiC6ekY?=
 =?us-ascii?Q?zIZ3HTxkvnxso4PclvKtcf+LhPbSJFDmafWbJPw4Qx6x760iKt23zOCCR6pc?=
 =?us-ascii?Q?GGBgONEUkx1s9JWvfaRcRY+m5dC8nU6dv3g3Dg5ACB3TihFFCvdskmuM1rge?=
 =?us-ascii?Q?s69GzzSMnbKfSYyrFqAJLbMj2mUsAVtRtS/Keh1TlE+1rjkoUBUtTtAT3cFE?=
 =?us-ascii?Q?97LHVHp4icvfuL3aq9pKzEW1Mi5z0+VEnr3a0GEc02KFpedctvQS39tOxsGs?=
 =?us-ascii?Q?I8yLBJIJM9tCjUJfR25nFusi1xivpXj0Q+3qOWUv7EKhuOGsqqLJSU09lb6q?=
 =?us-ascii?Q?FJKtR6CC0pMxSNjPSNDewg0x4HRmlg5w/EThJqbKMt2gYEnHVXiOM46I6EJK?=
 =?us-ascii?Q?04h9mekL4zJ4BVrIstJGuCxYJ2bDjNCNoqLj4CWli5P+8AoxwQirtnY8J9Tn?=
 =?us-ascii?Q?6NNw2chO5TRdfLsoI61Q74lqCGPJxwUCNTfrKe8HBLlLt1GVnVG+FIWo+Kxc?=
 =?us-ascii?Q?up7VxApQPtKDW9/OiYp5K9yo4LxkHoxy/DRzkvPOIDqvOkCqmIrOaZDaLU/T?=
 =?us-ascii?Q?MYFql17aE0vuoFW4oyXuWhyV9RZWowNN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 17:03:18.9431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6305f7-e0cd-4d77-145a-08dcb639abca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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

This needs to be set as well if the IB uses atomics.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 99adf3625657..98aa3ccd0d20 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -538,11 +538,11 @@ void jpeg_v2_0_dec_ring_emit_ib(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
+	amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
 
 	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
+	amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
 
 	amdgpu_ring_write(ring,	PACKETJ(mmUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-- 
2.45.2

