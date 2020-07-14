Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF3CC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 02:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A11C20C56
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 02:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f0PPLTa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A11C20C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A401D6E895;
	Tue, 14 Jul 2020 02:46:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF3A6E895
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 02:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2ZCh8/eG4+VeUidQ/nMb5H0NFzGtRk1g375uQXCmILYh4KArZSazAet6wAa0cxuFYyPXzfZftFVSOusu3+bTSHBKYh/KP8OUo9USREfFvltjwPUiUd0314gM21EQ30p/4BVojcaXlM4EmuZFdOWqpJ9S1KzCbGlSsK/CFdPGfZwrF32gOtDj1BbRy/yZK8mfRlh82SAY59wEHXujdPOPTOwTq0CADKQaof84gsmPoOvYVifCAIghgDTSio1tJ8rTSENFWvLlIZr3XfST40421WhRpFSawB3qI1Ady+JmmLN6kjZjmQJRBHHVUbeO8F8K+KDM6JLiSqplhdqUVgf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOwKICD+nvjew44yP1SElzSon0lQlSfk5SRXvg7L7ac=;
 b=AetggZfGs6tULnpTwlvZQYOfI3/ZPA8cBMWPRz4Gy1btwT/KGTK1wEUnIdYy2gY+JgQMMhbls+U8gZ6H9Qbs+eqqwJ8LFEHcBNtyTh64p8IEbWvWA0BK/BiVm+bqnWfwyi44DOKZEgw95H8DYqL4a537SJEjmu0IlNwGpQDlypxMIz+NmoCXAPcl/O+O9UxrLVgaN5jz6np/49ysi/eosqzYKIV1kywRVdcUY6jXaXyiYpyzoehhusH18rrhXfjuTtOifqaMWAEQbiU1uop2gFheYdztKXfgX+jHHW8F/RbAPkXG5brSVnyiI3qWUgyAN0WN6U5l0nYwthkLijlKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOwKICD+nvjew44yP1SElzSon0lQlSfk5SRXvg7L7ac=;
 b=f0PPLTa4B0eiMK4Rfqv/6sFokB3QWxKa9G/ElQqYbF+oOf5aYuYYEJ9SDtYc0VfJ4AiPSm6Rpe/ihOwKfgzozMvxdmxiyR+koZo8RUKX7YvM/nQoy79l/AL++FHBbxxs6r17yVGWPUXYJzOzrqNcS1COb06DWLO7EWYTY/eTuAI=
Received: from DM5PR07CA0095.namprd07.prod.outlook.com (2603:10b6:4:ae::24) by
 MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 02:46:17 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::23) by DM5PR07CA0095.outlook.office365.com
 (2603:10b6:4:ae::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Tue, 14 Jul 2020 02:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 02:46:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 13 Jul
 2020 21:46:16 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 13 Jul
 2020 21:46:15 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 13 Jul 2020 21:46:14 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amd/sriov skip jped ip block and close pgcg flags
Date: Tue, 14 Jul 2020 10:45:57 +0800
Message-ID: <1594694757-7620-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966005)(4326008)(26005)(82740400003)(54906003)(316002)(6666004)(47076004)(186003)(8936002)(336012)(83380400001)(426003)(8676002)(6916009)(356005)(2616005)(86362001)(81166007)(82310400002)(478600001)(70586007)(5660300002)(2906002)(70206006)(7696005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50edda91-f346-411b-97c6-08d827a014bb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4141:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4141E47FC16BFB673AC5677ABB610@MN2PR12MB4141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: seP8L/liPcYdshL3pk/4S7rmI7YDVykaxj6vniIRMDpBs60Ewj9cEp0aY+UNP1kJ7ItosY3GibwPUnwc6s1chSbm4tbEbbZh4h4lSlfSLAFSMg4s74lb/QJYhbLLXlgAA/Yw9BTFIf+Lay91wXFrdw465tYshxh8A7Gx44ebLe6SPTYczpXPOt2AOv5Zjv47WIK4QyE80x6b0p5hcJqU6TUpKNEoe6cu1CVfYwsUGrCtNltHzHqQyC1jyredUDqB68FAc1IolXRNye+M0BPB0zJh/5NO0dcy4oxqPC6JWmabl/wQvWHUeehHPx6WIOTYdS/6gtsqOLNxxiGGemR1fEvjGuBXc4qDGxuetI1k7rjeMspRbb8jukRuVoB2Ap/Il9OOTb2kYaAOeYBQJynTow==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 02:46:16.8174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50edda91-f346-411b-97c6-08d827a014bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141
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
Cc: Jack.Zhang1@amd.com, Leo.Liu@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For SIENNA_CICHLID SRIOV, jpeg and pgcp is not supported.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index a7cfe3ac7cb6..7f34a2f25700 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -504,7 +504,9 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
+		if (!amdgpu_sriov_vf(adev))
+			amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
+
 		if (adev->enable_mes)
 			amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
 		break;
@@ -732,7 +734,13 @@ static int nv_common_early_init(void *handle)
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
-			AMD_PG_SUPPORT_ATHUB;
+			AMD_PG_SUPPORT_ATHUB |
+			AMD_PG_SUPPORT_MMHUB;
+		if (amdgpu_sriov_vf(adev)) {
+			/* hypervisor control CG and PG enablement */
+			adev->cg_flags = 0;
+			adev->pg_flags = 0;
+		}
 		adev->external_rev_id = adev->rev_id + 0x28;
 		break;
 	default:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
