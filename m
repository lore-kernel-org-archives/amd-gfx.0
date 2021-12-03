Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01365C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 22:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 336B3AA4AE;
	Fri,  3 Dec 2021 22:59:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8281AA4AE
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 22:59:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfNh3s5le5MhQpkuWSdQX++81qD0ieaqFYSO5r9n86GQKLGDIfCqXVNg0uqYZUdZxj388ZDWibtz3qKu8wy/HBiKwCin7x41VjG5bAH5zJzKqeQYBNBPV5W3f45RZu9QtRHNqoZJSMkqHtma/4kV4tRAdiPX+gyc4FZ9Gb+VsAIIbqSJ8olfsXkpEGYzKglhGqm1Vra8bwkOFiHfSbzkywde1/zYwdYgjCFYUMrakor9wHTX/V7EV2ysI22vGCh8XbNWGffkrDfC2Gq3QLR/EVbgEljZnZ5RQYsDmqYcQyNGBzOyaEdjq9FNIwKHhGwHNOJ8mRWnyx9EwOwaVOB3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U07O2yDeprUP/yP65GDkQu4jxRalO/EhinxQCBXpe4Q=;
 b=C4SLZOXrrEK4EUUTGZiVC+RIvIHH4Oe9l2CYLBQB+hVwTULAtwHIfnRxQ+0efRrz8HE1OZ0r6Gj4oCWCo0j33BrHj4FZlmYeO5ZIZY0ImkBKBHe6JXWmYYO0BdcUkYrSwh5tptnRpnF+6ZK4C/ahM33rjdIxDxft+rMOxy478jI7jWpBAOgTn0LMV7SwkDL0Ti1ORJIVA8tGBLrqnsTSM0ii3gofWGtot0Tl0x9ymlPOMYtvVl62tdYDHsj0KOnE+ACwUp9q+oSLjUqDF/eQc36xxVNXciLIkENaw3dKlPAjju5yfxI7ygGqFDuE87cbkRJSUs9rafyb3Wg7CFsYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U07O2yDeprUP/yP65GDkQu4jxRalO/EhinxQCBXpe4Q=;
 b=wi9uHtFU25mkgO5UDP+FTnW2JZhk6GTmegGwVegFueuuvwNyHu2p9NU9WYuXJIzB9yuRYaLRX0oKcik+y/t4chmoTL+7bSxWcTDcPctIhrsL3rVQtw1Td3X3Zn/2zEaXW3vTvd1eDQibldHuYgF2p1++2SG20UjV//RvpVZKFdQ=
Received: from BN6PR13CA0055.namprd13.prod.outlook.com (2603:10b6:404:11::17)
 by MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 22:59:16 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::8b) by BN6PR13CA0055.outlook.office365.com
 (2603:10b6:404:11::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.3 via Frontend
 Transport; Fri, 3 Dec 2021 22:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 22:59:16 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 16:59:14 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/15] drm/amd/display: [FW Promotion] Release 0.0.96
Date: Fri, 3 Dec 2021 14:57:59 -0800
Message-ID: <20211203225802.651367-13-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
References: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a05c8083-b82d-471b-46de-08d9b6b0884f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3022:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3022F0C68EC8434C82CDC95EFC6A9@MN2PR12MB3022.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4ZayvrG8dGR7+I7PICtmgHBIi5SLi5G5qEOEZpglAwnkQIZn9/rwV5Y3jlvA0ra6zo4m9rhLv1yjm+BDt4A13vI/RxCp+exbrgFRAM16vSHiJEb3jZBhk3DiVkxdmLk8LAtUnfvGzXUcflMxR3kmzY0CFsNrQ6D4bli9VlerlVAo2in34mdDAhfMQs5otggnmM5UV/kRNZOHfKE6GHxRyTNeK7xkWXLnZO7zT1S9nedMZEzcIi8OWudZIMLFSBd7lrR5dt5MZ2p+Iu96nBXnFW5WqCvbnIETAjNADDyN3GLsJ4tAs41gbVrE+nriBdw7HKaZvuRHsKj4jIL8MM8cmlSP7axUmMSQ7pFAjgjrH5psrB75i/eEohtd1wxsNRrrvSGRFzSFL5e8+1H8uPqFxEKFYI4IIW0tOwHLnA2YdvnTc2TJJDn+f3fgRcoSmlhFztKWvv6D6CXvLRI0pZmiYtPw0r0/2i3MSJ6PyWi+nikk1r3FCByMVGimKKZRQk2BU/hDl/2icRF32v3mF9Cgy3CpMjPOxkQSYMTdXXkRljUM+1rdpyl3Be4+wxn6E+oITsEAENbFB5DMFuLXWwjG7wVYRKvG6/RqTW/ThDe5ICdwUuC2S8BZcESO0Eyzv/BrsKUrGgVLKnmPP27XFkTJaXg3O3pQVR5A7ym+CyMBBm+Hf41QkRzqDZ8RmaDiN5Vn+KxiH3TFVcRzI9A4TqZkvMzwW38osCsd9ED6T4JbE4yprdEzyeOwW6mXCg6VOHqStE9WpXlX/Y4dOHTd6yIJqMYAc+cNGCUxnyq9uuZQMk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(2616005)(8936002)(5660300002)(36860700001)(316002)(47076005)(86362001)(54906003)(186003)(508600001)(336012)(83380400001)(26005)(6666004)(2906002)(82310400004)(4326008)(70206006)(1076003)(8676002)(356005)(6916009)(81166007)(70586007)(36756003)(426003)(40460700001)(16526019)(4744005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:59:16.6719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a05c8083-b82d-471b-46de-08d9b6b0884f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3022
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 8c53ce426466..45af0a7b7da4 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xb3a083a5
+#define DMUB_FW_VERSION_GIT_HASH 0xbb1f0cda
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 95
+#define DMUB_FW_VERSION_REVISION 96
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.32.0

