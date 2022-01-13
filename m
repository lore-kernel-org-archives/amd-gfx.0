Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92926C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 13:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D051A10E156;
	Thu, 13 Jan 2022 13:55:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCB3A10E156
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 13:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuvX1Ek33ijNWXDdYbTu4y3GzqZDv8yTrOAXPxeHYHiGkpINoIXA6wFm7HYZswSS57l4/334JdbPgHZYZV++W/Nyg65sWdX1lU1RA+Qqe5IzG8LJ+/HmEwcYVWcxpcVXfHfw/Lh6aAUCHFuO7DYIwdpIWk03WA3DNN/GtfNEqr3bL30NLbMvqvu17HadHCx07y4uo+QFRczNnojNA9sWjOsZqJieZtSEgiQ/6QOxQiuNwxgT6Gia3oUEp8uPFWVxyKEyWOYPom7vAyL2I1nBBzd+7KcCagAgTUDIaWDSrAaI9E78z0nTBnP1KlY+k77bjmiZiXUlpNmxe6ludhhobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVv8K3D3wqKBCvRdBtp3uccGi/hAUUuHParHTuYQntw=;
 b=MHWBppM8/Fv/E3Q0iDtqZ1eEMia5rRI+9hJGag51MyxZsOGIj1lATp7w0gd/ZATKvgzb+LQ4eTGLzJUlTYfJw6kLtbJoA0Szw3EXBBg3DoLb2KzSaHsS4novCZsBR2sw5CXJb1QXs6pRUZau2WlUgapxo1nylBy1wt1qqeaSuRhM01h9R9+7w/1OBybTIlO7GFKlRRbB/tvvAULB9pCDP1gVX97IdpMhQUBmT7nHFyQOnJp8tX5pmNZHHCekBk/M3nZGPHf+Xw1wT4sqhfM+vKMkMIvZqRLlKAMAgMS7fV+y2Ingwkvv4vsdPNNjTdmPx7aptWrIvdZv7rk7aeecDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVv8K3D3wqKBCvRdBtp3uccGi/hAUUuHParHTuYQntw=;
 b=wZnKPGM39GNzlr5spj//+5emmYYu3HTealb9ifDdELUKSs/YNa9xB/XLBaLGG39Dcrd9K6yVRLtHfJoOtyFPIo16FQaKZJcj04LCUrEQj1Dvx3ZhHmkAupn8Oy98VO2H5vfttYGeqm3ZLppVCB/LtPVwafcbDYk9xb7Ibw+PYhg=
Received: from BN9PR03CA0983.namprd03.prod.outlook.com (2603:10b6:408:109::28)
 by BYAPR12MB3173.namprd12.prod.outlook.com (2603:10b6:a03:13d::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 13:55:18 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::d1) by BN9PR03CA0983.outlook.office365.com
 (2603:10b6:408:109::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Thu, 13 Jan 2022 13:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 13:55:17 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 07:55:15 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <veerabadhran.gopalakrishnan@amd.com>, <leo.liu@amd.com>
Subject: [PATCH] tests/amdgpu: Add VCN test support for Biege Goby
Date: Thu, 13 Jan 2022 21:54:57 +0800
Message-ID: <20220113135457.17020-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bc81a6f-ca8f-4aaf-6438-08d9d69c54b2
X-MS-TrafficTypeDiagnostic: BYAPR12MB3173:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3173837301E9FD4B2DF7DAA5F1539@BYAPR12MB3173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:256;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FrG230HVprvX8kArtcJbGXwWfGWhEy7ibQvhfp60NVc1GxfziJGJrqdFqTqNR5vrEON1kfArFV3vFbZ/LZ3MrxscpPCKA6CV5xQjCA/SDgWmRt+UlWgmkdLzmRVWtUJk7e5fXCPV1O2U4AlhsXygB4DkmsuNPZHZ8sxzjRc/4A7Wa6XfbTah55WyfkHOu2J+NdakIDLeK+pPFIJDta73bsUe/oxjmgv952naIUxC517wMmcQo4qMJ/h/XPyQnwFnrdPvsWeNsWEyfB5gTMoUiMU5p8RbbWafzmlg2W6VjDgU1SyKHR7xL319NJ1b6YD3FJrm0BU8eD1peiDxYTNNfqOE5ZAOGrmfwA37R5dRlKml3XiAgfzEujzbrNFg1djLYc4kyy2eMVgrvBCQE/JqbTMf+51Z/swwl4LyKvu9+nRaa+Ob0tHz22dCwuE7u196cvLKiOYmNRXGroasbIZD8Mcz1e4YBIZ7mReOZ8qLH74F1Ub6SSuoDCNhpsO97QSrpYYSnlPp7OFxf5IA6xheXMBd38OS3VmeFXjhzUSsAslblEUgKU84bnfafTQGa5KMp+hGX3XrooEm9Ju/kzx1IKlVHRHPxKsKHwTsp2gaZLkPV7O8iaSiFJjTCBVui4cViNvXJ1QXoP6KFJ9OatBNImLkidxYmobIHx6gbs1F2dkD1HbMUFUXgqGvaicq3O00fzLePFf5k2YHPTvZ6z2ul0H7T7j4RUu/1aGFEISLP8m+qlhpzJ0hLq3oqC0CKd+2+L23rgSv6J18Z2oKEs1tdg4h6G+OILrlprjiqyymPFeAxdnGOLzu7AE2HPEmW7k
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(8676002)(7696005)(186003)(86362001)(6666004)(36756003)(2616005)(2906002)(44832011)(16526019)(83380400001)(8936002)(70586007)(70206006)(508600001)(81166007)(336012)(47076005)(4744005)(6636002)(4326008)(40460700001)(426003)(26005)(82310400004)(316002)(36860700001)(5660300002)(110136005)(1076003)(356005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:55:17.3386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc81a6f-ca8f-4aaf-6438-08d9d69c54b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3173
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Added Beige Goby chip id in vcn test, will open a MR to
merge this on gitlab after review.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 tests/amdgpu/vcn_tests.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/amdgpu/vcn_tests.c b/tests/amdgpu/vcn_tests.c
index 628b4910..15d573d3 100644
--- a/tests/amdgpu/vcn_tests.c
+++ b/tests/amdgpu/vcn_tests.c
@@ -142,7 +142,8 @@ CU_BOOL suite_vcn_tests_enable(void)
 	} else if (family_id == AMDGPU_FAMILY_NV) {
 		if (chip_id == (chip_rev + 0x28) ||
 		    chip_id == (chip_rev + 0x32) ||
-		    chip_id == (chip_rev + 0x3c)) {
+		    chip_id == (chip_rev + 0x3c) ||
+		    chip_id == (chip_rev + 0x46)) {
 			reg.data0 = 0x10;
 			reg.data1 = 0x11;
 			reg.cmd = 0xf;
-- 
2.17.1

