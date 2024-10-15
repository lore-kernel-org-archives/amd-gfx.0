Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71426CFC266
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 04:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5D3C10E085;
	Tue, 15 Oct 2024 04:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1eUBQPdv";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 100EA10E085
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 04:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmN21uYsuZFGEQjuDoxP3HdPTGdVYRkGMsL5x7IzNH4nbKgof84MpaxvkYUyJLcZKcSgrZhOFWmWSCmc9Z55swP4Pa39Xk5V02ovWO6GyHg1iUHMYp7YLCTO+tR0P3Q/ZrBKR6RQ5drmHCvTs+gxkHDzIGwoYfkwZT/Jt9L3U0kq7IJb4Ic+YxVYdO25T4gabiA4JeslkBJN7RAIH7b+tFPVaqCJbAkq1BQlIWmqF7zR7pAnk08gX7SHKV6h+AAbi+lCRVEeg4UNKTyxxyJ1YLlnEBk3vq/9vo0Mw44l70H+EeufbaOhPdXj+5oFKPCO1TbrP03oJFXx5TBj8StUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XVwIgrtcN6iOz0KlUwengnTrPAdDspqghhg1UwVS0I=;
 b=Nkh0ax7JU5xzky06gx9AaAndTR6HwnmdFz9fGi9iuAyo6EuZ25ICZMXfPHzGZ6v3I/FP+6S+4Lzwx4truHLuQ61mKxuqfUne5JcpKDQ4yQ+q8SS5u2csc75OyQmdJRTiqnJAPQPxhfsu0FlNY7Iw7PHzgHnOLwTOsXvOluQFSGLChQwSecwln4CB/acHnAcDpmT3XW5FqkS9UNRZqst6W5skcCBOlIDMggBRS0hHaeMIe7vxwN+LY6xfApMVODYjktY/qe44z4lh3MAT2B1/QzRra2cwolnXSj/pMkJpNt3eV1CsHV8dtf+CkYF+PKw/z3R0gmVSzuzkVVnVBnMmaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XVwIgrtcN6iOz0KlUwengnTrPAdDspqghhg1UwVS0I=;
 b=1eUBQPdv4i4OdE1/5PRiovwbbmpzBcHfg2gav7LI6zNrPKd80yrwP/aLAlcUaniuu5HpjHnUudDk3CYHeh6JmmfV5ELb3xuMuzk/GGBriCWO64r2jFOiR94BKMjNLuG7HMRM8pknGpSRBbgUDA7cEoRy+qjL8hk00vTmtvbcc7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 04:49:15 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 04:49:14 +0000
Content-Type: multipart/alternative;
 boundary="------------nysO1mhSk4iTffQzXFLx8vPH"
Message-ID: <bb26d8c5-0ae8-4a74-9f8a-799e0d6c063d@amd.com>
Date: Mon, 14 Oct 2024 23:49:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: change kfd process kref count at creation
Content-Language: en-CA
To: Zhu Lingshan <lingshan.zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, philip.yang@amd.com
References: <20241011144155.120290-1-xiaogang.chen@amd.com>
 <c7d42fc6-6164-4080-a90a-b53bd7cd796f@amd.com>
 <15671ab9-264c-4a4e-bb28-8c4da30271b9@amd.com>
 <2da699ed-634d-4710-9539-a28ede17c41b@amd.com>
 <50fd40a9-3369-4016-a93b-b90b5b25e444@amd.com>
 <5e372d79-ceca-4509-8bf6-f18175744817@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <5e372d79-ceca-4509-8bf6-f18175744817@amd.com>
