Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FE7606A32F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Et+yUqK2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37DC9112463;
	Thu,  5 Nov 2026 13:57:34 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010022.outbound.protection.outlook.com
 [40.93.198.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 524A611248A
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 13:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+gBjOj0ESkAHYqsXDVRGhwM56elRXwQQF0ixIIu4fi0aSUJQ3aPa60QfqNXbUYuiC4TEKPvI+evUjwkgU1TVt4t6MYksFNWMnYbItivA1cOE2YrRDHaJ0uWpyU5F2rhTQTtkyldqLGBrNbWs2WH/EGgY6l5n7apKjW3ZZuiBG1LKqLTZvBT3c+RJ3LF5J0A7R9jkCqv+PzqszScfYq3D+1X1iohEQEXxsm+4WPiig207AbG4Z+OpcPP10xa7H8YKQk2qe5Fc9DYi4ZEE8N4lDa8ZOCZ+35/5F7kHP8qduUPbV2CpCc8syse6l2oIK0cQe13Y5rDK7d1BOaUUdDNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOgx8pgGLmdgx9hy1kQLZLrbdlxfVqcVYqI/nVnXr+o=;
 b=dRha0r5UmTTZvMN2LAk2S+4I2zIz6dY8DdEbpot2JM2be/BnKMjIiNuF+S0NhuDiUGpVT76GgEJMKCpANWhkUazFaTC4j+/irWV3YlaljEQZX9mkKuUVwur4BZi00LAXLT+FuQf80KcagtlERzO3OMKE7ZGA+fvwdsJWMVwpAeodXPJ2m+8Ex4acOae1ahPFAwGqf4ln0TgQd5oyCS73kfGr1uz/rSNHEScuVoHdivqCKh4yyTNBexsE3091mBJSPE/z7YyGttvr0Zizz/UJAim9MnInKKgH6S/qpBt5fNd+xleTCwcqyKFEc0mciIVSrH0D14mLQAyS/JKIvkMPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOgx8pgGLmdgx9hy1kQLZLrbdlxfVqcVYqI/nVnXr+o=;
 b=Et+yUqK2PsFueKMCXwyA+ad9xwJB+w7WO1NlE+pABtb4ZByPvH2PxBebx2Cv06CEgqF+VxoNgFB+EIOl9inaq+7UdcJ4O64I5bg53L0hCrsQHbT7o836DFrj2P585IWgtgbVI4Uthyr7Dp2b+VdN07T3wXCnGhoRHvfvgoKavyk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS2PR12MB9800.namprd12.prod.outlook.com (2603:10b6:8:2b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 13:57:23 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 13:57:23 +0000
Message-ID: <e68b5ad7-9d64-4aba-9691-5a549582542a@amd.com>
Date: Thu, 5 Nov 2026 19:27:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: reinitialize MES KIQ across a partition switch
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Mukul.Joshi@amd.com, Harish.Kasiviswanathan@amd.com
References: <20261029203412.3224512-1-alex.sierra@amd.com>
 <20261105135053.3501763-1-alex.sierra@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261105135053.3501763-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0061.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS2PR12MB9800:EE_
X-MS-Office365-Filtering-Correlation-Id: b82cfecf-fac1-4588-619a-08df3b44b730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261021123027099003|261026121527099003|261102123227099003|261009223027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: BwsW8VOM1bCzAFnRzn7WxC1XQf6wek35XC4VlCb9avfpPF/YBUXys/RBxTyr7sb1KeQVNUDBd/Jxoy2KVfRhdnM4zOjqBSUFvIj96ZTMmGj81th7t8klNQP8lxx4d0j+SZRAaV1wyB3PctnYH5zQagqHMqd1U7DTKWQ/qHPjjAz1L9QzmFlrrJ3L/IWD6gUN1HeBLTkZN8DIpyGyfZob5D2WyXInUi5oEY3RmVdzTUyNV4JmmzQ581T3kzKNOtir5Y4xR2BgfCqBPf/Ql7514IA5wcjM0YQy+923Wm47av3soPlQB98WNpKg8OwAPFQGitJjVldthT9AcdBfWIkuBjrPcpjliYliDfaEHfnBgls43snDBKIhv5XkT3LkeP+Mw47sa96dP2k3MbaDSic74QeoedspiJx7XY3KzUyrHYkOb9c3QW/vmhH6IvpuCY3TbIhV8TjlhVepkcFQ62z4xXlvNrH3lxh0xW8ezMRhNm17LxpipR90x+//DVIQjO0LEeulTqZiAUA2HtJ/ONuBFVhtUIcFS9nnzbn5D81fr57YfvtI3uJTn2L/4xT9lpbwr4oLUOTYwXH8Zk/qBGHQ/V7nMW8RVwCW/PkWXtFAOosKdP7Gm6HdoG44ZrZfBLDs1Rfp6rdlZBIm3ccjCQAhcDZzdnJCvb2mi6ew8W2jDv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261026121527099003)(261102123227099003)(261009223027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk1aWEdlM1BNY085OEZ0cTByKzlSTisxcm53bXgvUWhoeG9tcGo1aFRKRll6?=
 =?utf-8?B?Z25QdzBIL0Q0dWNtV2xxVDlKaWxYRkhNSVNiLzRjQzVIVnM5dnpJU2RsQmN6?=
 =?utf-8?B?amphUmErdW1DbzNlSXhvN1dOS0hhN2g2aStxbUZPci80alNnOG1GZmZtNmRj?=
 =?utf-8?B?ZXIwQ3FSSm1hSEU4MCtCS1NQTUw4VFpWMUU1TlovbE1iaWNIVmExMEgzaDdn?=
 =?utf-8?B?Q3M4ZU0vYk9rN1BxcitHSE1DMHRPeERmNXFwcXJHZ3VSMWYwVVVZb2JZbDhF?=
 =?utf-8?B?NGlCNWpBV1pnS21YbkVCVnVYalhWbTdTKzJ3NkY0cURLVmo0dXBJRGg4dEhT?=
 =?utf-8?B?ckU2c3IveXV0NWRBSnhGU3FMTHdzZUVPQ2pCdytGSW5rTGY0dHpXWUZad3dq?=
 =?utf-8?B?K2N3b1hjb0tjMTFyR1ZTd2RwdnVJR1U5ak9sMmZZTndhTVk0dUVkYWFrZ2pS?=
 =?utf-8?B?SWZGbUsyTXFYczA4MGtlaW1POTlCK0c1Ymo0WEZZN013OFFmU3BFckVUa0R6?=
 =?utf-8?B?bnN2cmlpWDRKdkdxWFVFdW5zbTA4ekVrUVdkUy8xamY1aUR1NHJCOE91OXZr?=
 =?utf-8?B?dW9lSElnNWp1SGN5ZldoYUJ2cEoyNzBxemEzTlFlblhYRWdXNEpXT1VuaTI4?=
 =?utf-8?B?bzU0TldGSFI2Ry9SejErME5jb1hGMFBMQlYzenpCb0lGcktsQ2RsM0FRREts?=
 =?utf-8?B?N250VjJPMEttNTA1dnNGSFBKSVdEL3o3ZG9FUDhUeGV3RlBHT2xUVEJOVUxt?=
 =?utf-8?B?WDNNZWxuWkZiVnVMRVBkMVhrM3lIUTcrU2VDT1VjcDRYM0R6TUhyQnlicUxj?=
 =?utf-8?B?Mm5nQnAwcE5Hd3M3aVliZXpPQUY2WkN5UnpWMWVtK3VJVzNNSHFnRDVFSXp1?=
 =?utf-8?B?Ni9LTndicFpvM3EvMjFsNHZ6YXlOMlBCYytyWVppYWszc2gvUEdHRGZ2dHZU?=
 =?utf-8?B?ZjNPRklGc2VmdkpxYVV3UER6WFJ0Mmo3eFUwaUMxL290ZnB6N2lNd0hjWUFl?=
 =?utf-8?B?QUhneDBFcW1pRHUrV0xKMXYxMXg4V1dJZVpqUy9WV2pCRDJUQ1cxZnhoZmRz?=
 =?utf-8?B?d0NpcTJZU1AxdEhKVkxzMmtkV2p3VThHamZkSXNnOVdlUmx1bmkrWDdaK0h2?=
 =?utf-8?B?YzRuNUZ2b1hoNDhkdm9RN3JqVkdwQTNWTU1Rd0pxWVhDRm45ck4zNDhoTllE?=
 =?utf-8?B?YjREYTdCV1l3dWtlVlRkYyt3enM1VTF2dmVxY3RRNHNVREdQV0d1aVBpOUJG?=
 =?utf-8?B?RHlCZ0lWSms2dFRrVmVKT1NQbnpHc1FWditxNkVRUjBsL1FhZW5FUUFMU1ds?=
 =?utf-8?B?SEF0TlRPcTVwVHJvTTJBa1R1Y1VtMDRmVjlha2RqNFllWWVvWmF2b2lvY2NU?=
 =?utf-8?B?V1ovYXlINkxwYUdSWmFxSEFORFJhamZvcTJ4SDV3eUt3a3F6eGcxeWdiazJi?=
 =?utf-8?B?UVg4WXVNMDVBcnBqT3Ivamg4NVpzaEIrMkwyU0MrTlN1aWR2VlIzemZ0Tkdl?=
 =?utf-8?B?TTJ6NjhZeGFNWVBwUGpVTXlKcnVQa2RBbGRoQWd2ZHM2bm1hS2UvU1ZoRk9t?=
 =?utf-8?B?cW9RaUk3djdjTjRZeFlLcFo5T1VOeUxMSzdYQmZFaU03QW9CbGhOd2FlZ2w0?=
 =?utf-8?B?SHBoR2JYbXZDdUw3bkRobkdpL1FjRTBHeUIwOWxOZm5ha3lZeXBSTmIzRDVJ?=
 =?utf-8?B?MFB2WVJLbUdOK01tUEhiQThDb1VZSEJoTk1UbWNzaEo4d1R5RXFhTVhzQlZV?=
 =?utf-8?B?UlhObDFXN0lUUndGVFREaEw3NzhMZzZIL0thVVRGTWJ0WVJiZnB5V1NYZmZM?=
 =?utf-8?B?cVhTM045VUtRK01Nb2xzVlZWRWMzd2U2S2k1WHZlbzFwTWR2TzFhSHBhcytV?=
 =?utf-8?B?UkxyKzFPd3hQNnREWWhDcjhsNk00SCs5THNRa3VsRnorc2cxMzZ6dmQ3OW5w?=
 =?utf-8?B?Qit0WW5OOFZGLzhhSzhSTGhGMWtXMzNBbU9yR01KOTFlT0ZkZVBwdUd3TC81?=
 =?utf-8?B?VW4wYWUweUJBVzBhK3piTWI1TEVIbi8zNHdJWllzYXBZSElkdUoxZ21vTXY5?=
 =?utf-8?B?YnB0YWJ4TFh4bmhmbm8yWHJiS3V4NmdGUFc5U2NzSW9LUlZxYURDdWltMFM1?=
 =?utf-8?B?ZGxxWjJHckg0c3VnVVdOcGVDL1hXS3FUTlFEUFptVk9pNk1JV0ZrWllRQ1Z0?=
 =?utf-8?B?b0QzdFJKOUowUlRvMExCZmVVeC81NDZ5TVJ6Qzg1aXFTY3JNV25QV0NyQTFu?=
 =?utf-8?B?V1VRcThaTHlZVmlOakp4ciszZG1ITTB6cXJKV2lNMUNvTG9KZ2h3STY2UW5D?=
 =?utf-8?Q?v7INcSBsZU3Wuambis?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82cfecf-fac1-4588-619a-08df3b44b730
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 13:57:23.0568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/3MgsKwm5qNfjc5vN/A6JkfoTZtWnuvQI0PVw1S2cTrdH0+qjgrD3c261JdAMiy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9800
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



On 05-Nov-26 7:20 PM, Alex Sierra wrote:
> A runtime compute partition switch updates the XCP mode and IMU
> partition without passing through MES hw init. The MES KIQ and
> scheduler therefore remain programmed for the previous partition,
> including its cooperative mode.
> 
> Stop KIQ in amdgpu_xcp_pre_partition_switch, while the old partition
> is still in place. After the new mode is committed, start KIQ again
> from amdgpu_xcp_post_partition_switch, before KFD recreates queues.
> That init remaps both queues and sends SET_HW_RSRC followed by
> SET_HW_RSRC_1 with cooperative mode enabled for SPX, DPX, and QPX and
> disabled for CPX.
> 
> The calls are gated on enable_mes_kiq. If the switch fails after KIQ
> was stopped, start it again for the mode the switch settles on.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 14 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 51 +++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 72 +++++++++++++++++++++++++
>   3 files changed, 131 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 652cd0950453..cd020959192c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -141,6 +141,14 @@ struct amdgpu_mes {
>                                                      uint32_t xcc_id);
>   	int                             (*kiq_hw_fini)(struct amdgpu_device *adev,
>                                                      uint32_t xcc_id);
> +	/*
> +	 * Partition switch: stop KIQ before the hardware switch, start it
> +	 * again once the new mode is committed. kiq_hw_stopped is set by
> +	 * the pre callback and cleared when post runs.
> +	 */
> +	int                             (*kiq_hw_pre_switch)(struct amdgpu_device *adev);
> +	int                             (*kiq_hw_post_switch)(struct amdgpu_device *adev);

Suggest to keep it generic like pre_px_switch and post_px_switch. Other 
preparations specific to a MES situation (enable_mes_kie etc.) may be 
handled by the IP specific callback.

> +	bool                            kiq_hw_stopped;
>   
>   	/* MES doorbells */
>   	uint32_t			db_start_dw_offset;
> @@ -572,6 +580,12 @@ struct amdgpu_mqd {
>   	(adev)->mes.kiq_hw_init((adev), (xcc_id))
>   #define amdgpu_mes_kiq_hw_fini(adev, xcc_id) \
>   	(adev)->mes.kiq_hw_fini((adev), (xcc_id))
> +#define amdgpu_mes_kiq_hw_pre_switch(adev) \
> +	((adev)->mes.kiq_hw_pre_switch ? \
> +	 (adev)->mes.kiq_hw_pre_switch(adev) : 0)
> +#define amdgpu_mes_kiq_hw_post_switch(adev) \
> +	((adev)->mes.kiq_hw_post_switch ? \
> +	 (adev)->mes.kiq_hw_post_switch(adev) : 0)
>   
>   int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
>   void amdgpu_mes_validate_fw_version(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index c29a60d6f0a6..4bdd9b60a35e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -212,6 +212,20 @@ static int __amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>   		else
>   			xcp_mgr->mode = curr_mode;
>   
> +		/*
> +		 * pre_partition_switch may have halted MES KIQ. This
> +		 * failure returned before post_partition_switch, so
> +		 * start KIQ again for the mode settled above.
> +		 */
> +		if (xcp_mgr->adev->mes.kiq_hw_stopped) {

Ex: this type of check will be inside mes post_switch logic.

Other than that, the patch looks good.

Thanks,
Lijo

> +			int kiq_ret = amdgpu_mes_kiq_hw_post_switch(xcp_mgr->adev);
> +
> +			if (kiq_ret)
> +				dev_err(xcp_mgr->adev->dev,
> +					"Failed to restore MES KIQ after partition switch failure: %d\n",
> +					kiq_ret);
> +		}
> +
>   		goto out;
>   	}
>   	amdgpu_xcp_sysfs_entries_update(xcp_mgr);
> @@ -721,27 +735,52 @@ void amdgpu_xcp_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr)
>   
>   int amdgpu_xcp_pre_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
>   {
> +	struct amdgpu_device *adev = xcp_mgr->adev;
>   	int ret = 0;
>   
>   	/* TODO:
>   	 * Stop user queues and threads, and make sure GPU is empty of work.
>   	 */
>   
> -	if (flags & AMDGPU_XCP_OPS_KFD)
> -		ret = amdgpu_amdkfd_prepare_partition_switch(xcp_mgr->adev);
> +	if (flags & AMDGPU_XCP_OPS_KFD) {
> +		ret = amdgpu_amdkfd_prepare_partition_switch(adev);
> +		if (ret)
> +			return ret;
> +	}
>   
> -	return ret;
> +	/*
> +	 * Halt MES KIQ while the old partition is still programmed.
> +	 * Devices without MES KIQ leave the callback NULL.
> +	 */
> +	if (adev->enable_mes_kiq) {
> +		ret = amdgpu_mes_kiq_hw_pre_switch(adev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
>   }
>   
>   int amdgpu_xcp_post_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
>   {
> +	struct amdgpu_device *adev = xcp_mgr->adev;
>   	int ret = 0;
>   
> +	/*
> +	 * The new partition mode is already committed. Program KIQ
> +	 * before KFD recreates queues.
> +	 */
> +	if (adev->enable_mes_kiq) {
> +		ret = amdgpu_mes_kiq_hw_post_switch(adev);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	if (flags & AMDGPU_XCP_OPS_KFD) {
> -		amdgpu_amdkfd_device_probe(xcp_mgr->adev);
> -		amdgpu_amdkfd_device_init(xcp_mgr->adev);
> +		amdgpu_amdkfd_device_probe(adev);
> +		amdgpu_amdkfd_device_init(adev);
>   		/* If KFD init failed, return failure */
> -		if (!xcp_mgr->adev->kfd.init_complete)
> +		if (!adev->kfd.init_complete)
>   			ret = -EIO;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> index ec595449963e..0957e56bb069 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -46,6 +46,8 @@ static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int xcc_id);
>   static int mes_v12_1_enable_dbgext_irq_xcc(struct amdgpu_mes *mes,
>   					   bool enable, u32 xcc_id);
>   static int mes_v12_1_enable_dbgext_irq(struct amdgpu_mes *mes, bool enable);
> +static int mes_v12_1_kiq_hw_pre_switch(struct amdgpu_device *adev);
> +static int mes_v12_1_kiq_hw_post_switch(struct amdgpu_device *adev);
>   
>   #define MES_EOP_SIZE   2048
>   #define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] = db offset [4:7] hqd info */
> @@ -689,6 +691,14 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_mes *mes,
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
> @@ -1611,6 +1621,8 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
>   	adev->mes.funcs = &mes_v12_1_funcs;
>   	adev->mes.kiq_hw_init = &mes_v12_1_kiq_hw_init;
>   	adev->mes.kiq_hw_fini = &mes_v12_1_kiq_hw_fini;
> +	adev->mes.kiq_hw_pre_switch = &mes_v12_1_kiq_hw_pre_switch;
> +	adev->mes.kiq_hw_post_switch = &mes_v12_1_kiq_hw_post_switch;
>   	adev->mes.enable_legacy_queue_map = true;
>   
>   	/*
> @@ -1881,6 +1893,66 @@ static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int xcc_id)
>   	return r;
>   }
>   
> +/*
> + * Runtime partition switches do not pass through MES IP hw_init. Stop KIQ
> + * on the pre-switch side, while the old partition is still in place, and
> + * start it again once the new mode is committed. The post path maps the
> + * KIQ and scheduler queues and, through setup_coop_mode, programs
> + * mes_coop_mode for that mode.
> + *
> + * If a scheduler ring is not ready, MES has not been initialized yet and
> + * the kiq_hw_init call from CP resume covers this mode.
> + */
> +static int mes_v12_1_kiq_hw_pre_switch(struct amdgpu_device *adev)
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
> +	adev->mes.kiq_hw_stopped = true;
> +	return 0;
> +}
> +
> +static int mes_v12_1_kiq_hw_post_switch(struct amdgpu_device *adev)
> +{
> +	int xcc_id, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> +	int r;
> +
> +	if (!adev->mes.kiq_hw_stopped)
> +		return 0;
> +
> +	/* Cleared first so a failed init is not run a second time. */
> +	adev->mes.kiq_hw_stopped = false;
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

