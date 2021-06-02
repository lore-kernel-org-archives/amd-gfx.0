Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEADEC47093
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8285061C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8285061C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E44B86EDB4;
	Wed,  2 Jun 2021 16:50:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FE716EDCF
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJxEhD7WuRFi0ut3/6Jg7iadzTsRwDesbQfGM11GNr0hGssT33N47RNGtYNoYx8HT0IHiVZ5PrcNiVf00SEQpp/VHDd5bU5vm5T9A2vNCddk6ttMZGx+Ozwx3BB3+47BksGZLr20UefuCBcjUB0cg4YtOqRDebUEAjB9dT5QgmrylzZpyFuJfCwXNdr6RoDIrESAIwQHBA8nVP1/wkrMBAyFjBxxRnUgOt5Ekwu0AeoGawckMMd/bl1xdOkJg+ppHvbsNtvCb1JaNfGNDf7Q2163BeHOUJCFz7DNU0YmbfJgNN5hryZO1a+OOxdgedoMz/S2AWSZjYrmteuFE1e93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqJG04Wrc9OhKE8FvKxpSAvXRPKu0NzlcqWUvK7DScA=;
 b=iUxrKcgGTGJSsNuM7LGFKnkA/ILWIZGE8mfQEI2xSAxC71TOgb0nUyGDEnZH4PCvxmsibqBKzkIBU90ICY+e83aB6soJe1Pc/RkBJXUCqMHFXDK3sBdWm+dPtIHYhR0tIBm5pEDV5anOxxn89QTGJJyJ3DNeiFLw7LgLOAbzhaw3eCQxD8Zw7sXb19D0xI8rH1gQbIBpLf/tSznR9Ab3OI7GTrfhouuGWx3gJfbmlv8+LuWZEJ1fi1thuHPrVoohbj0RBwkj0oaLzrTGGeeqq7kgay+CpaHG8uVcAQq+9RKN1FO8DfQUV0PQYjnOMX9pcW7BHw62ZFBlYHTXW2GAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqJG04Wrc9OhKE8FvKxpSAvXRPKu0NzlcqWUvK7DScA=;
 b=BxUWGFrgq96K5rFNmNtHpfd3F6tOEAaD1EBb/6UQFxk4p9H/oFgxlSoIInuNpkJkMnPinLVYDCb86oc6aul2pNmQrl1prb1pduA3iVFnR2I6qE6KtDfCKEp3YKBlbBWrB6dlMps09JecrnQRcAM6T7i3/7FP04hLejGKwNhWjbo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Wed, 2 Jun
 2021 16:50:34 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:34 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 50/89] drm/amd/pm: add set_watermarks_table function for
 yellow carp
