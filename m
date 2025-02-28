Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CF0C282C5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 22:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C57CB10ED5D;
	Fri, 28 Feb 2025 22:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="niHe7Ti3";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B9C110ED5B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 22:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdEHLtfC2nE9e6utnTlMbaiI/IMxCJP7DqmaqME3Q9/m7nYbgNAcFL6Akm5daaSvDa21/9AVJvqFl3GUeapt4cDfczjQ6mWiii+UJPkmZPHUn9aUsF9znE/4Ylv0WMCCH/SI8DFE0X6soi1wQ3Vt5RUNOR6coNmE6/YkPqkeQ4ZJpcfew+0jAVXkwZkmL4dwaEVkbZi5PofxVn4gD1PqzChbVCQLLNOarykeXCKek6ACTazn/hfwcWD845iMeGK3pwQiVYC4S7zTPsfXekH3SZ+FOOYaAn68qdU5EnSwqOI6bPXk34Urbo2k1rPK0Mg+Z2rrgrTybKEC4Yw35ca02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9whTDYO9gZPnP6IEX/luZlg2aSiBd6t02z9NNEPwVs=;
 b=C3+IfW3/g4rOAfwsa24AfApX0OtmICXsZMajoSPSeZsLGQR1K/sTzOqgSilA8k9wu3FN4mvH4ZEI2L8c+5MqCWxragjN0b58R5sPWN0MdhQLL/bfL68UTSenUo5Sx57Yg2cBhM25TwdzwiGN5oKhC1cWPSHC64ZN/hTCe+i+XvEZ6WK3X0w3wRenaCqlCA88aJx9FDb8wn7tRkDnJFh6ECMxUjNau8WvbW4r8v1WGHyfe3NjRsDt7Ha17Gr8HekSjf7WG7qQgjY4zqIhbyB8W3P74pEEnnSa5o2FiuVRujALZtw8vtD816OxMu8qpRg3vLwH9Oq22eoDOiDG45Dyfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9whTDYO9gZPnP6IEX/luZlg2aSiBd6t02z9NNEPwVs=;
 b=niHe7Ti3+o75JjJ+Afe7z6sjKl187OhMlJYihVUn/5Pjk+4xKTjqsiPE6TJS+VWxCLLgIOC41TJY3S5eXoi7l7TY8b4oNyVUPRDYkSJEwCWBbkTqa1hSjY7lFbl1gd5No+VI0ID1dYDq8Q+lHzWgPl1CpUcnMSPxfhiQybddDSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 22:04:50 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 22:04:50 +0000
