Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFC7D12696
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 09:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA30010E762;
	Wed,  3 Dec 2025 09:42:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SORKJR6l";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010017.outbound.protection.outlook.com
 [40.93.198.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C18D410E763
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 09:42:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wzik9oKzKYAyoWnSEDqBB1lfV2WSoXwCZNu2hyMI5rGl2c9ZBHO7pftsksSvrkh7QiUd6aB194FAOEF4TyVLy5D9AMpB8RE9nqmXJyNzXR7lWKJXVqMqGmzNgK4jhtyb6BQIKqgRf8okwF0PWjxwdRjdWPebmmmpR3UwUh8gy+KXj2v9ctNklcb9p0swaVLZZRb9uSlGanuuDoPhsXlwuwTFOfoUSmt6qW+grotZRklbSaMEk05bshzwVMo90PutcDIlEc1+Bvr3ZZ4UVqcg5CDQeVs8sF9Mi10E3l6qFy8cP9EHHaYowbsoreA+D7muO51/OHt6I8tDRKx50zPn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8Amo31kxPtttpxazKrHazs/YUndrS+HMgOEbwFVseI=;
 b=FUDmmXbgWosujmcQuxN9DjzahKeASYUrrkd0Rv0XoQp+CtmqeKH0WwF3TVzbAMyMtJ0iGWNBPhY895AUWKPy1Uk3IzhZmRNgdh3HP8bUttp74Er4hA/3J3KuHMZoUwb7S8gBSTtMjwzyzjABln1OpEe1JtPx7mEspPpL8l5C5Wg6Sl4ghBcdHVJv6/8Iv60FUdctWwt3tfExN6XYaVg75b51hULUNWTKz6LXWDRDsW/A1Lzso9Kl4fWzvKB1LcLIXbR7+fYXtAne9V2viPoEee+PhORmslULXBUvmSJTkZpXtci6HZbKNRP7jM3fii8YJGl0Kj+aufMy3klX9vyG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8Amo31kxPtttpxazKrHazs/YUndrS+HMgOEbwFVseI=;
 b=SORKJR6lzFnUSj9Elp98LTXGdYo46WJ3Lbyn3h8IGpFZ6r4g7J6oCqGjYliLX6yhtTSJiex/Bw4xRkEEAb1QtfD5OUMVpKg3aGO7lu7PtaNjsFRkLHCkDcSTxxyzctIBd6A9nZ3M7KbUfcO3XM6D8lXP7oRqNeKZD9cEPolHFhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12)
 by CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 09:42:13 +0000
