Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123ACFF60C2
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 04:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B91010E861;
	Tue, 31 Mar 2026 04:52:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jTVS1Of+";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 360E210E85C
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 04:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KW+J/EZii5yONqHxzPiWFaSWgMym8IjRxTe6L9IeWLmqk7XpE3Gtp4+6cFsxUubCums/aVJK5ggDTBQBE+W41NAHjwiNxCK8C12U6nsyqSD9kycH4iqVPqFEtKOzj98wlzi231v5UgdGfOfngXFihNSQI1HQzLoFinOiNnesVl17X0OpyeBis3kLD3+26Nbgp0oiUm9PcZcDIq9BV6h5gTsNSZOakTJLOB1d/F5pz37K64FYQ0Y/KOB3ISN6aySdOGd42FNqjTlTSylJCMnfQHRB0drZ4qeJT6MBjvTM4GvDs3A7/1PPjeJvMAHA8xV0Bet9JzW9Xfq1ClO5bwkM7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bfsJpOwd5ceUAoW6T2H5C8HaHq7MNoO0SEDmQZIF1k=;
 b=sxmiCwp5NPli4avNS3HbIBTYWrUCx+uhi/7p1m5t2ibVMMveATOKd3YTFyTe/3N+IqiX/2911I8mmO89iWznimUxHHfXjnc5igUz30OrLuqr4VouPTl/C7yGND5Ato8ZomEvBOb3EX4cvTukY+tIN+dxvbya9GnSp5LgttI63Z6UuLLOvXZlQUZjco0UEmNTKMckIthUojYvHaylXkPzn9ky+7Uqg2iyg428/5Y1+WSlNJYWSLHu0EtJQo7oQV5s1cbpfazta+hvSKlq7BCse+kztgsrE1U93pmkEqRHxI7WMMIzxvtacch9nCTYM9Dk3xUZu+WSBxFpgrM8XtCEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bfsJpOwd5ceUAoW6T2H5C8HaHq7MNoO0SEDmQZIF1k=;
 b=jTVS1Of+Xkh722R67MEpVSA2gJ+COrXzcDYZS0c7lkJ/JuACi3ZeBsP2aS8iFZ1Dq0vbOXbNilyZLKiPJ+pe+0ypBpo001HQLznb8jl6r9xjMuR1A6N9fZdRgA3LwboBKYUehs3TpOs3mnrEXN2pAATVWs9oEz1JghWQ9VWIvYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 04:51:54 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 04:51:54 +0000
