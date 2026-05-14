Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED999CD4F25
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2026 14:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80EF710F244;
	Thu, 14 May 2026 14:37:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XgDx1VEh";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B51C610F244
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 14:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zO/6Yxx2mfbqJAgtemq4qwd10TDP6m7CALdu+0DVzkvtLheWeYOTu+k4Un9mFlM0SXFoKkeZgN1xy90SP+qT5asTnKdnqQv84If/BWaxJI0xdmd7RlW+BR6Q+sWTo6KF+kKxI07YMRVApefGRWT165oqJWrAl38YTFX8e+davJ5hUBNQiluDqleFrG4LHzX1nr0FcL3Y3eNJUNVLlv7tGlOneSmAsd+MfXKJn+1JWQAhbLKfyjKIFGGil8bEU3s+I4DaraVR554Azo3ozw4+ZPpOFGXSpG0CZ+dHSa9yZM0EDRPJc/gx2nhgj05l2Ds0R+e+Uncc6HVz04yp6N7lAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tN+5kTUM/KwgVawzVVg7oVg+6xlJqm0U5uCAabMqaJo=;
 b=ICgL6XjFz/B/8ilOLkTDgAj7gJyG3FvlMC9pOUKGeQFQaJQGIF/x7ZGOM/I/xUW1WUnMuxQxdx9HgF2x4TZyOai9J/NTCh4UWXX3nKkS2ekm8sfz8/ycKGJv/GNIC7XahrHbwY69xaVhY3hpqgftQh/cfTKuzmMoIrs9BKWAaO5Sq2QS30yxhjCaNZDZuVuVvfuF3eCmJZMWyyWiBy3mNleBvJOk4/jq9jcAtypQ/CVm8aI60uvif3KNceGZJe/JvShL2QE7Qzb5sXeWiAVWqiM9Z2xYXu4n58g/eNZpI1l6aYyfs+0/TT2aX7Ag1sqJvZHpTbRN94J/Nvy/sP5aAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tN+5kTUM/KwgVawzVVg7oVg+6xlJqm0U5uCAabMqaJo=;
 b=XgDx1VEhhLYtD7yXPZFN0Y7aQTZ9jVrTHIFW6v29z7QwxH8ueSaXWyaTYBQvWl/2UyGGXGCDYik5wyMu9rnRyAGVua7oTu8qojNsGRe+R6OxNECqivpoI9QSvIvu7lPSG69OUmfNVTqSCAKWdi2B1uxbvND+y1f8JQIks2nmAPk=
Received: from PH8P221CA0062.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::14)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 14:37:05 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:510:349:cafe::ad) by PH8P221CA0062.outlook.office365.com
 (2603:10b6:510:349::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.19 via Frontend Transport; Thu, 14
 May 2026 14:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 14:37:04 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 09:37:04 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>
Subject: [PATCH] drm/amdkfd: Check for pdd drm file first in CRIU restore path
Date: Thu, 14 May 2026 10:36:51 -0400
Message-ID: <20260514143651.3913199-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 869dc9bd-0c38-4b0e-ec64-08deb1c644aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: z72M7hlCdXbWtrncr+kLD0GXx3saLGiM4af1zSFBXonzAdYaiAIKnq+uuFF87CH2MuUX1OYL/PgjnmZpLJo/LHa2Z+YDHD8kr70Ba1qNfkQNtoefYwF6wRP/BUIjSYq8EJxinfCYQ65W2yAfei0oEFXuuNoTJmx1F2N0jTBDmc71Ckf6OKMcdxLlNr0+NThlWtNAezLpoUrHg9OnKB/+3uWqXfLDtyd7I17XwaklBAjI5/9xEbgsw0L2RxH1Wq2QdO/yJk3QUjxzDLVjehzf+EnKCJsDeYUaCpGdniUntVOarcJEygkzfGIMrizlO/EU3pNzUURQnkx/aaH1fQVrmFAQmobztc/KwXlkb37wX5NHC0obFgh/D8+zy5WkSnfaU6bJxWf/pJuSAspqetZdSWtc3QLQdMchk0LMWKnZjtGQ8OptYRUSV3i8g4sRYzROn+8/yt3S53+1mTFZznDR1OKXYZbbrmmp9whAws93G1OwNXYHp215sfIDaolNtk9cQcM9Do8QhhVDICtx3HXfsZvNoKQv2IcgDWAwlBZFzTO4NvR5Y2r2OuidywZheHzmDi40iQa4kNY76h4LlnUz//H/uIsOv4vWd9ufP6M6Ba/XXqu83BU+FHEMZM5OQw2EMZIrpDdG1J7EQqnoh0rQamM6zdhaRgGX3jgh15OS9oEpzNJPCsw7ZwurK9ow52Or8Y0e3ijT4FeNhmxXO5L6br1wh98ZXQGUd5TnnKoXxak=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qy6DKmGj2/dn2orQpfz9jQDk9XmLuWFyaso0TA7EncAflgNjWpljsTjt1IHtogPgK2ir14o8J/h2X5B7s3BD5wG/loA5ZkKymcDed/innx9uKbYuppFaGlDGrJRNiSUdy8HcBNd4BjJQ2k7ugwDw13AB8Hj6uZ7/vkGmm0VSkDq1ekUJboF12cxaPldz4fHMnQMwvbWi/K9vnH760xXz/3yGlHa5ZP/eDpiNKsWUtoDmGQZJl1U+ECrfyvIS/BGKaRRViH9LmRbCe8mbopfadfmeT1+pXEWNCRZK01q3IFnZiyDWl++cJyh6mcYvHVt0qS8Jm8o/NyXYb445+FtdbZvxVwoBvg0QLwhQ11O5c7DBPqrl0CeGixreVvv8dmmcRSWkRR9ZiINQGZtvAaPIqZWnQsXk7eGz2inZVq9mdJqQzAQQUjBqn8LPvrDG7bO9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 14:37:04.6503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 869dc9bd-0c38-4b0e-ec64-08deb1c644aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CRIU restore ioctls are meant to be called by CRIU with no
existing drm file. There's an error path
for if the drm fiel unexpectedly exists. It was positioned so
it was missing a fput(drm_file).

Do that check earlier, as soon as we have the pdd.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 84b9bde7f371..db9223e00fd8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2377,6 +2377,11 @@ static int criu_restore_devices(struct kfd_process *p,
 			ret = -EINVAL;
 			goto exit;
 		}
+
+		if (pdd->drm_file) {
+			ret = -EINVAL;
+			goto exit;
+		}
 		pdd->user_gpu_id = device_buckets[i].user_gpu_id;
 
 		drm_file = fget(device_buckets[i].drm_fd);
@@ -2387,11 +2392,6 @@ static int criu_restore_devices(struct kfd_process *p,
 			goto exit;
 		}
 
-		if (pdd->drm_file) {
-			ret = -EINVAL;
-			goto exit;
-		}
-
 		/* create the vm using render nodes for kfd pdd */
 		if (kfd_process_device_init_vm(pdd, drm_file)) {
 			pr_err("could not init vm for given pdd\n");
-- 
2.34.1

