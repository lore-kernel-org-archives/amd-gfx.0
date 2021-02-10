Return-Path: <SRS0=kdbD=HM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28D6C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 16:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B425264E08
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 16:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B425264E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A7486EC9A;
	Wed, 10 Feb 2021 16:06:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E1156EC9A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 16:06:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLuQEW8Ghqu8yUHkwVMSPGeBT5p2evKqzxd0uiheP7T1qxBJAziYR4nKshowlvTFOz3svgRF1bb58Mjn9kci6wUpKBIv6vW/Hh2C94HfOAhT7/KzuCpBXbNJUQPLoqJ+bi4OtobjQEKnCcH8OxpWjydk6PuCLgD0VN8uUT/DXXLedDdp4aXCmtBzLyWEB2i7ZSMZCreFazeMv6nfZBEdwdSp58JtkUZWSCAEbFV4tAGoUbPCDbqJSUP8R4mhcPEkvL4VdU7iXrH6edmq59VYZyKVvLMS4C1YV+oyJfuEOp7bmwixWxuOm6aMNsttaxS49lIxoB3B1MdwnJew5T9BMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gh2tt/6t+1Ocb/0Tc6bIiVEBwydYbmmsqUkOiIyIV5c=;
 b=FXfxSFH1v+YkYo6UGet7m+i3TTldGuZV27Ez1ZuIXSQvbm1jfsfzJKr20la7f3CS2puBdD+hEnLoOA1V+TuqjKEoEoLOnKV4hBgchSIBdZ2QHDBNwex5Vg8RCQwlblhBFH5EB6E34dCjzWEHfFl5CpWCqTd+LzQeC72XJBovR7Y2gvTGbrRGo7rs5CtOACfRbCSlg18LAZMupcjW6LZm5DU2kL47nFJQ/iyp31CpKqNrhufu/3iiOsV2eUegnsyE8bZRAnpEEq9mUl+odhHXguTrXCsRSN3vo2eo3YfVr5lcrypDkN7FgVxAfQ6Eqvb6JzhBhHTl4faxe+fC86PqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gh2tt/6t+1Ocb/0Tc6bIiVEBwydYbmmsqUkOiIyIV5c=;
 b=uS8X+M6DRsul+byGylRdc5RWZ/5CiAvJyVYdGz1OvVAiF3qE8VygROhirlI4X3nWiFTIM0RsGPpGpUcQsFNomTEzLgmDUGmx5846tx9bkHP6ZL9ZkfpuiQsjzHtIrDyIb3l9Sd+U+MyxseUJ9AmCUKKHCVfITzlSc4dad5iWgsw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 10 Feb
 2021 16:06:15 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.027; Wed, 10 Feb 2021
 16:06:15 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/2] drm/amdgpu: do not keep debugfs dentry