Message-ID: <26555f66-5679-44b1-aa12-482272b5d6d0@amd.com>
Date: Tue, 31 Mar 2026 10:21:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amd/pm: Add smu vram copy function
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com
References: <20260327075231.1413092-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20260327075231.1413092-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:275::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b82c54e-6789-4a57-771b-08de8ee13ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 8xQDNz+JRSVxt/cmbDf43dyLpydp1P3Gyu7N2nw3LtIobiylHk1vsyKwCP6Rj7J4602aqqPJaIiYAifYpvPM2i1G+fxd3KuUHl1q4ABk2wm8xHy54mkwPMbg5pw9kftze3RDtQo0I0jGLCUfMhUqfVGFBeRPeuTSW37we1WcEYf6GxHcY+yWMMmvL89S9udDs1w3MGj8iLqHKNHnAQZi4qDjSPd+SlP4ZTZT8kiNKJtXbZzB7nJV+Qs7K0eVo0BpLlbs+TF/dqV7VkbAvrPzZiD13prrak356PaTk2laAYU6yAI9hbs6hOMVVn1YCZKzPt5NBVbll3mG/XIEgIMdmlGuD3wZc58PBIbHw9KOONUNXrB1yMGh1hMLPSCy+aCJ6g4FXm8U7ryB7VhbknifmIslxyMgjJsgOhL4/j/9wvIBF0y6P15NaCYyDYq99w8YFmC8l6SZ0jWNAjvgNXP1MT3dCwpQL/lU37yEwnVHkvuYqKdqGIEJmLQnZSe5o50Y/1w11+JNSlsorvhRlF0UhuLwJG9p9sJwJFN1CMOh/cUU6F2MGvSYlKSxOCUgma5BoKwrZ3yoIgkPkEIqlJbARPBQs7ZgvitFPUj7HeG9T12P6DS5hKqjOw4deLy/bwO/x8t833GdFCoAe6dPaH+3vD/l95bDZZOAjT0GnKXj4UTD8JkQ/ieoR4L8SAnE9np+AiLvXOT9yza/jiEwJ1h4Vx2HCGh/cqmIQre3nKSVsig=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG1zN1RLMCt2djJwOElTVEsrSG4wM2thUW5BQ1ZERWN5MzJqMmpWb1kyZHpD?=
 =?utf-8?B?dVVRbzl1UmNxZ0QvdGtXSWpBVDZRaE9SNVBNdGtWalFSdkxXTTA4VzZXUVE3?=
 =?utf-8?B?MlR3cGJVNmxpeFNySDJIOVVHTU15ejJmTk9MYUlwOWtBQ2lvWm91U25PYUxh?=
 =?utf-8?B?cHNOaWpkY0c1Q1R2Rmw5MU5MTVJPV0xKakh2a0xYRnpnL2s4aGNyZUZ4eUph?=
 =?utf-8?B?L1JRQUxGdURuUVpWUjlJMHQyYVZOa1pkTHFtQ2llYUZXRmlSUUU0TllSMjdU?=
 =?utf-8?B?YkpEbkZONUVCeWlLOTZscGpiQWQwN3JxRWUxZXVCQUxQa095cWRkeVE0MjY5?=
 =?utf-8?B?Zm0xYTE3VmdnQTRPMW9mVWFobDJsZmg3L2RzQWRzYm0zeHZZb2RTdUVyTDU2?=
 =?utf-8?B?OXZGcFZYbDBCdlBNeUZhbUxHMmZzSUljY0pNZ1hDbnNFdGJmcnZXb1NpSld1?=
 =?utf-8?B?WGMrZ0lYaVF5MmRIZlVBdklleXc5ekdKR1N2U1pUWmpySEhKZ0pEeCs2ZmhU?=
 =?utf-8?B?dGNtaVBMK2UzYzFsS3ZvYVhwSVpnRmQ4OVczR3p6bmRWczdrTXdWQmFWaXdP?=
 =?utf-8?B?bHNPR0lYRitaUXJWblovd041ajh3VGlMMW11b2x1N3lpNXl5US9nV0U3Umtq?=
 =?utf-8?B?NStYMWFKQnVaWUF6bGNCcHRpSDlRNlpPeVdnbXRLNWY1RUlBelV3T1FqVThE?=
 =?utf-8?B?cjlaVDZxVFptckpIYStQcW5IVS95V0JKbmZHYlZKSjdKczhrUGtZZTlLdTVs?=
 =?utf-8?B?c09oTWhhZ0lhd3NPRTVZYzM3OGpBRUhpdXpFODYzek9ESXBHT25CV1VRYWJh?=
 =?utf-8?B?RS91S2IxcHM5cGluMlFYTUhxMVkzWkJ6cUx1QW1HZWh4aDIxbW1LUzdsdE5v?=
 =?utf-8?B?ZUcxU01sUnlYWXpBajh0bmhkN1lYenZkaHdXY0s1WXFleUhaWk8zTlBoYWhX?=
 =?utf-8?B?N28zWXJkaGR2bys5NXkrcTdWSng3UkZFSGp4K09KNzJSREZyR3JSK2xaN0RH?=
 =?utf-8?B?K3B6Myt6Q0xwNDM3WThiZUJQZ1VKaXRnaHloWjRwK0pWeVBPL3BKOUcrS0o2?=
 =?utf-8?B?blBjcmJLTkxqcy9mR2E1R2UyeFRXMzVnNG5CZW9tZWhRYTZhM2k2bmtwaXZZ?=
 =?utf-8?B?UlRIaElXc1JKeFJYRDhVLzYzYWg2S0J3elN1UTU4RzNjekxhc1FiY0F0T2JZ?=
 =?utf-8?B?NW5ncTlsY25sQ3ZjdlMrVWxJQXpuTzVWWnBZbHVYZERKOStOdXZxT1c5OFJJ?=
 =?utf-8?B?aGlQRmk3SFFnNThLdzVDRzlCWjVZYWplTmd0ZDFUTzFvbm1VTWZGRVdwdXpv?=
 =?utf-8?B?bm0wdW5CcFJUK0xiYld1QlVhcFZlWi9KSkt0REtjY1JJclN5dE91amJCRWtN?=
 =?utf-8?B?R05SYTA1U3F0ekFyNTNxZDAyYXFTU1R1T3hOTDF1S2tvU01GTXpuR0RVajlj?=
 =?utf-8?B?ODNZbDU2a2hIejltUFM2VE0zYjQvODJZSkowNWFXVHY2RU9CZTMrYXRsLzBh?=
 =?utf-8?B?R2Z6bkRtdjUzbmpLaU81TEFMbStwaG5NSVRJS2lzT0ZCTVA1NzUyZXkxSUZT?=
 =?utf-8?B?YmNlOURlUkFJWnh1K0NGaC9SVWJKLzhoTmk5Tmkrb3VFenR6YXVDMEl0NHBv?=
 =?utf-8?B?Wk9BVTRaTEF6M2VmQlQ2MytDbHo0dzBtWSs1eXdpeUlnaWtaVzBHOFFjdnBN?=
 =?utf-8?B?TGVFeXQzVlRWNXRkK1I0c1hYcVlSV25CTElBQ21CSS9LN3RTRXlwWk15d1Fy?=
 =?utf-8?B?d2tia0ZBSXVPWDh2dTN1MG9GQSswM1kwK1RKSkRNalkrdEdjN1lLa0VvdGtx?=
 =?utf-8?B?RGM2Zm52YytJSTIyRjhDWjdZSVUzK3RKYUhSN2hxNGFEZGtwNmNEYmpoVTc0?=
 =?utf-8?B?QnZNWUhlSDNwMllkdGlmWC81NmljY1hXSVlRVGFmV3dhSURJb0IwcGk1VzRW?=
 =?utf-8?B?MlEvZFZ5ZnE4Q0lRUnRNaDhVRlRta2NOcm51aVJnNFNvanNpcm1XRklGZkd6?=
 =?utf-8?B?S01GVDdpTlQrNGVkbi9JUHA2Y0ZRSHY4K1hKblRzT0tmVTJmS2Vhei9VRGdj?=
 =?utf-8?B?eEpLaWhUdHI5aDRLVHdnRDB1WUM5WWZETHZoYkJjZk41QkRBN3dCZEIzSlk2?=
 =?utf-8?B?RkRQR1dwakFlanRqTmdYUWhkLzVYWCtSYlB1RWd0cFZuVWZ1aS9ZakRsSjRF?=
 =?utf-8?B?QUxTWDB1ZytQZDIyVk9MdHRHUytxM05ud2lXSlRlang0NExoTzEvcDlrenhw?=
 =?utf-8?B?UkUyUWlkUWlxL0FHZHpmMkRFQ0RDbGwzaGJreDd1Q1lIWUdsazJ1Zk15cCtQ?=
 =?utf-8?B?K2o1ZFVrdmpyTjVZaFNyOEFIUHNxNUV2UVhYaTJYcVdRbldnNURxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b82c54e-6789-4a57-771b-08de8ee13ab3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 04:51:54.0951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HbjzKJsS6oOZQGFy8BDJuPufPGqMv+3n7Vqrvl1virbbSUVKa470XP4SXxE5s2N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527
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

