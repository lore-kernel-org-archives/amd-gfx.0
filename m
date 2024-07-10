Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D893C3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C353410E8CB;
	Wed, 10 Jul 2024 19:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GBHkZ2bV";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F0B510E8CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOz/IK+W54vOsH9RQO0kSqzRCtRYhiFsp6TRDKA4UFqvatX83pVvkz7oXnQUt0/71aNlqXeC4uF9dVebl4iI8cmyXYNH1S2tVR4yL+nVOXsrpIn+zljCxAzGVPeLZOmiAMCn8bJQIIUi5GTL7OBdY8IgqYXyJJGGxnyPlXaNgxUygxq5qrmUN0He0mxoO8PR0kxStRy+ox0ugPBxmd+9POAhkQmQgwBjhmVWDG/WWn1j1CxNaXbt/8XepfyXk/bOGXx7YcqsQAPtDBU7vwJtQ5ZmrlViPmBKjRasvxceEfSI5Rkiok3QIFpTj0iDM1171ndugrmrRH+9O3qOI+nKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrfSHqcGrRe9/4kglVwBE0xYjwId9FgfuUa67WGfgnE=;
 b=Uh5IB5rMdRL3P0K8ReV/+pxkYH8HFWFJWi9mnSbRufi63gDipnXtWsfMIZhI6DIUYuWnxRzUpD9cZpkqwk6fdzR17q75qwxTVse+bujm5wx4GgPBjhI92/QrxuZyKuDioFdXrx6RRPZCZWvWcSyfz/MgLKbUYL6blUyh4bV+pQ1Z3ng/UZi5+MJNbBPy2glVHLaWf9ss4WgV2MO7pwcfxVjFhGe2iDy95AKN5HXN9QiJAATx5c7ixlzRPCz+2scPdN8lDhZFwaGTEGcTZp5/wEIVJ7sIpQLF6tZ5V7YdXhTAFrVsQTjWSkyMVeRp841qxkFXDZaiHAnIdbsLZ0LEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrfSHqcGrRe9/4kglVwBE0xYjwId9FgfuUa67WGfgnE=;
 b=GBHkZ2bVA+oBKzJBwcMd5eKmrlyEWOB3QKcugp2NZvbfO9oRjmYuuDE6D3KpStz33xh8XGybvmpN/K4ExG7SuS9d8bYhyTZg1KhkXh3G7RYs0jLVGzxBIBPR0j1WEIJznaqOozyDf9bhbts1mnTdAgCzvZY7fcnskpqSEmjnSRA=
Received: from SJ0PR13CA0097.namprd13.prod.outlook.com (2603:10b6:a03:2c5::12)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 19:40:34 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5::4) by SJ0PR13CA0097.outlook.office365.com
 (2603:10b6:a03:2c5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 19:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:40:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:32 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:40:21 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 45/50] drm/amd/display: free bo used for dmub bounding box
