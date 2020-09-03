Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80965C43461
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 16:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536D220775
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 16:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zxWfitbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536D220775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23EA86EA13;
	Thu,  3 Sep 2020 16:22:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B056EA12
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 16:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmBZ2BECzCEYov47X+BL09Gk5vvzqHzy/I8qUqsa8sepBa5VWhfTNw0JniFmA6NX173OHJTFs0D182OwEDS2cgfP1YuY8QqvF7DT3kPJHAsyrUq9zVf7p3rFI39xDEf9284xAqRgYkPJMhWsgZLI++nv0Pr8NI4BkI4GaD5/iWbP38gK1cQBio7WLS4XSSF4VhvAFU3uMjFeNItsgZZ2c80IgSBMIerSwaq4h4+4+ElEyIunZq+jA/t1unXn1HAbnv51By0jWmFVwLcLx2FK4OjD75JtqFoHk3wn+RDlDYfg8xXJNeFJU1JR3O77W/yG4jG8W3xUr73rcYHTabLQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f38DpBrMoj4X4g2JfP/z8ZzqECkOHRjpv2Zyx+nNLYU=;
 b=G8ZZjgU3vBWCVNpPH6TWPgcpo3Tkmu8cZT70x/Kykmn6YZd1fMRwMEZJ0JcdyXOI1PulhJsFIFasutPTPy0LDGkkLupggs13t1/raN8opThipu8k1KXjiiC86lvuo2akDgGaAwR80TZxh9KPw4h4kqx9su4CLw3a+eRL8LMPjrox2aXgMkVwoNAapG/6HlzEBSiKccoceO2ki74BQbaOCs2nRJTih60xhWNdO8RBOxgYdMmTHgsxFTMXnDsfVXU7+DJE7AxvnYF/RZBtT7e/fBZqIVp390GNBZibsE/QVXKzemcKbM/4fVEAW/6WYPbUBA6u0JK5ic9bBN/QTZwBow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f38DpBrMoj4X4g2JfP/z8ZzqECkOHRjpv2Zyx+nNLYU=;
 b=zxWfitbs1f8ZJeGBK0NcoKy/4KOzcEaZ5NL6AtGioh2LgDTcUnG9qSZ15bkKsDw+OnnvOKDkqz0mnjVrScx53GdO7W9RfvraiM0z5wVQACnY+wpOT4jGGeO85REZ1v8dBQ+qEoVlKGeCUxeDzfOfxFyxv3xGQA4Wgpahdj/o95g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN8PR12MB2978.namprd12.prod.outlook.com
 (2603:10b6:408:42::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Thu, 3 Sep
 2020 16:22:15 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 16:22:15 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/6] drm/amdgpu: add xgmi perfmons for arcturus
