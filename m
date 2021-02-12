Return-Path: <SRS0=bpzG=HO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE02BC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Feb 2021 18:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ACB164E8E
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Feb 2021 18:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACB164E8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5081B6E1D7;
	Fri, 12 Feb 2021 18:20:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 471046E1D7
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Feb 2021 18:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOQpuMKZutmpixrxItI6G5OBiwmeUBzFcSMLr7x4T4aCyenemlEeVDiq8Xg5cu0i+zROnS55fqq4dtOidXu3i55XtwG9bt6fwluwH47qPa95pxNlrK1RO3oE/gg4mTBNYeZuTn/CU2xqGutd1Wg61m/DQ2wftxI/TIvH3iGhMerNDUx0s7UHm2p2yE5ddzvFm8CEUA9FbMhA5orjKE7knv/hlTEf5qvIGA7yp95O7vYDnEVxLnVtskCIOCWJi/IQqiYkPGs/Cb6+X/UMgUt9bRG+WbhEsPcrhvL1OZVxJ36YkGy02nswjvcXDs3Ts9xNqHyAOQKoHuLFFdr/OuTl7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jHGDUQxhN0tjYYQv+27Ccr7vczLQ+brCvCsDmGoUQo=;
 b=XYtwSzchGXrYem6CNgR6+KEWHZ7ZMG8PLoSdjKfKy7/qoVegSbjh82VjydDSe2UoSfHB9N8XiH2QDjfPtSEFyIURQgtnnE3s6z7QpDDeGVVcUFU+/iicqpwdXk4CM1wPNqi7DruhQar2MZ+QREXBiFS+jQbQLHBbVQY4grSWPkKbSt/eIdAd8e/GBOe/0xDMxj09rRVLHkh7e95JOF77oJITcIvvfaEhFvlVP8JQX34X8d9QjjWqsKN4WCJSuxKsHy/KF2zWDy8/dSIBYYRzo318Nj/J+ZCa59sPF37CHw7qjQPl56zVeiDSazW45qCVzyZ+1xWObIjziF9p2pf8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jHGDUQxhN0tjYYQv+27Ccr7vczLQ+brCvCsDmGoUQo=;
 b=sjZCXu7WD51HcN8+w7JzyhxtwtUur4/bc+W0TgJFJsI3sfi9pvdsZdETS6qEaSAc09QMf8wh6zpQMcOqM+kfHJ7CSBlQqfl7KeaW01I1UGCQBiYHKstdfZqNP+d7YxhcE3SWmjgifWurFBKfClq7oKG3rVbLNyUTPauxhGUyVN4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1130.namprd12.prod.outlook.com (2603:10b6:3:75::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Fri, 12 Feb
 2021 18:20:20 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.027; Fri, 12 Feb 2021
 18:20:19 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/1] drm/amdgpu: do not use drm's debugfs middle layer
Date: Fri, 12 Feb 2021 19:20:00 +0100
Message-Id: <20210212182000.94835-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [217.86.126.240]
X-ClientProxiedBy: AM9P192CA0002.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::7) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.126.240) by
 AM9P192CA0002.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Fri, 12 Feb 2021 18:20:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c417cc8-f300-45d5-8323-08d8cf82daac
