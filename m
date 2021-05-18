Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CDAC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FAA60FEB
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FAA60FEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 843936EB9E;
	Tue, 18 May 2021 15:11:36 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3406EB9E
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 15:11:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDq2iQqwMZIiW0suSyGQ2HkkJQIlHLWwDhhyU6KWNec3kKdDgSG5r9L+jjA9nmqmCWQXaQo2nrtUarzdGuVwCPn+H2YaV3a1dB4JRcobCX9M7C3q+uWsfp26N/aL3K5dh1UWMLTAmyDXllXbo668blvhdu9/+8Z3VxgO1pvFEgstMU2+7Ocz2oNr6l+qB0a0Lm5ZHJ7oOx2mpwFi3i5AKSYCVKdV2nlQMTpWpk5lnv+DjcK1ddgkc/NCmHfXtmLNhoIFybMnvA2Kf0LgbrWWEBeA+ejWKDvIYam/oPZcGxKwj8iy3m1KV1RusC0ejHjYeTNZODGlx2E7xRxh2UJiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2LEeFXVlCIk65VCTluI6VfWvPz1CJJw803V+CsyTZ8=;
 b=cTtKl8KbYjn/FEoZRaHmFTZkAQ6KA9MXSNLuxfE75YC3KtXgLUHLZcl25V4rwNmvS4yQ6yVIWPUBqNPoU2Uw2dfiJDs9voQrMsU92KoeFRQiskWnXK69RwBc6EjvEC5RyTD7mprCQKsTViAcxlsm/w384smrmc6lb1LS4ou4OgdU+KZk/WLXhOSJ0lTqFcdck+0dV9kUqkLNhfgAFs2nV7cdQXWxzvknmoHnrq6udLSJHVSIWA5rPPUjpuVR6Lj1cDO3nP4I8Phu5Ahh0LcLzNef2+cvf9vn9+OfD4/fwVk+Ixe3ue6346+1ZxRdTq3ho7OAI/BWkkGFtgRbUxTsKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2LEeFXVlCIk65VCTluI6VfWvPz1CJJw803V+CsyTZ8=;
 b=ceL+FQXRNzHlI61upoxG6y7LkMWt07OKboyRxnhko4foIY9EI25/mO1j1+l6HALbK8k73tIFZOrDO8a/sbFAuv7nHKCwRBdatPNbaiAHM1iGtVBtGKk6tsa/aqgv07aImrND2Yr7g/kgcYIgoke0qwCqHt5/WzYsSEVhsBJ8ITs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4910.namprd12.prod.outlook.com (2603:10b6:5:1bb::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.31; Tue, 18 May 2021 15:11:32 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 15:11:32 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn1: add cancel_delayed_work_sync before power
 gate
Date: Tue, 18 May 2021 11:11:26 -0400
Message-Id: <1621350686-25923-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::24) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4108.30 via Frontend
 Transport; Tue, 18 May 2021 15:11:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e2439b1-a4dd-4002-2ad5-08d91a0f385f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4910:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4910C6C0136465A951211543E42C9@DM6PR12MB4910.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYcbnES9OQoi9qa9RVxiGRaDbUdNkrRbYUDWQ8IMe3FJ1XlUkeij4BiHHEUTdM+DdPJ6qjefVd19y9EYbspkMig3uqzvVx34h8lAGY2ASkSEr0r9aTWVE00L3JEsl7oIuktx4clpoM1Uoaj6xxip/owo1/Ngao8ISuUaEj529Gkvp4WHhqJf7WQ1JWARGuobthnlzl6kJBEiikXExlZ6nrt7pxmulMp6DKbRBzKL76PfeCsKxDd/VEqyJHMHDY/e8I+OCc0DPYTTtv0I+YzSQZv/riF35IT0rc3RgfHiM5rVNhdGmh6NppvQiuSQhWSr2jOcQeym8CxZdhvX+sMDSI78LxkIpiIR4ohpUw7BQswLC+8lfyUXP1xEEVo2FG9Pbo2pxASbtLwOJhAW97T5xqIoj0QyvWBlhyng0buzEIJ9pjYaJ+7qtXElSFEzWHcF5v+uYXVqaXLKYniOcxFjj28c/X9mtVn75NvpmRSz0kel7RdAFeb5/FBLFSELCGjiNofIti85gviWLH1WI5DT0wgRtMacfMB0dOV1Md1ojonhHQgnBBI/nDgeWZDQlkdRoaFN93+tcb7DFlzL/LmIZzlBYO+PLivPiH05oqUARMeMyTYEL9I4ZnQZRhLMrpI/rDSVVNm8Dhlu9E3e3i+SbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(36756003)(186003)(38350700002)(38100700002)(6916009)(478600001)(6666004)(16526019)(956004)(86362001)(26005)(2906002)(2616005)(66476007)(52116002)(5660300002)(7696005)(6486002)(316002)(8676002)(83380400001)(4326008)(8936002)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Fxd4TMWFCh6P3XrKOlDUy/WHkBxGlfpruupYfD/qC105xZsxPAgHcFWggTd/?=
 =?us-ascii?Q?uw74RgM0N1j7Hm7ZNoGqyT6W+hOW7ZfC4+PgvDZrKm/FALp07wxp4oZzhHNk?=
 =?us-ascii?Q?S8OcvKQCR0cL6M8ljNHELsyF8P7Wvm9b7zb+Qip4i3ptbpSCRXkAJsmMSYFK?=
 =?us-ascii?Q?RLJKjUJ5CX31VnOsif2DrjZIOIcoTlg/g6F+nDqDq819K6pVSETF6lnXosFa?=
 =?us-ascii?Q?htBnymC4XnxMat8b9vYDy7coIKhLFOSjArDBoBOjB2mjwN+KCU53XKExR0IO?=
 =?us-ascii?Q?jrwDIPE+PkSq7U6v0szp1ElFubMhRvnVYdmEhsHmlCjYrRsJvgCS8Jy+mv5G?=
 =?us-ascii?Q?IBKCLHP9WDS7xW1WWF7VoUuN6ns99pekJ5W+ohlLCGDDak/xsZREaLY6tUQk?=
 =?us-ascii?Q?ABdNF7nHV+Egxf/hiqW9qCQ8VGuv+WzJZ9gvk+1dGeWXzZztZumhIcuwPSPK?=
 =?us-ascii?Q?ipUA9GpYK2HZi5iAID7Ps2NZTm588FWwCFD87MZxwFbv2esEpb6KwmjjhGJR?=
 =?us-ascii?Q?6hDjYEDmsvbAMMsZ7Q7VeVKGZZYPGC17cyJ4Ocz2k8CmDOKDCPknx/cxWYHO?=
 =?us-ascii?Q?B1WHZxOzmGcT1g09bl2WYv9/dA46zj8rSFBB4lCfDXywTKKZSN6fe5HDgkyB?=
 =?us-ascii?Q?ySEd0BDtVfH5oI4t1xrffn+7qMHKFJfXb1drZXcNzP/EXvEajXjfxOY1i0an?=
 =?us-ascii?Q?RLUj3gDKDaa0yUUHXX/2WEphbNNwT79v6B/fYPo5d6UdWt3xEv5/zlCpY0mm?=
 =?us-ascii?Q?nMiJfEtnGUMxVuF6Tijy5YcNLP+jgWDI/lhJvbCpWMhu4DH6EoWSIMvvuNb+?=
 =?us-ascii?Q?Ia0z1elzPFGo6NIXiLSYqAbJiuRP58guq7dp7wbOXfoHGwDRpjARUhP7cOUK?=
 =?us-ascii?Q?xSo45GQf1u52NT92T/lj+/uX2r8iSALzt2+EGeGy7gQZ3FFsVPRZcRUsOv3K?=
 =?us-ascii?Q?Z5DGCssMH28WJAalZJwyKfSfXY2oBIU878LOKaoqKsavR4kQNgOjwaRXLLW/?=
 =?us-ascii?Q?3vHGBfHzWspFezW7KMRMHwMobNWHdzXfKp4IDFIb6QRaEhJbLxUWR8rlGhnQ?=
 =?us-ascii?Q?BRa78tcMP6O4w8aM1bgDeuWZcm92kA7mhqqrryxS6o/V77VK2PNX+x0OModK?=
 =?us-ascii?Q?1d5U/w9DVYK1HaIat1lpW9+fGvVC9RNwKyVbO0qATYF3VeaJ4tuhvSrCzh4+?=
 =?us-ascii?Q?Lhkglmk8Vb0kvmlM4d6UQF+2P1IsNGnAfrrfZ/KHzAP3vH0hrw7aRs2shrv1?=
 =?us-ascii?Q?RnKZ38T4alU8X3gDiPjOgMfg+q5kUTSukBXnomGf0K+a/W3icKLJ6KCJ9cdn?=
 =?us-ascii?Q?Rc4qGq5u04PpcLdGb+PuHNFL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2439b1-a4dd-4002-2ad5-08d91a0f385f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 15:11:32.4237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Q/R4cg6hDKwf30uL9kBANeo/vj8P5/XNUiL00kF08MjcwGM5+rtUQt9Ter0RvqS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4910
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

Add cancel_delayed_work_sync before set power gating state
to avoid race condition issue when power gating.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 0c1beef..6c5c083 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -230,10 +230,27 @@ static int vcn_v1_0_hw_init(void *handle)
 static int vcn_v1_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_ring *ring;
+	int i;
+
+	ring = &adev->vcn.inst->ring_dec;
+	ring->sched.ready = false;
+
+	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		ring = &adev->vcn.inst->ring_enc[i];
+		ring->sched.ready = false;
+	}
+
+	ring = &adev->jpeg.inst->ring_dec;
+	ring->sched.ready = false;
+
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		RREG32_SOC15(VCN, 0, mmUVD_STATUS))
+		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
 		vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+	}
 
 	return 0;
 }
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
