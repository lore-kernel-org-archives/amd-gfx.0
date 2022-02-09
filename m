Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74609C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 05:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92DFE10E2AA;
	Wed,  9 Feb 2022 05:58:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAABC10E1DA
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 05:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0MUyG7JXB7UCp+3ZNXhgp07cDooHLqe0mYMmSMMlBiyW1PIwFu0JynLPbxK5Pyl1IwTmqASm+lw3grNOu+ok6AUbUN4yqaE/Bqyfty1AxVz7BUMKB58LcBwRM9lf/LYfr+TbdTt4cKjLWAySEj0lqLO9AZVpSQtywsK45/jTOxwLMEZI1Y825eVM3vvGlzDZKvjpka9hy73Fq2SWfCQVDF+4VmIYzGdJWhrtdtt3QriPSOQT8+IoW7+Fhw6y3iabdV9A0MDjgomHICIx3d3BL+1MhMLnI7Yptde+6sb8lQPBkUZ6Sh/smFPoGy9TAMkmOoKG01NGZ5nwtfS3RoesA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3xeIvGgYDsL7BbfmlsmnukjLPx/alII7MaxtQ3S+Jw=;
 b=LzpAsjL1x1lSVPVimsqZmQW3D686bWA88SjARIQiVCAwmENSWqQd9ZSnsrklXRDSdgL9fkk33AtmrNpTo9NYows8tIsOjsp+XiWU3udmHyLp+qxZsCaeykDQ1/MOaowC2ZHpF+DbLIoZke+5V/IIer5l8AQXm6qDM11b6v6NN4hNuDwaaVL4k3v5a/8i87EwnRUbZVAS/i0+YvYgYLWcYaz3ly/N7hw4qHlvp+BSsBqp/+CgWhOb8ydcFCqwjqVOomHi0KDzHBFMHaMqE5XpL5DYQZkBvBMSaL6JY0m3KHGgFAom3Mk81Rkyj0EZtDXB568tNVKw/jX0Kb50tMMwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3xeIvGgYDsL7BbfmlsmnukjLPx/alII7MaxtQ3S+Jw=;
 b=jJkzGAsDcKsEYW6DmXiv3g39nYbPASlaUBr4iWx3RgL508crcDTxgsJ2LeMRx31sfhNws2PdNFrZbUrnCsjRT6sAPpehVVZ1Vbh2rOkSaNexCVPrvE6oiqjkYzzdvgQdAKzaAwhghZ3AjZEr5N4H+jFF+J2kJLmCwsQAwStFAvA=
Received: from BN6PR2001CA0043.namprd20.prod.outlook.com
 (2603:10b6:405:16::29) by MW2PR12MB4684.namprd12.prod.outlook.com
 (2603:10b6:302:13::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 05:58:22 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::fa) by BN6PR2001CA0043.outlook.office365.com
 (2603:10b6:405:16::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 05:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 05:58:21 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 23:58:16 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/11] drm/amdgpu: Optimize operating sysfs and interrupt
 function interface in amdgpu_ras.c
Date: Wed, 9 Feb 2022 13:56:43 +0800
Message-ID: <20220209055644.1873011-10-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209055644.1873011-1-YiPeng.Chai@amd.com>
References: <20220209055644.1873011-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95ae4004-f41f-4230-d87f-08d9eb912d7f
X-MS-TrafficTypeDiagnostic: MW2PR12MB4684:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB46840BFFC8C8071003CF52FFFC2E9@MW2PR12MB4684.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTE2372zDw90ecQanTUbqczuZUTo5GvSTnRbCCj4y0ueIs0O/NjfUuj+8ZQ4C+I2ZeB4n2WHBEH+wK0igpnV0aRc91VDKiFLAZyO3MLf5LrdOcNYKmXlbxTCE88jLuGWhirzzOe15DKkEHEBV3FGYMvOTcDuYH+69Y9Z57qmJowXJQydbHpGOChfUUeik5rFZLDeEaotd9IKE57N/uQUXqt+Q30zvO1TU6Np8sjoTMHyIbQHdFsLprqAV0HG1hTh+iX02C2vuzfmGGedtGUFhhQKfeNxYGCQB2Z9y7NrRSc3dhFwklOSq8ZrPAEg6W6SOs5Vw14H4TJN5lgKX3Hw46XDZr4c/PbMiIo1TfJCRu29X6bDY7dQ5EKemC2FAGeQ9pHyBt+9VccUJ5oRxmb2St2q2xlZhS1onc6Azi6hqig1motV+gBXJEEyHqdxPSZEzb+gdpUBQfjsTw0iWOFMoxXFF9H0FwtKvhQm+Q1EyxcZ2HsQYgFd3PXc7gB9V8WwRnKNVaS4x/PHt6TBYutd3e/OZucvRRFkko4YuH9BUOadrmclE/6+4ettY23Osu4MTIJ04OLaMCxlsQDccV/GXZhYwtqLhhcv9JNSaEYjkVae7NWHk9aywnffj0+TCCD2wYpal+l4+o3yw+enwZSqs1d+kkml8EChRPfMUg8/1AVPNXv8lb8/vouLLF66qEjC2SZeWZCe1rz1KSWA6hGlCCO0q/flF+siUm47QfvBaDI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(1076003)(186003)(16526019)(36756003)(36860700001)(40460700003)(2616005)(26005)(83380400001)(5660300002)(2906002)(426003)(336012)(47076005)(86362001)(7696005)(8936002)(8676002)(70586007)(70206006)(4326008)(82310400004)(54906003)(6916009)(6666004)(81166007)(316002)(356005)(508600001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 05:58:21.4993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ae4004-f41f-4230-d87f-08d9eb912d7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4684
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In order to reduce redundant struct conversion, modify
operating sysfs and interrupt function interface parameters.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 37 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  6 ++--
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8a76a4e07659..9f8f596663ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1276,18 +1276,17 @@ static int amdgpu_ras_sysfs_remove_feature_node(struct amdgpu_device *adev)
 }
 
 int amdgpu_ras_sysfs_create(struct amdgpu_device *adev,
-		struct ras_fs_if *head)
+		struct ras_common_if *head)
 {
-	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head->head);
+	struct ras_manager *obj = amdgpu_ras_find_obj(adev, head);
 
 	if (!obj || obj->attr_inuse)
 		return -EINVAL;
 
 	get_obj(obj);
 
