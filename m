Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24845C10F27
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 14:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC14720727
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 14:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DZk/07IZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC14720727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8691E6E200;
	Wed, 11 Mar 2020 14:16:45 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750082.outbound.protection.outlook.com [40.107.75.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E7176E200
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 14:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7YKnQc0VEv0kRsPTxrgnr3ivO/tgTd1FWl4kNYSlwC1IUHk5W2CqOQWdi33cnToNXXW6IB+sIrp0Q64MFSTGOo1B54fLf9WWdJdt/xZA2c7QRAIWcU8UhwB5kDpIsGAQXIxa95V87FxHjRcHuOugg6nTPrioF5IgmtpDGTYgLrYL59TQjR2UX/D/NplZAgrAMAc5cGUjZT0TC6x53gNzWK119JcHB+3ch/OkLSRFfEX+PgozJw5jWPdL1bH6G0+asKE1cURQiTKc3TsycAp4Lh9+03pUxRoMqM7lo8iIFRhR+6W5CZBkPRZ3TcIKJohHLg3qR2JqtcmihHu1MaQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hOo5Vxk/HocgXZRhM9xZ2XQZsIkKU9zr00m+0DKJj4=;
 b=LAuhkQa6F+rQxIZjPwRc5vxHjMgfM6f8lL1D7kmJfl8ENnlkbUMC1UZVRuBev2PAzvJgVRU3HrCTbdABeEYX0JKt+ysPUhpne1FEnkEavHTQ5dWK2ndyc3xxrFBC6lGZ65C6JpMUYeZmX+SSQlUek9mTa7eYavjpb7G4LJFlcAh1dEHi0AyFpL8Lbr9zkfEL3pIjTQis7D8G5dwl49F8ZTmZ4FCPf2oAxvfISEvGXNNoFd2ppMHpiQQq7uewb8MTDB4vJRiXdz1BIg5Y6bnWaehJ1yocMMmCVFT+L+BGxgLYx25Apqoit33HBisrwyXJSSBtfjiCw6kKEd6I7gk+Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hOo5Vxk/HocgXZRhM9xZ2XQZsIkKU9zr00m+0DKJj4=;
 b=DZk/07IZqQPeCyMYvAey/VzGw+yicN3OcaaTaVgAuuCi77hgm3inD0GfcymO4t106FlJedq+N//QgLIwq+jGcUyn806HsHdHrubtCjUObuho68VWYi28RtFaE9CBWyKU3FL21NbEunsUZxYhxZFMhvZ27nMU2gOlS/0WtHhtLQo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3590.namprd12.prod.outlook.com (2603:10b6:a03:ae::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Wed, 11 Mar
 2020 14:16:43 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 14:16:43 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 2/4] drm/amdgpu/vcn: fix race condition issue for dpg
 unpause mode switch
Date: Wed, 11 Mar 2020 10:16:36 -0400
Message-Id: <1583936196-794-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583259391-21834-2-git-send-email-James.Zhu@amd.com>
References: <1583259391-21834-2-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::26) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.14 via Frontend
 Transport; Wed, 11 Mar 2020 14:16:42 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 728b1f3c-89ee-4ab5-b798-08d7c5c6d2b4
X-MS-TrafficTypeDiagnostic: BYAPR12MB3590:|BYAPR12MB3590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB35907AE1449B2A07102069F1E4FC0@BYAPR12MB3590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(199004)(66946007)(52116002)(7696005)(66556008)(6916009)(36756003)(8676002)(26005)(8936002)(81156014)(66476007)(81166006)(86362001)(316002)(5660300002)(6666004)(16526019)(478600001)(2616005)(956004)(6486002)(2906002)(4326008)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3590;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tybxag85M1V7qMmdm/BvJg+cff4kA1/5qAn37Buz3aFrtlut6JRVKcIIKRRSfLCLadsfEWb4F48DFwfkjsTjk+4U7HHpuifCQrJdN3+4Ji1qZ8+hPHQqKJMlByi/hLeIcGgTRzWrQCocwqiokgMQvnPbfd8hGclI8ZZkOcpnCzlAfn2wI+nGxHKv5aJh1okc3VelzldovPLiseD8XofNajy400z6C0e1pjAOyGdpmUV3qSRYlpZaDZt1dQBm/lvLgQ57eZnYtBhYQSzIBluSA3QUqejp2HQQ3H7ydmi9CcX8/CS8IM5hoafrH8MzYeRj3uH98M/17NlkK+VYEg2+R04GGRogUsTqAQdi/EJSmG7Jzp3sHPDM0lgqtRa2ZEkeZM/5WHjD1NCx1edsI2kYJxzqT2vowFv9RLzqX0NFbJK4syCcyudTL/nO71EI5yZ4
X-MS-Exchange-AntiSpam-MessageData: WWkcet4dyXxrBxbTotBBagDjY5khr/Yz8HMWYCAtQEew4vSWfZmrb+pwm9vqoI/eclGBfL88dBZu+Vy13IiATN9b3Z21+zoq85PeOSN29Pe7K7yK1SVcY2DCdG8f+Ccet1ZYsM3eUH9MoiYY7yoW+w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728b1f3c-89ee-4ab5-b798-08d7c5c6d2b4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 14:16:43.0147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIv0gWqYgK5dEB+eBqk3/NMLwiDkrkb5ImAPEDLWCpChOVhs1QVYX3IpIwj4/xn8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3590
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
index 2fa2891..ba28fb9 100644
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
@@ -334,19 +337,22 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
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
@@ -355,6 +361,10 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
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
