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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8431C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 11:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A53660EE0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 11:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A53660EE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01DC789A0F;
	Tue, 24 Aug 2021 11:57:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9490B89A0F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 11:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efPpHt1AuOrAzbHNXYH+YnL4VkHaEOeane4suDbB+v+G6A4uJWDLslDpFRKAzblXsbUIKos9TL9jQ7eL815OReaUVczPZa1fU6cwPZ9WFf9mqJFAbeOfD0Ct5XGtiyXviaOI45zDn/R9DsDd0q4uR62oesQq45JlgmrOOxRsTU80neSgjAptwuD2YeOw7jh2QG4vku996y6/gs8eqF/zwNnLGP3TmW14VoC+iTorH8fW4Rw/a8acZODpWsCKD9/Xr4I/1zaqqCYh0qVg6qAsxHY0Ah/jGrZSD4smPh1uajOyoFXXtDqFutpMNO9tFc/VH7r5udy/5QD0jY/gqjhUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEzSAGLKc3C1SVl8aiBlC1Tf8Xr6XKMsax1yLlUQg1w=;
 b=EPaCHrfnglWRDJWr6zjkLox25RRP6jydLw39gaeFei5VOwlGiBtZvH8S8fCfEVTy5A+G3dJwyFNGi56LtGi2VC/6QVX0jS/JkQNIKugJ/EjCuslZC60ojjX2KAr4LuNqRKMCWMb9f78eOBPPviYbw7VsqrLKaUmrn7I58s1rMZrQc6Kfed2MrIurEwuu7Y09NcTvPOhQogOgJRRE2PLNJArkInni4pzFUUfFv2dr706r0x63M/6wIe0F0gXKmWzSL0tHO6BDFOSyHNAL78s6t3b7HR6Lzbzkch07TeVdg1mtSLHQc+P0PtC35fT7HB2iU3/dpKE43HYZZ4UfXzELsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEzSAGLKc3C1SVl8aiBlC1Tf8Xr6XKMsax1yLlUQg1w=;
 b=tgftQ8Inw2P6vc1MsEUQvcLczgwtKNGRtEm3Hew7O9nl6bypwiwQBNgPrBfXfNckQg57DonZj0+ho83Ks7qehG0/YDq9+rpUkPnguRcbgLpb28zvYNZiXN4jiZGG1THDstQVKbJSSqFUdhm8V6j9ugLm+5OA133NxlRjAhgCWwc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Tue, 24 Aug
 2021 11:57:27 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%7]) with mapi id 15.20.4457.017; Tue, 24 Aug 2021
 11:57:27 +0000
Subject: Re: [PATCH 1/5] drm/sched:add new priority level
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, shashank.sharma@amd.com
References: <20210824055510.1189185-1-satyajit.sahu@amd.com>
 <66607af7-5310-629f-1851-df4b74cebf7d@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <4e2337a6-8d76-49ba-c0b3-e89f4c04b4a0@amd.com>
