Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D339606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=d/+kCPbU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0CBF10FB92;
	Wed, 25 Nov 2026 14:50:15 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E89610FCA9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 14:50:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czr/bBtFno4mjSZk9KT+1eyiqS48XFCf+H+gYi4Hg/x2eTp+vqnjmWtx2VhQ4L3jBOf1eFEdOCZLwlMpTFsafucV+VAXu7reE3m/3SisIyXGKgVZv/R4eXueYQALZ2cgWzT43oO08WQBdG2XFeESCHPAEshtduIBMU13Nz/MQhyKcc0ODcsJcSa3LYB2/7DvmCfBS2sLB4v4PjrKnRw73tNBjZwBUyTkW7jHj/BpbBtLIZUpWuPzdgmx6Y4hBB4p+F1k6OUX3nGtLkMfize0YCnelWO2z1W0WA/22zxuA5TDAYPuUyeJZ6rsi0GHMWGUXlMebUuojElFOAhhbEyvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AY2qA+2Yy6yowUL61vIPJQFj6PWplIooLU2QC6oreTQ=;
 b=wktcTVWjpoL6dBSQyvm6HA9LLJCTOhMM/V2rU8TDBi8TfpA202dazqBhfn2PmxQNGrqFA2VrCWItXoLpwuGm3BVexOub83xpSHLqUz2MqyZAaCzxD75vaYsXc2G/oJjKTCgUNn+gy7432vMgOcdO+JQlNs7Z/zPHtbFVEChhhjJpV+YVTFZiUHvDYK2vevMVExFzeICtEeebkKW9pOlufD9M5uPyyCwCUiCABp+LXRDT0xZ6yLwCkqpBSviWj3+5V+sFPE9hEvaBGcsW2Mpdi4sXapgRMyQTlPGznbDuazQZy6gNPH5s+zC6yG/AkEN1n66Ji5ZCpWlQwxSQgkjnZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AY2qA+2Yy6yowUL61vIPJQFj6PWplIooLU2QC6oreTQ=;
 b=d/+kCPbUXzlxe1YanEKzeRVU4Z4LqNzowgKiX6eYMsgvLl19LydmKG4B2Kad+SQjhb8Dm7M/g6OOMmoM9IH3Al62fu1BYuqCPWZTOLXjCedIYNNyXtnyj3cF6XupYq1v7DWsylOVCZ5L/NfIsosI0CVU6JRN6tLGTefiMl/fQYo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99a) by DS4PR12MB9609.namprd12.prod.outlook.com
 (2603:10b6:8:278::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Wed, 25 Nov
 2026 14:50:06 +0000
Received: from SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
 ([fe80::a63:c537:f76a:675b]) by SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
 ([fe80::a63:c537:f76a:675b%4]) with mapi id 15.21.0615.007; Wed, 25 Nov 2026
 14:50:05 +0000
Message-ID: <a66396f3-1f40-468f-8760-2813734342bd@amd.com>
Date: Wed, 25 Nov 2026 09:50:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/amdgpu: get rid of amdgpu_drm_ioctl
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com
References: <20260911154212.591213-1-shahyan.soltani@amd.com>
 <20260911154212.591213-8-shahyan.soltani@amd.com>
 <CADnq5_MwSF626Ji96+3Gkerr8A_OsXAW1BmFh5tciEmo7xLGdg@mail.gmail.com>
Content-Language: en-US
From: Shahyan Soltani <shahyan.soltani@amd.com>
In-Reply-To: <CADnq5_MwSF626Ji96+3Gkerr8A_OsXAW1BmFh5tciEmo7xLGdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::10) To SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99a)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF7B9E98CB6:EE_|DS4PR12MB9609:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c884a4e-b7a5-43a3-5928-08df4b036492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261021123027099003|261102123227099003|261028144727099003|10067099003|261021121427099003|11063799006|56012099006|261022113327099003|4143699003|261009223027099003|261022075727099003|261021135927099003|261022115727099003|261026121527099003|261026140227099003|261022105027099003|261009221227099003|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 5zevdogoJnSroHIUXKs/5+grJ7bE3CWUgBZSb11bXT35AqFue1i9Um3hrBr+Za11uh536J6luoFWTt5n7812LbHhZbAcSKok6YwFFtU6qI381h1yFgCf2EfHRTUCUHB7Lbn+g8vn4IrnwIhQqnm4nBaGJgQ1teueO2ebU/54PYeXV6Q2MW+/T4kPtGv7XcZkVTcRiOzGwwtp8y84GyuisdscJdBih3QuxbCn2yl17/d23ZptL4Gs9YHQhEMbEsFGYutXxIbFsvQZ9r3zuvdblsnuJhP3DhiMLUQoEpQamOHpFxI8kNdU9gXpQApCVBzoZq82qOlZzm15XBOnqOrvoyzxsHWP/hWvCTE21I26n6mjPGScVX4D8mHcIZzYHz914UorP7CCx+4gufpcESjpkrVqwWOzOs784W8PA9+WDx20cgQgGLNP6w9+K4vTT/nTSdAIDq6q0WJCTtg7PhWAZKLgzV+aE0M0pmUMHCNGgYXiCE4G481VkKtGUDDl0QV5i+iU84xQmYqX9F3YpeugOCvUIHYh0x8glo+Ry+hT/LpAJUDqNX7EUI7cMIxcpsaL3YaBIMys0U5e0pEY//kD+H/yz7CPWgnrS4fWCHdqRUuIzqY6jNYXsiKjAw15v0JhoFBnaMBoZccRXSgOZhj2yPqOAE/ifTVwqRXqQT9hyaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPF7B9E98CB6.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261021123027099003)(261102123227099003)(261028144727099003)(10067099003)(261021121427099003)(11063799006)(56012099006)(261022113327099003)(4143699003)(261009223027099003)(261022075727099003)(261021135927099003)(261022115727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261009221227099003)(6133799003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU4wRlRyNWtuSDhHK1R4OWM2d3dtR1B2akd2U1ZyMXRvMjNRdEVScXJRaFhZ?=
 =?utf-8?B?K1lsZWlNUm5wSXp1TmdTaDA2REREWkVYVDVkdUd0TFlvSyszeXNMT1BGdGsy?=
 =?utf-8?B?ZExsaUVPUzE2VFFSM0pFLzJEZ3EreG5Ub3o4MmF0d29jempuWkVjL3FyU20w?=
 =?utf-8?B?OG5VbjkrSnJKUlZ4VUlERHNjYy96WElxKzV0bUdKa29hZkFEM0lJYk1semxZ?=
 =?utf-8?B?M3lQQ3hjRlpSR3dnOEkxTjBlU3FDK1BuQnN2Mk9PMThhY21RSEEwaTBJZWly?=
 =?utf-8?B?VC9SRTdNelJYVDE3QlVMMVN3MkJRbTVJWEVMbml4OWpTOWladWFUT1pNejN0?=
 =?utf-8?B?WHgxaEtyY0R2b0kybENPZ0ZCQkJqU2ZMa2w2UVE1cDRZT1IxVXJKZ2RyUWtj?=
 =?utf-8?B?SklJUUdMNjMwQzA1VXJFZXUrVGJwRWNaekRwckV4cU5WTWJLRjF5TnhSMEtV?=
 =?utf-8?B?bUFUQzNtMy9rUlRYUFlnQnpMdGRnZGtCNm80N3g1UVg3dGlCQ2JGNzdFYVky?=
 =?utf-8?B?NFh1OEE5bnNSY2NYZXBFVitqOUROaUFyaVg1NzZSeHhObzZ2U3NqTWdCM245?=
 =?utf-8?B?Y2Y3djlMRXVuSlFxSHpWMVdvNGpRQmlvSlAvczZONElUYTBXYmk1bG1CS3Vi?=
 =?utf-8?B?Sndyd2duRFFvUW4rWVF4d3p3WElNdXRnRittQnVpOFNhbnoweGc1ZzNNS2x2?=
 =?utf-8?B?WDc4dHVyYnhFd3JmQm9TUmw5S0ppVm1rM1lENDZjTWxUTHdMWCs3Q2hGYm5F?=
 =?utf-8?B?OTNZSVRIK3RtUk1LM0YvbFl2eWxDa1ZXNmt3VDcxUldxUFZEMTl0aEZNdnlJ?=
 =?utf-8?B?eFp2R3RsbGY0bGwrWTRJV01wOUdkUzJ5VXVtYWNJQWxaUkZJdC9Od0VXZ2Nq?=
 =?utf-8?B?OTN6MTI5RzFqR0Z5ZzJIMURNcUZmeXhhbGhYbFlyTkNRNGpybTFHZEtCYmIy?=
 =?utf-8?B?Nlh1cEZ5c3Q1VjdvKzljcmUzaG04QVdlV2F2aXZ0OXU0amdRajQ3S0JKNXJY?=
 =?utf-8?B?bmRuTlFtN2tuSUxjL1RWWkM1K1VtQzJha2FzWWpUSnJQQ1p4NldPeHlGdldp?=
 =?utf-8?B?QkpubnVGQ3ltQWJObjd6Y3pCWlg4MU43cVZjV28rTlhDcERyNlllL1hxTzZX?=
 =?utf-8?B?U2tJdnBmNmJXNUVSdVl0OGxiNFNFcGFCeTlnZ3NPemNpNi9MU3pHNUJiQVE3?=
 =?utf-8?B?eWdDMExUY0NYMkZ6amhCQ0w0TDViRDJURnphUHZGYUNsVmhSdEU2QVpQcm1Q?=
 =?utf-8?B?TGgrckhEbVJMWC82dFg0MHd6Z2tPUVI4SkpMTE1CME5GV2NhL3d4UENFM3pY?=
 =?utf-8?B?NWszeVZHeFQxOWhybmRJWlA1bmdlaTBkT3dlREpOR3V4MmQ3NnZqNWlpMzVl?=
 =?utf-8?B?VTdZQTJlYnVMTFJLcVR1Z0tHbzcySXNhN2x0c24wQ0s3cEhjMXVHc3hXdUhk?=
 =?utf-8?B?RG5va0xCRmE4V05EdmlRcFFxU1VUb1U5RjBaeXhMNjQ3L0hpNHExUVU0dnRu?=
 =?utf-8?B?d2hJZ3FNQlZBcWVVRTNOQlpXWEZEd0RTMGwzU1VsdDFucWpiTHVDdkxrRzh0?=
 =?utf-8?B?UXltVlAxb1hHYkNQQ3Y2TWw2NXVURUozUDN2blJhT29oWURKem9UaWxUaEp1?=
 =?utf-8?B?NlY2Tm5Gb3R4QU03RS9ncU1xZTBNYVJIMS9WQ1R6K1IyTU5LY2g1a2g1WDNu?=
 =?utf-8?B?V0FPUk9WUE9tVDdUeEJVbG9PdFM0MkpYclBtdzBiQWdtU1U0V1RwS08xZWJM?=
 =?utf-8?B?cWExbnRXSXVxQnNwN1ZtSjJSakJObmRnVHhLUmk4VVpCNWRTaXhaeW9WWGpR?=
 =?utf-8?B?YTljM2J5aGdFSnJvK3lROEd1U2xqNWNjdXh6cXJTSmZ3aGlVYzd5TlhsWCto?=
 =?utf-8?B?eGthSHRpMWpDR0NSVDkwMnBUbkJSZXMyWVF2QW5JKzMwR0tLdFY4U2RPdlpQ?=
 =?utf-8?B?NVJUUmU4VTNiWkVCSnJvYzJ0ZTcxNnFVam1EeEZZZkFuUm9DRDhhMzBVQXlR?=
 =?utf-8?B?VkdRaENaSFdybHJud2tSN1MyZ2F5b3FOU3hENlhlcEZ5MGFEMnY4YTFGeDJI?=
 =?utf-8?B?UDRROHdvMVEyeDBlKy9XYy96bm4vcFhNTEVUYVlhZ2wzVlhoc2VmSjJZbVlw?=
 =?utf-8?B?THIwcUwrQ3Qwczd3N0U2QlAwNTBLOUNWREw3RTQ5bFFaNnk2ZDlhNllBYXUy?=
 =?utf-8?B?bkFlK0VJcGdDYUw1Q0RhTSsyYktxU0RBUmJSekFucTNIaC9yZ09wRDMrbU9F?=
 =?utf-8?B?MUI3MjB5cmxBVk5Cd0pIVjJpZmNwTllwMEZFVVh1S2syWjd4T3JuSllKSjN3?=
 =?utf-8?B?d09WeWQvbDQzUFZnSDM3RVJZcndUaUo0OENxQ1ZUb0Q1eEhNMDJ5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c884a4e-b7a5-43a3-5928-08df4b036492
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 14:50:05.7325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5ZDjKN5D1j2G/cXk/rJmT3se37Y61YHTa/zU3U088fQ1kMKrTZchsSolq6NbAcW5pg+HrhoiT5gjtWBPPuzPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9609
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 5:21 PM, Alex Deucher wrote:
> On Fri, Sep 11, 2026 at 12:01 PM Shahyan Soltani
> <shahyan.soltani@amd.com> wrote:
>>
>> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>
>> Remove the entire amdgpu_drm_ioctl handler system in favor of drm_ioctl.
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> [shahyan.soltani@amd.com: Added commit description]
>> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile       |  1 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 23 +-----------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h   |  6 ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c | 45 -----------------------
>>   4 files changed, 2 insertions(+), 73 deletions(-)
>>   delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 7b08814a24da..d5ddf236a6f9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -321,7 +321,6 @@ include $(FULL_AMD_PATH)/acp/Makefile
>>   amdgpu-y += $(AMD_ACP_FILES)
>>   endif
>>
>> -amdgpu-$(CONFIG_COMPAT) += amdgpu_ioc32.o
>>   amdgpu-$(CONFIG_VGA_SWITCHEROO) += amdgpu_atpx_handler.o
>>   amdgpu-$(CONFIG_ACPI) += amdgpu_acpi.o
>>   amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 9c5e93cd3ee6..f51f03ae5241 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -3019,25 +3019,6 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>>          return drm_release(inode, filp);
>>   }
>>
>> -long amdgpu_drm_ioctl(struct file *filp,
>> -                     unsigned int cmd, unsigned long arg)
>> -{
>> -       struct drm_file *file_priv = filp->private_data;
>> -       struct drm_device *dev;
>> -       long ret;
>> -
>> -       dev = file_priv->minor->dev;
>> -       ret = pm_runtime_get_sync(dev->dev);
>> -       if (ret < 0)
>> -               goto out;
>> -
>> -       ret = drm_ioctl(filp, cmd, arg);
>> -
>> -out:
>> -       pm_runtime_put_autosuspend(dev->dev);
>> -       return ret;
>> -}
> 
> Thinking about this a bit more, what happens when KMS IOCTLs get
> called (e.g., modeset, display detect, etc.)?  Will they properly
> power up the GPU?  I suspect you will either need to properly add ref
> counting to the KMS entry points in the display code, or you need to
> resurrect this specifically for the KMS IOCTLs.
> 
> Alex
>

