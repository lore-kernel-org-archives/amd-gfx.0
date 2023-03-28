Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FD3C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A687210E8FF;
	Tue, 28 Mar 2023 15:14:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF8610E48F
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFG9altJVvPMK7w7zUqrq/WwwS4qUuRqCvhHJYEMYQfiCw05HMPqQEWYvumCnG6oS8bezbjytMZi4O7LqZBA4DVv4NqQiVOsT0Dg3rhbpDNB44xWjOx6jo8ayG0UsWhTKPRJp0IgBQyGz17JsqSmniCbkUe1q0ftVVlZaxQK2HNb5b3ErDvJR7TxzDl/XonDrWoPna8zIclj3QzEvIrxh83E2d8jn3FAKyxh2hVvIoX39VmCLZaHRK/1WjhXqMGmIsYKA+3243TQISz6vDwda5DgdraO8D/Y438tkPPNi2XyZMztG2iDAnBmp5XiPj7pDBnoOuaHAgKuOXiYC55PCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdSwg6lxITuUJhY1DeLjtfSDbjHYkkShjspXdArWB7A=;
 b=COHi71dM1bnWji2rOZpdAwW0qj79E3dEyuu+WcIfQfKgIciLITDKdZfidcDvX6gNRxllA4sSKB1d+73pMEuBtqjceI87XRnguIH/GjP+MaCOxccrT9T2NmWQcO9t+WWW9dA8GOnbc5z4S8+RpWWQ5PMrmBvzRZfEVPaBo+lwRxaHhn4xJ1xr/qEM2jb6jdPCyFf97GDXXjWTBJthYioW8guRVr+CakWZdTKEjUZjKgCrrt45Z23a/h/uhv9Frm1/RZgAbX+KtvBoqgj2jdmmFV8oBhg6XKFErf1gIGZLtWT3aovhNKIyvdrNf9KF91mNNEpj5j2wYRqz9R5qpmWtrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdSwg6lxITuUJhY1DeLjtfSDbjHYkkShjspXdArWB7A=;
 b=b7fBbRfILyzPu5T/Szkhx9mIZn1ITp+3jnTFE1Kml0UIMhg6xU8lMNBC0DiARNdsyi3iY/481OxeXO3qtbEixDo7whfhJgO1R9I4v115RPbvTtD28f7j4+VOmUsrYWB34OmcSEKXtrS1nuJOA7rD15X7+tOlKEMjPdkvGtyBKiM=
Received: from BN9PR03CA0071.namprd03.prod.outlook.com (2603:10b6:408:fc::16)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:14:11 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::f7) by BN9PR03CA0071.outlook.office365.com
 (2603:10b6:408:fc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.9 via Frontend Transport; Tue, 28 Mar 2023 15:14:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/32] drm/amdgpu: add node_id to physical id conversion in
 EOP handler
