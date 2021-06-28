Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A767C11F64
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 18:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D44461C31
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 18:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D44461C31
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC0A46E123;
	Mon, 28 Jun 2021 18:49:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB566E123
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 18:49:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvuWDHwSsPz6/a2zQakFkMpFLjCuR6iYs2wBz2z6bygiBlshGxFVRJreu/zbFHlBBvStkEi3F16aLe+cSdEYCrHmaeI40UgN8tJ1LlWynHP+hdcqkFedMPFv5xQ6ZtUC093nQfB0TZphMqu1KEHlG5esSErvMRWDP6ZXr6QxqArv6Yu1eK2vH3sikGKAN/M0hEy61e7oqzFIkXBfW1sfNHlyMVzRvWfQTX4gtGYTfk94bmQYnop88Cd/kQeJE2SRJ6IGBZjgFHaoV9eQDo0PED2piWUAtDQSa3MhdYSAPdbP/YDh8RIyslyOrO/RJJSrp4MlCRtddV/gRd2poGp9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrM6fygw59SSrBdaQePmHIWpLtG6ugXrEGtetnTwpJw=;
 b=JgLrzXZuL15HoqZdEmSuBMSLTX6c4l8c2TAdzuzKYVPuwNzxfdWVyc6nrNytrOSw15IUd0QYIj1jPTmsE8C++q+o7HinazJwk3Y4mexNTPncNC21PRb6s2+jkGsIdOhDyR0F6DgEPU76t78o45KiW6v1mnQXYGIshK+fjXPH/Os0mIpdyxezJBFyGOVoJXnGnLRCsnQWRzvW4hWPcYMfFCfQqH26v0o0X1B0puVGoqky6TEfJzJfBWXYCtRIvd08S6TgqYsCR237rKiIRXA4kk8jy8j1d+1S2czDprPSbveEzvOsJFgon5i8zqJKYHtwULb8E2elcGf6ajhQQub24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrM6fygw59SSrBdaQePmHIWpLtG6ugXrEGtetnTwpJw=;
 b=VyflCPbvvaa6+DTRIRvQ8ZR9fBxRdUeNrlNwuaW4qgn0gCk8/7Hu4NuLXR8iAsjAOSbhDCPMYG6ILnxuDdA7ye60ljfd0W81x9La5a7XtrSe3uEuscA44CjM+vC4b8xC4ycf/0MbLM7vorgBnhZ7EM7D27CA85UR1TmmQLpHO58=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 18:49:00 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 18:49:00 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/pm: Simplify managed I2C transfer of Aldebaran
