Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B3AC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 07:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1104710EA8F;
	Fri, 14 Oct 2022 07:08:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E4110EA8F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 07:08:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+9AJs8nNmPk4QdpmzAW6ycaZkBZkM6FXTEw2Vm2S1aqenfOC0voW5Ncbrzoa9fgR7URomGrMvBX3fOf4H2Q5NWMnJ93QL5JeN+TqBOHe2/xB3WbQChibTmK/jj854EMjonzeLu/s0mJjpniT9IGEqZ1ntSkew3jELnLUrtR2IR/g9sO3WkDhDiOPEFBFMXGoqAiwIcKZXLNhLvmsThu3YTWz0/HWSk1Xdk7xDeQb4p2l+bJfA6RNkKH1PtTS4JtaivG0euL0qonRg4GaxsSE8oye32gQob+1YHIkMSf/oKeiws94ddyuDD/IU1wqXvVt89dmZiDkf8psYSsTZGVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WB974fNzvGEyDaHiv/XxcXcDY+ngUdUh4c9D5/sJGVY=;
 b=UhvF3SWkINjZpJqRmACk7L4HT+NrlcIGKDQWHtohPDT/WX13fHV7aJMuzZuUAdV3eSFfbxgRb1yv3B7fCuL6qfcXxARhmEZLqTysOYOvgrfV81eP4/5ZDC+vTguswAajFwHvz7hyHBOa9cAswbONEssZgAGIaYWHj3GqsEC0aG+jOduyaUwNCy3bLFbq2Q2/XSsl49uhjrzXyenYdZSZ0Ggahts/pl3rKVLiACaT/jDruKdNsUb86lgvIYAO5gQtjEpFF4s4eNdn4jRH/WVVoD6r0qBw7X7DbrkbHGqmD+I/gISsvACoZabhK8QFaqNOrfWtaqzEWFCwk/1c2f9XmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WB974fNzvGEyDaHiv/XxcXcDY+ngUdUh4c9D5/sJGVY=;
 b=e+pHlfC/DZaczNC2uoXq/NWE4g5+X5yJ1LjVPv4ZezG6+xHNxq3QOak7qlGTW5dNmOJU2oc5XFvsTFoKDyt5WeppbpjPNqusz0Ib/uY8C36SekcAhYPvqr5i8Pmv/UyEwiIv68DJVRjg/CUm91ztVCxRRIp3Voi7Zk04b0zKf8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA1PR12MB7223.namprd12.prod.outlook.com (2603:10b6:806:2bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 07:08:12 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644%6]) with mapi id 15.20.5723.022; Fri, 14 Oct 2022
 07:08:12 +0000
Message-ID: <6271b033-04d8-31cc-2518-7613b65c64b9@amd.com>
Date: Fri, 14 Oct 2022 09:08:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] drm/amdgpu: dequeue mes scheduler during fini
Content-Language: en-US
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221014033419.3461246-1-YuBiao.Wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221014033419.3461246-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA1PR12MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af23ea5-a899-478a-16b2-08daadb2db59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BpUs7imsFyMVXEpSdgtc35Z+KmP/Gy5bXM0NhWSVefiIW2JD56ogyVlHfefoaidFTEF6QqvSWiDuPDd0jZ3R3YyFmMn0gk9tepJoNsRjLAtd63pFSy+sgJ/KFr84CZypTE5zbS4Tt69YcoucUNAXhK6G8m/ytdZhi9GyjecVmgvHKJq/hyCDPvpNRIkDNSOfoeTZSsYDNUtBUXo6PlX7oJQ3u+tSe1XRsLCMv/BhlJEeI4Id7NXb7wNmCWIqQ5nKlAvb6CYYVzBPcGzcBRGleOgTU+XesEyw+Q7uug4FH2PtGtaT+MEgO0RVUjfykM9NMMNZILAdaa40cOieT2oNW1E88ow90IgVtg95AhOk03sY/7Cbj8t5bxbGz8/17ppB8FzgvhgzJxVB2r00nEorHxRhUl1Y+J9PtzYePz2VHT7VC09O5pORSaJL/uog+I/CY2jo6RwBGC6Nbs13/KK3p7+exMZTBQsUZ4qJy0SB60v0regW3XCm4ody+15r/BV+//PYoo+G0YdTbkoXm5/35mARvEuh804Ifx9b06exby0Fj7DkARup98ZlZchbyTu1le+eJJC6AhrMgzZ4O0mhEi6+dyKuw66arvgyeSSG0oVwjo1FzyLEvm+FcSnUt4nkdpAR7y9GoHEu/c46zsQZz8uLsCMYkoISHK6MVaPbHRhcdVNaLxCt/3aVppgMJ95EPwBXRDNAxJOrLHG2wFmny9keOAXjVgEwiW+uFYSZh9z+M/xXgwqmSS33jDakJEJ1t6/nYDh36vkrhLKNqcsN7muttoorR0L2ElP6WiREeho=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199015)(31686004)(2906002)(54906003)(316002)(4326008)(8676002)(5660300002)(6506007)(6486002)(8936002)(66946007)(66476007)(66556008)(41300700001)(478600001)(6666004)(36756003)(66574015)(83380400001)(6512007)(186003)(38100700002)(31696002)(2616005)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVNkd1dUOGVlRDNWekJ1TFpiUjhLa1JCVG0ybkV5SHZHR0lPdU9WZkhseWJ2?=
 =?utf-8?B?S3Z2TERWN2NvcWR3Y2hLcHYxOXQxM1lsb3k5WG1oa3NINDloSldWYWxmTngx?=
 =?utf-8?B?ZWM1MUg2N1IydFhWL3d1ZWFrdkFRVm0yYytLQWxha2ZuNTB0M0VjVUl5bGVE?=
 =?utf-8?B?MU9qN2h6S3JnWkhINzFnZU5hK095ME9lSFcybE1oVjhqVE5ZWHhUeWhGb2J2?=
 =?utf-8?B?ajlFZm9SV2ZRVFR3UEtyVWd6NktncXFPV2w0VXEvblJUcEhRbVhLeVEzQ0w2?=
 =?utf-8?B?WkRmQ0Iwc1pWd1NHWml2TFdCbkhhMGt0cXVHVjlmbldSRFNOUXhTckh0cE1R?=
 =?utf-8?B?UzNGajZrRHdEQ1JTd2FpT0FDbDNUUzk5SDY5Tm85dE45VXJwcGlTTjlCcFBr?=
 =?utf-8?B?RXFDN3N5RUp3M1RISVo3a28zSnVONnhKUU9sUFlKcnBOS0VNMWpUbjUreDFa?=
 =?utf-8?B?bXYxRGpIQTRPRnhseitQZE85N2FsNmVFS0t3b0RkK0NwaXR6NjBySVZIWVFQ?=
 =?utf-8?B?aFlkTklzTTR2dmFwTW1DWFNDeGRuejZXcWhqRFVqZkxPc1pRNmxHZHMzVzFS?=
 =?utf-8?B?Y2Z4N05hMTI5bVFaYm1hbUUwNmNxbWp1dlM1ejhEaDkxMzRrbEEzeFBoQXhE?=
 =?utf-8?B?emljYnBVaW5YK2VGWCsvd0dWdXNETlRjM1BiRnFMSlZMUHFKaGdHMUxSSWhn?=
 =?utf-8?B?SElFUklwQzFNbmpzSmN2QXpDVHhzVkVYMUp5MnRTWTZVbnBrTXUrV3BmYURk?=
 =?utf-8?B?T0lyTGZNVlhGMDlKZUExZ3VLVFVYZHpsWDFjbEtLMzhZOUVoVU56eDkxYmZp?=
 =?utf-8?B?UEt0MmN1cjlSMmJqbytwMDRkT1c5bVhQN2ZnbllSZGNuUFMwZFhoTkYzTXl2?=
 =?utf-8?B?QXkyNHFWRDFhM0xHOTBpczJuTHNLdndjaEtyVGtBYW54WFRVazRDdHdoRUVE?=
 =?utf-8?B?Z1d5VUdyVXVOaGxLNzdVOStqZWxXOVovRnc0UElpeEFieUxQT0pwSy9CR1RZ?=
 =?utf-8?B?UXl6cTZWQ284R0hzK2dpNnQvMWNyeS9oblFDb25HTk9NV3hYdFlwQitORnlF?=
 =?utf-8?B?cTd0a0FPMlVtWm5YNHQ0QnozRk9sWFVNVWl0SW1MdS9zNHorQTk1TUtNbnlw?=
 =?utf-8?B?Rk9BcHV3ekhMWEZzYW94NzhXbVpPSXFhNlhtRHNxcU1qRWFYNTRISjNpY2No?=
 =?utf-8?B?SitRcmdSeGtkRktnUm9DME1veHFYNEU4enQxMXN4TXllcnBJL1E4T1lOQkJa?=
 =?utf-8?B?UXdsRWJkb3ZseUV6RE5pZmtWWXJ0T0tpbUxZUTAyNUNXNGtGeEgzWGdZK0hl?=
 =?utf-8?B?UWZVYUpoV051TC9LeFhnNHErRXJ6RjBTQXgwckpKVjhhN0REUmtSTU9WTWd6?=
 =?utf-8?B?cFJxWG1JNlFYalladHFjTzA1NHZveUxpZ3NTNklMbWFIa2hnL2N4ZURSYlVs?=
 =?utf-8?B?Q3c5d0ZBMTRLUmJ6Ymk1SG8rbjFBOEdVaEV5MDIvL3ZBYnpGRjJwS1BMVkI3?=
 =?utf-8?B?dVVUc041R05KL1lZb1lhL1VuRElXVXNLSHJkUUZwdnRnWldEUVZUYndXNW1i?=
 =?utf-8?B?WFJhTXJFNUVSUFBwNTZnakhZU1Qya0M0Q25wQkJQMHo0MG0xVXQ2MFRyeEl5?=
 =?utf-8?B?WHIvWFExeXdHbFU5OUlRajNDT3ovM1lPWUJXL2ppRE5hdGRZMmRydFFQMCtM?=
 =?utf-8?B?RjRPbEszVCtjdEQwdDRpZXFkZFVqZ0tCNHV3L1ZxeHVFbjJOVlkvak9QTmhF?=
 =?utf-8?B?bVQwTEdmbEozZVJseEN2MXdWbUMreDhEUk1QL2NzVzgzL0pSam9UajJwVUlr?=
 =?utf-8?B?YWVKQlFwOThPeDF4Smc1N2VueFRJQVVJcEpLLzc4bVN0bnEyNkpFT1FjSU1u?=
 =?utf-8?B?SHN3VVBRbUttbGlnMkk5TmdxT0VYbXhsN1daNHNvcmNUOVhGMWgxWWtSdUFw?=
 =?utf-8?B?eExFU2czMlcvTXVib3NnYUo2ZGtxL1Fqank5ekh6OTdjV0JRUEtSZ1o0WXkr?=
 =?utf-8?B?dlpYWUxtV0J2NEFkNHRzYndrb1VXdXNPNjl3Z0NVUm4raVJLNkRpMG5yVldn?=
 =?utf-8?B?dDFTQ0FhVjVUd29wdzVpS21ubXVJbkFNUlAzU1Z3dE1US2RoV1EydUs0QUQz?=
 =?utf-8?B?V3UxcFU3UHcxcDZteGd5UHc4c2h1dGpJeFFtNk9JYzQvcjhYREV3ZDZOUkM4?=
 =?utf-8?Q?dQKClnyT6cngt0AWUweWDpudrg7RLdrUi113mNrbI4EC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af23ea5-a899-478a-16b2-08daadb2db59
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 07:08:12.4991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N90L7fXf1E++cuXs26vSj+kOa1Ds0yH4bNpOqCcMYAqJVr+bpBosey/YaRMyzGKZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7223
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.10.22 um 05:34 schrieb YuBiao Wang:
> Update: Remove redundant comments as Christian suggests.
>
> [Why]
> If mes is not dequeued during fini, mes will be in an uncleaned state
> during reload, then mes couldn't receive some commands which leads to
> reload failure.
>
> [How]
> Perform MES dequeue via MMIO after all the unmap jobs are done by mes
> and before kiq fini.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 ++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  3 ++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 41 +++++++++++++++++++++++--
>   3 files changed, 44 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index ad980f4b66e1..ea8efa52503b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -130,6 +130,9 @@ struct amdgpu_mes {
>   	int                             (*kiq_hw_init)(struct amdgpu_device *adev);
>   	int                             (*kiq_hw_fini)(struct amdgpu_device *adev);
>   
> +	/* dequeue sched pipe via kiq */
> +	void                            (*kiq_dequeue_sched)(struct amdgpu_device *adev);
> +
>   	/* ip specific functions */
>   	const struct amdgpu_mes_funcs   *funcs;
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 257b2e4de600..7c75758f58e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4406,6 +4406,9 @@ static int gfx_v11_0_hw_fini(void *handle)
>   		if (amdgpu_gfx_disable_kcq(adev))
>   			DRM_ERROR("KCQ disable failed\n");
>   
> +		if (adev->mes.ring.sched.ready && adev->mes.kiq_dequeue_sched)
> +			adev->mes.kiq_dequeue_sched(adev);
> +
>   		amdgpu_mes_kiq_hw_fini(adev);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index b48684db2832..eef29646b074 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -44,6 +44,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
>   static int mes_v11_0_hw_fini(void *handle);
>   static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev);
>   static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);
> +static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev);
>   
>   #define MES_EOP_SIZE   2048
>   
> @@ -1078,6 +1079,7 @@ static int mes_v11_0_sw_init(void *handle)
>   	adev->mes.funcs = &mes_v11_0_funcs;
>   	adev->mes.kiq_hw_init = &mes_v11_0_kiq_hw_init;
>   	adev->mes.kiq_hw_fini = &mes_v11_0_kiq_hw_fini;
> +	adev->mes.kiq_dequeue_sched = &mes_v11_0_kiq_dequeue_sched;
>   
>   	r = amdgpu_mes_init(adev);
>   	if (r)
> @@ -1151,6 +1153,42 @@ static int mes_v11_0_sw_fini(void *handle)
>   	return 0;
>   }
>   
> +static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev)
> +{
> +	uint32_t data;
> +	int i;
> +
> +	mutex_lock(&adev->srbm_mutex);
> +	soc21_grbm_select(adev, 3, AMDGPU_MES_SCHED_PIPE, 0, 0);
> +
> +	/* disable the queue if it's active */
> +	if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
> +		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);
> +		for (i = 0; i < adev->usec_timeout; i++) {
> +			if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
> +				break;
> +			udelay(1);
> +		}
> +	}
> +	data = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
> +	data = REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
> +				DOORBELL_EN, 0);
> +	data = REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
> +				DOORBELL_HIT, 1);
> +	WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL, data);
> +
> +	WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL, 0);
> +
> +	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_LO, 0);
> +	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_HI, 0);
> +	WREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR, 0);
> +
> +	soc21_grbm_select(adev, 0, 0, 0, 0);
> +	mutex_unlock(&adev->srbm_mutex);
> +
> +	adev->mes.ring.sched.ready = false;
> +}
> +
>   static void mes_v11_0_kiq_setting(struct amdgpu_ring *ring)
>   {
>   	uint32_t tmp;
> @@ -1257,9 +1295,6 @@ static int mes_v11_0_hw_init(void *handle)
>   
>   static int mes_v11_0_hw_fini(void *handle)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
> -	adev->mes.ring.sched.ready = false;
>   	return 0;
>   }
>   

