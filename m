Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65549C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 08:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF2E6108F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 08:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2DF2E6108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 928E989CE2;
	Tue, 10 Aug 2021 08:32:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0864B89CE2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 08:32:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiCwgjSZ+XBywXrEoGSGDW6YtagWOSXPSLRVxD6k3lnayfPXpIAc5VoOCNE09OgXwEgIUVlwp5jxMnBI0WZKPSZCpPbDad9IH4yDXckvF19nEy7mLhZxzo9DrvE0LGyXWXtIds6kZ8fzPmOvsco6ihHiuD9j5juYuol6qigBdxbrzGwTFcnPYE0H1EYL22h8329gI98q5hw4Q4x2ocMz8l7NV/+qtPhgIdH/Hsrjnz69y2a3Ffb3kSUyb1Cqiu+GDQbETtn1oE3WlOZCGMja7MmNN+ECiO/9uFhtuGrZfOvsTGsVzRv5KdN1+UpKnvaXxc4parov4JbOl5XbPNflJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMpyH41j/8/9CzoEd2bdUMIEmUUJhMZ2WJVEWOBUWF0=;
 b=G1q6mFATYr76OqUhFn/WUO76vrvQ4aSf87P06HuzXAMd4hera7TO2WULHN0YOB2XhAoq6EP9HJ/+1N/h9OfQ4/rPkdDcws8bgX35nssD3r6fpTglYyr9nx66Iun8DU6UatwGImpyi+aU8wsHSzul90iOJHuK9Cj0eeCY3KvMXAdYJ+RagWKzXf81+5I6e/8OK/Yf5mMPH5hcvIjNXAN+70onab8pWTgicnjWsWgBb7AsTwIY9qnVugRJ49dceBPfalaXfSn+qSyP8KYSK4Vb7mUwmKUJtbputo1+umh6bUUDMPmWTwHdcO5GcTL+ST8Fu8rlbRLHHiimWbbCXJgBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMpyH41j/8/9CzoEd2bdUMIEmUUJhMZ2WJVEWOBUWF0=;
 b=gcpZf5LF+CrYnQCJDbj9/rKj/o7dUP0HTvjCvikx59d7HHnaiZMIVOBJGaGyYsTmL/RmqgrTFDc9XqKKtxhA0dXsLQn9OOD5emKUoz4SHMuDCzDdrjBO/UvoHHrtOoidiRL+AmXLNfIRgm6wwh92hLKcsGQBW7PSnhFBiv65ym8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 08:32:02 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::688a:7dc6:322e:bfdb]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::688a:7dc6:322e:bfdb%7]) with mapi id 15.20.4415.014; Tue, 10 Aug 2021
 08:32:02 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn:enable priority queues for encoder