Received: from CYYPR12MB8892.namprd12.prod.outlook.com
 ([fe80::a8d1:60ba:b228:2d5e]) by CYYPR12MB8892.namprd12.prod.outlook.com
 ([fe80::a8d1:60ba:b228:2d5e%3]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 09:42:13 +0000
Message-ID: <0bb4a734-5263-4011-9ca6-eedcbf3bc50a@amd.com>
Date: Wed, 3 Dec 2025 17:42:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/amd/display: Refactor dml_core_mode_support to
 reduce stack frame
Content-Language: en-US
To: Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Austin Zheng <austin.zheng@amd.com>
References: <20251202102437.3126523-1-chen-yu.chen@amd.com>
 <20251202102437.3126523-5-chen-yu.chen@amd.com>
 <38b6e3e5-fcee-48c4-bcac-5aee8feb289f@amd.com>
 <7eba047f-b427-4191-94c0-eda17bbb99ed@amd.com>
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
In-Reply-To: <7eba047f-b427-4191-94c0-eda17bbb99ed@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0042.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::20) To CYYPR12MB8892.namprd12.prod.outlook.com
 (2603:10b6:930:be::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8892:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e19da1a-d6a2-42da-a791-08de32503cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnpMYVJrTzFLanI4dkRHVlhEWEhrTmpkSDFIVTMwMDhTUlBUNGlCTXRWaTdi?=
 =?utf-8?B?UVY3UEtmdDlUWGNWZi9Hc2FDVkdRY1FvWTd3MnA0ekQ4c1RQY2V0SC9QZEJJ?=
 =?utf-8?B?SEhkRjNnWXVNQkZrQ201a2phd3lKc3FpK1A3Wmk0U2lpelZNWWJydlVLaDR0?=
 =?utf-8?B?akxrVGVNMmltSFFQczN3TmdXajlwVDkvRnlnMjRjbmJlK3ZoZ0pGQ1FpQkZt?=
 =?utf-8?B?RlFyL0g2NHFGbWJFZ3VFYzlTNUlDQTNQTzBKNFhCMlE4c1ZhWFNSSnhaWWtN?=
 =?utf-8?B?dVVrcUswdG15UFhid2k4WEpTL2lTMFhQakVXYkJ1NDdBaklZNkZpbno2U3FO?=
 =?utf-8?B?M0F5S2thYzdyazhyaHFleG54T3NJOUFXZUw3RGlIaktaVDNxc3ZzTDhVUlFk?=
 =?utf-8?B?d0x0emc3Q1JFY1BkWUF4V1llQ1psSjB2TG1veXoyM0VCOTQvR3JYZGdMU1d3?=
 =?utf-8?B?RFY5azQvNjc1ZXU3amhTV2c0Vjd3ZXNyRkxld2NiU2NCSUdjYm9KcFQ2Y3ll?=
 =?utf-8?B?b21EZ0k2ZHNFMThic3c1dml3R1VlbWVtcHZ1SG02WVhwNjJDTjN2Z2RWNkVP?=
 =?utf-8?B?Q2dnMnRkUlRPQW9CWUNQTmtnMUUwRnRPNTNSV2c1TVYwNHY0L0psYXVBR1NM?=
 =?utf-8?B?L2J4VzNueGdXWXVEMkJzMnNnMlFMLzQ0cWtSTkZ6QXJ3SnhvUE1IUk1UaDZI?=
 =?utf-8?B?M3dRaGZPNmtVd3FMa3JHVWdpd1lTc2RmUXlGaDl1L3VWRlIrNzB1WklrWGcw?=
 =?utf-8?B?bjVxRm92ME9ueWFwRUFmVmhLempNQ0I1emd2V0lsTTU1eXp1RnNPTDc5THFl?=
 =?utf-8?B?aE5RS2piOVJjSjRmY1FnVHo5cmhXWjlBUkhobjIzNkNJNmRFVzlaMUtreHF2?=
 =?utf-8?B?SmJUQTNnUXVLYVZta2g1WXJ5cXpqUDVHZDVkSGtEbEdJV3BHVjB3ZjVUcEl0?=
 =?utf-8?B?bUdJRUo2czhlaVJ4bmQ2cTI5S0V1QTg3dFh1bkVpaUJRYzVRckgwTThBZjFE?=
 =?utf-8?B?QXhNM3NVM2J3cGRORzlvcko5MTByZ0FQVGIxa0JWOExzdmVwVk90cjdBditM?=
 =?utf-8?B?aEtIUkl6VC9mdlh0emhxZnowQ3d4SEhqTnIwdm9rYjhRU0luQkZrQVFPbFQ0?=
 =?utf-8?B?aE12Y0hsZjFtclR6dDZTWjgxN0hEZkx0am9IbVFkYmpBSVZmQkFBVm1QakRG?=
 =?utf-8?B?eE96ZmxOYmNVTE4zbzR0cXJWZCtaa1Q4NHVsbzV5UC9XamxsS2J4cy9NYjgy?=
 =?utf-8?B?bW5qNlJ3b3c0TFJVbDk3eEIxZ3FnY3F2UjdpcmIrSmx5WEJyOTd4WCtTOVZQ?=
 =?utf-8?B?OGRyeDZpcno0UXZ2aGtMZmhxd1p0Z1pEaVJHRHpjcHpIUzRBUEs0Ly85QnhE?=
 =?utf-8?B?bGhPck41bkt1WXJ5eXFaNFRSak9xY0pJMlVPbGcyM2tBb1JqVlNnZTBBRUNR?=
 =?utf-8?B?NTJQb0JwOGpjVEx0bGdDVFZMemdPZFZJK0RnN0p2eURlREVQUnVxeTdxZE91?=
 =?utf-8?B?Y3c1UDdieUluREF2QzZhYVQ3QmdzUS9VbDQrTThSY1ZidWx3NmlaYlp3RXdW?=
 =?utf-8?B?anFGUCtrdzdKYVozL1NNeEtSelVybytjdGQ3TlFWUXprYTQySzl6ODRQcXRp?=
 =?utf-8?B?MkdEbXREUFF3YkVpZnVmWmFCdFRGeEoyU0hZNHJpU0dBRlZtVTdWMHBTYytH?=
 =?utf-8?B?YXNxQlZCZFVoSU5WdW1EcEtBaWh2Qld0SFN0WCtwNm94Y254cVBzRHEwNmpa?=
 =?utf-8?B?amtDVGdObFBGL3hrT0JVd2kySDJJYmdacjRqQlpFLzBhVWR1WVU5elR1R1RQ?=
 =?utf-8?B?akVjRWJYTlpZcWkxQlY1ZkFuN0V6aEw5RlNjVG9YQUFmY1N3RS9Ea0VWc3Zi?=
 =?utf-8?B?SXlkNngrbzg1RjVnNkd4ZzBtQS9EbVVGcy9yZVYzY29HZjBNeU5mdjdydVhq?=
 =?utf-8?Q?Bd+pccpcnS6o53bdWLMcGgos8uUynlEY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8892.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUZ5N0wvdjVTa1Vpcld4RHk3YzRJUzdxNStwMjVtU1ZxTjdwRnFOa1UwVDF2?=
 =?utf-8?B?TEp1OXlGc29Sb2lxVTgyQi9UajNLMHpwREVTd3diTm5IdGhUYmNzL1U0Kytn?=
 =?utf-8?B?cmNSUmNGRTRYVFBETU1Jc2FCTFpVTEErTzF3NHpTZDFMcUpmWkhOODdpM290?=
 =?utf-8?B?ZGJBNUZaTFZ0SC9iNmdWRkp6Tjk0bmNLajB2NWJOUGpiSjhMYlQxREFvRG5h?=
 =?utf-8?B?WXVFZW01MXBEY2ZsMnVRZityMlJBN2R4S3RwYTgyWkl3bGVJUzBZTXdtZ1JH?=
 =?utf-8?B?dmJTd2h2WDV4T08zZ3lZUnlRUVJWN3hxeENlRWhJQnhSYmxZVnFVb1J5cHpt?=
 =?utf-8?B?YVR6RytUSnlTeDN5d0o5c05UTkFkOUl0TFZHMVNmSzRVWjIzTFlUc2R5V0VM?=
 =?utf-8?B?TmVMdHA2eHhQdUd5QlQ2cU43RVlPV0ZqWlBLcXFKS2h6OTM4ODJIYkhqSlY4?=
 =?utf-8?B?MnpUUE9kV3NaZDNCcFc3N2g0OWlHNTArdGQ5TUk5dHk4MEFPQzBxTGl4b1JR?=
 =?utf-8?B?RzYyaDFNS0gzZnB1eFdoK1ZsMjdmaXBvekYwcTFKaGxYc0V6emo2NlZGVUVm?=
 =?utf-8?B?WjVIM1RCQVJjamtGcTVXLzZPZU5INlFUVlAwYUlua3VXV0p5YU84NFlQakxH?=
 =?utf-8?B?ZVFTaVJkMUpXS25zMHRHTitZeDV4dWtQQmhDb2duM3VJeWJrOFpBYVdPdG5E?=
 =?utf-8?B?NDMwc0w5Z2RpaWtLd25neWdSS0x2bG9LK1IwWVd5ZUQzdmJRY0ZlZUdPSWV4?=
 =?utf-8?B?enJHTVFhQ1M1VnhjZVl0YWZkSSs1cTJSeDB1QWhWMnh4QndGZEZSVURNTU0r?=
 =?utf-8?B?a0tEVE90QXdsYiszTE02bGFDeERFMnkvMFJBbjEvSnJzSUZQdUdHVFNxVlZZ?=
 =?utf-8?B?Rnd4aXhBYnNQOHhlZ2lpVkkvaStoNHIrMmR2TVlwR3Z4UW13UkkvZCtRZ3J5?=
 =?utf-8?B?dEZ4ZUdULzBJUHBYdUE3T2tXWmw3V1kxdSt0bmNSZ3NkbWowOFVueFVHbTFB?=
 =?utf-8?B?VkU4WXAwVERuM3J1ditKWmZDcytxVjREeGxwaG8wVFpCUHhMT2s2T2cwRXhk?=
 =?utf-8?B?R1lTaEowMjRhMklwRkxCR1lxeTYyRFp0K09CenNqeUl5cTJ6Zlh1R3EwRXZ6?=
 =?utf-8?B?Mi9qTFJXRW1Fd3lMMU9rNzNuTzJCZnlKT2hodWg0S1dtT3M0U0ZMayt3WW1z?=
 =?utf-8?B?Z0t3ZGw4Q1pnV3VTUVVRdCttamNkSGZFT09xeklNVkNRcDNKSWJuKzRWNi9I?=
 =?utf-8?B?ZGJVZDRyZFYxMlJIOTU1cEo4a1NLREpoN2JJWGFHNXdBYkdKbktSNldZM1lH?=
 =?utf-8?B?TDNWSlUyRS9FK1NaVU8vR1BHcXIwWjdnelhvbVVVRGVNYVRzYTZYOWFsZDVY?=
 =?utf-8?B?V0h2ayt0NmpoZjJPOG9tWjZHaWFKNzBpTTRjalM3bGlpTktpSWZmZ015Y0x0?=
 =?utf-8?B?amF4amJQUElOQ0lIK2tBWVBsdG5yUnNDSk5lTXdBWUlQc2ZHTkFIcTlPVEVx?=
 =?utf-8?B?aUNBbC82ZFlFaFdOZzFCa040SEJvbWV3OHFjcmFobjZXRHNPRVlpRlZHWjRO?=
 =?utf-8?B?WjNPVUw4SWJ3T25KbTVzaHlFNHA1dFFTbGV0K3E2eHp1N2szSkFDN3VmZUVZ?=
 =?utf-8?B?bFYrclVFQjlJeUZqdmFDbVhyZlNkNzJVb2Uvb05OODJBQnZBZXBRV3JLM1M0?=
 =?utf-8?B?emVDRjZMdkNMcmpSaTArNitsMG9xNHk5MUp5TGRsZkN3Wko4L21nS3N2a1l3?=
 =?utf-8?B?enJCOFRMSmQ0clZNcWtCeXcxU29oTW5qMzFXWUl1TEMxZGhRU3IrRjFQbHVv?=
 =?utf-8?B?SHVBUjNZdGpBZkR0OUQ2OFV3a1MvMFlLSFRzMFdsbmM0TTdOeW11MTFneFc2?=
 =?utf-8?B?blh5MVMzMlUvRHR4cVlFWEVkU2s1bFRkV3g2V3RKSXZSUlN1aUJvYVVkUFVK?=
 =?utf-8?B?dkEyUVN5UmV3T3kzcFF5a2FzTmRlZDVmazlvbzBDV2Mxd2wwOWZVOC9YWHpr?=
 =?utf-8?B?NUMvTXRqMXFLbUlGaTZjSUx5SHk4K3c5KzB6d0tER2IrQTBLQ0xxNkoycjVN?=
 =?utf-8?B?TEh0UkpaQnpoQU9aMTU1YmZtTE5pZy82YWdtbTFKWEs5REEzOC8xbXJwWkt1?=
 =?utf-8?Q?WAlYGoIsNIusdpeVp7qZ56n1c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e19da1a-d6a2-42da-a791-08de32503cee
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8892.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 09:42:13.6872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqoI1GkHWe5AIeuVJ7L9zeIWSH5Re68B79tKJuFEfnAg0aH7rBdZUypOOC2iDWu1uZP2NChURU7Icdi0/rWvyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284
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

Hi Alex,

I wiil add it before upstream.

Regards,
Chenyu

On 12/3/2025 12:31 AM, Alex Hung wrote:
> 
> 
> On 12/2/25 09:29, Alex Hung wrote:
>>
>>
>> On 12/2/25 03:21, Chenyu Chen wrote:
>>> From: Alex Hung <alex.hung@amd.com>
>>>
>>> [WHAT]
>>> When compiling Linux kernel with clang, the following warning / error
>>> messages pops up:
>>>
>>> drivers/gpu/drm/amd/amdgpu/../dal-dev/dc/dml2_0/ 
>>> display_mode_core.c:6853:12:
>>> error: stack frame size (2120) exceeds limit (2056) in
>>> 'dml_core_mode_support' [-Werror,-Wframe-larger-than]
>>>   6853 | dml_bool_t dml_core_mode_support(struct display_mode_lib_st
>>> *mode_lib)
>>>
>>> [HOW]
>>> Refactoring CalculateVMRowAndSwath_params assignments to a new function
>>> helps reduce the stack frame size in dml_core_mode_support.
>>>
>> Hi Chenyu,
>>
>> A bug seems to be related. Can you add a buglink? Thanks.
>>
>> Buglink: https://gitlab.freedesktop.org/drm/amd/-/issues/4733
> 
> Correction, Add "Closes" instead of "Buglink"
> 
>>
>>> Reviewed-by: Austin Zheng <austin.zheng@amd.com>
>>> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>>> Signed-off-by: Alex Hung <alex.hung@amd.com>
>>> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
>>> ---
>>>   .../amd/display/dc/dml2_0/display_mode_core.c | 134 ++++++++++--------
>>>   1 file changed, 71 insertions(+), 63 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c 
>>> b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
>>> index c468f492b876..09303c282495 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
>>> @@ -6711,6 +6711,76 @@ static noinline_for_stack void 
>>> dml_prefetch_check(struct display_mode_lib_st *mo
>>>       } // for j
>>>   }
>>> +static noinline_for_stack void set_vm_row_and_swath_parameters(struct 
>>> display_mode_lib_st *mode_lib)
>>> +{
>>> +    struct CalculateVMRowAndSwath_params_st 
>>> *CalculateVMRowAndSwath_params = &mode_lib- 
>>>> scratch.CalculateVMRowAndSwath_params;
>>> +    struct dml_core_mode_support_locals_st *s = &mode_lib- 
>>>> scratch.dml_core_mode_support_locals;
>>> +
>>> +    CalculateVMRowAndSwath_params->NumberOfActiveSurfaces = mode_lib- 
>>>> ms.num_active_planes;
>>> +    CalculateVMRowAndSwath_params->myPipe = s->SurfParameters;
>>> +    CalculateVMRowAndSwath_params->SurfaceSizeInMALL = mode_lib- 
>>>> ms.SurfaceSizeInMALL;
>>> +    CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsLuma = 
>>> mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_luma;
>>> +    CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsChroma = 
>>> mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_chroma;
>>> +    CalculateVMRowAndSwath_params->DCCMetaBufferSizeBytes = mode_lib- 
>>>> ms.ip.dcc_meta_buffer_size_bytes;
>>> +    CalculateVMRowAndSwath_params->UseMALLForStaticScreen = mode_lib- 
>>>> ms.cache_display_cfg.plane.UseMALLForStaticScreen;
>>> +    CalculateVMRowAndSwath_params->UseMALLForPStateChange = mode_lib- 
>>>> ms.cache_display_cfg.plane.UseMALLForPStateChange;
>>> +    CalculateVMRowAndSwath_params->MALLAllocatedForDCN = mode_lib- 
>>>> ms.soc.mall_allocated_for_dcn_mbytes;
>>> +    CalculateVMRowAndSwath_params->SwathWidthY = mode_lib- 
>>>> ms.SwathWidthYThisState;
>>> +    CalculateVMRowAndSwath_params->SwathWidthC = mode_lib- 
>>>> ms.SwathWidthCThisState;
>>> +    CalculateVMRowAndSwath_params->GPUVMEnable = mode_lib- 
>>>> ms.cache_display_cfg.plane.GPUVMEnable;
>>> +    CalculateVMRowAndSwath_params->HostVMEnable = mode_lib- 
>>>> ms.cache_display_cfg.plane.HostVMEnable;
>>> +    CalculateVMRowAndSwath_params->HostVMMaxNonCachedPageTableLevels 
>>> = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
>>> +    CalculateVMRowAndSwath_params->GPUVMMaxPageTableLevels = 
>>> mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
>>> +    CalculateVMRowAndSwath_params->GPUVMMinPageSizeKBytes = mode_lib- 
>>>> ms.cache_display_cfg.plane.GPUVMMinPageSizeKBytes;
>>> +    CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib- 
>>>> ms.soc.hostvm_min_page_size_kbytes * 1024;
>>> +    CalculateVMRowAndSwath_params->PTEBufferModeOverrideEn = 
>>> mode_lib->ms.cache_display_cfg.plane.PTEBufferModeOverrideEn;
>>> +    CalculateVMRowAndSwath_params->PTEBufferModeOverrideVal = 
>>> mode_lib->ms.cache_display_cfg.plane.PTEBufferMode;
>>> +    CalculateVMRowAndSwath_params->PTEBufferSizeNotExceeded = 
>>> mode_lib->ms.PTEBufferSizeNotExceededPerState;
>>> +    CalculateVMRowAndSwath_params->DCCMetaBufferSizeNotExceeded = 
>>> mode_lib->ms.DCCMetaBufferSizeNotExceededPerState;
>>> +    CalculateVMRowAndSwath_params->dpte_row_width_luma_ub = s- 
>>>> dummy_integer_array[0];
>>> +    CalculateVMRowAndSwath_params->dpte_row_width_chroma_ub = s- 
>>>> dummy_integer_array[1];
>>> +    CalculateVMRowAndSwath_params->dpte_row_height_luma = mode_lib- 
>>>> ms.dpte_row_height;
>>> +    CalculateVMRowAndSwath_params->dpte_row_height_chroma = mode_lib- 
>>>> ms.dpte_row_height_chroma;
>>> +    CalculateVMRowAndSwath_params->dpte_row_height_linear_luma = s- 
>>>> dummy_integer_array[2]; // VBA_DELTA
>>> +    CalculateVMRowAndSwath_params->dpte_row_height_linear_chroma = s- 
>>>> dummy_integer_array[3]; // VBA_DELTA
>>> +    CalculateVMRowAndSwath_params->meta_req_width = s- 
>>>> dummy_integer_array[4];
>>> +    CalculateVMRowAndSwath_params->meta_req_width_chroma = s- 
>>>> dummy_integer_array[5];
>>> +    CalculateVMRowAndSwath_params->meta_req_height = s- 
>>>> dummy_integer_array[6];
>>> +    CalculateVMRowAndSwath_params->meta_req_height_chroma = s- 
>>>> dummy_integer_array[7];
>>> +    CalculateVMRowAndSwath_params->meta_row_width = s- 
>>>> dummy_integer_array[8];
>>> +    CalculateVMRowAndSwath_params->meta_row_width_chroma = s- 
>>>> dummy_integer_array[9];
>>> +    CalculateVMRowAndSwath_params->meta_row_height = mode_lib- 
>>>> ms.meta_row_height;
>>> +    CalculateVMRowAndSwath_params->meta_row_height_chroma = mode_lib- 
>>>> ms.meta_row_height_chroma;
>>> +    CalculateVMRowAndSwath_params->vm_group_bytes = s- 
>>>> dummy_integer_array[10];
>>> +    CalculateVMRowAndSwath_params->dpte_group_bytes = mode_lib- 
>>>> ms.dpte_group_bytes;
>>> +    CalculateVMRowAndSwath_params->PixelPTEReqWidthY = s- 
>>>> dummy_integer_array[11];
>>> +    CalculateVMRowAndSwath_params->PixelPTEReqHeightY = s- 
>>>> dummy_integer_array[12];
>>> +    CalculateVMRowAndSwath_params->PTERequestSizeY = s- 
>>>> dummy_integer_array[13];
>>> +    CalculateVMRowAndSwath_params->PixelPTEReqWidthC = s- 
>>>> dummy_integer_array[14];
>>> +    CalculateVMRowAndSwath_params->PixelPTEReqHeightC = s- 
>>>> dummy_integer_array[15];
>>> +    CalculateVMRowAndSwath_params->PTERequestSizeC = s- 
>>>> dummy_integer_array[16];
>>> +    CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_l = s- 
>>>> dummy_integer_array[17];
>>> +    CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_l = s- 
>>>> dummy_integer_array[18];
>>> +    CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_c = s- 
>>>> dummy_integer_array[19];
>>> +    CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_c = s- 
>>>> dummy_integer_array[20];
>>> +    CalculateVMRowAndSwath_params->PrefetchSourceLinesY = mode_lib- 
>>>> ms.PrefetchLinesYThisState;
>>> +    CalculateVMRowAndSwath_params->PrefetchSourceLinesC = mode_lib- 
>>>> ms.PrefetchLinesCThisState;
>>> +    CalculateVMRowAndSwath_params->VInitPreFillY = mode_lib- 
>>>> ms.PrefillY;
>>> +    CalculateVMRowAndSwath_params->VInitPreFillC = mode_lib- 
>>>> ms.PrefillC;
>>> +    CalculateVMRowAndSwath_params->MaxNumSwathY = mode_lib- 
>>>> ms.MaxNumSwY;
>>> +    CalculateVMRowAndSwath_params->MaxNumSwathC = mode_lib- 
>>>> ms.MaxNumSwC;
>>> +    CalculateVMRowAndSwath_params->meta_row_bw = mode_lib- 
>>>> ms.meta_row_bandwidth_this_state;
>>> +    CalculateVMRowAndSwath_params->dpte_row_bw = mode_lib- 
>>>> ms.dpte_row_bandwidth_this_state;
>>> +    CalculateVMRowAndSwath_params->PixelPTEBytesPerRow = mode_lib- 
>>>> ms.DPTEBytesPerRowThisState;
>>> +    CalculateVMRowAndSwath_params->PDEAndMetaPTEBytesFrame = 
>>> mode_lib->ms.PDEAndMetaPTEBytesPerFrameThisState;
>>> +    CalculateVMRowAndSwath_params->MetaRowByte = mode_lib- 
>>>> ms.MetaRowBytesThisState;
>>> +    CalculateVMRowAndSwath_params->use_one_row_for_frame = mode_lib- 
>>>> ms.use_one_row_for_frame_this_state;
>>> +    CalculateVMRowAndSwath_params->use_one_row_for_frame_flip = 
>>> mode_lib->ms.use_one_row_for_frame_flip_this_state;
>>> +    CalculateVMRowAndSwath_params->UsesMALLForStaticScreen = s- 
>>>> dummy_boolean_array[0];
>>> +    CalculateVMRowAndSwath_params->PTE_BUFFER_MODE = s- 
>>>> dummy_boolean_array[1];
>>> +    CalculateVMRowAndSwath_params->BIGK_FRAGMENT_SIZE = s- 
>>>> dummy_integer_array[21];
>>> +}
>>> +
>>>   /// @brief The Mode Support function.
>>>   dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
>>>   {
>>> @@ -7683,69 +7753,7 @@ dml_bool_t dml_core_mode_support(struct 
>>> display_mode_lib_st *mode_lib)
>>>               s->SurfParameters[k].SwathHeightC = mode_lib- 
>>>> ms.SwathHeightCThisState[k];
>>>           }
>>> -        CalculateVMRowAndSwath_params->NumberOfActiveSurfaces = 
>>> mode_lib->ms.num_active_planes;
>>> -        CalculateVMRowAndSwath_params->myPipe = s->SurfParameters;
>>> -        CalculateVMRowAndSwath_params->SurfaceSizeInMALL = mode_lib- 
>>>> ms.SurfaceSizeInMALL;
>>> -        CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsLuma = 
>>> mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_luma;
>>> -        CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsChroma 
>>> = mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_chroma;
>>> -        CalculateVMRowAndSwath_params->DCCMetaBufferSizeBytes = 
>>> mode_lib->ms.ip.dcc_meta_buffer_size_bytes;
>>> -        CalculateVMRowAndSwath_params->UseMALLForStaticScreen = 
>>> mode_lib->ms.cache_display_cfg.plane.UseMALLForStaticScreen;
>>> -        CalculateVMRowAndSwath_params->UseMALLForPStateChange = 
>>> mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange;
>>> -        CalculateVMRowAndSwath_params->MALLAllocatedForDCN = 
>>> mode_lib->ms.soc.mall_allocated_for_dcn_mbytes;
>>> -        CalculateVMRowAndSwath_params->SwathWidthY = mode_lib- 
>>>> ms.SwathWidthYThisState;
>>> -        CalculateVMRowAndSwath_params->SwathWidthC = mode_lib- 
>>>> ms.SwathWidthCThisState;
>>> -        CalculateVMRowAndSwath_params->GPUVMEnable = mode_lib- 
>>>> ms.cache_display_cfg.plane.GPUVMEnable;
>>> -        CalculateVMRowAndSwath_params->HostVMEnable = mode_lib- 
>>>> ms.cache_display_cfg.plane.HostVMEnable;
>>> -        CalculateVMRowAndSwath_params- 
>>>> HostVMMaxNonCachedPageTableLevels = mode_lib- 
>>>> ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
>>> -        CalculateVMRowAndSwath_params->GPUVMMaxPageTableLevels = 
>>> mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
>>> -        CalculateVMRowAndSwath_params->GPUVMMinPageSizeKBytes = 
>>> mode_lib->ms.cache_display_cfg.plane.GPUVMMinPageSizeKBytes;
>>> -        CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib- 
>>>> ms.soc.hostvm_min_page_size_kbytes * 1024;
>>> -        CalculateVMRowAndSwath_params->PTEBufferModeOverrideEn = 
>>> mode_lib->ms.cache_display_cfg.plane.PTEBufferModeOverrideEn;
>>> -        CalculateVMRowAndSwath_params->PTEBufferModeOverrideVal = 
>>> mode_lib->ms.cache_display_cfg.plane.PTEBufferMode;
>>> -        CalculateVMRowAndSwath_params->PTEBufferSizeNotExceeded = 
>>> mode_lib->ms.PTEBufferSizeNotExceededPerState;
>>> -        CalculateVMRowAndSwath_params->DCCMetaBufferSizeNotExceeded = 
>>> mode_lib->ms.DCCMetaBufferSizeNotExceededPerState;
>>> -        CalculateVMRowAndSwath_params->dpte_row_width_luma_ub = s- 
>>>> dummy_integer_array[0];
>>> -        CalculateVMRowAndSwath_params->dpte_row_width_chroma_ub = s- 
>>>> dummy_integer_array[1];
>>> -        CalculateVMRowAndSwath_params->dpte_row_height_luma = 
>>> mode_lib->ms.dpte_row_height;
>>> -        CalculateVMRowAndSwath_params->dpte_row_height_chroma = 
>>> mode_lib->ms.dpte_row_height_chroma;
>>> -        CalculateVMRowAndSwath_params->dpte_row_height_linear_luma = 
>>> s->dummy_integer_array[2]; // VBA_DELTA
>>> -        CalculateVMRowAndSwath_params->dpte_row_height_linear_chroma 
>>> = s->dummy_integer_array[3]; // VBA_DELTA
>>> -        CalculateVMRowAndSwath_params->meta_req_width = s- 
>>>> dummy_integer_array[4];
>>> -        CalculateVMRowAndSwath_params->meta_req_width_chroma = s- 
>>>> dummy_integer_array[5];
>>> -        CalculateVMRowAndSwath_params->meta_req_height = s- 
>>>> dummy_integer_array[6];
>>> -        CalculateVMRowAndSwath_params->meta_req_height_chroma = s- 
>>>> dummy_integer_array[7];
>>> -        CalculateVMRowAndSwath_params->meta_row_width = s- 
>>>> dummy_integer_array[8];
>>> -        CalculateVMRowAndSwath_params->meta_row_width_chroma = s- 
>>>> dummy_integer_array[9];
>>> -        CalculateVMRowAndSwath_params->meta_row_height = mode_lib- 
>>>> ms.meta_row_height;
>>> -        CalculateVMRowAndSwath_params->meta_row_height_chroma = 
>>> mode_lib->ms.meta_row_height_chroma;
>>> -        CalculateVMRowAndSwath_params->vm_group_bytes = s- 
>>>> dummy_integer_array[10];
>>> -        CalculateVMRowAndSwath_params->dpte_group_bytes = mode_lib- 
>>>> ms.dpte_group_bytes;
>>> -        CalculateVMRowAndSwath_params->PixelPTEReqWidthY = s- 
>>>> dummy_integer_array[11];
>>> -        CalculateVMRowAndSwath_params->PixelPTEReqHeightY = s- 
>>>> dummy_integer_array[12];
>>> -        CalculateVMRowAndSwath_params->PTERequestSizeY = s- 
>>>> dummy_integer_array[13];
>>> -        CalculateVMRowAndSwath_params->PixelPTEReqWidthC = s- 
>>>> dummy_integer_array[14];
>>> -        CalculateVMRowAndSwath_params->PixelPTEReqHeightC = s- 
>>>> dummy_integer_array[15];
>>> -        CalculateVMRowAndSwath_params->PTERequestSizeC = s- 
>>>> dummy_integer_array[16];
>>> -        CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_l = 
>>> s->dummy_integer_array[17];
>>> -        CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_l 
>>> = s->dummy_integer_array[18];
>>> -        CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_c = 
>>> s->dummy_integer_array[19];
>>> -        CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_c 
>>> = s->dummy_integer_array[20];
>>> -        CalculateVMRowAndSwath_params->PrefetchSourceLinesY = 
>>> mode_lib->ms.PrefetchLinesYThisState;
>>> -        CalculateVMRowAndSwath_params->PrefetchSourceLinesC = 
>>> mode_lib->ms.PrefetchLinesCThisState;
>>> -        CalculateVMRowAndSwath_params->VInitPreFillY = mode_lib- 
>>>> ms.PrefillY;
>>> -        CalculateVMRowAndSwath_params->VInitPreFillC = mode_lib- 
>>>> ms.PrefillC;
>>> -        CalculateVMRowAndSwath_params->MaxNumSwathY = mode_lib- 
>>>> ms.MaxNumSwY;
>>> -        CalculateVMRowAndSwath_params->MaxNumSwathC = mode_lib- 
>>>> ms.MaxNumSwC;
>>> -        CalculateVMRowAndSwath_params->meta_row_bw = mode_lib- 
>>>> ms.meta_row_bandwidth_this_state;
>>> -        CalculateVMRowAndSwath_params->dpte_row_bw = mode_lib- 
>>>> ms.dpte_row_bandwidth_this_state;
>>> -        CalculateVMRowAndSwath_params->PixelPTEBytesPerRow = 
>>> mode_lib->ms.DPTEBytesPerRowThisState;
>>> -        CalculateVMRowAndSwath_params->PDEAndMetaPTEBytesFrame = 
>>> mode_lib->ms.PDEAndMetaPTEBytesPerFrameThisState;
>>> -        CalculateVMRowAndSwath_params->MetaRowByte = mode_lib- 
>>>> ms.MetaRowBytesThisState;
>>> -        CalculateVMRowAndSwath_params->use_one_row_for_frame = 
>>> mode_lib->ms.use_one_row_for_frame_this_state;
>>> -        CalculateVMRowAndSwath_params->use_one_row_for_frame_flip = 
>>> mode_lib->ms.use_one_row_for_frame_flip_this_state;
>>> -        CalculateVMRowAndSwath_params->UsesMALLForStaticScreen = s- 
>>>> dummy_boolean_array[0];
>>> -        CalculateVMRowAndSwath_params->PTE_BUFFER_MODE = s- 
>>>> dummy_boolean_array[1];
>>> -        CalculateVMRowAndSwath_params->BIGK_FRAGMENT_SIZE = s- 
>>>> dummy_integer_array[21];
>>> +        set_vm_row_and_swath_parameters(mode_lib);
>>>           CalculateVMRowAndSwath(&mode_lib->scratch,
>>>               CalculateVMRowAndSwath_params);
>>
> 
