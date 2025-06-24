Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3BCC7EE31
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 08:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF4210E528;
	Tue, 24 Jun 2025 08:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G50qIzeI";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D024A10E524
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 08:46:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aswqeus0GqyeSXysgb4Z4n2RyTlPFCgjoFQ9JySArdylh2Ml84Z48Dq4dE31msnNtCWyHNH9ght3CMSVrCFDcRc4YVTCdVmEcahJTwTRz5wJs2oRcebsXs7oOn6JERSUiBc2D0xpAu6lR6/2E5HXOHL30ZHvfSumEsDTYDjveZeO9sWnd/KGjDBWMW1NpWbq/fs9zv/dT9OqLoKqPzmWeiuozG7hvhxUv85XKAxDGu+k3OnTz+4l/2GOd6DELR8N5Iri4DG49u5GleKNm1K6SzGc25DfJyS0QwhevRspKXssQO1pNO6ynowWpq8jwOktV0vv+4ZvtFeuT4lpDIdpVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dm08ut3arInLzHaqrK3Ta6LqTHEsX5Q/lM48yH6R0Sg=;
 b=n3OazAWqJs5mRdJrhAiMt3mwvXD+B/T4VfUM5/4/X6G675U63fE0lssBJ1iB2RRE42znxS/00OqmFHL6O7A7ywT9IoClIp6Y55J9Zwdg8NEm5ThUTLXohRG2yTQZFXvDagyb/jvGtzB8rKbRWYjVZLjQh5NPbz0w+ePxElnsXwkYW5YT5VDpKPAokpPK6yUKyQs8BrRXWNAZkaBpFuxMDzi0BKSL5dkGuTtLcwTiBG1oWBNHX1iQvzVaXhTl1MtJPS9AhNf+Iv2vImATmjkPIdgK4NVAcSXxpzpzB9qKIQOSavNb+BYY0tfD7nR2xMb7sF2w2mewZF+sDcOZ/uEdYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dm08ut3arInLzHaqrK3Ta6LqTHEsX5Q/lM48yH6R0Sg=;
 b=G50qIzeIC5M9NWSyNdjxk80KdIgMBGQNZ/vIKrH+X6x+lGYTza74FlV79kvPSWz4q9I03uI9S8tSyFHPNkXnmeHqmo9fdR9AWcfcPzsh6NJ5moaFfAG2PRkjP3R3QXLafBJDIlYW15DUttqpUwOtZu3Bdw54h3XNq0KzjsqKmEo=
Received: from CY5PR20CA0028.namprd20.prod.outlook.com (2603:10b6:930:3::7) by
 MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 08:45:57 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:3:cafe::f5) by CY5PR20CA0028.outlook.office365.com
 (2603:10b6:930:3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 08:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 08:45:57 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 03:45:55 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v4 07/11] drm/amdgpu: add user queue vm identifier