X-ClientProxiedBy: SN7PR04CA0186.namprd04.prod.outlook.com
 (2603:10b6:806:126::11) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 415a16cb-f599-49ec-bda5-08dcecd4b7b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0hBaDdHSXZZeEs1VEVIeVZNWEtkanpMTHUzODN0c05CS1ZFOW12QnQ1c1gr?=
 =?utf-8?B?UDZyWmV4N3Q4am9teFJQV0s3Nkc5cXZiWkZLUkRKQWFZOUNhcXRIc3VOQUQx?=
 =?utf-8?B?Z1lnMktnVTh4cWFrNTJqMFQxaTB4VGV0N0g4V1YzQUdWZmJJZzdRY3hrZVgv?=
 =?utf-8?B?R1FRa2xPbXJPS2RTekNqYXZRUFl6dzB1UHhKNlJTYnpDZWFBZ1B2WFNsUDlR?=
 =?utf-8?B?b1VDSGdYTkJjUkZvSWVoVEUzbnNCOFFRNHJGZ2YzdGg4UGtuY3RNakNSQ2hB?=
 =?utf-8?B?T1JRUEZWVk52RGYvOUFuRkR0bDBoL3c0TWcyQzFLWEtMUVgyLzQxNlc1QlZD?=
 =?utf-8?B?YUhoS3IzYjh3TXNoa04wRDhpbGNlekI2dFF0aldIK3cwWXJ0RzBNbmZmMVZr?=
 =?utf-8?B?RitTWDlVVDBaMmw4ZXJoeU5vM1EzRytSTFZDZC9yUVpKRTZnMzNJTFliNVFX?=
 =?utf-8?B?d2RwaVpjZFhUei9OaldtbmNxTkl3RW9BV3U5aWVsNVJTV1Z4TFZ6TU5YTEIx?=
 =?utf-8?B?OFR5elpQNzl3KzhjMmM2czFNR2Z5a0p1a01aZ1g2dVNsMHFDMGlGMmdJc3Vv?=
 =?utf-8?B?bHc0RlVIZTlhSktrVisxMVlWSk9yeUpZVGJ2Um1JZlp2K2dIT2lrMmduajM4?=
 =?utf-8?B?NlRGQXJCZVVLZmZ5Wk9NOUNSUVZDeTNSZmJ4TmxhbzJqQTRrb2dER0FBR0t1?=
 =?utf-8?B?UngzSWMvZ3pBNU1Sem8zM2d2QzJtMlk5VGJjcFF1d1ZKVkFHS0JmZ0tKbGZq?=
 =?utf-8?B?Y3hZQ1NlZi9iVlNSWEh0WTlqdm1rUVVoNGxJS28zYUNmMXhBcTdMSUxlM2JQ?=
 =?utf-8?B?ZXd5VDFJT2FNbWFDR01vQWRzODVObFVZRkJOUHNZbXBhVW5rcGRjTzZMem5B?=
 =?utf-8?B?SzErd05rdlp2Ry91QTVxa0NoQWhEakN5N1MwcHJQNmd6L0NjRjQyU2UrKy9w?=
 =?utf-8?B?VkI1VDBGTkhndGlNRnVFSDB4SG5OSlJRZko2SzJTajEyM20rOG9LV0F2bVhM?=
 =?utf-8?B?aXhkOGVzWWFvK3lnMllucnJEZkYxS3A1cHhaWEpaY1ZLNDMxTzZGRUtDdERB?=
 =?utf-8?B?N2dxdGdpRXR6bFBhSUc0L0d2aDVwZ2xBMGVzSVJjWDRTNklVeHB5eHUrMDdL?=
 =?utf-8?B?eFlXVEExSHZsZ1NtLzBvVjRKaEQxbk83aHNRSUREVWFER0grMDZ4S0RZUnR6?=
 =?utf-8?B?NjhleWdmeUVKRXJWU2lTS0IrY0NIdGhwT1Jjd3ZIN3JiVUxsTFNuN0lvUnY2?=
 =?utf-8?B?ZFQ0L1hGZGxlTGdqZkxIZ1hTaXZTWnM5VEFhREx1ZFcvUGNFd3EvL3NFMDhE?=
 =?utf-8?B?NENWKzJ4WDZMNXVUdFRJSFo1SjNtcWlHUHBYTU1YcCtpcGduU3NsWC8rTzA4?=
 =?utf-8?B?d3YvQXhEYTFDa2h4S0NsVlNRclJvOWlSYjR4Z2NJbCtvWWZGV29YWmsxZFRw?=
 =?utf-8?B?TTBGTGtDTlBBR3NMTGRKZ1pzZGZEVU41WlVsMW9lQ2VveVpJOWNYbGF5ZXVo?=
 =?utf-8?B?dWtoODdObEJubXJCRndzWE1kTDlRaEhXTEExdUVPNklEdTZWaE1mcm9meUJy?=
 =?utf-8?B?amlHK3JCckpvM0lzQUptK05uL0dGRktaNXhYLy8rUVZ3SWpEYkRqeklEd0hz?=
 =?utf-8?B?NjdDZjEwMDBpNE1udkdqaWFYZ2VMVEh5Z0hSUWVPWndwYVpRQm5NKys1bmJr?=
 =?utf-8?B?OHpQdk0xMkk4cXBzSmdodkZCSUVsSDFpS2w2d3dhdkxnK3hBTUpVVG93PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djRNanBwU1pldTJMTzI2amhDeEZicFc1bVFoVTZGZElidEJQZ3krZW1mU1FX?=
 =?utf-8?B?T1lBV05qSkdSdFhiUGlkZ3ZxYU54VnN5NkFLbldOQThoODZ6eXEva3lSTmFh?=
 =?utf-8?B?NytyVHRlWXNXUmJib0dkREsyWGQrVWlkMGFrTDN3Q2tnbWZSRkFjRjl6Yno0?=
 =?utf-8?B?K2pjRUJmT3BDaUthdmhKNVF3WjhXYUZtWlQzWDlQTGdJNXQ0V1VleTFaTVZD?=
 =?utf-8?B?VXNkUTk5U2VzSTk3QlJ3ZzRoVXdqdDRpZTQ3SDExUFQwd0Jhd09lKzBGbTln?=
 =?utf-8?B?N0NramwxV1VSZFNTY2VoOTZEbFNJdUFBS093VG90Zno0SkJSK0YwTDRlNFVa?=
 =?utf-8?B?VGV5NHZVOG0rTUc5ZjJmZzE1UXJ1aTRxUjlnSzNhc1IvQk9SWEVXaGZYNUt3?=
 =?utf-8?B?NkdQbVE3TmxreElyZmlrdFM1QmJXZW10RndINkVBWHYxTitVN2VnakhYS2Nm?=
 =?utf-8?B?TWdPNmJYOU1sYk5PTTM3ZkY5VmJkdkEzTkJ2NHNHcG9NTmdTY2FpczNvbk5v?=
 =?utf-8?B?T3g3VlJLQXBSeFR0OE1nNXpUOGFHQUJMaTBydE1UbmR5blFaLzdKZkZiZnJE?=
 =?utf-8?B?NElBZFFhUW1IKzRSay9RQnl1TWNNQjRCZjFNam1Yd2dWL0lubU1Md2Z4b1Nn?=
 =?utf-8?B?MFVwejNXSGgyakc0eHBlS29lY2RPSFdUSTZvYnhjaHNEM1FGbVNJYnJlMU9u?=
 =?utf-8?B?VlBhdFlTajN1WTEzRC9mUFViR01wWmd1TXVpNUJ3YXJ3REx3SHo5cW1jSS8y?=
 =?utf-8?B?L04vRW1jRnRBcFhJZy96ZFNrUktFdzk1SnVVZUJrTEdwUVZoZGJTQi9JSmFO?=
 =?utf-8?B?TEo0Q1Z3U1FZLzBaYUZmaHMrUGJwSzlMLzRJeko1UkhFZnVuTVcvUldzcFNB?=
 =?utf-8?B?Y0Q2NVRuWElEcXpqWnRDUGZEeFdKWW0wcmRDdE5WSDEwV1BIck9UTUwreGJD?=
 =?utf-8?B?NUJMSzduV1NMNnVacnNxdlozbTlCelA0NVJ2MXNKamc3aGdSNWJVSGFNajNh?=
 =?utf-8?B?Q1FjcDNoT1kzR3Rsb0JUVHQrVTZvR21OMlEzcUp2UWlaUjhNd2NBSDQxT2xj?=
 =?utf-8?B?Wlc5bG1OZW9RVVFtaVNoU3pGUk9JSzlsbE5YNzY2MDZQREZRbExBKzFKMXVH?=
 =?utf-8?B?bzFHUVp2SkU3UzFhOUFpRDVwSHo1eWo5M1pKWTh5VVlSWGpSRU5oaTRKSklI?=
 =?utf-8?B?UnpqUnZYSytFRnBtUHZsUjF0MmIydEVGUFpGYVdsV0tGVEVqWEhlQWJtMjhJ?=
 =?utf-8?B?UXFKTUNCUSt3R1VOeE1JZUFKWUdrS3UyM2x0c29ZSzAzYStJSTFBOGpHSWgw?=
 =?utf-8?B?dEVXWElySDR5YzVOVm8wWkxVR1YycHAzVnpyd2ZnUDFER2JTZVpxSm95SXIz?=
 =?utf-8?B?WW1HNzQ2K0N1cUFESWZjcXQ0V3ZHSFFNbjkvVlowYjZTcU52SW9oYlM5TUJp?=
 =?utf-8?B?T0F1blNXUE5ZVkw1YzNmb204T1hMd0VuaXRVZHRUKzl1b3hYZnd1SVVmUS8r?=
 =?utf-8?B?eUpFVG4vbGplc3ZmVzVNV1AzaVl5Rk9rVC9rYVVPK1F2MzdRTDdOZHV1N2kz?=
 =?utf-8?B?RXhjQUFkazVMZWVRYUJkYnZKbDMvVEVMR01hQk05QVdkRzhRU3NjZG0xWXJT?=
 =?utf-8?B?TTh0WmVyRXJlUDRud1YvWHNUUFlGcjJ6c001YXpyZkNBc3FKZ255cW9kR0dG?=
 =?utf-8?B?SlpCVWpsM05IU0hwSWF0UE5BTml4NUloZkhWcXhuc3NtK1RxMlVJNjJsWDBu?=
 =?utf-8?B?QWkyaGx2ZHovQUlmMlVJNTN5Y25iYnRGeVUzU3NvUXd6Q205bGhSYjRVcUhD?=
 =?utf-8?B?SHVhT2UwUzZDaDBRNXZzMU4vdzkvWHg0U0xUVUdqSG5KUi9JZkxOb1BUUEpL?=
 =?utf-8?B?RldoL1VqdGlHUFZDajd6Z0NOZTlMdXZSb3lGSS9DZVEwa0xzVXpLODd6ZjZi?=
 =?utf-8?B?cUJHVXRieXBSMmpUUnVzazN1RnFMRTAvMHluM085WFJqdUpPeG9hd2V3TUFi?=
 =?utf-8?B?cHVmWkFyWkNhUXl5aEgrUmo1ZUFkOE9nY2MvazlwUm4zcXQram5WTHFpcnN1?=
 =?utf-8?B?Y0hkaEN3c2ZUakNYWWVsck5saTBhRHJLRGdEb1c0a3VzQVJQQXIrZWZGZE5U?=
 =?utf-8?Q?YsWM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415a16cb-f599-49ec-bda5-08dcecd4b7b9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 04:49:14.0671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIlGeHnUNou60hZa3qq/Ws4cDMGZR5HjY4dex0+7L4aQCvNy4l9N147cJRsV9nk/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330
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

