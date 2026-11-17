Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7FB606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UuTVnMOc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70D6D10F763;
	Tue, 17 Nov 2026 14:10:15 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C17E10F75F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 14:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MR8sJ4nRckYk5oAhCPdHaAeABiVTeloSNFpr2uu49bVyqyK/CwtSVAMOTMZn00aFUMKacN9sFMF34ckk3J2ycFvUkXNB71+9VS8Vu9hX2YyoPzCX/QsU/1Jm1/Sesp26wa51ENIAoGeykQtFBd/2aZ9mRs7R7W9AdIBwHe6ObogG5CaeEbN8vdGmq6pHf0xRtxHoU9LghOu2+s4tt0eVGPwnQybQ2dsBCPEd6ru6fFCnOegw3f8QAsEJMLo2qxMbmmLElgniqmMxvjJAYcbJ9oEG9QM2ASF8ri9868oZ+h2Pthnk93G0/3z03OlssAGQ63aLRr09Y5k1LYCpzkE9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRznkNg7NbVh4LW+LuG5Ifu/at5rTTyF9t4SCSioc+w=;
 b=mDeD5YX7Az4nqzYLm+fZYnJr7GLtjQE3mtMglFds9Q/fX5Lp6A/WSAYWG9Mf2WNsABGp/rlcrva1ji5qvDgXozP73+Xiz6ztWm62ef20Q0mGHFBM1RpqA4tiknsC5DY5/xtVgEmGu0J0EFDR6NfkqfP1w3HrhpFskqpLy1RtjQsIv1qXQedyDdkGBG0l1M725hXacC8UdJSk3EnZTpl3xetduKoNzoFEV9AgqfyhtO9m7jMN1Pvj0QmFI9RZaZEko17sfoJ2w721Pr8WIJXNmNfOXMKgfTKvPLT8RtllUTfdLyCsOCwYDjIYDdjGTCBC2Wg0QACxna+RTtZfwhLuGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRznkNg7NbVh4LW+LuG5Ifu/at5rTTyF9t4SCSioc+w=;
 b=UuTVnMOcb+SQm6erIiazFQ4RiqdFXp+sUQkMMGdKCRGo4wGXlwmDiaf5fnBVmAZCBPS0r2YwbKdw8gO0L3kFcRkMLM2m6D6SpCS2lojAjMoNXdopfQTsSFnBeRHj92YHeYBy2GWFdPxXzU0NvlFpZ089xa++8x9hgqUJdYdaHLA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:10:02 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0615.012; Tue, 17 Nov 2026
 14:10:02 +0000
Content-Type: multipart/alternative;
 boundary="------------TOzvupTzsThuh48r2I0oO0Er"
