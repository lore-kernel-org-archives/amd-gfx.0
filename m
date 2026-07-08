Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85767C44503
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 10:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D8510E5A0;
	Wed,  8 Jul 2026 10:03:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xOOq0NZz";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24FDD10E5A0
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 10:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1VDJV4ia9ZlGQfe6n3Wm/ZoZS7m4A+9n/V1WNn+iYfCyhiJuK98N5L/mHzAIRfPSSGh9ToM+9F9y9fPOsGbJ0WOaX0LbDiMv8UctbzIUjz6HUJJfTQqVbNlKrgbGszDh8SG1wnNhlT+IQizXg4999nxSYrfuRrXRzZFEPumugrnXoIlhCwNXN4YUVAb4GA2haSRL3fhrJnqqbit7vnmnjeRhFLXrUZq9muSDrI93Z7/mbOnqGhMV3CoxDkZhVEgIUowJ/5lKKv5M0gSagHZeb0aj+YOdhpFqo/+QsoFwlTJFh/K7+vjgwToDIslJ9RxljkbZ7DOuFbvDg9tKQVl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8J57eAGhpVNUvWTCeAp3YsnwgQVeN6fq+3fy9r7U1c=;
 b=qNlb9WGcjDX+IMcFjaZY2I/+4Lbw6rSpSGMQhxE2GNYgSt7uRh6La5FqhInUaYflCZAm5eQ/qtmx8OnGsMnnWsjbGHAsxuO8Q4a83ncuonxLRyybBXGQSOzDiWaXfFgPToTg2Rutru+xQWtDzsASfVZF9cbbf7B3XuLyPScq6b7tf1yWJoXc5+pm7DOIafAAFWzvpA6zy983OXOMvmGFa/BFXvIluI46OGFubqGWudhfWyZEw41I++3LMsC2TOL584tnTor7Y7zp5Zp9XF6Y+9P950yqkXoLoAFfffB1vETzE7goKiu1TekklrmGYy1mGfLOzzpVT6luDzN3PE7KnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8J57eAGhpVNUvWTCeAp3YsnwgQVeN6fq+3fy9r7U1c=;
 b=xOOq0NZzroyglne8W1kGsKCdjOPqAzvYblNM6clkSCWamVVp7CRp6LZCThUjjgWZeYECUQXlCULK46HcHlY7wMIiR1wO2qN/BdoDMJY9d53gAt/moF8BL0oBnSQ9iMV9Ptr/+cc4UfkxsX2Ak21znEm5bJjT8cq+Czdl8m6619A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 10:03:49 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%3]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 10:03:49 +0000
