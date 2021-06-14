Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6E2C48BE8
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C7C61002
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C7C61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984F36E106;
	Mon, 14 Jun 2021 17:46:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF1CD6E0F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEvcA9xjnNgjbqgKGGkyxR2LfAHh7gRtT1zQOeCPe6VMWJR9rmU8Sjo4E2iZ9F/AY7J68DapDWsikn1Gffwo8pU30JfMM1fA+2d9tMW2bYQhHfPjHL5DFIwIlo5B2KUGgNnqX+DKc60kigHMBkMLKfR6e/6VgWa0Ncdzdx9YjLEIg8MkY6RmVdQHR6g27zHEQC16kvOZ2IeGPfF/7WmAtoqnfO7Jz+AnYnX5Mob6gp+YKWdoXv6w/5uh1mCXjk3utKQiyRP+Ss30iGy4XAAw//ITo2ov4aUbDa2zQoxk8BkhQRgxpowSo+CFeH04G0ZOHCU/4vvS7C3NsaAGxt3y3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBn5h4/eThbcfg8inUYyZ54eguWhCQzRNz/g8O6Saoo=;
 b=HoXs4nrBBPwvbgGiwMJPlcFhdKiB/CXl0W10QcAutLScFyT4jsQF7oO6ffRlksTOwOIip6VCcLDqjk0u3IFCS92ml9sT7VJl0l/Jx9xXkUST7F89D2PL5m10nYAHPF+0qciXksrlb6jlWqiIIsWRc8m5ab+COjngLHG/iGy+3VRGiC52gz41+wmU2NBZ4GDXYSIybMibfQEZ8bmlBfBEUCyHhPfdqno1P80QzvAYJvnWqor1UlFtQxEMsaxIyFM+aTwOsdTpvlt2f5YHmwa7+fHQXP0S7vcI+gBYqHI25pDzO8UZ+3QhO4kmwVbIxDgZ4fXNIv6uZCniVgzNgBaphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBn5h4/eThbcfg8inUYyZ54eguWhCQzRNz/g8O6Saoo=;
 b=kcTj36QTyCOZ/49A6ZR9osszhPWvZiwAp3CbNi6fH9EUVGJGheKxBBBn1nJqneinK9diLJkcpirT+hBh7iEN3X2KLJA4lgRUoFsdyO9sKfupXeemwjticmzQH3kO5XLtALrXuhKVBDyjk7xlUwr0F2eILTeOewqPAlGZ6Zn5eR0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:46:52 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:46:52 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/40] drm/amdgpu/ras: switch ras eeprom handling to use
 generic helper