Date: Mon, 28 Jun 2021 14:48:34 -0400
Message-Id: <20210628184836.84530-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YTOPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::17) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.amd.com (165.204.84.11) by
 YTOPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Mon, 28 Jun 2021 18:48:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70cb97f8-58e5-46a1-501f-08d93a65642e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4959:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4959EC6334B6608E5C65A08399039@DM6PR12MB4959.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIIxs/lHPCC2UC9Wx/SOkigPWauORk8S4C2YoVuitg2gK2G8o1B0CPh0ldPKqw2mTgsVcdqJagTKK64WjZumCM3gNDRrritxRkel5rKA9A5PO8AtNNv6u//f3KKOlhS1dvtcsj9yse3ggiNVIAdIRUdxMPhPIJ15jr+OiNm/hOIgC0EI/MOts+12ltd4clTW5KwwiV+h9UJOBXzwX+v0uiX/EOH2+rJFXwIAGJajv6BppUjfi7UQM5YQWkDLna+IthSy3eb7nCrzIqyjzKvi3k5HGqzQE5t/7dk19DAPQi8pUhAmzJDDvt6RGEP6WaG2EMNzKC06DXoqVD3X3QYPvzS928S9TSQSDtCpRzmbnY6GdAW61Wz13yF6MDYyc6YDrHNnMW1ZsnhpLfPD4Dp/VIYzDbUXj3duYiYXLxOGWwDShu9hZpezpfLZdWfoiZFRMMwG+0f5rJrA661jTX7m4gcCWc8+ozWc/7PZrKKaH0kjinh8JKx9Ff4RW4qfhz2Fs1U0Vb1j+dZImqp7f0EDeReq5cXpZy+Vn12P2iiLo0csD2r+1LZoddP5KAvavvK8i/3O8tFiNHstjMtA+FBiy/VtVdxJA9L1thbS+OJKu35QVRWjbqVLiehDgnsAKUz8h2Ww8mHvqvCxiUomQl3JWWpulxbNrJuP72M7PahbfqJZvQ9ifHv1Is1NvB8OaQW3gg/psXVrDuY/3GX/VYHdXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(8936002)(44832011)(52116002)(83380400001)(8676002)(316002)(66476007)(7696005)(66946007)(478600001)(6486002)(66556008)(5660300002)(956004)(38350700002)(36756003)(1076003)(4326008)(86362001)(6666004)(38100700002)(6916009)(2616005)(2906002)(54906003)(26005)(186003)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qaLOIRRveypskQ+oQt9vEpz5zAtxztIAMmivl1ojvsr5gTrQJau/aVHE+Kvz?=
 =?us-ascii?Q?JK7VS3jJqZmD3qmb5skavY43xjYvZ9ok5QTuZNPezycMEChg+YFdhMc3uqb5?=
 =?us-ascii?Q?oHSI/+AeECKKiUwjYPGkb19B2PzNejwFtfRRvCq+KFU0iqtx12QY5gwOQuvN?=
 =?us-ascii?Q?qy8pgGpMUdGIq2rpGwFTkJzpASZLDfRZ2DksRwnhcbOZjgaMs4gKIb7Gn3co?=
 =?us-ascii?Q?BibMP04uTbuu66JQI9FrmHjJ4y0Nic6vfh+o2nhXyNlSIJ5xgTwhBJHXK3ps?=
 =?us-ascii?Q?YJ6Sh9CfMtF4duePTv/kAG3Jm7WxGiBW63byNme/2d1hneatfV9VKT7tiRvs?=
 =?us-ascii?Q?r7xIWtgmFedfCUEYUeDGvl2BBRsOttRUqycbAR8YdQJR6PosMf6oESqSmXVP?=
 =?us-ascii?Q?31+rCr4qgNxUZ2HhpytjVP8V//0xEP9RvcLnHUbGCErCnaJHN3pTcOTmTTKb?=
 =?us-ascii?Q?ecrNOpYCoyVAxbI+DId19g80Ud7Sx7uSpC2ORkP9dhLtnmWWitxs/PA+3rJu?=
 =?us-ascii?Q?1PwmBdXqbVz4WXqhM6T6dPc3hMy1XF7mZcv1zsijx7TsBQanR1oo4u8YJaoY?=
 =?us-ascii?Q?i7/ILO0e6S63pGyyBfCxXZ/b+uN12gLxZh0sCDhL8lXaxZjHSc0DfJjIbDlo?=
 =?us-ascii?Q?0x8aKsHAD7aOh3fRiaV4wFsh88NfwBWojtMPUgPUXyYPvwrvZLwWULtPFLXJ?=
 =?us-ascii?Q?W2DXhiynN7yr038nJBPIIXDIDzERMH5+irfQnKRShnd4Q2yw3lWWABiXzQJl?=
 =?us-ascii?Q?68zRoIiEXv95ZpB5jdirRQvu4tiCLtxcZYANVDVgrxtAO+C1m3w10A6pekFs?=
 =?us-ascii?Q?UXbDsqd3Uy2IOIzlsG50ZpszDpogJjRvzNt7jxttNsgMLPJ1ldKuerUHRPBw?=
 =?us-ascii?Q?t294ckKWRnwnMCenrmEptHsiMZEnMlwNX4js1XyatvFSSLxgENwJbSQ5Crli?=
 =?us-ascii?Q?aGVoylpDeHeP8wd6VSAnNS2qhzQJ8wAjXUX2giGZ69ZAJpVN93+o96qmkxAq?=
 =?us-ascii?Q?QJkw4KAP5PTibMGXFdYHYiLDsdyAXSvVAAKLTYew6WvvntdYvFWl6hBUEqvI?=
 =?us-ascii?Q?5rPlpZszGHSqBZXFmnAWZHcc3XrdSs2vUr7mXw4oPpAA+AXNSP6XgHWM2v5w?=
 =?us-ascii?Q?W0mo+SjF8eAOC4f/aKBm5le3DFkr9QnfTV1bjuy5xCbaeJ/nwXqY5cd8nTSY?=
 =?us-ascii?Q?rlCD6hEoCqvOIJYV4UGoIzZDSEkmDAFaFT7auuyijN7gmWCTU4Nxse5To00e?=
 =?us-ascii?Q?Fvh9cwpFEKhnMOOZLbBUx4hyZEiD2RlgsX9Xv143wFI+G0BGf6p1Na9pMLVz?=
 =?us-ascii?Q?a8EV11ru/zoRK6QmqFJe2YyR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cb97f8-58e5-46a1-501f-08d93a65642e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 18:48:59.9838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dv0lhfUr//TtRfI6iK3hDhwP14zNqzZhOH2Ofv699n6ZlIG8z8QETjHS0UBpNzK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
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
 Alexander Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Simplify Aldebaran managed I2C transfer function
to correctly play with the upper I2C layers.

This gets it in line with Navi10, Acturus, and
Sienna Cichlid.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 230 +++++-------------
 1 file changed, 55 insertions(+), 175 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 9316a726195cc0..f30edf862b86d1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1425,197 +1425,77 @@ static bool aldebaran_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
