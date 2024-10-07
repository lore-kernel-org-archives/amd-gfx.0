Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD5DCFB441
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 13:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6664510E39E;
	Mon,  7 Oct 2024 13:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hCkEu/W9";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C4A810E39E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Oct 2024 13:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHPWu9PNK9uH56KkTk+dVQhbiVqmtTtg1GrR914Gk0Dfdt0KbrGpzu2ta3IwuzpwWoG9Ukwf7alHTq1XRqeXIOBN9UY7qiO3Mmbw1vwv5B0m8vrq7fR1fR8tf6Hi0Z3f+vTenwhYlr0Aby4h6ATqFZqojZVxlp4oQBBv9deSPa6T/dMdYV0kJL6i0ZaREC2KPySLw+4gIE5xlG0M9hdlyZHazhmlcvnS+vtf38mg6XnOvqtRjoZ3G7tarkKpTeIFWeI7pH02TTynjuoX5aORP7suUVBESOEIkzHeFUrd/IdodWl2UzQ3N3689mrXTL7WcOpmxw8kvBsoz021OVvaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtmFfzm1DRd4VKvBSjoOOo9hxqTE+XSWtZ8A+WygX0Q=;
 b=gVkobFb1fCDr77pK4scuroBkUHB8jzveDSigHadald+e/BowLjqFKQ2ZaelOEGd+ZT8c2nSGPZZmg02hi5+wa4ki7iAFjBZMT9mRYyIftKU/M9zv7DJ/1iK09+8GGkmk4n/FUGiTOMsJGzktuPFWbz4wseo/gFjQ4WSAhNPoYuBYvXJIUrSZ3LMD+lkwbT8lx40QwohtiXenkQtIhWa6yP5kXg1MvPA6x6ZVfrk69d8FgHaE9n3sL9qiI27PSkcKbB09i1V3rld4beVVuomu38aYKP0k8F6rZtORwSsupdXQ5GabrHLRGmVIKskL3zJ+yHc8lPwSBov8orE9Ygpvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtmFfzm1DRd4VKvBSjoOOo9hxqTE+XSWtZ8A+WygX0Q=;
 b=hCkEu/W9vne75/EhUgQXE40/WtCkZiyr4UPe0mdBBYaDkFZ0Vs1TD0PFJDA+hcxvKONrc+uy86u1MvPZKIstRgVdXKVs465PvXPk63Ii5TUYNLQqGOFfnbUJp/6aaWMFpF2f/auMIT8TlfVQitE3PDjxnK8Dhw0+B5aFpl/Qljs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Mon, 7 Oct
 2024 13:50:33 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 13:50:33 +0000
