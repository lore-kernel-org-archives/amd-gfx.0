Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE9BCDD1BD
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 15:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B3710ECD6;
	Fri, 27 Sep 2024 15:38:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j/PoFFrq";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F58010ECD6
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 15:38:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8yNJs9sHm0EGAQ3MAMnfAmVJNa7xlTIQK7b5doXQWqpPAJjZqbiQHkUhYudrKRY0OxB+1r4nJtJGod8b+qGGlKaz8bFI4TEv8Mj7j5fOSDB3K8bfGYCAb9RfH1d7UBImBayV4m6bk1kW3wPeJ7I6jVnFVmLDMRCxtm4RCOzars4LjtVMBw4ybdfGLvpvAIsV+BHMb8sSuvmsW8nZmysiadzt++F7r6zQuW1yItBUWdTGBHD5st7CQcEzNu2Bs9BlcUQAriqDD0qt51brEVAg2oA9oTlXRxzmWyZMCGu3SHEvIdeowKGtoJlqUUfi7RXcCs+mWNnuPARv/qjLnyaBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Su3SLIsus7CmXiU1MEWBcyF1KnCXr8jWdQUjmcMKow=;
 b=ta2vVfA6t/h76ntPQLYhKJEjF6ZsLADF3uRqvgWGA9Poqr6tjKl9cYS8rYuW9y0VCPwjXcFFSNQR8PQxGf0abNEGxYRQbetsi0GfFT7PtDX3OSakPGH63A66P4d8h6IkoLogMbZUyTrNzm2vUNVOwFnGjuOTr/f6P90whrp9iB6lgs2tttMg7PyRwvYoxfKfVjp03qJ+vpeQIMRfjf0WMdPneMGGTavwym5ELQTh2PEC3sQ1lOhqRGr6blx79mUPQhHCCqWrWkcqnlDnrtGstjs4mImUIxdNNwRA4kvHrX4HYJdQJ0CLcRfaQjrx30Jfwy/E2z+mWnPMIErWzByiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Su3SLIsus7CmXiU1MEWBcyF1KnCXr8jWdQUjmcMKow=;
 b=j/PoFFrqF+4gSQfKZOnBuLNmEysA5DcbY/2QDuFoyoY9pZ/HO+W92MYmGgLmDjTS6SxctvDCMc+ihYR/SEidFCYCdAjZNjP7U5FZjrxOWrauQsYeTdnrGHrLP964jVT/b816/xSvFCAxYqTiytmLfD9onc1KPUWSu6ww7JxppBU=
Received: from BL0PR02CA0039.namprd02.prod.outlook.com (2603:10b6:207:3d::16)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 15:38:04 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::a7) by BL0PR02CA0039.outlook.office365.com
 (2603:10b6:207:3d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Fri, 27 Sep 2024 15:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 15:38:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 10:38:03 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 10:38:02 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 02/13] drm/amd/display: Fix system hang while resume with TBT
 monitor
