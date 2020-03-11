Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED40C0044D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 20:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B552720749
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 20:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U14SCelr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B552720749
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26E0C89276;
	Wed, 11 Mar 2020 20:49:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0CDB6E4DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 20:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kI3n49QJwreQUOEDpcwIzvQRHl82e20eHjImBQL8vL1up48Vs4siPtzyqILJjLbzAPna0mxoW/sF1iUn0cqMUVgedcWFnEKRwlYYJBvv3KoZ3Hrl9AXrmE4XPa8cInesI9zKAU3LZ3ugqYOBQIG+8SECHqk4Yvqdmk8j9d5CMV0C/q+c2pRhuGdwSNH5zJUt+vUwwoBFFhoOb3yudJ9gv/+t5Vm88posJLiUuk7U3mOaoknmRrNYO3l2gJHadslAFx8tGpQAxoZdxsYzOAytCPCW1bd/JQpxkMcZ0vdJgneTKaWBTkKDuBNsFUQmzTP94+KXhiUZ7dRaZ6ZcB+rM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vbnJG9+aSY0ZsnG8N6Q7DFVUobt0waYhgHxXsPLHVw=;
 b=f+JhWafRxBeyNx2e+ACJwe0FeV/gXCZDHn7GJyI8CoJHUta9rAlv6GARHguSL1OCojHCFY1aNb3AfiST2n3MEgibMmMT9dh29VEMrtHDM5En66aoKxipFG2I9AXfkTT29I5Y9g4Yp8gppYvKdJFu8CZ3wX9zzuv4hWZgS4aXZJROUuzJzivbVhylK6lXercAynsnJNewEwTD3CHSOjMoCtVnY9wdrahuglE0fG9HTPrTL+4LaU2BMfPGPyd7EDKH167WMVTLCqBLYx8PivF5xQiaPyiRhWmvgwvIxJ/TffXZ3STbwUqZrOFhDcrl3YL3cKMAqMx0pUPa7iNo6nwZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vbnJG9+aSY0ZsnG8N6Q7DFVUobt0waYhgHxXsPLHVw=;
 b=U14SCelrnkdPPBvGxwJzKea7/gdIq1LqRAbcJockxWT/WRhEqhFbnmOI2VwfA3MjCV40s72TUoNqKvGQ6tD3e6IXQNakfrJUF7R3rvALJ0PIN++M1ZocuZS5ceQiooXjm4sOt5Z+OLkkaehCRBNMx9a+IF4/H5dwYuQqW7KUwzI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3079.namprd12.prod.outlook.com (2603:10b6:a03:a9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 20:49:45 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 20:49:45 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v5 2/4] drm/amdgpu/vcn: fix race condition issue for dpg
 unpause mode switch
