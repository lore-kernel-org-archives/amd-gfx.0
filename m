Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA040C43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A447864E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A447864E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C030D6EB4D;
	Wed, 24 Feb 2021 22:20:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB20C6EB3B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VX6EPwOQHOKGpnOdwVXdXCG9X1msQ7ru+JpQ4MYVHU0XTLkMGyGmkzJ2ARlFizzh6sBZcAfAGYpBWz6v19jIvtE6rHfxtjBNhizIqBtOFgI6z7unoV/l1mMrvgGtJ2ugQfG1YXuoPxDtMfkwLsKS/sRfZW222Qrd+t8zzhUaDBxyxdaTIdfg3/EIY41CUOtWl2MWfT8RZJkoQNDQXOjclM4X5fA1624I6KW7CaWFWeTiFCdzxr1TgYZBgjtyb7XGjC1zZFr/PXf+hdFaTnCFTK+VMB4Ivwain+CvJ2Doeso6TFK+mcKwANU+yqBcGc11CSjzpytsjuyrN7FqZ79v9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txGDpLSRGWp71FA/GGnVk+b3brfoCW3C3xtU+Z/ugvM=;
 b=e6IZBG+Q7gnuGrHKWV1hv7jZUecOenHAkqRgJobQlbMwi3eGp243x0+GDYuY3wT18oeTbHK1xervIpFrupkoDp1eMNXmd2TFwvrJveLsGzpGi02+wop6fXmk1rB9UChdmLW4/nRxS9EpHX+jivZnprwc/+eBVjpKv6Ms4Kf3m7T8FGw63vAQVtyD75UeYSHX9ZI8S2qVR8JA+eX2oTnnKeduqfpNS16C2lin1usHSntck4ctCDAdlGBvm1l74Z8n/s7fnoCkL+prqvtmeCbbgefRrrDWd8GHT2Vuo2N/5TBI+C90S8TzmIjeVMP0LoSfIyiQNAJYzTr5kXXpgPGBUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txGDpLSRGWp71FA/GGnVk+b3brfoCW3C3xtU+Z/ugvM=;
 b=nAhJCL2zHldOlIuVZB8lRxZmWMzaAC33J2Fbia/WsHHCUZU5wL0qpm65UYz8sQNuw+CssddoAvWtEWJXp3Ur3tT0NuU8hKgjdkjVnqPlR1n7CNYApI2vqqqWFHSLZW8uZ+7ddKuf6ajFLQtSPvRJoEZOiX14IlNj0xrg9XllnQE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:25 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 058/159] drm/amdgpu: comments out vcn/jpeg ip blocks for
 aldebaran
