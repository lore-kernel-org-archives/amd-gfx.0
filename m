Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487B4C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 10:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E825C10E5BA;
	Tue, 17 Jun 2025 10:12:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bVqMLeJM";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9B8110E5BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 10:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObMV41nmxj6dO4mRsJzOjKWthXO3I1rpwTutLLk3FuH21FN1zOnSa8S0od6WAzFoJPFhfhhAZvuZoQ37+zrfU+xVT9jVatASmqhKLC++hV2OMXfkHjWNj8UZIiqIDh4H1aLWJ4bHwqXaIcvHFVh2wev59IQ41FHQkZHcZFI3YxPaQnhY8/RWoLsLJL3RMcGLHTPtGiww8UHRiREC+NSTKzYe2lnMAB8hiXNECpOe/dHQnbXGkM+65k34mteCICuq54hI3NjRJQ/J3/HtuAuZXvOdAkNIy+VoGZyjx7Edh8AoBn9qtEYdJwh22r5/I6woIJVaAbUzusRILl92hiWGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J9bCEzH/ivu2vROyzwwDCLK31qjBeWlT8kJnREeywU=;
 b=Nrk3A5NgDyUigmmzUiVSKILjJccUq9RqfGXczHQLwtz6JTPu9n3heO1ZvZIjMfo9Gt9dlGIB6FgwPxnkCRrWtiypHpfBfDUP9T/wwPHHB+gxfxErF+7ephvG7NKs456cN08zVClZcKOC0yidm2KoKYa2r3692HBDTL6maNS+siWNXi047LkcPlJg2HK+QHCdni+xualrfpjLu3jj6Ve2/TcsjdMgo2pJuDqF7xMNIc+p15Q8FB9nLN05o6Tdiztsy7cecOBLo6ezqxGsLpOqVfvXzrDOdsMRH6QqcD1MXnBwEt3f1z6aXY80PgBAx364DlyhxjLHr4XfQgXZ/wbF0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J9bCEzH/ivu2vROyzwwDCLK31qjBeWlT8kJnREeywU=;
 b=bVqMLeJMb6oOqywEll40NQOtiEKzBJWKjDZagG3ZU30YYe9GjzFN+bhdL9hI3fRRvp2F2X/f6dXDhxHuLrG7iKXnHLGlmY6GMcjdj6oZpN0prKC0T5aAshrTK2ujp7kkpuZZkUMrZhUQk3FJaQ1ZYB5V1N1EXeRadCitTiXqVpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Tue, 17 Jun 2025 10:12:43 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 10:12:43 +0000
