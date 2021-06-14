Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A34C49361
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7636760FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7636760FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE2426E133;
	Mon, 14 Jun 2021 17:47:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 604A86E122
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HASDNU50O5xmoQQXLNL/K0KGzjRjkDJJ8FmD2/JIBaxEYF7dSpgUFh0bOiPjD17Z3Z9tkt08wMpC8+OehNRD+5z0qjDTjOAMEvJRC5XqMrKMuUeitgCSI3suDD27L2JRE5qjp+ckWczgmZ0SN4rKyammw2psPzuxkszmwPwnF6b028bTxao6xAO4TRG9jm6DeWhGcjDnPDw+7joBx1/HTMY5Ukx9bB3mSUtgtV+1BN0hYbZjaQzjRq6EXA8kFzo+W8ZoKe5a2kYlSXPtI4AQZ+ytB5s3JN/XWPaWm9xc7R4qpdOPw9Q5ImIj70jvUM/GySqvJQdDOrNbm177+k+Uew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ssrUyPCcFmbN4ljQsq87W8kjtn/fxeH9UveSO7GnXE=;
 b=EL4gCSl9wYlCamQMj6LBvP7/uTLuTG8rQBnp8ZFbnXScbml/rFJlM/PVSZzXgV4ie/ORoe8MP9yecTXDjxZ58O4s07FaVdA+K/E36J65tDhurn2LCd9ET/IJc9V4E00c+f647ycTeCXR1XxUCgt6HldeRWPtv3Zi9nnYamj6QCH68kAstUzbZ3fLfJ+xQbBHkWQuTXfkEAonAGDC+9rzm5kx4fc+9siL2OWU5v6n5IK/TAgan0nGNIZkdIb16WaJ7xKi69+YItxY/0ZEhPMaAL6w66tYwkXBdxBuxCPC6L5jjjcQ8awF5Or01QT9mBCClOqKJ9FAtEeCRbo49UxUfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ssrUyPCcFmbN4ljQsq87W8kjtn/fxeH9UveSO7GnXE=;
 b=udtD+YWVEQ6CzCMeLhSv+KzMRkzXjTZRYsW7tlkrPwvwU5+/tNDOwq6SbNb5VTzKhsk3jc0T6kpnTPR4jeFJtUiB7lxOZP0YAZiYt4c+2NN77OOra2aydN6bcOU4GfQTgqKWucJv/1puuiKh5eN2qPqdw34Tz3JElrmUZjvkWf4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:47:05 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:05 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/40] drm/amdgpu: RAS and FRU now use 19-bit I2C address
