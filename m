Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D46C54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 09:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E9E210ED93;
	Thu, 22 May 2025 09:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oR6BqAgb";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4970710EE76
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 09:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/1t2dZUgIYHBfWMek6krorxtNjDzlRAJgQrDy6hEmjZs7XtT/VXvcG9F6uiq277Z3BCOrSywNa/wEaU8j1/oZxtmCQe9bpc9yk03tQ76NOdDT3eqLDfLNeGagTFJu0XaD/c/CI0I3o+BnnDZxtlDGYu9HX/7WambJiRrHTaEzdv9Qo1BbR25S3INd2BF+cW1KXYIjjHdu+G79Nk5Xt1WyC+64xxiivjgj08qD7Yf3tL+Bj1zIxEZz5xTjZTqk8r/AohOlE00gEk46S0lm5ZM5IxUBkCzrtBVt+g91E8XtkrwouP6luGSLxjUbmexCT7+pWMe6qJg/x1dwDABb0E6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eRXFyTYtlCn1e//rd84mISNrgHJy88wnGdXr35LNbw=;
 b=h7FFG+PCYhePrwmwJzJ3Ld/VEAJ3genEUWFPv84xJmIY2rnV60DsYAJ6Bsn3K6yETBnJJ7SS9sLLqmQflxOL/aiCxeow3RQvByjcqLzlt1KdjWnyJPS/E4xq+pbTFzhzFbxUsU17WSNBEYJ+4Y2Bh7wP9+AefNWtivH+ryMlOESlqfE1w6zQT+hUnH74yAmhYPcuVZsLRg19S+BVqJqxv+e7syVgPwiXk3gmfA4Tp3bviN4Qt2ziqbG2Y1pPjbMRTJlmdTuSgvs6Gj/rAMvMF+QccFK98xWsIBa4AlZlLqnx6xU8d6Ui5R0U7Hq7PNGB7u6BWz+tbEUI4kweSQYwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eRXFyTYtlCn1e//rd84mISNrgHJy88wnGdXr35LNbw=;
 b=oR6BqAgb/l5epMenZCgdCPJbZB1e9vHFZ03WjQw+sXAK5QuWhdhuCT2Qb4Xgrd2plyPjhXF0I9CSY9VPsVZ8Ha8Wb5D/yIOCTrx7+rPL0awg5yGaNG66TgGjVhi/UC8Ykkz/RmzG6Xgkw/4MTl4CNr2XNL2Zjd69CSo1/v/h9TE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8356.namprd12.prod.outlook.com (2603:10b6:610:130::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 09:09:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Thu, 22 May 2025
 09:09:41 +0000
Message-ID: <c21abd8e-2683-4e87-a274-3cdddbc359e8@amd.com>
Date: Thu, 22 May 2025 11:09:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] drm/amdgpu: update GPU addresses for SMU and PSP
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Alexander.Deucher@amd.com,
 Owen.Zhang2@amd.com, Qing.Ma@amd.com, Lijo.Lazar@amd.com,
 Emily.Deng@amd.com, Jiang Liu <gerry@linux.alibaba.com>
