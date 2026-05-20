Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B3ACD4F3D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 17:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64ED210E190;
	Wed, 20 May 2026 17:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fwbSGydC";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012005.outbound.protection.outlook.com
 [40.93.195.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6702110E190
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 17:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9rVWPBCjrT8zS7IbF/aP/DidbY8eLLBJAcmSJnbTL7Nb52eLJP2FT3XMgVvoYPxQ/PjiQi7M8s96vAPLdbEJvhime7Xe14EukL49YfdPkFKwxSYooToT/yrBYHKZBReG0miqGu6mUVpgy17h8imp3Vdz4HWd91s+EQNQAjMD9CuWAKcItysngLGG5W/N9kh7HTtfVfAP9oiZRG/+ZheRuWEDLza6HsKca7bfCk7mhKP451AQwpp3FvMhghY0QaDxpgYntTx8zxWa2jyQ7HBWuKLUVC/AoPStlqskXMMhcGo5zF/Yogp7Yqz4zREcqnoaXKYFqjaBYnHE2Hg8y33hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p14e2kuKiRmYVXZ4qTSBFB9Pby6UR3o5CnvVBiRJql0=;
 b=meYupcr8pT9KzAg6L5YB06rKhx/XEZ+8KhJhQX3+nWXF2t9DmeHezTIRAoW0tBJkmNq9/juiGiF5Qzd36+4+sCv4NRjVTb2ighFK+OIvoBRN4dCmf8q/uPJJrwHa5NEGKLlT4BmFrrS2HndP0R8ZOimAn+qeZXXYPVGGeJzALh1aaI8/yU4NQQYfJpPrGBuEx5avS5zLABCgPpM2fcrsnbgqoucDbv07LG6a8EcaNKqphxfTw4BAOAsiVOEK9VV7oX+S79pweh9tm5s6f0YeR8nRofGEtHckzblbKIeJmb7286F/+DlQf0Oc5FL5lCpfKrn7az4bE8VmfJH0XC5a1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p14e2kuKiRmYVXZ4qTSBFB9Pby6UR3o5CnvVBiRJql0=;
 b=fwbSGydCy8bh6yW42lgZGIWey+VKF1G5hW0hSp5ABUoqq7yW0dIm3GoIRxTdZkzzfKN33YIHwlVeB9/dfppOgr9qb0uPUp0Kja8Hsytx3pSGSfAEYYFPuIq07kbIdYWluQJO2uk5P00Cfni+xbM2/spqRCQVtvoZHEakg52eHTU=
Received: from CY5PR17CA0016.namprd17.prod.outlook.com (2603:10b6:930:17::15)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 17:02:41 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:930:17:cafe::4d) by CY5PR17CA0016.outlook.office365.com
 (2603:10b6:930:17::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 17:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 17:02:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 12:02:35 -0500
Received: from [10.254.93.104] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 20 May 2026 12:02:34 -0500
Message-ID: <fbdfa69c-0c51-4f4a-ac4c-97b376e3cef0@amd.com>
Date: Wed, 20 May 2026 13:02:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] Revert "drm/amd/display: Restore 5s vbl offdelay
 for NV3x+ DGPUs"
To: Mario Limonciello <mario.limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Aurabindo.Pillai@amd.com>,
 <wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
 <michel.daenzer@mailbox.org>, <alexander.deucher@amd.com>
