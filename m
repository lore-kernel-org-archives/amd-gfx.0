Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C54C48BC2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8A16054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8A16054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D727C6E24D;
	Mon, 21 Jun 2021 17:12:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E156E219
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsRwWbjIp4SzgSPsQbrv0/hFSpWckOrjhmnlEWzdNhKA2dSik11kigDl/Xh7OyEkmprY0eXcv1E660hBVZfUj478K2SkbkorQpcD7dqDe2t839q/0iNDpR71+SQsSywPRX4Xj28vLjA44JYadm1POI2yPQObEEIvvvJasRN+Cm9WYB0uNvXdIAUiXTR1fuQBogd8xfzrK+XdDcP/m2KXTLY22b9GxyoyOZQ+lSPEWTPQcBReYGZbqZx9TTEc1se2VySrADlA6xV6kV1xxmI0l7O7BdC45/WOt17TcHJQw2XZ2mYTT8QZ5hGA/7RRrv3lkZ9xSw1RWoizLKGIMg4Qvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyhKK1+o1MXMEqceLq44MUx8MpjZj3Tt3EYcfaPyga8=;
 b=XfKym4tyjRwRDU8ObkJiEKmDaeqDsCj5nKNq4wVRWWsYUzf5fxS3TkKM5USX0MSV0sVk/P1PyrUCQ5nQmhaS6CYvhpr223yiTSxshXVKXiLc3fNYTIAfI2K4VNyPqxTn222GEDrRQJPp3Tv6BR+T7QbxPeX4RqEu5uaGDNs2c+eIt9QePU8/c0rtYcWMS2DVznx+4Pcjg6+CcHYCsynAdmLCM8gBkOrFq4cTOqHCUXBy9VxZBlY58+8eyQ1Z20DIH12bIfrdD4WdO1Pv0Qtrw/J3gMn2tlVKEGJxLLEri/BQIRX2s3ontGJy3EX7FOxXWgJ6ZHXIZ662AtqQx1z7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyhKK1+o1MXMEqceLq44MUx8MpjZj3Tt3EYcfaPyga8=;
 b=gdO7SYzqKWkupx1nfg4oEQyNFG4Df4YzC1V5nrFu73uqcP1Dxozvg/4L7AaT4NxpCbU+zIHOl+fXOLDf0kwUmcKUK5r8qImfxIsa6SF9ckOr3T0mA+a0jFC0X74nseSe4oaek3k9cHdKAf2Y3kA1twWBLy/Fj7qENZlUWowFm2c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:42 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:42 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/43] drm/amdgpu: rework smu11 i2c for generic operation
