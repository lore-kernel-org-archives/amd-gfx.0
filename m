Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3653C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 22:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F2D10E2C2;
	Fri, 26 Jul 2024 22:18:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z9RyU6Xg";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFD010E2C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 22:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=He4d6sr3VE30XKiL0ogLwz48gULImXtUfFqWPW2FoBV5DPs8z0Rh+vwAxz42ckHwf6gTExSeWh89FYJPCuzCVjVN13pI+irXMG1B80+32LoQrC3Ropval3jqhraSv55/NAv8fsQ5ze6pJGqhyp1e0ZxqgwE4xHQSbto0ruUpKa/eNGeO73KM0/Yw/7nGMp6CYzwO7BBFfme7n8KnxGcEW4Ueya3vTw7LyNPiSZpCS8iybYHXXQNfmvz88ad6OfmZ4gRvmxCkb2pFFnYze2pxl33uyu660zR0eo17Ai+5YOAoQ3EiuYtiGmK5zI3lgMeYOxr3l9K++2w9Z/XjVr64gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBtDHc4P27ggOtmnbjYXxstfrnMC5O9VTOdKgmE2J/o=;
 b=d3j9kWshR40yGw1FwSbzrbRTPf4MVsw4nP59SEP5/UQNLR7lJJKJwPAxShZf380DZ55dgT3Fr6iS0ur9yVEoFSivK4/F9wkn+YI1abHO5EjbNPIJpC+GjN3y87V2DxT6PaL9BAuwqJdADXP6L4XA2Sjib8bD7w91mutnN+tq8H4f7Ou+jEOwMA5cWOHa+08gl5ykwY3YZwe5FrlKhI7POv50ibP30L49K82imOTsvtdercZ031jgbyfRexlPLGGblejDbgsq1f7lNd8bLeyYJ/jXeFInlyNVSKp+Dx1SpbEEcVITWIm6KX55+hNY+RrtQLIM+gYg5pXida/TpluKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBtDHc4P27ggOtmnbjYXxstfrnMC5O9VTOdKgmE2J/o=;
 b=z9RyU6XgSyH8MgBNyGz+9oricC25PWW69pW/HH+pMpjSYl9Wv2cly5em1MvqeJdNB3DrBFmA5zCA6nqdevj07eAnMqZEeDlGBHr9d/vBZcI4WeXTAubwU1L2TvQwYHQtoZC2aYUSktvRA5ebBKPHiTnCwTZqnWOhDkcOc8Su3f8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 22:18:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7784.029; Fri, 26 Jul 2024
 22:18:20 +0000
