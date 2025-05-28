Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B3AC3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 11:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F3210E15A;
	Wed, 28 May 2025 11:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OD7ig4Bz";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E417310E16C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 11:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tS4s+/rr1FH0nqxITLypdJJ3XH7di4V1smBJSGrphoMbVLVKfiIOZHFKmZQujK11eoVegHu+kLh9THVfVTQd56MbsS6KjqO6BL0wF2/aGUmKpUjnwbs+/f1OKdqiHfo9rJ7f03rrHmGVAjmXNa0XHG9YsnOLkZR9ZsXjdwXs3RSllDgGadsMSuc1LV0D/to11OIRODOJWcvzeHIRMDhmVDWOI3GWmMHI33htgeuhJG4EDQCJBN1b6lroBCHf1oynZneNUf7r5hhU2ds3YNzbb32LnHppo53SUOsjSE/jp43IcIU5ObKWsTrLXaqbuunRNGLW4oN4k6RLiONLGPhwMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGRGU8T51CtRfmOGJE2CbHQU4UvLxhmFaEyzd85jKxU=;
 b=Lh+xgGowne0OhSwf8cB2/c0tOpnHX+OQxFCqEwKwlqfwRchQz68tqJNKZYsBpwJ+9nN5zBGvtq4EsoDaecW7QNIhFm5htowlxq+C3iU40QvitBKHh5G33gcm2/TKtn/kIS5wkShXl+6pdfBVIoIw2vivXJCRVxXnpIkMLNx1iYpcZjZvzT91rIO/RA1+0K4g9ipVYkYHRWxeyZ6sWoYHJB+M0QjINiUQAFBrQeK6P6fj0R28eX6r4KgnWM0KJlX35Stq/hfl27k97vwh5HHbVwgxkQdoiUtpjeykrqYmC7p28njFkbfQvnuf6wAOd56PTbJQybJTFWCoAO5Qcn8PUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGRGU8T51CtRfmOGJE2CbHQU4UvLxhmFaEyzd85jKxU=;
 b=OD7ig4BzzlPKmj7VDG4uTE6T8RzVHrhKWIKeumCNeyaC2VPS9lOUUe9XFSseFeegfOumdGpS2TpslHFW9zaBJetWKmHTLi9wZ9Tu5Tr05AGVx08U/9NahMUkdpA3BX3ksMdOCWPdoATiKd8Xivoa/VlIWiKWRNNn4tFeJVM99Aw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Wed, 28 May
 2025 11:21:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 28 May 2025
 11:21:01 +0000
