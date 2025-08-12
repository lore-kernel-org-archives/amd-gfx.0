Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41080C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 10:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BCB610E0B4;
	Tue, 12 Aug 2025 10:57:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C6lk83gt";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52AD10E0B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 10:57:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dW6QjPTuCDkGp3Ek0nriFW1VRl9Krz6UxsN8cPJ5ogoOH5rJb6egKmHcjCc4iGScOnvOe4i1WqLuxr5bH4+ZIruaXjMbBOweK02e+djWP1Z9i3Xx/UP56WaLYk7xUK8FOiNhZ5lkwFQ7ZrwxmWcAoU1wR9NdWK2DXWwn23i0xrA9J+Wx3Ige3ndendMGPyaG+k1qIn4KZ41WnVDpYMg0u49/xpRjgQYTJHMnEG7v/ZLH8TrSE7DAWwlZzjrse5F/Eko8qrixSnAeUS/J+nrLKWtQaUwBxX9lZQ7HtGTJeREW8k/COrn2WhLUPifOAzRPdCWScE2MlKGv5DwM6c6dbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcxg/a1UX7SYMnFsCWX/y99xkD7y83u8U8gnKGZWDtQ=;
 b=F0xAhHj3cy/WMlGT/sE12/jOZib5kEuHOZwquCqXMm26KKiGKGMzZq7khN1jJZp4CzGT3bk1OSjMIBPJjGWhs/+RUp4erq/nDFmo1XlGba4cEt+6LfQtvRo4uPgimmWT1mQo5t0HjR6MoJM2uez55iGzAzY4pgz/RobEasVzJaKnDGwDoJxQJrCtUoTrhz7CCMR+5Iph9NmGjYo6OljTTVcXC92Dxf9JBsumsPXBy0F00VrVThsBYLY6TY7VocidZfDQpD0KOty4SIR8FrixkmB+Ipp8q2aW84DC1+emYcbTCFYqD8eKJFEKynMDx+55re8SQy8wxtgezevgoH068Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcxg/a1UX7SYMnFsCWX/y99xkD7y83u8U8gnKGZWDtQ=;
 b=C6lk83gt4eGqqCVd+Y1utQSZSnLXdMokcnbBiLedrSoeVXMLmGSlTNJMRgleISE06wb1kTeWoIedZSIYqoAk2LxQOLf5Xnwzb0wOV93HnapBSq913gU+M93H3IwtM4kLmUhyg/yRdhqhprktn6GJzM/KtcPaHzTE/uVsVTgDS/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Tue, 12 Aug
 2025 10:57:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 10:57:36 +0000
Message-ID: <00433931-5bc8-4ad5-976c-997296ce1fb1@amd.com>
Date: Tue, 12 Aug 2025 12:57:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/3] drm/amdgpu: Add ioctl to get all gem handles for
 a process
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, David.YatSin@amd.com, Chris.Freehill@amd.com,
 dcostantino@meta.com, sruffell@meta.com, mripard@kernel.org,
 tzimmermann@suse.de, Alexander.Deucher@amd.com
