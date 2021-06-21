Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AECC48BC2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B0B6054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B0B6054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8051A6E22B;
	Mon, 21 Jun 2021 17:12:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A496E219
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJkTY5JL/DZ/70iq7o1ItX0OplZTOGOubCCAm96Az7Y3D2ppBIrKEVWFG6FyS5mAPeUJkz4GBJToallyM5aNxhRhSmjjddQxC2T6myQHf5hb0yD6ZXPbgdBDD5VBHaxb4XJ9OkosBY+0flecpCf+xWkBfwTTn4umya/oMS6GjTz86Hme6wx8Tan6FnUHGn1zy+B4KL/HweEhqgsoq/al8MoPuQdl3IQK111XF8RhLCKHXFq/WcbPo6foLcJo2XU8J65ckGlMQYX5djJbiS+KBMh8Lo1JpnJxm5lVk8qdM4qu1r6W52D5v0vO0NWMICYhydbjq37/2MSfCFFt8BV1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBn5h4/eThbcfg8inUYyZ54eguWhCQzRNz/g8O6Saoo=;
 b=M5enjPAAWmAxFjY4ISDtDMAOxza1gnS5HGo2zh0SACoop6uE7BcN761tgArFFTCNlLjD2tKmN2nenJl4jLnSWEN4+qqw6+yQzOMNtJ3vttwAEJrFrEsew+zbmmqYQ31hhQr2mMA5GL/SyfEnl3MacIFecW9huBqgOLytpcMmbuNDh4SoFGRXHoTS0oawP0Jk/p5KVlEl/31EgmKXhfNLIGfNnwy15n7QhxTrpCVorIvZmnrjj7P7YtWTSUvSUw8thwfB/OYhbFi1BiY8tBi0JgLW0wPJq2Ni2a7D9qQUS5Cz/CLBWYBAN5Sjea7XpUd/CNA2U++EAA39A1hW6JX39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBn5h4/eThbcfg8inUYyZ54eguWhCQzRNz/g8O6Saoo=;
 b=imU2gS9UEH2rTzN01dmlNCDFAvEJYHnWRH4hD2xVQ8EvMjTkDH87g6AsezdyLOP00yZQqtVwtfj1ujFJahF94HzwyTyG22kRHkSLbYFgbULGUJI73qI2HDFUiAyqJP0mkxytQaU+ostHOPsDzxmAf7f8Fob1XrQNSpW309bCGsI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:39 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:39 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/43] drm/amdgpu/ras: switch ras eeprom handling to use
 generic helper
