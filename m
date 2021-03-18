Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00128C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2A764EB9
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2A764EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0143E6E883;
	Thu, 18 Mar 2021 04:33:54 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E346E881
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 04:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chG4JMgFQUi/YFx2swb2PSZvF+zBi5GH+tIgZMHplfHwkalT/fRgYzTO2nQPqXSu2+3ETCAoP4katkSBufOc6A/6AA8d567FN49ZS1TZPSE5iOC+Y8halGOwWFCJ268R3z4I4w6dulKHeBM57TZTiTGTLPaGvrUNYIBNQqYbviL02ywuDCBk9RGuQqw/mTff1p9LKMv3Xhpg5x7mQguHGf/7XW0WPrL5BKT4wcfRPPwgvdiiNbZVCPhfaf0WOMHAMJGLipmNmEmuWoxQvthKM6UGJnTG67RnkcnAnv7B1ngWzHZCWVdA7BcGZaMf4vZvLK6b5DFGGXVia2woMgt2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TW3SxekRbPYC04cSLiuyLGTkm0vglOf/R+UiM0gNij0=;
 b=MhMRWZqBF4UXsLYv2uDjzQsDyeeCMu3HjdFSp31a8qsU16leJHdDe/EcClTEDy76Qtp/XcWAc8STSqojdqalJEkVmrgbPX+ldDcSHVlStk5BuX1B3gEEGF/6OrK0N3r9AxGra9/JaA7er4MMRy/KAQIXqeGZdqsWqkHfU+iNXpPm+76nROZFvowmcpUjTrS5EDykMQWdltVdGdBi+z34x1ZTqwmr1g5yMiqgo2GXC5ccfMM1Adti/xqb12FkKoFOF1rf0rJzCpBJDMuUttm2nObsuRHfuOXnLFSVGmURUH0dGZi0BaMJRPLR7YE4ENWH3PJHQAOZgcXlmhH+RrOnzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TW3SxekRbPYC04cSLiuyLGTkm0vglOf/R+UiM0gNij0=;
 b=VOroYSTstzJZLPlIMY/JwojMNaTqJ3G/ET2OTKGp2O9PtH4XGULjTmsjGjxpdIvzVSnntMyjzFGOvqylwkI/k2TudJXS3ujMvfS0suwWE5hLDvqYL0ayzyBnoIdTNd92CXBkzrGsQ+IzRBIzOSxNi+XR9gnYzfSSZGED580C4ok=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4016.namprd12.prod.outlook.com (2603:10b6:208:16b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 04:33:45 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 04:33:45 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/13] drm/amdgpu: move s0ix check into
 amdgpu_device_ip_suspend_phase2 (v3)
