Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9567EC388F9
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 08:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B63222B9
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 08:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FbJV7ise"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B63222B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 910AF6E87E;
	Mon, 26 Oct 2020 08:29:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 042F56E87E
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 08:29:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwtt8CYJ7BemMJcKVzSMvV7Owwv+krt4QKYgo5YQv/MjTSimsIqQQiKA1jlEThkZSyXFVPpCVtRSDBLyXGe5GIqUCdS02mN1urRgx17/gctbUpBYOHhEBhUx3LpMFOMFMyTTEEV18sI0kEkE/18zicgMy29rtRhS+LVyeroezm9r3jttQJ+X6a/v7pFzgQmgyVIdWj6mVf1rgg+0lwJlytlKz4aw+TROabWfMku5LOkwdsjhHHaET5caPJX186z/oxXpZojZc781DH1NvQ13xwA+NDHrENKoInyaZ91DsMS/Zu1LZwBAPgZmWpkMaL+W3oYMN3pT2qExxMx5kXekow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LO+3M/dYvGGQvT5oD68186yvQ9qGbC3jU8P4XF3nko=;
 b=ZC/X9ETH2qRALAZJhqJtMeMqjEo1JDXEbgS0O5PfC4+KLAEOgfmhcAxJyNDVzdEgsKu+eelh6e7XfTByLg2jrXI2xu7vK/hoQJd/0C+ayMhmgrdp97WHz9NRvcLoplKnN/9vEswDsCr5ajXDTkLOvYzwC10R6Z4//ut3V80HYOUgWaS2lrhkWnNxzmHyZiEbS6wtgDefqFCrATKBO622DfQv4BpuBktjqOtgb40k9tZDfoBxvJzQMYv4/yfwaua98IsQXfPY2E5yuFeT5DcrkwrGcxYpzn9B2bewQK9kq6EmWYXOMLZ9JfrKOtxfWQzZMEUNV7e1FMq8dKcXf4zWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LO+3M/dYvGGQvT5oD68186yvQ9qGbC3jU8P4XF3nko=;
 b=FbJV7iseoaHllFnUUQ/yrM9WsQS78K2ifjsLkgw1ElpohZiOIdq7mG/oOZO4fcCqLMpYzmIDLzUJqzTtFOR3x1Sj7B5neYfb15OnMXDwk6Za1Exe6wfUoOkM4FIHR5LbyGRKufXPLfNpF8Vy8fRGNkEgkMTyeMaK4vYbrHz/Noc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 26 Oct
 2020 08:29:09 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::b007:cabd:9ff8:bf78]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::b007:cabd:9ff8:bf78%4]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 08:29:09 +0000
Subject: Re: [PATCH v3 00/11] amd/display: Add GFX9+ modifier support.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Message-ID: <a64cc203-b57f-115b-92db-7a2f95665bf5@amd.com>
Date: Mon, 26 Oct 2020 09:28:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
Content-Language: fr
X-Originating-IP: [109.190.135.109]
X-ClientProxiedBy: PR0P264CA0054.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::18) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.219] (109.190.135.109) by
 PR0P264CA0054.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 08:29:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe111c85-8265-41a5-7575-08d8798935b3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4483:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4483BF22DCE374BA2D0F79E18D190@DM6PR12MB4483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsdPngRddBr9y2Cl7diJ0INABAvDvhjWXBzm0u3O1NIDOdJK+zVVe0s7cs3SM7xzUEVO1z/vsGlgfs2MvhvPtjSBntaSJwuDFBpzMQhzzGjbq1be6GpkfpmVEz0dFUoWVNFsQ06/i/lnd5iRP1oLfXEEj8rrZs0rhoqnuQvUyqmbkgwOdINX4pNUI8BAD9t3gdEKP/hFJC6wLo1Na9j6mWLln5YXtr2oJDENGKF/dBdFqRrXq0MbKDKy+F4vyHAJMOuzLNgV6EmLUabbLDxc4lQ7iROsztf2jqx2x9u/aB42uLjxL5FCWF916Vl8rl5BcH7Dh4surJloxwDLEiNsUJD5CxXNi0UJI5Sipb8IL30eBmxJIPI+SvNOEPdm3BkZaZApF8zgAixOQxU/YiaV+AmKKnbhZRvFQRUApG7HB6IQwBa+OYCyaJHfmqZ5Gqq/s6Fn5eGjvuuTBcYzxQZt+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(53546011)(966005)(4326008)(66476007)(316002)(186003)(26005)(6666004)(8676002)(2906002)(66556008)(16526019)(66946007)(83380400001)(6486002)(2616005)(31686004)(36756003)(52116002)(86362001)(956004)(31696002)(5660300002)(478600001)(8936002)(55236004)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: j+W0vPeX3XsQgJBxhGSK/x/Bpo4hvjlQHxHKag/TYZAkp6pn/GCOu5zoPlFD1/VxEXNYCkj5zYuAdhNm3zU1k/CsVTCZsynbb5/6/9xftzwQjrqkgdz7PEvVvy/1G1u+JJrYa55gPGdaFnmJrTYVFKrFQ3s+IanomjQCD3chStJzbOPtDjOfarvzijLkgiULA03ad7rxE24Y/AQ/7iUStdpyhW7ZPWy5MxLut+pmUWDJrdgCq3vFb9IyF7O/H6aSoRZjibhvsAzfZBYtOxGletHUWx1RlQslDB4abEqIde86vDl5SEc0YFV2VSBfm2SydZB1CfwLV7duVcb4k03Mw49+g/YKjv7JiCdozVjgIEfm7K4Q2BLU8eTy/pnRA9ZRD6u5bx+SyEY/Hl+K3wNwUXMLiXSQCkURJmv3X/w6OeSu6cjRZXMjMKcvPVrV8ah9sBIM34X7YgwUdCFOMnHC0OCrPfzsLyONqo5saAKX7XC6ZxDJ1ZnERNK5lpEO7nTBXtAJU1lIUeDnP/IrjpzcH75zvP1Vc7UFH68s877EVkxwLIncxdoVGpkyjaDgMDFzpt1/yX3lsrBkm5CNue7j+wNEUnig/0fPW+BF0oz5mLtQEU0XlZ1hcGtuGuWMH8FlBOaWdLOtloK2nUSAxb9qtA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe111c85-8265-41a5-7575-08d8798935b3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 08:29:09.5737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDfpoiPLEbGBK0+ZD/CmoGKE6FHg5EPnYorQK2ohcjX0uSCrJ1YKUTJ24KETfC6L59ybDObrKMnSC/RZrNwoVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
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
Cc: maraeo@gmail.com, sunpeng.li@amd.com, daniel@ffwll.ch,
 alexdeucher@gmail.com, harry.wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Bas,

