Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44556C47092
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1046B61C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1046B61C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B899C6EDE1;
	Wed,  2 Jun 2021 16:51:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C9A6EDE2
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3zXzIllinj/Ju994kqlK0uFPIVX+TFF+tQiZiNyqyL/51U1wLcmC16zjsPvtOYcLaP/q0BA6nzYM/H/fpdClMxoBOpvzN76+abQLFm3PKwGY3+ZYUnJGyd5L0GnsEqrb1C0uKHcG5MwuJzBZSi13fiP2YmifI0wB5rVLCW5004QOAkijeOuWPTeqzMe7gHfC5WMNJyG3oKdytEFk3bT9lTDLAC2IJ32XtcIRfgNxXDsLSQC3uFwuKaFyRk1N8MqtkZBx7BAPX2rMBRLv9OIehZy8ZUVDv8h/maytXSfMsGQwWzVH/b8b72vYrzLtSJWP6+BWxZb6w8Ih1hgTZgwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vs2c2IwbcBQ15kAQlNwW4BZv0bLlzuNlZ6FR5cFclHk=;
 b=XJ0Y7/W+Q9Ocg8oGtFWWM9k2neeQOtcPgwC9y+bIvldpme/mMW7yANXQ8EXE4k2nOAngvPjjv6pO4c/EbaPS1czGMXl3H9rkGRUVKsX9VLp+ocbWJ5k5BhCBa8M27ymWek8PekneT5Ztcx8HHL5tIXNI+9oUrf3xc+/iLlgW2fuiOYkHoAeRFkmXBD+ENOFoCdvAQwPn5ouSQMaKWEJrBfxEL6Vpr3d+xyezH0GdFNjciULvLAUulZRB/BJcPlYYYZ+C1Wno8ycmZU1glS8owcbuITg0AF15h64Y2o4KSTBUng2er/nHL4YDmpBw6UahHNTe/Qq/A6owCIwhyJDPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vs2c2IwbcBQ15kAQlNwW4BZv0bLlzuNlZ6FR5cFclHk=;
 b=OeX2NItbZc8FUYIIEPtkQc8Ls5t/tfFwfJiET3L4byt37k1pGtnR/fVe8iFWRUPvWif/JePt2/Ys8MlhiFL5vHBMUgwsV8JR9kRb34+donuWBVvMAr07RUuBtXmKZ0SbGMHzsNr7CVs5+aO7nTFPujPYOU8uQnsbjgeiE+w83DM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:24 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:24 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 86/89] drm/amd/display: Add DCN3.1 blocks to the DC Makefile
