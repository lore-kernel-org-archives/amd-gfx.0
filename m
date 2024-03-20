Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF9FC54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A2CB10EDCF;
	Wed, 20 Mar 2024 06:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="USjVCh7i";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06AFB10EDCF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:36:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZHvMEs+9I66KCY4Q2QFLbTVOEM49m4sMqkFmAT0D2vIVtQzH5veI80rliabLz4iKnp7qzrV+oIhlcwjArsH0CUxAlnBA0Zdiiu+sZqge9qiQOKUtwOhzM+3RFUJ8Z+cZyNSFglk4jtxjjUHFo1GP2E6mZmpuHwjGrNQDYzb/2Kj8mI9ke9HYvKsE/IS/jL9+yeySxtKli9A5BB5sJlFSXgIrIRITlTO1QLuKA5PvD9zvwrqK+dPwEJEbsFjQlI+MPvl5Zd7JLSr+087tlzYctOJJGUCAU07P5Xjd0Jgz5/tktvKywbVYaGEu8ARBzBg98Q7ueiK65Rp5zhhcIXtdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNzdoX0yw/q9jj+S/ff4rj1VWDP1Jjg4IMvy9aRNpo4=;
 b=YRM3xlHGQDm3dnXJr4zrrcyAS5HVDf2B/6NYO/Sy1H+rUs0x2DcPMGxW0GRJBd1v6bf3s1QfmVtAJ6BEDyDFnwTW6TnjFo6uP3MeT9CrNHzR4E8L0I1GezpHaaM8A4Tmn0OskE/hgl1HO/gjWhHPLTVt3kUIbIeKyXDCFZPwBDHlb0MHz3oqrEt88FJMtSFDB5nou/W/KFj7bx7D/qhID8V61kLYbJJf4epRyvMwBker8BaX6uozTLKfJ95c/P8eojNgzP75GPveJmpLLver3TaVrnIOx1SvoSMoe/njEhtq2g8H6UJLR4tYPtxYDRnjRCJ386bo/R5kkTw96Wcr0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNzdoX0yw/q9jj+S/ff4rj1VWDP1Jjg4IMvy9aRNpo4=;
 b=USjVCh7iBjFcDkdv/ORliU9g446ErP7mXbmv1FjE06+OJ8oqZvxWaDDXZGsK+dolo2wd+dSscxLZTv410DZ+on8U2W5cOz4qJgUVMBAaZWoIhdraFQwbhl5gUImeN/gSK6RcXVcWIcxgKpSGdOGHtRaIlgHQCimyTi3Qs0oyKD4=
Received: from BN9PR03CA0535.namprd03.prod.outlook.com (2603:10b6:408:131::30)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Wed, 20 Mar
 2024 06:36:37 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::4a) by BN9PR03CA0535.outlook.office365.com
 (2603:10b6:408:131::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Wed, 20 Mar 2024 06:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:36:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:36:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 23:36:35 -0700
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:36:32 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 08/22] drm/amd/display: fix a dereference of a NULL pointer
Date: Wed, 20 Mar 2024 14:35:42 +0800
Message-ID: <20240320063556.1326615-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|IA1PR12MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 75fdc9f7-2f9c-4ed1-9420-08dc48a817ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNKgKkxKx+CcAXEY/hI0ntl0xL2+x9NCDaMAD8FWdY5pkthD37ALwE8wtqP7j3qh2cEVcObF54NhxXqrSFHdD7vym2ik6eT7vYkhTjcQJha/TI4h7I4FDeru/lZ5YUDIxBG5E0hyNg/l1sJeslVzOmWEbzHJfD6XidGYmva2It6LulIg748qgMIcjSJD5RNalGEARHvHdZ9BXeiK4T7u/ehwZE29x6jvV46rOtByiZowRqfU9b+Ks8k5jJe/zR3qJ/+SopKejM2tPLZUuAMc+k2AcHywyCsZgaMYMD2/AVt1E8gce/FH+4SOrchd+vXcEyQ5/1HdHlEtc4YqdyCx7O9yiMpOrMN/7PY6oTZYoxPjMUlXlUW6114ozPoCTrI6wfypLkU3vhbWHuBiAXPrmdv6RUdXCRhGsGmF0/OORoGhdy+cC5iYQA4vzUVKhysTb0738LVp/6Yvi1JdBuQ+wgfLvkf/JouSzUzbk3VXsbxr4dFwhVTYY1Sqz4QCVyvXNfdJ9gLmnR3+PYY3wBTAg+XvHmQjYE4l1FByJ7dISL6Vdje7/16m/EDlXAHaG15CuY+IUzwGW+/eECH0lfXmYkjd4JmINcQBny/dsT/rNNisxzbUD2LTIdhI0qXqd1WWt5E7vmz1Qc1n15dNDWleRDzkTF9J/YJfrF8ep5VDnHOKi1kBll8YuYbzC8owgZCE1WQnLzkiCpODrWeW6jy3mjqV6mWGH0TmlBysDPm8PpFcOpJrNK1k4yWvq/PD1l2u
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:36:37.2385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fdc9f7-2f9c-4ed1-9420-08dc48a817ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why&how]
In some platform out_transfer_func may not be popualted. We need to check
for null before dereferencing it.

Fixes: 4b939f625e9b ("drm/amd/display: Generalize new minimal transition path")
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index dd9fe36646a3..726c82be16fa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3057,7 +3057,8 @@ static void backup_planes_and_stream_state(
 		scratch->blend_tf[i] = *status->plane_states[i]->blend_tf;
 	}
 	scratch->stream_state = *stream;
-	scratch->out_transfer_func = *stream->out_transfer_func;
+	if (stream->out_transfer_func)
+		scratch->out_transfer_func = *stream->out_transfer_func;
 }
 
 static void restore_planes_and_stream_state(
@@ -3079,7 +3080,8 @@ static void restore_planes_and_stream_state(
 		*status->plane_states[i]->blend_tf = scratch->blend_tf[i];
 	}
 	*stream = scratch->stream_state;
-	*stream->out_transfer_func = scratch->out_transfer_func;
+	if (stream->out_transfer_func)
+		*stream->out_transfer_func = scratch->out_transfer_func;
 }
 
 /**
-- 
2.34.1

