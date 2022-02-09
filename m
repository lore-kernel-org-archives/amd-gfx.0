Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2192BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 05:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8FF510E20B;
	Wed,  9 Feb 2022 05:58:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81DC010E2AD
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 05:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S21Pmpg3tEIxjCOHi3UHaQlNq6piTjYd6fWAmfiKG9+ibKhw5a6XqoVMpwyWgu+I1ikXWrhAj1vgW9rrezXp1r1AkT3kCE50SDcqGBYrjnOjgqeWAFPUu8HDNH9/bol6hYxvBIgWdZrwfdj2t5f8LcdMwwb6TyNEClk+AiG9b35D8ow0VJJh0nwq11vGoB+SKMLJPWPLauP5Sp39QFQ2qcXwFnD2+nkKES8JQKDotz3pjMibatczC1xUzcUwDll7vj8gqbHFrxgUG8xDBCFcQo9R55hOf7kyFj1xQ/UjUP9YB/OoWgWsE1sJv7rMYnpj6vO+GKL/xU+MZyuZUjKAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGIBaq4nIWiHJc5Bfv2CdakPYVzKDOXqlsLPlbBDmoQ=;
 b=FzRZVpUVilmFJ/inhsdf0OgI9/TYRzGew/kXfnFdUR9W4h4Uts1qdnKalHCx7hwRq0rUX7ZvdBI67LF0NIcjIuuZMG8ih5MLHI9cl1tB0UVDjIkIFKWhQWeARrd+dy7gyJ7mvvdWBr/6hnbQaVAhu02KYhREgarcUpuGieA0JqrmGJF5xyChM1K/lwQLrgYVO9+aczMYC9qYdE+v824ES5xwt4xiLPLZd6x7SjAWZnB6Pj95X6Ezy2MFFgdBfNNireyrCv8sAFb+oB7Wk7xylVOHUJTK3bnWGxZZIYAdR+hdvcslz1pq6pyMF6HnUMDElDulzLBtnaSBZxzTcVUsdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGIBaq4nIWiHJc5Bfv2CdakPYVzKDOXqlsLPlbBDmoQ=;
 b=xYD2zJRtHstisBIjDMgxYJXwABy3tqNcRIDGgqkQhH74QpWgBV16mtz+xVNyIbYkfldyPiR3KAXAX0Arh7bJPelFGvFWBeaGNkgklQccYEzI4UUw/LQaxJAL2AP2RVnISEUxyTBW0PzKg+Ax19t9vscEEYA0X3KBx+XTW0YQZl4=
Received: from BN6PR2001CA0025.namprd20.prod.outlook.com
 (2603:10b6:405:16::11) by CH2PR12MB4808.namprd12.prod.outlook.com
 (2603:10b6:610:e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 05:58:23 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::7d) by BN6PR2001CA0025.outlook.office365.com
 (2603:10b6:405:16::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Wed, 9 Feb 2022 05:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 05:58:23 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 23:58:18 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/11] drm/amdgpu: Merge
 amdgpu_ras_late_init/amdgpu_ras_late_fini to
 amdgpu_ras_block_late_init/amdgpu_ras_block_late_fini
Date: Wed, 9 Feb 2022 13:56:44 +0800
Message-ID: <20220209055644.1873011-11-YiPeng.Chai@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 458b457f-004c-425a-648c-08d9eb912e94
X-MS-TrafficTypeDiagnostic: CH2PR12MB4808:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4808BF48B1C8573613CD1DBDFC2E9@CH2PR12MB4808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t101drI0tL4tHIwGPOfrDgsMDjfC6j/SF+V5cFav1KtYopfKS1R+NEuLoc52u+anYkV1IrgbdG15rH0jlDvpC0jgyWZQ31h0zHuxW0Dlf/YvIYSExgp+u1hciF2PBlSdMpoiAa46HwDGAjpwWzr8C5J185wh0pNGEmFwUiqKfsF5/RGvz0QmE70eNbjAz+fQf5DpceIjfE63oCsekKqAEzFY8Dy0Z16aV4nZTWIo0Fwnr2Y7AJit9wsxyjoG0Cmg1WOlq8/+RmUOqtX6dP9F/n8xWO68QDkXreTMvZXb/LPofrxgoY+TVN9e3RW4oaUjVHVjxFFzMy3khjRbmnPOa4NFaS+gCWOdU+9mdy0F9m9ymGOXGuzsOZqxW9f+L+bi082mbE79ubp+TMN33JP0jJwXp4EPQFk/mTex1gdvLHeHcCOLj2/KX+ylVyWgQRQUzDd68CHPyTrVfQt4i4N5BihyUl6YK0ixA6eptZinvbTVTVzrNpHyyJ4jvAKPFCXguzsSN3PK+lmhr9Nx7AzDsQBHno5NOUQzRKmEyATZ2iCO1fetGlDxafP2nBHJmZK76JJKRPookRZphWqGviiQlCV9uQukJzlGbTrIJO3tVnTE7FRmKLBhcCHjgPblglRAvI301dX44qKWPa4VttmHMdSFezPLrAxHDTLqKHNnq20D7E09/tkK80TKbi8ozGNRneEHA+//31C8egNHM0M9yjy1MH5oicKQ8qh9wYgWKXI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(47076005)(83380400001)(16526019)(2616005)(40460700003)(36860700001)(54906003)(6916009)(70206006)(70586007)(4326008)(186003)(1076003)(8676002)(2906002)(26005)(7696005)(8936002)(81166007)(498600001)(6666004)(426003)(36756003)(356005)(86362001)(336012)(82310400004)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 05:58:23.3273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 458b457f-004c-425a-648c-08d9eb912e94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4808
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

