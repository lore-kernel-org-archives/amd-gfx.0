Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939F4C4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 13:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2730206FA
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 13:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k59LEG0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2730206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EA856E9B3;
	Fri, 30 Oct 2020 13:06:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CC0D6E9B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 13:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2S0aqgawE7fEwjYk9ZoZM4lBeJQU1XYOuxIqoaSe2Cwdd7j0b0ufWPJAB98w0BwfNNGTnqPSvUGcQLAzwWQ3M+IewzkXgHzIBxXjkZvCugcFqly7q8gtsrqbftgvn3rUIGQFrwM1AwhjOsl6zrjRJEixOf7Y6HltUIT6jRh74WGBA1PSNiukXQEBjdXxBvwsghX7sD5k8hfjVZcELLilZzK2w0yazQn+58X7+bnZnYTBSwBkqJTNU+07ecuhE38vK5J9DuOsQvkH1ODmOptZIi48FbUGmz1LEQiDj+iyPEg1DMZNu7FnJpQSLlRLwiQ5I3Y+XR4XRJ5cfyPosEkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ1KCr0lC2TbliNMpD2Yi1iF1ElR+OCIuJkp4pCeRpU=;
 b=njsNG3lZAKrjWbpL+dx/p2UbKG2M82odE2uyw7jdQnCKc5dWib/tQ97Ar/EXkJowPAM05xmOm7dU1GAJ6GJieAVc+qGncQ0ciyNH0Bjd8NKEakZKlqgDNJU3i2+kt8cye5e1/2HrRu/yCzF3B0dR7AYUWGUbGyH6hSh+PajoyvVG3FOMu1ygHbXKEveHg++Wl3+a1YNvbHu/CWnir2OTx12zCc9PbQ58Mc0aF0UY0bKqWbn68Pcj0ShzAb3Vdqyrs+nNa2JYFAe5NRHYIQI/t0KFhYc3me59Xou7noJfek9iP0vXKUYudjzXm142F/1PrwH6zlQAYR4k/G9M8rexjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ1KCr0lC2TbliNMpD2Yi1iF1ElR+OCIuJkp4pCeRpU=;
 b=k59LEG0oQ6qZmWSAt4EUTRUF/TuJ5pLXbU74Ft5IRWU5vr8RvjKtMvS5ceGwujSWWkNnnvVz6kSDj2fn3wexY82Ac33x4xtFPG4H6R3+JJsCa9AgLqKEwCleDXJ7f3afHFvQC7fh6PGalbi8niWwT9BUr/oS46T0bSrhxlz9yIg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3066.namprd12.prod.outlook.com (2603:10b6:5:11a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.28; Fri, 30 Oct 2020 13:06:13 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a%7]) with mapi id 15.20.3499.028; Fri, 30 Oct 2020
 13:06:13 +0000
