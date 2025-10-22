Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190F1CCD195
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88DB10E6F7;
	Wed, 22 Oct 2025 07:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JkqYRGWo";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD3710E6F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:33:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZLif4+P6QmF9kIZR10A8N/RSJWQxaZIWXC10x2cUZ04FaBiy1pwK5cl8nXO0TMSH3NBvj7xIxlcMDp2sEuz3MXJJebpCsApVE+nyhgQE1NwJvnznQSYwnruiUuZBspnrylqxb48AfkScQaBhRVCUtbDtB2F39ZBVvm8l/II8Ge9QnC/rjLrtM8McX9liI5SEPFj/6g6Yw+zlLrKZpm27hfALmA69ymgit00qO+YNhOxXajMZwd9iqXCaXkUv8yI38PTxkPPq9TAdpvhffhPRyVRgohpVdgjuGJOQEg4aafCeEQ1krn1RtShDU+keQNW05HLffmAn+g/oAlu3Z8FlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCTwtqtGBKBgKnxlSqZvf5fqesIotMjqJgJauw59qcM=;
 b=JXuFAbSc8bepG6CyqIBZHUfAbK28sdKTQfeQNs8XSI1mK5wE58C7jykcqXqxlKmxww2hDWNg2IGDu9uVgOLXqIWRJHUglW+n/HehaefQV1Z3W8qHUhCC1KNAJrIrBKfLEAnJdAdXd5d/z7oE2yaJPh/jsQOdTfnVt5ReDddi+oT5l52kdDiDU+QSBHvwziO3sYRjnia+ymgac3sh+Dmtq0B2MnVYIbt4FcQnnxy4wjMoSiAlkpMUtqIwj1nitNbewBLGibaWdQZN42oQrwOpOazroRw3BJ4FA2PB0RuaQpNUrArvhoBaDJ/S1rag2vUT7qy7aKOMLi8EUOFTHfCu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCTwtqtGBKBgKnxlSqZvf5fqesIotMjqJgJauw59qcM=;
 b=JkqYRGWoM55Y+HkKumi0A28Ej101D6bliAGmLwr7WMZtXV5PUsTdHtNkn7JsAdUKZTsZhPZxMbyii9c3/9v+qkRNenvs7vNcwyTNHomcoVC3fReCMYEaThJr7vRxKwvtEfPBaABNCLLO2dMjMJApzYYryq/lCsJgr7QSauv3HHE=
Received: from DM6PR13CA0006.namprd13.prod.outlook.com (2603:10b6:5:bc::19) by
 MW6PR12MB8662.namprd12.prod.outlook.com (2603:10b6:303:243::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Wed, 22 Oct 2025 07:33:53 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::41) by DM6PR13CA0006.outlook.office365.com
 (2603:10b6:5:bc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:33:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 22 Oct
 2025 00:33:52 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Oct
 2025 02:33:52 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:33:49 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH 01/20] drm/amd/display: Bump minimum for frame_warn_limit
