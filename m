Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003BCC48BCD
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93EA610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93EA610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F6E06EC57;
	Tue,  8 Jun 2021 21:41:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D564F6EC55
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMHGYHwE9uPl8+z0ilOtwDqnbEs7GXqOpYn9HPyJ4lZuEX3LVKHPAtfLG0RAdqrUrxpnxlbaADeJUACm1oAb3yD3f3MTJWONBxx9vPzTE2DzezE52/2hKHRyI2k2opDIunmrukTKsa8FUnYoYmToJzgTSJ27Yc8QEsePwWkZtKXTbZ9n834k1IC8zqzS50xzLlRZxuoO79Hgz+XTLeyi2hdjHecF1/ya0Ih4fsa300fzBbq0keiE4N6ec7A+0YZKqOdKhvaRo5Z8p69PR/6fbZM8pZ4VH5L5qOw286iYaDo43hDjfZC2c2A21DmNzjlZXaZOgYm2sAGQNnpP87f+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tn15cSMU0K/H7aDpDr0pX36fXJBCXC5Rk+/iXEfVIe4=;
 b=Y8OpLc+6fTGVB6V5nJFuteMEVnk0O6LttVJGVQM6qNVS+8GJ/zldfTpaEqoALxUuaaIROTaQRUxoVoOp6JbvGCiCazC6thBeIyUFMiy2uM7rDt8TMAhs+P8jqdQ9TLVOTXe2y8dsT8QxU6w7SaBbGIjELUyNnAoMh2Xo2sO3+0FrZIc0Zkm+ONcEr9u9MnWK8ksNsr6ok6/Uq5JLDTnGRKQmzMzW/woBt91+axZ1U3vYLCMp21dF4ZGF6TO4/NTzn6kGN1JvkQlqdbEvfFjRtaskrIjoMXcKagnrCZDn5J22HoVmp/r+1ML/MtVKnNdEr1xyZBtt3eLVrQ1owjx7rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tn15cSMU0K/H7aDpDr0pX36fXJBCXC5Rk+/iXEfVIe4=;
 b=2evI9UPyStMQ7svixs4/y3nqeVmRPXD1/kGZWmNcUdwlhtYqfZdRM48Xp+YohDJnWQGjX53XH4xKKJEDNsbi+HN7/r6Xx1UsDkrmN/nYqEEPdgZYkjrD6vGnEbxOnV0RXGdk0KE0c840Bmh3HHIW5krYWOsqQEQkXOY5XPnHZP0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB4678.namprd12.prod.outlook.com (2603:10b6:4:a9::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.26; Tue, 8 Jun
 2021 21:41:10 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:41:10 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 32/40] drm/amdgpu: Return result fix in RAS