To: Satyajit Sahu <satyajit.sahu@amd.com>, leo.liu@amd.com
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20210810070954.4480-1-satyajit.sahu@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <782566d7-4b9b-9595-fd26-94dfb2406161@amd.com>
Date: Tue, 10 Aug 2021 10:31:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210810070954.4480-1-satyajit.sahu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR3P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::18) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f20:1800:9de9:89be:56d:b378]
 (2003:c5:8f20:1800:9de9:89be:56d:b378) by
 FR3P281CA0054.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.4 via Frontend Transport; Tue, 10 Aug 2021 08:32:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6358a05-f5b3-4ca7-d43a-08d95bd953d0
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5246F295369B079246825E848BF79@DM4PR12MB5246.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/Bf40VH17qIrweh6ILFO9Dqrxr1fs5Yp5KSs8JR9Fi2wMFizPTJ6N4+c7DkBjEDD713n7JR8DNmf8c9MkyxlIBeo1kqF3FRqdon7HOhkJtHFcDS3j0bq17FJ3IsWBnplt5QqIGNZN7tOJA1N1Ynzf9QoXWWioWExG3uINhwfBqRcx9r/ErH70h49Ve4B9LsdYCjIakUiAbbckItuxt0NWMn5QwB8BUn+DXwjoi+BMFEIedUitVk6wt7GZhlpvqNBbFfaa+Utfpdl9ogtjGY/mVI5jhfa8ZgVwr9jW7HowmocOpQ7VD4vJSOf/TweMN5oqKkUIUddrlq6SynW1q42+lOPC1MKW7aQlKbYNh+2oAp7jXpCH1+wNs1iEWLri+s+Sn36ldVjIZIKzeLXcEL8xYNUd8af+q2Pqq86PyyQbJzeaP63pcyg8dH0EbqCrmCXcY1vheiokMmgzgc4nY3lIsW/h4n7NCDHsB5OdJPidev1DeUGSONXacFDrLhi3vTePY5yqFfyKIAq5W+OIEqQjVMoqdIzFoWpBHDN/gt6YuuZz1R3ghxBofhhf08CGBh7cil1tyUR+zm1LUnjM8Bw1kRU4xoK9xN6+hcpolz+7zLEnPIWbxUYholzvDCoKzCHoS/I9SCOB8UApLgOeeWmzy7CDg3u3ABfhtHPOtoqoCN3O/mGFrpY1SKrwSWDXgX/D41EOvAe4OZ2jtZDVYp1zm62lLYHWyFP+r9n7zsIUBj+OlhlrnxmeTZgGfOrp80
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(30864003)(66556008)(5660300002)(478600001)(2906002)(4326008)(316002)(31686004)(66946007)(6636002)(2616005)(66476007)(36756003)(38100700002)(52116002)(53546011)(6486002)(31696002)(186003)(6666004)(8936002)(86362001)(8676002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXhvdUdYNDlhbmFINmxiMElxSFFkWmhxdFJpcmtwV0JuOERlcTE3dGVmZ3d5?=
 =?utf-8?B?eDVVWHVreTd2cGx5dXFRL29PcXJ0eGFZVjdNeVQ4Q3laUnZWUmhxZnBjNlZB?=
 =?utf-8?B?cGJsV3E0WjY3RE10THZUeTQ4dFFkWENsY2g4ZHgyVHFiWCt2eEVLNFpIWjZs?=
 =?utf-8?B?UlJrR2EwcExqRUVkTFJXTjFmaHNSeS9nMDhGNld2dHkxaDZocGNnWGZqWlk0?=
 =?utf-8?B?R2pGTjM3MVdCRHNrUUdEWGNsNWI5VUdTakdvb0dSUnJRdW9aaFJpa1NvMWJ4?=
 =?utf-8?B?TVREMi9ScStlMkt5dG1MSGd5cDR3ZWhLa0h2V1dKUEdmT01yMmNQeWtoalQ4?=
 =?utf-8?B?ZjdWOEZrNnU0UjYzdEo1dXJacVBxcHNGYWJjNGI4S0JhMUQzWG95Vy9ndDVt?=
 =?utf-8?B?MEhXZDA0QVVGcmdKaitpWUtRdGxkOTQzK3VWL1VVZDQxRFY2aWlCaFlmaDl4?=
 =?utf-8?B?QzAyR2ZpTnZ2MUpYYUpMKzNUMW8rb3VsWHFpZ0VlZXFZYm0wV1pVVzREMGtn?=
 =?utf-8?B?eTZOU0twU0pKNG12bHJ2VzNVVVdHbmVEK1QrMlAyTHZFczBjNUxYVmZkUzdN?=
 =?utf-8?B?K3I2aXUwVFRzS3EzVG4xTEp3anNVUU5zVG44NndsQzc4SGxwQ2I4VXVkYXVS?=
 =?utf-8?B?ZUxSNUhGYnlsTzhza3hMeHF1Vk1mcGhCRlVyQ2dGZ0hwVmtuSmNwOFBoa1hT?=
 =?utf-8?B?RUFEZmRDOVdnaWZQMDJTRUlCYXQ1d1k4ZFZOL1FUdFNLQS9BMWFxR0ZxK3pt?=
 =?utf-8?B?WW4vWWFONUdTK1JpdkxRTW9OUTNWY3ZxR0VRamw1OXFjcnVad2F3M1dEWGg2?=
 =?utf-8?B?S01FTVhHc0Vnd0QwbHorTm8ySzgxaW9JZ29nWWF6WmxaU3o0ZHo0T1dCTGpF?=
 =?utf-8?B?Z2xTaVpTR0NkcWNwem1kM1BRTE1XWFVPRFEyQi9PaFJPM1lCMEMxZGtlS1pC?=
 =?utf-8?B?YjdlS0JFdjc5dWVyQmRHRlI3TE1Kck92dEExQ0U0SnhacE9SYkJSNHFPMVN2?=
 =?utf-8?B?YUl4b3RNQmIxWHZ6aWpEdUZBTWVZL1VVdVI5NFdyU28vU05vMDF0TFdMTTNX?=
 =?utf-8?B?cDdwSGV2VW51QVl5eCtiODNNYWxXSDNiOWFsS29OSEFvU3pEOFBOdGQ4eTEz?=
 =?utf-8?B?Qm9jN29MaFFJbDViSnJid3l4bC9NTzNMUkVObmFMc3FuT0w3akhwOTFmRXVZ?=
 =?utf-8?B?dW4waW50UG5IY0dnUmR4NTREdSs3N3pQamVCVkZWUjJMQnV3UEVoSERBa3Nh?=
 =?utf-8?B?UXlNZjl4ekxZdUZDRlFxZEFyUkczYXZZanJCOXRzbjlseHlodW9CUmtKN3Fx?=
 =?utf-8?B?bDNqNjMwckwyTE9KODBaZnp6akFwTDg4bEt5NjF4c2hvaE9qVkFlN096SWZl?=
 =?utf-8?B?Y3JEMXFvbHhvNDgwKzdNYWpuVnk0elBFVUxZNEF4Y3lPcUhZM2x0QVZKS1lt?=
 =?utf-8?B?VktBUFk3MUQzRkZCNldUbzBuK2FDOGhVWmkzSEFZQUpuZ0kyVU56S3ZVa29C?=
 =?utf-8?B?WkJONkw3MXI0eXZpT3pJYmZCUGVUSlNHYTdtd3UzTmlQTXFQamRYeFRDaEpP?=
 =?utf-8?B?UHhkWTd1cjBZcFlyWTZtY20vOGdsNkg2NVdJM09JQUhMVHJQN3ExWWVBdDJk?=
 =?utf-8?B?TTVUZHpOMTdKcWxTbEFOOVE3dmN1N09sWkFuZjF3anlBWmltazZFUXkyWmgr?=
 =?utf-8?B?U2V6cW5oMU9iZW1rNmJPWEpqb2hEMFlKRjhzNDF2V3JPK1RLdWZCYUFjYnpy?=
 =?utf-8?B?a01TMTV4cURKWmk4cWF1Zk5CZGtkS0VGcVlDT2t0S25jaXdOTjBpenY2WnIy?=
 =?utf-8?B?OE5jYnJaUEUyQzNkOE1MUnJ4ODRHUFhobjA0UG0ySjdjYUFuYWxzN0tjRjRF?=
 =?utf-8?Q?FAQ3B8mA60OOn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6358a05-f5b3-4ca7-d43a-08d95bd953d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 08:32:02.3723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MN7JIMgSi5aXK7m/4oDrgGd4JkhXpSZq0+sr6qsLSEv46akLFzzAixugKyfr0+I01kznaKcEa86zu7GyMxzb6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5246
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


On 8/10/2021 9:09 AM, Satyajit Sahu wrote:
> VCN and VCE support multiple queues with different priority.
> Use differnt encoder queue based on the priority set by UMD.
>
> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 35 +++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c   | 14 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h   |  9 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 14 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  8 ++++++
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c     |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c     |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c     |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     |  5 ++--
>   13 files changed, 99 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index e7a010b7ca1f..b0ae2b45c7c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -73,15 +73,44 @@ static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sch
>   	}
>   }
>   
> +static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vcn_prio(enum drm_sched_priority prio)
> +{
> +	switch (prio) {
> +	case DRM_SCHED_PRIORITY_HIGH:
> +		return AMDGPU_VCN_ENC_PRIO_HIGH;
> +	case DRM_SCHED_PRIORITY_KERNEL:
> +		return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCN_ENC_PRIO_NORMAL;
> +	}
> +}
> +
> +static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vce_prio(enum drm_sched_priority prio)
> +{
> +	switch (prio) {
> +	case DRM_SCHED_PRIORITY_HIGH:
> +		return AMDGPU_VCE_ENC_PRIO_HIGH;
> +	case DRM_SCHED_PRIORITY_KERNEL:
> +		return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCE_ENC_PRIO_NORMAL;
> +	}
> +}
> +
>   static unsigned int amdgpu_ctx_prio_sched_to_hw(struct amdgpu_device *adev,
>   						 enum drm_sched_priority prio,
>   						 u32 hw_ip)
>   {
>   	unsigned int hw_prio;
>   
> -	hw_prio = (hw_ip == AMDGPU_HW_IP_COMPUTE) ?
> -			amdgpu_ctx_sched_prio_to_compute_prio(prio) :
> -			AMDGPU_RING_PRIO_DEFAULT;
> +	if (hw_ip == AMDGPU_HW_IP_COMPUTE)
> +		hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(prio);
> +	else if (hw_ip == AMDGPU_HW_IP_VCN_ENC)
> +		hw_prio = amdgpu_ctx_sched_prio_to_vcn_prio(prio);
> +	else if (hw_ip == AMDGPU_HW_IP_VCE)
> +		hw_prio = amdgpu_ctx_sched_prio_to_vce_prio(prio);
> +	else
> +		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>   	hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
>   	if (adev->gpu_sched[hw_ip][hw_prio].num_scheds == 0)
>   		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> index b7d861ed5284..4087acb6b8bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> @@ -37,7 +37,7 @@ int amdgpu_to_sched_priority(int amdgpu_priority,
>   {
>   	switch (amdgpu_priority) {
>   	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
> -		*prio = DRM_SCHED_PRIORITY_HIGH;
> +		*prio = DRM_SCHED_PRIORITY_KERNEL;


This change looks unrelated to the patch. AFAIK KERNEL priority is 
reserved for kernel tasks, userspace shouldn't be able to set this 
privilege priority.


Regards,

Nirmoy

>   		break;
>   	case AMDGPU_CTX_PRIORITY_HIGH:
>   		*prio = DRM_SCHED_PRIORITY_HIGH;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 1ae7f824adc7..9d59ca31bc22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -1168,3 +1168,17 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	amdgpu_bo_free_kernel(&bo, NULL, NULL);
>   	return r;
>   }
> +
> +enum vce_enc_ring_priority get_vce_ring_prio(int index)
> +{
> +	switch(index) {
> +	case 0:
> +		return AMDGPU_VCE_ENC_PRIO_NORMAL;
> +	case 1:
> +		return AMDGPU_VCE_ENC_PRIO_HIGH;
> +	case 2:
> +		return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCE_ENC_PRIO_NORMAL;
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> index d6d83a3ec803..f5265f385890 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> @@ -32,6 +32,13 @@
>   
>   #define AMDGPU_VCE_FW_53_45	((53 << 24) | (45 << 16))
>   
> +enum vce_enc_ring_priority {
> +	AMDGPU_VCE_ENC_PRIO_NORMAL = 1,
> +	AMDGPU_VCE_ENC_PRIO_HIGH,
> +	AMDGPU_VCE_ENC_PRIO_VERY_HIGH,
> +	AMDGPU_VCE_ENC_PRIO_MAX
> +};
> +
>   struct amdgpu_vce {
>   	struct amdgpu_bo	*vcpu_bo;
>   	uint64_t		gpu_addr;
> @@ -72,4 +79,6 @@ void amdgpu_vce_ring_end_use(struct amdgpu_ring *ring);
>   unsigned amdgpu_vce_ring_get_emit_ib_size(struct amdgpu_ring *ring);
>   unsigned amdgpu_vce_ring_get_dma_frame_size(struct amdgpu_ring *ring);
>   
> +enum vce_enc_ring_priority get_vce_ring_prio(int index);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 6780df0fb265..ca6cc07a726b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -951,3 +951,17 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   
>   	return r;
>   }
> +
> +enum vcn_enc_ring_priority get_vcn_enc_ring_prio(int index)
> +{
> +	switch(index) {
> +	case 0:
> +		return AMDGPU_VCN_ENC_PRIO_NORMAL;
> +	case 1:
> +		return AMDGPU_VCN_ENC_PRIO_HIGH;
> +	case 2:
> +		return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCN_ENC_PRIO_NORMAL;
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index d74c62b49795..bf14ee54f774 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -290,6 +290,13 @@ enum vcn_ring_type {
>   	VCN_UNIFIED_RING,
>   };
>   
> +enum vcn_enc_ring_priority {
> +	AMDGPU_VCN_ENC_PRIO_NORMAL = 1,
> +	AMDGPU_VCN_ENC_PRIO_HIGH,
> +	AMDGPU_VCN_ENC_PRIO_VERY_HIGH,
> +	AMDGPU_VCN_ENC_PRIO_MAX
> +};
> +
>   int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
>   int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>   int amdgpu_vcn_suspend(struct amdgpu_device *adev);
> @@ -307,5 +314,6 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout);
>   
>   int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
>   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
> +enum vcn_enc_ring_priority get_vcn_enc_ring_prio(int index);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index c7d28c169be5..2b6b7f1a77b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -431,10 +431,12 @@ static int vce_v2_0_sw_init(void *handle)
>   		return r;
>   
>   	for (i = 0; i < adev->vce.num_rings; i++) {
> +		unsigned int hw_prio = get_vce_ring_prio(i);
> +
>   		ring = &adev->vce.ring[i];
>   		sprintf(ring->name, "vce%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 3b82fb289ef6..5ce182a837f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -440,10 +440,12 @@ static int vce_v3_0_sw_init(void *handle)
>   		return r;
>   
>   	for (i = 0; i < adev->vce.num_rings; i++) {
> +		unsigned int hw_prio = get_vce_ring_prio(i);
> +
>   		ring = &adev->vce.ring[i];
>   		sprintf(ring->name, "vce%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index 90910d19db12..c085defaabfe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -463,6 +463,8 @@ static int vce_v4_0_sw_init(void *handle)
>   	}
>   
>   	for (i = 0; i < adev->vce.num_rings; i++) {
> +		unsigned int hw_prio = get_vce_ring_prio(i);
> +
>   		ring = &adev->vce.ring[i];
>   		sprintf(ring->name, "vce%d", i);
>   		if (amdgpu_sriov_vf(adev)) {
> @@ -478,7 +480,7 @@ static int vce_v4_0_sw_init(void *handle)
>   				ring->doorbell_index = adev->doorbell_index.uvd_vce.vce_ring2_3 * 2 + 1;
>   		}
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 121ee9f2b8d1..f471c65d78bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -145,10 +145,12 @@ static int vcn_v1_0_sw_init(void *handle)
>   		SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
>   
>   	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +		unsigned int hw_prio = get_vcn_enc_ring_prio(i);
> +
>   		ring = &adev->vcn.inst->ring_enc[i];
>   		sprintf(ring->name, "vcn_enc%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index f4686e918e0d..06978d5a93c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -159,6 +159,8 @@ static int vcn_v2_0_sw_init(void *handle)
>   	adev->vcn.inst->external.nop = SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
>   
>   	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +		unsigned int hw_prio = get_vcn_enc_ring_prio(i);
> +
>   		ring = &adev->vcn.inst->ring_enc[i];
>   		ring->use_doorbell = true;
>   		if (!amdgpu_sriov_vf(adev))
> @@ -167,7 +169,7 @@ static int vcn_v2_0_sw_init(void *handle)
>   			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + i;
>   		sprintf(ring->name, "vcn_enc%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index e0c0c3734432..fba453ca74fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -194,6 +194,8 @@ static int vcn_v2_5_sw_init(void *handle)
>   			return r;
>   
>   		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +			unsigned int hw_prio = get_vcn_enc_ring_prio(i);
> +
>   			ring = &adev->vcn.inst[j].ring_enc[i];
>   			ring->use_doorbell = true;
>   
> @@ -203,7 +205,7 @@ static int vcn_v2_5_sw_init(void *handle)
>   			sprintf(ring->name, "vcn_enc_%d.%d", j, i);
>   			r = amdgpu_ring_init(adev, ring, 512,
>   					     &adev->vcn.inst[j].irq, 0,
> -					     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +					     hw_prio, NULL);
>   			if (r)
>   				return r;
>   		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 3d18aab88b4e..f5baf7321b0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -224,6 +224,8 @@ static int vcn_v3_0_sw_init(void *handle)
>   			return r;
>   
>   		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +			unsigned int hw_prio = get_vcn_enc_ring_prio(j);
> +
>   			/* VCN ENC TRAP */
>   			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
>   				j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
> @@ -239,8 +241,7 @@ static int vcn_v3_0_sw_init(void *handle)
>   			}
>   			sprintf(ring->name, "vcn_enc_%d.%d", i, j);
>   			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
> -					     AMDGPU_RING_PRIO_DEFAULT,
> -					     &adev->vcn.inst[i].sched_score);
> +					     hw_prio, &adev->vcn.inst[i].sched_score);
>   			if (r)
>   				return r;
>   		}
