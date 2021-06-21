Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BFCC49EA4
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8EA6054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8EA6054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E5736E241;
	Mon, 21 Jun 2021 17:12:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38CA689FCE
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5eAZzUzKrwmMaOKbKPKY7J2z7Q/C6j2zA+SLYY+XiDZjKILoQQKJz4/+bHtTrw3w52ZE77BLhnPrdpnvgex6erFlxzdrm4/wHvscA0nJAhxybSsHpYyGHLBcbTEb3uzJwXcctkThMZmWXcjC1RoU2a2+ju6G26my3IbQEqGQsPLlemWYDT6ZsFNU8i0MSkxcdKeoVpq2KMjsPvR3rP2CtMlV6GWah1J922T3CS0pYU23wrYsoU9TomGt7Enfi59BUzkXaE+Z1XVhJCqp43G4O1P0IcIro6jTF1jvRTi72gHHiYcZXy2kHfxd7SU2m1XBAdwrX9/WnjFaJxz+rnp2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NznSkyMQxVL7iEPeEjr8tCXutlmrji1M/oJzdzaH4A=;
 b=iIDNbYeCTp1ZoHqy65LpgFqgVBgrVxbSXfLV05PPvep+QYEVuFFt+CnWxo7ZMzg7nk4YnOL0ymUncBih/FUu7xd66/7upI4oRnZXP3Dct3c4FessjGzNl2eHlPuZxubSlGjI69BqtpGMoQIxzRtVhorjq+DJSRZdL3iY08ohRwIIlsayEy/ay1beDtwVKOHpdrtsyRqqnSO8Bd+C/DDHIaYujoTRkKvoWZ4EJQM0eqNW+be4bpIaEdI8mPBEVQlWbx2nCyCBv80Qkxt11Kl/sF0YDsYRlE2JLjONDm8zQ5Zuhxp3RdpeRGnvXu2ebEeaj/Q6GKmitZYGFB4BgNbvzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NznSkyMQxVL7iEPeEjr8tCXutlmrji1M/oJzdzaH4A=;
 b=YD8eRbz+C6bVnBqXqZToLXZG8Fs0sN46Ed2IJEHtFdWjOf4zya8S2dwhNSDMTRPeDG85IrTs7NDGtSO05HhjE6pCw6WH1/4nyCyxk65hELJP2bGsmCm/S7PxiU2RWdOAZxDZO5Vkj481J4NKBCwZa1dLJNeq1hYEaBBY6RfzEuo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:49 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:49 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/43] drm/amdgpu: Fix Vega20 I2C to be agnostic (v2)