Message-ID: <92fdbfce-645c-41ad-914d-c7c127d91f91@amd.com>
Date: Fri, 26 Jul 2024 18:18:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix compile error if HMM support not enabled
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kernel test robot <lkp@intel.com>
References: <20240725232504.15982-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240725232504.15982-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0211.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ef501d-624d-4db9-d83f-08dcadc0db1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkVQWmNra21hZDFiRXFvdVhsQWJNMU5JdWFKbG5IUGRNbEV0ekRmTXBKNmk5?=
 =?utf-8?B?SGhVMTVKLzFzSVhmWTM3dnNKYkF5UWNCcjRFV0FlbFd4WHFjeHdOeGEzZ2x6?=
 =?utf-8?B?ajdNWTBDaDZ1MFpEeXZmK092U1RQUU03S3lpMTVnVDBMWEx1anl5UlBtVkVF?=
 =?utf-8?B?RldGYUR2ZUsya0VRbFNuY0ZHamRnV2kwQVRrK2N2OWNpdkFRVkMvWWNwbUFw?=
 =?utf-8?B?TTRnNzNETUcrV253QVFWS0hrT1RCWnBaZDFyTk5SRFdOVkljMkd0ODVEMFFC?=
 =?utf-8?B?SnNwL2xVQk9RNG9ONU1xMk1KVEVTTm8ycnZJQjBGUlg2aThLak5DUEJkUmJO?=
 =?utf-8?B?V2xjdEpVak9TR1Zoc3I1Mnd4bjJMUitqUnhEd2xNTy93OEVydzc4K00zTWtv?=
 =?utf-8?B?eEJESzJLUlcxZjFKMmJMTFNOMVpJQldoa1JCSXBKaTFLSmlaRUpGL0kzaFk0?=
 =?utf-8?B?Wmx0aldQMjF5WFFLRkhYVFJaWUFuY1puUlhQVU9SL0hTM2dMRkp5RlpTRDZt?=
 =?utf-8?B?U1hzaHZ6Y3Vib0hVN0dKUm15TjhFTSs5b2pSeTlnbmRBb2JsemVDYVBUUzJr?=
 =?utf-8?B?dGw0TmEzTzRaRUcwazFFOFE4VXJvdWJxRmxXK0tjRWVmcndueTNsMGVFcExK?=
 =?utf-8?B?U3pDMHBPOUFGQ3daaW1oOXdxbnU3T2tsWWFDZmJnRk11SGNrSFlJRTYzL255?=
 =?utf-8?B?UDFXdCt6MHRFZVFOZEtmcDlRWUJPUG40Ym5kWkNiUUVLRnNvbW1EZW00RDFJ?=
 =?utf-8?B?SFgrR0grd1o4NHZ5M1ljVm9COWh0THBFM1pralJPSFRVMkZLRk1ZQmtzNzYx?=
 =?utf-8?B?U2pzR1k2dlJVOHYvZDF5Y0tPZGRKUmMwWlczN2ZDMklJai8xa1lScktiYysw?=
 =?utf-8?B?VmRLS1pDNXRhK2R2aHg1NnNiSFFXaFRjY0xDTThUa0dac2xHQW5qUjJwY1JY?=
 =?utf-8?B?LzZHUXBBR29ZQzQ2LzJxTE03bmphYXZaMDAydktXUHJKWHBkenBJbzdvaVdI?=
 =?utf-8?B?alF2TmZBcDVjMVFIK3NseDJHSFFqaExMTm5NRXJvZWd5QWdHQlVUaVFiTDVu?=
 =?utf-8?B?SXk0TmIwanphanN6MGVoeXNheFR3eTRlMFJVK1dmSDNyaWRaZURVeXB5aUFa?=
 =?utf-8?B?WnVoVGVNVkRZNjBzQnJLY29hZFNEVXd2N2tjU3l5OUxWOER1czlxL21yMVJ0?=
 =?utf-8?B?SERqRmhVT0NhdjFyKzJOTmF3QzFOQlpUUklBN2gxYTVjcG1uelhzVlFrUExS?=
 =?utf-8?B?ZGx3VS9kYVNVWTlFRGVad3JDU2FMOWpBSVJnbDFKczltMm9RUW1CRkZ0Nnkw?=
 =?utf-8?B?VllsN2RpOTNsejI0R0gwSDZJZXBDSmtyNU9wRzVSVm5sZ0hOcnRqNDZvWWgv?=
 =?utf-8?B?UmNidU5ZMEZ2QjR2QWNsazZkc281UU5rN2lFa0JwZmdKbFRQbjBlZFRPWWNk?=
 =?utf-8?B?NnMrL0FPaWlTSVpHOERRNHBoVUdvZVp0T3Y2bmZieTEya0xKRzNvaHM4amFD?=
 =?utf-8?B?cWFIV0N6ZDd6aHpXVHBtQk5JaEtLb1ZEQ3VwSENNcm05WnhYMWVtSjVjNHcr?=
 =?utf-8?B?cFVCQ0VZWE9RbTZrT2Fqd05aZysxN2FkVERjSHpGWkFEd0daZXMxelJIWUpM?=
 =?utf-8?B?dmpVNHBXelIwK1Bwb001aHNYeWxsNGJNOHBDWHh2cGl0UVhvTWRwM3RtYnlN?=
 =?utf-8?B?V0djY2N2WHdzazF3eDYrRFZaYVdRZHMvdWgzZEtCTEhZWVVsdkJweVEwblJE?=
 =?utf-8?Q?rY+vQBM/Cx5l866hok=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHE0bTRsbGdZaVJRSTRVZUhEQVUxbVBIN3dxQ2ZWZEVkcjdIcVhHSVJIaTE0?=
 =?utf-8?B?cSt0TWxiSmVIUlhPaHd6QW1lNlkyNHNMN0pObUJEeWtWLzV1REpPdnpUTHV1?=
 =?utf-8?B?bUZXMk93dFdOM2s0VCtpUkNyMXRvc3ErV2crdVdpYXE5R2p3c3FIL2V3aXB6?=
 =?utf-8?B?OW01WGZjS0pLcWplQmI2aEduNVltU3FmZjRXZGdoM2tQVWFVVURXNkhxaUxD?=
 =?utf-8?B?UnQ4ZWY5NUNkemN0dEUrRzBSV2R2VDhuelFLc1N1SDBEam1BR2Nyd1d3WW9B?=
 =?utf-8?B?QVp5b3M1ZFE1RjE3Y2pPbEF6RHZBSlc5N2dmYXp6TGNRcW1WZVhWaVlmamx4?=
 =?utf-8?B?ZUk3ZzF5M2oxZEFHK3VXSXJMTjJucDRNTEpQQ3B3QzJvSEZSemp0azdVMExx?=
 =?utf-8?B?SEFYVU52YmVqTzQ2Wk11eHd4MlZOZCtrZkk5ZXNZZFVNUkoyb1FPK29KWXBO?=
 =?utf-8?B?cjV6S2VqejFKTjE0bnk5eXVEdjA5TzJ6VWpZUlM1L2tyWHgrbDJLbUhLQnVj?=
 =?utf-8?B?bG56MmNpV24xUGZsODg4eHlLdDB0Q0ZjaGI0ejYzQTl5QktFMnpLeEhQTjhm?=
 =?utf-8?B?MGhhc0N4SHowUEFMd0NWeHREd0l5WmNuS1VVYnI5VUJhaWtYbHhxdFM0eDBm?=
 =?utf-8?B?b0FTS05QVVZGTGVwNHNPbkZjN2lad0cvMnhmNnhZbDhlVjRDaGlMdGk5clAw?=
 =?utf-8?B?YmpuN0lZVFlDNTlENTFiVS9xMThWMkYvT1VLYW9IMElMTEQ5UWw1QUV6UmI3?=
 =?utf-8?B?VC9haFd6T2w0by9UQlRIOUl0YWlTRU9JdW9UTyt5UHJJbFVHQTZ1aExwTlhZ?=
 =?utf-8?B?VXE1bTgrYzBhVml5UFd5eTFjVkRwUlY5cVd5SXZsQ0p2Y3huRWZISXZiQUM4?=
 =?utf-8?B?QmNCZVRlWnNJLzBZMytFREN4MHN5L3hWekhxTlI0aWNjYXpYdDd0NUhLWFRo?=
 =?utf-8?B?bE5GZVhQOGVJTWt5WHNhZFlTMVZWV1NIT2pySU9zYXdGUUNNa3cyMUUyeVJJ?=
 =?utf-8?B?RC9Rbko1L2xhV1p6c3c4ZG5SeWljcGpIV2hNZjdBWDZvSW0wUzJuSDY0YzJw?=
 =?utf-8?B?QkhjdU9IMFNvbGhvdXJZQWJybDJSOHlkK0ZUYStweXBqSTRqSFBuMkNEVjNJ?=
 =?utf-8?B?OEdMR1JFY3NNTkoyMmlNN2g3akJiSXhZT3ZmS3g5czF3aE9hS3VoY0ZGZXVY?=
 =?utf-8?B?c1oxYlFOQy9yYjNiNDZGelZrOXFRWGpLSndpYVRKQWpCOVJ1NlhyTHN5ZHlz?=
 =?utf-8?B?M3Z3azZ6ZE9jbTEvOURIY1NjUTFGMTkyK1o1NjdVZStiYllwSUlmVHE4WkNH?=
 =?utf-8?B?Q2ZxUWMrc0FCWmZzaTg5V1ZJdHlaeEpSYTZnWS92bGI5UzFnR0hJKzNRbnZj?=
 =?utf-8?B?UkpWRnZRcXY2T29ocUc1V0dKSWMvVjNzQ0pVSzdISmN5RmFnNjNGb0ZVU2s5?=
 =?utf-8?B?YUZTL0hHVGNROFR6S1JYNzhQdW1pRnhpYmVtSlNmYUtyYnZxOG9DYU44TVk1?=
 =?utf-8?B?MEd1T0xuM1Nud2Q3MGFpUkNHQnFJY3VlenQzSG8yTnlTQjYzNG00U0Y4SURN?=
 =?utf-8?B?akk0ejg0Mkhqdk1NYmVRWjdvZ25OVkJZYkI1SmtIVDZFMCtlN3JrMy80bjlB?=
 =?utf-8?B?bks2S2lFQVcwVUhGR1B5dVIwa2FmWC90NCtnR0tva28xZGJacldoRS81K251?=
 =?utf-8?B?ZWJXSVhnZ3Z5WGdKNHBHQXRFMDQxWklsajBjVVVOcjV2SVN3ZkVjK3ptb3gr?=
 =?utf-8?B?aStnOUllekdyQUZnSms2dVJkMktSU2RnMWdxMHhFZTVCcUZVL2crRVJiM21i?=
 =?utf-8?B?Rno5UEFQSGV3N1UzMmJPSUZ0UWpYV24zZ1VXdDdUYmdPcGtCaUxsQWJYMTgy?=
 =?utf-8?B?L1NDSlkwMEtvS0gvSkxROVF0YmxCMWdkRUZ6a2RVTkdEZmxMRVVlaytRR2Y0?=
 =?utf-8?B?UnZxSE5ybTR0WGhuS3RhMTJRdHIyWnBoMU9DUGI2c1hUVDI3ZW5kSWc5MnNM?=
 =?utf-8?B?V1NXcXZwRFBwREZ6d2NZVVowTVdNTDFod2ZnWHFxMWZvWUpORWJYUVdBd0dV?=
 =?utf-8?B?WmNaWUZPOW1XcFpPTzduaXlsSEpscWlRRjRZYkJ1RTBYR3BRV2J1RTRTOHJn?=
 =?utf-8?Q?d6OC67H4sD2562HbL82QFMqie?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ef501d-624d-4db9-d83f-08dcadc0db1c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 22:18:20.2828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWd55Uw5ZenGsAqXXMY2W9Wij8R7oFHVC+/LzAsYqsmH1Nf9QiVxXJJKfCBcrbhwNcQcNci/CJxKMOAogKxFGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
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


