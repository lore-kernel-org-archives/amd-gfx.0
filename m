Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78E2C352A4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 18:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B272082F
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 18:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="akN2oXfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B272082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 384246ED06;
	Mon, 10 Feb 2020 18:07:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 313D86E9D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 18:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ET7VwMzC5piCIupP/AeuNnHkA8k34pVtZR9lwViPEWqlboSl6XTreSkjSt1aitdyHG/ql054tN6VuCb2BA+VxblavUpMpjI8BNVN+wOfjUodTGgA8+unPPH74v6YYdx4rqjuMEPrlm5HpnXr3FnDpCH2mPq1daVzxNvyf0QUqkSI4sMNY+RnxjPt2QmtsdEqzLiF5Qqxl3jvwI8DvHCd942TmFroxFfYMhu5kBPFHoTWKbo30U42JE87jUA2Tf7YMtAZvqJHvse1F6wqeoqLGVe+rcG5IO2HknCc2Sb+64jStSgsVs9+j44QrO34f3FwonNtHhsl/LWSmUkCScDdNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iotzGr5rLvNCRHlmgIqBxOfynZ5I9d0BKbz1cnwABIo=;
 b=hY0oAs4lZ7rxe4UmRzpU8jzOw0IdT6k03qFR7zyLnX6CjkJf6HsiILB2N/xBPyzGji+TOJrYCNk0eOL2t1NYhcBLLKw1sdckMXm7osfrwyMYkIo24w4kJiFqsL2WoR3mAEpvofPPLKEvzUROagtn76eALcGFiRce1kr8GUODyKZMTtsOgTrZulNT6WlJPs3yfJHD03L5adfIf4EcgtPOuC3nhopRjqXtXuGTBTpw9so4IbIHPGAwGZOJSKFjoL5tM2p6re1Ml78g9VYrtR8+SvBOkrMlKTJNizf9aD8B1ZTi5/ulWHCetbMGn0ngtcEsBX5Xe06VrKJRAYENxxdTtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iotzGr5rLvNCRHlmgIqBxOfynZ5I9d0BKbz1cnwABIo=;
 b=akN2oXfUiM/0TH7nqK5bjBAYhPBacT8Fu+J7H4tk6ql7ehJB+ik+AM9k1ljyqJHb8KpHSV5ByQgp45SZ0qeI6555Z1sZXUX3nEger5YDPOLO4CF2+cuiPjtGUONCzSHsw6xoveccob8Fr+rUkAR9iyJQn9diAXCpPH+GMWr7YRY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3477.namprd12.prod.outlook.com (20.178.196.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Mon, 10 Feb 2020 18:07:04 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 18:07:04 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/vcn: fix race condition issue for dpg unpause
 mode switch
Date: Mon, 10 Feb 2020 13:06:56 -0500
Message-Id: <1581358016-8986-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581358016-8986-1-git-send-email-James.Zhu@amd.com>
References: <1581358016-8986-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::16) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2707.21 via Frontend
 Transport; Mon, 10 Feb 2020 18:07:03 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97a120a2-4923-47c7-1a98-08d7ae540885
X-MS-TrafficTypeDiagnostic: BYAPR12MB3477:|BYAPR12MB3477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB347781FABED86E0733C98D4FE4190@BYAPR12MB3477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(199004)(189003)(7696005)(186003)(2906002)(2616005)(956004)(16526019)(316002)(8936002)(8676002)(81166006)(81156014)(478600001)(52116002)(6486002)(6666004)(36756003)(5660300002)(4326008)(26005)(66476007)(66946007)(6916009)(66556008)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3477;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SOR4D8ZiHPVJ/FkkSLL72slcC9Tt273JdNLcded80S7/eGOoSbO/QFQ8Rc5BGT5VX64ItTvRdNAIbXc8pL179j9iVpdz2KVXunJz8WsZKXevvJ56LrXMygCauubcgdQUqQnaXQazznJNH2vqQ6V3jY33lvZcsf1kQSVqADe4tlA1Spd/XhYO/OY8jFLZEUegoJyoSKDc5bVl03z2ZClNJxmpzhApI2oYFp9OtU12Bv4FFqVI5yw9A8sVDNBm/SJGSu/aO/zWm1Rxzg32cfzyX8D9ndiz8OHCwAxxXdpo/WLKTadVyDNQUn6rQxB/M3y5X2tACt56dgNWAndwLtX+M01AcGCntNRqXUTWUONO8iqFOFafppnj2H7qwC0wC+7o+BcYPUjhW+BerBcSNg3s425U3MwAq1IiOL6fjirHEDzfnp2tmfMNYYXNVXUDQSO/
X-MS-Exchange-AntiSpam-MessageData: DixvVRpO9m7wU9jfOUs6pBbOM3JQxehtDkN263TYe/rkbKsFpTeWo70wOWeDNTNqIEnhwPip6K2lb6IlswX4p1UMVJjAtYXd6CA+W+yXPtdZa/DeEYlUvrF+nUDbIysVLxe0rR2sKDFDmrow5Ybcxg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a120a2-4923-47c7-1a98-08d7ae540885
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 18:07:04.2789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBrrgVUkdcxR4xq1UalpVfO3Vv/0zAcJWgmehL233f71gxMv/SM2Ks4XNZa7CnQj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3477
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

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index aa7663f..28ef11c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -64,6 +64,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 
 	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
 	mutex_init(&adev->vcn.vcn_pg_lock);
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		atomic_set(&adev->vcn.inst[i].enc_submission_cnt, 0);
 
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
@@ -338,14 +340,15 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
 			fences += amdgpu_fence_count_emitted(&adev->vcn.inst[ring->me].ring_enc[i]);
 		}
-		if (fences)
+		if (fences || atomic_read(&adev->vcn.inst[ring->me].enc_submission_cnt))
 			new_state.fw_based = VCN_DPG_STATE__PAUSE;
 		else
 			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
+		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
+			atomic_inc(&adev->vcn.inst[ring->me].enc_submission_cnt);
 			new_state.fw_based = VCN_DPG_STATE__PAUSE;
-
+		}
 		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
 	}
 	mutex_unlock(&adev->vcn.vcn_pg_lock);
@@ -354,6 +357,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 {
 	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
+	if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC &&
+		atomic_dec_return(&ring->adev->vcn.inst[ring->me].enc_submission_cnt) < 0)
+		atomic_set(&ring->adev->vcn.inst[ring->me].enc_submission_cnt, 0);
 }
 
 int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 2ae110d..4ca76c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -183,6 +183,7 @@ struct amdgpu_vcn_inst {
 	void			*dpg_sram_cpu_addr;
 	uint64_t		dpg_sram_gpu_addr;
 	uint32_t		*dpg_sram_curr_addr;
+	atomic_t		enc_submission_cnt;
 };
 
 struct amdgpu_vcn {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
