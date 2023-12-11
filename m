Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AB1C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 20:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC5CF10E0D6;
	Mon, 11 Dec 2023 20:02:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 846EF10E0D6
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 20:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJzOOvDJ9JalwG++yZLsnuI61LKo0fp5ON7uWf6+9Hso35UrYdwjdUCoVzaC6ptrjLijKQakwYEu+klh3JLJCRt/jOWToVcwFg2ZfaejQaiAdaztppO7mLxlFerUluAu8RVoGi07EcBFh99KFlrA+m8B9dpV1xxPH9gWtUS5lHb3Or71TwzglgRiAEm0BAYKbbGy8fncH1v8HUOXbqXi6yTsPopIxOEvLepihe3+izcAih2U3+s5vzznlmYasXCjjEvzdNv/ztrSlMoBs28+C4v1O1ZyXcoHAIoD/CaEur00WWpAN7oTwXkMKcbwfvFmXwTJwu+Ud/VCYTPlmTfY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kFpfRNBtHL4ZB2k6fDpc6OX9RESHfelIp4NIyLBNb4=;
 b=Ge6XmFNn94TCT/zZxGKFAbW6SphU4vHoQ2IsVx4eyzNR7uv18g7V7yvJlVWyRWZD8f9exjrqCJgWu0zqisyVB8IP+Zmpy/UEKTOQwcGeJ4GQtFyzWw/mzE1eY2HsDZlDnVxwvVjeCUSyKK1T+7V3giLttrOyQ2Tov8RyKQQzuK3Uoov5T5aY3M/Bzir+kvSnUCWBPj+SQQWpFzlhBZI4yn8Cn+bWwrqQHMqVUCwSn2qC1Ym3k17rRiI8UnvLrkBLrbyWs5tsNaOZ+J8padg/bl1OiegOQAy5kzYR2moWCDbhxnHH62hOHW0UALc1mEx0QmnmHfWUq/dULAXGWAUvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kFpfRNBtHL4ZB2k6fDpc6OX9RESHfelIp4NIyLBNb4=;
 b=OIQcurnxHnPeNC6i1ld7TluKV8KCQIZrsFMao/tVPTYybonGwYS2rwtl3wRsu5jFG7Ame4BYuiDCuAhBY0D482GeZCTlaMoulnnNZdQGprE0PmvhF6hD5H5T1LYBX42UeEp+TAcEP1BNEzKrT7aYq0vybyWERVkIxKsAVxlUjgg=
Received: from BL1PR13CA0242.namprd13.prod.outlook.com (2603:10b6:208:2ba::7)
 by IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 20:02:30 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::71) by BL1PR13CA0242.outlook.office365.com
 (2603:10b6:208:2ba::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.23 via Frontend
 Transport; Mon, 11 Dec 2023 20:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 20:02:30 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 14:02:29 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdgpu: make an improvement on
 amdgpu_hmm_range_get_pages
Date: Mon, 11 Dec 2023 15:02:19 -0500
Message-ID: <20231211200219.762822-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208230105.733781-2-James.Zhu@amd.com>
References: <20231208230105.733781-2-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|IA0PR12MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: b80fa990-8319-4adf-5c5c-08dbfa841b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upwVNukKzK+UBW1LTkyaVFWlxRc/AiYdgXgo8caFy2SQoYbldN0v75L1BZUMj64mIGqXDq0b1JENtDnxqbFX7mECwQMPd/f1LV64L9sAA3VnMlFON2exmMTWArGzPBIaaf+LFhm158D31QUVGc4fQsBHQBeMbK0eGo5a0VwVApOWjvWn2XxZkP690MTjG3GSUI8MzYNNeEP3DjPm79rN9eevk/r0XS5yooLTdA+9VulIhli1acG9YQORAZxO/V5lPRUZ4m6yxMnN7h4Uj2RmV35gRnJkqpYQ+Ra1rXZeEHD9mNAbxXknRab1Sk2xLqS1yy2fHiI31L13d5TH5oA57q57wlSwmyvAik7csQo++/25FIf9J2iZhAIpwrM+gg00BjLt0TLaBjBCQ3586E2jJ+i/GMU6jpJTfJAq7uWEQRkkLLQW4osJ9vxv6csoj0HeIGgBdZ9A1haOMMm5xN+uoqZNHotwcNRD+zht0di4u9N47864xD6q7cZLsF5jQbXsPiTwQDXD5C2zOB/EvjaMuUg/wy3rVJo/UMsqKA2zC18f0wbpQKRZb+X7jUyD+DA2AnKDMhbClK0KbfK2YW3X2UCuQBJCENGipOu57LZnZch3Sre3p65wHvQDYq8Bjva6Aura4Vn+kPlOoLSRbDmc4DAobhbr+44G2COOI1P9SFb6IRNZ/LfpdomAenmgJOkkQ41vlFO4qf/qjyBJ/KUA+cAe40A3IanvQ1M+5d3c9b5/CLI6q551A4FS8pIziXBfdd6Dbngt8+MeTFOmtvd7eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(41300700001)(36860700001)(16526019)(1076003)(426003)(336012)(26005)(83380400001)(2616005)(47076005)(82740400003)(86362001)(36756003)(81166007)(356005)(5660300002)(316002)(8936002)(8676002)(4326008)(4744005)(2906002)(6666004)(7696005)(54906003)(6916009)(70206006)(478600001)(70586007)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 20:02:30.1631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b80fa990-8319-4adf-5c5c-08dbfa841b34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7699
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

Only schedule when hmm_range_fault returns error.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index b24eb5821fd1..55b65fc04b65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -199,6 +199,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 		hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
 		r = hmm_range_fault(hmm_range);
 		if (unlikely(r)) {
+			schedule();
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

