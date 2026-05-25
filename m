Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE7ECD5BC9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 14:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D2F10E12E;
	Mon, 25 May 2026 14:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1SwYMB4A";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE36D10E12E
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 14:40:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Spk66xhhToa+Vlvn4kgjVdL5HGnIJaSNC9G9UKkhFJaQPoIhmZUvQ/i/g90MUowhObeDhfG6GFD0gbWZWRe/iP5tPtdjVMii2WdgK25aAyCx+U87Leag0jfJMAESbGIyGC0DjZMTIjXXygeE+KjwctzD3MAB6c/qZhShTNtOgLc5zA3aR4wtMCwgTsT9ciFC+mDJiAxxqotBaEFZ56uFZEx8x36i5J4Wv6rla5nWEBcXr103mmc7QU4p+dONyJjlxHMigGNrPZl0tupb8R8ntYQykn/ZDW//hGoHVBcjTOXnA/Db4Mvir0M/z/7LyDqbP/J3wXoJQS5MQYMWEbpNXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQfqXvmTwUVXg5bIPToMuuaM0a8D8U6PNsKgA3aVyjk=;
 b=nCAa/jqX5JJhuYfgri6EVEOHJ8K5Z9GMD/WTJ7cziGyyTVM5xk3jvizRKboTwUSc5qVXbxeDEk6bho6gWpfGuNt6ldt/Z9Kq0ln6H+Z/Ltab9amGlYgQ0eoyhZNAdY7+TE73oZ0pe6dUn3vthxtwoxUdZ/Yh7BQ2RjSNjSVOc5jPBaRucawV/ZwAwPG1GLDXSa/Sa9P4kzyWud93dUYXh7t9G2Sbb/LQWOpbUIdVVBvRL3k/alV2MOdLBZKCXFLFDb5d4a+YlLCF9oIqfc4IFUFUJM+1nWBaWLby0S/xSMYAkyee1Zn32amzU0f2VEvgIy7OjeuSUEVmgKeRbrmptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQfqXvmTwUVXg5bIPToMuuaM0a8D8U6PNsKgA3aVyjk=;
 b=1SwYMB4A3nK1x6bCX+GuNBDm41nqPkgkmdF7ydFW9epGHNkvUaXFQZhQlLGXCGDaZT00QhaSap/LytPH9mc3oAUAZHumfcQj2A9Fi2JWQgp6a+MNdLwmCmL8E0OpO9uaSAm9B9Szebt+aPbkcPr+2Q0F29frtNfr7kru1ACzP8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH1PR12MB9575.namprd12.prod.outlook.com (2603:10b6:610:2ad::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 14:40:27 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 14:40:26 +0000
Message-ID: <7ad55269-0017-46eb-9b42-b139d87863b8@amd.com>
Date: Mon, 25 May 2026 20:10:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: add ioctl to handle RAS poison error
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Yat Sin, David" <David.YatSin@amd.com>
References: <20260521090445.2292040-1-yifan1.zhang@amd.com>
 <IA1PR12MB6356564293C123C66AF6EB6CC10D2@IA1PR12MB6356.namprd12.prod.outlook.com>
 <BL1PR12MB5898EE3BD319F4BBF204ABE9850A2@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BL1PR12MB5898EE3BD319F4BBF204ABE9850A2@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0097.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH1PR12MB9575:EE_
X-MS-Office365-Filtering-Correlation-Id: ac061b7d-203d-46ca-c697-08deba6b8f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|4143699003|18002099003|22082099003|56012099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: DmOsLiZ9TqC30JvgoVUexHzbV+GvaugMGwQ95FsucTQfp1Rvb3VrINnTVS3hQ53SW4DDiCXo6JCSK6zJyYc3W5s6Xo+9HPgOfUWj+h/D1ETYfQaYRegzEomr4rnlp3JRdmIYD54pJoi3n0iJ6Ppgw46dcapdsoWTBPE42llAJSJaUxqRPMD6/gjqTZLZa6G7qAzFQDq2k9yCe+gYhBTwy2wQsF0uOWhdfUoUespmEfNltMvCNDjJv700CPIxbui7ulYy533Ri+r0csvW+90cssqj9/88+K9SPYHSwqpTPGpG4f8BKmcHFcaKHBXJfxn6c4RFWgWB5i4iB6MYCXNYnPCbdhTUKwh7ljx1EnisMOVm5dyhEWTzdbKGQs+euJMEQTBRZyUDYaGAjb10wV16NVKkzZUIT7SJVxq4p7HW/iFUPQRkSm+bDzz1IvaISTVXjY9T3zWfRyHE8kK1mWFt/jfsqfaWSIU1yOLvwagF5Vx2qe5X0P9mJt1aa3tqRRC+7esqfPf89xdkG2LS8J/TxYn/yly6dRlR4FF0L75qmGt5UjUBt6fnhhnVehKznqriosPKvY+S2VS50C/nDuH0DXr4U+ecxBHCDiX9okHtO1oJfgFBR0ZLPTvpA2wuAFgAi0WYkfMt7326+sdu7OtxIAj35RrfsADJlTpRp11GM/7swrPZGd+NuhGO/yJyAgJq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(4143699003)(18002099003)(22082099003)(56012099003)(3023799007)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE8xSG5hNVh4RXR3OTRkdjdHdGlzSC9YM0ZDS0tWYkhLTFhxTG05dnNiMjRP?=
 =?utf-8?B?ek41MGlYUkxQcjExWFhjMmFQQzI0NkxINzFyNFYzNk1jaXkvMXZmVXBkNGVV?=
 =?utf-8?B?dlIrcG8va1JoenNwZmVHV3Z0aU0xVXp5K3V1ZTJJMFROTURrT3NkVXhlRUQ4?=
 =?utf-8?B?c0tnbFZia1Vzd2VDQWJJU1hxL21BZW5OdDVkaDRJK1JuU3VyUDRXQlcybGNr?=
 =?utf-8?B?enpueUxKbWwrblc5MXRpT1c5TXd3YnNNSXZBZ3k2QXRsQ1V6WVExQkcvQTVT?=
 =?utf-8?B?L29Ra0JKMTI0WE1nOWozZzFSY3liRHRvUGFPdXpSWGluQ1NCcGhZQnZoeC9W?=
 =?utf-8?B?NlZqOXVFU1VkbkJXOCs0a0c3dFZHUE1zTWVVN0YxSUdzN21zd1FRWE5qdE83?=
 =?utf-8?B?emUvSm40clpPNElRckU1aVdKYnQ1QTRERVFVd1hWZHpoMUphSEdtQS9CRjVX?=
 =?utf-8?B?V25rL2FIRWhCdmc2OGkwT2xrRlVOVnlSbXMyUE4xUjZWZGErZjJPQVlRanY1?=
 =?utf-8?B?YmVrWmFESUV2aXBCVysvMjI0cGtqMDIveUhJM3BPSkxPZndZT0N3L01LeWhy?=
 =?utf-8?B?c2paeENoUmtnd2RYT2U2RmYvWjZkdzV4MTJPV21xQVR4Q3FCZStEbUYyVnRy?=
 =?utf-8?B?Rk5QU3UyZW1rTmN6eVdqQjBrMkEyamhZdTJ6a3pDMGgyNm5QMHpMWmg5MDBI?=
 =?utf-8?B?V2MrT1loVktINXFQQmRCM0lienhvZWhsRFVocDBkWFQ0Tjh2aVljSEJ3eTFD?=
 =?utf-8?B?QlkwY3M3L3pQN3N3ZE9MTFFOYklnb2Y1UlhRMkd6V0dtOGl4U1ducEVIOWZp?=
 =?utf-8?B?YWdyUU40WTVDcFRpb1hPZWZaenJaTEVrZ0tGV2JqWHJoWXBlelQ5TkttN2Fj?=
 =?utf-8?B?TW5qcy8xZWt1YW5UTmlUMnI2dmhyZlFwNWp1bUNucU1tUVJ6bDAvaUlQREhG?=
 =?utf-8?B?eHhrWnR0VVdLQ0lPT0VzcnAvbm43aldJdkFYOUwwTnFLMFZEbVlSY3pjbnJL?=
 =?utf-8?B?TUhDV0pMeDNqWGRVbThuWVlZTUJCaTFWR3VpMDVvaWgzUTFvRzMwZGo1L3hC?=
 =?utf-8?B?V2FiNkJCU3ViOW5mREFSSDIvcGN2aTcyMFB4SHI5cmhqWXV1TjZkdVZkc08r?=
 =?utf-8?B?V09ub0Z0bERpc2FKK2wrWE40VlNhYmdCSWVTU1FPbUxkY2xTQzYwTjlkUmwy?=
 =?utf-8?B?eFg1K0hBSURHeS9MblRBWGhGNXNLOFFMK1B0WHBaYTJJemhXTFlsT1ZQVDJr?=
 =?utf-8?B?SDRnWVlyMGFjUmc2R0VvMTVSNERrNkZGbUlOT05jdXUwNXBlUnEwZ0ZrcDhw?=
 =?utf-8?B?TzAwYThVME1WN0c0K0tpOExmQm04bk9VbnVoemlaREo5Q3dxTXVEdC9VRno4?=
 =?utf-8?B?aXRoRG1LL3ZIRk51ako5RVNkdHFWWkNaT1BuUnFXek5INmZSWmgxbTAzMTVX?=
 =?utf-8?B?MElkYUgzZFNDeFpTa3BtWkdmZk5zMWRZWFdhMzJBczV2VURKV3dvMUF3c0FB?=
 =?utf-8?B?OUFXMDJ6MkE2UklzYitrUmUzZXdLN2NoMXhMVUNMNnM0TnBxZUZqcnRkczBF?=
 =?utf-8?B?a3M2emFySTlaTFR4OTJMZmp1RDlmSjZ1QWordHF3dm8wOVZZSXRzY1RtYkNP?=
 =?utf-8?B?MVJwMjVpR2VmWVZnZUFkdENtVGV4azhrM2EveHorYzJuMC9qWGZMWEhzNDQ0?=
 =?utf-8?B?TEpuY3NYcGt2L0VoQzBKSGZsbkJ0UXFDVHoxRWpUc3RCT1V3NU9mcEQwU2lN?=
 =?utf-8?B?TDZKWmFFTjY3Ky9nZzhuR3BrbThWS0JSTTBsaHlQN2VmVnk0d214NjZDYTQv?=
 =?utf-8?B?LzVXS2JvdEttNzVmY29mRVNzczU3RXZjeVNqNlJpbWx5bXNKakEyMlMzanVC?=
 =?utf-8?B?N2h3NDFYNml3RHZDYVFtS1M0M3J4ejZML3ptTGdmbnlKUUdVUERSanJ1eXZK?=
 =?utf-8?B?V3lucFE4bThnbG9WekpXdnFkbnNVQmZuZWpNcGJETXE3bE0xczhtK2VXajdD?=
 =?utf-8?B?aTYvMmtDT0hDa3ozU282RTZkT3JUYi9JK3REZlBHcDUraFBySHdRaHREV3hP?=
 =?utf-8?B?QyszQk1nRGM4bk1aMFZyOUFVdWNueDZPT3Nzb2s5Tk1TZ1BuTmV1QVlkZjZs?=
 =?utf-8?B?cU5KMFFlWWw1T3RaNEhiQkdBd1V5eEIrcWpTTG8rY25BK2xXdlAweGpINFk3?=
 =?utf-8?B?WHVzSzRhN0dEYzZGa2dFeWFleGlKSjVtVTNUbzVocDN0akZZbFBIMEh6Q3F5?=
 =?utf-8?B?NUZTMHVXeGdZZCtwWTU4eEdEc2xvMmV2OVJqVVE2WjRCWUk3eEVnRzZpeEFi?=
 =?utf-8?B?djlyNVV5Wm9oaVhzd1NWaHYwOHN6MWh6eFdMTWZCeTJpVHFYczJaQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac061b7d-203d-46ca-c697-08deba6b8f5f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 14:40:26.6844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHb2N4xx0xe5uWpppftpblkedI0fUQk0qRsuEpXClaFYhDa38cpbQ4u+3wH+v2Ow
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9575
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



On 25-May-26 7:53 PM, Russell, Kent wrote:
> AMD General
> 
> Seems fine to me. Will wait for Lijo and David to chime in on their v2/v3 change requests before I give a Reviewed-By
> 
>   Kent
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang,
>> Yifan
>> Sent: May 24, 2026 7:18 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Lazar,
>> Lijo <Lijo.Lazar@amd.com>
>> Subject: RE: [PATCH v4] drm/amdgpu: add ioctl to handle RAS poison error
>>
>> AMD General
>>
>> ping
>>
>> -----Original Message-----
>> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
>> Sent: Thursday, May 21, 2026 5:05 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Lazar,
>> Lijo <Lijo.Lazar@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
>> Subject: [PATCH v4] drm/amdgpu: add ioctl to handle RAS poison error
>>
>> Add a new DRM_IOCTL_AMDGPU_USER_OPTIONS ioctl with the
>> AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY option, allowing userspace
>> (ROCr) to control per-process SIGBUS delivery.
>>
>> Userspace for this can be found at:
>> https://github.com/ROCm/rocm-systems/pull/6190
>>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  6 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 27 +++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_events.c    | 70 +++++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      | 14 +++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 23 +++++++
>>   include/uapi/drm/amdgpu_drm.h              | 21 +++++++
>>   8 files changed, 163 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 5d7bfa59424a..771ec0608270 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1467,6 +1467,8 @@ int amdgpu_enable_vblank_kms(struct drm_crtc
>> *crtc);  void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);  int
>> amdgpu_info_ioctl(struct drm_device *dev, void *data,
>>                        struct drm_file *filp);
>> +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
>> +                             struct drm_file *filp);
>>
>>   /*
>>    * functions used by amdgpu_encoder.c
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 5333e052d56d..68d83a6e6b3a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -210,6 +210,7 @@ int amdgpu_amdkfd_evict_userptr(struct
>> mmu_interval_notifier *mni,  int amdgpu_amdkfd_bo_validate_and_fence(struct
>> amdgpu_bo *bo,
>>                                          uint32_t domain,
>>                                          struct dma_fence *fence);
>> +int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms);
>>   #else
>>   static inline
>>   bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
>> @@ -241,6 +242,11 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct
>> amdgpu_bo *bo,  {
>>          return 0;
>>   }
>> +static inline
>> +int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms) {
>> +       return -EOPNOTSUPP;
>> +}
>>   #endif
>>   /* Shared API */
>>   int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 1781c0c3d010..4d4d21babc61 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -3076,6 +3076,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>>          DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL,
>> amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>          DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl,
>> DRM_AUTH|DRM_RENDER_ALLOW),
>>          DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES,
>> amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>> +       DRM_IOCTL_DEF_DRV(AMDGPU_USER_OPTIONS,
>> amdgpu_user_options_ioctl,
>> +DRM_AUTH|DRM_RENDER_ALLOW),
>>   };
>>
>>   static const struct drm_driver amdgpu_kms_driver = { diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 24526e92f9b8..772e0fda7e14 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1423,6 +1423,33 @@ int amdgpu_info_ioctl(struct drm_device *dev, void
>> *data, struct drm_file *filp)
>>          return 0;
>>   }
>>
>> +/**
>> + * amdgpu_user_options_ioctl - set per-fd user options
>> + *
>> + * @dev: drm dev pointer
>> + * @data: pointer to struct drm_amdgpu_user_options
>> + * @filp: drm file
>> + *
>> + * Sets options stored on the per-file amdgpu_fpriv. Currently the only
>> + * supported option is %AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
>> which
>> + * controls how KFD delivers SIGBUS for poison/RAS events to the
>> +calling
>> + * process (immediate, suppressed, or delayed by N milliseconds).
>> + */
>> +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
>> +                             struct drm_file *filp)
>> +{
>> +       struct drm_amdgpu_user_options *args = data;
>> +
>> +       switch (args->op) {
>> +       case AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY:
>> +               return amdgpu_amdkfd_set_sigbus_delay(current,
>> +                                                     args->kfd_sigbus_delay.value);
>> +       default:
>> +               DRM_DEBUG_KMS("Invalid user option op %u\n", args->op);
>> +               return -EINVAL;
>> +       }
>> +}
>> +
>>   /**
>>    * amdgpu_driver_open_kms - drm callback for open
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> index e9be798c0a2b..e7d70e3a7f3e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> @@ -29,10 +29,12 @@
>>   #include <linux/uaccess.h>
>>   #include <linux/mman.h>
>>   #include <linux/memory.h>
>> +#include <linux/workqueue.h>
>>   #include "kfd_priv.h"
>>   #include "kfd_events.h"
>>   #include "kfd_device_queue_manager.h"
>>   #include <linux/device.h>
>> +#include <uapi/drm/amdgpu_drm.h>
>>
>>   /*
>>    * Wrapper around wait_queue_entry_t
>> @@ -1337,6 +1339,72 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>>          srcu_read_unlock(&kfd_processes_srcu, idx);  }
>>
>> +/*
>> + * Per-process opt-in for poison-consumption SIGBUS handling.
>> + *
>> + * Default: kernel sends SIGBUS to the process immediately when poison
>> +is
>> + * consumed, in addition to delivering the KFD HW/MEMORY exception events.
>> + *
>> + * Userspace (ROCr) can opt-in per-process via the
>> + * DRM_IOCTL_AMDGPU_USER_OPTIONS /
>> +AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
>> + * option. This lets the app's registered system-event callback handle
>> +the
>> + * RAS error first, instead of being killed by SIGBUS.
>> + *
>> + * Encoded value (stored on the kfd_process):
>> + *   0          - default: SIGBUS immediately (no opt-in)
>> + *   0xFFFFFFFF - opt-in, never escalate to SIGBUS
>> + *   N (other)  - opt-in, escalate to SIGBUS after N ms if app does not
>> + *                handle the error in time (safety timeout)
>> + */
>> +
>> +static void kfd_signal_sigbus_delayed_fn(struct work_struct *work) {
>> +       struct kfd_process_device *pdd = container_of(to_delayed_work(work),
>> +                               struct kfd_process_device, work);
>> +       struct kfd_process *p = pdd->process;
>> +
>> +       if (p->lead_thread)
>> +               send_sig(SIGBUS, p->lead_thread, 0);
>> +
>> +       kfd_unref_process(p);
>> +}
>> +
>> +static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
>> +                                        struct kfd_process *p)
>> +{
>> +       struct kfd_process_device *pdd;
>> +       u32 delay_ms = atomic_read(&p->kfd_sigbus_delay_ms);
>> +
>> +       if (delay_ms == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED)
>> {
>> +               dev_info(dev->adev->dev,
>> +                        "SIGBUS suppressed for process %s(pid:%d): app opted in to handle
>> RAS error\n",
>> +                        p->lead_thread->comm, p->lead_thread->pid);
>> +               return;
>> +       }
>> +
>> +       if (delay_ms == 0)
>> +               goto send_now;
>> +
>> +       pdd = kfd_get_process_device_data(dev, p);
>> +       if (!pdd) {
>> +               dev_err(dev->adev->dev, "Process device data doesn't exist\n");
>> +               goto send_now;
>> +       }
>> +
>> +       /* Take an extra reference for the delayed worker. */
>> +       kref_get(&p->ref);
>> +       INIT_DELAYED_WORK(&pdd->work, kfd_signal_sigbus_delayed_fn);
>> +
>> +       dev_info(dev->adev->dev,
>> +                "Deferring SIGBUS to process %s(pid:%d) by %u ms (RAS error opt-in
>> safety timeout)\n",
>> +                p->lead_thread->comm, p->lead_thread->pid, delay_ms);
>> +       schedule_delayed_work(&pdd->work, msecs_to_jiffies(delay_ms));

