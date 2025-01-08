Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86CCE77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 15:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD3210EBEC;
	Wed,  8 Jan 2025 15:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wS34fGqJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB3D510E126
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 15:29:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbFAHhM15xQSqRfjSUhFIq7XjDYML0sRmH85VLizerrBfX4DKpOcnx174ASUX5p6R3CR3cpcdJxOXAokKcSzYl8swp4F2RpUqwgDflAQ+lUNmuI4mzBXtGP/vKlDRHYaTGsr3EViZ10/frK/215WmgzpUL4LpYsazNKkgvjCcUai8FIYR3w1HmCX7BEOokfYrPqaxNNvUazgtVdP1q/JBS3DdHhWGjUUC9ayHcQtGB/vvKgJ4fF+pHfGVjzVV90H6sVvGMX0QD90p087BokmM60z2StzXPckihcT6xe62XeJbASTHIc4taTnFdqIiQJckmF3wolvLwVVwsUfJY+LlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfGSPXzl9vaxa5wLQtntXht/1bTEHSlDjBp/Dc2RYm4=;
 b=iaXcRsgy4N6CkScUgj5nG4qmUtyrQoGlx+IwrXLX0iRik9++i4QrRtZPA0wH/rO/fkRCGw9ulvTEz8F5zN+Zl67xzbTLyGiclSaEikTiSYcsjNKtjR5RfJ42t86vgJS2f63C8JC/OLMWTP4VJppoPzNZRUhRiOrWj704/g9ch5jdmpW5g0+QEXJP3O9CbBsJ2dQsksd+kROECw06oBGBuE/QeG76+dZpPY51UhROd4TB/xG18ujDdVllhVksctcZYek1BfzgFgxK3hKkG/8bwHkUrWhca1Sio009gF2OQxt+RLsrLINeMaZqxR19Pkm3ScNEwo3oX5jfQYnA1OewYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfGSPXzl9vaxa5wLQtntXht/1bTEHSlDjBp/Dc2RYm4=;
 b=wS34fGqJBr2c/uTha7EYEj7W951DvvK+scee/y40XSp8XlDVICjmi/G6gosBisKoa/rdgDUbISkIUavSVws6z4UiHyDlC9XxKT17LxQRpkKhjPhU05M2170XQq+u/eG5WBuVkIaXbB7fA3zA7rYY1Ww332nr42waFdFM8O+MUwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by CY8PR12MB7540.namprd12.prod.outlook.com (2603:10b6:930:97::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 15:14:47 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%7]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 15:14:47 +0000
Content-Type: multipart/alternative;
 boundary="------------ev101M0Ei6osqRLF0pOVA4Ce"
Message-ID: <dd237f85-14cf-4045-b85c-35d796cfb951@amd.com>
Date: Wed, 8 Jan 2025 10:14:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] amd/ttm: test fence->ops->signaled before use
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix.kuehling@amd.com
References: <20250107200140.1568268-1-James.Zhu@amd.com>
 <e05a67b1-7b2f-460c-bd53-246ea1f55d5c@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <e05a67b1-7b2f-460c-bd53-246ea1f55d5c@amd.com>
