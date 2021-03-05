Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AC0C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 03:44:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0351B65009
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 03:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0351B65009
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D7216EACC;
	Fri,  5 Mar 2021 03:44:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD8956EACC
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 03:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0E7ODL5BDn15pbyrTACiI+/EuEo2Zzb7zsjzuGUQTjVHzpGQx/4LizmAjDp2pjKTfz3Hm6mIQADi5bFbgknbabDVmDpPE3mg2lQRLj/5bzPBh2yYimQclu8hqjv33aCUVrmw9A3eaWxmc/4qJtIFN2BlbTcmUclXiFqwqKJdhCk4oO48aXi0gG0VcpGOaLm+0i5rplQ5SkEaL33+IW5G4ee8C2V2Zqpqzgn5HOvyIYx6DBiCaXn6aTtmvaz4RCSRSBCR+FW+56/rHb8Mg2E+0obInb5fKIo1cRP1VwMHGDhY4qwhBh+uv2Jk8jMypFW6ZQoWtPBuZrRbS9et7bfYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hW8tecc7CHBt9qqWdLICxg7bpmm6XHMPzCQVz2DF5gU=;
 b=YW2SdmcPASxtH9s4v+7ET7kahQCWaAG/zqb6ckB4dyc9s27UD6Lkxu/Qzb9NVsKZ4G4BEzfLG9o3TvKv3SUSVd8kb89gGYAOEfSJkY3T8gFOTtA9AbpBOPiehYvfxQX/xpb9tV7UpLBY4TrEXHrpJhtHgdDFisuGWo1MbcQl9fI3rMEYQkg2W6tN+QCKM1fZjB4+zL7y4MPwqz1TQOMjPQ8d4BkFq+9ssE28abDYW45FzKTNfBfbbfI+ndpdrmV3ZsuCR2Qtv2EfX5YNfV0nQjmrS21Pc4TaD72urcCYy95uebQR/8V4HyPcIBpHWHzADmD6r1diwGHhTjkdc9EXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hW8tecc7CHBt9qqWdLICxg7bpmm6XHMPzCQVz2DF5gU=;
 b=MuLH4WGS5Da1gdfIPmSSqQrfNLWZink4Rb8jQoD38Y8o9IuYZQRrOwvGgJHnlzz5aIxGcFA/EJUPWkwa0AK4TWov8b04NNuwPYOxeOcBbf51D9FtV4oKlauUm0EugXRNj8KbAOYPH/EjYTUWHkKcp9pcE91WKkDV9deIYbBcDU0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4565.namprd12.prod.outlook.com (2603:10b6:208:26b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Fri, 5 Mar
 2021 03:44:48 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%9]) with mapi id 15.20.3784.030; Fri, 5 Mar 2021
 03:44:48 +0000
