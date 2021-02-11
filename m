Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB00C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 11:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E5664E13
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 11:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E5664E13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036EC6EE07;
	Thu, 11 Feb 2021 11:59:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CCD66EE07
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 11:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knqz/c2s8gERGHsTOm05zezm67FwnTnGDwy47sLrEAWXE1moWrHmo8vwrwc9ywiEHNUepeM9QU2cwTmtvUwgvAgXUz46VcumASUY3pjNOH+fDGNBABzPwJyWTz4rKzIH7M2NYA97mVgpit6XSHpdiORtm4pTcsdd8jUvaj8dtkRmBda3710L1GvlqfZAY2ggOPbaCjh+YxmYtSEBZuUswovIqsb1JmOkN6cu2CDJJX1B5QGjEe8N7lCYzCMOXUkzXH1h1BPkwbVdWibHhxzhU0KXzybYdvnXWzxKtCdaE1vLENKAxkYXC7yGmDV4NoObsmx70b2ivfK+JpEo7Aj8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVo2RbaiMoeLb1yfmK8lwk0gK4DYNJ9SLLAp/hIoNRA=;
 b=bqT6SLrDkfFufCVL2TN5hKLoHNGdMm6kGN78EWAUNAsYcrzYRW8lcNcMGQ2AGxzHWtjiTXTniChSoeazhAKHdEGzvv3dTYuo15iaxg37qxEgRzZaJDgFZQaFcb5Viu1FBaOUSELe9iRR6xzoR2NIq81OzNF9ceNykWzoO6lmLsE1kRALSBc+BZF2LDxaOQdShX2KkQ7Wq4VVR70tr6e6N7XnRoVUA8ozOcfi6XQi/wu8/iYk+Vt2kHs3NfQu8ZWUMGCCZ0v6ce5xoAMlmd/QnxLPNtmx+D3IhJ+3NZrmRfXsFOAsRdm/zB/4drU1IxayLHJXXPTv53rkZQ/8m2tDgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVo2RbaiMoeLb1yfmK8lwk0gK4DYNJ9SLLAp/hIoNRA=;
 b=G9ybX47lJFSrbVYnrPH3juNUqxWDKvDubotTDkpDeynNwttRRwjonovawNbJugS8xlKaKE/3Vf9f+EMlaefFhsvSo8K2ovhb0MdfZb3cgG57TvgezL7ifsmjhUZjCEyou9js2YPU9oVwOZPnaIT4J6mb4COgwqsvD/2dlud7CG0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2456.namprd12.prod.outlook.com (2603:10b6:4:b4::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 11 Feb
 2021 11:59:46 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 11:59:46 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH v2 1/2] drm/amdgpu: do not keep debugfs dentry
Date: Thu, 11 Feb 2021 12:59:31 +0100
Message-Id: <20210211115932.9287-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [217.86.97.172]
X-ClientProxiedBy: AM9P195CA0026.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::31) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.97.172) by
 AM9P195CA0026.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.27 via Frontend Transport; Thu, 11 Feb 2021 11:59:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b03433c5-220b-4f96-f725-08d8ce848698
