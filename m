Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80618C07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5462C610CC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5462C610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B306E439;
	Tue, 20 Jul 2021 15:44:23 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 124116E439
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMtEV2jPfgoHTGEywyLWWBhfXlT0WZ//WV3MfNeIPJcBWmsI/CcrpVo6hI00bUFyx5SlgHk97N5RkQk0mg7IazQ/oPZuKRhAtsd2sozaA8vr0wD1GAOXUzBnpPO5Rl2aYbTVxJC8ZP5ZWlPLuSGn3PU3/UJ7EnJIu7z40oHDFESVV+MWG1UAEkA8bk0CVaQKu0bAcZgZbueJsyiEnpFpgb/6oroBfgErztgvlftrq8/4ReUxM+x44ER/HdmXZwA8L3PF6g+B7FgcIqpWw7K4Hn0Jb/58RRbCuG426020Emi9lvzFhAr1B1VQ55JUY9K8b233tMVR8IMQew3UUxSxgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw3mgBAyqoYvb8t7LpgexDT5i4HyQ2ZyabDjtdr/phA=;
 b=KYb9KDImrwMth6t/AokFuNb34HaWxkVloXuoHyASkH3fLT2sUCm9RkVhvjeyBua3u78OhosIGQrd74b+DjjwUVjq7gSgQvxDhIZ2zprEkL/LNgGQ/KPMj6LyTo1z+bxURfp4Eh94LXEQtixP79bfvkTHWCbjX7GNfc6Vi1Vdl6dqwPZrhFJKE2rFhBXzOwR9rfq8mhzh58BhyGROphD7gX43pEye04jiYUEDyGWh19aQof0ARfs0ZjoloKnv9YYJcdR1Rw2iVwkqueBEaZVqPaA2zIb9uNLiuo7SE/OAhLiWDbJjRiJvtDvzOzKYWJT1B43ClaAVWLrkRN7KQpSlSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw3mgBAyqoYvb8t7LpgexDT5i4HyQ2ZyabDjtdr/phA=;
 b=X0aGZ+1/x3OgAGMahfPcJfM+5nGmq1ke+rMNm/rGJYk8MTk8AAV+j2ib/VrPXpRvHQuZGgvp0kObkevCKCTcya6d1rSRyjSbPxARjA830PyGeirnpn/AbppUJKgimxYc8oEzfUUNo573jzMjpII+PJWzPAX/+5e/ou7tXFpSNtA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 20 Jul
 2021 15:44:19 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:19 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/29] drm/amdgpu: add mp 11.0.8 header for cyan_skillfish