Message-ID: <3dc6f502-bdd7-48a1-94be-b185f5f38825@amd.com>
Date: Tue, 17 Nov 2026 09:10:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: move TBA/TMA back to system memory
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: James Zhu <James.Zhu@amd.com>, Vladimir Indic <vladimir.indic@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Philip Yang <philip.yang@amd.com>
References: <20261116144744.1904011-1-alexander.deucher@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20261116144744.1904011-1-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBP288CA0032.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::17) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a889d4f-8faa-4c3c-e412-08df44b47881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|261009223027099003|13003099007|8096899003|11063799006|56012099006|10067099003|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: scJbNE+NzDNDpBVl9kzPk94yVd8rizlbuIYMZ4DvEYSWpd+84dSePNUaM2tqWxR7M0ki//2u8+cX7q7Dcvjxx6lezRy230+yeEwnKLqMQpY9w1ASsv+zwoLx6b+JwzEB3jC1kmHB+Dz1qKbUL/cAzg6FNljdyVMrnrl+b51zLFH21k6BlEE2YxdkF1L5NC7eG9JISx3EzFIuZRnnNP8r3ejNSHf1qisKNAS/BHNlhxrMZcP2ZfcLvtvZKp5nfKyN0g+lG18dlPkoP0Cbz2KeAP+Bmdy7hbQ/Cl94JOAf3DMxz30y0aomrZXNl/NjsZ5hc9SbulAmRiNB4jrxyB5M8PikByVu3RpGHe+mtNHd1cQqdto2zNzxlXJVoKBTgn11JjU+KUuTDr1t01HXoSJYX36Xh/KPaRm3OGe+B+c8JNQou+7Cm81xu08knBI6LX/mqGTkHHottVitEAfks9Nt7J7UEpyXLPZWGj5VgH9fNHkK1ZFCvCJo610CYSgfMzp68GKaxKCSpDE/GiMLvBmrukr4qSkNcIEwX/juzX6X6/9v3ssYQDrWfRkSeXkvgRUSiRTLJRUREtzHz2ofeLjxqg6rba6d6lljMazyHvDzIbsUDTa7MkyvwOpguPsHTsAL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(261009223027099003)(13003099007)(8096899003)(11063799006)(56012099006)(10067099003)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejFDcTAyZjFOajJXWHhvZFNiM3ltZTdXeGRHNlBEaDBJdm5KYWtwaXRTQTN2?=
 =?utf-8?B?bkZEYVdaRjc4cTJFWjBwVytQa2JXR3JQR3VueldDU2hUUVZDL1NhT3RvVDZX?=
 =?utf-8?B?RklLVjlkVys1Z1l5SWxnTXY3NkdhOGNUUmQ0Y213c1kza2E5UHlPWm1xajJk?=
 =?utf-8?B?ZU9tMTdQaDVBWTBrWjg4NkM2dFpCMnhRSDZaVytDTDVOY1JrbmhjSXVJdVpF?=
 =?utf-8?B?SExwY2tWV0d2M3FqUmVBSVhXeTdncU5uWWFGM3dLR252c3FVYUJmeEFhcXFo?=
 =?utf-8?B?ZHBmZEVYZktTRmhBamtYWnRPeGdDWVJqM3l1ZTBsWnV4aUFybGhST0JuZElk?=
 =?utf-8?B?MDBNUFczRWhJcENZdVNJMHhaTlpVQzZWT1hUVVI5UWdBQUV1OUkzeTVKUXE3?=
 =?utf-8?B?U29tZEl4WWpWOW41Q25KYmZNQnBJd0diNGVOWFYxQy9RaVhJc05WaHdRTTVo?=
 =?utf-8?B?cVJaSnFYWnBvZUFsWGl5YmlLY09FdjVKUXgzb0EzWDBZcCtZdUJBdW9sM0pw?=
 =?utf-8?B?UGZvakV0cXdwVU0zd014S1NZMHk4U1R4RnNHZUtRa2t6b0xhYnJ4N3pmTkti?=
 =?utf-8?B?VS9SRlN2VEdIc0cyYnh0dkpaelFRRk0yNlc1THNUVmJNOE9EWXU1UGNKWVFZ?=
 =?utf-8?B?UWpVOGNpdHdyWjhwdU1VaGlOTEw3dnJvRjhONDhMcW9JU1ZmVUJ3UjFBM3ZD?=
 =?utf-8?B?cVYzY2VocVBWWnNhZzFuaUQ4NE1uTFRRTmI4U1NuWjZsWllHaExjR3ovOGpE?=
 =?utf-8?B?TkxFajdrVktNZ25QclN6OXBRWS96bFR6bmRlVVpIQ1FkSTFBUXhDK0VBQ25q?=
 =?utf-8?B?RzFiZ3NTUXBtQ1liaHp3OTBvWHg5THVleXpCRUVLWnZ3S1I4TVVBb2NRNDRC?=
 =?utf-8?B?VklpaDVTVlNSM09ZTFNYaEZSQ3J4eDlrcHBWcVQyblBGSExHYlVxb2ttb1Zw?=
 =?utf-8?B?enFDTFhEVGFwT28vRFNmR1Jrb2s4cXBKL2FvVjFSeFZ2WXZkazZtRk54SXdW?=
 =?utf-8?B?WFF5b0RBOUdxQ0FLODY2emtVeUc0cHFUS3h4QUk4eFdWNGZjM2V5akpHd1hY?=
 =?utf-8?B?b1RqR2V3eCtuVzY1R016cWdUM25yejRBM2QvRnZ3VE45ZEFWVGxyK0luVE5i?=
 =?utf-8?B?U3hqaHBzNkJNMEMxQXJyWDJsbFluNCt2cXlEVWNJdkRobDVpeWJ3c1NRdmZR?=
 =?utf-8?B?M2NnOFIrUnNuSEx0RVJSSDFsaGdoSlF3cEZodHI0UytLdUVYZGxsMTMyck1a?=
 =?utf-8?B?L0lHL1pCc0ZJRXVXNjlmVkQzamRGbDd4Q0JtcG5XMGU4Y2ZoYmZDc3NORWNS?=
 =?utf-8?B?OXM0TlZEQWw3dHIyTlZJNDYzTzAwRFJmQzFFbjRuTDFmd1FpWVZPdSt0akNL?=
 =?utf-8?B?ZjJ0OXJYTWora0FFSGJPOU51WG9tQXhOMEhtSkV5dENKY0JvS21MaThtRm1p?=
 =?utf-8?B?c1VXRVF6WUQ1OUowcXR5c2ZiOVA0aU5iMlNIdk5KNVBhS3V0MGtUYXA5c0Fw?=
 =?utf-8?B?dVlucU5nMFlJbENqUUJ3emgxRlRudHl3eTZVeGtXVC84L25WTlh0dmV2aElH?=
 =?utf-8?B?N2lkZGpqT2l3MUNqVldZSDRjZW15S3BUZytDNVhHc3hLZ2JtQnovSmNqY0gr?=
 =?utf-8?B?RnFTd254MWcxdXBwSUpUeU55bE9QNXR5L1dIVWtTaUN5NzlqbWswN2dOTndM?=
 =?utf-8?B?bUFYSk9HUjM3bjBId1RnaXh4V2xqdHUzZkJqTm9VNmdNd3MwTVZZL3A2Z3VW?=
 =?utf-8?B?QlNhMy8wcTJQWXZQV3RRZWFuTVMzUGdDQ1FPWnRhbEhCY0VhMVEwcW1iYTky?=
 =?utf-8?B?ZUNwMHA5YUxFc2cyZTBYY0JiT3FOczNoYk5KQXBkaXZqcWJNamdEbmlXU0hq?=
 =?utf-8?B?K0ltenR6RlprekpFb1I4dml4ek5LZmZpdEZ2R1ZVSUEzMS90QnZON0VNeFd6?=
 =?utf-8?B?U2RmbUVFTUh6TXVPVFkvNXoyakh4NXVKeGtYV0dTVHY3RzdUemVTWFhUNXN2?=
 =?utf-8?B?WnlBUG1GQjVGZmlyYldUSklISGh1RFp6NlVMT3ltN0JUM0VMSndaTjZhdWox?=
 =?utf-8?B?dE9xV3VjNzZFLzV3cDZlZ3V5Uk04eDY0RkYrMys4S0dMbU9HM3BpNHl2NFZo?=
 =?utf-8?B?d1A1cTVnSktFZHd4aktDT0Z2UDhiUUlqeDFYS1JlODFIQXV1ZW1EZXRhTjgw?=
 =?utf-8?B?QnFRNmVxSjFMWTY0Nkx0UFpKY1JLR2FuaUcxb0JScCs4aUxUZjNoZ0V3Zmw1?=
 =?utf-8?B?amxxQnViTDVuV2RaN3ZWZE4zZXg3djMzM2pqdm5nckI3bXZCUVY3d1RhZ1VC?=
 =?utf-8?Q?hwMAqEKTSNz/xRbyAW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a889d4f-8faa-4c3c-e412-08df44b47881
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:10:01.9867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFHULbH+PZeQUutiXuPzpGyDGF9nVK+3cH9QwLJZNuq0a+BH6EZ0VnHBfV0NpgYh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------TOzvupTzsThuh48r2I0oO0Er
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

