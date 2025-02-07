Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153FDC02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 15:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF6A410EB39;
	Fri,  7 Feb 2025 15:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h89x55lJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F2510EB3C
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 15:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4VS5jdoqPxR4RM5DrlnSgDp8wws35BooeLLQR6VUqgMWloIgkz0BsV515nsEfA3AFgXgpgMwY5U/lsttGmCFS0Yms/TiNrjgiXIqos8yVClgeTVfqfeEksB6PPZE8gbLt3JyZMnYEz7j4C8pbDkxZE56CPKYd2DSoLL5ecPUw2LydgOWE6IkqGqRthT/mq32j7ORyaXZl4Il3bMNrVE3isDcF1Fjgy/siM7e/3cCCFJp14iOTqaBfRue7k5C+x44TMaGvaLOF7O35sy8SQhCFvdFhB8eJyVi2WFNllzf8jIJLifn3kgeYV1lExIjR99JIEDF6NHA31R/W/4kSUCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KezEU5Gle4kY5qTbquUhHdMVVEsfW/KGwzKm+Pgdjw=;
 b=vckvoO6FtPiJwdOkJiOZhS8dszeHlIYtb1sjpTpI9nXDVboPSKVoeZAxWbD9ancTjKeHDjwEcylp36OJzQ7phD+0Eay2VbXJRTjP/DGgU409PaHPhyeHiex+xmnTIub+DEHIwTwlytOMS9/TORs/SfHSSJAFbN0tATaaEAqlKkvx2PvSkSYyzrY7dvuJVYalVhObbMoKeRT/l73k1Z/wpSLqjH99D1Vso9gbkx5xpabQOYTSRd6kd+GJZaim9wjp1IMaUEG1/A5ZRs4W6hVtOJTtnYPdiyFPEs6VMEuvhHaqjOyDro+LVpqwmwD8ussk7mzqdiUOZaBtm6CgiG/vlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KezEU5Gle4kY5qTbquUhHdMVVEsfW/KGwzKm+Pgdjw=;
 b=h89x55lJehXnTbbwRE0SeYSsc7vbb27ldOBeg5JHcIXlK86R/vGoKynns0NdETJBF5w65PYPQCYY0xwrbCr4sgGAXZ/pn/y15Hu/Xzhgo1fgeGE8sKMTNO/vaXqe8Osvhe4OOM+1P50Gzygke1WnpxD+sw4xQX9+YY0Rzs/04oY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Fri, 7 Feb 2025 15:18:12 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 15:18:12 +0000
