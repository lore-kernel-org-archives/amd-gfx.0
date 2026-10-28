Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A82606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dGOT6wQ6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B7A610E5DD;
	Wed, 28 Oct 2026 10:25:25 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120A210E5DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 10:25:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlNjkFCVqHqr6Suop6Y2crgMcCAGgLI/3deu/6XTHIP24SnoJJyEQy+UJRVjPciJ8uRHTfNDrYxajN0OpI9hurG9304O3gfL3YxIkFyUw2cNAhfsXErSufndAROHTGWmcVLsnsIWSeNpGOhwn4ysHm7eHlwK3YtmmAJyIeBwM3LcTaB8YKQSX0AguL8VSOVzn+eFYzkB8ZE/yeCPe2iU9EOQ6eNnppEyWqLaUcTJN8XYLPLSbC+ols6knQuZBV8yTmyY5EYkkOA2YWgw4qpIHYSw5rKH2nhPessZw+umDS9E6TWk/m738Fw2vdcTJxDW+E9MMzrzKiiR7YsEnmqx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swGHtd3NMVn0r2kowPaMAO452xuBqaK3+zy9siPzycI=;
 b=Z/mYGu2Mm0WVUmp4cykBK37wu5d+6/A6ennr9NjjeH6079HVoZf5NfrfJBbc/b0hOXN1NMTzWhv7Gaopi8GujNz8bs8I4u8UhCEqAt7NYt4OTIn9Wyl0buI0Ex2Vne6bwZAOCJ1tTLEGmRr40tjoqDQFOND2rCKUK4kAB3Q2x/XL2YVXLcQdjvt6SeyhQyWWGXcLyYm0195gba45IYK9xt/CYqFlKOrlUHiSCY3LgqlIPNiyNlTmCOwVkfVtFoVMKeR9COV6gaJispFDUdeLJrR/L2SWAHZq1hNOVH9HQ2gIyOv55sk6XXd3cG2Cn+Fff85ivNugZzasF3HSXf9sFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swGHtd3NMVn0r2kowPaMAO452xuBqaK3+zy9siPzycI=;
 b=dGOT6wQ66zzwufaaohje3X9dA94PAoCrCLfRTVl7xV5iewOqVWaCt5amTZ3VW0oQ26f4/WjVyhJCI4n+hEXmi+a9/YOARvKg/YCwFp0qiXiYSqBatzToDVekIOF/8Cs9SD7IJMvPGFiZUMD/slwkpxZ96f6ZV8gSw1LhpBRKKjc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 10:25:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 10:25:12 +0000
