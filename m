Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43812C25B78
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 09:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1BED10E58A;
	Mon, 13 May 2024 09:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a7u9n31V";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE3410E57D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 09:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmlSX/N9Xc2zMVvMb7y+XHviE4vUwMmDOHjEJUGF9SgtcaWVBNCfmvboRjdhFsmVWxi+qDbsgBqJbKSSEwdUoPoBdcok39fYZjkusWDj7wr/GGHvVqwm9G7xcvumNrgtnKHbDAfesNyiewiRABjDwCKpsTHB+3aFoBd0zuFCkk73L2hvNZa/rk35rC+Dge2Oi+zTR69DVE56zOR/dmQn3yYFgYrpjB5GjmP/cZPJmPTpHB+MNUTLXBG7/gBr/yRfiMnmRR4RZePVJem0YcnpL6lOMFw9mtHQh+eiz+9PiGyq4AKXP28dLYQ7g7LvQ0HVAaedVg3dYb0m7/5DE/i0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9J4rsiFix35O3lpXedjTawyXBk4x8oqgefSLWD/WE94=;
 b=Eq7hdPAeUnrzVWgfO7qcB9cUNfa8K1Dm6Y3u61Rkt24iIOSDARIMiHXe5AegPuPcU8n/xAQ1XeNu7J7/np6NgobAsq+XtpamAho6cBPpFJfF1JmhhvQkhHZ1w3bae+49If2xuzeaVg04dD0OpQmi1ZKr4KiyDI62swZ5cP1LW+F1s34jaO+uHBQoVZj+yPx4wDt6p0ywQy+fv+kJDNZFu+eYCPuly9af0AlfeFw7tNuAOaFmWAQg6eqpJ4g+F/Pf9A8XrMuB6CqJYnS+ufKK6ea4n2cLaKWXT/sSOHXbE8a5Oe4OCnzyntKe7M9XWdOeuN3bYsEkt3utSrfk52JF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J4rsiFix35O3lpXedjTawyXBk4x8oqgefSLWD/WE94=;
 b=a7u9n31VP12Iut52KNEE9qRG/wahVwDmyObvrinyYctlriZEltdU0JVg6A/JEs1oz8gHvjOg1VzdtMyto51MVb8mFt2FykJKf6+xJfv3ONhzhBunxg7+ly5qFMukA6VTAVufuKPXvBmUKW8JUXWGqTrAqd+f2gfD51Qsdmx/QwA=
Received: from DM6PR06CA0035.namprd06.prod.outlook.com (2603:10b6:5:120::48)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 09:21:40 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:120:cafe::2d) by DM6PR06CA0035.outlook.office365.com
 (2603:10b6:5:120::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 09:21:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 09:21:40 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 04:21:37 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v3 06/10] drm/amd/pm: Add xgmi plpd to aldebaran pm_policy
