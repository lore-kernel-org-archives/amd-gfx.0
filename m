Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DAFC83F27
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 04:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F0510E24B;
	Wed, 16 Jul 2025 04:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DUNrfaus";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4245010E24B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 04:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+h9fjYCHPQ3ArcaVrDMgP1yAFlI5GVizXbDO3E1v9U2n7UpeB+uytrVd+AoC3bQh0xVswT0GqMcYbrkyfOre0w/GsMM09UQVxYqcBUlcLT+wIYx9hHsU85noExbdutu3nTOw/7EaiQ6uPZUf5WsyXycPEoZOIL7Rs/uaYXfxXfSdueOfazvucFKEiMMZtBMwH6b5co32nearuWSRFee/dZotWDmroeWGpfDOJF9gdx89DneMbmDuNoTLsj9F6A0hIaJz50mGAGYwPWcixRmIevtn8AfXEaMSt3qHmhsbMk/dALHtnzjv8IvpqDoTkUssaTAN12N2sXpWtjTXB671g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+lu/2hANdvtuo6Xw7lbBxhtJVAu2UQDmIBry5egxTI=;
 b=PRgyjuU9UwfHcfzQH2QWHdLGzXefC1HavtRowbysrRjg4QLW8ezUp7eR032gK3pmp6ItWuEtry0i6EtsDvv+6HI0sVaVAP7bRegHGle16JXTZgpytxwadZcVURpB0xPju4ewNFvpj7jEh9EgddSIaVHmLzsgNeCxB5Nc1ULVgDCJydT8v9GbBhQut/y3jxFSKFebhO2nv4T2VXYuiTTIIN8JM9uh7tLh9czfYHa06RbqtVUoiHPg0oYU3Fg8CVjVeUZeiMVphX/xvWxMfWVRIpb3fbh9bJsL52waa2u2b6IoYVltAo1cs7W523nCUl/rTQHNSNadXCzymvPsAe8/fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+lu/2hANdvtuo6Xw7lbBxhtJVAu2UQDmIBry5egxTI=;
 b=DUNrfausgU7UyqjjnHFZXWom9cncyItTQK4PQ4KRWfq1v+MC7S8jkej9O38zEpdnyLhxuhcUlvuwY9mEKKLB/s+VxBZI0TZy7CSTh+13/uxmj/3T/9M0teCO/VilHSEJzvDnMCw4g6Dbt/Jzo5K4atXUj5HrUfRSlk82ngjEpm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA5PPFDC35F96D4.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 16 Jul
 2025 04:17:40 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8880.023; Wed, 16 Jul 2025
 04:17:40 +0000
Message-ID: <6860a000-3ef1-42b2-89ee-ff176ef9ed23@amd.com>
Date: Wed, 16 Jul 2025 09:47:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for queue
 priv
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250711215122.23288-1-alexander.deucher@amd.com>
 <20250711215122.23288-2-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250711215122.23288-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA5PPFDC35F96D4:EE_
