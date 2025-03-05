Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F56C282D9
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA8C10E6E9;
	Wed,  5 Mar 2025 05:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B5oEsLxa";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C9210E6DB
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmQn7T2q3VSAp215MGK6bQLESK5tsXXSFSUS27tDPq3TqCAJb7CjfPq63YIwn58T7iis5eP+bC/p520lUEyq6flfwR3i6h/Nj43qppCwW8YQN5YbJWMz5NqxUQ5mkRVfqvFtdhHSOXeP5lW+wu/DcuBoDGqrAqjF6E9OWPcr7nwwgar6RwzkqsQ6noiR6KtMVP2kN6b2wszwx8Ut1znHQB5LpiLBVVIZaw4BgeJe+JlQYpkfugz2Er+Eo6bRqkq4aMupmGNeoqdemYUvzt4OHtNQSNdIGVY+BVxzrgPbnQMPHfhGj2rmsjM0WDxyJehsOrQbmRgb27hF9ftBwL3WnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q88H83Zi8EHrCMJQ9hX9FeBc7vW7MUc+2D8fQrXUY9Y=;
 b=LQeO3gwch3uM/XX/xrQGAkwzNxledvgno33/sbZTRTxO/hFb2pRp+u9NtMt+6Af8n9H8SwOajYGosBkQ1E4BPZvBNIIN4zmBY5TEbX9MGoVlHY+dyUUnWRRcCFGQVRp9iOMrd2DBKOge7PPbL986YYPp/CBazT84QL63fy8LGun/VORG8PLuZDLJ/Ky/Af9YXcx6B4KvlYr8ZJXlfca+JjorcFPFvOB1gtV+uJv0jXiHLSZTsUD/I3hYLoG02b2Um7sKTLXfjDa0dVC9CH8OOSn+V/TACReQT659+mxKym5nGdikwITwAc4xCmbsQdXlouWK3QSRKd9fliWGju1O2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q88H83Zi8EHrCMJQ9hX9FeBc7vW7MUc+2D8fQrXUY9Y=;
 b=B5oEsLxasjvF89x2JwZ6En6YMmzhZZlgeA8EsxHHJ30+Me/vb6/4TXs747W1ICuIrPNHH0D2Pg7wmhRLHAWaM4kNNqSTqyqBeic6vOCFjPxXJWR82Eb0q5jsWfs/VjNJew5f6N0ZDviUiTlH/S08geQMnSH8IqgNIvHsGfOvPwc=
Received: from BLAPR03CA0111.namprd03.prod.outlook.com (2603:10b6:208:32a::26)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 05:16:25 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::71) by BLAPR03CA0111.outlook.office365.com
 (2603:10b6:208:32a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:16:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:16:24 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:16:24 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:16:20 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Zhongwei Zhang <Zhongwei.Zhang@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 16/22] drm/amd/display: Correct timing_adjust_pending flag
 setting.
