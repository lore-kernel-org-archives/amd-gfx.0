Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24518C369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6A6310E7CB;
	Tue, 15 Apr 2025 14:59:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JmP3e8AD";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 480D010E7C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxvAuXGZyYUzneqXiFXLGnA7NcNLcWK4L7zuCfjtpTYKOWw133WMAEd1OH+bZVrJ2Jt272ZAKyqK4D9jJoRuFbsctxbj/xDs40WVm9JxywNdit5+nflvI96m6o9EvygTF2QFEiAbVUKfyytwIBs6KDzUWurpYVSDeZCRFqrmpmDdE/Xc5KrLhey6VSmZTh/WbTAjeSXPqqkWaipIH9mCBN0VsYA3ph9uDfUNM52a0EpAM/VjuB2Qw3rAI3nRBkPaYCzscsknGBWvJ5SlfWp7M28j2DzOngDY2IYlYrvh+x4+rQ485ee2ob6+UGE17qURLgFIZDWzmWO5byaZmn44vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZX1jEGIiGApzIOKKcvF0Fl7xaxy92Y1uiOAv0kIABWI=;
 b=ec2ZA79N5uHRaY0WgsCWHcwzkl+zrjwbtDOpflebJlPDkYGeGex/pwaxgCZQjBazOyXvRp7meUHcWLV/2o2WsV4Il48RLYu6sN8bUsmGOxaNteAcCpE+v9vl+pTfpac/lJM9RKIUqh0W3xiNbGCYcD5gd4yxqeRheswG/wR8AhazIVwfiPSJtk703M4mqTbtA+ofKqvEvNAwMURAAFSPdHJNNorlQYmPpLqwee/7OeZKVgWU+A7TQLFi3vJV8k8EdOAYuhVGB8wjiNJmtCjNJhTDqj2h6JnoRY3qqrmrb5Q0OKpfkVBQlDEw4ndk9iqrP6UtH930VE/pWw0sCTMcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX1jEGIiGApzIOKKcvF0Fl7xaxy92Y1uiOAv0kIABWI=;
 b=JmP3e8ADfSk0QzjtLwB/6zMYlaJJi1dO9uhLYm5/KfPP/w2WGR+dXxchMhQyo2RHmRrk0Sx2PAQyGVDdSjIhv0YYo+IuVvFyeehIgLvxw/y1ZhgqCTGzhK6+h4OBQP+YAydVLg7alDgSuvATbLs1CAuMYiqY+7GzHSnH/v9DaQw=
Received: from SN6PR05CA0036.namprd05.prod.outlook.com (2603:10b6:805:de::49)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 14:59:51 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:805:de:cafe::31) by SN6PR05CA0036.outlook.office365.com
 (2603:10b6:805:de::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 14:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:59:50 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:59:48 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Roman Li
 <Roman.Li@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 11/22] drm/amd/display: enable phy-ssc reduction by default
