Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9FFC4743F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116EB610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116EB610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE2F06EC5C;
	Tue,  8 Jun 2021 21:41:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB3D16EC5B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ci4KtX0mZr0DJPbYcce9dN+ABTnt6crmj8TcibTWQVOyam+iYcIYoPmlRlVz7uf0eCoFZb1Q3OQ0dZtvJiJlfj+2yzgIrqeqTia2RpbMBh1bL7Hq4Alsi+EcuFF4p1bkCwz8gof0upPathlJQokrVhKe/i864uHEbMoJDYDjp5m04jm6XPbZB0djonNj35XHboVFDetK0TySQRfysXZ/XXHOtnBZiiiqoMetrnaE3nmZ9AcM1OfpGAD0+7jUKML/Zn5/Fj9ve05j7CSHVkfOk6g6p1jBDWOUNCi+q02SpmBQTNERnLnJuNFQik/NNfG+pWRC5H0rLOy9Nknwweck2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3D7/aZcKGv5UypwrSUL6MH14jMCLgxg5BYimpAXBzY=;
 b=Om69h8Fjhv3xoDnmIhtVLNVAf5b9pKbdW+2lxLaYyUpEO9TdUcA4GNvZ4MjBmklAi4GqjmlX29kWxOQhfxYdukklaF6KU557o4yiXb8wn6+c/1KAuWqMxP2JB/h12xJNGbXr0eKe4Qx2iHXCpLy6tWiOVR6Yfp+K1HbQpvkBmMKxL7b4IePt0mB0PRTiKv4W/DVE30fy2sKwpJm8FxvpEwc8IH8X+jURmNlwVb+JjPzIB4vKPohhp0Fba8EDwXDDorGnOFrRc2ZLfpZT4XFv9AGJ7eYn7CpUg6DugKXTBN7L/HZYXEKss695Zxy4X1iWbpYgb3tX3S/NU3CXeYnsQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3D7/aZcKGv5UypwrSUL6MH14jMCLgxg5BYimpAXBzY=;
 b=CfNf+QFmVIa5F4svXEmv/AkMQlvy/qafLLIWnMyx8BLSYBeAt6aTiZj95lEbXq5O+QUnl/v8Dtj1OsO9G+EYGOjgxJtepGiPpqPbaR7k8eFcS/Z1M2YtO6QRcqelxnzDJZiyQe37QHSRGZjB2pn47nagvvum2WwsiSb1RmXP7CE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB4678.namprd12.prod.outlook.com (2603:10b6:4:a9::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.26; Tue, 8 Jun
 2021 21:41:16 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:41:15 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 40/40] drm/amdgpu: Use a single loop
