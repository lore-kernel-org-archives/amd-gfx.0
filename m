Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70538C2BD05
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 09:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7DB710E067;
	Mon, 24 Jun 2024 09:53:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W+H3Ypgi";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D5510E067
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 09:53:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmx5tRxskjIXbPX9jDert5rP66R+tTSIWVh0J9eTzI2ZzGDx5kgc+1KE83dQkyXFZm6aZGE6ztptv1vdp5dcdqfOMRQsf8yk6M6cJ9MuHJDj0//atnhmuoBfrp7NUMnf+lVQY3cE5RgMsq4zat8+TsESJ9/jxsSNWttJvVoq1OyBaeQgrRWFcOrjL9g0kUS1Y6F5qCoDpae5yiiQtGgQVhK3Dekn8Qk4gKxHYAdzDeRbkOqQQUt5Kte0mk9QAtop8PHrBnxvcMGhPpMaMp5oC3xBmFFNRDHmL69VSuKwdSxDZEn4ihzPVFoTWT5TydvP7TCRzv/tuiWwd1BP1C39Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WQdjNygsrxcSA8Axbhg1w1C/iuJN1DBe0dZB4ot+v0=;
 b=fPiERbXZfjKNXDpKTFolDIub8dLqBmtIWL59YAd9J5wNBmfGKLW467AwhDoyp15M/5PdNkHP9dhqk1/wcINAEXvgB9PE8k5w4iYekcNEIgAYOSS0pbKPD0dMWw5vlqbNFJkK1NlI6JmgNc/X568nXFQyRfSDKPv/M0c9RqLGwGJS/zTAuZkYm/CzCLkmMz7fiRPC3b7/RSKkEeZszUCwtWpZkHyTwMu9POHi0ygy7JDJMY90SCgvxlyRCLzZPLAhKGROuAwiyWhx0Ctd6ksH88IwNN3EjAM8Dzt9saWvnqMtoox1xHU4qA/cJ8aLKQo9wPQ5d2OxGLUgovbSenpGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WQdjNygsrxcSA8Axbhg1w1C/iuJN1DBe0dZB4ot+v0=;
 b=W+H3YpgigYsU7duAH0G59pRVpRf5pJHr9TQ9HfnN6xFkFGfqVoezdSMQW//7pgh6W4y0r6Vps1kQYbc6/Fps1ilWGIRIJPkWuaLd7UepNYv4ZNoBvdFq1LtbHZliu4yaQpVt4SmzWxU0QI+iuIiD8Vy9wTnzMwYXuoRqRZBZsd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 09:53:08 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 09:53:08 +0000
