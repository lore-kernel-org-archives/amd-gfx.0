Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68A6C38A02
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Oct 2022 15:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F04B10E861;
	Fri, 28 Oct 2022 15:51:09 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB39B10E863
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Oct 2022 15:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNjpp+GjBezuDARfo2JnNmB5ThiC0tHH7Rj+5kZRMSRFXl9DYV98G3xs1K1heZF52KNBulAN0b5SGjKVQuk8iDNtSxeOieaPYuTVnUSu9MUq47ehYUUYfwyluFYOUXYN/wAdoh8dgr1wabDAK+TkElIV0EuUMB5JdwoXuJx9Ke4saedJv5a57qbwvS78+HUQvZ/MCqzzU5jPuyRy1D4imgOwtF2oRGdav2JEl22uA+nklVreiuptjdzh2l65cKs+DOVCyEmgTSabK1bOcjp8QQgQwNJPYjyy011BlNOS0mwzLQag7H+RrdYt4IC8rplT4+qcNwimJosuyNvlnpwh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP/tW2XrjEXCY3KDW8se1D+3RJHDdcT2GtGdvQYPIS0=;
 b=RZ2RBCm8dJWQEPF/8iHsL0qITEwkS88L2bnpTB0EuQnIOEjAJsCyzz1eRB+w1TLMZrKYB4xnpTK0WXB1FbqL/ADWQMVrLp3ikCO16aUdJb+FR5/WJ6/zUirCpg15ROPtiulQvmG86XEKO8DfQYhlDeSwzbm1L5o5aIu1IASvlMCiARvHsQ1CoYcfUiIUmUnfZDzGIDiCuVChdPlULnuUQOg0UhbITA/aSy8/AAbai7c81WmmNDejbpHMRDl8QHSMfgvmS5XdMgPjomi5pvXBT1aisd50GFrnNhyaPw0vtp9Z8xtgCXCsCIa4SDtU4+/xszkRLLny/SVwdPUDQvuSYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP/tW2XrjEXCY3KDW8se1D+3RJHDdcT2GtGdvQYPIS0=;
 b=ACJC/5rK1cQoSD/TuhVtMOQwzOhymYrtz2hxq8iT8UhpnJnyl6HcCb4DjFgwXngTHZHSR6VSwrCeKIlt6impBDUxnYG9rUMLrBiZoO3X6rs9jCFQf39XzIr+Qn5AETGNhkU0gM7ykmY+tD37tJCMDEJTCSx1vaIbJa9jPdVZxgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 15:51:00 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89%3]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 15:51:00 +0000
