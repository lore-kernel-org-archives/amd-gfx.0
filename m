Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C491DC4BA3B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 10:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA6B24670
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 10:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZvXyXKHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA6B24670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E31C6E578;
	Thu, 27 Feb 2020 10:07:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51EDC6E578
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 10:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OP6v/q0vnXN7JlODo1P4vPBNfvwyfJ7ebWameLqKecYuRI9j/h5qsqER0KO4QUZ0XgRQS02z69aeC5f4mAwXscH1T4OP7s1NnKizZ2rsLA26fVk7SghGw98i7TiaV4kUDBzpylNYizCCiuhz29Ra/lrg1RWzbXyTZKNayD9nlGSv4phq8vGGo5AB13Tse1RJ3fpIYvEU+eeUCBhJz1a6uPG6ZxIbzAcjqX7mfA6Td79wyDBABlR6LU7qK6C7GLgADsq8zGSWXQXPWdCZBxIat9AZ650Z3j9trO7OgOGo1XuclVzJ/qE0sxplc3CnvgQXgSZyxYeca8wbs1kXS3l5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLjrITi3J75GhAYCoyrS6immGjQI7wXtCYHjLTLLo0w=;
 b=eTnBK7JSbUIKgVaw7X24s3UMMgueMGQOIuO1Zhd7SPQNT8d/YWGtiwG42Z02IcD1Tt69pDQFSDn9lCjYDs9eZrlgNOnWMU8laRkSumKsMw6vvqaUTNOT8fynP4EM2xoyzZP67CVBMgtfxvoDZcCff0+FXCgdCwhimsW4HMpMwn5G6c5zjDd/gznh9uAFgCXg/y7Kk92UzNorubZEOuy1kfB8Am1iTVBrun4dhf6QhVpFTTu+JZ+gr4CL0xuU5aguEkdxWPR07zYGWi3oPZI3T1CREaHxO8I/fRVi6bQhVI5enRbGW9lUr4BC4y4uz2nwIVEfRmOr7YM8J68AvN/gbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLjrITi3J75GhAYCoyrS6immGjQI7wXtCYHjLTLLo0w=;
 b=ZvXyXKHfwfXpL3jR1v8EstsYo6lNoCvZvrCEJCjsIMyT3Q7IIWTK0YTRtJTRySCRmnazCtgg/LSdbuH/gAoEi0yvCUPufZxtPAgLCGLURw9CmNh1TjvkSkwP6QLnS4jC+FFJ0fohLbUvFsMxYu+Sut4GlxqYFaNgWdRNqaYG5v0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1339.namprd12.prod.outlook.com (2603:10b6:3:70::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Thu, 27 Feb 2020 10:07:56 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 10:07:56 +0000
Subject: Re: [RFC PATCH 2/3] drm/amdgpu: change hw sched list on ctx priority
 override
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200226203730.4621-1-nirmoy.das@amd.com>
 <20200226203730.4621-3-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <6f488726-0ee9-a1a2-bb3a-9d12a405fabb@amd.com>
Date: Thu, 27 Feb 2020 11:10:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200226203730.4621-3-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2a:b800:8c:b0f3:cb6e:896b]
 (2003:c5:8f2a:b800:8c:b0f3:cb6e:896b) by
 FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Thu, 27 Feb 2020 10:07:54 +0000
X-Originating-IP: [2003:c5:8f2a:b800:8c:b0f3:cb6e:896b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25ccd002-f8dc-4e3c-0fa0-08d7bb6cea48
X-MS-TrafficTypeDiagnostic: DM5PR12MB1339:|DM5PR12MB1339:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13396578CD2DB4C2C0B6D9218BEB0@DM5PR12MB1339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(6666004)(186003)(16526019)(4326008)(2906002)(53546011)(478600001)(2616005)(36756003)(66556008)(316002)(66946007)(81166006)(31686004)(6486002)(8936002)(81156014)(31696002)(66476007)(8676002)(52116002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1339;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HC6jCixovvqnNzPn40qTR35wr2+rL8oP6KRgkVYD+xmsF2J+q5P0Ue/mz9MsE/09h/HhquiO7T6Vsf3tV1DaA76YJd4meYN6+1gR2qwjsszeaXNLm/lYYYPLUilyLWLaZ9Yrh+qyDVC/2dbG6ASrbasAARxOmUzFrbsYSog+6vzznpjm8q5nbmLmN2JViYd88bha8hUxSq3Pda9Nh1/sMtFNKfFnBfJQUELdcq3Blx2D32pFB7qfbi7MNExdyFlR63DdQc+kFaO7PaSek1jRclFBIl5AkyspxAulQaJK1JTofRc3nUfTJpJuVTPXXx8b/z138TZZB7EBHozImJAJoDbDr2eyyc5p3XGKIPDHAkm8mn4IWebxe1uzM94i3k41m8UxJ+jSKCs2zD/Dc14n7i8nLXZJVI2z+xGkgXJ6lxSwUkJLm+PxBIkL6IdJWGmh
X-MS-Exchange-AntiSpam-MessageData: 1PgYyWpIknldlK8wH/RV3LAuQUBG+XTtkeR+OGGpbnsZCOv+BvZwM3Ib38Z2sDv9Hnsa1+o2XePBoZsjM7+iUWWvjHupaCuLLEUoj5xzQUResGJ6NrsloaPajp0pD/7lLoW2QDVKdlM0FAZOq2c2D5D1rLJUyzXQzfT3xfSjCdVx0eiNKj9k0uIRXRnTJd5Jw4qM4NSeSPJQqC61AQRZ2Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ccd002-f8dc-4e3c-0fa0-08d7bb6cea48
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 10:07:56.0566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PScpBl758SbWENktHqZCdZhLF7WDxZ9l6K1UMICg6KlFgDqzoVe46uG5zEcEotOR2fb+jLulfLE/D08WhPAgPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1339
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Found two issues :

On 2/26/20 9:37 PM, Nirmoy Das wrote:
> +static void amdgpu_ctx_hw_priority_override(struct amdgpu_ctx *ctx,
> +					    const u32 hw_ip,
> +					    enum drm_sched_priority priority)
> +{
> +	int i;
> +
> +	for (i = 0; i < amdgpu_ctx_num_entities[hw_ip]; ++i) {
> +		if (!ctx->entities[hw_ip][i])
> +			continue;
> +
> +		/* TODO what happens with prev scheduled jobs */
> +		drm_sched_entity_destroy(&ctx->entities[hw_ip][i]->entity);
> +		amdgpu_ctx_fini_entity(ctx->entities[hw_ip][i]);
> +
> +		amdgpu_ctx_init_entity(ctx, AMDGPU_HW_IP_COMPUTE, i);
s/AMDGPU_HW_IP_COMPUTE/hw_ip
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 18e11b0fdc3e..4501ae7afb2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -326,6 +326,10 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   
>   	ring->max_dw = max_dw;
>   	ring->priority = DRM_SCHED_PRIORITY_NORMAL;
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE &&
> +	    ring->funcs->init_priority)
I didn't set ring->priority to DRM_SCHED_PRIORITY_HIGH in the previous 
patch
> +		ring->funcs->init_priority(ring);
> +
>   	mutex_init(&ring->priority_mutex);
>   
>   	for (i = 0; i < DRM_SCHED_PRIORITY_MAX; ++i)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
