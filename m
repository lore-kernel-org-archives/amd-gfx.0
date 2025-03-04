Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19171C021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 17:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B929710E266;
	Tue,  4 Mar 2025 17:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I+D7YuRB";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8297F10E266
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 17:57:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwntsGRDqCMLDu2WWR0WYIArsbUGwPVXxrEdZRLyJMpYA0zJJj0xrEJxPl8+wcQSCol3X9V3Q2JPAH02T0B2XmzL02B+vLhPCJ2nTrS1uXxwbx0XZMLxKfqwiGvUr3p04KaCjR14c0A2WAurTGg3yGVedA4hkbctHWAZ15T12eB//+l8FP79CyuhqfMzn9sl+PfcA9i6TVC4EXkh99utwCFbG3UI2NnAKsyWCNHx+VvHIt4smqixackMAr5zW8iGWTgTrdH8DDsDUbRliNQJdd/mzQLwHSUsUj9YS4QMvdqjHS0cIRxraCi6CWCsx4gjaJXW/vBzFY7tLMgYOVWz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRE3OuwR9edkmKKxarit8OPx7zEnCeUJfi8KxEqinjY=;
 b=Qb+Q5dIG+B7rlqNCAk8vzNHtq+L0LWUbha7KEcEMs0IRzsQtF6FxTs2F7hPIozxYbkXI5oA5LyYzcK+/ZL95SL/0T7EBg6/+9gOqGSK+kWbqT9w2f0HxgIVeKe2GITKgJf9USAQXQD1Vz34Bmdql55Ddh8smOaRqTrM60aMkm/unVm1B8xnIFb7KM/Zt5ethw25sEVcVzzzjDT7dWnPBQEBV7VqWnSq9JXggNKZCXYK4YRLQuPxL+qJpRkrkzbroM1ZNIMNcmjYsIwybuJQeFUVwRlsXuZDxIziutEFwY1EZ7rshxxjfsDKhSLYCkHbcKMgnMUDmc0I8PboWuiZ2Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRE3OuwR9edkmKKxarit8OPx7zEnCeUJfi8KxEqinjY=;
 b=I+D7YuRBDbCIw60wMaPEMSbBRVDaw/CocuN/NuWuc30p9DbE99OIDBynmgJyX1opcBXSgDYPnUtU5pXvSIDuWAhtj/CtLcy+eqEUhNIzdbOlH63F1mUFY7vWSa5eJmIKepMo6jUwdzwQQOt20lPcuHEw0UYa9Ox2dm/LgPPHPZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 17:57:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 17:57:02 +0000
