Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96687C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7FBF10F899;
	Fri, 29 Apr 2022 18:02:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E43610F891
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXaWlWkSJnmP11mJMnU6ng4tFcaVqq2cU5UXZaR+7KTeWmDXJHW3Cm9wXy3VHra/2bg4RFmCFUVr015zfyqCeCBIc2fbfqqYkuO8haWE5VbAXG99qhSXh2em2DhBZf+kxDBSo14neu7UzrHCOOK+FssGJZ4aBywn24bAOSbZdRE64ItfeuWao8NhGYs3+2go8HHtmTQuCuT2cuZ03D6jyZbcC/MTRXUYjiCKmkIh4RxEXtXfBw/RFmhFPoB8afj1eUZokV0nLjinfmjCcqI7jPLAoJFpYWujNNXZVVVTjb7yTs5DqFHL19Snrvg4+Jl1zVDiphNphsEqB8GvGlEUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU9jPpz9VHs/5uoz+iLnGmhbaG0dlF5/tI+ef9R8f7o=;
 b=SgeM8RowJ2h8W8co52eZlkvM6bnAofgjCwHV2f+UNV7YEVWAqiwUtv/08Z+ZAmwv395f9s307BlAfipeV8Qc31e07n3QMHsLaUrN+99eMo+1CRh5cNfIKfRetZwXlbRsIxmJzbJexo590/LpM0rfF4rQ3X2RT1WaC1lxQXnGxMwG5tiB7hTo4p8YjphYBT1AyNTL5giBxbD8hzoQ7/YkG4g+NP4vl9EP1mUxhd5MdurZdiOVpLXdekNogImMB/jIojUzt2VU9euxMSlAbgQJ/VLzFu5wfLXqXonq0XTrSqjc5QEoUeuflfHP1j0skbmhc4Ofl1Zsst5yt1r25qukLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU9jPpz9VHs/5uoz+iLnGmhbaG0dlF5/tI+ef9R8f7o=;
 b=2E1/ne0985FsF43eINSd5Jr4syQJuuYAkU1RBMwpDhsmcwIhuDPcdNLxgNw/GdVK0TpBHOKQNrp9xgDN+d4Vdl73UFJvK/QV4xQ26/15dgUq6Z4FojSAs7r5QexuNNzEKycMaKEwxgBFhjksz3Qe+SJm3X2xZ11e+BIToIGWDE4=
Received: from MW2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:907::16) by
 BY5PR12MB3762.namprd12.prod.outlook.com (2603:10b6:a03:196::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 18:02:53 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::28) by MW2PR16CA0003.outlook.office365.com
 (2603:10b6:907::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/29] drm/amdgpu: enable GFX CGCG/CGLS for GC11.0.0
Date: Fri, 29 Apr 2022 14:02:20 -0400
Message-ID: <20220429180226.536084-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 253e7804-8042-4c2d-bdee-08da2a0a7b36
X-MS-TrafficTypeDiagnostic: BY5PR12MB3762:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB376251524B80B34FD9CD1A01F7FC9@BY5PR12MB3762.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZyU/BBZUrB1zt9mNEse3J+Guirie12CFUd0/9G1sU0BxSnGyai/ryD9N7seFaAUCGOBWHPM98zIH4oCAOW8dSEgSoF8+627pKUiCeARIlALtX20RShhwbSDriSRawKUX2b9K2oakN70kLWr7jFGe1TEGZS2/mPuJjOpL55UWrS3G9fCHzOHO4Bwqsy5f99WHQuZSmDP+XEj3XmsnoTpEUWvqa2peZO44GeyusolxLFyZuU2SLIlRSvFx9JvdXa/YGX1vLxmZj+KQOeHfEA1/2Dw8nFo78mUbDwo2CBzPw36+63ESvhsIXZj9HCo7Ln2Xpmz4b/AVQUjzI0hbGdP8bdFwGchxU1tbjyB/7eBhLE92ZAApc6S9f+pVuSKxKHzCh5IyIsDIZszN4x12oTlnFKeuXfhzIguRONUJVh3X1rF3T/upkwkWbNcbb+pjLjLfoDe3G9vZT2gs/fwHeKgZ9zOiSaKAKQIgVYJL8qw6WGcvZASlqDmWrh2TBbTZ4fklO8zW9dbl5H3YqQGVRkQKd4D48d1ObW27rGNuzJ+As2Eqlrsw8UQHbHiCMMNVcL7XBpNXhVHSyABO9YbXabvBETdXigsOwKMuzn8dsXJ1IE1oU/O0aesbmxUqn118lVGXsRxRJppyCM2pYXo6HtZb8R6tsiqn44AghrybPDgqSO3lAlLHeNX0t7bwQmprUFG0FBCkXrvyepGu3OgM3hWtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(26005)(2906002)(1076003)(83380400001)(16526019)(426003)(47076005)(336012)(6666004)(186003)(2616005)(7696005)(81166007)(70586007)(8936002)(36860700001)(70206006)(8676002)(4326008)(6916009)(82310400005)(54906003)(40460700003)(316002)(86362001)(508600001)(5660300002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:52.9696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 253e7804-8042-4c2d-bdee-08da2a0a7b36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3762
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Enable GFX CGCG (coarse grained clockgating) and
CGLS (coarse grained light sleep) for GC11.0.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 80b558f649e0..dc200d11fcca 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -480,7 +480,8 @@ static int soc21_common_early_init(void *handle)
 	adev->external_rev_id = 0xff;
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
-		adev->cg_flags = 0;
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS;
 		adev->pg_flags = AMD_PG_SUPPORT_ATHUB |
 			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x1; // TODO: need update
-- 
2.35.1

