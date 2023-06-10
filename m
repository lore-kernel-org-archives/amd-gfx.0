Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D26C77B7A
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Jun 2023 11:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF92C10E184;
	Sat, 10 Jun 2023 11:36:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6DF10E184
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Jun 2023 11:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/FrhpufG4Z3o4AySRjmwLSKqKATHIbfzU0IORgpW11IeGsB5SCDap/pbIng0dtuSbFoKYn1KBpULSBevTuNbOwYTe65EfZlYJch4Jyg7SB/oSu2UCOKrRwlDy8jKRqt+fhmEoqWdkZM+yMlBOzELe11/1wE91elD8bO9gtwSYQMRRQcU+I4QFXYhf92i/pj+19ThDyC5icla7TOQ4GTR+eTFX3rK3KWqCNBh4k6A3wfW+AtkiRNs7w7jqIn12D2M1Bx5rRhQXFr7WZyd5SOPtsb51R3XBrpxIUqrakRLpkIUPztmqZav/+jhTdMC0pVfVKxEXTSrBs4PIjM94B0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eMzDa4BR4zZDkAlAZ4vr8o2ddoQFfltkNvIxJoTmlQ=;
 b=fmMm36d+sjm/9cp+ZjlQctkjA9M+e7ERaHbU2FnqdGZsvYI9jNTD5xKxz0LcReCfKz0MGIjsbQhaMZR4DhHT6rjF+s4oiv/k7TqAAIHSpSITohS3z4y5DxVhrU33s1Yv2tgxtgXg/wMxfBdcuf4ibsF6Vnw5Vg2yLBcUPOT1Q/lBcNpOvtsdWJR+P1BzrsdjjqBOWg3M3utzmn6rjR2rAXa16so9BRX2ELRUmOScSFar7HUQY78FpI1Da4vHT57cu06VsEmAPGkX07efBWv4K7EMbSQGdXzvBXCUXqo9REisPaTigKe2AfHuIOqH7u4c6ni2CDR4EwioTo/YahzBTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eMzDa4BR4zZDkAlAZ4vr8o2ddoQFfltkNvIxJoTmlQ=;
 b=bg5TH6OJ4ss50GAuj8VIU95ucLpGKAgMfsHKtMP0YrzqW5d2YbiUlLFbt5fdQrC+D6xukpEHX/3pnc8nildDQAJ7szSjZn0/FwfcrgRnNpIFkIpOUgRSYBRvSYGsDSuZfP4N7tIp4av7PetziELV3Fj8UPRD5sC4sM7aDtnEwiM=
Received: from CY5PR17CA0038.namprd17.prod.outlook.com (2603:10b6:930:12::14)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Sat, 10 Jun
 2023 11:35:58 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::6b) by CY5PR17CA0038.outlook.office365.com
 (2603:10b6:930:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.26 via Frontend
 Transport; Sat, 10 Jun 2023 11:35:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Sat, 10 Jun 2023 11:35:57 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 10 Jun
 2023 06:35:56 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix usage of UMC fill record in RAS
Date: Sat, 10 Jun 2023 07:35:36 -0400
Message-ID: <20230610113536.10621-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-check-string-leak: v1.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b58f35-fb58-4294-3784-08db69a6db9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0tGrXG7LjcTuIQDCWWu//9Y2LwDgD6dsoFwKf9u4kCRyiCFw60RjwvyEcQWRw/K7m2Xs2AaW6c1a1ptfVWHhYWgwP1Bnss9FdvlQ6I3dyUf6il2ycwheEPVdLZpsQSrU652mGzrIJboz/RYa9PjT/8JmywfVmpNiKUsIpGFbb4EFbeZgOgZfRMW/RzbP5BpCMvp4LIUJJy+adptabyOjeJCVeXlVXhZJRywU7FWOqrr5dJ1ZZVexgSu/ZQCVQcQ20/PkYm82GpbCQRRoA0sz1OE0hMgnHirFZqCl9xb/cLQky5jb8DWSCa5L8XehuovUCvVUiff4LYaQxnO62CF6Z5ydsNGqBn8Nfih/2KmIF81bwWvBdce96qpBs1n82AZqZczQVFOU06QN10k1QC7Y4VnT+DmnyeYKFcTlb+9wmQSqMAlnbSr7gnN0zd963rS3ayQDUT6yK8zkuVV3h0ktexBDyEJXXG3xJaJrlhuoG8OixYxW/ebH9IN5vGAuFXYuybfFZx9omXPqJvdG7ijIcMZZi5h8TTlMXw84ylEg3ibHjjCA80OKn1YAJNG42cPUEV6dxh2Jbh+qTyJ1mACRPaDoGd1plBVKMxQYJ2IjO0nOy+9HzMs086PTIX30ta1WvxcXiEdcSxq2dsPcdcF6mf0fYcf80ZwkvD0Ouek3pYSKdt0YNkCLzYrl+TP7Dn41t1T1cZ9HOx1SZxSZlSHi5rjQ/bogEnKAj7eWF5trF7wxuO6s3dG69lt4cGGenPcSkqcRXJ2egXuduKdBZYgYIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(8676002)(44832011)(2906002)(5660300002)(8936002)(41300700001)(316002)(6916009)(70206006)(70586007)(4326008)(54906003)(478600001)(7696005)(36756003)(6666004)(40460700003)(336012)(186003)(16526019)(86362001)(426003)(40480700001)(83380400001)(47076005)(82310400005)(2616005)(36860700001)(82740400003)(1076003)(26005)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 11:35:57.2030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b58f35-fb58-4294-3784-08db69a6db9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The fixed commit listed in the Fixes tag below, introduced a bug in
amdgpu_ras.c::amdgpu_reserve_page_direct(), in that when introducing the new
amdgpu_umc_fill_error_record() and internally in that new function the physical
address (argument "uint64_t retired_page"--wrong name) is right-shifted by
AMDGPU_GPU_PAGE_SHIFT. Thus, in amdgpu_reserve_page_direct() when we pass
"address" to that new function, we should NOT right-shift it, since this
results, erroneously, in the page address to be 0 for first
2^(2*AMDGPU_GPU_PAGE_SHIFT) memory addresses.

This commit fixes this bug.

Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Fixes: 400013b268cb66 ("drm/amdgpu: add umc_fill_error_record to make code more simple")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 27a32933cbee3b..700eb180ea60fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -171,8 +171,7 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 
 	memset(&err_rec, 0x0, sizeof(struct eeprom_table_record));
 	err_data.err_addr = &err_rec;
-	amdgpu_umc_fill_error_record(&err_data, address,
-			(address >> AMDGPU_GPU_PAGE_SHIFT), 0, 0);
+	amdgpu_umc_fill_error_record(&err_data, address, address, 0, 0);
 
 	if (amdgpu_bad_page_threshold != 0) {
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,

base-commit: 7eda4451177abbc8d2fab24f816a3243dd1808d8
prerequisite-patch-id: f2a3eadc5d7074225109701f1bb43b38bd6024fd
-- 
2.41.0