Date: Tue, 28 Mar 2023 11:13:15 -0400
Message-ID: <20230328151344.1934291-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 674dc84f-6724-413e-8c9b-08db2f9f1576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kT2VMAtGvjxfOdRfW9JIJRodmZB/H9lllyeN5vd6sp+0U1PBq4m22V5BBrQE1GLgTaDq7lGJw2kftU5xKRioPr1t27bk/RWMqmyD/NDvp74foTEZV7pfSr9ToTbYUNg1PZmCtyZ8/sNLcBsvGNPbN8jrocAjOdfMVpFJPuIjgH3UEl9pJ7OBtYU7V1PJRR3BbU2jfWEQ2iMWYASkVjZo1Wb5DmwZ+RFxwTb7TYiWS4MUbd060/SsOWmi+r65bb5zEC7HNYoyT7tgkZY2lEvTCiZR8koe1ymdvqWx4IoqvDXIRyNRZI+FnLCZvzuI+/kqf6ApVLgEPEyFFJwN6oz5dvuFsVQyXKGjSnhxdQX5ujq36UBcrOBdA2XDZ//kSYfXUN3IBRKo6MhrQMhEuPTyk3gTbM3tcfkb/CAuY2L6Gao+5KwI4HXUPGiUkDzz5gSBFVPtljnEsMgWGIAww5h71NROnODhoqArbvATFVQZ6xWqDQZsNee4LqsLAlQbhLrgUKOW55dvgCUY3VxnFMhMB+fFmRIg6OtepaeKhCS08bYa4ZhWjgcqPRsowDvfXj+nRFHUSx7nrqzXBokMTwRGR7yXtDO9RLCbk6m/UuX7Xtg+rw4f3TUV2jRjUTQIBdR7WW3RBwmOu8uv2beppGc+fA1yMDAHEiDwm/iHRvgqMr4T0kqZZjTO72kXgxU6RcETf2szSxPhR09uQqTEk5+IS7gCEH+zLm2bfHRYM5Dm7M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(82740400003)(4326008)(81166007)(41300700001)(8936002)(5660300002)(356005)(86362001)(40480700001)(36756003)(82310400005)(40460700003)(1076003)(6916009)(478600001)(54906003)(316002)(7696005)(6666004)(26005)(70586007)(83380400001)(2616005)(8676002)(70206006)(336012)(426003)(186003)(16526019)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:10.8984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 674dc84f-6724-413e-8c9b-08db2f9f1576
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Shiwu Zhang <shiwu.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

A new field nodeid in interrupt cookie indicates the node ID.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Shiwu Zhang <shiwu.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  6 ++++--
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index a6aef488a822..31c6332190e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -100,6 +100,17 @@ const char *soc15_ih_clientid_name[] = {
 	"MP1"
 };
 
+const int node_id_to_phys_map[NODEID_MAX] = {
+	[XCD0_NODEID] = 0,
+	[XCD1_NODEID] = 1,
+	[XCD2_NODEID] = 2,
+	[XCD3_NODEID] = 3,
+	[XCD4_NODEID] = 4,
+	[XCD5_NODEID] = 5,
+	[XCD6_NODEID] = 6,
+	[XCD7_NODEID] = 7,
+};
+
 /**
  * amdgpu_irq_disable_all - disable *all* interrupts
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index 7f78340f3572..a3543f121747 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -101,6 +101,20 @@ struct amdgpu_irq {
 	uint32_t                        srbm_soft_reset;
 };
 
+enum interrupt_node_id_per_xcp {
+	XCD0_NODEID = 1,
+	XCD1_NODEID = 2,
+	XCD2_NODEID = 5,
+	XCD3_NODEID = 6,
+	XCD4_NODEID = 9,
+	XCD5_NODEID = 10,
+	XCD6_NODEID = 13,
+	XCD7_NODEID = 14,
+	NODEID_MAX,
+};
+
+extern const int node_id_to_phys_map[NODEID_MAX];
+
 void amdgpu_irq_disable_all(struct amdgpu_device *adev);
 
 int amdgpu_irq_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 5cc4c2c31b3a..3682b0a64200 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2805,7 +2805,7 @@ static int gfx_v9_4_3_eop_irq(struct amdgpu_device *adev,
 			    struct amdgpu_irq_src *source,
 			    struct amdgpu_iv_entry *entry)
 {
-	int i;
+	int i, phys_id;
 	u8 me_id, pipe_id, queue_id;
 	struct amdgpu_ring *ring;
 
@@ -2814,12 +2814,14 @@ static int gfx_v9_4_3_eop_irq(struct amdgpu_device *adev,
 	pipe_id = (entry->ring_id & 0x03) >> 0;
 	queue_id = (entry->ring_id & 0x70) >> 4;
 
+	phys_id = node_id_to_phys_map[entry->node_id];
+
 	switch (me_id) {
 	case 0:
 	case 1:
 	case 2:
 		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-			ring = &adev->gfx.compute_ring[i];
+			ring = &adev->gfx.compute_ring[i + phys_id * adev->gfx.num_compute_rings];
 			/* Per-queue interrupt is supported for MEC starting from VI.
 			  * The interrupt can only be enabled/disabled per pipe instead of per queue.
 			  */
-- 
2.39.2