Message-ID: <ddc93078-bebc-4414-b6c9-07e01d663838@amd.com>
Date: Mon, 24 Jun 2024 15:22:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drop kiq access while in reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Vignesh Chander <Vignesh.Chander@amd.com>, amd-gfx@lists.freedesktop.org
Cc: jeffrey.chan@amd.com, zhigang.luo@amd.com
References: <20240624063109.655690-1-Vignesh.Chander@amd.com>
 <6f21496a-282c-428e-b66d-92edb82b21d8@amd.com>
 <5d63de6b-0d46-422f-bc6e-6f59fce6104a@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <5d63de6b-0d46-422f-bc6e-6f59fce6104a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0213.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2607de-3e14-4fd1-84ca-08dc94337347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VS8xOUtlUm5DR3k4Q3pOZVlBMnFpV281WEMzc2x2MUk5ayt1VS9DMUpMTnNs?=
 =?utf-8?B?MktRUUgwUURVVkZ4NnpNSHNnMytxZ0tCUTVHZWhZV3RGWnRHeGV1OFB4Q1Iy?=
 =?utf-8?B?N2lhVzFIaWUzb2hKZ25tZkx5Vmtid0Nnb3AzS2JzYksvTFJGcXhXS0JMdHhV?=
 =?utf-8?B?YmxIRTVaR1IxYVc1WVdsTVp6c2tjd1V5QjBLS21HWHlkRHRIVDJ0TnVUQkRM?=
 =?utf-8?B?eU5iSnBDQVdOSWI5a21pS1hiazJUYTd1SDQrLzQwYU9Lck9wU2tWWWlMaDdM?=
 =?utf-8?B?NU16bnpHcnBObmozalZCa1g1Q3pGWlQ3SW1ONis1NC9PaVNVNGpoYmdpcXkx?=
 =?utf-8?B?Z3RjdExtVHg1WkJQdVZ6RVRIaFZqWm9IamQ4VUNiSGFpVWZqVlQ3NlpzRGJ3?=
 =?utf-8?B?Nkd6RWNRR2NKZHltcVc1WVJvNGxUUGIxVHN2aElKSm1aZzFQbFVjSy9oU3I1?=
 =?utf-8?B?MUEzWHorZEQwQ0F1a2V2WUEraXJhL09JdmJDQmVINGNpUUdNR0xzT05wU090?=
 =?utf-8?B?ZkNmWmdhV1ZaVHZ2MEUwK0Q0UDdld3J4VkFPWTkrWjY0NG9wWjhmbmNpVDdX?=
 =?utf-8?B?MHB4QVRIYmpjNElmWnBhQ3Rtd1pGMXFGdzRCem5WTHpEVVhpblIwME9LcXhz?=
 =?utf-8?B?bllpL0NHVi9nNjNCcjBST2d6enlmMHNyYmhtWlMzZSt3V056aENpY0h5VHlu?=
 =?utf-8?B?clU1dDU2UnBvRUY4UVZLai9VQlRoRG1ReWZwZFBWYVMvcXVORUZtdzJZSFRN?=
 =?utf-8?B?YU9qS01XTUozL0VDaGI1eWk5WGhGbDVuTm9laEltMVNySVF6YjJtbngydVNZ?=
 =?utf-8?B?ZXVxM0RJMytLNjJCbnB2NkU5MTVIU1FRSHVaM0F2MHpYcWE1eU5Hckp6OC93?=
 =?utf-8?B?RWhENmJveEF5czRrQ0Zod3BXdDBFNlhGMTdXVjRqWUN6SWxBejd4ckYvakxv?=
 =?utf-8?B?TjVJRnhjN2I0dDdOQ3lqQWMwN21sMlFCOFg1Y3hEbUFmcWhjVjFSRlgwaW9x?=
 =?utf-8?B?eGxpRUdJbHZaWWNMVjVrV1VtSVpDb0FuU2NJZm9JclY1UzN5T2VIZ1ZtOW02?=
 =?utf-8?B?Tmo0eUl4VWJBQkloSFBmVVlxZVNLSUl3b1Q1OE1rMlN0aHJaTTFWNEtpVElm?=
 =?utf-8?B?dkZ4QXJpSVZ1dENOV2hTcS8xcndOQlpuNGpuYnFhM3VUUWdyTmc3NHR6Z05o?=
 =?utf-8?B?dGgxeEJhUzNndkNCclJqQ3Fvd1NXckk4Ulg2RHc0UzhzdXZjcktycHM0YjNT?=
 =?utf-8?B?SXJpQ1pURTZkdkZRRCswckdpTTMzQTRxenlUSUhQb3Y3Y09KKzQ4TDllUWJ5?=
 =?utf-8?B?bDlaOEhlZFdVL1VoU01DQ0dZSUxCbkg1NXpNeFJBU1NPajBnL203b09nSVJD?=
 =?utf-8?B?Qnlyd1A3N21PZ2IyREZvY3kwWFJrbkxyS2JQeXlPclVMSFpPckh6K0hkQVVG?=
 =?utf-8?B?a0xxWjhFanZ0RzJsVTZzWWRQNEttc3RkblR0V2pEN0JhTEJib25jT0pueDlt?=
 =?utf-8?B?RUYwRzI4ZnF5Yll0NXZraHI3aHFlWFlPUVdGV3o2b3lXVzByRzBBczBvTUdI?=
 =?utf-8?B?aXZmVXdsSTQyWmhzMDhIUkZ0UnA3NFB2eTEvSmUwNEhGK3pkQmx3a1YrRFR3?=
 =?utf-8?B?QXN5OG5lZ3M3NFdEdHM4eGJ4MlByM2lRS01qbDgwOTFtZnFlN1pFUkRLR0NZ?=
 =?utf-8?B?YzNpcHYyRWxwdUlCaC9EbXMwb1NtbGl6R0ZoU1FkcXlxUUxoTkp3ZHVKLytV?=
 =?utf-8?Q?V3I0v5jU62Zvapi0qyN5vQ/qXDZMTNb7Mm24RAh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTByc2dJcjZId3ZVcVRvSEhFcmQzWEVpWjRXWW16RXNKaUlBQ2xZQkRUaHFO?=
 =?utf-8?B?S0pCeDk2c0p4aVRSaEZDWWlVcVJjMlZRb3d6Y0x1Mit0VXpsWWpyQTlvbEh6?=
 =?utf-8?B?Z0hRNFVwOGo1L2ZYbVN2WGxoMnRlelgxb0c4N3dKU09NMmE1eWNnU3VSVEpE?=
 =?utf-8?B?V08ybm91NmlvYWRyZ0kzTjFyTjEwZWgzTmNkbWl5UWxOL3U1TC9yZTl4VDFR?=
 =?utf-8?B?cVZxUjRsZGJTbXdCSHJpQjN4blZtKzRSZ0ppcE5nMjNOVkF6R3p4VVVjY3lH?=
 =?utf-8?B?ZGhWRDRSWitwMkFIZVVXRE1LVWlxcE1qM1lTOXg0RDVVcm5iemYweENKL0w0?=
 =?utf-8?B?V3NlOCt4R2tRL3pHMFovVndKcmVmOEtmclZSdDQ5OWZpY0M1T1o4dlFNRzl5?=
 =?utf-8?B?VGxCVllBWkg1UzlUMG9Eb2RnazhtTVpYdFFCcWlQOUJTQTl0YmZpcUxQOGxI?=
 =?utf-8?B?bS9wTlhyd3BmYThUV2FiNWhPYWxGQ3hzcTN0SHpKdHFXQ1crUDY3Y3BreW16?=
 =?utf-8?B?OFBSL2VjV0p1OEMvUWtWZExqUUZoSVhDcmh0MWs3VkxwZk5ReCtxNDhPdll3?=
 =?utf-8?B?TkhIQVhFdGpKbE5yVTNzSmt4MFFSV2tUU1Z2cGtUVzgxYUFLRDR5NmViMU1o?=
 =?utf-8?B?ZysvTVgwZ1cvTDZwRE5MWHYzRi9SVW5HQnp3UUhLNDIwRk1jN0pQRGJlQk5l?=
 =?utf-8?B?cUFndktTVmdYOWRNdVdHaW1sajVPZmVkb3B5YmVLeHd0QkcvdXB0MnN1Undn?=
 =?utf-8?B?Q1Q3bWZGYVV5STNsYm1TTUZLeTRJSHVER1lvQWtTWlpYcktUaHVvaHZIU201?=
 =?utf-8?B?ZlMvTXpGU0ZqaGhKc0VmZEEvM0lvMDJWSWVpSVBOUlgxQ2JiZit4ZGEvSW1R?=
 =?utf-8?B?Sy9uRHBVNjgwOTdpTmVnYkRna0UxVmViZTk0YXBTL0h6Nys1WjdnaGx6YkNm?=
 =?utf-8?B?TUNtNmZJZ1hrWUFyVkRJV0JyRUtpMm81d2wzK041TndxSXFTUWt3Y01BN0pY?=
 =?utf-8?B?YU94c2VPWjJKaGJwRExpbHpzZVc1a3o4NDRPWC9lQ0pLZjdZdjJHY21Ub21o?=
 =?utf-8?B?d2ZlVlFTb2NDU1R5MXhsS1J3RG1MSWlDaGtrZEdoWUUySUFyYzZhVUwxdUR0?=
 =?utf-8?B?dkpCdkpjbVRLbHVOQkVLRkIxSE85Ulo2WmhBOU5peTkzb1duNlRQMzZPd2tn?=
 =?utf-8?B?bHIxeU96RmdKZjB6WERFU3c0UGNkVCtlbVBYVHJFOS9pK1ZoS2lrV1M0R3B6?=
 =?utf-8?B?V1ZCcW92elgvMlh5angxZGwvMm8ybmlZMTNJa0RRbFJvQnpSd1lFRFVYSk5i?=
 =?utf-8?B?dVB2U055bkZ4cGUwVEZSYXVJSklNYU0xUWo3VTlEOVh1NU91UVR1ZHdHSjVj?=
 =?utf-8?B?NXhRZlZpNXRIcE4xUVBvU3dvUGtkVFVNanM5cmxOaUNZV3BKckc3SEZZV1pn?=
 =?utf-8?B?RU9sMjI0ZTQ5aS9OekdiRUV0TzFwQWdLSUs4dUZsc0RmbzViRFpSMVFoQmxV?=
 =?utf-8?B?Qm44RnpDYU45dXExbHdkeGZYMW5GZWhSbUhyQTdUUC9FSjVRYk1VMlBaTWE0?=
 =?utf-8?B?eTBFbmJseCsyMHRKcTNJUnVDUitGRTRQZ2dIRFRwQW1Hd2JxcENrT3IrM3p0?=
 =?utf-8?B?MDJ3TVRnS0pYamU4ZUVxL0EwRjhUMGpKaytURGZSUVcwdTZCRmdOQThQYnVQ?=
 =?utf-8?B?bk1JdUNUYmtuSjg0TXYyY1lRamFEanlsSEVzL2JaR2lNRHFhQlhCNUlGSEVN?=
 =?utf-8?B?dnUxR3U4R3RkQ3hmYXhCSHFsbkVSclRZQlRGWWNUcHBJK29iSUJPcXRpTEFG?=
 =?utf-8?B?cmxuQ0dTSDJDMndGWVpWQnA1UkhtWGtXNW9JNmloQ3Y5WFZ2bmlDN0ZUajBk?=
 =?utf-8?B?SGtWVUI2SnlyS3FEUjJtYkRjVmZzMG1NZmtiMm9UdVA1Q09JQmlMclRvZ09z?=
 =?utf-8?B?cG5mRVNBWFQxbmJzQm9tQmtzdU9pNVZjY1pIb2VlQ1JTams5SDZsWlZjV2xn?=
 =?utf-8?B?MGVrdU1sTmd2ZExhanhxQTNuSHR1bmxaUjgzSUhnYXdEcERscld5TDdRQk5Y?=
 =?utf-8?B?Y0cwK3pLVXZHVTN4cW5BOUwveWUxWjJQZFl1MHJwRHBUS09aeTEyMGNZaEQ0?=
 =?utf-8?Q?YVgaGiyRSA2cLDVTbDmj/CoWU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2607de-3e14-4fd1-84ca-08dc94337347
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 09:53:08.1694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLcdm8lXD9lTony2CZ5fWroXtKfujsxrF+5SUQQWBUK753DNhmq+HU32jsO5TTBJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821
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



