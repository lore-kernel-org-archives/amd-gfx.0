Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2E1C388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 17:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90CA0247E4
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 17:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="G6bf6u75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CA0247E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D6B6E2C8;
	Wed, 28 Oct 2020 17:43:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A10B96E2C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 17:43:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oD9Z5njFTUZEncRwSfaYR7LKtnjwDd50hPn2tz28xD8dRZrtzo7ipckGqm98mbzai74us7pYkBDI07+DVxkAAKNNwp4/k3AxmUvrpZMIcDE6EYkuQxZPyYXRtQoqv+cnDUE0sWjEmfNwy1MkicT4suq6d/kAKYS/lX1X+yqZp4tcLiZ/zI6cHw9nXR3XkGGOrJdj5cGfG26bZlsJoz9k/vZAZZ/AjpTyjWjsryWVNtGgRffnJviiW83rjKZdPU8Pldv4czSREh94P0NGitCOsV0MpATuHv1Oado57ro2upZXltHJhaa4l4NfwrL7u827m466qr1NIzb7AL9mKhrp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0f553bNOiM3aMrTqsDNTq/BeScEJWC5cSIPlFXJ7BQ=;
 b=A39sq7l1qZrHBJFM78De5mdaFQyUUR5gtRVqew+tslu+39ejTOUjcicm7rIN7m07VrW0EiQYb36NIUnN0IrhbwzhhFIfFYk4JcYam8ANBPfqHvn0XkXZ3RJBlNdluzOeYY1MROliVdWKXKy0UtU7mqYn+6LS1e1giJPg4N/kp2Kuew0yHfO8tlBoKKL+bnBbtgtwI9Vxyq7cmvuAYJi1ER68FHJlqKBKFufD2g4eo6TGEblZ18PjHOdtycT5Fz7XTWxm2M0DBYXEulS/QEhCv81SuXP+qCrgtzWi6blEXHJcjQ47oehw0KGgMTHKM1GZv93tgnwc9LVLAezZ/HIc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0f553bNOiM3aMrTqsDNTq/BeScEJWC5cSIPlFXJ7BQ=;
 b=G6bf6u75sCyGhGKsqw6OxyutOP2F599SlXu5md6FCs+PX8QDcyKMap5ar3exvyED5Znd3ahJytpNuJE6HQO09HZIaGeJ+c0nSCjR8ZcOL+XqBn50qnUpRMjFlWNZxUsJvPuNP+1vN0tpvVSV3ZfYt5LYf/d2LJUiH4JD7Qy+Txc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 28 Oct
 2020 17:43:03 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 17:43:03 +0000
