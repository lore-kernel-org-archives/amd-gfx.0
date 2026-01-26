Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA918D19518
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 20:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B64110E47D;
	Mon, 26 Jan 2026 20:08:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xAVXLztS";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011035.outbound.protection.outlook.com
 [40.93.194.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB80610E47D
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 20:08:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1qJIAHg3VGbKPuMIpnhZQaXFhuyksrzW7fAJr/J0wNjUebtITnmr2QO74OSD6a98vA/8/bIWi05YStj5uQbjDJ4ASDmadCY3moSF4nyNm9ygOl7XmR2H9CDV6nsEJdaCt7WRFjhzvlH7N4iqgR8vRI6irBRsNsTCLDx3F/RkhuxVtjLZxInsKvzoU70tl4nEuQNbpxY/Y8HRUz4wOpiyxPEXIldx4rjk1ymk5us61z0avhWzhDXnkw2FPvI4Mu+txmSw4djvuhSMIWpvX0cAl4UMc0Aw3e6RsNC4x6b9sq6E2NnzntBAV1SakZbAFTMR5sUajLgCmu2ZQ4Zdnv9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04jFByZoDH7dQBvxnXhLJQR+1lchnnVPh8ebI5kMESY=;
 b=F7aJIDPuHiAdlbUhbeqBpdo2vb7ou4XqMci0Zw9YNdO/qv9AHHz6z7bgG6XET4DKcsaE5pFmBrfkL0IMAr/zLjGvpD1/TxSb8INZyIZBHob1+Qvpde87J2v1sdIQl4Ocm6flrz6NxBM5J+V0uvITzS5GxtnjXRxZC4i00Gz+RS+CCW8sdrkXMQwkR2+eWs/4kYUPmA4nDCdkRSqEx4QEvWhJmJ/UKYnkaxUrr8S8otuKMvNbG8JKEG1/uXoa1b61EvQwp/MyNqR5bghubh2PgAwdsQx++AyS31uQen0yaS2v4kHi1W/7tCfmJbpCA+3AXrXkWm5W2iERJHYrl6bqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04jFByZoDH7dQBvxnXhLJQR+1lchnnVPh8ebI5kMESY=;
 b=xAVXLztSWhV7j/tGJftmjrEG22hAQVpmHyZMhPwZNbLUDiYnbP9lZmF/UlNAtEBClze+yYNU0mcO3sV6UJMe6ANlmr4uvHCvv55XdCF+Ofbb2Ztccjdv0BGfUFwavyd3MzMfJQFmkp+Ci/oDZXbpHbsHjeBjOzb9vAQ7Xp9OTrA=
Received: from SJ0PR05CA0187.namprd05.prod.outlook.com (2603:10b6:a03:330::12)
 by SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 20:08:01 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::98) by SJ0PR05CA0187.outlook.office365.com
 (2603:10b6:a03:330::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.6 via Frontend Transport; Mon,
 26 Jan 2026 20:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 20:08:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 14:08:00 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 26 Jan 2026 14:08:00 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 08/12] drm/amdgpu/sdma6: handle gfxoff in interrupt set
 functions
