Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1022AC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 07:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A569610E03C;
	Mon, 13 May 2024 07:33:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WEYjxUd9";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E756D10E03C
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 07:33:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtIBsx3QIYHg+vao82a+cNH2XE0/sO3QzMDtJ+SgMu+R3jUPki7X6l9P6uxU5WEsPPzao3UI783+zh/5EKU2QbCuRPfDbdZHxy4i9BOFMP8Hy35mXS66IwrN8pDnPQZUGRNZzfYRkspMVbmauv1KOm+2AIs1DCJZQ/OYT0uDYLQrBYt6vqM1Lnc+RCESWVXXxEW3Oa5IjrVj6YGe9OzmiTvmUu1BKoq2v7WvZbXad+DiwCz1xREOdmFDfBzaeT30hgd8cvruY9l0zStQuPSXftrLtnsd0sE1vRe9xlmhULiO41HM4KQURbfRVbiwgtPGhkSRcO7ATcjgBl3deS76GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5RfIbu0rWvpkz/yZyPrtIgWQsFyuQlgMZMgGZclvNM=;
 b=a9bBeVTKnNWASYzWZAbCWZmstftBuUKEPbCkpX+QX4upQmywLn09MZOHzefz774055FUuBmyEb4sTuH3cuwmWRi8PxdBSk8em5CsE9MRtoykWN5GewTW8WcNsNlYGZ6aA7I68HNll78fZY24SPicDj/E/yk+nepOfZIoa8/qHgY6Rgkdoh1BukQw+1HmFLywyfDAB3FvJ6kMxsWQJk01513fmOFhHYyRUrOX5Ifm+llH75qmobZqccSkoBXo4VPi85CysNiQMSL4pvJbPHxRNHBBQ2PAkKfa6VeRAx5MNCWjVErFzmGDpIqu2VxzdEESJQba0Y+PmLND2liEoJCTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5RfIbu0rWvpkz/yZyPrtIgWQsFyuQlgMZMgGZclvNM=;
 b=WEYjxUd9GLV1Q55F8i5FL0nxKHmb9+UT67EgjUAsEP98MpahVNusk2qddnS2xok6idqrqg3Ogb/T/z3aEcQn1pAM0LiX4ivRbPmB8N/yEZeFOs/QZfgaJa3+0W2SPRjuxSKrbdUbqvvtKkJWwsDY6PekSF2AriqT7Q0AdR+Dpy0=
Received: from MW4PR03CA0068.namprd03.prod.outlook.com (2603:10b6:303:b6::13)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 07:33:36 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:b6:cafe::99) by MW4PR03CA0068.outlook.office365.com
 (2603:10b6:303:b6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 07:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Mon, 13 May 2024 07:33:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 02:33:34 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 13 May 2024 02:33:28 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 2/22 V2] drm/amdgpu: the warning dereferencing obj for
 nbio_v7_4
