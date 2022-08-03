Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAC2C19F28
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Aug 2022 11:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F7B18A71B;
	Wed,  3 Aug 2022 11:36:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7067E12A987
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Aug 2022 11:36:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exjYwnjhuo0fzCTUIsG8NlIV++hCYYHiCKhigvFiEXFiatFFVE+m5SHnwIgOq/O+vm9kSay32raaIyRoqPTFD7WU1v+J/GZilpaJQyPXH25rnwlPPFZP/ltUZ5fllI1ydrtY53PsgBlx/O79SD3LQktLf2xHQOSvTNKxBEfyJSWsEQtsPfzokJSIHec74uLSHYJfumHg9Ku813ucAeFt72VY2ic6ZJHZ9pLy+6CTMkEjnby3WL6/umip0YdcYn6CSbHrR1OuUVhPaxb02pqTWeRPdxCpcoxgYKUPZ3choed58BQ7gLOzdxhDiHrDL2BKWLCG588T/JnaZBZwD6IZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XS8RN77pjL3ZieiKRZa+s+7VU7ESDLhpMzP1q+EsTFw=;
 b=T5yZntbHo9BTeO3YOp54MgxBQhb09X3W3hg1TC7h9mHiKpzC62mLxV8eWXUSWHruJDpMH5fJhT1m18kXEVQBqfQa3gYk5GYSbpBlB6I1p+F7dx4h2H5B1E7B77ygcznNwdGRzZzMK+xzGPuebNUwCLDb5HDrYlbKbwaBpDlStR+iyxW8dDH4MdL64Ndombvw64B0y9sBL2Hejh1Z0oDmG8mLdG8NphTrabq1TANNaoCVemnUEPcitwblJu4URsjaFBuis1yUxbprEjfCl1lD5RZaWmEwNnQ9wVd8c4UO1pK8qB1Ai9aAZQtHuC2GyrNOOooPdvXFP1yAMt+rSEOq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS8RN77pjL3ZieiKRZa+s+7VU7ESDLhpMzP1q+EsTFw=;
 b=yPl+tly05e9Ge+WZlZkfvAdu8U+osX8mx9y3z/xutp2WQEf4joKLxj//kGlvilfDA1on887Zc2tQWZqkx+ZAaVZ9zUPDzMt3/fM3K04iD5Iula2UQJL89sJcTYeh6fhJSEgvOP2vlRVUhVYwT6ep9w8CWnQ3LbMBn14b/mfq8nM=
Received: from MW2PR2101CA0033.namprd21.prod.outlook.com (2603:10b6:302:1::46)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 11:36:39 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::89) by MW2PR2101CA0033.outlook.office365.com
 (2603:10b6:302:1::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.6 via Frontend
 Transport; Wed, 3 Aug 2022 11:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Wed, 3 Aug 2022 11:36:39 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 3 Aug
 2022 06:36:36 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Avoid another list of reset devices
Date: Wed, 3 Aug 2022 17:06:20 +0530
Message-ID: <20220803113620.3591261-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef973dff-a644-4e80-6083-08da75446e23
X-MS-TrafficTypeDiagnostic: DS7PR12MB5885:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1smkrFTkzUaQw+HkcrimmwmW1BII5ToCn+i30vkTGe0gNO09QbMUSnHKnJ5ItFmKaz0MLp85eyDo/JaqB7UX05mQ7F4zbrAN+8X0/+VUxl3rMH7SrSqwSEcyGJY1LMgLNGbD63rgd/lCGNv1Ia4Hp0PHNy9Kvbrdwjxpz5sC0jf9hBJRov/WHvMsZxWS1PrTUFWrCTku1HsyPqWqOX30sl/RbFgHUTieMI0xaHu+MWGChQfq8ncgyukjfftZT8lOGgmuV5sPVpwngqpwrxOLQTZhVEX0lKA41o9OIITm5KOmNoM1iSB8GFOxdlL2WU1KBBlX27pDTUiO5GsGZPFima4ekxS9S4h+v8Ct8228uJVy0mNUDwsageY3YIrx9YWOCFq6YPQi0nBBdCpgBgQAF0QHwdZgzpZoVdCKQF5iPhEfyOnQnn+Q9+ktpPMxPVoeT2/fDnGcj4qQmS7cGTQqxvIEzZsjZJRAIj8/iQfVKVkcO4EXxbE0In9K9s9igSWdmhO4bm2J9KcCoR1gb/e9NBnN/7IQyngZVRZewS7It2AJ2H7QzLbBigXJc5PG2KcWTt0es7Sai9CZ7o4SoJntwWiA2YutlU614DM8AMt0qeJW2s9koAjHn52c/bze9GejbefWvFt4FI1S2hewrYFksvkRvxowTdlqPKW5xwT3cHI8kLFoZ15kZoFGRhQWCoaH0zbuXfCS+ze9dhQP/xqfhjakDpPc8DQdGKR6RDp+bWJWLqSVmb3wk/YsY9vTFCI5z92/nNR/JvHfcWmG5YKkJKiK0N8P198le0cDENEoqw9JEyJR3sgt0vnvJ5UmX4hBjxB+KKaqIjZWpfTHpKUzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(40470700004)(46966006)(36840700001)(7696005)(83380400001)(86362001)(41300700001)(44832011)(6666004)(2616005)(82740400003)(16526019)(186003)(356005)(82310400005)(1076003)(26005)(426003)(2906002)(47076005)(81166007)(336012)(316002)(4326008)(8676002)(36756003)(70206006)(70586007)(40460700003)(40480700001)(8936002)(6916009)(5660300002)(478600001)(54906003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 11:36:39.0509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef973dff-a644-4e80-6083-08da75446e23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A list of devices to be reset are already created in
amdgpu_device_gpu_recover function. Creating another list with the
same nodes is incorrect and not supported in list_head. Instead, pass
the device list as part of reset context.

Fixes: 9e08564727fc (drm/amdgpu: Refactor mode2 reset logic for v13.0.2)
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c     | 45 +++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  1 +
 3 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index c6cc493a5486..2b97b8a96fb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -148,30 +148,22 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
 			      struct amdgpu_reset_context *reset_context)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+	struct list_head *reset_device_list = reset_context->reset_device_list;
 	struct amdgpu_device *tmp_adev = NULL;
-	struct list_head reset_device_list;
 	int r = 0;
 
 	dev_dbg(adev->dev, "aldebaran perform hw reset\n");
+
+	if (reset_device_list == NULL)
+		return -EINVAL;
+
 	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2) &&
 	    reset_context->hive == NULL) {
 		/* Wrong context, return error */
 		return -EINVAL;
 	}
 
