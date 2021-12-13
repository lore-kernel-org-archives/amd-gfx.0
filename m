Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D122C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 06:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C02510E5F1;
	Mon, 13 Dec 2021 06:51:47 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B13010E5F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 06:51:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIxJenDbleCEvnSgi61M92xC722PE0UBcVfUYoiwOiyvcrBxd5lM2czap9QSvApcSOS+E6V3AbI/n0XBDyRNb11E3UjsmFtQAYpGWGW5Jqaz97Vh1ZXYZuMghy0VenI/BBtCnJwqSJfsOOSuYRxrMkygaHbq+oddLleqVUZxGasi+WwkCi2ZoR2nMVaVd6PhlHOn95ZKvtK162VMu17WDNcqiBuQBwL2lWcC545MYyFIBRjeBtAbnzDwzZPxj+Lsh3U+eL08gvHAkEz6NeU0BldHXhTAODq8wGSzWmULH7nN+HoKKd9HJ0U/hVFrzZnzKDTbhWbHTo4MxMwiwgLhBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0qtdZM3S3jcIlevgE4x5nOTrDOpBI0zlW/YQ6WV6Jg=;
 b=UL/9+1qpUf+kcA04ZnW0kJX5WtjlLknen34D9EI0fPxUzFNi2FA+FBdiAVshXuoUfPDQAS7zqQHb3+qDHi0uGsCEu/FA549bfMB11NJ4R1KlnzKVB9t0gI04MCTp1plFNHx317m8jCuto4yMHW99GrEx5fu0JpczF3NwgpHgFIhErcR1dnTRDdI/JAqHShFp0bAJYobps2yZ1EdZlj94ySBS5HqA7JIgd95/YJk3pdIjD6O6FBEZX+uvJGhiKg1wVWJcrwIm6k206wdBnYqg663PgJJ91xNaU6vzud/dhy8YaOj8on0/Nixj9EfJnqR7M0P4+qpKIfvNahKOATUzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0qtdZM3S3jcIlevgE4x5nOTrDOpBI0zlW/YQ6WV6Jg=;
 b=geL1b1plVuBHppDq6JCUNrEvbyTzbTOQFCXdHMuJg29EvMneGa8R1m4vJB6WkyoIruafsLUckun2hPguQY7I1O+4ca+Kp1G3YU6meYZEdyzl9gbBTVVMXmlPJwioZ9+nRGoRQ8PcJwMfTSf9tYu3b3zrYVEPd3JrM2CG3iH+67A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4973.namprd12.prod.outlook.com (2603:10b6:5:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 06:51:43 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 06:51:43 +0000
Message-ID: <62e3d5ec-65ba-1e39-07a2-c16df1b81d37@amd.com>
Date: Mon, 13 Dec 2021 12:21:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: move smu_debug_mask to a more proper place
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211213054241.773719-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211213054241.773719-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::15) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cb0b32a-ab1b-494a-70de-08d9be0505ba
X-MS-TrafficTypeDiagnostic: DM6PR12MB4973:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB49737767C0E9F4FF5418830B97749@DM6PR12MB4973.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6BDcRQrTRGD2BeoyVA0Ue+YGrn9d2bimotbMpAMvm4eYw/7hWi1+ilOMmNFk1hhgU0cBk5WgPKDiVrEhw9Vni1qN7VgKpaUhxkCqGNOALnPeYwNx1TX4AYRAo7QupDK4DKM+2/sbxBkFxuQ0NENrIkMSFwm4khP9bTKg8unjIkpa16i3tqfTjYyOmcbGzWdAi239NeQUP5yrt0ntuirf6K3duPCVnghrvTOC6Gsn+NnmuPiMoOo8PIl3XTA2aIpYp/ngmI2ncPpsfF5GbrPuonGUkG/kUQW4vkyNViUv9YObrt7Fh5pT3sd/XNwfjhhIuK/ZpdQzLNQEvb2yyP/uC4D4Q9Q2jZ6krkMTBMnnoQXZHi7hyKJc9nJ4enkhKCrFhlCoIuKjLEDiFeQYIsmFzgHLDGmY+ZkUQaHzCdZ7dKbUgnUJUHYTI8RqXN+CNpxuyZV3LFbg3I3PGZGTQnRhWO4Z5Wtbr0BTLXyi1YhUxPxGPZ9TM7wKittuxQAKNKH6IgfySs+5JcXdU1yGxVtfePLAM07kQk59o2qxltMsr4/mSotiOGHhdIze8y9HsKOoUQeMnAAUK4Fuay051OC2mjSyh38oqX96S3bhrvR8OWwpx+y3oYVzG7oFnFAGSV05QWg2LygD7P0QQ/Ft3gzLmuMq5Ht40K+iJ/HegkWBqDX80ivkfJ4Am8+t/3T7Kv2FaM5qHEQCo+RIa0jas59H3mFH14MeLFTGsPl2IV5TUxE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(66476007)(66556008)(53546011)(4326008)(6666004)(2616005)(83380400001)(186003)(5660300002)(508600001)(86362001)(31696002)(8936002)(26005)(6506007)(2906002)(31686004)(316002)(6512007)(6486002)(8676002)(36756003)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnlQMVdIUXY2TTN0Z2NBb3psdVBFMHJyRVBSZGNrTks2Qjd0ajArYkVRY0JE?=
 =?utf-8?B?VWxxWjZ0eE1QY2JUYU1NRyswOE1VQXBJbnRsYXRrbDVPcUVwUU9SckdqM3ZF?=
 =?utf-8?B?eW05YVh1QlBMZkJxQ09wN3NNTlVwSllRYk52ZGNOdnp1NE4xWDRtb1paR2xl?=
 =?utf-8?B?RHlaeUZtblh0bXBodEUzZjhveEJFREZBUk00eExlRWpPRFh5QzAzUXdvMlhK?=
 =?utf-8?B?enFZM3VuRGtqNHluTmV1VC9wOHdIajZueVk2NjVHd05SamtwNVl4b3p6Q09M?=
 =?utf-8?B?WHNHQlA2ZUZZQjlRdDc3Z1lVTUh3SHdaeXNjK0s3dFdhUUtXWi85WkJVMEtT?=
 =?utf-8?B?Q2VHTVZ1eUxUKzhiMXVMK0ZDVGkxQ3NQN2RNNlEyWFJXZmxXMzVod1VWSldO?=
 =?utf-8?B?OGVPcWJ4QTFkQytublFVQmR5OGwxNXMrd1l5aitJVXVnL0JadWN3ZTAzTExJ?=
 =?utf-8?B?RDRaNnVQT1NpUXZXWXhuREoyeU5oY3RTeFdRbVpqMStmaWJ5d0xYSXN4eXls?=
 =?utf-8?B?d3JiQVRYMjlEWTRmdzBhZ2NldTlBSmoyWDRYNnpsTitKc1NscGpzSkZtZUhB?=
 =?utf-8?B?aENaUXlKZzVxeWdTLzh1VGVjYlNPakZqZG1FNU9NYVlxL2hNUEh2cTlaa21R?=
 =?utf-8?B?ZE9YRlFvNEJESXlYYlkydFhuY0NPNy95bmRBNTNaS2FrKzNPRktlNUMxZCtC?=
 =?utf-8?B?RDFPQkt5MzZ3T2lnR043U3FwNHUwakVTalVnWitEdTZ3R1YzNm9MbUgwcXd4?=
 =?utf-8?B?blVZVWh0NVVreEFtRVZOcHJ2akpkcHVKUVlDYTdPbkZBYkxmYXc2OTVaK1ox?=
 =?utf-8?B?ZFY5SWRqSzliMWg5TElTWWZNQ1dlVEpBMTdkTVhBbFE3NnFkSVNXWmJwM3Bh?=
 =?utf-8?B?ZnF2TFhpNWhnMWZYNzlVZjM2N3Z1bmZVdFM1bWZXTHBZVm55Z0tFV0ZhbzZh?=
 =?utf-8?B?TG91K3dCcXlKc0dCdmMwQmlBMFNZRjd2b0xWeDVWOFFQMnREU2JLV3l2MnQv?=
 =?utf-8?B?QytmN0VTenhlRnJYWnhiWmMwOFhqTUZoSncrWXhodTNHYTM0bFdCRENGOTY1?=
 =?utf-8?B?WmNrV3FxN2lWbllmdWtHamNSSHJkMW5FQ202NlJ3aHB2am1SeEtjS3N0UCtv?=
 =?utf-8?B?bzdWeFRNbWNaa2dVVU1tMVVYL1djNDVlajE5UnVaREtFZ1lEWFAyMnVQNVZI?=
 =?utf-8?B?NmR3RFZmbnF4ekU0d29MYnRvenJlRGxOdG9sUUVwUnRRNXFrVm1tY1pIa3pX?=
 =?utf-8?B?UExiWENPd25iM29HbFJ0cXVIWmVRR0FkZkpmNXVPb3BBUzNZeUJRa0Nodm9a?=
 =?utf-8?B?Z05FRHcvWm1BN3Nyd1hGZnA4b3QrRU5sRDhhZEhoZXVIZkVCNUljUFdGUnY0?=
 =?utf-8?B?VlF0YlRFUkE4dGh3blRVcUhnejB1cSszTWJsR3dmaVl5SXNGVUxTNHNpck5K?=
 =?utf-8?B?R1pQYktPVXRpcm5VL2RnNFA3R3BORUFyaGo0Y2lKdHlKdkdUWFFzRGJxRU1B?=
 =?utf-8?B?OFN2N2s5bnE4TkFYTjE5UzUvdVg5NXhmaEF1Ykx3b0p5SnBHdU9PaEJRZ05v?=
 =?utf-8?B?d2N2SEJSanBqdFlNcERTUWk0SU80SmtpcXp4ZXc4ZjJRRnNHenUrZEZzMVEy?=
 =?utf-8?B?OXM2dytMTnYyYTB6VkZKNmdCWWh4b2NnaUh4NFFIenk2OHZuRUxiTTEwSUcw?=
 =?utf-8?B?NUs3UEk3STNvRFZMYk9ReVNEUDRyUUxLOEp1dkZ0bHltbkFHUVVoRXN3N1ZC?=
 =?utf-8?B?TmVvRkZRWjJUQXBzdGpJUHJxK2dDUnZ4b0UzR1h1ME1SeGVscFFKcDQ5N05J?=
 =?utf-8?B?eTBTU0hxL1JnbTVZNVhIREN2a2w4aWNBaFFQZEhHNHRGQ2FzMjVoT0NTQ09K?=
 =?utf-8?B?TjJMQ3dVWjVNRDQyK2hlQXQwSTJEajgwR1ZBTVdkaXZGUVlLS0ZRTEl3c01y?=
 =?utf-8?B?eFF1NzU0VVQ0UkhkSUU1NlNjNUpyVkN4Z2tvMm1CeDF0ejBHSFdrNGpBWUQy?=
 =?utf-8?B?L0Exd205b0hPNHFPTnhUZXczdnlWNEVBeFdFOWlFckhQaEh2aEhGT2R6a2hT?=
 =?utf-8?B?K0tUUmh1MHVrSFRyUXdIdDltVHFBQXFVSGtBTDQ2aHJESmlXbE1FcFR1UEQr?=
 =?utf-8?Q?KhAc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb0b32a-ab1b-494a-70de-08d9be0505ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 06:51:43.3382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQYft66Kg9RB/bVvAOORg43uCM1/Md17fk+H3Ld6Em1FZD178ZzzzN5PL9Wsudk1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4973
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/13/2021 11:12 AM, Evan Quan wrote:
> As the smu_context will be invisible from outside(of power). Also,
> the smu_debug_mask can be shared around all power code instead of
> some specific framework(swSMU) only.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I1a0e1a436a51fc520a47b3fb28cde527d4e5eb6e
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     | 8 --------
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 9 ++++++---
>   4 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e701dedce344..9ceb8f3e73de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -811,6 +811,9 @@ struct amd_powerplay {
>   					  (rid == 0x01) || \
>   					  (rid == 0x10))))
>   
> +/* Used to mask smu debug modes */
> +#define SMU_DEBUG_HALT_ON_ERROR		0x1
> +
>   #define AMDGPU_RESET_MAGIC_NUM 64
>   #define AMDGPU_MAX_DF_PERFMONS 4
>   struct amdgpu_device {
> @@ -959,6 +962,10 @@ struct amdgpu_device {
>   	struct amdgpu_pm		pm;
>   	u32				cg_flags;
>   	u32				pg_flags;
> +	/*
> +	 * 0 = disabled (default), otherwise enable corresponding debug mode
> +	 */
> +	uint32_t			smu_debug_mask;
>   
Maybe, better to have it inside pm.

Thanks,
Lijo

>   	/* nbio */
>   	struct amdgpu_nbio		nbio;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 9dfccb20fedd..ee1cc15c6f09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1619,7 +1619,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   		return 0;
>   
>   	debugfs_create_x32("amdgpu_smu_debug", 0600, root,
> -			   &adev->smu.smu_debug_mask);
> +			   &adev->smu_debug_mask);
>   
>   	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>   				  &fops_ib_preempt);
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 12e67ad9a3b2..2b9b9a7ba97a 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -482,9 +482,6 @@ struct stb_context {
>   
>   #define WORKLOAD_POLICY_MAX 7
>   
> -/* Used to mask smu debug modes */
> -#define SMU_DEBUG_HALT_ON_ERROR		0x1
> -
>   struct smu_context
>   {
>   	struct amdgpu_device            *adev;
> @@ -573,11 +570,6 @@ struct smu_context
>   	struct smu_user_dpm_profile user_dpm_profile;
>   
>   	struct stb_context stb_context;
> -
> -	/*
> -	 * 0 = disabled (default), otherwise enable corresponding debug mode
> -	 */
> -	uint32_t smu_debug_mask;
>   };
>   
>   struct i2c_adapter;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 43637d55fe29..b233d9d766f2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -257,6 +257,7 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>   				     uint16_t msg_index,
>   				     uint32_t param)
>   {
> +	struct amdgpu_device *adev = smu->adev;
>   	u32 reg;
>   	int res;
>   
> @@ -272,7 +273,7 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>   	__smu_cmn_send_msg(smu, msg_index, param);
>   	res = 0;
>   Out:
> -	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
> +	if (unlikely(adev->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
>   	    res && (res != -ETIME)) {
>   		amdgpu_device_halt(smu->adev);
>   		WARN_ON(1);
> @@ -293,13 +294,14 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>    */
>   int smu_cmn_wait_for_response(struct smu_context *smu)
>   {
> +	struct amdgpu_device *adev = smu->adev;
>   	u32 reg;
>   	int res;
>   
>   	reg = __smu_cmn_poll_stat(smu);
>   	res = __smu_cmn_reg2errno(smu, reg);
>   
> -	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
> +	if (unlikely(adev->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
>   	    res && (res != -ETIME)) {
>   		amdgpu_device_halt(smu->adev);
>   		WARN_ON(1);
> @@ -343,6 +345,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   				    uint32_t param,
>   				    uint32_t *read_arg)
>   {
> +	struct amdgpu_device *adev = smu->adev;
>   	int res, index;
>   	u32 reg;
>   
> @@ -372,7 +375,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   	if (read_arg)
>   		smu_cmn_read_arg(smu, read_arg);
>   Out:
> -	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
> +	if (unlikely(adev->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
>   		amdgpu_device_halt(smu->adev);
>   		WARN_ON(1);
>   	}
> 