Date: Mon, 21 Jun 2021 13:11:56 -0400
Message-Id: <20210621171221.5720-19-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf18f57d-4d5a-46d9-2107-08d934d7cb89
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB386525E5BFA67F46670A0772990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRWdDzkWydPsrkiwWSVMNa3MRLGKSppPBscRTUSad3RUEnDuY30f0LGGpCR4FTKcRuewFgrfj38i9dWpzAUAYmClXpHF/9iquIY+/ndW6A69bf2GdKKch8Go83gyRVEVJVbeBjNybi7j5CGX91lSKcOfVHFNG6D6u9JIIBMsH5/Rvx7ELrGL7wCd4PRU74BzpbmfsuDt3TFVUAvJjLJ58N9oF79l8seMxGD5Hte2VCPxlsad6DH9FS1DNMb5Jp0c5F/wHR+FTuBaVxtR187SEC2RrSONV4Fl5pvuxjEZMWhYSCQlCAg12wAS1UNX5gfoUv7rEkjGR1KTtvMPgBcZXlLgqz8ekxmGLJwCq5UX4EpajOTm6Cn/G3qEEicsb+/C8vuTOXgvYaTJC4Wnk7SNJVJBZovFdna9j8Z55DaUhVUIk7+YKK+Mhr7jeV/UZnKS/qA7uaBoR6AdEPj67z/G5CkhQuVtiQH2HN78czxsJY1qiLSaHf7+u9Iv+/3AQPHRhNS9PGitHS1tJrnuxkpEGvGXCVIxLSiNT+lN++b0V2pirdz6STpqwpwE2ezH6Cxlu9ILpIYt9UsjboDoDnBCK3Oo/LwRONwp20R9SIRoPvDMkhkRYNwjWNARXAshXiSg+AaQPTlLHSBQQvxv/FyXdOLmICJjAf3jldc5lW5UY6+J35gnLh9+yMGJU9Z+v60+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(6666004)(83380400001)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+tx1wGLxpoTRTwZiQ8q2orz7oUYdfXbIljr0RP3Pp2FQ4Bh7N653JKmSZ7Cy?=
 =?us-ascii?Q?4xkHM8qPeOVvd0Q4AxoLwK5+UWrv7acTgL2ZXUb0RSt/kXxQKoCEs8XY0Erg?=
 =?us-ascii?Q?80htNhAIg512fwLbhjCokGq3V3McKltdZlbAik4oLqMCJ2I/JaPB6g5Lk8xQ?=
 =?us-ascii?Q?Lb1wmegjbcAlIia5aXNhahEM6FCGO3tEtF5BqJkXN0l3dSVdfr059bKurxb5?=
 =?us-ascii?Q?n5eSvDkuA4p4V5gwq9NYTQ77UNA/t/Bj6fS3QQbCN0LlQEnNLDQN+Nasszye?=
 =?us-ascii?Q?dWYRF50hSCdJyRJoQvZlrQ5DrZr6coYiKZiLf9nSI0eFZ24+GgwKwM82O4pO?=
 =?us-ascii?Q?ayWuiJ0FzI7PA6GmgEADfi0YSgrgP3kKgalrlfHS8XMOZPbJs7P3q6/f54QU?=
 =?us-ascii?Q?TztZjTny8S9eVU+/+uTNxhBY3zFBNU8I3lgK29qCbIJ2ucDxaiBQ3xNX15/2?=
 =?us-ascii?Q?4DgePnczhPEZ8EBdEpKAQW6F1FLYexrlLURFzhknt5qIPhly4nJobl4RJwCR?=
 =?us-ascii?Q?0x8muJ32h24PmIGfKyo+t2NnmWkVCY9hg2SikqvRsHMpv0/aaW94fmn/WZCo?=
 =?us-ascii?Q?zQ8Rc85Xuw3hfEWAZaFBJbH3piRFrkgjPpPyhIZs2PJNjdhNgRyQk+7Bg/77?=
 =?us-ascii?Q?ZIIkf2cHlvgBFpwuFAbE1zwkDVYox4fsWc0zbkuw+MRBAacpCu7E/sTSPCVI?=
 =?us-ascii?Q?txiRmbcXkZsY+O7MLGISUZrhGjHmrMxPx9sVYUSPEGXei6eMgtOBAx0hZl8i?=
 =?us-ascii?Q?kJ6svYGcvoISJ90Mfn1CJO1fTB6vYfrOAEdGJd4x1GxsabUXcRnFUPnarZIl?=
 =?us-ascii?Q?emsnuMn11FnkgxlALKgIY2XAkwdnTINKsfSEXHjWgeqVtUngsOrLJgOZWjGW?=
 =?us-ascii?Q?afOlnAGQfBpjI1HoODpytbr+iv6n8OzutOST9v/YYTFkojtZEoQ6l6M0L91u?=
 =?us-ascii?Q?C8FR9fBGdndtcd3HNAfa/EDvl48Vo+cawS/GGNIal+zjIbYEbpUDNFgh+KDU?=
 =?us-ascii?Q?9EiEqAPLW7nW4jOfuEDAi6N0ZMRRuuLfMpcDgf2FQOZSbzHNA4pcYE8tUDAI?=
 =?us-ascii?Q?lmdv+UFidr0EyNrAp22L6iCT1rTSpY7WmkKDV+FCeSf5z8JWzKE7WBZF8b89?=
 =?us-ascii?Q?LPQElEhZzisDY9ojOUVcuR9XHlex1QD/55nJsNYFnVNGgYwawffdpe8g+vuT?=
 =?us-ascii?Q?dllGsO3jWL4NJPktPwgssuRtA6jCVD2LqBanyWzjHlIoAgvWzeY7X8ODuBug?=
 =?us-ascii?Q?yCqtnyJpYwpulF/rqJXYRhXnd3MhGs3k10vMFa82BxMmYVo7ygSFOAat8q/q?=
 =?us-ascii?Q?hCrb6cUQ4tW9xG+aSxUVknEW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf18f57d-4d5a-46d9-2107-08d934d7cb89
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:48.8859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgexM28hfVppdetOQOqCQ0k454oxMRMYVKQ1nw3DuTWSgCOI3sknHnRizwRBmrTa
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Teach Vega20 I2C to be agnostic. Allow addressing
different devices while the master holds the bus.
Set STOP as per the controller's specification.

