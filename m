Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654B0D58E5D
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 06:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0237410E191;
	Mon,  2 Mar 2026 06:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SpTdkGRo";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7851E10E191
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 06:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPFvXYbDJWBtl+oaFotYyRGXKDG4+rckOjWWZJ3LlC6Cu34CEx7KqOZiMfwHDGTZLTsGSkabWSgyW8g3wFuy743rh8z7gyYvD69CHkZygWUjGotkEEjpQMiyykmAl0Ay2xGDJPCBnL/9szK/cZxHCKn1z6rUHrTWTPsKWwyQUxkIGuAzK+k3RhgPDnkRb3WO6nRvPGGcqSEBix4mPJvynUlrO6OxQY00EmIMWBRZz6Oo8nzhlkP41UNKWFGg5U5+P/h7R3gXt7GQ2MURRBPHSCAR2UDxZz/Af1IicvbjY+C4js3QdmCHs475KHLCUeyX/OgAI8Z5ZWyyu7GvJ26TgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxEEIjWtnPC/rqnq5l//9VRKf9LGvReBBQSBJLiPxwM=;
 b=YyC40OMZxXEQgfHcOKRT/ff8JeRQw4HwP96MuG0dUNgF0ZpDLqOr91MbLLrKq3tIkj+nOmx31i9+wlxTC+T6i39g8MdcDTPE38Mq7wghdqUq+GuIossCtab0tGazteSQEBjuL8/9u8Ui8cMLqQfqfrWy76mT6G6Au0sa10Hjgq1WY+DzzR8zHHsMO4M2cCCFbIRB+O5tEI9jMtFdEeQrxSHNETX7k+3VbzkKAyEKRtle8jc0nFwpeyEAHOy89MfUX83VTaRQgLHoEA5wOJr+b0XoowHJzaBrbQdJJS+fdi27j3lgbGlEUcSiCxX0I7GqA7LZzrCtqRDse90HDD2JAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxEEIjWtnPC/rqnq5l//9VRKf9LGvReBBQSBJLiPxwM=;
 b=SpTdkGRoUbG+2Weuy4Mxp+A5U3xtS5cDwCVf/Kn0CAWfDuR5Fk4Odt6Dz2FzXY21mzM5TyPAc/nHYIlCjlFJy+aQswvuZ9tL3lkl7FdbfE/Y3//yCg5W5DeYJs2Wv+Qg1iiw9wIaqOtqOvflznQI7I/KS99iq/a8og+bi9o1cx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Mon, 2 Mar
 2026 06:23:34 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 06:23:33 +0000
