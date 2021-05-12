Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA24C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 19:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02FEE613AA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 19:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FEE613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D216E2EF;
	Wed, 12 May 2021 19:45:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF066E2EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 19:45:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WS5Y8bZNKeYxgXIz3xxM+QfmPPP2cd8os+149lDYacMPrwHa7I8tjuVQvxNDeQ9iimZ1rMTYsMp8KltkTlsEGVdzBwkmkbovAuZHLjfz4Sn5gBb1TY1vGN4MLSL77zkxaju9d6ONrlx0wy/o3Rp0wzyUEYnq6u9m+xVbG89T6sHp9Fo6hrwjI6a6LXhbtNrZdLSST6w7aMVDfNb+RbPaCdgqIOQO6C8EXjli1pkptcr6fcv9IIPto7ok6iiGMM4d1hKkj2CWclFpHKpZl//FI67tHMR/ior9dO/q24U0Vvxfm5myB5pe1uecznmMBlEqPtZu5trmIW3ncWM6PwFvhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaZhSwp4MTjncjecPRjoxGtqt0WgrZ+P3Bn2m0R8EZg=;
 b=OCVEznKGyA7xlQEYvsa8gM0+x+mS8bdZKDhphko2A3f4PVd4z/HWaEubEoZNbVg3Nw+/fJLbI/oRgdy3gmYtGfcflfAg2Dnwb7HnDzWDlWZ86WDeEc+iiUrbJWjOr6RXuu2b39NOjsW5GqxzPiYoM2uIZXkWnZNmir57AC6bklncHJbEkaWqpRnOylTZGFLpkHmreIrON6l8oFR9xjeEEUtDkRwlLIyrsSDpXPjL/GHiieVoHThuqzr2Q52tTuEdBoXX8x5oV6iDdI6g1Wm+Sl59+gal32XaCBvigD9mG871XPRLpYoEPgTiZTXjFnxjSj8vZaNymbqdnnpE94zDNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaZhSwp4MTjncjecPRjoxGtqt0WgrZ+P3Bn2m0R8EZg=;
 b=Q3RzSHcMSHAJ//SfuUAI79MD80baMVR3RhElyY/5PAp1a2fKjfqFXu1bQS2o1iAkF2AW/Q8wVxjegM1MbSxMJ07jFbIVO6RpBeAssraTmdqkwnHqM+0ZXZLGNtNbXdD58G1cBQxY5PedtuWAk52AtUOcor0MsmjosH8dC0uKlxw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 19:45:39 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 19:45:39 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: free resources on fence usage query
