Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE08FC02199
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 04:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3074310EA17;
	Fri,  7 Feb 2025 04:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TncWa4Bj";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8880910EA17
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 03:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/W2/rCS8Kk76QAAIGi1nRT8gx8tXT/VNcBcKnchX1i/ulxeCvYkz1Ur5jJoJnPGj7Hq57u46n8JBK0drC3kXOom7SoejfVv0rgCkFEJju4LJ7TkiWF2zBYPfw23fNgJBH1olzW/nxRQRnOI08TyMWWgttaJiRsI5DbGLLOcVvknUE+u13DE9fdO9azlpBx8/+X2teeuU77+OITY2kWs10vA5auNAnLuTIrHA7ON4RXC/5AQtLJ1okH3qynAmToFd5RjmCuiEzYoLeMNWFy/tJr6hSW6eI4FpSu0hsJFqH84PT3n6D4SbzJQ3DQn5C0iMsbUNEOk9TLFnB6KgC+m9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbh+YWDGvdh9Lj1cVbjMRBHqzvFrZVgJY7LM8fpphsc=;
 b=Nq1zqwJTivaS3CAB11rwKPl6307fgdXqvp93K6uCzIil8fCo2nfiMGYwcph92M+HaaAO0DgEWljo2OZmdhnZB+AuYVqCHI1TVbh1lyxhio+KrmssuJaXzt3xoH2vjTjjdIwr456/Cohh/XgBdQ/hUhVCb+PbU2Oc95u4HIYhlHBu+UosWxV0w8Sf8GnNS48jM/b10l0nzhGeXqGORUIhzH/rmIbr0ZB4bFrR+KHRmWjHhUHl1xSpciKpQrSmGgCgkr1UCGIyC/DuXfPfPF9By8SzZEVnTcq4jihP2KA5X5mZVwgRhup/iYLB4No0nJukA1heEIED7bQ1a3WbmP/IhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbh+YWDGvdh9Lj1cVbjMRBHqzvFrZVgJY7LM8fpphsc=;
 b=TncWa4BjElFfZzVneRnxuY4d48Tr9TaDMP0ehJvq8ktBHe/c6LxFNSRMutORBt/7cit9Mju3PXMkPnor0pTVJz8gqDMIuYbuV3VBwUrXn6YnhOJvpkf4UU5XGLrjcOLI43pViOoEl/05y9ES7bvKKqjAeTCSD9DgZ9U67diUUEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 03:51:16 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 03:51:16 +0000
