Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49C7C98302
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 17:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B31F10E1A9;
	Tue, 22 Sep 2026 17:50:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fZN7hGKa";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013044.outbound.protection.outlook.com
 [40.93.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D4010E1A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 17:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GesgBEnBPgdRXad8nfXqBFZvrUmiyq9d9TntF16FXJJnH9GNWBWDWwsDT/fKN6uufGj04JQ8nKU8SGlvkYPDemodU2YD1duT9N+k8BUlPXB7s2gxrbTrhrZbOxK6KExewTIb7/x8dMEniIMTj215DcbZahafcHV3VRVxVtKg+9B61NlU8SEtl46FJNgAwjinhX6Vgfakyapq8r8tY0zeo/cGIhAzeQd678kY6IKBg3rw+q+gqkjznE2xthO7YO7FQN78uogp2WLJp8TiRAkSCQW3oLdLPd5f247kwedunr57ZaSM+HwDX12MJurtI4opjo/CSAeNCe3PihNvFUKHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtLpoheh0CWMrxmV9iJ4AkcohYdw73eDDqDRmV6ueEY=;
 b=TRkt2QvTojXPLNHCY80Wv8EmKZHnM/eyfOFvCYll/gMOGctMN8TgBCz2E+6jlwLSuqqlmfxCyeJFig5+tYxEGv98I3wfC6z4lDFVFIqB88ohkQNF14sF4ZfvFd3IiBVBO2XeWVjg9DjAK9fomi/0JP578EzJ0m433FXcWCjQ+XfmE7X7OrxscaR0CkYvq2VkoF2atXiNK9+g1vMIDUxvAdsEz/JmK7bukDLYUY3EeQ/yNW9DI8yw+EQN4c4Azi33T6QSXYLVf0TPiN+LhRgm1XBD9I65ty6C4dj5Dl/qpc0L2zC8UwPRZ6E1zmFRHOcfpbu0tzGxkJlZBXcPkLkOzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.dev smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtLpoheh0CWMrxmV9iJ4AkcohYdw73eDDqDRmV6ueEY=;
 b=fZN7hGKaWdh1UBmiz3Ah7gM3LFXRAIFET41W6G14JP9DR4NNH223X1y5nY6CG+LtpCaMGy0+AEnm8UUe7CxA42caGFCHJZSUWNub+WXV10fYsy7VaDgVzPKHQOgWsGio5vSnST41WniSty/yM5LdzCZThg888Um8/n2yfsj8tmI=
Received: from BN9PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:fb::7)
 by CYXPR12MB9319.namprd12.prod.outlook.com (2603:10b6:930:e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 17:50:16 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::7b) by BN9PR03CA0032.outlook.office365.com
 (2603:10b6:408:fb::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 17:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 17:50:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 12:50:13 -0500
Received: from [10.254.92.51] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 12:50:12 -0500
Message-ID: <c50780fe-70dc-4ecd-81df-90a6f7fa37d9@amd.com>
Date: Tue, 22 Sep 2026 13:50:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: only allow freesync on a VRR_ENABLED crtc
To: Matthew Schwartz <matthew.schwartz@linux.dev>, George Zhang
 <george.zhang@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Fangzhi Zuo <jerry.zuo@amd.com>
References: <20260909195906.3584191-1-matthew.schwartz@linux.dev>
 <2dff79db-bfa9-48ce-94c6-c467a85c8b8e@amd.com>
 <6e07ec9f-9423-475c-8751-289ff11a40cb@linux.dev>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <6e07ec9f-9423-475c-8751-289ff11a40cb@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|CYXPR12MB9319:EE_
X-MS-Office365-Filtering-Correlation-Id: bddad483-d702-4864-e3a2-08df18d1f5b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|42112799006|1800799024|82310400026|6133799003|18002099003|22082099003|11063799006|56012099006|5023799004|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 9OE3h2YPBFZmDTw0uWFuoP/3Ldwt6EZYKVtwpe211nHGCy2tUKq8EFigAxL0zJDpiZprnwK8CoiI9sGshxkk0CLGqnnYBuEKDbhq54Qs565TVv7ToyhLXLzmmWZo/6mQoO9krLyUrGo9f7t07MnwH2Ekh29OZZqct+4Myu1TX1JmSPs+X6bZpaQeskE/bXDUtBolsMXQ5tx3cG9uKxD7f1VtMo1GvUJWvLTBhzGDK3hJyW3uI1dw9Cw7WfUEJJOhAdTw7FzVyE7EBmyAug0LEsSjePJnYCwyv+mJ3KNRB9p9VcL2OWDIrY89PDqCWWpxx9B41i4Q81MEwfS2+79k9InMR0M92uwEJn/z3aQC1QVdu9kd3f310rBF2HK1XXxW6lkl1hbh8IVdbXi0Ur4AVNL8WZ8ZLxClvWPLKwCx1t2/4+ztJXdKVdZCsDp4R4NeEA+cktjX6EGTcpj0wh7FYzdiyaUj0LxLrg2SYCnrzy9vVkpmmu/A0dx0G/Kg2e/WdoVk9Bm6oPV8idYxzcIfcvQhpBTkBaC48C9vRfHcflfH5oFZrAz7lI/jjxORRbGUvCculb/mNmwg0NeA8x/AFPIPlYBCKVE4NPWXWfUgVwkwmzuOQWhTznhCba4JRhaM0P6CjR9hDIungArChGAR3H9f7iVQJk8GjZYSpz5Xwug=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(42112799006)(1800799024)(82310400026)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(5023799004)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gk3C3VWdPdRoHuOhEHHKTh0iSzJEF3Z2YEr5kUeDv1xaTkKsuNTP8V7nobPtfXCNS7oQnK6PXKeHgAbjldZNp8wff3e6wdzstF57O4mH5/VC8HK/04YpPgGyQJasmmKqGelh0krwtVqU0EVSmcjXz94tstlQ4yUtgGetcvNq9q+hqnUkUK3c/eQREeHebwHg1oPQy/oUMyLemnDtljFs5Dw4QkZdxj5qYAyhO4ec/7ejl2eg0YV+3Sb46ZhpCRBW/TGLKyDOog4BdBP9tGeJe0ocK+qlpzjroDfZ5DA0Pl5hqaQzkcTk3pGDGXORW2G4r5/NtakhDYoctYuipjPq7nxOM3YbSh3kq4jxRCY+RwZcbNgkUaEOt6TNPVYQ4xFdDsm5xw+kAU0KdGcvBulCyOV6BabJH5jmvLB6hFdMKcFmRWvoIGu+EMCOI7bjX2RW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 17:50:15.8962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bddad483-d702-4864-e3a2-08df18d1f5b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9319
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2026-09-21 15:47, Matthew Schwartz wrote:
> Hi George,
> 
> After updating to Linux 7.2.x, I noticed gamescope's frame limiter falling
> below the requested rate. The reproducer was a Navi 33 driving 4K120
> through a DP-HDMI PCON, with VRR disabled. A 40fps limit was producing
> roughly 37fps.
> 
> Gamescope was pacing against the fixed 120Hz refresh interval, but we
> observed frame intervals stretching to around 9.34ms instead of 8.33ms.
> The OTG vtotal also increased from 2249 to 2521. This was enough to
> disrupt the limiter's pacing despite userspace leaving VRR_ENABLED=0.

Hi Matt,

I wonder if this has to do with re-introducing 2-frame vblank off for NV3+
DGPUs, which made it into 7.2:

fba211b078d6 ("Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"")

Since gamescope is only updating every 3rd frame, it's possible vblanks were
turned off during those two frames, signaling driver to enable idle optimizations.

To test this idea, does bumping this line to something like 5 frames ((u64)50 *) help?
https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L3377

Thanks,
Leo 
> 
> Tracing this led to allow_freesync remaining true for a VRR-capable
> sink even when the FreeSync state was inactive. That allowed FPO to
> stretch vblank around UCLK switches. The PCON whitelist change exposed
> this on our setup by making the sink eligible for that path.
> 
> The intent is to keep the frame period fixed when userspace has
> disabled VRR, while retaining FPO eligibility when variable refresh is
> actually requested. With the patch, the original setup holds the
> requested 40fps again. I also tested VRR toggling on a Legion Go 2's
> internal eDP OLED panel and did not observe a regression.
> 
> Thanks,
> Matt

