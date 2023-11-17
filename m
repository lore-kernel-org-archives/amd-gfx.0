Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27936C197A0
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 02:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C462310E714;
	Fri, 17 Nov 2023 02:11:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28ED910E714
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 02:11:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsz6/gslJgzBus4LFMDI/FDF76e49kcKlJgchukrMgQm8Stn+Imqb1xhWbZUXDaTTp+3zP4MHAXyJAYl3HNkQatr7KximnNBcor8p3RutRbc5dXBC3QaFnMj4FKvpgVTIlUIjqY0P7sbCea4oAlRCsmDLSevFhJarOiMfbgYlkzcequcMnqTcQfJIAkH3vNZMJnwIsltsIM6afFumZQ69NvWDv49GDtlQ2fHjwAQxgV0IIfBdMiU4tzt/CoqBZfeTjBDzFOIzD0WOFb2gETzp9rR/kIimAbqJAOdwZmolVKIgSQgZpi91iMcbbX8TmXqOR06EI3YcPeUDS4YczUshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4w02eS95r2V+Ye1C5bkx6yaajlUPQgalKTGIm9oJpS0=;
 b=Uf4UiSgzEnWNWuV+WWUTXxITc1AnzC8OfYsTwOZnVoLvicZ2PRfzSGZ+fRg+KFBfqqmt7gPYKegWucHs25dXUAM4it2xtQj7H0nWdFJZJjfgJ7cKszsctFXPuLxbWZoE9Rp/vrcR5ayAEeyhu4keNGovv4orpKhCdY3sHnu55zfY1qa1JDEmKPwqhKl6I+xXVczP9LUyRvPIWT6y+uMOVAVdF5f/k6qvDqVV3/aDJShwFSJM5RF56fXjs2XNoY4onluRbKliih8CGILKfoO3nJf7Oj98N/UUcPC/O/AR4Nnm/1Zzoe5N2o+sMX6hxdTS4IirhLVoMmGlAzGF1vibCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w02eS95r2V+Ye1C5bkx6yaajlUPQgalKTGIm9oJpS0=;
 b=ddArUOawkldI0A9c4cdMqwI8aI1gqUhbs5x0kR25bxMAi3p+fYw74khWZnTlBndghAYxlrVi2xnRfOHyFH3TROcwL+tEFJTV5tpttOctn+jW0ghJFpz41qK3udlVXAdmXu8JaaGpU2OP+NpyDLF4o3p8B87pxKu24kayO2E2wdc=
Received: from CY8PR19CA0034.namprd19.prod.outlook.com (2603:10b6:930:6::24)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Fri, 17 Nov
 2023 02:11:40 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::6a) by CY8PR19CA0034.outlook.office365.com
 (2603:10b6:930:6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Fri, 17 Nov 2023 02:11:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Fri, 17 Nov 2023 02:11:40 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 20:11:37 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 5/6] drm/amdgpu: skip LSDMA for mes self test.
Date: Fri, 17 Nov 2023 10:09:45 +0800
Message-ID: <20231117020946.2912865-6-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231117020946.2912865-1-yifan1.zhang@amd.com>
References: <20231117020946.2912865-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: ac511814-58bb-47d7-a122-08dbe712897f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FISnAuVz8YMj6AFL4QFZ9AN6Zn5I+2Mo6ePFVTWO3uE+QUSeSL9DDTz2apFNrS708ZBUw9zHDVRpWzIzBgI0SAkjxaYTp22do7ZoQ1bEJjhcQ0d8UJGw2500fQF188rVs5Tyf+mjRmAFXluLa/t3bMDORLuxGZW32QtJvaAPjlThpHMMrWdqhNMS7z2CV53ACmIs4vbS1Kcq/MTzduPk89/3HhZ5HhFToUhU4QvNHHrTG2jUPMzpDUScLWVB8Bqmq83cIi4BXfSpRw3Xywaf67yOB0U07GR5gAT2H4g2Q6MuECrDt/gScudJq7LY725wx705tQJanpxJ+JFeAQ0fVz/8ScbFQ3TOW/ArNuS3+gwMas9pFqpI3bIpObYLATe2gP8CAFKSr25XoJytRkyN5cgplF55hCh8ivyt7to91/FRPNTDy9awmN2+QV5SbNKSLoqy5IsR08XJGrXBd6WSKkphoBCK7LCAri/vd8LL+yBJxq2KvferU1JmmBd8Tv6KETkjM2ye+s/fYBAQQSeMv6yoND30gUOjyQok8rs9N3bpHkZV+4Ji87OZ9yp5Md11nvi2qkic9F7K03QnysWsFa5Istl6OFksTBV7f+06/RIVmqs2OnTO9V5bt4u7RVVVVc29uCCv+0ykIQ1NY5AXzhxb3ojQWHSmJ2WqP2n6MTVD51WIEU+Bp2vC+dxMa/5luicLYek35faCLBZS+SCtFyj4dPq1kikmJQtNGGfSAW95nk87JENcbC8K4f9v0zUywf9dgq31sOYyRu9OhNp4bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(86362001)(316002)(6916009)(54906003)(36756003)(70586007)(70206006)(8936002)(8676002)(4744005)(4326008)(16526019)(26005)(2906002)(336012)(6666004)(426003)(47076005)(41300700001)(1076003)(2616005)(36860700001)(7696005)(5660300002)(82740400003)(40480700001)(356005)(478600001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 02:11:40.4390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac511814-58bb-47d7-a122-08dbe712897f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Lang.Yu@amd.com,
 christian.koenig@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

LSDMA ring mode doesn't support doorbell.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 45280fb0e00c..2464d246aa2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1362,6 +1362,9 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
 			    IP_VERSION(11, 0, 0) &&
 		    queue_types[i][0] == AMDGPU_RING_TYPE_SDMA)
 			continue;
+		/* LSDMA 6 doesn't support doorbell, hence skip MES test */
+		if (queue_types[i][0] == AMDGPU_RING_TYPE_LSDMA)
+			continue;
 
 		r = amdgpu_mes_test_create_gang_and_queues(adev, pasid,
 							   &gang_ids[i],
-- 
2.37.3

