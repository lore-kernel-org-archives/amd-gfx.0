Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA558CAC5AE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 08:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E647B10EA04;
	Fri, 26 Sep 2025 08:50:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d7oJVCN0";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BF2010EA04
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 08:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFGwxlWz+l03wA75iu3n06hjktxjh2pxSnphurbrE9msAFsDukelHUDeD+hUavkx1j9hShzaFe/aVUPvuKHX04LAVGOkWtX/yhd7DUFbotlVD5tNeepWK+itv8NnjPuIE1+X9a81A9QU/TpqvoqA/zRCzI30kElGxXBZJkpRXAZn7s5IvUJuz2iHuECc/QhkGErQeV7fpPh5cpZm0CchcRda5dgShbBN99j3FcX8/UYZgktwoKhuGDrMFBovZiySDYanoojRVuswC0RdiYGILE10f/Wkd52EvsgKUZq6NEPv6CmahwQN/Z+638GXHkVtDXXwUKigmdtrJVCjGaf1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5P5TSn9Kdnx4drMrUWXvRU5lt7kNYskUz5za3RvwgY=;
 b=LR51UCvA8U/rF4udGdnUggtJsx78JoSSZGk6qBjhPgDOgC+zfQXeCqFo3NqSTiwJUD4RW6pUmwHWQ8yHMNmzam1OUdrDeoQMTPKBfwPTLYkvd/luxLBi62Mi5W2WvltFP5rg71Lfp7+IPTHSl/H5kP4+2t9ROdI8Dio8xuWCcDFAY5+/DmDrxNET0Hk113tSLlye7mTzmIEXFC23l2PAcqekMgZe6ZpI7xmpOLQ2VcX7/G8dDJuyGq7LSHqrM7BgIgVJBGRfakoqmRgOhIAV0qoVWRrcwNU4jt9jns7YRmZV4aXflStq5BoEIRkloxoYW16/3LS2VyZdiTOUgplJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5P5TSn9Kdnx4drMrUWXvRU5lt7kNYskUz5za3RvwgY=;
 b=d7oJVCN0tT12hW/RR1dA7PoQT1eT1PGrATAoVOLozWCmZ8JRkOiUoOR6mDlnXaUiZAASU3SauwVPKpD+XRKxCc757UYM2mcS23EKtQO4kCjUyT+s/1bbztss67jT3XeJhIOdNB+VdDc2WKZf3opQbH31ZRlrR80WWbm7SFYKLMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 08:50:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 08:50:42 +0000
