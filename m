Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB66EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 16:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A3F310E588;
	Wed, 12 Jul 2023 16:14:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3CA510E588
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 16:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cV2d3omakxlJPMn+UugoXjCxP3zyuI0580Bfke4e2FKLQGKT/SGjOTBw/9Yr40ABsjP8YGE5tkZjeI3/SxsWvbhc+FRJGDHXNc087qJix6Zf08RVS41xT0JWGZwfGlishLPSmmLeS235AU0Ks8HLjay2uG3NVtQIh92cLXaFxcd2L4KMEadnGYwxfEgeaZyOPuxQHVJ9G9MyLSkvPII1C5SEpQs6b1+RGCUg4A2ghYyTx53eaiVWk+qTjrDJT9UcFZ47XON34cqA09XPtCV1Bp2r4ORBHGy1AP6L00yjmx/H6pcc8D82LE9W5jSDVYLYZ20KVd7d0bduQ1Ok6/rLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcQlSk7daEvGbtRlcVsAts9pF0G2YoavN6Ab/GKzG+Q=;
 b=StCurLPGTsMvZi4rlhhAiohw3QCBzZPQfBdvBEz54GmtzbJ6eKEBYNaB90bulSk8CxUheH2M9xR6z0CsgapBtlwAPlN8oYM7TVy2R9Rrx2hSMcviPc0HhYiETqiqNBWMwWcpUcZpaL8bqmI85nSqdADyvZnGiiYaWafbK4tnkf/9ojhWbkusqq1gVnKLv/GxDpNJNqkOneJ+KDvDtK7zmsoaEWUMSFzlSybpGlC0ftZOJ1Gx8l8AI+MTtAXGKvF+BT7bRd7OKqtcIDkT95IctTCkWNjYytoZx42+bJGNn/J9C47ybj0pM6yq5LSq/ETR+mpRSNeKlask0n8FZYae2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcQlSk7daEvGbtRlcVsAts9pF0G2YoavN6Ab/GKzG+Q=;
 b=ZsDHvsSpzFjyORggePg4Z381S879coQ+MuIMiICYfxmbok7Ft+1FHHr53A/zjB4zOBTlju5N+qmHbBs6HqxcQi6pR4mIr/2zTDnFK7x4CzbpfVekFiQgJHvKw5Q+YukK+rCwaNdeoNfSDnAEnKQN/3FWAj2lO9esfSNGAhflYOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH0PR12MB5347.namprd12.prod.outlook.com (2603:10b6:610:d6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 16:14:46 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd%5]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:14:46 +0000
Message-ID: <a2698f41-1b84-7d99-b167-70d79c33fff8@amd.com>
Date: Wed, 12 Jul 2023 12:14:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] drm/amd/display: Eliminate warnings in
 amdgpu_dm_helpers.c
