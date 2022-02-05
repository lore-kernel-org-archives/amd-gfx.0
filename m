Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331D7C4321E
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 01:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A743310E424;
	Sat,  5 Feb 2022 01:51:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCCAF10E417
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 01:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wdh37lzJHgV5ZH5S7SrKaxz3DsBo19VnFENu0jajRjswyXYg0pPeEA4YFvLqNULZpR0mySZ+4O1nXsX7mVuki4VDgKxGr1aN4NOUuLH+d/j+f9gBNAygDQ/Im3btfFdyngx8L+2ffdFPEpbJiE+Wy5xWF9t6b3oeye1J6RpHvHeZrT2lH6HKeFBwaIlMoMCVoOsu4G4mlvQCgpcrP9VLASw9jYa7xLeDm3uksHQp9ijfKajiaSM318iAOZwgirF4CmEbz6STl/+kwLEZavGIQdJOaOiG1AgR5b5E3E5B5+JTKHfxet9ly+CVv0e2aAQQY3jDTYQPQkWbEhuwCqlsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glH4CXE+z8NPLu+7+ekBuy9SoqToJ5XwYKCIi5ETN2U=;
 b=Nd9RbKKcl7cdFDMa3kQfo6C75eth9ZEkEpRtNoPV7+dVPVGeM48qV/c6TTCLEpZaPgiVmmO8LgnRLEnU3pdT4QyPdbms36whJvqx4p/n4+Gz7Ou8SVHzDZpllwJWRpNaPiq+3HmufFFMj8SyJk2pRCEbOU/yxi12ld0tGrKtk2L+QrDSLXd+5gIWUlK7n/4DupvyvX7boyqXbg3vkknroR9mx5rFFua0q+mXHmsduFqoiZsjABPSs+kmYXNqbmUJs2ZU/81LXW1mNu+X7PyVE/t3DiXpOVggZz3ZrWJG/ca0Fg3BHvN05Sx30EENUGbb/r8bBI8VZCsu9OMuk3Kf6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glH4CXE+z8NPLu+7+ekBuy9SoqToJ5XwYKCIi5ETN2U=;
 b=jVQ9zaOw11lNrn1rgluxGV/DA67LUQZz+RxFo2dro4i/EW5ILxV7Hj/YfguK5V7UhY3NdOzFg7COBJwPxjTgfeHSvhHAN4ymAr0lIA2rJtkSBJ6C556uaHRodvmye0Pln3U9DhYeRRYsLviOTPnG6r+e3LlS3/C6TCIBBi+3ECI=
Received: from MWHPR1701CA0008.namprd17.prod.outlook.com
 (2603:10b6:301:14::18) by BN6PR1201MB0164.namprd12.prod.outlook.com
 (2603:10b6:405:4e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 01:51:05 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::55) by MWHPR1701CA0008.outlook.office365.com
 (2603:10b6:301:14::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Sat, 5 Feb 2022 01:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 01:51:04 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 19:51:01 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amd/display: [FW Promotion] Release 0.0.103.0
Date: Fri, 4 Feb 2022 20:50:26 -0500
Message-ID: <20220205015029.143768-12-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205015029.143768-1-jdhillon@amd.com>
References: <20220205015029.143768-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 224e19f8-8e2a-47a6-745a-08d9e849f891
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0164:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB016450A6855F37A069C1DA6AFB2A9@BN6PR1201MB0164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3fTOleErbwr1Ll8mZw2CjtGtmRyatSCu0GiJ1f07JpuCcRXcweifJKFaVctkDJ05iOGZC6a+adF7cOVDioHQ2LfT6KVlpeCGgWD7LZZSA2SmJzeaT5H1mYqWSm1LlUiHzjfLv9CosNEtRIET+/3d3mhU8bA0Wruk8dMqtTTLGj7TmzLD/1z7dNYD+D6x7VWNABoO5HC1JqPsLd6jDCtoTdP4ImIhZeINJ7IXiaiZoa/ukFmIE2PWdAlXK38skKqwOL0Xscdu5RDcP5lnWKIcUgV9HpkORr64yq+nlzTeP9fUAyNXph4fksEUY1qBZkv6ULYjyGhz22i6kSRkOlUF79LilQ61qbG6P/a3KNdNOzHtTlX731XR+vB8xKPryPkrRUQSzMUt7iK54J2P65qIS1LxZXf9plTZLKLMXlbHomn/uRyJdIKQPyDrFcuqamXZvokrUGWRbST+CDxIUREw4TIpgKK34q81ucz0oFaqo73MIxVdIvGzGv4XgaEdVTY5K3K8I9au0wTtAtWQG7lB8WI36daLKa3Iunm87yE5xIgOa4A9DMKzUh4OZrU9CEZykWmWjxfad7jC/19rFk6v1Hg2U9r1zBIfnCrJmxhaeBg2u2wJbxBjjI/f8HhHZ63T4TMuKQNpgF2V/G8JutDuOnRy4X1ZPM6Jp3ff5nsAaXgU41haAdSiE78rs0d36jwr/1oJYoYbEOCcOqWAEt1yA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6916009)(83380400001)(54906003)(81166007)(2906002)(4744005)(356005)(40460700003)(70586007)(70206006)(47076005)(36860700001)(1076003)(2616005)(336012)(508600001)(4326008)(36756003)(16526019)(26005)(8676002)(6666004)(316002)(5660300002)(82310400004)(426003)(186003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 01:51:04.8299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 224e19f8-8e2a-47a6-745a-08d9e849f891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0164
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a01814631911..c5cbbb0470ee 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xab0ae3c8
+#define DMUB_FW_VERSION_GIT_HASH 0x5189adbf
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 102
+#define DMUB_FW_VERSION_REVISION 103
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

