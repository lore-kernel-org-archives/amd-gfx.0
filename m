Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2C6FB5EAA
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 03:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F16F810E86F;
	Thu, 19 Mar 2026 03:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QMMC0kSW";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 429C510E86F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 03:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmDUFCMKMa08NRMsd7Pj6wVrfSEv5evbUExpW5n1Pk99zNH46LJEjU9bWqWeHU7gXCRrgB6gYnFPSKTdyl3FZ76H4JFWNmjqBZGRSRHnQTPkU8Az70wMxfZ9tjfiBQJ1cVVc+zrMue6sdGnNIxeBkp5hHv2JMMc8v/Va1PZK028Bzu/G06iuz/x3lt5i5O1DCbpg5rgAV2Vxn4lSJgD/M8KYLzFuxy0eMBaXsP4BE9vb4ECEOGPVEN0Qtw95/hd/BBnNEg+a8QeqqZZli02TjLE/7M7IPQM172zb8CgnPsacP2zimHNZBAHIDdNO+41KVPZSqrnvtFTc8M7O56XSig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5dTUyHTyXq/oW8QP3EMamMJ5TEOZSX5d3TGxu7H9oE=;
 b=nqFiQZReIvuTMw8Bjx6mGQzdWJA7VaX490xeTtoYnz472bXAYxI2Tv4VzWgBDUaopwpFlUmp32UCsPzZF8qiNl2GPJ7Xd4u5UQLHIU8l674Ed4ED9/UTjW9tHi6wP9MoItetsEz31rEZuttDnlgZGpdr5bSoggTuY7FGoBpQIM0PDjaG1zHl2Vd4xlIZ5BPcP1az2TcsTwK8RM4p2QAfyVa7f83+jNKk3VmZGVfZg11N7/0mZn77stbnWEEOhUSba6MEkbQ1DPY5nNee56LYc/tR6HQ+klCPLCj2ohuoCXCEE+FMCgpO+LLlfA3pGbmAU/9uo+FDd4ODQ3G62mdflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5dTUyHTyXq/oW8QP3EMamMJ5TEOZSX5d3TGxu7H9oE=;
 b=QMMC0kSWbzWXv1M0PQMjk524Vw7o9zEKXw9N/QHuFGsnk0z5cX6QibdVh0I04EER+UVNijuywcRPL9pnWftJhy6SjsIubZpg2x3ZNbx+wqescpYdABAUuQJNBYyaXnzf0sT8Qipai0ftMCjVzw2/Oqq/IAu3e0YWh3Ip8e4YTY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 03:38:29 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 03:38:29 +0000
