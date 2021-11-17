Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98C2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 07:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99AB561BF8
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 07:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99AB561BF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 105236E55E;
	Wed, 17 Nov 2021 07:12:08 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2041.outbound.protection.outlook.com [40.107.96.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 759AB6E560
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 07:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Awd/uRgJwiTY0QRyqGY4+n5hYf3WAe/G1BNv4j7BlHs/La/ZtiV3T00+rR4RLhs0lHRhnL1yTaw7V72hANXaXbQmqFcVL12AcGtclH81x/yAb22GArKNib2zxn4IsqL8y1r+BjWCILvlROyQyDcCoauD8Q3JNoqovPttBxwo0WDbJI+ewFU3Y/Cxk6SEM8Kjbw311faJWUBTsIDeBa6ICSBifuE4X7u956UlKL/YXc3huvP4qjimJJXJRMVBZW9EkFr3sM+pjO4w7Ek4o35C5c6senhuAAyen8hAMmRkFLstLUUa6NDO/f6uYqrtjisQ8tso9HxOJDHw+1GOVlKTgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJoRCe/d1vNHVMCT656NPb2t7IqwlntUJVeSPy+k99w=;
 b=Gw5LSSHiLzGlarsjdCs16i4RoyGG6bpOtyTE9PRm6r/NcuE8lLrz3750WtZm/MxP0uzB2DGZTbh2mjiaVl04DSjjO77c1S7ifkUZEOeh8c/sVG4BLPdXWnMm+wTYM3fUT6TOK1+2FTwab932cL035iHzaTRu8aYtELFMXDGX/m6qGZvBr4P1fEL7BA/Wbi0EfsAHllMOXaeeILwOdcIhIRQGGR5NNopMvJiysz2jAA2oTOOPFIFHo7lqzcwEX66ld7kN/OD9oF/Ihm4vBUC58fCdJXkWpGXlrWqE3ScXuWBdHBInEz78ze6NPeBqZCL8e3eBT5pAc5r+fT5Y9M0mTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJoRCe/d1vNHVMCT656NPb2t7IqwlntUJVeSPy+k99w=;
 b=Ufo8SipO/eZg+C3I/kVlenNiJuf59wYtQPAcegmE5XOqQLl736uVQhUDZQopsjx00ab+V7trLK4A1S3ErmL/HG+2DwqKp9RHUIV+Lj0aUhjSzEhbUWe3sUXXWHoxiPe6VKjmvzt8OtVyv8R+oAlEe3eoq3T+LxjV9Lj674nQV+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 07:12:03 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 07:12:03 +0000
Message-ID: <856e4446-1735-aed8-c85b-d34aef1076ab@amd.com>
Date: Wed, 17 Nov 2021 12:41:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/1] amdgpu/pm: restructure reporting of clock values by
 smu
