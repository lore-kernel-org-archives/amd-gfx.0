Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04650C0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 09:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A41A410E91E;
	Thu, 30 Jan 2025 09:53:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="scpAVrfx";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AEC210E92B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 09:53:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUklbzWR2sIu/KkEqf+MJvyr4fON8CWRacRDWMQyddejegwzBj6j6fJ3ac9EvGm1KbTcNAyMBNw1DEUyeDi2/1Ty/EWAwVJoBjNE/27ir3Ry5bUOqtTD12QV/098b0rEkTH9qdDgFieoDL/XkZKba1LxBNHCJz1D0sVI9WXCc1GaQv+RpXLB4wDO0X/2Ipbiw8XSYTbwzl9X3IwAm6CXsMJ6FS8fLots44NqD5t+fF4HQmRC3DJO2XruD9jtJYxKVtD8lEPLoBaBgRDN3WCftMYLiPhQUbrXuQcq9IdSSah4ze6vHvBQXeyIZSaSksrgAyeQhxcyjmR0WaPXonzQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wh5wjhCLjfgopfsYcxBRIdXn5/PWA8y8llVCinYEGnk=;
 b=mExOsptJd0FcrtMvM/X49CXRl+kedJR1zz/qyRV9g/TJ7qcTENJWnoghVL15CXyBWfVMWjw2r5iEN9wUGPXWKyvw593gNm2Ex5zbGc8iMqpmsIU0AQMaulblB6gbBU2/rEPpyumpR8NUrR/j8keYlEKNNTb4Tt0F+NcoDbNzJlSVAe+8P+AZdXDDbRb5aT91sGTFDQ2s3oULCqUNMibNmZqBCVFGtRpIM5Dcos5od2tJ3S0P/fGFcNezNxQ+OnITb/bdq6GNfvh5SpeKdJtFBgNp7VhS6T/ZZh0vZP1We62PbyPeGXmYkZd3c8s/GDvS/BIuEDJLJciKEx+SLSAb8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh5wjhCLjfgopfsYcxBRIdXn5/PWA8y8llVCinYEGnk=;
 b=scpAVrfx9EpR0eGmH1syICC7efOyBdxOQsA/vSZywlbVBy0/ZgDQnHnwlj1rGqxePUMcyfxNDmx61DnT4bNkh3+33rFNzfTjZa5YbQ9FoCG4CGjuiJvZP8eVtpEdRh2AAKLfHcJP8CYnIGYTA0DubWGklzb3Vk1X8GIDrQd/cXs=
Received: from SJ0PR03CA0204.namprd03.prod.outlook.com (2603:10b6:a03:2ef::29)
 by CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Thu, 30 Jan
 2025 09:53:30 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::ec) by SJ0PR03CA0204.outlook.office365.com
 (2603:10b6:a03:2ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 09:53:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 09:53:30 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 Jan 2025 03:53:28 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH v3 07/10] drm/amdgpu: Enable devcoredump for JPEG3_0_0
