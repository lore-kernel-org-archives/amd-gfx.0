Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C008BC19F4F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 03:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00EFE10E543;
	Sun, 28 Apr 2024 03:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nQwHrr2E";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1BE810E543
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 03:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2Gx209cmey26P6OMWlZhYYRX6y+5GVRFcwCrC0akLpGzKsrm0hkNFcwHltU22wRYDOmfCWgFb/LSFbMDgpCTPioZeZH6mwV9i1rbOs40yc8z90FjigTi8wWEu2zwyCT/n0y1XSLsXqkC9nFltjR/itLT/SDozxhbANnBLh5o7ppr4n9cFU4rCtQ8aebmaeMG8YPZGu3z/26BJ8fKQNEDG9ianmMe/b/WsIDnF0VW1K2jD0ZznnANBrlVebfjNWreCeuUA7+4ESz2n2NKdsmF2Adv5gbQ+4XhmclP9IXcrIaKS9ZI+Agy8FGPWpqybUhDX/DmCLE9db7vivTVLzorg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkIFMQ3CDmU+/sJNrpsTIEXdeMlVJ5iSjjaSDDBobPU=;
 b=XZgydiVJuo4vqE80shyxuKPJAuMC5tUxWNpvJKyrXpuZtp2Ju3MWFhP3HnXoxbuxqwdmOFbPk/Af7yWcyakutGn/+RHmDQ0ZpA5uf45yyuhztEosV4Cd6dYfSZ2/tr39EUiYU3OZ+LKcXd/LrtHX+UZICIp131UPe2g9o0p48Vp6e8QicNVogJ9JIz9ffIj56NUEgkbROrJKawjZtrC0V+osy6d1w3tnUoA2qKHJD6lodkmaJhsdCPQmknsDfdJ+dZqtq/35fzksxYF3IoaHIKA84TVr6/b/m/Woo96GBLEX4co17AvaSrtwR0pW1mXOWdzFVaJ87nJzNe3RDykDrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkIFMQ3CDmU+/sJNrpsTIEXdeMlVJ5iSjjaSDDBobPU=;
 b=nQwHrr2EsRHKPYfh1IDZXxQxZeIS5/T5jKk6djDlD0lSrPL+q9Auj1XdEh4F9psM7+mbDVCUFmvgYyqxV2EeGW8PeN24KWzSLpBEYrStO5ESVqGpFxQ9fdxyrnYZn9bZ7GgB6b57KK6X7kCxQi3OsbbO9V/2ISaWo8pE673+e1c=
