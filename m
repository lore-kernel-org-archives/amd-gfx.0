Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C33606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YX/biKTV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C31510E2AE;
	Tue, 27 Oct 2026 09:47:04 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C83DE10E2AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 09:46:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJFsQsxmfn9sIT11/39jIAE6lJHUExxeenhkSz2La9MJx4iuMj3iOzhdGyA+WRVQawoxauFHeB+rZbbpsBPKB1JxY+CVz0dddjfIKADiiNCmvchh+lp2iYcPhdBpzo0yqqk1X7icWbPR+/ewJROqQTgFEcQ3IjHLSNVbePapMEs92kd4Qkf+qHZ12xA4919IFzmzEZnQ1QeCQM7Bm6qn/N2Gdd5ycQoWw+K1XXa0bpBAaSwKE8wEcc1HpRUt/qr5RggLX8aLd+TcMLvuvMaFXTzYZxesimCGnKcZHR+2h1XF5kOE91J+THaNDjdEGBDY7aOcJDKTBp7FpJ+g9yMwvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LA2o8jJxJAUfyIrsTPkCyTcJUxE6mHJz+qaZkVQNGvk=;
 b=v5S7/NmSjBf/XAD7KKJJpxoPJvHH6oo4Z/AHDFIcYON172FU21Dr1nMtDqmySAlQKUQPrOMVe3eNT5LUd0nuX2t/+8YLh2jRX47KPrmtz+rV4hbVXfrIqkCCCijsLBipRjMt6ntSxGIfdKE7IC78dWria5igfMaR+2yF2hr6IpmfL5FQJNcliw/O2cTu+XIG9K6H+pQz5XCgT+PKMTkBtC2zJhRmpyBXHWAqYfH+FRnjnS+JwrryKwxXceWKKpxo7cTB+5K21BjlJSKmjqBEtu2ZZtlu1GdkktPmkfEYhvyPd3aqsixRT3bg08vvoT+MnUr93C9vnkS4LmlY1IxFkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LA2o8jJxJAUfyIrsTPkCyTcJUxE6mHJz+qaZkVQNGvk=;
 b=YX/biKTVbGHNLtgef8MnfzoJPlFG1mkKlSwqfAfdtdAlkMtUSexLS05NWnS65arvpzjpIm1c+g6ywxhkAZf5h8iWxdhink/kJ574nw2MIIGigyINFB4Q66ZzXOmmS4l1ZktJ0m7sp7wwkLeV798A/taWe4ti+DG1xxqkus+q/Nk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 09:46:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 09:46:53 +0000
