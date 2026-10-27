Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B35B606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZjE4zJOO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B28D10E495;
	Tue, 27 Oct 2026 21:48:12 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013066.outbound.protection.outlook.com
 [40.93.196.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3017510E495
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 21:48:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAzu9xiqlRVX1FSVxuDkjKkgciWA3ihuX2Q5u/nRM572dc28byj7rYtNhTIeeDNXhLDafT0cFPo3N+ejq0GRyLeAIogc+fY6jdnu5UyqwdBdcRunVi43rSWT2+P2zbgqhzaY7eLlnwIOIjMdYANVgmqzFGv2U1vS4NofmwtKrtCAMhkUplUvpdWJaGmu5w57lbFijNtAzmoUr5co4n5ZivoS7HM48TDXNliQZGECnQ361esrAy/y9hJ3eLFpK/qgx7//+RtCj0VQcGtGgwMSewWOm7q4sZwxawT0Yq9duF3P3qQ2kgmQRl9b13evyLTfzjfxw+T8sGCzB9xHgzuhdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0Pf6+77JbiHV83kSEgtUN4IFAc6TktzPB7QcamTdLE=;
 b=eH21Usj3fCYQnk8zNfLjLhB3TufsuA8WJtC/T65tmgwX2lQFxzb7kt3Pvf3OFhrkZ8ULGm+pgkNVHMv08rqscEFMFWeLJysxeUjU9w8elun6aW+FDdwEi+pW+aKccSmeT46jumx9u/3/rtwL3sxljnJW6lD0QWjGQBzxqZMYMhtBC6+9qva9TdV01Hxze5ziZ75ObGoxHIDC6G5YlkFluxQ0S7uFi42XGyOMK2IEDJwpx1bIzSFz/hbgXLEWaO4C5ggNQYtgzrwQurLdNsoWeQfyBxT7yxmyy1jF37lY+d9JG8AxwRj+TU1t2cYKbWnpDHBmLpep+aR5a0IYPJXANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0Pf6+77JbiHV83kSEgtUN4IFAc6TktzPB7QcamTdLE=;
 b=ZjE4zJOO8SD6M6/vONdN2bqCYwZxjz3wuKL3+hHcfbRWAx244MNVMQq5TR1lH1IVja1Soup/XZO/BTwwYclCtg/SXsshnO56r7PcPJ9+PKgPyJwtZcWVIDgPbTMsQXw3yU1dhXEqFOmEZhW4p70d1uU6i8TIppbBI3waMcl6Coo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CH3PR12MB8901.namprd12.prod.outlook.com
 (2603:10b6:610:180::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Tue, 27 Oct
 2026 21:48:02 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 21:48:01 +0000
Message-ID: <75e4bbf1-1153-44bb-b759-b0d21cec858e@amd.com>
Date: Tue, 27 Oct 2026 17:47:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 8/8] drm/amdgpu: Temporarily enable UALink loopback via
 module parameter
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
 <20261027195913.1794477-9-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261027195913.1794477-9-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0275.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::26) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 289f5cf3-b36b-472b-4697-08df3473f8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|261026121527099003|22082099003|261022075727099003|261021123027099003|11063799006|261021121427099003|4143699003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: YKmu4T1K6S7cGxWeNEBecvEqj/qjOiMbmD6gTVSWljIQFzyNVouqx4moSs1OT0nrIDPiuAi10OJ3K7ibCV4HAi2M0hBQT2GFiG8ie5uT7MfAJyP4Kyevyu+CbBfwfY6Zh4mWoinaJim3kebCWos8deu1R5c62CkxwRDL0LXijdSibVL/VeRugZbZJTqjmmvvD9VX7uNXrCVudKyu8LZ37ADK4hJ1jv6xYRERoxFNpHkhAdj7OQZrqeGBc88M+lxVTYquQjRVJiAQH0VPYVfvSJhgw7xDuA8uxULFJ3k2gAweqazOA6lNlz6ospLMlFCoa3CyaBNSRWZxLiK5ei5GZGdvMwXrGp/mDboijM3+a9qe4rG8CBTa69oyRf2Neq8tjbQQyQaPIFhpVRGAb0u+CeEcZ00kLpCiUQ1FQJ2mF5ZMbmqDs34SmbX5ANvaaJQwTSfkYotlXLfVy0N+5RtXtviuS+IgS4GiokGSPunToIiYGFWUDXSGFtx7ut6cPfcWlSR9V31ftDSjhm2KpFvg6IE6FyRLTMVnoGnpq/GtvTOeNmnhqy4Oc4hg+hEMEabebEfFLOALptFhWlL6nPBGNIIHTxBbjCtfghZYgr/Jp9i558W0Zn9xeOSmGydcBmIrn2tPpMpF46nKSWefa0uAZBYp/1O0muyAjClkR6TESjU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(261026121527099003)(22082099003)(261022075727099003)(261021123027099003)(11063799006)(261021121427099003)(4143699003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm9oZjdLeXRkSkFmbC80dDJ4K01IQ0hMYTcrMDBlSU80NnJ4M245dVYrd2J4?=
 =?utf-8?B?M3kzUURTZGp2bk55cmp0bzRMSEFTemU2b1ZDbVpKSE1iem4wSGsvcVJaNVAx?=
 =?utf-8?B?ckZidkV1RE03ZThINHZUNlZWaDE1Mm5mNkVBa1NiM1JhLzNZVEZucGoyUy9W?=
 =?utf-8?B?OHpjVm1NVjVWbEJrbzgyaXNhMjhTcXZGSmVxbVM0OUNWdDRKN3QraGxHcUg4?=
 =?utf-8?B?VkV3eEllRkdYbnVyM29Ka2dwNGpSdlMwcXd5UU1LVEhDa1BvWFkrSkJzZUVR?=
 =?utf-8?B?bnV5cm9zVEJWa1M4MUVtUUFxaDdFQXU1Skt6eTRBQTUwOUZhMWVmM2V0MTNT?=
 =?utf-8?B?TDgwNVhNSHVoOVlXZGFjdUpkZUxLUUpKUXlkVklFS1JkS0pIWHlkMVdValVM?=
 =?utf-8?B?Y1pVYWhnRk1CcER2Z3RFWG1BdVdXRjFqVG9adEhabVUybzRpczVUODNSUkUx?=
 =?utf-8?B?R2N2dzdVb0prWU5OcHBoNldzVmp0YVZuUmRPczRlZ3B5Y2d1NkhNdlV4Qkta?=
 =?utf-8?B?U1JPU2ZneklkTTVZOUJjeW5Uem12blFOVHBna3BOTjY4QmUxZFk1dmY2NlIr?=
 =?utf-8?B?STZXbHpSV1JpaTRhYlh4WGdHMmphU2NLYm56ekttbk9OYXByTGYxRTlJSCs1?=
 =?utf-8?B?ZWRWVndCY1E4V0hJZlBNdGFZRFJMclJMN1VlOXhKaTB1aEF0ZzRvdS9mdTNm?=
 =?utf-8?B?MHVqejZ6YThTK0RBa01HVWlWUUZ3cjZqZkk5MDhxRXErQmdkV1JBMkRFeGlr?=
 =?utf-8?B?Rk84Y0R2MXltQ2l4eWc1b2c0QnlHZjdnVlZxSGtPVUhQeGdweHVzWFk3UDdR?=
 =?utf-8?B?MGRpdThxcDJuZHkzeWYxNnhzOWJKaDhDZkpORnF5UDFjMTZDenVRdmU5S1h1?=
 =?utf-8?B?YkZiZ1krWkVTaDlIeFBBdm1CUG8rUHh4N1EwbS9wTk41M0ZUc3lqRXZPdkZ1?=
 =?utf-8?B?Y3h3YmF1YlNzMmZCNEwrTGFVaDU4SW5RT1J4UG9hMThld3FCUHEvWlpQLzh0?=
 =?utf-8?B?UUROY3BMMVZWMWIzcFlWNGs5aFc4cHhWWjc3cTQ3d3BHa0I0L1B4MlFPcm5K?=
 =?utf-8?B?YnVWT3J6MXZZaVR6VnJxMEJMN1N3bjZKSS9uNFg1TlU1dTlObTdEZnBWL3lV?=
 =?utf-8?B?K1RUM1F5K2pqSDcwOUUzK1oxMHR2cXEwRGdGOXVaYURpcit6c1ZqZWdxcnNH?=
 =?utf-8?B?dFN1TDdTamtvL0swenpxTmdYYUU5TzcyUEtWNGZqS0p5QnAxa2dwYXRlN2ZP?=
 =?utf-8?B?SUNFNG5TaGVldy9qM0M4YUNNelFzZ1pJQ25NekEwb1lEV3p2UnhQM2ZnTDEz?=
 =?utf-8?B?bzJXNjVZdC9NSk5TOTNRUlBBOEg1K2ljV1k0Qi8zRnVpUVVwOTNuS2V5S1FP?=
 =?utf-8?B?ZVdPbHc2ejUxZTdybkhkYkxNdEpURUhna05sNjYraEE4ZDFvdmRMU1hkQUpN?=
 =?utf-8?B?eCsxNHd4eW1NZ1IzQlZ6aDdsVC9KaGVzVk4rSUJFTmhvM045MzIzdTRVdjNS?=
 =?utf-8?B?R2Q2Q2dKUXZYMVBDbEFndlRaTlpOT0FSeTlhR0p0c3NUeThkN0k4YUVHT1Fh?=
 =?utf-8?B?RVJpWlo4eFJRSkRCU3RMTEpZS3NpQkxQdmk5Z3lLdEpxSVl0R0ZscFRBeC95?=
 =?utf-8?B?K05MRE9saDJkQVAzc01RUFdHWGFwbThJUjVVTUI5VkwyNXRRbG1ZZDA0VVh2?=
 =?utf-8?B?aG5nTGdJMk5VaEpNb2dSRndxMnJ2Z0pIY1pWUzAweGdpS2hVV1JmYTY2UkFE?=
 =?utf-8?B?UnIwR0hKdGlQK0ZoRS9SbEhSMVYzUWl1R2R5dDEzUHBXaTRlbWhCaVc3Vldi?=
 =?utf-8?B?TDJZQmVuNWlYZ3ZTRVVDZUFYRHZ6RVhpTWRoRFd0QTJCOFRBemQwVUlWNXl6?=
 =?utf-8?B?R3RibkJpVExtOE5CelptLzJwaENudkJ3ZHNDakk1dUU3RnJRUCswZ3AvRHR6?=
 =?utf-8?B?ZGhBdm1hTHluZmczL0VHTGZyQjl2N1JOUFJPU3NxY0VKckJSL2JxY2pFUWlw?=
 =?utf-8?B?WTRNRFJKR2c0d21tUTBsd3dxWHdZM0swYVk1emUyQ1lBbStieWpiNEhkT2RZ?=
 =?utf-8?B?bTVGcjlEMnVRQmF6THBjY1MzcWZwNml2N0JzV2pkRnhkWTlmZDlKRW43YlQ4?=
 =?utf-8?B?SHJaL25MamRJcll3UzF3L2VZK0FZZXRhMDFOWVlvcEJGUlhDVHgyTkduQTFv?=
 =?utf-8?B?Z21iWldHd0VjaE5wak1YZTJtOFAxMkljUEVkR2pORUhiMzVIbFZXcERWVGIr?=
 =?utf-8?B?MDQ1WWtucFFscWp4TTgrRTMrbWtFUUJFbVJiQXZqamFuNFpPdmx1SHllMXhI?=
 =?utf-8?B?K0QvMGtVY01kaUltd3BidmJrMURnd1pmMXJZT1g1RmlPS0MyQXRlUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289f5cf3-b36b-472b-4697-08df3473f8b1
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 21:48:00.9470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1j8THi4ufMZfy0IxaYVpSuf6drnvQm0KGxAfV+cEYV93o8G3w2B57VNpVX8RNd9jxETHutRz8kUe7XQ175DFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27 15:54, Mukul Joshi wrote:
> Temporarily add the amdgpu.ualink_loopback module parameter to request
> UALink loopback mode for manufacturing testing, until the final
> mechanism for enabling loopback is in place. Loopback is disabled by
> default.
>
> Only amdgpu_ualink_loopback_requested() reads the parameter, so moving
> to the final mechanism only needs to replace it there.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Acked-by: Felix Kuehling <felix.kuehling@amd.com>

We probably don't want to push this one upstream. It could be for our 
internal branch only until we have the proper detection method in place.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 13 +++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  5 +++--
>   3 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5a32b54b1e9b..b8be093b8a33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -270,6 +270,7 @@ extern int amdgpu_rebar;
>   extern int amdgpu_wbrf;
>   extern int amdgpu_user_queue;
>   extern int amdgpu_ptl;
> +extern int amdgpu_ualink_loopback;
>   
>   extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3e5634de077f..e0cf40f86194 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -253,6 +253,7 @@ int amdgpu_rebar = -1; /* auto */
>   int amdgpu_user_queue = -1;
>   uint amdgpu_hdmi_hpd_debounce_delay_ms;
>   int amdgpu_ptl = -1; /* auto */
> +int amdgpu_ualink_loopback;
>   
>   DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
>   			"DRM_UT_CORE",
> @@ -1165,6 +1166,18 @@ module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms
>   MODULE_PARM_DESC(ptl, "Enable PTL (-1 = auto, 0 = disable (default), 1 = enable, 2 = permanently disable)");
>   module_param_named(ptl, amdgpu_ptl, int, 0444);
>   
> +/**
> + * DOC: ualink_loopback (int)
> + * Enable UALink loopback mode for manufacturing testing. In loopback mode a
> + * single GPU acts as both the exporter (accelerator ID 1) and the importer
> + * (accelerator ID 0) and loops UALink requests back to itself. Possible values:
> + *
> + * - 0 = disable (default)
> + * - 1 = enable
> + */
> +MODULE_PARM_DESC(ualink_loopback, "Enable UALink loopback mode (0 = disable (default), 1 = enable)");
> +module_param_named(ualink_loopback, amdgpu_ualink_loopback, int, 0444);
> +
>   /* These devices are not supported by amdgpu.
>    * They are supported by the mach64, r128, radeon drivers
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 1c2203ff175d..a98fa5f970b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -96,11 +96,12 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
>   /*
>    * amdgpu_ualink_loopback_requested - check whether UALink loopback is requested
>    *
> - * There is no mechanism to request loopback mode yet, so it stays disabled.
> + * Loopback mode is temporarily requested with the amdgpu.ualink_loopback
> + * module parameter.
>    */
>   static bool amdgpu_ualink_loopback_requested(struct amdgpu_device *adev)
>   {
> -	return false;
> +	return amdgpu_ualink_loopback == 1;
>   }
>   
>   /*