Date: Tue, 24 Aug 2021 13:57:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <66607af7-5310-629f-1851-df4b74cebf7d@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR03CA0073.eurprd03.prod.outlook.com
 (2603:10a6:207:5::31) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.54.68] (165.204.72.6) by
 AM3PR03CA0073.eurprd03.prod.outlook.com (2603:10a6:207:5::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 11:57:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ac8b058-f3d5-4aa6-b64a-08d966f657ca
X-MS-TrafficTypeDiagnostic: DM8PR12MB5414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5414D27F16645D5D5EA2F5C58BC59@DM8PR12MB5414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ds6lFjjTqjCra35ZOGfJ1QJXbaLaPCzHb5NBLuBF0aykKrkZ/IkLMjM1MrQ6IElFVwBouiolXIWRf+cKXlnJyMcqgKW0DVe9CfGU8wPfGKPCw/rgdYY+vp9FM0dXAwlXbA08l3/jZxjNmL8gvSJDJwyC4tJ3CcyQv6AS4q/462F+XtcxzXG1MV4h/72Kx0IwnErnSkDL+vQcA6Sq11AOjsfNuItpLA5TQ1ON95gsHWueUvIJfBrOaIbmX3F3aAmh2/rg66Rj2iGrW3fvrAwKuqP99BvdHy32t4dplgQYx8WRUV8i58uTUjUCO1JfyrMnX53qwJJejTKmUhxHY+wjck5xAIP+Xol17qlhxWqqpjXIt2sPhgDcel0mM92/NtW50ZbH+PMvEkeChkksLo+RQvp2f5EpNt6lwrdijVYZ5txsVv6C5xMXoloTbJ7YpW2cGirG9g0qB89jxUGvHwk0EEW/Nznw7eZje5kRbqJYdjtt6t8NuWoIj87VyNT5yzbUwhNbKUgkQpJb5feqRzTFRSM7OHDbOVps35p8ny/WKG9OYC6qx5rcZ82p+e2cpvJxtvOJbep+b1ykITlcxDffBhX6tAaaYTZ4OaF2GTJIlSLmTUWHtj+70YCsXvncheMyXNkn+P/B/qBPFknd/MFUBM7YuXxBBboGJaoEbbE/j1USlzqv+M+ThaQ9jgO+nsB+Zn/ZXZa19JxhWTGblBD2e+iLHnKadM2iP0nOrk5OAlC0fEgQZ+X04REXzvXccIW//fqeA6Uj+WAB8X1T7E/Iwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(38350700002)(38100700002)(6666004)(16576012)(956004)(2616005)(110136005)(6486002)(31686004)(26005)(316002)(186003)(8676002)(8936002)(4326008)(52116002)(5660300002)(53546011)(36756003)(478600001)(86362001)(2906002)(31696002)(66556008)(66476007)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHlVQmJsRjc0N3BpRHRsYnJzMHNBOUJwN0t5QUI2MG5kd1lEdEI4UHNoMVZn?=
 =?utf-8?B?TjVnQUJsaDF3blhQWUJXZU5wMEFtQUYzV1dKM1JSWDVKd0NGTERaTUdRVk5v?=
 =?utf-8?B?bW94UTQxc1FmQmhOU0M3d1VvV1ZxWGVLMUVRMEFtZjVBb21EWHpob0lzaWlH?=
 =?utf-8?B?TkNtNEhFS2UwSjBzVWlZTzhaWTNzM2ZtdkRSalZTemZrNGU5cjJRc3g0V0J6?=
 =?utf-8?B?TTlzenJyamJnaVF0dVFUeU9RK0Z2dXVVY3RJaGFuSFNmZkVqanZZaW95WTlv?=
 =?utf-8?B?cVVLTHo4VFBrekhRR1FCRk1sQm5ob2pBT2ZKN2RBVDRONEZkUDRrc0dWYS9M?=
 =?utf-8?B?WHFENFJxejVDQmwyQTYzZ1Z1bHN4QzY4NDhLOTZCTkZWT2R5VWZBSkNzeUVU?=
 =?utf-8?B?d0J2ZVNDa3RCeUVpZ3VnUS93LzhCRHhDWmE4a3QxKzBIeEV4RzFwdkRaTEhR?=
 =?utf-8?B?dEI5SHc0S0hvL05VVFQzZ0VkbHRkcnB1L3hKWVJZUVJJWlQ1VWM3aERyVU1U?=
 =?utf-8?B?a21wYnd5OWFKME9uQUFxVm4xSXRyaDdqWmg5TGtoQmpyM0lCUUJsNzFhaWRB?=
 =?utf-8?B?RWRXTWhmYVc2THNjNkxFR0VhNlFFc1JEU3ZqNzJ3dWl6cG5zcDBQbjFFZFRY?=
 =?utf-8?B?R1loMHBlMXdBamxENkZiYjNMampLNURGNFI2M2VMMTJ4OUZBa0hzREJYcGhC?=
 =?utf-8?B?bzhXTHpCWVQvU1hCZWZ0ZTRCZzNYbnVUVVl4U2Z1ZmN3SjVuYndpdEZSMjZ2?=
 =?utf-8?B?ZHV1MCtKcmlINUV4Q0lHOUNpdVI3R2pjZ2FHUmQyN2xhbnJQdVB1bWJ2UXVZ?=
 =?utf-8?B?VjJ1QmxySERhWTRCY2FrblJrdmZuVm0xcmZreVpxc3ZWQ0ZidHlGa0lDRTBQ?=
 =?utf-8?B?NGpTNEpMZWM2dmtjSWFEbHdDdnpQZmJQbDlCaXpiZ3RrbVduS3BBZlRYVGxE?=
 =?utf-8?B?WEtQM2h2b0dVUlpNenVtU3NpSGZIYmdraGxvT2wvRmFWT2pHbHVQRWdyMnh1?=
 =?utf-8?B?WERQNGtIdlNLQWtialBXZGE2YUVhK0RVamNHZ3Azc3I1SjF6L2VoeW9JcVFx?=
 =?utf-8?B?Nmh4ajhJVVhnVTVwSWE3ckVWcUpZcUVjVzhxUnFsQnVoOEg3RVNVTmRaQWhZ?=
 =?utf-8?B?SUdrT0pQMmtsRnFRMGdWOXF4ZEx1R2hGZU1tQ2lFdXJDWVY1cDY5OUlMS2ZM?=
 =?utf-8?B?SXFROGcxNXVxK25GM01oblJCVFIxQmF2bGhMQVJFaGR5ZDltWDFleXFEOFZs?=
 =?utf-8?B?NEtJMkNjRjltUjdqV3pEQnQ4SW5RaGlHQ29NMTVCaDFJRVBvWEJNcXF4b1l5?=
 =?utf-8?B?ci9QOVplRGYxdDV2SHJRL2E2YWhlWXExK2hPVHRkYk02c29Uc0xJQlZWRm1z?=
 =?utf-8?B?WmZkY3pnRWw2UFgzR3NWelJJTGIrVTAwVUtubFBEZ1U2UGlqbDR3dUE3R1pS?=
 =?utf-8?B?SUpxYjVsMm9lNTczeWQwR3NXSjExbEVYTUdvbUk1dEtCZXpnTzUwZmlaaExa?=
 =?utf-8?B?Z1E2RHE1eWo5SXpQeU1yR1dqVStTWFlpUVVldThxMkM5bGluOWYzMUVLdzVu?=
 =?utf-8?B?UTNCTnJLOUlLZU1QdVZtNDBYK3hKeDdlYXIxMWlsUkx1NW9CK0I5eVF0bWU3?=
 =?utf-8?B?dHl1TVlWaXA3L0xXeHdjWEN4MnBqU3ZtWnVWcFUvdHpLMDdYVzZyeUdJUDNP?=
 =?utf-8?B?N0tnTFV1RlNlTHdsbnFBUkZ2MlpaOW1CeXE2elBkUzNYN2VNWmE4RVZsTUV3?=
 =?utf-8?Q?cAdLpRet63c7IgjpZBRPTkijBH3u6F080xvxrRw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac8b058-f3d5-4aa6-b64a-08d966f657ca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 11:57:27.3184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jQ3XHiVwnIgWb6438DtOvHJjVmg5tX18TyEyuzWqeGInIHA96fPs/j7wOXMTmdd2HlBa/pggcDvfHxdbAqCdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
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

Hi Christian,

On 8/24/2021 8:10 AM, Christian König wrote:
> I haven't followed the previous discussion, but that looks like this 
> change is based on a misunderstanding.


In previous discussion I sort of suggested to have new DRM prio as I 
didn't see any other way to map priority provided by the userspace to 
this new 3rd hw priority.

Do you think we should use other information from userspace like queue 
id to determine hardware priority ?


Regards,

Nirmoy

>
> Those here are the software priorities used in the scheduler, but what 
> you are working on are the hardware priorities.
>
> That are two completely different things which we shouldn't mix up.
>
> Regards,
> Christian.
>
> Am 24.08.21 um 07:55 schrieb Satyajit Sahu:
>> Adding a new priority level DRM_SCHED_PRIORITY_VERY_HIGH
>>
>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>> ---
>>   include/drm/gpu_scheduler.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>> index d18af49fd009..d0e5e234da5f 100644
>> --- a/include/drm/gpu_scheduler.h
>> +++ b/include/drm/gpu_scheduler.h
>> @@ -40,6 +40,7 @@ enum drm_sched_priority {
>>       DRM_SCHED_PRIORITY_MIN,
>>       DRM_SCHED_PRIORITY_NORMAL,
>>       DRM_SCHED_PRIORITY_HIGH,
>> +    DRM_SCHED_PRIORITY_VERY_HIGH,
>>       DRM_SCHED_PRIORITY_KERNEL,
>>         DRM_SCHED_PRIORITY_COUNT,
>