Message-ID: <38975a37-ca5a-40b4-ade5-d7ab861782e6@amd.com>
Date: Tue, 27 Oct 2026 10:46:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
To: phasta@kernel.org, Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, Danilo Krummrich <dakr@kernel.org>
References: <20261022105443.60162-1-olivier.kaloudoff@gmail.com>
 <9c4f99bf-4bb4-4c31-9571-31f2aa57da38@amd.com>
 <d1db22be29151b65ac5054be1e80d36605ee732b.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <d1db22be29151b65ac5054be1e80d36605ee732b.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9a19fd-5509-41d2-4689-08df340f3afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|6133799003|261026121527099003|20046099003|56012099006|11063799006|4143699003|10067099003|261022105027099003|261022075727099003|261021121427099003|261021135927099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: Vm1h09yPFYrhSWUzUIEOL+ePfjvLo/OlQ3IoSLT6/Z8GihQTwlH/A/VuHujPRhHs4O5p06K19s7arkvgPdvL0aSJZT1Ld7aTSDtw3ScMW3Fb/nsvHcn7VGadzDMeIgOCne2f5amq0kFQrA6yxfG6WrKfdkcyFhDka7zs6Nqdau7206h1nG0u6mAI49a25kr7UXfGZm8qosmWAIDBKPC23uYcAZkOZIlAei+rooIKZzdK6Xugs0iTp+ROKZ7w4G0lIXqM+pLx4Aj3S9Nov9Wxe/Rfb8KcPvxpIeS0e2waKSGLhMim5mdauiQXG/llAClKFH8810qWi3H70AgqRkgNxHwQh6vl43lWtr8WoSAJgMYX86zg7KHThq8TbFwToiKHlGcmOq9zEDqOSt71+XIyCLb7NrnRUP2DKqV6qf6vW1cebzbJry2XO7klADwLaeYqBdGni/QZrxRv9yQ9ddc4ulz0GkCCu5tTiwRIrpWhevTOIUertEAapka1Y9cTEf5/2NcO8vg43ZOwvbAjqiwkG99wgMTSH25MC1NO7dd9D+s8OqHLdhKnjeXhbIcWntFV2MUogaffoHx27iPkrgj8fgzZLN8WTNLWyifhr+YGbOgArFJJ9ifi29Y7MshcKTzaEmqMY02KoazVCRBPSNZvI7u/Eis/7+Oip5rlpG4Q9T8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(261026121527099003)(20046099003)(56012099006)(11063799006)(4143699003)(10067099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021135927099003)(261026140227099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2MyMGxsUjFZTW1ZdXExc3JmQVA5ZWUyUlIzcU82dnZOd3pJYmxuK2FvUDF4?=
 =?utf-8?B?Vk9DTE1QZXRESHJxeTRFc3QvckZwMWc2ZFdZVUNwUWJ2ek5BNFpPSEQwQlBr?=
 =?utf-8?B?WDlwL2NCeG51MSs1N2JoSTZSME13b1YxMXdBNkJqMlRUN0ZJMXdxanN2YVAv?=
 =?utf-8?B?TWRucE05c0lxV2Ywa1JOVG8wRU1Ic1JNN2VwYmRIQTBMaldXS0pQaEJLbjZi?=
 =?utf-8?B?czFKT3VzVCtIRkdNL2UvTHE2b3FTOFlqM0psR3BUM3hLNlN5Ykl5eHdERFlJ?=
 =?utf-8?B?eGJMRWw4bFFqTVNGR0ZsbHlPRE15bS9UTW55RG9wbTZnMUVPVzhFamRuTVFl?=
 =?utf-8?B?YktPYTFZaGZzSTc4NGx6WDVzcE15bGxnVTFhVjhyTGJZVzU2UmI1RnB5Q1Zz?=
 =?utf-8?B?TEphUlg0b2V5UUJrSklRT0lLbGZtTVA5U2NrMkFqaUZsOVoxT1RyUWtBWCtD?=
 =?utf-8?B?UXg1WjFKQngzeHE5K0c1VHQyRExLSkJmZmNUYyswOSt1VHNBY1NYZmFhK1Rx?=
 =?utf-8?B?eUR4MG1BUVU1YXlsbTZIQXA2NlRnVW9HczBQa3lvNjdhanN1NHJKOTZ0QmRs?=
 =?utf-8?B?SDl0ODlpRHdqSWF3eWVPQ25OVGROYndTaldmY0JMNTNjejNlK2JMOUdERXVY?=
 =?utf-8?B?c1RuWGcwWWNCT3VIWkM1ZzlVRU45TSt4MjJtWmE5Z3FOVjNSSk5nWmhRUGwy?=
 =?utf-8?B?Unh1eGZZaUY1ZWI3R0dUOVNJR0xuWDZIUXZOQzhYWlkvZmFTOUtUTSsyYVQw?=
 =?utf-8?B?bHdjVTRTUno3dS91ZzFTaWJzSDhHdG12bG8xRTE5aVZQYXNINDI0TVlpakxS?=
 =?utf-8?B?VXNLV3R6NHlXQjNpZlY1SWxweFkwZmNndW9PYTJpM2pOTWw1NDdpODdNMVlL?=
 =?utf-8?B?TkdrQ011VFhDYzZsU1BOQWJ2RTFXSitaaFRMMGwzQ3AwU2xOUGVDbmZkS2Jy?=
 =?utf-8?B?YWo3NExhSnpVcnZnZWlweXhiSVBXZ09UTys4VVZJTTRQUDV2aUlCLzdwaHYz?=
 =?utf-8?B?V1ZWQ1grS0JLYWtqNEFVcFZMNlcvSWs2QmFqZzBVL3J0Zm92UkdlOVJkMk9B?=
 =?utf-8?B?U1BMZyswUzF3VXp2UXg0SUcrS25ZeTZKUXV3WU5BMnZ2K3ZRaHlQTmZwTlFz?=
 =?utf-8?B?NndXYVJ6aHNaaWNsd1BWSlpidmpnTGNaY0EzbXh5dkF4ODV4NkRnQzErUUtX?=
 =?utf-8?B?ZnBUVHErckN5TjhOcGgvRW5yL2REdHkzemhmb1JYakdSWWFGbFU0dFZmYWNm?=
 =?utf-8?B?Vm5EcGNDWWc0amhZYkVUWFBkdkRWZVZqMlVBTHBWcC9nNVlkdGVyUGxjaUFO?=
 =?utf-8?B?bi9HdkJ0cTBLTDVwS1F3UmkwSmNOazJxNWx4SitXclN0a3Q5S0pYRHJWOHkw?=
 =?utf-8?B?YkdudC9pYTFlN1ZlQXhla05wZGFHc2RkK0ROREZxSXhJdkgzU2J2eklMdXND?=
 =?utf-8?B?V244MG1YaFBIUHNmaGZVOXYvSE9HaUo0aXdIUVl1MkRVMHdHZUlwalVFU0d6?=
 =?utf-8?B?NmkxRUgxNlIveHN5K0EwNURWYzR4bjFaMFpZdnduYnhnd01BdmJ5c1pyL09m?=
 =?utf-8?B?SmdrSTZQd0tWVkEyMGROc2tOeWFBell4WDViTEE1d2czczMzOXNEQVQzcUhu?=
 =?utf-8?B?TmpVKzNBNWNQKzVJTmZJOWtxVjdoUmVNcHRuUFVEWGZ2Y1JaWjFVVGh3WFM1?=
 =?utf-8?B?NGR5RzZVMmpxQUduUEc4a2IrR1NqVlBsQW4xdlEwaWtEU05TbUNINXIzaUlu?=
 =?utf-8?B?OGJ3blRGOW83VUpNSDRpdkx2YXdaY3pmUk91bmZkVHJxaW8zSUpMV2wyUTZL?=
 =?utf-8?B?bmRGSnJhcmMxdktqWCtneVRBbTRWQXFQZkZ0bmxDcDlQa1VCcm1IT0tubEJw?=
 =?utf-8?B?RGpKVTNSaWFreDFHdXRUVDZOUnErUVBmVkZEMTJjNmlJRzk0RmJIc2N6RERU?=
 =?utf-8?B?QkdXd2Q3R2tlRzZCWEdVb0RQbGpUeE1jNlBvR3YrcmQ2RUY3UDJiR2lSNDZw?=
 =?utf-8?B?dVFZQkRnRW1TSzlFOHpQVDBlOXBjNXRWbG5ybVFQZjFySmZCaGtGSC9ibUFG?=
 =?utf-8?B?M3hhN1RyeTJJQ3FzTmxOYjRVUXB2M0UydG9XZXovaVFHTlRRUHQ5OXhBWWFr?=
 =?utf-8?B?YW9PdWJwUWJKK2loZDgvV2pXa2tubHgxdEFYeVUvVVRuR2g2cEIzY2lWTWZ0?=
 =?utf-8?B?dTBsaElOYVJ3bmFyQ2I1WXRDNTA2dmhROXVXazFVVk03bXhZUGcyaVNmclYw?=
 =?utf-8?B?cFVyUUF2WHNoMWdSaVlPTm5jSERieE1iQWZCVllhRnlaV2VSM3dqdDhHUU9O?=
 =?utf-8?Q?Zo0nTSSB2GhtPr8+7t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9a19fd-5509-41d2-4689-08df340f3afc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 09:46:52.9892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9BbEW7aEBkLnP0CZsYCweTyBX4l3sXh2gH7FxdrAX71jS+TCMV7TCRfXSamnWtG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 09:53, Philipp Stanner wrote:
> On Mon, 2026-10-26 at 09:22 +0100, Christian König wrote:
>> Hi Olivier,
>>
>> adding Philip and Danilo as DRM scheduler maintainers, just FYI on the technical background.
>>
>> On 10/22/26 12:54, Olivier Kaloudoff wrote:
>>> Hi Christian,
>>>
>>>> No, what we need to avoid killing the entity while KFD is still
>>>> using it!
>>>>
>>>> That is basically an use after free what you have here, only that
>>>> the drm_sched can point that out with a warning instead of
>>>> crashing immediately.
>>>
>>> The exact "use" we hit is the dying process's own exit fault:
>>> SIGBUS -> coredump -> get_dump_page -> do_swap_page ->
>>> svm_migrate_to_ram() submits the migration job on the process's own
>>> entity after drm_sched_entity_kill() already ran for it.
>>
>> Well, thanks for confirming my worst fear :) That is exactly what I
>> expected and it is essentially unfixable.
> 
> What prevents you from having your own synchronisation primitive in the
> struct where your drm_sched_entity lives in?
The problem isn't really the synchronization nor the UAF of the scheduler entity.

The fundamental problem is that SVM/HMM means that the local memory of the PCIe device (VRAM) is registered as "normal" system memory but in a way so that the kernel wouldn't use it by default for get free page.

So you got struct pages for the device memory very similar to how for example DAX works. On GPU access the memory is then migrated to the device local memory and the system memory copy of the page is freed up.

When you then now howplug the GPU and with it the local memory the data is from one second to next completely lost. If the data is an anonymous page the application will just crash, if the data is a memory mapped file it will eventually be tried to written back to storage. So you can even corrupt your file system with that leading to the system not booting anymore at all.

I mean I have seen hot remove of DRAM modules like 30 years ago already, SPARC was really big with that. But in this case you got a red led where you ECC error was, pressed a button and halve a second later the OS removed all valuable data from this DRAM module and it was safe to remove.

Hotplug on the other hand is a completely different beast because you don't get a pre-notification that you need to save your data. So hotplug is essentially incompatible with SVM/HMM.

What Oliver tries to do here will never work even in theory.

Regards,
Christian.