Date: Wed, 24 Feb 2021 17:17:18 -0500
Message-Id: <20210224221859.3068810-51-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d556cb37-6d14-4af6-ae0a-08d8d9125322
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175B71906814C9CAE0EC363F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9SXunRYZ3Y39KnaOq4BALJtqh4r3gnktuOgIhTExpAY7+JtoY+glrfUnYOAsq70PORwcmoxryzElIC/Xh8ChSYCyg0BZ0r6WXVL87eWSzFBFqk2PDqaymehBaEKPyZeEBoMHpX8sJF0QgHdoIaxvRDoE1OB7UtKKo9+0LI03CqFmy7jIeKRcUtQtw7Xp7cuyCafFGslgQIQii2RfNCGL8PMLFCcSLPVGA3S6ncFGOmrh11tc2Wf5gGnEn2X9sxfZB+Ey3T05LcgEQMhEuR4nqiwOAwyldiVhOPXFNUmhTwB0qMhvnn6f7w2URNdXgeJkoEoXPA4XiGil1s+r3BqTdpRFIJzV3Uw9HsGTvKnkkHZ3FLmit4mcegZ9jteriDO0MoJkgeQVYnGkuMEYP9Ys+oMvF2Am4scwDb9ERqylrwHQYymfJYc7FFTKgKloRFSYtLjNohpdIbqJ7ARKMGIRELDzHwr8AwRodrIQBKp9yVoAfWuMbVOotiuC0vjecTEy0AQGHvqXp9K8hx2S6gA2440dsOwfveaNntvWnJfHAMfsvRR54jBtTyLbCOzZaliqssx6r/2wxAaxHr9LloCe0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pSJlllF7J0DYPELynX/5cu+mrwAQ8WTsmiCkiMtQrUD76aMduWxSnz/W1tFG?=
 =?us-ascii?Q?aeUslMzK491SE0A3bd1Rfmm3iy2+fv4JV//XspBSdZFzoPJWopdlz8YeANV/?=
 =?us-ascii?Q?3g3dKvaxy8IRf2ft4LfIRwb3v4ZKj8c6ctlEzT78oSBoEY2/Qt01Vsv9nJwE?=
 =?us-ascii?Q?Vq6lX5oskXJldLIA9LrUBdRib6L5nY6oMpHUv5sBPEGpoptQdt6tISmcU0a4?=
 =?us-ascii?Q?F0ouTBexiBq+6BfFAfIxExdPe4r/L2yDVJ7KQzHnIXuaKhcM21VY9QZNfTlL?=
 =?us-ascii?Q?dfQQTWmjFbpxH7DgBHNSl6bhWDfId+4UkDtivGWjgXytusd0lm2nxiISPUl0?=
 =?us-ascii?Q?2pPMc3fvWGsjzPCbldGfAofN2DAuyWVesshgFVbVHUflEJEGnwXAzlQnaGlc?=
 =?us-ascii?Q?fS4lBJUwJguIOc/7jsQWJPYHqee7C+QTvSjy3Zyprtt06rwrjfBr9od1E/Lo?=
 =?us-ascii?Q?CfFgUVdNmO0ED73MHldKbLNi0w3bWUn1AISqtSMTxZf8BPC4mD82aFgkW7b8?=
 =?us-ascii?Q?+5QqCE9K8p4AHIDv25GVvtI77vDq6Fi9J+3mzu8pUoYN3ho2Ziigkx+7K9Xg?=
 =?us-ascii?Q?mMlybpwEypitz8lJej3guSoqmNW/FvNVbdfkqAZWZ2uQJE89nwCkri9XYXow?=
 =?us-ascii?Q?486TKgIFMcgLCGRJMK+5o+q6TNwrZI/PqkmLj6o2ZVwi0qfrhiNHFbOsHKz5?=
 =?us-ascii?Q?HynYWi1GDXZjrAeAxI10L0X1rbYgvlx+ZTOY/a+7LRIDQC/TKEPVxD5Xlnqk?=
 =?us-ascii?Q?1xLFpxunQD0h+0OlC4HPVvEdikT82Uw3N3sSZnqmBH9RwGCL1tql/asK7qIJ?=
 =?us-ascii?Q?kxXVPCrzx8BjvVrYoHnIT7clDXYXKsIspXlogWLbFGhnaZq6yOjL2Uttx0iC?=
 =?us-ascii?Q?X2CYl8ZMVeTyQsnErTt3x29UPT1uHrZorUp4SmTgiNnrfJ408FIKer3NsjGf?=
 =?us-ascii?Q?CJWAeGLoZFtuJMu4pfH9qk5b/nR3pGpIvbz4dHW8ry7U7PZht9La9ozjChks?=
 =?us-ascii?Q?8O7uAvaP4SvWoFTzIG5yKJ0Xrclq6OFQrLJiy1/dTajK2Ucn44V2a43jVWz7?=
 =?us-ascii?Q?0f5+hqoEaFVFbnZIaTcJ8UklI7YYD8BzhrPS6aOw9Y+bLYG8ZxFuTTeFDqA1?=
 =?us-ascii?Q?FxRbkSqOytZ+hBJcdUZmuoYjrjHmALW+a5+n4az1Z8JMhJPu6OF2Pqy30SGm?=
 =?us-ascii?Q?e4JmD4DwfJDKRHspgJp9GcGK6OFPo578iZmaJhLC4IrYoZLTP7ux3FjAK8hN?=
 =?us-ascii?Q?WlvMLzIQ5OaKECOh+tkgQzXSh1wG0afVZhc+XJpIRhxxdbRF3gS/4M1stsX1?=
 =?us-ascii?Q?nXSmqnruwL5YQASapKnsfTMa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d556cb37-6d14-4af6-ae0a-08d8d9125322
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:00.2436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMCsovprxQd/O9jVvv9Lx5MINHG/qX5oQM0DxqEA4X3m/Sl2B62VdUrg0cYn+mJ6sdAJDs1Jm5azOApdjpBrfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 James Zhu <James.Zhu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

vcn fw front door loading is not functional. comments
out vcn/jpeg ip blocks so people can load amdgpu driver
without specify ip_mask module parameter.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 67bfeecf62f9..14c6a27b2934 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -849,8 +849,8 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
 
-		amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
-		amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
+		/*amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
+		amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);*/
 		break;
 	default:
 		return -EINVAL;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