Message-ID: <7e5e915c-1f12-49ac-ae0e-752b5b158e52@amd.com>
Date: Mon, 2 Mar 2026 11:53:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Avoid overflow when sorting pp_feature list
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260302061242.3062232-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260302061242.3062232-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0239.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8c0e6f-6495-4146-5873-08de78243ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: e/lj0Yv9t1YImQ5LDfQcm5Aqk4Ed2JP5NwsFWAztAqFPvFz3FPZOZwKFQ0jd8AptRBx198D2NXOzncS6eyK1i4cs0Naw8fyDc/AERHD/Dco5E6YeYQhBM6qAfQJ1EX1VCOlLUcgB3Wb2oyauchqS9OTsd1eQsKdJYuIJ2YmGQ2R5Yv6YPCbyo52mzKYwoaWhrUUj22Q8MhSP4Q2nIu5UpkJwgBG4HkT6NS7A0rQZJRht+ibkB+JxgJxLzH+fSHOT5kiduHXJ0OFE/DvbhfqUrzvZE7J9y+s0dX/2zaQwy3ke+sM5LxT51QWC6axMVm182gyL8gU9ABFYxCl3fju7Z5T5qkrPathkbGsqqI0LElh+/Ea2Cvm33Qn/+Ban859afJ9xc9rKQ7BjAVFTquYc7cfZFr7hf0gorLgiDSHHQkhZbgxZnqvNEWo+LFSU2P2uiaE0zlbloAojo0pJHXfgb1VIFwJRg41eDTzrW0bNvnXLBFhS0EedEmL1fqHwqZe6yUcpse3FAbyrpZizDBuSM8H/G1XpdAVg38YOKhga/lhDePzqCiLcjLinmH9oUoEOejKWZPDqgaXB6fPhu+PlWlINPazHKY3EJ2OqVF6aU8E8Kwv7s7Vbvt+Kub1Phe5Vn6/HKuieIIlYupZzvxOAGGIsj/0AvU6fOpCgQLlseLSTOo9+n/JSRNtjnOzxOTJIoWXe4OBrZ9YC06eB++zT/i/CH+Q5sziYgbqv0IzvRrQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjROMWIzblh4ZXJUMkhxS3NlRUkwNXhVZDRUUXl4bVUvb3FtTjhKZ3JQRGtO?=
 =?utf-8?B?QXBsbTB1RjZIY1dSR1J4MG1VOEhuTEIwV0JhZXR3aHNWelhycmpEYnpoS1VZ?=
 =?utf-8?B?ampOOU9VMTVYU2pMU0ZDVDE3SUQvZHN3dXRGUnVjMzNKaHNVdHJad2huOU9Z?=
 =?utf-8?B?d3dmajcrUFpTOTgxd1pEcCt6UnZ6dVVDYmZQOHNhOUk1Wm9DaStSMktXdWlJ?=
 =?utf-8?B?SDlDWTVHNEhZZ0RGdThiOHREd0ZHZDFtQzUwdjRDWW9qOGlLTUtKU2hVblBE?=
 =?utf-8?B?VVpGZ2kySzNNODl2QStzTllKS3lrK291ZkFMcUNTL2MxKzMzblFCTkhmSFA3?=
 =?utf-8?B?VXFVaXh4RG4zK0VVR2JubVUwbTdXVVZLV2traGhiMnlOWHF1UFZsejNPa3pv?=
 =?utf-8?B?TnVrL05hRGFGekNCalJ4Z3VwbGpqMHBLNTd1YWE2WlV1WXBDWlpZVTJyK05P?=
 =?utf-8?B?WEl6MGRoNWZmOWN6Zk1rbGVyUmdmTmZlVWVZVkYwS3d4SllLUzVpbFdRY3ZF?=
 =?utf-8?B?NG1XSFFFSTEzMmpkNDNtWFJKN1FSNDdDTTB2WjVUZ1dpZ3NZSTFXaXRVZmpN?=
 =?utf-8?B?WCtCNWxNZzRLbUZrRnNaOWZjLzlweFdGdkJxeFhKOVBCSFo4NGFDSys0UTRX?=
 =?utf-8?B?VW9uSVBJcEEwRU1rZTZ5dnZveTVSelArcFZOa0Vub2gzYkhKQWpPMEM2WVpi?=
 =?utf-8?B?T29mOERFcWZmcUVkeThrL3Z2eDNuYmJKcjB1YnpJVlZENWVRM25RQll4Mklw?=
 =?utf-8?B?Y0E3eGJoTVB2YkFSNWw1cGNPNGR3SXAwZFlmbnpFL2hQakRZR25jWnpLaXRy?=
 =?utf-8?B?VVQ5TzNKYmhXWXBMQlcyTHZTL1pvenlBK1pyc0dGTWxLMkxYeEEzN0xROVBE?=
 =?utf-8?B?WE9NcEkySkQwbUhNcVV0TDhhRWYvWW9NcjhIbWU2blJ5dGFKMWVPVGs5Yjhp?=
 =?utf-8?B?dDlDVUZXakhmVzdDRWFxR3dpQWs5S21lQWZTSWF3RXhqVG5RZE9Va05FaGhO?=
 =?utf-8?B?ZXdCWGZZWGpZRUhneUFTZzhuc1FUS2l1SlJHcE5abHZmK25tNEIwZ2xGTDgz?=
 =?utf-8?B?d2ZLblJ5cFh2NmhaajlBcnZJZHBJTEtSd2tsdWY5VS9SZzdldnVsRzFYbjVM?=
 =?utf-8?B?VkJmQmQzYW40WVJUbEd1TkdJRGVmTlE1NGIvSnRpYUpTTmtEMFFzUEZ6eXU3?=
 =?utf-8?B?a3pxSmREaVZTK0lDOFFoNGxpNmFqczU3THhaaC9IeDl0YWpQZWpiZTNjUkZR?=
 =?utf-8?B?bHlvR2pkcDUybThrRmZZa2NZNHlTMjd0Yzd4b3Z2MC9YWHA5L0xIYk9Ic011?=
 =?utf-8?B?THR6VXM1UGxTWTBoUHdVMmZPdkUrNlFjOUtaRzlCcE83cnNPcTNONWxWUWpG?=
 =?utf-8?B?NXEwcUVDWU5BeXM1Z1cxczBpR1ptWE0yM1lEVFFsKzl5YUhSRUJNMmpQanJn?=
 =?utf-8?B?UFJvR2x2NXlsZDcrTUc0REJWcFVxWEhydkdUQVA0L0p1blhOSi9qM2g3TVE3?=
 =?utf-8?B?Y2JXUGhSa29DZk9KK0F4MlpkVFJUS3Z0VlZlWUJZZy9paFVoUVpLd1Nta05W?=
 =?utf-8?B?ampKcVJONk9tL1BqTjVPQ1NQTnRaZDBmRnBLeEhrd1dlL3Nzb1AzQWIzS2hZ?=
 =?utf-8?B?TkdiMW9LVkpWbCtURE1YSmdrdnEzQzVMUXBrY1dPcjZEYTJCSXlaQ2tjbk9p?=
 =?utf-8?B?UFNJWmpRYVZHbk5UUEdlK2Q3dHlvMW4xS0FjMWZ5Zm1PaktDVFcvQ0RJUTc0?=
 =?utf-8?B?enZUQVBoN1IxYVN0OXRyYVBEVnVrY1dkQit0QlN1Zjh5R3BES21VRzRJOW9s?=
 =?utf-8?B?NFhlZVBEbHEzMTVNS1RVRGU1RlByaWNiTVJSSlZRL1R6akp0NmFXdW94Ymoy?=
 =?utf-8?B?SGsxeE02S1E3QWRSZGJ0WjN4bGdWZ1pNdkpkNm4wQkNaUTI0UFc1SzF6bit3?=
 =?utf-8?B?NmUwcDA0WTRPY2o3Z2p1M0FpMlh3RUxQc0RoVldKZ2RhWDhZanpYblNMMzhn?=
 =?utf-8?B?ZDQzVDU1MzBUMGtmY3NZTUtzYTFxM1dpNlpGUzdoRTRjWWI5cFBMUWhLQTBT?=
 =?utf-8?B?V2phNmtnbmhuWjUyaElZWW13S0l5bDdyQ09LQXByT2Vrb0cyTEUzb0FOeVFU?=
 =?utf-8?B?NGV0YnBRSnVQelRDZ3RLUEVDd2VlQjZsL0taS3k5dWZJeHNJK3lBMW0yYmJQ?=
 =?utf-8?B?cWZ5ckF6dkIvRXhBS05UbzcwdzZFT21XK3MrQXZWRVBnNEhZZWlFaWhmNlpX?=
 =?utf-8?B?ano3WTBKMnMvNUpoN2RXZDI2d1VLOEM3VkZPZnJTem9PT2ViTDJkQ3ZEMk9L?=
 =?utf-8?Q?poseJ3QyMXYtioVWYF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8c0e6f-6495-4146-5873-08de78243ad9
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 06:23:33.8287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqIX9jW3sWuquJf0liPz7suzlDtuBsTChPJy2DhTz7Jj/8PIAOUdiGDmJDn7WxdN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441
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



On 02-Mar-26 11:42 AM, Asad Kamal wrote:
> pp_features sorting uses int8_t sort_feature[] to store driver
> feature enum indices. On newer ASICs the enum index can exceed 127,
> causing signed overflow and silently dropping entries from the output.
> Switch the array to int16_t so all enum indices are preserved.
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index c471c0e2cbd1..326c86b920a2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -880,7 +880,7 @@ static const char *smu_get_feature_name(struct smu_context *smu,
>   size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
>   				   char *buf)
>   {
> -	int8_t sort_feature[MAX(SMU_FEATURE_COUNT, SMU_FEATURE_MAX)];
> +	int16_t sort_feature[MAX(SMU_FEATURE_COUNT, SMU_FEATURE_MAX)];
>   	struct smu_feature_bits feature_mask;
>   	uint32_t features[2];
>   	int i, feature_index;

