Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E69C77B61
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 12:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6AA010ED37;
	Fri, 28 Apr 2023 12:44:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89A5310ED37
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 12:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdezbOIkeJkvrnvc/fqiPHCWJv4Bbqk2tA8H+uaRqCfclotOIBf4wKXC8d4Lmvqmg53f/VNQ/9sV8NAvGd7ctUqDOjHtydjBDbA/wV9uiPVpUtTpBVI0UO4AOG43fkU+KCPwvMtWzefKRDuXcqjpdDlzV1puFI+s461v3WDqb911lQTrpeIvFLGW2UWuX5VdQHdoJ+741cVC/JrCr6Hn+SSN54ktcuZ0xlz2Y/gba+AcldDsQ0QD7wNeGPgNOapt6lVZxvAOoNRdfI/jIkWHtNXZoHDkLRx/CHjWDAFzAw7C3/QCw6IhIMortX+VrD/Vzuj1jNXKqStUkboaLGixYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zA22/+jx7+0aJzInhq04cAjR7gKDii1Rp9FHs8sfMh8=;
 b=hd62AYe6IL8Tvnvt1ZtypXxBv7IJFLfwPmA8bauVZWEhPWJwCb3G/5WzJ4mUVDAyidhBsUydUqqQKTKN+qD3cmAR+t6lZygKGuS/m1d6lXyIetzCZCGdtYzm+o40CkBV0vxAgLV5wTvtaOVrgWO0orO6HsIcHmLFlHcYLEITeJlumFZa4S12BUmFUNKYOtrq3osNcRdpr8rpnrVBSXNKZ4T1WikAXhjeEwWWnWF1h7jnn4C7sihBs321Jco/yFQX3MVtNW71aOtFImd26ovUVWN/3ZhnRQqN4VjrhcYWBTiTg+kZaMZBs03L2h5ejyw/R9SjqzHhOcOVmGphsLNDjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zA22/+jx7+0aJzInhq04cAjR7gKDii1Rp9FHs8sfMh8=;
 b=K8jZ/+ofIAnbvOABaoe1JJ+SVGReLmWI0StFJSpwsSiu/Sm+pG4Symch6g9uEvGiElBLCM5oeunfjKJg4EvRTzILtH7iU4mAnUf83LlmxHqe/V+nUyhLVoftFJPXKAqzzuU4KHdzLxlWCmmoDl+704/35kMya7BHXxXmC5XKA/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Fri, 28 Apr
 2023 12:44:12 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 12:44:12 +0000
