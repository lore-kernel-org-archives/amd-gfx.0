Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6FFC02192
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 08:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E3B710EA41;
	Fri,  7 Feb 2025 08:08:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zum0uk/6";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8401510EA41
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 08:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7VXI3JsoNmayzT+5KwkTKkXwmuEkbbETe7p3Q/60VvCczRVbhi6SwhnVW7fh769X0bePpwAuyZvmSRKgyr/Bj48CEDVABNrVqs0kVvGL6NMV+C33ggdvuZhT0eI/0rx5EewRWzRgPDGXgG5fxWKwERFWssl8rHDfWH57nhm71br2LT2jWGIR1J8stcZq7kMqOwBdqHLEzcKSpK5zh4GwRjrQnNSFJsX0XKG4CipQZj9dYD44Rmg8Mhn5DvFWvX6wCduNyJhBUbxjMWX3qI4uY19fVLNrxpNVw1hvXgZTqDwhltnEiKbyRUYFwrIQQVd+/F129H/tRZ2uP4XdZG4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFF8weDax7xDR7nI4eSVA0br0zxWhMZ3omHOsjRjKu8=;
 b=UcNzlEkvF4sv3jYfdnaVChNczzxfUSkLbmAWVNrGHjPKPioOwEhT4niCTzmq/9Oh/olypw9AH1zijDpgr8xVe2/lq42IDb7sG4qlU17o8q2Qlk9I2Uiyewd8YwmwneROy9Ib+9HO7zCxQWaofHX7oMOlEsgLrlTFrboGQ6dYwB4GZ4kI/uC4toldhvR03WzWgbd/mWuJnKvDNNTW+OoMdDpP/lwNH7LPrMVuP7YsNs89cv5z24SXE7crkYlPh+FkP+69IyRnVViRrHug4n44sIRSnlUZ8izuKX8ub6HeUkI8jMZmTLaaVi54UZW9AHZhLyyG023ryLMcq2oppVr6YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFF8weDax7xDR7nI4eSVA0br0zxWhMZ3omHOsjRjKu8=;
 b=Zum0uk/6tAejvvgoSNpl7sTdBEfiO9pCgI0SXg0seQ9LDdizPJ2zECQsbSsu7vMFgk/WjPqefDFYmCckOdk+6oguMvl//mSZUclVefQ7oUZtY0gOCNlXgRU9r3JjKjC5UEs188ut4iuWi3cntfqQCPbHQ5id0cdkW08bK76tOyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 08:06:33 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 08:06:33 +0000
