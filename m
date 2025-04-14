Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0CBC369B4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 19:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA0BD10E26A;
	Mon, 14 Apr 2025 19:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zy+pPhXl";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF2AD10E23E
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 19:20:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVK1vPtRnuy13CVUZ1GKU2vjeAk3/mfZerTWX4u+52VJGHpT1V+ImwDkP0D/Kef+jWiVnpzoEnYQGmFvZGARIQXkHi8KoqD6hMiv00MZwwOXZ+d9K2x7p/FxsUu4LFJ5/hKg1GOUpI6ulqQrAU2iQ0TKPBn7dwPhTvpxlqg/DZo8Ez1Ufpl8ANIxBed0jziFYES6dJakc90UYj8Fv7S87okl2t0pninkz4Y7ts53mKBLT4tFik9QmgXGNY+5S9IjUwOIinJ8+85EU9hFOBAai+LWyIKY5OfZ2z6LTzxn6JDLhrTuzZlaC3/orCrO9F+Ke5N94r0wUEkUAq31zFTG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0n5MVkQxTePiiZ7FsLUnfPjJ5tzSJSNjV4nwaZOsiE=;
 b=r2kJK7W4rBPLMXOmwGiaiKto0xT7Rk3MIAvgfJq1sP+MnaK5Qh0yr0s1dPbJaBt1yVPyn/fU1w8l57BBkuc3ciFSMDnGVZNOYVE5Cj/B15TylW902diNBe0W3QR7kVlqRSO4+9fvUbgIGwASaRBl+YddJFZK4yEUeBfqT5x4LonuVsnUQpHz7fZp59ip8HDQyTNJ36d68lucRcwQt8nCLImNBTNzSex7s1EmmyY0nqmLBHfkP8PGniBTB3b9sMCK+OZglOK5WEj4jHkh3C8en3WxG9kN2xIkAf2KnywJFexl5a0mJ+LZdxlxTiLqbJRvF5T/BbKlJWlt+AQpR/XqoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0n5MVkQxTePiiZ7FsLUnfPjJ5tzSJSNjV4nwaZOsiE=;
 b=zy+pPhXlus40++C0Y1/IoyHLzcAjehOuqXOO61/VLA2xbYtiDgK2yqywC49iPKRMt4IUYJOpKYsCRbnBdPFzs0MmmFCf5evorlRVVvPOlCVWm1velJ96v/Q5smP2+iqA+swTAUuYTZZwNz2u7FDWbsDrRk9JM72la7FnUQ0Lwc8=