X-MS-TrafficTypeDiagnostic: DM5PR12MB2456:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2456935A05225BA674D359918B8C9@DM5PR12MB2456.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:187;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJ2/kHQlsw9Ut2Ibv+P0UGx0EUN5lacGzmi6d/oO+T2eN1ru9PmOsRHAJ2tD694Iuy9WBfgVfG2MGKkE42LV5FI94l5uXmzN5adCyi1Cj3DjBjJiUAndw2otZCIWTSl5jfWRV90mMZ3X6yr0BmLiiLFyqACpQfL7a5CORqE4hdsZLyI4F1fGSnuNSvVPy+T7NamtLgnXbG/e5HmoJBz/uZvqkjKT7KfaQ4bO4FLmVSnWkAg0vitlw6Ca3BCf0hpMcIyrz5QJzj8yGie+JWxyfzy1V0Qsl9nxWd0HRvCuhXtPS47qOinoaxIGCYnqYOAfVjCWcxWw2VkVLSWFtj+jUDZ0Ki3YxN3cghE+xq2qRWxdttv6aBjIHOcrngmYmQbnTN8MYVBu1b9pk24ORmXwEoy3/X/7MU6FEFmodECeqtgJ5MrOixp8sq9pu7uikjlqwQ91LAJpyd5zDATbPG/vXirhmeZ9+ca/LU8uYMwF+aN8oI30jLEo4YVpb48l63x6C07oSZemCYC928EAoqI9wA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(16526019)(36756003)(186003)(316002)(66946007)(1076003)(6506007)(6636002)(6666004)(6486002)(26005)(52116002)(8676002)(30864003)(66556008)(6512007)(44832011)(86362001)(2616005)(66476007)(37006003)(34206002)(2906002)(8936002)(956004)(478600001)(83380400001)(5660300002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CXz1DWZk4l3/4Fl5nKM3bn+ZI29DQftBGWYcY0hhQas08q2YHEA+jQAn++Ph?=
 =?us-ascii?Q?tiufnWSQM5pOth3U0/CJRjoVIgLuPEBzEVDYTNYFw8SjSq9ww4Igoe+8D0JF?=
 =?us-ascii?Q?P82ww1PnSJYQjbWomH+peTByYeV07DS3xO2jZdhncqYe5AiZW8yXC5rFoae/?=
 =?us-ascii?Q?/OGp5fb+Ra7/ODu3LBK+9KagGchkr84kkZS+zNUXnBG7P4db0WmMRgaiyeP1?=
 =?us-ascii?Q?H9VhryDDlAyf11Apy7FHTCgmqlwUwX8s/gOfDerJRUbQAXCBcD4PUwmKMWnx?=
 =?us-ascii?Q?q4gZ4krY9j6sYwykzX78Hb/8bSbYfACSJuJYfpSuzy4OGKUFfMFrJ3T3XNHv?=
 =?us-ascii?Q?qsd4LN1d2Hl8pUjnEYxreBhKj+Uz45ra+v0Lk4QZuA42SsqgP05IK5a6/Rq5?=
 =?us-ascii?Q?+CA9Utj9l2jhenjrROsxxX5+cpX8fopgspGj6HIekNGB0VHLw5cMnGi5TmGX?=
 =?us-ascii?Q?Zp7+CyKUlhRHf2r49DzJ8SquZ4p4UUqoiQ+P6iSoRXWQ5ihTLd+hWAkl0wTH?=
 =?us-ascii?Q?MWoDRV/xJvl3QJSkZcAPPiqktfErjq9x363d6j5IIqw1ab3yjSWdIk9VbDRy?=
 =?us-ascii?Q?IDITsWpopdwz2NQSpGN5fVMaeD3pRcq5dGubPAI528n5K0oj0GtUjyZGsilw?=
 =?us-ascii?Q?JDJJwZLJiasKfZq7zvtHJxluHgxxVysooN38zBKKTwyil8x5+0HN9C8fLY7l?=
 =?us-ascii?Q?+eqihnt0+Ru7f52/L8ZoVqsMA8iZ0lDoY/y73VROu6WpSbioz6U99yXoRRO1?=
 =?us-ascii?Q?TGHpDNRuL0nMj5th9SVGnXGBpvckk3qkuCTT/cJgvtWK0XbMU7suXrKmajf4?=
 =?us-ascii?Q?Ni3f+eETYtEfU54myHs6+aaWEiEpkKt1dYUqHI4+IB4Hkf22XniiUgwAaj2M?=
 =?us-ascii?Q?vYanVoiP2KcROsisSbswCUGV0RAiAz2odA3xSebn4YAGv9aSYAEzBWEDk9sh?=
 =?us-ascii?Q?ZP8hNBLR6f6XJIAOhqRTdx607V8zT0GtjoXgy6kDNXjhvzCziJmmbk0YnOTG?=
 =?us-ascii?Q?QH3qrldfuEDds+lxY+ZOWhQeZkDjHfiqOL8qN9YNc86CWuRAaEVEuf9yVHCe?=
 =?us-ascii?Q?lmqnifRmt0Y0TLAKYQ/kSfMzYrhk3uwCo0WeO0ejUDKGUqAIgSzAFn9X+z+s?=
 =?us-ascii?Q?p/vJWRmjJ9UwQO96N9QMkP6KpN8SkSfFVgZEEQn8w2q+dFrXqQ3ystnuCw46?=
 =?us-ascii?Q?Wr6y6/yLroLlldnS40l2ypObc8fsU6ifp+YpMTTUIwhYeeUV8KBfx8xw6iNp?=
 =?us-ascii?Q?leN6Q1c/nr/IvbeszNIZ9a+D6JDW2Nq4qHRuGxJMI/GjNFpiHTphDUoAY10G?=
 =?us-ascii?Q?XASTyat4+86eiEC/VCOQZP4R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03433c5-220b-4f96-f725-08d8ce848698
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 11:59:46.5839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 647DH1g817SHp6FOMlVM83EgpjW0fOV1pt6sfr8blCa61o6Xu3wqwpoUALVBBz2Cp+gC1OmgdJgO1SSCKGm0kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2456
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

Cleanup unnecessary debugfs dentries and surrounding functions.

v2: remove ttm_debugfs_entries array.
    do not init variables.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 20 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c     | 73 +++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h     |  4 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 40 ++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 --
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     |  3 -
 7 files changed, 52 insertions(+), 96 deletions(-)

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
index 4c38c5771cbc..55db646d0ba4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1228,7 +1228,6 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
 					  adev, debugfs_regs[i]);
 		if (!i && !IS_ERR_OR_NULL(ent))
 			i_size_write(ent->d_inode, adev->rmmio_size);
