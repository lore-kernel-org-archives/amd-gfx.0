Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793AF10854DB
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 09:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055CF10E781;
	Wed, 18 Mar 2026 09:39:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mr4gCREv";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010057.outbound.protection.outlook.com
 [52.101.193.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6143910E781
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 09:39:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADwHmx8y9rl2AbEF1UEmXZDGK/0ido1HyGlKM3pO7FNg4ZEQgNyQN3m9LqugfrP8e6XLaGGosgRI/01OVpc/4LAX69u4jxepsGjoEWzGUle7wuzOpzNe7nzZcGiTUlAJmNw0pECyK/sLN1Esm/cOs/QR/rZVKfc/oV2+7QvqU/uQQt30TvtRLPURh49qskOXZvKQjg0lxZj5FAXkYmj5Cxia4xZkHR6E18+eY4/x5dVs4l6jQuObD+4oVDOZ6ckD9GvYDxI8DS/YxM3djoTWdYWYVcOG2YAUtb3XcTH7rfQNGxR+dsN1ImPC32D1VDqfCjkuoaJUPYdhV8BS4erPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZhXuze5s7fPSA0o804kkDw4OUo84t5a4hxNGfiCURw=;
 b=QwfD47ncBz6vD9Mach99+VyaRoQZShjehsY1xBsUByYXARi+6U515ZWRCpeqG/OzrBEUdn0zPnhA/OJwg3iqGFYGZ8f0o1b0jFW9+Zv+GfrriLzAPY2b6CvtNm/XRVErzyC4wGa9vDVE5IXebMYGDS8fHA8C9roXW0PlZsxHN6lYN4cv+4i5OgqOabSNKjAb2Ycd0o9O9BYgOz3+DyttclJs/EZHFojX0NfRwAqpSI9f22CFJppXeKxxvskfC7e4PYZyd5mGdYKPdlRK1UVjhED2MiqCJJYouaJEK6kD5ZVFW8wqpT3WyGrBkLcSyebAjSJdsHdwXisB/ONI/g5NfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZhXuze5s7fPSA0o804kkDw4OUo84t5a4hxNGfiCURw=;
 b=mr4gCREvbsAbmIusE8hapzV/EeObfutFcujfYi5JyIFyix/4i48wf9oLI3r8IW/GT0p+wMuqp6W5THUdk7bR88AK2EAiON9Akna5HV+hzzRBlEQE8RtiJOloxXIUrBI74xT9XmHkVkSVRYI3tqeTsLyaQdwL3zNTdSMtvzEzfCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 09:39:18 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 09:39:18 +0000
Message-ID: <2e6d0e34-e093-41a9-a4b3-59afe3050dfc@amd.com>
Date: Wed, 18 Mar 2026 15:09:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation"
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260318074708.2078535-1-sunil.khatri@amd.com>
 <dfca1bb0-26dd-45bd-ac11-c3756ce808ac@amd.com>
 <48df3b31-724a-4548-a52b-9f034664d422@amd.com>
 <DM4PR12MB5152791EDD4F7021198821E3E34EA@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <DM4PR12MB5152791EDD4F7021198821E3E34EA@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0254.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::20) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 85292ed3-0cfe-4675-ea79-08de84d2398c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: MxMqKa3a6Nf1f0IgBsiDMRFxjh+9IlN45GZc+O7x5lq02YzEQ45GlLaqebJh0q6yiPZydWq1Eo/G6tsxXgr9Kmaj8RXI8G+b6g0QOlSOTp07GHrt0kUjSoGp+jlzR7/nzK8ARvvv3im931keGoT741YHdo6VfNJ9hm+b426H7nBHMoozB2khqTLW8+UexbqDxSsT/e76BUxafBC0sYzYyahj3aZpCw3gXSMt4UsOHyATFXKzhbo5ATXH+RwiNv5G8aohg4Tvrn6+3NDQCQGA3blhsoz5QX7+hFLPWp0DthSrfjcV5NNwXpgZaeKr3QbahgGPGkMM8G5sFjpZqEOF0rNxim58VuzHrYPIZsrgGqSEY4guHYkmfvkTNzOZGbw+ozYwcsPuj9MSnhOLxLJinyqxPsJVzxljnzocNW5cOhdE3V+ZNIK39ilkeReTL7iOuj7Ortx8JDpntGOXFRuswiD2aAleIe7/1ELQBo6ihfI6LkfXi4CQzT4zEAWlPCfYvDKByZxuGbJGoj+lNMOl0v+cKS+uUPsRRjd7utKbYDaMG1duwySBpERwvfqb0fk46Ejqx2AIbVD1aTpZoqy0OJUJMKrSXehGJGZp+6wbdjPCj7taun3Y5JD7XPbgkZ4W6VHNmWZ2c36Z5ubvJXBo0/6VPLgCqH2vYc+dH7BX7IuvgVFfVJ+zre+7mlB3oIQW8hYkNR5Qi1ROX73XzhDFvqndS79ctKvghMWTr8LcVdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm5iM29rdEZuV2FlWXJFRVlyMHBjSlhUYjYza1lwWXZpUGtsZHVOSE9HRWJF?=
 =?utf-8?B?dDJ3RzR4NTI0ZmlZc0p6VW02Tllrakt6VFBNc0ZwZVh1dGRjN2RwY0Z1MHBB?=
 =?utf-8?B?VGJHVmNNOFdBMHcrVVl5WUJOTHJ2ZjV2T2UwWWNlUEMwU1gvSlRSV3daekRC?=
 =?utf-8?B?YXYyV1QwNktGcTZNRzJXNWQ5Mnl2U0hyUGhKSUdib2IyaG0zaWZabEM2ckxi?=
 =?utf-8?B?THFOdjRvS3pJQUdSbVF4anhUTm56dVhBeCs5N2lTcjNNekRZbExOY0tSdEtt?=
 =?utf-8?B?TFVSNTRKOTNXb2orQUg3LzBlazE3VWswTTVNVTY3RTY1NXlReE9ZTi85RVBL?=
 =?utf-8?B?N2djREJOc2txUU56KzRIcDdYQTdUU1lQRHNqTW1oSk1WMVdnWHdLVnRSQm5E?=
 =?utf-8?B?dWhXTzAwZFpqRm8rS013Rzk4cVZwYjkyZVE2VHdWZkVpdWtRNm1yZVI2NDF4?=
 =?utf-8?B?L09iR1RsSWYvL1MzYTVRd1BrczdLdU0xTERSbGdFWmltS3BjRHo2alpmK210?=
 =?utf-8?B?QnBTQVcvVHh0bE5FRVV3T25QSEROSXFsWDdQd2UxaURweTRwNGlNQlFxZ1NJ?=
 =?utf-8?B?bll6TGw1cE5KVWdUUkQzcTJuRzYvVk5RL0ZGN2NpK3NqR2ROS21MdlRJSVUv?=
 =?utf-8?B?MWkzejl2YnUwYndVT3ZkMWxSZWNPUkV3K0d4R3VmWEtpTWRYbU9uWUR2eWtQ?=
 =?utf-8?B?NmR4QWRoSGZ3NlZNR3I5Qll2cVovVkszcStLd0FQaG04c2VCS1lUc3lMd0VZ?=
 =?utf-8?B?QnRXa2xtdDJKVytUQkt0bU5ZSUdMbVFPdElXZ1duN1FTbXRXbkZuVUs5czh5?=
 =?utf-8?B?SVRnZTRoYXpnOEJ3V1ZhbGNqMjloN0JUS0s4YSsxTVhja2FyelRWY3A3c3J5?=
 =?utf-8?B?b1l0aE9weWtlWGhlUnJjZURUbHpnenpFcnJ0V2V1a3ZOSG1RajlpTWdLWHF5?=
 =?utf-8?B?UFZsNTgxSnVueEM1a0Mrb0pzeWtuYkpKUm1tZERuUDZhaUo1WmZPeE9VYzRx?=
 =?utf-8?B?NkdIZG4xQkdCNjBtR1ZhUXg4bXVqbERPNTNkeVlVajdEYXI0VzF4d09KYXRK?=
 =?utf-8?B?SjBaejBxK1hPRDNOZjlkQ01TTm55WDdZaGVjSGFiY2F1Y1duaUFVQmoxTXkr?=
 =?utf-8?B?VUd1eWVrb1lJOTRxUTYraHIxY3VhT3oraE5IcUFWQXA2MDJxNmdiZDRDS3h3?=
 =?utf-8?B?U094Y0VDb2lCeTZiMkFQbXpBNDZKbStUWms0dHJyanB5Vytwc1FCRE5sZlNq?=
 =?utf-8?B?TU9jL01uWjlHWHk0UWc5UXlCOStwQUxvdjFITGE1bGgrMkh1cDEzZXRXMjhi?=
 =?utf-8?B?UkFJWEtqaUg5ckJJVUxBTXNzdVVFTkM2Qzc1Wi9zRjZEU3BVRlJkaXZjUHo5?=
 =?utf-8?B?K0FIQ3hwNW83ZE1icngyWm1kbVR3UWROV3Y2ZmI1YUNXVjZIMlhJRHZOY1U1?=
 =?utf-8?B?cnhSZkVoNnJES1p6TnBPQ0JybU9MVVpQSnlxbEVlZWhiV0NMUnFLZFFnQ1Uz?=
 =?utf-8?B?L1lJVDJJSFNoSXhJUHJ4OHpKVndzUkFmM2pKaldwWDBJM3lxWW1wMWE1TE9K?=
 =?utf-8?B?bmpibTQxU3o2UXlBR2YxaUtsMjM1cWdlZGpQRVdvRUhFeWNFb3hVS2hPUGcx?=
 =?utf-8?B?dXhEdVF1K0wxQXJqdVY1T2wvN1R5MEp3eU5IZXN3OXd5czRheW54L28yekpH?=
 =?utf-8?B?MG1RZ3paU2N5V05NQ1hsQWFPclUwVDlBYUZRQ1VaNGRyRTc1Z01scVB4a2dY?=
 =?utf-8?B?TlcrQjc0VTVXRnJmQzFuV1BiTVliazUrMXdtYnF6MHJlSHJkNTBPb2ZKUUxG?=
 =?utf-8?B?WGxpM1VOTU5idVVONlN3bEU1a1hBSGZrVXBpYTJERVpydEJjVzJ3blAzV0FN?=
 =?utf-8?B?Z2JXbUg2T2czZk9zR25ScUMyQmxRK1N3dzh3RkZiRjU1a3ZRSGRyR1dhdkV0?=
 =?utf-8?B?ci96UHF5S1haOXVIRVN1Nnp1MnM1OHBSY3dKMmxDNXl6SXFRaTJqMlZuNWZ1?=
 =?utf-8?B?VW5OdXFhOVhhVHFhZ2VIS0tPVjZwZE1xNW8yOEE4eTFVWldQYjVvaXRaWmdP?=
 =?utf-8?B?Um5IK2Y3eUhxZnJQSGVKN0RpK2NmMC9YUyttT2N5allmTlhhV2RNZTlDNnMr?=
 =?utf-8?B?c3lsNzZUS1Z2N0M1MWJrQjdVYmFkcHFsc3pnR1c2WUYvWXgvZlZwU1pNdmJo?=
 =?utf-8?B?T2k5SUo4cWd0eURFZXVJRndlRGFIUk96YWhBZHEwR2NjY21idzUrd2pudm1S?=
 =?utf-8?B?RTdmeHY5aDdFZHFuRTAxamxPc2NZTEJLcmU0U1MyYlBXcTVVdUd0OEUzNFJL?=
 =?utf-8?B?c00rUlVDU1JFbWZjTUNUNFJ2d1dIMDFsaUlvNDBrcUZPUDdGczRRdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85292ed3-0cfe-4675-ea79-08de84d2398c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 09:39:18.0557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hB/vD5uTZs/xHxWS7G0NCClR2CMcfsgEKdo4CwkR4I6CmiE+LJcvDLJDIkSb14rGUA6V+M85ZYtY7ag5wkq9WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322
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


