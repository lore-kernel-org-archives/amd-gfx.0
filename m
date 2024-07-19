Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3ECC3DA59
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jul 2024 16:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEEA410EC64;
	Fri, 19 Jul 2024 16:13:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="16pcnqHF";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D533710EC56
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 16:13:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLnpstkJ3bf65gYoQO5Z6sur46wefysiDJ5Ubb0LXTDzM+HnILn4m02WahzBAk/zPFz0r1/LJt4S+b3XPeN8x3nKunOJs7mawQWlwQU3DClkB3dVpkuEpd4FynljwqRNVBgn2gFbKm+iZ/C+Co0S/kxEajDo/DNUp1vu69c6zKsQJRsQ/25mN9DDHOUKiyCoJ9G66sf5CCNqME07YfMFX91ZBaClkMlgmJng3bTxgcEi1r6+adnMnEHfuJ726b4h1TBsWWcGqueRVbedth1TTyQKTS/uKtRzRWmMCB2sNg1GpSoHCEz4E0U86sOt4VfXngN4SAA/DCCuPfK97rvKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoe3K/JWGW8P8wUIccApixDleEqvc4KTc4vQ1oWYoFM=;
 b=VcEo5FkMxn6eFMB8xWAdby/Ky6c59kj16nKFcxV4gwfDsyKBnJ7oV9JUJyKEDGYQrpzn24KLETSq3gKB0rn95UnsZoqYIi8RT8I48OxNbRQEY0APL93KGdJW3K67oGTJ/UnBqUtU/SPEgWkHOLBNLAfEpk5iQ/K714uqv81GHaDAnLTgEq4CcHuGLbvQXvX01pGVAjWI1rdCbugG+6zJStIljYhl7sV4bHFcpA+QtblIWyf8tx3gEN3LE8+sMfPXBOqBH2btjn1bnvueNS0Jgv/UKfSsoMM0xVKTl79/aLscyZKTTx1sxQZI5Arld1H46p1SA/ZeEDMBb3SHMYRk1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoe3K/JWGW8P8wUIccApixDleEqvc4KTc4vQ1oWYoFM=;
 b=16pcnqHFz2/b3AeYS78YbG0o8tPA7jl+0ukfpbykOAWJuzS/VjP9kaUDhwlssXfYVm2Q+tvUBuNEyk9obxNhPBntCuNLAgDL02pUqI+A4f5gjjBIsItQOxmGWPH9JMy5VrGKiB9dK0oeg+ENb8eRnMqHtFqRKUqqoUEExOCNhsM=