Message-ID: <2d217925-6e28-032c-1379-21b82866c755@amd.com>
Date: Fri, 28 Apr 2023 14:44:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] drm/amd/amdgpu: Fix style problems in amdgpu_psp.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230428124219.211145-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230428124219.211145-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW6PR12MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: b37b21cd-407e-43b3-3973-08db47e644c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2PyCuiw0twWZUtepwxKdKPgiis1yXa+3W0drksfaGYdZ/gZH9K0Ojx2XkMaKMkHfAfwuJe7twhyneEmpCKPCkiWBGCqrSYNO9y5YBIKfh8oeuDySVJ6PZp8vbkCbu+RdyELhgKGLVCDrXXJWucJsWZhl0MpxMT8YdXUYDnzRnVgWswhAngymZc8uaFLd+3UahNrSfat9Tqd38xqo9iH9yASDsO6m6D3pUJR4CItoTok2EBffgt0gh2T3IIuSqqmzSDVjC2BN9WGhGGa5pKrnkyuI5JOgOXxpZOJcIQWzpOcxeJ7Xm1POUMGr9lmHCn+8ogvJK7smZDjJjywyD07EqeQKWOrVQpTwRQMSpFdEEANmm8clDryhJFdvpaCNh3dGa7Am3AZ3OgTw8J34hz94qRbOdGN9SBvDIJyzmIn5RLZmyNo0ImFijjTxVlYSuTOFrRTgiK+Of1GBDsXeiaEsEouHCUQh6Y9asmmMSwpqzqoBFjuKd8vyL5m8Obu1YXKEN97WF4mwfCxQhTcnXecDZJbl3iIRyVRBdTovIa0q5gT93edZRMTrRVlXJ5NgfGZYeYR0Sdlkz9ko1lXGVnS66ROD+wCqydPDC7aIGz5KPIfWIEGFH7qxq2zmcOgkg2MtN18NW4QUJZH2ak4+43yVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(31686004)(66556008)(316002)(66476007)(66946007)(4326008)(6636002)(110136005)(6506007)(66574015)(6512007)(2616005)(38100700002)(186003)(83380400001)(478600001)(8676002)(86362001)(8936002)(6486002)(41300700001)(5660300002)(6666004)(31696002)(2906002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFBtZnJNMlh3MGdOZEsrM21pcko5UFRKR2lFQmRlbmY1dWllbVplc0NUQ2U1?=
 =?utf-8?B?cjFRSDJlSEpXSTN4dEZ0dmp6T2tsMzJjYXg5dEp1NStwNnZieG9lajFrWFUw?=
 =?utf-8?B?THdqMUlGam5DTHBtTElJZVVyOEN4YllqRDUxUXBxSm1YamM4VXFyT0lXb1ls?=
 =?utf-8?B?T01PNkovcWtTeEVnazQ5OTR1VVY1cnhmMEc3cHpRQWZCQUxkcm4rZFNldGVw?=
 =?utf-8?B?NERlazRFdlFVK21DekNwbWdLNUFGWUI1UFRmUGUvY0pYbkZuelJoMlY5eTc5?=
 =?utf-8?B?OHB6QVNjTzVuQkdmeUpwZjc4OHVqNlcxVEtGN1oyQk4yUExIcDE4V284dVpm?=
 =?utf-8?B?NGFmUWs2Y0tkVnc5Q2UyNTJ5ekhmRjBET0IraVVueXRXbzBZTWlSbHlINytr?=
 =?utf-8?B?ZWxWZkVQODN6SVljdU9OanFscVh3SnIxWDBUN0hKNE5VOGF3bkZvN1ZJeDM1?=
 =?utf-8?B?MVc2bUZMYnBJM0d4YW1zaXk1MDdHendGMGxXYUNEQWdCdWtmZGNoTG5GY2o1?=
 =?utf-8?B?bkVkd0Vwa2J4S2RWTWliNHo3NnJTbFFqMG5QSFBtTGlGdlpoNEYzeSt4V2RJ?=
 =?utf-8?B?OGN1TWdsN1JIR09ZVWYxaGM3VnZxSTlTb1d0ZkRqNUVuQVNCWUV5M0tYUUk4?=
 =?utf-8?B?bW5Tek5OUkltWW5QYVlmL0VLTzVqWStrbjJRczhETjJHUmJkTmpodkZrSnBG?=
 =?utf-8?B?WHJSR0x0WXNOSUp2ZzRIRlVBb3A0RjNhK2tqbTB2MG4vYkRjYkV0Y2l2ZVUz?=
 =?utf-8?B?UFlWUUo4dHBuVCtTUWJ5ZmN6Q0xZNm1vRm5pblMzaWE2U1d4UHlrZ3FoV0p3?=
 =?utf-8?B?VGlab0dKNjVId3NvenFtUFE2dHQyRjJpRnFVNUNxTDdUOWZ3WVRKOHVnSVM3?=
 =?utf-8?B?bTc1NXVjUEsvK3ArMEUvK0ppeUpZeXVTZ3JwWVdYM0ZHeDcza0hmKzdXK29x?=
 =?utf-8?B?Y3pLMTZSekF4K1o1NzRWbTJQR3JXMTVlRGFha1ZRTExVVTZzQUhpdEdGcE0w?=
 =?utf-8?B?YUQ3V3pRdU55MDdmVmxsY3R0UkFxbng4MStIU1pkWU5helhUTlYrcXNPc21Q?=
 =?utf-8?B?TXVCSUUzRHZLand3VGp5UDNwRDRpMmJGd1FaamxzTkdaaENjQU9yK012Q0RQ?=
 =?utf-8?B?S20zQUJjOVBQUFJOMzFKYWg0TEMwYWRWVzlLbzJuMGpBbFNjNHAxMGE0eDdl?=
 =?utf-8?B?SlVNa3gxaVZsQ3VSM0JKV3BBM1dNK2ticmRyMW5CMnJUMG5UWEorV3o3R0Ir?=
 =?utf-8?B?cThjRTBvZi9MUjFZaTZZdjFRZjNCZjJ6MStlUGk2OXlsTGQxOUFBRFk2aURt?=
 =?utf-8?B?UGIzNFJRWTk1VlpMNm5ocGdFYjdOSlNpOE1Da1k5dEpjYVdpK1ZlWWowNlRF?=
 =?utf-8?B?VnpNOHNhVzhhbytzckhNNXIvaFFLL3FaOThSc2hrVVQ3Z0cxMi9hNmwrRjdZ?=
 =?utf-8?B?YnU1UDJ3Y1cvQUlLVW8rTXM3UmpXUkVBc0JBZVFVZ3VTRXgwMjZ4ejBtZWRh?=
 =?utf-8?B?dXRINkU4Q1dVc3NiKytHM2hTc24yWU92L2J3SVNkWUxCYjBaa3FEaFRzYURj?=
 =?utf-8?B?bEdJZDZBbEVMNVZoSGNXRCtURW1ER2pKeDNRZGJhWFU1eDdGZ2F3MU9QSGZX?=
 =?utf-8?B?VENiTGFHTjQ4aWhZQjBoQ3JMOW5YYkROVzdsRERjSUZBdHhuZUd6dWd4ZGFH?=
 =?utf-8?B?aWR4Ym1DY0wxeHkxZ2JPeisvSDczeWpkNWlIRVBUenFCOVljZnR2WDRLOTV2?=
 =?utf-8?B?a0xNN2lpenpOa29MalhVS3c3NVZOV2xucmx2OTZBMHU2UmJuL2hCbkl0TnU4?=
 =?utf-8?B?UUxGc3JDVE5CelVxSk8wSEhmT0pQUkRXRGxKamtxYUNybXdEa05DM0g5ZUli?=
 =?utf-8?B?WWlSb3VWd1F2Q2dGZFRrWGkyQkUrREd5VmpLazJnSTRUL0hsOTJBS2J0YTlj?=
 =?utf-8?B?Zm1uSGluRzNCeXFGTTdMMVcxcDduRjR4RWRMeTdqaEtBTm1tWUJKaVJ1ejdK?=
 =?utf-8?B?UHdTdTNHQ2Y0c2V3bDRmSTRRR3lzTERoNHZVSlNVakdhK1NqcDFlWUtZSTd0?=
 =?utf-8?B?ZWI5ZitPZkJwYWhVT2pSN1d4cDdSNjNqWWlXclhZbW1aLzV6Z1plMk5sRzVp?=
 =?utf-8?B?aFV3QmxKVkM5TGhNM1Fad3dwR0FHbExYaEVSYk1kZ2RDVFRYdVpzVjNtaVlo?=
 =?utf-8?Q?nKZNrlbynDxMPId1neIt7KaVrjUMcRO9a5R9fDWE1dQe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37b21cd-407e-43b3-3973-08db47e644c8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 12:44:12.6770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQJqBH2tJR34doHhq9dKAPaXz49Zp17CKGvSOHxqVCnKrVRN9ZBXzIPNIh4T487H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7087
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

Am 28.04.23 um 14:42 schrieb Srinivasan Shanmugam:
> Fix the following checkpatch warnings & error in amdgpu_psp.c
>
> WARNING: Comparisons should place the constant on the right side of the test
> WARNING: braces {} are not necessary for single statement blocks
> WARNING: please, no space before tabs
> WARNING: braces {} are not necessary for single statement blocks
> ERROR: that open brace { should be on the previous line
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>
> v2: (Christian)
>   - The casts to "void *" are completely superfluous in the first place.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 51 ++++++++++---------------
>   1 file changed, 20 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index c58654a8b6c5..aa37b703c718 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -411,7 +411,7 @@ static int psp_sw_init(void *handle)
>   	if ((psp_get_runtime_db_entry(adev,
>   				PSP_RUNTIME_ENTRY_TYPE_PPTABLE_ERR_STATUS,
>   				&scpm_entry)) &&
> -	    (SCPM_DISABLE != scpm_entry.scpm_status)) {
> +	    (scpm_entry.scpm_status != SCPM_DISABLE)) {
>   		adev->scpm_enabled = true;
>   		adev->scpm_status = scpm_entry.scpm_status;
>   	} else {
> @@ -458,10 +458,9 @@ static int psp_sw_init(void *handle)
>   
>   	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 0) ||
>   	    adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 7)) {
> -		ret= psp_sysfs_init(adev);
> -		if (ret) {
> +		ret = psp_sysfs_init(adev);
> +		if (ret)
>   			return ret;
> -		}
>   	}
>   
>   	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
> @@ -645,7 +644,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
>   	skip_unsupport = (psp->cmd_buf_mem->resp.status == TEE_ERROR_NOT_SUPPORTED ||
>   		psp->cmd_buf_mem->resp.status == PSP_ERR_UNKNOWN_COMMAND) && amdgpu_sriov_vf(psp->adev);
>   
> -	memcpy((void*)&cmd->resp, (void*)&psp->cmd_buf_mem->resp, sizeof(struct psp_gfx_resp));
> +	memcpy(&cmd->resp, &psp->cmd_buf_mem->resp, sizeof(struct psp_gfx_resp));
>   
>   	/* In some cases, psp response status is not 0 even there is no
>   	 * problem while the command is submitted. Some version of PSP FW
> @@ -830,7 +829,7 @@ static int psp_tmr_load(struct psp_context *psp)
>   }
>   
>   static void psp_prep_tmr_unload_cmd_buf(struct psp_context *psp,
> -				        struct psp_gfx_cmd_resp *cmd)
> +					struct psp_gfx_cmd_resp *cmd)
>   {
>   	if (amdgpu_sriov_vf(psp->adev))
>   		cmd->cmd_id = GFX_CMD_ID_DESTROY_VMR;
> @@ -1067,7 +1066,7 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>   				     struct ta_context *context)
>   {
>   	cmd->cmd_id				= context->ta_load_type;
> -	cmd->cmd.cmd_load_ta.app_phy_addr_lo 	= lower_32_bits(ta_bin_mc);
> +	cmd->cmd.cmd_load_ta.app_phy_addr_lo	= lower_32_bits(ta_bin_mc);
>   	cmd->cmd.cmd_load_ta.app_phy_addr_hi	= upper_32_bits(ta_bin_mc);
>   	cmd->cmd.cmd_load_ta.app_len		= context->bin_desc.size_bytes;
>   
> @@ -1138,9 +1137,8 @@ int psp_ta_load(struct psp_context *psp, struct ta_context *context)
>   
>   	context->resp_status = cmd->resp.status;
>   
> -	if (!ret) {
> +	if (!ret)
>   		context->session_id = cmd->resp.session_id;
> -	}
>   
>   	release_psp_cmd_buf(psp);
>   
> @@ -1467,8 +1465,7 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
>   	if (amdgpu_ras_intr_triggered())
>   		return ret;
>   
> -	if (ras_cmd->if_version > RAS_TA_HOST_IF_VER)
> -	{
> +	if (ras_cmd->if_version > RAS_TA_HOST_IF_VER) {
>   		DRM_WARN("RAS: Unsupported Interface");
>   		return -EINVAL;
>   	}
> @@ -1478,8 +1475,7 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
>   			dev_warn(psp->adev->dev, "ECC switch disabled\n");
>   
>   			ras_cmd->ras_status = TA_RAS_STATUS__ERROR_RAS_NOT_AVAILABLE;
> -		}
> -		else if (ras_cmd->ras_out_message.flags.reg_access_failure_flag)
> +		} else if (ras_cmd->ras_out_message.flags.reg_access_failure_flag)
>   			dev_warn(psp->adev->dev,
>   				 "RAS internal register access blocked\n");
>   
> @@ -1575,11 +1571,10 @@ int psp_ras_initialize(struct psp_context *psp)
>   				if (ret)
>   					dev_warn(adev->dev, "PSP set boot config failed\n");
>   				else
> -					dev_warn(adev->dev, "GECC will be disabled in next boot cycle "
> -						 "if set amdgpu_ras_enable and/or amdgpu_ras_mask to 0x0\n");
> +					dev_warn(adev->dev, "GECC will be disabled in next boot cycle if set amdgpu_ras_enable and/or amdgpu_ras_mask to 0x0\n");
>   			}
>   		} else {
> -			if (1 == boot_cfg) {
> +			if (boot_cfg == 1) {
>   				dev_info(adev->dev, "GECC is enabled\n");
>   			} else {
>   				/* enable GECC in next boot cycle if it is disabled
> @@ -2365,7 +2360,7 @@ static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucode,
>   }
>   
>   static int psp_execute_non_psp_fw_load(struct psp_context *psp,
> -			          struct amdgpu_firmware_info *ucode)
> +				  struct amdgpu_firmware_info *ucode)
>   {
>   	int ret = 0;
>   	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
> @@ -2404,9 +2399,8 @@ static int psp_load_smu_fw(struct psp_context *psp)
>   	     (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 4) ||
>   	      adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 2)))) {
>   		ret = amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD);
> -		if (ret) {
> +		if (ret)
>   			DRM_WARN("Failed to set MP1 state prepare for reload\n");
> -		}
>   	}
>   
>   	ret = psp_execute_non_psp_fw_load(psp, ucode);
> @@ -2716,9 +2710,8 @@ static int psp_suspend(void *handle)
>   	}
>   
>   	ret = psp_ring_stop(psp, PSP_RING_TYPE__KM);
> -	if (ret) {
> +	if (ret)
>   		DRM_ERROR("PSP ring stop failed\n");
> -	}
>   
>   out:
>   	return ret;
> @@ -2967,7 +2960,7 @@ static int parse_sos_bin_descriptor(struct psp_context *psp,
>   		psp->sos.fw_version        = le32_to_cpu(desc->fw_version);
>   		psp->sos.feature_version   = le32_to_cpu(desc->fw_version);
>   		psp->sos.size_bytes        = le32_to_cpu(desc->size_bytes);
> -		psp->sos.start_addr 	   = ucode_start_addr;
> +		psp->sos.start_addr	   = ucode_start_addr;
>   		break;
>   	case PSP_FW_TYPE_PSP_SYS_DRV:
>   		psp->sys.fw_version        = le32_to_cpu(desc->fw_version);
> @@ -3491,7 +3484,7 @@ void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size
>   	drm_dev_exit(idx);
>   }
>   
> -static DEVICE_ATTR(usbc_pd_fw, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(usbc_pd_fw, 0644,
>   		   psp_usbc_pd_fw_sysfs_read,
>   		   psp_usbc_pd_fw_sysfs_write);
>   
> @@ -3674,8 +3667,7 @@ static void psp_sysfs_fini(struct amdgpu_device *adev)
>   	device_remove_file(adev->dev, &dev_attr_usbc_pd_fw);
>   }
>   
> -const struct amdgpu_ip_block_version psp_v3_1_ip_block =
> -{
> +const struct amdgpu_ip_block_version psp_v3_1_ip_block = {
>   	.type = AMD_IP_BLOCK_TYPE_PSP,
>   	.major = 3,
>   	.minor = 1,
> @@ -3683,8 +3675,7 @@ const struct amdgpu_ip_block_version psp_v3_1_ip_block =
>   	.funcs = &psp_ip_funcs,
>   };
>   
> -const struct amdgpu_ip_block_version psp_v10_0_ip_block =
> -{
> +const struct amdgpu_ip_block_version psp_v10_0_ip_block = {
>   	.type = AMD_IP_BLOCK_TYPE_PSP,
>   	.major = 10,
>   	.minor = 0,
> @@ -3692,8 +3683,7 @@ const struct amdgpu_ip_block_version psp_v10_0_ip_block =
>   	.funcs = &psp_ip_funcs,
>   };
>   
> -const struct amdgpu_ip_block_version psp_v11_0_ip_block =
> -{
> +const struct amdgpu_ip_block_version psp_v11_0_ip_block = {
>   	.type = AMD_IP_BLOCK_TYPE_PSP,
>   	.major = 11,
>   	.minor = 0,
> @@ -3709,8 +3699,7 @@ const struct amdgpu_ip_block_version psp_v11_0_8_ip_block = {
>   	.funcs = &psp_ip_funcs,
>   };
>   
> -const struct amdgpu_ip_block_version psp_v12_0_ip_block =
> -{
> +const struct amdgpu_ip_block_version psp_v12_0_ip_block = {
>   	.type = AMD_IP_BLOCK_TYPE_PSP,
>   	.major = 12,
>   	.minor = 0,

