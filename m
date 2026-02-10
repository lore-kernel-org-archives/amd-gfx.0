Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110D9EA811B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A654210E58B;
	Tue, 10 Feb 2026 13:56:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1r7q5NG+";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013043.outbound.protection.outlook.com
 [40.93.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D6F210E58A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:56:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BK4UM5ft1RG1GudASAk4ICXehQ+WTltd2hshaFjyuRjNIJSWXEVctmSIj2JkEuAONKGktoSh0twEGaKfBWZbPzI4aPrm5W6g46IllC6m5HkqjVm02eHsAuY99yD93Y+H38BquNjXeJW9JpMPt79f6YJQV3D+0Bab1kd7Vrkp2mnH8Wh0Rfq+5GgS+MsoDBFAEbWR8V+5dlfmrNlr9A+fQo+P2xEOb8NJhTByqdwgGIgdqrcVHdukm36s9mqSTJoaKMj9Z0oqrtYQcPDszgJBA6jlFOFmsLwJvTu85nxV7zp7jhIUQX1PeLsLzWdzZ271rG03S5MnedatgmPhsnYRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJtnmd/woBnLQS+VNMm0c9JrPv2QJ649DeRhq7yZIKI=;
 b=klOSsmbmlReaGN4dQ8Ssk+9E3atKYsE2Lmt37UkWm5ThLHOthB2AjKcLi5O5Vffr277XIfPRSrLwDe2UFQ7Xz2QvtkSi40C55PckMgC0jwYJbaGOf72WGWn7sJ0eDHQqk3nNnJZnsaZjtE6mVWI1IGV0n4XKBvsv3BcIkPBiaXiOrwdoa/QUjMexcnTCoGpwwNlp9Q9LA03gIwF/uB9WhuMTjS+8ivkQY83PdqoTOGHBkM0TLdbi+KPf+h8Y5ukKXo7XmLdIRgYAmIZXZ3Zfanhg/hdt9Y1h8k2JSRfil8Mi9Z/z9N626ulVhTsUSfEr62BAJvu29hEEkYTdg7HqXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJtnmd/woBnLQS+VNMm0c9JrPv2QJ649DeRhq7yZIKI=;
 b=1r7q5NG+oKyP95RG9e98qu8ZjgqDuYT652QGZOKBsZ9dDUh76VpXzHQgtAzxOEYCoKh1qbZ2lprYT8CIlj/viPlZyYhiZAB2fDZxEvbaoGig2FryCjTagcHj4H7mWMPIQQ23Klnbbip+g/TkYC3AWcjq8hB5XggwUgyAh2Jd4zM=
Received: from SJ0PR03CA0229.namprd03.prod.outlook.com (2603:10b6:a03:39f::24)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 13:56:53 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:a03:39f:cafe::4c) by SJ0PR03CA0229.outlook.office365.com
 (2603:10b6:a03:39f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 13:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Tue, 10 Feb 2026 13:56:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 07:56:52 -0600
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:56:44 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 18/18] drm/amd/display: Promote DC to 3.2.370
Date: Tue, 10 Feb 2026 21:50:11 +0800
Message-ID: <20260210135353.848421-19-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b349a46-ce54-47e2-6be0-08de68ac3ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hUM4SivwSxAHKnoqLiM4UWpuAVkjRHrcP42Xnz8+KXoe7xGszXWXpS5jD4Tz?=
 =?us-ascii?Q?KLWh/joVgL/gt6TC5J26moITpJ6v5Z7hs+F4E9fLdd3up5/LAoroxNIQtBpk?=
 =?us-ascii?Q?szuhnIbNJikh8Rin0JCHTBFQz+6bhPPR/V7PT5tgTjFZ6ERAv0jrfAuYq9i6?=
 =?us-ascii?Q?ReWGfYSiNuJdC3XiM6+Z1nJ7fj0zjvLL+slP9HzkICJxrrcT4GsrWH/OKsPg?=
 =?us-ascii?Q?8WmjCoVRWAmWxIsti3lr9z3bnmlo5RgRmYt6limZOspKEI2jGS8DY/e0w/0Q?=
 =?us-ascii?Q?p2ppUL0TFpGfsQy/4MM0dnvetiZY5Xns5o0IY3A/BffqCmyEt+RS2mun2DiQ?=
 =?us-ascii?Q?u3CkAA/ty04D5aQGSOOX6epCIPXZwq8k2bGI/bTBq2KnnnLZ+RwtDaPdumq3?=
 =?us-ascii?Q?2J9bLq4I0HxKGx7uu2Rb5bIOD/M2oIFVBvgs8fGI1XLDrJUqhB2FbuYif5XT?=
 =?us-ascii?Q?YcaCvEkuweZfNlrQgOL4CZlnyjt35UE+YwKMBEkNBpkr38wmlhTKZAL6cJEo?=
 =?us-ascii?Q?wU8xvopFvunJqLo0e4+cCrPVcOn7hh0L/lWhiKy2R52jOFdwr4OTAnExGwd+?=
 =?us-ascii?Q?Z6ZH0TL4JLxD/NF+UIVX6WIdjGVEAalknolN4iFaMVa6K8qKM/r0bty88JJu?=
 =?us-ascii?Q?bP3fAsOx62GYnTQ1qqBuSIiA8YmV6n+AV9TgMwa0rVrQ41GgX3Zi1LqMWDwU?=
 =?us-ascii?Q?tyDaBIFg8T+Zb/BsegY3TOh/j4zSnyHSj14GqRluoOdTxzKm9iqwL7bksQYB?=
 =?us-ascii?Q?imX4mjscaYJnnUz2kOiRDTmJ4utMFx4M8EKhq0UQozm5uYqoXbLzCbG+7NvK?=
 =?us-ascii?Q?DsbTmWxVL7b+YGPu2wLxZ+wflUHgcGNnEplVdaDrqoloAh9yVCoQgvYEDdRE?=
 =?us-ascii?Q?G4RBLl8jBORtO0WBqZleq3PJnkMGtO9ZgYXGzlQJDbrFKMibb1gs/4ihgkO7?=
 =?us-ascii?Q?E43oezlJ5YuKXrwvG/X5qrTt15gMgX/a944AP04wug0ZtajnnAzrloO4CNhC?=
 =?us-ascii?Q?CrJUXJDf4/ubB3NJmuCI5Wgt1U9P+Hr6ov4aK4F8AerPExOfC3VX/TWhkqAH?=
 =?us-ascii?Q?CvG42p0PIED1Q2U5Zz3ld6AEjUrwV4cSEiUOEqXffWRQ3kgroldwACGr4Awz?=
 =?us-ascii?Q?m+RaBf/itpV6rMxs64wYRisFbWq8YaYs/aKguFJBEj57SojDHQ5Btkh6KriQ?=
 =?us-ascii?Q?uV/08i5bTqYfqRRoU2X4D2a8RqqtvquDVOOFYazaYhY8SQK38h+X2I/zLchf?=
 =?us-ascii?Q?NkE18s91SBeN7KeecEoqQaIrA64CgFKkR/SwfnILlv/RV3rxYwVH2+PihZn0?=
 =?us-ascii?Q?xPeWjMQVojxuE4QL+bJ8l9NgNf2vLabQJI1Yhf/5p+j45Jn1frihihGL4wOS?=
 =?us-ascii?Q?BQnvoLg0Cc08G9KwsF66rwvOEBLRvRCKZanA/yaL28xoUMOgKoJpYEPfM+RX?=
 =?us-ascii?Q?XylapLaCPcinV8Onag2XPtja5T2nwYl7jPzZY8nW8T+Qg6us0fdv3U/yHPL6?=
 =?us-ascii?Q?V8ilnxpQuzEabrZe5pUWywLPh6+LDgGvPGFPorjpmDAeqOWAKkFe8LUeb7x4?=
 =?us-ascii?Q?bSh7X6vdrqN4M6fhXjmW0+q+CuM/hfdCeXsxzidY9rSmM7vBLO2v4gV4PULH?=
 =?us-ascii?Q?c9BzOua3DxeiC4yk1qIYLtd5R84rsTs490jxuQNpjeSD3IF+R21ZHbN2AOW7?=
 =?us-ascii?Q?IYLH5Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y1F0yZ6arAMfrZ1Z8sYVbexU5PRq47FAZv6VZxBp8Ff92Zqk5SJtv8chKdx7kwz6pDFsj6t2NLlFgEtvj9rwsIuVTWSfeRNFucH6TStknH9NomhCj7XWjKtrbF1wzrkuLMiJO0k9M/rY3QBM1kzG40sYZKbtQ0UVtmm+XhICjWFuWC6FkOWb52BYadHS+NCkE+W8UF1FP8Vcaps3Asd+QWkJk0KSpDNKV9ZSWgcIyXBTCtyfRC66mRe+Bk1ObYVAxT+1NdW4pWRq50Lj2e3FezPyb8x/MPg4Z0HQ0YtozYTJpqv3t/4cQ1TO6jN6qGYFg8n1O2h1ep560TMCVGD1ftl5hpRTZUY8Pf8/vnG+j4UP0lVnTtBLvLl++IdRcHtNL0anzetkofBzWsQqd51R3wQTfKRc568JDC79bMkXeZVAFmb5S45vwSIcQQz6ooGv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:56:52.9954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b349a46-ce54-47e2-6be0-08de68ac3ed9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:

 - Add static keyword for sharpness tables.
 - Refactor fams2 calculations.
 - Add gpuvm and hvm params to dml21.
 - Expose functions of other dcn use.
 - Extend inbox0 HW lock support to DCN35.
 - Disable SR feature on eDP1 by default.
 - Implement ramless idle mouse trigger.
 - Migrate DCCG register access from hwseq to dccg component.
 - Revert "Add Handling for gfxversion DcGfxBase".
 - Revert changes to Gfx Linear Tiling handling.
 - Skip eDP detection when no sink.
 - Refactor and fix link_dpms.
 - Correct logic check error for fastboot.
 - Check return of shaper curve to HW format.
 - Remove conditional for shaper 3DLUT power-on.

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4c4239cac863..71f2812acf59 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.369"
+#define DC_VER "3.2.370"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