Message-ID: <046323ba-868a-4608-9ea9-aba864dc9b58@amd.com>
Date: Fri, 7 Feb 2025 13:36:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdgpu: Add amdgpu_sriov_multi_vf_mode function
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250207060320.1564404-1-Emily.Deng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250207060320.1564404-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::23) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce4ffab-ce31-415c-5466-08dd474e55dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cys3VUM5TzZLT2dmSHRwS3JVR09Vb2c0T2FXUzMyazBXZEFuYlg4T2VZTGQy?=
 =?utf-8?B?dkdYY2ZVNjJScXpoUU0xanl5K2RqR0VDSVV5a2VBMUlhTzk3Ti9vTEk1bW9p?=
 =?utf-8?B?U244SUV6azBMbzF5NGE5SldoYmRZZzFaVWtoTmE4eElrL1BiN05Lb1pxZFRQ?=
 =?utf-8?B?QTN2eklxS3VoOGJIeXpQcjZ4N2ZSMXZYTm9aSlpKQXVJWHRhN0I0dllvYmFZ?=
 =?utf-8?B?cHRRUkVqSVQ0NDFFZWJJbURNS3REeUxHTXpTNmFQSVRXRmRJSnRxOUR1M0xw?=
 =?utf-8?B?RG5xbkNLYjRXMUJKNlo4czJpRWZPR0N1bW4vcGNXS0hlbENtZDRUQlpSbzJh?=
 =?utf-8?B?SmVVUG4vL1NCdFEvallNdVp0ZEtLeUV3RnY3aTk2ZUR1dDRkS2ZYVW5LZnhV?=
 =?utf-8?B?azdMZi85eVFUbWx3V0s0VDY3OFp2RFdUOHN0ZlNPd0VaU1kyTFBuaEJ4N0ZR?=
 =?utf-8?B?NklQajRDcy9IbUdZdmNEMkpSQWZuQVRGeUl2a3pzd3VMQ21yN0dnd3o1NGNw?=
 =?utf-8?B?NjA5bklNcjR2b1BYVFNhVlZZeWhIVXVlOVkyRjJNZUpzeTY0eGdTT2xuWGdo?=
 =?utf-8?B?SmY0bWhsVnJMaXBSZU5pNXRycFdZMXgvWEcwOVozZ3BibWEwbnh2QytjMmxl?=
 =?utf-8?B?Z21SWWVmOHZHSi9WTTZJNkxYS0lHZFd0T0s3eFc3bWNBSGRJTUJacnNTOFds?=
 =?utf-8?B?dlZzWTdNUGdaTHV2bW83OFluVDBiano4TzRLWnkxaktTLzlGTExXeTdPalRY?=
 =?utf-8?B?NDBEdTZjRnVLNjlzL2tnWWEwTzYzeHFqYjNmWmdRdjA3NmR4L09kTzN0M3NO?=
 =?utf-8?B?VThNNWFYaUhGNEVwODdBQi9ETzUvSGw2ZFdPSk9WL0U2MFNCRXRxajlnb0pi?=
 =?utf-8?B?aTFaaWNSTkJyUE5JRmk2NGcvS3pNYi9SWjcvU1BIem40clo4S3EyTXFmb25o?=
 =?utf-8?B?SS84WmpXYWFFVTVRZ3JyK2hhYUxmbkNUVkNtSE15RXptRTlPN3k4bmx1ODU3?=
 =?utf-8?B?c3JRdTBIajdnZG0xTExSbEk1dkw4Sko3M3J3R3pXWUNSbGUvV0pzeTc4OVNs?=
 =?utf-8?B?Skd1bHo3bVZNMXpRRFJrU2Z5akpibEtiTENwRExQNWtLTXlvMFNlcVc0UmZN?=
 =?utf-8?B?bVlJZUR4NTRhcHA4cFA4ZWs4T29hZmRaSTNOWE15bmVZRS9pZ1RZeXpBSjhy?=
 =?utf-8?B?aTdkSzBGemRQRWY5WG1obVdraHNXVXdHb0RkREpPL3FDMjdJVGNKYmcraUVV?=
 =?utf-8?B?WG0rQVBrdFZiTk8rdlA4bVB5QVJyV252ckNVazhNQUIzdVJSRkQ1WHQ3Z1pB?=
 =?utf-8?B?Z0JpMExCd095NTY5VU5YNklvY250S3FMOGEyMW9hTG1Ba0Y4akFXbDA1Kysr?=
 =?utf-8?B?WVAyWFZBK2JSakRLZXZNU290dHAzTmZiemRDMG9YbzdOWk9TMlhBR3krQXpa?=
 =?utf-8?B?SWI5TGY1YUFrYWlMeEFwKzNxcjcrZUxGQi83M0t5dHFUVjZHTnFya0YxUmli?=
 =?utf-8?B?azREMUphcTlyMkFHSlV6Rm9USXBPVTRwNW9jL3pKNWQrbkpJL3R5RXdJbUFS?=
 =?utf-8?B?UVh2aVBKVndxcDFWYjgyQU43MENBR3dEYVdvNGhjTEhETkVWZi9UY1hTYmNn?=
 =?utf-8?B?NEk2U1Nic2JzSStQWkFUZEg2K01TSEhIVjFuWktQQlhjSDNJYUV4eEF1bkJ2?=
 =?utf-8?B?OFR6anFFTUxHd2p0UDdYckdMQUdJZXhhbEUwaHhqRisrZWFTY2NvODhTeE0y?=
 =?utf-8?B?TEVTT3dwY3hESmJEN2NiS2hOeGdwVkRiM2JhTUo1MHBEY0pwV1NaOXcxMy93?=
 =?utf-8?B?QWJTUUlMSTNOT3AwNDdCMWR2R0tOTmhHaDdTY0s4M3pKTUxETEhxRDFvWFcy?=
 =?utf-8?Q?NQ5XpAeJlbRFZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3liYkdZNkxlcW1LVXphZ3YvNW4zbGRLdmtRblowWFNvZjZaa2JMZk12cjdz?=
 =?utf-8?B?dDRBd1pQZGxFREpFbzFmZkZyVitsZld0elQxdE0rWWVMSzBRdVVTVk13cnlI?=
 =?utf-8?B?eG9wWTUrbGczMFNFeno2cjQrY05uMGgvMmxjaXE1dDQvZ1lJR2hPb09vT0Vv?=
 =?utf-8?B?YmtrQnBPbTlsYVJOWXNLejdocDBESW90Z2YxT1FFVXpkTjVGY3l2Y0x1RS8y?=
 =?utf-8?B?V2EyNTduQTBzOGN5RkZqMmFmdUMvU1NTTWwrL0FHcmhTN25zdFc3ZWpSUHlS?=
 =?utf-8?B?MjNRVFA1Y2lZMHJ1aHorV0NSZE1mdU1VZS9SQ2NEeTFPcVIvSEg0dWlDa3d4?=
 =?utf-8?B?MFYxWTNwZTVMWldPcmJhSUEvaER0NGhpTVJ6ZmhzQkhnNzljc053QXB4cVdk?=
 =?utf-8?B?R1Qwb3RTZC9SbXJtSFZSOFRyOW5pek15ekp0SC9sVkRacXVZdmJybHpacEl5?=
 =?utf-8?B?NU45RzdCcTZOdG5sQW8ybHgvZmtnTTdnU05pNVhCUHdlMWhLZTQ0QXFaMzNv?=
 =?utf-8?B?Y3ZHRXVVVDZoK0FJYWtzRzMxYTNEamU1bGF5MnpZcFh3MlZMYzdPaEF5Z3JM?=
 =?utf-8?B?U1kxdkxhN2RPZElSMG9CdjZKM3pFM2FTancvN3RpeG1yRmxmUGlhR1Z6Z2Jl?=
 =?utf-8?B?RlljSUpRZFNMOFdMYmZqeTJkOHdrOWc2bHpDM1lxR0xwZmljbXJjL3JFbnJr?=
 =?utf-8?B?S2tsaVozTE5BOGJDaStMVDVsK1dlT1VNa3hJRXBzYkUrc0xLTkxSUW1RSDc5?=
 =?utf-8?B?WjlIWCtlaWhKbno5ek5HRjd3T2llTytWSXpjZkVIRlMrb1JsbEg0aUZLSk95?=
 =?utf-8?B?WXdJZGp4NCtMcUU2OUtmd0VQMGVsLzZqcXRKMS9MZHc1NHk4YWM1eGg0Nllp?=
 =?utf-8?B?WTJ2QjFXV1NzZS9ndTV4dEFyMDA4bzVJV0lTLzZUejlLT05SOTV5Z2E3RnFa?=
 =?utf-8?B?SlcxbDZJQ3ZNaHU2d3JIeEFHMnFuU251UjlOby9KRWNEdUMzeHUzb2FKcWYy?=
 =?utf-8?B?bEdWdUdWcGs0N1hkZFZGbUJtMXBBbUdZYUdUNHZtM2doWkFhK2wyS200UGd5?=
 =?utf-8?B?SzkwcDZ2ZnVLZVI5aEpsWTBMS1Qva00rU2dRRUxIejRtWVMwNWNKSk9uQmMw?=
 =?utf-8?B?bERSY21mL0pFaFJocjhUOSttWTY2Z0NFTW1JV0loUGVqZFJiYlVRMEQ0c21h?=
 =?utf-8?B?TGhzZXZML3poUDNDM0pkOVllSHF1R2RnWG5xT1UycjRLYzhiQnc5eE96TlVk?=
 =?utf-8?B?RmlkdVdPdnRHTkZFdjZzTk5nays3UUo1TEVRU0hkRXFubVFia0I1cnJJM3Bs?=
 =?utf-8?B?U004RzJwYVB6L0VveFdwR3E3THdOeWdzQ0xRT0didVI0Ny9WNGhvNjlKT0J3?=
 =?utf-8?B?U01uNHpIaTFETjhreWdzK08rUTdjcFpmYlFLRzNvOXFpYWpBcWVzeDAvdVNC?=
 =?utf-8?B?ejFPWlZVdm0zWGRFTkZyY3FSNFZIUWRuOEF5MjF5OHdGcVNNeUQ4RUhvK0M5?=
 =?utf-8?B?VmpEN1lXZU9aU1pRVlh0dHhrbWN5U1FFYkZrYlVvMStaeVF0Q3EycjlkdEJO?=
 =?utf-8?B?Q1FDaFgyMUgyMlhhS0lKdGJ6WEtYU0xSa0VBWHhxN1p5eHR4WWw3dVhUTHly?=
 =?utf-8?B?cEp1ZXJWLzZFQ1EwQkdOZ2t6ak04dWJsek9ManVCb3NpRjZhenBqZW1uVE5Y?=
 =?utf-8?B?MWptMTBRMVZrMVM1dVhHQW5EamdST0RPMG5KakRidWEzbWtkQ1ZIVE9uUnJp?=
 =?utf-8?B?SGVGVjdzM0N5aFI3TDk5eG8zN2dOZ2JrcTR2UTJPdzZZMkZ1TFJ3b3dRSWtq?=
 =?utf-8?B?V0d5cVduQ0ltc29icC9TdUhvanloVHZiTWhnV0xyY2RFS0ZVTHF5ZC9vaFJB?=
 =?utf-8?B?VzluWnFWck4wTmM1S3BGdWFlUjU3NmtXUXhQZ1dhUDg0Q3VlRTlBbjBlQTIr?=
 =?utf-8?B?YlNwOExUcVNha1VDV1k4YmZwNnd3ZldRcnRMQzNFbGt0aFdEN0NaK1FobmxF?=
 =?utf-8?B?cUdzMVgvVTlDck5sbXdCbWFhbVFOM1o2aklQQUZheTBiMWJkSmhlanpFS3J1?=
 =?utf-8?B?SXZkaVZNTEpYZnpGOEhORFNNVFhPQ21XNmdSOEVpMi9yR1JzTlQ3T1BDQ0ox?=
 =?utf-8?Q?l//NHlyI/nEPkzZRxDhafsvDN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce4ffab-ce31-415c-5466-08dd474e55dd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 08:06:33.4279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQJ+HjXOLYLZ2mconbsHWfV5PeFjdn3TAYNOIWOb2i+spPRcu5SclY2KlFt4/3bK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176
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



