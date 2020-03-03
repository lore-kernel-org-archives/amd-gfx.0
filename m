Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F99C3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 14:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332112073D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 14:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T8ZwCrtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332112073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F05C76E8CE;
	Tue,  3 Mar 2020 14:03:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C670D6E8CE
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 14:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eybHCn4r9bvN5inHRPbQ5fBEUNKTDlezvpXeQ08PWAXI0PPKY8eDIF1jd58EtAaiVBlnun1ABkBxdMeQpwN/89xWJnh/YzGTrHKZTtOfLG6w1vUdSlLFZoF/4Lv56TfYMTzLIm2yl8eCZB6mjUd5hRrVu8YwCWKqKWnRBYp3lUP2tskvgSsYHakqLJ3Kd1EEANIFUVwZgnU6wWwfjeaczKWpz4rUs92KZm8UFNlNDueqdTZop1BF7q5b1ROk0EI71Vb1QfuOFZqkBucuddVtoOzkJ+eG83Jnk0UV9alvl152w0qnrfSgSpU+ELEZkXFDCDyGr3D5bpHWEvebBFqrMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0QY8IeeAy6ZUK9y1n1hxeAwHKviiDXT7Ss+sk22QMw=;
 b=YlF6zG1TQ3AOQcvyxb34xWxOh4+6T2czevOwgM+xYkF5IncV331riuizesUhLZKRllFXtvNJJSiBVGnUjLNr/PXEoU4zCOI9KKK4TVnmGH5UGGtxa92NHXbBRUw02xlfNgk9Lp542NHP59qiI9ZlVojrFQIK1Bx1ys5h5xQoGsSziQ5H2wtzGfRQ1z6zdPTsVIgU5CALiS0hGZQxVWenlS5gRTiQR8Fua17uGce5IcuPbnBj7GH2yaw07ItZjwlivhU1yqoSzQtH2qlCP9I26+s8ki8w8JL28intATy/8OCf7AoYQ1lPoxlXlAFVdgZsDtwwg1iHucADzwAxyjDnpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0QY8IeeAy6ZUK9y1n1hxeAwHKviiDXT7Ss+sk22QMw=;
 b=T8ZwCrtYkIDyi/cc11mQKe/NDSeJTFyvDMS9anil5MZsQIXKvacudJ2T3+vjLCsAcqe5VavL3DXJk9DQS5w9CMrDpFBIdyDr2E4Wy8r3E5TVEhuZoyMmQhM9BNs3p+nl4nkiQzc6DwNTKlvhxXF/klQ/Flk/6d6JkTAWICxChBc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1865.namprd12.prod.outlook.com (2603:10b6:3:10b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 3 Mar
 2020 14:03:19 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 14:03:19 +0000
Subject: Re: [PATCH v6 1/1] drm/amdgpu: set compute queue priority at mqd_init
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200303125039.53141-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <99ff4cb5-3d6a-c14c-20c6-553d2b22df50@amd.com>
Date: Tue, 3 Mar 2020 15:03:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200303125039.53141-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0141.eurprd07.prod.outlook.com
 (2603:10a6:207:8::27) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR07CA0141.eurprd07.prod.outlook.com (2603:10a6:207:8::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.5 via Frontend Transport; Tue, 3 Mar 2020 14:03:17 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c6701e9-b987-4327-6524-08d7bf7ba04b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1865:|DM5PR12MB1865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1865FACA59805A525471C8A183E40@DM5PR12MB1865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(189003)(199004)(6486002)(36756003)(4326008)(5660300002)(66946007)(52116002)(16526019)(66476007)(186003)(2616005)(66556008)(478600001)(8676002)(31696002)(2906002)(6666004)(8936002)(81166006)(316002)(86362001)(31686004)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1865;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0GlL1BHy33Xt4LPvzkwZ3QNrvgEC5YisGrn3IyGWHyQiNE+O79jzhkT5/Kf7j4tkpS3O2gPDAeRZpFaKNsSVv12rFqvjGRlSIF6LbCjlutfSAHBAJ6C6AizSJs5m8H83uKr+TbvP1aMoly/JWq9ovXarhCJb0QWkddY0yGWCv+0EX5MEU1lz5Uyq+99KO1qKbzPzqvObl5GTC1clGg42z4sSUS4Nx0GjkB3lCGH18/a25434z4evGEBgOtcb1+T2OB2h5DoYspJgjxvSHLGrIL0cRdBJp8KVAVpdhLYA1uCJIPFVRHK5NnuI7z9ss3+VoahznSlIDJK3bfbmcok956A1a6P/+t2YIE2z5+ziOid4v6CL4SdC3CyWdecaO5JgaN4NyjBBfJiLfBBq9urmRxfPNjF9fzD953Hz+pU+wM2C68Gm8HQaQB6TBwaDfW+f
X-MS-Exchange-AntiSpam-MessageData: seL2D0mLEOrXXFG20jb7i+WeQp6T4x93eLOqF1KOVlN/+INHZ4OWMnZyAEkcXwUrteWMMEPtfNSk47aWROHoECjau7qrM8JEyQiRH5QWq+xxvSUEJdwUKXHkjpNNv51ZaR5yjzoW/aZT4aRWcDZ7lYGn0QxnRtIMklxOsmFiXbjTqpsV/NpaUB5ks67l5LWAqgul+PW8jK5v2T4X5Zd61A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6701e9-b987-4327-6524-08d7bf7ba04b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 14:03:18.9491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXADf1e1WvzNADJGlHGS9T2agbx9/1Lctd7xuy2g4UYLUlWpXvZ0Jt/k6BEHUuu8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1865
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.03.20 um 13:50 schrieb Nirmoy Das:
> [SNIP]
>   struct amdgpu_mec {
>   	struct amdgpu_bo	*hpd_eop_obj;
>   	u64			hpd_eop_gpu_addr;
> @@ -280,8 +290,9 @@ struct amdgpu_gfx {
>   	uint32_t			num_gfx_sched;
>   	unsigned			num_gfx_rings;
>   	struct amdgpu_ring		compute_ring[AMDGPU_MAX_COMPUTE_RINGS];
> +	struct drm_gpu_scheduler        **compute_prio_sched[AMDGPU_GFX_PIPE_PRIO_MAX];
>   	struct drm_gpu_scheduler	*compute_sched[AMDGPU_MAX_COMPUTE_RINGS];
> -	uint32_t			num_compute_sched;
> +	uint32_t                        num_compute_sched[AMDGPU_GFX_PIPE_PRIO_MAX];
>   	unsigned			num_compute_rings;
>   	struct amdgpu_irq_src		eop_irq;
>   	struct amdgpu_irq_src		priv_reg_irq;

Well my question is why we we need compute_prio_sched here?

Can't we just design that as:
struct drm_gpu_scheduler 
*compute_sched[AMDGPU_GFX_PIPE_PRIO_MAX][AMDGPU_MAX_HI_COMPUTE_RINGS];
uint32_t num_compute_sched[AMDGPU_GFX_PIPE_PRIO_MAX];

I mean the drm_gpu_scheduler * array doesn't needs to be constructed by 
the context code in the first place.

Or am I missing something?

Regards,
Christian.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