Date: Mon, 14 Jun 2021 13:46:14 -0400
Message-Id: <20210614174632.20818-23-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 810a42b2-96cc-45ca-7427-08d92f5c6c98
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4748F7D046417D4DE45041DF99319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tw/PGvfXksIbJ+zdQmpGPYG9RfHI9xgkdpGyPPE0x4sOv151Oia4aZ59yavvMvh5zaDHNZs4Ga7zJspAqRJV3IRYXaELuHzC41TWevvmepZ3CZqzboGDrfTADWKnQSO+z75FWyUshIXKnOtgGqU5ScP6jJJZwGQ08V0WMsUH8aI4X4o4AOuBBMRr3QLQ75S/B4R2lwUri/+tCHOeIZdY4TxKSuVnDQhoH/5QgsWbbOXlQs5bwVRfSaddFAdNK/AA8uG1rVJgIhf88xwlefdVHOW8SsvwCgK8Nro60eQxOGsjcYtg/jN/GPwJycIfCsPnure93E20vqtERxMyD+rXW6OzmR4RcZgvo1fsspThudKxZAM88tvFwLol6ArZMCMI4Zer8q3ihN7QnbxUfJDmXYzK1XQ5igQW5vC8LE2yYJcHQDUXzclxa6yfL3ZqKSf8fntxM8RUlq6B1tfPJRNsoAS3u7UVpkr58XzkZ6n1hnKQm6bvj5A0x98O6ovU0quzYXN4cKGsdqmCTis6umy/F3X8wkCuiT+Axt/VkKiKNHXrTQrEwdKNX05VTYW9CzzSSE0M/AJyyF3zXWdIa5eUJkjm3rzyYp61/X+YK/3M8V9q+CDI1R1rBplD2sSTVXTnxZ+n5wlDMcpNdBBkgtUiml8qU8dVh8AlZ2UKZxWT2CT+fTx0XEz1b9AaFLu3/wZ5rfe8SR+Iz9AZMRBGA3CMU/TqP+JkFE49QP9oEcL4mqElsR260AppCcTVHO7DmjIbXXPoNQvoet4aRbm54P1pusIBvgz7B78bSEiqohiFm6erbhPhEdcIqf3SPD0mmg8e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(1076003)(26005)(6512007)(30864003)(16526019)(186003)(4326008)(6666004)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(6916009)(38350700002)(478600001)(83380400001)(6506007)(966005)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fxg0i72JZNf1+b6CTgc5lmuSwKlh+CZFzrsOvCFMrfxCRQRyiy3jH6CiGuYh?=
 =?us-ascii?Q?3O/RA2jUqJhHofRYBPWjO3j6aYCLf3M7+1loJAfIG32zo+Rbg5diRYmpnXIp?=
 =?us-ascii?Q?Ez1Pv70pdtDWbORsDktwB22z3dOvoDJCLpoO0R5FRxTx2EEpi8mUlR7i1e65?=
 =?us-ascii?Q?yBnFUx/uO3RtuvFHj2AbTXvLyrwpPzcthwnR9CjVd8UtMj42ujRJ4Df+/4+Z?=
 =?us-ascii?Q?sLCfvQCxNTm40gEE7BckyruREiVXhsjrAROFVOIkWzJhLqklnjatCfCLBeP+?=
 =?us-ascii?Q?d3JC0YamCdDyosihbsGwa1WSQLFzTXBT5WhGUVpNoUuSC9wmoIYZ96J2FLmD?=
 =?us-ascii?Q?hrAlx85TO98suQHaBUO+KnX+ArB2JfZ4UoexcWXA9NxqoS1htTE3WHoDktBI?=
 =?us-ascii?Q?Rl+tzIIQn4KYm++Znj749GuUluLQDFqfSLbSQlaH9FYDnsn3vjsI4ZtthckP?=
 =?us-ascii?Q?kyuWMXtLQFuVGjnBjljQa42k6LCqx2ZFa2J+MjR0sHOLqYeSIrSfR9M0DmwS?=
 =?us-ascii?Q?vnH5Dcdd5E1z5tzD4iE9S3JrrtoEIo2vmpq8htQpfbcNcFJsPFrMntpfrejo?=
 =?us-ascii?Q?wMIIadMv89F0gQTHajHvgW+ynxvirJ786XX0h//ehW4L8AWXQHgCuJYW7roM?=
 =?us-ascii?Q?NEch0jSaLDdCUbyVGXOOwIjruWJytnDc1+7KzkPfcLVcoSP2RTUAfnHbbjzS?=
 =?us-ascii?Q?DTBTLN+4n2xbt465L1ZWBAX+Hj/DFKwo5OJrZ6VAbfSz+sWwKqRR7zQ3ZcTd?=
 =?us-ascii?Q?DCaHuHUT4KGNtoaPaXWs5Mex7QRaGJIl83GemVHxd262gvQqTZq/YTZ4RRPk?=
 =?us-ascii?Q?tKnNDPCGhE7SX2lOwGOcDhIz7TAVNqycd1/29cZnowc6RWWlZvvwxfYWV5EU?=
 =?us-ascii?Q?xR6ZJv7KpxUB9TC4ZXwuyoYAl+0U5tRY8ELkZoZPrCDGOms+xnhIWdqF9NdB?=
 =?us-ascii?Q?mGZvjxMQWLEwYEyifMhX6akzI8tvkpXJmNDxEhk0FV3pgItubaNOIgkO6c0y?=
 =?us-ascii?Q?tqNW0G7rl4aWPFH6LkcFC57Jtzyli20ekEPGSkPoV9hZ+M4YjR4vVpUHtKHT?=
 =?us-ascii?Q?HSlvU/9XqZxu4oa3mlC8CSFnqzwvCsXyJOlqOX4+E03BEniW9Yr4He7g70HO?=
 =?us-ascii?Q?YvRXTwsEe6A+aOW9A4bIVzuKnYC0qqPFk/Wyop3uFL5+N0f8M4EtGOk3cXbk?=
 =?us-ascii?Q?M1NqutV4Yykw56rt7vjs4Brz09c6YwFWf3rjvcqumWaMH7Mjs13BGTu1KuEJ?=
 =?us-ascii?Q?aK4QCg+bJSSxeSEZqwJmXexHiAAqECTZX3ofcMXYtMgoSslbzwDwo42JFs4c?=
 =?us-ascii?Q?lylsMLpVwOWwMi4Wz6qW1jZi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810a42b2-96cc-45ca-7427-08d92f5c6c98
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:05.6322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DknA9skEKrcWj84/99Rxiaz65b2sjFe3ZHdCCL/abbLRgKUwxTqQkJwXQGxw7pn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
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
 Alexander Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Convert RAS and FRU code to use the 19-bit I2C