v2: Qualify generating ReSTART before the 1st byte
    of the message, when set by the caller, as
    those functions are separated, as caught by
    Andrey G.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 105 +++++++++++++--------
 2 files changed, 69 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index fe0e9b0c4d5a38..d02ea083a6c69b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -41,10 +41,10 @@ int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
 		},
 		{
 			.addr = slave_addr,
-			.flags = read ? I2C_M_RD: 0,
+			.flags = read ? I2C_M_RD : 0,
 			.len = bytes,
 			.buf = eeprom_buf,
-		}
+		},
 	};
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 5a90d9351b22eb..b8d6d308fb06a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -41,9 +41,7 @@
 #define I2C_SW_TIMEOUT        8
 #define I2C_ABORT             0x10
 
-/* I2C transaction flags */
-#define I2C_NO_STOP	1
-#define I2C_RESTART	2
+#define I2C_X_RESTART         BIT(31)
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
@@ -205,9 +203,6 @@ static uint32_t smu_v11_0_i2c_poll_rx_status(struct i2c_adapter *control)
 	return ret;
 }
 
-
-
-
 /**
  * smu_v11_0_i2c_transmit - Send a block of data over the I2C bus to a slave device.
  *
@@ -252,21 +247,22 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
 		reg = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_STATUS);
 		if (REG_GET_FIELD(reg, CKSVII2C_IC_STATUS, TFNF)) {
 			do {
-				reg = 0;
-				/*
-				 * Prepare transaction, no need to set RESTART. I2C engine will send
-				 * START as soon as it sees data in TXFIFO
-				 */
-				if (bytes_sent == 0)
-					reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, RESTART,
-							    (i2c_flag & I2C_RESTART) ? 1 : 0);
 				reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, DAT, data[bytes_sent]);
 
-				/* determine if we need to send STOP bit or not */
-				if (numbytes == 1)
-					/* Final transaction, so send stop unless I2C_NO_STOP */
-					reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, STOP,
-							    (i2c_flag & I2C_NO_STOP) ? 0 : 1);
+				/* Final message, final byte, must
+				 * generate a STOP, to release the
+				 * bus, i.e. don't hold SCL low.
+				 */
+				if (numbytes == 1 && i2c_flag & I2C_M_STOP)
+					reg = REG_SET_FIELD(reg,
+							    CKSVII2C_IC_DATA_CMD,
+							    STOP, 1);
+
+				if (bytes_sent == 0 && i2c_flag & I2C_X_RESTART)
+					reg = REG_SET_FIELD(reg,
+							    CKSVII2C_IC_DATA_CMD,
+							    RESTART, 1);
+
 				/* Write */
 				reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, CMD, 0);
 				WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_DATA_CMD, reg);
