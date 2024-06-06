Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C22C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D912410EAB6;
	Thu,  6 Jun 2024 21:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZxathZOK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7921810EAB4
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AugSIWo8s0Cf1lNRmIbfMhMaT+4rwd9S8QmHRReI4hA4XNtSBAlgpJ2/h3hSOBLogztXC91Nk5/jDtkoKOSrmKQ4LcVFrFsHrlefYG08+eq5vq+npRjC8ie+dMeSBgCqV6K8ZwFawB61jgyoCf62AqfS36llknfa2y7OM1wmp/p1ZQHV9KtHPeTU+aALRcGTsodC8p7256fU69NpRZVSZEmZc4gBaLRw2GEJWAqjv2ME459Om6DXg/yNRVKcRFTR71h0S7G6uuOBluHQAbSU7DsSYCE0ImbMojUaHOiyRo31l/2B3n1DFXSBghSEpkzd0wxmQIyP9Pv2VmBkJe+oEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMcQuuxLpVSzh1+xmQ2brPx3xjYtLTJeDLtfq+Bz8ZE=;
 b=T2mOGzoi0K0Tp/ym5PWahKl6ppge+laZ4sIPPcAy2hNWbCU5jm3jISK6xpsQbkECt4IfihByqy2yE8I1YhP2A1GPJPmGbQibj/kZwHSInRkCPGsml0VHz154ExupABfRdD3pT9s0CK3gn9K7n1C1lAZc5sbIyqPPFgKyzKOg0L0/+eUWBXHIC2eHM8vchGF5Me/bVpP7u3M4tH26xyrWGjUnTkmgR2oA8spaaS5xPdEByj9wXqbnBmYcz5VbHtmv4wJHc5bzf8U/DBOshYVXh8tmn/4CQO+Kn/0XjAOxDIDLAAyBx3IjYhgBdkkkarwA0js+noBSDPXBdx4O+vSIzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMcQuuxLpVSzh1+xmQ2brPx3xjYtLTJeDLtfq+Bz8ZE=;
 b=ZxathZOK6UWVqdiI7n8qtIiTrjn/W1XJU8HyqOCBDcRnHzZBPUK9UGP//nRwNSNcZmQ31YD8hMMW0qk+sZV3EWi7W3pQ8u/GK8yiqduoX8Ut8mY4o1Aza/ujoZpzcCsjbNka/CngZHX7pdovoZTThxH6qL0ivZYzspWNZOkCxsI=
Received: from SA9P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::31)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Thu, 6 Jun
 2024 21:02:10 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::34) by SA9P223CA0026.outlook.office365.com
 (2603:10b6:806:26::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Thu, 6 Jun 2024 21:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:02:10 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:02:07 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Chris Park <chris.park@amd.com>, Leo Ma
 <hanghong.ma@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 13/67] drm/amd/display: Change AVI Info Frame version to 4 for
 OVT