Message-ID: <6bd2ec1d-2fc2-4e49-abb3-4bf7782c29f5@amd.com>
Date: Fri, 26 Sep 2025 10:50:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] drm/amdgpu: Merge amdgpu_vm_set_pasid into amdgpu_vm_init
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250926080348.2935967-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250926080348.2935967-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac14a82-df1a-4e6d-ab3d-08ddfcd9c62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RE1yV2ZJRzRNU0krWnlhZVFWanBRdGQ4K0ZCM2tGdEF2UWlOVnZLaC9nTEFt?=
 =?utf-8?B?SWkwOHN6RzN2S2N4bGtBcjhOQnRjWVBvUS83bHV4dDVJbHQvL292SVlnK2tQ?=
 =?utf-8?B?TkVtYnpUWHY3Z2huSVVZczRZVG80Umk1YWplTG1kb2FvKzZVdzlhdkE2bHhF?=
 =?utf-8?B?bkJOVnpDa1hVd1dQWk1TaVRTc1lRRC8yejd4ZS9RYTY3MCtiTHBRek9yNTA5?=
 =?utf-8?B?SXNOUlZnUmF0Mlhnd3p3cEJXaThEcmljaWo3eXJzWDhMd1M5OUY0d1ZaNTI5?=
 =?utf-8?B?OW5TL1kvZS9vUHlodVljd3NkRm5QOHYyUUhhMHEwZjJwOHN6bGZDOWRaWitH?=
 =?utf-8?B?Z045MkYrY2lMUmNucGpOblVZMXFZOXBQN0lyeStwNWE3TW14bjliTVkrRzZi?=
 =?utf-8?B?dUd4RWM2bzJXRjlBNFJ2TTFqQ29VeDIxSkc4d0NrQlFRYXdwSkRpWSs1eGhU?=
 =?utf-8?B?MytNNmtoMXZ3RzFJRjVkL095S0JwS0R1TmtXQWhURWkxL3kwVndUaitsaURa?=
 =?utf-8?B?d0s4TTE3MGpCTnJzcGhLSzhTMkFXNWozczhkOFovQ0dwNE1QWjVaQzJxTldR?=
 =?utf-8?B?NEVPZk9KZ3k1T1M3c09XeTczUlZxN1VtNGx4ODJhQUZ4dlpxSnJjT2p2R1Zn?=
 =?utf-8?B?MS9OVERYTlJHWXBPZWlIc012TzkwdU1iTTNzeDViMkVhenpRTDZNejhkT1U4?=
 =?utf-8?B?djZQSERtQ3BXNGRhL1B3dkpUekcxZkg0YnkyMmJmOXFuaEdXaWtrS0w1Wk5P?=
 =?utf-8?B?S0ViNUFnV01BTVhXSnM0SWhGb1kvWlFkRWFGb0JhVlp2WDNXQ0xpckpNQWow?=
 =?utf-8?B?eGNPaTdvU25tWWlSTUl1L0QvQlR6ampEbDM2MndxeGVCMmVxaGtkN1prZjRw?=
 =?utf-8?B?WG16YTVHNFV3d3g0TmFYQVpFd3AwS2VqR2F5aUJzcVgxeDRVUVJUR0Z4MHBi?=
 =?utf-8?B?WFZaa1J4elgyVm10dmJVb0JYcld6d0NGQkJZUTh4ZTdaak1WK25VaXBZbTdC?=
 =?utf-8?B?QXRKMk1aaURXT0tqRXVLdEE2VDZtTWNlMDJmZ3J2TVhITk9HTndKUloxN09K?=
 =?utf-8?B?UDdEakp6OElmOURsei90YzBxcHZiUXdiYU9sS25WT2UxRmpIZS9UVlRWckE5?=
 =?utf-8?B?NWZxbzN6cTVDVHR6QlZWenlQQVk3bCtsTzhIWlJTTFp4eVJzdkphWVUycTdZ?=
 =?utf-8?B?TXBENzBIZnZwZnhVRWJDM1VkbmlxczJ5anFMdjZHUHloOWp6bkYxUFduQlpZ?=
 =?utf-8?B?OU9JVlpxT2o3OFdTMklvdmVJOERSRXJTejdKVlh4SlhRTnNoSStxS2p3QVRJ?=
 =?utf-8?B?Wkd3MUlrQ2dKN2VvV01KWCtSY0dRR1hvWnpmSUxmUHBIWW0reHgrL2JLc2E5?=
 =?utf-8?B?eDFpZVRtTVNyS3NNa1F5MEtyclhvSC9iQ2VXWjdnZTQ2Q0ZXTmJyUUl3QTFx?=
 =?utf-8?B?UlN1b1M0bWhqOVAxMFh4NEltTUphUm5UZ2dGVEtNYXk3ZGpLS25QQ2sybzcx?=
 =?utf-8?B?SWlCU3h2YU43T2RNUXBOMXhGNDFES014eS9GZGVnb3dRNi9CdHQvV01WOUhp?=
 =?utf-8?B?cW04QUNydzNMYmJaVUdwa1hHMlRuM1dQSzd2QmNoN0J4UHZNRjNCa1VkVWxE?=
 =?utf-8?B?UFVDbnlERUZ6UGE5cE9qTVdOZi9hVmZyOWEwd2F4R0V2Ulg3ai9wQkxNRGtB?=
 =?utf-8?B?cGZQai9WLzd6THkxRjFnK1MyeEU4MUc2NGF4MGdDQUZjN0JZaWdvd2NveGxL?=
 =?utf-8?B?aHg5Qm44dFBiYVoyK1hSVzlnMkx4QnV6aEZsNCtXcFNWUlBYVG1DZWVrOWhP?=
 =?utf-8?B?aVluNXczV3pyUHlOWTFCZ09tTGNvNG93aXp1Q0ZMenRtK1FkZTk5Y3Vodncr?=
 =?utf-8?B?TGpJUDRwWllRNnFCTFNYcnhWL1lHYjk0U3hGbEVjR3VVWUJzMXZuTUJhT25O?=
 =?utf-8?Q?b/4tzMOsAtUN5z7KEPIylrPlVhkkSHec?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0g1Q003RU1DSWQrMGx2K0JFTDZoOEY4Mi9GcjlYdGd5N1JFZTI4czRqWGFy?=
 =?utf-8?B?TnROblduUCtaYUVsYUFMb0dBaEtiZ2ptaSs1elZQNkZtbUpwaUUvVWgrbFI0?=
 =?utf-8?B?ZUpWcjhNcXFwblJBelpsYUhGZkZuZExSZERkcW5UdzV3UWR0NlptVFFiRzQx?=
 =?utf-8?B?bDM4NmNRZGhDdVBHVzRMZzhSM0s0OU1nakxYUGxScGJUaEtpRjNlcEpSenhF?=
 =?utf-8?B?bUticHpVczlCREp3b1JrdkxTOGd4U3JEM2tOcldtRHNwbXFwdldaQlBSdkcv?=
 =?utf-8?B?VlhhYXdKWUdPM1BIb3k4ODFRNlY5Z2xHdDBzVzgrVjkrUE9ocUFBeDV5RU9Q?=
 =?utf-8?B?RWZDN2lFNjFESFJwd1pDcHE1ZGVxR05vOHNGcUNWTG9XSnR4QUhBMXpVYTdo?=
 =?utf-8?B?eVU1UDJZWmw4anV3Tk5VTGU1V3hYNnJLUmUzaFRGRTY4UzhGOU1ldzZlei9D?=
 =?utf-8?B?bVpuSk0wV2Z5aXNaV3ZmRGtBQUp1NDZFT25vdHBobUFWOEQ0TFBua1N4OTJy?=
 =?utf-8?B?MDN1cjdBckNydE5vTHdlZHdnaGJKUWZ4Rmk5elFldnFZbisrdDBvN3VnUWNL?=
 =?utf-8?B?NDBpcjZjV2h1d0lhZkFZN2xKOHIxbUttSEdHUHA1S0xicW9MR29hMUEram9L?=
 =?utf-8?B?SUNiQUtLVUFNdnlvVHMrQTBhcVRBVmw2VkMyN0RmdXNhMGZacEdLdmxHdEpH?=
 =?utf-8?B?VXJMYUxHVW0rSkxGZDNWdkg2czZxVzlrbjhtTlZFa0VOQkZPb2R0d3ZDazQw?=
 =?utf-8?B?OHJyZkJvZjZWTjkwUHFwYjZHcWhyUFpmd0VqdlR6SDFPREJ1cituYzh1a2Y4?=
 =?utf-8?B?Q2NqQ0VaN2Rxd3pZR1Nub3VGa2ViQXFDSDNHcnJnaUliK3FkazZjN1YvekdG?=
 =?utf-8?B?Q2dadWVFK0lPZ1cvT0s3clZ0YTNhclVXQmZsR1ltKzcrb2NTOHUvQUJCN0Iy?=
 =?utf-8?B?V3R1QVZlMUY3Ry8zNUFRU1p0RWxIQlFaa01RR1VHekdCQWVyZ0JhY1ByNlBY?=
 =?utf-8?B?ZXhxa3dmVHJBNzNPcGJONTlVWmlMcFRxcnNOZjVOZzhCVndMeEhZTVRpOWF5?=
 =?utf-8?B?b1hMNlB1RFhURGRaZis5SmU4QWZiV3F4K09wSjMwaFJOQVc5dWhVTGdDR0JQ?=
 =?utf-8?B?TkEzZDVkeVVOYktNNGl6eUl4R3YyZC9PUEhsaGRMWlNhY1JVaFNveGw0czg5?=
 =?utf-8?B?US9WWmU1WXJtT2NIaCt0RFl1Mk1ZL1NrNGNKR0VlMHBpVklJb3BIK2VRRk54?=
 =?utf-8?B?cnZiVEpXL2M3akVPNWhnUGZVem5adThBYjVEdy9VK1M5S3Y5V3o3dVkxb001?=
 =?utf-8?B?azROU2lISUxlT01QMW5YVmRXdkw1T2E1TkJUZUdEeGNJV2taWWFJVFVWeTJq?=
 =?utf-8?B?QzlFbHFWclRUNjJyK3JTVFhCcDA2eEwrdy80Y1U3eTBQa0RveGpJMW5PWit5?=
 =?utf-8?B?akp5SEhCOW4rNnQ5eVVGTUt2S1dXZVBHc1hmYmoxWnVKL0E5NjdpQjc0bGc1?=
 =?utf-8?B?ZWdQQTJwcSs2U1dXVWtpaytSRzg4enEvNk01TG9wRUhNT1dGMXNObXN5M2hC?=
 =?utf-8?B?T08wa3VmL2I1YUQ1VFExUnBzQlBuSnUxN1k5ZzNCSGg3eWhnbkVrM3dodE1B?=
 =?utf-8?B?NWZGY0hIUUxWRWx4MHVqa2VENmxCYXBvVHdyQ2wvckppUjRubXJXUUlzRzBx?=
 =?utf-8?B?bm05b0crYzlKR01tS0svS3UzdElMQWlSWnNhUDdscWJsbk9CdGtjNkZnWWh0?=
 =?utf-8?B?Q3dOdTVSS25JZWdqaUhENEhpWUdkUmsyZGR6aUpoWUtITTlOamZBQ2VDRXFW?=
 =?utf-8?B?c3R0c3ZnN3Nab0NwZ1hlSnJ2M2FqSysrdlRyZExxV1hqbnkwTjNHWFpnSUVj?=
 =?utf-8?B?SytxMVhDbTZuTmwzWml1aUJ4RjhhNm9tMGg1WmFRMTlLeVNqY1lCNDB5QWFO?=
 =?utf-8?B?cCtINXRpNWN3ZXkvRURVcVUvL3hqWmFEY2VubmtCVzF0bURFM0p3ejNQYVI5?=
 =?utf-8?B?eCtta1UxOHVzNHI0OXFKSjZSTkVneE1oZjFhQUI0eTVTOEloRG1UUHQ3VVhr?=
 =?utf-8?B?b0RZYk0zdjVPZnh5M0dNRlBhNTlvYUljemRURnN4RGExM2xMaERZQ3BKYmg4?=
 =?utf-8?Q?W6hhTiDxZ4XWYn8pneMlKPeTQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac14a82-df1a-4e6d-ab3d-08ddfcd9c62b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 08:50:42.2102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCz/JKos74PbzeOvuKZGLZqagBXFjraDaZUP79DkHBMaAdo2mFS2/nWY0C2rlo4h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
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

