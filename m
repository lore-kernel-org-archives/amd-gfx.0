Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959F8C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 21:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2526E10E819;
	Thu, 17 Mar 2022 21:40:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5405210E819
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 21:40:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aT+1JcTpqU06D6VEE1J2TNsJxjsD9PdRogBgnsgOOCa294O83ZLvaS+JP1beNVUMliTuohj21NBw+kYL7uesi9JxSxDx0j5NrVwZwcMyTF68YtOKMOVf0UEhQ2/bEMBQ7WUysKS2GFwf+qUUozC4ccSvWIHSoZMNMP+NBfzdwmPKLRej/hJW5PUbsM36sefF5kUzh2kyWXM2ZlGrMTKCoy8EmeXGJkgoXmUQ9EawCakzuryVusWVYxDKTVhP0KJtET/+e8uxTPpmh0YnY1NdFctxLSdIveqhyBdZ5c2OO5pytJPhlFxnIBqZGGo2pjFcihGRYLL6ZUyUhJ6HEa/Vtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNn8k5GYMBg+YVwy0oGUmExl4oKdadAYxH/mWU6JOOc=;
 b=Pf0vfbvpoS1xL6sGVBpsR8zSVpFy+VQFRDynFE7bDAs2+Oyxdt8USeZ8b88ajCaUz0wgGxidnejDMErNNBPSsd5MBZIMT77zb3LFwUsqV361K7aAJu/K4oDkMObqgbC/i6JHEslyH5qBGmJGCICJKyPj38Avf7xLaN3dauCpI2EgSxdPevKOYjAgXEhmZ09uEmD4NH5OqEeTMfmfy1jgQCQHNwWmJgd3byTG3g9P4aGqlS4mWTMKHcjPOzr7HhA3mpk8yWw6YegdcMoyjU+EEh8DJycDBnLYOAyxM21bkMIl/4tMlKk6+tUFeXJpwol1GcafTh6OL2Mchlm92pIBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNn8k5GYMBg+YVwy0oGUmExl4oKdadAYxH/mWU6JOOc=;
 b=Rat2d6hSVud4+/PG1T94St9kFsMHVNvSgP03jAQhAJGWNi+LlYArKgp1/PMv/Bjb57sRIdZvuwd8JCIqLRhH4ZiG22B7zVHEZMhK40zPW9Rg4kna8eXmIqyMbV7bN9lRRpyTOWHf7nQLHpEQy0A2Wk8fYPp187wcGz8x49ZpCXM=
Received: from DS7PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:3b5::28)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Thu, 17 Mar
 2022 21:40:24 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::a4) by DS7PR03CA0053.outlook.office365.com
 (2603:10b6:5:3b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26 via Frontend
 Transport; Thu, 17 Mar 2022 21:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 21:40:23 +0000
Received: from tuspatel.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 16:40:22 -0500
From: Tushar Patel <tushar.patel@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Fix Incorrect VMIDs passed to HWS
Date: Thu, 17 Mar 2022 17:40:05 -0400
Message-ID: <20220317214005.133302-1-tushar.patel@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f67712f8-8b4c-49f2-66aa-08da085ebe47
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB32125425CCC96A007261526796129@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTKEhOTKE0Wy4HiEKqGPKWjK1qtZ1ybWBsaBJWIfRlHLUaNbQQF9JGkJi94V+dlVmJAChfvhx723+/F8JxEvlLuAtgH+9PRVwsaWhrzvtI6aZp2WdHoejsS4IydXOknvtXLV/dpJmJ/fRHB2tS+k9AbloOHLzAf+OdOU2Oak0JZTSKgAg8gNFhWsJ0VacRsGluwAX+SDUgPpfpVGjtmyxtLekPmO/eqWD9YWcIlrpNU+0h8EP3uxTA0bot7wjEvSDwBR4JldWoFPyuPsDqs8Tb2Suqucr8W4SKJBrsWn/R5QqLJ/osTij09px+k0U8yvEGKgCX8BHYHLduEyXUYbxdXL+AMEnXd6hw3Z6zMIwWHK33CPMX9xvSjmtYDgHrwxTWfIkBVeZisC2xGuvVNa/1Mw5rH7zVx84f+myw96wNQboTppdDojPCWUYvYOFdNjYenoXgSTOVleWO9f8TkXydtVDB+sDWFV3wObmIIYlTfiXZq41oA/RKyfTk5H6Z3tLugR9Od2x2VsKXBYXbGbxyKoKiWAG4XspHCV8ZfLZjHJIqiHizT+o4Fx4rdYYVqsWHbmuER7rJajBggBwwkQ7vCarBc2YxgZ+pSx6MAEkgZMGBK/JfbNr9iqvpVwqQwMOY4J4ZQCmJJLP/5rlYUcy0bG+xMokmidsCgIVNgbbHMhK9RGEIN/FJZtbCWSrIjr+IUu6MerBXxolmeh5H9VOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(70206006)(316002)(6666004)(86362001)(82310400004)(6916009)(7696005)(508600001)(356005)(36860700001)(47076005)(40460700003)(26005)(16526019)(426003)(1076003)(2616005)(336012)(186003)(83380400001)(81166007)(8936002)(5660300002)(44832011)(36756003)(4326008)(2906002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 21:40:23.7551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f67712f8-8b4c-49f2-66aa-08da085ebe47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 11 +++--------
 2 files changed, 4 insertions(+), 9 deletions(-)

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
index 339e12c94cff..0978e1145995 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -483,15 +483,10 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	}
 
 	/* Verify module parameters regarding mapped process number*/
-	if ((hws_max_conc_proc < 0)
-			|| (hws_max_conc_proc > kfd->vm_info.vmid_num_kfd)) {
-		dev_err(kfd_device,
-			"hws_max_conc_proc %d must be between 0 and %d, use %d instead\n",
-			hws_max_conc_proc, kfd->vm_info.vmid_num_kfd,
-			kfd->vm_info.vmid_num_kfd);
+	if (hws_max_conc_proc >= 0)
+		kfd->max_proc_per_quantum = min(hws_max_conc_proc, kfd->vm_info.vmid_num_kfd);
+	else
 		kfd->max_proc_per_quantum = kfd->vm_info.vmid_num_kfd;
-	} else
-		kfd->max_proc_per_quantum = hws_max_conc_proc;
 
 	/* calculate max size of mqds needed for queues */
 	size = max_num_of_queues_per_device *
-- 
2.25.1

