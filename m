Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3C0C48BE8
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E35DA611EE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35DA611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 840006E14F;
	Mon, 14 Jun 2021 17:47:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A7006E147
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tuc+mUX/SPN0H4KlBo2S3z318LOE9ZMbtq9qZXJvIiUYlas2x+xtpH9n/G1ij9z4Vh/CXzuYHD6fuOkMNT5/BtyR6EaHLYF7X6nNRTQnFNWxXtvYBfafrkNSp2qClXe1YiW41W2gjyRp2MgrFwEUC9WFk0ZM26GfWyzjByIksXXSYVOC5yZb9ds2q9gaV+0IlhNDREE5C109bXiz9Xi2rTWldcQDpK2uFaEQU2CRYz16gD1FiDdiCOhgsGxndoeiF3wtNY43BIhRIWBJaB9G5sKRRz1Y3hCglg8wCRRXGpx9kC1nI/NU3tP4Dul2KM4q26D9pYGIi1wXDVKLyHisgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdMe8D8rq9VLVuo8D7C192iP9ZWUJ0683aqRGqqUeZ4=;
 b=n9qg2YPTShtefXNEAmA0pDVdOGBbj+AGAo25vqT87ltmLJuO7qkEkzjPNF30B3giRpn2GyF5bZqsdadn55bLX97A4wIO/+LFnMNNU0nPtvJdfQee0jVyLeEiS2ZhdCv89Za45AxFDN91aFC7e85nseNdtp6qVzCemhKuDtoe/0mb2bZWW2xcmGiKkSy5r2dEiEMLRqby3W6DKC4lWfx1j3aDuxa1Alf25BV01za5tFlhHdyPkYpfSIpFCRW9sy7rU4zkU17aTkSpFcGRr8ydAPyiAXCS9CLGmetEyajXnFxum83oHne1y6AkeJT9iiYBeLiofH9u2CpM0SMDKycsZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdMe8D8rq9VLVuo8D7C192iP9ZWUJ0683aqRGqqUeZ4=;
 b=Rt8KihO2/Smf2cLC1ceXmPNIoV82LQwfdJQQa/YGIgndjv1BIvVdAcWe+hXmfK/i1tXZ93QVJVBKgs1eMohEpmyIImN+mkW/OwFThi26sQX6hZaKsq7MuCdqrWDabKF3w4SkHPEW4cncAJCS4HMASrTKLFQXDCd4Dj33zcBwang=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3577.namprd12.prod.outlook.com (2603:10b6:5:3a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 17:47:44 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:44 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 31/40] drm/amdgpu: Fix width of I2C address
