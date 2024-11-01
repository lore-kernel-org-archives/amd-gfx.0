Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3843E67493
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 03:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE9910E089;
	Fri,  1 Nov 2024 03:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nJBtpVwi";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C818210E089
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 03:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLVkdKjVEvuq7i9efqOdVnnYE6WMHHvuAL5N7wXliA89B9IhfqD9jyYa6orqWHUJ4sk1iG8eucxZts9ty4l3UPuii4GBZzX491P4O458GJ3cDxFiPp8UCJP8Dh/XkXRI2OBGUOc5Kp7iSU96M6nLB8AOXMIp/df8anPYKs36Ukgig1sW5o+LVbUZ3BdZaMOxg0xawZODS+kbBJNwKwq3PNks7j7dl0KP9Ea00gcpJg7B9ybXTOXOSHkyYZ3YwC1eNtOWA62hex+A2HzijXbLqgaGX4MUfEbSbOkwYGW454JxTo2j4seVSFWyszlaPJ7GYGMY8MRkG2SA2jqku99HRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3Swyd2VmkfBdU6XVqUhbl3qhetCJJ+wjndQ1MRUJ8o=;
 b=gqPpCL5n9lXNo92DMUokSjn/0VFxCsA7PHQxIKf/It0im4jQZJx8wc8/TuX7SM2XzsZCqIRxepBeCiYbGfTHv3wA7Wwtl9WYyX9wGtsJNT3K31m+JSFhlnxuydHN3+JQ1v0+HTnmDD6lLwVxJXdMN7zQFO7Cv/96obZFr8SnKuWRAOqOIYIVPPKmsyC+/WZPwSIHECKkkvvgWpHSTOAOGrFBXtpPVJAGRyr9MkubMpnsRdm4b1j/EX2vGwcKhuwezJKJ5sHUcEmtG76qIAqECEckVWba8WktAhnz06zdV/tknr3Ks9G6w/VHhe/DhSCKmEDb3W16jbhiDzq5VRmuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3Swyd2VmkfBdU6XVqUhbl3qhetCJJ+wjndQ1MRUJ8o=;
 b=nJBtpVwiHbmzcu2gFvKJ0S2tmN/pbojahKu5VK4mDDIT9ydtTeRMYz1KCayM+tCu4wahM56984VCAXGQ/79NMKmwJ1BSf9X33F8sEu6B3Dw6tBPHlEyNN5HR2gf9G6uYWqli/AuWC1q+NkAJ1G8OYyD+ZpD5Hl2iwl+JEcGmftk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 03:20:15 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%6]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 03:20:15 +0000
Message-ID: <7521be7c-d597-4e23-9bb3-385c0b7dc458@amd.com>
Date: Fri, 1 Nov 2024 11:20:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: Explicitly specify data type amdkfd_process_info
 in related functions
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241015035150.1477582-1-lingshan.zhu@amd.com>
 <db85737d-9489-453f-85c2-dbd740a98904@amd.com>
 <a938652f-b641-4afa-88a5-47308ffccecf@amd.com>