Message-ID: <49ba42a4-b661-4673-95a0-c218ec1482e3@amd.com>
Date: Wed, 8 Jul 2026 15:33:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in
 sriov mode
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 Cursor <cursoragent@cursor.com>
References: <20260708083035.186400-1-chongli2@amd.com>
 <d3ffa862-8fff-40cb-8779-97d3bb4a429b@amd.com>
 <DS7PR12MB5768E74BF2292A0F8F87E0CE9BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
 <3ac3c6d5-8fad-4b0e-933d-42fa71a43657@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <3ac3c6d5-8fad-4b0e-933d-42fa71a43657@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0357.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::6) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b680c9-0a68-48fa-817b-08dedcd834c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 2pWlHc9w6kaWrAti8TcWwkYn5F7nMtzt+2tVMNyceVEK6lK7YQObIZOKHFrQLC6CeiCyo5lmX9TaGZQlH64mwvEtTB8Msn9Vq/Brhh6mSBYBi49TilMjAybjOAJJ1hT8Ztfu9EKJvOMW1QFrEx1bUQlmZLb7IQefKI9kxI6QAHij3KzSLrl+SDa4J5Ts5e+GywtpsSDHxG4RURAQuiw4LwnzjefIHNT7sZGA0ZxpCwocAYpJABlGn4KRQv/H3qGNTdpdwqHG1ZpjEnLU3f5wwmfVOonLiXA12ysqbSQBqWpKr49FwBNWHPm9f4KkrLNzcAOMiOQ0C77qYvQyaI0zGsSmZZqg9mAxTiLHC8CqciZeJsc/3eEH/R6neBSg94vggcXS9fuiwmD8q1b1KTW2LImqhn40TxEZkBnZVid5nr3oQT2Kg69xwTLj3hF4Kky5ZiLj8DhGI6Yw+YFaJYIwufWfukUyhEooDRSBBQshSqIb0kRlvsFGGdeJTXCifVF/SNdO1REi8UTAoIkum7wEh9c2Zyc2kTyqQ19s7lGuwZkTtqlgxlZZWhZubJ750ewCqJ5Moy7ZfNmUod3TqR2yu3OS0OXvQ+D5x+oU+BB6hPwnqlLqQrWvlgrsICSy8ZBkxDqdQ92MDwWiGvgqiJXB+LnOzasIXFrB4c3ueZlj+IM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UktGajAvOTVlREJvZlJaMlNPUWdCQzZDR1c0YkxxOXYwcllCVVA1N3QwejZG?=
 =?utf-8?B?d09jTFNjeXJESEQxUjMyZEZPRHptMGxoWVJBYjVtQnE5ZVY4OS8xU2Z0R3l3?=
 =?utf-8?B?WjRGYWw5akE2RENHN21OWXk5Nk5xeTV2VVBpUkpNY1ZhbVJxL2VUK0xmTFl2?=
 =?utf-8?B?c1hlRXhKR1Nhc21KcnNGSXhEQm12Z292RjVyMUdweExKV2MraHpSK1dwVUVJ?=
 =?utf-8?B?eHZZQmZwUmNqcmJUNjhocTJqdEJWSFlkbVVSVGQ4RzQ0MW9ITmRtVmVDT2t0?=
 =?utf-8?B?TURaZDdvSTY4SVRnektGd2xYV094ZVBFUExMcHRiZndNV1Q1SHV5Wkc3NzZI?=
 =?utf-8?B?NWhJY3JvY1hKKzJiUmJieGNlbGNBUnU2YjMvV0JiYUFXQlZwT0hScmFPZldX?=
 =?utf-8?B?MEhCSDYzTWxFcWdTalJKYkp1elRFeEJkdzR0cGZHendGcmY3WmZQTVNlRjBl?=
 =?utf-8?B?UWc2S0ptdUtXQnFKaVpGang1VDVLRndBYmo4YVJpS2R4amlrWS9JVDc5aTNr?=
 =?utf-8?B?MEtJZ2tlSWhGMmF6NWVCbkZpWmVrbUdMVHVlanZiWENOU0JZQ3ZJNXNOeGdP?=
 =?utf-8?B?NDNQUlRYb2I0Rk9SWTVCeUcyNWU2Q0VCSlhDZUhpVDd6UStOZE1KZW8vT0ph?=
 =?utf-8?B?QVRFUE1HUUpoUDVQSzZLQnZra1k1UnRMU2thc1kxeGVHVkJydFE2VXd5MU9w?=
 =?utf-8?B?Q0h1UnIyQW80TnN2bWdoSzljZkJ3TktISEJKZHp5WGtYUjNaRkw0RWdrbnhG?=
 =?utf-8?B?Qk9rMTVGQmh0OUlpdjN0RjA0eFdDUmlEaDBhTWhHMlBOVEZvaExWaVlnVVEv?=
 =?utf-8?B?WEZJaUNhakt2eER4cGVDek01cHlzVEEyKzRaWS9iMHIyM0NvZUFJalBYTUNL?=
 =?utf-8?B?ZkRHMzZVVFp1d3Z1ZVhabms4QlkzT2FaS3A1YXMycWt6NVhZcUgvazc0MFhE?=
 =?utf-8?B?ZGwyQ2xCWHhXSWp0K3dlM2w0RWpHdEI5MVcxSkVva3k1c0RPV2dXRHNYMTE3?=
 =?utf-8?B?ajJTOUdhMUZRN2owT1d1eG9vQ2I5QlNyYXZNSU9aMHlQd094NkljL1Z3R2dG?=
 =?utf-8?B?SFpsWVRGdGNKWk5sVFViakxZSTNIQnBKV0FIaVZzVVNMYlZDYkh3TUVyL2My?=
 =?utf-8?B?UlJzckdJMlBEdGtFZDdNMnRCRU9qMUNkVStIWXZBMjRsUEJCTHV5VS8xb3F1?=
 =?utf-8?B?TWV4R3NsT242SUFKeWRaZnYycHB2UFQ3eEdNRzhGZDlPeVBIRG9WSXlUT082?=
 =?utf-8?B?c2hjY0h5UDc3d1FUYTR5am8rTXJXSlhTc0N6S0F6OVYrdDdqS1RQeEExY25F?=
 =?utf-8?B?MkFacUZBMy9kcUtJR2w3SVR0N1dRYzljRU1uQmVnNkhFalVNMlpwb2JPZWZs?=
 =?utf-8?B?QTVYaVVpQ0hlNTdPMUxEV3EyR0V5ak00TEs5cVNEK3hPSW9XbzA3djQ4OXBP?=
 =?utf-8?B?cm9aeGF5QmZJY2d6MlJPdjhHZWZURDF3WDhqRGdHWVVZRmg1L2Jqa1NrRGho?=
 =?utf-8?B?TUZYcC9LRjJpR0lDTXBhLzVjY2RiK1U2dm9FYlBCTHcrWURZQ2NlenV0MDVz?=
 =?utf-8?B?YXQremNvRU5BaE1RQUh2VmRWUTJsK05iNEk3UURTcmhMaUZlakk5eGwremNW?=
 =?utf-8?B?ZVZUbXQ3dTNEQlZvbjJwbk9oek1OeVBOL2VoUVRyZFVSMUtrdGVjaWhmMkFk?=
 =?utf-8?B?c3RaeWErTTZLUUJVTnVobmVWZ3RqOHhEb0FSWDArbklrc1V4S3Y3cUl3QWcr?=
 =?utf-8?B?NXlYWTNWQ3J2bUQvcHlhYy9EZnhzM3NGMG1iaXhDNjhDZ3BFRFRmMkFpUVVM?=
 =?utf-8?B?cStCNTZSbGRXWWxHc1RZcmw0cG1kUUtJd1UvQzU1dCtUNTlDRVdtYy9RbGFE?=
 =?utf-8?B?amVGZW56QUhDSlcyNDFucXhwSmxxYWFIb0VuWis3di9YQUMrUHB3cEo0K1ZW?=
 =?utf-8?B?eTk2NUJKQzU2Qm1majJZS29pZEs2bFVLV2x3UVhHbHphb0Fna25mVjJnakox?=
 =?utf-8?B?MHh6VGpDR1Y3UFZzVlF0QTU0QnJuTURLR0I1QXl0cFpWYTFPc2NRdWo5cERU?=
 =?utf-8?B?NWJ4eEpTS3JsazN4OE0rUUZmbklxQzhaSlpJRkZhcTB1VWxpMDJGL1k5Y0NI?=
 =?utf-8?B?ZjNqTkc0dGVVSE5WSmNQeVBYZHlnSGZ5M0JjNlNXamk1SDNpcVBFQSt6VlJa?=
 =?utf-8?B?YU5lcDhTaFlzUGpEdDNKandBdHFnckRvZ2pGSlE3QmJnZTdQclBvRjdCdXE1?=
 =?utf-8?B?d0ltR0dLV1ZCQWxDdWc1R0ZuWHN5Y3BmL2xXanEvUEZrYTg5SjVkWkl4dWdq?=
 =?utf-8?B?aEdMME5aY3RpaWpneFYxcnFDZUR3K1Jka2kzU1ZlNVZHdW1tZ290QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b680c9-0a68-48fa-817b-08dedcd834c5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 10:03:49.4047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPC8aHxL5ahycMqZMhSmpTWxIINqhSzGuFltZunHagjvsee3o9HFWvnSxtO83wcH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
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



