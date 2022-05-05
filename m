Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05626C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ED7C10E3A7;
	Thu,  5 May 2022 14:24:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEFF710E3C7
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:24:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2ALtMtpWxf0vkcVMc4NJVR5iL2bLJZjydld2kMf2f+86PGrOzKX2kCBgIoJKiM1EQYGpVADHJ1YSdTdvqo6FXfj32lN9j//DNv+F8Tr0GrHABM7S+C5NhHYEPv+Qw0FBipl5WSEbumt4rnJWG1CAIPF5m/bOLKiWr/EPuL8COvjZy9BdokeppSQuozBQUY0LXYfq1ClVSiP1js0ZfNZGlb5yobvWALHGSTGRbyHCnyrjvmGhMAYeR/Ze3BP4DXRnC/dQuwRyvIR9/GlFOHxf/znpLVjP42ToupM8ltubaRrQRiXQuJvWNzRiQVyl8ooyrLhv3tCnwEnoBV90bsK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K1bSk/07cqnZyusjNTncZL12XqJ4pIlTzdKou6vsT8=;
 b=gHNJO7NNLFQiaknzgn8ChhXtv88S1zVJZU2awDVxFkUIWeRMU4RdASofVva8x5LsP7zGK5TCXzuPzk0OVbhmD2JCGt1Pq+hewZbS87wNVLdOVs9fqzpyJ3eEE4LIspIdagUrtIJyLW0zkau3R1S5XNp3UazoeNe8NE1viclOoVU0E1VDr1gXAckyS2Izd1hAjl7BuCuVcIu8WNjJJ+eIL/NlvnK9OpFW4XIPZoVfFB03e4s8+gux26IszunkR0oHu48NSUP1wffP1jv8jUT14uT2nbjyZcyfJO7yio9GW5xr5kRLa20LR4EYC/RFxbsUHCwdf+dqMzDpuak6CNYQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K1bSk/07cqnZyusjNTncZL12XqJ4pIlTzdKou6vsT8=;
 b=V8jw+L8p676Hor+nPcaNL+h1Caf8aGOs3zj2fZjpAyJX1+YOJ30uKfRSxhp5BW3Uth2S9RJREZbZgia+v8I8piL/I4kZDVUn64h+lasD4sgJco/6n9uea1RQcW/OzJS6qxLreBnm2K3sDj9GLPNBJnLOWKZTasRI6Yl1TS4AOKY=
Received: from DM6PR11CA0045.namprd11.prod.outlook.com (2603:10b6:5:14c::22)
 by BN8PR12MB3380.namprd12.prod.outlook.com (2603:10b6:408:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Thu, 5 May
 2022 14:23:59 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::14) by DM6PR11CA0045.outlook.office365.com
 (2603:10b6:5:14c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27 via Frontend
 Transport; Thu, 5 May 2022 14:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:23:58 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:23:56 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/17] drm/amd/display: use HW lock mgr for PSR-SU
Date: Thu, 5 May 2022 10:23:18 -0400
Message-ID: <20220505142323.2566949-13-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505142323.2566949-1-dingchen.zhang@amd.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c883ce79-a754-4054-2a10-08da2ea2e519
X-MS-TrafficTypeDiagnostic: BN8PR12MB3380:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB33804FE25DF3487045DDCF298DC29@BN8PR12MB3380.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BsWEynP79+umEq9Tu8OKAAshVkrvUD1u2dO74mFOMphMVZfZT4H9ivNbQwAbjFsM9PqDYdRwh9tfJIaSZ1DWCBm6tzhoL1c7ZVoGVRZLdnd71X5D2DldB8shLKhFUKrcmOWP4M460CaWDlySSnPe5oLcfS877c4NP1hpUwU7rBYe5PBwfWt6N8HEGEFTwAMJ2XG1wA6CkwURN5YXH8OWEEAaYACc5uiKAAdVmp8jsqx7wBqDiCBruuQsQ9EMOEha41JVXO2+bJKVI0csrRO1G+DxD4YRrdSmAjc9UMPk3WIK3CZgN+hFjzP1xAETLAue3jL6PXebnclaumg/hTkzUN6vMGkuEfXzeXz7cbViBrHFoa8Ko/xpXjdqv/wsT+qO2MY03LelyWLU//w/tJyxcBdz3mtmh6N+LBFLT/A3nYVtmjtgTVCYmck41BPD6tcbTgM+2XAX0LpqaLERLb0yKfBb2lQ7hSF1QOW4Aj70oIu1GRoDCeTJajoYTei9DV8GmsIbVxNRegW5qYUzXPUyjOGrSKCA5BnLwqTf+fGfPqTVqXs/NQfCuATeh2089S21rglnDwDB+TJGbjG5KwJ3g8wuL2BtWUQrxqokIidJUfmxPyfxVJ06jQX7yOxk2MHXHZyDk9YCBBqsacWBPal6iIn5W5gGIXQJzCcKAg19HBIJ9EUBHNM1D9sV1miDTgAC392Xdu0iTrIIlY3TXc9ouA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(16526019)(316002)(8936002)(36860700001)(81166007)(508600001)(6916009)(54906003)(1076003)(186003)(2906002)(86362001)(2616005)(8676002)(4744005)(26005)(4326008)(36756003)(40460700003)(82310400005)(83380400001)(6666004)(70206006)(70586007)(5660300002)(336012)(356005)(426003)(47076005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:23:58.8620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c883ce79-a754-4054-2a10-08da2ea2e519
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3380
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
Feature requires synchronization of dig, pipe, and cursor locking
between driver and DMUB fw for PSR-SU

[how]
return True if PSR-SU in the checker should_use_dmub_lock()

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index b1b2e3c6f379..3f32e9c3fbaf 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -65,5 +65,7 @@ void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
 
 bool should_use_dmub_lock(struct dc_link *link)
 {
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
+		return true;
 	return false;
 }
-- 
2.25.1