X-MS-TrafficTypeDiagnostic: DM5PR12MB1130:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB113034442A82D9600CE65EC28B8B9@DM5PR12MB1130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WAWi7ku7hFXuBWm2fUJoPy6wFtc+jbaE7qh7rzcdrl9CI1ZUrN4PrD8rhuC/8iVwBqf5ow7WY3sYqO2k33tb2rDVlwYloKUL9ZRblMI49+sz83BSe6WpRS4F4v3wmS6ETY33q8YMT9ztuT5XjFydO8Ch1D91gJ5JTYI8eerqKlh1cCjj2wY38qgz1802KGC2mgaYw0h4JznDN1FDHtz0I6GNdPQZb3Qe1jwDOg4/pn5t7PrU1y0rEHkipUktIzSTuQ1GeYJ9GbbjREDeQl8buJUKkDgEtW9CwknSM40Mfnx0QyvFQFRuDs7+n7F/ixOJM8jR+0jeEjFtnEgvN+j55jQYzykNOVhAnaqkZh/McyE65dDjZzUmhZUumqoAIrlkFqn3GDhOIQPwcyQgbZw54OewH41Rs7r1z3r+28wXLupyeTLnh1AiWNp3CxGrNkXrY42YGEAFxS6soBzPH8Zz8mDXDVJZe8lRWp9Ycg7PIR1+/W/sqhSSNkSNPhqscsVDsSWM5lHc2cavWdmktFnQNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(2906002)(52116002)(36756003)(86362001)(8676002)(83380400001)(8936002)(66476007)(66556008)(66946007)(478600001)(6486002)(6666004)(6506007)(956004)(5660300002)(1076003)(30864003)(6512007)(34206002)(4326008)(2616005)(6636002)(26005)(44832011)(186003)(16526019)(316002)(37006003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4qM2uFsc2owxus0WlGHioiRXMy9M+vOUpl8n4VM+wD1crtkmDA1GXFIjVPgu?=
 =?us-ascii?Q?/bwTR722hsFVzdEO5Bld4OJEMya3g70oFDQ7WXIMPoxMLyyz03m+wfi5cXUA?=
 =?us-ascii?Q?SecwiWVlDz6n6rLvpNExD9SsOEcOvqaW9nctHjEzzc4AAa3XWzTRWFJZSlqB?=
 =?us-ascii?Q?JPj9Ni0WfOFwmhvueRwRK9qpMXaLQCOj3QYLeimW6BYVfZzCTa9oAIRmPM9k?=
 =?us-ascii?Q?EIRZfZHvp7XScalPo0ZvvODA1e5kxxV50chrskk+BRMbZXrJ+BoEHuEHGQUi?=
 =?us-ascii?Q?4Ad1h3Baa6QT2yFV6Qge9kyDZKICZ0eT/QCtSgDQoFWsPTMvZaQCHvx3ZpBQ?=
 =?us-ascii?Q?PsbpszdxU/Doclzkb0SBlUZMDKw8wP2dDxM68Cyq2wa3GdpN5eqiVohRIj2q?=
 =?us-ascii?Q?73ryTSuQvvb+o9BInyh0CBSSuFnj1Im7MIXUmpaNWNH+epSe9XrO9ygOmcB9?=
 =?us-ascii?Q?4X7hCcV6mfMlKevrPZNArbnUm2UYAxLDMyMUgunrkdeHEYIRWLlzH1hwE9MG?=
 =?us-ascii?Q?S0Wsbot6GXXWLkbMbuoVrN4GuDKo9TtyrStrmti5ami75g+LNWbVKcV8Yt33?=
 =?us-ascii?Q?E+vnJlSlS8DWskZDYcBFue7V/45FRh5PSeevm7JryhlHf2LopC4Ur8tCy8vZ?=
 =?us-ascii?Q?woLD2ZXGUfOxGUAAYSittMAlEjEbSvErKAEICFWoUZEA9xtHEW0nI3VGwT5q?=
 =?us-ascii?Q?Rd04b22Ts0K+t6wkJDBgMcqMKwkPXO7vp02/qnUxBLm2IIX44h1x5QGWGcHy?=
 =?us-ascii?Q?Sgee7vvnmYIh3UaMlIzNOMjdAvQFWKMQFm7ubgXPb6lT2g9o27GLQxhp8zgv?=
 =?us-ascii?Q?tabbimUE5LzxR3MAHUk8QuUG6n731lGWzflAywloP9K5rCL9e1Fbhg2qC+Wp?=
 =?us-ascii?Q?H6tBtxpVb4NodVTRn/2KO3BC1/wNX6o2xo/gBvLdmRWmi08qnOY+401xY+mj?=
 =?us-ascii?Q?PQ0Wx8TqLVTG9VZRWXFBM3sDrDmq/Ts46h+9s9t0grD+llrw8pAWkrg/mxyW?=
 =?us-ascii?Q?pvIXbi9vWX1nyyGil9Gh4AFxf2tI+sweLcgBwhZbwgYVxngAO1wN34e9sznE?=
 =?us-ascii?Q?4OJbF4yKC2sSmQPPsMmD9s8Xxj7fFjRt9s/iya9/lT/lbof6BuCkEL9BfxXK?=
 =?us-ascii?Q?Evc0BhAkhT/epQuzmejCsD4Ae+KsKNPbHg2ljklgPHM84jnWr1CbCBypso+b?=
 =?us-ascii?Q?9eu2TNQFKIrlPWVsXNVIqiJ/Y9FERWCaMn9+k8v8Q3YIj8t07z9gLL/FiWPV?=
 =?us-ascii?Q?o4oico6xFqXNRw74MX80F4mXQ6TBqTuxEVjJo86flrpSIwS+nL3QoyPXCiSV?=
 =?us-ascii?Q?I15cYYAq83o6lXIJQ1etOcWu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c417cc8-f300-45d5-8323-08d8cf82daac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 18:20:19.7960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KF+tkDNnf+dRCHnHmpJGw356+tWFbGGQaDaikA3+C/bwXffRwXXp2s1KC/KsX0TXCxKtbJUNPmmzVDl5hdQhbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1130
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

drm_debugfs_create_files() is a drm middle layer that
drm drivers can avoid by directly using debugfs_create_file()

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 131 +++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h   |  18 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  43 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c        |  17 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  18 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  47 +++----
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  32 ++---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  17 +--
 11 files changed, 171 insertions(+), 169 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e3d4d2dcb3a0..8d0311ded641 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -795,8 +795,7 @@ struct amdgpu_device {
 	bool				accel_working;
 	struct notifier_block		acpi_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
-	struct amdgpu_debugfs		debugfs[AMDGPU_DEBUGFS_MAX_COMPONENTS];
-	unsigned			debugfs_count;
+	struct amdgpu_debugfs		debugfs;
 	struct amdgpu_atif		*atif;
 	struct amdgpu_atcs		atcs;
 	struct mutex			srbm_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 55db646d0ba4..8811c6f5be4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -38,6 +38,21 @@
 #include "amdgpu_securedisplay.h"
 #include "amdgpu_fw_attestation.h"
 
+static int amdgpu_debugfs_open(struct inode *inode, struct file *file)
+{
+	struct amdgpu_debugfs_info_node *tmp = inode->i_private;
+
+	return single_open(file, tmp->show, tmp);
+}
+
+static const struct file_operations amdgpu_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.open = amdgpu_debugfs_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
 /**
  * amdgpu_debugfs_add_files - Add simple debugfs entries
  *
@@ -46,35 +61,29 @@
  * @nfiles: Number of callbacks to register
  *
  */
-int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
-			     const struct drm_info_list *files,
-			     unsigned nfiles)
+void amdgpu_debugfs_add_files(struct amdgpu_device *adev,
+			      const char *name,
+			      int (*show)(struct seq_file *m, void *data),
+			      void *data)
 {
-	unsigned i;
+#if defined(CONFIG_DEBUG_FS)
+	umode_t mode = S_IFREG | S_IRUGO;
+	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
+	struct amdgpu_debugfs_info_node *tmp;
 
-	for (i = 0; i < adev->debugfs_count; i++) {
-		if (adev->debugfs[i].files == files) {
-			/* Already registered */
-			return 0;
-		}
-	}
+	tmp = kmalloc(sizeof(struct amdgpu_debugfs_info_node), GFP_KERNEL);
+	if (tmp == NULL)
+		return;
 
-	i = adev->debugfs_count + 1;
-	if (i > AMDGPU_DEBUGFS_MAX_COMPONENTS) {
-		DRM_ERROR("Reached maximum number of debugfs components.\n");
-		DRM_ERROR("Report so we increase "
-			  "AMDGPU_DEBUGFS_MAX_COMPONENTS.\n");
-		return -EINVAL;
-	}
-	adev->debugfs[adev->debugfs_count].files = files;
-	adev->debugfs[adev->debugfs_count].num_files = nfiles;
-	adev->debugfs_count = i;
-#if defined(CONFIG_DEBUG_FS)
-	drm_debugfs_create_files(files, nfiles,
-				 adev_to_drm(adev)->primary->debugfs_root,
-				 adev_to_drm(adev)->primary);
+	tmp->adev = adev;
+	tmp->data = data;
+	tmp->show = show;
+
+	debugfs_create_file(name, mode, root, tmp,&amdgpu_debugfs_fops);
+	mutex_lock(&adev->debugfs.debugfs_lock);
+	list_add(&tmp->list, &adev->debugfs.debugfs_list);
+	mutex_unlock(&adev->debugfs.debugfs_lock);
 #endif
-	return 0;
 }
 
 int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
@@ -1235,14 +1244,14 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
 
 static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_debugfs_info_node *node = (struct amdgpu_debugfs_info_node *) m->private;
+	struct amdgpu_device *adev = node->adev;
+	struct drm_device *dev = adev_to_drm(adev);
 	int r = 0, i;
 
 	r = pm_runtime_get_sync(dev->dev);
 	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		pm_runtime_put_autosuspend(dev->dev);
 		return r;
 	}
 
