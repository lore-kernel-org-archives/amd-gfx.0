Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B527FC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 08:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6138A6103A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 08:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6138A6103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E71BC6E558;
	Thu, 26 Aug 2021 08:38:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 835FC6E558
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 08:38:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhkEyUw9gL7E7reTSFEjtLRa1eNWbbt7FfkSItSUPxipfopBCyFw4lY+1xS/Wi2YpIeOioft5El7pchT9xNPwLk7t2RXdFwI0tF/1pFOn/2kFedkrkHgQ8zdpvmyiSAZHG66jPUGAQo+chSxpVXcBvcRhv5COgjATdd8OI20NAYicw2wT104O3anWKloGOi13uEzvfJoyCGVljUZEmqUKeDYBCk5rz+NrNJSqoETVAjiUSRMMz516i2vt8m4AkTsqMA3AJJyWxiihs03poNETJoowMNo9xq0SdF2P07pGqEDVSD+HObVro5uhEIQf09+WtHxEuPCrN+x4YOX+YcwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MBnKS/s2+ZnxLzz2O/H6dSuM8lenGbh3Oj9sx5sI5s=;
 b=LKyI/7bbB0eaB8uElNtLkHZYq5Z7wNz/SZU4oL/7Ov9fT+pC6XOL7XNn3dladLPeqresCVZ1gEAZLnAi18n54kcswQBExp9qTJbclVFhz+e2cDZYGTglDuggmNpFguGGul9sCb7QBNcIfCqPRZFXodTZjNPB7g8TngX+Sat7LnLY5Ji6TLQt97RdUcVJlC2YcAgWyLqh5OUVI2iHc3yq7PgZpGD3GPhFK+12Lnj4cg6P8HvMsCRRGZ8e30rsVUecBfjvFinAHmuDCxhhDPXIojlJDBB5VzL3/Jzhlir0sUhZfiW3Zf66ud8QlH5yhUk/htlNeNGxVr6xakxIWrqYFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MBnKS/s2+ZnxLzz2O/H6dSuM8lenGbh3Oj9sx5sI5s=;
 b=yMgfgHT5zEvqy1nvGUD/07EhFH5/ao2j8W/NYG4Vmju+CjYIwyZjm6yvBfNnFJvVtCRy7wtTQipDNCFcQDGSHdkplS5oW8pO4EG2/YcOvTjmEd0J9HN1P+0iLQcf5/MgVIsEeVRof5ovEv/OuBvVTtJ+CU0lTV+KkmRcpKKg5l0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Thu, 26 Aug
 2021 08:22:40 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 08:22:40 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu:schedule vce/vcn encode based on priority
To: Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, shashank.sharma@amd.com,
 nirmoy.das@amd.com
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
 <20210826071307.136010-5-satyajit.sahu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <fd989790-d7d1-a0ae-99d3-075f4c0314a9@amd.com>
