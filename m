Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF97CEDD96
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 13:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5BCC10E72C;
	Wed,  9 Oct 2024 13:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DzHpS9qs";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46DEB10E725
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 13:48:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3BQsqSf+GyK9LUqlQrDM1MMA7tCrdTyi4srsFXiFCIc3CEGs8BE8viZny5EPzvDHddPF3atC575/x6DL7z+CL4ZqR31d0mL12Xgcyvpg1IXC8LcETVb0l5d8OYwj/vUrwz2nUDJSX62L+mESeTAcBw/oemmgIDrvT8mwnIfMx0maA71/Jv1IFWymgWpNGqEIZCieIgqT/uHVhohptWqNsz2kT8+adRKgOWmk5FutKFBkjRJMSXIXV6GHBBQiNQxETzuhW3V3GMe4hyQJns7p/gkGN2bD+U/19jQg0AqAfh9D/w6EIWcKdCnMFrNHy63teNVfrmc8J7CVXTYAOITRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHB2Q8BQobpTtpec9rMXqLBsbxZtiXj866ovHFX72vw=;
 b=hENJIRSkYanp3/XiAKmET4JDevkIbI4VrUuF+aOQuo2zR3h9Ce9TdeRXrQ4X0hMxHmODaEKEbUPTu3qqvaH7k/++Hn/erRa5PYDJ+CR6VGwjKZ4L2DH2fkbU6MscjRrJPcmcDglPviuJ8QjbPkFDDzAGfylvEAbR7FwRhgemX5jzzmaBg7N4Br/i/6SURAjLTbgkgBbCOBY0Ain5GUtxsOvIrAbYFPSo0dZI6o8Wj7Jqe8AYuK+xbTRNGeaOssv8VQtbZiOqWme3cc480DL1aaKmzQQR4wjskN55jKtCikeRfGgqruHr/yPQ7q01mnTXZFFeL4lu2aBiD2M8vts+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHB2Q8BQobpTtpec9rMXqLBsbxZtiXj866ovHFX72vw=;
 b=DzHpS9qsfzatNPLkd3QYruBYapktN8eG799za3WAAmvFqoHGb8nJlmHL6uL1woJ2mP2yvwlV4C0y70ccF3CdFzLaDKVO9Q2w97JLpDsFohJIm4EvjkR9mDvssEsfRltxrNm6w5wXWIICn2MDMsfkHonVsndj7EDXJbuWxOI16iY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Wed, 9 Oct 2024 13:48:18 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 13:48:17 +0000
Message-ID: <5d6732cb-c5f5-46e4-8725-a290505abe47@amd.com>
Date: Wed, 9 Oct 2024 19:18:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amd/pm: Fill pcie recov cntr to metrics 1.6
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: le.ma@amd.com, hawking.zhang@amd.com, shiwu.zhang@amd.com,
 charis.poag@amd.com, donald.cheung@amd.com, sepehr.khatir@amd.com,
 daniel.oliveira@amd.com