On 2024-07-25 19:25, Philip Yang wrote:
> Fixes the below if kernel config not enable HMM support
>
>>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_queue.c:107:26: error:
> implicit declaration of function 'svm_range_from_addr'
>
>>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_queue.c:107:24: error:
> assignment to 'struct svm_range *' from 'int' makes pointer from integer
> without a cast [-Wint-conversion]
>
>>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_queue.c:111:28: error:
> invalid use of undefined type 'struct svm_range'
>
> Fixes: de165b53c93f ("drm/amdkfd: Validate user queue svm memory residency")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407252127.zvnxaKRA-lkp@intel.com/
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index 9807e8adf77d..64c292f0ba1b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -85,6 +85,8 @@ void uninit_queue(struct queue *q)
>   	kfree(q);
>   }
>   
> +#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
> +
>   static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
>   {
>   	struct kfd_process *p = pdd->process;
> @@ -178,6 +180,18 @@ static void kfd_queue_buffer_svm_put(struct kfd_process_device *pdd, u64 addr, u
>   
>   	mutex_unlock(&p->svms.lock);
>   }
> +#else
> +
> +static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
> +{
> +	return -EINVAL;
> +}
> +
> +static void kfd_queue_buffer_svm_put(struct kfd_process_device *pdd, u64 addr, u64 size)
> +{
> +}
> +
> +#endif
>   
>   int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
>   			 u64 expected_size)