--------------nysO1mhSk4iTffQzXFLx8vPH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/14/2024 9:51 PM, Zhu Lingshan wrote:
> On 10/14/2024 11:07 PM, Chen, Xiaogang wrote:
>> On 10/13/2024 8:55 PM, Zhu Lingshan wrote:
>>> On 10/13/2024 1:30 AM, Chen, Xiaogang wrote:
>>>> On 10/11/2024 9:56 PM, Zhu Lingshan wrote:
>>>>> On 10/11/2024 10:41 PM, Xiaogang.Chen wrote:
>>>>>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>>>>>
>>>>>> kfd process kref count(process->ref) is initialized to 1 by kref_init. After
>>>>>> it is created not need to increaes its kref. Instad add kfd process kref at kfd
>>>>>> process mmu notifier allocation since we decrease the ref at free_notifier of
>>>>>> mmu_notifier_ops, so pair them.
>>>>>>
>>>>>> When user process opens kfd node multiple times the kfd process kref is
>>>>>> increased each time to balance kfd node close operation.
>>>>>>
>>>>>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_process.c | 15 ++++++++++-----
>>>>>>     1 file changed, 10 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> index d07acf1b2f93..78bf918abf92 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> @@ -850,8 +850,10 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>>>>>>             goto out;
>>>>>>         }
>>>>>>     -    /* A prior open of /dev/kfd could have already created the process. */
>>>>>> -    process = find_process(thread, false);
>>>>>> +    /* A prior open of /dev/kfd could have already created the process.
>>>>>> +     * find_process will increase process kref in this case
>>>>>> +     */
>>>>>> +    process = find_process(thread, true);
>>>>>>         if (process) {
>>>>>>             pr_debug("Process already found\n");
>>>>>>         } else {
>>>>>> @@ -899,8 +901,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>>>>>>             init_waitqueue_head(&process->wait_irq_drain);
>>>>>>         }
>>>>>>     out:
>>>>>> -    if (!IS_ERR(process))
>>>>>> -        kref_get(&process->ref);
>>>>>>         mutex_unlock(&kfd_processes_mutex);
>>>>>>         mmput(thread->mm);
>>>>>>     @@ -1191,7 +1191,12 @@ static struct mmu_notifier *kfd_process_alloc_notifier(struct mm_struct *mm)
>>>>>>           srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>>     -    return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
>>>>>> +    if (p) {
>>>>>> +        kref_get(&p->ref);
>>>>>> +        return &p->mmu_notifier;
>>>>>> +    }
>>>>>> +
>>>>>> +    return ERR_PTR(-ESRCH);
>>>>> this cb should only allocate the notifier (here it returns an existing notifier ),
>>>>> so I am not sure this is a better place to increase the kref, it seems coupling
>>>>> two low correlated routines.
>>>>>
>>>>> kref is decreased in the free notifier, but not mean it has to be increased in alloc notifier.
>>>> Who referring kfd process should also un-referrer it after finish. Any client should not do un-refer if it did not refer. That keeps balance in clean way.
>>> I think we already do so, see any functions call kfd_lookup_process_by_xxx would unref the kref of the kfd_process.
>>>> The current way is using  mmu's free notifier to unref kfref that was added by kfd process creation. Ex: if not use mmu notifier there would be extra kref that prevent release kfd process.
>>> I am not sure this is about paring, current design is to free the last kref when the whole program exits by the mmu free notifier, so it would destroy the kfd_process.
>>> MMU free notifier would be certainly invoked since it has been registered.
>> This patch is about having "get/put" at correct places, or keeping kref balance in a clean way. We have 'put' kferf at mmu free notifier why not have 'get' kfref at mmu registry(alloc) notifier?
> If we place increasing kref in mmu alloc notifier, it is still increased at kfd_process creation time, actually no difference, but inexplicitly done. Others need to dive into mmu ops to understand. Current approach  actually has a better readability.
I think this patch has better readability that it pairs kref of 
kfd_process in "get" and "put". People see the kref got added at 
"alloc_notifier", and decreased at "free_notifier" in same source file, 
not need to dive into mmu ops. When people see it got decreased at 
free_notifier they would wonder why the kref is not increased at 
alloc_notifier.
>
> MMU alloc notifier is invoked through locking, it locks the whole mm, so better not to add extra dispensable code there.
The change is adding kref for kfd_process , not mm or mmu_notifier at 
alloc_notifier. MMU free_notifier is more complicated then alloc 
notifier. free_notifier is triggered by scru callback and we have kfref 
updated at free_notifier, why not at alloc_notifier?
>
> Current solution runs for years and this change actually does not fix an issue

