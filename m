Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDC2606A9DD
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZuM74dwW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB2A810E3E5;
	Wed,  4 Nov 2026 15:58:03 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD87E10E3E5
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 15:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyUb6YLGl09ntBy29lQ/9y/EOvgbbZSuk8OB7CdanHRmezkRhLdljinCOoVvmd14GBaFLc7yFBW0OmB4e0x2zTZZUXbXNmdkdPbQAvE1bizU0LJFPmuc0z0mYxhJrlJOMQMvNEW1yE5Xe+PpUu5h72QC1YDB068XWqVn62RexdHupJMD1V9ZV7re5T0930NUt5nZ0qWkqXz/VMI1xt73su0oVmNCQRWMtwD/mp4n8CDK3Dz3MwkPhnjfla+jegtM0XWmYBG+onnUwhp+Zhyw8YhIOd5jOnZcusCtv2FlBykIcEBObcW511i8HUT6TkMO4b3ifmn4NdzByYqscJc91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0A/aw5pldudAKjgTyeC6PUTPKgRJMAhqDGyXOsEYexE=;
 b=f8SqwFQs60egXxxqO7zRuBLFZVTNEets/YfU5iQ2ppvPXBZZv9G9NPmzvu99GuOu5VB+K9n+L1cOJ/noc5jYWd/WhWTpEZXSk4R7jaZ7oG1HQKAQFoJ+dr1i4tbxvb9CrtNTi8EnQjJCW8Wd1j7J08Rhpm89WgXcReMb21SPsX0jVoMc7KOAh+L/sa1PhzfMrGUKFzOvyYPFtlusIcpHEVlc6aWZKJ2I/PLN46A1dch6q3zNISoKgjhUn6gbL2WxaoXPKskTC4fUiV3B8k7ijm0cpkFBwerNs1tJIOCABWg+QMRJ1zxNZzyPJD3oRfeSn9kWw2O6Jdcw8eVpqf8xfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0A/aw5pldudAKjgTyeC6PUTPKgRJMAhqDGyXOsEYexE=;
 b=ZuM74dwWnJNetrRDlDesI5h2e28ocEn7Qmuur4YozlsfUSPpxxQX4rqgPmUFE0p+mMcXFVNlsjuHkJj9P/W49Wg1h7a7N7M+N716oyrTy3u16ZaZ8xWo7QJkJoK/+CiyRR6LpNeQRJcAEqOnMTmID9RYGXNwb0jR2/1Gjy1bWII=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY8PR12MB7754.namprd12.prod.outlook.com (2603:10b6:930:86::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 15:57:54 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:57:53 +0000
Message-ID: <1f1d9758-c480-4c07-a045-2140c539654d@amd.com>
Date: Wed, 4 Nov 2026 21:27:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: reinitialize MES KIQ after partition switch
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Hawking.Zhang@amd.com, Mukul.Joshi@amd.com,
 Michael.Chen@amd.com
References: <20261029203412.3224512-1-alex.sierra@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261029203412.3224512-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY8PR12MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 8484b30a-4187-4e0d-df60-08df3a8c62cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261022075727099003|261026121527099003|11063799006|56012099006|261028144727099003|261009223027099003|261021121427099003|261026140227099003|261022105027099003|10067099003|22082099003|261102123227099003|18002099003;
X-Microsoft-Antispam-Message-Info: pb9TbWDn3TDll8Vic7ZpAsu077r1AFmCoi0R9FHix3QQ8tjGDJwmOyKPfLaLTF5E8u3NLgW22eiT503yNFHkUFUBBUi6uVNYrw7y/13AqngQ1bTwNGxdhaJmiglHgv+v7HI7IWhwSo8L/4iFSQaZWKd8/+d4vOVkroCUknaZBlRZGVPuQ4T2s6lhU+ZoXkjbCwfbWIenvKxkgBMDbcdXD0JA42Odm5HStBDIDdRBazA04BJcO74lVKn4Xgwmtve8+oflglKP2kes2dmN5abPkj7kqoQRg2kB0EI70mFi4CRRxu6plY3evsrG1OjeK5eeJry/QiYbPUXOWBcabE5757rGFBGhnBnmIscd4yc1YQsMroeer/Q81vTJiWaL51IVukc03ZjjJzUJop1IlhZ/epWaN6G5hiBb6ere/jHDJl/zN7RbcnSdY0660rt3KeYaJ2Ngt/bI50mnPcsQmATe7PrgePMUf1yCWHJnRhe7D/AWtSfMlO5I5r03ABTPWGOzGHPSjx/BCH5Kvl/TRkTaBTpyhE9ByxJlslulyUBC2h2+m46q1gkV1D3S3wGJrMRuucO3KDJjGhNrM0ikCXgrpYlf8VahD+DEQRq6lOv65VPQOsIWv6tpDUvDVVXM/RlQjnms0ecTQMMWiyRB8PcDcCK+Scgt+jjajvtcWtVvoMM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261022075727099003)(261026121527099003)(11063799006)(56012099006)(261028144727099003)(261009223027099003)(261021121427099003)(261026140227099003)(261022105027099003)(10067099003)(22082099003)(261102123227099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3YycVBOQ0lINlU1RjZHZXozQzN0eDg1b3hTNFErbnI2blJaU2JoTUFQTnBG?=
 =?utf-8?B?MVgvLzd3N01BOHFiSlFObnFaNnBlTis2SU5ZUTJqR0VubDlSVjVuSlI1TW9r?=
 =?utf-8?B?TThNRllhNmNuYlpSbFdLQ3p4N05tWEpRc0FNRW56SjlwbEhja3pmQXNZaEFI?=
 =?utf-8?B?Wk00cXYwUXBQS0kxd2ZYd2JxUnc2WU5ZL096eVEwMnZhS3BtTzZqcGJlQVll?=
 =?utf-8?B?Z2FCRFc3V0t3T2dxa0hpeUMwbE91SDRBcGZ0RGJjbUFWcFl2SUM1MGluclhn?=
 =?utf-8?B?VWJmeVVwek43aDV1NXBYdktyRmd6ekY4bHlXQ0ovTXZUeGVaYmRBMGxCL1Jn?=
 =?utf-8?B?ZjlQeEZsekt1TVg5VjZDL2Y0djhnNS9icTQ4a2VxanNaQXgycUZVQ204SGU5?=
 =?utf-8?B?UnNEcy9xYVFZTGp5b0pvNnA3NXZpTW1nakRFUmJkK0k4NUNVcXFBTEkwNHRR?=
 =?utf-8?B?d3U0ejlueUFRT0xveEdTYTRSd3MvYmRRQVkyRTJ2WXBvamFnL1B5RnltZWNL?=
 =?utf-8?B?d041ZnF2cmp1UGNoNXFOdUZRdlAwbVh0RVM5SitvdkM4Q0F6Vnppd3VPM0lG?=
 =?utf-8?B?K2liSzAyakVRV01lbzluUE05Z3ROcExMQ2RhV2w0dVBqbVV6V1NiM2psY2dk?=
 =?utf-8?B?MVNKdnp2L3JHK0wzSXVMQnRkYmRLb0JtTzBodjAwQW5SbGxWN3VkUmF5a1Uy?=
 =?utf-8?B?eHJmTVhwWVAzc0cxT3lqQTZoLzc1NXV3L3pMSWF0am8rUnRTaTByY2hXZVhm?=
 =?utf-8?B?N0U2bVJaeVQyRkFoQkhMMWVGUU1PbU5FL2phVUkzS0lIZkc1M21wNVVma0FN?=
 =?utf-8?B?dzZXZFk4Uy85VktxbExLdWhYZis0ejB4ck54UkZTMnZpbExVRXdocjJjTzZv?=
 =?utf-8?B?cVN6SVlhL1o5ZUNEVkdpUkw4NWExVFpYdlhrRHBYZmVzb0lLRnh5UnR2Q00v?=
 =?utf-8?B?OGpBRWlHN2t0Mzk3VThuTVJ0VDFObVQwdFU0Y3lEOWM5U3UwUEtKYm5UaHFD?=
 =?utf-8?B?T2xXbHN3UDkvaUtYY2ticGJLYzRGRnZxWS9qdjFQeldJT0JJakxBM0NpNzNG?=
 =?utf-8?B?cU1JQUZGcjgxOS95RlE5OXQ3TGl3K0EwU3NSK1gwdnNpTXdONzBjTlcyMHkx?=
 =?utf-8?B?S2U2eUY4NnBGV3VjOHMraEdBWXlDMHFpTkExeFdqSXh3M1ZYdkRhY3hFbGNU?=
 =?utf-8?B?dEZnR1pFSnRZc1dmOGdmWUw1YTMwQ1BpS3RnZUlvZnQxRHdIbHoxVVVTcURZ?=
 =?utf-8?B?QUErR2NkekRDU2VPUHlMNjE5UzYzOXNJOGZaUFNOS2tkZUpqRGtOM3RoV0o3?=
 =?utf-8?B?WVRpWjJKUitKeC9jMVV4VkNXSkJqT2UrVkZ5RnV6S2h1TE1IZ1FuaVE2bU5r?=
 =?utf-8?B?WTJTWmpIS1VlaUh0blhNTXc5bnJwT3Bham13aWpCZGloNGlZK00xQW9qT3JU?=
 =?utf-8?B?Znk3Z3VXaGN0cy9vRFdSN0g5L2N5WXk1VWFpNE53NTVub3hZaEx6cHJEalRY?=
 =?utf-8?B?UWlUUko0eHNJOWd5a0tHVVRQNytTdm1LSHkxMENma1pRSkFLL0M1a0tQT0pt?=
 =?utf-8?B?ZThEZ1M5SUQ0dlBNajlEYWR0VUN5aVpnVU4vcWpISVY2MjNzZlIzUkk1SmF0?=
 =?utf-8?B?aEZwM3hwRWMraFExL3Z1NGNUOEhYU2V3U0o5a3lSOVNHUC9KaGt2emZFaWpC?=
 =?utf-8?B?VUkyczIvK3RSZVBwS3V6elFmUWh2cGM3U3VVTTgwYnRKOTk3R1haRVU2VHBx?=
 =?utf-8?B?TGNkbGZrV0tDSzE0ZjNlV1gzQ1QvMkNuL3lkK1lmdmZTNzRJQkQ5TzMvNUI5?=
 =?utf-8?B?OUx0anJNd0xiWkRrRSs1UmNnUjNaNjhra3Fia3B1M2E3Q1NpV3p6SnZSbE5P?=
 =?utf-8?B?MFFMTUpiOUxZbTYrWVF6V1RiVURYazg0ZlVMMGhRVFZScWhDZjlrdFVvV3Vm?=
 =?utf-8?B?ZCtGSzdGT2tsdUd2SnpyZER1MDZPbXRJazliUTlFTTNEeGJMYWZOT0NoS254?=
 =?utf-8?B?V25iWFE4Vk9SS1JVVDdTbm5mcWhFbDlJaTNTV1E3aWp3djVIQVhMZzBHcmgw?=
 =?utf-8?B?NnNJNUVYajg0R21USUhyU1A4SlJibUk1bzU1enl5Q2dvMm1EUHU4Ynh1NFg5?=
 =?utf-8?B?ZzErT2p2bnFLR2IrMHdhZE5uSWJzelJCSm1iQ3BkVUhycVBsK1MybFhmWHZ0?=
 =?utf-8?B?cm5oR29JaHAyVEJidWc5cFA1SVFIeGVJakdabXZGNEJzQVhpd3N5MzNJUE9W?=
 =?utf-8?B?OW42Qmtla3VLMGVJbUN3cStUMnBjUitEYlFoMVV0TTM5RTJEZTFnTVRrSUYx?=
 =?utf-8?Q?ZxiLAeRdpzP6XBkwz5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8484b30a-4187-4e0d-df60-08df3a8c62cc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:57:53.8250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTsgiFlqBkKRoFoqz0nXImTDNjlykjtxHl97BOpadJFz8DfrzZAqZ2GhqSADywRM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7754
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 30-Oct-26 2:04 AM, Alex Sierra wrote:
> A runtime compute partition switch updates the XCP mode and IMU
> partition without passing through MES hw init. The MES KIQ and
> scheduler therefore remain programmed for the previous partition,
> including its cooperative mode.
> 
> After committing the new mode, tear KIQ down on every XCC, clear the
> KIQ and scheduler rings and their writeback pointers, and initialize
> KIQ again. This remaps both queues and sends SET_HW_RSRC followed by
> SET_HW_RSRC_1 with cooperative mode enabled for SPX, DPX, and QPX and
> disabled for CPX.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  5 +++
>   drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 54 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/soc_v1_0.c   |  9 +++++
>   3 files changed, 68 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 0f368fbd2c80..5a14f4e7b64d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -141,6 +141,8 @@ struct amdgpu_mes {
>                                                      uint32_t xcc_id);
>   	int                             (*kiq_hw_fini)(struct amdgpu_device *adev,
>                                                      uint32_t xcc_id);
> +	/* Tear down KIQ, clear its rings, and run kiq_hw_init again. */
> +	int                             (*kiq_hw_reinit)(struct amdgpu_device *adev);
>   
>   	/* MES doorbells */
>   	uint32_t			db_start_dw_offset;
> @@ -553,6 +555,9 @@ struct amdgpu_mqd {
>   	(adev)->mes.kiq_hw_init((adev), (xcc_id))
>   #define amdgpu_mes_kiq_hw_fini(adev, xcc_id) \
>   	(adev)->mes.kiq_hw_fini((adev), (xcc_id))
> +#define amdgpu_mes_kiq_hw_reinit(adev) \
> +	((adev)->mes.kiq_hw_reinit ? \
> +	 (adev)->mes.kiq_hw_reinit(adev) : 0)
>   
>   int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
>   void amdgpu_mes_validate_fw_version(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> index 5573fe981a22..760c93740a7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -42,6 +42,7 @@ static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_block);
>   static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id);
>   static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id);
>   static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int xcc_id);
> +static int mes_v12_1_kiq_hw_reinit(struct amdgpu_device *adev);
>   
>   #define MES_EOP_SIZE   2048
>   #define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] = db offset [4:7] hqd info */
> @@ -674,6 +675,14 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_mes *mes,
>   			mes->shared_cmd_buf_gpu_addr[MES_PIPE_INST(master_xcc_id, pipe)];
>   	}
>   
> +	dev_dbg(mes->adev->dev,
> +		"MES(%d, %d) SET_HW_RSRC_1 coop=%u enable_coop=%u kiq_ver=0x%x mode=%s\n",
> +		xcc_id, pipe, mes_set_hw_res_1_pkt.mes_coop_mode,
> +		mes->enable_coop_mode,
> +		mes->kiq_version & AMDGPU_MES_VERSION_MASK,
> +		amdgpu_gfx_compute_mode_desc(mes->adev->xcp_mgr ?
> +					     mes->adev->xcp_mgr->mode : -1));
> +
>   	return mes_v12_1_submit_pkt_and_poll_completion(mes, xcc_id, pipe,
>   			&mes_set_hw_res_1_pkt, sizeof(mes_set_hw_res_1_pkt),
>   			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
> @@ -1530,6 +1539,7 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
>   	adev->mes.funcs = &mes_v12_1_funcs;
>   	adev->mes.kiq_hw_init = &mes_v12_1_kiq_hw_init;
>   	adev->mes.kiq_hw_fini = &mes_v12_1_kiq_hw_fini;
> +	adev->mes.kiq_hw_reinit = &mes_v12_1_kiq_hw_reinit;
>   	adev->mes.enable_legacy_queue_map = true;
>   
>   	adev->mes.event_log_size = AMDGPU_MAX_MES_PIPES *
> @@ -1774,6 +1784,50 @@ static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int xcc_id)
>   	return r;
>   }
>   
> +/*
> + * Runtime partition switches do not pass through MES IP hw_init. Tear KIQ
> + * down, clear both MES rings, and run kiq_hw_init again. That init maps
> + * the KIQ and scheduler queues and, through setup_coop_mode, programs
> + * mes_coop_mode for the new partition.
> + *
> + * If a scheduler ring is not ready, MES has not been initialized yet and
> + * the kiq_hw_init call from CP resume covers this mode.
> + */
> +static int mes_v12_1_kiq_hw_reinit(struct amdgpu_device *adev)
> +{
> +	int xcc_id, pipe, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> +	int r;
> +
> +	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
> +		if (!adev->mes.ring[MES_PIPE_INST(xcc_id,
> +						  AMDGPU_MES_SCHED_PIPE)].sched.ready)
> +			return 0;
> +	}
> +
> +	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
> +		r = mes_v12_1_kiq_hw_fini(adev, xcc_id);
> +		if (r)
> +			return r;

