Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717DBCD342C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 20:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D91D410EE9C;
	Wed,  6 May 2026 20:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jbYEOQxk";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012067.outbound.protection.outlook.com
 [40.93.195.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98FF110E55B
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 20:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGJDpUWBr6rnxBKbhQ9D3X/NgvbCbYzG92E4jZUUia4/srcKM5b+DvxGrBfuezZ+EoEOGVnIGyEu1k2EnYXpytkqVc5Fv8XSos26yAqPMap8AU3p2pIFMMPumrYJz9+/KDkq/NqGEmhy2IOZy0hKxsyoRO/njeTX+poUim7hvzLyA3Ea0LjOFMRA0fiLE0Ihz7inRoQvO7X4I+5qZV/5C0/apz/vZn7q2dCX8KegM4ve2fIIfruW96W3A7+5CQ8WnyyAqTetskk1vUqxoBsYJQRB+V0BLZuy/kkgBMYRAq+xNEBAS9LS7mZVsFojf4r7wWrbuy+9RnmjTq1rh60iWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3O3wwvJ0dzLGwORdNsziGFZMzNMXAPfHpzSf8x79bO8=;
 b=u3NhifgLFsYnlvjiZBgdtjhdmMgpItGwvJj5r8PB9skB2GtrjMrlWx0S4ez9LMpXcjWrf7BlxkWSjv/tnfUtexk5TMqRIqMz0JPwhjjWGGhQ3hf9nxRzGRl4TOmszXFzCF1Lt4dOZhGLrsuR6KdrI8eQErS+8qo1iAxNNqns+3/5I8Yn4cyiNSkoVTbzhQzS+To4mBvx+dj3bKtIUDawt6hK+QDhL1yumNaxkLd1L5aoqGaKbCV2/fs44b9vynnEejtZCQ0izeTSXGaJUewFVAs9l4XBJynAGROAdmLOY7z63qjBXagN3PDWHF0y1gEjiSLfQshJPpzzuk7pm/VTaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3O3wwvJ0dzLGwORdNsziGFZMzNMXAPfHpzSf8x79bO8=;
 b=jbYEOQxkys5H0G10u8WqfRQ7vHku/T8/tQl80gvBBzbpQSEnUe1Ymd+tI34S7IadyDPttUYQQ1Sr7Z27Ev9+vwdSKR809PHZhFJgmpD+iTR2Nu70dsl/b2N/MhdYTl7LcMPxVqXel/S+tG9iwVqEfk66wmFxTLT6Z0NB6kB7Jw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:32:20 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:32:20 +0000
Message-ID: <dc74c28b-e4e0-4617-b5af-317e29625782@amd.com>
Date: Wed, 6 May 2026 16:32:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Use vline2 interrupt on DCN instead of
 vstartup
To: Leo Li <sunpeng.li@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: Aurabindo.Pillai@amd.com, mario.limonciello@amd.com,
 wiagn233@outlook.com, sysdadmin@m1k.cloud
References: <20260504183649.165131-1-sunpeng.li@amd.com>
 <2349271.vFx2qVVIhK@timur-hyperion>
 <d988ded3-92e5-4900-b6d1-887a96891852@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <d988ded3-92e5-4900-b6d1-887a96891852@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::15) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: 12825af8-4a81-4da8-20f3-08deabae9262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: N+priuZ3LV+9wsRSfPLPnmKYnqU7JCozHgH71BacPuDAzTbRtHnyBgY8vDRL7xBXqa2QwEfNsP/JIzYsj8Cmy78O1oJRITojCJ4Qt5JbebtUAzV06s5gUd2UJKPWf20oNHjXFO9oXOY0iKw67M+zXN5gWrW6lRmqCqKNixljZJjVxLKayf/uAIt+xIJRAd0/utr8AQGWEiE5nbAWJN+HEoNJocPME1WFgDBOeQVmtTP4fmdkYnFEFi/N4Oeq1W3jxELRW7VNalovniuGftV4QX5jtR10kevTKRmoz/5M1A3HBZTSAnTnPk9xlBvRgemtCvyxgEzBo0gxq+jZ/ovQ0gZUazF3DGDiskk6C7rWhIljzY+C8fxZ/AnvJXBC7wJDr6Bb4jV3R6ZjaFsQTmo83SzStSs7N3AOElkrAYDK8dELh3q/QXFKXaWPC7yr6BMC83LDMk4d9+MUW/lyWuQ1uB0XZJWM88fdAj9g/Ryofz/tn1uvZlrQJnPXj9fMOfg9c/phnEuHp4rjgUzQen36brFmGSrYhz2WJczJe6MMfGkF7X35nDOv/kWNH1cNrHEwjNyJCWB0RoqMSfVz+BjyBfiY8dmAu8bk/SajQM1HqasyVDQIi/P0eWZLTG5HoPK4kKfC1mysQVyLRn0nk3Hs3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elJ4eTFtVSs5R2gycng0NlkxdEtMSVNmQm82WnZKeTBMbUY3czZXY0tISnRK?=
 =?utf-8?B?NTQweUN6THFtWTNsUVVzVCtpOFVOQ3U0VFpMeUNlK0doSExFMThLSXM2RkZT?=
 =?utf-8?B?YW1YejV1cWNiMk9lK0QwbEZ6a1k5RG5rdEw2V2JHV2dWNkdMbzA0Q3FEOWVz?=
 =?utf-8?B?cFFHaFBoTUdhcGE1NkpsZ0kwZHVqN2FCSHdkbk1EeHdzWFVyb2FLcTF6akpj?=
 =?utf-8?B?WjlzeGtWSlVOMHcxU3o4UTdjMFVmRXlPa21WQ3VRRU93MFB2dHRmcjk1MkpV?=
 =?utf-8?B?Ymw1V01EQnJITzNhdDI2dU12OWZveWt4YVMyZ0UyVjRMM3poUkplUGFPUUh4?=
 =?utf-8?B?RXlQTjBKb0xudUoyUER6VmtIZXNZNDhEd2c1UWtBQ0tRb2RvZStVbnVrcHdU?=
 =?utf-8?B?TTUvYTFYWllDbTR2d1FWNXBvNUlZdytTdDB4YXozTzBUMXg4UlBNb2pvTFA3?=
 =?utf-8?B?MnZTWWVpVzRScE5xRnk3dXo2UlRNR3J2Yyt4Q3VIZTBPbmhjQm5KVjgvblF2?=
 =?utf-8?B?dVlmMU4vUmlrOTR4eUZLY2ZQWDRvQUtxNnVvUWhsd3ZrdDBkak5kOHJGNjY0?=
 =?utf-8?B?TXBCYlJXQ3lkaUhRYzcwT2plRmtKc2dsQVJJU1FMVWVkdkQvazZNNDhEcXNO?=
 =?utf-8?B?Qm1YQWhjdTdYUVpEcEhsZzVveXhSY0pWbnRDT2xFREhTUElIUmdOTkJta3Iy?=
 =?utf-8?B?ZVpPanJkbkU5d2ZhbVprOHRWTzlhcUwyQlNuVHc5WURjZWR0aDhWbVJmNW9L?=
 =?utf-8?B?RmZlUDVZa0R6ak9kR3k2Rmd2b3ZiRnVwdFdYRmRjejhhc2swVGx2am9teXhY?=
 =?utf-8?B?MDNhcHNLWHFTWm5LZHhRUlBab1YrUzJGMjQvbE1BNXpwY3JxTVBaTEpsRzIz?=
 =?utf-8?B?VWZlc045b3BPVC8ySDNIQTgreVRzUWphZHpKSXgwN3c0V1BkZ2VuTEF6a0pP?=
 =?utf-8?B?TkNTS2lVbWVFN0lHaFlhZ3F2bnlaMWxSM1NMbVh4UVY3bVpEZWN0eUlwWVdz?=
 =?utf-8?B?ZXAyRVNUMUQ1aVRReFFYR1JtVnZFTkwrSXBLWTR4dGw4K2N1em9rSmRkNHNv?=
 =?utf-8?B?T3BXelEwMUFpQXZXbU01cEJKU2pXREdXRzVobG1ENDBoN3RQaVZCTXJScUdD?=
 =?utf-8?B?K1ZoTTQxQ0hmUE1QclFtZWVYd3FxTHJEbWJpWFpWanZDemN6Y2xOSXJDNTRm?=
 =?utf-8?B?SVN1RjdlMHRaZGg0a01xdTJKZkN0TFBwUUhZQ0hiQlNPNm9wS0drNWY3SzRP?=
 =?utf-8?B?a29iRUVFc3NNVzlCbmw1aitwMlN0NzZsL2hkRkZOWXdUREZxYjNTRFF6djFV?=
 =?utf-8?B?bmJOL0diYWdYTmNmaTk5Y2hOaUtMQW9EZ3F3TDhvQTFYcFBTYS90NXRqS2xn?=
 =?utf-8?B?VzBJZUt0SUtLT25FK0VPWkhSeXd3RDhFY1M5SDUxa04wTDdiK0xXNXJtdXY4?=
 =?utf-8?B?ODFJeFkvM0FpMlpuZUhtdVk1Z0EraHZKUzVHUHM1QmM0eEJHT05QKzZEQ1dB?=
 =?utf-8?B?NVNBYTVRQUxvTmxnRXNNUTg3RlAyMHdoWCtjM1NtTkxNMk03V1NqT01LUC9K?=
 =?utf-8?B?RnVDVHBudEhTYngrRGpyRmlYeDFVUHloZXk1STZhcm9mUDJBT0FCZDErbkNM?=
 =?utf-8?B?V2FPMTlqbkwweGhJR1BGU08xWGhZWEpHdmJtNndiRldiUjFRNUhvT2o5c05H?=
 =?utf-8?B?ZFNLWEREeXY3OE85QVdwc29xTENtMGRWM29NVUhJRUNsVnVoclQrZDlaMzFj?=
 =?utf-8?B?emxLWHBoNW82ODRWL3pXaW9qTUZSdnhWK2Z0MUgvRXVQamxIbVBmbHdMZXlp?=
 =?utf-8?B?VytDcDAvbUY5WURoNVp1dGZ1UlZ2cWlRTEIxY2E4L0dnSVAzb3NuRmxDUFYw?=
 =?utf-8?B?MUxiOHZEdFNpZHl2Q3BTTzRKckhzdWlWdFRNQXcxYjNlYWREc1ZMS0tocTAx?=
 =?utf-8?B?aWJueUQyam1iek1adVhEdldpWTQ2c1B6STQ1b1lhZ1dYZ2xYZHVNR0FGSUxp?=
 =?utf-8?B?Z3hiMGdPbDN3SGlNY3AzbmNPZURGL2JsbFMzRjJjMlExZHFVanVUaW94Sllw?=
 =?utf-8?B?SkNaT1NBbnRBT3ozM3Y2OGZCRlhqTU0vUjh3VDBzelZTb0g4THJuV2kwS1RT?=
 =?utf-8?B?T0tuTStCZHp1QmtnSnczeUsrOE00ckU3WDNRakMvUmVoRE5tZ2NxcjBWS2Ri?=
 =?utf-8?B?M0VkeEs3SE1JVUljZ0ozYjdQUXJ3UzRhOFNzVmdxTUVvQ0hjZHowTzgvcHM4?=
 =?utf-8?B?TTZXRGQwZC9KdmdUMWNLVCt5bk5oM0tWOEhkRlNMcCtQek0vM2dpSzJ2d0ZB?=
 =?utf-8?B?T091bGZQUWRabFgxeVhWamxVQUhqNVh2eWR2K015VXFrK3ZtMzloZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12825af8-4a81-4da8-20f3-08deabae9262
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:32:20.6522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiiVg4Trq4Cn7NpDWXcq8d1NTTQ2WTWTcRaA+tosOUoEb8PdLRCORZdUxJb7XDJ/ZDXm7YCsGD8/0Q8KQP7/oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001
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



