Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BC5C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 11:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7EBA61350
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 11:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7EBA61350
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E8B6EB24;
	Mon,  8 Nov 2021 11:16:13 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2041.outbound.protection.outlook.com [40.107.96.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12F586E942
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 11:16:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVnXCwn8w4kJ5LQlN49XmC/lcZ2A2G7s45nP4Kf6AfLjIFe3JjoYUjQkGRLHpGMa98MorkCCKJ4bNyMQ6QqoImaKdDEslljmXivZQ38lhA8dkH33W1NEMSAkJ+/ANPSB3219Y9aivT8bXshGRv4YFjCHp5PB/uJOPq+eZQ42dZpyNN+Bn8AGYKJi2GbdbLTlx41gPUNd2/mD8PEjpIvwspJEVQiyVZ/LClC9Hul2dHAlkXCICLkq9DU+njOI8EzMLy2bpKQl6GceqCvMgAisoJBzzBYxMf+jDvBUVzM+iM9XONyecGbHn+umHhNMMGtJkB+wco26Fx4GnqfL5h3eEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJhqS6v9hsJJtQLAlEg+Pr08iu+pclRDbXoX0UBg1pA=;
 b=QGo1+ergWWnprBeU6zbPkvbuFj0nH+SCN7Jmb7mnmRVu2iDasT+UWipq6U2hVBRk8MEJ7NRwCHnLFGGLX6MrLurBZE7Q4sT37PJ4NC7zjR5MU/OY3mIuzs7TId0baDayuVztLOWCpE7z8LU9CQ5rC3mVopWZpy3J4XaTCSZFCpBod83mWoqbOAPyJl9xd1IyMcy2meSMQMYkUQXXg/7d+jSRY6OYV1TcKM5lgo3OIXvqDHa5Vla0yIlMfCO+qwfncC99CN54H5LlzbXZMGi+Z5tIRohNLrhmx7xdVvLkY/JPjz06r3pF1re96CiOJ1BEppaYpBJfaN3V3ObnAjECCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJhqS6v9hsJJtQLAlEg+Pr08iu+pclRDbXoX0UBg1pA=;
 b=SVeAKCSI6tmNKnvseiwJidQPThV0frH3ZGrM4DAF+FiiFdICxB/+uWnz67hIqpNxl9B3KbfQher2WiJz0/rMZ2C2o1g8cozfNDrddd5AMnV9FxCZoiNjr4aexvh3H4qL+Yk2btf8VJHDJEyevlJjVr8JT9SbnxCwKuHZRfjUHFQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Mon, 8 Nov
 2021 11:16:10 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 11:16:10 +0000
Message-ID: <80a7b1d5-f57c-ef32-bd90-9e31554127e2@amd.com>
Date: Mon, 8 Nov 2021 16:45:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211108044723.54716-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211108044723.54716-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::19) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0057.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Mon, 8 Nov 2021 11:16:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7dcdb1d-edf8-4eb8-f1e9-08d9a2a92a99
X-MS-TrafficTypeDiagnostic: DM6PR12MB4042:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4042751E0E92AE11319BB04397919@DM6PR12MB4042.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujQgjmmTkexrUomRsdKSMWp9LSWfpukKqcbUehMB6/dYFBCRyl+CRn4H1ajXT/2YofymJEfpRCWnECe5eLoU4iH39+g5vqpRoneyPqEWlWJkl0MquWn4tow2Gpcd/YQr/7gZvRDN+/WL7LJF4vfHhZzkP5Rzm4HP1fjkNzjnm9HHyvf5ZF4wXiiBstjl8aBgTSxQausCWaluE+PdNd6h6o91mBLRKqm9Adv9oPyb6pCzOLpjYERDSEbhWQAgG2RvKSOd3cY4sxVwD2SFZ7wuq1SaJIT65uzQyQxfYhCDJoPecFotToQRAiKeDwPt6h7SvtQyKe8mRjYsua4lW78XvJ+UmpDY9p8WuisR31vuBN9Zgn0UKOvmGnhH7mA9zaHer53+iYpP3n/a+T5r6ECCZj2/P3xp3FJOfcc5rWpUPonSysJUaR8WRxV04qoYEgYuMvxVB8CUH8ACLyimCwS7cIXq5m5rNo8rhi9DHTYivV1vcC9Gxdg4yGjBu89Emb4l7EGdFK9JftrYCpAMDoiV/u1zyGUcNlvC72w8DNsYsVZPaJSm3iAyeB6rD8YUzwXcvj6OPs+4QzLggMCPc4kPIYqk0DDUEC/r8wpiOaKEd2yg67u+dw5ZQBpR65nKFFjsDkvxJYSz4t/pZPqY1VBDIPMD3ZWLXYQOnbFo3QIBeMRKkfs1JVznPreUuI7BtFzedPPvxc7m+kYBHUQkGmgj00esEcbMsIsLwqu9UbcaNvmkyEUW35RO80ao3X8TahCI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(31686004)(86362001)(83380400001)(6666004)(2616005)(316002)(16576012)(66476007)(956004)(6486002)(8936002)(2906002)(66946007)(4326008)(5660300002)(508600001)(186003)(53546011)(26005)(66556008)(38100700002)(8676002)(31696002)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0pTU1NZektPUHdPNEc1U3YwQXJzbWd1c3pRRGwxU1VGV2JZT2ptcjFsZGdv?=
 =?utf-8?B?QjBkYitKWHJTVE1Rb25kcEIvdnFWSWI1eUl5NWJmeEN5aHNuWWJCeTFwaDBO?=
 =?utf-8?B?ZGxnZWdHblYvNTB3U2VrUjMyZUtSUWhLTGRrYzNiT2g1aXM4M0F1Uk9JMUti?=
 =?utf-8?B?Yk5JMXg1Y0w4VDhJV3RCUkxGWWc0K3pkazhESEp4WkFQek1hZGc0OWdYTnNH?=
 =?utf-8?B?cy81U2Zpb09veXYzeVZWbkVwQ0tJTVZuUDJiaVpFbzVwbEs1Z2sxVmU2QS9O?=
 =?utf-8?B?T09PM2ZML1p6Z21ORlordlVKdjJFT0lFRWFPRXlsMkFHdVhSRlRub1Z0bW94?=
 =?utf-8?B?VGdyb3hPQjh2cVZmYkdsVEpSaEY3anZ3b3dvVjg3NEFQSW5idGlyM3d4dU9Y?=
 =?utf-8?B?cDcway9jRzZSRmU3WWxCUVFsTFdkdDBEb1o3QWlxREJrY0p1YXRybzhWTkFn?=
 =?utf-8?B?cDdkZkduVGZKMzI3NWx4Um9tdzBaUFZWbVB1VHBWU0VpK1B1dlNybFlsb09V?=
 =?utf-8?B?Ui92WmxFdytReGdzU0NzMXp4Z2ZOR2lncFFCRUZ6d0pZRlRlbFNGOWMza2VY?=
 =?utf-8?B?NTNkRm1lUGlMMTNVeDk2ZHJXMkR2K1JOL2VIM1B5Y0lkLzFMU1M2OENTQ1hE?=
 =?utf-8?B?OExNaHB4aVNGQW5pSWo5dlVXTkRkbkJTMC9GSHY1MnRaM2ZDbVhLeWtwSEJ5?=
 =?utf-8?B?VGNJMU9DWXJnOHhDL1lpSlJsa1NnR1k1MzIzbWh4T0ovdGRraEY2WHF3elBo?=
 =?utf-8?B?blgvc1FZZTYvRzhWTVlyR0tidG9rNDc0T29HTkxUeCtnVEVVOWVVVXRtYkVy?=
 =?utf-8?B?dm9MNTFhL3BTMFNQQXNGcC9seXI0MCszVThYVzlzZjV3WkpwSndXeXFDa0pn?=
 =?utf-8?B?cHRaUkRzOTFmNDVTMUpJdWZVaCtwSFI5YU1OcXpOWXUwMEhOY0lsNis5dklO?=
 =?utf-8?B?aHJWVXhFV2lXbjJCMVJaTmNMRVg4Qm12Z29aTDhVS0hGM0ZFZzd6K3BoOXZR?=
 =?utf-8?B?R2g1N2hiZjN6VERzUXhRRjYrV2VjQ3hJSkpaU2VrRkpFNjFrOXFENUtjWUhX?=
 =?utf-8?B?TFI4VVM5UE4yenp5am02eG1rL0lDeTI1dkIweEhuN3V3T3R6dG4rZG5Dc25M?=
 =?utf-8?B?Sk1HM2hSc1NSWm8yQzlzME1kZzRIL0RQNzl5cVhNa2VNekNkSXBoY3hCMUIw?=
 =?utf-8?B?alA5UTFjRzcwTEJnNXJZaVA2cklrbEplb3NHdHlLQ1R1djZnME9XMWIycU9h?=
 =?utf-8?B?cis1enFNWkJEUUc1UEtWVjRTaUdYd2U0ZE9QeTRBTGpHMG5xYmsrSHNZbEl1?=
 =?utf-8?B?Nk5SK3BSaDIvRTZGK1oxQXNRSUJDdXRZemJHSlJwbGJrajM1bFcwNGJUaytF?=
 =?utf-8?B?bGZIRkJJMDVMT0hVMXhudHo1TUVmb25Tb0VZcmxQazhicGtqdS94cjNERGRC?=
 =?utf-8?B?dGZpU3gwSm9vR2MySldobUJiV2xFRnNIVUdyQm9raTl2dDZ2RmFZazlhOCtt?=
 =?utf-8?B?am15TlRZSDZSN3k3Qm9yM3hvSW0rNHRLdkczUTZFcHJwTmt1cjNUUndKWTJM?=
 =?utf-8?B?MkxjN1BISEVYRTh4OVFLWDhsSldiREtwdGt3Ui9kU2I2QjZqZEN4SzNyTkdW?=
 =?utf-8?B?ZzFJaC9sblJPNnFqbVord2xaMGVCbG1nbGdZTURTckN3cU9tamNQbEdwZlFJ?=
 =?utf-8?B?WGFmUEpDOTJEczNBYmlxR3F3MEFBTERXNjhJVE9Lci9BNkp3WFpxWnpTdUtK?=
 =?utf-8?B?TzNDT3pZY2ZnZ3AvVW94ZjRmbHNaWEVsc1BZREVESndOOWNpV09FQk5xNXlZ?=
 =?utf-8?B?U3cwNFdaYzFKQzBCTGlPRHdDRno5bXltU3MrTzBrR1hZRnlEQ1lJcmpoNXV5?=
 =?utf-8?B?Q3YyeW44VTVZRXpTRWJmVHdndVVCNlNRdURTRkFRVFNEYjFMN1VOOUQ1NFph?=
 =?utf-8?B?aU5mdi9icktBWU5BZWJnRk5Lb3g3d2xxTDdkb3FKMEdDOFZpbWl4TWFXaTll?=
 =?utf-8?B?Sjh2NFNaeGpGR1ZFZkhRRDJjNm9CVFlRSmJidmR3b1ovM0ZGK0VrbnNPSGZM?=
 =?utf-8?B?NGMvamVtQ1J6V001aWQyaGhHUTNHcXNtSWhTZmdhdVgyTzFVS09sTFNZY2Vi?=
 =?utf-8?Q?5znw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dcdb1d-edf8-4eb8-f1e9-08d9a2a92a99
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 11:16:10.0808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQOI2TRpNKVGy/BTvPDsfDSx/XD7JxUvmpwoHFtEPrxVJ2faL9fAiS+BDjy959gE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
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
Cc: Alexander.Deucher@amd.com, Borislav Petkov <bp@suse.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/8/2021 10:17 AM, Evan Quan wrote:
> Just bail out if the target IP block is already in the desired
> powergate/ungate state. This can avoid some duplicate settings
> which sometime may cause unexpected issues.
> 
> Change-Id: I66346c69f121df0f5ee20182451313ae4fda2d04
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Tested-by: Borislav Petkov <bp@suse.de>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h              |  7 +++++++
>   drivers/gpu/drm/amd/include/amd_shared.h         |  3 ++-
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 13 ++++++++++++-
>   drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  3 +++
>   drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c        |  3 +++
>   drivers/gpu/drm/amd/pm/powerplay/si_dpm.c        |  3 +++
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        |  3 +++
>   7 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b85b67a88a3d..19fa21ad8a44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -767,9 +767,16 @@ enum amd_hw_ip_block_type {
>   #define HW_ID_MAX		300
>   #define IP_VERSION(mj, mn, rv) (((mj) << 16) | ((mn) << 8) | (rv))
>   
> +enum amd_ip_powergate_state {
> +	POWERGATE_STATE_INITIAL,
> +	POWERGATE_STATE_GATE,
> +	POWERGATE_STATE_UNGATE,
> +};
> +

To reflect the current state, they could be named like 
POWERGATE_STATE_UNKNOWN/ON/OFF.


>   struct amd_powerplay {
>   	void *pp_handle;
>   	const struct amd_pm_funcs *pp_funcs;
> +	atomic_t pg_state[AMD_IP_BLOCK_TYPE_NUM];

Maybe add another field in amdgpu_ip_block_status? Downside is it won't 
reflect the PG state achieved through paths other than PMFW control and 
ipblock needs to be queried through amdgpu_device_ip_get_ip_block()

Thanks,
Lijo

>   };
>   
>   /* polaris10 kickers */
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index f1a46d16f7ea..4b9e68a79f06 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -98,7 +98,8 @@ enum amd_ip_block_type {
>   	AMD_IP_BLOCK_TYPE_ACP,
>   	AMD_IP_BLOCK_TYPE_VCN,
>   	AMD_IP_BLOCK_TYPE_MES,
> -	AMD_IP_BLOCK_TYPE_JPEG
> +	AMD_IP_BLOCK_TYPE_JPEG,
> +	AMD_IP_BLOCK_TYPE_NUM,
>   };
>   
>   enum amd_clockgating_state {
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 03581d5b1836..a6b337b6f4a9 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -927,6 +927,14 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
>   {
>   	int ret = 0;
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	enum amd_ip_powergate_state pg_state =
> +		gate ? POWERGATE_STATE_GATE : POWERGATE_STATE_UNGATE;
> +
> +	if (atomic_read(&adev->powerplay.pg_state[block_type]) == pg_state) {
> +		dev_dbg(adev->dev, "IP block%d already in the target %s state!",
> +				block_type, gate ? "gate" : "ungate");
> +		return 0;
> +	}
>   
>   	switch (block_type) {
>   	case AMD_IP_BLOCK_TYPE_UVD:
> @@ -976,9 +984,12 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
>   		}
>   		break;
>   	default:
> -		break;
> +		return -EINVAL;
>   	}
>   
> +	if (!ret)
> +		atomic_set(&adev->powerplay.pg_state[block_type], pg_state);
> +
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index bba7479f6265..8d8a7cf615eb 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -38,6 +38,7 @@ static const struct amd_pm_funcs pp_dpm_funcs;
>   static int amd_powerplay_create(struct amdgpu_device *adev)
>   {
>   	struct pp_hwmgr *hwmgr;
> +	int i;
>   
>   	if (adev == NULL)
>   		return -EINVAL;
> @@ -57,6 +58,8 @@ static int amd_powerplay_create(struct amdgpu_device *adev)
>   	hwmgr->display_config = &adev->pm.pm_display_cfg;
>   	adev->powerplay.pp_handle = hwmgr;
>   	adev->powerplay.pp_funcs = &pp_dpm_funcs;
> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
> +		atomic_set(&adev->powerplay.pg_state[i], POWERGATE_STATE_INITIAL);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> index bcae42cef374..f84f56552fd0 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> @@ -2965,9 +2965,12 @@ static int kv_dpm_get_temp(void *handle)
>   static int kv_dpm_early_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	int i;
>   
>   	adev->powerplay.pp_funcs = &kv_dpm_funcs;
>   	adev->powerplay.pp_handle = adev;
> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
> +		atomic_set(&adev->powerplay.pg_state[i], POWERGATE_STATE_INITIAL);
>   	kv_dpm_set_irq_funcs(adev);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> index 81f82aa05ec2..f1eb22c9bb59 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> @@ -7916,9 +7916,12 @@ static int si_dpm_early_init(void *handle)
>   {
>   
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	int i;
>   
>   	adev->powerplay.pp_funcs = &si_dpm_funcs;
>   	adev->powerplay.pp_handle = adev;
> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
> +		atomic_set(&adev->powerplay.pg_state[i], POWERGATE_STATE_INITIAL);
>   	si_dpm_set_irq_funcs(adev);
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 01168b8955bf..fdc25bae8237 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -627,6 +627,7 @@ static int smu_early_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	struct smu_context *smu = &adev->smu;
> +	int i;
>   
>   	smu->adev = adev;
>   	smu->pm_enabled = !!amdgpu_dpm;
> @@ -639,6 +640,8 @@ static int smu_early_init(void *handle)
>   
>   	adev->powerplay.pp_handle = smu;
>   	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
> +		atomic_set(&adev->powerplay.pg_state[i], POWERGATE_STATE_INITIAL);
>   
>   	return smu_set_funcs(adev);
>   }
> 