Message-ID: <822a3d7f-6342-4a4a-89c2-2ba09c56495c@amd.com>
Date: Wed, 28 Oct 2026 11:25:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
To: "Kuehling, Felix" <felix.kuehling@amd.com>, phasta@kernel.org,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Danilo Krummrich <dakr@kernel.org>
References: <20261022105443.60162-1-olivier.kaloudoff@gmail.com>
 <9c4f99bf-4bb4-4c31-9571-31f2aa57da38@amd.com>
 <d1db22be29151b65ac5054be1e80d36605ee732b.camel@mailbox.org>
 <38975a37-ca5a-40b4-ade5-d7ab861782e6@amd.com>
 <eb350cb1-9d63-4075-91dd-f321ccc26199@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <eb350cb1-9d63-4075-91dd-f321ccc26199@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0352.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7aa4c3-1845-4038-11be-08df34ddbff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|261026140227099003|11063799006|4143699003|56012099006|261026121527099003|261021121427099003|261021123027099003|261021135927099003|261022105027099003|10067099003|261022075727099003|20046099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 07XBFS10H5dU2O83Rd3ZtoninDMlv/8dHBKujvl3qcLG3Fz4vh2Aq6CRvH+0QaTEvjUER9rmgeS5C99xMfBbzDjevMTFJ7UZtDduncKroMyue10Lx5ya3HWxYATNdXQCdvV7Z/+3zJIycDifYffuEOREKl2XgU6PfWBCcZTup4+dPXV+RGC9lld5vWcdd6DrpnaG67nifIUVrdI6Mu2NoF5XWsObuPL+3cm5LtRPkIIakxTfXomrXB5qKqUkG+KEypYXpxGN1TFd45u2zs1gj8woT3uVfeN0b3LdFcsOCZYWttSl/0C2EfKyzgfvh5Sn0k8oKgJFn8xy0v76YGjb9CttMkXhTijH1G1Utmkf8OnXBIodbjo4flth6fhAv9Gg9QwotRhc8Qydabo5slHmn7OGnh88oGpw5jO6OQ8pnOKwuwM17m29VXrKEZXN6iopxCgnJc//MaAfl9SHfZhk+1ZRo1+ihgmjW9FN76I8V1NLjyZwJt5TDOOhMJdwp48Kjk/nE7q95M4tMSJqG2fZlDwfmwQxcrJkke5F87DB8a5Y8aJ8hdA9lzGo7AIq+fAXlGbkjusPA0IqMnMo9Z4aJPxDp5GQsqVl/pZdc01QQAH8v4fZCkNGfjK1A39xb6fiCpS25xDWnQmxbcO//DAw6lf6WJv0yJ3Bg10ughpNZ5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(261026140227099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261021121427099003)(261021123027099003)(261021135927099003)(261022105027099003)(10067099003)(261022075727099003)(20046099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnBnd09pM2RWQ1lUWFFYOThmY1Fqd01DNGZmWkdQeklPS3k4SDZ3MWlvYTZa?=
 =?utf-8?B?bmZBRi9qRmlCTHlrazdaV01GNS8rbGU0OTlRa3FPVWRFZmh4VVlEZU1qT2kz?=
 =?utf-8?B?UUthZk1tdmpWRFpaYVB5cnduV2JaMGw2TDNCdk12eWZJTlViUW01aDlhRk4y?=
 =?utf-8?B?TGYxTFZ0ZmxxVkpQQWlicEFuYmtYUkJKVDRMdFYvM3dlS3lsQmx3NkxTWWEv?=
 =?utf-8?B?VXFkN3BUcXYyWVIzR0E4blduanJaZ0xHSFBmMW1VeHBGdmw1WFZ0dHpaVTRr?=
 =?utf-8?B?OGE1UGh5dkcxMnVZekZ5d2tFSExrVVZUUUdPMDZmRmlITTYyVEFVc0ZYVnls?=
 =?utf-8?B?SzZrOTV0ZE9UcmxtaldJN0l1Rk01enlwNnhXT3pLNGozcnJ3NFRsaG1zazZT?=
 =?utf-8?B?VXVKL1RJcHZQUUlGUVhwMjIvM0Z0UG1OKytMSjdHWE1QTDV0N2cwWGViYjBi?=
 =?utf-8?B?TjNsMWpvVWc5NXAvZDUxTEdNbnYrQ0d6d3U4MnhLajVqYW5HS0NveWVlcDNz?=
 =?utf-8?B?MWwzNlJFL29pRXZhVUtQeUR4aTR0MkpQNHZSTGFScHkyaThqd1ArenRnaU9r?=
 =?utf-8?B?Tk5sdkl3M0ZkUXM0dmMwNGpzOFJ1VEJhMDNqYlB1Yk4weDV2YUhKMm1JbTcy?=
 =?utf-8?B?clk2NEIrWHhlaXJOZWdkZkV1cnNsci9KVkxGNG12WXhhbWhkRXVkRFJSdzdo?=
 =?utf-8?B?NXp4MHMyMHpEcnNsTEp3OEtCNzhiQ1ptWG81ZHVMMWJhZENKQzBDWmhYOWxG?=
 =?utf-8?B?TlgwajNkQnhUbncxenhwcHZVMHRXdU5DZlVFcytTWFlwd2FJald4aHllbGJj?=
 =?utf-8?B?dUlGSmRCT3hVRHZNTkdWbFNFOHNpWk93NnFaazFPdFhtd1RrSEYrajJQRHdy?=
 =?utf-8?B?UUdHOUFwSVRocjNoUnNoWm0yRFBaMkZSOXJZNXk2L2o2elVlRlh4dk1Fekk0?=
 =?utf-8?B?eE1YMGEyUWRFaExtWUNwdEt1aUNVZlJ3SmNxcHhVSE5NUGtueUdSTzZYakh0?=
 =?utf-8?B?MWV6K0t3bThUWkhKbDE5QXU1cTdYdnBTMzl2TWFqZEFpSWlDVTJ2ZTdsR2Rh?=
 =?utf-8?B?RkN5WTdGT0N4YlU1SWlNbk5sR1NHZk9FaVhnTjlaMklQQVlNTDUvc284SVNi?=
 =?utf-8?B?dFdxZ0pRa2ZkQzNNYkdVS3g3Vkc2TDNVRnRrSElyVFJmRlAzRWRGdU9QMG1a?=
 =?utf-8?B?OFpwelBwbmlWM2NPQjllM01ickNWUVZURmdBWjNmV21RV1hlb3dabGdUMFFQ?=
 =?utf-8?B?amdaVFgvRXk4T0tDbjdwNmVjMUVyTXQydHQ3aEI2RFhaVW43dHBQcXFkditU?=
 =?utf-8?B?QjkraTlXdFhCMGEyOW9pUDNwSG51NzZDNEdOcm5OZzlURzJ4Q3NPMytjbmQ4?=
 =?utf-8?B?Z3ozN3duYU56V0l1SWRMLzkzNGdOQUtRTE54blArY3VMdUMybDJLYjZYYW45?=
 =?utf-8?B?ZERBbDhzcnlxWFpJUEFjSG5BQmFSZnNaL1l0Z2IvTXZEZVRLUVZVKzcwVGRz?=
 =?utf-8?B?QlhjR2FwOGZEek55eW9ZWHRINFhvcWdHVmtBbmRvTUp2M1dCVFFhQVZtdmNv?=
 =?utf-8?B?K2tTT3pnM0pja2U2VnVVUnhLZzNDZlREL0NwODcxN2cwMkp3TmNaaXo5ellm?=
 =?utf-8?B?UzhuY3lCNVpkb2lLM1grdVc1elhEcTloeUNUQXFKeHFhVG1PcUlSU0pUOEZ5?=
 =?utf-8?B?WGtGOHZNNDY2bXdBOGREVTZLZ0J0SE9sZ05FMm84aXBYN2dUZis0dGQrTzZT?=
 =?utf-8?B?SHNJNXVXbTR1M0E5NC9ZbFhhd3VUVVNsQk1GUHl1dmhQSUllTWtXdzhBeVVx?=
 =?utf-8?B?cGRlaFlPendPSk81Z1lFR2w0MmpFbk5oQ1cvcmprbm1GRDdFaEtuYmlOakRR?=
 =?utf-8?B?TGkxeDBzY3hWc3BFU3Q3WHh6SjNjUjhTNVpzNDZ2enFyT0lJZ1NWYjEzdkU2?=
 =?utf-8?B?N0paU0h3S0dRb0lyUG1ZMDRsMXpISXlURTJCTU05V0RaLzhQYmVwcC9JL0lr?=
 =?utf-8?B?KzQrTDliQkJvUjVKSnNLNjAxcnJVY1ZlRTVFTWxaYVYxOGIwaG0vdE5rS0dT?=
 =?utf-8?B?ZGx6VzdBeE42bDZ4ZnhQMFlzNlQzZHhCSXRqbDRRTVd4d2Jjc3ZPWCtpN3FW?=
 =?utf-8?B?VVhVbGVwbXVYMmp3K2Z5cjF3bmtuMGVvenMzbWhHTWY0cUlDMk0rU2wyVHhY?=
 =?utf-8?B?cm9JN2QzZWo5eUI0Z1RGRThHdDZ4dDY5ZFVjdlR0dnExb01Od3NFVVgvSlhO?=
 =?utf-8?B?RWFYTWtvb2lNclRnc1o2VjYwSUk5WHEvZERXREJNeTMrSzVWVlIrbEdQSnhK?=
 =?utf-8?Q?BYRzH9O1bUKG8aCS6t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7aa4c3-1845-4038-11be-08df34ddbff7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 10:25:12.5248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3AFaScO4FZv5eUWjaNvddBtZ8swdQ0Eebu4Sv4YJCNkuOhSC4bxMtMPZY1O9aMm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 16:54, Kuehling, Felix wrote:
> On 2026-10-27 05:46, Christian König wrote:
>> On 10/26/26 09:53, Philipp Stanner wrote:
>>> On Mon, 2026-10-26 at 09:22 +0100, Christian König wrote:
>>>> Hi Olivier,
>>>>
>>>> adding Philip and Danilo as DRM scheduler maintainers, just FYI on the technical background.
>>>>
>>>> On 10/22/26 12:54, Olivier Kaloudoff wrote:
>>>>> Hi Christian,
>>>>>
>>>>>> No, what we need to avoid killing the entity while KFD is still
>>>>>> using it!
>>>>>>
>>>>>> That is basically an use after free what you have here, only that
>>>>>> the drm_sched can point that out with a warning instead of
>>>>>> crashing immediately.
>>>>> The exact "use" we hit is the dying process's own exit fault:
>>>>> SIGBUS -> coredump -> get_dump_page -> do_swap_page ->
>>>>> svm_migrate_to_ram() submits the migration job on the process's own
>>>>> entity after drm_sched_entity_kill() already ran for it.
>>>> Well, thanks for confirming my worst fear :) That is exactly what I
>>>> expected and it is essentially unfixable.
>>> What prevents you from having your own synchronisation primitive in the
>>> struct where your drm_sched_entity lives in?
>> The problem isn't really the synchronization nor the UAF of the scheduler entity.
>>
>> The fundamental problem is that SVM/HMM means that the local memory of the PCIe device (VRAM) is registered as "normal" system memory but in a way so that the kernel wouldn't use it by default for get free page.
>>
>> So you got struct pages for the device memory very similar to how for example DAX works. On GPU access the memory is then migrated to the device local memory and the system memory copy of the page is freed up.
>>
>> When you then now howplug the GPU and with it the local memory the data is from one second to next completely lost. If the data is an anonymous page the application will just crash, if the data is a memory mapped file it will eventually be tried to written back to storage. So you can even corrupt your file system with that leading to the system not booting anymore at all.
> 
> Migration of file-backed VMAs is not supported by HMM, as far as I know.

