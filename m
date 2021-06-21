Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F45C48BE5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E857B60FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E857B60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97BA289E36;
	Mon, 21 Jun 2021 17:13:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF3489E01
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWBjhiQIP70HBJxNm9S0oB6NZVG1cQ+4DHnTg9OnKEhwnje1ZPhIDuezM0F+jb0gGZaVfvlUeY/zlVKAoTEhxztNXfPT4oD48F37zygyQYDmLU8QEn9ZcbGRA58Jfx6us2tLDWBFTQ5vth2I8I2f9hMjooWIJQmqeMyUnLZ98u5VMuqW9VKq0Djxjdgtpx54Rz0BOed4Btba3CCXn6KQRAbO5oGPR+a9+9dsxhuajN3mU2J95cziPRJp4yZrJwI0juj6PmDV9RcqgeIPWNj5Sw+0ViQ7OBoXZLgAApBj9pflpuBQ9m4NrhpWTDvYv7BU3+5umf9K9Dk0XRjvRD1+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdMe8D8rq9VLVuo8D7C192iP9ZWUJ0683aqRGqqUeZ4=;
 b=Ewdx+WnUMb2xQORY9mN92SLCpP/Nc8xZ2A88lUZ9d7Y8QdW4YkaTnehuaqqevRh2pbi+VlmRlMNfBwmdfyaB4WVEDJisxHNy4rBVqQoqpKVVEGFaUMFWodINg8jFkPXogylTTZn4FyxIyVtiSXA9PxeNRQAa1J9OXFDWBDdtYprHCHdiel98s3p/t6JzDOkF6SxDQ3fpntgP+xpM9LepzCNGIjrTQ1Zb5tQpQ+2KiHZjmxAKP3Ju3FAZn9pbAELQYpG+a7J/c905693MGHaWF1k4jLYkM4iYGrxwjfewru8SvNv9+9dlD9OMnRoNRijwgvdd9SGUhbKEej89kmLx8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdMe8D8rq9VLVuo8D7C192iP9ZWUJ0683aqRGqqUeZ4=;
 b=jm03gduAHbdTgRKjVtR9oD5EwH4FpLmIemsIZBn28Db/96NX70E6UPh8vX9OgzAW7S+CSv89xtFOdoNqVHP8ci17UI8JShif7hL0+Q7OJmLZTPQ6/uqrvFa9j05WDuZycxTICFR0eVeN1DkfCp7Wh0SuyKFCxWHhTp6aLIKPn9c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 17:13:31 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:13:31 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 31/43] drm/amdgpu: Fix width of I2C address
