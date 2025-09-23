Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C7CCAC5B0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 10:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2553810E0EE;
	Tue, 23 Sep 2025 10:00:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZTvmKQCT";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012016.outbound.protection.outlook.com
 [40.93.195.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A79C10E0EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 10:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffsQQFnH3QkRsBEsT0qPg1zz6vxzELSotN4qmcbXbLCEtxEzxUYKUulGAqHvKH55mYyUEgnAzFYXN+LRXUOK6T4pgYwLCJp4gSif/+lW7bsDv5NXn0p0mJk9tO3KWTlz2Sz8opcaMacDMOqKrJVUDiA+1iaUIruunQX0RQGhx5XtvUkDxZ1w4YtEwz3C03HBaPeEXg32NwkXt+CEs1pjbnDWBlaa+t408j5H7mA6fMOg0WDfAcOBLMPLeGqTMwl702JWBfOmiTJAhvy9u7OHZHXxgqaGYsluAjSryF25IkFnB5sxJfgsR/pelqwdnUpF5sXP0JubdE0LZGCru2cWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39OGFmC8ObFA8513KnyrCrp49t6Cu3eRkx04kxdGhi4=;
 b=mmxGAkLnG/3hnPoKUIhCCTUWJ7sb6i98HGm44Pt+hEJ/gAv+xLKtiLiMei4r4AgOP8vNgBIJxhQ1xEJl7I1/3quByZBRBkOyN0OUIEUQUtOQ1KJ9ngnWA8uFD9PVsQbWdesZIWK/gvWJpqYpCsEN7KKvcEcNDK0uGN7Y0F1Ga45OtEpf3uD1ntyGUfIw20kzhzkXbrcEMWPnQ4tQjXci3VmuYdNGBpP3QJaWjtHmS6h8FxysvB/wDd8i4vnErE+8B2er2xcpNZlaVtNqf8Gf8Hb7Q9wCWgp9JO0BZKoyc3eoh/sCHYLFZIy8ZucSlgVqmeuMvqCOJHcnLiLHLlRwSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39OGFmC8ObFA8513KnyrCrp49t6Cu3eRkx04kxdGhi4=;
 b=ZTvmKQCTUGi26oSoKatxCr/q3L9tpi8p2dR9L91D1RS6nPtAglNJLJKbwKOufJcBYEwKuSbDPyGiweC+cOHR2AFAEWwKIzJW8OtwkWyKzaV53WxCyIEy1CUNuFsS+Uo7iQtYGLod4w/TUW/03AE3H60uEBkqjPPlSbxl3oKGJpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11)
 by SA1PR12MB9472.namprd12.prod.outlook.com (2603:10b6:806:45b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 10:00:38 +0000
Received: from PH8PR12MB6770.namprd12.prod.outlook.com
 ([fe80::5da3:7c42:3309:eb4c]) by PH8PR12MB6770.namprd12.prod.outlook.com
 ([fe80::5da3:7c42:3309:eb4c%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 10:00:38 +0000
Message-ID: <b0436b08-b6ca-4159-9798-aeb537ae831f@amd.com>
Date: Tue, 23 Sep 2025 12:00:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix pipelining jobs with timeline syncobj
 dependencies
From: David Rosca <david.rosca@amd.com>
To: amd-gfx@lists.freedesktop.org
References: <20250917095939.41615-2-david.rosca@amd.com>
 <c1f6d69f-7f71-4d6d-b475-fe22f5316ca3@ursulin.net>
 <74ed415e-2938-4b3c-ab68-4b074d35e4ba@amd.com>
 <31124176-c73b-426d-bb35-793161b44a68@ursulin.net>
 <a950349d-69e1-4a7e-bd99-d9d6a1528533@amd.com>
Content-Language: en-US
Cc: Christian.Koenig@amd.com
In-Reply-To: <a950349d-69e1-4a7e-bd99-d9d6a1528533@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0226.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::26) To PH8PR12MB6770.namprd12.prod.outlook.com
 (2603:10b6:510:1c5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6770:EE_|SA1PR12MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: b38a8485-323d-4364-6ad7-08ddfa880bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWQ4U3FmK2tSdFVTQWJ6R0lCT3FPbWRqdlhqNXdDU2VRcW9Zc2JKRUEvTzlF?=
 =?utf-8?B?N0tka2ZlU1h2bzIwMGFGbGM0STJCL0xHWklSQlhTdURGTlFmSGJGbHRHaDFr?=
 =?utf-8?B?ZGFlMTQxZElUQU9oeE4vYVBBdGlIbjNGQ3FraDVGdERVVFBBcU00aXRIeUl6?=
 =?utf-8?B?bUFWTU55QU9GV2hFUDEzOUJ6NEFRWVl1Zy8wWU9yUmhNTDMrZTRpQStPMVo4?=
 =?utf-8?B?V2FNUWNpUXBxcDlnK09TMFZYbXRZVnhoQlJhQnZ1RTk2dklWWHJlWkZoSkty?=
 =?utf-8?B?YUdHbmN5M2c4ajNza2pSMkd4MVRJczhITlNNdXJWWHdsVGZaSlpOaWFxSmkw?=
 =?utf-8?B?WDBwOUJ3cTViN05YenNwSU5Nd0VxVDY3RkI3bGdCRlJmckQxeWsxd3A2Rysr?=
 =?utf-8?B?K2lZVE9TU2hFYlU2eXNsa21wSjRVYXc0ZVJRL01jc1FMUGJ3SnhPUG1PSUNa?=
 =?utf-8?B?UFQ4RTJTVEVBVVp0ZCtyazRtMjJXMDdlZy9lWVBvbC93QzJRa0NyUUcwWDZ0?=
 =?utf-8?B?bzJ0TGs1cHRnTXFSSExQZjdsM3dUUHhjWko4ZEhzbFQyVCtNMUtVbEZGVkhN?=
 =?utf-8?B?TVg3MjJSMXhnRjNSVVRvS2FvYWZBb1M1cnlzRHE4MDVBN2syTERBVXRBTkFO?=
 =?utf-8?B?YWowK2xIcm9WdS9wdjBPSldLUGdxQkR4NlhWeXcrZTkvcDRPOVJkN1BTcTBx?=
 =?utf-8?B?VnljeGVRUVZPSTZMQWZpZUpKNWQzTlB6dTIxV1BxdHQ3MWUxZ3Fpb2tIM1Yx?=
 =?utf-8?B?Qzg2WmkxRC93SEVkci9xL09teDNLWmZyUUJuVWQ0YWM0V3QwUEVlRVArNlEz?=
 =?utf-8?B?OWF0dkpQRk8wZVVENzZkYU41OU90UXVsQ3ZmckRZTWdVaTFiUStickxVQVZy?=
 =?utf-8?B?WmxwZTJNR2VNb1V5OU9HcHhyVy9jaWpKemxYbk5GaFd1NFpzRTAyRW5hcE1s?=
 =?utf-8?B?cGJSK3k3SkFkRmFsQ0UxNWhUaWpUK3ZxY2xvV2F1dnJ6dGc4bDFxbFoySEZL?=
 =?utf-8?B?ZXpVREdQWDNoOW5LZmc0SmVTaGN5UllYWmJ5aEJsd1dIS2IzalljV1VzZ0dq?=
 =?utf-8?B?Uy9kSnhheTYvWWtIem1EcFlPNmZjVVVWMFdPbWRCZ0p2SXBBSEowNHE2WUJs?=
 =?utf-8?B?bC9sOHREcXYyOHlqN1R0WGtEeHJKaVJtSnZnd3o1dzR2dUVTbUhkT21lZ0No?=
 =?utf-8?B?S3FRRmF0RVVxc2tTNnBuQURvU1ZEODBKRDJLd2hpYlFmVTc1WDlxaVk4bWps?=
 =?utf-8?B?RC8vazFGZW04QXVHTEtRT2o5NGZDejVwa01Dd1lwYjc2UHNac2ZzRjBVVXMx?=
 =?utf-8?B?T1dwL2ZiZGhLZUJSSjRCTjdHeFBVRlowUzdDY2ZzbWF0TlBHWGFPcGpLYTBw?=
 =?utf-8?B?bGZGc21kQzF1dTN4dklpVzROd3FMd0RjOENpYmx5dW5ZdHVVU1FoQVF3MCs3?=
 =?utf-8?B?SEorQnkzRlMxcFFmZGpzcy9SS3pOSGpJd0lqd0lPNlJ0c0hmT0JZMmR5ZG5h?=
 =?utf-8?B?bVlPSkRPSWlUVklCQy9BT0U5Yktjc3I4NFdlNHJQMDVlNUhUOUsxblBqSDFw?=
 =?utf-8?B?LzMvODVkNFVvS0tXRTlsWGR4WW0rVm1nTC9mOHN4UW9EVWk2b0F2T0c1WWl0?=
 =?utf-8?B?cG1qVG1VUWdaZ3BGTzg0QlVteFdua21majRzRVI0SDNkRWI0NVdDWFJWK2cv?=
 =?utf-8?B?aEw2Y1JUR0hzU0xkNkt6TXk0cU1EMUE1enBxNmZ1SDlmUGFodjRFRTdCcGlq?=
 =?utf-8?B?K2pQbzhpWmVyYUM0SFgxTUV5ZEZTVHhlemVodzE0M3h5eXZLU0VEU2NzSWJQ?=
 =?utf-8?B?QUQ3b01pU1dEQW0wNVNIc3Z6OFMxRFl0dURtVFJsbk5LRXcvT2xMRXRmamZC?=
 =?utf-8?B?bmwzUzRGMnlSME56U2grM1B0NFVIQUt3SWc1dDJIRFhyQnFhQTdyMy9HUk9r?=
 =?utf-8?Q?+chzUDeIlEQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmpLY2NPeW1PK1ppdy9HZkFCelVHVFVycGZWK0dYWEdyUXlLRkZlUHIwZk5V?=
 =?utf-8?B?d1Yzc254elRCQkNDTW5mQlZFYWd2cUhsM2FrZHpCblhrc3Mza2VybFVha0ZH?=
 =?utf-8?B?NXZuVE5kUE1VSlAwSXU3SExuVERYeFhMMksxTFZ5RG80YnBOS2xTSEkxUzAx?=
 =?utf-8?B?UnI5TFNSRmxzWnBHdnlQNWxqMnZZUjNhK2MyeFlKUFFVM1VYVUxQNUtRTWI3?=
 =?utf-8?B?dTZOSzc1TUVzSDVURDduTFR4RU9zUVI1b0lkeXYvYjM2RHprdzdGSXd6MzYr?=
 =?utf-8?B?RzZTUDYvRlBuYTRWRS8rNk1xSnU5amErTVRuR2RzMjRXOUJ5VXhCYzQ5Nllw?=
 =?utf-8?B?bk82RGJ1UUZ2Z1FvYUZtUXhaOCtzZXBBV2RvZUE3SjBZM0x4ajQxZjVXdjNP?=
 =?utf-8?B?UEpIdXJ1b2swUE9wVUtTMmVxaklzeTloVDZDRmtvWS9HZmVhejRPK3NnTlJZ?=
 =?utf-8?B?WkdJMmxZOXg2Qks2ZFZaQTlQcmZWZXA4S3Q2Z0RNNGFJa3ExSkp2TkhYcU9s?=
 =?utf-8?B?d3M2NmkrODNEQ1FwMVJwVU9WUFMvRFVwczhJbEtoanNOVFVCVFpOZ2xscFhj?=
 =?utf-8?B?VWRySVRKZHQ0NHNEclFMWVpBaDZOTmt1cmpicFBFUXFZYjFhVC9PVFM3ZlM2?=
 =?utf-8?B?amxPMVRCWnpuRURkZ1ViRFFCd08yTlZGbzNGS1NvZjdQbWxJcENaK0pwV2px?=
 =?utf-8?B?Rk5PZUJLRGc2WVVrUUFDVm5VL250ODIyMHloNnRCQWkvR3V6VHdRMlZvUGZh?=
 =?utf-8?B?YVZkMmdtckJnRXNTeDhxRUhJUklrb0dPQzBEVmxpQUhIK1BTSjRhSVQ2eTZD?=
 =?utf-8?B?VUpyZHlyM21YRmhJeWQzTTdZTVhJSTR3bTRBb1BWa0ZhUkdyY3o0bzdDOU56?=
 =?utf-8?B?ZzZEOWhIbE5YWHB4OG1DK29QRXo5aEhSNHo3VXVJRVl1Zi9BcmVXK2dqZHlY?=
 =?utf-8?B?SGFFOXNQNmFEWXhwSG9mYmVDTmFQT3VZdVZGWUtoVnFPaGlTaVhqd0lqc2xI?=
 =?utf-8?B?NWJsaWl0Vk5BUjJaRVdEZXBDblhIN3lDYkcwa3drZ2c1WTRXSzJpNGgvTDk0?=
 =?utf-8?B?Nk1LcWpHaDhwSEYxWlUzT05DSEw3U0FPcEtBaTQvOTdRZ2hBb0puaDZIQWlY?=
 =?utf-8?B?bHI4MGIzS1lyRnZPSFIxS0VzUHZVYUpXang0NUNQT1BDMGI3OXViODF5Z2tF?=
 =?utf-8?B?SmxYdXpkWjdOSllmdXNvM1BCditjbThHbHBmU2F2cUh5b2hwUS8yam80aUFG?=
 =?utf-8?B?V1FUTDNFZnY1L0dXTW1WR2FVbERDcFpSZmNoWk8vRVBTTndyY0J2YmNmZzVT?=
 =?utf-8?B?bFVERlROeWpNeU1RbXhuTXZ1c21pVGxYOUhXVUkwZ2U3LzRXRDZ4ekxuY3Ja?=
 =?utf-8?B?RXN4TlpWRVZQc3BHaGxkeXdteGVRMHdmaXpZVytBa1I2TG5wdVIwSmNqaXdG?=
 =?utf-8?B?eDhrQjJndnl0QUpYT2hDZURiNXdDQ3lSTEtNd29Iazl3TFpTK1IxOTZqRm5p?=
 =?utf-8?B?cCtPQWNFamR5dk9ia2FxTEJhRXM1TDlXWlBhRytGUlJGTnVVQmJOWHAxb2hQ?=
 =?utf-8?B?aVdJNzMvdE1xT1h3STZma1kwY3FQa0xFaTBhcXI2VnhFVDhZT1psb2lBZkcz?=
 =?utf-8?B?a0dyWEFQb2xRcldEK0dPUjl1TWlVMk41U3FUN0ozTHI5OEVuSE1zVk1RMEtt?=
 =?utf-8?B?VE4yTTJUUlFVMkVMUWk2MEJndjEwMnNuelYxOEdjbXVNZGg3NDVZWTNSZCtu?=
 =?utf-8?B?THJzenlSdXA3Q0xvbFNKMEdZT2plWWprTmtKOE5Ta1Zhc1Z6Szc3VWY5RGV5?=
 =?utf-8?B?d1RjeEh2QXRVeFVXbko3anVFTEkvdTBwb01zUUtCcUhwM0xtMXBNUU5HSUdz?=
 =?utf-8?B?c053d0tNN2grZXRkYnZVUDUzbzZFb2J0OUJidStWRndSTW15aWlQeWRzVVdq?=
 =?utf-8?B?Q3Q5eXM0SHp4WGVkallyL3IzWSs1eUJxbklzNG44SUU0RW4zMzVMbGdWRmN2?=
 =?utf-8?B?OWxmOUVjVTJkendTSFBYZGxtQWo0aUJNM3VDTlNYUlVsOUVzVkhjcFF2RnNi?=
 =?utf-8?B?MEV0Mkx5cEduY1Y3OTR4NSswRElCMmpUeGRKcHFFNGpZK3pnUzVVMEEzcGF0?=
 =?utf-8?Q?n96cBIvlxIy4cDXtRAU5Ps/f2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38a8485-323d-4364-6ad7-08ddfa880bc0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 10:00:37.8853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hz4ooIA0HEj1AOTeER4/O9C23oMzw28YHWRew5oouT8lAHdDDkSscHLvT95K/rYY3CB9DBj3xjU16d9SuLoDqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9472
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


On 18. 09. 25 11:13, David Rosca wrote:
>
> On 18. 09. 25 9:47, Tvrtko Ursulin wrote:
>>
>> On 17/09/2025 11:54, David Rosca wrote:
>>> Hi,
>>>
>>> On 17. 09. 25 12:15, Tvrtko Ursulin wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 17/09/2025 10:59, David Rosca wrote:
>>>>> drm_syncobj_find_fence returns fence chain for timeline syncobjs.
>>>>> Scheduler expects normal fences as job dependencies to be able to
>>>>> determine whether the fences come from the same entity or sched
>>>>> and skip waiting on them.
>>>>> With fence chain as job dependency, the fence will always be
>>>>> waited on forcing CPU round-trip before starting the job.
>>>>
>>>> Interesting! I was sending patches to fix this differently last 
>>>> year or so, by making the scheduler use dma_fence_array for 
>>>> tracking dependencies and relying on dma_fence_unwrap_merge to 
>>>> unwrap, coalesce contexts and only keep the latest fence for each. 
>>>> But I did not have a good story to show for which use cases it 
>>>> helped. So I am curious if you could share which scenario you found 
>>>> gets an improvement from your patch?
>>>
>>> The scenario I am trying to fix is very simple to reproduce with 
>>> Vulkan when using timeline semaphore to sync submissions on the same 
>>> queue (eg. each submit waiting on value signaled by previous 
>>> submit). I have noticed this issue with FFmpeg Vulkan video code, 
>>> but it will happen with any Vulkan app using this pattern.
>>
>> Still out of curiosity, is the performance loss from the CPU 
>> round-trip something you are able to measure?
>
> Yes, I'm seeing measurable improvement with this patch applied. I have 
> tested three cases (decoding three different videos) now and the 
> result was +2%, +4% and +6%.
>
> Regards,
> David
Cc Christian
>
>>
>> Btw your patch is I think fine, so:
>>
>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> But you will probably need Christian to ack it.
>>
>> Regards,
>>
>> Tvrtko
>>
>>>>> Signed-off-by: David Rosca <david.rosca@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 10 ++++++++--
>>>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/ 
>>>>> drm/amd/amdgpu/amdgpu_cs.c
>>>>> index 2e93d570153c..779c11227a53 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>> @@ -29,6 +29,7 @@
>>>>>   #include <linux/pagemap.h>
>>>>>   #include <linux/sync_file.h>
>>>>>   #include <linux/dma-buf.h>
>>>>> +#include <linux/dma-fence-unwrap.h>
>>>>>     #include <drm/amdgpu_drm.h>
>>>>>   #include <drm/drm_syncobj.h>
>>>>> @@ -450,7 +451,8 @@ static int 
>>>>> amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
>>>>>                        uint32_t handle, u64 point,
>>>>>                        u64 flags)
>>>>>   {
>>>>> -    struct dma_fence *fence;
>>>>> +    struct dma_fence *fence, *f;
>>>>> +    struct dma_fence_unwrap iter;
>>>>>       int r;
>>>>>         r = drm_syncobj_find_fence(p->filp, handle, point, flags, 
>>>>> &fence);
>>>>> @@ -460,7 +462,11 @@ static int 
>>>>> amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
>>>>>           return r;
>>>>>       }
>>>>>   -    r = amdgpu_sync_fence(&p->sync, fence, GFP_KERNEL);
>>>>> +    dma_fence_unwrap_for_each(f, &iter, fence) {
>>>>> +        if (!r)
>>>>> +            r = amdgpu_sync_fence(&p->sync, f, GFP_KERNEL);
>>>>> +    }
>>>>> +
>>>>>       dma_fence_put(fence);
>>>>>       return r;
>>>>>   }
>>>>
>>
