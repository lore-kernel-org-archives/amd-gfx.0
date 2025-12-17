Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968A2D65C49
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 14:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A14410E790;
	Wed, 17 Dec 2025 14:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0gqd00g7";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E7C710EC6C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 14:19:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBC7xflNqEDw6+yPXgxDlt9Nz5xDVwXspWHvxmvbchDPzBszLBFtLKmkSS1o0LS/EUXR498ZsfUA1fc5ncm80CLlfAIZ4jLW1P0HcqgQfDb7xbnIxuGNcszq455tbraMCrn4hgHbYzd5k50p/ks9ZGlqxWGer2DS2lwq8MLEZtsIxZsmznbOMNc//sQFH6RbinhmvOBejRS/RnYESDTI1cJlHwOd7z5oyXj702GS/Cx7xqv1bKkLhX60jyf2ya2EJNfDekM+y0JkLogrtWuaZQ2dpNM6GIdOgKh+5tteUrjJHy0J7zsz/I2PyMVUfxL77cxaNtJvmdwlyKxSAEWS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zr5vdjqvEZQiJnnbxoAbh6uwk0LobxzsztOEtIK6G08=;
 b=LC1DJC1DdN7BCbWjOZNoEl3AZ+NxOxmcrHOgJ0Ktc7Y4lmTpIRjGRSZgW2Ro0hDMpVlimHKgEXwq6NDltONAR1P8CNcjM32h4/xFh4h+A/hwVuBSMqoC6ESJQjPFrmPkzm1gbWjiARyd4i3te0vdxTaWvadUjs+gHpPIPn3HQVbRsJyIRxUuaM9yD931c0i0lHt2t1ERmHrfC+we8XaG+Y5X70TnV0TuhIwOD77ySyfdA/HxE+cdP7SGBmUquQXXiJyynBE1maWAw0eRr6lTPbDl5CseStD2/9VZ5VNNh0YTGGLJVAKEo/7G0mbq3xMxP6PZXMVIHOu1vgqrIiRBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zr5vdjqvEZQiJnnbxoAbh6uwk0LobxzsztOEtIK6G08=;
 b=0gqd00g7t/QyQgqMUMbRN0BOUZSl9bucGWB+8YE2BDxwkbpFNGxQVKUbBivnvI+vpDfm6g5qIrUARFeTxPUgx3qCK344yk4MhBRNmv9AnsL5w22YFHcKhfVQv8nR4EQRPCHuKyR6J87gzidayTawESQEuLjTwKHySWsLeVb8drk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BN7PPF2E18BD747.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 14:19:46 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 14:19:45 +0000
