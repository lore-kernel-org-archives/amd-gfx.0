Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862DBD3000E
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 14:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2497B10E930;
	Fri, 18 Oct 2024 14:09:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0wn79aRV";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DE1410E930
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 14:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hB+CUukiAcZKi11crQfJiNP3Xu98YDXgyGc2YNY4cL3eJoF72cJmGjd0N6bqlz2OLFAs/b0Gf2T3X/VsJgjfix1uapQe4SaMbKaPwb+JU3RbjEIL1AyrzHP+CqUqCc5JyvK/nvcFr6nL/2sB4FhjzKCjAHYfWZRTf1t1hoxHQ87EBfEPuXm9KLtd3gIJAzTuc6ix4Gbg31xsToHfOeCHlmHGDB2UbvGfzjnTgMW0Q1gDMuRSy9z6mCONgxGeg4EqQIU8LZ9PZuWjbi/acVfkmciwlFMeCrdG8xn9wgb1X2e16V+hneZRVHP/MlDnj2nDkjqZdAwuoSAs9fGjAIaFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZaeFMaB204NgvBQXYFCZUVQe2e5K94teP9o4sLflDQ=;
 b=NhG5JYUm9Tc7m3MP6rK1IJd3rdn9Ah2533oHI4Fn3ynz2jXjjwr7hIEVbHOfH9RbV3n+mzsHOuw+wJNI6BCVf+u8F0jxIPCAIue+YRf9wnCpZ1BPb+ZQKWd8QaiwLCNC8ANM++WSfO1CNltVO/d3JVaYPqapb7KQvMbXYEy0l1GJnOUaP4EUMN99xHmvOoYWu41YyrL4VKR7a1HWVdlwjaNHYQlMzRh/usW79ocv8xqQdhBuvKRkaS+rkVH/VS8XMLNVX/Z9vYx4Q2EjFeSkB/yAe1Wzmitw3Ur8gxpDG/eCA5XPhloyhsa6OTZAzmUGTw8vhUyQ4Wf3rGGagPRZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZaeFMaB204NgvBQXYFCZUVQe2e5K94teP9o4sLflDQ=;
 b=0wn79aRVKm98za/E5bTtH9CzRAzu2mG4E7LxJ5kxghjy803/lZr+xcFmB4y0/sERy/vstj2wIhWwLcLxBapSMpT6PhMXKPFr0rVWbUSn98PC6xf2xiJmU1L6GZ4SVIq0WXRQfZSbVE5/eliTkbsCmDgEfW91O4lfpKkqow34qhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 14:09:26 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 14:09:26 +0000