1. Merge amdgpu_ras_late_init to
   amdgpu_ras_block_late_init.
2. Remove amdgpu_ras_late_init since no ras block
   calls amdgpu_ras_late_init.
3. Merge amdgpu_ras_late_fini to
   amdgpu_ras_block_late_fini.
4. Remove amdgpu_ras_late_fini since no ras block
   calls amdgpu_ras_late_fini.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 53 +++++--------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  8 ----
 2 files changed, 11 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9f8f596663ab..1aff88fcea76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2397,11 +2397,10 @@ bool amdgpu_ras_is_poison_mode_supported(struct amdgpu_device *adev)
 }
 
 /* helper function to handle common stuff in ip late init phase */
-int amdgpu_ras_late_init(struct amdgpu_device *adev,
-			 struct ras_common_if *ras_block,
-			 struct ras_fs_if *fs_info,
-			 struct ras_ih_if *ih_info)
+int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
+			 struct ras_common_if *ras_block)
 {
+	struct amdgpu_ras_block_object *ras_obj;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	unsigned long ue_count, ce_count;
 	int r;
@@ -2429,7 +2428,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 	if (adev->in_suspend || amdgpu_in_reset(adev))
 		return 0;
 
-	if (ih_info->cb) {
+	ras_obj = container_of(ras_block, struct amdgpu_ras_block_object, ras_comm);
+	if (ras_obj->ras_cb) {
 		r = amdgpu_ras_interrupt_add_handler(adev, ras_block);
 		if (r)
 			goto interrupt;
@@ -2450,57 +2450,26 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 cleanup:
 	amdgpu_ras_sysfs_remove(adev, ras_block);
 sysfs:
-	if (ih_info->cb)
+	if (ras_obj->ras_cb)
 		amdgpu_ras_interrupt_remove_handler(adev, ras_block);
 interrupt:
 	amdgpu_ras_feature_enable(adev, ras_block, 0);
 	return r;
 }
 
-int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
-			struct ras_common_if *ras_block)
-{
-	char sysfs_name[32];
-	struct ras_ih_if ih_info;
-	struct ras_fs_if fs_info;
-	struct amdgpu_ras_block_object *obj;
-
-	obj = container_of(ras_block, struct amdgpu_ras_block_object, ras_comm);
-	ih_info.cb = obj->ras_cb;
-	ih_info.head = *ras_block;
-	snprintf(sysfs_name, sizeof(sysfs_name), "%s_err_count", ras_block->name);
-	fs_info.sysfs_name = (const char *)sysfs_name;
-	fs_info.head = *ras_block;
-	return amdgpu_ras_late_init(adev, ras_block, &fs_info, &ih_info);
-}
-
 /* helper function to remove ras fs node and interrupt handler */
-void amdgpu_ras_late_fini(struct amdgpu_device *adev,
-			  struct ras_common_if *ras_block,
-			  struct ras_ih_if *ih_info)
-{
-	if (!ras_block || !ih_info)
-		return;
-
-	amdgpu_ras_sysfs_remove(adev, ras_block);
-	if (ih_info->cb)
-		amdgpu_ras_interrupt_remove_handler(adev, &ih_info->head);
-}
-
 void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
 			  struct ras_common_if *ras_block)
 {
-	struct ras_ih_if ih_info;
-	struct amdgpu_ras_block_object *obj;
-
+	struct amdgpu_ras_block_object *ras_obj;
 	if (!ras_block)
 		return;
 
-	obj = container_of(ras_block, struct amdgpu_ras_block_object, ras_comm);
-	ih_info.head = *ras_block;
-	ih_info.cb = obj->ras_cb;
+	amdgpu_ras_sysfs_remove(adev, ras_block);
 
-	amdgpu_ras_late_fini(adev, ras_block, &ih_info);
+	ras_obj = container_of(ras_block, struct amdgpu_ras_block_object, ras_comm);
+	if (ras_obj->ras_cb)
+		amdgpu_ras_interrupt_remove_handler(adev, ras_block);
 }
 
 /* do some init work after IP late init as dependence.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index ae8741ac526f..5de567c6a8f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -597,18 +597,10 @@ amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type error) {
 int amdgpu_ras_init(struct amdgpu_device *adev);
 int amdgpu_ras_fini(struct amdgpu_device *adev);
 int amdgpu_ras_pre_fini(struct amdgpu_device *adev);
-int amdgpu_ras_late_init(struct amdgpu_device *adev,
-			 struct ras_common_if *ras_block,
-			 struct ras_fs_if *fs_info,
-			 struct ras_ih_if *ih_info);
 
 int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 			struct ras_common_if *ras_block);
 
-void amdgpu_ras_late_fini(struct amdgpu_device *adev,
-			  struct ras_common_if *ras_block,
-			  struct ras_ih_if *ih_info);
-
 void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
 			  struct ras_common_if *ras_block);
 
-- 
2.25.1