Date: Wed, 12 May 2021 12:45:26 -0700
Message-Id: <20210512194527.7687-1-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <f689c523-c60a-a0d2-ca6a-5dcb043ffc91@gmail.com>
References: <f689c523-c60a-a0d2-ca6a-5dcb043ffc91@gmail.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::21) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:33b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 19:45:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77f54bb1-5a9d-4d19-2990-08d9157e8518
X-MS-TrafficTypeDiagnostic: BY5PR12MB4997:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4997506BD115D81546174168F4529@BY5PR12MB4997.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:241;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7qiSi19lENHn3xrrizEvTvTfALWUB/gW69D6nAM5mgIOndhHVty8q1BvzFTZoWIvs726lTE0xql7xyKyhfkWCaxutzG1jEZpbG5mSQiJmpa6IRzHXDvRoK3g2njmZyG46rLNk5H7ibTvo2kL3toMoAS9nCWp9HKoyz4+SkHMkI+SsnkSgBSFPyjtDrxXRqPNUGzl0FMYOPi8SR/49mtk0muPow45+Rlfv+8wD0pMeRasVicZ0y2f7srfAMeRiIAEQCHrXbRfIir4awdwBPcmkODkErXcZ4ae9lc93/LYW/vd5UiuTNZ6qPytNyffY/0YjS/0DdKfAhKtv5LWfmkFz8tpSHKcoh+WJ/0oto9qNAYrM4r2JX669c9+62suloQpSgVCJuSzx8e86mexRv12focza7rjWZDjLqcng39Sr4xJ6kQtg0Dv3gJvPXgkL4MmsueItPw8MTiREVUXRjI9hMIL/+WKGc3Zfrmhgeg7emO+lmaO5ma7TTk4H0j2wD43lsu26VZwOBrCIHKU2jTQXVyAP2NgIBp/BEay9MWX9aeb4JIRHXZUSrEHfY/fuxp5PA5XMTZIHQACE9X2Ahkk7OhMCexR1Xa+gYSvJrrIIBBAe99qPRaz0owNCbcUrQXiMw8lE09uEucJGrqfqoMfRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(366004)(376002)(136003)(396003)(346002)(8936002)(8676002)(83380400001)(86362001)(7696005)(16526019)(52116002)(186003)(2906002)(26005)(38350700002)(66556008)(2616005)(478600001)(38100700002)(66476007)(66946007)(5660300002)(36756003)(6666004)(6486002)(316002)(6916009)(1076003)(4326008)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RQyrxcjPZ0zRgDGCGYbJ1nZGw6v1GVHs+DnyhL76dsu0gOWvSNKy+LJrBgIm?=
 =?us-ascii?Q?q6G823TK8UGO78DY5bZwrFSIQrT80aWDa7qvYoRjh/CnOVA6w+GVvPV+Eax/?=
 =?us-ascii?Q?f7z2qEItbdTinuVPc2+qSw7hB9G01aaaP01+757j7N66LADFgO/2qIEDLHnb?=
 =?us-ascii?Q?amM4RcedjBJBlmUDkW0OCwnjwJitOpb7U7ul402wLc0WzNcmFr6czIUzjEep?=
 =?us-ascii?Q?aR0WYWN2l/eZRfpM/J26vckRT6GIXATxVkMRXF1Sbmk5CpQIHrUpm5/GEAqn?=
 =?us-ascii?Q?BHg6MDvPnmiZKL1KxcTQTFfyw3xdWmSJqqlKV79s75217uTKU+pzHzpC8Ifz?=
 =?us-ascii?Q?drRBxCsDhBwmvKw54GHFlZI8p8ZcwaPA30wgEwncka2SEj+JqyAYvRtL52qT?=
 =?us-ascii?Q?khHzRpjyPLGcDaueOe0Ue67Dj69wHsUT9J01JrmmQ35LXxa2bj4d5XP0GKoI?=
 =?us-ascii?Q?mdxGVMEAZCW3mHoArCMv4P+bt9nlPLplVypeAQLqGLf2fFPeSlSHa7p3M9jU?=
 =?us-ascii?Q?xXEvOZG5WZmJm8LMCp9KwcOZKEvbhfDcFfcxmPIveJyVUFp4YqbQ0mev47AP?=
 =?us-ascii?Q?VdNH9pEMrT1aA2ALo4biXekhYJyueW+vyJ+mk8pInhkfC7moX7nvSFv9kWYc?=
 =?us-ascii?Q?x5GfQ1KjQxoQDuyQT3woMUrCtXMWA9mAYA9wc/lAV0gzfAEiZsw9KONLa6cO?=
 =?us-ascii?Q?v+vaqrBb/ku2A/HD8/TNbRkcky2td1n3YTY11xG+OT2IGj7XemqHRf2Z2y4B?=
 =?us-ascii?Q?hXiDVRPBbMVEJNztYgHhNrmLH2QcucNTRS6ZmJfe/qjbkn7evO0yppHzrnSo?=
 =?us-ascii?Q?QZghSvDJZ0DSIXdrEgsSgsRojeHtiAHYFjMUiPAFwcyprbu7SLd3QgLwLcBO?=
 =?us-ascii?Q?CGou8pPSF2ymN1QDDHIoMnlSEi2cuHKTiz5RnUb8CQLjOzKiPWIT9FfvtwLV?=
 =?us-ascii?Q?xauZRFkMx82RS05X78RJ3bT2AEMNQQNaBvUHWLPYi/c0KcrgAfMUrqMNBWnd?=
 =?us-ascii?Q?MwfNYYsig+l0KXCJHe2kE0AilqEGgDIyCHsAMAluOG58zJVjCadi9RALbj64?=
 =?us-ascii?Q?7ATNHcdUNQJLP8eB/GvDsPAReVbKtviaP4ygltEx6p4guO4z34sbePFfE/wx?=
 =?us-ascii?Q?eCNt2RoBLYWoY3tiIy1iJ9qeOyePyrTQV1HKyyAzUsPXF2xTogTnnJQWOOjM?=
 =?us-ascii?Q?PIGFFHtOMGKy6imR7zM2boNB7NOeEm7xC6AUcVA9gvjsngRTMrbTzK7okrkh?=
 =?us-ascii?Q?jcR/9fhqsDY4lPc4nRKF9kFgm+SxCswZ5DaJa21ihlVS4KC5eEbmw4fj+Fol?=
 =?us-ascii?Q?efZaQYe3tQs7cEJ2HDFtU58n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f54bb1-5a9d-4d19-2990-08d9157e8518
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 19:45:39.5260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IgPrRQP9cFQKFwqFy9CQYNhZuypqbcNx5pYbORg5Hnezp30fqiE5YeGNhA6UEDw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
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
Cc: David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Free the resources if the fence needs to be ignored
during the ratio calculation

Signed-off-by: David M Nieto <david.nieto@amd.com>
Change-Id: Ibfc55a94c53d4b3a1dba8fff4c53fd893195bb96
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 01fe60fedcbe..9036c93b4a0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -669,11 +669,15 @@ void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *cen
 		if (!fence)
 			continue;
 		s_fence = to_drm_sched_fence(fence);
-		if (!dma_fence_is_signaled(&s_fence->scheduled))
+		if (!dma_fence_is_signaled(&s_fence->scheduled)) {
+			dma_fence_put(fence);
 			continue;
+		}
 		t1 = s_fence->scheduled.timestamp;
-		if (t1 >= now)
+		if (!ktime_before(t1, now)) {
+			dma_fence_put(fence);
 			continue;
+		}
 		if (dma_fence_is_signaled(&s_fence->finished) &&
 			s_fence->finished.timestamp < now)
 			*total += ktime_sub(s_fence->finished.timestamp, t1);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
