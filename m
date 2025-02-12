Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93357C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 21:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48C8310E99F;
	Wed, 12 Feb 2025 21:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Am3agEFJ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED32310E99F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 21:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEAME8nc6HvQp/he/+Yj5RMeWiwYJQ6Q/KP8oPdn6xOj3jbfUQw2PLZkDP7eCh1PzN7ExPMOC6srwA1pxGMrjuCQjr9bzqSQHnr4NRaAFCl3HqRKVLXiX5OenE3eJhUOypgvK4YcRMPIyhLgLiXcdYHrwHZFvD/2R85RdfJrxbfKwz5dXGOqdaPVcOdOXWF2q6oIGJrnBh2K/b27DVjzgIeSkEirITh0oyo8NPxSlmN53QiRH1Ugg+y+Inu5X7PMNk+wcPzviWZf7EFPAgsO3KxBrbn6dd49CQS53GwLs3EmWU87KK/5JsvMzQ/uil42HYbp2B8OnZ+P5g6WXVxp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjUD4+sMJe5dRPAJg8kX4pj2FJht49lYt/FZ5uVB8KI=;
 b=S7xj90bHMLPQDu+PCs45doFae5yfra9dsj3FEoC+KYVG+0H07s2SwTqjrdu1hUs3TNBIiWJsFeVFh5lL130qSDO7J4p5GR6BQ0JjGoLuLruQ+U2G9b/trnrxBpdl/dkYyNogTtJvDKYFFwt8MkNufrxDQtTAh4P7chQ8VT0VcpcbTWn/tpCPhNBpLGvEhQXh4ri7eppOgmCBi/pZx7XJw7eVEb51y3ZaWE11MXIPLML6DpnrnxYhhrfCxXsz0d9/rtNP4i8q+iiDWzhWrATlqxZFIPR7eBv1B9tvybC0LimjWKcZDhtMbdxJN6wJf/5aDlxaphPos0HmB/0eO/UmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjUD4+sMJe5dRPAJg8kX4pj2FJht49lYt/FZ5uVB8KI=;
 b=Am3agEFJofKj465GjHUR/g1jzaZxUUeO8CkyBR6f9sBZNzgE1AleSCUHco/c68uyIhqavcjxRvDPfYgu9WzA3EBMoPJSD7qTic072U6wOZAKSpTpEwLgcTjsbfZ/KMNgxRSCYkjwS3eiNRv02rTj8L8ZtjOqpCvtgdSHOe88cn0=
