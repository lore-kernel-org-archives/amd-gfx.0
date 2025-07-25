Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E81C83F26
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 05:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15ACB10E085;
	Fri, 25 Jul 2025 05:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D2z5a0vw";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD99510E085
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 05:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6qtEukwK6RhOn4qbeJBwUSjZ7WTpN/6I7UlQ5bJ8IJutUmRBaIM6O/5xC4FzQlD5+Btt+wkrAlvFmgXS4HVnoSgqsBfjXt7s6dMKTOVY/mXlJ2i/MjOc/nB8eleIAODdntIGSzou9q/e6RlboMulVd2mJ70rogXyFCm0s/YaNwaZp26UFzs2lAgLjfjIr6eHOIv8ZpxfPHEvAfwsQ8VZDK4G9/m7O/hs+1sDnK/Cm7sYjZBHnFhO5AkQ3u9UZTkOL0eogRoOjt7BuKkmh5E+kLrxwxaJq+TlIv1SI5Ma3j9f0NWeAOODVLdHQihOoqbiN5vsEE8IIrher1UkQGM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqI2DyORwQxruQXkAchaVhJLTAoGQFBc1U7t5I4A4IY=;
 b=iNQWVIGdJqMFgfJ9Livxf0slilT3yps6jOmBjEjbaHMEomOCs8GkG+UBC98dXgVwkYTn3lDFUqMaKLL+WxX7SqTo+uXX6W9KR0YN7ENRaOHcPWS2bHKRuPrLxCIfdzrtZ8Y6bSJeT+TlPoK0cgGSSQVGRqjyqzEPpK09Ls6mxO2CQMm9M1hJHsrvCqdA92tWe4e3TRp3cCxYy6uF3fT+Su6WmPWkn3hSBXHiE5C9A+wmBLYQ/pnOe3CF6HE6/wVeYbjvRf08HS9Q5ofy43553kabA9HbyPOYnWs1D5RZUTbOmS6HliLJfDf9rlkXkVbYcCFqWXfjblUBUsQdm9biVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqI2DyORwQxruQXkAchaVhJLTAoGQFBc1U7t5I4A4IY=;
 b=D2z5a0vwn2U0PmrkTkATfEVKgD4U2WnD188rI5ui6OCN1S08IY8ecvfTJ95ysaV83SeUvFWJLJy+6gZEjT/ypajQI5SEWFqJTBzE5s4Nrpx2nK0OZs9cLBJwJG9pcj0WzK1hR47LWX+ksqFo9N7ES0e4PvGDHMOokC3YsyUK6ck=
