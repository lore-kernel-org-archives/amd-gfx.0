Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53784C77B75
	for <amd-gfx@archiver.kernel.org>; Sun,  7 May 2023 12:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6622210E0B4;
	Sun,  7 May 2023 12:55:18 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F75310E0B4
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 May 2023 12:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnw5BzX3jUeclJnTrYVybowYnFnL9XCnJdBn1Ri/OKBRNlMnFpSS4/ipk7c6IIPvq168GlqXx6mZ5tbndeLo50WfyJM+4wa1jHZhOhNjdXAWxAQdZ//hNwUyFiL+z710EmzAbL5zvjBRRaagUe19/bpAqtatZgV4oDxIDGjC6Kfmlz5vjlwVF9LrvTmgNjZKQaYPA+q0Zhg/2S15XzMdhhy8X9vS+zKDabdGkXWfmAhhISRhV6heQx/+GJebOXkd3RYcl7+mpyeXYaumzpE7MoBe4cAyPYb+pxYpDTpPfKFmAHY7+lWZkq4O2FKSso3UkgfLmTXbdD58evow1jVeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUjo8frI4DRDTbY8Ajr4Q9yqLuEU5pQG1oOGV5U+Rz8=;
 b=oD8fLwDWjU0h22O9hLnGNcN1D38z1ftwRyoa4ZEK+Sz9PAYgCOTbxVlZZRbQPfxsYMhp7ezQtb3jOadGJrS/aQKSVkNDJkPtZHDa8lxRC5NfLCMDHcx++ntGZTETggqq0Zu8U/2p2sghqDgZ686HBClWJdefdCCSZl46kHLbb5dzgnwrkuIFm8P7mYTdf8tgFf2ulGUP10+4zutH42dACw5iZCd23riTyUInycMTFbrXi+3Dzgz94NDrxvURq+97/UQLBQDSkN7lcBmP7Qlqtea+1l30HkesDUBUiIC77L/GUJaG/j9Z0264HAjIHGg6WCLp4SCKVHSrMdH5Luucug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUjo8frI4DRDTbY8Ajr4Q9yqLuEU5pQG1oOGV5U+Rz8=;
 b=Hadv/YG/rRWdtot5VTx4UDXpqThK0Dr/fRuFF+7u0TdsCf/rPbUSHeoOoOoaMJGel8TT9AGBS+3dbyft2TJokjer0hwqczdM2wFdcdLZbh35Kw/I++pV4pJjpPjqu8XdIi61FpBalvdJanBB156kgs9rTEx9HBQ7CmRnNCD4EgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.31; Sun, 7 May 2023 12:55:12 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::ea3d:ec42:656e:a248]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::ea3d:ec42:656e:a248%4]) with mapi id 15.20.6363.031; Sun, 7 May 2023
 12:55:12 +0000
Message-ID: <9f6e80f5-e0ad-0711-4ebe-e8445921ebd7@amd.com>
Date: Sun, 7 May 2023 07:55:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] drm/amd/pm: parse pp_handle under appropriate
 conditions
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, lijo.lazar@amd.com,
 evan.quan@amd.com