Content-Language: en-US
To: Darren Powell <darren.powell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211117062044.4752-1-darren.powell@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211117062044.4752-1-darren.powell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::9) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:97::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Wed, 17 Nov 2021 07:12:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7f377dd-63a9-49e9-7e93-08d9a9998ddd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-Microsoft-Antispam-PRVS: <DM6PR12MB321207589D2AA1A81AFD7AB0979A9@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:77;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w20F1tEzznNJqVbG7RZBRCxuRrF4fNvLOSur3LcmhKCct6YSg6YqLJRnKolk1Cjp9I+386naTFpfY54dB3sjOBubGSHaECAYNLq1wcVtjF4xQjWHEKxVUBMrxcGMRDhya9Eebj6/bPt7WZOoGz+DOQ58aC5rDXq01dRELUI7lnnM6lPyGfrhW3kUItJPRbx9CItKTNnao5E86fl2Q3ZRReATuEt3041SnA9rBRPee2S8Hdf6nOrFszsXRYqVaVBIfGon7rQ4p5E1ySbIBXxVul4ChCv3oBFuD8xB+Oh8vA2l7byU+7CBTK2eh6x9R8QJzbj04zvEEi1YLrUEv2rVGFn7u1d7e8BmOE2c4fPLK0aGhNIxU+pe5nbUMWzc4js2vuJK27WKt2jCxcpSvy86Yu60wyo79XRQlhp6UQh4lTwRjNcwQ8BwsPkgRrRhRPKwDRqI9K2EhjohfyaG03uy03l15jdCEQLSr/sHL0EilF0G4IQ6W6EmYkcZlhgEa1xYxLvo3o8JPZUrFRFGp07yid4iB4kccq2NJdO5VCbo93Hz6KngYzlqbAigovvTA9xrPpbziUoqDqHfwLx8RtyqVYGapFEfhi6KaAZHLvkPzXmp1kCVRhLm4cLhQTI/YyG7AD7UTzcHXLfQMeep1mPZywqVkc6BRq1mamR5pTqFOb12oZbEHFg7DJCgF1XYVBItNlo2CqtLWlg9FtSctbYvjH1ewzyzLx/Y+7SwW1E7M3AnajMb7eT4AwkVt0EUGl5u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(2616005)(83380400001)(66476007)(8936002)(36756003)(6486002)(66946007)(956004)(66556008)(38100700002)(2906002)(5660300002)(53546011)(30864003)(26005)(16576012)(6666004)(31696002)(31686004)(316002)(186003)(86362001)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU10YlhwTmpkSjZ2d25TQVFXb2xXS3grZGNDTkpwclNNdzQwbllXTkdMV1pj?=
 =?utf-8?B?cWk3WXFJT3kybFFoQkFtQTNtUG5Nb0N6MXZlTnh4bExjY0orcUcxQ2tyVUFU?=
 =?utf-8?B?NFZqZkNUY1NTenhuVFJmcWQ5c2IrQlN6a0NzWXFoQjBwdFdzT1N6WXM4ZjVq?=
 =?utf-8?B?TTQvNlYvQUZoV2xhWE1wVG1zcG92ckcrZkQ5QUxKV29ucktBaGoxRld5ZzBk?=
 =?utf-8?B?Vmc3eUI4UE0yRUMvcEtRK0JKak5MNVI2VXhKejN0NjVLMVBCVERvZTd3V3FG?=
 =?utf-8?B?UGVuanV5Ym1iOFQvcGNFNDVGdjVUaEJ1T09HYmtXM2V1cFYwY3FtcFYvc2RE?=
 =?utf-8?B?THczenAybGlDQmdMZ2N0THhKZjdFZDNqdlhONmNtZEhTZ1pXdVVSaVFXOWRG?=
 =?utf-8?B?NWJmajlPekdSWkRpU0xvSXVPM1dadkx6ZVBHTCtsdTNsZXlLTmFKSTdtallH?=
 =?utf-8?B?cUNYL1dZcFduTTBsNFZGOFF1amIwQnV5akt5a0NRMk5KQlRub0ZTaWR2WVQx?=
 =?utf-8?B?N2syRWJwejJLdGtJZVBrRUhZbmdnUENsY0YzNXlld3BVVmRPYmpHRFNLeVph?=
 =?utf-8?B?b25ycldzaVp5dGhlenVYdGFjS0NOZUhVemhQeDlkaVoyZSsyU3RTL2tqU0Fq?=
 =?utf-8?B?TW1XSU05WjFHdUM1TkdXeEJLb1Z1aU5CMHNxVkpseFZrekFudUQxQ2c0RlJS?=
 =?utf-8?B?WEF3dmN2UVN4MjM5NmcyNFhFNWdSZ3RDa1pHbC90RTNSSmtFS3JacUZkZ0Fu?=
 =?utf-8?B?OFk2azQrcUZ3M25FaWxiMWtnV3hEREVyNTFUcFZDMmh5Y3MrbE81ZjllRGZ0?=
 =?utf-8?B?RTJHNnBLaUNXdEVqamM1K3U1MGp3Y1dVbVJjczh2Kytud0I4MjFNemVqU0tL?=
 =?utf-8?B?bjlYTzJSaytLWDFaYjczenpMcUN1Q2x1M0ZscGJ6NEFHTW0rUHg2QjNnbmZs?=
 =?utf-8?B?YzgrT09xd0hQNDlhTTEvNmx6OG5TMXFEaHh4MkJERnRTNytXQTJZMGFRUTJo?=
 =?utf-8?B?TDY0OWJmTlkyOXBzNmpBRGUxdWhhMUl1QkFLdzRwV0pqSHRUSFprbTQxbkdK?=
 =?utf-8?B?ZzN5V0hQZmloUlZHUGJtZUtITFd0RFgzMUszS1lOUmxCcksyWjRKa0pLaXZq?=
 =?utf-8?B?eHI1bVZaWVlQcXJidmRYQ0hBY3FkM2Y0anBqaS9uQSthRkxOMmc4MW05QVRO?=
 =?utf-8?B?RjRzWUhuejd2NjhiRUMwcnUyMVlxN3dkWVVsUTJaRnltejQzWXpTaHJKVkRS?=
 =?utf-8?B?eVkrZTZFUFR4YnRYemJzWnI0N1VFUU9oKzZ0YjFiVjZHQXoxOWl0VzJXN09P?=
 =?utf-8?B?MzBpYitOaXpNa2tJQU5hbkoreVRva0tFQ081Q3pMUkhwTUJ3Qmd6clN0RTdC?=
 =?utf-8?B?SFczSXhnSSttdldpVDBNYWE3Y0NGLytCb1hrL0kxdEJ2M01MaHhmd2tmQmYy?=
 =?utf-8?B?bFJyQzRVdEptRjF6ZHBBcTJ5dllkc1l6MkZRU1dwODNjMDdXYlliQ2hOSzdJ?=
 =?utf-8?B?UVRjUzF4VXRwMnNoTU9nblMvRVdGZGYvRmUxeUhRdzhESkNvTE11Z3ROakpW?=
 =?utf-8?B?K2dSTHk5eFM5WkZocUgyZ0RuQ09GWEFjT3Y4R0NvbVRwbGRnU1JRbkJLekJI?=
 =?utf-8?B?RnZaVDBZWGhSblpXTnBESUtRVEJzYW5vOVhrMzVlWnk5TkpCZElrYmZqeXk0?=
 =?utf-8?B?Yjg1NDlCOEZabUVGYlRGeElCdUh1dXpKVjgvUmxnWmQ3b0ZCbmpIaUsyL3lv?=
 =?utf-8?B?YWhBbGhFM3pObTVseUNkSnV1QmJzdHFvNWRnakphWTdwM3J1N2x0WDN0Zzll?=
 =?utf-8?B?QUlvallUNGRmcW1yQTdEVE5BRFBvY2hJRFVYbWZ0QU8vR2RlNlJia2dSTXdo?=
 =?utf-8?B?SXdVakNLcWNHVmdkR2FzenZUWVRMQmNMWk9lcG9BalVGTjVqNmNvOWlaS1BL?=
 =?utf-8?B?QXRjOVJqbkovZjMvekJqNWg4SW03cE9wZXlPem5xZ1RDQk4vU0lZNWFEeVNt?=
 =?utf-8?B?bHEzZE5MTWxzWmpzbytidW9oamRJamVKRE54MVJXTWtYTm5qTzR4SGFUU2tL?=
 =?utf-8?B?Y0VDcVJtaENUdFk0OVIydytRNVlNeG0xeGJhOGlVTlp6TUp1aHQ2S2tIZ0R1?=
 =?utf-8?Q?8/rI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f377dd-63a9-49e9-7e93-08d9a9998ddd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 07:12:02.8397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKrppTnT7jbGGi7DNezAwBY4is8BTVdsDHoVtW6dvs5df+h4ej30FtsKM+RQCoL1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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



