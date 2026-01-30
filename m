Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8ED7D49C7D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 08:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 553FF10E973;
	Fri, 30 Jan 2026 08:42:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MK7lOP1Y";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013031.outbound.protection.outlook.com
 [40.107.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB24B10E973
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 08:42:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdXWy/ylfn2z1Z4udNJxXOvI1vMwbhq8CskdfI0oi/ElbFBxLm1WoDN9ZRnHakM6nl72zbUWLoKiL03FbNK8giES+z7NngEcnK1uODvZubfID/rYNFYWRpSU2sfm/OnctMq6j25mVEJ2t8eVLgh9iMU1Zgn1FRXbt1BiL05Vt3eOes1yzisjeFzMXifTZXvqdYi0DsPfyGJJIhMafqfohBq0qPPGI1AWPYzGYCHfMrpwWYKap2WX6EDIEYKks7jqcu9W4Wzu2WAFu7fxrpc3gQbeACk2vo8C5dsBnEFqU79QdQmo2HhMo42vv0sNvnGwmHPCZiXMeF1WswjQOD2ETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aebQMl88uPRJxOYl6N98uQwzbK8cOv/4G6ixnU3mQRU=;
 b=ZucjlW6sIC7x3DpG1K5OImhAjNP6xBAcVONY6SI/aaLlTPTV2Ko6Y/zNqrUsCYW1S8kyf0UzMvoZyA5h6C3potTWbbHBFRw4b83kJKJLKvxilrNCQqgDIhx2P9a/0v6b/TsHw6Gsaef0DwBsdpu6roQ7m4goNYStPy79JNfrmyudUvFB+JAi6dGkP1+MegJSK2Xi+SpLAeldYnx5vd7u49Yu0XjGsb+2a7t8+0NQ9V+/0bfstUnhrbNbApK3W92th3TJuZ4UfGvsp/K88OHYkFvcDAReZs3g5fUoxzQWCbppFtH31hsBKLMexi7PlUNOlIU4FEmagVGzQBBxf+nqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aebQMl88uPRJxOYl6N98uQwzbK8cOv/4G6ixnU3mQRU=;
 b=MK7lOP1YnEMIes07wm5hs5ccNMuBbyYCopdubBRErgv/dpHRDkV2AydrWb5K3Pa6n/lwxnCBa1VAumWcpHRQ4xkjELMQ6Up4m4SBQfz+BEEK2eJ4asxwWH4t9FfEP8IN0sOq3ocKSwshDppWx7cEyNcETUXTUESgBZQ+vne/eV8=
Received: from BYAPR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:74::19)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 08:42:14 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::78) by BYAPR05CA0042.outlook.office365.com
 (2603:10b6:a03:74::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.4 via Frontend Transport; Fri,
 30 Jan 2026 08:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 08:42:14 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 02:42:11 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <David.YatSin@amd.com>, <Lancelot.Six@amd.com>,
 <jonathan.kim@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH v5 04/11] drm/amdgpu: Add user save area params validation
