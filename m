Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767F2C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF6F20715
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zN6mJwsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF6F20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E3256E312;
	Mon,  6 Jul 2020 05:05:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 937CA6E312
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 05:05:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDmhMU6HOTEF5LW6wuG0O+FczRsYobEV3fqQOsGSx0DW239Dkf4nO7Lbh7TKUO3aI0nncHHJgujrbiKoiROePltrqT1J+RTj9OO8wjpneS9n7KqdWDyauDoAIsThLhOxRakfWJLfcxSL7JedgyVZ49hCFi34BoFPq6iWz9oiDjiK1R7xgOqp9i4xZrsWIu3jleC6fhTLBgppOU+1KC+GEL9FZssZnsXn25LSTxWXkmbs/uj2otIBzIWgveVcp7jyKsAIynVl44qtqbI7Rt/ZwWs9DqYJFqiXTtoaFk/N87z3Go8tkl7GWQeazAB+dFV0FU+L8BczuRLogAtOKB1J2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrrDuclc7HDYILtiC3gAE1mCz68AcYe/oF4hoQFQnK4=;
 b=hhoG3qZgnPVr0/0Ubb/+ievbGo1Fe+yo7HlkpMinP2vE4LZ3WPMDrz/xwtyATKreyMQWFLx/HnyvQNjwkh6LQABy42rwRv+vwb8ibSqalyt7PGwoZX9rxKmKwAFeS+B9V1B8gVAWBRM+uItmBhqySO+dso2MoUB6tlAFewHSzl62e+O3tdC9GrmBpqTz47lVmYpQSkKb9DYis77+Mq9QuSwzGZWkttBZrnHh8y7mB2yfMYOcoz2+2TWg8ngzqbaa6kTM1MDtsUWUmLduSd5toVURa0hV+NllpmOto5wPUl1X67p/FzxpHSCGg8pxd2O2KfpDkD+8WQarly0fGqtRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrrDuclc7HDYILtiC3gAE1mCz68AcYe/oF4hoQFQnK4=;
 b=zN6mJwscZtYUVNmuPjMQ8CsnYdfi7ySmxtdT65wj5F2fKm4zcX1MLc9Tm9xFCs1XODr3cijDLGpfeABw0liZfl1HOM7bTit8BFJRNTzEHTCxCZzut8RQPx9jhvSM8triqft7FsmQk7UrSSPCkN0peKrztzlms9KYe6IUWSxtNCU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 05:05:53 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 05:05:53 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/12] drm/amdgpu: use register distance member instead of
 hardcode in VCN2/JEPG2
Date: Mon,  6 Jul 2020 13:05:03 +0800
Message-Id: <20200706050509.714975-7-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706050509.714975-1-ray.huang@amd.com>
References: <20200706050509.714975-1-ray.huang@amd.com>
X-ClientProxiedBy: HK2PR0302CA0017.apcprd03.prod.outlook.com
 (2603:1096:202::27) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR0302CA0017.apcprd03.prod.outlook.com (2603:1096:202::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.13 via Frontend Transport; Mon, 6 Jul 2020 05:05:50 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a9d8c8f-ab34-48d7-e420-08d8216a423c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44701082F32910023C17F032EC690@MN2PR12MB4470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXwcCFbJv+3/gAkq/lkS43KwIb/+gtfTDpQZ2E2zvDc3/qgehXsaIF84OQ0Va9LcK3BVGsKDBicDdqREiVJOAWbX0TIIUqAebqJ+CkcsNfjN9rKk8HvSgSHyJJByS9bABP/Zv2UnGlDaT+F+lyEUfmCUHBx291rrr+yDgnQNsiazxD/vQBD2kMvm3WRbdLijyqX21COEBXqhpGhzNlcWY425M1Z7sYe/m/qHbhKFDYpmEaaj+e7992AGcaM1Xv/e8vR4pctUuTxv/9P/EqS3g68qtUt0VOeJBjpJ4zarDTQ2TsgOiK3aF5hx3kyicvD7nxXAS0Ip2QkxbC8CKP7TWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(6666004)(26005)(54906003)(66476007)(7696005)(52116002)(8936002)(66556008)(66946007)(36756003)(478600001)(5660300002)(86362001)(6916009)(2616005)(186003)(6486002)(2906002)(316002)(1076003)(8676002)(16526019)(956004)(4326008)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: lrgd37OAB6DzSzIlIdWDB/u3K4VT7rFg1nc10LkTQlFkQsF9q5BPWoGkfhzZXh9EwlgbBDonKZpfLIRirj23HEy5xfm70g3ruxeoODp0mQZ4IaURwA12CtGepeGPUL930Pwoh97XYBKOjwTGqNFmteVMmOq9SyhrEbAup13lgsAVrclLRnmAH6LY5N1Q6kmd5w5fLDbsTCPnE+e0N2oqxpGxqn6S/Cx6n+gO+54kK5Hr1VoetHP2586g3EE47jQS8CmaunN4vNeCgzUYcQEOUYcw0fr33DBjhOMb1B3p0U+xgCYgNM0ZnAS9guNVRXeUCjly4vrfvBWMKLO/94+NxpBT618hyE1pDhuC9VlcDqV2KZNFCZhtx1b/p5bBGTwOJFf+1vTg1GUvz6A8JLYFxluLoovIzlT5Ptm5GTdr5hc/apNZ4IUcMuYvdd6QcCBrPTzNoYDoUHhvoFNtJVoATb/RRj937ifUHR95Gv62GwVxSCDDAuthTva5oKcZoWGU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9d8c8f-ab34-48d7-e420-08d8216a423c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 05:05:53.7110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1P5f5p+X+XwWgMfT/wWiMij5ata5vSh3D4S4AFYhGkI1ohmEcQ+e6WhDP7YUbJ9LJ12mkWf+4MioFlhqZUzHkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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
Cc: AnZhong Huang <anzhong.huang@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 Huang Rui <ray.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Leo Liu <leo.liu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch updates to use register distance member instead of hardcode
in VCN2/JEPG2. They are for the same ASIC.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Tested-by: AnZhong Huang <anzhong.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c  | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index c5f49129a300..94caf5204c8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -629,7 +629,7 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
 	/* wait for register write */
-	data0 = hub->ctx0_ptb_addr_lo32 + vmid * 2;
+	data0 = hub->ctx0_ptb_addr_lo32 + vmid * hub->ctx_addr_distance;
 	data1 = lower_32_bits(pd_addr);
 	mask = 0xffffffff;
 	jpeg_v2_0_dec_ring_emit_reg_wait(ring, data0, data1, mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index c0e4133a6dd5..23a9eb5b2c8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1505,7 +1505,7 @@ void vcn_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
 	/* wait for register write */
-	data0 = hub->ctx0_ptb_addr_lo32 + vmid * 2;
+	data0 = hub->ctx0_ptb_addr_lo32 + vmid * hub->ctx_addr_distance;
 	data1 = lower_32_bits(pd_addr);
 	mask = 0xffffffff;
 	vcn_v2_0_dec_ring_emit_reg_wait(ring, data0, data1, mask);
@@ -1660,7 +1660,8 @@ void vcn_v2_0_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
 	/* wait for reg writes */
-	vcn_v2_0_enc_ring_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 + vmid * 2,
+	vcn_v2_0_enc_ring_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 +
+					vmid * hub->ctx_addr_distance,
 					lower_32_bits(pd_addr), 0xffffffff);
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