References: <20230506034819.1777919-1-guchun.chen@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230506034819.1777919-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::13) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cbc07b3-739e-4af2-088c-08db4efa4b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aICmTt7qqX7MLAcdlv30PZvHtsyEd/+KQh9elwlYHEj0A++IRQ3o2P1gG1vavSmCGmDCACH4b5FMdYMJz2hiQ3e7DpHwqnYxhYQ4hxAszp7i2XIWTAqak4OSfWcYQPQEoPEXYeO4sdGK1z6V0J78oI48kM/Y5vGz+ZyQInmkacLaZzpIQyWxJOpEvvz3uqzwlLEUcvaIB0fIQriMDF6O9CwKum+HDJeGlq2Cr5jhWkUdSTjxxVGSCJuaNQsHD2DOVeGG11k6Hb+Xhbb5WgGE6KUIZevhBdIoyi7IOeLYabtJTCOlklcOmcuM9wu073DV/+grIWKNtAJ+9mpMDppCLUH95MXsFOMoL8OEQKixLbeufHkj85j5+LcRipj/hg4lBcAQB0Ozh6h7F29p6K3EsWlEakMVMtYapqLJJhXAPzaa9Dqy4mmsBmfVmgA0UVi8vpnZdEi3msN/LsTafGFKOTBl7QuvnEQMk/mFCYvIKZhtF00SZMNIAIKjv4vLuquCsOcg82B5gVIirQEMjAV1Q9dJOqAknDn6GhiNyfwt8YIx9A1tJY1+OGE/XYPmOD2lw3bz6Q6Wp7268I2TFQawn/EYPXOX6Np62xXF74fIke8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6095.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(83380400001)(966005)(478600001)(6486002)(2616005)(6512007)(6506007)(53546011)(186003)(44832011)(2906002)(36756003)(38100700002)(66476007)(66556008)(66946007)(6636002)(41300700001)(5660300002)(8676002)(8936002)(31696002)(86362001)(316002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVpxYXJIcGVJYUZDb1g4ZHFlZGljWkxCUmp0d2dTSkYyeGgwZU9tUVBSUkho?=
 =?utf-8?B?dGtaZ043ZE01aXZuUUdSYzNKaHpQQmx2SGNRMUphbHlrbVY4ZC95NGVrYTd0?=
 =?utf-8?B?MERiKzJ2ZEQvWHk1SmMzOVdBOFQyb1pvNTYwamZ5VVdDakJmb2hjN3VPV2Nr?=
 =?utf-8?B?YW92am9FYlo4ZktUSHVtY0hJb25hZkMzeWZ1VDlrUWl6ZzhXNlZHTjZmN0li?=
 =?utf-8?B?NHV5a0h2V2d5Um52VlJSSlJmbXh0N3FSRmZsZHZWanBWL1ptemhWS29idExs?=
 =?utf-8?B?R3J0RUJQS3VTdzBORU1NNS93L2RHcFdkbUdzeVVGaXJpK3Z3R2xDL3N3eVN3?=
 =?utf-8?B?OHluRTBmUnB3SXFZaklUWHVBZXpNYzFGS1gzWlRXc2RNNkdyZW5yVGVZSmJH?=
 =?utf-8?B?M2lsb2c1eld1RkFrMVJublZMV3dFVlpmTjJPVDVjRXo1TnZUS0pqYk43WHU5?=
 =?utf-8?B?UlJEUmdoN2M5eklVZGhYSjUrOTJTM0pvcHM0OUFvOEVVWUVucHB4RHhBY2hR?=
 =?utf-8?B?ZHgrd0hMMHRzOXQxZU5pSVV4S2svUlJkdDJRY0tiQ2Q2UU43bC9pVFFvUmp3?=
 =?utf-8?B?Y0h2Wk11SkhESkZkTTJXSzUvbGY5U0dDbElucFlndWxpZjlBUGpnL2JqaU5C?=
 =?utf-8?B?QTlXQzVMZ2t0cWxiNEhQN2lIakx6WW10eW9rNndieFVqMjczNE0vY0pHMkEy?=
 =?utf-8?B?VStVbnZXa2RPL1hYbjl0TmdTY1dvVEg3cHQzbDBpdmtzUjFvVDNVTnVBQmlh?=
 =?utf-8?B?Y21adFd0MVdubGJwc29MWmhEMUw5NTM5V3cxaGZQMkNCRUJXdlB6Y0ZvVHpu?=
 =?utf-8?B?WEdKaWZiVStNWUdDck8vWW1IVDNBb09wNitPZTNUdlNpT2g5MlVOODZ4S05E?=
 =?utf-8?B?dERLRlBOenFjZUFkYlZqZDdoWHVsbkdERVB0TStUME5vZjZ5MEdha09JVFda?=
 =?utf-8?B?YVMyZjFiR3psL2tHK0hpMzBsYUw1VVBxYjd4ZnNibU1CNkNoVDlCcDUwRThw?=
 =?utf-8?B?cGhxRStDM0RNa2Uva3krOXN1VmIvZUgwM0gvRWdHZnRlaEdBek10YnVoWUww?=
 =?utf-8?B?cU9ESXpGbkhPNkJwMGtmS3RaWE1hNEpDeSs5THV0by8zNkFOMTlWSzBmdmFv?=
 =?utf-8?B?RjhsNUpYeVplcmgrN1dIaS9MY3BRMkZaY0tEcXZhRFFkSnhLWGUxTmpwMk9Z?=
 =?utf-8?B?VUVRdWdqWlFBQkNKY3d5MmZIaHl0b0J5bnllZ2wvNVFxZitIZkhwRlErUThZ?=
 =?utf-8?B?T2VHcDdhcUliUklKYnBjN1dHcnhUeVlTN2QwaFZMZ2pwZEcxQjFiQW5DNFpw?=
 =?utf-8?B?UnlDZG1WNHNmWjdSRXFla01iNkw5RjBVQnl1bjhveDVyZExmWHQvSDdiNHpH?=
 =?utf-8?B?NW1udndzcFdSQVdYV3dqazBIZldCQlRhWlEvZEd6cXp2SkJOWnBQd082OUtx?=
 =?utf-8?B?OHk0R1RVODlpWXJqQTdYSCsxM3VhZjBzUFhLQkhLRE5HT1RHNHI5c3IvV0wr?=
 =?utf-8?B?d2t2bm54K0NubzVUWldybWs1UTRpUkxkWHlpbTBPdUtoOVNyN0hacU9tQ0w3?=
 =?utf-8?B?QldXZThYNUpJY1RyZ05vMEViK3ZUMTViWWJWNjZaZDVlRG5GRTg2SUR0bHJT?=
 =?utf-8?B?c2VYUHVVeW9FcWFxc3cyNlo0Qm5TbzdZUC9jeWY3NjV0Y2pjUEZlajUxMzB5?=
 =?utf-8?B?ZXFoME9DN2tMb2tmbU9LVXV5cmR6bzAyak9rcEMxeWRGTUtKd0I0TWFSNUhm?=
 =?utf-8?B?SGdmYzJaQ1VPbTRWUHA2c1B2QVoxRWRJS3lhNjlkNEFMYXlGSFRwYThTdmdr?=
 =?utf-8?B?MTY4NDczY01BNkhCaXR3dVJyM2RvT25JKzFnanFoSHU1MHBwQ2piYU5TYk1W?=
 =?utf-8?B?czg1WExjdVk0SVRWMGFPRW1DOWprd2RVSlc0ZU9oZy9MazZWTG1yMWJ0SGE4?=
 =?utf-8?B?R25uWDc5MnUzWC8rcXZ5R08zaE9wWWNCMTV0MFJXSkhIQkhCUmxIbFc1TU1l?=
 =?utf-8?B?d3pVOVNMU0NqVFhTUzk1aDdsbXZIWW4vWFR1dThjV3VzeU5xUWlBN1N4bnN3?=
 =?utf-8?B?MUJVdCtnNWJuV0NmcDhqKy9GRHdoaXBPS1YxS1Vrc1dwMmttN3NRUzNlMi9o?=
 =?utf-8?B?K2JkUlduY2VXVGIyZ09KNWIvOFZtQkdkRGpyc01KQ2gxSXhpSmJhVURSRWxQ?=
 =?utf-8?Q?cbXIJCvHO0alkqp6j8VJnbMC0ugsLoBg40FQTdfsXF8L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbc07b3-739e-4af2-088c-08db4efa4b86
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2023 12:55:12.1104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWV6Po5heUPOFRNEaLOGffWF+OdcOikNqq4soDJvGgvIjL9o4vMAPT2AyYsBoaiSRm45BVb4KEf1p4IGylSRGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
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


On 5/5/23 22:48, Guchun Chen wrote:
> amdgpu_dpm_is_overdrive_supported is a common API across all
> asics, so we should cast pp_handle into correct structure
> under different power frameworks.
>
> v2: using return directly to simplify code
> v3: SI asic does not carry od_enabled member in pp_handle, and update Fixes tag
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2541
> Fixes: eb4900aa4c49("drm/amdgpu: Fix kernel NULL pointer dereference in dpm functions")
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 300e156b924f..86246f69dbe1 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1460,15 +1460,21 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
>   
>   int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
>   {
> -	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
> -	struct smu_context *smu = adev->powerplay.pp_handle;
> +	if (is_support_sw_smu(adev)) {
> +		struct smu_context *smu = adev->powerplay.pp_handle;
> +
> +		return (smu->od_enabled || smu->is_apu);
> +	} else {
> +		struct pp_hwmgr *hwmgr;
>   
> -	if ((is_support_sw_smu(adev) && smu->od_enabled) ||
> -	    (is_support_sw_smu(adev) && smu->is_apu) ||
> -		(!is_support_sw_smu(adev) && hwmgr->od_enabled))
> -		return true;
> +		/* SI asic does not carry od_enabled */
> +		if (adev->family == AMDGPU_FAMILY_SI)
> +			return false;
>   
> -	return false;
> +		hwmgr = (struct pp_hwmgr *)adev->powerplay.pp_handle;
> +
> +		return hwmgr->od_enabled;
> +	}
>   }
>   
>   int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