Message-ID: <32f7690e-f379-4f28-b747-2d0f59a5156c@amd.com>
Date: Fri, 18 Oct 2024 09:09:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Add kfd driver function to support hot
 plug/unplug amdgpu devices
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com, christian.koenig@amd.com
References: <20241015212139.63500-1-xiaogang.chen@amd.com>
 <003ddddb-9a6b-4e62-9980-da923f7b889f@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <003ddddb-9a6b-4e62-9980-da923f7b889f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:806:22::22) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|IA1PR12MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: b57d7063-61bc-4379-2b72-08dcef7e7956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0c0NkFnUDE1bnRkanJYbmUyQmNWblBSRDBTWm8xVGZBZUhWRkoyRWpNN3NU?=
 =?utf-8?B?bzBUWGJmUm0xUTh3VTJCNEY2RlpVUEo0eHpZaGtzOG42ckhkT1JWSUNlRkc2?=
 =?utf-8?B?VFlUVk1MYk93K1ZRUGJWMWlLRDUzS2ltZkM0UUtzTVNiTyt3WDcrb0Y0a255?=
 =?utf-8?B?T21FQjRsQlFyc0J3UVE3R3ZlV2JzMURuNjRmSXB0UjFaMk1PK2hRRGUyY0JY?=
 =?utf-8?B?TnJobGsyVlFsSUhsRXgrdllZd25aYmhwL1dnaStSQVErdnM3Z1FDalo4c0pJ?=
 =?utf-8?B?VWpScnBqQlFsb0h6OVpxczlPUHF0R0IxVm93SlVXcDJ3WnVPZDZQODdlMWtD?=
 =?utf-8?B?SEVybXM2d01CZ2h2cVl5djdQUTIzS2NaOXRmV2VmdlNmTzhvUlNjQzJrM0tZ?=
 =?utf-8?B?aHMzRjhlK2pLSnIyN3ByUW1WYnhhUzA5dTYxc2dFYWtpYTBYbkgzZ0RpeGxJ?=
 =?utf-8?B?a3lraE1YcDFSeUt0MENZdW1FODB2Y1BEVXZYdHo0a0ZVMFFNV0ZWRDlubjEx?=
 =?utf-8?B?dzgxYTBnbGhidi94MlpFY1FLS3NjTTdoZDdBZHpMaU8vZnF5dGZVdzRiQ1pM?=
 =?utf-8?B?OHl0NXFBM0RCQklEb0ZaUENCWTFQTUxVOURxczVTb2Q3Yzd5MzVMazhwZGFS?=
 =?utf-8?B?L1lkK3lhOTdwa0ZvbHhraFc5bjllNWFUYmhla21Cb3hvRndPOEFYME96Rm9r?=
 =?utf-8?B?Wmh6WENWaEI5YURKVXFKTWFRZCtyUzd3UmVCV3lQK0FURDg4bmxNR1VxQ0FR?=
 =?utf-8?B?MkFyUjlZV3BRSHovN0hIS1JMazNNYmExZlV6VC9lakFHRDIvUzJSR3RZZFIz?=
 =?utf-8?B?OXRESFhubzFtV1NxT0xMakdRWFZzcnAxWGdubk1tRlMxeVFvMy9ERTVOYjFt?=
 =?utf-8?B?MXFqblRGeVJHWVkyZzhibXRVMFJNTllnSTdDdWh0TnNIUkV3YmEwUVZ4STZk?=
 =?utf-8?B?MnowVVJOUkxYQmgwcjQwL0l3UFRta2M4aFNBTHZ4WDFUbmNYSVJEMElqbEpO?=
 =?utf-8?B?STBVRnNCcmJJaGE5Q09SeC9DeUNVQlhIWi9WUjlBWWpoSHp0cXJQWDNTRXRk?=
 =?utf-8?B?bkpKTS9sTzIwcE50YTZXQlNhbDI3UjI4Qy9IMFlWSnNINDEzWVlSRnFPRXJ6?=
 =?utf-8?B?L0VScEZXZHlnbmc2eUw2V1h0MktVZEhxdnFmWHZOTWh2ZHhJU2o1UlU0Nncz?=
 =?utf-8?B?dVBnbXIyYk5obXNCUXFaMk1ZcHFiUDZ4QnYrcklIaVhoWC9kWGxvSHgzUlpR?=
 =?utf-8?B?ZnRPQXdiVjZMMFM1Q2FMajZvNnp2Yzh3ME94OE1RNy9GeFU4QWQwTHZxVWF6?=
 =?utf-8?B?T21JQi9SUlhqc0NoNGcxNytJdGk4V2w4S2RGMW55RHo1NThId2xqWElIY2pw?=
 =?utf-8?B?TEVoa05xYmVxdVF4NWlBZ1ozRGlmZ2I1dFYwYW1BUnpSczViRkNuNUhaR1VV?=
 =?utf-8?B?Vnp2M2NyMEhPRGtTRWQxT29RTCtoSDBzdkZIOCtzbXNJUVZ1UjJpNTRIbE40?=
 =?utf-8?B?YTZIOXp1R2xLb0srT0swMEhSTW5JYWcyZCt2UVErN25teFNYL2xYdTFTZ29T?=
 =?utf-8?B?OUt1NmFsN1BRUEFvWXJET01sSC9CYURFNVFWb3FLUGxWUDlNY3FSK3Q5YVQw?=
 =?utf-8?B?S1dIbVdoQnUvbk9BMHJYMzBFS2xVVW9WRE1SQ2dpZHEzVGVxYUppUXBzZVJ6?=
 =?utf-8?B?Um0xSnFWMlBlblJSampCTmozL3lTYU9sTXlVOXVUQzJKaEVqUEhtK3Y3TUJM?=
 =?utf-8?Q?A19RqjJO8CAiB3Xzt0mckhn1ZQRqaPQ62pzYvSp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUNxYkFJdFVkWHE0N05GblZQQXR4c2x6aFdZVndReDlEc3RmRENBaVFXVjJq?=
 =?utf-8?B?YVdnSm42TmZoZHJndWhCUnBsL2hOc2FRbFMzdFZ4b2drbU5NdnZjT2JFQ0pO?=
 =?utf-8?B?QTRkdUx1c1dPMDZFcWZtQWpLNXJYWmpkOVByeDE1VmxpSFNndDhDbStWdkZ1?=
 =?utf-8?B?TURLb0xGSzB2KzlaekVZVWxDdCtGQVB2M29ZVGUwNDlhQUM2a3J4dEpxYWty?=
 =?utf-8?B?YWhTZGFXOUJPMFhnNUJaQkRtSHZQUCtoNC84VTFPQXpWTENBL2xvazJWSXJw?=
 =?utf-8?B?TXVQUjd3bzBPRlQ4OWFFNzRUT3YwTEpTOCswOGxCRGJublM3M3E5WVVuMkxx?=
 =?utf-8?B?MmpUWU5pSzd1TGI5ZEJaUmdpV2xNbkZ3MVNQZW1yWkcxd2ZJNkkzT2V6K1p0?=
 =?utf-8?B?NXRMUEtiWjNJMGdHd09yNlFSMkZHMS84ZDM2MWxZZUI4U3ZUeFd3R0lJRDY3?=
 =?utf-8?B?UW0wSzJLSjdaS3FKanVCL2NCeDFIaXVhcVA4dGNEVlRvMUxTK3U3aGpVamE1?=
 =?utf-8?B?bVZ3WW5BZFdTZVgxNFUxYUZLaDdNMlhwWmdZQ3dub0lqa205WjQ4VFlXcDdB?=
 =?utf-8?B?dmxrL2lFMjdtNmhCdUhQSncwS1ZsblVMVUlNdTB3TXpOZmI5V3M0ZmU0TzZm?=
 =?utf-8?B?dzBNcjA1UVVUWkQ5T0VmKzRiVVp2WVgwZjJhQ3llWmFnYU1HTmlpYXdZY3Rr?=
 =?utf-8?B?N2hueTZkK0JDYzNlc25jSFJ1ZWdhUWY1OEgxazAwUzZybTJSQ0dsK1NwZVhx?=
 =?utf-8?B?VnlJZVdoMFBlMXI3UEhZbkY4QWFDWWNLWllXYm1lK3ZaM2laSEF4RHQ1NE9j?=
 =?utf-8?B?Z2djK3R2NlczeCtvNStjVWFhS2VmdVBYUXc2eTdTVmxZL3YyM09rWnhJbDZZ?=
 =?utf-8?B?SXM0RlhDZ3hSc01QK1VjMHVkQ2NhME50d3hPdTUrSElPM2dUYjY5OU90ODFj?=
 =?utf-8?B?RmhtUVFIWTNoNklhajFzejlRYXZxU09jR2M0NUdzeDh6Y0RORFlWVTIwUCti?=
 =?utf-8?B?SkFWcHB3K3ZWYVduaDdvT0FVc2pIblFmRUVQSVA2cklGZStOQjdtVGU1Q0Nr?=
 =?utf-8?B?MVZJVnVkU1hNUlp0azNnY0NGdk81TDBLL1hEdG90L0NDVytxN1VSS3FCN3cx?=
 =?utf-8?B?ekZaUkVCanpVOWV5bXliOUg1QWxtWHB0Vi8zSmN2VGFVekhUL09qalNCZzBE?=
 =?utf-8?B?OTVXbjNhSzZvWFZYQ0FvQ2c1S2RBMHlURGdXR1lwczRhWHFscFpQWmJNdlN1?=
 =?utf-8?B?dnVNamFaNS9KT3JMcWtqRmk4VFg1TUs0TGx2MXFNZVh3V1R2L0VxQ2JLY1F2?=
 =?utf-8?B?Q0JvVGl1aUtoeWxhNndDdGh1ajR5MW1rYnc2bkEzMjhXaXpPcDhFeFlpZWxj?=
 =?utf-8?B?NlNVWHhIK21vTkxTRXVrZ3htV3hqUmRhMEJZWkFvOUltdFVETzJnME1QMWhD?=
 =?utf-8?B?TEpLM1liY1pHcFZhUXk1Y2VXQlJEMDhwMUpWajBUTVB5bUlBd0ZTNk1kNit4?=
 =?utf-8?B?RHFucHZFMWZCa0pEM2xaZEJFbEZJMWpVQklsNm5wQXJUbHByK2djRCtCczRF?=
 =?utf-8?B?QVg1enJON2lQUTV0bmRjem5abEd5aHQzMldORnJKL0wyUmQvK3JqVUJnZlFQ?=
 =?utf-8?B?UFRNMWpVSUUxL3RoUTB1ajVVcGVwNnh1Z01scHB6RCtoM1pJSWxLQlYwZW9B?=
 =?utf-8?B?Zk9GWE9EblFjM1pUa1E5eVJva3dLQ1ZWSGE4Yk5UTiszODUxc3RTOUFIT0tT?=
 =?utf-8?B?cDY0aGdyNStXbDNuMEQ1K04wS1JOL3NTYUlrWXUzVmhwMDBhQUVnWTZVQjJ4?=
 =?utf-8?B?bzVoM091Mzl3ZnhJKzZhZHpIUGxrTlIxMXY4NDFKSENNKytZSTBMZ01STjRV?=
 =?utf-8?B?NkQ2dGdnRmI2aTZieVFWeFhFQm5sRTQrQkR3R2owQndLaWhWcXB4ajdOVkpz?=
 =?utf-8?B?MzVyQnlzUlBHWnQ2UUFEdXR4VDdlV3VOdjRjTEkxMHNhTlR1QlQ5S3I0cEl5?=
 =?utf-8?B?OVA5akJhTFczSHpxdEFBNDVVQ2dJRDVmMzNuRkU5aHpVLy9UL3o2VXBkaVNl?=
 =?utf-8?B?RXNoSmJpV3hDOGg5YytVUmY4L0UzSlBBdkxnTUVtZmZqZVhNekpjWVhMd0NP?=
 =?utf-8?Q?fGms=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57d7063-61bc-4379-2b72-08dcef7e7956
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 14:09:26.2555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyCZisfpGHmLVlq1FDFp0dfgqK4ogNh6zMxB7wAwQ0c4ZKEf2uMYyetfQHuNZgh/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239
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