@@ -1286,9 +1295,8 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 
 static int amdgpu_debugfs_get_vbios_dump(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_debugfs_info_node *node = (struct amdgpu_debugfs_info_node *) m->private;
+	struct amdgpu_device *adev = node->adev;
 
 	seq_write(m, adev->bios, adev->bios_size);
 	return 0;
@@ -1296,14 +1304,14 @@ static int amdgpu_debugfs_get_vbios_dump(struct seq_file *m, void *data)
 
 static int amdgpu_debugfs_evict_vram(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_debugfs_info_node *node = (struct amdgpu_debugfs_info_node *) m->private;
+	struct amdgpu_device *adev = node->adev;
+	struct drm_device *dev = adev_to_drm(adev);
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
 	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		pm_runtime_put_autosuspend(dev->dev);
 		return r;
 	}
 
@@ -1317,14 +1325,14 @@ static int amdgpu_debugfs_evict_vram(struct seq_file *m, void *data)
 
 static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_debugfs_info_node *node = (struct amdgpu_debugfs_info_node *) m->private;
+	struct amdgpu_device *adev = node->adev;
+	struct drm_device *dev = adev_to_drm(adev);
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
 	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		pm_runtime_put_autosuspend(dev->dev);
 		return r;
 	}
 
@@ -1338,8 +1346,9 @@ static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
 
 static int amdgpu_debugfs_vm_info(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct amdgpu_debugfs_info_node *node = (struct amdgpu_debugfs_info_node *) m->private;
+	struct amdgpu_device *adev = node->adev;
+	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_file *file;
 	int r;
 
@@ -1365,14 +1374,6 @@ static int amdgpu_debugfs_vm_info(struct seq_file *m, void *data)
 	return r;
 }
 
