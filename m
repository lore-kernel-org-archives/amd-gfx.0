Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03584EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 17:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A56AE10E036;
	Fri, 16 Jun 2023 17:59:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6557C10E036
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 17:59:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8bFkYs0nA73/iLf0sIfcXUIJLdI+HYvSjOg7vAhpFoTHABA0vOpZN9FpjCP4Gy+gHRlsRW84pulKJjyWFcbBEaNTT0nkK8ljbcJ+nSE0fVcYWWaQphLJYsx3Ld4XN0YwEibn8PFkgjpdhTJgkVIvhKMf+t26ldI08GG36xrBowTzwYc4qwBV0OUX0DIkIj84Naj8xdHpi+lkFKFx/GUsTR6bTUrQw1lYl+PfldrUwNJD6XVQk7yDqGz6z0yISu6ujW3X8vZfTRRFJrDjCRxDMkZdbJwDqIYoquPJlBuJu0yNWdar09vot2Z50noeoh7rP0moVZCIxorx5oplPP/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkYkXmYKX3CdRqG9RH/oNzv6vDIEAXQyV22VIJeHGV8=;
 b=BAp/DzsYcbF9zruVRFaxyJFHDK2Tq6qezWVpYGaNUoP+a8NmxYmo2b44gEY40tg19jvAHazJRli1v1CdLLSkV7syg+9vHie/irr3J7Tryu/U93EfPupafJQ2FrG1JXNrDaNf0i3ToY5ltweETAAq84EhG1u9gF6O/qxCSj16tjq7whQEyXUL1h2YTwQsRQvjXpaREMhI3QA0jbRF2r0MQzwVr04mFBP0ogzEimaGolsXOyWb/HjRSMIyzzNVzqrxO7qerxvIi/AL4L7LEf+fwki35MAq/hp2moah/vUuD1uw0UVowsVaheTH5dcH4LsftRP1ztvqI5PV/ciNGbNHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkYkXmYKX3CdRqG9RH/oNzv6vDIEAXQyV22VIJeHGV8=;
 b=sSDlvV871Wm451gBrUWJbVHAuSeiPgJNCEBaGsM3cyGR+dF4H3D7uZrpOWcPNJjm1U/1DbRXo8+Gx9hSopi0BmeIbHoyl584NS8SNEMoTvyM4NAJVMgiCJL+iNgfcTRqrsUBk4v0kK3zoIJlQtJCrNwX0AO4g4oqyHMweGWTwk4=
