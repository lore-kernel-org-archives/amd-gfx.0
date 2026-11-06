Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C3B606D817
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CLCird3K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD591123D2;
	Fri,  6 Nov 2026 09:56:34 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689AD11204C
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 09:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlF/SNyTJJl30w4gG5bE9emqezNxav+dynA+BjG5794Aff2ETVMb9VF/vF+1bdZOEtgkdG4bQhZ0/pPmTluFP0rBciC5D+xY9mpbZZ4ywJO+mGFyGfQ10tVQHEhY3cBotCbxSaTedDw/sB5EWXMcr4EujBHjblYYfskueGfdOb6ArBLs3rowQunP7j4VTZFM9Ki129td+WvZ6YLJq5cRc/4UBYWbhgwZGVRSCIwMExmyWLcYHif5GGoHcG72aPYUPUgDMdfCf4c4tiu9JG/pzpzb6B8gJb3GAgkClCF/zzWz0y3umOz7dtv6llKr7fHdX5yFLZWKbZl15u4iIJ4Pag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIxPeblFWjIrbb/HU4i9TY6O9ClF1RjRSSGAytwb3Jg=;
 b=N30fmC/sAw/7+mZdxP22Qb42n1X9FnVFMo8pf2Ag8SsVxccXWymyaAUR5tJbWxQ1pfRdBwAS+XDCNAUmTBaXbr32FGZqNpKbuLx8XHhok73rAvG67EmYNdIfVqLEN8Cy2I61eauPQ9u+LcTrm87rjCX2mFP82evcV6EEgNlLt3NOS5Y9nGU/R9jjhWA9eIDi/nD5yRn8Xr+rw0H0Xc9n+OaHxguEndTY387aUI5e4RMQeJuIvOIAzhG1tOnJtku066kxdGXqseusGVELcj8/rPYb6d/JsIKEY3iLoE7SporTWZ+U+e6PrDoashIwlikg+YSiYYYyFN8wnmG2s8beng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIxPeblFWjIrbb/HU4i9TY6O9ClF1RjRSSGAytwb3Jg=;
 b=CLCird3KoUooI/SSP7wLEtVy1VtGggApkgpGiYA9oKzxcs9C3whdS5D/LuaLf1ty8J/ac0viye7ySoceqJtfHHMQ1qC/EA80zGCjRgeF6QxmNFBybW9eIZhr5h5ugMO0S0ckWdxO6llZbaLVLD5PJq7cC1R3CsKob8ypCXEufIo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 09:56:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 09:56:17 +0000