Received: from CY8PR19CA0033.namprd19.prod.outlook.com (2603:10b6:930:6::9) by
 CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.32; Sun, 28 Apr 2024 03:33:27 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::4e) by CY8PR19CA0033.outlook.office365.com
 (2603:10b6:930:6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31 via Frontend
 Transport; Sun, 28 Apr 2024 03:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Sun, 28 Apr 2024 03:33:27 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 27 Apr
 2024 22:33:24 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Remove redundant function call
Date: Sun, 28 Apr 2024 11:32:38 +0800
Message-ID: <20240428033238.16508-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240428033238.16508-1-YiPeng.Chai@amd.com>
References: <20240428033238.16508-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5d0b12-768f-4dea-8b1c-08dc6733f785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3Js3R1bWpjcMCmLPbVZcRLR12SrQ4Gv+RvyPbDUvxz/0d05LjntT0hEySdRL?=
 =?us-ascii?Q?y4DdFrq7nE4ZnL/DuOax/vyXo8caUqaYmEe05H9uULy7hFSROKVzeZEbouer?=
 =?us-ascii?Q?KYBro56+F/sev0bnZlBxiqeTVooMJKONLsKo28uQ87lfy46tUTqsHyOQJPO7?=
 =?us-ascii?Q?DVDeZE1Jf1b1omtWtXzOJ4tereMDPxhyICSlc6uoX/fau8aZ8+IU++X25eyu?=
 =?us-ascii?Q?yebRfqbYh1cGGPJVjhyt7wQ73iLCkqzLofAKMCLNpiTgO5tnb86gjQkDCaDs?=
 =?us-ascii?Q?iJSCZmQdLEW0kSOVadd2158Q5SIeYD9jOCnSDptaHoyadZ3xHq2Ay6ffoeaU?=
 =?us-ascii?Q?sfPhk5kwU8mbMJ3NQrF8CBs46g0wuJ2d1ZpDtChNmLvBsgWaWWdw3KY0qgqB?=
 =?us-ascii?Q?5P6hZsEbXTynqTN4IKbgdt+j6tpvnyy8kxV4r+Zl1RDMCI2KpJhmGYlZ9O0H?=
 =?us-ascii?Q?4Nq50PK7wYHKQXXUYVeMsR9Tt+DsG81KoyEifsQkpNgKNKnoF8VjE8wGv3/q?=
 =?us-ascii?Q?TQjSVAIQ9Weaau7L0WVNIL48AZOHnUggS72sCNKS9LKyGmqnvyZ6Nz89gxMM?=
 =?us-ascii?Q?UuCy+MC8j/gUU1R15vrIz44N8CFs7jhanFr1BoRoPCzW9hAR9oELxFAZa0Ey?=
 =?us-ascii?Q?hRZTQ4MapJxNZHwK0ErM5V579zNXiPq4iVb78P4NDotkxB6Donx1ZsKS+Mnu?=
 =?us-ascii?Q?z5Hf6laQ6Fb+YIdqfkoqwR2ZC0etvXxby6ifSpgAgRrySWmOZ4OACEmE0Qtp?=
 =?us-ascii?Q?lbBzRibFkuc57aXz2PhmPINoMbIp/IZ+19aSHG2sZSTzF30p419B5/VbWD8U?=
 =?us-ascii?Q?DWLh4VGmjVL7QRE9IfjgwCTMPeeWGWgfOOykcgJuBLpt5WgpikSktZIAbd9I?=
 =?us-ascii?Q?rkpglMx7PZ8mBqnQYizNrSzSDWBg7i7miTu/ABcA3r8KBjTOREC0Px+bhpg5?=
 =?us-ascii?Q?y6EE0smlqF9j5htQv4BgfXrO3kbfVcex8yX7vq1Q97oMAN5jmemxNN6/DF+c?=
 =?us-ascii?Q?ynYJ2uQEeQJmiVe5HAGDHncS4ovxcWgAwT7hsbVRj6tVoz4cw9buByHU08cy?=
 =?us-ascii?Q?p124I31RKdrAhbS8LpGlXV7Q2O6nHypEyTEtJaorF3LSwwSoGkyM03ivi+3I?=
 =?us-ascii?Q?IaWlwoSHuOe9Sbkr0tcqqNfECVPXNXKxfj0zjV7t9nGFar3cf4I6MH1DkPoU?=
 =?us-ascii?Q?629P85pMCd7Yj/+oQrCylfTOGWZg+6aGbpgw6b2ipFeB9dr0yL8C6uQsyFvC?=
 =?us-ascii?Q?ntoBdf74UdVQxCKx55wgqdwzQnPNB+/shmqMBrAZhtgR6g3DXFfd54PZ24H3?=
 =?us-ascii?Q?7dGoWCT6Khwr9a0AHUzAaM8sLOjQkRURdBtHT4D8J1OQNeKRKAngbt1Z2HQ/?=
 =?us-ascii?Q?csJDhCo8o5g0/85QMBrM1HTHnOdc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 03:33:27.2391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5d0b12-768f-4dea-8b1c-08dc6733f785
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732
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

Remove redundant function call.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 11a70991152c..7f5342539c17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2794,8 +2794,8 @@ static void amdgpu_ras_do_page_retirement(struct work_struct *work)
 	mutex_unlock(&con->umc_ecc_log.lock);
 }
 
-static int amdgpu_ras_query_ecc_status(struct amdgpu_device *adev,
-			enum amdgpu_ras_block ras_block, uint32_t timeout_ms)
+static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
+				uint32_t timeout_ms)
 {
 	int ret = 0;
 	struct ras_ecc_log_info *ecc_log;
@@ -2804,7 +2804,7 @@ static int amdgpu_ras_query_ecc_status(struct amdgpu_device *adev,
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	memset(&info, 0, sizeof(info));
-	info.head.block = ras_block;
+	info.head.block = AMDGPU_RAS_BLOCK__UMC;
 
 	ecc_log = &ras->umc_ecc_log;
 	ecc_log->de_updated = false;
@@ -2812,7 +2812,7 @@ static int amdgpu_ras_query_ecc_status(struct amdgpu_device *adev,
 		ret = amdgpu_ras_query_error_status(adev, &info);
 		if (ret) {
 			dev_err(adev->dev, "Failed to query ras error! ret:%d\n", ret);
-			return ret;
+			return;
 		}
 
 		if (timeout && !ecc_log->de_updated) {
@@ -2823,21 +2823,11 @@ static int amdgpu_ras_query_ecc_status(struct amdgpu_device *adev,
 
 	if (timeout_ms && !timeout) {
 		dev_warn(adev->dev, "Can't find deferred error\n");
-		return -ETIMEDOUT;
+		return;
 	}
 
-	return 0;
-}
-
-static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
-					uint32_t timeout)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	int ret;
-
-	ret = amdgpu_ras_query_ecc_status(adev, AMDGPU_RAS_BLOCK__UMC, timeout);
 	if (!ret)
-		schedule_delayed_work(&con->page_retirement_dwork, 0);
+		schedule_delayed_work(&ras->page_retirement_dwork, 0);
 }
 
 static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
-- 
2.34.1

