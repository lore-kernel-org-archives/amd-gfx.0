Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AEDC61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 07:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE8010F293;
	Fri, 28 Aug 2026 07:33:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2wngXPWq";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010063.outbound.protection.outlook.com
 [52.101.193.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7304A10F293
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 07:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbf/zo9Ds7NNm7r5m2dqMeFJKHjcyIlyPucLQfxp9VoY+eonnsbC/3RRjaCuTzAzZj5MlEZayn598bctnv2kQu8ye4RRAu1dE5ulIujoztnWIE7LzInqW7yvycWxEsXj4J1Hpwak9BWmxwPmEu5rB61etIwYiRa1RXg5Tz5krwb18/TeTfXOSI6RayQdbcnwVMJGWp0PV9MYDegJ4eWUuNxMjSn/UhLe5NnFYscV+k+LacHA9rNRNuM8fhIG0qxzqGEAY1LwrPWTVdHX90CvUIQPv04tQoomQy3afQKFs4tHO8vUTTbKFo64D8zWJRGwRiTc3Cx639mev6DKNkjxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGVvz9gm2NeseiWR/6tbiTrZSvZN5+GjmLhI1jO5kaY=;
 b=ZVW25mwi2IDfDzqVlX5ImlaBXk8Si+ZnehlobQXos2sX/vcdgKlw4991sirHQWC6vuGqgj2Indpp1usSCaN6ubBYLpV3AwPgKK+amn0euLGWNaGwIPHGXY7sd79GpfStA1RGTC6Kz26oQ3SJL5yxDHQaBw/nYBqe5WPsktLmCJgJc+CbgiZnFQx/dTff3uULkDm5+kD2s2vu6guBsveHwsIpQjhz5KL2E2fgGuhCKaUiyArkFgqhrVI9IYdIyauYv24XajY2R7JtQixYHTm9qYms1beNF9TyA4uNsdTRHQ25rr1gyZIRldiYQmADaGQ0FXhmgUQbdM/d5JMI4SV5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGVvz9gm2NeseiWR/6tbiTrZSvZN5+GjmLhI1jO5kaY=;
 b=2wngXPWqVTSUGPLixBZxx90Y3f0yESYf/Z+Dwq3earFAWgaZicwdSq/7PobL/7bbXq0h7G2BJ5TGgqd4Lp2ItIfwCq71hvUjBLpDvTUHUkJY7NfksZRmhHjUSdmiBiupqqLOfWnDML+zMKKUnHWGAK6L/P5qjSA2zlqesaRsz5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 07:33:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Fri, 28 Aug 2026
 07:33:45 +0000
Message-ID: <5c85279f-e28a-45cb-9e5a-df0dda163ded@amd.com>
Date: Fri, 28 Aug 2026 09:33:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] drm/amdgpu/userq: update the kernel docs for
 amdgpu_userq_fence_read_wptr
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260827154849.1021013-1-sunil.khatri@amd.com>
 <20260827154849.1021013-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260827154849.1021013-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: c6173f72-d7b0-4662-1b70-08df04d6b12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|3023799007|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: UkllOHJ4P4DS5YZreIW/LnaAM/dc7pEis+8r5nmlJFQWi3Abb0aPu7XSdZxMORVD6wpFk4/ehChQ4vTatDKrv92FmoBggHMjJJ9vH+nhQ+QpnwerD81oPqyQ73xD2AI9RzCSSbSTlhrfSLvMmwDyqwa9LnytHrjPu5gnIJ5oIRo4Q5rh0AteqhWwAffZ6XTs6r+txMtY7YMtVmkgumgyh18AYC+lge6tsDdk9cynWj/GddMGBkRcdruJuetQpYrQ8xP9Xxk0Ff727aq8/FnQo5O0qyj4IBh1eu8QRSbRrkwni5NVKrdgdXILhMXVRACUZdaKbXEBtLeRxDjZBVcV2/mlZGEVou0ebo+6X4KOj/vmhWUlJHyJtB/vhvAcDJAsTQT0nnLND1r/oNcthZ93vMHyuzqnzHzYcUp9AVrvxcZxC1N4MoOIOAR11FmfR6PBC9KQUXP/ncAZAk4/YjU8dvVTCbeHbF/DqxkDWZpRFuLFB7ukVe8VERn7NdpZNdboxiIc1Px/gD3H4pdiNMaua7/PjG583/MzujZ3Ukf06NudAkvuOX9NBGAyUT9NQDi+6p/2xuLSSctpE1yLlnmDvEe4hxrVjMwPzmrZ64jW1TeX+gE5C7QceS9I4QICHHxvQP1Z4paO9QiAaAa6QjTTIP58xW1vR0FX+zRv1dcZPyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007)(6133799003)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHdLT3NPY2I3TmdsYnZweXhjVHdMT1ZzSXowNmpMaHRtM1Q2NkhCeEN5L2RU?=
 =?utf-8?B?RzVnU3dseTBYZVNLdjFyQjVlKzN1UTZqenZkVWJ4SGk0OElEM2hZNm1wc3Fn?=
 =?utf-8?B?dTRBSzFERzVia2paQWZMWDAzZDlYL1FmL1dsV3V4TnVwTHpsOVhRRWtJalpw?=
 =?utf-8?B?NWxqSmszVVpZWmxncG02bGxqcWdqVmRiVWlwaElVSGpoMDNGL1NqTWgwM0F5?=
 =?utf-8?B?cmExeHBGaGNwNmllR3lSRXhTaWxkZ0piUTFwcStFZG1WVkQzWTJad3lyemVn?=
 =?utf-8?B?N1hBa0JiWnRmYWY0a1dzMkFGTG5PMFphVzI1V0tKMkNPeDRQeGRsMW5qMlVI?=
 =?utf-8?B?VG0rc1V0aXQ4dVE0Ym01WVdma2RrQ2t2WDdsWmZENHV4MkE3TUxXc29SczNy?=
 =?utf-8?B?YmtkclA3Y2xibzRXZGdDSnVsMi95SFdUL0pWamZCd0JsV1Y1ZDdHamJyczJn?=
 =?utf-8?B?M05xL3k2UzhKSFU4UVo3SnRvd0FRQkxsR1dYdUlOaFp3L3pKblRGN1dHMFlz?=
 =?utf-8?B?WForc3A5b0NNTzFSck5LdnNMdS9VNXF5bFQyTmpOcUJ3MDMyMW9McGYyclhr?=
 =?utf-8?B?Nmxxa1FyOTk1K1psK1ozSU90dzMvSUtCdUhyVlk4S3FWUEN1Y0VpY2RHZTVp?=
 =?utf-8?B?WU9kRG1TanhXcUVTVnRoZEZTR0dLYS9RbGpRaEFrcDlmUG1OeHMxMzlqSWxi?=
 =?utf-8?B?bVFXeUM3ZjhveFlMOFpleE9uK2ZNMzdIY2hnampPZTV6STF3dlpmZk95WjMv?=
 =?utf-8?B?bzVDREJldkpSb0hmNVZGZkhqUGhYdU9lV2FseEx0Vk9QaWJCS0dRSlc0MEJS?=
 =?utf-8?B?WUtDUTZubTZLMVpDeWE5THJhTC9ySjc2enJNZzJMYkRJZFFjTC9JMjlwdHRW?=
 =?utf-8?B?RElKSW0zZDRqNTkzQ1hjNjIwYUFSS2c0RzNLVlNFSXVRUVhKT1RwTXd1aFhP?=
 =?utf-8?B?akx4cFdkVStBbStzcUtyK29uVnY1M2I0bU1JOURrUm1oek1hdU5lQ1ZvSkZv?=
 =?utf-8?B?RWVWb3VJSWhJKzBaQUxvSEFSM3UxaTNOMkl5bSs5QjJvM1FkeDhtTXN2NWVX?=
 =?utf-8?B?aXFqc3BzejRyWnpIT3YxamRsQ010bFh1WGYzYUVTLzlLWm80WkMzSmxJQlNH?=
 =?utf-8?B?TVFpeXRzUVg3V2FiY1I2N3Q4NHZKei9uNVJWL21tN3VQUnNLaGNMcVNzbEsv?=
 =?utf-8?B?NVY5eXk2YXRHYzlFRzR6NjMrbklvdXZNOGJ1bndsSHpMcGRpR1RhL2ViNHlo?=
 =?utf-8?B?NTNFTEhwc3VFVlZTbEZvNVFLVUhWdlhGZmR5YUg1QndFRlNVTWUyeEhvRnh2?=
 =?utf-8?B?Nm84WEhJN3lFMS8yclgzUFpxTU1IQ2ptdGlTYkQ4NENSTlhJR3U1T210SmdT?=
 =?utf-8?B?V2hZOFVBa2ZJWWxqZWhIdzJqaXUxd2h6cGI0VklIc3prRythWUVQcTNFM3VI?=
 =?utf-8?B?TlBURVdNU2VTeXBKUGE3S2UwMzE0TitlbjNzTmdrcGxWKzJzS1BldGk1Tncx?=
 =?utf-8?B?eHhXM240ZWk2cG1lMlB6S1RNcUJkVDNlLytJUnAra2liK25jVk1tSXN2MllT?=
 =?utf-8?B?aE1BWmVza2IxeFpVNjVZSU53NmJiTFZLa09uQk9QeDJVckNJc3dlZW1zZ0Y0?=
 =?utf-8?B?S3JlbkhJK3IyNDFwWkRGT2JkbXpDNVNFNEJERThOU0tpL1c3OFpVMFlzN3Vw?=
 =?utf-8?B?UzZGcDUrQ0l6ZVNqVnhiOFRWR3g3cjk1a0pOSWlFeGVraVlrV1haaGlqbjYz?=
 =?utf-8?B?UC8rK1hkanRIVW51L3B6QlV3Rld3ZktBNGZuQTRHQ1VjL0xYVmRqTTlrY2g1?=
 =?utf-8?B?ZXNVbUNHQVNWdFZ0cnFFL0FMazVuOFFTbmc5ejZFeVhRcmJrWVAwVWZLRXFs?=
 =?utf-8?B?TTZmM0hyNEhmb0NQeHhMck5qdWprejEyRXpGQ1JJSURYcWk3SU4wM2c0bVNX?=
 =?utf-8?B?c2crNlNQc0x4VjRYcjlCSmRtcFNuWXNpcTJEdTgzRWxWNjFta21yUzJ6NWo1?=
 =?utf-8?B?eDNsNFIzcjBVRXVGeDJWVk9ES3FWM2x4UmUycU9jNnhnbTg3ODB1bVVCd1lW?=
 =?utf-8?B?K1pXQ0tkQjNwcm40cktZd29idUFzaG1Ec1RUcXBJMXFablUyd3B0aUE2d1B6?=
 =?utf-8?B?QURXcC9aZWExMk1tMjJSSXRoaSs3cC9WZW0vK3VBWURIN0hxL0h6SjlpendZ?=
 =?utf-8?B?REJVdVNFWTJycmV5bXg1UHNWWEpSS3N6aURTL3J3b01ZOXcrcnRoREUxbmRS?=
 =?utf-8?B?eVg1ckI2YzBIalRVOTFDQzY2L3ZCNFV1dTNleHlPRHRaUlhjbXM3Sklrc0Fv?=
 =?utf-8?Q?w04UBrZKi4OCH10yfk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6173f72-d7b0-4662-1b70-08df04d6b12f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 07:33:45.5067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: js/PfcVOXe3LqUChLhvg4jLsja7sSxZRXTBMjYnVuQ3HEULoshIzekvAzKMJFdvz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215
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

On 8/27/26 17:48, Sunil Khatri wrote:
> update the kernel docs for amdgpu_userq_fence_read_wptr.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 5b936d12c55b..c270635c907b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -361,7 +361,7 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>   *
>   * Read the wptr value from userq's MQD. The userq signal IOCTL
>   * creates a dma_fence for the shared buffers that expects the
> - * RPTR value written to seq64 memory >= WPTR.
> + * fence_val written to seq64 fence address >= WPTR.

Mhm, that isn't ideal either. Maybe use something like this:

Read the wptr value from userq's MQD. This value will become
the rptr when the HW executes the commands and written it to
the seq64 memory. This way the wptr can be used a seq_no to
create a dma_fence.

Regards,
Christian.

>   *
>   * Returns wptr value on success, error on failure.
>   */

