Return-Path: <SRS0=3Gw3=DQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BD5C433E7
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 02:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5CE206F7
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 02:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uJUXtIAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5CE206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F8A76EC0C;
	Fri,  9 Oct 2020 02:42:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A8C66EC09
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2020 02:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJrnGeyo9ZynoKt/Q5LdjSLjkpS/eDtjecjJBrsxfZ6j7APbxDic9iBRse31ZubIRItu+YNHfjxi8VHCxeNLLj+LpH4l0e9EIfSoctMWixRpUhUE7tMC460zEZcjIaBN8SYnS9YEvCZh0pT91EsrB+UEY8k06OsQHgPcEagsT8u8u2Yf/pyJzoaZi/dd5+QFPD6WOdvEjnGxyYVTDgKqYltCc76pKWohWgE6bTMa53yNBNza2uf4TBl1dUeEtruu3hqUGh+L37akLD/n35IEhhbUWzuAofqNVc0eduvSBCvb3IL20yrKyXd0Ts85Xncp4loPralgg1uLKQcZUTuD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIkm5YytmX0LH8JG3ITzbat4xAtBjknHO9BGOTRhY3o=;
 b=K3XX5OfdDcU62nhote6dyOsWVp0xjXK3nOigCFXiE2lKxZgOt+D+uN73STSBtLb2JublQmnu86fuyPL/gTesiYic2i6MqzOgfYUUs7it8/D310RnxPjxhHK247O4RrOYA9OLlfg4ROeQ0b2MXg/z2DOO20RHiZB8Vz7X06OGKwzYG9Qx9njWpZcFuzx17WqoKjN8CMGM4FnYJR+24k2c8tZv2ZsjmHMYKS2jBMKPBMyVzeS1ogeWEg2kQq3vycFdSwtpvTt5Xp4JE6nMQ/fZxBUCGg6JI71r3fhEgaqRAht5Q4P3sy8gZcyL//dC8tLycQyBX2s7VqEunyJN9iVIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIkm5YytmX0LH8JG3ITzbat4xAtBjknHO9BGOTRhY3o=;
 b=uJUXtIAcHMekFdeZpCHjonu3u0eKkWn/Cz2Eg0n7rQ3YAAcDFPp9H9N4oUegIhBQqR6FIpq1RU0pmXoQUvvgPFrwZb/Zk9mvT/Yg8DT+xaudtjUo7CVohYISW3ZORYQhd8CqW5+EiBZNXdjV3fs6TOq3Ig8hrodNE0FtLDKUT7k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.26; Fri, 9 Oct 2020 02:42:16 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3455.026; Fri, 9 Oct 2020
 02:42:16 +0000
Subject: Re: [PATCH] drm/amdgpu: Remove warning for virtual_display
To: "Emily.Deng" <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201009023406.809601-1-Emily.Deng@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <f9fa23d7-a3b3-a519-d41e-4a2facc2e433@amd.com>
Date: Thu, 8 Oct 2020 22:42:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20201009023406.809601-1-Emily.Deng@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:ace0:9ec8:79d5:6f98]
X-ClientProxiedBy: BN6PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:404:121::30) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:ace0:9ec8:79d5:6f98]
 (2607:fea8:3edf:49b0:ace0:9ec8:79d5:6f98) by
 BN6PR18CA0020.namprd18.prod.outlook.com (2603:10b6:404:121::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend
 Transport; Fri, 9 Oct 2020 02:42:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df860301-d7f8-4e7a-7be2-08d86bfceef9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4402AE99D2F29FC1DC6A6180EA080@DM6PR12MB4402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:313;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yeu7zXjOmv4Cfz9QlxpT7j8gNL3uxxvzWsmSH1OYlskHjaURl2bnSFg2oXp1gFeiZAasmHp8LmpN5QSZb0wkwa/heXK9ge+q1tJacP424EA+0FyY3p56tDWsRT03pgvehI7GSLXnMQwT1zaHFlVPswY5sQoGtJcjfSq70utY3Ls6sj23Xo/r+yM7Y3C85XazX4OuY0L2IbmLeV5O3LbGyYCpuTQa+YY7p05N3IIQJGEnXMqLfrKzYuho7G2OoaWElAJ09BKpRHIq5d9spVz2zkxc/wcC1fQiqQfcqECiNjCfdVZrXmh9Fn84GM9p21mHWjkEhUrJUyujFS77ShM+pKNGrI2PlkG+8TFuv6sFoP81Lm6zlDEMfRw7BwXRo19d
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(66556008)(66476007)(66946007)(2906002)(5660300002)(52116002)(478600001)(316002)(8936002)(16526019)(31696002)(186003)(6486002)(86362001)(53546011)(36756003)(8676002)(31686004)(2616005)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: T/gpBaWmfXj2EtWl3gHySKquF41YME2LTIvvh3fGgXZwu9ut0wpdze7sQCrm/bxM2wBx7en6AKNT/8MTYuexmEukrAXJYahqgZu9yxcTnA0NCw+a9hYfpDwrZIYAbrJXgdL7oH63MNSCc45Xh+VJdm3AG85osgd8CaUDan9nRNaC5+pkrFQu5VLJt0ZDu489ENFczvP7JcMSxEKs8WO/KW6Xg+zqc/D1/wgXDLwDSCsHnYNYL92RE78BaVQrip4hQtuU9gio5IyrpIYcIkb4TdCTMoulRsaQ5bnHb1lAYqpuCZWcj9gkapJUeZL6Wt62Nxfum18CVsrWiXOMBZC3cDXU9LQtVUQH5iDslDSOtrTWYz0DvFyAVUt/2u5qQAUqK2h53V4quZ9ISotpibK6va5n69mMeXIXpY/cdnjxdl/TireimI2J8+uk5x3VZBWfhi+eqsZVQ+fGW05erJlC53RLTMYfBd2M8/GI5MQjf+UtJcJLlSWROt3U07+qr5tpo4dPML11uxmntZ9uSpjHf8Il/ksm3Z76ZXJ293Z//2cyH3OELFUvn2VWnylkIUAEIIYEgeKMpRMt0eNdqK5rUJgeNSlX1YI8coBLAfPfU7xKiHCHBA4kSEDye9wzGL7SL6q2gQ/rYSINysGkWUQaQT27Aq8qd5+lrWtEIkKAYHTm/SV4f+4AY2vXj6LO1o03iBQXqsrLZOiPa23dSB7NWA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df860301-d7f8-4e7a-7be2-08d86bfceef9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 02:42:15.9761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T50/NGmZlnfGIWRWEAXs62RHlXk9zNrwMOUGBjTfr7zpaTE2XKAS6BAq8yHsi8vu8WJRHno7+0fdAgMkq3/+cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
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

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 10/8/20 10:34 PM, Emily.Deng wrote:
> Remove the virtual_display warning in drm_crtc_vblank_off when
> dev->num_crtcs is null.
>
> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
> Change-Id: I755150a32478d8c128eed7ed98a71175d2b3aefc
> ---
>   drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> index 469c05fd43d5..b4d4b76538d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> @@ -174,8 +174,10 @@ static void dce_virtual_crtc_commit(struct drm_crtc *crtc)
>   static void dce_virtual_crtc_disable(struct drm_crtc *crtc)
>   {
>   	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
> +	struct drm_device *dev = crtc->dev;
>   
> -	drm_crtc_vblank_off(crtc);
> +	if (dev->num_crtcs)
> +		drm_crtc_vblank_off(crtc);
>   
>   	amdgpu_crtc->enabled = false;
>   	amdgpu_crtc->pll_id = ATOM_PPLL_INVALID;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
