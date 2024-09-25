Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD486C369B2
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 09:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5365610E094;
	Wed, 25 Sep 2024 09:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0wuaYUoS";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAD7A10E2DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 09:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtvxGAvbgOeJpwaY6qr3JlK6Di+n4Otyx+p1nl0bCuW5DX9KGJ/Q4dCR2vnUhia4Zfd2ZqrjL6S9tVw8U/bik5hbmn4h30i9LHJtaFK8wvfoRv6l4fl1X9+8B4Hdj5c6vNKShEMQ4V3OOh6+CPEh/3W1rirVgX+qw6Rn9/pPVRfbfMkrGWMoE2z7hrBp6F25KOOgdWcgwiSN1Ho9HxCsttEVZ2bxyfWICWMNOavydu6zOIiR6IiVXKxmfdB7rbTy8aziK6c7sR47AueHCR2kPxL1x3tNhpskWwn0aEOuSOdndLMBKfrYq9KgiT1o+LygI1AD9Jwq96DkLsSVqVbWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ0jAMRgHSRN3ZpShRmDC41WIHTUD5qY7uMFTOF41j0=;
 b=yxJATDazH2jmuDg8OcC0wiwyRiyAVIyHoBx8nKbbLI4EmeaVeney6ALADi0LkdOqkRs3S+1aYtjztY+/OxXYv7rtGbu7uTnC7QijSOIJbJ8MOzE0l21Ffumbs+cvUsyJ25gZPLD0MQQ0HVHoNl9O3sdIKfLDBamxI4uu9vCzh6Z0avSRpVtQIPneqRU7SO60Dq6mjxLnyrjK3MyDgaO//dTIHQCIb4XnrhqSGYlQYnVPRiEcAD1UeUZ84LYOKg+dUPDpFlnaJyvzqfGD2JnsQ6kdFhlqzB1b98edzVl24mlguTe/Rrq/zC2JZMcJBKIR1gRyg2QBuEbblywMeUsU/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZ0jAMRgHSRN3ZpShRmDC41WIHTUD5qY7uMFTOF41j0=;
 b=0wuaYUoSanzBOCB0Cp/IVvdIBDsuo+C+a1m06i8ogmiu76pehX0qS+XXLsWl9+lCEZdb+6yGIxWnWFubmNIy2IsM5bRMchOeNXLJTWBNuGa4tlUE8Dl4lkgY83J25lp/5zM2DjmMxlP30cqu8Q8pcTqTeI/YfhiEU7pWu+90DYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 09:21:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7982.012; Wed, 25 Sep 2024
 09:21:23 +0000
