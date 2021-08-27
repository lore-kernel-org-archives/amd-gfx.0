Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD1CC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 12:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2287960E73
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 12:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2287960E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C4016E929;
	Fri, 27 Aug 2021 12:43:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC0256E929
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 12:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZUTjG9qxNtvb6hxZ9okr1mtP/V+izurbi0ea2ukPM4udOr2vOuEXWXa2b9TsJjhzB3yOMwY0ilqASzCwCoAgzghcxQOM2rG/itNSM+8FCrEzZd7nbHTwo6SBDpAP20oi0WUG5Ws3STeQRcziZ9SUBLes882fU252PknmzDTpU6znKoaTuNQo8GcMsWEEZtrYZIQklKn3LgnypgqeBcpGagivbo364rcrDrIG8MTs1fEiIASAHLlWQj1stb7e/agkoLuRp0Hc1I+h2jUzm+aIkwyY3VRdSAp9iFAHzdJp+WGgAleil17vGPN5NJG9o8wrS8rA5utzERJfkGRG/JkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAg1O5+sU2uBsFVzOrNDZo/ZF7AzFWnmckLvRC4KGnE=;
 b=XYE5j7ESFq4fHLw+kiA9DZ7yRj/4V1OYYmgA0oWf0o3Ggwbsx+YKB9ibUrhh1XNKaKUKL3bvrEXGqLseAxAl335PdiPVqurpbze69/i0ZabcEQHapwgARnyy468Kb1JnVlHwu7AYGhOS1s0jMwhSltyCs9Fpm2cNbeIF9ipU2SR8sToeoZuz00hYl9j9Plalr/Nlpnxr/PH1dhmREP9pJe+0TdAax3XgYLEyBqmu0a75yv1+gG1uTpbE6X6ymKhqLLURO4Ouul7Sk7dMs4NuNBt3vN+ZN1bzKZdkxQgsQNFeSyx0ZzC4Lu90zWEBDMEl4ZiS6QubJ78RqKgjKJHn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAg1O5+sU2uBsFVzOrNDZo/ZF7AzFWnmckLvRC4KGnE=;
 b=HseNCVTwG/dphqGYe5wKa43HPvd5gqmMRar4MnG619F/IUOClQ46Q0Qbv4q//pJYd55DleEBZ+p1Z4IaQl178mbamON9WR5y7E8kfP/qY5bsrS0zIgxgLgdANsBzV2rNigEsjWGMgRHCaNBge1tPSpjbUJrpjPeOd5hOOZjauw0=