On 26.09.25 09:58, Jesse.Zhang wrote:
> As KFD no longer uses a separate PASID, the global amdgpu_vm_set_pasid()function is no longer necessary.
> Merge its functionality directly intoamdgpu_vm_init() to simplify code flow and eliminate redundant locking.
> 
> v2: remove superflous check
>   adjust amdgpu_vm_fin and remove amdgpu_vm_set_pasid (Chritian)
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 +---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 66 +++++++++----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 +-
>  3 files changed, 25 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 8676400834fc..a9327472c651 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1421,14 +1421,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  
>  	amdgpu_debugfs_vm_init(file_priv);
>  
> -	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id);
> +	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id, pasid);
>  	if (r)
>  		goto error_pasid;
>  
> -	r = amdgpu_vm_set_pasid(adev, &fpriv->vm, pasid);
> -	if (r)
> -		goto error_vm;
> -
>  	fpriv->prt_va = amdgpu_vm_bo_add(adev, &fpriv->vm, NULL);
>  	if (!fpriv->prt_va) {
>  		r = -ENOMEM;
> @@ -1468,10 +1464,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	amdgpu_vm_fini(adev, &fpriv->vm);
>  
>  error_pasid:
> -	if (pasid) {
> +	if (pasid)
>  		amdgpu_pasid_free(pasid);
> -		amdgpu_vm_set_pasid(adev, &fpriv->vm, 0);
> -	}
>  
>  	kfree(fpriv);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 108d2a838ef0..f78fce37b5a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -138,48 +138,6 @@ static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
>  	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>  }
>  
> -/**
> - * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
> - *
> - * @adev: amdgpu_device pointer
> - * @vm: amdgpu_vm pointer
> - * @pasid: the pasid the VM is using on this GPU
> - *
> - * Set the pasid this VM is using on this GPU, can also be used to remove the
> - * pasid by passing in zero.
> - *
> - */
> -int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			u32 pasid)
> -{
> -	int r;
> -
> -	amdgpu_vm_assert_locked(vm);
> -
> -	if (vm->pasid == pasid)
> -		return 0;
> -
> -	if (vm->pasid) {
> -		r = xa_err(xa_erase_irq(&adev->vm_manager.pasids, vm->pasid));
> -		if (r < 0)
> -			return r;
> -
> -		vm->pasid = 0;
> -	}
> -
> -	if (pasid) {
> -		r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm,
> -					GFP_KERNEL));
> -		if (r < 0)
> -			return r;
> -
> -		vm->pasid = pasid;
> -	}
> -
> -
> -	return 0;
> -}
> -
>  /**
>   * amdgpu_vm_bo_evicted - vm_bo is evicted
>   *
> @@ -2552,6 +2510,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>   * @adev: amdgpu_device pointer
>   * @vm: requested vm
>   * @xcp_id: GPU partition selection id
> + * @pasid: the pasid the VM is using on this GPU
>   *
>   * Init @vm fields.
>   *
> @@ -2559,7 +2518,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>   * 0 for success, error for failure.
>   */
>  int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		   int32_t xcp_id)
> +		   int32_t xcp_id, uint32_t pasid)
>  {
>  	struct amdgpu_bo *root_bo;
>  	struct amdgpu_bo_vm *root;
> @@ -2636,12 +2595,26 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		dev_dbg(adev->dev, "Failed to create task info for VM\n");
>  
> +	/* Store new PASID in XArray (if non-zero) */
> +	if (pasid != 0) {
> +		r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm, GFP_KERNEL));
> +		if (r < 0)
> +			goto error_free_root;
> +
> +		vm->pasid = pasid;
> +	}
> +
>  	amdgpu_bo_unreserve(vm->root.bo);
>  	amdgpu_bo_unref(&root_bo);
>  
>  	return 0;
>  
>  error_free_root:
> +	/* If PASID was partially set, erase it from XArray before failing */
> +	if (vm->pasid != 0) {
> +		xa_erase_irq(&adev->vm_manager.pasids, vm->pasid);
> +		vm->pasid = 0;
> +	}
>  	amdgpu_vm_pt_free_root(adev, vm);
>  	amdgpu_bo_unreserve(vm->root.bo);
>  	amdgpu_bo_unref(&root_bo);
> @@ -2747,7 +2720,12 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  
>  	root = amdgpu_bo_ref(vm->root.bo);
>  	amdgpu_bo_reserve(root, true);
> -	amdgpu_vm_set_pasid(adev, vm, 0);
> +	/* Remove PASID mapping before destroying VM */
> +	if (vm->pasid != 0) {

> +		amdgpu_vm_assert_locked(vm);

This here should be dropped. We lock the VM root PD, but only to make sure that TTM doesn't destroys it before we have waited for the fences below.

With that done Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> +		xa_erase_irq(&adev->vm_manager.pasids, vm->pasid);
> +		vm->pasid = 0;
> +	}
>  	dma_fence_wait(vm->last_unlocked, false);
>  	dma_fence_put(vm->last_unlocked);
>  	dma_fence_wait(vm->last_tlb_flush, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 3b9d583358b0..556d0483c6bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -503,11 +503,8 @@ extern const struct amdgpu_vm_update_funcs amdgpu_vm_sdma_funcs;
>  void amdgpu_vm_manager_init(struct amdgpu_device *adev);
>  void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
>  
> -int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			u32 pasid);
> -
>  long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id);
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id, uint32_t pasid);
>  int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,