memory address and remove all "slave_addr", as
this is now absolved into the 19-bit address.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: John Clements <john.clements@amd.com>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 19 ++---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 82 +++++++------------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 +-
 3 files changed, 39 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 2b854bc6ae34bb..69b9559f840ac3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -29,8 +29,8 @@
 #include "amdgpu_fru_eeprom.h"
 #include "amdgpu_eeprom.h"
 
-#define I2C_PRODUCT_INFO_ADDR		0x56
-#define I2C_PRODUCT_INFO_OFFSET		0xC0
+#define FRU_EEPROM_MADDR        0x60000
+#define I2C_PRODUCT_INFO_OFFSET 0xC0
 
 static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 {
@@ -62,12 +62,11 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 }
 
 static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
-			   unsigned char *buff)
+				  unsigned char *buff)
 {
 	int ret, size;
 
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, I2C_PRODUCT_INFO_ADDR,
-				 addrptr, buff, 1, true);
+	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, addrptr, buff, 1, true);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get size field");
 		return ret;
@@ -78,8 +77,8 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 	 */
 	size = buff[0] - I2C_PRODUCT_INFO_OFFSET;
 
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, I2C_PRODUCT_INFO_ADDR,
-				 addrptr + 1, buff, size, true);
+	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, addrptr + 1, buff, size,
+				 true);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get data field");
 		return ret;
