Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973FC606A326
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=blVqedDY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3423F10E2CB;
	Tue, 10 Nov 2026 07:44:21 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C68810E08B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 07:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9QxiJQBR9zF6Me2SIpe7fbie9+a23rW0pUV4Hguh6HM7cJAex18HErOfXjvEBT/xYNTiwVgW9rH4iJ3uBvhn0kjuYNkD4q6xa9/yQiZtskj10siqB0TKn2h7rXglh7pwZn8u7zBGX/awGYQ4KLbiz53mhRd96BoRPSlVlExqJz09yQwLYDUXFlzPs5HdiFduSvB4fCKN1aqZDeF3qogSq/341Ya5HXFAjy4vMBcUZdPrWzkQSwXYp7pYb+4Jj/6GjHxV2DuL8IANjZ0R86tijnoIJWWC9hKgehtX2ivCU64OIX21PobJDbwxdxJECYZ+5CpueVso/i3FEc3JYSnFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VrYlrQzM7VJCR70aMexwfVFNAWMCl6OsK9MQGBFvvc=;
 b=I2Z4rZAAzapp5TKYzNvvlVg9BjafxuCAPdsLzh0jfwK9iLXXMbo+eom23tWm06K50A6anmbRa/OXGn0MEeMKJQU2HUyTtAiTu/py/Vb1MxFyIfutufRGk+TjzWwuTBpAlwoB45LmYXS2+p7vRtqSuxcmsGaqIJC1g8cwFHPIqy1bbo447aNSpBGHJAXsKj0PjwRdJa9rorsp+cR/Bd0KlWsJ3ujg4Hh4Mgxlr7Fc6CcU3E/VlgdXtXITi0RCfVwTgEt+iZfyE9lKLqeYrcDEC/Cv/Zf2iXbIr6TgkwfOSDZPX9LonoNEmcxoL3TFNbrqng+QAtxWEDZaecWRhyvu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VrYlrQzM7VJCR70aMexwfVFNAWMCl6OsK9MQGBFvvc=;
 b=blVqedDYmacK0ytNGQAzQ5+fzDESB5Feej2bnVmUUdeQMy0pKqiqWBvL/3HZt3Vxu4koypEH6XJFCnO4OCaG4Q4bfa4Jvgu4JKAL5HW9inMLQSjxQu+m2S+nT49WvJny+NRaWXHsssqzD0oj/xh+Z1y277JqP8/NjZ/EUNoCUa8=
Received: from CH5PR02CA0021.namprd02.prod.outlook.com (2603:10b6:610:1ed::26)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 07:44:11 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::9a) by CH5PR02CA0021.outlook.office365.com
 (2603:10b6:610:1ed::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 07:44:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 07:44:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 01:44:08 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 01:44:07 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, <philip.yang@amd.com>, "Jesse
 Zhang" <Jesse.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: don't check the HMM range when getting its
 pages failed
Date: Tue, 10 Nov 2026 15:43:36 +0800
Message-ID: <20261110074407.3360908-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 484fb972-1631-436c-cac9-08df3efe68c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|10067099003|3023799007|261028144727099003|11063799006|261102123227099003|261021121427099003|261026140227099003|261021123027099003|261022105027099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: ITEbesB8NSdVXeVhkN4B63tWCpYSRoyfWIsr41diOx0nCIBhg6YzKyQXvvAEwRZf8kBEeIqrHOSuiTIK/8atQjnWvz1av65dzaRGDUbgFggYMhrigLS+S4Sn7kuhDfT8t39uCay+AeQKSkWXgSfCMnwz3n7iUWoNDnq1k8wqJ+IiNIKTLjjtnjMnGhTH0X2k1m5YQRLb/qfV4v7CfptG6nRrIdOPQH/gG+ZEiZFw0qY08FNExxQzUf+IT7MZiyumSFr77CUtxITXAh3jPVrwPA07nDwexR3CuqpjggjeD+uwkR4UL9ePCTNmVhurCqB4/b8/V10oGWsr/Wg8DMKQDXH4tZOMSRVqzbzdWiKVlrKQa1eEDDse+yWg4babpznJXx75tgsGPQgdd5vxImstbW0UJy4271rmkd0ToCweQ+h8dpp190GXareKVPrupRvEIi4HWFyBLAWJh9qZZOpSm/hbh3PvfDOiZplAPT+5nZ0/iVnAZxPJJQHSm75njpzVibAXivsVMLOl+JeJauAjvNwGxFE9qyAN5rHVRF3EO2PzqUDhZC8cwmDWidn/UagNaXrNN+R9DDwro1AnFLCvAvi7We15TisX1ss5nVeTC5j/BtUfs3cozdVhjCHFvQfUXMY82h8Rl9oOGeVPd/qA0mbulo4XOKCv6Tx+6zIgYUjMdtZtyX1gF4pXOizKSqV2OUmjkO06alBWKJW9CE3GYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(10067099003)(3023799007)(261028144727099003)(11063799006)(261102123227099003)(261021121427099003)(261026140227099003)(261021123027099003)(261022105027099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ouXQKYEN0eN6XIPz2Ot/bemlwtzu8982aunVvJ9yT3wDL3XSpBM0NvFnJ/Dk/JU7QrlyyAkPdwAlT1+XEENMfKS48yYPvrImAOXgpCCL39WwahJfO/4gZcn7iGWmYgq6xfPNk/m/5ZoJHcExzHfVQGu6sHRnij5xqsducix6ZvvWwBzjFF3tUZ9dmy/TDUGBV4MWJvo8AeSj/c8THYWsv2Sq0/OYOtV2t7DjXGDFChbBJ9Ep8WgkTGXHy79AsxbVK64963qVm4Ytyq2WhMcbsIyPwtlCeJgIaEV/Z05r8pcgzgCzio3btnTeKVBxrkQtMgL6IrygvX8xtVchMEXF4Wz/WopIFTDXfOrGE/xFpzumh8uyJhWF1oPi+Gv9rJesNUvCKGlWMkXTKThEAv/49pdWZtiTbzt5ICQqFY0lTfRx96ApxzYqyLUuIRVHYlD/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 07:44:10.9908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 484fb972-1631-436c-cac9-08df3efe68c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When allocating the PFN array fails, amdgpu_hmm_range_get_pages()
returns -ENOMEM before setting the notifier of the range, but
svm_range_validate_and_map() still checks the range, as it is not NULL,
before looking at the error. On navi48, setting SVM attributes with
failslab:

  KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
  RIP: 0010:amdgpu_hmm_range_valid+0x66/0xa0 [amdgpu]
   svm_range_validate_and_map+0xaef/0x4e40 [amdgpu]
   svm_range_set_attr+0x193e/0x4610 [amdgpu]
   kfd_ioctl_svm+0x137/0x320 [amdgpu]

Check the error first; it is only 0 when the pages were taken.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index a571fda5c713..0879e37faa71 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1895,11 +1895,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 		svm_range_lock(prange);
 
-		/* Free backing memory of hmm_range if it was initialized
-		 * Override return value to TRY AGAIN only if prior returns
-		 * were successful
+		/*
+		 * Retry if the pages were invalidated after they were taken.
+		 * Only check that when taking them succeeded: a range can exist
+		 * without a notifier, e.g. when allocating its PFN array failed.
 		 */
-		if (range && !amdgpu_hmm_range_valid(range) && !r) {
+		if (!r && !amdgpu_hmm_range_valid(range)) {
 			pr_debug("hmm update the range, need validate again\n");
 			r = -EAGAIN;
 		}
-- 
2.50.1