References: <20260519220529.202096-1-sunpeng.li@amd.com>
 <20260519220529.202096-2-sunpeng.li@amd.com>
 <67b8b972-5b1f-4de5-871d-a9b65c2e5279@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <67b8b972-5b1f-4de5-871d-a9b65c2e5279@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de648e3-ef83-48d5-f345-08deb6919a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|30052699003|376014|32650700020|1800799024|36860700016|42112799006|13003099007|56012099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: YzujYyEPvLZ9Mcr+kSqbapnp+HDR7aUEzwQvKLFuqV8JS9Tk2xA/d6qVzM9CVvmt7SxH4dw6R3GNOFih4xWZ2FQM+3YJ7EeP/zUj4shYfX/PUDcP+TD0JhtygEpAnY/O7pV1uFzgDSRJpmkICudK6OHAUwZkxfFuYzSRYRaR8a/sPiecHt/XM93OOajpnbvdJ3x4fxwGHYCnUGL3TKZ7CwKD9XXnb6tXNHpHy5ciLpNcsuyzISrLzrnYvTPoDlrec0N8RHFgdpqh509fG/4AjPmo6EvRTeh8xH82gPjcdqCS8SPSxrUgA7F/xu4tGxQVz12q9CWTFVmNrd8Rv6h+kwruFLDZKBe4/J59SEdviaMBi45Z7m/ohr8uJE4pXTE9hfUgFlgfL3NHQVZDQWkQZjwUiDqZ++/lUOHfrWtyC1GA7ImAh6SFyom9xcIFPqGD8cdiz0uCL+pLC3oYavPZ3dA4KHplOM7KHWlCLzmKh1DTyHSFSMgan9NmVqSSkjOPwX4f+K2s+V8RLmCjky/5u5BjTlIBoDk0gMiJKwQ/jhLicohRfdiMJMP+dzSlnAf6chTZjo1/TLwD7JndJoW3sfutou+Nbvm8qtaKkZoKqO/wCevELxS4ua0ouGewsTuosTwSa4ghzzAnf6+SEb/wa3NOomT91LHYsgLPkz/gOLibB8eeTZu+VyqCNHXVeEiC20QJFaP6gdYJW0zRfrrckZyL4qhWNnCfwzV/1EiMWXo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(30052699003)(376014)(32650700020)(1800799024)(36860700016)(42112799006)(13003099007)(56012099003)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P9ZnWIfdwYXc1rZNMUwGpYcEXIF8FEa6Pyd3tdhMxyO59db7KocO5FVJww0x25HoeQ1yTXUQn9HyTTDGw0s6CiFAocX269BexEZB7sXh03Ly5JU4u94sQDwzLhV8Nd1EHo+MDciA+WTerJNp86ZmOpNC15V94d03uDMSIQeGURMIh8wCLtHiLVD7RVFcEdTWq3duaCeFPSrBwD540yv2DjSevCdwib46uqcRGjNfZ/h0GhsyEDB1fwPgpEuk6Vy2eL/TZynljCUyaevQo+RC+v6B8ZDmh0BN6QRG5Eu098le7xH1ji3LuskfqZEcZNjoiGm9Ng1yaxLHgJM0j7UcCqk0JTO9p4tBIZRJtOZWjrjNjeST9yJqquEVKtsJOHIdeyLzdE3nDV3+tK+ywGEWg7lAv0Xs4FacIiBAUlxgovKevBQR/nCoDyyM/df+k/02
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 17:02:40.6582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de648e3-ef83-48d5-f345-08deb6919a38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980
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



On 2026-05-19 18:18, Mario Limonciello wrote:
> 
> 
> On 5/19/26 17:04, sunpeng.li@amd.com wrote:
>> From: Leo Li <sunpeng.li@amd.com>
>>
>> Now that proper fixes have been found, let's revert this workaround.
>>
>> This reverts commit 751414c12388ff2b475e15c15d3c817dcf563635.
>>
>> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> 
> Unless it "actively" makese the problem worse - could this be the last patch in the series instead of the first?  This will make things cleaner when it comes to backporting.  IE backport the fixes, "then" revert the W/A.

It doesn't make the problem worse, but we do want to revert it since it negatively impacts power.
I'll reorder this to be the last patch when merging.

Thanks,
Leo

> 
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++---------------
>>   1 file changed, 3 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 4670252ede244..be9c4e094d8ec 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -9518,21 +9518,9 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
>>       if (acrtc_state) {
>>           timing = &acrtc_state->stream->timing;
>>   -        if (amdgpu_ip_version(adev, DCE_HWIP, 0) >=
>> -              IP_VERSION(3, 2, 0) &&
>> -              !(adev->flags & AMD_IS_APU)) {
>> -            /*
>> -             * DGPUs NV3x and newer that support idle optimizations
>> -             * experience intermittent flip-done timeouts on cursor
>> -             * updates. Restore 5s offdelay behavior for now.
>> -             *
>> -             * Discussion on the issue:
>> -             * https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
>> -             */
>> -            config.offdelay_ms = 5000;
>> -            config.disable_immediate = false;
>> -        } else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
>> -                 IP_VERSION(3, 5, 0)) {
>> +        if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
>> +               IP_VERSION(3, 5, 0) ||
>> +               !(adev->flags & AMD_IS_APU)) {
>>               /*
>>                * Older HW and DGPU have issues with instant off;
>>                * use a 2 frame offdelay.
> 