X-ClientProxiedBy: YQBP288CA0022.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::6) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|CY8PR12MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: ad61e1b9-3047-4768-f8a4-08dd2ff73034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3VYejRGeFRWbm9oeFlkTGlnMFh5Zkk5NVk4T042c1ZSQ1ZVbGV5Z3d1OWZG?=
 =?utf-8?B?R1lFOGdhRDdCaERJYUpHRWx1cDlsTVdpeVlQeXJSb0lQZlc3QnRKU01PcnE2?=
 =?utf-8?B?MnpCdUtXR3lZVUN2aldEb1lVYXJZSUdxRENkLzNKVnBrcG5LREhla1Zva1JY?=
 =?utf-8?B?Qk1MQW55eFc2OGtsY0ZkRS9qY2NseEwxRVQ2NzVVbm1Jb3pqT05IbTE2TW9C?=
 =?utf-8?B?Z29EUU9NQjdpS0EvSEZod2FpaUhaVmc0aXpEcjZPVXNjYjBRUUE3VmsrbTE5?=
 =?utf-8?B?UjFZVi9XS3gyUmxJYk9GUkpsdjNqUFRSREY5a1hnbGpOSm9GUGVKZTlzSVVV?=
 =?utf-8?B?aDdQWVQwT2xRUFNxRzMrVGNtV3pZSGRtaWJkMkVIOHFVVGs2c0YyYk1FZWts?=
 =?utf-8?B?djFBV1o1cmlKMDFTM2o0N3lLT29jb2kydnZDazFKTGs1ZUpCZkxuR2FJM0hU?=
 =?utf-8?B?a0NSZllESnBEaE45d1BZYWVCS2RsNFdoR3JvYzFqRTFhcElhb0JtR2R0M09H?=
 =?utf-8?B?TmFCWTd6bzR6MG8xcWs4dllrM3V3WDgrdUM5eUtSakNVeWNGWFR6QlFnNFRp?=
 =?utf-8?B?VURnTTJQak9sUENsSjZVVkpsckpQcGJCQ1dwb0pKcDdESVB5YlgwZGhQSmVF?=
 =?utf-8?B?UnM5Q0xBMnZVK2lCQ29hM3pmQWcwclhMVCtqelJUZ0ZBcjZhaW1hUzRYUGRm?=
 =?utf-8?B?YitFMnAxNDFoK1Iyb1krYzdLcmk3MjZjbCtzbk9nUWpkcU5CZENhM1VERkNF?=
 =?utf-8?B?YzhCNkx6dURPcEpuOVJFR0RqUDR6cTFrU0xFZW5hQXJNWGVULzk5dmw3L3kw?=
 =?utf-8?B?ZnIwUkY0RFlJcGZxYlRPUk9ycmZZam1pQTBkd0FrbnF5ODdFMm1sNGtMZkVu?=
 =?utf-8?B?bWNsajhjcXhmWXFFdWt2SC9pSjBweFVHd25iNlFxajNqM25aRDMvYXNhaVhh?=
 =?utf-8?B?aXVwQ0p3cCtSZU9ZNnhUc1JXMFRoeVZUYkNrNlJ3RjRDVlFsM2hUZUVrd0R6?=
 =?utf-8?B?VHBwYkJ1Z1QyNlB0bFMrWUR4cjV6bnhaMStUc2M0MUxBNE9mQUUvOHBjTUVs?=
 =?utf-8?B?dXl5eHVhZWxMNjZIYXZMVWgxVU85c2NyZUxpZmJRUVB4eEdWTnprNmFLZjh6?=
 =?utf-8?B?WCs3emFQREdQOVJ6b29zOU5GUXU3NERlTDRhY0dhS0ZkSzc0d1ZHU1hZeG14?=
 =?utf-8?B?bEtoL3EvTW5aQ1FEYnJaZStXYU8rdjlnc0hLQXZ4QUk2MUtibHlhUUk4SlVr?=
 =?utf-8?B?RlhFTlFLc21vZU95cHc2YnRHTitNSGtFdVgrOXBRY2xYZTRKMlMzZm1Cek44?=
 =?utf-8?B?SkVnaDRkZ2ZWbm5Xc3E2UUo5d3hxUnJXTjRTSVFTeDhMZ2tQN2lFbnRGUEtw?=
 =?utf-8?B?THIveEFIMXVUaGkrd3JybWowejBVbEFkaEpQcUpRMDhJZlRLT2NmbWRWbGRB?=
 =?utf-8?B?dFNJLzk4QStoUnJLTW5QU2ExMG5zQnhjVFpOSmlwdFltcmJ1bkw0RUxkWHVz?=
 =?utf-8?B?bzU2UDJRb2lON0o0Q1lFbWNyb3d2eHFQRmVwVGNkNG5Eb0czajBtV3U4QmNv?=
 =?utf-8?B?T2hTalJ2VkFNUnZiSTlVOTd2WTk5akJVY0tnNHhxZXRFRkk4WU5NTUpTZ0F3?=
 =?utf-8?B?RmNzblRJMkhsTmxoWHJ5WkQ2VTZMUTB2bVFRMEhFdTNKUEF2ZFhVbGZJUlhi?=
 =?utf-8?B?T3hyZUZoaDBlV2JGUHJNbWtEUDF5UmdmK25XVE83Mm84ZE8yWGh5elZ0bVdY?=
 =?utf-8?B?SGlnMXkwc2pFOE9mRHNETnFldEtEaEdmb051NHMrV2FJbERMUE9qQ0U2M0c1?=
 =?utf-8?B?YjB0SWFCOWp2OTVhSUY5QTZGc0UrYUl2R0NhQ0FWVFd3TVN5d2pnSkVLT0M4?=
 =?utf-8?Q?RzqYHBVh4mnW4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHRROU1xT3QvR3F2RVV3WHYrZlpsbjR3cVVTczNuR3F4K2hOdmp5cXNCRUNj?=
 =?utf-8?B?R2tEUmU0ZS9BaWZYQ0FIdCtqajZvdkNRSFNlUDVMaU9sNlkrSEYxWnVQTFhK?=
 =?utf-8?B?emNhNXdpUlpNOHFVb0FZOGEzQXJLOVZPdkVOS216QmFyM2p2NXIvYUJ1RVB6?=
 =?utf-8?B?cVdEVllnQWg1OGRVNEMzQks0SWJhMjhpQ0NsSzBZdFBtb0Jwc1J5bXV4aGQ4?=
 =?utf-8?B?SHcySDlveUViYUhyRVhldmVabzkrM21PeUZXMUxCRnhUMjRQVytRR1JFUDY3?=
 =?utf-8?B?TWsyRmJMOThVbXIrbHI1OTZ6TVdXK1l0eTA2djFBZCtGZzRqaHY0aDk5VTJN?=
 =?utf-8?B?bGtvNzNDQWV4dHNkTlRZTDMrMEdIKzQrbnFlV24zeXU4RHNYWW5oU0sxVzJQ?=
 =?utf-8?B?WXdyaXVaT3l3NnlaMThuWWgrWkUvMkhtclZwMjIrTmNzbzVyMExhZ2ZZZDVO?=
 =?utf-8?B?aEN0QU4yMW1sODh0OURzWFkzWDVQaGVNQkx2NXF5ekxZNEJvK1BpTmN5RC80?=
 =?utf-8?B?dVAxVThySmJMRmxLdnFXRFJ2Y1M2cXpmank2SDJ2dnUzaU9kZlkySHhlTHgr?=
 =?utf-8?B?ZHBZMHU3dFJqbXZWaE1xMTRIc1Jsb3lrNzRxbVBaQjBQbkgrR25jRVVtcnNv?=
 =?utf-8?B?Tk1JZVJiMG1XaGhsSXo2UktkUzQxaHVzTTl6MGtBVlQ2b0FPTVRkWDRqZzlP?=
 =?utf-8?B?OHhBZFdSanpMUktRaVlnR2dNb3dEakF4YVV3ZFZwbXVnZGFtbFFraW83dFdR?=
 =?utf-8?B?ZzZ2NlNlUGVoQVdPQVpFRURFOVJmTUpJR3dackNzNXdESjU1OEZjNnlrWisr?=
 =?utf-8?B?ZDA0OTViSEJ3SFcyZXE1M0FsRzRYeFU3SXlHK3pCMUszaVFFSVlwcU41blhx?=
 =?utf-8?B?LytuaXlKaGdYTnBpWE1ndUV3b3lsd2VWaTA1ZVkwNkxHUUFnRXNTbVlwK3Bk?=
 =?utf-8?B?RGhQWGZPUlU3K0w0N2JpOWpGWGxMck1nZm5LN2xPSEQraVNmYytNZTVQa0VV?=
 =?utf-8?B?NkVCZlZOZk5LNVd3aHcwUjAvT2xLOTdBWXh2d1ZteHNXaHJCN0E3VzBCZTBP?=
 =?utf-8?B?S1BKZmdPRzBvOVVTK0hFSEc0MkNGMXlXVnhXbm5UNGJXdW5PYlNvSlFieDNU?=
 =?utf-8?B?TXRhVjluT0l5RUZOcU1rU2NHc0xzbGN5eUt4TlI1SENZQVVCV0ZTZ3FOQUZ6?=
 =?utf-8?B?VHVCb3lEcURMYTFock5QNGVTcGtFUlFSZUJSazV4L2Mrc0w0TnBmcHdreG5N?=
 =?utf-8?B?RTNhVFRQejMwclVvQnVrWXBwUWE0REllYngybGtJREtnSGVBYWhUaUxGUzBM?=
 =?utf-8?B?OGc1VzR1bFViaHlzVnRaL1pWWmFhdmc1WmZiK2NTcG9nWjc3eVJCcE5QeVdN?=
 =?utf-8?B?Nk9Mais3UkgySm85bi9Vc2dDMW1hT2xZMUdCNkhQS1lTalFaSzdDOFhEbGlj?=
 =?utf-8?B?OFk1emllbWJCUC9KRmdMa3UvZk1OeDlidURCaGVXdWs5REwrRVNNOHMxb1Jr?=
 =?utf-8?B?UzlFdDVDeXZWNnZpT1pPUGd6V01JMEpFSXVsL1cvT1N2cTB3bWRiK3RwcU5J?=
 =?utf-8?B?V2w5dlJjdlhmNVpVcERIUlc3ZWN4QVl5Y3pPVjRIeFY4M21RYUhpaktIamhx?=
 =?utf-8?B?cU9FdnV6S0crSHZiVTBRYTJjVzhPSWc4V0dRMWxJSVpMNDY2WDMwdkh3a3Vm?=
 =?utf-8?B?eVZtMUJvRWZnaFVFVTc0eXVXYWtieURVaWFsYkFlU09uc3ZrTTFiZi9oRUs0?=
 =?utf-8?B?UDBpbnI0SDA5aTJ3MmU0Z1ovY2E3M2ZiUHZpbHFkRFo2UlpuZk1rQnA4dzZ5?=
 =?utf-8?B?bzB3Ti9oTWROQmFsK1djUGptclRQK1pmQ0Q3cmVkL0tTbFFSOWFyMHZzMnBv?=
 =?utf-8?B?MUc1N056b1E4T2gzNzkzSndXc3dFaHhKVXdxWUFmT2FUbVV4dmNiYjcwTkhJ?=
 =?utf-8?B?dTNrY1Q0NGE2anh2ZTBEUWN6d1pzMEw2MUtnTFVoM1A1TFlLUmk1S0FVVVRF?=
 =?utf-8?B?MkVVUUg0V3lNMHF0UzgyVHlHK1VPQjNWc2E1dG9TL2pUY3dzZlF4L2dWelYw?=
 =?utf-8?B?aDhxNk5SZUZKQUJIWHlmSDNWNWJQaUxuOU5helFxV3NSSkVheVlSQWh4clQ0?=
 =?utf-8?Q?ySw9QvMi0fZ2kyu3ROnIDO80X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad61e1b9-3047-4768-f8a4-08dd2ff73034
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 15:14:47.0815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tmCUdFaMsVINB85WEFbSHi6wrfUxV4NF6mJd/WB2DMJg+Vret9OQq/p2Uz2I91s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7540
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