Received: from DM6PR13CA0010.namprd13.prod.outlook.com (2603:10b6:5:bc::23) by
 SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Fri, 19 Jul
 2024 16:13:19 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::3e) by DM6PR13CA0010.outlook.office365.com
 (2603:10b6:5:bc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18 via Frontend
 Transport; Fri, 19 Jul 2024 16:13:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 16:13:19 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 11:13:16 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Implement bounds check for stream encoder
 creation in DCN401
Date: Fri, 19 Jul 2024 21:42:58 +0530
Message-ID: <20240719161258.2415880-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SN7PR12MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb12cb6-4400-4d7f-003f-08dca80db483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6bq6wK/tRDkAK0Uq+47kq0Qgi73d+OKYzr5w6v6qveg4bvfQoVtCvS+D+xcl?=
 =?us-ascii?Q?1Wardkfapa1T4u1w4A+gAdJPChmiLi9nQhifTJCXTj8CkFPk9sE2okeIa65e?=
 =?us-ascii?Q?YeK/tDjKL8mDeq43cG/aHMo2wlgB8+ma5PtR8GIMu8xtmuxOERvKW4DaIThC?=
 =?us-ascii?Q?iZpCVpUi0+Ztq2xX6NSnFeZiOcg93VnV/nDNhzjuaxWwdvKNoy+siIEVKYAU?=
 =?us-ascii?Q?b4IKBi6DAK8fNlkKARVuH1Qaw6/vwqIdzghGJo7bsqzfpFZNL1xWmRprBuHc?=
 =?us-ascii?Q?kVtTVJf4kIKvYEhnVyskKyX0KSFlpk0bhLHqp77jx7e3H59sdX88cGLacS+y?=
 =?us-ascii?Q?BCx80J+4BmeMjDtcnuJhqzXmLicNV2VLZJwu0VX4P3AiqH5ufgPVb6IGZeEO?=
 =?us-ascii?Q?W8YrzHYoygk3b/qB+jAgBMUkhM+h37kPPWt6WQzJ9XONgDioofsDu/QWP9bM?=
 =?us-ascii?Q?tOJ/COgh1NjBGors96FhBQvceX/Mnus5iXVeFrpllRXJOCz/hvF0k6/AEO2a?=
 =?us-ascii?Q?DS+Cnh8xW+Cl+5nqJZ7NR9qmtE/u6jdtL4o3TzxfhrNhmhnRFZZKT6DvsNqs?=
 =?us-ascii?Q?1dzLjwZLLHMbRonmM7NrsvrJQbAq0rDnPehwga+iSmBBnLuyf5UlrPuhR9aW?=
 =?us-ascii?Q?E9xdv+KHVs1SJFpCz2cnomFGhXsh6tdENIHg/Y90l0uKRYjr1kE0JUSyFJGK?=
 =?us-ascii?Q?t844drgtyaKyB55cHh+d5QKViLJz+qr2V7NfqcBviB7bFeEiCKSPulu2Q00Y?=
 =?us-ascii?Q?Sb9VoY5NkO9zC+i24ja6C6fFBSYhc2ueaP1T202m5FPe5Ueowym382yT8o1Z?=
 =?us-ascii?Q?tAULmMLVk0AxMmNz8+5BeTCYpp0QuS9+bUbAaMDfzXcczES6XrHVA8Izf9Gr?=
 =?us-ascii?Q?vAsNry/Eiel/82xbx0UrWd6ctfzfq2UWQDV9BQbs6Y/KE1VMyZOIr24s1MsF?=
 =?us-ascii?Q?StbUPRR/vs9K9oCbrs25kQm/udIhnmtQq23BjHNobT8XPFIZmB3MWQup+VaB?=
 =?us-ascii?Q?WGvEx8RzduIO2QlUUEoVBm+pTupsz7znZfSMggaFXKORnfLJ/IF8rSAHOMn4?=
 =?us-ascii?Q?gQzGMCFU0C7W8rFQk/sIx8c9BnY/io3WbE6cDKUG7Gv1cduloylQ//46IX00?=
 =?us-ascii?Q?hLeTiXzlZ7Z/t8c+xGMyvSuXztUEuz7Ef3CobhVOLIeHV38bkCBBS1FPSX6F?=
 =?us-ascii?Q?CCnKflaNS6iLLtOaVgr6MOELCoQfhbE9W9lhgm0IGHuH2qr77Bg9vso/pSHI?=
 =?us-ascii?Q?rVIDWs9djhbhAR9AnzCWeRXOq55KV0fWUL7cX5P7ahLm2Wm8vydclx3D+UWV?=
 =?us-ascii?Q?n34awDqujcLEVFDsHE+Vh5mz78jUZeLbwDlAhy29GNo/ejbrNTp+A6zcGnC+?=
 =?us-ascii?Q?iSKPy2FEju/dQrIPL/GCbLflfhTl0l6TOghEFcUDY4/Z1rNu04lSMxfQcNO2?=
 =?us-ascii?Q?Nia/nxB1G3tAmG8dlTkfB0qo+71qbJEW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 16:13:19.5199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb12cb6-4400-4d7f-003f-08dca80db483
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936
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

'stream_enc_regs' array is an array of dcn10_stream_enc_registers
structures. The array is initialized with four elements, corresponding
to the four calls to stream_enc_regs() in the array initializer. This
means that valid indices for this array are 0, 1, 2, and 3.

The error message 'stream_enc_regs' 4 <= 5 below, is indicating that
there is an attempt to access this array with an index of 5, which is
out of bounds. This could lead to undefined behavior

Here, eng_id is used as an index to access the stream_enc_regs array. If
eng_id is 5, this would result in an out-of-bounds access on the
stream_enc_regs array.

Thus fixing Buffer overflow error in dcn401_stream_encoder_create

Found by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn401/dcn401_resource.c:1209 dcn401_stream_encoder_create() error: buffer overflow 'stream_enc_regs' 4 <= 5

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index d3808c49d298..5ee20753572e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1190,7 +1190,7 @@ static struct stream_encoder *dcn401_stream_encoder_create(
 	vpg = dcn401_vpg_create(ctx, vpg_inst);
 	afmt = dcn401_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt) {
+	if (!enc1 || !vpg || !afmt || eng_id >= ARRAY_SIZE(stream_enc_regs)) {
 		kfree(enc1);
 		kfree(vpg);
 		kfree(afmt);
-- 
2.34.1

