Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2C3C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 12:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C39961357
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 12:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C39961357
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C970589812;
	Tue, 24 Aug 2021 12:39:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3FBD89812
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 12:39:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ll9C+j1kYdYPHDTRXzZP0wNQs7D0Advb4QsFrEKLOeTyK0yak+rcCQZncKTSbGRK7XtPTxzY7HFxWSRdnxM0xOOmadtw7U4X3pGHVwo8JzYcVmYolTbAYxxw+tfla5FKIp15nsUDF3IcXv1hX4nqLre2vednDEO7nJjgaPTKq212Pv9U0VH1ibdgv7TJ2S1nsRnHu9tVBMW1OcsNpoWszEAhGEzj8u5nfJkIbVPzgekTh8bRz+pPV0L/5JS8Q2UeqF+47vRPq4rXrcfgO4KMbndZDKQCvsgFRUex7EdsRJrRRZ06BcjkWVHs05phw8DTwMo5KDIg1gyb0OI/a/YkwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhjqB57uVNy6qfCi7GywRhpda6Bb40RARZpU7ss/sZQ=;
 b=Fnzi7st55ywDwyIP62W5mn0/EfHrAwzubu/U2yRulgx33aqXlk6KEu4nkQBCWfpvsYwM3Hq36r5bPT0zSKPHYZ3ccWCDoPXQKX553O7lxT6xiOVhX5T1C97HEaEJtuajeN5SYTVICcWaIzXDQLsb7JLvhR8Vhkngcd5UEQgxR2KHGzL1q4UorbYMBwRD5+mjbqhoRl/kFQN2zuhFm8L93U+AU9CpdsOkt2Uyp2EYM2fILB6IRBH0X9y7PKyC+f4GvDBCL4YUl0kOxan1VZd5+b1ms5VmiDL03vVYZEmC6YCduzrgzUFSRTtOzIw6lt98dlNtTpz4tYyVKVlKIB5qqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhjqB57uVNy6qfCi7GywRhpda6Bb40RARZpU7ss/sZQ=;
 b=yM2pgWNRdRGBrMFv764xmJz4FSKLsr7Xkn3DnkUtuYI4hv2ZkEjhxG9FWIQVZ0WoNHl+M7r8Vnk9iimNr8zzsHhWyRw0urIXkCFtzQuvtCSbYmv5HEDQohTfPSlfpzLb0yOcpiOeCwcPDXKlLe5CHNefhfQEIkixTRgHiQNV7uk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5166.namprd12.prod.outlook.com (2603:10b6:5:395::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 12:39:26 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%7]) with mapi id 15.20.4457.017; Tue, 24 Aug 2021
 12:39:26 +0000
Subject: Re: [PATCH 1/5] drm/sched:add new priority level
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, shashank.sharma@amd.com
References: <20210824055510.1189185-1-satyajit.sahu@amd.com>
 <66607af7-5310-629f-1851-df4b74cebf7d@amd.com>
 <4e2337a6-8d76-49ba-c0b3-e89f4c04b4a0@amd.com>
 <49509444-2e27-86e6-abe5-8a44dedc0f10@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <89f6e6e7-662d-995f-a281-7e5712fff772@amd.com>
