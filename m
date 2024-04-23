Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33574C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 03:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9C9112FD7;
	Tue, 23 Apr 2024 03:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iYKuSIrb";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE461112FD7
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 03:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wg+qJKqCn9G37SHJI/Yv2k01tKB+vNrLmGz9necdo48vT4KkAaJiRga0xvnYUm3MuQstUAEV/865nreu5kj09fQsQl5OAZHsIxC0yy9PnS9YjSSzMuUjY5u/Mw/OmdjzFaHhcYc3VgShkcavv86HhxLLjcBOEX9Zxmf7xHsbOugBCT9GzIGaGyY8dqG2DFZbxeeZ1S5VTwGKJHS/7n5q+PWPvonF5APAN29FmEZn4qYQgZZGPPLv39JCdObezAeYRnx5PPqKbmG42bWdueNhkA9CHMFxYvmPttvLexsD5nwcjb/J1VDIo6enz8pPNKEplb0xRN6Vylw1IsXPiMpX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8/qHARog3ykgG6U1h/8hwvvE+G2ivHJNxtH0P253SM=;
 b=NDr9D94v2fExWh46rHkUzvVXAYQPHMKSDicP/ocqiFcf2gZ4LtC6YVmPsEkI1IfpL0wBRv0mHoZDnXIfgWpS7Q4oB87/Y8PWxzsysYNwdVQLYx3AOoKX+hQZE/DtTzKQMim+8JHv95688mthKtJ5dbxR7LfDysl+jv7omeo0JY8480VKR4dtTOtADJZUw1eJG5FPl+6R00bQ3K2rAC4xD11kgF/i0wnkI49gmVe+8OSbCULH5X0xiieltkAwRKCR0SS+9t9c75RrKFSqBixx26AyRA/N2WfxJgSnnMUQMMB6GrlxPy9Wq5wBNPSi3UG7Z/eJycTGfSjyBXcNnabuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8/qHARog3ykgG6U1h/8hwvvE+G2ivHJNxtH0P253SM=;
 b=iYKuSIrbYAGmzbBkv+eDWCtyKjm3OWoaLMnLaU/8IAnY6/MvuNeobKbFSVs8YD5WtmI+AzyrpBnAqh+zuUA4n7AFADnDphaKib2diWXDtlJFdt6+pSrkAJcFEak4Fnhhjtj3Fzt3S1WzjRExtRDkAJ64sATPV+Fgn+n5qQJ0XDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 03:06:11 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 03:06:10 +0000