As said this patch is having "get/put" at correct places, or keeping 
kref balance in a clean way. Do you see any regression?

Regards

Xiaogang

>
> Thanks
> Lingshan
>> Regards
>>
>> Xiaogang
>>
>>> Thanks
>>> Lingshan
>>>> The final kref is same. The patch just makes the balance in a logical way.
>>>>
>>>> Regards
>>>>
>>>> Xiaogang
>>>>
>>>>> Thanks
>>>>> Lingshan
>>>>>
>>>>>>       static void kfd_process_free_notifier(struct mmu_notifier *mn)
--------------nysO1mhSk4iTffQzXFLx8vPH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/14/2024 9:51 PM, Zhu Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:5e372d79-ceca-4509-8bf6-f18175744817@amd.com">
      <pre class="moz-quote-pre" wrap="">On 10/14/2024 11:07 PM, Chen, Xiaogang wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
On 10/13/2024 8:55 PM, Zhu Lingshan wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On 10/13/2024 1:30 AM, Chen, Xiaogang wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">On 10/11/2024 9:56 PM, Zhu Lingshan wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">On 10/11/2024 10:41 PM, Xiaogang.Chen wrote:
</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

kfd process kref count(process-&gt;ref) is initialized to 1 by kref_init. After
it is created not need to increaes its kref. Instad add kfd process kref at kfd
process mmu notifier allocation since we decrease the ref at free_notifier of
mmu_notifier_ops, so pair them.

