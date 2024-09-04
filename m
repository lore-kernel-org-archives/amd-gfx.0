Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05183CD3431
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 07:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 820C610E699;
	Wed,  4 Sep 2024 07:32:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NYgR0ce0";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05A7410E699
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 07:32:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSWZw450+nG0L6mYa+kMeC860oCTE+JNXoyyJ3mb/w5IAYwMRPJF6u7jX7+xWw92aOvl+rplz1ZvuEIeT/x7Vx8d6GZwD4Mu80uDsjJGhTkPXjj/7yFmyQOfLNl36V5NIU7qUJ4nk0OXNkLWtG+QOc4JCt0lbqZHXRxsPv67Qa3Pbm2wF+JRC5yZp040dZIGDKLRmubeF4iKWCb+SXvAoT8sz4KQiNVXoZ0kBb4EMDH/DVUT2NcrL6u+4RNT+lzhfiO2bBCuuNZ5OQr/fShr4JGorsi16l8gUfyklQfnPsdtzjWiomZj6BrKfwEpuLufBE73jLts3l/v+6WqZD/K4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2AsOTNZCkwTF5G76WdV+OupvlmbxQsWx/ptl0LyppE=;
 b=XRAlG9Y6PHz/IJVsOB4xgEDQ5N89VPvsOC15yJ/vM6MQKTbB3gUBzSCx+TK3dW6DBd68+dADqnSNnX3e5+82lOe/NduP4Ww4rjVpOwQ8pcDr0AwFVAiNZf6D9kJvZJOGEIcrscGF9JnnycmibrbgNs+P2yTA9KeJKIdVwd/c6qM5OcNzXXHxrWsI+DZcHkQST6/RyiacxM24yjE9hey8BCoaNpl/FPL4d98EBUKmp/Fr7zuFygN8XzQOExVpEfCenePnD6LGIF+2tXR2TufEeUBcqa2sljoAv/3swcjnPRiQcE/Ezw5sMHoaJaZQU1Yept8T8nvJsj94Z8U4Z9dR+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2AsOTNZCkwTF5G76WdV+OupvlmbxQsWx/ptl0LyppE=;
 b=NYgR0ce07Wd6ITXLrJMEfVw/ZHfKmgCawAPI+08dJXyrtDiqHq70obA+V6uc60OpaDXRrNvl3OVr/33Mc6sGDueJEq0H/J0+9D6CVKRjbsBRIWODbJuqkXBh/tu48+U6av8U+NM89XS4wLvs8gUKqbq1NxKQ4xBfvnp5RwcXpVY=
