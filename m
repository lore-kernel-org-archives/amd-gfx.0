Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813E2C36013
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Mar 2025 08:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00E0810E136;
	Mon, 31 Mar 2025 08:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s/teyhpV";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB3AF10E00F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 08:24:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLnqX6dvkLH3yKqhAB5nlYwDffx9blJ+l5PTKk43kEhE5+YiwvOoeJ1So9YZYiZah//pGnbk/CIACzbOuGMxevkm7G0fIJlkZqryyPLcXfx8Zrgb+e5Nj0+fxpjKwdAXFhACIKCBMRCGSzEGuqzzTHBVXcR36UyNNDIkkPJVrojfIoF+jSl61RHfEv3x3IUIxZUKtplflzQEEnQCdRo6sgua8rFtueeQc2MzLKRndId3bVPC8tTw86Kl9ybGEnWFhXSQvvY1D8Om8KYdPk7VywLXSf24H4cdRuqVU9y71CYuS9kyRkZTTy0wK7jB5/IsAyHAx0ghvYLX8PEbj6k7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAuzs//q24xVWedF3z16tiZW+J5nt6Ixs1we5mNRsfs=;
 b=xa9CtcaKUyBuVovcJCXGZyQHXPhMzzJMXYbYK32kW85VN9C797L0V450sRUSyX5UtMcF6IWlWbcOKWIFq0YCNhTbfP6ZabVbux15DBtBTsvm8EJUEvUPe0rYbVFdjswoH4Bjh7nLoVQENGrNn5KlKXlNlAfhgJ+MPGBqSBS6Q6SMI9puc1R/2K+3RhqmjjuMTnxPu5CkdipJiunNF2dpNYInnzgsvJtjDT+gt5KG10kg7cYsOYxOqWGQKqzI/G127y2TXeW4D61IW0Z5bUKCSGl2pKxAzTRmW+OKjXmB3C649iPp+d7b9C3YiC032BtABjja3286n2YuRrcPtSOmSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAuzs//q24xVWedF3z16tiZW+J5nt6Ixs1we5mNRsfs=;
 b=s/teyhpVSVKftuEfcr0Kkrl+FQa0d8gAgmjuOpuyRN46Mw4zzWOvKZ+RSh++nXVawS/vL8GC5uO3oY187tpHGcJ9kgSp2wnbr2fMddoHiP/aBVboJ1uDm/OPc4BGQE9HGupGyfLnGpXBNEG5ytc8oZk2JroodLsbpiu7lR6xOes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 08:24:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 08:24:23 +0000
Message-ID: <9b95adc3-4010-489f-9cd6-78c36da63aba@amd.com>
Date: Mon, 31 Mar 2025 10:24:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm: Add DRM prime interfaces to reassign GEM
 handle
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, David.YatSin@amd.com, Chris.Freehill@amd.com,
 tvrtko.ursulin@igalia.com, dcostantino@meta.com, sruffell@meta.com