Date: Tue,  8 Jun 2021 17:39:46 -0400
Message-Id: <20210608213954.5517-33-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608213954.5517-1-luben.tuikov@amd.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 691cc72b-c5f5-4f46-a53e-08d92ac60fe9
X-MS-TrafficTypeDiagnostic: DM5PR12MB4678:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB4678D2F9497A67F310FAF24D99379@DM5PR12MB4678.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rn6a5S+jqoP1XJufNePLIodhGV3qIkEhTq/bSVS/Q034yqnadyyRdvnCvfovjLTPCJ5WiqqwXUQJTIKGxnkSI7FuBLkP163UbUc0dOiLGXzdDtLoNYzlxaU2DK7lkkhBMVbB0eRMT23MC0A1ZvW1eJiufpDflleWJ8KnQuG4NFb0c3Dibe5e6SwPNJCm0wKNzcbQyl7xgk9r6wY/3BRZNGx/78ibsKmZMcVSCyVLBeuVtIBAlgYNv0xGr4PVULsxl09QI5SoOJqvDmnI9ckNMUkBYhhxVQ8F2Y7AUmzJSSEpy8tyDHaPFNIL5hrj4xH2BlkdnGTZip1kN5NaAL+Yywaytap2Q1eNLMbNJKf8UpSfn2jqUDT5QZ0lnKdBmMI7rnBEYNnRzDMPCWFAxAmfteU97WLbnMrKDWZsXBjE00yEuh3YnMNvs6V9amQpUdTA9xCal18IIK1hTmhVbTxtDBW0tOgEYT+pxkdpGxrYYacwbLMNYZLGcsrWDgJ53ojnMoO43nddejGxcfgS6OJvzK0DE0tHlwkVORVinggTa6jZd1z98cBagrjk7gWMx/DD5mLFQwGP7RVNkjYtRrihbCwWSLdaM11WfLh27d1aXbOw2LL6PYF+9vcLWYFyzh/27npSldvZrp5xHJQ7UEqqVwVyFFq782ZSFdU+jj5ckUyd16QR72iA6wO+H5+nrpZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(2906002)(26005)(6916009)(55236004)(16526019)(8676002)(316002)(66556008)(6486002)(52116002)(66946007)(66476007)(86362001)(83380400001)(1076003)(38100700002)(8936002)(2616005)(478600001)(956004)(36756003)(54906003)(4326008)(186003)(5660300002)(44832011)(6506007)(6512007)(38350700002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?muCiw/Jw77YdPq1fJpPW+4JNTXt0ETNodNljxa2QJA9TAUy8A8YakoNil3WQ?=
 =?us-ascii?Q?AXnrKmmP2xbqMth0gQ78LzEGZ7C77WFK8hg75cU7fNi78oSvJuZofV+PtPfu?=
 =?us-ascii?Q?fxVtdoGSCEuxkSSufybgREuZO9Q+59/gwgpuIMTDY2TJrjB/7HhsDY66rBwm?=
 =?us-ascii?Q?YjfJolk9hgTNLQJITUzldBk4gE9jefrg46RhkU+QCOurFJ5OUexHE7mWW8gT?=
 =?us-ascii?Q?XxbnYDL7sNbs2z0G3qvXTnlNzrxSJyjnmXXDVIkfqMDPEDm+SPA3eucxjJGT?=
 =?us-ascii?Q?nYypMizPs5pj4orHUzjBKU7uUMw9Ui54j+GeBof7dW14dkwff8Jm/hRfRcJw?=
 =?us-ascii?Q?SLl/c8NLxauNl/7FD2xeOjfG27Dn/VmcSv5WJ7sywP72A32XUS9Mk96yiYlU?=
 =?us-ascii?Q?1+Neu1aoqHVnaSgc4n5XsR2fJ4EHxTd70KwK94MX21/d9mml6LJJOCTSLS9t?=
 =?us-ascii?Q?pGLo+rtwEpE03M9b5Ni4aNRtNaUgRpRir+w+SKvQpQrLuL2KmPql/xbwBjsa?=
 =?us-ascii?Q?GzpKNy0r2LSGex2DJhIMAO4bfqd9HIfz+gLiEorTM3rbi7ztAHmLPixzpNYe?=
 =?us-ascii?Q?emBUCBbZnCvv/l+9t6XxgqKOiw8IneDwsXt1m1mHpvOpPzdTdn9DcVh2IN/s?=
 =?us-ascii?Q?nN1ZW8Uwi/1qmHUnC6EMzsMqLPZPveun09hBLihK5BMld5ovhALGytq57VNs?=
 =?us-ascii?Q?VMTH+VdaDmQ6tDe3D5DV0nI1LpirH3h6e9abuMD1FE6h27jzZC2VwAAD0WZP?=
 =?us-ascii?Q?90hOxl/pA+jLzdpKAnt7iK1jnLJp9/+AvXNiMDNMTGwgGon9+mAWfUhu84HC?=
 =?us-ascii?Q?dDfjSSpfiFRJ7ePpDP4j+heIjVwld98ipoAzGSSLOM0j2aj3PQgMlLT950UZ?=
 =?us-ascii?Q?R7f1H9c9KWxv6cYB2sb54ux/8oJe+bvuOSJatzaelXtmeFqDh8q8izNGocYH?=
 =?us-ascii?Q?2Hc3Gis7JfP2czOR2YG4SyPTygbxSEy/ifM+5fAYZJj6c605u4SMenATRaje?=
 =?us-ascii?Q?Dm/Ca9U8MC/hJ+A4pIkJ0Z7G0sKbcrEfIC8zCPvx6Np4OIykvqZvsydyh+P1?=
 =?us-ascii?Q?wJPraODnfTueDF+u/HjhIfmig7cof9t2rtAsfyHhY/4dgtxRiok4l90XkX5+?=
 =?us-ascii?Q?A0nRACHYmMLKfRjzkjg+0SIxV3q5BuenvfOrG/FBxBrzr273mrwNgJ2TwiCc?=
 =?us-ascii?Q?biBwUrJl/xBpbiAEFG2i+cQrZCwxWRARrgMVW1Z/NYuEKJmH4awl+g5WZnQA?=
 =?us-ascii?Q?ruSIjJvANJwWAXVKr0RJHj4WwV0qmGjV4RKz735zStW1sDjjeJzpab0cSY5m?=
 =?us-ascii?Q?RqWyahqtj7YhHiYF4WP9gbmK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691cc72b-c5f5-4f46-a53e-08d92ac60fe9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:40.9666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJalt8YJtb6fwxTn5HrukUkgsAOiSu8qgaX/q6YDruUvYCOzaf83/y50ng4mK4jK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4678
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
index e3ad081eddd40b..66c96c65e7eeb9 100644
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