Message-ID: <1f9441b1-46af-496d-9711-a71242d03b46@amd.com>
Date: Fri, 7 Feb 2025 20:48:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
 <20250206131258.1970391-3-lijo.lazar@amd.com>
 <CY8PR12MB743505FC4310A69D4B2C372685F62@CY8PR12MB7435.namprd12.prod.outlook.com>
 <22d2c3e8-98f9-4ea3-9737-08e9812d312a@amd.com>
 <CY8PR12MB7435B4D359268091F915407F85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <a5bc0dcc-3aba-404f-aee4-f664a71b7a1b@amd.com>
 <CY8PR12MB7435100E613BA33C8CD4B2DD85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY8PR12MB7435100E613BA33C8CD4B2DD85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::35) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ae3999-51ba-44ea-b4f3-08dd478aa2da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWZJYkI2NyswUWlRNW1QejFRc0VSc2x3N3gveEJteko0NnFUMFl5RHFuZUI4?=
 =?utf-8?B?bk5BZzMyWVNkL0R5OXRCamtVT0p3UTRNR0E2VElNZVJrVjJuRUt4MDBsV2dT?=
 =?utf-8?B?VEdGVS9MWTdBQ0svQjVGK09KK2VVMU0wOWpzcVdvekJUZWlWZ2hHcEltYThI?=
 =?utf-8?B?c1BHU2tXczFkQklvTUZkc0gzMXJVNk5Nb09TRGpYQnp0UlJKZWtWdENQSWQy?=
 =?utf-8?B?K1UrZHZwRjVJRUVNVHYzUTJ4NVdxMk02TVRobUFFQzdmODVXZklYWFJBajRI?=
 =?utf-8?B?UEExbkxwSDdQaTFpQnhYTEFEcmw4ODRxalJTY0xaYXN3Sk1kNzBVMjA1bXA2?=
 =?utf-8?B?OHNzY3FrTUdaRHJuRXJVSGs2dUZCZTg5SmdlUG5BbHBNcmVrOG81ZVpxajFz?=
 =?utf-8?B?VXppeWliUmRVUWhQVlVVbWRjTWNtNnlTMDZIMEp5Y3paN0FTWHZPK1Z2aDZN?=
 =?utf-8?B?Zk9tUE44cEZIMkpxZXdFd1QvbkpXU096N1h5VnlqSjgyOHhIN3FlWHp2THZC?=
 =?utf-8?B?TW5DQXFIbG5KZ1p4eWRuSVpncm1DUlpWK0hHMW4yeHJESTkycWYrWXQ1Y2JL?=
 =?utf-8?B?ZUxKOU1jLzdCMEttSUkrOXdTVk1YSndKOU9ZeFQ3SnFMQ2N6M0tRdjl1aWRt?=
 =?utf-8?B?dlhYYzdJWVBoZzh6dGlGZG9GQ2lQTllURGRwM0FLd2JWcUpQZUdLNXFGYWpH?=
 =?utf-8?B?bnpTelB0aEloVFNIMVZQVkJEU3NYK0lnMm5RUVJTdFN1Z3Jucmd1Vy9FeFM1?=
 =?utf-8?B?TWhHS1A2QldtR0JnWi9kUFhsb25mdWRtVUpVTThCUFlzUUJoNnB3TXI0VFJN?=
 =?utf-8?B?cEl2cG5ramVUQ0hLU3hKM1ZMRVVUKyt3MHFqWG1naUU2WDdBaXkxWHNzQUZC?=
 =?utf-8?B?ckxZREliTzVBVTJkOExxNWw5WUJJeXM2VGxLMjIzdDRxOUNoZG81WnZzWFJs?=
 =?utf-8?B?Q0E5eHRlM2Z6Zk0zZmdXcVkwL0M3dlEvR3ZNKzYxSW1YK2JuVUJkbEVmb3RN?=
 =?utf-8?B?OUhmTFYySlpyRzYrTjRDSmFBc2dmOUlZemI3REwvNGF2UjBNa1NHbFdzeGhL?=
 =?utf-8?B?dTdpMXdGanNFV2o2V3BPK3gvN0RhZGlnUjlXZXExa1U4TERlOEVhMnpnYlpN?=
 =?utf-8?B?cHlQeXhLK2JmbVl1ZDlMQkJNQzNIU1U3V3owdWVpbUMvaVFERnRHUzcwaElK?=
 =?utf-8?B?Vnc1MmMyRURSVXNlL3BqKzhRV0dWSisyUkhLb1dUMmxNMDJSb2pxUXVRdUI1?=
 =?utf-8?B?MUNmRS9idGFIOXdCaUp5KzJidjV2dmlyMGdzYzhUREtvQlJhc3RoUy9tdDcv?=
 =?utf-8?B?eTdrQzNCQXhxU3MwSFRGdm44SmM5Z2RRdlJLYWJROGpZWlo3ZlZHVm1aV2l6?=
 =?utf-8?B?MzVpUjhvSVptWnNxY2dpeEFydzBoNm0xRkFWQ1R0VWhMYmdnU2F0aVFCdjFY?=
 =?utf-8?B?OTg3VHQ1YXhSeXllTytObTZTMGtHN0RzUGtaS05nN3QwSWk5QjlOcUxNS0tL?=
 =?utf-8?B?RGFqb29kdDZYdkd4dlovSzVKWHBLM2doajZlVVNsS05NY21RNER3dEdRV1Ix?=
 =?utf-8?B?NGlZeXBxNU5uaWw5VVZRcDEvb1ZJcURUQm5FQVoxR2FIKzFhd1dHekEwR1ZV?=
 =?utf-8?B?SjkvTDMwaWMzY0FBR0lWcGhZelZiMHRpNlBrbi91TFl1R1VWVUxKak5JNmUx?=
 =?utf-8?B?UVNZbldMWHUzUU4wNWw3QTZZaDZFZm1LZS82dEZJdEJJeUEyZ3lTOHlDYmI2?=
 =?utf-8?B?OVh4ajFmdmk1OGZkWXJyQ3cwQVR4WnZXTGRiVTAzbGt6SG1qSjN6OWdSK21o?=
 =?utf-8?B?UjRZRzBYVUsvRWxEWTFHdGFLM0ZlWmE2RzV4VnJ3UlJsTHhlWDR3Q05jTVpn?=
 =?utf-8?Q?izRxwNVvLsKfh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlNUeTJNdDNYTkpCQnExUzNGcExrZ3RTbGtweFQrcUs0dzBobzVRTmZiSjF2?=
 =?utf-8?B?Mlo1RXB5NVAzWlFyNTc0MXFKMERwVGlMUWpod2hFTmIrU1BBK1h0V1hWTFE0?=
 =?utf-8?B?aG1LUTZiaE9SMjhWWi9kUVlITUtEcEhnNVJjd3FaeHo0clVYN1hlWDNiSnY4?=
 =?utf-8?B?Z1BmNjZlNVdVUVl0ZWRqek1pd3FraDZSdkpTRjViVHErOHl3QlNta3FSbWtV?=
 =?utf-8?B?TmFMYlIxSG5SMC9SUmlZZ2FLWnJuZGxPNkJFNnRDeURnLzJPQm1yOFZaTEw5?=
 =?utf-8?B?cFZiSGw0dWl1V0t3VnpoT0JuVVp0QXloRzUrS3E4S1RXY0xXcDNDWGUvTjFo?=
 =?utf-8?B?elU4ajJmUndibHdqUjlqc09TYUU4WE9oREh4ZEUySFV6MWdOeCt3cGZwMk5Q?=
 =?utf-8?B?SjB6bjFNTXB2NVpTRDk0SFA5UVF3bDE4d2ZtVHZnSzVuR2FxVWVtaHFpWngr?=
 =?utf-8?B?eC93Ry81dllDcVB4bkduQkNXM3cvNEZab0N2ODhhKzlqU2tBanlINTRPQ2s3?=
 =?utf-8?B?RjF4SVQrVHZCVVhjVTRlUEwrQ20xWER0S3dPd0ZCem5UbXJkQlZ4SUNST0li?=
 =?utf-8?B?NDEzcGJ4ZTkvRWxubThjNlN2WnhnMC9Md3pCVHBtY2RzZXJhMk9DdGsyMFIv?=
 =?utf-8?B?U3k2dWhrQ05leVcvRU9sR1pWS3cybjhWRHJOYkxva0VIOXluTnRxa3M3VVp2?=
 =?utf-8?B?R1BNdDE0VjhDb0FrdEZ6UTkzOSsyVlYvSEpzZEorZnRCOWpocFNGU0NXMVk1?=
 =?utf-8?B?VUVMUzF3WnVpTk5DUXZ1QTFjcEdZZjlpd0tkVk5XWlhPNnAyM0N1UWsyNm1V?=
 =?utf-8?B?clNkc2dUMG4yZVVnMm9HVHlncTVGVVpOWHpKRjIzTVowUjFwK0hLNHp1djJI?=
 =?utf-8?B?QzVFc3Q0bzJrTDhXY0NtaVBMYUlLd0pCeXpIWDlzdENQZVNuREJqLytxYS95?=
 =?utf-8?B?N2pyK0FGc2ZVWmRUeitZRVpXbTF6anBuTmlVKzVwZktiTzI5c1Izc1c5cnl2?=
 =?utf-8?B?N1VVOFN0K1hnZGt1WmpzOUN3RFhXbGJNYWY1c1hESExmREVuUFlGMXNSLzN3?=
 =?utf-8?B?UjJMbElwSXgyVkpEQ3o1WE5VQmlKOGR0ZkM4OUpDSStVMDlrSmYwZncvUFhL?=
 =?utf-8?B?bzB6cjB1VHVPSDhaSzRHeHV1THc4WGNjbHNaMDJqemVIMWh4V3NrMjdHc1lI?=
 =?utf-8?B?TUNGbmg0OVFDMklPQmdKOVFZUkpaM2Q5Qks2Tk1lYmZ5QVBsY2NSVVg3eXYz?=
 =?utf-8?B?clNDWG84WFZHZzFPK3duWWVyS0pUVlViM3dMdC8vQ0t1d3p1THdFTVF6RGdq?=
 =?utf-8?B?SnhqMVpqekZpL0xsenpXZEZwZmhJQ3NRSVQ4RUNwM21CNlFJN2hwQkFvR2lw?=
 =?utf-8?B?dXMwUlRndW9sWElRbE9YKzhLa3ZSNFZadlJWWFA5WHRHWmVTWklVcTN0dXN6?=
 =?utf-8?B?Y2ZRYXlYZHkrV3hNYnJyUm1pNXZnWkw3eE11dmtDUWgyZ2tvNHpEd1lIK29Z?=
 =?utf-8?B?dmR3NW9USHRkRDlKU21QMHc4YldpMnVGU2JtRTdZZlBoeW9UV29rRk5tL3BK?=
 =?utf-8?B?ZEw2bC9aWFFwOGRIUzVHZXYva2lBSnVLNk9YN2QzZ0ZRS3gyeVIyRG14YkhX?=
 =?utf-8?B?QmM2UXNZRjZzZ2FRVEFPREx1SHZXM3FLQVJZT1VhcjJKU0hoYndkMzgwL0ZJ?=
 =?utf-8?B?ekdpTUk1ektIandhd09qZ0dvK0IzMWRaNHpWQUpPM1g5dnlLVEFlMUR4YXFU?=
 =?utf-8?B?ZHVnTldjYnAwS2JTd0JGVEdHOHUrQ3c0djNwV3czUE11cEhJbk5MRXh2QWtW?=
 =?utf-8?B?UDUwQTBYWVdEazVFb0V5Qno3dXp1OWVTbWxMQTNuMFI4T0tRQ3diQ1BuSVQw?=
 =?utf-8?B?VENHUnZielErOGg0UG9HMllDNzFweVFwTmJzbHEvZ0lvQzBNcHpNMjArSzBH?=
 =?utf-8?B?YXJqTDJrK3RDQnd0V3g5RGk4Tis0Njc3RzNCT210YU9zem5TeVZiZElCSjNC?=
 =?utf-8?B?ZmlMbzU4SVM4NXEyYUV0cS9VcmpyMitmSlhmV2IxQUhqRythSkkyU2lwZTZN?=
 =?utf-8?B?SHJMd1kwTE1oa2dNTjVMTWZ5cEtzNDJQVnZERlRCUVRsd0VtZ0NjRjZYZUFK?=
 =?utf-8?Q?MqIEqPsG7YCnLqordogh8g01R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ae3999-51ba-44ea-b4f3-08dd478aa2da
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:18:12.3361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbLnvuHIumdNwBLocUZVZ6tIO19YPKnpYvCvqnyiX6hmmdCEiyZYuhijia4neKsV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
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



