Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A54F1073CBA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 13:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1856810E646;
	Wed,  8 Apr 2026 13:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uig3RWKy";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DAEC10E646
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 13:21:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEYTpTCJQ85aC3VW7AhJw+fzkpBv9G59z0TMCp0ImQRccZ8DAtFYyHoOajK/RyoIenu+UrJDtkBgIbpy9uxQWV+A1yxmBBYy0qoWmDn0XIhAXZjgEK9Mab8W3PA74mOYoWJUY6CFLI2X8stb4W4iuYFR/8V8cusoFxDaAoEWU1z+2Z/QGdnqHN8HADHnlsLTHl5jrFyrZ02ROgU2kt9S7VZOOLbgPxaaMuaWDt8sHJBzoG7hwktXN7o2Q6gQBdL03BaF3d5nmRZr1Vn3xJyPdPfV3cACZI6hsWKX5nJ/kinNebokNvBzbC21Rrjad48KrXGQ+moTwsEXXxCjaW9iyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Kq9iu4ITfJKcrokcUJNGqhc/TALkZpvZXVLnxAh9Kw=;
 b=oOoE8lxUdfkZ2g7xvzEgfSVakQVEQzbAIyAUJ4hpVc6dk6JAqoSW3mQn6zrpQrHPdmTmbc2aXJTWvqGpymwogLitM1d4x7MW6Kfg+CjrjbYGI/9Orw9Ado1zHEDm490heMgDqzOTsP5O9pMXcwZ//W/T7lekr/fZbr8lY0pRw00UG9Clu5/0edRqgvmCUZEZUJgNSzOhkbZ7m+KyLMvnNUy7OBD6BgOAyRsANyTNqBwUIULqMT4AfrR390ait7R1rL10fWiXlg2GwwdyTMDdDzu4EZIAF9CEsntokImHTRQ1KJIgfna7M3SUBt6PKScQluNRuYXtHV/di8Y2bpos8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Kq9iu4ITfJKcrokcUJNGqhc/TALkZpvZXVLnxAh9Kw=;
 b=Uig3RWKyPFcruR6X3aVtvI+yr+hQt6HL7zYm9YFXDb4KewNaTZugNmTPROMuIofuCD+TzC5QabaQHnffSYHH7GMQ+Qw0s+o0FojJ6CTri7MZiy98uCvDFV2rXEE/5iD+XfVyKuvZChmZ5Mtu7byVCjB2J5FzQQDOOVuOhkjcHP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 13:20:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 13:20:57 +0000
