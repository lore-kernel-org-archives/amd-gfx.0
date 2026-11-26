Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9698606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DsMgjs+z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD4A112367;
	Thu, 26 Nov 2026 11:36:00 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE9FA112367
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 11:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXm9148PddSl5ub7zkVMkrIgy9Sca9dOVNUsZDp8ClHYR9rQaBl52bIBYWzvCTHBbwbxNWX8/9wDeJCFakdwQgv2r9LexWzkaWqQ4vLNK0Csobq3meHS0ciKVU4OWPHEkUBzN9+CXDieQBRMxSFXsyWBS8ycI272jgNfWQDDgeKuEWgAzJewu2cCYaGhgbOcUyNkSYBPJ8rnwIXQiwBdnZeoKuv+MYLjz13Yy0iXgHvyk1SRM7qU2ve9WRJuVl4kIJfhlq1zzt8f5B2TNvFTKC56hPS1hsHEUTVyDMK+kBQFGZATkMmFtFqPIxs3xWeqaqaCz4XSPCKNoZzQORKEPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GggS5R8LVesgIxWQyXDGy0JhcptFB8wJYwNAutP/ltg=;
 b=wbJ/sBUAbpF7U0RdG8BYKAcgbW6gEFYJMdABdkcTNtXME4QQCHVyq3ogeKWvaSyD56bXLbfIJ6Sn0NDfDecv8zBzTaEgXzsL9OF+43EWk4RVEW0yE4br8s2gUuW3f2P/9bCdvMmpge6CYbCq96a83kE8AaYdAUmwpEzrK86wZAJT0QhoKZCxwXnrs56ZBcIGEfMl7elJhrlb+lPpbcoBIrD9iYPXFE946sjHTSgxWZ8UZ12e9QEcK8mwM9dTpKpyAr+I1XC6CtLEZeYbnAJpwKIKKvsihQf7yKQHKuy/CdlrvQJxplCdRAOMDRzeRGjGs9W5C7wvWMdrQsWYz2LMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GggS5R8LVesgIxWQyXDGy0JhcptFB8wJYwNAutP/ltg=;
 b=DsMgjs+znA68ky9O2wMNau6EylybVnYSiX1Vd4wdVK9J4tn7uA+gSCiw8BaW6joH/fdN3Ae6eqh2en848EriB96aQN0oBJIf4X6d3d7ukmXqeXWzXU8NdiQ/6TVZN0WG3BgyUKt8LZIkBZlEcXt0imkqcyf6wu36C6U9OhLZ8XQ=
Received: from CH3P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::35)
 by CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 11:35:48 +0000