Date: Thu, 6 Jun 2024 16:58:34 -0400
Message-ID: <20240606205928.4050859-14-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2f4a0d-054f-45e5-f9fd-08dc866bee82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lsGturiC66opGvM5+TNnbCQXk0Yxmb/des/HDqsdaDzXDfh/MAiwdWfCC0UT?=
 =?us-ascii?Q?8hGDk9xh86yB0h9/tSvobDoTlHY4v+A38rrtSmlvxR7qwl2ttDAvBSzweqpN?=
 =?us-ascii?Q?TEqUtQLXXLjxJegVTT2hst5LF+9ladXiBreGqYOqU4vZjyS1AYhazAOYtJ+H?=
 =?us-ascii?Q?jD3hQQ+Kp4k4dgwlo3HFby/7lTT5lDhFNygOFB7cgex1XJoxXg7Pn4Yrz0HG?=
 =?us-ascii?Q?vnFogWp3mrq1NgDbrL3YSM8u6IDOHcq9F3kN+7o8NnIivyOfSANz05cQY88B?=
 =?us-ascii?Q?I0p2Xiu5TagDvmlsxUpvBXvsU5G+DiNRB3LRhDLL18j1dz1wybl9hM+U+1zd?=
 =?us-ascii?Q?narYBNczwXBPRvsuS3zlWR8yb0VchOCEjoyKNSt3+gIUgzz6pt7aLtke4Rsq?=
 =?us-ascii?Q?JyrZ/rh0Fat38VGfmPgxx/Dwn7I08Ph2Dk0y/vXPR2CZ/xAgIiZbfiZQ22Nr?=
 =?us-ascii?Q?/4j1UzPZDBnIA8BDh8tzfidRpUhsLmQwyk9QatDRKvhuEE1xtq4fBPya6y/K?=
 =?us-ascii?Q?k4g6kAJMcY+uZ/gsszZxBlR8G/mADvdrw+OAeS9qSQDllkYC3FEw+gcLJRbI?=
 =?us-ascii?Q?QF1SzyotQEC6Nnqhun1LKmY2UgejrYzEZxPvRvNwc62DcPWSZR8cMHR581cs?=
 =?us-ascii?Q?RtLJVshtSZjP1DEy/mCLwopEEkvpn9MkZJHm8SwqSE+Hp9Ui86XAlvMezZ7K?=
 =?us-ascii?Q?q2ajXOhJcJioU4ndFoETeeSZrHG4qC+9YKaBE5v+Q7lIJRB2ULUcZIWiOtmO?=
 =?us-ascii?Q?PUQsjOsbl18Nod59I4Tlg1jY+3ibd1Qp708yHu1Sc6N/KrI/Qj05bjxJTk/1?=
 =?us-ascii?Q?vQbAFsXRR7zjcfRdVngg0Au3TEittJ6HIYi2e2dMbpgOW59iO2wJnrZZ1VK/?=
 =?us-ascii?Q?yZclj+u27exVw/tJzL9xiL914U4XLj7UtRDLVc81ehybJLOYbMJKhALxsRNI?=
 =?us-ascii?Q?zxT4DFtRYqtR3BtLQuChGVAOl7/tbjm5E9FNm4MKg9TOHSP/JBqGCFopeSzt?=
 =?us-ascii?Q?LJPSAM7ZPitOzfwgIpBeNFShR8Tkdi8SvWqr+D3FTidWFRo+1y1SdfHEbTX1?=
 =?us-ascii?Q?LcKEo8+OHmsHYyM843xSga08wPr+ufO9YUHXXoixHXMUNFaWep44mUMq/MZp?=
 =?us-ascii?Q?xFe7FR4UNJlRM6446AUubZM9OPjEjA3DAgaV5tScoDBGfosOSzZKtYLeBxGi?=
 =?us-ascii?Q?A2DpOwZbvN6pLfQIZlJAhBQLSdGVH+aO208Ym689lsszsGGOlb6igF/odmA2?=
 =?us-ascii?Q?IBDJsewalfHrT0nzegfgZ8YnONvbotRv66nUvg5dXZq5zHqTldO5zwJVrwSp?=
 =?us-ascii?Q?wTLviMushYMP3KPXk4ygZmhJ9TRIK2paIycisPSSe7epuMpjupOwoqrq0V/d?=
 =?us-ascii?Q?GucmMjyI92MTcMarCPe08yZHwspasE3Jb3VXxzGxwEuACOa00g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:02:10.0014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2f4a0d-054f-45e5-f9fd-08dc866bee82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207
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

From: Chris Park <chris.park@amd.com>

[Why]
Official Release CTA specification reverted the change and
no longer uses version 5 to indicate OVT timing.

[How]
Change the version used for AVI info Frame for OVT to 4.

Reviewed-by: Leo Ma <hanghong.ma@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 234236c43d21..61d6b5b21571 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4287,7 +4287,7 @@ static void set_avi_info_frame(
 	}
 
 	if (rid != 0 && fr_ind != 0) {
-		hdmi_info.bits.header.version = 5;
+		hdmi_info.bits.header.version = 4;
 		hdmi_info.bits.header.length = 15;
 
 		hdmi_info.bits.FR0_FR3 = fr_ind & 0xF;
-- 
2.34.1

