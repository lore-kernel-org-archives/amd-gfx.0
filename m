Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEFDC27C44
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 21:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D39D7112DFB;
	Thu, 30 May 2024 21:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Du2SDopA";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DACF9112007
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 21:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAJVyCRk6FmnEm0SxzSGta2IXhx4ELe30ovti0m++eQiSdCTV+ivfl8C3Gt/4hawIHEpg7PmtmEHKJhRoaHH8a+ljt7ldW7sj36aieXIFwst7uxkWQIsEUFYlYx6OHTvsKdGEZeBvpZFZ1yS0cL6hcg6DyQQiwyh1GqfNybq9+otuEb2JR/lzcHtPTvskDjAXvZtYPKWAfjbFfzpMYTxBTd69EZsdqG2Yo5/yErr/oc5BOP35V1IJENq1YU6Gc5SkF45eGPaU0kh5rS/Jt4wSHaWVQ0/bc5FgmEWTGnoXRhAtCZzDRJfhMzBmytwg5eWNE6c0zYnjfDuNlH4McvzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p60p6NUKH+g1fVUouFr6se1cpRATgLTqebzLE4eGImE=;
 b=ApFT+EXnbGBY6+3w6QsmlO0rtYc1OfUi+d2w4NaPY8liO/YkyVwmiOp9yUJezKeXaDpWv4WJ8EGKoFUUMGuL4m8FX2ZknGL0hPzf6csMlfg60CS2d4clcAAKig+HqFFOhiQmjnFHoqn815xadL7lJNGForLAZyGVcIAgiUIRsvbUdx7vWoAFRk4x+5/VhoKoftnkSIpGir1zh/MMhwVy3d33f63q7y9LuJB3Fi1SAAI8V3chxrFWs179IVFRGRJUri+YyTdGxSSS0LO+ad5B5EreZoyP4mcthWiqsdIJUry+FOedpetI83VYQg0r3IwxWqsIHv5U2Czlnu/SPeLyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p60p6NUKH+g1fVUouFr6se1cpRATgLTqebzLE4eGImE=;
 b=Du2SDopA/h/kGLLTVRBerKO0tvtMFso/SEysGIys7UqoRzx1sFRu328iUvT+em2P/t9Gpu9dH6iL/Ah6tnUBJz3GMjqx3o3eKH2KhvyE5h4sAZ/Di5xqwuFwdiq8VCpm2dzgLYeQUc1EvwWr2M4b4sAwn30txmRXXL5aQ75cJUw=
Received: from SA0PR11CA0132.namprd11.prod.outlook.com (2603:10b6:806:131::17)
 by CH3PR12MB8582.namprd12.prod.outlook.com (2603:10b6:610:163::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 30 May
 2024 21:48:28 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::79) by SA0PR11CA0132.outlook.office365.com
 (2603:10b6:806:131::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Thu, 30 May 2024 21:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 21:48:28 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 16:48:24 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v3 1/8] drm/amdgpu: add skip_hw_access checks for sriov
