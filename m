Return-Path: <SRS0=Y8VF=EX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0125DC2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 16:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9FD20897
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 16:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uwlpliU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9FD20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBA9A6E037;
	Tue, 17 Nov 2020 16:17:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39CA96E037
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 16:17:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Snli8DB1cSDjXFSXECxmxJiSjTNWHQ4V2lH3d50GjRPbyAbrZ6m+xTzvuqtq0b1ufOfLT7+Tkw46aB7DPBcvCs5mTu+fEvPsLi0WRuE+6NEwKM2WW7yHE5pXbtLkX4IBbbAJrNFIDH3xJ7qzSYVPySd2i9j8gTTGwZbnIhs9YR2WGC0YdziReMogc4Z5pT1g571PP9gO/RRyYGYAFjk2U9vxGXLsbN9nUnoO+GlCbptjmWFilwFyYvT+Ijj5+nTr6ViqwfWz9jQ8zhZ7EacDutTi0vlt6Lxxe/MbmUrgV+ykK4mZ4QTAhKTtXGw53q3o/cs5a2LmdYXLsG+1/bK64Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld6+50ZZSFdFzPF+yvgBKn8r+M788WVZrKTawCH96Zg=;
 b=QzPvjXQEsbKOm+fQKmc7LHX/tb/Nv20ZIKfNKFbaNBprbtkpzpDfdTcaJd0WOf+Xn7j2sacuHRvsXMlFiy8BsFpp9BH8Ny7Hm8mAKXycMahhE+m1d6PSvk9Mm7aVRGEVU8GKxHJTGNVDpyQnCJ84lGcOD7XErlhngYrTYHQ2LH31Az1ZfTlJI/cy7f0w7v7IlIEYGmALhfdxdAoVWCCCR2vMpGxaqq2jxYj9NchvW/90MBRL7GU62zjF0dQPmy6ofioMDlyIPUSLoGnXPT7UhjMM4/hOOGHRXpUkwkFZ8VVq2MoBf0cN6M+/oL9VIH7L1DMxPYRGqVOiMRWJL5xj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld6+50ZZSFdFzPF+yvgBKn8r+M788WVZrKTawCH96Zg=;
 b=uwlpliU/gE+tr2KDDA/MYQaFjSnXxKvWY67ofLWA76IGN9RcH0JvwEsmeXGCviFxmkM8BvBvKGcnB71MHH+LecHsRbHb4TyYL0OAeTeJq8yqbqdNVGceSxx03O/SSa2jMWf/6ttNT6URSZRsutlSPE34lsh4oMTTu3tv96y6VqU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 17 Nov
 2020 16:17:01 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::95e:3860:8b43:1a35]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::95e:3860:8b43:1a35%4]) with mapi id 15.20.3564.032; Tue, 17 Nov 2020
 16:17:01 +0000
