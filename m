Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0723EC35FFC
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 16:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728F810E54F;
	Wed, 19 Mar 2025 16:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cfgkZJY8";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0582110E54E
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 16:24:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSNPXJRGem7gUwTxQpxAh/OwGnaI/TIPIHa6VHl0h0Hk4rp6sYEyXBBB+/tSYNWfgT3xjur7K/Wr91odWtriEB8wIuosBPXAXrWiAjMxZswNqbIizoYryaz1ZY2ItgOjO6s4htQWecmOAWd78CFF+zdKP5kUkmwMvut0sBqkmJn0o9W0mSwfSOudsQLnsBSZBWlUQJUJ9ApvQTzE0mzLU/pHFDRdq605EDpsqkF14IEbn14p3opmeAK00BJQStDeYSxC1e91HOBFnVBmGcflzfEI5QpixdSRdkep1XQj7xrC6hn3tmBYQOWzM+cDOf1Tx2H1X2a4ScCN1CJcpGsLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2uss7TiOxLoxf5A9rCxnxPPzdflr1t4STAzBrM+PF8=;
 b=MueT6oFsqM3dSrWqdXJxWBQdb9sAI8UlNMDhIPbkovNRmViOqx6W8K1KzJlGq0WxRxY9kYLAHtu36nscZRxL8ORIorC7Pm4V75EqzGw2DC9vBRGegljTyciCWkInFhBSEOasHTu3fTkUF0bQX6vnjQz2auRZmNQelfrexAnCRB/1E1OsCMmAa7paewnVpLM07xl2rdHLzoYoP0UR4K711cqWSp6s2gI5BeS5ZBpAaiZJjwtDBkYUDPalEA5mgIpYiOZGPB2XtdL24I9Q92t1alXMa8h+hlY/53t9PncKWIXbGNk2BjcK0lJ2XY30EUh1OWKw1RvKMhP3a+I5q4BRig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2uss7TiOxLoxf5A9rCxnxPPzdflr1t4STAzBrM+PF8=;
 b=cfgkZJY8HHkYpdvtJSGfUZqYABjtNewZymEFJPUiKcKvO7tlGNm7iCZ0mi+dVWQbA/xGds3cImmbfUMgAjepM05CVNBNQ9u0ZpTBqXFjI8uQo1+e/jm2kZVm1FfmRmgLp2LyCZ7BAfXH1TPKDgLZtK8MS5nvNfYkUv8nMf9ETeg=
