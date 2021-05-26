Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A70C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 03:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA8361430
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 03:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA8361430
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC7C26EB71;
	Wed, 26 May 2021 03:11:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12FD36EB71
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 03:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxR7PFEioARA2/PTEm6E40YCr0sAhmrHQLcmTNy6i1wBVnTFILP+8W4iW+N+Yam6NafJ2pdiFLtsqZZ395TLGx4/W1egF/FD+eFkPsxO2UWUIzPp2J1ruZnVHDuOlyuSRZDwDNcEBY4Xw/q5Ll025PZwF9Xx2QFR9t3BmY9SR1HYP4fHPAgMF3IMZlTbu6byBFTtIlTJXP8KJ8Y27EM0K6u6tt8RrWygcmstFKrilP18i5Vjv4yZ1FN6CLsa3MQzTkX0nbov31aNAH+k01fqKJew6lT5cIQRU0srVNyalG2aOe5VEwforG9G3Gtshst7W1tHwMQiQ1P3EnTcmd0UVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEvLRypGHzJQyhxacJBnhiBx5un8TeFq1I6CEZd4E7c=;
 b=JE8IbqbHLLqyhLPIRq04quwS1RNSpoYLz2YkNish+etrBSPjRo2/Ip+4KdSdPsnRf0eliDgIfeCeyIoq10leXYfnormAFJ/mEb097T4mV249q3XtPgM6yiGX8dCHfNies0WdritUhqNLd8Xi7LSBh69oMwDKXRGyA9g4BmjuDHCOZZd86MqC89JJIS1aiUWTx1bLqvW1/MFoAktyFW+WMbpDeYY57g1BfsUvsLH4mBF/Q6Y9FMR4SInBDqKBqmcwb6pFSzTgHJcHXAcD/zEZ2xxgfXpycwKgYu0F5Usj4aXPun/lDoKOB3qfDMlPdZ+Pt24P+L53Cv+bKqZdat2nFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEvLRypGHzJQyhxacJBnhiBx5un8TeFq1I6CEZd4E7c=;
 b=sxs/SDx8WmCxaDmLrLYOPsIoP229zmLzF83sQ46JwUfjcKe8n8pWD4v4XLr5hl/6YTH1eN3m5v6zLFm3K+HPLWjt7u2toqFjW9V5Fa/aCCu+xD9dqLlIgmdx08/c8+pJ3oDw2nDMHClfaWKIRcCMSH5s9aeROuVzuWoE8tC+PQY=
Received: from BN9PR03CA0798.namprd03.prod.outlook.com (2603:10b6:408:13f::23)
 by BY5PR12MB3843.namprd12.prod.outlook.com (2603:10b6:a03:1a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 03:11:10 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::e6) by BN9PR03CA0798.outlook.office365.com
 (2603:10b6:408:13f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend
 Transport; Wed, 26 May 2021 03:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 26 May 2021 03:11:09 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 25 May
 2021 22:11:08 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nirmoy.das@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix metadata_size for ubo ioctl queries
Date: Wed, 26 May 2021 11:10:54 +0800
Message-ID: <20210526031054.1122-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 023e4c43-c19f-4667-6d86-08d91ff3e91b
X-MS-TrafficTypeDiagnostic: BY5PR12MB3843:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3843EA0AB7A4EA98664985CEF9249@BY5PR12MB3843.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oxg3UByNUcMeXYl285YMBrlfIY4/q0veRMqdk3iAYTlSIw4AwP5EALbxY4zeAoczXL2RaDEJWEota9AEIxh3kxVi795Yr/1O2rBRbQ/wJ1VqsTs/u/6oq1fEOYU4ViD9BwH0iyprn4LBi8Udv9Xo0NaGMz8Zo8cVd3S68zwu3FY658ayLMHTc+tj9Nt3/DMbstRvkTkXltcW70O6BNs6dolN7CdHY7JlbWzeqxWYeArssajTekJUh0WDALhD32pa3aWP9FpQ9bkInZ1pDXrPZXtvwiGNayxxwxodqSJznyJcYepl3Lke8tPtc/XzHlU1INixbLldH3kxplI/AZNCmLpg6cH11F7Xt9MWzN1VLVemUFY53IvpTd0XG90byIW0hNj6bnhFJC5GufDEFpf9oDQlWohLs5rR4BAgAa983QSR3xss6g1a2GYdn9sjWFjTHkWyz1Wtory5b3vi61MkaZj0XK00z3v1rN4t+CsWffs5MAcZhqGfhNqdcV3DbyU8jwkJ7bpkh1jzhyifus9wBxehRtiCSCP4ZyipiY5E6G5ZxF21wRMgUJHcMhxIS5oCoeF/o7nytBFujXMzY2h3K0q2VqFqLB1PwokyS8dGfiDEJiNqJDaxJdBY2Awni63hZP8Wb4BOdUqZgg+aOPaIpxVi5SpDNUbASXehl+BxuxkmwwKDmzvVMCTFPIwRnPEh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966006)(36840700001)(2906002)(5660300002)(1076003)(44832011)(6636002)(478600001)(426003)(86362001)(316002)(2616005)(8676002)(82310400003)(336012)(6666004)(83380400001)(47076005)(7696005)(36756003)(82740400003)(110136005)(16526019)(186003)(8936002)(356005)(70586007)(70206006)(81166007)(36860700001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 03:11:09.7359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 023e4c43-c19f-4667-6d86-08d91ff3e91b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3843
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Although the kfd_ioctl_get_dmabuf_info() still fail it will indicate
the caller right metadat_size useful for the same kfd ioctl next time.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 3f85ba8222ef..2d876e1eaa7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1213,6 +1213,9 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
 
 	BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
 	ubo = to_amdgpu_bo_user(bo);
+	if (metadata_size)
+		*metadata_size = ubo->metadata_size;
+
 	if (buffer) {
 		if (buffer_size < ubo->metadata_size)
 			return -EINVAL;
@@ -1221,8 +1224,6 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
 			memcpy(buffer, ubo->metadata, ubo->metadata_size);
 	}
 
-	if (metadata_size)
-		*metadata_size = ubo->metadata_size;
 	if (flags)
 		*flags = ubo->metadata_flags;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
