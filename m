Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BF1C04AAC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 11:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B6F10E5DD;
	Thu, 21 Sep 2023 11:55:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4981F10E5DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 11:55:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMG1iq8lHv37jMmKnYU9pqRBd5Ubkg94w04YgP1WUOiY+64PVzKVdBQZpuy9TdohnXKeNQH/xYTjYv4Jz/YZe7AhAJiOTpxXkHuFXY6MJwUvPE5unZpu8FbamLqxafgXM7W4agiZr14r3eQW2vczA46kVwhLOKTQuuZZnViP4rRllrFH3b74HI5Rz5Tcn9XWotPEm3dRkg0nyIjMltNQbB2nYxolsUcvFm+NtJ5fmUxhvuprI1WHhc9AVo18ufqsQ2DdTa1kf70Byl1jotYQ2IzuyjzHfAcCH1Yi4ftc4hZpK7BxEwKuex9WB6iyUFhzwz+T8sFxi4YNufi8G4cmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txEwH1n0QsW6Vx1S1Klpo+Jy6of6Vt6fFnJ6bxv7p+E=;
 b=niZUVTmQrKnzIyaJmWBv4IrC9TMWMH/NnL6XStJmdC4FYm35zc/1xFNO3Cohtqx9zKuOYz9S808K8+yV2ELOgcDXGaE9YaElyB2AONDNSTNByhMIPLvLmWLWruSBsU/8aC77sJSFTo+AdAY3lrS5lezu19eNbZVNg7CD9jBbDpByj3g+nFJeJL1+EwNttfyKxtcw7yVJ/QGhP2/yP+EfYqWDTI0i4zLeNB6BApjLImhUaSeCyI3Ljy6HX64Be+wBx2MAJEu9FDHQmfH6+bv0LDxhkbUUmaerLM+hHI/jkU+uP7muzjhgqCLpMtB7hc6CZG2EJFlRSTTmXZCJ9ERg+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txEwH1n0QsW6Vx1S1Klpo+Jy6of6Vt6fFnJ6bxv7p+E=;
 b=BoVtNjeTgMr7moBQWnKO3KMcfFNhLCfaUI0P3GVYKOiYFUB5jNoN4dMInS7RcH6I4LUXPZNJARh9w1tWEwDw1cz11khWN0uu+zL9fncEy5oSNM9AVYEZw2C6Jwtq/1WwoRk6t/1CGwp6gUIDJtFlxgycHBFCcDUHYVAYeVkAS5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by SJ0PR12MB6808.namprd12.prod.outlook.com (2603:10b6:a03:47a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 11:55:06 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::d890:af2f:d92e:9d4b]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::d890:af2f:d92e:9d4b%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 11:55:06 +0000
