Return-Path: <SRS0=J5eG=D2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBE5C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2020 16:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D2321D81
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2020 16:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2ngJbmnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D2321D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C4D66EA0A;
	Mon, 19 Oct 2020 16:22:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C06126EA0A
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2020 16:22:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyEMyqhIjOv9o++gX/OS4V4NT+MTfPr3KmGWTZuVPipV2JVwpcPwbxmEVmh9Vri/l3vShSeckN+tpntxc+lEZmelysjbArEQ1IeNyIUyvBn4iPfJiZB9zPoltqpEDSaG/6kBLqvY0yJ9AFJbiON5QjCOUN6cfxbjLARWzv0SvVioWck3XZHPQFUhJwcP0c94sDoJZuitDs8qJX9tyMfOfrn1r4YcVF9H3Ybq7haPWYBBJv+Sq7G/QPnnUxSVk0KQXnIf8g0zxJmdXdyODcu/uQWBj2Siar6npWn3m6+aHe/4Qu3izCubH9jAuF48R18Wrvv6p5d8pf+ougnQgIQ9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYOh1WZ0w3Doteymc39ee8jB6vDmSbjyiWJyjKxY6Rg=;
 b=O/PSwsSzmr08mHV03t9M7Sco5ceMgZZMDBSbaB6gy7Fueshe1Xli1g9s6wI1ywk1E5Xqm9NYM0mfpFPa//uZuPSUsTMhRKWrSGDeJXTB2jBuNKBZRvqKAE+3qHpLppG03kgy+/l4pY9ASgYmSW8ZYLfsDYhOPkDMcUCcHPkjfuCwC61WiTphvKBxjvFAjs/bVQVo2432MIsjdEBjVK6D257r8yDXSTROVG7j7ahse2uh1SSFZrV/GyIMxPdGA/kGZCPvHAojaJ+sT/hxke8S5GkqsJLr8nG9ARFcJ6nIzaVtsU6Wi5sgdRlou0csg+KGmYMlYtLrASHjo5sWy1BHCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYOh1WZ0w3Doteymc39ee8jB6vDmSbjyiWJyjKxY6Rg=;
 b=2ngJbmnj3aKZA/pMywgHyX7VHdwuABfBFa2/wnQW0K7FUmXJj9iBS6XZte0+Qm2ILGaWTbnevz7op/1hwY6bjKzuci0Rd7mz9Hz44LHhkWvNKmr4zXAl3sVMqDqxIfdyfep5Prz4vLr8Hjbj+FABUXJDjlYUMk7FKA61D44KtpE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4962.namprd12.prod.outlook.com (2603:10b6:208:17e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Mon, 19 Oct
 2020 16:22:45 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 16:22:45 +0000
Subject: Re: [PATCH] drm/amdkfd: Use same SQ prefetch setting as amdgpu
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201019140221.5840-1-jay.cornwall@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <dfdf17d2-a388-1f3e-9ae0-597caf7a5f25@amd.com>
Date: Mon, 19 Oct 2020 12:22:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201019140221.5840-1-jay.cornwall@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.113.11]
X-ClientProxiedBy: YT1PR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::35)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YT1PR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Mon, 19 Oct 2020 16:22:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 75f98d75-721f-4802-b95d-08d8744b361c
X-MS-TrafficTypeDiagnostic: BL0PR12MB4962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4962566A1B0FF0316404A8EA921E0@BL0PR12MB4962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgzSwj30y1m3RPnrg6ulSpRkl4McWc1ZfNy1G6jRRFGR4FysC1HpqxnPcvJvBjwh6sA+99N0hfSyDo3FOESZxfYtJlOJCpf7GEQrb15CoI93iF66H2Zzel5AY0dAUkySdo7I1rTFKFisgbeJkYhP8TCZ9ZyZ8pRJUqsAPG6IVq2ZKj3PY/M3D41cm24Pc5f/HbAcDpInKDG1xLCNudQHITdj3MTS8BawbIpg87piNe5oZnb7tU+Ml2/JiKV9Iy94KR39CYf72YsEDv9do4nzFIEHMD+1uJRH9D9fbAHm95vm9Hw984RWTvTggo04RntKurtxi+h4v+xZvESjw+VPs/I5fOwfedvYgr17FiI51xTCl3fyHRc04r5UnzP8vBtt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(52116002)(66946007)(8936002)(5660300002)(83380400001)(478600001)(66556008)(66476007)(86362001)(186003)(44832011)(316002)(8676002)(16576012)(31686004)(956004)(2616005)(6486002)(36756003)(2906002)(31696002)(4001150100001)(16526019)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZqJm4KZvE2fFplewqJsO4onsflo8HtaMhBUO49YzOHd+Uai9hcVOOeCk5zEKtBvKHKrfpn8sIMiZHpDISP0qgl2fl0bQ8OXyHfjNB8vSm/RTn96NZ76qVelyygFjz5xau5FsLXNBhR+m+PMiNptRivWe2Q+EjD0og/OJz7BAL/3AR6HpxspncnKo9/OgTJClAPIO4ifnbN9n0NnIlibjEt3d21skGaikNOQ3Z7s7eUsJVL46fidZDYAj5PvaNTRDVwuvkv8s2lODXZDE2h7dsFAShUsUabtTU2iqLK0PwxC9lLIUdoJpC8li4YqjUgSXij1DBDBBEImhkoA2jtwHeK97evuFQrDkwxhPuk1+zkB1C23sR76uPAKy3XVDtd0C5W4AaGJ2X4zMxFSc0FbUhmDE8F5151//1wo9NXBEFV3Xi3V5t9z0jZsIocMLQuDAxbdV9j2PbJPwElwezmn389INHl8Kvjc7EFSf3sYVUHAbJf3iHaJvQTOecdj0Dl1UmcKfcnBA4YNb54BptdLsrjwkMuBvX2mIvpuFAMN7U5tYOIeJ62AibLhd2LcQh4XLi+GeBa/XbiR7CiE0YnJHDoSkHTQHb/qH0i3U9C39HIejyQZyNHGmbEd9cNwaLL1+BKAb48+kIok/jNzHwMWCHQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f98d75-721f-4802-b95d-08d8744b361c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 16:22:45.3918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MwmHHIU6ZohQViXcYy5M+aIsv+MJobSTrjd1IhTV9i3ChDwFw1sVIpptjUFpvs6MD0bxYnTOzzoVAUQNrt6SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4962
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

Am 2020-10-19 um 10:02 a.m. schrieb Jay Cornwall:
> 0 causes instruction fetch stall at cache line boundary under some
> conditions on Navi10. A non-zero prefetch is the preferred default
> in any case.
>
> Fixes soft hang in Luxmark.
>
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
> index 72e4d61ac752..ad0593342333 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
> @@ -58,8 +58,9 @@ static int update_qpd_v10(struct device_queue_manager *dqm,
>  	/* check if sh_mem_config register already configured */
>  	if (qpd->sh_mem_config == 0) {
>  		qpd->sh_mem_config =
> -				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
> -					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
> +			(SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
> +				SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
> +			(3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT);
>  #if 0
>  		/* TODO:
>  		 *    This shouldn't be an issue with Navi10.  Verify.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