On 6/24/2024 3:08 PM, Christian König wrote:
> Am 24.06.24 um 08:34 schrieb Lazar, Lijo:
>>
>> On 6/24/2024 12:01 PM, Vignesh Chander wrote:
>>> correctly handle the case when trylock fails when gpu is
>>> about to be reset by dropping the request instead of using mmio
>>>
>>> Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
>> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>>
>> Thanks,
>> Lijo
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 ++++++++++++----------
>>>   1 file changed, 21 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index a7ce8280b17ce7..3cfd24699d691d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -613,10 +613,11 @@ uint32_t amdgpu_device_rreg(struct
>>> amdgpu_device *adev,
>>>         if ((reg * 4) < adev->rmmio_size) {
>>>           if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>> -            amdgpu_sriov_runtime(adev) &&
>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>> -            ret = amdgpu_kiq_rreg(adev, reg, 0);
>>> -            up_read(&adev->reset_domain->sem);
>>> +            amdgpu_sriov_runtime(adev) {
>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>> +                ret = amdgpu_kiq_rreg(adev, reg, 0);
>>> +                up_read(&adev->reset_domain->sem);
>>> +            }
> 
> What has actually changed here? As far as I can see that isn't
> functionally different to the existing code.
> 

In earlier logic, if it fails to get the lock, it takes the 'else' path.
The 'else' path is not meant for sriov/vf.

Thanks,
Lijo

> Regards,
> Christian.
> 
>>>           } else {
>>>               ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
>>>           }
>>> @@ -681,10 +682,11 @@ uint32_t amdgpu_device_xcc_rreg(struct
>>> amdgpu_device *adev,
>>>                                &rlcg_flag)) {
>>>               ret = amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_flag,
>>> GET_INST(GC, xcc_id));
>>>           } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>> -            amdgpu_sriov_runtime(adev) &&
>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>> -            ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
>>> -            up_read(&adev->reset_domain->sem);
>>> +            amdgpu_sriov_runtime(adev) {
>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>> +                ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
>>> +                up_read(&adev->reset_domain->sem);
>>> +            }
>>>           } else {
>>>               ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
>>>           }
>>> @@ -740,10 +742,11 @@ void amdgpu_device_wreg(struct amdgpu_device
>>> *adev,
>>>         if ((reg * 4) < adev->rmmio_size) {
>>>           if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>> -            amdgpu_sriov_runtime(adev) &&
>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>> -            amdgpu_kiq_wreg(adev, reg, v, 0);
>>> -            up_read(&adev->reset_domain->sem);
>>> +            amdgpu_sriov_runtime(adev) {
>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>> +                amdgpu_kiq_wreg(adev, reg, v, 0);
>>> +                up_read(&adev->reset_domain->sem);
>>> +            }
>>>           } else {
>>>               writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>>>           }
>>> @@ -812,11 +815,12 @@ void amdgpu_device_xcc_wreg(struct
>>> amdgpu_device *adev,
>>>                                &rlcg_flag)) {
>>>               amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag,
>>> GET_INST(GC, xcc_id));
>>>           } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>> -            amdgpu_sriov_runtime(adev) &&
>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>> -            amdgpu_kiq_wreg(adev, reg, v, xcc_id);
>>> -            up_read(&adev->reset_domain->sem);
>>> -        } else {
>>> +            amdgpu_sriov_runtime(adev) {
>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>> +                amdgpu_kiq_wreg(adev, reg, v, xcc_id);
>>> +                up_read(&adev->reset_domain->sem);
>>> +            }
>>> +            } else {
>>>               writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>>>           }
>>>       } else {
> 
