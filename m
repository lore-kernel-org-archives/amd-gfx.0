Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB21DE7716B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 05:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ED6C10E49C;
	Wed,  4 Dec 2024 05:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VExaBgZK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D58410E49C
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 05:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7ZXPpGjC3CbE5X/aIGdxlVXnMPSB5n1zJIS0WdtMI4LqeameezVsGivvD+ySfom8pyzQRkHjzH5j4OY0dlbtn8UG8vXf+ACcS8Nb2z6dnNJIfa+2bbIXSFDE/f3htC2WRmzu9TTSXm/qWN3PYTnuRVMBkJptMSNc7xHQ9V/e2um9qR+6l7y5H+kOXJ3sIy4t8TLuiWWDbEOVvtdXb7zq9b5ZfcIogf1CJIWOjWTn+cH4rSAF7h2qrw7IjxzzMKdQUPEnXpXdGM4wP6ow9TM1cFcMTyurwEgSfOrYQSJ+V1KXqSCrQMY1Imn+92vttuU5b5L1DzAoRy9Dn1MFRXDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Y8GJ8aPoNMGqIz4hNTTF2dzlgLnJn8OOPE/9JChnX8=;
 b=h3Ovmi2hnYVXRY5qHn2SWgp1Fa4ZNmBQRM/0c4GPrN5LxXeN08bWoPUQB15mNCxC1UNHo+6I+dYpV4SERDtlg3topF9U6PFqqtIW8Xqgf/q+CLiq7vpHuWFjgLArK0eUCkym/t7bya54HTpZ3Ku2VE8H48cVR2n2dg43HdFcP7ygChFiB8Ql7zK5nuxg4c4+NrTiVE9quATxCXJAyUN9V0/SkOXs2Em1+8MiHI+sooUo51pa+7dERB5qB2WV5YqHP43U+aLIIuVVIXZb4U1vxthw7iPqnWEGUcl6PJa059+SmTiYOYjzzlGrE6SUxCtaNrCapTlqGvEKiw0woojqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Y8GJ8aPoNMGqIz4hNTTF2dzlgLnJn8OOPE/9JChnX8=;
 b=VExaBgZKvFOKITG13cL2m2Q59NW49Mzb3IGqlgq0QwYNa8tnrnOZo4VtDCvZKQV9U4PZFv/RdNsu+MTbTf93na86tFa/f5hsRRPjufQXMJiCq+c+2qufPJ6LscCgUAPcgkUsxnm9KMz618wFA5igujXfFztsvMQmcRahvZ56jTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 05:38:01 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 05:38:01 +0000
