Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5C7C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D6A123117
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6A123117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 759FF89C6B;
	Wed, 13 Jan 2021 03:44:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2833F89C6B
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 03:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikxOO22hVKgc6qI3WLmZtqRXmXyNO714uYb28SH34wRwFrCjmGLxHFSBzAkgx6cXeLt7CzBjMmAhbQnosRZOxyiCwOycZKgtU+wjRd7YgccGoOUiK/3Mo2izMLSU/1Ksp6TZLdpQKpD34VJGbYNbHdmtXkysG08cXcALWAHQiF5Fnl3dId4zeMKLEcArzdqjsGwxJjQMxUD8+bXLU7vDlg8DHdmA+E4wBRA5Bpnqr1rqj7+KcHWo8oDuhuSDZ55oc8lSf1Bad/jgg1lj7leYGB4aQkg/8D9EAM8pCTgieppFaFKmljkan1C8zji+Ylp3IH+BT7ekJa/DCFlDkt8npg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDbIipqe+WyIQAzCA0O0T49cRv5Pv5YRZhAy33hz7FM=;
 b=aqJrG5BibyjgSf+R8Gsa92iCuQzk3pDxX2MrfwXd0q+hLp7RxoSe527zjlMRDWGF+9T9YwS34aQLzBX4oXpeBrICGZbdTyip7ROA1a+i4dZf3qqb4rxEQ7APopdwsx23l2+0LIFDP2XPLbVpS8C646fwsYfpo7Y7VnRmHLuVWfucBDU4vcvRAIUvVDwjXRazZctvIOSzW42ZPr8sqXxaUREeKjiOUNX7gSLwPT2H3odbaeL4C+RhwQ1eCEd5KvHZrxfaU+ZNRmM1S8qEirPgL2c5EJ/zGSrsMjX+cjM071jLcrKdKJPibiDcSu9J09nlXVldHg1OqbGkbUcKkgoSfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDbIipqe+WyIQAzCA0O0T49cRv5Pv5YRZhAy33hz7FM=;
 b=ExFs20yUUQixaOn1tPp7wlPDyX7HtOBQGD8WIfbbT5eBCuyMwwcUOzvuAIE4G+UxRzL4LkLg+f1OqQEq6RAgEseezu1oofSBy2WdD8Lhr9El1R6aIb3louYt+fQwz7HRfWUsicyqgOvIsO3/lqbRI2cKaaw3n+rn/uqWVeOcZO8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM6PR12MB3593.namprd12.prod.outlook.com (2603:10b6:5:11c::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Wed, 13 Jan 2021 03:44:18 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118%3]) with mapi id 15.20.3763.009; Wed, 13 Jan 2021
 03:44:18 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Add Secure Display TA header file