@@ -91,8 +90,8 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 {
 	unsigned char buff[34];
-	int addrptr, size;
-	int len;
+	u32 addrptr;
+	int size, len;
 
 	if (!is_fru_eeprom_supported(adev))
 		return 0;
@@ -115,7 +114,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	 * Bytes 8-a are all 1-byte and refer to the size of the entire struct,
 	 * and the language field, so just start from 0xb, manufacturer size
 	 */
-	addrptr = 0xb;
+	addrptr = FRU_EEPROM_MADDR + 0xb;
 	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2b981e96ce5b9e..f316fb11b16d9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -28,11 +28,11 @@
 #include "atom.h"
 #include "amdgpu_eeprom.h"
 
-#define EEPROM_I2C_TARGET_ADDR_VEGA20		0x50
-#define EEPROM_I2C_TARGET_ADDR_ARCTURUS		0x54
-#define EEPROM_I2C_TARGET_ADDR_ARCTURUS_D342	0x50
-#define EEPROM_I2C_TARGET_ADDR_SIENNA_CICHLID   0x50
-#define EEPROM_I2C_TARGET_ADDR_ALDEBARAN        0x50	       
+#define EEPROM_I2C_MADDR_VEGA20         0x0
+#define EEPROM_I2C_MADDR_ARCTURUS       0x40000
+#define EEPROM_I2C_MADDR_ARCTURUS_D342  0x0
+#define EEPROM_I2C_MADDR_SIENNA_CICHLID 0x0
+#define EEPROM_I2C_MADDR_ALDEBARAN      0x0
 
 /*
  * The 2 macros bellow represent the actual size in bytes that
@@ -58,7 +58,6 @@
 #define EEPROM_HDR_START 0
 #define EEPROM_RECORD_START (EEPROM_HDR_START + EEPROM_TABLE_HEADER_SIZE)
 #define EEPROM_MAX_RECORD_NUM ((EEPROM_SIZE_BYTES - EEPROM_TABLE_HEADER_SIZE) / EEPROM_TABLE_RECORD_SIZE)
-#define EEPROM_ADDR_MSB_MASK GENMASK(17, 8)
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control))->adev
 
@@ -74,43 +73,43 @@ static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
 }
 
 static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
-				       uint16_t *i2c_addr)
+				       struct amdgpu_ras_eeprom_control *control)
 {
 	struct atom_context *atom_ctx = adev->mode_info.atom_context;
 
-	if (!i2c_addr || !atom_ctx)
+	if (!control || !atom_ctx)
 		return false;
 
 	if (strnstr(atom_ctx->vbios_version,
 	            "D342",
 		    sizeof(atom_ctx->vbios_version)))
-		*i2c_addr = EEPROM_I2C_TARGET_ADDR_ARCTURUS_D342;
+		control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS_D342;
 	else
-		*i2c_addr = EEPROM_I2C_TARGET_ADDR_ARCTURUS;
+		control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS;
 
 	return true;
 }
 
 static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
-				  uint16_t *i2c_addr)
+				  struct amdgpu_ras_eeprom_control *control)
 {
-	if (!i2c_addr)
+	if (!control)
 		return false;
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
-		*i2c_addr = EEPROM_I2C_TARGET_ADDR_VEGA20;
+		control->i2c_address = EEPROM_I2C_MADDR_VEGA20;
 		break;
 
 	case CHIP_ARCTURUS:
-		return __get_eeprom_i2c_addr_arct(adev, i2c_addr);
+		return __get_eeprom_i2c_addr_arct(adev, control);
 
 	case CHIP_SIENNA_CICHLID:
-		*i2c_addr = EEPROM_I2C_TARGET_ADDR_SIENNA_CICHLID;
+		control->i2c_address = EEPROM_I2C_MADDR_SIENNA_CICHLID;
 		break;
 
 	case CHIP_ALDEBARAN:
-		*i2c_addr = EEPROM_I2C_TARGET_ADDR_ALDEBARAN;
+		control->i2c_address = EEPROM_I2C_MADDR_ALDEBARAN;
 		break;
 
 	default:
@@ -154,8 +153,9 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
 
 	/* i2c may be unstable in gpu reset */
 	down_read(&adev->reset_sem);
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, control->i2c_address,
-				 EEPROM_HDR_START, buff, EEPROM_TABLE_HEADER_SIZE, false);
+	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
+				 control->i2c_address + EEPROM_HDR_START,
+				 buff, EEPROM_TABLE_HEADER_SIZE, false);
 	up_read(&adev->reset_sem);
 
 	if (ret < 1)
@@ -277,7 +277,7 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 }
 
 int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