Message-ID: <e53e3076-b73c-0aa0-d662-5ceb275b432f@amd.com>
Date: Thu, 21 Sep 2023 17:24:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: fix ip count query for xcp partitions
Content-Language: en-US
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230920200155.1728471-1-sathishkumar.sundararaju@amd.com>
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <20230920200155.1728471-1-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0197.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::6) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|SJ0PR12MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: e76e7510-08e4-435f-21c8-08dbba9998cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8X9X1d9omiK4DhhZMPmpBxeqkzJeE1O1JHpgnwQmRK6029DrmVDpyOOeDeKVdjiy2IsNosbJrnLA1oeJtzBi6pV2S5mGDisUatsUwdFWFoOfcvNhHz/9RjUuC15J7i4n2PWD4/C/gg+Lm26wR+OrMqGxPpEzNgF3PMSLy4Kcqljd4ZK7kEoaVV4S/LCDuGz3ZufMgfnXbC+rijqz2iq2aDidCMDgA3ZGPSG0PYJa4W1QEUJHv+bQf9S8hJhK1OZ77qQ81Yg2X5qkOzALU8sog6TUZZm9OjQYrackj4tn/i9DfrkNXJDDY1kbaS01dPfDG1C1XzeyaDu+wO+zDhSxKmZgojg5WMeNBZpROmDdmSpUpMRq/Efl8XElyLYzIQP9+DjsLu2xZYQuOtFGNiUQ0lma6wQMl8exwwVxCIZ729+MsunVA8RC72J5Iu3KbX5lQ3+zMkJPFNPinWveRzN0li6Zw70Hemg43EXew3q99QZGeoFIniSJP/peyI6ye6rVo0zZYc9eiRWKpYC+dUYSZ/TE9P3REAJunHC9poNRYHaR3FlxiJbBJC6msSqEUi5jJlMFrX/7a+1vsZTWhbzNrRbZOOHgLzCgSzraqxH6rv77m9pICKBQ0Msx5EKK8SzwJQOYxARV0G6xRtGxxpAIBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(186009)(451199024)(1800799009)(83380400001)(478600001)(6506007)(6486002)(6666004)(53546011)(6512007)(8936002)(2906002)(8676002)(26005)(2616005)(66946007)(66556008)(54906003)(66476007)(5660300002)(4326008)(316002)(41300700001)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkdrUWt1MXI1dUo1RHdIc3RJMGJocWtZcy9YSFFaL2MyVVpoa3RXUVhMOENp?=
 =?utf-8?B?UnJpYlpyWG1rSmVBT0VjUHUzOEFTL3VHaTNrNERpZGZlSTNjSFFIZFpaMThi?=
 =?utf-8?B?bEYvZmNJRCtuMjIyeExVYmQ2cWUzL3VkdmpKVzgwL2E2M2tXb0tZWkpBNm92?=
 =?utf-8?B?dmZKeHl0Q3IydEdGNWNTMVhaM1hOTUVIV1dNeTZKQU0xQjNHODQ2Vjdjd0lx?=
 =?utf-8?B?U2VBalhpV2V2NmVlU0ZYM0FKY1RjOXJ4SzRqMXh4ZVBJeC9ZdW96OHhYalB5?=
 =?utf-8?B?TUZOdWpFbzkvSUo2OERsT25UeTc2akRxcis5NEVncktXYytJRUgyY2lEeFNy?=
 =?utf-8?B?emw5eEZjMTJsSmFERnVHSlpYNWJaRUNGL2JaRGNrL253dm9CdVRBbGZSMmw3?=
 =?utf-8?B?Sk4vRVdHNFhpb0tPdXlUVis1TmQxNDUraE5SekpDRjJ3N21XekdzaFdGZ1cz?=
 =?utf-8?B?UlVyNy96b1lrUGovMFM4WDJuKzhhcmlSOGd3V056cklXL3lHS3BIWVUyTWh5?=
 =?utf-8?B?KzdIQzBJOGp5bk92M2FlQkMvY3hxMEtDWDhkNDNQU1BzTjBGL0ptQzFUM3lY?=
 =?utf-8?B?TjByMFpCSFpSNXU1dTFKYzN4TjNIcWdqcDA1TS9Sa05yNGJYUS90cnBkOTFC?=
 =?utf-8?B?WGJYQTJTV0tubFYrZnA0YU05SmgzSG1taC94alU5NkhjbHIxVCs0blhSRmFG?=
 =?utf-8?B?K25jQVRHeXQ1ZUxxTUE0YTJyY2FaY1FQQ3pFem0yRU9qRmNDRy9Scnlrd2wv?=
 =?utf-8?B?T0pyVkZMTThLdlg1ZDJCcmxjb1hqRkYycTQ3bGxtSGQ2WDV2YUkyNkdYS2Zi?=
 =?utf-8?B?WGFTdGx1c1BDdmQxekJyNWFFdXVobFY0RGJzOUtidzFWU0RKRXRNeXJBVHE5?=
 =?utf-8?B?Uzg5eU9wd0lDemErbmtzUXgwM09neSs0RlBSZVdUdVJQS3FRU2l5K0ZabXl3?=
 =?utf-8?B?MUMveEpSNmJPc0pUbHdJemdETDRZdE5qVE4vTDhOc21RWkcxVm1jU3h2VS8x?=
 =?utf-8?B?dCt4WVdaeWp3Tm5kejZmcnpkWDNVNUEyT0NIMlFuRnV6UlBkQnhQRzA1UmlO?=
 =?utf-8?B?ZzZpLy9KaTVNVlhvWnphNjJNVUxqeFh4WVAxWEF6djNnWDlEWENtckdic28w?=
 =?utf-8?B?R2NVc3YxR3lzVi9CVGJnU3lzM3B2b1NUaFFlajJtL3gwN0luRWR1UXlZOHR5?=
 =?utf-8?B?TS9iT1dpRFVJYVMvdzZ6QnVOaW5JaEo1QmxubWlTcXM4SUR0TkQvcERNRXUv?=
 =?utf-8?B?ZkFySkN2V0I2RElNNmZyQ2lXR3VJMjFHSzVlbmlHeDc3ZmRrQ3Z1UGpkaCtw?=
 =?utf-8?B?SkhHVC8zY3BNSExGWVFOVWF2RXVxMTg1Qm1pbEVSUURxc3hwMlBkMmUwOUJS?=
 =?utf-8?B?SUM5cDJWanpDTFRhanlkVGx5RkIra0h5UUNnM1l5TjRVRnJkL2I3U3FtVWQ2?=
 =?utf-8?B?eUJYZVVBejI5MEVlTGNZZFUzd3VKa09wNXlWSUVtOTR1S1FwM1JvKzdKWUps?=
 =?utf-8?B?Q0FIQlBmL2Fwc1BxVWJiOFN5bXFHR0kwbVI5N0ZDM2UrbDJtWEIyUWlmYmd0?=
 =?utf-8?B?Y3psR0NtT0xhV1paY2RJRzV1NE5VazFPdHZaMVpsY1VKSDZubk1WRW1lejdn?=
 =?utf-8?B?WFpYSGwvMTlLOUpDaGFHN0pvVU1XUWRsaFVPaUlidmtnZUZQWWVPZGdjdGZ4?=
 =?utf-8?B?czBmbG5qUk9nekxXZlMyb0haa0MvTlhpUEk4R1ljNm05TjlrTkp4WUREQTRz?=
 =?utf-8?B?dUlCVXdjYkcydXI3aG1ZUmJVMkRMYzFoVlZ2VkM4eVJqbk9oN1BFS29hSFRa?=
 =?utf-8?B?TVV2T1JIY1ROTEVoeWNTSkxMQzNaTnhDcHY0clh2WTNOejJWeW9lWVFYOTFn?=
 =?utf-8?B?dFBxS0E4WHpkdTFvM3dtSFFtSGRHZmxaS2M1aEdVR2dFSHVFSzNYa0hCbEYz?=
 =?utf-8?B?c1l2bnhFQ054dGdnV1Q3bXhLaUphOGpFUzdCRlNVM2JyZFl5YTNQclNDWUdl?=
 =?utf-8?B?T0xFZnhxUkJUdUlvWDFNV2ZvR2YxYi9Cdld3Zm4xRXdRVUkwT2h5MHhOSUNu?=
 =?utf-8?B?SWxuaTF5Q3BxOXVrMXNwVksrYkRjSFBCMjEwWkVHUW1tdHBkRXZsRXBVWVox?=
 =?utf-8?Q?rmRzjq5UMM9YGp978vhSf9gS9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76e7510-08e4-435f-21c8-08dbba9998cf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 11:55:06.3367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEzMv6S9AbP17b+vKW49hZmnFtpjymEnMhuf+92Dd0fgQh7XpxLERO80k1no6QcGXOupSiLH506rPk1b7+GudA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6808
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>,
 Koenig Christian <Christian.Koenig@amd.com>, Srinath Rao <Srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please ignore this patch, will send v2 with few corrections.