Date: Tue, 20 Jul 2021 11:43:37 -0400
Message-Id: <20210720154349.1599827-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54c79229-9cd9-41f7-fbaa-08d94b953ca9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5349E0378AAB96D5638EAAEBF7E29@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmsNGFLHZEccK4BrGgkWN8RXGdNf8rlfZdU5mVDMWQtxIXgmGC+OVFn4LmhZs8m1gFsoPD4ZbSudV31RweQRxHTvsuv0Oi03C9LtaAPdJGwXny4f3pZOZCG363hGEoG0hACjD0zYqu+MNfXIE3Xh9oS7BFqy+rULPGAUNd8qB0vSKRDLwX9heBs5jwIfnSCMfRUfDwA8MDEmbevblJFNuZV/9TX0mpdgTBosuT+vGvXodYWJLFczVQWDYC3tlLeWcPqNtBzc65ygbC++xuUTYOE6Q9ZTyTVFcMQIHUcuUyoDsfiVYSH6Z4wD3KmJVUhw1gP7TrNzW7qBlqxNF93D5w9oYYOE+t3FWMBo6FQnS94ighdJ/Tp8VVrX2O8NUnor/GQC55wCJ2+yKRccUMsEn8fkF5QuMUfuLw3UtZ/fZyW96a/qWFws76LAdZVI42btDyQEoHt2x2J4k2TmD6+m4EvcC7qiZy+1CICQ4K4A8l5zY7YpLAKZcDF+pxl31CDmdLN9ihHHd/9t+lCH2HBj+KzlPEycYWvtbAuj9wPqrNZbDnhYz6uBWKdE0HrOIMooDYeIzsLRZGEDKJcCU89B1ystYQ5vjgD711rgKwhTiao+FqoHPf+hXScOCNU8IrbA0t54fdF9oH96jR6YO/Y+YmlBG66YLo0afjGVIrzLFbIbsgIMMbdD/rMmSRw6c2/gJ5W2P3e2KczLGloFlABhGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(2616005)(86362001)(6916009)(38100700002)(6486002)(83380400001)(54906003)(6666004)(956004)(30864003)(478600001)(316002)(1076003)(4326008)(52116002)(2906002)(66946007)(38350700002)(66476007)(5660300002)(8936002)(36756003)(7696005)(66556008)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FTPy2huGEOdRioXyC+FrxMAYiQqWBgW3hcgAgWwbpcgWW724pNbHpr3G+he9?=
 =?us-ascii?Q?i/Avy0HGlcB0hxC3q7A4IpNW0FklNLcdyWGCw5C7FHPjgWXabP9dX57JAuBZ?=
 =?us-ascii?Q?HH+b8kLXJIvBG7RamYNeb4kub1ba/Qh0BeuXwiMSUUiFnHX/5oIqmuIlLLYe?=
 =?us-ascii?Q?f5sZC5ab9Zm1ICvapLapvCs0tt8ZASskFPRG/hApgHfP+Yiz1eTxmY2CBUvI?=
 =?us-ascii?Q?tzsE4dF1h7v8U+Gdgg6Af7IFYaylmt2XxxhprC+5RUBVhM6BM5E3Yfc+Rluw?=
 =?us-ascii?Q?eHB9SN0qwSZdmUSPfGEgGDCvgiAd7EEYvSx/21ez/BSYrcK8gVuwGcouKjnU?=
 =?us-ascii?Q?ubjusLxVoOd2vBnaax17HQVS2vmBe0L+LqYM1Eu0BGhM9lwKzqHdbFS3wpie?=
 =?us-ascii?Q?JDtzV6DjM8HUrGtdOO/mgzWq3kYZjA0xcewYkibjdtCX/KWwX+jTBZOP/FMQ?=
 =?us-ascii?Q?IzijsZbHaHR9HDaAIyZBoauiQmI3/vn32lGx3rZvYDHfTszSJsl+VIwDvjcO?=
 =?us-ascii?Q?zYD4V7peLqGMBUXuSw7/bekkXaQ/x0wJwtTR3Aqm4mgzGGNZVF2y1/wHirvq?=
 =?us-ascii?Q?N5FerET29psmYl1W3Iy4BFhQLZa6xhWv/Lvg7Ppev8aMCK8lrSjBXzmJWDJv?=
 =?us-ascii?Q?UBfNrC9k8VaubEeoKa3uA3LKc7N8q8VRdaQvQByPYjKhx1GR/qeYWItcZylN?=
 =?us-ascii?Q?XJxdpOzNkFTUkYaAXMklzgEPWW3DMRqIl3JhZdnE5fpZLW4UbVezC26K5kAt?=
 =?us-ascii?Q?GLze1NgxVNXdBlX19U94vMNbui9gdA6Wcirukb8BDsJit4hINBCHbt7IgIci?=
 =?us-ascii?Q?mRCfkzKXbGd2t/GUZzR7LW49JB7NmDgXWCxUVCeYUH8B5r0/gE5tOu076qSK?=
 =?us-ascii?Q?Og0xNiLZewdlt7LGqtR4UNXM/NzFXNhrMSQQeTFX2laZ0GGbF8neEdWQj+tr?=
 =?us-ascii?Q?EnZ3PaX4z4qP12iCDcdmoAxGXU19H8eiDerlUOEcip0fW1F/HSJakCVp/jO+?=
 =?us-ascii?Q?tDIhH3I3f9mKaMmeSV5fGK3OC81bhIxN7bD4xm3rGgXA6Xv8eMba3Tahr5Uw?=
 =?us-ascii?Q?C2Rh/+birWMSUajwQM0id7QtKXuWUS64cDInedL00E3DiEWL7AgGQwCKqXJK?=
 =?us-ascii?Q?dfXiFBMsIN1y79MBo8cIY2AOV9lSw6vmgoxggc3dzTWSIBk+pGoNq0y6lTfr?=
 =?us-ascii?Q?8Go67Lky+BzCkZq+wKIVt3DGVN9IKtUt6abYOwd8XJ0TmX7fWaBQhB+q7TPu?=
 =?us-ascii?Q?VG0NjZzyb/8VBVwEgx2CAv/e4OceTq7vms1omBDHiNZMa+UkHVqHSCYXiYu5?=
 =?us-ascii?Q?Ye2VBT/ptv52iJpBg7Vmeuwm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c79229-9cd9-41f7-fbaa-08d94b953ca9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:19.3442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfQR1M2so1SFxW3yzcOa3ay1BZ5w6Vi1pHZu/E/fBtnN4QDqCCkNMTPgzYA3r1B7XU+m7w7Jb+MBfCREZEboIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <lang.yu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <lang.yu@amd.com>