On 11/17/2021 11:50 AM, Darren Powell wrote:
>   Use of sysfs_emit by each of the specific device implementations is problematic.
>   To remove this back to a higher level, this patch adds a new function "get_clock_levels"
>   to the power-management API (amd_pm_funcs) and smu powerplay API (pptable_funcs). The
>   function returns an array of values to the power management module, which can then
>   interpret the array and print the values at the top layer.
>   This patch is only implemented for navi10 for some clocks to seek comment on the
>   implementation before extending the implementation to other clock values and devices.
> 
>   == Changes ==
>    - new power management function get_clock_levels implemented by smu_get_ppclk_levels()
>    - new power management function amdgpu_dpm_print_clock_array to print most common clock
>         list, which can be later extended to use different units (currently only MHz), or
>         other functions added to handle more complex structure (eg pcie clocks)
>    - new powerplay function get_clk_levels implemented by navi10_get_clk_levels()
>    - new helper function smu_convert_to_smuclk called by smu_print_ppclk_levels and
>         smu_get_ppclk_levels
>    - new error return value -EOPNOTSUPP for clock levels not recognized, allowing fallback
>         to print_clock_levels. (NOTE: If pm or dpm not enabled current implementation will
>         try and fail with both methods)
>    - new error return value -EINVAL for unsupported clock level
>    - new error messages output for error conditions encountered at the device specific layer
>         which can be removed if suggested
> 
>   == Test ==
>   LOGFILE=sysfs_emit.test.log
>   cd ~/workspace/linux
>   cp ${LOGFILE}{,.old}
> 
>   AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
>   AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
>   HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}
> 
>   lspci -nn | grep "VGA\|Display"  > $LOGFILE
>   FILES="pp_dpm_sclk
>   pp_dpm_pcie
>   "
> 

