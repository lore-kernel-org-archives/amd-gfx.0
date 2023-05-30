Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9470DC77B73
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 22:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F093210E42E;
	Tue, 30 May 2023 22:04:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB8B10E42E
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 22:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJCBYl29D6TLmoODKL1c23s0Jtl8QpKkrm9Ch4HBPGGRpU/aIa4ddwDLi9xLuiuK6IJ3dEJnuu6CoS7TE/CMhund0D4pRT7lX3KJC4D6zY47Zlj2D3VJnePh4LL6fH6eHwvrmPGTxmZjt45K9P3rJCOo9BoEsEmVGFFTmbxiN26bxW0isM9pg1cKzSTJDgnuXs76T8GfEE3dG+Awbuok7WGv1FYuAfC4v/10TZtIsr9ouSod9YaPr6wJLAtfo03iIOppRmos7mB+K1AL4udhux48heVr95GeieMJ2RwoexdaTPvKLIuv3EvXciY2N+HRWQiJJmblByXWkY7rsg99yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h51YmmEWBZAXtcyRSX6roHHxZJdQdJmYGq962Ls3XEA=;
 b=Vi9fSezemTIIfKOTuEMKwuPNvCOIHvXPI0oTh0op4QmhshrMXYhSmjHN0a3nEfgvyXlkscJTQDQ2CbdKVvRadSyE7Ieptji1CHl5PsMxNSHOGZKEj6UfaNNJa3eJw7flFlhsbr5zHuOeLv63eFdafSyNo0L5S4/P3Gzm8kbF6+f4XWmMJHuPXFmMTI2kqoloI3rM6Kfe/vEuf+zx3X1Xglgk2h0KJ2w5nymgaEle8Rv+G0BaPjyfuPriYm0ET3+Td8whDGNBkRPPWCkVLfmzPGqdsfkZRFAjx4yRzfDGL1kR8YChL4sG/r6r6o4ng1BbHcqCgP7ppCQMczo3k6k6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h51YmmEWBZAXtcyRSX6roHHxZJdQdJmYGq962Ls3XEA=;
 b=YysIGZGxRKC8BanQTyLnCeFrNoqP0KYf4QqiWs6Ry3vOcOparHIZsSNblClch9+9OlOmn8gQuHIhrxX7+ptVMLir7CJTGSTKJf8d7+vDDKJOWdr86BBpkwoowny0lfi+CMvBBSXwa4m1JwpUPbd1OqxN/ohfMz3oHb86CMy1flQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 22:04:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 22:04:08 +0000
