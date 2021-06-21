Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862FFC4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58EFF6054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EFF6054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E31789E01;
	Mon, 21 Jun 2021 17:13:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC1189E01
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X312fatpsEfM+FyKhdDooHcGP/3/M+Cwcdiw5fnenwo64XbOT0HMCzEe795p8RMTDAVytzwchUnSocxFhKv24PMBRbCPUrX5gW13SeI+dwKOVtW+MlDXkXnHIv/icbt54i86AmQ/Bm12dghmxkXTYW7dwYIVUgVRJ5kGJ7XdjHzYK3FzDgUOx37o5CL97QZx+TrbC68ZMyXkzNoxEYy9z1V+TsU4Z9iONYPmeQHzkPIHpDbH+JKNnXoYhp8suojIQe4Js+rRiGD3usHVHrl8eAwZ/RKHdZb6k0WEAvPaToXLSuV/3odFQ1cvJaR+SZnvx++ZJOa3xXCxZ8CLkNIC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5eiFddhLSGTRNYJ69xkz35gik/V8Lpb8pNiz+vRt5w=;
 b=DfaVV/eHJicQCL0Im2FReHfXrq5H205r/ccEmNnwjLu7YzTc8I/iFfJIG1kzbfV7IfY2Dhh/zSO2/eGcUMtHyigHcbWbygl+SwKsIfBEM5oUg+60Th+rIlmw5RQcbOkf54Rgp7DBY3JDrhv52yFWVyuSU7ENkGWnQFl1TmJWLeO2WIrTBavicxVaWILxsutyPC1yj3hy57/Q8E9D6Av0crNHPDrbp+mqe+RIyRffQIMfUUPUCcVX4FuGidRGuf2+10c3QVBGfdxT+D3yZt39y+QBM8C0KTC80JLcuy35ofR8YQcr3kDvczaHKgfw9MJnWW7Ii1eyOcy0unQKHLNYyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5eiFddhLSGTRNYJ69xkz35gik/V8Lpb8pNiz+vRt5w=;
 b=BPAJ2E3DpJ2c0lCzX/gWY6lk73MfcAygOtwMZlGstLPhXxNL09mlIUNlYJ9xDnjVusCGB1ShxEuVjAIFkpAaMqf4pY/fV1Y1KGPbUUr2LOept7cSRz0uIiueFsgZVt4jVZxLpO/a3AiutpWJrlm5lAE/Bk3D9x58nqjj+UeHulI=
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
Subject: [PATCH 32/43] drm/amdgpu: Return result fix in RAS
Date: Mon, 21 Jun 2021 13:12:10 -0400
Message-Id: <20210621171221.5720-33-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:13:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d9eb9b7-5d76-4080-cbf1-08d934d7d30a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29850A01CC9F3C2691B87CB8990A9@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wa9Lkbl8QcYdWOWxs30kn0NHBD1LZklPXKFeLLpawUrUhI3lR8z0Y3pd5Bu8IzmGhBGWnshUbDsUAi4eawQoDcCwVqAa4JoMaeK53rcWGgoGc1R5mFHftssnRhF12IDFBqcGU1pAeqdHbM22B+7s4xQEO9oEDqaPdfL5qy34zLafi2RVy0QUacYo6JVgtP7W/p3v5UesoL6gi9RHYU5gxlLDTlKTEa/sdCYwlHunDCI+niwIv4gIFqCu6yVvhVHc4vi3leDBmclkQuuP+rpDnmEcs6gu2CpphcLi1EmESEG4cJIVcxmkoZai94/0z0qoCj/PR1t6VnnwX7LggQ/jJcvoMhv5+jN7S+Nkcl9AxVqi8dWLIUTALzCFN2Edzk3WW0wUJaDKwDtsYrRTdx0LiLlfGQQsGx3Y3p+/pDPGLui53BPCchkdq98fI1iJW9364bcoACNDEGAtrpAzOyeBBqM1tIFzNZq3VwVOOPd4BOFdI31VAW5qfTTQH+kC0oo+k7uI8qrluM1b3IpVqNMx2cYcfh64er3VJv31wIA/pZaMHjQME7Ygks0RD+SMYrxwiLjTrJVLOgfBY1Zm2hwuANhrG2QIsrmaZjNiLii+3QIJcRn6D4MRQ2RH/1IMjF8TCDEueByNdZhf/qu6jw7f2kaDcZCQcwTYAP5Ir5k2lbnnBx9FzaH7QFD2gKsOTsy5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(6666004)(55236004)(8676002)(316002)(6506007)(6486002)(54906003)(44832011)(8936002)(478600001)(66476007)(66946007)(956004)(2616005)(6512007)(66556008)(2906002)(52116002)(36756003)(38100700002)(38350700002)(86362001)(5660300002)(186003)(4326008)(1076003)(83380400001)(26005)(16526019)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L7DpUqkBrdXWldzobCrweWGlArcp+ESgrhqdyyJIQkWvY6x4I2I4AxoEwmPG?=
 =?us-ascii?Q?a4OydhIp16vCyoCvp9+MlXnqci+O/MGFHJF0rHoU35b0pm4t/1S3juUyj1jZ?=
 =?us-ascii?Q?5aorlcnthDFlE72FThDCw921SzQNJX4VC3yS9hRqqkl0hOcGjv6m7WMyEcpO?=
 =?us-ascii?Q?UVHeB4P3xSRPQi97mqic45cCUpR4r2gEJUE3ZL/FO++eWWW7AwMGTJ4iiWZD?=
 =?us-ascii?Q?qaF2GxGnZ0qJSp1lFTXs5fxfo+OZRJ8Y8WzMtS27oAagtog6lIftufHVTkoI?=
 =?us-ascii?Q?Ym5X29ZAXpS/phZrp9vBBPr/oO48fJ85i8NkXMTujpNLt7cCaKZ7lT7GFp+/?=
 =?us-ascii?Q?/fpzp78a4cLGJJXLUw/+xSheiS00vMsxuuiJxmw8GZxSjn5y9nPCt8Cbza8e?=
 =?us-ascii?Q?qrK66hjUsbWUeZyccQ1HbiUhpw90mFT0w8Fx8Y4bzf/4JRdnmOs6UDOfayW3?=
 =?us-ascii?Q?xZnxTfttUhvdCNbCMxu1MZNhpFEeInDU4R8hvRK6MIFILWPGLJuMsPfAJK6z?=
 =?us-ascii?Q?WIpmX0qid3WpTZKlXyQlmCrm+Fh4+TWdYqex46I24UnbeghTSBj/HSCqW67E?=
 =?us-ascii?Q?izf0BqOSlS15Xljl06kxv49TZHpdp3Fq9yh9KewUGNQnjaJscGyYtma17kOw?=
 =?us-ascii?Q?WyToP5eHxwrN+R1JON1C7FBuyP98ahaFCrtpUtRDx0r+Xrhg0X+/TCntaP/+?=
 =?us-ascii?Q?RtXMbhzRLXi3qRNTjmMN7oDP/3U2t4LP3v7DR/iPfA1BEi2UXwTHvfosUAab?=
 =?us-ascii?Q?rPeN88KCEMQZC8li05PkSHYg+yMLoBAO+8lIhkv5hEbvTZc/7PI5xhsFmYzZ?=
 =?us-ascii?Q?h2eUouQS4Fsgj+SGBogkvydfE0jgp7y0o481zP/ESAT5dXUFVkA5ybkhQLa2?=
 =?us-ascii?Q?5tL2laBiXZ0X+uvs8kYoAeRpB3IbkC/QpibFl/zfjD7jzh53WT7JIFA8Edwy?=
 =?us-ascii?Q?eRMjVt4G7k2EH+EQlLpGpWKKPd3/H8IKIctZc2ksfxTNNLcyHRefoi9X/oEI?=
 =?us-ascii?Q?8yvUZsvw/yrHil8SsFeDNYAGV9oT/zOOMWMNFY44nLGQ4ECORMPps/JgUezl?=
 =?us-ascii?Q?CEzi1SsEa1nL8qSisY+H8V1vFlJSrCKjbihLofRW4jgEDORWJFAMh/0Ohewz?=
 =?us-ascii?Q?lX+IlH3Pc7xxRtbGzTdFQaAWoGvUfPIQU1w/A9ie/av6GZhUPf4PgUFOpkGu?=
 =?us-ascii?Q?K89s3OG8kjhBFu4upxfz1Kk6uiVhfY3hk/2FIhIH3ouOqCEg9kNnU5PjkJSs?=
 =?us-ascii?Q?DevvHCk+LWsdCaWxX3eWjbN8M2IQgCptxDEAim+OCSQ1ngqGzZ/cIQrY5vlh?=
 =?us-ascii?Q?57PV/3iiSQBYj6Q7fmh6/nqx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9eb9b7-5d76-4080-cbf1-08d934d7d30a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:13:01.4128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6g8j3vnzjM/nBMBgj6lJZPW3dwHFIsmCIYVItTuiTTL+p75tgffRKwxy4dVQfFk
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
index a9af6d0a2ed6bc..64054a825b7421 100644
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
 
@@ -1994,7 +1998,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
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
