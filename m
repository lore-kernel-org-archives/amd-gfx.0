Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB12C2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 19:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55ED710E4F9;
	Mon, 19 May 2025 19:54:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vd+aF8ZX";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 078B310E451
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 19:54:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcY1tfGyT3NGpqD+PTSEC8p30h4U0xwkWEtz5BQSGZqbtBlhOkwwuHD1Gejf0DUoE9uUzlWVGEG68eRV+hx7xsVjCjZRx32/lPbnqmWGhy0SWhbAipaDTJJsR7P8zppUIr5mqQovwiIBwpVxsFO6Y6VdJ4Y0Ok0GWtUYqmV20C4FDRHDSycCHHuIET0UZIcp+zY0Dr7U0uLoVwHRvbq3H/hV9sisTbQ92QKOYi/1kaBw0hcDoB8Rlm0Jv1Gm+52S0VD939ArfFRaj40sdPoE3QKRusJ4T6mvXOJYCZdq9pv20HQMFu42qrAsnXF9aDxzc290iVdyUzvZ1zKqPev0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/kElZ40mXSclRuscWDZWNV5f55nYnqqcr87nCMwXgM=;
 b=Mu+E6UnWToXWhhf2zJutBRUoPv93kyJxXGwrmgdRCUOG3kQ5mt02eHQ8/7nlh7OmLd0UC/DuBfr8KN8AtUpV/aL2lAPUOWZ1XREWku01yyRUP9SNm28kJP9VW0bkvhj+PFzAOk5VNwtkYkfhD0UDTcgqArynKnigWuAeLaqoQaOuI8Zs7ajvG3AOL5mT2yVEGmFe+xnAWphZIrMYrchLLOzuuZIey5cfCbvSlnl5qH9KjdMdyAho+aiIXgP+lalKoOZwp+hhyHQqIXbHSJVi6aQ3jCMk36udLcjDLE0YaaAiI5EMjaAiLkh4YsfiUfwuo4zkXoKkwOVtK+lV3FNIqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/kElZ40mXSclRuscWDZWNV5f55nYnqqcr87nCMwXgM=;
 b=Vd+aF8ZX1QGYBCUyuyCokl7w2nBJ+uVayKcCX74hF/JfBzgknAz9BGzlBFJTAlugRzmfByeaSbmwmHieuvEB8/MdSWb2KpGPE2laus56Jg92Jjhdg9LyRutrbshetlfJMaHUiPnAvdg2wMVT0jCBCP1p9IPvTekxUmWz04rT8io=