Message-ID: <b64d7cae-1acc-4caf-bc9b-080abdfddcfd@amd.com>
Date: Wed, 25 Sep 2024 11:21:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: update the handle ptr in dump_ip_state
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240925035132.1887405-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240925035132.1887405-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b36c09-1ef9-49aa-766e-08dcdd436ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDFiTXNvTG8yWEtpbGVsSWkwV2FZZXI2b2dySEpnY2ttS093OHlhZGJFbG1h?=
 =?utf-8?B?TjJpUFlyL0I4anFEZ1NaNDhkRDJpMU1oYkV4Ti82SjNjdDlZZjhod0x6cHJl?=
 =?utf-8?B?aTZEWmQ3N3ppbmg5QnVoQ0puWVdtdU1tbldDeXhYbHlwRHdDRWcyeTR0MFFO?=
 =?utf-8?B?a05mYkYzak03WHVBL3YvZXp2MGp6cThkTi9xaXZHcEVFQ3pFcFhIN3ZqQTQz?=
 =?utf-8?B?U3M0bnh6c01GTzcrMmFvbDRBTjVUNU91L2VRM0ZKUGZMSWd0WWo4TnA4U0hy?=
 =?utf-8?B?em9QaTU1UDVmQVE0MHpUbDJSd0J1ZjVjVkc2Qy9FSm03dmttMEgvOU9TQTVT?=
 =?utf-8?B?Smlpa0VGV0Rvc21nNWhuNGRkeTZ3R0Y2c1ZnVVMxU3BIVFFDUDBZcTVCWUdM?=
 =?utf-8?B?dXlZNTBnRmtFVTdkZ1hkWU1XcE5sQWRaQkxzUHZPakNLK0NLN0lCQ1VqQ0Fo?=
 =?utf-8?B?MFQ3WktzTE1XMVZrWG5WU3Y4ekMxVE1nR29JWnY0WDBJeGkrUVppclRzaDFz?=
 =?utf-8?B?R0NrYXNRUTEzYm5ab2g4UHNWRUNNWTVmQzZqQ3BQOVJacFVEWFI3Y3V4aFpZ?=
 =?utf-8?B?ZUx3WFFncjlwYisvK0xRdGZkeG15dkFVWGtta21ScTVTK3lFYVZNaVZ0SHhz?=
 =?utf-8?B?TUlhVEVVcUNvMW9jazEzb21MZS9NcmZGcnc1dzhOd0dSREhMZWxiNTZYcGJG?=
 =?utf-8?B?bkVRWTgyblVYZkplT3pIbWxMQzlWZVI3akNPWEl3NEpBZTJGcW9FbWtjR2FD?=
 =?utf-8?B?QXQ3VzdodjRUQVRnRllNTWpLMkxONzk4Y0h3Y1h5WDZRd3lLcmx0ZDdyVDhF?=
 =?utf-8?B?bCtFMTNqNlZReHBFQm9vVTlpNG5QVVIweGpvRXJkTHd0K0hLZXlGWWZQMllm?=
 =?utf-8?B?Q3psWURDdmNVUmNMRm0yNVJXV3BGMktFVTZHSVNwbzMvaFI4M3FMdXhvOXVr?=
 =?utf-8?B?YkF3SmRqTWgyRzdRbVo4cXYva3lhSzZUMVVCS0RnR211QzNKeEp3WnZDRTRV?=
 =?utf-8?B?SElYQzM0WkFrR1JCRHNBcXIwMzVaVGxBa1E4R1FOTm1SOSszcXdSMWoyOU4v?=
 =?utf-8?B?cmxIbkROdCtRckZnYTZrZDc2V1ZrL1ZrbFdNQmkyUmNyeEc5Y0RuWUlEQ3FD?=
 =?utf-8?B?c2lQRmR3WVZvSkE0SzJtbVZrZkJLYzhjVk54T1RtNnF4RjUzdStRUzI5aGpM?=
 =?utf-8?B?WVdTWjlCVjVBTzYxR0ljWDgvZVZObVNIYzJ0Y05YR1l3eTZPM1JYRmVWOEp1?=
 =?utf-8?B?V3A3bWxnSitXeEZOdnMyZlgwbUpzVHZ6KzRkTXZkdDYyTzlSZ0FST1YyTVl1?=
 =?utf-8?B?TVpOQ0xWUktkNWdHZzZwUzJPNnBsSERRZTlkZTlkOVFGMCtOc2xWa2dlbGpu?=
 =?utf-8?B?RnpiZ3UyVWY2OWh3YUxjNVJMTXloZjhCVm1RUUNwOGRzYThiRGVhTUhoMmNZ?=
 =?utf-8?B?MVFHQW5oNmpqdGlWSkUzNzZENlRGNG51dS9rMjBWYmFwY2gwcDdTZFU3WU03?=
 =?utf-8?B?a2gyRlJNT21YUW16WENpUkdBeVdOSVNXU2NaTUNSZmtrK0V0Zkc3aHR1bURo?=
 =?utf-8?B?MzU5Yk5oN2lnZU1PWEpRMVZ0eHlvdWtxMDFQVmpMVktFQ09uWDJFSzVqTndk?=
 =?utf-8?B?RGhTZXNIZXNWK2VUZkNRVXVQWDIya3BORzMrckxFSkllQUFNMWFYY1FIaW5G?=
 =?utf-8?B?UlhIVlpyZS9qQ2o5N01xdnRucmFYcktYb0x3T3hEYll6eG0rU0hlay9aUGs4?=
 =?utf-8?B?VCtKWnpHd2tDUnE2dnhYek9rYVFXVXMrejhHaVNqbnV0SnBPeFdnQm1BUTNG?=
 =?utf-8?B?UzVuOERmSlFkb0l0dWtwZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NktXN2tQZWk5c21JTWhBMkw1a2YrSkNLVzhGYitSN0lDSDRSdTZzaWlkSXVM?=
 =?utf-8?B?M1VqSFBvRkJGUDFkQ3JZamxIeGdDOE03enoxV28wWU53QmlTbjhqMEZ1ODU0?=
 =?utf-8?B?Rkd6eitLd0djc29ITHZ2aGhzV2YyOXVJTkVUN2thaTZ6dTRaZXJyenpWTkpW?=
 =?utf-8?B?Z0RDK3M3a2srQ3hXS3FONGlyRWlWTjhwYTNFaytsVkZqTlNScWd0d2VLS0F5?=
 =?utf-8?B?V3lIeW9INEJlRjlGUXkzVzkwck53R1VzMzFsaXdrcGpyV3hkR3hReUV5YUcv?=
 =?utf-8?B?ek5lQzhOZHRHMUU2NlRRY0sxN0dZaWx1SXJENTVCazZZeGFkYW41akVXWG5x?=
 =?utf-8?B?czBZcFFLb2JUVUl5cFpQTHI2eHdTVjVEU3lmeTN2bUowZlM5ekZRQmdPakhQ?=
 =?utf-8?B?SG5qc1FrSzBrdXpRc1d6c1dneDB5UWV4cHZWQTVUVVR5VGlXVEFKN1RZUzhq?=
 =?utf-8?B?Q3lqZGUzTGxnc2M2YW5vMTN2UVk3NmdvY0xuQ3plOUMxcjFSSmF6cEFFQlla?=
 =?utf-8?B?QjZJMWw4cENXUGdiVTZsUUIxR091TE5nYk1rY1NnUkNCNXVPMWRHOHhQSGR0?=
 =?utf-8?B?d0t5U1IzT2tVNGpCeDdSdVg0MXJFNFVPMVd3MVE3YjFTamszYnFvVHM1cUZt?=
 =?utf-8?B?ak1KUkJzeDhLdXRCTEppOEhoZHJRclZoVkE1U2F5S2xGU0d5T2JsWDZkOWRM?=
 =?utf-8?B?RFRheGVRWG9ERVhHcVZnUEEwanppd0l0YkN5WjdQNEZyR2tFaEVNbUR2bGtU?=
 =?utf-8?B?ZlFBaVBTUlo0VmJaY0JpczJjbHJvUlk2aTRNMjN4bnRzOWlHWFYrLzh1K0cv?=
 =?utf-8?B?dW1HZ0JLTnhsZzBtQjlzaGkwY2lBMm1zZUQzQWkyMzQ2SkZDNmtpT2IrUVYr?=
 =?utf-8?B?RlMvOFVLOGtJRXFzQjY1YzVqSjhtTmg4elhGTUlJS2x0S1cxU0RXQkF1YXBq?=
 =?utf-8?B?WnV5Y2NvVDNkL1QyTmR3bFQ3Zlcyb0J3aENnKzVsSDZINEcxYXpBZ1NXZkox?=
 =?utf-8?B?cnhQTjgxRnZKRUNxcm0vTCthaHZsVE1ZaWRLT2xXemdxV2RIU2l1L3g3aUNT?=
 =?utf-8?B?VkJ2cE1oTUV2aVRIYk5sT3BQSVR6QVIxa296VjNKUTFlU1RJRm80RWFQY2xG?=
 =?utf-8?B?aE44NUI0Z3VLMHd0VjdHVnd2Z0trajQ1WnhHTjVvL2FPditmNG9DcVB6K3pk?=
 =?utf-8?B?NzBvVkptSEN1M0hmVjJHVm5venJkd2MxRVhUaDdRbHg2dEVSVGNOc0N4SUFX?=
 =?utf-8?B?a2cxRTV5OWZiM05HdTU1aFY2elAvMFIwRGtYS2tpOU1vN1BaN1RIZk55WnRZ?=
 =?utf-8?B?aTJZdGRkK2NacGxKYUJubFlkc1VsTjRrcFpQR0JTRVZXVlN6ZUVtQVA4MVNF?=
 =?utf-8?B?dkU3bTVOVDdDWEl2eGdjREVJaE5ydHB4SmJ1SnpOeDdWdEM3V3poNGh6TWtY?=
 =?utf-8?B?eTBwQm1mYkRub095RVkrYTY5S3pQajdkbWQwVXVJV0Yzb1hQWis0NUQzSWhv?=
 =?utf-8?B?eU50WHNOK3lqU0x1a08zTTNmcExvelgvMUZQU0NiU1cyMUZwdEcwOHhxNkpJ?=
 =?utf-8?B?a0dQK3ZMZ2V6bVoxQUxCZENFWEZReWNraVVzTnRsbjVjR3ByYWpqV3VBeTV4?=
 =?utf-8?B?NUZheVBDai94Q0xkZ3FaVlZNM0IycEM2aWY5NW5Rb2NHekF5YnZqbVZoTU12?=
 =?utf-8?B?VGtDeHBQVTRqR28zM2EwRGdUcjQvZmY4NURQYlNYSzlKUkRacmcrS29rQlh5?=
 =?utf-8?B?ZEJwWDB6cTdZcmxkSFFYckNMeVFsbEJ3bVBmRm5tY25pSGl1d01PTXgwTkhz?=
 =?utf-8?B?QTJNS2dZMThiaWRzVEptZkEzZHAzMXg1UFVGMHo3NHpmQURLN1IxNElZZ2pv?=
 =?utf-8?B?QVBIL1A0aFY3b3V0T0JYeUFycDRsTnpvcExRelBEeHRpOWFzUGI4ODc3ejRh?=
 =?utf-8?B?RHYvTDB4WmdkRFRWMWRWNm9ZalQ4RnBna3BDWnhIbWZEUThGU3BKOW5iZC9Q?=
 =?utf-8?B?ZU1oMUNlZ3ArMlUvaElJZjdGNzZWdkpPMngwUEJsK3JkRFgvWnVJSWM4TkZa?=
 =?utf-8?B?MkFkaExtbzFvRW4yOUNPeXdnN0dnUktISzkzZFFnb1Qrc0tCcUYremZoaG52?=
 =?utf-8?Q?HGFQBKRRm+5BW+YL31XtyaZWG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b36c09-1ef9-49aa-766e-08dcdd436ca0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 09:21:23.7424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qm6mXctmQ2/6DI/9Isz+D3DbS/XOwvIquXe3xIyCN4uf0VxmIyWKqAd8ppEXPaeb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231
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