Message-ID: <97494a80-4336-4a1b-81af-56ca8ca974e3@amd.com>
Date: Wed, 28 May 2025 13:20:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: only export available rings to mesa for
 enabling kq|uq
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250528083756.847677-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250528083756.847677-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 20428a45-08e4-485c-d05b-08dd9dd9b9d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzZJS05EUHNyV2ZXWFhiaG5PUHloL0NScENXdER6QytuNk9HUWIyYzIzOG4y?=
 =?utf-8?B?RnVpY1g0YWZJU1VQMVltckczakg1YTlZRkpiclRJb3FieWtWMDFsVjdnUi9h?=
 =?utf-8?B?ZmZ0QWxucTdTL3N1c2c1ajU1MExYRkxBRFdWbG1CLzN6aXQxbHN0REdLNlVh?=
 =?utf-8?B?VFd1cVVScDF2TnFieTZSc05rMXhYZzhOaFpQbUgrZ09LZDJTdS9aL1dwNkJD?=
 =?utf-8?B?WnhQNTlaV1VQS2hkSlpNMkNDQ1Z6MTYxYmNmcUhKNThiS2dncTFFYlhjY1Nh?=
 =?utf-8?B?MytoWENGcFRKWVNHSFBibHErOTE5Y0w5NG1LeFBxdGlGN0RiMk9iSHA4Z3po?=
 =?utf-8?B?SGJWMG14OWFMVkNaN1FoSTNESmdJSjlCSmNsZS9SRFZDQU56UE5NdGViZTM2?=
 =?utf-8?B?bHkwcTQ4dVFINzdqeWtFcGhIR0dieU9lWmpvd2lHcVNlN1VDNlZMbE1vQlF2?=
 =?utf-8?B?U0xmZFhyb0hxWVEzd0xHcE93L0lxUnpmTU55NFpsT1FnMk0yZ1ArT0VzM3Vj?=
 =?utf-8?B?UENBSkhHbkdQZGlSNmFtYm10NlIrUDVHblI4TFllWWdERnFsazV2Q3BjT1pz?=
 =?utf-8?B?eGc3b255MDd3dytJUms4TVg1OWN4Z28rSSs3UVNTNmdUSGUrNmExWTRQK0pa?=
 =?utf-8?B?RXRmaExTeUpxMWdFWTMrQjVpMVEyMmVDRHF0KzR5NGxpOHZNSEhsVmFuN0NQ?=
 =?utf-8?B?RGNwU3NoVk5MOXoxLzFqUi9GVk84WWVMNVhLTWRLc3NTRU0rMDQ2MWErUDRK?=
 =?utf-8?B?L2VhTCtXZWZTcEplYmxaUlU4MjEvZmR4T0laaWhpemhMMFg0T1RsenN3RXhv?=
 =?utf-8?B?SElJTHlqam9VclA2UUlWWDRQVUYwcjRSOTFpcWIzK3EvNFFxdS92K1IxSFE5?=
 =?utf-8?B?SkI4RUp3TUQvbDN6bW16eDM2ZjNpaVN2YUw0d09Jdll5dU5wMXZMMDh3OU1Y?=
 =?utf-8?B?YXl4Y0NmakR1ZUQvOTlLYm9CUUNqWGpBRitYcnZ1M29FOHBmYnJsUGhBbklS?=
 =?utf-8?B?ZVNrOVRoRjdkUUFRSTh6MGFZWm5pYVQyQjduUHhJY0ljLzVsZHNNQ25Cb1BJ?=
 =?utf-8?B?Wll2eW5RZ3VkK3VheGtCQmt3eVBPOUFFYTFCK1RKYTUrUEZvNy83N1Y4eEEv?=
 =?utf-8?B?UVQvN1ZSRUpmcDRPYTNXMk9RNnFPdXpsemlVdWxSNHhHVk10TFhuNUxjVlVG?=
 =?utf-8?B?NmhPakZ3dTQxbDJRTEJ2ZGw4Z3ZKUFpOUFZLMDcrZUpPZGRiMGV6NDBGVEYz?=
 =?utf-8?B?b3o1MU9kS0duTldxVFpFaHdYVVhRdnV4YXVPMFRyclVicmJiOXhUdHd3RGVo?=
 =?utf-8?B?TDY0QURNOTFGbEJXYzR4cmlnWndiWXI0dHlmLzVEN3NIb0FlRDBDU3hFOGx0?=
 =?utf-8?B?NXBabU9LVlN4bVhLb01QTXdEMEltUGNuK0RoRXYwTEVPMExyRVdXVTBERjZz?=
 =?utf-8?B?TnBvNEEwYTd4U25QS2dTQ2lwRUNqY0lVY2dDVmhhcEljalE0MFdQaEtmRXFh?=
 =?utf-8?B?QVVzSTZvekhKMmNmWmRQMVBRTGR4Y3ZuK1Q4ZnBYdnJJMnFienFPTTczaU1n?=
 =?utf-8?B?eVdpZ1RBdTl0bEVRRE16VHI0SkRFc2YxV2puMzgvYVNFazF3S3FNMkR2c1JP?=
 =?utf-8?B?dVZjK3JpNUNaN0pRa3RhRG55SndYVEpYSzJHM3I3NnRQWklhaDRDVXVUeXhM?=
 =?utf-8?B?OFdtZEttWEZDemYyV1lHYUlqOFBsSitFZUVWRWlzdWJvTDJ3aWo5Z1ZaVmJR?=
 =?utf-8?B?N09hcnVnK0VQSmpHa2hlMm90VnZIM0FjK08rekpGUVlTb0Z0dDdhNGNwMXVF?=
 =?utf-8?B?UHRWSE95c0ZsZVZBRVpPQStYK08zbHhrd0w1RFIyWW9qMXZnQXRzMmRHVDkv?=
 =?utf-8?B?c1lsSzZMeGFkNXdNelBLcnlqVHZ3UmNXY1pmdmVabitza2tkaVBJUXE4cjBQ?=
 =?utf-8?Q?t8A3Zf8lZzU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXNJRlB6N0dxdkRpVmtDb2JQdGpQaS9sZno1YmdLcGhKMWdLRjB4UEUyTDFF?=
 =?utf-8?B?QjBady9DdHY2aHNIUzdnWTZyOGk1Rk1ydWJLdms5TnBnejRFanc4Y0hvU1NV?=
 =?utf-8?B?Uy9hRmZSKzYzVk5ReG9tV1ZwTGJMU1hYdXJuUlBrWHJ1ZVZDTkcwQThsSTlB?=
 =?utf-8?B?eWF2dk10QitFcUFTZzJzOEhvd1hoNmdyOFJ3akIwSXJRY2ordHVIeUQ3Mmg1?=
 =?utf-8?B?WWFrWnRxSW4xV0ZFTzRKYndrb0JGWk5kdk5oY0FTL2g0YU8ycjliamNUU3hx?=
 =?utf-8?B?TnVIZ1JTK0JWcmVsUk9lMmdUL1V1YlJnR0EvMENuaHdvRXA5MXY2MVduZS9y?=
 =?utf-8?B?b3FSd2gvSzlML3g5WXZKUDNaNmlQZGowOTAxdmxKenhzUDJsN1N1aTI2Rk9o?=
 =?utf-8?B?em5hRzBGRmh6bXMwbnlwa1Q0REFpNHAybWZ6eFJFMXRmcERVeXNrbVFNdW1u?=
 =?utf-8?B?ZGxDdWg0WWR4Qk9tUTg1TTk0RG9mYXpwWkM3cDB5cUNGRTA3K01pY2NIYVNy?=
 =?utf-8?B?UkpwczJyV1hseHhDS1hQdXRVYUttQmxQblNpN216YmhKbXNjSTdLK1R3V2FQ?=
 =?utf-8?B?cXdXRk9lQ0czK0N6SEd1bUc0ZWRIMFlMVkp2RmJ4OHVEVEZDbHBhbHVUaURT?=
 =?utf-8?B?RTBwMEFOT1lESm1ZaWcxQWRteXBrbHlLQ0txQTJZeWZqdVNXVEZNckxjV2Ru?=
 =?utf-8?B?bFRYOXVMcEZsNDVHUVJ5R1FidDBXMzUzRHR1bGVhMlhPS2J0UTRzaXA2bWhB?=
 =?utf-8?B?bUJqVFFkRTVRaUdCYmxPNWhtVGZweXpNZE1xQzYwRjBCMjRKeFBNUG52a3hB?=
 =?utf-8?B?YUtSV0VwNVF1akFtY1U3ajRRR0lXVzJBZW5HdW04TTdBRzNQQzIvYXZCb1BB?=
 =?utf-8?B?alFwNitHYTRaOE5SNVAwOWFqR0hkL0xkZVQ2bU1sTFJkTURJc2FVT29JUmVs?=
 =?utf-8?B?MTM0UlNPVVRoOXBoeXVZY01HUGhBNzl4U3lWd0R0eDdnOHJ0MTh4QkNueHkr?=
 =?utf-8?B?MnBDL1ZnSGxsckt6b0RSRnpJK0wzSEhtVkNoKzAxMWN3K2ZlVmxhU09VZjMx?=
 =?utf-8?B?NmJoSk9WMkJBbmdaZG1ob3RPamxOVEpZTmJtdDU3QUloSTBXR0dLdUNRcGtQ?=
 =?utf-8?B?T0NzR3YyVkZhb1Y2WGJxOWhsckNhY2ZSc3ZNaVdxVzFlRnlRc3lKMVY4ZFdl?=
 =?utf-8?B?MjkrRkxyYlQ0WUdOMGJVM0Y1dnVSTkxTOS9vbGZISUh5SU1POExwRUgwK2J0?=
 =?utf-8?B?dEhkaWM2U1F2anRSWndkNkFzeXBCRmNYbGpWNTlPNitqcElPdEZhdXpablBV?=
 =?utf-8?B?clNpNThtckd3Q1FYZkY3b0RERWduVklTOHoyZWcwTXdPNGQ0eEk5aC9zNXFt?=
 =?utf-8?B?dllOcXNnT1hpQWNGSW1nYUVHNUxGcmpQOU5kQk5YeU1xbmd4TjhpMEFUZVZ1?=
 =?utf-8?B?SjI1UlFkMmpyY3c2NzJ2VmJSZXZKWkkzNGpVY2V1eFNkeGVDd21EaCsvK3Uw?=
 =?utf-8?B?aWRuM0lOL0pHQnlaalhSaFZGVnlyZlQ4RDlsWXJVd2FVK1M0bFo5S25nMTBN?=
 =?utf-8?B?SHgrejJSb21GU2t6VFJxekFvcVcxRUhZcHJlWlFxMzlXRjV0RnZRWlpRUkkz?=
 =?utf-8?B?N3dHY2w0Tm9xdlhEMHE0ZVFsMDN3K2tENVlsMUtnTXg4d3RhRW0zeHBETkRP?=
 =?utf-8?B?KzJZMHVJclBVQzk4NGE4bXMwcldjVWZoUkpaaVFCQ1FqMVBjOVRpZngyWXZu?=
 =?utf-8?B?WE9MK1h1ZjNicVFmRzE1N3JmUHdyZlhIWDJaWXZPQ2RSdXlmQjhvaGh6Zi9k?=
 =?utf-8?B?aFozcU5iRjZtVHFET3RPR1RsWW4wNnB0YWxPaGVNeGNJWDF4R2dCRUVlbmwv?=
 =?utf-8?B?SXlldlVDb1FwYmhqUStMdXAxa3c2dENCa05UY05qWW5ueE5zSVV0QlJZYzRu?=
 =?utf-8?B?cWJiZnhJOTdaVlpHTkpaQmdVVWljc21LSkxTNms1M0hTYVdPMGg0a1RSdGo2?=
 =?utf-8?B?YUVQclZmWlhBay9URmc3WGdpNVE1alI2ZE9Gdm5idUczQVRNU0pHN2w1T3I5?=
 =?utf-8?B?VlhKL1B6UmUxSzd0M2RUbUtPRUtLTHh0YnFNTTVOTlZJSmdKLzltZE1ITXZX?=
 =?utf-8?Q?XzztBshZAQXRsVCiR6Pl968Oj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20428a45-08e4-485c-d05b-08dd9dd9b9d3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 11:21:00.9922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tJciYVFSrae0jHPy143u6gm7PGEQUzlZyB6coc5J2malI6ZfYTrMhthS4Oh5R63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974
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