Date: Thu, 26 Aug 2021 10:22:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210826071307.136010-5-satyajit.sahu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0193.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::13) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:1fe2:dd0d:124d:d9ff]
 (2a02:908:1252:fb60:1fe2:dd0d:124d:d9ff) by
 PR0P264CA0193.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.19 via Frontend Transport; Thu, 26 Aug 2021 08:22:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c968c84-70d2-4bea-3d33-08d9686aab8f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4111:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41114C53A42AE70CF8F18C1D83C79@MN2PR12MB4111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46Jyz3+s17KPG+8tguedFl1s72ZkHWO+x3QYpLOHmBpKkymvwKP2sGTe352hZ8U9l5cCeWXnliIpULmd/JOI7no7QVzOIhBGbHqTauG4YewflR+lT/5vANW4UK28Et8wZl3ALtKzoESwv9RMXHLCkFl4P4jZ/7ebd/wptHVG8evc4p9cY5R/TTU8EkOWQOWrW0NH/Yj2TAgxnqOLws0gMVy12pVwdn0pwgmQKUSU5w5QXMnHT6M9J1OIKi9C8G6BD3WTugysLf3jmeYtzEAqcDx2fyGkiYgiR4wQDMn0zcvXu2O9Tu9/wAZkFxoilidNUm8sbr4owoxDndbkpEib1L2JUmbi36SoU8hOrTLcuGyk9VUNfvh1iURjGyoM5vlRmDuqjmlFni8GKvvJyoIFQqlnHqZ7BcCa2XA/TwMeVJWz+una5ljrDzTVEaIuRJjcX42DVUXlPqNpFXopvm//ZN9J8Yg13oBcQTHcCQnDZt8HFDniTKVh19WL/Tgrc7Ey/9gvsqMixUAcqYXYcL8JOb4GyHCCuPLFuXakoF0IdK2UB7YEmbtCPcUebwnEyMFrEvj3R2js1I5Q260Zc/oR1nSoa9jOY865H/RyERiim7yagzFjzUvOPSPSfu/ezhnyYXlHg0pJDCCCX6TBrEnIRuOP8/w7YeiVoWcO0hhbBR3awjOV/Ho8Y5oqaSJgekO8+pnpVZ4Dl1a5nGgjY+unfnz6fq+vOHlDtgnie4gaUnQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(66946007)(38100700002)(6486002)(186003)(2616005)(66476007)(478600001)(66556008)(5660300002)(31686004)(6666004)(4326008)(36756003)(86362001)(8936002)(2906002)(31696002)(316002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlJBWi9OdlJGT09qTXFTYUN5KzhvMU1zYnczR1ZxNVI1WDJ0S2RkQlUwUEh1?=
 =?utf-8?B?bjFYRFo1RjNwZ2NRUkVucHlLOEM2VHNVQ2twTTYzRVZ2OHZESWZRZWFUYmNx?=
 =?utf-8?B?TzZWSkMwSDBRV0ZxdVBkZ0RISXZvN2t3aW1CT2k4aEUrTkNiaExhNkNtWmsz?=
 =?utf-8?B?Zk5XWkJ2ZlNvYUQ4bVlYOFE5dWFtaWxNaklvc0hnUUgxcGo2bytySk8zWVdR?=
 =?utf-8?B?akJuTWxJbkZmQXFxMkRTMDZaaHNxa2RwU2ZnMWlaVHBiM2VzOURiZUFCS3l6?=
 =?utf-8?B?b1dJajBvL3pjNzEwVmVMd2FlN1VjcnVoZkRNaDJOUFdKUDhCUndFYXpuV0lh?=
 =?utf-8?B?ZVZYcUp6Zmdab3BDc3loNkZZTlgyd2dwa2REbUhKWUI3SzYwNUdOaUtPTHIr?=
 =?utf-8?B?eXJuZFVMRVQ4NmxYcjU1RjVKaVA0ZkMxcWdwY3A4MXpyRHhRdk5PbXNyWnB1?=
 =?utf-8?B?Yk5RdTkvR1cyaEg2elQ1TFNUdFZ4cjd4RnlHeEsrTjB2d1RjcmM4MW1CdUo4?=
 =?utf-8?B?MCthTUs5ZU5BeVcrWDZKNFd3aTdJdXFWU1MvaHNxdmJveHVDa3k1MXppZ1Zy?=
 =?utf-8?B?S1RjdHczQlA4Q1lRbEszSWd4Z2YvQ1NvQVFxZUZ4VTVxNHVVa3QxRFI3YWtX?=
 =?utf-8?B?ekl2TS9qODN2a1Z6U082QWhmT3dsaW42dGF1Z0hZVml3UGFmOUN1TkY4Z2RM?=
 =?utf-8?B?TTZ1ci96T3ZZV3R2WjJGYmIrdXBkdUNXV1RNbGx4cHNIcGVTd0xhVXBtMHdO?=
 =?utf-8?B?cTNHdmdjTk1jNzFJWTcyYWF0T0JDZWpHc2xTQXdUcUMwZ0FoSUxHajRSOWs2?=
 =?utf-8?B?Ui9DaE5PcjlZZTNLZjFTMDNOMlZ5YmRwRjNqeXpwZUN2dGc3TmRoRkRUTGlQ?=
 =?utf-8?B?enh0eFVNTVdjcGowN2xzMWJTQTBjSmhOR0pWK1loNGlSWWpuazA1WEgxMmV5?=
 =?utf-8?B?Z3M3ZjhmOGZRZ0VBWHBJSGh4TndPN1VtaEFaRXQ4MjJHSTNORERtK0FUcmNm?=
 =?utf-8?B?RWZmMjg4c01lN2pYT3BlS1IvWmlaRm1ubm1hcXJZTXdUOHFobmk3Ykh2dWNt?=
 =?utf-8?B?RWlHUWFPSVNIQUxvL1lTdHFLRU9Na1VDMHVZSVhMTnp3anNwTm4rcnpMNU9p?=
 =?utf-8?B?OXIvZlh1cS9HbGZXV05vb2k2Y0Y3Zkw4RVlpeWEvZEhPRFc1NWxISXZzOHZy?=
 =?utf-8?B?VXk0ZGt0MkdBVzQxd1pDb0h0bUxnS3FIRVlXeE1mRThhaFl5d0x2VUlsanpF?=
 =?utf-8?B?MjM4T3FkRGtzM05xL1o2VFJ2Tk84ZUtTaWJ5TzIvQkpESlV2SUlOSHZyNVFz?=
 =?utf-8?B?NHJPc25Db2VBYktudHdYbVpRdTlLMXV3WnNVWXEzQnAzNmdKdDZuUUlyT2ly?=
 =?utf-8?B?QmlBcWhGams2SHV1enJIZWM3b0Jja21LZVhaUDRMcnkwM3FwNUhIejVnWVh0?=
 =?utf-8?B?ayt0citvRlU3Y0FaQ1QrelJMUDFjaVFiQ3lHZURMUit3cFpEV2Z6bHhnNXAr?=
 =?utf-8?B?QnVZZlJzN1RzRXpOcjB1d2FRYXpGY2psT2h1NFhqM1EvdzFBZkJmcjlHR0lo?=
 =?utf-8?B?RVpYeVNYMUxXVzBYUG90NHdJQmpHc2hoWGUxT3J4SlhzOUVaWXZDcy9GaFB5?=
 =?utf-8?B?Nm4vREl3RWFZTlNqUjNXWGkrN2d4SHNmS2hQMWMxc3pFS2RSTEwveE5WWXJJ?=
 =?utf-8?B?R1JsMkZ0Tnh5U2hVNTBuT09CeFpwbXRhZHh4WWhsQ28zZ0NkSTBmdFNOZEdW?=
 =?utf-8?B?L1I0YmFnWVNzSlFudHJWeE56clVyNSt5UzA4eWUvb1pEdVNjU1VBdkx6WmpU?=
 =?utf-8?B?YjVZMXgvZUFLRFpQMVpENzBZZHM1ZVRHS1ZzcmJyd1A0QlhpOGhkRkhZd1ZW?=
 =?utf-8?Q?1Sis7B6j5hcRN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c968c84-70d2-4bea-3d33-08d9686aab8f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 08:22:40.6877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YYPEns9mwRXqf+sjWRmQEJf6076BbDVSZpsmTBlzcQbM152mmuH+f1RJDg3+7Km
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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