Message-ID: <fc6e46e3-e302-47a9-948f-90a30aae7878@amd.com>
Date: Fri, 28 Feb 2025 15:04:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] drm/amd/display: Add a new dcdebugmask to allow
 turning off brightness curve
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250228185145.186319-1-mario.limonciello@amd.com>
 <20250228185145.186319-6-mario.limonciello@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250228185145.186319-6-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0180.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::14) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 10464ff1-35d6-4b7a-82ff-08dd5843ec20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWxmTHJuMHFnZDllWnY5UFo2U0Fnc25GTWZ6dUJpQStybDVsd21jbDg3RlVU?=
 =?utf-8?B?MXk2TVZIWUkyVXFMWGpjRW5FeWYrd3ZKYXNQazZuZFhRbUNGL0MwTjBRTk1Q?=
 =?utf-8?B?MjJFcXJ2TEtXNkZ1Y0tYTnBoNUl1OFk5YlJxOXpkNVdWbndVK3VZRnFKalZP?=
 =?utf-8?B?MDhjTDNBcHY0TEV0RjlHdlBrOUVqclY3bW1HNVdNMUhoeE5WTE1EWmtzTC9r?=
 =?utf-8?B?Nm1hdUxPVlJtcGt4a0tOLzB3RWN6d1hHazlZTWJveHFFWElZS2JqUmJHQlo2?=
 =?utf-8?B?VVdFd1JqZmZvaGEvY2FDQkxNSCtGSER2TzVWMDlTcGlSNVpsU2lOaDR4ZGZv?=
 =?utf-8?B?VjlzbEc4RzBWQUtjOXVmMm9iaHNLVXhKOS80RlE3Qy8wSWNHZkhmT3hQZEIy?=
 =?utf-8?B?S215dnNDZE1IL2dyeXNVc1RyNS9yTFdSZjhONHFXNU9jL1F4cWxTTkhLZlAr?=
 =?utf-8?B?TWxsMjNaaDN0TWpzM2s1TXhVbzU4VmlHUWYyMVViL1lXdzdyd1hraUNrS0d5?=
 =?utf-8?B?VlREUURkbWJ6a0s4VU9SVU9GRnFtbWU4cFV0SlYrUTMvNlF2NE5tTDNkRTNL?=
 =?utf-8?B?SWt6SzBWNHdJcEY2eFVXaDFrK1RyN1pzbXQ3SEJCc0MwdHZkTHdSY2Y3dm4y?=
 =?utf-8?B?ZTcraDhxSkJWUlM0d0hkcHNCUURGek1mQ2FGbUlkempMdWFEUExNeTY1Ukth?=
 =?utf-8?B?WnJBTjJlYjExOHBDWWZkdGR6OWlwcytFVmRycllXcUJyU0VkaDlkZEdQOHp1?=
 =?utf-8?B?a0dzcGFUUDlsclFNU0txR2laeHhtaDd4RTRMN3d1STBJaEtiWEM2UUpSeVBV?=
 =?utf-8?B?bi9VeHNTeVNXQW9qd1FlOVJ2NnNndkZOeWtseFlSbVEvUnZPMmk4UGIya2lD?=
 =?utf-8?B?aTY2YmZwZ2EwUFNseUI1R2xXbVBtMTYzRGp4QW8wRGJyLzR0MWRjektlWDNv?=
 =?utf-8?B?cFFueENZMVRCcDhhS1JOeEJ3ODlMRXRIM1RoYkU3N3lLSU4vS0hld1Z4MS9C?=
 =?utf-8?B?NjNJbFNlalM4NGszVzJyTHJSa2pmVkdzcXZiLzZOb2hNZ2FoMjBKenhvNnc2?=
 =?utf-8?B?aWFoUCtOOGptNkkwUXhRQnRvd09XS2VqUTR4Y1dUVFBJWWRnQ2Z5Y3ljOGVT?=
 =?utf-8?B?QTYwQkJYVkU2OHltVVBrZURsdE5XVTF0TGYycVh0VXBpT1ZreXFxRUk2WHhD?=
 =?utf-8?B?K3hGL2ZMUVlkVjJpdzhWQkxyMHhPeFEwZlI1aXNONjg2WG90dng4ZDJzaXBK?=
 =?utf-8?B?RlNxZ1JiQWM5d3VPOUJCY1BFWFJKV2ZrWVFpNzltWFR2dGMzODhMYmU4OXha?=
 =?utf-8?B?SHVFZS9OKzkxYU1Vc08zMDFodDFKNDd4QkhxVHNZckQ1TnB3c2N0MFdSbCtN?=
 =?utf-8?B?blZBaGVzSVNsL1l2cHA1Yk44ZmNYUWRGNjZNMU1HNnpJY3pxNm9lRVZneXhD?=
 =?utf-8?B?aXFXbG1CYjBQWWpJZ2d1NE5JNXJoSS9ua0h0dUN3L251QW83d1dleExLYkJj?=
 =?utf-8?B?T2N3cXA0aGEwTmFtak1ENnp2RFQ3cmt6Zm9mSnRhYytFQnZPT0pVNDM2ek5B?=
 =?utf-8?B?ZVVzUkRpOHlWdDBIZ0M4V3o4Tys2dGZFZHZDVXlYWUVyU1RsZVV1Y05adThH?=
 =?utf-8?B?WlRFakpuZmEzb051SG1EMUY0OFZLaFMwOC8reFRtelU0Q3VFZXBvY2d2QVpl?=
 =?utf-8?B?blhtclg0SWt0WndwVDZqdnFyS3l1VXRFc2xpKzZXQ0FwdFkvMG5uUE9TUUY4?=
 =?utf-8?B?SEc3S1ZqUmVyemVLS3U3S2Q5Y3ZVZy9yZG1mbDRSa0h2ekdzR0dhUDdaQ1Zp?=
 =?utf-8?B?QXE0ZlFYQWUwVk4zYkdzU2NKVEpjNVpRZU9keEFvRyt0QlhRUk0weWc1Wjlo?=
 =?utf-8?Q?90E3CB7I6flaK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGQ4SHdjSGVvWWdjNlcxeXhIOTM4RjhIb2pHWUpSNHFGRFFISlZnVnd1Nm5o?=
 =?utf-8?B?TzlFLzNQalE4MTU4OE16M2pFckd2c2RmdDlNNS9UTzQ4ZStXL3U3WnhGY2Jo?=
 =?utf-8?B?NFp6akh2MU0wNDdkWENtRlNLcWh4cFFQWlBMbTZTMldDaVdVdlRmMW5nSlc4?=
 =?utf-8?B?QXN0bXBXUDFpQzQ4WDRmdzdSZ2lRSjMxNlJodjBCS3RhN1BSOXoySEhQZ2Rk?=
 =?utf-8?B?NHN4R0dJQVhibng3UFBnMmxoeDlnUGlLVURjMldOVHlEdWFqMjRieXJpcDBY?=
 =?utf-8?B?V1Ywa1JnSElaVXB6MUpidWQ5SlpVOVNYbExuVUZFL0tJM0t6K1ZCQmxjL2tY?=
 =?utf-8?B?VGJRamYxOEp1ZnZuNEZQWVI2VWJ4N2IxbTY0MUVMWHlrOXRwU0M1QVAvL004?=
 =?utf-8?B?V2VoTjRiN2l5N0FqdUlhU01maTFaOHhESy8xaytxNE96amhQVTBNUngvcUgy?=
 =?utf-8?B?d0tsbUZKRTJtRGxRYkNmSlNjczNtaVdBSnlYNWcvY1lxMjY4WTBrbjh0Qkw1?=
 =?utf-8?B?YTVLUXBqbEQrRVhrcFAydWEwd21ad04xK0dpaHF0WWY3SHdPNEpZbys1L00v?=
 =?utf-8?B?bnQ5VmV1QmpsR1FXUWZNV3ZuV1oraENEaUVyUTlIWkFQT2RaK0VEOE8yTHp5?=
 =?utf-8?B?eGJTaE5KUEh4cHVoUEhKTlJGWm9KQnhpNDltczJYUUcxSWNBYlp0cW9MYkFH?=
 =?utf-8?B?NGVrOHJFSTBlTmlrVm1UN0EyeVd3dG4waTB3UlVzWEFOWGdyUHQ1cEROMmZE?=
 =?utf-8?B?TXNEbnNlQlQ4TTVHdHJrK2gwaEczK21MYVhnbWhqZ08rUFV5TFpPMEt0N1Bn?=
 =?utf-8?B?UUdOS3lrZi9WeEtNZmlKQmJGMUU4cnMvT0liZGNILzRrTUlhM1ZMamQvQnp6?=
 =?utf-8?B?MUg2VTJrRm9ZRGFJVHpZR2JzMjFsK1pQZEgwcjYyVURDTWd6L1dNWStaYzEw?=
 =?utf-8?B?MVB2bzJRT25KTXlOaWRWM3dXU0loRTVrMkxhekc2aFVhY0lxOVAzL3l5eVF5?=
 =?utf-8?B?UHhyOHFjdTAxNllIekZqbU1lWHVyMzJ5MHR4aVRUbmx4dUxjbWlvTll1UGRT?=
 =?utf-8?B?bGh3N2krdEtVN1UxcTlLcmFyNlR3M1NOem9EUm9hVDRwTUg3c040L0pMTUNO?=
 =?utf-8?B?aVkrejBlbEE1SXJnczZBRDlMMnpzRmk0VU4wVkUwc29oSzg2UE9wdjFOK1dN?=
 =?utf-8?B?V0U1dFJ0dEpZVzRKTEVpWXlJWUlYbnNOWTRSTythTk9ZTm1jbkFiOHNYVmJU?=
 =?utf-8?B?L0VnVldpTnhnSDFMNGxKcFFKQ21DZklvaGVFV01Icy92V2JWeGJ1d1c5L0x3?=
 =?utf-8?B?UEVjbFplcDdQQjhIR25makZuVzlLa2hKcENHeWdnYVQ4M1FNSXlUcnFaZzNa?=
 =?utf-8?B?YTJ1V05OZDZvRFZpY015ZnhXUEZ0T25SK2NoRVA0U0FFbU1odklrQTVQZVBS?=
 =?utf-8?B?dEpuYXdWZWcwRDhwRUNQQzg0Y1Z1bXluKy9GTTQrZ1ViNHkzT3d3d0ltYXh4?=
 =?utf-8?B?MEVsSkhMRzJQd1ljaFE5VHZESHNiaDFSRWNKRTVDMmQyYlJabkd1VXY4dCs4?=
 =?utf-8?B?WEd3MGs0VlJFR05aR2ZhSzl5dlM1aTRoYjBPaWYxSHpCdFMvWC9OeGhvTnBY?=
 =?utf-8?B?SndLNEZtd1dnTFMva1FKWmdUYmJqVTJRaEs3R01BenFzbEhwZUpuYkQ2TkJ4?=
 =?utf-8?B?N3V0clpQNUdDRmtpVWZyV3Npd3kxOW1uTXNMV3dRRVN2T2xnOThuQVZPRVly?=
 =?utf-8?B?bGY4QzdORVBETG4vc1NyM1VEZE5wOVFTWEx0RlB4TU5LNlYrazRYZE9EcHBo?=
 =?utf-8?B?QzBKMm9HM1V6L3hlMUFvS2pCTE5qanRZd2MvYTBDVFBaVnZwa0EzVVE0Tzlz?=
 =?utf-8?B?RlJMOXNmeWZaV3Q5UmdmTVpOZ2tPNmk2MElZSW0yREpJY3J1bXNxaWd6dzFS?=
 =?utf-8?B?UENQZzRWNEJiYXY4YTN6bVdMWDAxNXpCMVFDdmlZa01CUFgrdE5tZXZDYkpR?=
 =?utf-8?B?UkpvUmhqK1FxcnVkRmNqN2g0Y0JHODN0WUtUeTVCTHVndnRGVXNqQ2JmcXFL?=
 =?utf-8?B?aWh6Q0dZUTBZVlh0N1ZMRU9icFUzdElWaHFhYkRPNCtGdVRwN1QyZ3Q5K3Rm?=
 =?utf-8?Q?z8Wd9WgKMTmVYWyMGUHtbucpX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10464ff1-35d6-4b7a-82ff-08dd5843ec20
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 22:04:50.5318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8gdLg7mwunlLmcOS+3hcyYX9Gslcm/AK7sP0ZN5JBHVr7tcaH1ut9WuTBqGrtSLo1viFgpa3XyZ+UQ5PhVbQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2/28/25 11:51, Mario Limonciello wrote:
> Upgrading the kernel may cause some systems that were previously not using
> a firmware specified brightness curve to use one.
> 
> In the event of problems with this curve (for example an interpolation
> error) add a new dcdebugmask value that can be used to turn it off.  Also
> add an info message to show that custom brightness curves are currently in
> use.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
>   drivers/gpu/drm/amd/include/amd_shared.h          | 4 ++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b252c67f2bc4..63b66e2c9ab9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4767,6 +4767,9 @@ static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *c
>   	for (int i = 0; i < caps->data_points; i++) {
>   		u8 signal, lum;
>   
> +		if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
> +			break;
> +
>   		signal = caps->luminance_data[i].input_signal;
>   		lum = caps->luminance_data[i].luminance;
>   
> @@ -4951,6 +4954,8 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
>   	} else
>   		props.brightness = AMDGPU_MAX_BL_LEVEL;
>   
> +	if (caps.data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE))
> +		drm_info(drm, "Using custom brightness curve\n");
>   	props.max_brightness = AMDGPU_MAX_BL_LEVEL;
>   	props.type = BACKLIGHT_RAW;
>   
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index c0538763ec1a..485b713cfad0 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -354,6 +354,10 @@ enum DC_DEBUG_MASK {
>   	 * @DC_DISABLE_SUBVP: If set, disable DCN Sub-Viewport feature in amdgpu driver.
>   	 */
>   	DC_DISABLE_SUBVP = 0x20000,
> +	/**
> +	 * @DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE: If set, disable support for custom brightness curves
> +	 */
> +	DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE = 0x40000,
>   };
>   
>   enum amd_dpm_forced_level;