On 5/28/25 10:37, Prike Liang wrote:
> The kernel driver only requires exporting available rings to the mesa
> when the userq is disabled; otherwise, the userq IP mask will be cleaned
> up in the mesa.

Hui? That doesn't sounds correct to me.

That userq is disable in mesa when kernel queues are available is intentionally for now.

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index d2ce7d86dbc8..43d86c09d8bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -409,7 +409,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  		type = AMD_IP_BLOCK_TYPE_GFX;
>  		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>  			if (adev->gfx.gfx_ring[i].sched.ready &&
> -			    !adev->gfx.gfx_ring[i].no_user_submission)
> +			    adev->gfx.disable_uq)
>  				++num_rings;
>  		ib_start_alignment = 32;
>  		ib_size_alignment = 32;
> @@ -418,7 +418,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  		type = AMD_IP_BLOCK_TYPE_GFX;
>  		for (i = 0; i < adev->gfx.num_compute_rings; i++)
>  			if (adev->gfx.compute_ring[i].sched.ready &&
> -			    !adev->gfx.compute_ring[i].no_user_submission)
> +			    adev->gfx.disable_uq)
>  				++num_rings;
>  		ib_start_alignment = 32;
>  		ib_size_alignment = 32;
> @@ -427,7 +427,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  		type = AMD_IP_BLOCK_TYPE_SDMA;
>  		for (i = 0; i < adev->sdma.num_instances; i++)
>  			if (adev->sdma.instance[i].ring.sched.ready &&
> -			    !adev->sdma.instance[i].ring.no_user_submission)
> +				adev->gfx.disable_uq)
>  				++num_rings;
>  		ib_start_alignment = 256;
>  		ib_size_alignment = 4;
> @@ -439,7 +439,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  				continue;
>  
>  			if (adev->uvd.inst[i].ring.sched.ready &&
> -			    !adev->uvd.inst[i].ring.no_user_submission)
> +			    adev->gfx.disable_uq)
>  				++num_rings;
>  		}
>  		ib_start_alignment = 256;
> @@ -449,7 +449,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  		type = AMD_IP_BLOCK_TYPE_VCE;
>  		for (i = 0; i < adev->vce.num_rings; i++)
>  			if (adev->vce.ring[i].sched.ready &&
> -			    !adev->vce.ring[i].no_user_submission)
> +			    adev->gfx.disable_uq)
>  				++num_rings;
>  		ib_start_alignment = 256;
>  		ib_size_alignment = 4;
> @@ -462,7 +462,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  
>  			for (j = 0; j < adev->uvd.num_enc_rings; j++)
>  				if (adev->uvd.inst[i].ring_enc[j].sched.ready &&
> -				    !adev->uvd.inst[i].ring_enc[j].no_user_submission)
> +				    adev->gfx.disable_uq)
>  					++num_rings;
>  		}
>  		ib_start_alignment = 256;
> @@ -475,7 +475,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  				continue;
>  
>  			if (adev->vcn.inst[i].ring_dec.sched.ready &&
> -			    !adev->vcn.inst[i].ring_dec.no_user_submission)
> +			    adev->gfx.disable_uq)
>  				++num_rings;
>  		}
>  		ib_start_alignment = 256;
> @@ -489,7 +489,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  
>  			for (j = 0; j < adev->vcn.inst[i].num_enc_rings; j++)
>  				if (adev->vcn.inst[i].ring_enc[j].sched.ready &&
> -				    !adev->vcn.inst[i].ring_enc[j].no_user_submission)
> +				    adev->gfx.disable_uq)
>  					++num_rings;
>  		}
>  		ib_start_alignment = 256;
> @@ -505,7 +505,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  
>  			for (j = 0; j < adev->jpeg.num_jpeg_rings; j++)
>  				if (adev->jpeg.inst[i].ring_dec[j].sched.ready &&
> -				    !adev->jpeg.inst[i].ring_dec[j].no_user_submission)
> +				    adev->gfx.disable_uq)
>  					++num_rings;
>  		}
>  		ib_start_alignment = 256;
> @@ -514,7 +514,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  	case AMDGPU_HW_IP_VPE:
>  		type = AMD_IP_BLOCK_TYPE_VPE;
>  		if (adev->vpe.ring.sched.ready &&
> -		    !adev->vpe.ring.no_user_submission)
> +		    adev->gfx.disable_uq)
>  			++num_rings;
>  		ib_start_alignment = 256;
>  		ib_size_alignment = 4;

