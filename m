Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0166C34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 09:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE4720722
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 09:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NCuSU7ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE4720722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CDA36E1AA;
	Tue, 18 Feb 2020 09:35:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F016E19C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 09:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSlpSUoeVKhbrYarDXoxpskn7Vif8VNkYRuQYqiA+Y3L84W6VJuAdSinIRF/mVTKnGkgsNSCIz0t3gsSGF1t0acqk7ePVoqKDhLe1SVnbTLPyrkM9GCXDuJKiIz3MtMD1P4dwPnYjacKCL3D+DUgFMRA8H/OEYDtDlI33/cASOPYTbrgAtjXyanyEvhEa5mNg00B8dSmXufuN/AGliPf9GMqAjNiykRVH+IthH2T8/45Tr3jHO3OknjMuIEZw2tBQiOdFVAzUxRpxIPLXc4rLm0uaWGjveP9uZWG7Ncdi5+NyCM9RjSK+3Tfo9dpmFX7a2oUMCFCVAVCPA5mqTwTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bu23Tb45NfEPKQ3r32BJ9gNBLXPMn/rGrnK0OBQOVxE=;
 b=lUSAUhZAvQ9D/0dvCscHVGQsqj0igBfYLGTTqenyP5DvmdvzU41v2x9Ida3p6ECU9ij8uPx535YgtbWYVF+09ml03XTUtrBSQkExTFvb2w+JGSjI5YZD1Gin2Spo3eFsQXj0h7ftatUxMsZaYwMWBoge/DWxZRdbjq3R204DuDOy6SU7gBZooTeE9+2Dq2BBpKaGXhAHCqbCBIp3G+NzHpw2dNWgXFs9jdp/s0x3jWoUMs2wB7KBrKOk9ZLe7GWl3riUK2O2E+2r+WS1hyUwHP9iJTU1kNW79WhXWH818q+XxmGE40oOZokIhXWTiUfnJ8EK0eOcsPhtOOr2uHGFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bu23Tb45NfEPKQ3r32BJ9gNBLXPMn/rGrnK0OBQOVxE=;
 b=NCuSU7ua6k7tV3ekkVkXYEK6ov7RwUR73qw0cH+nmllI6JM0WeSlqwIyraA9c+knY0YMB9BExkGexKQcEIVegm0o19T7LQBVLSas9gNrMMME7iblHHXnYaVoPIJVpEsL20coaNvlME/ANOwirx/PsK3q8kflD8WR9QzoEitnX6s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3086.namprd12.prod.outlook.com (20.178.241.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Tue, 18 Feb 2020 09:35:46 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 09:35:46 +0000
Date: Tue, 18 Feb 2020 17:35:35 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix the wrong logic checking when secure
 buffer is created (v2)
Message-ID: <20200218093534.GC6610@jenkins-Celadon-RN>
References: <1582014600-7147-1-git-send-email-ray.huang@amd.com>
 <879e7606-eedb-5b54-5600-8132df620933@amd.com>
 <20200218085507.GB6610@jenkins-Celadon-RN>
 <12b843ca-61e0-5368-eee5-fc000a6a0986@amd.com>
Content-Disposition: inline
In-Reply-To: <12b843ca-61e0-5368-eee5-fc000a6a0986@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR02CA0175.apcprd02.prod.outlook.com
 (2603:1096:201:21::11) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR02CA0175.apcprd02.prod.outlook.com (2603:1096:201:21::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23 via Frontend Transport; Tue, 18 Feb 2020 09:35:44 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81c2cf68-4f6e-4c73-75da-08d7b455ee64
X-MS-TrafficTypeDiagnostic: MN2PR12MB3086:|MN2PR12MB3086:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3086DD40BC2403DB57F920D2EC110@MN2PR12MB3086.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(189003)(199004)(6636002)(4326008)(8676002)(6862004)(6666004)(8936002)(1076003)(81156014)(81166006)(66556008)(5660300002)(66476007)(33716001)(66946007)(316002)(956004)(86362001)(6496006)(2906002)(16526019)(9686003)(52116002)(186003)(478600001)(54906003)(55016002)(33656002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3086;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8if02EGXrzE/FGqMA6mYYa9Peq8j2BU2/vN2ZuLpHAHU03cXrf6ozDzKQKRTlh8JyITKn5cTWFnsDeGhKNRpU0FKbxrPIFWUs/MLlVjX1+hzZNrbIzz4MFrU2CbzvLB6YluF8STXen4XAGRv0yYmim4g9IeA0KJRLyHrYgous34i2yM6J92F+6h33jijMX8jvkAxDbEqXf3KbmT2ZqgdqYAMePNzBSV9xjNl2BvulsIMP78IPWr5RXQB2UTpk0pZE3WRlMxqAwhDDM4m5Y+pYr4Xf3Nr8AezZPNBjpmZlF5NOuV8UKZ3OtyxkrCu1x64eGqF2xKK8qZIcYm/sj+4tac0YSVtCskTlSrhHEo79WWMJ/8ergueVumzDoHhQbQngdXTQU6amJoZnG2bOokh8NGw6PyvC+al65B0eMCi8/mcE1gktPJ8LqHyttRtBpk
X-MS-Exchange-AntiSpam-MessageData: XeK6Zfbc6a4myXHGrFNlhZ3BcGS/ECzz1bJ9H9knvTLVD1QJYhZ6QsicDegzdKzKDTpoxBPdOiOtlhY4eZjVpBNagApPge+iJe/4QQiQPvEalQtnAbSL0LRZKzIt5/513EKB9arL+jJ30kMeH/PLJw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c2cf68-4f6e-4c73-75da-08d7b455ee64
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 09:35:46.2954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qf+taomc+bvQ0XO9oIMNXElquZZhFaVqjxq6JkjCPpbD+xpHmrf7tFEiToez3YuBDw+n6mrAAnaH36Fr8u4xfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3086
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 18, 2020 at 05:15:33PM +0800, Koenig, Christian wrote:
> Am 18.02.20 um 09:55 schrieb Huang Rui:
> > On Tue, Feb 18, 2020 at 04:50:01PM +0800, Koenig, Christian wrote:
> >> Am 18.02.20 um 09:30 schrieb Huang Rui:
> >>> While the current amdgpu doesn't support TMZ, it will return the error if user
> >>> mode would like to allocate secure buffer.
> >>>
> >>> Fixes: 17d907c drm/amdgpu: implement TMZ accessor (v3)
> >>>
> >>> v2: we didn't need this checking anymore.
> >> You misunderstood me.
> >>
> > ok...
> >
> >>> Signed-off-by: Huang Rui <ray.huang@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 5 -----
> >>>    1 file changed, 5 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >>> index b51a060..5cbc63a 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >>> @@ -235,11 +235,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
> >>>    	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
> >>>    		return -EINVAL;
> >>>    
> >>> -	if (amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
> >>> -		DRM_ERROR("Cannot allocate secure buffer since TMZ is disabled\n");
> >> Only the error message should be removed, but we still need to test the
> >> flag.
> >>
> >> E.g. in general we should never log that userspace sends invalid parameters.
> >>
> > Why? It probably can help userspace to understand what wrong input it is.
> 
> That's correct, but it also allows userspace to spam the logs with those 
> messages.
> 
> While the kernel tools are rather clever and filter out repeated 
> messages this is still considered a bad idea because it might hide more 
> serious error messages.
> 
> What we could do is either make this debug severity or use something 
> DRM_NOTE_ONCE() to print it only once.

I see, make sense. There is no DRM_ERROR_ONCE() and I think this case is
not very hard to check. So let's remove the error message only as you
suggested.

Thanks,
Ray
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
