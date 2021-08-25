Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D9AC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 11:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723BE6113C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 11:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 723BE6113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0865A6E1E8;
	Wed, 25 Aug 2021 11:29:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E97D6E1DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 11:29:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUWlzTa4SBMjEmQOetuJOxOLMzH5n8vxky65LPmQf82+y6MvxGyNhlfB2AXVAN3MytTG40BvFV2hPn5yfoo8gfW/zrOB5cPvpz5lKVKpYMk/4qlpuHnZqNGqViKGVZmaOTnjXal9/yydSeFG+He9HhlT8BSTLACpomluWV2rdXKYgom2N9NfvhKPxf4nUcheK03IjFTI56jKWE+UxmkBjlk+bLUg1FaBZuosamWX2h8tVy864FaZ7rkKdY0BTiLiWIwqSDG7pNnSTkgJb4nZUaLTMEBy12asa9gqK0qvlAXhBAoajAv8nPfBJJ6amNS0jC+Myv0VY+/Q5B/t/UEDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNp3Suh4Nv4cG3FxHXWizMQm9OIoUBuF6+Bz7+RfBJs=;
 b=R3VOa+XKPidUZjgmJWTARt/K05wGahf6saRDsfFI4mYh40J25cNmMR/Fw2U7u9vDC+UKIJCEsb0IspzXy4QJm4LHCe8MCqIDXtOgxWTT8CRl0fqToTCzcQ2SnJ6ToLTQfszLEaCrciF5NhwMaYoJq8nJWhNEfMPZAMoDjaUwar3W0LP+YfETxKFMXAAID1v7lDd3Asi1+cfrA5GI3P7ZhM2O4XANqRhoIJZEFVEdgPyOZK8VnDK31gYlH02lJ3Ob1+dGHEgdeaxYsmYYjU0ftf5Z6tDlZgr8QpqpROB5EizD87o3mcdXA44V1vQ/yrXQoFuVnF0PUKbd60pCq32fxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNp3Suh4Nv4cG3FxHXWizMQm9OIoUBuF6+Bz7+RfBJs=;
 b=HFjgUMbkMDsc7aSW+tcwwIXdshYmxcuaMUNIOIpKUWszpLlqBQLM5s9JaPYZTi3pujWkOtzmIvKxo0PqFK+9c36cs+TKt6oQDaLvl+FXHELUzH5NaSTBL5BKUc7N53+NlhF1YqdlhKy40E/Uv457tszpjKTDC0l0WiIO+Xdl8BM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 25 Aug
 2021 11:29:45 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 11:29:44 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: rework context priority handling
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: satyajit.sahu@amd.com
References: <20210825112203.3806-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2bb20ed1-c7c2-531a-7743-1ccd1919a5d6@amd.com>
Date: Wed, 25 Aug 2021 13:29:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210825112203.3806-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM9P250CA0023.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::28) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 AM9P250CA0023.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 11:29:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70adce75-52fd-4a31-704f-08d967bba333
X-MS-TrafficTypeDiagnostic: MN2PR12MB4301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43012578CBF299DD17CBC92683C69@MN2PR12MB4301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kdOvWaFyyf65jEiMRhb1mJYEDcFjPFyJWPDKjd6uC6yZVBLT2jdApiHB2JP0MPTE6z6dHgTHYHFC0cmjYWUYKmFuyBZTI37wSrSHBgteLT39/+cL4BUSCAoU5FjNcp5pb5BHKbayWPt49WcL6fXPfgsmlyn6XrD4iFYQUI6rbMKvHz1d6WFmrtgsft9eUOUrZMkjxAg5WPlM2hRyS47tupQfbLd9LG8VjYRbxUfLwmKr5qYc5PJgb06QCAF2rBwZqRpWyFToYM/T3VzVr5Scg7FtrbcUiPSdSFeqNH7mYz8ZPzJo+FztEXDmO/u/FXhugtIDavxJpDGAx4PbqGhHpzjBg1tFcRKqT7V8JXCtlajfCwCBD+lzG5mtygTTXzflx3cmIY9Gm5QQ6EfGcX+8Yq3hZrYal2UzAUNdX6icRlrjs33AmcTXtF/5N8VrPwhc+FMy4whGpracSBECZ3lEBlYbGkLWc4R+DSm8rE+ePGyrsj0httx8JiSYjIy+JCUnV92I2iUzwjpBmEmIzgQcgA84nRv18lTp/KwpEMVuJOg76OE+Sln5WqC1oDJjRv88MYXLHVlmy4IzyqvMN8DV6ZalO9xqF+CsDpgXX9+mnQ/7wiUe76vB+2l7FplX49WDv+17qeYKEutwSGj1pfPvufrmPWZnVE8s9Bt4U/ZWON33Rje33JVUZw8Z61FdAbBFSJduO54y6S82x13lTlFQKujwJ2Zxr9YEvGG98cdkOK7iqrutEy5W2SOQcuPwC/iT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(31686004)(4326008)(316002)(8676002)(8936002)(2616005)(16576012)(956004)(38100700002)(2906002)(30864003)(5660300002)(66946007)(66476007)(66556008)(86362001)(6486002)(478600001)(83380400001)(26005)(36756003)(6666004)(66574015)(31696002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkRTd0graHptOERDclB4WVJSSzFSUzk3WDJmU3FNTkh1SjZMVmJBalNwbDN1?=
 =?utf-8?B?c3o4Rk9ITE0yd09jMG1sbzA1aVlwdFN5RjZHaTQxdFd4R21sNzM3VlFzZ2Jy?=
 =?utf-8?B?S2x3RjhtSkZmMVJBK1dnZWVmT3BoZGYvSlIvdjMzQnhjZmx6azY4RWZPeDc5?=
 =?utf-8?B?cWN5TkZlMnhZZkZ0dzVNL09wMVVNaGRyNXZrbHdtbjl6K3JIc1BBZURWNmZp?=
 =?utf-8?B?V3NUSmlWbzRMWVBuclV3WS9MNU1HZWNrRFdzMGs3SkdFRXRlMmVOOCtRcVNO?=
 =?utf-8?B?dVZxSllZeVBxNnQ5RWNtaUJ2UTFxdHcrYVZZRktta2RCdm9GekpsNytOVHFz?=
 =?utf-8?B?cXV6V0pSOFFzOEFUWmtnbEtJUERkUk1FcEJXL0ZKb3JDenJRaVFrbjRwQ0Yv?=
 =?utf-8?B?SVF0OEc3d05KbzJBaXpOUEwvUjVLTzVyd0xvNCtFQzJDMTROQzlvbDloNjJL?=
 =?utf-8?B?SWJqRElneUwyaGVKd0crSXRYNDJFT0doTC9zbXp6TnlMRFp5K0R3enpLaUVh?=
 =?utf-8?B?OVE3SFlIeW0rZEM3TTJTY0hTcUNFeUhqQ1cwT0Uwa01wbkVPVlhLMkMwcUtM?=
 =?utf-8?B?dXVvNVd3RFFsbmZMSHVXQzVBSC9hdlQvTEUxZ1B6blovWXJSSmYwVFZDRzdx?=
 =?utf-8?B?RDdkZmxuTFhsaUFEZ2c3UUU1eXg2MVg1SndwZEVEVVVrYmU4dnptbXFKVytq?=
 =?utf-8?B?aWJFeG94SFh2OTVJV0FNbzFOc3NsQVY0My82YWdMK2ZHSk1uL1J0QW9qVDVX?=
 =?utf-8?B?UGphY3JjU2JiSkxKUXUwWHl2SGZaNk5vamtSTk53U3E3NUhRM21NVDB4Vjh2?=
 =?utf-8?B?dC9UQW9ydDlzTUpYMkRqbnhLWFpwTktleHFlMnJ1U015VTNkS1BNOXhmditU?=
 =?utf-8?B?SUpWZlVNdTZKYURvRjcrallHcExCYktoazI0OVNtS05PRmF5Y3kxVFc4VWRx?=
 =?utf-8?B?NzNPZUgxcXdLTlc4VThoK2RQYzE2K25BWXk2OTd5WXE0NnM2djBpamRENElk?=
 =?utf-8?B?NGZqcWdhYThFWVF6bUNvTSs0TzVJVVltZS8xaFVMVmwvcm44OXBNMmg5Z2k3?=
 =?utf-8?B?V0NkOE0zUHUyVGcvcnVUa3JvajJkR1EvekxKQW5YS3NzT2g1VEllZ014aUQy?=
 =?utf-8?B?YmNtbjZnbzVMdW1Ud1BscHRmeW9iZHpac0JEODFoS0dpejNOZER2eVBvNkhp?=
 =?utf-8?B?N1FBcVdJdWpyRi9Qdk1lNEJBMjV1M0ZwMHVuK2pMUEhSWTRwUEo4TlhUVTda?=
 =?utf-8?B?US8rNVFMUmJmVWpPTlZQUkFpdlFwK2JEaU1GREsyYzYvV1NIY1Z2cHVUNXJ3?=
 =?utf-8?B?eVJURDRNN0ttaUszTnFaczBZVTZvY3FZSktkVVI2d0hMdzlUbWZrd1lMaWJu?=
 =?utf-8?B?cmpYZ0FTcm8rTjdVTUJBVUsvcEJnUHV0K1NFM2lpVVEzdTJxWnd2R2xDNTJp?=
 =?utf-8?B?RnpOdkZsNFgvTWEyM2ZRQU5iT1VpVVZ5WVpCY2R6SHdpWUZQdXNjK0NTYmla?=
 =?utf-8?B?d0VsbzdvOVE2aWpaSUpqRTd3TjhyZm01dWJFMFlzTGFYS3ovR0loZnlSekdw?=
 =?utf-8?B?UWdpYnI2bWV3d1cwSnVIMGFITW56bllWSWJwUGpjZllVMWZQMGhWWlhWaEV2?=
 =?utf-8?B?dHZ5SjlSaEtQakJqcFpyYzEwQjJwbHVUQ0dIdGhnV0hEd2RoeFEzamNHNkp5?=
 =?utf-8?B?T3NkSFV1b0RvL2wvUlExb3JIYXBITVRubzhUVkpJWXdTcVB2eDhvaDZ1L1c4?=
 =?utf-8?Q?92yqWNs9YKcT++ELYeEc/P8EVogE7FNnXGTepnZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70adce75-52fd-4a31-704f-08d967bba333
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 11:29:44.6187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkUng7GcbfBFtrBxrZPPn1Do6mIYK2jlzWCyII/2K/OxuVp/GRPcLOMXdQ/koZdv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
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



Am 25.08.21 um 13:22 schrieb Nirmoy Das:
> To get a hardware queue priority for a context, we are currently
> mapping AMDGPU_CTX_PRIORITY_* to DRM_SCHED_PRIORITY_* and then
> to hardware queue priority, which is not the right way to do that
> as DRM_SCHED_PRIORITY_* is software scheduler's priority and it is
> independent from a hardware queue priority.
>
> Use userspace provided context priority, AMDGPU_CTX_PRIORITY_* to
> map a context to proper hardware queue priority.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 127 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h   |   8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |  44 ++------
>   3 files changed, 105 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index e7a010b7ca1f..c88c5c6c54a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -43,14 +43,61 @@ const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
>   	[AMDGPU_HW_IP_VCN_JPEG]	=	1,
>   };
>   
> +bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio)
> +{
> +	switch (ctx_prio) {
> +	case AMDGPU_CTX_PRIORITY_UNSET:
> +	case AMDGPU_CTX_PRIORITY_VERY_LOW:
> +	case AMDGPU_CTX_PRIORITY_LOW:
> +	case AMDGPU_CTX_PRIORITY_NORMAL:
> +	case AMDGPU_CTX_PRIORITY_HIGH:
> +	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static enum drm_sched_priority
> +amdgpu_ctx_to_drm_sched_prio(int32_t ctx_prio)
> +{
> +	switch (ctx_prio) {
> +	case AMDGPU_CTX_PRIORITY_UNSET:
> +		return DRM_SCHED_PRIORITY_UNSET;
> +
> +	case AMDGPU_CTX_PRIORITY_VERY_LOW:
> +		return DRM_SCHED_PRIORITY_MIN;
> +
> +	case AMDGPU_CTX_PRIORITY_LOW:
> +		return DRM_SCHED_PRIORITY_MIN;
> +
> +	case AMDGPU_CTX_PRIORITY_NORMAL:
> +		return DRM_SCHED_PRIORITY_NORMAL;
> +
> +	case AMDGPU_CTX_PRIORITY_HIGH:
> +		return DRM_SCHED_PRIORITY_HIGH;
> +
> +	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
> +		return DRM_SCHED_PRIORITY_HIGH;
> +
> +	/* This should not happen as we sanitized userspace provided priority
> +	 * already, WARN if this happens.
> +	 */
> +	default:
> +		WARN(1, "Invalid context priority %d\n", ctx_prio);
> +		return DRM_SCHED_PRIORITY_NORMAL;
> +	}
> +
> +}
> +
>   static int amdgpu_ctx_priority_permit(struct drm_file *filp,
> -				      enum drm_sched_priority priority)
> +				      int32_t priority)
>   {
> -	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_COUNT)
> +	if (!amdgpu_ctx_priority_is_valid(priority))
>   		return -EINVAL;
>   
>   	/* NORMAL and below are accessible by everyone */
> -	if (priority <= DRM_SCHED_PRIORITY_NORMAL)
> +	if (priority <= AMDGPU_CTX_PRIORITY_NORMAL)
>   		return 0;
>   
>   	if (capable(CAP_SYS_NICE))
> @@ -62,26 +109,35 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>   	return -EACCES;
>   }
>   
> -static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sched_priority prio)
> +static enum gfx_pipe_priority amdgpu_ctx_prio_to_compute_prio(int32_t prio)
>   {
>   	switch (prio) {
> -	case DRM_SCHED_PRIORITY_HIGH:
> -	case DRM_SCHED_PRIORITY_KERNEL:
> +	case AMDGPU_CTX_PRIORITY_HIGH:
> +	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>   		return AMDGPU_GFX_PIPE_PRIO_HIGH;
>   	default:
>   		return AMDGPU_GFX_PIPE_PRIO_NORMAL;
>   	}
>   }
>   
> -static unsigned int amdgpu_ctx_prio_sched_to_hw(struct amdgpu_device *adev,
> -						 enum drm_sched_priority prio,
> -						 u32 hw_ip)
> +static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
>   {
> +	struct amdgpu_device *adev = ctx->adev;
> +	int32_t ctx_prio;
>   	unsigned int hw_prio;
>   
> -	hw_prio = (hw_ip == AMDGPU_HW_IP_COMPUTE) ?
> -			amdgpu_ctx_sched_prio_to_compute_prio(prio) :
> -			AMDGPU_RING_PRIO_DEFAULT;
> +	ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
> +			ctx->init_priority : ctx->override_priority;
> +
> +	switch (hw_ip) {
> +	case AMDGPU_HW_IP_COMPUTE:
> +		hw_prio = amdgpu_ctx_prio_to_compute_prio(ctx_prio);
> +		break;
> +	default:
> +		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
> +		break;
> +	}
> +
>   	hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
>   	if (adev->gpu_sched[hw_ip][hw_prio].num_scheds == 0)
>   		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
> @@ -89,15 +145,17 @@ static unsigned int amdgpu_ctx_prio_sched_to_hw(struct amdgpu_device *adev,
>   	return hw_prio;
>   }
>   
> +
>   static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
> -				   const u32 ring)
> +				  const u32 ring)
>   {
>   	struct amdgpu_device *adev = ctx->adev;
>   	struct amdgpu_ctx_entity *entity;
>   	struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
>   	unsigned num_scheds = 0;
> +	int32_t ctx_prio;
>   	unsigned int hw_prio;
> -	enum drm_sched_priority priority;
> +	enum drm_sched_priority drm_prio;
>   	int r;
>   
>   	entity = kzalloc(struct_size(entity, fences, amdgpu_sched_jobs),
> @@ -105,10 +163,11 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   	if (!entity)
>   		return  -ENOMEM;
>   
> +	ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
> +			ctx->init_priority : ctx->override_priority;
>   	entity->sequence = 1;
> -	priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
> -				ctx->init_priority : ctx->override_priority;
> -	hw_prio = amdgpu_ctx_prio_sched_to_hw(adev, priority, hw_ip);
> +	hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
> +	drm_prio = amdgpu_ctx_to_drm_sched_prio(ctx_prio);
>   
>   	hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
>   	scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
> @@ -124,7 +183,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   		num_scheds = 1;
>   	}
>   
> -	r = drm_sched_entity_init(&entity->entity, priority, scheds, num_scheds,
> +	r = drm_sched_entity_init(&entity->entity, drm_prio, scheds, num_scheds,
>   				  &ctx->guilty);
>   	if (r)
>   		goto error_free_entity;
> @@ -139,7 +198,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   }
>   
>   static int amdgpu_ctx_init(struct amdgpu_device *adev,
> -			   enum drm_sched_priority priority,
> +			   int32_t priority,
>   			   struct drm_file *filp,
>   			   struct amdgpu_ctx *ctx)
>   {
> @@ -161,7 +220,7 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>   	ctx->reset_counter_query = ctx->reset_counter;
>   	ctx->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
>   	ctx->init_priority = priority;
> -	ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;
> +	ctx->override_priority = AMDGPU_CTX_PRIORITY_UNSET;
>   
>   	return 0;
>   }
> @@ -234,7 +293,7 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
>   static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>   			    struct amdgpu_fpriv *fpriv,
>   			    struct drm_file *filp,
> -			    enum drm_sched_priority priority,
> +			    int32_t priority,
>   			    uint32_t *id)
>   {
>   	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
> @@ -397,19 +456,19 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
>   {
>   	int r;
>   	uint32_t id;
> -	enum drm_sched_priority priority;
> +	int32_t priority;
>   
>   	union drm_amdgpu_ctx *args = data;
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>   
>   	id = args->in.ctx_id;
> -	r = amdgpu_to_sched_priority(args->in.priority, &priority);
> +	priority = args->in.priority;
>   
>   	/* For backwards compatibility reasons, we need to accept
>   	 * ioctls with garbage in the priority field */
> -	if (r == -EINVAL)
> -		priority = DRM_SCHED_PRIORITY_NORMAL;
> +	if (!amdgpu_ctx_priority_is_valid(priority))
> +		priority = AMDGPU_CTX_PRIORITY_NORMAL;
>   
>   	switch (args->in.op) {
>   	case AMDGPU_CTX_OP_ALLOC_CTX:
> @@ -515,9 +574,9 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>   }
>   
>   static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
> -					    struct amdgpu_ctx_entity *aentity,
> -					    int hw_ip,
> -					    enum drm_sched_priority priority)
> +					   struct amdgpu_ctx_entity *aentity,
> +					   int hw_ip,
> +					   int32_t priority)
>   {
>   	struct amdgpu_device *adev = ctx->adev;
>   	unsigned int hw_prio;
> @@ -525,12 +584,12 @@ static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>   	unsigned num_scheds;
>   
>   	/* set sw priority */
> -	drm_sched_entity_set_priority(&aentity->entity, priority);
> +	drm_sched_entity_set_priority(&aentity->entity,
> +				      amdgpu_ctx_to_drm_sched_prio(priority));
>   
>   	/* set hw priority */
>   	if (hw_ip == AMDGPU_HW_IP_COMPUTE) {
> -		hw_prio = amdgpu_ctx_prio_sched_to_hw(adev, priority,
> -						      AMDGPU_HW_IP_COMPUTE);
> +		hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
>   		hw_prio = array_index_nospec(hw_prio, AMDGPU_RING_PRIO_MAX);
>   		scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
>   		num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
> @@ -540,14 +599,14 @@ static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>   }
>   
>   void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
> -				  enum drm_sched_priority priority)
> +				  int32_t priority)
>   {
> -	enum drm_sched_priority ctx_prio;
> +	int32_t ctx_prio;
>   	unsigned i, j;
>   
>   	ctx->override_priority = priority;
>   
> -	ctx_prio = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
> +	ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
>   			ctx->init_priority : ctx->override_priority;
>   	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>   		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 14db16bc3322..a44b8b8ed39c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -47,8 +47,8 @@ struct amdgpu_ctx {
>   	spinlock_t			ring_lock;
>   	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM][AMDGPU_MAX_ENTITY_NUM];
>   	bool				preamble_presented;
> -	enum drm_sched_priority		init_priority;
> -	enum drm_sched_priority		override_priority;
> +	int32_t				init_priority;
> +	int32_t				override_priority;
>   	struct mutex			lock;
>   	atomic_t			guilty;
>   	unsigned long			ras_counter_ce;
> @@ -75,8 +75,8 @@ void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
>   struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>   				       struct drm_sched_entity *entity,
>   				       uint64_t seq);
> -void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
> -				  enum drm_sched_priority priority);
> +bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio);
> +void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx, int32_t ctx_prio);
>   
>   int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
>   		     struct drm_file *filp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> index b7d861ed5284..e9b45089a28a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> @@ -32,37 +32,9 @@
>   #include "amdgpu_sched.h"
>   #include "amdgpu_vm.h"
>   
> -int amdgpu_to_sched_priority(int amdgpu_priority,
> -			     enum drm_sched_priority *prio)
> -{
> -	switch (amdgpu_priority) {
> -	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
> -		*prio = DRM_SCHED_PRIORITY_HIGH;
> -		break;
> -	case AMDGPU_CTX_PRIORITY_HIGH:
> -		*prio = DRM_SCHED_PRIORITY_HIGH;
> -		break;
> -	case AMDGPU_CTX_PRIORITY_NORMAL:
> -		*prio = DRM_SCHED_PRIORITY_NORMAL;
> -		break;
> -	case AMDGPU_CTX_PRIORITY_LOW:
> -	case AMDGPU_CTX_PRIORITY_VERY_LOW:
> -		*prio = DRM_SCHED_PRIORITY_MIN;
> -		break;
> -	case AMDGPU_CTX_PRIORITY_UNSET:
> -		*prio = DRM_SCHED_PRIORITY_UNSET;
> -		break;
> -	default:
> -		WARN(1, "Invalid context priority %d\n", amdgpu_priority);
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>   static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
>   						  int fd,
> -						  enum drm_sched_priority priority)
> +						  int32_t priority)
>   {
>   	struct fd f = fdget(fd);
>   	struct amdgpu_fpriv *fpriv;
> @@ -89,7 +61,7 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
>   static int amdgpu_sched_context_priority_override(struct amdgpu_device *adev,
>   						  int fd,
>   						  unsigned ctx_id,
> -						  enum drm_sched_priority priority)
> +						  int32_t priority)
>   {
>   	struct fd f = fdget(fd);
>   	struct amdgpu_fpriv *fpriv;
> @@ -124,7 +96,6 @@ int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
>   {
>   	union drm_amdgpu_sched *args = data;
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> -	enum drm_sched_priority priority;
>   	int r;
>   
>   	/* First check the op, then the op's argument.
> @@ -138,21 +109,22 @@ int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
>   		return -EINVAL;
>   	}
>   
> -	r = amdgpu_to_sched_priority(args->in.priority, &priority);
> -	if (r)
> -		return r;
> +	if (!amdgpu_ctx_priority_is_valid(args->in.priority)) {
> +		WARN(1, "Invalid context priority %d\n", args->in.priority);
> +		return -EINVAL;
> +	}
>   
>   	switch (args->in.op) {
>   	case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
>   		r = amdgpu_sched_process_priority_override(adev,
>   							   args->in.fd,
> -							   priority);
> +							   args->in.priority);
>   		break;
>   	case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
>   		r = amdgpu_sched_context_priority_override(adev,
>   							   args->in.fd,
>   							   args->in.ctx_id,
> -							   priority);
> +							   args->in.priority);
>   		break;
>   	default:
>   		/* Impossible.