Hi Alex, thanks for your input. I've looked into it and from what I've 
seen you brought up a really good point, but I'm not entirely sure how 
to proceed.

The problem is if I try runtime resuming the GPU on the KMS entry points 
for the IOCTLs, it interferes with other processes that call that same 
entry point without an ioctl path, typically with their own pre-existing 
rpm handling. For instance, A lot of the MODE SET ioctls such as 
DRM_IOCTL_MODE_SETGAMMA, rely solely on the .atomic_commit hook to 
communicate with the amdgpu_dm driver. A wrapper here within the 
atomic_commit hook (.atomic_commit = amdgpu_wrapper_resume_example) to 
resume the GPU would be a possible implementation method from what I can 
tell. However, within a different non-ioctl pathway, more specifically 
the suspend/resume IP block one, dm_suspend/dm_resume also calls the 
.atomic_commit hook which triggers a deadlock as the new wrapper tries 
resuming the GPU while it is already suspending within the same process.

On the other hand I could resuscitate the amdgpu_drm_ioctl driver like 
you mentioned but from what I can tell a list of "kms_ioctls" would have 
to be maintained and updated whenever a change is brought up. Which 
probably isn't the best idea in the long run.

In anycase if you have any input on the matter it would be very much 
appreciated.

Thanks,
Shahyan