Date: Mon, 13 May 2024 14:51:07 +0530
Message-ID: <20240513092111.341168-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513092111.341168-1-lijo.lazar@amd.com>
References: <20240513092111.341168-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 671c6d10-217a-4997-76a7-08dc732e18ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qsMdRSzvUdmo7rnmOUX/qDrWdV56MgrVi0eH8z3sPFJfP3L3cCIrlqOArTUw?=
 =?us-ascii?Q?JfQ1IcgEEWcCic+YxMZZLTk1ClRhYOVYRn49SN1E7d5E/LGih8Zc6c2FD/W0?=
 =?us-ascii?Q?s7XDSrECLsRg5oQoQvFxkugS2vsaoiet08uWHgcaWqJYztds9JzBU/wUvvMT?=
 =?us-ascii?Q?ucn6vgOZ9faHUiUxR2YpfHV1hO4E7DBrj3ao0/5vJUsBhoEfZV00RHZbLJcM?=
 =?us-ascii?Q?9x7sRoZGGtmyMugodAhb/wbL4bp0s+PbgUWz3U/jj+xC4Am/++P/l/IzZXU5?=
 =?us-ascii?Q?9wEnAjbjGip18KNkqmCPwPAfTJ724PSbVmTUkgmsXBaLatEP+h0oWNu85y3e?=
 =?us-ascii?Q?0F38Omfh639XH74vliUXJcKgFI9r0ysdPy82rHq8p63nS70VsB/Hsx5pQdbL?=
 =?us-ascii?Q?9JCvxOBd1k12pdjFjry8go9WaGYrgD1RJOTLxZp91KQnXgoaUqKpNFIKHs/X?=
 =?us-ascii?Q?XfvjH4iWd4zO5Rkgm/TYc90IS1a+6+yv5pp+2ZXA94y+81VCNPBZkt65a1a/?=
 =?us-ascii?Q?4ggkpvyfMLKo2hXj10QXnIKJIX23BDe3FNBXdTyyGyp+l2qXgAIGfEKgKNHq?=
 =?us-ascii?Q?wXatbXkMnJntn6yEC8set9iF4wpel2Fb7/YFpziFCE5Pz+5r+9exOMZ+WDSX?=
 =?us-ascii?Q?M+aMv/KML8OhVlS8dLQgAKPaTO6y6riYB8UOQBFQoy5R+50EsR/gK8fx5bQ6?=
 =?us-ascii?Q?Lijb3TRsjtbJNPhgLhq4hPenqWs8/YzijYekM0jh/vOD83qaqGtLhLso4NDr?=
 =?us-ascii?Q?PobzBHvRxRNdd3qHAMGXNaCd73gAMFgGHLylx0GCw2ETenjBJRrmJVM8rPR4?=
 =?us-ascii?Q?vH80OnI/gxGLQNNgetGK4OKqODSMUPJhXxsQRAdmwXKZUuziYXFS5rlLl8+Q?=
 =?us-ascii?Q?LGFaMCGWdFh8N4tQF/B6/hYvpPLY0ppU0FA76Sn9iQtYCbaISXIBFsPfuEBM?=
 =?us-ascii?Q?i9isu30iXpRrYAWLMHVlxp/JqIgfoL2pLoyOEFY0eoqjyTH3V+wdXm6S8Jfl?=
 =?us-ascii?Q?tlBJeLg59xJ1C6lzKTGdnuHitQnlZahjDDVOowQU/btdeo+2wAJFZRTQXYPE?=
 =?us-ascii?Q?/AwpEB0Q/OrxkqgVk27LhGhsG9mkMKcvTOp3zOzxBdUuOT2v8KYz+fNewFR2?=
 =?us-ascii?Q?LiRs1dUNI5rOpvZIauWSzUHf8d/XrxJdp47GoLhUTtPHqKDukflS//0Rvrkl?=
 =?us-ascii?Q?hSt7dkzfojAb3E8tWnUkZS0vA0Pcd8xv2QjTBHJvtYwz/m0WIgXwiQENWAtd?=
 =?us-ascii?Q?DC1Tu/7q//z4OyxlvzK17BXnwdhBAcMRrzf7w2OT3OovV/dfRDxg8R4BliR9?=
 =?us-ascii?Q?VH2QohVw+F18chsPafhGMwDgd/FwS26R2RGg6ookugs9mfk7CPmu7mF/aLN2?=
 =?us-ascii?Q?LVNlyMVrTYvN+lsnPxqc/mWwiPrV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 09:21:40.2826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 671c6d10-217a-4997-76a7-08dc732e18ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762
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

On aldebaran, allow changing xgmi plpd policy through pm_policy sysfs
interface.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index a22eb6bbb05e..66d386ef1da9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -266,9 +266,30 @@ static int aldebaran_tables_init(struct smu_context *smu)
 	return 0;
 }
 
+static int aldebaran_select_plpd_policy(struct smu_context *smu, int level)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	/* The message only works on master die and NACK will be sent
+	   back for other dies, only send it on master die */
+	if (adev->smuio.funcs->get_socket_id(adev) ||
+	    adev->smuio.funcs->get_die_id(adev))
+		return 0;
+
+	if (level == XGMI_PLPD_DEFAULT)
+		return smu_cmn_send_smc_msg_with_param(
+			smu, SMU_MSG_GmiPwrDnControl, 0, NULL);
+	else if (level == XGMI_PLPD_DISALLOW)
+		return smu_cmn_send_smc_msg_with_param(
+			smu, SMU_MSG_GmiPwrDnControl, 1, NULL);
+	else
+		return -EINVAL;
+}
+
 static int aldebaran_allocate_dpm_context(struct smu_context *smu)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_dpm_policy *policy;
 
 	smu_dpm->dpm_context = kzalloc(sizeof(struct smu_13_0_dpm_context),
 				       GFP_KERNEL);
@@ -276,6 +297,20 @@ static int aldebaran_allocate_dpm_context(struct smu_context *smu)
 		return -ENOMEM;
 	smu_dpm->dpm_context_size = sizeof(struct smu_13_0_dpm_context);
 
+	smu_dpm->dpm_policies =
+		kzalloc(sizeof(struct smu_dpm_policy_ctxt), GFP_KERNEL);
+
+	if (!smu_dpm->dpm_policies)
+		return -ENOMEM;
+
+	policy = &(smu_dpm->dpm_policies->policies[0]);
+	policy->policy_type = PP_PM_POLICY_XGMI_PLPD;
+	policy->level_mask = BIT(XGMI_PLPD_DISALLOW) | BIT(XGMI_PLPD_DEFAULT);
+	policy->current_level = XGMI_PLPD_DEFAULT;
+	policy->set_policy = aldebaran_select_plpd_policy;
+	smu_cmn_generic_plpd_policy_desc(policy);
+	smu_dpm->dpm_policies->policy_mask |= BIT(PP_PM_POLICY_XGMI_PLPD);
+
 	return 0;
 }
 
-- 
2.25.1