There hasn't been any problem with sysfs_emit for these nodes.

The problem is with this kind of usage -

                 size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
                 size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, 
buf+size);
                 size += amdgpu_dpm_print_clock_levels(adev, 
OD_VDDC_CURVE, buf+size);
                 size += amdgpu_dpm_print_clock_levels(adev, 
OD_VDDGFX_OFFSET, buf+size);
                 size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE, 
buf+size);
                 size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK, 
buf+size);


It's mixing a set of data in a particular node. Then the node needs to 
pass buf and offset separately to use sysfs_emit_at

Even then, if you notice, not every data is a clock level data. Some 
like VDDC_CURVE is ASIC specific and have a different format than clock 
DPM level data.

The max number of DPM levels are ASIC specific. In the below 
implementation a max of 8 levels is assumed for all ASICs, but there are 
ASICs which support 16 levels for a particualr clock. In fact the 
implementation needs to pass max+1 as in arg for list_length.

Sometimes, the current frequency may not match the exact DPM level, the 
approximation of what is the current level is ASIC specific. So instead 
of current freq, ASIC implementation needs to pass levels and the 
current level.

In general, the problem with sysfs_emit_at is not related to a common 
print format. pp_od_clk_voltage node is a representation of the problem 
- a node which is an aggregator of different data formats. Also, it is 
difficult to narrow down to a single one across ASICs given that there 
could be changes from one to next.

Thanks,
Lijo



