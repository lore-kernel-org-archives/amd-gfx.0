Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21280C982D2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2FE10ECDE;
	Wed, 16 Sep 2026 17:53:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wP9qN+xR";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E0F10ECCE
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5KeFMetTGyFnQUS5Sk58osZIgPaaG6vdKk9mcXZNxDK2JTf0DcpxfYi7MPETAC9dfbzzH75pauXkSGSRkO+7t4ialwVf9+VIpCB/bSHKiZRW0B8owx7QJgSLNxdMMOPEQm9a9jEZ11pV2VlvAzm04rmkYkTp0JdGhl3GWpEfVjORRnggMjLjVgQqjkyX3RSw8+Qq7p+xK7nYaJf6ozKufDHZhwUlDHW87bOTSfJB5P8GQsDRRAWDiRtbsxTTXLpQO40GHzScxHB15yXY7xNTrty/ljg07NOkkrxZY4dEAcxS1TM1nkhQMO74Fi/z1XaKEJeo6m9rHLXaz4fPCt09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29hhqfxKo5YieXXekh5iJUKhodSz67SVHYg/Y1ChLzY=;
 b=tfVm0qufSaQB7ye9R8uuYOEJtSMAzHuAG+At/2G4FTXz00LvKAfzpBOKiF12e90J/amEXTfuNXS1B/WT9Spf5obl5567fQgeGTF6LRgDlSLejxgFfkixBhUdSl95i9fEcPzEeaQPJKJvDLpGmNXepHBHuz9sj2cYkzlpGQ4EfSi64xvY62EN6ICOZgGv1tB9WCTqBu8kUjUYvCOYtoZh8DE8RJAoPQXUViToCtBJLnaV6nBnXb/K1SPOnbzi3E1MmjP0oTj8fviyhRktXFxylqlFPPY1tggHAF1o/GbHbqXfXyHCaFgIcUbsi9sEz5nysdXOTlAoJBiTfLL+RNnf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29hhqfxKo5YieXXekh5iJUKhodSz67SVHYg/Y1ChLzY=;
 b=wP9qN+xRTNQsK/3Rucgz9Nw04tIJ5AA1CUyvXgvQl2AkDU9fE8KVweFdHUtaIXZFiCXfgYjTgbbOJlAsGVziEftlvWeXkr5ypqpkEGr0uqBD8CmB36V4HtkXuBFcAB7y8NQGLcoBtJC7BXt6cpAmebvQ7XaMe1hiFKwNPsYxJdY=
Received: from CH5P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::13)
 by CHBPR12MB435029.namprd12.prod.outlook.com (2603:10b6:610:33e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:53:04 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::47) by CH5P220CA0007.outlook.office365.com
 (2603:10b6:610:1ef::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:03 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:50 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 47/64] drm/amd/display: Fix KUnit helper warnings
Date: Wed, 16 Sep 2026 13:52:02 -0400
Message-ID: <20260916175301.368306-48-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|CHBPR12MB435029:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a6845a-f215-4f60-cf6c-08df141b5b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|6133799003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: ROtlnoOxWL0+pWOqjmnsIoqmAqsAgHKc8w22oqohW8YBraKNBv+9HbxshdHH3NI3H2ncRdgTWnbnf6NwIEuaQU++plfRzD9d8dfJ+U0rrAglplWPUqIipHri7su/ah09EBSZCtFAPMaPSKL7WMpdwvyoZk2ZpASZsKwhXajhvtmOSc78N50fdR98mVStpcsNgpjR3hVIdmRaM8dt2aN7+cx5x/2Ha2yAVJ9os2fVBCtAZAJ5qZAl0Maqwmo9pA5WT4gQHgz0qoLusBdBAlBhEisFD6oe79uPnqYVviYBU4Ddp8KgMWzORhYzewJtD0F1kS61lnJDS7N8jlQG3MM9RDLSGjz4lkoQi103CsbOqWc3PN/i6c5GZ7ataOR1FwQquajXOR+9HANwX8kWWuXPVUBGYIOXtS+zNXqPF2i5j6iCg3d0FYYAKIzMD/dEP2YEsDuOPcqmx1/Nf3mqYBvclEN+jGilzxTsVY91fUzbbZnSC0pTVDQrzlQMagb52K3DG2cqAsKjlzHMywVdq9Qzmc6hoZjn6gL2tz+fUPnnMCgEJ1sOxlK1vMwROBj2m3C/Qb1k1rjaxLcty5QDFfMsWYZq1TKMhh4Sz2ywBouJWwtH30sHQ5TghLk2dcn3uOYVMCsOz6hxRHryg+vrEtNFznWne6fPZMZaLVjuWPgWsnHEjHqexBuKznyWaVK/PKjyXW2v994moMtUnAwtDVwUFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rDhv/HmsijU3N96MCHfoOM7Ax9VKrcZHCEZxZv9N4bpJAEem64bSeCuFHoF+nQLmTqvB5RNcA6e7+60Z3hYC3dBNA7FW5hLG1r2Lhe8mCABJKp+TnwLtH6Dk179WXwJQD8D98ts6sh/QB9CHBIKr6A/zHMhBs1G2qwnFbGfsMZtkiRzw5Xr4mAP4PPFcEZ7VmrYC5jO9Mn9ponJKK1yvujpHtbKZuj99fVpuXxMnMoh9NcvjRvfuLYXYYZu0/O7CNnugCmPluwyxGarMjx1z6J+fN+1rZRkbvlkvp7TysV9jmetkwloBXwwXfq6D7Ai/Le/W6bwKpweg2NrClZK7UaDaQ12Yv3LsufKbj5VrwxRjzOwRC028Tafk6ORt1Jfsti60bOhVbgm/A5mguhQJ6wMdXSzKZhXZb4voLEy871mX0HRcVZubB0Iya3X7O+Qs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:03.8560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a6845a-f215-4f60-cf6c-08df141b5b6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB435029
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHY]
The real connector fixture lacks atomic state callbacks required by
DRM connector initialization.

[HOW]
Install the DRM atomic connector duplicate and destroy state helpers
alongside the existing reset callback.

Assisted-by: Copilot:GPT-6-Astra
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 09eba15c2705..d37fe26eecea 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -4293,6 +4293,8 @@ static void dm_test_is_dp_sink_present_queries_link_service(struct kunit *test)
  */
 static const struct drm_connector_funcs dm_test_connector_funcs = {
 	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static struct amdgpu_dm_connector *dm_test_alloc_real_connector(struct kunit *test,
-- 
2.55.0