Received: from PH7P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::33)
 by SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 21:48:38 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:510:32a:cafe::ad) by PH7P221CA0003.outlook.office365.com
 (2603:10b6:510:32a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Wed,
 12 Feb 2025 21:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 21:48:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 15:48:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, kernel test robot
 <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>, Lang Yu <Lang.Yu@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/umsch: fix ucode check
Date: Wed, 12 Feb 2025 16:48:20 -0500
Message-ID: <20250212214821.2871419-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212214821.2871419-1-alexander.deucher@amd.com>
References: <20250212214821.2871419-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: a3768506-3ef1-4eba-0b0a-08dd4baf024f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GA6UMGsf077N8DDlWMCA18yeZQ64MiXrkfWasLk/l2rEnQ2rU3g2fILxgSn2?=
 =?us-ascii?Q?R1Lm1iYbDThkNTFEwFjKhsoV5Uk5yucxVfShI7GHVa9xFx3bN/Bk16AKhbZe?=
 =?us-ascii?Q?h4yJbe/6mJj0ltMk7WOUwuJiZjT6HKdCRtT04cxaURJIHGn+vvt52Y4W7br7?=
 =?us-ascii?Q?FndzDusee3itDLKWiDCNBHU2YbDEL+1UNHcKDf3ZDsryIWbJ/MWeIR2rES1I?=
 =?us-ascii?Q?2Z/vq0rIH5V0EPcX5y6jjstCb4oucrzYTD90CQXPNTOSL2VZcYDq7AuWonvs?=
 =?us-ascii?Q?mRHTrsmAcnxAfJ4IxXHrLE3nUcg6fTsXSBwNekxfAWZcahREdnbW6RreoeVC?=
 =?us-ascii?Q?ImmNvWcRcnMMvcXAwVSv6RqezdB1lJ3XKkHU+Wn8KlbdbndrHGzQHKXb7M2B?=
 =?us-ascii?Q?cowuVhYkkzUPaqZ5esXISdA86bgFqEP/xJG7CWdQLmusjcu37C/TzNyuOIiN?=
 =?us-ascii?Q?TxFB4p21g30lQObpZErD1123KK4mlCfndESazBRrYYSdouQTVxK5sLIFKEfd?=
 =?us-ascii?Q?6F4AO7J/cFRH6gsZ2xu9qUqY0Q9fS7VmcACOB7tuLzOmY4CE4RjMeday6kZJ?=
 =?us-ascii?Q?7FAOwsZ/+CCtGkbAbKlGjM8g3P1s0+2O8MWZy46dtGKj0aKVN0y32frptZBP?=
 =?us-ascii?Q?rakaxI6zV89b7mhvN4F7qUobVKs5/EA8edo8q0aX2AesIjXvgEzXMpnNfoBH?=
 =?us-ascii?Q?iSTQw2kRDw1ZxyI/Y7bsr6fTT3SAdenwOIty5uQJg2d9RMzK4lz5KIxNngvo?=
 =?us-ascii?Q?ksXBCGhVd4Yp4Rx1+Oi6y9XOzMRJo3q3ZYR8AA9PeyYHFxezvmwrZP7GvNWB?=
 =?us-ascii?Q?NA3cQRzXrjXNHy5gcrx3OQOO6vDPrnQZunyjaa0u+kzijv/KdcfLEmhST/oi?=
 =?us-ascii?Q?z4141piEKzXhzhcGZHTEG3tGRaGHxw3yIsM/Z/THwPX0+iwrYwpikhezgO8+?=
 =?us-ascii?Q?7dsG4iU0c6/Mc5bCcUqwIM+K9/qL05svYutFIx6hGU6PCm4fpdL5//gMzePu?=
 =?us-ascii?Q?s8iShdvUYXR4tFLH95qhecHkDXJQHeDPnl1HFt88O5XCS5lMUeUurroBogqT?=
 =?us-ascii?Q?ZUtGVMZY8lQtAiP1kvDP/PNLlkxYiugTzpUwtHKalkxvv1QNrDI/jy9gd+SQ?=
 =?us-ascii?Q?h63eWDh8T7U1aAG3Nabvr72RXQlxDphJBE6SN4zHd7ib6enBfnsyA0LqcXuc?=
 =?us-ascii?Q?4/JKXy1fgjuZ+7R240Y9CitboZoBjdTu7Ydi6yGBXtsQtwYcle6nCL2IubgG?=
 =?us-ascii?Q?cJc04dq7jabwiUAUhUP3EQD+DfS6Tg+LL03pRtwfO7T+iHeiMEceTuRdD/gn?=
 =?us-ascii?Q?XhIqQSzCxLoJFzz8XyOxLo5dC3fA4PAdMRLYhgZ1nRG8KA3Z0nn6xpcRw5Hf?=
 =?us-ascii?Q?lkusrE7ex3huNvlRt3ZalAufOfPcX00yIzqwy80YkAo4CiNMHCka1+ker0+F?=
 =?us-ascii?Q?O/QLYuZ35w+B2YFGHrSL49lTj+C/+mB7+lxYlqBZQ9S/0h9K/IHOo/ewAF+a?=
 =?us-ascii?Q?eHCQOgqars8298c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 21:48:38.5009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3768506-3ef1-4eba-0b0a-08dd4baf024f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941
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

Return an error if the IP version doesn't match otherwise
we end up passing a NULL string to amdgpu_ucode_request.
We should never hit this in practice today since we only
enable the umsch code on the supported IP versions, but
add a check to be safe.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502130406.iWQ0eBug-lkp@intel.com/
Fixes: 020620424b27 ("drm/amd: Use a constant format string for amdgpu_ucode_request")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index bbf16e7b5ab9c..e0e27f7ada395 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -586,7 +586,7 @@ int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_mm *umsch)
 		fw_name = "amdgpu/umsch_mm_4_0_0.bin";
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
 
 	r = amdgpu_ucode_request(adev, &adev->umsch_mm.fw, AMDGPU_UCODE_REQUIRED,
-- 
2.48.1