Message-ID: <19728543-a606-41bc-b4fd-464b7a1d7a94@amd.com>
Date: Fri, 7 Feb 2025 09:21:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu: Add xgmi speed/width related info
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
 <20250206131258.1970391-2-lijo.lazar@amd.com>
 <CY8PR12MB74358ACE4AA9BA563D3219E985F62@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY8PR12MB74358ACE4AA9BA563D3219E985F62@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::31) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c84bb9d-07ff-4cbe-eec6-08dd472aac2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWhlVldRcTFCMFZFa1NZQWozS055dEVLR3BJUklCY3pYRys0NVdOTlBkbUVX?=
 =?utf-8?B?dHFxbUJZc2UrM3E5clJOc0FlUmpvLzRZd2NVTnQ2ZkhQQzB1NXVsMU50a2Zs?=
 =?utf-8?B?OEZSa2NTdkRMOTE3TVB0S2lXZHVTRHFrYnVuNmtIZ3NJZm5rTnpVa0tSTlpt?=
 =?utf-8?B?UFdIaE8waTk0c2dybDZqcDd3cWRtZWxVbTJJUzgzbndUTnQ1YmNhRmo2WitD?=
 =?utf-8?B?REJUamd6TWVoS1ZzNzFHZGllWEdNVEs1ZGd4SGliUEdsOTZxSjRpeEZpU1pX?=
 =?utf-8?B?dElYbFZ6aFF2Sm0xWEhIQmhWeE1GWEVsMmc5aU92SC9IbEczRVY1aUU3Ry9q?=
 =?utf-8?B?aXVBcWRtTzBsRFF5WjhwSWFOUDROaGVnWG5sRDhkS1MrS2ppNHlDY0JVY0Nx?=
 =?utf-8?B?cXFSSE9PaGZiOE9qZmJnMFJmdDRWd1ZDOTQvYSsxRlRoaERxR3B4ZkZ1ZFFD?=
 =?utf-8?B?bXBUVXpiSUZ5dXp6WjUrSE56MFBJbVMxbERKa0hXVUdob1QxaExTRGhPV2hF?=
 =?utf-8?B?YXc5Wk9uYjJtelo3azJtUVpvWit6SC94RkdFT09HMjIwU0EvUmw3bytVVVVF?=
 =?utf-8?B?ODBhaUlFdy9Wd05YV3FPK2VvbTlUM3BGeHlMbHNzdFQ5U1dOdkIrQ0FnWFZG?=
 =?utf-8?B?ZFgyZ0J0TGdJclpZS2hvSW00eTVYNHo3SFJTMytKdGJOZjVJV00rTmZYbkRK?=
 =?utf-8?B?NnovMG1FQTE5dDNxcFpzUTc3MlZXV0syVUEzZG9DMEJJRUhoQmp6Zk5JQlRK?=
 =?utf-8?B?NVhlSjg1cGVpaDR5a3BxVUcrNTFRU2czVmNuTjQ2NEpoUVFmTDNnTDRid3FH?=
 =?utf-8?B?QVNHSHNuNkhCblR2a3QyZXdzeHRaVnR2d0FtYjlmMElzWllteXFOTzVNV253?=
 =?utf-8?B?NVBEOXg3SGtEK1NYc0pBVGVlc005a2ZDYnk5YVd4SEtuT0pJTnY5eG0rdkJP?=
 =?utf-8?B?T0Zma2cvbi91M0FQQitnbmlaTHhKQjBFOWlEb3Qxd1c4aXc1ZFpQOThwRUZL?=
 =?utf-8?B?WXlVL01YandLTkYvR3JPNGduQUxUZTdNdjBpd3NqZGpoR2R2UWh0eEFZaU5J?=
 =?utf-8?B?Z0w2aDlRR0g1U1dQNzFGRUczaTFwQzhBK0JBcE92a1BTVlRCNWdsZW00VnZ0?=
 =?utf-8?B?cFNubE9VSkJiYlovV1Z3bVA4WVJWZG1NUXRyS3V1SndKVGVkNFlkZE1ZN3dR?=
 =?utf-8?B?ZmROYkRFYlhBRTJPSWNJTWNCeVh4eXhORTJXQ1FYTUNtekFURzZ4MDU2STFn?=
 =?utf-8?B?WHpPR1o4b3BKcEdvcm5UbVI2OHNEN1IvWHpNTjRyRUVvY0xpakZvTys1QUlN?=
 =?utf-8?B?bWRQUGZ5bjF0azlUSjBabUQrbGhpRGRKMVd0QTk5ZkM5ZXdxdDJIWEJLYzlr?=
 =?utf-8?B?MWcya1VKZmlld3RoTDJhNkRoeDhpZHA2eTdVT24wNzFzOSttV1dkaVJvSjNX?=
 =?utf-8?B?aW9UU0tCZ2x0WWlPRUkwZ3BONlZKZHBGL1pQV1puQ3ZjdjhhQlZVeXYxREg4?=
 =?utf-8?B?RGQ5MHVVaVY2MVdaeVNhNm12ZysvV01vakhJdERrR2lTaGgyZktVcmZzWXVt?=
 =?utf-8?B?M2NueXdLRGNwSmRGazdLVEVWMmxiREJNaElOV1htZG5CM0ZSOHMrTnhKeGxz?=
 =?utf-8?B?ejhKZWE4cW1QSDU0SVc0azFXc09aK0xGSTR1QnJLQThKYUhLUDVWS1VLVTJC?=
 =?utf-8?B?em8vODkvQkpuTStkRGNxcCtxQ1FDdEJIT2dWZ3E1L1djKzVFbUNiVnVXNXNR?=
 =?utf-8?B?aExKc2FvMVJBbUFRTWhzN2Rpa0RpUU9LTFd1Y09jeHhWNkhDVTl6bXdzbi9B?=
 =?utf-8?B?Yys3MmRVUHFzQW1MQ1d5aEdvUmJJUkM1cWJUNzkzRDJaV2VLeERVQjRlMHQ2?=
 =?utf-8?Q?1x0qAKZ5bWPDg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWFEWitVc05na29wSGl2V0RDNm1XTTFwZklSckNHTXl3YXJ5enkwamQwakh6?=
 =?utf-8?B?cEI2ZVBOaVczRXowK1pXTjhxZldFb0RqNk45c0JlWk1Sb1NzLzhsZThCbEFT?=
 =?utf-8?B?V1pLbWlFUzhqV2JCSkZYaHZkTkF6RUJRd1cxVlV4Zi9GUVhhOVpqM2YyQys2?=
 =?utf-8?B?NHpvc0p2N3gzV1dDT0FRMkhDcnFIOTVYSWxNejJFNTVxTDYrQW5aaTJRWFdN?=
 =?utf-8?B?L3Q4ZmRnTzZnTGRRMXJBcWZDeDlBT0FYQ1k3dXlrc0VocjZ1MXN0QmpjTCtV?=
 =?utf-8?B?SWR4UXYvSU5tN1VnV1RYZXNBaks5WEk5eGtZZzNpZUNEdVpkcndMbGhPSzd5?=
 =?utf-8?B?N1lMMWdsc1kzT0Z3T21zMWpMaG1NYzdDYktwaTJOWU1OYWVIc1FjTjl3TEo4?=
 =?utf-8?B?Ry9NU3pHRC8rSFRVcFZkTkVNdyt1WGx2aG94YTFtY21IckErQXEwYy8zSFlJ?=
 =?utf-8?B?dkF3cjliZ2QxWnlQZ0UzTkhjczRybkM3aUJFSGI2eE1VOTlDWkxncldPbEZu?=
 =?utf-8?B?RUtPMjR6dXB3eEU1TTJMeHBJVWhsdGh1Q3pqWTBaR2hrbkdJUUgwSmhzY1lI?=
 =?utf-8?B?NnJjN0l5eXFTei9WVzNFdmdLUUVXQjFnTlFaY0hGclJ4UkFZdXhoWVRaVzRR?=
 =?utf-8?B?Y0IwUThuQ3BYVVRnVzVvbFhTeWtwR05sK3pMZ0ZwbVcxZEJna2QzaXhDaHln?=
 =?utf-8?B?WEpmY0VzdStzNTliVDRzU3l4TXRDRnZjK0JmVWxxM3BhZVB0NVhQMWU4Nkhw?=
 =?utf-8?B?YzF2WU9IUENKNjdIZk1nQzZQOGxwQ1VKYUdIcjJMZHBzY3RWZllzdERzQXgr?=
 =?utf-8?B?Y3Nvc2tBR3R4a3luRDR5Z2dWTk5WSXYya1ByTEF3V1FJQS9JWkpKUzJFc3Zp?=
 =?utf-8?B?Y3UzMlV0TW1STktSRElTV1c2TFpFNno0ZllONUdhMnp4UzlBRkI5NFZJT0d0?=
 =?utf-8?B?MDU4VFBkM0xweTZ3OWxVdjBwUnErMElyNXNIcmZxcVZrWWM3V3FZTXZSN2xp?=
 =?utf-8?B?aGx3V3JoUmVuRHhmK3BiNHBic25pOGRkUjlHeFpoVWZNL0pBZ3JqOEN0di9t?=
 =?utf-8?B?NUMrYng2a0s2N0ppQkNxenZ5bzJBSTUvQ3JQanczS3BLSjg3WkdsYzNLZEc2?=
 =?utf-8?B?V2xvN0orSzdtSkJ0N2ZnSWR1aTdJZThSVE9nRTBKR2d5MC9RdCtncWZOU0Q5?=
 =?utf-8?B?Q0psVlZqSHprWmdVbmIwNlkyK0pwV01UbzJIdmVLMllTRklobkRNOG9wVzJr?=
 =?utf-8?B?VVRnUjRKelFLZVM1YUxaNEwzajNWYmlWT29NSlJ6cG50dEhwVHQyYkdOdW1T?=
 =?utf-8?B?amVQTDRTcHg4TVZMbXFnc1A2Q2JlN0l3Q1BhZHluU24rOU0wQUlPR2d3WVht?=
 =?utf-8?B?QU1Tb2I4RjAyYUJjWXNhMFJFbFo5TWp6NXlWNzBDNGNaL0FDWGhJeWtBUXNa?=
 =?utf-8?B?ZGoyS1RrWmNySWdTS0pBVmZMdlI1Um9wTjNDRHMxRWFFZDJXaXZNWmdMRlhn?=
 =?utf-8?B?R0sxbkNZSndvbXAvYlU0WnVtRmdnVWdBaXlsQWgwUGdlN2ZRdFIzU0dWWGJU?=
 =?utf-8?B?eG1NMXh3dlB2Z1dRcHBZY1hCbmxTdmErSGNzWmpucjZpVUwvM2xpN0dpOW1T?=
 =?utf-8?B?M09aR01CZUlrdU1vdzVaZnNZM2Z5QW03KzFsbWxVeVpLQ0hveHJ2Vkgwazds?=
 =?utf-8?B?VC9SVGQwQncyYUZpcFJDKzk3M0RGOWhWWDRaTFlqVVExWGZXeEM2Wkk0T1NO?=
 =?utf-8?B?d2F1akZjV0w4VS9sQnZLZ0VhZmVMVG9rb3FRYzRzWDRWOWNWMW5MeEdzdFpi?=
 =?utf-8?B?RG1ORXI0UkJmeDNIdWI1ZHVBMjg5aVY2bmFKL0htejNMeWJIYldFK05JMUFH?=
 =?utf-8?B?bnZaREtDZENRdEs2dTk5alUrN204cVlKOFBRN2NtVVJ0WmtqRUw4UWZVZy9B?=
 =?utf-8?B?a0p6QlEvUXNqSmdCOFBpKzFORUhOZ1Z3dkVuZi9NZFg3aDdOZjhmTVhBMkFO?=
 =?utf-8?B?TGxRbHlUVEpEVGxpaDE5Tk9mTlREdnczWFFzQmFKOGNOTVAveG9KVFk1Kzho?=
 =?utf-8?B?YWlOOTFlQ0dzTUhHbmR6WDBxa2tGd2lLNU9LS3VvaG5QVDVoOThsdGlCMnR6?=
 =?utf-8?Q?7ZOGhPI6UlSGicThYoVairet8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c84bb9d-07ff-4cbe-eec6-08dd472aac2e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 03:51:16.3560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27ZzqUVvhdMvoEgzKbupF0SHMv9FEWxin+ANsVefwbYamLofbc/52YX3hGE7zt1H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941
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