ThispatchisReviewed-by:JamesZhu<James.Zhu@amd.com>

On 2026-11-16 09:47, Alex Deucher wrote:
> For non-MI parts, move TBA/TMA back to system memory.
> Results in GPU resets in some apps after suspend.
>
> v2: add additional IP versions
>
> Closes:https://gitlab.freedesktop.org/drm/amd/-/work_items/6116
> Fixes: fe5966d4fdcb ("drm/amdkfd: move TBA/TMA from system to device memory")
> Cc: James Zhu<James.Zhu@amd.com>
> Cc: Vladimir Indic<vladimir.indic@amd.com>
> Cc: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
> Cc: Philip Yang<philip.yang@amd.com>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 546721b4d59ac..b1b641ddbcf68 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1554,7 +1554,12 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>   	if (!dev->kfd->cwsr_enabled || !iosys_map_is_null(&qpd->cwsr_map) || !qpd->cwsr_base)
>   		return 0;
>   
> -	if (KFD_GC_VERSION(dev) >= IP_VERSION(9, 4, 2) && !dev->adev->apu_prefer_gtt)
> +	if ((KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> +	     KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
> +	     KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4) ||
> +	     KFD_GC_VERSION(dev) == IP_VERSION(9, 5, 0) ||
> +	     KFD_GC_VERSION(dev) == IP_VERSION(12, 1, 0)) &&
> +	    !dev->adev->apu_prefer_gtt)
>   		flags |= KFD_IOC_ALLOC_MEM_FLAGS_VRAM;
>   	else
>   		flags |= KFD_IOC_ALLOC_MEM_FLAGS_GTT;
--------------TOzvupTzsThuh48r2I0oO0Er
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>

