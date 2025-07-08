Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FF1C83F09
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jul 2025 03:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7512F10E00C;
	Tue,  8 Jul 2025 03:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ARVzaT6U";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77DFE10E00C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jul 2025 03:49:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8ODRx7jJcVYjP4ZwshXWUWrJfwdGHSAjy2pPoakfXYkY/WB0AopFZal8efXQaVu/xcZHxuEQHLGGrJpyFJ0qwgIXqW+IQ/iE2/FH0IjBMF0gBOxdFbP38iHatl8V6ldjeuMZFA0A6kl4kl8xQKP6tpqXLxqv+MQbQis7nIQpI+04wfNhtXmLIT1BuwNjHMVuimfBEK/gMYOul3f1zHvm8X/NLAZnEYrql7gV2eWVYIA9gkqZGQGKTpTTn4SXJ9tCv4lhwDuc+JE2/291QR/PjNOkp4hLJDurcRJ8mD19M9P/FtlnqoANJNy4uoI00aWaI/aiTummmyqH7ywg5Ktzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LBlEkWk0zK745kc3Epk6AIXpeJUWIJaAC1D0YRKE1g=;
 b=s6FFu+i+9LlvTM+F3WzeAj7h5bFEv7bOu92ZRiCBOyEasbJE9xAN997HCpvoqI6OlKJY+xpjKQ7dr4zLSDgZXVIQiSPNdn2u8k052S0iiYC3129wlQlx7jzrQ5c8It512UqizHRWxHE8tM6/sDRqbDfGO3CJ1/oYfN0vWgoEUtQpPxhCLt+uD8aUdTLvirj4Fym1b46JI1c8Z5pqUps719GuD3adisrxUnNIHPJExZTOqMMuvIN7Tnrs4AOFl/pJWwcpzGvOiwsWS5Ul5bGvm5q9cLzfkm4QzvWeXNgTve/8TnvFzfVTfXw5t55wb5/FzzN0hDSEr2AKR75eS9W5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LBlEkWk0zK745kc3Epk6AIXpeJUWIJaAC1D0YRKE1g=;
 b=ARVzaT6UGvmdOwGxNFM0rW4Xo+Q3NtZNhzNLPHawOB9IrfCk6YQiBRSYlhA4x8ymbfDzk7L1TWeaPqR9Mo+HpRKDiU14h4UAfU0kg4IqgtMIUq1lUBojHtxN7LtX4rAwP8s3b7kqLIR9vOZ2WnZebL29RMMEHDYajkJtd/ZlTpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Tue, 8 Jul 2025 03:48:57 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8880.023; Tue, 8 Jul 2025
 03:48:57 +0000
