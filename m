Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D51C54EBC
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 11:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6CCC10E1A4;
	Thu, 12 Jan 2023 11:50:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF6610E1A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 11:50:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDi2CqdysyPidZFHDMXXogBcr2IXUbD8Fd9fFB4cbASlLNFcfABQT/unPK+ME6888ubZue8P1XOUSHZveBonBcqhTq3TH35bCplkn1bEsGKApg+fTs+iXNrfMc+4DzRz/bSdwPMfFlCK7UaZNXFqLlwcSvFmigFl8L3D6CPOe+uskZ4Yfk7lHfqZaIHxH+S/15xhPSWX4yXcN9n6RLqRRM6Tfo9xvmX5CrKQY1O6I8/uFgSiFcHY3I5QuPDTb0ZPifBu5eHyeCQUxATFb4xnWme27sE+PgzE8PUjj+KrHPITVG5ynPlBXwCiB59TCbS6c4yUSGRTc/naXMvWzFA8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mHm3NukN+xmZyn8S0so1aafETKJr01VFUcGoIo1+pw=;
 b=NODTEgCyjeztvDRljyqCDJixesoQScI3KfN3ZfGetkXCKvqA7v1/aty4WykJnyaGluJdSd81sU8kuc1WUw3khfpLX1WjHXdaey2riIGLPw42TmctCsPC4Fp+NHpUAv59IxMoYncRDNzgnCZOHq9AJXILYS/i3lbQHD5LhycBHFth/FblndrShPw91Jgn9y1m8HHq5OuIs/dqX2sMk31U5lMmjmqnQ14Tdh9BwrmxwqQPyyCsIeqgCp7hka6V2wU3GbSLsYyAMYWt41YfYlT1tVePhSrdshGPP6AeFvMRJMASLH6bPze7d5Zll1lsmddCcw3yP261AiKZDm9O9dQqBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mHm3NukN+xmZyn8S0so1aafETKJr01VFUcGoIo1+pw=;
 b=rMJ6UM7YE7Ioc1bvRrWSg2DyhMDSet1R5CRD+Yk/JMhH/jbhAIhWesbLEQhGqyPo7F5bYa/9dLHg2wxpe6sgv0Rqd0v+mPJ9uiikyLvmH9BPitYmY0IDBZzWHlwgn9P53XjUw13Xc8ol5MsYMHpeJCLbW0GLFPQ2NdyR4elI9tE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 11:50:39 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 11:50:38 +0000