Message-ID: <5194dc30-684d-4073-8772-42e46bb40f44@amd.com>
Date: Tue, 17 Jun 2025 15:42:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 9/9] drm/amdgpu: implements detect and reset
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
 <20250617092243.2769580-9-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250617092243.2769580-9-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017C.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::47) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1c92b6-212f-474c-46c4-08ddad877fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bE1pWGdNTnlWN0hpcmZoeFhwNHFTT1EvSjE4bjhvVVo1OElqNlBiQTY0WGtz?=
 =?utf-8?B?SlcvQm40Ui84cHN5Y1FRRDZQKzRzcHB2K3pwZndYQnFZSFFaOG5GU2NOVWdJ?=
 =?utf-8?B?TjZBRytuczFiNG4veXBac1hkRjNiVWpPNUtYVWRsdkRXRzBVVGd1OXpFT3o3?=
 =?utf-8?B?K1lQWVQ0VWhDL0dpOVRUalpjWktsNnliYXoyVndWc0drc1U1Z3hTVFhKd015?=
 =?utf-8?B?SjA1Q1c3S3pnY21KN3E5SHJLQzR1ZDY4blRFR0ZkUDFNUDZyeUNZQzNRNGxv?=
 =?utf-8?B?alRQL0ZtYjRrbjNHdHo1eTFrOUErYXVSU2FXSDJJRWIwSGxxUklHc0tGek1k?=
 =?utf-8?B?NnUvRlJSb1AxMW5NTHVEMytRNElwTFhqRXlWT1BlUnZzLzBQNXhUNjBwQytj?=
 =?utf-8?B?SEdWa0ZmTnA5eHErNEJONXVvNzJBbDd3cjJMUjhPc1RTS1dLWk5mS1RiMWxa?=
 =?utf-8?B?VTlLejBidW5QVENWclBGMk50dkZvMzlmWUV4TkQ2L3BoMkJXaWJIU0s5Tk9L?=
 =?utf-8?B?RG8zTXNiVEJobWtLYXhUR0hTSWVZSnBqYVI3cjllTlF5aFVJRnBEYTB3Qkdj?=
 =?utf-8?B?YitIaTk2ZlRCcHkvSFQrZWRWSTQ5NzBta2dXTXFxT1ptWVU5cWplSFlzQ2NK?=
 =?utf-8?B?TEVUZ052eGwvbDROVCs2ZlkxVXp2cWNGVVNHRG0zeG84MmtIZWNZb0h4cjFl?=
 =?utf-8?B?L0RGQndpSlhtUkQ4L1FnRldmOEdLZFpzNktTbjlwTUJDQy9kVzhLZEE1ajVl?=
 =?utf-8?B?QUQ2OTZ2UkhTeHJZM2cwMFAvbDFSOGkwalpPVWlKaUpENHREM1hadXdTdnZW?=
 =?utf-8?B?MlEvZG9ndWVwaE0rVnRvaDQ4T3BYYlZrQm9QNXZ0Wmd6YkE3VS9YOWdYbEVX?=
 =?utf-8?B?eXhqOStzL1JySTdpRFJ1NWgyaG5ibm9TTTZDV3ByNXRiN1dQa0RoY29hRjVE?=
 =?utf-8?B?REM2eitIWmF1cHdEazN0T1ZnNTM4L3ZWWEFWVllRUks4WlgyRGZZM3lSTy96?=
 =?utf-8?B?alVneXhhc0NOL2VkMzVML1RXTStoN3RCRHJOYlhxYUZnWkRqOTlBVlYrc2xx?=
 =?utf-8?B?a3dkWE9kRzFQNGFMUktjSEw0M1FSUkJlRnFpaGlPQ3A3eG9vQVEzZVRHY0Nt?=
 =?utf-8?B?cWYydk03VnhjWXMrdjRVSnlFeGJaa0RQRnk1VkVFalFsNnJGaU1HUXMrQitK?=
 =?utf-8?B?NjZlNW5VbjZVNjhCNWh1R3llNzN3NjNRdVdKZWFicnMyekFJMlNrMkxxcmNN?=
 =?utf-8?B?UENLcWVoTVVpL1ZYbWVXR1FXeGJTZWQ4TDhadERDZHI1eGRUNWRJVWVhUWNQ?=
 =?utf-8?B?cGFHZXFmMThQY2VWbENLTlpPSzBWbG5HVWpWVVBEcmY4SThtWDlLdjhCVXJj?=
 =?utf-8?B?R3VzQlFXcEM2MFpFK1lEY0xBcG8rMHgzUk55MTA0Y1IzczEwc0EyTjcvbUhv?=
 =?utf-8?B?S0Z4VlJreWpnWWVuVHpoTll0MEl4RENuR09QTGpYVkpLMjA0bUUxK29heHdS?=
 =?utf-8?B?dGc5RlY4Z3lycVUrNFF1ZTBic0VwbGF5U0gwclVraTBYTGRNb2VYOXRrOFlr?=
 =?utf-8?B?eWtYMjZHa0VOVnM0aGRnV3lYUElYQUkyOEo2dTdZUUtjYnp2alNvbnZYTXBL?=
 =?utf-8?B?OTEvY0VYK2RHMmZhcmx1TUF0WGFhNjdGL00yOEpNZ2p6QmFjOVdMVWYyTmda?=
 =?utf-8?B?N2ZwR2NGZWUwZXBMNzVFUzU4YTVqQXBzanN3Q1RLRDk4MFl3cGdGOTh4REgz?=
 =?utf-8?B?Mlg1NWJYeU1naTFJS3l4Zk9hR0x5Nm5rallBdTJvSDUxdEpiK3dJQjhDYktN?=
 =?utf-8?B?ZTlBMXF6TGFYNjhFNWNFb3JHaUEzRE0wUDVKUDlwWFVRaWVJMktrNUdBWjVl?=
 =?utf-8?B?QldJckhxdDRVVDA1QXR5enR1cEo3UG5jZEhHUXlHU2ZYMnhydmhwSG0vVmxy?=
 =?utf-8?Q?8e9WDX9ReCw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHdvNlZJSDAyR0lFRDVDcnZJSVQzV3ZOYSs4QUhOTVQxeEVNV3F3NmNtS2lJ?=
 =?utf-8?B?ZzNwZU83RGs4TnZ1c1NOYklGdkQ2Z0c2cTRNeTNScVgxRHArMmIreUlidTR6?=
 =?utf-8?B?a2F5N1IyeE5mYzNlbm1KYXN1ZEduWFVBM0dEK1l0em42RFZxRjE5TGJxWm5s?=
 =?utf-8?B?c1FRalpXdlBpclM4YitTVzRta3N3RFE3QmdwdkJUaXhlWnZtTG5WVlhhZlFJ?=
 =?utf-8?B?UlVPT3Vwb0Z6dUZGZm5IVHN5MVJrSVIzN3NtdTdEZWs3SlFCSjZaNS9XMEJB?=
 =?utf-8?B?cVhJQ0lQQU5oN09wZXl6RFV2bVR5OVJxdThHNUVFMGRPNE5uK1BrNEpqbCti?=
 =?utf-8?B?ay9OK0NiZC9VSWdNaFNPWWpzWi9YRFV2OG5TM2daZkp0a25aNHFpMW5UeEdY?=
 =?utf-8?B?cWJ6TnY0bWdsRU1vQlk3TWdiMWx0eDlSeXZ0aE0zOVowb25CVlNUSmF3SG5r?=
 =?utf-8?B?MEZTTHptSHd6WGxpdDVZTUM5cmZDckN3N1MrMDFzTklEM0RkcG5VK2tsYUpR?=
 =?utf-8?B?OGQ0dkxwRC9QcXFiZmorY1FBdmpNMVdMM1RmanA5c3ZhUk51NjlvdFNLVUxn?=
 =?utf-8?B?eXB4Q1FTdnRiVS9mWklwYkpnak1LTDBrUXBoVUJXdFVzVmJsVkVUbkZtTGNM?=
 =?utf-8?B?dVRvd05pRVM3bWRFOE9OVW5RdVMrRHNoN0pTT0tsTjhuaHBCUlhpTW9TZkh1?=
 =?utf-8?B?Q0J1S3BhWUJUcTB6RUlBZGVUczhDVjU0Z3M2emJZV3ExaEMxQWdOV0xmWmtr?=
 =?utf-8?B?MEo1bUJOdjEzOUFsRG50cXdNNmxrTUU4eTBsOGwwR3RoZ3NpY3hYWFI1Tlk3?=
 =?utf-8?B?Z2VUbkpOUncyVk4rdy9oN1lEcS9MbDdzd1JqcGF0eFcyY21pQllWSTlDVXF4?=
 =?utf-8?B?SndEZUNBa20yMmtFTkdhbzZYM1J2YzFOMjJPQnJsbmNROGlBZDczRlhvcE9t?=
 =?utf-8?B?SDE5RDZxMUUxd3pOQmF3bWxVMlVSd0had0dmY1JidFk3MElCS3VIS1JkZ2E0?=
 =?utf-8?B?ZjlIVlVxZ21TVElFVkVXVktCM25qdkk2NE1Mcjk4V2NJS3JOd3crbEF5TjFT?=
 =?utf-8?B?dDlRVG9yUklHMkN1cnRRNjIwWGhrTEZKUk9BeXAyZVVobUFuMEIzMVNDbG5t?=
 =?utf-8?B?RU55RldhZlE3RVJLWVJPL3krVC9tUzduWldKNWFsUU84ZVU0MnluT09JUzNE?=
 =?utf-8?B?QmYrbU1xSm5WRHhLOWtLZzhHY3lBT3oxMDJSNVFncmdvaGZUN2FibkEwODBF?=
 =?utf-8?B?eDdEWFRmcG03bzJrOGl5Ymk3Y2xNK3pZODBqYlZrOGgvMnhkYWtPL0JwQXVJ?=
 =?utf-8?B?RjYrMHc1bXphZTFsYW94eWJ4MUVueGM2eWhqUUlGY0FhcXE5UG82YkZGSzM0?=
 =?utf-8?B?eVlzcGlxaUdPemJCMktPalZnOEpTS3d0YXlDczdMck1FUVgvWTR3eHpRQWND?=
 =?utf-8?B?MU8vd0diR1dPZ01mbEc2WGN0WEZzZE1YYXVLWkFvcHdtQi9VMkNCQ1QzOUpY?=
 =?utf-8?B?dlhUY1RrNlZxOVh5VCtFaHl4UlZGSE1tNDNRa3dkUUU2b3E2Q3REYW9FUnlW?=
 =?utf-8?B?czV6QlJONDlwOVBlSk1pWHVaSkU5UHc4aDBnRWIyZnd5SWtJcE9Ld2Z2c2ty?=
 =?utf-8?B?VkJBd1RIWlZJd0ZBb0xOYlNWMGgxcVNIbzhGVUxsV0I4WWhjVFhWNWxvVnh5?=
 =?utf-8?B?YjNabVhnUHI3QWFrd1djczBmWGh5enlEMDVMbE1xV29DeHFyNHExQ2pKZW9S?=
 =?utf-8?B?S21NN0pDVGg2d1Q1OGFjOW9tZUhFeUpjanB2M0wvMHd0NGpOVk1ZVlBEOVJU?=
 =?utf-8?B?NkIwMHVtTzE5L1dUVDd3NjdINzN5Qng4QThQaHl2Y1haaEliTVdzVk0vN0hF?=
 =?utf-8?B?ZDR2NEZVcWVZN3EwWFdnMzdBNlc4WjdlcEFoZFdPWWh5a1l2aEEvd0JSekpI?=
 =?utf-8?B?Y2dqZmdhL3hIbU5aSENDMm52cU1mRWNuV0hhNkZKRXo0UGdzYVpRQlBKczN0?=
 =?utf-8?B?M29PRllYU0FvT1I5WlhPR0p3RzF0RUhlb1dDVGtudEQySVU4cUh6OWFBOUhR?=
 =?utf-8?B?dTZMYzdITk9KRFF3YWtTTXpucnNmQ2daK0piSGFtUll2aXpkMk9WTmJNVjZ6?=
 =?utf-8?Q?pK2Ue0aldxpM+wCDtKq8zndMU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1c92b6-212f-474c-46c4-08ddad877fc5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 10:12:43.7094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35faqaiw67k3mUTXCI426VAjGI5Kjli7YzOPwOgRJ+jLofU7mdc0I6eX68DyZ2M8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701
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



