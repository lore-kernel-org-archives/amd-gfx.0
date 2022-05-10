Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D1FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 13:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48EA110F10B;
	Tue, 10 May 2022 13:52:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED60610F10E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 13:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4prm5Bd0LendDaWpQmYhlBfChEdNCbA5EUPwrtYW76xbZO1XXh4KqTPJUHy/mfwytB/7TpVt8WvpVIK8CgHLXuKJsiIgs+ID2Qb3kayy+WH8XADCVIIS20LMDt8qAPlbRIJ7Uf4ODxc838+5RTu3hxgZjE0Q2B15jSRadsJBqMT9Pt7dnIQcD+dwF0zrXKBP8Bzs8oVEUGyguO1sK4TyycFKaVlH3JjFmVxXM76w/4agJ/EqBHKm3ElVTDy23jol6H45IFr939lVU2PWJ15fR4giL9/IvF5OIGQlcL+ZJ9SDdgg11nb44kIUEqB+oGbawMupfLNGdAv3jjy89HShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7FvWfosJyYkgg0H8UBvnS4wBYVySCSBdeGPrRyGdHk=;
 b=oKijzp40HwzQnIgIv7TEG5EqvNeFDiWNblcpEsD8kL1T/45nBAQQpanC+F4LnC1H8R06+LMknzoPXCn6XpOZJ9HoFz/kGTfc4PvAH7LDzxCM9AAmD/BVITyqP1WArTA/S2lsHvb5x0fZZwokMRdyTq5C8aT0/adBMYjd5C/3S+1pt5lIJbgtbJKu4jCdpTDq5kw50/Ys0I4P3TvGU/7eAoskkHCXda3UkCsS08yyGsA5fVgbvsiGO79QBtFysnpm+CsllPXL4hHcRS55lESqY6RTJd6Zv+Nlj5WbRaqKRgxF3XNk6qIGe1OxgiZJTVwdyP6NHMlh2wzLmd3rilOV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7FvWfosJyYkgg0H8UBvnS4wBYVySCSBdeGPrRyGdHk=;
 b=JrTAHkmYlBugRyaIwKnEEvGyvOqffrPkKYCmhRbDVEeSACz0xhZ8t1JpxQ4R4n66bpEilMjThckyZUfjuwVc9EQj2Z2D1zerMmYOfC+v16335aieWTN1B/eGiMVapzg+TMs8zSOWQlT7VYHLZHws1eO5DYk+igjzYbCSFZt83hw=
Received: from BN8PR04CA0033.namprd04.prod.outlook.com (2603:10b6:408:70::46)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 13:52:14 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::a8) by BN8PR04CA0033.outlook.office365.com
 (2603:10b6:408:70::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Tue, 10 May 2022 13:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 13:52:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 08:52:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amd/pm: keep the BACO feature enabled for suspend"
Date: Tue, 10 May 2022 09:51:44 -0400
Message-ID: <20220510135144.551692-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5256234f-ae63-4e9f-a7f2-08da328c4992
X-MS-TrafficTypeDiagnostic: BY5PR12MB4226:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4226B176ADD8E53EE0B35285F7C99@BY5PR12MB4226.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Em9dC4IQ8BfdMmHFod3F1v/pNwSRfBKAxvqfxSxlDmaXAONClBMF6Hx+1HItiV9/JfeNq+JyLMaDLftc3iU8yYkd92vOL1FeVS1pKFbESh42kqP35x2vmIwg1nRoElDQspc4olEawzbwwyYTZyehFN/7KUwH/eKLLjr3LQiDBJzvSCIV21p0z8M5DB8HjiArrk6Q5IQH47ht1F/UwZkWF8Dz8SD31fNgmr2E7IwYt+juMOfOVZhDJuST1Y0v2/Cc4o3Y8dLx+FcTTuOlKMULuvLpRqMC3MUYJKg1fIJ3RdC0tqVbbt5J9Y5aYqvzOS7QzDqZLAzL6eIQeXZ1aPbflGYuz9/vX+bQAK3bSWHzcrdXrAeS9aSpDG04tQvrUcIdZ8serGf+I/HoD6LjseMsYHRAppNQsj+g5YCjYbybAt+qbq+9xyAf0c1CkTZPOIgZbAbYkONpVnnzz21Qw5CZ6aDBQXxPjXCd8odsPG0FKKW8H2Ybw6QLZL/7D8iMGzV3xkQWo0l4fsyFurBISXAVWNcfb9sqlISQ8G3gVExmvb3iShbx9dJOAORRPDuCklofC38USK8XzXRJKAn4wUnksGhQK10PFA/yJkol7qhw9RwwJUKKXpHTw1wCZBYVnatoWNoFWfiDgqlQlmOw3AhYZw8Msl0ZRCdJTMx7d1m8XZ5SPK3Dg9DcvW+wMccRpH9KeVWIKb7r4SEi1EskM1Jjxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7696005)(6666004)(5660300002)(6916009)(26005)(36756003)(356005)(8936002)(16526019)(15650500001)(186003)(2906002)(47076005)(426003)(336012)(1076003)(82310400005)(83380400001)(508600001)(966005)(36860700001)(86362001)(70586007)(4326008)(70206006)(316002)(2616005)(81166007)(8676002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 13:52:13.6879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5256234f-ae63-4e9f-a7f2-08da328c4992
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit eaa090538e8d21801c6d5f94590c3799e6a528b5.

Commit ebc002e3ee78 ("drm/amdgpu: don't use BACO for reset in S3")
stops using BACO for reset during suspend, so it's no longer
necessary to leave BACO enabled during suspend.  This fixes
resume from suspend on the navy flounder dGPU in the ASUS ROG
Strix G513QY.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2008
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1982
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 395f266be690..956062496202 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1390,14 +1390,8 @@ static int smu_disable_dpms(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
-	/*
-	 * TODO: (adev->in_suspend && !adev->in_s0ix) is added to pair
-	 * the workaround which always reset the asic in suspend.
-	 * It's likely that workaround will be dropped in the future.
-	 * Then the change here should be dropped together.
-	 */
 	bool use_baco = !smu->is_apu &&
-		(((amdgpu_in_reset(adev) || (adev->in_suspend && !adev->in_s0ix)) &&
+		((amdgpu_in_reset(adev) &&
 		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
 		 ((adev->in_runpm || adev->in_s4) && amdgpu_asic_supports_baco(adev)));
 
-- 
2.35.1