On 18-03-2026 03:02 pm, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Khatri, Sunil <Sunil.Khatri@amd.com>
>> Sent: Wednesday, March 18, 2026 4:22 PM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Khatri, Sunil
>> <Sunil.Khatri@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
>> Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument
>> validation"
>>
>>
>> On 18-03-2026 01:29 pm, Christian König wrote:
>>> On 3/18/26 08:47, Sunil Khatri wrote:
>>>> This reverts commit 0cdff8eb31c139dde4716e4aa37198c16364629e.
>>>>
>>>> The patch has caused regression for userqueues where user is stuck
>>>> and is waiting for fences and a gpu reset is triggered in kernel.
>>>> Also for any of the parameters when count is zero, the driver does
>>>> not read from the pointer and having that check is overkill.
>>>>
>>>> Application:
>>>> MESA: error: amdgpu: getting wait num_fences failed
>>>> MESA: error: amdgpu: getting wait fences failed
>>>> MESA: error: amdgpu: getting wait num_fences failed
>>>> MESA: error: amdgpu: getting wait fences failed
> After I reverted this patch, the error still occurs when running glxgears.
> Does it work fine on your end if you don't apply this patch?
>
> amdgpu: getting wait fences failed
> amdgpu: getting wait fences failed
> amdgpu: getting wait fences failed

