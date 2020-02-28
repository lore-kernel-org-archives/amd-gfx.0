Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4BCC3F2CE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 03:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D55E24692
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 03:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LWdpnh4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D55E24692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B126E9A1;
	Fri, 28 Feb 2020 03:30:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0013B6E11A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 03:29:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIic1ywT2pO/8vVvbKiXGEpc4fPER37v6aXxpSf0zxV5vnpRVBcW6ROo73iliumbwQB/z6xItI5/4bXotJ8n3GqTSYGgGRCCA8iZyswD6rRwgDgcLEU82RxQYFgzlN/Y0lebL/2ajmVafBjZK6MxTArOwpTpEtw0Vl1+jR2tCBydsA3Cky16flk90255chWKp4K4PRZscfiiZQ8J5GoCaq3fM9au6RBlkANp0yqmzJIlsh937DesQK3e5iUP8gNFkYZXvSXmeg5XDuvrUFL6RI0jzS9xRyHIN3bamGXfSfJcaUpwgYKW8n8CeJq8aUzS2lxLnUqDdvhS7geLQwVJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0ULi5xQQgnRg5971/Ft/1oTEUbj17IS5VIJsWqtf9A=;
 b=ibi3ssFAA95IT75ikTIHzAr9l6cTJDAtHXBiuI7bbHVMlIFpPxuBA2RpDokOcgUo4X92dHmfkADH0IQ2AsgINIsQPckAYtVSNm44hmyzp5Vh4/GkaN1gvnivulVYNLxHNki0aIcHetPdJVASnOj/9OF1oEqXD0cWioyMPKR74b1Wvifrusgce96Jd7h8dLtK0I0YR9vDNW5l4CSJzAuWO+opb/nlUI+hMOwYxyY1uA1+oYPe2F4+u2tlK4wQpZXFu0KIHurFszuxQ00olUT1Ag/uS5HJ/AF2n2E98AxNmSjMBDgb+T61oofVRwGq+XEZ/4xZKHkg+gnmDujj6mrG2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0ULi5xQQgnRg5971/Ft/1oTEUbj17IS5VIJsWqtf9A=;
 b=LWdpnh4It//tLPhEeXeAHW5nOfwOKRsGCCzdNHTdIrmEsL+QNyxoIpZDbKnYi25TYWFWojL1uqUbSYAKnYOVMsEmHi8cEmICfAVQk1JB1MNDkpVCfl4EtuwPZf3Gu9WzXApEZN08/K7gDoqLUXUPaO9pnLGc+Hz/SbWM1FoKLN8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Fri, 28 Feb
 2020 03:29:57 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 03:29:57 +0000
Subject: Re: [RFC PATCH 1/3] drm/amdgpu: implement ring init_priority for
 compute ring
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200226203730.4621-1-nirmoy.das@amd.com>
 <20200226203730.4621-2-nirmoy.das@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <d76bc281-31e5-d0e2-47a5-6c41bc05c401@amd.com>
