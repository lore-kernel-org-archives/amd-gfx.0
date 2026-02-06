Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E496BEE20AA
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B16610E7BF;
	Fri,  6 Feb 2026 14:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IDQ+uhrS";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56D3C10E7BF
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 14:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8mmV3XNm7tw2osow5dFn27aQSCbjsgLb6VcwtseI3tMPeEF5itlyJc5RqUuZ+GBT9+Gne6VHBIol3h55HOfvQXrihOLrlgMa2QcVIXxS5lyDaoJ/kehqKLztFtrXj9Zm1wwMFCw/+QbKM8WgiqU1vW5lBLZTCjFQveIdBus1p4gXkL87G2Ase8wMOKuhEkn6qHSXQMBM+r5Z+31H9VnFcxFHOqyThe8EHDNaKucYsxk8ug1K2wYTu1fE2R6qebup3JVSX2AMochqUznALBodfyEd7sMWDO3fAZI/BB3cYeCYshUVqRyEw3G9kx6KcFuXOrYcFmgiHmhw/bUxpTV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5SCsxkQOm70JLamsQxcXwsRlO+XJYDLPPFbXw6qL/M=;
 b=IgYKDzMVbZ5nc8dW4FUFiAMd+EX1ZGqHrZ9okTPXoXCiB+gP2a7sZ5sxtXUOzqhuxzXf1BUDkOS2r29ldszVgsrv/Jv3Q7o5E82g1JjIU6MbfuFcWTLWUdVZeMwV+9nt91Id5/J7BdbZ3z2VHhlHi0iMSz5zAP8J0ZdwH2o9AuAnT9EhrxFa89Mc2CNLRsWq2oOElNE79ULkN7if4m+1XPd8L1I181z25c7Fm69Q7Vq3nYDPVYbZeqPTT4jyOmKCdOmQ9/0EYz/5uiaEpf0X0AiltIkEE5EXmAD/0gjA9rUPvTVT78vBeb4pAdTeBp3hDyD6wfr2ayENq1Mj/nUmUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5SCsxkQOm70JLamsQxcXwsRlO+XJYDLPPFbXw6qL/M=;
 b=IDQ+uhrScv8EwKwgfalwbJ80D2Wf78TwvtXE5WJzsQCKGARhBt0M7bCDNnvZhrhpb5br2X1zYeaOnnBVgxCyMRE9Xrl6KvUOJlKo1LTXPih//1vZAUP+8HeG4w9WdZKuGeP5IVpmm3HpLvgOkAriiIG6TSneWTmeC4PrMtPGSwM=