On 10/17/2024 4:04 PM, Felix Kuehling wrote:
>
> On 2024-10-15 17:21, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> The purpose of this patch is having kfd driver function as expected 
>> during AMD
>> gpu device plug/unplug.
>>
>> When an AMD gpu device got unplug kfd driver stops all queues from 
>> this device.
>> If there are user processes still ref the render node this device is 
>> marked as
>> invalid. kfd driver will return error to following requests to the 
>> device from
>> all existing user processes. Existing user processes can still use 
>> remaining
>> gpu devices during/after unplug event.
>>
>> After all refs to the device have been closed from user space kfd driver
>> topology got updated by removing correspodent kfd nodes.
>>
>> User space can use remaining gpu devices that are valid at same time. 
>> When all
>> AMD gpu devices got removed kfd driver will not allow open /dev/kfd 
>> request.
>>
>> Unplugged AMD gpu devices can be re-plugged. kfd driver will use 
>> added devices
>> and function as usual.
>>
>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  5 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  7 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 78 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 43 ++++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  6 ++
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 ++
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 13 +++-
>>   .../amd/amdkfd/kfd_process_queue_manager.c    | 24 ++++++
>>   9 files changed, 183 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index b545940e512b..651ae0775f80 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -248,6 +248,11 @@ void amdgpu_amdkfd_interrupt(struct 
>> amdgpu_device *adev,
>>           kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
>>   }
>>   +void amdgpu_amdkfd_teardown_kfd_device(struct kfd_dev *kfd)
>> +{
>> +       kgd2kfd_teardown_kfd_device(kfd);
>> +}
>> +
>>   void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
>>   {
>>       if (adev->kfd.dev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 7e0a22072536..bd241f569b79 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -152,6 +152,7 @@ struct amdkfd_process_info {
>>     int amdgpu_amdkfd_init(void);
>>   void amdgpu_amdkfd_fini(void);
>> +void amdgpu_amdkfd_teardown_kfd_device(struct kfd_dev *kfd);
>>     void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>>   int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>> @@ -431,6 +432,7 @@ int kgd2kfd_check_and_lock_kfd(void);
>>   void kgd2kfd_unlock_kfd(void);
>>   int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
>>   int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
>> +void kgd2kfd_teardown_kfd_device(struct kfd_dev *kfd);
>>   #else
>>   static inline int kgd2kfd_init(void)
>>   {
>> @@ -511,5 +513,10 @@ static inline int kgd2kfd_stop_sched(struct 
>> kfd_dev *kfd, uint32_t node_id)
>>   {
>>       return 0;
>>   }
>> +
>> +void kgd2kfd_teardown_processes(void)
>> +{
>> +}
>> +
>>   #endif
>>   #endif /* AMDGPU_AMDKFD_H_INCLUDED */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 1e47655e02c6..4529d7a88b98 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3315,7 +3315,8 @@ static int amdgpu_device_ip_fini_early(struct 
>> amdgpu_device *adev)
>>       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>   -    amdgpu_amdkfd_suspend(adev, false);
>> +    if (adev->kfd.dev)
>> +        amdgpu_amdkfd_teardown_kfd_device(adev->kfd.dev);
>>         /* Workaroud for ASICs need to disable SMC first */
>>       amdgpu_device_smu_fini_early(adev);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index a1f191a5984b..d246f72ae0e9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -327,6 +327,13 @@ static int kfd_ioctl_create_queue(struct file 
>> *filep, struct kfd_process *p,
>>           err = -EINVAL;
>>           goto err_pdd;
>>       }
>> +
>> +    if (!is_kfd_process_device_valid(pdd)) {
>> +        pr_debug("gpu 0x%x is not available\n", args->gpu_id);
>> +        err = -EINVAL;
>> +        goto err_pdd;
>> +    }
>> +
>
> Instead of duplicating this in all the ioctl functions, could this 
> check be done in kfd_process_device_data_by_id?

Yes, that makes code simpler. Also, need add same check on 
kfd_get_process_device_data.

>
>
>>       dev = pdd->dev;
>>         pdd = kfd_bind_process_to_device(dev, p);
>> @@ -578,6 +585,12 @@ static int kfd_ioctl_set_memory_policy(struct 
>> file *filep,
>>           goto err_pdd;
>>       }
>>   +    if (!is_kfd_process_device_valid(pdd)) {
>> +        pr_debug("gpu 0x%x is not available\n", args->gpu_id);
>> +        err = -EINVAL;
>> +        goto err_pdd;
>> +    }
>> +
>>       pdd = kfd_bind_process_to_device(pdd->dev, p);
>>       if (IS_ERR(pdd)) {
>>           err = -ESRCH;
>> @@ -621,6 +634,11 @@ static int kfd_ioctl_set_trap_handler(struct 
>> file *filep,
>>           goto err_pdd;
>>       }
>>   +    if (!is_kfd_process_device_valid(pdd)) {
>> +        err = -EINVAL;
>> +        goto err_pdd;
>> +    }
>> +
>>       pdd = kfd_bind_process_to_device(pdd->dev, p);
>>       if (IS_ERR(pdd)) {
>>           err = -ESRCH;
>> @@ -704,6 +722,9 @@ static int kfd_ioctl_get_process_apertures(struct 
>> file *filp,
>>       for (i = 0; i < p->n_pdds; i++) {
>>           struct kfd_process_device *pdd = p->pdds[i];
>>   +        if (!is_kfd_process_device_valid(pdd))
>> +            continue;
>> +
>>           pAperture =
>> &args->process_apertures[args->num_of_nodes];
>>           pAperture->gpu_id = pdd->dev->id;
>> @@ -779,6 +800,9 @@ static int 
>> kfd_ioctl_get_process_apertures_new(struct file *filp,
>>       for (i = 0; i < min(p->n_pdds, args->num_of_nodes); i++) {
>>           struct kfd_process_device *pdd = p->pdds[i];
>>   +        if (!is_kfd_process_device_valid(pdd))
>> +            continue;
>> +
>>           pa[i].gpu_id = pdd->dev->id;
>>           pa[i].lds_base = pdd->lds_base;
>>           pa[i].lds_limit = pdd->lds_limit;
>> @@ -901,6 +925,11 @@ static int 
>> kfd_ioctl_set_scratch_backing_va(struct file *filep,
>>           goto bind_process_to_device_fail;
>>       }
>>   +    if (!is_kfd_process_device_valid(pdd)) {
>> +        err = PTR_ERR(pdd);
>> +        goto bind_process_to_device_fail;
>> +    }
>> +
>>       pdd->qpd.sh_hidden_private_base = args->va_addr;
>>         mutex_unlock(&p->mutex);
>> @@ -981,6 +1010,11 @@ static int kfd_ioctl_acquire_vm(struct file 
>> *filep, struct kfd_process *p,
>>           goto err_pdd;
>>       }
>>   +    if (!is_kfd_process_device_valid(pdd)) {
>> +        ret = -EINVAL;
>> +        goto err_pdd;
>> +    }
>> +
>>       if (pdd->drm_file) {
>>           ret = pdd->drm_file == drm_file ? 0 : -EBUSY;
>>           goto err_drm_file;
>> @@ -1031,6 +1065,10 @@ static int 
>> kfd_ioctl_get_available_memory(struct file *filep,
>>         if (!pdd)
>>           return -EINVAL;
>> +
>> +    if (!is_kfd_process_device_valid(pdd))
>> +        return -EINVAL;
>> +
>>       args->available = 
>> amdgpu_amdkfd_get_available_memory(pdd->dev->adev,
>>                               pdd->dev->node_id);
>>       kfd_unlock_pdd(pdd);
>> @@ -1090,6 +1128,11 @@ static int 
>> kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>>           goto err_pdd;
>>       }
>>   +    if (!is_kfd_process_device_valid(pdd)) {
>> +        err = -EINVAL;
>> +        goto err_pdd;
>> +    }
>> +
>>       dev = pdd->dev;
>>         if ((flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) &&
>> @@ -1202,6 +1245,12 @@ static int kfd_ioctl_free_memory_of_gpu(struct 
>> file *filep,
>>           goto err_pdd;
>>       }
>>   +    if (!is_kfd_process_device_valid(pdd)) {
>> +        pr_err("Process device is not valid\n");
>> +        ret = -EINVAL;
>> +        goto err_pdd;
>> +    }
>> +
>>       mem = kfd_process_device_translate_handle(
>>           pdd, GET_IDR_HANDLE(args->handle));
>>       if (!mem) {
>> @@ -1266,6 +1315,12 @@ static int kfd_ioctl_map_memory_to_gpu(struct 
>> file *filep,
>>           err = -EINVAL;
>>           goto get_process_device_data_failed;
>>       }
>> +
>> +    if (!is_kfd_process_device_valid(pdd)) {
>> +        err = -EINVAL;
>> +        goto get_process_device_data_failed;
>> +    }
>> +
>>       dev = pdd->dev;
>>         pdd = kfd_bind_process_to_device(dev, p);
>> @@ -1384,6 +1439,11 @@ static int 
>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>           goto bind_process_to_device_failed;
>>       }
>>   +    if (!is_kfd_process_device_valid(pdd)) {
>> +        err = -EINVAL;
>> +        goto bind_process_to_device_failed;
>> +    }
>> +
>>       mem = kfd_process_device_translate_handle(pdd,
>>                           GET_IDR_HANDLE(args->handle));
>>       if (!mem) {
>> @@ -1567,6 +1627,11 @@ static int kfd_ioctl_import_dmabuf(struct file 
>> *filep,
>>           goto err_unlock;
>>       }
>>   +    if (!is_kfd_process_device_valid(pdd)) {
>> +        r = PTR_ERR(pdd);
>> +        goto err_unlock;
>> +    }
>> +
>>       r = amdgpu_amdkfd_gpuvm_import_dmabuf_fd(pdd->dev->adev, 
>> args->dmabuf_fd,
>>                            args->va_addr, pdd->drm_priv,
>>                            (struct kgd_mem **)&mem, &size,
>> @@ -1616,6 +1681,11 @@ static int kfd_ioctl_export_dmabuf(struct file 
>> *filep,
>>           goto err_unlock;
>>       }
>>   +    if (!is_kfd_process_device_valid(pdd)) {
>> +        ret = -EINVAL;
>> +        goto err_unlock;
>> +    }
>> +
>>       mem = kfd_process_device_translate_handle(pdd,
>>                           GET_IDR_HANDLE(args->handle));
>>       if (!mem) {
>> @@ -1660,6 +1730,9 @@ static int kfd_ioctl_smi_events(struct file 
>> *filep,
>>       if (!pdd)
>>           return -EINVAL;
>>   +    if (!is_kfd_process_device_valid(pdd))
>> +        return -EINVAL;
>> +
>>       return kfd_smi_event_open(pdd->dev, &args->anon_fd);
>>   }
>>   @@ -2990,6 +3063,11 @@ static int kfd_ioctl_set_debug_trap(struct 
>> file *filep, struct kfd_process *p, v
>>               r = -ENODEV;
>>               goto unlock_out;
>>           }
>> +
>> +        if (!is_kfd_process_device_valid(pdd)) {
>> +            r = -ENODEV;
>> +            goto unlock_out;
>> +        }
>>       }
>>         switch (args->op) {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index fad1c8f2bc83..019567249110 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -893,6 +893,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>       svm_range_set_max_pages(kfd->adev);
>>         kfd->init_complete = true;
>> +    kfd->valid = true;
>>       dev_info(kfd_device, "added device %x:%x\n", 
>> kfd->adev->pdev->vendor,
>>            kfd->adev->pdev->device);
>>   @@ -919,6 +920,10 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>     void kgd2kfd_device_exit(struct kfd_dev *kfd)
>>   {
>> +    struct kfd_process *p;
>> +    unsigned int i, j;
>> +    unsigned int temp;
>> +
>>       if (kfd->init_complete) {
>>           /* Cleanup KFD nodes */
>>           kfd_cleanup_nodes(kfd, kfd->num_nodes);
>> @@ -929,6 +934,20 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>>           amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
>>       }
>>   +    /* now this kfd_dev has been completely removed from kfd driver
>> +     * before kfree kfd iterate all existing kfd processes, if kfd 
>> process
>> +     * uses any kfd node from this kfd set its ref to NULL
>> +     */
>> +    hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>> +        for (i = 0; i < kfd->num_nodes; i++)
>> +            for (j = 0; j < p->n_pdds; j++) {
>> +                if (kfd->nodes[i] == p->pdds[j]->dev) {
>> +                    p->pdds[j]->dev = NULL;
>
> Could this be done in teardown_kfd_device? Then you may not need a 
> separate "valid" for is_kfd_process_device_valid. And any accidental 
> access to a device associated with an invalid pdd would automatically 
> trigger a kernel error message with a backtrace.

At teardown_kfd_device the adev has not been removed, ex: there are user 
apps still refer the render node. kfd dev(kfd nodes) is released at 
kfd_cleanup_nodes of kgd2kfd_device_exit when all ref to adev got 
released(user apps close render node). During that time kfd 
nodes(pdd->dev) are valid. We still can access kfd nodes data structure 
though their queues got stopped and kfd_node->kfd has been markded as 
invalid.

>
>
>> +                    break;
>> +                }
>> +            }
>> +    }
>> +
>>       kfree(kfd);
>>   }
>>   @@ -1485,6 +1504,30 @@ int kgd2kfd_stop_sched(struct kfd_dev *kfd, 
>> uint32_t node_id)
>>       return node->dqm->ops.halt(node->dqm);
>>   }
>>   +/* tear down this kfd deve */
>> +void kgd2kfd_teardown_kfd_device(struct kfd_dev *kfd)
>> +{
>> +    struct kfd_process *p;
>> +    struct kfd_node *dev;
>> +    unsigned int i;
>> +    unsigned int temp;
>> +
>> +    kfd->valid = false;
>> +    /* stop queues from kfd nodes in this kfd dev */
>> +    for (i = 0; i < kfd->num_nodes; i++) {
>> +        dev = kfd->nodes[i];
>> +        dev->dqm->ops.stop(dev->dqm);
>> +    }
>
> If the GPU was unplugged already, what's the point of this? Won't this 
> trigger a timeout?
>
pci base driver will find that the device has been unplugged, will not 
call amdgpu driver's callback for pci device that has been removed. So 
that would not happen.
>
>> +
>> +    /* signal a gpu device is being teared down to user spalce 
>> processes by
>> +     * KFD_EVENT_TYPE_HW_EXCEPTION event
>> +     */
>> +    hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes)
>> +        kfd_signal_hw_exception_event(p->pasid);
>
> This sends exceptions to all processes. It should only do this for 
> processes that use the unplugged device (i.e. have a pdd that uses the 
> device). This excludes processes that don't have the device in their 
> cgroup.
ok, will iterate all existing kfd processes. If any kfd node from this 
kfd dev got used by a kfd process send the event to correspondent user 
process.
>
>
>> +
>> +    return;
>> +}
>> +
>>   #if defined(CONFIG_DEBUG_FS)
>>     /* This function will send a package to HIQ to hang the HWS
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> index dbcb60eb54b2..b8dd80ee17be 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> @@ -378,6 +378,12 @@ int kfd_init_apertures(struct kfd_process *process)
>>               continue;
>>           }
>>   +        /* kfd device that this kfd node belogns is not valid */
>> +        if (!dev->kfd->valid) {
>> +            id++;
>> +            continue;
>> +        }
>> +
>>           pdd = kfd_create_process_device_data(dev, process);
>>           if (!pdd) {
>>               dev_err(dev->adev->dev,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 6a5bf88cc232..97e7692ce569 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -371,6 +371,9 @@ struct kfd_dev {
>>         /* bitmap for dynamic doorbell allocation from doorbell 
>> object */
>>       unsigned long *doorbell_bitmap;
>> +
>> +    /* this kfd_dev valid or not */
>> +    bool valid;
>>   };
>>     enum kfd_mempool {
>> @@ -1055,6 +1058,10 @@ int kfd_process_restore_queues(struct 
>> kfd_process *p);
>>   void kfd_suspend_all_processes(void);
>>   int kfd_resume_all_processes(void);
>>   +static inline bool is_kfd_process_device_valid(struct 
>> kfd_process_device *pdd) {
>> +    return (pdd && pdd->dev && pdd->dev->kfd && pdd->dev->kfd->valid);
>> +}
>> +
>>   struct kfd_process_device *kfd_process_device_data_by_id(struct 
>> kfd_process *process,
>>                                uint32_t gpu_id);
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index d07acf1b2f93..c06eb9d8008e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1157,8 +1157,6 @@ static void kfd_process_wq_release(struct 
>> work_struct *work)
>>       ef = rcu_access_pointer(p->ef);
>>       dma_fence_signal(ef);
>>   -    kfd_process_remove_sysfs(p);
>> -
>>       kfd_process_kunmap_signal_bo(p);
>>       kfd_process_free_outstanding_kfd_bos(p);
>>       svm_range_list_fini(p);
>> @@ -1173,6 +1171,11 @@ static void kfd_process_wq_release(struct 
>> work_struct *work)
>>         put_task_struct(p->lead_thread);
>>   +    /* the last step is removing process entries under /sys
>> +     * to indicate the process has been terminated.
>> +     */
>
> This comment doesn't provide any useful information. What would be 
> useful is, why this needs to be the last step? Without that, I see no 
> good reason for this change.
ok, this change is not related to the patch. I thought it is better to 
update kfd topology at last step after all kfd process resources got 
released. I will remove this change.
>
>
>> +    kfd_process_remove_sysfs(p);
>> +
>>       kfree(p);
>>   }
>>   @@ -1536,6 +1539,12 @@ static struct kfd_process 
>> *create_process(const struct task_struct *thread)
>>       if (err != 0)
>>           goto err_init_apertures;
>>   +    /* no any kfd_process_device can be created */
>> +    if (!process->n_pdds) {
>> +        err = -ENODEV;
>> +        goto err_init_apertures;
>> +    }
>> +
>>       /* Check XNACK support after PDDs are created in 
>> kfd_init_apertures */
>>       process->xnack_enabled = kfd_process_xnack_mode(process, false);
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> index c76db22a1000..eaf4ba65466c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> @@ -124,6 +124,11 @@ int pqm_set_gws(struct process_queue_manager 
>> *pqm, unsigned int qid,
>>           return -EINVAL;
>>       }
>>   +    if (!is_kfd_process_device_valid(pdd)) {
>> +        pr_debug("device 0x%x is not available\n",dev->node_id);
>> +        return -EINVAL;
>> +    }
>> +
>>       /* Only allow one queue per process can have GWS assigned */
>>       if (gws && pdd->qpd.num_gws)
>>           return -EBUSY;
>> @@ -498,6 +503,11 @@ int pqm_destroy_queue(struct 
>> process_queue_manager *pqm, unsigned int qid)
>>       if (WARN_ON(!dev))
>>           return -ENODEV;
>>   +    if (!dev->kfd || !dev->kfd->valid) {
>> +        pr_err("Process device is not valid\n");
>
> Would you expect to see this message during process termination after 
> a hot-unplug? Should this really be an error message, or would an info 
> or debug message be more appropriate?
I will change kfd_get_process_device_data that will include this check, 
then this message will be merged at !pdd case.
>
>
>> +        return -1;
>
> This should be a proper error code. -1 is -EPERM.
>
Same as above.
>
>> +    }
>> +
>>       pdd = kfd_get_process_device_data(dev, pqm->process);
>>       if (!pdd) {
>>           pr_err("Process device data doesn't exist\n");
>> @@ -567,6 +577,10 @@ int pqm_update_queue_properties(struct 
>> process_queue_manager *pqm,
>>           pdd = kfd_get_process_device_data(q->device, q->process);
>>           if (!pdd)
>>               return -ENODEV;
>> +
>> +        if (!is_kfd_process_device_valid(pdd))
>> +            return -ENODEV;
>> +         vm = drm_priv_to_vm(pdd->drm_priv);
>>           err = amdgpu_bo_reserve(vm->root.bo, false);
>>           if (err)
>> @@ -612,6 +626,11 @@ int pqm_update_mqd(struct process_queue_manager 
>> *pqm,
>>           return -EFAULT;
>>       }
>>   +    if (!pqn->q->device->kfd->valid) {
>> +        pr_debug("device where queue %d exists is not valid\n", qid);
>> +        return -EFAULT;
>> +    }
>> +
>>       /* CUs are masked for debugger requirements so deny user mask  */
>>       if (pqn->q->properties.is_dbg_wa && minfo && minfo->cu_mask.ptr)
>>           return -EBUSY;
>> @@ -679,6 +698,11 @@ int pqm_get_wave_state(struct 
>> process_queue_manager *pqm,
>>           return -EFAULT;
>>       }
>>   +    if (!pqn->q->device->kfd->valid) {
>> +        pr_debug("device where queue %d exists is not valid\n", qid);
>> +        return -EFAULT;
>
> EFAULT means "bad address". Probably not the right error code here.

Will use -EINVAL.

Thanks

Xiaogang

>
> Regards,
>   Felix
>
>
>> +    }
>> +
>>       return pqn->q->device->dqm->ops.get_wave_state(pqn->q->device->dqm,
>>                                  pqn->q,
>>                                  ctl_stack,
