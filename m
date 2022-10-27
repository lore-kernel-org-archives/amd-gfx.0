Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EB6FA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 14:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5338410E648;
	Thu, 27 Oct 2022 14:28:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE0B110E648
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 14:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LooJqxtoIkmF3Z6nUyBEl9UFNKU+ZfHw7TB+iy8knu3Df90xek0ES9P1J8uMCViNDtExBRZbEVR5fpN0ltwwpyLXRIBJ4gbYyvedi3jzUzauF/FG3lauZGgiw0SonDwwxNUBYexuS4nVg+9ESZ2SZU/lnI+OG2RjsbNGqdWkqzGyDTsKYlPqrFzR9GCC1bM9Csrre6oNkAT9LdqqtuiaOQwVHpv6VRP+eZFxzEGU6H3ZTHbY9Qo/i1GxDIeisJSkjs+eDabPA5A0tO0mEUODYkPpsF1YMfEC0sbPSEKWcaROi+SZEN3wLnS9UbG7tu/sxljDvQf65tKdLwe7AQ5Vow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glufebwksGPToJ0ZAF0tzGFhkyzI7yy0XiCMZSZRlQM=;
 b=hBk0Ka2fWiFY8YgamzoiSYicyzHSaQOnJaKYTyhN438YdRInn3nxRYJyH8nhhke0XROiTNJ0eDjO5Vwcuhi1sBcdCQ0SkUsOqWzNpFmn8K/jL4vtbdprlepgZYcXZOGVAxPf7SGPU9kuJ1u3svzsCZUOqNicTOM2ZsT1UiwkCPil9cwOYvMzYq/Za/7IHXOnpw+/GDZjII8+DmtTxOTC+6ou5avfrsFAUxnsJoi3O5Gmmv0nUn51zepvArUYV0qYrLTs1xvlVeuWel5gla6m36FUQPntW1KOxnaBx80E4FCfZPORxfVH79XOOHZT0aPQEnsU6nm2YYQbk31eNNYoKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glufebwksGPToJ0ZAF0tzGFhkyzI7yy0XiCMZSZRlQM=;
 b=3JI4xzwCTlkGO/Edyj5jo1N05gr8JjYvLjaaFIE/OAH+3gWJW8lqSC1YC8lmJ7B77cYWX6qqs+KdwPsZKbAIZ7cXyMM9AsodxvcVmGffLqBsAo/pyYkmxIcKBiV1DEDnxE867hnM2Q+DfXQe801wA4nqw4yf1EOCKP0dJPGye78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Thu, 27 Oct
 2022 14:28:53 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89%3]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 14:28:53 +0000
