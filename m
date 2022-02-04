Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4030DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 19:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D062210E655;
	Fri,  4 Feb 2022 19:15:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD79110E655
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 19:15:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTc6OcXPWHUyDCZ0MBCdhp6UglFJKhf7S0VnHTsEY9ozJsfETsAQhcWBU4mWiqgb7FRgKiE1jRcTwYLM7p+99bTS6I3mTEOuHPKUpFu3JhAOxhLTRWRrRbNXkcPo3vHPkg+1m2xvyQvKjLtZAAICBF8mjK9bYJl9DER2+Fp53SC/GF+blNEpyUFu3I7LYCrAdZ068l6TwFzijE8jo0VmT3OY4cc7msa8FUKXE5CbOeC3VlbOh0aPAdbNGtEc6gXWq2z42im/9pF8iSB1QdWYN1Un1Sc2L4tjFO2W1O2WqyRQMMUuIaaEp722LE0Q+uujIIaepld2zodvRWeuV8SVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKSFtMWoLtw3ErR37DXQmsfIi9QRVbEXv2tRnTCpo3g=;
 b=LsXBsSH3n7OFQf0CvBWsGR7Sm6ilU5FKJ6ijIkCgG97UeG1thiso51SB7YP+kGDIyOGiz/WYNHoKCfyKxo88JQE5DF03um5rzorZlggjJ2kdIr/WHK+Ab6aor7DdzN4xsdkBQIiroapwYDlTP4e+/Bp8hdKM1dh5skV1CRdHg1HfgYT0DTQKMMJGClAxuieZgxdETJKzDT5F2LpwNCtR2sD/4/zaScER3NBvsW+USggj247dY0u4XrJoVKAX5UG86DfXDYOuQqKQZsI7ZNJXK0t21XRF7ME1h5+fl0RgPE/7E3KF1h3JsLmNmqeYEHrQDaqbeLNTuzkpKRJYhR+Wtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKSFtMWoLtw3ErR37DXQmsfIi9QRVbEXv2tRnTCpo3g=;
 b=hGJIObI+xzmb1H6Rk9ieSNVjZ6YTbP3VsKQJJ3KS+vt/4FityDOYSSQntVrPJcKaUpqy3pNQ6fvdy8tMpKPfT3ST4CE0Mo1sXQk47hSBH+Nu0D/lJDuXWhevkrvzu+B0Fxe1UruN030ykchOZRTBmc/fPsoejCZTxrfxgLb+1m0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1531.namprd12.prod.outlook.com (2603:10b6:4:f::8) by
 BL0PR12MB5553.namprd12.prod.outlook.com (2603:10b6:208:1c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 19:15:39 +0000
Received: from DM5PR12MB1531.namprd12.prod.outlook.com
 ([fe80::d01b:f78:ca43:12cb]) by DM5PR12MB1531.namprd12.prod.outlook.com
 ([fe80::d01b:f78:ca43:12cb%11]) with mapi id 15.20.4930.023; Fri, 4 Feb 2022
 19:15:39 +0000
Message-ID: <c8da9980-c2f3-0a8b-9fb8-2da5a3238c4c@amd.com>
Date: Fri, 4 Feb 2022 14:15:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amdgpu: move lockdep assert to the right place.
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20220204085201.30615-1-christian.koenig@amd.com>
 <32b9cdf2-3d71-4228-3471-38584575f41b@amd.com>
 <668b5be7-de6c-4c47-9756-6452f316cd7e@amd.com>
 <108a3c26-df8c-c7ea-2228-25ec69afe50a@gmail.com>
 <df73c8a3-0c85-0402-01e4-38e6bec5af17@amd.com>
 <cc241e74-40a6-7b87-d80d-a338361abd01@gmail.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <cc241e74-40a6-7b87-d80d-a338361abd01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:610:58::25) To DM5PR12MB1531.namprd12.prod.outlook.com
 (2603:10b6:4:f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77ba19fb-fcd9-42b7-8ac8-08d9e812baa9
X-MS-TrafficTypeDiagnostic: BL0PR12MB5553:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB5553828DA542722DC117C739FE299@BL0PR12MB5553.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bXjBG6HZcK2eS+7FV/512+89dyFDJ7lODa+aCBG2u44k6wyF7mpMItWdstPSLxYNs6+h8gZvB4soXO41Gyca7r4ywomuocCDqG7fUTEpMq8X1vp4naM8pnhIML1ZX1W+3j5bC8kDsUs4GFkLbgGmFO1QKu4+FyxNcpgM1Q5VTBi/9zDEcR4R92Jocwfnlli2eBmgbIaUAXkpsWyCVqSScO43MSg7/69PMao5szgNBw4ZGMsghcc3mB+knamPLSQWDsjvcoyoFiymQOF32tm2NzwIISRML++xo2cGbzI7X+swh84lhETTCGFU5kkNDzKgrY42tZkgf4CNuCYwgtrhsMlCH5Qi4FXQR2tnoPTOCjU8kA/qNnof1IA26tXo0W+uAy5Ae0xZ9SZDrn2qBKHH14p/Hblmups1xx8WYVL+Uy+sOLijr1vCmdgbeVlubCeWC2c+R0xEW6UKFat984wNq4oLmwZUb6vabVlkTAjSOCTw3woPR6CMhSck8DqQzGZcb89OJ8QwTp1mvdT7tQ2EqunDXqRTH+wwnORIt5sqeVVhGwl1TAkUQf093c0FzoaKuQbZGzKcRubJQDubGwpc/gKCmT6GJH3kV0g9L8CO3hcW3oKpuNKoNvPgyr7ef1VoApTK75+iJ3+Vf852S06ZzZgNnUeGViO0mOY3MIUJh1QBevNmv64rjeqpB6Sn217dnciK8cuY09q3BI/hDZ/g6DlYn5Kjg1Vd4pRX8JiPTbIisD+kvD7ipdJi93Xdq1Vw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1531.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(6636002)(110136005)(508600001)(6486002)(83380400001)(5660300002)(2906002)(31696002)(86362001)(66476007)(186003)(8676002)(26005)(2616005)(66556008)(66946007)(8936002)(36756003)(66574015)(316002)(53546011)(6506007)(6512007)(45080400002)(31686004)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnB3dTVzQWs2eXp1NDRYbGhUT2xUdHlFa3RYangzNVRBbHV3aWlmcitwYjZM?=
 =?utf-8?B?TmR1M0ZQb2pUZDZWNUpGMXp1OXZ4RFl6amZ1dnRoSEVSbnQ1TWtCaG5lSlN5?=
 =?utf-8?B?REVrTGJjNzBjZ1JvcURXSUllTGJxRFFTMlhTVlNabDR4STJvTG5ZaHMwM3di?=
 =?utf-8?B?NlhuUWgyZ21MTit6eXNaZ2hSVnROMXVLbUxGYjBybWI0R1dNOTY3eEV6b0xI?=
 =?utf-8?B?QlQ3VnZWVmdXVkdIQk5COGdPQldSSlVjYmQ5ZlorRlhrM0srZ1hHUERLemE2?=
 =?utf-8?B?MkNSTFY1a3FMbks2UllVenZQanRsQkRZR0FpQlRZOENHMXQ0SWJycnpsay84?=
 =?utf-8?B?dWtSSzkvWmFiWUVIRHliT0RZVlFid3VWRzltY1BEamNuMmpTQ3hmbHNtMVhm?=
 =?utf-8?B?OUNENnRCS3gzN09oclRaa0RMWkdqZzFvN2duQ1p6OGZSSEFwczZhZFV6WHpM?=
 =?utf-8?B?UTVOQTZSM0Vsam9LSG9XVmpRMDkrMThETGZyNE5GcTBOTHRjVWgxOWZQK3Zv?=
 =?utf-8?B?Q1pBTUFEVS9RdVBLSmtZL1ByZ1J2bjgrN0cvVExsTE1zTW51bjl5cHhuZjVO?=
 =?utf-8?B?dXFIK29kdTUzTEVaaVI3VG0zK0FMb0UvSHhIZHF3OTlsVmhnZlZXM3FoRk85?=
 =?utf-8?B?YlN4djdyN0pWT1RPWFJ4bmxvZDJaTVlobnBEaGFPY0MvcXprNUFSVEx6Z3ZV?=
 =?utf-8?B?d1lRZnk2RTA5N0hDNUxqVVlzVm5lU0hJWllhckNyYTdielR1SWlnS3FsU2pP?=
 =?utf-8?B?ak9IaWdzUFVFSlZva256anEwTVQ2U3YxSll6L25jR3FFTTM1aTZBcDFoc0dM?=
 =?utf-8?B?TG1NZDZ4amZDcXFiK1RjK1Zud0NPa3h4ZXRJdVJ3ZXpuQ3FUY3JWeGgzb1Ax?=
 =?utf-8?B?SkYvNE56OG9Mb3RlSEFCVll6OGRPSTRwZlVLTnVOa2x6QkZKK1ViL01rZ3d1?=
 =?utf-8?B?NUtQblVySTVyL0txWFdPV2pLdTZ2MHNRTEcxS2l4QzVQQVBJU2JQOUFESW5x?=
 =?utf-8?B?NGJSalFDRFBFMGp6NUZ5UThla29OL2NnTktQSnZrTWZDd295TUdTSmRKVUNC?=
 =?utf-8?B?SVRzYWFQbGtDMWNDRUN1UWJhNll6L0lEUERRdHNNVWNCc2Z4U2JVSTBGUWdN?=
 =?utf-8?B?TkY0MmREcHRnUG14anVoTVBPTUNLNmR1cmdaNEZFaU9CMVRQTGFCSE9BL3FR?=
 =?utf-8?B?eHFmWEpVb0FyeHZReVBTak5ZbnI0QWNoeFJmZjJicW1uTjBLelZsZTZZbHY5?=
 =?utf-8?B?OGZlb0x6SHNqMi9pMmlzazFJUVNXeWk0Z0NMWDdVMkVnTDhnU1dPRFMrNllh?=
 =?utf-8?B?OWxYbloyRFJDdHFhR1BCTXF3VFlQY3hoMGl3aGU1SlZVamtvNVVYbURwNk9Z?=
 =?utf-8?B?QjNPME13Z1k4YlBuYkt1eXVYVko2YkZGa3pkNndCQ3FXaXVLakcva2VuZ0Yv?=
 =?utf-8?B?MWhia3dTaHJOclQ2Mnp6V0NHK2dFeFJ2d1ZmTU9FcVRPNVFoaXVlT1NXSmRP?=
 =?utf-8?B?MXdNMjk5bWh6MXpzWGpQSTZIL3d5OUNjYy9kRS8zTUFpTjArTWJibG1Lb1pX?=
 =?utf-8?B?QUZ5a3Nvb0pUWDJRQVZzQS83dER3aHRwdHArT0lwRkl3U0dGd05xKzh1eUpl?=
 =?utf-8?B?NkV2dlhnL2xQSFpWUXBKWGZFUGVlYXVjUWFNWVhCVyswZHZUNFg3N0hWUWdK?=
 =?utf-8?B?YU9LenhNZkxlajUwMjBrSjd3MXM0djBvSXNEU00va1kwQjBpRzB6MWlzdXly?=
 =?utf-8?B?elJFWkZ0TTBjOWdQY0U5UVpHUEhiTlFTNnozcnh5d0h6cE5ZbCtXdkRoWnRE?=
 =?utf-8?B?dmdUa3pobFpmMmozbmFKdTdheHpTT3BJdFlZTWV0MmFHTGJqb0Q4dmhPa3Ry?=
 =?utf-8?B?ellKNlRGUFh5QVptNE9wblFoUXZTMDlXbXU2UTlRaG9UeVhoa3ZISnRZUkR1?=
 =?utf-8?B?VU1vSmlYdXVUKy8zVGJKM29OOWs5K0MwaWluajR1bUl2S1VrQ1NpL2VOTnVU?=
 =?utf-8?B?WGE3RGVxbGlXRVhSVFY0Z0ptZnZBbmRVUU9zZ3dvSHloSXpMbVgyNEVVTUEx?=
 =?utf-8?B?akk3SXpER3A4d09FYmxmaVNXdEZ0VitmUmFCaWNheGtDcE9hZEhWejZia2Zy?=
 =?utf-8?B?Zk5WeStWVTlZb3ovZXlyVm5xeHFlY2w5RjJmeE42dlp1NCttbnpHREFSNVdq?=
 =?utf-8?Q?3ZN7jq4qTb1PfB04CdQibyM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ba19fb-fcd9-42b7-8ac8-08d9e812baa9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1531.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 19:15:38.9926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvDmp43ynAe79IDMZGkTcKY7UjSRVa0tVgd+9WKV9STQSrxWyGywALjIJVmdB/FuSmIoBDG6hau8OlpwlwRGiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5553
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


On 2/4/2022 1:50 PM, Christian König wrote:
> Am 04.02.22 um 19:47 schrieb Bhardwaj, Rajneesh:
>>
>> On 2/4/2022 1:32 PM, Christian König wrote:
>>> Am 04.02.22 um 19:12 schrieb Bhardwaj, Rajneesh:
>>>> [Sorry for top posting]
>>>>
>>>> Hi Christian
>>>>
>>>> I think you forgot the below hunk, without which the issue is not 
>>>> fixed completely on a multi GPU system.
>>>
>>> No, that is perfectly intentional. While removing a bo_va structure 
>>> it can happen that there are still mappings attached to it (for 
>>> example because the application crashed).
>>
>>
>> OK. but for me, at boot time, I see flood of warning messages coming 
>> from  amdgpu_vm_bo_del so the previous patch doesn't help.
>
> Do you have a backtrace? That should not happen.
>
> Could be that we have this buggy at a couple of different places.


This is on Ubuntu 18.04.


[    8.392405] WARNING: CPU: 13 PID: 2732 at 
/home/rajneesh/git/compute/kernel/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2673 
amdgpu_vm_bo_del+0x386/0x3b
0 [amdgpu]
[    8.392586] Modules linked in: amdgpu ast iommu_v2 gpu_sched 
drm_vram_helper drm_ttm_helper ttm drm_kms_helper cfbfillrect 
syscopyarea cfbimgblt sy
sfillrect sysimgblt fb_sys_fops cfbcopyarea drm 
drm_panel_orientation_quirks k10temp nf_tables nfnetlink ip_tables 
x_tables i2c_piix4
[    8.392628] CPU: 13 PID: 2732 Comm: plymouthd Not tainted 
5.13.0-kfd-rajneesh #1055
[    8.392632] Hardware name: GIGABYTE MZ01-CE0-00/MZ01-CE0-00, BIOS F02 
08/29/2018
[    8.392635] RIP: 0010:amdgpu_vm_bo_del+0x386/0x3b0 [amdgpu]
[    8.392749] Code: 0f 85 56 fe ff ff 48 c7 c2 28 6b b3 c0 be 21 01 00 
00 48 c7 c7 58 6b b3 c0 c6 05 64 64 62 00 01 e8 5f be a4 d4 e9 32 fe ff 
ff <0f
 > 0b eb 8a 49 8b be 88 01 00 00 e9 af fc ff ff be 03 00 00 00 e8
[    8.392752] RSP: 0018:ffffaf33471d7d98 EFLAGS: 00010246
[    8.392756] RAX: 0000000000000000 RBX: ffffa08771600000 RCX: 
0000000000000001
[    8.392758] RDX: 0000000000000001 RSI: ffffa08772ae01f8 RDI: 
ffffa0800a426f68
[    8.392761] RBP: ffffa087691fd980 R08: ffffffffc0a4e2e0 R09: 
000000000000000a
[    8.392763] R10: ffffaf33471d7d68 R11: 0000000000000001 R12: 
ffffa0801d540010
[    8.392765] R13: ffffa08771615c00 R14: ffffa08024166618 R15: 
ffffa08771615e60
[    8.392768] FS:  00007f7b80179740(0000) GS:ffffa08f3dec0000(0000) 
knlGS:0000000000000000
[    8.392771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.392773] CR2: 000055839db51eb8 CR3: 000000010f49c000 CR4: 
00000000003506e0
[    8.392775] Call Trace:
[    8.392779]  ? _raw_spin_unlock_irqrestore+0x30/0x40
[    8.392787]  amdgpu_driver_postclose_kms+0x94/0x270 [amdgpu]
[    8.392897]  drm_file_free.part.14+0x1e3/0x230 [drm]
[    8.392918]  drm_release+0x6e/0xf0 [drm]
[    8.392937]  __fput+0xa3/0x250
[    8.392942]  task_work_run+0x6d/0xb0
[    8.392949]  exit_to_user_mode_prepare+0x1c9/0x1d0
[    8.392953]  syscall_exit_to_user_mode+0x19/0x50
[    8.392957]  do_syscall_64+0x42/0x70
[    8.392960]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    8.392964] RIP: 0033:0x7f7b7f8679e4
[    8.392967] Code: eb 89 e8 6f 44 02 00 66 2e 0f 1f 84 00 00 00 00 00 
0f 1f 44 00 00 48 8d 05 21 ff 2d 00 8b 00 85 c0 75 13 b8 03 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 3c f3 c3 66 90 53 89 fb 48 83 ec 10 e8 94 fe
[    8.392970] RSP: 002b:00007ffe6bb0cdb8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000003
[    8.392973] RAX: 0000000000000000 RBX: 000055839db4b760 RCX: 
00007f7b7f8679e4
[    8.392974] RDX: 000055839db4aed0 RSI: 0000000000000000 RDI: 
000000000000000b
[    8.392976] RBP: 000000000000000b R08: 000055839db4aee0 R09: 
00007f7b7fb42c40
[    8.392978] R10: 0000000000000007 R11: 0000000000000246 R12: 
000000000000e280
[    8.392979] R13: 000000000000000d R14: 00007f7b7fb5b1e0 R15: 
00007f7b7fb5b130
[    8.392988] irq event stamp: 1264799
[    8.392990] hardirqs last  enabled at (1264805): [<ffffffff951011b9>] 
console_unlock+0x339/0x530
[    8.392994] hardirqs last disabled at (1264810): [<ffffffff95101226>] 
console_unlock+0x3a6/0x530