Subject: Re: [PATCH] drm/amdkfd: Move set_trap_handler out of dqm->ops
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210305031254.13597-1-jay.cornwall@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a7fe659f-016b-beac-ad23-58aa30ac7a69@amd.com>
Date: Thu, 4 Mar 2021 22:44:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210305031254.13597-1-jay.cornwall@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YTOPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::40) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YTOPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.24 via Frontend
 Transport; Fri, 5 Mar 2021 03:44:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 552a2216-abe6-4356-71c8-08d8df89065a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4565:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4565DB8207CA15A76B2B363B92969@MN2PR12MB4565.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OPOQ2qNE5SxO34WuCi6+YHDBP/Q7tfirHAVMVM+dbXB6weqDaHZVVGiZ8gmmHLUUA3nxA2ypQ3+bDyGnYj7wetlWVfasvSYk4EvW+2GsvLVbFmiXYORxhrubRNkBZyDeV4Zv5W/viT/nZW0tu0K7xlivJOgzbOK/jEcXQteO38r7YRL/fLnipbcGU+6qGOg1XuftimzsEIz8tO+XQcVzc/hn1cgv6kVCNOywaqpMkmzByoaJbvu6VCTuxef71yQMCxenYnrqHuCq4qNX3eXsBKKfEeUTDX1UhWEGR6/fv7kM56NFftGNwSJqcm5lDLS3ADsceZLIzvBoKU1keJJc4pEYOufB6YawlN+hA+sqhrwQya3ZoBE1+1WMnNAYT7bCk4UpUe9CUOxVdXOtVPSLLLJjiGUQeFuOz2zwjVw/w9o4+cmxxndWtYXt7P3cyl+uRsm6Ey4XX8L5DyvL0jA/okBeiAWeZusvYTNKWD2HSpyXl1VwSimIb1YHgWb1/U1PyLRcH/Ak3UE4rBnkjnZAuNIu78rhtPj92XmlRub6/43hcnOZ+Dp9VEwwZMxpO2eyQTCDun7MhpbTbUCC0DyvB0cj3UEIxSD77tVBDqilaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(316002)(31696002)(44832011)(6486002)(31686004)(186003)(478600001)(83380400001)(86362001)(36756003)(16526019)(66476007)(66556008)(2906002)(66946007)(5660300002)(956004)(2616005)(16576012)(26005)(8676002)(52116002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R3BRUUgzNnhSNW5scncrdFhGNzRoSzlVUWhlY1lscTJqSGJ1SHYrK1RsUlFy?=
 =?utf-8?B?L1lBcm14QVYxM2Jvdk1WaElxTC8valZmMjJISDdXNldiRWtBVHhYdStHOGRw?=
 =?utf-8?B?U2oxTzZnK3dtcUhyQjJLd1I1dnZJQmx5OURjWmRENjZ1eUwzbFFqRWR4TGlU?=
 =?utf-8?B?VCtQL2V2eFBZNE05aGRZWG1Wa2RpbndNcUE1ZXRTaVY2eVpmWFFXOEs3Tm01?=
 =?utf-8?B?Tlg5bEtXS1NzS2xDV3NyYnN2SnpwNENZb0FIR3k4dTlac0tCeHFKWG84bTBL?=
 =?utf-8?B?eVRGT1lvS05yc0NncUNVUWZidnFkZ2UrUDFGTFZNSkpaVnNYQVhnaXBvTXg3?=
 =?utf-8?B?MEQ0TGxJcjdnd1BWYnZ0OWpVYW1nekpaMjk5OXU1MW1HSndUMUdtWjFVU28z?=
 =?utf-8?B?bnNpcy9HeVJTS2pVNDEybk1OTGlnK0lSZ0twN2R6WjhzZi9rVlRMdUZnbjBO?=
 =?utf-8?B?ZVA5NEQ1Y0UwNEVPRWxBL1ZtbW4zdnhKTXliZjhVNWRoYlc3cFdLK3lvQW9s?=
 =?utf-8?B?S0QzOUN6TjhmQjIyODJkTzZwOGdHV1dBaDYxN0xoZ29rQzROYU9BMUVYeG5L?=
 =?utf-8?B?cWhLa1dYT0MzUmlEbUFhSjh5N3NpUkllbnppSjd6U2lib1dzVHkyRkNuazhr?=
 =?utf-8?B?SUErVzRkUUdPeG1ONlJUbW1tUUFsVGNoME82aXJqaFJrbi9Cdzl3OTlHYmxY?=
 =?utf-8?B?V2t1WjZHbUtyZ09SbldBUzA3Z3Rla1B0U25WMERNODM5dGN3RmZwa08wa1ZU?=
 =?utf-8?B?bWFiZlQydStqdlBSV2gwZG1qTFBZNDZ2R2ZXYk9EajdwZW45S1BmVzQva1FF?=
 =?utf-8?B?V25QM0NRWTM3SUxPMytHMkQyZmRGTVhodFJCZ1gwYkFtK0s5QVBwaVh1aXhj?=
 =?utf-8?B?dnIzcGlzTHJqKzQ1dDM4WnltSmtQemM0ckxxd2Z5VHF6SVN5Y0FTT3dPRGFo?=
 =?utf-8?B?eGVQWXg2VVhrS2NrWVFEcHVHZGNhcTh5M1JDZWphMFJOc05NbHBvc2R5TVpt?=
 =?utf-8?B?dWUvT1ZUVEJsUmNJY2RIcVFWa1BFTFBielpJekRaSFp0Si9qMm9jU0k3cnRE?=
 =?utf-8?B?VzVIYnBvZ3BwUWs1bmduTjlXMmtBVllmcWhROTFEdkFsbFN2MFpqblRXVWM4?=
 =?utf-8?B?bWpLdUhVYU4vcFhiTzErdUJPbFo5RE90Rmx0K3h4L1pLelY2YkVWRmJjeEpW?=
 =?utf-8?B?WlBnQndVZExNcGUwRXNTNjlrSFRCNGM1V0pERzJOZFZ2WDVPdVNzQWdncG1t?=
 =?utf-8?B?aVZoWHg5N2RNeGFpZXdsbTVVYVAzOFF4Q1JFV1JZZUxOdTdtTkJDTWZCQmJK?=
 =?utf-8?B?L3VORDJQVmx0MWtiM1FBK0R0NWF6NEcxcENVZnA2d3l4NTRSeGZ6b1ZDL2gr?=
 =?utf-8?B?R0ZPenVqT0JlN0JMOWl6TW9FZCtlUEcrci9Rdm40STJMUXcxZnRxNEoxeldL?=
 =?utf-8?B?aHo3bHZrQkRBKzF2SW5BTlVrV3Btekhqa0pGNnJRTXd4TktPd1RSRTdmd1dB?=
 =?utf-8?B?a0xlOVpBaldpUFpWSjdUdjMvRTRIaHhDN0p0K1dnMnF0OGRLWmdkVE9lNExO?=
 =?utf-8?B?SnNCK2Q1WFZ4TXY2TUU5ZFpXVnVkREgveTlOQ3NiV0cxQm5TOEJWMzM0SlBm?=
 =?utf-8?B?dkkzRGRoa1BTcmVrWVZ6ekZOaGpXc3JPNk1tU1luZTl2YWNTZ0tLeVc0WlFB?=
 =?utf-8?B?U3ZoNENqK3R4NS9JVEJaOHJRbzF1ZXh1VXBvekNFZmZ2QVNLQ0RyOWtRRFpU?=
 =?utf-8?B?RUpDbGN6RkQ3RkR2TVozR3U0Wmt4SEQ1a2VZZ29UV0dwZ0M0SzJ6UGl3dWJU?=
 =?utf-8?B?RW1UVDNwTHZKeTRtVmF2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552a2216-abe6-4356-71c8-08d8df89065a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 03:44:48.5538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOE7PiVSrAoIdVp27Q/7kAZcyy12DDDR6T0Cd+VKP+bf/Ox6HGU22mTmknpJ3SwrG0cJ9bSnS86rkNIwC9B7rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4565
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

Am 2021-03-04 um 10:12 p.m. schrieb Jay Cornwall:
> Trap handler is set per-process per-device and is unrelated
> to queue management.
>
> Move implementation closer to TMA setup code.
>
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  6 +----
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 22 -------------------
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h |  5 -----
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  4 ++++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 19 ++++++++++++++++
>  5 files changed, 24 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 8cc51cec988a..6802c616e10e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -556,11 +556,7 @@ static int kfd_ioctl_set_trap_handler(struct file *filep,
>  		goto out;
>  	}
>  
> -	if (dev->dqm->ops.set_trap_handler(dev->dqm,
> -					&pdd->qpd,
> -					args->tba_addr,
> -					args->tma_addr))
> -		err = -EINVAL;
> +	kfd_process_set_trap_handler(&pdd->qpd, args->tba_addr, args->tma_addr);
>  
>  out:
>  	mutex_unlock(&p->mutex);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index c37e9c4b1fb4..6bb778f24441 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1596,26 +1596,6 @@ static bool set_cache_memory_policy(struct device_queue_manager *dqm,
>  	return retval;
>  }
>  
> -static int set_trap_handler(struct device_queue_manager *dqm,
> -				struct qcm_process_device *qpd,
> -				uint64_t tba_addr,
> -				uint64_t tma_addr)
> -{
> -	uint64_t *tma;
> -
> -	if (dqm->dev->cwsr_enabled) {
> -		/* Jump from CWSR trap handler to user trap */
> -		tma = (uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
> -		tma[0] = tba_addr;
> -		tma[1] = tma_addr;
> -	} else {
> -		qpd->tba_addr = tba_addr;
> -		qpd->tma_addr = tma_addr;
> -	}
> -
> -	return 0;
> -}
> -
>  static int process_termination_nocpsch(struct device_queue_manager *dqm,
>  		struct qcm_process_device *qpd)
>  {
> @@ -1859,7 +1839,6 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
>  		dqm->ops.create_kernel_queue = create_kernel_queue_cpsch;
>  		dqm->ops.destroy_kernel_queue = destroy_kernel_queue_cpsch;
>  		dqm->ops.set_cache_memory_policy = set_cache_memory_policy;
> -		dqm->ops.set_trap_handler = set_trap_handler;
>  		dqm->ops.process_termination = process_termination_cpsch;
>  		dqm->ops.evict_process_queues = evict_process_queues_cpsch;
>  		dqm->ops.restore_process_queues = restore_process_queues_cpsch;
> @@ -1878,7 +1857,6 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
>  		dqm->ops.initialize = initialize_nocpsch;
>  		dqm->ops.uninitialize = uninitialize;
>  		dqm->ops.set_cache_memory_policy = set_cache_memory_policy;
> -		dqm->ops.set_trap_handler = set_trap_handler;
>  		dqm->ops.process_termination = process_termination_nocpsch;
>  		dqm->ops.evict_process_queues = evict_process_queues_nocpsch;
>  		dqm->ops.restore_process_queues =
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 16262e5d93f5..aee033b1d148 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -121,11 +121,6 @@ struct device_queue_manager_ops {
>  					   void __user *alternate_aperture_base,
>  					   uint64_t alternate_aperture_size);
>  
> -	int	(*set_trap_handler)(struct device_queue_manager *dqm,
> -				    struct qcm_process_device *qpd,
> -				    uint64_t tba_addr,
> -				    uint64_t tma_addr);
> -
>  	int (*process_termination)(struct device_queue_manager *dqm,
>  			struct qcm_process_device *qpd);
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index e2ebd5a1d4de..8f839154bf1f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -944,6 +944,10 @@ bool interrupt_is_wanted(struct kfd_dev *dev,
>  /* amdkfd Apertures */
>  int kfd_init_apertures(struct kfd_process *process);
>  
> +void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
> +				  uint64_t tba_addr,
> +				  uint64_t tma_addr);
> +
>  /* Queue Context Management */
>  int init_queue(struct queue **q, const struct queue_properties *properties);
>  void uninit_queue(struct queue *q);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index a4d7682289bb..ff3e76450b66 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1162,6 +1162,25 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>  	return 0;
>  }
>  
> +void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
> +				  uint64_t tba_addr,
> +				  uint64_t tma_addr)
> +{
> +	if (qpd->cwsr_kaddr) {
> +		/* KFD trap handler is bound, record as second-level TBA/TMA
> +		 * in first-level TMA. First-level trap will jump to second.
> +		 */
> +		uint64_t *tma =
> +			(uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
> +		tma[0] = tba_addr;
> +		tma[1] = tma_addr;
> +	} else {
> +		/* No trap handler bound, bind as first-level TBA/TMA. */
> +		qpd->tba_addr = tba_addr;
> +		qpd->tma_addr = tma_addr;
> +	}
> +}
> +
>  /*
>   * On return the kfd_process is fully operational and will be freed when the
>   * mm is released
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
