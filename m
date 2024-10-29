Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DE7D2AB11
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 10:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0415710E609;
	Tue, 29 Oct 2024 10:04:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gFBCJtcY";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F6E10E609
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 10:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+Mj/ywMbAwJake5Gsf3wjb9rQt0U6HTIE3F9k+sin7ZQY4JkOoq7ADoqnaOLaKtl6D6QSQsJenL7zXq4vmuDYDVyr8Lpu0yQjD0ObaMsBwRI2yk1XizOQ5GiMxQYVL8Av1MFGtcNLXD7E1UmmW6buwxkw5HfBJxTTrdTNeCavhD7yzJuWzRCsEE2zzKdb69wEGSZG2u/XLOicCSLuIuDA0jIGNcb3bgsFC3jPvHvQm3+O5fwVGrynu2IFKcnCD1npWqV6AGrCeqAdAVC4zx2hWoxGR9Eq0GQfCbGHZJzLvKxAqu6liq+afkrarTWssr/NjQ1Lo/V9913yTJJqU72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sA9UXmd4by75Uqk3j/O05qvH+1z7sWsomTLbfQ0zPPw=;
 b=gvpKwLcStXi2hpK5yg75+5AxXI+MLd5k7s5DdNcEsn2ZPLff4A/cpk8qroJb8wc9QtRXqqsikwDHi7xd4QTEAyI3EuBt57eQwkNkFWZLwyGfUHboYRwY2yBWdvuqheH5TzNajQXlF33VAcRw6I9hwDqaBgegjwELcAN3Gnn6faWOSISUAL/V3+YTLCQoEuLLh58JNvgUpsqI03Bgrjc85cgdzFkAzhjalX8JTJWsYmy7rPsaeLpUGSK+wMJ3ym7kF1Z1xWXcP3Zt6fUYdZ8Eu8uZk0NDbDFPYCdjI0DcvKuKr9SKPy3hw324P8/4hXGVL/AqKOK6sCcbLnwTFH4FKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sA9UXmd4by75Uqk3j/O05qvH+1z7sWsomTLbfQ0zPPw=;
 b=gFBCJtcYWBDLQ3Td3CqXtY9771X9Dnbx0mgoSXT/dWJe0fIoJGtSiqKVc0CTXQ1gPQlwTyOPFKLT9TMqfoddg0PPCgRfK4glkU12OLCGe0R75htRc2JaPhdtpC/um+Frqt2apjD+vz2ltOR2/94odKgF0PafC+v5YTDMPod0N1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 10:04:22 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 10:04:22 +0000
Subject: Re: [PATCH 23/29] drm/amdgpu: hw_init for each vcn instance
To: boyuan.zhang@amd.com, amd-gfx@lists.freedesktop.org, leo.liu@amd.com,
 christian.koenig@amd.com, alexander.deucher@amd.com
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-24-boyuan.zhang@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <7d123c59-392c-90ca-7ad7-4b0bbfc6ef0a@amd.com>
Date: Tue, 29 Oct 2024 15:34:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20241025023545.465886-24-boyuan.zhang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0215.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::8) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f00ca9-9f03-4853-bd0f-08dcf8010f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmNOdUFpTitVeDhmVlJoeUlQRFZKTkdxTHNscjdzUmpLeTFqQ3NvTXdNUDY4?=
 =?utf-8?B?RmhZRk8rRTl0dDArb2VrbzBrdDBsYUNDaXlMa2V0cWkyNVhRcHZDdjZUTERx?=
 =?utf-8?B?QWFYUFREMmZ2V0o5VVJUVy9wRVI4cTNlZmovUFJDb0tRTTMrSHZqdG9sRGtX?=
 =?utf-8?B?V3RSSzhmTlpDT25aaHQ1aTZmZ0poVjIyam82RENWYU82OHYrM2kwc011Q3B2?=
 =?utf-8?B?NGk0d1lIeXBML3JUMHZFTGY3Ty9mZHhhTVh4b3p2WjYrWmtPajFHYWRMV25k?=
 =?utf-8?B?YXhjVmttMi95bTlmNmxmRFhtOXNZL2ZFYkJTZXZTVzlmUW5tMTM3OEozbXhm?=
 =?utf-8?B?Mm5lYnNTSUlHVlEzaDM1NEFLMWV0Z1BhT245RGhTNlNmMDFrOFQ4cngwL2N2?=
 =?utf-8?B?VkkyN3FLZmUvTTYrakJnSkZWNmN1ZVYvZXN0RnRpNUFJaXFLZWFuVnUxd2Fh?=
 =?utf-8?B?TU5RTHdHSHhISmZiajIzL29rbDVnQWJFOHlpcGFRaU1JYVRlMkFzL0E3VHZy?=
 =?utf-8?B?QUp0cXNVRjNjTTJhQk9YalNXUytKZW9Eck50Q2JLNitjNi9BV1AxZzFnWnQ2?=
 =?utf-8?B?UEEyYjBjNnRhUjZyaGo4ZUdxVFpwZ0w2MWt2RFZYYjZLTlhWUnY5dGpQTlhs?=
 =?utf-8?B?VERaS2hyS1FDNkd1N3k2WEZVWjNRa2NzOWxSZ2NsT2NibHdGakZNSHRYeThm?=
 =?utf-8?B?Yk4yWlIvSTVuczBGREZqbVNkQ05zRC9uTDdtaXQzRnRlREdMRFRlN2oydnBm?=
 =?utf-8?B?bEZtYlppR2R0ZjljSlNtazFROXN6ajlYQ3FYQ1dGT2VVUm1lU1g1QnFSM25j?=
 =?utf-8?B?ckJpL1FFaUdiS1dFWHBEV2xjVVJaMXJGaEFoL1VEdjdOMlI5QncycXloRHRV?=
 =?utf-8?B?NnFLM0NQakZMUHJUZFhBMENrS1U4dlZndFRNTUU4Y3g4UlZpTENnRER3clIz?=
 =?utf-8?B?YisxVDhnQnIyelY2L0ozNkJVNjJyRTgzd2xZUDBvU1hMd2hqWlNsdDhpMVZw?=
 =?utf-8?B?YUlMVUxReFBQdGlQY09UbVBGSGRLNWlCUkw3TUtVTFExcDF5VkFDMUtlK1BT?=
 =?utf-8?B?emxkSWVMZUxBd2lSODlYVWM1VFBDZ1pqVmVQQmo0U2R6Ymd5YWFuajVvRFBs?=
 =?utf-8?B?NHJGZWZnOVdiOEFzWWR1N3ZtbUNkNWk4VkNTTVdrQ29Ddi8vVXA3ZzB6TzhT?=
 =?utf-8?B?R2JBZVQrZXNTUkI5c1dDZ3NMRUFsczhtM1NySmg1bzdGRmtMeFc5bzlSSmNp?=
 =?utf-8?B?RUEvNFFpemJpZEJwK0lTUEpra0tDZkVqMGxsWDM3YkRJbEYyeGVGNDlYbzFw?=
 =?utf-8?B?Z3Y5Y3V4b1VBR3Y0aTlqdnMyZktJZFRkL3diV3VZZzdCWU4vQ2drZlU0V3Ri?=
 =?utf-8?B?SW1UYjgxYVh5dkdUWHpDRnUwWWc3UEFqY0Vuc3ZRVmxNS3psMU9GWHRLNkxQ?=
 =?utf-8?B?NTRPVmhLdWtLUzZpNmdaNldQcXN4RWQ1clZVSTFHUnIxbFN0cjZvNitYZW8z?=
 =?utf-8?B?Q2F5b3FuTEhUeHpoQWtHcEFnVVpZS1NiNy91Q21CVis4RDlvMFUySnF2QVJR?=
 =?utf-8?B?Um1pQjNRSzFuNXJSbm9xREp4QW4zSE1ETHJjSXU3Mm1RSVdpcGRtaWEraGk1?=
 =?utf-8?B?eUN6akRzVmRUbWI1MTU5VzZ1S0pWbXI4RDdEWVN4RmpvMlRIQjlGZmNmVVNo?=
 =?utf-8?B?Y3hRRFVUd3V3Ny9QcGNvL1ZOVmo0US9jZ2Jnc0ZSejRteDBuVmN6bFdHUnpG?=
 =?utf-8?Q?zOdo78tGIEjV6F83AA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWxpNC9URVdCcmRjcUx5Tlpoc2tnc0FGRFhKdWFHTzQ3RC9xTDlLK1pvY0tp?=
 =?utf-8?B?NHpVb3ltNHJ6QWNuZkpYUmZuTHVtK3NaL3JjV005MnAySExqMmlvNFBmdmM4?=
 =?utf-8?B?SlRvNzRTMzRDd2NoVWRBc29wbC8xMmQ4L1ZVMEE1cm5jUzM5bmhZa3J6dkQz?=
 =?utf-8?B?NWFkbjVVVFIxZWVQUjJ0RCtialFYcWIzTUprRGg0ZG9lNkNqaG5tL1lGenQx?=
 =?utf-8?B?K3hqcTNXd2dwYko1allrV09uWFhYc0N3REw0Z1dBeis2UXFLUTB2aEhrMEZp?=
 =?utf-8?B?ZmtVL1lVckZkSDNPSGdwbzNDeks1ZGxML2FhVUtQdndFNCtGU2FWVkUzbndV?=
 =?utf-8?B?dDFQV1FTWXkwSEY1dVAxVGZyWnoxd29kM3BvclprOURBZDJmRWRicmh2SGN1?=
 =?utf-8?B?TjlNL01Ua3pZaDBBZ0J6dDIrZmE5NmxlK2kxSkdpaGhPVjh6SFhrcEY2Nm0z?=
 =?utf-8?B?RnNmdGovalRzYnY3eWxnK0poRk5QTkwrRHQzUE93ODFmZXFMbm5Nbk5uY1cw?=
 =?utf-8?B?SkxoaitHTzFzNEQ5dkhuNmVUVHJVS0QvbC9LU0VFMjQ1ZUdwL1ZUUjhsSmxa?=
 =?utf-8?B?MFBtZnpoU2VwZzJ0Qk1JcDNTajJPNHVkeS9kZ2lKR2kvMUdqeTBtK1lHdklo?=
 =?utf-8?B?cU55RmtKSTN3T2Y4VStjZTVyQU4yd0pQSUlZdkNJWkxVMzg4ZHB0ODBYdTF0?=
 =?utf-8?B?enNrWFBlRjFsMlRWZlFRaDJSMFRtendvWGJKL2xBUEpZY1FINDRJb1BIZldT?=
 =?utf-8?B?b3FOMTRYdGpFRDRUaDNGbFVIU2VLNkJ5N1FGRUhoQWF2SE1MeW8yUVBpWXRn?=
 =?utf-8?B?WVdwRXI4aGE0TGxvTS80aVJpM0NPZkI1bmYyUks2V2dMKzZLQ1cvNnQzSGpz?=
 =?utf-8?B?QjJwSURJTlNwaVdQclRNY3lyVXVpVnNDQ21lUjlVT2lkSDRMVk5sV2NzWFZC?=
 =?utf-8?B?a3JvVDJmTDdpUlhSbGpKMWcxb2RGRUpiSlN3Ykd0cmhqWU1DWXZaVVNoOGFh?=
 =?utf-8?B?eFVab1hBN0htN212VlNldG9DdklLeEt1OXlTb2JQOGtQYmRJU0x5U2c3OXk0?=
 =?utf-8?B?QllVTzZpVE5Zdk9uS1RucDhqMUxkU1ZSbmNWSDJvamdnUWpUNGlPVW5DQUdP?=
 =?utf-8?B?ZDd3anY1cXovL0FwdGtDaEJzcm41by9SNFlWeWRvMTk1empDM25KeGNkQmxP?=
 =?utf-8?B?TGxLOVVXV0llV1hlSkNBSnZ2c0NIOWtxdnhOejU5OGI4Z3ZKSlhsNUMxbHEv?=
 =?utf-8?B?WTAwWXcyZVBidTJ2MGE3N3dTTEZ3K0J1Rmhqem1Ic1kyODBzbEJ2RzVwRGJ0?=
 =?utf-8?B?aGFMZXFTWmZZa3VJajZ2aHZFMmk1clBxZHJOanBjRk9vL1l5R0lWRlROMUhm?=
 =?utf-8?B?U0F1bjdGR0V2cDF3WEk4bFZ1UVcyV245MmNnTkVPMzZ3emZFSHZvRC9FR2tY?=
 =?utf-8?B?OUpZbmp0Q1ZDZkJ6ZkgvZFE5b3JMZzg1NFo5dXdJaTA0VTJjZ3lVT3E1L2xq?=
 =?utf-8?B?bkpSSUZWbTl3ZnY0VE1nTzF0djg1dWNqRFRsNElTZ3lsS0REUkQ0QWxYdDMv?=
 =?utf-8?B?NDkwYnMxcWJucmZHN2QySlJ0MTlpOFJLZmpuem1peWNadWpYWkNsZ3ZCd0c3?=
 =?utf-8?B?SnpXU0FyNWZ4SUtkTTg5YThXZTRwcjkxaExWSjlzWUtLc0hJU1VkWkNBVWx6?=
 =?utf-8?B?U1NyYkpFeWdjOEhKaXEvRlFUaGhiV2xTSG14QUJnaVNQY1JnQnNaUDByaVpv?=
 =?utf-8?B?K2lWb0dCSm9jd1NUdHh1YThPUlV3Z1JRa2hxVTdWQ3RoSVlGOFV5TURoNjJ1?=
 =?utf-8?B?VnZLQ1lzU0QvYi9DMVFNR3ZVZ1pkcmEvcGMxUGNqKzdMWmtUQWNhd25Ib0xO?=
 =?utf-8?B?ZXUwejVlNkliZ1M1SFMvYlE1aFpId3dlNURpRE1PZDZMUlQ2SGh3R2JMamg4?=
 =?utf-8?B?dnY2eWtVWWEzM2QwM3YzZlNiV3hNWmV1Zmc2NHYvSmlRRGtXN1o2VlUyQ0g4?=
 =?utf-8?B?M3JHV245VVJHNEFDM3JvQ2x1RmhoYjV5UmFENnpDU3h2UG0yNmJlR1EvL1Y2?=
 =?utf-8?B?VjFYc3l2dlA1czN4RTBrdGRKTFBBbks1NUI2SWc0S0pMV3dCV01ocGFPV01S?=
 =?utf-8?Q?uN/tdfxT2BGtigi353Oo2IUjb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f00ca9-9f03-4853-bd0f-08dcf8010f9b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 10:04:22.1960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOzU0jWGfHhatBlXRG3O4flPjRkQX2LYzNHC/PjGYEvXhXAg7rpaHdhjYtATVRtm14olnIRX+kkf9i4wEtLowQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
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