-static const struct drm_info_list amdgpu_debugfs_list[] = {
-	{"amdgpu_vbios", amdgpu_debugfs_get_vbios_dump},
-	{"amdgpu_test_ib", &amdgpu_debugfs_test_ib},
-	{"amdgpu_evict_vram", &amdgpu_debugfs_evict_vram},
-	{"amdgpu_evict_gtt", &amdgpu_debugfs_evict_gtt},
-	{"amdgpu_vm_info", &amdgpu_debugfs_vm_info},
-};
-
 static void amdgpu_ib_preempt_fences_swap(struct amdgpu_ring *ring,
 					  struct dma_fence **fences)
 {
@@ -1593,6 +1594,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	struct dentry *ent;
 	int r, i;
 
+	INIT_LIST_HEAD(&adev->debugfs.debugfs_list);
+	mutex_init(&adev->debugfs.debugfs_lock);
+
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600,
 				  adev_to_drm(adev)->primary->debugfs_root, adev,
 				  &fops_ib_preempt);
@@ -1669,10 +1673,29 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
 	amdgpu_fw_attestation_debugfs_init(adev);
 
-	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
-					ARRAY_SIZE(amdgpu_debugfs_list));
+	amdgpu_debugfs_add_files(adev, "amdgpu_vbios", amdgpu_debugfs_get_vbios_dump, NULL);
+	amdgpu_debugfs_add_files(adev, "amdgpu_test_ib", amdgpu_debugfs_test_ib, NULL);
+	amdgpu_debugfs_add_files(adev, "amdgpu_evict_vram", amdgpu_debugfs_evict_vram, NULL);
+	amdgpu_debugfs_add_files(adev, "amdgpu_evict_gtt", amdgpu_debugfs_evict_gtt, NULL);
+	amdgpu_debugfs_add_files(adev, "amdgpu_vm_info", amdgpu_debugfs_vm_info, NULL);
+
+	return 0;
 }
 
