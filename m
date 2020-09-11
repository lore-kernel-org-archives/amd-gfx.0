Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9EFC433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 17:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB76214F1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 17:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aoKk0+kc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB76214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E25DD6EABD;
	Fri, 11 Sep 2020 17:08:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E91AB6EABD
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 17:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8nkdiVcilTQcHeBAQgvGur3BFeuI0EgyhPXI0sjBnXngFYNuzS1TW0cX7ZbdZ/2154w4duEnRv2EWreAtL9aHrXQJrHHblaX4oVVoRPJsIcaPdocaSfod1FXDyDi+7l2EJPJcXjkVhyZXdKHqM+p2iohdAkK/tH2XK0EXTDuxhSIbg4V4szKG6yqlHDOxFFlh80fKNv92r8bETN1g4KhNJPIxcp+TiHv0kzC2GnJMT3T2O8dBQ3UwTRWki6Mg6Nh4j4PUF779bHpTsln87NiNfyrku4QlGLpRkKx/Xv6j+5GjPNYzcZQaxYpKIA/GedmtOFyjARr9YDa8oKqRtu9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBK9P+7mOgeG9nodJihCp0cJKEiBJDm/Mh/Vk4caiOU=;
 b=gJiFCTTrjEK6ZT8UxXTqxtOEKW+1su2xPnbM07hXnZrWrUuZ+fdw8sMA6gexGCfDGqsUqipvuTCuXfH/9Exd66G1efGzcm127MikBRTVzWJ23zkFMjeHm2FTXsLpVXUvzZXY6bGamc8taHNwNmU+CTD1xC0VNFuRwk1qOdbs3JjyELf3LMe93oCqau2w9UC/bd9GYk1tITDouWDjjniWfUEj3aeDe1dD3v9S23MVOn1FnHlXk5mLzH/ocLe3mHDhzl0zionjpDj7P0/TJHxVLK4WPww5FGnEpVPNzX/KklsQ/ChxqFEiNESXqMQoCH9z5/0KAtu2crfX3Q5bzEgyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBK9P+7mOgeG9nodJihCp0cJKEiBJDm/Mh/Vk4caiOU=;
 b=aoKk0+kcU2akgfAw3Q3oAbEeM2QY6WORcrdpOBOOc1JtHw7w1FbwfnMGUS+DoxPRo+uK5ldMvIhI50MfAnjXvKwI4oktSmYeqT+c56cqqZpVS/Ss8gkJP0fsjtKl0HY5CCktgcM/RMdnEdkgh5O+sRkkEu9l+QR1H0dw/JOIRSI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3143.namprd12.prod.outlook.com (2603:10b6:a03:a8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 17:08:06 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::754e:8f27:157a:9101]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::754e:8f27:157a:9101%6]) with mapi id 15.20.3326.030; Fri, 11 Sep 2020
 17:08:06 +0000
Subject: Re: [PATCH v2 3/3] drm/amd/display: Move disable interrupt into
 commit tail
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200911162709.87720-1-aurabindo.pillai@amd.com>
 <20200911162709.87720-4-aurabindo.pillai@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <7aada9a3-3222-ec5b-b82a-f0b21ea2d469@amd.com>