There is a amdgpu_xcp_pre_partition_switch. In case you want to do this 
before the actual switch. Then the corresponding post switch. It may 
need a check like mes_enabled or similar.

Thanks,
Lijo

> +
> +		/*
> +		 * The firmware restarts with its read pointer at zero, so
> +		 * leaving the old contents and writeback pointers in place
> +		 * would make it replay stale packets.
> +		 */
> +		for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++)
> +			amdgpu_ring_clear_ring_and_ptrs(
> +				&adev->mes.ring[MES_PIPE_INST(xcc_id, pipe)]);
> +	}
> +
> +	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
> +		r = mes_v12_1_kiq_hw_init(adev, xcc_id);
> +		if (r)
> +			return r;
> +	}
> +
> +	return 0;
> +}
> +
>   static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, int xcc_id)
>   {
>   	int r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> index 506060fc5368..95ebbd4a7369 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> @@ -1100,6 +1100,15 @@ static int soc_v1_0_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>   	*num_xcps = num_xcc / num_xcc_per_xcp;
>   	amdgpu_xcp_init(xcp_mgr, *num_xcps, mode);
>   
> +	/*
> +	 * xcp_mgr->mode is the new partition now. MES KIQ was programmed for
> +	 * the previous mode and is not reset by the IMU switch, so tear it
> +	 * down, clear the rings, and run kiq_hw_init again.
> +	 */
> +	ret = amdgpu_mes_kiq_hw_reinit(adev);
> +	if (ret)
> +		goto out;
> +
>   	ret = amdgpu_xcp_post_partition_switch(xcp_mgr, flags);
>   	if (!ret)
>   		__soc_v1_0_update_available_partition_mode(xcp_mgr);