Date: Wed, 10 Jul 2024 15:37:02 -0400
Message-ID: <20240710193707.43754-46-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: c59ffc6d-5087-4261-5e9c-08dca1182a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1IGxWSDi/1t0fuVQCKOeFIE7M7KxA4xq/kYPTwqihjkSfCySBBpbwulRG/GY?=
 =?us-ascii?Q?UFLExM1YySZR7qZGRg5QZBUPJxnCQ4qc3mGIvHO7uLSjdlj0KMMssPsWktB5?=
 =?us-ascii?Q?F5kqp9pl+bygfUVEigix7q653CSK9dg+vZP63MwniTnXjqfS1v6IWlQ3zKDv?=
 =?us-ascii?Q?gw7RhI9SFMPs6K+YZsQ+YncI8QQGG3KrLmYDlNXVZIkJ05C3uym/APkY0Toj?=
 =?us-ascii?Q?IBCTNcarEGHCBPHWJOEIoQyVnSItGkQjT9J6hYYCkjA6zn+/mkCVASlMHCqR?=
 =?us-ascii?Q?6exTZb7FYZcwfQcdQ9z7HGL1/b1o0uM7n/FXjxVMyvbzodviy6jkcOtPs09m?=
 =?us-ascii?Q?Q8P7AkPFrVktqMg/2/jQLpkb8WImELdkskJMPItkYdnzltLcRtiD9Ug3AQ+i?=
 =?us-ascii?Q?csPRQEK9GH6ifbc8tG9+WITgasD5dbiSxIw9ncLXly3vMqNJrZ4/JI7XC2TR?=
 =?us-ascii?Q?2/Dg/VEp295IhnSVu6MI4mLLf0cjul1gXojWUS7cgYnP4kTZ7dQ6VVS64STy?=
 =?us-ascii?Q?8LqFEvcqgWQ0XIpqiz+UEJdB0pEEmfOxDUK/Y9VXnXHE8CzDxftE3mQXCX7z?=
 =?us-ascii?Q?J/uomzNzO0NXf38uvk8xM8CyudmXvOdROmRyi4wQhyNrHiAkZcTIy5KElPY5?=
 =?us-ascii?Q?rxV8I4MaDeSAGoyqc5LdSjSYrcqMLEy8t/4JJ4wwYad2cmrpg0Tb+cr7Z4/D?=
 =?us-ascii?Q?z3l+5jy8mQJsORIIa6L8bw2ROxYsnUe8XjKpfu5St4t80uvrT/T40diCxCO5?=
 =?us-ascii?Q?TSF8F2q+vv6cNhmbdagyajnFMkMZ2MNynD47EQ6O+2JES6dO3LXAUDR7yY8L?=
 =?us-ascii?Q?qK4xsz08C/Po11JAMsn4v9zpdkQBygclHNylieW6/2WXs+RG8X0BXCcRgP7f?=
 =?us-ascii?Q?9O4hnS367YF0Y0AGtsvNmS1zJZwcvVXbxRc1wMgQrL9slpthhBRyj3D+gxqX?=
 =?us-ascii?Q?NAcT+uxOaWG80ZkA1LXBw6z+SSmF+3+M+cklpXrp6xAwpKr9tZd3uxdD61i7?=
 =?us-ascii?Q?ScuxL+CXN1c+MPcprfwvQUNiwMYy+uZGR6O+vAAcnWwdNNRZ1OX7q/mdLzXw?=
 =?us-ascii?Q?KvV/4/UQJoJKpR5a5UlDlV6TmDGcEwgLK2LateiqltFHP63Dx69I+2qQRPoN?=
 =?us-ascii?Q?aE5M7MMyQp6QrZaT5B52/biSnz8f4lE/jvqEzqUwZsjt2j9tWqmw5FnrSv1a?=
 =?us-ascii?Q?VaUTpUR4kmjcyYFdsJqP8PwpQfthVIjQFxjC7tHdiN11lYBHxWd6m9Jd1wBe?=
 =?us-ascii?Q?xA+IN67DyObmuVW6a33FTDZvemD3xaW1G/y5SZMh5J7yGoP0ZPyl7UlJkg8m?=
 =?us-ascii?Q?BMRHyj3zCTRE9IdDoJIkHUWrXmBrEVpeVmIK/LglC14XDj+EsICa1J+GnNyM?=
 =?us-ascii?Q?Na322tITyMwqIOq8pLFcoc2dStDRZcjqKJVbMehz6S8tzz1Zi3IRRRW/QrKU?=
 =?us-ascii?Q?/5dqtqgnxg9W+ngm+ROJWIXwUw8SneLB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:40:33.6660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c59ffc6d-5087-4261-5e9c-08dca1182a3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

fix a memleak introduced by not removing the buffer object for use with
early dmub bounding box value storage

Fixes: 25a40071e ("drm/amd/display: Enable copying of bounding box data from VBIOS DMUB")

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 864a66406f8a..d6be73d74b95 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1740,7 +1740,7 @@ static struct dml2_soc_bb *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *
 		/* Send the chunk */
 		ret = dm_dmub_send_vbios_gpint_command(adev, send_addrs[i], chunk, 30000);
 		if (ret != DMUB_STATUS_OK)
-			/* No need to free bb here since it shall be done unconditionally <elsewhere> */
+			/* No need to free bb here since it shall be done in dm_sw_fini() */
 			return NULL;
 	}
 
@@ -2465,8 +2465,17 @@ static int dm_sw_init(void *handle)
 static int dm_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct dal_allocation *da;
+
+	list_for_each_entry(da, &adev->dm.da_list, list) {
+		if (adev->dm.bb_from_dmub == (void *) da->cpu_ptr) {
+			amdgpu_bo_free_kernel(&da->bo, &da->gpu_addr, &da->cpu_ptr);
+			list_del(&da->list);
+			kfree(da);
+			break;
+		}
+	}
 
-	kfree(adev->dm.bb_from_dmub);
 	adev->dm.bb_from_dmub = NULL;
 
 	kfree(adev->dm.dmub_fb_info);
-- 
2.34.1

