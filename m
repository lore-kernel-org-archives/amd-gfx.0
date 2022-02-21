Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49194C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 10:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF28110F22F;
	Mon, 21 Feb 2022 10:17:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E3C10F226
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 10:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSGXlioug3YNHu+QWq/5tQ2fe2fFQ6dN1ewJfXBG6pBm3OE7A7+CGHBMbcEE6slyz8JYSC3sGflidlA111014wUZm9Matw5bq47fy4Gc/AjKerWL8s94om2YduogGhL7oaEyAs9eAET5btZHLE9sI8/1P2F7x9yb4+FJqA1WyMO8NxqHqDgK5MBfqZqlRIYNAmxE4oRevsRBPeAJseDPrlWVpEuMmU8s5wxFWl1qmrkaY9Pw8hhs5lWxHycAjjEUNGIH6YEjCYJ9sQG5W8vcPjqUY8Mvm/SWsRwhFuVxWE8Wy8d/6Jbhuy0H2kKibM1bvrKcYd8IDHOkRxHlZLFuyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiB3reyYNvqybGzJTyHVLVgRZaxUuMd9LBydcgWqJLU=;
 b=UFW8NOSSh/nEL854LvRG30DvLU90l7sOiz2dRfFjIyvULeEfsCZYsq3Ka/q48yhPpn/LVzZULsYXOCdVNKmsE2uPjh6UbX3JaVtYZmQYOic9XRiJVUYwWntp9SVXBS+KFlUbgSg+1x9Sd6sa50Durr5XSwPrMz0uiUyAb0mpAS6DK9vnR/eKxQIrVmTNUubjW/cYCxS34SHg1NElBAcZ/43FhpMMl055TzbIFBk9QsCvx7iBYUrkY4HXVlRSDJ7+KtR7Xqt6hjqNXvV4ZLh1mFbKBSNhVNYRjv+FK4GzqSZK3wMJoXWHyRipriSFk5QUHzaQ1BcY/RJv97Z22O5qUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiB3reyYNvqybGzJTyHVLVgRZaxUuMd9LBydcgWqJLU=;
 b=GDMyV5BXiRgGfVQiAbV6c4z8e/ru1v7nAdksV5J0OUpqKBF74vNrn9XlGcHaPJUiK5KFevOZx0Tmqz/A+3p3vXkeFngSVznp2mysiVdWlOwJQoCGJkGaMJqVRFXpmq1bKK+OcTOHbQxVv5de3xqhwWzvnxrXMQ/2flmafEeLEEc=
Received: from DM5PR07CA0025.namprd07.prod.outlook.com (2603:10b6:3:16::11) by
 DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.14; Mon, 21 Feb 2022 10:17:04 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::b3) by DM5PR07CA0025.outlook.office365.com
 (2603:10b6:3:16::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Mon, 21 Feb 2022 10:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 10:17:04 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 04:16:59 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amdgpu: Remove redundant calls of
 amdgpu_ras_block_late_fini in gfx ras block
Date: Mon, 21 Feb 2022 18:16:12 +0800
Message-ID: <20220221101620.3269611-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
References: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b9ba343-992b-4eb0-0044-08d9f5234f25
X-MS-TrafficTypeDiagnostic: DM6PR12MB4417:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4417515EC7A3A0133C2D15E0FC3A9@DM6PR12MB4417.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5XqPWyzWLoZPFw899z/kQWFnI9ycnjlhfYsYoBjt4OrQFIDtCc0Pbw4dD33Q0AWQb95i5np9zb/vm33BPrrpG+rQI4lRzWWOV5MICbLeOGFsBoVyjl+oyMYHALRPJli4MdvhZrSVgyRnLPvCiNt1x2CAFE23oiF5naPFdrwcIYr1oTAZU6sBeZn3PB+NqpOtWp3gwrGuCwRf4i78NyYHbIKlHpaPbi1ptDbeWVLt0k0Gqbx3FpBnYDS0wM13YvvTwiJmhjdZfNMDvxIc95WxtB2yGRi+IfhJ4JVbsGwL+pxv2HUfxEKuzR7zxM9g0aFhFo6WADlAU6nEoikUSL9RyRmlXAm5NFolNP+alAWKY5ZRpw5wnKc2jjjUqFgHka76bIsd5Yh9/okMRKw4mqjPlN+RlKQkEt68ffXomtKXoM3vPlku8g9DFQ+azL/fVBv32CBkkHdtEHIbtoS/A/H++d99laGH6CTX5cFoyUe0BK7D/IX5Tbs74Acc9tNfa+N870/RErHVWLQB3dz8mfudUtKKAV4rabc3lzxn6lgITR8QsmWaLsMfKixE9efxll8JeC9zthXkSE2RG52V9l+o2mdNiZrMMxOF4V9MCAftKPsP8/bnWDvp0WmBYA2cHygj9E5Jq2hAC2RnDkEq9x/eRKTXxTF2cI0fiJnb5mavmZiBgTMBpY4IuJXYcd/K1iDuqaGHqoitBQ8rCKJs4EoaPNemW7QlSMClIEOvj3HYyso=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(70586007)(54906003)(40460700003)(6916009)(6666004)(426003)(83380400001)(8676002)(508600001)(4326008)(36756003)(70206006)(7696005)(336012)(2616005)(8936002)(16526019)(2906002)(81166007)(5660300002)(1076003)(316002)(36860700001)(86362001)(82310400004)(356005)(186003)(26005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:17:04.9027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9ba343-992b-4eb0-0044-08d9f5234f25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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

Remove redundant calls of amdgpu_ras_block_late_fini in gfx ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 7 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 40f7e29aa9ca..8fe939976224 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -644,13 +644,6 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 	return r;
 }
 
-void amdgpu_gfx_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX) &&
-			ras_block)
-		amdgpu_ras_block_late_fini(adev, ras_block);
-}
-
 int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
 		struct amdgpu_iv_entry *entry)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f7c50ab4589c..dcb3c7871c73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -387,7 +387,6 @@ bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
 int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
-void amdgpu_gfx_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
 		struct amdgpu_iv_entry *entry);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index dc6e6fe6c978..f0cc073e6bb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2206,7 +2206,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 
 		/* If not define special ras_fini function, use gfx default ras_fini */
 		if (!adev->gfx.ras->ras_block.ras_fini)
-			adev->gfx.ras->ras_block.ras_fini = amdgpu_gfx_ras_fini;
+			adev->gfx.ras->ras_block.ras_fini = amdgpu_ras_block_late_fini;
 
 		/* If not defined special ras_cb function, use default ras_cb */
 		if (!adev->gfx.ras->ras_block.ras_cb)
-- 
2.25.1

