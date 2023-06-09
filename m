Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93823C7EE2F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 08:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A4FB10E276;
	Fri,  9 Jun 2023 08:37:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADB5410E276
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 08:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnevMVCv+Xav9NxovS9+Z6uFAGKeIaW8HPTiBrbpjwdzeIYZ29JrOhKsKVIdfG8W456RI64EXUvWcOgl85Y8ltS27PNPSinDgao3f1TxUHcxYyOKJgHXSc/tPbjgpgwWYo0ZN/wtamtwa/d6UwMM/0QLN5/A4O14WWy2hgIgPlwm6S27exV5lKM3hmoigymM4s8hPK0LXPMFoQvOjgNqe+dDVf9g2QP+7vShTD2osvpHujxFED5iDBpR04eZY0Jlbnea6nBJvEk+vHUAuQR52hQLvtcHdIEuyfii75dXNQRX28AC1eSKH1G7hOC620xq7sYv7VxiT46wknYU4mXM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAlZjaJEx71O2XIAIsUHDntp/hPG5VrgoXO3PFvrBmo=;
 b=ey/FuogLrM9efUOU7atf8iG4vef6iKrWLxpveXz0Db5DMsxgAimKR1dKA9xUStKfOFiQ8kPeMtmYj/iTtZLsAiLzCe8pIPgnPau29gqJ8cs3TLQwHkwCX/5gyKlgwAegL4TjyzXmzjWQXNqS8u/6waO20VGNm/vvJxV0D6lMTLfQ3ziTVYJSNMP+A32QxLss3jZ3cGejZKF5CN0asZ5+GRGJpxAxoIMzOMl43BZcaE4hbtOt+BICsUxk5SmFlu2CN9Dq7Q2DNSGPlbKoFDB5cQsghOFAu1i9ZJ5ZnrbNVUu0lr88TjZmeQGGPOn7bTzwkMlDvd40UaBp80BmVQiPqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAlZjaJEx71O2XIAIsUHDntp/hPG5VrgoXO3PFvrBmo=;
 b=Hy3vipYOYwvjrYSJWsIc1y6Ny6W0HydUrPl8KL8LIRSk1r09gXM1Txeg+/3JR2eWQNEzmrM6LNF5IHefy3bJmvvtV3fx+9c+Ll2mIt3Y60gjTtePok2bCuKvVv/nkFxwhq1Jypj1Hc8ZOchyXQj2HDhdNv4eX0eLPDsHwnkqfuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Fri, 9 Jun
 2023 08:37:36 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::c4f0:c05:8644:5637]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::c4f0:c05:8644:5637%3]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 08:37:36 +0000
Date: Fri, 9 Jun 2023 16:37:25 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: =?utf-8?B?5b2t6YC46LGq?= <pengyihao@linzhuotech.com>
Subject: Re: Radeon RX 6800 does not work properly on Think-Force 7140 ARM
 server (generates Oops and causes system deadlock)