Message-ID: <99c96b56-2082-41a0-bfda-4a5c409830c9@amd.com>
Date: Wed, 8 Apr 2026 15:20:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amdgpu/vcn: Factor out vcn_v{3,4}_0_dec_msg
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 Ruijing Dong <ruijing.dong@amd.com>
References: <20260408125426.2118644-1-benjamin.cheng@amd.com>
 <20260408125426.2118644-3-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408125426.2118644-3-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:207:17::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c2341a-84ba-4f7c-66e2-08de9571abb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: VVGNdMHBpdjbJfDOHit96tuLNR5WYaCWIg9oCzyhkoshvfXKVjx6C9+dzfsP9RrYI+dvDum80KSZjCGUUPyyJaJptUTNrRqIzpGkKr1+WcpHSd4CW9wqxCPq6aV1S9voeLtryZh4tEigDoRdacdzp6y432tqvh9sRIRC7/hY+zOdDXrAAQS81Mrm38UqGz0sIdR+IIjjI5sTsK/vt08wwrobVJ+6wSrZAHb9Jt04yWk5oMKgDK9+TQaQrAdZpx9kjjPsqju2T4kdU7YIBNleyIAIMjc9YuKlwQPLnss385RB3AdfnkETaQjX+iE0QDnRfmedLmXTNcReXMUy7EpH9O6wzT4EHln/qmKXY3Gn9wvZy3+WReE7vYlRL4gxMt+qLnh9PRudYZpPYm6aILrS2ONbxQqlg1E+PP4DCsAwsZwuFD2gK7Xunr9ZqlGl0LQYyxyjTmJXja8/vJVLKHSo2Qavp+AZQXqHxxRDgKON3C9dV9ZT8T10+4jxWZc81WWyayTt/pxnSC8PcODHQI62+LuE1rJSmORkln8QQgoJcpVOQm2+Wnl8Pavkgk2YzWaYOIE608dPCgcFjKSMWl98uqE+ABCDHFyThOy+pP19r76uIRozeQOpEi5CKrFOMYjrfBbyxIk66Wpx4UF7tWeSTQI8lehdTMWQJId8tmfnSLirxVFDJaotWOcq0yEoY2N6ELAtuMW7Drk+T6pWWylmTpvGszS4eYtFwaGOWFjWfYY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW1TUVkvSWgrQzY1ckRXWENUMUZYMXdrSy9hbzJBUCtPVnovRTBIcE5hWUkw?=
 =?utf-8?B?eGQxTkRJREp4OWdOMUlaeUwraFJMTFBZTTJYMG00ZXBRUnhXUVJTWkFKbFdn?=
 =?utf-8?B?ZVYzdUc4NUx2RFVjaXZUWmJVRDlPOEVqKzJRbk9vcnFDQ2w1ZmVlZjQ1WnpC?=
 =?utf-8?B?QmxjU1UxRUtaZy85aW9HM0NmSFVnZEQwc0liT1dBWmpkaUNYTTRyUmZnVzc4?=
 =?utf-8?B?cVRTdHJLdm1SYTFoVkxxKzA3bDc2MzhVZmNRSm8vUDZCdE14Sk8zSFNtZ1lL?=
 =?utf-8?B?eEZwaWFqKzJzUU1GS2p0ZWppV0NqVkhqYVh4KzV0M1dUd1p1WXgrQnl3M2cr?=
 =?utf-8?B?dm5wamFtajd5MDN4OGN2RDA4UGVTVXc5anpLaXhuMDdGc2FpUjUwNjU5c2xt?=
 =?utf-8?B?Wit1SVJZTlpLSUkxVGNzbWY3V0tHSGE0VjJZekFVSjg1dkFlU2w4clVNUUd4?=
 =?utf-8?B?UXdYK0t5YlRJSERZbkZGVXVWaVJXSHBVWVZ2WWo5UjR5NXpMNmYvZDE4RFV1?=
 =?utf-8?B?dWNrWUc3UjRlVFoxS2QyUjNXVTNkR3c5cFN2TG9KRElsM29vRzlZWjl1T3Mv?=
 =?utf-8?B?NnVMZmlRbklzOFZpUldrT3VDK0UzN0FGYzVGdmFrbEV1UDVSdFI5Nk5mSUhx?=
 =?utf-8?B?ckZNUitRTGttSmgvenUxUzNnMFhZbGNnbzludzJuVCtyWVJFcWlYMzNtTERX?=
 =?utf-8?B?bDhpTUo4WHFyaERaaHp2ZjMyZzFpRzQ1d096eEZkcjJ5QSs5NVVzbkRsTFl0?=
 =?utf-8?B?c3BkVjduc09iWEd2VTVta1JFdGtrL29QUko4cVFsYVFnbHBCa3ZWbzJWaG4y?=
 =?utf-8?B?Y0dzenJybURJZ2hDSjN2T3BaaXc0M0VQZ1pYRkJwTCtnTiswWXJaWFkxSVlx?=
 =?utf-8?B?L1Jwd1BMczJobmxmckRqQUdQYnZlUU1TV1VuYXZjWUNLTFJmNkJaS2o4ZmIw?=
 =?utf-8?B?c2VqMlpycVR6RFFxWk1zWDBVcTE1eTVaaVFacUdsSDROaW5UcWhBdnpEd29z?=
 =?utf-8?B?MnUvRE83OTBBRzVVd213VEdhb0dEbTJjbnZYTDhCNm9ScGtsMEJtcmdaMW1B?=
 =?utf-8?B?RWJnOXVqQ2ZoTmpzcGt4S2VJclZTeW5rVmJ6TkI2blMySmpWQkhGUnlYL1RH?=
 =?utf-8?B?Rno3cUlTV1NlM3E1VXI1TlgvUGhsRnQ5TEN2NE16Q3puOFY0TlhiTGp4U1dM?=
 =?utf-8?B?dTNhSHBnQkM5SmNXMmJiM1dDVGRDTnBJbEgwZWFpaTlKQlQwTkdUVWorYWox?=
 =?utf-8?B?R3dmU1N2ZTJUMFRKUEVnOEoyaDNFNlhRWi9ZK0h2QnpGbUdocEU2aXRPZGxN?=
 =?utf-8?B?VThXbENLUW5CTnAvM3B1RFFIdjdVS0cvb3ZFOHI2dkVjVXE4SVBTTHlGelM4?=
 =?utf-8?B?UVArRko5TXlnSnNhKzBvV0xPK1o4MkFFL0tLRXJVU0x4Y1JQb1U2U0d6WXJx?=
 =?utf-8?B?YnordVVuN0JjL1VOSzRSSFpyWDRpc091YTQvV2IvUmJqRUVMRXVvUmljNXhn?=
 =?utf-8?B?Q3lkbzhsOGtSSzFKSSsyc2hrQTJaN002ZzBpRU5iYjNFUnY4dDdkQ1NGaTNB?=
 =?utf-8?B?b1h0Z3pyRzZoNzJFVlFMa1VPdVpQd2tQRGFkL3N3VExueDQxVnFPKy8wZytj?=
 =?utf-8?B?MEg1MUMrK1FKWDhoTS9qUi92TkpZQS82RTJ2L1VoSTVxc1dxNmxLc0FCTjIz?=
 =?utf-8?B?L2RqY3R2UEZ4Tkg0MnRvNWVXV0pwcUJ6a1hFS0xkKzJTOFN4cHVMSlE0K1ZW?=
 =?utf-8?B?UmlCVC9kcUZ0S0NFS1NmeGI3M2NJN05KM0ozUzNVSGh6TnpOc3lFcnlMdGZo?=
 =?utf-8?B?ZlBBOVoySzROY3BKUEJLNTRRbStJcTk4YkEybjc5QUFzekRqMjFUUno3Uklx?=
 =?utf-8?B?NG1FNW5VM285SmFxaStLZlJGbUppMWxwU0l1Znlna0tONGFuVnczK0wvY2NB?=
 =?utf-8?B?ZnV4WmlRLzgraEhTcWJocEVaZU1RaFdyUjFyeno3K2NtYnd2cE04b3VCK2JW?=
 =?utf-8?B?bGxWdjNtWFErRjVsaWxSa2tDMFVaaUYrZ3d2NFRKQVhLRU52Nis1VjhiUmh3?=
 =?utf-8?B?YUYwdEs0ZWF4L1F6SVhhUENZSlNRN2ZBOEMxY0lhTXJJS2s2cC9oY3hKeWZ1?=
 =?utf-8?B?cXhEdmc2cWR0N0NRUStNeWR2YldUblp5WUNvc05rWDZXaHpOaTRuRndtL3pu?=
 =?utf-8?B?VWsxalRKUmNsdHpzZWlObVpRZzRmdWNuMTA3eEM2TnM1bGdmVGxTSUJCNExn?=
 =?utf-8?B?K256U3A1eVNMY29tMkRiNDFkTVNKUG1YQmxzald1WC9MbVptMGZJZGxDYy9H?=
 =?utf-8?Q?b6GATJoNrOfvnJpAAZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c2341a-84ba-4f7c-66e2-08de9571abb1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 13:20:57.9090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFpFsa5/W8E5gk6EJ6aST1H6X543na34LDhw825vP6AtFwDrDwHUMcxix+WdGENt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
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