Content-Language: en-US
In-Reply-To: <a938652f-b641-4afa-88a5-47308ffccecf@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0225.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::13) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e06a046-9d69-46b5-0475-08dcfa241a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejZSUW5ZazA5UVhLbzI0cnZBMUQrNzVYU3ZiN1BaQ1hCWllsa0ZDdGVCOHFH?=
 =?utf-8?B?ZnBYUS9Vc0hQZStiUjNZUkVoUnAxM29qUjUyRHJmZVhpaTlDaldaK29BUmxS?=
 =?utf-8?B?SHNiUENBTXpDWFhGMTJFekdjNXoweSsyQXZ3OHZpSGJTeGhCOENBay9ZK25a?=
 =?utf-8?B?SnU2bGxrZzgyOGlSV01VblJIV0pPTGp4SU0xcEg2QjR1TG4yamhQZTRCWlU3?=
 =?utf-8?B?WG41NVJDbVlKQkxtV3pwTHF4V1l6bytjcDZ6WjdiOUZnbFVuVk9VNzFNMzA1?=
 =?utf-8?B?RVk4clV3WXhwa09PYTRzOHBQZWhsRmxrN3ZPcXJnWi9NaERJdXlyQ0ZHcjho?=
 =?utf-8?B?QVJ0QXJOWi9LU2ZtYm53QzZ6QUJuNTRWRHhTRC9qVGZ0TERxRVE3WklleTkv?=
 =?utf-8?B?Q2E0SVVJQ29CRkZaVHpxTmQwVWtTcHQrd1V3b21TV240NnpzSFliblpyRmdp?=
 =?utf-8?B?aDFBVVgxUDNkcGdRMGR2aWp0elZjZHVLVjZMWU10dzNDT04vRkhadzJvT3VI?=
 =?utf-8?B?dm9kUUZwUjdkeWRtVnpJMXhUQy9pV084ejh4ekdKcm9ObWpicHhZUW9SYlFE?=
 =?utf-8?B?VkdUOExjSGZ2NjFVU2lvUVcway8wdFZOYWNGWkZMKzdXT2graDNrNGtKNlBJ?=
 =?utf-8?B?SmY3UlNVMmZnQzR2Q1hDK0xqbFFzSFFleHRrYXhpdERNbXdpMHNtempPdU44?=
 =?utf-8?B?U2NVMUVGd09CTnRnSHE1QmpSQnRtSmY3MVZOWDdaUnlEQVkrRmFDdTQwSllM?=
 =?utf-8?B?RnNsRm9yODR2VDZGL1dUUFBjYmVNNUZXZkdSb3phRHNHR1g0QmlNbjRxcmdN?=
 =?utf-8?B?Z25wNjI3TStWMi9GTkRkMkdtZUh2VFJQcXhyc09ZV2xWT2JFYXNMVTFsQ05B?=
 =?utf-8?B?aUt0VnQ3c2ZnbmI3UkRWeWZLNXAybzVoaGNYZCtTTGxITUsrUEJwclVaZmYz?=
 =?utf-8?B?TDFOZTJvZFViS1VVU2pQSE5KQzVKb29udTdCc0EzM1Q4cGdlS0Q0TjFSdms2?=
 =?utf-8?B?L0lJUWJFY0FEbkRwQzFvcUFGdHkraDFxUmwvRDZ5b0FtMmF0WHl6NVoveE0z?=
 =?utf-8?B?YTdscVBvQXdybXZhSk0xQVVnZjZyTjNNbUdhT2MxSEV5K1M5WUZha0x5WTZO?=
 =?utf-8?B?T05NREJtRGdhL0pBTCtDZ2JGVVhzaFJ4dExUUWZ2YmFUOUVsQXExUDVOaFpZ?=
 =?utf-8?B?NG03QWNLTEQydWZmYk43bDVmaUQrTzR2NnlZUFpPYzBNVU91aktSMWRkYUdL?=
 =?utf-8?B?N0Exd084U0pUZlZNZWJ6SzFCK3ptNWZpTmdtS1RIOXV2ZHRlci8xanEzemdk?=
 =?utf-8?B?V1pEbS9lQXFxcmU5M0VUcWh2T280MEdlWVNyNnlKQmdsTzZWUzNwNVBvYks1?=
 =?utf-8?B?bWZXWHp0U1JKZXloNEY1UzEwVDhEWTRqekszdnk4N2x3ZCs2YXBuSnBBSlpo?=
 =?utf-8?B?R0lXZDlOZUFHamU0NDVLeWdKQ214cWVUSGEvZ3NyTlZjSmNIYTZuK0FMV1RJ?=
 =?utf-8?B?RDlScldUQW95bm5HcUc3RXhPSUwxODVGVHJRWmlXeXRkUzgzdEUwZ0NseDFG?=
 =?utf-8?B?REtOM3JuQTBuV2tlc0tFVDlEZlBLeVBBNDNKMkpTUU9Sd1Qwc1ZyVHk4T3kr?=
 =?utf-8?B?V1N4c3BSV3I5VkhXVE0xY05Sb3M1aUVJNlU2RTV6NFJ3K1lBbnhLdXkvU0Uw?=
 =?utf-8?B?UXh5WkdIZWpZNTcyRFpCMUVodlIrYzlORGxUa083RFVQSWdGekpJN0x2UGFZ?=
 =?utf-8?Q?kOxQ6/V+VW7YjAJilmUj6nNeDqlfifLzBVJMevq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODRVaTRvWkVPditYWkhjZU9HSFk3Tk1nTnZ6UmF1SzJUdWZCdkRVa3dKS2U1?=
 =?utf-8?B?Nm5xOGY4eDB0MFd3dHlEaFFiK0NHcnNJVnFSVGRsYUhDUGR2bGFhV1dFY0Jn?=
 =?utf-8?B?MWJtRGpjQnRiTlhZZ1Z2Yk0zR3A2VWxZblVUNmt2cVJqbFJSUVhZMU1sNVVJ?=
 =?utf-8?B?UHAzSE40VGxNb2ViZ3ZBblBuZmdLRU91K09BblRCekhrNXpYM1RtNDVxMDVu?=
 =?utf-8?B?ZXdyZGJ4NTMrWlhwSEpQdkxUSE03cXVMSmxMYjl5M0V6RWxCS052ZnMzUzlq?=
 =?utf-8?B?b2ZWQjF2U0l0QklMV2NaTlpxL0VDc3QvM1h6NUt5TU1od0hwM05vS3RCbTFY?=
 =?utf-8?B?TCttM2VBcWxkZk4waXFET1BycitiZHpXTVN4U3pVTGVqWHI1Ykp4QlFvWU52?=
 =?utf-8?B?dkFJS0hPMDluU0tJNGF5UEpHR2NXeFVNRldYK3JlMzd5ZzBoVjR2aGYvbFJr?=
 =?utf-8?B?NW5rckdqS2dqZ0dHMEkxbTZrbnpUWjliaEVSN2NZTEdaZ2ZEanovaDBQTnJE?=
 =?utf-8?B?d1pQNnFGbmswUE01dG5tU3JhenhlN0NBcTZla3E4Y04wUDJ5K3NTS0xDZDJj?=
 =?utf-8?B?Y1B0N3oydUJSSCtWU1JmU3NxMXV1MFF2dkR0WW01S3lEOGZSdHlzSEVkYmxW?=
 =?utf-8?B?MHRoMlA3ZTZrVXlvUHF0amUzQ2pFWHB6Ky92dWJmb1MrMWZYdzlzWmFWVzlo?=
 =?utf-8?B?RDRObEhKTUk3VGdaNEd0aEV0Q1ZRZjR2MkZ2SXREbHVhanROamhEVmI3bncw?=
 =?utf-8?B?UURRRU4rbGV5OHNBWVJxdkxqMk4xYU1Rb3oxc21OM1c1SVdxNldVYXJFVENC?=
 =?utf-8?B?Q21rWWVrdHBoRFJTc2xsTDdybWtCSkRmRVU0Y1BTWVVJZmJ5UVUvWm9LTnpW?=
 =?utf-8?B?MWtGS0JROTZ2eUtaZDFSSzYrdkR0OGdGOXdEZmtJQ0hUSXhPMDl1b0JUcnhx?=
 =?utf-8?B?ZFR4Nlc3MW92V2hMcmNXbkNHR1BUU3REd1VuZXBGM1p2U3RWbmdQdXdPZGF6?=
 =?utf-8?B?RERQZzlKRDhxTmcrZkFEbmthSW5tKzRHQjg0UStZWXloNW5DVFRLUEF2eis1?=
 =?utf-8?B?SkkvWnNoNnR5akJNN2toUlVIKzhIQWZVR0hWNkQ1ckkwL2xuRmFwZmxhaXJF?=
 =?utf-8?B?OUVycEQzKzk4ZHBMWHcrWHpnSU1VNmVmOWhEYmU5cjBLdm1kMjJYTy9FNmxI?=
 =?utf-8?B?QXk0QmJYT09CMkluaE04L01XM3pLclRrSVVwd1ZVeWZXTlVpTHduem84S3ls?=
 =?utf-8?B?ZzIrNFVPQWp6K25YZEZjaHlpclA5bHYwWExEWWFyUDN4bEdUYWVaTXBmRm5F?=
 =?utf-8?B?S1YzbXQ3RGl1TWkxLzZibGtZMENjWnI3bGtSc0FBODRIQlZCUFZucGZJdFp6?=
 =?utf-8?B?bit0ekJCQjF6MFhrVUtmdjdpQ3dyZktuc3B6R3hRKzE1TDRYVStPRnhVUWtz?=
 =?utf-8?B?bFZ3cFUzdGhWWnlJU3JwUWxmNllTSEtSamwzd2FNNG1LcEd0SmIraTB6UTBw?=
 =?utf-8?B?UFhzVDBZNTBZczVYbkdia0t4Vm16NVBXSFA2NWlCcnFCSTR0QXVPdlNMR2Na?=
 =?utf-8?B?aFhlUlQ5b0taM3VRN0hxeHR1RkJTRmFkU3k5QURzMlBwaFFsUjFmK3V0NUZ1?=
 =?utf-8?B?YVRFZ2VhbDlKWmxzamRCVDRXaTRteDIrUmR5aGNnOVNuSUJBWjEyYlVnb2Zx?=
 =?utf-8?B?WkpKWGNZVVpmdlg4NkRxWGVjRDVUc0VWb3VVTkR1SmtQRUM1THZDNWhOZDJB?=
 =?utf-8?B?MUVpRk1rcy84SElWenZUNFNXRzVIaFNnZWNVVGpzL0NjYkNrNUtUeFZVYUdE?=
 =?utf-8?B?QnhDN054Rm96RUNKSXkzL0NRL05nMXpIWjdDNDNVaHN5WDVrMlVvbEplaXFL?=
 =?utf-8?B?eGo0cEFpN05NUWRtcU1xeU1yNWhEQzBwUkpvOW4rd0N3MzVDL1N2VFhsaVhO?=
 =?utf-8?B?aWhlZm9LYXpqbzVzMTFMNWNwK3FtdUVubkR4QmtvTW5GdmpkUWRPZGdXNzVn?=
 =?utf-8?B?ZlRVaU44OGliMzFZM2tGbmdEcERsVEYyYkNreGdCTVRQQjBCbWt1ck5WMU1K?=
 =?utf-8?B?WjhGS2JRWW5QTlNqY3c0M1JzTE95OEZKTFpUaDdzWlZueStGU1ZxYndTOUdE?=
 =?utf-8?Q?W6ISvbwiQIM+t9WP1XBauzYRh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e06a046-9d69-46b5-0475-08dcfa241a5e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 03:20:15.0205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNFZZH7rvhm6r6hjbciBxfNJgjDxgtvUlMtfSIIKZRgXNvzIuUXHkmaNLJ+O+Fd5aFQ28M/RlyhlaUBgg1VkPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
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

