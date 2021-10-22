Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C1FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 09:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D1060FD9
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 09:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A7D1060FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47EEB6E47E;
	Fri, 22 Oct 2021 09:44:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32FD56E47E
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 09:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJRQInkWxY96CIsI22p9+bzmllG8yi9b74WZugP6Nv5RsQAtp8IvnaZ9EEuTl/VF6pY8ybEVdAb4yPbCGW7CfweLevNQw5TOMj1lYDC88/Q72qb8QuEGYEubnSLXHiMdw/clIp33UP64km0fV2ejgGqSB4umZ7wPkVulw7+zHCslMPpZvJxs1hboY/S67Y3mgKK2dLuNrr4GXkdmXaLaZKO2NHG0NtlGHidmPuorBpahGcTld4czUwIQTUFJ16+E0pYcINaMvvXMuaaMUHMtyrS5Zjr0j8dxK2/ELusk4TdaGcn+e5KYGRkKvycEsUiQFodW4uOzBGoectPBI2KAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfidzA5ng9Y6LvNd0HSm1CMnZfiqi9uDPrR4bTw/m2A=;
 b=Za3BZSoFHyKnfSIKSOAGAzXpFSEiIFwATTtRbh+oRPA+DkHXcgJDLtsoY2mTRsr/9TiW+rFDM2PnlsrjCBD7kfQJ5OCx4hqb4u0nMcSssPyHmk8ay9+mSyJCKflN6rYm6O0ghoC+PTITaggcnO40dqRjIvpDqe9K46VMsCL0Mz04mEPVIjfx6rDHz8p/97fkf2ClkQ6nAoXLCD4HqMhpUjEGSr6NrB2YEcAqaB4U1lXVCBMYSzIUEyrNbtnj+D4bam4kvSQ8FvTVIFQp+ClBdoAppqmNH8V/H9w7LG0j26B/YIjWgvt/Fj449vIuLekfeknWOrlrDIneJ5KEIgPbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfidzA5ng9Y6LvNd0HSm1CMnZfiqi9uDPrR4bTw/m2A=;
 b=hAPcDvYAqk554T+e63GHiQx5LTmKoeMOaFADhSPSFwXH33PNctndOhgrT49GsYbgg+b0oVHrrs4/BbbESwgUKNoplonGfm8okENpvlT9F7al5G0zD6GUKIx/56Sz2ws3TtrXB3l7aEFFRx9yNPZf6ZxxNe0rTwa/B8rQiE0Eqq8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR1201MB0078.namprd12.prod.outlook.com
 (2603:10b6:301:56::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Fri, 22 Oct
 2021 09:44:24 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4628.018; Fri, 22 Oct
 2021 09:44:23 +0000
Subject: Re: [PATCH v3 1/3] drm/amdgpu: do not pass ttm_resource_manager to
 gtt_mgr
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: andrey.grodzovsky@amd.com, lijo.lazar@amd.com
References: <20211022093231.7787-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3c9138cd-3635-29fb-f4c5-19eccb2b1410@amd.com>
Date: Fri, 22 Oct 2021 11:44:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211022093231.7787-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR0P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::14) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:a39f:d981:e7cb:e6dc]
 (2a02:908:1252:fb60:a39f:d981:e7cb:e6dc) by
 FR0P281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.11 via Frontend Transport; Fri, 22 Oct 2021 09:44:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a36f8037-2092-4d50-0821-08d995408785
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0078:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00788F4BFF24189E6BFB9B3A83809@MWHPR1201MB0078.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zQ2RuDWtO2sozUCkRDNvpVwEvNmmXxuunL0XsRt7Wo7TBjD++YKrkm2WOr+nTSO3reHFUATvC1+XA0ITqfpP1esu5oX4X7GLfm75P9vP90XUZ0Y4Pm5kdLo9ptNCiS8AxI5rIiKL34AC01qeNQ6aElpMAexpy1GAvoZnVqs5PD5W0gd1jshZHQW7qU04RFYdPD9TWNJ95TFWu0BGm5WshntLblbbdNT1VLw3Art8s54N+gKk2GG1A8sMEprFlMHbOA0YHKcOD8mPsCnC+CAzO1KCD1a2SmxYKcoHEKJxUj8E3/W9LH/YdADsUDGjsfknfo0H0Z7acFKi3oUkG/Mds5H9x7RSpVTic/RfjWvLN8K/PGJvPWC3VU5BN4cbIpa/CxXVdEhcsHkCcC7hdySkNKgXJBZs3yuBF76Z5GgQWe1ZuJYiS88EyaZX7WhAdRYrf2n8auA0XCB0aQE7MX48L3kPUL60IAYW1Fw28ZE2TbXG6Mly6U+Y9xcIpofHoPA+UBf2F9pD4DUHLHh0HlhfWzbzOMircopV/mfZakYBMZBPPpRpMHWMNEKD1AtusOpqyrnOeawlCfSimzFogmIMu6lkb2O4IEMiUGEHejATpGN/gp9UI7yWRHVxxY31ub3K7j8Yc+KvaUjf+TbZ1y7M9L8i20jie5Ko6hfPmoJLy66SsLJmhr9VQ8YjsYP/JHjaU1x/aioxzXJs4bXAmbQwAQDm33GsIJaHVMppvBg6RdMFZ/kWnR+73vijGycTSfW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(508600001)(66476007)(4326008)(5660300002)(316002)(6666004)(66556008)(86362001)(2906002)(2616005)(8676002)(36756003)(38100700002)(66946007)(186003)(6486002)(8936002)(31686004)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFo0OEx5ckxHalVER09aZmZBUGhjaHcvbERGUndCTldJcm9vS1BzM0ZwU2NX?=
 =?utf-8?B?YVRpZWlrcGh5RUNJKzdhaUR1MW1Gc1JtWjBnM0d5dlZSN25BbVJKWWVwQ0lm?=
 =?utf-8?B?amxMN1A2STF6ZEQ0OE1sVXhIOW9USDdkMVo2VzVkZ0liUTdkOUVlVllLU1A3?=
 =?utf-8?B?S3o2dFZrR2JRYkRBRWsvcHhEL2lRY0FsbXc1RTQ0Y05xOVg5ZllQTUFQRGM3?=
 =?utf-8?B?UUl6TDZDVUIwOHJmVDBtaHo2N0hEQkg4Lzl0YklYR1pzUGhoK3YwZS9kUzdj?=
 =?utf-8?B?WndPTU5LWll0Rk1XcUVvdlpwQ1ZNc01XbklGK0x0cmNQbURtc2ZyRUZXM3Q1?=
 =?utf-8?B?bG5YVVdZMk5wVGt2YVMzeU9qamhySmVzVE5DVnhoNEZBVGRJVHNjZmNVRzd5?=
 =?utf-8?B?UUMzSmNUeFI1RDk3YXJjUDBSYTBDREJ4SURvOGpTZEo2Rng4UFRyejIyeWta?=
 =?utf-8?B?eDQweHNwWmNDVEpkUlFCN2RBTTdIUjFNd2tYSHdIOVdUSFZXOGRjbld0SXpD?=
 =?utf-8?B?SkMzeTZydVFMWWM5d1JHUkR0UVZzZTFKSWI3R1RCS3E2aDlsbnFORUJHTy83?=
 =?utf-8?B?K1pSenpGdUVRaThJRzcxMFQ2ejEzeWNFVElhNVJ4a0FmWXIrMHJIMkhVUGZ0?=
 =?utf-8?B?bEg1L3FrWkNGaHoxbmFBUGVTTG1QMHNVU0FjQktqWWZIR3RtcVpFVEFZZi83?=
 =?utf-8?B?RDkxcTdxdWd5Y2VmUWJWTWErRVQvZGd1WmtDZ3pYMGsxVHVYMkVXeE1GNnRR?=
 =?utf-8?B?dmV6N0R3WjFjWEN5TUwxbG0zU0FWTjR1YlZRVVhNL0JTT2hJcFR2VFRpS0s5?=
 =?utf-8?B?eHhpWmh2MU4zR1V1OG1rVHcrWDBKMWZ3d0JMZFdEeHpHM1RkTE1pYjZaeUVZ?=
 =?utf-8?B?cHBKcGE1aGZPblJ5Y0IvQ3R3cEI5R0pPcjVmTUQvTjhoNUtMUElTZ2RlYmJ1?=
 =?utf-8?B?ZjNFenNRd1hmd3NnWlYwSTNSSGtYekpNcVZlbmlYOTYrTS9mV3RFcEM4azNR?=
 =?utf-8?B?R3lWY1Rwci9IelBBMjhhN0M3UDlIRi83ZHJZSUJucklYVldFOWI1RTY5UWUy?=
 =?utf-8?B?ZnN1ZjlSTzkxcHhZUjlLcVZLdGpmSUE5cHR1bXhlSEdiV1E5alNheGprTnZu?=
 =?utf-8?B?TlZYOFJ0V0ZiOTY5aEl4NVNCSWgrUzJDQStucWZiZE1MMWdwbHcyTVVsRDBa?=
 =?utf-8?B?cTQ2U0JhaVpJdU9TNUswZW1XU1JoWWFXZnRiTnRyb0dJSW9tcks5THlPWVd5?=
 =?utf-8?B?QW9jU2plOUZYMnpsamlESURXZ1NTb0h0NGRVTFAwdVJjbzdXSllFZ01sbXRN?=
 =?utf-8?B?Q1dtQ0RoWlI2azU5ODdxazJsbGtsTjQwUys4aGpYMmQ1a2lKeGNLZUhlbTR2?=
 =?utf-8?B?SXNDdGVDM2drOUx0ZHNqNGxJRGRiell5NzZSQ3RYRmlpNTFiVndhNTlzTG1T?=
 =?utf-8?B?MHMzREx0UjZ1aDdjb1pyNVpVeEFaVUIwcjdwdElodStBMHNjbGk1ZG1BUUh3?=
 =?utf-8?B?SjRXd2llMzQ5TzhmL0hUOUR5d3lLK05xS0VVL2I4eFdWZWh1SCtSbnI5S2JP?=
 =?utf-8?B?YURBTkNKaHgwRDRVTTlVNUVXTmUwMXlwOHBkcTlGbUpCUFY1NmhxQTNyKzZU?=
 =?utf-8?B?RjRlbE9QN240NldMOFByTy9FdG8wTys2bHk5Rk5jdERsK0liV1p6dmdLUmli?=
 =?utf-8?B?dGo3Q1VKdytzSWI1V3RQb3ZjUjRQWUNPMjhIdVplbzdyMWs4d3pEUW9IbGgz?=
 =?utf-8?B?NzJSWm5aL2w2aC9YSFZqOFlEalJQZ2hpek9xUUpUcFF2MlZsN0M5cU9HYVBw?=
 =?utf-8?B?NTFxV3g4VmgzNzZ2c2JDQTV0TDEya0FUZzZPM1VyY29ETnI4cURrMlFOT1Zn?=
 =?utf-8?Q?xgJsHpOGi0hGH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36f8037-2092-4d50-0821-08d995408785
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 09:44:23.6542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0078
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