On 2/7/2025 4:56 AM, Kim, Jonathan wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, February 6, 2025 8:13 AM
>> To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kim, Jonathan
>> <Jonathan.Kim@amd.com>
>> Subject: [PATCH 2/4] drm/amdgpu: Add xgmi speed/width related info
>>
>> Add APIs to initialize XGMI speed, width details and get to max
>> bandwidth supported. It is assumed that a device only supports same
>> generation of XGMI links with uniform width.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 41 ++++++++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h | 11 +++++++
>>  2 files changed, 52 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> index 03d909c7b14b..edef5763e2b8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> @@ -1679,3 +1679,44 @@ bool amdgpu_xgmi_same_hive(struct amdgpu_device
>> *adev,
>>               adev->gmc.xgmi.hive_id &&
>>               adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
>>  }
>> +
>> +static inline uint32_t
>> +__amdgpu_xgmi_get_max_bandwidth(uint8_t link_width,
>> +                             enum amdgpu_xgmi_link_speed max_speed)
>> +{
>> +     /* Returns unidirectional bandwidth in Mbps */
>> +     return max_speed * 1000 * link_width;
> 
> Instead of wrapping this in a new static, would it work to declare a new member adev->gmc.xgmi.max_bandwidth?
> Then in amdgpu_xgmi_init_info, you can define max_bandwidth directly after the switch.
>

Link Width/Link speed is generally the standard way to represent link
info. Presently, tools like SMI show these for PCIe. Followed the same
here and kept a max bandwidth value calculation.

>> +}
>> +
>> +/**
>> + * amdgpu_xgmi_get_max_bandwidth - Get max possible bandwidth of a single
>> XGMI
>> + * link of the device in Mbps
>> + * @adev: Target device.
>> + *
>> + * Gets the max possible bandwidth of a single XGMI link of the device in Mbps.
>> + * Assumption is all links of the device have the same width and are of the
>> + * same XGMI generation.
>> + */
>> +uint32_t amdgpu_xgmi_get_max_bandwidth(struct amdgpu_device *adev)
>> +{
>> +     if (!adev->gmc.xgmi.supported)
>> +             return 0;
>> +
>> +     return __amdgpu_xgmi_get_max_bandwidth(adev->gmc.xgmi.max_width,
>> adev->gmc.xgmi.max_speed);
> 
> If you do the suggested above, both tests can be simplified into 1 line as
> -> return = xgmi_supported ? max_bandwidth : 0;
> 

Yes, primarily width/speed is chosen to represent link info.

>> +}
>> +
>> +void amdgpu_xgmi_init_info(struct amdgpu_device *adev)
>> +{
>> +     switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
>> +     case IP_VERSION(6, 1, 0):
>> +             adev->gmc.xgmi.max_speed = XGMI2_5_SPEED_GT;
>> +             adev->gmc.xgmi.max_width = 16;
>> +             break;
>> +     case IP_VERSION(6, 4, 0):
>> +             adev->gmc.xgmi.max_speed = XGMI3_SPEED_GT;
>> +             adev->gmc.xgmi.max_width = 16;
>> +             break;
>> +     default:
>> +             break;
>> +     }
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> index 044c4f6be44a..384c4ddef78a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> @@ -25,6 +25,12 @@
>>  #include <drm/task_barrier.h>
>>  #include "amdgpu_ras.h"
>>
>> +enum amdgpu_xgmi_link_speed {
>> +     XGMI2_SPEED_GT = 16,
>> +     XGMI2_5_SPEED_GT = 25,
>> +     XGMI3_SPEED_GT = 32
> 
> Why not declare and define them as units of Mbps to begin with so you don't have to do the calculation later?

Actually, this is also something which is followed from PCIe to
represent as GT/s. If bandwidth field alone is kept, then this also
won't be required.

I'm not so sure if that is a good way to keep things.

Thanks,
Lijo

> 
> Jon
> 
>> +};
>> +
>>  struct amdgpu_hive_info {
>>       struct kobject kobj;
>>       uint64_t hive_id;
>> @@ -75,6 +81,8 @@ struct amdgpu_xgmi {
>>       struct ras_common_if *ras_if;
>>       bool connected_to_cpu;
>>       struct amdgpu_xgmi_ras *ras;
>> +     enum amdgpu_xgmi_link_speed max_speed;
>> +     uint8_t max_width;
>>  };
>>
>>  struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
>> @@ -102,4 +110,7 @@ int amdgpu_xgmi_request_nps_change(struct
>> amdgpu_device *adev,
>>  int amdgpu_get_xgmi_link_status(struct amdgpu_device *adev,
>>                               int global_link_num);
>>
>> +void amdgpu_xgmi_init_info(struct amdgpu_device *adev);
>> +uint32_t amdgpu_xgmi_get_max_bandwidth(struct amdgpu_device *adev);
>> +
>>  #endif
>> --
>> 2.25.1
> 