Date: Mon, 21 Jun 2021 13:11:44 -0400
Message-Id: <20210621171221.5720-7-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621171221.5720-1-luben.tuikov@amd.com>
References: <20210621171221.5720-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41435893-3957-4f9d-2df1-08d934d7c5a7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3865F5157B5BE787D09B7EA4990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zl/5/kixZY0r2zzZ4KU5gtbd1p7Ut/+Z+fCc6wmiEuBPhise6ScrxeRM0Km8yckv+NGxarQp1T+cjMdTDx2OZkmPVU+brfTz6HMR9JLR0gMCdXY+/llQ+KzEfSWrZ1eizC9x7CpZCkjdjlX6dP/hWnWiKudixnEESHmY4JASB6zYowOA+YsC1X1QD3nUPA/0zFCaeqAyK1KvYtRXAtvX3AijOSuX4lrVJnl/G9ZjJ6JQg8ZvU1DuCmw1xjdwkU83MXIIuE9vRDjmf9tgp6pXr4nxCkEsL78/9/zGcVyBEQ5Toi5Bin+KIX4iVgwR8ZDmaNcb+utovPtrUHMBOKFIAx6xZT1ywENB/3CQp3S/Q/fAGkUnWDRcuGUGz5SBqJgf7bKB6w++XcurBH+9d/gjM1OFouIHv9SgvE69os+TjYwUfcglKG4jY+tD4GiyaByAaigY90q3f1E8MuVmn2RJPExDo1T++0FpFppkNS5P0gjAmkphfGEPXGe4ONnISZ/lTRmvR3VEHGGBtYMHi2noEmCc5Puj0sIXhNh5a54vh2CIlgvUIg3JD2M1cWLHYIc4WVu1Nub8/HYmdIpoWQDXq3ndrzTZo0oCUT+2jBhawM+Tp2yhWMy55sx8rYLgTXhBrQXQ/nBvtI9PQ3ksj97fwlc9G/9l1qAPZxh/HBVomhzES1vwWPaewnnHsAX6YpKpqTmpvcPkJGIhUVodhP2qQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(6666004)(83380400001)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RbhlDqy2lVdzbJBkunBn6YHAGi3/Ntq+Y5ldULT/fjXyT3bKFBMwhS2OzWKL?=
 =?us-ascii?Q?nEw8jOO/ijxEcADmI41ZtrlmuxG11Q54/h1JIOepb9XPhI4RthYTsFwLYFL8?=
 =?us-ascii?Q?RE0wFG7lrr3nbDkwKRNd0eeibMaLlkKGCHAyjvZoxCuWkIF4QCj0u33q/K1A?=
 =?us-ascii?Q?Bga7dTipkBETV9yATMBCl6Q09N0fCpDHrC9wjhsjTgEQupfzv1fBxfMgz7a+?=
 =?us-ascii?Q?iPJ1P4r323bbnwe+4MrwtBvhv9iKgYU0hOOmTEky0Tyw9jYQrTSuF1yeizVT?=
 =?us-ascii?Q?1gIGwMmGkB7tVkM8Hk+9bBL/mtUjaZpgfeVNMg+JdxU/j/fB/3ZLEiZoU6/R?=
 =?us-ascii?Q?f5ledermnRdTCSLA7wWpaBD2Q3+aEUgZrzuBzbO4xvys7QHdKRCguDs7dhhu?=
 =?us-ascii?Q?8r4+BZnbKNpny0O+rz1bdExyYZzTs351v2USGO2fDnSzLSGeCKs4DYsuGfjn?=
 =?us-ascii?Q?XlQQU7IXwoetTZct/0hbOjlWmjiuCR8IYbT45iFNlnKxOSZGZIg+E62XW5Fl?=
 =?us-ascii?Q?sAlGoSKz6szHbRlrQQ7NEF0/HM+U7QY5TDafhpYMajQUIWbBZmdIzNlrQ63w?=
 =?us-ascii?Q?pQAOd0SVDEQwcuMhPn+V3j+nmy9J+/W9YhCrMvOSenxQN0KO1RrN6zXzCQEB?=
 =?us-ascii?Q?/+xQWaSo5C8ZP5r4vTZUUlFnwmKLcjXgrXnUKEhEVis7kSod0HwuRtkn7ZLi?=
 =?us-ascii?Q?nKJTbxqxAk3bxvoaYkE1kTc9lpLr74xtO+qC02VctiG6474nJoYWWH+NagXq?=
 =?us-ascii?Q?v8P2bThXXuAi/EKGsLj+qkV18ZAWl13JTH4c2eGzXhwA2WUD/K0ZYSmYzJzt?=
 =?us-ascii?Q?OKlCwpDiMzhx/+j0MjXZ8yuDOYN6R0r5Jc4zRBg6JYnEohIaqj7FzljcyMC1?=
 =?us-ascii?Q?iJIooxUc3cWfVGpWyBScc9I9HdX1W3NjAbyOuVi7lBMbfuPT6rwLdq1MA/BI?=
 =?us-ascii?Q?vn+4lVPXeUf1fR4TBDViwBquZ9GYkKTs02m2T4hQfwly8dyB2xXqUK8DuM9Y?=
 =?us-ascii?Q?s6YLZK+mmMOEff5XALmEozr7iJysaP3C4+Ymo7+3SJT45NqGQvoENwA8h8iu?=
 =?us-ascii?Q?UaD6LDpaKOxUS1SCmaiSUCaHC711n4mJBaRgqIkPYEV6JLV1CtKAwjRMMqm7?=
 =?us-ascii?Q?QIwt4zZqurpj5jnohQdGpJrMb0/ka4gpE5Vy3OeqxQ+RgybVKEu+WC1queiE?=
 =?us-ascii?Q?3h9A6+zfJEMdFGYI5jj1bsk/wWmpDAi0fbWU9l5qVzybeOuOUuowCZsG5RCI?=
 =?us-ascii?Q?q4WiDtFMiny/mMCJbGLv4zS1AX/tRA3vk/YrfkG3oxCYABQoqHiZknSfbskD?=
 =?us-ascii?Q?EWHzuyR5KLhJ81BDdcxVqgGA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41435893-3957-4f9d-2df1-08d934d7c5a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:39.0065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuqW86g+QKGf29osUg+dpoI29VXbSj2nScuTPCG0kBml2LIa7wJpRiYDviKKuXVV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
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