Date: Thu,  3 Sep 2020 12:21:54 -0400
Message-Id: <20200903162154.55694-6-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903162154.55694-1-jonathan.kim@amd.com>
References: <20200903162154.55694-1-jonathan.kim@amd.com>
X-ClientProxiedBy: YTXPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::40) To BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTXPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 3 Sep 2020 16:22:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a213557-c6b2-4d31-64fd-08d850258553
X-MS-TrafficTypeDiagnostic: BN8PR12MB2978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2978246D75CEC2D23D4740C7852C0@BN8PR12MB2978.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLtD3dZsZ2rDeiVcsWlgu3yB/hTBUsB/53UnvynGqFijCnsmS+cf5Fj4r5T5V21TJx2T8xmGStvSvsQs82iwyfbdPXqxiNv984zvheOW7PIdGJTJJ2w1UlA3/I5PJckPyorcYbhLvmSn2xmSXbkCPvJS1ncikA2H6DMtaqOkFxMHpWVnPqZ6yIeY2LPXn7GcwRqFw7ZavnHXMxnUfrkxJKyb8WuGLgfER5ac3JniXqwJ/Jb6+aULo6IA6Sbxx8x4xIfQVleEKqlB112si/8GhI/o0n2UT/k6UkBBw8dBcLUH0nSBpeMQQgqPxUNTlJ3FK2wLsWMpB74FuTpyFQbj+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(316002)(54906003)(2906002)(6486002)(4326008)(16576012)(478600001)(8936002)(6666004)(8676002)(66556008)(52116002)(6916009)(66476007)(5660300002)(86362001)(2616005)(186003)(44832011)(1076003)(66946007)(956004)(36756003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: hTmm8fUxCJfmq4mwvQKMyTfhu5b7lFO8aTWdwvt1EsnY9BFsf9bfFnomiucatbfWcAbWvwwtSOzJ85XQ3DsFQtYXzpsxkvM931DIyRCFF/rDO+MkkqTN/hLCbDbO/OSG4a3qGrCdUxO7oekZrBqHNvlO3KVUJLvpE9OCyf4RXzGf3QtAt1Rb68Z+ZTjT4V4cgnxqy82S/HHV6i/g6zeP1jIBxFfwan2NHb+dhIOoLSJdGHcCv3wKIgheSAd8MuWDHXKn4y55Ntuv7g+j+wbkZ6oBToy5BMBHeMm1C4EA5r+LUyVy6bVnJnYih1JIlTFVqn0XxeQHmc6pA0bQa2PmdWx3A0pd5FhkDxRmI1SioOCkScUTur5/Y04IKS77FhgrvyqXQFx7fWbB97wpkhHEgkyMsOlRnkTUvYLWGkgPQx3lCf8tXTxm0wZZuJbYMNH2KsO15HSttXaSfzR55ls8oHfiNmGW10qSE4fPXDdaxj0oVBaeni1RX4SvqwzS0T7BitsszEhSjqoazf6LqMqxTgircugc8ef6gdg+9fpOFGeodOZ30xNP85hutsoyyw6EDv5i96NarBfUSvqoKtaYmvj32auQM8h+SVrbZTymYYS7ULKSa0WDgGRCsutsmP1RjRntmuu4BSOhvdDU9VxSpw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a213557-c6b2-4d31-64fd-08d850258553
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 16:22:15.6251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrLcJVuM5nz7LPwcrjDsFoPzqJFA5Wjoh4slpyjZpft63XRI2jJwe+oMPDMxEbmP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2978
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <Jonathan.Kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add xgmi perfmons for Arcturus.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 32 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c    |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index eaa44c99d423..420157ee7c25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -32,6 +32,7 @@
 #define NUM_FORMATS_DF_VEGA20	3
 #define NUM_EVENTS_DF_VEGA20	8
 #define NUM_EVENTS_XGMI_VEGA20	2
+#define NUM_EVENTS_XGMI_ARCTURUS	6
 
 /* record to keep track of pmu entry per pmu type per device */
 struct amdgpu_pmu_entry {
@@ -58,6 +59,11 @@ static struct attribute_group xgmi_vega20_event_attr_group = {
 	.attrs = NULL
 };
 
+static struct attribute_group xgmi_arcturus_event_attr_group = {
+	.name = "events",
+	.attrs = NULL
+};
+
 const struct attribute_group *df_vega20_attr_groups[] = {
 	&df_vega20_format_attr_group,
 	&df_vega20_event_attr_group,
@@ -70,6 +76,12 @@ const struct attribute_group *xgmi_vega20_attr_groups[] = {
 	NULL
 };
 
+const struct attribute_group *xgmi_arcturus_attr_groups[] = {
+	&df_vega20_format_attr_group,
+	&xgmi_arcturus_event_attr_group,
+	NULL
+};
+
 static const char *df_vega20_formats[NUM_FORMATS_DF_VEGA20][2] = {
 	{ "event", "config:0-7" },
 	{ "instance", "config:8-15" },
@@ -96,6 +108,15 @@ static const char *xgmi_vega20_events[NUM_EVENTS_XGMI_VEGA20][2] = {
 	{ "xgmi_link1_data_outbound", "event=0x7,instance=0x47,umask=0x2" }
 };
 
+static const char *xgmi_arcturus_events[NUM_EVENTS_XGMI_ARCTURUS][2] = {
+	{ "xgmi_link0_data_outbound", "event=0x7,instance=0x4b,umask=0x2" },
+	{ "xgmi_link1_data_outbound", "event=0x7,instance=0x4c,umask=0x2" },
+	{ "xgmi_link2_data_outbound", "event=0x7,instance=0x4d,umask=0x2" },
+	{ "xgmi_link3_data_outbound", "event=0x7,instance=0x4e,umask=0x2" },
+	{ "xgmi_link4_data_outbound", "event=0x7,instance=0x4f,umask=0x2" },
+	{ "xgmi_link5_data_outbound", "event=0x7,instance=0x50,umask=0x2" }
+};
+
 /* initialize perf counter */
 static int amdgpu_perf_event_init(struct perf_event *event)
 {
@@ -387,6 +408,17 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 
 		/* other pmu types go here*/
 		break;
+	case CHIP_ARCTURUS:
+		/* init xgmi */
+		ret = init_pmu_by_type(adev, xgmi_arcturus_attr_groups,
+					"XGMI", "amdgpu", PERF_TYPE_AMDGPU_XGMI,
+					df_vega20_formats,
+					&df_vega20_format_attr_group,
+					NUM_FORMATS_DF_VEGA20,
+					xgmi_arcturus_events,
+					&xgmi_arcturus_event_attr_group,
+					NUM_EVENTS_XGMI_ARCTURUS);
+		break;
 	default:
 		return 0;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 569c40be6e75..23af431de997 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -512,6 +512,7 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
 		if (is_add)
 			return df_v3_6_pmc_add_cntr(adev, config);
 
@@ -553,6 +554,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
 		ret = df_v3_6_pmc_get_ctrl_settings(adev,
 			config,
 			counter_idx,
@@ -589,6 +591,7 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
 		df_v3_6_pmc_get_read_settings(adev, config, counter_idx,
 						&lo_base_addr, &hi_base_addr);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
