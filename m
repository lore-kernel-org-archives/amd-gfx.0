Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912C0C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 05:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31DF110E7A9;
	Wed, 12 Feb 2025 05:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OmZ7j7uK";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65FA810E7A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 05:26:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iR3cl3iDqkb2z1SbocnCfV5CNjZHCpTbQLNuYgcR/1UfhxVKIN64o9pQ9XTRfXMmzJNz7AY/DH3AKI+GP5dHEOoaoSbHFHAW7W/l2S4f/MJmQe9GYORbAMpoTY3Dzynuyd0ppUnlyGqMb/j3K7kO1BEh8p5J2WxNmBnwwwboIkhFIM2PhWDY3qarQrfyrs7UboJXkw4MWIAbZ3Ng62Rj6XvLIkjyXe2z1SomRkR7Tw1UuaqGBcyAIWUsKdCsXOKfPK2ooh7H/Hyuv4rsbAY7gwe9Mc4/dCggEic2SFKXFhf+JUescCd3Rk6H33rzQg4ow2QI6eN6MxO/Aah1iMFxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4wxH68gOJhurVySaBDtx0QgUJNOCdGxddaizLW+M2E=;
 b=rOOY7KA2iWynmDZPsKDzWzZS+e9XFZ/RetHdXK4pZJW7/UTcelHiLzGk8ifzvnX2w8Sj1l4paL6vy9y8eOo8QDShfDhhMWmhkQdJLffXEadRil3Vb4z59kNMqqq1bGMb8+yXSBjLTMKF8q8yzzNjyXn7eJVNcVuYnJz1vSXl3WtjVYGW6wjW9MvLvNOUtlilMyIEfvKEjgvW7Q+yfNUgPOxSsNkPLj9hqrte2gQYU1vdju/t5FchmgkR+pCVjz0SYX/lNkjh9NG/9T2DApRAHbQLNUp15dcxnugqmBbiHFkUYmSEBFvANzbAj3K6WVaD+utkrqz/qJSfjLuk+RPV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4wxH68gOJhurVySaBDtx0QgUJNOCdGxddaizLW+M2E=;
 b=OmZ7j7uKs2CHCceEdbj3UGG7rvfjKQ8Tmkr/soBQw/Fm4jhXSKU/cAoPSa8nJMHGjJJU08XccvLRXUa9gxqerSb2ieNT4lm374fh01csuxZQ9Sl0I04JQ+WXN41gcE3Xh7EaWkQMfR2l/Uru+Vq+PS43CPiv00tJwDDiCf9d+Nk=
