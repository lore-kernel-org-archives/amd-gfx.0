Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5638EC48BC4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 12:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84F0E10E1B0;
	Thu, 15 Feb 2024 12:39:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dnakbgrw";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46CD210E74B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 12:39:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QN+wImxCK/zh8zqvMcmE0FizBhboJSRizcEjViB+LUgltdoIA5Pg+1NjJPyg22KApYUXTYEwSxxaMOZq+bXKHffuB1RgxQciYD8evVfzXOSdOA7bwyuj6etoVx3+LqoT+Tru0bGgyNiXJ6XsJAF7JxprXzMZTq1MDBDawFdqFf/CRIBiSZaGcD9I0HlTPIH29DVb6uSGcvXp2J4UPqSe7xRjpGaQi9n5d6dA0n20TzZH8DjHfrhdXv7vYUvEiqFms9HhxElsP4N78x+TMe7YLc12seOrvE62yRrBsuIGVLACO2df6EAWODETMATLv/oyhsc5HiSebXmbUe4kJrjGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szvosJxIDP97TLyhh97L4ppIPpsm6jVR4NbhpViPDFc=;
 b=ZoOcgU0zu7lVgLXKUdTx5loGAVbX9IXKZhsh1G60h6oG3GFes4oc7xMbV5Aa1VAKEe+a9OpLIMNrlNwHIZ1h6+xm342AUn0H8P01RgZuuc++7UUmXGx+di2zzBIW+I7OGNSe7aKsLS4ONPyf4V1d7NTQ+jBJPdQ9279W/9TlXLCtnfAOzv4+3EltQCpivlSDafmBj3Is7cu+dXjZKbfw9Ek0mEeJKVbokC9oUWW1V+zipZCsUIFpXfCnt8T/S+s9j13bY1Z3q0j1RlMW6phYD2DKBzZjLu32P+ZQzVkN2f5HJadvZdFPqmaRiq5TJHXmjOuV2COhlE6go3QqpaxhpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szvosJxIDP97TLyhh97L4ppIPpsm6jVR4NbhpViPDFc=;
 b=dnakbgrwMCczvuyxt5b9wy+IiI+zxbcjxCijD2rGtGLsGxRN/H+ExCUR+O4IyPphtff6mcz+JDFL+EZVSmE1PeHDKcZ8iCx1TUP3Bhw8PEyT90LzpquJOV/WbuKl9yIzCxrpu8ELf8ubI+TrC8xr80xWlp7BK+0IKqppclqBuqo=
Received: from BN9PR03CA0369.namprd03.prod.outlook.com (2603:10b6:408:f7::14)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Thu, 15 Feb
 2024 12:39:00 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::62) by BN9PR03CA0369.outlook.office365.com
 (2603:10b6:408:f7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 12:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 12:39:00 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 06:38:58 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Likun Gao <Likun.Gao@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix missing parameter descriptions in ih_v7_0.c
Date: Thu, 15 Feb 2024 18:08:45 +0530
Message-ID: <20240215123845.2327190-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1a4ee6-aaa6-4305-35cf-08dc2e2315ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0opj9L+OlgtfaERy2SI+jbE5Qv6GoFD0I1Fc7cRxXnrkQzSjqWhIfMWfa1lSAkqofeantmQqoJCykxnUNCrEX3mkE/mRiFCxJVYhOP6xF1OBHZQP72C2gYXdTfmiv7GFFZ6dg9mhYS8qp79NevZZ8Jzlav7SxNoepY/3DqeiU8jgRmsRFHz8WmSd5fri3w0r3IHccjZIuUvwFTQO+Yzzrpu9olleiZLOEMvz37IIGlSLKTaOxoB58j+5zVfJ8/yOlysDzBp/H3tZ4/J9qw3nM1wsbW3kAR8CxP7j9yAVo4XeWFFag66lZu1JtJc6FrbgowK0lrVrOKsX5uD8+Dz2Z24Di9HRK2LUBBOQ6iI80/tZ3fi6TW+496JpmQOG6wZMnf5nxm+K0jy+Vw12pjsgf0a8TA3vWl3/6V7p9UXsfYxNUOA00WbHFoF+ZNUZvPIoWnjoLM07A/Lf5xzAJK5ECwMLSe2aZ3dNV9uzPXRBnyCEeTgytU02jNHfm4gVMzp38Xhln/Imcrza9N3YOrMoLSkU3emzZV0YuY1+te/GDW4mT8ez00vfXZnMgBsrtbZ8DIL68h60ggvbe6AuhtZwckfPBcYKgMFoEeJ3aCTMSTEszxDsGOeqi0R0BXjs9Z8aa5ehaGOWhJlY/CfNpa5IZHUOZecySSvS4lfTBU7qYc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230273577357003)(230922051799003)(451199024)(36860700004)(186009)(1800799012)(82310400011)(64100799003)(40470700004)(46966006)(36756003)(6636002)(110136005)(8936002)(1076003)(26005)(2616005)(336012)(4326008)(70206006)(66574015)(83380400001)(8676002)(54906003)(16526019)(5660300002)(70586007)(316002)(7696005)(86362001)(6666004)(82740400003)(356005)(81166007)(426003)(41300700001)(478600001)(2906002)(44832011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 12:39:00.3761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1a4ee6-aaa6-4305-35cf-08dc2e2315ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148
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

Rectifies kdoc warnings related to the 'ih' parameter in the
'ih_v7_0_get_wptr', 'ih_v7_0_irq_rearm', and 'ih_v7_0_set_rptr'
functions within the 'ih_v7_0.c' file.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/ih_v7_0.c:392: warning: Function parameter or member 'ih' not described in 'ih_v7_0_get_wptr'
drivers/gpu/drm/amd/amdgpu/ih_v7_0.c:432: warning: Function parameter or member 'ih' not described in 'ih_v7_0_irq_rearm'
drivers/gpu/drm/amd/amdgpu/ih_v7_0.c:458: warning: Function parameter or member 'ih' not described in 'ih_v7_0_set_rptr'

Fixes: b6ba7a165b13 ("drm/amdgpu: Add ih v7_0 ip block support")
Cc: Likun Gao <Likun.Gao@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 236806797b23..16fe428c0722 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -378,9 +378,10 @@ static void ih_v7_0_irq_disable(struct amdgpu_device *adev)
 }
 
 /**
- * ih_v7_0_get_wptr - get the IH ring buffer wptr
+ * ih_v7_0_get_wptr() - get the IH ring buffer wptr
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to fetch wptr
  *
  * Get the IH ring buffer wptr from either the register
  * or the writeback memory buffer.  Also check for
@@ -425,6 +426,7 @@ static u32 ih_v7_0_get_wptr(struct amdgpu_device *adev,
  * ih_v7_0_irq_rearm - rearm IRQ if lost
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring to match
  *
  */
 static void ih_v7_0_irq_rearm(struct amdgpu_device *adev,
@@ -450,8 +452,7 @@ static void ih_v7_0_irq_rearm(struct amdgpu_device *adev,
  * ih_v7_0_set_rptr - set the IH ring buffer rptr
  *
  * @adev: amdgpu_device pointer
- *
- * Set the IH ring buffer rptr.
+ * @ih: IH ring buffer to set rptr
  */
 static void ih_v7_0_set_rptr(struct amdgpu_device *adev,
 			       struct amdgpu_ih_ring *ih)
-- 
2.34.1