Date: Fri, 27 Sep 2024 11:37:09 -0400
Message-ID: <20240927153720.99916-3-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927153720.99916-1-Jerry.Zuo@amd.com>
References: <20240927153720.99916-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e927a93-97e2-4e0e-bad2-08dcdf0a60ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1zBbmlAbUhYBz6TQ1iNugej6NoV710Of7T1j2wZ14sJryJ7nFq9laa8H9X1B?=
 =?us-ascii?Q?yhO3hrg+qt3rwHkkvGkZR7V7nRdte5q1jQiaUfVgtNdbzBKhfEiMtvZI14ze?=
 =?us-ascii?Q?QZAMiZr96iXt0pv0Bmfrgqr0/zWEOSCJuLzo6/LuWlUb5MUMw/lKQP1v+fyn?=
 =?us-ascii?Q?N4Zb1xAqMrvLS5tXF8+DV81BHxMpVL03vLQ5ufd+hgm20tQgMrKPjXqGCXRn?=
 =?us-ascii?Q?CZEYykfP/cb2Hl1WvHM/CE2AF0vF4zQLrETtH7v3PpPAJXTEwxBgXjsEhQ2i?=
 =?us-ascii?Q?PXRB2C8Uu95kIrCp22eWgET2Lcr5CLpJXNb4ZczQrH0g487FB3oIVwT2SwRX?=
 =?us-ascii?Q?9i63OohUQj0Ur9uqrh4v17BCs3xT9aHFjzK3crl4IgHEHOYVAKIeSoadJaVg?=
 =?us-ascii?Q?a0u1tQxNVC54If8JHKZiasPq3jcDNw8ZpOTKPyVvGoMCECgn642sPlfqWzzo?=
 =?us-ascii?Q?wtHn3QP5/uoKoaOIa5NfZMOBrpkodvxZ6MPfXCERgvzPKaOl2dWqmqPDt7lo?=
 =?us-ascii?Q?d2d31F56p19rZ818yL/MppVfM4fNqMRgRJZE4RtitgTNgaR8q+DP5uTVGvbZ?=
 =?us-ascii?Q?AB7O/wbRjNX8Z6BhR0VOXHybl25uknE/cjVl0ps73P1YBW9HOfrLBltcuJCh?=
 =?us-ascii?Q?ARuw029EwqDiogxAw7/b+RuGqHP+l7ykjGlQoqbcoNknWDyo7fZ/prl+YHH9?=
 =?us-ascii?Q?K+cvJwhx9CIjHbkhR2WbNj15PwegHPrf21C2aFs8McSWNCieMQyzIq6y82Da?=
 =?us-ascii?Q?yf5+TOHuOA04OvjAkNUL8Ginip+z0KD3V/SU0Gjr95WKM/trw6z961li643d?=
 =?us-ascii?Q?P5nwSQnNHshW/vVlMIeiwtd5F+DaireUEar+0+AuMUHLLZOR9rlJ6+kBVLg5?=
 =?us-ascii?Q?ovMbKlzVHYXJgr8NV5tw57GzToPiZ/4CSA7DApZpKGo/BpbCfrRoceGSi8jx?=
 =?us-ascii?Q?t11JziufqnnhR3DKh75TeWVOLvWwetrcZZYnH7vnr9znpTHVasWCwQCNYjAG?=
 =?us-ascii?Q?e0Yu011a/mcU+ILsxFSpdJjFkF/O1Q7sa3QWx04oKCJgDX6AbFbmPGsfWS57?=
 =?us-ascii?Q?bCoPFrSA7unTifUyoS3Qzl6gYRjoX5CcSxaKcs0TCqySZ/Ys5jWvbtkK3BYd?=
 =?us-ascii?Q?WucUp/L3w/z0OMPdAdFJ9OeV5wlRQqhbazkLMUmTeKsep3CLXIXy02/2p+DQ?=
 =?us-ascii?Q?dSQFTXm3j2e88ZWfFPYxaVM9FUQGnxmsCtoadfAdMVxUoNCMTJ1sTZQBPDcv?=
 =?us-ascii?Q?IOKsdN6zZV/2SavsisOdh11omdXEclEvjCRIbiBMOzalwssGrDnmdW2N/cHK?=
 =?us-ascii?Q?WmRglhVpR23YLt+EPwcWu9TIH/XHKJ5XACsz0BljhaLdms89us3+KoALajia?=
 =?us-ascii?Q?5gDFH+jcXv4EfHuk365RC4Hbmzhl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 15:38:04.5552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e927a93-97e2-4e0e-bad2-08dcdf0a60ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
Connected with a Thunderbolt monitor and do the suspend and the system
may hang while resume.

The TBT monitor HPD will be triggered during the resume procedure
and call the drm_client_modeset_probe() while
struct drm_connector connector->dev->master is NULL.

It will mess up the pipe topology after resume.

[How]
Skip the TBT monitor HPD during the resume procedure because we
currently will probe the connectors after resume by default.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0d32f9cbf8aa..054608d4a0db 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -770,6 +770,12 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 		return;
 	}
 
+	/* Skip DMUB HPD IRQ in suspend/resume. We will probe them later. */
+	if (notify->type == DMUB_NOTIFICATION_HPD && adev->in_suspend) {
+		DRM_INFO("Skip DMUB HPD IRQ callback in suspend/resume\n");
+		return;
+	}
+
 	link_index = notify->link_index;
 	link = adev->dm.dc->links[link_index];
 	dev = adev->dm.ddev;
-- 
2.34.1

