Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F0EC33C99
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 06:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 730CB2073A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 06:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SYxA1Vy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730CB2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 253186E134;
	Fri, 10 Jan 2020 06:00:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE246E134
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 06:00:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T10m6XQ5flor3AjL5ED9M6hvcqYVUBXTN+lI3SIXyKOLNRUBYibg/Kq9b1hsCVh6axqIHd8n4VLJn1Ftlmuk2rjkNRijKovEby7tzzmAoneIFBlsDf/nQHO7mPUaayPun3gdIurgA4b3gSbAJrtOAjQoDFtYweisWQLzoE1RbZgYRQxsMA3I1KrPzVhJcxwBoaZTX2CNmjKl604bZXl9eZDcX2jB6fx63fLo3q9lH1sJw6tV90zyqpUJP/QzXpiFiEuzJIK+0JTx/ZfAREuOzaF5vEzWrqe98czyn2Uhv07nQdtod9oo/e6V+s8WPDAx57wUv8zX7KIq8IRem4H8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTj75SQBmY7pxMO5f6ZlHewdFGsvpk8xWmCUwJfMuv8=;
 b=DGqZT+OAd4C9xNBUEMKcms2Stj2NwQq7tpn45kT1tJ3SnvbuqO7wn9U+fUCRE4b4b8zusHs/07sIIWa8t6HhMJxXMHHng+SjYIwJISWICPfcK6I2Ld5uk0uPVNnwH/wOkwJeG1Fs3zHY9OZQogeL5oAuwMZf24gHLb/uAQWCJNY0rxCyJQ8kwRC9Gc8LoXn11YbiL6P0bCbHhIXKUOO5XxWXz/6CTQKz+8fjjzKjqtf4zKnpb2FODCu6rnP019h53ygbtTh+DpOuOS8++8fbTpwti8mZsAcputxVN4GlnNAhA/DjUbin1ICGihWaOs9EkdJulpxbX18G+GL0u4ypbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTj75SQBmY7pxMO5f6ZlHewdFGsvpk8xWmCUwJfMuv8=;
 b=SYxA1Vy+QnDMKySIEcGEhPJs4GE5g62+1rMpijEEmwaf/qr1JF/RiKPcanQLiEhJmjyyaWnhDelL+i0wPcFPAYFWc06qx2yNbbNwbGvkl/2hAqaIGqhSUf1FW0WSmp2znVCL1AHXo0LRO7SdrcrmOoaG3yk+z3dviYYm1wF1rcI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0073.namprd12.prod.outlook.com (10.174.104.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Fri, 10 Jan 2020 06:00:04 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 06:00:04 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: Fix kernel oops in
 amdgpu_dpm_switch_power_profile
Date: Fri, 10 Jan 2020 00:59:33 -0500
Message-Id: <20200110055933.28218-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47)
 To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from Harpoon.amd.com (165.204.55.251) by
 YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Fri, 10 Jan 2020 06:00:03 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a974537c-f7ed-4885-2378-08d795925639
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0073:|DM5PR1201MB0073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00736AD4BB94F7D66F25E5D192380@DM5PR1201MB0073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(199004)(189003)(81156014)(81166006)(186003)(956004)(16526019)(6666004)(8676002)(2616005)(52116002)(7696005)(5660300002)(66556008)(66476007)(66946007)(4744005)(2906002)(36756003)(1076003)(6916009)(6486002)(478600001)(316002)(86362001)(4326008)(8936002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0073;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLdJGbleMQZPLAf6Qyl/C7fOZY/wKmsIklkC+dZitJjzohgUsojTwp/0J+EG5HmeXgukb8Hvwo3yRskqWn8LpOkELNrAGo1zwrZAB5bcmZACrmXCtiorwZdzWmpnOSCRG1wthbtWQ7X/KWq0Ig2jdkgV29vrtNZtNYukTLp+qL/yDC/YnGNDar/ytaU8FUxZ57eL5em5rAV+9dEqR569Qznh1A8WY9n7SbMwJcYs6klYZ9ZjGo3P0KVCcKg2D3a9t5tyFAuZVd0zweZnR1wxNAg9BKMxZU6A3aj3Uew6RGlOmdDhXSTwUhtLT7pJj2uMMrdNmhNIkrLNWqD+OH7KDSwpeHQs5TyNVfkV6Yh63vGBijEPxC4eUQEDJy0HiO28CqSuqRVCptBF6XB0rXyaclDqS7QhjAVnHNf5PMVUbPR3hv95S5yxI7Qm9V88wRgk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a974537c-f7ed-4885-2378-08d795925639
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 06:00:04.4951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYZXk3Eu8tBV1xYk9ufzOyhbgK9MAToqEki8KV31407aaSvnKJB70H8/SK2Yu5fQzODDd60ouBjTOYyPaM6FWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0073
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
Cc: Evan.Quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Pass the correct pp_handle to pp_dpm_switch_power_profile.

Fixes: 9bbdc6e48ec0 ("drm/amd/powerplay: cover the powerplay implementation details V2")
Change-Id: Ia6998a836815c274509bd7967c1c148475252fa6
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
index f7c0ae6e0f8c..6c7dca1da992 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -1123,7 +1123,8 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 		ret = smu_switch_power_profile(&adev->smu, type, en);
 	else if (adev->powerplay.pp_funcs &&
 		 adev->powerplay.pp_funcs->switch_power_profile)
-		ret = adev->powerplay.pp_funcs->switch_power_profile(adev, type, en);
+		ret = adev->powerplay.pp_funcs->switch_power_profile(
+			adev->powerplay.pp_handle, type, en);
 
 	return ret;
 }
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