Date: Wed,  2 Jun 2021 12:49:05 -0400
Message-Id: <20210602164908.2848791-86-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:50:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7d79550-c646-428f-1e03-08d925e685ef
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4534B443A45032AD1F8287DFF73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFxKRRfbPbiHZV7NDkWvirsgQS/g6IRc0XcLfTzDxptHvYOYU1LTzsuFwHUPEZz+W5PFVajNgWYPaznPR1eO3A7Ay+z1Y70Ll5Wumdva9kOMUTLm/HfX8Q+2Z9U68MVViwhq0qTkpl/cG/W9RKSfuw6EQSBVtGkZwhQDmVdZgvNescMt5eynBtbbgEwkPjdCwKkWxK8ofOcSBnq/I4lUtghVTL5hZx+HaBNNKAmG58o0UP9mdENcbiFtjEmolssSNAgAA1vokW1pdzUFvlcMa8tsI97dlefoiwTUbEbZzX0vNSeq4bpA6w//uE9znAaGvhw8KJl1LGJtgysYQ4stwt8g4WJPANCzXwJzrtA0FI3hNWFn34QZp3EEro7TvFo2TrDOjLlKKvy6iaYpV0Fu6SLX4trUVu0Pd93sV8wNBa9bPKZ7D7UII0NGlmTYmb0XatRXo2KH53oU2C5u10mVJEala4kmwx8f87y6ajxRGZDy3EaYt+N3Tqcjh7UpVMiwoHPHzb2NM5PpgiZ1ysqv/4pHe92L3dR8ShSGh3DOqbYbRkN5MEd+nFnZvIMByaBcJmNw1o4eC0kvllE8RDdfLT6+Wa+YRc6QI7iTrOf1lMNRxIFV6YMI+BdKcWf6yEFtFICH14pwTU1Z6Czap8NKogq2lJPiLF/baPNLgV/xZT5eRQacvVoTHZLfy8lCGYmO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vewTf1bKRJXdhBhhsL951KpNNPFcZxFICaKcT336X0H17eh99OuJaLAUIHgD?=
 =?us-ascii?Q?H7gym3McprZj8maRojltXdN/26GbTsIG7Hy7f3kPm9hDwqZnzBQ04/LGlEeE?=
 =?us-ascii?Q?6eJYhcp7RZf7ogeDhlZ/WnbGizC/clvVH9awuSBvdMe37qFyXrB+ThW0pHne?=
 =?us-ascii?Q?n2+NloWglltexdEailLOYIEiZGQggnlf6UBJf99/I31w6xC//hLoK3Mn48u6?=
 =?us-ascii?Q?prM2LSO0O3tH7+FjUITqAw2SGGvAHJg/mppKCRw9hIaH01Myi9sJxp1Cs9cL?=
 =?us-ascii?Q?9ytpvEkqQhhOs9BNfW1IVVQHtDL0C8xI/NOpuba1ih3m1GdmHBcqEq+UHKqx?=
 =?us-ascii?Q?U9dkudACmZBODekSz10PwJm7+lc4e8XmfO5Pm11qDY0+ZURXMj3S91A//7zQ?=
 =?us-ascii?Q?zjdp99rcxwHMQk2rER/Gjiq7Hnuro6q6AOOMCX4k8ithOmxSIzmkyjAT0RdV?=
 =?us-ascii?Q?xQ/aJ9lPmQLKcMM6wpt8VKy+pjrldCmd6SX/laTG7LJLg8eof2AfbggZaFdC?=
 =?us-ascii?Q?NuKxd7wML/jpvdIJj+I2Dck5epHqgzmqmvymypt2uIK/e1rljI023ovgFfIG?=
 =?us-ascii?Q?X27/xSzTy8oPcymcYwlAkZuCjeZPf9Dx3Tm6GjvAc4hjREN2s7UEkWHoP0u9?=
 =?us-ascii?Q?oTzdlHNF+HH9lSZWLNHJsZ4iAa8U1tDg4l7ykBNvg9+So6MaqRih1g22XUCW?=
 =?us-ascii?Q?I6gs7VcsHtXQvKzz6dp8GNNrVKfl3rmMmBis7jGUp/ZJOhLE67xys1/BlBL2?=
 =?us-ascii?Q?fHtyav7UJS+GOqfVvQb2tXuf1kEEAXaJkrQgYcazSbA8f+3tEw4a2RbxOaw+?=
 =?us-ascii?Q?xuDkJospOvkwavxMCxjVihdqUYn+jHDaK0KlgjdLFYZEweeCCWedljNLTZ49?=
 =?us-ascii?Q?3piKHBY5oPh8/LrMS2m0CBvsnDojvj9vNKl64OWv5gcTP8Lx7TFZoknwh1/S?=
 =?us-ascii?Q?WwTtl2C7dQztay8QJn7a6zasIrXiYdRMstkvfr2HVGI7GXaIL9DQcC2jEIiZ?=
 =?us-ascii?Q?vLX2Tx5+f3veJxrvFN6sPYBL5t3gXkK9G1/8ZnrZJt4ffjSvuz3OgFalDpbE?=
 =?us-ascii?Q?r+DEH3CvsoHQG/8BTSF+kwqGyfGkT/H8Kbvji9l9cJyWJo48KwhzG+7gNQnW?=
 =?us-ascii?Q?PU7dm7EiYc01ehEHusOEMgYlxgh6wgIRQPcYOmh8uwdfpKfgLoFceMz0UZfN?=
 =?us-ascii?Q?YLDmdXIwpXy1oyE1YOUBa7jxLnkkEXwXLs9VSLhEk6Pbhk3jFe5/wRKiqfRV?=
 =?us-ascii?Q?8muXXBE1xZnMYeVOvIDEWpN4eu2+sjCz/LRDDn3l2FSUEXKZ/VkorHO137Rs?=
 =?us-ascii?Q?WbDvv6AMF+3wfJAzBRzgsOM8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d79550-c646-428f-1e03-08d925e685ef
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:27.2169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuoNVoqTlZL2wKP9vEkpxMcD9+cHHiTzsMG185PwapKb2DPqewF57G9dvQQbc2IRjspSaw6ZFaYzG+rsFDKkpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Preparation for compiling DCN3.1 support.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |  3 ++
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile | 35 +++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/Makefile

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 505158a5fcc1..95aca9b0ef7f 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -34,6 +34,9 @@ DC_LIBS += dcn30
 DC_LIBS += dcn301
 DC_LIBS += dcn302
 DC_LIBS += dcn303
+ifdef CONFIG_DRM_AMD_DC_DCN3_1
+DC_LIBS += dcn31
+endif
 endif
 
 DC_LIBS += dce120
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
new file mode 100644
index 000000000000..439b95d4c120
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -0,0 +1,35 @@
+#
+# (c) Copyright 2020 Advanced Micro Devices, Inc. All the rights reserved
+#
+#  All rights reserved.  This notice is intended as a precaution against
+#  inadvertent publication and does not imply publication or any waiver
+#  of confidentiality.  The year included in the foregoing notice is the
+#  year of creation of the work.
+#
+#  Authors: AMD
+#
+# Makefile for dcn31.
+
+DCN31 = dcn31_resource.o dcn31_hubbub.o dcn31_hwseq.o dcn31_init.o dcn31_hubp.o \
+	dcn31_dccg.o dcn31_optc.o dcn31_dio_link_encoder.o dcn31_panel_cntl.o
+
+CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o := -mhard-float -msse
+
+ifdef CONFIG_CC_IS_GCC
+ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+IS_OLD_GCC = 1
+endif
+endif
+
+ifdef IS_OLD_GCC
+# Stack alignment mismatch, proceed with caution.
+# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
+# (8B stack alignment).
+CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o += -mpreferred-stack-boundary=4
+else
+CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o += -msse2
+endif
+
+AMD_DAL_DCN31 = $(addprefix $(AMDDALPATH)/dc/dcn31/,$(DCN31))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DCN31)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