Date: Wed, 10 Feb 2021 17:06:01 +0100
Message-Id: <20210210160602.15903-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [217.86.120.56]
X-ClientProxiedBy: AM0PR04CA0060.eurprd04.prod.outlook.com
 (2603:10a6:208:1::37) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.120.56) by
 AM0PR04CA0060.eurprd04.prod.outlook.com (2603:10a6:208:1::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.27 via Frontend Transport; Wed, 10 Feb 2021 16:06:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1edf370b-d5af-4173-11e5-08d8cdddcb1b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4138:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4138BE190CA4E28D135FD3B88B8D9@DM6PR12MB4138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSsyvPX6I2p6YMVRYxu1Hc2sudLt/5xHVptION4+YhxPwTGyX0v9IBRLAadPOXMJEkh4feURSfCkOoGMDQxahR4SagrqqGhvqgafbUpfTEyykIsgpSaXOfw5Q6EMoGcrPJ/P9buX6jT/e4hb6bUBE4SAubTWs6bm9SAKmwTcU4RpYbr7Wv8Vz/BEQA5LKcs5ghhSpiYXHcuTCXDeFIL4CdH/ZaOBSe4b6BWn9a9ShIwntN1+L4wvx4PwdUQyn9IaAfqhIR9ZJYCbzpK/V9nxhzKcxGf5oVkw8akfD5HdwErthDbNk+skR4+8kLJaMnjrao6G8uq3q2gR7ZxL4rBjVtkeXTSAHnA26UWm9eORjI5cA7nMscPgy4s/EZwqFsF4767pU32chgNYr/EbAb9fVX5KM8jKjA4P2XhwvkANqYTlC+9AgX3g9fUr7zfnjEckPRr+Oy7bhIw59EE5aDw+V0P2Qgjru6KlMO/Yld/cmtphMQvTlcatOxFHMhPsVgsePLaIdXdEVkyWSI2NM7krZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(26005)(83380400001)(6506007)(34206002)(16526019)(186003)(316002)(4326008)(5660300002)(6486002)(36756003)(478600001)(6636002)(66556008)(66476007)(66946007)(6666004)(8936002)(52116002)(6512007)(2906002)(86362001)(44832011)(8676002)(37006003)(1076003)(2616005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QFou/wZvviShw/5aXZu5JbqZt2vYw5GTqagCp/6ScWD1VSF1ki2GJefJF2Sl?=
 =?us-ascii?Q?IFPUf30ArF8Qztdgi+oyYQG9mpRzYPIyF6E+VNPfev+Q3DorGv6ml4Krg/9e?=
 =?us-ascii?Q?4zJ0w/dcQk6emlxAAYEc/nLn8xTQH2B4mZHDa4dfyx/vw1bxObpn7HE48DaI?=
 =?us-ascii?Q?B+vFJHQ84xnDIN6w4NaBpqtbU3mMep8TzTUqJVu2onImK5xaH6SMjI00L0v+?=
 =?us-ascii?Q?iuABs+qqfFChaGXShh1dKlCjNMZlDkdcejpGrvIB5PR9O7dOsvUNOzBmOHwB?=
 =?us-ascii?Q?PF3Ce5nDyX+HYvVzHCVms6l43AGZNMI7zq2LYp9tx7N0Czm/IX3DhobCHWTn?=
 =?us-ascii?Q?Lwq1fcm+a1K2FJ4tEAnieuPoJsLLl2walbsrxRhIITOzZ6SA2U5atpAXom2J?=
 =?us-ascii?Q?2LbfRkwgbyhz2Gem453+Szo90eylF4t5ziCMvkZwyVlVt2dzfhPH/xmJer0S?=
 =?us-ascii?Q?A2gz1fl7AaNMG5Kz9B3GlMANSU1ZrF7O1oLFI8ThnpClBwygwQxAhN4nafBQ?=
 =?us-ascii?Q?D++QnHBS+Mp6L4sbWneJJw3UQhUuWrEQ7zlpB1f302A5lkaF5j7HscTJOaVj?=
 =?us-ascii?Q?tSdFfp6bNg7TORO+mAsAm9hQsdBCNSG/F5BUUJGlHB8FvQbyBAjGdQGixdqL?=
 =?us-ascii?Q?OLxy2AljKsgVWrIKnT1SFODpS59jbicYinNjryo1CakmRI55CYo9PuXBJnqu?=
 =?us-ascii?Q?IpPyACzOQYiWwr61vokJfnMuTxfRlsKTzAkC3v+4MNLvxCXublyzmsaE95xl?=
 =?us-ascii?Q?LoKjltcHb9Lh9hcHCJzPfTuvUJrCftmbz+n9xgh2v4lXkeGPZrqMAykW+/hw?=
 =?us-ascii?Q?rrWIddLLy27F3aLaA0XGpY06zDcnAqAqOSKDSmseN/zMSSQOx6yLZ86H1bS5?=
 =?us-ascii?Q?mW5Zm9POWyKQzIiB9LPEILxLj7KpH8Fw4QR3ChlqaO+wUYqIvlVWjqfAiGnd?=
 =?us-ascii?Q?HJpf6oylx5OOjBMNLknShHm56ibm15QWNFtVu/DixaHC1VnAwiTGncU/nh6p?=
 =?us-ascii?Q?tDm/IS5KVijlkTiiupiWw5GS7dry5VI9gj8Ddlbu8sZaw54bvkHI9xMXvYWd?=
 =?us-ascii?Q?Bv4eZe83DhaWrvo85ExvDSbMmBtsaDn29Wre6LaN04vXaIS4Nfxo3XkX57DB?=
 =?us-ascii?Q?qdEJICyuZvtyLTiB0HXx988ILxJ4pafu/Kgscf4OcJyfOBcm6QAHJXlZpMSZ?=
 =?us-ascii?Q?4aiu6gz8xirUDzz9YjaHAFrEoBMJUEObKQHf7KrwK1iMEybCoj0LWBhe01dJ?=
 =?us-ascii?Q?uZLCaERu0w1iBBoSR1wL/+x2dYoNd8smSqhjBKMc8HmKAEfraKRoVJjR7Hnb?=
 =?us-ascii?Q?azcxAUkqeirgNh/0k3Kd5aQB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edf370b-d5af-4173-11e5-08d8cdddcb1b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 16:06:15.7367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WGhl4c/ePyMmc1TiPsV157lCD5o7NE5JxXVurRGysTQ0fPYiG7o+NJ06ifCRc3Bv0E6SAJnOv0AKcNtqruEUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cleanup unwanted  debugfs dentries.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 12 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c     | 34 ++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h     |  4 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 ---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     |  3 --
 7 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e0c797a5f739..e3d4d2dcb3a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -797,10 +797,6 @@ struct amdgpu_device {
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
 	struct amdgpu_debugfs		debugfs[AMDGPU_DEBUGFS_MAX_COMPONENTS];
 	unsigned			debugfs_count;
-#if defined(CONFIG_DEBUG_FS)
-	struct dentry                   *debugfs_preempt;
-	struct dentry			*debugfs_regs[AMDGPU_DEBUGFS_MAX_COMPONENTS];
-#endif
 	struct amdgpu_atif		*atif;
 	struct amdgpu_atcs		atcs;
 	struct mutex			srbm_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 4c38c5771cbc..874522217b7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1228,7 +1228,6 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
 					  adev, debugfs_regs[i]);
 		if (!i && !IS_ERR_OR_NULL(ent))
 			i_size_write(ent->d_inode, adev->rmmio_size);
-		adev->debugfs_regs[i] = ent;
 	}
 
 	return 0;
@@ -1592,21 +1591,20 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_sclk_set, NULL,
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
 	int r, i;
+	struct dentry *ent = NULL;
 
-	adev->debugfs_preempt =
-		debugfs_create_file("amdgpu_preempt_ib", 0600,
+	ent = debugfs_create_file("amdgpu_preempt_ib", 0600,
 				    adev_to_drm(adev)->primary->debugfs_root, adev,
 				    &fops_ib_preempt);
-	if (!(adev->debugfs_preempt)) {
+	if (!ent) {
 		DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs file\n");
 		return -EIO;
 	}
 
-	adev->smu.debugfs_sclk =
-		debugfs_create_file("amdgpu_force_sclk", 0200,
+	ent = debugfs_create_file("amdgpu_force_sclk", 0200,
 				    adev_to_drm(adev)->primary->debugfs_root, adev,
 				    &fops_sclk_set);
-	if (!(adev->smu.debugfs_sclk)) {
+	if (!ent) {
 		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
 		return -EIO;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1fb2a91ad30a..1efdfb9b5506 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1137,15 +1137,16 @@ static int amdgpu_ras_sysfs_remove_all(struct amdgpu_device *adev)
  *
  */
 /* debugfs begin */
-static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
+static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev,
+						struct dentry *dir)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 
-	con->dir = debugfs_create_dir(RAS_FS_NAME, minor->debugfs_root);
-	debugfs_create_file("ras_ctrl", S_IWUGO | S_IRUGO, con->dir,
+	dir = debugfs_create_dir(RAS_FS_NAME, minor->debugfs_root);
+	debugfs_create_file("ras_ctrl", S_IWUGO | S_IRUGO, dir,
 				adev, &amdgpu_ras_debugfs_ctrl_ops);
-	debugfs_create_file("ras_eeprom_reset", S_IWUGO | S_IRUGO, con->dir,
+	debugfs_create_file("ras_eeprom_reset", S_IWUGO | S_IRUGO, dir,
 				adev, &amdgpu_ras_debugfs_eeprom_ops);
 
 	/*
@@ -1156,7 +1157,7 @@ static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
 	 * ERREVENT_ATHUB_INTERRUPT generated. Normal GPU recovery routine
 	 * will never be called.
 	 */
-	debugfs_create_bool("auto_reboot", S_IWUGO | S_IRUGO, con->dir,
+	debugfs_create_bool("auto_reboot", S_IWUGO | S_IRUGO, dir,
 				&con->reboot);
 
 	/*
@@ -1164,16 +1165,16 @@ static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
 	 * of RAS IPs during ras recovery.
 	 */
 	debugfs_create_bool("disable_ras_err_cnt_harvest", 0644,
-			con->dir, &con->disable_ras_err_cnt_harvest);
+			dir, &con->disable_ras_err_cnt_harvest);
 }
 
 static void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
-		struct ras_fs_if *head)
+				      struct ras_fs_if *head,
+				      struct dentry *dir)
 {
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head->head);
 
-	if (!obj || obj->ent)
+	if (!obj || !dir)
 		return;
 
 	get_obj(obj);
@@ -1182,9 +1183,8 @@ static void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
 			head->debugfs_name,
 			sizeof(obj->fs_data.debugfs_name));
 
-	obj->ent = debugfs_create_file(obj->fs_data.debugfs_name,
-				       S_IWUGO | S_IRUGO, con->dir, obj,
-				       &amdgpu_ras_debugfs_ops);
+	debugfs_create_file(obj->fs_data.debugfs_name, S_IWUGO | S_IRUGO, dir,
+			    obj, &amdgpu_ras_debugfs_ops);
 }
 
 void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
@@ -1192,6 +1192,7 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
 	struct ras_fs_if fs_info;
+	struct dentry *dir = NULL;
 
 	/*
 	 * it won't be called in resume path, no need to check
@@ -1200,7 +1201,7 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS) || !con)
 		return;
 
-	amdgpu_ras_debugfs_create_ctrl_node(adev);
+	amdgpu_ras_debugfs_create_ctrl_node(adev, dir);
 
 	list_for_each_entry(obj, &con->head, node) {
 		if (amdgpu_ras_is_supported(adev, obj->head.block) &&
@@ -1208,7 +1209,7 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 			sprintf(fs_info.debugfs_name, "%s_err_inject",
 					ras_block_str(obj->head.block));
 			fs_info.head = obj->head;
-			amdgpu_ras_debugfs_create(adev, &fs_info);
+			amdgpu_ras_debugfs_create(adev, &fs_info, dir);
 		}
 	}
 }
@@ -1218,10 +1219,9 @@ static void amdgpu_ras_debugfs_remove(struct amdgpu_device *adev,
 {
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, head);
 
-	if (!obj || !obj->ent)
+	if (!obj)
 		return;
 
-	obj->ent = NULL;
 	put_obj(obj);
 }
 
@@ -1233,8 +1233,6 @@ static void amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)
 	list_for_each_entry_safe(obj, tmp, &con->head, node) {
 		amdgpu_ras_debugfs_remove(adev, &obj->head);
 	}
-
-	con->dir = NULL;
 }
 /* debugfs end */
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 762f5e46c007..aed0716efa5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -318,8 +318,6 @@ struct amdgpu_ras {
 	uint32_t supported;
 	uint32_t features;
 	struct list_head head;
-	/* debugfs */
-	struct dentry *dir;
 	/* sysfs */
 	struct device_attribute features_attr;
 	struct bin_attribute badpages_attr;
@@ -395,8 +393,6 @@ struct ras_manager {
 	struct list_head node;
 	/* the device */
 	struct amdgpu_device *adev;
-	/* debugfs */
-	struct dentry *ent;
 	/* sysfs */
 	struct device_attribute sysfs_attr;
 	int attr_inuse;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index aaad9e304ad9..f4d7cf60c262 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1788,7 +1788,7 @@ static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev)
 		(adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
 	ctx->train_data_size =
 		GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
-	
+
 	DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
 			ctx->train_data_size,
 			ctx->p2c_train_data_offset,
@@ -2560,11 +2560,11 @@ int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
 				ttm_debugfs_entries[count].fops);
 		if (IS_ERR(ent))
 			return PTR_ERR(ent);
+
 		if (ttm_debugfs_entries[count].domain == TTM_PL_VRAM)
 			i_size_write(ent->d_inode, adev->gmc.mc_vram_size);
 		else if (ttm_debugfs_entries[count].domain == TTM_PL_TT)
 			i_size_write(ent->d_inode, adev->gmc.gart_size);
-		adev->mman.debugfs_entries[count] = ent;
 	}
 
 	count = ARRAY_SIZE(amdgpu_ttm_debugfs_list);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 6c142455fc66..4df4cf2fd4dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -68,10 +68,6 @@ struct amdgpu_mman {
 	bool				initialized;
 	void __iomem			*aper_base_kaddr;
 
-#if defined(CONFIG_DEBUG_FS)
-	struct dentry			*debugfs_entries[8];
-#endif
-
 	/* buffer handling */
 	const struct amdgpu_buffer_funcs	*buffer_funcs;
 	struct amdgpu_ring			*buffer_funcs_ring;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 10b0624ade65..83147b7d836e 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -439,9 +439,6 @@ struct smu_context
 	struct smu_baco_context		smu_baco;
 	struct smu_temperature_range	thermal_range;
 	void *od_settings;
-#if defined(CONFIG_DEBUG_FS)
-	struct dentry                   *debugfs_sclk;
-#endif
 
 	struct smu_umd_pstate_table	pstate_table;
 	uint32_t pstate_sclk;
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
