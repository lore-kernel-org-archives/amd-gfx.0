Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764C1C48BF6
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 11:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E43F210E460;
	Thu, 29 Feb 2024 11:10:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qw3Wdrdv";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0005810E460
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 11:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5kPCKC83B8ylIaHaqYWtjozv5e1TdjwLqHh2TkZJgmDmAGVovhaR9Ux1zHU7aeC6kTWMwGgRc9nUGwFWBSz7TzYrVjSey0Y2Dn7p4xlWTCAJwhu4UHWiwCbPNfKxmGYF6ft7GZq9LA0KvyRC2FEO+crxILCujp23EKAOkrpZ9rguaRyN688DsY/yMNuqoTaOpp9P1n/T5NsSlkgqh8Mdia4mw3heYMuz0CrEf4TN0K4RkluiCXRPOE2gwrLkII9PQJMXQmOKwzq1mNu0UEypQYnlDZUJiexrnfCFkDS1IvAIbvVTt3WPL4v52rwjzqOHMMd+famm27GjRQoGAsifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFWKbxXSffqcqW5lrZwNxsFGAI+B+MHrbOh2QJTtk8w=;
 b=Y1ja2VtM/TOR0Bg4zbFN5dueiI9Bq6Xtg901vZWwCnqzuIZZiPqS+S9cQgC63V9hhKgQG9J4Q4kNtTGAvkcp+nZULhgcHeD1OsnML6BzOWN7+cc/rvpjooCXRwSNxt5RGHZL/2b/L9bsymtGMgRWMI6FMK5kNTdM38m1IBq+EWx9Rw+vDKF/5/N55iYyacLTVgWe9UgxfiPZGJeEUNCYrwFeLZDqMR5h8ddOPBUkp49vMGmF7UH+3v5uOfsyXPT8N+eb9TaNZtXv+4ZSrjalOWBZLqI45oEIWu+5YXwYVsHiX6KbrInXxvSnE1zwjuLupqQlQ22xWkDcErTGK77G1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFWKbxXSffqcqW5lrZwNxsFGAI+B+MHrbOh2QJTtk8w=;
 b=qw3WdrdvgGt/LY2f1gaw5lYHSPDTNdFm+JLKXzBCZPzIgB7ExqHYTuLg7XieXzaP1d3K2pATESctm6Pjq1+NAILWx1jvDuCDSm7qO/fmW/IbxSD/c6eYn3LRC6Ld6bLjSb9vU7FrdlvGD+0FeMfLAzXZosyTSOsrAJizq8u81iw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13)
 by MN6PR12MB8592.namprd12.prod.outlook.com (2603:10b6:208:478::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 11:10:08 +0000
Received: from IA1PR12MB6332.namprd12.prod.outlook.com
 ([fe80::22fc:4326:d657:92ad]) by IA1PR12MB6332.namprd12.prod.outlook.com
 ([fe80::22fc:4326:d657:92ad%7]) with mapi id 15.20.7316.012; Thu, 29 Feb 2024
 11:10:07 +0000
Message-ID: <c2115fec-385a-4a8e-b056-ec062b1f60aa@amd.com>
Date: Thu, 29 Feb 2024 19:10:01 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com
Subject: Re: [PATCH v2] drm/amgpu: Check return value of
 amdgpu_device_baco_enter/exit
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 Alexander.Deucher@amd.com
References: <20240229061941.1970301-1-Jun.Ma2@amd.com>
 <383ebb6c-b50f-4fa8-9555-e9b77c5a9778@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <383ebb6c-b50f-4fa8-9555-e9b77c5a9778@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0181.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::19) To IA1PR12MB6332.namprd12.prod.outlook.com
 (2603:10b6:208:3e2::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6332:EE_|MN6PR12MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cadbdb7-ccac-4bbc-23ab-08dc3916fcf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: swwddIo6pY+KC44JJ4VVdiDLiADtEKHPPY7vQGsce6Nrt2o1/xeqj4Fk0IcY6+OzA4dcWEstpWBeaRGEHi+P6YsTynKu/HFOfNNOmsHBr3M5Ir5bQoFQORVMLw+O71t1wSQEPjZt1pZrO6NfsR4AoDPRsDpbAppEFD2kVXO71NmLAkmSDyzQXAgtqm0JvYYV5Zw3Bxm2tb8xJCflOeHYIHyZQjSp1G8RgHmPPUNKjBImeBFmzAWfZA9H/a3rm8bFdsyRxD+IO+Tj0W0mp3t7G62p8LycLQqcgrUNb9gnjtxJZAhko/6t3MhzuAgCHtJ8+3cjDHtkx4nzB1nFugbUHuLcxe7J/AWLG4O6l+ZrfQ/Btd+0QPW3AuNNczvKEd3ys0UeMUt9MSB0TbuYLcKnpLvBkLhYBwiRzPqRel3hb7olfNlPL/wnrZQEHKjr8OXx02PZOUrLB+G3jG6UJi36trSQCFP05kVt8Pt5gLOoq80bJqkXHx8CWQG2E4+kBIsVQPi+1THVFFVGYVFRLQCytw2LIJgDSE2aVnACyIH7e6WK6N/nw0XdWV6Lytnqb4mZwQbHvpzDEim4h9SNEF3G9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6332.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0RLWXRBWjVpY0VlaFV1S0paeGVrbTA2V216ODE1VFJGNXN3OGRNU1lEY1Fu?=
 =?utf-8?B?c0pTRmJGYkU0eFJhUWNLaXlTcS9LNWc0emh6OTRuMENSNUQyRHBSTUxsMXdU?=
 =?utf-8?B?cXdJTVlXMHhjeXQrci9qUFIwRk5IdEFSY1I5YWpGem1iYmFkRkU0d2x3VjNn?=
 =?utf-8?B?YnZVT1JZemlxa21oMXp6eGF0eDlvKzBraDE4ZGdOQ2tBVHNUaFV6cUtKQmk2?=
 =?utf-8?B?SDB2eUt4UVBiSWpoMDA5dTZ2SGlRc1pweE9XQnFOeW9hTEc3N3dJSTYwcm9l?=
 =?utf-8?B?cTBQR0VNNGtqUUZsMlh4NXd5TFVjZm5TcWhwNDliYlRtYmdHSExFdXlTeXJo?=
 =?utf-8?B?eTdVVWl3c01IUlhQbFJaVHBEN0NEd2R6R1FPVk9PdkNwTytNRGJiV3p1bWVY?=
 =?utf-8?B?ODNMMnNzT2dFam9oZEc3Wm8wSFFwbElOejk0WERrT1A3VEZvU0h6ZUlRS05p?=
 =?utf-8?B?YXZ3YlM0S2hWRjZKRzdoVEkwRGVJY0lpbm92UjMrZHZzVW9QZ0tsaVFwZDBE?=
 =?utf-8?B?Y29HaXpISlRsQ21rRHNuU1J6QmJialhiSzdWamtHSWViVktJb0YydUlVclNS?=
 =?utf-8?B?QXR2YXphVXlUei9qZHljNHp3bjdTeStjdmV4NTdBQzV4dDdRZ1FUcjBEVTBw?=
 =?utf-8?B?dHJSQ2l6UmROYzVFMDRJS0lVdnVZSkRRb1l0U1d0MWlST2JGZUs2Tk9hSU1w?=
 =?utf-8?B?aERjeTIrbTJhNGcrMTl1TlJ5SGFoM0haNzgyMk9lY0hOdEdRajNHQXRiSFhF?=
 =?utf-8?B?RTFQWXBTY1BNdHIxZWFnOFpDc0x3VDRWY3l0OWJrbWtDR1k5Nk0vS1FySFhu?=
 =?utf-8?B?YTZnN1AvOXc3U09kSjVGRy9Rd0g1ZU5LbGp2UW12TW1TeUh6Q2pTT3VVVklj?=
 =?utf-8?B?V0t4OExHb3N6aTFxN2crOUZQbyt6T0dFNmRXQXU0d3pzR0JrYlhncTllamZW?=
 =?utf-8?B?MXlBNjVZMW1xcFUxNUo0dFk3djZLcW1xODJTZy9UUzdmNXJTcUc0VTE2RElQ?=
 =?utf-8?B?UDNYM2JQSlhVb2dDYnNQcXNDWm9LaTFxdjdoajhBaVhwakFxUGx1VVc4Q2dX?=
 =?utf-8?B?V1RFUWNrR1ZrNy9ZLzAzV0tBYWJYSVROZnJ3Nm1IczFyVTcxM0dHS2ZpZDA2?=
 =?utf-8?B?OFRSWTZUNW5CSHBrNkVvUVdKUUdlWGtpelNnUkZtdU0ralJYYmE4L0l2UEZ6?=
 =?utf-8?B?K1FwaHZkVmNlNHlwQzliMnZBR1JZd1FJK2RZNkFycDhHZ2ZYamRhVU9aZ3hw?=
 =?utf-8?B?K090MmZGbnphM0ozcUFEcVVtemhxa2pMSFlwU2R6SjA3Q2pqejVBdi9mcW5r?=
 =?utf-8?B?Y0lURlpuRVhzVDNOV0U1c1FUUy9hMkNyM2lzWVc2L3dpaCtQbmthVm1sSmt1?=
 =?utf-8?B?ZlliUHZCV25jQkluSUJlMFJxdkxYSnJveEtWckM0WHpNcWFQVVN2cGF0VVFW?=
 =?utf-8?B?ZGFqSVZETkFldy84YUpCbzZ6bDIxcnVFWVlqUDBJMHVBYWlVMjQrTExqU21o?=
 =?utf-8?B?c0kwOUlyNGFrcGszUGJ0YldKZG0zZVV2REoyeHNPVGJRU0FDSU0vNlY0aTRi?=
 =?utf-8?B?R3p5QkVRMzZTKzJsM3pFRDcwTGZyRm1JZFNkM2tQREpDSWdzK3MzL1ovSjVt?=
 =?utf-8?B?QmhOaUZ5MzdUOW40dFhTSzZKcXMwNnRjeUtvWkp5QWQrNHdBbjNUSHpKTCtK?=
 =?utf-8?B?OGVSNUlqTko5NUJZalBldllCaGNoOGNQbXREQnhHSHphUFdscTRNUXpkLzFZ?=
 =?utf-8?B?cmwvbUFlYURzNi9sNTZjQ0trWis5WUU5R0w5c2hZcUdVTDlQUXh1YU1VbW5z?=
 =?utf-8?B?NVB3bGJDOHUxV04vVWZYRXlNbzBxQ0t0a3B3bllxeEJFd1Q3c3ZhR0NiTmpu?=
 =?utf-8?B?T0dIT0M1dlk0Wk9qL2I5MjZQZ0wxcXBPOFFoOXo5KzB6OGxudjUwcDhTb1dL?=
 =?utf-8?B?SXp4RE9RSDVjRnN5L09CRDF2Zm9pWmFGVXdtNnBnSEgvdXBvWC9XN05TL3lE?=
 =?utf-8?B?azUvQ1hiMEF1R1V3RXE5QWp1cG13eUxickI2Q1FBcEUwUUhoTVVxbGh3TzJ0?=
 =?utf-8?B?clY5RGVEL2lZNVVtdGNGYXhQa0FwZVJJc2daTllDTU9HL0dTa1JRSHpWSng1?=
 =?utf-8?Q?08PtZdjfPo7gDTVOWhvmuhiat?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cadbdb7-ccac-4bbc-23ab-08dc3916fcf9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6332.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 11:10:07.8445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4n2xY6v26RqUcUpwx8SQW6EYPzcoyNyr93myQaewBgZ5nkLiNqIr/7cbG7heBYH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8592
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

Hi Lijo,

On 2/29/2024 3:33 PM, Lazar, Lijo wrote:
> 
> 
> On 2/29/2024 11:49 AM, Ma Jun wrote:
>> Check return value of amdgpu_device_baco_enter/exit and print
>> warning message because these errors may cause runtime resume failure
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29 ++++++++++++++++------
>>  1 file changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index e68bd6f8a6a4..4928b588cd12 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -6000,15 +6000,24 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
>>  {
>>  	struct amdgpu_device *adev = drm_to_adev(dev);
>>  	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>> +	int ret = 0;
>>  
>> -	if (!amdgpu_device_supports_baco(dev))
>> -		return -ENOTSUPP;
>> +	if (!amdgpu_device_supports_baco(dev)) {
>> +		ret = -ENOTSUPP;
>> +		goto baco_error;
>> +	}
>>  
>>  	if (ras && adev->ras_enabled &&
>>  	    adev->nbio.funcs->enable_doorbell_interrupt)
>>  		adev->nbio.funcs->enable_doorbell_interrupt(adev, false);
>>  
>> -	return amdgpu_dpm_baco_enter(adev);
>> +	ret = amdgpu_dpm_baco_enter(adev);
>> +
>> +baco_error:
>> +	if (ret)
>> +		dev_warn(adev->dev, "warning: device fails to enter baco. ret=%d\n", ret);
>> +
> 
> This doesn't look like a real case, moreover the warning message is

In fact this is a case that actually happened.

When amdgpu_device_supports_baco returns with error because of some reasons,
device will enter runtime suspend without calling the  amdgpu_device_baco_enter()
and without any warning message being printed. Then, device is usually fails
to resume.
So, I add this message as a warning to help us find the real reason.

> misleading. If the device doesn't support baco, driver is not supposed
> to call it for runpm purpose -
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c#L2664
> 
I changed this code in another patch.
https://lists.freedesktop.org/archives/amd-gfx/2024-February/104929.html

Regards,
Ma Jun

> Thanks,
> Lijo
> 
>> +	return ret;
>>  }
>>  
>>  int amdgpu_device_baco_exit(struct drm_device *dev)
>> @@ -6017,12 +6026,14 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>>  	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>>  	int ret = 0;
>>  
>> -	if (!amdgpu_device_supports_baco(dev))
>> -		return -ENOTSUPP;
>> +	if (!amdgpu_device_supports_baco(dev)) {
>> +		ret = -ENOTSUPP;
>> +		goto baco_error;
>> +	}
>>  
>>  	ret = amdgpu_dpm_baco_exit(adev);
>>  	if (ret)
>> -		return ret;
>> +		goto baco_error;
>>  
>>  	if (ras && adev->ras_enabled &&
>>  	    adev->nbio.funcs->enable_doorbell_interrupt)
>> @@ -6032,7 +6043,11 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>>  	    adev->nbio.funcs->clear_doorbell_interrupt)
>>  		adev->nbio.funcs->clear_doorbell_interrupt(adev);
>>  
>> -	return 0;
>> +baco_error:
>> +	if (ret)
>> +		dev_warn(adev->dev, "warning: device fails to exit from baco. ret=%d\n", ret);
>> +
>> +	return ret;
>>  }
>>  
>>  /**