On 08-Jul-26 3:23 PM, Christian König wrote:
> On 7/8/26 11:35, Li, Chong(Alan) wrote:
>> AMD General
>>
>> Hi, Christian.
>>
>> This version of the patch is not host-platform dependent; all host platforms follow the same path.
>>
>> I verified this patch with KVM in my local environment and with ESXi on a borrowed server.
>>
>> Distinguishing the host platform was a mistake,
>> and I have explained the situation at the end of the patch email.
>>
>> I have pasted the content below:
>>
>>          Hi, Christian and Lijo.
>>
>>          Sorry, I made a mistake.
>>          Host access to the VF FB is not platform-dependent. After the host driver sets VF_FB_EN in response to GPU_INIT_DATA, the host can access the VF FB.
>>
>>          I borrowed an ESXi server and tested this patch there.
>>          The amdgpu driver works normally.
>>
>>          I rewrote the background. Is anything still unclear?
> 
> You still have this check here in the code: "early_full_gpu_access = (adev->virt.req_init_data_ver == 0);".
> 
> As far as I can see that is Hypervisor specific and a NO-GO.
> 

I think this should be seen as a policy set by host driver on when a 
guest operation is allowed. Host driver could do it based on other 
conditions also, not specific to hypervisor environment.

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>> Thanks,
>> Chong.
>>
>>
>>
>>
>>
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, July 8, 2026 5:05 PM
>> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Cursor <cursoragent@cursor.com>
>> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in sriov mode
>>
>> On 7/8/26 10:25, chong li wrote:
>>> v2:
>>> Some legacy ASICs do not send amdgpu_virt_request_init_data().
>>> Only keep the full GPU access request early when request_init_data is not sent.
>>>
>>> v1:
>>> Move the initialization of non-GPU resources out of the full GPU
>>> access region during AMDGPU device initialization.
>>>
>>> Background:
>>> In SR-IOV, the guest sends GPU_INIT_DATA, then the host enables
>>> VF_FB_EN and places early initialization data, such as IP discovery,
>>> VBIOS, and PF-VF exchange data, in the VF FB. The guest should then be
>>> able to read this data before requesting full GPU access.
>>>
>>> Before this patch, the VF still requested full GPU access in
>>> amdgpu_device_ip_early_init(). At that point TTM is not initialized
>>> yet, so the normal VRAM aperture mapping is unavailable and the guest
>>> falls back to MM_INDEX/MM_DATA register access. That register path
>>> requires full GPU access.
>>>
>>> Use the BAR0 framebuffer read path, amdgpu_device_read_fb_via_bar0(),
>>> for the early init-data copy instead of MM_INDEX/MM_DATA. This lets
>>> the driver delay the full GPU access request until after the early
>>> init data has been copied.
>>
>> That looks like it goes into the right direction, but as far as I can see it is still an ESXi specific change.
>>
>> So once more: We can't adjust the driver to the hypervisor!
>>
>> Either this works on all hypervisors or I have to reject the change.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: chong li <chongli2@amd.com>
>>> Co-authored-by: Cursor <cursoragent@cursor.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 +++++++++++++++++----
>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  4 ++--
>>>   2 files changed, 19 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 610d82b79de3..ac66796e8634 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -38,6 +38,10 @@
>>>   #include <linux/apple-gmux.h>
>>>   #include <linux/nospec.h>
>>>
>>> +#ifdef CONFIG_X86
>>> +#include <asm/hypervisor.h>
>>> +#endif
>>> +
>>>   #include <drm/drm_atomic_helper.h>
>>>   #include <drm/drm_client_event.h>
>>>   #include <drm/drm_crtc_helper.h>
>>> @@ -1987,16 +1991,19 @@ static int amdgpu_device_ip_early_init(struct
>>> amdgpu_device *adev)  {
>>>        struct amdgpu_ip_block *ip_block;
>>>        struct pci_dev *parent;
>>> -     bool total, skip_bios;
>>> +     bool total, skip_bios, early_full_gpu_access = false;
>>>        uint32_t bios_flags;
>>>        int i, r;
>>>
>>>        amdgpu_device_enable_virtual_display(adev);
>>>
>>>        if (amdgpu_sriov_vf(adev)) {
>>> -             r = amdgpu_virt_request_full_gpu(adev, true);
>>> -             if (r)
>>> -                     return r;
>>> +             early_full_gpu_access = (adev->virt.req_init_data_ver == 0);
>>> +             if (early_full_gpu_access) {
>>> +                     r = amdgpu_virt_request_full_gpu(adev, true);
>>> +                     if (r)
>>> +                             return r;
>>> +             }
>>>
>>>                r = amdgpu_virt_init_critical_region(adev);
>>>                if (r)
>>> @@ -2159,6 +2166,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>        if (!total)
>>>                return -ENODEV;
>>>
>>> +     if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>>> +             r = amdgpu_virt_request_full_gpu(adev, true);
>>> +             if (r)
>>> +                     return r;
>>> +     }
>>> +
>>>        if (adev->gmc.xgmi.supported)
>>>                amdgpu_xgmi_early_init(adev);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>> index 9a40107a0869..340703d89d6b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>> @@ -185,8 +185,8 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
>>>        } else if (req == IDH_REQ_GPU_INIT_DATA){
>>>                /* Dummy REQ_GPU_INIT_DATA handling */
>>>                r = xgpu_ai_poll_msg(adev, IDH_REQ_GPU_INIT_DATA_READY);
>>> -             /* version set to 0 since dummy */
>>> -             adev->virt.req_init_data_ver = 0;
>>> +             /* Version is set to 1 since GPU_CRIT_REGION_V1 */
>>> +             adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
>>>        }
>>>
>>>        return 0;
>>
> 

