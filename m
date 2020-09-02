Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7F3C433E6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 06:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155E92067C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 06:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XXRALiNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155E92067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A5EF6E127;
	Wed,  2 Sep 2020 06:55:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F9D86E127
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 06:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSuXrh+i4I+vG0cKOMZrfGExWQGqLDc3QWayPiHAvory82SXJgyuAWz3SlBqKRQxr2rKrS5LS6Ii4nn6YWILxBeSNVa6OxNGhJ9QXXimNw7WHhpMzprMfKr3Gh9qg9Zt4Et+mExHn1fifVNksH2xFYk5m8rj5Ll6BfSWjhuFiHCN9dd/IHg2NsOM/aM5mucrNGmHN7xHM9625xupceKBtAIZjZcCa4RPO7HrCEPHm93aEtWwCShI1xDsvwbcTV0rCGRRscPVSf0xEpc0xCDzs4rQqkWSIg881IjFRBSEArPmnd3cvzdDJiB2rfo5XjW2XPwRADpkpSnW+EFWj+PZsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU/mgpA8w6zlYSzH656XqxnYGRAUvvIzkJ+QY5NosXo=;
 b=mPajWRZYy8AtFFhTTbFKPjPZqYFVsLq++BoASNzb3lEI2Cs6ZiPW50BJ4rKqWzfaK4L6f3e/V8QrMBdiz83dcmP+5SuGr579bmGx6B2s8ru65TLosvgUIvxVrg0rY2hNGWiJ1LLhMcY3NkudDE/Uw0BJl2rBFAZJPtz+ZBCl+wveqVA9mX9iyk0yC9S3+l+A23kkzOEJzpHG0suB4HE9Yi+8ImVumn741BXPdkP0QL2WN6fUZTalZxQ9QbJb4UOyacC1RGD5ts4iVcY6b6hN2athmX8Te42+G5mr8cOVQuiav5uwYucesL9U9Vn6ElyzXpuOYb0YWokwOcJ0doJjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU/mgpA8w6zlYSzH656XqxnYGRAUvvIzkJ+QY5NosXo=;
 b=XXRALiNnYI9foRwo7uxcvSCCwg6uBBW2e0OVUxX4bOe3V0I7Vsco+frsxhFXRnMS1bAqsbKeK428r/wVbWTjGcYTs7Vv0spf3+TRVcu9EU/ezQpRdUNde2+WYkf5cIZ5z2+fnHBfLG69Rr1DLZ3JAW9L/RQajW3VKcZE8Dky3bs=
Authentication-Results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3966.namprd12.prod.outlook.com (2603:10b6:208:165::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 06:55:19 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 06:55:19 +0000
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu: disable gpu-sched load balance
 for uvd"
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200901194928.22386-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e09d9528-e2a2-5f17-dd0c-2cf94f9cc0b6@amd.com>
Date: Wed, 2 Sep 2020 08:55:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200901194928.22386-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0030.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::43) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM0PR02CA0030.eurprd02.prod.outlook.com (2603:10a6:208:3e::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.20 via Frontend Transport; Wed, 2 Sep 2020 06:55:18 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 090f9ee3-5257-4f78-d46a-08d84f0d2784
X-MS-TrafficTypeDiagnostic: MN2PR12MB3966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3966EBAB4E5EC77439611E22832F0@MN2PR12MB3966.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7pn+FPgE99Rjr4xmUfEnrxTRDxnRNXHGsWr0P++fs+mvSSRtSJD2pOL+lr0DOwOtKpKVHxse1qSVUHn4cMy/k4JzBfxykj5hGbO3YLEG0o1VDxtZM/QkLJcpSbQfvoFcGbsmFCW54lt0haPTWcg2G3bpFU+zX7IUy1/TroWeMHTyVeI3B7yQNk13x2oeRrXNGzCqOA49reEqMzVwmfGtts47DKkVt7jFA1Fv5bxhO3w9qcUnnH8l8ND1pp5MySLQojc1y3Y8dSLUvMa8TThr12WmeAXeUb+wff0VzhD9l119FCsmX3mZqr4gSMfawKiRwcN7mOvkUn2CDR36rw1sY/DdggKLUD/feI2JvDZ/whrQp+WhgQaxnYJy96i7wXgJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(36756003)(2616005)(66946007)(8676002)(4326008)(6666004)(31686004)(66476007)(956004)(66556008)(186003)(83380400001)(5660300002)(6486002)(31696002)(52116002)(316002)(2906002)(16576012)(478600001)(86362001)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8w1kVnQSHv64mWwWXk0XLrcXHPHOZ9ln44XPqAmVuQg/76IAGyvFokoqdOMsFMzDINRpLs4RC7XBNodLCQyNVmQEGvHWAhNXT8tutcxDPIlYdqUOSQzIYa6CYEP23PpqV+t93bDz6BqSfJKpnFKAGTDUkdLFECOP+XXLBnNhC9mtR2KU3xHELEWAVlePPP2FuAvA0HsoQOo3DBHRoWplvo9ZVKJYlCPmH7UZfbpxmyc7ufiIOY4Y4G54cvPHAD+AV+/aBS8Y9PnwVbdZBphsLGTJBPv+DB0URl/APG6e5iKS8RUHoDgkx7jjYaQpdL503smsEJBjLgHrKil80NVuHJHCDlSSctentHozCe6o2DTMycQZj0UR/CuZ1oV53YbIqIxAdRra2qsYHiGxb6XlukJxedQwh+KousMT5L3oerSHKCapl4BA5GqFPGfOcwsQGy1nZ0m1QThM1ROq1GDNmnG1+g59lKUoXDWneSkwtH1VOAiIHI9aq+QB9uaYfF+eDzUQOF6foowrYkysqL/PkRNYO0W90jJ5a21dBvhyQs9+/iWqyNsC+x1nk99HwqCny2k6BrtKuL2+JbBxCHTX3LFVMSNR90g/KQ2uEF7zOc72/VpS4lLahkY8/mmaUyWNpnkAR5SwVko+JnP82hOYdACwKYTu4amyJIQBJmYZE4Lpqj0GGICmOgy07b01lkfqIS1UagSRH+ZRU5EbFYJczg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090f9ee3-5257-4f78-d46a-08d84f0d2784
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 06:55:19.2818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouq6RzI3l04Esa2HblRwlXunvV0ucW5Y0YwYk3Yhdkr5tTInpBmGJaNOs2YcUmp1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3966
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
Cc: alexander.deucher@amd.com, pmenzel+amd-gfx@molgen.mpg.de,
 Tianci.Yin@amd.com, Leo.Liu@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.09.20 um 21:49 schrieb Nirmoy Das:
> This reverts commit e0300ed8820d19fe108006cf1b69fa26f0b4e3fc.
>
> We should also disable load balance for AMDGPU_HW_IP_UVD_ENC jobs.

Well revert and re-apply is usually not the best option. Just provide a 
delta patch and Alex might decide to squash it into the original one 
during upstreaming.

Christian.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 7cd398d25498..59032c26fc82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -114,9 +114,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   	scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
>   	num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>   
> -	if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
> -	    hw_ip == AMDGPU_HW_IP_VCN_DEC ||
> -	    hw_ip == AMDGPU_HW_IP_UVD) {
> +	if (hw_ip == AMDGPU_HW_IP_VCN_ENC || hw_ip == AMDGPU_HW_IP_VCN_DEC) {
>   		sched = drm_sched_pick_best(scheds, num_scheds);
>   		scheds = &sched;
>   		num_scheds = 1;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