Received: from MN2PR06CA0009.namprd06.prod.outlook.com (2603:10b6:208:23d::14)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 19:54:54 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:23d::4) by MN2PR06CA0009.outlook.office365.com
 (2603:10b6:208:23d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Mon,
 19 May 2025 19:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 19:54:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 14:54:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Update runtime pm checks
Date: Mon, 19 May 2025 15:54:35 -0400
Message-ID: <20250519195435.82731-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|DM4PR12MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f9bd33-4532-44ce-0d31-08dd970f05fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OBCGhqyTmIe0Sli4xD0vE3XGl3RNnzvbIGcfj4cn/KvUoLMsh2J+q3WOKz7J?=
 =?us-ascii?Q?u2jD/XQd3B+xnYrscq9DHN4romyHiezYtujpSLm7gjkkN382fyW1SFQSrWay?=
 =?us-ascii?Q?GPh3KZfToD9fnpgQ4DISVUozPATr9iwz5E5+IUPoFtWZbwe3lll0SWk6G/l+?=
 =?us-ascii?Q?VU6ve3zTow8TyZfom5R8X7cZ09YgdhvNuEMgVrNu3jcXhvN8U2dCPBhRjPed?=
 =?us-ascii?Q?vaSlOltFMpuJl46OEKBRfRShBWIBnb89PLO+mqDfhgaHYEDYC7KTi+ZN2ZW+?=
 =?us-ascii?Q?YZ4iMVYcPVEpCpzrIyMd/2T081C9WTrJmK6sPBArM2M+TiYAz6HObRP5e+K9?=
 =?us-ascii?Q?JRG0JjSH4CAERRVm3xj2irNjeYIoFY0tssku2wOk/vn8nh/a/r5i5EaLotr8?=
 =?us-ascii?Q?JhcMg/BtvrQC7LfiTOWliftgyM1bs3hNcwqzko0ZoTn6N27/mkuDJd5qWsBu?=
 =?us-ascii?Q?6PzClgy8mokvTmUx4OJulpFUE8KuAjEDY/zwnwtcgdHUvJntng9tRo31DdnI?=
 =?us-ascii?Q?hEccXDHTKh9tnHafXF2HNjuBVDOHlFi+yAGt+ep32nyDzHvaVmjTZoYpkRJk?=
 =?us-ascii?Q?DogcK9jK9iFsywMcT6l9b2oOkhrD8K7pr9RQucaceABBW+G/125k80LYbnRR?=
 =?us-ascii?Q?9l8zvsuabWG4kulThOcESDta6VUS0il7sxrHff5FnVXebMtIK6GjB8Ppsbwf?=
 =?us-ascii?Q?Ty88+7uDwqlr8ZcBnIKFfuWY7Qio8n8uEn+ps2VOcNbKMOC8CUdjeyjk69hy?=
 =?us-ascii?Q?4RavcNJeM/NQZi97EcAkNLDB55/nCxa5srGHMnsDAwhSZLGSkF97gTwsBFUc?=
 =?us-ascii?Q?Sb4CnBzx5Yap0WgAqd9Ml/TAlbheERRi+aXweJNJKGyl/lJSFm/0vlKlTPvA?=
 =?us-ascii?Q?Q1sn8qEa/+AQ+/Kw31KtI3UmU+t7DVen9IKwfZuqhVjkA1Pw2QH7BLNTVl3t?=
 =?us-ascii?Q?OGxG5L25Cryij/KzRgEOATvTd7mBviqIlYjgyaOrAsQmCTNpaQzA9rKZ+vqp?=
 =?us-ascii?Q?AzqHMVzTW4tOqM+7P5NZbvp6zsde24kW2kjSSbJdYitZBOl26hLNQ1jtvICE?=
 =?us-ascii?Q?tfdIGakn7cquckSriTXGkwEWivZ39Rn46y2UK/fWhjq1TSXX9lNY9/vq1J5Y?=
 =?us-ascii?Q?toOgAQ6PJ0i+jqlxbhkKpkpzyyz2xjoNI8d/qYrzfZHqGTJwo3WdL6nsm2FG?=
 =?us-ascii?Q?DihSI+tw21GLotiyOgssrWEkosPXisbofdF7ws3Rh6N4CHPnkJhlXhGg/zXq?=
 =?us-ascii?Q?YJbj5Uw7ISOayGa94myXxu1zbcxs30mC2h4PkH1jB39o7Tsg6TBOyLYo1N6m?=
 =?us-ascii?Q?VygY5w3hnuU+2NKfSpbHH31y1CkVVFjJf2Nhw5GsbFYcWvLeuurkmkoAmnJN?=
 =?us-ascii?Q?WaxrPRJAU51Rzt0hFpmODqVmzZGE7gu/Lj4ZJHI8OocDYT2Wlc+bRu+3zwga?=
 =?us-ascii?Q?tPksqqyc2aRtChph74yJPVyQAxfy7qQVzywZYtFe2an7tFrhrAzZGJc8SPC1?=
 =?us-ascii?Q?i/BrXAR/YGFqaiKTXgl8pwDEgmUFQFJ1EDj+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 19:54:53.6835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f9bd33-4532-44ce-0d31-08dd970f05fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569
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

Don't enable BACO when in passthrough. PCI resets don't work
correctly when in BACO.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 32bf55eab9efa..f011ca5d24942 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -512,12 +512,13 @@ void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
 				break;
 			case CHIP_VEGA10:
 				/* enable BACO as runpm mode if noretry=0 */
-				if (!adev->gmc.noretry)
+				if (!adev->gmc.noretry && !amdgpu_passthrough(adev))
 					adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
 				break;
 			default:
 				/* enable BACO as runpm mode on CI+ */
-				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+				if (!amdgpu_passthrough(adev))
+					adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
 				break;
 			}
 
-- 
2.49.0

