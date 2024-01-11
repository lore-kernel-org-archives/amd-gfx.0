Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA355C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 06:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D3CA10E664;
	Thu, 11 Jan 2024 06:05:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7130610E664
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 06:05:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXGWuYk0iP2fqLKlhtydrjoU9he4OObwgVdYXaVso2o+4B6dCEHfUK9xNBb9sZ2PZ2QE7Lxm3wBS6aV9a3MN9MuZFrvOiIF/KMyDxyf9P6boqZCLqplx9ig2Tyl8ofT32RLKa6LDStSsWWRmz4LrdMaiIKqIdghoTYjkJgAQwZc6SncVfMvGONdSRcqz6yFvtI41UZxT59tBV8NC5IGbF1tyZ9Zm9dGMm+uGIUilQCVUozV5d11JY7qYv3pQ+xGAR3pzWF9gEBz8UDa0fi0rsX/VS+MnBnvStieOe/rx88FucqQ/11yCsEahEMigkZm65ecMJam6mRoC9uKfWmuBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DxWfWVcCRSva62CMORHgf0UpZnq92KT7CDpfrM0s0Q=;
 b=D6/Ew6Vc+rcfNUUFAS9WAnkmF9Q15+xWQV2rUUERNZCtv7dIP9dDLj6RMJ2yVk/zkLDKYem1AHYMY3ncJsZCXAYg39h7wULiebZOC+QtDi0/0y7pZtXD7BkaT/BzTavrb9P6Pg2Dmbl2ksbO4FtdLxaHSMLRkG42QpwFIhz+uSXTQhlC9PcP4mZUBdjBzdGumOsP+gski07A9hXBPP8N41oR5wqunyhK8tMQXLVjGSaplimKTQ7o4YTpd+d7Jf471v2VRQsGzkMdiPsGXMOpKPla771YS1/NWAfceCwdT2wmtblcgiLok5Fxzubbz5RKd/gRrzEsm/FUsMGGkVegyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DxWfWVcCRSva62CMORHgf0UpZnq92KT7CDpfrM0s0Q=;
 b=O/n10vZ0TkfV9CE7fy1ajMcC2sjYxRIFjCWGAHEyOJx9nOCIVEpRkHFBBS7zfEFqVkh5zI6JobnCg7GXKDcm3itFJ9PwkXxTt07AdQRIYp4D/isLo5QYui+mePjTjG1TkgqUsv0L7xBh4Yt/IOZPA5FNa8L2i2SEb7f4teBmVaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 06:05:29 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%5]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 06:05:29 +0000
