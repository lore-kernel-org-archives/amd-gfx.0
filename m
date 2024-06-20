Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE837C2BA1A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4376210EAED;
	Thu, 20 Jun 2024 16:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="15JZnqaL";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8037010EAED
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:14:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZVB6DhIeOFaaNmZhzc6EoEM7LdXIHHPUE3aYvMK8S/W7LgZXqXwQtBFj+c9IHKn/ZVU8ttP+x4Wsat7MNHO9/cd+U2GLZuWmnDJaaiFlL8ps/UXTc3fpKzc76lF3KC1kjRJYPElf/PvalvpIrgBPBWHrXIM7jEXciQFHUUt2FDIYifZywwNlu+gTeItPZKMWUoKY2vryCLR0guXXebWn076Wr3QA0VSW9SVv/rLcO0MC0pGdg4SIbKTWBr8M0aymiyW8X/d8Iofm0wJ/Nr0Zpt2cFjB81DykbzULcJtHe7jEevRnuU29UlbwyDVFQ4CFZOBU9SkJZbKXvyFQCjSnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sg9ctmRE7XKsjZaAA3y+7IeqauPZfbGVCxDECNVVPRY=;
 b=daUqP9LKZTS2hA/I6cyYHkFq+c3SifMbLWHx2kBA+Ogx4niK2RyNr7r2BdvkBTdtvIPEuu/jSaiUOnSN0mkgYjA082YlbLahmEYYN/A5rpzJNemuudEznJb7Jj/b6M+WhQZw6nF09OVeAKExvEtQRa6PQw7/w9C8eAQmcgJm+rw5VCfVyLwnotfA8WX8a9GetBv4daKEtUdXopQR5ELWir3y585/hhbS4mLUafB+1yzQkaqWT3fGn9uLr5wLzJ2r2JiwcPmfAhll0aakiBeLKpVeo5JFfTlwfk3ZeRPPamRErV57oU0kpD5pc4pTyaCII8DDXXfMJoV37C8kFyVj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sg9ctmRE7XKsjZaAA3y+7IeqauPZfbGVCxDECNVVPRY=;
 b=15JZnqaLC3TdKIXtKDnggZhjyIFFUDWeqD01e12831IxDm8cphdFDO37h0JY7SbexhkiX6+1kQl2Z4c6Om0aevEMZ/PPHzdvz8TsAg6reUQqDXJHoLU+ykDS8+/871cYlG9KXcbWEqz9P28sOsPaJ+wTo3cUD/gk9Gp6OKNo2Fg=
Received: from SA1PR04CA0011.namprd04.prod.outlook.com (2603:10b6:806:2ce::18)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 16:14:27 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::81) by SA1PR04CA0011.outlook.office365.com
 (2603:10b6:806:2ce::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:14:27 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:14:23 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 10/39] drm/amd/display: Fix uninitialized variables in dcn401
