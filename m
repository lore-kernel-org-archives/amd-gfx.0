Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C633CC0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 21:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66B4D10E51B;
	Wed, 19 Jul 2023 21:23:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 215D110E51B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 21:23:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC5gNiei89zur9c6/dhI2laud1Q7hgKnL5HED8TRJaIjZZDw/FQtgzv5ge0vIjekoOB+NUUGfqA4SdXtgHbhAGm+P6+uKKgu4PK9dT2lNmBTknG7wso8Oh1zc7oHcwSaoNjYXoPdAiD5VipWgyyXEb9/4B9zvXpoUWpqlyUzqsMNnQz6acxMY3uFvYzNnJuEhijdN+Fof00pFhjhMpGdTP3CYNNhrnB2OeM1WImIBYjbykiHRi66xCY6zfWTvZHlmYi0js11WW8p+9CGGVV7eMBBzDvM7UHNMzXl+2EmX0np7XLf+DdxokJrmDxqiRuL1Pjw0Wu/Iz3Roruz4f5Brw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF057PS+MlcebL6M2DULQemY67CSvBFrpZGZsxPiLaM=;
 b=n+zsrDqWzUtFXyXWLra/YnlRl55p3+lIUEjCAiGrEcA/davi9f1d2bUf5Bs9yFYqXoTGRDysKX1B8at07RJ04gQYmVHc2/0V//2zjjln0ns/f2IkHfNhtbjdUSJ4O/+FAJxXVLqLTHyISmB059a1PMYpMgeawt/dw9CqeUMF3RNQ3WnzeKFmYUVRenqsMRjJIYhW+2SMahsHnRhKCC2uqtkM2UnlA24AW8fkYfpm6MCDzpsbrXnb8gf+Ps9UIPZ+a0Nh1Yf1uafZshH+E4cEh3yk+DcLIociGOBREr0hYWUB1OCsX3ad8oqHENbPHCOS6ToAbxvbRVl0NtqLByF/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF057PS+MlcebL6M2DULQemY67CSvBFrpZGZsxPiLaM=;
 b=GFeU5S/fN3xiwi09V1TqbXyDfm3xAOPXB3MQv8pI5ITNwtYYdFBP9G4Jro0jPpuymEzmtLUWKzDG5KKC4bytPTuCLeWFudAWzwKlHVdLwPp+onsmc/qBFuS4mAkQOntFm6OgYFBXON0eQPtvKwj0VJqLLNriL8C7Wyqame1Cxlc=
Received: from SJ0PR13CA0070.namprd13.prod.outlook.com (2603:10b6:a03:2c4::15)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 21:23:09 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c4:cafe::79) by SJ0PR13CA0070.outlook.office365.com
 (2603:10b6:a03:2c4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Wed, 19 Jul 2023 21:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 21:23:08 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 16:23:07 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: avoid svm dump when dynamic debug disabled
Date: Wed, 19 Jul 2023 16:22:55 -0500
Message-ID: <20230719212255.30960-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 33590928-9088-474f-75f8-08db889e5916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 21noj0KqfJV9sgxxqEQDMpzhR9jrcrrw0cdEuE2ll05OfHv2pC1L0Dl+8MjJaq+PzuNrAdwvKe0Yfc332IiyMQ2Nxa0zxJDTyXcYB0D+JspU+JAUAqklg8zKCcEJkzF6YOaz3EX4JP1tFg+oh4puHdgSboWMYMtINMj/z7adkCocfJQiKXN4cu5/zRD5DeRns+xyoYFT6RmfOg9YKwxR4LT26O3x0d92KYeJZybKatUIV3sIzjUxMAto4hdWAs3PWVFdLUAveG0IwHHHe4tQeupisrjaDvA1zHyjwWwB/sLFCTMcPX+VbvySkG5FiUdNIbORzDUyw0vxL5JKe/p/G+HIza8jNZemP9xv9+JAj2/TAbEF9Wft9zDRBJuRJWcTTHldCUsPyOdQZ3tp7B2DQaMuKulilIsjNF1aFDSJVwf3V1cgZQJF+sw1Mr5YUHiTG8puNu+wrb5NLb1g7R9KfKwbJ2sP76MBPkbd8yZ3/jnMcuEzrYylDLlZBbrBr1fpeFJYcSfnpXh5fEmma32AcI/tNP2ROOlBkqmR2sHiUnixQGkFFUfrSy7ZpaRouSHImOzHnGeDhuw9nL/dvm6lZu5D+uAKFOpXyKVDMAigiSNmQuhXitenbuRfIJQ7b9C9QSK+i92o7EkihCltX+EmPt5pz2Nw9tjyZIWUXvjWDdkzcnJBDpQoI58olv9aTm9bzI5bUu2snjApfsXPM2qH0hjEk2386hYV24h8kB8oXCHaRQO3sr8Bhe5B+rnSZyqlKkM81+6SmlN4K4RRaL2EfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(1076003)(26005)(336012)(186003)(478600001)(70206006)(70586007)(316002)(4326008)(6636002)(16526019)(41300700001)(86362001)(7696005)(8676002)(8936002)(44832011)(6666004)(54906003)(110136005)(5660300002)(36756003)(426003)(2616005)(2906002)(36860700001)(40460700003)(83380400001)(47076005)(40480700001)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 21:23:08.2974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33590928-9088-474f-75f8-08db889e5916
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974
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
Cc: Alex Sierra <alex.sierra@amd.com>, Philip.Yang@amd.com,
 Felix Kuehling <felix.kuehling@amd.com>, jakub.kurzak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set dynamic_svm_range_dump macro to avoid iterating over SVM lists
from svm_range_debug_dump when dynamic debug is disabled. Otherwise,
it could drop performance, specially with big number of SVM ranges.
Make sure both svm_range_set_attr and svm_range_debug_dump functions
are dynamically enabled to print svm_range_debug_dump debug traces.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Tested-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 479c4f66afa7..1b50eae051a4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -46,6 +46,8 @@
  * page table is updated.
  */
 #define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
+#define dynamic_svm_range_dump(svms) \
+	_dynamic_func_call_no_desc("svm_range_dump", svm_range_debug_dump, svms)
 
 /* Giant svm range split into smaller ranges based on this, it is decided using
  * minimum of all dGPU/APU 1/32 VRAM size, between 2MB to 1GB and alignment to
@@ -3563,7 +3565,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			break;
 	}
 
-	svm_range_debug_dump(svms);
+	dynamic_svm_range_dump(svms);
 
 	mutex_unlock(&svms->lock);
 	mmap_read_unlock(mm);
-- 
2.32.0