-	memcpy(obj->fs_data.sysfs_name,
-			head->sysfs_name,
-			sizeof(obj->fs_data.sysfs_name));
+	snprintf(obj->fs_data.sysfs_name, sizeof(obj->fs_data.sysfs_name),
+		"%s_err_count", head->name);
 
 	obj->sysfs_attr = (struct device_attribute){
 		.attr = {
@@ -1594,9 +1593,9 @@ int amdgpu_ras_interrupt_dispatch(struct amdgpu_device *adev,
 }
 
 int amdgpu_ras_interrupt_remove_handler(struct amdgpu_device *adev,
-		struct ras_ih_if *info)
+		struct ras_common_if *head)
 {
-	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
+	struct ras_manager *obj = amdgpu_ras_find_obj(adev, head);
 	struct ras_ih_data *data;
 
 	if (!obj)
@@ -1616,24 +1615,27 @@ int amdgpu_ras_interrupt_remove_handler(struct amdgpu_device *adev,
 }
 
 int amdgpu_ras_interrupt_add_handler(struct amdgpu_device *adev,
-		struct ras_ih_if *info)
+		struct ras_common_if *head)
 {
-	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
+	struct ras_manager *obj = amdgpu_ras_find_obj(adev, head);
 	struct ras_ih_data *data;
+	struct amdgpu_ras_block_object *ras_obj;
 
 	if (!obj) {
 		/* in case we registe the IH before enable ras feature */
-		obj = amdgpu_ras_create_obj(adev, &info->head);
+		obj = amdgpu_ras_create_obj(adev, head);
 		if (!obj)
 			return -EINVAL;
 	} else
 		get_obj(obj);
 
+	ras_obj = container_of(head, struct amdgpu_ras_block_object, ras_comm);
+
 	data = &obj->ih_data;
 	/* add the callback.etc */
 	*data = (struct ras_ih_data) {
 		.inuse = 0,
-		.cb = info->cb,
+		.cb = ras_obj->ras_cb,
 		.element_size = sizeof(struct amdgpu_iv_entry),
 		.rptr = 0,
 		.wptr = 0,
@@ -1662,10 +1664,7 @@ static int amdgpu_ras_interrupt_remove_all(struct amdgpu_device *adev)
 	struct ras_manager *obj, *tmp;
 
 	list_for_each_entry_safe(obj, tmp, &con->head, node) {
-		struct ras_ih_if info = {
-			.head = obj->head,
-		};
-		amdgpu_ras_interrupt_remove_handler(adev, &info);
+		amdgpu_ras_interrupt_remove_handler(adev, &obj->head);
 	}
 
 	return 0;
@@ -2431,12 +2430,12 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 		return 0;
 
 	if (ih_info->cb) {
-		r = amdgpu_ras_interrupt_add_handler(adev, ih_info);
+		r = amdgpu_ras_interrupt_add_handler(adev, ras_block);
 		if (r)
 			goto interrupt;
 	}
 
-	r = amdgpu_ras_sysfs_create(adev, fs_info);
+	r = amdgpu_ras_sysfs_create(adev, ras_block);
 	if (r)
 		goto sysfs;
 
@@ -2452,7 +2451,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 	amdgpu_ras_sysfs_remove(adev, ras_block);
 sysfs:
 	if (ih_info->cb)
-		amdgpu_ras_interrupt_remove_handler(adev, ih_info);
+		amdgpu_ras_interrupt_remove_handler(adev, ras_block);
 interrupt:
 	amdgpu_ras_feature_enable(adev, ras_block, 0);
 	return r;
@@ -2485,7 +2484,7 @@ void amdgpu_ras_late_fini(struct amdgpu_device *adev,
 
 	amdgpu_ras_sysfs_remove(adev, ras_block);
 	if (ih_info->cb)
-		amdgpu_ras_interrupt_remove_handler(adev, ih_info);
+		amdgpu_ras_interrupt_remove_handler(adev, &ih_info->head);
 }
 
 void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 8b94b556baf6..ae8741ac526f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -619,7 +619,7 @@ int amdgpu_ras_feature_enable_on_boot(struct amdgpu_device *adev,
 		struct ras_common_if *head, bool enable);
 
 int amdgpu_ras_sysfs_create(struct amdgpu_device *adev,
-		struct ras_fs_if *head);
+		struct ras_common_if *head);
 
 int amdgpu_ras_sysfs_remove(struct amdgpu_device *adev,
 		struct ras_common_if *head);
@@ -636,10 +636,10 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 		struct ras_inject_if *info);
 
 int amdgpu_ras_interrupt_add_handler(struct amdgpu_device *adev,
-		struct ras_ih_if *info);
+		struct ras_common_if *head);
 
 int amdgpu_ras_interrupt_remove_handler(struct amdgpu_device *adev,
-		struct ras_ih_if *info);
+		struct ras_common_if *head);
 
 int amdgpu_ras_interrupt_dispatch(struct amdgpu_device *adev,
 		struct ras_dispatch_if *info);
-- 
2.25.1

