Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492BDC48BE6
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171C6611EE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171C6611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE0EC6E117;
	Mon, 14 Jun 2021 17:47:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8DC56E110
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcxrI80SPX3nl43IWmbxQ/4WWrB/6xfOgbkUfMEFMTURsshLNOsKDAFSuTqN3CM4oMacTVQsnjA77qdyzG0P1g4KJ7VW3eEjLTUIhD/JlpDlehHKbsNCbHq1K/mdkqvOr+CW5bFBH5JtBivHk6lZn1GIXpN0pHvOegTFw/JmX4wC2PH96ATsYobrxPNA0vye9IDBeOPsjgW8MWWI7d+0a0ka4aksfB5i17+6Y0okqgwqmuRUTTx+Kh/ie6usyURxhDm9bzbw0ZDmAkw6ZAa8yR4/UIt+VFhMRqv9qwkTV8ZudIfaDuTvPQcG4BNcpo73vMRUBpebbqUjFOFwcwItCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv43ah7eShxf00NzwZ1rqq118/UOJoFxAikJQH5VzIA=;
 b=dTnTztidNSW/ZbuZAdHOhoT5P3zx3A31f5BoTM0Z0tI/X1gFCoWo+ERcODsRAYhv3rydodvOt+mpVus6hIla8R+LUckLqq1l+d5TTCWXMnMMpzmcCVxStn1l5zX+A5w0PZA4zdrjEuWtL/r2RFrSXjoQWxy75yFd843r4WycZYl873KQAxbpg17Ds5Im1x4OMGvhiE9X51VJ2w54Drn8M3D8/LssvgZKaf4oom0/Ypaf877U1U4v1M2C8C3P0XyUk9ZkKhLfJ9f0BLUV9hzjhoOknicfiOqL9Pv3BB7KD7xvJG88lRNklUZjwCcgFXhRNGlEK2QFuoOC1nrQEY4RAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv43ah7eShxf00NzwZ1rqq118/UOJoFxAikJQH5VzIA=;
 b=leCsCi2a4PUar+h9cx1LKDwpxhf7J5CuYtcqdhVsi5otqv9sZqsraON/iU6wJqTqS1edJk3EAh5TgbHVguURN/b7RJoetVaxfCGqo8A6VpW3gmRuF0JVWCtxgsf8NLslw4MzcJ+Ecr9oYBHRqA/yUJ164v449mF4DPnHtUc1AYA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:46:57 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:46:57 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/40] dmr/amdgpu: Add RESTART handling also to smu_v11_0_i2c
 (VG20)