Date: Mon, 14 Jun 2021 13:45:58 -0400
Message-Id: <20210614174632.20818-7-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:46:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa020e44-c15f-4189-6eba-08d92f5c6453
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4748CBD0FBE789C8E6F73F5499319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d92JVFpzV7lEhsLfPpKGQvD07kvqQatUJkdWdATYFCJ8kDaX/SNtzfGfCcAenK7sygNBf9yVqE8270dtHmwRi8mg9Hpxc3iFPLw507AxGuu2YIflIc0HUPlivjtgDHN8/ZdaZu1wV9jwcBa+vivIOH6VzlkX8r8Xq7PftEP4rLruGXQGebX3PWCvIsflOw7RZnqPDPS07fu36WhAaGBai8V1JGQysHvCjw7fYSYB2oeYVZjcgR4NjZnky4V2YSB+q0Jb6x9LmfaCxPnKQawoTMPQKzLYcvhCZ01UBgnMlM6Oc5SC916tIE6ldColBqYK2tANtfUy8H4DstyoQMbjNKQZ+BEDX9lVzOUy3kbDNdtFt6N+2h05HOpfu+UfXgz2OHgwkBECabfxjXsexSn5lyigTIG95KZMFyKuFguYvpyQpuZ+VE9t5ltOdIPNUrMrfc0OTXHKD5aHa5DShg2Nc3I33ZfB2nrQ7S8/Ggv9EShfmVIw74S6OKs+2m+epXYMl4m+bXIXg8Z5eXykL919MOat3NiRUN0K9bwSIWj7W7nJRSIl20hXoUUHQhO03DWMBezP0iIJ5v4KmiglcMQRqMmjrF3iHuMbUC7Yi2hboWGetXJMNASxgR+mssfbGx2wTZAxWSVim6rF3RfsbAlm7PzC9JdgKvr4ycKsmzklqorQh2Cg36L1qRI0zoXke+JFoz+gAIk97aOUQZK4b8vo0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(6916009)(38350700002)(478600001)(83380400001)(6506007)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2c/A4I86xsXd1PhCyff9SkBGiH+lXjiI/rWr0I/7ND20ZOrmoszqWY0MvEaB?=
 =?us-ascii?Q?VBMbOvpQiMPFyMnCxuYm8r6QSGAOlQPrOoRIX3Bv5dKly2PK/lTCBv2NFxIV?=
 =?us-ascii?Q?wodUJXtN0GfqBDj1t3zoQjnjNAcTQChg9TkNA8xbfTRVkyFyWbWpon/7ccBX?=
 =?us-ascii?Q?3gxSyuwuY0Z4/iQ3rwp+9jR7yNMSYAiuyhZXc4NpGnTk1E0k8lpwy40Mwkro?=
 =?us-ascii?Q?Gk/UCFqTFW2Z4ZXtaYNNNuL33CZl7athK89pAPvEkN5UDAydIyawCqajVfkr?=
 =?us-ascii?Q?qVE8VCniZCxOLVuSGcRdfA8aApW2tC5H8feXsE8HUsot9QmJxrM4JHqqk+7M?=
 =?us-ascii?Q?CpUC0KJgKraSuCDezbg/NwzuXuoWC21dz4d73fNZwNmQ+il4KhVA+VC5Rp6a?=
 =?us-ascii?Q?vdI/gi3OZOvaCFHg4aPJNeqivqmKnYIfAB2PqTHi088V5bxqCbqH0k1WA612?=
 =?us-ascii?Q?TxUads4orDnT+I5TNks8rpi5EPdvEWanI8rdnveno0rlTKGZnzu8oOcphWJJ?=
 =?us-ascii?Q?AgssmCQBcutASn6HrpLwdA0Eaf61r7BKlbfm89IiDBXQ1TTa3VrhdAMK3U92?=
 =?us-ascii?Q?gyZRLR3HImJVNuutjUZHwLSQRkTQE0xH8CoQKx1ZY3tqj1r1HO0RTfukD/or?=
 =?us-ascii?Q?zi/rDF5IbAef+ZTaBhjk+8Va4qA+e0lc9iTgcmTqNjfgh1l3ds8jKZb/yBdz?=
 =?us-ascii?Q?FzkLB+Bc/jx9Vv6O+LkYo5RUsyaydEoFgwUsQC138rA04EhLmlTUWqQYlJEV?=
 =?us-ascii?Q?63YnOeSILYIeDqwoBs9aqsWbkNvkcW8tYF8FTIqGMMIZSf8Su/Kqky7DpHUc?=
 =?us-ascii?Q?TRUrN+AotkJoz/84lfrCLjzeUXOFtPMTpsH+T3/AKxSoa/o3cuSNn09DuWwA?=
 =?us-ascii?Q?bBPrCknANEVGVyE/ETNQfbmdO0JtgGnxfDJIZLIzoZWKW/OrCa1jb5ylgedt?=
 =?us-ascii?Q?YZb7XJ6cs/BRAsUFjvk+EA0hqKKV1kTDrC7dFA//fvRTqr5Kjy5+KlQtFLpQ?=
 =?us-ascii?Q?qtzvT48OJ1u+ZV22qc/wF/rEsuJKrFb18sgGN4+T74BCsuEuLcR2ArXkYRV9?=
 =?us-ascii?Q?3PAN8CS6BSmttjHB5EmhVbn/mbjegGi8/LHg5to2ILk8sUPPi0BvhchZF9wk?=
 =?us-ascii?Q?LehYGxVU7aZTeYY9oMUAZcenQi3K2Q5uv+FqsLQAJ6KY96T6Ty0/8YJsh5zG?=
 =?us-ascii?Q?O2le+APv1FJEmyfSJuYtFEy7UwilMv0rkZXcAVEz6cS1Dw/5CPDBWWqMzz42?=
 =?us-ascii?Q?tajEra0FeAW97a0hA/N5c2c/1ZershOgBGUqSjNBneHvybHw6kDKamuvkD1r?=
 =?us-ascii?Q?KdqBKmJFIrk+6oc0c4HVLcTd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa020e44-c15f-4189-6eba-08d92f5c6453
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:46:51.7551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3nFcTwFr4HBN+NIXA0dKLIxrhXkwtVdcHE6Y8b6Gigw7TShoLCdIY6h48lTvrxb
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

