Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E522C2BBCA
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jun 2024 12:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7D7510E0C6;
	Tue, 25 Jun 2024 12:45:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rBSgibmO";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CCB310E0C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jun 2024 12:45:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rw71CTYD4qf55S1jubTi10H+PNnoNA2eFKMJNR1CKPK0H5SRYGoqtlJs/vQ492XxJQNy5DbbdvEaehwrTc1y/hWMxs+AXiI9ZY2Fw/Yv0R4E6LX1ZX868XRUc8tapud1z5SxeogIW3L3M0I0dZummwcX6tzcAjPsvh1vYWvjYCIA9EEH4R5B55bETNus61X+DRAgmUW8wqcvf6irQO7TK4p+34BT+IL5u3FF5zQIbvmC2k8wTXLlgLIH3caIJHWGnTN8g2XqDRmJwKZjkfS0AE7Y0eafmmZMRS+mJuLvJdCmBa7KRon5LDlN/AGn55bVqaNlA7RhNBZX2oufolF9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOuMrKYFsqCrBpmdJ3I6U5ip7o0efZkAlVRUncWhnwY=;
 b=IL7gJWCPux13Av8r6fvrUR4x77jWQ7w0N+MBSBh3i4EKr738xu5mHa5xA6mvhDlHzl42f4hxAwXCX0tz3xu6Ou0rrhcCWDL0p+foeOpb3QxWHXu53jz3h+sVFphWoM0Zs1F+ZM8FCWmKJTxZ75wwP18hC/F6i/aAn0jY+lI7XH8hRHB3+M4UMlOl/PTOd2QsfWm9qK0VIuZ8CSuiPYH0MMVTUo9O5O91r9Gb3Nh5CM/GiSdLOlcz9RgbFPmQkaEuY+N4j98d9mwV8jw423Ul1ITLdvSyywnraCtKLuyo5r/KGVCf6M2EtQNucix4SG6abbdMczg0EzC/EllQZyV49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOuMrKYFsqCrBpmdJ3I6U5ip7o0efZkAlVRUncWhnwY=;
 b=rBSgibmOArYfHSMEh7g7b2F2DpdfuyoVwUNw4r73QfD40xtFH33/nZrna7swSs0HZD2cyv1muj79JPmFyyipvobPQCQGDUV4sXL8KGL45XhzB9ZkRPYTK/rgdd2p/6sfn+NVUgvaU45Y8hp7q5iD41LmWxXB+5jMwGfkvwEjFHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 12:45:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 12:45:35 +0000
