Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81112C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 11:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E85551129F0;
	Mon, 22 Apr 2024 11:25:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dQH0sss/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE41D1129EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 11:25:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAMzqxhg6034ymqt5ea8AteX4T3a65im8IwcTx9qB3qHq0mdf5rH+25Kji0rizDfaLhUpCp5VOyEJWN/eDiOa+15gYEB6OfHoWNdPl35lYeZDDOpg7Tnl6vQhWKNfYMsm/QV3RpJPmonBXu0DB6njfAe/P+LFy07uWHq5E6cUr+nBf5IJ9nWtEue5Myv5TTcK0Ol0PMnaGFogNKYHLcNM8MNIBHMnmF+S93NEPo1iGcf9xZSOb0fhx0C9aoVMUsF6vlB3blNhGUiq84giZCukSSsVjcIANyFfALKKMfWYjss0paJBELG/ORG2yQsqGlGCKttvtcj5QUdBzyGqy/eqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOoVbj5gyZiQ7dFEU2aWXn0zDl63OBIiv6Ba8VwviRU=;
 b=l9P0hWPwdGnWbtjpO7Rn+dFkLix3I/r9Kh+vuJrIJpr0/fmK11W8+nK5KGr85Wxmb0wJFI8JEbGpTFk9b9KbCpCWHTx5eJcCLgmYABHZZyr9JKfrGopVagl1pvzeIs30+rOCxbpeR3G8Go/n+nEi2/+QxK/awkzbxqi7AtUqXtOnUgxGk0/K/jIt5U9yp2v5wTl1O/2jzYJryQlkd8gLcd6s/PCSvB5vchPKiwdTJtDRST5I4FnzXdYyNoHVxKCMXAKK6ovc3yIC1XVYIOlpEVMbybubNJuI0vi1UL0WDq5Ds2A6nOckXgztjWxbvLhoGFPPt0MNbn38+iiwUTRDwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOoVbj5gyZiQ7dFEU2aWXn0zDl63OBIiv6Ba8VwviRU=;
 b=dQH0sss/vDO8jNrUBU5FsMFJbaz4fZP/2tx3As1jbP6R4+EB5V8CNjYdMGv8RyKrlb15VwbNkxaZT66q5IAYR1pwh9vHgo20PJSwGYHsKyJ2YR4d5Eovmh07mSB6FB509Wt//Z+BFUctrtIkHldeFo3YpFQN/p9VNftf4YdwrEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 11:25:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 11:25:12 +0000