Message-ID: <ZILkxTxVGCPU4y3d@lang-desktop>
References: <1523b223-539e-40a3-a005-63c22d03ede4.pengyihao@linzhuotech.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1523b223-539e-40a3-a005-63c22d03ede4.pengyihao@linzhuotech.com>
X-ClientProxiedBy: SG2PR06CA0251.apcprd06.prod.outlook.com
 (2603:1096:4:ac::35) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: ce63cfc7-46f8-44f0-f5f0-08db68c4c705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DN237sKg8YDkInLBZn9HDFiUPvN02qX8IXap0m+rd0PyeYeOoYSicKW5lxzJEsYzijXzyWxunIszpTLYbIkNkV2Ie0L6LC8w0YNof2FRdkMKXY6IX+DzAqlvDc1uBlpF5S4cu3T96xNlJ9bYHev50A3ALW3S0glTFS8HjNgmdiAyKmHZld3Eks7c7+O7bqe3e2SqoGg2iJqRX4qyExAG0ew2WF95/ALfQ6QwwMtdubOYQIJYkCRLf0ONN8fSdXzG/K0wlGfyyuk6sUa9Kb2Wkj7E6XK1f4GZyQDhCVhbzG1hErb62hUwCr8DFbp5lcEO1OIaNtrRRFN6YOe67LDQbSFnO/qoJ2v82dRFSu2LnBZUFRQDw2qvoXYTk8oEcqla0ULhrwyH8nuXTsWAJfThzFyhH1eNxxnlse6AR9ozTZsC3HTuG5cHxehK6uF4+VHzTQh33q/kL8YwKhu2XcWHkHpbET9TAgNAC/2z6/DW4PKEAbyQMsiIJ8EBhLdhlXWG4LKehgIVFSz/F8kKqEPNYdYxF9zuqNTuKdzztQu4B77ICw2OyA3tLXNouyI5DTeV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(7916004)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(66556008)(478600001)(66476007)(66946007)(45080400002)(54906003)(6916009)(4326008)(316002)(86362001)(83380400001)(6506007)(6512007)(9686003)(186003)(26005)(41300700001)(8676002)(5660300002)(8936002)(2906002)(6486002)(6666004)(33716001)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDJSaCtxNDhXSEtpbVRLUFJPb3g0WGd2WlBRUkwySGNSY3ZYNTQrMGh1MnBm?=
 =?utf-8?B?UjFmdkY2WTl3WXk1VEZreVowZFFVK2dweVFmRkVOVWh3RU1BRlJqL0JJczFl?=
 =?utf-8?B?dnRDbEVEMmpDdkN0M3laQ1IxT3RrVy9ZTXN3eHBwSDJIOHVuNXlvY3Yvc3FB?=
 =?utf-8?B?bDZTaXhLVCsrM3ZlcFFwTlZERFN6d2pjQUtEaVpzVnJKYW5YWFZCS2JpZE1L?=
 =?utf-8?B?TjUyK2J3MUQ0KzhvTVowdG9VcW1GRGwwVzFyQ0JuSUcvWkJuNlhpcEh3S21W?=
 =?utf-8?B?d2kza0VIejQ3dVhVNTFtdVdLakRCRWhPMVhMVk9NaTNZczVYRWlJT1dqa2xT?=
 =?utf-8?B?cXNTVmdDT0I5eGp3VnY1TXQ4OXdPZnRNQmhiMDJGSFdIbFNpdlRkUW1FR0Fh?=
 =?utf-8?B?QU5OU2R3T1hGQjh1NEdzM0RaV1BBK1hzUnk1N09oZ2JIbTlUVGYweWQ5b0hC?=
 =?utf-8?B?SDhHQ091eDdmRTRWVVh2ZVNjb015NFFiVS91UEo2c3VXK0VWRW5SUUpaTW15?=
 =?utf-8?B?V2pGTDRQKzBpRVU4Rk9SM0Y5N09zREFTV2l5dFh2eCt6OUZuYXREVnpXdXVw?=
 =?utf-8?B?Rlh1eEJOT1Z5Mi9JaFMzckxSV0tVUWZIWktydXU3S2xLSUNpeE5ZMTVKWC9h?=
 =?utf-8?B?RjM3UGJ1UlJiNllLRGdaNWl4UFJGTXBIWnJvUlhQRGZFYVV1OWN0eldUQ3hs?=
 =?utf-8?B?Q3pJaHdheTFaSTV5N1FRMUZ4UFZvNEphZUN6R21xa2F3UElORmJwUjh5b0VZ?=
 =?utf-8?B?NW9RWW4zZWxuNHlIeEI5WXp6c3BWcUI5ZGl3emVKTDlkYkszZnpEamdCZUdD?=
 =?utf-8?B?N1IyZ2xUaE9ycE5SVUQ3RndoSHF5N00wM1RiZjA1bTlRc2lOQ0JiWTRtRVVy?=
 =?utf-8?B?dTU1K05NMnlKQllNK0ZiTHJaS1l1R0dWOS9EbnVmQ2t5c2NIQVhOdHRkaFRT?=
 =?utf-8?B?b1B0ZWdXQ1hOV1U2eWVqYWhUbzhMckw3MUNqYS9qRG1KMDRQY1IyeHQzSWVE?=
 =?utf-8?B?YkJBRkVHVDlFUEh3M3FlYjdBTno4TnFhWUZ0V1lLZ1FZSGZWVmM4V08vcHF1?=
 =?utf-8?B?MjFwbHVFdGR2dnEwZVBoQTBmMVZubzdHR3IvbTRMN25JcWhPTzRyL0Y0MG9B?=
 =?utf-8?B?Rm0zSUVXL3FhRWFkejV2cTY2Y2lTWm9PUjRxMFFhaTl3R2xEZDZaK3ZnYU96?=
 =?utf-8?B?emxvUTZCMEMwTHowTXRKb3FIdTU5KzdWcDA5Q0pBazBuVDBVOXFQRjVWSUZL?=
 =?utf-8?B?RWh1YVFiQlJSM21VQWNFTEhwQTdrV3hsUVVtdkZkSTNabDV6cC9TR3ZWNWpU?=
 =?utf-8?B?YlBHNlNvVTNDWmU0VURRQWgxRUV2eXJ6djhramlCNVRJQXBuTWhwcFVwSktU?=
 =?utf-8?B?R2NtcDNmeTdCMUhnUzBpSUdUVW9WcHI1ZWEvcnlaN24zd1RMNEpWNU56a1Ny?=
 =?utf-8?B?NVdUc3k3Y0RkeFVaRDVaYW51bys2MmE4ZnhVVVFKSnlXby8wTEppQ2wvVGpY?=
 =?utf-8?B?NjRsTzg4cm5pUk55MFdkd1BjZzROVGxWMDBleVBhR1g4SGttbnl3eGl4ODJi?=
 =?utf-8?B?SnlhZlhvWm1jZmkvb0FjVnpBTzlydDh4L1RkUXI5RG53czFXVHprdTlTclBh?=
 =?utf-8?B?RnMrbEpBejF6OGh5V3RJam1sUzRrbVREVDFqNHcyUndvU3dXZ0M2bXB4VW41?=
 =?utf-8?B?ajVHR1U4Qi8rb0h3TE5mTWFuRWRYMC9jeXZyb0hHRU1IOTUxUHNBNTVJMWNp?=
 =?utf-8?B?eVNHVmNnaDJxYjRjcXd5WFhLMERObmNrVEx6NXhYYXU3ejByYVVXN253Lzlu?=
 =?utf-8?B?cDRzeWFtNnhEMlBhWW5WK3ZpNUYrK3I5bXRhSVJaQjkyVWhaZFBDcHlPR3Y0?=
 =?utf-8?B?MTZTL2J2REg3d2c4WmxBREFrUVNQLzYvd29rbXZ2K25WZVQxampxZ053cXFC?=
 =?utf-8?B?Skg3Rm9xbG9RdTNodWtRcUFLUExjdjFzSnBQQjVPdC9NcGRWWHg1akxKL2lQ?=
 =?utf-8?B?ZjNudFBOMkNwaDJiMFN6cjJPT1ZVSkI3UmYzT0plRzNHdnE4VGIvT1JYdUht?=
 =?utf-8?B?aEdCMDNlMzNhYllpWWRRenErOTJTYkJYWTJ1a0JydGljR3ZnWFFObEphUjRC?=
 =?utf-8?Q?fUSaEII6M6BX0JeTqil6kGI23?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce63cfc7-46f8-44f0-f5f0-08db68c4c705
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 08:37:36.6481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHaPQTxyE0QtQ2Tpzp96w+mVcDGvNjpal6/hxfbrp2mtdEJEbRNIClFFCfUMlztRDuULjk1hrRjeiCyfuVgYSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
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
Cc: "alexander.deucher" <alexander.deucher@amd.com>,
 amd-gfx <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Try to disable CONFIG_HSA_AMD_SVM in your kernel config.