References: <20250522034350.433219-1-guoqing.zhang@amd.com>
 <20250522034350.433219-3-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250522034350.433219-3-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: a73f0aee-7309-4d7f-e1a8-08dd991062e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dENtdGwzcjM1VTB3NTRVWWR5WDJWSkxUbFNCYXA1SyszMkRzQ0VsNW1NMXhi?=
 =?utf-8?B?bjB2aHlMMUFHRkd2WjZtUHFXSEkrY0JwcHpmcGxObUkxTjd6MDI5VTFPZ2xN?=
 =?utf-8?B?UG92Njg0NlNha3BEMXZ0elBLeGdOUVU3U1hCM2lrZVFxSEtKRVNGSS8vQXVh?=
 =?utf-8?B?eE5aeEprOE5nS0tFK1JOZFA2bGFGZytxRC9aNituZUNudE9sY2xTVXcyZ2xC?=
 =?utf-8?B?WVUvUHBsOEIwRGQ1YTdxMDRRbzNrQ1J0NURBbVp4QWEreXN6OXdaekV1RXg3?=
 =?utf-8?B?ZHNKbjNqZHRsTkRBdk4wZG1UcTBGekpxSGxSa3BJUU95NlN6QmhZSGR6REY4?=
 =?utf-8?B?b0I0N3IyaVpSaTE3alZ0ZW5rSzlIdEJ1NW9uRStzNTg2T1JJN2p1UE1DM2Ur?=
 =?utf-8?B?c1VhbXExeDRwK0Y4K2tmT2VUNVVtd3pmTHJQYncreS85bFVXdXdwTG1OeURi?=
 =?utf-8?B?TnlleFBKVkFnRUg1ejAxK3FFRmVwNFVrUExReDQ0bTVuWHpwSGovTWdTb1h4?=
 =?utf-8?B?eVJDMSt2QURkV0orWEZKaDlPWkJ1dGFaQ0VwaE96Y0FXS0U2Rno4TWo0VHVJ?=
 =?utf-8?B?cndSZ094a0haMktrK1FZcW02dkE0dkcxczllMGxxeXUxbVk4ay8yZGhDZmhO?=
 =?utf-8?B?dStyTnV3M1lzL2I2cnkrQ2ErQ0laSjUwUjViZ0hGbS81ZUxGZDJQVmtWbXIz?=
 =?utf-8?B?a1lvUUJDMHFwaEdMZndETXFkN2w0RHc2aFUxUHBieFc2dk8wVzdNWEdQQ21y?=
 =?utf-8?B?RkRnbkpJRDNqaUNPa2c1a3FEWE1JWVlINWFDNXpieUxBbStyaVkrMGlaMXdP?=
 =?utf-8?B?cFJEYlFDRTd4cXQ5Yzc3b3N3WW14WkJaMStkUjRHeXQ3T0RrVG5TOElvSkdD?=
 =?utf-8?B?SWt3RGcyaGdUWVlZUStpSEplV3dnQ0ptdWJyUFF0d1hGSE9sUHRTM1ArWEVJ?=
 =?utf-8?B?alBUWGdTSmxPTG1vNlpKQ3FETTZBOWgxYkFOUnJDREptZFdZY2REZDVvc2dk?=
 =?utf-8?B?Yk9IS1JPaDUxcWpYTTg5aVJZd2huMzE1UDB6aklieEJMTUNzakdoeUhCZXFC?=
 =?utf-8?B?UGl2MUN6VGhkOEx1NDNUeXk5cWRxdTFSbEw3NXdab0J0cGRpdW9iV3Q0T3BW?=
 =?utf-8?B?clUwOWc1bnN6NFJXaXFyR1FMVytFMnFHbzNhQ3hUenhzRlBzOGhUdnAxbWZZ?=
 =?utf-8?B?YWd5ZCtKN1lKZjdnelhVYk1pRmZKTUE3ekV0b1hLRUxkRnJBSm9IUlczdEVT?=
 =?utf-8?B?dGtSdmZ1SnBsS0ZuREZ6MlN4dFBjSDh1c1JYSnhPaVVzY2g1MGpDbDFGeHYv?=
 =?utf-8?B?alpKbkw3OGpMQ0grRnlzUGpKUGFxbUN1bGVMZ012UnlFanJkWWxUcS9zTjkr?=
 =?utf-8?B?MGwzT2tmaWRQVEE2TjJ2alV1ZjlQRGxuS1ZqRVRrTjBjNVJIMjVpdWpJMGJz?=
 =?utf-8?B?aVpKU3psSHNDdzh0L0tPTVlUNFg2QmdBWEtHSWUyRXI3NHdOb09CYXJ4TnR3?=
 =?utf-8?B?U3dyeTNqc0Y5N0xFNDhUNDZUeVprVVo2eHVteFgxaWR6WGkyY2xpSVlwQ1pX?=
 =?utf-8?B?V3MxbEhqZmxTeHB4TjdhZS9acVFkYzUxdCtLUUhydXRmc2dNMzVRWnBLL1hF?=
 =?utf-8?B?SWlOVU43NEpPdFVYOC94RDBxcFFjS0wwOTZKSWcvS2FGTDM0Qmt0TUlTVDJJ?=
 =?utf-8?B?T2YxVDFkaWNJSzI2VWg0ZW93eFNONS9nMnRLVVNNWmZOZ2dLSDhoVXZOL01I?=
 =?utf-8?B?aHE3Rk8zbnlHc2djVUF5T0hrbHQ1YU54cC9EbFAyWWNMS2NkRElRUjBCZk5z?=
 =?utf-8?B?TlZRdW0rbWtpWlRuY3N0Wi9rK2R3K1JTSzdaR1Y4dzJkRDFldU9SZmt0aitu?=
 =?utf-8?B?RFJqME9oQ2VqRkVaWWdZa1B3UGc0NnVlOTZoY3Z4NWpIOEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlNIMFo0TzNoNXFOTGljTVpZN3A0Q3JjSk9McVJkTUNmVm9aaWNneHVZK1Yy?=
 =?utf-8?B?OWU5SEs2Ulh5YjA0TTA0Y2FEOStHVGtWVnZoNndmYi9XV3ovU2U0Y2ttVktE?=
 =?utf-8?B?aDBNNDBoamdYZk5TbTIvek81c2wzUXRBcmVuQjZrQlJlTU1HY0lxTGtOZWFY?=
 =?utf-8?B?MWNRVTFzQ0QvVzFoem5LNWdFTWtKeFo0N1NzeTZPMFJBaXRleUtRUmRXdFQr?=
 =?utf-8?B?ZXd5RDB3ajErMVZtZ3JUSm1PNjJxM2Y4aXBqV3ptWWRIYjFXWWJPNkJrRmJj?=
 =?utf-8?B?K2YvS3JLUEcyd1FvdURRdFFHN3hQbGs5ZHBpRDlVZHk3bXNBcDRBWjlDM1ZS?=
 =?utf-8?B?Wks1ZnpNVFlvSnRYSlZtWVBuKzlJc28xbXdmVmhoS1h2OFV5VHhjdVJ3ODhO?=
 =?utf-8?B?MnBtUEQ3WG9hVXhDU3lOR1hXYXVkU0FFd2hMeVJyVTJUZnI3NjVYRlU1Uzhw?=
 =?utf-8?B?S2RsQ1VGeDNkekdpeHN0UmtYZTZlSzZ6RUROVlBwMHR5SUx1OG1TaXVSN1Vp?=
 =?utf-8?B?NitoYXgrZEVOOHlRTmxsZUtWWlBlWHlkWCtKaUVqMGIvYmppVzVyUE4zSHEv?=
 =?utf-8?B?akY1UmxsbngySERUTlN2dnR4bVNBU2dUR054N2tSWmUvdzdsemFYbVpwWDd4?=
 =?utf-8?B?dGF0YWZvMUE4SWNBVENPd0JCQVAyeS8zR1ExUzBRbDhEQlJwdHNZRGZGbGp3?=
 =?utf-8?B?R3YyMTQzNU02blA3cHh3REswUUJWclRPZXVIZUlSVnlRNlpMNzM1d1c1SjNs?=
 =?utf-8?B?WXpLc2xUdWhueHBtNWZrVSsyRWxINmZNWGtLdGYrUUV3djlNMTFZUzZ4OGhN?=
 =?utf-8?B?K005RVVoWlNmelovNXVpTjlrZ1BMSDlqUE9WQnBkeWZmdGV2Z0dmYlF0N0VB?=
 =?utf-8?B?M0IzUFdDYktOYzczaEVRa1BEWTJSWktjSE5USWpEN29XVFFRRjkxd2RNaW4v?=
 =?utf-8?B?cnhKMzI3WjV4WVdSR3ByKzNxRFBJRDNUUHB6QzNzNjlOYndvd1FLaUwvR0Rx?=
 =?utf-8?B?TW9WMnB2YkVwS2hzN3lSR280M3IxY3dGYmJYT2kyMUlJcVpnbG84cTVFN1Rj?=
 =?utf-8?B?K3VhUlhsZGN0bmpkTFBuMktZZFQ4bFdZTEU1UDJjK0R5S3dpUERzWWE1NWlx?=
 =?utf-8?B?UW5MRXN1azdNUmIzMm9KU25ObWZDNVpnSkVQTGRDeUE5SXZkRlRVTGNCNlY4?=
 =?utf-8?B?OEo5OFlGZm1UaTB4dHNTcmh1VjZmREFua0hORTBJUFNOYmhwb3FPclliVVkw?=
 =?utf-8?B?dWwzZFF5Z3pPUnA1NmZIMHJ2WGkzeDhLdUc5YVI2SjJPcDdNanJybTV1VnM1?=
 =?utf-8?B?b0w0dFhweUNUSWRKUG4zWkdCa1Z5d2dRUHYxQjZDSUJvOEZEa0FEam5RMmNQ?=
 =?utf-8?B?UWNoMDZNU0R5eHJiSk56WDBZei9RQ29kdmxXWU1RV0M2V04xbjRQQTJ2WGxH?=
 =?utf-8?B?VnQ0aFo1R2lpS0RSeEVKQXZUL2FUNyszYXdyK0E4NGd6OEg4VUJJL2JnOW5p?=
 =?utf-8?B?SWNFRXZqaWI0TENtMTFDSExndmcxU0YwN21KODdNOFovVElIQVJOZHpFTHdv?=
 =?utf-8?B?cHV2RFNoTGpVdUU0cXBldWNld1d4elVDUk40OFFKZHZBaFhaNVFCV3pMOExJ?=
 =?utf-8?B?Y0dUcDd2dm9PQ2oxRW9nRG1tOWNQdllxK2lCSi9Ja2krUHVsUlZGVnp1ajZW?=
 =?utf-8?B?WEpWVUpOV3IwOEs1bFRSS3pSemNrRnhXUCtiNjFrajhScmo5YUZHcHZNREFo?=
 =?utf-8?B?Q3YrZStkSzZuanJTalNieUp2cnRyWDlONlh2aStGeGF2Vnh3NEJwUkRPamND?=
 =?utf-8?B?TlVNMzNFQVpZV3RzUEZKSjBJTVNYSFN5TVZqVy8remZLY1FjSkw2MkZZMWRk?=
 =?utf-8?B?c0p2MTF6c3ExOWFsTmx2aEFoOGtMdUNOVGxOcEd3RWp3NXA5dkNTTVl1Yy8z?=
 =?utf-8?B?eTV0c2IzWVFmcjZ6bTBmeUNuVmFGcGk0YnBidUV6MzJQdlpSaGFjaEU1YVhr?=
 =?utf-8?B?LzdsUGc0RE1QeDBKRVVVQzFDcTJ1Q2FPTTlDeWhxS3R6Nmtndm1FRFkzUXo5?=
 =?utf-8?B?QTNyc2t2S3NaQ2FQYnh6L3FqQ2dzUGVWT2tUc2VFUzY1OVJITHBndnpqVXJk?=
 =?utf-8?Q?+Hs8Q+w+oWRQTAIZ5KvUL2uC9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73f0aee-7309-4d7f-e1a8-08dd991062e6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 09:09:41.7110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8FMzKOCujd2gOqxpQbLpQn+pXBs+PvRBJxPKXK/hCJUdVmMlS7KfGvKsbQ86DLc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8356
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