Date: Fri, 30 Jan 2026 14:07:58 +0530
Message-ID: <20260130084137.2906792-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260130084137.2906792-1-lijo.lazar@amd.com>
References: <20260130084137.2906792-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 7011429c-6439-4beb-95b9-08de5fdb77d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LVg814YC9fi3N0x8J9cU0KLZ89Othi3xAADw91fWKKfuKshAkC9YEkfoh4HJ?=
 =?us-ascii?Q?dQjLEZJE6nOEq4ZJSuR0lyp1eE6odny8pl4EJkFGQjNkczd60NpNypUFZ5NG?=
 =?us-ascii?Q?WbVG0FxA7mSB60nJDk8e16y4Fv0/cqfspo3w1BaUig8wgvtPmWhc2JKLERYl?=
 =?us-ascii?Q?cL7VF0nBdUAqNpn2vj6wIPdubj5kByeeLLXeddUyeZCMDs6cyl3GuaWZ6ASL?=
 =?us-ascii?Q?u7xV5YkIbUqzXOWu/bd4cNKRxtx2s48wNUqV/iboXdXheXIouc80MWhGtIeC?=
 =?us-ascii?Q?BNzkAn/YNlevKzK6+V4VTESA3I68tTSvbKx5ecP0+D//6tK/0o6fYKN+i515?=
 =?us-ascii?Q?FDIGHMhmG3Q4XiPft4EqeVjSG0DT2sNH9SGfTMOUARzOOYmkpBh4hI8E+YSn?=
 =?us-ascii?Q?vtfUrX8OXEmWrDtJU+PIEeKLvp11LrdHfqkoBGBKy3Ir+6M+Q0zgYBFHB+E/?=
 =?us-ascii?Q?67UrVW6OkcMGwLb/pSxrU7AuJBAmsyDlCWt1RwBSRcckD9n2cWllWXZULYrQ?=
 =?us-ascii?Q?OXW0QKQiQlcmqOOsL/E2SgifvavqBPgmfeobzMgEjtRRx2qMKUwHHUc6JfLt?=
 =?us-ascii?Q?p8KxT3FApTA64UauEZ8pjLXWQEAN5J5U0jCRPN/pDCrljXRSStvFwATdnduk?=
 =?us-ascii?Q?Lg5NhwWxK85uNYhCdrbz4DuCu4MPp+QQjsAM2Nf2dM0Tp20ngAXU3c/mUMyE?=
 =?us-ascii?Q?XaeC//ghU8I5+nZ/O7SnFyhHIuoWf5w9NocOcTV0zJDB52RRGcCPImcb8ki9?=
 =?us-ascii?Q?I2ygF1xhj1ymjaOnj1nep4GXVSW0zlHkgnyDEKrM0l178JYAXUl1/nhO5mEb?=
 =?us-ascii?Q?vSJMUnfdnfHvB21T8KTKiVIim3XWKRdQgecrjOPEZCvzvS0gASKolgPkw2aW?=
 =?us-ascii?Q?2tFvVaQxXiq67sBfZGUduSeulzy9i/2Tamy85o/cdK0hMMsOZk/nyxs9BnPD?=
 =?us-ascii?Q?qVdSIWHSS1xQsjp7/bX1o7Dhr7wY0A87cSS9KCpg4VvzSFnrq/6CXuONOxiF?=
 =?us-ascii?Q?6DL3r1LAR8+V1V3aOsxnxG7ZC/ziguYbzdY+CLuOH2gjUeSs2Lnng7C+EpDx?=
 =?us-ascii?Q?FJrMH4KmBVIxdARbwK0MtC/ki7C/1lAxBB2170MeQb4k6h6nNJNdHMBcpWr0?=
 =?us-ascii?Q?GhUyayHl92jIBQFctsE6wWtiVFgbH3Sk55rleOWVNuXSuFbuulPY9Nwc2w0N?=
 =?us-ascii?Q?bv/5FGQ8zsTLcXofeYEIvGri/eMAowNtPxA/utHU5kkiCBPZi5ewDOT9mdXU?=
 =?us-ascii?Q?6n50Z6Kdu5xFUug3cYEUSNHjEID45PG1LCmuDhkMmHIgq7Ate2+O6rEHEexq?=
 =?us-ascii?Q?fkDQst/LE/U3ArpK0H7qXDzK0nHwqSg3OPKhk0ZP5tm4nm2LLeMZQS1l9BPi?=
 =?us-ascii?Q?ltZXQoA2NidjG+wfnTYsmLnSSqKs5E5tystQNO9H8M9m9jyG8blNgC9hrzBi?=
 =?us-ascii?Q?wRkwiIBEV+HPrf+G54ChvHMpnu5pXyBgK/t4OmYg8IZrmoTQxtpMLmAGxQDU?=
 =?us-ascii?Q?EJgiiivvGVdCO6v5E0Cdh6RsbfLzDh4+AH+t7IAhNCIBVEW7wklpW6RepOvI?=
 =?us-ascii?Q?AM1j5mJUMWR7QPRN4Y4i+lgxOxThE67UcZvlnOtFHnwgtPYZRRsLst43SXzx?=
 =?us-ascii?Q?vAezoLABWs74Hgd942yDDpXxM1eTMnVh/3OElD7043S5uRzwCJs0xfD2/RJa?=
 =?us-ascii?Q?7xmsXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zYhPjPJ0D77Cmvf5rC+2QLMqy+icswgn1kJuue5nFfaua1YkjwOvcaX6YupvPcTWaLX9k6fCGlZpHX8lchAdyeMDGca7XK4K1+amHQylRMBntQ3EZcaVimW2jSmySVwrVlbX1IA6rCZuVqLEbjenNv7C/+hOQ2JUYazokccdYOmMIUKaRVCsoBjHLBnll65k3fKbjH/jsXF3cBBy6GKsAsmVf+o5wfEvd5ws+IYMPbtN47CAHXIEMlFJun/agh3ClSsbhpETQTWcvFSg3MaClYd66yB+yQXhyR/kXv72xSBGzXzTSCASPZW1chu0WZ3+yjTZnWbhCj7cfmHPwoT+MnAnHftWZSBfoTV+KMfZYi4+JQfQLfeF0BllIj91fR4mnKhRoV5ZEFx3bUDKl96eEnjkjU6quuTwA0tpsQ5tIQkMrr5BMkqOzLbqDfpMf9bq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:42:14.4807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7011429c-6439-4beb-95b9-08de5fdb77d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853
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