Message-ID: <4104d342-4a3e-4b80-96df-b98f7126ffa2@amd.com>
Date: Tue, 8 Jul 2025 09:18:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/36] drm/amdgpu: clean up sdma reset functions
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, sasundar@amd.com
References: <20250707190355.837891-1-alexander.deucher@amd.com>
 <20250707190355.837891-5-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250707190355.837891-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 860d9b06-9e13-41e0-4dae-08ddbdd25ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TW5EZDBUeUVJd25rODBVTkUvK0x2b2J2RTNVNUpQQlJPcmNpby9IQWhha0NC?=
 =?utf-8?B?bVRnVWtKRVVsODFBSkRNMm5JNzNWWVNmUU9vNmRIM3FEUlJxN1lqNlVGcTQr?=
 =?utf-8?B?dGtTWWFiYWIwWW5RSFhFWU8zbndXdGdXWG5tbVh1R3Bqb1NiUkw0SXBUODNk?=
 =?utf-8?B?cG0vRlhNYkZWOU9qZkFxaGZYeDAyT1hGMFdkQ2JHdmc4aW9OTjFXN2t4MTFh?=
 =?utf-8?B?OTNmNGtiRjJNRVlmRFZ6ZmgxNDBtWVNjQ0cvRFpIL1JBVGloeTFqNmc3THg1?=
 =?utf-8?B?SmlIOGpBTzcxVksrZUxwRmpzUnBEK0h0cTVySVFYekYvSkxVMjJzMzNOajFu?=
 =?utf-8?B?eHdXd1MzanViZy9YVEIwcmsxeGJOZXUxUlNrOHNkeG82RTgvakF3RHJ3dHdo?=
 =?utf-8?B?RTlrdEx4OGxzTTlNa0xjc1NFbEFvYUxnZ1NGUzZRVWdRVm9nM05CS2JnT2k1?=
 =?utf-8?B?ZjN1NEZoSm9DZG1mTlRuZksrWGpmdjhsQXBBTmk4UzVIT1RuSldvL0crelFn?=
 =?utf-8?B?R1lXTWVGV0ZtcXZ0OENpN3Q2WDZQTDdOeFFmRXdsZGM3enZCN0lXNjZFcjJQ?=
 =?utf-8?B?Qi9TVU9zNTZPa0U4QzNSTEdjaG1uNGNmTCtORm4rRHhLck9Ub2RlVUtydW91?=
 =?utf-8?B?ajNMYmV6ekJyM2Y2WFZnZElDUUM4R2FNYXZUUDJqN1RFdzM1cGJpQ0V3amx2?=
 =?utf-8?B?NmpIc24vWDIwQ2NGdk5naE13ZkRKQ2xVZnNXVFI0VXJWL1RaOVEwMk80LzNu?=
 =?utf-8?B?RGpLcktYRHZkUTJMTnFrYW1zbVBaUzJQWDBrV3JBL04yT2xUd1JoaHE4NG5F?=
 =?utf-8?B?bXRyZkpPZDI5TzhKdE1XRk1BTEsrejZCN2xHNEhoaG1mRTljWkRBazZxQlFu?=
 =?utf-8?B?MjlFOHBEdjZqTG5UcUt5TXEveEtyQnI3RzdhUzUzM0o4bFJnMzk3UnBIYjly?=
 =?utf-8?B?akp2V091anptN3E5c2M3YVdHbDRMeWJHZ2EyRSszRlkvRnU3alhaWmY5RXEz?=
 =?utf-8?B?VGxFK0tlb21HcHVDRjZLRXBwSEJoUkVvQmdCcHkvZlBlWjZsWlRNVGdWSThB?=
 =?utf-8?B?VEVzamczcVI2QlZLeVNTVC9oREtGU3NrSTVQYVVma1Z3NzhrMCsxZytmZTQ5?=
 =?utf-8?B?eEpob2Y4V01ITFdTNlRiaHlNQUU0NjQ0MzZYeGgweWFNYXZ5TDNVUmtxbW54?=
 =?utf-8?B?cVZXRjlZS2ZiU0F5TVZZeXAvQnJNbXYvYksrSm4rN1VFdGFabVFEWDBpcHUv?=
 =?utf-8?B?LzN1MmRQTGw4YWIrM09kS1JGT1VwVmx6RDByMFNqT1pLdnRscE9zMEl3MW0v?=
 =?utf-8?B?YzdMUmp4UjdvYlphOVNRRWpoaERZSEdaVjJ5VDYvN2pETlZ1YTA4YW5nZmdZ?=
 =?utf-8?B?Q29zM0o1b2RZTm9WcFUwSWY4eVRSRjBDUHVORWZsMVdZU2tTYkFYRW9lMkE1?=
 =?utf-8?B?YkFhTU1iKzROai9UdGtLb25uNGZiNmszRGpUaXpGTzdiQ1Q5LzBlU2NFWXNs?=
 =?utf-8?B?VUZIVlNTVmZaQVdaRHNWRE9PVzYzMDBiWU56TjNBNDBHQXBrYVprc2VKSDJU?=
 =?utf-8?B?RU93NElHazdBUlE3Y3E5cHVYZDUzM2hqejNUZnJUb3pydVo5aGo3WnpxNmRu?=
 =?utf-8?B?RGRQS2U3dGxhazJOUENnME1qUlBMb3ArYW1xaWw1SjdXMUN4NlROVVhmVGhE?=
 =?utf-8?B?L3JDa00wL1FwaXpMZHN5NWVkTTc2Qm9RQ201WncwUGVvZFF6Y21lWGVpNThs?=
 =?utf-8?B?VVRHUVE5ajdNbVFoSm4yTkQvK0l0V1Jpd2dCUGthaUNTY3BHY3lRSENHTlhn?=
 =?utf-8?B?UU5DNVZWa3BzTkJnQWFDdGxjdUdKWmczWWVSaVBFdWI0bTNBUUFRU2dKZk1U?=
 =?utf-8?B?OFQ1R0VVUXBJTG1jNS9ZbkR1LzlOb1hGMmlBTFgwV0JKWU5IYnR2Q1NzdUU3?=
 =?utf-8?Q?JiIzVMPima0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEF1TU5UT2JJZUJ1RWRESW1heXYxUVB4NnErdThrZnJQaTg3elVJQVROcjF4?=
 =?utf-8?B?cUc5N0o2OFRrRG04aWRrejdFR2tQR3VFM0NDTTZ4K0c4S1FQMWUxck5hdEZP?=
 =?utf-8?B?RXMwNUp4QkZqN1RzaFZpTk1BWnozckx1M3J5TUFTZHY3WlBYY2RXUzJJZ1Zr?=
 =?utf-8?B?UnMvNy8reE9UOVh5L0xlWHYyUDFKeHpRWGVHMDIycHZSdzlwckNIOFg1L0VO?=
 =?utf-8?B?dStBdWpCZDExa2NIUnJBaUVzREJNR0ZCVVl6d21xRXlLYTh5eFhLcEtvaDRv?=
 =?utf-8?B?VGVJS0xrRTVJUm10RDZMRjRWckZXdDcvRzVQVFJsWk0wM1ZQQUxPZHVzQ0pU?=
 =?utf-8?B?ckVUQVJnMzcxbmVINDRHUkh1R29ld1FXTFdGNVFiV2tvazdsUW9IQlRQZFo3?=
 =?utf-8?B?Z2Z5NTV5bEczWU0zZTlPdER5TDJOaTVrc3l1cTZWdnpCeU5nRTB0Mm9jdlp2?=
 =?utf-8?B?Y3RpL0dYdzBVS3lwcXJoQWUzSFhKeVVKYTlLM2QrbTkwVU1GemtPL0d1QUth?=
 =?utf-8?B?NWZXTldTcHZqTjFzYUg2Q2dpdkpzTTJrenBzckllbFpQSEhCeXN3R3lDMUp6?=
 =?utf-8?B?NjVhOWMzc0VLeGRPak1zNVhDM0Z1WGNpbGNRUWMwVUorQTE3clZCNGpDcm5i?=
 =?utf-8?B?dTFKUUF2cmNLeWFKbGJ5SkQvTi94b1NISHdPUFF6WGJ2Um9Va1RES2pqZGhv?=
 =?utf-8?B?NVEzWS9iVXN5ZUx2R1RsK25qanl0eENyT1poVzJBdnVTTzduT2hIWHlBRWk2?=
 =?utf-8?B?QzZxcU5lcFU0bHJoUkhkV3Z4d1p6bUwzRjFteURrNTVqOEJWZ1hSYUtQVXlY?=
 =?utf-8?B?U0NpMG9lL3ZpNFovS3BXTEk5YlpJazMzUDlpRGVJano3YmxOaUNvUnFkZmRl?=
 =?utf-8?B?K01KYVJISnlrUW5TakZocFY3R2loTStpT1ZKaGd3SDBnZ0NyS1ZnMktPN1lk?=
 =?utf-8?B?aDZ4SGdDRlZPeHE2dXlrZmpmMDFsSUhWMGZpYy81ZFBBa3FzMXdVWXVtSGs4?=
 =?utf-8?B?V2R1UUZTN3B1bkN2ODU4UWhYQ3lTZTFMWHpObUtWM1dWZTRlYnFrNWdOMXJH?=
 =?utf-8?B?M0U5RUpYbW5CMWxFbHF2VWsxc0FEdWVNYTRyMXp6VTZHeVZScXNSQXFOTkRt?=
 =?utf-8?B?K2hvRDhqaGtjWERsUDRpbnZ4RzdjRjJTcy9kaUlnSzlxcXZ5RjhwZG9neDQw?=
 =?utf-8?B?b204VnhXYldpRnRMUGQvQzVVYUhyWnE5cll0MlFVNlJmc2VTWEJSNms2SkRC?=
 =?utf-8?B?OXZJbXBDdlhHbVFYcExRUWNLY1hkY3Mzdm1uVk51dTd2Zm4rQWdZcFE4elNB?=
 =?utf-8?B?RVhqMC8xQzhHejNrY3JSV2syV1VrcHg1WHVIWTlHYnpwUndHK0JpS1JMN1Vs?=
 =?utf-8?B?MTNmMVZtSTRXRmN4a1V0WFM5cnYrcE5EZ1JEMzNqTlE1b0gzb2Rnamd1NDlt?=
 =?utf-8?B?bUVpVjdhTlVvK3hINldsbVN1eDdnbEIzaWVLOTkwMm00aldzd1VOOE5xdEMr?=
 =?utf-8?B?T1JRMlgyRWk5MTVnV3FTMUdjSTNWK0t5d1lXY3liQ2hsVlRveTVJYU9HZElC?=
 =?utf-8?B?ZTVNN2hwb2FwNFZodWZmbis5TmF4ZnZ6Yi9FYjhmSGRad05RdjlEa2dhaTA4?=
 =?utf-8?B?cFhBNVhaaDA0NXVXamQvN0V0bWE2VnVhOTFCSVdJV05KVHF0Ky85cHZPK3FT?=
 =?utf-8?B?SjI2YmV2b3R0ajhlTENySHJzZ04zd1l4dnZYNTIvVnFBS294dXp0UUFNelZW?=
 =?utf-8?B?eDh6TUxZZW1SMlJoZHFORXcyNFNNbDkxVkVsRlN0amswbWdZMjhrY1dDdFdF?=
 =?utf-8?B?Z2Y1WllMMXN6alZ1K1BWcVA5bkI2MmRVUWk4TExsb3R1ZzV3MmREa0ZCWFUr?=
 =?utf-8?B?eHFNeVZESnU5YmNOM0htQUZlR2o1SVB0V280ZkFtV2JjM2QrQzdwdzRFMDlt?=
 =?utf-8?B?ODFZWHU3MXV3ZDVIMlhoQi91RVIvZ3BpU1pvU0Fid0VXbTNnVlhyRDdhS3BH?=
 =?utf-8?B?aVBodml3ZXgrSTBZaUN4ZkY4WWlGeVdwOWRhUU50Qk5sNEJMcnlCVlRNL01D?=
 =?utf-8?B?S2dVNE1USmFQVitYVnVibUdhNWFNMHdrRHVRejdmQ0V3VnEyNXBvQUV1SWlq?=
 =?utf-8?Q?yoEiHEwpQBnXG5I4o943/Irbv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860d9b06-9e13-41e0-4dae-08ddbdd25ddb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 03:48:57.7876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giDYJ5Np9KMjeWsamyJ5gyB03HE4kUYDBQAVHJIYhqqMwXd4Gq60w2BQAmKpJIrE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564
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



