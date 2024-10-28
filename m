Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E48FD339A9
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 17:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 577DA10E00E;
	Mon, 28 Oct 2024 17:51:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BRJY/kH1";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D051E10E00E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 17:51:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fd4V2Rj5vXZ0KDiiCjP36PLslqTTq1xvlybjy4wH+kwK/LrUOC8YA2cAI51nYBIfo3M6ZQGWfnxtoOA4052jBAElhrfI+zk+nRZBHZRSU3esr57t2yNEa/xwFSyt3y98Pyq3rGQp8zRhS5m7qcbvsHSKqgjHokVjlTnGb5POyL0i5tZN6p8OFXCm2nhPenng3226ZVmOGlxxNJ0F5bZUhT40wBCR+4snnke3e3k2EzFuSmYSl9EMkfCafnQ39fPiwEwtTW8PQOOm1o1CgJv2ZCS60RvLK8DZTwh1kPEjIpyIkfz4wCklGB624TNtQ//JQRSebBpl79dNBpadQACoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUkEPMhuDgpzM+OLV7Pk4GQmUhHd2xmpVkMDqTcfBKg=;
 b=ngATDIrs7xnH9pI15u4j1GUO73+AShpkrFjDbB63ufp01Fdbd4osly5wo+1wt/BbBFdT/mXIfEG+3AMP1lEVh4gJGDLS7TVTRvI5rYQTYcSW3vRXSigxhMdzMj5r+XqdZiTLsVdMcRtc7xozNTRFFNv78Yoz/BQy6vUALLF1JbETk5jOsX3OiEkB7mTqtMaJhlpKSg5RFrmQTpRxY1VkKjnO91Vt6B7nQB/UClrMHkv8jh9vXuvcVuZrKsVHV9ySAgpwY/2EqhTDmEXdFq/1KBksT0kRF59D4SOx72CVXG6OgN7m2RB89ucLsWItew+VFxYcPDb766g9IT2GttRhGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUkEPMhuDgpzM+OLV7Pk4GQmUhHd2xmpVkMDqTcfBKg=;
 b=BRJY/kH1nc0HmNkd07127rl8E7I4QQnZ2YcaUqgDIQe8c9Dg/304Ul6Do+tT9HQnQqaD53PuYrJYD+M3Q8bw3FOaiR9401f0pZJWOCaTaE7pqwY0LVDNTScJhPHZrooL8hlFDVDdXuTaOCgAYj6mO5Uhgk0i0jMhZY33LbiUVPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6492.namprd12.prod.outlook.com (2603:10b6:510:1f3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 17:51:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 17:51:39 +0000
Message-ID: <07f7b6b3-5fd5-4a2f-a619-966d7a1d03bb@amd.com>
Date: Mon, 28 Oct 2024 18:51:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/4] drm/amdgpu: Expose special on chip memory pools in
 fdinfo
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20241024092342.98760-1-tursulin@igalia.com>
 <20241024092342.98760-5-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241024092342.98760-5-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: 46267be7-1405-4f7f-697d-08dcf7792c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3FxOXdYWTNlbmFvZHQzL1dDSzRyTWhxd0tXUUU2QjhUbHZXZHY4dElDamZE?=
 =?utf-8?B?VkE5Q01KaFpwVlFMK3k1Z2hzYkc3M3B1Rys3MFc5bnBOQVZQcDlaR3BNY2pF?=
 =?utf-8?B?aEZjR2NHbVpIQ1Q5bDdqWnQzYVl3emloNDE5ZVRUSW1ieXZhczNvNE16SDY3?=
 =?utf-8?B?Y2Q4SjhIVVhQaFkrZFJzcWhUaS82OGF6N3JzRnZwMktPRVBZeVNMRVJYTFVI?=
 =?utf-8?B?UnE0N2svVSs5bU5QNkhGNTlGWUxGb2kzR3h2TW5GbzRhRlBTblRPazlCVnVU?=
 =?utf-8?B?bmlvZ3ZyS0FoNEJ0MzFMZW5OZzlFS3RSQmdnQW12c1JkMFNYUk51dGJ1VHJC?=
 =?utf-8?B?RTllNzFqS0F0a0lLZUN6VnJ4V1c0VDJpb054OGtWb09xeFNFVHNvaU1yS1c3?=
 =?utf-8?B?Zy8xZ0p5K2pnazc3Vjl5dFNsWEg0VUhuWjJGTzRTUDU2REtNck10YXJFdFhP?=
 =?utf-8?B?YnBQMk9tYlg1YTM2MjVwcjI4SE1meDU1dUI5YlJ6R2VJS2Z1ZFJ0RWZPZTJq?=
 =?utf-8?B?VUpQSUoyRlZKOWtpbjZ5NmlJcXZlS3dZTTZCL3lzL29heEM2bnREb2ZhSm9h?=
 =?utf-8?B?cWxPYVVsb3FFdUk0aEhIcWJZazA2Q052ZWxaZWZwUzY2TDBNeFJ4NGt0N0l1?=
 =?utf-8?B?cFRSMmljU1lBVy9tNWxOV1J0RlFmSUg1NWpkd1dTMkthYnpKNmtNWURTamNn?=
 =?utf-8?B?c3FpMmVjakJZWC93bGQrakM5TGNmUFZGdGhpM1FEK09NNFBwV0czRUh3SVZS?=
 =?utf-8?B?ekd2SHgrY25hVFM1ODZmNWVYdVRoRFUwSFZ6cTZCZUNWWjRDaHdmUENKRVJB?=
 =?utf-8?B?MS8rRkVZUzdRa2lrUjhTRGVkSnBITVV1elljNVBTTDkyWTZxdXJrQ09lazVF?=
 =?utf-8?B?Y2pVaVFtT3Brc0VTYjVsRG03ViszelJodkFwRjl5V241cmVQbm0zUk5GS254?=
 =?utf-8?B?dU4va1NFc09zZTYzbHNXNk4rVXR0Ry9wM2xSN2d6aE8xSldOZ0FWVGJBM2ZY?=
 =?utf-8?B?dlRUQ1VFSFZkbVNLMDFNZUQrMmU0VzBya3h3aE9LK1N4dldhVWNJc0xkZDlL?=
 =?utf-8?B?eE5pMGZka2ZFSEdlOGZER2V1WTNOUUxmSm51TUNnRFl0elFLRVNEcU5LK0pU?=
 =?utf-8?B?TEEySmUwcjhwWEE4WFJNWDdLblpYN1F5RENQekNibWE1NDdZTmZWdmgrcTgz?=
 =?utf-8?B?R05MZ05pdWsxZDFZY1pqclRVcjVjOXZaZGdGYlF3VWU2d1drODEzRXBQNHlF?=
 =?utf-8?B?OTV2YzA0VWEwU0lvdmNqbHhhdUk2N29JR0N3YzZTV3R0UmlWd3FUdE1JQWk3?=
 =?utf-8?B?aVhIZThld2dqdWM5czZKSy9pSXh0ektHaWpDdExuSjdMdlpwSXFXbzRmRGpT?=
 =?utf-8?B?NHdJS0Q1cXhDd3c1bDErVkFvYXVJcUNKNzQvSVFIMGY0TEJvZUlzS3AxNjZp?=
 =?utf-8?B?V2lWTTZNK3krcFpmMEZSOUJlM0lMTU9kZlNLN0EwUTBIMjJtNndndklLcEpR?=
 =?utf-8?B?eUgxSFJkdUNxM1VzSE5WRDhMbHlxVE45Qkk2NHRPM0txNW9oelEwWlAySldN?=
 =?utf-8?B?SlBjc2hDMVBGMVZJV1pkUTRVMTg1RWVTNllYZUwwMi9mMVVsK01aWEhrTHJr?=
 =?utf-8?B?S0ZhdXNBZnIxZ2JCWWtCYlBmMGw5UVBVY2FPZ2RNNk90b1JiejI1REVCTTFW?=
 =?utf-8?B?Uk5BR0hmSWRjZjlNeHdWdDZNSG53d1BUV214KzlHdjVvUTVRaDVrcTJLSkJV?=
 =?utf-8?Q?tHhE+BwUo6oen4mvyg4LrvJu/sf1pdl7bgDCP1Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFdrdjdFV0RFOVFFUkE1WUFTbElvMVg0ODNwMDUzZmJEVE0zRUJPc1JPL3Ew?=
 =?utf-8?B?VTVTaThhNGR1YkxqR2FwVkxNN1kzVm9TK2wxZ1ZKZnZqeGNuWWh3NWVKVEpE?=
 =?utf-8?B?QUtiNExMUlprcFZPdmJjaWx2ZkhVTGVGbVlucjFiUG9DY1FkbzZMVGR1bWZa?=
 =?utf-8?B?dncxRDA5SXFlVHNvc2VBSWluKzczNzJrWUxmQTRhdmxaUXFsVkRvMEpZcEhj?=
 =?utf-8?B?NEd3TkVZc1k1Skl0UTFxc20vNU1MR3ExOVpaTzlCcTA1cEkwd0FWUEhLRzZE?=
 =?utf-8?B?MGtOVWpmUjU1VkNEenFFVTFpVmQwaTE3VjY4cjFOWW5CK1dGa2ZBWExTS2R2?=
 =?utf-8?B?bkVZRDVFWUhDKzNsTHJTdS9CS3M4d2dsUEQxd3QrQi9pZndIMVo0WHprVEwr?=
 =?utf-8?B?bUtTaXQvTmcrOVEzNUxjLzVWaFQ1NC9XVDBQVzFjS3BiV0NPNkg0RGxnTWt3?=
 =?utf-8?B?Q1cvd0prT2tMMGI5d2F3MkdYVENxL3BrRk5md0UvQlVsZkx3RUdLVURPbVlt?=
 =?utf-8?B?b2Y3QitMTVdDTUFoMkgvbnlrazB1YzdnQmpCR0RBOWFqUlp0L0dtYlpKTE4r?=
 =?utf-8?B?dGFMNHg1Rlc0OWw3VUdGdEZDRUlNNEtrdDlNY0dadTM2WFZpSExHUEFiSFN2?=
 =?utf-8?B?Q3RXaDdhbjB4NkQwSWdsdXdzSE9RcVRLK1FMbzZ6czhydEhHeGtJUFNqQUVO?=
 =?utf-8?B?amlSdlQ0S0pmeXo0RGhTTFZydVFqODdkc0taM2ZOWCsxNUdwQ1VoWURuc3BV?=
 =?utf-8?B?eU9uYjRMbndDZlg2ZENCQnJyV2N1SDQ2LzcyenlLUm9GV1g2ZmtOb2pQSC8w?=
 =?utf-8?B?VzFoWHlKM1hWWmJDTTc1Tk1KdGdoTUlsSFRZOC9lL2ovWDZPVXNzU3BGSnRQ?=
 =?utf-8?B?SHlKUjlCMXpoVDRwUTd2Z3ZLMzNmYjJ4aTZ4SmF6ajJCWWhiZTlNMzMzaDc1?=
 =?utf-8?B?ZUtTcGFOUFZmN0N3MEMxVytxYW1VeWNxZ0JuSVdoVHAyZDRhbkZNZUVSWEdo?=
 =?utf-8?B?b3pPL1BNSDdRMkZBcUM3ZmNMZjBGSlJHaFEzMy9ZamxFditsZ3E0UnBLMHNV?=
 =?utf-8?B?dlk0d08wcURvQnh1LzJ5ZHd0OWd2ZTVwYjVaa0VKazBnWGR6VkJMNEVJNjgx?=
 =?utf-8?B?T3ZCdXA5c1cwZ3dGamphTDZkZ2Z2ZUVzL1VLeDFyc1luOHdxQ2VIR0MxZ0Jq?=
 =?utf-8?B?bVRxWUkwZ2Mvam9lb3Y3d3g4REM5WWJuQkhCdmZCRDRRMnRiR1JHdzBjaXNq?=
 =?utf-8?B?eW5LTGszejhGayt6VXpOUmxKd0R2YmFmMjdCMmM5OURzZXVDUGNOUFZUeHhJ?=
 =?utf-8?B?a1QwMlRLS1c5eFJwZzQzK1UvU3ovaHNZZ1F5UUZqOVRtczZXbEdqZFlkUW8z?=
 =?utf-8?B?dmMraGE4ZEVOWGNMTERxbzFUbDg1V1dPdmJ1YlNnTW4xTDVCY0RUelJtd05k?=
 =?utf-8?B?UWszZUhmOWV5UzA1VTYxR3IyOHA2TEI5VWxNamVTNm11SkkzUndkOGxId0hm?=
 =?utf-8?B?OStYd0ppemFrYWlmT2U4cms1VjhDU0h3VjFWTWRoc2VxSllmeW5kQ1ZjbUhX?=
 =?utf-8?B?ZDk0REdRb1NHbjlDSmlYaE9JQWdOSHpCcmh6S1BtMXlnSUpoZmFVeWFOMzdZ?=
 =?utf-8?B?Sm5DZTN2N3lQeWtWVVZrQzdvRHlEeEM4Y0ZsSWpRS3Z5STRuOEUwK204S1lL?=
 =?utf-8?B?ZXQwT2VqS1l0Ti9pcTlnWStiSHpRbm1JaEkrd24xdlphL0NmOTBaK3FLMmdh?=
 =?utf-8?B?QzN3Q1JUUWVyY0tkVjRMWGdVWVJSSEhVbzBqbTdwV1NlVnoyZHVZbmZOY3Vi?=
 =?utf-8?B?Z2h1UEN3cm1JbjZvZEdzRHo0T1M0a1RReWpPRmRxTjFxNTJuSHZmQ2dFdmxa?=
 =?utf-8?B?bDEwYzEwc3UxS0ZsR3g2Y3ZxZi9JcXZXMTliNzFzUFpJZHJsMjJkMzI4eGl6?=
 =?utf-8?B?RUk1S1JMSVBEajRwcFZmaUFoN0x0SkpOSW1QZFhsU2JRc2hycFRmbUJhcTA3?=
 =?utf-8?B?SWFXZUtwbXE5TlJiNXQvRndmdy9xRFBuNkQ0S1VBUWxvdS9KZTVXWGhvRWl4?=
 =?utf-8?B?YkdPOW4zLy95alBzWWxMOElvU29pZ3hiSGo1SUtCRi80SHJkSUplVEg0SWp3?=
 =?utf-8?Q?50dlCN7+DBMga8o87g2ZAmlqz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46267be7-1405-4f7f-697d-08dcf7792c66
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 17:51:38.9921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzHfllRBHHvEh31ufDuopdqsuaVylWpk6bpzHvdSSj+S2usDpD8pNZNRQJg54Pvt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6492
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