Content-Language: en-CA
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
 <20230629044635.2266729-7-srinivasan.shanmugam@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230629044635.2266729-7-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::35) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|CH0PR12MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: 7932c764-3395-4f4b-263d-08db82f31bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+W6I9DkfrvNRzJeS1GjSlFC07A7TLzBMck6xYxOKJ+3fl9L6OAPs4h6oQ5qFFD+f3mNItw0b3RqLfwoElWDGwQMvqBqi0Czvpx5dzSEY/ghV+XyNuShmFvUMu0jNcPIg6XsYtV0LtkQEJAf2jaIVEWvkFGhPQOVxj7ykUL8CP2sI96p4GlORGv8l25JP+Qee9ZkPJc4cZAW6jlyN1T6IHYsOzTIzWAQYwjKjmQkJ4rnhSXoJvGJuJ7g5pZ+GlKELizqNHjCptzfGNjqnPSHXFS5+tPq1vKa06JPkz4vwjzc43DXgGS2g0W7NC38gCbi4jAtevFdDlPjzCmrPc/JrWZ0PlfjVSoHQ1GDpTKbkD8GmRFzIM8PoDALwM+VYRP/gINPgokhYa+Oj0EZ06t9mjXgofW74KNBOIYnW2Y2BWljBI0CKUPV47zRgv3BN9zKNLW9IPJSxtZioakNLTyU0OjObLvzfcSA2Clf9wlTJAcJzwzR+U+SrIBzcuApLksecbHTs17MQMdRhDL9HX0z6Hsn1YYQMePY4we5GO3FoXivlYhtBhNbz3qDSguE0bL7RiQqQGEcS09N3eJnEa2BFK/HoVw+odzWTKv/YBiQ+9UWdJOWQx2u6RiLeB+w3ogs8Q7bx//XalqYxX7OMuxuUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(6486002)(186003)(86362001)(6666004)(2616005)(31696002)(478600001)(110136005)(53546011)(6506007)(26005)(44832011)(316002)(8936002)(8676002)(36756003)(41300700001)(31686004)(5660300002)(83380400001)(6512007)(66476007)(66556008)(66946007)(4326008)(38100700002)(6636002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkFZWG5hVzd6dG15eE53WmFZL3ZzQTgzUGtxdE43SFk2RllVd1VvazlSMWNm?=
 =?utf-8?B?WDJxcDBXNGN5eDdlY0liRVZwb2ZnNStJUm1JZ2E0NjNIWFNvdVUxKy9kTE1O?=
 =?utf-8?B?MVVkaGNNQTNxMVREMnJ0QXNrUmdZc01tRzNGRmRzWEREK1NIbXYyZWdpb0Nz?=
 =?utf-8?B?dEt2WFJ5TWZqcWhaVDUwU0lWVjBOUVM4LytTL25MdExWcWFLeEJoK3FIcm1K?=
 =?utf-8?B?bHhZaTlGOTBwNm1SaVVvVXhpQjJyNlNreTY1eE5DNGZXZ2hxbXk5eFpHcjMv?=
 =?utf-8?B?RWNOWEpodEdGY0xwcmFJUjQ4bGFUTnh3Tk0yNWJzUm5RMDk4Y0ZWSlNsRmd0?=
 =?utf-8?B?RWtFcmJMajRPQ24yMEVBYlNGZk56ZGdXdkozUHkvOTJjZ2tzSWRUckRKZ3Z1?=
 =?utf-8?B?dHlhMnZUeVc3VGJrUzBXTyt1T1ZCeXppN2taSVJjc25KR0tIL2JVQ0U3aWx0?=
 =?utf-8?B?eGZqZTZWVVROTC9icjMrRFFWOWJlT0hGOEQyUlRFQ3FNaVZzOG8yWkFVS2hJ?=
 =?utf-8?B?bVdmWlpYWnJhS1BtZUpXRXRST0J3d2hiZFp0UVJqL3RTVEdiWGNsY3E3R1d5?=
 =?utf-8?B?Zy9DSU02b1RTYml6L1BLZGR0SnQ2ZHFKT0tRdUMvejQ3VVpmWEd0VWNFWmJC?=
 =?utf-8?B?QXJ0bXhDL2xEeVFIeXVPczRqUEIxZHgxYXFodDI2OXZPTVloRm5MQS9RNWJU?=
 =?utf-8?B?dFd4c3d1b3Rwa1o5RkE5Y291NjFJZ3Y0dEM1V0dtSDV0bUJjbm1jNHlKL1Z6?=
 =?utf-8?B?Q01RZ1VpcFVqMWxvK1Q4aDBHM1FiZmgzTkd2NXFFZ1RPQTB2eHlDeHZkYVZ4?=
 =?utf-8?B?SitVd1RMaDJsZ2VEYkxsZFlmRnpBdDNyZHo3L2wvbHFEbm13YnQ2L1U4ck1N?=
 =?utf-8?B?YUJuKzdzcExKUHgxNEtIVnBhajA1Rnl5YjZhclNsZlphcm1NK21pSW1rU0tm?=
 =?utf-8?B?MEt2bU5maWxZS1dSY2tqTHZYS1hhTlpoYjdvcXhWdXM5WHpBTmhCMW1XL1dr?=
 =?utf-8?B?R1pLbkdNSjdiS3BibHdnMzdQeFR3YzVFQlYvZzk2M2RYMHV5Y1Q3Y0FGSy9Y?=
 =?utf-8?B?WXg2bWI2QmlIRmlwMkRrZjFnZ2pHTGh0bzhtNDVXWS83VFpzRjlFeU92NU12?=
 =?utf-8?B?Zk56Z1hQcWozY0k5aTZsUE1ETkhxNTB4NjVxNDV1eFlNeXdGMC8ra05lNEpR?=
 =?utf-8?B?d2F3VWFackRVTW52eS9TNlcxVEFNRWVKKzdnSk5qKzdIa3NvSGpXV0lDdHVI?=
 =?utf-8?B?ampodjk0REZOUXdzSDE4WURMclNDVmoyUGlVTmRWM2dpQ0hRcG5yeXpLQ3I4?=
 =?utf-8?B?R1pkWE5QZzN5elppVzViYzRMVVNSa3VQTnpYVnJOd1JVaXhPazJ1RnVkWTd2?=
 =?utf-8?B?SklyMkhDazB2RXJ1eWw4S3BBWnR4NW5JYWtWTlBERzhHUWNRdVYyMWQveXhl?=
 =?utf-8?B?Y2hJcDN3OXN6dVE0bFhZbW1ENlBCY2VISGxsMlpaNUhLQ1NUT3QvWlVGWUlX?=
 =?utf-8?B?WWdybWwzNTNFYXp0T05xVGhxVW9mcGlsYTEyWm0vZmZRYUZMVDhVUmZNWmNU?=
 =?utf-8?B?Z2FGTVFPMW15RHIzdGMxYmxNakowYmVmUndhaEpqT0JnamE2UzFmbXNrNVdy?=
 =?utf-8?B?emxBYkc0UkdhWWZrbEVMYVQxNTVQclU5R0lYNW9TejRRUUxMMDNOL3lkbEY1?=
 =?utf-8?B?U2JKaCtzSzFicHF5bms2R21EMlErU24rN0JZOUp1c3hodFlNK2dGTThZMjJk?=
 =?utf-8?B?dUxPZzlIbk1NNGpLTFZPWC9CbEhxUmkvbC9DclRDb0lSUHZ4ZmVzdTlqZzAz?=
 =?utf-8?B?NlVRNmk2N2VHUDZHQjFxRW94VWZ2Qm51bjBwN3ZBeGFUazNEWkJEaEpPeGhz?=
 =?utf-8?B?TW1SS0lBUUZsS09LNGQ1UjBLTUdad2JwOFJlV0hDL1h6cVVOdmlhVGY1RTVm?=
 =?utf-8?B?MWhnLyt4NVJ5VW82d2wxZzhuS1M0Zm9lc05LM20rcllnOE8vWVh5ajdsek4w?=
 =?utf-8?B?Rm00MkZlUkRUQVRHV2JQQ28xMkl6dWx4cGhjWlhZOUNKbmZsdzUzOHc2cU1O?=
 =?utf-8?B?aXlFK29xK1V6cG1TcHFocTdwOHE2SE1PTm1xV053MGcvVmoyN0F4bnBkeFNG?=
 =?utf-8?Q?KWqizVksl6aMcT6Q+9ZJaAZgB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7932c764-3395-4f4b-263d-08db82f31bf4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:14:46.2183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y96G5zEVtzyimtbfoL9UyUCUP2y1LbKv6dk9XaDJxaSDWQ2TaXaQsTdlXwzy0EQQv901WA001nTdIJfOnnI+Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5347
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/29/2023 12:46 AM, Srinivasan Shanmugam wrote:
> Fix the following warnings reported by checkpatch:
> 
> WARNING: Block comments use a trailing */ on a separate line
> WARNING: Prefer using '"%s...", __func__' to using 'execute_synaptics_rc_command', this function's name, in a string
> WARNING: Prefer using '"%s...", __func__' to using 'apply_synaptics_fifo_reset_wa', this function's name, in a string
> WARNING: braces {} are not necessary for single statement blocks
> 
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 29 +++++++++----------
>   1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index a6be04ad387f..66909bb5e5b0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -68,15 +68,13 @@ static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
>   	}
>   }
>   
> -/* dm_helpers_parse_edid_caps
> +/**
> + * dm_helpers_parse_edid_caps() - Parse edid caps
>    *
> - * Parse edid caps
> + * @edid_caps:	[in] pointer to edid caps
>    *
> - * @edid:	[in] pointer to edid
> - *  edid_caps:	[in] pointer to edid caps
> - * @return
> - *	void
> - * */
> + * Return: void
> + */
>   enum dc_edid_status dm_helpers_parse_edid_caps(
>   		struct dc_link *link,
>   		const struct dc_edid *edid,
> @@ -255,7 +253,8 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(
>   	/* Accessing the connector state is required for vcpi_slots allocation
>   	 * and directly relies on behaviour in commit check
>   	 * that blocks before commit guaranteeing that the state
> -	 * is not gonna be swapped while still in use in commit tail */
> +	 * is not gonna be swapped while still in use in commit tail
> +	 */
>   
>   	if (!aconnector || !aconnector->mst_root)
>   		return false;
> @@ -282,7 +281,8 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(
>   	/* mst_mgr->->payloads are VC payload notify MST branch using DPCD or
>   	 * AUX message. The sequence is slot 1-63 allocated sequence for each
>   	 * stream. AMD ASIC stream slot allocation should follow the same
> -	 * sequence. copy DRM MST allocation to dc */
> +	 * sequence. copy DRM MST allocation to dc
> +	 */
>   	fill_dc_mst_payload_table_from_drm(stream->link, enable, target_payload, proposed_table);
>   
>   	return true;
> @@ -633,7 +633,7 @@ static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
>   	ret = drm_dp_dpcd_write(aux, SYNAPTICS_RC_COMMAND, &rc_cmd, sizeof(rc_cmd));
>   
>   	if (ret < 0) {
> -		DRM_ERROR("	execute_synaptics_rc_command - write cmd ..., err = %d\n", ret);
> +		DRM_ERROR("%s: write cmd ..., err = %d\n",  __func__, ret);
>   		return false;
>   	}
>   
> @@ -655,7 +655,7 @@ static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
>   		drm_dp_dpcd_read(aux, SYNAPTICS_RC_DATA, data, length);
>   	}
>   
> -	DC_LOG_DC("	execute_synaptics_rc_command - success = %d\n", success);
> +	DC_LOG_DC("%s: success = %d\n", __func__, success);
>   
>   	return success;
>   }
> @@ -664,7 +664,7 @@ static void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
>   {
>   	unsigned char data[16] = {0};
>   
> -	DC_LOG_DC("Start apply_synaptics_fifo_reset_wa\n");
> +	DC_LOG_DC("Start %s\n", __func__);
>   
>   	// Step 2
>   	data[0] = 'P';
> @@ -722,7 +722,7 @@ static void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
>   	if (!execute_synaptics_rc_command(aux, true, 0x02, 0, 0, NULL))
>   		return;
>   
> -	DC_LOG_DC("Done apply_synaptics_fifo_reset_wa\n");
> +	DC_LOG_DC("Done %s\n", __func__);
>   }
>   
>   /* MST Dock */
> @@ -995,9 +995,8 @@ void dm_helpers_override_panel_settings(
>   	struct dc_panel_config *panel_config)
>   {
>   	// Feature DSC
> -	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC) {
> +	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC)
>   		panel_config->dsc.disable_dsc_edp = true;
> -	}
>   }
>   
>   void *dm_helpers_allocate_gpu_mem(

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