I've been using v2 for a while so you can tag the series as:
Tested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>



On 22/10/2020 01:31, Bas Nieuwenhuizen wrote:
> This adds modifier support to the amdgpu kernel drivers for GFX9 and
> later GPUs. It has been tested on
> 
> - VEGA10, RAVEN, NAVI14
> - weston, sway, X with xf86-video-amdgpu (i.e. legacy path still works)
> 
> and includes some basic testing of the layout code.
> 
> The main goal is to keep it somewhat simple and regression free, so
> on the display side this series only exposes what the current GPU
> can render to. While we could expose more I think that is more
> suitable for follow-up work as the benefit would be minimal and
> there are some more design discussion there to discuss that are
> orthogonal from the initial implementation.
> 
> Similarly this series only exposes 32-bpp displayable DCC in the cases
> that radeonsi would use it and any extra capabilities here should be
> future work.
> 
> I believe these are by far the most complicated modifiers we've seen
> up till now, mostly related to
> 
> - GPU identification for cases where it matters wrt tiling.
> - Every generation having tiling layout changes
> - Compression settings.
> 
> I believe the complexity is necessary as every layout should be different
> and all layouts should be the best in some situation (though not all
> combinations of GPU parameters will actually have an existing GPU).
> 
> That said, on the render side the number of modifiers actually listed for
> a given GPU is ~10, and in the current implementation that is the same
> for the display side. (we could expose more actually differing layouts
> on the display side for cross-GPU compatibility, but I consider that
> out of scope for this initial work).
> 
> This series can be found on
> https://github.com/BNieuwenhuizen/linux/tree/modifiers
> 
> An userspace implementation in radeonsi can be found on
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/6176
> 
> which has been reviewed and is ready for submission once these kernel
> patches land.
> 
> v2:
> 
> Per suggestion from Daniel Vetter I added logic to get the tiling_flags at
> addfb2 time and convert them into modifiers for GFX9+.  Furthermore, the DCC
> constant econding modifers only get exposed on RAVEN2 and newer.
> 
> v3:
> 
> Fixed some typos, rebased and CCing more people to actually get a review.
> 
> Bas Nieuwenhuizen (11):
>   drm/amd/display: Do not silently accept DCC for multiplane formats.
>   drm/amd: Init modifier field of helper fb.
>   drm/amd/display: Honor the offset for plane 0.
>   drm/fourcc:  Add AMD DRM modifiers.
>   drm/amd/display: Store tiling_flags in the framebuffer.
>   drm/amd/display: Convert tiling_flags to modifiers.
>   drm/amd/display: Refactor surface tiling setup.
>   drm/amd/display: Set DC options from modifiers.
>   drm/amd/display: Add formats for DCC with 2/3 planes.
>   drm/amd/display: Expose modifiers.
>   drm/amd/display: Clean up GFX9 tiling_flags path.
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 169 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c        |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   3 +
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 754 ++++++++++++++----
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 -
>  include/uapi/drm/drm_fourcc.h                 | 115 +++
>  6 files changed, 880 insertions(+), 165 deletions(-)
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
