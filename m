Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3F4EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 18:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B2410E499;
	Thu,  6 Jul 2023 18:19:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 212BD10E499
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 18:19:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBQxsCp5S7Fn/NF0t4nTDUH/HlP7zdAAMcWL43/teILYboS+r6GgUN8ho6nvm89kEw/talNPez51Lqj6+VNnykxoIG9ueEdRIX1AO55ksC/K/5ODcdjs4+uQv0HoRoZWmW+HXR7e4yGjPlN0loeX25Q8A2Fy2wsUrCviEVXs0dXwcmZHiIAK5awbjqZv6HWXz6ZYIqb+ep93AdmOitWljZM9mcQQdy4MEwmoultNPcpkGfxQ5s3swa4ay9k8uTpUYkKdhslFbdtAC4G/QWYNKScqPzhz81xKhlOZuuHUBHxeidM5bqCjuLmnegH0YQA72C5J/an17p0Uo1l/i4l3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PcKpfBGlRsBRaaDhmZFiZzWNvC10UKc8h44/zeGnls=;
 b=bJjbcdC/ayC8r3H5DVadHEdEnH9dvWgkMjYd3PStHlbn213xClGdfxIFaUGGJlE/hztdEaKV6EXDj4UK54lGExMmrdDjC4SwH9kzdlsBdd+QTr2Egr77L5DjpLR3QwnPdBribA6T4cy2bHCGpKEMmXHHhHmghRSTuMgGqooqsADIPG4XJI9CpxA+S84P4PpKlt/FndwJDIRsrSURfGCcPkWw/MlvnsUDavR7Awoa5mwIbjKrJEKChRnjL1Pj+cvmRAgumQnOSQNMfu1ZfEmGif8qhTqgTqN8lO2mDSBLBrj1KeGEMu6fn5r2otIgbzA0YkvXzXxybQJn8l9cVylhxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PcKpfBGlRsBRaaDhmZFiZzWNvC10UKc8h44/zeGnls=;
 b=ipcI4tdKN4dJK0WhzzE2P7wPMukE/bQOPYN76dDtrcwniBOFgCR4XjpXjVLJu1FqRDOMm/7dJuaNjFoK3xHWz/y8e/rzFv8Y+wtqBHbVDGtdLjvcpIXcI8tJ3kPp+qik0uaRVobOECjwFtoKqicTPd9GzyFq+yFE02FpbaIpC3I=
Received: from MW4PR04CA0344.namprd04.prod.outlook.com (2603:10b6:303:8a::19)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 18:19:40 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::c7) by MW4PR04CA0344.outlook.office365.com
 (2603:10b6:303:8a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 18:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 18:19:40 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 6 Jul 2023 13:19:38 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amdkfd: always keep trap enabled for GC v9.4.3
Date: Thu, 6 Jul 2023 14:19:17 -0400
Message-ID: <20230706181918.189722-6-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706181918.189722-1-jinhuieric.huang@amd.com>
References: <20230706181918.189722-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: be68742c-674e-45ec-b498-08db7e4d9076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cx7nzhq0pXzVM5+w1QmR/313MNZTLc3LD67Toqz2eJppw8SpJft87tPMf57IURdesw0YeqyKru/EZNJlqP2WK6c09JfruIsh766DTGnTq+QS573wX7rgdv6vHL7YupGjySdXzkXj6ppVBe9nWGyAbpNNoxPlr+ljzGIyRLgMXu89bvaJWG7On6Ned/94l2GUp5IzsUn3qi8kub7QLfhkmVTNX9fs6lfeAHGxQ9OIbUH55pCr84vXRxnX7JJjB1Y3rsXL/oSD/uZVkg1Mlco85vXSQfCL9mUyxhua9JO6llj3foXT+qLXN0YpM6Eryxo7o2idE0kEdrIUiRxDB6J/iIJ2CURR30GEd2tBVvtmSLMgpZor1YuTYVvDvNZwLpoYkFsT70DZM8WoUi6VpmSjApZsnIOyUVTvMghoFf6pT1a3mE1rg/RC2Xb2IqSDXmEXKNThLQ9RnugG78b6blWxA3N9QkrV+TZQjGf3AdS+DSaPdULs4nGfIOnAT+nvc9h1ndbTKn57uAme6tzR3On3aRljq/829VhB9n8LbcND0FLT1VQPvRMndhNVROdaWAQmehLTgvW8eDXVKXJIHjuv2qGhNaL4QXdejzXvcduSRyfzAPrDwe9pXHPRximu5qDowwuC81CRvYSsx7d7wPIOXiTibH153NvGccADeMPjK3N61IRKGyEryMaLPxg0hXCQKzpFd8XloMKiLAgsOfZYenjr3zd4bJBsegjsvBvhqyhRbQcd81yo3cZANVvofZqYfQvpMCDhZUE3BTOeEiRmtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(8936002)(8676002)(2906002)(70206006)(70586007)(2616005)(5660300002)(16526019)(336012)(26005)(1076003)(186003)(40480700001)(41300700001)(40460700003)(36756003)(356005)(7696005)(6666004)(82740400003)(81166007)(4326008)(83380400001)(426003)(6916009)(47076005)(316002)(36860700001)(54906003)(478600001)(82310400005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 18:19:40.2774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be68742c-674e-45ec-b498-08db7e4d9076
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Jonathan.Kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To set TTMP setup on by default.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 6 +++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index cf1db0ab3471..47c5d16677d6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2842,7 +2842,7 @@ static int runtime_disable(struct kfd_process *p)
 			pdd->spi_dbg_override =
 					pdd->dev->kfd2kgd->disable_debug_trap(
 					pdd->dev->adev,
-					false,
+					KFD_GC_VERSION(pdd->dev) == IP_VERSION(9, 4, 3),
 					pdd->dev->vm_info.last_vmid_kfd);
 
 			if (!pdd->dev->kfd->shared_resources.enable_mes)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 190b03efe5ff..4cb9b3b18065 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -591,7 +591,8 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 		pdd->spi_dbg_override =
 				pdd->dev->kfd2kgd->disable_debug_trap(
 				pdd->dev->adev,
-				target->runtime_info.ttmp_setup,
+				KFD_GC_VERSION(pdd->dev) == IP_VERSION(9, 4, 3) ?
+					true : target->runtime_info.ttmp_setup,
 				pdd->dev->vm_info.last_vmid_kfd);
 		amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ba04a4baecf2..91ae9121e2bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1644,9 +1644,9 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	p->pdds[p->n_pdds++] = pdd;
 	if (kfd_dbg_is_per_vmid_supported(pdd->dev))
 		pdd->spi_dbg_override = pdd->dev->kfd2kgd->disable_debug_trap(
-							pdd->dev->adev,
-							false,
-							0);
+				pdd->dev->adev,
+				KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3),
+				0);
 
 	/* Init idr used for memory handle translation */
 	idr_init(&pdd->alloc_idr);
-- 
2.34.1