Date: Fri, 11 Sep 2020 13:08:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200911162709.87720-4-aurabindo.pillai@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::33) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0064.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 17:08:05 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65518f94-dcf5-423d-42f5-08d856754025
X-MS-TrafficTypeDiagnostic: BYAPR12MB3143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31436ECF7EDAE3A3602E5531EC240@BYAPR12MB3143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KQy4Oy7u3QfMfqBja70D2mE8/xJWDBPqyeBD7PlMT8yq5gFwGkk4Ffe3mSjHPVnRclNcPJ0Pr83LsYwZKnLuFuO0wmEEZjM4M5uQdbxw4JYKhAUVO0hEQ6NkhThhQB0uV367p0fFX3iLkHFMcPMHXY6WVVAgZSerNw4//QAzSnblcAYelclelUNGARvzXo8wBiCIklsasrHCT2n7cKSNlgWD4eT+ZMgwo/MFKNh338BrJcOfmQuTl9UQ7n8c+Vw2+NXG87aMnaH/ujnnIjYxeUPVoHYiVk5BgGSTN5/yvMeQ37p7bAYUFfR8fL0QJQ/HQfvA+tlZnUKjEhTikiLhZAf3leiGv8P6NRQvBv+3nAzGUOMP1zQXOvTePz5FZ9u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(2616005)(6666004)(8936002)(16576012)(8676002)(66946007)(16526019)(5660300002)(186003)(83380400001)(6486002)(478600001)(956004)(316002)(36756003)(31686004)(66476007)(26005)(52116002)(66556008)(2906002)(31696002)(86362001)(53546011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: V1BN5qQR9Mhk5ty99X58iuWKLIwas4rg0E2r8MfGfA7upYfjm3Qdr+W5M3+QipqKeE2Cd2WJyO0I1TSVFmFx+12gRGWzcB1vj21/tqkXK6rzZeQhpbZDUPWt9p/Q15pjpKbTdlbQLXEHylzFLeHxIJEVWN+jIaIKhPh4e2uW/Nlio6fbOwuk9SBkF1jQMucJXhXJN29mF5B/DmHMzpIBl+vsMb48tfvwyAKYhJKJEOBG1JJZPi9sL1soY6c8nJ0efVOAIZQSngBUi5rD7bNDUjic4PTs/xsuuYHaGRsdA4TWUs8D1F2+cCUQdDngoKa/dp4QmbH3uhgi+Z9yTeQ2ynjo8IvSMZfeK4a8VM87PsdO0ZBpIetMW6/BPtQJEAEY81R6//pQdiRioLkXzOwF8PVGVMXDO3CbZhh2W2v59NuD4vzlwatp+oBazOKyg4jjFGfwuJk5ho9k+W2ZrOS2dNOExBKdYIXut0i3EXlr59AJvWALvJRjWyYMTMMhg+m7bx/OiWq+D67Nw+smKAE3Mtol0s2Uj/JBeqAZTFxXnVmlWqR8NwvTRpQhHY1uQ40FU7rxmhWibSOH6vJW+5b6yce46DrZ+dOeLXrg4yzP8y62VE5Jr30/eTchpYk0b9uCPB9LD/U5wRsaXxxUNDgc+A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65518f94-dcf5-423d-42f5-08d856754025
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 17:08:06.4289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vjwAz7E3nR9Aclm3RshraAjGg39X80C1OkSmqy98qC9VrtDUc+8I2DMok0zpiLNi2ynLYvsqxx/c/e0CjHH1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3143
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

On 2020-09-11 12:27 p.m., Aurabindo Pillai wrote:
> [Why&How]
> Since there is no need for accessing crtc state in the interrupt
> handler, interrupts need not be disabled well in advance, and
> can be moved to commit_tail where it should be.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 41 ++++++-------------
>   1 file changed, 13 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1455acf5beca..b5af1f692499 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7488,34 +7488,6 @@ static int amdgpu_dm_atomic_commit(struct drm_device *dev,
>   				   struct drm_atomic_state *state,
>   				   bool nonblock)
>   {
> -	struct drm_crtc *crtc;
> -	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> -	struct amdgpu_device *adev = drm_to_adev(dev);
> -	int i;
> -
> -	/*
> -	 * We evade vblank and pflip interrupts on CRTCs that are undergoing
> -	 * a modeset, being disabled, or have no active planes.
> -	 *
> -	 * It's done in atomic commit rather than commit tail for now since
> -	 * some of these interrupt handlers access the current CRTC state and
> -	 * potentially the stream pointer itself.
> -	 *
> -	 * Since the atomic state is swapped within atomic commit and not within
> -	 * commit tail this would leave to new state (that hasn't been committed yet)
> -	 * being accesssed from within the handlers.
> -	 *
> -	 * TODO: Fix this so we can do this in commit tail and not have to block
> -	 * in atomic check.
> -	 */
> -	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
> -		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
> -
> -		if (old_crtc_state->active &&
> -		    (!new_crtc_state->active ||
> -		     drm_atomic_crtc_needs_modeset(new_crtc_state)))
> -			manage_dm_interrupts(adev, acrtc, false);
> -	}
>   	/*
>   	 * Add check here for SoC's that support hardware cursor plane, to
>   	 * unset legacy_cursor_update
> @@ -7566,6 +7538,19 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   		dc_resource_state_copy_construct_current(dm->dc, dc_state);
>   	}
>   
> +	for_each_oldnew_crtc_in_state (state, crtc, old_crtc_state,
> +				       new_crtc_state, i) {
> +		acrtc = to_amdgpu_crtc(crtc);
> +		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
> +
> +		if (old_crtc_state->active &&
> +		    (!new_crtc_state->active ||
> +		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
> +			manage_dm_interrupts(adev, acrtc, false);
> +			dc_stream_release(dm_old_crtc_state->stream);

Please include this dc_stream_release() in patch #2 as well to prevent 
memory leaks during bisections.

With that change, this series is Reviewed-by: Nicholas Kazlauskas 
<nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> +		}
> +	}
> +
>   	/* update changed items */
>   	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
>   		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
