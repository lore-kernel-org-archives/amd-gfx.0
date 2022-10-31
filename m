Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF450ECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 15:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9E2110E00C;
	Mon, 31 Oct 2022 15:08:59 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4EA288BE3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 15:08:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mjdz8caZi4adq3ozCPQpBxJCfGPnELFIpX0lcx1QPqPx2TJt4mhPfB8mUGsLEu5R+aUBBKZ2hx7qNRof37HC6shhQY/Z2eWkng1Qg+RFmi6iN9+Fq2GId8RDu7tkfMMW65qN+moYVI0/HbonvjKInECcGh+sUjXc4meccXjIIQh1DjNEHKolqKoJoBiFzyBqziRVAWtXxEi//UCwpnKyR6Waq63PzFR5w23PfYrwAugJUoW/iTgiKY0bH3n8DUbTc04ZtK9MsWhnGK0vCzCTxPzAhZgTLCcl8ABMojQDLRj5r9qsSCrqVVFFXk/2KJ1xbF7v0pIaTzuIC5q53aUQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQPpRtzVH+pmSlmR+wOBlMUcm+JvP5SbXVw5p6TXx6w=;
 b=G5bVvBWQZbhzn+2JSIp8ksYq0Pk2LM6ZF0rO0vSWm0lVPFDIeq/52GdeZjfqB4cgRS+R7r+7/EL3vgX4zEfwIU4H/arVroDcb/XVgGeMwriidSS0m4CKVEs+W+5Dljqe+0tJZYVaWLoFBnZuCWWZbzFiD+0eWSbUA/aoDdFpOnCn6pERzsIfiImhkXXzW/WXAR08JGujXluZRN5t7JAPRlc1d1+IP5QElDdl9lN5nY0hXPcb3l7NaI7otBMhWynrZ91cKxCRbnh29byZeOo+mtL4NhirJXNCfFM8NxqCmFMJUBy5sLD6HgyUO7dONw3svuoe0I8MmXskZeW9Gu+jnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQPpRtzVH+pmSlmR+wOBlMUcm+JvP5SbXVw5p6TXx6w=;
 b=EZxiO4mDfc3zYpBqvUBNIu+SAJiBz3mgXD7x4ezos3ZDCVwhW6ql7etcTZcdUOkOSa99CDTP3o3zQOxy+3WaU3Qw87H/bLKrOaS9+m6M0w1nxfmnfVgLeox+b6hDHTH718R+YV0SvML+oJfDv8hidMSzzAB2MW1kLp1ohDTDCsQ=
