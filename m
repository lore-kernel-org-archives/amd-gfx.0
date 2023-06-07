Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95483C7EE25
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 17:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0722F10E51F;
	Wed,  7 Jun 2023 17:21:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7658A10E51F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 17:20:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sga6Big6mHnT0AZn1ONPEIOr/WQv+OysYii/u54B5Q26QZVarL9Ja9kFBx699yk6EVFDTnuEc9uQp1fLLMcUrVNxgNFYCvh4EtVogbGYD4s2ZHKO0qDP2zcJA2oK7YyoRafq7+y17KAvDdIRAciv4/TKsnVjD4Pdo7+SFkJSHJYA2a+tJk83vIJKFGIHCg0BXsOd9nzJ0hkU931Kr5mFV4rUEKD3tGF+Ood1GLOwPl5SB7imWDvPPyTtZ8ovwSS52leRhZ3EbVvbSY58KlCGYX369Mv2CGG0jPk9XVtxRiWi9f3BxhZYRrBG7mrBD7VBFTuhULsPcm2rp9i2MvGGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6B7J4+UgQ4vP8TIBbsAFuT0lp4Eg3yCF9ddFjlP97LE=;
 b=h7Zs/ql9+xLK4uQLBVQVLO59Od1rl3ZpCVNyZlNtrKJBduBiX1KXwaSvZEilQjlC/I+Ji5Ayr7WqrRrb7drF4MFU+j5bMNNFFwu/hnf5ZqAWS+2MoG6Ao9tEK5T9QD6EhyAXHGwRGGRQ9h2WDC111JcM67+n/5xJj9cSMsJRazUI9zvmhaVUxFv77TsrlexDkiybWo6LFRehE2AuZcadCZChgoJh019s4Er+azEOpxmBZG4wh0kRZTY+qBYSajuxPVkgkb8re6lV44Q6Rs0oEH1F/rV50TTCt0mU5KYFmdpin6eI9PraJpyWwQrtedhNVyQOqnbcbPUe57Zq4QcMdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6B7J4+UgQ4vP8TIBbsAFuT0lp4Eg3yCF9ddFjlP97LE=;
 b=xatmDdfJkuCuR/I8p00OrRd9aXB42eym5M3vZPIX0Mp6j4FhREC48ao/p9VyE1pJ1jbYt3f4Z1tKZGLk+W2QN0CkiIuUpRVqkg2d560SwKYo/5Qw4HTwk+Y4rJo90Mo1sF9WNkUmqa0138M+pYVotM01H3aMN1I0hI8+hPVIvT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 17:20:56 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::a500:7a4:10f6:1cc6]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::a500:7a4:10f6:1cc6%5]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 17:20:56 +0000