Date: Thu, 30 Jan 2025 15:21:10 +0530
Message-ID: <20250130095113.534630-8-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
References: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e940fbd-6649-44e5-ae6f-08dd4113f3eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2lCZnF4ZngrcnVsUENVdDllKzRpVDRNTGdxQXZ1SE1FeDdhYXR3ZGtCKzY0?=
 =?utf-8?B?eGtnclkzSlZHc0Y2Vy9aU005bTY2Q0svRzIySFJ2VXdDNWREOWdTNDJSRDdZ?=
 =?utf-8?B?b3d2b3BJV2U3ZEdPZ2gxTW5SdFJXaWxWQkFhY1FtTWJzRVdCU1R3WWM5SURI?=
 =?utf-8?B?Mjc1ZUpHRjY5aGhHSFdhSzBDQnJTL29SYUErZUswTmhleCtKMjgzb0FRVzBD?=
 =?utf-8?B?VHNlcy9pQ2R5YW4xVnJnem55dnBHd3BvbVd6NkR2QnEveFNtK3p3ZktiM0tC?=
 =?utf-8?B?WEtFZlVWaHF6NnNSUnFsWTZwRVV3QjlYbHNoQ1BqbWYva2lTdUtGTmpPRTZp?=
 =?utf-8?B?cjV3cllHNWNSSTR3Tm91a3VRVmJVT1R6VWJQMytzN0lrUGNkeGtDZHJwWXpo?=
 =?utf-8?B?aFVGM0ZDb0RLQzVEaVgwWUJqVmwrZy9jYmdEZlZFMHc4SmpQTnNqNTcwSEtQ?=
 =?utf-8?B?M1U1M1Q3M1daZEdXZ3djUkhORkFKSFhiR1hwbGFhb0wvc3Y0bDVIV1Jyd0Rk?=
 =?utf-8?B?cWpqUFZ6MGdPOTFMUlZDeFNIeTRVZGgxS0tEYmNORnRzcDJVZmppWjc3VHoy?=
 =?utf-8?B?WTJodGVzK3QzM1NReko2bkVTdWpLU0NDRmJwTk9KQ0FTRTBMWWl2L3VjeGFB?=
 =?utf-8?B?OXFwZ2FWd0R0US84NXgrOTJ2QVI5c0pLQlVYbzVVWlNkUmkwMzBZVTJBNmJZ?=
 =?utf-8?B?djdKVnBsZHRmN2Z3UE5wa0hrY1FvWVlkZ25IRGE4QnIxTndBOTRxaVpmVXhB?=
 =?utf-8?B?UG9wSmo5dDBRcXVvNmtoSXpqa0NDY1dhVDhJT25iWEJpejJoUTFJbEh2U01D?=
 =?utf-8?B?VG93Y0g3YnJnYVZCT1BFU2V5K3RiL3dYdXJlQURoekRadVk3ZStCU0t5cUZJ?=
 =?utf-8?B?RlBoaFNaM2dJTU55SFVUWitqZEN1NmI0TFhVNWhKVjRURU9rQXZQTXp5TXRH?=
 =?utf-8?B?TWczby9FNFVzY1hWR3pCZzdKcHQzVU9IcjYwRGVhR2JlelpuTlJRd21NVXZ4?=
 =?utf-8?B?dlBndkdhanRaMkRhVGREZkRkWXFvUEg4d1gxRUIyQXVTWjV6R0xOSlZLYzVp?=
 =?utf-8?B?N21KOU5oNUhlL3VrS3JCL09DQmdZRmJoa3ZhRGdqeStCaU9BUlFLWVRJVUpP?=
 =?utf-8?B?QTgzRUwwd1luNWU1MEZUS0NmbDN1eFRLdlR1eXpiU1oxUmJ0RWsyRVM1U2Y4?=
 =?utf-8?B?Tk13L1RuSXl3SXFVb1NaN3hhVnhJVXBxMHlLbEd0bDR0MGhHaDhBMmdhbnRC?=
 =?utf-8?B?c1l1aDNMY2xMZWhHRjFtVm9HS2JZZnRDc0c4Z2lOUUtXM2pNOTc4UWx6MDBH?=
 =?utf-8?B?Tkd0ek4rUWNQWE9iRlh4R21JYktGL2ZYS2ovMkJVRWZML1ZsTGFCUkZIcTJo?=
 =?utf-8?B?RUsyZHdWamVDd1hYN1AxK3RRS1RaQ3BrRmZoZHRtdVprMDhMUGEzelJaK1JK?=
 =?utf-8?B?WVNJRk42U3gyNXkzUXJ5QjFaVGd2YkZ4K3J4Qkt0YVFaZ0thRktVU2FveHlJ?=
 =?utf-8?B?NTBDSHJuOEpZK3RUSWg5QlB3Q1IrMWJPZ21kSVVKMTVzdUZlZU4yQ3pJemFG?=
 =?utf-8?B?bS9qbDl0TmkwSXZKZjh4dFdkZHFCTis3SFpCbjJSL0VmYXUrZHBLMlZIRWpz?=
 =?utf-8?B?ME4vV1c2Uit6ajhMQmxYcmNFdEw3TGlrdUttdE9uRm9FSlZnVmcySnRUUXJR?=
 =?utf-8?B?TDdYaVdlM05Lc2lQV1o0RXZPVzg4Q3BDM0FzMGtNTm5yZFNqUWdKRzJXVVJ0?=
 =?utf-8?B?VzdWTDRsMzAxVkZjazJkVkNLWG9tbktsOG1EVDdtcko1RTYrYXRmbkdtL0wy?=
 =?utf-8?B?cm42T2N5bzZaMTZFL2NHcTVWT0JNMGt0SDNQZ1NnMzNOUHRoRkd1VmhZMEJ0?=
 =?utf-8?B?aUNHRm1TZlp4bFBjY0xmekhlV1VNWlNQUDY4MEJPckRYOXREd0Q3WkV2VE1m?=
 =?utf-8?B?MzJoSHlWTnUwd3dxZWdYOE1Mc2lScDdiNVh2TFpzSndGMmIwaERkUk5nbGVm?=
 =?utf-8?B?OTZQS1A0QVh3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:53:30.7409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e940fbd-6649-44e5-ae6f-08dd4113f3eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444
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

Add register list and enable devcoredump for JPEG3_0_0

V2: (Lijo)
- remove version specific callbacks and use simplified helper functions

V3: (Lijo)
- move amdgpu_jpeg_reg_dump_fini() to sw_fini() and avoid the call here

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 4eca65ea9053..a4acb7cb7ea0 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -34,6 +34,22 @@
 
 #define mmUVD_JPEG_PITCH_INTERNAL_OFFSET	0x401f
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_3_0[] = {
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_CNTL),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_SIZE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_UV_PITCH),
+};
+
 static void jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v3_0_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
@@ -112,6 +128,10 @@ static int jpeg_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->jpeg.internal.jpeg_pitch[0] = mmUVD_JPEG_PITCH_INTERNAL_OFFSET;
 	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, mmUVD_JPEG_PITCH);
 
+	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_3_0, ARRAY_SIZE(jpeg_reg_list_3_0));
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -543,6 +563,8 @@ static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
 	.wait_for_idle = jpeg_v3_0_wait_for_idle,
 	.set_clockgating_state = jpeg_v3_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v3_0_set_powergating_state,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
-- 
2.25.1

