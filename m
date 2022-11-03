Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E1FC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 23:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03AA310E6C7;
	Thu,  3 Nov 2022 23:13:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE6710E6C7
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 23:13:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIZFuZ18LIJwBDNKp9Zq6HrB722OSWuYxghX8Jf8/JKRJhK+/Sn6Rt87EBUo7Q9EuOgjxrlYyTYkDTLkp1dV02m4NP8+gJPhp194nA26MEP1GRLOO/UXMWgQdPq2YB8b5AVYvdHps4WGNssa+ws0lzG/fR9uHBj+X23fVNT/T2rwWYFxVPs8noLBHEGPqf8B+VtUpDF4c/vueYMFIAv5i3u5wR66DuaVWJMRthho/aNNZlDqjayqm2Qkl2ZPnweoAG4R2dcXeo756O6qAvjnowyq7hcolsrrSO+Apy1h894vQGIHfxjRlvThP7Zt9cC7JkTSieeNtetl07YRGkBUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGIJYoXd8p6uEy+Tg3XJ2GcoKLQgAcqCK42BjMegoVk=;
 b=AeS1jXmqzrJasLexKXBfgfwcBn3LhPTlVROVy29E0WOtDFEs0Wi3Dm2DO5NrMa8m5oX/9t5N6KuGj8q9cMgOVs2OQZfpHg3FkWqLIVmbwssE7RwuqwKOOkPAuQeKDEVHSBRjhLSEvFY3EOUQ4sp4Si8s1eyfVXgpvduMNGzQf3RiKCaMFrixdaFkjjwLDgrUrp5AuYwgKrM4V4yaCd/MCJ0GULzZH75+Mvs+duY0O6FHgERgjMH5wh++RUpqWaB1uotDqNCzePoc01UKRwCmoVYWSy7rSCgDF706inLVQdwBC2DhJaYZbdyt2l4IsJRO0mlMjzeqBRAf/IFZ2Cl0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGIJYoXd8p6uEy+Tg3XJ2GcoKLQgAcqCK42BjMegoVk=;
 b=GOpB03l7VT6fi40LRnMuITTE/NVC7FbVwC+1iN7w3nN/Dz/kvHbnyk2J4ganRej7Trun0R2RB9XADc4TdF6wYgyT3bQ65qutzQygdAROTIvDFgBp8POij1Oz7fbl9XD6zDUdS/AH5VmEsWexkgNxViVe9INOhyfhlpNh0t3Dp5E=
Received: from MW3PR05CA0021.namprd05.prod.outlook.com (2603:10b6:303:2b::26)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 23:13:42 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::42) by MW3PR05CA0021.outlook.office365.com
 (2603:10b6:303:2b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.9 via Frontend
 Transport; Thu, 3 Nov 2022 23:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 23:13:41 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 18:13:40 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix error handling in kfd_criu_restore_events
Date: Thu, 3 Nov 2022 19:13:09 -0400
Message-ID: <20221103231309.916480-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: aacec4e0-9621-4f45-025a-08dabdf10c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QSWQVrjpmSbfwG0W4eh39YzvVvqFjcJxommgjLPDfMVYfMkaekp7sghGUuUiRu7j7PWpqMAZ+VVWAcQvA8iivWYBHmHyJqSPhkvJtDFR3bMkd8nBLIReF3FBx5Vv1tbJCZN2stlLexLDp6dl6V2U/oUF36LIo1/Ek8huWboZB+gBGlAN7IqROlSyqfXZD5vPt8+p/d8/OR0JuoQmaRMzWAefzssQ5oN6Y9yH22u8h13boK1Levr70ClhaANdCSyE9OgQwS+7BjbGPBj4JAP0KFl8PXlIhiIgO5HWYGaq4avFgPKvb15sQLX3Wz5MH1o7XpdMwg9MzL9aZ2WMEfZs6Yl2jKPpbQDYVpcdMgL4NzM/lX6Ak4UxQnbsvLlb12A71815zAg+e6x/mxwnxPxK83v+lTOUfCFCNs0SJb/SH2qKiQs5Np4Ay1ncOfZ5XlHauv9yuAiYlaBRWdMnghmFlCA2TWGnDkmzGZYgsQ2MDpODHnyIyCbi62gQRoPGXEH+ajTzgRS0tt6hkpEG8bezreMXsZaqZLYbbnfsOnCWiL0Q+ExnnW0tHteUVZQD/qoLBFgN0ZxoAitN1Pl/vSb/9HWoT/MaMDq/8O6znLpYob6SwwDZNO9mLUlOV1V920PQ2bt7L9GxT7yq5b2SEIXKDRh4lF34NxSOaAmwBkpVQ7ea70SX6kKCHZbJPjtDOXbC7xG/BLsjcNEmobtXFL+6uPbDje2AGS8aT4EjjAn+UMU9h4phf7yntdCJFYwr0zSIh152fGFMjcb9pxouI2hQxSaaasTpG3LTGe0C9qBZU7w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(47076005)(2616005)(70206006)(70586007)(7696005)(336012)(6916009)(478600001)(26005)(8676002)(41300700001)(1076003)(5660300002)(4744005)(2906002)(83380400001)(16526019)(8936002)(186003)(426003)(356005)(40480700001)(36756003)(82310400005)(86362001)(36860700001)(316002)(6666004)(82740400003)(81166007)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 23:13:41.4287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aacec4e0-9621-4f45-025a-08dabdf10c34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958
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

mutex_unlock before the exit label because all the error code paths that
jump there didn't take that lock. This fixes unbalanced locking errors
in case of restore errors.

Fixes: 40e8a766a761 ("drm/amdkfd: CRIU checkpoint and restore events")
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 83e3ce9f6049..729d26d648af 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -506,6 +506,7 @@ int kfd_criu_restore_event(struct file *devkfd,
 		ret = create_other_event(p, ev, &ev_priv->event_id);
 		break;
 	}
+	mutex_unlock(&p->event_mutex);
 
 exit:
 	if (ret)
@@ -513,8 +514,6 @@ int kfd_criu_restore_event(struct file *devkfd,
 
 	kfree(ev_priv);
 
-	mutex_unlock(&p->event_mutex);
-
 	return ret;
 }
 
-- 
2.32.0

