Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67694C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 08:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0820010E56D;
	Wed, 10 Jan 2024 08:27:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ED5D10E577
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 08:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oShcOeh/mUvM/xDiiwzfAsrStA7Y2NwTLASuOjfbJ5eUO8Uaym5ubRN4RRyo2I91owBScZP1jxOMCz6UIPee6FRpME/BTf+UuKzFcpLXW+MvVenpo6M9mZU5WzK5YV1NgzHjfwOoXQIrsKIF0nSpJgH7O+aPhWiAmpRkrUlC38OamDHdnwLW5H2q0Ud1f0Cez0a+y5K6hQRTAKFnTblkYwz/jhgikaMoJW1c+JMkFb/pdtvpceT7nZzd4dg31rrMkgILmtIVHl3MkPhqE5vfCLSIPMUU7QubNw5KlsiviC/lC/rF7ovZ/JI5YxFypYbaSAAQLEuDjcyeeBpO21jXLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvvTsVpPNcd/a/rN8AytdjRzIOMCwkWQUcR1I6hkDnE=;
 b=jGhaxSdoVH6bN9uliSjPXwsIOkolYgC7aM6YupeCUhFhTzoWygoQK9ug6qrcY0OsEEJqdehBO4sCIlCFne9XBJNtw+T7jojpHEKxYSiue5+jb05OHdUAp5H8m0Yizk/DiSA/8oi90Phj2+lMUm2pjwut93T0ecKsiKZO7ErDNy9EswLjmne2t4siMF6bAzzvvAMjMtL5tZ8xm2VQlO+UUrhOn+ZOt+yK/yOvgHLhAD4TpCzoInlIdH10Z2XZu6qDjOaGDicM7xGzqrnuRxS3levd7dw4ivlp4BKxXlOgMDW31mbOT5/dXpqfc0IHmws0E2BhnlJ2ewk9SljCBXs3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvvTsVpPNcd/a/rN8AytdjRzIOMCwkWQUcR1I6hkDnE=;
 b=Om6D3pAyIB6SPZ+E8aCMZ69lMBuqKE3e9rneQ4CXCSbyAz6VFbs+yxtKZtFXotrJ1h1S0UIw1aUhVYA7ObcaoWzZflq2y6kmzhsyQIlB+Q7FqojDw/W3PNhibWtfzDITEWW4oS22Bq3UeoeGb1xddJeWF0V1zyA2Xcry7ORs1Pg=
Received: from SA0PR11CA0191.namprd11.prod.outlook.com (2603:10b6:806:1bc::16)
 by CH2PR12MB4873.namprd12.prod.outlook.com (2603:10b6:610:63::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 08:27:02 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:1bc:cafe::32) by SA0PR11CA0191.outlook.office365.com
 (2603:10b6:806:1bc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 08:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 08:27:01 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 10 Jan 2024 02:26:59 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Fix 'node' NULL check in
 'svm_range_get_range_boundaries()'
Date: Wed, 10 Jan 2024 13:56:44 +0530
Message-ID: <20240110082644.405086-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CH2PR12MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: f7842bea-2f93-4b6a-ecf3-08dc11b5ebae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thq2visvHxbpzOjbxd1R7Bk9ti6rTpEtm+fl3iAlJYVAjEgxDB3l7bLYqRzXqDaEnXonvKwkkJzaevgEy40yOsbXuHo7NvVTg+v8v2ZJqFU+onckACYVJV2Ana6FaTCm4LypFMx/ub65sjT+8fgOsZqsHFBtB3wIql3ZRk+ehDZ02gSkXPQ0OTU12GjJ6hc8iIIpR1NqWYv0BQ8+5Z5n+T6kXLwQ2g5EYNKVQDFA9xJRb/5GVqnBjcyRuP/YrIG6jpPPRb7zWC067sWJWay/5HkgWww4M5nQpHzzSE+JfsENT5zlnrB5SYtpXJm2AGevttLCliO0bwDIXrLYy50dzNMcOD0x+QyZ5YPmxTVTOH0q5KD0KdE+F0WEY/9gJfWkKAkifMkKd2RaUV09cErQ4a6JRUrX5PoNte2R1yLv7J5aB8jHW9gy7RrHhocWHE0Ll9c/tPN9G7MLAdwwjJS0n2XLM7ZBnApGrt2Ot9FFLTOk0o/OYFx/9+STZRvgJJJB1M16PwwllXsJVaaIM15JrQPDXOTIhDuv6H2xfMkjFqFGUaOkYmMIkdJDq5wuhFfXfDfGWIci60ex9yCOikIla0h8J7Q3RD1AgH/4gWGUucCma11O9Ygeh1iPEMiekrsuP7LhjMCzTmnxuy4KSnq3k/kHND62sSuK+QXyBEcU8wviTQWyknXuFIy+5x1OvbYS+Ub88XJ+q4SOILtie4YFUWqb7cQDrDo2Vxi1OQqqnrTF1ehkyw9/ZY0wzev3bOrnGRqC3DmKrZ9t9/Vwy/pp3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(36860700001)(478600001)(82740400003)(6636002)(316002)(54906003)(110136005)(356005)(81166007)(86362001)(2616005)(6666004)(7696005)(66574015)(336012)(426003)(26005)(83380400001)(16526019)(1076003)(40460700003)(70206006)(70586007)(40480700001)(47076005)(8936002)(8676002)(36756003)(5660300002)(44832011)(4326008)(41300700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 08:27:01.9849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7842bea-2f93-4b6a-ecf3-08dc11b5ebae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4873
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
Cc: Philip Yang <Philip.Yang@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Range interval [start, last] is ordered by rb_tree, rb_prev, rb_next
return value still needs NULL check, thus modified from "node" to "rb_node".

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:2691 svm_range_get_range_boundaries() warn: can 'node' even be NULL?

Suggested-by: Philip Yang <Philip.Yang@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3b78e48832e9..6aa032731ddc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2656,6 +2656,7 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 {
 	struct vm_area_struct *vma;
 	struct interval_tree_node *node;
+	struct rb_node *rb_node;
 	unsigned long start_limit, end_limit;
 
 	vma = vma_lookup(p->mm, addr << PAGE_SHIFT);
@@ -2678,16 +2679,15 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 	if (node) {
 		end_limit = min(end_limit, node->start);
 		/* Last range that ends before the fault address */
-		node = container_of(rb_prev(&node->rb),
-				    struct interval_tree_node, rb);
+		rb_node = rb_prev(&node->rb);
 	} else {
 		/* Last range must end before addr because
 		 * there was no range after addr
 		 */
-		node = container_of(rb_last(&p->svms.objects.rb_root),
-				    struct interval_tree_node, rb);
+		rb_node = rb_last(&p->svms.objects.rb_root);
 	}
-	if (node) {
+	if (rb_node) {
+		node = container_of(rb_node, struct interval_tree_node, rb);
 		if (node->last >= addr) {
 			WARN(1, "Overlap with prev node and page fault addr\n");
 			return -EFAULT;
-- 
2.34.1