On 7/8/2025 12:33 AM, Alex Deucher wrote:
> Make them consistent and drop unneeded extra variables.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 11 +++++++++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 11 +++++++++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 13 ++++---------
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 13 ++++---------
>  4 files changed, 26 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 5a1098bdd8256..1d8ae5ef6e1c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1544,11 +1544,18 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
>  				 struct amdgpu_fence *timedout_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	u32 inst_id = ring->me;
>  	int r;
>  
> +	if (amdgpu_sriov_vf(adev))
> +		return -EINVAL;
> +

Better to wrap such checks under

if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
	return -EOPNOTSUPP;

Thanks,
Lijo

> +	if (ring->me >= adev->sdma.num_instances) {
> +		dev_err(adev->dev, "sdma instance not found\n");
> +		return -EINVAL;
> +	}
> +
>  	amdgpu_amdkfd_suspend(adev, true);
> -	r = amdgpu_sdma_reset_engine(adev, inst_id, false);
> +	r = amdgpu_sdma_reset_engine(adev, ring->me, false);
>  	amdgpu_amdkfd_resume(adev, true);
>  
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 6843c2c3d71f5..908ed8b849376 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1457,11 +1457,18 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
>  				 struct amdgpu_fence *timedout_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	u32 inst_id = ring->me;
>  	int r;
>  
> +	if (amdgpu_sriov_vf(adev))
> +		return -EINVAL;
> +
> +	if (ring->me >= adev->sdma.num_instances) {
> +		dev_err(adev->dev, "sdma instance not found\n");
> +		return -EINVAL;
> +	}
> +
>  	amdgpu_amdkfd_suspend(adev, true);
> -	r = amdgpu_sdma_reset_engine(adev, inst_id, false);
> +	r = amdgpu_sdma_reset_engine(adev, ring->me, false);
>  	amdgpu_amdkfd_resume(adev, true);
>  
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index d2effa5318176..99be92efb74c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1575,18 +1575,13 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
>  				 struct amdgpu_fence *timedout_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	int i, r;
> +	int r;
>  
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
>  
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		if (ring == &adev->sdma.instance[i].ring)
> -			break;
> -	}
> -
> -	if (i == adev->sdma.num_instances) {
> -		DRM_ERROR("sdma instance not found\n");
> +	if (ring->me >= adev->sdma.num_instances) {
> +		dev_err(adev->dev, "sdma instance not found\n");
>  		return -EINVAL;
>  	}
>  
> @@ -1596,7 +1591,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  
> -	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
> +	r = sdma_v6_0_gfx_resume_instance(adev, ring->me, true);
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 99a080bad2a3d..b79dc0a37667a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -807,18 +807,13 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
>  				 struct amdgpu_fence *timedout_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	int i, r;
> +	int r;
>  
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
>  
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		if (ring == &adev->sdma.instance[i].ring)
> -			break;
> -	}
> -
> -	if (i == adev->sdma.num_instances) {
> -		DRM_ERROR("sdma instance not found\n");
> +	if (ring->me >= adev->sdma.num_instances) {
> +		dev_err(adev->dev, "sdma instance not found\n");
>  		return -EINVAL;
>  	}
>  
> @@ -828,7 +823,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  
> -	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
> +	r = sdma_v7_0_gfx_resume_instance(adev, ring->me, true);
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);