Date: Thu, 30 May 2024 17:47:58 -0400
Message-ID: <20240530214805.40970-2-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530214805.40970-1-Yunxiang.Li@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240530214805.40970-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|CH3PR12MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: e870bf5c-e764-4653-914f-08dc80f23dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEp0dXg3NWlnbExXUHpoM0tzR0QybDQ5ZndtMmJ0TCtNczYyVXpldmRxenZB?=
 =?utf-8?B?UzFndFFIUXNnY0JNYlErUEt2Q2JkQ3owcHk2WU13aDFCdVRDN3ZOY0MySFR5?=
 =?utf-8?B?SjkvTzV5d2E1ZzlxSmZsZ0hIdEtGQTdNWUpYUGR0LzlmZmkwdW9SNitLdG4w?=
 =?utf-8?B?N3F2TGUvR2EwL0Z5OW1zRWxGN1YvcTNMRnlPdTFpMG5iNS82RDA5QW9TMFJT?=
 =?utf-8?B?elhKN2hXMUVhUnk2ZUt2ei83bEJ3UXJldVBxZHpBL2xBL05LdUlVczhjZXQw?=
 =?utf-8?B?K2s5cFF1UThnN1pwQkZGNVZ1YkR4M05JWFkzMHJVclVYV3dkNWlzUHZzYldw?=
 =?utf-8?B?Ky93MHZZN3kxMGpSdWxseVFmUTJ4Vk5oQllvTG5IZ1BrWjgzUnlFYTE0N1RR?=
 =?utf-8?B?eUYraXQrWXU5Y1ErcTRmUXVTVWhsRXg4MnQ4K283bmxENElPM0pzWHZ1cTlw?=
 =?utf-8?B?RHFOeTVJaWo1ei9US3Y2TlloMmFndHpBQngxOGE3czM2d2NYZEZqODRNTm10?=
 =?utf-8?B?YjRsV0FGNEVjZWhBakhYdG1ROTExNktuTHlxMDJhczZqbkxUQ2tJQkJ3aUta?=
 =?utf-8?B?SFBPRVJiMHc1RFRTRTM0QncvcHN3MDI5em5yTGJMMFliNWdmRlJGZFdXTUgx?=
 =?utf-8?B?dkNod3BPVGZldXpNM1JUbUxnbHgvYzNwZ2ZiOGFVR3FTaWUwM09yQkc4ZVlZ?=
 =?utf-8?B?US9jNTN3cnpkQ0dOckU4eFBvbVJVMmRDNzQwQ1VvNEtaTTNxTVFzaTdjbUEv?=
 =?utf-8?B?NUdOcVhCNFdYbHQzZDFpMkt0eTQvc1g0ZVFDSzIyTHc2Ni92cURhbS9TeU13?=
 =?utf-8?B?NzdPUkticFdubHdndlR3ZnVZaGdIUHYxdXRob0pZRWwzdVhYbVVHa2RyVTdn?=
 =?utf-8?B?QlJWcllEelRnM3hwMnl1d1NoR21jcjhSZWs3TnJaVzJGTTdydG5hS0hsYk44?=
 =?utf-8?B?VTMzWVpySmNneG92NnZ1ZFdURzZkSVFkVVlFMmRocUpBNXFFaGN1SDBaK3dE?=
 =?utf-8?B?ZEVHZmRtZDFlTkRCRXJwZHlBaWYxS1dDYnJSZ09vMStFR1ltOU9PY3NGbnZY?=
 =?utf-8?B?Q2RvcTQvYjJmeUJmQmwrN1dzUXlFYkVhSGx0bFo1S0xCeWt5WGtManRicjFS?=
 =?utf-8?B?TG8yQ0lwSFdKYTNtRlpGVy9JUkZZTGxHRWM3TjRxRmJMb0F5TWx2VkJrVERt?=
 =?utf-8?B?eUtNNVFQRzRYdm1kZXUxWWZoYzhpN2UxNGprOGs5VG51Z0lubGsrZVArQ29F?=
 =?utf-8?B?ZXo0ZnFTQldmbVFkb0VEd2w1aUJ4elFhYlVkcnBaUmtJbWZxT2NRdVlBcnJO?=
 =?utf-8?B?V2ZTczhOSDc1WUVxbnJhMjA1Q1BrZDVMTUpMNWZDWnRDVzNSRzNPd3A2M1VL?=
 =?utf-8?B?VUVROW9sbFI4OG9CeVNEcmNhWHQ4R05uUHRzcWJhYUpxTnp4Q0xmN0l0VmM5?=
 =?utf-8?B?T3VKTm5mdVFFbG5POW1nbzJoUWMzZXVLZWNyS0dMRWhNV1lmbEhQVmpqT0tm?=
 =?utf-8?B?cXVIU3hCSzJZL2d3TEJpcVZUV1JWQVpSR2NjSU9sKzdrcit6ays5NjNXeCtD?=
 =?utf-8?B?VTVvNlFnejNoNlJyRVpvWUJLaituR2tPdEpvOEpYbUJiWjRZQlBoTCtGN1JP?=
 =?utf-8?B?cXRlTDhTbmUzS0FEOUZkMVNOUmRjMURGT3BlQ1FsTVBqSWRMa1F4OEVyakNW?=
 =?utf-8?B?WXduT1pLZkRmZEdjTnZIeWNQUVdEZkhMM05TVVRDMEpIL0pkOWcxVFY3Y0dz?=
 =?utf-8?B?QkVzcVREQXFwMjBGaldicTNnNkNUNVhLZjQyell1eHR4bU9yb1l1L2RrWWpS?=
 =?utf-8?B?ck9rejJtNGJwaUlUQ1RpbUR1eWZhOFhHLzlSeGlzZDJjRmNXODc2MHY2azFT?=
 =?utf-8?Q?Noc8Dh8zg6Yj3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:48:28.7317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e870bf5c-e764-4653-914f-08dc80f23dda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8582
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

Accessing registers via host is missing the check for skip_hw_access and
the lockdep check that comes with it.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3d5f58e76f2d..3cf8416f8cb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -977,6 +977,9 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 		return 0;
 	}
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
 	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[xcc_id];
 	scratch_reg0 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg0;
 	scratch_reg1 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg1;
@@ -1047,6 +1050,9 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 {
 	u32 rlcg_flag;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
 	if (!amdgpu_sriov_runtime(adev) &&
 		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rlcg_flag)) {
 		amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag, xcc_id);
@@ -1064,6 +1070,9 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 {
 	u32 rlcg_flag;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
 	if (!amdgpu_sriov_runtime(adev) &&
 		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
 		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag, xcc_id);
-- 
2.34.1

