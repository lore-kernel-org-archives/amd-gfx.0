Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F281AC43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 19:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9137206F1
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 19:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dV8U59+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9137206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 810A86E037;
	Fri, 27 Mar 2020 19:54:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E38596E037
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 19:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LogS8u/X1eZ75t5eSSExqYUmlM2giN6AHI4UZjO9oDBB/UEVnGJmm7J5wVNw/fNC0TfhA1xHy7/Co4GLmudyS6guVMeSfR7DqbA/e+OxOwmkk7JExaJqW8T02Dym3Rc3VzWpkxhal3ROTTe4JXnxqmlLy6LvXzFvZwHxxr0DR1zY+8zJhIrYWKF4TKI5B4OXjAh+lgXRKg1jDdSeIPsQ8VDga5Janx0Fg8q9zezgglHifCgCJNQcfuuK6J4L9kONo9Zjt9q/NehWpqbT1nlexRyyKePZD3vd+wGhH/fe6OzOEDaXmUuPYdD5MwRm38fA1lIh/u7jVAYoBY4sOuMauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlerXRaw6Uye7ErHnp916+zcdMWKveMHZBzkEBVs84k=;
 b=SUkpXT99DXquwUt15CaOT4pme93zQF9QUPiBgWL4FlGyAbVXw6V+4eo5pxP8Omz8IoeTWiGYTLSkEahMPN/U9F+mzzS+z6W5vm2ibE5obG+qnJSvIPfUgjVe1JzRDb9uJTrsntJ22nFV1ihDhqbM/s3fHon5i2vo0l8Mj/pG18TyCdsdfGKwMhBDB4H579KXyDWw9RCTch226GiRaA0cHITc6820LZt0AIp9djWZr535tMpgtqFFADnOkkmvksPuWGJpIzYcZnNId7eFWgHcOCxs5vcBoqvhE3hditohGZy0ozDFGuDMe/ene97WImWxQSV+T4wjClgL34xKd33mcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlerXRaw6Uye7ErHnp916+zcdMWKveMHZBzkEBVs84k=;
 b=dV8U59+EI38Gr+QRLrvlqfds/Z4lY5mxPLQKhVq3FufEKqaHOpivLHewvCq61uDHnJmOoeIjd++F7Fn+evjs4UFWSG31OdbI8tLG5VHbnOQf/jB0yqzuNKVGEM6ObiGCcaGgAT+nj86fqLQYjWJXmriY9p5vdLVmcvXMqZcZ0MI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 19:54:10 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 19:54:10 +0000
Subject: Re: [PATCH] drm/amdgpu: ih doorbell size of range changed for nbio
 v7.4
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200327193211.8148-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <67a66f48-447c-db01-1e4f-dfcfb9a02f95@amd.com>
Date: Fri, 27 Mar 2020 15:54:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200327193211.8148-1-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.147.81] (165.204.55.211) by
 YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Fri, 27 Mar 2020 19:54:09 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97fd68a2-a454-4166-12ce-08d7d2889dac
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:|SN1PR12MB2542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2542106C61D62BF211EE604992CC0@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(5660300002)(31696002)(16576012)(66556008)(66946007)(8936002)(36756003)(316002)(16526019)(26005)(186003)(86362001)(2906002)(6486002)(81166006)(81156014)(8676002)(53546011)(478600001)(66476007)(956004)(44832011)(52116002)(2616005)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2542;
 H:SN1PR12MB2414.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /J7Usb1qgTNcQhTzmrGWts/QFRDkuFvSRjkTv45uHKpVrxnh0N1QgCjCm1pvsBMGcGdzcLSXDQ7h97cdXq9di4iob1T6Y0CQ1bFoBMFua66sj/hWciqCQgOinsrlFnvTv6YNX/hF2qPOC1Hq8ydxju/LX3n0NoFyg71YE90Q1ZFlXmteN0pLKISQCaiHgBauW8ZoX998m5AXT20LQ3eY9TwaGeMBg7CFyAhLGLQVUKuHD/5aQYzrm+P1OXPGZqRpB2UahZihooGUb3HX9uHpkIWlPJg+4+xLMNu/BBDMFr8E8CnD7qCPeEaiOGC3Bat/Ufn9hKrRyhR9b43rB1KsZJz000O4303QSbphBrGsFA6ylE8DkEuUgsuJ9YrCC//+8Uqn4cH4tliEedR6VJaXSrogQT7+Xu1yIqr6PQfoIhWCSmYs/35y/3nEwqlURcZq
X-MS-Exchange-AntiSpam-MessageData: LlpP2UPDB1LQDwK3YwxQrQi9EyjFUOmQyDUURkYdP+VLsd91iil2+R73LUPgtaX5TFYJaWq6tgaTIVwy9sh9JTOuU0WljjSvNVZYq4PEm5XyTwU0bmmIN/2TiFiLat3ervHNe1TRO8VKEc2DoPrd0w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fd68a2-a454-4166-12ce-08d7d2889dac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 19:54:10.5795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmo9+F4R7H3ykrKpRSTuPt/6mAPfhKBr/JREGdyRnoWaTmi+EQSvjPeM9bnNlgK8Tf0AjP6rWo/P0MwEclxbCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-03-27 15:32, Alex Sierra wrote:
> [Why]
> nbio v7.4 size of ih doorbell range is 64 bit. This requires 2 DWords per register.
>
> [How]
> Change ih doorbell size from 2 to 4. This means two Dwords per ring.
> Current configuration uses two ih rings.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index 41c53c149852..72bdd06ed508 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -185,7 +185,7 @@ static void nbio_v7_4_ih_doorbell_range(struct amdgpu_device *adev,
>   
>   	if (use_doorbell) {
>   		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, OFFSET, doorbell_index);
> -		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 2);
> +		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 4);
>   	} else
>   		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 0);
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
