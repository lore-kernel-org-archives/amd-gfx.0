Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914ADCF3964
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1099410E769;
	Thu, 19 Sep 2024 18:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JcaBMWNW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BCBC10E75B
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:35:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pePCH6VWqC2Rjqgu2dgIU787TPRJggANDgYtpRALdn6qIkraHM4dxCrlyZl0Uow/iv09iGNRPaKfw94Nb//9K2zoWDFi1V9opHfhmn6MSnSbiTPtS8YUxhIKZKpItw8F1tIHILqf3AxKr1oqDGChDdTQ6O42mEnROku2wCDMPIDadcjxtcYY7USTbrXmm4iuhi3rQaJjUZUWxXr9Q7UnEJxU8mJtLbuTKpG/HkY8FIQyz/QPVCrwkgDBkMjjtQ86je0TZCx6aS4/UNrtM0FhobojYW5l+9FAQkuJSivFWvSKBW5ruVIMmVxA+wDY2ci8Zn85VbXvhkyuggYOD4F4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7i+M/rXGQYgJqxncT8n6SDJHx//M1QCdrkNbk6io4M=;
 b=XneMDbC0lTbQbvFval9fIvDeYNXYcm3rwH/YUzHZqkGF7bFV+9W9bgOLJ5gUva39H8pq6H1IrqQ6JSUX2UzXZ4+k/tHQtqawY8ghYFoDfvtNNgNKEmRFnmwy8RhWtxkm6Cun3OP5vdjdosy7AZhKc4KjJFkMSccR+tVGrX2PIruNTjs2GXzNkCWG7zmkxM0S3xElBzJyQlX27J2GXYQacTEfs8zxNO10O4YqfeDEI94i/IBQYKHpXz///MtQ5HQr69EwvdJN+uV26IHD/K0KJFbDL5gk9ipL3SIkJDhwekQKUVqc4349OyGjAXJ8DFGSvBimyEQTA1nWbtjWT/wgbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7i+M/rXGQYgJqxncT8n6SDJHx//M1QCdrkNbk6io4M=;
 b=JcaBMWNWt/rwUoVfB3SJtRZsqqFgN5ioJYWNBeXZbnH/OUKR35bnc9ELSFLunGFApsOrLDKqEz0no6WVLsjFGhAeMW7TbedSXX0r0XGrQg8brtsko+nlexwdrcjWxg4VbsBOWf+tWYQLoqf4TIJx+vXdjdhuVPiIE0mpZTn4h10=
Received: from BL1P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::34)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 18:35:10 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::93) by BL1P223CA0029.outlook.office365.com
 (2603:10b6:208:2c4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.29 via Frontend
 Transport; Thu, 19 Sep 2024 18:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:35:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:35:06 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:35:05 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 20/21] drm/amd/display: Enable idle workqueue for more IPS
 modes
