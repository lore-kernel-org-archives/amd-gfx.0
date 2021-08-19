Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596A0C43214
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F1D610A1
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29F1D610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 334456E97B;
	Thu, 19 Aug 2021 13:38:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91B376E94F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 13:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIiMyjX4zln0iVEw5yBJ4dDp9U0/RD9QXJl5Zx2RHiX/xLaFSIGrhddh/BtGNkYtk5Z9SVU+E1PjWxTnTKxyrvRaae9dWHZw6KvjrsFcN8yAMw8tlibwao6Ff+uVFXEZOq6khg/SmFYm9JDOa/Cl+wK9HHX487IYKw4u/3SaAw/t24+T92pBl1dVjDt5UspnJ7UWOkswyU5eBBlzfZ8whdcgQyrLQQGjsbB/mLFUCQO0oNQ298O2iDIlMXQWcrMbqQkInrQ66gg7ZkSgtHHt41BW6rEhoz2NNOibRJONu1VjcYyUc3xlxPO4YUKHDsbMMfYj/BGIoJl7W010atCNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edOHqBVPFA1gFtidl0BQjYfK8LsLkvFrxJcVFMyX10Y=;
 b=ai1qNqI2THeNOl5+WCovSoL2bkvHzqPDjzBkouvOCHY0pAEWqbNmyqLom/Se+AhvU92DguB7Utd4O3W/BZ+2z5qKkYiSzaEvXHor/rzEwh8aOSepoq0I98vBzvktJG8IHA2B1W2JclTw2t8TzKIr5oNtTRTVMZkmn5b8kyxCtboPcJKFvuXEJvCnfefEU1+gmPU6R1lcijkE1PakynKSwXddLZa18mpg2p5c+Lq4HDABpZrpfM/WsgVBgslklBl8pSTtlmtD5QK3S5nzs0xfkagj9Py37AMDInxnBN5fcL01D1rKaRK/qc6NvBMA/otPeOhf9LqlTlQDfzsJWOItmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edOHqBVPFA1gFtidl0BQjYfK8LsLkvFrxJcVFMyX10Y=;
 b=GiV0yKm9PjSaWOgW/zeWYmDKZkq5gMk49fm9iNKstL7Yk6Zex5pZwUBIbKRJnfRbRedSaAOCV4vo0lomvGAqBN/LeXvU5poZInPyx/YaMo3OgoSvedAWZ0GimKFtbJXGlnGyP/YXEvOWZK7kQbhmMNGfzh9/k3G2AY6OSbO+IwE=
Received: from CO2PR04CA0173.namprd04.prod.outlook.com (2603:10b6:104:4::27)
 by MWHPR1201MB0128.namprd12.prod.outlook.com (2603:10b6:301:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 13:38:00 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::4e) by CO2PR04CA0173.outlook.office365.com
 (2603:10b6:104:4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 13:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:37:59 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 08:37:56 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH 17/18] Revert "drm/amdgpu: Remove verify_access shortcut for
 KFD BOs"
Date: Thu, 19 Aug 2021 09:37:12 -0400
Message-ID: <20210819133713.4168-18-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210819133713.4168-1-david.yatsin@amd.com>
References: <20210819133713.4168-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e060e81a-e9ea-4b6b-cf22-08d963168fba
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0128:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01281FE94B6BF40E47DE1E1095C09@MWHPR1201MB0128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y4lihARbNoKN0m7WtqObrlIX/9/7S574JSgBqLoGHXf6wQIDgSsgsrf4jvb/eD57m3ZfXllHtAI5P6eWeCcDpv8Ly6TIxgL+0x1m3mLVjA7FnBqVu+cQhO81e5x2tGOYfPFEEjV85bwrMhNw+G20I1ACeVv/tCh0oN633QRprRsviXgNIchFAypq54+T7oQ6js/Snvxa51xQXIqHMUOJ9Lq0v1Gnc+nSL8e+8GE5/91n/UMTUXFZTzqeP99yYpLgxuYKC257tG7tMiBbnuwI0sg2CdUAoiONOo3ZshvGSTuNrw+4DCn3Uf9SAgtsynCKU85Ay+44k3uTlOTSSvWeerkI26ocgNZV12+Cm94py7MBDSipBTjQ7HytElNC9+yCsIc8Bv7uVQ9hiI7m42CfFAvsQAlPN2jsDNCbiFsz6fzrGME4Xpyz9iQScUh2zOfjOM29utER5yo82tQQOe7YFQp/wTkUqsEdOmkr7kep26dEdv86T6vN6WBtM77gKDXAGS1gm3LS+c/pLc3tOCb9IkY3TnkrYCRCIf8+Pza2xKR2dke7tr3i8M894smE8sNu0YNOPN76anJHIz39hedbTtooGvyi/Gmr6E2JPke+WJ5S1tOQ6InTZ9yUVAuLki63OAoYQPKt9lztSFucHYpWoXAkUpfNxMwXUdC8c6Q2/QRjxV3keVj4IvE5ukdhb2EWMmWrGaONM/X4BReS7SBeZszmbJoWKISr1rz3ZZcqo7FefYpgR84E5ej0V87is1IbUgbqGsnJ1T8HYBFhWicaRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(36840700001)(46966006)(81166007)(4326008)(47076005)(82740400003)(356005)(7696005)(8936002)(478600001)(426003)(336012)(2616005)(26005)(8676002)(70206006)(16526019)(186003)(82310400003)(34020700004)(70586007)(83380400001)(36756003)(2906002)(5660300002)(316002)(36860700001)(86362001)(6666004)(54906003)(1076003)(15650500001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:37:59.9871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e060e81a-e9ea-4b6b-cf22-08d963168fba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0128
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

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

This reverts commit 12ebe2b9df192a2a8580cd9ee3e9940c116913c8.

This is just a temporary work around and will be dropped later.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 99ea29fd12bd..be7eb85af066 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -178,6 +178,13 @@ static int amdgpu_verify_access(struct ttm_buffer_object *bo, struct file *filp)
 {
 	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
 
+	/*
+	 * Don't verify access for KFD BOs. They don't have a GEM
+	 * object associated with them.
+	 */
+	if (abo->kfd_bo)
+		return 0;
+
 	if (amdgpu_ttm_tt_get_usermm(bo->ttm))
 		return -EPERM;
 	return drm_vma_node_verify_access(&abo->tbo.base.vma_node,
-- 
2.17.1