+void amdgpu_debugfs_fini(struct amdgpu_device *adev)
+{
+	struct list_head *pos, *q;
+	struct amdgpu_debugfs_info_node *tmp;
+
+	mutex_lock(&adev->debugfs.debugfs_lock);
+	list_for_each_safe(pos, q, &adev->debugfs.debugfs_list) {
+		tmp = list_entry(pos, struct amdgpu_debugfs_info_node, list);
+		list_del(pos);
+		kfree(tmp);
+	}
+	mutex_unlock(&adev->debugfs.debugfs_lock);
+
+}
 #else
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
@@ -1682,4 +1705,8 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
 {
 	return 0;
 }
+
+void amdgpu_debugfs_fini(struct amdgpu_device *adev)
+{
+}
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
index 2803884d338d..44121fe09ec3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -27,10 +27,18 @@
  * Debugfs
  */
 struct amdgpu_debugfs {
-	const struct drm_info_list	*files;
-	unsigned		num_files;
+	struct list_head debugfs_list;
+	struct mutex debugfs_lock; /* Protects debugfs_list. */
 };
 
+struct amdgpu_debugfs_info_node {
+	int (*show)(struct seq_file*, void*);
+	void *data;
+	struct amdgpu_device *adev;
+
+	struct list_head list;
+
+};
 struct amdgpu_autodump {
 	struct completion		dumping;
 	struct wait_queue_head		gpu_hang;
@@ -39,9 +47,9 @@ struct amdgpu_autodump {
 int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_fini(struct amdgpu_device *adev);
-int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
-			     const struct drm_info_list *files,
-			     unsigned nfiles);
+void amdgpu_debugfs_add_files(struct amdgpu_device *adev, const char *name,
+			      int (*show)(struct seq_file *m, void *data),
+			      void *data);
 int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b7ee587484b2..5eac4ce1c508 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1250,6 +1250,7 @@ static void
 amdgpu_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
 
 #ifdef MODULE
 	if (THIS_MODULE->state != MODULE_STATE_GOING)
@@ -1259,6 +1260,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	amdgpu_driver_unload_kms(dev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
+	amdgpu_debugfs_fini(adev);
 	drm_dev_put(dev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index d56f4023ebb3..00bb64fc88af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -699,9 +699,9 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
 #if defined(CONFIG_DEBUG_FS)
 static int amdgpu_debugfs_fence_info(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+
+	struct amdgpu_debugfs_info_node *node = (struct amdgpu_debugfs_info_node *) m->private;
+	struct amdgpu_device *adev = node->adev;
 	int i;
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
@@ -748,46 +748,37 @@ static int amdgpu_debugfs_fence_info(struct seq_file *m, void *data)
  */
 static int amdgpu_debugfs_gpu_recover(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+
+	struct amdgpu_debugfs_info_node *node = (struct amdgpu_debugfs_info_node *) m->private;
+	struct amdgpu_device *adev = node->adev;
 	int r;
 
-	r = pm_runtime_get_sync(dev->dev);
+	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
-		pm_runtime_put_autosuspend(dev->dev);
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 		return 0;
 	}
 
 	seq_printf(m, "gpu recover\n");
 	amdgpu_device_gpu_recover(adev, NULL);
 
-	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	return 0;
 }
-
-static const struct drm_info_list amdgpu_debugfs_fence_list[] = {
-	{"amdgpu_fence_info", &amdgpu_debugfs_fence_info, 0, NULL},
-	{"amdgpu_gpu_recover", &amdgpu_debugfs_gpu_recover, 0, NULL}
-};
-
-static const struct drm_info_list amdgpu_debugfs_fence_list_sriov[] = {
-	{"amdgpu_fence_info", &amdgpu_debugfs_fence_info, 0, NULL},
-};
 #endif
 
 int amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	if (amdgpu_sriov_vf(adev))
-		return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list_sriov,
-						ARRAY_SIZE(amdgpu_debugfs_fence_list_sriov));
-	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list,
-					ARRAY_SIZE(amdgpu_debugfs_fence_list));
-#else
-	return 0;
+	amdgpu_debugfs_add_files(adev, "amdgpu_fence_info",
+				 amdgpu_debugfs_fence_info, NULL);
+
+	if (!amdgpu_sriov_vf(adev))
+		amdgpu_debugfs_add_files(adev, "amdgpu_gpu_recover",
+					 amdgpu_debugfs_gpu_recover, NULL);
 #endif
+	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 5b50860eece4..dda268336bb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -838,8 +838,9 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 #if defined(CONFIG_DEBUG_FS)
 static int amdgpu_debugfs_gem_info(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct amdgpu_debugfs_info_node *node = (struct amdgpu_debugfs_info_node *) m->private;
+	struct amdgpu_device *adev = node->adev;
+	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_file *file;
 	int r;
 
@@ -877,16 +878,13 @@ static int amdgpu_debugfs_gem_info(struct seq_file *m, void *data)
 	return 0;
 }
 
-static const struct drm_info_list amdgpu_debugfs_gem_list[] = {
-	{"amdgpu_gem_info", &amdgpu_debugfs_gem_info, 0, NULL},
-};
 #endif
 
 int amdgpu_debugfs_gem_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_gem_list,
-					ARRAY_SIZE(amdgpu_debugfs_gem_list));
+	amdgpu_debugfs_add_files(adev, "amdgpu_gem_info",
+				 amdgpu_debugfs_gem_info, NULL);
 #endif
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 7645223ea0ef..836e5ea5143a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -455,9 +455,8 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev)
 
 static int amdgpu_debugfs_sa_info(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_debugfs_info_node *node = (struct amdgpu_debugfs_info_node *) m->private;
+	struct amdgpu_device *adev = node->adev;
 
 	seq_printf(m, "--------------------- DELAYED --------------------- \n");
 	amdgpu_sa_bo_dump_debug_info(&adev->ib_pools[AMDGPU_IB_POOL_DELAYED],
@@ -470,19 +469,13 @@ static int amdgpu_debugfs_sa_info(struct seq_file *m, void *data)
 
 	return 0;
 }
-
-static const struct drm_info_list amdgpu_debugfs_sa_list[] = {
-	{"amdgpu_sa_info", &amdgpu_debugfs_sa_info, 0, NULL},
-};
-
 #endif
 
 int amdgpu_debugfs_sa_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_sa_list,
-					ARRAY_SIZE(amdgpu_debugfs_sa_list));
-#else
-	return 0;
+	amdgpu_debugfs_add_files(adev, "amdgpu_sa_info",
+				 amdgpu_debugfs_sa_info, NULL);
 #endif