Message-ID: <3303e24e-d423-47f7-aa01-62fb7a1bed87@amd.com>
Date: Mon, 22 Apr 2024 13:25:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix Uninitialized scalar variable warning
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20240422094908.537208-1-Jun.Ma2@amd.com>
 <20240422094908.537208-3-Jun.Ma2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240422094908.537208-3-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 194cd07f-f08c-48db-4036-08dc62bee014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjFabDBCY21zbWVvWEVqNFFVMloyVGFSMUN1eU9Vb1pOaElGSnZWaS9qd0Fw?=
 =?utf-8?B?Zkt5T2lkTE5Pcjl4MEFHQTF4cWVnSjBJTlJWMjVyVVViL3RTbUJTbTNWaWxt?=
 =?utf-8?B?eS9maWZlWWlJVGk1ZlR6TjVPNWtsYW1NaXJvYXBzVFFGeE5FZEdFeXB4dExP?=
 =?utf-8?B?aCs0N0w0OG40dlNiZjZUc3lTMHRyZzFzdkpGTHZpSEx4OWtpTjRoLzI2dEh2?=
 =?utf-8?B?OC9JOE02SUtVLzhUZDhMSlBZelZQUjU1K0g1ZURzTUFWOGM3SkZQdThoVTlV?=
 =?utf-8?B?L3NWQkQ3RWdJUk8xMnZOZGZSdEI4MzR4NDBLeDFBdXNsV1dUYnorSjgxMWxI?=
 =?utf-8?B?NFNweVhSY1J1V3dUYkQyZ3VkRDZDZ1dIY0VMdW9reHpzV3dGNy9WOXhOc2V5?=
 =?utf-8?B?cUg2cE5rczlpTFREWCthR1lrMEtZb3RDd0IwNVJ4ci9kTGpUZG01Q25mUUpj?=
 =?utf-8?B?M3BZRldmcTZUTmlBQXRoR1A4V3VGaVFHWnh3aGJxQVFhTi9CZG5xRFlaR1Zy?=
 =?utf-8?B?TGJJN3c1Z1dYaU1WN2RJTzN5bCtFVEJEZnZ2SnRjQ0ZJUlNJK2cxNjdKNVZv?=
 =?utf-8?B?enZiNkIvZDhtTmV6OWZscHVQZ1NIWnA2cFJZK1g5YzRWeG1abkdCazhaL0sz?=
 =?utf-8?B?NExxb2o1cmNhTlVlL2R2UDM2V3ptaUpMbmpLOFBpdUNuOWFTUWZYeTU2ZFly?=
 =?utf-8?B?QTNsaGRNNlBCNUd4cE0wS0JFMU9QMCs4VWMxeFVXV05YbDFGb1dua0lhUkQ5?=
 =?utf-8?B?aEVjd1BjVmk4VklyL3RYVHo0MVoybUVoYWJYY0RiTnZPSmpMNDZOZThieXRw?=
 =?utf-8?B?bXdEaS9PcmdGR2xkTUN6SnVxczBSazJ6UVFNTUU0SVVGS3htSUE4dG1ZK1Zl?=
 =?utf-8?B?dXViWFp3RjNEd0ZySUNTMzhocnN5YTk5WWh2L2tsUW01bkN5NUNRTHd1NFFo?=
 =?utf-8?B?eld1Mm1WOVphUFllYVdJRTlDczdMYi9UT2E4Ty9hbHhCVE9WaFc5b3NCVlg5?=
 =?utf-8?B?Y1N6T3A3eHZjSXBod05TeXViNEpmZlRESVFNNnVHQXBNWCtSQWZDNlA3Wmtj?=
 =?utf-8?B?c3NQMzJJZVk1ZDZxQnE4NndWb0phUVhBcVFyVGk3Y3cwSGpZN1hYZW93dFg1?=
 =?utf-8?B?cDhCTXJ1Vzd5UGJwNkVwV2NLU1VTN0k5Sk0za0hBdHAvNktETWd4S3NiYXZK?=
 =?utf-8?B?NTdSaC9TV3RraGwwbjRSZzROc09nY2ZJQVdsSzIvbkc5M05nbzRGbTRyNFhG?=
 =?utf-8?B?L0pQRGdpek5zZklaNFV2cGNVcDNxWk1Sais1aDNYdWpaakNodDJES0NGa2Jj?=
 =?utf-8?B?cmtjWFZ1YnZONEdxYUc4c0ZHSWN0NGtmUzAxazlucGw4c2tLWEk1SVVEYmV0?=
 =?utf-8?B?Z0RKQlFQeUJCalZsZXZBNlFKS2gzeEUyR296Znl0Sklnanl6WmFaY0swVStT?=
 =?utf-8?B?OTlGc01nMFRpRTMzSjI2L0hWSHJVbnJPRW85UlQ4SE5id3BaeW82bys3RU90?=
 =?utf-8?B?ZGY4YzQ2Z2x5blpWeWhqYmdpRHl4SkRBcko0aTI0bnZicGNjOEdDWWVSa1l5?=
 =?utf-8?B?KzlrYjd5Sm1VcG1ZUVN6ZEZGY0ljdDdzL3A5SGJzTGE3NVdvaVpmTmhWWTFI?=
 =?utf-8?B?SHV5K2VZcU1XWXROSHl3R3NHV3NIK0pTNm4wTXRpcTBTeHgyMFlvcmlWM2Fq?=
 =?utf-8?B?WWVEcWZXeG9ZNnBBMkQ5UnllQkFpMUVpL2RkeTFCc09GV0JEU3JHNmpBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWhDMUpCeEZCYzFod1Zkc1NRTDY1NzRuN3UzTVhjVllTQlVjUGJWWk1va1VI?=
 =?utf-8?B?THVsWE55NEZYeHAvTEV2MU0vRU9mdVB0Yk1HODRvYlBta1VFZDR2OTlyUFF5?=
 =?utf-8?B?Z1hJdUpPRnVmcytBRC9jMEtwaGVVNDB3UGlTNk8yYldHOGhjNGVmVEdMcXI0?=
 =?utf-8?B?MjRtbmtMSmxyaWRseTc2enJBc1gxQ0xZbkUweXZYSC82QW1jYVBHaXdFUTU0?=
 =?utf-8?B?T1dCUkxtLzVWczRxblZFZ1haWlhhUE1CTk9Tc2NURXRoUEEyNXFxbHc0WHlZ?=
 =?utf-8?B?SDMzaEViZnk1RmM5SSt2VnZFVU45dWYrNkZsUzNGQ21hYWk2Wnc5cWRtSGhk?=
 =?utf-8?B?VmhDRUxwZEo1NmFveEdkcGdoSnduanRsVE8vOXRMZnFhK25zY3lDWlJjTWk5?=
 =?utf-8?B?Ym1aUVhxRmROdEN1K2hjWTBJZHpYb2hUNXNOUHlqRXRVdkdEMG1XSHh3Uy9w?=
 =?utf-8?B?QXV6SmJKWjdpODdVay9GL1lmSkJ0N1U5eU5QM2E1ditUVGRVWVlTRVllOGdT?=
 =?utf-8?B?dUJLazZXRXRCOUh2Nk9ZNzJpTHhwbWwrdjRPanVaeW9WQUR1dFBlSCt6SjRz?=
 =?utf-8?B?c2JoclVRS1lMZHl2Wld2VmNXNVpsaklCZDRjUkJRMTYwQnBHL2tra1cyN1N0?=
 =?utf-8?B?Ri8yanBJN0p5NE5qL01GN3JQdzdlYVZqaDUvVG9hdXAyUDlyVHVZbWNXMHJM?=
 =?utf-8?B?VVBEb2srQTE5cWpLZmh5VHNydGNEVCt1VVdwZHBYcHhqbFFvcjRKa1huN21S?=
 =?utf-8?B?WTlBaUQwK0g1alNncTNBTkNCVE9oRlkvdFZFTzU5RnhKQmJDcklUWjRWM2FL?=
 =?utf-8?B?VnlId3d4ZGlLRmVzVUJKeTFYVWhqcW9OdDM5emEwZ1NYdWpvUmNDMW5LUk02?=
 =?utf-8?B?Vk1zMi8yUFJnT0QrMUY0K1VLanptZ1dLUUxQU1kxbFVIbHB2UTd6c0hqSVdE?=
 =?utf-8?B?bUxsVE9VbW12Y1RoWmhaLzkwYjRYK2VGRGt5OHZOY05UQnUyS0lDeGJEazVl?=
 =?utf-8?B?a2JCNFNrV3pLVUZvZmFybUJqb1hJczg0MFRmaWVKQUpjMUtvWStBWHJRUWYz?=
 =?utf-8?B?UGZSOHRjTE9zS2UvM3k4emxhejR0QnBsOEN5ZzJFRXRCTGZPMjd2OFU3UzlD?=
 =?utf-8?B?RlNtTmVTanZNaDIyTXl2eDN0d1BxU1lucFRFQitOZ1oxSUpBOFl3VVl1YXlC?=
 =?utf-8?B?K2I5elJPb2p4ajlBUm5XdlMyeWE4TFZ3Q0hqeVk1bDZiZWZNME13ZDlGUTM0?=
 =?utf-8?B?THROVjBVb2t1QVl0WlAvN21pQ0c3NTNmcGYwb1dtVW9uVm1ob21MdzNQMmwx?=
 =?utf-8?B?Z1EwUlROS3krTExMMlV6NWt4ZStFRGE3UVVIVHBUeUtIRy9LOTZHcHVkb01W?=
 =?utf-8?B?RGhjNVB1NGp3U1BjODRNMTMyWkFDVXZUVzh0OG1ZWWFMMW9nWDdSR0FJRlA1?=
 =?utf-8?B?WW1Sb3RGNE5lcmhmYnJIQ3hRZWtsbFlwaEZaQjJjdU5qdk50TFBHZ2Z2d0Ni?=
 =?utf-8?B?dU9tUWRPQ1hIRWpsNnhGc08vQ2lNRnpkOGFsekhyQlFJN3F5bjJxc01MQUhq?=
 =?utf-8?B?bGw2OE1mQlgraU02RFlGWFI3dVJ3TTBhZ2dxWEFCR1JYU1hVRm5DZjNDSjBE?=
 =?utf-8?B?K3dTdGtKUUppSndVN2lKMk9pZmdmbUZGaUdndldtQ2FURzFXajdNSXFNa2hI?=
 =?utf-8?B?ZnQreUFUS0xSZm1jME5DQ3hmOEJRQ2VtaFNxVmp4ZldreHh5Q3BuSHAraURl?=
 =?utf-8?B?RHZ5UmsvOFJKTVZBVkk4NDRWbHhTOXQ5cEdYWFBjWDJ6T1pDNXVNNmp2bmkx?=
 =?utf-8?B?ZlZMN3NjY1hZSVVGeFdTMnUrQXUydXVPY09Lb3VoUjNCQWRDK3RnYkp3cUhX?=
 =?utf-8?B?RGlVcVR3bEhqTHF1aHBhb1lnTmJscFI4ZU5jN2ZqQzUzd3ExTDFWbW1PUEkz?=
 =?utf-8?B?bDNHS29Lcjg4eXkrOHpRRCs1WGh2TStIeXVZMEI5aTk4M0pjRlg3eDhoWmV4?=
 =?utf-8?B?bytzaHYrTitUZnFlTTIwZ0FJTWZvWm05Q1AwdGtlN3B3aW02U3IvUk40RFNn?=
 =?utf-8?B?YTdmcVFmK240RGRsN1RSdHZ1S01ONkxXMm01ZDlDS2xXU2VrTHhHY0NMaFc3?=
 =?utf-8?Q?HfhycGyl4L9nMT2FjrM/EjQ7x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194cd07f-f08c-48db-4036-08dc62bee014
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 11:25:12.3518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNVQgoCkEJfDNjG/iUuUDUeS6FwmTWnUifRkXrJIN+xrLlZu5/2aRQbtafUfq3Wi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907
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