Date: Mon, 14 Jun 2021 13:46:23 -0400
Message-Id: <20210614174632.20818-32-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a1a22b3-0a22-46d1-edcd-08d92f5c71bb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35775D2CC8E560DF38FF1D7099319@DM6PR12MB3577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgTII/AWZ6ZkPLnBVWbqU6lVKRRMbw38Kn3bS/P+Z8pdkm589gbDtP1/UwuybaRLmD3PoV0nYCOA+ge+JTY7mQhCwWvp7sfoQSgiJYw5H2niQ568IEKPKfPq2q2Q0xzGqh0Z8BncP2sFoAdl0qZhJaz9rzTPfgF6Bw/fnLby3H46wMB32Z+QGHX3YkORfhyZztnIHEcBSKD6WHTtT3VstUy1SDO5606kwcwWSym0S9g0PdOKRJdV0CbeoLOC0nhFDhoKctF+ZpRy98VQE62JlU3xPvNSWe5N8h//WV6iX6I3jDPsrGOabvhe3qo3GsE/DV5vLrq9I0PLEz60X3dTIiwux41rYFkJoOK/cwUo131hPR8LvSmv6P6fUQL/atR8jhKmWoh1qDNfJZpLjXsSNCXsex7wnNi99T6Dde3eSEUosbd1Nr8V7ti1ylxLUtWFp4082EcUozg/mLNMKhSL3ZImG9Qe09qRJWqeqkZRZyPjPZspg76gsR7RYNpbSNds+oAKGiuTnvIfQLBhA6xBqIQd2Am1jqLA9/xq5Uxuwv0mnBqWm1DjFQjTdcdQmiERVH8DmC3I94mZQSjckDRQ67xlheKgkRtujo+myQ6pvFpVGqe/nJefEAJG6G40CgjRw283zKfyjboSX+8Tfg5NSrwf5PXthPeSa0jLE8VwaleZ+pBqOIcV/f3lXiLADzBg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(44832011)(6512007)(36756003)(6486002)(16526019)(186003)(86362001)(52116002)(38350700002)(38100700002)(8676002)(2906002)(5660300002)(8936002)(478600001)(316002)(54906003)(66476007)(6916009)(6666004)(66556008)(26005)(83380400001)(956004)(55236004)(1076003)(2616005)(6506007)(4326008)(66946007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GB3uv65kBSHFr5DwL1P3ySWeFeFx7qh7L4jiDBcVxIiW7qrOT4OEqttC/qFw?=
 =?us-ascii?Q?6gtSkhO1EbecH5Cy6O9QcvjfpV2LV+IeJ1TFq6xXLVrhGOC98jfbMUR89wJd?=
 =?us-ascii?Q?ZCmP1g1lHu4RM62H8Sufo2jnzzeqXxvct0f4Asg9ngUyJqJTwNtKvXYc1msa?=
 =?us-ascii?Q?V2dnnWPexi/Qn1S51TRZLDthutGpnkfGBDGXG+PReMNjV7gHZ+JP44U5rqoA?=
 =?us-ascii?Q?IvItYYG42kic6AJlXKCQkp86yF05tsc6TBR6WoZqst9wNRsFzoxnS/Xnnqvx?=
 =?us-ascii?Q?gV04Udz5XlEyr4oniQuw/QhTRGUG/zWHXYJms7s8ccnhnljvEzh3h0WPhbgw?=
 =?us-ascii?Q?w/SXV8gVOEKMKNSR5JpqFW1oEbti+aT/tU63qm++R9eolqFDi+jb9JqMzSa8?=
 =?us-ascii?Q?Zu/5nXPiauoWaaejjGDBoeD7SAYCLiZW2EP+o5a6MB3gRtK80LHG3z2LfSmH?=
 =?us-ascii?Q?rQ7VpuDUz0ecLaKhL5rc5KZvHpDT/wfi3/bnig24A/37CrYIZ3cC6ce7iAny?=
 =?us-ascii?Q?dg6cnkiBKoAFdi6hsb0grgOMYbDESztgS8xXYnFEwOh93yaan9iTT3zK2Emx?=
 =?us-ascii?Q?T9i0LA0pFLaDiNG6b64J9O1GctIktYgpTPaBmldnqjYG+BM/bgMyYqyYNAcT?=
 =?us-ascii?Q?6GrBnQ3jpKiCl7tQURuJUpEcyg+P6hnBlO093gyvLTHoxiO6+ljGCtv1ypfy?=
 =?us-ascii?Q?Qll9GjFKGfCfc0CiYx7zwJCQVnV8eorVhCFU+tT7TIFnJ2c+UfifutGG7rol?=
 =?us-ascii?Q?xMSkNjaDyTAYpZk5jIJj9FIxiQIUjVVHtKbNluW+5j+pBc0zRddubu1EdVzK?=
 =?us-ascii?Q?8MECU0b4Z4VllbCScN0y1WJEOPPDoENOgfhUlzc7cyIYvj60kCA/sLko93qO?=
 =?us-ascii?Q?35mADCiEaI+p5WdlzSEfnYJy7hQlhkOBI/iNSuDZgHh7wWAPdB7A5ab7/OkC?=
 =?us-ascii?Q?vk5QsanZ21umLDTp9drUm87k3LATlof5gRk5qj5ABhP3sR4bY5p4a2qvAAi2?=
 =?us-ascii?Q?BIalBoy0hiav7zDCJNyp8yB2L8/2rKhzEt7Z05NE51cDK+0ltIDyfAvqvlfZ?=
 =?us-ascii?Q?dwsEl/y5nevtnuLu5OXJm66BmsvP1GeXIG+opiRuXzZpykHP70NrVcjBFCrC?=
 =?us-ascii?Q?7wML34neC5R42BAf1mSjtfxdfTRhXq25MHz8iAHGDtlPMFUR871hcMoxzlhi?=
 =?us-ascii?Q?kbYt06pRJ6KOm3K+yilYFB3GvQfAWfdV/lif5rhfHoQV5tohjtAd1fQV2eBM?=
 =?us-ascii?Q?CSDAe/2LVkmMXp0i51BkVAHp1l+BXYk+7Jx1P6loq4BMEoUQdyz4G1Fc46Zr?=
 =?us-ascii?Q?qXzY2WcWFuouMutkE8gNKTo3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1a22b3-0a22-46d1-edcd-08d92f5c71bb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:14.2353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLAfapkFqDftpg9Yni/wGKaPFXtLmKY0EALmKkoWwKzeoPf5B/Mbnza32Pu33c5z
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
