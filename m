Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CCFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 16:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3D81EB64E;
	Tue,  7 Dec 2021 16:57:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A360EB432
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 16:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uwchylpg5FF3JN1XZxzckphusI2Yl6/oc/E250aJ7ZDMpNjs4AKvAz4LOdw/QUvVg2xTNJl7yGi3H6u9w0nA0pNEuWRiWilB11hzn9lZC7BWXbAZeQm0CDmUxh71zTkP98U4QgZFiQQhnziJIMeraD+YZw6DESea7zz6OPusFQpZmf9m9Oz+4dqFboqQxAw3z3iVFS0NayZZqQSxGyApVPQySFZAomTJxTQ3MM/6wBUC9i9mgT46MxOsdjSs9TAejMJdS8zcl3faC4g8/u0rrI0QgtSEpk+yL2pxlfxQ2wF2okbYJu/xhlqAU+Y1JBTT1yLjvktt1z1WGJEBxob0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICow3tvH7rq34Z/A/0OawARHqWfIlAS40fSys9YOl1U=;
 b=WFhxpMaXYY6hSUdfjAzi5ptwh32ONXaxUMi6dlHVLMPMrNCrIQCMdVPhTofJ1vTGzfLrY2DiJcOJEDt0pEknSXE88DNgk3cKpebZHOIg9j5BxJo/2pndAc1l+RKzwWqv1pLd2aI66LjQcbOdZ0Wr2sdVzKaxZ5pesKU9gKoCT7QhtpkkXPsgmoDOzvSwlqXFcudCI1G4VWFDgzteVQT7itvb/zt0K5uFpB8C58PA5TUzxNh5D7PiXYY87hPzQ9yo2qk5bY0bNTMHqAhMWn9/m+ihIfE/gerCFK2MC03W46Dm/ziOilnr3PU64ghasrhai4vyM6zU5ANve4RkbQsFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICow3tvH7rq34Z/A/0OawARHqWfIlAS40fSys9YOl1U=;
 b=AixcDqJok67Px/onQ4HRHolYCrVQJde25mkVHRBUuUi2ecGPAHSUQEKQRnEycwD8cd030AXQIyJcriKpJYzxMkeHbu4gQls/3wnTHyKGJSyp0xXQy8ITbfmTM1aHs8ZO68/JiNy2ehvO7K5iRKOIM0DI72PWZX5ZiafU6SAKe94=
Received: from DM5PR18CA0075.namprd18.prod.outlook.com (2603:10b6:3:3::13) by
 BYAPR12MB3351.namprd12.prod.outlook.com (2603:10b6:a03:de::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.16; Tue, 7 Dec 2021 16:57:45 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::27) by DM5PR18CA0075.outlook.office365.com
 (2603:10b6:3:3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Tue, 7 Dec 2021 16:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 16:57:45 +0000
Received: from Zhigang-WS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 10:57:44 -0600
From: Zhigang Luo <zhigang.luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: skip reset other device in the same hive if
 it's SRIOV VF
Date: Tue, 7 Dec 2021 11:57:24 -0500
Message-ID: <20211207165727.25109-1-zhigang.luo@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 869972ce-a615-49a2-3db9-08d9b9a2b0fe
X-MS-TrafficTypeDiagnostic: BYAPR12MB3351:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3351985F9CD6BECB60B197DAF16E9@BYAPR12MB3351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUltshiJKoFKhK9o4fMsUGgrYl/1mf3wXeNbffRR42Z+IEyuJUa1SQuYY4QpNdUOM52Lqn1uYUgTUhMyFXJigLYFtQhySjN2plbmgJbsxu9KTp+95Z3od5MxU4VFLaEKtWjq9lUkO33mtc4oVObA5LokkNxzB/BkM7d63GFn1XCYuw0J46/zpxUpd8Hn5OtALx6BnydijpyYJm2lL4Evuc/NBhQe8uTRP52MDQ8mawtyoyRpJ3/UlDqghaISKmr6b7drGYHYhqHsijDinREbAmzM+JSxO6b/CFTC8ZXjHTMZ3lxudVgBbtus3/AExmKUYslEsx8lQkFX7Wpkjr+5ez8F3VBwrSviIuD9lEf75ThDTrLa75CAjj9iPSd1/7ymzcv8P2nK+/xDg9rBfTwqZUnudI/rUbpBu0mZCZQ4cE04vsFjKJqn/aDYXrjkvDofC/ULcvrg0lPIbhXPBF4JjPgSkYy/PgC2GtdJbOY26cKOZXU1gET6z850cWBHUnqvWja1XelNUhGtdtcShe2+MyaFIrrfTcG6op0qn28u10x0zt+YQVISilfQasgq6IExtiWQB0ositF12x9RSeqSN7RC5N5YUxU8rXTAzueiS+1VHXMV7xWQ4xFzjx/dXvLAPszARNMB2UAM2MIkka5CWBhj9GVZg+YnkAsu0jpyEY6DdhEdJArjiJRHZ/R4/ou8Syjpy5miKzJD1iTPPGBzMTbFWiYrcHxycMXAjHKo66vizr42p5cNuyFb1/fG9CDA50K/hIdasDS7vWJ3zGb8c+GJahMnAuZc8s25h1cxXMg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(82310400004)(83380400001)(36756003)(356005)(81166007)(40460700001)(70586007)(86362001)(70206006)(47076005)(1076003)(8936002)(186003)(8676002)(26005)(16526019)(36860700001)(7696005)(44832011)(426003)(336012)(4326008)(2616005)(2906002)(5660300002)(6666004)(316002)(6916009)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 16:57:45.4139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 869972ce-a615-49a2-3db9-08d9b9a2b0fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3351
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
Cc: Zhigang Luo <zhigang.luo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On SRIOV, host driver can support FLR(function level reset) on individual VF
within the hive which might bring the individual device back to normal without
the necessary to execute the hive reset. If the FLR failed , host driver will
trigger the hive reset, each guest VF will get reset notification before the
real hive reset been executed. The VF device can handle the reset request
individually in it's reset work handler.

This change updated gpu recover sequence to skip reset other device in
the same hive for SRIOV VF.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3c5afa45173c..474f8ea58aa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4746,7 +4746,7 @@ static int amdgpu_device_lock_hive_adev(struct amdgpu_device *adev, struct amdgp
 {
 	struct amdgpu_device *tmp_adev = NULL;
 
-	if (adev->gmc.xgmi.num_physical_nodes > 1) {
+	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1)) {
 		if (!hive) {
 			dev_err(adev->dev, "Hive is NULL while device has multiple xgmi nodes");
 			return -ENODEV;
@@ -4958,7 +4958,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * We always reset all schedulers for device and all devices for XGMI
 	 * hive so that should take care of them too.
 	 */
-	hive = amdgpu_get_xgmi_hive(adev);
+	if (!amdgpu_sriov_vf(adev))
+		hive = amdgpu_get_xgmi_hive(adev);
 	if (hive) {
 		if (atomic_cmpxchg(&hive->in_reset, 0, 1) != 0) {
 			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
@@ -4999,7 +5000,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * to put adev in the 1st position.
 	 */
 	INIT_LIST_HEAD(&device_list);
-	if (adev->gmc.xgmi.num_physical_nodes > 1) {
+	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1)) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
 			list_add_tail(&tmp_adev->reset_list, &device_list);
 		if (!list_is_first(&adev->reset_list, &device_list))
-- 
2.17.1

