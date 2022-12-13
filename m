Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1211C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Dec 2022 04:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6ABE10E1A6;
	Tue, 13 Dec 2022 04:16:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DBC710E1A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Dec 2022 04:16:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj23JL19HKhDDb1BN9lg5Hfved9fAWO0cYE0sOp6G8eTpo0fuefZZx6jBlm8RgW2rE2VNpw/OzuwGiofb1SYtoojpa2hnIZ/13fsP54+jeQcYJNHNOUIwr11da6fbyZ2XUOq9PAByny4QEdgTJGVK8AeT8/34OS/QX+onO0L48eswi3/sZPxonrV9ZR5uDWy4buXBaeBqNDVn1JTiLNgWTCIeJCSSOKLNKCETEsPlDZYaDLcUaUXbUIviYu3jpItzdh2FZ59r9rPIDALXp9xRMbcSG47Z66myfEU3eyq/kY8FdzkONegwWrqiQdqlNvOPGt20XE3QFYSJRsbfBSw8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ns0oG4nKKs59YXAmakOEStuzTpajN1wMtmYRkSL01e0=;
 b=bsYeotX5KQnw0Fw4FvbKqkTEr/6saBYk2/CV35dbdJevOyYOpPBFJCw8i3BBVUaQMRgpKAL5JYrqUv/oNG+R1auRLyrLE0JCfLyP5bH926l4YIAHectUyUvlQqiBRvALByhdh8AUx+EQfypziimb1gfKk3yx/BlWJyD4VIzbNprfIs0B8SgLnSjEdFAgtiaDkyjv0eQj4dfjwV+ltUtl7XSqpWhQZ45klyitFGDApO96h1Ta6qIYq3voP9HiQdlBm0wO9txD+9KTYRQ3+713DOnLdaP9ZWhPrgbOA2sQSJntywA08vKpUS9//efhYBwZ2cCyHX+ZPEyH13CS2FN5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ns0oG4nKKs59YXAmakOEStuzTpajN1wMtmYRkSL01e0=;
 b=IRaln/r8UVBouAvHO7p4OJYHmzQpU2r0ejCQkLA7JxhX2NHBzMQXDAdPSA9mNY3JQvEWvSpIl9OKgg2wNt7uXSvQuiHE9Mh7FzIKIMEbd5qeulP5Te+7O5OHMj58PV5PA0zVb0X75o1YHoVpNYS/3B4ha0LAHz6hVRn96QXu3e8=
Received: from DM6PR14CA0048.namprd14.prod.outlook.com (2603:10b6:5:18f::25)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 04:16:38 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::4b) by DM6PR14CA0048.outlook.office365.com
 (2603:10b6:5:18f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Tue, 13 Dec 2022 04:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.21 via Frontend Transport; Tue, 13 Dec 2022 04:16:37 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 12 Dec
 2022 22:16:34 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: Fix size validation for non-exclusive domains
 (v3)
Date: Mon, 12 Dec 2022 23:16:19 -0500
Message-ID: <20221213041619.126603-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.39.0.rc2
In-Reply-To: <a9aff70e-591a-35ee-fd06-02a452be8886@amd.com>
References: <a9aff70e-591a-35ee-fd06-02a452be8886@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|SA3PR12MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: a5cb4234-814e-439f-da1e-08dadcc0d43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dXmUoPp328ReFDXn+6J458ur1JMj3+7+q7dQnIZSRdd6SIdwXEsnWbUu20iLZiGDNJXD89MB/GmrWT6SD/T8gVIXaSB0g2N5fodCRzYjks/xirzaLbNB6I8k61iFUMZp6CnQ3Z5Z17pCfs6qEYxHii0kjlEPKEnhufG4HbkMKcUfiKksA9GOrrIxrCEc3FwnreySWnhUZ2GzF2S9YxAc3QLO5NP+YgYuUSeGA5ka0cVN2/K0YKPN5tBaJxI+adYqyRRKSerrx0SpdVOl7ys8w+aUrRpUTBnqtCFurT0cixFa2A1rriKO8j7JV5FGOS6IsfaaLRwRjR98leH09cAuCQT3OXdwxGBTKjPSxjuogfqMd930fk04mWVg574dGh0P1zkx+8cUjC51SJ/6CIid8BublFw+Yi/BOopCU0zrUKnzMfon+C54nc1HVDKewntvBJqjv7n7n4S6YnnlJZiprCyv8i7MAQpZJbxOZtxJhPFRgnub7NjJR4S1Xh76huUssNTQePzl3VLvr71RYkcnNEyNfg1FOcngTX2biCJwudhvJwElUelM3Ku3qkdAmBquIBQBQwedzZErULnLQEke98nQnHvtIbU4NZa6bDchESzliR0b7ZhrybEAarFzsxTNh0YajRnak2si2iRH+8mYBIG37UC1K5WIzjov3rLKzvPoT6DEFkkgzRlRA3l2dD/Pb1dPiCUMGzJSZC50F7fcRLLXHJI2cvA3shWdJ1wOfHw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(44832011)(186003)(36756003)(86362001)(2906002)(47076005)(66574015)(1076003)(426003)(6916009)(83380400001)(16526019)(54906003)(336012)(2616005)(40460700003)(70586007)(36860700001)(40480700001)(5660300002)(8936002)(70206006)(4326008)(316002)(8676002)(26005)(356005)(81166007)(478600001)(6666004)(41300700001)(82740400003)(82310400005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 04:16:37.8441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cb4234-814e-439f-da1e-08dadcc0d43e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix amdgpu_bo_validate_size() to check whether the TTM domain manager for the
requested memory exists, else we get a kernel oops when dereferencing "man".

v2: Make the patch standalone, i.e. not dependent on local patches.
v3: Preserve old behaviour and just check that the manager pointer is not
    NULL.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index fd3ab4b5e5bb1f..43b01f8287ea52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -448,12 +448,12 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 
 	/*
 	 * If GTT is part of requested domains the check must succeed to
-	 * allow fall back to GTT
+	 * allow fall back to GTT.
 	 */
 	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
 		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
 
-		if (size < man->size)
+		if (man && size < man->size)
 			return true;
 		else
 			goto fail;
@@ -462,13 +462,12 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
 		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
 
-		if (size < man->size)
+		if (man && size < man->size)
 			return true;
 		else
 			goto fail;
 	}
 
-
 	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
 	return true;
 

base-commit: 814a56e6601ce866638d4ef005f099119bee39e8
-- 
2.39.0.rc2