Acked-by: Sunil Khatri <sunil.khatri@amd.com>

On 10/25/2024 8:05 AM, boyuan.zhang@amd.com wrote:
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Pass instance parameter to amdgpu_vcn_hw_init(), and perform
> hw init ONLY for the given vcn instance, instead of for all
> vcn instances. Modify each vcn generation accordingly.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 39 +++++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 73 ++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 37 ++++++-------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 67 +++++++++++------------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 21 ++++---
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 21 ++++---
>   6 files changed, 123 insertions(+), 135 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index d135e63e7301..8ce3cea6cf44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -338,37 +338,36 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	struct amdgpu_ring *ring;
> -	int i, j, r = 0;
> +	int inst = ip_block->instance;
> +	int i, r = 0;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		r = vcn_v2_5_sriov_start(adev);
>   
> -	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
> -		if (adev->vcn.harvest_config & (1 << j))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return r;
>   
> -		if (amdgpu_sriov_vf(adev)) {
> -			adev->vcn.inst[j].ring_enc[0].sched.ready = true;
> -			adev->vcn.inst[j].ring_enc[1].sched.ready = false;
> -			adev->vcn.inst[j].ring_enc[2].sched.ready = false;
> -			adev->vcn.inst[j].ring_dec.sched.ready = true;
> -		} else {
> +	if (amdgpu_sriov_vf(adev)) {
> +		adev->vcn.inst[inst].ring_enc[0].sched.ready = true;
> +		adev->vcn.inst[inst].ring_enc[1].sched.ready = false;
> +		adev->vcn.inst[inst].ring_enc[2].sched.ready = false;
> +		adev->vcn.inst[inst].ring_dec.sched.ready = true;
> +	} else {
> +
> +		ring = &adev->vcn.inst[inst].ring_dec;
>   
> -			ring = &adev->vcn.inst[j].ring_dec;
> +		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> +						 ring->doorbell_index, inst);
>   
> -			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> -						     ring->doorbell_index, j);
> +		r = amdgpu_ring_test_helper(ring);
> +		if (r)
> +			return r;
>   
> +		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +			ring = &adev->vcn.inst[inst].ring_enc[i];
>   			r = amdgpu_ring_test_helper(ring);
>   			if (r)
>   				return r;
> -
> -			for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> -				ring = &adev->vcn.inst[j].ring_enc[i];
> -				r = amdgpu_ring_test_helper(ring);
> -				if (r)
> -					return r;
> -			}
>   		}
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index d00b7a7cbdce..36100c2612d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -345,8 +345,9 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int inst = ip_block->instance;
>   	struct amdgpu_ring *ring;
> -	int i, j, r;
> +	int j, r;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = vcn_v3_0_start_sriov(adev);
> @@ -354,57 +355,53 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   
>   		/* initialize VCN dec and enc ring buffers */
> -		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -			if (adev->vcn.harvest_config & (1 << i))
> -				continue;
> +		if (adev->vcn.harvest_config & (1 << inst))
> +			return 0;
> +
> +		ring = &adev->vcn.inst[inst].ring_dec;
> +		if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, inst)) {
> +			ring->sched.ready = false;
> +			ring->no_scheduler = true;
> +			dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
> +		} else {
> +			ring->wptr = 0;
> +			ring->wptr_old = 0;
> +			vcn_v3_0_dec_ring_set_wptr(ring);
> +			ring->sched.ready = true;
> +		}
>   
> -			ring = &adev->vcn.inst[i].ring_dec;
> -			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i)) {
> +		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +			ring = &adev->vcn.inst[inst].ring_enc[j];
> +			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, inst)) {
>   				ring->sched.ready = false;
>   				ring->no_scheduler = true;
>   				dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
>   			} else {
>   				ring->wptr = 0;
>   				ring->wptr_old = 0;
> -				vcn_v3_0_dec_ring_set_wptr(ring);
> +				vcn_v3_0_enc_ring_set_wptr(ring);
>   				ring->sched.ready = true;
>   			}
> -
> -			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> -				ring = &adev->vcn.inst[i].ring_enc[j];
> -				if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
> -					ring->sched.ready = false;
> -					ring->no_scheduler = true;
> -					dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
> -				} else {
> -					ring->wptr = 0;
> -					ring->wptr_old = 0;
> -					vcn_v3_0_enc_ring_set_wptr(ring);
> -					ring->sched.ready = true;
> -				}
> -			}
>   		}
> -	} else {
> -		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -			if (adev->vcn.harvest_config & (1 << i))
> -				continue;
> +	}
>   
> -			ring = &adev->vcn.inst[i].ring_dec;
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return 0;
>   
> -			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> -						     ring->doorbell_index, i);
> +	ring = &adev->vcn.inst[inst].ring_dec;
>   
> -			r = amdgpu_ring_test_helper(ring);
> -			if (r)
> -				return r;
> +	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> +					 ring->doorbell_index, inst);
>   
> -			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> -				ring = &adev->vcn.inst[i].ring_enc[j];
> -				r = amdgpu_ring_test_helper(ring);
> -				if (r)
> -					return r;
> -			}
> -		}
> +	r = amdgpu_ring_test_helper(ring);
> +	if (r)
> +		return r;
> +
> +	for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +		ring = &adev->vcn.inst[inst].ring_enc[j];
> +		r = amdgpu_ring_test_helper(ring);
> +		if (r)
> +			return r;
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 7c3a62f84707..00ff7affc647 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -299,37 +299,34 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	struct amdgpu_ring *ring;
> -	int i, r;
> +	int inst = ip_block->instance;
> +	int r;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = vcn_v4_0_start_sriov(adev);
>   		if (r)
>   			return r;
>   
> -		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -			if (adev->vcn.harvest_config & (1 << i))
> -				continue;
> +		if (adev->vcn.harvest_config & (1 << inst))
> +			return 0;
>   
> -			ring = &adev->vcn.inst[i].ring_enc[0];
> -			ring->wptr = 0;
> -			ring->wptr_old = 0;
> -			vcn_v4_0_unified_ring_set_wptr(ring);
> -			ring->sched.ready = true;
> -		}
> +		ring = &adev->vcn.inst[inst].ring_enc[0];
> +		ring->wptr = 0;
> +		ring->wptr_old = 0;
> +		vcn_v4_0_unified_ring_set_wptr(ring);
> +		ring->sched.ready = true;
>   	} else {
> -		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -			if (adev->vcn.harvest_config & (1 << i))
> -				continue;
> +		if (adev->vcn.harvest_config & (1 << inst))
> +			return 0;
>   
> -			ring = &adev->vcn.inst[i].ring_enc[0];
> +		ring = &adev->vcn.inst[inst].ring_enc[0];
>   
> -			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> -					((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i), i);
> +		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> +				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * inst), inst);
>   
> -			r = amdgpu_ring_test_helper(ring);
> -			if (r)
> -				return r;
> -		}
> +		r = amdgpu_ring_test_helper(ring);
> +		if (r)
> +			return r;
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 5a3de3dbc3c9..feb373a96cfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -257,49 +257,46 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	struct amdgpu_ring *ring;
> -	int i, r, vcn_inst;
> +	int inst = ip_block->instance;
> +	int r = 0, vcn_inst;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = vcn_v4_0_3_start_sriov(adev);
>   		if (r)
>   			return r;
>   
> -		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -			ring = &adev->vcn.inst[i].ring_enc[0];
> -			ring->wptr = 0;
> -			ring->wptr_old = 0;
> -			vcn_v4_0_3_unified_ring_set_wptr(ring);
> -			ring->sched.ready = true;
> -		}
> +		ring = &adev->vcn.inst[inst].ring_enc[0];
> +		ring->wptr = 0;
> +		ring->wptr_old = 0;
> +		vcn_v4_0_3_unified_ring_set_wptr(ring);
> +		ring->sched.ready = true;
>   	} else {
> -		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -			vcn_inst = GET_INST(VCN, i);
> -			ring = &adev->vcn.inst[i].ring_enc[0];
> -
> -			if (ring->use_doorbell) {
> -				adev->nbio.funcs->vcn_doorbell_range(
> -					adev, ring->use_doorbell,
> -					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> -						9 * vcn_inst,
> -					adev->vcn.inst[i].aid_id);
> -
> -				WREG32_SOC15(
> -					VCN, GET_INST(VCN, ring->me),
> -					regVCN_RB1_DB_CTRL,
> -					ring->doorbell_index
> -							<< VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> -						VCN_RB1_DB_CTRL__EN_MASK);
> -
> -				/* Read DB_CTRL to flush the write DB_CTRL command. */
> -				RREG32_SOC15(
> -					VCN, GET_INST(VCN, ring->me),
> -					regVCN_RB1_DB_CTRL);
> -			}
> -
> -			r = amdgpu_ring_test_helper(ring);
> -			if (r)
> -				return r;
> +		vcn_inst = GET_INST(VCN, inst);
> +		ring = &adev->vcn.inst[inst].ring_enc[0];
> +
> +		if (ring->use_doorbell) {
> +			adev->nbio.funcs->vcn_doorbell_range(
> +				adev, ring->use_doorbell,
> +				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> +					9 * vcn_inst,
> +				adev->vcn.inst[inst].aid_id);
> +
> +			WREG32_SOC15(
> +				VCN, GET_INST(VCN, ring->me),
> +				regVCN_RB1_DB_CTRL,
> +				ring->doorbell_index
> +						<< VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> +					VCN_RB1_DB_CTRL__EN_MASK);
> +
> +			/* Read DB_CTRL to flush the write DB_CTRL command. */
> +			RREG32_SOC15(
> +				VCN, GET_INST(VCN, ring->me),
> +				regVCN_RB1_DB_CTRL);
>   		}
> +
> +		r = amdgpu_ring_test_helper(ring);
> +		if (r)
> +			return r;
>   	}
>   
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 2c9f863c40b1..fb1e1d5bcdbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -268,21 +268,20 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	struct amdgpu_ring *ring;
> -	int i, r;
> +	int inst = ip_block->instance;
> +	int r;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return 0;
>   
> -		ring = &adev->vcn.inst[i].ring_enc[0];
> +	ring = &adev->vcn.inst[inst].ring_enc[0];
>   
> -		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> -				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i), i);
> +	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> +			((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * inst), inst);
>   
> -		r = amdgpu_ring_test_helper(ring);
> -		if (r)
> -			return r;
> -	}
> +	r = amdgpu_ring_test_helper(ring);
> +	if (r)
> +		return r;
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 9d67e884952a..137c3b452433 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -232,21 +232,20 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	struct amdgpu_ring *ring;
> -	int i, r;
> +	int inst = ip_block->instance;
> +	int r;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return 0;
>   
> -		ring = &adev->vcn.inst[i].ring_enc[0];
> +	ring = &adev->vcn.inst[inst].ring_enc[0];
>   
> -		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> -			((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i), i);
> +	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> +		((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * inst), inst);
>   
> -		r = amdgpu_ring_test_helper(ring);
> -		if (r)
> -			return r;
> -	}
> +	r = amdgpu_ring_test_helper(ring);
> +	if (r)
> +		return r;
>   
>   	return 0;
>   }