References: <20241009121417.346166-1-asad.kamal@amd.com>
 <20241009121417.346166-2-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241009121417.346166-2-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a14122-7c8c-49df-2c18-08dce8690789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UG44OW96dG5POGxPYXJ2THZSNDZOWHBmc1BWVnMzeG8rZk4wZ1Z0eCt5aDVH?=
 =?utf-8?B?VjhnT0dLTXlxMWhaQlZRZURmN1FRL0FGU0ttYThocUtwMU9GT1VnWEQzUUpa?=
 =?utf-8?B?dmxPbnBpbWtMZW1Vb0ZON0g5NmpjY3h3OVNyS2pHQnkwUjdzZHZHNnZxZEtE?=
 =?utf-8?B?L0dwaGtLOTVhVmZHcmRRNHYzUndkRU1zZndrNC9RdElhUzNoWThNdkJuRm9M?=
 =?utf-8?B?UkNleGJaUTdxZXlhRkFtc2lyMUlTVjZ5SCtIM2VtenNWdnBOejQxcTNJNjFN?=
 =?utf-8?B?L2NaZWM1UGExTS9rUHA3Y0lhZ0VENHk2RkR4ZThISVlRL3NvYWZzN2hSblVy?=
 =?utf-8?B?eWdVdUNscFJNK2kxZm5wZjFVcVJ4UHhJcFJZNjVDaGlQQTQ2cEtzL2Y4RkQr?=
 =?utf-8?B?Z05yOVhJWCtSSitMS1p1ZGpPVEFOVklKMmwwek1GemYyVE54RUtNMnJsbmtU?=
 =?utf-8?B?NktKUHFaZkk0VWMyMHc1MDA1K3JoVmFhdXk2R2ViU0FJcnFjdml2cmpkRWRF?=
 =?utf-8?B?MS9pbWk5RDVKSHMrSnZLV0xrWlFLcDdkK0RCQUVZQUhBSzgrcjI5V0l6ZFU0?=
 =?utf-8?B?a28rN1dDZ2lveUs5YjBCbnZSOVZnVUtuMW9IVG81TENGa2JCRHlObnRrcWNz?=
 =?utf-8?B?cVgyRE1JOFBrQ2dwVnF4bFo0S3ZKYW5Kb2dYNWszMXRWd1F1ck9kb3o0M2dj?=
 =?utf-8?B?NVRHMUQwVjhlTkZxNU5Yb3ZvbmZtbXVtQ0lzL2dQRHQ4SHlGOEtZRTFEVElp?=
 =?utf-8?B?Z0Y1eERnRVM5T1lFZHljWHlHS0VZWit3WnRHUDZxWHliNnFyb3hUdU9oTjJ5?=
 =?utf-8?B?S0dPbUREN21rdlJINHFNYzU2Z2RRNCtMRlAyUk1ySjNVVGNpbVdHenVaZkds?=
 =?utf-8?B?NmVkR2U4NWs0b211QkJCbkowSmtmZ2FrMmwvWmI5OWxoWnpDMzF4bTQvMko1?=
 =?utf-8?B?OFZMTm1hTTZ2a1M5YjNyYkxKSTA0UFYxY2s5Q2xuamI1WG9PMGdLYStLSzdz?=
 =?utf-8?B?MmFoRElmQXp3eTZxWmNld0dIcnhkYjM4a1NJcEpNUnRmUk5IK2hWVWZYREpv?=
 =?utf-8?B?VHUwZ0FQY0JybGhRcnptaUw4NG05KzIyenlVVjVZcTE3NGF2STE5dEdCWWVX?=
 =?utf-8?B?WjlkdlRKdzVvVStIU05ZMU0vVWxUYmhCeFJIWS8vQXMxVGZSZWRNZW5WVkJz?=
 =?utf-8?B?a1J4VU0rQ1BvaXNCUGQ2Q1ZjSk9CK2JZdXNTSzE0NHZQSExhWFBZc3FyMm5s?=
 =?utf-8?B?UXFSM3AxMWw0UThTVllMNkxQOFREeGxHZC9PQnhJbFJvVVl1c0tBRFdLSmpG?=
 =?utf-8?B?cThQM2pBRXJGWWlIMnkzSkN4LytoL2liZGNFeW5TTmxCUmMrNXBHUG9iU3k5?=
 =?utf-8?B?dHJ6aEt0UTdYeWZ0YURzZ3VpQWt2MDJaZDFNL2k0MDI3a3E1MWdwKzZMM0pi?=
 =?utf-8?B?VGJzWTNPcEdWL3J3UkRXTm9rYUhnV2k4MGYrVkhVVXU3KzkyL1hvTW5uQU9K?=
 =?utf-8?B?cmRjK1VrbnJObitHYVVLZmtDem9CVHQ1anpQU0dWZWU4Z0FSSjlmajBGOWxO?=
 =?utf-8?B?RnFTTG1NU2FSMW0yampWVGhPZHQxemNGWlRQQ2JUU3V4TTRwenJHNVNqZlNZ?=
 =?utf-8?B?N2hjTzVtVlJ1TmRQNzZZQjM0ajVselV0bmcwUkR5UkFkSnl4Z2FuSGE4NUdI?=
 =?utf-8?B?c1lzRVkzQXB3dmN3S1F6TVZibUtkUGt6VkxTVnRnWExPUmlQUXV6c0VnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmpKc2FQODgzZ1VoSmFGK0plSG9haC9nTExnT2d5T2IyKzdteFZHVndoS1JN?=
 =?utf-8?B?c29HZE4vMEVyNkRqazJubGNhbCt5L0d6Umt4MUNGczdRKzR2ZWg3OUljd3NM?=
 =?utf-8?B?Ti84RkNnV1hHVUhybTFCVDM2UGhxK0ZTMTJsUmhjaDgyV0JKN1pCTXkycW14?=
 =?utf-8?B?aDByUFc2K0tKcE56UkZrZVNyd2pzeGdpQncvZzJYMGpYQUVMZ2ZtRDd4Q3d1?=
 =?utf-8?B?Qkw1Z3BvcmtCZzEvandvV2JqTHkyOS9kTlpuTGxjWktqTmIyQTJ1d2tDV1BQ?=
 =?utf-8?B?dmNkbWMra2xIbXgyV3NVNnJNeUVKRXVIR05venVxWjVmVUpqTld5d2ZOZXpD?=
 =?utf-8?B?UEVETS9yaC9NSXhTWitqRlc1Q1Z5RkVJK0VxbmRsR2ZRMnZydEVkcjUyOUJQ?=
 =?utf-8?B?ai9sejlaYkEyWWcxMDRYNlZnZzd0RnRaSVRidDVCME5KK1BOMTR6MjJYTWFq?=
 =?utf-8?B?Q0ZFVjRjSll2YUxjL1pPQjNPWkdhUm93Z3ZldjFEdjVDSklmcVN6d1MyNGI2?=
 =?utf-8?B?SVFpUlE3bm5YVlJVdjN2VU5KTk1lMVNQVnpGZ3YvclhubVpDdFRZYVR0a1Er?=
 =?utf-8?B?a3ZRMUVBNU1HcEp1SlBsYmllV1J6NENBemF6TTRCS0NVc2RXNWhQRUFHdEhB?=
 =?utf-8?B?dTdmeTBDVUhFU1NHSk4vMG5GblMrcmEyVWd2bXQ3eEJKaXltS3VNUy94UzRR?=
 =?utf-8?B?M0o1cmVvWEdVajdteUhYenYremV2dGxqeXhIQVRFc0hYZkVXN2RHTFYydlhl?=
 =?utf-8?B?Zkdab1BZY0taM3FNbDlMWlF4djRKK3pYU3BBc2NsME5lY3F6T0RlOFdtdG1D?=
 =?utf-8?B?TmRqWTIxa3dNcEZZWHRJUGcxSzhLQXpUM3d2YVVVcklrUHBYVVhiUGZ5cGZm?=
 =?utf-8?B?by9mM3hBQThsOE55WUtKSW1MamRSSlUyK3FGOTlabjA4K0p6Y2lJUC9BTUxa?=
 =?utf-8?B?b0t1NVFnYldxQUd1S0VuL2h6S0Y4bkFjOCs5RGNQZURkSk11ZDlwWGxqbzhh?=
 =?utf-8?B?cHRhYnQyWG51WXVNN01BdHVJQ2ZDa0lWbXZyWlE1ODU5YlMySG9sY0pkdnc4?=
 =?utf-8?B?UFN6NmtpdGRWdHg4TkJqcGk1eklqM0FmVm9IaFFZUmMwRFFCcDBHd0ZNKzdT?=
 =?utf-8?B?QkVNSEwrN3Z1ZHBlVXlsV3BvWFRGRU1yalZjMXZIOTROUWI0ODkyTGpsc3Qy?=
 =?utf-8?B?cFZoSEU5WjFYaG1zbE92MmE4MmlydnVUN25VWmNSTGl2eHhic2Y5ZEppZkRq?=
 =?utf-8?B?VSt6UnhJdnZkK1MrWHp2bklzNVVqdGpPbEdIQzk0N2ozRW9NY1pRaE4waHla?=
 =?utf-8?B?alI5bEhwUXNlM0VPLzliUmhWV2xBOGdhbURyc3QzWUc1NXVaNVNXM3lnSVMx?=
 =?utf-8?B?RUpBREU5azc3cllFUVhjZklEQllxcWFFSUJFVFZ4YWVyWFpWU21wT0NVYVdZ?=
 =?utf-8?B?Y25NU1gyL0Z0dVlTNjFCSEt1STFRbC9MWUY2dlJqVFpyL1gwVmpyU05GZUdR?=
 =?utf-8?B?MFh1bVF5b2xSRFM5WTRwMDZ0TGhVZklpT3BtZ0dBMi9UeHpYMnFSd0NWRlhU?=
 =?utf-8?B?by91UFYvdy90RmExLzVpeVAzMG8vdlFBdFRuQkNmellDZEY2cUpVQlpRL1BQ?=
 =?utf-8?B?cGJFNU1wWDJTMlFKMFV5cDA4MkNpQXQ1WUVIZkNzc1loaHZydStrcnEzMFQz?=
 =?utf-8?B?ODdZNTdPQ0xrZUNHengvbmc5dnBtNmpadFBrVUFDMmNEZVNCU09RVS85K1Vx?=
 =?utf-8?B?ZnRRQ1NsM1BBZm11bC9TZXhPZGhNVHd4blBSck1XcWJFdTBXaGRVcUpCRnFB?=
 =?utf-8?B?eXdxM2dPeDZsdVpFc0xOaGY0OWZjaGhjWktyY0VaVzZNQ1hCTHgvWVVoMVBt?=
 =?utf-8?B?cC9KM0JWNUJQNFArN1NFU05lUXBwRW94K29sVXhvSURZbWFPMkFPcDducFNj?=
 =?utf-8?B?bXI5dWljdkdRWXcyV0kyMG9pQWxJNE9UREo5cGRhaUNxN3Jwc0VpMVFPVVc2?=
 =?utf-8?B?Z3hCYUJvUmVONkZkZ3dQRnVvbW12UUg4RzU5elFjck4vOHBNaHQzampjL1B5?=
 =?utf-8?B?dTlwTUJsb1ppWUFGWXh3dmwyTTU1ZmIwdVJUN0JuSEl3VGN0RzQrRndKZFJh?=
 =?utf-8?Q?uaOIZRkKw4xMZ8UWddoz+Kyxl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a14122-7c8c-49df-2c18-08dce8690789
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 13:48:17.9085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pK+SjpZZvWxTQPh534YyzPafj1DZ58iXL8uVinXkOR91StIpWvys2n+P1yLFpsAJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275
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



