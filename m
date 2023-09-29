Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85312E728D6
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 18:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8859710E1B7;
	Fri, 29 Sep 2023 18:19:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15EB510E172
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 18:19:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiNanOyqP+Hry1K/tgGj2t3v2nIjDzmiP+5/00RsoGvgUtJ46NN2ZJnTAYM4h6xpR/dPpQXyx3KEmyQ2BeXBbzRJlRFNjSNQK6WlgDWwxW2kApifWmO3fqU68Q/b9E9uue0e/ox7BSJLlTY01NNeDVs3EBHOhkNpzKe8BU8q4Kw5JeonAaDEJefgj/43darn7EmotQXNB7O2wwgSBhLbeUITvkc9IedKOoLwfOZt3auRH4PM6wwaJkQ6dNv3/G002lj2Sa7OCYvcf+wsVTGV/hWqPYWrP65J5phQgo9WlYXyUHZZpZWf1zAy/bVq/yqhBHPdtFgrjv4dKKoQiuovNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGNAvR/y7Uk9isETnrDUASG5XDJ6t0OTkG7SmtPCyFY=;
 b=b3L7y3RxZiGim/itwGmAEa/qe53IRKsnVlbmn52K4Puvmm4LYwKoTsaulgtg8l2lFZ+3I3VskVoGBfllLiMBFT+iEA5XqC4fXxG0DEIZkxvF5SH3JxeQPyZB0SZoKdHCrqk6zllOzVjEZ0B6ndu6SgY65Ao6wIgqee9fRAsgoY6PFwNw/lVYXiT80njLR/pLf/dlTwwcLWDmxSkpDNv4afSni6047ScpqwcdCn2Lnfovx89tAKOojE5zo2+SDBrBbxNpa+zPk1nhGiJpB+VGCP3EEVXEBuKLYdpW/0ZxUXo8wJHsig1AXYEj+DM4e6PJtV+mNYEwplSxsZdJjFnvgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGNAvR/y7Uk9isETnrDUASG5XDJ6t0OTkG7SmtPCyFY=;
 b=npE0a1746MAYCNu6JFVxDqe9q6IxtYImj1iYAF5SXBFxna72kg6r83oOOh2O9pkghdAcKnmETW3roNO5APnJs4gc9U9WauSnhsU5DLIaSyEfx+yQkC2WqxrLTpDxb9NcNVKVdA9RK2Ts1mStJ3RIWoXUv/phR9Q7JzTnK2uvC7Y=
Received: from MW4PR04CA0067.namprd04.prod.outlook.com (2603:10b6:303:6b::12)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 29 Sep
 2023 18:19:12 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::9) by MW4PR04CA0067.outlook.office365.com
 (2603:10b6:303:6b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26 via Frontend
 Transport; Fri, 29 Sep 2023 18:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 29 Sep 2023 18:19:11 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 13:19:10 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Initialize acpi mem ranges after TTM
Date: Fri, 29 Sep 2023 14:18:55 -0400
Message-ID: <20230929181856.2311515-2-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929181856.2311515-1-rajneesh.bhardwaj@amd.com>
References: <20230929181856.2311515-1-rajneesh.bhardwaj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: c56954ff-a231-44e1-7ce4-08dbc11894b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJz0T3c3bmFk+Id+KyWzXlJ32M4yaPX2jMq0EKso6fCu0s6zRm3ccwe70H/10yuCXIxCD0g+3hNHW/OzlPtrDPyUSYuhobbd27LnlkhMwVCBOFJKOgFKnhHKkEQh52ONRkJp+xkXw6vKTkxjRutaQcEcpyTnn3060tEaULFJbsNRWFcyTAAVKvp6Yv0zsbRpmKE0aqqk9xklpBbcjqoeoYMj4XD2ITil2hrPewtGf/3vtjRAqD58WA/96GOrCipauP7EO9VJQRhOG0DYIAEXYKmSEDtTTfMh8vEr4qUwy4DlPI14mYOvK64JeLfvq1o8xflDtZ2tnEKBxAmToiWYy9dbVKBH2PfEY+Mf4fGCB8fEGHvwGMS5GF4gCTE8kzwBm+BBp6RXBGn2cRw+HB2l3iXHQ321NQG2wL+BAqbGUIYotgl6rpYXVXWhGVZVyPb1IxHix1jB92G1fv9P99NP+r4728Mw2CD7XM7oOtqaFw/SEQ7pflUDgjN6fjBmNQ9/YssHRdViwOaminUCF9HnAl2/kIy6LnMYxGAkmUpUmiKdvz//R8zlbx161AFHy6vvVSDfdTVOOL1+ie+Rsm9lm34BbmkLU4oRe7Q7i9Fb7fi5UuX88wh33vMJSCb8Cf45tM/Jt0zDEME/8uUB0oRUb4ta5wRvnA4pP4hwLzYrj0zblEbn70LcNS75fR2Pic7bdqhQalzOdwFQ9IWlMhqTu4Fj8z6SaHIQdIzKTUoNHMDLxTkvFzDVR8FXVc6Jk7f2gD8b1Z7lJWwPh9jTBBZnqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(83380400001)(40460700003)(7696005)(2616005)(336012)(82740400003)(356005)(44832011)(16526019)(2906002)(5660300002)(36756003)(8936002)(316002)(41300700001)(6916009)(54906003)(4326008)(47076005)(70586007)(26005)(36860700001)(426003)(70206006)(86362001)(6666004)(8676002)(478600001)(81166007)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:19:11.9686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c56954ff-a231-44e1-7ce4-08dbc11894b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
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
Cc: philip.yang@amd.com, Felix Kuehling <Felix.Kuehling@amd.com>,
 lijo.lazar@amd.com, christian.koenig@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move ttm init before acpi mem range init so we can use ttm_pages_limit
to override vram size for GFXIP 9.4.3. The vram size override change
will be introduced in a future commit.

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 268ee533e7c1..005ea719d2fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2190,17 +2190,17 @@ static int gmc_v9_0_sw_init(void *handle)
 
 	amdgpu_gmc_get_vbios_allocations(adev);
 
+	/* Memory manager */
+	r = amdgpu_bo_init(adev);
+	if (r)
+		return r;
+
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3)) {
 		r = gmc_v9_0_init_mem_ranges(adev);
 		if (r)
 			return r;
 	}
 
-	/* Memory manager */
-	r = amdgpu_bo_init(adev);
-	if (r)
-		return r;
-
 	r = gmc_v9_0_gart_init(adev);
 	if (r)
 		return r;
-- 
2.34.1