Date: Mon, 21 Jun 2021 13:11:48 -0400
Message-Id: <20210621171221.5720-11-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb95cc7f-5c2b-4e27-2cda-08d934d7c730
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38652842297F63A715B2344B990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:113;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hagsRHU4ERSfBgck7MMRU8L2EyspneJgqejWzufPtHlTTcWsHSDrX5cDXl5n18YjnMqZkO7Qwpm0AiOscYtk9X+xYW8YkAbg4exT4sWGh++RjxdlOxIsddLHSLphe+nVNduWVvEKVoETWOhS0VMlunbkOZ+Zb53pTW/loQVc8qFKCF424zB1BIaMLw8xb1wlPgtDK88BXPQ/i6B+4fdnI/8TQvJwfZrWgMd22TFG46GVp+8g+0MnBmUT4dtMPENxNjNSA8Vy6ZxQXvLGUXA2E24ZOU4leG1gzQH0oSteLpPJMoAg/aXeL6dxXKlDp8ARDUmG1CIW92DkpFjrpCdn5mcCOB4OBJc28hGrGSbyaoHLUWrGJC8vGtHaO3G7Sk/d/NODE8Np21CCCtppR1+UgRJVdj5r4Zcno6uosDDpmrVeGteqOi6UyoPvb2xHaddHTPtRuc5bNNstwa9/pSYhRZPUCkwvMFT0H/A7bEax5UluwD6ajUihwCX6QeZN+lFveqM4Wp+GcXWb3+Zow+THSG1fQy7KOMwg0SvxDVMvoQ3ku+248gQigphWAnDAh3LNGuQMf0waGbAHZca3+N5Lz7f6zrQg2F11CQRhT6YXsmSqfqIxJTEWIDT/Bj8Xcl4yiQsGtSmLBrvVTj/zjwoSTT0Hln96Dmx7O7APeahx86/GOesqZnUNcvWHW2+SgDypi90nr1w0EKBiYcWrvu0ntA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(83380400001)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZO6RF9vf1IPOYcqt94+b15JTZ4G2bRQWXN/+erqV/aLDtpeAxsqvyuYp9jug?=
 =?us-ascii?Q?gZDebHauysQ3rjJvnNhVtCfPFuECzm+JPiJ1fTxf4eJqmhkyVA2QLYVSGw3/?=
 =?us-ascii?Q?q/bnNMs0JxqIviaBveuJVPc8b7vKsJik76ewAUgxxDwJr3yrqR2kaVYz/14L?=
 =?us-ascii?Q?bgkZdwxEQeOO7CySZIvCQXMaDQ+urrcTmjs5a6Zz4HfFq77+WRBNV09uIfTK?=
 =?us-ascii?Q?jz8FimFd09NvrRva/dsmzTIn0I1kxcI/2hpsd9hgbUtuPSPSdHUtUYQqM4w2?=
 =?us-ascii?Q?dInIPnnQIPv426UPINIpFX3Iuvo5qk5Q5zxRAj1f4aG2F7RiUzhakrTXTL+Q?=
 =?us-ascii?Q?o+5eziVWdY7J2nTM40Jbw6lFCYsXp292C7pourXOntMJXZ9EBdl1D5y0U2lW?=
 =?us-ascii?Q?QXdxmTXsgilE1XW2VI8nVrxm2XYWa95jQvd/vysM1efOB9eOQhR2SKFXhvPX?=
 =?us-ascii?Q?n0a0nvgWgRz+X6pmP8sfeEBy9WHG7RT0Ni9Il+GwdgxScoUAJ7ISyBM0rFzk?=
 =?us-ascii?Q?2KlT7sNGPcSiSWCRcGLYcvY8XRHzqMDrsi1tji3gJH7xa2LEioMAmhlqffBC?=
 =?us-ascii?Q?DkS9yE+QogbBQc8wKg2URBkuB+VHbdCDZPE7rtvZj7iov3VQ5gxo1Y/Fz93y?=
 =?us-ascii?Q?NEUq9aQLXMTupuyuhOtQsn/0D2rX3M/4f+/PPBLPT4U+Et8NrCagW79zY2O7?=
 =?us-ascii?Q?7IvSxHDkO4gYaZWp+wZuemH9q9kgF+wqrteNhqwTmmk7xhqrszQby6DZuN/o?=
 =?us-ascii?Q?xqT53lqkhZ9rhKU9x7rjf9vV37y3R6JADcwYPsYVe+qzqsYltHs8c3Ks9h9y?=
 =?us-ascii?Q?Ro5PNusOEQZ8fEPXZvWStKzP+52qz11UTJpXBs0l+e8Mhpyjx5zaHZyAIyvK?=
 =?us-ascii?Q?U+Fl7CgjYtJix679xBX0ZYmefS3yTHWj2Q2XikRv0ODcyY6W5PPigwJmIq/D?=
 =?us-ascii?Q?44cdKHSOmpSa4Fq7nU4cPNDMiUhjk9rzwDvD0wn6E8GnYzWDeyUwL7s52UfZ?=
 =?us-ascii?Q?fUMEK+35+28GVBBM1hMDWpJ1HTJa1Iuz6kezlOwVRGM7/uhsK69I6GQVc31p?=
 =?us-ascii?Q?SzbgZkTWle8pdP6ZXto9eJW8AZIoHab3a6RfehgkLpi5T6/5WbXb6KbIoehD?=
 =?us-ascii?Q?j/9BSL8abXSolCp1CmEERbLLT+k5USmNy2d9YEfTVCLTY6APC1UiMtSHmumf?=
 =?us-ascii?Q?SRTxfa1eZvPh+AFQMAoRuXzcdCqbncMtsCDFSN08WAO9oY9VDG/K9+CtUZ2+?=
 =?us-ascii?Q?yr7G8MtYkXAAIevDCwfEx/2uDsmC5UYPcJKH/w5W2KsDVTHpc0mhmuTESWlU?=
 =?us-ascii?Q?673E72t7XndRDkPWwYQQoikK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb95cc7f-5c2b-4e27-2cda-08d934d7c730
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:41.5051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFTjicl37pp+SmVxGeWhthJbVMYZUdQy1Ps0Nth3y+rRFBjLJdD7R2enhUkTazgX
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
 Luben Tuikov <luben.tuikov@amd.com>, Aaron Rice <wolf@lovehindpa.ws>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Rice <wolf@lovehindpa.ws>