Message-ID: <c9603e2e-a55f-4a98-8d5d-86285d6f28dc@amd.com>
Date: Thu, 19 Mar 2026 09:08:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Review 1/1] drm/amdgpu: Add amdgpu_regs_pcie64 debugfs node
To: "Yang, Stanley" <Stanley.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260318112201.3779461-1-Stanley.Yang@amd.com>
 <f65148cd-5cf6-49c6-82de-9d0c22684656@amd.com>
 <PH7PR12MB7988DA658EB703CDFB61F4759A4FA@PH7PR12MB7988.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB7988DA658EB703CDFB61F4759A4FA@PH7PR12MB7988.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::24) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d3fe18d-9d3b-4f86-c71b-08de8568fc46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: LxHnA6WG6oMzC6AjpcMLLSrLHIN6oqf2wvH9H7bxZUMBsXF6qLkaDX+K0gLaRAvIQNPjhP4U76UpAVEyWcRXm1sc8EFKTwudOrhs8Ekv8680ZWO8Rn4l9JT89Tq6Hea1VFP/AVJN3fOaOu5kQBeGtZtV6gcufI0ppRqrC64BksWDbd41cclzDCWQKcLnBjAzWOGzV6y3cCFpHjNL5BbqJec1GMC1Vt5J/mFIzrH6hHSVBwDppezH2zb+XR/7kul/v6baTaNMo+1hhoy4acErAoQcI17aL3lh2qY+zBQ9eUJHHv4tQQoU7H4f1fO+vY5p+YVHs+CWdiNerE+/fYWJO9IR0EXeO3kx7pJQe1O18HS7dX8BLq9G2mlaQlEBdqYk7g0VgyRo0wmECWXQH4xmpaxuJUyG3hv/t8PPXoi5ehfL2ovr1RkSatYBgobRx/SFaSo5JLK0LJw5DEKttI32fr7E/z2Uh4aN9m8Igjw5RHTjx/jXxHx6cf26tD0fp+PpSBtrRXBhABdKDEpfWfG50TI53CYbOL2wnHHVt468yNrqxMjm11mpBh1zN+vbcu74nv4R6/6XQr2mSEp/L+FLHqmCt0wpeNSTl/RmG3qe9irDBraxwZ+zIMhkziH4rIDl/0fhWccfpHF3f/uOq+AsXrZ53xKernATGtPcLpcmpaDfaWDwQFxHYFRHwEy/wXxMj973l3RcESQntF5n0YalTBwIj9BFFT6mE9FZiSgS6xEgu7NWfK717me+H1ySm9No
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlArR1NSQUtZMWZidnFCdGZYQ3BpcUY0MEhjSWpBU2RVZnVWYWdEcmlZNzBJ?=
 =?utf-8?B?bXVlWmJKcnRGU3NmYUIvNkkrWE1KU3BCOHZRK1ZxL0I3SGo5dk1WUGRPRTVU?=
 =?utf-8?B?U3o4ZkZ6QXNZbUZzbGlub2VxRS9CM1p6T3BPZjR4MFRWeW5xdUFVbDRkb0lO?=
 =?utf-8?B?eWdzTGY2eTEwRy85cXl3cEt0QXdlR0NyWjYzbkh1MitQYm9BaWJlQk1MUVVG?=
 =?utf-8?B?N1JZWWpTMUJaS3FZRFNFWVlNenRTOGVoKzB5cGJ3QzZrM0ZRSFBEa1ZDek1D?=
 =?utf-8?B?NmczMENiL2tnQVhrdGthUzJZYndBdTZtSURLNEVmSS9hR0M5ZU9aVmtuWlRq?=
 =?utf-8?B?dytFUUl3dDdkN05XVU9jeWpCZ2RDdWM3OVV6NGpkQzE1d1cxeTFZbHF4S3NO?=
 =?utf-8?B?bW1UV1ZXZG1jRlpDMEg5RkpzRFZtYTFqWnBOV3JUZjh0bi9lVTMxanZTdXA0?=
 =?utf-8?B?TnNwM2ZQY29Zd0RNelVRbnI3MDZncmRaM1FiaGZNalZid1dScllTb2cxMUR1?=
 =?utf-8?B?bHdxclFUbi9YaCtHaGlzdHQ3RzVxam5tbi9nUG16eDM0UmRFLzhCa203a2l2?=
 =?utf-8?B?dWpyWDZzSjYvOVNTUDNFM2hwUC9kYWpJTXdSZHY3OEVOa3VhSnIrVFRneEgz?=
 =?utf-8?B?VGRZQ1FuMDFWTnVMeThad0ZYT1VZTDcvR3htR0k2RUVBQTRJdHU0bUF3S1pt?=
 =?utf-8?B?SGw1R1hmTS9CY3BsZnAwU3VJZW1YMkRvTThPa1lYdkJoM1d0OGVKSkNKMmxF?=
 =?utf-8?B?aS9USjlteHN4NVJJZGlBdmdhc1E3WjhRekFiVGRmN21IWWU5bHBXRC93bkJp?=
 =?utf-8?B?dnZOSUlTY2h4WWJqMmwxVHNZbEk0ZTBVZmdOZ2hDYnRId3Rjd2MyZDVmOXVk?=
 =?utf-8?B?S3NoSm1KOTJieE1GTG1RS2FJNjMzSmtRejdNblo4clJFbGt2c2x0ekFCNy8w?=
 =?utf-8?B?cmU4NjhWbU9DbjRxYjBzM0pZbmdXNHg3alpZOFlYdmZZN3pnd3lsbnBBWG9K?=
 =?utf-8?B?TkJETEZNYUtTY09ad1NhZHdPK0lrV0tGb3JrMnhzNWx2MlRVOU5JRzNLb3Fw?=
 =?utf-8?B?VDJrREZYQlN5d2RSTVhmT2R3NXJsNWNXRVNwM1FUYTFzL1ZpeHV4N0g5Nytn?=
 =?utf-8?B?ek1PcXBiaE9QYnJOQlNkbXNEbE5FMnJMTTJ0QXhrVStxNnE0dmZwZjQyVnZs?=
 =?utf-8?B?aVNPU0J2cEx0N1RzalA3VmVoSlpydVYwR3kxRkVDU0hPblpKNGdBSi91azJo?=
 =?utf-8?B?b3R4UFJid1QwS2JGOEhPcjlpMURGdC8vYmh1TjJPdU1SZ2dWZHc3LzkxbHRw?=
 =?utf-8?B?Yk1FV0Q4K1pJS2h1VW03b0VjK2JkNlF5akhUV2xwODkxN2xxSklnYzNhdmNS?=
 =?utf-8?B?d3pjZWhpZ0hNSk4ySjhYaTZEYmpiT1Bha21QQ0pnN21LcmxGcGd3M2FELytn?=
 =?utf-8?B?UHZGd1k2NEVwdi9Dek94Ly9jcEZldWx5UnV5VXBIdWtjVUxONTdxbFozVGQw?=
 =?utf-8?B?a2FWSkdlMVZFWWtXOStQdlBWWlRMbzRWVTg3RCt4TU9DTERVMlhlSnducW5Y?=
 =?utf-8?B?SmU3SHc0M0JkbjZkM1NqZG8vMHJBM1RKN3Z5YlJoaGpQdEduL0Z0OXZBMFBz?=
 =?utf-8?B?MTFnYVg4NXFaMmxjcWo5eVdKdk1vU25zUnVUeHp6dDFiSXhMbmcwdjg4WGhS?=
 =?utf-8?B?b21UdkV6b0NXR2pleW1VNzZrYzhNN2MybnI1SkxIc0NDb3U1c0l5c2ZMV29t?=
 =?utf-8?B?eFFnK1c5VmpFU3VqZHlwb0F2R3JDKzU0K2xRc2VGMTlRRkxlUTRYM3U3d1Vw?=
 =?utf-8?B?QVZyU3c0cDY2OUQyaWt3NjgzeTJsUmRRNTgxMGF6bEpJSCtxWUdRdzJlMGoz?=
 =?utf-8?B?WXdWQmdZcXF5VG5pSDBWT3A1NTNDR1VKM2V4QTRPZm02K3Y2MFFPQlczenh6?=
 =?utf-8?B?ZDdHRFNrYThxQVJJRGRTRU9Nd1FQZmhEYllRRmdZaWpqaitzaE5jZ0JYczdm?=
 =?utf-8?B?RkROczRtaXhpUHcrU2xaNzNpaFN2bGk0elB2dVROb3NTZzVwd2NFUEk5YzNW?=
 =?utf-8?B?clMyR0pBbjI3aXZCdVJZaEFTc3ZLT0VUUjR0UHV1RGNRS3kvZTY2SEJhdThY?=
 =?utf-8?B?aVBVMWliK2tqQkV0TWE5dzlXcjdIbFc5MW1ZK0swdVE0TmRMeGs3TGZkckNS?=
 =?utf-8?B?NUwyeThNYWZReDhJSDc1UmhlNGN3SVEyQ2trLzBUSno2dEUzWGpBN1hsOU91?=
 =?utf-8?B?UDlTYXViNzV6L0w5MEJ0N2d6Vy8xRy9CUmhqSUtjeU5XTzNTRzd4N1NCTjlH?=
 =?utf-8?B?UzM0LzFoRlZZT2hjUVgyMmxlTHdjNmVZT3k4L1c4aTFud2pySVRmZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3fe18d-9d3b-4f86-c71b-08de8568fc46
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 03:38:29.3041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7o3a2f2c/tA8Eb4H749wqYS9q2AIisyWiZS7QZvYZbA4h+cKWAf6Fi3ldMcHp6pn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181
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



