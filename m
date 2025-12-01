Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F186CD116FF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 23:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E5B10E4C9;
	Mon,  1 Dec 2025 23:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k/5v3On/";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 383EA10E4C5
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 23:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ie8lEeTjUWTpObKoOe+1oQS0BKQTRT20JxhZ3m4/hZgs2uZG7xuQOyYEQXWxnCAts0cRJzvRt3Iq7PsZ67ofUTSd9seOUrmMyCQ3gZumYgGGQiLZhCxzBNIJ6U7xCGpJMFBulRWE7qaeJv732bdjF1Rog7JSi4oSsR7WPUkDSf82IaJjIF/jnY+gYuUDXvHg9IzbHQ4oD4YG/q85UUN+vrEvVGXCZrl26HsUvodpu70GaHuDpgp+HF+r0i2Nw4N+QjP4ZgfH1RKeSTSPFpA7+WUS+aCJHfhwK2XJnHFp+Q5tzE3WN04ezmZd/oG6Sf5ItikLBpibMey48YeEYFNeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xf+M39hX9RMYyf2wtJReOle+f3oP2e+zof/vBiE4P18=;
 b=OYh5GbPnae6NgIpeHRQyk6yp+oX1tONoNjlpzSXnzINF/jZP68iYJtzx3afy7KwArvN3nq1sXGNBUsoiFHkjMcRUXxp1EydxHEbK9Vuqu3q+WUwmAdo30/6qES7mFEOVLt2L1Xrn3crBAvKyspeUBED1IguQ9RmVTLq+mS8z64y72zqMgLPQ0Eozmq1/4PdqYUVDqfOmgvyTyb4nAIOOx9Eu3FUO1YV7IOJOAgtGKhd7VgdyN348gYp5GWmUjXW5PL8q2h1dH32LWUXE+7/eYpjHNH4t8THsZ1M7jxmlWG6ICa6DV7yF38YRrz/UMLUEP/1gmi8CdY4bCctfSBXZiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xf+M39hX9RMYyf2wtJReOle+f3oP2e+zof/vBiE4P18=;
 b=k/5v3On/jyawotlnRPtS8lwPpYo8ZXeVZHg70Q0kS2Yn0gLR2AXx6ra4noZPhVnaCGPnx1IxTePNvOn9epubNZIhfn9u9P97YlmxKRWUjVYf9EaBCHU2n7TtLxX8P1DscUhK0a+3Je1OeI/BNluN712vEsNocTieDeViESznTwU=