Add an interface to validate user provided save area parameters. Address
validation is not done and expected to be done outside.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 39 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h | 10 ++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
index 80020fd33ce6..f4907172ebeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -64,6 +64,15 @@ static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
 	return true;
 }
 
+uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc)
+{
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return 0;
+
+	return num_xcc *
+	       (adev->cwsr_info->xcc_cwsr_sz + adev->cwsr_info->xcc_dbg_mem_sz);
+}
+
 static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
 					 struct amdgpu_cwsr_info *cwsr_info)
 {
@@ -425,6 +434,36 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return r;
 }
 
+int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
+				struct amdgpu_cwsr_params *cwsr_params,
+				int num_xcc)
+{
+	uint32_t min_size, max_size;
+
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return -EOPNOTSUPP;
+
+	if (!cwsr_params)
+		return -EINVAL;
+
+	min_size = amdgpu_cwsr_size_needed(adev, num_xcc);
+	max_size = 2 * min_size;
+	/*
+	 * Only save area size details checked. Address validation needs to be
+	 * carried out separately. User is expected to pass a cwsr buffer area
+	 * with size >= ctl stack size + wg data size + debug memory size
+	 */
+	if (cwsr_params->cwsr_sz < min_size ||
+	    cwsr_params->cwsr_sz > max_size) {
+		dev_dbg(adev->dev,
+			"queue cwsr size 0x%x should be within min %u : max %u\n",
+			cwsr_params->cwsr_sz, min_size, max_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		      struct amdgpu_cwsr_trap_obj **trap_obj)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
index 3c80d057bbed..7f922559e297 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -56,6 +56,12 @@ struct amdgpu_cwsr_info {
 	uint32_t xcc_cwsr_sz;
 };
 
+struct amdgpu_cwsr_params {
+	uint64_t ctx_save_area_address;
+	/* cwsr size info */
+	uint32_t cwsr_sz;
+};
+
 int amdgpu_cwsr_init(struct amdgpu_device *adev);
 void amdgpu_cwsr_fini(struct amdgpu_device *adev);
 
@@ -68,4 +74,8 @@ static inline bool amdgpu_cwsr_is_enabled(struct amdgpu_device *adev)
 	return adev->cwsr_info != NULL;
 }
 
+uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
+int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
+				struct amdgpu_cwsr_params *cwsr_params,
+				int num_xcc);
 #endif
-- 
2.49.0

