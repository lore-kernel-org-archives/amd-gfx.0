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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76B7C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A8F60F45
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 44A8F60F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D71136E81D;
	Thu, 26 Aug 2021 12:18:34 +0000 (UTC)
X-Greylist: delayed 880 seconds by postgrey-1.36 at gabe;
 Thu, 26 Aug 2021 12:18:33 UTC
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (unknown
 [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF2C66E81D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 12:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxGC1MhQAMJueYizCS+rJnOo1XW0F7fSIWqW95zoBrSt1vAttFEs9JX5n5qozDRfoZ/2lV90r035TWp14GmKVpbY2H0A0EsT0N9ZICjom99rgiygysqgwWqZL5P15vUW/vJKzlbJwCsJ2dWCGdUJRIJlMQLtwDKG2SkptJoGzsT4kabVYeK2zTTWIX8XOWgx9QORewLAAy72uW/QOGWmA4pd2r+eKeAa+Mpqz9WSQBJjvtMGEBG1y/0Ew25w1ZtoKJT7Cbhp+MAr3790EGi64QFxHUrvdUVaWgeax1uPQ7oCse0v8j7kQYwd1Q8fVNzhzabnAP5D+nKRJhceL8GSTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM04VB63LD9iF8qkaherQg7DXJsP25bd72FL8ZMNPxg=;
 b=OIWdsh44iPYVMHtbVh3qmfKhz59zxyKgtIAij99Gcy9c2b80WcOD4MmrhrTpgweRAACLh1eSJ/10PV9XKOJDYwxw8GlLlHCZQ7Yc6/2mAkUImQL4lZoSU0V64KORyLU9Ez0DIUhDHNQXTYcwYOtlBeUcLluzFqIAbiSr/hsp4cAY2mizqQJd3u2znOcmaL/qqgPsA/+KXGX+m33oX/B6WsXvcpCkm3/fuku8/qePB7aWgguNEmhcUWv27oNeqF2wfg4PKXT3x0HodU89mR4XR2Me7eNsRYxuM3xrfpIlArqEc90nr2pV5awQO3BEfoLEwFWcECKWVugKYy3z5sd8Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM04VB63LD9iF8qkaherQg7DXJsP25bd72FL8ZMNPxg=;
 b=pzkj0foS+2Fq3QxGz9IbRPBhO7SDHF7U88I7K7Atu6x8QoZEPRTA6sFwT/C1/Z7tQe5zDIJS/CN8xdNGRioRS89vOWLeQ5og3bEv5M3E/gUIEkgvvej3zVfmPjcb6aR2BjCkdICSkF3F9/YT1onPHz3m4Xj+dih/lxoW9Pceu9k=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 12:03:52 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Thu, 26 Aug 2021
 12:03:52 +0000
Subject: Re: [PATCH v3 1/1] drm/amdgpu: detach ring priority from gfx priority
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, satyajit.sahu@amd.com
References: <20210826112853.6617-1-nirmoy.das@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <b8d4756c-9ee1-13e4-5a84-62b8aa64924d@amd.com>
Date: Thu, 26 Aug 2021 17:33:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210826112853.6617-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::26) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR0101CA0040.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Thu, 26 Aug 2021 12:03:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd05d40e-965d-4fcc-33ad-08d9688991ef
X-MS-TrafficTypeDiagnostic: BL1PR12MB5160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5160C8A5DD96689843602FF897C79@BL1PR12MB5160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDCFBsoFIU3PtaYInLrdEoy7FqkQ8jWJAM9VmZJt5fpqnNnTnlOJoKKAqijk7b3nKffRrmM6Gzzaa4dsQQ+yR2uq9y6YKrjG4zArdh2ea+OwzsSRljm3mmmjavWPMny+6jZKR/2ZRgnId7mDnew9hLhrQBFZlOK+f5L6VeXjVfhkOYZcO2NgmR/ZU4im0F3QgSkt6qXlg5QDzg3VGh+XEsCdiATIoCBYDRupXVFeV2tyvQtWNL8vnqFBm+uLjEFSgZ7N3lc3Shaz4T8iuUTHShYbfq3uAESTjbaOuuW6dDUU9zWz0tC7mreuW2dp3poNy2o+k8u1Wv1rAjuZJYh8aN0ZH59B/ZR4IzA9mQlp4zE64X1yYv+NMB9KUfD/sXpTi7o7VPIZLawGhEAB4GBZmfu1aUXQKMEjaUNviC28HISpF7aePeqdltBwox1I7dAOxfjzaAew2b5pt9Tju6cp1UxjZr2YKt7NAJepc4S5Nkle3WXmMSPbFMPwlg6mI3YikcaosW6yCvnvl4uOgGlXJ5SjPVTJ9xeAmbjT1JdDbOV5Mil/228iqyuHuHJN1Nr7lTEymXPM0/ANo2G7wunVMQ0W7oj4u8+iHpN3El6W1FuvDg+S9gYJN59HRtGVm7XjNcsehk93/Hznrhz9rqzjzfA9hhcEzS/ZeTMJ5bG41vvOdGTbvTB1QlNx6JHgt7M+00EsETaPKm/vn8emNkiNcpgCnvk6sV8qoOhPa16ZO8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(31696002)(16576012)(26005)(83380400001)(38100700002)(6666004)(53546011)(4326008)(186003)(6486002)(36756003)(66556008)(66476007)(66946007)(86362001)(2906002)(5660300002)(2616005)(478600001)(8676002)(316002)(31686004)(8936002)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHFPRldIbXhRK2NIK09BTGJibUJjOUc3YTFlSCtydXlHSHVLVThVWGJiSjk2?=
 =?utf-8?B?ZlU1ck5IVVI2TXl3bmlDUnVwb0t1MzFqU3ROdXNGV3pwK2d0aHp0UGU3MEwz?=
 =?utf-8?B?YUNrTXZmdWZHSTNzbS9wRTZTblVjU1ZSbmg1eDZzTFowbFJUcFkzbFNPSXhJ?=
 =?utf-8?B?K3FsNkQ0MFZ0NVMxQUR1OUF5VTEyY0hheVV1MHNhbXVlUlpkU2UwRWNTWm1R?=
 =?utf-8?B?UWQza3Z5Ym5HTTJnMXBxSTBrRm15aGQvQnArc1NQUDc0b3FPT1hTSk03OGNT?=
 =?utf-8?B?Sk9sVFJQc0ViU2dQZVZybTdBVFM5M0ZxN241ZlZpamQ0Yzk3b09Ed2JQVEtJ?=
 =?utf-8?B?anlxbXl4UWlXZEtWdmZwSnF3NElYS25ZVk1JcndwaVRhRDhqNVRKMGs2aDNh?=
 =?utf-8?B?YkdvTzF0Unc0c3ZURUd6YUpuZHZjb0gyeGFINXF2TUdSbDlKWFoyUmVESUhR?=
 =?utf-8?B?b2M0QlYyQWZoUDJiRlhsejJpNW9EOWYvYkl4V0ZlMFhpLzA3TWc3VCthUlJ6?=
 =?utf-8?B?NlNiRlhEby9WTzYwVGxTTStJWkZoZ09MUitpVkIzNmRqbXZRYnZKemJQSjFl?=
 =?utf-8?B?QlVqNHBNVVJjQlBQUk1GdWM4VjNmOVVJU3ZOb21tcHI1aWhvSk9tZUlHQUhN?=
 =?utf-8?B?N2FaM3JqemRuZ3FxalpxRjV1aytwV2NKNkZMMTFyakZwV3FITlRrNDhFV1Jq?=
 =?utf-8?B?MngvWk1RRW5aWUxjZ01GVXh2QnpIeHM4TVh0OXJ5alF6b3dieDRQYXBTaVFW?=
 =?utf-8?B?V2sxOXl6blVsbzJNNytvdTllNVo5OGx6ZmhLZUhkV0FOWitYVG9ocUF3YmVM?=
 =?utf-8?B?UzVhdjg5V0JieDlEblpSTEs0Y3FUQXVxR0tDNVNFWGZtUVhhYld4a25KRXEv?=
 =?utf-8?B?ajlPMXczMzl4RnV6RkJwb2h0ay9pK0x1RkwyYk1NMU9MMGEzVFZtd09FZnpH?=
 =?utf-8?B?TW1iYktIWEhVYmZPQjd2dFFYMjhsMnQ5NHY2MGxoNTlMZm1tbzAyTndYMSto?=
 =?utf-8?B?RCtLaGYrMysxa0dId1ZEdUdjSTE1ODBlRndJNmR0UVNrVVljRExIUnBsaDYr?=
 =?utf-8?B?QjRMZlNyVHIxbWxRQW80aVhXWkFTbXYwK2F6N084NE5wQjdEMHczYWlhdytI?=
 =?utf-8?B?aWlYM3h1UjBBRlFsRjYxdyt0R3hoNnpDRWx5UDAxaGMxVGxqYUpjSHBsTzNq?=
 =?utf-8?B?RnhEaEtDQkk4S3BUN1hvQ3FmZXhacTNJSlh3SWtQYTMybFQyZmpYc2ZXWXpt?=
 =?utf-8?B?TFl4d0htbmEyeDZaMUU2dldOaEhOa3VxTjkxNWZvZ2RKUEg2M1pWVTRrOWNI?=
 =?utf-8?B?Q1RmN2NoZjdLb2NKQ2h0ZGF5V1JOTUk3Nitqd2N1Vk0rN3NUUXdEaE9FVWFO?=
 =?utf-8?B?MzFaRmIrWkwyTjB5MXlrVTQ1ZGhIYlF0SWdEckRCNjI2a1RDeUFIWVZ3ZmVu?=
 =?utf-8?B?Z2NXZG5Ub2xUakd0Wko3N3h4THg2THFKNFRtYWFUNFh0RjRNUkdlL21rbGtI?=
 =?utf-8?B?dzQ0ejZDWTdqZjZ5QXgvYlFYWGZDTXJJV2doYlVpc3QrWUtRNUVnQ05PQ2pM?=
 =?utf-8?B?UWUrNmFOc3lSM24wTGJtNmRYTDJKNFpySnBpdDRISkR0RGF1WTdzY0lNMGpk?=
 =?utf-8?B?VUZqZi9BNlp4dlhSK3dHV1dBcXBoYmxqdUR3alFIL2RrQjg3R0RQd2d0QUE3?=
 =?utf-8?B?VG5aeUFqcnZTU29KTjJaWSt3WVRianRRRTNPWWFBWWFWQm9kRWRVNTVBbFU4?=
 =?utf-8?Q?XBszIjA0MXx7WFY05Fm8rhkQnBAk5Zw2LVoduha?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd05d40e-965d-4fcc-33ad-08d9688991ef
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 12:03:51.8772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfOmGu5nvW8bWQAjLL2B/fq9XSo3IAzXf4ngdP8Cx+ZulQzQLyR9zYWLK6NSjsC0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
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

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

On 8/26/2021 4:58 PM, Nirmoy Das wrote:
> Currently AMDGPU_RING_PRIO_MAX is redefinition of a
> max gfx hwip priority, this won't work well when we will
> have a hwip with different set of priorities than gfx.
> Also, HW ring priorities are different from ring priorities.
> 
> Create a global enum for ring priority levels which each
> HWIP can use to define its own priority levels.
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c  | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 7 +++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 9 +++++++--
>   3 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index c88c5c6c54a2..0d1928260650 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -109,7 +109,7 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>   	return -EACCES;
>   }
> 
> -static enum gfx_pipe_priority amdgpu_ctx_prio_to_compute_prio(int32_t prio)
> +static enum amdgpu_gfx_pipe_priority amdgpu_ctx_prio_to_compute_prio(int32_t prio)
>   {
>   	switch (prio) {
>   	case AMDGPU_CTX_PRIORITY_HIGH:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index d43fe2ed8116..f851196c83a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -42,10 +42,9 @@
>   #define AMDGPU_MAX_GFX_QUEUES KGD_MAX_QUEUES
>   #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
> 
> -enum gfx_pipe_priority {
> -	AMDGPU_GFX_PIPE_PRIO_NORMAL = 1,
> -	AMDGPU_GFX_PIPE_PRIO_HIGH,
> -	AMDGPU_GFX_PIPE_PRIO_MAX
> +enum amdgpu_gfx_pipe_priority {
> +	AMDGPU_GFX_PIPE_PRIO_NORMAL = AMDGPU_RING_PRIO_1,
> +	AMDGPU_GFX_PIPE_PRIO_HIGH = AMDGPU_RING_PRIO_2
>   };
> 
>   /* Argument for PPSMC_MSG_GpuChangeState */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index e713d31619fe..88d80eb3fea1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -36,8 +36,13 @@
>   #define AMDGPU_MAX_VCE_RINGS		3
>   #define AMDGPU_MAX_UVD_ENC_RINGS	2
> 
> -#define AMDGPU_RING_PRIO_DEFAULT	1
> -#define AMDGPU_RING_PRIO_MAX		AMDGPU_GFX_PIPE_PRIO_MAX
> +enum amdgpu_ring_priority_level {
> +	AMDGPU_RING_PRIO_0,
> +	AMDGPU_RING_PRIO_1,
> +	AMDGPU_RING_PRIO_DEFAULT = 1,
> +	AMDGPU_RING_PRIO_2,
> +	AMDGPU_RING_PRIO_MAX
> +};
> 
>   /* some special values for the owner field */
>   #define AMDGPU_FENCE_OWNER_UNDEFINED	((void *)0ul)
> --
> 2.32.0
> 