On 19-Mar-26 8:47 AM, Yang, Stanley wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, March 18, 2026 10:43 PM
>> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH Review 1/1] drm/amdgpu: Add amdgpu_regs_pcie64
>> debugfs node
>>
>>
>>
>> On 18-Mar-26 4:52 PM, Stanley.Yang wrote:
>>> Add amdgpu_regs_pcie64 debugfs node to read/write 64bit PCIE
>>> registers.
>>>
>>> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 113
>> ++++++++++++++++++++
>>>    1 file changed, 113 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 6fdcd9c78324..e15b3aa02919 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -622,6 +622,111 @@ static ssize_t
>> amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
>>>      amdgpu_virt_disable_access_debugfs(adev);
>>>      return r;
>>>    }
>>> +/**
>>> + * amdgpu_debugfs_regs_pcie64_read - Read from a 64-bit PCIE register
>>> + *
>>> + * @f: open file handle
>>> + * @buf: User buffer to store read data in
>>> + * @size: Number of bytes to read
>>> + * @pos:  Offset to seek to
>>> + */
>>> +static ssize_t amdgpu_debugfs_regs_pcie64_read(struct file *f, char __user
>> *buf,
>>> +                    size_t size, loff_t *pos) {
>>> +   struct amdgpu_device *adev = file_inode(f)->i_private;
>>> +   ssize_t result = 0;
>>> +   int r;
>>> +
>>> +   if (size & 0x7 || *pos & 0x7)
>>> +           return -EINVAL;
>>> +
>>> +   r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>> +   if (r < 0) {
>>> +           pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> +           return r;
>>> +   }
>>> +
>>> +   r = amdgpu_virt_enable_access_debugfs(adev);
>>> +   if (r < 0) {
>>> +           pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> +           return r;
>>> +   }
>>> +
>>> +   while (size) {
>>> +           uint64_t value;
>>> +
>>> +           value = RREG64_PCIE_EXT(*pos);
>>> +
>>> +           r = put_user(value, (uint64_t *)buf);
>>> +           if (r)
>>> +                   goto out;
>>> +
>>> +           result += 8;
>>> +           buf += 8;
>>> +           *pos += 8;
>>> +           size -= 8;
>>> +   }
>>> +
>>> +   r = result;
>>> +out:
>>> +   pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>> +   pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>
>> autosuspend also marks last_busy, it's no longer required to call it separately.
> 
> pm_runtime_put_autosuspend and pm_runtime_get_sync are paired, autosuspend is used to release runtime pm usage count,
> and it reads last_busy not marks last_busy.
> 

This is a recent change -

https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com/

Thanks,
Lijo

> Regards,
> Stanley
> 
>>
>> Thanks,
>> Lijo
>>
>>> +   amdgpu_virt_disable_access_debugfs(adev);
>>> +   return r;
>>> +}
>>> +
>>> +/**
>>> + * amdgpu_debugfs_regs_pcie64_write - Write to a 64-bit PCIE register
>>> + *
>>> + * @f: open file handle
>>> + * @buf: User buffer to write data from
>>> + * @size: Number of bytes to write
>>> + * @pos:  Offset to seek to
>>> + */
>>> +static ssize_t amdgpu_debugfs_regs_pcie64_write(struct file *f, const char
>> __user *buf,
>>> +                     size_t size, loff_t *pos) {
>>> +   struct amdgpu_device *adev = file_inode(f)->i_private;
>>> +   ssize_t result = 0;
>>> +   int r;
>>> +
>>> +   if (size & 0x7 || *pos & 0x7)
>>> +           return -EINVAL;
>>> +
>>> +   r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>> +   if (r < 0) {
>>> +           pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> +           return r;
>>> +   }
>>> +
>>> +   r = amdgpu_virt_enable_access_debugfs(adev);
>>> +   if (r < 0) {
>>> +           pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> +           return r;
>>> +   }
>>> +
>>> +   while (size) {
>>> +           uint64_t value;
>>> +
>>> +           r = get_user(value, (uint64_t *)buf);
>>> +           if (r)
>>> +                   goto out;
>>> +
>>> +           WREG64_PCIE_EXT(*pos, value);
>>> +
>>> +           result += 8;
>>> +           buf += 8;
>>> +           *pos += 8;
>>> +           size -= 8;
>>> +   }
>>> +
>>> +   r = result;
>>> +out:
>>> +   pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>> +   pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> +   amdgpu_virt_disable_access_debugfs(adev);
>>> +   return r;
>>> +}
>>>
>>>    /**
>>>     * amdgpu_debugfs_regs_didt_read - Read from a DIDT register @@
>>> -1544,6 +1649,12 @@ static const struct file_operations
>> amdgpu_debugfs_regs_pcie_fops = {
>>>      .write = amdgpu_debugfs_regs_pcie_write,
>>>      .llseek = default_llseek
>>>    };
>>> +static const struct file_operations amdgpu_debugfs_regs_pcie64_fops = {
>>> +   .owner = THIS_MODULE,
>>> +   .read = amdgpu_debugfs_regs_pcie64_read,
>>> +   .write = amdgpu_debugfs_regs_pcie64_write,
>>> +   .llseek = default_llseek
>>> +};
>>>    static const struct file_operations amdgpu_debugfs_regs_smc_fops = {
>>>      .owner = THIS_MODULE,
>>>      .read = amdgpu_debugfs_regs_smc_read, @@ -1606,6 +1717,7 @@
>> static
>>> const struct file_operations *debugfs_regs[] = {
>>>      &amdgpu_debugfs_gprwave_fops,
>>>      &amdgpu_debugfs_regs_didt_fops,
>>>      &amdgpu_debugfs_regs_pcie_fops,
>>> +   &amdgpu_debugfs_regs_pcie64_fops,
>>>      &amdgpu_debugfs_regs_smc_fops,
>>>      &amdgpu_debugfs_gca_config_fops,
>>>      &amdgpu_debugfs_sensors_fops,
>>> @@ -1623,6 +1735,7 @@ static const char * const debugfs_regs_names[] =
>> {
>>>      "amdgpu_gprwave",
>>>      "amdgpu_regs_didt",
>>>      "amdgpu_regs_pcie",
>>> +   "amdgpu_regs_pcie64",
>>>      "amdgpu_regs_smc",
>>>      "amdgpu_gca_config",
>>>      "amdgpu_sensors",
> 

