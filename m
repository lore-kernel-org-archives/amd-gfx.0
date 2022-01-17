Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC425C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 14:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53E0C10E2D3;
	Mon, 17 Jan 2022 14:19:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7832910E2D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 14:19:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FemCEHcX8oXhLXG7JjsWNzeIrmqGLKrE/MHa+CkXGlWSGaTkImkr3Yow3ylc1IdEOIkJFrTa0ZP/6QaNJSysYWCX3s+dpfvYWjHcNIuhZELNh5KX3uVl5OztWRlKu9JLi5lVoSp+YFitPBNLoUl/i5dPpczMIkrDItOyvtERIuHpUf84Smw4DjhbcQdO9tZmF5aHS2d03jDkxCj7vZZOvb6FrWKDCaKds5Zg7qrVruj3TwYEJbFAD5ugtCYR3jRMkpEXItCVtwdzRfGrJmAPTx3kavzcFRiG/aLu+ZfQjwmgXJwGcC2ooxwnfjwHSTBagNs7MttjABwlr9tUWhIkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wM0JnU+KyNW+WZZgePIEwcDy/BPM3QY4e6XO75K/I/k=;
 b=oc6kYp+PEBllsQ869MZm5KLfin09LYw3fCO0TyVLRYqnjJDjnKZ22vbfE+bzekTr6VWfQ9v4t2FWVE68buOH+fzr0J6Vv/YIy7l2FtT1UNyWPKQLKlIBcrln4IaYnTON7U42EAd2b1uDctJCLT15jOvKY56Mu3vH1uoA0dhVwO2cK6eNHZsKcE4P20zsbCMzJFfQ3QeLMjs39ypC5Q4W/tsYQX6RLulhk2mFsBUs7sux/rnW1ZrDFqUDt7Q/t4SKdb7LDv440OJkmzBqOJYiT2ALZ5T0BG0XPB652pEGTAKPV1D47PkK/N+CRas83jQ17aXg9YCVRdJ2Fk+BI8vFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wM0JnU+KyNW+WZZgePIEwcDy/BPM3QY4e6XO75K/I/k=;
 b=OSUJas0fkIpG2Od0JjLnxO1hNTYJ/UR+bcMYyNzUmOaMUjbn3msVIqJmfxB9uJ9oJT+P3XgHRbX+LdGxOnF1Pz4MM7l3FLRGjzL5pog66hY3TxWpnWzEFojv1I43llneBLAOSpxRsh5ZP+EIWR5ijnGc4CLf4C7zH4hKKh6YTbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by BYAPR12MB3368.namprd12.prod.outlook.com (2603:10b6:a03:dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Mon, 17 Jan
 2022 14:19:49 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::e8ac:d90:95b4:f70a]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::e8ac:d90:95b4:f70a%4]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 14:19:49 +0000
Message-ID: <98202e9d-cefa-8874-8a8d-58ec512f80ca@amd.com>
Date: Mon, 17 Jan 2022 19:49:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Sharma, Shashank" <shashank.sharma@amd.com>,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220117063343.27896-1-Amaranath.Somalapuram@amd.com>
 <12d7152f-3274-a250-e25e-6144cc9cc1e2@amd.com>
 <DM6PR12MB3897D77C82314BBBDBE8AF93F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
 <5568c4e1-7bc5-cd7f-d6d7-92a4f920c40c@amd.com>
 <DM6PR12MB3897D33226DBA88264B5BBF8F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
 <62372e77-31c8-211f-0d9c-01a0f880badf@amd.com>
 <779d4778-6b85-2769-f169-f5f9e956a671@amd.com>
 <10fe91c4-9078-8937-5dac-0625d38c2ea3@amd.com>
 <7a082b06-179a-22dc-e176-3f6d46a1deeb@amd.com>
 <8ffbf71a-9c62-b153-bf52-a88e7bcf91d3@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <8ffbf71a-9c62-b153-bf52-a88e7bcf91d3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::30) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 945008de-2bb5-487d-c85b-08d9d9c46bb1
