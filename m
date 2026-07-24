Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E08FC531D0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 00:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEDE810E634;
	Fri, 24 Jul 2026 00:24:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pZDMaG7b";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A905E10E634
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 00:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yA1L2Hu40ux8QPFOrh9jvp83t3lHBcA3p4Ej2JzYa2RTM39Qsf9+rKBGenxRuywkNbYj+d/WuNOXDlxwWQZQbP4V57XFheCsxvPbEAtpHDkNpPtNraYP/XPyBEK7cYQrJzjuMKW3mTnhm4xs+Hu4Iubrn2wS8gBlhKD5QcQiCpqV1c5khKV9dSuc2FnieHe0Y6pR3PtPYA9ZvKbs2RKWCHQeiKcXY3RMh1m/G/Ff/YuP5rSQBwdof5TMDdVGgmvD++g9Jfs0ixuNHgMtYzJIyytht0Ap3LmLcQOYAnXr0to3fe++oKR9ddnAGYrDd5imhx9RI8EEELyt5dNGi4SNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDso3vM2pdIjtRQ0mitM5tMsNwFGof0ayA2cwdKeY8o=;
 b=d86igSqu5mA+ovrXETCky6Eblqa6a5t2jQ4hDc65PgNrnjyXgMzMjc21APQB1mJq9b/7j0spvm+ypmul4NuUdtizbFTCdfWcu64SFNUknek0mIEi5iYu2l+AQlxijwV/Tq+vJ6j75D+bSQ+43tN+gcMT9hM7CkFWKD1kB55yqSXKKMiBKRE6VL7SYUnecba9+kCDd7RN5iREwzm1vlzU/hrI1R4Ww/WnpqhB+Lwq1+olcDVVtnC3kTU4uMNDajmnWE4ogBC1ppNBHUSklX8lUFyZVOe00BsI6a5IWNANYf3iW0TPcUeA+xIPf8BAIkjTYRiibMzDC3cK5NXidpUtPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDso3vM2pdIjtRQ0mitM5tMsNwFGof0ayA2cwdKeY8o=;
 b=pZDMaG7bjM2xNQM2t3C03efkVwiM1GmiN6IUkHiBo4Ab4S2KuPz0wKiZbd60R+XuxmQYnPXqwFMtcvXQrkmre6OpEcJQceU72AZUgnA09SkzTXAGOeiECbXE7TjgdoPhDGNjTtbflEIuM57LnPFTO3NBUreDXILzYtxHCFsShp0=
Received: from SJ0PR03CA0196.namprd03.prod.outlook.com (2603:10b6:a03:2ef::21)
 by CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 00:24:31 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::18) by SJ0PR03CA0196.outlook.office365.com
 (2603:10b6:a03:2ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Fri,
 24 Jul 2026 00:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 00:24:31 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 19:24:28 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: avoid resource leak on SR-IOV VF with
 AMDGIM_FEATURE_RAS_CPER enabled
Date: Fri, 24 Jul 2026 08:24:19 +0800
Message-ID: <20260724002419.1091113-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|CH3PR12MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6000d8-6865-4d44-9cbe-08dee919ee1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|6133799003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: G11mdoq3XSzdbnkkWcZehVMGjSQlVE846acXxJnZcrCHKqO/AmkjbOMKipBoIxzHuG9fYpx7E93c7wFiHpAIU/1vnOdFympHnJqH2j/dSQ6MKZ2AuorvYEhFYVuQ004ZngPTDMNJxazSF8MxtfffTwedpW3yCpK4ilWz3Dz23KjN8aN3t+NafmIEQTxMiU6m+iSV/sF4IjUAtn6P+8Vy+r2wr9BfhNKHc8Y7mUpIk6zbXWW13qjzfAYquhVHAT/P9btDmyUCQH2JYpYN9lDM2H4EQnb0R4vkc5VFz5/FNL0N/65ZVq2LCIkwqmHWJic+F517HFsVrrpc54qPA83D+rpxagUgmg+gW2CL2FcIt/n2sil67XrqO04NCAP4YEi4yZLDurZWaSYteCd+F5iWlJ+52Te2LuM8ium+UznxC2/hfPMITC7wUgYB3j6+0d6zlGV28MfY+0mhZx/Xt5+Ce7W/gw0W0TFBicsKlz6hPxmDzZMwsALrx6KlTeR77rGuxxDLTk80sgjUsKR0NnDNXEdDU82xit4UT2bM1TRYHGp3rWvGJNGRr6AE31/r+C0NA3YpiJHIK36MWdKSRrooLaGqYNKuCH2USLO4ZCfKWD6Q2t6u5cl8tkGqR3IRThDLNBa4knIHjZO4KFuJ8eg7JJEfe9NIZvtVBm0YA1fGTw5ovF4aeecPK9AnqtJ0d5HG73c2HLD2Gwy+YozpvmtUUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OpN7q58b9cm0tj5kONDQRnFHTfajHiVVoBFkYe89IRLaZePELWGLv7yjZmFrm6Zl+GwPXplpYHFkhf/iYH6ekvlrYQCF0w4KRL8gaJ+Ezu7Il2WcQk3qBHI7koVsYqXSNVCP2Q7zEaEbfAxohogJH+pUOx016+Tp3CxW4zBlfy+UGBOs/t6XItzzY1bJQmMeWrVdne59tPl5gt5gNxfn4hrPMHkuQmD8Z8+3CeySKSfpb2jNX+sjKFc+k/IHuGfQ3kzA01F/bsjtuQ7IIRNDMGnttTZU+yT6CfXzQbl5fyPecWvWvjF4YP8dZ5QhMfq+DDNahX68VzCuK64SIK8dAZkbvVTMLZRNBYXt/7jysdQB8PkOfmidWWTshww9crN/qAwvLqCsgAaI0yR9U1urEEyUbZtlw6gfKk3NgqOdcTzGOJNwiq35YQKnDION/m0V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 00:24:31.0420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6000d8-6865-4d44-9cbe-08dee919ee1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8355
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

Original amdgpu_cper_fini skips all CPER cleanup work for any SR-IOV VF directly.
When AMDGIM_FEATURE_RAS_CPER is enabled on VF side, CPER related buffers/workitems
are allocated during initialization, but the old code returns early without
releasing these resources, which leads to kernel memory leak.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 0af8b7be326e..373e47050630 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -519,7 +519,7 @@ int amdgpu_cper_deferred_init(struct amdgpu_device *adev)
 
 int amdgpu_cper_fini(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_cper_en(adev))
 		return 0;
 
 	adev->cper.enabled = false;
-- 
2.34.1