When user process opens kfd node multiple times the kfd process kref is
increased each time to balance kfd node close operation.

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
---
&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c | 15 ++++++++++-----
&nbsp;&nbsp; 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d07acf1b2f93..78bf918abf92 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -850,8 +850,10 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp; /* A prior open of /dev/kfd could have already created the process. */
-&nbsp;&nbsp;&nbsp; process = find_process(thread, false);
+&nbsp;&nbsp;&nbsp; /* A prior open of /dev/kfd could have already created the process.
+&nbsp;&nbsp;&nbsp;&nbsp; * find_process will increase process kref in this case
+&nbsp;&nbsp;&nbsp;&nbsp; */
+&nbsp;&nbsp;&nbsp; process = find_process(thread, true);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (process) {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Process already found\n&quot;);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
@@ -899,8 +901,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_waitqueue_head(&amp;process-&gt;wait_irq_drain);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
&nbsp;&nbsp; out:
-&nbsp;&nbsp;&nbsp; if (!IS_ERR(process))
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kref_get(&amp;process-&gt;ref);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;kfd_processes_mutex);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmput(thread-&gt;mm);
&nbsp;&nbsp; @@ -1191,7 +1191,12 @@ static struct mmu_notifier *kfd_process_alloc_notifier(struct mm_struct *mm)
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; srcu_read_unlock(&amp;kfd_processes_srcu, idx);
&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp; return p ? &amp;p-&gt;mmu_notifier : ERR_PTR(-ESRCH);
+&nbsp;&nbsp;&nbsp; if (p) {
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kref_get(&amp;p-&gt;ref);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;p-&gt;mmu_notifier;
+&nbsp;&nbsp;&nbsp; }
+
+&nbsp;&nbsp;&nbsp; return ERR_PTR(-ESRCH);
</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">this cb should only allocate the notifier (here it returns an existing notifier ),
so I am not sure this is a better place to increase the kref, it seems coupling
two low correlated routines.