I think the work struct also should be part of the process. In case, two 
devices used by a process consume poison, the process needs to be 
notified only once. The work to send signal doesn't need to be scheduled 
again on a per device basis.

Thanks,
Lijo
>> +       return;
>> +
>> +send_now:
>> +       send_sig(SIGBUS, p->lead_thread, 0);
>> +}
>> +
>>   void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)  {
>>          struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL); @@ -
>> 1391,7 +1459,7 @@ void kfd_signal_poison_consumed_event(struct kfd_node
>> *dev, u32 pasid)
>>          rcu_read_unlock();
>>
>>          /* user application will handle SIGBUS signal */
>> -       send_sig(SIGBUS, p->lead_thread, 0);
>> +       kfd_signal_sigbus_with_delay(dev, p);
>>
>>          kfd_unref_process(p);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index f037062c33ea..d3fcf07c0ebe 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -875,6 +875,9 @@ struct kfd_process_device {
>>          u32 pasid;
>>          /* Indicates this process has requested PTL stay disabled */
>>          bool ptl_disable_req;
>> +
>> +       /* Delayed signal to user */
>> +       struct delayed_work work;
>>   };
>>
>>   #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd) @@ -
>> 957,6 +960,17 @@ struct kfd_process {
>>          size_t signal_event_count;
>>          bool signal_event_limit_reached;
>>
>> +       /**
>> +        * @kfd_sigbus_delay_ms: Per-process KFD SIGBUS delivery option for
>> +        * poison/RAS events (set via DRM_IOCTL_AMDGPU_USER_OPTIONS /
>> +        * AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY).
>> +        *
>> +        *   0          - send SIGBUS immediately (default)
>> +        *   0xFFFFFFFF - suppress SIGBUS delivery
>> +        *   other      - delay SIGBUS delivery by this many milliseconds
>> +        */
>> +       atomic_t kfd_sigbus_delay_ms;
>> +
>>          /* Information used for memory eviction */
>>          void *kgd_process_info;
>>          /* Eviction fence that is attached to all the BOs of this process. The diff --git
>> a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 419bb8086ccd..dadb7cf7b072 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -992,6 +992,29 @@ struct kfd_process *kfd_create_process(struct
>> task_struct *thread)
>>          return process;
>>   }
>>
>> +/**
>> + * amdgpu_amdkfd_set_sigbus_delay - Set per-process KFD SIGBUS delay
>> + * @task: task in the target process
>> + * @ms:   encoded delay value (0 = immediate, 0xFFFFFFFF = suppress,
>> + *        otherwise delay in milliseconds)
>> + *
>> + * Stores the SIGBUS delivery option on the kfd_process associated with
>> + * @task. If no kfd_process exists yet, one is created so the option
>> + * persists until poison/RAS events are signaled.
>> + */
>> +int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms) {
>> +       struct kfd_process *p;
>> +
>> +       p = kfd_create_process(task);
>> +       if (IS_ERR(p))
>> +               return PTR_ERR(p);
>> +
>> +       atomic_set(&p->kfd_sigbus_delay_ms, ms);
>> +       kfd_unref_process(p);
>> +       return 0;
>> +}
>> +
>>   static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)  {
>>          struct kfd_process *process;
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 9f3090db2f16..ab71c4b4aeac 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -58,6 +58,7 @@ extern "C" {
>>   #define DRM_AMDGPU_USERQ_SIGNAL                0x17
>>   #define DRM_AMDGPU_USERQ_WAIT          0x18
>>   #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>> +#define DRM_AMDGPU_USER_OPTIONS                0x1A
>>
>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE
>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union
>> drm_amdgpu_gem_create)
>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP
>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union
>> drm_amdgpu_gem_mmap)
>> @@ -79,6 +80,7 @@ extern "C" {
>>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL
>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct
>> drm_amdgpu_userq_signal)
>>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT
>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct
>> drm_amdgpu_userq_wait)
>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES
>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES,
>> struct drm_amdgpu_gem_list_handles)
>> +#define DRM_IOCTL_AMDGPU_USER_OPTIONS
>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USER_OPTIONS, struct
>> drm_amdgpu_user_options)
>>
>>   /**
>>    * DOC: memory domains
>> @@ -1673,6 +1675,25 @@ struct drm_amdgpu_info_uq_metadata {
>>   #define AMDGPU_FAMILY_GC_11_5_4                        154 /* GC 11.5.4 */
>>   #define AMDGPU_FAMILY_GC_12_0_0                        152 /* GC 12.0.0 */
>>
>> +/*
>> + * Definition of user options
>> + *
>> + * option: AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
>> + *    0:          Disable sigbus delay - SIGBUS will be raised immediately
>> + *    0xFFFFFFFF: SIGBUS will not be raised
>> + *    other:      Set the sigbus delay in milliseconds
>> + */
>> +#define AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY                0
>> +
>> +#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED
>> 0xFFFFFFFFu
>> +
>> +struct drm_amdgpu_user_options {
>> +       __u32 op;
>> +       struct {
>> +               __u32 value;
>> +       } kfd_sigbus_delay;
>> +};
>> +
>>   #if defined(__cplusplus)
>>   }
>>   #endif
>> --
>> 2.43.0
> 