That would solve quite a number of problems, but I don't think that this is covers all requirements.

On demand loading of files into device memory is one of the major reasons we do this in the first place.

>>
>> I mean I have seen hot remove of DRAM modules like 30 years ago already, SPARC was really big with that. But in this case you got a red led where you ECC error was, pressed a button and halve a second later the OS removed all valuable data from this DRAM module and it was safe to remove.
>>
>> Hotplug on the other hand is a completely different beast because you don't get a pre-notification that you need to save your data. So hotplug is essentially incompatible with SVM/HMM.
>>
>> What Oliver tries to do here will never work even in theory.
> 
> What are we trying to achieve here? I think Olivier just wants the kernel to not hang or crash. It's obvious that any application using the unplugged GPU will die with a SIGBUS or some other catastrophic event. It doesn't really matter whether it used SVM or not. So if the result is that a migration of an anonymous page from unplugged VRAM back to system memory fails with a SIGBUS, that's not a big deal. That application was going to die anyway.

No applications usually survive a hotplug event for a GPU device. This is absolutely mandatory behavior for display servers for example.

The documented and implemented approach for all drivers is to return -ENODEV from all IOCTLs and redirect eventual memory mappings to a dummy page.

> But we don't want the kernel to crash or panic if we can help it. And I don't see a fundamental reason why the kernel should crash.

Yeah that's what I agree on. We should have a clear destruction order.

But another major question is what we do with SVM mappings which we can't migrate back because the device is gone? Just allocate a page and leave it like this? That will certainly result in corruption sooner or later.

Regards,
Christian.

> 
> Regards,
>   Felix
> 
> 
>>
>> Regards,
>> Christian.