Message-ID: <3c5a0186-8863-45be-80a5-30143783361a@amd.com>
Date: Wed, 17 Dec 2025 09:19:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] drm/amdkfd: Move gfx9 MQD to VRAM domain
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kent.russell@amd.com
References: <20251215165630.1172383-1-Philip.Yang@amd.com>
 <20251215165630.1172383-5-Philip.Yang@amd.com>
 <b513f97d-6d40-4ba3-acad-c882cc0bc483@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <b513f97d-6d40-4ba3-acad-c882cc0bc483@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::20) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: ba212ce2-1d61-4171-8ca9-08de3d775428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uk5adXQ3OU5yYXZLbG94b0pzdXZqVUVuSXJZVDJyMTlGUHRnNSt6NHJzalB1?=
 =?utf-8?B?UFd3dzhjOWpselBzU0Z2alh1akI2MmZUa2hVQXRuZHRHZDYvWGljaW5nY3Bx?=
 =?utf-8?B?TmN3c1Bmb01WRVpHQWgwUzlJNnNPa0kydUFwVS81ZFZNWTZxU3YrV1FCRDdK?=
 =?utf-8?B?MUwyaEJrWkd0QWdrSXpWM2RlR2VGV2gwWXpTdE1pNG1oVGtpR2FqS0JoQ3RL?=
 =?utf-8?B?TFpZOTZaRXlxNjA2SWgxTDVnSG9rcVQvVEMrRTIrbkJRQ05VeHQydnFnUVZW?=
 =?utf-8?B?OEtLb0NCWmRmU0R4ZEhKbmd0OW5BOGxoNG5SRzdBQitxRno1US9ZSHBYL3NG?=
 =?utf-8?B?eDlzVlFkZ3E1MWl1bm42bWdPU1l6WFMrVXZrUzVyQWcxUXJpWVAvVHd0YjlO?=
 =?utf-8?B?ZTcrbXg1U3JhU2lFb0lMajJmdm12NmcxdFFNdlVESGp6SU0yeEc1U1k2MGls?=
 =?utf-8?B?R05ONGdaMDY0T3U5SUFUSG9RTVFLSytRcnJ5a3k1aENjOFZuUnEzM0pOdGtw?=
 =?utf-8?B?M3Q1ZzZPZzdKaENEMjNIZjRjYXdDUDYwM3B6YXVCRTJtTGpvcEhuZGt1TVNS?=
 =?utf-8?B?bkNUdkVSUjdvT2FTbDBRMDJYb3ZYMHZOOWFvLy9Ka2JKdVQ1QnF5UlR4NHVY?=
 =?utf-8?B?QmRCVUdSN2RkQXU1T1Nub00yUWpBRllaNGJhUkdxTjlTcXVWaG1BQzhIQk5R?=
 =?utf-8?B?dVV6b2p6RDRSQkNqMWQ2bnZoeURjMVVvYTVHMFBMZTdPOWpPRlMxUFVkYk03?=
 =?utf-8?B?emRjSnRHNjlvLzhzTjFDckU4SFRjb01ZVmI3WTlyeG1wdG14Z2dPTGFnQU5H?=
 =?utf-8?B?eGl2c2UrRTlIQXhHU1o3Mnh3Vm13VWlzVnJnZEhQT2FDLzhMV3VpV1V4MFor?=
 =?utf-8?B?M3lHUFEzb3dKMU9Uc0xmWnlRSC9KdFJLOHRHM3Y4UTg1UklUOGduMHJtUjEx?=
 =?utf-8?B?YXZlaUFnU3Jobk14UE4xNzhSSlJhVmJvK0ZwZjkxVUlsNkJUSit2ekdTVG1J?=
 =?utf-8?B?VjBxcVdXRWlPUGtiVWN6Ky9UeVNOK3NkandkNFV4T2pzcXBEOWhiVFVUYmQy?=
 =?utf-8?B?V3NEK1NPNytadDlEWjV0ZEErbUdiTlhYMU5lTzFPRXZSWVUwenNuNWlsQnl0?=
 =?utf-8?B?WVc0WFFHY0NJQnhPc25EcTJLY0JLMDV0MUtOdFFuYjVpdWRJNkF5M3cxRTlw?=
 =?utf-8?B?Y3FJc3JnZ0EyN1hNUGs2Q1plaFQ1bDRXLzJRSXZRUG1TZmN1d2Z5bUVTamla?=
 =?utf-8?B?bitNVjZnVDN4NExhVW9mZkFRS01uS3lOTmFnRUhSNVFGbW9SRkxxMVJ3bTRT?=
 =?utf-8?B?SC9QbHhvY29tZ0J2allMTm5IMlY2c3JLRUUrZDJCRmdoeXZDWFR6KzhZYXBa?=
 =?utf-8?B?Wng2ZzRwS2VENXEycm9nNmpQSjBES1JuRG5hWTZqbHJUT05tM3BtSkNxS2Z2?=
 =?utf-8?B?VG9EemlCWTh1VlJScWRqN05Jb2xicEFsaGh4aWZzS1Vva3RQc2JEMFNvYU9X?=
 =?utf-8?B?dkJjdHFmVXR1bm5jbzZkeHhZejNKZS95SWlUWWRiNnFiaUg3b1doTlJhNVNx?=
 =?utf-8?B?RVFoaGg4SnE1NUI2M09xand2UktyZXBPdjlhSmpaRksremlLK2dqdFUvd2RE?=
 =?utf-8?B?clBGeGNFZU82MjQ2WXRPQ3RDTEVCTGlXWmY1MGRxd3VNdE50d1NLaGJuNGEz?=
 =?utf-8?B?cEZQcUtjS1JXWTJQQ29DTlZxVkZMYXFyMGFQd3NPbXlqMUNPcHROb3Y4NXUr?=
 =?utf-8?B?NWtHTU5ZWEVPQUphRUZhL0dRNnN3VHFWcWZ5dm1RLzRTbnZQSVRSTFMxcWly?=
 =?utf-8?B?TnZoM3h3RnNoaTY5T2pFV0tvZFZGN0RmSnhNYmdzenVDMWxsOFdyYThqUzk2?=
 =?utf-8?B?MlErREhsSDZ4RU1hdk1aSlBXTHBYRU9JSUZoUUlFM2w4SmcvNWUyV0ZRNmJX?=
 =?utf-8?Q?k8jcQNPuSCY/EmxrXJ2PJE9RqUcyZ4sP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjVEckpmY3VON1R1dGhsdkVKZVpqanZjUG5wYW1lNlp4TjdhZzRSSngwc3N3?=
 =?utf-8?B?Ui9Ta2VLQllCUlJIdy9zMFJFeDR5ZThVd2dxVmpRcUt3NzZ1aXJrV0lBM3Qx?=
 =?utf-8?B?c1l3TDk2VXFDM3NDOW44UWs2L09iKzZzOFQwUGVhOTljZ1JCV2tiZDFUamkw?=
 =?utf-8?B?bVhhQVVPUDBCSXdCOU45Ym4walN4dEdpSWllNEtJSjlUYld1aVd5ck9JNGdF?=
 =?utf-8?B?ZjJJY0hSWDZSekhVU0lnRHZRVE41bUl6UkcxRXhoY0ZYaG1PbUxFUGF2MlVG?=
 =?utf-8?B?UXp2Sk9ZYVN0RGdMOGFSM3hodHZmMUJoY3JGRVpPM1dnWlUvZVpiWXNHT2l5?=
 =?utf-8?B?QVpPS1c5ckQrdWcza0xkT0Z5bC9ocTd6aEJlRjFSZ3ArM2JabW5xRExndnN0?=
 =?utf-8?B?V1ZwTTNsQjdlcUxjU0JNM1dvUVlzcnpUNGlGME01eFRHUTBkVnFqSzc1US9k?=
 =?utf-8?B?RUczL2dTUU1pREZ4YUNtQndMNVVpakhFMWtlNUpxS2hodS94Q2tIdkFCYjJp?=
 =?utf-8?B?bnpMbUdra0pwTU05NGtNOERJMGpRajlsS1YvN2tMdmdwMjgrMWtBQ2liLzZy?=
 =?utf-8?B?dFFGaTByUUxhRmJvN2ovSHRqK05iRlJTY2Z0TzNMcktaTnNuUThqWGRjRnFF?=
 =?utf-8?B?dUM1MktES3dMN0tlc3F0cTRMbThCa1V5dGxteUdONW1wVFRpWGUyMjBuVDNu?=
 =?utf-8?B?cVFSN0dJRnkyY2M4YlVzNFJMakJOYUgyTTRoOHhDaEpLOXA4ZzFDQWVDc0Jx?=
 =?utf-8?B?TExkWGxGcmdLV3QvNzNtZGVZRlVFT1NxTW5GRUZoVzQ0M0FwMFYyOFhneTVZ?=
 =?utf-8?B?bUhYZXRueVJ0Z0RyeVl1bUJNZCtZQnVHdjdTMk40WlBJQjRwcUI0ZG5rUytR?=
 =?utf-8?B?WXNmYkNKUC9QOXV6Mys0QlZpUnNaYzlUTlpUc2lZRlpwU2c5NEZyMlFiemp0?=
 =?utf-8?B?bVJqb1B4c2Q2Z3NNSS94ZU1XcXVnS2tieVRVM2hiU0dkdXd3czUwM1gvWm1u?=
 =?utf-8?B?MUdIa0lxRE05V0tIaEtqMUltTVB6amU3dWh6eGhjUzcycHJxRUFNajdHNDdR?=
 =?utf-8?B?OW5ZUGpxQUNJemZDU3NZTldVSENlNHBCRWZGUFFBNjErZmh3SytYRVJNUXh4?=
 =?utf-8?B?MlFVVjFyNnY5Z0o2R1IzQ2xOTmx0MzhNSmRvRnZ3M2YvZ1czK0dwdFhORzgw?=
 =?utf-8?B?MlAxYk5TNW0yTUdHcXhxdGlWb1hmSWlDekNNQkxkcDBOWkNXNUdnSHBzL0FC?=
 =?utf-8?B?VXlTS25GSWFIOUhuUi9GYVJ4WXZyV3gra1dVRmF2REcyT0dibDY3VFh1K25M?=
 =?utf-8?B?dGMxSU1UZjFqMFZBYys5RytBKzA4ZUQyQk1JZEg4VWJybytnZmNwR20rNlhT?=
 =?utf-8?B?MG1hb1VhR1Y4YXdVd3p0SUFxakt2c3RKaXdlT1FNcEx3YVF3dUp1RjJOTFBW?=
 =?utf-8?B?OWRxdWViSW5GelM0cFdXYldza2VXV0h0M0ZnakJEeXNJdnNKYnBvNGF6QWw2?=
 =?utf-8?B?SE81TDFRZ1QxWXNtNG5RSnNtSVQvWmloN0drTmE2LzNnd0d0UlZSdHR6MkJN?=
 =?utf-8?B?SVp4akhSQWxIZDhUZ1VnMlRxYVUxd1hCc3JXYWVWTlV2dHZCdk8yN2NRL3NP?=
 =?utf-8?B?RjY3ZXdTNU4rQmx4S1RNN1RRMmRxV0pETXk2d3B2THVzTjJiZVpPVmxEcjVG?=
 =?utf-8?B?UXpvMFpnK2FsZHI4ZUh0VzU1Rm84SmMrZ0FpUWR3NG9USlRIQXRhMmZLbGZ3?=
 =?utf-8?B?SzJTeXZOSWwxRVdIWlQwUm5tWm9FUnpveHpmczFLVTlPeUI5RStFYkVBWHNU?=
 =?utf-8?B?aTdnV2k3T1ExR21FalFmUjlwUG9jVmVENytJenNoRStBQUxaS3dLbHdlekox?=
 =?utf-8?B?WUZ0djNkNmloa0h2MDV1OHhZV0J5SnhaQWlUNjM4b3hVOUpNNC9YRVExeE1R?=
 =?utf-8?B?VFJ5SXZaWTZYSTNld1o0WEJOU0d2aHhrRk53c0hiOFgrdHkvQjcwNnAwNzlE?=
 =?utf-8?B?ZlV3OTZJSkFGR0NaSGFxMmhPM0tsendYc1FKdjZBNjZyYk9lZjBVTTFCK3Bu?=
 =?utf-8?B?VlZBVkxsWkVIUjN5ekRhRHZHU1R5VzY4bjhTZkNGNUtDWks5TTF0ek40NVcx?=
 =?utf-8?Q?1VyU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba212ce2-1d61-4171-8ca9-08de3d775428
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 14:19:45.8360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWv+yqRUBZSKJDf6AtSrkJWlNUIti7dBuwm9tgD34iJSzCQL1ecf0/R4mf7Mx7rV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747
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