Am 26.08.21 um 09:13 schrieb Satyajit Sahu:
> Schedule the encode job in VCE/VCN encode ring
> based on the priority set by UMD.
>
> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>

Some nit pick comments on the other patches, but in general that set 
looks really clean now.

Reviewed-by: Christian König <christian.koenig@amd.com> for this one here.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 30 +++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index c88c5c6c54a2..4e6e4b6ea471 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -120,6 +120,30 @@ static enum gfx_pipe_priority amdgpu_ctx_prio_to_compute_prio(int32_t prio)
>   	}
>   }
>   
> +static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vce_prio(int32_t prio)
> +{
> +	switch (prio) {
> +	case AMDGPU_CTX_PRIORITY_HIGH:
> +		return AMDGPU_VCE_ENC_PRIO_HIGH;
> +	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
> +		return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCE_ENC_PRIO_NORMAL;
> +	}
> +}
> +
> +static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vcn_prio(int32_t prio)
> +{
> +	switch (prio) {
> +	case AMDGPU_CTX_PRIORITY_HIGH:
> +		return AMDGPU_VCN_ENC_PRIO_HIGH;
> +	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
> +		return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCN_ENC_PRIO_NORMAL;
> +	}
> +}
> +
>   static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
>   {
>   	struct amdgpu_device *adev = ctx->adev;
> @@ -133,6 +157,12 @@ static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
>   	case AMDGPU_HW_IP_COMPUTE:
>   		hw_prio = amdgpu_ctx_prio_to_compute_prio(ctx_prio);
>   		break;
> +	case AMDGPU_HW_IP_VCE:
> +		hw_prio = amdgpu_ctx_sched_prio_to_vce_prio(ctx_prio);
> +		break;
> +	case AMDGPU_HW_IP_VCN_ENC:
> +		hw_prio = amdgpu_ctx_sched_prio_to_vcn_prio(ctx_prio);
> +		break;
>   	default:
>   		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>   		break;