On 6/17/2025 2:50 PM, Jesse.Zhang wrote:
> From: Alex Deucher <alexander.deucher@amd.com>
> 
> If map or unmap fails, or a user fence times out schedule a GPU reset directly.
> 
> v2: drop detect and reset, call GPU reset directly (Alex)
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 128 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
>  4 files changed, 131 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5e2f086d2c99..f1e520b81eae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1304,6 +1304,7 @@ struct amdgpu_device {
>  	struct list_head		userq_mgr_list;
>  	struct mutex                    userq_mutex;
>  	bool                            userq_halt_for_enforce_isolation;
> +	struct work_struct		userq_reset_work;
>  };
>  
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 00174437b01e..6eae2dc2080b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4432,6 +4432,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	}
>  
>  	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
> +	INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
>  
>  	adev->gfx.gfx_off_req_count = 1;
>  	adev->gfx.gfx_off_residency = 0;
> @@ -5828,6 +5829,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
>  				if (r)
>  					goto out;
>  
> +				r = amdgpu_userq_post_reset(tmp_adev, vram_lost);
> +				if (r)
> +					goto out;
> +
>  				drm_client_dev_resume(adev_to_drm(tmp_adev), false);
>  
>  				/*
> @@ -6050,6 +6055,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
>  	if (!amdgpu_sriov_vf(adev))
>  		cancel_work(&adev->reset_work);
>  #endif
> +	cancel_work(&adev->userq_reset_work);
>  
>  	if (adev->kfd.dev)
>  		cancel_work(&adev->kfd.reset_work);
> @@ -6160,6 +6166,8 @@ static int amdgpu_device_halt_activities(struct amdgpu_device *adev,
>  		      amdgpu_device_ip_need_full_reset(tmp_adev))
>  			amdgpu_ras_suspend(tmp_adev);
>  
> +		amdgpu_userq_pre_reset(tmp_adev);
> +
>  		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>  			struct amdgpu_ring *ring = tmp_adev->rings[i];
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 295e7186e156..5a7c933adae7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -26,7 +26,10 @@
>  #include <drm/drm_exec.h>
>  #include <linux/pm_runtime.h>
>  
> +#include <drm/drm_drv.h>
> +
>  #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>  #include "amdgpu_vm.h"
>  #include "amdgpu_userq.h"
>  #include "amdgpu_userq_fence.h"
> @@ -44,6 +47,39 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  	return userq_ip_mask;
>  }
>  
> +static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
> +{
> +
> +       if (amdgpu_device_should_recover_gpu(adev))
> +               amdgpu_reset_domain_schedule(adev->reset_domain,
> +                                            &adev->userq_reset_work);
> +}
> +
> +static bool
> +amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	const struct amdgpu_userq_funcs *userq_gfx_funcs =
> +			adev->userq_funcs[AMDGPU_RING_TYPE_GFX];
> +
> +	if (!!idr_is_empty(&uq_mgr->userq_idr))
> +		return false;
> +
> +	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
> +		dev_err(adev->dev, "userq reset disabled by debug mask\n");
> +	} else if (amdgpu_gpu_recovery) {
> +		if (userq_gfx_funcs->detect_and_reset) {
> +			if (userq_gfx_funcs->detect_and_reset(adev, AMDGPU_RING_TYPE_GFX)) {
> +				amdgpu_userq_gpu_reset(adev);
> +				return true;
> +			}
> +		}
> +		//TODO: support compute user queue detect and reset.
> +	}
> +
> +	return false;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>  			  struct amdgpu_usermode_queue *queue)
> @@ -51,15 +87,22 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	const struct amdgpu_userq_funcs *userq_funcs =
>  		adev->userq_funcs[queue->queue_type];
> +	bool gpu_reset = false;
>  	int r = 0;
>  
>  	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
>  		r = userq_funcs->unmap(uq_mgr, queue);
> -		if (r)
> +		if (r) {
>  			queue->state = AMDGPU_USERQ_STATE_HUNG;
> -		else
> +			gpu_reset = true;
> +		} else {
>  			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
> +		}
>  	}
> +
> +	if (gpu_reset)
> +		amdgpu_userq_gpu_reset(adev);
> +
>  	return r;
>  }
>  
> @@ -70,16 +113,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	const struct amdgpu_userq_funcs *userq_funcs =
>  		adev->userq_funcs[queue->queue_type];
> +	bool gpu_reset = false;
>  	int r = 0;
>  
>  	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
>  		r = userq_funcs->map(uq_mgr, queue);
>  		if (r) {
>  			queue->state = AMDGPU_USERQ_STATE_HUNG;
> +			gpu_reset = true;
>  		} else {
>  			queue->state = AMDGPU_USERQ_STATE_MAPPED;
>  		}
>  	}
> +
> +	if (gpu_reset)
> +		amdgpu_userq_gpu_reset(adev);
> +
>  	return r;
>  }
>  
> @@ -318,6 +367,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  		amdgpu_bo_unreserve(queue->db_obj.obj);
>  	}
>  	amdgpu_bo_unref(&queue->db_obj.obj);
> +	amdgpu_userq_detect_and_reset_queues(uq_mgr);

Is this the intended place to call this? Or, try unmap and if it fails
try user queue reset/ or fall back to device reset.

Also, amdgpu_userq_detect_and_reset_queues() could be scheduling a
device reset. From what I see, here and at all other places caller
proceeds without checking the return/waiting for the device reset to be
complete. Is that also intentional?

Thanks,
Lijo

>  	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
>  	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>  	mutex_unlock(&uq_mgr->userq_mutex);
> @@ -691,6 +741,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  	int queue_id;
>  	int ret = 0, r;
>  
> +	amdgpu_userq_detect_and_reset_queues(uq_mgr);
>  	/* Try to unmap all the queues in this process ctx */
>  	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>  		r = amdgpu_userq_unmap_helper(uq_mgr, queue);
> @@ -703,6 +754,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  	return ret;
>  }
>  
> +void amdgpu_userq_reset_work(struct work_struct *work)
> +{
> +	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
> +						  userq_reset_work);
> +	struct amdgpu_reset_context reset_context;
> +
> +	memset(&reset_context, 0, sizeof(reset_context));
> +
> +	reset_context.method = AMD_RESET_METHOD_NONE;
> +	reset_context.reset_req_dev = adev;
> +	reset_context.src = AMDGPU_RESET_SRC_USERQ;
> +	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
> +	/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
> +
> +	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> +}
> +
>  static int
>  amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  {
> @@ -729,22 +797,19 @@ void
>  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>  		   struct amdgpu_eviction_fence *ev_fence)
>  {
> -	int ret;
>  	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>  	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	int ret;
>  
>  	/* Wait for any pending userqueue fence work to finish */
>  	ret = amdgpu_userq_wait_for_signal(uq_mgr);
> -	if (ret) {
> -		drm_file_err(uq_mgr->file, "Not evicting userqueue, timeout waiting for work\n");
> -		return;
> -	}
> +	if (ret)
> +		dev_err(adev->dev, "Not evicting userqueue, timeout waiting for work\n");
>  
>  	ret = amdgpu_userq_evict_all(uq_mgr);
> -	if (ret) {
> -		drm_file_err(uq_mgr->file, "Failed to evict userqueue\n");
> -		return;
> -	}
> +	if (ret)
> +		dev_err(adev->dev, "Failed to evict userqueue\n");
>  
>  	/* Signal current eviction fence */
>  	amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
> @@ -785,6 +850,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  
>  	mutex_lock(&adev->userq_mutex);
>  	mutex_lock(&userq_mgr->userq_mutex);
> +	amdgpu_userq_detect_and_reset_queues(userq_mgr);
>  	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>  		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>  		amdgpu_userq_unmap_helper(userq_mgr, queue);
> @@ -818,6 +884,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
>  	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>  		cancel_delayed_work_sync(&uqm->resume_work);
>  		mutex_lock(&uqm->userq_mutex);
> +		amdgpu_userq_detect_and_reset_queues(uqm);
>  		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>  			r = amdgpu_userq_unmap_helper(uqm, queue);
>  			if (r)
> @@ -874,6 +941,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>  		cancel_delayed_work_sync(&uqm->resume_work);
>  		mutex_lock(&uqm->userq_mutex);
> +		amdgpu_userq_detect_and_reset_queues(uqm);
>  		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>  			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>  			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
> @@ -922,3 +990,41 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  	mutex_unlock(&adev->userq_mutex);
>  	return ret;
>  }
> +
> +void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
> +{
> +	const struct amdgpu_userq_funcs *userq_funcs;
> +	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_userq_mgr *uqm, *tmp;
> +	int queue_id;
> +
> +	mutex_lock(&adev->userq_mutex);
> +	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +		cancel_delayed_work_sync(&uqm->resume_work);
> +		mutex_lock(&uqm->userq_mutex);
> +		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> +			if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
> +				amdgpu_userq_wait_for_last_fence(uqm, queue);
> +				userq_funcs = adev->userq_funcs[queue->queue_type];
> +				userq_funcs->unmap(uqm, queue);
> +				/* just mark all queues as hung at this point.
> +				 * if unmap succeeds, we could map again
> +				 * in amdgpu_userq_post_reset() if vram is not lost
> +				 */
> +				queue->state = AMDGPU_USERQ_STATE_HUNG;
> +				amdgpu_userq_fence_driver_force_completion(queue);
> +			}
> +		}
> +		mutex_unlock(&uqm->userq_mutex);
> +	}
> +	mutex_unlock(&adev->userq_mutex);
> +}
> +
> +int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
> +{
> +	/* if any queue state is AMDGPU_USERQ_STATE_UNMAPPED
> +	 * at this point, we should be able to map it again
> +	 * and continue if vram is not lost.
> +	 */
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 0335ff03f65f..649ec25f4deb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -135,4 +135,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  						   u32 idx);
>  
> +void amdgpu_userq_reset_work(struct work_struct *work);
> +
> +void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
> +int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
> +
>  #endif