X-MS-Office365-Filtering-Correlation-Id: d473e524-bbc2-4359-3142-08ddc41fb3bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkVKUXFKNTNxUVpzQy82OTZNU0JmUEEwMUhrREg2L3VHL3JLNTFxZm1QUzRL?=
 =?utf-8?B?ekVsVkJ2Z3R2d0M3VTJ6d2tvc2I3OFRhaVA0elR0blFmeVB2SzJOcXlNRkhD?=
 =?utf-8?B?aEVyb0tNby9YWUt3bTdNeTUweVhCM3ROdmxaMUFyYVNPSEpzQ3kyNHQrVUgx?=
 =?utf-8?B?UXBQVmZvT0hRVXFuNVZsaG41bGRKUnNvNnRmSjhydkZVQnFSVXlHSXJkUHpy?=
 =?utf-8?B?UU9KVDhDZ1NuTEtpU0hYRTFHTjY3d3dYUFV2RFlZQVI1OTF1dURLMC9ybVpl?=
 =?utf-8?B?eUFWSTNOYmtQUTgwM29Td0gveDFiMFBEN0NyVElSTCtBRTluNzU3VytqY3k0?=
 =?utf-8?B?UiswT242SVlJT1VtSDdhSXROVEtJZVZ3RTFydENmVkt1STM1TnVsanM0clQ0?=
 =?utf-8?B?d29QYTVZS1BMOUdpNjIvSXV6cXBRR1dXaE5ac3E3Y1FKaG9kQXlvd0hSU084?=
 =?utf-8?B?SGRITGttbjlPUC90U203dmUxK0pCMWdwYWZwWEZaQ2JWN0I0TWlGVTkwbVJs?=
 =?utf-8?B?YlBDTXpIMnZrN05jMVhiNDFyTHJ2RVdUZ2F2UG5MaUFOeGszR1JocHBQZHFU?=
 =?utf-8?B?QXFvMXprOVJrYTZmVzZTajV6SytCeWFGQnBhY0tmVjBNQ29rbWhrVWo5c3V4?=
 =?utf-8?B?MjJDcFQ2SEFYZTNjNHdRUmd4SWQyeWZsdDhseEVrSVR3UlN6TmNnWExCYkVn?=
 =?utf-8?B?T2lsOHM3aStjQ2dQM1ZwTXl3bkxqRFBWcFIrR3E3OGF6akg4bXB1QTAySlhM?=
 =?utf-8?B?WTkvVkFSQ0RtMzI2NTY5TnFrTlcvSnVoc3pLbnhzNTkvaXFwb1RJSjF3T1hY?=
 =?utf-8?B?WEJCN1BxY3F4eE1ZaUJvdDB3T0ZXVjRQUkdoWEFZYmZBM0UzK0RIYkVRZGlv?=
 =?utf-8?B?NDE4RExZcGhZOFFZdWtOamFwdmFDaVRmT3B6QTZtUkJkYzFoTE0zaU5mTWJ5?=
 =?utf-8?B?ZytIcTU4ODJJRW40UHh4d1IybnhsZzNhb1NBdHlvTk1mUFBJS0ZodUsrdkhO?=
 =?utf-8?B?OW0vWFdTUlJ3VnpOS2ZkWFFiRWk4MDRjTkI4emMzTjA3SERVL3BhSTFobXVY?=
 =?utf-8?B?eUFIaVFuaVhwN1RQR1JsdDl0L3lrYmpXemFPVkxDMWNHS29RYitxdUVCd3ZI?=
 =?utf-8?B?RTlFVW9ibnNuM2l1eFAyaVpZYWVtZGc4MndVZlQvZVkzNEQvam5OYWtHSzR0?=
 =?utf-8?B?NXJiWFBYM0tCeW9UVmkxaFkyNG1UR0t6NEhUZGErcE41MjdaSEVHUE01YlVT?=
 =?utf-8?B?OEZSMmdYRGNJb3VIN2xnNnR1TUxkaGNRVVhWa2hPa09MdlcySE50bGVzTTlM?=
 =?utf-8?B?VXlPOU55VStUWHo3Q0NWVUhRNkEzUUtSRzd4U1RqbWgwYndzeVN0dTRCcGdI?=
 =?utf-8?B?NU9aS2h2OXBYRUZENHVmalNPaWxrb0ovVUZzOXpYMFZVTmk5djJ3b3pFZjc5?=
 =?utf-8?B?TFRtdFlvT0NxMFRYaktaQkJPTVVIYUxzQVgvNngrOG1UMFFtT0ZCWkExazFY?=
 =?utf-8?B?dlA1dWptSjhJZEVGN3pjUHB3TWZpS1JPck1LOStNMzl6aFpuc1IzUWFvcGw2?=
 =?utf-8?B?QUEzZ3NzRU93bkozTityUVZKNXRrelpjYldWaU9FV1puVHJ6SStDbGkvVG13?=
 =?utf-8?B?YmQ1aGkvT1AyZXdXRU5WaGJtZ2hUcTBZYjE5OHg5WkkzYXE3M2NuU1lGbkFp?=
 =?utf-8?B?Y04rZEQ5WE9QL2l5a2dEaDAxR3BmKzRUVExNWFY4c3AwbUVKdm9yU1F6clR5?=
 =?utf-8?B?d3pVNjkxSHBDdFFZSURUWitMVVNRVkhiMTZwenFTNW1jREFaRDZRUG9Mc1Bl?=
 =?utf-8?B?YTJHVXpJUEh5QW83YzlKMmNGQVA1V1RkNjBmZW9zUzlPMTcxVTlncEUxR1ZC?=
 =?utf-8?B?anRlR0lEUWVuKzhaRnlHYjQ4cWhVQytOVFNtdVlhTzIwTGxyWUlVV2NjZjhR?=
 =?utf-8?Q?o+fyVJE93xs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnFQa1hIVTJWT3Nwa3A4NjBPenhBRnQvUUVac1dIdGtGdzE0Nlk4RkMvaXFi?=
 =?utf-8?B?dE1wWEpYSnpXam5qS241MDZxaFluYnVGY2YyaWtzN0VSdDArSzN5UVJSNzNZ?=
 =?utf-8?B?QjJMT2dGVDA5TjVjSGdmYzhMVzBvOVZRbHBRc1NCTU9WeWxCbnFMbWlTWFVS?=
 =?utf-8?B?YnB4ODZHMnRiYUZ4SVZFQmVQTTkvZE5nWG51SSt0STRINXV4N3FoemhLb0Ns?=
 =?utf-8?B?U0hSQ1JtMFN0NVlxWkI3Yzc1WmhjQzBTTEwvak10M0dId3lnMmRaMWFSZG9O?=
 =?utf-8?B?M3BDMko4NTdPY2JHQVl2YzE3WlFCa1ZzQm9pTng2WUkyeWI4OWswMVEzN2Fj?=
 =?utf-8?B?SmtRZ0lETldFT2NKNjlTbXNTajJTZ3FNZXRRdlNOcWRnRC9nVmJFbnhvbnF5?=
 =?utf-8?B?Skd2TlZ3S2lRZW9TcDNtNzFyMHd2Rkc1aHczTS9qWVJsL0FEM3NmOG0yMTdq?=
 =?utf-8?B?dzNaNWdDaXhDWTI2dUNob1M4c1diVGwxU05kNm8zTVVNQ3dCbzFmell3L1pX?=
 =?utf-8?B?VDlpZ0FkaW5RbmNDWjhXb0QxZWdRMDdReDlJenREaktPdTI3QUhzVXZIVG5W?=
 =?utf-8?B?SlBONXpGQ3o2NWhlRjVBQTJ6YndkYU0yNXcvN2F6ZWZBNW03YUpyWE1Dc29T?=
 =?utf-8?B?eG5Jd0RWKzFKem44eXZ3cUpXOE14Rmp2dC8wZjZBUFh6TmhMbXNna3FGeDh1?=
 =?utf-8?B?SWdrYWVmVGZUa0lSQVBVYVRKV2s1dlNicTg4RnQxbUtoUlZQWWxLeWRNZDNR?=
 =?utf-8?B?aVBmRFBPRGJLWWtvZDJWSzVabzY5SDgzS2FOdmI4bVN1ZkFwQ2g2c1JUMStI?=
 =?utf-8?B?NDNpZVF6WGFUUUJuWjY0bEY0WTRRa1NkNkc3OHFwWW9YWFNQL1kvZDZ2c3BZ?=
 =?utf-8?B?clNTaXR0dmppejZ2N0VodFFCUW9hQjQ5U1FPZk9UTzBZQ2ZoeHJNVnFCMkEw?=
 =?utf-8?B?WmtJamlRZTJ4NXVJZ0tvTlVlT3hRSk52TFJESEhZS3FEL3FYL3JJa0IrWnNt?=
 =?utf-8?B?ZXlDNkh0RkdHYlhieURTT1dMYkwvSFJpTnZoZjVNSFNkbGdLelY4M2xpVUFn?=
 =?utf-8?B?WjJ4SVVML3ViNk1kTlJiVUlUSnBuaHh2TGdSenAzMW9CVU83OWtLYjBWRnA1?=
 =?utf-8?B?SExPZlZyaDdsZkdVMWp3b042YkJjbGdmOWZjc0dHV2NzWk1SZXNQV2dvd3NN?=
 =?utf-8?B?M09NQzhMZ3JMRm4wWlBzMnB3M1l4OXhRQ2k0TUZQV0JNTzhFeW8vcjZyMXl5?=
 =?utf-8?B?ck9iRUdKYXBlYWgyNTdHa2JScWsxWU92bmtocFRwYVRZSXQrTXhoVzE0bXZG?=
 =?utf-8?B?NUk0NFExWFN0ak5PRUdVcHVTV2N6dkNDb1hXV2xxK3ZYcXVlU0JrNXBsaHBN?=
 =?utf-8?B?OGRWNUlrRDd5K2VPcVJoV1o3Z0xHbXdZUE5nb21ZR2lPcmw4bWVUOVJpeXFN?=
 =?utf-8?B?UHpRU1pFK2JYT1lQbWFodXlicVJEaCtNWVBlK0x2RmRld1h5RzIyRUdzZzlM?=
 =?utf-8?B?TnVLdk5ERjFVOGlEL1oveVV2K25RSlBYc0ZOdWtGUTQ4dFBiOXJMelVNdVdy?=
 =?utf-8?B?Y1FBb1Ric05iZzhiQkUwdWZOR3l5M0h0MFJ1RmYrTGErQmphbU54RnQxNGk5?=
 =?utf-8?B?N2xLZU05cTk0Z3M3eVljZmxlRXoxeDBpYVFxdVREQ04wWVFtUG1kRGhKaVZJ?=
 =?utf-8?B?RFJWSjBBT2dSY1ZjNGlwSEhtT295cGFXOE5TeGVoby9CWXNNTVB5VzV4R1VV?=
 =?utf-8?B?THcra3ZYZmxjcXZ0empWa25JUStzWXhNK1l3cjRMdmVlYlNCYkw1TlMzcG5t?=
 =?utf-8?B?UkVzc0I2TEMrT2hIVGFjc2hQU3crYkhiTFYyaCtxd3AwNEU3TlA3empwc1Ri?=
 =?utf-8?B?RGpBVy9BZk4rUVkzMzhFbmNYdXViejdTK0dGT3lQdkRqa1BWeWI5eUVhZmhm?=
 =?utf-8?B?eHo1QWR4V29DVjNaQisrZysvSkFzMXBQZXV2Qjd1NkN1UE5wT2ZNZXBpVUtT?=
 =?utf-8?B?YmdXNEJocmJDb21BMmluNmpscWlMRTNyZk82TWx0cWU3clRNYUx4YmcrOVZn?=
 =?utf-8?B?RXIxdWM5L0dza1g5dE5HOWk5Zk9ianEvSkJpOGtnZ1dxSGJ4MmFsNVQyc0Rx?=
 =?utf-8?Q?HTZ5PslEBNWPJYb+qnIZ/usTK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d473e524-bbc2-4359-3142-08ddc41fb3bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 04:17:39.9183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJrMMhA3nanXgwm8ltrCYeO5Wu7bBcupHJPvDfE636sIJTnmTcDZdXvtCJSidCxS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFDC35F96D4
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



On 7/12/2025 3:21 AM, Alex Deucher wrote:
> Set the MQD as appropriate for the queue priv state.
> 
> Acked-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 37dcec2d07841..b9ba8b22a1073 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4124,6 +4124,8 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
>  #endif
>  	if (prop->tmz_queue)
>  		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_MATCH, 1);
> +	if (!prop->priv_queue)
> +		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_NON_PRIV, 1);
>  	mqd->cp_gfx_hqd_cntl = tmp;
>  
>  	/* set up cp_doorbell_control */
> @@ -4276,8 +4278,10 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>  	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
>  	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
>  			    prop->allow_tunneling);
> -	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
> -	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
> +	if (prop->priv_queue) {
> +		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
> +		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
> +	}

As per above logic, only kernel mode queues are supposed to be
privileged. If so, would suggest renaming the flag to kernel_q

Thanks,
Lijo

>  	if (prop->tmz_queue)
>  		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
>  	mqd->cp_hqd_pq_control = tmp;

