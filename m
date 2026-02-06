Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58B2EE20A4
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 13:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C35F10E73B;
	Fri,  6 Feb 2026 13:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Piai6ydo";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3FF10E73B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:36:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxAcJw+zew6I106yNRprT62CGf0u7u7XJXf32d0xPPC6SvHO0bPuPRZek3Sbw4BZqyCpxKtfdAgaHfD64ngV/o5v6Ljd4VsNtQ3OxrNHg9UV3aVYssrJi0u9hY8kK1NGBkmyhMr4pdtZHsdqBrd2d6zuygtX4BXwqKB+OW4/aCBNgvKEendB9NfzDBqJ4Q74W7+RhySZ6RpQjcLKQTG6y20R0BUXsiEQ0EbhzGXO1nxv/e5rs14oYyVien2prpDtse0/fJOCwaROV6qg9iq8JXiozwI2U8QEYPryIHPZbjQKD5mYBPvpE5e/8bhWEzYXmGhiPuvVZtWSMxH8pcqUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHdMMjoPCTYVi0RoCw812UtzUiYcQc39Euiy/ZBIlMU=;
 b=asMeYQ2QdSgGyiMT+B8aqIoS93eDVCc8wMmdMP/Q4L9Pw+5rehWOIsyOltRreUI0yxr31TrwUsV5mk/aDSDSKFRK1tGPv7n/tzN3XeI2CyxHl2tBYVlOJWUvclM6SQXicLnsBqSY5lbUCZ0qWQU6nX30VHHWBqpYrW9mNsbyOdYtHJtkiJ+VmbI3zDkDafctRlHXeco3wxvP6p7XcY2a/fAQ+3D6gwBLTYFuZ3P6a3Uma9KH5w/cLq+kzplvD16xncS7nfXzN/rnyo8e416JWP8kWCJgUs7BnZey6Em77SIqCUKfSRiT2VXrSAqK9zsBNBPNxU5ubLvFXliu+U2Lcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHdMMjoPCTYVi0RoCw812UtzUiYcQc39Euiy/ZBIlMU=;
 b=Piai6ydohjov39NIFUZRfVNc8QG7jTn3C2C5Li8M8eAI+1pNRKaoSbgBksPe95ao2bKmiyjbZtZTwC1tEZBHBQA8K/69+OoZ6w1aebm5a7WFzUrIykOn/WmF8EC5Q3dKdbMYRFXh6JPePifCAyu7Gs09yC+jZlJXq717MhFR6+8=
Received: from SN7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::16)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 13:36:41 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::f8) by SN7P222CA0016.outlook.office365.com
 (2603:10b6:806:124::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 13:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 13:36:40 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 07:36:38 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v4 10/11] drm/amd: Add CG/PG flags for GC 11.5.4
