Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CEBF33A7F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 15:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D414810EC38;
	Thu,  5 Mar 2026 15:06:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="14L2paF5";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8080210EC18
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 15:06:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgvU/E2EbtY/M3S0slv7LOsk3TNJ5ejwzu7O2O8EeeEYZ+JKbGHd/0MrDUd7peeYo52XkeFMjjncjPGC1xPuxhGzCbhx66DAu0iRTXRlkpzYiE0GGmLls0vyrfAmeGjkDXzGcAlKFUj44YaSOuJ5XMJU1zuoRfSYuplOiEOSURiELvUTBk/jsNRr//BHI4C3fS8hS23alfuQRGxMt4psdWA/zKXP/eg5t4itKsdqp5Z0iYFiwE8KI7Cnw+urEOBByx/lOZ/4/eyLh+sSxcTDD6e+uufGNpUhmLJIyIcEbfv/6isqAxiVR6xRRBvu6o+EFGT4877jjeeGJkfeFvDp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+0vS5ek2tUfY2D/AKYAMQUqu6eKwEPsJamY9H5EIbk=;
 b=J/A/ph9njA2XruCMosCFkI1MgS9lx6QBXkpFarg/U1/8MQx2lLf/ULPCVg6kq+gsiMlK1Si/HKmm4qQGegsrxuZ9qAGypJ+h7PhShZjCCyXiMl9R1C0SzJpgO+6uuBW7u6JMwJcHKXcJT4aAVlhZNaSVRTFh8vzq1CplI1DPdjrwSWA06WIAwo/Mi3a0pcYRbYzMU0VPtHpHnSAl2dGGuyU9M7xZZIPZbMfkw74XO8Y1/WhlpxUCI7eZSHSqGa01IycSX3Xc+h8GvIwtsaewqBxyJ8JQG2j9Y7QJpFf3IAjwcZLgt5aBw2Vl8lyf4q9AdOTyHGRPlfjUjhVgj0UhQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+0vS5ek2tUfY2D/AKYAMQUqu6eKwEPsJamY9H5EIbk=;
 b=14L2paF5IKF5P2jbfcCZuXfwhpDRuzQu+KUAzV4dDbKXsLbgKOm979PSpLAIW5bLDK28C+iqnRL1RAdG8EH5Q+5+/g7ZD2NQ0D2/ufDDzBXHfopSatv0x8Esqnf1CJp1zx6yRQvNnWQjdjxFCyd7e9H/kMAz0p0D99LKfjyqfds=
Received: from SA0PR11CA0063.namprd11.prod.outlook.com (2603:10b6:806:d2::8)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 5 Mar
 2026 15:06:24 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::fe) by SA0PR11CA0063.outlook.office365.com
 (2603:10b6:806:d2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Thu,
 5 Mar 2026 15:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 15:06:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 09:06:24 -0600
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Mar 2026 07:06:23 -0800
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Fix a few more NULL pointer dereference in device
 cleanup
Date: Thu, 5 Mar 2026 09:06:11 -0600
Message-ID: <20260305150611.1166241-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 82887c93-fd66-4f6b-bae5-08de7ac8c4bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: jFNVVotXfgCGFwqb0htTf3gNIwQ7AZn0J3lelY5igkWX9VeAvMRmMoeW9vHR1Nqn5p6NQSmDnvr7uvcBeyFpzio4yQgpuyIUP57rf4nv0Qgi2iglVdahQuy/Yx8jt5iijeXcSErOsGHSriH+gB28hsrECISo0zn0Inu5UkGp0mBZLnU1tRZwh8mSRXPOn7D8EJ2DHvvbOd8pdgg0YFDK2JVmlbJuXUxtTRNyTJcFL8csJD19Dv5VKL2E0nVXyxgvACLygMKYj9LF3089Tr0VZuqyUIkZ8HyuE3NiEehBbHoU9hxtERLffPQdbaSyluedmQlMYGBBNU054Be03R65SG92mqCbt4VFAamZB+Tx0efmHtZsZjnvqF7ZeNYbly6wjI6NelzaPOFgKmFill0Zpv9elhF7kgd3+zNBRBBGmwII64g9R10T0NDreTD7xOPe/JO0q+Lc40C0XmuJSngjR1xzIkn3eVEgq9lMezoHLP3eq2cZMnPEVVs/mBCK3dSi9HSWfZc4DqFRY8VL+BUHnmB5KIXs3UyHJHbh0pGr0j7apmy3yFNVmt79OcZTHIgFvuHP+zEhGsuwWGOlEN2j+gGiTwt+FvxAR63fi3RB2P7qQ3LDab0/b1yhms/5P3kYc9oXSm/f3AHlbheJKbEA5BNzXvvd5P0ZZssUwHqYNXtac/QX1ugvpGff8Cr9HYyeFQRBV8cTGNfJCwSSA3SHLamrmvyN/tbsgpte0Rh/Pe/PI26XyVwpHvt3/u1uc7rilXdMwiQMyBZ+qNQFD/Z/gQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qBlxJzHXsoy8JFemklQlUYWHf0q6ttVIYtAzFNp4kdtAAWJ+bLI3tCYRo6IfsK/rkV3uQDDS8g8qY5rtaHeky5vOFUADuQWh/jvQaOrEh+j6f+fQ7IV7SWORQy/JQzT+Y46BfGSbem/kpRkl/zUNotSqrcTHRbriFURdXTDCjLrYdXb9p363bcNWt3t2u5XYujssKbXxsEXPH24vQw4muwnLF5c0NApRJ2TRZ23mtKJqSlRH+NS/VlVXqKnb53NMRSP9I9LSxVy3vjdVGUbpsAMzspuBgTgLD6e7ICdD9BD+m3GpP+1X0qCO0JwoiOwqHs4HzgFeDVIRysMm9rTdLgjyxhX81k12BoMX4UC+TYWDgeOEsONYtm5f5wf0kpNw+C4jGisfvXvZQsA3L1tY0e/JRLzSOqxrsoySalYqAP50oy3hgo+9Q1MTiIimvy0D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 15:06:24.5357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82887c93-fd66-4f6b-bae5-08de7ac8c4bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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

I found a few more paths that cleanup fails due to a NULL version pointer
on unsupported hardware.

Add NULL checks as applicable.

Fixes: 39fc2bc4da00 ("drm/amdgpu: Protect GPU register accesses in powergated state in some paths")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 258391ddee7c9..bc6f714e8763a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3508,6 +3508,8 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	int i, r;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].version)
+			continue;
 		if (!adev->ip_blocks[i].version->funcs->early_fini)
 			continue;
 
@@ -3585,6 +3587,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 		if (!adev->ip_blocks[i].status.sw)
 			continue;
 
+		if (!adev->ip_blocks[i].version)
+			continue;
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
 			amdgpu_ucode_free_bo(adev);
 			amdgpu_free_static_csa(&adev->virt.csa_obj);
@@ -3611,6 +3615,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.late_initialized)
 			continue;
+		if (!adev->ip_blocks[i].version)
+			continue;
 		if (adev->ip_blocks[i].version->funcs->late_fini)
 			adev->ip_blocks[i].version->funcs->late_fini(&adev->ip_blocks[i]);
 		adev->ip_blocks[i].status.late_initialized = false;
-- 
2.53.0

