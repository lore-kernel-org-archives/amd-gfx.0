Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191ADE7F154
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 03:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88E1D10E454;
	Wed, 27 Sep 2023 03:02:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4979D10E454
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 03:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkjXA9O7EhMFIucg4V2Ol9qDv94HS7JzUSHuBWoLs9fOoIR0P3cphUMZ7vfK5vzA9Tks0kVy+9nQj73FghmrEwgyIey4qxSX2IHfN7Bpm9JwDqg1Q4v6O5POYWLtwzk8tTjprheE01sSOmVzP4t/A+jK/4iwY4hNqrAPmuTGSiUbbur6TOlXMFsEwYL3ooZivvTRES235/pVEKsHfNCAIpA+UpOG/oI1A6iOEM4k8MiarBD8dLoGGbTvPR4ijUqXLwVOKPgxtywtEUz+KY2bdkrGLDQ9ULlIqI8S824zLi3T4PHoTiXMPcgo7elYAmHD+7YTQegvMtQ614afVUQSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3e+9pfv9iJI7mLrBK3ljXqcr6nKS1Bpls73SBI5MRY=;
 b=iuWBI4ShcpoyhO57OXXSzxi1M9KwKqDiH4uXEo/SHJtg35eKV831a7k013h8sKEatjjBTHcAwWgaD+lRmvGm6c4FEvyHt7ZWTj0AwX69oFtYkeDHky7MHsm9r/XXbLtGiwA5gkK5GPxoJiV62dtVVleznK2i815C1Bt1C+KOxzkRTTNgBHae+xGtFepVm182os1zutxfAJJAXPB1uxtGWN/K7J+p3/f8/Ct8654JtJi+y3m7RBrI2iTOok6lHzIjLIymHLwcq0JtR2zsURkXJRmKtlygRzFWUpiSGVYS/TdG5S9Sp7HoGQ4p5ERjDUzQf4/hz+x0vPS5bhEMPq6A+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3e+9pfv9iJI7mLrBK3ljXqcr6nKS1Bpls73SBI5MRY=;
 b=PvXB2Kb6zmw4oKP0VMJq3eiu8uJM42klc0jELuO4PKinwNiXx9iYFHvmPbp85Iu3cQY/92Wx/rngydHlitBLb1mSqJGLLbQPjJeQ/lgrWSy29YpqabQWVUp5S65CiDGZPAT89xUvUs7ejXsPNsiJUF4h/+gzrRG1fHjX8thpmmk=
Received: from DS7PR05CA0073.namprd05.prod.outlook.com (2603:10b6:8:57::27) by
 DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21; Wed, 27 Sep 2023 03:02:26 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:8:57:cafe::2a) by DS7PR05CA0073.outlook.office365.com
 (2603:10b6:8:57::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 03:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 03:02:25 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 22:02:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 20:02:04 -0700
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Tue, 26 Sep 2023 22:01:59 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix a race condition of vram buffer unref in svm
 code
Date: Tue, 26 Sep 2023 22:00:08 -0500
Message-ID: <20230927030008.278066-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|DS7PR12MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b247647-d0e0-4790-dfc4-08dbbf062d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XodwzNTz9RCs5ZFoRIK5FWfJdBWpJJ/CdhI5SD57k1P6cKkw4+TBydWJFNm8FOa/hCjyADQLOo4nffag5ILG3rB+GZpDy8EYTAgvV0TGCIQzjYrtpRfXXpO6T0z2d85Ls+dd2Vj92eFbJ2CryGkr/G9s4HSW2Ilx/aijBqXv6iC5e3KaguJMLhCevyvHSrPK4PwyU1Om5XKngYyK31elUCyKqN5HsAtV8U0DfAwjPVzgD6WMdgVz/4IJxmWptB0w2O/c54Syt02fHEPxHNmzLSbs83LeEsoOA7XavcN5ge/ntSJprHqfHwKksHDJvxthEkhDxZx6FyV2V3nl1UcPY+SSm8RbnUKMHlCwaaP+Q5f/i2bEGrPwHcaTQHosyBnqwD5MId6DWQICfjyvB6FTpENVXItZLH7ju8orUwwoZvlM0eWmHign/Auw2gU6XtysdAzAzbhRUNpghHDVDpiFsUODuj3zqi0lzdEeoVyvp7EpsrvbRVFJIVZ0AW3AKiirJ13jsJZvLbS/W1aG5nKt6hnClB86MZhCAEssEurfRI2jFYMHhNkzmnK6WBPDoLwfMAUBPZGedQbrOvF/MY8OVlhGwhcR4AzueoooP7QGWqRQ488W3ceSBTTBNUitql/fOFePsN+NENvhOLxqdF+eI3NN16+DRfnMwV4nVLWGipkU1u+0u4hu4la6P3nIvWyX9RD07tKTsow5Ef27yJfrkMmG9i63rtXNhjq0X6tYKUpR9nFRIfDUThjZy6L5MJHzWcJRjmxdFx3S0sVqJL3Jw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(6666004)(478600001)(426003)(336012)(83380400001)(26005)(1076003)(2906002)(2616005)(41300700001)(36756003)(70206006)(70586007)(316002)(6916009)(54906003)(5660300002)(8936002)(4326008)(8676002)(86362001)(36860700001)(81166007)(47076005)(356005)(82740400003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 03:02:25.7781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b247647-d0e0-4790-dfc4-08dbbf062d95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959
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
Cc: Alex.Sierra@amd.com, Philip.Yang@amd.com, felix.kuehling@amd.com,
 Jesse.Zhang@amd.com, "Xiaogang . Chen" <Xiaogang.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

prange->svm_bo unref can happen in both mmu callback and a callback after
migrate to system ram. Both are async call in different tasks. Sync svm_bo
unref operation to avoid random "use-after-free".

Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 70aa882636ab..8e246e848018 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -637,6 +637,15 @@ void svm_range_vram_node_free(struct svm_range *prange)
 {
 	svm_range_bo_unref(prange->svm_bo);
 	prange->ttm_res = NULL;
+	/* serialize prange->svm_bo unref */
+	mutex_lock(&prange->lock);
+	/* prange->svm_bo has not been unref */
+	if (prange->ttm_res) {
+		prange->ttm_res = NULL;
+		mutex_unlock(&prange->lock);
+		svm_range_bo_unref(prange->svm_bo);
+	} else
+		mutex_unlock(&prange->lock);
 }
 
 struct kfd_node *
-- 
2.25.1

