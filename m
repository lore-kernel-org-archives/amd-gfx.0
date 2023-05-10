Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A7BC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 08:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEAA410E06B;
	Wed, 10 May 2023 08:38:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9208810E06B
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 08:38:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+NftEcVtUngpQIOZHiheseEiuzmH9Ew8TTJ5iENypGvIvUaym5exX3j2d85SWc+YbgQ5ImrhpZQdhQ3DcHZSLGu8bUDXgnVuEUIee4zwP+YyKq0+awCt0/I+qC5hIVktDgxIO4ybufEVpgdGVgTLdRDiCzMyFZVhy4v5JEvjdq4Xp5DoS2NQsbwXk42x5LmZu92sbzp9uF46X8zEHpDf/juWVSiSM5jo8SejMc6cmJaX5d1mlLo1+umKQLJf8UhRGEOX+MO9S1dsnIh0yRF0ApxIUa/jUW89fUOHQaCTeo0wroH+Wzs9zxnDY07S2ug0K22gbHuCobCEGNLI43u4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLOXDmwBKsMRqa24zUcmZ9kzjQbz7dBzFCmtnCs79oM=;
 b=ZfQTvJizeCisqypY6tNuu2fxEIHF1lgpuMi8NYfoCTgIuSwiZHzIHTdYDvcYHXKRXhh8qun01L6E8oyZsuVdliL2DC7GbflJSLQf0WJPi2nTW46AqMYFuAi8VDwtDsbFWw2dVQjRhKWkyIeFVMrtsQGWn2JZOwVB6foG106HlCmzyZXVOzp+77HQMhD8Kx99UI4PMIGx53aTO4y25iRZllWzvgc492Vi6HAZuoHXIBROr0FFWvVGoL9zxzBRIFZ5mAXjheJmY/GltoP49XoRiUO65o26HlflDLcSrn1wMxfYdiR82aPIYpQkqHRhlUmxNg0zNI7ATSqgYPYMtfOHvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLOXDmwBKsMRqa24zUcmZ9kzjQbz7dBzFCmtnCs79oM=;
 b=DRibqxXOSRZSHhHxWWZyDS3FnBAlq7JIh2yBitVfhqJAkSWsJUcgYYZaj87YBW++f8GT9uaJdnSq/vtB7MB8Vl+MCYn3PkX3YGrfRctgK3/pr8Zim7Hg91g4C4aDcOv3nB0/GPc87Lxfl8tYIhRpgUww1m6XvhuRn1ZSacPL14I=
Received: from BL1PR13CA0158.namprd13.prod.outlook.com (2603:10b6:208:2bd::13)
 by PH0PR12MB8797.namprd12.prod.outlook.com (2603:10b6:510:28d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 08:38:37 +0000
Received: from BL02EPF000145B9.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::20) by BL1PR13CA0158.outlook.office365.com
 (2603:10b6:208:2bd::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 08:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B9.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.20 via Frontend Transport; Wed, 10 May 2023 08:38:36 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 03:38:34 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: change gfx 11.0.4 external_id range
Date: Wed, 10 May 2023 16:37:30 +0800
Message-ID: <20230510083730.1919231-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|PH0PR12MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c8ba20-fb68-4e66-126e-08db5131f2b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HxjhaOyAxBNMSHzGU18C/q81SL0XIg/mab8EfXy0DWW24JchTCkfPm0p4VQjG4O8Pyde9n7J5AyddS3yU7zCvrauao84QoXBsrcaj1bKj7Q8cMp1zfh4cHdHLFm6XO1wrFBdzqRB4fbBXjWNPM4Z/z4T0PzCtuX7yBkkt4kxJtAPvu7UT2KgKS4tCnv4VIxD+U1u+GQnaax0WqwFkgwipEyPVhlG3RnfbBSoyRsHdRA7g0OsimdnOTv/BCFw7DJHD2UyVszOgPT20C7t3FK/CbapM6DWNE5OP/bua7gQXNyc12TupYVN2GqJyeQpeC5jc9NbKc2tqfQ88sXNq+7dzn1WRU0w9ZP09G1RS/N/AKl1vd3rUHqIh1SKdGavTcn8mAFKRvIeFCesJChTFyIHjJVJ3JmBb8w9MKdhu5fJAsJPzuCAXfJe/waavUSHGKbFSCM2ip3uIRLSDXihiPesxQ6Xw5yaoNBjq46AQy6EgqtdlAgFB0d+MI2vpKTH3WL/JEqGKVX9QzWqpx2501PEkmY583FxkguMaYM8eLM65Obj3l/fgfq8WUahsHMtYPfqie2+DPUrh+yWIbicv5M8WV+w3z3jX4D2tQEwslTSyEVVGttzoLouvED6ox1RaDQwpK9JVtltJnSyH3iudKDq2J+25zQsG9BSc4vE8SMWIBxcwa0UTiYZxzkWQTEl5wOtC9MVL/brGnDwyIqBcCp/3LPJUsKh6AHl8ZawBUcj7o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(40460700003)(8676002)(8936002)(2906002)(83380400001)(47076005)(2616005)(426003)(4744005)(186003)(36860700001)(336012)(16526019)(36756003)(82740400003)(81166007)(356005)(82310400005)(86362001)(1076003)(70206006)(40480700001)(316002)(6916009)(70586007)(4326008)(26005)(478600001)(54906003)(7696005)(6666004)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 08:38:36.9592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c8ba20-fb68-4e66-126e-08db5131f2b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8797
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
Cc: Tim.Huang@amd.com, Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Yogesh.Mohanmarimuthu@amd.com, Mario.Limonciello@amd.com,
 Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gfx 11.0.4 range starts from 0x80.

Fixes: 311d52367d0a ("drm/amdgpu: add soc21 common ip block support for GC 11.0.4")

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 0f82b8e83acb..6bff936a6e55 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -711,7 +711,7 @@ static int soc21_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_GFX_PG |
 			AMD_PG_SUPPORT_JPEG;
-		adev->external_rev_id = adev->rev_id + 0x1;
+		adev->external_rev_id = adev->rev_id + 0x80;
 		break;
 
 	default:
-- 
2.37.3

