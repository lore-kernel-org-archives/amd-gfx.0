Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A570C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 23:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D85C10E916;
	Fri,  8 Dec 2023 23:01:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB3A10E916
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 23:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBPskIzJ/hPHBFv6F/dqeP0Enxu5SRwZQj5xVbGldNAWLBQaCYhfF8F2rcUebFfyWe/ftBtZmtnkVDV+HoUsj4GS+nZB+G7lKRzKq7PNgnZOnllfoFAUk/uWyOnTRFgr1Vjy0ZEefqA1egQg6UHFQ4cQbWOtJgS3sxbx85t15O6PEyWZ49d7x3BgUKWaBnUg0grUXG6sZfgWOUQv1cJLqG6inlkuxwt68P6TpFWcyLbH1Vw9mgxK2LDdq9sSIF3v0rwckJN7J/G+NHXgDKjOthV9fZPAyJdwM6DeSrL4j5NQEHqWf/B3DnHYpyzhbmYHWejNW75fELEHCu2vxH9B1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxjbXjqICFKBYV7lbwYW093XyVCTR+QFFKjINVUbprw=;
 b=MZCdHiTltbZUPBBOVqM9Fk23ZjX7+vyaC7zL/VW9FbpK6ouWx/BW1tSRuolTlUs9S0b9ggk1PHaZGljqc+RCqEqgfn/ecplylcJofefl8icoZV8TiAxKdomFgSuVhfUz2pKkxxy5hnXsRNqjgo0HVfUDHO3IKpyFmqzryRjKmMcuJukHxcCY09EOVinvBppD8dU6T0mJG8OeQSZSOiy0T5jINs1oHLgIJ18bu8N+E0BbB+kszmGrYY68YJ6OU2sRhh7yVyWzME5aB/XsSi3KyKJ4NQZ7P2ReOGtIGr35LdT51/POoHTZTEqQ9lYUV1ycS0urscL+gmRVJ0lWwJWTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxjbXjqICFKBYV7lbwYW093XyVCTR+QFFKjINVUbprw=;
 b=sovAweuM8y93Z5EhIfniJ8c0Z+1qtZYj7mR8fiwqKaiVteCvmz4eYbvGBtovmIgUtaRlkOluEbkun5twqLI/vw+FU18+FB3/BVwyeo36XwoT8vU94Q+J6wRRN4Fs9b4KOF/elFivYbERsbYCyCJ5hrPhCcowisaR/+hcXKAA/7Q=
Received: from DS7PR03CA0015.namprd03.prod.outlook.com (2603:10b6:5:3b8::20)
 by PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Fri, 8 Dec
 2023 23:01:18 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::6f) by DS7PR03CA0015.outlook.office365.com
 (2603:10b6:5:3b8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18 via Frontend
 Transport; Fri, 8 Dec 2023 23:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Fri, 8 Dec 2023 23:01:17 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 8 Dec
 2023 17:01:16 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: make an improvement on
 amdgpu_hmm_range_get_pages
Date: Fri, 8 Dec 2023 18:01:05 -0500
Message-ID: <20231208230105.733781-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208230105.733781-1-James.Zhu@amd.com>
References: <20231208230105.733781-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3551cb-d216-414a-2ee0-08dbf8419616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGgQCH97KungJC+455JE/Fix3bxcVa5ynD0U/ui7xgmlYRCdkZlhXW60qt0xdGya7Bp3H/XfzBZqvL9Z0M54BpbknalfsuX1lHcgS+ZyvJ6Tgj0akMKlE5/a19yVwt+EYmSyRNfBqFrE18y8w7EPEdwZf5efva1fPASlR6DPRuEuvNalARjwUL+1OA6u1RdJq2fND4yuPfcNeloDwiyYhljLl1STdlj+Kh95orVoHs+4bVKlXQci/9D5bpjaSC4wAQSkfg42IIsbq0Gf54aLzN+5oiyhwYouRfEDvFApVgEnZ/JrgA5R31+W8aCz0qBo9eFBipKwSlTYRlZmSwlv/+skebqVHUwD3ktahsKAQSzMDFflI+Z7pYrH92HwBnqj6xFK+Lslg/mJ+ufPezrxxBbx17RAmNtXMExsLXoiAaNQXgWiERCazoo7LR+2iO7NbchxBKNY5N02ACTFufiC87x41FvVogr2MniWUF/Dvmk8OVd6qiwwQRXMho7zlX6g46cl7uEv+patB+Mk8THbCS32diuKO4e/S9hP4nJdOxncwSj539lIDRXQSLZA0VFjJAALjmIQhFyxm2Eq/53l1MGgGwhOG89MA9B5kecoPkZm148RqFX2OkNyxducrZd+e2Wa0RYNB9Bv4vkagLPjxwA5H3Zaq1mNL+pP1PbecqAWh/vCuKRx8ht7JsKYDoSWX0CHMJ0ai7uWcJR1ZndPE6elw6SwjQCk8nPBvRDiqEaL+BGUmmdn1wQjF3AEUi6tVchJ4fGFUmL7ToExdCaqUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(7696005)(1076003)(2616005)(26005)(16526019)(336012)(426003)(83380400001)(36756003)(2906002)(8936002)(8676002)(41300700001)(4326008)(5660300002)(86362001)(6916009)(316002)(54906003)(70206006)(70586007)(478600001)(6666004)(81166007)(40460700003)(47076005)(36860700001)(82740400003)(40480700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 23:01:17.6874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3551cb-d216-414a-2ee0-08dbf8419616
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054
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
Cc: Philip.Yang@amd.com, Felix.kuehling@amd.com, jamesz@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Needn't do schedule for each hmm_range_fault, and use cond_resched
to replace schedule.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index b24eb5821fd1..c77c4eceea46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -199,6 +199,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 		hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
 		r = hmm_range_fault(hmm_range);
 		if (unlikely(r)) {
+			cond_resched();
 			/*
 			 * FIXME: This timeout should encompass the retry from
 			 * mmu_interval_read_retry() as well.
@@ -212,7 +213,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			break;
 		hmm_range->hmm_pfns += MAX_WALK_BYTE >> PAGE_SHIFT;
 		hmm_range->start = hmm_range->end;
-		schedule();
 	} while (hmm_range->end < end);
 
 	hmm_range->start = start;
-- 
2.25.1

