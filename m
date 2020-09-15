Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB18C43461
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 22:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A13520B1F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 22:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="06qCVKYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A13520B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE2F66E913;
	Tue, 15 Sep 2020 22:34:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D00446E913
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 22:34:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ahg2AK6c6OP+BXUEwP+HRUUnxia6EG/lfZ/GMlspzYvKvOXbtyrpGOTz8PXqUnqNQHsGuWy5ALZ0jm2Qzu/sTlbiN0d5gj5mokEPDVvaSscq7VzSeCjMyXuoaFGNqG3KAJvT0gs8JN/mKwU2hpEX45fF8NzaAGrHyVZwi0ptVtQ/lApbH6b126QQPAbkAIMb5MDSDxJaZ9Jc6EH8gLMKFpTAM03QufsqSowNb4JAYB4eqdeyOSdHC+iAuqL8JsdQXYIQSQcBj9swOs9Q+vUlgfyfmvLjuKv8T8Ydsf7kJnbl+B5XF/XZyrZLX6ES1U73O+v+O2oq5ws1dk/863KWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7OAo15jB0zlYAy3razdCDRKFv1xrrk6xdFdK6idFv0=;
 b=fZxmfdoVQRkFsCyrdGge/a0yqdr0bh+DST/Cg4PCUECKlSxlxT5HrYtCP4W0TyQ/jvqTO5HYDlzx7iuZ10sPGzwmE14pS/I4b7FeICBf7D0zPeT7ju2iP6uvKUpLEw28GRxItkRm4pYBjDUx7ZnN1AL4vbcfHhrXZlNL1b9vWdBxZcw/ZauXwCLMNdRWfgjMduHKlIZ0C7O0aYQOyIwRCTuZPp8YuYKbPBNX8HNgSJ1fQP++797HyPolBeA/7bVOTj/ozV9H7URBMiNMGsrJo5k2YSRU5/apu+nhLj17d4CRT06qm7DDZQuxe/nGcI91BhlgaIxAxcV40gTkGC+lKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7OAo15jB0zlYAy3razdCDRKFv1xrrk6xdFdK6idFv0=;
 b=06qCVKYJ09cnLQ9QsHop4B06laVsF4/CjgabF1f4xg6OB7Vak4IVvi9wespi0Fi9G1xHSEWlm4OgTMGUbnr/UtWqr+PDX5TQGgUfUDspmn2UGryLG3DI8GOARnFxX820+R7+8Ru1EZWjKGHuwa2tW0y3taLCyOkAbuIsH/Bg/rA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2781.namprd12.prod.outlook.com (2603:10b6:805:67::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.19; Tue, 15 Sep
 2020 22:34:06 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 22:34:06 +0000
Subject: Re: [PATCH] drm/amdgpu: prevent double kfree ttm->sg
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200915215212.2669-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <fe6fafe2-0ff5-f36d-4cf3-57f17faeae5d@amd.com>
Date: Tue, 15 Sep 2020 18:34:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200915215212.2669-1-Philip.Yang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::17) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YT1PR01CA0078.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Tue, 15 Sep 2020 22:34:05 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f496e4d-c1b3-4421-9081-08d859c77479
X-MS-TrafficTypeDiagnostic: SN6PR12MB2781:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2781885A116809A750488F8892200@SN6PR12MB2781.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zJz/bnfmMpq1tZ3whmw8yzV7+B+uEo1Cvh04OEavpiR6W5PApk8NqnbmGozoh5MxYy6fiHpL/D9dJh+cDfbROSD2LkQNs4Z+CE8SeXnbLa7tsyyGfy+MMH+WoMu3MRa/82DQBDOfSXiSAT6WFJ5+pBg8ThuYv2P3W/qlCbmlJ8DKl9C4W06lwHe2SYCpVL96jsx4h9ImQcszCYeN31JlL+AmHTBOjZ38r6Nul8fq/eZrnWfq2mgkcMkG5Z4eN0A7uzKciiYhd4UcGdgsh7AaPEA62NLs8K6cC8xRpLz7Fi6go/1kpyljjqdRp9KwzHRq7QIUu7Lov0ZION8ZfnViAfhHmEjKiTBLWdAYeRqXU6TdYtjTgsrji8DYimFUOO2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(52116002)(36756003)(66946007)(2616005)(26005)(8936002)(956004)(44832011)(186003)(66556008)(66476007)(2906002)(478600001)(16576012)(31686004)(6486002)(5660300002)(8676002)(31696002)(45080400002)(316002)(86362001)(16526019)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: F0FZnkVoRMXtsfv90Bvy+hCCWoPnIOR5LqqfdAYl4r/nS8K8caZL+qFSH5/eqoH6GvGiR6C48SrJhJ7GL9KmZR/J4cioeET/EnPMuQINo/KYFVTIcHUvkYvYT//EY8YmVr1GgtJcXr//D5d4ogsvHkG7AIr1P1lMsTSRxVZQd53w0vB/0mGR7se0IgklL5jclVr5LvpMWO6WYfr7RtwrckYhy22x43TfhEK3G/BXDjtaPOgRdNEllHnG3brznItAL7u/ux3+I5LTs5LTLORhYwsYIWopwkxke5DKCKm9CTRpZqLbdmF6TEtk9pE/527FPDtvn2pu3epc2PR755qjZESl0knawLUOztbWAVwE7MziRYr5OGNv7AuXeEawT98ClR0+JCRGfCTRh84T5p2OWHTqx7lEBEHrsNLN2ke1GDeYLs9QtZVoPqdBd1qxvj/dUOv9KyVVoD5o8zO/2bc1RPUXX4b6Scneij+RsmXJZ5oSfvIkcH6TJlGo/31NZ47jIR0FfZBdgrqzAIHWgWD5VVSffNaZIckKo+f7Fb6WOYoRZDD1JNoBiT8+wmtpv+/q+vvHik6R/rlkobu5icEdb4Has4oHapQvDTxLFqqnKy6pCJQJIEjfM6sbVUErmgmfLvNFP5Ycr+Owr1Yi0VB4IQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f496e4d-c1b3-4421-9081-08d859c77479
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 22:34:06.2391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7vtywWtgpaWDl2Lp9bRVKHMvkZXhLhyHo8n4Rm259oGGpExl0e/f0lCszzhHoD4iY2RSby24SAl2RA6yXDlyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2781
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