Received: from CH2PR15CA0020.namprd15.prod.outlook.com (2603:10b6:610:51::30)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 19:20:43 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::c7) by CH2PR15CA0020.outlook.office365.com
 (2603:10b6:610:51::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Mon,
 14 Apr 2025 19:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 19:20:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 14:20:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/userq: track the xcp_id associated with the
 queue
Date: Mon, 14 Apr 2025 15:20:25 -0400
Message-ID: <20250414192028.3113100-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 732fc3eb-83b0-4e6c-90aa-08dd7b8972fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?soYgIRddGWZ3i435Ie546gTzSdj15z5kqveHb5rhjWitev9oSHlKfxwqJzWM?=
 =?us-ascii?Q?Tr/3I4OcMSZzylfELhRulRpns+Aso2H7WZxlYYwiaNhUBuUopwtbRBk4FeHi?=
 =?us-ascii?Q?79FDua1EHdsz4t/Nyv+5SYrU64+3Wcyrso3E6P8vyubS6uzWLcJ/wE7PLrD7?=
 =?us-ascii?Q?IHcMoroKP7qf/MW+CntiyD8nMVi4Hs9ZbA4J+QcLH4wK+5da9nTnEd1JlWbs?=
 =?us-ascii?Q?Ef4SOzM9tbi/oEdq8DzQiqJvlaiio9pAEwcF3ZT7AC9AYAYWEeTuVuZDUTxx?=
 =?us-ascii?Q?oCjewBpLW+qQvDxxPagwig1fQEywEcoUsyir6g/gowfwz9XdOirNxgzja2iC?=
 =?us-ascii?Q?jDbFlYJUkJ1xSAjWJevwcvVtesIGWPHmZPsyepsY0pru4yc5QOrxfqfVzPc2?=
 =?us-ascii?Q?jgr5kA7NybvT802GaH1QzZv2UzFYYQM9+BJ/JQnDXqvHotiC6Itv3f38sJ4T?=
 =?us-ascii?Q?DYy5RKfwEHjS9ncOEpr9r7u8pkq6qBp9mMSN+lLwdNyE3AQvUy1AZBERXqnL?=
 =?us-ascii?Q?NixYsBVP0OjlhdiiJSaPoIA17VlxNrfzGLdK2olk/+iIife3KKTVMhkyFj9a?=
 =?us-ascii?Q?3EEJlKJ5gNpbwVYXW2jz/XEPpo7IPeGT3aXYdlohsuQKW64AecyG4kcmp2Ao?=
 =?us-ascii?Q?R5pmXp2xmNQweNJr6k7DKOsw5nRucu+qEkyYap2tvp2G6yjX/AJ4QBnBOjng?=
 =?us-ascii?Q?PvDmvTb2spJ9BVEiN1mIMhvnntYaDw2qHxyPPzYcQCR8ISyPa8yJTPYeXnOh?=
 =?us-ascii?Q?uKO8ppBbOxv9xRZXfXuVHqKTzojjZSkJucINLAmXUPk4+dav1OXntacYewF6?=
 =?us-ascii?Q?4Hi34IWLftlsMWRVxq4ILrILKbbpYKnjzNhONaxqIe4JM6hqqxCX71XsLaoD?=
 =?us-ascii?Q?Jmxi1UnhVg2dM3AVcwgw1EoxxPWgK0aL+8jRrJnelLHse8h1wA4tSO1Jvavb?=
 =?us-ascii?Q?GGdK/ktbCUCcE/BXo9IzXlpP0f7HPP6jslC31TJuuJ0GQS9Yo/UenqpjJV+G?=
 =?us-ascii?Q?THfufc4G8olNB3Qci7LxtiKnrudbRPJ8ghiP/PVEKFQtcj5nw8nmxjI04SjV?=
 =?us-ascii?Q?2ri4CmJNc8eQknX6uW+XqIRMtbLTWdN99Thk6m34qTxUy/jZLkHy6OB1WiLO?=
 =?us-ascii?Q?TNS/6QAdwFtZa7++Luh6uiWXQPO0tgehuY1OqYascboNMRBDspTP9F40dF1Q?=
 =?us-ascii?Q?OyYw311wr9F3HmYQatXMgXFBz1Tc6UVuJkB4zqVlOzY5gEVBlh+AyWZpH8zw?=
 =?us-ascii?Q?a94WQ5P9Lxv+USFZBUB+j1+gnht2CG2YUZ4M4uMaQ5wT/SIzu/VZo5XRQEnI?=
 =?us-ascii?Q?Te5Qn+f8KvlOc8f+ynV39HETBc05LMrKhRCAExPffOPz25J6s934QxzVkqdq?=
 =?us-ascii?Q?VMQNU6O49htC3CIopuW2bjcn2tkl0Ro18H4OYqkCYsUfTOfjhGjP9o+nHlGh?=
 =?us-ascii?Q?sIfCNnC65Qu9QKOsd9XUzZCEmDWbt3nihdzCzFsfkeb88ZJ/G+SDuhS6klkF?=
 =?us-ascii?Q?O6zVRrKIdaKXkDVVmQ2YpyP7Ks26F1rK2w3A?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 19:20:42.5366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 732fc3eb-83b0-4e6c-90aa-08dd7b8972fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197
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

Track this to align with KFD for enforce isolation
handling.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
index 381b9c6f0573d..db79141e1c1e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
@@ -56,6 +56,7 @@ struct amdgpu_usermode_queue {
 	struct xarray		fence_drv_xa;
 	struct amdgpu_userq_fence_driver *fence_drv;
 	struct dma_fence	*last_fence;
+	u32			xcp_id;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.49.0