On 2/7/2025 11:33 AM, Emily Deng wrote:
> Use amdgpu_sriov_multi_vf_mode to replace amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev).
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    | 2 ++
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c          | 4 ++--
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c   | 8 ++++----
>  4 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 49ca8c814455..a1450f13d963 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1990,7 +1990,7 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
>  	uint32_t max_freq, min_freq;
>  	struct amdgpu_device *adev = (struct amdgpu_device *)data;
>  
> -	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> +	if (amdgpu_sriov_multi_vf_mode(adev))
>  		return -EINVAL;
>  
>  	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 5381b8d596e6..b28082084b3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -352,6 +352,8 @@ static inline bool is_virtual_machine(void)
>  
>  #define amdgpu_sriov_is_pp_one_vf(adev) \
>  	((adev)->virt.gim_feature & AMDGIM_FEATURE_PP_ONE_VF)
> +#define amdgpu_sriov_multi_vf_mode(adev) \
> +	(amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>  #define amdgpu_sriov_is_debug(adev) \
>  	((!amdgpu_in_reset(adev)) && adev->virt.tdr_debug)
>  #define amdgpu_sriov_is_normal(adev) \
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index e8ae7681bf0a..9d8119d91f1f 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2009,7 +2009,7 @@ static int pp_od_clk_voltage_attr_update(struct amdgpu_device *adev, struct amdg
>  	/* Enable pp_od_clk_voltage node for gc 9.4.3 SRIOV/BM support */
>  	if (gc_ver == IP_VERSION(9, 4, 3) ||
>  	    gc_ver == IP_VERSION(9, 4, 4)) {
> -		if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> +		if (amdgpu_sriov_multi_vf_mode(adev))
>  			*states = ATTR_STATE_UNSUPPORTED;
>  		return 0;
>  	}
> @@ -2044,7 +2044,7 @@ static int pp_dpm_dcefclk_attr_update(struct amdgpu_device *adev, struct amdgpu_
>  	 * setting should not be allowed from VF if not in one VF mode.
>  	 */
>  	if (gc_ver >= IP_VERSION(10, 0, 0) ||
> -	    (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))) {
> +	    (amdgpu_sriov_multi_vf_mode(adev))) {
>  		dev_attr->attr.mode &= ~S_IWUGO;
>  		dev_attr->store = NULL;
>  	}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8ca793c222ff..b4bdad79221e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1825,7 +1825,7 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	struct smu_context *smu = adev->powerplay.pp_handle;
>  
> -	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
> +	if (amdgpu_sriov_multi_vf_mode(adev)) {
>  		smu->pm_enabled = false;
>  		return 0;
>  	}
> @@ -2048,7 +2048,7 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct smu_context *smu = adev->powerplay.pp_handle;
>  	int i, ret;
>  
> -	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> +	if (amdgpu_sriov_multi_vf_mode(adev))
>  		return 0;
>  
>  	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
> @@ -2116,7 +2116,7 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
>  	int ret;
>  	uint64_t count;
>  
> -	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> +	if (amdgpu_sriov_multi_vf_mode(adev))
>  		return 0;
>  
>  	if (!smu->pm_enabled)
> @@ -2152,7 +2152,7 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	struct smu_context *smu = adev->powerplay.pp_handle;
>  
> -	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
> +	if (amdgpu_sriov_multi_vf_mode(adev))
>  		return 0;
>  
>  	if (!smu->pm_enabled)