Date: Tue, 15 Apr 2025 10:58:57 -0400
Message-ID: <20250415145908.3790253-12-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adea7b3-d296-4e44-71cb-08dd7c2e2c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pA02onE1icY77XtV1H4ACTSAw1q8eILKQMdWoyXBw37xEQi3T68zwtoddvXe?=
 =?us-ascii?Q?wLjDaBDMqpbWBUSG0s/x9Vjby61Vz1I6ByoWCB/9R+1lMLadkcUmYcaq0o7c?=
 =?us-ascii?Q?5zzKHTyJpNTsF59v3OB4eOltqZOZlvHk8qEfoJyDEKkv9vfQZ41WB/10hswp?=
 =?us-ascii?Q?pDN7NKXlsnG/x0TWMBEhoVSC9tfStGV/7TdI1Enb4T/STdTM8bXHQ0X1VuMF?=
 =?us-ascii?Q?+qWSzAEzl4jGZ40b/E/OxAOz6DPG6evD3WAS0Wbw2+5z3k3oHe4ccD1cpYU1?=
 =?us-ascii?Q?y3gxbNdvhfifepNvS8feVB8xIt7+ABd/HYniQbjOi9SCLMrKLRBP2n/T3M/r?=
 =?us-ascii?Q?ZwHQDlUNSJbE21O9MLqbTrsOYNRtuxBs0fhLsEs/wjXbMOA6PM8fH6GgLpd8?=
 =?us-ascii?Q?OVUEwu4rmcYNbr+0wpAsNjuK/LZe0hjjo+ofib8TBwdQyzERaGHoW+MmqEax?=
 =?us-ascii?Q?zfqsBx9fqEnB9LkivPjnF/e5xlu5g3mg1War5wkWxSrFpFwUMgSCzBbhrVN+?=
 =?us-ascii?Q?hC/3891pM7/FALFrhRdEV/VAFhtDT//eOHYYv6YFskl46B7SW2ucTa7vEDAJ?=
 =?us-ascii?Q?ucR4gL4B+h7Qai9t1Yb4uO8sX9E4KldWb+lQXIkR+t9osStldz51LDYNWABu?=
 =?us-ascii?Q?bz5EXHrl0ZOAfEy8echU2UjFe2aE23WNIuTxHBLqZAK1EAorqIyZPpoS0tMC?=
 =?us-ascii?Q?c9IMYZ9ZD6joqbm7FF3WxHybUMb9tfECrdAsUXNMNmlRK4NQN5w1D105FQLj?=
 =?us-ascii?Q?rP/NDmJjBfYhVh/AkPx6GBHK8k5QmdxtWqyDnlELKqdyfuq52MZxTvpkOh+u?=
 =?us-ascii?Q?tfV3Y3GxTL80W5Dyg6Iv0EIl5z38ZHyXGP6ty7uS7RHKKJIB5LOewDIu6GNl?=
 =?us-ascii?Q?CP68q0Ft6e06lZw2xt+N9MW+EKDzIFaaHVcVk8642TH88o0WC8Mie7Vuwu33?=
 =?us-ascii?Q?s4ZruTyy7dIQt2Vxcv3ANbG4bSCKf3PGL56G8RGnJCuYHwn0Li3Y2buSe+4w?=
 =?us-ascii?Q?mZ3Ec7iPhy1XE2DIpNwiCjyRUl4OZsBdcVwaj0MF1hA4lS1y7CHIAbAoLX1S?=
 =?us-ascii?Q?NMr94CPgUykZ2AybqLi6sGRgUIKl60hxyvhSyE1KJ8ugNMecqEYKsmEox8QU?=
 =?us-ascii?Q?G1t7KLc/klSBS9TLFtX1NB+/Bg/Z/njAgPNr+fS/Hti0YIqH+3x7oht7R3Zb?=
 =?us-ascii?Q?td/er0/KdI2ZhRIlAZfTflolIB4ddRWoBPGkzmBM3EyyP966C3QHUOMlmOHv?=
 =?us-ascii?Q?kgeRj7+rDfVPNLn86wd3MImhUJR0g1mxT+Cr7sTBIxfLjXRuTPS58+a6AdLR?=
 =?us-ascii?Q?ncNRzpgRFdS6u+oqKHZP8oWs2TovixgjbsnruL/svA1z3Os5qRELpP8lqnOU?=
 =?us-ascii?Q?PtUqEFi18ek++eodxeeZpRuwU0vx08VSXfqZYaKLkkU3w1th5EGw74vqm54r?=
 =?us-ascii?Q?94rC50+byMWTHQPp/eFxTKS4uetplDNAsroKyCQPvRDkkf07M1+R2UxYjgqY?=
 =?us-ascii?Q?5CVpXrQJkZCU4l2kmxATfEpZmY2yHkj9wVXk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:59:50.7197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adea7b3-d296-4e44-71cb-08dd7c2e2c28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960
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

[Why]
Reduction of phy-ssc is needed to support DP2 high pixel clock on dcn35x/36.
There's a special flag to enable it in dmub hw params.

[How]
Set hbr3_phy_ssc to true for dcn35, dcn351 and dcn36.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 46e0de6cc277..236e73115812 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1330,6 +1330,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	case IP_VERSION(3, 5, 1):
 	case IP_VERSION(3, 6, 0):
 		hw_params.ips_sequential_ono = adev->external_rev_id > 0x10;
+		hw_params.lower_hbr3_phy_ssc = true;
 		break;
 	default:
 		break;
-- 
2.34.1