Received: from SJ0PR13CA0058.namprd13.prod.outlook.com (2603:10b6:a03:2c2::33)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 05:26:16 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::e0) by SJ0PR13CA0058.outlook.office365.com
 (2603:10b6:a03:2c2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 12 Feb 2025 05:26:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 05:26:16 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 23:26:06 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amdgpu: Enable ACA by default for psp v13_0_12
Date: Wed, 12 Feb 2025 13:25:52 +0800
Message-ID: <20250212052552.1612815-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f9194f-99b3-40a3-58b7-08dd4b25c5f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aBwnfQWuBC1yOwHXfyzLpCJKnuHf4PjzBt5n8TLvmjfuegIBbs9Y2/B36fRI?=
 =?us-ascii?Q?FrrRGxWr5Oejjfh0rLplhfYB5VDoxjDf/UzRwk/MDL+8rIwzi+5CmNpJUQPB?=
 =?us-ascii?Q?9w6IUrVeyu5Wuzm2Cp23IJidyuNpji7eIvBpX2JR9UoAE9gR4dsYicbowfi3?=
 =?us-ascii?Q?wnUihOAQNdFYa4vZazyQ1wMXvui057n4DbF5fCO2MtrkHS7O2Sdlrxsp3+CV?=
 =?us-ascii?Q?ORBTJiuIe8eVcKKoLW7fdr/e1L3Mm81oX75mknQIElAT4TnzQnXNijd6EhWv?=
 =?us-ascii?Q?fEpAB3uN7AJMjY+VR3BZoyO5LZquXYgEkgOVUZi1qDoqegXF/4AUTDpkUqI2?=
 =?us-ascii?Q?xz47BcGbyoijcC8wr+//bX26hLlmLXLVgU43tfy0qAyZK0/g0vwXHkfYho2N?=
 =?us-ascii?Q?oqmb1c4DntsGRcjE5LPB9Icl/m9mJepGUAHJ0TFTstAqOE3oLt8Wgefs2zP2?=
 =?us-ascii?Q?ntEvqiX/xwkgkwa6BKP2QLgZKjSS5To1gjbxl35K+7lOzgUrT2/B8JniOJBl?=
 =?us-ascii?Q?ZXPUSG9oKu9bUtrxw/ad6gZGIQdkGhnZNV59lHDBixVvKEw3ms4yA1IcSTgN?=
 =?us-ascii?Q?VX+o7IXF+sjwCMXikdDmLFzTn1XiZ8l1rMzzpri9BMjRSxh8nRkOdGfkytOo?=
 =?us-ascii?Q?A5HGzed9p3jZzqNgZTK0r8pkpOLvIN8yv3/tuXwSRu++uHp0nnQFw7WlS4P4?=
 =?us-ascii?Q?9GxvxXSkax0k5Ta5V+B8q198KhA+arF2xjtPiThbtqCeCWWgQUYq9lp7zX7a?=
 =?us-ascii?Q?qyIhqQFJnWP9e9tHVuZJuNmr2Co2cDHhvfqcwqdktaiMmjFWyli7actkrW9g?=
 =?us-ascii?Q?/DMNUr5CVmvFsvdGPRK7soHgoooD4sBaXEiSpuZV9QvSaqf9hkZTVRKqCqi/?=
 =?us-ascii?Q?oITh18fqEedC/pcXdl3GYWn2himm6YMJ4swhU1WXscmXMXBRQosQtJy64I5a?=
 =?us-ascii?Q?KT2hJlMaIMRcR0Sox5bmuabE9yYjvIXhJY+iDK+Vvsri0aX4LVmc7iLo5OT0?=
 =?us-ascii?Q?PjK8rgOjgRtrU63Vg/eamAyR5RXKr4JnLePX2r5D6PW9EklietVj7HL1+x7n?=
 =?us-ascii?Q?J0TKFa9w5PQMfXtKLOnlne7psbTwvdOhoYXAQLv9UK4lGsM5jmyhYbtNg5uF?=
 =?us-ascii?Q?1oyxgiZGFSz/Wgfi/oCkEOhVshTBx++Z3wV9Khu0Bvpth2VkPlycm+hsoSYa?=
 =?us-ascii?Q?ziK5MdTBpVfHyJQvmXPGTf2BkWFQqUnVXem0QEVSIcAhwqSaNtdoRYppH4oJ?=
 =?us-ascii?Q?+PC27brtRVgXzEY4WdVLOIyQBABry0QHTb5B02ZVytdSgawmWghzjV6I0wWP?=
 =?us-ascii?Q?UDJ+/6KPMexi6GMU5D47UI5kdoG0Lef4qCaWpXPel7/XTSD1URQntBeoL7nD?=
 =?us-ascii?Q?gsZ8/3yKwtiznixa+RKJK23mu7BqTFAk44NHf8fOA9RXrPmUwZmacF7cfHXQ?=
 =?us-ascii?Q?eBniDp86nX/x2+WqZsgPLRlEAzbZLU/xPxQYZLhZcYLKsN9mImKcgWpZvUb9?=
 =?us-ascii?Q?aGqxJCamJRNE1j8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 05:26:16.1848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f9194f-99b3-40a3-58b7-08dd4b25c5f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
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

Enable ACA by default for psp v13_0_12.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 44d13a60588df7..3c3312bbfee8d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3760,8 +3760,9 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 	adev->ras_enabled = amdgpu_ras_enable == 0 ? 0 :
 		adev->ras_hw_enabled & amdgpu_ras_mask;
 
-	/* aca is disabled by default */
-	adev->aca.is_enabled = false;
+	/* aca is disabled by default except for psp v13_0_12 */
+	adev->aca.is_enabled =
+		(amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12));
 
 	/* bad page feature is not applicable to specific app platform */
 	if (adev->gmc.is_app_apu &&
-- 
2.25.1