Date: Thu, 19 Sep 2024 14:33:38 -0400
Message-ID: <20240919183435.1896209-21-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c87ca6-8738-492b-6b09-08dcd8d9caec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rK9gVNZotTujzVdw1U7aj55j5jdfMr+uQ4/cQeoY2r/9xyofTK6553Llef0e?=
 =?us-ascii?Q?Nqla6nINFklNCSN8mGXAavWgZzRhtArG3WMygmgmmMbbIjHmzRBE31e1xoAA?=
 =?us-ascii?Q?6vdgduTRZQ+dTRexE19ne38osZ+lDDg60Cwz7lj6vTbC79z4U7n91dNg1U0i?=
 =?us-ascii?Q?qChIWoLPu7jNId0qEB8QQAzkyTbDvvYW9SkJdZrMWQJWsDEKB2ly9MsjQvYw?=
 =?us-ascii?Q?4xzVPnw/8q2YZMrAzLV+4B2CPS70wgogc9EiS+BYx4LrjADhVNneZivrnayc?=
 =?us-ascii?Q?f1wSvUaV3VsjcQEMEoyTXWt9sB9x1HIHRnsLKqIeM61j4vGjsLs8G9Tse/UM?=
 =?us-ascii?Q?2fKu8EOBZZDhPEzr+d43n+H9JM70mweOtlTVOxZV0MRoSMao8SEQgufIKeOn?=
 =?us-ascii?Q?4uD1pUJxVZHbpMHitbyIBJnJ4U4ZIK47BrhHV1up0ShsxtoAbfjhE693hR+y?=
 =?us-ascii?Q?Yf79O6HDsO/xaGIrlzwHdtVmGRj+aiPQR7os/HNYeyDYQqj4iLpj693wIzuy?=
 =?us-ascii?Q?OkUhZ6Vho1mdewipyWuE6uz1c/tSruLAvl6LRLQfyU8i8NfdUf6NFa9YYLjK?=
 =?us-ascii?Q?OCwys/nu/eJwtERnj8Q+TUTjYbbOWtUvCNXXWJ164XIZl3gG+AhL9SCxrhRw?=
 =?us-ascii?Q?ai6FnEud5vacjemQD34bepWH+fsnrLlMILhJx5d3f/h+abl7UpSmoabgKK3k?=
 =?us-ascii?Q?UXPQvOsiUeroduaKj/TYkDAju7liJdiDza+BN0EbrzI5jRXgAf65JmQ0wGXz?=
 =?us-ascii?Q?DdrasWGOnaWAeG0QJBxvKyIr21VPQd94QgoI1xsZlzetUK7DzJi5GOzRAOKZ?=
 =?us-ascii?Q?avES1LbdUEwoR/N4qmi1KE2sslVKfuWy21/dYyfAGjY40EUK0oPc/kZipJvC?=
 =?us-ascii?Q?ohJpRJbMTTccq6zDZ4RgiBB16HzuGP+cBAkX8FJkgHyrNEsR5k6iFsHJFJSP?=
 =?us-ascii?Q?SOMuUuHiIX961tGXgEBylvB3PsRqD9ewOf8NrpCQ3IxtOmMd17F8cteR5ZdW?=
 =?us-ascii?Q?Dq/1vmtKG2DaG3Ok4AfEnXdRksECSCGxUp1ene2Z4slCS4QiqN7k37NhFCUY?=
 =?us-ascii?Q?ZHUVReiUe4hXdCAOY55NAXL5q12oZnyT/GeEtHnybqii5hcvdN0mg9VOjcQN?=
 =?us-ascii?Q?cl2XVOk2qu+8mZhi902ykqz91G01NRd4mjt5U2C5IFstSAmvy8jxM9iiyKXJ?=
 =?us-ascii?Q?B/tm2JmjEDwYOMB3TOLtk9mO7SJK9LTUW5jDWAhZAuAb2vsswuDi5gXZ8lR5?=
 =?us-ascii?Q?dDIkjbBc9Nx/cGydzgUmbuY0TTCdl3Vxk6c+ZcwdetNutRwr5NjJEPT/lM3G?=
 =?us-ascii?Q?M6asv82hl0lnJoEgUKXhvrC7H9YWhDwUFzYKxjfPaz1gHiXsrZtKeRWY6z0l?=
 =?us-ascii?Q?wLFRMuvkQpQ/aU9BrB76FMJd6N20yPHSpL7mQMAI4AW6IqnI7H1W3JQNC2VK?=
 =?us-ascii?Q?C7clOZCs9SgYQzHemrx7wsdVlJIuA8qv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:35:10.3137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c87ca6-8738-492b-6b09-08dcd8d9caec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

There are more IPS modes other than DMUB_IPS_ENABLE that enables IPS. We
need to enable the hotplug detect idle workqueue for those modes as
well.

[How]

Modify the if condition to initialize the workqueue in all IPS modes
except for DMUB_IPS_DISABLE_ALL.

Fixes: 514fd3e75d90 ("drm/amd/display: Determine IPS mode by ASIC and PMFW versions")
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3bf2db3b3059..58973bfe319b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2026,7 +2026,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			DRM_ERROR("amdgpu: failed to initialize vblank_workqueue.\n");
 	}
 
-	if (adev->dm.dc->caps.ips_support && adev->dm.dc->config.disable_ips == DMUB_IPS_ENABLE)
+	if (adev->dm.dc->caps.ips_support &&
+	    adev->dm.dc->config.disable_ips != DMUB_IPS_DISABLE_ALL)
 		adev->dm.idle_workqueue = idle_create_workqueue(adev);
 
 	if (adev->dm.dc->caps.max_links > 0 && adev->family >= AMDGPU_FAMILY_RV) {
-- 
2.46.0