Message-ID: <665f0f9f-9000-4247-bb94-38fee0943bc8@amd.com>
Date: Fri, 6 Nov 2026 10:56:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add a debug flag to disable the userptr size
 limit
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Yuan, Perry"
 <Perry.Yuan@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20261103074312.2467826-1-perry.yuan@amd.com>
 <CY5PR12MB636974AF9E0B54C482EFF35FC1762@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CY5PR12MB636974AF9E0B54C482EFF35FC1762@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0445.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 67cc0a32-bf78-4775-dd8f-08df3bec33c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|11063799006|4143699003|261021121427099003|261021123027099003|10067099003|261009223327099003|261009220027099003|261009221727099003|261009223027099003|261009221227099003|56012099006|261102123227099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: D/490GsYMr7l0J/RBvYxwu33aSCfLQkAxNewyfp6Ai2LuhlkW6ngY5tT8rAJWc4kaGissVFCY2PDQJb28kXn6hj2lxwIlgeznbfV3M3ItRTwU5P1Fyjf4iQZ0pZnM20oGqRmbdVYNaTllnHdWbu1dj3eNRsHegp/ivD7gpMo2FK95mhTS7m3GiuBgXiTooQbDNvV+1O3S2zXOTX1JQL9NrKsf7fEPGfmpHN76WFDAKmp5C+NaBCyfGz/GtYp4m8LdhJZZPFiPsBQq8p+uHMaTQpzImvTg1I4G7uulImv72D6KKcI+QrGVb00yN/FBivhhPxFiuT6T7FfDsNlr36yjDh88nFjlHKWPtNaGvJ2pcrF800DwwITmF09rNvGaRazCzi1NIiPDsAAwwOvXtKk7FM35sus04pS2Emi1iq2cSpXwN2QkVqEwQh6VB8X1m4UW9zzx9ZISJit6t5Uf9R3GkhEQ0NjqzgA62dORdSOGCJdJQAoKi7PsYIrwnMtoQgk46IygGMKQy9GbZo3GjQwp0J88z7NrcaIwXSJP9xywTU3HtxCjyGLD1qt1Yxk/l0N2iHBRa/6jizDREgh7XWnDQ/xHM0e05Ee/o23qGGPFOxhfpP0idPkrcygAGYXGTBGzv6rQ7t998V/ugnAS5F6BmWGs/0Q7QAN12RqlpoqCp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(10067099003)(261009223327099003)(261009220027099003)(261009221727099003)(261009223027099003)(261009221227099003)(56012099006)(261102123227099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTlRdkI1anRkcXJMa1lhL1Yxcjl3bkNlMFFCckJJeFlBSURSUUw3RmNSOTVp?=
 =?utf-8?B?aEw4VGxjWHBJTzJINy9TVGsyN0xpZGpOTzVVSDlyOGtCVHlhSHA2b2VBZmJu?=
 =?utf-8?B?NGk4Y1lKSnBOZE9JY0k1ZnBsTitXN094NXk3WExFNndocFllNU5MdXZJYWtF?=
 =?utf-8?B?Q2h5U1A2UGtNeDBiRktKUDlJQitvcFl4TVBzYjQxTzQ5dmhkcWM1WnYzRk9z?=
 =?utf-8?B?YlJkeGVoTFdoY0hhYnl6dXdRR3h1aG1yRUltb0NSWVFSclJTb2lLSmFTTXJm?=
 =?utf-8?B?eE9Ia3ZxWDErM25DS3lBbVN1cTZmejBzL2g2NkFLSk9RRjgwV3JFaVIzVDZo?=
 =?utf-8?B?SWxqR2xpTzlNNEE4NVdNcXd0NkFMSDBYWHBneGQwOVZEMWN0TS9Hcm1MNk1t?=
 =?utf-8?B?Y0FLakNKVXRyVzVhaXlKTk00dFllM3hzN2s3MnlhWUN3QytDTktEZ1QzT0lU?=
 =?utf-8?B?bmIxanFzT0x0V0hwV3MxSVhHN29SUEQ1Z0lwbjAvU3BQb0ViQmJCK2N1VDRk?=
 =?utf-8?B?b1VtYmJkcFlLcFJWTEc0WlBvd1JkNHN4OGw4VW9VdUNoRytkV0RvdFdMalBr?=
 =?utf-8?B?bnZDU2NXUFlBNU5QTFNoeDJXdnZVUExIY0ZjcU8yZjkvNm5TYitlT21tUXl3?=
 =?utf-8?B?blgrSjNIM3BYT2s5RG5NY0I4azh3N014T05WK2VJbkw1dkg2SEhPMG4vM3dj?=
 =?utf-8?B?RWdBbzlGdlcwRnBIMmVqdnVNcTRMVEFmQkJ5L1MvU2c4WnR1ZHVhY01Zazh1?=
 =?utf-8?B?OVltZGlsN2Z4Y0RLN245UGQxRERzU041WkFBVFBraHVHamNMcDVpR0xYWXFV?=
 =?utf-8?B?TkZlcGZKSldSK041bGRFckU5UXZ4aVdjZjFBUGdCbWpkeXMvMW84a3pBNWZn?=
 =?utf-8?B?MkZrd1IyQVNJZUwxdHRjQ1JRZ0FYTTF3UWxyaDVqUTMrQi9YSU5tcE5QWlNs?=
 =?utf-8?B?djZKVXRPUlB1RkZjTTRVQU5PZ1c0Qk9tWGxTWS8zN2JWU2NNVGRtUkNxV1dG?=
 =?utf-8?B?NjRzWTN5L2c0UVdJb1liTlVkeCtEMk5ZWHVCVlo1cmZHT2prZXc2NmdrdFdm?=
 =?utf-8?B?bTFpMXdaK3k3SEZ3SDdjbnM1aDJqbTVmYVZEaUZBMUhkRlIwSFlWMWVjeGpN?=
 =?utf-8?B?Q0pDNXRTSnJ0SmRrY3JmWXRPR0RyVEQ3UHZmbTZMcDhkZEZhaFpISmdONG1o?=
 =?utf-8?B?Mnp3ZG9JZjZ3a1dFQ1VhMWltYzZrQ0h6VDdxZFNGR2E0dkZzT1BKYXBmY2N5?=
 =?utf-8?B?aVFUNWxHaVdSMDlhQzdGR0NZejcrNDM5ZmpESmc4cGdLcExIem9Ha1lXOVRw?=
 =?utf-8?B?ODExNVY2Uy82MW5Sa1MxMVhyUXNJdDJyb2gxMk4yRTlhQmdEc1VxU29YM3F4?=
 =?utf-8?B?L2hjTkZrVUNLZEk3d3VoY1NoYnpMT3IzVmxxU0NpRHRJTnJuMWxMeFdhSFhP?=
 =?utf-8?B?NURDeU04cDVVKzRmL1F5Ui9OSW5Vbk4ySWtUbS82U1N3WUdmZTVtNDdXWURN?=
 =?utf-8?B?cHcrU2p5c2ZublpkQVB4cnlQbDVFaTVhSWtPL3puOFhWM0FBei9hQjBxMUNT?=
 =?utf-8?B?ZUNSMS9BT05Ba0RhbkVtM2R6Wi9rVG5MNTdYaGRzOEtqOHpYdnhTK0ljYWNv?=
 =?utf-8?B?cXlKSm1iUGJiQTRrdWJ2Zk4vNUp6S0MyRi9KT3Q4SERCbDhIVHdoYy9EUHll?=
 =?utf-8?B?SmllQ3d0VDUzd3hJWmR4OGlwRWhLcFphZStKSEF0c0UxTDVPNVN4VjQ4QVp1?=
 =?utf-8?B?RjBaRWR4eWkwcm5ZUjVDN085LzQyTHQxYjB2UERJYUFBdEJBM2I0Nldrak1F?=
 =?utf-8?B?TW1DM29SOHpGcjFGczdnbG1TSWl6UFlTMko0UFJmYkRzNjZMdmtFRWJrM1Bn?=
 =?utf-8?B?YXFONVJwUTFFWStJTkp2RkVsUnFKK0VkWnppdStGRm5lSzlLM1JWaHVtQjhv?=
 =?utf-8?B?SjNNdmdDRlhoNmR4QkdOQmk3cDVpUjdrYmlxOVhnMHp6ekhiNzZmZ25qVjJU?=
 =?utf-8?B?d1Jqd3dqSUF0M1FWL3pmQnJpaldZaHo0a1hsMFlkK3NKcWQreHA5TFlmazdJ?=
 =?utf-8?B?VFQxR2RoZytUTS9aNld2M0U3bnp5YlRrcW85VTdEamdYNVhBTlBOM1oyQ2ow?=
 =?utf-8?B?MmM2R1oxV2l6cEpWdVNtdzNEVlhoRGxKaGpDY0NMc09GZThoY1BicVQzSUxV?=
 =?utf-8?B?Slc5RU9pVmFvNnIzdlRSRDNhdVYwdWdKSlF4N1RKaEtiNEFWVy83bXNhNG1J?=
 =?utf-8?B?Mk56dFQzU0x1NmNueUtad1J2bmZEM3JjQ1NaUUZPZWZjb0h5Y3c5am1oL2hk?=
 =?utf-8?Q?dgtYRqSZK1g4FtnB35?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cc0a32-bf78-4775-dd8f-08df3bec33c0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:56:17.7922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCJppYlJqFAr+nu6gPtN8ZaQ6TVW9CJpRrmVFhfo6NlXcVQT80COYEPwp/OMSNeQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Christian König <christian.koenig@amd.com>

On 11/6/26 08:02, Zhang, Yifan wrote:
> AMD General
> 
> This patch is
> 
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
> 
> 
> -----Original Message-----
> From: Yuan, Perry <Perry.Yuan@amd.com>
> Sent: Tuesday, November 3, 2026 3:43 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
> Subject: [PATCH] drm/amdgpu: add a debug flag to disable the userptr size limit
> 
> The GEM_USERPTR ioctl now rejects userptrs above 1GiB. Existing applications that register larger ranges fail with -EINVAL, and the limit might need to be adjusted based on customer feedback.
> 
> Add AMDGPU_DEBUG_DISABLE_USERPTR_SIZE_LIMIT (amdgpu.debug_mask=0x4000) as a workaround to lift the limit, and print a one time warning naming the flag when a userptr is rejected for its size so affected users can find it. A zero sized userptr is still rejected.
> 
> to disable the limit:
> sudo modprobe amdgpu debug_mask=0x4000
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 7 +++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 8 +++++++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5a32b54b1e9b..0355af0433ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -959,6 +959,7 @@ struct amdgpu_device {
>         bool                            debug_enable_ce_cs;
>         bool                            debug_hibernation_thaw_resume_gpu;
>         bool                            debug_disable_ip_block_soft_reset;
> +       bool                            debug_disable_userptr_size_limit;
> 
>         /* Protection for the following isolation structure */
>         struct mutex                    enforce_isolation_mutex;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 5e0029530b79..ee5e61718151 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -150,6 +150,7 @@ enum AMDGPU_DEBUG_MASK {
>         AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU = BIT(11),
>         AMDGPU_DEBUG_DISABLE_IP_BLOCK_SOFT_RESET = BIT(12),
>         AMDGPU_DEBUG_SDMA_RB_CMD = BIT(13),
> +       AMDGPU_DEBUG_DISABLE_USERPTR_SIZE_LIMIT = BIT(14),
>  };
> 
>  unsigned int amdgpu_vram_limit = UINT_MAX; @@ -1092,6 +1093,7 @@ module_param_named(seamless, amdgpu_seamless, int, 0444);
>   * - 0x20: Enable experimental resets
>   * - 0x40: Disable ring resets
>   * - 0x80: Use VRAM for SMU pool
> + * - 0x4000: Disable the 1GiB size limit of GEM_USERPTR
>   */
>  MODULE_PARM_DESC(debug_mask, "debug options for amdgpu, disabled by default");  module_param_named_unsafe(debug_mask, amdgpu_debug_mask, uint, 0444); @@ -2345,6 +2347,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
>                 pr_info("debug: enable SDMA RB command switch\n");
>                 adev->sdma.sdma_debug = true;
>         }
> +
> +       if (amdgpu_debug_mask & AMDGPU_DEBUG_DISABLE_USERPTR_SIZE_LIMIT) {
> +               pr_info("debug: userptr size limit disabled\n");
> +               adev->debug_disable_userptr_size_limit = true;
> +       }
>  }
> 
>  static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 348693023563..77e0e063147a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -567,8 +567,14 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>                 return -EFAULT;
> 
>         /* Userptrs are for temporary uploads, not a general memory allocator */
> -       if (args->size == 0 || args->size > SZ_1G)
> +       if (args->size == 0)
>                 return -EINVAL;
> +       if (args->size > SZ_1G && !adev->debug_disable_userptr_size_limit) {
> +               dev_warn_once(adev->dev,
> +                             "userptr size %llu exceeds 1GiB, set amdgpu.debug_mask=0x4000 to lift the limit\n",
> +                             args->size);
> +               return -EINVAL;
> +       }
> 
>         /* reject unknown flag values */
>         if (args->flags & ~(AMDGPU_GEM_USERPTR_READONLY |
> --
> 2.34.1
> 