Message-ID: <5f4babf7-f8b9-4a93-8858-849b8b32c3b9@amd.com>
Date: Mon, 7 Oct 2024 19:20:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] drm/amdgpu: power vcn 2_5 by instance
To: Boyuan Zhang <Boyuan.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 leo.liu@amd.com, christian.koenig@amd.com, alexander.deucher@amd.com,
 sunil.khatri@amd.com
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
 <20241004184444.435356-12-boyuan.zhang@amd.com>
 <4a7b5736-f60b-433b-a021-fef2cf4f2338@amd.com>
 <2d260d2c-d052-4b07-9cbf-0e5fc4199f98@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <2d260d2c-d052-4b07-9cbf-0e5fc4199f98@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0254.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3b0b84-eacd-45e1-9e77-08dce6d7035a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWRPVUtHcEREeExMTTNKL3RZWWNKMU9VMThFNGxaSFBOckUrVmNWTnlJSEtj?=
 =?utf-8?B?MzNCSFhxNUhkZG5qUGxVWmJSY25ibUVPSTVLVkNFdllVQUpTeXBDRTk0TERp?=
 =?utf-8?B?cWVOVkdOWkJ4WEt4OXZ6MTMwdEcxTU5Zck9tK3ErTi9FaWRJS1lBNXdJR2tV?=
 =?utf-8?B?VmxUZWhxZGtobjBpMEZSZjV0ZzR2WDQ1dzFMWTkyWUY5Z0dqb3FSRVlIMVNC?=
 =?utf-8?B?YzVKdW9nSWVnSm5nNnBqcDRxUVVwOHFSM3pwUUs1NzBJN25KRFI3eldBbFBn?=
 =?utf-8?B?UTBpc0NWUkQ4MVlYWFJ4YnNicUlWaEd3M2kxQnpWdDQ5RFBPUXlQN3N2MkNX?=
 =?utf-8?B?WnFaRmdiN3VjaXhuOThjTFJSUmM4Q0gwc2lvcnNnL3lHcG10QytndCtVdVNj?=
 =?utf-8?B?c2N1enp5aHRaWXBSY29tK0JVNUg1QnVBL0paTEs2N0lvaGRiSFl5enhvRkZ5?=
 =?utf-8?B?Y2hBTTdNNE5DNnRNdEZramRaUFZFcFpZQW1XZWZ5eWt6UFFhYWwwTkJjQTA3?=
 =?utf-8?B?bUs1YU1jbkJ4bER2NUZjZEhQUS8wV1JqTXJJbTNDajVQekNnODR3bU9BOGZZ?=
 =?utf-8?B?SVNsVlk1cGY1a2xSZkJqTFBLdTJnZzJNZjFkam53UldHTWROZlowWkdTSDY5?=
 =?utf-8?B?Y3JCT25kVlc5T0puWk5LU0JzWGJWSU9GTGd6ZnZSOERXZnJKcHQyYzdVbnBV?=
 =?utf-8?B?a3puM1ZxTDUxcHRqcFlxdmlzbENXTm4zRHpoeGZNa1hDSm9kcDRtNlRRNVVu?=
 =?utf-8?B?bDdOOXl2eUxCV2dSWWl4MlJzSXhEc0FJbmZPYkN2VHB5K0ZWMWsrQjlQcGJB?=
 =?utf-8?B?eFRTV1QrTXo3ZjlTNXdJd0RMOXIvdnlEaGdyOXRheFhCVWdtbUdxblZ1L3gy?=
 =?utf-8?B?RExZbVRkVzd5cUhLWk1iQjFzSDhGS2QvR1N2Q2llcmpjbDMxb1dHLzZPRWFM?=
 =?utf-8?B?alh4UVB1NmZ0ZndBaWk3UEMrV3RIV0liSVFpYmRhbnRLdkNsZllYZENWYUI0?=
 =?utf-8?B?VWJUVlJjaWVkSkE5eHRoQkRFTENJNEp0K1NkQWtiVDQ5ZCtLS1E1V0F6aHFn?=
 =?utf-8?B?RW0rSTlxQ05MNTYySnhiNEo4ZkM4ZjRzRWxGa3h3S3dxVCtlYzIvdERYR1E1?=
 =?utf-8?B?d0xHOUI3Z2cxQU5uUTk0WldtbkRZbHVkQlNwSW1SaDRlRC9uaG84V3Jxajk2?=
 =?utf-8?B?WGdaZEJvRzljUzFIK0taMFJybVhGaXc0RVdCR2xmMEtQQ2ZLK0pTdlVYSmZZ?=
 =?utf-8?B?ZHl6WHNpSndzRmplK2JwZTVlWFRaeHFQQjhnVzhaaWpJcEoydC9Wd0dIY3hn?=
 =?utf-8?B?ZjQ0NCt4eFkzeE56YllFRGJWOGpkTm9Za24zWVFkUjE1QmpFc0twL2p6SG1I?=
 =?utf-8?B?STJ4ZG5LOUovUjNUdGJ3ekFQTFl0TDFrT1VBMUxHbUZUNjNRRzl6QUlGaU9u?=
 =?utf-8?B?eGZESHhnSnVTaC90UTk5aEdJcjhYOFlERVVaOEZKU2JNYkFlUElPN09haG5Q?=
 =?utf-8?B?cit0K2F0NmtReUgrcVdkV0U3NWlycmFCN2dzWGgrdlQ1R1p2eHFralpDUWtY?=
 =?utf-8?B?YnRPR1RHR1p3Y0hOc3dxMmRrQTNNbWthbGxOWDBNSUY5aGVYY1BhTzlsYU16?=
 =?utf-8?B?K21iZUFReVVvV0ovb1QzZXRiUlBHbHBmdTdTbmxoRFRJbjVIc0NrVEo1SWlG?=
 =?utf-8?B?cjliUGdWcUhMM09FOGRHUUEwYmMwRFZZd1Y1VUxULytGeFpJbWVWU3FRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d25lNUFaS00rL3FJNDFOMEhjOXpVU1B1WkYrVVhIcjdNQVFrTWt2djQzQU1Q?=
 =?utf-8?B?TmN3L0IwbXg2SkJYRSsrZTRCa0x0SDJHUkNjU2Q3VG5uOUpJajBBQWlpS2p0?=
 =?utf-8?B?ZGtqUElXbnJKTXNuSHBYZ0Z2ZW14M3BWMUVFbTZJWWtyN3JXVDRZSHl1Ti9v?=
 =?utf-8?B?aUZqaGRIRk5TK1pRSkRtWnUrYzVHSzBJZ1lyMDBhbEpnL3ZWQy9ZRDF2RlZv?=
 =?utf-8?B?bnlGeWwxNVBYdWVhSlJIM21ZdnlVTWFyT0FyYTVlMU5ZTGlMTzZUQkpLZCtP?=
 =?utf-8?B?OVN2TmNrbVMvUnk5SWliSGhZR0krMnlObnVTUTU3YWh0LzJDNzJPRjltZlZj?=
 =?utf-8?B?aVk5QXhrVVJNNzN5WjNKRUZwTzNKbXlIWHpRSzA3UER3RnN5ODlLVVN1Z3By?=
 =?utf-8?B?OC8yUm1jRkJJT096QUl0dzd6WTNSNnVDYVhlem85eERtWkZMbzd5ZnpIVW5I?=
 =?utf-8?B?SDZSZERuYUlVL29kV2VkK0J0L21mQVhDMkdhaStUUVltSWVrR2RpcnpqRnRN?=
 =?utf-8?B?VFlVVHJpZEE0VDk4K1J1U3Y1dy9GMWppbHl1bWZ6bndNRXFTQ2xjL1dwQ1I2?=
 =?utf-8?B?aExLM1pSZlJQN0VyM29oZXR1RzAvaEF3UmNDUWhtZ0V5LzJtbFRKczd6TmJl?=
 =?utf-8?B?a1ZQZnVCRWRURjRCaUY2bzJlcEpIc09iR1k3RkhZaWVyVWNUTnR0TVR1QldW?=
 =?utf-8?B?NXpXamROaUZtMlp3UCtxQU4yNUc5STk5L2hVOExsSFpLcUxjdUx3ZGlaK2Nq?=
 =?utf-8?B?eWxXWDllT1ZpcmVBTHV4aDFtUEpKNGdTamZaZXJLek1pTUZWUFBRSExyNDJo?=
 =?utf-8?B?R2lJaEE5bkNzeHUrNnhvU2Q0ME1wdWhEYWV5ODlXMHVWSU4xV2RrQkFSa0JK?=
 =?utf-8?B?TVZTY21VWi9TV2EvOUhjbk1hUjY2Qk5yU1ZKZ25seHpKQ3FHNlZOb2lRVG0v?=
 =?utf-8?B?dzlldTYvTUU0VG1hcGRUR2Q3YktiRGNzZXhXZGMrYzJSSDVPajcyNDNQcWpr?=
 =?utf-8?B?U244a2t2UGwwL0VrMVdZRUdtTVJDS2NPTkN0QUZ4VGZPT0laaWEzTllKM0VD?=
 =?utf-8?B?ZnQ5MWJvZE13dC9hY2laWUxZd2ZYMmE2Tk5vREZjdXpVVjJvR3dkVDZUU1h1?=
 =?utf-8?B?TGJlZ2pYTnRKS2JhQzQ3SjQ5YWt5U2dGVlNmOFNuN1VZQzI4MWRlZkRSd3hE?=
 =?utf-8?B?R01NNDY5L1NZTXFPZ0pnTEhIYTZGUnhsNnRFenpRQkxCcXhIcDVFMFc2ZWxJ?=
 =?utf-8?B?L1BXRC9KRHlQNEtLelUvOUswNzc0NzNhMjM4WUJzMmQwc3V5aGo3cXBqMmkz?=
 =?utf-8?B?Mml3L29Hck1peC92NnA5N0NaVytQYzhvTUpyTkJOODJjSU5QZU5SUHNXUFht?=
 =?utf-8?B?VUczeGFranB3WVBjanBKVytsN1FsMXBBYlRlNlRSZmp3TmIrb1A4MlFnYjI5?=
 =?utf-8?B?SExjaGxyZHlQQmNJV2tvaldvNVYzNm5Tekd5cDcxZDh6ZURPdXVzak5PbnM5?=
 =?utf-8?B?RkVuSnJkYUtBQjI5UjFFM3BsTkVnb1BxbXpnZmhSd01QK2h2SXdrNjVwcG9W?=
 =?utf-8?B?VUhmUXI0M2Z0LzAyWEFPNmVadndSU0UwdWc0aDF3eW5Ec2Y4Yy9ZWkUrYStC?=
 =?utf-8?B?T01XbVhZYzc5ZytkU2hwL1kwWFpTa2FoRGM3dkdJT1pYTXlicWQyclNtektL?=
 =?utf-8?B?TUZSRHRYUERLQ0V5SzZlOENldmRtQmNuZUVBcXhyanA5THd4MnlHbkJ1Tzh5?=
 =?utf-8?B?UDZCU251MEpCdjFZVWdVRTBRZGN0TjNsZmU3alVzYmNOZDh0akk5SzJYeDJL?=
 =?utf-8?B?NWZ1MldLWXFpSXFJVnpEZi9UeWgvMTI0aS93U3dQRjhFdzEzb29MME5uVEZV?=
 =?utf-8?B?M2dNNjVqb09uZ25rME9qc055R2dUZkE5Wk5Fc0VIdHNrRVppTzFlekRWdmRN?=
 =?utf-8?B?Y0N0RkNZOVE1bEswMUMyU3VndVBrOTlHL0Fqei91aldlZlRGK2w1cldMRHEx?=
 =?utf-8?B?MGZieXloT2xVcm9JL2p6YzlsNlQyRkFMSFRscFVScnFwcmJLU2VQcWxYYldu?=
 =?utf-8?B?QlM4YlBsbjRTcS9XeWlJRFp2eFk5TWNmbXJ0RmtRQTR0bGo2U2FCK3ZKcFVX?=
 =?utf-8?Q?YeFPi5eGIRumZWm78GwMx7sWy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3b0b84-eacd-45e1-9e77-08dce6d7035a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 13:50:33.1873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5WBEc95UQcou33t0NbWipqDH7oeZRwrAQHcwBOU9OmBIdwLXk425cynnzSjEzz6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
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