Date: Wed, 11 Mar 2020 16:49:32 -0400
Message-Id: <1583959774-16570-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583959774-16570-1-git-send-email-James.Zhu@amd.com>
References: <1583959774-16570-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTBPR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::33) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTBPR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 20:49:44 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d5ce2fa-0369-419b-ccbe-08d7c5fdbac2
X-MS-TrafficTypeDiagnostic: BYAPR12MB3079:|BYAPR12MB3079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB30791EAA89F276681F029146E4FC0@BYAPR12MB3079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(199004)(66946007)(26005)(66476007)(4326008)(2906002)(66556008)(6666004)(5660300002)(7696005)(52116002)(6916009)(316002)(81166006)(8676002)(478600001)(6486002)(8936002)(81156014)(86362001)(956004)(186003)(2616005)(36756003)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3079;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0wmU0CN3Xx3EhwRl1/XPKJ+YTQGsZQ8bB58B1QUaUNjuQnpDhQppGHMFcrgjEwNsYbpvvAeQkkGyNmUr/L/16rsIGaaG4l0DVw8s/luFTo5yto80n+v8XaLm+SpGWw+Ag8i3QH+OkY49tL9ZEQgB/uqZc0NNpnKalrQfnrcPMNObK5G7AESYRqWZaoOSiO23HcFjfasb+1SzjaRUU0xSadOPyL//aMfBRW6dg4ZxW9fGRlTsDZNakeXo6lhCreXQm3j4WdwJLBdqhRCCkF3xE3idhNvCQd/aRfcKHJ3H2DsSEkIvQnZPPCbQLR0o32AoUlGPDcE83espO7FUQc084PvDiV9nuFxH8qnRXbKlF3Fhq82vJpZSn9ZkVzrhFCavCFE3/HUYodSWXjkjSYPmQJTKhiGRZRw18oefxer67Y6r3lZkztMOMMLgXeipO8tR
X-MS-Exchange-AntiSpam-MessageData: vwngryWR3F9qplFCuaRBPndKhJorhHBlGqM3kYn9JG0NSIrH+pyyO+aj9TiZ79GJLvp+XQ2vOu2iuWlk2KLGOHi7aMHw3uAS/inO+1fMekGnQjavhphPTpAfRfrL8gTmb1XQxtQvjXSCkEi7pviH0g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5ce2fa-0369-419b-ccbe-08d7c5fdbac2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 20:49:45.0468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XyQLcV2C6FCHhzu+Fh4TIuMRnXTIuJdTUBBEQ3LbEokxqD/r9INPZ3BE/jKBUeX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3079
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

Couldn't only rely on enc fence to decide switching to dpg unpaude mode.
Since a enc thread may not schedule a fence in time during multiple
threads running situation.

v3: 1. Rename enc_submission_cnt to dpg_enc_submission_cnt
    2. Add dpg_enc_submission_cnt check in idle_work_handler

v4:  Remove extra counter check, and reduce counter before idle
    work schedule

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 32 +++++++++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 6dacf78..0110610 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -65,6 +65,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
 	mutex_init(&adev->vcn.vcn_pg_lock);
 	atomic_set(&adev->vcn.total_submission_cnt, 0);
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
 
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
@@ -298,7 +300,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
 			struct dpg_pause_state new_state;
 
-			if (fence[j])
+			if (fence[j] ||
+				unlikely(atomic_read(&adev->vcn.inst[j].dpg_enc_submission_cnt)))
 				new_state.fw_based = VCN_DPG_STATE__PAUSE;
 			else
 				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
@@ -333,19 +336,22 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
 		struct dpg_pause_state new_state;
-		unsigned int fences = 0;
-		unsigned int i;
 
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
-			fences += amdgpu_fence_count_emitted(&adev->vcn.inst[ring->me].ring_enc[i]);
-		}
-		if (fences)
+		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
+			atomic_inc(&adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
 			new_state.fw_based = VCN_DPG_STATE__PAUSE;
-		else
-			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+		} else {
+			unsigned int fences = 0;
+			unsigned int i;
 
-		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
-			new_state.fw_based = VCN_DPG_STATE__PAUSE;
+			for (i = 0; i < adev->vcn.num_enc_rings; ++i)
+				fences += amdgpu_fence_count_emitted(&adev->vcn.inst[ring->me].ring_enc[i]);
+
+			if (fences || atomic_read(&adev->vcn.inst[ring->me].dpg_enc_submission_cnt))
+				new_state.fw_based = VCN_DPG_STATE__PAUSE;
+			else
+				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+		}
 
 		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
 	}
@@ -354,6 +360,10 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 {
+	if (ring->adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+		ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
+		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
+
 	atomic_dec(&ring->adev->vcn.total_submission_cnt);
 
 	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 111c4cc..e913de8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -183,6 +183,7 @@ struct amdgpu_vcn_inst {
 	void			*dpg_sram_cpu_addr;
 	uint64_t		dpg_sram_gpu_addr;
 	uint32_t		*dpg_sram_curr_addr;
+	atomic_t		dpg_enc_submission_cnt;
 };
 
 struct amdgpu_vcn {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