Date: Wed, 13 Jan 2021 11:43:53 +0800
Message-Id: <20210113034354.14557-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:202::28) To DM6PR12MB2812.namprd12.prod.outlook.com
 (2603:10b6:5:44::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR0302CA0018.apcprd03.prod.outlook.com (2603:1096:202::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.2 via Frontend Transport; Wed, 13 Jan 2021 03:44:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b9805ce-a68b-44f2-d2f6-08d8b77581a5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3593:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3593C863F011C72ADADB608A90A90@DM6PR12MB3593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:256;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /f5b2WlOWJW5bRMuq0mEmcsNTmXK2XlEMI4DDRgqjwTE8IKxitxH26DtUH988BOraE38qCDP1jrAEc3v+8tc0jVoNDn8UP8iCff12u270w500gx5+Fy24hWQ5RhsJgrGIRIIke28IDWrcIp5/+SVYkRdFpZZlnxZYGFr9G8Hc+9GRQoCwiFoZJtoTFEsFBNOP6+VMwk59QzLcAJZj/sg+3H1DKraqEzU2ex0Im/+57KZpUeSoJbeVz/9ovDxEU8tSw8vLmvYrhXolM97JsySz9sVIpxTfZwd/8JjkqRzHhmgQ6IU9u5cYbdiiHL0SXgcQo2cqngdLAhhabEqYoEX5pJPBecWDsNbzTFPjckm5xivJAa00qDFK1AVb5sTAOGAACPHGkrYtGZZKKX1hmyx3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(7696005)(83380400001)(86362001)(8676002)(1076003)(6486002)(186003)(2616005)(316002)(956004)(5660300002)(478600001)(52116002)(16526019)(6916009)(66556008)(4326008)(2906002)(66476007)(66946007)(26005)(8936002)(6666004)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gvYJqdX/9tRka1kSP+FhBDe0fE/Hvk/THsoxMn5NbRgCv5tswcLa1ch5Mlzd?=
 =?us-ascii?Q?Y0tl9ffpRObkqhYX7S4xFgRibVNqJfxRD1tGFyvQSJ+mY62GRVtpLQmDDCDV?=
 =?us-ascii?Q?XS6mMQEmzUxYJPDm7lnO1WuKWGp73bNs2ttSIU26obE/Mah674m1fNtkK85U?=
 =?us-ascii?Q?m4YO3K0+L/OXHD8ctoxLwcsQOR36CXblvj3ijLgJb1kYHyAqqs3VDjqqUxcy?=
 =?us-ascii?Q?Kf7TF50GDC8qR5Q7f4ZLvD/R7OygeeOSnpShPrYQDagysXdGvWwI23nFoD/b?=
 =?us-ascii?Q?g+Str8IetsL1chmGwk98CgLxUSH1VfxddV4EFPzZUjBSj/sD/7y/FOdS4RmN?=
 =?us-ascii?Q?JIOm86awL057dm5Ii6tSf8Iscz9LWuIK0h9r3a+H2vd9m7HWwaKcg+Bs/XB9?=
 =?us-ascii?Q?GL2LDig2sJEl0SilSf845SEKT86Zh+U+y0ESuDL4JsjJsO56GezBzr2rP7J9?=
 =?us-ascii?Q?UpWt8HodiFZVixSzw+PmZG6wZm32xd3Ln+DySjSNQqO7RiP13tKfI2f+V/5c?=
 =?us-ascii?Q?UJBRg04/hi/xTnecE2jHu3u5vOBCxSv+N5z+GjnE2jGhR3roJ2lejtKK8Qbr?=
 =?us-ascii?Q?tr4V4dO2FuhceQP7Wvnqe1ZHV87vUOxjw/XcUNP4woRIWoyuNWVeN0WBMVl1?=
 =?us-ascii?Q?qtnAr3mi5dh756RMGxgHIynoJl+2nhW2/SnLz0yypOlb9shnVrEirESJMQ4z?=
 =?us-ascii?Q?9QyFk9m0PAgSgDwgPa+c1DG1liUcRnLMjv/qhmBPHNKciyz/L3lhWxmKbNsX?=
 =?us-ascii?Q?opxXj6CubmhkcAm7fuh/bsQIfDpp5EpjAdUxQMta3OwgTz7yxUVtuerqb2R6?=
 =?us-ascii?Q?MbmcTElf2j/Alf2/geqJkpr2DV+7s1/iQCJwxqXvoEWlN8xdCMf/a2JMs+MH?=
 =?us-ascii?Q?kELZHpTRirRYZUFqZit74TymOxTXM1Plnx4BlfR3V7zVtScUBEBBjjVODyDo?=
 =?us-ascii?Q?WiLbhOHOlysyD3WeCsQBGjAspnHgCgA2kNLVvqaah0M5goGMzZS+V6vflOFL?=
 =?us-ascii?Q?WynI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 03:44:18.6126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9805ce-a68b-44f2-d2f6-08d8b77581a5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbVRAd1z88J1jxNbjeu7HMRmKXdg6RwMfW53Zd7ynDJ5FBwaUoZN3gp1fHZ2XWBzq9ef+hfCbtWyV6lKGVCyjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3593
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add file ta_secureDisplay_if.h for Secure Display TA

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/ta_secureDisplay_if.h  | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h

diff --git a/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
new file mode 100644
index 000000000000..5039375bb1d4
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
@@ -0,0 +1,154 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef _TA_SECUREDISPLAY_IF_H
+#define _TA_SECUREDISPLAY_IF_H
+
+/** Secure Display related enumerations */
+/**********************************************************/
+
+/** @enum ta_securedisplay_command
+ *    Secure Display Command ID
+ */
+enum ta_securedisplay_command {
+	/* Query whether TA is responding used only for validation purpose */
+	TA_SECUREDISPLAY_COMMAND__QUERY_TA              = 1,
+	/* Send region of Interest and CRC value to I2C */
+	TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC          = 2,
+	/* Maximum Command ID */
+	TA_SECUREDISPLAY_COMMAND__MAX_ID                = 0x7FFFFFFF,
+};
+
+/** @enum ta_securedisplay_status
+ *    Secure Display status returns in shared buffer status
+ */
+enum ta_securedisplay_status {
+	TA_SECUREDISPLAY_STATUS__SUCCESS                 = 0x00,         /* Success */
+	TA_SECUREDISPLAY_STATUS__GENERIC_FAILURE         = 0x01,         /* Generic Failure */
+	TA_SECUREDISPLAY_STATUS__INVALID_PARAMETER       = 0x02,         /* Invalid Parameter */
+	TA_SECUREDISPLAY_STATUS__NULL_POINTER            = 0x03,         /* Null Pointer*/
+	TA_SECUREDISPLAY_STATUS__I2C_WRITE_ERROR         = 0x04,         /* Fail to Write to I2C */
+	TA_SECUREDISPLAY_STATUS__READ_DIO_SCRATCH_ERROR  = 0x05, /*Fail Read DIO Scratch Register*/
+	TA_SECUREDISPLAY_STATUS__READ_CRC_ERROR          = 0x06,         /* Fail to Read CRC*/
+
+	TA_SECUREDISPLAY_STATUS__MAX                     = 0x7FFFFFFF,/* Maximum Value for status*/
+};
+
+/** @enum ta_securedisplay_max_phy
+ *    Physical ID number to use for reading corresponding DIO Scratch register for ROI
+ */
+enum  ta_securedisplay_max_phy {
+	TA_SECUREDISPLAY_PHY0                           = 0,
+	TA_SECUREDISPLAY_PHY1                           = 1,
+	TA_SECUREDISPLAY_PHY2                           = 2,
+	TA_SECUREDISPLAY_PHY3                           = 3,
+	TA_SECUREDISPLAY_MAX_PHY                        = 4,
+};
+
+/** @enum ta_securedisplay_ta_query_cmd_ret
+ *    A predefined specific reteurn value which is 0xAB only used to validate
+ *    communication to Secure Display TA is functional.
+ *    This value is used to validate whether TA is responding successfully
+ */
+enum ta_securedisplay_ta_query_cmd_ret {
+	/* This is a value to validate if TA is loaded successfully */
+	TA_SECUREDISPLAY_QUERY_CMD_RET                 = 0xAB,
+};
+
+/** @enum ta_securedisplay_buffer_size
+ *    I2C Buffer size which contains 8 bytes of ROI  (X start, X end, Y start, Y end)
+ *    and 6 bytes of CRC( R,G,B) and 1  byte for physical ID
+ */
+enum ta_securedisplay_buffer_size {
+	/* 15 bytes = 8 byte (ROI) + 6 byte(CRC) + 1 byte(phy_id) */
+	TA_SECUREDISPLAY_I2C_BUFFER_SIZE                = 15,
+};
+
+/** Input/output structures for Secure Display commands */
+/**********************************************************/
+/**
+ * Input structures
+ */
+
+/** @struct ta_securedisplay_send_roi_crc_input
+ *    Physical ID to determine which DIO scratch register should be used to get ROI
+ */
+struct ta_securedisplay_send_roi_crc_input {
+	uint32_t  phy_id;  /* Physical ID */
+};
+
+/** @union ta_securedisplay_cmd_input
+ *    Input buffer
+ */
+union ta_securedisplay_cmd_input {
+	/* send ROI and CRC input buffer format */
+	struct ta_securedisplay_send_roi_crc_input        send_roi_crc;
+	uint32_t                                          reserved[4];
+};
+
+/**
+ * Output structures
+ */
+
+/** @struct ta_securedisplay_query_ta_output
+ *  Output buffer format for query TA whether TA is responding used only for validation purpose
+ */
+struct ta_securedisplay_query_ta_output {
+	/* return value from TA when it is queried for validation purpose only */
+	uint32_t  query_cmd_ret;
+};
+
+/** @struct ta_securedisplay_send_roi_crc_output
+ *  Output buffer format for send ROI CRC command which will pass I2c buffer created inside TA
+ *  and used to write to I2C used only for validation purpose
+ */
+struct ta_securedisplay_send_roi_crc_output {
+	uint8_t  i2c_buf[TA_SECUREDISPLAY_I2C_BUFFER_SIZE];  /* I2C buffer */
+	uint8_t  reserved;
+};
+
+/** @union ta_securedisplay_cmd_output
+ *    Output buffer
+ */
+union ta_securedisplay_cmd_output {
+	/* Query TA output buffer format used only for validation purpose*/
+	struct ta_securedisplay_query_ta_output            query_ta;
+	/* Send ROI CRC output buffer format used only for validation purpose */
+	struct ta_securedisplay_send_roi_crc_output        send_roi_crc;
+	uint32_t                                           reserved[4];
+};
+
+/** @struct securedisplay_cmd
+ *    Secure Display Command which is shared buffer memory
+ */
+struct securedisplay_cmd {
+	uint32_t                             cmd_id;                    /* +0  Bytes Command ID */
+	enum ta_securedisplay_status         status;     /* +4  Bytes Status of Secure Display TA */
+	uint32_t                             reserved[2];               /* +8  Bytes Reserved */
+	union ta_securedisplay_cmd_input     securedisplay_in_message;  /* +16 Bytes Input Buffer */
+	union ta_securedisplay_cmd_output    securedisplay_out_message;/* +32 Bytes Output Buffer */
+	/**@note Total 48 Bytes */
+};
+
+#endif   //_TA_SECUREDISPLAY_IF_H
+
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
