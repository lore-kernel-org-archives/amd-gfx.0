Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE4EC43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 23:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 036D720714
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 23:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VMdRtMxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036D720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6566E22D;
	Thu, 26 Mar 2020 23:17:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E286E22D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 23:17:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUqaRgkfpEsFuwtmBNKRPArqStpSZPx45t8mA8iNvo8hGYE/LCddgw83Xgu72GPvHZ9XXte3fRfTXd9d+UhmjLTG+xv4iQdXFm00CeM9HiFr/NX0cFJlVRmz/8PclDheFTsDx6KRQxgTDDFU/ogRYprXPsMSBqtLooFhZwAcTz0KZ6wm7Zhq6Ln5kKz2/RDYMoM9yol3gG/6sH9XYGVjTnZWPG+dtkV+9IO3XVtg4qvC2JwAHKzv2Adt1pl7Zpu7YyPV0Khpeh6xlKbFlFiZo23qL/fJ9+KC3GsuhVLWpK4YGfGM+d+b+nYiNTXGc4Rk9DYX+X1aXei2dXXXomHVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PN7ZrwqRFPWzDh4BJSA3Jut/jBEpMavLvHVe60gam4=;
 b=FXm7FzUDXBYudsn552qO8JkaH5BKJ+EBM8oFGCVxVTH5u9aaaaoUbT8QW1nm9fJ28zualKfF7VCBXlcMjRQysHvAxZJGxIfftaxAckBh3EUluvIkvKVMqaFRUmNi1UiGM7gJg56ZeBbGssQf31HqA/+iC/oQGQIf7KrAusV5E8lrio81+BBfkFMe0V52A8fJYqfUMvQC7H5jCJBTgFXSwPt+6RAlcAkbGyTbX56fzMdc+DURyoSgdK+V2t6+MbdUVaUr5lha0VALDpcTanXFProC+RGhg4UYG9qL1BRcywwv4ZVFKELdfj0S8StUs0Wp2zdQpP8SpKfYK4hDuqC0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PN7ZrwqRFPWzDh4BJSA3Jut/jBEpMavLvHVe60gam4=;
 b=VMdRtMxkcIpTscmbFAbRj7CIwvNh6chXweMM3VmEMyYQdC71uA7nrbKJssm4/45ZACA+NvcrlPpe+quA85HOBYVnr1K/iVLUedNf2xKXcDlIy767z8dgBC0VlAJsW/q79g96Iiwy7hRL1LYggVUDmPjbUENU3FNmsjtjhOYeFA4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 23:17:55 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 23:17:55 +0000
Subject: Re: [PATCH v2 4/4] drm/amdgpu: Add a UAPI flag for user to call
 mem_sync
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1585252968-1218-1-git-send-email-andrey.grodzovsky@amd.com>
 <1585252968-1218-5-git-send-email-andrey.grodzovsky@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <56039ad5-32f0-6c70-992f-07e7cad7a4af@amd.com>
Date: Thu, 26 Mar 2020 19:17:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <1585252968-1218-5-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::19)
 To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (108.162.131.176) by
 YT1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18 via Frontend Transport; Thu, 26 Mar 2020 23:17:54 +0000