+	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index e365c4fdcfe3..6c7296754ef6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1289,9 +1289,9 @@ const int amdgpu_max_kms_ioctl = ARRAY_SIZE(amdgpu_ioctls_kms);
 
 static int amdgpu_debugfs_firmware_info(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+
+	struct amdgpu_debugfs_info_node *node = (struct amdgpu_debugfs_info_node *) m->private;
+	struct amdgpu_device *adev = node->adev;
 	struct drm_amdgpu_info_firmware fw_info;
 	struct drm_amdgpu_query_fw query_fw;
 	struct atom_context *ctx = adev->mode_info.atom_context;
@@ -1496,18 +1496,14 @@ static int amdgpu_debugfs_firmware_info(struct seq_file *m, void *data)
 
 	return 0;
 }
-
-static const struct drm_info_list amdgpu_firmware_info_list[] = {
-	{"amdgpu_firmware_info", amdgpu_debugfs_firmware_info, 0, NULL},
-};
 #endif
 
 int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	return amdgpu_debugfs_add_files(adev, amdgpu_firmware_info_list,
-					ARRAY_SIZE(amdgpu_firmware_info_list));
-#else
-	return 0;
+	amdgpu_debugfs_add_files(adev, "amdgpu_firmware_info",
+				 amdgpu_debugfs_firmware_info,
+				 NULL);
 #endif