Message-ID: <e7131b79-c48a-48f3-9654-9e00a34cc784@amd.com>
Date: Tue, 25 Jun 2024 14:45:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: check bo_va->bo is non-NULL before using it
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20240625124211.132100-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240625124211.132100-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ae15d7-3767-4981-79fc-08dc9514b4e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aCtlUGR3K0IrN0c4aDRCT0YwcFlCS3BjbWlUaHJQNm0zanlxZGdPQ05Ua1Ri?=
 =?utf-8?B?di9LOE8vY0kzNFZFWlJKWjlXVjYwOHVka1pXQ0lndkcxSEw3cklCdWNHM0tD?=
 =?utf-8?B?bm5VbkVoU09KbmVZODJxV3NmVWRFcS9yUllNRWZ0Q2NuSXEyVEUrQUNxQXNR?=
 =?utf-8?B?V0dVdTZMS00ydUZmSjNpZkNlQVpYVThBL00zRmdtWVFXbXRIRjhnSkJWSm1M?=
 =?utf-8?B?UGlRVFdYL3EvQW94cnA5cUdmaDZack01ZkpSZllLcTlYZnp3Qkxhem9BZ0JM?=
 =?utf-8?B?clhQOHUvRGdBTE9qU2xyZDd2bXRpb1Y4RnNrR2hYeVZtK0M3V2lKOHRrRUJr?=
 =?utf-8?B?VTNDbnN0NjB2SzJLVW9kVFM3U1YwTlg4VUM3YmphOW9TcEtBQmQ5MlA3Wnlw?=
 =?utf-8?B?cTRRd00zc0NMNVU2dE1GZEtIMFJic2VIaDY2M09IVGRHV1huSExpUmdIWXRy?=
 =?utf-8?B?cGpzSFVQWERBbFI4R1B6NkJGem8zeUxzUk1XbFBjWWVVL3hMMkcxZktDb0Ur?=
 =?utf-8?B?dzB3OFhmRHpwWnllVHd4azl0UHJrVWNwNUM3NTB3bGljTHQzV3VNSWFKcjcr?=
 =?utf-8?B?MUFUaE92MEEwNjY4TFBhMEhvSFlxeFRwUEswRzM1S245NzBoLzR6SEwvSTd5?=
 =?utf-8?B?alU4QVZUZHlMbUhDcXZjTllpZWtXRmlzRDhyNm1oS3hSTFVjSkltM3V6RmNr?=
 =?utf-8?B?RiswUXdrcU9WRVNHSTh1UzJySVIrejNwN1dxNFkzVlQrT0plTWRHWm4xZXRy?=
 =?utf-8?B?b3hid2h4aGFTekgvMXZRUjRtMjEwSU1RNS84Q2N6L2YwNDBHSFQ1bHlTdGpy?=
 =?utf-8?B?aVNDandKRmtnTFdyeTdTU0lxa0lPN1NFU3JITXZrejhOQkFCTDJBUzdPQUY4?=
 =?utf-8?B?a0l1L1V0eGVHeXRVcXRkNTdPQ0w2SHhES0xBL1ozUW5YaURZUWdJbUFKbkRa?=
 =?utf-8?B?L2ZDVnUwekdqQTI3Y2FRRG1mdU5PRytnZmVHZERMTUVmR0lhQlJqNlhuL0h3?=
 =?utf-8?B?Q01sL2o3d25DYmdSM05qTzBINHlHOFB0eVZTNG1pOVA4SFhTVmRicG02MzYy?=
 =?utf-8?B?Vnc0cHhGZ2l3ZDFxMDdXZU1Gem5YdHIzV2NzYWduTGNvVzN0RGg2WGV1Yis3?=
 =?utf-8?B?d0lxMmJSZStpMXRydHBQVHhydWpEb3Fta3o2SUlRL2FzVFVQeVdOUnFpVGg5?=
 =?utf-8?B?TjVGTHorVnY3cjkzUnhlL0V3aXhRaFFkeG5veE5PRnExK3ppa2tPSm5QSWkv?=
 =?utf-8?B?dDFPV2NGNWw3aEI1Q2F6UGNOdlh2K2M1S1FLVVFacCs1cG5od2w3N3ovVTVl?=
 =?utf-8?B?ZlFsZHl3ZUF0QVZVY0I4enpHZVZvcnBYem02NjRWL1M3MTNqSGszQlZFVEJu?=
 =?utf-8?B?TWZyQkpScmtvNDZrbTFCSTFSYWEvVHdjcEltNHlZRFNjNW00dEduOXE1M2hM?=
 =?utf-8?B?Uk9IN29SQldjbjlZNE5meDZhbWxMQitheFF1VmxORlZ0ckxvaHRZZ2NmOW81?=
 =?utf-8?B?S3M5RURBdEtSUnFVc2FOWnE1RFVxQUpQckN2d2RvZ1ZzcnBIM2c2bFhYbGl4?=
 =?utf-8?B?dkNyZkNGNjIvd3loZWZQRTRwZ1Z1WFU0WlVteVU2aG53Tit6a0MvTmFlMDkz?=
 =?utf-8?B?cFRoSU01dHorQlRUdVh5WlBGSjNQajEvMTJLS2w3QVlJWjRWNmlVM1lHUWtQ?=
 =?utf-8?B?VUpaWlZOTHkrRklOa2tCNFZSRy8vQ1FaclhPNmMydzJQRnJsenRxcG1CY1U3?=
 =?utf-8?Q?gSa4q0F12+HKs47ajiBE01iMzLreW6g07NoowKO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(376011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFVsWmQ2eGZhSFZRQmVHN3NoVlBkS3ljNUpqWWh4c0s1WnR6RjVqaG42Mld2?=
 =?utf-8?B?WWNxY3FNZWxsd29pRkpLbWVnUzZKWW1CYVAyQnk5TUs5MFU1RG9iZ2dibmdR?=
 =?utf-8?B?UUJpUTVYVkp6c1dUazIvdkE5Y0RsWGNLMitLNzkwaVlGVzFBSm1aRXZXMDdL?=
 =?utf-8?B?THdKUE91QWxQaDF1dW5PTXQzWkN3bmUxeDdFZmFXL3FlWlNpTlkrV0poTjAx?=
 =?utf-8?B?bWh4YXlVT0dUakdzQi9RWVBSWWovWTl1dFMxRlYyR1pmYkh2RFNwcUNKdHIx?=
 =?utf-8?B?Z2JacmV4Zy85azREcFFZajFzbjdPa3dYWjRLaGNjbURPWWdnQlVXTCtRMktZ?=
 =?utf-8?B?YTRDOU84cG5XYkh1ZlROb0JrRDZWUnlkdHlOanNJQ1JPSTNXVnZ1SU91enlT?=
 =?utf-8?B?a1lXS0NJMGZveGJvajNwUzlTakpmQzlXN21tWXlSSlBtVWNBUEg0cTl2bEln?=
 =?utf-8?B?dXgybE1KWUVGUzZhWUZUYnFRUm9nNjhqOERWc0wwVWdyN0xKMHNndlhxc1Bh?=
 =?utf-8?B?cldVK2NCSHJPd29iSTJMaHpPY3Z1UUltNms4Y2N4NHNjNmJ2eWNVWGF1TVha?=
 =?utf-8?B?V1QydFZGYUxYLzFab1MwSnh1bEt5UnpMWEYxYW5xMHZkWHpNYWRLNTBvTGFm?=
 =?utf-8?B?OXVaOXpGYmo2Qjl1R1hCWHhwN09NUzZqcWVjWDJ5YURmSlZhNVE0c0hIMmFB?=
 =?utf-8?B?MFJpdHJEUENPMTBpclhPY0hCV05LSXp3ZkJoREhGek5DNWdZdWNud1NJazhv?=
 =?utf-8?B?WFdxSXBxdi8zZWhva1BmRXUrZjV3NFV0YTdwSklFWHRaL0U5cWtWb1ZnS3NT?=
 =?utf-8?B?QTFSNDZQZkxvS01aa2RpaDZ0KzljWEdVL3JDN05ITlZwck9QN1cvVEZYeUk3?=
 =?utf-8?B?U2NENElzWWJUcWI3bWNZdXVtWTUvNG80RmcrQzY2eHpHMVM1d3RpeGZUVFA3?=
 =?utf-8?B?aUpPZ1M2dXptM3Z6L1N0dXV1TnNtUWVBTnRnZVRvakROR0psdUlaOXVvaHI3?=
 =?utf-8?B?OS9tNkk2MUw0RFJESlpXV0tyZEpJRWxyOXhON1ltUjQyeGdpMlNWcm5kTVdt?=
 =?utf-8?B?dTdsZW10Rk5wcTBCc1N4c1JQOG9hME54V1N6UnVxMGVSVnY5MXpKQnNNbWpr?=
 =?utf-8?B?ZTRkeWx1bW1KalR2dEx5R0Q0aHVVZHNyTmJyVWM1TUpnMEEyVGk4UmlxQTNR?=
 =?utf-8?B?K3ZjRlBBVFhVK3hXdTZKS3FzaGlwUjZObjRaZzR5Wi8rK0MySk1FTTZKSHEv?=
 =?utf-8?B?YW84UnpSbXJHQ1VRWEVkdVU2KzhXdXlUdFhmMTdaZ3hwKzJic3ZjSFBNSmFm?=
 =?utf-8?B?THlLdThvL3ZlYTlTVWNEbWhyNXBiZ3VhQUFhKzJrRy9DOTUvb2VyWmg2YlJB?=
 =?utf-8?B?NzBzMURhNVorMGRSQTFyVTNLTTdsRE8rRlR6bUZNdjhKekg4eG5NU24xOGlq?=
 =?utf-8?B?azdxOEtuY01BYWZwVlhVd0g3b3hUVlBlempDREkrQzlHd2MzZXNoYVBuVGdJ?=
 =?utf-8?B?eU9vcnhuTDJNU2pjSkluQjVEWEk0RHFNd2NLNDNGMStJOWY1MCt2T1ArazRs?=
 =?utf-8?B?blVlWHBlMzlBTGhvalY3b0MvMDlWTSs1SUN6alpWMXZaRDM3V05SSzBzZ1M3?=
 =?utf-8?B?bUMwVHRyRHEzVEt6cDdZUzJSZmNqWW1YL2JUYTJpSGtjTFo3OGxNN1pnVEJo?=
 =?utf-8?B?OUVvb2RKMEJzVUJpVkV6QTJzMlo2RC9vVjVQWXpzcmJGNXpock1iTVdmQll4?=
 =?utf-8?B?Mm1EOVBNOVY1L3l1MFRzMTZad1hFQ0dud0tWYWZaTWw1bGkvbXJEdjdPMUll?=
 =?utf-8?B?ZVV3b09LUUZzeE9SRmgyZS9pU1VaQ0o0MWdXc3JVQTIzUU9uSGF2YUZzWm5o?=
 =?utf-8?B?dDJtOEhYRXdweUZEcnhXdjFsMlUwdXp4Y1U5NUhQZXd6N2JZdU1ORmsrQ0pu?=
 =?utf-8?B?NXBHMmxWVGQ2Y0J3NFQ0ZnB4MnFLanNzV1NWb1JUSzVRc3pNSzZxcnlpek5r?=
 =?utf-8?B?TDlzR3JTNVAyQjJDSk0xZUlvUForRmRPZ0doQzdZc1g1bjZvcDQrZFR6SWdW?=
 =?utf-8?B?cHErZ2pjRUIxRk4wWG1mL3RmTmkrYnZGdmVqRGtqL0k0RWtncFlQS2krak9p?=
 =?utf-8?Q?WHlxgSTkQs57qGgW/+UVL+Ohc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ae15d7-3767-4981-79fc-08dc9514b4e2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 12:45:34.9208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/VTIvSBhdbY345BE+KqX7JdmWmOe0FZ6PZ4cnzcuhBDu72RYt4ShFEpmfTMGtnr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
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

Am 25.06.24 um 14:41 schrieb Pierre-Eric Pelloux-Prayer:
> The call to radeon_vm_clear_freed might clear bo_va->bo, so
> we have to check it before dereferencing it.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/radeon/radeon_gem.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
> index 3fec3acdaf28..0cf1a72091b7 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -641,8 +641,17 @@ static void radeon_gem_va_update_vm(struct radeon_device *rdev,
>   	if (r)
>   		goto error_unlock;
>   
> -	if (bo_va->it.start)
> +	if (bo_va->it.start) {
> +		if (bo_va->bo == NULL) {

In the kernel you should probably use !bo_va->bo instead.

> +			/* Buggy userspace can try to use RADEON_VA_UNMAP after
> +			 * closing the BO. In this case, radeon_vm_clear_freed
> +			 * will unset bo_va->bo.
> +			 */

I think you can drop that comment, it's perfectly valid for userspace to 
unmap a region after closing the BO.

It's just that the radeon VM support was never designed very well.

Regards,
Christian.

> +			r = -ENOENT;
> +			goto error_unlock;
> +		}
>   		r = radeon_vm_bo_update(rdev, bo_va, bo_va->bo->tbo.resource);
> +	}
>   
>   error_unlock:
>   	mutex_unlock(&bo_va->vm->mutex);