Am 25.09.24 um 05:51 schrieb Sunil Khatri:
> Update the ptr handle to amdgpu_ip_block ptr in all
> the functions.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Both patches look like a straightforward cleanup to me.

Feel free to add Reviewed-by: Christian König <christian.koenig@amd.com> 
to the series.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c   | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c     | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c      | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c      | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c      | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c      | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c    | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c    | 4 ++--
>   drivers/gpu/drm/amd/include/amd_shared.h   | 4 +++-
>   22 files changed, 43 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c4d4fbcfca7a..c5827171b596 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5380,7 +5380,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   			for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>   				if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>   					tmp_adev->ip_blocks[i].version->funcs
> -						->dump_ip_state((void *)tmp_adev);
> +						->dump_ip_state((void *)&tmp_adev->ip_blocks[i]);
>   			dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
>   		}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 13a3604cf107..fdadbe49c913 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -42,7 +42,7 @@ static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
>   	for (i = 0; i < adev->num_ip_blocks; i++)
>   		if (adev->ip_blocks[i].version->funcs->dump_ip_state)
>   			adev->ip_blocks[i].version->funcs
> -				->dump_ip_state((void *)adev);
> +				->dump_ip_state((void *)&adev->ip_blocks[i]);
>   	dev_info(adev->dev, "Dumping IP State Completed\n");
>   
>   	amdgpu_coredump(adev, true, false, job);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 45ed97038df0..61300eb88ab4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9632,9 +9632,9 @@ static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void gfx_v10_ip_dump(void *handle)
> +static void gfx_v10_ip_dump(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	uint32_t i, j, k, reg, index = 0;
>   	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index d3e8be82a172..36dc6af70330 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6703,9 +6703,9 @@ static void gfx_v11_ip_print(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void gfx_v11_ip_dump(void *handle)
> +static void gfx_v11_ip_dump(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	uint32_t i, j, k, reg, index = 0;
>   	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_11_0);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 47b47d21f464..13baa6868a78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5102,9 +5102,9 @@ static void gfx_v12_ip_print(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void gfx_v12_ip_dump(void *handle)
> +static void gfx_v12_ip_dump(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	uint32_t i, j, k, reg, index = 0;
>   	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_0);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 23f0573ae47b..4d8db3dd3f37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7356,9 +7356,9 @@ static void gfx_v9_ip_print(void *handle, struct drm_printer *p)
>   
>   }
>   
> -static void gfx_v9_ip_dump(void *handle)
> +static void gfx_v9_ip_dump(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	uint32_t i, j, k, reg, index = 0;
>   	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_9);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index c100845409f7..f973d922e6b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -4643,9 +4643,9 @@ static void gfx_v9_4_3_ip_print(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void gfx_v9_4_3_ip_dump(void *handle)
> +static void gfx_v9_4_3_ip_dump(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	uint32_t i, j, k;
>   	uint32_t num_xcc, reg, num_inst;
>   	uint32_t xcc_id, xcc_offset, inst_offset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 23ef4eb36b40..50ad06f06c62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2371,9 +2371,9 @@ static void sdma_v4_0_print_ip_state(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void sdma_v4_0_dump_ip_state(void *handle)
> +static void sdma_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int i, j;
>   	uint32_t instance_offset;
>   	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_4_0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index c77889040760..487cc0992263 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1878,9 +1878,9 @@ static void sdma_v4_4_2_print_ip_state(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void sdma_v4_4_2_dump_ip_state(void *handle)
> +static void sdma_v4_4_2_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int i, j;
>   	uint32_t instance_offset;
>   	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_4_4_2);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 3e48ea38385d..3ecf77ce2f1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1799,9 +1799,9 @@ static void sdma_v5_0_print_ip_state(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void sdma_v5_0_dump_ip_state(void *handle)
> +static void sdma_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int i, j;
>   	uint32_t instance_offset;
>   	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_5_0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index bc9b240a3488..d19dde1d6fc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1757,9 +1757,9 @@ static void sdma_v5_2_print_ip_state(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void sdma_v5_2_dump_ip_state(void *handle)
> +static void sdma_v5_2_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int i, j;
>   	uint32_t instance_offset;
>   	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_5_2);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 581fa550ef29..ed7413c1954c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1624,9 +1624,9 @@ static void sdma_v6_0_print_ip_state(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void sdma_v6_0_dump_ip_state(void *handle)
> +static void sdma_v6_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int i, j;
>   	uint32_t instance_offset;
>   	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_6_0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index cfd8e183ad50..a69b6cf7106c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1556,9 +1556,9 @@ static void sdma_v7_0_print_ip_state(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void sdma_v7_0_dump_ip_state(void *handle)
> +static void sdma_v7_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int i, j;
>   	uint32_t instance_offset;
>   	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_7_0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index ecdfbfefd66a..78dfcd02d8da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1957,9 +1957,9 @@ static void vcn_v1_0_print_ip_state(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void vcn_v1_0_dump_ip_state(void *handle)
> +static void vcn_v1_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int i, j;
>   	bool is_powered;
>   	uint32_t inst_off;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index bfd067e2d2f1..5d6accdba480 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -2066,9 +2066,9 @@ static void vcn_v2_0_print_ip_state(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void vcn_v2_0_dump_ip_state(void *handle)
> +static void vcn_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int i, j;
>   	bool is_powered;
>   	uint32_t inst_off;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 04e9e806e318..8896c25fd1d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1958,9 +1958,9 @@ static void vcn_v2_5_print_ip_state(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void vcn_v2_5_dump_ip_state(void *handle)
> +static void vcn_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int i, j;
>   	bool is_powered;
>   	uint32_t inst_off;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 65dd68b32280..3009f52f62d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -2284,9 +2284,9 @@ static void vcn_v3_0_print_ip_state(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void vcn_v3_0_dump_ip_state(void *handle)
> +static void vcn_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int i, j;
>   	bool is_powered;
>   	uint32_t inst_off;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 26c6f10a8c8f..17ea10c14e29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -2190,9 +2190,9 @@ static void vcn_v4_0_print_ip_state(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void vcn_v4_0_dump_ip_state(void *handle)
> +static void vcn_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int i, j;
>   	bool is_powered;
>   	uint32_t inst_off;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 0fda70336300..742bf09ae195 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1765,9 +1765,9 @@ static void vcn_v4_0_3_print_ip_state(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void vcn_v4_0_3_dump_ip_state(void *handle)
> +static void vcn_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int i, j;
>   	bool is_powered;
>   	uint32_t inst_off, inst_id;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 9d4f5352a62c..3fb8b218e278 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1648,9 +1648,9 @@ static void vcn_v4_0_5_print_ip_state(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void vcn_v4_0_5_dump_ip_state(void *handle)
> +static void vcn_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int i, j;
>   	bool is_powered;
>   	uint32_t inst_off;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index c305386358b4..25ae338df346 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1375,9 +1375,9 @@ static void vcn_v5_0_print_ip_state(void *handle, struct drm_printer *p)
>   	}
>   }
>   
> -static void vcn_v5_0_dump_ip_state(void *handle)
> +static void vcn_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int i, j;
>   	bool is_powered;
>   	uint32_t inst_off;
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 3f91926a50e9..cbb19895ddaf 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -375,6 +375,8 @@ enum amd_dpm_forced_level;
>    * making calls to hooks from each IP block. This list is ordered to ensure
>    * that the driver initializes the IP blocks in a safe sequence.
>    */
> +struct amdgpu_ip_block;
> +
>   struct amd_ip_funcs {
>   	char *name;
>   	int (*early_init)(void *handle);
> @@ -399,7 +401,7 @@ struct amd_ip_funcs {
>   	int (*set_powergating_state)(void *handle,
>   				     enum amd_powergating_state state);
>   	void (*get_clockgating_state)(void *handle, u64 *flags);
> -	void (*dump_ip_state)(void *handle);
> +	void (*dump_ip_state)(struct amdgpu_ip_block *ip_block);
>   	void (*print_ip_state)(void *handle, struct drm_printer *p);
>   };
>   