Message-ID: <cbd1eaff-bb4a-2cb6-51d9-5a26c699bfdf@amd.com>
Date: Tue, 30 May 2023 17:04:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] drm/amd: Disallow s0ix without BIOS support again
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230530175301.231070-1-mario.limonciello@amd.com>
 <CADnq5_M8XdDsyn0q-mM4CfFoMHH6g54VP_SG4cNztEYAwwB_hg@mail.gmail.com>
 <MN0PR12MB610183E9EC20D68FE3670D24E24B9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CADnq5_Oke4oTrHK2+=dNpY-9p1TArRO6CVWQVvKocwHP-JS+2Q@mail.gmail.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_Oke4oTrHK2+=dNpY-9p1TArRO6CVWQVvKocwHP-JS+2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: e119a55a-8601-458d-9478-08db6159cad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KOzoJ6LjDDFUXHEu2PXVrtPoQKF+fpSNI+SsIZ0V3R0DDOQ+bQ1IAKhMQetueVr14IUeZRkkJ1MU5hZkt1LsE0RVpRCkXVibMZLXax96WHHLq64W5IM7l0ixk8Nct4Fy3os14maMIxToEDfypPVrU86mp4yo+SScGdNkphQ9uGLz617HUMWoc6nSSivj9CM0x3puePw/QVlSMbbcg9VsidKVQrg9ma3p7r93OuEjd58pWvVa24G/HXPUMw1GCOWFh6twoKCR6ed9Knzx76vU6ye+V6o0KFfcqrfddmqrIeRdSUD79i4Vr86zzeZIOaAYwb4YoPU3PykFTVSw91qiFBxIndooqrcHlorZKJuIHBZu+j49TMFXJ1fPRetcPtS0lMdJyMOvpDBsNuVoWVspdvqCoXFlRR4bowToTQaJe56Vo1uC4nIWowORHTvV0PGHneO0rMbHfmmYRO6+9HojCBLjZA6H/n0SvuL6cw4LmZx5mMzP6THk+Rimn90EieynDiR5s9ZC42X21KqqaJ+sTDV42tPm2mwqddfvFuU+snMVo35VGxW5boYldG+MijoGzbPz175BWAt1Y4SnEfM55mB1NsX6CyQ0frNMeIUfqlTF7Yz374pN8HQfBfEGrl1JV0JM0UUi6jLtH0kDgTy95UD2DSITkxbhIpFpW+0Kh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(54906003)(478600001)(31686004)(66556008)(66899021)(966005)(66476007)(66946007)(41300700001)(6486002)(38100700002)(8676002)(8936002)(5660300002)(86362001)(31696002)(2906002)(53546011)(186003)(6512007)(6506007)(83380400001)(316002)(6916009)(4326008)(66574015)(2616005)(36756003)(32563001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGdCaktBMXdtNmQzbWxLdGo5N1RLR1JoTFo4NzFFeTZFOWZ6Y3lBS0x6WXNT?=
 =?utf-8?B?OTBpRTRDMmdnekp5Vys3KzBVL1FKcWFKODhLZU1kcjdHV1BrZnVHZUhySE1C?=
 =?utf-8?B?T3U1aTExUjFIMkdEUXZ6K0lIdmRHakNzZldUWFVOd1gzUFFUQjFLZGhNUjJx?=
 =?utf-8?B?OWI4UURyL0NNL1N5dGJ3bVJ1Y29qRmNEdHl1ZDAxK0RIbUtMWmRzWkVFMXRq?=
 =?utf-8?B?N28yYTZzV1Q3azNEV1dYdkVVVnZmdUloL24rUkxpMnMrcHFERDQzVkdqd1Yz?=
 =?utf-8?B?L0JMKzZhclI1RTdPQit6ZGRISjJQbDRkVGdRUng2dWJOUmlCRXNEaHR3eWpk?=
 =?utf-8?B?aHZXdUJQZDVNNGpBMVBuME9YYlY4cVorODU1K1lOOFM4YVhwRWRjdUI4QVBh?=
 =?utf-8?B?akU2bnRGenZkRkNJbGRYUUFaYkJmNFJKSUthempUb1BKUDU0aTFDQ0V5WlVX?=
 =?utf-8?B?VG1UY3hlVVBFZmM0SU1ER0xpV1VHMkFuejdvSm1zUHF1NDJXakp4N2wrdUhZ?=
 =?utf-8?B?Q3ZRUUhFNndvMit3OUlGdG1kdmpqYllUMklnL01YdFFJY00wdUFRdTZzN1dF?=
 =?utf-8?B?d2JxV1JrN1llb1dydWhQemVpems2UXhraVRJY1FZSWpGU3hzZmlHS1I3NUdB?=
 =?utf-8?B?SDRPZ2pGWDJ5VnpMYTFDT01DOEFobDFwQjEzQWVWaEowYWgxaGE5U3hKRjhS?=
 =?utf-8?B?TGpQR1p5enl5SlNNV2ExeGkvR21ZdFdsYU0ydXh6S0JscnZEeEhoK1FsVHZr?=
 =?utf-8?B?ZEJZeG9xN0U2L2tzVWViVTF1NGwwQjZZenk1cWI5WjNDTTRjYTZzOWtMOXFF?=
 =?utf-8?B?ZmdtQmNSS2dpYzVSYlU5UUVFU01TdGY3UHdLa2tVQXd1Vkhob3JiSjNhSXpp?=
 =?utf-8?B?OGVjemRpNFVVKzYzNUpnSjduK2xrY3kvSmYwMUIrUHhwSldzU2V3aTdzZ1Z3?=
 =?utf-8?B?ODVic2FGbDRGZXBUcGxldUtZMXVUMVFOKzUwSnJlTkpFOFNZNkpDd3grNTZr?=
 =?utf-8?B?V3dxbjRTK2locHJhTjlIb2ZROUdKZXpDLy83NGJqQzFvSExnZEJGTUkwYUFT?=
 =?utf-8?B?Y2Y1czNqRnZMTkNrTCtRUW5OYk5aV0pycW1MTTlsTHB5TGxzT2tZQzNYdjZQ?=
 =?utf-8?B?R3NpRWpLTHJkNTdOZ2d0RjI4VURDTmc1WmFYUWwweXFITnBKWW9BbEVkK25o?=
 =?utf-8?B?ekxyZzc5L1JydzBiNUpkck1yTFRIMk5zQVp6ZGN6TXVsYURnczhPNXVINytx?=
 =?utf-8?B?OFJGSGVYMWVRTXdDbWJYS01OT0RhR3BVZmZOMVBDWVZXMlQ5SytrSm9sR3BF?=
 =?utf-8?B?Yi9JUlhJbXV3aXBFZktFRDZZTVg2Vm1Za2JqL0l5OWgyNG1IT01JSzBNNHVK?=
 =?utf-8?B?ZWtBbktFMExwT3lvcG9WdHJHTHFvd21DK0hzdFd1OUQzVEhuWWtBMHFDcFZs?=
 =?utf-8?B?OURpaUNsczdvVWFla2JyYnlQNytuYTJKUTA1WlBoYWVHZGI2TEZvTGdqWEdr?=
 =?utf-8?B?UFFNalVNK3NUcmI2TG0vZGVNNVZaeFJqaUt3enBHU1RQSWtackNrbytuc2ts?=
 =?utf-8?B?STJPd1RISlRjRVdTN09IT2xSczgzdzdOTHo2Sm16UVJMN09lVU5ZcVA2QXYy?=
 =?utf-8?B?MnhweXVXNjR6cHphUDRrakxKb1E2VW0wSmYvWVJrWWpISFhhVHpxUWdyK1B1?=
 =?utf-8?B?NmRrQU1lWXhHLzFsV0VJQ2dTbDBKbjAvWFR6cUlDOVcvR2tZVGxCU21xdHB5?=
 =?utf-8?B?QVo5N0dRaytoU3B4TjZBdG1aRHFObGRDUVdmQUdSUmlYTU1HTytHV2JJTys1?=
 =?utf-8?B?STVqYkhXektQYzRaUENNbUVaNDlUUnZVeC90alBjUmdqQWQwMEt4ODFqZ0FK?=
 =?utf-8?B?aEEwRlhtQTVsalpwOUhmem5Ca3hDVGhDd2U3MGtRa21lbHppSkRmMGxva3lI?=
 =?utf-8?B?dzJJMVNqVHBmMDVUaVV6QjN5aDFodGZXNjEzOTd2YWVDdjBRanhMejFPQ1Ux?=
 =?utf-8?B?NGI3VFdiTTZqTFRPaGNiSjh0RlhFSzdQdUhUWHJXVEx6cEFGNVNIRUVDbkwy?=
 =?utf-8?B?WmFvTXpkZ2hBOFU2ZXczTGhjWDM5L3l3Rldod3JSSTBJWWE1RDk2MTBINU44?=
 =?utf-8?B?UHpxK2ttTWtFL3FQcUgxZUtYSEsxMjZ5dmdFV01sOVUvUnh1WE5Bd0pQV0ht?=
 =?utf-8?Q?Uo2wdjRE9xktpBAxjVJNVJ9154NYS6ArvbRTFwgBPUkU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e119a55a-8601-458d-9478-08db6159cad6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 22:04:08.8059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kH3DKTkd4Wg/EuoDEEfkIWhmt3ZyqmzA1bdGKhxhdtg2VzJbXDeBjdSomTU+R2KTQg8/ni70Wfazpu0c3xItrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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
Cc: =?UTF-8?Q?Rafael_=c3=81vila_de_Esp=c3=adndola?= <rafael@espindo.la>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 5/30/2023 4:34 PM, Alex Deucher wrote:
> On Tue, May 30, 2023 at 2:19 PM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
>> [AMD Official Use Only - General]
>>
>>> -----Original Message-----
>>> From: Alex Deucher <alexdeucher@gmail.com>
>>> Sent: Tuesday, May 30, 2023 1:16 PM
>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org; Rafael Ávila de Espíndola
>>> <rafael@espindo.la>
>>> Subject: Re: [PATCH 1/2] drm/amd: Disallow s0ix without BIOS support again
>>>
>>> On Tue, May 30, 2023 at 1:53 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>> commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support")
>>> showed
>>>> improvements to power consumption over suspend when s0ix wasn't
>>> enabled in
>>>> BIOS and the system didn't support S3.
>>>>
>>>> This patch however was misguided because the reason the system didn't
>>>> support S3 was because SMT was disabled in OEM BIOS setup.
>>>> This prevented the BIOS from allowing S3.
>>>>
>>>> Also allowing GPUs to use the s2idle path actually causes problems if
>>>> they're invoked on systems that may not support s2idle in the platform
>>>> firmware. `systemd` has a tendency to try to use `s2idle` if `deep` fails
>>>> for any reason, which could lead to unexpected flows.
>>>>
>>>> To make this the behavior discoverable and expected, revert commit
>>>> cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support") and offer
>>>> a message if SMT appears to be disabled.
>>>>
>>>> Cc: Rafael Ávila de Espíndola <rafael@espindo.la>
>>>> Link:
>>> https://github.com/torvalds/linux/blob/v6.1/drivers/gpu/drm/amd/amdgpu
>>> /amdgpu_acpi.c#L1060
>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2599
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 16 ++++++++++++++--
>>>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>>>> index 3a6b2e2089f6..a3523d03d769 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>>>> @@ -28,6 +28,7 @@
>>>>   #include <linux/xarray.h>
>>>>   #include <linux/power_supply.h>
>>>>   #include <linux/pm_runtime.h>
>>>> +#include <linux/sched/smt.h>
>>>>   #include <linux/suspend.h>
>>>>   #include <acpi/video.h>
>>>>   #include <acpi/actbl.h>
>>>> @@ -1473,6 +1474,13 @@ void amdgpu_acpi_release(void)
>>>>    */
>>>>   bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
>>>>   {
>>>> +#ifdef CONFIG_X86
>>>> +       if (!sched_smt_active()) {
>>>> +               dev_warn_once(adev->dev,
>>>> +                             "SMT is disabled by the BIOS.\n"
>>>> +                             "To use suspend-to-ram enable SMT in BIOS setup.\n");
>>>> +       }
>>>> +#endif
>>> Will this generate a spurious warning on platforms that are natively non-SMT?
>> Yeah; it could.  I'm not sure how we can reliably detect this.  I thought about looking for
>> the 'ht' flag, but that probably wouldn't work for this case.
>>
>> Are there AMD Zen CPUs or APUs that are non-SMT?  Could gate the sched_smt_active()
>> check to only run when it's an AMD x86 Zen SoC.
> Some of the more budget conscient Athlon parts don't have SMT IIRC.
>
> Alex
In that case, I think the best solution is to just revert cf488dcd0ab7.
>
>>> Alex
>>>
>>>>          return !(adev->flags & AMD_IS_APU) ||
>>>>                  (pm_suspend_target_state == PM_SUSPEND_MEM);
>>>>   }
>>>> @@ -1499,16 +1507,20 @@ bool amdgpu_acpi_is_s0ix_active(struct
>>> amdgpu_device *adev)
>>>>           * S0ix even though the system is suspending to idle, so return false
>>>>           * in that case.
>>>>           */
>>>> -       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
>>>> +       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
>>>>                  dev_warn_once(adev->dev,
>>>>                                "Power consumption will be higher as BIOS has not been
>>> configured for suspend-to-idle.\n"
>>>>                                "To use suspend-to-idle change the sleep mode in BIOS
>>> setup.\n");
>>>> +               return false;
>>>> +       }
>>>>
>>>>   #if !IS_ENABLED(CONFIG_AMD_PMC)
>>>>          dev_warn_once(adev->dev,
>>>>                        "Power consumption will be higher as the kernel has not been
>>> compiled with CONFIG_AMD_PMC.\n");
>>>> -#endif /* CONFIG_AMD_PMC */
>>>> +       return false;
>>>> +#else
>>>>          return true;
>>>> +#endif /* CONFIG_AMD_PMC */
>>>>   }
>>>>
>>>>   #endif /* CONFIG_SUSPEND */
>>>> --
>>>> 2.34.1
>>>>