Date: Fri, 6 Feb 2026 13:36:06 +0000
Message-ID: <20260206133607.91047-10-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
References: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec403f4-66de-46ce-74d1-08de6584c2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ja2boJDiieSdpCHgdR8ClHIGzqwN/85dGv9mK1i59a5QRYK8Ve8OJkEU8fq6?=
 =?us-ascii?Q?oi8oZbu+Y7tkMg/NxNzs+XxvqL/1I8xR6eW4rlka6wY/BsVz+PSmq2wqTNTH?=
 =?us-ascii?Q?Cl+U0cnyH+gspr5JTg+Ro/ZI1uWIsXn2MJKSSnY1ZEjo3rd1mLHeG9VoFERB?=
 =?us-ascii?Q?uXzRO3wAsdiPbbj94R0jKkhl+q8YaJxE8MEvue9lSihAEpy0lJ9I+W30/Nut?=
 =?us-ascii?Q?VnAThrTXZB63iDqMPq9syjsEH0s3uujtlNHKb9JNqyna0mcsabYbFe5EAizg?=
 =?us-ascii?Q?Hcv4AqTC3KSXECd8wk+QtNoBZqJk43a2Yr54Un202O5CtapW9K5a8P0judNu?=
 =?us-ascii?Q?VQt24ODgNKHwtRLlFZ7a2PMZTZYifHsiK3Bv+1QKx5YG/toE2CLsewwKIkWu?=
 =?us-ascii?Q?oAgH7NsA2SjXZpQowh62NOP46x9kb7kyrl11JQD8xQiV25i+vZTWmQ606knc?=
 =?us-ascii?Q?SnMSZ8rKJNe5raqaaK0gtKGP2A5BViOxAxZYQ4Ytg97UXr43DjFC+EP7Zf8s?=
 =?us-ascii?Q?pk3RTms8mcB1vLZR4WL4O+Dh9pcGK/cD4HRK/59i0U5koUNCwVFgENLpiO/s?=
 =?us-ascii?Q?YLmrpsMAr5J19SIcl6/3Eb+hWSC7H2JejP/zJEwbuiKEVoI0QDOTSugzeRYT?=
 =?us-ascii?Q?CXaz0YmEeNrB2E+y3W1Dj2SAwPDZOm1yrBpvoPkxty1IbJKCre+DXmHB0n8U?=
 =?us-ascii?Q?jvzhTbSLLrgyXIl2c5UgrTaqRC+1sIevGJYPMzAc6ygHERTnJhXiNs54NH5M?=
 =?us-ascii?Q?AQRvcjOeYrAtPpWvWIEWj0lH6pXviInYoaI7IUlYsaPEra8NdfaFZaijuJwE?=
 =?us-ascii?Q?hHW0Kc8O9TD4Excu6avUcy4EvW0twTEqvC2zGbUgk5cA5MP+q1jTYT4XXkPh?=
 =?us-ascii?Q?V6iDsvTbHEXxXhRJjVtZSZD20CZKD3l9PXjmnzKnMb85RzobuBSTZ1GNtrCL?=
 =?us-ascii?Q?ADXd2dezKh+j2laTV/1vD2xeHCr1bSENbJlwk6UTP5R81IFXHoOrdC2TgqIW?=
 =?us-ascii?Q?UF9UAxZCCDTti37fmlrTLl9uBl+qW4bHurMTt8XcrXeVD+lWrFoRRoewg7/L?=
 =?us-ascii?Q?02P55kwp1o6lNMGAaXFWpuBBcRXLmETKaqsbonJftyc4SYn4K+ZSNrwzgfCR?=
 =?us-ascii?Q?+M4u7t2M6Lm3CkaWPuAZq4O8IqTufyHGE75r0QsCAFbf1+CJZ4waW3aTdDLg?=
 =?us-ascii?Q?iC3ys2m23Bd7CtCnf+ZaOk6IgrotSvTsIZQYuUAayaaF3Ni+A+MjnJuz6pj8?=
 =?us-ascii?Q?8cw55yzlq3soRZX3dIi7+WBFfIUW+FWBMSDslFuEQ1AEAayS75s6wgLp+ZaV?=
 =?us-ascii?Q?+JoPVNvfRF6yBRIZLyMQLDUEeeZoWGfFmc+C6K6t8Xy/USbqdyMXVna6y/zq?=
 =?us-ascii?Q?eAwwP2HVKR3TeGgvCmOhwdwY+KIrrAtxusDD/khrlJ6jM/EyJ1XQBhLig/UE?=
 =?us-ascii?Q?u+07JMnby2JhZdclPzSjBCDJT1tdaVN83+4e6SIx9mKjMAV0xV9eJz/sjDj4?=
 =?us-ascii?Q?cha2oTgwm4uwXhHfhccaMjCbsDX0YMbh+E81YUKQWw4n29vd2iPgtx2PlRuj?=
 =?us-ascii?Q?atgAV6lEtxoIcaAqeH6/RtpDmQEUAbX99EZ0Zt+AdY6U4J99xBfsUsfLLfAc?=
 =?us-ascii?Q?rXBIoRcnI32cCVUlxHeyAwoNF7lpfHRLwfllHZJC/g2DgXveMgoddayFhmqm?=
 =?us-ascii?Q?XF0Cyw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k4ayt+GvD+S7dFuVd1Oeg509G/CCZCDLrGjAfpsWqkhlCzDe3H7nAo1wiZLfnEI+IWBaK2MI4HXk8GCmx9Z5gFTNyTMJpY9/SMlI2S4Z3KXo+9Xev90k/VeUyGb1ne6DZx1wwQp2C8rgUnj60CY/wW9IA717tru2jeIJjDEsubDHlOk8ZCuWHfBq6k/LkSj5ZAMzuGPJvsJ4G++dtjGaqWBbRXWE0ioMSdkqEKt8UVi7+Cfj6RPKqQkph7IJojb4jnz3EEyQ9PoWq9Mx2ivchOXj6zA0cBRZI3OX9pwMyl4icb3pd/y2jMgAZlEUoB8vhCNN5FkVRLK1fJblH2TJIbfUv+p9HP4T/GeSCiDj9qQiC2FtSa+9FtTP71my4CyTl1UO1M0pf20z94tobRkT0E7S7BPxsTIqovOlTK/S7jHx1GVwS/7qS8/6bMTyvZUf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:36:40.8003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec403f4-66de-46ce-74d1-08de6584c2a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
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

Enable GFXOff for GC 11.5.4

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 79d132fc8ca9..8122a5cacf07 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -839,9 +839,28 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 		break;
 	case IP_VERSION(11, 5, 4):
 		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
-			AMD_CG_SUPPORT_JPEG_MGCG;
+			AMD_CG_SUPPORT_JPEG_MGCG |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_FGCG |
+			AMD_CG_SUPPORT_REPEATER_FGCG |
+			AMD_CG_SUPPORT_GFX_PERF_CLK |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_HDP_DS |
+			AMD_CG_SUPPORT_HDP_SD |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
-			AMD_PG_SUPPORT_JPEG;
+			AMD_PG_SUPPORT_JPEG |
+			AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x1;
                break;
 	default:
-- 
2.43.0