Date: Thu, 27 Feb 2020 22:29:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200226203730.4621-2-nirmoy.das@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::21) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Fri, 28 Feb 2020 03:29:56 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4dfcdb9-ce91-4803-8c39-08d7bbfe7bcf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4387:|DM6PR12MB4387:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43873AC044272D286743089B99E80@DM6PR12MB4387.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(199004)(189003)(478600001)(186003)(66556008)(2616005)(956004)(53546011)(966005)(26005)(66476007)(31686004)(16526019)(6506007)(316002)(52116002)(86362001)(31696002)(2906002)(36756003)(8676002)(81166006)(66946007)(8936002)(6512007)(44832011)(81156014)(4326008)(6486002)(5660300002)(45080400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4387;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZuhIjzs1wB6KWoY0yiwgpdFygQEXi3q7quBLu/OlDshnfXururaShoUxLY+X1pPtEZERb1gLPVuHHCR0BzxKoztmlkBBpZYW9JhRKzoxj2ch80RXIivycrbZi+IQocbfyEgzn3pHg0injsnqBFqsyuxH6KPqPGDJWTIHuanBualCZktgRNlOuZUtfow8VpjC9Faj33CvG4KvSqAn1vYtTE12j3QfEDoDWcLbpkXi7ug1Vsq+YRjAdlC4aQNdd+5dI00qfcBxKsbDFzlOB5qRhyCfL+6TRuNdvHPSZS1CnZW5Zw5b3vUSQHm0tRVkoVHMtDCd9p9AM3juUvqOfjzNFLi6nnqpSDdep6+93VXXJhsqgEpILZqSibOdubPcw6Ld8C/ZUcxbD1iNoLuoNJV/BecLLzdoN1WqixwPXfMOFrek8WoNd6+jt+LbwimM6r+GUeADhoiL7T30nr1mvpVhH5n31RJckJBGUT9yRKyRaA=
X-MS-Exchange-AntiSpam-MessageData: wo/RBe/7XgtlwVOaKFjBg70JZZ69qCgtW7bgrvtKwaKvrKzE+LPfrVczrnVTG9V9Vg/xF8gBDDs2suKN5xiTmrFdjWMtHElQpG8N7a02b7bI/TACO7leXGNtzCt1PkEDDQc0p2jkUZjaA26peNpYaA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dfcdb9-ce91-4803-8c39-08d7bbfe7bcf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 03:29:57.1310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWQARK0sWfXATHzUHwly8y3sWMsBUE/NjPIuionF2vH2o7L7hqt23ui5+fIATLAe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
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

On 2020-02-26 3:37 p.m., Nirmoy Das wrote:
> init_priority will set second compute queue(gfx8 and gfx9) of a pipe to high priority
> and 1st queue to normal priority.
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 14 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 +++++++++++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 24caff085d00..a109373b9fe8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -170,6 +170,7 @@ struct amdgpu_ring_funcs {
>  	/* priority functions */
>  	void (*set_priority) (struct amdgpu_ring *ring,
>  			      enum drm_sched_priority priority);
> +	void (*init_priority) (struct amdgpu_ring *ring);
>  	/* Try to soft recover the ring to make the fence signal */
>  	void (*soft_recovery)(struct amdgpu_ring *ring, unsigned vmid);
>  	int (*preempt_ib)(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index fa245973de12..14bab6e08bd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6334,6 +6334,19 @@ static void gfx_v8_0_ring_set_priority_compute(struct amdgpu_ring *ring,
>  	gfx_v8_0_pipe_reserve_resources(adev, ring, acquire);
>  }
> 
> +static void gfx_v8_0_ring_init_priority_compute(struct amdgpu_ring *ring)

Why two verbs in this function: "init" and "compute"?
Certainly there is no need for "compute".
Just call it

gfx_blah_ring_priority_init()

Putting the object first and the verb last, as is commonly done.

> +{
> +	/* set pipe 0 to normal priority and pipe 1 to high priority*/
> +	if (ring->queue == 1) {
> +		gfx_v8_0_hqd_set_priority(ring->adev, ring, true);
> +		gfx_v8_0_ring_set_pipe_percent(ring, true);
> +	} else {
> +		gfx_v8_0_hqd_set_priority(ring->adev, ring, false);
> +		gfx_v8_0_ring_set_pipe_percent(ring, false);
> +	}
> +
> +}

Again. Notice that the only difference between the two outcomes
of the conditional is the last parameter to both.

So you could write your code like this:

gfx_v8_0_hqd_set_priority(ring->adev, ring, ring->queue == 1);
gfx_v8_0_ring_set_pipe_percent(ring, ring->queue == 1);

Further more if "priority" had to be variable value,
I'd parameterize it in a map (i.e. array) and use
a computed index to index the map in order to retrieve
the variabled "priority". This eliminates if-conditionals.

Note in general that we want less if-conditionals,
in the execution path and more streamline execution.

> +
>  static void gfx_v8_0_ring_emit_fence_compute(struct amdgpu_ring *ring,
>  					     u64 addr, u64 seq,
>  					     unsigned flags)
> @@ -6967,6 +6980,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
>  	.insert_nop = amdgpu_ring_insert_nop,
>  	.pad_ib = amdgpu_ring_generic_pad_ib,
>  	.set_priority = gfx_v8_0_ring_set_priority_compute,
> +	.init_priority = gfx_v8_0_ring_init_priority_compute,
>  	.emit_wreg = gfx_v8_0_ring_emit_wreg,
>  };
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 1c7a16b91686..0c66743fb6f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5143,6 +5143,18 @@ static void gfx_v9_0_ring_set_priority_compute(struct amdgpu_ring *ring,
>  	gfx_v9_0_pipe_reserve_resources(adev, ring, acquire);
>  }
> 
> +static void gfx_v9_0_ring_init_priority_compute(struct amdgpu_ring *ring)

Ditto for this name as per above.

> +{
> +	/* set pipe 0 to normal priority and pipe 1 to high priority*/
> +	if (ring->queue == 1) {
> +		gfx_v9_0_hqd_set_priority(ring->adev, ring, true);
> +		gfx_v9_0_ring_set_pipe_percent(ring, true);
> +	} else {
> +		gfx_v9_0_hqd_set_priority(ring->adev, ring, false);
> +		gfx_v9_0_ring_set_pipe_percent(ring, true);
> +	}
> +}

Note how similar this is to the v8 above?
Those could be made the same and he vX parameterized to
the correct implementation.

For instance, if you parameterize the "gfx_vX_0_hqd_set_priority()"
and "gfx_vX_0_ring_set_pipe_percent()". Then your code becomes,
like this pseudo-code:

ring_init_set_priority(ring)
{
    map = ring->property[ring->version];

    map->hqd_priority_set(ring->adev, ring, ring->queue == 1);
    map->ring_pipe_percent_set(ring, ring->queue == 1);
}

Regards,
Luben


> +
>  static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> @@ -6514,6 +6526,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>  	.insert_nop = amdgpu_ring_insert_nop,
>  	.pad_ib = amdgpu_ring_generic_pad_ib,
>  	.set_priority = gfx_v9_0_ring_set_priority_compute,
> +	.init_priority = gfx_v9_0_ring_init_priority_compute,
>  	.emit_wreg = gfx_v9_0_ring_emit_wreg,
>  	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
> --
> 2.25.0
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cluben.tuikov%40amd.com%7Cfb0f769b48da4c3c390108d7bafb4e1b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637183460845495056&amp;sdata=qqzOg3W%2FvkOrG2eglBM7NmByS1ZreZAfigOJWFgA1Hw%3D&amp;reserved=0
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