X-MS-TrafficTypeDiagnostic: BYAPR12MB3368:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB336863A716997B427E9B78BEF8579@BYAPR12MB3368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: he/ld8/zNGIKq5Z6/+xdEIdRgUIJWV3DzEvgGvsm+xc//bI4wUmnNolDcohd9s1AvfCsvSVH5AuFFbQyH4vwBLQmP6MBHVYJ4ORtk9V9nZb9uzRsOPaDVaIQKnNvtaCTlDDHL1ZV2YxTod2cF6iGn+xce6MWexrVXLHQt+fkjbKiGaq81sxkZkGNH5XtABGGC9hR0sKUDET9Hvb59uC59CYQ/HXWVH02Koe/2zXGWcYbsKXTW4c5as2vltbDW5eEMNnh0rfFDSZUTPfm6io46w/81nPSoMmIsUpuFpyGREWdnNk/IpcqIx+ziYHtAkRe+A9XfcLyleEZGnRTbevosfZIJ2HVSLdcMsgtsYEy+FEz4HfiLjsyMGUAWTzGmR8k21GloOZh+DoBdBvPi26SJQ2smhV/UagcpME6ffz3a7WoIoQgS0EvWnJ06yOSQKq4VnphwQeNg3kRBILG36hDSHd0ckO0gEb92EDubUcPY1Pb9o32tzu9qlAj1mjTd00oFKfIAFpHii1fTgsNnhzsX15Bteob2YWlt1FTu83LYwdkp6O6yjTpTfDIMwjdwJZ8hBcxlweC3RMfUWhOrzq5XpbcRP5P/Qfwdgd5USqkVSxAt8WTmHH2nhsbtzgda1r8roOFcibaksyhjHc5xvcsisQk7UayO97GTX1mHa88aREH3SWQSnPlcJvQaymOyDAPGfIOFbpd6zrpXmcvliLjAPmsXk/4ckpQKF3OSkzZ+yKXcV9MZdTP+X60o0/W3mMS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(83380400001)(2906002)(6666004)(6512007)(4326008)(508600001)(36756003)(316002)(66946007)(66556008)(110136005)(31686004)(5660300002)(8676002)(66476007)(6486002)(186003)(2616005)(31696002)(6506007)(53546011)(26005)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUlOeUpsOS9IeTJzbFY1RWp5L2RMeVB3RWs4blJOKyt2a3htbzNmNlRTWTEx?=
 =?utf-8?B?V1FIa0hlM2dyM0pIejVtSmhUNmhrQ1poZWZMRTBTb0VxQjloWFk2cjlOeTNN?=
 =?utf-8?B?RXVsUlM2a25zRFdEWlVncFBkdGFHemtTaTlRcXpJaXQwbkxsLzAveVRwSjlG?=
 =?utf-8?B?OFdFdndpU25DVlo3emtubVFLdWNwT0RyYU5ZTjYwWXFwUSs4ZlZuOUJ0NE0v?=
 =?utf-8?B?QUdoTEhyUmNqQWFsbGp3Z2hnWFlNdi85T1dnQjJjaStJY0NieHYzZ0RrUWRr?=
 =?utf-8?B?YnRsTkgyekRIdW9XKzBLS1l2WGdaL3dsUktKNktDQlFGTE5OSHhQSStDS0dk?=
 =?utf-8?B?S1ZTemJOVlF2UWoxdmxVUFIxK1lwTFBURmlxNk9GTGVoNzNoVVZFcHpiWnJ1?=
 =?utf-8?B?NmMrSnlxbDZ4bjNyUWVSTit6OHFOcnpsV1ZFbTFlNnhpb3NDdTRpUkw0Zndi?=
 =?utf-8?B?emYvVjZhUGhkOGRTZzFlcUZsTGx4NVV5STZvdEJuOVN1V2RCT1RlNURkalR6?=
 =?utf-8?B?eE8yVG0rOGhFWmpzSE9acVhSZmhVUE1RTEx1c2tLcU9WUGFFcm52cGNxWjZR?=
 =?utf-8?B?WU1nbllFN1gzemw0OWpmOVowbFhuanNZblhtbmVZaWJOVW52SGljdWhxU3hV?=
 =?utf-8?B?bXFCNVhuTitiZGpwM2dVSGtwZWtWZFdnMklyUnZlNXdhQXFkMmNrUkFIS3dF?=
 =?utf-8?B?SzBBVVVvNkQwaC9PRXFsVGtlbExGeVMxSkZPTmIwZ1EwM01PVnNjQ1RBeUdn?=
 =?utf-8?B?ZEg5cHFhWjM5UlNpaTRhUmZ0U0F6NW9PR2hFRHBuWnF1ZVFBZVRVMStlWmFv?=
 =?utf-8?B?WmlVeTdKeHhIRTlkOGFxSndTS2VDWlZCR1FQNEVOSGdtdWtPMzY4L0VGOTha?=
 =?utf-8?B?dkpaT3ZlcGxJNjhnNlFpQyt3ZnhoTEx3MjJrQVpqYy9hT3Y5dE5VQy9hVUZn?=
 =?utf-8?B?Z3RuSjlqZkhIK0x6aWd3ODQ4QXFpZTBjcm5KSkJQMCtnd0VVKzVsNnhDNlhn?=
 =?utf-8?B?RU81T0V5S1lTeHJSTUdUL2JHVTVCNG0zWUlsZjNkaTlNVGN3Mkx6SUF3cG8y?=
 =?utf-8?B?SitZczBnSGpKOHBLTjZ6SlhFRkpLK2Z5amFNeEhpRTNYWjBsVHErRDVXSlhY?=
 =?utf-8?B?aHdkeWRjRGRBVUlNSWY4c2tsRkl3ZFd4UERaREdmdXByRFREQnl6RGxoQzda?=
 =?utf-8?B?RzBjZUFPWUNUNEFxYzRzV1dEM0FPZTFEdWwxVHVtZWV2Ri81clhIelVreE4x?=
 =?utf-8?B?OTNsd0Jpd3BXTnhnT0h3ei9hNUxTSUNBYWdpYkljMkpEQ2lXUk9yYUlLcWRP?=
 =?utf-8?B?NkE5czlYOWVzVlBRYWxidXZjbVM2bFRyL08wYllFS0xaNzFvRktRbXdhLzRN?=
 =?utf-8?B?T3lQUG9UcVUvdTIvbkVLeU81UGZsV1dUWkxBN0trQTVQc09BVWZSVXVOK3I5?=
 =?utf-8?B?bmUyazZDbTIvQlV2RXZvaU85VFNaejZnOFdqUlpKSXdEODU2d3AzaXNQRGo3?=
 =?utf-8?B?NVFQa0ltb1BCVDN4dWp3elhtQ3NFZ3dLUFFYUVc0K2RicVZySy9nNGpIaFVr?=
 =?utf-8?B?Z1BpbXRhZzBzTVpFUUpFR2RhQ1drenFvRTNRdmw0NlZQQ2xhS0EvdXVaVFMy?=
 =?utf-8?B?TEh3THdRZ1hHWjllbnUrYzJNK2NjTVRaNWFiZ2FNWk9KYVlwenk0blYveVh1?=
 =?utf-8?B?RUxPVmwrRkZBWDFPU0Z2RmYrNEFZWS9OOFpwaEtUOXdoaG8xM2FROElBd2x2?=
 =?utf-8?B?OHpqZnp0Kyt1aW9kcHhPUndpVWY2WEtKYzdVSzZVajIwb1QySkgyRTRxTXZy?=
 =?utf-8?B?WE9aNjNkbzlGcUZNRWo1UVo3RE1mV2F0VkcwQmU1aWp0bUNZQ3JGWFl5eEtP?=
 =?utf-8?B?QkZ4TzI2NkNERnplaG9kbFZiNmdQWEdpN0d6UXhDTEd4SmpJUWhYTi9xQW96?=
 =?utf-8?B?TythUFAyMVhPZi9jSDhVTVJSMDBlNDJYTlF6TEdVbXVqY1NEYW81czl0UWJa?=
 =?utf-8?B?UDVmYWJzMWNBbW1pNnFtZXA5N1pTbzJvSWZZMmhNZmI5SnhKZVlUaEYwZTNC?=
 =?utf-8?B?Y29RWjE2aU5ZM2xzYmU0OWpXdU9IT3BOd2tYUUdQZ0k2cGQvbzBaaTFrRXk5?=
 =?utf-8?B?amJHZXZ2M0dzLzdxeTg5VGViOGkrUkU3TlBweHVoUkxVazU1dkRDdXVSa3VS?=
 =?utf-8?Q?Agzsw/JbBf1SKIAAZNRXu8U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945008de-2bb5-487d-c85b-08d9d9c46bb1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 14:19:49.7328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSDa3joGWiOzKBTsT+8sC9edhF5TtxoDaIzXr46Ie4A1I74iLf7fV4iGVNSx3qvJsP//tgLhoW2fSUsfNu0vYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3368
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