References: <20250328180652.2108029-1-David.Francis@amd.com>
 <20250328180652.2108029-2-David.Francis@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250328180652.2108029-2-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc65759-2f6e-4098-292a-08dd702d7112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVdtaDVWalZIcnRYTFYyV0tZcTFDVXVzM3BqcDBzUGo5aTQvRFZQY3JhS1Ar?=
 =?utf-8?B?ZFdKd0d1blBFRW5hcXlGVkhHNU5EM0pOWGRtMmZXNllkNHVJSmpTK1NHOTBD?=
 =?utf-8?B?VktxWWZ1bi9BVHNyZ05obFZUcm9tRE1PSUkzZDRVdlVQUVo3cUgzekdJY1pq?=
 =?utf-8?B?czJ2QytuTVFtQm94OWpwaW9PMFBjc1hFNkF6ajgrWVBMTG1UQnlIcDJIbGIx?=
 =?utf-8?B?ZzVtdGp1Z3pUMFY2QWU0NmF4Q01vOHVlNUlON1ExdUY1b0pOdnUwdncrQ2tL?=
 =?utf-8?B?eXY2Q3JhdVR2YmRBeTRVZkpPZ3IrNFQydGRzK0QxU0pFNFJySXZLcDZmeTJq?=
 =?utf-8?B?dHByVFR2enBXa3Z5clVCWDM2RjU1UVo4WGVTaFZSb05jMEkrWllnemZGWnFX?=
 =?utf-8?B?YkVGdzk1bytMYVVheUNVK1kzZDRlS3BwaU9IMG9pV3FrcVIzVDBCaVpab0VW?=
 =?utf-8?B?QWZUMzB1MW5GQnFWYmpCa204S0tFaVFmUmt3Z2tEbDFNMjdqQnF2V1hVMFR1?=
 =?utf-8?B?ajQ1VEJoYXBMeXZ0Y1BiNWo4UjZIS0VXRDIvRnFuR1pVTE5WRWN0K0MwOGhh?=
 =?utf-8?B?SjVuVWlRUjJoWmdWdmd3Q0I3YUtYa25hN3U2M1JSRUNWa3VWRGVtQzU3bllM?=
 =?utf-8?B?bVZoTFk3MnJJTHlpOCtJVEU1aXR4Vy9CT1VzU3ZDb0ZPODdRekNoTGFlQ2Nr?=
 =?utf-8?B?K2hWdUczVlhkbEFHNFJKeTRLZHNsNlc0c2NJeVQ2R21DSDVYUzRPWnZRSytV?=
 =?utf-8?B?eDVHU2EyUkhtOTRmRUF3a2xpQ29mckpNd0oxaXFMVVNaY2JxU044Slp0UEgv?=
 =?utf-8?B?RDRlWFRHL1JodFFMM1ByeURzaW1mU3FRcGxzWDFLZGZrM1MzRS9TWTh1cjZP?=
 =?utf-8?B?ODdHRE1kaWlZSDNRQ1BBUHZVVmV4WThBTElZdkRkZCtiZDJ0ajQ1OStBQm05?=
 =?utf-8?B?K0pjMEhJOVRyRmEyK01qZlZnS25hOFdubkJhcGpFMjNjczVSM0JTVzFDanZO?=
 =?utf-8?B?ZmJuS1lEYW40YWY1YmNEZGJqNlArcUdSN3d5OXhGVG9QdDhpT1N4ZVFvcWIx?=
 =?utf-8?B?MUlFblBPTGQzVE44WCszclpEN1pCdGJmU0JnN1Y2bGZVdnh3T1MzWjIxU3Z6?=
 =?utf-8?B?dTVjSzB1dnBUTm1wenlhYjN5a2FMNEhwc2dqS3RsdHI3VjVJbUhlaFh6VklV?=
 =?utf-8?B?UlpmTUs0dWoyNEQ3QTNNT3RnQ29La3d5M2VjUkpoK3hxOHdrRjRXV2J2WVZF?=
 =?utf-8?B?bjMreHFPaTBiYldvQldkSVpEUXpkV0N4U2RPQkxrNmxnMHRwc0JxdFB1RjRx?=
 =?utf-8?B?aS82L1ZaaW9vTmtIMFJrNE1QbHR5aEd4am5IeEIzNk9pYkgzQmM0SEhIdWll?=
 =?utf-8?B?TnQ3R1Ftb3VmcTBwWWZGMTFZQ1ZHNldaUi8rRi8vSmVkUGNrTjJJODlXREsw?=
 =?utf-8?B?c2VkbUJRV0VZZ2xMZkx3eHllSkMvVEpCS2NJVWhWZVAyT00rVUo0cDJhRlBq?=
 =?utf-8?B?Z25RVFVFZUk4QStMd1pkdU41QVlYd0dUTTBvMU82Z2Z0d1ZoWkp3bHpxWmFt?=
 =?utf-8?B?TVV5R09ncXRsYlUzZlhHY05rM1J0SFMreWNIMCtEU2lnalFmMCs3TjE5S0Ix?=
 =?utf-8?B?NmQ5SUlNQ01MdnZuM0xEMWxWS3BCNzFYSHFtOUtlTXVIUitaSnZvR1hNTG9v?=
 =?utf-8?B?VmlaamdERkxjTlBWUnBvNEZObXRvRXZKNDVVVmwxRjUybngrbFEvSlUvekVr?=
 =?utf-8?B?anNUNGxuSm9kRHJURE1FQzRoRTR0bW5vdXNhSE5LQklqajhBdVMwWlhQbHBZ?=
 =?utf-8?B?Nzg5UFl2SEkxS1YzNGZhQWhRV1VEUDR3TkJZZWwrMFhjMFV5bTFOVjNKQmlK?=
 =?utf-8?Q?sA2xTlFMb9qLu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEhKV08veVZjU05ZWFQzOE56MUJmSzZjaEhHSWJkbXd0MytEM09lSWE1eTlO?=
 =?utf-8?B?UzR2WWdvb0xoY0x4TElLS1k0cWtKbExISzhjdE4yT24yZTBXVVk3cmoxb1VG?=
 =?utf-8?B?N3ZOcDlPNnFVY3ZYdEFobnhtWC9Xaittay96bFlTN2JrR21VZ0cya2dDNmdh?=
 =?utf-8?B?dmlla3hWR3l1WXdiV2FPWVlSREJOUWR6VWpZQkwybmNJRzgwcXNpZjMrZkIz?=
 =?utf-8?B?NVBZSEJqMzdvdUlDWVBjaVBackFVU3A4K1VFVndqZmdjOUhGNHgzYXkvSnp3?=
 =?utf-8?B?ZVpybGpvZXcxVTROZ1ZuT05aR21zUWxWeStpZnBlY1FPWlczM2crTTNCWEZp?=
 =?utf-8?B?VytFaDM3aCtDMEJsY0dGdWd3Q0hzKzZQVTFxcmp4RFQxRThPQWVNRUpFRnYx?=
 =?utf-8?B?OUl6NS9TVk9OWmdUYklVdlRGK1VQOGs4SnBkOXk1b3ZPMnhmUEJtTnNEUXNk?=
 =?utf-8?B?b204a1VFK0orOGhPTnRpUEo0SkN0RUwrUlh6Z3JEVjI0ejJTTVQwTFkxY1M1?=
 =?utf-8?B?SWJ1SmVxdXd0ejdYQUNPRms1WjVBaTc1UHpvZWo2cHNQU2FSQmNEeTRpWjBx?=
 =?utf-8?B?bjV0eGt3OS8zYkFCSHZWUm5tcU5TL1BSckVmV2Q0R3dsc1hqM2thU0RKaDFh?=
 =?utf-8?B?aWcvbktKeGxBK21KeXBlVHpiZWx0aU5RZW5QbzAzeE1pNWpCZHJSc21PeDBl?=
 =?utf-8?B?Q2Fodmp5VG1VM3dZQjFZdGxjSmpqamFzY0xGYTdaa2E5UmhsZElpajkveWNT?=
 =?utf-8?B?QWpBSXdoSnlnazJzR0hsdFZyaTNpRVBQTzl5UzJaeFgyV05oQ2NHem9waVg3?=
 =?utf-8?B?Uy9McEFQT2RVRnRqQ2NDQ05qZU9YenhYbDQrU3NQL1QzVHdrTzZiOHJWSms5?=
 =?utf-8?B?emVIVHByK3JUNktjN1NYb0Ezc21xSjcrQXQ3QUdpWm1WZTdRNW5EVTkzNkJ4?=
 =?utf-8?B?cVZqNXpWUnVocWxySFpmOEhBTTZTZE12Zm03MXlrOWx0LzVRQ3RsSE1uaUgr?=
 =?utf-8?B?OEtRUUErVGhCYk1PYXVOYzV6SHI5MlgrTFJUVUd6U3hhMG5JaGo5TEpwNGVx?=
 =?utf-8?B?VGhqRCtrM09ITVRhZWFaODl1K082dEJKS0VuTEoyMFNPMnV2VHQ0NWJCSkdW?=
 =?utf-8?B?bk5xUlgyU1hHVUtJckxzOHlReUlidHVXanNZeFpVd0J3Y2laMlF1TGdZd2Ny?=
 =?utf-8?B?dldLM0IwZ3hTT1c4VTlNUTVDRS9iQXhvczlQZGE4S3lHNjZuR2c3dEZEWVoz?=
 =?utf-8?B?V0NYVmZ1Ym9MNHNkQ05iS1dOV2RjeElGUkJTUWJmby9ocUlGYmZIZGluTG1W?=
 =?utf-8?B?R08xUUdhTGFQWVowMyt5dCt1U21vS0ZEb1VOZE8remZsaGtWQThLTDRYOHFS?=
 =?utf-8?B?WHZWamgvR29LZ1J1Zml2ZTA4ckdnNnAyL2FBS0sraW9SMkpuSW5HMUFOVEx2?=
 =?utf-8?B?UmxLS1VmRWgxODFPZE1EMDVnbXJvbzZXTVZqYWs4Q2ZxOW40U21BQ0lkNDFG?=
 =?utf-8?B?ZUFBNUxIWmx6Vlp3bXRhQUkzYnZPdWxjSWFrS1JFd1hhNHdtTjBsQURCVGhZ?=
 =?utf-8?B?UWZnbTJRdGlzZ3ZPb0ZyUUtzWGpvbktQQTJmQ2c2OG9FS09mcFNVbzI3Nnpk?=
 =?utf-8?B?QnE2akluZjFOZENid3NoNEE4VTVoZHpaMTUvM1FFMmxPb3hpVE1KUldabUtY?=
 =?utf-8?B?bkM2WnlCRG12M01adEIrYWYxTDFZaUVXNVlITmxiQW1JdDBwYjJrN1FyN2lz?=
 =?utf-8?B?anNVSWFDVTVTUVhRbThSZWY5YWRObDZhUnhMYURkanhyUSs0ZVpNcU9mUnRZ?=
 =?utf-8?B?V215cERhM2NBalFucjZ3Mnk0djQzSE40YVhUdDhCN3o1SU9GWTdYd1QxSlFv?=
 =?utf-8?B?Z3ErNVRqOXJJTW5XbGE2VDhxSUxEWHRzZ2ZvQlNtWnJvWlp2SWdnWGtBKzFr?=
 =?utf-8?B?cTZmeVRxZU4rVDdmRjJHR3lMRWowaVZ0SEdkbjMrVjg5R0RNOUtLMWQ2TmxO?=
 =?utf-8?B?L3lXaFN3WU5JVUtzeDJheHlBZ2JpT2R2bDErNnRrc0x4TFFPYjJjbWFmWHdM?=
 =?utf-8?B?QzZIR2hxK1EyRmY4M3M1YWtZNHBKamhwRFk2YnhHdVhndWdlNHFFdGJxbXBW?=
 =?utf-8?Q?4+Wc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc65759-2f6e-4098-292a-08dd702d7112
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 08:24:23.2204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBsh8XGtf9XJ5UZbgiUULxYxtL5meFlWa2eqpMT6ez/Y/KyAqqVGeyuKJLbbbflH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
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

