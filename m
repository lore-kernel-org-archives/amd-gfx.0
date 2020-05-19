Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF08C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 14:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B292072C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 14:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VoztT24l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B292072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A566E34B;
	Tue, 19 May 2020 14:41:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 543026E22B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 14:41:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afV2RhqmnlkiM2V+aXgSPMezwt0i4NXeXQXKTkJRn8+O2IX6cz8RjzTsEhOq3Q3Wa2eeumg/pElQ7u8mw8oAZyKM2CBm/YwSE6UJsDodyRsxFZbBPZSwmx3HOjEGOmIwobUKR7JFTmgbJWDL3EuXMyxw5MuQb6rWrXHw8WzNQsgGUwdCTASpuotJN2EQ6slTYFFW2h1yMbWUSdCOaLpneO55YJkwzdT2gR/WbE/0PSe+QfPdmtfplt4TF7L+cdRlqWymz2rVA5KWgiJihIq4S5NH0+SVGeQs2Im58gyHrtTpI/uHI9HLTGOo7n3vIRVVS0o5fqaKO0HNeCCicK+aTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ri2IbcF28o+sFy8dNKkqRsI7FmXFfJzSt6cYjectQU=;
 b=WTL80alUkL39SC/fgPmDK2QgECCql4qfFqOUuMdn9K2FibSIc5mFwGzzDsNul26ojA8yA4JKnWotpbpbmtYM9aYwXefzCfezBvFk+ua4WjLf1dQoWFSZ0jOlVlwB7EL/fHEG8BIurcRd3zzW1n/rpKOekuOd1wEy5S6ARv9jNpu3l7AlD9m1OwnGCg+ufxtPOzGxqJcf6PCkogboqb65RhC1yayM45UllW+lXN3twgG4O6uop0ZYcmxQhwrQDLP2pHl7X9oX/X5PSYx+Uq0idls1P6cDl+OH/++qsoyCUF6eJ8INQFpcQp6Tj76cp51jrPRk8uJe+XhWB3jQbWR3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ri2IbcF28o+sFy8dNKkqRsI7FmXFfJzSt6cYjectQU=;
 b=VoztT24lqakoieRK8MkeQYueaaroKxQl64SDTKSyqPg0xWXR6QGJfNtklYUaFFGngHu/qDyleg9QBupF8vCCQZMp2xSBBi3SQW5ozjp9X8j9oMdn9P+sUuEN1Vv0+stN0qlKu1BZ3kC93A6scjkL3fOjQODZRttBjQ6edLfyf8s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1370.namprd12.prod.outlook.com (2603:10b6:3:76::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.27; Tue, 19 May 2020 14:41:47 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135%5]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 14:41:47 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/vcn2.5: Remove old DPG workaround
Date: Tue, 19 May 2020 10:41:37 -0400
Message-Id: <1589899297-19138-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589899297-19138-1-git-send-email-James.Zhu@amd.com>
References: <1589899297-19138-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YT1PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::36)
 To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3000.24 via Frontend Transport; Tue, 19 May 2020 14:41:46 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0b0bead-9da9-4a10-ff6d-08d7fc02c187
X-MS-TrafficTypeDiagnostic: DM5PR12MB1370:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1370006E5E3D4EEB1F16F900E4B90@DM5PR12MB1370.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYtPL7mdlaws4Z0MzDWp92mN3yDEFOJRhkuBi5q5xfFYCe6w6mSgbDh6gKfvu1UrYUKRnig2sGnuge2m26m0BEM6ZobL5CJeKY33yIB9LBzo6aDK/e4EFoW6YnJVMYzhCZfcXQlDtG0SE6uBbxYmTqikDKvpPCFznoz6bTwuY32TDqoYJru4qwE2oamqn1bv9+JuYAK4fZ1L6jahUATZk1LRPgJixiGrsth5sOftyWjieYK3iU+/Spj7WMwOrrm6y2XeJnFlpBNEsTrO1J1XlywDbtwtUgnIK3nGRoOGWG7cboJMK1NG061dq9NoS0fIzUC3N4GzlP10o7lWJwOqh3VCqnwCp45o3qvrLxlgwEV73oEw74TcVECOFg8xAEn7feNdWum7pb4tUrmnsd/dYZ9qkffbeZyYcpeX/HuQvIdo8VkfS6IRLMx3O7S68WZa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(66556008)(66946007)(478600001)(5660300002)(6486002)(4326008)(316002)(86362001)(8676002)(66476007)(2616005)(8936002)(26005)(36756003)(2906002)(186003)(6916009)(16526019)(956004)(52116002)(6666004)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PvGlXevoFX6tRUuck0pRXE62FCeyz10ydgxTGJ8DjD5SYLSj5nC8TOjB7H+dPQExZra2Xz47a5nYGBRcBkYirGc37yNa3qEElaqdrLSEjO2jCFNxLCbhtxJ08BgqkOHtvPNdquSi0PVdRur2MkoKSYIAc7LShRbgxWRCgd3YuNoxTD7nudY0RibYu3Maq95Z6tbshlZFEwmhYjjX5hWDZoXGl304RIrgwmLvZHfgqTjg5swgEYIDLiY7Fq3kD+S8JhxzbC8taNyQiPA1PTR4CNX4vAnljrw6TFQDgz3l5CODyHFJNxd1mnAVpPQYq3odOnR0h8Y6KHMKTfLXuzyPPMITucsJVJRP5jrni2pLN5KS0rWKwkREx46Rzh/KYGAYt3p7MW8Ab8n/K3t8We4rhFfenz/xJ/Qu2faekBBJBaF1OzQV3rGeH8OhXTcwGuINW6sZmdl8BdqunRmzSftEQTtCKekSQBjlF37RmQ3ybTpXqr4toIdwQjqCVxL/6M9n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b0bead-9da9-4a10-ff6d-08d7fc02c187
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 14:41:46.8081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0gMvPvnzoCTqJ+0XKDh6m92iVQfGBnBqsj8i9+ccNWjsGWD8x8FbtQPLe2+B5Es
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1370
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SCRATCH2 is used to keep decode wptr as a workaround
which fix a hardware DPG decode wptr update bug for
vcn2.5 beforehand.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 34ed906..3c6eafb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1453,11 +1453,6 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
 				fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
 
-				fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
-				WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR,
-					   RREG32_SOC15(VCN, inst_idx, mmUVD_SCRATCH2) & 0x7FFFFFFF);
-				fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
-
 				/* Unstall DPG */
 				WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 					   0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
@@ -1519,10 +1514,6 @@ static void vcn_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		WREG32_SOC15(VCN, ring->me, mmUVD_SCRATCH2,
-			lower_32_bits(ring->wptr) | 0x80000000);
-
 	if (ring->use_doorbell) {
 		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
