Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1711DC4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 06:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9FA112827;
	Fri,  3 May 2024 06:31:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KNYt8llE";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 701EA112827
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 06:31:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8umSNLTEoOSmfIUuFgAMQZ3D7toaAHMlUj7BjzL/eHHsI0jd7OrY9RbylnBF3NB0xGHDmsoGwZd3e/smmJUqoTGUFYP0Vjf6f57dbyCt4Nt9VbewZ2y3uXsjLEcHVa+uPXRdrbm3EdgXms1xVuIZLnm/1P7v5SBdElDvDmTliKbyY6cdFnsAFbQJARtYDayRPzbaFeaxhAghbzjQ6E+x0YSyzmFrN08rsed5IFlwbsXAaB8LhMfY8RJudL1qtDFnCqUHfD9H9n2+yO/XWMnfsxA2FzOmdtCWlC5uJSKChgvdlejI4Yea696GYKZapWT+401+/g39ZZAco2rNM+QMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kxlkq4L1WylZ358a/XtGmRPYZkx7BwuMeJx26X78QZg=;
 b=IITs/YMCPHtuqiULDgDx6YjC3alDNKAq3ts+jFgPQ3wlf9VDapzvrr3IJZR/+7vW7fZLk9LCK9nDFp9E+jQiZaY2ipSxeplbtSVCLej+gbJmcT3S6F4/7sUfOgM9qDgprE7rdKqQKLbCCjAxU9PMaIqGn9hSh9cuLvXwSkKAbhptt1VAHruKf2g4V9A+x20JPiDfnbkMO5hXRnCaVCJymx5IDSpmuGEsrAxWEANZjGwoWxFMdeyOzM06kLb79sH38G6dkxAM7i0I5f57hFgq9H6UGVxP0JEESLp73edG24wKFBXOEc13Bclx1gERU6Fq7vlPTeiAwhkPmhHicyXGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kxlkq4L1WylZ358a/XtGmRPYZkx7BwuMeJx26X78QZg=;
 b=KNYt8llE8u6wcjPl5NYiic9nljmo8cpfzmOQjVLQjgimFNaOeKA6EsUdSZtUSzokyyZyTRU/2DSIw2xNnG1b3S08ZVJ8s1y1OnGvsG6jYb+1ib6gny0crN10xQIg5NykmrtW11g5bAdYeZlT3GuVvkrupUDd+TkZ+xGw2gvJGu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Fri, 3 May
 2024 06:31:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 06:31:32 +0000
