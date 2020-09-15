Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ADAC433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 22:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CBC02064B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 22:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PA7My947"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBC02064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0F36E245;
	Tue, 15 Sep 2020 22:00:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCD4D6E226
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 22:00:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKacvfQV3DapR/8C3ZnFAL0BZoEt6n3tKxE2aOVKSzydx1gQoAYqr0gvbFP6bs87x7DFwxxTvxDILEhu6Fl36pEd4SoKTsRFyA8EAMfEVN/7xnEXLZHjVBHHiwr3obhZYJPgyk4Ff1d8JDNLhJWptxb+eGfBU3e1NoYSyn3bmAgGLFZYaIy6+1lvBNxK0ul5tvOcZ/+4A3qG8gS1AMBHdY+8tng1JudXh1bMuiIAzvajPDr+e1h/2yD/4rUxXHecoLfQvGTU4Igqb3EYj/e3UPwGePy/8j0UFIoLdhxv0fifsq8b3ogQeLpahuPSbVYBX1tnGStmlliL2AXfiYDTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFcxkrz2TrhdPoegGjg3EqnVwdBA7H7UVpAoHXCCl5o=;
 b=WEf5b6Pg6RewAhzTgBboiCuIA2q5GBDE8g0CdIm51hzLPr/UhrLnv+vEp88lAfAAUtB71200HYyJ+681+glU/Vf381YA971ti/SR7EcAllQtea2vxmL4a8Vz8CxaoT9Tiv3dk4Wn5v+tf//FXRwxcQDKrCOyxqvP5vDK6FqMZRFmk1ZCGEV7CKv1thwkfRoraS0ZRsFo4Hp7uJ9I/t7ehtqigrzljJHL1/NbwqZkThRBQgnn1bu5EeVs82xliyeWf9a2ljfnXGVButkB7lCXBjIcWCMVF7ZiMR6HOnQNxK/QDiHuzu4PF3ch4jtv17fhXrjaXlxj5zusgiBRGEA5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFcxkrz2TrhdPoegGjg3EqnVwdBA7H7UVpAoHXCCl5o=;
 b=PA7My947xpzSM8I0G5ZRLqQv4vurt32fu8QNkBqjIDvTj6m5yL8gBj0KGXjA8791mjwT8nbUXCSLpJFN/ho/S4ZNCgCB3RtM//epo1rZ+slX5CL1jQPM65xVZSs9g1tuw6NF9MvecYghH3Vw0li9z3VpWtxvIbX5LMMSfDlEZB4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN6PR12MB1188.namprd12.prod.outlook.com
 (2603:10b6:404:19::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 22:00:35 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 22:00:35 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: add xgmi perfmons for arcturus
Date: Tue, 15 Sep 2020 18:00:15 -0400
Message-Id: <20200915220015.2646-3-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915220015.2646-1-jonathan.kim@amd.com>
References: <20200915220015.2646-1-jonathan.kim@amd.com>
X-ClientProxiedBy: CH2PR12CA0003.namprd12.prod.outlook.com
 (2603:10b6:610:57::13) To BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 CH2PR12CA0003.namprd12.prod.outlook.com (2603:10b6:610:57::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Tue, 15 Sep 2020 22:00:35 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b23c7875-e5cf-4141-0d34-08d859c2c629
X-MS-TrafficTypeDiagnostic: BN6PR12MB1188:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1188E392ABBEF8560C43972F85200@BN6PR12MB1188.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZV+oWnC014EABkby5pn5PTOQ/7Q8m2Kyq4f0DQ3+GtKRhp2ky2XFa1/KKOPOk9h1u5gFIgNwNmjbFWZbZ/A1daH46Dtkz6pqF2S/RQ/owt0EZ2OxO/8vXtFeovww4CUytQD4lsEm15IenLPDSn14F61bO62wW7d+3BgecVw5v4oiOsl4oYkcR//4+hWjCAjeBBElXgCmNB0H1hZgAq7ZYvDwCpA2GrCc1gXgfMkCZZZfT6ZIipYjf1xZvzvoWj6ItOs2YDsFwTm7NWH1y1bbCzHmjPlUck+gSreDTGFFi2hSficbdHDRRQnLDgc7+/tMhO+N6wb3pmG4hl1eXyRIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(54906003)(7696005)(316002)(66946007)(8936002)(66476007)(66556008)(478600001)(6666004)(86362001)(5660300002)(36756003)(2906002)(8676002)(1076003)(956004)(4326008)(6486002)(2616005)(44832011)(52116002)(16526019)(186003)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jhfvhtDSVWftC05m29ltae3fd3V3YEh/T1d+g65yQ3vD5e4IweiJBn07CQej6i2wl1y46fpmlSo2MXdiUOzcYkOlXCKft5UqqaIP+D2ov9v+HGQGICX4RTn2DGDarbVvURQHgm9Andf+YalM6HJO+d31txB6rSqX36MTrk7+wU6qogmjNe/dFsGn0vlJd1/Q5AAFm3G0UejQPx8js0U2J8qvWMhCa90WE8NTYtyp+u6DqZ1X1ITD1NYa8v2qrqWmr27uv9bI2rAmtqZPemvF5Gsgv41Y4OJDsi9QvP7q45S064zR8rK9r7bTJRBvM0XtWW3zzET7k4ou2dGmm8QEUKHAAbsH5lbwatpRBVS7RSgoW55VTeE/V/n25GizsMX5BsG3oqxK1g02Cz9cajqF+b0nzXaEz6idD7/RyH2z6ExRLt84+xO9nMCQbf7YR7oxFUS18dKmH9CLkIHJgObZUn9xtl1Us1Gl/kuiW1nrkkg5neBJPGUvN9TF03DuGebWzdU1qW71F2oKT7Zovujs85EGVuKGWcK4USbT6A09ZRsBKlLYH2eURO97jj1+65Pnwb8d0fzYgE4h4YowiQtf+9ragZroZSvGBbMqIFM2btH1nj/MOg6qVA06786sDdd8JBcNAoF1QNMbL4juUUYJBA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23c7875-e5cf-4141-0d34-08d859c2c629
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 22:00:35.8250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jX1L8ivd2Yy86aKn+fxX3Tly2O3tQzdIu5GdiliOKXCl9RefmmCo/6bXP6PKIR7g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1188
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
Cc: Jonathan Kim <Jonathan.Kim@amd.com>, Harish.Kasiviswanathan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add xgmi perfmons for Arcturus.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 55 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c    |  3 ++
 2 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index f3d2ac0e88a7..ec521c72e631 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -34,6 +34,8 @@
 #define NUM_EVENTS_DF_LEGACY		8
 #define NUM_EVENTS_VEGA20_XGMI		2
 #define NUM_EVENTS_VEGA20_MAX		2
+#define NUM_EVENTS_ARCTURUS_XGMI	6
+#define NUM_EVENTS_ARCTURUS_MAX		6
 
 /* record to keep track of pmu entry per pmu type per device */
 struct amdgpu_pmu_entry {
@@ -110,6 +112,27 @@ const struct attribute_group *vega20_attr_groups[] = {
 	NULL
 };
 
+/* Arcturus events */
+static const char *arcturus_events[NUM_EVENTS_ARCTURUS_MAX][2] = {
+	{ "xgmi_link0_data_outbound", "event=0x7,instance=0x4b,umask=0x2" },
+	{ "xgmi_link1_data_outbound", "event=0x7,instance=0x4c,umask=0x2" },
+	{ "xgmi_link2_data_outbound", "event=0x7,instance=0x4d,umask=0x2" },
+	{ "xgmi_link3_data_outbound", "event=0x7,instance=0x4e,umask=0x2" },
+	{ "xgmi_link4_data_outbound", "event=0x7,instance=0x4f,umask=0x2" },
+	{ "xgmi_link5_data_outbound", "event=0x7,instance=0x50,umask=0x2" }
+};
+
+static struct attribute_group arcturus_event_attr_group = {
+	.name = "events",
+	.attrs = NULL
+};
+
+const struct attribute_group *arcturus_attr_groups[] = {
+	&amdgpu_pmu_format_attr_group,
+	&arcturus_event_attr_group,
+	NULL
+};
+
 /* All df_vega20_* items are DEPRECATED. Use vega20_ items above instead. */
 static const char *df_vega20_formats[NUM_FORMATS_DF_LEGACY][2] = {
 	{ "event", "config:0-7" },
@@ -400,6 +423,16 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
 
 		pmu_entry->pmu.attr_groups = vega20_attr_groups;
 		break;
+	case CHIP_ARCTURUS:
+		amdgpu_pmu_create_attributes(evt_attr_group, evt_attr,
+				arcturus_events, 0, NUM_EVENTS_ARCTURUS_XGMI,
+				PERF_TYPE_AMDGPU_XGMI);
+		num_events += NUM_EVENTS_ARCTURUS_XGMI;
+
+		/* other events can be added here */
+
+		pmu_entry->pmu.attr_groups = arcturus_attr_groups;
+		break;
 	default:
 		return -ENODEV;
 	};
@@ -530,6 +563,28 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 			goto err_pmu;
 		}
 
+		break;
+	case CHIP_ARCTURUS:
+		ret = amdgpu_pmu_alloc_pmu_attrs(&amdgpu_pmu_format_attr_group,
+						&fmt_attr,
+						NUM_FORMATS_AMDGPU_PMU,
+						&arcturus_event_attr_group,
+						&evt_attr,
+						NUM_EVENTS_ARCTURUS_MAX);
+
+		if (ret)
+			goto err_alloc;
+
+		ret = init_pmu_by_type(adev,
+				&amdgpu_pmu_format_attr_group, fmt_attr,
+				&arcturus_event_attr_group, evt_attr,
+				"Event", "amdgpu", PERF_TYPE_AMDGPU_MAX);
+
+		if (ret) {
+			kfree(arcturus_event_attr_group.attrs);
+			goto err_pmu;
+		}
+
 		break;
 	default:
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 6e57ae95f997..6b4b30a8dce5 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -513,6 +513,7 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
 		if (is_add)
 			return df_v3_6_pmc_add_cntr(adev, config);
 
@@ -554,6 +555,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
 		ret = df_v3_6_pmc_get_ctrl_settings(adev,
 			config,
 			counter_idx,
@@ -590,6 +592,7 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 
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
