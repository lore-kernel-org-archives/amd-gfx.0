Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD31C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8568B10E44E;
	Wed,  7 Aug 2024 07:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2/w5AZUT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2222210E44E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zey18AmCIPb6dbFVf+JkAlUc6yTtZICpPf/5Igm0k58Z4PMLU1P5axhVP0Vs3CBDRfJdKjhbWeNqbKFxuIl7rkiOQRa6vmeOKt3mVfwDpIx9NA6ShSEeukyJIZhlcsNrFT1NCOnu7ixQnz+FuKW/3YlsQOwjHAozC45+F2nxBSjE56HsfzG4vwDB+FQUIkehTHTrtgfsSquoS8hF7G7cQra8mgZdpXq4i4W558cu/Jq/kKh27QC0AX3ldxq4d/QCMplBI2caz78DOR3FI0q9/dEMvLisiWjg0TcC4lmTwF+SYLgJo5h3zzyXmVorPCEZGsE2oVH8GkJCQWzVhwcaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbJdqdhWc48XOLr9pp8RJCPCtaBXA4h2li5xn0MTSq8=;
 b=sFmStIDkmU7r1NRpq4c+K+fKSkUGWugcWrnQx44PuHh9ZXFvSBkHIwwL2qZiHggETcoua3i0hcx/ZNwI2c0FVtWScDXpRxm4KNSyzLQk/eOAdLBxWYyy7b7xaFDWHYq5q3mWL1OReEaXZQ5revfePxlu8wnM2HukJlNDozr3eRbyijK02ZirFWdyYl9LQLnset2+zBF59+LxJ2Ab2+5+/VMYpOoNl4Ck9Z5N78VsvPzoHVEmYNGSn33TX9agdRLFhJORYAnhkCCdqfKlrnWDRW9BCEjGzgNxlyH9Y8QOnWwm/REVPVzus2aKNOJLHgBVlsFfVQk9C/vvJknbuWvZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbJdqdhWc48XOLr9pp8RJCPCtaBXA4h2li5xn0MTSq8=;
 b=2/w5AZUTaSvFllwT3dnX8fMvni4frhhnzLdYaVtUeko9gUEDTIzqL4g/eagkEaw85j0r7kJslKWhtt3THvCsQijGI2neg0esftUWAR1WtCMYZj74l0asSNWyZQNEk0+afFCipd+Ssq3dM9nyuB/xHKFxfYyYY1g010iip/bidxE=