Regards,
Lang

On 06/09/ , 彭逸豪 wrote:
> I have a Radeon RX 6800 and want to use it on my ARM server (Hardware name: Think-Force Technology Universal Server/7140 Advanced, BIOS 1.1.7 20230216). However the presence of this GPU can cause kernel Oops or panic (some older versions). Even if the kernel does not panic, the system will fall into a "deadlock" state and cannot log in normally.
> 
> Below is the Oops of 6.4.0-rc5 (the full log from the serial port is attached). After that, the GPU cannot be used normally, and the system is stuck in a "deadlock" state, and cannot log in normally after entering the user name. If the GPU is removed or replaced with another GPU such as an older Radeon RX 560, the system can log in normally. Radeon RX 560 works fine in 6.4.0-rc5.
> 
> I have tried multiple versions of the kernel, from 5.15 to 6.4.0-rc5, they all have similar Oops or panic, and the GPU cannot be used, and the system cannot be logged in normally.
> 
> The attachment contains the full kernel log captured from the serial port, and my 6.4-rc5 config file. Please let me know if additional information is needed.
> 
> (Note: The previous email did not have the correct subject, so I retracted it. I am sorry if you have received duplicate emails.)
> 
> [    6.535108] cma: cma_alloc: reserved: alloc failed, req-size: 2 pages, ret: -12
> [    9.824070] Unable to handle kernel paging request at virtual address ffffffffffe00034
> [    9.831955] Mem abort info:
> [    9.834737]   ESR = 0x0000000096000046
> [    9.838469]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    9.843756]   SET = 0, FnV = 0
> [    9.846794]   EA = 0, S1PTW = 0
> [    9.849919]   FSC = 0x06: level 2 translation fault
> [    9.854773] Data abort info:
> [    9.857638]   ISV = 0, ISS = 0x00000046
> [    9.861454]   CM = 0, WnR = 1
> [    9.864405] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000001ff5489000
> [    9.871074] [ffffffffffe00034] pgd=10000001b078b003, p4d=10000001b078b003, pud=10000001b078a003, pmd=0000000000000000
> [    9.881637] Internal error: Oops: 0000000096000046 [#1] SMP
> [    9.887180] Modules linked in: input_leds hid_generic amdgpu(+) usbhid hid cdc_ether usbnet snd_hda_codec_hdmi binfmt_misc snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core gpu_sched drm_buddy video snd_hwdep drm_suballoc_helper drm_ttm_helper snd_pcm ttm onboard_usb_hub nls_iso8859_1 drm_display_helper snd_seq_midi snd_seq_midi_event ast snd_rawmidi cec rc_core snd_seq drm_shmem_helper drm_kms_helper snd_seq_device snd_timer snd ipmi_ssif ipmi_devintf syscopyarea crct10dif_ce sysfillrect ipmi_msghandler soundcore arm_spe_pmu sysimgblt sch_fq_codel drm pstore_blk ramoops reed_solomon pstore_zone efi_pstore ip_tables x_tables autofs4 nvme igb nvme_core nvme_common i2c_algo_bit xhci_plat_hcd
> [    9.948668] CPU: 0 PID: 305 Comm: kworker/0:2 Tainted: G        W          6.4.0-rc5 #1
> [    9.956630] Hardware name: Think-Force Technology Universal Server/7140 Advanced, BIOS 1.1.7 20230216
> [    9.965801] Workqueue: events work_for_cpu_fn
> [    9.970137] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    9.977060] pc : __init_zone_device_page (/home/ubuntu/kernel-6.4-rc5/./include/linux/atomic/atomic-instrumented.h:42 /home/ubuntu/kernel-6.4-rc5/./include/linux/page_ref.h:99 /home/ubuntu/kernel-6.4-rc5/./include/linux/page_ref.h:115 /home/ubuntu/kernel-6.4-rc5/mm/mm_init.c:557 /home/ubuntu/kernel-6.4-rc5/mm/mm_init.c:966) 
> [    9.981826] lr : memmap_init_zone_device (/home/ubuntu/kernel-6.4-rc5/mm/mm_init.c:1084) 
> [    9.986677] sp : ffff80000aea3980
> [    9.989971] x29: ffff80000aea3980 x28: 0000000000000000 x27: 0000000fffff8000
> [    9.997068] x26: ffff80000a8c5f70 x25: ffff0001c118d6a0 x24: fffffc0000000000
> [   10.004165] x23: 0000001000000000 x22: ffff800009bc5e98 x21: 0000000000000001
> [   10.011262] x20: 0000000000000001 x19: ffffffffffe00000 x18: 0000000000000000
> [   10.018360] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [   10.025457] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [   10.032554] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff8000094032cc
> [   10.039651] x8 : 0000000000000000 x7 : 00000000ffffffff x6 : 0000000000000001
> [   10.046748] x5 : 0000000000000000 x4 : ffff0001c118d6a0 x3 : 0000000000000000
> [   10.053845] x2 : 0200000000000000 x1 : 0000000fffff8000 x0 : ffffffffffe00000
> [   10.060943] Call trace:
> [   10.063373] __init_zone_device_page (/home/ubuntu/kernel-6.4-rc5/./include/linux/atomic/atomic-instrumented.h:42 /home/ubuntu/kernel-6.4-rc5/./include/linux/page_ref.h:99 /home/ubuntu/kernel-6.4-rc5/./include/linux/page_ref.h:115 /home/ubuntu/kernel-6.4-rc5/mm/mm_init.c:557 /home/ubuntu/kernel-6.4-rc5/mm/mm_init.c:966) 
> [   10.067791] memmap_init_zone_device (/home/ubuntu/kernel-6.4-rc5/mm/mm_init.c:1084) 
> [   10.072297] memremap_pages (/home/ubuntu/kernel-6.4-rc5/mm/memremap.c:270 /home/ubuntu/kernel-6.4-rc5/mm/memremap.c:366) 
> [   10.076111] devm_memremap_pages (/home/ubuntu/kernel-6.4-rc5/mm/memremap.c:407) 
> [   10.080183] svm_migrate_init (/home/ubuntu/kernel-6.4-rc5/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:1029) amdgpu
> [   10.085112] kgd2kfd_device_init (/home/ubuntu/kernel-6.4-rc5/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device.c:647) amdgpu
> [   10.090318] amdgpu_amdkfd_device_init (/home/ubuntu/kernel-6.4-rc5/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c:197) amdgpu
> [   10.096039] amdgpu_device_init (/home/ubuntu/kernel-6.4-rc5/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:2537 /home/ubuntu/kernel-6.4-rc5/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:3871) amdgpu
> [   10.101329] amdgpu_driver_load_kms (/home/ubuntu/kernel-6.4-rc5/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:146) amdgpu
> [   10.106704] amdgpu_pci_probe (/home/ubuntu/kernel-6.4-rc5/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:2149) amdgpu
> [   10.111648] local_pci_probe (/home/ubuntu/kernel-6.4-rc5/drivers/pci/pci-driver.c:325) 
> [   10.115462] work_for_cpu_fn (/home/ubuntu/kernel-6.4-rc5/kernel/workqueue.c:5370) 
> [   10.119190] process_one_work (/home/ubuntu/kernel-6.4-rc5/kernel/workqueue.c:2410) 
> [   10.123177] worker_thread (/home/ubuntu/kernel-6.4-rc5/./include/linux/list.h:292 /home/ubuntu/kernel-6.4-rc5/kernel/workqueue.c:2465 /home/ubuntu/kernel-6.4-rc5/kernel/workqueue.c:2557) 
> [   10.126905] kthread (/home/ubuntu/kernel-6.4-rc5/kernel/kthread.c:379) 
> [   10.130114] ret_from_fork (/home/ubuntu/kernel-6.4-rc5/arch/arm64/kernel/entry.S:871) 
> [ 10.133670] Code: 910003fd a90153f3 12800007 d3490842 (b9003406)
> All code
> ========
>    0:	910003fd 	mov	x29, sp
>    4:	a90153f3 	stp	x19, x20, [sp, #16]
>    8:	12800007 	mov	w7, #0xffffffff            	// #-1
>    c:	d3490842 	ubfiz	x2, x2, #55, #3
>   10:*	b9003406 	str	w6, [x0, #52]		<-- trapping instruction
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	b9003406 	str	w6, [x0, #52]
> [   10.139730] ---[ end trace 0000000000000000 ]---



