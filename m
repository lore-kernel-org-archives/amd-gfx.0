Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73768C2D0CA
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6AC2173E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Lt0gxz3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6AC2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5FD16EB8D;
	Wed, 11 Dec 2019 15:33:41 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760070.outbound.protection.outlook.com [40.107.76.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 635EC6EB7A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtBq+hm6PqPvvlH60IHIiumxgSvxrHaL0c838vKX1OaBJURyqhauTRWjgoyNOcTWR9sbKZFcKmY+StFRVc0j3jfeAs1YIe19qsSN8lugTFzZe1iaBJVyWbjCT9WQIwzfUumGrFDl6L6YeamO4hel/2Q2CQDmtHuqszmrvCrKYhzbomz+M58Rxz6Iwy7SAlVfHGib+XHsH791rOPjCXlNm9blKhoZbAxNENCxDzjLYpfru8CIx97ZDwBgFhiHb7ZcAr5toh6VmfpjQtvS0Bn1Ym+s5lzZ8U5rKQEyt5qJ/RG/isQEzQJUbcFPp4+3ZVaCFJzw7nsI/p59GWwRTnkD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NW5l5Qi4D67sCYkp84iqislcOwgtF86QMImdm9Iwlo=;
 b=JCb2f7u4jUt80naWlkRiLzoCQeNSfAbyUhoJAJ03PPEWI4v9kvjXp1MCJVmb3cc3quSDBW9iGAxRbLfa6u9FW/HV1xmtKTMWsMCh6l7zbD/D2Rrw1YnGZOirFoUwsoLj/B4UC+fTEwjTqpW+OJU/MteiJ8VOlGfgWUjdvYVXohqsoZOqpE36KJ6toyQjJN2Lc2Iou3Hr5IHI2GymXhKaDKghgy4mjHMXrauq7g+WQAf3MT5pBY7uq7+KIHprYJZgeNAdA6yot0AzOjwxh4/vLUdpyeUg4pWv3ZldLPPzDANz3kRLbjGyDu9p/UTKwhGdVYNvKlpSUUbkbxCi/NQGuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NW5l5Qi4D67sCYkp84iqislcOwgtF86QMImdm9Iwlo=;
 b=Lt0gxz3uW5GMXfSwOH210bz/TWuzlejLkcWlNpMh0GoyBLHvjVXNt/Sj7lJmNQWfxJx9wPQRXLeasgUTqQlblgkdmFb0oH7abnNmdouV31o1a8fVHRotIK3BjM0oZOEzcNmJf9PM+UTvXdipAVsnRxSbdDum4a/sqvTaJmc03aI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:39 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:39 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 25/39] drm/amd/display: Specified VR patch skip to reset
 segment to 0
Date: Wed, 11 Dec 2019 10:32:39 -0500
Message-Id: <20191211153253.2291112-26-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 87e40173-b5ab-498d-002f-08d77e4f7e99
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491285F172EA5D510E47A7B985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(4744005)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rKcG3m3N57GSbVps1Ux6tQOLON7Il+zU8LyPpzjlGHLC6MXgP2DrgdUZi4TBFGTGP4uUyQdpsmC7Oz1aRXZZeKCorXbpKRn6S5pqq9Ywx/JGIwndjWyO3phb09hCbY9QGpzAhCT8xEm7KcBmqsdO4rrHU1a31HChi7yRJ2hKoD10KyW1QnXKqkxu6DeUa1UvrLiZzMo+BJnIj0hHOz2HGmatgXVwP5poW7P9An1VbaS00r/YBm3Nxk3cG4H603dcOKLo4+tIpl3A/lkRuNkmwdUOrisFt4EISqSx2Lfif9+DJn1pW7zN0rvRDqB3fhzxHg5j6ZJO2Bq3/nlF+O4xoIwJNvdgXeYxY51PqdbWFn9+k3po/Bu5jzZOU8k/QtsIy2VTjFSvhxQu6FzcLhx7AzjBZa2bNvXJNz0MQZ50Fc7lo/0sr6/N3oBuyzWR4x4W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e40173-b5ab-498d-002f-08d77e4f7e99
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:39.0475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Or00qppPGE0j5QkFhGg2h3JDcdfhxoK8Gy4zwCcSAHYzj1bhEhgVPvTj1ODUTbb96aGGqxQXMFTiNm6Em17sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Derek Lai <Derek.Lai@amd.com>, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Derek Lai <Derek.Lai@amd.com>

[Why]
After read the 3rd Edid blocks, we will reset segment to 0,
which causes this VR fail to read Edid successfully.

[How]
Skip to reset segment to 0 for this VR device.

Signed-off-by: Derek Lai <Derek.Lai@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 1ff79f703734..f420aeac7fbd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -133,6 +133,7 @@ struct dc_link {
 	struct link_flags {
 		bool dp_keep_receiver_powered;
 		bool dp_skip_DID2;
+		bool dp_skip_reset_segment;
 	} wa_flags;
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
 
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