Received: from DM3PR12CA0115.namprd12.prod.outlook.com (2603:10b6:0:51::11) by
 BYAPR12MB2886.namprd12.prod.outlook.com (2603:10b6:a03:12d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Fri, 27 Aug
 2021 12:43:41 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::35) by DM3PR12CA0115.outlook.office365.com
 (2603:10b6:0:51::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend
 Transport; Fri, 27 Aug 2021 12:43:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 12:43:40 +0000
Received: from amd-Celadon-CZN.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 27 Aug
 2021 07:43:37 -0500
From: Satyajit Sahu <satyajit.sahu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <shashank.sharma@amd.com>, <nirmoy.das@amd.com>,
 <lijo.lazar@amd.com>, Satyajit Sahu <satyajit.sahu@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu/vce: set the priority for each ring
Date: Fri, 27 Aug 2021 18:12:58 +0530
Message-ID: <20210827124300.14593-1-satyajit.sahu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6939959e-5acb-4755-1352-08d969584c75
X-MS-TrafficTypeDiagnostic: BYAPR12MB2886:
X-Microsoft-Antispam-PRVS: <BYAPR12MB28865ADBB6E33386BC607293F5C89@BYAPR12MB2886.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmYmbEiJCeLuAh3GWChiZ/Vz14CPLP1WnWocRaNZvgGHJnZJXW3P4+x6FHp66f21bjGNjbqXrmecOoYeMrJQUYjKhtHOs1tDyaEJlubDy3wrTLWlFfxgw33YYLwT8nic46Gej5KCFDTPugUcNUzGYMLClkgbVUYqTJKDxxqj0qkln80rfMUJKS3LksPsx6r1uRmwRS7xG2wGqChHkrk+C6tYuNzGgWXxESmLa5KBjnYDRcAZ6iW6hcP9MUcyJuFizvCAmrlUW7qyzVaVkkXRI5GeynQQxdNUIyWVrkDdl3qzDKRiwcFOW4glvaoM0ClstRRz3EJo1HFgj4zgLAaluPYdXmlP9OD7zhd1MEm2kBH4+QQKytQ17JaZaPsZ3Zs1Ram7fO0HPdj+R1EOkjz/f3qGV1TGxWtEcnHuSrc4FnL4ofMQTSM+sDBR9onKPYzylK3Yss32Q+oquefQl0hAvK/on+iNBIzgjCBpIyw9/DcO8UIhUGfLiO8NhHrWesbEjoDjy2SAz7CeTvIl2iCmXAZLwUkoD6mm20QRIGTJoqiYC5/rfWqY7NB6DTUCXRc/ndYIH++iWKL2xjFhrsGvlBquc5dlzx8+cdKYqbgvjvcB/cs8kWCLXD2EeM9I3LO0xR46mE0b/1DvHPNVA79BtfHMwr3e4Mpp0sEYYDFfRKmsqGyFyqegBNNcvfGXVrptG8DGZzURpZYMtDoCofBw6nMY1k5KRYCD2cAEEb2qVnQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(36860700001)(508600001)(82310400003)(4326008)(7696005)(70206006)(316002)(336012)(2906002)(44832011)(186003)(16526019)(6666004)(5660300002)(81166007)(70586007)(54906003)(426003)(8676002)(83380400001)(356005)(26005)(86362001)(6916009)(1076003)(8936002)(47076005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 12:43:40.9485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6939959e-5acb-4755-1352-08d969584c75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2886
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

VCE has multiple rings. Set the proper priority level for each
ring while initializing.

Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h |  1 +
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c   |  4 +++-
 5 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 1ae7f824adc7..c07d973a2946 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -1168,3 +1168,17 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_bo_free_kernel(&bo, NULL, NULL);
 	return r;
 }
+
+enum amdgpu_ring_priority_level amdgpu_vce_get_ring_prio(int ring)
+{
+	switch(ring) {
+	case 0:
+		return AMDGPU_RING_PRIO_0;
+	case 1:
+		return AMDGPU_RING_PRIO_1;
+	case 2:
+		return AMDGPU_RING_PRIO_2;
+	default:
+		return AMDGPU_RING_PRIO_0;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
index d6d83a3ec803..be4a6e773c5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
@@ -71,5 +71,6 @@ void amdgpu_vce_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vce_ring_end_use(struct amdgpu_ring *ring);
 unsigned amdgpu_vce_ring_get_emit_ib_size(struct amdgpu_ring *ring);
 unsigned amdgpu_vce_ring_get_dma_frame_size(struct amdgpu_ring *ring);
+enum amdgpu_ring_priority_level amdgpu_vce_get_ring_prio(int ring);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index c7d28c169be5..8ce37e2d5ffd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -431,10 +431,12 @@ static int vce_v2_0_sw_init(void *handle)
 		return r;
 
 	for (i = 0; i < adev->vce.num_rings; i++) {
+		unsigned int hw_prio = amdgpu_vce_get_ring_prio(i);
+
 		ring = &adev->vce.ring[i];
 		sprintf(ring->name, "vce%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+				     hw_prio, NULL);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 3b82fb289ef6..e0bc42e1e2b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -440,10 +440,12 @@ static int vce_v3_0_sw_init(void *handle)
 		return r;
 
 	for (i = 0; i < adev->vce.num_rings; i++) {
+		unsigned int hw_prio = amdgpu_vce_get_ring_prio(i);
+
 		ring = &adev->vce.ring[i];
 		sprintf(ring->name, "vce%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+				     hw_prio, NULL);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 90910d19db12..931d3ae09c65 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -463,6 +463,8 @@ static int vce_v4_0_sw_init(void *handle)
 	}
 
 	for (i = 0; i < adev->vce.num_rings; i++) {
+		unsigned int hw_prio = amdgpu_vce_get_ring_prio(i);
+
 		ring = &adev->vce.ring[i];
 		sprintf(ring->name, "vce%d", i);
 		if (amdgpu_sriov_vf(adev)) {
@@ -478,7 +480,7 @@ static int vce_v4_0_sw_init(void *handle)
 				ring->doorbell_index = adev->doorbell_index.uvd_vce.vce_ring2_3 * 2 + 1;
 		}
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+				     hw_prio, NULL);
 		if (r)
 			return r;
 	}
-- 
2.25.1