On 10/7/2024 7:03 PM, Boyuan Zhang wrote:
> 
> On 2024-10-07 01:22, Lazar, Lijo wrote:
>>
>> On 10/5/2024 12:14 AM, boyuan.zhang@amd.com wrote:
>>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>>
>>> For vcn 2_5, add ip_block for each vcn instance during discovery stage.
>>>
>>> And only powering on/off one of the vcn instance using the
>>> instance value stored in ip_block, instead of powering on/off all
>>> vcn instances. Modify the existing functions to use the instance value
>>> in ip_block, and remove the original for loop for all vcn instances.
>>>
>>> v2: rename "i"/"j" to "inst" for instance value.
>>>
>>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +-
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 565 +++++++++---------
>>>   2 files changed, 280 insertions(+), 289 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> index 9f9a1867da72..de1053cc2a2b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> @@ -2278,6 +2278,7 @@ static int
>>> amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
>>>     static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device
>>> *adev)
>>>   {
>>> +    int i;
>>>       if (amdgpu_ip_version(adev, VCE_HWIP, 0)) {
>>>           switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
>>>           case IP_VERSION(7, 0, 0):
>>> @@ -2321,7 +2322,8 @@ static int
>>> amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>>>           case IP_VERSION(2, 0, 3):
>>>               break;
>>>           case IP_VERSION(2, 5, 0):
>>> -            amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
>>> +            for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
>>> +                amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
>>
>> This introduces a totally confusing design now. At a higher level an IP
>> block type manages multiple instances and their power states. Now there
>> is a mix where no definition can be attributed to an IP block. Or, if
>> this were to be done uniformly for other IPs, then for some SOCs there
>> could be 16 SDMA blocks, 8 GFX blocks and so forth.
>>
>> What is the reason to do this way? Can't VCN IP block maintain the state
>> of multiple instances within itself?
>>
>> Thanks,
>> Lijo
> This is part of the fundamental design change for separating IP block
> per instance, in order to
> handle each instance separately within same IP block (e.g. separate
> power/clock management).
> 
> Part 1, Change all adev ptr handle to amdgpu_ip_block ptr in all
> callbacks (hw_init/fini, sw_init/fini,
> suspend, etc...) for all IP blocks, so that each IP knows which IP_block
> (and which instance) the
> callback is for. Most parts of this changes have been submitted by Sunil.
> 
> Part 2, Separate IP block per instance.
> 
> Part 3, Since callbacks can pass in IP_block now after Part 1 change and
> instance value can be
> obtained from each IP block in Part 2, IP can then choose to handle
> callbacks ONLY for the given
> instance of a given IP block (or still handling for all instances as
> before).
> For VCN, all callbacks will be handled only for the given one instance,
> instead of the original for-
> loop for all instance. As a result, each VCN instance can be
> start/stop/int/fini/suspend separately.
> 
> Part 4, Change all VCN helper functions to handle only the given
> instance, instead of the original
> for-loop for all instance.
> 
> Each instance can have its own states, so we think it makes more sense
> to separate them on IP
> block level to handle each of them separately.


Such a change should not be done unless all IPs follow the same design.
You didn't answer the question - what necessitates this change? What is
special about VCN that it cannot manage the states of multiple instances
within the IP block?

Thanks,
Lijo

> 
> Thanks,
> Boyuan
>>
>>>               amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
>>>               break;
>>>           case IP_VERSION(2, 6, 0):
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>> index d00df51bc400..1f8738ae360a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>> @@ -158,35 +158,34 @@ static int vcn_v2_5_early_init(struct
>>> amdgpu_ip_block *ip_block)
>>>   static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>>       struct amdgpu_ring *ring;
>>> -    int i, j, r;
>>> +    int i, r;
>>>       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
>>>       uint32_t *ptr;
>>>       struct amdgpu_device *adev = ip_block->adev;
>>> +    int inst = ip_block->instance;
>>>   -    for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
>>> -        if (adev->vcn.harvest_config & (1 << j))
>>> -            continue;
>>> -        /* VCN DEC TRAP */
>>> -        r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>>> -                VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT,
>>> &adev->vcn.inst[j].irq);
>>> -        if (r)
>>> -            return r;
>>> -
>>> -        /* VCN ENC TRAP */
>>> -        for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>> -            r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>>> -                i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
>>> &adev->vcn.inst[j].irq);
>>> -            if (r)
>>> -                return r;
>>> -        }
>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>> +        goto sw_init;
>>> +    /* VCN DEC TRAP */
>>> +    r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>>> +            VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT,
>>> &adev->vcn.inst[inst].irq);
>>> +    if (r)
>>> +        return r;
>>>   -        /* VCN POISON TRAP */
>>> -        r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>>> -            VCN_2_6__SRCID_UVD_POISON,
>>> &adev->vcn.inst[j].ras_poison_irq);
>>> +    /* VCN ENC TRAP */
>>> +    for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>> +        r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>>> +            i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
>>> &adev->vcn.inst[inst].irq);
>>>           if (r)
>>>               return r;
>>>       }
>>>   +    /* VCN POISON TRAP */
>>> +    r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>>> +        VCN_2_6__SRCID_UVD_POISON,
>>> &adev->vcn.inst[inst].ras_poison_irq);
>>> +    if (r)
>>> +        return r;
>>> +sw_init:
>>>       r = amdgpu_vcn_sw_init(adev);
>>>       if (r)
>>>           return r;
>>> @@ -197,76 +196,74 @@ static int vcn_v2_5_sw_init(struct
>>> amdgpu_ip_block *ip_block)
>>>       if (r)
>>>           return r;
>>>   -    for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
>>> -        volatile struct amdgpu_fw_shared *fw_shared;
>>> +    volatile struct amdgpu_fw_shared *fw_shared;
>>>   -        if (adev->vcn.harvest_config & (1 << j))
>>> -            continue;
>>> -        adev->vcn.internal.context_id =
>>> mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
>>> -        adev->vcn.internal.ib_vmid =
>>> mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
>>> -        adev->vcn.internal.ib_bar_low =
>>> mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
>>> -        adev->vcn.internal.ib_bar_high =
>>> mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
>>> -        adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
>>> -        adev->vcn.internal.gp_scratch8 =
>>> mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
>>> -
>>> -        adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
>>> -        adev->vcn.inst[j].external.scratch9 = SOC15_REG_OFFSET(VCN,
>>> j, mmUVD_SCRATCH9);
>>> -        adev->vcn.internal.data0 =
>>> mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
>>> -        adev->vcn.inst[j].external.data0 = SOC15_REG_OFFSET(VCN, j,
>>> mmUVD_GPCOM_VCPU_DATA0);
>>> -        adev->vcn.internal.data1 =
>>> mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
>>> -        adev->vcn.inst[j].external.data1 = SOC15_REG_OFFSET(VCN, j,
>>> mmUVD_GPCOM_VCPU_DATA1);
>>> -        adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
>>> -        adev->vcn.inst[j].external.cmd = SOC15_REG_OFFSET(VCN, j,
>>> mmUVD_GPCOM_VCPU_CMD);
>>> -        adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
>>> -        adev->vcn.inst[j].external.nop = SOC15_REG_OFFSET(VCN, j,
>>> mmUVD_NO_OP);
>>> -
>>> -        ring = &adev->vcn.inst[j].ring_dec;
>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>> +        goto done;
>>> +    adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
>>> +    adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
>>> +    adev->vcn.internal.ib_bar_low =
>>> mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
>>> +    adev->vcn.internal.ib_bar_high =
>>> mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
>>> +    adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
>>> +    adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
>>> +
>>> +    adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
>>> +    adev->vcn.inst[inst].external.scratch9 = SOC15_REG_OFFSET(VCN,
>>> inst, mmUVD_SCRATCH9);
>>> +    adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
>>> +    adev->vcn.inst[inst].external.data0 = SOC15_REG_OFFSET(VCN,
>>> inst, mmUVD_GPCOM_VCPU_DATA0);
>>> +    adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
>>> +    adev->vcn.inst[inst].external.data1 = SOC15_REG_OFFSET(VCN,
>>> inst, mmUVD_GPCOM_VCPU_DATA1);
>>> +    adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
>>> +    adev->vcn.inst[inst].external.cmd = SOC15_REG_OFFSET(VCN, inst,
>>> mmUVD_GPCOM_VCPU_CMD);
>>> +    adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
>>> +    adev->vcn.inst[inst].external.nop = SOC15_REG_OFFSET(VCN, inst,
>>> mmUVD_NO_OP);
>>> +
>>> +    ring = &adev->vcn.inst[inst].ring_dec;
>>> +    ring->use_doorbell = true;
>>> +
>>> +    ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 <<
>>> 1) +
>>> +            (amdgpu_sriov_vf(adev) ? 2*inst : 8*inst);
>>> +
>>> +    if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
>>> +        ring->vm_hub = AMDGPU_MMHUB1(0);
>>> +    else
>>> +        ring->vm_hub = AMDGPU_MMHUB0(0);
>>> +
>>> +    sprintf(ring->name, "vcn_dec_%d", inst);
>>> +    r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq,
>>> +                 0, AMDGPU_RING_PRIO_DEFAULT, NULL);
>>> +    if (r)
>>> +        return r;
>>> +
>>> +    for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>> +        enum amdgpu_ring_priority_level hw_prio =
>>> amdgpu_vcn_get_enc_ring_prio(i);
>>> +
>>> +        ring = &adev->vcn.inst[inst].ring_enc[i];
>>>           ring->use_doorbell = true;
>>>             ring->doorbell_index =
>>> (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>>> -                (amdgpu_sriov_vf(adev) ? 2*j : 8*j);
>>> +                (amdgpu_sriov_vf(adev) ? (1 + i + 2*inst) : (2 + i +
>>> 8*inst));
>>>   -        if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2,
>>> 5, 0))
>>> +        if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
>>> +            IP_VERSION(2, 5, 0))
>>>               ring->vm_hub = AMDGPU_MMHUB1(0);
>>>           else
>>>               ring->vm_hub = AMDGPU_MMHUB0(0);
>>>   -        sprintf(ring->name, "vcn_dec_%d", j);
>>> -        r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq,
>>> -                     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
>>> +        sprintf(ring->name, "vcn_enc_%d.%d", inst, i);
>>> +        r = amdgpu_ring_init(adev, ring, 512,
>>> +                     &adev->vcn.inst[inst].irq, 0,
>>> +                     hw_prio, NULL);
>>>           if (r)
>>>               return r;
>>> -
>>> -        for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>> -            enum amdgpu_ring_priority_level hw_prio =
>>> amdgpu_vcn_get_enc_ring_prio(i);
>>> -
>>> -            ring = &adev->vcn.inst[j].ring_enc[i];
>>> -            ring->use_doorbell = true;
>>> -
>>> -            ring->doorbell_index =
>>> (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>>> -                    (amdgpu_sriov_vf(adev) ? (1 + i + 2*j) : (2 + i
>>> + 8*j));
>>> -
>>> -            if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
>>> -                IP_VERSION(2, 5, 0))
>>> -                ring->vm_hub = AMDGPU_MMHUB1(0);
>>> -            else
>>> -                ring->vm_hub = AMDGPU_MMHUB0(0);
>>> -
>>> -            sprintf(ring->name, "vcn_enc_%d.%d", j, i);
>>> -            r = amdgpu_ring_init(adev, ring, 512,
>>> -                         &adev->vcn.inst[j].irq, 0,
>>> -                         hw_prio, NULL);
>>> -            if (r)
>>> -                return r;
>>> -        }
>>> -
>>> -        fw_shared = adev->vcn.inst[j].fw_shared.cpu_addr;
>>> -        fw_shared->present_flag_0 =
>>> cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
>>> -
>>> -        if (amdgpu_vcnfw_log)
>>> -            amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>>>       }
>>>   +    fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
>>> +    fw_shared->present_flag_0 =
>>> cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
>>> +
>>> +    if (amdgpu_vcnfw_log)
>>> +        amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>>> +done:
>>>       if (amdgpu_sriov_vf(adev)) {
>>>           r = amdgpu_virt_alloc_mm_table(adev);
>>>           if (r)
>>> @@ -1005,197 +1002,192 @@ static int vcn_v2_5_start_dpg_mode(struct
>>> amdgpu_device *adev, int inst_idx, boo
>>>       return 0;
>>>   }
>>>   -static int vcn_v2_5_start(struct amdgpu_device *adev)
>>> +static int vcn_v2_5_start(struct amdgpu_device *adev, unsigned int
>>> inst)
>>>   {
>>>       struct amdgpu_ring *ring;
>>>       uint32_t rb_bufsz, tmp;
>>> -    int i, j, k, r;
>>> +    int j, k, r;
>>>   -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>> -        if (adev->pm.dpm_enabled)
>>> -            amdgpu_dpm_enable_vcn(adev, true, i);
>>> -    }
>>> -
>>> -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>> -        if (adev->vcn.harvest_config & (1 << i))
>>> -            continue;
>>> -        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>> -            r = vcn_v2_5_start_dpg_mode(adev, i,
>>> adev->vcn.indirect_sram);
>>> -            continue;
>>> -        }
>>> +    if (adev->pm.dpm_enabled)
>>> +        amdgpu_dpm_enable_vcn(adev, true, inst);
>>>   -        /* disable register anti-hang mechanism */
>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
>>> -            ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>> +        return 0;
>>>   -        /* set uvd status busy */
>>> -        tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) |
>>> UVD_STATUS__UVD_BUSY;
>>> -        WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
>>> +    if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>> +        r = vcn_v2_5_start_dpg_mode(adev, inst,
>>> adev->vcn.indirect_sram);
>>> +        return r;
>>>       }
>>>   +    /* disable register anti-hang mechanism */
>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS), 0,
>>> +        ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>> +
>>> +    /* set uvd status busy */
>>> +    tmp = RREG32_SOC15(VCN, inst, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
>>> +    WREG32_SOC15(VCN, inst, mmUVD_STATUS, tmp);
>>> +
>>>       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>>>           return 0;
>>>         /*SW clock gating */
>>>       vcn_v2_5_disable_clock_gating(adev);
>>>   -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>> -        if (adev->vcn.harvest_config & (1 << i))
>>> -            continue;
>>> -        /* enable VCPU clock */
>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>>> -            UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
>>> -
>>> -        /* disable master interrupt */
>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
>>> -            ~UVD_MASTINT_EN__VCPU_EN_MASK);
>>> -
>>> -        /* setup mmUVD_LMI_CTRL */
>>> -        tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
>>> -        tmp &= ~0xff;
>>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
>>> -            UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK    |
>>> -            UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
>>> -            UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
>>> -            UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
>>> -
>>> -        /* setup mmUVD_MPC_CNTL */
>>> -        tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
>>> -        tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
>>> -        tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
>>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
>>> -
>>> -        /* setup UVD_MPC_SET_MUXA0 */
>>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
>>> -            ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
>>> -            (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
>>> -            (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
>>> -            (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
>>> -
>>> -        /* setup UVD_MPC_SET_MUXB0 */
>>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
>>> -            ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
>>> -            (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
>>> -            (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
>>> -            (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
>>> -
>>> -        /* setup mmUVD_MPC_SET_MUX */
>>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
>>> -            ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
>>> -            (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>>> -            (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>>> -    }
>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>> +        return 0;
>>> +
>>> +    /* enable VCPU clock */
>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>>> +        UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
>>> +
>>> +    /* disable master interrupt */
>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN), 0,
>>> +        ~UVD_MASTINT_EN__VCPU_EN_MASK);
>>> +
>>> +    /* setup mmUVD_LMI_CTRL */
>>> +    tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL);
>>> +    tmp &= ~0xff;
>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL, tmp | 0x8|
>>> +        UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK    |
>>> +        UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
>>> +        UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
>>> +        UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
>>> +
>>> +    /* setup mmUVD_MPC_CNTL */
>>> +    tmp = RREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL);
>>> +    tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
>>> +    tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
>>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL, tmp);
>>> +
>>> +    /* setup UVD_MPC_SET_MUXA0 */
>>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXA0,
>>> +        ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
>>> +        (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
>>> +        (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
>>> +        (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
>>> +
>>> +    /* setup UVD_MPC_SET_MUXB0 */
>>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXB0,
>>> +        ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
>>> +        (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
>>> +        (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
>>> +        (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
>>> +
>>> +    /* setup mmUVD_MPC_SET_MUX */
>>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUX,
>>> +        ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
>>> +        (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>>> +        (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>>>         vcn_v2_5_mc_resume(adev);
>>>   -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>> -        volatile struct amdgpu_fw_shared *fw_shared =
>>> adev->vcn.inst[i].fw_shared.cpu_addr;
>>> -        if (adev->vcn.harvest_config & (1 << i))
>>> -            continue;
>>> -        /* VCN global tiling registers */
>>> -        WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
>>> -            adev->gfx.config.gb_addr_config);
>>> -        WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
>>> -            adev->gfx.config.gb_addr_config);
>>> +    volatile struct amdgpu_fw_shared *fw_shared =
>>> adev->vcn.inst[inst].fw_shared.cpu_addr;
>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>> +        return 0;
>>> +
>>> +    /* VCN global tiling registers */
>>> +    WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
>>> +        adev->gfx.config.gb_addr_config);
>>> +    WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
>>> +        adev->gfx.config.gb_addr_config);
>>>   -        /* enable LMI MC and UMC channels */
>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
>>> -            ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>>> +    /* enable LMI MC and UMC channels */
>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_LMI_CTRL2), 0,
>>> +        ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>>>   -        /* unblock VCPU register access */
>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
>>> -            ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>> +    /* unblock VCPU register access */
>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL), 0,
>>> +        ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>>   -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
>>> -            ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>>> +        ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>   -        for (k = 0; k < 10; ++k) {
>>> -            uint32_t status;
>>> -
>>> -            for (j = 0; j < 100; ++j) {
>>> -                status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
>>> -                if (status & 2)
>>> -                    break;
>>> -                if (amdgpu_emu_mode == 1)
>>> -                    msleep(500);
>>> -                else
>>> -                    mdelay(10);
>>> -            }
>>> -            r = 0;
>>> +    for (k = 0; k < 10; ++k) {
>>> +        uint32_t status;
>>> +
>>> +        for (j = 0; j < 100; ++j) {
>>> +            status = RREG32_SOC15(VCN, inst, mmUVD_STATUS);
>>>               if (status & 2)
>>>                   break;
>>> +            if (amdgpu_emu_mode == 1)
>>> +                msleep(500);
>>> +            else
>>> +                mdelay(10);
>>> +        }
>>> +        r = 0;
>>> +        if (status & 2)
>>> +            break;
>>>   -            DRM_ERROR("VCN decode not responding, trying to reset
>>> the VCPU!!!\n");
>>> -            WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>>> -                UVD_VCPU_CNTL__BLK_RST_MASK,
>>> -                ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>> -            mdelay(10);
>>> -            WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
>>> -                ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>> +        DRM_ERROR("VCN decode not responding, trying to reset the
>>> VCPU!!!\n");
>>> +        WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>>> +            UVD_VCPU_CNTL__BLK_RST_MASK,
>>> +            ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>> +        mdelay(10);
>>> +        WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>>> +            ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>   -            mdelay(10);
>>> -            r = -1;
>>> -        }
>>> +        mdelay(10);
>>> +        r = -1;
>>> +    }
>>>   -        if (r) {
>>> -            DRM_ERROR("VCN decode not responding, giving up!!!\n");
>>> -            return r;
>>> -        }
>>> +    if (r) {
>>> +        DRM_ERROR("VCN decode not responding, giving up!!!\n");
>>> +        return r;
>>> +    }
>>>   -        /* enable master interrupt */
>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
>>> -            UVD_MASTINT_EN__VCPU_EN_MASK,
>>> -            ~UVD_MASTINT_EN__VCPU_EN_MASK);
>>> +    /* enable master interrupt */
>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN),
>>> +        UVD_MASTINT_EN__VCPU_EN_MASK,
>>> +        ~UVD_MASTINT_EN__VCPU_EN_MASK);
>>>   -        /* clear the busy bit of VCN_STATUS */
>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
>>> -            ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>>> +    /* clear the busy bit of VCN_STATUS */
>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_STATUS), 0,
>>> +        ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>>>   -        WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_VMID, 0);
>>>   -        ring = &adev->vcn.inst[i].ring_dec;
>>> -        /* force RBC into idle state */
>>> -        rb_bufsz = order_base_2(ring->ring_size);
>>> -        tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
>>> -        tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
>>> -        tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
>>> -        tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
>>> -        tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
>>> -        WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
>>> +    ring = &adev->vcn.inst[inst].ring_dec;
>>> +    /* force RBC into idle state */
>>> +    rb_bufsz = order_base_2(ring->ring_size);
>>> +    tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
>>> +    tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
>>> +    tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
>>> +    tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
>>> +    tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
>>> +    WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_CNTL, tmp);
>>>   -        fw_shared->multi_queue.decode_queue_mode |=
>>> FW_QUEUE_RING_RESET;
>>> -        /* program the RB_BASE for ring buffer */
>>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>>> -            lower_32_bits(ring->gpu_addr));
>>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
>>> -            upper_32_bits(ring->gpu_addr));
>>> +    fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
>>> +    /* program the RB_BASE for ring buffer */
>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>>> +        lower_32_bits(ring->gpu_addr));
>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
>>> +        upper_32_bits(ring->gpu_addr));
>>>   -        /* Initialize the ring buffer's read and write pointers */
>>> -        WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
>>> +    /* Initialize the ring buffer's read and write pointers */
>>> +    WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR, 0);
>>>   -        ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
>>> -        WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
>>> -                lower_32_bits(ring->wptr));
>>> -        fw_shared->multi_queue.decode_queue_mode &=
>>> ~FW_QUEUE_RING_RESET;
>>> +    ring->wptr = RREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR);
>>> +    WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_WPTR,
>>> +            lower_32_bits(ring->wptr));
>>> +    fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
>>>   -        fw_shared->multi_queue.encode_generalpurpose_queue_mode |=
>>> FW_QUEUE_RING_RESET;
>>> -        ring = &adev->vcn.inst[i].ring_enc[0];
>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI,
>>> upper_32_bits(ring->gpu_addr));
>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
>>> -        fw_shared->multi_queue.encode_generalpurpose_queue_mode &=
>>> ~FW_QUEUE_RING_RESET;
>>> -
>>> -        fw_shared->multi_queue.encode_lowlatency_queue_mode |=
>>> FW_QUEUE_RING_RESET;
>>> -        ring = &adev->vcn.inst[i].ring_enc[1];
>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2,
>>> lower_32_bits(ring->wptr));
>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2,
>>> lower_32_bits(ring->wptr));
>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2,
>>> upper_32_bits(ring->gpu_addr));
>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
>>> -        fw_shared->multi_queue.encode_lowlatency_queue_mode &=
>>> ~FW_QUEUE_RING_RESET;
>>> -    }
>>> +    fw_shared->multi_queue.encode_generalpurpose_queue_mode |=
>>> FW_QUEUE_RING_RESET;
>>> +    ring = &adev->vcn.inst[inst].ring_enc[0];
>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO, ring->gpu_addr);
>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI,
>>> upper_32_bits(ring->gpu_addr));
>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE, ring->ring_size / 4);
>>> +    fw_shared->multi_queue.encode_generalpurpose_queue_mode &=
>>> ~FW_QUEUE_RING_RESET;
>>> +
>>> +    fw_shared->multi_queue.encode_lowlatency_queue_mode |=
>>> FW_QUEUE_RING_RESET;
>>> +    ring = &adev->vcn.inst[inst].ring_enc[1];
>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO2, ring->gpu_addr);
>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI2,
>>> upper_32_bits(ring->gpu_addr));
>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE2, ring->ring_size / 4);
>>> +    fw_shared->multi_queue.encode_lowlatency_queue_mode &=
>>> ~FW_QUEUE_RING_RESET;
>>>         return 0;
>>>   }
>>> @@ -1424,72 +1416,69 @@ static int vcn_v2_5_stop_dpg_mode(struct
>>> amdgpu_device *adev, int inst_idx)
>>>       return 0;
>>>   }
>>>   -static int vcn_v2_5_stop(struct amdgpu_device *adev)
>>> +static int vcn_v2_5_stop(struct amdgpu_device *adev, unsigned int inst)
>>>   {
>>>       uint32_t tmp;
>>> -    int i, r = 0;
>>> +    int r = 0;
>>>   -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>> -        if (adev->vcn.harvest_config & (1 << i))
>>> -            continue;
>>> -        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>> -            r = vcn_v2_5_stop_dpg_mode(adev, i);
>>> -            continue;
>>> -        }
>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>> +        goto done;
>>>   -        /* wait for vcn idle */
>>> -        r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS,
>>> UVD_STATUS__IDLE, 0x7);
>>> -        if (r)
>>> -            return r;
>>> +    if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>> +        r = vcn_v2_5_stop_dpg_mode(adev, inst);
>>> +        goto done;
>>> +    }
>>>   -        tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
>>> -            UVD_LMI_STATUS__READ_CLEAN_MASK |
>>> -            UVD_LMI_STATUS__WRITE_CLEAN_MASK |
>>> -            UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
>>> -        r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
>>> -        if (r)
>>> -            return r;
>>> +    /* wait for vcn idle */
>>> +    r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS,
>>> UVD_STATUS__IDLE, 0x7);
>>> +    if (r)
>>> +        return r;
>>>   -        /* block LMI UMC channel */
>>> -        tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
>>> -        tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
>>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
>>> +    tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
>>> +        UVD_LMI_STATUS__READ_CLEAN_MASK |
>>> +        UVD_LMI_STATUS__WRITE_CLEAN_MASK |
>>> +        UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
>>> +    r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
>>> +    if (r)
>>> +        return r;
>>>   -        tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
>>> -            UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
>>> -        r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
>>> -        if (r)
>>> -            return r;
>>> +    /* block LMI UMC channel */
>>> +    tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2);
>>> +    tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2, tmp);
>>>   -        /* block VCPU register access */
>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
>>> -            UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
>>> -            ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>> +    tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
>>> +        UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
>>> +    r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
>>> +    if (r)
>>> +        return r;
>>>   -        /* reset VCPU */
>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>>> -            UVD_VCPU_CNTL__BLK_RST_MASK,
>>> -            ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>> +    /* block VCPU register access */
>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL),
>>> +        UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
>>> +        ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>>   -        /* disable VCPU clock */
>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
>>> -            ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>>> +    /* reset VCPU */
>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>>> +        UVD_VCPU_CNTL__BLK_RST_MASK,
>>> +        ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>   -        /* clear status */
>>> -        WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
>>> +    /* disable VCPU clock */
>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>>> +        ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>>>   -        vcn_v2_5_enable_clock_gating(adev);
>>> +    /* clear status */
>>> +    WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
>>>   -        /* enable register anti-hang mechanism */
>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
>>> -            UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
>>> -            ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>> -    }
>>> +    vcn_v2_5_enable_clock_gating(adev);
>>>   -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>> -        if (adev->pm.dpm_enabled)
>>> -            amdgpu_dpm_enable_vcn(adev, false, i);
>>> -    }
>>> +    /* enable register anti-hang mechanism */
>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS),
>>> +        UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
>>> +        ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>> +done:
>>> +    if (adev->pm.dpm_enabled)
>>> +        amdgpu_dpm_enable_vcn(adev, false, inst);
>>>         return 0;
>>>   }
>>> @@ -1838,9 +1827,9 @@ static int
>>> vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>>           return 0;
>>>         if (state == AMD_PG_STATE_GATE)
>>> -        ret = vcn_v2_5_stop(adev);
>>> +        ret = vcn_v2_5_stop(adev, inst);
>>>       else
>>> -        ret = vcn_v2_5_start(adev);
>>> +        ret = vcn_v2_5_start(adev, inst);
>>>         if (!ret)
>>>           adev->vcn.cur_state[inst] = state;