Am 2020-09-15 um 5:52 p.m. schrieb Philip Yang:
> Set ttm->sg to NULL after kfree, to avoid memory corruption backtrace:
>
> [  420.932812] kernel BUG at
> /build/linux-do9eLF/linux-4.15.0/mm/slub.c:295!
> [  420.934182] invalid opcode: 0000 [#1] SMP NOPTI
> [  420.935445] Modules linked in: xt_conntrack ipt_MASQUERADE
> [  420.951332] Hardware name: Dell Inc. PowerEdge R7525/0PYVT1, BIOS
> 1.5.4 07/09/2020
> [  420.952887] RIP: 0010:__slab_free+0x180/0x2d0
> [  420.954419] RSP: 0018:ffffbe426291fa60 EFLAGS: 00010246
> [  420.955963] RAX: ffff9e29263e9c30 RBX: ffff9e29263e9c30 RCX:
> 000000018100004b
> [  420.957512] RDX: ffff9e29263e9c30 RSI: fffff3d33e98fa40 RDI:
> ffff9e297e407a80
> [  420.959055] RBP: ffffbe426291fb00 R08: 0000000000000001 R09:
> ffffffffc0d39ade
> [  420.960587] R10: ffffbe426291fb20 R11: ffff9e49ffdd4000 R12:
> ffff9e297e407a80
> [  420.962105] R13: fffff3d33e98fa40 R14: ffff9e29263e9c30 R15:
> ffff9e2954464fd8
> [  420.963611] FS:  00007fa2ea097780(0000) GS:ffff9e297e840000(0000)
> knlGS:0000000000000000
> [  420.965144] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  420.966663] CR2: 00007f16bfffefb8 CR3: 0000001ff0c62000 CR4:
> 0000000000340ee0
> [  420.968193] Call Trace:
> [  420.969703]  ? __page_cache_release+0x3c/0x220
> [  420.971294]  ? amdgpu_ttm_tt_unpopulate+0x5e/0x80 [amdgpu]
> [  420.972789]  kfree+0x168/0x180
> [  420.974353]  ? amdgpu_ttm_tt_set_user_pages+0x64/0xc0 [amdgpu]
> [  420.975850]  ? kfree+0x168/0x180
> [  420.977403]  amdgpu_ttm_tt_unpopulate+0x5e/0x80 [amdgpu]
> [  420.978888]  ttm_tt_unpopulate.part.10+0x53/0x60 [amdttm]
> [  420.980357]  ttm_tt_destroy.part.11+0x4f/0x60 [amdttm]
> [  420.981814]  ttm_tt_destroy+0x13/0x20 [amdttm]
> [  420.983273]  ttm_bo_cleanup_memtype_use+0x36/0x80 [amdttm]
> [  420.984725]  ttm_bo_release+0x1c9/0x360 [amdttm]
> [  420.986167]  amdttm_bo_put+0x24/0x30 [amdttm]
> [  420.987663]  amdgpu_bo_unref+0x1e/0x30 [amdgpu]
> [  420.989165]  amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x9ca/0xb10
> [amdgpu]
> [  420.990666]  kfd_ioctl_alloc_memory_of_gpu+0xef/0x2c0 [amdgpu]
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 8b704451a18c..4b3ab9a25e91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1076,6 +1076,7 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
>  
>  release_sg:
>  	kfree(ttm->sg);
> +	ttm->sg = NULL;
>  	return r;
>  }
>  
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