Date: Mon, 14 Jun 2021 13:46:05 -0400
Message-Id: <20210614174632.20818-14-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:46:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 330f3e7e-4d06-4d54-7101-08d92f5c67a0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4748EAC3C58639272E49A0CB99319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jj+PM5AEoPDsoGq/BudbbKP+0n9kx793bVEXpwZH/+y1Xfkv/pJcvTXh7I5Tc5IUG1GLs8ckTeX0/FmvoJlHcPvBg07ZYbn85UlQnVGsZunNy3K90uiNuurotwYlIOXJ04K6cUPnteRufPufIYsFzD3wy8ug/FmBzGLb2HjpHE8ZD8Tlxn6xZqKQa19Ztj4xmjyjoCRia2lvfz7SmiF4KxRdoqekMczTy0XK5xoeZY04BKlx9bWUK4Do0g6sekbqWk3pPHYkXaVXVYcBT8z2HbCx2CFnqO4j9WYK4ZJpJGsOdVc1JkLjxNUse+25caFoF2yiybWHFWab1i6G4Jff9wB/06eRcZ0R+HS7ikb4mMFTn1CTvC3u93h+omeiAB5bNAFLZrc7xgawHIinBxFcCwOzB+pw6+7vsRg1Xml7U2bEVP9SuarM/EYyg3+mtr3/5NP0TAw23rkSfdQ++Et3eK42jcCS5sCK8Iup3t8Oc5aiL3VVVpLI38oil+rINJopUMnXUF4WSBFz9EV21aspnNzkL+MfHGcUQlgxSuAsfAbPn32f+Jnj1URGh6RKijtwAqrz5QfinQqRvxgL9nbpYweWWyltdsJ7zSIwjm/QChC4QNUCnWg+zJpsDOQ8mZN099PNToKZMYBugY8VoiJ4p9N4wrtlWoWumDjTw0GTddew5nTjEvvHES/5FtsONc/9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(6666004)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(6916009)(38350700002)(478600001)(83380400001)(6506007)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zu/DF/8KmNEMtOoJN83M9ZgFFUTzza/LPO67+CLr201V7WvOp5ZbTIEdFIB2?=
 =?us-ascii?Q?zF9zeNRwmnF8tSFfrPyuHDzGa1ZMqPt3SQ69rX3TrvOEIR7YytkzU+V+4v3M?=
 =?us-ascii?Q?e6KriYMJJXkjyDuqABgYBI2KacPvWPhUfddjjQ/C81UdbSDzJ/w2vODCnarE?=
 =?us-ascii?Q?FyrsFaVduBfNmPIhzhxsfgExCwAiELvfe/FSIL4YK8vDNzm6q/NK4vGYQL3U?=
 =?us-ascii?Q?D1ePD8lcbxNJ4NEGe0uEEHbM1+n8n81gAGbkGFPCrpCI8qsnfFrqPXelQB5l?=
 =?us-ascii?Q?8xIlwsv1eSBXT6Y/revjWfxX7fyyXTk3Kilgzme71Y+QKDua99Jq2A8alr9z?=
 =?us-ascii?Q?0rPb01im5kfbtb4hfi5rmF8D5LkWyxm4Y/r5JmM6tMaPg3mufHphKFVHQ1Uo?=
 =?us-ascii?Q?n6E/wU4I0tsDG1dRfreNehiaXr8Z6Z9xPWQaJL3aiekcpVdI8cqMqUOAdAYa?=
 =?us-ascii?Q?qqXMrqkrFFooYrv08F5Q6og+8pjUeRZHOapwVsSDp7Fs2I1Jjwqg9I4Z5fYD?=
 =?us-ascii?Q?OPqa+AWvXx5ldMlmKyQeGJVOdnGddao35Ww1GB2qi2EP/CJC4n5rVMeYEsrQ?=
 =?us-ascii?Q?mHG3LKoQ4PsZA6rDghelOLLxHJvFY50OCzQYAbqRGj6wzOOADJiQM0DfX6uV?=
 =?us-ascii?Q?RgYoHqmunjk+g/p5syoSXa/s2tzmfJx4rKYSg/q7A2FJjP8vfHn6zwUQZJWH?=
 =?us-ascii?Q?euinLWmgmlzlC0y+X8RNm75h6MB1qJmmbhxOBYGM3Sd0s4zgEDFBIJ+SzLfw?=
 =?us-ascii?Q?qL6/vF2i5GJ0GUMhUmjUaxagSsGM5OIWqUbQ9W+2izVb2sT+PeUkfX7INlJd?=
 =?us-ascii?Q?ueuj42dfl1KyJprZOduNBX3VQXg7wkWbyYtjYc5Ml/u+CqrMshSms9bUgQHT?=
 =?us-ascii?Q?rzfp/v+iPWMvH6tI0l4vYGE4tvvFDVqDslkzFXvEXPXJe9BWXRvi/JnnxVKl?=
 =?us-ascii?Q?EGCHlPHNSTlSI+qq9qu0umBac8ZgahgfHssMpKXJl8M8mxT/tRmQ9M8CuSCS?=
 =?us-ascii?Q?G+E7RaeSKEJHA+YEeI3BpPxlXJTKmv18vLOvrgvojnU9whAqYaUFQlZWTGs0?=
 =?us-ascii?Q?nuCjj9BkKuA9Gdt0OtgWO59VPt/UqCq7x++vtBOaKdrSo0lKffL6BhmZUc3e?=
 =?us-ascii?Q?lSgTBZzBPZTTKlmQ+iQCsaydGUSV20PoDOHgCaX30rOMoBkaX3tEdIEKZ/Qa?=
 =?us-ascii?Q?6iYCzcT0dfxbGUBy63MzxxtmQpMFfhG7exXGijQBoqZ79enUmM0x2rQuBanH?=
 =?us-ascii?Q?OOVAvBen/yOz53elwHlB3z7Svv0qx0DL3ar1/LqyG7zBDDBLBF3OU+qj2HDo?=
 =?us-ascii?Q?1O3B+Hnryow2GCXylnoYasHx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330f3e7e-4d06-4d54-7101-08d92f5c67a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:46:57.3169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnCbR9cAR5mwujpA95D37afg59XEDEzps1nygetmQ0VvTJxeu7GZn5YzPT3nDWeo
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Also generilize the code to accept and translate to
HW bits any I2C relvent flags both for read and write.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 3193d566f4f87e..5a90d9351b22eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -530,13 +530,11 @@ static bool smu_v11_0_i2c_bus_unlock(struct i2c_adapter *control)
 /***************************** I2C GLUE ****************************/
 
 static uint32_t smu_v11_0_i2c_read_data(struct i2c_adapter *control,
-					struct i2c_msg *msg)
+					struct i2c_msg *msg, uint32_t i2c_flag)
 {
-	uint32_t  ret = 0;
+	uint32_t  ret;
 
-	/* Now read data starting with that address */
-	ret = smu_v11_0_i2c_receive(control, msg->addr, msg->buf, msg->len,
-				    I2C_RESTART);
+	ret = smu_v11_0_i2c_receive(control, msg->addr, msg->buf, msg->len, i2c_flag);
 
 	if (ret != I2C_OK)
 		DRM_ERROR("ReadData() - I2C error occurred :%x", ret);
@@ -545,12 +543,11 @@ static uint32_t smu_v11_0_i2c_read_data(struct i2c_adapter *control,
 }
 
 static uint32_t smu_v11_0_i2c_write_data(struct i2c_adapter *control,
-					struct i2c_msg *msg)
+					struct i2c_msg *msg, uint32_t i2c_flag)
 {
 	uint32_t  ret;
 
-	/* Send I2C_NO_STOP unless requested to stop. */
-	ret = smu_v11_0_i2c_transmit(control, msg->addr, msg->buf, msg->len, ((msg->flags & I2C_M_STOP) ? 0 : I2C_NO_STOP));
+	ret = smu_v11_0_i2c_transmit(control, msg->addr, msg->buf, msg->len, i2c_flag);
 
 	if (ret != I2C_OK)
 		DRM_ERROR("WriteI2CData() - I2C error occurred :%x", ret);
@@ -601,12 +598,17 @@ static int smu_v11_0_i2c_xfer(struct i2c_adapter *i2c_adap,
 	smu_v11_0_i2c_init(i2c_adap);
 
 	for (i = 0; i < num; i++) {
+		uint32_t i2c_flag = ((msgs[i].flags & I2C_M_NOSTART) ? 0 : I2C_RESTART) ||
+				    (((msgs[i].flags & I2C_M_STOP) ? 0 : I2C_NO_STOP));
+
 		if (msgs[i].flags & I2C_M_RD)
 			ret = smu_v11_0_i2c_read_data(i2c_adap,
-						      msgs + i);
+						      msgs + i,
+						      i2c_flag);
 		else
 			ret = smu_v11_0_i2c_write_data(i2c_adap,
-						       msgs + i);
+						       msgs + i,
+						       i2c_flag);
 
 		if (ret != I2C_OK) {
 			num = -EIO;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