Date: Tue,  8 Jun 2021 17:39:54 -0400
Message-Id: <20210608213954.5517-41-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70a87824-3752-40c0-51c8-08d92ac61331
X-MS-TrafficTypeDiagnostic: DM5PR12MB4678:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB46788ADD79D7D9BE08EB4D9B99379@DM5PR12MB4678.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWFdC165Xj0+TOriw2YNz9iDpKSD4QMcSpQPMuysrQ1Ev/esZktvsQPKC707a6lwYDlnHP5YPFYPLtzZcv5jcAyXNNCx4zvf2f0TkuhsnudGEDOcZiGE2xHppnpx1I9y9FDT5ZDXbqs4f0Yy7UujzNCX7pJbHtSqc8arWG5D5CSkhJMOJqNYM5uJbVXBT+ZxFS4fqGBc1doEB5jXcR8TEBe64Iz3PdKk02QFIY5yyXrtONuREn3KSVHlsAFHzRO+QrKenXOuWYMv7tAXsc+KliyLrrWYCla3mpe/+cQl0PoehjhBdidfMzU1q2egNROKMcFO8hwgPifyUqEljrv5vQ26hUjT6IzXSQpAi9k0nXgHBm7AFxhHb5jWEfvTlw2dhl3yGnEn9s85whwzLA2gmpMpRa1dbLD/l58sIyGIFpvlIvSB46DJ2nEQ3rBl/9QRi1WzYw7Bz1JWEnEpGvpwgKa7PKLwe+nahYmX9aP3ZWsE1n+KyzQ1O76hkLh5vGWiIFGC4Q447o1VwIgiNGTojdUUx1NolBvuJT0af1zOsA3JOr9TkBbiMkXXAbYKYCVP7/RH5DPEfJ1Vx/anSA6upY4D8VVWw0VlvgnNuPOw5RWaGyTpgrXHqDlHrf2hp4oEEHqUuTXIUEpMxL3wai4VkLtajbGvPjXfULoYanhItYPpnZ0tLyjEfWX1wE+lLv/Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(2906002)(26005)(6916009)(55236004)(6666004)(16526019)(8676002)(316002)(66556008)(6486002)(52116002)(66946007)(66476007)(86362001)(83380400001)(1076003)(38100700002)(8936002)(2616005)(478600001)(956004)(36756003)(54906003)(4326008)(186003)(5660300002)(44832011)(6506007)(6512007)(38350700002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?glE3Xg29Kpd3cpm/NbJl5ssRYRLuYXFk/A5FAVVkvMEWImmwBRWPkKZiBAt4?=
 =?us-ascii?Q?s2FO9PlEOEwT7+Fi06eU6XB3B9Rpr7V6FM7XMBioXc091neWCA72a78h+hzH?=
 =?us-ascii?Q?u5XQ5MHYsNO+3FzIczKGIGrbfLXpHroQAIH3n6bMvYGA3YrjuA6O2LS3DpXb?=
 =?us-ascii?Q?PbMGXB4oUhbemVpBcOFQb79DAKqqM+EqI9vSk69SRp9LK5E0WDxCqfTvTQrZ?=
 =?us-ascii?Q?dVyTQE0r0QOHadzr2ciVcOz74UPRwlXaikCETZowTccCYwUOJc9ttNjmKvgI?=
 =?us-ascii?Q?uKCW3auTiujmzCwPEZYpRPKMsmxvVwdyW3vIFNM/615zQeKPc222BffmstXH?=
 =?us-ascii?Q?3xJX1Wgqe9SrBVVRNxutiQMNoeG4Hm8e9+n8CPp8NdQ6UEDwZKWF3MxTSzex?=
 =?us-ascii?Q?eJbQddn78icZpLZEenXMmAZ7sLaIHVDxW/wXOIlyJN1HTLO6d8HYlrPxIS3P?=
 =?us-ascii?Q?U7pACmuN+oxf1e39Nxy/kcrOYhI/5iiGPmqkcjeVuDYL43XGVVNZzKDesu4G?=
 =?us-ascii?Q?LcXyWRBOH2Dgbu7RyKnboVs6riqun1dkkNfmfqD517XxMctCUcbNRQR6ur6c?=
 =?us-ascii?Q?xioJS2b1peL+KPpSSUq5M7fg1k/kWvkcwNWIxZvIvRQj5gSLxMmgWMtgH+ar?=
 =?us-ascii?Q?iDaWnPJtswzO6n1j6q0eQokSWyamYyPAe36qn5+qjXkEbrNxCzR6TsXvo2gK?=
 =?us-ascii?Q?D5Z/6PrOIy6crY7tEcwjLI+zA2xTZTn+GlPY+LC/pS09f0kveVajseV83EA5?=
 =?us-ascii?Q?+kcycPk3OEDJAlJKt8AMlM4WeyHNV00zSTPYGaeJXazeHrNR46ssgNzdddGG?=
 =?us-ascii?Q?DVmIXE5M5zaMH6ZSc0NgwTcw4+DaPXayojQ947wweM45Aa5TfjYQIo67N+Lq?=
 =?us-ascii?Q?lBH4PG1eOGvnvHb/Bmjt4uaLn0Hxeo84KQdM7qzvpa9ZjNIqCMnTek3IawX1?=
 =?us-ascii?Q?2Z1zshnIY35QZmd5qR6Wc5QnfkMb1mYvj6rLA+ryO/hdbUzR71JBY42rKabL?=
 =?us-ascii?Q?1PqHMoLiMw6V1ZnixKNA70+cf7ide/KfodYemPz9I4fc37QRZxMylMXF1+jH?=
 =?us-ascii?Q?ab2TY1aUumOSvNQd0KEY8qwIAjxye12l5EIUYw+Hmar9XZrwx91oCvbAf7Ds?=
 =?us-ascii?Q?FoGBvYqfiKA25gxIhShPfKfivcrGWJn0XVQIhD6TQV+FFetTGUOa7e56OgDY?=
 =?us-ascii?Q?c4KEoM084SFTCZtVUBJ8xKkK6ke+E2K23N24avpPVJ2uD54CsRFHOzHOGypq?=
 =?us-ascii?Q?42xP4QWjcSiOHbivtZ9eH60lBwOOaSgG6MuHw6/qeBfJX+QC2TWDeeMIs5qj?=
 =?us-ascii?Q?q4w0wAnT3zJcPcuFQI/4h7Wb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a87824-3752-40c0-51c8-08d92ac61331
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:46.4905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QuggEqiN/P4wSoWXY+LG7Vl3F7vBdvH9k/TU+Ovc10+mm5kQKJOvUl3DW659yGr
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In smu_v11_0_i2c_transmit() use a single loop to
transmit bytes, instead of two nested loops.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 72 ++++++++++------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 7f48ee020bc03e..751ea2517c4380 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -243,49 +243,45 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
 	/* Clear status bits */
 	smu_v11_0_i2c_clear_status(control);
 
-
 	timeout_counter = jiffies + msecs_to_jiffies(20);
 
 	while (numbytes > 0) {
 		reg = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_STATUS);
-		if (REG_GET_FIELD(reg, CKSVII2C_IC_STATUS, TFNF)) {
-			do {
-				reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, DAT, data[bytes_sent]);
-
-				/* Final message, final byte, must
-				 * generate a STOP, to release the
-				 * bus, i.e. don't hold SCL low.
-				 */
-				if (numbytes == 1 && i2c_flag & I2C_M_STOP)
-					reg = REG_SET_FIELD(reg,
-							    CKSVII2C_IC_DATA_CMD,
-							    STOP, 1);
-
-				if (bytes_sent == 0 && i2c_flag & I2C_X_RESTART)
-					reg = REG_SET_FIELD(reg,
-							    CKSVII2C_IC_DATA_CMD,
-							    RESTART, 1);
-
-				/* Write */
-				reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, CMD, 0);
-				WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_DATA_CMD, reg);
-
-				/* Record that the bytes were transmitted */
-				bytes_sent++;
-				numbytes--;
-
-				reg = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_STATUS);
-
-			} while (numbytes &&  REG_GET_FIELD(reg, CKSVII2C_IC_STATUS, TFNF));
-		}
+		if (!REG_GET_FIELD(reg, CKSVII2C_IC_STATUS, TFNF)) {
+			/*
+			 * We waited for too long for the transmission
+			 * FIFO to become not-full.  Exit the loop
+			 * with error.
+			 */
+			if (time_after(jiffies, timeout_counter)) {
+				ret |= I2C_SW_TIMEOUT;
+				goto Err;
+			}
+		} else {
+			reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, DAT,
+					    data[bytes_sent]);
 
-		/*
-		 * We waited too long for the transmission FIFO to become not-full.
-		 * Exit the loop with error.
-		 */
-		if (time_after(jiffies, timeout_counter)) {
-			ret |= I2C_SW_TIMEOUT;
-			goto Err;
+			/* Final message, final byte, must generate a
+			 * STOP to release the bus, i.e. don't hold
+			 * SCL low.
+			 */
+			if (numbytes == 1 && i2c_flag & I2C_M_STOP)
+				reg = REG_SET_FIELD(reg,
+						    CKSVII2C_IC_DATA_CMD,
+						    STOP, 1);
+
+			if (bytes_sent == 0 && i2c_flag & I2C_X_RESTART)
+				reg = REG_SET_FIELD(reg,
+						    CKSVII2C_IC_DATA_CMD,
+						    RESTART, 1);
+
+			/* Write */
+			reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, CMD, 0);
+			WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_DATA_CMD, reg);
+
+			/* Record that the bytes were transmitted */
+			bytes_sent++;
+			numbytes--;
 		}
 	}
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