--------------ev101M0Ei6osqRLF0pOVA4Ce
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

MyQorAisinline.

Thanks!

JamesZhu

On 2025-01-08 04:18, Christian König wrote:
> Am 07.01.25 um 21:01 schrieb James Zhu:
>> this original test condition is unclear.
>
> No that is completely unnecessary.
>
> The point is that with fence->ops->signaled provided the fence should 
> make progress even without enabling signaling.
>
> Why would you want to add this?

[JZ]Nothing happened.  just for clarification. So the code can be 
interpreted , if this fence has no signal op defined, we need try to use 
enable_signaling

to flush this fence. implicitly, if signal op is defined, then this 
fence is flushed early or later around.

>
> Regards,
> Christian.
>
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>> index 48c5365efca1..d40f07802c4f 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>> @@ -218,7 +218,7 @@ static void ttm_bo_flush_all_fences(struct 
>> ttm_buffer_object *bo)
>>         dma_resv_iter_begin(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP);
>>       dma_resv_for_each_fence_unlocked(&cursor, fence) {
>> -        if (!fence->ops->signaled)
>> +        if (fence->ops->signaled && !fence->ops->signaled(fence))
>>               dma_fence_enable_sw_signaling(fence);
>>       }
>>       dma_resv_iter_end(&cursor);
>
--------------ev101M0Ei6osqRLF0pOVA4Ce
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>

