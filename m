Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6028FECE564
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 05:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D22C510E634;
	Tue, 10 Sep 2024 05:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nVNPGIO8";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4174D10E634
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 05:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCvMW7zui3nfyfE0O5affQP0sCjjNEAGrAUws2Xo3aI1xmbKQA5e7d1Tm9kV4D8lt4xA5vZ2M7Kvv7s/7U2Irg3QMNDYhd3AyzK0Q4Ze+m/Tu9hwmvLDQ05FyR5Ke7hj8ZggufwJbCSrjdzHLTHgQG7qr1aG1AL3p/Gq3mahYrpuoC/+xrEyejRN5QpyqHc0VjBRyhjV2hHOZ+X60hGQGtiyJPMtgDKuc9bzoZBDylBuOi2LTPgwGDoKd2KLcpR4c/AdOJ4dAm6bRahi/rOAlziElaZqD1OneX/nRm8usNxBBR6Fd68d3RJugjDcowBW76tiW+m50AJ+VQOXiFPRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsIOTrwm6mORFUG8/2L6LRUN9djNO18oSVJ4LUV5P+Y=;
 b=AZQkKv2YUBipdx08HmTyJ/7y0hy6FyGtcwVFuVvNMNOw8oeoMHZAu2rM53/dWnEvbCYo+BX4NvAD1OjEVk3MHfhz49PUHcvS32NpSlLzOvgCi7wbn6lAZl52KGDUjSP1VspiUPQaIzY+Chvnvzb3h5UuXLKaz8FcjgmewIkUKIIvnagQ61poxqVMDrQyNBHXgsVjTcutfs1llUTgTa4ZuVkA/r0dgbgmyl4qwPYpJULn1uJtBJPWKkb5vRcABrpIyzszq8BFae9+M+mkli3OupITZusZRfm1sAyl/0L9RWbWuwo2ZYrZoQ7BGAc4C78DzwSivz1QbhaY8bkZRXeJHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsIOTrwm6mORFUG8/2L6LRUN9djNO18oSVJ4LUV5P+Y=;
 b=nVNPGIO8CO35fygWxw8blMwpUgu7EgXhq149VBRk0CMBbW7YsjkB/M8NBSB8t8ELTD2VIgsEHoTvPRbt9cRaStj55XVEHnOLKW2idWirfRwpjq2L9l61NrUmIYdrLEKS49GyBphpTHYDiKA6aYHwFl6ln1g9287RQT6stlbxfPU=
