Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FB9C2BB1D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 13:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977B520719
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 13:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ukXhTQuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977B520719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A10DD6E829;
	Tue,  7 Apr 2020 13:14:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF6A46E829
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 13:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqAX3F9Y+BuK6z3OfkzMqsh9xZU/cp/c+KYYF/A4+Afy68kX/cVkASE0/oNARXW09EAbcP3p0u7eapItwvRNmwN08l5CMVPQKt+UTVqaCxL9eAv8m+OcTNb5XKkcOlwGcSPo78XNYT5p5eF3JaZW+MLy6cHR11x5D0JqlIo4Ggs8E8b1RQoAvWf+SVUrfx/OhH1moNXlkSkqcarQ0Sgtxu4y5g0F0C9j8HFJvWPYkfHz6CJDtPsSmYWF4B8EfKQKEOgE8lSQyFhnbC3NlMYu9CO0DY5MqpfVTVgEx2gGM7iehkQ/sUXKj4j/dCFwkMzlyD+n7SE7Q9YIm5zDSDc1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFPoZOrearWPuPj5JRX1AjiUopaXRMvNgXznNLh6r+o=;
 b=Im/FPCW7CRtRU/auTXbtTCUCB/pau7GJ0dokgkR3tfD52r4TOm6wOBIruxd/19jIK+IAw3HWc8R4pJATtxuj49rOV4gJu9xY1kuPnaALt7Ivub51muuoQWD2CashXKr6YDYNTdTHa70Derx6QlhZbwowpbj9YoIhP0p1uj7d6EELeKl5EBs6kYeOmyn4yqqdr0SuTlRoNhdlFH4jGLnX+lqCjcNHmIz0XnLVqYsiUEURKDtMoO6JZEqXTj74z6w6bbTscei8mzT0/ckQYfLTVyZh8dRZjTfxah0tjeDr3hvON6WCjtou6A0Ie+eHBEItYuzwVrFNywk6Qev4CGob6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFPoZOrearWPuPj5JRX1AjiUopaXRMvNgXznNLh6r+o=;
 b=ukXhTQuBJ2nvWUiZ6SWzaEa4fE7qptqdRRCulEmYH4b6SBHARhG77Vp4t1vaM5Kp/Q2Z6YN4RQPo4EbyZZSTUJ+VA4nwRBq7b9YjNJUgcpqiQpV7UVuOmdYnyxTOFv5bhfpd293T0MmI2SauhNBDgTbPwgXx7I8S9X6kI/lINvY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
Received: from MN2PR12MB3536.namprd12.prod.outlook.com (2603:10b6:208:104::19)
 by MN2PR12MB3293.namprd12.prod.outlook.com (2603:10b6:208:106::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Tue, 7 Apr
 2020 13:14:26 +0000
Received: from MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b]) by MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b%4]) with mapi id 15.20.2878.022; Tue, 7 Apr 2020
 13:14:26 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with video
 playback (v2)
Date: Tue,  7 Apr 2020 21:14:16 +0800
Message-Id: <1586265256-8824-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To MN2PR12MB3536.namprd12.prod.outlook.com
 (2603:10b6:208:104::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HK0PR03CA0106.apcprd03.prod.outlook.com (2603:1096:203:b0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2878.15 via Frontend Transport; Tue, 7 Apr 2020 13:14:24 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46802f9a-d58c-4a4d-6bcd-08d7daf5989a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3293:|MN2PR12MB3293:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3293416701832F335C4B95CFFBC30@MN2PR12MB3293.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3536.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(16526019)(316002)(4326008)(6916009)(6666004)(478600001)(2906002)(7696005)(86362001)(186003)(15650500001)(26005)(66476007)(66946007)(52116002)(6486002)(5660300002)(36756003)(8936002)(8676002)(81166006)(81156014)(66556008)(956004)(2616005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fjblDoxWEr6BNSx/AAyl/3YDKqjjNaVeY3PLiT/9BPUjNMYHqrfQP7Fh4qa5sqjAJmrViiTEAPJu64EII0ay4wK+W7pmth1TR7pNw3H6D5oa/rQ+YtwG3c1NWwQPvvFLyzhSZWRQaIyCUsipXSERzz7fCxtkb0eC3gUN4ooKMsJb6YlxPsNpgSSJDxKpBAiCq9M1bGLT1R8z8E/Wbfra4EIwEOUJZezVDZH2EulsPeOf1b2c82mW6tXBNKgg3GeZQ9xEOuvKiYFo6pHhn4eCS9HcIQW6dJsTt6abJJLJF7OOqy3h9rEOaeBJBTyK5grE6d2sRihcxqvdWv+rv6XfeXA0unvrhpahyt/c1coiVnDOiBqwbdhn/E8t+pPC/Uz+g+C+UNS3XJjhCJ73GdZ1ZzAkGSua4+wgnvUwO6ogd6nJUaPZ1LoYWrZ16Y/NXMgW
X-MS-Exchange-AntiSpam-MessageData: 5C5Kcx3wbRuDAN1CxNeEKNT+zl9MOLOczON+SrvQaYYuws6ILfRxI8Be6ZAxatQ0dklAiOuH39Jr7GdAUri2SV2++JGff8qHx63VLPLtaZiJsGsbZOs+KisHeeczOS8avgGtlyhDIENxHRDkK0P9WQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46802f9a-d58c-4a4d-6bcd-08d7daf5989a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 13:14:26.0193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/8UyXyEvcL9z207u4Y7IHxntGQR23ow+sP23csftvruz90qSoSmt4USjaLyggEh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3293
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com, evan.quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The system will be hang up during S3 suspend because of SMU is pending
for GC not respose the register CP_HQD_ACTIVE access request.This issue
root cause of accessing the GC register under enter GFX CGGPG and can
be fixed by disable GFX CGPG before perform suspend.

v2: Use disable the GFX CGPG instead of RLC safe mode guard.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2e1f955..bf8735b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2440,8 +2440,6 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
-	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)
@@ -3470,6 +3468,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		}
 	}
 
+	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+
 	amdgpu_amdkfd_suspend(adev, !fbcon);
 
 	amdgpu_ras_suspend(adev);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
