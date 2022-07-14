Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575E1C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 07:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E01818A8F3;
	Thu, 14 Jul 2022 07:07:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2079.outbound.protection.outlook.com [40.107.96.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE6211B087
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 07:07:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMBn/0sAfeaBIyGKsB39kAcb1E7IeYGfQPDJZvvqsQUNZ/ErkfOc9X6zFWqQMyTqjurXnEQe3VrKXb+ElS5heIl0R2Oy8IOG9a3FIUMq5tMPVaxSgpu5b9KY/e3Ypm9ZFSX4sRUNCzK5cjEQhK3qt0SImQBTOkdUJtjoZOglVlGkQdsUdoNEhET/1lGv0DQuxW8YBhTz6IYLLytjDqBvl4CvwMg31uw5ANeITa4NBQw4edL4FlAE086gttNVFSydFDK6Pay4DJlS2ZCLloaUe0l2Tyc/uxdSYCHTjxhaBS+u5v9AZLiFoDQTVYheZJHu2kqdSkY78myEcd+ZDlKl6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCAnwyaTniP9pk03z2GbpDexGEF2QjE2+XYDjx/lq+0=;
 b=SNRgFTNhT4hhGr5zhIqcdGuB5Z8mtff9JDoJUQ6XIhB+mG5AKI8SDHg5FPaEexkQob/tdhV+nVURgwjDmsBxzayEdG/mOWUPmHN/aWksUZ+8uFLG/NWDKEKdVFGNz3ldgWHPiE8U9i3u7F6RUMzF+UZIkCttgRi+anC4jRFrgckVCZ+3kQF6Pv278Iz0YQd5l2TbVPXEzWQ58uJHkZyqZ1sCbeqqzkFig9S/zcIv0ldqzR/LIO6dh/JjjUmUW6gVRByfHu5ZgUXrVCTY4M6cJGc/f1OjnnvlgwVzPGZkAV5fSsoLJxduXjjszyNLwgOS11/TkwhxO2M7zHy6C1evkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCAnwyaTniP9pk03z2GbpDexGEF2QjE2+XYDjx/lq+0=;
 b=4jZktvaGHoUYlQbOot6ZI3NutqKGkgRyXNprED38w7xAx20ls6j7EvNQUv/R8DFALKWNNqGVpAvhi/lajlv69b6Iicw2n0rKpAZUnIikjtWWHgZV+58wjfpp+k2dsb7XxZHtj7j+2KUBbbdNREFIuxx2RL9xJsp0Hp2sexkb/D8=
Received: from MW4PR03CA0087.namprd03.prod.outlook.com (2603:10b6:303:b6::32)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 07:07:53 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::cf) by MW4PR03CA0087.outlook.office365.com
 (2603:10b6:303:b6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13 via Frontend
 Transport; Thu, 14 Jul 2022 07:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 07:07:53 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 14 Jul
 2022 02:07:50 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: limit the number of enabled gfx queues
Date: Thu, 14 Jul 2022 15:06:45 +0800
Message-ID: <20220714070645.99139-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e8b3b4a-f4f5-4c07-bcc2-08da65679221
X-MS-TrafficTypeDiagnostic: MN2PR12MB4285:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yzZbztYEtLCwJfFUHKrxwSOM9CGSbdBQT+WOPGDjRjW0x5lMXHGNaUXmUHb1V3Z3irzjSKHozm3E0TO63Or13zgZhbSVcg7xEY+6q0Asi05oBb7uS4aES8vRT1XEHvk33up20pdv86mf2XVjb3gklmofRpyFcETry1qSaeDyE9Vi8MhKE7C1Z9KCzSeErYpCZ0iCcpRn4WEMxb9mCJ6Fg6cgx2HwnYkWQETTr+9+jqRTQszZOGopKOHE5H4AkEX8csUG0mo4o6RiKgvQ5/aa0BwY4dGe8xHj66a9AM9oPEiAYCwTjxv3H4oEgesP7IoKZZQP8FxoPY9vbp7r1k2FgUNSLjo84w6+CrG6zncvQTAVerVIoY5MiaZbCuoE+dVAE5JQaeScsvFq0/SMg1kzlyd5YNBbqOEbWsTJ6KuF3uPZ+kelB6EBgaG4/2SBCeHe3xQS7uaGztfCsdakGpsWLALPlDkl6/M7aChLK8StdFJY3p608bN0mhwlsAdH8IfFtgtVj0TVRsudjC/qoNeEN3KpbmxZVdblf7n1RzflSYxY7d4aEZxWK+HK+VmuwsnuFGtvCrUoL1bx15LLlTEhwRB451t2/moda+q75WMsyt28ZPQtS3xkzGITLIzxtyNpWRA0HzRa5j99/M2gyHp0MwlLw0N6GNo5SFsEsuAlazbCDiyG5BEkJ1PqEjW5M8Yc0q/IxpqN5Lp6zeORMEtPkI0sye5mxlQSB4PEd1I/Md6/m9tvZi/APSbpRFuExxMMgTHNX5J0ri3i2h5s26IVCeK0BBwgOlcSiXsu5+nihI2X6U6TvXct7viv/tNhblW0IX5ovNPRT51/unKci1W5EuVTairTSq1hbntLp6nxMTEsxMkbf8jneWKMdnAGLedS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966006)(40470700004)(36840700001)(54906003)(36860700001)(478600001)(83380400001)(1076003)(2906002)(40460700003)(40480700001)(86362001)(6916009)(82740400003)(36756003)(70206006)(6666004)(81166007)(2616005)(82310400005)(70586007)(26005)(8676002)(7696005)(4326008)(16526019)(426003)(316002)(5660300002)(336012)(47076005)(356005)(41300700001)(186003)(8936002)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 07:07:53.2193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8b3b4a-f4f5-4c07-bcc2-08da65679221
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The driver can only support AMDGPU_MAX_GFX_RINGS gfx queues
at the moment. Once enabled gfx queues exceed the limit,
we will run into problems when setting up gfx rings in
gfx_xxx_sw_init().

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 222d3d7ea076..ae3fe1d0df04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -229,8 +229,9 @@ void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
 {
 	int i, queue, pipe;
 	bool multipipe_policy = amdgpu_gfx_is_graphics_multipipe_capable(adev);
-	int max_queues_per_me = adev->gfx.me.num_pipe_per_me *
-					adev->gfx.me.num_queue_per_pipe;
+	int max_queues_per_me = min(adev->gfx.me.num_pipe_per_me *
+				    adev->gfx.me.num_queue_per_pipe,
+				    adev->gfx.num_gfx_rings);
 
 	if (multipipe_policy) {
 		/* policy: amdgpu owns the first queue per pipe at this stage
-- 
2.25.1