Date: Thu, 18 Mar 2021 00:33:17 -0400
Message-Id: <20210318043323.3989-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318043323.3989-1-alexander.deucher@amd.com>
References: <20210318043323.3989-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:23a::29) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:23a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 04:33:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7492e2e1-772e-4f0b-161f-08d8e9c70479
X-MS-TrafficTypeDiagnostic: MN2PR12MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB401653D094FFF266C605D3DAF7699@MN2PR12MB4016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jNp7ybj93tAJ4fyolc37OwOgZjdUvg8SvLnzNE05J1OHXbNt7irlFHseDnpZcLvGvTkDnSYsCRe9xPP8CGfWMjnyox2azfMgR0L/525sz7B0I1xTMVEH4gzXMDqVrnrxTcL6AHpYObBi6BY0nZ2dZE3Pm2DSLyvG4SwNH9OqTGJBw1G1XG4aShmHfBdP2UBu164ID1Gap0qG7ZqOlpNm6VewVzjkxv69BiHQBYIw7x2LWKeOS1c4nSIv1PL4wUmwRFkYsRXLhV4tDXQGnoSwqdfd4pQPooAVRM4ln41KL/Lk8m5FqJSZG3XK09WeYPQN3gE81bliL67yGm6DwsLeQXXHhaznrfAgNPY24Vc+gOoaqM3CA76bMuvtwGyl/nHy1S2J9n5JTeM5il4jo9lyYn8FSbKGEubl2yz6T/nUmwoWGdvNOtm6Y0cu/iVnsW+qPD025QR5NwkpNNm7xExvXZgn47pF7FW8B+Kh+OAUCd+g5RrAtsdWKPI7xGPdM0V+2P2+qc07SDnLVJxAH6a4AENGOfNJJrtnHC1l7ncZS3d1HYDLNfoOCxdzeLcyR4tTExk7JKMg3GUvQRUfNVvlh1b3LQoz5fMyrnBdGBWbiPQvdvgdx3VOcPRtDlAQb8CgcN0I0LyoaOixohMgtM3mdlsfs6qmqLXJOAZW+lOWwEXIquBo3nyePUglJQhk4NXC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(316002)(5660300002)(52116002)(1076003)(83380400001)(8676002)(66946007)(478600001)(38100700001)(86362001)(8936002)(16526019)(69590400012)(4326008)(6506007)(6666004)(186003)(36756003)(66556008)(66476007)(2906002)(6486002)(956004)(26005)(2616005)(6916009)(6512007)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FboECaJuM64Dqjq7IfPf55/iN5lsega1EnjZ5boXCmUITklDz7Ug15Fpx9As?=
 =?us-ascii?Q?msQ5Bb9XjFDlpPtImaNk/gi/HA+337khb1oUT8Jg6RAWio2QYFTuzT3/5O8/?=
 =?us-ascii?Q?jvDbdq0/H6RgG8DRd4xu4si9z71/1YiXxvA8e5ygbTffuJnFq47fxLqVZnOy?=
 =?us-ascii?Q?YnhIa/skvJtriB88nTvgGXF2AACAhzYOmyFcCPSVAuXTByC3M9avmPe/8Hes?=
 =?us-ascii?Q?q/A0RZ88VigEZyHssJwAvnq5Fv4GgkOhHnRO3EGDDw+m3hi/8JpQTlGRCdVi?=
 =?us-ascii?Q?EZLYGVFrtG093gNESNFpWZUwlby0mYubeEZ9MYPvKMP4IBeU2KNhK3h25a1u?=
 =?us-ascii?Q?z8vSLQVE+PxRPu7Nfr+wwkRV4PxnmBQ/dlIeC/IjB0sNrOw5M+WlLQXMMytc?=
 =?us-ascii?Q?R7bTiW5nsP5H3EBjItE+4XypghCEGDjM1AdOXtbgVdie0kCranCTwMR2c/7U?=
 =?us-ascii?Q?xityhyl0/9II9TciC6x/G7ucBPkZz9tKOagOZwmnSi8PnAazX92+JoeDiPfb?=
 =?us-ascii?Q?Vnn6x687eXdRZfDCGT5NJDLbSVFssb38rSQromIueK/uHfhhwx2xs9oKdxM5?=
 =?us-ascii?Q?aVJeGWHE2kkaMlZv2B0Mep7y1+W1LVCHzSoPgfgIMzF2Cjd7x2FB6P7J8FOC?=
 =?us-ascii?Q?DJL3X0DSHd9MFTryqRn3a6XHp+EIYKmWSG+0Fo6zCizVJq+IKK0/4SY0f7AB?=
 =?us-ascii?Q?MkPA5p1zSzFTXJc7njZPH6eKoyH0O+rZ7HyxJKz3PSdGOnjxT+0ahMO/n/6a?=
 =?us-ascii?Q?hi5E1/3S9cYVBBfqH0NDRS00YfwkZ+LvzJyqXCD9tlwa0JSpAsI4TOV9Xisy?=
 =?us-ascii?Q?N5wuUOF5RJXCVZgopj9xbF2nZHCAdI6fPFV/0AipVRdStM7sBvM2BPqstgh6?=
 =?us-ascii?Q?eIuOvY2RJAd4ENR16E7EQgr/SON7byaq99ojArskWQpGhsJxsa0jWpf6bu66?=
 =?us-ascii?Q?HWhaZcK51WyWOwAaQF9VY5vkkM1PAaOBbFnK3Zc/zvpHVs8RTIQll2CYRWfo?=
 =?us-ascii?Q?PXcAirifboy17iR1755+eX/1vzFU2zCGIuM6Gx75qdg+SBCORe7s4rdik06d?=
 =?us-ascii?Q?lHAZz/BNwBhriBn1JGp66OL/Iti4MZn8S8PQ1A28+EaXgDFGOpSu/vc/7CxN?=
 =?us-ascii?Q?p2hMNWvmo/Y3NGMrIwd5hIMoeT2Ody6auaktwq99Knm+lysjYmt7AWzrL4C/?=
 =?us-ascii?Q?aPsOWBujr06J7Sz/g9GankFgaQoDAqhvUKD8JBbNTijPbWoCGW1nZHi23tXy?=
 =?us-ascii?Q?RvBlZqAdRhhn6gKGi/SrAZ7FqahvvltzTVm1Zh8M1cn1LVantT5txEZrVaEQ?=
 =?us-ascii?Q?hGbvEkHyOAcIJl3O/I64mB34?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7492e2e1-772e-4f0b-161f-08d8e9c70479
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 04:33:45.7634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMP4B7x7HvMoQkbVYB3B/NAr3jiGFezYtIBD3BqRFsJwt6AayBxG1tC0ZCOlkvkq3YX0PhWUQzksFBY3TtevKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4016
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No functional change.

v2: use correct dev
v3: rework

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 80263bb8a631..2f34628e15bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2699,6 +2699,11 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 {
 	int i, r;
 
+	if (adev->in_s0ix) {
+		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
+		return 0;
+	}
+
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)
 			continue;
@@ -3692,10 +3697,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_fence_driver_suspend(adev);
 
-	if (!adev->in_s0ix || amdgpu_in_reset(adev))
-		r = amdgpu_device_ip_suspend_phase2(adev);
-	else
-		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
+	r = amdgpu_device_ip_suspend_phase2(adev);
 	/* evict remaining vram memory
 	 * This second call to evict vram is to evict the gart page table
 	 * using the CPU.
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