</p>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">My<span style=" color:#c0c0c0;"> </span>Q<span style=" color:#c0c0c0;"> </span>or<span style=" color:#c0c0c0;"> </span>A<span style=" color:#c0c0c0;"> </span>is<span style=" color:#c0c0c0;"> </span><span style=" color:#ff9d04;">inline</span>.</pre>
    <pre style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">
</pre>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">Thanks!</pre>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">James<span style=" color:#c0c0c0;"> </span>Zhu</pre>
    <p><style type="text/css">p, li { white-space: pre-wrap; }</style></p>
    <div class="moz-cite-prefix">On 2025-01-08 04:18, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:e05a67b1-7b2f-460c-bd53-246ea1f55d5c@amd.com">Am
      07.01.25 um 21:01 schrieb James Zhu:
      <br>
      <blockquote type="cite">this original test condition is unclear.
        <br>
      </blockquote>
      <br>
      No that is completely unnecessary.
      <br>
      <br>
      The point is that with fence-&gt;ops-&gt;signaled provided the
      fence should make progress even without enabling signaling.
      <br>
      <br>
      Why would you want to add this?
      <br>
    </blockquote>
    <p>[JZ]Nothing happened.&nbsp; just for clarification. So the code can be interpreted , if this fence has no signal op defined, we need try to use enable_signaling</p>
    <p>to flush this fence.  implicitly, if  signal op is defined, then this fence is flushed early or later around. </p>
    <blockquote type="cite" cite="mid:e05a67b1-7b2f-460c-bd53-246ea1f55d5c@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
        <br>
        &nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
        b/drivers/gpu/drm/ttm/ttm_bo.c
        <br>
        index 48c5365efca1..d40f07802c4f 100644
        <br>
        --- a/drivers/gpu/drm/ttm/ttm_bo.c
        <br>
        +++ b/drivers/gpu/drm/ttm/ttm_bo.c
        <br>
        @@ -218,7 +218,7 @@ static void ttm_bo_flush_all_fences(struct
        ttm_buffer_object *bo)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_resv_iter_begin(&amp;cursor, resv,
        DMA_RESV_USAGE_BOOKKEEP);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_resv_for_each_fence_unlocked(&amp;cursor, fence) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!fence-&gt;ops-&gt;signaled)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fence-&gt;ops-&gt;signaled &amp;&amp;
        !fence-&gt;ops-&gt;signaled(fence))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_enable_sw_signaling(fence);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_resv_iter_end(&amp;cursor);
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------ev101M0Ei6osqRLF0pOVA4Ce--
