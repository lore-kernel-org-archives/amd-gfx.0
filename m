Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9330BC3F2D1
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 18:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CA120656
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 18:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Lat4lb4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CA120656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C8D46E506;
	Tue,  3 Mar 2020 18:16:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADB426E506
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 18:16:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8ZP1g0JhInUYp0TRKSk+BAsAPf+hWHkbjlOHls4T1NjCcWE1QJuijr6CaY+qnFKBvsaLOIyxIdQi0vSh7mGPRXy/1JSP133Lpp9mD/FJ85XxqPQVr4lecGtbu8RGyWbn7Djk3jRKKwhV5iAW7GRGTwc7qA+p9XnbP/7xWUbDzWTErZERSJ5KEsuPEAshF/HSWb7oozGbRe7xa8J+N9Wlb3JrI6a+iNyRC7Dbie4Rr14ZeTjnHvZh1mYsj16m80ZZKTQ/lVqMHws17riukASBeyBhU4QXKgBzmRCKEf8HizXXB1XMcasVjTse1k5OvusSohp8UBcv3GvFRWnQRSN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOu5YCHBeUZRKIFWUKiCmu1n2GYIF7f502Uqgpmvwrk=;
 b=Xl2whCkNw0UF6B8G4nHpM4Z3GsLcbyRNwMOTBsn+IoZs2tpSC4MPeVhDSvEdmr8z4AsW8yTPhr79D4IyKtSgPjd7Vn9lmbOz6qe/MgT3qGEvfNBrJcUtP3VQCc78jWwf9DgGQujD0qZkxWTTXiaxNRGVju6RB2ybcvG//UCeS+NwAK3XO8Z3fpQJNxsO68WyHcNq+e7IaVXb9D092+A5GcDPI+7nd2uSct97mmKXAaBJdEe4AAiEWhvdFE86UEDEmQKw/aa92zO11Tteef3HVGAvGUmSzXI3KpmB0i1yjp9XruprvsSKJfBWedcFdsFayz/vcplrJKpZRb81K9zfyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOu5YCHBeUZRKIFWUKiCmu1n2GYIF7f502Uqgpmvwrk=;
 b=Lat4lb4KrvdQDzSEuLHtryWLl3iMrA5z3XkUBeLKDmbQjqNmRV9ilHECsUZJYcdW7PYh9bq/sN9lgL7ujPmXM5DdEoBtBjxziCgeXsHz592AI0P36AI+TzghlB4aU7JjMr3p7MzIN9Hs0j8aXKtc1kNv+SpZLtA+U/APpFWG1bs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3382.namprd12.prod.outlook.com (2603:10b6:a03:a9::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 18:16:39 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 18:16:39 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu/vcn: fix race condition issue for dpg unpause
 mode switch
Date: Tue,  3 Mar 2020 13:16:29 -0500
Message-Id: <1583259391-21834-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::29) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.14 via Frontend
 Transport; Tue, 3 Mar 2020 18:16:38 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e7d0ff9-d1fc-4bbb-6e77-08d7bf9f040c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3382:|BYAPR12MB3382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB33823E68EB3DE0E88DE9BE36E4E40@BYAPR12MB3382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(66476007)(26005)(2906002)(6916009)(66556008)(66946007)(86362001)(186003)(8936002)(52116002)(478600001)(81166006)(6486002)(316002)(81156014)(2616005)(5660300002)(4326008)(16526019)(6666004)(7696005)(36756003)(8676002)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3382;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQbH2DcDqMysbk5FzBxrAeYEzY1IDPx0sZpFxLlbNccD2UStef7g7qL18FI6qv/Mv6ks2uzPDybj4qAieJjxTHBA0IjCnfA0Ak3vtHunndoxDHwkuD/G9Sl9j2fC/hqyTXxmFQ1WnrXDRVAIs45secacdrG1/HUu/nfQR80jzhtCZ+tZr4rW+qlpqMtbYuJKvSP6UOYxijbHhy+JuARMtiWFhiKXDIkX3ywmW8PqPQHMuIm2xD+euuSdMkgkGTZGJBuSNfyoeB2cILkXLda9reunCqIBKsY4eyk6K46+B91hBvNJhL/c3Ja/WWr3F0q2O9SCZY/aYWR8X35BiLDaB74jdmxOh028H+SEgaIZMjH5fxlo0AsWRAm/eHw0m5q3j7RyWVOYtsd5F6WzQuPqjlue3b7hqV7WZK2uaVX+6IGyNlCrBKdtJoh7UnO1+2/a
X-MS-Exchange-AntiSpam-MessageData: 85oQvg+BL321l/mE6RJW2En4ADJfUigrcJj71Xq/NXC2P5og2To4Q7smZxBGtKJkdGu6r+k0tl8BgU90vD+PeVqBdv2bjg8R9m9/fqsuj8xXO+61w5zzhygcB2KlfNbuDZY2J9Hob8NyiNi/cDMObQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7d0ff9-d1fc-4bbb-6e77-08d7bf9f040c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 18:16:39.1450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAcwVkJayYYQpo23pS16NoCUa/bm+DW7iwjgUuF3J1qKgT3P2D2cJmxA6Vx0Plx7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3382
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 28 ++++++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index aa7663f..74cefc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -64,6 +64,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 
 	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
 	mutex_init(&adev->vcn.vcn_pg_lock);
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		atomic_set(&adev->vcn.inst[i].enc_submission_cnt, 0);
 
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
@@ -332,19 +334,22 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
 		struct dpg_pause_state new_state;
-		unsigned int fences = 0;
-		unsigned int i;
 
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
-			fences += amdgpu_fence_count_emitted(&adev->vcn.inst[ring->me].ring_enc[i]);
-		}
-		if (fences)
+		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
+			atomic_inc(&adev->vcn.inst[ring->me].enc_submission_cnt);
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
+			if (fences || atomic_read(&adev->vcn.inst[ring->me].enc_submission_cnt))
+				new_state.fw_based = VCN_DPG_STATE__PAUSE;
+			else
+				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+		}
 
 		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
 	}
@@ -354,6 +359,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
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
