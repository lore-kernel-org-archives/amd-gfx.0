Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A97BC98302
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 18:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C3110E776;
	Tue, 22 Sep 2026 18:10:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0AWYCU1g";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013026.outbound.protection.outlook.com
 [40.93.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF49B10E776
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 18:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUxOTh0mjbFkjqQ2qRfowOuh7YKjDp0ydS2N0kxav5FqzLIQE7fHdyHHvkLexyA7JRN7ouJLrMymA4WyzUBqE8b9rAwoq9OeIv4VrcJhy8APjY1xGAhzVGbUH7Ex6u2aYCrUXiSURkCuGgi7XG6yPRGwquXry4wuXXPPJpCAeAGmY73ih0F5erhTKb1Gq3pJjeHdlL9VO84JAtkNX145Tl7OyhNOuYQKFhfUTPULFWFdgXhdxmig+8IQCYmXrTFmWjZigjLD7i4W9bcwLBnDkDzBn387RS8luehCbudU8IajM4VM88xlgnbQE8ZQg58VhcgUugpqSn10k4VOc9hmeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsjac3BZ/Ykr7mInFerPi2Ridlqp4TpunF+7uQag+dk=;
 b=QklOh5z/qSTjVb84wkAgEl+nLpUT0zhlcvDH3/AT0sLnTPlRTn0J3oH0QEsHDMT7Gpfn9B1YbXvxlD8mqE9eKscWtRL8QOgV6SUpm3n2MnxHykO1WuUTZNTT6VyvaQvds1eu+d6aKtk8l1aNY0U+pK0WV9xi6uYTne8xuxNcmE//Ipncxj/uCkvZKGwo01deUwUytGVg2GH7qZ9K+d9QPtHmsQFwpnZhYSzkeS2xcGVPb/6+PEUDFYUCq9OaWGysisLGemMKDQU42ZTiT7GhAo0bhc7vm10zKpb5QoGmYbpTISjV6taqaeswL3zbtq1bIf7qxkxJ+q2Um6PvEMadbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.dev smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsjac3BZ/Ykr7mInFerPi2Ridlqp4TpunF+7uQag+dk=;
 b=0AWYCU1goiMrmzgSbGd3W82whRc+V3sbA68H9k+1+qgrW5/WRhzwlg0/2sku3ezK81QgcdJWUMI3S8hEOCc4q8TvOzBUr3FASTsTcbLsV70USCLHHkHXUVE99Jmxl51/E0HoQA7DxOWos2D6KmibK6pj52+kekD637tgFRPe6Uo=
Received: from BN9PR03CA0708.namprd03.prod.outlook.com (2603:10b6:408:ef::23)
 by LV1PR12MB999327.namprd12.prod.outlook.com (2603:10b6:408:3f8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 18:10:27 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::48) by BN9PR03CA0708.outlook.office365.com
 (2603:10b6:408:ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Tue,
 22 Sep 2026 18:10:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 18:10:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 13:10:26 -0500
Received: from [10.254.92.51] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 13:10:26 -0500
Message-ID: <bbb92d7b-8986-4765-b9ae-fb7595cd7410@amd.com>
Date: Tue, 22 Sep 2026 14:10:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: only allow freesync on a VRR_ENABLED crtc
To: Matthew Schwartz <matthew.schwartz@linux.dev>, George Zhang
 <george.zhang@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Fangzhi Zuo <jerry.zuo@amd.com>
References: <20260909195906.3584191-1-matthew.schwartz@linux.dev>
 <2dff79db-bfa9-48ce-94c6-c467a85c8b8e@amd.com>
 <6e07ec9f-9423-475c-8751-289ff11a40cb@linux.dev>
 <c50780fe-70dc-4ecd-81df-90a6f7fa37d9@amd.com>
 <a2a345da-a199-48f8-8461-ebd298aa252a@linux.dev>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <a2a345da-a199-48f8-8461-ebd298aa252a@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|LV1PR12MB999327:EE_
X-MS-Office365-Filtering-Correlation-Id: 4446a464-d97a-4a7b-9286-08df18d4c777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|42112799006|82310400026|5023799004|11063799006|56012099006|4143699003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Qptmv2u2OC3RsnIt227zUH0CxW6Dxa06IJfj0hXqBtU1pIf1aEnNJpKBKbzAFqvXRdAlFI0eegnufBcN6E/fB9VCcZ9+d40OHE/ieEapjTSb/k9KbUWCY41iPJ2OWRRziSNHPvqapX5b54pDaMwO1usWviU3a55yeS4K7Alm8qiC/xlY1NAzVWgK/JhF0VRUHiglSH7UCXqKSWR5Hjp5nT5o+F1E4cGk7uqvuKDiuaUgrwNIdLj+S715xZj7TdKZwfYId3lWlx5o8W16Ue8Uur9at9T3t25UF0KeZE0bQ/wHtQCb+T293LqdD7rv8KzNQwXu954gSoM7KIVZEHenUeUeJ4BreNCL1u87Q5wS+dIKlHzz7zCxma0DmHv78UnbRIP2iElZ5qntKnYKg1dexW9UL4bXuy5Q4MOFYus9gUrkeyoVkGtYMtaZ6yaSJAKMn+DH+Az9f3eUPTASSsRfFKj21mtJCRU0eg18Bc3Afqm7FSUB32vc/QTMhv8i6x+4uljxzSTh+ZE5GtmQz1pvdj2V2MO0A0Xaee/HSj8sA7VamsNgJR51ZzaJFXQRHEe21+WEobNBCU19umcMpD0s2X4FQO/Bj/7utDiD37b9GfOjFlqutLx6iv4nFQMYpJ6mcrZwdw4fdMug8VS31AYuxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(42112799006)(82310400026)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dIsbzjvEHFPbQbGlJPQ4T8IBZ7PSR4oQSp2ho2aLi3ytuL4C44Y5KaZ0/10il7DsMtJxOj/e21cDqii+Lrny5t2isORJz9pJACHfV6hMPdMWHQxjvvTAAIhUVN7nHqEzpTZndDr8YjI8XfgtICcJNPDc6W7mVBw+xrNzPg5Ps+33hRQhsXYwab2GYkrOGl4zrAHkULNNbjHpcEmQwPnP0k4hYmr8ns4Nn3Tt5flGU4HyTdeJjdOMNZGhqaIs0j9s9mBIhUKOtNAu2sWDaLQb7n8HhOY/OE8hZH+d8iEjE2Hl9gxjipETCnDTPgADl/7+nqTnliJ0bh0mXp1sFAMye2snUuQlsp6S1vdQlgVVMsv6iDe0jun9ODZ5OzkolvNwZ/Xyquhuc3u+nssOkjIbyK6ESX61WLBrZiYvQI79ckSyl4iuYCOFgmBMLCjOv499
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 18:10:26.8095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4446a464-d97a-4a7b-9286-08df18d4c777
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999327
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



On 2026-09-22 14:04, Matthew Schwartz wrote:
> On 9/22/26 10:50 AM, Leo Li wrote:
>>
>>
>> On 2026-09-21 15:47, Matthew Schwartz wrote:
>>> Hi George,
>>>
>>> After updating to Linux 7.2.x, I noticed gamescope's frame limiter falling
>>> below the requested rate. The reproducer was a Navi 33 driving 4K120
>>> through a DP-HDMI PCON, with VRR disabled. A 40fps limit was producing
>>> roughly 37fps.
>>>
>>> Gamescope was pacing against the fixed 120Hz refresh interval, but we
>>> observed frame intervals stretching to around 9.34ms instead of 8.33ms.
>>> The OTG vtotal also increased from 2249 to 2521. This was enough to
>>> disrupt the limiter's pacing despite userspace leaving VRR_ENABLED=0.
>>
>> Hi Matt,
>>
>> I wonder if this has to do with re-introducing 2-frame vblank off for NV3+
>> DGPUs, which made it into 7.2:
>>
>> fba211b078d6 ("Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"")
>>
>> Since gamescope is only updating every 3rd frame, it's possible vblanks were
>> turned off during those two frames, signaling driver to enable idle optimizations.
>>
>> To test this idea, does bumping this line to something like 5 frames ((u64)50 *) help?
>> https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L3377
> 
> Tested this by reverting my own patch in the kernel and replacing it with this, and unfortunately the issue
> still reproduces here. In Hades 2, a 40FPS limit is locking to 37FPS erroneously.

Interesting... Maybe try reverting fba211b078d6 completely as well.

If that doesn't help, could you try isolating FPO by force disabling it (without applying this fix, of course)?
Set `disable_fpo_optimizations = true` in both dcn32_resource.c and dcn321_resource.c

- Leo

> 
> Matt
> 
>>
>> Thanks,
>> Leo 
>>>
>>> Tracing this led to allow_freesync remaining true for a VRR-capable
>>> sink even when the FreeSync state was inactive. That allowed FPO to
>>> stretch vblank around UCLK switches. The PCON whitelist change exposed
>>> this on our setup by making the sink eligible for that path.
>>>
>>> The intent is to keep the frame period fixed when userspace has
>>> disabled VRR, while retaining FPO eligibility when variable refresh is
>>> actually requested. With the patch, the original setup holds the
>>> requested 40fps again. I also tested VRR toggling on a Legion Go 2's
>>> internal eDP OLED panel and did not observe a regression.
>>>
>>> Thanks,
>>> Matt
>>
> 