Date: Tue, 24 Jun 2025 16:45:31 +0800
Message-ID: <20250624084535.1178476-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624084535.1178476-1-Prike.Liang@amd.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1a9c95-d53e-4e3a-e2c8-08ddb2fb898f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wpP32grZveiolz6UKhUn+lPI+aY+Sn3n6rVPw2yK0h6r8eOYeMGjY713PeXT?=
 =?us-ascii?Q?plThtw7mZOs0iTlp31HqaApYanrDmz3kVTQtTbrZadc2BBo2A4LfaqkYLeov?=
 =?us-ascii?Q?c9Wcxo0ztLOFz7wYuAqt2+TxuqDlWRy8UD08UN+m50SyYvu4t+eX4Rx0B3fh?=
 =?us-ascii?Q?5AL6bZ66Ks5wBZ5fa1hyd9ypll/fpu0CsibKiptWgU/0pwYJCmDodHHSaD7C?=
 =?us-ascii?Q?oW06T1/D8zJoByGvd5bxbX2JNL4ojglp9qZlUgOLwcGlWDEI8mVZgPhrgBn2?=
 =?us-ascii?Q?BB2E1DqKX52I1huRk+jRfiCJt9GYcSgyCpoMllNRccH5h79JHAZwZW5BhO5x?=
 =?us-ascii?Q?tXVtqYoPpONiRDy0giKwCHiOmVy8bTXprD77eOWLF2LYnHvoX6Sw+2VvL0Xj?=
 =?us-ascii?Q?ETmzBjPaiEDFlUyjSngcYxbV1h54HDx/TW5YIvpkWMbvrvtncnvix58X8DtI?=
 =?us-ascii?Q?/tvG1gp4t+2YOiy7O7fVuZZFAOkRXA2arn1eajl6mEh9GeGjXO8Ka8yYwaBD?=
 =?us-ascii?Q?NfVp2YhoFAvYiVconciUdMOYJA1V+4/jMN4evAKxXGTB9Bth4ivTQD41dNxd?=
 =?us-ascii?Q?9yXFHbai5XBwG2czCqiSrqpD7BoYt50VRe8eThCoy7OR99mdBIV3KRyPxr3R?=
 =?us-ascii?Q?TEK2snVKs8N383kfKayvRbjmyCtohuYdHCiNYw5s0g+IwKSux8GyYVkHnAx0?=
 =?us-ascii?Q?FkiOsS7jvqkh+C4k/x9FwQUN+ppuLYLq6Mnnw5+MbAWVRraHC3vm8Qw20rwx?=
 =?us-ascii?Q?olV2by/+hYkgJp9eeHqOzwIxlTFPXv2XEiQL13O5Z5xMmTto77FcjH6chhpG?=
 =?us-ascii?Q?bk0jHtxD654gQ/4/N1o39FDuUV5j0Ik3+5K1K5toqKDpNHnxXj30Njok1QAt?=
 =?us-ascii?Q?EUUTOzbfsiXqQVWNib2mtDNKrYHmRv20mVrpHjzOV5vvuQlkVhDiE2Jdwvt3?=
 =?us-ascii?Q?vb9sIGWo1uTJnxqIuHRCsZXc9ClfCPMvihofdJyFEFpl0sDStYJt86uA+2U8?=
 =?us-ascii?Q?37Ix8v4cLFeYAb2/1LeHKpZu9lYbZANYTtuc/x2OOY9Infinx6UIVFSlUcmU?=
 =?us-ascii?Q?tvsXCsP642dGsxVB6UW/ejR4JuuGm+sAVwjLIBouQ2bc7rO7ns6Cl5KbMXcq?=
 =?us-ascii?Q?2pYc9hwVAilDFXjCxX5Lf4waEg9lphIHrMDixzqxwBNYeeS3INGABS/ujVXA?=
 =?us-ascii?Q?vMxRKds08bgDBCnnEYEAXshphQlgHBpds+7rboZ5L5wsmtk7Xk1XR8tBEkoU?=
 =?us-ascii?Q?wCLKcvQddQNN2g59X72tcvxwyP2xvrbg5NyC95GmOG5iKkdVvd/NzEmncXlc?=
 =?us-ascii?Q?bgtiSJFP59erlgNpacA2/7fFRG4ikPPB8BiVeSbXilQLWU30UlMWb6Vviq2b?=
 =?us-ascii?Q?P6PAlRcUwLcFZK4BZw175OqMvN0vVrulo3pqMdb6Cn83ymhqK4SUdh1qO2gq?=
 =?us-ascii?Q?1Ttu16RhsMv7Y4PdBUP+cJSotPKqD8Ac/P+3mX3/ny7IEI/Ig1194jGAvJ1r?=
 =?us-ascii?Q?OonNHAE1FXKWnrKmRvu+FL0GuEWRVMCHIDfC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:45:57.0047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1a9c95-d53e-4e3a-e2c8-08ddb2fb898f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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

Add a user queue vm identifier for each userqueue
kms opt accessing.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 79b263c18eb1..0208c6b8a8e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -501,6 +501,8 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
+	fpriv->vm.is_userq_context = false;
+
 	return r;
 }
 
@@ -535,6 +537,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
 		AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
 
+	fpriv->vm.is_userq_context = true;
+
 	r = amdgpu_userq_priority_permit(filp, priority);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3911c78f8282..5e075e8f0ca3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2560,7 +2560,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
 
 	vm->is_compute_context = false;
-
+	vm->is_userq_context = false;
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 				    AMDGPU_VM_USE_CPU_FOR_GFX);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f3ad687125ad..1e3c0f85c98e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -422,7 +422,7 @@ struct amdgpu_vm {
 	struct ttm_lru_bulk_move lru_bulk_move;
 	/* Flag to indicate if VM is used for compute */
 	bool			is_compute_context;
-
+	bool			is_userq_context;
 	/* Memory partition number, -1 means any partition */
 	int8_t			mem_id;
 
-- 
2.34.1