Received: from BN9P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::6)
 by IA1PR12MB8310.namprd12.prod.outlook.com (2603:10b6:208:3ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 05:15:07 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:10b:cafe::38) by BN9P223CA0001.outlook.office365.com
 (2603:10b6:408:10b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 05:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7982.0 via Frontend Transport; Tue, 10 Sep 2024 05:15:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 00:15:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 00:15:05 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 10 Sep 2024 00:15:04 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Leo.Liu@amd.com>, <Haijun.Chang@amd.com>, <Lijo.Lazar@amd.com>,
 <Victor.Zhao@amd.com>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: Retire un-used write in JPEG v4.0.3
Date: Tue, 10 Sep 2024 13:15:03 +0800
Message-ID: <20240910051503.788992-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jane.Jian@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|IA1PR12MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: 887874a4-d344-4343-8907-08dcd15788d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ex9xVkyimUEzGq9u+NPS27byj94I32pW0tu/7sTFAAIMp5kdyza99s0MYB+j?=
 =?us-ascii?Q?sXuN3xb/vNhxDTFBNs69BJ8owpMcQ48Jc6Gji2o5G84u0tJ4XrOPh77mpSdd?=
 =?us-ascii?Q?URJU4pc8y4NzxEHif0bEaj7dmNAaTich172BXOSALk5BY5ZQdgf5x+2Ytcwe?=
 =?us-ascii?Q?M9DPf0ZTYOC5DZqPAC9g9K7foJV0mhVxeuqZaDKMNtCqoi67h5LVYX1iJN4D?=
 =?us-ascii?Q?Fkhh0pgbjx683lOShCvSQ65iiQXcvA7yQ8bPtGh/+MfBQ5yS9kfjES2kdPvO?=
 =?us-ascii?Q?USxceZIL9YAzvkZHa8ChRu0nHWnBBZnDlNJxJC1jAl65l50VZLCk/sJJGA2C?=
 =?us-ascii?Q?arEgNU9Hgf/1RxSVmFVUFdfol74iPXPE6NvZvqTJAKqAWUwxXITaS2spHIl3?=
 =?us-ascii?Q?lWOmD5zzlv/yg5EIrK7Sz5r2+aNvHeDMk319P60c0onL94gc28DBtN7/l2r/?=
 =?us-ascii?Q?y1uAcK0uE1IesUjjWgZnt1gRwTgUtoEy+FQxamnn6/hmhr6jfQU0Vr5+15du?=
 =?us-ascii?Q?lwoHjjMT8gWA6pOhd5vCK71ion2jGTRDD0mtS0vMhUwDjd+Q/vDsn4CsIeOn?=
 =?us-ascii?Q?UqJdmjILlavwUQac959TW7qEDUG1IC85C38NPrJ49BHoabf6TSlrEklwB450?=
 =?us-ascii?Q?cIY6+d6Jq5o+l+6sXCRhPqeNEQAOs1doP5yvnHhwbJvPXHIhEdKOzIfgxGp7?=
 =?us-ascii?Q?MnwL1rTc9ly6o7j6eb3G4qo+OaXs1ruW8zu4i7/Qa4l07xstIhtFjrh1I1DO?=
 =?us-ascii?Q?sXZlIXPuZf0wxTDgCkncVKmbBRr4o/ljSAO0uYWNxpCU2aXOkJYcQQOk8NxB?=
 =?us-ascii?Q?IoNAiza8ZhtJi6lhJPCWOIxW/lMN+hA1hgpoeqgoMsRWwf45cFMmX8rFrgzf?=
 =?us-ascii?Q?gFDt8OGZNOA+vbe0X/RuSAesQo3jK/FcbgOfxPipfOjSC29mGlQjeuPuwI3Z?=
 =?us-ascii?Q?UT6Yj8recc5oebzxcalnJQXnnKLMlSOuMSMU5Rfu7GRs4/C9wg62OV0q5rus?=
 =?us-ascii?Q?D1uZL1QzTpaclHFMMTIRYulPoFHBzyN24r8yBhimf8cEomXn/nRhxO1cuprz?=
 =?us-ascii?Q?yD8c0+O878EMw7rwouU6MJ6imrt9nx+iNr7mXv0SR8IDk2Ar6MoZJ+cS0P+x?=
 =?us-ascii?Q?qAvRCmVuHi6E4/BEFIaYuIf796gSHb/kaJ+EwjELdjX3KSkMJSijn2z+KLnt?=
 =?us-ascii?Q?ebTujJ+SD1g+YuRmzQceUdxToyGYWqzq57wjW088MDEOq4Bg0kzwmAX0gYD4?=
 =?us-ascii?Q?rNLT4fiZqcyeqHPGVSENmNOzP1e6PKO/rRXiuT1xsRncJEYL0G+MHg7qrYDz?=
 =?us-ascii?Q?JLd69fVwLOLN+EHLF/Eu7fsq7JHJs1j4lLcvR2sYVjuSX4gYw9iiB00+lQ3S?=
 =?us-ascii?Q?npRhCQWkUZWWDX2wKqOtnLH1/0qt93iwRYocsWyF+sseuMAsL96lKVRUhZmo?=
 =?us-ascii?Q?cOHKT872Y9k6ek6QiP7TgbCd5CctNMwS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 05:15:06.7394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 887874a4-d344-4343-8907-08dcd15788d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310
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

write OP of HDP_DEBUG1(0x3fbc) is no longer functional, so remove it.

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 86958cb2c2ab..eafd8bcf2870 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -743,14 +743,6 @@ void jpeg_v4_0_3_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq
 	amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
 	amdgpu_ring_write(ring, 0);
 
-	amdgpu_ring_write(ring,	PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
-		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, 0x3fbc);
-
-	amdgpu_ring_write(ring, PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
-		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, 0x1);
-
 	amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
 	amdgpu_ring_write(ring, 0);
 
@@ -1088,7 +1080,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
 		8 + /* jpeg_v4_0_3_dec_ring_emit_vm_flush */
-		22 + 22 + /* jpeg_v4_0_3_dec_ring_emit_fence x2 vm fence */
+		18 + 18 + /* jpeg_v4_0_3_dec_ring_emit_fence x2 vm fence */
 		8 + 16,
 	.emit_ib_size = 22, /* jpeg_v4_0_3_dec_ring_emit_ib */
 	.emit_ib = jpeg_v4_0_3_dec_ring_emit_ib,
-- 
2.34.1