</p>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">This<span style=" color:#c0c0c0;"> </span>patch<span style=" color:#c0c0c0;"> </span>is<span style=" color:#c0c0c0;"> </span>Reviewed-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a></pre>
    <p><style type="text/css">p, li { white-space: pre-wrap; }</style>
</p>
    <div class="moz-cite-prefix">On 2026-11-16 09:47, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261116144744.1904011-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">For non-MI parts, move TBA/TMA back to system memory.
Results in GPU resets in some apps after suspend.

v2: add additional IP versions

Closes: <a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/work_items/6116">https://gitlab.freedesktop.org/drm/amd/-/work_items/6116</a>
Fixes: fe5966d4fdcb (&quot;drm/amdkfd: move TBA/TMA from system to device memory&quot;)
Cc: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Cc: Vladimir Indic <a class="moz-txt-link-rfc2396E" href="mailto:vladimir.indic@amd.com">&lt;vladimir.indic@amd.com&gt;</a>
Cc: Harish Kasiviswanathan <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
Cc: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a>
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 546721b4d59ac..b1b641ddbcf68 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1554,7 +1554,12 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 	if (!dev-&gt;kfd-&gt;cwsr_enabled || !iosys_map_is_null(&amp;qpd-&gt;cwsr_map) || !qpd-&gt;cwsr_base)
 		return 0;
 
-	if (KFD_GC_VERSION(dev) &gt;= IP_VERSION(9, 4, 2) &amp;&amp; !dev-&gt;adev-&gt;apu_prefer_gtt)
+	if ((KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	     KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
+	     KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4) ||
+	     KFD_GC_VERSION(dev) == IP_VERSION(9, 5, 0) ||
+	     KFD_GC_VERSION(dev) == IP_VERSION(12, 1, 0)) &amp;&amp;
+	    !dev-&gt;adev-&gt;apu_prefer_gtt)
 		flags |= KFD_IOC_ALLOC_MEM_FLAGS_VRAM;
 	else
 		flags |= KFD_IOC_ALLOC_MEM_FLAGS_GTT;
</pre>
    </blockquote>
  </body>
</html>

--------------TOzvupTzsThuh48r2I0oO0Er--