-			bool *exceed_err_limit)
+			   bool *exceed_err_limit)
 {
 	int ret = 0;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -294,14 +294,15 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 	if (!adev->pm.smu_i2c.algo)
 		return -ENOENT;
 
-	if (!__get_eeprom_i2c_addr(adev, &control->i2c_address))
+	if (!__get_eeprom_i2c_addr(adev, control))
 		return -EINVAL;
 
 	mutex_init(&control->tbl_mutex);
 
 	/* Read/Create table header from EEPROM address 0 */
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, control->i2c_address,
-				 EEPROM_HDR_START, buff, EEPROM_TABLE_HEADER_SIZE, true);
+	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
+				 control->i2c_address + EEPROM_HDR_START,
+				 buff, EEPROM_TABLE_HEADER_SIZE, true);
 	if (ret < 1) {
 		DRM_ERROR("Failed to read EEPROM table header, ret:%d", ret);
 		return ret;
@@ -395,8 +396,6 @@ static void __decode_table_record_from_buff(struct amdgpu_ras_eeprom_control *co
 
 /*
  * When reaching end of EEPROM memory jump back to 0 record address
- * When next record access will go beyond EEPROM page boundary modify bits A17/A8
- * in I2C selector to go to next page
  */
 static uint32_t __correct_eeprom_dest_address(uint32_t curr_address)
 {
@@ -409,20 +408,6 @@ static uint32_t __correct_eeprom_dest_address(uint32_t curr_address)
 		return EEPROM_RECORD_START;
 	}
 
-	/*
-	 * To check if we overflow page boundary  compare next address with
-	 * current and see if bits 17/8 of the EEPROM address will change
-	 * If they do start from the next 256b page
-	 *
-	 * https://www.st.com/resource/en/datasheet/m24m02-dr.pdf sec. 5.1.2
-	 */
-	if ((curr_address & EEPROM_ADDR_MSB_MASK) != (next_address & EEPROM_ADDR_MSB_MASK)) {
-		DRM_DEBUG_DRIVER("Reached end of EEPROM memory page, jumping to next: %lx",
-				(next_address & EEPROM_ADDR_MSB_MASK));
-
-		return  (next_address & EEPROM_ADDR_MSB_MASK);
-	}
-
 	return curr_address;
 }
 
@@ -452,22 +437,20 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
 }
 
 int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
-					    struct eeprom_table_record *records,
-					    bool write,
-					    int num)
+				     struct eeprom_table_record *records,
+				     bool write, int num)
 {
 	int i, ret = 0;
 	unsigned char *buffs, *buff;
 	struct eeprom_table_record *record;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-	u16 slave_addr;
 
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
 	buffs = kcalloc(num, EEPROM_ADDRESS_SIZE + EEPROM_TABLE_RECORD_SIZE,
-			 GFP_KERNEL);
+			GFP_KERNEL);
 	if (!buffs)
 		return -ENOMEM;
 
@@ -507,22 +490,15 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 
 		control->next_addr = __correct_eeprom_dest_address(control->next_addr);
 
-		/*
-		 * Update bits 16,17 of EEPROM address in I2C address by setting them
-		 * to bits 1,2 of Device address byte
-		 */
-		slave_addr = control->i2c_address |
-			((control->next_addr & EEPROM_ADDR_MSB_MASK) >> 15);
-
 		/* EEPROM table content is stored in LE format */
 		if (write)
 			__encode_table_record_to_buff(control, record, buff);
 
 		/* i2c may be unstable in gpu reset */
 		down_read(&adev->reset_sem);
-		ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, slave_addr,
-					 control->next_addr, buff,
-					 EEPROM_TABLE_RECORD_SIZE, write ? false : true);
+		ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
+					 control->i2c_address + control->next_addr,
+					 buff, EEPROM_TABLE_RECORD_SIZE, !write);
 		up_read(&adev->reset_sem);
 
 		if (ret < 1) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 17872117097455..4c4c3d840a35c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -44,11 +44,11 @@ struct amdgpu_ras_eeprom_table_header {
 
 struct amdgpu_ras_eeprom_control {
 	struct amdgpu_ras_eeprom_table_header tbl_hdr;
+	u32 i2c_address; /* Base I2C 19-bit memory address */
 	uint32_t next_addr;
 	unsigned int num_recs;
 	struct mutex tbl_mutex;
 	uint32_t tbl_byte_sum;
-	uint16_t i2c_address; // 8-bit represented address
 };
 
 /*
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