References: <20250811150536.3394262-1-David.Francis@amd.com>
 <20250811150536.3394262-2-David.Francis@amd.com>
 <5e3de4f0-b529-4b18-a99d-5c2d592cbb73@igalia.com>
 <cc7d180c-fab0-41f0-926c-ba757b3e01f2@amd.com>
 <27954e0e-1f98-47b6-8505-4ccd93041df8@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <27954e0e-1f98-47b6-8505-4ccd93041df8@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:52c::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b19bbf-76bc-4fd0-c5b0-08ddd98f0c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3lsVHR1WEtrcStDSWRMeWRmWS9semhzdUMrZ1JabTJDS0RjaUFNaHdLVEw5?=
 =?utf-8?B?U21ZUncySkdUbkJTeHRZYXBLaEMvL3A4Y0xzL2JrNEFYTi9DOVNiZEk4ZE9Q?=
 =?utf-8?B?Q3YzSTlCSzBKVUVsNjFaN0hsVDBrNTdkdVlQcmVXNWtGazdYL2puUmRmK25D?=
 =?utf-8?B?TW1sVjNUaGplcXVtdEV2RDNQdGpBL0xaWTAvWk9ldkZwQXhzWGlDbmtwaXBi?=
 =?utf-8?B?aEw0VFBaeDZLK1JKTTh6Wjk2SG9hQm1hWVY3MTk1YUFYbDYxYnJiWDUzRThu?=
 =?utf-8?B?em9FbHcydlo4QmdLVWkxN3ZYYU1OMldsSmFDdzd0clM2eE9aQ2tQa3NDdUt1?=
 =?utf-8?B?RUdyamEwWGY5T3o4NitYTWJuRnZXcnovVGlaQXc0aWxGMkM5cHZOV2dvcHJJ?=
 =?utf-8?B?elk2clBnMk9HSjdxVmpZd0N2eEdvaW5XL0Y5RzRWeGZxSzljNHJXb1FtYm9h?=
 =?utf-8?B?Rml1ZytKNGNwOWQweHJNb2ZlRkVaQndLVlBnRUJFcm4zQktoQXNEUTRXL3o4?=
 =?utf-8?B?WXB3ZWZxRFlwem1CQmZ1dEVBclBoWWJlcVlOTm12ZTByVFlnWUtHQnBhUjA3?=
 =?utf-8?B?emhVQkhPNFpqdEJpMlpOSDFNK0hxSDFjdjZTV3piWG1vWVRyQ0I1UVlvYXg4?=
 =?utf-8?B?S080RHUvTnc5MUtoR1NNLzlnTFg1WFNHdm1QM0xzRTBaSlNMSHRYZkdud2RZ?=
 =?utf-8?B?MWVVOGdCSCt1WFZjVzVWSDU3Y1J5aThyOTFmRnZhZW9KZHdYZUdEMFBpeVFt?=
 =?utf-8?B?T1JwRE9DbjFBd0dwRUFwWURybVZSQ2JNdGR4R3R0Sy9KbW41WUFOZkMxV0ly?=
 =?utf-8?B?Nzg0Wmwvc0VXcmJoMHp4ajFRWFc2czFmdUVkRGdNUFl6R1REcktFOFFsR1A2?=
 =?utf-8?B?WkVSbXdRU3R4b1piblQyemdtcm9Wa1U1RkdJU0F2dzYrcXpsTURsV2FVZG5p?=
 =?utf-8?B?Qk45a0d5ek5XZHRZMTBVaVFuMnlLbTVpK096ckx2QjJTU0ZTUndiVEJWN0Q2?=
 =?utf-8?B?eVNjY1RUWUFEVWdxWW5kTnlXMi9Lb0wxU2p3ZjkweTNjcm8vSmxZNUdNd1pN?=
 =?utf-8?B?VEJ3S3pLbzZ5OW1pZmNBZzkzajhDMzExZ3JXSVdFQjh3QkNDYXZBK0hKRDJx?=
 =?utf-8?B?MEFEdGNuMEVTaUlHQXliSkx3S1RLVXpYTkxEQnBTSVJyWnhPTVJ4eFIrMVgx?=
 =?utf-8?B?SVF4R2xJMWdleDQ5c0MwaytzNHB0elhJRldpNmRFcXh0cXZCdzN1cmtXTVFH?=
 =?utf-8?B?bHFsTDJUMHBNQS9XMEJhbFZYN0luc3Vlck1DdmxYSGhFdjlBVjh1UnBEb0o5?=
 =?utf-8?B?NGUvc3ArWUlwY1Bob1FZSnZwb2REbVhiYmh5RWMvNzdLV0ZNU1RXaUNjT0Yy?=
 =?utf-8?B?NkNzZ1MyOU04bWsrRDNESkNISHhYOEtBZ3ljckUwY3l5VFFFWUIwN2RwdVhO?=
 =?utf-8?B?MjFRQ1RBL2J4alNwK1RueHovZWd0Y0E2OU5lYU95b3NuSmNaaEF6bmx6bk9s?=
 =?utf-8?B?T0l1eXBMZnpJR005QUkySW8yUTZ2UklPbTczZnIyYkNjNzVmNVhtM05PdXky?=
 =?utf-8?B?S0paTjY1OFBtRmdQYmJ1bW9rYzByenZuRHRyQ3BMOXQvSzBWclhOZDlzQ1RJ?=
 =?utf-8?B?Vk11czNDbURTaEJYRTRJOUdHK1NjN1VMTEYrU044UkJWemR3WHVVRWZhTlRs?=
 =?utf-8?B?cFhTN1FyWVQ1bGF3NFVZdjhTUUtnVnJnVzZ0dDZ2R2cycmZFaTdYWlhNQ21m?=
 =?utf-8?B?Rk92ZXNNVTB0YnRhbWFwZ2VHMUFZcWh3eGx0eUFrSGl3bnc5SnQwNEtQZGxF?=
 =?utf-8?B?anU4elVheVdDMWpwRnpiRjRNSkt6YzVpYnBpbEVOaEdzQmc5dGhrOXk2UjJX?=
 =?utf-8?B?aExOTlcyZVpQMjdNV0ZSWHVUamNJU0w1S0tTSkZuUEtqSVUrb0VvY1YwYWhY?=
 =?utf-8?Q?qHc6INKSD1U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkswcnluajdCUlZOYklmYkxPMlRvYUoxK1ErbTJDQ1pDN2pLWFNBTFRsdEV6?=
 =?utf-8?B?dkExVFB3WDVKbHpab0g0aXBwVmR6YWw5VStoMWlvMkc2QTNjMGh5cTFpWmpn?=
 =?utf-8?B?UUhiV3FCQy9NenlJb1VjSjhEQ3BKMGZaS0hYUklLTUV0L1RJK2grb3dKTEVt?=
 =?utf-8?B?S2Z5S2ZjTmpaelBnNTJYWGhPRVJwdkQ1TTNLRUE3V2lPYUI0Q1ZDSDUxdU1Y?=
 =?utf-8?B?YkdCZEVTbDJtNHRlT1RGdkt1a0xsNmhnTGRXMkdJRlZ6UkhIWUdQU21oTUEw?=
 =?utf-8?B?RjhtTDFIL01XNFhpZUMrV1JWRXEwK0NreEdQNFlQUUpRQjRUOWlTR1ltdUdP?=
 =?utf-8?B?RFV1SnJKZUdWK2JkZUM4NHhrREpXV1I1MHRDTnF3RFVHdHRTYXNSUUpab0hm?=
 =?utf-8?B?WGZob0IxcXB5bEFWWTRiZ1BCdCsxWlJKeDVza1RBVU5OZDBIRGlhRWU3TEhK?=
 =?utf-8?B?UGhCZ2NMc1cwajFtR21FYjFqbTFaUTcwZ2pSL3lUQ2pWR01XME12cWVmcU9T?=
 =?utf-8?B?eExPelJ4dFZIQXJIdWFtTkdwcmNCaHgrRVVOMkFHZXFwaEw2RDRsUjcraGU3?=
 =?utf-8?B?TWZqaGlrS2ZhRTZTTWYrZ0hhNnJjcS9HZkNjRVg4RXV0SllpNEN1MWtJN1pE?=
 =?utf-8?B?c1JDVWR3UFI3RStiWGJGbVhSVlpnSXlQTExzUXNNbTlQVitRRFIxWnAxMmJa?=
 =?utf-8?B?QVZoemZrcHJZRktrcElxalh0aWVKRXg5Q2pNUjQ3YUpNdGgrZTFBVzljTExt?=
 =?utf-8?B?NU5TcC9NMC8wclA4OWl0Qjd2RytqWG8vMENJV1Y1SWYwSmNhWHdKbXp6TVBM?=
 =?utf-8?B?WkwxQ2s4S3ZrUG5odE16bWtMQ0RUSWJ1MTU1K2xoMXp4MjBCZHZDcWFaWlZ6?=
 =?utf-8?B?ZHlJNEFaNWhjZmZYUUVSZW1WSlpKTjVHUW4zZUI2S0pLR3R2UVJ6akE4M3pJ?=
 =?utf-8?B?UjIrWVlHMkNCeHhEWVVhRWFnTXhBQmU5MkZ5ODZOTHdPejQ1NWtaRlBjZnhh?=
 =?utf-8?B?ZDBZSmVkcEtoUlp0c3NLazR1Q0ZRckJoa01IdWpmdml6bnNObzErSGRmUGRV?=
 =?utf-8?B?S1VNay9QdmhRT0EvMkpsVGVmclpDRHJEQ1hUYkJxcE9teUQ1VVBYUEU3STh2?=
 =?utf-8?B?d1M1QTRtR21xNUpSSGtSVWxkNko3d0x3MzNsOWhReCtydXkxcmlXNEpBaDNh?=
 =?utf-8?B?VFNUKys5TFF2TCt1WGVwYmMwcDB4Q1R1SnRWdzArNjN4alcwSHczM3liSDlF?=
 =?utf-8?B?c3BvOFdWRWp1TUp5TGxJNXI4Y0Y4LzZwdjhTeCtnWDZMNkJyOEZQSGQ5Z2lv?=
 =?utf-8?B?U2RTKzloRFdqNUJHRjRDQTlySkYzVEw2ZFphOElOM0QzM09zUHNGWFA2UFg0?=
 =?utf-8?B?V0VWeG44andMck04TDRYbkRVYWdYN0l5djNjOUVkSGN0UVhuaTlRRHh2S25Q?=
 =?utf-8?B?SE1Wayt4RkNWeHZWblBXdGNZTmxDTXE1cmMvalhoTE12QVRkMC9jS2grY2JP?=
 =?utf-8?B?S251ekRYVG9SK3lxK1ZSWFlMTGpMaFNBd0YyZFlUWm0vTUw2Vkk0ajFXNDl2?=
 =?utf-8?B?WTc4cGRGQXRsWXRsYmt5dVVjMFV5Y3hVRWFDZHlRS0hWVGdYYVdhRS9pZHN4?=
 =?utf-8?B?QWptbU51UEtpQUFJaC9JR093V1ZJeTRrWXZPMG1ZNnBPVThuN3Z4ajhLQ0t0?=
 =?utf-8?B?K1NkVHFyRkUwYlJlc00wcDl1eG5RSU9ldUtGOHYvL2V3eGZNdldaL1dKc2xS?=
 =?utf-8?B?cVg3YzFFcXNjalBoWmV4NEtDaVlnRXlvYVFlMGt6bVZLcFRodlVlV3pEZHdT?=
 =?utf-8?B?empYZ0ZuNWFKK0dFRU5YSG5GU3lVSGUvK3o0TkpnalhUNlpacmdRNDhEOGIy?=
 =?utf-8?B?QVNZblNza3JkL2pUcDhQelZUb3BkanBuK1A5S2dGNkNuSW9QbnhPNmNIR0JL?=
 =?utf-8?B?YUpPTEdVeFdOQnpCM3VrQWNxdmZVU3I1WGo5ODdjUEtMYzIzVTduSmpUc2Zx?=
 =?utf-8?B?cTAzR0M1NW93R1hTY1BYb2szY3Fid2MySXRLRkVVKzVaZjZhRldhbmd3cjd3?=
 =?utf-8?B?K3JYQk9pcHVxc25wL1BLdFNEcUp3eFhpTTA2bWFkaGxVaDM5MS9HTG92TGFX?=
 =?utf-8?Q?XjH6RyKrviy8VrrHwTj9OZ5ee?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b19bbf-76bc-4fd0-c5b0-08ddd98f0c1e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:57:36.6719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FobKF8spxGoxXsfs7IMNZVRmCTa/uJ4t6ktH2OSqfHdd+EgEUg0q0PlegmTjWoB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790
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

