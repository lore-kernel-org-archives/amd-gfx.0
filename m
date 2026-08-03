Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC97C55175
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 09:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 740CA10E533;
	Mon,  3 Aug 2026 09:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="juXUqAdc";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE7B10E533
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 09:37:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyd5u/FxYg8dHvDQ7E4RNVr+wwYFoUwAEfFy5iLnWlkE5asW2m+BehN9bpeV/zilLdteQ98/srWkU9B8wvPwEyW2tukH6+fSFJ4oBCCyWS+6G37Vdsze6Vk4LzNpL5+eyWh2fTGyIJLUpcydBZwgILuK7FCDW10MoUnsY7St4IS8w35n6/qOmVVlimzyHsMKhLYp95e82eXIgJsdokk8nHpJc+8f3yMw0r7QoExaB6QuhHN+7UpFV4gS9Q/0QQYycg5JAnstC8aTsLXhlqr4+x90qo0ZuxNSkl1O8EkOrlKmQOZ0ArZwcGTSXlPWx++1BNmtXpvQcMnKKs+uu4tt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRUytj5hsxacBha4RILg5AevAzqCwzeA0Ym72dNmSxU=;
 b=TK2rUIhO3VlsCpsBE6xHqIJmXp9EcB7HvKjvdk5zrWv0zgoIVZqPU0DnED42KVw05SXyTqeRLY90U5+YKnz7VGrzzFnW3DDj+g3CvjnQcSFL7F3wNMLbKuFWIWpw2tiwPbV5u/iqYU+/lq9w5v0XVx0ksSisIvUkR8YDRZZvgkRh3wok5BIenT5rB2XqO93Ehof6LEfbpdz9JQ9P0SzIrAtHkL4c73/nfDV1O44nbtOemXDUUnf03X3QfUkKCxWV/CrM4icn2dPjeZ9oU6tJ2oklNh76eEkmW3ugvmf2bU/EI5Po2ZdgSFlcQ0BqtM/fDC+2V9BG6xwqHl66Ht6puw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRUytj5hsxacBha4RILg5AevAzqCwzeA0Ym72dNmSxU=;
 b=juXUqAdcS7Jn7OIkUAm4UaGSu+bXZy+hbmSnlFT1HCEc1jF0E6z2fz4SnaluIgXUASoCcHPLWNra8RgC54Jd5mMtaE82jJurmEMMB18gkoakRRtBIyYv9BYDfwaMgbbz8lDk8SjjrRb91DEr88DBDcq0tRUAGxiQNycdIhPT7nw=
Received: from DS1P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:453::13) by
 CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.17; Mon, 3 Aug 2026 09:37:15 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:453:cafe::23) by DS1P223CA0005.outlook.office365.com
 (2603:10b6:8:453::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 09:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 09:37:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 04:37:14 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 3 Aug 2026 04:37:13 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: serialize queue map against GPU reset
Date: Mon, 3 Aug 2026 17:35:35 +0800
Message-ID: <20260803093713.1904533-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 8428c644-b1e1-4168-5ed9-08def142cdac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: jsIjS1RocypfyuwOO0kZQFH8iM40CUYvQ7BALSKX1rJIWaeMv1h51FS4iOo2DeoGmKQHIB1Hq3XjtToVHbaGoJLDQTTXl4aq+/ooybboq5E5c39eR3apwvmMTlTmR/2ZZfypjo5ihoYGd2X8Db+D5eotJ7A+w18cH5mcV8FTduaJk2+6unE5kdOn8tqV0IwCehDckscyC0Fg8QaQRi91BEcQDUzzI5eMhL/D4iQ4fQ0g1fhCB4E0+6j/c/s8+l9zXDvQ7PRycLxWTN8ddD9Eu3WM3CAHJqPL29mtVSW0MLNdhXExAwnAT9ZOkm8Afod7U8IMqWc8LK2g2n4/FOfOMbRuGIrW5ZFPZvjkkwwKlI2UW78hwZwvXfNJYh2Z9ZTCvKtg+rNBKm6u5GXsv1sBJgkznMithPO0gWxYwhELiAKG7wvjN/D1kKc2AjLOh0lgdCcPRePVs+lKs6Fr6AMQD9mXwVMKoYJYLnuKUt/0ggVvhF9ck+8JfEua3cWOb5mWDl50h+NRjTlvMyey+VhFmGjkA3pHCJP83R0C2dbHy9sH+Qt4jefELEs2vgOHRCF7qnMRqEoiXf98qnJjplZMbT3vGFpCx4V6Cj6/IURWP1tGxgRUxXHxX2tl5rSxT4faCEYwnRkVAFAQzCU2ayJFFH591EW8LOuOBt6IEE3IGHkLj4tpmgWEqLDit6Ej7nMCp8SacDxZ+cZwiQHuvaC6Xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gG0Cno96+m2hFIx7jN8SPSRA8mj9ujp2Bl6HMK8uuyzsXpTfyJON+n0SLXKHOUpk6UpmsH1AOfBPBpG4NV5n3Zmb4pZIZg2t+fllUmfD/hNQLzkvt/XYIl3ho0gXGrmxaSCCiMm8RUdiH2x6uyL9xJJncgHbTt7N8hKK0G0oixcQV+79XnccKWZkh9E9bQIiB8H8zTCFGh9bUNY9uRp70Nc2isUYT7nViAKBQPPEviFg99ldNZDDYLJwkOLXSwtPrVrRdehTFW5DQ82pZLmCYJEHSVMsECsEb7u2hVwwCqbLlSwYCLKjAiuq2eZE8TaYb6NmrDBRg52onKPO/jfOpc1OkYCyhk0JarIV1RG81ajQuvzeK1DsAHTy7ycWJeR0m8Bt4subAKuA7QxlveaGrPz/Aoixpnpn/fX7tI7wUulU/5vA9N+mommq0JIK5ZC+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 09:37:15.3501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8428c644-b1e1-4168-5ed9-08def142cdac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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

Creating a user queue can race with a GPU reset. While recovery holds
reset_domain->sem for write, MES is unresponsive, so the ADD_QUEUE from
amdgpu_userq_map_helper() times out (-110) and an otherwise valid queue
create fails:

  amdgpu: MES(0) failed to respond to msg=ADD_QUEUE
  [drm:mes_userq_map [amdgpu]] *ERROR* Failed to map queue in HW, err (-110)
  amdgpu: [drm] *ERROR* ... Failed to map Queue
  amdgpu: [drm] *ERROR* ... Failed to create usermode queue

Take reset_domain->sem for read around the map so it runs only once MES
is back up. This mirrors amdgpu_userq_cleanup() and honors the
userq_mutex -> reset_domain->sem order; the reset path never takes
userq_mutex, so there is no deadlock.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 652599f08990..770635ab5298 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -745,7 +745,12 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (!adev->userq_halt_for_enforce_isolation ||
 	    ((queue->queue_type != AMDGPU_HW_IP_GFX) &&
 	     (queue->queue_type != AMDGPU_HW_IP_COMPUTE))) {
+		/* Serialize the map against an in-progress GPU reset (MES is
+		 * unresponsive during recovery), matching amdgpu_userq_cleanup().
+		 */
+		down_read(&adev->reset_domain->sem);
 		r = amdgpu_userq_map_helper(queue);
+		up_read(&adev->reset_domain->sem);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
 			trace_amdgpu_userq_create_end(queue, r);
-- 
2.49.0