Received: from BL0PR01CA0020.prod.exchangelabs.com (2603:10b6:208:71::33) by
 BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Wed, 7 Aug
 2024 07:57:43 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::91) by BL0PR01CA0020.outlook.office365.com
 (2603:10b6:208:71::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Wed, 7 Aug 2024 07:57:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:57:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:42 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:57:39 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Martin Leung
 <Martin.Leung@amd.com>
Subject: [PATCH 24/24] drm/amd/display: Promote DAL to 3.2.296
Date: Wed, 7 Aug 2024 15:55:46 +0800
Message-ID: <20240807075546.831208-25-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb0e91b-c412-44d2-60d6-08dcb6b69e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lkkRTH3bgCli9D62k6hnhakR3Al7fT62z0cpnCv4BzB5pTvm7EW/Veb6AhTI?=
 =?us-ascii?Q?BWSeJphBUhIT8DtWPlpO1GCgk/0DEoy03Ri+Gcj//0zyBsGvwKEID/wOwPR2?=
 =?us-ascii?Q?LFT6XFLNqtm7mayroBeyhz2HRLOa21g+gml6r2VipvbiwxvdDBeBNbTV176t?=
 =?us-ascii?Q?8dKpSL1dOe1Roz+XrUVgTchjEKdTauyqohuJJwzNrBljZL0mrHcxqUdL3dMb?=
 =?us-ascii?Q?a9lBTzSTIhk+RRpU5p9Rp1z9AyHi0GkHAw8Xd7lXbRFPvO+fYFHffUC+NkUZ?=
 =?us-ascii?Q?61MM63YWTjN824PfqeZwTnwlFB/NIzEL+p158VTJhtl725yZzxPZyILWtN4g?=
 =?us-ascii?Q?OL4MJx32u7LV2xUuJyD5YipJUSBlEdSvPDo8vyMpgNkzra6CY41osDqDNbJY?=
 =?us-ascii?Q?XVQww2et6xCz2EqWE0euM7Vu0jFf7I8y9+Zxsn4I0NKeGWHOEOoohzb2espu?=
 =?us-ascii?Q?bw7pGziBqfdejy+QhHpJzoCnfsLnboM2zg3TKa/XNp1C6Mw2fJ5xxHoCkAwB?=
 =?us-ascii?Q?X/PBgG+vmfRRmiLIkMKbXMPB4xD3Ts0uyRu3VuTqCoSllup//uUYBxhKsC/U?=
 =?us-ascii?Q?UbhK5thaIp7aI+XuXWv2ljaEBP8FRxoT+AKdZE26ALEn1cjMT6rTst4n+4qg?=
 =?us-ascii?Q?Vf84KyWUqmylFyp8bDqbFaUCs8SlvvUwoXlt8S4SuGfinaLaHyF1FBvb/aoH?=
 =?us-ascii?Q?cDD4KNOu0DCEAsl2geuhUsD+k5QEUsoOH25N4V42m0vnRx26NFh0k+p4hB18?=
 =?us-ascii?Q?Jc++ZgAQhHtCKdvJCmSPI96lnPzIXx4Za356Rqa+cyRbBaXp8v1VKbr9hrjy?=
 =?us-ascii?Q?Ik8SZWFZW+VvxoAFMOIghoGADXqxrktARRfEsHd5C7JLdiKeB77R2WHC2Wdf?=
 =?us-ascii?Q?hJ0cBvoeRRuV+h8+jAT4gmIEtuJcKpibV13XZvalE3BWCHkYyjaOP00Pv0Yx?=
 =?us-ascii?Q?9bQoSYPz0DqT8AS0EwHdAKXyy2/6Vy2SKkko2QkWecEY8cfna6HigqxYGr3s?=
 =?us-ascii?Q?nIhNyNjtjvq81nmmxnS9ET9s/wPjcE/j2G2CUPeESE9nh1g8E9fKC5r0YpWd?=
 =?us-ascii?Q?3dG8JSWP7k8Q7mDiatNG+8bLmyPHbGgdVXj9qlbwhdDq3FUKzL5LZtsM68Mb?=
 =?us-ascii?Q?lS8X120a0wuFEhEkrI7OO5fW7vaxNLEWPDklbScC61IJroyQutj8NUWuhNv4?=
 =?us-ascii?Q?slS/EFI8uZhfzKvm9pwaiICJzSlEEj8TEolnbDozrxbIOqDMK3c9lt0z90vQ?=
 =?us-ascii?Q?OwEiGNeajErHGbLxM6Oa8fG+9G6g6evkIoy8IKpBGS7HOwWxuRD5P+fZoFSL?=
 =?us-ascii?Q?EjqWZW/vZDC+XtHOTXwNLmPYYvjdSZK7Mp13gZN3AhNDgJjSIIb6NgSqHPFB?=
 =?us-ascii?Q?4nWKl5TOt5vK7zUZCAcuLjFOeVzfGVrmYP4VQUsmqBpmQCDas04TyxoHaSNR?=
 =?us-ascii?Q?A1hSUbtkhG8neh4j3nJxXLTwVKuhyY49?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:57:43.4767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb0e91b-c412-44d2-60d6-08dcb6b69e47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
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

From: Martin Leung <Martin.Leung@amd.com>

This version brings along following fixes:
- Fix some cursor issue
- Fix print format specifiers in DC_LOG_IPS
- Fix minor coding errors in dml21 phase 5
- Improve FAM control for DCN401
- Add null pointer checks for some code
- Refactor 3DLUT for non-DMA
- Optimize vstartup position for AS-SDP
- Update to using new dccg callbacks
- Enable otg synchronization logic for DCN321
- Disable DCN401 UCLK P-State support on full updates

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 91a351f8711e..6b036417a73a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.295"
+#define DC_VER "3.2.296"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