Message-ID: <99264b52-4e47-4a2f-a930-a87feef3ac85@amd.com>
Date: Thu, 11 Jan 2024 14:05:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix the shift-out-of-bounds warning
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240110093938.684930-1-Jun.Ma2@amd.com>
 <7fde053e-b120-4d80-82cf-0a104ed5653f@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <7fde053e-b120-4d80-82cf-0a104ed5653f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0163.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::10) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 837eacc4-90b7-4290-213c-08dc126b501b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Grz4RWTQWXzKoCjoK24uqBkd+thxisZag8caqkZotaQLZAoUplDsrB3I3FCuStQMpzG9R4RUIUjkmYZMhblCl0iWzbR1BW/g31a9kclmeD/WE8K6eLKtQecAhdQyai/w+r6bIGi/xyaUULRekxHQlEvAbyLXwCEp8234k4uzTW17vDbeYonznb/8D3j2Z4YbmY+T7dw9xABaaxd2MqEjWbCG50yhumpXZxbUQZ8KiQjj6ZR8G5cR5cQINAOky1A5mWcbRlfwus+0CvqRjEmlSbWSXi9PUFGjyhwjRSUEorMfxp0FZ5t1EBgiP5CGGKmbQVAmE9d23uvP3F70Rk9zeFavU2T0iXRjQYkhskX+72/5t5m2A0uO20k91s0IC/VggY7TquvSWefmLbLoR/yacFXw2hYBqhCfJf+dCO64xlQ2K+Au2IysSTQhW0BFStsfdo4hDX/UcghEbuGQolAKCclH1hzGK7SkjOAAr38tMM+IjL7ALGosaN8lZgMrZAt/w8LZRJ+2QLyKFD3y1wi9mn/1PDwO79nXy6Bthhw5P3SQP+XAhoHQH9TKy8gVZmaBY7BRVBHy9X50hwSG9Vu+4h8Tn4ppQWhmENv2iSzZqWCDPh63yG6963tSetUUA1a7DImljbBxn30P3ZikXQViQ4ZGZ5rtG1JmBEFmtLcEGQrR8sp0JG/9wGq8RVWlti7F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799012)(64100799003)(451199024)(31686004)(110136005)(31696002)(36756003)(8676002)(4326008)(38100700002)(83380400001)(53546011)(2616005)(26005)(6512007)(66556008)(6506007)(6666004)(6486002)(66946007)(66476007)(316002)(478600001)(41300700001)(8936002)(5660300002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWR3VkZMMVVzcFJoS3RoeUVxWGJ4UjI1N3UwQTNHazFSNDU1elJjZmUxc2Uw?=
 =?utf-8?B?V1FlQlBMdVRhclVSZzhPYmRqZUIxQkNTTHk2STVaQVlZM1R1ZngxYmxINTZq?=
 =?utf-8?B?OTNZVTJSRTROOGZDV1V1V2xSWExLeTVERFB5K0FOb3JKUnM1NTd0YitacWRH?=
 =?utf-8?B?QllDUnYyQStWOFNrOWIwaDBUZHgvakZQNFpldElaMnpBNXU2MGVEQm5DUHVO?=
 =?utf-8?B?eTlIN01TdWkzbTFXV1hTckxHc3VSMDhrdlBmWTRYeEFsS2UrcjRvbE5IQ3dj?=
 =?utf-8?B?clc0L3lxbGxxckJPblZSUldWbWlWY0h2MnExdXlmcW5ERm5sZnNJajBrRmNz?=
 =?utf-8?B?SGpTOTJPdWJlYW9Bdllzc0IwSDNwZi9MY2Q0bWZlNnBDMGswU3dzVWNKSVNK?=
 =?utf-8?B?Nm4rNHVBMU53anQ3Z2VTODV2RGx3NkE0T2g2ZjFNSk80RDViRkgwVU5KaHNa?=
 =?utf-8?B?OUtkNFhhemhJOUJRL1R4clptZWFrU3pVdEtNSHJNNU42QWRZNkZrZ04rNmxZ?=
 =?utf-8?B?d0s5bzNVdzV4SC93R2JmVjg4MHpmYXpxWEoyeWlLclVDblNJSTE3YnNZL2R6?=
 =?utf-8?B?RGg0cm5KNHQwSlNyeG5tbFdZT3JYc1VMSzJxWW51eXhlVEV4QUhVQUJja3gz?=
 =?utf-8?B?bmJ4d3loVTkweWNVbXplS2UxZjdpSGUySU9BcFp6RGlWMHN6ZmxHU3B2RSti?=
 =?utf-8?B?TW5rMW5ZamFKSmR5Vm1hME8zMjhPa3piVUN1UXRHVVZKaTlYNHRJV1hHUkl3?=
 =?utf-8?B?YURSWGl0Ris4V0I2N3poYVB3dk52aEtZRWhQTUtiMzRQMEpYL2NDbWRyWUdW?=
 =?utf-8?B?MGxZRWlteE8ydHd0SkpYeHFXbXRuTUxLTG9VUXpnQURORnZxUmRDc1dJRFZD?=
 =?utf-8?B?ZGJTUmsyOTBQa1FHaDlNYjFBaHlXcVhremNLQVNZeGVrM2QvbHdRYnpGTEVZ?=
 =?utf-8?B?alJVTTZzV3pRYWR4M1g2L0dBZU1uYUZaVTkyZ3R3UE9VN0dXRHFyWU9UMG1h?=
 =?utf-8?B?ZEM5LzNvcCttVDNKYmNFcTZIa0NNUDY5a09ub0pKWkNnRll1NW9hVUI2SnVY?=
 =?utf-8?B?NW5ZMGdTQUVpL1VPMW4zSmFGWVNHb0hpbkVKbDJhRE00NmFhN2RXbHg3VTYw?=
 =?utf-8?B?TDFkalNENVVYYWhMeGdQYXFhL2ZlYmZ3SGloVFNyYlVIRy8rb3ljTjZqWlov?=
 =?utf-8?B?TmVPa0VYcmpDR0Ezbm84eW9OWVVaL0YzZlZ6WnA0QWdPUkNRUVkreEI0LzVE?=
 =?utf-8?B?cWZCNFlvSTRycmM3LytaZEQwaldUMS9KbWEzb2RiYXgwUjY4bmZaTGg0UEdX?=
 =?utf-8?B?OUZDL1Bxa21aa0dtSkQ2RG1jOExrNlBqdC9QbTJNR0dKWS92eU5PVjFyMlVT?=
 =?utf-8?B?WkthMGRjVjFWUjhIbmNZQnVvR0RVdmlpTmdtZmNmM2JUUEhRYkE1MnBaa1pk?=
 =?utf-8?B?WWo0V00xcm5CcnRjMyt6QXlGM1U0Vm1KbmFnM0t4OUpEdzBCNWRoZS95UjBL?=
 =?utf-8?B?T0VBQ3dGNkZIS0ZCWHFFQjN2ZjZiUGx6L3BIL2NhTkxUc09QTTdDWkgwY01n?=
 =?utf-8?B?bkVmeS9kcFpBakkxRmVRc0gyZ0tESlJKTFJMWWZGNHpBNExSd1FhWjIzd1hk?=
 =?utf-8?B?bEZXYTFnMEJ4T2lScTE5dWFYMm9mcW5SVkRlN09McFVaellNcXdldktXTUI4?=
 =?utf-8?B?dHNuOGI1V0FwT3JpeGE2eXhJaGhITHo2emZPTjE3RjlsTjNQYUJrK2lXcXBm?=
 =?utf-8?B?ckhqb1J5aisyekRGdWhuYkNVT3FldGkxWnFjWDN4cU5hVXlDUlVLYlBZTXNa?=
 =?utf-8?B?SzdyYU9PWGpJb0FDaGJFTlhlQXN3cG1hVTdFY3J0K1lGejRkM1Vwc0Q1L0tT?=
 =?utf-8?B?TXE1RmEvKzZLT2dHYzcwY05HTVFINmZiallYV2dSZ3FtakRNdHRQdWs0UUdE?=
 =?utf-8?B?UWxGSDMyTGZtRVN6NDdWNGhPZGMvZEZmUEZWaHJMOUZFbmVYS3orM2JadzAz?=
 =?utf-8?B?OXMyVC9JZXlaOGo3K05SQW9kSXIzcXR2MWFaaTZpSnBYRTVRUUZqSWhaMUZh?=
 =?utf-8?B?K2gwN3RtUEdIUG1sUWpzck0rVHBzY1kvMmpQNGRGU1VQZlQyQWI3UTdpRldM?=
 =?utf-8?Q?8jnuvZrcRMI87u04gRlmCMpFS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837eacc4-90b7-4290-213c-08dc126b501b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 06:05:29.6745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoaXn5qJHjm+OVq4aCyQF2fr8vGfdLzXHJVNkysWp6OETxIoFbo+x5FHa60nE85v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818
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

Hi Felix,

On 1/10/2024 11:57 PM, Felix Kuehling wrote:
> On 2024-01-10 04:39, Ma Jun wrote:
>> There is following shift-out-of-bounds warning if ecode=0.
>> "shift exponent 4294967295 is too large for 64-bit type 'long long unsigned int'"
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   include/uapi/linux/kfd_ioctl.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
>> index 2aa88afe305b..129325b02a91 100644
>> --- a/include/uapi/linux/kfd_ioctl.h
>> +++ b/include/uapi/linux/kfd_ioctl.h
>> @@ -1004,7 +1004,7 @@ enum kfd_dbg_trap_exception_code {
>>   };
>>   
>>   /* Mask generated by ecode in kfd_dbg_trap_exception_code */
>> -#define KFD_EC_MASK(ecode)	(1ULL << (ecode - 1))
>> +#define KFD_EC_MASK(ecode)	(BIT(ecode) - 1)
> 
> This is not the same thing. We want a bit mask with one bit set. And 
> ecode=1 should set bit 0. ecode=0 is not a valid code and doesn't have a 
> valid mask. You could use BIT((ecode) - 1), but I think that would give 
> you the same warning for ecode=0. I also don't see BIT defined anywhere 
> under include/uapi, so I think using this in the API header would break 
> the build in user mode.
> 
> Where are you seeing the warning about the bad shift exponent? Looks 
> like someone is using the KFD_EC_MASK macro incorrectly. Or if there is 
> a legitimate use of it with ecode=0, then the correct fix would be
> 
This warning is caused by following code in function event_interrupt_wq_v10()
		
else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE) {
	kfd_set_dbg_ev_from_interrupt(dev, pasid,
	KFD_DEBUG_DOORBELL_ID(context_id0),
	KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
	NULL,
	0);
}


> #define KFD_EC_MASK(ecode)	((ecode) ? 1ULL << (ecode - 1) : 0ULL)

This can fix the warning.

Regards
Ma Jun
> 
> Regards,
>    Felix
> 
> 
>>   
>>   /* Masks for exception code type checks below */
>>   #define KFD_EC_MASK_QUEUE	(KFD_EC_MASK(EC_QUEUE_WAVE_ABORT) |	\