X-Originating-IP: [108.162.131.176]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c18c70bb-a0fd-4a64-b28b-08d7d1dbe9c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4201:|DM6PR12MB4201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42019845ED7A00EB1CDC236F99CF0@DM6PR12MB4201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(66946007)(66556008)(66476007)(26005)(53546011)(36756003)(55236004)(81156014)(6486002)(8676002)(8936002)(5660300002)(478600001)(81166006)(16576012)(186003)(316002)(86362001)(44832011)(31686004)(956004)(2616005)(2906002)(4326008)(16526019)(52116002)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4201;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rk1n1cC2ahoYJBO3i1dFDh4WMSEIfHwLySICZsQHFV6rxUYTxYFlOufThmU7lT+FqWypjSqRhz6Nv5PatLuALXnLIwuFZVjHQgeZoimtjaV0ehKVehiaRLoAXEEOndteIAnBGdDoRiHSuzjuThIz+uic5/lr6n97H0bKYQrN1TQvHdKFTSGloAFBCEn25RwBgfu5ia12VdiMtNEOBv3nKi30TbXwywR998mo2zUjaQ1Q8cu+8QO2rxNemHGbr5s2UI7pmITDNWjM+FcxjUZxWiqN/Ma2mWCcFW4gcW4sTUzYCOTBUQTt1bdnyr5BvdFhYh4IlZGvnFvY9DTAzYwtCS1HUJx1tXlgzjoEehP03xr3EubNL1UAVuyiAjvNUo6vJ28iCHAn0za/xWRcMybMD+lWgIqx6v5L2Zk6+Ya5ydFRPHhU62UcUY8R5xsPEz3j
X-MS-Exchange-AntiSpam-MessageData: S+EOcIJ1ktDZP7dEITHMtydE3YQgl38q90pule2NCHUrVwxmel6pRG4GyHWbAXcJKZ+hjNZrnuFQHh9J7rIdtJqkuhjqY/ARvpQGIxonAqi529tZzay6Y/gHq2jl1YKI7g7tEQ7jJP19SeqGtbOMQg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18c70bb-a0fd-4a64-b28b-08d7d1dbe9c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 23:17:54.9180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVznHMXIHDkElxzWjUxn3FI2o1b900Fj/lQ6EZLQp5DjKaInwUNfCEKD4TpWGkwV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
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
Cc: alexdeucher@gmail.com, ckoenig.leichtzumerken@gmail.com,
 Marek.Olsak@amd.com, Ken.Qiao@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-03-26 16:02, Andrey Grodzovsky wrote:
> This flag used to avoid calling mem_sync without need.

The title of this patch means that the flag is an "enabler" flag,
i.e. when present, it enables something to happen (flush caches).

While the description text in the commit implies that the flag is
a "disabler" flag--i.e. when present, it, quote "avoids"
mem sync, "without need".

I'd much rather the commit text simply expound on the title
of the commit, something like:

"When this flag is set in the CS IB flags, it causes
a memory cache flush of the GFX." or something to that effect.

With that fixed, series is Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

> 
> v2:
> Move new flag to drm_amdgpu_cs_chunk_ib.flags
> Bump up UAPI version
> Remove condition on job != null to emit mem_sync
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 3 +++
>  include/uapi/drm/amdgpu_drm.h           | 4 ++++
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 28bb840..f18d974 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -85,9 +85,10 @@
>   * - 3.34.0 - Non-DC can flip correctly between buffers with different pitches
>   * - 3.35.0 - Add drm_amdgpu_info_device::tcc_disabled_mask
>   * - 3.36.0 - Allow reading more status registers on si/cik
> + * - 3.37.0 - Add AMDGPU_IB_FLAG_EMIT_MEM_SYNC
>   */
>  #define KMS_DRIVER_MAJOR	3
> -#define KMS_DRIVER_MINOR	36
> +#define KMS_DRIVER_MINOR	37
>  #define KMS_DRIVER_PATCHLEVEL	0
>  
>  int amdgpu_vram_limit = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index bece01f..a8aa787 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -182,6 +182,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>  		dma_fence_put(tmp);
>  	}
>  
> +	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
> +		ring->funcs->emit_mem_sync(ring);
> +
>  	if (ring->funcs->insert_start)
>  		ring->funcs->insert_start(ring);
>  
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index cfbec27..5f7a4f5 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -601,6 +601,10 @@ union drm_amdgpu_cs {
>   */
>  #define AMDGPU_IB_FLAGS_SECURE  (1 << 5)
>  
> +/* Tell KMD to flush and invalidate caches
> + */
> +#define AMDGPU_IB_FLAG_EMIT_MEM_SYNC  (1 << 6)
> +
>  struct drm_amdgpu_cs_chunk_ib {
>  	__u32 _pad;
>  	/** AMDGPU_IB_FLAG_* */
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