kref is decreased in the free notifier, but not mean it has to be increased in alloc notifier.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Who referring kfd process should also un-referrer it after finish. Any client should not do un-refer if it did not refer. That keeps balance in clean way.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">I think we already do so, see any functions call kfd_lookup_process_by_xxx would unref the kref of the kfd_process.
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">The current way is using&nbsp; mmu's free notifier to unref kfref that was added by kfd process creation. Ex: if not use mmu notifier there would be extra kref that prevent release kfd process.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">I am not sure this is about paring, current design is to free the last kref when the whole program exits by the mmu free notifier, so it would destroy the kfd_process.
MMU free notifier would be certainly invoked since it has been registered.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
This patch is about having &quot;get/put&quot; at correct places, or keeping kref balance in a clean way. We have 'put' kferf at mmu free notifier why not have 'get' kfref at mmu registry(alloc) notifier?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">If we place increasing kref in mmu alloc notifier, it is still increased at kfd_process creation time, actually no difference, but inexplicitly done. Others need to dive into mmu ops to understand. Current approach&nbsp; actually has a better readability.</pre>
    </blockquote>
    I think this patch has better readability that it pairs kref of
    kfd_process in &quot;get&quot; and &quot;put&quot;. People see the kref got added at
    &quot;alloc_notifier&quot;, and decreased at &quot;free_notifier&quot; in same source
    file, not need to dive into mmu ops. When people see it got
    decreased at free_notifier they would wonder why the kref is not
    increased at alloc_notifier.
    <blockquote type="cite" cite="mid:5e372d79-ceca-4509-8bf6-f18175744817@amd.com">
      <pre class="moz-quote-pre" wrap="">

MMU alloc notifier is invoked through locking, it locks the whole mm, so better not to add extra dispensable code there.</pre>
    </blockquote>
    The change is adding kref for kfd_process , not mm or mmu_notifier
    at alloc_notifier. MMU free_notifier is more complicated then alloc
    notifier.&nbsp;free_notifier is triggered by scru callback and we have
    kfref updated at free_notifier, why not at alloc_notifier?
    <blockquote type="cite" cite="mid:5e372d79-ceca-4509-8bf6-f18175744817@amd.com">
      <pre class="moz-quote-pre" wrap="">

Current solution runs for years and this change actually does not fix an issue</pre>
    </blockquote>
    <p>As said <span style="white-space: pre-wrap">this patch is having &quot;get/put&quot; at correct places, or keeping kref balance in a clean way. Do you see any regression?</span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Xiaogang
</span></p>
    <blockquote type="cite" cite="mid:5e372d79-ceca-4509-8bf6-f18175744817@amd.com">
      <pre class="moz-quote-pre" wrap="">

Thanks
Lingshan&nbsp;
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Regards

Xiaogang

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
Thanks
Lingshan
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">The final kref is same. The patch just makes the balance in a logical way.

Regards

Xiaogang

</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Thanks
Lingshan

</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">&nbsp;&nbsp; &nbsp; static void kfd_process_free_notifier(struct mmu_notifier *mn)
</pre>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------nysO1mhSk4iTffQzXFLx8vPH--
