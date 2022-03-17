Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7A9C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 20:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C70110E103;
	Thu, 17 Mar 2022 20:57:37 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3897810E103
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 20:57:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdVp4yDuCqZBOcRyelW3WzaZE9G76gifzk1XjOy8NwFo9YNth3CSdO6q90virQ93SXIRcijvhTYqKaW4R5BaPIrd6y2oVsmjgVi4tdqQaqjYtyXbVVtwrxK5ZQ10SeJihWZVTM1qOKevFFI2PTfXkgsO/FxqfSIfSpDbGtHkJVF37McyorZNYwr3DqkLyGkI0dJJH+ywWGpgs0L4b+5BBSI4pjfjoyTIFEAZG4zB9yEqweuXrAuPhBGeagxKZC5ScN1wGhIvZVOGcmYudxA6Nm8MNsudtrGIrO6PVQBsIXHzrgdZTFjpfruTdV4CwgpiZSFuZAS2lJxAYsQCDJ8nDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSxA8zZgsZeNOJEoG44YHk7UKea2XtE5t7qNsX+T8gc=;
 b=P1LtVmg5hUP16T2/JLDeNfwniGapIYwoGsdYrzIQ/QtoYXkQZeYnnjHJOGEpxnBaJCAYBE5GxsIwDdsZ8w9M81nYIZZEhW4BbYewvxlxQER8zwpQSiGMJQjVkZ4ZwLK9WGZzVyKyrPS2kWfz3LJ41nQv1LKjBz08YRdyI09U7CHt9aRx2j4xVgAzntFLi4mj3etiyqGHlqvwf3mFLf28p1paaQgxVG09RQ5/nxGjTM6g/UwrqrmDHQ/+Q6AknuM/pOGijxNP2mIG76i0AifH13fOhq1x7nGa3GNBqFCGgkSgA+JgsADeWsljyWmcEspuhZ414VhCOEnYojx8G0/A+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSxA8zZgsZeNOJEoG44YHk7UKea2XtE5t7qNsX+T8gc=;
 b=quuPh74NS0xKK1zqnfpF97zwA032A9mFIqIo63kbR6n3PCdh8+UsGukU1IRiNvyJOO6+O+SyhYa0Ahi7ig68f/uwNyKG1pI378D7vmJW52ngjWhu5g+/J2GB6M2+AQMLW6arsXBJkpc/W37BYDKDKz+3tHr5nTn4/vNCeHjwTII=
Received: from MW4PR04CA0174.namprd04.prod.outlook.com (2603:10b6:303:85::29)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 20:57:34 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::7f) by MW4PR04CA0174.outlook.office365.com
 (2603:10b6:303:85::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 17 Mar 2022 20:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 20:57:33 +0000
Received: from tuspatel.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 15:57:31 -0500
From: Tushar Patel <tushar.patel@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Fix Incorrect VMIDs passed to HWS
Date: Thu, 17 Mar 2022 16:57:03 -0400
Message-ID: <20220317205703.130737-1-tushar.patel@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d46f51f9-d777-4d50-1333-08da0858c22c
X-MS-TrafficTypeDiagnostic: DS7PR12MB5765:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB576515A2C20D0FBFE8E36C5F96129@DS7PR12MB5765.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8eqCWJjjvEjr7KG49DVlC/KrmtCF1vZHBCh3BSG3YT/bqJROJJ2NefLj93fCoNcGH/wBYFr6EYEjOM7rMrRgznuzuD5+QdyV5+uMrijPbM+p174PdF5ho5ycxU/f3BziPWAvipwKZdI8knSlgRBl4Utztv4v4zb18vyGxwaw91xWjWwU/QZ6rbKg1IGIPYBzjZeMcuF+An0S/ul+YGJmMY5ZT8wPpQ0vuypxP5Aac+9BJoA2DGNLxnMVZBsdWIZDBnDc+icLHOjK2z6bCt4nzelPl3ze3nSNeJTK3/+r5/2IsQWy7BFjatX2PGiy2Spo4Ad0tcD37euJXFimEv70G2m6jAwH6P7BFU3VrPhZ8231Sws+qMh0KtQYoyC36tsxeXHllvHYYljymfw7psmOY4w2mjDPSmHHlJu8TA4+Z8MXEuvqWgAGvPi+BE9gnKKw8hzHJsCfJ9klVVvA3Ita0w96Eb+DZEpduQOmZtsPFwhZQtbcr6vEvalx1XqXPOdMd27wacx2CY4Kl57+hGBiK93X8YlF6yNfOBPGY0sELiYSVTG4iadTDPn1nOFWxk3ON58ln+Tt/cT9SKJa+hjmN69zQt0xOeDcfgB9ME78t8Elln+gN3nbiFc8FYW1g1uKKDRBGY6cHzCm0Le/g/oEXVqjRChvbNtO+MPYTOEQNd1H09EsSkC/9fntu+4bFc9Lrfgr8T0y/V7sVL/UQIXK2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(36756003)(5660300002)(82310400004)(26005)(6916009)(316002)(426003)(508600001)(336012)(1076003)(2616005)(6666004)(186003)(356005)(83380400001)(7696005)(70206006)(36860700001)(40460700003)(81166007)(47076005)(8936002)(16526019)(70586007)(44832011)(86362001)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 20:57:33.2440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d46f51f9-d777-4d50-1333-08da0858c22c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765
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
Cc: Tushar Patel <tushar.patel@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Removed dev_error message for incorrect VMIDs

Fix Incorrect VMIDs passed to HWS
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 12 +++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4c20c23d6ba0..bda1b5132ee8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -680,7 +680,7 @@ MODULE_PARM_DESC(sched_policy,
  * Maximum number of processes that HWS can schedule concurrently. The maximum is the
  * number of VMIDs assigned to the HWS, which is also the default.
  */
-int hws_max_conc_proc = 8;
+int hws_max_conc_proc = -1;
 module_param(hws_max_conc_proc, int, 0444);
 MODULE_PARM_DESC(hws_max_conc_proc,
 	"Max # processes HWS can execute concurrently when sched_policy=0 (0 = no concurrency, #VMIDs for KFD = Maximum(default))");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 339e12c94cff..66074e1abc79 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -483,15 +483,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	}
 
 	/* Verify module parameters regarding mapped process number*/
-	if ((hws_max_conc_proc < 0)
-			|| (hws_max_conc_proc > kfd->vm_info.vmid_num_kfd)) {
-		dev_err(kfd_device,
-			"hws_max_conc_proc %d must be between 0 and %d, use %d instead\n",
-			hws_max_conc_proc, kfd->vm_info.vmid_num_kfd,
-			kfd->vm_info.vmid_num_kfd);
-		kfd->max_proc_per_quantum = kfd->vm_info.vmid_num_kfd;
-	} else
-		kfd->max_proc_per_quantum = hws_max_conc_proc;
+	kfd->max_proc_per_quantum = kfd->vm_info.vmid_num_kfd;
+	if (hws_max_conc_proc != -1)
+		kfd->max_proc_per_quantum = min(hws_max_conc_proc, kfd->vm_info.vmid_num_kfd);
 
 	/* calculate max size of mqds needed for queues */
 	size = max_num_of_queues_per_device *
-- 
2.25.1

