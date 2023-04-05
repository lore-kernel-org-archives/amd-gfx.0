Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7ECC761A6
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 13:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE72710E085;
	Wed,  5 Apr 2023 13:24:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE1E010E085
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 13:24:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+WCn4DTJdk6gmmQGOC2Qh5TVK0F0/+s2GdIgqY0NyvWeIM1FQqfkMksfS8Mhh183MsvzpYZXQ3dllFEGZvZKfAyZaHC4T2I1DxJWI5b7+fMsrk4Yg1XokpeIcxG0VRr4OfHp5NlVpIbDIpn59t9YFBVsMSmonUBUqYo9zv1WC6P3ehPCad8TgfSjm3QBfzMW1ExmcA8aw+SCNIatsNkkcIjCQikPz45PazUTLJUBD5f4N26lpmueh2wD4W0xCbFS27y7/oLNaTvWn64G13W12uBVOoUHUpgMFlntvODO8vJnZOq2zGa8Zi+eLDenR4lc8UvHwMsBkj+MFOL1OS2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1Mvo/5gWgaVjqJhzyJwa5ZgVD4+NK4HMrya+E/AYJc=;
 b=m4wKpYlhCGZvU7bpm6WzdhLnyFswwp/x0ttXDi50QpHVYOnOu+EBrKQTkaCB0271HCE3IukNixQ9oSjQlalfkmNY6RVArga5Kx0vNPAm1G8wPcqU7kV1VwKNHrEgcWm875daO9ojXsD2pONEIwAlTy54Kl/8AhY77Qer8mx2CAOq0PEt6yuEFkbLLspeaQxhpp+cMhotVOoddtlGJ504FlMGkPA9lKHY2dxAuSrIpd1kqndzCL8iPzjADTeNivyH/69Z89EtcQABLh/BDNkLFJL2U6Z8k+o1YHNfUeIZQUEXBGmtIDofvqUaOGrCbkIn3K+klUBKTNvVZER76sF8QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1Mvo/5gWgaVjqJhzyJwa5ZgVD4+NK4HMrya+E/AYJc=;
 b=Xs5fIQeJhjX4OcwqjQ/W6qw6JaX2nGS8Z6Fg9KmqVgoXwYxIIh3hq/UKFJH1dIiqOmbsRN6lkHpeWn/yYK9YNbAROWVUdBE0brQ1VEcC2BKHMmB1520hhrPrqmVmfDvi0nMHd9wBL7RGx8vX1IA+NsjXvQ9U49e5HAxUXeM6WiI=
Received: from BN9PR03CA0564.namprd03.prod.outlook.com (2603:10b6:408:138::29)
 by SJ0PR12MB7084.namprd12.prod.outlook.com (2603:10b6:a03:4ae::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 13:24:46 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::78) by BN9PR03CA0564.outlook.office365.com
 (2603:10b6:408:138::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Wed, 5 Apr 2023 13:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.28 via Frontend Transport; Wed, 5 Apr 2023 13:24:46 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 5 Apr
 2023 08:24:44 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: Fix trivial style errors
Date: Wed, 5 Apr 2023 18:54:28 +0530
Message-ID: <20230405132428.393593-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT040:EE_|SJ0PR12MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f41456-8ae6-40b7-22bf-08db35d92006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKp3IJzR7PUv0p8jrt81SC0P8AvrePDlV4/z0af8+F2Ks8rYQcBRKVCM6i6W3+ggaf3KVPi+pqxZaXSXdYpBr3Q8gvbb1bT8Fq/VWN4ui1pBsLZ2/xdNa1cOyUq5ArFnrL/91EOXeFU3ZOGOXo8Tb5szNR+3wh0DCNzP/n8lmQannkERZnZSvep36v4q0S1KbObZ2efLsOCI5DLCua2YM86YUHof8qRlpWeuXVZR4LIEcadcJn8X7l4aB2SupafNgJ6nynjl3TGo5jXVLj+2y01nyi09AXLIYA8ALNhXApUVz+oJ3QfIwxioD77oCfk1y4OgOGkltqnWhGlEMHBzskiXvcCMSRImr7wvbZ3Cnu27vrerv4rth+iqUn2PC8QWd4TaGCeRP+g+pUsWnUkRv6tGq+W3xAK2dBD6F+M9OBDIN6Cajb6ILurL26kz8KNzf48zlT4YGWStgQ7KNWrkEIGqpVo/bbSAlcFVTIawaSTvM7enP3ud/YlR0Y3BoL57LGWo+ER5EB2t9w15Ade1Tb5IBmhmB+hr3ftR7eHnriogMOvdFuzEEkU+iMjp2b8Xs/e3LsfkBjFwMGNYwj5xmln/8FY9Ox6IYrf9gaazyTf204UfdCmLT9JU6g2u/t9pSHxsoRgyqPoVAi5uFD8dema5e6ygRU6m8wOJuSr3sApYz7NKtetvHE8r68W7HRLfGKtPnlzSp7U8WlQREr6L0b3z8PuZsly2Mt16X/JWECg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(26005)(1076003)(16526019)(86362001)(40460700003)(186003)(7696005)(36860700001)(82310400005)(478600001)(316002)(54906003)(6636002)(110136005)(8936002)(36756003)(5660300002)(82740400003)(44832011)(2906002)(356005)(70586007)(70206006)(4326008)(8676002)(41300700001)(81166007)(40480700001)(6666004)(2616005)(47076005)(83380400001)(336012)(426003)(66574015)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 13:24:46.4193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f41456-8ae6-40b7-22bf-08db35d92006
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7084
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix coding style errors reported by checkpatch, specifically:

ERROR: space prohibited before that ',' (ctx:WxV)
+module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);
                                                               ^

ERROR: space required after that ',' (ctx:WxV)
+module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);

This patch gets rid of all above type of  "ERROR" messages in
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c.

v2: The driver doesn't resubmit jobs on hangs any more, hence drop
the hang limit module parameter. (Christian)

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e652ffb2c68e..25606af348b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -521,13 +521,6 @@ MODULE_PARM_DESC(virtual_display,
 		 "Enable virtual display feature (the virtual_display will be set like xxxx:xx:xx.x,x;xxxx:xx:xx.x,x)");
 module_param_named(virtual_display, amdgpu_virtual_display, charp, 0444);
 
-/**
- * DOC: job_hang_limit (int)
- * Set how much time allow a job hang and not drop it. The default is 0.
- */
-MODULE_PARM_DESC(job_hang_limit, "how much time allow a job hang and not drop it (default 0)");
-module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);
-
 /**
  * DOC: lbpw (int)
  * Override Load Balancing Per Watt (LBPW) support (1 = enable, 0 = disable). The default is -1 (auto, enabled).
-- 
2.25.1