Message-ID: <d6ff5baa-4e95-62e8-df49-ca8840b16b2f@amd.com>
Date: Wed, 7 Jun 2023 13:20:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/3] drm/amdkfd: add event age tracking
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230606162418.1862540-1-James.Zhu@amd.com>
 <20230606162418.1862540-2-James.Zhu@amd.com>
 <de46df60-71e3-f722-efa2-d4f7e077cc31@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <de46df60-71e3-f722-efa2-d4f7e077cc31@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::15) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:EE_|DM4PR12MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f059f3-c1fd-4723-d853-08db677b8dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hp94cmY+vLzzTvRgFgZXyojj+XiMH5hiDXmgW9QACM+YkjlLFUMKXs5BU9C4RBjhC8AfDU23GPipeJ7erv+enYBOqDinPhwYXGL7lMZJUh6TsWGRo/n3wSzbb/+BuqHgD8azgQMGafI7xdJlvK090EIbe2nfXNKd3cWHFKQW0JuBQYJbrpwl6neBEvwZNXK3zv4Lduy5kgbQsUTXKKUz8G6r62EhPnL0erpbT3QRLbdyW7ml4eVpbjjCaAwbIHrQkVzj5UrO9ne2m6RYTtwDIRG5eDz2fERweF9uWdc1Z7aLIZG8P55APzu5YBM+EQBCMhFibQALx1UmaFyTo1gEWqYrReivnFMtEAmE7Qd5IpLB5btc3IeangrTGKeZoVz13mV38ekdxqt3EG0n2D9Rdp+ULqDYynYfq06V/pT5CGaxZpi9ml5Bni2+h6vZuaGR76fqP1TL+fik4UEKnTSVUAXZwLuL08ZoecZt9pNzDg7R5KaUbvxfJrjo2jW7na/Spu9SONoRxAkXeFc38sZylsq9sSffT0MtUolA31IlN2zCUbOXGT3/f3Y9nAY+oaFeXQ4h32+PKeFjtS5OXAXMIMDRU+o1HDWMeEV5ZG74ITLVf9U6Wzwj+7FTUENpCuOsTSo191bGHshmkXfhF5wX6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(8936002)(8676002)(110136005)(478600001)(36916002)(41300700001)(5660300002)(6666004)(316002)(6486002)(26005)(4326008)(6512007)(31686004)(66946007)(66476007)(53546011)(6506007)(66556008)(2616005)(186003)(83380400001)(2906002)(38100700002)(31696002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0dSdVVmUUNsV0taTFBIWWFnK0ZEOUlJZXVLWnI3ZkVZdGtpV2ZnYkRBUUFY?=
 =?utf-8?B?NGx0RCt3TndDdG5aR2U3cElGQ1MyK1JZNy8wZldmcWlDQUExZGl3NDVlY0Jv?=
 =?utf-8?B?ajMybko0eFhERXBlZ1VuZ0VCT21na3N2Y1VROE83UCt4aEhqWmpKc2xRMEpY?=
 =?utf-8?B?aks1bkRGeHFIVVZ2NzhYUk15S0M5TlVlMDZIeVlqNEhqMWw2MmR1Y2VKMmpT?=
 =?utf-8?B?T2dac2k2ZlZHb3hsTW14YjZWUXBNS3JwYithRHFCNVNVNWRjVUltei9PWjhE?=
 =?utf-8?B?YzUrVGZTWnFVbGQveTcxMzlqNGM4TWpnbTBuQitMQ25uZ2s1UFRKUkcwNnJr?=
 =?utf-8?B?MXZ0ckorcnBjV0dyOUFJK0g4NGZvY1FVbjdJZ29MVVNueGNvQmozbkdvc0hn?=
 =?utf-8?B?UlB4bmlFWFpCZko0UkcwVjEybTBSR2hRMSszNksxSFhsK0c4d2NLZ3lMakJv?=
 =?utf-8?B?VmU1MUhOZ3c0QmZXYUFCS1ozYy96MGEvdmM0YW5xblhERGQvbnVWaUxGRGpO?=
 =?utf-8?B?aWZHKzVOSDdJQVRzL2R5TlpyaWR4OFNmUlZzWkxZYzdvV3V0ZWJLak9pZHZO?=
 =?utf-8?B?ZVZpdStFNFR2TUxsL3E4eGdxQnROazdiUjNoVmhjTVBxUTdSNHpmbTNJZnRE?=
 =?utf-8?B?cEZjanhXZk0wdFJ0aWpvcUxJdWR1eURiNDRZdk9VQVgzRXNzRXRiSlNIQmhs?=
 =?utf-8?B?TWJNYmNZV2NoUDY4c3lDMmY4ekxJNzRUNGQ4Q1F1blFGL2RDOVZGREVsRjd5?=
 =?utf-8?B?dE9hUWdrMFdXYVJDcnlrVFdYL2tuK0ZYT0FSTUNXdlVXQlh0S2xRUXZSVDdF?=
 =?utf-8?B?a0xYSlVjTGFHWC8vZkUvSWpyOXpnWW0vWHF0YmpDOGpoV0dUaWo0TmQybEk0?=
 =?utf-8?B?UmttN3JGZ01BaWFUelVkMjJTeGZaM2ZKbjUxWER4NlovT1FYMCtibzE2SWVB?=
 =?utf-8?B?bGU5VkxlTzk5T3RiaEh5VnV4WndCWjZwcytwOFdKWVg3UFFXd1RmR3hFNTBT?=
 =?utf-8?B?KzdGRk1MdFJ4Tk9TUkxmLytLbHpGc00vUzdrMGNRQUlyKzNnUnVHeURvelAr?=
 =?utf-8?B?QUlIU25NSnFvSnlMK01tMXFzSVBYa01ZeTkrYXZzVGNXbEsvM3JGQndyTkh4?=
 =?utf-8?B?TTQzaWJqNkJmUEw0ZFovelRmMDlONWJGeEg2WFFUZUNXSW5KeGorMjBDVVkv?=
 =?utf-8?B?dlU1ejVPaUREQzF3UU1GZ3h0ampWRVdaa1VCR0RjTnBPcm83ZWRWMkRhOEIx?=
 =?utf-8?B?aWZxV1FDOHNFT2k0UzExcmpjbE1INlFkWWpqWnlUaTUyK2tQWlB4NUlYZGgw?=
 =?utf-8?B?ZTJZaHlYMXUwbm9yazh0SmRkNFRtWTFrZFpnSU1vdzM0QUV6WHNmNHJJdnVK?=
 =?utf-8?B?LzFqQnoxZ0N2ekpjWWg4YmszVXhBa2ZwUzdZb1pNdng1MzJOTk9wZkxyV3M5?=
 =?utf-8?B?cWs2UFJvbXkxbkdzSGNaN0ZTYzl6djIvdkN3VkJTNUFBZUh0U2tQRGFEUlpX?=
 =?utf-8?B?M3QraVB2Rmp0Mm1GQ2lpMGNwYzRUQkVKNTJQTlV3OGdBcHBjTnMyVU4zZWh1?=
 =?utf-8?B?S0dac0JMcXJpWGhIU01WQWxJRWo2OHNvRTlMLzdmSUFtVkk0cklsR0Rva3li?=
 =?utf-8?B?bHlNNmhTZXcyN25WT3IxeEp1K3F2bWZxTk5XREt2cjhLYk1mWHYwcnFuaEg3?=
 =?utf-8?B?eDFxdTlFSmltb1lNRFhZOXhxZXZPalZ4aVhLNnZwNVRDUnJVcXM0eXRHdWUv?=
 =?utf-8?B?M3hlTzVWM0xqUkM1d21jQkN3OHpVRDYya1VOdzFqWUFuS0Z5SmpJekNubThJ?=
 =?utf-8?B?UitYS091ZHNiWHdWN0F2WWhXNUVwZWZpTHBDaUFlVW9QN0diSVdyYmpDRUt3?=
 =?utf-8?B?c1p3Z0xRbjdnNXhWN290VzlrZmpQa0srM3B1MHcyeTV6cmVsZm52QVNhSVNQ?=
 =?utf-8?B?cU9IcUZXa1l4WndrY1poWDdBSnZVTkpOaHJsbkJuVE1EV3ZFRlZTRzFBR3ZW?=
 =?utf-8?B?eGlpYnJYZVc1QlZ5aEprM2FLaDN5YkEzY2dCK3ljSHJzOTdhc2pPWDdsK3VE?=
 =?utf-8?B?UzI0Mm1ITjYydXRIdkhFdXFDdVJFMFNlSE9KemdiY3c2Q3dRZFptMzdndXFI?=
 =?utf-8?Q?bi97O82S+Kk+SGVoPG2JFUBnr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f059f3-c1fd-4723-d853-08db677b8dcb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:20:56.2604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mFDeDlM5Q9bv2rFgAFewSJcjw2LruMw5a+zKmUj1WJ2aYjXbB+7g9Iw/u5y/ukz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495
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


On 2023-06-07 13:17, Felix Kuehling wrote:
> On 2023-06-06 12:24, James Zhu wrote:
>> Add event age tracking
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   include/uapi/linux/kfd_ioctl.h | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/linux/kfd_ioctl.h 
>> b/include/uapi/linux/kfd_ioctl.h
>> index 1781e7669982..eeb2fdcbdcb7 100644
>> --- a/include/uapi/linux/kfd_ioctl.h
>> +++ b/include/uapi/linux/kfd_ioctl.h
>> @@ -39,9 +39,10 @@
>>    * - 1.11 - Add unified memory for ctx save/restore area
>>    * - 1.12 - Add DMA buf export ioctl
>>    * - 1.13 - Add debugger API
>> + * - 1.14 - Update kfd_event_data
>>    */
>>   #define KFD_IOCTL_MAJOR_VERSION 1
>> -#define KFD_IOCTL_MINOR_VERSION 13
>> +#define KFD_IOCTL_MINOR_VERSION 14
>
> Bumping the version number should be done in the last patch in the 
> series, once the feature is fully enabled.
[JZ] Noted, Thanks!
>
> Regards,
>   Felix
>
>
>>     struct kfd_ioctl_get_version_args {
>>       __u32 major_version;    /* from KFD */
>> @@ -320,12 +321,20 @@ struct kfd_hsa_hw_exception_data {
>>       __u32 gpu_id;
>>   };
>>   +/* hsa signal event data */
>> +struct kfd_hsa_signal_event_data {
>> +    __u64 last_event_age;    /* to and from KFD */
>> +};
>> +
>>   /* Event data */
>>   struct kfd_event_data {
>>       union {
>> +        /* From KFD */
>>           struct kfd_hsa_memory_exception_data memory_exception_data;
>>           struct kfd_hsa_hw_exception_data hw_exception_data;
>> -    };                /* From KFD */
>> +        /* To and From KFD */
>> +        struct kfd_hsa_signal_event_data signal_event_data;
>> +    };
>>       __u64 kfd_event_data_ext;    /* pointer to an extension structure
>>                          for future exception types */
>>       __u32 event_id;        /* to KFD */