Date: Wed,  2 Jun 2021 12:48:29 -0400
Message-Id: <20210602164908.2848791-50-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52f85900-4ce5-45f1-0253-08d925e67794
X-MS-TrafficTypeDiagnostic: MN2PR12MB4487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4487AA6E4E1E6C656549D182F73D9@MN2PR12MB4487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WdfzxHGJvox5/aney5XIeVHS/h0t0r10TLbROdnxnNZhGbXuFXASWWM7SbUO0gwH7S+Ahvptz1348YyCNdj/JlcmvT7uIT1c8OZK764BNIKQaMa2m7kQP8/jsgVfEs50rLZtnCxqLy+wkWJyAijOxk4d/f6IOD0kc9hzSM3Y761XlPOQgnpSohtoTJ6qJT0cjXf3TO7QDFkZbrzZuR74e1eZdTJ7DZkIOSuM9OE0//P9GZeMA0iJD98GIwFVUKm6FqEfHG1OimJqFgbWO9O7q/3SLSoI1huJFF9eQB+rjGNm7XlajDmQ+q7sYF4EKOrRVFpkwMVdhr3sa6ebOnjHoCds0N8CN1G6zuOwPNetkJEEstcl6BrALyLZj8NES7auH4AjZ9SYlVcCCG8rTphVeves50NAofz+BdMMtpnqv9UNilpR27955dVtsrElEpm53Aq1RsI0jguXlJfPvZXPCsjKzLUN/nJLvrOMjL1BgJfKOutnSVjRFKiNx3wYqQPcdrqKVGMDaK6PySvyRWh6Uea7Vc76AeKubDI2aCDwWaM6bEXLGxb356pV2vz5ojz7VuIHlwg7b4Ut0dzzmaGEZpMS1sFO/G2VFagfDLxKfT7P9mh3D/TXTtssn2IRS0OLbVpz14L7TsQ8Hff+5f7xxSwjvu4bgJf4BZduRJ0USY/orGTEUUROVzpwglplTa00
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(86362001)(54906003)(1076003)(8676002)(478600001)(6916009)(6506007)(2906002)(38350700002)(8936002)(316002)(6666004)(36756003)(66476007)(52116002)(16526019)(186003)(26005)(83380400001)(5660300002)(6512007)(6486002)(4326008)(956004)(2616005)(66556008)(38100700002)(66946007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fGXE0VuMT5yxaRukJNFN7ghU7OpPXJiZdliSXRpxi9qdLkxQnLGRScV6yaWW?=
 =?us-ascii?Q?97QoITXYtcSsdg1wLy7mKGyHfhVrnkRBBOO67/h8Xt0hKVMAvy/tJGhn2tCr?=
 =?us-ascii?Q?QYEpbEGFpXf0KwwQ9511bJH6yUO9Ji69tDCSmcbwkqLdPfcVd78Fk0rUE7i0?=
 =?us-ascii?Q?TC01FYNxM2odToFn7+NtiknO4Y47c03gq4nZg532iRc5L/WibxW+6omxrKYd?=
 =?us-ascii?Q?OBn4WRWFhdMOCkOR3w30gn0pX5yOWBn64iD/2oT0yWLzeJAzSwQHTtjvct+H?=
 =?us-ascii?Q?KgkUQZ+3P3rOa/14Ss9fBXCquFz0D/qyU6C+wLpPcJdKc0Yq2AWZZcGNDEeV?=
 =?us-ascii?Q?+N1i9Vo4L2UzDXoyVKg5LU36bdQkt+F5Xd40V7A5PLRlseqZ7s8dYyy2LrQv?=
 =?us-ascii?Q?qU9hL2/XNo5sOPhP6bp6qfQKiuae1OhoBRlO3WpQZPf9p+jp+EicnD1E0OXY?=
 =?us-ascii?Q?Ir0nhvDGhONSUZnv/jMYGOJsIJZpJT0ZTU/n+gOADvv3rc7T9ZRU5QZXmA9R?=
 =?us-ascii?Q?Z10q1bMm7He82Ka/6eQKgRm/gCezyQiAqgJ/I/xj9Qz2aiuuhaOfk1UvFYdq?=
 =?us-ascii?Q?RrRVgmO6y5EGcZ4h9GnUl4fHhDOLSbufRRx4QZSdt2+d11NXdx6Ro6K+eqSG?=
 =?us-ascii?Q?SgwP7tdLLa/Khv8n/HJ+RSlF/8of+83eiZY0TTbiHDqYojurx6cuDQApa7vg?=
 =?us-ascii?Q?gsjV8821Pv5UqZeBUmc7bLZVCPvvlALWNHlldInhr7Ip6stayGiV5qSKSDy7?=
 =?us-ascii?Q?D6lpq9nk5Jd9KfZ5nIj+7moCKk2uRZv7gEFd9Ji4UAne20tvCcTzA7ucpA0k?=
 =?us-ascii?Q?wOaNSKSiQHYtFUKKAVJlwQIrFbCOFvlTDYS8jwHeMDodmgiD5ADmDChXJbVF?=
 =?us-ascii?Q?mWPbZVgzfMCSlqF7D56tVDrK1updAKL8/rVIXfMR3p8xxAnCBywHPc9hY/DC?=
 =?us-ascii?Q?bzp/Yikhs/C0TfCvT2wvaykKUhYwYLwDPRC7Uf2RsiioKnm5oSAdh1jpgyGW?=
 =?us-ascii?Q?4WQbq+PFvODQuYEYJIW1JIs5v9f+8qaZoWU4Bcqsp70iSQhtaWi5tkD8bGUt?=
 =?us-ascii?Q?dz+8pomI3QasE2OwfUlPlKjhWNtklqSBA8WlvvGkHent6q4f25I4RK98RxNf?=
 =?us-ascii?Q?+JsGaAPaWUKMOof7d/cQXdWypVTuoXlwaVFL7GuWOUlyKLe+Y098Oid0bKDj?=
 =?us-ascii?Q?Sq0+iCQ3ikSUDKzle9GUtvYh1Z+S2sjR4t1NTyBga2G7RBpGnS8DR7Wmnr3p?=
 =?us-ascii?Q?MT9U6b5kI8B+rmMFDrUgITmUnUwi/h7wO25gktEtJ4sUyRCm79uC710Qy4xX?=
 =?us-ascii?Q?716Xn2gyweYw/y1tXFBnAQ+E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f85900-4ce5-45f1-0253-08d925e67794
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:03.0103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uzL9yfkhjW9Rg8H/s2J/FrU/mVlWmS6d1o/x/4MG2/zayAJFfmKKwgEzAiaVYLC7+ZUfj9qQdFQ2uwEkfeMdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

Add callback function set_watermarks_table for yellow carp.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 373abe8376c9..71ebdaba029f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -322,6 +322,66 @@ static int yellow_carp_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
+static int yellow_carp_set_watermarks_table(struct smu_context *smu,
+				struct pp_smu_wm_range_sets *clock_ranges)
+{
+	int i;
+	int ret = 0;
+	Watermarks_t *table = smu->smu_table.watermarks_table;
+
+	if (!table || !clock_ranges)
+		return -EINVAL;
+
+	if (clock_ranges) {
+		if (clock_ranges->num_reader_wm_sets > NUM_WM_RANGES ||
+			clock_ranges->num_writer_wm_sets > NUM_WM_RANGES)
+			return -EINVAL;
+
+		for (i = 0; i < clock_ranges->num_reader_wm_sets; i++) {
+			table->WatermarkRow[WM_DCFCLK][i].MinClock =
+				clock_ranges->reader_wm_sets[i].min_drain_clk_mhz;
+			table->WatermarkRow[WM_DCFCLK][i].MaxClock =
+				clock_ranges->reader_wm_sets[i].max_drain_clk_mhz;
+			table->WatermarkRow[WM_DCFCLK][i].MinMclk =
+				clock_ranges->reader_wm_sets[i].min_fill_clk_mhz;
+			table->WatermarkRow[WM_DCFCLK][i].MaxMclk =
+				clock_ranges->reader_wm_sets[i].max_fill_clk_mhz;
+
+			table->WatermarkRow[WM_DCFCLK][i].WmSetting =
+				clock_ranges->reader_wm_sets[i].wm_inst;
+		}
+
+		for (i = 0; i < clock_ranges->num_writer_wm_sets; i++) {
+			table->WatermarkRow[WM_SOCCLK][i].MinClock =
+				clock_ranges->writer_wm_sets[i].min_fill_clk_mhz;
+			table->WatermarkRow[WM_SOCCLK][i].MaxClock =
+				clock_ranges->writer_wm_sets[i].max_fill_clk_mhz;
+			table->WatermarkRow[WM_SOCCLK][i].MinMclk =
+				clock_ranges->writer_wm_sets[i].min_drain_clk_mhz;
+			table->WatermarkRow[WM_SOCCLK][i].MaxMclk =
+				clock_ranges->writer_wm_sets[i].max_drain_clk_mhz;
+
+			table->WatermarkRow[WM_SOCCLK][i].WmSetting =
+				clock_ranges->writer_wm_sets[i].wm_inst;
+		}
+
+		smu->watermarks_bitmap |= WATERMARKS_EXIST;
+	}
+
+	/* pass data to smu controller */
+	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
+	     !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+		ret = smu_cmn_write_watermarks_table(smu);
+		if (ret) {
+			dev_err(smu->adev->dev, "Failed to update WMTABLE!");
+			return ret;
+		}
+		smu->watermarks_bitmap |= WATERMARKS_LOADED;
+	}
+
+	return 0;
+}
+
 static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.check_fw_status = smu_v13_0_1_check_fw_status,
 	.check_fw_version = smu_v13_0_1_check_fw_version,
@@ -334,6 +394,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.set_default_dpm_table = smu_v13_0_1_set_default_dpm_tables,
 	.read_sensor = yellow_carp_read_sensor,
 	.is_dpm_running = yellow_carp_is_dpm_running,
+	.set_watermarks_table = yellow_carp_set_watermarks_table,
 	.get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v13_0_1_set_driver_table_location,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