Message-ID: <e931b723-d4bf-be9c-0f08-6f3bf00eb938@amd.com>
Date: Thu, 12 Jan 2023 12:50:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
References: <CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com>
 <0931a762-c3a3-16c3-33a5-88e83fca4bcb@gmail.com>
 <CAAxE2A5pBqOkny15tSRCWn_UW8=TTE=zYPChBZofZCrHZoQbww@mail.gmail.com>
 <35304b1e-98a7-d342-9f1b-50f07b45cf98@gmail.com>
 <CAAxE2A6KJWPJ3eqKoaiJZUJCNqRpx+WYwoGEZKxX2Kf_auLUWg@mail.gmail.com>
 <a90b0e8e-dd02-031f-0432-1c5f6f02e949@amd.com>
 <CAAxE2A7PJdiPORP-X+7kFmix9pCo63PqeamP20BZJx4GDfJdEQ@mail.gmail.com>
 <8ec2b238-fa8b-a693-b9d9-3a590cc05664@amd.com>
 <CAAxE2A7G_gjvuGNNtZ6J-4R25Ykx8ziz1B2f0Dc3KuC4KeYdzA@mail.gmail.com>
 <BYAPR12MB461473D2083BC8B9FB012AC297F59@BYAPR12MB4614.namprd12.prod.outlook.com>
 <CAAxE2A4F59qttYfrT66v4Fe0D1h4Km=DLY779uC=HHSGswg4Lg@mail.gmail.com>
 <CADnq5_MLO4FLXrmUXPUzo2UBzqxa_hjfL0qBzibWAqO79uhxvw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_MLO4FLXrmUXPUzo2UBzqxa_hjfL0qBzibWAqO79uhxvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: ad09d3f2-790c-4b92-1ff3-08daf493395e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1zZ62AdpQilBU/YugKnF+PssIz5mE34alv0z1ptnX2T8pbblWvDi4NSvUvE1GQEdAN76ti+dLd0XQYp67/2Veg9xblCa8ysKQb6ajtGJmR2ht9o1RikKcCwNbVaHTk8zdEgo+jIX0AhWJE2R3B1sAE6OhecSaVpxcONpqmHkH4og5DqGeWsuolfI3uz7iOJv/SA/Br7u8zivjIgV8H6z99lo5uQG2eq+CjoCMV4xVbrm7KcyI8blf/rt9BoUniqS23HQJ0JGhR2jxtgqKN1vbH4Fdq3w2Zn1GURk/2uINcGCMryq+2oVibmO9GNDchO5N+6KtLjBXHY2jRJNQe3LzCoa3/3DLFH3AQ5AGm8YDgowNguzx5LHg7QmTxDHpFPAjLlGuAOvn2SPx5/ozNvXrLXlYSD3xVPUNmJ/JOvW3QfL/kDVsRXPaZ4NiWZzIYKGa/d9BmXIqVLU8BGM2YTkT2GNy986FX65tEXSwSRKb0ic4rScO/lB8jN+hoHnqQx85hKMy7jnaaD8iy3pmh2o9H80+s0SQSNEgMdFz9k/I8BKHHmVm9aW5bE3EamN3gm5H94jFHA1Eu/E8cZfRJouVpPDzTibwN8/ckRtxNQ3MwJIGR/TC9y6TfYW44uhogls68wESBPtX3wkqapvxhMNxwaC2LvH2ypDnfOyzMYp9l/PF7WwA0hkl1F5GWDptr2VAe/x45Lh42d45LuGXS4YPxOMvM45HjH8GIMq9J4IAq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199015)(5660300002)(54906003)(6666004)(2616005)(6506007)(36756003)(2906002)(53546011)(31696002)(38100700002)(83380400001)(86362001)(6486002)(316002)(6512007)(110136005)(186003)(478600001)(26005)(31686004)(8936002)(66946007)(4326008)(8676002)(66476007)(41300700001)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHRMU1Rlblpka2hGTXVObFdtTTNMNnd6ZHl6bzRIV1F5b3RpdGMrTjdUR0JI?=
 =?utf-8?B?Q3pHTGlWbWQybGRBT2dkRWNyZEdkRkFhMDRhMEFoOGtkMlpxQ0IyZDg1Mlo0?=
 =?utf-8?B?aXVPYjY4WHdoQnBQa0lldDlQMlZVekNxVGQxL1BkcG5JdEgyQ3UyLzRDaXAy?=
 =?utf-8?B?ektCMmJJRm9kaVlicnRwN24yVzRTSEhhWkR6NHVIMjZ2NnpRbm5CRGw0TzZq?=
 =?utf-8?B?VnJOZXlIMnh0K3BWYlArTlFYK0VvaS8xSVV6aFE5NlNxOFZKazltWERyM0hx?=
 =?utf-8?B?Y2NYQ1RGa3haaUErUk1TdithQU5WVUwyRFc3S3FPSHMvQVN0NkF4K2hxTExL?=
 =?utf-8?B?R3pIUlRXVUtsUEs5dkNha3V6MU1oVWJNRXVaRHVFWVB3VVl2WG80U2YyNllI?=
 =?utf-8?B?OGswK0FXWXNkYkJGUzVFMHdCK3ZDSjBoeHdmT2IySXFUcUtwNWlxMkVtWm9V?=
 =?utf-8?B?SVZ5eUI2cG55NDRGK295L1NySk5hYlI0R1JhS1ZBeTV4aTROMHBBS2lINkJi?=
 =?utf-8?B?QmQzQXFLYlNnRk43c0c0ek1FUVJRM212MXhTczdWVTdtOFMyUHlHUVkvME5s?=
 =?utf-8?B?dWxyQWh1L0NxVktHNEN4MzFaeEVOZGFKUGNXelBtdzBXVXZwbmQvMDh5YUV0?=
 =?utf-8?B?c0svWjhUVytIK2RIWkJWaW43MlM1VXVrNE9aNTJVV2JySWdBbTZ3ZWRtYUsy?=
 =?utf-8?B?UjZSNktLdThsWVZZN1Z2Sk1KdFZ4NmhrNkFFYjVVQzc1Rm96SVYyT0xGanJp?=
 =?utf-8?B?SjdnNHlrc1lTM0o4QnBhaTlLQjhpMmU1ZGpWeHg3cVNXc3pLRkUzc3VTbGpo?=
 =?utf-8?B?YWdhOEtPWVhnVUNjaVRablB3SWZkSzZucU5wVkFYalBtYVQwbXRUdHZneFVV?=
 =?utf-8?B?UTFVdGNHVUY3UE8yTkVrVHdyRk5ac0RRR0VzQXVKd1ZCcHk0MmZLaXFLTG5O?=
 =?utf-8?B?cVdmaXZiaFZ3Y09ZbTFvbEhDQ2cwclhOY0J2N0FCamsxNnh6MWV2UVdwSlpU?=
 =?utf-8?B?dmppMVZ2cHppaDZ0Z09TYk9aYlZ2MkhGWktiblcrcG9UejdRZ1UraFpoUzdM?=
 =?utf-8?B?bENUR1JUSDRXalZVRVJCcTNUb2wvMFkzSlB6NXFueGpINTJMRXErR2lqTUxp?=
 =?utf-8?B?NS9Zc1NKWWczNjVTUWpPNnFVYjArQUxZSi9NcURWUHg2TitEN2pFNTU4dW9S?=
 =?utf-8?B?bWxNdlkvdzkxOElhbUR0SlBFeXM3RkxYc0NOcGtxcmFZVlA3NU5HU3ozbFpt?=
 =?utf-8?B?M2ZGRUNlSEZwTmJFV080NDdoVmxkeGxnK0tHcjRzK0ZwelUxSVN6TmFQOC9i?=
 =?utf-8?B?Z1dkZWxLVXExS2w5cnRZRXVjRkRVblQvWEpVQU1vaFVUYlFjTmUvN0hPNDlJ?=
 =?utf-8?B?QjZXaWdjNHdFMEN0OElDYnZibVVEaXNUSDFNUEpEcm11L3VIOEVWb0NQTlFO?=
 =?utf-8?B?SHRyUmJvQmVzbm1WREtFeUFCUTcrS0RaOE1rNUpiYm9YM05WaS9xMVZheEhv?=
 =?utf-8?B?aGdhaTI2aVJhbUZLUTNDM1o4ZkFuK1pjaTI4M0Z3VFpKY3hXQTlHc2UrQjkv?=
 =?utf-8?B?WkZ1Qm9kZW5TTy8wTmwwbXM5b0V5YnlJdUZUTXBKWVN3UElSVi9yZFR5OXBs?=
 =?utf-8?B?TzlzRUVyeEJKNDhZM1RrOWJRQ01rZzNyY0FxZ1ZFbERoSmg1cG9zS0pBMWdk?=
 =?utf-8?B?RThkSXZadkdBcGlKbmZaT3Rialh5WWRaUFcycVlMQ21oKzg3VTRUOXFEVHRE?=
 =?utf-8?B?RFkrNEUwNG1GanF0Q3czZjVMemZORzdMVDdVOHcxekNXaWlaK0J5V280MWtt?=
 =?utf-8?B?Njd1TTFRR3lBQjhZUVZtRkFlcWdaWXl2QXVwNTltd1MrdVh5VTFyWEdHMUMw?=
 =?utf-8?B?WVFPTWVoV0xyUTYrVVdaZ29La0JZeVBxQXYwMFJyTUtHbjV3Z0tGejNpbVdX?=
 =?utf-8?B?bFRjVllKWlpwSXl5WkpIbnA5Ty9URjBYREN5Tlk2ZnZZNy82YlYrR0tFMDBt?=
 =?utf-8?B?bUNYZEltVSszQ2F1RWg0QVYyejQxOHVVV0tnb2F4UVhMM2pHTmlQZlIwYkhu?=
 =?utf-8?B?WDQzRXNBa3JzZDVBKzJCbTRKeEI2UWdBKzYyN3lJbHFOUnRvTkJFSlRyMU1P?=
 =?utf-8?Q?NN2+iH5OsbGzI2Pd1+sUfjt/Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad09d3f2-790c-4b92-1ff3-08daf493395e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 11:50:38.8529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJUJtNXREykaXoLA2uS6QRkJuEc329kkxCSuVEerN1e2Lf5Q8V5eUtxPG88K11gC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.01.23 um 21:48 schrieb Alex Deucher:
> On Wed, Jan 4, 2023 at 3:17 PM Marek Olšák <maraeo@gmail.com> wrote:
>> Yes, it's meant to be like a spec sheet. We are not interested in the current bandwidth utilization.
> After chatting with Marek on IRC and thinking about this more, I think
> this patch is fine.  It's not really meant for bandwidth per se, but
> rather as a limit to determine what the driver should do in certain
> cases (i.e., when does it make sense to copy to vram vs not).  It's
> not straightforward for userspace to parse the full topology to
> determine what links may be slow.  I guess one potential pitfall would
> be that if you pass the device into a VM, the driver may report the
> wrong values.  Generally in a VM the VM doesn't get the full view up
> to the root port.  I don't know if the hypervisors report properly for
> pcie_bandwidth_available() in a VM or if it just shows the info about
> the endpoint in the VM.

So this basically doesn't return the gen and lanes of the device, but 
rather what was negotiated between the device and the upstream root port?

If I got that correctly then we should probably document that cause 
otherwise somebody will try to "fix" it at some time.

Christian.

>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> Alex
>
>> Marek
>>
>> On Wed, Jan 4, 2023 at 10:33 AM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>>> [AMD Official Use Only - General]
>>>
>>>
>>> To clarify, with DPM in place, the current bandwidth will be changing based on the load.
>>>
>>> If apps/umd already has a way to know the current bandwidth utilisation, then possible maximum also could be part of the same API. Otherwise, this only looks like duplicate information. We have the same information in sysfs DPM nodes.
>>>
>>> BTW, I don't know to what extent app/umd really makes use of this. Take that memory frequency as an example (I'm reading it as 16GHz). It only looks like a spec sheet.
>>>
>>> Thanks,
>>> Lijo
>>> ________________________________
>>> From: Marek Olšák <maraeo@gmail.com>
>>> Sent: Wednesday, January 4, 2023 8:40:00 PM
>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>> Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the INFO
>>>
>>> On Wed, Jan 4, 2023 at 9:19 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>
>>>
>>>
>>> On 1/4/2023 7:43 PM, Marek Olšák wrote:
>>>> On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo <lijo.lazar@amd.com
>>>> <mailto:lijo.lazar@amd.com>> wrote:
>>>>
>>>>
>>>>
>>>>      On 1/4/2023 4:11 AM, Marek Olšák wrote:
>>>>       > I see. Well, those sysfs files are not usable, and I don't think it
>>>>       > would be important even if they were usable, but for completeness:
>>>>       >
>>>>       > The ioctl returns:
>>>>       >      pcie_gen = 1
>>>>       >      pcie_num_lanes = 16
>>>>       >
>>>>       > Theoretical bandwidth from those values: 4.0 GB/s
>>>>       > My DMA test shows this write bandwidth: 3.5 GB/s
>>>>       > It matches the expectation.
>>>>       >
>>>>       > Let's see the devices (there is only 1 GPU Navi21 in the system):
>>>>       > $ lspci |egrep '(PCI|VGA).*Navi'
>>>>       > 0a:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi
>>>>      10 XL
>>>>       > Upstream Port of PCI Express Switch (rev c3)
>>>>       > 0b:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi
>>>>      10 XL
>>>>       > Downstream Port of PCI Express Switch
>>>>       > 0c:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
>>>>       > [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900 XT] (rev c3)
>>>>       >
>>>>       > Let's read sysfs:
>>>>       >
>>>>       > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_width
>>>>       > 16
>>>>       > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_width
>>>>       > 16
>>>>       > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_width
>>>>       > 16
>>>>       > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_speed
>>>>       > 2.5 GT/s PCIe
>>>>       > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_speed
>>>>       > 16.0 GT/s PCIe
>>>>       > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_speed
>>>>       > 16.0 GT/s PCIe
>>>>       >
>>>>       > Problem 1: None of the speed numbers match 4 GB/s.
>>>>
>>>>      US bridge = 2.5GT/s means operating at PCIe Gen 1 speed. Total
>>>>      theoretical bandwidth is then derived based on encoding and total
>>>>      number
>>>>      of lanes.
>>>>
>>>>       > Problem 2: Userspace doesn't know the bus index of the bridges,
>>>>      and it's
>>>>       > not clear which bridge should be used.
>>>>
>>>>      In general, modern ones have this arch= US->DS->EP. US is the one
>>>>      connected to physical link.
>>>>
>>>>       > Problem 3: The PCIe gen number is missing.
>>>>
>>>>      Current link speed is based on whether it's Gen1/2/3/4/5.
>>>>
>>>>      BTW, your patch makes use of capabilities flags which gives the maximum
>>>>      supported speed/width by the device. It may not necessarily reflect the
>>>>      current speed/width negotiated. I guess in NV, this info is already
>>>>      obtained from PMFW and made available through metrics table.
>>>>
>>>>
>>>> It computes the minimum of the device PCIe gen and the motherboard/slot
>>>> PCIe gen to get the final value. These 2 lines do that. The low 16 bits
>>>> of the mask contain the device PCIe gen mask. The high 16 bits of the
>>>> mask contain the slot PCIe gen mask.
>>>> + pcie_gen_mask = adev->pm.pcie_gen_mask & (adev->pm.pcie_gen_mask >> 16);
>>>> + dev_info->pcie_gen = fls(pcie_gen_mask);
>>>>
>>> With DPM in place on some ASICs, how much does this static info help for
>>> upper level apps?
>>>
>>>
>>> It helps UMDs make better decisions if they know the maximum achievable bandwidth. UMDs also compute the maximum memory bandwidth and compute performance (FLOPS). Right now it's printed by Mesa to give users detailed information about their GPU. For example:
>>>
>>> $ AMD_DEBUG=info glxgears
>>> Device info:
>>>      name = NAVI21
>>>      marketing_name = AMD Radeon RX 6800
>>>      num_se = 3
>>>      num_rb = 12
>>>      num_cu = 60
>>>      max_gpu_freq = 2475 MHz
>>>      max_gflops = 19008 GFLOPS
>>>      l0_cache_size = 16 KB
>>>      l1_cache_size = 128 KB
>>>      l2_cache_size = 4096 KB
>>>      l3_cache_size = 128 MB
>>>      memory_channels = 16 (TCC blocks)
>>>      memory_size = 16 GB (16384 MB)
>>>      memory_freq = 16 GHz
>>>      memory_bus_width = 256 bits
>>>      memory_bandwidth = 512 GB/s
>>>      pcie_gen = 1
>>>      pcie_num_lanes = 16
>>>      pcie_bandwidth = 4.0 GB/s
>>>
>>> Marek

