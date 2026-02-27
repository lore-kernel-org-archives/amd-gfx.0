Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E41FD530C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 08:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE3F10EA54;
	Fri, 27 Feb 2026 08:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fyKdHh9e";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013007.outbound.protection.outlook.com
 [40.93.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5784110EA54
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 08:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reufzoU1nrB3/MXkhwYP4wiAM1n9iBvYcqNAQg3hjkLyXwOp8uBz3i9hOsy9YsDDs42IVzDPiB7p6QGgWPlvsIC/9FLWRJh0c2TLlCK9tA0+4w/DKDaQi9T8Gcz03M6oin8nefvQHUsJLV0WkeKYDYesyAYlVrgo+Tg08ru1lFkIQWNVavQHejG5ZAzxCg01jQ9t78d9ycNh4gzvS+jYZXUyaVDEqWtEDfDOKCThAYWkdkNj5xnPxlQnPYHN5EoJ9aHwsWh8CYtJBhpIrZUSzBQ/MJMGL3so/RFokswbpPECiiRQirG6AGoBf5oss+1mtUsyKDKAB+SSHFvypM8zZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhfNppzS37i4h/ChreDr8xlyIDKxo/VAxthnhLriKPM=;
 b=h2TmPbaJKwzN2L8iX+YAPvS6EIdQXCYjmNYAfZHxnDvTiM9yjwjhVbvH+MusKCUq/5RB4UvGdJu4ZcE0P8WJadZzbKRtpU/pKSdE75HBlf4tPdLnpdJXay1Lxy6PXNjudEyMfYE1ikQsckNtsLZrRzukb6EDQfXELM5krfFpnuWEa4zTAunQ3AR1uH8+mSqPao836PC12DHEXsSpR6tgcbzaJLSZNY81ApJbjXoRTXolP0cVdDlKUaO2t76Nc1gxbEDQ+qxKVqydtYf0oK5WZa/iNAFalFwADbcdDmPw1DxH64CJ6v+cP7p6/Rm3gvKhW9UqwlPHRsbwiDo1hr1XSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhfNppzS37i4h/ChreDr8xlyIDKxo/VAxthnhLriKPM=;
 b=fyKdHh9ePRMx/nhzsVxI3rmpZ5cw/iBERtvGNyaeo0DiTZwWnQ9EHJCL1GYBh/ZkmphDZWjJX9CcLmwKiwv3oWL8ONX7BojewFybnaxVj1pYraYq9s4KkAlwJhshhNj9aQ7cteCMGLhrrLC9GlsWHtl1MYv1Xf+bMjpgz8E7J5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 08:13:44 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 08:13:44 +0000
Message-ID: <7642883d-4f11-451e-8629-176ed025ec84@amd.com>
Date: Fri, 27 Feb 2026 13:43:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: restrict sensor load values to 0-100
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>
References: <20260225093406.498727-1-kevinyang.wang@amd.com>
 <96885b73-a1fc-4b3f-a35e-0177a415a331@amd.com>
 <CADnq5_O4u+v9f5XNFipKHPa1qC6tEr0k4ppZXX0tUqrAjY8PXQ@mail.gmail.com>
 <DM6PR12MB2972FEFE85BC8F6C684E25068273A@DM6PR12MB2972.namprd12.prod.outlook.com>
 <5accd44a-5795-43cc-acf1-a8467038b7a2@amd.com>
 <DM6PR12MB29725599B2FE50BD48D442238273A@DM6PR12MB2972.namprd12.prod.outlook.com>
 <5e1692a3-40f1-4adb-9a7f-7db064a0b11c@amd.com>
 <DM6PR12MB2972B553D5C65B858CFC24018273A@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2972B553D5C65B858CFC24018273A@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0079.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: d456f03d-73b8-4349-cef7-08de75d81fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 0se1aulP+vH4ofM+FlIyRqEInD+r57YQ98l3fKy8GmmwJrd0/EyJwUGl8yPBUhj1qksQ6pqQiqfyYvvwg9YplSYyPr392qlIt26u/CGb1s+HyGY/24cP8H4di/K0HqZK6u0xSPT+L/6NHlWrvZENF2dIjKKXqOCbYVi3CNIJacbCUBPqJB1tey6TvaEdqo3yJC/MjkfqY3ecUC+BV5Cga1uY9fZSded7AU4PNgL/5xnqXsBlq3UeAMeq5dV3WE/jBIkp5VUhf9RCtxymS/hYTNjrBb1Ac/u12IHfoqQLGnY8rGEEXBcTBuvTEj4Vn+OcM53lLK8YrzclsIj92UqYR63p45Fi1BtEmKm4eSjRX1UQNDEjXGMnnWO5dLwtGRLe5pCaKmWfj5Hiw7wETqtGvOXLwdKoRuIj/NGTzJaOU7+e83NICCpzogOfLhoSViM1Ccqf2crxDYLnBay9YlbW6gKUnNBVS2VDImToG6DtvlxmANS/SHuRpSqxibCApOFtKi0x+sAbRbxXach/ZcEAz63RcQKPZp8m6glH/A/n8+psMmh+09Kfjb/OcugCpgDpkuk+osdjbrvS+Zl1nE9R1ekSr53wiNGmKkn4iZoZ9m5i50QjUG804n5/daomqrWsi9a9CzkSlfxlVeYgNMANzDvYlInhyzf7vnpcjW4p1Fiwd+HPBCnlTmjQBuePg+DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0hWUUdyUGtqUzFaYzkzM1VNQ2Ewa2x5V0RTTDVpR0dDWnN2L1NVZ2VWbDRw?=
 =?utf-8?B?T0ZoZHY3dVA3VnkzcFhiQWs1ZmcwUmVHNTZUcmpxRzhqN3dNc2xERXd5ZXdC?=
 =?utf-8?B?VjNYQXRSeTMxTnVwcE91OVdxQXZLakdDWGhEejZDVS9XMnYrWGRUdjZCZFNS?=
 =?utf-8?B?a1prV2wxczkxdVlpZ1l5eVNrcCtrenVua3JuNXVadldWSnplZzdwd0hjWHkz?=
 =?utf-8?B?aU9ZNHFrZnM5SGlMc0Fjb20xTmY1SHhwejEvSmMxSnFqOTNzY1F2bzhJNmpT?=
 =?utf-8?B?L0VaS3g3Y3Rsa0FXR0lDRzZOYlpjSEdza3VDVm5tWXpXTExVV3NPNHB0UFhB?=
 =?utf-8?B?RGRUamtnUkZwTlc4SXVjc2V0ZmEwUnh1b2NYL01yaG1FTXl1ckNONkFRYjJ6?=
 =?utf-8?B?ZEZGcGZ3UzA2dnNVK2pMT0JmL0pVYWw0UzhEQmFqMjYrUmJoZ1ljMDJmYm5F?=
 =?utf-8?B?U25JSWNXZWE4c3VOTjAzdXorWEV6QmlpTFdvSjZYanBhUGpqUTFuK1VvUHkw?=
 =?utf-8?B?NmU2ejhoRnF0dDZ6K0w1dWpRVGRyL20rQWt3VGNlcUxtWkFNNUJoMWN1dUx5?=
 =?utf-8?B?bElsRjFWeWFCaHdtTExyZzlabEVWejVNL1VyV0paOS9EQktKRmV1dTBTZUp6?=
 =?utf-8?B?dU9xQU5BSFVYc3V4b2MzU3RCeGtpMkh5TGw3a3NDT1hrUFN0SWRWK2hjTnpE?=
 =?utf-8?B?dWNDbXI4YzJhMHlQdlRvRkNSMUpNWVF0N2ZsdGlLajB3UHk3R0U5emFaTWc0?=
 =?utf-8?B?aTVMYWk3RU8rYUdUZ284OVUwYTJ4c2ZBQTBETUpRTGk2cVNTMW90Q1dCRkMy?=
 =?utf-8?B?TkxWQStZdk14UWdLakJ3cTdSUEoyczBuN1kzTHdYTFpwRmFQdDI0Tk5GRUZS?=
 =?utf-8?B?SS9hckJnTmpaZThnb0d5YXBXZGZEbUFCTER6Ykw1K2lxOTRLcXJYV1c3bVpE?=
 =?utf-8?B?QktWOHYzekN4Mzh1MExndDBDYVZxTGY2dGdWNmNTUFFaVHJiTjdBcHY1VHlm?=
 =?utf-8?B?NmYrMDNQSkpCN0htVWQ5ZUt5bGZhWGlFY3BjVy8yc3RQdGJlUUhOUXpidXN3?=
 =?utf-8?B?cnhSYURrMndqYUFHZFFlbXNYZ1dkeUwvQmJHRi8yclJqMnR4OFJIM1Z6WUtO?=
 =?utf-8?B?MTU3QjEyVlIrcFdMeTZJTFlXcFFrdVE5bWg2aUs4RERiVU5xdW9SZ25yQ1JR?=
 =?utf-8?B?MmlURUhkV0xwQTdjMnRGUWNlZlFveStTYWdpUW9sOXRNUlZuM0tHbU90bVFw?=
 =?utf-8?B?RzIxVGhwSzVidldBZnRWUS8xOVIyYy8vK0VkOWtDbWRneDdRVHoxeHFXQmI3?=
 =?utf-8?B?WDFYMG1NZmxZQkduMldiU3Y1MXhCU01JeHRFK1Fqdy9TN2ljRmJvZzNTRnRD?=
 =?utf-8?B?Mjlackp1WUlsSkcvWXlUWnA0NmNMVUtpc21Hb2dpZnY5QU9QNlhsa3lnWTVM?=
 =?utf-8?B?UFY3ejBldGlLa0Zkbkp4RmRObVBrdlVZOWE2UUF2bkw5UUFQOVpQcU5qa1RJ?=
 =?utf-8?B?Q0FMTk1XUlhuRi92bjJNVjUxWmxmRWdTOEFIeTZac0svL3VhaGxEQVNFSVdh?=
 =?utf-8?B?N0txa0F0aGRzcW80UzNiSC9CdjJ6T3pCYjAvSlRQTnhiMjdMTStjd1FXejF1?=
 =?utf-8?B?My82cXVEVmhhREZaK2lvcTR6bTRnUHphSmM3dmtxSEV5TDRQcGdwS1RjckRT?=
 =?utf-8?B?SUZxd01uUlhaa08xSWd2akh2QWNWbVVzR09ha0poNGd4TWQzZGtsNlloWGN2?=
 =?utf-8?B?cTVOUWRwd2twVCtrWXR4dWQ1eDloRGRUS1B5Q2NGNEIwb3dDeFJoWXY5THdP?=
 =?utf-8?B?L3k5SkNuR1EyZStIV2VndHUwZGxDcUpOUG9BNUVTeWMycDhWU3ZHSVdyQWFv?=
 =?utf-8?B?WlJnYzNaenVTUTltNWZKL0lsSDE3WEc1TVZnY0NwOGZjY1Q3ZTJ1NjBDdE5i?=
 =?utf-8?B?UmlzSFhNTlBuVFdKbXhnMi95U1ZwVHB0ZkNJaHdjOXE0Y2pLWlZNeUZNR3FE?=
 =?utf-8?B?VlBPNkxPRkNrY1RzMmRORUpYdmc4d3h0Nm02VWU5cW96N094Zm5KS3YyUit6?=
 =?utf-8?B?ZUJWQ2RsSXFqNENONkN6Vmh2TmhDTjB0SStFS2x3R0NQR09IL2N6Q3dnV3Ny?=
 =?utf-8?B?dDdqMGJxZkFtTzNxZGtkcFZHdU1CbExLNXpQc0tWQ3Ava08weWdVUXJLeGJ5?=
 =?utf-8?B?OEtwdFZXaWN2ZkVVL2xIQ2NVSWk4VC9WMW53YlJjbzErRkJIYWk4OFlnekhP?=
 =?utf-8?B?cVhpTCtBNUN4WjAyLy9jNkNLVFdKOEw1L3ppNkVkNXBZbFFZVlFLc0JPRnU2?=
 =?utf-8?B?RlZVdVQ1cERzZ2ZXUlBCMmlEbEo5M2V1YnMzM1pjOGtxU3ExZ1E4Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d456f03d-73b8-4349-cef7-08de75d81fd3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:13:44.3845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkBdOUCEQaERddm5nn360SF4ufYFw9BYW3+yHzRszbum5CQqOow+LvduRo+mvR+g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999081
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



On 27-Feb-26 1:36 PM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> The KMD should be responsible(e.g user mode application) for the returned results rather than simply forwarding firmware values.
> So, I totally disagree with your point, and we need to right person to review this, no further discussion is needed with you.
> 

KMD doesn't know anything about the actual utilization. If you want to 
handle it correctly, either return an error (because the utilization 
values are improper) or fix at the proper place and return the correct 
values.

Doing a blind clamping is not the way to fix it.

Thanks,
Lijo

> Best Regards,
> Kevin
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, February 27, 2026 15:55
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Alex Deucher <alexdeucher@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: restrict sensor load values to 0-100
> 
> 
> 
> On 27-Feb-26 1:15 PM, Wang, Yang(Kevin) wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> This is not a workaround; you have misunderstood the intent of this patch.
>> All ASIC load sensors must be constrained to the 0–100 range.
>> In other words, the KMD driver must not blindly trust the value returned by the firmware without validation.
>> For example, invalid values may arise from issues such as memory corruption.
>>
> 
> We have many users who really care about the validity of the utilization values. If firmware returns any garbage like 65535 and driver clamping to show as 100% utilization is not the value. We don't want to chase ghost utilization bugs with this. If there are issues with corruption, fix it in the right place, but keep the integrity of utilization values.
> 
> Thanks,
> Lijo
> 
>> Best Regards,
>> Kevin
>>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, February 27, 2026 13:40
>> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Alex Deucher
>> <alexdeucher@gmail.com>
>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
>> Feng, Kenneth <Kenneth.Feng@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: restrict sensor load values to 0-100
>>
>>
>> On 27-Feb-26 10:14 AM, Wang, Yang(Kevin) wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> Ping...
>>>
>>
>> Please restrict this workaround to the affected SOC. Otherwise, if there are bogus values, we will fix it at the right place.
>>
>> Thanks,
>> Lijo
>>
>>> Best Regards,
>>> Kevin
>>>
>>> -----Original Message-----
>>> From: Alex Deucher <alexdeucher@gmail.com>
>>> Sent: Wednesday, February 25, 2026 10:24 PM
>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
>>> amd-gfx@lists.freedesktop.org; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
>>> Feng, Kenneth <Kenneth.Feng@amd.com>
>>> Subject: Re: [PATCH] drm/amd/pm: restrict sensor load values to 0-100
>>>
>>> On Wed, Feb 25, 2026 at 7:14 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 25-Feb-26 3:04 PM, Yang Wang wrote:
>>>>> Limit GPU/MEM/VCN load sensor values to 0-100 range via clamp_t to
>>>>> ensure validity.
>>>>>
>>>>
>>>> Is this a workaround? If it's not within range, it indicates some
>>>> underlying issue.
>>>
>>> Likely for:
>>> https://gitlab.freedesktop.org/drm/amd/-/issues/4905
>>>
>>> Alex
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>>>>> ---
>>>>>      drivers/gpu/drm/amd/pm/amdgpu_pm.c | 27 +++++++++++++++++++++++----
>>>>>      1 file changed, 23 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>> index 938361ecae05..86ef1ffbf1dd 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>> @@ -1414,20 +1414,39 @@ static ssize_t
>>>>> amdgpu_set_pp_power_profile_mode(struct device *dev,
>>>>>
>>>>>      static int amdgpu_pm_get_sensor_generic(struct amdgpu_device *adev,
>>>>>                                          enum amd_pp_sensors sensor,
>>>>> -                                     void *query)
>>>>> +                                     uint32_t *val)
>>>>>      {
>>>>> -     int r, size = sizeof(uint32_t);
>>>>> +     uint32_t tmp = UINT_MAX, size = sizeof(tmp);
>>>>> +     int r;
>>>>> +
>>>>> +     if (!val)
>>>>> +             return -EINVAL;
>>>>>
>>>>>          r = amdgpu_pm_get_access_if_active(adev);
>>>>>          if (r)
>>>>>                  return r;
>>>>>
>>>>>          /* get the sensor value */
>>>>> -     r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
>>>>> +     r = amdgpu_dpm_read_sensor(adev, sensor, (void *)&tmp,
>>>>> + &size);
>>>>>
>>>>>          amdgpu_pm_put_access(adev);
>>>>>
>>>>> -     return r;
>>>>> +     if (r)
>>>>> +             return r;
>>>>> +
>>>>> +     switch (sensor) {
>>>>> +     case AMDGPU_PP_SENSOR_GPU_LOAD:
>>>>> +     case AMDGPU_PP_SENSOR_MEM_LOAD:
>>>>> +     case AMDGPU_PP_SENSOR_VCN_LOAD:
>>>>> +             tmp = clamp_t(uint32_t, tmp, 0, 100);
>>>>> +             break;
>>>>> +     default:
>>>>> +             break;
>>>>> +     }
>>>>> +
>>>>> +     *val = tmp;
>>>>> +
>>>>> +     return 0;
>>>>>      }
>>>>>
>>>>>      /**
>>>>
>>
> 

