Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0208C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 08:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBB72463B
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 08:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EEByChrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBB72463B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C87686E4A6;
	Wed, 28 Oct 2020 08:31:01 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700084.outbound.protection.outlook.com [40.107.70.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03DDD6E4A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 08:31:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBrawPbQkiPRH/8UsvzQub7sKFaDVopDP7ZvuWfouDsrarpcXYI4ng2Dz5AKSDZcVhtyBd5QFuCvvg1VLa5h9UwSL4euHYHB+wE2D0VgvBPnqN4sZF/csqtR1PMwI+7uxb9coWyhHswtm6L6oglZ5rPXlu/FxPbwLy5OyiUMS6GGIWhgsXTt31vO44Fy2ZydN1ce5WTZS+FTPOkcdG1AzhpXbPjSUYShLByo6BBixuCw8aAWqJ2WKSkoQF+xDj8UH1x/9sQbeGQVIc5F5nqAVYd+uhBy23WiMu4hLatL6RnGAgWjidExRv1CkfTCOPgxvkVzOZVMXIEzDdhMLHY0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXjRmdWTuvLJC94uQRq+mpcQA9uXyOBlte1+hGY2/HE=;
 b=WzYqT2YUSKghetkjdMmCAYUDTJ471O0+4i1jspBNrR9au74etWPrs3EhcVHW+djrmXRPyHMRXZN9TKPL6kqwCozeTQq4CQ5b0cwAGKshLC/gVHUtI3ri6K1WHdOIJb0E8zJwIzT8/ikgsszUT0cbA/jAZ7x9a7l6Tcegy2lSoSOtUPBKZgGxY+1WdzIp1JwyNF6G2RMu4mkTm3pa8dpchcMU87q1PD4SaVA35q5dkSqhAogNjJVdwhcg8Il04e/vDEt0aSx2AA+TE550U+2nAlr/l0fw2LQzg3Izjc9to9vYgSaXFKhx82xGx+y+9pqPIXv2O3YV8cYyJa5FesxI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXjRmdWTuvLJC94uQRq+mpcQA9uXyOBlte1+hGY2/HE=;
 b=EEByChrr5DRVSXdlQRB+5BsiP9oCUwMBfOborSllRJXh1UScM4Sz39ortfF304vD3q3oOYfRH4MaQNofLPjLcJtMA7R7nA7camMDZl4JRnW5/S3nsj65TC7ItIHtYxLKr0hg0inqRlrnTn0FWODjkhdsZyEE/TSbUgjlzuFnD+0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4699.namprd12.prod.outlook.com (2603:10b6:5:36::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.28; Wed, 28 Oct 2020 08:31:00 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 08:30:59 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amd/pm: enable baco reset for Hawaii
Date: Wed, 28 Oct 2020 16:30:29 +0800
Message-Id: <20201028083031.1195496-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201028083031.1195496-1-evan.quan@amd.com>
References: <20201028083031.1195496-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0001.apcprd03.prod.outlook.com
 (2603:1096:202::11) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0001.apcprd03.prod.outlook.com (2603:1096:202::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.4 via Frontend Transport; Wed, 28 Oct 2020 08:30:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7846dfd5-b907-4dbd-9eb2-08d87b1bcc5d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4699:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46992036D88DB73114A19596E4170@DM6PR12MB4699.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MtjXLkWMct+F1cloFoHWo7adeDUIfcrt/oWcjR5wDwa0e2FAkipyEVjrx41fmo4MGZxNjpcCHGRhqUYvoswlSBIoz9/UtUvFShGo+FwLkalCMRD1v/3098bxTuz2PEtMDPIW605PfLeeLpAu9ONHNo5PWZi4KDiOAt/3Y18+vFe2FcBQx/CZUILwkZZUIpOFH+mOGXn/nHYRRo6DHaphV94o9Bkszyld8w4Gpv+o4snNE8tJFPGN4IBbWfMDYheI+5535IRt+v0xQfxUpBIGMM0suckKZSxFN3i8cxqvwiUajz5p9yZZt281MM3t7COmw36Vc99qsKhs+b05WtlutA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(1076003)(86362001)(4744005)(52116002)(7696005)(26005)(66946007)(316002)(36756003)(8936002)(6666004)(8676002)(6486002)(5660300002)(66556008)(6916009)(83380400001)(186003)(2906002)(478600001)(956004)(44832011)(66476007)(4326008)(2616005)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jLIkxLwMd35IMjUJOIdgS8SMo9eIwOueOTMeq20Pz9pyksA4eFrwMeysPA/HJvuNU18tHY2Ott9ub7Cebmz3P+zBMFjubxTCz1f3CDI/8KwMvl7jmqD52u8kQ/LcOCyuKqUuOQIzSwGECG2AtuS9eGP1Baa3IadBw7Go2PLaqgN5q7tZLiugpqFiw+5sWB9VZkrYIOsskNaQrd6p6k5V/00nKpyeemAIGx2YBtvMxC26SLoLbmbwz2C5bUkfaAFZxihaGmLXXalA9ysTs8GZIx0bTCjEPf3QusUwS6wS2XQMWZxA/q4m8wLkJ9K9FviI1DBhsQH3j3gfrd9BMCsvmPQ66gd7J69ifo4xhp+b/eEkk5k11zKhtnZroymRKw87GcLgmoByUX95uWQp0pc5c+2qlLKEeQbzUQvXzAX2jn+T9bbmzPXVcEYRedVRsEEdn50Pi31J8Txa9GofCEKBA/DkLPXyax3iqvU6T+yQi718ERJ8GCQIHYsdSVhUBTdA1Q70OQDPH6CVDNQWFMoCANMVq8e/y2PCth4H3Dw6xySx7MUUxqSusVx2iNUphcr+L6CLrHTwtDMcbKU7M5iMLdbsijD1YLJjTLJ4uErJNNJiDr+PJpLwqPRepneQORY65RVbph8w1IXLURwXFTqPJg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7846dfd5-b907-4dbd-9eb2-08d87b1bcc5d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 08:30:59.9094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RoVjxOJ6OElVgoElFTsFKmc2iPb+K4wzo05qHk4/IJNXG93TuKjVrnloLLt/mk61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4699
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
Cc: Alexander.Deucher@amd.com, sandy.8925@gmail.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Which can be used for S4(hibernation) support.

Change-Id: I9c90c916bdd6e128b7cf7f5c6c2c6ca5b7cfc0ef
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 03ff8bd1fee8..5442df094102 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1336,11 +1336,13 @@ cik_asic_reset_method(struct amdgpu_device *adev)
 
 	switch (adev->asic_type) {
 	case CHIP_BONAIRE:
-	case CHIP_HAWAII:
 		/* disable baco reset until it works */
 		/* smu7_asic_get_baco_capability(adev, &baco_reset); */
 		baco_reset = false;
 		break;
+	case CHIP_HAWAII:
+		baco_reset = cik_asic_supports_baco(adev);
+		break;
 	default:
 		baco_reset = false;
 		break;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