+	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ce92768cd146..0eb2f7282330 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2255,10 +2255,10 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 
 static int amdgpu_mm_dump_table(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	unsigned ttm_pl = (uintptr_t)node->info_ent->data;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+
+	struct amdgpu_debugfs_info_node *node = (struct amdgpu_debugfs_info_node *) m->private;
+	unsigned ttm_pl = (uintptr_t)node->data;
+	struct amdgpu_device *adev = node->adev;
 	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev, ttm_pl);
 	struct drm_printer p = drm_seq_file_printer(m);
 
@@ -2266,18 +2266,6 @@ static int amdgpu_mm_dump_table(struct seq_file *m, void *data)
 	return 0;
 }
 
-static const struct drm_info_list amdgpu_ttm_debugfs_list[] = {
-	{"amdgpu_vram_mm", amdgpu_mm_dump_table, 0, (void *)TTM_PL_VRAM},
-	{"amdgpu_gtt_mm", amdgpu_mm_dump_table, 0, (void *)TTM_PL_TT},
-	{"amdgpu_gds_mm", amdgpu_mm_dump_table, 0, (void *)AMDGPU_PL_GDS},
-	{"amdgpu_gws_mm", amdgpu_mm_dump_table, 0, (void *)AMDGPU_PL_GWS},
-	{"amdgpu_oa_mm", amdgpu_mm_dump_table, 0, (void *)AMDGPU_PL_OA},
-	{"ttm_page_pool", ttm_page_alloc_debugfs, 0, NULL},
-#ifdef CONFIG_SWIOTLB
-	{"ttm_dma_page_pool", ttm_dma_page_alloc_debugfs, 0, NULL}
-#endif
-};
-
 /*
  * amdgpu_ttm_vram_read - Linear read access to VRAM
  *
@@ -2483,8 +2471,6 @@ static const struct file_operations amdgpu_ttm_iomem_fops = {
 int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	unsigned count;
-
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 	umode_t mode = S_IFREG | S_IRUGO;
 	struct dentry *root = minor->debugfs_root;
@@ -2493,15 +2479,26 @@ int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
 				 &amdgpu_ttm_vram_fops, adev->gmc.mc_vram_size);
 	debugfs_create_file("amdgpu_iomem", mode, root, adev,
 			    &amdgpu_ttm_iomem_fops);
-	count = ARRAY_SIZE(amdgpu_ttm_debugfs_list);
 
+	amdgpu_debugfs_add_files(adev, "amdgpu_vram_mm", amdgpu_mm_dump_table,
+				 (void *)TTM_PL_VRAM);
+	amdgpu_debugfs_add_files(adev, "amdgpu_gtt_mm", amdgpu_mm_dump_table,
+				 (void *)TTM_PL_TT);
+	amdgpu_debugfs_add_files(adev, "amdgpu_gds_mm", amdgpu_mm_dump_table,
+				 (void *)AMDGPU_PL_GDS);
+	amdgpu_debugfs_add_files(adev, "amdgpu_gws_mm", amdgpu_mm_dump_table,
+				 (void *)AMDGPU_PL_GWS);
+	amdgpu_debugfs_add_files(adev, "amdgpu_oa_mm", amdgpu_mm_dump_table,
+				 (void *)AMDGPU_PL_OA);
+	amdgpu_debugfs_add_files(adev, "ttm_page_pool", ttm_page_alloc_debugfs,
+				 NULL);
 #ifdef CONFIG_SWIOTLB
-	if (!(adev->need_swiotlb && swiotlb_nr_tbl()))
-		--count;
-#endif
 
-	return amdgpu_debugfs_add_files(adev, amdgpu_ttm_debugfs_list, count);
-#else
-	return 0;
+	if ((adev->need_swiotlb && swiotlb_nr_tbl()))
+		amdgpu_debugfs_add_files(adev, "ttm_dma_page_pool",
+					 ttm_dma_page_alloc_debugfs, NULL);
+
 #endif
+#endif
+	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 360952129b6d..1d28b1c01874 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2452,9 +2452,8 @@ static ssize_t dtn_log_write(
  */
 static int current_backlight_read(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_debugfs_info_node *node = (struct amdgpu_debugfs_info_node *) m->private;
+	struct amdgpu_device *adev = node->adev;
 	struct amdgpu_display_manager *dm = &adev->dm;
 
 	unsigned int backlight = dc_link_get_backlight_level(dm->backlight_link);
@@ -2470,9 +2469,8 @@ static int current_backlight_read(struct seq_file *m, void *data)
  */
 static int target_backlight_read(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_debugfs_info_node *node = (struct amdgpu_debugfs_info_node *) m->private;
+	struct amdgpu_device *adev = node->adev;
 	struct amdgpu_display_manager *dm = &adev->dm;
 
 	unsigned int backlight = dc_link_get_target_backlight_pwm(dm->backlight_link);
@@ -2483,8 +2481,10 @@ static int target_backlight_read(struct seq_file *m, void *data)
 
 static int mst_topo(struct seq_file *m, void *unused)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
+
+	struct amdgpu_debugfs_info_node *node = (struct amdgpu_debugfs_info_node *) m->private;
+	struct amdgpu_device *adev = node->adev;
+	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter conn_iter;
 	struct amdgpu_dm_connector *aconnector;
@@ -2504,12 +2504,6 @@ static int mst_topo(struct seq_file *m, void *unused)
 	return 0;
 }
 
-static const struct drm_info_list amdgpu_dm_debugfs_list[] = {
-	{"amdgpu_current_backlight_pwm", &current_backlight_read},
-	{"amdgpu_target_backlight_pwm", &target_backlight_read},
-	{"amdgpu_mst_topology", &mst_topo},
-};
-
 /*
  * Sets the force_timing_sync debug optino from the given string.
  * All connected displays will be force synchronized immediately.
@@ -2582,12 +2576,12 @@ int dtn_debugfs_init(struct amdgpu_device *adev)
 
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 	struct dentry *root = minor->debugfs_root;
-	int ret;
 
-	ret = amdgpu_debugfs_add_files(adev, amdgpu_dm_debugfs_list,
-				ARRAY_SIZE(amdgpu_dm_debugfs_list));
-	if (ret)
-		return ret;
+	amdgpu_debugfs_add_files(adev, "amdgpu_current_backlight_pwm",
+				 current_backlight_read, NULL);
+	amdgpu_debugfs_add_files(adev, "amdgpu_target_backlight_pwm",
+				 target_backlight_read, NULL);
+	amdgpu_debugfs_add_files(adev, "amdgpu_mst_topology", mst_topo, NULL);
 
 	debugfs_create_file("amdgpu_dm_dtn_log", 0644, root, adev,
 			    &dtn_log_fops);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5fa65f191a37..1bbe7b8738ea 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3786,9 +3786,10 @@ static void amdgpu_parse_cg_state(struct seq_file *m, u32 flags)
 
 static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+
+	struct amdgpu_debugfs_info_node *node = (struct amdgpu_debugfs_info_node *) m->private;
+	struct amdgpu_device *adev = node->adev;
+	struct drm_device *dev = adev_to_drm(adev);
 	u32 flags = 0;
 	int r;
 
@@ -3835,17 +3836,13 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
 
 	return r;
 }
-
-static const struct drm_info_list amdgpu_pm_info_list[] = {
-	{"amdgpu_pm_info", amdgpu_debugfs_pm_info, 0, NULL},
-};
 #endif
 
 int amdgpu_debugfs_pm_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	return amdgpu_debugfs_add_files(adev, amdgpu_pm_info_list, ARRAY_SIZE(amdgpu_pm_info_list));
-#else
-	return 0;
+	amdgpu_debugfs_add_files(adev, "amdgpu_pm_info",
+				 amdgpu_debugfs_pm_info, NULL);
 #endif
+	return 0;
 }
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