Message-ID: <21a6280b-f795-45f9-6344-7340f4d5da3e@amd.com>
Date: Fri, 28 Oct 2022 11:50:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH RESEND 1/1] drm/amd/display: add DCN support for ARM64
Content-Language: en-US
To: Estela ad Astra <i@estela.cn>, Ao Zhong <hacc1225@gmail.com>
References: <20221027002528.15983-1-hacc1225@gmail.com>
 <20221027002528.15983-2-hacc1225@gmail.com>
 <c41b45cb-8a1a-4140-b7f9-08aa481a25c1@app.fastmail.com>
 <8eb69dfb-ae35-dbf2-3f82-e8cc00e5389a@amd.com>
 <d1157b52-c759-c765-8c74-aee43c23d6e2@estela.cn>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <d1157b52-c759-c765-8c74-aee43c23d6e2@estela.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0326.namprd03.prod.outlook.com
 (2603:10b6:610:118::9) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: a9964ac0-2f55-48bd-194b-08dab8fc35e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eLRO8Actxf7tel0WS/G/bVg9RomsX6YOk7jioTplqK89tiPwM2enJ/oowz+MpTDQmnOBKpBKoNgbRT/fGY5ggjLhjRPiK+4+gSpjIDFfyOzCq+xhAHc6e1wD2+UfpWgTPWgrVLUpnv9j+g3F/qrRojjktdsU0+i7cf5DmdCkJozddzkfyFG0MCYxG/u5WCN1MEERaSJaRsEK+pgjatIQuVPz78RrWHTBXH6s+qwPzPoSRmjmn1h176QOF4Dv5nrZVH0l4NJ5iaIHIfkKQR0TCTrLWngt3RR/xbz40TNPZkAouNXFk/JJZvfzSkWU08GVealT6WHYI9bOatPAy66QEG8J17nKn2W6+EG2gCePmU+P85NNNfvCR8u5M6hjhy1N8LDHaSXWHQ5J+w2nJbxxRohJ14h+qMpXmrQEGnE2DnZC11IIchB909alipWGcgWfbhTg5Y+G+wStrTF3dWZ5AW8KjqgGNboSLdSvH5L+Ad3r6jp07EWDY9TWJq1Bx7HpmFL5t6inHXWQpJUefCFcUuFlDQ4/jgMm24DuUUTOncCTZMB2sS769BixB7+0X/ReG+tAQnFLsvxo8qbfFpX24OOp1Swk0OZTAmco8rfEtQ7HpXtEtXhlgzZkY6O1Zh5RzaU92C9UJn1xJTgOFFaTlKrjGYdtn/NZZzTXzHVJNRYdevLx4MDyDoI247DutXaeHX3C8pznDkDJzX6rd4xvu2SxA6uwGuTPc7awm93N4q+QIqnuvM+5cMohXlDOhaLYr/PTvGdrpqCP1DEOg+ZoFEtQLBwx73rY2ZWNLLwacX76lDZzgEwFHdRgE4q4q89sBpuYP5w7vwa5U+IyW6KCXUQ7PvisdQwswCtxNEP4Hy3Li/jH+K5g5u6gq4FXFWPx8tLWn5w2oqBVljNOhszzPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(83380400001)(86362001)(38100700002)(4001150100001)(2906002)(5660300002)(31696002)(66946007)(4326008)(66556008)(66476007)(8676002)(41300700001)(8936002)(6506007)(26005)(2616005)(186003)(6512007)(316002)(54906003)(53546011)(966005)(110136005)(6486002)(478600001)(31686004)(36756003)(781001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MllnenpRdzNWSVROM2VEWVFRQy9wb2FQVHo3NkFWQlF2Z1FFeCt1QTNNYldt?=
 =?utf-8?B?RG9DekkwL0RQZTBoL096VUQwNUlNTm9McWpvNjQxMUI5RzR5VERIcitZaXRv?=
 =?utf-8?B?eGMzQzh4RmxDdG5DSjVZVUdnRWgxSlZueTkrbU85bHFrZEVPeko0dFJVajVl?=
 =?utf-8?B?NU5sLzVBT0laYWNOL2NZTlZPaWkvNVUyM0s5eWJCUFA5b0xjMUppcDZoOXBL?=
 =?utf-8?B?NWtpOHBTOElOaE9hbjM4ZEpteGwyWmN6akRyNm5pT01zczdyc2F6SVVVc2Z6?=
 =?utf-8?B?bzBLMXFBRFhCZ3dxeitsWWpBNjcwLy93SitmVVd4ckVRODd6M1dQTk9ZaGFG?=
 =?utf-8?B?SjdwMFhaV3NqMi9CcHZXZWFiU1RvaVJuUmpUQXZ4d3I2YlAySnFkUWlDbW5I?=
 =?utf-8?B?by83Q251eUtpNmJQazI0OXZOL1phMEM1bkRGYTZ2SG9JTDNWWjVLUzBla0sv?=
 =?utf-8?B?UmdHZjV5ZFV6TUM2VHhqUmxzTVZrbk01dXpwaUR1WGdraDUzMU1uSWMwRTZP?=
 =?utf-8?B?QXdXVWtzNEdqSWU4RXNFUTlyZFRGZ2ZZSDZORFFBL1poTEVXU1N6WG14ZVpn?=
 =?utf-8?B?L01YWjBrQVlzcFpaSGwxaHptVmZjSGFxOXJVSVlscXZOemJGYWVEaXhhUy9L?=
 =?utf-8?B?RE9SYlpGekVlOGg3NzVJNHZQSWJYa0JZNExhcng0b1d4SE1LYmNwMldBeTkr?=
 =?utf-8?B?M1ozblMvY25LSEs3dnB1SFJTcE9Zc0tOUmE3RW9LQXBrcjBuMGJKenhRWUNz?=
 =?utf-8?B?ZWhaZTVhUnkraVBPV2NUL0NpckFUSWRHM2tsWTFmQUJ4c0ZxNFc3cC8ydHZq?=
 =?utf-8?B?eHF5bVk1UVd6VlpNektDSENGS0orWjNEbGF2L3BxcUxqOHhKc2lwWWc5S3hW?=
 =?utf-8?B?cGRNVGRuQ3RNVXJzcXdCVGR4WmIzcHkrQjZQSlJYN0dZTld5RUFCTEI4c1ht?=
 =?utf-8?B?QU5PWnhQdVgwdCtZNm5WcENNYWlFUnRSNVZjK0krUHlTMFFuNTdOVFpOZktm?=
 =?utf-8?B?WmZ4ZWc4VWpiU0JiUU02MjkwSVYrbHFRNS85U0syVHJac0U1RG44NS9lZlUx?=
 =?utf-8?B?Q1JSVTVHN2FCdUdsRmU3dWhmTFdXTmlGS29lbERubFk5Q29kUUNwUXE3NG5Q?=
 =?utf-8?B?c0phajBlV3NNMDMxUStqQkJaOEwxMzVGNmwxcEpRQWhnbW1tbjhIcXB1c3lt?=
 =?utf-8?B?VC9GZVBJcEx3dmxKbENCRG1BbjdOUzJuU2x6YUViWUVpUmRzUWEwKzlOVHdy?=
 =?utf-8?B?ZExUajNMZmxqc003QkhxNmEzei9FZnZnTHNzRGxDMnlZMUVzRDI4V0ZoRGll?=
 =?utf-8?B?NGwvZW1TTDVNWE1aalFmQ2hRTWUzOU1VQU40UTJMeUZhWnl0N0lxRnlmeWh4?=
 =?utf-8?B?cnVDV3FSSlVMTkZOZ0FHT0crbWhkS3EvVDBqWGhNd2NCNkJUbjl6V2duYmdS?=
 =?utf-8?B?dzhxTWM3QzRPbnJCWTBSS2t1T0xNZ0xvbE4xSmVXOFpKTGN5VGM1Q3J1c3k2?=
 =?utf-8?B?WlF5MlNqMmFxbmFuQnhBN2RLR01uNW5zc3E4RWRjemtNSXdEV09kNmlNV1po?=
 =?utf-8?B?YjY5UFVKK0MzaTY0c1hUQVh3b2dBdTh0cmtMQzdjaVQ3Sm43WVNuWldLTFZY?=
 =?utf-8?B?Y0c5eE9NTXIxS3BGZ3NBdjF1ZUhmUlYwZkpRTHFMd1B4KzBkZHA1QWVmUTFu?=
 =?utf-8?B?dWhQb1MyVTE1TnhsNHpFVStod2lQWk4vMnFuRjJvdDNzVytwMFpINndFUzNk?=
 =?utf-8?B?Q3BVZFNEbGxpdFRtUDFQMXRsaVZnNk9hLzNrc1FlQW5FRzU2aStVaXhNTTZu?=
 =?utf-8?B?VlRuYWd0WFBveGdvUW9sNDNQK1BkRjRFdUx4eEYyL2ltNmVma29nNjJQTzMy?=
 =?utf-8?B?aXZ1bVdQREJXY2RZcTFVOXlWOHpBMTFLb2w4M2t3S0xTa1Z6RDBaQkh4N2Zt?=
 =?utf-8?B?OGJkM0t1TW82VjgzMlVMNnk3Ym42OEFUNVRPanpScUxETFRyVVBBZkZYVE5t?=
 =?utf-8?B?Vk1zL0o4QUVXQnprNkhvWmNCbGlRR3VXSjRTOG04Q2lrNDNqS3hLc0x3cWt0?=
 =?utf-8?B?eTh3Q0Jvb2FNU2pCL25tc1NrQ0h3U1FjMGVKaklQV0NyNFdlc2t1VzJTUEYy?=
 =?utf-8?Q?hzDMQLslJmSWlghtACRMjLYUw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9964ac0-2f55-48bd-194b-08dab8fc35e3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 15:51:00.2941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsmqPNduPesPGlzfV2VkHcyPyut6y4cCl/AY/wMc9XZNNl3VbduIfmLd7saH135Ado/r3le9coFyGGH/L7llGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
 Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-10-27 15:24, Estela ad Astra wrote:
> Hello.
> 
> I have tested it on a Phytium D2000 platform with RX 5500 XT.
> 
> Distro: Arch Linux ARM
> 
> Kernel: Linux 6.0.5-1-phytium aarch64 (patched, 
> https://github.com/saeziae/pkgbuild-linux-phytium )
> 
> Plug and unplug: OK on all ports.
> 
> Resolutions tested:  3840x2160@60Hz, 2560x1440@60Hz, 1920*1080@60Hz
> 
> Dual-screen: 3840x2160@60Hz on DP plus 2560x1440@60Hz on HDMI.
> 
> Graphic applications: glxgears. 1080P video on MPV (VAAPI). Minecraft.
> 
> IGT test:
> 
> Most tests went well, with a few error logs.
> 
>      > cat kms_flip.log| grep FAIL
>     Dynamic subtest A-HDMI-A1: FAIL (0.201s)
>     Subtest absolute-wf_vblank: FAIL (29.571s)
>     Dynamic subtest A-HDMI-A1: FAIL (0.172s)
>     Subtest blocking-absolute-wf_vblank: FAIL (29.537s)
>     Dynamic subtest A-HDMI-A1: FAIL (0.257s)
>     Subtest blocking-absolute-wf_vblank-interruptible: FAIL (29.458s)
> 
> Photos and video clips: https://t.me/esteladaily/334
> 
> Thank you for all you guys' excellent work.


Hi Estela/Ao,

Thanks a lot for running those tests. I'm glad to see that DCN is 
working with ARM in general.

Estela,

Could you share more details about your test system? I'm trying to 
understand your system and Ao, so we can try to add one ARM64 system to 
our CI.

Thanks
Siqueira

> 
> On 27/10/2022 22:29, Rodrigo Siqueira wrote:
>> Hi Ao/Arnd/Stephen/Nathan,
>>
>> Ao,
>>
>> Thanks a lot for this new patch.
>>
>> Since you have an ARM64 + AMD GPU, could you also run a couple of 
>> tests in your setup? If so, this is a good set of tests imho:
>>
>> 1. Check plug and unplug displays (let says 5x)
>> 2. Change resolutions
>> 3. (most wanted test) Could you run some IGT tests?
>>
>> About IGT, this is the official repository:
>>
>> https://gitlab.freedesktop.org/drm/igt-gpu-tools
>>
>> It should be easy to run IGT in your system. Follow a brief summary:
>>
>> 1. Install dependencies
>>
>> (maybe I missed something)
>>
>> Debian
>> apt install flex bison pkg-config x11proto-dri2-dev python-docutils 
>> valgrind peg libpciaccess-dev libkmod-dev libprocps-dev libunwind-dev 
>> libdw-dev zlib1g-dev liblzma-dev libcairo-dev libpixman-1-dev 
>> libudev-dev libgsl-dev libasound2-dev libjson-c-dev 
>> libcurl4-openssl-dev libxrandr-dev libxv-dev meson libdrm-dev 
>> qemu-user qemu-user-static
>>
>> ArchLinux
>> pacman -S gcc flex bison pkg-config libpciaccess kmod procps-ng 
>> libunwind libdwarf zlib xz cairo pixman libudev0-shim gsl alsa-lib 
>> xmlrpc-c json-c curl libxrandr libxv xorgproto python-docutils 
>> valgrind peg meson libdrm libtool make autoconf automake gtk-doc 
>> python-docutils git vim sudo
>>
>> 2. Build IGT
>>
>> meson build && ninja -C build
>>
>> 3. Turn off your GUI
>>
>> (You must run IGT without any GUI)
>>
>> sudo systemctl isolate multi-user.target
>>
>> After run this command, you should see the TTY.
>>
>> 4. Try to run this IGT test
>>
>> sudo ./build/tests/kms_flip
>>
>> And let me know if this test looks ok for you.
>>
>> On 10/27/22 06:52, Arnd Bergmann wrote:
>>> On Thu, Oct 27, 2022, at 02:25, Ao Zhong wrote:
>>>> After moving all FPU code to the DML folder, we can enable DCN support
>>>> for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG from the
>>>> code in the DML folder that needs to use hardware FPU, and add a 
>>>> control
>>>> mechanism for ARM Neon.
>>
>> I recommend you to add the following info in your commit:
>>
>> 1. System that you use to validate this change (CPU name, monitor, 
>> distro, wayland/X, etc).
>> 2. Describe the set of tests that you tried.
>>
>>>>
>>>> Signed-off-by: Ao Zhong <hacc1225@gmail.com>
>>>
>>> There have been problems with stack frame overflows on this code
>>> in the past, how much have you tested this with random configurations
>>> to see if we still hit them in corner cases on arm64 that may not
>>> show up on x86 or powerpc? I would expect to see a few more of them
>>> for every new architecture port.
>>
>> Hi Arnd,
>>
>> We followed your suggestion to isolate all FPU code inside a single 
>> place (DML), and we recently completed most of this task. As a result, 
>> all FPU flags are only used in the DML code. I guess we might have 
>> issues in other non-x86 platforms, but this is something that we can 
>> improve over time, and from Ao message, it looks like that DCN is 
>> working on ARM.
>>
>> At this point, my main concern is that enabling ARM64 may causes some 
>> compilation issues that we did not reproduce yet. I cross-compiled 
>> amd-staging-drm-next + this patch with aarch64-linux-gnu-gcc version 
>> 12.2.0 and everything looks fine.
>>
>> Nathan/Stephen,
>>
>> Maybe I'm wrong, but I think you have access to some sort of CI that 
>> tests multiple builds with different compiles and configs, right? Is 
>> it possible to check this patch + amd-staging-drm-next in the CI to 
>> help us to anticipate any compilation issue if we merge this change?
>>
>> Or should we merge it and wait until it gets merged on the mainline? 
>> In case of a problem, we can easily revert a small patch like this, 
>> right?
>>
>> Thanks
>> Siqueira
>>
>>>> index d0c6cf61c676..3cdd109189e0 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>>> @@ -33,6 +33,12 @@ ifdef CONFIG_PPC64
>>>>   dml_ccflags := -mhard-float -maltivec
>>>>   endif
>>>>
>>>> +ifdef CONFIG_ARM64
>>>> +ifdef CONFIG_DRM_AMD_DC_DCN
>>>> +dml_rcflags_arm64 := -mgeneral-regs-only
>>>> +endif
>>>> +endif
>>>> +
>>>
>>>> CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
>>>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
>>>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags)
>>>> -Wno-tautological-compare
>>>> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := 
>>>> $(dml_rcflags)
>>>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=
>>>> $(dml_rcflags) $(dml_rcflags_arm64)
>>>
>>> Why do you need separate $(dml_rcflags) and $(dml_rcflags_arm64)
>>> rather than adding -mgeneral-regs-only to $(dml_rcflags) directly?
>>>
>>>      Arnd
>>
>>