>
> Regards,
> Christian.
>
>>
>>
>>>
>>> Because of this locking the VM before the remove is mandatory. Only 
>>> while adding a bo_va structure we can avoid that.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index dcc80d6e099e..6f68fc9da56a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -2670,8 +2670,6 @@ void amdgpu_vm_bo_del(struct amdgpu_device 
>>>> *adev,
>>>>         struct amdgpu_vm *vm = bo_va->base.vm;
>>>>         struct amdgpu_vm_bo_base **base;
>>>>
>>>> - dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>> -
>>>>         if (bo) {
>>>>                 dma_resv_assert_held(bo->tbo.base.resv);
>>>>                 if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
>>>>
>>>>
>>>> If you chose to include the above hunk, please feel free to add
>>>>
>>>> Reviewed-and-tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>>>
>>>> On 2/4/2022 11:27 AM, Felix Kuehling wrote:
>>>>>
>>>>> Am 2022-02-04 um 03:52 schrieb Christian König:
>>>>>> Since newly added BOs don't have any mappings it's ok to add them
>>>>>> without holding the VM lock. Only when we add per VM BOs the lock is
>>>>>> mandatory.
>>>>>>
>>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>>> Reported-by: Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>
>>>>>
>>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>
>>>>>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> index fdc6a1fd74af..dcc80d6e099e 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> @@ -375,6 +375,8 @@ static void amdgpu_vm_bo_base_init(struct 
>>>>>> amdgpu_vm_bo_base *base,
>>>>>>       if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>>>>>>           return;
>>>>>>   + dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>>>> +
>>>>>>       vm->bulk_moveable = false;
>>>>>>       if (bo->tbo.type == ttm_bo_type_kernel && bo->parent)
>>>>>>           amdgpu_vm_bo_relocated(base);
>>>>>> @@ -2260,8 +2262,6 @@ struct amdgpu_bo_va 
>>>>>> *amdgpu_vm_bo_add(struct amdgpu_device *adev,
>>>>>>   {
>>>>>>       struct amdgpu_bo_va *bo_va;
>>>>>>   - dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>>>> -
>>>>>>       bo_va = kzalloc(sizeof(struct amdgpu_bo_va), GFP_KERNEL);
>>>>>>       if (bo_va == NULL) {
>>>>>>           return NULL;
>>>
>
