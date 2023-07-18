Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68473EB64DA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 12:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0248010E31E;
	Tue, 18 Jul 2023 12:21:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B6910E31E
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 12:21:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ao2XAHPqzNsjqSktALsqEKQdHyShRSc5jSjoQbZ1axqJaV88OL2aRdJKhcFyHulc469u5BLemPhqp5eOLE/CZ8MS5wBuE9t7zVdSl84C+Fuzf3mTJttUdl906WohYyeND/MAuqEjlaL2dVl9VvW5/ZSFRUU5R0cU+8EaSGH0bGpsRsqFZfTmebYF5ETP+5zOqBLSajuEokfIk5UWL4Ch00U6GrUOVNeGSnNcgJwx+JDXYyPtFp0E9aKMHv0BUFVnkFK2wgSyt4ouDpHOqLyET8NP5LFMg7AlJEMKOZA3+AvIMcU7fxmnK+uwddRwqdD5jqehKu3XH+rpddvD+XGwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0V6tFVpu564ArArAJux3BD/LaZQUu6NMHEFw4dTPbU=;
 b=G+nrSF0RSjdj2fAmCDc5QXl9pF4ocd90NszyKBxK2t8d100VG6q0hghJyMTG+ccvwTQf5SOOitiSIB3liMROmeAqnku4XsciYS/ZLkB4KboXtRPXDPEwaXI3Hf/F4jlXnroCRxik449M4fHz4Yfuy1rlX6F7Fhc55z6OBMnX4M8q8zdO+XJt5CHjZVm/RpUHGO0oL76kIynxrSNYsg6O/T0jCM2CbvmwJ9lKhHylUKS7g7yBm8mz20bXfR936waUA6kpzeqrkq9TBq6PmmOdTuaIg3ll4lGSyOocrsFv1jQBPaCvDROqz2uBrWEkvyRdibWIMwOtyEAFp9YQ3n8oXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0V6tFVpu564ArArAJux3BD/LaZQUu6NMHEFw4dTPbU=;
 b=Dm4JgnWvD6MN90FXbhfhrXzSJjmsaKMXkWKJYJR1mhtCy5MOPs8mJKgpIUS9cl8SEHvktgoXkkNnitRw+L31IA+/97seKVhPjGZyn9wQ3zqRJ0fk7KpXzuU2eG6YpqlhVUweZW8WZeadb5s9SxVnHTd3K5uvMoXy7ByEjXXr5lE=
Received: from DS7PR05CA0045.namprd05.prod.outlook.com (2603:10b6:8:2f::7) by
 LV3PR12MB9268.namprd12.prod.outlook.com (2603:10b6:408:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 12:21:39 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::d9) by DS7PR05CA0045.outlook.office365.com
 (2603:10b6:8:2f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Tue, 18 Jul 2023 12:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 12:21:38 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 18 Jul
 2023 07:21:36 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Update ring scheduler info as needed
Date: Tue, 18 Jul 2023 17:51:20 +0530
Message-ID: <20230718122120.2938177-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT113:EE_|LV3PR12MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: d5836a58-f9d8-4e1b-1c5f-08db87898933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4258Ve86K0gqeETJ1MK8551f9URQrfeo2yaEtd0kr7ic4sh3OzKO5ZeGroTP1XU3Djurgh/RJKFbJEyVzWH4CPP6/dMqCCC7jOkgEUxLvyC+HscfXD1SneaFuPxOZCmNpZZlxfpV277vxakFlhLTGVzfgI50pRF65eGwWVDoT2VV8Qy/sZ0NMUu3rhnU6lOkIv2UYSm6vsHAYOjX8raCzTuqvXJChx4i/EKlMiUaPa0ZjtPV42NEyCuKkRCuW9M9MUx3Hck35HlDDO9dN9fKzReOLZLh0/dG0IWuNI/0++Hco5kqcygxykfjs+S75UEyas2hwRx4f2lT0I8DUpaoe+VGXbeoqp1JvH+K3Yu11KsyCN5vmG8JzvKq9Kogc91FG+AJD5CUYdeJX11qt5RWDHcX4a5F98BsI+D+JoMpU8USCSKEB6Z4B+0LRixH4q5iYGS6Pu0bIXVTwyYQg2tu+DKLPm0+R8sMK4yn2pnaiXJrYp6hkO85hIANB9zmzGSk0QAerEB8TQmXdjKVdk3yv4doQ4fLdyPpMBzxqT4eU1EtjGDAI4T8Gmj6p5ehpORX/4mly7t+hA5RRoJDKL4vjuoZPkgnp6i9yAD0/HB1ca3MBXQ8JqAsBB+P4CLP+6o/kRTJdfeRW045J4xuWLVNiAZ/L8shO8mRZVCOnIv8vI523rzprTUSfuEZeAeZM56i4Tv5Ax+/R8kqhlZqeyaQweXTfpJmQrtvcYrgU46H4rkzlH8f8PncFrUCncCk6T2iWEMBpn5Gx40/HQrYOfN4qw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(316002)(6666004)(7696005)(86362001)(4326008)(40480700001)(336012)(186003)(44832011)(478600001)(41300700001)(54906003)(70586007)(6916009)(70206006)(40460700003)(8936002)(8676002)(5660300002)(1076003)(26005)(83380400001)(426003)(36860700001)(36756003)(2906002)(81166007)(82740400003)(16526019)(356005)(2616005)(15650500001)(4744005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 12:21:38.4373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5836a58-f9d8-4e1b-1c5f-08db87898933
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9268
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
Cc: Alexander.Deucher@amd.com, James.Zhu@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Not all rings have scheduler associated. Only update scheduler data for
rings with scheduler. It could result in out of bound access as total
rings are more than those associated with particular IPs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 72b629a78c62..d0fc62784e82 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -134,7 +134,7 @@ static int aqua_vanjaram_xcp_sched_list_update(
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
 		ring = adev->rings[i];
-		if (!ring || !ring->sched.ready)
+		if (!ring || !ring->sched.ready || ring->no_scheduler)
 			continue;
 
 		aqua_vanjaram_xcp_gpu_sched_update(adev, ring, ring->xcp_id);
-- 
2.25.1

