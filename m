Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC6BCCA470
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Oct 2025 13:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E6210E622;
	Tue,  7 Oct 2025 13:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fYhxmdvM";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013053.outbound.protection.outlook.com
 [40.93.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7916D10E622
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Oct 2025 13:35:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqPNjgfqDTGqpbci/YPmdj+990EZPV2Hfki/Slk255Bszi+o41ZGpbV5oSmcwHebkXlEcutz0XY0zGfgAGASUR6CqJbqOtIkOEsl0Mi1pGMU/GvSUpJN4qPdDV8NWrt3sLQipKBX7q7Vx8EKAVMUyxNaqbTLN/+iOV5a32FdLUpXI3lPw8iLaKu6xKJfk+0Yhia2eU9adSintyfuVWgQ/H2FNUOl+GnzRKFwyeIBevWmrd+El92BTtvt4H7cZHkN72SShNVzbutuudSATIxoyBfN4pBE7gQ/43gZlkneYlggs1oA8SSpVXNhz8Jbls8w/2mP46sfva18+MrQAGpvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns9Vp/rpzEDevkiixrWbee2y43b15Vw8zjuoDJ8Wr/4=;
 b=trFO/KzNwWMSyxkaNxg623c0q8CSnGqRmQy2G9AAYz6Z0OQMVc1x913m/yUcc3yvedGcmjeCCn83XYtSau0R91xp9hj0ijf+UHHwCOgzVyPz/ACIMVHOl+2zuDx+oAMbIAEY82uxwqW9vr0jGjbaYgqOqVni/YFfVNb06GigAs+E8qC3YAzMUTKToO02VJmuMhCLnX0QP+LTaPpnpoqmMoqAtn4f6rse+B/YpsJQcLah2I4Zwhpr6UsS1/sCbYlfgp+GEbbqqFWS7nYpg7P9zk2KzpKCuqHadVN7DnU6sHkiSziBLp1iICPML0KLKoHNoODCpZkSeNNrWs2/Bdgdsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns9Vp/rpzEDevkiixrWbee2y43b15Vw8zjuoDJ8Wr/4=;
 b=fYhxmdvMmmHFv1tUu94d2ECMKlyGt+AQ78jg++P0ahfxFY2HkdYfslyZZ6VVhRJDuoeViFsez/LSxqMrmRKFMV6CeFIiap+U/+hBl7Yg53tu/NUGukoVjtqvz/Zk+FgRzPTOYEH5hMrELdYKms12rzBb5+e0k9F4aPkCREcc/FE=
Received: from BLAPR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:32b::18)
 by LV5PR12MB9802.namprd12.prod.outlook.com (2603:10b6:408:2f8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 13:34:55 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:32b:cafe::26) by BLAPR03CA0013.outlook.office365.com
 (2603:10b6:208:32b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 13:34:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Tue, 7 Oct 2025 13:34:54 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Oct 2025 06:34:52 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <Lijo.Lazar@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v3 4/5] drm/amd: Drop calls to restore power limit and clock
 from smu_resume()
