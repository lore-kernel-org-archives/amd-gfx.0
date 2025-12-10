Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79E2D3C526
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4437310E681;
	Wed, 10 Dec 2025 07:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ynMxM0RS";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012056.outbound.protection.outlook.com
 [40.93.195.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB9F10E683
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=od7dvn9sQj8JxpfFnZWgxzJfFwE6JFDl+SpTdV7aZUtevsUGgeJ6lVvcaut1wOL0dPx5A0NaxiqZ4Mk5kMObhbPWMIfTvQnZgKY0GlCKaRsEUajTxgsQ33aDVpJCxbQkvszgY1ak7Pa8U0F28L6tc0+khRlnfQdZONqMr83X3qI2b7bBs8N+RDfkRtSX5KpHIY2ZV3JDbBBK43Pj/Q6vZ4y1u5s8r1kMEYbZDZtPIgwalXfgydzTguMy9fBJL3bTLw9+vwRnhzHSPwEFB6DGbkxmer0/i+QPR9IgLdL0265V0vT+AkFwTrwfBBNLjO4tQVV9S9wKeOKlEcBguL/WDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JH1ZIx7QglQWmTTUubSwpqnis6eXkjLCRDnpIAHJLtU=;
 b=vs50EhQ/Ycp3yMrLg0ZsiY/6EgqG8dQZ3zer4fAVrSZrDY9rEYOa/sFmTwWc3rk+NuZtvxGs6F2w7DnH5+c21jV75RuS4dpaVBs8cDc7i+Ypu/2xKWWzKxqxU2SvGFtIg7BxyO4MDMAwTOhB50NftJ0CCD9OirmCE4yIsARonaDxu3GTk8t3MNEODyOJO/fDtGFGMadmrM++iKMhx+sTKNV68FVFIwbK9ft2UqMF7F1exkJfBZvDLuiqJWQgEmcCnHqbuoiyvCjO70mTpyU8lC3mPqamW3lF7pZvfrHtqvCJiN2IG8z7bN1QlYGx6ez1ZnfSHqhxJUSZNE/UxFIR8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JH1ZIx7QglQWmTTUubSwpqnis6eXkjLCRDnpIAHJLtU=;
 b=ynMxM0RSoyQ/4nFI+xzNxomD56ZR4GtAgNWJ0GnFeKZQdiXCsT0Oj9KAwyrNimzxapWyWdK4gvQUWRialIQxmHodjytSnS2kE3AdOy0ld9cVK2J8dOhk6FFpo27DHjwJXCRGSLibIOT7NIt5scp6QHIxTkwPgdzrwVFLCtByHu4=
Received: from SA9PR13CA0055.namprd13.prod.outlook.com (2603:10b6:806:22::30)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 07:14:37 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::b8) by SA9PR13CA0055.outlook.office365.com
 (2603:10b6:806:22::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.5 via Frontend Transport; Wed,
 10 Dec 2025 07:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:37 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:34 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: support xcc harvest for ih translate
Date: Wed, 10 Dec 2025 02:14:08 -0500
Message-ID: <20251210071415.19983-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210071415.19983-1-alexander.deucher@amd.com>
References: <20251210071415.19983-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: ca912522-6beb-4a85-80c9-08de37bbc741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lucNCljOc00XmkEDQk/USvH57pGTvQ2nvqe78AvQW49fWxkQF/cM8a/QSYpr?=
 =?us-ascii?Q?QxK5dimibjrIHd2Yi8lwFA1ma80uRH112Lg1XzgChfJM7OlL329QyMauOwCQ?=
 =?us-ascii?Q?bYEb37sx8JAGgo2ETfryfPj5KU60XsyGLGQpICfbwOCNjQPw+XOU0dzw4wlg?=
 =?us-ascii?Q?RfuMNrO1Tgrtio0ve9GkX1A851WyLIi9RCwbNJKCJmdNnM6GEm7DpMw8IAyX?=
 =?us-ascii?Q?lghJYqsWlfBk7cGfL3xkF2VW4+3qYz0+WP3xW1kOldUuWsRwPmPXuHJdxzj5?=
 =?us-ascii?Q?Wu67ksnCjgJtZUO/06l95uY9ej5WrlbsnpRi1kQHDnjnYsEzqvY4GHT7mC4e?=
 =?us-ascii?Q?I75RU43m17Fk639D8JAK3wgNG2D4ywFuwRoIS/p696nBtQA0CWNTaGWMkya4?=
 =?us-ascii?Q?IVmwjvihjOy93EBchtsS8ee4gYoPqyogbIgTnq4h7gDeRuiEDJ0P7Esd+vsQ?=
 =?us-ascii?Q?ExVsP7Hg9WJ/qRrUzF9pOsomN4RHzz/gresS8QZBfBMIs1lKlF46GFH2r+Ig?=
 =?us-ascii?Q?nm++7v4Z+MOEi88mO2PS//6Q6hzRGEsHHsCXATKaCimJe9KCS50b+gcIxLhl?=
 =?us-ascii?Q?wZiIUci6435evT+BCb8SSp0kHWkQGXhEteEaVbPa3YPAqnFO9kHmNK3N7BUa?=
 =?us-ascii?Q?l1c3SZUEbhgqL6+agJ9tM5ylhLtteHA6eCorlekXoHOQUWLR8egbpfVbAY/h?=
 =?us-ascii?Q?LV3JFPmkBdzQHGHJhHfxtGT2DN9x7N0BBR9qhucJlTRzy0GRGhlARUZ28sVM?=
 =?us-ascii?Q?WcbhsvAReNwKyJlq+PlukhIKdORz1luh3u2oIqAZ0JKZJSluB0LbN6HXJipS?=
 =?us-ascii?Q?u8y93XVZPKQglW7DYOnv/DzqhT/VL5vaXdJNvSlK5YzMyjQYvu95yQP+NBLQ?=
 =?us-ascii?Q?SjxRmkjLNU+CJ8cJhdSq7HJPjOwc/QNnsxQiXPuO0MHEFBTpGhBm3a2U+qTR?=
 =?us-ascii?Q?KDVhC1XRejzrSrn5w3fwPUhNugbsWi+YtqBIAgU6BVIhh1paKQtnIP/tjy3v?=
 =?us-ascii?Q?svm0Pg9mSJu1mDZPTHlBh+ZVxv66T31jb5t8ch98yKEV8KUfMzTG6eWMJMI8?=
 =?us-ascii?Q?tckaEIMIha7rZ5mqy4KbdUC6ScIZYp8CRoOQMSdtBBsYdaNYjCXp7JIeN3Nl?=
 =?us-ascii?Q?rp1+aONA31MwMuXMFzI6+LQQ+pLzU5cYF+Vu+qWuwdObUGzuPTlUl2FTFo4s?=
 =?us-ascii?Q?Mk8aSbIHchm6aqtyAJHOT9WW43HMe1WByPUmrET5ewBu5F3JIc5IcjteMo55?=
 =?us-ascii?Q?QCTa2+Gken8tNgwRj+8gtq9avcYK1XSsVlqmc0dr9NQdhzgvKuR2/Lm63RpK?=
 =?us-ascii?Q?dwYXSmKg7ZLKmk5ogJ11FKCdd1rbb3/OaE3vT0mxqPWcJY+1PwcKcjhVu+hq?=
 =?us-ascii?Q?cLJHSSwyKDe+/cPls/rjv+d2FR7i6md1TCAhQ3rcRmGWJsrO8vGBR02e64vR?=
 =?us-ascii?Q?XFFaW7kWTLtEi+RsENpCRngGIMEZOWuriakR9lQf/819+aeBb0eZRhiWvlPp?=
 =?us-ascii?Q?sH1f/oFoqKmiK8YiIxJvWaRpkK7yQ77os3mQq7soSwCo9yIEP1/Mkx/TwgxC?=
 =?us-ascii?Q?D1HI4HgWZqnnaHE2P0E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:37.3915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca912522-6beb-4a85-80c9-08de37bbc741
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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

From: Likun Gao <Likun.Gao@amd.com>

Support xcc harvest for ih translate to logic xcc.
V2: Only check available instances

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 2f94c44bd6e11..26f8394bdce4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -700,14 +700,16 @@ static int gfx_v12_1_get_xccs_per_xcp(struct amdgpu_device *adev)
 
 static int gfx_v12_1_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
 {
+	int logic_xcc;
 	int xcc = (ih_node & 0x7) - 2 + (ih_node >> 3) * 4;
 
-	if (xcc < 0 || xcc >= hweight8(adev->gfx.xcc_mask)) {
-		dev_err(adev->dev, "Couldn't find xcc mapping from IH node");
-		return -EINVAL;
+	for (logic_xcc = 0; logic_xcc < NUM_XCC(adev->gfx.xcc_mask); logic_xcc++) {
+		if (xcc == GET_INST(GC, logic_xcc))
+			return logic_xcc;
 	}
 
-	return xcc;
+	dev_err(adev->dev, "Couldn't find xcc mapping from IH node");
+	return -EINVAL;
 }
 
 static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_funcs = {
-- 
2.52.0

