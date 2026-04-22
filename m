Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F70FA1FD6
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 17:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF3E810E9FC;
	Wed, 22 Apr 2026 17:19:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JR0KcUOL";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013010.outbound.protection.outlook.com
 [40.93.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAAD510E9FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 17:19:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9gEb9epuuJjsT59QlDIO0zAKm7xZH+FiwT6vSRIlD3ACHGn19pBQalfNhs+J6Rr0hJ/nc+oNrQXccJuuzySUxkzOnKMM+15jZWY5t6GRQcPPO9BdBdzKQLvsmpPzveC0BwBD/0ZbBbp75jX/3YLScC/g5X4lOA8+V3cRw6VvHKB7Lc3qcSgW9uMe643OOq/Cw7sIWCneU+ACYLB4c9JpFGp8gJrjJJrpypfp8V7Eyw3T4xmBzWGs4tJHQDBR6HHri4IEeH/WjxbKq7NbDwlsFWUDWNRDK2SKsiByl7QUXkCHsmfrsTHvx/DmmKsId02BMxcfxJ/Cz3R4bX2F+mDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00YuVDSsEqJyLVkHvqwy4XpioJa3cODmaMtFmr4kPqs=;
 b=d39W25o3HskSQEB1QsB06rWlM3aj49SzwJaEFDnKrSa1ft9s0+YJQQt8c6s+2hxNfBPWvPrxxIurYZkNQQQKHVLM06fVcy+IN7kPDoe1XRY63FsWzGn+Yt9BsfSJ2YCjckYPPQPjUHXfc50otusdf0QT45/De4GKmcMvEUnie5MRbkZ/jWYm7YXsRd1lwwH0OmeChevQ7MiycSDljFEaghxeEnmS1hgRVu7zmPYz79tuujOqD9n/4hPrbXsqhoerL/yl7mu/KtKtwzXlTsENBqs+uZk1HwXy4pJoO6I10CHQYcYcInbSSg+Hvbv5Xb0nr3qefq0EMD3N5fTQnej5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00YuVDSsEqJyLVkHvqwy4XpioJa3cODmaMtFmr4kPqs=;
 b=JR0KcUOLdI3zJcYlUOCjV1R0a9bceI0vtbYmgDbxwPnyy3adiV3B2h7aloXQTBJQtIrFhJ0Jk8lfb7Chaf7gv4u0H+5U+HDf8EGQYSCKrLnmfKDScS4rA68TSUYAQiZ8hCVNQ9hv7ar6SBWP8Tnz5PVqP9tp63hCrFAnCWfWJ1U=
Received: from MN0PR04CA0028.namprd04.prod.outlook.com (2603:10b6:208:52d::27)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Wed, 22 Apr
 2026 17:19:03 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::7d) by MN0PR04CA0028.outlook.office365.com
 (2603:10b6:208:52d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 17:19:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 17:19:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 12:19:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 10:19:03 -0700
Received: from [10.254.93.15] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 12:19:02 -0500
Message-ID: <5b0ea1b1-40be-4941-b4cc-521a9fca8c09@amd.com>
Date: Wed, 22 Apr 2026 13:19:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs
To: Alex Deucher <alexdeucher@gmail.com>
CC: <amd-gfx@lists.freedesktop.org>, <Harry.Wentland@amd.com>,
 <Aurabindo.Pillai@amd.com>, <mario.limonciello@amd.com>,
 <wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <stable@vger.kernel.org>
References: <20260422162956.620362-1-sunpeng.li@amd.com>
 <CADnq5_OYNSoWteuXDJrCOtj4qYn2q+vyXUKZaHvgNN+5xFFg2Q@mail.gmail.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <CADnq5_OYNSoWteuXDJrCOtj4qYn2q+vyXUKZaHvgNN+5xFFg2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a899672-23e6-4657-8657-08dea0934078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|42112799006|1800799024|376014|32650700020|82310400026|36860700016|18002099003|22082099003|13003099007|56012099003;
X-Microsoft-Antispam-Message-Info: 4v+eVeiEv8VcGIPMZUOLT970po1SBcGhpZbpBzFxipOjsYS9pP3T4D2kNh62ZPRrqeQVo99WUXhMI6pLQtmcloEO1/NWF4K9YnnfzT96TPuaxbg9TAek8Ij5VGgLqlsqm8qtvmWMdKOEX8wEHVgWR6+4Y9/DJrZ57Yss5S1er4dHKxtTb2bAU/z9p+Cz0TN+J2FKPn6OpMe92TeAtWK7n+upqT38/tFq2BeSWzrBkpYKTAn8J2iJSLsBfucqXWX2/SYEbGu2+S1yEl8ZNK8udzO3E6+/HoVmWselOWjlqlw/nFfU1uiUFi42j/bUh6epWYfUjycdRX4qOb1P1ZOalrsXOXOhc7EVkFmWDlwl1KmqgtZCVYFCKqq6OGLodTAzlPn9xt6dmM01Lvvz69lovF4WzVAPbPv+u44Z4Kah9YuhRtU+D7Z/F8o76ZllnP2aDUOLP6YL44CGXpnVlUtWuGSyVNmbUrxxoNITKa3ukgG78JyVhjtqfxTBuHV2PRJA95lNLpmmeykF1KxjqO075qWUMiAODPuLYUcWd4ubc3b0E0+AXUNCC4IMrz37cLC6adz+6DYpv9t94znRpSgw/wON4AsX3aeqEzJ8bukP2MPJ53dNp8n8UUhqmV+shW0lpsSeJXtAaC01/IgJ8ynvacbPUat1YEjaRud+G08QWTOjZSJ9xdTRi14ucFfGqmkM9idusFpHXp9Ghcnb2uim2BWmfzOY/RqKjw4SVKW36e8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(42112799006)(1800799024)(376014)(32650700020)(82310400026)(36860700016)(18002099003)(22082099003)(13003099007)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: apKeGIn4Vv2kyP/5UGr7DHPYb21tna/F178ol4fFAzjA1OjU0AjkLovuLBLuDvPJ8pZpLltoe8xVHmWfM7wQ7+/jYti14k/fwyTmZSGLsNPPOEHAfR2r4K8JVnA27XwcIzJv/Oz6KwRkWEtIU0e0cw3TIkJ92LRYrv4rv00zKb/iR7q01yvHCLbPCJSf2Gb+Oo8eXvqTfbfUpUSMwkGVaoIKAhttZlXnUnGk/lshEGLUDbC5hMMZf76Avyz+KJ65CcVMrmdd7QqreabYnrWXxNKdQH4cXZ2NA3FYPhfgwFFboKoQQej/5hs6YYFTnToytKKatkjrkb5Rct5hoSY8O7ED5UQ8QV677eo9mUU5f4vuHdOaO+E0KoMUd5SY+bARJFY78Qc+3RRABzTDodNinTEXwO51L707fbPieCe9aYs/Oop3J4J9r3SkUktL7/7r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 17:19:03.5025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a899672-23e6-4657-8657-08dea0934078
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
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



On 2026-04-22 12:56, Alex Deucher wrote:
> On Wed, Apr 22, 2026 at 12:49 PM <sunpeng.li@amd.com> wrote:
>>
>> From: Leo Li <sunpeng.li@amd.com>
>>
>> [Why]
>>
>> Rapid vblank off is causing flip-done timeouts for NV3x and newer
>> family of GPUs that support more idle optimization features.
>>
>> A proper fix requires further investigation. In lieu of it, let's
>> workaround it for now.
>>
>> [How]
>>
>> For NV3x and newer family of DGPUs, restore the old 5s vblank off timer.
>>
>> Fixes: 9b47278cec98 ("drm/amd/display: temp w/a for dGPU to enter idle optimizations")
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3787
>> Link: https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
>> Signed-off-by: Leo Li <sunpeng.li@amd.com>
>> Tested-by: Michele Palazzi <sysdadmin@m1k.cloud>
>> ---
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 3fa4dbda4517c..ce5063928413c 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -9511,9 +9511,21 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
>>         if (acrtc_state) {
>>                 timing = &acrtc_state->stream->timing;
>>
>> -               if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
>> -                          IP_VERSION(3, 5, 0) ||
>> -                          !(adev->flags & AMD_IS_APU)) {
>> +               if (amdgpu_ip_version(adev, DCE_HWIP, 0) >=
>> +                     IP_VERSION(3, 2, 0) &&
>> +                     !(adev->flags & AMD_IS_APU)) {
> 
> Why only dGPUs?  Seems like this is reported as least as often on APUs
> if not more.
> 
> Alex

Hi Alex, Mario,

At least in the case of the few reporters I was working with, this specific
flip-done timeout was reproduced on NV3x and 4x systems running multi-display.
The reporter for the linked gitlab issue was also running a nv3.

The cause of these flip timeouts can be varied. The signature for this
particular issue was OTG failing to fire an interrupt that is expected to
deliver the flip-done event. I'm not aware of this particular signature in APUs
-- at least none on my radar. Do bring it to my attention if you're aware of
them.

Thanks,
Leo

> 
>> +                       /*
>> +                        * DGPUs NV3x and newer that support idle optimizations
>> +                        * experience intermittent flip-done timeouts on cursor
>> +                        * updates. Restore 5s offdelay behavior for now.
>> +                        *
>> +                        * Discussion on the issue:
>> +                        * https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
>> +                        */
>> +                       config.offdelay_ms = 5000;
>> +                       config.disable_immediate = false;
>> +               } else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
>> +                            IP_VERSION(3, 5, 0)) {
>>                         /*
>>                          * Older HW and DGPU have issues with instant off;
>>                          * use a 2 frame offdelay.
>> --
>> 2.53.0
>>