Am 28.03.25 um 19:06 schrieb David Francis:
> CRIU restore of drm buffer objects requires the ability to create
> a buffer object with a specific gem handle.
>
> Add function drm_prime_change_buf_handle to change the gem handle
> of a specified buffer object.
>
> This function calls drm_gem_object_release_handle.
> drm_gem_object_release_handle is an internal function with one caller;
> make it not acquire the prime lock.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/drm_gem.c   |  5 ++++
>  drivers/gpu/drm/drm_prime.c | 47 +++++++++++++++++++++++++++++++++----
>  include/drm/drm_prime.h     |  2 ++
>  3 files changed, 50 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index ee811764c3df..f56eeed808d2 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -282,7 +282,12 @@ drm_gem_object_release_handle(int id, void *ptr, void *data)
>  	if (obj->funcs->close)
>  		obj->funcs->close(obj, file_priv);
>  
> +	mutex_lock(&file_priv->prime.lock);
> +
>  	drm_prime_remove_buf_handle(&file_priv->prime, id);
> +
> +	mutex_unlock(&file_priv->prime.lock);
> +
>  	drm_vma_node_revoke(&obj->vma_node, file_priv);
>  
>  	drm_gem_object_handle_put_unlocked(obj);
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 0e3f8adf162f..08205b291825 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -190,8 +190,6 @@ void drm_prime_remove_buf_handle(struct drm_prime_file_private *prime_fpriv,
>  {
>  	struct rb_node *rb;
>  
> -	mutex_lock(&prime_fpriv->lock);
> -
>  	rb = prime_fpriv->handles.rb_node;
>  	while (rb) {
>  		struct drm_prime_member *member;
> @@ -210,8 +208,6 @@ void drm_prime_remove_buf_handle(struct drm_prime_file_private *prime_fpriv,
>  			rb = rb->rb_left;
>  		}
>  	}
> -
> -	mutex_unlock(&prime_fpriv->lock);
>  }
>  
>  void drm_prime_init_file_private(struct drm_prime_file_private *prime_fpriv)
> @@ -1084,3 +1080,46 @@ void drm_prime_gem_destroy(struct drm_gem_object *obj, struct sg_table *sg)
>  	dma_buf_put(dma_buf);
>  }
>  EXPORT_SYMBOL(drm_prime_gem_destroy);
> +
> +/**
> + * drm_prime_change_buf_handle - function to change the gem handle of a bo
> + * @file_priv: drm file-private structure
> + * @gem_obj: gem object whose handle should be changed
> + * @newhandle: handle to change to
> + *
> + * Will fail if the gem object cannot be found or if the new handle
> + * is already in use.
> + */
> +int drm_prime_change_buf_handle(struct drm_file *file_priv, struct drm_gem_object *gem_obj, int newhandle)
> +{
> +	int oldhandle = -1;
> +	int ret;
> +
> +	mutex_lock(&file_priv->prime.lock);
> +
> +	ret = drm_prime_lookup_buf_handle(&file_priv->prime, gem_obj->dma_buf, &oldhandle);
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +	drm_prime_remove_buf_handle(&file_priv->prime, oldhandle);

That won't work like this. If this is the only handle (which is likely directly after creation) then that would potentially destroy the DMA-buf.

> +
> +	spin_lock(&file_priv->table_lock);
> +
> +	idr_remove(&file_priv->object_idr, oldhandle);
> +	ret = idr_alloc(&file_priv->object_idr, gem_obj, newhandle, newhandle + 1, GFP_NOWAIT);
> +
> +	spin_unlock(&file_priv->table_lock);
> +
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +	ret = drm_prime_add_buf_handle(&file_priv->prime, gem_obj->dma_buf, newhandle);
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +out_unlock:
> +	mutex_unlock(&file_priv->prime.lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_prime_change_buf_handle);

This needs to be an IOCTL and not an exported function. Re-ordering handles *must* be separate to re-creating the buffers.

Regards,
Christian.

> \ No newline at end of file
> diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
> index fa085c44d4ca..5a9288493dd7 100644
> --- a/include/drm/drm_prime.h
> +++ b/include/drm/drm_prime.h
> @@ -112,5 +112,7 @@ int drm_prime_sg_to_page_array(struct sg_table *sgt, struct page **pages,
>  			       int max_pages);
>  int drm_prime_sg_to_dma_addr_array(struct sg_table *sgt, dma_addr_t *addrs,
>  				   int max_pages);
> +int drm_prime_change_buf_handle(struct drm_file *file_priv,
> +				struct drm_gem_object *gem_obj, int newhandle);
>  
>  #endif /* __DRM_PRIME_H__ */