Handle things besides EEPROMS.

Signed-off-by: Aaron Rice <wolf@lovehindpa.ws>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 47 +++++-----------------
 1 file changed, 9 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 3a164d93c90293..3193d566f4f87e 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -117,8 +117,7 @@ static void smu_v11_0_i2c_set_address(struct i2c_adapter *control, uint8_t addre
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 
-	/* Convert fromr 8-bit to 7-bit address */
-	address >>= 1;
+	/* We take 7-bit addresses raw */
 	WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_TAR, (address & 0xFF));
 }
 
@@ -531,22 +530,14 @@ static bool smu_v11_0_i2c_bus_unlock(struct i2c_adapter *control)
 /***************************** I2C GLUE ****************************/
 
 static uint32_t smu_v11_0_i2c_read_data(struct i2c_adapter *control,
-					uint8_t address,
-					uint8_t *data,
-					uint32_t numbytes)
+					struct i2c_msg *msg)
 {
 	uint32_t  ret = 0;
 
-	/* First 2 bytes are dummy write to set EEPROM address */
-	ret = smu_v11_0_i2c_transmit(control, address, data, 2, I2C_NO_STOP);
-	if (ret != I2C_OK)
-		goto Fail;
-
 	/* Now read data starting with that address */
-	ret = smu_v11_0_i2c_receive(control, address, data + 2, numbytes - 2,
+	ret = smu_v11_0_i2c_receive(control, msg->addr, msg->buf, msg->len,
 				    I2C_RESTART);
 
-Fail:
 	if (ret != I2C_OK)
 		DRM_ERROR("ReadData() - I2C error occurred :%x", ret);
 
@@ -554,28 +545,16 @@ static uint32_t smu_v11_0_i2c_read_data(struct i2c_adapter *control,
 }
 
 static uint32_t smu_v11_0_i2c_write_data(struct i2c_adapter *control,
-					 uint8_t address,
-					 uint8_t *data,
-					 uint32_t numbytes)
+					struct i2c_msg *msg)
 {
 	uint32_t  ret;
 
-	ret = smu_v11_0_i2c_transmit(control, address, data, numbytes, 0);
+	/* Send I2C_NO_STOP unless requested to stop. */
+	ret = smu_v11_0_i2c_transmit(control, msg->addr, msg->buf, msg->len, ((msg->flags & I2C_M_STOP) ? 0 : I2C_NO_STOP));
 
 	if (ret != I2C_OK)
 		DRM_ERROR("WriteI2CData() - I2C error occurred :%x", ret);
-	else
-		/*
-		 * According to EEPROM spec there is a MAX of 10 ms required for
-		 * EEPROM to flush internal RX buffer after STOP was issued at the
-		 * end of write transaction. During this time the EEPROM will not be
-		 * responsive to any more commands - so wait a bit more.
-		 *
-		 * TODO Improve to wait for first ACK for slave address after
-		 * internal write cycle done.
-		 */
-		msleep(10);
-
+	
 	return ret;
 
 }
@@ -618,24 +597,16 @@ static int smu_v11_0_i2c_xfer(struct i2c_adapter *i2c_adap,
 			      struct i2c_msg *msgs, int num)
 {
 	int i, ret;
-	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
-
-	if (!adev->pm.bus_locked) {
-		DRM_ERROR("I2C bus unlocked, stopping transaction!");
-		return -EIO;
-	}
 
 	smu_v11_0_i2c_init(i2c_adap);
 
 	for (i = 0; i < num; i++) {
 		if (msgs[i].flags & I2C_M_RD)
 			ret = smu_v11_0_i2c_read_data(i2c_adap,
-						      (uint8_t)msgs[i].addr,
-						      msgs[i].buf, msgs[i].len);
+						      msgs + i);
 		else
 			ret = smu_v11_0_i2c_write_data(i2c_adap,
-						       (uint8_t)msgs[i].addr,
-						       msgs[i].buf, msgs[i].len);
+						       msgs + i);
 
 		if (ret != I2C_OK) {
 			num = -EIO;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
