Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFA5C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 17:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5541C88EA7;
	Mon, 22 Nov 2021 17:37:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D7588EA7
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 17:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGGzLvBs4VJtCzKxaIIG6U7APN1Ia9xOIlZNkGM462+M6ypu60O1lfdeSiCQ4euN9Il84sUO2wKMstXAioLHqDVvJPxpOB4iaLx4vyBCiD9OAXS8hYWuvaRlrf3IdmR11HcYdon5zGkKO7HBNVKFO15Wfk9eAwQ0pxkFte2TfSLVcLxs05E+PYyjDkNMFgfWsXm564S/Di4r23qCFmnRHIGTPGdfX27wn29I9GKmTnKHhTkj+t5wI+gSfsjR3UrztoMaFmz5c00xDDq7iOVhJ34kAkpA/flfxUOvQxTsH7+8YCHZWSvUEgsGPMMSqy3iOAX8jcPpo5UlqmczCijKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW2kRldrl6Ef9SZ1dol2zxAqi2iItlsUollxoaGpzno=;
 b=hP702mUDSmKqPijjQINmrMUMfUlTL4rz9yG0WV4BdDnWhZkvk0sO/ydDxI7ko5pFFynh2gYFujw0tZV+/+ITDMTYjiXuAiTJ52gMicYqivNpWNuA8s91WnPRbJxktLFbC1wWCUYMn1euQ6N0ZOOU/qqAl7T9VBb2osClcklc5Tj0rqR7mGZxCtqxr/+uKk2mEdu7vrkcYmEZplvgQhhEaLYRUfVl5z7rEclcWMNJDhz+JPNBLGQYgUHBuTNGtcbjJJsPBmtYfrywxDb4kc8AWYOf9HnSfWv+dqRvoOUXuAjUn9HvHVO8+cPosALzotkAXKVqgkAR3HwJ9h2/2I+fAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW2kRldrl6Ef9SZ1dol2zxAqi2iItlsUollxoaGpzno=;
 b=waCUtZFTgbdmyb0Hd+OCINTvAEtXbiD6f8O7EFpsyOaSPeWF81xmzXw6nf2njAbD0aVh63H9OJemmKzFau3Db1hXl4S3ZUsRU8u5SIf1CFd7aFwPJJ2rxFNO830hrNZqrk/+vnha5nD8fAJqtRR6NwrsnhBoVc8vW7EME3kf8kQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5225.namprd12.prod.outlook.com (2603:10b6:408:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 17:37:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 17:37:05 +0000
Subject: Re: [PATCH v2 2/4] drm/amdkfd: add kfd_device_info_init function
To: "Sider, Graham" <Graham.Sider@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211119195258.2173551-1-Graham.Sider@amd.com>
 <20211119195258.2173551-2-Graham.Sider@amd.com>
 <7a682c56-817b-2658-b370-19875e3fe06e@amd.com>
 <DM6PR12MB30673775BED4A5783F78129C8A9F9@DM6PR12MB3067.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <46774a7b-8554-cc17-8242-b5d90b424dd2@amd.com>
Date: Mon, 22 Nov 2021 12:37:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <DM6PR12MB30673775BED4A5783F78129C8A9F9@DM6PR12MB3067.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT3PR01CA0089.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 17:37:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cd666f3-9350-425b-b70f-08d9addeb356
X-MS-TrafficTypeDiagnostic: BN9PR12MB5225:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5225A8ACEAAFAE2D9DD30602929F9@BN9PR12MB5225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEjW5BN96oW4JdxZhM8/bxnAbtI4jwEtoNCV9d7ic604HfLgGjZle/qSc8Q+R4C0KpBsc1PDlNsLBX3CGNC5bth4m7N7nFb+8BYSgcZ6sqkoOTmkxYxkdwaRLdoJEqzIfzo0MTaJozIWvrkjMwuyMutG9U5u5X+UIw/0QjJVXeSu1LctJz8PX624PmvtHmSumIvJTUQ8+dZUytoxpLOGLKocFz3zkywt084gf0sy0StYkKfijWwqypjRQNPKYi0zqp1zzBfyCYlRpMlZ8EXRdbBcpeCJkapKBThkp1EPGOaI+TMa9qlzr7q+8bcBAEhCckp0LR69TahkgoQantja9eXIMCfz/hH/d8Sc6BjJOqBIoruqoCHr2RDgNu7tBcLNeYc9gZty3rz7SFUcichKhxdAA/Ff7OR+TVr32Umj5SwkrmQvFTm6HZMas+9YMBm3I9DhDZveYvge1CcMHG7kr2aPIGq1Y1HYtr+78Eq8m7sJEb161M9MzSXum9ga9JUGnFjK6l0Qjp6FQrleqszjf3XOwc62RlGyVITnzePsAk0qIP8B3QssMKW8MQ+ybxcYl1roBHfgzutwa95r2Uj8plHLqOyrqRtq0+N0hN2AON97TtpsmaubEHAgcPr6UTG8yr5/AEF9fxgM7pV+066UkMfoyKtV3VRDHFURiVLUGTnrNL3ZOQLPGVPFnnoCU7BcDxl4n+D9T5VZZq2SS3b/nGpZXLx9JjRTet3EqhPG4qq6b5/ViRkfxknG7+wQtqGe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(44832011)(4001150100001)(8676002)(26005)(110136005)(16576012)(5660300002)(508600001)(86362001)(956004)(31696002)(83380400001)(2906002)(66946007)(38100700002)(8936002)(316002)(36756003)(186003)(4326008)(31686004)(2616005)(6486002)(53546011)(66476007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YS9vaEdZOWZQakpZdmE5OXFhUjZHWW9yeEU0VFdSa0MzbTQxbklZL2s5bGRS?=
 =?utf-8?B?WjNWQmRJd3U0YWJHOGt5OE9zVDFrM1RDczhtZUFhTllVZXBnT0ZBdm56ZTVl?=
 =?utf-8?B?WDZ0dlBJYlBydEtNOGVtZlRMZTRKNkJucFVpZGVYSEkvK1BLTGFGWHRHM0lz?=
 =?utf-8?B?UEhGbURaVW16TU4rbTBPNGY5b29EaCtRQ0svQUlocklidlJNQ3JodkdWVTZO?=
 =?utf-8?B?WEVBYUordzAzcmhzaUg3U05oaDhOV0FTL0Y0Vncxa2l5S0d2ZTVNKzU1elh5?=
 =?utf-8?B?VVpXYnhVWXZKMlRURDZ5WUIxWTl2a2xqN1l5YjZNc2h4eGFyeUx5YVd0TTZq?=
 =?utf-8?B?amk5eFVSaFNMTmlzUUpMTFRuclpaOVU4a3lhcWNmTXZSRHdqdkl5ZXlhcW1p?=
 =?utf-8?B?dGkzbjdVbnRKNkozY24wN29zNW5TOFBDZWtKSmF3b2xHNjFRQllGbXV1U3hK?=
 =?utf-8?B?cHlXTW5sZlUrcUk0SFNFSlU0NTUzRXY1RmxMQ0tjSEc4aFphb0hrVHlOVWpS?=
 =?utf-8?B?VWFmNFRBbEN0Y3E1akxYcXB1bjdkS293VWFBT1lDb0lucjNkRHlJTDU2Snox?=
 =?utf-8?B?QW92UktHaFd5bDh5dnVCak9jZzRzT0FCVm9rVXd6UHZRVm4vMmllckdrNFdO?=
 =?utf-8?B?SWJjWERLV1dSTGp1R0c5M3hENVJMcnNTcjZKOVM1THNxZnhXeXJRS3phbVpr?=
 =?utf-8?B?VnI5UnZneE5CU1lvSnY1c0RYb1Q0TTdvSVlxcUZRZWZzNGYzNjBFQWFZRnl6?=
 =?utf-8?B?bGF1bFlZM2ZSWE13Um4zUzRobHQ4MVZxTGl6Yi82KzhkamlzYWRzVUJNT1Va?=
 =?utf-8?B?ZllUQTlHNjJHU3VUYWVlN29NdzR0Y0xyLzJBb0E2aXV1NnlhTDlOUUFZaUs1?=
 =?utf-8?B?dmo5YUZXOU5BMjFGT1hoYTdzQzVocStMRTJEOGJJOTVZTVd4emJ4K2JuY09O?=
 =?utf-8?B?bmN1N1l3eE1SSm5GRi9XVDBSNjExTmRpMFhja2J0eko0Qm5iT1NUZ3hwTkxn?=
 =?utf-8?B?N096WkY3ZmwwT1Y0MHRheHhEUWRldU5qM3NoUVZ2NTJLRTFITTlUT1B2cmZ6?=
 =?utf-8?B?SVluWm9oaW0yUGNFVG5OMitZNU8vRk0rVEN2UzVWcGRoNy9ZZzM5dEZTOHZD?=
 =?utf-8?B?UW9mSTAwdkJhWjAvSStaYzlNUi80eVJUeE41NExKMExNZ3crcnBMdXREUjFE?=
 =?utf-8?B?b1pHOXFwRlpvZHRrRmZOTE5McDU4UzRiZ2p4b2lsUEozNU5ncnFNRndVdHVV?=
 =?utf-8?B?aS9KL0ZSV0xOT2MxbVNFTUU1LytQMmM2SHhXVytqcWJDeWUvZDJwTlIzTkFa?=
 =?utf-8?B?Zm8xQXJnSEF2d20wQm5NNEJiUlFjOGVldjVzcnhxUUNvNEE0cTREQjZybDJ0?=
 =?utf-8?B?aDJmVE9NQU1XckNmVmd0M0RQK2R2a2o3T0hzYTlINTlsNGk5SFlreDcxVjYx?=
 =?utf-8?B?cjlUbHBxdHUxQU5RUnRLTjlhWlNraWxVWUZQR3cwZ0sxNEVVWThJdnplSmNG?=
 =?utf-8?B?OGVEWnhqZ24yVkJEWkFDV2pTZHIvb1dBRkZmQmdZM0RTcDhTNFpXUnJjblZn?=
 =?utf-8?B?VWNkczcwWnFqT2xTMU1YNzdJNXJjVkFGbldGMGMzbmRKdHdqOXc5UyswOThy?=
 =?utf-8?B?aDBCU0VSYzZHK2ZZdG1mSVFnU1p3WFltTnJTVXNxZis1QTFJOEpWUFVjVmN2?=
 =?utf-8?B?NW55UkVqZk9Sa0Rmd0MwZE8rd2F2V0IzcUlkaGpRZElyRHVnL2ViUzBKY0w2?=
 =?utf-8?B?eklPcHpPYnkwQU9RZHZiWmZzK1VjN1R1Tmw5Vlp0TVpFZ3FaNTl6ZGNlNDZs?=
 =?utf-8?B?bitvMTAzZlpLVlhnYmRwUzA0ZWtDRGRyMXdyQnZ5ekl4UVpRQ2p0VnhoVkd4?=
 =?utf-8?B?VlVRYlgzdzZYaVQzVCtQZ0N5ZjErcGNES3ZLUCsyM0pKVmV6VVVHdHFQL3RD?=
 =?utf-8?B?UFVmWTJjVVhLa2JpZHltaWxnQVJiZkRLVVZvVk1NZ0RzeloxQVYxOW95d1Vr?=
 =?utf-8?B?NkNQNE0xRVNPQ2RWQzRYR0RKM3ptTUR3cHh3QklNcGNWWmNHQTNJV3JMYWVt?=
 =?utf-8?B?NFVHTytkSnBMaVdCNGdBSDZpM2ZTajZidDhLQ29xcjJzOTd6L3Z4TlY3WGJ4?=
 =?utf-8?B?dXFlNzRzWUlidXV0MENJcUl6Q0FOK1F2bHJ4K3JWN1FsY3ducnl5d08xR3J0?=
 =?utf-8?Q?jQLymJJaQKqkLaLPkmYHNUs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd666f3-9350-425b-b70f-08d9addeb356
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 17:37:05.4114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8oY6GvlvAPLDoeeKqfQ2PZCacN1hHigWogGJz/ge3P2a40tnj2Zg3awDsZqZpKvh25DyhdSUT3+Bzvmo9bZiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5225
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-11-22 um 10:25 a.m. schrieb Sider, Graham:
> [AMD Official Use Only]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Friday, November 19, 2021 4:20 PM
>> To: Sider, Graham <Graham.Sider@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v2 2/4] drm/amdkfd: add kfd_device_info_init function
>>
>> On 2021-11-19 2:52 p.m., Graham Sider wrote:
>>> Initializes device_info structs given either asic_type (enum) if GFX
>>> version is less than GFX9, or GC IP version if greater. Also takes in
>>> vf and the target compiler gfx version.
>>>
>>> Inclusion/exclusion to certain conditions for certain GC IP versions
>>> may be necessary on npi bringup on a case-by-case basis, but for the
>>> most part should be minimal (e.g. adding one || asic_version ==
>> IP_VERSION(X ,X, X) case).
>>> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 61
>> +++++++++++++++++++++++++
>>>   1 file changed, 61 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> index e11fc4e20c32..676cb9c3166c 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -511,6 +511,67 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
>>>
>>>   static int kfd_resume(struct kfd_dev *kfd);
>>>
>>> +static void kfd_device_info_init(struct kfd_dev *kfd,
>>> +				 struct kfd_device_info *device_info,
>>> +				 bool vf, uint32_t gfx_target_version)
>> This will give you a compile warning about an unused static function.
>> Maybe squash this with the commit that actually starts using this function.
>>
> Sounds good.
>
>>> +{
>>> +	uint32_t gc_version = KFD_GC_VERSION(kfd);
>>> +	uint32_t asic_type = kfd->adev->asic_type;
>>> +
>>> +	device_info->max_pasid_bits = 16;
>>> +	device_info->max_no_of_hqd = 24;
>>> +	device_info->num_of_watch_points = 4;
>>> +	device_info->mqd_size_aligned = MQD_SIZE_ALIGNED;
>>> +	device_info->gfx_target_version = gfx_target_version;
>>> +
>>> +	if (KFD_IS_SOC15(kfd)) {
>>> +		device_info->doorbell_size = 8;
>>> +		device_info->ih_ring_entry_size = 8 * sizeof(uint32_t);
>>> +		device_info->event_interrupt_class =
>> &event_interrupt_class_v9;
>>> +		device_info->supports_cwsr = true;
>>> +
>>> +		if ((gc_version >= IP_VERSION(9, 0, 1)  &&
>>> +		     gc_version <= IP_VERSION(9, 3, 0)) ||
>>> +		     gc_version == IP_VERSION(10, 3, 1) ||
>>> +		     gc_version == IP_VERSION(10, 3, 3))
>>> +			device_info->num_sdma_queues_per_engine = 2;
>>> +		else
>>> +			device_info->num_sdma_queues_per_engine = 8;
>> I feel this should be based on the SDMA IP version, not the GC IP version.
>>
> Can the SDMA queues/engine be determined by the SDMA IP versions? I would have thought those were instead done on a chip-by-chip basis. E.g. in amdgpu_discovery.c this is how the number of SDMA instances is defined.
>
>>> +
>>> +		/* Navi2x+, Navi1x+ */
>>> +		if (gc_version >= IP_VERSION(10, 3, 0))
>> There needs to be a maximum check here. This case should not automatically
>> apply to future ASICs e.g. GFX11.
>>
> Just a thought on this: assuming on future asics this field is going to continue to be populated, might it be better to just continue adding cases here as they arise? Adding a check for e.g. < GFX11, would require eventually bumping that check to < GFX12 alongside another check for >= GFX11. So at the end of the day, if a >= check is going to be needed anyway, is a maximum check necessary? Of course this wouldn't apply to below regarding the needs_pci_atomics bool, since as you mention on future asics it can be kept as defaulted to false.

The reason we had a firmware version check here is, because on these
ASICs older firmware depended on PCIe atomics, and at some version it
stopped depending on them.

On future ASICs I would expect all firmware versions to work without
PCIe atomics. So device_info->needs_pci_atomics would be set to "false"
for newer ASICs by default and you would not need a firmware version
check for them.

If we do need more firmware version checks for future generations, the
firmware versions will be different from current generations.  So you
would need to add new if-cases for those anyway. Firmware version 145
will be meaningless or plain wrong on GFX11 for instance.

Regards,
  Felix


>
>>> +			device_info->no_atomic_fw_version = 145;
>>> +		else if (gc_version >= IP_VERSION(10, 1, 1))
>>> +			device_info->no_atomic_fw_version = 92;
>>> +
>>> +		/* Raven */
>>> +		if (gc_version == IP_VERSION(9, 1, 0) ||
>>> +		    gc_version == IP_VERSION(9, 2, 2))
>>> +			device_info->needs_iommu_device = true;
>>> +
>>> +		/* Navi1x+ */
>>> +		if (gc_version >= IP_VERSION(10, 1, 1))
>> There needs to be a maximum check here. On future ASICs (maybe GFX11) I
>> would not expect atomics to be required.
>>
> See above, agreed here.
>
>> Regards,
>>    Felix
>>
> Best,
> Graham
>
>>> +			device_info->needs_pci_atomics = true;
>>> +	} else {
>>> +		device_info->doorbell_size = 4;
>>> +		device_info->ih_ring_entry_size = 4 * sizeof(uint32_t);
>>> +		device_info->event_interrupt_class =
>> &event_interrupt_class_cik;
>>> +		device_info->num_sdma_queues_per_engine = 2;
>>> +
>>> +		if (asic_type != CHIP_KAVERI &&
>>> +		    asic_type != CHIP_HAWAII &&
>>> +		    asic_type != CHIP_TONGA)
>>> +			device_info->supports_cwsr = true;
>>> +
>>> +		if (asic_type == CHIP_KAVERI ||
>>> +		    asic_type == CHIP_CARRIZO)
>>> +			device_info->needs_iommu_device = true;
>>> +
>>> +		if (asic_type != CHIP_HAWAII && !vf)
>>> +			device_info->needs_pci_atomics = true;
>>> +	}
>>> +}
>>> +
>>>   struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>>>   {
>>>   	struct kfd_dev *kfd;
