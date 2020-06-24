Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA002C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8A820724
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fgkEMV/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8A820724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 512766EB6F;
	Wed, 24 Jun 2020 14:35:20 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750043.outbound.protection.outlook.com [40.107.75.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A686EB6F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 14:35:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdxvIF9IXRI5PemVZuV1COvyJ7EGAkuO30PqyPHOylcO0h9iUjcqO6cdqFIrXKQxC0Y0H5m4rb75n+jC9Kauc81rOP7aTicU460+gM2CeaS4WQulU24pWqechnUrRuRL3t2IcvoaP5rTVyW0inPUXYzoToTVaQCf7NVzGqmoxShs1evC9hh1molGMYWFoiBAjHvvgQfCdM5oUxASteVZFnkmzwU9e9FzrchpTK0G9Ghv7OFOcj0oAqaTH2Duyj2uXKDjzhjM1W5DoY3a4ztBODD9lgb/qV1L2iZl0AIrfOp3BPRobnLcXnARWZQAXAHZYZvWuyn+5XgspH8ao8eVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jFqW83P2Zs5VTJy8IMwJ3ttV6fCk9SXRnIzXH44XbU=;
 b=X5b35d1iE5BmIvcV2pks8vJUDPOTYhu0O1KWW6oNoFinJlF07Fktd+6XER1gfz8Qw7DE8bA6lqhRq+iE/bCqqjnNjbtQAhRgKa1r0X+KHvJHocet16a76jqq9ncgCTcFfc4p9XAcAiXEsNsQT0KeOociJlL/H99jQG5BPNTQ84E251or+yfFq08khfsIwngsPzpS0f9KvqNVnblMnFpiMJ47AnYmYSDpm8C1panSrhQ4oWtN94Idn0apNAxTletSFgJG6NmAOXtWUUd0+iYjsj7tyieHHpYSgIjTVNy0JWTXW8rMz93g2XAU8T6+a/90cwVqJxfYFMDKc2wiWf/K/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jFqW83P2Zs5VTJy8IMwJ3ttV6fCk9SXRnIzXH44XbU=;
 b=fgkEMV/g7++RIpwojWdnWZYSh48J/VQHR93PYy5QITXvsO/R1/Niq67hu0aWcfLBCsoIoRZGfKfq4ghV1ECBnh9CiYKH+uqEJukK6H3ijqfH4k+ro0HMmHZMnoZ+7VQx3AKD6Fg9jkCqxCnH+GfNL+3As7C24KDhRr3snzzhBOM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 24 Jun
 2020 14:35:17 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 14:35:17 +0000
From: "Wenhui.Sheng" <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: reduce ip discovery data reading size
Date: Wed, 24 Jun 2020 22:35:00 +0800
Message-Id: <20200624143500.4062-1-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.245) by
 HK2PR03CA0056.apcprd03.prod.outlook.com (2603:1096:202:17::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.12 via Frontend Transport; Wed, 24 Jun 2020 14:35:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5a71371-5e5d-419b-f533-08d8184bd049
X-MS-TrafficTypeDiagnostic: CH2PR12MB4232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4232AC246914D021362E87AB8C950@CH2PR12MB4232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fhFWIKSdKRVyEYcY5HwPOyBIOzcSdY9yTwN+9SvioFSZe1Brigr6NKlz1l3a8wpqWTjChyDEuK4JLctj/aMeAhZQHpOoob/Qiw7PnsG9xDziU49CQPC+r48y4ox6ugvNJ9uaQkytdvDUth9Y2JvwX5cQTMCZJ/b8k9Qnfyq/WyIEsVcQ9m1FYkOv5B+4qrYQB6QqtUgnYtZ7UbHA/efycfFScMVE5txaTkXjAj3EV+b6/fc5MTk3ycelsGUYEMvjA5TZDZLZA1uSSVd8PQ1a94BbnRtbS/V/hf8osBMQ+wsV/ZQhu9LexYJ1VyyXXmHS4gEDa2+H/Nkb2Tl0t5oa/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(83380400001)(4326008)(52116002)(7696005)(66946007)(66476007)(66556008)(2906002)(8676002)(956004)(1076003)(316002)(2616005)(478600001)(26005)(6486002)(5660300002)(8936002)(16526019)(186003)(86362001)(6916009)(6666004)(54906003)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: U8gal9suD1O3i0yHjMo82eCRzfobyVoVm2WVqYJHf/KvpwneVXNADqNhTnx/q6S/3DwF+SLZ+/E5iylH+ZWcJrI+5qkAD2PcLC+LjW05ArRTkG8F/Z379pjDnGDLI/0Y5/Rlb0pKV5p7by/7vtV8SgCoRDM1uczHd0bDS+PxW4Wvg47BwGKPSGk5UMvscYHKrwLjojVkQB+0YDBQmEd7Fk4FTPY8D738qZ/zy2Pl49hhfQ1IGJsbnqY1J8wpqprlX3D9Ivsk3cNtIyJSUaJ6GzO5xdy2Ka9AsVdEg74VhbqAI25E+i6RguJAW7RbEf7BDprpspYUpVq7MhtTnKq9yZV3D7TOd8GCF6jFnSIrf1cZIVy1logPad0be2Lbsf3ofSDu44+twwZD67JNO2I7XYYsSlTCwXOrxPBbhbD0u1z0cf5RphxztKigC9NZlxTjzo8p+p0Kfscwt5QtvlSXtKSWBEG+nxpc/fXQGYZIT9k=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a71371-5e5d-419b-f533-08d8184bd049
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 14:35:17.1665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVbn5/Jbgv+BR2+UnoJE8peZLJLEfNZQu8Q5XK0h5Zibsnmb97T5yukkJf9xMk/3i63ZxjCwWW442SCxSRWUWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
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
Cc: Wenhui Sheng <Wenhui.Sheng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenhui Sheng <Wenhui.Sheng@amd.com>

Only read first 4K data instead of whole TMR block,
so we can reduce the time in full access mode.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b5d6274952a5..82c048766745 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -133,7 +133,7 @@ static int hw_id_map[MAX_HWIP] = {
 static int amdgpu_discovery_read_binary(struct amdgpu_device *adev, uint8_t *binary)
 {
 	uint64_t vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
-	uint64_t pos = vram_size - adev->discovery_tmr_size;
+	uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
 
 	amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
 				  adev->discovery_tmr_size, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index d50d597c45ed..8f6183801cb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -24,7 +24,8 @@
 #ifndef __AMDGPU_DISCOVERY__
 #define __AMDGPU_DISCOVERY__
 
-#define DISCOVERY_TMR_SIZE  (64 << 10)
+#define DISCOVERY_TMR_SIZE      (4 << 10)
+#define DISCOVERY_TMR_OFFSET    (64 << 10)
 
 void amdgpu_discovery_fini(struct amdgpu_device *adev);
 int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
