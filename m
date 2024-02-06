Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E359CC4829D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29618112CA4;
	Tue,  6 Feb 2024 15:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jyj8O1qd";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D0B10FD8A
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuLwDFwalQvJGaJGNzV247S27KNzRbI+ZAY+jaPrtmpFjgIXjvtJiR4h/p9Z2pkL4ILJBN87M3rKbglm42yrGzIdjm5N9t5nXwymYY2Tmr4xiiLYCOJ4O39ckKh3eAnhUQyzRhRNgDCfmS8BVU3SdzXSnl6QB2TKdbI7knrIpTT1F1ga0i6f5j0p7FK/DRXJ00kASHrMg+nywf0pd7C9h1xuvTZn+1PCGZXbAn28B8/+1CrqWkZ9qpF7LuqeWVU4tr3PEFIM1cWQwfs7RezR5caMDAz9kfnQqJah/5sYxQQXn/uBBPUae5r5oX77ndR6BkuJ1ADzbD0FsvzeuWbMCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yo1o0iUnE3fhPe5bSX8AtOU0Lyzj8VpNCYu+pRwhV8g=;
 b=HTwH6smYBthoLpRLRFhB2WhwfB00xqvmVUe3UWDZthGFg7+idaHjSb3lL9//Mo41yaOuZK0ETZN+Xs55SZpnH84h2bGCen27U6CBrvuQJc+QUBSYnhVX/l7jtaPnk0FOZEE80ITGgA/UFVSBB6zgywT+3ZFQHV5u1Oi6V90c7J3cknH8jdRh2qPt52FqeCgQ+fmrbaBVpnM0lrtqZS/0RCW8INELeFeD1Uo2h+v602WKT1Z/C8Ftt8KSu8AgtFqTgrY5lt9FIUGGF5lDzddVprs2P8zs9/SfgY0ngsJx2uFkul4WEayPjE6BqIlwtBvwn6MDd4Gv4Nl3b2/937whTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yo1o0iUnE3fhPe5bSX8AtOU0Lyzj8VpNCYu+pRwhV8g=;
 b=Jyj8O1qdd9I0Vf8Un8mgCdiNMg/hurMu9W0dt2NmQEJ3M2LyRA/JqaFz5zbV6EsiUloNOLgt4o30XECUYIiHGWdh/Elf3et2Xs9M+LhvbZF69+nWLY0P/tXcPJ7jR2jF0Fc6SbCrsn1sZVrFChtGy4G0zJTMyw7O0OtpEcxCfZQ=
Received: from SJ0PR03CA0211.namprd03.prod.outlook.com (2603:10b6:a03:39f::6)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Tue, 6 Feb
 2024 15:59:43 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::92) by SJ0PR03CA0211.outlook.office365.com
 (2603:10b6:a03:39f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:42 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:38 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 14/24] drm/amdkfd: trigger pc sampling trap for arcturus
Date: Tue, 6 Feb 2024 10:59:10 -0500
Message-ID: <20240206155920.3171418-15-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a46b9e-8724-4856-1115-08dc272ca1e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95hx38CGopw7FwXOVpxqLMD84iaISWiEl8MIPraeraU7sHAsCdGrJylxRO5QkTKID9euzKBlmFIkYjJ2cZ1tzkrd3cUkFqxRkRh+DJGR3lRziegtbEfDVcGaU0WMqguqyF4pyYK03C0isKaBoDpQMrTLrJ5m2ddwNNqtf0u5IRHP1y+EY4F9KF5ILiKw+dTFl8b9C0WZg/RTyhFIAKqKbFJwOqazvx37JWlkpXioPFI0d6edMWdjqbk7u1a9e8VPnHh8/Ur3JTn598e8en9eLb4btjZUXe+pVADTHv2PEcxlsHWv/GA5/7kif3drAN2j3OU3I/dfj7jNJTP1uaa7G++06e7l6E9R+E1DwgGtiEQxPNKdH+dAaq/VHezNlp5FL63A015xzxY9mebQYtiC5K0vyXRW5TLJAGcVQ514Zj9U/4r6j/xFqFMxZYoPABMuif+38x1N0u235wVCSD5Rz6F3WXZD7N/5wl21Xd+41AwzCMocMmoFzbKNsVEL0LxcquZ3DfTGqhJ3jYwR9CVdNY7f0zqe0yfOeyqWVPRKBGKj5rtAxgeXDMsXxpKxyUFrvl9J82xxhWRkYPIFY9+91HlkNZHD9/DIGmrgd/9f56Yjd0ArtiCPRZTBWM+eDbmvU1x2jXAg2hrkpVti3KAr0j8/UYLtsH0pYfzvF1ChKVhXWa4lAervfV019AwxRXp9EdKMXnoDjsLkvjYmFWLwtW/BurLQSnmXMR4FtganRuTx3YSREh9DN7YNDSA15Cwu4zxC1UdGbBVh1FG4YNW/tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(4326008)(5660300002)(478600001)(8936002)(6666004)(83380400001)(336012)(70586007)(70206006)(316002)(6916009)(47076005)(8676002)(16526019)(36756003)(41300700001)(82740400003)(26005)(54906003)(426003)(81166007)(2616005)(1076003)(36860700001)(356005)(86362001)(7696005)(2906002)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:42.6771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a46b9e-8724-4856-1115-08dc272ca1e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599
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

Implement trigger pc sampling trap for arcturus.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 0ba15dcbe4e1..10b362e072a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -390,6 +390,17 @@ static uint32_t kgd_arcturus_disable_debug_trap(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+static uint32_t kgd_arcturus_trigger_pc_sample_trap(struct amdgpu_device *adev,
+					    uint32_t vmid,
+					    uint32_t *target_simd,
+					    uint32_t *target_wave_slot,
+					    enum kfd_ioctl_pc_sample_method method)
+{
+	return kgd_gfx_v9_trigger_pc_sample_trap(adev, vmid, 10, 4,
+					target_simd, target_wave_slot, method);
+}
+
 const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -418,5 +429,6 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
-	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
+	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
+	.trigger_pc_sample_trap = kgd_arcturus_trigger_pc_sample_trap
 };
-- 
2.25.1

