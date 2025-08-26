Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3BBCA0EFA
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 06:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC52D10E2C7;
	Tue, 26 Aug 2025 06:03:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QkLKCWBu";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 819EE10E2C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 06:03:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEPA1Z/qkYrfWsZxZRAX01jkcruLpd/1V3Mpua3Z953BVcSdhG6x0OdRxGJleu9X1NY50w87Buiyy7/Uig+m2nMwFPKV9LF3IdKu9JSKSkTBqK7XhwAjql7AKUYqSXsikGaXcHkPLVyd8fhdweojnLCP6WFTG3Msma/wm/fWLeWF+IkjJ89VLOldwhAhjirUcVs0m2tFGenLbS4R5pbuyXSYSBxOT7qnUdoTQZ6RuuLkrWLVcioujBRIcadgo5SNC7ttXh2saYVx6nOOf+uAvWx/WYjpH/Bbw3i8CXb1jBYE/oKc/eki4WmwLxlRauVj+N0lI+FVHVx1huSZc+XPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fXZ+BY2rX8mSJ6JcVUE2jnK3IFLEPEgXFJm4YVqIOs=;
 b=DYgG2YWEPJQLUTAy+a2DMkOXXeLIciWBGquN2PTNpo9xk1MNf098IwqacjcFnri8+J7v0XjuL1aV4GuJ8SS79zdRkGWW4u7Ho4AaCFwp4H/uJC2yLPp/KFMwg0s9fqPTkKWs1FxnBTGxKfv3lE/3+6ezXTRVqJdG9uhiF6COLYvnyhNxGrFtHwFbwpT8N1s1OgFjHb66l904kS2LSIVtHLmUu5e7m1HeZZYFn9sLzye3aT7ZnaLNQCK9uL/mMz1HjGSA2zFvPCGHYF5ZBCROKfOPGDCjh6whtovEmAHrWhz0Vvvz2pZB9nJpPx3DCCMBY15dMd/D2xXDnaijW3uNdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fXZ+BY2rX8mSJ6JcVUE2jnK3IFLEPEgXFJm4YVqIOs=;
 b=QkLKCWBui/hmfF0NAn2B+0Z8hIrBTjBG8czAZXeOhyVurFkeDBx4+/N2/YvG4ZfEymPLvjxKAOs0yIK4YtTPhPjXtGweJ3tbQh6wfY2rxoYKaUqm45jIYxTuVyjsluQ1HA5dHZ7x/NlZUVk8R2sDsyyDnt7xM3T5BIup/+Fmzok=