Received: from SA1P222CA0045.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::22)
 by DS2PR12MB9797.namprd12.prod.outlook.com (2603:10b6:8:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 23:15:27 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::e5) by SA1P222CA0045.outlook.office365.com
 (2603:10b6:806:2d0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 23:15:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 23:15:27 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 17:15:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Revert retry based thrashing prevention on GFX
 12.1.0
Date: Mon, 1 Dec 2025 18:15:04 -0500
Message-ID: <20251201231509.791954-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251201231509.791954-1-alexander.deucher@amd.com>
References: <20251201231509.791954-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DS2PR12MB9797:EE_
X-MS-Office365-Filtering-Correlation-Id: 5046bd22-48dd-414c-9846-08de312f83a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xULEnZli4STvkK8vOv0sFuC7cyXskToXq1bt5c/LOc4PkJ+6Uxv/kippECSR?=
 =?us-ascii?Q?Kpvle1tPbu6oeUncw45WZcaWfqwvS4OmooLJgJHQ2T6oztEMgDFyFhrqOuKN?=
 =?us-ascii?Q?aCq/KDsORblVHhijCtvMlMOik20vuFtubr0vdj91mCHTCxCrxg6k01jwY+e5?=
 =?us-ascii?Q?WzaBVPoiWU6V4fRjyaWINuae/rhZwr7Eo4mgXZxsTpu28Jwn6ENZYst4NocD?=
 =?us-ascii?Q?hl0fHrc3SF463hqwiDABk7FGY8tQ9rHfHRR81xl3V5EhDkn6U6diYPGwE7DH?=
 =?us-ascii?Q?bQXUxG0iBzQIRzdXfLXrTfSizSNEY9Swf6OOht0EdvPuzSAspfV8xMCrM7AC?=
 =?us-ascii?Q?WdDxppPcNf9NSu4TzIgtpGjYBNgH1T1tTwXL3O3JBrbGxpGDD5sFdh6mvw2D?=
 =?us-ascii?Q?IU0sm5Qi5vnsri/5WDPVowVNG04Dr6FFIsLCuDni+uzYo2u0BtErwEzhJ2B/?=
 =?us-ascii?Q?QGnPBY/DWnn5wKzajXZdUp67h07it2wmcAZJz9L8FaJpr7XXtYDbkb8BSLDg?=
 =?us-ascii?Q?kx4Av06maz9tgz8Y7lW9zbsrxuX9EP3/+elqTDT5VruMpNcX8KiXVDO2eoFR?=
 =?us-ascii?Q?rXrQIGjmChhzfhItAQM737Gc1NEey1+STfzrYa7MIS8hqsML2t6DNeGNM009?=
 =?us-ascii?Q?NqNCERCdAbfCGJDz3aLEP8GWMDt3ghC4wnhkuPl6zj6iypV2cX4TPgx3XPnP?=
 =?us-ascii?Q?DQKKDHseZLrqh0FheLYHF6jAnOvQGZFEjzXtUg25HyzQnWpZj6RtMJ/YvknD?=
 =?us-ascii?Q?rrBbPSB/nBJZY8F4OytONcUcS9pXhEQUTE8pK4MuCyarltmcA8AdLgcIQvDm?=
 =?us-ascii?Q?HOHhIPnkHULuoTNMOZ1nFbXhsz63hEBGIPO5dgItwHkDqZ3O/ulydz7bYxSz?=
 =?us-ascii?Q?Ko90W2Ylkw5sdux5nC1hKrUxlqTq95cKvq3xaUETtefOIlrfKEoVjo8HQTtL?=
 =?us-ascii?Q?/faoaJLxla2BV5vv3dwSUJES+VHKJAmYNIP5hSz4yoBHfL31aZeWqFds3d3T?=
 =?us-ascii?Q?Z8gT1wWKP0nRAkJ/RBGM8J4xPkdZemfvU92S9BPOJB2Qp7OCBhyBVgnDSjv9?=
 =?us-ascii?Q?9H8v/qx7whOubZ8/91aPwNYF9ARVb4hW2kA9wcwqI3ju95W1cHAtZFap2qu9?=
 =?us-ascii?Q?2rknu4MC6BKOSyVkDE05fxL4eRKieTtAFlmObOytBLnEzgQukL2MRLKFb8dv?=
 =?us-ascii?Q?mOBby5IAAcRHEomTMVRF7nha6jB4E/KEIF7AFIy7xLgj7pxcHzkrXYRN2Y76?=
 =?us-ascii?Q?Fqrg5rh/9iU8KRQ4rnPijG5e11LxsAU6SO7xy58j1OLqkZe6SCr3BjrElSkT?=
 =?us-ascii?Q?hTrEA8ffXftASj/JTxuh3jA6JWEyLh2Rscc5LQN3E6Rq0JDrZ1Xv6P3SiOER?=
 =?us-ascii?Q?hduXHlhCmBJGDsIwm09gxekzwu50/shFi9yfIO7WBAxEH1TQ+s5QnTrTyjV3?=
 =?us-ascii?Q?RBi+ve5xa6aWTNDzuMUijIDUbGZSGPubvqSvTr7qS8d4hdI1qwhpVrIhX/OU?=
 =?us-ascii?Q?/1WFIJ0oy2yoPsDK8GGXqoOez9ioJxa1rBHKFQ3HjY5lEJS6DZqqVy1d+ux/?=
 =?us-ascii?Q?aLmo0uWBlerNWfEtye0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 23:15:27.4158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5046bd22-48dd-414c-9846-08de312f83a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9797
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

From: Mukul Joshi <mukul.joshi@amd.com>

Revert the change to enable retry based thrashing prevention on GFX 12.1.0
for now as its causing data mismatch and slowness issues with multiple HIP
tests.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index edd5b41a1e395..da01903113f40 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2512,17 +2512,6 @@ static void gfx_v12_1_init_golden_registers(struct amdgpu_device *adev)
 {
 	uint32_t val;
 
-	/* Setup the TCP Thrashing control register */
-	val = RREG32_SOC15(GC, 0, regTCP_UTCL0_THRASHING_CTRL);
-
-	val = REG_SET_FIELD(val, TCP_UTCL0_THRASHING_CTRL, THRASHING_EN, 0x2);
-	val = REG_SET_FIELD(val, TCP_UTCL0_THRASHING_CTRL,
-				RETRY_FRAGMENT_THRESHOLD_DOWN_EN, 0x0);
-	val = REG_SET_FIELD(val, TCP_UTCL0_THRASHING_CTRL,
-				RETRY_FRAGMENT_THRESHOLD_UP_EN, 0x0);
-
-	WREG32_SOC15(GC, 0, regTCP_UTCL0_THRASHING_CTRL, val);
-
 	/* Set the TCP UTCL0 register to enable atomics */
 	val = RREG32_SOC15(GC, 0, regTCP_UTCL0_CNTL1);
 	val = REG_SET_FIELD(val, TCP_UTCL0_CNTL1, ATOMIC_REQUESTER_EN, 0x1);
-- 
2.51.1