Received: from SN7PR04CA0115.namprd04.prod.outlook.com (2603:10b6:806:122::30)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 16:24:29 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:122:cafe::b) by SN7PR04CA0115.outlook.office365.com
 (2603:10b6:806:122::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 16:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 16:24:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 11:24:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/mes: enable compute pipes across all MEC
Date: Wed, 19 Mar 2025 12:24:15 -0400
Message-ID: <20250319162415.3776175-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319162415.3776175-1-alexander.deucher@amd.com>
References: <20250319162415.3776175-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SA1PR12MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 612750e9-d0b9-4731-5f9e-08dd6702866c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0ShU+Fg7cAX74CJwpROgIVJw3j6QBwx1Ir8ZExeD3R2LOV6tPRFtEAVkFlDf?=
 =?us-ascii?Q?2PiS7UzmmLO5kwdRGmlOpb8E3uRDIHCt/C+YhU2ZmEZhvHwB938TKt3nFmXe?=
 =?us-ascii?Q?5rZoxYiF6h2yXEbqquIZNkw4DPb0D05O5zIztvNQygyL0zhO9/yTepkkbVtY?=
 =?us-ascii?Q?GPzC+TMwFdbluRA/FzU9DrLfd6jDVc+DdMs83Dszt6SN9ESNmfhJYcsBPGkh?=
 =?us-ascii?Q?OFIrDuxMbMWvzkIkUJXPVyNHxgS8ExwfB5nvh7cIUM5CFicmBj+Bn4vkJXHA?=
 =?us-ascii?Q?sCOvhp1s2gBrzKZs2rBXrMF/QQycNgi9hXfRwlULNXISiMi2CF5mo3CXjUfO?=
 =?us-ascii?Q?9xF0NL5wRC+GtBrFPtL1/qXJy7PRHTyIVO8ArDuoVQB28Onb/Qh2jmuaR+O8?=
 =?us-ascii?Q?mZmDAcSPt7jGV/tlb6iy4WI0k3PAWil4zvhFJ4VU/QnBsYMjRZDCRGPfQKKl?=
 =?us-ascii?Q?Y365glR6ttoK9E0ASZBwJOxkh0FvZoJ3eZIeeXEZCXVUfHlWlwf/JJyyBf+B?=
 =?us-ascii?Q?rdkHqWRI7wibGCipNbA3eZumQ6ieBVfNV+AGXPZ3WTj8/scJ7d0WH408f8q3?=
 =?us-ascii?Q?qJ4zYmUG+IF6wJntK2HAdqpuNjNwmo9hId0LCAiZIDxxlrvD5az07/QiyXGP?=
 =?us-ascii?Q?YWIniW1SpY+Yq8g+XtKnHSAR59cwUsshzd6W7Jo2GfOeqJYSwLZWrqqggfdZ?=
 =?us-ascii?Q?UJPKDhKyuShO36k6OkTcE1TD2BVsPHA53EMLxQTouNlsrCNm4WeT829gyLSn?=
 =?us-ascii?Q?BEkUiDT2YvUT1ud9FlBM1uAJqarq4k0EmwBFXFu9zlFUebbFW9ui33wXcGaO?=
 =?us-ascii?Q?JvADT9ZfJhdNka41tZg+HJ5FY1kYfyb5wcIzIRVdpmVfjc9uq6M8TUSpiUWn?=
 =?us-ascii?Q?+D4LWUVBQUvNcldX/Wzvuv5C5T2xCZa3uCEWWlXmtmACFMJndyCGr06cPgTj?=
 =?us-ascii?Q?Lc08zTHXjkqZYXBQg3SN88o4azcYqnZH3z1tXXGDlO9chGgXJ56Kn5/H7/kn?=
 =?us-ascii?Q?3hRP+1l4YYTsQX+XB+/TyMqg8Yi3H4vO8K1A/4gs4mV1c+bgUrKATiVXZ/25?=
 =?us-ascii?Q?daGSXLxdLCz3bYnjXZdi4zDQjtMBBp6eGuDSanCsyMI58UV9St6BF6k9NFR+?=
 =?us-ascii?Q?wEvHjPoil13ePvXBcVJsqZMUZo/cC6ZVmMb+ETFaSAxAOk9VGuU5ajMmuMqM?=
 =?us-ascii?Q?g5pocBRB/u9ALHKVb0tXEgxDUkySEatdjPxeSkKRcBZuP4VeWxym6k29Z/Iz?=
 =?us-ascii?Q?4krQHnGSi3GuNQLp2HpNV3wvtEbAmvt5fc/eRMHAKTUm6VMAwtR71ss6IRvJ?=
 =?us-ascii?Q?TE/pVCH+D8838OLDBri+R3Hx0K6UnN2sHTtud9T6aKTOrYMlE6uz0wSkqFI5?=
 =?us-ascii?Q?Wpa+NIhJkt6GbITCPW6DF3g0QLTMWCBl+5mgfUB0MbRHoyIi4UpZSr5qId8G?=
 =?us-ascii?Q?iFi+0w6FkrLjxbqK5Ryy6oLkhc/OLhd7lHlaWqN1UDUQgFSujei+NC2ySp0j?=
 =?us-ascii?Q?01xN/nzQwf8B+yc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:24:29.8698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 612750e9-d0b9-4731-5f9e-08dd6702866c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920
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

Enable pipes on both MECs for MES.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 920cd1c1eacb6..b8066c0b9014f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -109,8 +109,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	adev->mes.vmid_mask_gfxhub = 0xffffff00;
 
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
-		/* use only 1st MEC pipes */
-		if (i >= adev->gfx.mec.num_pipe_per_mec)
+		if (i >= (adev->gfx.mec.num_pipe_per_mec * adev->gfx.mec.num_mec))
 			break;
 		adev->mes.compute_hqd_mask[i] = 0xc;
 	}
-- 
2.48.1