On 5/22/25 05:43, Samuel Zhang wrote:
> add amdgpu_bo_fb_aper_addr() and update the cached GPU addresses to use
> the FB aperture address for SMU and PSP.
> 
> 2 reasons for this change:
> 1. when pdb0 is enabled, gpu addr from amdgpu_bo_create_kernel() is GART
> aperture address, it is not compatible with SMU and PSP, it need to be
> updated to use FB aperture address.
> 2. Since FB aperture address will change after switching to new GPU
> index after hibernation, it need to be updated on resume.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 23 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 +++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 18 +++++++++++++++++
>  5 files changed, 65 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 4e794d546b61..3dde57cd5b81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1513,6 +1513,26 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>  	return amdgpu_bo_gpu_offset_no_check(bo);
>  }
>  
> +/**
> + * amdgpu_bo_fb_aper_addr - return FB aperture GPU offset of the VRAM bo
> + * @bo:	amdgpu VRAM buffer object for which we query the offset
> + *
> + * Returns:
> + * current FB aperture GPU offset of the object.
> + */
> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo)
> +{
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	uint64_t offset, fb_base;
> +
> +	WARN_ON_ONCE(bo->tbo.resource->mem_type != TTM_PL_VRAM);
> +
> +	fb_base = adev->mmhub.funcs->get_fb_location(adev);

As discussed in the other mail thread this should probably be changed to use the cached fb_start.

Regards,
Christian.


> +	fb_base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +	offset = (bo->tbo.resource->start << PAGE_SHIFT) + fb_base;
> +	return amdgpu_gmc_sign_extend(offset);
> +}
> +
>  /**
>   * amdgpu_bo_gpu_offset_no_check - return GPU offset of bo
>   * @bo:	amdgpu object for which we query the offset
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index dcce362bfad3..c8a63e38f5d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -320,6 +320,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
>  			     bool intr);
>  int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
>  u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo);
>  u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
>  uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
>  uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index e1e658a97b36..3fc4b8e6fc59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -871,6 +871,8 @@ static int psp_tmr_init(struct psp_context *psp)
>  					      &psp->tmr_bo, &psp->tmr_mc_addr,
>  					      pptr);
>  	}
> +	if (amdgpu_virt_xgmi_migrate_enabled(psp->adev) && psp->tmr_bo)
> +		psp->tmr_mc_addr = amdgpu_bo_fb_aper_addr(psp->tmr_bo);
>  
>  	return ret;
>  }
> @@ -1270,6 +1272,11 @@ int psp_ta_load(struct psp_context *psp, struct ta_context *context)
>  	psp_copy_fw(psp, context->bin_desc.start_addr,
>  		    context->bin_desc.size_bytes);
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(psp->adev) &&
> +		context->mem_context.shared_bo)
> +		context->mem_context.shared_mc_addr =
> +			amdgpu_bo_fb_aper_addr(context->mem_context.shared_bo);
> +
>  	psp_prep_ta_load_cmd_buf(cmd, psp->fw_pri_mc_addr, context);
>  
>  	ret = psp_cmd_submit_buf(psp, NULL, cmd,
> @@ -2336,11 +2343,27 @@ bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev)
>  	return false;
>  }
>  
> +static void psp_update_gpu_addresses(struct amdgpu_device *adev)
> +{
> +	struct psp_context *psp = &adev->psp;
> +
> +	if (psp->cmd_buf_bo && psp->cmd_buf_mem) {
> +		psp->fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(psp->fw_pri_bo);
> +		psp->fence_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->fence_buf_bo);
> +		psp->cmd_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->cmd_buf_bo);
> +	}
> +	if (adev->firmware.rbuf && psp->km_ring.ring_mem)
> +		psp->km_ring.ring_mem_mc_addr = amdgpu_bo_fb_aper_addr(adev->firmware.rbuf);
> +}
> +
>  static int psp_hw_start(struct psp_context *psp)
>  {
>  	struct amdgpu_device *adev = psp->adev;
>  	int ret;
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev))
> +		psp_update_gpu_addresses(adev);
> +
>  	if (!amdgpu_sriov_vf(adev)) {
>  		if ((is_psp_fw_valid(psp->kdb)) &&
>  		    (psp->funcs->bootloader_load_kdb != NULL)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 3d9e9fdc10b4..bf9013f8d12e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1152,6 +1152,9 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
>  		adev->firmware.max_ucodes = AMDGPU_UCODE_ID_MAXIMUM;
>  	}
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev) && adev->firmware.fw_buf)
> +		adev->firmware.fw_buf_mc = amdgpu_bo_fb_aper_addr(adev->firmware.fw_buf);
> +
>  	for (i = 0; i < adev->firmware.max_ucodes; i++) {
>  		ucode = &adev->firmware.ucode[i];
>  		if (ucode->fw) {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 315b0856bf02..f9f49f37dfcd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1000,6 +1000,21 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
>  	return 0;
>  }
>  
> +static void smu_update_gpu_addresses(struct smu_context *smu)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct smu_table *pm_status_table = smu_table->tables + SMU_TABLE_PMSTATUSLOG;
> +	struct smu_table *driver_table = &(smu_table->driver_table);
> +	struct smu_table *dummy_read_1_table = &smu_table->dummy_read_1_table;
> +
> +	if (pm_status_table->bo)
> +		pm_status_table->mc_address = amdgpu_bo_fb_aper_addr(pm_status_table->bo);
> +	if (driver_table->bo)
> +		driver_table->mc_address = amdgpu_bo_fb_aper_addr(driver_table->bo);
> +	if (dummy_read_1_table->bo)
> +		dummy_read_1_table->mc_address = amdgpu_bo_fb_aper_addr(dummy_read_1_table->bo);
> +}
> +
>  /**
>   * smu_alloc_memory_pool - allocate memory pool in the system memory
>   *
> @@ -1789,6 +1804,9 @@ static int smu_start_smc_engine(struct smu_context *smu)
>  	struct amdgpu_device *adev = smu->adev;
>  	int ret = 0;
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev))
> +		smu_update_gpu_addresses(smu);
> +
>  	smu->smc_fw_state = SMU_FW_INIT;
>  
>  	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {

