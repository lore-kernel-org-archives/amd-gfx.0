Return-Path: <SRS0=7qc2=IE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F14C433DB
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 19:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D32650CC
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 19:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D32650CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 409C56E059;
	Sat,  6 Mar 2021 19:03:37 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700089.outbound.protection.outlook.com [40.107.70.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B84D6E059
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Mar 2021 19:03:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOfcqm/hT08JzJMnD1CIK/ATH6cHJaQNfbMGWt892LT7Oo5LDcviStoUmjutyk2TdIgWPYlhvRLE0K5KXMgoJbiLjlfIpUJTjvt/Apq5KU5Nob3vK1gHPOUJQU3TS4fY2iOBfCbjvULqHxgqyC52ZH1fd6Ak9WC1BaLkPga5710ez3wMmo2tyD3G8ogXDNsr2clSjU0eEXtVtT5dbHZ4fppeZLo5iPTbxGvEVWyxTcycwk5q4TyO5auP0CfTKwbtJAuj+rb698PQBETTeQcSkcFLl+Qn4I3ZxDW1k1F05mB2p8aZV8/pGplZPvoQ+T+hVJ7k8ZK6dQvpYLOemEwiqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56vzP7WL82TM/AesURumqZ+vCsoWsCL/6cltxA8LBS0=;
 b=Z4ux7pLXOVSgGc42t/6Y8xMlf0JtoBOax/awLxkj97ZErfqv/BXgatu5NtGx+rg/2j9ST9L46olfw8LQEISVnrDf2e7JOE5sY3V+sMbgrGUrpzzqEjJV0gO/6W7raBmVoqva/so+0YKnDsL7rlE1xC8RiPbbns+mGk6JUNMXcR3KIMeaO56QBybsiIqQCK6FkElzu76TBt7e/cl05cAyE6kCCqSLmEawFLufCWNVDzFCrPSIfA0+Z5xUDvwkkI5ER04nuLtQGBidCTcTxI8QpBmKQMDIT8ALwpSTG1YB3e5uwsWrTVGTUerFXRyx9LpwCQZ76IP++fNaoJDuOPECUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56vzP7WL82TM/AesURumqZ+vCsoWsCL/6cltxA8LBS0=;
 b=XkfO2uUbaFW0qEsl3rvg9jjaDlwNGn1v12YTe3Za08LplR3+Ks9KjlNYrd+e4X9VcLy0Og0rcckXbRY3vCold9kk41A4SJjBdleZ9diui8bem4iQ47kl+imCHsJIVHYPj7rTKtw4FjxrclarLe8Maox/AS/OPKcRvRdTF1Bt0yk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4535.namprd12.prod.outlook.com (2603:10b6:208:267::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Sat, 6 Mar
 2021 19:03:28 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.023; Sat, 6 Mar 2021
 19:03:27 +0000
Subject: Re: [PATCH v2] drm/amd/amdgpu implement tdr advanced mode
To: Jack Zhang <Jack.Zhang1@amd.com>, amd-gfx@lists.freedesktop.org,
 Andrey.Grodzovsky@amd.com, Monk.Liu@amd.com, Emily.Deng@amd.com
References: <20210306172507.202243-1-Jack.Zhang1@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9cea258e-1220-635e-1133-7dc1eae397b0@amd.com>
Date: Sat, 6 Mar 2021 20:03:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210306172507.202243-1-Jack.Zhang1@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:e39a:d922:7fb6:1e47]
X-ClientProxiedBy: AM3PR05CA0095.eurprd05.prod.outlook.com
 (2603:10a6:207:1::21) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:e39a:d922:7fb6:1e47]
 (2a02:908:1252:fb60:e39a:d922:7fb6:1e47) by
 AM3PR05CA0095.eurprd05.prod.outlook.com (2603:10a6:207:1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Sat, 6 Mar 2021 19:03:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6fd2a24c-eeb5-48ff-cf8c-08d8e0d28656
X-MS-TrafficTypeDiagnostic: MN2PR12MB4535:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4535236EEBE591B624E53D3B83959@MN2PR12MB4535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbMe8ylPPmNu3Pz8Tp473YFvn+7/lJKOWqlHkFDb1M1YZxfr8lQl88RJXNb55Rurjb4QkHSy10RLKBzI+7AMf9pgBCPevwpH4rgdd6fYs3vQluJdGw9wCSCgDMrIKcMYDXlfanCkGaR1pvp0LivHph9zDDA5269jmA1/zuCA87g08iN6k5RmYXaW31N2wUO3d59JEmGbaik2TCF6efFGx5zipBD/D7MOA/BBENsRzIZI7NmsqIfMhMwN9EFnfMoXnNjDkb1YR74d851ldr9G6EI8tHeQDsstqf+Kyxbw+Krl5gRuyqQ8XTnRmwEdqh5R6Ni70oD6rczYyaVQJ9Q1hbUtdyh+4Jcw3aakbxNlw0EkGjVIPsbYRExAW/9l8IXpmbYI7HPLDfsGNGblzfA79yTrwqGBtsQSE8eBHK1M0A27KV2aGDvxaOB5ZmWZRytylMD5NNgpyEWnjo8w4oDz0Nq3ESv+XXpbLtgm1FTir05TQP+/yEeDL8h3wxoDiD7gW7E+Ow9CNLFJER3BqIkYYxtc6tLA27rDzYEjrJN9yR5H1P6AgQos93lKEPgRCCwCTR/kmELLpuTQOFpXosshXtOuzZOGBkU4szPa0Lwb1Dg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(2906002)(478600001)(16526019)(6666004)(186003)(5660300002)(83380400001)(30864003)(52116002)(36756003)(2616005)(31696002)(66476007)(8936002)(6636002)(66946007)(86362001)(66556008)(31686004)(6486002)(8676002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Tk1Sd1h2OXl0aEhUNFZUdU4zR2VRdDJtUVhMQndwQ1JrYmlFZllQcDZHUUgv?=
 =?utf-8?B?eXFUTGZTUFB4bWF3Y1VIRkx6NUNzd1greDVmOEJDWTVoQ21UZmQrWmRFYkpk?=
 =?utf-8?B?bEtMeEE2VlhWaFJ2OG9UWUJRNmlpNVQxYmZZTnROWUphS2JYdVhaRG1EaWZa?=
 =?utf-8?B?MlpVY1E2OUtsaWVDcC81dWFlcEg0Y1hzbXA3QXV6OU1JejFUVlFsWTRLN2dL?=
 =?utf-8?B?TUxjaE1zRzYxNGFxUktJRkQ4SmVoVitwcUdjL0tHRTNGeGVWMmExYUljMmJM?=
 =?utf-8?B?VUdXRXkvTlJvUnQ0akcxbmdqUCtuZ0gvNytWM3Mzckt6b3JYamhvbThuUE9S?=
 =?utf-8?B?NU9IcmVpVWQ5QWZ1WThOSW9BQi9aNzNlemVYU3lyMFZncWFTWTJ6bnJDaXkx?=
 =?utf-8?B?QlIrQVdFUFJleGJnaGV5eU1hTGZoZVhaU09SV0ZDcVRiWExzT21lUEJBZmlR?=
 =?utf-8?B?NWljMndLUlJ5REMwTi9TMDAvWDVpYk92KzdYaVFlTmw5STdvRkdFQVF6VjhD?=
 =?utf-8?B?djluTjg0TVB0dS9DdkFLcVNONXhxUE1MN2FodjNLZlpvdGJON0IxT1ZsNy84?=
 =?utf-8?B?emxSNFVvR2p6K3NiL1JpaURjT2hEbis0ZXJmSDUzMXBFbTFPaGJtZTExaDRx?=
 =?utf-8?B?OEFZNzkwMFZyelUyMVRyZnBDZUJSc0tvQmpiNytBaCtaeEhpcXo0TUc4a3Ew?=
 =?utf-8?B?WEI4ZWxOamZON2phWUtTMkU1ZFNja0E2YlM4dWhXTCtySlpJWUgwYkdMWmpB?=
 =?utf-8?B?VjkrWGJPTUdPUjd1Tld2Qkh1Q0hyNGZtTXk1aFcycWJ1VUhaK2MzMW82bEpv?=
 =?utf-8?B?Q3NyMndZU3JhcjRKQ2RPbHFPOXB6elV0Qm4rZFRHbTJwTDZKU3VDRy9RMnRG?=
 =?utf-8?B?MXo0Mk5HZ21WMGpHS2dCUG40L2N2SFhPRXd0MHBYN3ZFbURzSjRGYXBHKzJO?=
 =?utf-8?B?YVl6MVdweTVaU2ZNOUMrbTVqTUdKNXk5SERXWCtTZWUvakxvam02L1prTWJk?=
 =?utf-8?B?cndweGxkdGh4M0JuT29xZ3Y2NDZtSW1XU0QxMFlVd0pmK0xHMWRBYXhlN2xy?=
 =?utf-8?B?QzZKNWxvUDZZY1ZuVnhlZzl3S21TbnY1Qit0VmVsZ1ZabWlNZytPYVFlaEI1?=
 =?utf-8?B?TE8za21DTzNZZ3pvNnkxK01TSWV5MTlMcGhxamluRzNRY1lvNUhrMmJEc0NB?=
 =?utf-8?B?L2ZKMTdzRGlyT2dmVWt3Zzk5Nm96dHl6OW5Gdi94M0hURi9xY3dxdE9pbTha?=
 =?utf-8?B?Q2JUL1BWQnJzS09ra2FqOE4yWmE4RkpFYXNjMEdiQzNTZ3lUSFRlZW1Wd1Js?=
 =?utf-8?B?OWpzTXovdjEvTXBhQzFsR2xiSHd0N250ekV2RGpCOGxpUDVnZVlpMnY4T3Uv?=
 =?utf-8?B?OEQzaTNEbzRPS3Z5Unl5SmxZbEt2Y2hLeHNSV3loOFpiakRMN1VONThWR0NO?=
 =?utf-8?B?TW1CdFJ1YmhnZGtNa040RTExWkhkaHNxYjY0QXJ0WkFIQXIrdVpzbTJYT1I4?=
 =?utf-8?B?cmdoTFhGMDc1dDJlSTkwNWxmSmV2aUlDeUJMMi9SZHhGVG1HVEpuYjE4Z09J?=
 =?utf-8?B?dXFCZVhFUVo1WC9hc0dSVXBSOFFZZjBQenFtSlhTUlZUakxVbmpEdnhwU0xw?=
 =?utf-8?B?bENRU3pzZnFlNGZnQ0FkT1lTK3hkbkVQWW5KbEwzd01xV3lRb3BsMDFqWDRm?=
 =?utf-8?B?RmhhWGpaNFJ1WTZZMGlubVB6akFPSWxWK1R4bzdMeitnVWg3aFVEaVlZYUVR?=
 =?utf-8?B?bS96eWw1bElMTTJTYldRNGhNdUJIemdGaW1wYnV4WWZyMmNjODFMdHBQTzBz?=
 =?utf-8?B?MnE2aElIVXFWTEhSS0t1dXhGL0Qvc0lZSUNkRE5Sb0IxQk4zQ0t2aVlYdi9p?=
 =?utf-8?Q?6c8+v3bHXSTii?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd2a24c-eeb5-48ff-cf8c-08d8e0d28656
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2021 19:03:27.7283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgaaBnYq69B9FZntuib0P8Thtyv2LS4RH9vcrsmadBYS/8IXb0pkJhdq10tHLCE9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4535
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Jack,

well first of all please completely drop the affinity group stuff from 
this patch. We should concentrate on one feature at at time.

Then the implementation is way to complicate. All you need to do is 
insert a dma_fence_wait after re-scheduling each job after a reset.

Additional to that this feature is completely AMD specific and shouldn't 
affect the common scheduler in any way.

Regards,
Christian.

Am 06.03.21 um 18:25 schrieb Jack Zhang:
> [Why]
> Previous tdr design treats the first job in job_timeout as the bad job.
> But sometimes a later bad compute job can block a good gfx job and
> cause an unexpected gfx job timeout because gfx and compute ring share
> internal GC HW mutually.
>
> [How]
> This patch implements an advanced tdr mode.It involves an additinal
> synchronous pre-resubmit step(Step0 Resubmit) before normal resubmit
> step in order to find the real bad job.
>
> 1. For Bailing TDR job, re-insert it to mirror_list, don't set it to
> guilty and leave it to be handled by the main reset thread.
>
> 2. Don't set the job to guilty in pre_asic_reset, and leave it to be
> handled by Step0 Resubmit Stage.
>
> 3. At Step0 Resubmit stage, it first resubmit jobs asynchronously,
> then it iterate each ring mirror_list, synchronously pend for each hw
> fence being signaled. If the a job's hw fence get timeout, we identify
> it as guilty and do hw reset to recover hw. After that, we would do the
> normal resubmit step to resubmit left jobs.
>
> 4. For whole gpu reset(vram lost), skip Step0 Resubmit as each job
> after vram lost was considered as bad job.
>
> 5. Involve the concept "Affinity Group".
> Doing two hw resets is not necessary when there's only one ring that
> has jobs among some hw-related rings.Thus, we involve "affinity group".
> Hw-related rings could be added into a common affinity group, such as
> gfx and compute ring. When tdr happens, we iterate all rings in
> affinity group, skip Step0 Resubmit stage if there's only one ring's
> mirror_list that has valid sched jobs.
>
> V2:
>      -fix a cherry-pick mistake for bailing TDR handling.
>
>      -do affinity_group check according to the bad job's sched rather
>       than the default "1" so that there could be multiple affinity
>       groups being pre-defined in future.
>
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 102 +++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  47 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  27 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   1 +
>   include/drm/gpu_scheduler.h                |   1 +
>   7 files changed, 173 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e247c3a2ec08..8632d7071292 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4188,6 +4188,37 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
>   	return false;
>   }
>   
> +bool amdgpu_affinity_group_has_only_or_null_working_ring(struct amdgpu_device *adev, struct drm_sched_job *s_job)
> +{
> +       int i;
> +       int working_ring_num = 0;
> +
> +	/*
> +	 * The job is considered as the real bad one
> +	 * if job's sched is not in affinity group
> +	 */
> +	if (s_job->sched.affinity_group == 0)
> +			return true;
> +
> +       for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +               struct amdgpu_ring *ring = adev->rings[i];
> +
> +               if (!ring || !ring->sched.thread)
> +                       continue;
> +
> +               /* for non-empty affinity ring, increase working_ring_num */
> +               if (ring->sched.affinity_group == s_job->sched.affinity_group) {
> +                       if (!list_empty(&ring->sched.ring_mirror_list))
> +                               working_ring_num++;
> +               }
> +       }
> +
> +       if (working_ring_num > 1) {
> +               return false;
> +       }
> +       return true;
> +}
> +
>   /**
>    * amdgpu_device_should_recover_gpu - check if we should try GPU recovery
>    *
> @@ -4310,8 +4341,10 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   		amdgpu_fence_driver_force_completion(ring);
>   	}
>   
> -	if(job)
> -		drm_sched_increase_karma(&job->base);
> +	if (amdgpu_gpu_recovery != 2) {
> +		if (job)
> +			drm_sched_increase_karma(&job->base);
> +	}
>   
>   	/* Don't suspend on bare metal if we are not going to HW reset the ASIC */
>   	if (!amdgpu_sriov_vf(adev)) {
> @@ -4639,7 +4672,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	int i, r = 0;
>   	bool need_emergency_restart = false;
>   	bool audio_suspended = false;
> -
> +	int	tmp_vram_lost_counter;
>   	/*
>   	 * Special case: RAS triggered and full reset isn't supported
>   	 */
> @@ -4690,8 +4723,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   					job ? job->base.id : -1);
>   
>   		/* even we skipped this reset, still need to set the job to guilty */
> -		if (job)
> -			drm_sched_increase_karma(&job->base);
> +		if (job) {
> +			if (amdgpu_gpu_recovery == 2) {
> +				if (&job->base) {
> +					spin_lock(&job->base.sched->job_list_lock);
> +					list_add(&job->base.node, &job->base.sched->ring_mirror_list);
> +					spin_unlock(&job->base.sched->job_list_lock);
> +				}
> +			} else
> +				drm_sched_increase_karma(&job->base);
> +		}
>   		goto skip_recovery;
>   	}
>   
> @@ -4788,6 +4829,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		}
>   	}
>   
> +	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
>   	/* Actual ASIC resets if needed.*/
>   	/* TODO Implement XGMI hive reset logic for SRIOV */
>   	if (amdgpu_sriov_vf(adev)) {
> @@ -4804,18 +4846,64 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   
>   	/* Post ASIC reset for all devs .*/
>   	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
> +		int step = 1;
>   
> +		if (amdgpu_gpu_recovery == 2) {
> +			if (amdgpu_affinity_group_has_only_or_null_working_ring(adev,&job->base)
> +				|| tmp_vram_lost_counter < atomic_read(&adev->vram_lost_counter)) {
> +				DRM_INFO("Skip Stage0 Resubmit Stage\n");
> +				/* set guilty */
> +				drm_sched_increase_karma(&job->base);
> +				step = 1;
> +			} else {
> +				DRM_INFO("Do Stage0 Resubmit Stage\n");
> +				step = 0;
> +			}
> +		}
> +
> +retry_resubmit:
>   		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   			struct amdgpu_ring *ring = tmp_adev->rings[i];
> +			int ret = 0;
> +			struct drm_sched_job *s_bad_job = NULL;
>   
>   			if (!ring || !ring->sched.thread)
>   				continue;
>   
>   			/* No point to resubmit jobs if we didn't HW reset*/
> -			if (!tmp_adev->asic_reset_res && !job_signaled)
> +			if (!tmp_adev->asic_reset_res && !job_signaled) {
> +
>   				drm_sched_resubmit_jobs(&ring->sched);
>   
> -			drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
> +				if (amdgpu_gpu_recovery == 2 && step == 0) {
> +					ret = amdgpu_wait_resubmitted_jobs_completion(&ring->sched, ring->sched.timeout, &s_bad_job);
> +					if (ret == -1) {
> +						DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n", ring->sched.name, s_bad_job->id);
> +						/* set guilty */
> +						drm_sched_increase_karma(s_bad_job);
> +
> +						/* do hw reset */
> +						if (amdgpu_sriov_vf(adev)) {
> +							amdgpu_virt_fini_data_exchange(adev);
> +							r = amdgpu_device_reset_sriov(adev, false);
> +							if (r)
> +								adev->asic_reset_res = r;
> +						} else {
> +							r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset, false);
> +							if (r && r == -EAGAIN)
> +								goto retry;
> +						}
> +
> +						/* add reset counter so that the following resubmitted job could flush vmid */
> +						atomic_inc(&tmp_adev->gpu_reset_counter);
> +						step = 1;
> +						goto retry_resubmit;
> +					}
> +				}
> +			}
> +
> +			if (step == 1)
> +				drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
>   		}
>   
>   		if (!amdgpu_device_has_dc_support(tmp_adev) && !job_signaled) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 865f924772b0..9c3f4edb7532 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -509,7 +509,7 @@ module_param_named(compute_multipipe, amdgpu_compute_multipipe, int, 0444);
>    * DOC: gpu_recovery (int)
>    * Set to enable GPU recovery mechanism (1 = enable, 0 = disable). The default is -1 (auto, disabled except SRIOV).
>    */
> -MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 = enable, 0 = disable, -1 = auto)");
> +MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (2 = advanced tdr mode, 1 = enable, 0 = disable, -1 = auto)");
>   module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 759b34799221..28cda321157a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -281,6 +281,53 @@ void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
>   	}
>   }
>   
> +int amdgpu_wait_resubmitted_jobs_completion(struct drm_gpu_scheduler *sched, long timeout, struct drm_sched_job **s_bad_job)
> +{
> +	struct drm_sched_job *s_job, *tmp;
> +	int ret = 0;
> +
> +	list_for_each_entry_safe(s_job, tmp, &sched->ring_mirror_list, node) {
> +		struct drm_sched_fence *s_fence = s_job->s_fence;
> +
> +			if (s_fence->parent == NULL) { /* fail to get a hw fence */
> +				/* process a job */
> +				atomic_dec(&sched->num_jobs);
> +				dma_fence_get(&s_fence->finished);
> +				dma_fence_signal(&s_fence->finished);
> +				dma_fence_put(&s_fence->finished);
> +
> +				/* remove node from mirror_list and free the job */
> +				spin_lock(&sched->job_list_lock);
> +				list_del_init(&s_job->node);
> +				spin_unlock(&sched->job_list_lock);
> +				sched->ops->free_job(s_job);
> +				continue;
> +			}
> +
> +			ret = dma_fence_wait_timeout(s_fence->parent, false, timeout);
> +
> +			if (ret > 0) { /* succeed */
> +				/* process a job */
> +				atomic_dec(&sched->num_jobs);
> +				dma_fence_get(&s_fence->finished);
> +				dma_fence_signal(&s_fence->finished);
> +				dma_fence_put(&s_fence->finished);
> +
> +				/* remove node from mirror_list and free the job */
> +				spin_lock(&sched->job_list_lock);
> +				list_del_init(&s_job->node);
> +				spin_unlock(&sched->job_list_lock);
> +				sched->ops->free_job(s_job);
> +				continue;
> +			} else if (ret == 0) {
> +				*s_bad_job = s_job;
> +				return -1; /* timeout */
> +			}
> +	}
> +
> +	return 0;
> +}
> +
>   const struct drm_sched_backend_ops amdgpu_sched_ops = {
>   	.dependency = amdgpu_job_dependency,
>   	.run_job = amdgpu_job_run,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 81caac9b958a..25292f4699fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -76,5 +76,5 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
>   			     struct dma_fence **fence);
>   
>   void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched);
> -
> +int amdgpu_wait_resubmitted_jobs_completion(struct drm_gpu_scheduler *sched, long timeout, struct drm_sched_job **s_bad_job);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index b644c78475fd..cb50bfc80bc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -35,6 +35,11 @@
>   #include "amdgpu.h"
>   #include "atom.h"
>   
> +static char *amdgpu_affinity_group[] = {
> +"gfx",
> +"comp"
> +};
> +
>   /*
>    * Rings
>    * Most engines on the GPU are fed via ring buffers.  Ring
> @@ -189,6 +194,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   		ring->adev = adev;
>   		ring->idx = adev->num_rings++;
>   		adev->rings[ring->idx] = ring;
> +		amdgpu_ring_set_affinity_group(ring);
>   		r = amdgpu_fence_driver_init_ring(ring, sched_hw_submission);
>   		if (r)
>   			return r;
> @@ -459,3 +465,24 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
>   	ring->sched.ready = !r;
>   	return r;
>   }
> +
> +int amdgpu_ring_set_affinity_group(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_device *adev = ring->adev;
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(amdgpu_affinity_group); i++) {
> +               char *temp_name = amdgpu_affinity_group[i];
> +
> +               /* set ring's affinity_group bit if find it in affinity_group list */
> +               if (strncmp(ring->name, temp_name, strlen(temp_name)) == 0) {
> +                       DRM_DEV_INFO(adev->dev, "set ring:%s in affinity_group\n",
> +                             ring->name);
> +                       ring->sched.affinity_group = 1;
> +                       return 0;
> +               }
> +       }
> +
> +       ring->sched.affinity_group = 0;
> +       return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 56acec1075ac..6b0d217e6f5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -350,4 +350,5 @@ int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>   			     struct amdgpu_ring *ring);
>   void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
>   
> +int amdgpu_ring_set_affinity_group(struct amdgpu_ring *ring);
>   #endif
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 1c815e0a14ed..589cbaea35dc 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -301,6 +301,7 @@ struct drm_gpu_scheduler {
>   	atomic_t                        _score;
>   	bool				ready;
>   	bool				free_guilty;
> +	int				affinity_group;
>   };
>   
>   int drm_sched_init(struct drm_gpu_scheduler *sched,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
