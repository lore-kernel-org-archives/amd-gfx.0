Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFC9C6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 21:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98BAF10E572;
	Thu,  2 Mar 2023 21:38:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9698810E572
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 21:38:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7MjLo2LF1Y9IU6yAAZTsN7AioU+PQQGwVMfUD8Vn8ROWpk/LK2pWYiFnIhxFr3MMAI6djMDXtkldrm9w7br4u5O2inmFdpO+fVIc+cscGyPCW6r9cg1fRt6zR39ghbfnm6R9kuGkT0kWvYuDTzbTkW7S+jwgEN+NOZwr5Fnk6aLjcbJGvIwfdT0MwiIVtuP9QF96Q9IuGm59ibBHgb9Sj+6nIhOAVuhislxEshIngL6eQH5hpSTjElVA4Hd9hEr/srsPtV7QF9YY2biDyLIvANHFrd37MERE4R2pwpcbuRSiDhs63mpqL8sHweZjfkIjKHIOMI7ukSguNaG9hsZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HB0HTq7yVXmpB/K2phB2c7ZN/oef1S6aoOab5SoZC64=;
 b=MUDI90y9Bo5kZFYWkx/XHukXTeDj4tGL+qmR9lSa6JXEqFRn7R/JLDksQQtXoNaBhyM4OXr4WYXsANUEnMprAXGzRKOcOvlE/RqZcrdun2UwLRr08QJj/F7tnSbTO0+uklajIbjihgCyMBcc+3a5lHhXuQGMjzqQGeQxtw1gXMIkbbkrokpNuYLAgIZJvHc0MrXDvo/hcVPtYNvSii9zkJvEpZ0jvrkWGliwmgo4bkxvvDEtsqRudNcS9UiHV2bFsVhsP6l/whQ4c+xeojuFYzKeblJQLXvCZzXsxZU9LJ8tVMdQTBUp6pBe/CCCl7wOXz2m7jLuIDn6FzQA4c3Cgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB0HTq7yVXmpB/K2phB2c7ZN/oef1S6aoOab5SoZC64=;
 b=dnyqsq/HLT9QX9Ik9V9aoGbcaHmMOH1qunzg1zJBlbLsOlbYHGkfAmD4WoMMt9jEjOhGkn7txM8mioUyZCwYZg/MgGSB6hQp3KenmRL/LzKmacdO+O7VcCYjEW4M5iCm333Uj10d4/97JWOzSHIQGsvApC39+CKlJf7BEF9WaOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6973.namprd12.prod.outlook.com (2603:10b6:303:20a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 21:38:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e%4]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 21:38:10 +0000