On 4/8/26 14:54, Benjamin Cheng wrote:
> Both vcn_v3_0 and vcn_v4_0 use the same interface, so unify the code.
> 
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>

Looks good of hand, but somebody from Leo's team should take a closer look.

Acked-by: Christian König <christian.koenig@amd.com>

> ---
> v2: Moved RDECODE_* defines to header in patch #1.
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 100 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |   5 ++
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 102 +-----------------------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 101 +----------------------
>  4 files changed, 109 insertions(+), 199 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 03d95dca93d7..10aff7da52b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1641,3 +1641,103 @@ void amdgpu_vcn_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_prin
>  		}
>  	}
>  }
> +
> +int amdgpu_vcn_dec_msg_limit_sched(struct amdgpu_cs_parser *p,
> +				   struct amdgpu_job *job, uint64_t addr,
> +				   int (*limit_sched)(struct amdgpu_cs_parser *,
> +						      struct amdgpu_job *))
> +{
> +	struct ttm_operation_ctx ctx = { false, false };
> +	struct amdgpu_device *adev = p->adev;
> +	struct amdgpu_bo_va_mapping *map;
> +	uint32_t *msg, num_buffers, len_dw;
> +	struct amdgpu_bo *bo;
> +	uint64_t start, end;
> +	unsigned int i;
> +	void *ptr;
> +	int r;
> +
> +	addr &= AMDGPU_GMC_HOLE_MASK;
> +	r = amdgpu_cs_find_mapping(p, addr, &bo, &map);
> +	if (r) {
> +		DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
> +		return r;
> +	}
> +
> +	start = map->start * AMDGPU_GPU_PAGE_SIZE;
> +	end = (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
> +	if (addr & 0x7) {
> +		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
> +		return -EINVAL;
> +	}
> +
> +	if (end - addr < 16) {
> +		DRM_ERROR("VCN messages must be at least 4 DWORDs!\n");
> +		return -EINVAL;
> +	}
> +
> +	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> +	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +	if (r) {
> +		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
> +		return r;
> +	}
> +
> +	r = amdgpu_bo_kmap(bo, &ptr);
> +	if (r) {
> +		DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
> +		return r;
> +	}
> +
> +	msg = ptr + addr - start;
> +
> +	if (msg[1] > end - addr) {
> +		DRM_ERROR("VCN message header does not fit in BO!\n");
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (msg[3] != VCN_DEC_MSG_CREATE)
> +		goto out;
> +
> +	len_dw = msg[1] / 4;
> +	num_buffers = msg[2];
> +
> +	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
> +	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
> +		DRM_ERROR("VCN message has too many buffers!\n");
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
> +	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
> +		uint32_t offset, size, *create;
> +
> +		if (msg[0] != VCN_DEC_MESSAGE_CREATE)
> +			continue;
> +
> +		offset = msg[1];
> +		size = msg[2];
> +
> +		if (size < 4 || offset + size > end - addr) {
> +			DRM_ERROR("VCN message buffer exceeds BO bounds!\n");
> +			r = -EINVAL;
> +			goto out;
> +		}
> +
> +		create = ptr + addr + offset - start;
> +
> +		/* H264, HEVC and VP9 can run on any instance */
> +		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
> +			continue;
> +
> +		r = limit_sched(p, job);
> +		if (r)
> +			goto out;
> +	}
> +
> +out:
> +	amdgpu_bo_kunmap(bo);
> +	return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index e72687246235..ad6ca7aa74bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -573,4 +573,9 @@ void amdgpu_vcn_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_prin
>  void amdgpu_vcn_get_profile(struct amdgpu_device *adev);
>  void amdgpu_vcn_put_profile(struct amdgpu_device *adev);
>  
> +int amdgpu_vcn_dec_msg_limit_sched(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
> +				   uint64_t addr,
> +				   int (*limit_sched)(struct amdgpu_cs_parser *,
> +						      struct amdgpu_job *));
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 64531ad56c48..38a4fcf5872e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1900,104 +1900,6 @@ static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
>  	return 0;
>  }
>  
> -static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
> -			    uint64_t addr)
> -{
> -	struct ttm_operation_ctx ctx = { false, false };
> -	struct amdgpu_device *adev = p->adev;
> -	struct amdgpu_bo_va_mapping *map;
> -	uint32_t *msg, num_buffers, len_dw;
> -	struct amdgpu_bo *bo;
> -	uint64_t start, end;
> -	unsigned int i;
> -	void *ptr;
> -	int r;
> -
> -	addr &= AMDGPU_GMC_HOLE_MASK;
> -	r = amdgpu_cs_find_mapping(p, addr, &bo, &map);
> -	if (r) {
> -		DRM_ERROR("Can't find BO for addr 0x%08Lx\n", addr);
> -		return r;
> -	}
> -
> -	start = map->start * AMDGPU_GPU_PAGE_SIZE;
> -	end = (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
> -	if (addr & 0x7) {
> -		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
> -		return -EINVAL;
> -	}
> -
> -	if (end - addr < 16) {
> -		DRM_ERROR("VCN messages must be at least 4 DWORDs!\n");
> -		return -EINVAL;
> -	}
> -
> -	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> -	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> -	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -	if (r) {
> -		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
> -		return r;
> -	}
> -
> -	r = amdgpu_bo_kmap(bo, &ptr);
> -	if (r) {
> -		DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
> -		return r;
> -	}
> -
> -	msg = ptr + addr - start;
> -
> -	if (msg[1] > end - addr) {
> -		DRM_ERROR("VCN message header does not fit in BO!\n");
> -		r = -EINVAL;
> -		goto out;
> -	}
> -
> -	if (msg[3] != VCN_DEC_MSG_CREATE)
> -		goto out;
> -
> -	len_dw = msg[1] / 4;
> -	num_buffers = msg[2];
> -
> -	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
> -	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
> -		DRM_ERROR("VCN message has too many buffers!\n");
> -		r = -EINVAL;
> -		goto out;
> -	}
> -
> -	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
> -		uint32_t offset, size, *create;
> -
> -		if (msg[0] != VCN_DEC_MESSAGE_CREATE)
> -			continue;
> -
> -		offset = msg[1];
> -		size = msg[2];
> -
> -		if (size < 4 || offset + size > end - addr) {
> -			DRM_ERROR("VCN message buffer exceeds BO bounds!\n");
> -			r = -EINVAL;
> -			goto out;
> -		}
> -
> -		create = ptr + addr + offset - start;
> -
> -		/* H264, HEVC and VP9 can run on any instance */
> -		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
> -			continue;
> -
> -		r = vcn_v3_0_limit_sched(p, job);
> -		if (r)
> -			goto out;
> -	}
> -
> -out:
> -	amdgpu_bo_kunmap(bo);
> -	return r;
> -}
> -
>  static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>  					   struct amdgpu_job *job,
>  					   struct amdgpu_ib *ib)
> @@ -2021,8 +1923,8 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>  			msg_hi = val;
>  		} else if (reg == PACKET0(p->adev->vcn.inst[ring->me].internal.cmd, 0) &&
>  			   val == 0) {
> -			r = vcn_v3_0_dec_msg(p, job,
> -					     ((u64)msg_hi) << 32 | msg_lo);
> +			r = amdgpu_vcn_dec_msg_limit_sched(p, job, ((u64)msg_hi) << 32 | msg_lo,
> +							   vcn_v3_0_limit_sched);
>  			if (r)
>  				return r;
>  		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index a89e316a4add..41215ad7dfac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1817,104 +1817,6 @@ static int vcn_v4_0_limit_sched(struct amdgpu_cs_parser *p,
>  	return 0;
>  }
>  
> -static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
> -			    uint64_t addr)
> -{
> -	struct ttm_operation_ctx ctx = { false, false };
> -	struct amdgpu_device *adev = p->adev;
> -	struct amdgpu_bo_va_mapping *map;
> -	uint32_t *msg, num_buffers, len_dw;
> -	struct amdgpu_bo *bo;
> -	uint64_t start, end;
> -	unsigned int i;
> -	void *ptr;
> -	int r;
> -
> -	addr &= AMDGPU_GMC_HOLE_MASK;
> -	r = amdgpu_cs_find_mapping(p, addr, &bo, &map);
> -	if (r) {
> -		DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
> -		return r;
> -	}
> -
> -	start = map->start * AMDGPU_GPU_PAGE_SIZE;
> -	end = (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
> -	if (addr & 0x7) {
> -		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
> -		return -EINVAL;
> -	}
> -
> -	if (end - addr < 16) {
> -		DRM_ERROR("VCN messages must be at least 4 DWORDs!\n");
> -		return -EINVAL;
> -	}
> -
> -	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> -	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> -	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -	if (r) {
> -		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
> -		return r;
> -	}
> -
> -	r = amdgpu_bo_kmap(bo, &ptr);
> -	if (r) {
> -		DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
> -		return r;
> -	}
> -
> -	msg = ptr + addr - start;
> -
> -	if (msg[1] > end - addr) {
> -		DRM_ERROR("VCN message header does not fit in BO!\n");
> -		r = -EINVAL;
> -		goto out;
> -	}
> -
> -	if (msg[3] != VCN_DEC_MSG_CREATE)
> -		goto out;
> -
> -	len_dw = msg[1] / 4;
> -	num_buffers = msg[2];
> -
> -	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
> -	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
> -		DRM_ERROR("VCN message has too many buffers!\n");
> -		r = -EINVAL;
> -		goto out;
> -	}
> -
> -	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
> -		uint32_t offset, size, *create;
> -
> -		if (msg[0] != VCN_DEC_MESSAGE_CREATE)
> -			continue;
> -
> -		offset = msg[1];
> -		size = msg[2];
> -
> -		if (size < 4 || offset + size > end - addr) {
> -			DRM_ERROR("VCN message buffer exceeds BO bounds!\n");
> -			r = -EINVAL;
> -			goto out;
> -		}
> -
> -		create = ptr + addr + offset - start;
> -
> -		/* H264, HEVC and VP9 can run on any instance */
> -		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
> -			continue;
> -
> -		r = vcn_v4_0_limit_sched(p, job);
> -		if (r)
> -			goto out;
> -	}
> -
> -out:
> -	amdgpu_bo_kunmap(bo);
> -	return r;
> -}
> -
>  #define RADEON_VCN_ENGINE_TYPE_ENCODE			(0x00000002)
>  #define RADEON_VCN_ENGINE_TYPE_DECODE			(0x00000003)
>  #define RADEON_VCN_ENGINE_INFO				(0x30000001)
> @@ -1957,7 +1859,8 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>  
>  			msg_buffer_addr = ((u64)amdgpu_ib_get_value(ib, idx + 7)) << 32 |
>  				amdgpu_ib_get_value(ib, idx + 8);
> -			return vcn_v4_0_dec_msg(p, job, msg_buffer_addr);
> +			return amdgpu_vcn_dec_msg_limit_sched(p, job, msg_buffer_addr,
> +							      vcn_v4_0_limit_sched);
>  		} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE) {
>  			sidx = vcn_v4_0_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT, idx);
>  			if (sidx >= 0 &&

