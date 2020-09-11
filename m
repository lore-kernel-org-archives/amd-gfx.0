Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43317C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 18:25:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C782075B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 18:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tmUGPQ2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C782075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF5C6EAD5;
	Fri, 11 Sep 2020 18:25:45 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870AE6EAD5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 18:25:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/9ILRCRo059OKtaQIzLO7tL/HEb9faKOJ5fxieEoPeQaDWMC6iz/DQIakrFUpS/iFUlVZjCNEKtgkZn+7i58EUCpmRSbl9stcgiLVqvO0/MnKzWSeeK9vK7HmMPpEf6ngXUxvYy9wyBbLGMyDimMqLncPm+nVDtA4XmkOQqjUD3ktHqTnnhSz4oDsY5mF/yKxAdvA8WHlyuZYhuApO541z8UpaXVS82I8bUo8ERHzbia/xOwawq6l8/8Q/RxuyVcaBkEOQ8MZ922LCxluTxJHYDrH97bo52XY1rny6RNG1QXfOOicco5YGCobnfsrPrRdHRbS13v1uiWP18/KxADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlEeEDZsDrIrhdeSG+SJxHXY7dfh2UGHjXFSt5n1Phg=;
 b=dzQx17M7Jjq+zBhBhAcl2q2D+cTFLI7R2A4OFMRDHUfIkrsgTD0UWqS7ecgiSSroLjGY1w+3+rc2BVP7GufEKSSNRW2rTo4QA2Lb/PV6IipcVUj01MbWrXWS1m0yTKHdVuXZpx4/brBrUgNlE7K0ZHNd4z8YK/1+TD6AXHVanfeu74V0A3cVOBNdAhJuWNanYPr8nANOkio6W3XLGeaUVPI+JdiZfynwP5Dpb/sWhi5wcRbi/5MLNOGqPed+Z2W07kuKhlmlUmWybZoduoBql9R9M47Br+vvk9wIq2Ohk3FtECOTsIyyRjbWzkIrDqczWh2gt7XEe5SXFdrkUQAfUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlEeEDZsDrIrhdeSG+SJxHXY7dfh2UGHjXFSt5n1Phg=;
 b=tmUGPQ2ctooPLu39KXAfy4WQ0+7EOkuiSp8V1K9F6cCCF1YMHcbU0PbcfknHdo3daPFlvNAu++pH+J9uxbyJ2El0H+yOkbgeQ7VYvqJb4RzGdqVmXSvEthTTLJI5zdNCfbytfCoOt6X4lzuBStUpkOVy08a7R0Q/tPNUAZCL49g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1643.namprd12.prod.outlook.com (2603:10b6:4:11::8) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Fri, 11 Sep 2020 18:25:43 +0000
Received: from DM5PR12MB1643.namprd12.prod.outlook.com
 ([fe80::8e5:a542:5281:d341]) by DM5PR12MB1643.namprd12.prod.outlook.com
 ([fe80::8e5:a542:5281:d341%12]) with mapi id 15.20.3326.030; Fri, 11 Sep 2020
 18:25:43 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Add comment to function amdgpu_ttm_alloc_gart
Date: Fri, 11 Sep 2020 13:25:31 -0500
Message-Id: <1599848732-15764-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YT1PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::30)
 To DM5PR12MB1643.namprd12.prod.outlook.com
 (2603:10b6:4:11::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YT1PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 18:25:42 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6ea4dbd-ac83-4cd9-a03b-08d8568017bf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4058:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40588829D152FE5158F1E47180240@DM6PR12MB4058.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hp4D4gmXSOWPbjQSkkXqiAmOLasX2unCTGT6mi1Bac5irZxOoXbze39hPnVpb2XvMDbUMKYNMhAH0iUEsw+5da/ajmwNkzUqenkfQRQ6Zn+otP6hArQKudJmYZ0/MBgQqVLtzqSn+iYNQ0kVyOiri/YnP2QZD/9KCQTztpvk1kAvbd/2Pf87lglHdteHQp256VxLgzRZtx93fzV1RENwpRyvHIw5gwexIUhYgV2YFc9mW/HLTMWqYjvr2YiQdGo+bdSSWHtf/qqrEFcf9yDATxjrA0VtxrKyP+fvrOllMDOhQOZCe7odowRrkmhe/0HOBwa1YEvhf5HjCJ5dRThJqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1643.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(5660300002)(16526019)(8676002)(8936002)(6666004)(2906002)(66556008)(4744005)(83380400001)(66476007)(66946007)(956004)(478600001)(186003)(36756003)(2616005)(316002)(52116002)(26005)(7696005)(6486002)(4326008)(86362001)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: yiote1sB3Is/jSkxmDTw1SKvpWn67lbOa2tJBcVaJ94mCU8M14WzcwhyLVSruyLmBmUdUDXNhQRfZYUqBSS7n7a7h9ON1VpRfZi5Pw2gJdr19Xu16fdAGQDDDRtO1ye2NWXhoBDBDQYqQajRvah5mlErAr7ZLf9F+lSNz6Uh1WVIcvgbEvqOzmqGh5ShRZHXH2U7lr+o+fRwP5+y7hGSqvnN8A7x6wAa56RBgSoqxj5qkFIS13/X1HQwYa7Nochwc6ctvAktxhDJdb32TWJV6YneUrR+MMBpOkDD/oBExd1rPYLhfyDf2k0KJJq8HfXtAFF/cED9PU6zolqT+va75ygFYzSyvga9I1MTsWp4Lx9NSmwpsBgx7N7MooM5Ht/Apo4X9+ivyyRVFjzTr2n1BFkITd01gtdaI0TcSf1mCguK3UD6TmpnvRBRpigcb66wyMyRIuqng8Ca2yOgBv1fAM4x05RGgZMZhiMkdZKFqpEet+6UolQKrYwgqgej7o8TKuiYG0zUg/7pY6qBACKjgA85Sb9HUHK1Q4j3mc6f3Y87DOxhIUre9EApF7wpRXas+0FyOA3PPSytKxpLG+ewCfnGdL+Iu9tbiFS6w4iqNYdXmycnUFt9c8E7518dCQP5ddFUN6/0AABya3LmKUGjSw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ea4dbd-ac83-4cd9-a03b-08d8568017bf
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1643.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 18:25:42.9990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsO7GSg+BDW+H8Me6OBUZZkOLP6/wRpReVMS2LPri/PB6Nwip6QV13RYWlwIh61Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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
Cc: Oak Zeng <Oak.Zeng@amd.com>, Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add comments to refect what function does

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 63e5414..8b70445 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1210,7 +1210,12 @@ static int amdgpu_ttm_backend_bind(struct ttm_tt *ttm,
 }
 
 /**
- * amdgpu_ttm_alloc_gart - Allocate GART memory for buffer object
+ * amdgpu_ttm_alloc_gart - Make sure buffer object is accessible either
+ * through AGP or GART aperture.
+ *
+ * If bo is accessible through AGP aperture, then use AGP aperture
+ * to access bo; otherwise allocate logical space in GART aperture
+ * and map bo to GART aperture.
  */
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
