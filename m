Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F43C4743F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A002610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A002610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B6576E5C8;
	Tue,  8 Jun 2021 21:40:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E10B16E59B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G01lRfvBz3uiWUqlRe4Q94HBAxEWfLUjRAoXKz2TtViz2CNfu+MGzP+uQfhvXem1+6tYMCw7mX2V1mw9ClbnlBIkboOt++nvGn5wlvhZXgSB5MuEg51jOo5yyBV7XfQ4UpW6hOqpaGN9a/m7l1f14X6AJyADvzN3uXVbYih+BSGnU+3v3r0GiB84iOghbdqLY7azrWddmJ/jp0yLiKW1AQXwLaNiu6L/tv/C1Y8Hq/TbK8qt1GrMii+6Ltgdacb4DpJMY9mF7jRE86V6CrMJgZZaLcr/YpvcjAnPec9HA55rWpdt7M4lOjEshD+sli8Eb0ycFUKUhTDcqvkG7OxuHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBn5h4/eThbcfg8inUYyZ54eguWhCQzRNz/g8O6Saoo=;
 b=CmpxKQVoEMN1uysQHbCZ7OGy4DXjQ87SEVnJQmL+5efhXknCNygXR3PSAhOuF0TkaB98yzdlS5TtWptio8iL9IoLBlqn/Nr6tOPS5SmuvdoHQ0MVyaL1YrmU0g+Cw9EUH7z4SfnJt3uja8U+eXztWXS5mUhSDB1sVSwvKmprfJ16awN3+NSgFEHPjgGr5t5Rz5CjKrXoRhoAePtMJ49jLKn56W15Lk0Tu104xLN5sML82b3PXMbcGQbVzb1cs2DYUDpckoiJtG2ekGDY1SX3V+WyLTQNmHQk+0QBUGXQ5vzwxyyxlPVvHIwBqp/5ZDf5y1SEnlma4o6svkta1+8r0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBn5h4/eThbcfg8inUYyZ54eguWhCQzRNz/g8O6Saoo=;
 b=n7w0/0WiV2nWDOAqrkT5Dmx16p4G67eL4u4M3mc/6LH2hdOOitSOacYHE7B68ofn0CrJmyZr+j5Zrrk0n7yYICCGqfY6HVqiIP6PZHfZW5Hoi3f4RIFUvd4oHX+u9KuolCxw1qkCPlGlIFHZSTxkSb6KVlAFpTJGoysNdCAOvFw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:17 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:17 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/40] drm/amdgpu/ras: switch ras eeprom handling to use
 generic helper