Message-ID: <8eb69dfb-ae35-dbf2-3f82-e8cc00e5389a@amd.com>
Date: Thu, 27 Oct 2022 10:29:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH RESEND 1/1] drm/amd/display: add DCN support for ARM64
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Ao Zhong <hacc1225@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20221027002528.15983-1-hacc1225@gmail.com>
 <20221027002528.15983-2-hacc1225@gmail.com>
 <c41b45cb-8a1a-4140-b7f9-08aa481a25c1@app.fastmail.com>
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
In-Reply-To: <c41b45cb-8a1a-4140-b7f9-08aa481a25c1@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0394.namprd03.prod.outlook.com
 (2603:10b6:610:11b::28) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: c85759d5-e4dc-46d8-4665-08dab82792e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 792mMX7JKF23MMxpbVGRINns1BbxONG26sDWA7PowI/bR5YRFYVaaUNwHTikQEdeHFyLNzaOzV98fvkfY20/xA1m65MNBhYNRSU5vZDx+wKg/NBI87Otnoatz396uKzeYBF1eOH3CGGjhQiEfZV9cj9JqXH+dstq1umgGjcUd2Q+QGx7wdcUPn72e1MK86kDlckFRK7VSXK7v1tk46kQ/43pBmA76bVxHNZax5BWRAQ+2XB+itC9+gvDy43u51x5DVf9rUu3P+P/x/sa9Z3slSMiIUUazcXpxFKpg5oHkrjTe9ZkGkA+vHhGfPqk1r9fLE02+OmF1YHnaE+Wq5TWVEa0/ffjwdA+DDZUOfeNj/vOe3YNYW/s0hwR6ig4knyuZb5d+gO4oCWX/5Jbm1QbEuED17PDb9XhFDFqzC72BbeYgPK7rXW+9qbz4hq0OeFafWR+V5Vn8c6Qi8h7Hcz5Wq+fGPMpF9s41jTXR17m2oSj0se5xi385Q0qgvHBMLyqCJu0yopjz73qWsSJ0f0mb+tHGHSXelpUZKUQaSk1ckdCdwKurjwkATfCzOVR8vqVFZn0pLa2OxMKcSwSL8FiBK2LkR5keWdVA3k/OLnFUfb48KvzDUy4apwLgNg/pVV1VIzT6CLMyw57EyW+MywlDE/XpZDOU9uewc1NCGneVjLWSc7KdKomooJ0c8OJhgu49MLHAzkaMp00t0fYF3496Dk/tVXvXVwyC3BkPksNZIR/gcEa3AMAleVbSbSKHI1n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199015)(6506007)(4326008)(66946007)(8676002)(53546011)(66476007)(54906003)(36756003)(110136005)(316002)(6666004)(66556008)(83380400001)(38100700002)(8936002)(5660300002)(86362001)(41300700001)(31696002)(6512007)(2906002)(2616005)(186003)(966005)(31686004)(478600001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGE0eVljYUFIc29oQXlIN0ViYlBCNDNRTEJzOTJFWTVoRUFQTkY4eFh4aGp1?=
 =?utf-8?B?NWM3cVBtVDROTnNiSTdsaWkrT3dpMmo2NFhqdHhCb0xmRCt3MnB2MzI2Qmdp?=
 =?utf-8?B?aU5PU2xRNHloanRhRUZrZkNPTG5xSDdVc2NvZXlsbDRwMU1qL0dhd3BKZk44?=
 =?utf-8?B?NzdOa3lHcXorYkFTN2NqWTVqUTdhbWRuTEgxRnJTeFJsMXZiNGFqMUxlVG40?=
 =?utf-8?B?bTU5SUJiQjI1UWlIM2xxalJqMlRWRnYzM2V4SGFJbWpWejlCYnFWTnlIa1Mz?=
 =?utf-8?B?WjVra0gyVndRWUxGamlYelF2cXFxbDR2MngxSlpZYzBTc2JJNlpxcGpjQkhS?=
 =?utf-8?B?eWdxZGROR04vNWxSNHhRWDhoWC9MSzZGVUZvY2NGMmZUMFNBU2RySCt2WFp5?=
 =?utf-8?B?b2JtUC9uRHJKbEhUMm9MUnBhRWIxZVB6d21kc1NWNkpUcnR6SkhGa05UMW1u?=
 =?utf-8?B?OCtWNWZYZGwzRmFib2RUUVh3ekdweHdsVlF2QnlpVVJmQ0xuZXlkczROWG9k?=
 =?utf-8?B?SE5pUnhacC9mcFlVQkREQXBoUGxsZ1psSWp6UnRtbmN4T0NWaXhlUURONVUx?=
 =?utf-8?B?SkV4cytLQU1Ra1lKRVcveUgwTGFvQ1NFL0RMcFZkcnVna2oyWG5TOHZtUWlU?=
 =?utf-8?B?VFZUSHFYRGJaUWdjZXowczRtK3ZobURjRVlMMFV4WFFxWmtERWxuODFqc0g1?=
 =?utf-8?B?bDIxb095Nng3KzRLVkZLZk1UaXpzMy9pQ0ZtanFEcUpqZktNKzJrbVdjeSta?=
 =?utf-8?B?d1R4TkprelByUHYvWGhqamc3dlR2U043U2NDTEtmeFFvVkF4QlZPSWFFSFVx?=
 =?utf-8?B?L3dDVnI1T01wcUFhREszOHRyN1Mvd3FqZFpZckZCUS9DbTRTTHB5bUR0OWI5?=
 =?utf-8?B?NFdQaVQrK3NXVTdUcjVVM2tnZnBwY0huMmxYd2lZeVBObFI2ZHZuNERzQzBI?=
 =?utf-8?B?YXhtQ2R1cXlVOXUrMWtIRlhOQjFkQkNiZzBCRy9kV2JKZHUzc2VUQjErL2N6?=
 =?utf-8?B?Uzc1bmtKN0dZc21jUTVQM09scnlDOGpRZkpmUktUTnR0R3FLREZSYUNCSkxW?=
 =?utf-8?B?bzBmQjhyTnlxTW9mdTdLUG9SZEVyc2ZVYjhpS0p5ei9ZeGxuZUJSWmxIOCtl?=
 =?utf-8?B?WWpvcEQ0WHBKTDgyN1MxczdYaXVWa3l6VUVZUGFQL1Zxc1c5TEZKRC82REJo?=
 =?utf-8?B?eHZWQTl2Q25nenJVLzhKMEhRRFRZWVRuSEpFR1QzK0FyajRDN1pOdUVHeWh6?=
 =?utf-8?B?Tk9wS1JPR20yRzAwZTVUT3N2K0xWK1ZCOTZ5Rm1ia0wwclBPYkJ4aXhka0p3?=
 =?utf-8?B?M2VTQTNmRjVWVG5GVElsRm4wTG5KbFNmeENRK1hiNCsvQXBkYnVJUVc3Nk5i?=
 =?utf-8?B?eTZHY3oxcW1ybzhTaDJRK2JxNW13akJrSCtoR3dFaXIyVmt2eCtoc25NU0d2?=
 =?utf-8?B?ZGkzQm5ndUlESCt0Q1JvMVZ1UzVKVSs3VkhUWFBaZDd3MXd1eGJGaHE5RWdu?=
 =?utf-8?B?d1puNXNHWUpNU3haSmpJT05XczF0SWloQW5YaGlSRnZqQlJvNFI2OFB3V05G?=
 =?utf-8?B?bnh3dENFZk5HQnREVTBEVzRZVW15Ujgrd0VNZ0x4UitmQTEyU0VLTGJIU3Vj?=
 =?utf-8?B?NVh5VEdjTUR0aGRXVXpMcnFjdTdPdUpXOTR4R0RZWEh3a2dERXk1OTF5aUNB?=
 =?utf-8?B?Vks4UW44MlhIaGpHdXRlRVZCVWd3RVl4OWxsbHpYc2ZjaE9TdVJ3TU1MejRW?=
 =?utf-8?B?bXFTLy9yeitJdUhrNnUyNjhzdzJReml6L0dEU2ZNdUxxK2ZjaWNBRFU1K21s?=
 =?utf-8?B?dEZZWVpTdjNadGxzUFFiQzl1TWlWT1YxWnQvSGhxbG5OUXpVUWxmbzRkQWdu?=
 =?utf-8?B?cjlhRDFWTEZFNnl0RklYQTNpMzhQQlQ3T3dxR29DK1ZEeXBxclo5SmVpbllh?=
 =?utf-8?B?TGg1bDJhR0ZobHUvTWtaQS9zU2xsSmd3Q09ZSVVUbU5DK2V4REdZUndCTFo4?=
 =?utf-8?B?SS9jSnpPV3lnUS85OEx0S1lxQVNESjIrcDN1RkZpdXNNZHZsN0ZRNXRYYVM3?=
 =?utf-8?B?SDJ2emMvczI0dnVuRDkybFAxb3hLQ2JUUzdYWmR1c3p4b2tvd0htLzM3RWhJ?=
 =?utf-8?B?MUV1OXlDNndxMEd0L0xOUzZqYzdOU3o2TG1NT1NGQ09uSnNNZVdsdWFlbnMv?=
 =?utf-8?Q?XpJ4/k6WlK+Hb0bJF2yAIzo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85759d5-e4dc-46d8-4665-08dab82792e5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 14:28:53.6112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dsb1PCM7QX+WSo5uJEfWs6RN9Eck5aEG72OzSoIgmCxt0fBNc8JigT2V3vLwAVnDrK701d7UljcbXan807gXcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161
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
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 linux-arm-kernel@lists.infradead.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Ao/Arnd/Stephen/Nathan,

Ao,

Thanks a lot for this new patch.

Since you have an ARM64 + AMD GPU, could you also run a couple of tests 
in your setup? If so, this is a good set of tests imho:

1. Check plug and unplug displays (let says 5x)
2. Change resolutions
3. (most wanted test) Could you run some IGT tests?

About IGT, this is the official repository:

https://gitlab.freedesktop.org/drm/igt-gpu-tools

It should be easy to run IGT in your system. Follow a brief summary:

1. Install dependencies

(maybe I missed something)

Debian
apt install flex bison pkg-config x11proto-dri2-dev python-docutils 
valgrind peg libpciaccess-dev libkmod-dev libprocps-dev libunwind-dev 
libdw-dev zlib1g-dev liblzma-dev libcairo-dev libpixman-1-dev 
libudev-dev libgsl-dev libasound2-dev libjson-c-dev libcurl4-openssl-dev 
libxrandr-dev libxv-dev meson libdrm-dev qemu-user qemu-user-static

ArchLinux
pacman -S gcc flex bison pkg-config libpciaccess kmod procps-ng 
libunwind libdwarf zlib xz cairo pixman libudev0-shim gsl alsa-lib 
xmlrpc-c json-c curl libxrandr libxv xorgproto python-docutils valgrind 
peg meson libdrm libtool make autoconf automake gtk-doc python-docutils 
git vim sudo

2. Build IGT

meson build && ninja -C build

3. Turn off your GUI

(You must run IGT without any GUI)

sudo systemctl isolate multi-user.target

After run this command, you should see the TTY.

4. Try to run this IGT test

sudo ./build/tests/kms_flip

And let me know if this test looks ok for you.

On 10/27/22 06:52, Arnd Bergmann wrote:
> On Thu, Oct 27, 2022, at 02:25, Ao Zhong wrote:
>> After moving all FPU code to the DML folder, we can enable DCN support
>> for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG from the
>> code in the DML folder that needs to use hardware FPU, and add a control
>> mechanism for ARM Neon.

I recommend you to add the following info in your commit:

1. System that you use to validate this change (CPU name, monitor, 
distro, wayland/X, etc).
2. Describe the set of tests that you tried.

>>
>> Signed-off-by: Ao Zhong <hacc1225@gmail.com>
> 
> There have been problems with stack frame overflows on this code
> in the past, how much have you tested this with random configurations
> to see if we still hit them in corner cases on arm64 that may not
> show up on x86 or powerpc? I would expect to see a few more of them
> for every new architecture port.

Hi Arnd,

We followed your suggestion to isolate all FPU code inside a single 
place (DML), and we recently completed most of this task. As a result, 
all FPU flags are only used in the DML code. I guess we might have 
issues in other non-x86 platforms, but this is something that we can 
improve over time, and from Ao message, it looks like that DCN is 
working on ARM.

At this point, my main concern is that enabling ARM64 may causes some 
compilation issues that we did not reproduce yet. I cross-compiled 
amd-staging-drm-next + this patch with aarch64-linux-gnu-gcc version 
12.2.0 and everything looks fine.

Nathan/Stephen,

Maybe I'm wrong, but I think you have access to some sort of CI that 
tests multiple builds with different compiles and configs, right? Is it 
possible to check this patch + amd-staging-drm-next in the CI to help us 
to anticipate any compilation issue if we merge this change?

Or should we merge it and wait until it gets merged on the mainline? In 
case of a problem, we can easily revert a small patch like this, right?

Thanks
Siqueira

>> index d0c6cf61c676..3cdd109189e0 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> @@ -33,6 +33,12 @@ ifdef CONFIG_PPC64
>>   dml_ccflags := -mhard-float -maltivec
>>   endif
>>
>> +ifdef CONFIG_ARM64
>> +ifdef CONFIG_DRM_AMD_DC_DCN
>> +dml_rcflags_arm64 := -mgeneral-regs-only
>> +endif
>> +endif
>> +
> 
>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags)
>> -Wno-tautological-compare
>> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=
>> $(dml_rcflags) $(dml_rcflags_arm64)
> 
> Why do you need separate $(dml_rcflags) and $(dml_rcflags_arm64)
> rather than adding -mgeneral-regs-only to $(dml_rcflags) directly?
> 
>      Arnd
