Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE97C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Dec 2022 17:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AC8289453;
	Mon, 12 Dec 2022 17:48:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8B210E23B
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Dec 2022 17:48:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZCsbNZLDK8LM2wvrtC7d3xvqulZqaAzOS4aCHF2cUEzCotuzebYPCXpxIG7vcx8Uaw8tHpTDDyBfWtvos0OqU46L/Cu41C0rqVK2CVJ0KzucezQyd32M9jIZZfW88Z/IVoqWlUtCbMUY1o4AzreL4In0QPtoWYgw0Qe5m7ElSM5s1K+8KnqxQBV5NS/NIvuW1j1fe9MeWIHYbST17FDbl17tqnC48BpPuY47UtJdZjkeolGkgpK3OdBU+24l1LicfZR0sP3H2kkMd407OsY4Iqo8SOXQj3lEZTuVMu6ueA+MiLmj8X3ebEVJB/OURHmzjPQWVTqK2RLkRcle2z8dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6XOOeY++Wyy8qyNmofr6iPqdC+esmBVyBA99W6oF9s=;
 b=ABhvZGgh+d8pl6lkvHSn3/5mofE+d35a23SsRnlkrrXnW8MPA6KJWmn7XMXKh8R4vli8PapS8c6siWvPB9QQQyH9DmfIDHI3f541IFGuubeZLwRIOOEL665n9kkX8qg+t0aCvhRWUa8SJkdtdVypf2Oqr1c0rYpuOkMoi45H8DKungEdBgX8rqwgEw64oVZdQWuN7yqeSW0hsrm0u3z7YShkjOzw5M86Y+s6q7CKvdpPZpOlcs1IAZhVqLbmXm5t3NOizrn5y8S7HpBDQnbZSZDoh6vw5mKfzL4G565k5RvntMZZCrHRj0TVAR+xg9l/JC0nsUxsoOw0q8ykxt1ktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6XOOeY++Wyy8qyNmofr6iPqdC+esmBVyBA99W6oF9s=;
 b=XhsUjEtD5LsUAaBO4pu53cuNj+R9ryMjezTBjRJWw8nvDbFKBQxxBDiVEIF79tfygolPU4Bh8zZD6dlRdNAr4QkAFYccbys7jrrRgKj3djWsXzIbFplm78j58kZVnE7tCJKMkO5BFDjhj1InSLPz3XQ/GkUFkiNVN9bwd3avL/Y=
Received: from MW2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:907:1::17)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 17:48:54 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::93) by MW2PR16CA0040.outlook.office365.com
 (2603:10b6:907:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10 via Frontend
 Transport; Mon, 12 Dec 2022 17:48:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.21 via Frontend Transport; Mon, 12 Dec 2022 17:48:54 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 12 Dec 2022 11:48:47 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Fix size validation for non-exclusive domains
Date: Mon, 12 Dec 2022 12:48:34 -0500
Message-ID: <20221212174834.36544-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.39.0.rc2
In-Reply-To: <20221210092419.16548-1-luben.tuikov@amd.com>
References: <20221210092419.16548-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 900f62e7-0216-47f2-4600-08dadc692310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZV9uyR+Zmb0tgq2+GkKskVq2xtQWe+b9Gey1PRfq4inOhEFanWUJk0ARpVn7wJuL8k71PZCALBUoao56CJYm0bshouHuK2Nd8tVAXPxqG9I9TK5DCNSXk7lQMHR3JbUmtZtj6v9mkDMziHIJOJBnL119zIk2j/FKist/GxsNYFnEioSr1jmILQjQ2MLjBQtOVmkrv3JU6rJB+ys0xo6trOctetIFNr0jMMkFNGKr6Ip+esSwTua54aBtiNE1KxqzonDceBaCzQ+7+61xllpAQjPtmatyzRxtZV8x50V3QDEGC40MrxKOVbNCl/h4zFeWi+1ztMG5DhCWnT1YQlRbvtYPWG7tCyt/JzzYlL5Xz/W68fgd1CdJZzltzXC2ELAt/mQ0Ftm/N/QglhjoBM0QZhO9GE6Zzo3gWcYs9dCe6JkhjA7dBn9M7mGUC+D1noHnrXz2pcOBoLlFmkKMxnQ5B06v+Y88BOj+7O7Mty1sPfewpEuVM+5KNbCWVYbRkmoDQCYMXf02n7jKZykLw1zAb0m0FX0CxtAjSJSh7ABsRF9tg7rKcYwcgS5t3/MEbgSCtjvldqHgXfm4CgbZKgPzoTpyjZHy90cNFZpKB3R6sWX53S1j2TRVQqjJpyYX28iWqzUOHqLD1ouKqC+UFkhhTsUK/yYDvbttytunOKYRH8ykHuhs3SjbYwhi/t1pvrJgzjODSFCYCRnbqVsOWzW5JzoOUQQUPsgh6iLysq35hNA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(40470700004)(36840700001)(46966006)(8676002)(70206006)(36756003)(70586007)(5660300002)(81166007)(47076005)(4326008)(356005)(66574015)(426003)(82740400003)(86362001)(54906003)(6916009)(8936002)(41300700001)(44832011)(316002)(7696005)(82310400005)(6666004)(2906002)(478600001)(26005)(40480700001)(36860700001)(16526019)(2616005)(186003)(1076003)(336012)(40460700003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 17:48:54.1011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 900f62e7-0216-47f2-4600-08dadc692310
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
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
requested memory exists, and to allow for non-exclusive domain allocations, as
there would be if the domain is a mask, e.g. AMDGPU_GEM_DOMAIN_VRAM |
AMDGPU_GEM_DOMAIN_GTT.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index fd3ab4b5e5bb1f..e0f103f0ec2178 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -448,31 +448,26 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 
 	/*
 	 * If GTT is part of requested domains the check must succeed to
-	 * allow fall back to GTT
+	 * allow fall back to GTT.
+	 *
+	 * Note that allocations can request from either domain. For
+	 * this reason, check either in non-exclusive way, and if
+	 * neither satisfies, fail the validation.
 	 */
 	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
 		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
-
-		if (size < man->size)
+		if (man && size < man->size)
 			return true;
-		else
-			goto fail;
 	}
 
 	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
 		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
-
-		if (size < man->size)
+		if (man && size < man->size)
 			return true;
-		else
-			goto fail;
 	}
 
-
 	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
-	return true;
 
-fail:
 	DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size,
 		  man->size);
 	return false;

base-commit: 20e03e7f6e8efd42168db6d3fe044b804e0ede8f
-- 
2.39.0.rc2