On 2025-12-16 17:27, Chen, Xiaogang wrote:
>
>
> Can this patch be stand alone ? I think it needs be combined with patch 6.
>
This patch alloc MQD on VRAM, without GART mapping, FW will access MQD 
via fb aperture address, with mtype UC. This works fine then patch 6 add 
GART mapping with mtype RW to improve performance.

> On 12/15/2025 10:56 AM, Philip Yang wrote:
>> To reduce queue switch latency further, move MQD to VRAM domain,
>> CP access MQD and control stack via FB aperture, this requires
>> contiguous pages.
>>
>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 3 ++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 090d17911bc4..113c058cf7b5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -329,7 +329,8 @@ int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
>>   	bp.size = size;
>>   	bp.byte_align = PAGE_SIZE;
>>   	bp.domain = domain;
>> -	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>> +	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>> +		   AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>
> Should bp.flags setting depend on domain type: when domain is 
> AMDGPU_GEM_DOMAIN_VRAM then bp.flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS?
>
AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS only used by VRAM buddy allocator, we 
combine GTT and VRAM allocation flags in other places too, use domain to 
decide the mm. Regards, Philip
>
> Regards
>
> Xiaogang
>
>>   	bp.type = ttm_bo_type_kernel;
>>   	bp.resv = NULL;
>>   	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> index d234db138182..14123e1a9716 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> @@ -139,7 +139,7 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>>   			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
>>   			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
>>   			NUM_XCC(node->xcc_mask),
>> -			AMDGPU_GEM_DOMAIN_GTT,
>> +			AMDGPU_GEM_DOMAIN_VRAM,
>>   			&(mqd_mem_obj->mem),
>>   			&(mqd_mem_obj->gpu_addr),
>>   			(void *)&(mqd_mem_obj->cpu_ptr), true);