Message-ID: <f9eb9cc2-4e95-4bf9-b2db-a459eca10686@amd.com>
Date: Tue, 23 Apr 2024 08:36:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix two reset triggered in a row
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20240422194550.26148-1-Yunxiang.Li@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240422194550.26148-1-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::35) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 6269cdbc-baff-4aed-1ade-08dc634253cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDhtU1dLbktNcHhsbEY1NkdtVG1ITGwvUC8yWmFRa2paOFB5M243OEpLaTA1?=
 =?utf-8?B?aFZQblpCSWh0ci9DRG10OURUdFRHYkRBTlRLMUpMRXpVTEhRSzYxeHNhWXA2?=
 =?utf-8?B?UC9DbHBFM3RRa05GZXkxeW1va0N2WkxSbzVTTkhvWmJyS2dONFdxdlBDUkVq?=
 =?utf-8?B?akhtWlJkRTFRNGFWNVdzblprbDZWclJCWlZQK3NyNjB1T0NBbFhDK2QyUTdM?=
 =?utf-8?B?WmF1NzJ6WHlWWkNKTUlFL0QzS3l0YnJQbXM0ZTJtL2hmVGx3R3AxUlc2OWZQ?=
 =?utf-8?B?ajZQOEpZQnBFT09FemtDUFpXMWRoa0ZsS1FRUEI2amRPNDFkaUdsb3dTbWU0?=
 =?utf-8?B?dHVXbGcyRTNpVFJkYWtUblNQZ1lGVlRkd0l4eDJMRE9jNVY4dnR4Zi95Uk5L?=
 =?utf-8?B?bVZQSlN3WmlBUDdEczJXdVNlaGovZU1BVjZHUFpGRFBXZGptM3d6NlgzK25x?=
 =?utf-8?B?SDVhZU5ydHNScjVaUk1jQ0NLRXVlNS8vdG9waGM0Q3NJRGUvM3BMa0hjMU40?=
 =?utf-8?B?VDY3d1k0U2MzbFg2ZjgvenI5bnBUNk9xODlTbUY1Rmk2TXpQcEpaVzVNYWN5?=
 =?utf-8?B?QmdLQkt4UkllaC9OWTIrUHZpNFVBMkxhR2M0U3N0SlJoVXUxcFlLSDZHNWxV?=
 =?utf-8?B?SGJPK3k4VVl4cVpEM2NEN3ZuTHFPWW1MTDBiWkpicjZHYUI3V0wvV0s2MWNN?=
 =?utf-8?B?aHZ5QytDaElRN0dmWVlyTC9QVHpDQUFQS0RnNGRJRlN1QnZyTkpVbk9LQjli?=
 =?utf-8?B?djZla0VYbTZLZVlEQWt4YlJUdFl0ZElnZ2RsYURoWllvZ003UFg0eUtpL1BM?=
 =?utf-8?B?M05tQml6M1Q4Z2ZmaitIQlJsV0lxV2lLbHlNM2FLKzNzV0VDTUNRUlFCNHQw?=
 =?utf-8?B?SEpOYjdxL1l0bEFjdFh4dWhJdjJIb0M0S0p3ZGd1b3VBdE5CcUpjMjRMR0ty?=
 =?utf-8?B?dWJxcWhqS3cyaG5PSGxidHRBQlZGQllHbnlvT3QzYURCWG1lZUJ2Ni9VZkJ1?=
 =?utf-8?B?MWw3cE0rVHMxQmN5bjIwN1MvL3d6UHo1Sk4waDJobnIveTVwTitlMU9aaTRU?=
 =?utf-8?B?YXZvdmZrYmduNTNDcVFLaWFIR2JSb0Q1NENhbThpTURyRk1yNVY0L3pTcWlM?=
 =?utf-8?B?eEdYbmd4UGdCY2kvdXRFT1gzWFdqbGM3LzBuV0crbjlSTytrMEpsZTdWeVpH?=
 =?utf-8?B?d1ZZRGNkL3BSQW5GcHE3TTlwai83M3ZFZGxrZ1pJbmM0ajRiRFV4ZHdic2lP?=
 =?utf-8?B?ZEdBdU1GdU1VejU3ZzF5UCt6eGxQSU9YR1N3WmVXU0xZem5IMndzZG5nM3pF?=
 =?utf-8?B?T29TTkhXeTMxN2dpaWpqRE4vZ21scis2NE80OC9kSFUxdkNrK3p2cE52QWtl?=
 =?utf-8?B?ZFJxUzd1SlVBNzJYSjZMOWdobmdZZmI4eGRmcUR1N3czMngvTVZlb3dESDV6?=
 =?utf-8?B?aXNnN0ZOYy93am1manArbGN5MDh0aDdSeFRLQTlzOXI1NmRxalltcTdLa1lt?=
 =?utf-8?B?cElHdW9hRU9lTFhoelZDK2ZQbHFWaGdJeXY0d2YvRFk0RUZUeXJVSTg0bnJK?=
 =?utf-8?B?RjJGSVpJK3pWT0kxUFNMN1BTNmU5YmdDeEg3U1FkWTNKSnhZdUlWZU40bXhV?=
 =?utf-8?B?eW9NeldENjZqTUFwOTVSSFJSNmFVREhwMmtsYjk2MHRKc01lQ0FaUXhNbFFj?=
 =?utf-8?B?TWg3Tys0K3lWV1ViRlBSdjJTSldYY0ZuMFBOSDdFRnY2aG5ybzNzUWtRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG1QQVNzZ2N5cHFYVE9KUGpYcEZLbng0Qm1hUHdUU1doL0xrL21pK2tGbzNa?=
 =?utf-8?B?TG9UZWFlejQvZDRoeG50YTh2anFjYnY1WDVMdk9YMmVRMUFHbUVtNEwrdUxV?=
 =?utf-8?B?M0lmZnFyMGtCQ29ZR3BJQWhyMVFUc0VFcGJDK1c0eEVreVJ1OHY0WnowZ1NL?=
 =?utf-8?B?SWxHWU5DY2hzb2k1N0cwUlpTdW81RlBHOEp5dWVmdmx1R3kxQzRLY3M0VkJY?=
 =?utf-8?B?RWVocFlHNmk5eTRXQkxzcTJHOFdTcExWbFBobjRtcGd6YmhuU3ZadnRIM2xL?=
 =?utf-8?B?VFd6aDcxK3huRWpYWkhYa0d1VFZ1Q3NBS3daOWFCd3JmY1ZPQVB4Z2RYWFRL?=
 =?utf-8?B?ZTdaVUZuNHA5ZytXSmNtcGFwYXhhTnRTdUM4UW03QkVXM0lWYW5ZTmtaK1JY?=
 =?utf-8?B?WUNjNzAzNzEvQ1k3REFpNzJTcVpRQXV5c0l4OUVnNkNhdWxXTzhrdGpWU3ZL?=
 =?utf-8?B?TmN1UmkzT0plT0RpUVdPV2tadW1WMzdQRkVaMFRITHBSV3QyUWpVYVZHL3h5?=
 =?utf-8?B?TDI3Y0FrWXY0WDdhQm1SY2Q1cnVlV1BBei9sc2hIV0dNNEhMa2RmSEpjTTJP?=
 =?utf-8?B?RmgvVlBXQU5yUUx5b0ViZkZvMDRlVFk5RW5LMTJmWldGTlpkWE1CN25wR2pl?=
 =?utf-8?B?c1F3a2dxUGRSZWlkei9STU8rSEpzNml4VllQUGkyZkZ3RHoyQkRaT093bGtL?=
 =?utf-8?B?RmpYbjNMRkZlVjBWdEFBdmR4SFlZekVNNXFoWExuVnpzd2lNUU11VjliMlk4?=
 =?utf-8?B?RlY0cU9pZm1kbmFwY1JHd05XbnprckpyNzVEMU83SlVJMkI5ZktvTzdIa09w?=
 =?utf-8?B?enZneFdGRXNuSHdXT1FVckNOMHhxZklMdjJEWVlkWU5iTDRZc0l6NGV4eWFU?=
 =?utf-8?B?bXRMNTVWME40RStDNzNsL3F2bmRiVWpIWnpPQUJ5L0MrYStPdnVxdk5VbmFh?=
 =?utf-8?B?bWxBWDNyZmVDd25mNEtEdjI3aURkMGN1YmdjRCs5Z1lHZ2o2NzJnbllEYjA0?=
 =?utf-8?B?a2xpcmlsMkY0bUdISzBMYXd4dUMyazRQb0RpdXNFdHpyMUNpSWhlVCtBT2xP?=
 =?utf-8?B?anQ4cStBRjJtV0Z0TWVLUFlwL25uRVZQTU1Hci9kWjZwLy9Ha1dWdWNSa0xG?=
 =?utf-8?B?TEpaSWJVOUVtZ2NUZG4xSjBDa3lFaVlDbjNjbUVSZzhNdGkrMVhZbHBmR2o5?=
 =?utf-8?B?LzAyTGJKQ0ZjTGc5d01jSzJuWXBPQkkrMFdSSjVOcjN0a3l6eXlCMGZVandk?=
 =?utf-8?B?cDF2Rk1hdkc1RitLM1U5ejJid1RNUkNjbzVKNi92bEE3a21US1RhaFYvT3RK?=
 =?utf-8?B?YXVDVHJoWS9sQ210T3FVVXNQREJjSUhZQmlHTks5aGRWdnA0TUFodUF2b2ZP?=
 =?utf-8?B?aHdOelhxTjFiT0tOL2xtR1lCR2NCOUs5ck5lc1hKUUVTai92VHl6cUdqQVRP?=
 =?utf-8?B?WllGUXFXMW16UThjRVlOK0Ftc1ptSXhUdXdzLzZWaHEzVndqM0hzQ1hCVUNm?=
 =?utf-8?B?Z2xleklNeWdyMFFuakhVdjFlWGxGVWxEWTRhWGhwL3NOUWtCQ1ZxSEdsZjl3?=
 =?utf-8?B?bnVHbGh2djJlNlM1UHhNR3ZqRUtMU0orQVZWNzg5Z2kwSXE2R1BueWZVTnJw?=
 =?utf-8?B?K1B3eWFrSEpaR3VURVFaTkdyaG1KZGNub1NhRHM2dENLNnlnNVNlbk0vdDNq?=
 =?utf-8?B?aWNUZThvL2RFSGhtMFgvQnIxM0U5UzlZNzJMQlFUR0RqcWk1OGw4dUNDcVJO?=
 =?utf-8?B?TDhGN2VDMWI4QUQ0R1ZPb3Zjd25sTzRkUnk1WFF3SG1PZCtScEUxNTBmSXFZ?=
 =?utf-8?B?aCtwOVZyK0ozaFhpN0JkR2s1dnpPN0hlUFdZbzhqeTRhSXcrTmpVUHJWQ0lz?=
 =?utf-8?B?RXo1QWJ5L1FaR1kwRU85N2hmRFlVai9KMVl5c0pueFo5NE9yWmUrZ0xjUnFD?=
 =?utf-8?B?Nk5QbW1qT3poRVVEQ1M0S00vb2ZzQTZVMDUrREdyb1BxbCtSYWlJL2p4cFJL?=
 =?utf-8?B?U2FQYzRLelowSTk2eFVac1RNbENHb3NmN09DYktnWHJxUTQ3dTBLTVQ5MXhU?=
 =?utf-8?B?NGUxY1VRcURja0pXaWIvaEtvYUY4dnNRQkcvbFNsVmpaK1Ywcm02VFMwZ2Qw?=
 =?utf-8?Q?HZCp+Qe3AgRRxAHDgpkriErFs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6269cdbc-baff-4aed-1ade-08dc634253cf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 03:06:10.8478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFYZReL7rzDzJqHVBUxCeq3EWHiTup4ZaczmnTPFVWLcLtZf1DB5hZeZorq/Ii7u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824
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



On 4/23/2024 1:15 AM, Yunxiang Li wrote:
> Reset request from KFD is missing a check for if a reset is already in
> progress, this causes a second reset to be triggered right after the
> previous one finishes. Add the check to align with the other reset sources.
> 
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 3b4591f554f1..ce3dbb1cc2da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -283,7 +283,7 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
>  
>  void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>  {
> -	if (amdgpu_device_should_recover_gpu(adev))
> +	if (amdgpu_device_should_recover_gpu(adev) && !amdgpu_in_reset(adev))
>  		amdgpu_reset_domain_schedule(adev->reset_domain,
>  					     &adev->kfd.reset_work);

We can't do this technically as there are cases where we skip full
device reset (even then amdgpu_in_reset will return true). The better
thing to do is to move amdgpu_device_stop_pending_resets() later in
gpu_recover()- if a device has undergone full reset, then cancel all
pending resets. Presently it's happening earlier which could be why this
issue is seen.

Thanks,
Lijo

>  }
