Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE70C48BE6
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 18:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7C2613D3
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 18:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7C2613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCCC68981B;
	Wed, 16 Jun 2021 18:12:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01E538981B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 18:12:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LU9Jpa4xjVjHN6VfWqoz3YLnt1/sJaQYXy7FYiicdtAGACGgDv7YdBIT7EaYHrUd/a/XgnDUd3b8OkgJmNbKloWyg5g03hU01qhWA4488pUUgsy8XeDi0rxF7OY+lgW34shJ0/DJPR2E+NIDc1M9xae5JaESOUFCEWFnW3NfyTTnY0bFdrtO3agBM2SqWAhbHi7ZAsJ2gF40Hx2pGBmf2DNQy40HgqqhK6h+kmo59YLQ1GVM77nPbaGwIINxzXlE4CXASTdsdU1Vt2z6Bxpq5CfIvuzt0dbw43klXE0Oqlu+1MNAgCN0Lh5QOY4OGFbT8ruJ3rDo+D9MmoutWISAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtEV/ncT7Pjh2RNYrsMcFqPYFAAF7hhyL+IZJbxURqc=;
 b=mUf9A57KbSLiJCVPXXRmKXUuAAHNVHaMcRWTt903+DpTjxvZCciyCXijA8scjHoFKTNGc+hdLofmhGAtrYBa/M/58wWEEl6BZj9AeoqLOnSasmSaMr/TD+RTK9Ihk7V6uAukLiDqHPw3hx6G3zmveS4HstMMBnmbrl/CukIM3MsuwoxSHoQzTgwoIMK4w09uVXQY5Bv0nKkW+4t90TTT3kfsuFdSPm/5HbTR5K3ZU688BtkQCNcPMBczicCwcN74D/diB/wnBUVkrqxMdMizhe0NMozQ/PT/si6pRN82Crn/XAVFcLzvyPigs4euyOwSsqDB6LFkDpq+L2hxQWMvGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtEV/ncT7Pjh2RNYrsMcFqPYFAAF7hhyL+IZJbxURqc=;
 b=KZhbyr7Rdo5smetbupEi4Q00HByM4JxTBDrZWplELRtJ1Tj88cppda94wqBEN8suvSmkvyE8ABxi0EWZaA24Zp4AXKn8F15Gh3uVkQGGx+7d1ZTpPnySpHLEOOLeTZZSIZNKIL7VvKxYjlOQ34BqkIS8kRmie0+bYFuDxWVPZDw=
Received: from MW4P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::21)
 by BYAPR12MB2742.namprd12.prod.outlook.com (2603:10b6:a03:6a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Wed, 16 Jun
 2021 18:12:32 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::ae) by MW4P223CA0016.outlook.office365.com
 (2603:10b6:303:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Wed, 16 Jun 2021 18:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 18:12:32 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 16 Jun 2021 13:12:31 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Set iolink non-coherent in topology
Date: Wed, 16 Jun 2021 14:12:15 -0400
Message-ID: <20210616181215.376756-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ea9339d-3503-4d57-7a0f-08d930f24fa7
X-MS-TrafficTypeDiagnostic: BYAPR12MB2742:
X-Microsoft-Antispam-PRVS: <BYAPR12MB274210ABC3B94F2AE5FFBA39820F9@BYAPR12MB2742.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MwB+W+BjOOuk+AskhiCnbA219kB2CIlwGz6XQBDURqDDqd6yu2SAhyLAtcArmmB9bO2OI+rcpyr53YkTW+FNMaBrKRaJKL7J7TPvIO4Dr/lLVa43lfunYcoCjV3/ugidxh1saWmW7D0k590fYx8CK9tmNEn7Nq7eTB4TSyQlBzrmo1Pm5OvLgejLtYD20VUQUNqPYNKFPtqsc2lxHBBrVLTKzEvtrchXFPe60HHsHmg1F+w/DqOiuWY2vJJIK+w1dfd0THbOnNYipo/L2oFBsJr7mpxwVFJqr6hNG2es0OmMYZRFBSRHM8zMmK4CpL7qT9P7r8PlCXA2VSTbwKGPSWM/hpahgY64AmDy33wd5UQamSh4qpbPeN7CwNC3MOG+xUYPv/IkOxE+Po1ZK0wkiZxiYJ/kE2zOL4lCbL2nNvCZJg1tKKqI+vKoA+8Q7QAHYU6L0bTPungYyzBPz3oU208SpzKBODOutclbE7suixH5jR6hc8aR11y7oX9Sz0qdpATltTunM74fqL2rVV6TgrNw6zTtHYqtaKpZPFDgow3wJ0YHGp5p2VUUpqDJqIgHgh2Ne1oYy6mS0mRf6VJFMNkcc00fxu2qGxtGkSbjrOov7JDsDy30DWFpnckkEclnTE8dDtw67PQSkoVz7Fenm8XK2glhgrUzJaXyYcmYYTnLEpjqb4SW2h7YLP98jI1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(36840700001)(46966006)(86362001)(8676002)(316002)(478600001)(6916009)(26005)(4326008)(82740400003)(7696005)(1076003)(16526019)(186003)(36756003)(2616005)(426003)(70586007)(336012)(36860700001)(47076005)(356005)(70206006)(82310400003)(2906002)(5660300002)(81166007)(8936002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 18:12:32.4701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea9339d-3503-4d57-7a0f-08d930f24fa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2742
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix non-coherent bit of iolink properties flag
which always is 0.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 6075cbfde59f..8ef3add769d7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1336,6 +1336,28 @@ static void kfd_set_iolink_no_atomics(struct kfd_topology_device *dev,
 	}
 }
 
+static void kfd_set_iolink_non_coherent(struct kfd_topology_device *to_dev,
+		struct kfd_iolink_properties *from_link,
+		struct kfd_iolink_properties *to_link)
+{
+	/* CPU -> GPU with PCIe */
+	if (!to_dev->gpu &&
+			to_link->iolink_type == CRAT_IOLINK_TYPE_PCIEXPRESS)
+		to_link->flags |= CRAT_IOLINK_FLAGS_NON_COHERENT;
+
+	if (to_dev->gpu) {
+		/* GPU <-> GPU with PCIe and
+		 * Vega20 with XGMI
+		 */
+		if (to_link->iolink_type == CRAT_IOLINK_TYPE_PCIEXPRESS ||
+				(to_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
+				to_dev->gpu->device_info->asic_family == CHIP_VEGA20)) {
+			from_link->flags |= CRAT_IOLINK_FLAGS_NON_COHERENT;
+			to_link->flags |= CRAT_IOLINK_FLAGS_NON_COHERENT;
+		}
+	}
+}
+
 static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 {
 	struct kfd_iolink_properties *link, *inbound_link;
@@ -1361,6 +1383,7 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 
 			inbound_link->flags = CRAT_IOLINK_FLAGS_ENABLED;
 			kfd_set_iolink_no_atomics(peer_dev, dev, inbound_link);
+			kfd_set_iolink_non_coherent(peer_dev, link, inbound_link);
 		}
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