Received: from DS7PR03CA0069.namprd03.prod.outlook.com (2603:10b6:5:3bb::14)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 15:08:51 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::db) by DS7PR03CA0069.outlook.office365.com
 (2603:10b6:5:3bb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 15:08:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 15:08:51 +0000
Received: from magnus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 10:08:49 -0500
From: Daniel Phillips <daniel.phillips@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] kfdtest: Also detect under-reporting of available memory
Date: Mon, 31 Oct 2022 08:08:37 -0700
Message-ID: <20221031150837.8503-1-daniel.phillips@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f2aaf8-8134-477d-2c1c-08dabb51d1e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ik8+dOzary1bojrwtQdv5f77OpHz65J7unhd2T9fGBOmrmed4MGZMaR99xQtJgXYBLJHVvDBIHiAfOEGhC+r9YHRBy2PUGd5v6c4DIK3j0bKnaP77/G58WGRBfbOdKW3Ck4mKTFg/Ui49vXx+wOQMT9iS4fhBJo9X6dTZ12eCejix/0lZ86+9YAdnJqkjy9uaecpsMk79SQplVfz/1ooHCnqy3BtrfYYrXtvqRtI/q4ErQlbEKk9/KIPDShkE/uXvnVHm97u+W5JJQzsdNwqHS9DYhjsyJaFepO4gcSabZh7SbwAG2Z2+C1iMogOEXILU7FvB2CA7t3/HV839c1SiZKBRTxrBJrL9HS+7l02AmQgQKXizKDt5tlmWMqzTXji/VZds2BBuUwxsp7qOPZHjAo1eM3CCe2NLWt1GfNOvRRENHW29xLcZxgzPi3zrcsmUCXTxKqUJG3WAYxyeooeLy8AxMPVPKFuM50vZ/FwZO7HnmhodPO5941dUEk03lGn+N/TWCfqcB3EZbeZy76c9c3n6GLoeCjYC03pTID3qx249uc/ZR0dN5W6PHn2vm+iHkA7xBXTi9pWMC6s5oe8cYbj9/Hbq7BufYfQgDf8HyzEO6GQB28TIZBpURV34QNF8ZiDK8ZJ/zYaPNX/MdVpp9+zCohADIh1wURv7Z+wwG2JwvganzuuTZf+uPH+yz6nMho+zCZqPug/ImgtGZlZERwh4D4TAArqIi+zq7DMEGIeEMwDHqFLmN06mZB9Aq8MHs5Ep7qC82ujUA3lT9Fn7yHHOl5i2Dxvof93POx2O4AOL/CQP8SgG5ZmVzM2NUN/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(6666004)(478600001)(26005)(316002)(54906003)(6916009)(7696005)(19627235002)(82310400005)(36860700001)(47076005)(40460700003)(40480700001)(336012)(356005)(36756003)(2616005)(81166007)(82740400003)(16526019)(186003)(1076003)(83380400001)(86362001)(426003)(2906002)(70586007)(4326008)(8676002)(70206006)(41300700001)(44832011)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 15:08:51.3439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f2aaf8-8134-477d-2c1c-08dabb51d1e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
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
Cc: Daniel Phillips <daniel.phillips@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Detect under-reporting of available memory by initially attempting to
allocate substantially more than reported available memory, and ensure
that the allocation fails. Continue shrinking the attempted allocation
until it succeeds, then fail the test if the successful allocation is
either too much more than or too much less than reported available.

Signed-off-by: Daniel Phillips <daniel.phillips@amd.com>
Change-Id: Ib418f0aa26e8db80590a6c5f2578da56a4b60f2b
---
 tests/kfdtest/src/KFDMemoryTest.cpp | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tests/kfdtest/src/KFDMemoryTest.cpp b/tests/kfdtest/src/KFDMemoryTest.cpp
index b4cb37a..f6affec 100644
--- a/tests/kfdtest/src/KFDMemoryTest.cpp
+++ b/tests/kfdtest/src/KFDMemoryTest.cpp
@@ -252,23 +252,32 @@ TEST_F(KFDMemoryTest, MemoryAlloc) {
 // Basic test for hsaKmtAllocMemory
 TEST_F(KFDMemoryTest, MemoryAllocAll) {
     TEST_START(TESTPROFILE_RUNALL)
-
     int defaultGPUNode = m_NodeInfo.HsaDefaultGPUNode();
     HsaMemFlags memFlags = {0};
     memFlags.ui32.NonPaged = 1; // sys mem vs vram
     HSAuint64 available;
     void *object = NULL;
     int shrink = 21, success = HSAKMT_STATUS_NO_MEMORY;
-
     EXPECT_SUCCESS(hsaKmtAvailableMemory(defaultGPUNode, &available));
     LOG() << "Available: " << available << " bytes" << std::endl;
+    HSAuint64 leeway = (10 << shrink), size = available + leeway;
     for (int i = 0; i < available >> shrink; i++) {
-        HSAuint64 size = available - ((HSAuint64)i << shrink);
         if (hsaKmtAllocMemory(defaultGPUNode, size, memFlags, &object) == HSAKMT_STATUS_SUCCESS) {
-            LOG() << "Allocated: " << size << " bytes" << std::endl;
             success = hsaKmtFreeMemory(object, available);
             break;
         }
+        size -= (1 << shrink);
+    }
+    if (success == HSAKMT_STATUS_SUCCESS) {
+        LOG() << "Allocated: " << size << " bytes" << std::endl;
+        if (size > available + leeway) {
+            LOG() << "Under-reported available memory!" << std::endl;
+            success = HSAKMT_STATUS_ERROR;
+        }
+        if (size < available - leeway) {
+            LOG() << "Over-reported available memory!" << std::endl;
+            success = HSAKMT_STATUS_NO_MEMORY;
+        }
     }
     EXPECT_SUCCESS(success);
     TEST_END
-- 
2.35.1