Yes, it works. You might need to update mesa too. I am using the latest 
mesa with ubuntu and i dont see those error. with your patch they do show.

Regards
Sunil Khatri
>
> Thanks
> Jesse
>
>
>>>> Dmesg:
>>>> [  122.668493] amdgpu 0000:0a:00.0: sq_intr: error, detail
>>>> 0x00000000, type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0 [
>>>> 122.668504] amdgpu 0000:0a:00.0: sq_intr: error, detail 0x00000000,
>>>> type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0 [  124.687518]
>>>> amdgpu 0000:0a:00.0: Dumping IP State [  124.688351] amdgpu
>>>> 0000:0a:00.0: Dumping IP State Completed [  124.688355] amdgpu
>>>> 0000:0a:00.0: [drm] AMDGPU device coredump file has been created [
>>>> 124.688357] amdgpu 0000:0a:00.0: [drm] Check your
>>>> /sys/class/drm/card0/device/devcoredump/data
>>>> [  124.688361] amdgpu 0000:0a:00.0: ring gfx_0.0.0 timeout, signaled
>>>> seq=569, emitted seq=571 [  124.688366] amdgpu 0000:0a:00.0:  Process
>>>> Xwayland pid 3471 thread Xwayland:cs0 pid 3479 [  124.688369] amdgpu
>>>> 0000:0a:00.0: Starting gfx_0.0.0 ring reset [  126.560451] amdgpu
>>>> 0000:0a:00.0: MES(0) failed to respond to msg=RESET [  126.560456]
>>>> amdgpu 0000:0a:00.0: failed to detect and reset [  126.560460] amdgpu
>>>> 0000:0a:00.0: Failed to detect and reset queues, err (-110) [
>>>> 128.789840] amdgpu 0000:0a:00.0: Ring gfx_0.0.0 reset failed [
>>>> 128.789848] amdgpu 0000:0a:00.0: GPU reset begin!. Source:  1 [
>>>> 128.790161] amdgpu 0000:0a:00.0: Guilty job already signaled, skipping HW
>> reset [  128.790174] amdgpu 0000:0a:00.0: GPU reset(1) succeeded!
>>>> [  128.804538] amdgpu 0000:0a:00.0: [drm] device wedged, but
>>>> recovered through reset [  128.804574] amdgpu 0000:0a:00.0: GPU reset
>>>> begin!. Source:  6 [  128.816663] amdgpu 0000:0a:00.0: Dumping IP
>>>> State [  128.817458] amdgpu 0000:0a:00.0: Dumping IP State Completed
>>>> [  130.963939] amdgpu 0000:0a:00.0: MES(1) failed to respond to
>>>> msg=REMOVE_QUEUE [  130.963949] amdgpu 0000:0a:00.0: failed to unmap
>>>> legacy queue
>>>>
>>>> Cc: Jesse Zhang <jesse.zhang@amd.com>
>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>> ---
>>>>    .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 29 -------------------
>>>>    1 file changed, 29 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> index 3fcd70a38374..0d9a13081f2f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> @@ -484,16 +484,6 @@ int amdgpu_userq_signal_ioctl(struct drm_device
>> *dev, void *data,
>>>>         args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>>>>             return -EINVAL;
>>>>
>>>> -  /* Reject non-NULL pointers paired with a zero count. */
>>>> -  if (!args->num_syncobj_handles && args->syncobj_handles)
>>>> -          return -EINVAL;
>>>> -
>>>> -  if (!args->num_bo_read_handles && args->bo_read_handles)
>>>> -          return -EINVAL;
>>>> -
>>>> -  if (!args->num_bo_write_handles && args->bo_write_handles)
>>>> -          return -EINVAL;
>>>> -
>>>>     num_syncobj_handles = args->num_syncobj_handles;
>>>>     syncobj_handles = memdup_array_user(u64_to_user_ptr(args-
>>> syncobj_handles),
>>>>                                         num_syncobj_handles, sizeof(u32)); @@ -
>> 950,25 +940,6 @@
>>>> int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>>         wait_info->num_bo_read_handles >
>> AMDGPU_USERQ_MAX_HANDLES)
>>>>             return -EINVAL;
>>>>
>>>> -  /* Reject non-NULL pointers paired with a zero count: the pointer
>>>> -   * is meaningless and indicates inconsistent input from userspace.
>>>> -   */
>>>> -  if (!wait_info->num_syncobj_handles && wait_info->syncobj_handles)
>>>> -          return -EINVAL;
>>>> -
>>>> -  if (!wait_info->num_syncobj_timeline_handles &&
>>>> -      (wait_info->syncobj_timeline_handles || wait_info-
>>> syncobj_timeline_points))
>>>> -          return -EINVAL;
>>>> -
>>>> -  if (!wait_info->num_bo_read_handles && wait_info->bo_read_handles)
>>>> -          return -EINVAL;
>>>> -
>>>> -  if (!wait_info->num_bo_write_handles && wait_info->bo_write_handles)
>>>> -          return -EINVAL;
>>>> -
>>>> -  if (!wait_info->num_fences && wait_info->out_fences)
>>>> -          return -EINVAL;
>>>> -
>>> Mhm, in general such checks look valid to me.
>>>
>>> My educated guess is that userspace sets num_fences = 0 to query if it needs to
>> resize the pointer out_fences or not.
>>> If you have time please double check which check fails here.
>> Sure, i will check on that but for now i have pushed this revert.
>>
>> regards
>>
>> sunil khatri
>>
>>> Apart from that Reviewed-by: Christian König <christian.koenig@amd.com>.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>     num_syncobj = wait_info->num_syncobj_handles;
>>>>     ptr = u64_to_user_ptr(wait_info->syncobj_handles);
>>>>     syncobj_handles = memdup_array_user(ptr, num_syncobj,
>>>> sizeof(u32));