Date: Mon, 13 May 2024 15:33:22 +0800
Message-ID: <20240513073322.3612851-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|CY5PR12MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dcc66b3-777a-4e05-a8f7-08dc731effd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XS3ONaHmFxHHCiJQSSRJ3/83t/abaY1FPJy3a5JDYK1mPkV8L8V0aE4h6d7V?=
 =?us-ascii?Q?zOH1bk3WRTjWVzA/8ziPLODTQLIPkqi0mkoo+RCpyZFeOI+PmMxKm7JCMHQJ?=
 =?us-ascii?Q?/d4538Q+c3d60OSEfWmxH6r1cJZTfxH5dWR0qi+heQt1dOROLpGMWbfBevmv?=
 =?us-ascii?Q?3+bze2CaQb7+zuFYGbp6c7FPORWhviXAiIJlV78vQ60X9P/zkJ6hGOkL0Sxz?=
 =?us-ascii?Q?IL/plQ6Y8Mt+Og0hna5P8hH5JktFggHJUV6mCfX3Io/0wwOaOEYbSaBee4hd?=
 =?us-ascii?Q?1UQYAlzyowI6UEvNI+zY6zB22yQ9kLQJ/6LEwgunlF56JERFi3ZW4zoZzffs?=
 =?us-ascii?Q?i5g32II3POEmQVVAd4gLbsBPT9rdcrvZ+Jgtpo3pJ1lwiKp8IhW2SMo+Ri8C?=
 =?us-ascii?Q?QCJrg2XJjM9wqFw6vs9AlFZip3oDFSgW1SSmZM6mkoOrZ7lFhb55s+cvKE2F?=
 =?us-ascii?Q?URgvIdL/2aZRl/qUtJEJWdBDphPzatBe+fJhCH1eQvaZawatgOw7y2aO+/Nt?=
 =?us-ascii?Q?p5Kie+d7luBFtZfjkunG623pZYAn1mDuqHIFnn+xA/LrBgr5wmhiNCo8owZ1?=
 =?us-ascii?Q?qvO98sIWVlsLijF8zVzScMyLosH2suLqbPdA/mN3DuuY+PIOGCXfXEBCCoXV?=
 =?us-ascii?Q?FpkkkUc930WSoncLj5IsvgyB833uOWuju8etGdeiigxGJtiFQOJw5w95voyw?=
 =?us-ascii?Q?Z3kN5TVFiU4i3P9xSM0o2UCoZXMGkuNh26LW0wlgBcyLk1wnpG8DmK372Cnx?=
 =?us-ascii?Q?ARXEKotNDMyujbiY6nQWzHfm2W21yyVwt2Fm/xnjz4F78jmlWa3mgs+zm+ot?=
 =?us-ascii?Q?ZSlb+LwC+Z9PqVGhG6Sl6uJL7cVOqD2usPEnFpGPJQs/D9euVsf1JU1sN9Be?=
 =?us-ascii?Q?iD1zpHoF0hqQaAgTaS1P9N5qc8i9d7aFLIInFYD0NcBMG+0YvpcEtsN6fExx?=
 =?us-ascii?Q?sonLU1SQ5tMqTL6bgXIjS1BbO5bixTJrxOYS+lsBNMC6LLaJtoinec7JqOCF?=
 =?us-ascii?Q?5wk+elrM23/xukdcl+xvwKSV39JHxi/vEfnZwkbLEF5CsLLn5MyFmdhtFeXK?=
 =?us-ascii?Q?lK9+tsT5USYggJqPcK6MwuqFLPgRJH45puTMf6+PFJwiEKl8M894Fzs4787X?=
 =?us-ascii?Q?+oUn4HaI0LOPiKcHe38s9ASPs6mYkvR22H7aMsn9rTV7N7HniuLl9RQ7SZkS?=
 =?us-ascii?Q?oa0fY4VzWVLlSV//h5jcI2b7ersx+8M6dcckcY1rKL6xcYCVgebA/LT2QdwI?=
 =?us-ascii?Q?FItXzulq+S6WVM8hYLFWBeVUMaH5xz9DQ8bHOZS/ztZ9Cc2t3Ifq+WuzQr/j?=
 =?us-ascii?Q?YAaJyEb79rppPfKwLtHN49r3u6iTK5GeGmpMKZ6+9MNF0g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 07:33:35.6439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcc66b3-777a-4e05-a8f7-08dc731effd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105
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

if ras_manager obj null, don't print NBIO err data

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index fe18df10daaa..32cc60ce5521 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -383,7 +383,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		else
 			WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL, bif_doorbell_intr_cntl);
 
-		if (!ras->disable_ras_err_cnt_harvest) {
+		if (ras && !ras->disable_ras_err_cnt_harvest && obj) {
 			/*
 			 * clear error status after ras_controller_intr
 			 * according to hw team and count ue number
-- 
2.25.1