Subject: Re: [PATCH] drm/amdgpu: disable gfxoff if VCN is busy
To: Jiansong Chen <Jiansong.Chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201030113710.14291-1-Jiansong.Chen@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <2a04ca91-5999-bbc8-e9cd-7820b7868696@amd.com>
Date: Fri, 30 Oct 2020 09:06:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201030113710.14291-1-Jiansong.Chen@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.230.192] (165.204.55.251) by
 YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Fri, 30 Oct 2020 13:06:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01ec168a-8a80-4241-b6fa-08d87cd493c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3066:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3066C6968D1CD224F0302268E4150@DM6PR12MB3066.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6YXHe2dkEdm0ya0gMCFYKK9jKUa8ONXQRAtEfm2E+KqFW2CLhwmjJuMElMXtLvucHZ95OlF9WkYKg5yD/22d3dFX55tlyAsIO2/7vBGAi6hCV9rjgASjFyp2Rp5lqmYjTBNzm0B03hY9k/94rL6hc8KUsbQ94hR5J2j/pKVp5d5hNq9CJ0TODq3an0BxRJMIOwTfsMCDU2vsz4I3RQOOFsU8+fHfqcDqTazn0jP7U489BnFdk6E1gYMKyq5Wt2/aSjpQROOAqN3RKk1wDWPy+VrTSo+rXJwUdY393fEFrl8mz10nuKZxp0j4iLDHYQt8mbhdiARrs6nE4dYQDDwBaFtt6oqiC50oX0l+2I9gvEBwZLnbwcSsd/pIfVYOrpc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(4001150100001)(478600001)(6486002)(186003)(4326008)(16576012)(316002)(8936002)(8676002)(31696002)(52116002)(36756003)(83380400001)(26005)(53546011)(16526019)(2616005)(2906002)(956004)(36916002)(66946007)(66556008)(66476007)(5660300002)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: k1shsy+IPdP+818PrGJyWWhUG1x7mAbIrEliYJbOlvAHyCFV/Psm0HPy5JjWPdIrJngoYKpvVc4vVau68a6vTBcweqcnUJVlIJ3w5NdYGFW/+iZg3k3Y8ZwSXzCPhbR1Yho2BEMuz8snVNG7aD2R/zBOSaO223MxESr4b4+fwtJeSxlCDyjwPpDIdYi6ReeSSR85S0rtz/WqDPZmN9qCF1zFf/RNmphSS0FM/8kNWyqdT2RhZ5QQmIqp9VRU/n5rui2TVDIjJmAeR0NjWKJWWo61sUykkMNbu0fm6pGG5qDS/5WwaNwqUlxVSp2IXXAYyhRDGl2/FczBfzysnC9bvkkn1KVZp4ErFNG2zENomzm7PGtLnzZVjbUfRs7ipmS4C0gezugjP/pVIU3tGB6m6FVlrMEzRL4nuuj4XjZmcC+JBDbxejX6Iv3fLwk7QkzZNONsYDD1woa33cBsTuzbGCW8nZhwE7UTJqpRcbrb1nuNVxiivMGf+VS+KjP780flnq3KLcDW/7HG080OsZ36cyXf/5rLmynuTLKaX3pHR67Bc5/pO8+ITS/b8iCXxMQp6RtgVuZji2IlOAc18zh0yYB0b569XzFaD/63l/ofYo7nicjPCy+eA0iwimibhXaeb2w6p4WVlRdGGWCkwFz+ng==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ec168a-8a80-4241-b6fa-08d87cd493c1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 13:06:13.0689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZUbMj63joCP3TPaQRdyAZSce1Gmzin1DhtobMzr/QEQiqUiy+5v7Ris8ODgJHBM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3066
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
Cc: tao.zhou1@amd.com, james.zhu@amd.com, leo.liu@amd.com,
 hawking.zhang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Jiansong

Pls check inline.

thanks!

James

On 2020-10-30 7:37 a.m., Jiansong Chen wrote:
> Toggle on/off gfxoff during video playback to fix
> gpu hang.
[JZ] It is a workaround, not a fix. Also Arcturus needn't this WA.
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: I5b938c446884268c2cda0801121a53da980e603a
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 277a8435dd06..444b89413232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -358,6 +358,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   	}
>   
>   	if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
> +		amdgpu_gfx_off_ctrl(adev, true);
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
>   		       AMD_PG_STATE_GATE);
>   	} else {
> @@ -368,13 +369,16 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> +	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
>   	atomic_inc(&adev->vcn.total_submission_cnt);
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
>   	mutex_lock(&adev->vcn.vcn_pg_lock);
> -	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> -	       AMD_PG_STATE_UNGATE);
> +	if (set_clocks) {
> +		amdgpu_gfx_off_ctrl(adev, false);

[JZ] Move the above two lines before mutex_lock(&adev->vcn.vcn_pg_lock);

Since it may cause S3 test failure.

> +		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> +			AMD_PG_STATE_UNGATE);
> +	}
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
>   		struct dpg_pause_state new_state;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
