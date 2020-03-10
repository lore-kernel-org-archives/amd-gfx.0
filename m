Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B289C10F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 11:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3176924681
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 11:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vv3UpKwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3176924681
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4C8D6E160;
	Tue, 10 Mar 2020 11:26:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC9496E160
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 11:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLa3V/+M/wYsec4j80LmM+ne8+os6PjGfm355V68sS/Uea+XUCZ7IouvKVuulvKmcIOqcuQwN/PssTwy1oLUJAoIHcO43jpFL8Kd37yUS3ZcpWNByJac9PF5ZF3l9/3pdrTrTkKMpGlQz6uJCXsBh1FBKfLTP5/nmEY+gcF6CmwWfOTJkylkss4jukSYXfp7/VPnP166mOZt0j2ibTbeIEsrP7+e95yBHYUjlkxUFHV8jlwx0/U2JTIb95I3H9L6z6IFpVUVr5B6kyDTeVe2CFoA6+YZrDLRBshosdYfp8X7o+WZaVuyM7v29pJBXxPXEJDZl1R/aiOpXbRZDcJ3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTLrklupNV1kdAupi9gtwnr8F9ktrU2FPLUfddzFxi8=;
 b=Wus6L9lSfxr2fWes2emZnf4OD9DCEiRU546xSixDcaqhbuthoIzGG2F5VPxsNOc+kHLlzUqRBWBTMHZ2jl1XtGT+eYjNVVOO33Drg0U9ar7qYy2j24wdPrzoDd5CaavN19pD7dt8n58V/oqc8h6Pq+GKW1mFAJsglVioC16g2hwkxETD/i5sYIlxLnjmKNWwOlXw5TLyVoEcll6QVEs4O0TP1/SYDrL/vj80CSh4exajExG/e6qTYh0gpCKCQp27Wgq9LueRhEHeZe/YeEWk0/YBJ0KiT9vd7G9H5GbaJvW/quypbaTf6TiVIjwKSBjAozuPgiAI9fUwCenAXN2IJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTLrklupNV1kdAupi9gtwnr8F9ktrU2FPLUfddzFxi8=;
 b=vv3UpKwhMBmgPrXX8plxECTV+muc1cs91JQwa07E5wleCseBwWgj/D19BMC/6ZDgmRvq2B1+sZwDqZcWB77qvm9WF+oIQohouG38X5FAkxUb9MZAMDQAiq1Jh6AceDItIvs2O1G8KaXbJaCp2SBt9dQZfP5oA7ivf4FLtDRjrKw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1563.namprd12.prod.outlook.com (2603:10b6:4:a::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 11:26:20 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 11:26:20 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: fix assigning nil entry in
 compute_prio_sched
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200310112748.4899-1-nirmoy.das@amd.com>
 <20200310112748.4899-3-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <bd692268-7504-b9c4-7304-49ddda9b5987@amd.com>
Date: Tue, 10 Mar 2020 12:29:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200310112748.4899-3-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZRAP278CA0007.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::17) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f32:a800:70e0:f409:f185:3dfd]
 (2003:c5:8f32:a800:70e0:f409:f185:3dfd) by
 ZRAP278CA0007.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Tue, 10 Mar 2020 11:26:19 +0000
X-Originating-IP: [2003:c5:8f32:a800:70e0:f409:f185:3dfd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6647807f-9803-47d8-2dc4-08d7c4e5db50
X-MS-TrafficTypeDiagnostic: DM5PR12MB1563:|DM5PR12MB1563:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1563E8BA70A996E476340CAA8BFF0@DM5PR12MB1563.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(199004)(189003)(36756003)(66946007)(31686004)(6666004)(4326008)(53546011)(81166006)(8676002)(66556008)(2616005)(66476007)(81156014)(6486002)(316002)(2906002)(16526019)(8936002)(31696002)(52116002)(5660300002)(478600001)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1563;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPlOei4LNVIVD3w9ZIe6/YQTSWPuDRQwOKPI3NWZrsV/XPUkuBM8Csbs6XL1bd/LXbTK/FdBInfgL07RWwV8yERMgiWzPKpY28Kj/ebaNB5BHQT37NblRlSDKcTVNhrjdjLW/HH+Pn3SJaInsLtCYtckIa+wyR9QRsqC3fm/vmDwCsEVvGqr/l3zJy0z/12dZapZ44xnEL6ObWeJIs8kRDEwPc8Me1UziTHYDmVOZbV+Z7Jfk5msdy/ElU5jrYHLZceGmAZnRfGIR3lQ2J2w3/3VjdVVDLlF3Q+vRQ2UIQv22XQm+1iSol9Btr2ppIRrhFrqOqbazg2nqocPYarE4QwAF13x/XQGpVSU7ZPMosqWllH11rF7QQv42T7HUuXy5SR9YRUIMaqg5ndsPs4RJA61sKIssvwH6KyGvMssRrybdNs+Kd2r2mLEak+5TWG5
X-MS-Exchange-AntiSpam-MessageData: 0wdbcWpuxBK99dsJ2/F0WqkgU+YbaejOlJum07JKK5huacq4sbLwNXVqcHX8tiTSML9QgFZPzqrfeHzJ0IfXnqKn1OdYAEYPJm5mLx9pqbl0gdHTbx3wDqOVMtRCu99NFDqDCPI1jopdgI8IEP6eGjt7VaymdmlAmaaw0POjEYT+DDfCfF+9Gu+u3wyg9idccol4h7b1reH3xSf6zxdyvA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6647807f-9803-47d8-2dc4-08d7c4e5db50
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 11:26:20.3373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Pu7BZoSQbvhOMj5eUq0s6ZwlltuTPeoG4hDpCGNhEAfXKjZ0JcKwaa9zQLSzjBJQyUR3h0+WLDXebteEkMyQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1563
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

Please ignore this stale patch.

On 3/10/20 12:27 PM, Nirmoy Das wrote:
> If there is no high priority compute queue then set normal
> priority sched array to compute_prio_sched[AMDGPU_GFX_PIPE_PRIO_HIGH]
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 99875dd633e6..01faeb8b4ef2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -478,10 +478,18 @@ static void amdgpu_ring_init_compute_sched(struct amdgpu_device *adev)
>   	adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
>   
>   	i = AMDGPU_GFX_PIPE_PRIO_HIGH;
> -	adev->gfx.compute_prio_sched[i] =
> -		&adev->gfx.compute_sched[num_compute_sched_high - 1];
> -	adev->gfx.num_compute_sched[i] =
> -		adev->gfx.num_compute_rings - num_compute_sched_normal;
> +	if (num_compute_sched_high == (AMDGPU_MAX_COMPUTE_RINGS - 1)) {
> +		/* When compute has no high priority rings then use */
> +		/* normal priority sched array */
> +		adev->gfx.compute_prio_sched[i] = &adev->gfx.compute_sched[0];
> +		adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
> +	} else {
> +
> +		adev->gfx.compute_prio_sched[i] =
> +			&adev->gfx.compute_sched[num_compute_sched_high - 1];
> +		adev->gfx.num_compute_sched[i] =
> +			adev->gfx.num_compute_rings - num_compute_sched_normal;
> +	}
>   }
>   
>   /**
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