@@ -341,23 +337,21 @@ static uint32_t smu_v11_0_i2c_receive(struct i2c_adapter *control,
 
 		smu_v11_0_i2c_clear_status(control);
 
-
 		/* Prepare transaction */
-
-		/* Each time we disable I2C, so this is not a restart */
-		if (bytes_received == 0)
-			reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, RESTART,
-					    (i2c_flag & I2C_RESTART) ? 1 : 0);
-
 		reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, DAT, 0);
 		/* Read */
 		reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, CMD, 1);
 
-		/* Transmitting last byte */
-		if (numbytes == 1)
-			/* Final transaction, so send stop if requested */
-			reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, STOP,
-					    (i2c_flag & I2C_NO_STOP) ? 0 : 1);
+		/* Final message, final byte, must generate a STOP
+		 * to release the bus, i.e. don't hold SCL low.
+		 */
+		if (numbytes == 1 && i2c_flag & I2C_M_STOP)
+			reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD,
+					    STOP, 1);
+
+		if (bytes_received == 0 && i2c_flag & I2C_X_RESTART)
+			reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD,
+					    RESTART, 1);
 
 		WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_DATA_CMD, reg);
 
@@ -591,23 +585,59 @@ static const struct i2c_lock_operations smu_v11_0_i2c_i2c_lock_ops = {
 };
 
 static int smu_v11_0_i2c_xfer(struct i2c_adapter *i2c_adap,
-			      struct i2c_msg *msgs, int num)
+			      struct i2c_msg *msg, int num)
 {
 	int i, ret;
+	u16 addr, dir;
 
 	smu_v11_0_i2c_init(i2c_adap);
 
+	/* From the client's point of view, this sequence of
+	 * messages-- the array i2c_msg *msg, is a single transaction
+	 * on the bus, starting with START and ending with STOP.
+	 *
+	 * The client is welcome to send any sequence of messages in
+	 * this array, as processing under this function here is
+	 * striving to be agnostic.
+	 *
+	 * Record the first address and direction we see. If either
+	 * changes for a subsequent message, generate ReSTART. The
+	 * DW_apb_i2c databook, v1.21a, specifies that ReSTART is
+	 * generated when the direction changes, with the default IP
+	 * block parameter settings, but it doesn't specify if ReSTART
+	 * is generated when the address changes (possibly...). We
+	 * don't rely on the default IP block parameter settings as
+	 * the block is shared and they may change.
+	 */
+	if (num > 0) {
+		addr = msg[0].addr;
+		dir  = msg[0].flags & I2C_M_RD;
+	}
+
 	for (i = 0; i < num; i++) {
-		uint32_t i2c_flag = ((msgs[i].flags & I2C_M_NOSTART) ? 0 : I2C_RESTART) ||
-				    (((msgs[i].flags & I2C_M_STOP) ? 0 : I2C_NO_STOP));
+		u32 i2c_flag = 0;
 
-		if (msgs[i].flags & I2C_M_RD)
+		if (msg[i].addr != addr || (msg[i].flags ^ dir) & I2C_M_RD) {
+			addr = msg[i].addr;
+			dir  = msg[i].flags & I2C_M_RD;
+			i2c_flag |= I2C_X_RESTART;
+		}
+
+		if (i == num - 1) {
+			/* Set the STOP bit on the last message, so
+			 * that the IP block generates a STOP after
+			 * the last byte of the message.
+			 */
+			i2c_flag |= I2C_M_STOP;
+		}
+
+		if (msg[i].flags & I2C_M_RD)
 			ret = smu_v11_0_i2c_read_data(i2c_adap,
-						      msgs + i,
+						      msg + i,
 						      i2c_flag);
 		else
 			ret = smu_v11_0_i2c_write_data(i2c_adap,
-						       msgs + i,
+						       msg + i,
 						       i2c_flag);
 
 		if (ret != I2C_OK) {
@@ -625,7 +655,6 @@ static u32 smu_v11_0_i2c_func(struct i2c_adapter *adap)
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
-
 static const struct i2c_algorithm smu_v11_0_i2c_algo = {
 	.master_xfer = smu_v11_0_i2c_xfer,
 	.functionality = smu_v11_0_i2c_func,
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