Subject: Re: [PATCH] drm/amd/display: Always get CRTC updated constant values
 inside commit tail
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Aurabindo.Pillai@amd.com
References: <20201117155121.1522769-1-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <0ceb26a4-a111-2914-c7dc-a98273c299ff@amd.com>
Date: Tue, 17 Nov 2020 11:16:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20201117155121.1522769-1-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::23) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Tue, 17 Nov 2020 16:16:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e28b0d6-18dc-43ff-e9ed-08d88b14374a
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4553ABB90F729FF2BAA042F58CE20@MW3PR12MB4553.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QElVlbfr33cq9kDGcfzOzh6dwWEBY7b5xtUiR4NKTFR25UmpKf9xFwVPAeXIzfE30vrJQxSFWU8od45OtbN4sI2Oweyw+6LofsAmIovcDOO+p/3jk10OOJ+kXDaBbAZ5VrE6Iw3G1AWhQhWyWgPvvB2Q3i4e4TNXAyAsmRAiPe7ZvmwxZpAEjjMW7NuMc/ehko+xfuc6H+3YzhWOJjMtKyb87oVJpNgUjmLGLNWgAOsFjldClo4miVCzuowDajqnja+iwVb1yPw447TK1GcSe4XOjyOcXLvhvZ8iigwMQNaltl8Kvo3xsJlscrJS1vfYABypcCjqWiE6X15rg2/7StuNp11vb4LeTsO3JfeBZkJh4UMYKSHqQhfyvhScE/D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(316002)(4001150100001)(52116002)(31686004)(8676002)(8936002)(2906002)(44832011)(86362001)(83380400001)(15650500001)(956004)(110136005)(6666004)(26005)(53546011)(478600001)(31696002)(36756003)(6486002)(4326008)(66476007)(66556008)(2616005)(6636002)(16576012)(5660300002)(66946007)(186003)(16526019)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RkVhN+V+sVG5tPsvjZfD6U5fGMH3/TMiw2J8USBuQEiow5GgjpJC13+yBOg4XXYwr9doShzPRvkgTe5RP96KbcziP44LUE+c3YFPAAKoOrbPlfviwV/qct8/SJHXG1e/CvEZNEpkibWq3N8PJQZqccBEwfNVSOEd5r5mrwqqeV+sQ3GGt3KlGWvfbSHUXlidB5o66Fj0v990eg8PiRIBnOiH/vIifS26/Hp4w0WO4JOHqvOGfGGl1GvAZXbmt+UN0n0F6nfCpflFpJ/MDG+pH5TV/+zon5POK1dzwxb+6lKMGFRP4sG5V/36Dr8nGlBwECGgSeLODcaewYWuVMgU3iiYF+5KAu0XJPwHO8ySnnEdSx0eb1e7TBtz4EYxLaYLHDNmX1x2oyxjoVIFXjP0ZBTdI/cNTFS0UMwHINLeYjOsLUSFyICd7JhibXGNTnoWWQXYKEb7ryV6XLWXBDR79IoBu2O04SODbdFWyp0tWFUh5N7cPGk3/2vZhksBQr0y38VUf/XR+7HzLx9Hk/0n5xkplC6KbSdEIT8+PkKh68LCOqJKjFGnbwHEjoRJddXul1KRZIjqJdr/MCyVGRDU1YAV3qiRx/Dta5khgk8xGdTBKfPtYpY/KfUbH9mhBjJZAJFIzcBcqPAQ3Csq9ukYfQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e28b0d6-18dc-43ff-e9ed-08d88b14374a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 16:17:01.8667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMSEPs1t3AyQynyn6Th1tZunmL26O1aEOzMKxRv15KxV5dYNfROTL1UEpJGwc5fGZJxh/42dWGPWgBQ5SG4i7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2020-11-17 10:51 a.m., Rodrigo Siqueira wrote:
> We recently improved our display atomic commit and tail sequence to
> avoid some issues related to concurrency. One of the major changes
> consisted of moving the interrupt disable and the stream release from
> our atomic commit to our atomic tail (commit 6d90a208cfff
> ("drm/amd/display: Move disable interrupt into commit tail")) .
> However, the new code introduced inside our commit tail function was
> inserted right after the function
> drm_atomic_helper_update_legacy_modeset_state(), which has routines for
> updating internal data structs related to timestamps. As a result, in
> certain conditions, the display module can reach a situation where we
> update our constants and, after that, clean it. This situation generates
> the following warning:
> 
>   amdgpu 0000:03:00.0: drm_WARN_ON_ONCE(drm_drv_uses_atomic_modeset(dev))
>   WARNING: CPU: 6 PID: 1269 at drivers/gpu/drm/drm_vblank.c:722
>   drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x32b/0x340 [drm]
>   ...
>   RIP:
>   0010:drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x32b/0x340
>   [drm]
>   ...
>   Call Trace:
>    ? dc_stream_get_vblank_counter+0x57/0x60 [amdgpu]
>    drm_crtc_vblank_helper_get_vblank_timestamp+0x1c/0x20 [drm]
>    drm_get_last_vbltimestamp+0xad/0xc0 [drm]
>    drm_reset_vblank_timestamp+0x63/0xd0 [drm]
>    drm_crtc_vblank_on+0x85/0x150 [drm]
>    amdgpu_dm_atomic_commit_tail+0xaf1/0x2330 [amdgpu]
>    commit_tail+0x99/0x130 [drm_kms_helper]
>    drm_atomic_helper_commit+0x123/0x150 [drm_kms_helper]
>    amdgpu_dm_atomic_commit+0x11/0x20 [amdgpu]
>    drm_atomic_commit+0x4a/0x50 [drm]
>    drm_atomic_helper_set_config+0x7c/0xc0 [drm_kms_helper]
>    drm_mode_setcrtc+0x20b/0x7e0 [drm]
>    ? tomoyo_path_number_perm+0x6f/0x200
>    ? drm_mode_getcrtc+0x190/0x190 [drm]
>    drm_ioctl_kernel+0xae/0xf0 [drm]
>    drm_ioctl+0x245/0x400 [drm]
>    ? drm_mode_getcrtc+0x190/0x190 [drm]
>    amdgpu_drm_ioctl+0x4e/0x80 [amdgpu]
>    __x64_sys_ioctl+0x91/0xc0
>    do_syscall_64+0x38/0x90
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   ...
> 
> For fixing this issue we rely upon a refactor introduced on
> drm_atomic_helper_update_legacy_modeset_state ("Remove the timestamping
> constant update from drm_atomic_helper_update_legacy_modeset_state()")
> which decouples constant values update from
> drm_atomic_helper_update_legacy_modeset_state to a new helper.
> Basically, this commit uses this new helper and place it right after our
> release module to avoid a situation where our CRTC struct gets wrong
> values.
> 
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Good work.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1772adcf9f98..91f7fdeee758 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8121,7 +8121,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   	trace_amdgpu_dm_atomic_commit_tail_begin(state);
>   
>   	drm_atomic_helper_update_legacy_modeset_state(dev, state);
> -	drm_atomic_helper_calc_timestamping_constants(state);
>   
>   	dm_state = dm_atomic_get_new_state(state);
>   	if (dm_state && dm_state->context) {
> @@ -8148,6 +8147,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   		}
>   	}
>   
> +	drm_atomic_helper_calc_timestamping_constants(state);
> +
>   	/* update changed items */
>   	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
>   		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
