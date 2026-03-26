Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36C4109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BDD110E914;
	Thu, 26 Mar 2026 03:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yRMU3vd3";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012067.outbound.protection.outlook.com [52.101.53.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8C5A10E914
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udyhhOO2ZhhM3UgZeuUtvMaujp4o6JyXZxrpjWOaixIa9RqIzJ1mjQyx0CYge4YV7TG8DEZ/fbkfHlLs3Vo7NP87k9gwGhRb904KxUGz9gACio5sQQNBl/6bdIj+OdbF1Hfsnqqgom6/ljIOERM7qlwr2rFprLuXx4lPtiWPx0bxIkiq8RNQwUspNxFF2LJsnHy2xDhcAHuXaqtzhgjoU7VSnx4fcZf8HO9OWTRCJdcok6aNW2YKPiF11ODnm0QlJ2evvK2HRcYZf1uW4dm2rob+U1daOqskSSF5gW+9Nz/oGBB8ulWthQ5isIIZptYuwMIctaUKaIPxJczKbXEBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBBOAWLXkwH3Ec3jcYqi+c/uwdzlc3tE98JWZC32JpU=;
 b=NBalblwOXyYZI6BtaANJTw578IuD9zbPbTtROL4JCHMdy0iTLuHPCZYE1mkvKztcQfUpSsy59/ohyfeF/ycJxkrxRpQVvc25TssPu9c33Z8/ssi2nuXpY85pf0utz7UxJomUSP/mUH+N/A4Y+z9TIpGWHCm7gHm/2aW3s7KOje6EOXrULMxlLzy4hdBtnlBYWrw+RikJzlgTH6vCIdd1IueElYSUwonIz1TQA7TEsev5d3fD/YxTtckg4+HWc43pjlYza/SgDIQPMXfBR0K2UD2ozKVjjOtajNpoS+nncPIEdxM36v32eymCJpW5brobOwvBRMqWKiHtktWqXrMVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBBOAWLXkwH3Ec3jcYqi+c/uwdzlc3tE98JWZC32JpU=;
 b=yRMU3vd3Y2ktQUqwpWeexpz+OgdXcvG/95evt1P/2QDSzRLSQ6V1ICsHuTbTXAvxqH03VdM/lRpxd2FAFuctB6qpAnGnqmmVw8ilGWEuQMUA97E/ELC01aWBzuJv+/3XANIJXvxBZyZJSqKKfAFSOGRupMDgRorbGhHuOee8EDs=
Received: from MN2PR01CA0011.prod.exchangelabs.com (2603:10b6:208:10c::24) by
 DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.7; Thu, 26 Mar 2026 03:00:33 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::b5) by MN2PR01CA0011.outlook.office365.com
 (2603:10b6:208:10c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 03:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:00:33 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:00:29 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>, Alex Hung
 <Alex.Hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>
Subject: [PATCH v2 02/30] drm/amd/display: Enable Replay support for dcn42
Date: Thu, 26 Mar 2026 10:56:53 +0800
Message-ID: <20260326030153.406612-3-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e90ef4-b657-456c-cbc2-08de8ae3d8e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: cLRLRSytORsRfuADAjHmesKJ800MfQseKTRmk0dxZ+i5z26K+RlFAyyNXBcBinX2pTGKVthrp0yNUg7odOBIXYe/KKSVh+zt2rjtWebuKzk0rIBITqSe2v7mMe6cJhCQJCN+OUZajyNqRuxFQpXEXKsf73Cw4eXJSDSzigJRCWYvHGHma1NjdufrNGr7tlAAKpXKxq1C/VtozEWmoAkb+aKnusMRGi1SWCvCPqfiSGZ/u720oYkE+ygEnUOj86Ghwcn6JU4UZjQ7WHNMpWdkywJigUDTCp246GPRQWTtp2B5zMwxTuV+VIRJxnAhP7sZvM1jUAKgAnLVzxca+UZAfozskOtIyTpP3Y4OUpZBv9QK+xBxpiRb1wlg8YQqmAX9c5u2spr/nvr3iWCgPQpvVhZJ19Hmo75+WV6m2jnx/WbFIo4SeZ7LhGsbFcmQ8KbuUHsy8IxJegp/gHAPTSmISNiFuVcVzSoBLVUhisIlQTQwtoJHZCL2MMXLsUL5+UA4DGl9cDNF+F9ceOnc5yZu3P8uWffgEgtNL3qAsSbsv177AnaTlqMup96aHSJQf4byb1dcs7eIF9Ut4wFpvOb1zQJd+/Sk3C+iaGB3p5PxrhkEaDZyJJEwz56xdeBF+tNnWh/Ej+jOu0JH7ICJ0SEuqhcDAUIBrtGfO6yCJUTUROCd56F0r391gs3cHLkxekez8I427X+VDk3hfjBcJqSxY3AxmasF/6NcrGHxzhKm7XDxpV3UZeWWF5+PBGV5g8mX8fB+d9ktsYqwoFtoGpHj6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1PXURcmkMNexSS8j6AGae+iGjqDu+mfvenAHPF9khR/I1ajqvOPaWpUeNSfv2N8pstz1td69tXjfA2iVoHRhCZmoY6hlzydZH9xglVMXSNsS3pJWnblpS4cXHUKCm0Qklui9hgnWdyomO35Q2nz/qIk5HAoAx+yzOaoSzY+0ht7fEXamJHjLuEDXmKBUu4Mx48vS26sPaL2fVwlNMXIAiH9wgrTLGbkBGVS4Lv6htC/QKCE4wQ8JI/6XHRAN0RT0DijGQvSIZQvKNj7JOCDUkxq0R61y1P8IArejy9YfJPQFtQ9zjHKfpSWtm3OYXOPL5+lPXCXSLhjj6eBgUbbj1WNkrQzTt/kjrw8yXuR3HENhqkFjbc4eJuMjI8TegHhGVxuYP6uVkBjLkGjukDGjOz3pEQECQPW2mwfzHG1dOkZel2NzJaSSwZpXtSw6xOej
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:00:33.3701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e90ef4-b657-456c-cbc2-08de8ae3d8e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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

From: Roman Li <Roman.Li@amd.com>

Add DCN4.2 to the list that supports
Panel Replay feature.

Reviewed-by: Alex Hung <Alex.Hung@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Chuanyu Tseng <Chuanyu.Tseng@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 44294a67c40c..cc1127aaea9e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5577,6 +5577,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 5, 0):
 		case IP_VERSION(3, 5, 1):
 		case IP_VERSION(3, 6, 0):
+		case IP_VERSION(4, 2, 0):
 			replay_feature_enabled = true;
 			break;
 
-- 
2.43.0

