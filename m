Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017D7EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 05:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E7D10E028;
	Mon,  7 Aug 2023 05:11:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9DFE10E028
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 05:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeJFE/+RGngKLiT8/mPSQLTFcoO/MvoLHAq+vyF9IayMaxT50m0EDaBCjB/BR5RXvTCe1rAlEbfKizwzCBM85zUHcDU3u5YSrC793rQNh2Q3uzpFN4MXg98tUFgDkpRfsaKmC37YxOxWujhEk9lR/BjoZEnFLrNr2aaAbq7C6yozzah8putirf+CZtOabOJj05zHlEgHynzmw9vpJCbkkpG0jMBX19neeMLIQUzUuvC3pjybi2OyZ39JewSSGlnJXLm4h0KIj4z+6jGwXdyTy8yJKN+WHHTcEkLXX7IVwtfIehma2qf7JW6T3RpiyF6VGbE1WQ7wtS/zZvYyj0tvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnORAhwoE3V7N/IypFK550lZjvlN1tSiGIcfFdkg4VA=;
 b=EiwwwWEWdAOUBtnP2KYicdNhMRLIH23BnePuljLttVMnSKiLNCSbkHS2wzVKH2NiqBKdfHJZYWA4rBQE5G97XzQB13LQhrV2QZKZr9+uPo3xc3yviJAUGeCER6Vy9MtAjXCZlBZvFVBEQzrGt/MQNbm5O3ibknFolLK+4rFwT11Rjc67ztvv0vWRpIB2F5Rxg3Ct1X6yKPwcfakN346QS7DxA1IK0Pwh4CdG4YbzKT1qLXmbtRf5z7gezQxqyeORjNHkf+n8EE6nh802kJFVciJx3sSmtsPRN5ZuReD6Npx+hMKifSSEGL4pNbUNz3gKctfdOvaEhQ2HHno0pUtlIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnORAhwoE3V7N/IypFK550lZjvlN1tSiGIcfFdkg4VA=;
 b=bROuehkWEcj3rkO9YwL6tz3ffgIIQ6kuwwi45D10Gz+SyIGB6l8AbRwkxtuLKBoPMrBjex8Ecu4nvGqzYeG2AKMA3l52BgELmgk/LEFOVmstgfzFPxH5xyvCuxAtzwLB+6imTjTRAAdvkJuSx+uMheU/Xc6k+OQv3upBT1jynmc=
Received: from MW2PR16CA0051.namprd16.prod.outlook.com (2603:10b6:907:1::28)
 by DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.26; Mon, 7 Aug 2023 05:10:56 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::96) by MW2PR16CA0051.outlook.office365.com
 (2603:10b6:907:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26 via Frontend
 Transport; Mon, 7 Aug 2023 05:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 05:10:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 00:10:57 -0500
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Mon, 7 Aug 2023 00:10:56 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/irq: Move irq resume to the beginning
Date: Mon, 7 Aug 2023 13:10:54 +0800
Message-ID: <20230807051054.39706-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 109f9457-3eff-4c0d-ae25-08db9704afe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9AN8+EG5iyr/W+qTn8RHuLnIDIUUYu7PAmBQKEpq7OeBFPaJJMqJBt+VKH4R/Rsamqxt/4lfrGNBzMrbinrY+cBlvL1Fo9gm+ljWfnbkrr7okv+sd2N2BUD5WB/aCqanGNsSdh/rzG9bFWp1eZa5Iv000zdynOOYnozZX+OzckA9unIJitY09YVbSCxSd/C4qfdnwauWu0Pb/fQm9ysNxoohojFTlcH/s/CK4+GT10RHFHgUc4x8hdaUhJ5/c1thZsy/3Tl1ev7ZOXK3LH0SZpMxurVdI+kQVN8hQiLPczz7xVTybyDH6FD34xzW00rqAhwd3RQ1LvIdqwFYQBtLDIObYbM8N6CVKXQz8GscNRTdNhjhoMfmNIAH95khasu1bHxl+fEECGoEvt6k67ir0wYRDq8pKB1pkx3iohScq/tDH9tTg2+XKXVLVXhmUIxU83gJCtcESL/tm9+Pu/xG2TRSzllAY3MMl6zHfKt44dmR5u9GqCV0rGtIZ4CUblgGwWof04PL+9XUAaOtnKrt5zLYIQFLgXDhzZoeXkFIioduJPCQfsZz1cf2q9GkrWcVCoSvw97qksU2T4wJFV3GvXi0La7sM3F5Kch7scoRWcmRlIKtBedy3m4A8F3QdGmHJELx0fF8kEoIrvl7FgorTcpDd3e/6xAgXRbddtlWyAIDHQGIILvCnnxfSveLErUEbVAjn2x687YIFpQJTeI/6nDWH+c41Qs4w9UUQT2vwihglscI7A5sDEczGxZvsk+EKBndNq3xgs+/QoBfDd/RAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(186006)(1800799003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(36756003)(70206006)(70586007)(6916009)(4326008)(2906002)(478600001)(8676002)(8936002)(5660300002)(41300700001)(40460700003)(316002)(36860700001)(40480700001)(86362001)(356005)(81166007)(82740400003)(7696005)(26005)(1076003)(336012)(2616005)(83380400001)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 05:10:58.8379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 109f9457-3eff-4c0d-ae25-08db9704afe5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112
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
Cc: Emily Deng <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Need to move irq resume to the beginning of reset sriov, or if
one interrupt occurs before irq resume, then the irq won't work anymore.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1338489b0b2f..8b304fdfe6db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4617,6 +4617,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 		r = amdgpu_virt_reset_gpu(adev);
 	if (r)
 		return r;
+	amdgpu_irq_gpu_reset_resume_helper(adev);
 
 	/* some sw clean up VF needs to do before recover */
 	amdgpu_virt_post_reset(adev);
@@ -4646,7 +4647,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 		amdgpu_put_xgmi_hive(hive);
 
 	if (!r) {
-		amdgpu_irq_gpu_reset_resume_helper(adev);
 		r = amdgpu_ib_ring_tests(adev);
 
 		amdgpu_amdkfd_post_reset(adev);
-- 
2.36.1