Message-ID: <20d00e76-7ce4-42d0-a968-d7adae616984@amd.com>
Date: Wed, 4 Dec 2024 11:07:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add the capability to mark certain firmware as
 "required"
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20241203181403.23515-1-mario.limonciello@amd.com>
 <e8ae8d63-44d5-4e77-818f-67cf69d0c8b7@amd.com>
 <c5a7f27c-c676-4e10-83ba-393a4df06ada@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <c5a7f27c-c676-4e10-83ba-393a4df06ada@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bab0768-b97e-40af-68ef-08dd1425d111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzdXcTgydDlaeE1GM2hrWWVKN0h2KzFqTlJIRG9lMkJpNnl5enVQQjdvdG05?=
 =?utf-8?B?QkFWeVNFVWN2U3FpNjg3Wm5tZEs4NEFPeGI1NVdlYnpCVmJ5WWc5UE5QcnBo?=
 =?utf-8?B?L1BtU3p1azVFa0swRmRYRmxRZWhxM2o4Skt6OHRSZTRkQ3VmR2RyVDM0TXFz?=
 =?utf-8?B?UmV1RnA4Y0V5T2ZTQWRNNmRDSUFqME1jZWVuNC9UNUZXbEJiKzJMMVp3dFUw?=
 =?utf-8?B?c0JWTmxaQkpwUHR3d0V3YUJvZE9XTHE1OXRPc0QrNTAvczkva2NRMFVZTjVJ?=
 =?utf-8?B?Vi90eFVGSUM2aGJBMURrK3FLaFRKRWc0WUtEdm5sK0lxYUdzbUxyVEpzWGdI?=
 =?utf-8?B?M2dQNTc1aEZzZFB2ZmFVN1FGV0ZRZ3UyOVAva29IN1NKUnZ5bGhzUFJxNmJo?=
 =?utf-8?B?WHRjcTJxUHRKYnFNaXRvMTNqb0NvZEhxelNHQndIVndpZ2lHRXdXcEJLREhl?=
 =?utf-8?B?Y3UrcCtIMGsvclJYejFTUHdoUDlickIzK3E1dFU0ckdiN1hrZUlBOWlTZmFQ?=
 =?utf-8?B?Nm8raEd2b045S0loVEk4bFFRNHZIMUJHazZ3M09Lb01UY1NzQ3FzMEFNbU9m?=
 =?utf-8?B?NGY5MWdWbjlBdGZSYXZpZ0RaMWJLeHpBQXc3MXZ0NWc1UXZXaWhaMnVoMlEr?=
 =?utf-8?B?ZVd3cU9ESmk0SVF4eVVwd3AzOGdWTE1zNElFNng0YmtKcmZhWnhnOXdnWGVB?=
 =?utf-8?B?Wm5rajczQTYwbGtJMUl1K3pQaXM0MExCcFRFcDJ4Q2xpMlpQWkk4U3ZVWENE?=
 =?utf-8?B?Nk9DK3U1aUptaUQvdG1qN1lhN3BUWENNZ1pqN29vNGlvRWsrdFRZK0I5Z3ZX?=
 =?utf-8?B?SHpJcWkxQXMyWXI4Y3Q3VHU4SDJFODhZSFVvN3g3bCtwek9CMGdLSFpLQncz?=
 =?utf-8?B?eHlTVHFIMk4wWjltRGlUU3pzUWpPanE1S3hxVHo3UW56eVJWdTIwUnNFR1pK?=
 =?utf-8?B?TlJCVXpZM0I0eXlMaHhkK0JsV2wrdDBnVTVyejZmZFF3TjkvZWhObzhjZzdK?=
 =?utf-8?B?UGNFSi9nd0tNYTgyMlA5eUMrN3doWW1kSTNhMWloUVNXdmFLbHJUQ1QyUDNF?=
 =?utf-8?B?WHdaQTZlOG9EUHo5R0syM0dxZTg0Sm1IaUxlWnlkN3RXOXBEcHo4ZWM4bFJF?=
 =?utf-8?B?aWE2ZWQxYjlWSzAvK29NUjZOOHBOTjNjQXNTZ0lnUmpPSXVKZWhMOGhsL0s3?=
 =?utf-8?B?NnM0TkFsK0h2Tk15cmZWRXdvWlFlMnhxMUR1dDdzZ2J0T2xQZ3FCUytXS0No?=
 =?utf-8?B?VnBlYmJxbG44K043YTl3NVFWUnNrVkNIckE0b3BxRldhNkJiL1JraHNNd0R6?=
 =?utf-8?B?ZW00TCswVU0rQkk1dURvZ0ZmaHdqOGV2NVFyUDlEcXZTZkcycFlZek5zMzE1?=
 =?utf-8?B?cWcyOEFsamZ2bUV1Q3NxM0JYdXRFQllYU04yWmJOOWFRczlSNExkNFZCMGx0?=
 =?utf-8?B?WU94YkJwVGVGOHk2bzRwL0RGNXlLN3RicGl0NEpoc0FSUHErVDA5djNLSUpX?=
 =?utf-8?B?RzFGcTFlRjY0dktScEJDR0RPZjNKUWl1VlhubnVqUHFGNVQrazBJYjIxTWhB?=
 =?utf-8?B?WlpDa3FPUnNjSkMzTGxLWmFHemlTd2wyZmYxa1pMbDNpTGdYYWQvWUNNRDNE?=
 =?utf-8?B?OFVHODdEcU80NW00VzE2SGhIUWtzeTY0RG5oUndnRVFXWWEvYmVMUkxvNDBZ?=
 =?utf-8?B?NzhXNElubkhBdlBnZlhHVEJMUEpWMUtUUWtMeW8xT2FPdUlsSXhiMTJSOTJs?=
 =?utf-8?B?c1dDSzV5Z21hSEdsREFpbDlYTTRmMFdRNGVDcnBOUFFQOGQySUx6MUlzNW15?=
 =?utf-8?Q?A+Ubd/MbAEkuwKUduxoUY1dMsHmDEXJurtTPQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TThiR1h6OGhNQlBOd1RDempPczVlSGpCTDhhMXZ3YWRpM2svZWlVNUlKY1NF?=
 =?utf-8?B?Q2s4a3ZjTWNWaDkyYUd3bUh2anJScDhqSHkxbjBQaWNzL25yR0UrWGZGSm1G?=
 =?utf-8?B?VUdtQ3A1N0hHQVBZRGZGRWVjM0R6TkJNSTVHQ3A1ZHo3dExnOGlBSjhBSWNR?=
 =?utf-8?B?SWlRbmZ6S1VQeXhSRUgxYjBvT1NzYlhZd2NVK3hpMjI2UWF3ZVI3T3BudHF4?=
 =?utf-8?B?bXR1bTBSM0owWmlFRG1Mblc1YVZBT3d3ZjhwSmFMbWwzZW9pNEdwWHFjUU9l?=
 =?utf-8?B?eXVRbG5ndGc0S0JGL1N1blpJS2M2NkNrTTNuMW0yYndCbmJ2SkhUT28zQXZU?=
 =?utf-8?B?MENTY3pVSVNqMDRONnRCVEg5Zk56RzF1eFMvMTNtQThvMnVvTnNWK2I3MGJo?=
 =?utf-8?B?YkFGWG5meWYrUWpDQlVIRkRNcW4rVG12SHE1cXZLekplTDlJdTl0N1RoWUEv?=
 =?utf-8?B?ai9QYnFhU0JQZmlINlBRWnNmN2h1QXhpc3NmMnZQUTNhMVhoYWcrdExjYXR6?=
 =?utf-8?B?ZHgyM1JKSmtxZ2Fxc1hIcE9YOXRPSnFhU1BEK3YyTnZ2dnA4NkJrVENDL202?=
 =?utf-8?B?MDdnM2Jra2JISG9XTGR3RnA2eGhXZVJISTl5Y0NnaHFucGliTytHOXVMdTFm?=
 =?utf-8?B?MFFxOWpIQk1WaTI1ditNalhPMTFjaC9rWEtlVWJnV0ZOYkIyQ0hYMVV3aWdn?=
 =?utf-8?B?T2pEVmQzc2l5czRrd1VvaGZhRExSWW15S2I1NDVlaTZ3Q0FMR3I3K2I4Zm9O?=
 =?utf-8?B?WXRTS1d6Z0t4cEpnamhza09pZ0JxbEE5SXF5WXUxbmZnaThjVzdKMGFjWUdC?=
 =?utf-8?B?T1JxcUlMM1lYcmk2V3lQdU1TWGUvcENiRE9SOVJwR3UreXE4MHVESkdwM0tr?=
 =?utf-8?B?eFRTa2p5WnlWdGVnWDVGZ3gzMnBDOGFJcHJQSk80dnlCMjNoS1BYS2NDVml0?=
 =?utf-8?B?OVBGT0pjTXl2NUpYdEt2TFBFMFpzSWcvQ2graVRRc2lOQlJiQXdjcHZWT1hI?=
 =?utf-8?B?Y0FqR1FXd0JiU1JwZmo2VE9FdThiQXFEQXFBbEN3S0pJNVcvVVcrdVUrMEVL?=
 =?utf-8?B?ZnAwc21EMnV6Skwyc2JwVmdqNjZEUStpdUNNTnNFVVM5elFJVHhWaTE1clZC?=
 =?utf-8?B?SUFwc1ZBdVNNNDdWd0thdlhWTTNYeGtuWHRXeW1sZ3BJQUsvcmJwcGcxRmxz?=
 =?utf-8?B?aWZzU1NtRGExUlhuQ3Q4bjEvQ3BGWlRlaDNST1pnS0NYcjl2UVVkUEpiSTh3?=
 =?utf-8?B?VlpIZDEra0FPSkRqS0Y4dDVNOUd0WEw4aUNxNFFCUUdGVVlJKzRiUnJ3VEZV?=
 =?utf-8?B?VzMwWmZnNWNieUhaRzV6UVlSZ2ZsUXJvenM0QjVTRzR0Tm1oamplcnEvRjhp?=
 =?utf-8?B?SGg4K2JvWk9KVFVZam14US9sSUtqTVBJb0Q4RklWV2dzbWJqeVdXMmM4NHNo?=
 =?utf-8?B?L2YyZ2VTS0NsdFNqQjIrYzZLbndHaUZaVmRwRmk3cXZFOFBTUHVSUkZ2UTBk?=
 =?utf-8?B?NXVkMzVCQWpPWDRnUEx6TWFLU2JlZHMxN2FLRFdnZE5jODhmT2d3UmVodytR?=
 =?utf-8?B?RGQ5MWpENGYwV083cVRSdVlLZlVRMGxxY0ZjMEtoakFzempYM0taMktYL2RE?=
 =?utf-8?B?L3Q5REJrc3NtS0RLaE00Qk1mVHVvMVRleWw1NjZyRXlDQllYR0lYWDFZWUt1?=
 =?utf-8?B?RWR5dDFjK2o2NEluTGFNeThnOVBEdnE3MnZJMDF6M29FNDJndFUxMEFKUkJI?=
 =?utf-8?B?MnRES3BQdU5IQkZyZEk5VlhtQUZ2OUV1OWVjQ1VpSFFFNGI3SlhKdnNraWpI?=
 =?utf-8?B?YytZYTFZakpsL2pzc2FyVlpaQXNFaVlGZDQ4c2FHbXRFdGJhNG11eklGYWZQ?=
 =?utf-8?B?eWFUQXRONEs1VmV6Q3BUMkttR28xbHcvZVdnN1NiVGpyK25mT0lLd2R3SDZC?=
 =?utf-8?B?bS8zK2NLRVQyZ2xNT2IzU2lObUFkY01zaGhyRVFhR3hLWmNaZXJNUGlBSlBS?=
 =?utf-8?B?dU8xVUYrem5RUlZacHQyZjR3YVBoOUpmWE5XY3ZUNVNkS0VUOFAycURhdnRo?=
 =?utf-8?B?UytsanVLN09Tbm1DVzZla0RTNDFnM25PQzBmSHBYMXVzaThwbUxaYmFUT29q?=
 =?utf-8?Q?kuV3bgMsxJql26lWC0esfWzV1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bab0768-b97e-40af-68ef-08dd1425d111
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 05:38:01.3890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzKtKLfdl8syH2IgytuTPFtvYy8LikgBHwfYMu1g4mFx9jKwSHajC8c/FsoQK7nO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458
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



On 12/4/2024 10:44 AM, Mario Limonciello wrote:
> 
>>> +enum amdgpu_ucode_required {
>>> +    AMDGPU_UCODE_NOT_REQUIRED,
>>> +    AMDGPU_UCODE_REQUIRED,
>>
>> Couldn't this be handled in another API instead of having to flag every
>> load? By default, every ucode is required and if optional may be skipped
>> with amdgpu_ucode_request_optional() API?
>>
> 
> I guess this would be a smaller patch, but 6 eggs one hand, half dozen
> in the other?
> 

I thought only ISP and gpu_info (no longer there for newer SOCs) fall
into the optional ones so far. The usage is rare, similar to the
nowarn() API usage.

Also, as far as I know, the cap microcode is a must whenever used. That
is not optional.

Thanks,
Lijo

> Alex - what's your take?