On 2026-05-06 16:00, Leo Li wrote:
> 
> 
> On 2026-05-04 16:54, Timur Kristóf wrote:
>> On Monday, May 4, 2026 8:36:49 PM Central European Summer Time 
>> sunpeng.li@amd.com wrote:
>>> From: Leo Li <sunpeng.li@amd.com>
>>>
>>> [Why]
>>>
>>> VStartup is an OTG event that fires when the pixel pipeline prepares for
>>> pixel scanout of the next frame. It was previously used to deliver
>>> vblank events for commits that do not trigger a fb address update, and
>>> hence a pflip interrupt (hw cursor updates, for example).
>>>
>>> The issue with vstartup is that HW can mask the interrupt in cases where
>>> idle optimizations are enabled or when a HW lock is active. This could
>>> the explain the range of flip_done timeouts frequently seen in the wild.
>> Can you help me understand how that could happen with vstartup?
>> Specifically, what is a "HW lock" and when is it active?
> 
> Hi Timur,
> 
> I should've prefaced this patch to say that this is a theoretical fix. I haven't
> been able to reproduce the timeout issues myself, and this patch came out of
> internal discussions with folks more familiar with the HW. I don't think this
> will fix *all* cases of flip_done timeouts, but it may address some of them.
> 
> (But timeouts aside, we *should* transition to vline since it's more reliable
> than vstartup.)
> 
> To answer your questions: depending on the DCN generation, there can be a few
> things that affects vstartup firing:
> 
> * DPG - DCN can Dynamically Power Gate parts of the display pipe when a
>   self-refresh capable eDP is connected. DPG is engaged when there's enough
>   static frames (detected thru drm_vblank_off) Once gated, even though the OTG
>   (output timing generator) is still enabled, vstartup is masked. vline is
>   unaffected.
> 
> * GSL - Driver can use the Global Sync Lock to block HW from latching onto
>   double-buffered registers during programming, to prevent HW from latching onto
>   a partially programmed state. This will mask vstartup, but vline is
>   unaffected. See dcn20_pipe_control_lock()
> 
> * MALL - A DCN accessible cache introduced in DCN32+ DGPUs that can store fb
>   data to allow for longer DRAM sleep. When scanning out from MALL, vstartup is
>   masked, vline is unaffected.
> 
>>
>> Many users have experienced flip_done timeouts while playing games.
>> In that scenario, would any idle optimization be enabled or is there a "HW 
>> lock"?
> 
> If the game stops submitting frames for ~15 refresh cycles, it's possible that
> PSR kicks in. Though I know there are plenty of reporters running on external
> without PSR support. If it's DGPUs, it's very likely due to MALL. A reporter I
> was debugging with said disabling MALL showed good results[1]. If it's an APU
> with an external monitor, then that's less clear.
> 
> A lot of the reporters seem to be running Phoenix (DCN314), with a common
> symptom of DMUB timing out[2]. If a self-refresh panel is involved, then I'm
> curious if this vline2 patch would help. Hamza's recent patch[3] that enables
> various levels of reset may help to mitigate, but it doesn't fix the root-cause.
> I'm planning a branch with this patch and [3], along with debug dumps on
> flip_done timeouts for reporters to try.
> 
> [1]https://lore.kernel.org/amd-gfx/e415c38b-4102-40e4-a195-0256caf34802@m1k.cloud/
> [2]https://gitlab.freedesktop.org/drm/amd/-/work_items/4831
> [3]https://lore.kernel.org/lkml/20260505182105.420525-2-someguy@effective-light.com/
> 
>>
>>> DCN hardware provides 3 generic OTG interrupts that can be programmed to>> fire on a specific line. Vline 0 and 1 are currently reserved, with
>>> vline2 available to use for event delivery. These interrupts cannot
>>> be masked, as long as the OTG is active.
>>>
>>> [How]
>>>
>>> Switch to vline2 for vblank handling. Today, DC will program the
>>> vline2 position to at vupdate -- the point at which HW latches to
>>> double-buffered registers.
>>>
>>> Since all the vline interrupt types share the same interrupt src_id,
>>> refactor the existing vline0 infrastructure to allow for all the vline0,
>>> 1, and 2 types.
>>>
>>> Since this is intended to replace vstartup for DCN, use the same handler
>>> logic, but be careful to leave DCE on vstartup.
>> Why not also switch DCE?
>> Does DCE not have the vline interrupts or does it not have the same issue with 
>> the vstartup interrupt?
> 
> I didn't want to touch DCE since I don't have information on how these
> interrupts behave on them, and I didn't want to regress anything. Would need to
> do some digging to find out.
> 

DCE's architecture is quite different in this regard. No VSTARTUP, VUPDATE
signals and interrupts on DCE.

Harry

> - Leo
> 
>>
>>> Signed-off-by: Leo Li <sunpeng.li@amd.com>
>> I think this patch should have a "Fixes:" tag or another way to indicate that 
>> it should be backported to stable kernels.
>>
>> Thanks,
>> Timur
> 