Use the new helper rather than doing i2c transfers directly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 86 ++++++-------------
 1 file changed, 28 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index f40c871da0c623..e22a0b45f70108 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -26,6 +26,7 @@
 #include "amdgpu_ras.h"
 #include <linux/bits.h>
 #include "atom.h"
+#include "amdgpu_eeprom.h"
 
 #define EEPROM_I2C_TARGET_ADDR_VEGA20		0xA0
 #define EEPROM_I2C_TARGET_ADDR_ARCTURUS		0xA8
@@ -148,22 +149,13 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
 {
 	int ret = 0;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct i2c_msg msg = {
-			.addr	= 0,
-			.flags	= 0,
-			.len	= EEPROM_ADDRESS_SIZE + EEPROM_TABLE_HEADER_SIZE,
-			.buf	= buff,
-	};
 
-
-	*(uint16_t *)buff = EEPROM_HDR_START;
-	__encode_table_header_to_buff(&control->tbl_hdr, buff + EEPROM_ADDRESS_SIZE);
-
-	msg.addr = control->i2c_address;
+	__encode_table_header_to_buff(&control->tbl_hdr, buff);
 
 	/* i2c may be unstable in gpu reset */
 	down_read(&adev->reset_sem);
-	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
+	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, control->i2c_address,
+				 EEPROM_HDR_START, buff, EEPROM_TABLE_HEADER_SIZE, false);
 	up_read(&adev->reset_sem);
 
 	if (ret < 1)