The cyan_skillfish will use the mp 11.0.8.

Signed-off-by: Lang Yu <lang.yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/asic_reg/mp/mp_11_0_8_offset.h    | 352 ++++++++++++++++++
 1 file changed, 352 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_8_offset.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_8_offset.h b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_8_offset.h
new file mode 100644
index 000000000000..19293ccaec23
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_0_8_offset.h
@@ -0,0 +1,352 @@
+/*
+ * Copyright (C) 2021  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef _mp_11_0_8_OFFSET_HEADER
+#define _mp_11_0_8_OFFSET_HEADER
+
+
+
+// addressBlock: mp_SmuMp0_SmnDec
+// base address: 0x0
+#define mmMP0_SMN_C2PMSG_32                                                                            0x0060
+#define mmMP0_SMN_C2PMSG_32_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_33                                                                            0x0061
+#define mmMP0_SMN_C2PMSG_33_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_34                                                                            0x0062
+#define mmMP0_SMN_C2PMSG_34_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_35                                                                            0x0063
+#define mmMP0_SMN_C2PMSG_35_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_36                                                                            0x0064
+#define mmMP0_SMN_C2PMSG_36_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_37                                                                            0x0065
+#define mmMP0_SMN_C2PMSG_37_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_38                                                                            0x0066
+#define mmMP0_SMN_C2PMSG_38_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_39                                                                            0x0067
+#define mmMP0_SMN_C2PMSG_39_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_40                                                                            0x0068
+#define mmMP0_SMN_C2PMSG_40_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_41                                                                            0x0069
+#define mmMP0_SMN_C2PMSG_41_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_42                                                                            0x006a
+#define mmMP0_SMN_C2PMSG_42_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_43                                                                            0x006b
+#define mmMP0_SMN_C2PMSG_43_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_44                                                                            0x006c
+#define mmMP0_SMN_C2PMSG_44_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_45                                                                            0x006d
+#define mmMP0_SMN_C2PMSG_45_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_46                                                                            0x006e
+#define mmMP0_SMN_C2PMSG_46_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_47                                                                            0x006f
+#define mmMP0_SMN_C2PMSG_47_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_48                                                                            0x0070
+#define mmMP0_SMN_C2PMSG_48_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_49                                                                            0x0071
+#define mmMP0_SMN_C2PMSG_49_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_50                                                                            0x0072
+#define mmMP0_SMN_C2PMSG_50_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_51                                                                            0x0073
+#define mmMP0_SMN_C2PMSG_51_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_52                                                                            0x0074
+#define mmMP0_SMN_C2PMSG_52_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_53                                                                            0x0075
+#define mmMP0_SMN_C2PMSG_53_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_54                                                                            0x0076
+#define mmMP0_SMN_C2PMSG_54_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_55                                                                            0x0077
+#define mmMP0_SMN_C2PMSG_55_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_56                                                                            0x0078
+#define mmMP0_SMN_C2PMSG_56_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_57                                                                            0x0079
+#define mmMP0_SMN_C2PMSG_57_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_58                                                                            0x007a
+#define mmMP0_SMN_C2PMSG_58_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_59                                                                            0x007b
+#define mmMP0_SMN_C2PMSG_59_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_60                                                                            0x007c
+#define mmMP0_SMN_C2PMSG_60_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_61                                                                            0x007d
+#define mmMP0_SMN_C2PMSG_61_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_62                                                                            0x007e
+#define mmMP0_SMN_C2PMSG_62_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_63                                                                            0x007f
+#define mmMP0_SMN_C2PMSG_63_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_64                                                                            0x0080
+#define mmMP0_SMN_C2PMSG_64_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_65                                                                            0x0081
+#define mmMP0_SMN_C2PMSG_65_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_66                                                                            0x0082
+#define mmMP0_SMN_C2PMSG_66_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_67                                                                            0x0083
+#define mmMP0_SMN_C2PMSG_67_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_68                                                                            0x0084
+#define mmMP0_SMN_C2PMSG_68_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_69                                                                            0x0085
+#define mmMP0_SMN_C2PMSG_69_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_70                                                                            0x0086
+#define mmMP0_SMN_C2PMSG_70_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_71                                                                            0x0087
+#define mmMP0_SMN_C2PMSG_71_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_72                                                                            0x0088
+#define mmMP0_SMN_C2PMSG_72_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_73                                                                            0x0089
+#define mmMP0_SMN_C2PMSG_73_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_74                                                                            0x008a
+#define mmMP0_SMN_C2PMSG_74_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_75                                                                            0x008b
+#define mmMP0_SMN_C2PMSG_75_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_76                                                                            0x008c
+#define mmMP0_SMN_C2PMSG_76_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_77                                                                            0x008d
+#define mmMP0_SMN_C2PMSG_77_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_78                                                                            0x008e
+#define mmMP0_SMN_C2PMSG_78_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_79                                                                            0x008f
+#define mmMP0_SMN_C2PMSG_79_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_80                                                                            0x0090
+#define mmMP0_SMN_C2PMSG_80_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_81                                                                            0x0091
+#define mmMP0_SMN_C2PMSG_81_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_82                                                                            0x0092
+#define mmMP0_SMN_C2PMSG_82_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_83                                                                            0x0093
+#define mmMP0_SMN_C2PMSG_83_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_84                                                                            0x0094
+#define mmMP0_SMN_C2PMSG_84_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_85                                                                            0x0095
+#define mmMP0_SMN_C2PMSG_85_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_86                                                                            0x0096
+#define mmMP0_SMN_C2PMSG_86_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_87                                                                            0x0097
+#define mmMP0_SMN_C2PMSG_87_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_88                                                                            0x0098
+#define mmMP0_SMN_C2PMSG_88_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_89                                                                            0x0099
+#define mmMP0_SMN_C2PMSG_89_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_90                                                                            0x009a
+#define mmMP0_SMN_C2PMSG_90_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_91                                                                            0x009b
+#define mmMP0_SMN_C2PMSG_91_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_92                                                                            0x009c
+#define mmMP0_SMN_C2PMSG_92_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_93                                                                            0x009d
+#define mmMP0_SMN_C2PMSG_93_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_94                                                                            0x009e
+#define mmMP0_SMN_C2PMSG_94_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_95                                                                            0x009f
+#define mmMP0_SMN_C2PMSG_95_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_96                                                                            0x00a0
+#define mmMP0_SMN_C2PMSG_96_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_97                                                                            0x00a1
+#define mmMP0_SMN_C2PMSG_97_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_98                                                                            0x00a2
+#define mmMP0_SMN_C2PMSG_98_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_99                                                                            0x00a3
+#define mmMP0_SMN_C2PMSG_99_BASE_IDX                                                                   0
+#define mmMP0_SMN_C2PMSG_100                                                                           0x00a4
+#define mmMP0_SMN_C2PMSG_100_BASE_IDX                                                                  0
+#define mmMP0_SMN_C2PMSG_101                                                                           0x00a5
+#define mmMP0_SMN_C2PMSG_101_BASE_IDX                                                                  0
+#define mmMP0_SMN_C2PMSG_102                                                                           0x00a6
+#define mmMP0_SMN_C2PMSG_102_BASE_IDX                                                                  0
+#define mmMP0_SMN_C2PMSG_103                                                                           0x00a7
+#define mmMP0_SMN_C2PMSG_103_BASE_IDX                                                                  0
+#define mmMP0_SMN_IH_CREDIT                                                                            0x00c1
+#define mmMP0_SMN_IH_CREDIT_BASE_IDX                                                                   0
+#define mmMP0_SMN_IH_SW_INT                                                                            0x00c2
+#define mmMP0_SMN_IH_SW_INT_BASE_IDX                                                                   0
+#define mmMP0_SMN_IH_SW_INT_CTRL                                                                       0x00c3
+#define mmMP0_SMN_IH_SW_INT_CTRL_BASE_IDX                                                              0
+
+
+// addressBlock: mp_SmuMp1_SmnDec
+// base address: 0x0
+#define mmMP1_SMN_C2PMSG_32                                                                            0x0260
+#define mmMP1_SMN_C2PMSG_32_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_33                                                                            0x0261
+#define mmMP1_SMN_C2PMSG_33_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_34                                                                            0x0262
+#define mmMP1_SMN_C2PMSG_34_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_35                                                                            0x0263
+#define mmMP1_SMN_C2PMSG_35_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_36                                                                            0x0264
+#define mmMP1_SMN_C2PMSG_36_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_37                                                                            0x0265
+#define mmMP1_SMN_C2PMSG_37_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_38                                                                            0x0266
+#define mmMP1_SMN_C2PMSG_38_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_39                                                                            0x0267
+#define mmMP1_SMN_C2PMSG_39_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_40                                                                            0x0268
+#define mmMP1_SMN_C2PMSG_40_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_41                                                                            0x0269
+#define mmMP1_SMN_C2PMSG_41_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_42                                                                            0x026a
+#define mmMP1_SMN_C2PMSG_42_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_43                                                                            0x026b
+#define mmMP1_SMN_C2PMSG_43_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_44                                                                            0x026c
+#define mmMP1_SMN_C2PMSG_44_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_45                                                                            0x026d
+#define mmMP1_SMN_C2PMSG_45_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_46                                                                            0x026e
+#define mmMP1_SMN_C2PMSG_46_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_47                                                                            0x026f
+#define mmMP1_SMN_C2PMSG_47_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_48                                                                            0x0270
+#define mmMP1_SMN_C2PMSG_48_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_49                                                                            0x0271
+#define mmMP1_SMN_C2PMSG_49_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_50                                                                            0x0272
+#define mmMP1_SMN_C2PMSG_50_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_51                                                                            0x0273
+#define mmMP1_SMN_C2PMSG_51_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_52                                                                            0x0274
+#define mmMP1_SMN_C2PMSG_52_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_53                                                                            0x0275
+#define mmMP1_SMN_C2PMSG_53_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_54                                                                            0x0276
+#define mmMP1_SMN_C2PMSG_54_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_55                                                                            0x0277
+#define mmMP1_SMN_C2PMSG_55_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_56                                                                            0x0278
+#define mmMP1_SMN_C2PMSG_56_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_57                                                                            0x0279
+#define mmMP1_SMN_C2PMSG_57_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_58                                                                            0x027a
+#define mmMP1_SMN_C2PMSG_58_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_59                                                                            0x027b
+#define mmMP1_SMN_C2PMSG_59_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_60                                                                            0x027c
+#define mmMP1_SMN_C2PMSG_60_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_61                                                                            0x027d
+#define mmMP1_SMN_C2PMSG_61_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_62                                                                            0x027e
+#define mmMP1_SMN_C2PMSG_62_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_63                                                                            0x027f
+#define mmMP1_SMN_C2PMSG_63_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_64                                                                            0x0280
+#define mmMP1_SMN_C2PMSG_64_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_65                                                                            0x0281
+#define mmMP1_SMN_C2PMSG_65_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_66                                                                            0x0282
+#define mmMP1_SMN_C2PMSG_66_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_67                                                                            0x0283
+#define mmMP1_SMN_C2PMSG_67_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_68                                                                            0x0284
+#define mmMP1_SMN_C2PMSG_68_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_69                                                                            0x0285
+#define mmMP1_SMN_C2PMSG_69_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_70                                                                            0x0286
+#define mmMP1_SMN_C2PMSG_70_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_71                                                                            0x0287
+#define mmMP1_SMN_C2PMSG_71_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_72                                                                            0x0288
+#define mmMP1_SMN_C2PMSG_72_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_73                                                                            0x0289
+#define mmMP1_SMN_C2PMSG_73_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_74                                                                            0x028a
+#define mmMP1_SMN_C2PMSG_74_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_75                                                                            0x028b
+#define mmMP1_SMN_C2PMSG_75_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_76                                                                            0x028c
+#define mmMP1_SMN_C2PMSG_76_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_77                                                                            0x028d
+#define mmMP1_SMN_C2PMSG_77_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_78                                                                            0x028e
+#define mmMP1_SMN_C2PMSG_78_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_79                                                                            0x028f
+#define mmMP1_SMN_C2PMSG_79_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_80                                                                            0x0290
+#define mmMP1_SMN_C2PMSG_80_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_81                                                                            0x0291
+#define mmMP1_SMN_C2PMSG_81_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_82                                                                            0x0292
+#define mmMP1_SMN_C2PMSG_82_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_83                                                                            0x0293
+#define mmMP1_SMN_C2PMSG_83_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_84                                                                            0x0294
+#define mmMP1_SMN_C2PMSG_84_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_85                                                                            0x0295
+#define mmMP1_SMN_C2PMSG_85_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_86                                                                            0x0296
+#define mmMP1_SMN_C2PMSG_86_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_87                                                                            0x0297
+#define mmMP1_SMN_C2PMSG_87_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_88                                                                            0x0298
+#define mmMP1_SMN_C2PMSG_88_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_89                                                                            0x0299
+#define mmMP1_SMN_C2PMSG_89_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_90                                                                            0x029a
+#define mmMP1_SMN_C2PMSG_90_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_91                                                                            0x029b
+#define mmMP1_SMN_C2PMSG_91_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_92                                                                            0x029c
+#define mmMP1_SMN_C2PMSG_92_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_93                                                                            0x029d
+#define mmMP1_SMN_C2PMSG_93_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_94                                                                            0x029e
+#define mmMP1_SMN_C2PMSG_94_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_95                                                                            0x029f
+#define mmMP1_SMN_C2PMSG_95_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_96                                                                            0x02a0
+#define mmMP1_SMN_C2PMSG_96_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_97                                                                            0x02a1
+#define mmMP1_SMN_C2PMSG_97_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_98                                                                            0x02a2
+#define mmMP1_SMN_C2PMSG_98_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_99                                                                            0x02a3
+#define mmMP1_SMN_C2PMSG_99_BASE_IDX                                                                   0
+#define mmMP1_SMN_C2PMSG_100                                                                           0x02a4
+#define mmMP1_SMN_C2PMSG_100_BASE_IDX                                                                  0
+#define mmMP1_SMN_C2PMSG_101                                                                           0x02a5
+#define mmMP1_SMN_C2PMSG_101_BASE_IDX                                                                  0
+#define mmMP1_SMN_C2PMSG_102                                                                           0x02a6
+#define mmMP1_SMN_C2PMSG_102_BASE_IDX                                                                  0
+#define mmMP1_SMN_C2PMSG_103                                                                           0x02a7
+#define mmMP1_SMN_C2PMSG_103_BASE_IDX                                                                  0
+#define mmMP1_SMN_IH_CREDIT                                                                            0x02c1
+#define mmMP1_SMN_IH_CREDIT_BASE_IDX                                                                   0
+#define mmMP1_SMN_IH_SW_INT                                                                            0x02c2
+#define mmMP1_SMN_IH_SW_INT_BASE_IDX                                                                   0
+#define mmMP1_SMN_IH_SW_INT_CTRL                                                                       0x02c3
+#define mmMP1_SMN_IH_SW_INT_CTRL_BASE_IDX                                                              0
+#define mmMP1_SMN_FPS_CNT                                                                              0x02c4
+#define mmMP1_SMN_FPS_CNT_BASE_IDX                                                                     0
+#define mmMP1_SMN_EXT_SCRATCH0                                                                         0x03c0
+#define mmMP1_SMN_EXT_SCRATCH0_BASE_IDX                                                                0
+#define mmMP1_SMN_EXT_SCRATCH1                                                                         0x03c1
+#define mmMP1_SMN_EXT_SCRATCH1_BASE_IDX                                                                0
+#define mmMP1_SMN_EXT_SCRATCH2                                                                         0x03c2
+#define mmMP1_SMN_EXT_SCRATCH2_BASE_IDX                                                                0
+#define mmMP1_SMN_EXT_SCRATCH3                                                                         0x03c3
+#define mmMP1_SMN_EXT_SCRATCH3_BASE_IDX                                                                0
+#define mmMP1_SMN_EXT_SCRATCH4                                                                         0x03c4
+#define mmMP1_SMN_EXT_SCRATCH4_BASE_IDX                                                                0
+#define mmMP1_SMN_EXT_SCRATCH5                                                                         0x03c5
+#define mmMP1_SMN_EXT_SCRATCH5_BASE_IDX                                                                0
+#define mmMP1_SMN_EXT_SCRATCH6                                                                         0x03c6
+#define mmMP1_SMN_EXT_SCRATCH6_BASE_IDX                                                                0
+#define mmMP1_SMN_EXT_SCRATCH7                                                                         0x03c7
+#define mmMP1_SMN_EXT_SCRATCH7_BASE_IDX                                                                0
+
+
+#endif
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