Received: from CH1PEPF0005BD62.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::3f) by CH3P221CA0004.outlook.office365.com
 (2603:10b6:610:1e7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 11:35:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0005BD62.mail.protection.outlook.com (10.167.244.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 11:35:48 +0000
Received: from satya-SPLINTER.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 05:35:45 -0600
From: Satyanarayana Yandapalli <Satyanarayana.Yandapalli@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Lijo.Lazar@amd.com>, <Kevin.Wang@amd.com>, <Christian.Koenig@amd.com>,
 <Satyanarayana.Yandapalli@amd.com>
CC: <Priya.Hosur@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH v1 1/1] drm/amd/pm: return -EOPNOTSUPP for pp_dpm_fclk on SMU
 v13.0.5
Date: Thu, 26 Nov 2026 17:05:17 +0530
Message-ID: <2ab1157611dfff6e6c754ac4d6578fffc9529309.1795606828.git.Satyanarayana.Yandapalli@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795606828.git.Satyanarayana.Yandapalli@amd.com>
References: <cover.1795606828.git.Satyanarayana.Yandapalli@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0005BD62:EE_|CY5PR12MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: 732fea54-18be-48b4-34ad-08df4bb16adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|261021121427099003|261102123227099003|10067099003|56012099006|11063799006|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: EI56ZIpS0e3uNdCkvierzDFPxGatd9N8vxLSGY7vA2fbz+oZSn6iFZvPyPPY6A7PpUvPqI/ELN7O57YTo9El6WD59U9u0KGrx4nVQq3STMxY3vpzAQWLOQ5rTWzrUgj60lGPRsIyMbfEPeorJEY2POup66ybviodDkMAey4KRSJBv/o20IXLKU5E2w0HUrQCQfIcKhWXMmoE9MKdMU5spNPGuuTHLN4iA4u8qLD/EpMhBErgvPrsPRvAIvvzwGE1hcf57dH/1KLPFvbuSYKWiRpPHvDbF6mLuKgzH32z1EcdEI+87hoc+gH1rV9gsvVCKOjMGiX/8ThIWsVDcoesyYJPccBqvFibhu4JKdyg49m2ITtdjeBG/pbTja+LrHeSEgrazEBNP7xuLRHsNMxs2KmkVaTAQtAG5rPWo7C+z/V1qwMRiAjaR135kVQ69pFCImOD3dnEdb4iDmR57qZhRHFZ+NP34QV+V0EdpwrUi+9Quhf2cECMrXKEXPyfc2546zgnqZt+tl2/ugErJsAhKoiaRw5fA8RCvT1tcJE6kyQEiaYyK7gHa5ecCNKG504MVv07YE3Z9MhvVju3Ep4h4W/f1Q6/3gNVB/2etWbKRwNmm2wR2VUwc+pPnpCbr9bTxlphqHJcwGj0SFd7OPZcZdQPGOnt/j9QTLStbDcfjqb7wiL4i/1N/jJ69yI0Xaa0tB0bKzILJooudw+6+/NTgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(261021121427099003)(261102123227099003)(10067099003)(56012099006)(11063799006)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0qa+E8i6wyYXHQ3cMPRUoBwrlK5gJmXK3ebkfsf7ZoUS521ETcmOD5iN8XZKqvke2X8EgAHAeGIyJ1MDbG5yIXjTz4aGFeLL4NJCV9TfORCgXc1X5TEXKAwi0XGW9/Hdm7z9K4imOiQueDXDEtvA+eAo5ynElwaxWHY0eHjfdkbXm3xApqqL3bEl8xcEoE2j3knG2Zn8ACjgzxgnmY2P0j/pWewuYGx+O1puCiT2514ye0zB0HASwz2CEm9wyCAy17RB6tKlXp8vYNDFD8YH2m2ZAUp5UqO/EyKnEH7P2c/YIXke9V3f2kZNoFvdEpGh2108i1qroM1g1Ml4D1woISf5kogx2ulneMqYzKVbJygnBBh6+NoRoUoiyDpSHdHFQ6fQo8wC6/pxiOGTtiitVVvcuGyiwtS0SzWEQ0dGKSAXjgyRH8CKksG8U0z7IFlT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 11:35:48.3654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 732fea54-18be-48b4-34ad-08df4bb16adf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0005BD62.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646
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

SMU v13.0.5 exposes pp_dpm_fclk, but FCLK information is not
available through SmuMetrics. As a result, amdgpu cannot obtain and
report FCLK levels for userspace.

Reading pp_dpm_fclk currently returns an empty result, which does not
clearly indicate that FCLK reporting is unsupported on this platform.

Handle SMU_FCLK explicitly and return -EOPNOTSUPP so userspace receives
a proper error instead of an empty response.

Signed-off-by: Satyanarayana Yandapalli <Satyanarayana.Yandapalli@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index f95b15af436d..c48e59a745e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -928,6 +928,8 @@ static int smu_v13_0_5_emit_clk_levels(struct smu_context *smu,
 		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
 				i == 2 ? "*" : "");
 		break;
+	case SMU_FCLK:
+		return -EOPNOTSUPP;
 	default:
 		break;
 	}
-- 
2.53.0