Date: Wed, 22 Oct 2025 15:30:13 +0800
Message-ID: <20251022073332.666119-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|MW6PR12MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b5458ce-66a6-40be-4f27-08de113d59c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q1pjsOnGvclh75nVrJ6Ua16R7fDn0uNSaT4m5vK9YqrUVWkpCrmp2FYcB2Z3?=
 =?us-ascii?Q?C0yoxsD25N3mxX5CuHBUH7ti6OtFCleUQO0aGZZ0TspYBP/tKKhvlYXl3D9U?=
 =?us-ascii?Q?VhjKWSYfJxhZ2MV0/loHs/AVP6McoLmWZCGDlpNAGQNqz/F2HRHS+E3lKPxy?=
 =?us-ascii?Q?pdC/QRyqSX9DqkCDnOTq5+SfzSG3AtnZ2UPQkS5W3B4enENN3F4ocr8pe7wQ?=
 =?us-ascii?Q?OowHFDRPvSOY6+NfT+LNHa8UQJzNSwJfWEL1Srter6eUrK8118BWMBxOTTdi?=
 =?us-ascii?Q?vq9EVIzv59WrlVTO7fLVHIy+V+Iz6oVLQzUyHq7Gj/dy5ncChsn3j+AJAf6d?=
 =?us-ascii?Q?UN9Ix+LbCK61IGyvCSj16qmfq4IKAwIDQM7GX2ky0+pMHwAusWiz7VYltbIi?=
 =?us-ascii?Q?EowOmSOzgMBoPrAEvy8DHbbFsDRPM0tIPaBinfCG0IqY1mO/AzBHWWz67jmp?=
 =?us-ascii?Q?Uc1tASAgR4sJpTDWj35/ulNL2F4iu0GmnKtJbQpz0oFCj02600zZQCbG+RXI?=
 =?us-ascii?Q?r+a7NOLv08ytQXOkn58yzyRyhma4CMFELpVO2LKpavdBM4HiMfgusQ2Ev1Ie?=
 =?us-ascii?Q?NJ+6pkfVnDhD8Xb5mVigWz0TN6r4OOksuSc+pUNOv5f8QG6HqD2HrDN8er74?=
 =?us-ascii?Q?TuGhg6qCCgNT6m0xToJ8E6ewIm9z/7aOG9aDfsNraBP0aEu6GMWXA5WuqXRg?=
 =?us-ascii?Q?nGhE9K/33K4Ma7F0pYHEAkKBBnaPg7kYUiisiWWf/g6QpEZBQgUzhUiKAdA2?=
 =?us-ascii?Q?JaIZHvdU2c5jhp5YqrOSXhgYRW8NhNPb1MzG4F3gr7sf5Er/Mtpo00Vy1LZK?=
 =?us-ascii?Q?NnboCM+xVAv9AaNYU3HB5ODmgpV9ONLjytBBY9V856gJD/K5GOPiAEn2lY3f?=
 =?us-ascii?Q?JHu9StppAdF0gb+hslpWN0SoafBL3dKEGkxBoPJFjBMz/Gv7iNQ3y54+07mS?=
 =?us-ascii?Q?AAKOEsDJJAlZABqdIrXOv3qfyxJy6IN1jVE+YzUXzN0J2MoP77FPcC5lXwZA?=
 =?us-ascii?Q?h10SXQ0tfNGoPDMWi13I3heLviB37j07tzPUJ9VLOVRonwQlVs9wWebIV0tM?=
 =?us-ascii?Q?2sdlgPE/ayHTpbIHymsEyN2DNgO06WSo1Qzc0EmWf3cyQkyGcM0OhrIJfbzN?=
 =?us-ascii?Q?JGmbX/eJ+Kt7/ROldr3Gia8i3n2DH+20opUmZITNR3DsK1KBoUXAsgrwomn8?=
 =?us-ascii?Q?+kMdAleHsJRWrBcB/aZgDfsFNcH6mxT/Ogb8Begm35kT6qrgCuNY0Yab3Gv3?=
 =?us-ascii?Q?f4mvkBzFCu7NEZafmS+e8A/yLE0t8yXQtWGzisNigE18GIPwqPr9eLhmKAJp?=
 =?us-ascii?Q?WGfIx3iH4yYllmZPz2IyOKvMEGrwtBxWR/9hBEn9De8PRLnLttYtUJXh1MCq?=
 =?us-ascii?Q?84XuAE7o8IJqYjgIoxmq+ypbi/9r5C2VJltRn4XifDOqGpbBiRytccYEOkic?=
 =?us-ascii?Q?nHHYFAjnOXeRVSr8gtwIF11SPxiDdG/5+pZoXCCXjnDykq5/zekoZ6sW7Rtv?=
 =?us-ascii?Q?fgI/vKOKJ67aZjXooKKdo1fhZPg2gtdWpehskA2wuV746S36cV2YTKKjKw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:33:52.9042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5458ce-66a6-40be-4f27-08de113d59c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662
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

From: Mario Limonciello <superm1@kernel.org>

[Why]
The bigger of CONFIG_FRAME_WARN and frame_warn_limit is used to
trigger warnings about large stack frames.  The dml_core_mode_support()
stack frame has grown to 2056.

[How]
Update frame_warn_limit to 2056 so that CONFIG_FRAME_WARN of 2048 doesn't
cause a failure.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4609
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Mario Limonciello <superm1@kernel.org>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
index 4c21ce42054c..4ff0adef233a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
@@ -35,7 +35,7 @@ ifneq ($(CONFIG_FRAME_WARN),0)
             frame_warn_limit := 3072
         endif
     else
-        frame_warn_limit := 2048
+        frame_warn_limit := 2056
     endif
 
     ifeq ($(call test-lt, $(CONFIG_FRAME_WARN), $(frame_warn_limit)),y)
-- 
2.43.0