Subject: Re: [PATCH] drm/amdkfd: Fix getting unique_id in topology
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201028171128.22077-1-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <65b5bc97-767a-c7eb-5a0a-55d9e3b47eae@amd.com>
Date: Wed, 28 Oct 2020 13:43:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201028171128.22077-1-kent.russell@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.113.11]
X-ClientProxiedBy: YTOPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::39) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTOPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 28 Oct 2020 17:43:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da5e2132-b373-42a8-8560-08d87b68eb8c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4096D7B8BB994BC84548DC1592170@MN2PR12MB4096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dRLol/iXB1a0Q2uV6LCtWhxbF7Lf2DkxRzfaC9ipvADluNJMDphXxzFjvlNkhRWTvU0oiqljarYyMw7XxZNWvyJySdj3Ys4Ccji05kqhilZxoWSE979j6yaPty3kZFNfs4fmAIVxnb53cd7plAi/xse+YXsvo6y7d31VGhgvxFX5DQr53LneixHjpTAEs40pxYH2tThVT1tYBWcGtCwUhHVo0kHNTwg5PPA3Z+sLzC607n4O2nmOopqlm0ImFU1mQ2+VG5vu0kWQX1WwlqlLVBC4WvvCibsUogAJR3RtxEn7wMkX1W+gZqlF72WWPoUmm2d7zDO1X+kUQi/ifgLCCkRxHgo2sjebidiSUm5dolH1lTUiAF79ne4mL0/U8dB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(86362001)(956004)(2616005)(16576012)(52116002)(2906002)(44832011)(8936002)(83380400001)(186003)(26005)(16526019)(4001150100001)(8676002)(6486002)(66476007)(66556008)(31686004)(66946007)(5660300002)(31696002)(478600001)(316002)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jieaJgkghLYJghykrO/U+g9wJP+Fz99u0B2bHUCzF2g6GvOOFTmXiHe/aj8O9Gf/Oki/26mtJ3hB0bCR1S+ECUM3AKZ8e0ymqgl2qg+MG0GD2tSuaLp8o+AEA5DIYgKgdQmWK6IEL+g7XxdP0PHz5T21qdTTiNbkc8Pk66UPdvXjOfSUrSA95IME4SdNEOd/st1mZIk4KiC/UpJGJFsk7eKp3Pv76ujzQWgR6xbR7EQTSIqJHvKLX5qsffsamf2g3A63XqEfVH+6mVOSbDlC9NSoT9TP1KDswoEUgY4Nm51bSNoD05vHcP57zMWD1NKG7KrntK0NoYKNLnl4Uj+e1X3+mlbZG/kAWsLRkhD2qxpPNQ7G7UvX53QofMa46J8l92EVO/I5FoBIsRusuM4jCyyS6LSbtoNuVuLzgNdZxSQtXfruVNZMe/GdUTtZNA3Nc3n8mlKhdLSr+crqW7JgvM42j/sRAX7JEz5WUz/kc8LgHADM8KIx+vjfhmjA6IBxufMa3Lc+9ccY4Lo+I2xGNkwlo6CE0OYzMhjN+d5ZF2Fs1YtwPVlHdNQIU3XjB9VtgMpW2h/2W+aRM888XYo6EhI5Pib1xCEZKJf/sW8aqysyIdoW6t9yp7p2od0nWXBeJqNo03hVdTCUnBfAZ/p0Mg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5e2132-b373-42a8-8560-08d87b68eb8c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 17:43:03.2770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7Gj3I3m+j2u7474J/u25SqPrIcboNrMjYApGVlmxjx6pM5sIGijgeZ7R1KGjjlNJn3x1GP/UV9I+rtOLhQRlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-10-28 um 1:11 p.m. schrieb Kent Russell:
> Since the unique_id is now obtained in amdgpu in smu_late_init,
> topology misses getting the value during KFD device initialization.
> To work around this, we use amdgpu_amdkfd_get_unique_id to get
> the unique_id at read time. Due to this, we can remove unique_id from
> the kfd_dev structure, since we only need it in the KFD node properties
> struct
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 2 --
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h     | 3 ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
>  3 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 14c3f148735b..50922ff2927b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -757,8 +757,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  
>  	kfd->hive_id = amdgpu_amdkfd_get_hive_id(kfd->kgd);
>  
> -	kfd->unique_id = amdgpu_amdkfd_get_unique_id(kfd->kgd);
> -
>  	kfd->noretry = amdgpu_amdkfd_get_noretry(kfd->kgd);
>  
>  	if (kfd_interrupt_init(kfd)) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index b7be5c5751b7..e2ebd5a1d4de 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -292,9 +292,6 @@ struct kfd_dev {
>  	/* xGMI */
>  	uint64_t hive_id;
>  
> -	/* UUID */
> -	uint64_t unique_id;
> -
>  	bool pci_atomic_requested;
>  
>  	/* Use IOMMU v2 flag */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3f2aa055c32c..a3fc23873819 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1340,7 +1340,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
>  		amdgpu_amdkfd_get_num_gws(dev->gpu->kgd) : 0;
>  	dev->node_props.num_cp_queues = get_cp_queues_num(dev->gpu->dqm);
> -	dev->node_props.unique_id = gpu->unique_id;
> +	dev->node_props.unique_id = amdgpu_amdkfd_get_unique_id(dev->gpu->kgd);
>  
>  	kfd_fill_mem_clk_max_info(dev);
>  	kfd_fill_iolink_non_crat_info(dev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