Received: from SA1PR04CA0017.namprd04.prod.outlook.com (2603:10b6:806:2ce::22)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 06:02:59 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::c3) by SA1PR04CA0017.outlook.office365.com
 (2603:10b6:806:2ce::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Tue,
 26 Aug 2025 06:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 06:02:57 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 01:02:55 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/amdgpu: disable hwmon power1_cap* for gfx 11.0.3 on
 vf mode
Date: Tue, 26 Aug 2025 14:02:44 +0800
Message-ID: <20250826060245.334880-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b8f1a7-a102-4c8e-c50d-08dde466348a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sox33q53c+AfvgsYXgyyF3m1PJHWRhhyYrT+nK1JVvQLZwp7lltQ+znIHn8X?=
 =?us-ascii?Q?ZU3mB7eNBrvXmZrSuIqU4ZbYMWIKMiJOpHKYyKfiCElCCdYBYeggt2xJc7AJ?=
 =?us-ascii?Q?iDqSH+vsvv10S6/4TuGL2YNcgG31uJ6rD1RT/Rf8L3e8HwB7ACZv9U/9fW61?=
 =?us-ascii?Q?42S2zTl5i2aoUvEUrXNwzpPlU6qmkA3nY67bSwBg3E3vLHWOKLiwjgqkj+BJ?=
 =?us-ascii?Q?gzPzS2g5seM0bMS8jjdcCR+ripopWbq4rTOcQ3juMTfbg5ctBtnGAoZj0z+g?=
 =?us-ascii?Q?HLML0Ckg1dIi0V77ieczzZzwZzwNU/vLYUZuQB7LkS29efmgOt6i3jEepmLH?=
 =?us-ascii?Q?ZwXalySBNlz9e8wSnXr96wWvXt+IHgfWm1zUbyrARR7fgJ3VRMHnj6rWmviq?=
 =?us-ascii?Q?2KZP0IqvocuVmQY3WbZKrJvC2B02T1Zi3HpnLIWfPx3GuyTpc/jqKirrLov0?=
 =?us-ascii?Q?jPMibY9BKRolL3aRwpkw84TxTKCga7/g7gyunoj1YfjLk4AAVoUxUkjsmI4B?=
 =?us-ascii?Q?Y5RsStegq52JnDpqz+ATvGhRk44z/WbuKxvwAHFf0FgbpSsv2fdYBdyc+OoF?=
 =?us-ascii?Q?KtRDudz8qzGCxrS86BN7asXw7cNmXNsAb1Hyyz7OSUVoiyzmzCBpfBwO5Bng?=
 =?us-ascii?Q?r8mH0hjsEZm++xxQ1+VzfG9m2Nu/hWb/tPChuh4jHCY+DdG9qq+Xq/oTPysB?=
 =?us-ascii?Q?jWnsdjof49vELXgRrt2P+EH05Icjx6U4mcQh2H0M2TYMw5uPt2nItoebYlJk?=
 =?us-ascii?Q?RVgeBYm4GMLs4Xhhdv8ihcPZqPNmlEwL/W9WfJI/gZlQH31R+tkbrA/UVlsr?=
 =?us-ascii?Q?0pxUWHq9H06xccgCB8xMVdtsAr0idcE6gbSEid+gOEoNoCfifj6crCLng4nS?=
 =?us-ascii?Q?XN3mAjRvUl+JAprTVwUBmzOlg1ADFwjMJKB7c4sFzmr2hifBdrWmtuemQCFE?=
 =?us-ascii?Q?S61Y81yCx5nuZ1V7TmfIM0C4t/fKAsjxwlEvCygQmTk0QW8JePjS1KG0DS7U?=
 =?us-ascii?Q?wy1Bp4oTWNgMNwot8IgTA28Dwg+HDyHSCSm1kHcnMaSCBKDH7OuomRqxVJqN?=
 =?us-ascii?Q?7N9UjEDPXz4Mb3HgCblx4QoShvK4LAseS9JCa/0Ll50PPp3xNfeURnX4/gLv?=
 =?us-ascii?Q?4FOT7073MzyanXm7oKOcKgJ+fk8hjG0Yh2e3g80iqggBr0NmJpVaCNB4RZU5?=
 =?us-ascii?Q?7GKCh5iym9P+FiNWYyp1gkViH06HPtYlaCoGCaO57nji+8JgfTbCuVwHc6w2?=
 =?us-ascii?Q?KwWnaShePOSoF9Wz0umljNHEXlU94zA2PHkdr0bLYPU9/NwhaRgX7QxztWrL?=
 =?us-ascii?Q?arCcm35l1AuBRCh5zGRhZ86xq0tjbULAWlCAy2EEsGjN5tlPQamOu51xxzm7?=
 =?us-ascii?Q?W3aYfpAvxfd3VRJu0Inu1/zsCn0j31WfKYTiZo5FHF5hfeoKIb5XSP50Ujfu?=
 =?us-ascii?Q?GuXHYK8FXCdcAtA5qwuSpELrrftpLMv93vP9Oc+Qi4jH5trefCOv87nXQXFZ?=
 =?us-ascii?Q?DsnHRE2lFpY0IDdWE9HU++P/75CqTqGs6lbl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 06:02:57.5127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b8f1a7-a102-4c8e-c50d-08dde466348a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
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

the PPSMC_MSG_GetPptLimit msg is not valid for gfx 11.0.3 on vf mode,
so skiped to create power1_cap* hwmon sysfs node.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d5cc4d7f84e2..c9a986cf3aef 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3593,14 +3593,16 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		effective_mode &= ~S_IWUSR;
 
 	/* not implemented yet for APUs other than GC 10.3.1 (vangogh) and 9.4.3 */
-	if (((adev->family == AMDGPU_FAMILY_SI) ||
-	     ((adev->flags & AMD_IS_APU) && (gc_ver != IP_VERSION(10, 3, 1)) &&
-	      (gc_ver != IP_VERSION(9, 4, 3) && gc_ver != IP_VERSION(9, 4, 4)))) &&
-	    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power1_cap_default.dev_attr.attr))
-		return 0;
+	if (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
+	    attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr ||
+	    attr == &sensor_dev_attr_power1_cap.dev_attr.attr ||
+	    attr == &sensor_dev_attr_power1_cap_default.dev_attr.attr) {
+		if ((adev->family == AMDGPU_FAMILY_SI) ||
+		    ((adev->flags & AMD_IS_APU) && (gc_ver != IP_VERSION(10, 3, 1)) &&
+		     (gc_ver != IP_VERSION(9, 4, 3) && gc_ver != IP_VERSION(9, 4, 4))) ||
+		    (amdgpu_sriov_vf(adev) && gc_ver == IP_VERSION(11, 0, 3)))
+			return 0;
+	}
 
 	/* not implemented yet for APUs having < GC 9.3.0 (Renoir) */
 	if (((adev->family == AMDGPU_FAMILY_SI) ||
-- 
2.34.1

