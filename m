Return-Path: <SRS0=uBoY=42=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB1DC10F27
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 16:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E6F20727
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 16:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZRTzxseR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E6F20727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE5C16E061;
	Mon,  9 Mar 2020 16:57:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DEA96E061
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2020 16:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbETO30MyV0Pfsl0W2dQ6HRYeFRnymGAIJhJvSDXiF2iXQIqPffv1+7M5TfBXIt7ZAqO+rsDd13O3xYCPZs3QDjrYBiD1qujbgFicZAeHUMjuTHKYzcP1oYloxfUGLiHuwpgG/Vh7b76dbwQTZiFIC7uhTqQsf8BzHM4ToaWj1SMCl14jCr4BYj4f0JzY6atGp3Bt9YFMh8+baSj3pGqsTi51inYbpf219SdAL1bPaGKSSvT1jqtwhir1UzX6v7UCEmaDRsyjoYyZwhUCGjVGx80oPZHRGPvDDYNg9NwQc92WD90tEKG1Juw/ggjt6IX/5Zctd1dIKFGEsk6auWv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RU06D8swIdKVNkisXzfflo1dMAdyxsKbMBFNfbs/rGg=;
 b=N/QSgoHeX1z3j8cVaEhm2NbA2qo6hkIV9Rn7fH3tNFzCj49gOJh2rvFKJ+0Szx5ju1NgrMzrvgnKKIheSpVDRonQw3o5vZ9xWrZ6cpS+iZOiVY+UFw/kyfwZpZyYtVU6yt2zlrXtjP3ZTx8z5pzZK1HXc3Wq/ZSOdorAZu/apz40KOsq2FEbNhucN1airVWqYVy/x/EObVmAspzui/HCWfSDfnTAk2pei9gPijjpAEBVPqenDlkjT9idZYC5WcD2KRGDmJuEIJruRdqjb+W/XgR9s2SD+Qb8roC/5AGuv92J7HBXbYwfu0FTAzhPkAGAvpAWW8AdjMFmrtk1TU2fMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RU06D8swIdKVNkisXzfflo1dMAdyxsKbMBFNfbs/rGg=;
 b=ZRTzxseR4pS2uRyakFWDeh/Z2awcbJ0E0zUPhfG6FnWA4tYv9dVdNTWD4ea5JffPzF4F7kUKPVKQXYrm7f+QmKmMrdKaV46535LQl51KiW7lsv2r9IkgWI1Pz4jgOJT29MVGWVpWS+5yDZ6kwljZJfvRTpIE7BC2mkzuMgix2f8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3527.namprd12.prod.outlook.com (2603:10b6:a03:13c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 16:57:12 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 16:57:12 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 1/4] drm/amdgpu/vcn: fix race condition issue for vcn start
Date: Mon,  9 Mar 2020 12:57:01 -0400
Message-Id: <1583773021-15957-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTXPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::47) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend
 Transport; Mon, 9 Mar 2020 16:57:11 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 54a33610-5bc2-4298-6a1a-08d7c44ae98d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3527:|BYAPR12MB3527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3527A84F85713CE9C1F54F3EE4FE0@BYAPR12MB3527.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(5660300002)(2906002)(4326008)(956004)(2616005)(26005)(66476007)(66556008)(66946007)(6486002)(478600001)(6666004)(86362001)(6916009)(8936002)(36756003)(52116002)(81166006)(7696005)(16526019)(186003)(81156014)(8676002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3527;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G/RC6nfScfee3983dT/sBsbsVqQeamlbrEFSUauIQB23vbzzylWQmC2PlfYKVp3AZe5rjwup4nQuMMWh0+SIJanZ4kvav9149TaKwRDqWu5+QchayVyHEIihHaysnZq/8HYEYqE8nSlo816YyPZWPrJyrB9JMswkYvwFynCgg56QWok6GTn9+5JqvqLngg8OmmP529UCF+Ofsf7hRDhEkf0sDiEBA/USL+ZABAXADw7BdbF7KIehQXs3F0s+yJY5vOjSwXpiz2iWDhEY7j04lBDpxCnn4uOfasNg/Dn2m7F29mW66Jq21GIAE2fxzmGvoZpgbcms+VRqZV+A4XCrfhX3A9OinQbnu3NgkSu1YBO6uLXpKuLriBe3n/WsZS9W3vMAyVDPyXFF0kiVRfILL4VUpPKly4sC4ZXtX7JuYbc4w+AkFHJlO+ao502wDLFK
X-MS-Exchange-AntiSpam-MessageData: OuAXqV1Ly++Sf9R/Fh0SYLkxtQoY6lbtcUzYqwM7kpV//4osDGMeyvpVFdbGIFIhHAHgZRfH/2ucFsCv2E5biVZBEFyj7fTOfhvda+POTwdRnWG9YmRMRyC8GVT6Rq1xQq45B24KRhvbTHWiiIxQCQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a33610-5bc2-4298-6a1a-08d7c44ae98d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 16:57:12.5215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vI7cszXGcemKobGeB2InrY640GTP9LOi4E5z9tIXXjUD0G4lAawCgeDikWXJrg8R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3527
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
Cc: jamesz@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix race condition issue when multiple vcn starts are called.

v2: Removed checking the return value of cancel_delayed_work_sync()
to prevent possible races here.

v3: Add total_submission_cnt to avoid gate power unexpectedly.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index a41272f..6aafda1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -63,6 +63,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	int i, r;
 
 	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
+	mutex_init(&adev->vcn.vcn_pg_lock);
+	atomic_set(&adev->vcn.total_submission_cnt, 0);
 
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
@@ -210,6 +212,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 	}
 
 	release_firmware(adev->vcn.fw);
+	mutex_destroy(&adev->vcn.vcn_pg_lock);
 
 	return 0;
 }
@@ -307,7 +310,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		fences += fence[j];
 	}
 
-	if (fences == 0) {
+	if (fences == 0 &&
+		likely(atomic_read(&adev->vcn.total_submission_cnt) == 0)) {
 		amdgpu_gfx_off_ctrl(adev, true);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 		       AMD_PG_STATE_GATE);
@@ -319,13 +323,14 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	if (set_clocks) {
-		amdgpu_gfx_off_ctrl(adev, false);
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-		       AMD_PG_STATE_UNGATE);
-	}
+	atomic_inc(&adev->vcn.total_submission_cnt);
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+
+	mutex_lock(&adev->vcn.vcn_pg_lock);
+	amdgpu_gfx_off_ctrl(adev, false);
+	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+	       AMD_PG_STATE_UNGATE);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
 		struct dpg_pause_state new_state;
@@ -345,11 +350,14 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
 	}
+	mutex_unlock(&adev->vcn.vcn_pg_lock);
 }
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 {
 	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
+	if (unlikely(atomic_dec_return(&ring->adev->vcn.total_submission_cnt) < 0))
+		atomic_set(&ring->adev->vcn.total_submission_cnt, 0);
 }
 
 int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 6fe0573..111c4cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -200,6 +200,8 @@ struct amdgpu_vcn {
 	struct drm_gpu_scheduler *vcn_dec_sched[AMDGPU_MAX_VCN_INSTANCES];
 	uint32_t		 num_vcn_enc_sched;
 	uint32_t		 num_vcn_dec_sched;
+	struct mutex		 vcn_pg_lock;
+	atomic_t		 total_submission_cnt;
 
 	unsigned	harvest_config;
 	int (*pause_dpg_mode)(struct amdgpu_device *adev,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