<ping>

On 27-Mar-26 1:22 PM, Lijo Lazar wrote:
> Add a wrapper functions for copying data/to from vram. This additionally
> checks for any RAS fatal error. Copy cannot be trusted if any RAS fatal
> error happened as VRAM becomes inaccessible.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 12 ++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |  3 +++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 7bd8c435466a..006ef585a377 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1104,6 +1104,18 @@ int smu_cmn_update_table(struct smu_context *smu,
>   	return 0;
>   }
>   
> +int smu_cmn_vram_cpy(struct smu_context *smu, void *dst, const void *src,
> +		     size_t len)
> +{
> +	memcpy(dst, src, len);
> +
> +	/* Don't trust the copy operation if RAS fatal error happened. */
> +	if (amdgpu_ras_get_fed_status(smu->adev))
> +		return -EHWPOISON;
> +
> +	return 0;
> +}
> +
>   int smu_cmn_write_watermarks_table(struct smu_context *smu)
>   {
>   	void *watermarks_table = smu->smu_table.watermarks_table;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index b76e86df5da7..d129907535bd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -174,6 +174,9 @@ int smu_cmn_update_table(struct smu_context *smu,
>   			 void *table_data,
>   			 bool drv2smu);
>   
> +int smu_cmn_vram_cpy(struct smu_context *smu, void *dst,
> +		     const void *src, size_t len);
> +
>   int smu_cmn_write_watermarks_table(struct smu_context *smu);
>   
>   int smu_cmn_write_pptable(struct smu_context *smu);

