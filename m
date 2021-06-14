Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE9FC47094
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E19611EE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E19611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 482F46E141;
	Mon, 14 Jun 2021 17:47:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9281B6E14C
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfS+u/6Cq97ktI0ZAQxH8UQWTa8t66lfeDdnzb9GOcEsfPZSMd25RGaYIGFOCLvnX/LcV5vzdNrUuol7473HHgT5Ht7V1SuevLGda+vvTYZEFsDYAUysd/4K+iOhZf4FDZXX/ecWgkNcJ/vEq9+1/4tfThZFJdWYU4UPgzymjHjKYilQvDoMsC8KT6T6h8QzQoZmnY+QTKZOsmeoCJSy/3TXYw6rTqVdv9NoeQR0WmiT+zZ9vIbbEg3l7MOD8eUzX7bXW9Xwf4gK/jaQ8iQr2rOkEqQSea7zY76KCeGE5yrWrIuipzxTk0/dyEhUwovXMnqseXVC08/r2xubsVCvlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHFnq6swIskOi0OalUh5AWTSd8oidYa6crbEHBh19Fs=;
 b=IV4M5zXDtuWoDqrdCBX2oEWwHslYv8m+XiB+rQfuwBc7lilNC38AX0YUpal+THPpQuvpbbA482+zlOWul4kWR7AMpon9mq6kakeHJ8wcptkNl7hQDxi5mAJHpyMFRLBE56VXSNFW1mpUsxhRqBp1IVygyUCg9olx4xJu6DgwHTOheau5TZvz+oprtbaBNPGWGWKEA/qzNdC6eJ4kmHikSqmtFHAO+5+GZX8mSJuHtHBflto3ZK+PFJOwwBzljxedUqcfsfDotc6r30fWF33L0OoxWcRwUUibbw2rKvzvu5idOYQue59i3DEAJTriTaGH4xjeE/qQj1lmS+HpHmy7hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHFnq6swIskOi0OalUh5AWTSd8oidYa6crbEHBh19Fs=;
 b=Atf6CXJ7UOj66Vqsrql8Yg7qa9MrmwNtYC4ZNWGQCuI0CerYI6OaUuhvzSNd8RZb4kmNB1b8e7cPPV9BxttKrmMr15FKDKMg0OBI5mPtDx1oZpxxJMyGmwWJKupz/ar1z1cN+6xA9ouQ2EM7u1OiXIcURRmVPzoa3mHXX/lRbBI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3577.namprd12.prod.outlook.com (2603:10b6:5:3a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 17:47:45 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:45 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 32/40] drm/amdgpu: Return result fix in RAS