Date: Mon, 21 Jun 2021 13:12:09 -0400
Message-Id: <20210621171221.5720-32-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe9d8393-d819-4af7-b217-08d934d7d28a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29858A68486CCDFB457890C3990A9@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ObzVVOE/0WKR7jDrMIFgY6cRRe/7x1ZLhSMOCtHaVCZ1OaRmZYVREfw1eG41UZeWMDz0tpbfEGzS/mnQLFItNSVykGJ1fhPiiK/QECsvN8s3DXBqMcetHOArgjnbsUtLoWoaKhIvY5MjuV2fUekl3iEFhtHDqkCv94OsQew9KRAAAkfxCtSNJDzUTlYxrKXKapt/E6FsUxO9PgSUhj+4DVyVB6D8/ivqA4ZVbSuKj5URqnATYs2PklQG/8P1Bi5UJ28FTLYBPh+alx5ZGS/uo8dICmTts+8U+ZIvRvRlgIBC6NZqcB4qn/TW0D6r47JWaeTlN/kTDjBNoR03AqvgnTzow6aCe0vVP+Naac/CRhgBQcy1sRz5rRrIUt6pIrKn65BqBchyFCX6j06G4dbSn0kIV95as+/6z3E3x37czv/m345o35675J40JJ0t8PDHcgVDH5HgNyqnPH9KONv98MFQORh1fcgeSdIR91S+1MDvLyoCMoogsvJvcoU6M+CI80lZTojllG5t7tOxhW9SqRRFDQmWPMEsXQRHfh6tU8HYv1V63OOs9sVXbuDeixWibjPVpBRDEbme3qFFlh4aZfvnvYJA7QoL+GjkPnoGDXYX1pvXiJwzppjjeOB0zfzL3XnhMZqA/eZVEB/0v0riJj8P03FtJYcM4Vf/ipbSq9C0B+WbgAKphIOtLAIe5pKG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(6666004)(55236004)(8676002)(316002)(6506007)(6486002)(54906003)(44832011)(8936002)(478600001)(66476007)(66946007)(956004)(2616005)(6512007)(66556008)(2906002)(52116002)(36756003)(38100700002)(38350700002)(86362001)(5660300002)(186003)(4326008)(1076003)(83380400001)(26005)(16526019)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+zeiWI/YOnr4Nu8aHIeFRu3BV5eQlThyPJ2MtDVY3UOOrawCPi50NVKtV/DC?=
 =?us-ascii?Q?DH33d9YScT4NvJNKDYStJ9whrUa8d5RK4fGzXXp5AfbgOe0s0h2JAJUOjPqy?=
 =?us-ascii?Q?eL0CZITI+OESM3vsVRbwXpbu9fkvo+CSvMvppfIRaT23ukQcMpTxREvNoUHx?=
 =?us-ascii?Q?/C9HzDxrDbIt8wbyv7xR8daLsbBSQ4uMK8bbWWUlgzPzM4GgitFvE65buUds?=
 =?us-ascii?Q?e5Zw/idiB+RdprZ4tGG49Ixk25y9WanZ3wzvIHStrzJSn4S0VKpOAQriGf4E?=
 =?us-ascii?Q?gDSo6zX6WPtBufXbpol4bk9shUpzMpA8tAt1ZEv2LpY1sarLJnj6+R7o/4Gi?=
 =?us-ascii?Q?R0Y/CXo8guQjrIAxhAjnJEfVNA7dnTgn/xp/TYXvh/6WTDCYFv3XP9OHfLUW?=
 =?us-ascii?Q?z9JyChtCD/gffp+mqVrXGUVcooLrvA/TB8MGlZqH85i/oj+dQA8tlB8Zc+Z6?=
 =?us-ascii?Q?ScsFtYW89g3wKzTGQS4bFh4xDC1DWZvFY97KLCu4OIiD7R+IbHeLuTpd1jfb?=
 =?us-ascii?Q?5qbMIguh/WzbjTfw2bmXXSViPiZSpoq0KjYrnzqaLYNSv7LROxC0TdYesPo3?=
 =?us-ascii?Q?zVO4Jnoqd5cL7KwDB9ukNh3B3WsjU6S8kV/UAXjOOfdXJitqg3iJ4lBn87oO?=
 =?us-ascii?Q?GGBxx15J18Cg6tFw1bRxiEPxzhoRHISHZt5rHPM0luq+nLW8ZFU5/B0M4NUG?=
 =?us-ascii?Q?aWSsFALazqpy0N020WkOs5yD+XWvQvSlS3ldJHH7eBy+zTOy03adSsszzDDd?=
 =?us-ascii?Q?q6br0A+3Hy2rLsIyFVDmCY3rnp+mnaQwSZTxiQWSGA5USESYLvvBzAD3aQyX?=
 =?us-ascii?Q?tTC2apoUEXnv1jHh4XafY3/B8Gqp+i8Cmw2oIPMDqHNqRxszehwlOfRmvGps?=
 =?us-ascii?Q?T8AN3WXeiCp37GGU9Gu+0Hca++/WuuM8AblViJxM5spa2Bg9KyznHGSov/Cp?=
 =?us-ascii?Q?gDlFcqG5kmNawgmmGR2YLMqnd32vp2/pXpihWKCPltsAVolbenXpJdM0f8Pr?=
 =?us-ascii?Q?BzC98FAaK71BVMz/cMN0GdKVG1C9CCkgXZHpDQqb47Xoku/zmSfQw9T1NR6e?=
 =?us-ascii?Q?AjC+TTTK+QOyBseb9+3fZdgvaJqL2fHHvsLTVkILC2+idTeR4w9MHwTeGKCG?=
 =?us-ascii?Q?jRAFZBPXm7Sq3MJ6J8/F4oNwxaHOzaiQQp2a+Sxui9UsCYWAqi1vjVgli4Vl?=
 =?us-ascii?Q?pcy1v/SqAVWjbEPLPIT5GBP+WxtzaTUF/jMWcpfIqvupcM0wH28909edVcDJ?=
 =?us-ascii?Q?dAaSlYHuVfRnd/8g95NGyjVgubDptq/yzXiWrtT7KnUBOPKQMBuqrm9sP/1T?=
 =?us-ascii?Q?woxGHLbovhMG3Fd4ILpGSI8G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9d8393-d819-4af7-b217-08d934d7d28a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:13:00.5493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpiDuv4hqxw3ZoZFJhOszTUEGl2iqsvJZOx73wUpFP9wNgTud79m3nnb31UDUNlt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
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