-		adev->debugfs_regs[i] = ent;
 	}

 	return 0;
@@ -1591,22 +1590,21 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_sclk_set, NULL,

 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
+	struct dentry *ent;
 	int r, i;

-	adev->debugfs_preempt =
-		debugfs_create_file("amdgpu_preempt_ib", 0600,
-				    adev_to_drm(adev)->primary->debugfs_root, adev,
-				    &fops_ib_preempt);
-	if (!(adev->debugfs_preempt)) {
+	ent = debugfs_create_file("amdgpu_preempt_ib", 0600,
+				  adev_to_drm(adev)->primary->debugfs_root, adev,
+				  &fops_ib_preempt);
+	if (!ent) {
 		DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs file\n");
 		return -EIO;
 	}

-	adev->smu.debugfs_sclk =
-		debugfs_create_file("amdgpu_force_sclk", 0200,
-				    adev_to_drm(adev)->primary->debugfs_root, adev,
-				    &fops_sclk_set);
-	if (!(adev->smu.debugfs_sclk)) {
+	ent = debugfs_create_file("amdgpu_force_sclk", 0200,
+				  adev_to_drm(adev)->primary->debugfs_root, adev,
+				  &fops_sclk_set);
+	if (!ent) {
 		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
 		return -EIO;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1fb2a91ad30a..b504914519ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1137,16 +1137,17 @@ static int amdgpu_ras_sysfs_remove_all(struct amdgpu_device *adev)
  *
  */
 /* debugfs begin */
-static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
+struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct dentry *dir;
 	struct drm_minor *minor = adev_to_drm(adev)->primary;

-	con->dir = debugfs_create_dir(RAS_FS_NAME, minor->debugfs_root);
-	debugfs_create_file("ras_ctrl", S_IWUGO | S_IRUGO, con->dir,
-				adev, &amdgpu_ras_debugfs_ctrl_ops);
-	debugfs_create_file("ras_eeprom_reset", S_IWUGO | S_IRUGO, con->dir,
-				adev, &amdgpu_ras_debugfs_eeprom_ops);
+	dir = debugfs_create_dir(RAS_FS_NAME, minor->debugfs_root);
+	debugfs_create_file("ras_ctrl", S_IWUGO | S_IRUGO, dir, adev,
+			    &amdgpu_ras_debugfs_ctrl_ops);
+	debugfs_create_file("ras_eeprom_reset", S_IWUGO | S_IRUGO, dir, adev,
+			    &amdgpu_ras_debugfs_eeprom_ops);

 	/*
 	 * After one uncorrectable error happens, usually GPU recovery will
@@ -1156,24 +1157,24 @@ static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
 	 * ERREVENT_ATHUB_INTERRUPT generated. Normal GPU recovery routine
 	 * will never be called.
 	 */
-	debugfs_create_bool("auto_reboot", S_IWUGO | S_IRUGO, con->dir,
-				&con->reboot);
+	debugfs_create_bool("auto_reboot", S_IWUGO | S_IRUGO, dir, &con->reboot);

 	/*
 	 * User could set this not to clean up hardware's error count register
 	 * of RAS IPs during ras recovery.
 	 */
-	debugfs_create_bool("disable_ras_err_cnt_harvest", 0644,
-			con->dir, &con->disable_ras_err_cnt_harvest);
+	debugfs_create_bool("disable_ras_err_cnt_harvest", 0644, dir,
+			    &con->disable_ras_err_cnt_harvest);
+	return dir;
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
@@ -1182,14 +1183,14 @@ static void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
 			head->debugfs_name,
 			sizeof(obj->fs_data.debugfs_name));

-	obj->ent = debugfs_create_file(obj->fs_data.debugfs_name,
-				       S_IWUGO | S_IRUGO, con->dir, obj,
-				       &amdgpu_ras_debugfs_ops);
+	debugfs_create_file(obj->fs_data.debugfs_name, S_IWUGO | S_IRUGO, dir,
+			    obj, &amdgpu_ras_debugfs_ops);
 }

 void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct dentry *dir;
 	struct ras_manager *obj;
 	struct ras_fs_if fs_info;

@@ -1200,7 +1201,7 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS) || !con)
 		return;