Date: Tue,  8 Jun 2021 17:39:20 -0400
Message-Id: <20210608213954.5517-7-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddff658f-cd80-4c5d-fa99-08d92ac601db
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4355D5503AB0DFBEB9B8727799379@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRom821c1Ne6r3amifrKutKQaoWxtZfDnFfQDMzDbPSo4rR0JgX+IW8MsJ9Pwldjl4sLn4MGNZajjqUlg0QSwqFYfXmnvghFt8NGgXiLbH3occHvzPwfkLQ5ZKSjj9IKeNuheVLoSmHEbMIL6erY6b6dZC+Hh0cMFlkDjaANN4YG9LaEaU22lXQOyeqtlhXXpSjblC2dTIadJSW8P9Zrlw453E9meYAX2xOQqqrQ69YEhDUMY16rv4Mo0xwIr2S+fFxuAaUIA8NbGRIOuJYUAbhB266mbWv+c7NEdHgaBMWuE5udkLrr+kFPsk8ADiFlC8s9/s1TLLATLReRNfOjQRZNNVINH+cG0gUZ2udoXftHeQyiglmT2byzcupcGEsHAjr9rTmxHnTOm1MB6ADyl3i04ivDM+OXyeBermSprLfAdzPUIFhWP/6xDKpnS9KlL6sPlK7DUlCqSKf0DYeowmw6HBiO3LEhQgM1DH/cyvHqSGJbk+mMHwNkLUXsZQ+zUVXSJa2onTTayy82ZUbIk35bLupOJ8OonKyrgI/zyq9Xh5dvHnGBW2A/T4kuNRXMfnnETuMUhTj8c+XLTJ2pALeRiHGls7Cp75tt/yPIeToLpcHea2ZIQ6BTj90GoWHV7c1C3o4WGJ1g0NOc664EA9ZY00BrJe+ppAd4q/Nt6sfV1DQk0xCzf8fqk7R1GLr90qREUYYusX4kEA2Z8uDuFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(39850400004)(346002)(44832011)(6512007)(66556008)(66476007)(5660300002)(38100700002)(956004)(38350700002)(6506007)(478600001)(66946007)(8936002)(36756003)(55236004)(2906002)(16526019)(6916009)(186003)(54906003)(86362001)(316002)(6666004)(6486002)(83380400001)(4326008)(26005)(8676002)(2616005)(52116002)(1076003)(69590400013)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qo0GGBbQx04NyqjAUojYHObzwcegA0JoxlMRFgT3eK8wBEPyRjiejqsoHJ+N?=
 =?us-ascii?Q?i6RCp+hgS8Xx6apEfp3VcjV/musg9FJ1qBHu1cPTF6SBB77ukK8SC/PzOMn9?=
 =?us-ascii?Q?0keR8/HJYku/WBbH+Ds4RRghDAajaDBWw/mIZhV7KmhJeU/bpXuZeb8nyTil?=
 =?us-ascii?Q?1EP4jVp1JWqdT0RXCkXjEjAYl0uVyokG+n9JRr+P/j7pcnIRPlM9yNNwIfEE?=
 =?us-ascii?Q?hARQ0hr/AnXXuRNiiVammsWrGwOWNYpexpZBcCS/OJAGd9Y0APJiPeO1ceuD?=
 =?us-ascii?Q?MdY+e9rjhSMGuzzRQ1K35gRFFVb/bFOScW0x8uEnPKyL8zWbKqcWtDXllwEU?=
 =?us-ascii?Q?VaY9KRbrMXHAXhI/QH8odBwOdR0SJLyo8gtgAqKTiEpKVCtKzCWWvlVGSEHL?=
 =?us-ascii?Q?vzpKvmeavdarYUh5cZxI/seFQk3VT4uefzBGiQSLsy8mR5AvtWjAnxmi7Z6c?=
 =?us-ascii?Q?zvX76Y5PmvdX8nfHTPRo5kQ8GeU/XgQKMYWgz/5dNwH2S2pN1nQZm2jO/hBB?=
 =?us-ascii?Q?CUXnJCP78ZTr3uLuIA6vD+yJt7ZfDlbMDTSu8tczkmIesh0j4/IeR8BC3mA0?=
 =?us-ascii?Q?GK98UxJcr5pgrmwahi4gIZPFu1XbuVP9/0Mqdu0dZW1gY3CSrZnjzSh2m0ym?=
 =?us-ascii?Q?/zSWjroSZF0sm5KO5L0L1x2JqgaRPCTziiBJYNqOKDjoyuzOky+0dRJj+Ks1?=
 =?us-ascii?Q?6x7U4OseWxrOKQpfH5epXi9dNrR2ShUSDjawEfyfBC+1lWczSkKjv4enbCJl?=
 =?us-ascii?Q?wpB7KOn6i8gMuC82Z98TA/8v9q+ZXxfDdKVPczfbhYVgUaWQ4SNyHlp4zIiS?=
 =?us-ascii?Q?Yu+lopGG/hce4HSPRKp+ZGTDYXIrGRU8kApgLyIbKFUXS9SX8bzWRwrJXKWV?=
 =?us-ascii?Q?6Wmt9DC4qNUY5gsR43CkNCfGHsIRN0thJc8GJOHYaogO1eFDLInRB+ooHR8m?=
 =?us-ascii?Q?r968t07AHRA69OtGFLa4EPZVRoNz5X68oR6RNR+aMWka2BQ8qZ9iFffmYXJP?=
 =?us-ascii?Q?j8paElPa7sqHqm2BoZGRweyHRXSSOPPkTT79OmyOHyNmMYJGBM0zIl+hfGsb?=
 =?us-ascii?Q?fXq0/pt84tfRA2/DmAISUaV9ADj4OFTWrp+fpBs7xTlrtdvw+EdukIkkh1GU?=
 =?us-ascii?Q?I92wILhMjxF8zMA60aHtnUC8qoAtrDywTAuKEyc/I6xIld8CKiCCDy/8Wezp?=
 =?us-ascii?Q?nwjwMcL2MC3F40xiLHd4KC9nfwBMKrrR+Tn0WrP/0cd3ES4fNLeYa0WYy7Ho?=
 =?us-ascii?Q?/ioAJ8CJK7joRnVMVlfm4q4boXoJOLiz5+KAQT0OsbpM+kMe6Psjznj4KDoC?=
 =?us-ascii?Q?jRLD5qlxBYJszMF2ARJmGPF1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddff658f-cd80-4c5d-fa99-08d92ac601db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:17.4120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SELNJ6mO4z2dY28S5TtSW7R4c10ZctqBcdLLTkclB5BP/BtnEGnaBnCVOBL0H5jE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