-static void aldebaran_fill_i2c_req(SwI2cRequest_t  *req, bool write,
-				  uint8_t address, uint32_t numbytes,
-				  uint8_t *data)
-{
-	int i;
-
-	req->I2CcontrollerPort = 0;
-	req->I2CSpeed = 2;
-	req->SlaveAddress = address;
-	req->NumCmds = numbytes;
-
-	for (i = 0; i < numbytes; i++) {
-		SwI2cCmd_t *cmd =  &req->SwI2cCmds[i];
-
-		/* First 2 bytes are always write for lower 2b EEPROM address */
-		if (i < 2)
-			cmd->CmdConfig = CMDCONFIG_READWRITE_MASK;
-		else
-			cmd->CmdConfig = write ? CMDCONFIG_READWRITE_MASK : 0;
-
-
-		/* Add RESTART for read  after address filled */
-		cmd->CmdConfig |= (i == 2 && !write) ? CMDCONFIG_RESTART_MASK : 0;
-
-		/* Add STOP in the end */
-		cmd->CmdConfig |= (i == (numbytes - 1)) ? CMDCONFIG_STOP_MASK : 0;
-
-		/* Fill with data regardless if read or write to simplify code */
-		cmd->ReadWriteData = data[i];
-	}
-}
-
-static int aldebaran_i2c_read_data(struct i2c_adapter *control,
-					       uint8_t address,
-					       uint8_t *data,
-					       uint32_t numbytes)
+static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
+			      struct i2c_msg *msg, int num_msgs)
 {
-	uint32_t  i, ret = 0;
-	SwI2cRequest_t req;
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
 	struct smu_table_context *smu_table = &adev->smu.smu_table;
 	struct smu_table *table = &smu_table->driver_table;
+	SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
+	int i, j, r, c;
+	u16 dir;
 
-	if (numbytes > MAX_SW_I2C_COMMANDS) {
-		dev_err(adev->dev, "numbytes requested %d is over max allowed %d\n",
-			numbytes, MAX_SW_I2C_COMMANDS);
-		return -EINVAL;
-	}
-
-	memset(&req, 0, sizeof(req));
-	aldebaran_fill_i2c_req(&req, false, address, numbytes, data);
-
-	mutex_lock(&adev->smu.mutex);
-	/* Now read data starting with that address */
-	ret = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req,
-					true);
-	mutex_unlock(&adev->smu.mutex);
-
-	if (!ret) {
-		SwI2cRequest_t *res = (SwI2cRequest_t *)table->cpu_addr;
-
-		/* Assume SMU  fills res.SwI2cCmds[i].Data with read bytes */
-		for (i = 0; i < numbytes; i++)
-			data[i] = res->SwI2cCmds[i].ReadWriteData;
-
-		dev_dbg(adev->dev, "aldebaran_i2c_read_data, address = %x, bytes = %d, data :",
-				  (uint16_t)address, numbytes);
-
-		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE,
-			       8, 1, data, numbytes, false);
-	} else
-		dev_err(adev->dev, "aldebaran_i2c_read_data - error occurred :%x", ret);
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
 