Received: from MW4PR04CA0050.namprd04.prod.outlook.com (2603:10b6:303:6a::25)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 17:59:49 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::d3) by MW4PR04CA0050.outlook.office365.com
 (2603:10b6:303:6a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Fri, 16 Jun 2023 17:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Fri, 16 Jun 2023 17:59:48 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 12:59:46 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Enable GWS on GFX9.4.3
Date: Fri, 16 Jun 2023 13:59:29 -0400
Message-ID: <20230616175929.1269698-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e03194d-7a40-4787-b3f1-08db6e937a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbayr7j22mN0eWhizqUn64AKBlyb+ywMI1LZ2RwFWp85XvD+eKERprk+oV8CQkgIEvEoICmSFSdfYP6Fko86r/OCHAeuHYd5cNRK9C3wsmIXkvXyWAaegwdPT6tO9EODuVqHRKKsi0dCcsNe1Tjq0F8FdMbODbx54m1JHVkq7X32s5MNV+TKIBdVLHjwpyLffhPe5n3BhhAL/DGozFeS1q3KJp78fHwJx60E0uyWMWCc6qaq9FPcilr1wehp9doHnFUiAOojynEpzmTMjLWgKsjziSPo6e04zPyg3xcTi3b5jI1kmTPUiXkGhdorzn3A1yylUZAY7krzuzFa4x6IMUP7o0Iii1y2ZPxeUEM1fd7B08NUnNT/j/lO49KObkhOyWIs7z6pABwwCPy64tDWjFugeYEbl/iwLb+VSYHZP2yA9v3Inz38TcpEsEcGgu1W1AcsiGc8Ve1XGvCiWW0ekUXtcZwjsXL+pRIDuaGAfduHNbubYZc/5vUXShmP7kNNIgVAjYeS2GaCF81OPL9txdWiEP/Za0J1Ok/xsTJC8kzV025n5gvIcaRMtqK3p2OK4JchCpeDtXLpkJnpRb1iprwaqbRw9kBnHbijPonm25HmR/+9dUVXDjw2r/fLYJZsXK91Tv7e0IcXQJP007dKfwXu/6+CwYtPP8cpGNdWEEY09cxn30CEc10C156gZrl45oNxRuBFm6QiaNo/Tx5uFsZr+MfoH6yn4pZjn4s2GTKEzCjYtpKwh5C3U05dyNfCcXaJTYrDnyunZjNPBsuWMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(1076003)(36756003)(478600001)(16526019)(26005)(186003)(40480700001)(6666004)(40460700003)(7696005)(2906002)(8936002)(316002)(41300700001)(8676002)(44832011)(86362001)(81166007)(356005)(82310400005)(82740400003)(5660300002)(426003)(54906003)(47076005)(83380400001)(2616005)(70586007)(70206006)(6916009)(4326008)(336012)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 17:59:48.9731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e03194d-7a40-4787-b3f1-08db6e937a1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable GWS capable queue creation for forward
progress gaurantee on GFX 9.4.3.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  1 +
 .../amd/amdkfd/kfd_process_queue_manager.c    | 31 ++++++++++++-------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9d4abfd8b55e..226d2dd7fa49 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -518,6 +518,7 @@ static int kfd_gws_init(struct kfd_node *node)
 			&& kfd->mec2_fw_version >= 0x30)   ||
 		(KFD_GC_VERSION(node) == IP_VERSION(9, 4, 2)
 			&& kfd->mec2_fw_version >= 0x28) ||
+		(KFD_GC_VERSION(node) == IP_VERSION(9, 4, 3)) ||
 		(KFD_GC_VERSION(node) >= IP_VERSION(10, 3, 0)
 			&& KFD_GC_VERSION(node) < IP_VERSION(11, 0, 0)
 			&& kfd->mec2_fw_version >= 0x6b))))
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 9ad1a2186a24..9a091d8f9aaf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -123,16 +123,20 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 	if (!gws && pdd->qpd.num_gws == 0)
 		return -EINVAL;
 
-	if (gws)
-		ret = amdgpu_amdkfd_add_gws_to_process(pdd->process->kgd_process_info,
-			gws, &mem);
-	else
-		ret = amdgpu_amdkfd_remove_gws_from_process(pdd->process->kgd_process_info,
-			pqn->q->gws);
-	if (unlikely(ret))
-		return ret;
+	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3)) {
+		if (gws)
+			ret = amdgpu_amdkfd_add_gws_to_process(pdd->process->kgd_process_info,
+				gws, &mem);
+		else
+			ret = amdgpu_amdkfd_remove_gws_from_process(pdd->process->kgd_process_info,
+				pqn->q->gws);
+		if (unlikely(ret))
+			return ret;
+		pqn->q->gws = mem;
+	} else {
+		pqn->q->gws = ERR_PTR(-ENOMEM);
+	}
 
-	pqn->q->gws = mem;
 	pdd->qpd.num_gws = gws ? dev->adev->gds.gws_size : 0;
 
 	return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
@@ -164,7 +168,8 @@ void pqm_uninit(struct process_queue_manager *pqm)
 	struct process_queue_node *pqn, *next;
 
 	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
-		if (pqn->q && pqn->q->gws)
+		if (pqn->q && pqn->q->gws &&
+		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3))
 			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
 				pqn->q->gws);
 		kfd_procfs_del_queue(pqn->q);
@@ -446,8 +451,10 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 		}
 
 		if (pqn->q->gws) {
-			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
-				pqn->q->gws);
+			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3))
+				amdgpu_amdkfd_remove_gws_from_process(
+						pqm->process->kgd_process_info,
+						pqn->q->gws);
 			pdd->qpd.num_gws = 0;
 		}
 
-- 
2.35.1