On 2/7/2025 8:06 PM, Kim, Jonathan wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, February 7, 2025 9:20 AM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
>> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
>>
>>
>>
>> On 2/7/2025 7:29 PM, Kim, Jonathan wrote:
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Thursday, February 6, 2025 10:56 PM
>>>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
>>>> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
>>>>
>>>>
>>>>
>>>> On 2/7/2025 5:03 AM, Kim, Jonathan wrote:
>>>>> [Public]
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>> Sent: Thursday, February 6, 2025 8:13 AM
>>>>>> To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kim, Jonathan
>>>>>> <Jonathan.Kim@amd.com>
>>>>>> Subject: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
>>>>>>
>>>>>> Initialize xgmi related static information during discovery.
>>>>>>
>>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 +++++++++++++------
>>>>>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>>>> index eca431e52038..d4eade2bd4d3 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>>>> @@ -2502,6 +2502,19 @@ static int
>>>> amdgpu_discovery_set_isp_ip_blocks(struct
>>>>>> amdgpu_device *adev)
>>>>>>       return 0;
>>>>>>  }
>>>>>>
>>>>>> +static void amdgpu_discovery_set_xgmi_info(struct amdgpu_device *adev)
>>>>>> +{
>>>>>> +     if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(4, 8, 0))
>>>>>> +             adev->gmc.xgmi.supported = true;
>>>>>> +
>>>>>> +     if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
>>>>>> +         amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
>>>>>> +             adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 4, 0);
>>>>>
>>>>> Can this stuff get rolled into xgm_init_info and called directly into
>>>> amdgpu_discovery_set_ip_blocks?
>>>>> Breaking up discovery_set_xgmi_info and xgmi_init_info as 2 separate things
>>>> seems a little confusing.
>>>>>
>>>>
>>>> Intent is like this -
>>>>       Set IP version info. This is the job of discovery and kept inside
>>>> amdgpu_discovery.
>>>>       Set any static information derived out of IP versions and not available
>>>> in discovery tables. This is kept outside of discovery file.
>>>
>>>
>>> Then why are you proposing to set up static information in the discovery file in the
>> first place?
>>
>> I didn't understand that statement. The function - amdgpu_xgmi_init_info
>> - called from discovery sets up the derived information. Only IP version
>> info is set inside discovery.
> 
> Snip from you're last response:
>>>>       Set any static information derived out of IP versions and not available
>>>> in discovery tables. This is kept outside of discovery file.
> You're calling amdgpu_discovery_set_xgmi_info which calls amdgpu_xgmi_init_info which is setting static derived information in the discovery file.
> A wrapper called in a wrapper is still doing the opposite of what you're saying int the snip above.
> If you're trying to avoid this and keep discovery clean, call xgmi_init_info in amdgpu_device.c somewhere after the IP blocks are set.
> And put xgmi_supported definitions in xgmi_init_info since that doesn't count as IP version setting.
> 