Hi Christian,

if sending udev event during reset is going to create problem, we can 
move this code from reset sequence to re-int  (after GPU reset succeeded).

Regards,

S.Amarnath

On 1/17/2022 5:27 PM, Christian König wrote:
> Am 17.01.22 um 12:43 schrieb Sharma, Shashank:
>> Hello Christian,
>>
>> On 1/17/2022 11:37 AM, Christian König wrote:
>>> Am 17.01.22 um 11:34 schrieb Somalapuram, Amaranath:
>>>> [SNIP]
>>>> Any suggestion how we can notify user space during this situation. 
>>>
>>> Well trace points should work. They use a ring buffer and are 
>>> specially made to work in such situations.
>>
>> We are anyways sending a trace event with data, but can trace event 
>> be a wake up source for an application (like a tracer) ? This DRM 
>> event is just to indicate that reset happened, so app has to read 
>> from trace file.
>
> Yeah, that's a really good question I can't fully answer. As far as I 
> know you can filter in userspace what you get from the tracer, but I 
> don't know if you can block on a specific event.
>
> Christian.
>
>>
>>>
>>> Alternative would be to audit the udev code and allow giving a GFP 
>>> mask to the function to make sure that we don't run into the deadlock.
>>>
>>> Another alternative is a debugfs file which just blocks for the next 
>>> reset to happen.
>>>
>>
>> - Shashank
>>
>>> Regards,
>>> Christian.
>>>
>>>> Regards,
>>>>
>>>> S.Amarnath
>>>>
>>>
>
