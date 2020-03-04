Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A64C3F2CE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 22:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4D920842
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 22:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a1BSAvqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4D920842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 325EB6E129;
	Wed,  4 Mar 2020 22:32:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A13E6E129
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 22:32:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeDR9lkZvodrVnoPO1TX0bEdDmLe9bWvRU8K/vtDlpFJkoATrNw98VsE7Z4jcTrsbwDyZWcglgPf/y3svdDIOEejisuazvF37DDL74zed1w1po6q5w6gTGY7H73JqrYW0y/3hZZ9xmYvXqklHp9/6nGqBbyfVeONusojWQnonHiBrr27fGwp0ZEY3s2lqc87/VZk9525a/UseKve+OLs/vtI0uy3sXjhWd4lkcsn6u7IFthsRGw/ZM7Q5UHP17zjWr2R1vDNieIqvHGoGMM1M+adlx920BObnbqEbViDolJFv6N9HT1v5WwH1IaFntdOmj/CLFfsWlRM5/UIQHzcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIE9hIfA5UbwtYldWh+1xbhPxxt2D+8q1lpIxttKbp0=;
 b=QaZp/Ka3XxSZh7RQI7wiu6HarsCQonN1vuLRinHP2avtIBETFcxh4IFggvlAgmlQ3rfxbtvqM+HioRIPbdA8dE8/DvQCqM2KYoJjMEGyjCA7XdSOrwONRQapLx+Oy3J6rf5tAs3fP/C1bVyajV+UU1bYeMFiM72CfZ/1oeBTKnIl+L9r2t9bg3hS3c/RXwtVQBE0z0wWCQs4Vrf/VC5IGqGoYY/JL72PP5nfj0ktcBWXHSoTSBCQYENBjuGSQ9Ds1LP/NUU9ONs8zs/WUG5zHAt45hES6xNtte/QIcWLj9FXfxxPLYy2I+ZNBfez4M2v/puYg44ZJQ4EvP9G1s0Ntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIE9hIfA5UbwtYldWh+1xbhPxxt2D+8q1lpIxttKbp0=;
 b=a1BSAvqN+UpdTSGx+OsUD2pCGgW1DKxkQpVK+7JtENd5lXpCNICKmU2st+OvsHYEI5N0nyvCYOnJTpCdYtX5vkKA93OfM0IU3WeRicI/CgehNpbLiEa47yJRtuLfXPTZ7Io/xdaFYa+6tQLEoU7pKm3Ie9RJynRcyojTLYoQPI4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3641.namprd12.prod.outlook.com (2603:10b6:5:3e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Wed, 4 Mar
 2020 22:32:56 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 22:32:56 +0000
Subject: Re: [PATCH v6 1/1] drm/amdgpu: set compute queue priority at mqd_init
From: Luben Tuikov <luben.tuikov@amd.com>
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200303125039.53141-1-nirmoy.das@amd.com>
 <2085216f-f82c-3d2e-8f91-b05c2cf76a50@amd.com>
Message-ID: <3760b697-0faa-e1a5-533a-f2113bf7adec@amd.com>
Date: Wed, 4 Mar 2020 17:32:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <2085216f-f82c-3d2e-8f91-b05c2cf76a50@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::20) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 22:32:56 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57666cf9-4e5e-460e-d94e-08d7c08bfc63
X-MS-TrafficTypeDiagnostic: DM6PR12MB3641:|DM6PR12MB3641:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB364129D6F95587A7C52FB4AC99E50@DM6PR12MB3641.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(316002)(66476007)(6506007)(66556008)(16526019)(31696002)(4326008)(186003)(8676002)(26005)(2906002)(53546011)(81156014)(81166006)(86362001)(8936002)(66946007)(478600001)(6512007)(52116002)(36756003)(44832011)(6486002)(956004)(5660300002)(2616005)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3641;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FEtcCHjkUSmuFtUAWAZO7clXueMmuoiZ3MKMgzOrWTUVGKDJEPCyQaKJLhQxhDD3m22g6tlhX4v4Sqt9OiREc0k3/alg1AebI1LaKQ+7qBboHSCvy+nZYUhP0WVSaG5QuR3Vi3ZbfGm8T7vaf4RWB+5Z+zdhzLztH/ArMOYcmJo6ZqqpVmqXftEAdQsGpV5hCm98oXSBBtvjbMOWD+y6A8RU6JSmRKx3RYdRcuAW8UcvMnffGjCzBf3kjlgju7GHqugq8jWaPFkSKExjD3gZinBM6PWqhvPF7Vh2gVGMw2zdPcsu716WnlMmIU5O67cX5Yijtg+R0fcjXq3Hx9gbUMeO2sL8iJxKC7QWpQL2CCrNVm8Fqkw5p14kcufS79YgcvbCXzHeyFgL+cldExsrPJCy61Myoy16IUbfD7KZ/sHlZQPgsHwJEqNxl14+MbB7
X-MS-Exchange-AntiSpam-MessageData: TG95/dkCM4eCd1cuYoK8sjL+kKQSkxBfgix/XbJwrtGgVzB2dKDa11IzAKKbF0TurzSLkI3E4tGYQxQBNU5WYZNI1M6BgJD5C5tFxAMu9WQ8/WJl7vrPoBG6EIHK+wNn7RAqP8DbMgZoGXVQHPtBuA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57666cf9-4e5e-460e-d94e-08d7c08bfc63
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 22:32:56.5332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qr0O3PHA1Op0PsZ8tU6DhfEnnAq/vfwnAuuL1kGJqaKyT560xNM1u+AnUpjl9pR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3641
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-03-04 4:41 p.m., Luben Tuikov wrote:
> On 2020-03-03 7:50 a.m., Nirmoy Das wrote:
[snip]
>> +	case DRM_SCHED_PRIORITY_HIGH_HW:
>> +	case DRM_SCHED_PRIORITY_KERNEL:
>> +		return AMDGPU_GFX_PIPE_PRIO_HIGH;
>> +	default:
>> +		return AMDGPU_GFX_PIPE_PRIO_NORMAL;
>> +	}
> 
> This can be a map. We're mapping from one integer
> space to another. There is no reason for a jump switch.
> 
> For instance,
> 
> /* Map of the DRM scheduling priority to pipe
>  * priority.
>  */
> const enum gfx_pipe_priority s2p_prio_map[] = {
> 	[0] = AMDGPU_GFX_PIPE_PRIO_NORMAL,
> 	[1] = AMDGPU_GFX_PIPE_PRIO_NORMAL,
> 	[2] = AMDGPU_GFX_PIPE_PRIO_NORMAL,
> 	[3] = AMDGPU_GFX_PIPE_PRIO_NORMAL,
> 	[4] = AMDGPU_GFX_PIPE_PRIO_NORMAL,
> 	[5] = AMDGPU_GFX_PIPE_PRIO_NORMAL,
> 	[6] = AMDGPU_GFX_PIPE_PRIO_HIGH,
> 	[7] = AMDGPU_GFX_PIPE_PRIO_HIGH,
> 	[8] = AMDGPU_GFX_PIPE_PRIO_NORMAL,
> };
> 
> /* Map it!
>  */
> pipe_prio = s2p_prio_map[sched_prio + 2];   ## You can view this as y = f(x + 2).

Note that you can make this into a 

static inline enum gfx_pipe_priority s2p_prio_map(enum drm_sched_priority sp)
{
	return _s2p_prio_map[sched_prio + 2];
}

Regards,
Luben

> 
> Note that if you fix enum drm_sched_priority as I described
> in an earlier review, you'd not need the additive factor of 2
> in the above linear transformation.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