Am 24.10.24 um 11:23 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> In the past these specialized on chip memory pools were reported as system
> memory (aka 'cpu') which was not correct and misleading. That has since
> been removed so lets make them visible as their own respective memory
> regions.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Yunxiang Li <Yunxiang.Li@amd.com>
> Cc: Alex Deucher <alexdeucher@gmail.com>

Of hand looks correct to me, feel free to add my Reviewed-by: Christian 
König <christian.koenig@amd.com>

> ---
> It is easy to do but is it worth it I leave to AMD experts to decide.
>
> I gave it a quick spin and have only seen all zeros when running a Steam
> game.

Usage depends on HW generation and use case. IIRC GDS is the most used, 
but only in some rare use cases.

The upcoming HW generations will depend quite a bit on doorbells.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index 7a9573958d87..df2cf5c33925 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -66,6 +66,10 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>   		[TTM_PL_VRAM] = "vram",
>   		[TTM_PL_TT] = "gtt",
>   		[TTM_PL_SYSTEM] = "cpu",
> +		[AMDGPU_PL_GDS] = "gds",
> +		[AMDGPU_PL_GWS] = "gws",
> +		[AMDGPU_PL_OA] = "oa",
> +		[AMDGPU_PL_DOORBELL] = "doorbell",
>   	};
>   	unsigned int hw_ip, i;
>   	int ret;
> @@ -87,12 +91,16 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>   
>   	drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
>   
> -	for (i = 0; i < TTM_PL_PRIV; i++)
> +	for (i = 0; i < ARRAY_SIZE(pl_name); i++) {
> +		if (!pl_name[i])
> +			continue;
> +
>   		drm_print_memory_stats(p,
>   				       &stats[i].drm,
>   				       DRM_GEM_OBJECT_RESIDENT |
>   				       DRM_GEM_OBJECT_PURGEABLE,
>   				       pl_name[i]);
> +	}
>   
>   	/* Legacy amdgpu keys, alias to drm-resident-memory-: */
>   	drm_printf(p, "drm-memory-vram:\t%llu KiB\n",

