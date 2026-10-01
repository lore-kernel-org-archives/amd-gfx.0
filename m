Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2315ECA5FD2
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 15:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A93F010F6FC;
	Thu,  1 Oct 2026 15:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mRSQuiDP";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFAEC10F6FC
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 15:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxWFhnMQjSm+Lsax0+XhcRukR0fNvVOsoBoG2OfpuLHWmLSrgW+VGD6yWpYHMpdmJz63LQNssvBkGPuP4tALuuL7iekbhDf6xElrPPEPPYSZcVGnMBvB2tXqbqRs81XCJ7T4ujX7tuXks5cQW2+Knv0Rbj+htWm6E19LPqMSYnaWYcz3KTemTVC/u2z0B55B4mINYSjfhX3mdPzH86XgefbgKTbnbk4bLL5wkM/9xh4gCep95Hd+4r9wHVFCdRllOsSg/L92iIH2py0tPpDCoyEUpM7FHibTIFdCSj49WJrInuZqw7VHUb6PXXa58D6VPSvcqJgZnty9eqtW55Jn6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6h59gN7xFJKnrQvO7V//MExUvwbU049E4F/uJq7v6To=;
 b=b0/fLzQNB3XvAN4ay/Pfkd1V4qr3yc7TsJRc+Q5sUBdDFsNrvCGwWGw6l2RnfySAdiUHcNabid8gbSMu/8lNTx4zp1ksOyiW5pKlaGEf/5E6EfdQ3NQPOv4K/CdHsyQC2+Dkov5XwgJE+c99U8/BE9GMNapXqGEEBuXwK73YbJV82Qq9QblHfgVeTpNTRWaoJbaWauwYn7GoBM5bJgXDXKytaVtC1djk1Kx6XXNW0gWNp157ZPRBiqYMTwndNcSxDnft1QQZZP/7TwcxATj/gORm+klsDPzsAwN5h+Kz8sZcUzTxNimXCaj3DUoXSfFoSY8omjsepC/t7OJqqOBq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h59gN7xFJKnrQvO7V//MExUvwbU049E4F/uJq7v6To=;
 b=mRSQuiDPcVr8+tHg+Y2U5rgv9C+K9Q4FzcTHgmtXM9POO9gQr1zNsLBk1K9CYXn934lxpMLtU4QyLTRuj3Opr2CHXjUaQvUR6RXjSqiehtoGWCfhRkOggKppttgI+a61VnigtSM4JNTN7g5PLXd13j1mhiLUQ6KyUQTTEt48N+M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by LV9PR12MB9832.namprd12.prod.outlook.com
 (2603:10b6:408:2f3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 15:51:09 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 15:51:09 +0000
Message-ID: <d2157c31-ead7-45ee-b459-1f7d3daf08cb@amd.com>
Date: Thu, 1 Oct 2026 11:51:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/amdgpu: Enable remote TLB shootdown
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Mukul.Joshi@amd.com
References: <20261001135406.4049406-1-Philip.Yang@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261001135406.4049406-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0002.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::23) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|LV9PR12MB9832:EE_
X-MS-Office365-Filtering-Correlation-Id: be4e682c-84e7-4e0d-37de-08df1fd3cf73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aAjNcELbIVBpTwSAW57N6L0d6imslgSUUoOMqIAlbHO9ZoqyPvp560Od/O1tuW04uz3hPsZpwCGSKEJK8Vlcd9arYOhZ+DpaXgZYTpM2N8/n3CEnIfenO8F8WvdMgpEv0qYs3pci0C7ertFcD6n8aLxsNT8EYmMGEO9j9NWcmfQ/rpkdzMFGtDV7DlBT3SWtysJFth8q8cbrPWPwH14+/40MbycciKUbia44PM6brGGYG17Mdi8IPT8iT8tk4KxCClVR4e+mvwoJIWJFdc46Parrin9xoqc0DJLqz+VVaLZd16VgTdukqdq8ceC5BP6feZwvqp4CvsLkYmA7LOdjL8VaeKTuxXgrZshUD/HyOONEFPor0dQGwKqQERtaaBz4a/0UW75VRnSCKzLGzNA9f5+PlUDv3kq4umzogJBCvRn3Q1fxKcSEEDi7FC17Kf2PVgMiGrQOLX4nqKrLseCvHDBXuDZMqnz+aN3RGpsB9X27ClmztF6aWuzzW6GUPZ72qsrEsBzbFJ+d4GFaHcmDJi/Da3DnSA0cj6i17qMEdCK3fQPS/DpsIy+kA2y1Cf/GTQBjRs8LqWlsWusJCyeuGSH+WCPJidH/gYlVVmryYJMlPwJGbiSrW5JNKqLEdp7BrMRtwrSBzW+dNwMmtb/MYeCTfCmXqhhMbfs8EAeuZO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjB6UmhOYmh5dWpkeTZycHFjOHIxckhnU3kxR3VhNWZJWTkzOSsyYWRQZTEr?=
 =?utf-8?B?enlMNmRtNGxiZ1NrOVVQVmxpM056Z3ZrY0NUVEkvTWxTVXpMcldFZGF2UlVm?=
 =?utf-8?B?cHMvMStBcUJWamhRVXNHTy9KTm9wd2hHQ21UQy9XaDFPektKVkxRS3g0YjNX?=
 =?utf-8?B?T2FRa0d1S1dSMWFraUczWXRqNnNzQ2xDQ0M0VWJiM2tHSzJlb1JnbEw0Nlhn?=
 =?utf-8?B?bmxUS0xvZi9PTEFITzRNdkMzMjlJVWhTN1NKMjBYTFFkQ1J6N1VtQklhdTUw?=
 =?utf-8?B?VU5HQ3RDV2Mvc2hGcVhBVURnUzlISWZLeXJLK0o2TkxEMG82OVd4SVR3Nzhq?=
 =?utf-8?B?cE1CQWJlMUsybFBsZlYvWVM0TncrWGllTy8yTHIySm16NjlJVnhGSFFlVnZF?=
 =?utf-8?B?QlRuSzFCV0svSmx6dnNrWURTajdEUTJyVldQZ3BhYjRmMHkrUC92MC9INnJp?=
 =?utf-8?B?Sk5mZTBXOHJ0Y2Jqa3dUQnNhRURjQUxVZGZhREVyakhhZWJORGZaVVBaVURB?=
 =?utf-8?B?RDRtZmxkcTNLWFNiMzgxS1F0Z1JueCtYdy9vcy95RFRwd1djL1JZR01lYVJx?=
 =?utf-8?B?Tlc3ZVYyVmFBOVd6bEZobG5GRElpWkFNN21RMWJ6RGt3aUF4TmlJOFRQeXlx?=
 =?utf-8?B?Vm02RUJGOFExZ28zaktRUDh4YXY4UjA4TVoyZWNrQmIxTFFGbENrRUUwUjht?=
 =?utf-8?B?djkrWk1XUjd5ZXRobGFvMVFCaFlIMDZLMFhTclJSZnVJTWdjcWdjWmloTXBZ?=
 =?utf-8?B?R2tiUHJSQ2pLdjdqRXpDcUFJR1JWUndHRDFUK1lVVDd0Z1VVSkY4dCsyOXVV?=
 =?utf-8?B?WjkwVTV2b2luNk9lelpzTGh0SmV4UzQ3czE5bG9NaTBFcFY2ZGF3amM2elFL?=
 =?utf-8?B?YlppUXA1OHc4dXZQM0tBaVBzd21qSWJSK0RnVmdBenBEbXBMVU16QzR4UUQ1?=
 =?utf-8?B?VW1xcXBRd3dFemVtUW9JV2s1QnJVQXJxWXQ1VjBMWHJ3OEhxM1c4RTk3UnBV?=
 =?utf-8?B?VDVQMUhWLzR3Um1NVzJVU3ZlcWZRSmdSMjdEM2M0bEk0OFhtWjZ0ZnM3Yml6?=
 =?utf-8?B?K1RyMzFnZmQxdGhJMnd1dDJWMkkrd0JvbVpnTURmb1J5K3ZhdTkxU2FQNDBN?=
 =?utf-8?B?bk81ZHYwZUtMbWlkWndyV254RHBUWGQ2VU1IWHoxMGhBY0o4RS8wZmlXUHpU?=
 =?utf-8?B?blRGUFYrRi83amJMaGd0OVlkK1FEcU1NK0ZZMWNzdzdCbkd0aHhkZ1lrV0gw?=
 =?utf-8?B?Y1M0dENaT3REL0NlZjRaaE12SGFDbG8rTEc0MnlWN0piY1o5L2tCL0xBQmhn?=
 =?utf-8?B?cGdTWWVIQ0ZEd3ViN0xvV1hLdEo4dlFIb252OWVxRjM1THpyT252NS9tRlZw?=
 =?utf-8?B?OG5pMlMwaXBiQVdITWd0Q3g1ZHgzZVVqdHZyakRSRi80eUZYOXhKbS9mb0Qw?=
 =?utf-8?B?dzFidXR6T0U2Ry9Jbm52ejVvMDlZV2lwTkI4RXJ6YThReUUxWWNnNjIwZmhq?=
 =?utf-8?B?Ry9sNll6RmdKQ05Gb25uTTFKVDhIOEcvVUo2dVpWWXJ3TE9PbHhBamVRMHoz?=
 =?utf-8?B?TnNsYlZqMy9TbHU1T3V2Q1pNZ2ErSWZEU1EvalZ1Rk1LdE9odDNHQkVFS0RO?=
 =?utf-8?B?cGtBbjg1UW1vS1huRVY0NFViNzdtM1JDNi9BN2phUjFBcG11OFRqZmhrM2hZ?=
 =?utf-8?B?QXpuSVMzcEpUUld1RlJlbFluNFF1NWI4akpENFo5RW8yN2lLRFRlbWtPM3pQ?=
 =?utf-8?B?NkN1OWowOUprN2pMY0prWklXRGFNRW9KL1RXUnBZTHRDMUtIeUxmTnJVS2Vp?=
 =?utf-8?B?WmZ2Mk5hNlhMT1AwQXJ3bnBmdXhnOVF3dWRCcWQzOWR1OGZkSFViQ0JsZ1Y2?=
 =?utf-8?B?Y2NWYzVieTRKRHl5TzF4alRGTmdvdzRvNUNhQnViUlV0TFJ6Z3VHTmlTNTIw?=
 =?utf-8?B?ZFVtU3FJWXBhazgzdVFBb3orUUZDMjYvRW8xd0VxUEJIb213QTF5MldxbmhS?=
 =?utf-8?B?V1Mvdll2UllKQW5lUk1ROU12aWwvaUxoU1pGVitDdldwbi93SC9rZUhJTG9J?=
 =?utf-8?B?aDNQOTkwMmJ5bTdHLzRuWWg2WHMxeHVKQVFDd0lOczFFaHdNMzFRVXAzdWJQ?=
 =?utf-8?B?RUhITmxpS1lKa2d0RkR0cFRnMit4ZU5VQWh1bTQ2VDk5WWF6RldNUnFzclJT?=
 =?utf-8?B?NDZCNXkxUWZ5elI2SkRSZS90TWNnK0NteEJRVU5Mbnl3MW9sRkZNNGxNenpQ?=
 =?utf-8?B?d2lNcm5zcWlNU1ROYU1aWEpHRFdna01uL0hJWUNvZTRaQWlibGI2YkIrZ21Z?=
 =?utf-8?Q?TWac6ueGoLmvBGloct?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4e682c-84e7-4e0d-37de-08df1fd3cf73
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:51:09.1194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGBdaTZmaLaIyjwOycwJUghjtxHC5uRMpg/jRp4cN4sexwECi2+Svo7wpyvwbj4xCorN8PlRh2nelcAMuJPudw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9832
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

On 2026-10-01 09:54, Philip Yang wrote:
> FW remote TLB shootdown support is ready now. Remove the early-return stub
> so the command is actually sent to the peer GPU.
>
> This requires nHT firmware version >= 1.2.E.1 (IFWI >= BRP0660).
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

The series is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 1cbf1b5e1631..3b3339c5be08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -6072,9 +6072,8 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
>   	struct amdgpu_ualink_ring *ring;
>   	int r;
>   
> -	dev_dbg(adev->dev, "skip remote shootdown to remote_accel_id %u\n",
> +	dev_dbg(adev->dev, "send remote shootdown to remote_accel_id %u\n",
>   		remote_accel_id);
> -	return 0;
>   
>   	peer = &remote->peer[remote_accel_id];
>   	ring = &peer->shootdown;