Message-ID: <52638c55-ba64-4cf0-9bf3-8b7935e42f3e@amd.com>
Date: Tue, 4 Mar 2025 11:57:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Validate return value of pm_runtime_get_sync
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250304175128.368511-1-sunil.khatri@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250304175128.368511-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0125.namprd11.prod.outlook.com
 (2603:10b6:806:131::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 009947aa-b81f-46cf-9c42-08dd5b45f7ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXcyMWFNaEdpZFhnS05vUW5IZ2JjUmU1ZExXREM0OXN2NjY0eXhudnVGNXZL?=
 =?utf-8?B?QkRMSzhKM3hib2RLTXpmdzFNVkJGMHVQQ2N2ZmtUUzBrUVBwZ2xXUW54S3h1?=
 =?utf-8?B?WlZhckEySmdlZW9qZTZCQmFGRVlDeGVDQ1BaOVRMTURDVWFIOFRBdC9rUXVy?=
 =?utf-8?B?MmpNcEFVc2hNMkJaVitNMENTVm1WRkpLSXYvdFIrZVZRT2YwQUVtaHEzRWp0?=
 =?utf-8?B?MFpNQUJpODE2LzZoRXVkSFRyb3p5aVV4dFhzVFM4VWhHVS9KM1R5RnlTQnV2?=
 =?utf-8?B?MXhKc0dxU2Y0ZU53SE5tZDMwaDFxaEMyYzNWdkVsc1VwV2NSR3IxNGVsN294?=
 =?utf-8?B?WnB2QzZiVmlzWmZ2Uyt6TE1wN1hzTS9aVDlybW9rODNXamRzekRnK0N5TG9I?=
 =?utf-8?B?bER3bDBFTHRpbDFiZlhFYThRa3Z5UzJtYm84SGJKUTUxaWNsR3IxcWtuanZU?=
 =?utf-8?B?RWE5aHVqcTJNcmxUOTVQREx0R3cxVkJuR0hpeXl5aEs1V3BxVTRoeC9ndlU1?=
 =?utf-8?B?SEZYMDQ0Q2NnNHJyb1lMMzhEOGNHOU85YzI3Wm9UZEhuMWw5VnBnMU9PSms2?=
 =?utf-8?B?T1ZtVnJaRHlzVlpVM0tKQlhxak5rVWtzYlN2TmhwKytVLzM5SXBVbkZzQXdW?=
 =?utf-8?B?UWthRGtxbEg2QWJyclZvdytaVVkwei9OZFJGU2lmUXE2NEVmYTJIMXhBNVgr?=
 =?utf-8?B?alZESWI4T3JXbzdjNUtmbTBXai8wZGo4UEdNeGJCRXA5d2ovMmlNa2NNUzBI?=
 =?utf-8?B?bEhxZG1icjlDN2wvbE4wN284emdndXRnUTY2OWtKZmh5QUNuaGQ5VW44VXZT?=
 =?utf-8?B?TC9sVFByd3Y0eFoyb3RET1p5QjBHTXZzTjJNRzNOT1dTYzEvRFRlTWxkdUxq?=
 =?utf-8?B?bkJCV0JoV3A1NUVuWEhHRkpnQ0xzUUFTaXBlY1JxdHJRTXdVRXpUakF3bEs2?=
 =?utf-8?B?d2crVXZkN0oxOU9lM1hvV3VlTXZCOEkwZTlQUjNXQjc5T0xnK2ttUlR0amhy?=
 =?utf-8?B?Smo4VnV3SVFGT0Nid3p0ZmxuUnN5WUJzb09vK2M3K2Z1UzR1TE85Vmx0UGZH?=
 =?utf-8?B?S3gxOXBWK2dXM2lyZDlkTmVnRUdCck1mRVlMMnVvZEljQUxlWFdFTCtINzgx?=
 =?utf-8?B?M09GMGRnYmJLLzl1NFVuSVc5NmluN1B4eDBkaklpZWk0Q1BnMlRYcUdIbEM2?=
 =?utf-8?B?UUhvRUl4Y281ZkhWbFB5cXFWNW9abEpZVWJzNHpYVkNDRWRqcCsvNUpLVUdn?=
 =?utf-8?B?a2w4WUwrREZOaFJKaW11K0Z4dS90UGtZeEtqbzd5UzlMaFd0UXFCMkt1SkVv?=
 =?utf-8?B?RFU1b3BOMnF0bXpxNU43N1BrN3RodERlcjN1V3ZuamZrRW83SWRuUGl1blVi?=
 =?utf-8?B?WWJmOXR5UXpKcDlFaWw4b1haZnVwN0RQUGI0VkJYUDkyYnRYaEdtL2JCUWRQ?=
 =?utf-8?B?RmxTS2xja0hWZGVHd2QzZ2pOQjRDYVNNNVdiWEQrZUdlVm5IZ3h2d0dWWWMy?=
 =?utf-8?B?RFpicFBqNEswZnFDdDJxZnJnS3NRcXJ2aFZHS1d1TDJQcjBIY0tSOWFlK0tu?=
 =?utf-8?B?RTdLY2J5cHc5QVBYQmNLclREWm1oNUY3bG8yMDhPQXZXSUdtVzF4NzRMcllW?=
 =?utf-8?B?SU5Zc0hsNHpMUERMTXVTRkNWWUhiM0VFWHR1Lzdhcit1eXNrR0dXSmdzelVq?=
 =?utf-8?B?TDVadzdsK3ZZOUNENzYvekNVMzBmZzE5ZmtYL2RzM3l4NXlZbi9iUllNckdi?=
 =?utf-8?B?YndrdC9NMWNIWWtaZVp2bTBuZSt0SGsyeDlCYWlOeWdORzEyU1RBTlkzWWlH?=
 =?utf-8?B?NXNHNXA3dXkya3B6TjQ0SS95TmlMVENnS1AzZStaWjNmWjFXZDBXMURmMUVJ?=
 =?utf-8?Q?lJvqWWwuXlOkn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1MvL09sV014NWpqU1FVZTBMY1lkVCtNRnY1djNFMU5RV2M3N09UZkFFUlZu?=
 =?utf-8?B?QlM1VzhQQXF2VDc4OFYrVjlBV0JqcjRIbS9jMmRROEx2SVp4TFpEdlpJeitu?=
 =?utf-8?B?SjFKNlM4VlBsYlkvdk1hdys2TnRrVmY3OStDT2JtNFZLOEh2dnFxeVE4RTNK?=
 =?utf-8?B?RE93T3cvUWp5RUlHMU9RVUpjaDBVeEtBSFVGaHUzVXh3M1NwdVc0RGlMa1hi?=
 =?utf-8?B?RGtEdTJiTU5SL3ZyT3IxSGM4dHlxQXhiUGlDNE85bWdkcERUYUh6MEhhNGgr?=
 =?utf-8?B?RzJiOG1XRjJEanhxOHc5TlA3T252akZFNmNOVG9sVDBTL24wc1lEaVA0bWNU?=
 =?utf-8?B?VVNJWmdLVzRQbDJmRTVCVlFHZTBpTXdqZ2szdzFONzMzU3NLbHdNcTF6NjQ3?=
 =?utf-8?B?SzJtblZWUFBEWHlORDAvNjN4eHJBRDdjcnFVTWJXZWZZeFQ0TkJrWXFKbTM4?=
 =?utf-8?B?MjBmVUhHakRxcVA1RXRQaUtlN0VkUDdYMUVBTGtqQlhHU2ZXRmtSZVd5djV2?=
 =?utf-8?B?SEU4V09ZUkI3KzRGWWFJSDU4Zm1tdjM5K0V1alJJaURxajJtZXBkdER0Wkpa?=
 =?utf-8?B?cDFBT1Vwa1YvUE84YTRNdnJSL0YwRFNqemR2dFJhc21UNzBCNDZEUFp5UnZn?=
 =?utf-8?B?ZWFtVzYyazc2LzZqaEY5am1TUDM3NDRkdmlxS1BUUFI2UjFkZnN4SEc1K1VV?=
 =?utf-8?B?Z1lJVUNUbmNYdjIrSmVmajI4ME8zQzFTRXZSMHZvY3pHc1IyWVlPUlVlb0xa?=
 =?utf-8?B?RmpGZzh2RlFkcVRHcGhkaGdJZENJVlZickJCUUNURk1lQ3A5RFRRUmZ1U3JQ?=
 =?utf-8?B?a1VzSWxBK09PL0NrcTB4VzQwU0ZkQ3dJOFBqbUphYkx5eUtsUm5xZU8rSjZY?=
 =?utf-8?B?eStFaGhUNkM5bEF3dngrbTZBajRrRDhSUGNrc3k4SzVZeXdjSjVwRW9uWEF0?=
 =?utf-8?B?UlVrYkNoYlgvRFBpYTBlRmtVcVF1eVBER3YzM0EzQmhza2I0cEVpbzN0TjI2?=
 =?utf-8?B?RTBmNjMxSkZxdkNWRS9NOEVNUGhjTnU2bkJtanllUjJYRVBCQnpFN3VRd21l?=
 =?utf-8?B?Ui9CNlQrMUxvTmtFeXIwVTZGeFkwZWltK2w5eGZ2NXRsQktsSFZYWlJ1OVBw?=
 =?utf-8?B?T3lsd2lNVVdLc2V0RDBKSytMamtPUnZEcVM1aVVyd29wK0I5ZUJQMFp2VDhm?=
 =?utf-8?B?cFVUdi9iZy9SRENoRE9aTFUybDNqTHRJU3drWW91WjIvZlBVSHRQYWRhTjNI?=
 =?utf-8?B?RnozcUhydTJWSldPU3p4SnYySWMvTjNuWHlFV09BM00xaUZFcndQSkFXN0pU?=
 =?utf-8?B?MGlsbGt6M05mNzIrOER2ejRRSGZXemJlOUtoMllFcmJmcVhjc0ZWeXJzRXRj?=
 =?utf-8?B?WW5Xc3BoVE9ZNC91MlUyVk53bFZDTDM5aGxqRkZrL0psdlJ2b3lLaGJOa2dP?=
 =?utf-8?B?bjFqZGQySUNwcC9Pcndtc05IZU9Rc1p5QXc1VWxJUWZkL3g3dm5EdGpGNmpo?=
 =?utf-8?B?aWV2L0R5Y1NSWTZYUlRJUnlKZ0YyazFUd3p5a2FxTmRhT0pTSWVYQXNNUVJi?=
 =?utf-8?B?eURtMzZUSjJTT0dZdzZTZWoxUTlTNHVXVDJOSDdxSHhPV2t1SUJoY2dzUTB3?=
 =?utf-8?B?MjFnZ0V5cnM4SW5YVmE3NEZweHU0b1FQSXp4cWJiQ1FjNWdYR21XYngyM1dC?=
 =?utf-8?B?TFJCSEttREVqZnNCb3pvTFJjeHBkdmN4OG16dUFvWWpmQUNhc1NFeUkxRDAz?=
 =?utf-8?B?SGhhVGFTOWtKWGdPb0JFMjNmeDVhbFZsQUtwZDlPWkJyM1BkZzkwM2c4bk9i?=
 =?utf-8?B?RFpJTGdYTmx4S1JFZmJwYzNIUVNvQVJTamhsdUZIVldtZFhlN2t5SnpFZ09z?=
 =?utf-8?B?a1dvYndvb0MrRVZTVnFiZkZzbWhuOE4yYXNKOXcvNmJlc0V3TmFhbERlTDNB?=
 =?utf-8?B?TUJiWlI3V1BZajN0M3FOWVFueGJqeEJNWHg4Tk9FSGdpZE05WFVZeXlwdTRz?=
 =?utf-8?B?K3FOc0Y3MDlVUU9IRGpkZmJ3eS92ajYzdXIrNnVReEJ3aEM2eTBKZHR5eTBt?=
 =?utf-8?B?RFJkY3BIOTBCVW43dHJRc01SZ203NWVYQldCb3JqdDV0dU9Ba2tROXovSVlZ?=
 =?utf-8?Q?U+9DlbpWE9DxO3r9zxCEdrnSg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009947aa-b81f-46cf-9c42-08dd5b45f7ad
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 17:57:02.4293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVrMzkfBeulcipmdyyzGxBMEQt7QnIkoLHz/6rBdko4zFVN5KsdGTftg6f81Ls6bSm9+SGs0T6vnpsdDY1hTWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889
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

On 3/4/2025 11:51, Sunil Khatri wrote:
> An invalid return value 'r' of the pm_runtime_get_sync
> is r < 0 so fix the return value and add proper logging
> of failure  and exit cleanly.

You have an extra space between "failure" and "and".

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 3a71d01b54c9..6babadeec268 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -289,8 +289,11 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>   	queue->userq_prop = userq_props;
>   
>   	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> -	if (r)
> +	if (r < 0) {
> +		DRM_ERROR("Failed to increment ref count of device pm_runtime \n");

For new code can you please use drm_err() instead of DRM_ERROR()?

> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   		goto free_mqd;
> +	}
>   
>   	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
>   	if (r) {

