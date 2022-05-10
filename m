Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68672C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9C710E9DB;
	Tue, 10 May 2022 20:46:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB8010E9DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:46:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3UtxQQhY/SxsB8b6mg3LZZiWo5Px8MF+e0GlR6niNIjobY4FqW7vYvHpQeLv3QsoHrw8bUsBs0DfrbgRaXmJ8T2xkQ5EB51fVDkAglJ1RpwE4GwdCcETNRtq7+pWGfe35DRdJMaRn0E2/FM28+8WeSvVNiJXejhHhKMWQ1pxSmNd6ao+RvRNRScGspT4qXWpM5c3JJLuQVhfAja2N3WETFJHwYc9ZseqaGTMzDW9oeAFPiC05U+64HuZ3yykcic5hSx8GU5ugXWphMk2E8ibGamemSLq/gPG3vHbRGc3Uq1OYT64JGLmN39WOipq05SPndwt3yTmlih4HSvD4nUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K1bSk/07cqnZyusjNTncZL12XqJ4pIlTzdKou6vsT8=;
 b=RYdkDXVJQsiMGQ4/La9AhnZgLnDifsDsrpus2uO/uKVBDZwvptiuZs0Fy3VdKNabhTsedlwYzpWvq3hX+gaWQgJeHy76l+tDf0xLFoZgpjJdOMHxIS/1cNxfUA7SooMUiPclRP5orW/A+yFECntCbBEmq8Qo8Y7DYQJInW7bNIq4X7WWmWj9yOSvgfXKSxdV6UmGKgPBdZxe6CNwvVO4Xb2mGQd1ePQF/GnpJPEKylZ2sSYEmkN/Aya6kr7snlQjIAbPBKWqlZDeTQBZigma4aHUHg4tL5d+Y3Uw0Ad/js9qnVixHTW/HRfx/mB/gMp0rpy1+X0vcwzHe/dOSZdcpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K1bSk/07cqnZyusjNTncZL12XqJ4pIlTzdKou6vsT8=;
 b=J5DzAPL290z/1uUiE9I1UEM4+W17UdW0unJvgg8TzFp0yKFzpbv9XPwtQIwjC5JtLB+wNY5NupiKujY3zJDF9asGAq1RHHgXoy5eyWnzXTwzkdxV1IucAgoWbPVRbSEv8HyH2/XNz371QCEqwPYGNlx77ClEn3HYn/DSGL6bmDs=
Received: from BN8PR04CA0053.namprd04.prod.outlook.com (2603:10b6:408:d4::27)
 by CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 20:46:22 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::f4) by BN8PR04CA0053.outlook.office365.com
 (2603:10b6:408:d4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Tue, 10 May 2022 20:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 10 May 2022 20:46:21 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:46:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 13:46:20 -0700
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:46:16 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 12/19] drm/amd/display: use HW lock mgr for PSR-SU
Date: Tue, 10 May 2022 16:45:01 -0400
Message-ID: <20220510204508.506089-13-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 247a2a3c-d309-4589-4a89-08da32c62442
X-MS-TrafficTypeDiagnostic: CY5PR12MB6372:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6372D4289D70A455C81751518DC99@CY5PR12MB6372.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sC92QAQ4KxNcZxc7R3E+SHbLp6PX7091Dx9yLYZeUvPc8XAEoijHN3UbQkIu4J0nNqKXrrFFLK2hP/YwI5mE//Hu3CHOyIz7mGxQ+j1KM9mLWGyYO7PeBhKqMvB2dZAjNYwZzioJ0MgYsOs+hQRD6ze5u06bmhK+EN5HPMy4W+ZKeHVy+WBwSrChHS7TRs6qWOgqqWpXdzsGaZQJDBiwZaQyOfhG7Wsp/33Nq6z6E6SFJhYetY18OKAz+cALtit+u+IeNHholZOFm5ik+ltPamHpw3fo6O5gT6kmPm/z3vXFJpmAyfLZLut7ZvrT2eseb4AewReBD8puarXi5UbMusde0/H+7rbhhyhOJym4r3ZHlhQLdsUUq623OcRtKxckQsxiext2X5v/RT+o7pRMJRPrQo4R31lEiCXazE+ysRK1YpF/e4j0bLrBY9xl/QO2pODQyUuMqd1ALisFfj+3RWpsFUJKnB+U6LhC9mkvYfcigjWCpy+0SvuxUEskls/s4DWbPJELlCyGCrgKDgoO+KSsA2Z7xVDMGqdTYm2oMXvsA2ZRD6YzWnWP8Iav0JZXJ2otxkPaqArmWgiZ4N15kVS7PqezUUJAvyjL2H/k857w4BWFmjURX63Kt/Omi+scI4dVQKEXPWVtb7qfcZIA65Yw4HlSFDxe4ptfdQOBDDXiG8vbq3R7ljU6txFHlYrPgYF8SmLjj1xmuPEE4yC+og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(4744005)(26005)(86362001)(82310400005)(186003)(336012)(83380400001)(47076005)(426003)(70586007)(70206006)(1076003)(5660300002)(8676002)(2616005)(36860700001)(36756003)(54906003)(6916009)(356005)(81166007)(40460700003)(2906002)(6666004)(7696005)(508600001)(316002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:46:21.8959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 247a2a3c-d309-4589-4a89-08da32c62442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6372
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
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