Message-ID: <89f303d0-9d72-419f-b965-d9b5b86065cf@amd.com>
Date: Fri, 3 May 2024 08:31:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Reduce mem_type to domain double
 indirection
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20240429164707.49196-1-tursulin@igalia.com>
 <20240429164707.49196-2-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240429164707.49196-2-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0116.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b85bb9-97f8-4b85-1bec-08dc6b3aac2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDJMa1FRcFNMLzl4OWFCV2VZb1EzZHlPZjA4bUw1YUVQT0ZxVENXRjdQcTMr?=
 =?utf-8?B?WVh2RGdzRVVSa1FoZ0ZPRlpYMEljUmc3M01RYTVsWk12S2E3NWxNQWdvdTM3?=
 =?utf-8?B?dFNURWhpRW85aXFWL3JQanBJTStzZ1ZHZndqdTlDNkU3bnhGRmxaZDFtVWVm?=
 =?utf-8?B?VElmNVhwVmlNNmRhd2pnUnFNS3FlRnlabmp5cnlMMS9abGhKVG9ScVdJNTJZ?=
 =?utf-8?B?bU80SGI3cUFKRllKNWVMQ0krZXRXN1F2cmhHck1DbUpVai9LV3BacTNvUXFE?=
 =?utf-8?B?K1M1My83SWllRmhwTDhaV25zRit0NytVaCtlTmlRU1hDYTh4b2NKNXdXaVJq?=
 =?utf-8?B?QUhMMzJSMFJZbXdyVWxXcG56Ni9LN1RBZDhvRGplUnN2ZGlaMU9wZ2ZOS2Fq?=
 =?utf-8?B?R0NiTWlZa21ZMDFrUGMvUnU4emUySHdDSkpyZk5iL2JHTHJNZHBicUtYTlEv?=
 =?utf-8?B?Tm9uT21wT3ZXK3JDSTJ2TnVtckU4MlJNSlRuVnRIV3IzbllUcmVnY1JXUEFV?=
 =?utf-8?B?MDQvelZyY2ZGRENVRENlQUVTT2FVVXkxaENyaVc3Sk1oZTE5aVM3RUp5dFpD?=
 =?utf-8?B?U0tMMzQrSTc2YWhnYU9jWDVBZTc2TmphVVA3UHdzbVNPSFJrNWFuZVpyL1Ja?=
 =?utf-8?B?UEwyS1FNdC9EMFZuL0F5TFRMeWRuNTFTWHlzRGxiOEVZaUs3T00xYWJpOCsw?=
 =?utf-8?B?Z0xSbHdVSTVKMEZwb2JETWZzemhXbGJIWEpROHhRaTRIVDVVbUFRRTZCQXlX?=
 =?utf-8?B?UmEvZE1NK0VWS2k4T2dydklsU041L3A1VFRMZytBYmJYOWJ6L0pvODFyQmNn?=
 =?utf-8?B?dmR1b0p3SWNnMFdaaklna0lkV2kzaHliTnY5OURpNUNIZGtMWVdWa2NLVnNz?=
 =?utf-8?B?Ukc4d1FheE1KQ05UZGcxOTZmYkQ3bmtpR2x0RzhlRzBDQllWS0xMY3cxZ2c3?=
 =?utf-8?B?MElwRVViQkkxNi9GSVFlbE5ySTg3Qk5hZStJZThnL3hvQUNBUGdwVnJvVElL?=
 =?utf-8?B?dHY0citwMytQTjlQUFRaNFpYTmVNVWlqeUdHMU1jMkhoSnVQUStkeUY4K0o5?=
 =?utf-8?B?ZWJ0YTFnVzF3VWV4N2tSTlZEWTJzVzBCNjBVUExTeEVUS3hLZzJGTjhBOEFK?=
 =?utf-8?B?Y1kzU1BWMEZNYVFNbnJYTTUwS2hzVmpSZC9SSzJlWmhLTTBPRDZhS3JydXcw?=
 =?utf-8?B?dEJkSWJjQUNBRTYrV0I2YVlNaGZyVWhackdUeE9wY1FhYktKKzhIcFFHTjNL?=
 =?utf-8?B?NHMvQ0JBWHlsYUxxUUNqSGtCbjFLR2c5MHMvSlVnbzJDVlRjbWJLNVI2LzNZ?=
 =?utf-8?B?Q0hUaWR2bml6T1ZyL2ZrbFV4ZHlpTU9oZmlSYzJFc3ZvSUt2Nnl1RWdjd2ha?=
 =?utf-8?B?dlA1cmRBejFLd0NUWTNFcmxld05INis5Z2dER1hvV3VIYzFuY3gvQWQrVklS?=
 =?utf-8?B?VTZ3Tm9iWUZjQUZBY05SL0hZaHdROTFNTXBmcmc4NGNQbnNaS0JMNnZCQk1O?=
 =?utf-8?B?MSthZVNPRDlyckhXV3VtWGJ3YTAwZVZSanZTako3WEgyYzdITml6VE94N1VY?=
 =?utf-8?B?ZC9YRFR4aXU4RXlna0VrUERMR3BJMDU2bllRdWJ5bFd4QlRZYS9FUlUxZ2k5?=
 =?utf-8?B?cm90U0d4L0V1RGZPa2w2U3kzQnRTRE1pNkhzUHhiZ01SUDhqT2d3UTZ0aDJw?=
 =?utf-8?B?cnd6N0JZZVo3VTR5ZzBuU2ZvVWRmSzVZUkpFVExJWDFsZms2SlE0TVJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0U4Z1NVbEIxYzJ5dUt2N0dtN29KWHNCU3NvcDgvamdacTQ2b0sxQ0ZvWmtS?=
 =?utf-8?B?Um5NUE94QzRvOWd3MmpZSEp2NWl6N1hPS1RJNlFuRFd1TVZyaDNyUDB3MXJz?=
 =?utf-8?B?MXM0ZnFTUWVWamdxVzZCUzgyWXRLZzZ5N2tBYkpnUHV1YWliS0xYamZPWXRC?=
 =?utf-8?B?ZkVhSmNjbEFTenBYSGJlOHpLckkrL0NQMWtaZUUwcUEwSEQ3dzBTeXRNcGps?=
 =?utf-8?B?UTBXRUx4MWhXVnFTU2g1L09yVDJRYS9adGdKaU0xTUZocnRhazhuVHh5dTk0?=
 =?utf-8?B?djRMbG0rem9OL3NPMUJPRGhWK21EeTdmZmNBTmFwenVGUEJjZmpaamZqRk9T?=
 =?utf-8?B?Q04zN3I3cTMyeWE5ZWZsM1Axd2liYjFybVZHZnp0Z0daakVQTGJMdWdMRVgw?=
 =?utf-8?B?VHRsUnBOSElyaHZDTE5oNktWMlB4cmhpUGtrUXNjd0RHRFV4WFgwSjVnRnVG?=
 =?utf-8?B?dUNHdmE5MkErSVJxeXRrOWtaZm5uZFhlMEh0RjlvZVk5OFNGVnQ2d3pMbW1G?=
 =?utf-8?B?RVJsekRCWFFVa0VJQWgrc25mdGZ6MFJxclZRV043NU1jSEM2SVpjckk5b2N5?=
 =?utf-8?B?akZmS2lyTURVM0tseUYxTDZ3bExjcXk4QndzYUJJM3AwWW5VNFhzdUs1eU5t?=
 =?utf-8?B?WHJNNEVEd3U5UmQvOHdzUnVpNElKZG51ajYxOUFqZ09nNlFmSFVsMTBRUmh1?=
 =?utf-8?B?Y2JtSXk3RWJPVHZMV0szUnJFQVJoTE40Z3J3V3d5NEtYR3VERnFJSU02T0dn?=
 =?utf-8?B?UXI0ancxdTlkRHJKUmxUUmxaUzJYbjB1SDVDTFk3YTFkeWlDY2FWRlRhMVcz?=
 =?utf-8?B?TTFRaEc5QnNpNlFMRTBtamZObXZ0STBxaTBwWUJhdC9WS00zd3p6QkdBMmJa?=
 =?utf-8?B?bFVDdWdyTUFMc0tybjhESjB6SkJ1VnkyUlRDMzVQcUtocVBIWDNhSjVObUcy?=
 =?utf-8?B?bWViY000RnFQdlYzcncxMklRWCtReUpKTnFXaFYzbnVOaG01OENoUS9PcytS?=
 =?utf-8?B?elppbGFJNkRDbGZ4NlRBcW03ZGlrSjVNN2U5Tml1ZTZNOXozZFFJelViUHNk?=
 =?utf-8?B?Z2NucWFXRmNpRlBVaVRUc3pVUllqQUdhWmg2T2twUXh6R0hzWG9tOFZ3WlFN?=
 =?utf-8?B?amovRW5RQUN2ckR4bTBHcktHam5TVWF5aXVtOFNEQ2p3TWt3Y0Q2NjB1NStC?=
 =?utf-8?B?L3JjNWE2NUJkOFhVNjJWaDZGeXBsekNWbXQ5c2w3NEx1VWdxOFRWazlhcmxm?=
 =?utf-8?B?d3d4ZDEvaDJZUzcrTkdnNTFZT3I5RFY5VW9RL1E0OU5BZDMxWDBxOWFlcTNM?=
 =?utf-8?B?SGZIZVVIMENCUk5ITnBUSldjTjAyeW85aUdmRkN5U2M2RXZHTFE0dEFMNUtU?=
 =?utf-8?B?MTQ1KzNQVDkzMkN6T2I2UjBycW9FUE14QWNVMFE5QWFkcExpRDMyY0VNajls?=
 =?utf-8?B?Y21wTTlKNHlud3JlK1h2NE9oNmJiM0JTNVY3YVg0c21LNGljT0dqOFdxcDQy?=
 =?utf-8?B?MDZCeGwxeVAwN0FYNWFGWTdNaCtLNkZSL2Fucjg2L0tHZ0FsS1ZndkRldjlQ?=
 =?utf-8?B?UzJDc1V0V1BEaW9sKzBNaVFFQXMvcm5Ld3djTGtkald6L3JWZENQNGZyQTB2?=
 =?utf-8?B?RFllZnZpMFduUlhMK3VwSS9oYzZBQ29lT2ZjYkVEMnVhSTFSTVVsRCtiTGty?=
 =?utf-8?B?WVM5N3c1cEIwTnFSd29zdVY5K1duNDhHejNxUEtNeDBPenYxSkRZVG9VTVZ2?=
 =?utf-8?B?SG15Nm5DQUorc0ZRM0FORjNHQitkK1ZlRnN0TEJwSTZRQmtCbTVhN3ZONDRa?=
 =?utf-8?B?RjVVQmsyUTFZem0xLzl5TmNzKy9BLzNTcWpjSDRta2FVZGMvMmFBZllFWlN6?=
 =?utf-8?B?Q0Jvb2tLS0x5bzdLWkZKbXVHaXZlZzJFeU9XSG1hSFlsR1B1eEJBL0drVjJo?=
 =?utf-8?B?Sm1Vb0FoM2VYWDc5UGNBTUhkTUpkUWVXNFRldjF5bDE2UzJpK0RSYm9uYk1Q?=
 =?utf-8?B?aHE1anFmMFRKZ2EyU1pUV2p4TzJwbWxQZkY5TjM3WnJ5ZHFpak5lZy9FYjM5?=
 =?utf-8?B?ZFBiQkkxRFFpMis5UUJIU0s2UHZFYmNRTVlmWktqZ1pEMGpnZEJJc1Z5QTE3?=
 =?utf-8?Q?lXSDfWQA7IzFMASa4V5ckTTWG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b85bb9-97f8-4b85-1bec-08dc6b3aac2d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 06:31:32.2353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtmzqPjpGemL9BKrT9utBsXGDkGQPLTPYe5c+8jTUCjP1UcPe2yO6TJKnUQ8RK2K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
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