>   for f in $FILES
>   do
>     echo === $f === >> $LOGFILE
>     cat $HWMON_DIR/device/$f >> $LOGFILE
>   done
>   cat $LOGFILE
> 
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 41 +++++++-
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  9 ++
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 53 +++++++++-
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 96 +++++++++++++++++++
>   5 files changed, 192 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index bac15c466733..fbe045811e60 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -310,6 +310,8 @@ struct amd_pm_funcs {
>   	int (*get_fan_speed_pwm)(void *handle, u32 *speed);
>   	int (*force_clock_level)(void *handle, enum pp_clock_type type, uint32_t mask);
>   	int (*print_clock_levels)(void *handle, enum pp_clock_type type, char *buf);
> +	int (*get_clock_levels)(void *handle, enum pp_clock_type type,
> +				uint32_t *clock_list, uint max_list_length);
>   	int (*force_performance_level)(void *handle, enum amd_dpm_forced_level level);
>   	int (*get_sclk_od)(void *handle);
>   	int (*set_sclk_od)(void *handle, uint32_t value);
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 41472ed99253..ca7a6779e59b 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1020,6 +1020,23 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>   	return size;
>   }
>   
> +static int amdgpu_dpm_print_clock_array(enum pp_clock_type type,
> +					char *buf,
> +					uint32_t *clock_list, uint list_length) {
> +
> +	uint i;
> +	int size = 0;
> +
> +	for (i = 1; i < list_length; i++) {
> +		size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, clock_list[i],
> +				clock_list[i] == clock_list[0] ? "*" : "");
> +	}
> +
> +
> +	return size;
> +}
> +
> +
>   /**
>    * DOC: pp_dpm_sclk pp_dpm_mclk pp_dpm_socclk pp_dpm_fclk pp_dpm_dcefclk pp_dpm_pcie
>    *
> @@ -1058,6 +1075,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	ssize_t size;
>   	int ret;
> +	uint32_t clock_list[8];
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> @@ -1070,10 +1088,24 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (adev->powerplay.pp_funcs->print_clock_levels)
> -		size = amdgpu_dpm_print_clock_levels(adev, type, buf);
> -	else
> -		size = sysfs_emit(buf, "\n");
> +	if (adev->powerplay.pp_funcs->get_clock_levels) {
> +		ret = adev->powerplay.pp_funcs->get_clock_levels(
> +					adev->powerplay.pp_handle, type, clock_list, 8);
> +
> +		if (ret > 0)
> +			size = amdgpu_dpm_print_clock_array(type, buf, clock_list, ret);
> +	}
> +	else {
> +		ret = -EOPNOTSUPP;
> +	}
> +
> +	if  (ret == -EOPNOTSUPP)  {
> +		if (adev->powerplay.pp_funcs->print_clock_levels) {
> +			size = amdgpu_dpm_print_clock_levels(adev, type, buf);
> +		}
> +		else
> +			size = sysfs_emit(buf, "\n");
> +	}
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
> @@ -1159,6 +1191,7 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
>   		struct device_attribute *attr,
>   		char *buf)
>   {
> +	dev_warn(dev, " %s ENTRY", __func__);
>   	return amdgpu_get_pp_dpm_clock(dev, PP_SCLK, buf);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 3557f4e7fc30..d8c20a134475 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -610,6 +610,15 @@ struct pptable_funcs {
>   	 */
>   	int (*print_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
>   
> +	/**
> +	 * @get_clk_levels: Get array DPM clock levels for a clock domain
> +	 *                    to array clock_list. current level is first element.
> +	 *
> +	 * Used for sysfs interfaces.
> +	 */
> +	int (*get_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type,
> +			      uint32_t *clock_list, uint max_list_length);
> +
>   	/**
>   	 * @force_clk_levels: Set a range of allowed DPM levels for a clock
>   	 *                    domain.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 01168b8955bf..2de566118422 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2395,11 +2395,8 @@ static int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type cl
>   	return ret;
>   }
>   
> -static int smu_print_ppclk_levels(void *handle,
> -				  enum pp_clock_type type,
> -				  char *buf)
> +static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
>   {
> -	struct smu_context *smu = handle;
>   	enum smu_clk_type clk_type;
>   
>   	switch (type) {
> @@ -2432,12 +2429,57 @@ static int smu_print_ppclk_levels(void *handle,
>   	case OD_CCLK:
>   		clk_type = SMU_OD_CCLK; break;
>   	default:
> -		return -EINVAL;
> +		clk_type = SMU_CLK_COUNT; break;
>   	}
>   
> +	return clk_type;
> +}
> +
> +static int smu_print_ppclk_levels(void *handle,
> +				  enum pp_clock_type type,
> +				  char *buf)
> +{
> +	struct smu_context *smu = handle;
> +	enum smu_clk_type clk_type;
> +
> +	clk_type = smu_convert_to_smuclk(type);
> +	if (clk_type == SMU_CLK_COUNT)
> +		return -EINVAL;
> +
>   	return smu_print_smuclk_levels(smu, clk_type, buf);
>   }
>   
> +static int smu_get_ppclk_levels(void *handle,
> +				enum pp_clock_type type,
> +				uint32_t *clock_list, uint max_list_length)
> +{
> +	struct smu_context *smu = handle;
> +	enum smu_clk_type clk_type;
> +	int ret = 0;
> +
> +	clk_type = smu_convert_to_smuclk(type);
> +	if (clk_type == SMU_CLK_COUNT)
> +		return -EINVAL;
> +
> +
> +	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> +		return -EOPNOTSUPP;
> +
> +
> +	if (smu->ppt_funcs->get_clk_levels) {
> +
> +		mutex_lock(&smu->mutex);
> +		ret = smu->ppt_funcs->get_clk_levels(smu, clk_type, clock_list, max_list_length);
> +		mutex_unlock(&smu->mutex);
> +	}
> +	else {
> +		ret = -EOPNOTSUPP;
> +	}
> +
> +
> +	return ret;
> +}
> +
>   static int smu_od_edit_dpm_table(void *handle,
>   				 enum PP_OD_DPM_TABLE_COMMAND type,
>   				 long *input, uint32_t size)
> @@ -3100,6 +3142,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
>   	.set_fan_speed_pwm   = smu_set_fan_speed_pwm,
>   	.get_fan_speed_pwm   = smu_get_fan_speed_pwm,
>   	.force_clock_level       = smu_force_ppclk_levels,
> +	.get_clock_levels        = smu_get_ppclk_levels,
>   	.print_clock_levels      = smu_print_ppclk_levels,
>   	.force_performance_level = smu_force_performance_level,
>   	.read_sensor             = smu_read_sensor,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 71161f6b78fe..55e6880c2964 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1261,6 +1261,101 @@ static void navi10_od_setting_get_range(struct smu_11_0_overdrive_table *od_tabl
>   		*max = od_table->max[setting];
>   }
>   
> +static int navi10_get_clk_levels(struct smu_context *smu,
> +				 enum smu_clk_type clk_type,
> +				 uint32_t *clock_list, uint max_list_length)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +	int size = 0, ret = 0;
> +	uint32_t cur_value = 0, value = 0, count = 0, i;
> +	uint32_t freq_values[3] = {0};
> +	uint32_t mark_index = 0;
> +
> +	switch (clk_type) {
> +	case SMU_GFXCLK:
> +	case SMU_SCLK:
> +	case SMU_SOCCLK:
> +	case SMU_MCLK:
> +	case SMU_UCLK:
> +	case SMU_FCLK:
> +	case SMU_VCLK:
> +	case SMU_DCEFCLK:
> +	case SMU_DCLK:
> +		ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
> +		if (ret) {
> +			dev_err(adev->dev, " %s Unable to retrieve clk freq : %u", __func__, clk_type);
> +			return -EIO;
> +		}
> +
> +		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
> +		if (ret) {
> +			dev_err(adev->dev, " %s Unable to retrieve clk count : %u", __func__, clk_type);
> +			return -EIO;
> +		}
> +
> +		if (count > max_list_length-1) {
> +			dev_err(adev->dev, " %s Too many clock values", __func__);
> +			return -EPERM;
> +		}
> +
> +
> +		clock_list[0] = cur_value;
> +		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
> +			for (i = 0; i < count; i++) {
> +				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
> +				if (ret) {
> +					dev_err(adev->dev, " %s Unable to retrieve clk freq : %u", __func__, clk_type);
> +					return -EIO;
> +				}
> +
> +				clock_list[i+1] = value;
> +			}
> +			size = count+1;
> +		} else {
> +			// for fine-grained dpm, display cur_value as average of max and min
> +			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
> +			if (ret) {
> +				dev_err(adev->dev, " %s Unable to retrieve clk freq : %u", __func__, clk_type);
> +				return -EIO;
> +			}
> +			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
> +			if (ret) {
> +				dev_err(adev->dev, " %s Unable to retrieve clk freq : %u", __func__, clk_type);
> +				return -EIO;
> +			}
> +
> +			freq_values[1] = cur_value;
> +			mark_index = cur_value == freq_values[0] ? 0 :
> +				     cur_value == freq_values[2] ? 2 : 1;
> +			if (mark_index != 1)
> +				freq_values[1] = (freq_values[0] + freq_values[2]) / 2;
> +
> +			clock_list[0] = freq_values[1];
> +			for (i = 0; i < 3; i++) {
> +				clock_list[i+1] = freq_values[i];
> +			}
> +
> +			size = 3+1;
> +		}
> +		break;
> +	case SMU_PCIE:
> +	case SMU_OD_SCLK:
> +	case SMU_OD_MCLK:
> +	case SMU_OD_VDDC_CURVE:
> +	case SMU_OD_RANGE:
> +		dev_warn(adev->dev, " %s Unhandled clk_type : %u", __func__, clk_type);
> +		size = -EOPNOTSUPP;
> +		break;
> +
> +	default:
> +		dev_err(adev->dev, " %s Unknown clk_type : %u", __func__, clk_type);
> +		size = -EINVAL;
> +		break;
> +	}
> +
> +	return size;
> +}
> +
>   static int navi10_print_clk_levels(struct smu_context *smu,
>   			enum smu_clk_type clk_type, char *buf)
>   {
> @@ -3241,6 +3336,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>   	.dpm_set_jpeg_enable = navi10_dpm_set_jpeg_enable,
>   	.i2c_init = navi10_i2c_control_init,
>   	.i2c_fini = navi10_i2c_control_fini,
> +	.get_clk_levels = navi10_get_clk_levels,
>   	.print_clk_levels = navi10_print_clk_levels,
>   	.force_clk_levels = navi10_force_clk_levels,
>   	.populate_umd_state_clk = navi10_populate_umd_state_clk,
> 
> base-commit: eabeb4f20a0786188fba07a2dd1b0a614c4e15f6
> 