This is only about structural segregation - like the place where we want
to maintain xgmi related data. Functions setting IP versions and
information from discovery table is kept inside discovery. Any function
which adds further static data out of the IP version is kept in the IP
related file.

This is not about a logical separation like xgmi related information
derived from an IP version shouldn't be set at discovery phase.

Thanks,
Lijo

> Jon
> 
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Jon
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>> +
>>>>>> +     if (amdgpu_ip_version(adev, XGMI_HWIP, 0))
>>>>>
>>>>> Maybe roll this check into xgmi_init_info i.e. void early return if null.
>>>>>
>>>>>> +             amdgpu_xgmi_init_info(adev);
>>>>>> +}
>>>>>> +
>>>>>>  int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>>>>>>  {
>>>>>>       int r;
>>>>>> @@ -2769,12 +2782,7 @@ int amdgpu_discovery_set_ip_blocks(struct
>>>>>> amdgpu_device *adev)
>>>>>>               break;
>>>>>>       }
>>>>>>
>>>>>> -     if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(4, 8, 0))
>>>>>> -             adev->gmc.xgmi.supported = true;
>>>>>> -
>>>>>> -     if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
>>>>>> -         amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
>>>>>> -             adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 4, 0);
>>>>>> +     amdgpu_discovery_set_xgmi_info(adev);
>>>>>
>>>>> If you do the suggestions above, you can just call amdgpu_xgmi_init_info
>>>> unconditionally.
>>>>>
>>>>> Jon
>>>>>>
>>>>>>       /* set NBIO version */
>>>>>>       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
>>>>>> --
>>>>>> 2.25.1
>>>>>
>>>
> 

