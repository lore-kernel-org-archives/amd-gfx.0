Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFDAC2BABC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 09:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBEBD206F7
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 09:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ALdBPADX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEBD206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EF966E7D9;
	Tue,  7 Apr 2020 09:13:31 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690048.outbound.protection.outlook.com [40.107.69.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B0F6E7D9;
 Tue,  7 Apr 2020 09:13:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko2/rA+TV267ajRkLjsxr3Me+KornSfrK7qDFAdDt/cdgU4WOePUGCeRIsiUZipXRabnQMVrg8TO5O4RYjCIdXJM8Xj9eCYZx/GZ5rq/HQrx3vP19fMEKrIQZP5MDmVuIs2tfB6aGusk0hSDOeYo1Th9UlVWcM7ABLdlK0k92cvCsWFdXRbypZys0ryNstA74ANo9y9vGTgo8zdHqediKHMbuwz77ECnJY96FRNPDM46fvmpvEPFevFXKStRQTFN8UJqj33ZcLAHmcixsTEaERleUFP3L4ND33HGW1LUxD62msojU5pubWohIiNwYongfVBXAA6AZ1ePCXatJJcauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OFwSfkXmHYi7u42qDfqcWz9T4s/ubR25NdYBGd1Zfg=;
 b=ZuCf0NknlKLz39mG4fNvr0JPFaP6qhd1lMA4iKA6DjwqyoUTDqb+cRRidlBPttNrbl/8QU/fqVJHJ2bLvQ6fLfBBSJLHl2fJR2BPn1yO++1AjkjBt5exnAk5wlzkdu0YOvOZDNoWHsbVtlmyfTtpTnKxYfK8gcCJy/ILp+PT7ipENJx07qOpTwdX9AIwCqog3zqlgEJ30QU8f4Q9Cns49SCQj3KnBni8zI5bf6QWxlxSUcaIGsMkJyr+pQlFOoy9PAKyJLNGiTIqjj1rzw/M9Ctv8ys6NfN+14PvV/+Nm/kdexTayBJer9RkVeKfzd0Z1pQX+YY9WHgkqNINXAKezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OFwSfkXmHYi7u42qDfqcWz9T4s/ubR25NdYBGd1Zfg=;
 b=ALdBPADXhGY6Krq6/xPD6XB9y3YkUyGU8GySfK4I4n6mVNrcBMKzMyCawxkCNwwBGGFMLnols8aUEL53u/Pm2UxuhVK5Y+qn0az22c8bW/mfwprB0AJtp1A+6HmbHmZGfggE6FTXddNNd2hJk53Uzwg6MZQgZGjWaZHpSLSkZAI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB3325.namprd12.prod.outlook.com (2603:10b6:208:ce::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Tue, 7 Apr
 2020 09:13:29 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 09:13:29 +0000
From: Huang Rui <ray.huang@amd.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/ttm: clean up ttm_trace_dma_map/ttm_trace_dma_unmap
 (v2)
Date: Tue,  7 Apr 2020 17:12:53 +0800
Message-Id: <1586250773-31519-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-intel.amd.com (180.167.199.188) by
 HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2878.15 via Frontend Transport; Tue, 7 Apr 2020 09:13:27 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f43c333-29eb-4675-2c67-08d7dad3ef98
X-MS-TrafficTypeDiagnostic: MN2PR12MB3325:|MN2PR12MB3325:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB33251BF0B679F4BA29C4A35FECC30@MN2PR12MB3325.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(6666004)(66556008)(8676002)(66476007)(66946007)(478600001)(86362001)(81166006)(8936002)(54906003)(81156014)(4326008)(316002)(6486002)(2906002)(36756003)(186003)(450100002)(52116002)(956004)(7696005)(16526019)(5660300002)(2616005)(26005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7THt+7fO+OorP+C7is6yZO8Vmawm3DScZSBSOpmQpwNJ6PQTweSKUDARe4ikNECrPys6FxE/QAJjxPIFvHy7Zj6MlV+9XS/+6wlZEDIYYo8+KtYHGLyyM34O2neoiu/8l20l5OJ7pfawrPlz8WPmXr4j55n9OAIgmx8cQqPM3xQaWxpYWHlETQSjFdcN3i18KT+SB6xMCJF0bOr/3tRkd23aGZcMTUW87T72xs0It3DFqoWo1oLM0wmR9VpwY9wB/vMyxDuNugI4c1xHODnx1jZTkbobbAf3GFEVX2B/cPDDYBDQcHaI9D6fwFP6K1tJTIp/Kv3a+kVEo2CM5YdRsvXoMT1/w99rURSxOYMuDu8Yyo+sP1Of7jVAnyAwv75yyWd+7vFEsu7EuWyjjiwdsIbeW4YNMNHwCUoP/AzmLXJeluJAX0DiwRV1dvJVr3ap
X-MS-Exchange-AntiSpam-MessageData: cXgnS8aQI2fe5165jwnj4i8Yut53tQdonBfJaM5HxjpW0AbV4xgfpE/FC9TIVl7+OydNe6pinx+7HgHfzHfA7JPJco5Us+i8bjINbwau06eBA7GxZbw4ChDwgsd8rt+t9zunp7Kr/demdS5e9l0bqQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f43c333-29eb-4675-2c67-08d7dad3ef98
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 09:13:29.0665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3eDjzRAbSrUS9QGpwNtv8eG/ZXIIK54JIpAwAjDuJ5DDyKqTZgQIedIq2W3E6WWb6+vzxkvfXQ5Ys8huHdK3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3325
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
Cc: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ttm_trace_dma_map/ttm_trace_dma_unmap is never used anymore.

v2: remove the file completely

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 include/drm/ttm/ttm_debug.h | 31 -------------------------------
 1 file changed, 31 deletions(-)
 delete mode 100644 include/drm/ttm/ttm_debug.h

diff --git a/include/drm/ttm/ttm_debug.h b/include/drm/ttm/ttm_debug.h
deleted file mode 100644
index b5e460f..0000000
--- a/include/drm/ttm/ttm_debug.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/**************************************************************************
- *
- * Copyright (c) 2017 Advanced Micro Devices, Inc.
- * All Rights Reserved.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the
- * "Software"), to deal in the Software without restriction, including
- * without limitation the rights to use, copy, modify, merge, publish,
- * distribute, sub license, and/or sell copies of the Software, and to
- * permit persons to whom the Software is furnished to do so, subject to
- * the following conditions:
- *
- * The above copyright notice and this permission notice (including the
- * next paragraph) shall be included in all copies or substantial portions
- * of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
- * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
- * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
- * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
- * USE OR OTHER DEALINGS IN THE SOFTWARE.
- *
- **************************************************************************/
-/*
- * Authors: Tom St Denis <tom.stdenis@amd.com>
- */
-extern void ttm_trace_dma_map(struct device *dev, struct ttm_dma_tt *tt);
-extern void ttm_trace_dma_unmap(struct device *dev, struct ttm_dma_tt *tt);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
