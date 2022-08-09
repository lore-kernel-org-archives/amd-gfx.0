Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA16C19F2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 07:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B6118DFD5;
	Tue,  9 Aug 2022 07:22:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB7AA12BF71
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 07:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJrtMVMtZQbxfpTpBmhQOFu+56kGQuzLsdkP15JQ4SDnthpIx3PB/4BemuSYeNQ4rfgfwh+S7zyYdtZ94MdBe91czQUQfPh/dxQuezIJFm640ytAdDqFSXLzYNxw3DqySMXjww1pcZqF4uH74DtFOwgEDrFsT9sSYoZLlk+a4fN3PWzXQewIjcGpaotU1fEMdQiitn3mkwP2nYhyt09JOZivsCJ/zBh7VlBHAu2c/vRuVTVkle1/kmMxoT+2DnA+ofav3wmfgbmbJ9u53mY1mFcHuyeA+jJrAh0ZNFevX1UaHRkmmRRAXdqtSxUUJ59XZo9T5dH0Sw/XhkhBcK6gnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5h2rZrdGNqVekaTeoGswfO4dzRn2+9ZM0wCJZi4KSj8=;
 b=UQCkpTFqLiwJ3hob+nJY06udaclHi5CwjtvTKzguv4AyeiAifN4ByZ4rZ5o9eiOS+r3l7S65dm4CEzMRd5fPeWPT8WI+5zuFPcBg+hkIsN0sgGDYPSds4IN+ZHW9lCatj4ruZqaRhIDyYaOQjPIX6oSF4sd2faQK/q4eZFjhFZVHvzQlYTfDqbqi16uO5dzI3A6Lhd4zzP38l2T9ybfFMwCHGi8J+Y39sqPmm028KgFI23SUhMHkpReec0Arzs5NhiTMO7nPe5uBo4V8kqUgk+rV2pZDONKIyAig+IpDbiW0zu4Wh0g7dAGbAoTqbSPyIsBwKBJEBQugKwiDFegX2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h2rZrdGNqVekaTeoGswfO4dzRn2+9ZM0wCJZi4KSj8=;
 b=j7AAZXy3SlNOHmv4TEFr+ddraLNJ/jSjgZDz9LEmVYU3H6xuepzlT5uOISwtJNZfnx77dQcO7x4VS1qNSh5kKL1tVg+descb2W/hGWHAKDdrfE/jKfsFyz+wL4NBOZI4KohGpTmbY4zCzWoH5GCrzBZQzbhgCQO6++om67QO5Uw=
Received: from BN9P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::6)
 by BN8PR12MB4788.namprd12.prod.outlook.com (2603:10b6:408:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 07:22:26 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::fa) by BN9P220CA0001.outlook.office365.com
 (2603:10b6:408:13e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Tue, 9 Aug 2022 07:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 07:22:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 9 Aug
 2022 02:22:24 -0500
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Tue, 9 Aug 2022 02:22:23 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: skip pptable override for smu_v13_0_7
Date: Tue, 9 Aug 2022 15:22:19 +0800
Message-ID: <20220809072219.436078-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03de4deb-20fa-4675-9690-08da79d7e8f8
X-MS-TrafficTypeDiagnostic: BN8PR12MB4788:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZkA/sZv1lgPP6hxqMBiGzv3OSN/TFP7WU7Ta9hw5/AkmF6wtm0Dcg0uTZpa8BermFDV7uBiCZdOJDJJxfZ19i+/CYt5NqMtzHeX/txlhl02Def3VXEsx/UZn/sKtmnjydclvahgTzJ44OdO0vb+KEwL0K5TtHRwWhCNDd4wdBmAz2oHaY7OWrlvznM8beASUMp1VPF6btmgteh/PcY7muADDPJFv4mITaE30Sr8Q6IyGtwAJBGzqmHRhBajcgF77PIVZwjnuWn3NuDTWmwrRxyLtK83h2lvLKemk1FVBguSlTsfxBsfw9mVm0LPwhUt7ulF80J5/H/ybQQyMxK7NrB/H5tl4ineEtp7abHbIijTGT6fPy6HIv0BVSKtWAOLaCi+/nhyoUDrOVTkpeUpBdPq7vvk+BMfGIiqCgESU9nyNpo9I2gviFF+MxrbSokElIsfURy3qnvyXEU8qj/hVqKoJxtmfzLOCIlxXkq5frv9sA8rheaIA3WW8TbPsDx7jbyWLjPz+z0Uvo3SadX98JjJgpUtNUnBcNJ0RCgPjBtDYiUq+D+HzoYXq0ISeesJM0VhNAisB62uuURoS9170R9yCG8Pd6Wq4jiLZiseaFI6F9DuTUtk4zdMkEYfv1kdCpcJ9AzJhmlEi62IjjNIqKI/9760iR3AS4PHMtpi9bugW4GSO1qKaSFmRsvcn+VKjLw8oRbqcqByUoJ/TFuu/Lr7RI9b8TN+weOcP1SgTFBEIbgiwgpl/YijBFCVyfw6qRNgK7IGah0eZ6NPz4yIF5fkMGz9+xQaXeHcKgNUTuZO16477VWgA2rpZ9467JdE9O3i1JJhY2TwCQfV34Y3OQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(40470700004)(36840700001)(46966006)(6916009)(316002)(478600001)(41300700001)(2906002)(82740400003)(40460700003)(40480700001)(82310400005)(4326008)(70586007)(70206006)(8676002)(5660300002)(44832011)(8936002)(36860700001)(81166007)(356005)(36756003)(86362001)(1076003)(186003)(2616005)(336012)(426003)(47076005)(7696005)(6666004)(26005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 07:22:25.9256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03de4deb-20fa-4675-9690-08da79d7e8f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4788
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

skip pptable override for smu_v13_0_7 secure boards only.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0370482dd52b..daf4dc9811af 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -212,6 +212,9 @@ int smu_v13_0_init_pptable_microcode(struct smu_context *smu)
 	if (!adev->scpm_enabled)
 		return 0;
 
+	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 7))
+		return 0;
+
 	/* override pptable_id from driver parameter */
 	if (amdgpu_smu_pptable_id >= 0) {
 		pptable_id = amdgpu_smu_pptable_id;
@@ -219,13 +222,6 @@ int smu_v13_0_init_pptable_microcode(struct smu_context *smu)
 	} else {
 		pptable_id = smu->smu_table.boot_values.pp_table_id;
 
-		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 7) &&
-			pptable_id == 3667)
-			pptable_id = 36671;
-
-		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 7) &&
-			pptable_id == 3688)
-			pptable_id = 36881;
 		/*
 		 * Temporary solution for SMU V13.0.0 with SCPM enabled:
 		 *   - use 36831 signed pptable when pp_table_id is 3683
-- 
2.25.1

