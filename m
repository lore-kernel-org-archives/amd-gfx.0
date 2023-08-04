Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F382C001DE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Aug 2023 16:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B16A510E72D;
	Fri,  4 Aug 2023 16:06:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB1FD10E72D
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Aug 2023 16:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8qK5T5g7n/vTGY3dMpt0G3AZRznpr6I6RTbrJro4g7Vj+S2En6n+5UgwCwqURwDjOaAXMD45qCb3F1kVpQepVCKbnUwhKsdQjONLZjQyHYk8P3CA8Ql+gdlUIbPG+rnfaN7KCxget4U5z7IkOqfK5jYUcOtoZOZn0p710EqeryukolyAJhR9UaaYoRYNTk5TOphG5GRgby8P7eiSPF0iOavhaGTwi2U0F57hYi0JUopfZw2y0D/1TiGlg+YEzAhyYyq8TPVCF11JLVNmU+W+B9KWpTSLOdlZAxNZiULPtB6oFKCtM0wd15582wtOFExwH2HrUEfOrlr5fYiV8lbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vw1wjTLFFUNA4QzpDopvdTOA/tVWTBdHcnwJTDsG320=;
 b=dF/HNvXtFuq1YTT8C2bkwU1Z0CTfUStyuuIrLh62BACN0SUbO21lUp0PtIwDoqqKTD9VryeyOjxyt7Vz68TWn/xfCipJkt0aGE9zq1t4rhwJT5Yuet7mg9GkUHgsT5Pp2AvDACRNNhpvssWxSDme6XD3S2vdsEx/cuSJji6LeRhmex07B5LQ3gHmz4xrw2XRXvZ5TAVf83BqZvI7eCJkBrH2+Aql+jNk9tJZBTBZRPSp0Iq3SZUmzzxpwWgat4kBJhGu8dCyJP0vEU8houwgmZcE7pT+5z7hZW2uGmcjoZa0JiNb7hOVvlp8JaNRMe83w2ULJxKgWA5k3vv4MucqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw1wjTLFFUNA4QzpDopvdTOA/tVWTBdHcnwJTDsG320=;
 b=JnLkB+qAJaXyYiKXYSrusTEPDrQ0aj/tJmjIDyKj3aZFq3+44GST7+vGj3sbfmaSDkswRKU663jq1A+NpJ1dYVUnImOAGj7VugnscyiGFPn/WlbCZ5hj7FnD5kKF1ajCl7chx4t+MNcdLlPFmsA2ATZ8G4YELibAea7jkCxWwLY=
Received: from DS7PR03CA0183.namprd03.prod.outlook.com (2603:10b6:5:3b6::8) by
 CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 16:06:02 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::e8) by DS7PR03CA0183.outlook.office365.com
 (2603:10b6:5:3b6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Fri, 4 Aug 2023 16:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 16:06:01 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 11:06:01 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: wrap dynamic debug call with
 CONFIG_DYNAMIC_DEBUG_CORE
Date: Fri, 4 Aug 2023 11:05:45 -0500
Message-ID: <20230804160545.28868-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 12516b34-0eaf-46b7-52be-08db9504b30f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ef4zS98UFFGrQqkHoc2A0yyCWdGgem3iLNOlNnb0PeGONo+55tsmXh2+oNt7CAIrkyofJJlDED3rr3bUq05CQXXxHj99ekdHNlqifiTvqLmhA3VIP7cdlyX5nem980Rb/qWOTin1WTzYnEdX1GFvShH5sZJEwiz5xsKYPEVZD7rzAUFDk8RXe3Ggb1QJJedq6MkHJXYw+If7Hift42Sqfvae5S+gK7O6MfSSiCkiW5SqWqwIkNXbz69trAIl8oP0f/g0grylc6OVWZiOa0YMRq9TE395u1DlDAon02J2CBSlt2gIpbzeWU9L4JDEQaFl6tiy18pRf8co09wrv+kefDNc3rX37Umcpc79eljuuML/MMLkfl2J8UU1XOl5yStvynwZjaOZaNu+GyCE9yYQv3JKunQiKYAGpjfvWyd+asg4JkAVHonR9fT9IsLAPAqYYvl8Vx5Tkpgo8pejYNOv4TiMEoThHhJg55ui4FNuU3hEVViqqRSnv3hFoCpg4QSIVVCmfW0jWxKwk4nP7SFbwJZPnZilQNKXo5P6XHoSw5WrIZ6bUZYmI8RnNGZUOr8K9ALq95h0WPNoneisO1J+9fbjdITkytmTX+tw8HWzGQAG+v+I65LT1y3mucfRBMA3fIvpxPbmL+OuO18b6g0K+Qd1pzzK5ji2mx/Je4QKfPnjlBY3ddn6DcZrDdyPxs7FYIYC4vxFPx4uYHdpYv85gqPN4LTPYVdh6im+sXqgYvTKq7TN0X/37I5761k1ovH0JlTsRY/O+AGJt71pTQqU0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(82310400008)(1800799003)(451199021)(186006)(36840700001)(40470700004)(46966006)(2906002)(1076003)(336012)(26005)(81166007)(356005)(82740400003)(36860700001)(2616005)(47076005)(5660300002)(16526019)(40480700001)(426003)(83380400001)(44832011)(8676002)(8936002)(70206006)(70586007)(6636002)(4326008)(316002)(41300700001)(36756003)(40460700003)(6666004)(7696005)(86362001)(54906003)(478600001)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 16:06:01.8497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12516b34-0eaf-46b7-52be-08db9504b30f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
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
Cc: mike@fireburn.co.uk, Alex Sierra <alex.sierra@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This causes error compilation if CONFIG_DYNAMIC_DEBUG_CORE is not
defined.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index a69994ff1c2f..cde4cc6afa83 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -824,6 +824,7 @@ svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
  *
  * Context: The caller must hold svms->lock
  */
+#if defined(CONFIG_DYNAMIC_DEBUG_CORE)
 static void svm_range_debug_dump(struct svm_range_list *svms)
 {
 	struct interval_tree_node *node;
@@ -851,6 +852,7 @@ static void svm_range_debug_dump(struct svm_range_list *svms)
 		node = interval_tree_iter_next(node, 0, ~0ULL);
 	}
 }
+#endif
 
 static void *
 svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
@@ -3594,7 +3596,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			break;
 	}
 
+#if defined(CONFIG_DYNAMIC_DEBUG_CORE)
 	dynamic_svm_range_dump(svms);
+#endif
 
 	mutex_unlock(&svms->lock);
 	mmap_read_unlock(mm);
-- 
2.32.0