Date: Mon, 14 Jun 2021 13:46:24 -0400
Message-Id: <20210614174632.20818-33-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614174632.20818-1-luben.tuikov@amd.com>
References: <20210614174632.20818-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31fbf76b-f0b8-47b5-feb8-08d92f5c723f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35778440DDDFB1246F90E55B99319@DM6PR12MB3577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vdd85Ly18gQWtwtsUFOrA90id88r5JE1Vbc3R1MoNgdVvOIZ8N9TKmi4xoyzD4ZJxiHlcEQuaZWnIeyDoJJawRS0qul4Vu2sFJkoLPYz+RzNcruVKKbl6jiq/JWa4CmH9IoJdVzg0kJs0i8PRJSbEcNQgn7EIqOIVr1aTnfVvz6HCkdzG6F3gIkXII/+ugfj+xnDhaAN0GyrAoWX7NEbi0BpBNfey1xRhIhAHv0314T2QBtuL1BJCwRZJAL8adSsJBOQpJwOaZn+nnebdlFbB4orG5p7WQnrCuwL/8bM3NLDfGX+782qXj6IO8PJWfJi2BK+fgoB/YTvxgXb7jrRzpI5SK8ADytnuAjY43kdTSdR7NGrdGBJ7v/vj3+RHcrjzOQxO0aGuGguyoeAVdxzokCC1M9uOmAjqNyqTDOHFw6Ukk8Ld8SyBkDhn+MJT4JKRSKyyJ3uadLH+AYNUjviib5jJWxnKmHIIrZeuvTUvr6nEI6PgImzed2XJMr3jzN6mNUzhjmfLMWr04zN/Fgoi59XLAhXNcgMlJciWlzPa9RDcn8pEAtuAh1XrWtzyqAZxdy3DjTIAxWRCgWQxg9I22X8XnChvfYsj5xo8uf1BkfAey6o3tkLsyMcatE1oG0lYaUbIDHysfFMR8eAZynePqtCQNe/2CUfJ5LJFOw+zrcMsCYBYEZK+pg4FOjs5Wc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(44832011)(6512007)(36756003)(6486002)(16526019)(186003)(86362001)(52116002)(38350700002)(38100700002)(8676002)(2906002)(5660300002)(8936002)(478600001)(316002)(54906003)(66476007)(6916009)(6666004)(66556008)(26005)(83380400001)(956004)(55236004)(1076003)(2616005)(6506007)(4326008)(66946007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GmbgnzofLWbA0R1bgU9m7r00FpOZ4P1No33SJGomJYgflciFW4WtGh3xbj4r?=
 =?us-ascii?Q?Gjfi9HXwgYwwyqjSRQjUzw/64SQsGR8LHXi0G7A5JbjUVIqIKq9JPA90cLFD?=
 =?us-ascii?Q?LZsLUakzrGRUJZUK7P2HpAg2EQ4E+EZFEWKlMZvGUj+WXbaV7o0CAU52vdcd?=
 =?us-ascii?Q?RpUjkrCNLEE0im0OgTqx4hRJeiSVFFA7hnVu3Q+YLZNnDgMJfCQjHRQsw+N3?=
 =?us-ascii?Q?egL+iZumwXl9sA4a7nFvNFKDJ9haMRG4U8v1mQw/NTpZwzSM7IpbY6WlpCZX?=
 =?us-ascii?Q?WxVAcJtfrQG2Y5XtSM6fIJYw5K97Bv15UlM+5YNhIWmxA/umOKx/a38QyUEg?=
 =?us-ascii?Q?JKDA/6rkcob8jvB6rJpVyNv9vGKTe21Sr9hf7gJ6HOfBzq/M3/fOdheJXMSq?=
 =?us-ascii?Q?boZ887NWQOBBvENOKo8u614DnHf+AQW4IKKt8lMTgTcgmDSL/hvnAsvoMBpa?=
 =?us-ascii?Q?HM/6wFaGM8O8h7qhabZ4YTzdKqW9sk805OWduCwiaZFJyS3ZApZEG7nIujmF?=
 =?us-ascii?Q?DMKiN/UFvDPJANBx7IDMxt+zEsy9vPK2GYNvP8/wriiqpiRY2LXkUHuWVNLU?=
 =?us-ascii?Q?hePl4idxFmPIvbevpObNpUI/HDxSyjNqtELb0vt+PZAVmiNbDjOfwTv00zAm?=
 =?us-ascii?Q?Uy4zB59H850yC6oqeHdFz0K/7cXvBxAjwmfdZaN/9BJ8Q6WcBJCttLGmGHyu?=
 =?us-ascii?Q?ugbA5sS/3ltqUNtjtDFekrDVJdX7KH0DCHO8smZ0Ow9MYQuHu+LS5fyepSPm?=
 =?us-ascii?Q?Sm0H+/rQ9OK0xWyNuzERloj3ibv2RMR+4RICtiFda3mrCj4M53SYJd8No+Jg?=
 =?us-ascii?Q?629V+I29Vx+f2v0ppR2Z6YiqH3A+Z4Iwa3dBWaAShWR49kEaJxXTLV34J5b8?=
 =?us-ascii?Q?pvAoq1XnUBkupFmmHKorrdopTOuzivH3q7xI5hQubj6DC5GsDaNntshhPz+U?=
 =?us-ascii?Q?4H4+y1OX6zYgz8o7BlMHfK8oicTtf7G2FP6UBiE6bjl9vZV+l9n8vuvwc1Sp?=
 =?us-ascii?Q?DAJmEtulGxuuobZejv6C9nxF476Xz5HL8exFUW8efcFrIJUt9P44j/iBtZQm?=
 =?us-ascii?Q?Qeyu9TQhNL3rDNdIajUX1B/bOFmrsl8gHEGTQ2XqWu+LCPz9AIAJgbCzlKIx?=
 =?us-ascii?Q?P7MSt8YuPiE/xdH0IXlk4UIuZgGECfTprPtk5VJnEjvP71CsttyFIEwe9736?=
 =?us-ascii?Q?boLjWCWPry9swaev93GI1p4mS74oQzmnJBjH5WvjeHV3R9OCPmsxcY3i03Pc?=
 =?us-ascii?Q?f/7z4DMOiHbgG8AJ+OuMvEuxsfRBtSebPb9WwdvugBSUj3OhJ0ALLg1ICmqk?=
 =?us-ascii?Q?VFNpAzc9x2WP7qkIjJ3Zvxjl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fbf76b-f0b8-47b5-feb8-08d92f5c723f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:15.1158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39yVpAnfXlPL6HsMtWV71Vhf0AP7IQBxEQ6Jv36MPxyF6RMXC1soSUF39ODbu/0/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3577
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The low level EEPROM write method, doesn't return
1, but the number of bytes written. Thus do not
compare to 1, instead, compare to greater than 0
for success.

Other cleanup: if the lower layers returned
-errno, then return that, as opposed to
overwriting the error code with one-fits-all
-EINVAL. For instance, some return -EAGAIN.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c    |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 22 +++++++++++--------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c    |  3 +--
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index a5a87affedabf1..a4815af111ed12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -105,8 +105,7 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 	int r;
 	u16 len;
 
-	r = 0;
-	for ( ; buf_size > 0;
+	for (r = 0; buf_size > 0;
 	      buf_size -= len, eeprom_addr += len, eeprom_buf += len) {
 		/* Set the EEPROM address we want to write to/read from.
 		 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9a878b5a7665fb..18dee704ccf4dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -355,8 +355,9 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
  *	to see which blocks support RAS on a particular asic.
  *
  */
-static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *buf,
-		size_t size, loff_t *pos)
+static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
+					     const char __user *buf,
+					     size_t size, loff_t *pos)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
 	struct ras_debug_if data;
@@ -370,7 +371,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
 
 	ret = amdgpu_ras_debugfs_ctrl_parse_data(f, buf, size, pos, &data);
 	if (ret)
-		return -EINVAL;
+		return ret;
 
 	if (data.op == 3) {
 		ret = amdgpu_reserve_page_direct(adev, data.inject.address);
@@ -439,21 +440,24 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
  * will reset EEPROM table to 0 entries.
  *
  */
-static ssize_t amdgpu_ras_debugfs_eeprom_write(struct file *f, const char __user *buf,
-		size_t size, loff_t *pos)
+static ssize_t amdgpu_ras_debugfs_eeprom_write(struct file *f,
+					       const char __user *buf,
+					       size_t size, loff_t *pos)
 {
 	struct amdgpu_device *adev =
 		(struct amdgpu_device *)file_inode(f)->i_private;
 	int ret;
 
 	ret = amdgpu_ras_eeprom_reset_table(
-			&(amdgpu_ras_get_context(adev)->eeprom_control));
+		&(amdgpu_ras_get_context(adev)->eeprom_control));
 
-	if (ret == 1) {
+	if (ret > 0) {
+		/* Something was written to EEPROM.
+		 */
 		amdgpu_ras_get_context(adev)->flags = RAS_DEFAULT_FLAGS;
 		return size;
 	} else {
-		return -EIO;
+		return ret;
 	}
 }
 
@@ -1991,7 +1995,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	kfree(*data);
 	con->eh_data = NULL;
 out:
-	dev_warn(adev->dev, "Failed to initialize ras recovery!\n");
+	dev_warn(adev->dev, "Failed to initialize ras recovery! (%d)\n", ret);
 
 	/*
 	 * Except error threshold exceeding case, other failure cases in this
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 17cea35275e46c..dc48c556398039 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -335,7 +335,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 		ret = amdgpu_ras_eeprom_reset_table(control);
 	}
 
-	return ret == 1 ? 0 : -EIO;
+	return ret > 0 ? 0 : -EIO;
 }
 
 static void __encode_table_record_to_buff(struct amdgpu_ras_eeprom_control *control,
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 65035256756679..7f48ee020bc03e 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -222,7 +222,7 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
 				       u32 numbytes, u32 i2c_flag)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
-	uint32_t bytes_sent, reg, ret = 0;
+	u32 bytes_sent, reg, ret = I2C_OK;
 	unsigned long  timeout_counter;
 
 	bytes_sent = 0;
@@ -290,7 +290,6 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
 	}
 
 	ret = smu_v11_0_i2c_poll_tx_status(control);
-
 Err:
 	/* Any error, no point in proceeding */
 	if (ret != I2C_OK) {
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