-	amdgpu_ras_debugfs_create_ctrl_node(adev);
+	dir = amdgpu_ras_debugfs_create_ctrl_node(adev);

 	list_for_each_entry(obj, &con->head, node) {
 		if (amdgpu_ras_is_supported(adev, obj->head.block) &&
@@ -1208,34 +1209,11 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 			sprintf(fs_info.debugfs_name, "%s_err_inject",
 					ras_block_str(obj->head.block));
 			fs_info.head = obj->head;
-			amdgpu_ras_debugfs_create(adev, &fs_info);
+			amdgpu_ras_debugfs_create(adev, &fs_info, dir);
 		}
 	}
 }

-static void amdgpu_ras_debugfs_remove(struct amdgpu_device *adev,
-		struct ras_common_if *head)
-{
-	struct ras_manager *obj = amdgpu_ras_find_obj(adev, head);
-
-	if (!obj || !obj->ent)
-		return;
-
-	obj->ent = NULL;
-	put_obj(obj);
-}
-
-static void amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct ras_manager *obj, *tmp;
-
-	list_for_each_entry_safe(obj, tmp, &con->head, node) {
-		amdgpu_ras_debugfs_remove(adev, &obj->head);
-	}
-
-	con->dir = NULL;
-}
 /* debugfs end */

 /* ras fs */
@@ -1282,8 +1260,17 @@ static int amdgpu_ras_fs_init(struct amdgpu_device *adev)

 static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)
 {
-	if (IS_ENABLED(CONFIG_DEBUG_FS))
-		amdgpu_ras_debugfs_remove_all(adev);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_manager *con_obj, *ip_obj, *tmp;
+
+	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
+		list_for_each_entry_safe(con_obj, tmp, &con->head, node) {
+			ip_obj = amdgpu_ras_find_obj(adev, &con_obj->head);
+			if (ip_obj)
+				put_obj(ip_obj);
+		}
+	}
+
 	amdgpu_ras_sysfs_remove_all(adev);
 	return 0;
 }
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
index aaad9e304ad9..b140e6f8209b 100644
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
@@ -2530,18 +2530,6 @@ static const struct file_operations amdgpu_ttm_iomem_fops = {
 	.llseek = default_llseek
 };

-static const struct {
-	char *name;
-	const struct file_operations *fops;
-	int domain;
-} ttm_debugfs_entries[] = {
-	{ "amdgpu_vram", &amdgpu_ttm_vram_fops, TTM_PL_VRAM },
-#ifdef CONFIG_DRM_AMDGPU_GART_DEBUGFS
-	{ "amdgpu_gtt", &amdgpu_ttm_gtt_fops, TTM_PL_TT },
-#endif
-	{ "amdgpu_iomem", &amdgpu_ttm_iomem_fops, TTM_PL_SYSTEM },
-};
-
 #endif

 int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
@@ -2550,22 +2538,20 @@ int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
 	unsigned count;

 	struct drm_minor *minor = adev_to_drm(adev)->primary;
+	umode_t mode = S_IFREG | S_IRUGO;
 	struct dentry *ent, *root = minor->debugfs_root;

-	for (count = 0; count < ARRAY_SIZE(ttm_debugfs_entries); count++) {
-		ent = debugfs_create_file(
-				ttm_debugfs_entries[count].name,
-				S_IFREG | S_IRUGO, root,
-				adev,
-				ttm_debugfs_entries[count].fops);
-		if (IS_ERR(ent))
-			return PTR_ERR(ent);
-		if (ttm_debugfs_entries[count].domain == TTM_PL_VRAM)
-			i_size_write(ent->d_inode, adev->gmc.mc_vram_size);
-		else if (ttm_debugfs_entries[count].domain == TTM_PL_TT)
-			i_size_write(ent->d_inode, adev->gmc.gart_size);
-		adev->mman.debugfs_entries[count] = ent;
-	}
+	debugfs_create_file_size("amdgpu_vram", mode, root, adev,
+				 &amdgpu_ttm_vram_fops, adev->gmc.mc_vram_size);
+#ifdef CONFIG_DRM_AMDGPU_GART_DEBUGFS
+	debugfs_create_file_size("amdgpu_gtt", mode, root, adev,
+				 &amdgpu_ttm_gtt_fops, adev->gmc.gart_size);
+#endif
+
+	ent = debugfs_create_file("amdgpu_iomem", mode, root, adev,
+				  &amdgpu_ttm_iomem_fops);
+	if (IS_ERR(ent))
+		return PTR_ERR(ent);

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