Received: from BY3PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:217::10)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 14:15:25 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::a5) by BY3PR04CA0005.outlook.office365.com
 (2603:10b6:a03:217::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:15:25 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 6 Feb 2026 08:15:22 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Jonathan Kim <jonathan.kim@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Fix watch_id bounds checking in debug address
 watch
Date: Fri, 6 Feb 2026 19:45:07 +0530
Message-ID: <20260206141507.1475882-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: d672bb59-d1db-4269-114d-08de658a2c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MU1wODZVaWFkbzdoTmNvNEdKNm5DeWwwbDR1TmQ1bnNxNzZvUG5POWJnODFq?=
 =?utf-8?B?RGJHaFdNeGlVNzZ1UkoyWXVXZXBpL0NCMmlrQUFiR0NrS3IrWkhrZ29ERFUz?=
 =?utf-8?B?M0RHREp5eXRZWnF6RmlwdDdIbWNEM3FXSVhHSTRNcFF0V1ArU0kvNjhIZXVy?=
 =?utf-8?B?Rk5BbVZNQ3VQUm82MHRVVmhHUWF1anJEMmNMbDlNandWNlRHTnRVMVFHRDFI?=
 =?utf-8?B?NnMxVU5XbjdxeGU3djZqN3pROEFnN2QvWGF0ZWFPNVlWY1FGUnZXYlJoWVh4?=
 =?utf-8?B?WUhLS3prYVgyOXJHdlpoWDlWZ2p2c0FhZSs5T2xCT1FqTmJJVnh1cGJUMUo2?=
 =?utf-8?B?bDFxNExLSnVmcmxncUgvYkpnRHlncERNdktNZWFqeXRGMzNwWk9PRGxweEpD?=
 =?utf-8?B?Y3VZMFA0Uk50NkxUaGdBdUZzVHR0NWI1UnYydlJvYmNKZThESXR1Z3pjdklr?=
 =?utf-8?B?ZjZoNWlZWUN2N2srRmxoekxlMkxHTjJZRi9XNU43RVNKTFBwWDlvb0kwWTlF?=
 =?utf-8?B?ZENJMlZtK1BGdVQ3V3lIaVZIZ0toNG52TUw2dzZ5S05peDJnTnlkbHVqTEVG?=
 =?utf-8?B?b0d2b0JvbEJlNFhPSWdxdnJrZ1piS1lpWU1PdXpTVVZmZUNwRWwzMDJ4S0NM?=
 =?utf-8?B?TWtMeHhoVVhVM0NaOVIrRWNBVjZiRENYblhhWjdtTEY0TGdYcVdCYVU2RDlU?=
 =?utf-8?B?alNob3U3Sk5TOXNwaXRRbWpNTjRxZWxMWmF5RU0xTDU0VHhaeS9yUldYdTJG?=
 =?utf-8?B?SFJLTjh5Q0tWbVlRK2lVV1ozbC9vSXR6eDcyajN2R0hrTi9URUpsSkwzWTFx?=
 =?utf-8?B?Q3Yzd2FGR0wrbm9rZFJJbVErMWZyWWN3Nm9RYmVGcy9Ud2hvNHhjRkFnZWtZ?=
 =?utf-8?B?ZzJTaUJDN0dNVXFPNTFyQ0pQUWxqMjUvQVdITUt0WndCbHdPaVFEODI3UkJ4?=
 =?utf-8?B?Vnhyd2lFWHh4SWlsWW9IWlU0b2dNV1gyaWJjWHM3Mk5id1FwV2N1Q2dRcm84?=
 =?utf-8?B?NGJXdG1lWG41blRFaHM4dVEvbG4yVmMvQXZDbkVpVm5KZHdVb1ducUNtNUFD?=
 =?utf-8?B?RXVtWElzRG03S1FYN1lXZ21ZZXAvZE9XUGs1N0h4QitOZ2VNQ0drQlcxd3Aw?=
 =?utf-8?B?UElIQXJpNnhoOFNzWjVCNDA5UjQ5eWJsc1pKNzVIeGgwdExPZFY4SmMvTmR1?=
 =?utf-8?B?emQ5QWZjR2JScDBYUEN2ZXAwblFMQy8yM2F4VXNOMkNDdSt1eDR3d09KUG9C?=
 =?utf-8?B?L2F4ZFVXWFRuZFlLRERpTTlIVmRqMzdwdTV2S3ppU090RGlGZDVBU3ZEbHRz?=
 =?utf-8?B?QngvMTJBQWNJa240MjIyTUNMblNKS1hZdFVQQjc2Q20yT0o0Q2F6akZTOE04?=
 =?utf-8?B?UHF4SkRrcXh4bytGeVRMWGxTMS9RS0FFdHdrUWsvdnBlV2M0NGRzWmRuNk02?=
 =?utf-8?B?SVZDR1BQQ2lJZE1tT3JuYU9YanFCQUJzM2Vxc2tHZSt1QktYWHZ3NWo4WGlQ?=
 =?utf-8?B?bWNhN0dFNTFTWjdJWG85UDVJRzB5eVdGbExXaS90Ris4cEZDajJJTFRxY0pX?=
 =?utf-8?B?bGpNcDg1K1hzSlEraitnVlRNOXdHZ0RjbkNxZm5iS0ZoY2ZTd0tNSU5KSlpC?=
 =?utf-8?B?YVZIU3JFUnBpa1VoUHBOcVovT0tBYjhFQXJUZU5KcHVSa1BqYjIrUDBQbk1V?=
 =?utf-8?B?K0V4SitYRnd6VVFqT3EyK1JGSlZQdFVMajBPdEhGb1FKTEZmdkxDZm1hNlZ3?=
 =?utf-8?B?M24zaG0wYjhiSEpsMGxycTJOWDhGaEVRRjhPSzR5eXVRWWVuVDVDdWFFVGRy?=
 =?utf-8?B?KzU5c3pKWVhzYnpBNnhudnEzOWcrVmJoSWJKYVFpR1RKbjBubkNVLzlsSGhq?=
 =?utf-8?B?M0hBUlVUdWYzVkRoY0ZURzFKZTlNd0tGWXpLUWh0b1dGcllWZ3ovZ3E2NFZq?=
 =?utf-8?B?Qk9ldEtGRWlncmRSK2poNXM4aTJxd0FNQVYxSFJpc0tyZFZaN0pIWGFFejVl?=
 =?utf-8?B?cm0xK0VpY1BXZGVGSjUyejMxRXFHL1VjeGQ5RldpRUNUU01aZ1VNU1kvUnVu?=
 =?utf-8?B?dW9seFhiK2l4bnY1Umw4VHJMaDRjMjZHLzQrdUIzTGNpdDhjK01aaHRodXp6?=
 =?utf-8?B?WGlpcXo5eDZXYjBtbXdPWDdDWnFlcWhyZnNtd2hjeURDMEtlTkg1KzBjYSt2?=
 =?utf-8?B?Z2l2MGNYQnN2VU9uMFhJMDNqOEdVUWhxbUFJenZGUTN2Ykt3ZE5iRWlrSUk2?=
 =?utf-8?B?dHRNMHFuZXNLQUtDandFbkQ2QmNnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3lqe4mOTsScEMjN1cqAfWyGJCxVnEFAaSjl6Es+W/ihwsNeE0Nk9HUy8VLWAQ2M6o06PEZ48+F0OoSSGnyQOwULdGQo6bPXuK5IIEdJNWpj9TqUBunSzoHph75pcTdagefNP3m9VkW7F4Np++bEPRvFRKphEQIQ8Z2KdZX4pBgr8EO60kODQRpImivxmmdLvNpJvHFtzohti6rqAhX32R2IoKwM5VfcHw86OLosoAvJeTggDc1X0IDtMO/EFFGf3y1vo9iEeNv2o0gES2SsPS1LMfY8og1CByqFBKaxPDKcVRORRsU4z2+ueV4538kJ0Ztu9ZzquHeMFW8WIR9koBxqT4kWC5qzZRGUvg5z1TsCwLupdVpX2NVtHEWv8ISLnOH4P9nPMYFu9uAy5TWg9CvmVlq7OUVLBRRJHEG4RiBF8mk/4QTsp1J5xhaVn9ULu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:15:25.0800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d672bb59-d1db-4269-114d-08de658a2c0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
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

The address watch clear code receives watch_id as an unsigned value
(u32), but some helper functions were using a signed int and checked
bits by shifting with watch_id.

If a very large watch_id is passed from userspace, it can be converted
to a negative value.  This can cause invalid shifts and may access
memory outside the watch_points array.

Fix this by checking that watch_id is within MAX_WATCH_ADDRESSES before
using it.  Also use BIT(watch_id) to test and clear bits safely.

This keeps the behavior unchanged for valid watch IDs and avoids
undefined behavior for invalid ones.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_debug.c:448
kfd_dbg_trap_clear_dev_address_watch() error: buffer overflow
'pdd->watch_points' 4 <= u32max user_rl='0-3,2147483648-u32max' uncapped

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_debug.c
    433 int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
    434                                         uint32_t watch_id)
    435 {
    436         int r;
    437
    438         if (!kfd_dbg_owns_dev_watch_id(pdd, watch_id))

kfd_dbg_owns_dev_watch_id() doesn't check for negative values so if
watch_id is larger than INT_MAX it leads to a buffer overflow.
(Negative shifts are undefined).

    439                 return -EINVAL;
    440
    441         if (!pdd->dev->kfd->shared_resources.enable_mes) {
    442                 r = debug_lock_and_unmap(pdd->dev->dqm);
    443                 if (r)
    444                         return r;
    445         }
    446
    447         amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
--> 448         pdd->watch_points[watch_id] = pdd->dev->kfd2kgd->clear_address_watch(
    449                                                         pdd->dev->adev,
    450                                                         watch_id);

Fixes: e0f85f4690d0 ("drm/amdkfd: add debug set and clear address watch points operation")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jonathan Kim <jonathan.kim@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 1dae317858e9..91ede56890d2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -404,27 +404,24 @@ static int kfd_dbg_get_dev_watch_id(struct kfd_process_device *pdd, int *watch_i
 	return -ENOMEM;
 }
 
-static void kfd_dbg_clear_dev_watch_id(struct kfd_process_device *pdd, int watch_id)
+static void kfd_dbg_clear_dev_watch_id(struct kfd_process_device *pdd, u32 watch_id)
 {
 	spin_lock(&pdd->dev->watch_points_lock);
-
-	/* process owns device watch point so safe to clear */
-	if ((pdd->alloc_watch_ids >> watch_id) & 0x1) {
-		pdd->alloc_watch_ids &= ~(0x1 << watch_id);
-		pdd->dev->alloc_watch_ids &= ~(0x1 << watch_id);
+	if (watch_id < MAX_WATCH_ADDRESSES &&
+	    (pdd->alloc_watch_ids & BIT(watch_id))) {
+		pdd->alloc_watch_ids &= ~BIT(watch_id);
+		pdd->dev->alloc_watch_ids &= ~BIT(watch_id);
 	}
-
 	spin_unlock(&pdd->dev->watch_points_lock);
 }
 
-static bool kfd_dbg_owns_dev_watch_id(struct kfd_process_device *pdd, int watch_id)
+static bool kfd_dbg_owns_dev_watch_id(struct kfd_process_device *pdd, u32 watch_id)
 {
 	bool owns_watch_id = false;
 
 	spin_lock(&pdd->dev->watch_points_lock);
-	owns_watch_id = watch_id < MAX_WATCH_ADDRESSES &&
-			((pdd->alloc_watch_ids >> watch_id) & 0x1);
-
+	if (watch_id < MAX_WATCH_ADDRESSES)
+		owns_watch_id = pdd->alloc_watch_ids & BIT(watch_id);
 	spin_unlock(&pdd->dev->watch_points_lock);
 
 	return owns_watch_id;
@@ -435,6 +432,8 @@ int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
 {
 	int r;
 
+	if (watch_id >= MAX_WATCH_ADDRESSES)
+		return -EINVAL;
 	if (!kfd_dbg_owns_dev_watch_id(pdd, watch_id))
 		return -EINVAL;
 
-- 
2.34.1