Received: from BN9PR03CA0239.namprd03.prod.outlook.com (2603:10b6:408:f8::34)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 07:32:44 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::8f) by BN9PR03CA0239.outlook.office365.com
 (2603:10b6:408:f8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 07:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 07:32:43 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 02:32:41 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix kdoc entry in 'amdgpu_vm_cpu_prepare'
Date: Wed, 4 Sep 2024 13:02:27 +0530
Message-ID: <20240904073227.1726831-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c170c61-5114-4a91-7d54-08dcccb3c39f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c25HaGZkZnJXbGVDa085UDNpZlFaanB1ZTZabVdkczFBcmlrVUJROGcxTDUv?=
 =?utf-8?B?SEtYSGJpNE1kMTJWUFhXVzRhUG1Cc2VSaGNoMldSRnZZbnp0WTdMU0VXWmhC?=
 =?utf-8?B?S2dGMkd5Y2IyQUw4VTh1aFhoMHVrSGhVQ0FsR09lTnN2MXNzWittVEM1MFVj?=
 =?utf-8?B?M2FVVzErV2FwYlU3SW1JZk5ocExZR25vam5ZNU5FUUhUcWFaMHVsNS9xbERE?=
 =?utf-8?B?dHhza0RUN2ZDaWRnZi9RQ2ltOStXclpRQnZ1Q3h5Q1VyZjVwWlpxRFZGblUr?=
 =?utf-8?B?TVJFYkFjQmlWeWZpWUplZUxCSUJRS3Z5ZGdpK3Q2NnQrdDlMTzdibHY2Q2ts?=
 =?utf-8?B?dERRQUdIdmszd2JKSzJQa3ZqdkRadE1iVTNud25wUGRxZkhmRWdSS1VrT2xX?=
 =?utf-8?B?S3hMRTNrWEhuWUtqU2xxRWlYN3RXdmk0UGV6MFFKZ05VYmlOU1dudVpNbm5B?=
 =?utf-8?B?dVkxR1htcDBydE5xanc0YmNyMnJ1WkxlTnM5ZHBRYUZUUk5pVHpHdHFoVSs3?=
 =?utf-8?B?MllPM25wdlhoOHppb1o0Y20xbm5DSTJkM3dBZXZUeDQrczE4eWFUT1F6ODdq?=
 =?utf-8?B?d0NhbHc3dmRmb1ZWN2czam15ako3WEIya1RhTVZLVGZ2dkMrTG11U1F4Vkhr?=
 =?utf-8?B?N0FKcndoN2NUMkVjb1h6WHhSQTFuSjdlcWU0cFhORFNiaDA3VkNjYWo4OVRJ?=
 =?utf-8?B?dGxUdlhjdVZPWUxqM2FWcHpHMjd6UmQxM2UxRUxMazFISDJPM1ZtRzBRR0F4?=
 =?utf-8?B?dVZoNytOTk1YWlFvajVOY1lkWGxXeHZsS2x1S2ZwTUxzWWZndWFwZGtCMXhp?=
 =?utf-8?B?NmVZdXpLOS9aYStpMUt6Nm9IajRBR0RyYzU3bXlVenhvTkpsMUJPbXA0dFk1?=
 =?utf-8?B?bUJOaHN2MmFtaW8vMzJyV0ZsREJ6cElxdmwxTG4xV3REeDRYNFlqbFRSOG1l?=
 =?utf-8?B?OFNwdXpVQ3FSRTIrR0szaVJEMGlGaEtlTFp3S2NGQzJUajVyQUx0U3p1clBm?=
 =?utf-8?B?U1hLbE1tc05yR3Z3UVBnWmJpdysxaHk4UTZjNjlkdGsyTzBTdndSa0lOUUFm?=
 =?utf-8?B?eEUzdlJVMXZocDZITllTWWM3YTFWS3BRQ2xVOHlSckpqUmpJRHg3eEE4Zndq?=
 =?utf-8?B?K3ZXdkdhKy9nRExTWDRqZGI3STNSSTNITU5YZ3Frcmwyb1UrTkNZWHoxU1Fx?=
 =?utf-8?B?QnVNY2dwbUJqRGpDYStBdmJwRlA4Wk5heWdBN3RwVTJlZnhNL3pkSDNaQ1pI?=
 =?utf-8?B?UEhKWWg1ZmNGOUhUY25DbU5ka3NwUk1iWmhKZmcxeG1YUUtkOUNIQlhzS2Z0?=
 =?utf-8?B?NEMzUUcvMGdOWFdzT3hDZG96S20ycXhDMnhzZW9ZTFNuVUppcWpOMTRKSFNt?=
 =?utf-8?B?WE1Lc3VaYlA1cWxlUktQTmhlRzM3VUdyOWlPcjFjTHF2VWZweUx5cmE2bktC?=
 =?utf-8?B?b3QyRE1NSEFrRUVaKzE4Z3dvZHdMVmdGLzgxWmhSOFYrdEJidkZyY0VyZEhy?=
 =?utf-8?B?T2R5bUNJbE5SMW83M2RHck9CUGdyZmtsVkgwNDUrS2ovUTM3UkhDNUJhSjJN?=
 =?utf-8?B?UGppaW54MlJtZEl3ZkxZV3FkNTN4cEdnT29tb0hGWGtEN3d1ZWRIZFVrNERT?=
 =?utf-8?B?R0ZaZlF1a3ZwWjVxeWM1d2pDK2tpaXFGRDlXYW4vR1Rnajk2ODl3dUZqTGVW?=
 =?utf-8?B?T2pNNXp5alp2NTdYNnJOWG0rbXQranl1V24vejFzNzdIU0VQVkI4RlJ2Rlh0?=
 =?utf-8?B?VHoyZXFGVU1jYTdYYTFPamRTeVVRaGNCRUIvRFZzSnBTbnZQS0Y5ZGdEaEQy?=
 =?utf-8?B?cmpUejhUbVhZRDVCNnRHd1kxSStqVlJjWFNlcURyQ2s4QWFUeU9PcWNrNEdN?=
 =?utf-8?B?SjBPOG5vaGgvMy9BN2wvaUI5SXkvTkhDNUdHMnVaS2VsaEtSOWl6QUZaWFd4?=
 =?utf-8?Q?culNeoYbInx9A8XNSEHbPXm0AFF3VBHf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:32:43.2208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c170c61-5114-4a91-7d54-08dcccb3c39f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848
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

This commit updates described non-existent parameters 'resv' and
'sync_mode', and failed to describe the existing 'sync' parameter.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c:50: warning: Function parameter or struct member 'sync' not described in 'amdgpu_vm_cpu_prepare'
drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c:50: warning: Excess function parameter 'resv' description in 'amdgpu_vm_cpu_prepare'
drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c:50: warning: Excess function parameter 'sync_mode' description in 'amdgpu_vm_cpu_prepare'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index 9ff59a4e6f15..29dbcdfeea8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -39,8 +39,7 @@ static int amdgpu_vm_cpu_map_table(struct amdgpu_bo_vm *table)
  * amdgpu_vm_cpu_prepare - prepare page table update with the CPU
  *
  * @p: see amdgpu_vm_update_params definition
- * @resv: reservation object with embedded fence
- * @sync_mode: synchronization mode
+ * @sync: synchronization mode
  *
  * Returns:
  * Negativ errno, 0 for success.
-- 
2.34.1

