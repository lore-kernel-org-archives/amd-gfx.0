Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15123C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 05:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B98E22B49
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 05:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B98E22B49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF46E6E823;
	Tue, 19 Jan 2021 05:51:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BEC66E827
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 05:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QE8zUIUlRhL+g4+fJmYtR2gU3V+mise1gAy/zKojeSb+EFttkZAr23fcpnrTp7g1kHExZ+zMoL6ugHYougV2bUM+bCihq1XYLBDSSgGMMe2St8lY0YPbJBZtynP6A19Ns+7hPH+A8Vx4U+sbpAMBjamr78ADRiViKV/3XuJue04PKfzKxXBJmMKb3yIgONOIXUSt+fbzuQax15dO4fYRFUK1rGOZW3NspzEwnK9LMNSR3CBJCpTbsyL7EYLrUQqdGQSRV/MMmmSOD5b/JOWd4MhyUoD6gL2GtKU+7YwEkVmfVXCOPtQIJ/IxAzHmrk+g6VYWZAX5itktGqZ3C99pGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRaTeS54JGdU3nZymIPiROe2s1dJQsgTNbB5HmxjYa4=;
 b=eTZyKSdvyo1h0nHiBH5hAQR8GMusvdyul8qhzlnNCnmKFPufB6u2EZviDDFTXNPLy9soQN55KWVdZ9mEChjnklciUOzhMkaSd9ngHC3OT4Xh2QZZaDraU1qqKjAa3YN6X7TA4YNarDwMNp8VbT2OAH7c5f6lwtbI+/tHGo89f5PcN6FQGqDc+Vwj9FYQ1GCZTpa9D4c/1KiJVqdfrybI9lNAeCgs+91RcKx/uI5djbpw/kCWj2C2+iNTZJP1QX2K5CAiTZGQd21RY+JrjEXBI+QKXCN040OQEbW0ChEHFHhmIUF/SVIkSjzLRfdeQWiICrbxJJFGGWoF39PQgx+q9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRaTeS54JGdU3nZymIPiROe2s1dJQsgTNbB5HmxjYa4=;
 b=b5gJOsHmA3Klm4YopuaFY2HaAYF1fCD9obVaZgGspD5BoOMDybTEedGI91Z3Tyy+Y2MHZk40dwVrh6xXlIlAMaRlgXgzIJiLFfITghFIONSTvCUEkFgF4a948kTYcNj91nAo4kPWij7qtK37fOWAhPGUQjFvBA8jnirCc9GYz8k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB2492.namprd12.prod.outlook.com (2603:10b6:300:e8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Tue, 19 Jan
 2021 05:51:56 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 05:51:56 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: remove gpu info firmware of green sardine
Date: Tue, 19 Jan 2021 13:51:35 +0800
Message-Id: <20210119055135.70134-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0052.apcprd04.prod.outlook.com
 (2603:1096:202:14::20) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HK2PR04CA0052.apcprd04.prod.outlook.com (2603:1096:202:14::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Tue, 19 Jan 2021 05:51:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b7f9336-9835-4d48-5367-08d8bc3e5420
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2492:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2492AC97197EEB2E61B7F822ECA30@MWHPR1201MB2492.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPmCzL8Ym5IXvLmbLumwsGpyZIhsqQtaDq8YzgTCuQg6eDm/7cZpEURQvYXY+amvTVKZy+XBgoLPwUiBliPfkMDW4/r0jb3zRMS+RxzR6O1LxgNEaFmdbdXjPZu4xMCJv21XVFU3ujMAxjryFg5GDBEz/wSQ5IVYriXbu3e7bP7Rh6VppkeqYZ2s3tczIAwUeDxxMgHbeRA9Dy+NeuyoTuYMRjxwy4Et78XIgrNHJCRxptS0gGo51w6nwzvxp0NWNxDDqonVUCiqUe2oNLTd0vohgDR3O2FrOa7Ul7cMd5jfmorwOggGp+ZXG3Pm5bTIGoCnmtKckC5187t0j64gLrD3I2s6YM3JUyD2NPF3pVgUGv9G2CjIJnBtsPqvCJ//IbhCk/Ja3pu6y9U8zjZGzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(7696005)(83380400001)(316002)(6666004)(5660300002)(52116002)(4326008)(2906002)(6486002)(8676002)(54906003)(6916009)(16526019)(186003)(26005)(66946007)(956004)(478600001)(2616005)(36756003)(8936002)(86362001)(66476007)(1076003)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S+DPYLwx7AKKG+a1wNrgj/U1WJ7moCmfh8htO4xYDQ+xdPUm2QVc0hknJHhV?=
 =?us-ascii?Q?fK8bOsNtoQPSaY9YfWpyw0SntUjryfOJGYvNy3f2RKIcBPO6Yv7uaw6BiE4S?=
 =?us-ascii?Q?pop6cNF/VutzubV8KGVKIoZImQ+oHMDSqbGRCHO17aP9pVBI3IyAajynBxqI?=
 =?us-ascii?Q?1EAZMdnaV1GqDKsSmUyuSZuAdghphu7Qtl7PpaWewBi5/v9+sXdZ4pKsXnim?=
 =?us-ascii?Q?kwYdpRD2pSuSvGFgCbIZ7IwXPikf12Ta38LqT872zlCT3RZDUO7xOHCXePB6?=
 =?us-ascii?Q?hjR8FQ86xeeYswWFsJ5CYxV9lrzJ6RgVH8VpSS+HEhUnutJ0q6Y7IiZYpT9+?=
 =?us-ascii?Q?1WTK2JWZiCzoaJhFLZ1bAMbSOiIhIhXfPk9aSRnq2t1dTfMcBiCeyABKIo/l?=
 =?us-ascii?Q?3C8mmlXQjXF8p0r8wD8ZywbyW/FhLn6lKE3/NjebIPYrEp1A3DA8l+v5/nZu?=
 =?us-ascii?Q?gamH/4zCIn1tLbD0knPZEZlxkIa6qV/XEcFnOZEXzQ8p2onOJT1knElaY0lF?=
 =?us-ascii?Q?8Eg5B5LAmFUvlLwKoiM7CnZvmsBlzoAlKGuu9sNlTX0cnsIgJfEHN3u15BuF?=
 =?us-ascii?Q?MPbElVPkKJo1wSylYvB1IScoiYuV1FK2UsVACG/NptmU1gohDXflcAzjd7TC?=
 =?us-ascii?Q?Bo0flbovynCouaWWxixx3J2VuSdAr/ykTT/nt9wUjvVezaSP/7x7irDXblTY?=
 =?us-ascii?Q?fDhPi6+RJcyUqs3fXZFSWXNnb4jIajYjNbl2fj038n9LsGR3aUQE9jkBVslB?=
 =?us-ascii?Q?1vRarclgXKh34rq83iR8PmRls7P3SLInXp0DlBx5tljmXW7rJUSuIcEhGQCO?=
 =?us-ascii?Q?E3Pf6yf6OCuIrDazPm3cQSGTe0wzzvls1uRLxEy3YWnGwu3p1ZMYyEUWuPnJ?=
 =?us-ascii?Q?hWmHJFXy8rx5g4qiB07enN9iDVZ7QrW7VUdD1O//jiF4t56us/mrAtDnePxR?=
 =?us-ascii?Q?5UyeH0Hj7k+6N0877BnIo01wd5RU7jB9v45ZogOV+rXkBXf7a3a1SkNIyzNc?=
 =?us-ascii?Q?Jg/8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7f9336-9835-4d48-5367-08d8bc3e5420
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 05:51:56.2652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29qZXsxNR/ehS9JgMk/sbzDAGkdXbK2XkjTlCuIQ3u+iXohzq0hAUv6F/m3zf61U2funU7x1wj7jz4qkfIwp+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2492
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <prike.liang@amd.com>,
 Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The ip discovery is supported on green sardine, it doesn't need gpu info
firmware anymore.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4d434803fb49..f1a426d8861d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -81,7 +81,6 @@ MODULE_FIRMWARE("amdgpu/navi10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi14_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/vangogh_gpu_info.bin");
-MODULE_FIRMWARE("amdgpu/green_sardine_gpu_info.bin");
 
 #define AMDGPU_RESUME_MS		2000
 
@@ -1825,7 +1824,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 		if (adev->apu_flags & AMD_APU_IS_RENOIR)
 			chip_name = "renoir";
 		else
-			chip_name = "green_sardine";
+			return 0;
 		break;
 	case CHIP_NAVI10:
 		chip_name = "navi10";
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