On 10/9/2024 5:44 PM, Asad Kamal wrote:
> Fill pcie other end recovery counter to metrics 1.6
> 
> v2: Add separate function to check recovery counter support
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 52f3c537bb3f..91297590f006 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -108,6 +108,18 @@ static inline bool smu_v13_0_6_is_unified_metrics(struct smu_context *smu)
>  		smu->smc_fw_version <= 0x4556900;
>  }
>  
> +static inline bool smu_v13_0_6_is_other_end_count_available(struct smu_context *smu)
> +{
> +	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
> +	case IP_VERSION(13, 0, 6):
> +		return smu->smc_fw_version >= 0x557600;
> +	case IP_VERSION(13, 0, 14):
> +		return smu->smc_fw_version >= 0x05550E00;
> +	default:
> +		return false;
> +	}

Not sure if some automated script checkers or additional warning flags
will complain of missing return statement.

Series is -
	
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +}
> +
>  struct mca_bank_ipid {
>  	enum amdgpu_mca_ip ip;
>  	uint16_t hwid;
> @@ -2417,6 +2429,10 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  				metrics_x->PCIeNAKSentCountAcc;
>  		gpu_metrics->pcie_nak_rcvd_count_acc =
>  				metrics_x->PCIeNAKReceivedCountAcc;
> +		if (smu_v13_0_6_is_other_end_count_available(smu))
> +			gpu_metrics->pcie_lc_perf_other_end_recovery =
> +				metrics_x->PCIeOtherEndRecoveryAcc;
> +
>  	}
>  
>  	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