Regards,

Sathish

On 9/21/2023 1:31 AM, Sathishkumar S wrote:
> fix wrong ip count INFO on spatial partitions. update the query
> to return the instance count corresponding to the partition id.
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 32 +++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 081bd28e2443..42348f61a5c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -639,13 +639,45 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   	case AMDGPU_INFO_HW_IP_COUNT: {
>   		enum amd_ip_block_type type;
>   		struct amdgpu_ip_block *ip_block = NULL;
> +		struct amdgpu_xcp *xcp = NULL;
> +		struct amdgpu_fpriv *fpriv = (struct amdgpu_fpriv *) filp->driver_priv;
>   		uint32_t count = 0;
> +		uint32_t inst_mask = 0;
> +		int ret = -EINVAL;
>   
>   		type = amdgpu_ip_get_block_type(adev, info->query_hw_ip.type);
>   		ip_block = amdgpu_device_ip_get_ip_block(adev, type);
>   		if (!ip_block || !ip_block->status.valid)
>   			return -EINVAL;
>   
> +		if (adev->xcp_mgr && adev->xcp_mgr->num_xcps > 0 &&
> +			fpriv->xcp_id >= 0 && fpriv->xcp_id < adev->xcp_mgr->num_xcps) {
> +			xcp = &adev->xcp_mgr->xcp[fpriv->xcp_id];
> +			switch (type) {
> +			case AMD_IP_BLOCK_TYPE_GFX:
> +				ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
> +				count = hweight32(inst_mask);
> +				break;
> +			case AMD_IP_BLOCK_TYPE_SDMA:
> +				ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_SDMA, &inst_mask);
> +				count = hweight32(inst_mask);
> +				break;
> +			case AMD_IP_BLOCK_TYPE_JPEG:
> +				ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
> +				count = hweight32(inst_mask) * adev->jpeg.num_jpeg_rings;
> +				break;
> +			case AMD_IP_BLOCK_TYPE_VCN:
> +				ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
> +				count = hweight32(inst_mask);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +			if (ret)
> +				return ret;
> +			return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
> +		}
> +
>   		switch (type) {
>   		case AMD_IP_BLOCK_TYPE_GFX:
>   		case AMD_IP_BLOCK_TYPE_VCE:
