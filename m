Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAABC79F99
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 14:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B825310E4BD;
	Mon,  7 Sep 2026 14:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LTcGkdso";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94D9610E028
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 14:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDQttcM9sPrPN19S8Pcp1WZ2I/cwWw8Y1wv225Jot2BJHDMsinMgchZ2UWYJnbRmGso2tAwa/ZIaWsYmUT4bNWGScRoCdwfwOaYVX/fvVcveHTCVXNwafRWY2Zgax6erDsUaaiLIqdRdbOD3Mkr7bH1uRFi/Ql9rOdI/K9hZU51lTsjigMVxDjITX0LZg8dtt9z3UlJsPSuoNFSAvoitCFnIK8caVbl4B0sSbUDtXMj0d+nfM/E0n5G6pIEAS0cxm/7S0uTcaSHP+54YnMpiePx6oHSWt7hb7AtB0+lPrSWmR5sv8EOdGeo+YskdGwtEI4PfVQYSuSqgp2ngayabvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuskxkOmaHxs6GboTBRJR69RCkagRliwzB9XneqjuUM=;
 b=L800rSG9ljIZ0ClFpFT4vl/tyvTlQfPwV8jJwxryO6h2svH1EjtL+WmlvXD90R2j1UGe9mArNNZtg1bEwdE7iglfkFa+8BE1DYPXpFjcY3AFCYFpMDMXpJwadj4vTT0tk8nsaO5T5MBLr8bfF0vK29q3Zjjx3jSPcBYiewQ2Q/LWJxyhw0RTDVctwgVvZ7yw7Eg5hC3cQpNpvdvE3EBh/1AaGCcAQJYB2/q2iZ6ae0SZVFobOrPGl0zxfEAW+oB2iPakVa5oDTnm+u6+Obw1Ik/DPoBZy1DikXFz08BW639LvMZ0Ar/dS0oniuuPXq+D60mRxBjWkPEgW3PV+1+qBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuskxkOmaHxs6GboTBRJR69RCkagRliwzB9XneqjuUM=;
 b=LTcGkdso8+Fqp4gyio/yTK8kRTfw7P8YsHhUMpsk6OBpgueUTyCenVECqhUwBWtXuN/66vm54YbKTSTFqSPhXlU7z4UPQM8tIbaRBX81gcEpt31JLm+PgLpQS2plWje2Xo1AmgM3VycR2OIgx3I2Wo55PEl10/MhKcZxS7Pf4MU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:42:16 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:42:16 +0000
Content-Type: multipart/alternative;
 boundary="------------HOCjM8jGFone8aZkYXaQgtpF"
Message-ID: <7b03140a-5c9b-4e87-92b7-72e8c1d93722@amd.com>
Date: Mon, 7 Sep 2026 20:12:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: fix userq_signal_ioctl stuck in
 drm_exec_until_all_locked()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20260907084719.3972-1-yogesh.mohanmarimuthu@amd.com>
 <f9e8f8ff-ee5b-42d1-bc80-4ee22e4f3677@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <f9e8f8ff-ee5b-42d1-bc80-4ee22e4f3677@amd.com>
X-ClientProxiedBy: PN3PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::14) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2a6c82-d596-4fd9-68f6-08df0cee3613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006|8096899003|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info: 9aJHWwpCwwlQsWEJaByq0jwcpyzMxPSH/AZqEuwgODWWvw7LAp5H1s4F6bTpCUdROBk+aEq7Lbm4yfZhdPleHnMj0+m/26lqyMLisbl4ToYuFijMDuQrseAbDXHL8Z4Y8ktMxWlGv4nfvYNAag21ECDip6UYooeIosZxQtvKJvKjoi740AdJtw6CCYKD2Lpw+ABP5uuYwZWoWXhauOddiEPqUeI5sv2Ws74e2u15RN05pgA/v5nlBivn9l5vDihJotdk5HU5yNlXphtDG2BqYJTlYFCr4bmNLmDb56bgWX3D9iE3FwvhvrrTj8qSDhAjDdL9qBTbA9JOhYTg/FqZ2jOGpkSJwhepDKmjlNl3BdJqqE2skjgtS0ik71RMlI88y/VF8I2s7gLIGBNlP2WBivjbcXJFa/0PYiWnaAvo/sUdN2p1R7NHZdAQTvMx3Vmi7neN4m4nSsAVRXNhw8nntsoums5c2eGZ9XQvdlPOCXdksetLiv9wkqCLmOVzdAGhwQ4lz7zCC6E28S8WgIia89uNJi2MmoWPrO/+2X/4arMd6FM2p35vDSHe6UfPNu/LnkEIOoHsR2R12hQlm/9CmgcneMMWqrEJwToHVVfrG+phBDK5z5c0rUjwBB2m8HCF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(8096899003)(4143699003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlZyZmVQaC9LNGNEdFExN1V5eDB0c3d6L1hMYkw5Tm0vR3g1bnlUWCtNR1BZ?=
 =?utf-8?B?RnBlVnRwOG14Tk9iR0N6SkR6dWphRml0dFcrLzZMNzZCZTV2Q2JmU3dqbUJr?=
 =?utf-8?B?RzA4cHlMYkVjNWJjUDBjMmlZei9WaWxQRndUUFVxQ3NDZ0EzTDBQN0NUM2dk?=
 =?utf-8?B?N0dFSFhzbDNQdXQydDdSZGFLUjVBREMzT2o4OUFqZzhRcDFKRDBOdTZhNkg4?=
 =?utf-8?B?V1NaWlQyOUhYdHhyZ2dGeG9jcXRrb0JMby9KTHdvbTk1amNxbUVrZGo2cjg1?=
 =?utf-8?B?dUw1dFV5RkNJTFBtMUYxSWNCb2lHTmo0WTIxaVNmNFU5Q2VmN3U0bE1waVRy?=
 =?utf-8?B?UjlITXV1TW1KZWx5Q1lCZlpYSkU3b2tqQkJWMlBDZGlpUHJNMVplaFJxRTZv?=
 =?utf-8?B?VGszOUJKUy9VTUFOZEFsdGFadzJSNzNXRTZtTjR4S1BRZTJZcFV2RmhJb2po?=
 =?utf-8?B?eTdhMGJyOEE0Mkg4bXVWeEViNFpzc01xaUJuSENSRGtUWE9PWGtPZ1FISVNN?=
 =?utf-8?B?QVREUkNaUmJ4YmtMN2t5UHRWMGpEUEtTeEtiQ0dTazJCajdVSGgzSGdPdC9z?=
 =?utf-8?B?d2tnZkZ5QlJxZk5yQUp4NlhXT2c3ODczd2ZEQ2JXS1lUSE1uZythSExDMzNU?=
 =?utf-8?B?WVpvSDNiWC9XQVM1SERrNStLQjk3K245dzVMdURpNE1TYUg5N1V5emNGTDdZ?=
 =?utf-8?B?VkZ2ak9VNmJ4Rll4c2VrQVBBd29NbTVBcnB3Q3V4bkxFS2xvMlN0cHNmWDNI?=
 =?utf-8?B?QXFVdlpLZ1laSVRDbTJWdEhvRExlMUtXWFkwK1RKejMxZzFHVlI1SXZyZ0RR?=
 =?utf-8?B?c3M0Wmg5M0dnc0s1aVE4cmJ2QkpEV2UyM1N2RlU0bVNtWERSRks4R0h5WkJF?=
 =?utf-8?B?MXBQZWdid3FsVk1KaTFwaGY5ZkNOUnhTYkZSb0o4eGJDb0FJUUI2aXhtTElx?=
 =?utf-8?B?RnQrREVmdlhNNjZXb215MVJVU05HWk5ZMW5tZUFmVEVvVVVNZGNQSjRTak9z?=
 =?utf-8?B?VG9xa3p0dlRJUmNucUZpWjJLSUtsZi9RaFF5MFM3Z2FrbENTbjVqSEpJbmxn?=
 =?utf-8?B?WUwxZFd2VWpHL2hBd3BWSzVKemx1YVZQQ05WMFlSc0RMSWN5WHhOait6QlF6?=
 =?utf-8?B?ZXBEQ0RnbHlvUlNRK0wrNXEwZEx1SmpkT2dIMFZ2cGhmYW9mMEtrWmxpTW5R?=
 =?utf-8?B?bFN5OEJsNjNkbVlwVENjUWNiTzYrYUdwVERYZzhYNEdRZGN6YTBveTRmN09H?=
 =?utf-8?B?NUZFTW85TUNGYmR4TldzODk1WjVQTHFHMXh2dHZ6V09zWStmNU92Y1E4eENs?=
 =?utf-8?B?aHMrdnQxSVBYSTZnLzB3ZENwWGx0bThBYlBIZi9vU24rUEFsWlZ4d0lUaExL?=
 =?utf-8?B?a05QcHBhak1Ib3gzZ3pOWjRCdGQwUmF2dVJpNEZSaWtBM1BibGptRjBSWnYr?=
 =?utf-8?B?TU5GS1FPdjE5RHdjdm14emRKMmtvME0xcyttTlJUUlR3aG11V2IvbWxXUDhF?=
 =?utf-8?B?Uk5CSThTV05CempTMTJ4MWRTRlM0S1MzNkI2SUZUNFJzWVNMb3lQRmRDeS93?=
 =?utf-8?B?TVQyYjJKb0g0bENUZUdKZVVuSnpPekhWZ1JEYlhGcGtvZ1F3eXFFcytUQWN5?=
 =?utf-8?B?SWpUQktEU1B2RmlTcEpTSksraUhIMEFoUkMzTUxndS9saVUrVnFSRmFMTkFK?=
 =?utf-8?B?VThLbEVZVDJpK3BweUF1T0tEaDRYQzkwWWxXaXd5TFV4VjBRWWEzVThqM3hP?=
 =?utf-8?B?YXczMisrSjlKM0QwcTcrZ0lqcWVpbDRieEhhc1AwVjJmNzhoZE12MTNjV1RI?=
 =?utf-8?B?WmNNdlNaVUs3RjNMQktzZFV4Y0FjV01NQnVTMkFHMGpuOTl1cERqMWlBcGN2?=
 =?utf-8?B?ZU1uQ1RtMXoyQVE0VzVQUTd2OHhFczdERFJZdEd0TENUbk84OTM5WkE3ckNM?=
 =?utf-8?B?SklYTTV5S2Y3UzZMSXFlbnBZNXdmZUFDRUZXNXgveE9yWEdVUnorVEJnbzZn?=
 =?utf-8?B?NVE0KzN4dkVYcFZLVndSY1RvYmxqQ2QvOVd2M3RySEladDFmTm9mRUZhWmpF?=
 =?utf-8?B?MVZ6Y2RXUTRaUDJpNnJuT1VpU3BERXcwejlrRXB1Sm8zamRDN2lSTU5QdHBi?=
 =?utf-8?B?U0RYUGFNb0VYQ0h0UDJCc3YweGZlMVlsMG9GVHp0WHpiQkVwWnliUFpHaWlx?=
 =?utf-8?B?aG14MVhVZTJPZmdqUjE2NWNOdnNJYmhqdzRxZVQ4QjVVQnZUKzk4OXBYSk1x?=
 =?utf-8?B?MzZjT1NKYWhxdEtab1IzR000cU5PRndBdHRGUkwzZGdGK1JuOUhTQ0pXWVVN?=
 =?utf-8?B?UlZudDFaR1ZFU2Z6UWJNcE1PanBHZ3IxdnZmWEFjYllxcHJyMHNKUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2a6c82-d596-4fd9-68f6-08df0cee3613
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 14:42:16.0369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vN5oldrUsU+9S2YDS4/oyhBGyMYF4GDJ+7nYn0FqwIhLGsWYNybiq/rB26PCrBvfrE1qMvkFcWzpxrDkxLuBig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041
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

--------------HOCjM8jGFone8aZkYXaQgtpF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 07-09-2026 02:23 pm, Christian König wrote:
> On 9/7/26 10:47, Yogesh Mohan Marimuthu wrote:
>> If in userq_signal_ioctl only bo_write_handles is passed and
>> num_bo_read_handles is zero then if there is contention the code is stuck
>> in drm_exec_until_all_locked()
>>
>> This happens because read bo's are handled first and then write bo's in
>> drm_exec_until_all_locked loop. When there is contention in one of the
>> write bo, exec->contended bo is set and the loop is retried, but
>> read bo is zero, still drm_exec_retry_on_contention() macro for read bo
>> is executed without drm_exec_lock_contended() getting executed.
>> drm_exec_retry_on_contention will keep going to beginning of the loop
>> causing infinite loop.
> Well that is a really good find but clear NAK to the solution.
>
> This if this causes an infinite loop there is a bug somewhere in the drm_exec object.
>
> My educated guess is that drm_exec_prepare_array() needs to call drm_exec_lock_contended() even when num_objects is zero.
drm_exec_prepare_array()  returns immediately if no of objects is 0. If 
its not 0 in that case order of calls from prepare_array is 
drm_exec_prepare_obj -> drm_exec_lock_obj -> drm_exec_lock_contended
So contention is never cleaned.

I can patch this up in drm_exec_prepare_array in case no of objects is 0 
call the drm_exec_lock_contended like below.
if(!num_objects)
returndrm_exec_lock_contended(exec);

Regards
Sunil Khatri
>
> Regards,
> Christian.
>
>> Fix this by only locking and reserving fence for bo only if there are
>> bo passed userq_signal_ioctl.
>>
>> Observed this issue when testing with MR
>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40808
>>
>> Signed-off-by: Yogesh Mohan Marimuthu<yogesh.mohanmarimuthu@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 24 +++++++++++--------
>>   1 file changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index c270635c9..135e77837 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -572,17 +572,21 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   		      (num_read_bo_handles + num_write_bo_handles));
>>   
>>   	drm_exec_until_all_locked(&exec) {
>> -		r = drm_exec_prepare_array(&exec, gobj_read,
>> -					   num_read_bo_handles, 1);
>> -		drm_exec_retry_on_contention(&exec);
>> -		if (r)
>> -			goto exec_fini;
>> +		if (num_read_bo_handles) {
>> +			r = drm_exec_prepare_array(&exec, gobj_read,
>> +						   num_read_bo_handles, 1);
>> +			drm_exec_retry_on_contention(&exec);
>> +			if (r)
>> +				goto exec_fini;
>> +		}
>>   
>> -		r = drm_exec_prepare_array(&exec, gobj_write,
>> -					   num_write_bo_handles, 1);
>> -		drm_exec_retry_on_contention(&exec);
>> -		if (r)
>> -			goto exec_fini;
>> +		if (num_write_bo_handles) {
>> +			r = drm_exec_prepare_array(&exec, gobj_write,
>> +						   num_write_bo_handles, 1);
>> +			drm_exec_retry_on_contention(&exec);
>> +			if (r)
>> +				goto exec_fini;
>> +		}
>>   	}
>>   
>>   	/* And publish the new fence in the BOs and syncobj */
--------------HOCjM8jGFone8aZkYXaQgtpF
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 07-09-2026 02:23 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:f9e8f8ff-ee5b-42d1-bc80-4ee22e4f3677@amd.com">
      <pre wrap="" class="moz-quote-pre">On 9/7/26 10:47, Yogesh Mohan Marimuthu wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">If in userq_signal_ioctl only bo_write_handles is passed and
num_bo_read_handles is zero then if there is contention the code is stuck
in drm_exec_until_all_locked()

This happens because read bo's are handled first and then write bo's in
drm_exec_until_all_locked loop. When there is contention in one of the
write bo, exec-&gt;contended bo is set and the loop is retried, but
read bo is zero, still drm_exec_retry_on_contention() macro for read bo
is executed without drm_exec_lock_contended() getting executed.
drm_exec_retry_on_contention will keep going to beginning of the loop
causing infinite loop.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Well that is a really good find but clear NAK to the solution.

This if this causes an infinite loop there is a bug somewhere in the drm_exec object.

My educated guess is that drm_exec_prepare_array() needs to call drm_exec_lock_contended() even when num_objects is zero.</pre>
    </blockquote>
    drm_exec_prepare_array()&nbsp; returns immediately if no of objects is 0.
    If its not 0 in that case order of calls from prepare_array is
    drm_exec_prepare_obj -&gt; drm_exec_lock_obj -&gt;
    drm_exec_lock_contended<br>
    So contention is never cleaned.&nbsp;<br>
    <br>
    I can patch this up in&nbsp;<span style="white-space: pre-wrap">drm_exec_prepare_array</span>&nbsp;in
    case no of objects is 0 call the drm_exec_lock_contended like below.
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #c586c0;">if</span><span style="color: #cccccc;"> (</span><span style="color: #d4d4d4;">!</span><span style="color: #9cdcfe;">num_objects</span><span style="color: #cccccc;">)</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #c586c0;">return</span><span style="color: #cccccc;"> </span><span style="color: #dcdcaa;">drm_exec_lock_contended</span><span style="color: #cccccc;">(</span><span style="color: #9cdcfe;">exec</span><span style="color: #cccccc;">);</span></div></div>
    <br>
    Regards<br>
    Sunil Khatri
    <blockquote type="cite" cite="mid:f9e8f8ff-ee5b-42d1-bc80-4ee22e4f3677@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Fix this by only locking and reserving fence for bo only if there are