Am 29.04.24 um 18:47 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> All apart from AMDGPU_GEM_DOMAIN_GTT memory domains map 1:1 to TTM
> placements. And the former be either AMDGPU_PL_PREEMPT or TTM_PL_TT,
> depending on AMDGPU_GEM_CREATE_PREEMPTIBLE.
>
> Simplify a few places in the code which convert the TTM placement into
> a domain by checking against the current placement directly.
>
> In the conversion AMDGPU_PL_PREEMPT either does not have to be handled
> because amdgpu_mem_type_to_domain() cannot return that value anyway.
>
> v2:
>   * Remove AMDGPU_PL_PREEMPT handling.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Reviewed-by: Christian König <christian.koenig@amd.com> # v1
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  3 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 27 +++++++++------------
>   2 files changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 055ba2ea4c12..0b3b10d21952 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -165,8 +165,7 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>   		if (r)
>   			return ERR_PTR(r);
>   
> -	} else if (!(amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type) &
> -		     AMDGPU_GEM_DOMAIN_GTT)) {
> +	} else if (bo->tbo.resource->mem_type != TTM_PL_TT) {
>   		return ERR_PTR(-EBUSY);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 8bc79924d171..eb5bd6962560 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -976,12 +976,11 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   
>   	ttm_bo_pin(&bo->tbo);
>   
> -	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> -	if (domain == AMDGPU_GEM_DOMAIN_VRAM) {
> +	if (bo->tbo.resource->mem_type == TTM_PL_VRAM) {
>   		atomic64_add(amdgpu_bo_size(bo), &adev->vram_pin_size);
>   		atomic64_add(amdgpu_vram_mgr_bo_visible_size(bo),
>   			     &adev->visible_pin_size);
> -	} else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
> +	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>   		atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
>   	}
>   
> @@ -1280,7 +1279,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   {
>   	uint64_t size = amdgpu_bo_size(bo);
>   	struct drm_gem_object *obj;
> -	unsigned int domain;
>   	bool shared;
>   
>   	/* Abort if the BO doesn't currently have a backing store */
> @@ -1290,21 +1288,20 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   	obj = &bo->tbo.base;
>   	shared = drm_gem_object_is_shared_for_memory_stats(obj);
>   
> -	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> -	switch (domain) {
> -	case AMDGPU_GEM_DOMAIN_VRAM:
> +	switch (bo->tbo.resource->mem_type) {
> +	case TTM_PL_VRAM:
>   		stats->vram += size;
>   		if (amdgpu_bo_in_cpu_visible_vram(bo))
>   			stats->visible_vram += size;
>   		if (shared)
>   			stats->vram_shared += size;
>   		break;
> -	case AMDGPU_GEM_DOMAIN_GTT:
> +	case TTM_PL_TT:
>   		stats->gtt += size;
>   		if (shared)
>   			stats->gtt_shared += size;
>   		break;
> -	case AMDGPU_GEM_DOMAIN_CPU:
> +	case TTM_PL_SYSTEM:
>   	default:
>   		stats->cpu += size;
>   		if (shared)
> @@ -1317,7 +1314,7 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>   			stats->requested_visible_vram += size;
>   
> -		if (domain != AMDGPU_GEM_DOMAIN_VRAM) {
> +		if (bo->tbo.resource->mem_type != TTM_PL_VRAM) {
>   			stats->evicted_vram += size;
>   			if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>   				stats->evicted_visible_vram += size;
> @@ -1592,19 +1589,17 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>   	u64 size;
>   
>   	if (dma_resv_trylock(bo->tbo.base.resv)) {
> -		unsigned int domain;
> -		domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> -		switch (domain) {
> -		case AMDGPU_GEM_DOMAIN_VRAM:
> +		switch (bo->tbo.resource->mem_type) {
> +		case TTM_PL_VRAM:
>   			if (amdgpu_bo_in_cpu_visible_vram(bo))
>   				placement = "VRAM VISIBLE";
>   			else
>   				placement = "VRAM";
>   			break;
> -		case AMDGPU_GEM_DOMAIN_GTT:
> +		case TTM_PL_TT:
>   			placement = "GTT";
>   			break;
> -		case AMDGPU_GEM_DOMAIN_CPU:
> +		case TTM_PL_SYSTEM:

I would still prefer a AMDGPU_PL_PREEMPT here to be able to distinct those.

On the other hand OA, GWS and GDS placements are missing as well. So 
that switch should probably be fixed.

Either way the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com> for now since it doesn't change the handling 
at all.

Regards,
Christian.

>   		default:
>   			placement = "CPU";
>   			break;

