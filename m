Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77491C7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9ECC10EFF3;
	Thu, 30 Mar 2023 19:43:01 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD6AD10EFED
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmjAhE+S5aHI9pHGNvg+Xid5oZ6buzFSyQBipjFRUIcn/FAuyyq42W9otBJM1MxQ+BvseP53uz143cfb0EjWmlfuItonPoHTyYvrX9J31Bpf0EgPhBs4uawUNvbSphmFGIJ5SjWTy7j75Xp7Bf3tsg0XL+i52z2tQB2zrYwEkk9YeVaXyfmsWhKTMjw5gUOqD2UuTpd9TjH0GmRKLj3wFTPNAwjkQwVuptYjL+VuzmLKoAZsCgKOE9e7N42OOdZy0lHUojqP8c2EJGyIPzEERKXhh8eSA5gNyWW9h3NY38keHXN5+VZmp0+aEHSPsoSSiyz5SGWLnjuS7E0Wfhmfug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egOZ1toJtzgjYVQt5GInLaAqD+TwcjWoCfK5h3UKF98=;
 b=WB7Wg7vL03Vp1IaqNC4GySDkWAsJZL3GPkr4vcsufPmmbIxbNDXcg7xejpqAfWgNz1pPwz1/A5ZjEYaiNzUg8JuCR1X40+2cpeUVUgAmXilcxFS9w596QnIUnkj8qtfZ7pfZYDbD7lZuRsR28s0RitvMj1munNPAMeuvPGnOPqssRj6ac5kb0kPfvslvCotj2nwNbexdeK0PGBC+JmeNpLBwNBynE8w7oc3dL/ygPfkidxpGdW2WQLPuzlZ4x8M8xRO7boBxSAFYh0YNr1EAEeLzbrw9cZV8Ico8NAMSQR08c8E8//Uls96IBXvfrwSxUCjTY8DJr+wBRSXu6H/DrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egOZ1toJtzgjYVQt5GInLaAqD+TwcjWoCfK5h3UKF98=;
 b=o2TfoeAxeNIyThstXp9g4SLiOwJVG2De0JJOmQIF/uiJYTniuu1+q9UluusfjnhMuN/rizyf212LDO+WOfcftTpNxuQuf0jUoRjg4o5pYZ2RguHn51kenTx6FCS9DkZkYWl2lbSR16KqKSu3dWokF7iidPFn6rrcaelZjWBYaxs=
Received: from DM6PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:333::12)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.41; Thu, 30 Mar 2023 19:42:56 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::f4) by DM6PR03CA0079.outlook.office365.com
 (2603:10b6:5:333::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/23] amd/amdgpu: Set MTYPE_UC for access over PCIe
Date: Thu, 30 Mar 2023 15:42:27 -0400
Message-ID: <20230330194234.1135527-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: a861b7c9-94ab-4803-3b87-08db3156f5dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cwlJSVdwMMyCEg+PdTyk6j/S/pnc/JkLiTJxGGpgr/KRiHE6vNTorTmTdIyukneoK7f3Ap0nBqUapnmwcM6Lep65X9HF/dQ32zepIWfjZhekGt3rYKf07z3bIyqfUFrtOFWWo9PXBBRwC1aBtj8XkOP+N4dM8b+Ez2TAAR3jdtXI4dyDEnGj1OnbYqd+voPtNeOUBdwkOTHEajjpQRcisciVpb1HKpH0JosgWLVzpVwKBS622+2JL2MjkJRslY4YG5alIp4KmIoc4n0++lvLkM7bKg6j55B1GeZgjeRgRtU1Jp33ytvAHfRhIQK/Ae0zrPjwnSKvQDGp7OMmVIRjOD4mMuU0tSSEww157A2riojpRKFFw2tQc0RbIrwyBw4x0Lstx6PCeHmc3Z8/YnrNAmLXInO0MwzkZFTya+1RgzotWS56oewKHcs8SlMT2/lpC/ozu6G0yyScnFDVZPaUXJybr1bcS3G1bc7nvMUwtnwsMg1h/V812fAfLAYh0XMaU6Ny4TNyKebTtaB7j9xbqh/ms2k8mT+F4AI22Xvbb/DndNwwMXhb8IM6pkVip741zeJ3txYPmk/y+qfDyn9jCEdEAUK0Iz6/B7EOf7cCnBkYuDYw7nurJQz+sIs++7uqlhZqamGD/aR17ZhuADstKeVEXiNo6W142BV9oUe8wJUl3YCZFk7OF2IPtFmsUgve9NnNZZIg5ftI+5AkBnljUeV1gldERfqfH6xE3/xb50U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(186003)(26005)(16526019)(7696005)(41300700001)(1076003)(70206006)(70586007)(54906003)(316002)(4326008)(8676002)(6916009)(478600001)(2616005)(6666004)(336012)(8936002)(82740400003)(426003)(5660300002)(47076005)(83380400001)(2906002)(40460700003)(86362001)(82310400005)(36860700001)(81166007)(356005)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:56.4075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a861b7c9-94ab-4803-3b87-08db3156f5dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135
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
Cc: Amber Lin <Amber.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Amber Lin <Amber.Lin@amd.com>

For GFX v9_4_3, set MTYPE_UC for memory access over PCIe.

v4 - add missing indentation pointed out by Felix and add his
reviewed-by tag.
v3 - add missing logic for the svm path.
v2 - add amdgpu_xgmi_same_hive to separate access over xgmi from pcie

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 29 ++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8bd9d88655b8..efd2bffbb892 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1192,16 +1192,29 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		//e.g. NPS4. Current approch is only applicable without memory
 		//partitions.
 		snoop = true;
-		if (uncached)
+		if (uncached) {
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
-		/* local HBM region close to partition*/
-		else if (bo_node == node)
-			mapping_flags |= AMDGPU_VM_MTYPE_RW;
-		/* local HBM region far from partition or remote XGMI GPU or
-		 * system memory
-		 */
-		else
+		} else if (domain == SVM_RANGE_VRAM_DOMAIN) {
+			/* local HBM region close to partition with a workaround
+			 * for Endpoint systems.
+			 */
+			if (bo_node == node)
+				mapping_flags |=
+					(node->adev->flags & AMD_IS_APU) ?
+					AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
+			/* local HBM region far from partition or remote XGMI GPU */
+			else if (svm_nodes_in_same_hive(bo_node, node))
+				mapping_flags |= AMDGPU_VM_MTYPE_NC;
+			/* PCIe P2P */
+			else
+				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+		/* system memory accessed by the APU */
+		} else if (node->adev->flags & AMD_IS_APU) {
 			mapping_flags |= AMDGPU_VM_MTYPE_NC;
+		/* system memory accessed by the dGPU */
+		} else {
+			mapping_flags |= AMDGPU_VM_MTYPE_UC;
+		}
 		break;
 	default:
 		mapping_flags |= coherent ?
-- 
2.39.2