>> -
>>   static const struct dev_pm_ops amdgpu_pm_ops = {
>>          .prepare = pm_sleep_ptr(amdgpu_pmops_prepare),
>>          .complete = pm_sleep_ptr(amdgpu_pmops_complete),
>> @@ -3070,12 +3051,12 @@ static const struct file_operations amdgpu_driver_kms_fops = {
>>          .open = drm_open,
>>          .flush = amdgpu_flush,
>>          .release = amdgpu_drm_release,
>> -       .unlocked_ioctl = amdgpu_drm_ioctl,
>> +       .unlocked_ioctl = drm_ioctl,
>>          .mmap = drm_gem_mmap,
>>          .poll = drm_poll,
>>          .read = drm_read,
>>   #ifdef CONFIG_COMPAT
>> -       .compat_ioctl = amdgpu_kms_compat_ioctl,
>> +       .compat_ioctl = drm_compat_ioctl,
>>   #endif
>>   #ifdef CONFIG_PROC_FS
>>          .show_fdinfo = drm_show_fdinfo,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
>> index 2d86cc6f7f4d..6b06c0956e48 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
>> @@ -43,10 +43,4 @@
>>
>>   extern const struct drm_driver amdgpu_partition_driver;
>>
>> -long amdgpu_drm_ioctl(struct file *filp,
>> -                     unsigned int cmd, unsigned long arg);
>> -
>> -long amdgpu_kms_compat_ioctl(struct file *filp,
>> -                            unsigned int cmd, unsigned long arg);
>> -
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
>> deleted file mode 100644
>> index a1cbd7c3deb2..000000000000
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
>> +++ /dev/null
>> @@ -1,45 +0,0 @@
>> -/*
>> - * \file amdgpu_ioc32.c
>> - *
>> - * 32-bit ioctl compatibility routines for the AMDGPU DRM.
>> - *
>> - * \author Paul Mackerras <paulus@samba.org>
>> - *
>> - * Copyright (C) Paul Mackerras 2005
>> - * All Rights Reserved.
>> - *
>> - * Permission is hereby granted, free of charge, to any person obtaining a
>> - * copy of this software and associated documentation files (the "Software"),
>> - * to deal in the Software without restriction, including without limitation
>> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> - * and/or sell copies of the Software, and to permit persons to whom the
>> - * Software is furnished to do so, subject to the following conditions:
>> - *
>> - * The above copyright notice and this permission notice (including the next
>> - * paragraph) shall be included in all copies or substantial portions of the
>> - * Software.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> - * THE AUTHOR BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> - * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
>> - * IN THE SOFTWARE.
>> - */
>> -#include <linux/compat.h>
>> -
>> -#include <drm/amdgpu_drm.h>
>> -#include <drm/drm_ioctl.h>
>> -
>> -#include "amdgpu_drv.h"
>> -
>> -long amdgpu_kms_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>> -{
>> -       unsigned int nr = DRM_IOCTL_NR(cmd);
>> -
>> -       if (nr < DRM_COMMAND_BASE)
>> -               return drm_compat_ioctl(filp, cmd, arg);
>> -
>> -       return amdgpu_drm_ioctl(filp, cmd, arg);
>> -}
>> --
>> 2.55.0
>>