Date: Wed, 5 Mar 2025 13:13:56 +0800
Message-ID: <20250305051402.1550046-17-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 4413e81e-1e3e-4559-73ee-08dd5ba4e038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dd5GkNKngJu5IzCgrHNVsTHS7zf9qT32/VeXlniAHaG/+UxEwcK6X9zzoJ3f?=
 =?us-ascii?Q?QVx1U4oDgIK1OP6Wd9EoT89HJpQj677liChmF3Af3lOQ55ybZkWKYC6vYc0L?=
 =?us-ascii?Q?rppBpHT+8Nqc37Ev3LUOsbMSA+Oh8pnWwB2xLdKOP129vTyBRQKCYODt4PlP?=
 =?us-ascii?Q?PTTyVFGyQMSpWWqcNJ0ClGCIKUajQ3Rsn3dLznCpKK72srmIYOEpx9FOvi9p?=
 =?us-ascii?Q?bL9vuzf0VPubJg9jCcF0rje6qwrz7/q5SHF1axKPvikWifVevkiDjDEhWqeh?=
 =?us-ascii?Q?U0yJHt38fEzhIAy2iTlKuyooo5yT0MrGE0dk3GI7teWMkpH9x7Co50vCtSgG?=
 =?us-ascii?Q?pTvWMah2XmAJaJaBjANO30fa+tOJfLi6wpJjHE4rBAZWK2QB/RfQB9BF69H8?=
 =?us-ascii?Q?RsjrqDbf9MqsZ6CSYSLH9btcwxSnckBx4xiVE3Xc1nmAPAWa7lfLRiYm8VY7?=
 =?us-ascii?Q?B+LE4sHpTk2FVMuEAGtA+a7UcyViXDVdGRr2iXqux/AgV78G1cCvv8/458gi?=
 =?us-ascii?Q?5WnX2oP0fYkVBZ9YqJNXMUsaYsuCoQg5eqk6wUvrP2qf8auEK6mf8etPbjSd?=
 =?us-ascii?Q?kPLWlsYhZ0EomujXRLrRtuihCWpdVjZICO1Y/ann3kOR0mDnjymA5dU54G+L?=
 =?us-ascii?Q?BWNJH7hfSIkMVUcd7FdECNoM7zp4gLtRcm1d/PzCwfrqC2p8hMiP6g3phXlV?=
 =?us-ascii?Q?Aa+wDJQo7y5njMQVpzhppg37yCW5gVo1WkmYZh8ltTSeksuN4zhcK5wRXq2W?=
 =?us-ascii?Q?gkuil0H+MOS1FojbLqvjf2Kc8Di6s4Ci4oGn85OUObqog8VEhMWfRXXGvBcU?=
 =?us-ascii?Q?OTrryVIMN4Nk5do4qgSdejoO6l3yxXqynEfcGoitANKZVJsrcPr42XwxP21W?=
 =?us-ascii?Q?+06nzSL1OYEZtH99eqJdI98EI1Du9OdFtobRGCY8pSAU+Gacol/ezbFo9a2Z?=
 =?us-ascii?Q?U9YdbaYqFruHzT9SNsaWXlBjzLEAN+xnjQS9zr2qzL/fRoCeEGdMIJWjXe2O?=
 =?us-ascii?Q?1loU8P8CwGBCmVO06fwuDg22W8XXkPBZt8Jv0ZDPRVAP611GfhZHOrzVHriB?=
 =?us-ascii?Q?Vc3+LPxj/1T/otGJD2Tt3nMxXtxYosVIZckP7N1JOdTjMc07AxCQskFlgYYt?=
 =?us-ascii?Q?mCQu5bd4KH3vP+RbqvWxKXC93P3JcyDIVkKAgG8e+k67fBDqo+gXoWuzwcIQ?=
 =?us-ascii?Q?w1007UGTmvk4NOqg1QvJs4uG9hjtFWwFlg8VDUIHBAFDFrjeDW+mjKeIWc22?=
 =?us-ascii?Q?v1O6wGrMUT/A/70W4QXqYk6DgsJodIT4YsM5r21BVSUQS3girkG7t4Oqbak0?=
 =?us-ascii?Q?yz+h3GfqmNL2VhLLSi/nFwvKCXmBcJ2TqbhN0F87MUzyfMj2abv6pT/4RUpf?=
 =?us-ascii?Q?1sk1288NWysIE9z1SaveXLoSM8lHmM5xn755poLLbecc2tYWK9RTrLEj6yHS?=
 =?us-ascii?Q?Ev2drYUaIbg8qE1TN9x9ijr5718/jPXcyyQYMB6Igc0je7L2wW22g2JMx93Z?=
 =?us-ascii?Q?TrxEMScuxaIPHNg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:16:25.0569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4413e81e-1e3e-4559-73ee-08dd5ba4e038
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
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

From: Zhongwei Zhang <Zhongwei.Zhang@amd.com>

[Why&How]
stream->adjust will be overwritten by update->crtc_timing_adjust.
We should set update->crtc_timing_adjust->timing_adjust_pending
and then overwrite stream->adjust.
Reset update->crtc_timing_adjust->timing_adjust_pending after
the assignment.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Zhongwei Zhang <Zhongwei.Zhang@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5a43e4901cc0..28d1353f403d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3169,8 +3169,9 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->crtc_timing_adjust) {
 		if (stream->adjust.v_total_min != update->crtc_timing_adjust->v_total_min ||
 			stream->adjust.v_total_max != update->crtc_timing_adjust->v_total_max)
-			stream->adjust.timing_adjust_pending = true;
+			update->crtc_timing_adjust->timing_adjust_pending = true;
 		stream->adjust = *update->crtc_timing_adjust;
+		update->crtc_timing_adjust->timing_adjust_pending = false;
 	}
 
 	if (update->dpms_off)
-- 
2.34.1