The I2C address is kept as a 16-bit quantity in
the kernel. The I2C_TAR::I2C_TAR field is 10-bit
wide.

Fix the width of the I2C address for Vega20 from 8
bits to 16 bits to accommodate the full spectrum
of I2C address space.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index e403ba556e5590..65035256756679 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -111,12 +111,15 @@ static void smu_v11_0_i2c_set_clock(struct i2c_adapter *control)
 	WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_SDA_HOLD, 20);
 }
 
-static void smu_v11_0_i2c_set_address(struct i2c_adapter *control, uint8_t address)
+static void smu_v11_0_i2c_set_address(struct i2c_adapter *control, u16 address)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 
-	/* We take 7-bit addresses raw */
-	WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_TAR, (address & 0xFF));
+	/* The IC_TAR::IC_TAR field is 10-bits wide.
+	 * It takes a 7-bit or 10-bit addresses as an address,
+	 * i.e. no read/write bit--no wire format, just the address.
+	 */
+	WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_TAR, address & 0x3FF);
 }
 
 static uint32_t smu_v11_0_i2c_poll_tx_status(struct i2c_adapter *control)
@@ -215,8 +218,8 @@ static uint32_t smu_v11_0_i2c_poll_rx_status(struct i2c_adapter *control)
  * Returns 0 on success or error.
  */
 static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
-				  uint8_t address, uint8_t *data,
-				  uint32_t numbytes, uint32_t i2c_flag)
+				       u16 address, u8 *data,
+				       u32 numbytes, u32 i2c_flag)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	uint32_t bytes_sent, reg, ret = 0;
@@ -225,7 +228,7 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
 	bytes_sent = 0;
 
 	DRM_DEBUG_DRIVER("I2C_Transmit(), address = %x, bytes = %d , data: ",
-		 (uint16_t)address, numbytes);
+			 address, numbytes);
 
 	if (drm_debug_enabled(DRM_UT_DRIVER)) {
 		print_hex_dump(KERN_INFO, "data: ", DUMP_PREFIX_NONE,
@@ -318,8 +321,8 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
  * Returns 0 on success or error.
  */
 static uint32_t smu_v11_0_i2c_receive(struct i2c_adapter *control,
-				 uint8_t address, uint8_t *data,
-				 uint32_t numbytes, uint8_t i2c_flag)
+				      u16 address, u8 *data,
+				      u32 numbytes, u32 i2c_flag)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	uint32_t bytes_received, ret = I2C_OK;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