Date: Tue, 24 Aug 2021 14:39:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <49509444-2e27-86e6-abe5-8a44dedc0f10@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0051.eurprd04.prod.outlook.com
 (2603:10a6:208:1::28) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.54.68] (165.204.72.6) by
 AM0PR04CA0051.eurprd04.prod.outlook.com (2603:10a6:208:1::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17 via Frontend Transport; Tue, 24 Aug 2021 12:39:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f9282e4-0a8c-4927-3c1a-08d966fc3510
X-MS-TrafficTypeDiagnostic: DM4PR12MB5166:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5166DB77633E43378A7C52F38BC59@DM4PR12MB5166.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2J9hH/S/r+W9gfDVfc4Ez4I4o+pmiy+owUMPUSVA0K+A6hNbI/Uihj1jL6QPXxm4n7mbdcpXby4CzREwXVzjWuuGntmnLVVTZ1gfjwJTl59v33+ar4jQnq3zEFNm3Ypv/eKc/Hfl6jhgpz6hagnHYVedpDf0wVET+cPe+Ixyy1dZRdIvSftgFNt19RIkRdxBkDdnhuCz3iYBdyY9YVfI0rAVi++XYmaEj/j0ShpIERvUO3C3zHfaPvX9hALg3c1gwSvVpFAe/1ZBgYQbTPUoVePlRyxguqSW9Sz59Qs6qtq/3hFviTBh6l2SlHFalAw9LeB+lLpAiaL2vpTMv9o5FOiIlSpGTGp4I96vCd0/6dxn57ZE4nKfUTjH2AICeQW+mUzte4MckaRUC2an2zu7Lh6UFkOpbcHZ8x4HQ9gRgAYRD5oIFxAlxWYXkCrsqlX4oxsbUgvLAeOeqMhq1QEXheGgYEgfjTtYLnpLnWUHJRlGdjzcWxqJ6W7YnqNQYJ44++TvFXGAZJBM5E1k5L02TGsIdls2RAROgVGiuR2y0/OamRSq/tyEjqinCPykulASm+QKLEziA+ax/r3xsF3xm6C21jsJwycy8BlK+/1A2ubAqNm2Z5Vj3AQaULKS5k/dcR6wgIvv+gd7uUqwUqPgWBAaV+J8AjDM1Hodslb2cf65NQdzodzmtn6TpWkXgyVbu6bPQIKwik+TgpKQviA2OFclqrqjbbMZ3xaygCfLsupwi4DbbXWPLt1V6yxP3g+fYnBNvNMMy4GsRoxbsdTwdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(2616005)(956004)(38100700002)(8936002)(8676002)(36756003)(66946007)(2906002)(38350700002)(66476007)(66556008)(5660300002)(31686004)(53546011)(186003)(110136005)(16576012)(316002)(52116002)(31696002)(6666004)(508600001)(4326008)(86362001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXVFSHFXbTFZTFRudVp5OU92UFJRVG9GOG9vZ25ZWThOVmxPWXIyVGtBL00v?=
 =?utf-8?B?SFlwclh1Tk1MWEhsREVxSWV4d05JSitpUHBBbHFnaVBFVXZKVWxMTDdoc25m?=
 =?utf-8?B?ZXAvb21WZVlqb24xeDN2dWd2NU9JTDF2blI0S1VKeG1MZkk2TDF1NVo2UVhO?=
 =?utf-8?B?RWwxSXlUa3Q5bXlpL0VIUnRzMzVsd1NjK1pLNmRYSWFHdmxtQzMrL0dRa1VL?=
 =?utf-8?B?dWVrckZjNVVkZEhnQ2UxaXZaU0pkeHJhVWFkUUpnMWRFOWN3eWpqSmRJSFNw?=
 =?utf-8?B?azg2UkpSc2dHa2ZIMkdhL2NTZE1Tdlh5OGpJT051dTIyWW95dUhBcUxLN2RS?=
 =?utf-8?B?L1JjM25rWXdFaklyNzA1MWd0MGQ2M2FNTzhZOXJwN0RUWEhxbnJTcnczdUpj?=
 =?utf-8?B?TUhkazhYR3lSZFc4TXB6cU1ySFlOZjNUb0xIVkdtZWFRSHB2NFIrVEluNmor?=
 =?utf-8?B?N3dHcm9UUk03bzFlWVFQTVpUOXVXNlhRMU5ndXU0azRPanRvdjZQMERoTlFa?=
 =?utf-8?B?TDFsZ2QrRU5nOHlTK1N4YXZNRkdJcURqWjg0Tzc5MmZNL0xRVFh1dzhYVURr?=
 =?utf-8?B?bHFmU0hhUDV2UUpWMW5ONDVCbVJrd0tsaTJZMVVIQUlIY2JzVWFpSVJuNHBz?=
 =?utf-8?B?SUhYU2JZcE5lK29yWCs2VGdlMkNNVWw5enQ0RldRMFcwaHNwcDFFVkJKTWt1?=
 =?utf-8?B?YjREWVhpNWJKVEQyaWh2TUd4L0tTMzFCRjdTai9zODkrMG1sd00xcE50T2kz?=
 =?utf-8?B?KzBpN3NsMlZpVENhS294b2ZHK2NLMGwwRFptVUpYZDB0UnFhb2ZJczVad2J5?=
 =?utf-8?B?aENQWXNiNkk2ejNDREovaitGVXdkN2dmVFptVHpMVzlLSDBZMkxMQTE4UjhL?=
 =?utf-8?B?dktSTnQ5bHVNdDdRK0ExTmd2eU1NR25jUEZ2YTc2SFN1KzgzRllwYXdhTDNr?=
 =?utf-8?B?Tjgzb005SlRONXdhNElsQ0hoVk9EUmdBaTVRcnVmQUlSV2RzK2ptVm1BNnhN?=
 =?utf-8?B?ZmZxYlRYWVI3cC9kWEUxZDdRWHEySzZta3NKVDVZalYwTTYxRGV1amI1dEhp?=
 =?utf-8?B?cGtick53ei9MVC9OUmJsL0tOcWE5SG1sWWhZRkp1a0RFNy9DTmNXUG1FMmF0?=
 =?utf-8?B?bWJPclJYSHhINTl1Q2JHd25mbXhlaW1mVUM2dThFdXNJbThWMlZDcE1GV0VF?=
 =?utf-8?B?Sm9KMmEzajdQODMxNi8xaW1LUU5Sakd1emgybVpIOXRTbmxpSXR6K3FDZ0lt?=
 =?utf-8?B?MVQzVm5pL1Z0K0EvUlVWY1NacVo4bUFienYxOHhCNVJERC9NcDc3cE5jSnd2?=
 =?utf-8?B?ejExZ3dwdWgweTNwYkJ1Q0M2L1MrYys5UGlEbG8vSnFIWXB3SWRZckpuL1R4?=
 =?utf-8?B?QkFKemlJQjNmcmdvVzg4YnZ0amxreldNNCt0VTRCSTU4Y0lIakNva0xncVJ1?=
 =?utf-8?B?b2VKZnUvQmZVVWpndGIzaWgrV1IvSDhmYlRDSERVUkNUWGdtcitRMTdyVmpr?=
 =?utf-8?B?bUxkSW0vc2tTa1JuUlUzeEE4dWdYaXYycXVRMTRKajVrVkQyazB4YlZuOHd3?=
 =?utf-8?B?SE9pazBqeDQvK2NlSjdmOGM4dEExcDYwMUZ0bzI3SVljNmh0YU5HQ1ZkSXRM?=
 =?utf-8?B?ZWdOM3pySUhSZFRidmxtVjllSGhwWEdjSjJDZVMxM0xwZFFWc2l5eHpRU3ly?=
 =?utf-8?B?bktTNE53OTdVdDI3ejdxdHp0MEwyN1FsR2dVSDZ5OXNjbnZnY0FDQ3hEbFU5?=
 =?utf-8?Q?nMtatG/sb3Aw8N3JszTthfqmOJkwt395O/m3PxQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9282e4-0a8c-4927-3c1a-08d966fc3510
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 12:39:25.8779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Saqz2UbhsnC+5/KdlM1/RpWVf+b1rGEU+xLqZMuF6o7yiFomhN7UJwcuSwSVbkS60b/W9oq+m/25afwiDyy9Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5166
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


On 8/24/2021 2:07 PM, Christian König wrote:
> Am 24.08.21 um 13:57 schrieb Das, Nirmoy:
>> Hi Christian,
>>
>> On 8/24/2021 8:10 AM, Christian König wrote:
>>> I haven't followed the previous discussion, but that looks like this 
>>> change is based on a misunderstanding.
>>
>>
>> In previous discussion I sort of suggested to have new DRM prio as I 
>> didn't see any other way to map priority provided by the userspace to 
>> this new 3rd hw priority.
>>
>> Do you think we should use other information from userspace like 
>> queue id to determine hardware priority ?
>
> If I'm not completely mistaken we have dropped the concept of exposing 
> multiple queues/instances completely.


Yes, that is my understanding too.

>
> What we should probably do is to use the (cleaned up) UAPI enum for 
> init_priority and override_priority instead of the drm scheduler enums.


I went through the drm code, now I see what you mean. So what we are now 
doing is:  mapping  AMDGPU_CTX_PRIORITY_*  to DRM_SCHED_PRIORITY_*  and 
then to hw priority which is not nice.

We should rather map AMDGPU_CTX_PRIORITY_* to hw priority directly.


Regards,

Nirmoy


>
> Regards,
> Christian.
>
>>
>>
>> Regards,
>>
>> Nirmoy
>>
>>>
>>> Those here are the software priorities used in the scheduler, but 
>>> what you are working on are the hardware priorities.
>>>
>>> That are two completely different things which we shouldn't mix up.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 24.08.21 um 07:55 schrieb Satyajit Sahu:
>>>> Adding a new priority level DRM_SCHED_PRIORITY_VERY_HIGH
>>>>
>>>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>>>> ---
>>>>   include/drm/gpu_scheduler.h | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>>>> index d18af49fd009..d0e5e234da5f 100644
>>>> --- a/include/drm/gpu_scheduler.h
>>>> +++ b/include/drm/gpu_scheduler.h
>>>> @@ -40,6 +40,7 @@ enum drm_sched_priority {
>>>>       DRM_SCHED_PRIORITY_MIN,
>>>>       DRM_SCHED_PRIORITY_NORMAL,
>>>>       DRM_SCHED_PRIORITY_HIGH,
>>>> +    DRM_SCHED_PRIORITY_VERY_HIGH,
>>>>       DRM_SCHED_PRIORITY_KERNEL,
>>>>         DRM_SCHED_PRIORITY_COUNT,
>>>
>