Message-ID: <2163df8a-8e21-1a34-7f2a-7b7c875948c5@amd.com>
Date: Thu, 2 Mar 2023 16:38:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdkfd: Ratelimit oversubscription message
Content-Language: en-US
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230302194613.2659027-1-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230302194613.2659027-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ccfdeb-2d18-4a63-a643-08db1b666b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uE7IJX93npxytdS2cf+B2A4aNwA5KVE7AYkJDjNE/Pwxvz1VKwoS0UyvxQiRpxhQEAHO94T4ImSJqST4dRxrASfYwVNF4wBosOm5H+ngwKoHnDPBVkef4Uh6ry0VJuTA8qf5oZBEaZnuYeHiF3nt/6pDINldlZeJD4QGqGA3qk9XvLUjIc5V+VaULdDE9/V+rf6+r2r1rrowICfomJJ+9iiKo80xjyKua5kctwp9uwU5YZa0cZiPHTH5PK/Uq6rMvVzvve/hrrnOKQodXxYXNvK2FrSAeIGqE/NyL/f1CanMVTB20KjbbQbWuXQbQ0lHdEFvAb2euiUqqmchkcq2DyYm/Zr3TA4dfXgIR2/YSa2RAmrc9YxebUmnqBNNx3VqGPS509p65xBRs39bHla4cvs+IJ7gl4w7hgK+c6Nc1duyJzHBpxT4Lav9ldRqsdRd15tjcZVI5/YOcHZkBvIqd4uvN2Ic13i7QO3yT4CyBRXK112D+62y5zX3b/nQkasyI9lNgI5M0KoNPrIb4F4w2VNAaYvvdKpFpv7EyhP6mFyvtKN5Ne09miBeKuFwtWfM1cpB5KJT7hpfY9u2DKqE+XYsHc8bWhXxduhg8Ql9Ueff/OzrcDdUamNw0jWPtyl7L6BgcLumVcpH+7UVeko0d9Ml7zBWNb0mTEtuxbg9xBuHYHmkQdJF81hLCK5Y/6bdF9P34xZX0YIZRFho+4zCEmtR02IYypfOt4XOhrvP07c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199018)(83380400001)(31686004)(36756003)(38100700002)(478600001)(8936002)(5660300002)(66556008)(86362001)(31696002)(26005)(186003)(2616005)(6486002)(6506007)(6512007)(8676002)(66476007)(2906002)(66946007)(44832011)(15650500001)(316002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXZRL2VtYkx3cEZadTIvWXIyZkc1NXRSQUQ1OFR2UnozaXg4ZUFGcU95LzNJ?=
 =?utf-8?B?NDVBRWFsR1kzazNYdHlDOU9QNmJsQktrWXhSTVpnblMrWkxqUjZoTk9FenJY?=
 =?utf-8?B?T3pYaktwQjdQRGtjNFpQY1JEZWJ3VjBrc2VTT2FmTTJwMFMvZW5TN3kvQWFH?=
 =?utf-8?B?NWhOV1M5ZWFHN1FaaHpsdWxuZll5M3VneU40QUQrQ2ZQdjVqaHYzam80L0Fv?=
 =?utf-8?B?bkdFWHNFc2RIa3VIUHYxbis3bUk1QjlJeG8wYm1WUkVydVNPUHBSaUFtRnF0?=
 =?utf-8?B?L0I2ZHNKbkEwK3hYc0lYOGtqTFZKMFl4TWVRNjhGWnVrbUJHRmRlT1paeE1K?=
 =?utf-8?B?SllNQW5RcWFUR1p6Qkx4cFN1Rll1OHRKQ3k3R1NQS2lDNkJrSndOSEdkbk5L?=
 =?utf-8?B?dHR5TlczbCtSNWlTcUFDcU81ODRTa1hDWjc2YVVSSS93TGwvYlF2K21QL1Jj?=
 =?utf-8?B?MDZIZDgvclg0a0IvL3VFYTl2VGJtVEc0YkVyT2M0dmljVGJTZGMxbnU5cnpB?=
 =?utf-8?B?ZmJYSXBiUmZkTUIvKytCQTd5SUJ5Y09DcWJGMnA3M2prak9HUnlkTDVtT1Nm?=
 =?utf-8?B?QjdnYUxzYmhLU1hMWklIZ3NpM050ZUl5enNIS0ZqUmpQQUdJbXJKR1Z6ZTVp?=
 =?utf-8?B?ZFc0aXhVMGUzK3FqY3RudHF0NjFqWFprM2xnYVpzQWV6d3BxK3psZXR2WUxp?=
 =?utf-8?B?UWpjYzhMbXAvZG0wMEdTWkdlYmNiVVRGS1BlUGtyK0lqYk9lWDJtVVo3OHkv?=
 =?utf-8?B?WVNxalhoL2t0Slg1bTJvbDd2aklWWVdiYWpsTzhNTTlDM2w2U25jOTV4eVQw?=
 =?utf-8?B?ZFNTcVd5WTFEVEVkVjVGNmRYbGdHZEFOMGJOTFdEUGtwbXFPRnJzWTZJN2hD?=
 =?utf-8?B?RVFmaGg3eEExeXhJWEZaaUZrcWtnSWNXZGJFMG9LNlhtL1g4aHNya3dpVVR4?=
 =?utf-8?B?U1czMTNJTitsbS8xdjFoWEh0dks3aTU4Sjl4eGIxeGhYeVhjQXVPRitiSEUr?=
 =?utf-8?B?djBNNlF5SThLM3JNa3ordVp3dzU5QmFCUiszS3BRc3E4MTloaVBwanVSN1hD?=
 =?utf-8?B?dmhLaDlqRzk0dm4zYnhVVVg2QWd5YmVoN29wT1YxbXZJeFp6OGREb3ozQkw3?=
 =?utf-8?B?ZVFnVGFjaTh2cHJieVd0ZU1aYlJEZlMxYjA2YzdWblVvdTk3TlBNY3FZUWc5?=
 =?utf-8?B?eW5rUC9yYXd4QmhyUnh5cDZyNUtLd0ZDMHh0ektVb2pYNjV5b0paVXJkc2NH?=
 =?utf-8?B?S1FwT0t3cFJVZGVITm1zM1gvQjFlbmtiekxJNlVHa1Q2Wko3SWJySGMyVGZQ?=
 =?utf-8?B?TFlrWU9zS2w5RCswb3BpZVpYMHM1UkN4bHk4S0FmQjBmblFMWTFGdG9lREt1?=
 =?utf-8?B?OHhLeC80MDBIRXc3QVJJY2RqTzY4bXAzYi9oQ1F2VGNSanlGbzl6SUdTSGh5?=
 =?utf-8?B?clJybDV3eGVqYTJ1YnNJaEQyWjhMRWVzZUsrcWdSb3FQSlhqVE5wd3hMRlNX?=
 =?utf-8?B?dzlkdUg3UEJHQk5oWFp5K2xiVUNtM3kxV002TnZnVFMwYWFrQlNnSWlLNVpM?=
 =?utf-8?B?ZFpjY3MzdDU3LzJ1RFlPcE4vMlkvUVNjeTNBVk9LQXp1cm5JL3V3cThBOVNy?=
 =?utf-8?B?VTgvQ3Q1YUF0QmIzMVZIS2dVY2tXbFhYbndjZkFkeWNqVzJpU1JBVzBWeC9M?=
 =?utf-8?B?VVVYVDdYUGZ3MTZUcDRLVkhibXBRRzN3RHNpam1iejY1ZlI3Tk0zVFZQaTVH?=
 =?utf-8?B?aEthdk9PcDN5L09IeU43MUozdTRBM0NnSFgyNk9NeW5meVFHVzlSWDNCVWUz?=
 =?utf-8?B?TlZCYVNOazBOeUlra1lON0RFWi9WV2wrbTVESFNZMFdPOWxnWWl1QjRpeER3?=
 =?utf-8?B?WjF0T2l3V2Y0MHFXQVAwSXMrMGFYSGJKV1kydFkxY0ZheWN5WFQ5eE42c0xN?=
 =?utf-8?B?ZFpNVlZDNGxLRS9lQkd2am1ZMm5OUzA2OFYvc0RzUFpORDVxNmFGWDMvaDU4?=
 =?utf-8?B?NVZKenAyQVpDaUpTVmI0STRpWWxLRGNwcDNBa0VndmhYRXVQd3V3dDRiY3VD?=
 =?utf-8?B?c3N0RGVZL21renQ4MktSaElDTUFpcW5EdDVRS202eUU2U2F0dWxHZjljNjlC?=
 =?utf-8?Q?wp0DDrx+dihiC9i0d4PZEu1ac?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ccfdeb-2d18-4a63-a643-08db1b666b23
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:38:10.2419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmDbVUoBi+Vlrl4HVlxFSvC3w2XewjjKWfzSqeKKguHisZmV2wJoynjZiZWy4NnKk2OqfiarvWgx3UJgCthXYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6973
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

Am 2023-03-02 um 14:46 schrieb Kent Russell:
> On certain applications, this message could end up flooding dmesg.
> Ratelimit it so that the warning is still available, but doesn't take
> over the entire log
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index ed02b6d8bf63..9eb3b5feff56 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -207,7 +207,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
>   
>   	if (is_over_subscription) {
>   		if (!pm->is_over_subscription)
> -			pr_warn("Runlist is getting oversubscribed. Expect reduced ROCm performance.\n");
> +			pr_warn_ratelimited("Runlist is getting oversubscribed. Expect reduced ROCm performance.\n");
>   		retval = pm->pmf->runlist(pm, &rl_buffer[rl_wptr],
>   					*rl_gpu_addr,
>   					alloc_size_bytes / sizeof(uint32_t),