On 12.08.25 11:56, Tvrtko Ursulin wrote:
> 
> On 12/08/2025 10:36, Christian König wrote:
>> On 12.08.25 11:28, Tvrtko Ursulin wrote:
>>>
>>> On 11/08/2025 16:05, David Francis wrote:
>>>> Add new ioctl DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES.
>>>>
>>>> This ioctl returns a list of bos with their handles, sizes,
>>>> and flags and domains.
>>>>
>>>> This ioctl is meant to be used during CRIU checkpoint and
>>>> provide information needed to reconstruct the bos
>>>> in CRIU restore.
>>>>
>>>> Signed-off-by: David Francis <David.Francis@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 83 +++++++++++++++++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  2 +
>>>>    include/uapi/drm/amdgpu_drm.h           | 31 +++++++++
>>>>    4 files changed, 117 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index 4ff3a2eaaf55..f19795dddf9d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -3031,6 +3031,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>> +    DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>>    };
>>>>      static const struct drm_driver amdgpu_kms_driver = {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> index e3f65977eeee..3873d2c19b4b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> @@ -1032,6 +1032,89 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>>>>        return r;
>>>>    }
>>>>    +/**
>>>> + * drm_amdgpu_gem_list_handles_ioctl - get information about a process' buffer objects
>>>> + *
>>>> + * @dev: drm device pointer
>>>> + * @data: drm_amdgpu_gem_list_handles
>>>> + * @filp: drm file pointer
>>>> + *
>>>> + * num_bos is set as an input to the size of the bo_buckets array.
>>>> + * num_bos is sent back as output as the number of bos in the process.
>>>> + * If that number is larger than the size of the array, the ioctl must
>>>> + * be retried.
>>>> + *
>>>> + * Returns:
>>>> + * 0 for success, -errno for errors.
>>>> + */
>>>> +int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
>>>> +                  struct drm_file *filp)
>>>> +{
>>>> +    struct drm_amdgpu_gem_list_handles *args = data;
>>>> +    struct drm_amdgpu_gem_list_handles_entry *bo_entries;
>>>> +    struct drm_gem_object *gobj;
>>>> +    int id, ret = 0;
>>>> +    int bo_index = 0;
>>>> +    int num_bos = 0;
>>>> +
>>>> +    spin_lock(&filp->table_lock);
>>>> +    idr_for_each_entry(&filp->object_idr, gobj, id)
>>>> +        num_bos += 1;
>>>> +    spin_unlock(&filp->table_lock);
>>>> +
>>>> +    if (args->num_entries < num_bos) {
>>>> +        args->num_entries = num_bos;
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    if (num_bos == 0) {
>>>> +        args->num_entries = 0;
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    bo_entries = kvcalloc(num_bos, sizeof(*bo_entries), GFP_KERNEL);
>>>> +    if (!bo_entries)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    spin_lock(&filp->table_lock);
>>>> +    idr_for_each_entry(&filp->object_idr, gobj, id) {
>>>> +        struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
>>>> +        struct drm_amdgpu_gem_list_handles_entry *bo_entry;
>>>> +
>>>> +        if (bo_index >= num_bos) {
>>>> +            ret = -EAGAIN;
>>>> +            break;
>>>> +        }
>>>> +
>>>> +        bo_entry = &bo_entries[bo_index];
>>>> +
>>>> +        bo_entry->size = amdgpu_bo_size(bo);
>>>> +        bo_entry->alloc_flags = bo->flags & (~AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE);
>>>> +        /* WIPE_ON_RELEASE is set automatically in the driver; it is not permitted in
>>>> +         * BO creation. In the interest of giving the user exactly the flags they need
>>>> +         * to recreate the BO, clear it.
>>>> +         */
>>>
>>> Ha, curious. What is the reason flags userspace cannot use are specified in the uapi header?
>>
>> The comment isn't correct. AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE is perfectly allowed in the create IOCTL.
> 
> I looked after reading the comment and it seemed true:

Oh, good point. Now I understand the issue. The GEM interface doesn't allowed for the flag on create!

> 
> amdgpu_gem_create_ioctl():
> ...
>     uint64_t flags = args->in.domain_flags;
> ...
>     /* reject invalid gem flags */
>     if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>               AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
>               AMDGPU_GEM_CREATE_CPU_GTT_USWC |
>               AMDGPU_GEM_CREATE_VRAM_CLEARED |
>               AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
>               AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
>               AMDGPU_GEM_CREATE_ENCRYPTED |
>               AMDGPU_GEM_CREATE_GFX12_DCC |
>               AMDGPU_GEM_CREATE_DISCARDABLE))
>         return -EINVAL;
> 
> Actually, thinking about it more, maybe more flags should be cleared in amdgpu_gem_list_handles_ioctl()? Perhaps the above mask should be defined at a common place, or even internal only flags removed from the uapi header. Or uapi vs internal flags split or something.

Yeah, probably good idea. But it should most likely not be in an UAPI header.

The general background is that we have a bunch of flags only the kernel can set and are read only for userspace.

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>>>
>>>> +        bo_entry->preferred_domains = bo->preferred_domains;
>>>> +        bo_entry->gem_handle = id;
>>>> +
>>>> +        if (bo->tbo.base.import_attach)
>>>> +            bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
>>>
>>> I had a question regarding this part in v11. Any comment on that?
>>>
>>> Anyway, thanks for implementing the other changes I suggested, this one LGTM now.
>>>
>>> Regards,
>>>
>>> Tvrtko
>>>
>>>> +
>>>> +        bo_index += 1;
>>>> +    }
>>>> +    spin_unlock(&filp->table_lock);
>>>> +
>>>> +    args->num_entries = bo_index;
>>>> +
>>>> +    if (!ret)
>>>> +        ret = copy_to_user(u64_to_user_ptr(args->entries), bo_entries, num_bos * sizeof(*bo_entries));
>>>> +
>>>> +    kvfree(bo_entries);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +
>>>>    static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
>>>>                      int width,
>>>>                      int cpp,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
>>>> index b51e8f95ee86..7cdb6237bb92 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
>>>> @@ -67,6 +67,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>>>                  struct drm_file *filp);
>>>>    int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>>>>                struct drm_file *filp);
>>>> +int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
>>>> +                  struct drm_file *filp);
>>>>      int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>>>>                    struct drm_file *filp);
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>>> index bdedbaccf776..59b423883e91 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -57,6 +57,7 @@ extern "C" {
>>>>    #define DRM_AMDGPU_USERQ        0x16
>>>>    #define DRM_AMDGPU_USERQ_SIGNAL        0x17
>>>>    #define DRM_AMDGPU_USERQ_WAIT        0x18
>>>> +#define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>>>      #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>    #define DRM_IOCTL_AMDGPU_GEM_MMAP    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>> @@ -77,6 +78,7 @@ extern "C" {
>>>>    #define DRM_IOCTL_AMDGPU_USERQ        DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>>>    #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>>>    #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>>> +#define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>>>      /**
>>>>     * DOC: memory domains
>>>> @@ -811,6 +813,35 @@ struct drm_amdgpu_gem_op {
>>>>        __u64    value;
>>>>    };
>>>>    +#define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT    (1 << 0)
>>>> +
>>>> +struct drm_amdgpu_gem_list_handles {
>>>> +    /* User pointer to array of drm_amdgpu_gem_bo_info_entry */
>>>> +    __u64   entries;
>>>> +
>>>> +    /* IN: Size of entries buffer. OUT: Number of handles in process (if larger than size of buffer, must retry) */
>>>> +    __u32   num_entries;
>>>> +
>>>> +    __u32 padding;
>>>> +};
>>>> +
>>>> +struct drm_amdgpu_gem_list_handles_entry {
>>>> +    /* gem handle of buffer object */
>>>> +    __u32 gem_handle;
>>>> +
>>>> +    /* Currently just one flag: IS_IMPORT */
>>>> +    __u32 flags;
>>>> +
>>>> +    /* Size of bo */
>>>> +    __u64 size;
>>>> +
>>>> +    /* Preferred domains for GEM_CREATE */
>>>> +    __u64 preferred_domains;
>>>> +
>>>> +    /* GEM_CREATE flags for re-creation of buffer */
>>>> +    __u64 alloc_flags;
>>>> +};
>>>> +
>>>>    #define AMDGPU_VA_OP_MAP            1
>>>>    #define AMDGPU_VA_OP_UNMAP            2
>>>>    #define AMDGPU_VA_OP_CLEAR            3
>>>
>>
> 