-	INIT_LIST_HEAD(&reset_device_list);
-	if (reset_context->hive) {
-		list_for_each_entry (tmp_adev,
-				     &reset_context->hive->device_list,
-				     gmc.xgmi.head)
-			list_add_tail(&tmp_adev->reset_list,
-				      &reset_device_list);
-	} else {
-		list_add_tail(&reset_context->reset_req_dev->reset_list,
-			      &reset_device_list);
-	}
-
-	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
+	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 		mutex_lock(&tmp_adev->reset_cntl->reset_lock);
 		tmp_adev->reset_cntl->active_reset = AMD_RESET_METHOD_MODE2;
 	}
@@ -179,7 +171,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
 	 * Mode2 reset doesn't need any sync between nodes in XGMI hive, instead launch
 	 * them together so that they can be completed asynchronously on multiple nodes
 	 */
-	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
+	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 		/* For XGMI run all resets in parallel to speed up the process */
 		if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
 			if (!queue_work(system_unbound_wq,
@@ -197,7 +189,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
 
 	/* For XGMI wait for all resets to complete before proceed */
 	if (!r) {
-		list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
+		list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
 				flush_work(&tmp_adev->reset_cntl->reset_work);
 				r = tmp_adev->asic_reset_res;
@@ -207,7 +199,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
 		}
 	}
 
-	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
+	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 		mutex_unlock(&tmp_adev->reset_cntl->reset_lock);
 		tmp_adev->reset_cntl->active_reset = AMD_RESET_METHOD_NONE;
 	}
@@ -339,10 +331,13 @@ static int
 aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 				  struct amdgpu_reset_context *reset_context)
 {
+	struct list_head *reset_device_list = reset_context->reset_device_list;
 	struct amdgpu_device *tmp_adev = NULL;
-	struct list_head reset_device_list;
 	int r;
 
+	if (reset_device_list == NULL)
+		return -EINVAL;
+
 	if (reset_context->reset_req_dev->ip_versions[MP1_HWIP][0] ==
 		    IP_VERSION(13, 0, 2) &&
 	    reset_context->hive == NULL) {
@@ -350,19 +345,7 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 		return -EINVAL;
 	}
 
-	INIT_LIST_HEAD(&reset_device_list);
-	if (reset_context->hive) {
-		list_for_each_entry (tmp_adev,
-				     &reset_context->hive->device_list,
-				     gmc.xgmi.head)
-			list_add_tail(&tmp_adev->reset_list,
-				      &reset_device_list);
-	} else {
-		list_add_tail(&reset_context->reset_req_dev->reset_list,
-			      &reset_device_list);
-	}
-
-	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
+	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 		dev_info(tmp_adev->dev,
 			 "GPU reset succeeded, trying to resume\n");
 		r = aldebaran_mode2_restore_ip(tmp_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c4a6fe3070b6..e8a0b19b7398 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4742,6 +4742,8 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
 				    reset_list);
 	amdgpu_reset_reg_dumps(tmp_adev);
+
+	reset_context->reset_device_list = device_list_handle;
 	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
 	/* If reset handler not implemented, continue; otherwise return */
 	if (r == -ENOSYS)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 9e55a5d7a825..ffda1560c648 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -37,6 +37,7 @@ struct amdgpu_reset_context {
 	struct amdgpu_device *reset_req_dev;
 	struct amdgpu_job *job;
 	struct amdgpu_hive_info *hive;
+	struct list_head *reset_device_list;
 	unsigned long flags;
 };
 
-- 
2.25.1