Date: Tue, 7 Oct 2025 08:34:37 -0500
Message-ID: <20251007133438.39411-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007133438.39411-1-mario.limonciello@amd.com>
References: <20251007133438.39411-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|LV5PR12MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7096d1-4012-4724-9072-08de05a64d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?STRpeys2w8ZzpenFNSJGAi1OPBwc6ynwyDKSpmdTGaaSkE12CYixGih9eSsT?=
 =?us-ascii?Q?NekqsZVhQ339T6me3U+O5fvHssIBZE9q7eboDcWzHe4D3o+Etm5MDvxA6kcv?=
 =?us-ascii?Q?gLqm5P/Av/2xStSAJ82cPjei/7lEIO2BNYenTUt+vsEt+DTDMQ5ffOBDU5wq?=
 =?us-ascii?Q?sg9tb9+ZMpDQznyrjElp1C0FwTJhfAcuT0WRT+pn0VgGABLP2yfZchKsmp/k?=
 =?us-ascii?Q?EJ5mhOzTg/Dg0V27QT5puRS1mJ3g7OL3DFdGJEGIlRVpYLQdQQ/MWOTMInQz?=
 =?us-ascii?Q?/VwDXGFkOtmhtz+Ax3pnUREyE+txtnShtWsIczvA6HNf632aZLYYd04IcrNr?=
 =?us-ascii?Q?KsWfHd/8b09+jbZhg/zSOxv0ciH7b15OYh37tttt0ObQmtmAelw5/2l9t+hl?=
 =?us-ascii?Q?AtboAZNZfD4RxEfoULWLoP4wfQd96JDnZKlMwsiE42c+JKN2ByE4Fd0B0TEz?=
 =?us-ascii?Q?FfA0TV5z/vGo8G+Xc/q3VD68dJKuNQtmauNy1UCWM7UuUnDU6Hvhyx6gUS6E?=
 =?us-ascii?Q?G0U5fga+D2EGFHZ7n/llCqB/YfCCjmyE9nWh+uVbFOlSxMCGBPr54HVebFbu?=
 =?us-ascii?Q?AYqAQXh6wYjJ7tD9463CwaVJgSkm91LAFCJYR+j+ORDeLVKSkRXZQjXjOtEV?=
 =?us-ascii?Q?dOEasgVffW2CyMxbv1rJ6JV++iWX0Dd+5Jh+UAwFj3zncDamMTRRUINVaesl?=
 =?us-ascii?Q?KRtU0KPBi9D9VMDzp1Hjj4TNhxFzFbca3o5bFUey59AKjD7eunDvdsILreJM?=
 =?us-ascii?Q?Z0lDaec0CBtxqJRlJRyNBXuiVO3MiLlPATCFtMVBFen1PjpsQ6xsGw/QGgWV?=
 =?us-ascii?Q?Vaeubxa7FUWB/q5p86sLu2omYfZLtcaN3tNLD9WAXpAEERTCFCdGfeYoFN54?=
 =?us-ascii?Q?T+UfzMFt57Hg2dxyputMu2CQpXGgD6+clBRms4vBGVSBQUtP/2oP3wE4qAkt?=
 =?us-ascii?Q?WjeqnxlW7KLytMz76wPzgJXBjRyaMpJRYQK+TZOzjD3fsSEtwKitrQunFuk4?=
 =?us-ascii?Q?k+cDDibJi8cDj6Igj2bTZJ5Gv/Wa/e/2lKsLQGCMpKa1s6STfN4b8KYArOKz?=
 =?us-ascii?Q?I2s0M/W48DsiF6bO+fORq4TyUO1alnJMsdCd4Dn4KlEPd3OeHuXX4GnSXYNL?=
 =?us-ascii?Q?Xr4D4bcmmT9D4Qhl3IRQEcbmnoVhIIE34xyRW/ID20h3XkZzB5yZnfrM2STZ?=
 =?us-ascii?Q?K5VhwEcZdyJutdFwrG0xYQG27CosVv318O+sEyHRkruD9j3x54WCS61Qa7+C?=
 =?us-ascii?Q?m7ETFvXM6XqBu6A6rrSpkynSQH/vyyKvzXLwlkIfdYHPqJNHKNSyUWC22xge?=
 =?us-ascii?Q?UzoLWkmbwR25tObykDt+Ne/8ebiJkqj2SBHpoNjas1ulfv+Gm58cAjHOGcBP?=
 =?us-ascii?Q?NnQ3dv5NXg46MHFA2EkwS3x2xZu2Hj8BmjsT6e7H/xwTHo78Fq8K+sybkC9O?=
 =?us-ascii?Q?RBDrouAs23FPtTAaTkES+i4qjiTA9A/7vn8wUw2CILKIFlYw9Uzb6nJGLRZf?=
 =?us-ascii?Q?wAAOIHb/li5fQDlNceeFoOBi28sFlUlgCLf0u2C3KZmLBCgwfXk0kpbm75DZ?=
 =?us-ascii?Q?VDImWK4fDkVWjXt8Nh0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 13:34:54.9849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7096d1-4012-4724-9072-08de05a64d26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9802
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

User requested power limits and clock settings are already restored as
part of smu_restore_dpm_user_profile(). It's unnecessary to call the
same restore as part of smu_resume().

Revert the following commits to drop that extra restore:
commit ed4efe426a49 ("drm/amd: Restore cached power limit during resume")
commit 796ff8a7e01b ("drm/amd: Restore cached manual clock settings during resume")
commit f9b80514a722 ("drm/amd: Only restore cached manual clock settings in restore if OD enabled")

Suggested-by: Lijo Lazar <Lijo.Lazar@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e87e729b230b..5ec42de1d91d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2230,7 +2230,6 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
 	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
@@ -2262,18 +2261,6 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 
 	adev->pm.dpm_enabled = true;
 
-	if (smu->current_power_limit) {
-		ret = smu_set_power_limit(smu, SMU_DEFAULT_PPT_LIMIT, smu->current_power_limit);
-		if (ret && ret != -EOPNOTSUPP)
-			return ret;
-	}
-
-	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL && smu->od_enabled) {
-		ret = smu_od_edit_dpm_table(smu, PP_OD_COMMIT_DPM_TABLE, NULL, 0);
-		if (ret)
-			return ret;
-	}
-
 	dev_info(adev->dev, "SMU is resumed successfully!\n");
 
 	return 0;
-- 
2.51.0

