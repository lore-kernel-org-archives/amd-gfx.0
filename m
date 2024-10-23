Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFF8CDDE64
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 10:55:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8088A10E27C;
	Wed, 23 Oct 2024 10:55:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ehtk26iq";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2D4710E27C
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 10:55:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOVjK22PPOu1iEnUIYSJYr+MPNDSstg4gAJsyIq4mKwV3uKJhgkPP/kwRu3sx7fmsyPTthoJu4I8/JB/GQQhWGWMKLyH1fn4+QYKkxQRJQsVjxr+pYgAlRSdx3aYTJJRiG3We566mO0aVSBDSyoU05l2em5F0R7d4VtdBhN1PHWLdXnqg3hUUp/Nasm6rRFAImbjc6uosVVqY7SRyVcr8ngAWY5u153ZUwOzUppeK91ZRehTj6BeC9TFBtKxMjjPaKkYP+g0aksNUI4u+ElzuQABW5nq8A3lqZG+dl3IWKgOfCCjRXP6YXbY3fy1726vTymde+fj4CHf190LjTmY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yl+FR+iAHwt5Cr9NuU/b0ExHZcWfGGHU/8iX8x5Y/cQ=;
 b=bfAqw9MN7OvT1uVqif3Y/fdBn7cF/A2Bty5sp5no4BG69t6j8BYPlLpQib/ko6bm8UcY/ybEo+f2fdAUItO187ZoZq7RffI0vl2RnY8UBQkHQ4weumHW9EBfdFWLrhs87CBASQEYSV/WjboZbNOPbc4/u8uggksm1eZOYsuOARwdLIkV4vq0n4F+E0m+syDcwH+jlal6Lxhd2cSoNjsKGApJ/LGZIP5t0yN2PS7bP5lXMHX+NYtr4HOIlLNvpF9doX9CSniihXmGRBDVuHECWvRxJimOlves3+MWlKfKnvCur0q0iIEyqkKlwzxYweodgtSmx81oJrROzXgteZ2kRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yl+FR+iAHwt5Cr9NuU/b0ExHZcWfGGHU/8iX8x5Y/cQ=;
 b=Ehtk26iqrZpO17NYRdLTqc/2qGIY7sBJnrnqVxpNVkv/3Ar4ovaSIcJaqP6jIetkEsjdkrx1R8D2s2H+5NSgqaK06dBm48BVjlezPWHStGB1N0QI2ivgAF9tAyXARd1sq7LbqBg/G2YYhGiAaFeGYpjkWwdBZD3nEpYilSrsgII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BL3PR12MB6521.namprd12.prod.outlook.com (2603:10b6:208:3bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 10:55:36 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 10:55:36 +0000
Message-ID: <8ea96dd2-260c-4fd6-a78b-4d491cd0338c@amd.com>
Date: Wed, 23 Oct 2024 16:25:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: clean up the suspend_complete
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20241014074902.1837757-1-Prike.Liang@amd.com>
 <20241014074902.1837757-2-Prike.Liang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241014074902.1837757-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BL3PR12MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: 16eb2238-a514-4f5d-71e0-08dcf351394d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGxiMlJ5RlJLVFlqNGMycTBXMFk5NEg3b1VmVE1hOFFpUG9UKzgrZE8zNGcx?=
 =?utf-8?B?MGJpNE5pRkZNR0dGVWRnMHZhSDRCdDk2OWsxRk9JY3p0azlFd1RPaGlNeDBv?=
 =?utf-8?B?MVU3TlJSMEdSZWNYS09tMEFydkl3dHAvZDdqZjZQc2FKYWYyOTc4YWpBUDZU?=
 =?utf-8?B?YVRReENONzhDMjhkRHM1ZFpITnY1S21POHp1NDJvaTNZVVZwRW1UREl0eThN?=
 =?utf-8?B?MS9Nb05JOTMxc0VWTGp4NVY2NFpXZDlBM3lwbHZIUWpIcDA5VTloVk50Nkp2?=
 =?utf-8?B?SkoxOGI5RFJtRG1oOUpEaXNCa1VwT2RTQVhRYlAwMGJSSzJLRTBNSHljN2F2?=
 =?utf-8?B?WXJ4OG1mTU1haVdqL2NpamN2V2pqTGtvRUtHVDhMeUhGTGZHOVFZOHJjR3VS?=
 =?utf-8?B?cEJYWFZNZzNmNFk4OE9JanhlYWlxbUgralpDeGN5SmRxdWR5QmxYMFp1K0Fh?=
 =?utf-8?B?ZUs5THJJdkNZZ1ZPUXpUbnNOWmoxS3BpUHFGaXdBL0loYVR2Wkh5NHh0S01W?=
 =?utf-8?B?dWlDcWFxeWJJTXZZZ0pHYjUyRlV0cStYYlJjMFB5VFRhN3Uydkk4RXY1WVVt?=
 =?utf-8?B?SjdVa2ZrazRmdVYzc3dvaS9xRmFqNERwUk0wOWtTeUg5MWgrK3NzZXBWRHZh?=
 =?utf-8?B?R0Q4c3Q2cEp0cTdBSmVub09MaDMwLzRCMURMdmtBMU9xVnhqQXVzVkdPdUdH?=
 =?utf-8?B?elNydnlyLzZVd0ZCSUxxTVY5VGx4TzhlVUJWRDdpSmRvSGxtaFQydFlBZFd6?=
 =?utf-8?B?SFAzODJML0VpdndFN2tnMzZCYjgzbWF1b2dtb2pONGxGMU1sSnFqSlcyZ1Nr?=
 =?utf-8?B?Vm1WS3Q3Nld6a1BZbVlJL1Q3Q2EzR3U2VVZnR1o1SDBvQy9UWU1XSzNHY0xP?=
 =?utf-8?B?bjlNaXBGNDRCbjJHQ1JtVHVGQVdsTTlVUUtpQkxXa2NxRzZRU0VQblVYSmxl?=
 =?utf-8?B?YjkxQzViMXNnRm9wTDlLS25FRi8yM2J2cWxOeFZUbzhMZjVXRmpvazluZ3Z0?=
 =?utf-8?B?aU5WY2ZGYWxRb2hqNi8rQ3NaM3ZVZ1lOd1EwZENjQTZkbnVFdUc2YlIwaEh6?=
 =?utf-8?B?NC9qbHVSMWpzSm1xaldXVmxZVnk1cG1XcFZsZzMxZFBHdjJLbDNsbmFvcUhx?=
 =?utf-8?B?SkYyT2YxcUpxRXNMYUZoQ1pUNU1sUjdGaVhMVXQ2WDE2dE9kZkdxeGpZSytP?=
 =?utf-8?B?WUhsZ1ZTSjJ5TjdWMFJVK3BQSEVVazMzQnl5ZXIyYSsyODJRZEEzaDFTSW5p?=
 =?utf-8?B?MzRuTHgvMWJ0dnZJY0ZDNlg0Yml3MTFieVN5RnowRlZFeTZlR3pnSWxsUXpl?=
 =?utf-8?B?YmZhZzBBWHFpQVF4dlk1OFZFb2Nma0Z4YkJxNEEwN05SWVRNaXduUlpjd3l1?=
 =?utf-8?B?RHJib0F2cUM5YjVBTng1bzliMmFzcU5QdjgrS3h1V1I1cURFWHpDdkNBS3Zt?=
 =?utf-8?B?Y2tYZWNlUm5zb0hsWkpqb3dSQWRUSHBET3JmSTlMbzU4L1dtcDdEaURaUS9p?=
 =?utf-8?B?eXMyZXpZYmYwakdMMTlPV3pJOHY5UVpORWFyUVhjM1IzbUJYUEZ6UlhBcnFl?=
 =?utf-8?B?d3RLTkZ3TElyTnBubHdHc0NFLzRWT3RNaEZiN0pMY0Evc0x0VXJXSEFEdHRx?=
 =?utf-8?B?UlE3RmtXclJ1dkFPamRDL1FONUxnYnVtOVhIUEJST2xRbmFwa1hla040TVA2?=
 =?utf-8?B?M3dsOU1PRW9yWFRnUXFXOUFQeEx4VldBYzdKem00b3c3WngrNGlRN2ZiZktJ?=
 =?utf-8?Q?kfUX6T5Ud1H9ITUiVDDQp3h6JhPD4Ll3VkGZLhG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NndyRmNVeDNLT2xxUlpKU3JRVnZhV3RJTHZ0Y3NYOHhXTTFhZnh6NXJ0U0xR?=
 =?utf-8?B?a0xRQlVwSGlxMms2WngyWGpQTmRwZHBnYmNGTmtJeWlxcHJ4VUx3YTRFNTR3?=
 =?utf-8?B?VTJ2QkU0MU9PQVBkaGpMZW1tblhIMHZ4MkVab3NWYUF4MHlwUXRsNGxIZjM1?=
 =?utf-8?B?RWxCc1ZOK2NpZ1N1aTJqWUY5eXBzTTMvbU1kaGp0dk1GU29qUzZTK24wM05F?=
 =?utf-8?B?QzBtMTNCeDIvUHpUbDlwQTRSN0REU0FkVCtRTzJnd0V0RCtLdmlVV2JNYXhV?=
 =?utf-8?B?SUk4ZVFiM3BEQzZNLzBINHprcWkxZXhWZjhFV2F1UGRXVCtqWEFGTzBhMGNW?=
 =?utf-8?B?bS9xdnE5d21UVHNyZ01nY0w1cEFGTmdPejBGQmEzaS9xOFcyNHVkNzl2UWFT?=
 =?utf-8?B?SmtKdWU5c2NRbFFsK280Z0k5dndpMUJxcW9XcTZaalJkVlZ3U1FsS2ppZ2tM?=
 =?utf-8?B?ejJtZjNuSkh6UFljMWFzUHUyVzd4QUZXTTlwVndTVDM5OHVjVkowcEZOYWQ2?=
 =?utf-8?B?UTdLYWJzdEJjU3Bwc0ZuS2tYSUQrWWU3VjFScjd0WGpMS3N4c1duaEgyZXJw?=
 =?utf-8?B?eXJCOWNQakFUMWh2WXZrZUFmWHJ6NWdiM2ZIUFJsbGp3bkFxL0tyVHBUUGJy?=
 =?utf-8?B?TEtCWElZb3VmK2dJdEtxNmY2V1VxTDFFOFJSRi9yRFZOVCtwRnlwL0g4RmVE?=
 =?utf-8?B?eWJFM3pwRXhRSGJQVU5CUmwxOU1wbmM5Y0hTeXZQMFl2U3FybENjN0RUY01H?=
 =?utf-8?B?U0xWRjRpNWV6dlBWc20vVDUrRTRtOWJPdTg3bDdjaXZvMzRNVFh0V1NYdlI0?=
 =?utf-8?B?TFlJS1JvdmVZNVY0WUtVM3VyZVZsM0x0dGdEL0l5ejMzajkzemdQTHVuNDlz?=
 =?utf-8?B?RTNrR0phKzhSc2t1QXc5ZStDanhMLzIwTXIzalRzWG9lSlRRc2xFd2lUK1Fr?=
 =?utf-8?B?N09QWEVWdXNpeFcwNUdaMTZ5Ny9OMDh2ZXNaQUNwTWx6ZW1PRCt5bDhlcm9I?=
 =?utf-8?B?aUxFQTFuNC81L0NHN2JSampHcXAzSnhQMHVYWHFxY1N5RWRvNlZnQXhSaVJ3?=
 =?utf-8?B?QWZiR3VMdEdPd29KMy84K1JwVkRSdjBtSXZRcnlodHh3aEI3RVQ3eGQ2cHBn?=
 =?utf-8?B?VjlGS2dKc1E1cUZmbDVJY0NDTjBzMG5JZWFWU3VUZThhdXlkd1p0dFREMzR2?=
 =?utf-8?B?c29xRnppdElZUyt3VkhvTW56Y3dvYTU4R0NDK0ZHV01CRkJManFvSzVsY0dQ?=
 =?utf-8?B?VktVNVpUY1BScEx0R2Vzam5TeWFseHpjOW1uUTlQVnF6S2o2Rjh2TnptMlFz?=
 =?utf-8?B?d1BMZjJHWGdmOVR5TU96eCszZjk1N25KWUVOQWxNZXk3eEUwVytFVXRpM3lI?=
 =?utf-8?B?YllNb2hqa1JhcDlNZlZBalpCZnNvOUdqcGNnUU42cnJpbHdQZVZmTUJPTHhP?=
 =?utf-8?B?TFArNHppYnJDOXZGMGVGbHRobDBGZkVUQzJyVXRmTDgzd1VLQlpTa2xJL2dk?=
 =?utf-8?B?bVIyZGhMRy9nd3Fqd1psZjdqTjhMbkdUV0VvUU54dzMyL0tmenRsZDFkM2Rt?=
 =?utf-8?B?Z1NTTWluWTg5ZUdQK1ZNY2FWNzlsdElOeW1IaFM1NVZJb0JQRHZ0Yk5zNWo2?=
 =?utf-8?B?UWFBZHkyM3A2akszRmx5YndUS3FRVzE5aTMvQ1h4L2MydkhFOVNRdFhkR0dO?=
 =?utf-8?B?NmhrY3owWkFKUHZBRjc1bXN6eFVCdlZTamQxclJ5R3NSWXV1VXdjdFNraCtV?=
 =?utf-8?B?cmIwU1Q0bE1uQ01iQ3lnakNhNXRQVklnZ3psYTlKOFZ0RXExMEExOTJRNDU3?=
 =?utf-8?B?TGJ0cGlWY0R0VW4zU3p4d3dRbzhPS1NlcnhJVndMMDVQOUdwOTFBdVIwRmF1?=
 =?utf-8?B?R0tkVmFoZms2YzgyS00vYU9ZU0c4aFh0bTVCOHZJNC9mR2prLzZNR3YvdHBt?=
 =?utf-8?B?TVJ1L01PRjZpYzR3dmxQcTY5YWhCcWtXak9mbmJoOWRubzQ0WDYyV21XSVg2?=
 =?utf-8?B?UUxFS0dxRWIxZWY1Y0plTzNhVC8xZWJXcUxIcE5GckpGRExUOVNQZ2wwYmls?=
 =?utf-8?B?YXlabmEyVk1KK3dRV1Z5cmloSVhLSkJ5QmtoK0RHckZOc3lOd3VYOWplZksv?=
 =?utf-8?Q?lAvq3BY6haqguZFOA3a4Ias8s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16eb2238-a514-4f5d-71e0-08dcf351394d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:55:36.2914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dB3TFzc0dI5JfNIGLOcc8Xc6QKbJS0b7mgPqX/5mcRDvvqXkwyOpPNnzEuWdeqn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6521
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



On 10/14/2024 1:19 PM, Prike Liang wrote:
> To check the status of S3 suspend completion,
> use the PM core pm_suspend_global_flags bit(1)
> to detect S3 abort events. Therefore, clean up
> the AMDGPU driver's private flag suspend_complete.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 --
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/soc15.c      | 7 ++-----
>  drivers/gpu/drm/amd/amdgpu/soc21.c      | 2 +-
>  5 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 48c9b9b06905..9b35763ae0a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1111,8 +1111,6 @@ struct amdgpu_device {
>  	bool				in_s3;
>  	bool				in_s4;
>  	bool				in_s0ix;
> -	/* indicate amdgpu suspension status */
> -	bool				suspend_complete;
>  
>  	enum pp_mp1_state               mp1_state;
>  	struct amdgpu_doorbell_index doorbell_index;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 680e44fdee6e..78972151b970 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2501,7 +2501,6 @@ static int amdgpu_pmops_suspend(struct device *dev)
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
>  	struct amdgpu_device *adev = drm_to_adev(drm_dev);
>  
> -	adev->suspend_complete = false;
>  	if (amdgpu_acpi_is_s0ix_active(adev))
>  		adev->in_s0ix = true;
>  	else if (amdgpu_acpi_is_s3_active(adev))
> @@ -2516,7 +2515,6 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
>  	struct amdgpu_device *adev = drm_to_adev(drm_dev);
>  
> -	adev->suspend_complete = true;
>  	if (amdgpu_acpi_should_gpu_reset(adev))
>  		return amdgpu_asic_reset(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index be320d753507..ba8e66744376 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3276,8 +3276,8 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device *adev)
>  	 * confirmed that the APU gfx10/gfx11 needn't such update.
>  	 */
>  	if (adev->flags & AMD_IS_APU &&
> -			adev->in_s3 && !adev->suspend_complete) {
> -		DRM_INFO(" Will skip the CSB packet resubmit\n");
> +			adev->in_s3 && !pm_resume_via_firmware()) {
> +		DRM_INFO("Will skip the CSB packet resubmit\n");
>  		return 0;
>  	}
>  	r = amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 12ff6cf568dc..d9d11131a744 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -584,13 +584,10 @@ static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
>  	 *    performing pm core test.
>  	 */
>  	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
> -			!pm_resume_via_firmware()) {
> -		adev->suspend_complete = false;
> +			!pm_resume_via_firmware())
>  		return true;
> -	} else {
> -		adev->suspend_complete = true;
> +	else
>  		return false;
> -	}
>  }
>  
>  static int soc15_asic_reset(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index c4b950e75133..7a47a21ef00f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -904,7 +904,7 @@ static bool soc21_need_reset_on_resume(struct amdgpu_device *adev)
>  	 * 2) S3 suspend got aborted and TOS is active.
>  	 */
>  	if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
> -	    !adev->suspend_complete) {
> +	    !pm_resume_via_firmware()) {

Looks like this will cover only ACPI based systems. Not sure if that
assumption is valid for dGPU cases.

Thanks,
Lijo

>  		sol_reg1 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
>  		msleep(100);
>  		sol_reg2 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
