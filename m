Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C93C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 23:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 345C510E815;
	Mon, 10 Jan 2022 23:39:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0534710E663
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 23:39:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drFmsHK7rgf7bORiJaBwex3N5I72iEEh9FWA3Pw07lDv1g77s29UL2xJP2pfkYhRBK1TPeFdzTcVELPLD04zHcCPPLkxu4/jiBnp9dUNboUKsBa0ju6fjdFqPcOc7rYRWpSc6hsDIQ0WoOs+xaZwxBt39eYgx++sR3+vg2XoaU/A1DVUUpU9bcf9IUlhv9oWJsOXiEzGMFVoPx7z9nv4EW9VWGNY76+WACP7fcGDF7WKfyYcMwHKHmCP8Qd6c09rnOi70vgIgUz0xUUQ1l8TfwkvE2RGJtWaYbqR8uS+nxsL8gbpiXS9UlYOzs3M56DxuyHNMyldqS1tGDuPG82KEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SR8JDtOroaunAeKKdmFEmSJlar48TbWAJEulGtVwDSQ=;
 b=dZLUq5iZ4v7TbYNczmXMhwuFr/fyIMd7cKlAw6JZIv+GNDPeW1LfByncA+iD7/n3tJvpoYsLD8cUZUP8KSY1+jttfqKA3b8BEqt7N5BAgCUdWGO0yxRqbBniAde+XZywXGa8syo8dlST0ZQSyan4wnbMh7b/uef8OVP1zu8pRFzbJMDLH4RdyJrR4t25lehKt8noLsGRh5gXIjvy0nSZYM8g0+VH4X0B2NNyHrYilxafB+6zRfFieKk22TRq966lNexozOgSwSC5AJMQohLmEQEuHcB7eyo8kQqcZoFwQD27HZjM52En6aBcKcq2l9zyHiXTHVP1eMznoEf60O6Exw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SR8JDtOroaunAeKKdmFEmSJlar48TbWAJEulGtVwDSQ=;
 b=a6sKRbdBXfsb63rJUYvIHewxJcDgHpO3jPSSJQ+/IBsxgic1lgUo6Iu9ClbBYbO3UraHbLuIw8dkn8bJDo2uBarlHHol4S7uSI6qPbyc+GZQ7EEIXqyWifxq4zJ9ONsCNxN22FSH3J9PF9tWH94Nr/39vfsFCI7kYjuDxWD3Bzw=
Received: from BN1PR13CA0027.namprd13.prod.outlook.com (2603:10b6:408:e2::32)
 by BN6PR1201MB2496.namprd12.prod.outlook.com (2603:10b6:404:a7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 23:39:19 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::c2) by BN1PR13CA0027.outlook.office365.com
 (2603:10b6:408:e2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.8 via Frontend
 Transport; Mon, 10 Jan 2022 23:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Mon, 10 Jan 2022 23:39:19 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 17:39:18 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Drop unused variable
Date: Mon, 10 Jan 2022 18:39:05 -0500
Message-ID: <20220110233906.1178021-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110233906.1178021-1-Rodrigo.Siqueira@amd.com>
References: <20220110233906.1178021-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17c80f27-caa5-4480-6bc7-08d9d4926c15
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2496:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB24963CB0DC4A7CFA5765ECFE98509@BN6PR1201MB2496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n1SnuyDCQZbTseDEKc+LFFSvc2yC+cu7mlwT8nekyvhnY2AMZpCS5obfH8WOkUO/wmcKZJGSr0TLxN12ZGMh0s4uGALQmYkCVUoF0UmwLYjnphbgz0/lBUrTEHRCqnYIlTLM1ppFVM15VOSsv+u7e2ox3LFF6x6gLnOis2ZF8eBuhKXpf4QUBffzybi7MUWuu3veuSgEBtLvxoI4jtVyauzqgI4thkwaOj4z/AAqPOEhs6FSDL36RlGE8Fz3Ksqi/IY5gVhl6seXTlXNSpl8Cym4PfHs7TG8avy7UcOba4Am0c57QpSrGdTtakD3DZx+HPmhD53YoaO5fGEeL2VcX0BYMadLNmuaaY5Ek+F7t4JLKGsU4yoPkPnFQ8xaWLR+64SrIqy2Q84enrTsDNpVAckNqvEgyZbOO1TW2C9PB/e2HwBn2BC/R4C8R45eXBY1F2BOPGVRziQhsmPlYq/4bjzUSGs4Chr86kf7D43MCCs0Ckk788oTkUAgSvA0hPrvutHucy3OUysWP6FuC+xft5h8OLegdoDhEC2UhDkGeu5hDlPbb5Pxa5dnZxTNsdc5gdfQflgXRdugqvgxKPUwP4iRyAzk2bkOVSfEwPE3XAUJmDuG2VhEjRw3JflmdeV2WJc7yU4h9t6+BSVNwQ3aOStSaqqbmedI/VX2oNua+RfrBc3eY1LnCDBNcwFCMioOmihMjyzTlX6wQJ0S4qxYTsas8CJyisKkzPPpmfVMXt+s3OlVee2OznPu4QZ3VwUP8j8U7z2CdV2UwV2UrwfbtrJM70/jzari89Eg8yLnhyg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(70206006)(2906002)(426003)(186003)(16526019)(2616005)(4744005)(26005)(8936002)(8676002)(36860700001)(70586007)(4326008)(54906003)(47076005)(36756003)(83380400001)(316002)(110136005)(356005)(82310400004)(86362001)(6636002)(1076003)(81166007)(5660300002)(40460700001)(336012)(508600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 23:39:19.2824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c80f27-caa5-4480-6bc7-08d9d4926c15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2496
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
Cc: nicholas.choi@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This commit fix the following GCC warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:945:6: error:
  unused variable ‘i’ [-Werror=unused-variable]

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b1bedfd4febc..517650d286a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -942,7 +942,6 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	struct amdgpu_ras_block_object* block_obj = NULL;
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
 	struct ras_err_data err_data = {0, 0, 0, NULL};
-	int i;
 
 	if (!obj)
 		return -EINVAL;
-- 
2.25.1

