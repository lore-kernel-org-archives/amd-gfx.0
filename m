Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E339BC7EE24
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 17:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64E3610E05B;
	Fri,  2 Jun 2023 17:01:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 220C010E05B
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 17:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj+EdDoek8LSE8ovJB1dpYhf2HXW+WdZFDVdRSjRmpi8BbWb8hHLXRO5eyXfBxy7RD78UsgSoeseQcVxhL1m6+7YLD+JhBxQojmIXnpMSUHdX3IynlAKX1l4Dwg+dI2X2Impn0qjXjq/PmC7psnw5p1gkTH9A8k443Wy65SQ9IzsTvRlUxLa7aNwq60/ekQ9zX+yLXINHBFrPItr5koNm/wgCCPGTTAVG8l4PcAeb+Meb9QpoUPTpN62LpKCnq0IbnX09CBjsPd92RrE5LdkkxYnai58mY1LAKGmw506KevVeWcZtBej+V8u4Au4wRu8lFJFmRoZ8pi6HlcdKxpaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3UtFJBay6m2qa8y6uIs4xQ0ItfxkODpWfAh9mq4bvg=;
 b=abV5YhWUnFherQ/yzB/o6Yo/eLan4iOxYf7TDKNCdB4K23a6mGeV2inS/8Gywud+pIYViW4aXTComS4MG6EYomEKtGs7lSuWe2qghcedFf4BQt0NVzpFK/eiXlNMc/WLY7uNkT2KY4xjPINtTKN5O1S2h+H0XJLlntt8vE1Ce2QQglZfKkZaRFeGeBKw7E3bu7KCcGkDXzvcfO9/vfRupt+bJ0AiB9vp0/QlNYHYZ51aJa1vrRvnIW/PvT8Rt5VhxW/hVwPsUtS4Z1QBlvB6DqXzUOoN2ffTrXqUHpoSucdsw/ktYgkbZ71JHmWzc+36KKu/xn4Jj3o1fajTw8bnJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3UtFJBay6m2qa8y6uIs4xQ0ItfxkODpWfAh9mq4bvg=;
 b=x4R6EoPnS2JygV7MEdkjvB9xSHYwqtFSkYI5aWxt6JKK5gMvsgyRbmiYK4renKM/oVynfW/5fqkRidNVUKBvOLBf8WqazomeUkX64PV6JEruY2p42uX6ERixpxfsaKhGOLQfO/I4747RKsYX6dHdJZLZoC9WwgARUFyiH7EOGIY=
Received: from CY5PR15CA0079.namprd15.prod.outlook.com (2603:10b6:930:18::15)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 17:01:53 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:18:cafe::c) by CY5PR15CA0079.outlook.office365.com
 (2603:10b6:930:18::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 17:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Fri, 2 Jun 2023 17:01:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 12:01:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amd/amdkfd: drop unused KFD_IOCTL_SVM_FLAG_UNCACHED flag
Date: Fri, 2 Jun 2023 13:01:39 -0400
Message-ID: <20230602170139.18284-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d20023d-78e7-4aa7-66df-08db638b10bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8FS/4QqYlWoyCRuywf8ub9btlEp3zuozR7ViNwPDyV4Lqn4r0ALGUoyZZ2a6i4U7z9as8JS0P1swKhSODvzG9cmWEWZWVUWQojHZEOAHy+LQgczvaRbC6G+pJIc+EDxLSqHYn4qPZFJWy9d3rdoCz0WxQC2b4RCLebGrqXRgxFO5AH6R2KkJNX+7Kr+TttV4TsPCosSgyh3MBobXBFH4l5Hkj/NEo3qLL2i9aw1cVdL2yXE0ODAIs5yvWrxKQ11zS1Ic0R9AJztsCjUt5eFGYnOftSCk6qmvsltnQbvCDubX5b3NfmeGgtaYJQikKApizCe2fL9bepdEIDon30Co3zR/xfSFy6W2qerK6yvtMx9PgLT5n66t2HYK3AufBHycNZZv0uB2mRj4OTp8u2Nu38lIR4wwidTas0h7dVa6blo0ATw2S5Y7ZkeFzqQ4+/eL4mLVDs14TyyuRiRJTw6jUnRI1gdyyPQaF8eHmqLT8VgvvUUfBZsG0niR2YfKzayJGt5Ot5PgKJpP/LI/m8/gFUhMnaEEXelbnzmCie86/dRpJGOJz0tPcocT3pLRqmlWGuLQAy9Kh+GBuKV9XxZkUPjC7JAV39FmM2TG4rr8EPwZggOta0aa170njFtjFOFKElFO8tDvz+RIWgjbByZiEs4iX0ihyATcxwcObFbkYDiUPZBr8ukieCwXKfBpnN037AWxn3x3YqCTGtpyf7vkanxxiJ+iVXbZPjOebU0KjbmzLhuAj1Q8d+pRyahUgsV3bn9uo6eP9sRKOgFKUBb0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(82740400003)(356005)(82310400005)(81166007)(40460700003)(86362001)(478600001)(54906003)(70206006)(6916009)(70586007)(36756003)(40480700001)(6666004)(4326008)(186003)(26005)(16526019)(1076003)(316002)(2906002)(7696005)(8936002)(8676002)(36860700001)(2616005)(336012)(47076005)(5660300002)(41300700001)(426003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 17:01:53.4440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d20023d-78e7-4aa7-66df-08db638b10bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip.Yang@amd.com,
 Felix.Kuehling@amd.com, rajneesh.bhardwaj@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Was leftover from GC 9.4.3 bring up and is currently
unused.  Drop it for now.

Cc: Philip.Yang@amd.com
Cc: rajneesh.bhardwaj@amd.com
Cc: Felix.Kuehling@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 include/uapi/linux/kfd_ioctl.h       | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 615eab3f78c9..5ff1a5a89d96 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1154,7 +1154,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	uint64_t pte_flags;
 	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
 	bool coherent = flags & KFD_IOCTL_SVM_FLAG_COHERENT;
-	bool uncached = flags & KFD_IOCTL_SVM_FLAG_UNCACHED;
+	bool uncached = false; /*flags & KFD_IOCTL_SVM_FLAG_UNCACHED;*/
 	unsigned int mtype_local;
 
 	if (domain == SVM_RANGE_VRAM_DOMAIN)
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 2a9671e1ddb5..2da5c3ad71bd 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -623,8 +623,6 @@ enum kfd_mmio_remap {
 #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
 /* Keep GPU memory mapping always valid as if XNACK is disable */
 #define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
-/* Uncached access to memory */
-#define KFD_IOCTL_SVM_FLAG_UNCACHED 0x00000080
 
 /**
  * kfd_ioctl_svm_op - SVM ioctl operations
-- 
2.40.1