bo passed userq_signal_ioctl.

Observed this issue when testing with MR
<a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40808">https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40808</a>

Signed-off-by: Yogesh Mohan Marimuthu <a class="moz-txt-link-rfc2396E" href="mailto:yogesh.mohanmarimuthu@amd.com">&lt;yogesh.mohanmarimuthu@amd.com&gt;</a>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 24 +++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index c270635c9..135e77837 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -572,17 +572,21 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		      (num_read_bo_handles + num_write_bo_handles));
 
 	drm_exec_until_all_locked(&amp;exec) {
-		r = drm_exec_prepare_array(&amp;exec, gobj_read,
-					   num_read_bo_handles, 1);
-		drm_exec_retry_on_contention(&amp;exec);
-		if (r)
-			goto exec_fini;
+		if (num_read_bo_handles) {
+			r = drm_exec_prepare_array(&amp;exec, gobj_read,
+						   num_read_bo_handles, 1);
+			drm_exec_retry_on_contention(&amp;exec);
+			if (r)
+				goto exec_fini;
+		}
 
-		r = drm_exec_prepare_array(&amp;exec, gobj_write,
-					   num_write_bo_handles, 1);
-		drm_exec_retry_on_contention(&amp;exec);
-		if (r)
-			goto exec_fini;
+		if (num_write_bo_handles) {
+			r = drm_exec_prepare_array(&amp;exec, gobj_write,
+						   num_write_bo_handles, 1);
+			drm_exec_retry_on_contention(&amp;exec);
+			if (r)
+				goto exec_fini;
+		}
 	}
 
 	/* And publish the new fence in the BOs and syncobj */
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------HOCjM8jGFone8aZkYXaQgtpF--