Date: Mon, 26 Jan 2026 15:07:43 -0500
Message-ID: <20260126200747.13527-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126200747.13527-1-alexander.deucher@amd.com>
References: <20260126200747.13527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd8f719-035e-4e33-3365-08de5d169b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DQGNaC4JtWVww0zS/s3tLX7t/QzlxfGRWhoDfWWEcKiLhcNDT99GduxtCiQ7?=
 =?us-ascii?Q?9yPAHa53+n22mBhdVYw4l7UEnlTjb7lapX0UzsnABu7cXdxZRiInQMjd7Fk3?=
 =?us-ascii?Q?Bk4BjW/eIZXP67M2poP8N7Qp619qt60oq3oAUAhO70wtwxGsV38z57vCvWsQ?=
 =?us-ascii?Q?GaBjnNd4HZIpPpvL5Oau/SOE5QFK7l7JFhMrUgbFp6K3gfVTOSg5hyT7NsRb?=
 =?us-ascii?Q?IlSLEzmrjMfe6YJDIJ6OOaK1EnuZOHwkWY1Sc8R+YWqoAZ5dus1q2qQ9sJnl?=
 =?us-ascii?Q?/iEu+FMhrCbVJgC4DLJ1r8ihPz6603bsC82S/B5RjMUY5YoF0qg5geoRHZSP?=
 =?us-ascii?Q?VjrGAwOMHeAAID2B7ji4q5xIYmaz+1pasZTFUv2AHgiszhbFx9irzjijlGsF?=
 =?us-ascii?Q?30apUZJfqrcKmBxvSq4byJD4fy7JkNd/UZTXNeYnIZS+QkKLQFR7FqQgwpWp?=
 =?us-ascii?Q?xSRimFgz6tEY2ZlbGdbGY2kFEAqxnBaCxRFkD6p9jikhbu4Ha8odxLU7lDOW?=
 =?us-ascii?Q?Q1DntWomrBSKwqXYwx/OCg8WpY7SsB1JWQG1tjPnlY9MuIi23AzFypdBjVQv?=
 =?us-ascii?Q?agK12bBFulL6QTtPeLC5QpNWxsOfA3GX8sEkjQCbIcXNF+l0gfiYmQrcoIAG?=
 =?us-ascii?Q?yxJqt2f/U/bYcbCr+x6n8RuvQCiWW2ENrmfTVw5DgvS9k31Ok4Ydcj8bCeZj?=
 =?us-ascii?Q?qjjRYlJ/DLwI9CRSk+6AnzxbCqHan8soo0z1xqf+A6AsMoSxFYc8EGxsCNam?=
 =?us-ascii?Q?f2TJIn9xSwDDFRgdIexpRyaNOB/c9KEDbrJgT642Im8hkhOxs4hBbTJ8KDPq?=
 =?us-ascii?Q?E0PIypiZT/t6hTh1BM+4bwt5Q5lZJZ4liry7kQ7HJaRwMXwGldCWztCiHryA?=
 =?us-ascii?Q?D7FoEpLtA36nXaH8s5qH+UXMPZ17FUXauoOfCy3M16HvlZN2UT9Dme9dkcKS?=
 =?us-ascii?Q?fgQNkGhT4LgHbibBVIPlmxu++DInkG8OAP6g2+7rTqAIq0pRFeCgfarfwTof?=
 =?us-ascii?Q?pdPxwYQ7Qy2X7wkqWKXFwL8h9r4VST71QVU4s2BluIZghac0TZyYkRwpnKDw?=
 =?us-ascii?Q?HWY/7CN0b9Bllbg/OEJ2X0eGwHjUKb0baAVAIXKS/pBSRaqpl9n3BxD7Zvsx?=
 =?us-ascii?Q?xOcCNCHB0/oDIkTJ5mDie7HZ5Qvn/dD3D2jkqgyN3hrOvjauYkp0fdrCpnCV?=
 =?us-ascii?Q?mJW0rpGJQ29tv7HM1FhsyW4tKfiBwgWwWv0Bz/7SBRqrTRi7yPOeuZaM0LnY?=
 =?us-ascii?Q?50jAALIB8Rui05/1l/3fd1df76b/98RC5m2ibovwkgpjpQU6xFA/cFRbY8/o?=
 =?us-ascii?Q?n2eNKnqq6laWkDz6/2cNW60jNzZNns658nzupXIjTH51GKg8wk4tQ9ZZTU/E?=
 =?us-ascii?Q?Yr56Ka2JGR6okwBGfZiIvFYnmcnEWxCL5MgLA2zuyCAlrs1X9iA9HDLnxRb3?=
 =?us-ascii?Q?mUVC7yIOWsFXtqhufY5DQEUnlxSTZFTreINwYmXaVzI3pxf2uE5HumZvduYe?=
 =?us-ascii?Q?r7Dir89m7hYWCTSTpTj/0emJtIqANQ/BNVQCFpErAbVFy7/yCZg0uWbsS7Um?=
 =?us-ascii?Q?FHcNL7RnyP+vxOmf8FdcwJdNnXwTqX/ieGTdhkUNdTcrC26wfpJ+7U1bhsL8?=
 =?us-ascii?Q?HDwng6SSnSakdLeVErBlFpYxg7/03BfhrbkklRNItyOtNJsgM9kmIn2T47Q4?=
 =?us-ascii?Q?vEckYg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 20:08:01.2297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd8f719-035e-4e33-3365-08de5d169b8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089
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

Need to make sure gfxoff is disallowed when we touch GC
registers over MMIO.

Cc: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 210ea6ba6212f..1baad542db043 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1620,15 +1620,16 @@ static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
 					enum amdgpu_interrupt_state state)
 {
 	u32 sdma_cntl;
-
 	u32 reg_offset = sdma_v6_0_get_reg_offset(adev, type, regSDMA0_CNTL);
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	if (!amdgpu_sriov_vf(adev)) {
 		sdma_cntl = RREG32(reg_offset);
 		sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, TRAP_ENABLE,
 				state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
 		WREG32(reg_offset, sdma_cntl);
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
-- 
2.52.0