Date: Thu, 20 Jun 2024 10:11:16 -0600
Message-ID: <20240620161145.2489774-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 7426cb56-2fca-455c-05ec-08dc91440f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|82310400023|376011|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?juUJWFqPnWmVNv07haxvGkSHUpLg9UFEQVc36R+0dKzPcKr6xM4tkmsXNhg9?=
 =?us-ascii?Q?gFnHplAm/PJBhMjGxVWeHtkkCZGCDmrQQ3668R0jQt3EW6fvjrD5OvHJnXdq?=
 =?us-ascii?Q?g7wRd8yrXzh7W/CmhGQnJkHwOkO4p2XfaiGYbN63rDniv6wqqUdcOhLKOhpe?=
 =?us-ascii?Q?xj+dXy/iXNMF0jo9HLlCr4PXl0eAbGk4LqmTIKuee+cVP0Vzf3b0yl0KRmiY?=
 =?us-ascii?Q?Rd4SkLtPnbAG6BAvFX9F6RgrF0JWjqcvxbfFbcSDrSpXVNoCxT29Sq9s0xvr?=
 =?us-ascii?Q?5laTqIOENce1Rs/ezF/59dF8kOk9Dtp87+ZMQQTUcTf9+pLC7bKZhdDEHlgY?=
 =?us-ascii?Q?ZzHKwmSOTLrxoT5yAA1TNi0eMzNQd1KM7WmTUHIwsyDbT82jsd/9N7Lhsm4y?=
 =?us-ascii?Q?/k7Cbujl3bN4dGC4O9N5MElatmnG5QFvwI69MdB+aVMZYBTgwzgYfgCYNkRH?=
 =?us-ascii?Q?QRScTVMeIhOkIjWxnzcv4Bo2EmgYfppQsfpXgwSKv2gvke+qsVwwsnWw/FXa?=
 =?us-ascii?Q?GQQCZQ3jYEQXTLrDFijdr0RCO0qx/EI0Aw2aFBXVkLt1xcD1eA8YZ+ndzWUq?=
 =?us-ascii?Q?RpHcyYByTM9rx4Hg8yIITRg8B9RHNMEBDLrdAOGyTjEfRY7IpBrReFiRU0cc?=
 =?us-ascii?Q?dr7G7FwHrUwVfobADi3BtMBDBqqF+QTOrhII5Ujv5Ksh4hiVdredWHxmscgc?=
 =?us-ascii?Q?5NUoITuQmCpFvCHsHUBP1vo3q2DWXMr1sG3Ao/89R9bj9eO1eoxS8nVOu95M?=
 =?us-ascii?Q?EzAbPNkkMKsEgxaC0zw+Kg6n/uSJeIx/12DsDKFybSX9Phr5NJNKu3+q80f8?=
 =?us-ascii?Q?BbUHHbLh6Fj+4755G0+cOqMmOe8uyMB7SLEE02f16Re3BpzaBXbtiavY1Lke?=
 =?us-ascii?Q?skiatafiYZzXhvZbi02+rxXpvPfwWBQxmSuO0XW0im+E7K5Cq2fYCMrcI4Dg?=
 =?us-ascii?Q?8SU1m/8DQBXQCB45j8fV2ishgBr8S/uW0lthb14xoQlSRs31i/dUtZ7/2Md5?=
 =?us-ascii?Q?tLOWykhWI968shEBIK2SZ1XTUqSa3hipbWnPVsl6LzEvloQG1R3itjhCG3aw?=
 =?us-ascii?Q?eDONJ37F+CyxKockvYnhuCsEX9INL+3crbJOYBsNFLuclocjqOT8/5ldx4oH?=
 =?us-ascii?Q?63s5C4hMFM4Gq9gmujOY4PbK893FGbBIIXWk3nTfxaWtABgbW6Tn9GqaHR/h?=
 =?us-ascii?Q?xLPCJ/Zww+pXAEc0CLungUyW3PIr31P19DYsv0/BArYG8a6j6geVCmCKXZmT?=
 =?us-ascii?Q?k2gpfhpWy1G3OfFVid0T7B8bjuiQkW5/YIcVSkvqG3gMLFQR38D75BCcXWrn?=
 =?us-ascii?Q?c7ttc//BMeP2e/fNxuZnjLElCboW3MAAxYTwTFiOGwL3pV4gKjsrzyr2f5jK?=
 =?us-ascii?Q?y1i+1T/68beWJEKu9QE1gjmCouerkFaQn25CQ/rJSs8somSANA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(82310400023)(376011)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:14:27.4833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7426cb56-2fca-455c-05ec-08dc91440f0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507
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

[WHAT & HOW]
surf_linear_128_l/c are used in CalculateBytePerPixelAndBlockSizes
before they are assigned, so initializing them before passing them into
the function.

This fixes 2 UNINIT issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c        | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index be73784e21eb..6f4026e396e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -11521,8 +11521,8 @@ void dml2_core_calcs_get_dpte_row_height(
 	unsigned int MacroTileWidthC;
 	unsigned int MacroTileHeightY;
 	unsigned int MacroTileHeightC;
-	bool surf_linear_128_l;
-	bool surf_linear_128_c;
+	bool surf_linear_128_l = false;
+	bool surf_linear_128_c = false;
 
 	CalculateBytePerPixelAndBlockSizes(
 		SourcePixelFormat,
-- 
2.34.1