Am 22.04.24 um 11:49 schrieb Ma Jun:
> Initialize the variables which were not initialized
> to fix the coverity issue "Uninitialized scalar variable"

Feel free to add my Acked-by to the first two patches, but this here 
clearly doesn't looks like a good idea to me.

>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 7e6d09730e6d..7b28b6b8982b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -437,7 +437,7 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
>   			 struct amdgpu_ih_ring *ih)
>   {
>   	u32 ring_index = ih->rptr >> 2;
> -	struct amdgpu_iv_entry entry;
> +	struct amdgpu_iv_entry entry = {0};

When this needs to be initialized there is clearly something wrong with 
the code. I would guess similar for the other two.

What exactly does coverity complains about?

Regards,
Christian.

>   	unsigned int client_id, src_id;
>   	struct amdgpu_irq_src *src;
>   	bool handled = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 924baf58e322..f0a63d084b4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1559,7 +1559,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
>   {
>   	struct amdgpu_device *adev = m->private;
>   	struct drm_amdgpu_info_firmware fw_info;
> -	struct drm_amdgpu_query_fw query_fw;
> +	struct drm_amdgpu_query_fw query_fw = {0};
>   	struct atom_context *ctx = adev->mode_info.atom_context;
>   	uint8_t smu_program, smu_major, smu_minor, smu_debug;
>   	int ret, i;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 2b99eed5ba19..41ac3319108b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -120,7 +120,7 @@ static void __amdgpu_xcp_add_block(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
>   int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
>   {
>   	struct amdgpu_device *adev = xcp_mgr->adev;
> -	struct amdgpu_xcp_ip ip;
> +	struct amdgpu_xcp_ip ip = {0};
>   	uint8_t mem_id;
>   	int i, j, ret;
>   