-	return ret;
-}
+	req->I2CcontrollerPort = 0;
+	req->I2CSpeed = I2C_SPEED_FAST_400K;
+	req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
+	dir = msg[0].flags & I2C_M_RD;
+
+	for (c = i = 0; i < num_msgs; i++) {
+		for (j = 0; j < msg[i].len; j++, c++) {
+			SwI2cCmd_t *cmd = &req->SwI2cCmds[c];
+
+			if (!(msg[i].flags & I2C_M_RD)) {
+				/* write */
+				cmd->CmdConfig |= CMDCONFIG_READWRITE_MASK;
+				cmd->ReadWriteData = msg[i].buf[j];
+			}
 
-static int aldebaran_i2c_write_data(struct i2c_adapter *control,
-						uint8_t address,
-						uint8_t *data,
-						uint32_t numbytes)
-{
-	uint32_t ret;
-	SwI2cRequest_t req;
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+			if ((dir ^ msg[i].flags) & I2C_M_RD) {
+				/* The direction changes.
+				 */
+				dir = msg[i].flags & I2C_M_RD;
+				cmd->CmdConfig |= CMDCONFIG_RESTART_MASK;
+			}
 
-	if (numbytes > MAX_SW_I2C_COMMANDS) {
-		dev_err(adev->dev, "numbytes requested %d is over max allowed %d\n",
-			numbytes, MAX_SW_I2C_COMMANDS);
-		return -EINVAL;
+			req->NumCmds++;
+
+			/*
+			 * Insert STOP if we are at the last byte of either last
+			 * message for the transaction or the client explicitly
+			 * requires a STOP at this particular message.
+			 */
+			if ((j == msg[i].len - 1) &&
+			    ((i == num_msgs - 1) || (msg[i].flags & I2C_M_STOP))) {
+				cmd->CmdConfig &= ~CMDCONFIG_RESTART_MASK;
+				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
+			}
+		}
 	}
-
-	memset(&req, 0, sizeof(req));
-	aldebaran_fill_i2c_req(&req, true, address, numbytes, data);
-
 	mutex_lock(&adev->smu.mutex);
-	ret = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
+	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
 	mutex_unlock(&adev->smu.mutex);
+	if (r)
+		goto fail;
 
-	if (!ret) {
-		dev_dbg(adev->dev, "aldebaran_i2c_write(), address = %x, bytes = %d , data: ",
-					 (uint16_t)address, numbytes);
-
-		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE,
-			       8, 1, data, numbytes, false);
-		/*
-		 * According to EEPROM spec there is a MAX of 10 ms required for
-		 * EEPROM to flush internal RX buffer after STOP was issued at the
-		 * end of write transaction. During this time the EEPROM will not be
-		 * responsive to any more commands - so wait a bit more.
-		 */
-		msleep(10);
-
-	} else
-		dev_err(adev->dev, "aldebaran_i2c_write- error occurred :%x", ret);
-
-	return ret;
-}
-
-static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
-			      struct i2c_msg *msgs, int num)
-{
-	uint32_t  i, j, ret, data_size, data_chunk_size, next_eeprom_addr = 0;
-	uint8_t *data_ptr, data_chunk[MAX_SW_I2C_COMMANDS] = { 0 };
-
-	for (i = 0; i < num; i++) {
-		/*
-		 * SMU interface allows at most MAX_SW_I2C_COMMANDS bytes of data at
-		 * once and hence the data needs to be spliced into chunks and sent each
-		 * chunk separately
-		 */
-		data_size = msgs[i].len - 2;
-		data_chunk_size = MAX_SW_I2C_COMMANDS - 2;
-		next_eeprom_addr = (msgs[i].buf[0] << 8 & 0xff00) | (msgs[i].buf[1] & 0xff);
-		data_ptr = msgs[i].buf + 2;
-
-		for (j = 0; j < data_size / data_chunk_size; j++) {
-			/* Insert the EEPROM dest addess, bits 0-15 */
-			data_chunk[0] = ((next_eeprom_addr >> 8) & 0xff);
-			data_chunk[1] = (next_eeprom_addr & 0xff);
-
-			if (msgs[i].flags & I2C_M_RD) {
-				ret = aldebaran_i2c_read_data(i2c_adap,
-							     (uint8_t)msgs[i].addr,
-							     data_chunk, MAX_SW_I2C_COMMANDS);
-
-				memcpy(data_ptr, data_chunk + 2, data_chunk_size);
-			} else {
-
-				memcpy(data_chunk + 2, data_ptr, data_chunk_size);
-
-				ret = aldebaran_i2c_write_data(i2c_adap,
-							      (uint8_t)msgs[i].addr,
-							      data_chunk, MAX_SW_I2C_COMMANDS);
-			}
-
-			if (ret) {
-				num = -EIO;
-				goto fail;
-			}
-
-			next_eeprom_addr += data_chunk_size;
-			data_ptr += data_chunk_size;
+	for (c = i = 0; i < num_msgs; i++) {
+		if (!(msg[i].flags & I2C_M_RD)) {
+			c += msg[i].len;
+			continue;
 		}
+		for (j = 0; j < msg[i].len; j++, c++) {
+			SwI2cCmd_t *cmd = &res->SwI2cCmds[c];
 
-		if (data_size % data_chunk_size) {
-			data_chunk[0] = ((next_eeprom_addr >> 8) & 0xff);
-			data_chunk[1] = (next_eeprom_addr & 0xff);
-
-			if (msgs[i].flags & I2C_M_RD) {
-				ret = aldebaran_i2c_read_data(i2c_adap,
-							     (uint8_t)msgs[i].addr,
-							     data_chunk, (data_size % data_chunk_size) + 2);
-
-				memcpy(data_ptr, data_chunk + 2, data_size % data_chunk_size);
-			} else {
-				memcpy(data_chunk + 2, data_ptr, data_size % data_chunk_size);
-
-				ret = aldebaran_i2c_write_data(i2c_adap,
-							      (uint8_t)msgs[i].addr,
-							      data_chunk, (data_size % data_chunk_size) + 2);
-			}
-
-			if (ret) {
-				num = -EIO;
-				goto fail;
-			}
+			msg[i].buf[j] = cmd->ReadWriteData;
 		}
 	}
-
+	r = num_msgs;
 fail:
-	return num;
+	kfree(req);
+	return r;
 }
 
 static u32 aldebaran_i2c_func(struct i2c_adapter *adap)
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
