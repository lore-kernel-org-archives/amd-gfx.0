Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43E2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 22:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6749510EE94;
	Fri, 18 Feb 2022 22:32:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1FFA10EE94
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 22:32:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXRu+R+t/h8oij3v3L7b0K0EJ1FKNcwpGadaeyyYQVw4GINZBYKPjMX51v/QBLhyfKAGsd+GVl0sq5fUvVE55Ss6L/WQwKbE7hexD8y3203T59yc1F2/4K5NHXIDgbi7EkqfybYPKAzxrLCIlOzYBvoDOpdRET1OWzGj5xou9HrgcI04X1AtwVrWHC81tTQEU481PXAXHgvca8Y2O0Cp6OSQ2pYp7d+4gPX0rMdKWO7EsHF4mYld308A3veUCgs0lurhwsi0HTXFFQQgAMvIYhQ7FXC2+nXigQYS/NqJEdGnQhWqdqXbqWMmgVyJcoywLSzPGPF3rCBos5zbdrzX0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGbifOzfP3tHmpwiZ2MDlWmOO3xWGdVOyLI2TCVhkpI=;
 b=O3MNTFCHz3tfI8wcMwJuVAzfu/ZezUPQ+EcX4EV7z12MsRBwAnNNlga0vTWuyqXBE4GxCh/SwL8y9v8zYjEvKiW/tZlCk1zCRsYvQuV5GwDgHfOjXtW/JM+e82tcTLRcFiL9UtmM9cd4BtwKGc55+nAYGrnLLq82vpuzSEPmvsbbO6xSb3X6mW/vmoPde/Wj47c9KouGsf65bM6DGj7toXiB66xi6dFVzx3XLZrxcsHaNPgxZYuwZ/q8xskSN+vlD+Ph8yJzTpgR0xc4521DlFrRMQnKMSXUT6zqRR943lJTLH77qItBUr20mi0+DHBm1cYTKYP/g5ZpnD/H+3lczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGbifOzfP3tHmpwiZ2MDlWmOO3xWGdVOyLI2TCVhkpI=;
 b=zQ8NPSAalRjLobw4ieUKBU4r6cXRvFfFUqoM3nAv0Ba74ItMHBhdb980ZsytAsmmOcF/gZNaVUV08tEiBxijx8ydYYHg6Duy5AInWBVjfGP7KkSOW1nheanVUphD5exKMcQEWeRgqs+YgcrP7s5cjVkRq+SBkKtow9+BETsiyDk=
Received: from DS7PR05CA0051.namprd05.prod.outlook.com (2603:10b6:8:2f::12) by
 CH2PR12MB3879.namprd12.prod.outlook.com (2603:10b6:610:23::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Fri, 18 Feb 2022 22:32:35 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::8b) by DS7PR05CA0051.outlook.office365.com
 (2603:10b6:8:2f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.7 via Frontend
 Transport; Fri, 18 Feb 2022 22:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 22:32:35 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 16:32:34 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Fix criu_restore_bo error handling
Date: Fri, 18 Feb 2022 17:32:18 -0500
Message-ID: <20220218223218.1548615-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aef60b95-13b8-40e1-c2d2-08d9f32e8feb
X-MS-TrafficTypeDiagnostic: CH2PR12MB3879:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3879D4DC02B8B6D116669F1092379@CH2PR12MB3879.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dqum3GxL1c8mccw5sYfVdwVI9Ea0T9klPai0ycsgBnnozpTHMbdCBI9TH4J0vkY33ISXWCGwhBb3Qibzxj9bele98ZvAtejIXy/2XL7QQ4sQFhnSykoWpAWIF8iTNkK/I7aADOUSgPNu3FCf1k1UXM4Q5zY8sF+YSXDYiSHj1xXnrhcEr1Sm1yU98MzvteGIA0ZrO5bjr08g1dnWmdCOESkKnrgaqhvqu4AW2PC5IjRl5pGPCO47iK2DKr7Pm4nj8GP1b2x3n3OfNfKOHttOatFJZjyS0qzXpAiqIpnZNbj1Ml2moTwYVongHnjFYMdutR06NQKZw9LsEookce0g5gJ9HeZOxn5qDIHesDS+Wx64MrrMNn9P3QOadioAPPU1tPX6OqH1hOr9bC7pIQ2Xz2cTv/pEOJkU+tUw5ME0s0FjcDlDRwI1nMmuNcrwebGQ3zzUrx6D0tUAhv9HGUPijyOPaMe+Oz9uoor8mB0GaF/iERYpK/5az53Ev0Jd5QREZJVbM9scL677CIl3c0NqmYskcm1Cq16vPw84QDn+oZs5CwuGv0sBDALCpTq3yeLLMc6qxStYmPlLMfnEMqd9fi99NDOlelOFbxHGhAD25deKjjHPClxlrBTqSC3nMlHLZOIErUMqKpInPiUHJryaET9RiZdFA/cR/WRffZxC7pBbIly7kXiK3Q9f3mNxfwj8XbrXiCoPiVvyIgF6fqsjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(82310400004)(2616005)(8676002)(4326008)(1076003)(16526019)(70206006)(7696005)(81166007)(356005)(2906002)(8936002)(26005)(6666004)(186003)(86362001)(316002)(83380400001)(36756003)(47076005)(508600001)(36860700001)(336012)(6916009)(426003)(5660300002)(54906003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 22:32:35.7180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aef60b95-13b8-40e1-c2d2-08d9f32e8feb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3879
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
Cc: Tom Rix <trix@redhat.com>, rajneesh.bhardwaj@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Clang static analysis reports this problem
kfd_chardev.c:2327:2: warning: 1st function call argument
  is an uninitialized value
  kvfree(bo_privs);
  ^~~~~~~~~~~~~~~~

Make sure bo_buckets and bo_privs are initialized so freeing them in the
error handling code path will never result in undefined behaviour.

Fixes: 73fa13b6a511 ("drm/amdkfd: CRIU Implement KFD restore ioctl")
Reported-by: Tom Rix <trix@redhat.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index fead2ed46dc6..ceeb0d5e9060 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2092,8 +2092,8 @@ static int criu_restore_bos(struct kfd_process *p,
 			    uint64_t *priv_offset,
 			    uint64_t max_priv_data_size)
 {
-	struct kfd_criu_bo_bucket *bo_buckets;
-	struct kfd_criu_bo_priv_data *bo_privs;
+	struct kfd_criu_bo_bucket *bo_buckets = NULL;
+	struct kfd_criu_bo_priv_data *bo_privs = NULL;
 	const bool criu_resume = true;
 	bool flush_tlbs = false;
 	int ret = 0, j = 0;
-- 
2.32.0