Received: from BYAPR02CA0020.namprd02.prod.outlook.com (2603:10b6:a02:ee::33)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 25 Jul
 2025 05:56:19 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::2e) by BYAPR02CA0020.outlook.office365.com
 (2603:10b6:a02:ee::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 05:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 05:56:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 00:56:16 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Update external revid for GC v9.5.0
Date: Fri, 25 Jul 2025 11:26:01 +0530
Message-ID: <20250725055601.1637428-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: cc465ae9-b930-433f-d611-08ddcb3ff9c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MVyN0MnwCwBeDwy9+m9d4B6mwXvrenxMkpeBSyeZyS95m8Y58ltgLMl/wcsu?=
 =?us-ascii?Q?ROIO5uQQ7NCMvJV5UKfY9IM9alOIEECXDKsnkbX1Ccch3h0gBgHMhoJOaMQy?=
 =?us-ascii?Q?8Aa6NZXwNQD0CqZQ+SE0Tvl63cq4Ox/sTR3V2tYx5Rd4hutLV1/BS2lZLGIE?=
 =?us-ascii?Q?7W1hOFYyt+TUtgZycQnOGYBwHIzAVASRohNqhqXS3CrpieWdWVtV8VQfxGHG?=
 =?us-ascii?Q?V3eQExAl0UXyZH0vrZ/UnwiFKVCfr6tYnjN/YrTdG+FxXyYtqSSYA3zcXVcm?=
 =?us-ascii?Q?k1hY8bIGQDsJn3BKetsbRmhJrL6zjTJc/CRvzi+qnIp1pxr42V10txfQaQaZ?=
 =?us-ascii?Q?dXpsaES9jZJq2/bPsrkl3Mcc1NrK5Q2a5nRRL/1HvdQ6SgfxN6MJtC7I8xjh?=
 =?us-ascii?Q?LEKZt4m68uAjwV/9a3Y8zHlsbLZLvRKb9OWJoDEb2pLlgf+QZOzy4oIUaGfi?=
 =?us-ascii?Q?AmPmcUk3rmkt9NC2zDfIMoEjw4xRGaOoXQX2/3mL+/z3GT4BBuWV2DuP1dW5?=
 =?us-ascii?Q?2zRtL0es21StNr+ODG22porw0Q7m7H6z0BFiBOEgqKom3QHSTKKFBHxqPgL/?=
 =?us-ascii?Q?P57SyB+U54ofjHzSBdko2usnKCFp10FXuHjdhOmU7fv2Rffyc1it+8hl4z11?=
 =?us-ascii?Q?4leJNX2VLiCXebDl0OtXcietkyYgic4KyCk16013kJDd6h/UpH25mLnbNGXq?=
 =?us-ascii?Q?wrnGrdtyb6PRxq/ClPwpVK6p+bRhgXSaMd7mHd+Un3H92we1Y4UXIBOCSGZA?=
 =?us-ascii?Q?huyVGRY2setPazPovapKXrWwIwT8SaZsYLSM8eba+lPeyvWluuGI5gNdDsOM?=
 =?us-ascii?Q?pD/M4zEZSIE6MtkdMXTO5LdslaIKxvLRvWthTl2iMjMXyBJ1cLmojqVqsi4S?=
 =?us-ascii?Q?wk5p7vngTUeIHe/xBhefMYyslF+QBYJoSWxkt7NafmCcYSoKurcV85kTX5Lr?=
 =?us-ascii?Q?nkhchA9yr1+MEIanCjTLw1HQ5B9Z0vSY7FSORI5yst+qI25kMzwBCqlGUfye?=
 =?us-ascii?Q?Zns7QH+C/sqFiKLCK9UJnywxe6kVW0N9RbiXzgbxQWXiyKNL9EZqhpeY5LMr?=
 =?us-ascii?Q?maQGrS09XdkLS6cXQjdVLLHPmUC6brC9ymQYjIvMVW60bFg3gKepmIEG91ED?=
 =?us-ascii?Q?DsrPdTSQc5jIo3rWM6foltKRYbznmwIi4V7Vn+LpTNhJT0SWGHQEoEfFgqSe?=
 =?us-ascii?Q?iGPLTav4ZbqEgrBULOCV5xncQI0Gnd4wo4KaD/XrRQxDqYs/9R+v5/yfgwen?=
 =?us-ascii?Q?zASREPcxtY5AKbvffwBKb/r/jxDHls4J8wzx97kZ8SxgR4bkNI4NoxL+asMP?=
 =?us-ascii?Q?ycmXIAOmZ3q16x86bQ7XaGnu41kGdnIj+ZQo3dYJJSKhxJXx/N0io+LSNApr?=
 =?us-ascii?Q?XdFiE2NUDNzV/GCano87/4BaWTQHXye8mfiGSllcco6h737jjLAlPzOwcaaJ?=
 =?us-ascii?Q?6r+kvt5rwN7XxFDwHXbgBItAWhGSwKvzO9hbfz+arf0VCcVfT9gnxcpifsh9?=
 =?us-ascii?Q?jznEuuB+dAOX2jyUDC+JOcEnDy2wRqxnY0gW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 05:56:18.8922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc465ae9-b930-433f-d611-08ddcb3ff9c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
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

Use different external revid for GC v9.5.0 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c457be3a3c56..9e74c9822e62 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1218,6 +1218,8 @@ static int soc15_common_early_init(struct amdgpu_ip_block *ip_block)
 			AMD_PG_SUPPORT_JPEG;
 		/*TODO: need a new external_rev_id for GC 9.4.4? */
 		adev->external_rev_id = adev->rev_id + 0x46;
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
+			adev->external_rev_id = adev->rev_id + 0x50;
 		break;
 	default:
 		/* FIXME: not supported yet */
-- 
2.49.0

