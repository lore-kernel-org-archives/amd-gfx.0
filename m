Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62238EB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 14:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED94010E49A;
	Wed, 21 Jun 2023 14:36:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 657F510E49A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 14:36:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=banjg/MXP2fUHPPkbZ5/0uV+c2k/MQ9pbvJqNOhhIwf8+AlcT4qv567PkwBCiaN8/0A6y1Aj2OvPhDpV50jM5ony+WViuHJm0s6ye+Yi6HpntfBWpPn6dw6qfNFAJkeMsAa2InMfWs2ICyVVSZQuJzsySGi5b9rQUUNaicRpl3Q+TSEESsmavKt5N0LZ+k7hMmCgvOMpm+raYilgwYufg3YuFfkfTz5Vwz6+qbohxco1f5NlZEZmsigv8AylyD++hXEepdMGWu7mdYfYYEvm4ciDJMXPhjrItAI2w+8P7QCXDadnqaEuYEVD9QHYEkxW/jCe2cUILcqPXUvF+oMJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYWGeKPTuSsBpKPYqgg49u0+zkpvdaCItEyqmcHbA/0=;
 b=Dl3iT+9Gabfokv/BnR0wLu5o39VTKDffk45suOqj4/gMmsA4j4pkWwdSZ6oE27tj8ujn6trcwWzpY8MmOtI7iS3YqA8jdeyQ7YQLFnC94YZ45kS5aK3p831GP2ROU9AdtBbdCh3b8Lq92sr2a7+bTy8V93Rl3SrJ3fCc340bXU+z6mb5Dne7nGDK1oW3BaQFyMJfUsjfVH1XeL0Mns/P3jNR7Pmxt6r4lTjWiSHiFSYxufu++LhtzJgVVwj4W8GFB8L9Ivb3uIj2O8XJ+HpIZ6dmMeywG/WKvvTGoc59uqc2bnsEhxP8XgHlOySpYSWX20VnurrVBKwKj2o1B/6j2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYWGeKPTuSsBpKPYqgg49u0+zkpvdaCItEyqmcHbA/0=;
 b=mHGvCyOZXRr+qSDIp0PyHuRdLmG/yXU/ZJsv0nq+ZCy/jagBri3TtqvCzdMby18sip1GMZdhImgy0JfvPM7uG1kxavN0vLM92xyfqstd0zS7q5Y1c1jGS+e+OXsbGuqjVEpUfixxVrHqg8GAFQknBKUhdJt2hjBK6QETAioYy0I=
Received: from MW4PR03CA0316.namprd03.prod.outlook.com (2603:10b6:303:dd::21)
 by DM6PR12MB4974.namprd12.prod.outlook.com (2603:10b6:5:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 14:36:03 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::70) by MW4PR03CA0316.outlook.office365.com
 (2603:10b6:303:dd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 14:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.21 via Frontend Transport; Wed, 21 Jun 2023 14:36:03 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 09:36:01 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add VISIBLE info in amdgpu_bo_print_info
Date: Wed, 21 Jun 2023 16:35:02 +0200
Message-ID: <20230621143502.22293-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DM6PR12MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f474312-42a2-4e66-9061-08db7264d708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oEl2RT6k8VGbezsgDdOSofWy3gBZrOC2nG5mxvQAXcFiTx9b3vTp2BUABq6zkB3eehqti9am7ERsHJLpDDauN1m8gKh5O5S6TwX98jpP4sikbaSC/8oM7LvWt+A+KL5CphXkQ6QQkfDMBM9/HczLeulCW6SuPJkOFkqQkMN5dUcagt7ZlzVqLr8Vv0jd2LVx2L0m0nA2KWHdEbiTBUYBr/Wjmx3KZMEEjGexi9l56gjoY9hJBkKU7fyg7sJF0rQ032s2OEEH83CgrkF1vFwzgz3HFgLLduSorRoEgM5wyj5quPPzlO5gDF3NdS07pg6rfv9HqDUVkwde9EFYPh6bkvbcBB2V4A9cahZr2NHfGldTk3XqlH9tm6xqhSH33fJYp7oBLzR6HgeSfIY+flKRUSzqX1mBEWJvcKrw+AJMxRtKEbuJ94eRHCu4UurGSa1UIcz2YLvI0Nlm1ikrYCguQV3WcYj2qffKwCHkTsfFn0JlxrJZa1KD+YzGhGwmu6w9KjWleudDjWk1lF2f2dCWR9IO7IdYgkhtKl+1nG8Ab01OD3Zj3kpeHVVdF8OMFT02RK8Gg5UqlQ4ktDfTT+9E3yIFC4zsWsJUuctvqnBRryAzPLpZYDU2ahp5bcGJtjFe5uLjIJxAhUwr5jYhsqo+7Du95XeWDtViaoH+tBxDgRnvyZYWJzyxhpRgE/AIwaaEVfiuJhaPt5WbcIswjdfaCgnf49qr0FDpyo0qAmTcuxYIfUvN6DmrfZdiVCRZtPu55MRtO+DeyTYwzAqbe4deSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(4326008)(54906003)(1076003)(26005)(16526019)(186003)(7696005)(70586007)(2906002)(82310400005)(8676002)(8936002)(41300700001)(316002)(70206006)(5660300002)(6916009)(82740400003)(356005)(81166007)(86362001)(36756003)(40480700001)(47076005)(426003)(83380400001)(2616005)(336012)(36860700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 14:36:03.1453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f474312-42a2-4e66-9061-08db7264d708
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4974
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This allows tools to distinguish between VRAM and visible VRAM.

Use the opportunity to fix locking before accessing bo.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 33 ++++++++++++++--------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ff73cc11d47e..f12f019d7f99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1583,18 +1583,27 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	unsigned int pin_count;
 	u64 size;
 
-	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
-	switch (domain) {
-	case AMDGPU_GEM_DOMAIN_VRAM:
-		placement = "VRAM";
-		break;
-	case AMDGPU_GEM_DOMAIN_GTT:
-		placement = " GTT";
-		break;
-	case AMDGPU_GEM_DOMAIN_CPU:
-	default:
-		placement = " CPU";
-		break;
+	if (dma_resv_trylock(bo->tbo.base.resv)) {
+		unsigned int domain;
+		domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
+		switch (domain) {
+		case AMDGPU_GEM_DOMAIN_VRAM:
+			if (amdgpu_bo_in_cpu_visible_vram(bo))
+				placement = "VRAM VISIBLE";
+			else
+				placement = "VRAM";
+			break;
+		case AMDGPU_GEM_DOMAIN_GTT:
+			placement = " GTT";
+			break;
+		case AMDGPU_GEM_DOMAIN_CPU:
+		default:
+			placement = " CPU";
+			break;
+		}
+		dma_resv_unlock(bo->tbo.base.resv);
+	} else {
+		placement = "UNKNOWN";
 	}
 
 	size = amdgpu_bo_size(bo);
-- 
2.40.0