Am 22.10.21 um 11:32 schrieb Nirmoy Das:
> Do not allow exported amdgpu_gtt_mgr_*() to accept
> any ttm_resource_manager pointer. Also there is no need
> to force other module to call a ttm function just to
> eventually call gtt_mgr functions.
>
> v3: upcast mgr from ttm resopurce manager instead of
> getting it from adev.
> v2: pass adev's gtt_mgr instead of adev
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 23 ++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 ++--
>   4 files changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 41ce86244144..2b53d86aebac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4287,7 +4287,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>
>   	amdgpu_virt_init_data_exchange(adev);
>   	/* we need recover gart prior to run SMC/CP/SDMA resume */
> -	amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>
>   	r = amdgpu_device_fw_loading(adev);
>   	if (r)
> @@ -4604,7 +4604,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   					amdgpu_inc_vram_lost(tmp_adev);
>   				}
>
> -				r = amdgpu_gtt_mgr_recover(ttm_manager_type(&tmp_adev->mman.bdev, TTM_PL_TT));
> +				r = amdgpu_gtt_mgr_recover(&tmp_adev->mman.gtt_mgr);
>   				if (r)
>   					goto out;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index c18f16b3be9c..62e14efa61fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -77,10 +77,8 @@ static ssize_t amdgpu_mem_info_gtt_used_show(struct device *dev,
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	struct ttm_resource_manager *man;
>
> -	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> -	return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(man));
> +	return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr));
>   }
>
>   static DEVICE_ATTR(mem_info_gtt_total, S_IRUGO,
> @@ -206,14 +204,15 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_manager *man,
>   /**
>    * amdgpu_gtt_mgr_usage - return usage of GTT domain
>    *
> - * @man: TTM memory type manager
> + * @mgr: amdgpu_gtt_mgr pointer
>    *
>    * Return how many bytes are used in the GTT domain
>    */
> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr)
>   {
> -	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
> -	s64 result = man->size - atomic64_read(&mgr->available);
> +	s64 result;
> +
> +	result = mgr->manager.size - atomic64_read(&mgr->available);
>
>   	return (result > 0 ? result : 0) * PAGE_SIZE;
>   }
> @@ -221,16 +220,15 @@ uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
>   /**
>    * amdgpu_gtt_mgr_recover - re-init gart
>    *
> - * @man: TTM memory type manager
> + * @mgr: amdgpu_gtt_mgr pointer
>    *
>    * Re-init the gart for each known BO in the GTT.
>    */
> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
> +int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>   {
> -	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
> -	struct amdgpu_device *adev;
>   	struct amdgpu_gtt_node *node;
>   	struct drm_mm_node *mm_node;
> +	struct amdgpu_device *adev;
>   	int r = 0;
>
>   	adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
> @@ -260,6 +258,7 @@ static void amdgpu_gtt_mgr_debug(struct ttm_resource_manager *man,
>   				 struct drm_printer *printer)
>   {
>   	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
> +	struct amdgpu_device *adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);

I think that variable is now unused, isn't it?

Apart from that looks good to me now.

Christian.

>
>   	spin_lock(&mgr->lock);
>   	drm_mm_print(&mgr->mm, printer);
> @@ -267,7 +266,7 @@ static void amdgpu_gtt_mgr_debug(struct ttm_resource_manager *man,
>
>   	drm_printf(printer, "man size:%llu pages, gtt available:%lld pages, usage:%lluMB\n",
>   		   man->size, (u64)atomic64_read(&mgr->available),
> -		   amdgpu_gtt_mgr_usage(man) >> 20);
> +		   amdgpu_gtt_mgr_usage(mgr) >> 20);
>   }
>
>   static const struct ttm_resource_manager_func amdgpu_gtt_mgr_func = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index d2955ea4a62b..603ce32db5c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -678,7 +678,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		ui64 = amdgpu_vram_mgr_vis_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM));
>   		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>   	case AMDGPU_INFO_GTT_USAGE:
> -		ui64 = amdgpu_gtt_mgr_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
> +		ui64 = amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr);
>   		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>   	case AMDGPU_INFO_GDS_CONFIG: {
>   		struct drm_amdgpu_info_gds gds_info;
> @@ -738,7 +738,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		mem.gtt.usable_heap_size = mem.gtt.total_heap_size -
>   			atomic64_read(&adev->gart_pin_size);
>   		mem.gtt.heap_usage =
> -			amdgpu_gtt_mgr_usage(gtt_man);
> +			amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr);
>   		mem.gtt.max_allocation = mem.gtt.usable_heap_size * 3 / 4;
>
>   		return copy_to_user(out, &mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 91a087f9dc7c..af1c4e414979 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -114,8 +114,8 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
>   void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>
>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man);
> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man);
> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr);
> +int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>
>   uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>
> --
> 2.32.0
>

