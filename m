Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86826C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 05:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF6F10E2AD;
	Wed,  9 Feb 2022 05:58:26 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A10410E2AD
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 05:58:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9Ur6ooqsvprp4T0w/agV/CG6/RGLrBOa8423IVQXslNw9f64feU95U4q9qoX+ryTyu954+/NOEC4Q0HWsAbzhyObcdOyT1GU+QETP393hQ0nrVz/yprhfo3pcDlD/tgjpsZYEDEsM/m15HZkKIvvfVsgUClvKQNPqKOeKn7q+QFOMgpRspc04bxTvs4A/ErrKnedkBQhpCWSZRI4jiu9syWi5+PJIU+YLX/eDVQkwleIuUO4mokdN1o6KmajmRICgOfznKTEYr2AhZ/U2URqt6OleRZvqIAhQUGtgWGa08hj9y8F73FYQS937WJItJNMIF4WkIXAEtB21mmKULWmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRvuMxh8cqgyuyffNoU0Gwt+kAX3bNhspYYwrPg4RKQ=;
 b=PH/mvYPNsYUG+KnwWkY8ghHcmE7SVwjM+6FnO13Ff697ILpn4WcXlZmuOjROcnYZf0/3pjJncKCaunXD9ocV7EUneUxZKxn3gwthW6xyMLQCAbWE1CQ2oM94BbB8ouniL6CUamEkNTZFcgFyfaWy0tLuHRENPk0c3gl+cy8UhIh8cAhmVD8u3YkVo1uiO3h9isB7kSC5OmjV707RhMI/5VvRLlyoyM05w2vXTC3zwjYjG3yPA0PntRuozEMwjx7Zj4PEaLxYlE717M0pnKwmY1uSp3Do6ZqnItBjotR1lZN2b0sKg+UOtiTZ8nu5DjKFVISCMf9R+NMeqgTcENl/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRvuMxh8cqgyuyffNoU0Gwt+kAX3bNhspYYwrPg4RKQ=;
 b=wShE53NLZrBIDRucjw//NoCuUDxu37YjNAAfZTHBQrbuD/M7iNF5XhPKx4JH4Z+4VnpEH4hUxrqriR4C10gw3rjpke4ka5quBqsc4/W2LSSdJo+OhN1PyHeZQ5cF3d3p1Rc/pUWFrOwMghqIAXww0OZkMcIPdUTACob+o/WK/nQ=
Received: from BN6PR2001CA0030.namprd20.prod.outlook.com
 (2603:10b6:405:16::16) by BN9PR12MB5276.namprd12.prod.outlook.com
 (2603:10b6:408:101::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 05:58:20 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::dd) by BN6PR2001CA0030.outlook.office365.com
 (2603:10b6:405:16::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Wed, 9 Feb 2022 05:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 05:58:20 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 23:58:11 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/11] drm/amdgpu: Optimize
 amdgpu_umc_ras_late_init/amdgpu_umc_ras_fini function code
Date: Wed, 9 Feb 2022 13:56:41 +0800
Message-ID: <20220209055644.1873011-8-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209055644.1873011-1-YiPeng.Chai@amd.com>
References: <20220209055644.1873011-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88d92405-ca6f-4b2d-1559-08d9eb912cff
X-MS-TrafficTypeDiagnostic: BN9PR12MB5276:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5276539B421152E6F60B4985FC2E9@BN9PR12MB5276.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/ctidlwdAtigl//5oetMtjePwMTIuD3d+o8Q/4iyFboS3HpqXXXWDiqW87RcT+uzorvmJqVtV5iwh9CRRBmwgEHz4dXkEHWx41Mwc4GP+eUd+h4RbGwu9Q3hwoidrhR20KDCkXy0QGPEYPeDnmHV+vE87LGOF2INOh2hgxbn77dniY5UTEITKbgPtjsMb39371VONuH7m8H+1+Q/gS72VrNEJT/8cjAntdPz0aOEEAhhO+GzllURlSnFwMiBOcKVvGAz4RI7yvdGP+DZNzSpg4W6mH2zgte9N2w+cGilzDRK6QFhOw6mG+wxwNrX/3uHYBEr9XBlNhaRP+83f/4dRYwm6bPts6cEcOirvEuHTX753+dqq6VRKEYN+6heWCIu+4tRrUG9bPaLTJqpSYzRJTOJYZPva5zIE/KWxT9G9KqBYnQQKKAgqzHYkzGG4M6OTTN5tAk0yXTAT6qwPqgcB1i9QV6CTAitjcNo36veqSvtoWTT4DF0ByP4/C0MhINEiNcU6n7OYkWQEoD/U+tVbR0nNxbZuw9HecKRoNzVUtT5Qm4Dm58KMbTxbIyM2R5JFEmRJD/95b0rqdrDq8o9xlWKjnzvAcFL9xcznCa9SQ735rcquidhjo3+zB1RKUzSuk6E9ZPE+mWwLgT6Nf5O+291L/8LeIgJBx+SEsWMU7DowfSJDf522EDT78QRiBElIaP3RwLTQ9ZuGS6SNMOJZiCckGLXiRwDhVj4TO4ceQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(508600001)(40460700003)(2616005)(1076003)(83380400001)(36756003)(7696005)(6666004)(426003)(336012)(316002)(8936002)(82310400004)(5660300002)(186003)(81166007)(16526019)(6916009)(26005)(356005)(54906003)(47076005)(8676002)(4326008)(86362001)(2906002)(70206006)(70586007)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 05:58:20.6554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d92405-ca6f-4b2d-1559-08d9eb912cff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5276
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Optimize amdgpu_umc_ras_late_init/amdgpu_umc_ras_fini function code.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 44 ++++---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  4 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  6 ++++
 3 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index ff7805beda38..9f1406e1a48a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -129,7 +129,7 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
 	return ret;
 }
 
-static int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
+int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 		void *ras_error_status,
 		struct amdgpu_iv_entry *entry)
 {
@@ -139,36 +139,15 @@ static int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 {
 	int r;
-	struct ras_fs_if fs_info = {
-		.sysfs_name = "umc_err_count",
-	};
-	struct ras_ih_if ih_info = {
-		.cb = amdgpu_umc_process_ras_data_cb,
-	};
 
-	if (!adev->umc.ras_if) {
-		adev->umc.ras_if =
-			kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
-		if (!adev->umc.ras_if)
-			return -ENOMEM;
-		adev->umc.ras_if->block = AMDGPU_RAS_BLOCK__UMC;
-		adev->umc.ras_if->type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->umc.ras_if->sub_block_index = 0;
-	}
-	ih_info.head = fs_info.head = *adev->umc.ras_if;
-
-	r = amdgpu_ras_late_init(adev, adev->umc.ras_if,
-				 &fs_info, &ih_info);
+	r = amdgpu_ras_block_late_init(adev, adev->umc.ras_if);
 	if (r)
-		goto free;
+		return r;
 
 	if (amdgpu_ras_is_supported(adev, adev->umc.ras_if->block)) {
 		r = amdgpu_irq_get(adev, &adev->gmc.ecc_irq, 0);
 		if (r)
 			goto late_fini;
-	} else {
-		r = 0;
-		goto free;
 	}
 
 	/* ras init of specific umc version */
@@ -179,26 +158,15 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 	return 0;
 
 late_fini:
-	amdgpu_ras_late_fini(adev, adev->umc.ras_if, &ih_info);
-free:
-	kfree(adev->umc.ras_if);
-	adev->umc.ras_if = NULL;
+	amdgpu_ras_block_late_fini(adev, adev->umc.ras_if);
 	return r;
 }
 
 void amdgpu_umc_ras_fini(struct amdgpu_device *adev)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC) &&
-			adev->umc.ras_if) {
-		struct ras_common_if *ras_if = adev->umc.ras_if;
-		struct ras_ih_if ih_info = {
-			.head = *ras_if,
-			.cb = amdgpu_umc_process_ras_data_cb,
-		};
-
-		amdgpu_ras_late_fini(adev, ras_if, &ih_info);
-		kfree(ras_if);
-	}
+			adev->umc.ras_if)
+		amdgpu_ras_block_late_fini(adev, adev->umc.ras_if);
 }
 
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 4db0526d0be4..ec15b3640399 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -85,4 +85,8 @@ void amdgpu_umc_fill_error_record(struct ras_err_data *err_data,
 		uint64_t retired_page,
 		uint32_t channel_index,
 		uint32_t umc_inst);
+
+int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
+		void *ras_error_status,
+		struct amdgpu_iv_entry *entry);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 15958fd45f64..94095b965e2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1234,6 +1234,8 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 
 		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
 		adev->umc.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__UMC;
+		adev->umc.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+		adev->umc.ras_if = &adev->umc.ras->ras_block.ras_comm;
 
 		/* If don't define special ras_late_init function, use default ras_late_init */
 		if (!adev->umc.ras->ras_block.ras_late_init)
@@ -1242,6 +1244,10 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		/* If don't define special ras_fini function, use default ras_fini */
 		if (!adev->umc.ras->ras_block.ras_fini)
 				adev->umc.ras->ras_block.ras_fini = amdgpu_umc_ras_fini;
+
+		/* If not defined special ras_cb function, use default ras_cb */
+		if (!adev->umc.ras->ras_block.ras_cb)
+			adev->umc.ras->ras_block.ras_cb = amdgpu_umc_process_ras_data_cb;
 	}
 }
 
-- 
2.25.1

