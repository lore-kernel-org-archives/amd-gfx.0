Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB118C624C2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 04:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730BB10E5D0;
	Mon, 31 Aug 2026 04:35:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D1H6hSfz";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4484C10E25E
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 04:35:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qT434W5xhnIzxtp+q0RZHtCHRBGaNEOqKM/N+c2stzEfa3cqvgZPbz7gEMqIvA1WTqzrFtMJ0kCWNxQHJmfB7CLc6yq7Y4oMlO7OSLAgpwGZZAmW8foTt9zJ+QIEGoVkhkH8S9LkA3FWLSkZCFPBpcmWw8h74AA66mkqyGUuKrxJgSqFjO5Exkj6urah0nW5gemm5JGHxxgCcFigCp2u2gm61gg1aRMqafMt53Xww8c0+zFx1meZGHJaJTDsaxC8eDygD65g8oVoB2hl0JUjUcODqa/9UQqrklnUUYFYBriNJX0AsXnkzo2awmWRYRHFJs+O+/hsmbxgkfrWBKRyUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsqcTjMZq5nBQIsbj6zY532kLXh0aK6Av2vy4nJf8VI=;
 b=e5jGhDlE53rBpNEN0xFwemvjRkEu39NiQRc4ZlINjjKzy+mFjWlfKSVOVGe3m5d8X0RyAYh5+iPqoCJLg2A3IO72JmVKQyo0WdAo9jvk79Q+VK2yuJO68Qz9A4dA8gOwQHVwmdN7SovQ230dlL1QvViNupdpDwl7nMMHVu0KLOC8O/HnlbMPpAO0pnjv5JRvNLSLbg44h21Z44GLd5uSxNSNCx+ir210hlf2x+AAsNH6N/T2vPx778Z1kYos0ptCuxBMjA0dn9ykFC2moaXZxx9TwpwM/13+7FU7eCr/qtIsDZlcdI6mCuMgl7uy4yynlm+oSnFwHb5lH7+jhkAPKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsqcTjMZq5nBQIsbj6zY532kLXh0aK6Av2vy4nJf8VI=;
 b=D1H6hSfz6orXaeNoJ6b+IxutJhblT6TPMR308XKDUKe0x22ngxsRqALD6m3q9KQLsM4pTvXghCL9bQA0/AhapRqq9OJdevJij8RwBqKmFaigKpQflojRICqE0R8sqXR1YbgtrA0nY5yQOt+iMSzFaQ0KgkLIGrljSI5JroShed8=
Received: from BN9PR03CA0959.namprd03.prod.outlook.com (2603:10b6:408:108::34)
 by MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 04:35:27 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::24) by BN9PR03CA0959.outlook.office365.com
 (2603:10b6:408:108::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Mon,
 31 Aug 2026 04:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A7FE.mail.protection.outlook.com (10.167.245.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 04:35:26 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 23:35:24 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 3/7] drm/amd/pm: stage od reset for smu 13.0.0/13.0.7
Date: Mon, 31 Aug 2026 12:35:03 +0800
Message-ID: <20260831043507.523599-4-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831043507.523599-1-kevin.wang@amd.com>
References: <20260831043507.523599-1-kevin.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|MW6PR12MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 08574c3a-9182-402c-b0d9-08df0719476b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: d2nGrMlXCA8eh9zPD/cE+0T29NWUZjfyPpUSWuq1sOWwVP1XZIl/9ycX7obC0pBE7DpKvk+LOKFZRQ0cbgHTBKEP19STcd5eSAm3ROLS/8b7+ewVf/0OyQgMn9u7wJ9s0/PmBBZLVoiMlm/+1Sw3pxitNSGJ0W0F0J4KLQnvJqFxe0S08r8TOwKNN5NQEdbv8dYQKyqJg5MXrXxaN8uqBn4NTF2jR9+Esd7rRUDrJJWzp+x2HtoiQ2lU+gwpNT6eRe8/engbCT+9pr78CZ0gKNWLKVWVz93xH39CgTs+SL141neJbZrGBbsdSx/ToNHHS5SnX9rFCHagniDtSZad0BvPVfkuZjB6cCJXlajPrR80Es8Cln6AH1w+9ItIkrR3O1xI11VMm+APqJVOlYtzVpORPg3TJ3houKzO1Wiy7c5d/cAVmOUfKX8daWQkoxpEbnHQxnX7CHc3/Lq1+iGfyA5u7HkyULxzxvdB+jA3W+ODr3X2T8dL/rHDYxQ4TY94rUPydqClMOevpUJSFULqyZ95qO8ezyVMn/OeJ+3mu7cpR4W22XwZ4lYVQRdfzPq70xNCiIyQUykZY7XdG+Y9v/u5XL1b/OJUlF33mnY6Hyy6IOEjIFcyVAaAp7AzXSmGNAEIFETSNq/ljLP3xQNZgQZokD6aRMZxSY0EyLK/eti8YKfTl9bkyEJV+5Pemi2+fpiz6DxAXzXdHr71/Yxaiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MGRtC/gyIQQmAaGFBIG3WcZ9zIG2PH8ly81NnB9VmmFbClM2IEHdQGsCG0zg2u2Q2otoXR9ouKJJuNRjzeztRnE8HLRER9T/e3VSLwKKhJj6AcS9zylDvhG1mJnNwFaZgACvEnbfRmUObaag7A5vTfdQ9lsYSgfok28IEpMfWEoTIFM3mJQu7+pAgkZgCttzyL9xCi0m0YPdnRZYXBNPY+jBts3Dfbs5/wQ5qz367ppez8hXdpkcpijxz15SnRJDJsxe6DehD/VEJts3z3AaUM8+7vva7MBiiy0ZfCDcrUUNBMgtsQ+SpDFZH27sfo0j/e/tGArbluYy+3v7Gz81lYs+AkgWu5+spaWUvSqmwkO8ZFA4xcelplz2xAodDNZN/ceE8d19x+BElxQVU4plbOnmEEc0oI5opSATZAtXYJ2w7GIpJvubgRyDcyiBGiUw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 04:35:26.3288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08574c3a-9182-402c-b0d9-08df0719476b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8733
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

SMU 13.0.0 and SMU 13.0.7 copy the boot external OverDrive table on
reset, then upload it immediately. Keep the table in the driver cache
until the user writes c.

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 16a6b8fd832c..26668cb00e0a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1897,7 +1897,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 		       sizeof(OverDriveTableExternal_t));
 			od_table->OverDriveTable.FeatureCtrlMask = feature_ctrlmask;
 		}
-		fallthrough;
+		break;
 	case PP_OD_COMMIT_DPM_TABLE:
 		/*
 		 * The member below instructs PMFW the settings focused in
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 5fe409a23772..b0399dd49639 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1906,7 +1906,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 					sizeof(OverDriveTableExternal_t));
 			od_table->OverDriveTable.FeatureCtrlMask = feature_ctrlmask;
 		}
-		fallthrough;
+		break;
 
 	case PP_OD_COMMIT_DPM_TABLE:
 		/*
-- 
2.55.0