On 10/22/2024 4:01 PM, Zhu Lingshan wrote:
>
> On 10/22/2024 12:20 PM, Felix Kuehling wrote:
>> On 2024-10-14 23:51, Zhu Lingshan wrote:
>>> This commit specifies data type struct amdkfd_process_info
>>> rather than general void* in ralted functions.
>> Several interfaces in amdgpu_amdkfd.h use void * as opaque pointers, e.g. process_info, mem_obj, drm_priv. The reasons are partly historical because KFD used to be in its own kernel module. That said, there is nothing fundamentally wrong with opaque pointers when the upper layers doesn't need to see the contents in the objects returned by the lower layer.
> void * is workable but imperfect, IMHO it representing a compromise that could ideally be improve especially when we know exactly the data structure type.
> This change provides better readability, type safety, compiling checking, and avoid the castings
shall I make any improvements on this patch?
>> It makes me wonder, though, why you're singling out just process_info? Are you proposing to change more interfaces to eliminate opaque pointers?
> That is because I just happen to read process_info related code, I can surely improve others if any individuals of them also represents a certain data type.
do you want me to change all void * opaque pointer in a series or just this one for now?

Thanks
Lingshan
>
> Thanks
> Lingshan
>> Regards,
>>   Felix
>>
>>> kfd_process->kgd_process_info is initialized
>>> in init_kfd_vm() by such code:
>>>
>>> static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>>>                        struct dma_fence **ef) {
>>>         struct amdkfd_process_info *info = NULL;
>>>
>>>         if (!*process_info) {
>>>                 info = kzalloc(sizeof(*info), GFP_KERNEL);
>>>
>>>         *process_info = info;
>>> }
>>>
>>> That means kfd_process->kgd_process_info is type
>>> struct amdkfd_process_info, therefore we should avoid using void*
>>>
>>> Using a specified data type other than void* can help improve
>>> readability. There are other benifits like: type safety,
>>> avoid casting and better compling chekings.
>>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 10 +++---
>>>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 31 ++++++++-----------
>>>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>>>  3 files changed, 19 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index f9d119448442..c1346b8c9ab7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -239,8 +239,8 @@ void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
>>>  int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
>>>  				void **mem_obj);
>>>  void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
>>> -int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem);
>>> -int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem);
>>> +int amdgpu_amdkfd_add_gws_to_process(struct amdkfd_process_info *pinfo, void *gws, struct kgd_mem **mem);
>>> +int amdgpu_amdkfd_remove_gws_from_process(struct amdkfd_process_info *pinfo, void *mem);
>>>  uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_device *adev,
>>>  				      enum kgd_engine_type type);
>>>  void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
>>> @@ -299,7 +299,7 @@ int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
>>>  				     struct amdgpu_vm *avm, u32 pasid);
>>>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>>>  					struct amdgpu_vm *avm,
>>> -					void **process_info,
>>> +					struct amdkfd_process_info **process_info,
>>>  					struct dma_fence **ef);
>>>  void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
>>>  					void *drm_priv);
>>> @@ -348,8 +348,8 @@ void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_device *ad
>>>  
>>>  bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);
>>>  bool amdgpu_amdkfd_bo_mapped_to_dev(void *drm_priv, struct kgd_mem *mem);
>>> -void amdgpu_amdkfd_block_mmu_notifications(void *p);
>>> -int amdgpu_amdkfd_criu_resume(void *p);
>>> +void amdgpu_amdkfd_block_mmu_notifications(struct amdkfd_process_info *pinfo);
>>> +int amdgpu_amdkfd_criu_resume(struct amdkfd_process_info *pinfo);
>>>  int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>  		uint64_t size, u32 alloc_flag, int8_t xcp_id);
>>>  void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index ce5ca304dba9..2a1ee17e44a1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -1376,7 +1376,7 @@ static int process_update_pds(struct amdkfd_process_info *process_info,
>>>  	return 0;
>>>  }
>>>  
>>> -static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>>> +static int init_kfd_vm(struct amdgpu_vm *vm, struct amdkfd_process_info **process_info,
>>>  		       struct dma_fence **ef)
>>>  {
>>>  	struct amdkfd_process_info *info = NULL;
>>> @@ -1552,7 +1552,7 @@ int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
>>>  
>>>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>>>  					   struct amdgpu_vm *avm,
>>> -					   void **process_info,
>>> +					   struct amdkfd_process_info **process_info,
>>>  					   struct dma_fence **ef)
>>>  {
>>>  	int ret;
>>> @@ -1639,19 +1639,16 @@ uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv)
>>>  	return avm->pd_phys_addr;
>>>  }
>>>  
>>> -void amdgpu_amdkfd_block_mmu_notifications(void *p)
>>> +void amdgpu_amdkfd_block_mmu_notifications(struct amdkfd_process_info *pinfo)
>>>  {
>>> -	struct amdkfd_process_info *pinfo = (struct amdkfd_process_info *)p;
>>> -
>>>  	mutex_lock(&pinfo->lock);
>>>  	WRITE_ONCE(pinfo->block_mmu_notifications, true);
>>>  	mutex_unlock(&pinfo->lock);
>>>  }
>>>  
>>> -int amdgpu_amdkfd_criu_resume(void *p)
>>> +int amdgpu_amdkfd_criu_resume(struct amdkfd_process_info *pinfo)
>>>  {
>>>  	int ret = 0;
>>> -	struct amdkfd_process_info *pinfo = (struct amdkfd_process_info *)p;
>>>  
>>>  	mutex_lock(&pinfo->lock);
>>>  	pr_debug("scheduling work\n");
>>> @@ -3093,13 +3090,12 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>>>  	return ret;
>>>  }
>>>  
>>> -int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem)
>>> +int amdgpu_amdkfd_add_gws_to_process(struct amdkfd_process_info *pinfo, void *gws, struct kgd_mem **mem)
>>>  {
>>> -	struct amdkfd_process_info *process_info = (struct amdkfd_process_info *)info;
>>>  	struct amdgpu_bo *gws_bo = (struct amdgpu_bo *)gws;
>>>  	int ret;
>>>  
>>> -	if (!info || !gws)
>>> +	if (!pinfo || !gws)
>>>  		return -EINVAL;
>>>  
>>>  	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
>>> @@ -3110,8 +3106,8 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>>>  	INIT_LIST_HEAD(&(*mem)->attachments);
>>>  	(*mem)->bo = amdgpu_bo_ref(gws_bo);
>>>  	(*mem)->domain = AMDGPU_GEM_DOMAIN_GWS;
>>> -	(*mem)->process_info = process_info;
>>> -	add_kgd_mem_to_kfd_bo_list(*mem, process_info, false);
>>> +	(*mem)->process_info = pinfo;
>>> +	add_kgd_mem_to_kfd_bo_list(*mem, pinfo, false);
>>>  	amdgpu_sync_create(&(*mem)->sync);
>>>  
>>>  
>>> @@ -3136,7 +3132,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>>>  	if (ret)
>>>  		goto reserve_shared_fail;
>>>  	dma_resv_add_fence(gws_bo->tbo.base.resv,
>>> -			   &process_info->eviction_fence->base,
>>> +			   &pinfo->eviction_fence->base,
>>>  			   DMA_RESV_USAGE_BOOKKEEP);
>>>  	amdgpu_bo_unreserve(gws_bo);
>>>  	mutex_unlock(&(*mem)->process_info->lock);
>>> @@ -3149,7 +3145,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>>>  bo_reservation_failure:
>>>  	mutex_unlock(&(*mem)->process_info->lock);
>>>  	amdgpu_sync_free(&(*mem)->sync);
>>> -	remove_kgd_mem_from_kfd_bo_list(*mem, process_info);
>>> +	remove_kgd_mem_from_kfd_bo_list(*mem, pinfo);
>>>  	amdgpu_bo_unref(&gws_bo);
>>>  	mutex_destroy(&(*mem)->lock);
>>>  	kfree(*mem);
>>> @@ -3157,17 +3153,16 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>>>  	return ret;
>>>  }
>>>  
>>> -int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
>>> +int amdgpu_amdkfd_remove_gws_from_process(struct amdkfd_process_info *pinfo, void *mem)
>>>  {
>>>  	int ret;
>>> -	struct amdkfd_process_info *process_info = (struct amdkfd_process_info *)info;
>>>  	struct kgd_mem *kgd_mem = (struct kgd_mem *)mem;
>>>  	struct amdgpu_bo *gws_bo = kgd_mem->bo;
>>>  
>>>  	/* Remove BO from process's validate list so restore worker won't touch
>>>  	 * it anymore
>>>  	 */
>>> -	remove_kgd_mem_from_kfd_bo_list(kgd_mem, process_info);
>>> +	remove_kgd_mem_from_kfd_bo_list(kgd_mem, pinfo);
>>>  
>>>  	ret = amdgpu_bo_reserve(gws_bo, false);
>>>  	if (unlikely(ret)) {
>>> @@ -3176,7 +3171,7 @@ int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
>>>  		return ret;
>>>  	}
>>>  	amdgpu_amdkfd_remove_eviction_fence(gws_bo,
>>> -			process_info->eviction_fence);
>>> +			pinfo->eviction_fence);
>>>  	amdgpu_bo_unreserve(gws_bo);
>>>  	amdgpu_sync_free(&kgd_mem->sync);
>>>  	amdgpu_bo_unref(&gws_bo);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index d6530febabad..b0426a1235b8 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -934,7 +934,7 @@ struct kfd_process {
>>>  	bool signal_event_limit_reached;
>>>  
>>>  	/* Information used for memory eviction */
>>> -	void *kgd_process_info;
>>> +	struct amdkfd_process_info *kgd_process_info;>  	/* Eviction fence that is attached to all the BOs of this process. The
>>>  	 * fence will be triggered during eviction and new one will be created
>>>  	 * during restore