@@ -289,15 +281,9 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 {
 	int ret = 0;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
-	unsigned char buff[EEPROM_ADDRESS_SIZE + EEPROM_TABLE_HEADER_SIZE] = { 0 };
+	unsigned char buff[EEPROM_TABLE_HEADER_SIZE] = { 0 };
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-	struct i2c_msg msg = {
-			.addr	= 0,
-			.flags	= I2C_M_RD,
-			.len	= EEPROM_ADDRESS_SIZE + EEPROM_TABLE_HEADER_SIZE,
-			.buf	= buff,
-	};
 
 	*exceed_err_limit = false;
 
@@ -313,9 +299,9 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 
 	mutex_init(&control->tbl_mutex);
 
-	msg.addr = control->i2c_address;
 	/* Read/Create table header from EEPROM address 0 */
-	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
+	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, control->i2c_address,
+				 EEPROM_HDR_START, buff, EEPROM_TABLE_HEADER_SIZE, true);
 	if (ret < 1) {
 		DRM_ERROR("Failed to read EEPROM table header, ret:%d", ret);
 		return ret;
@@ -442,6 +428,7 @@ static uint32_t __correct_eeprom_dest_address(uint32_t curr_address)
 
 bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
 {
+
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
 	if (!__is_ras_eeprom_supported(adev))
@@ -470,11 +457,11 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 					    int num)
 {
 	int i, ret = 0;
-	struct i2c_msg *msgs, *msg;
 	unsigned char *buffs, *buff;
 	struct eeprom_table_record *record;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	u16 slave_addr;
 
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
@@ -486,12 +473,6 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 
 	mutex_lock(&control->tbl_mutex);
 
-	msgs = kcalloc(num, sizeof(*msgs), GFP_KERNEL);
-	if (!msgs) {
-		ret = -ENOMEM;
-		goto free_buff;
-	}
-
 	/*
 	 * If saved bad pages number exceeds the bad page threshold for
 	 * the whole VRAM, update table header to mark the BAD GPU tag
@@ -521,9 +502,8 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 	 * 256b
 	 */
 	for (i = 0; i < num; i++) {
-		buff = &buffs[i * (EEPROM_ADDRESS_SIZE + EEPROM_TABLE_RECORD_SIZE)];
+		buff = &buffs[i * EEPROM_TABLE_RECORD_SIZE];
 		record = &records[i];
-		msg = &msgs[i];
 
 		control->next_addr = __correct_eeprom_dest_address(control->next_addr);
 
@@ -531,20 +511,26 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 		 * Update bits 16,17 of EEPROM address in I2C address by setting them
 		 * to bits 1,2 of Device address byte
 		 */
-		msg->addr = control->i2c_address |
-			        ((control->next_addr & EEPROM_ADDR_MSB_MASK) >> 15);
-		msg->flags	= write ? 0 : I2C_M_RD;
-		msg->len	= EEPROM_ADDRESS_SIZE + EEPROM_TABLE_RECORD_SIZE;
-		msg->buf	= buff;
-
-		/* Insert the EEPROM dest addess, bits 0-15 */
-		buff[0] = ((control->next_addr >> 8) & 0xff);
-		buff[1] = (control->next_addr & 0xff);
+		slave_addr = control->i2c_address |
+			((control->next_addr & EEPROM_ADDR_MSB_MASK) >> 15);
 
 		/* EEPROM table content is stored in LE format */
 		if (write)
-			__encode_table_record_to_buff(control, record, buff + EEPROM_ADDRESS_SIZE);
+			__encode_table_record_to_buff(control, record, buff);
+
+		/* i2c may be unstable in gpu reset */
+		down_read(&adev->reset_sem);
+		ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, slave_addr,
+					 control->next_addr, buff,
+					 EEPROM_TABLE_RECORD_SIZE, write ? false : true);
+		up_read(&adev->reset_sem);
 
+		if (ret < 1) {
+			DRM_ERROR("Failed to process EEPROM table records, ret:%d", ret);
+
+			/* TODO Restore prev next EEPROM address ? */
+			goto free_buff;
+		}
 		/*
 		 * The destination EEPROM address might need to be corrected to account
 		 * for page or entire memory wrapping
@@ -552,25 +538,12 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 		control->next_addr += EEPROM_TABLE_RECORD_SIZE;
 	}
 
-	/* i2c may be unstable in gpu reset */
-	down_read(&adev->reset_sem);
-	ret = i2c_transfer(&adev->pm.smu_i2c, msgs, num);
-	up_read(&adev->reset_sem);
-
-	if (ret < 1) {
-		DRM_ERROR("Failed to process EEPROM table records, ret:%d", ret);
-
-		/* TODO Restore prev next EEPROM address ? */
-		goto free_msgs;
-	}
-
-
 	if (!write) {
 		for (i = 0; i < num; i++) {
-			buff = &buffs[i*(EEPROM_ADDRESS_SIZE + EEPROM_TABLE_RECORD_SIZE)];
+			buff = &buffs[i*EEPROM_TABLE_RECORD_SIZE];
 			record = &records[i];
 
-			__decode_table_record_from_buff(control, record, buff + EEPROM_ADDRESS_SIZE);
+			__decode_table_record_from_buff(control, record, buff);
 		}
 	}
 
@@ -600,9 +573,6 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 		/* ret = -EIO; */
 	}
 
-free_msgs:
-	kfree(msgs);
-
 free_buff:
 	kfree(buffs);
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
