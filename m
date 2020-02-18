Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66567C34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 09:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3135E206E2
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 09:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EWbukQEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3135E206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D81746E9CA;
	Tue, 18 Feb 2020 09:44:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172ED6E9CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 09:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRymQxZTRQDIuvnTrylRkspX17aZBQzzylznpxrj7yWdfq7kL1ZN6CRv4qrruQvuQZ1NJ++CAI0px9CqJnhzS/qmEkIn1o/xNT/cbjdPCvnlFsswS4mKJ/fHvmA8Z9LSVAVbn+y3a/2vHTFyJfi/5pOgQXs11Jejapwna3+u04Z7pmYQoamIC0GH1dcshfyPPyeP+015MZGPfXxKYRbccV4vw5t4lNAmU3T0hYsEbTjgd715325T0jMbuUvSUPPJkj8/Au/Kc/Ui9pmqCe7Jyu68bFjORSRRPiYw24vbO7fTng4K+DAMynhzS8D1CjiAIAowapusU5ViWMAqKY63qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42ae+MAlVypUbCL0/kLRfNG/7jQy7byP5d9UyOxehJw=;
 b=ESYnsCYLM2ssdDdAl6qNTMa65JzE9wGqwsYYz1Aev1lDLH3YEsNVPptbBts46SIVVQhG6vissLSJgbkVf49twoafCRQUUtqnV1G8fMlR2EhfjgquFHCRs9betjz40c4uNZ4VGiHp8qVmPMbStDFCC20+4Dac9WTGnMfB5OyieccMCCu3/5AHN+SSc97llY+vvEWE8MkD5rHwwFmydMCrS+iqCiMP42EtmxBTBsj/+xKhFCRIqBpJ2ZHQkVxRTVJcsH+IZeRRvvtQoEjJbXf6Prhb2SNYM4bS11YHsWDJQw7gbTJludSbiw09axx++Y6WJIpIUXhLjHVvQl9k7U44cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42ae+MAlVypUbCL0/kLRfNG/7jQy7byP5d9UyOxehJw=;
 b=EWbukQExbhaTXYydhqyuC3Gy1M1EW3LBZuF1+uIRCAlAuLssY0w4BABZ+twEqBNNOuC84/4KKlVP9uERX3Jz1y3rVx9dLd0FUkGVBXTuGFIxuaf3CUDw8b5pRBGr3z6NTmdYWnZ9J3Qt1DKrRm7WuqPFPSpZfDWkTEWWqSVOH+0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3375.namprd12.prod.outlook.com (20.178.243.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Tue, 18 Feb 2020 09:44:32 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 09:44:32 +0000
Date: Tue, 18 Feb 2020 17:44:22 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Nirmoy <nirmodas@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix the wrong logic checking when secure
 buffer is created (v2)
Message-ID: <20200218094421.GD6610@jenkins-Celadon-RN>
References: <1582014600-7147-1-git-send-email-ray.huang@amd.com>
 <879e7606-eedb-5b54-5600-8132df620933@amd.com>
 <20200218085507.GB6610@jenkins-Celadon-RN>
 <12b843ca-61e0-5368-eee5-fc000a6a0986@amd.com>
 <20200218093534.GC6610@jenkins-Celadon-RN>
Content-Disposition: inline
In-Reply-To: <20200218093534.GC6610@jenkins-Celadon-RN>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR0401CA0013.apcprd04.prod.outlook.com
 (2603:1096:202:2::23) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR0401CA0013.apcprd04.prod.outlook.com (2603:1096:202:2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Tue, 18 Feb 2020 09:44:30 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d9c102a-8cb3-482f-7024-08d7b4572835
X-MS-TrafficTypeDiagnostic: MN2PR12MB3375:|MN2PR12MB3375:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB33754FC88ACC9CEB95B1E922EC110@MN2PR12MB3375.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(199004)(189003)(86362001)(26005)(5660300002)(55016002)(81156014)(81166006)(9686003)(1076003)(66556008)(66476007)(33656002)(66946007)(8676002)(33716001)(6666004)(2906002)(4326008)(316002)(478600001)(6636002)(54906003)(52116002)(6496006)(956004)(8936002)(110136005)(186003)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3375;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hj8mpoZVNpDhd6PIfnAdzhZnafIFMlk1wcebJfyGyL8ZvdG+kPtzq1/N4ry/wGsOeVGjoX2pKrhwxkxP1z5P6PgxQHzR3WKvlAc9T8hDB1WNexlOdTwFns8RGzBwTFol7wXwCyr6T26rnBFr4n4AzF78tjnIRaoitdb0gt6ykPh3/HCjsrLxziUTgDM158yYVUq+8ApcsQV2jPpxEDe8Gu1gq+MNgj3MVUlYmdxvgtZmHZFV6/sS+Ma7KoqLK36u+CweK5xxntJo9cl0CmcD/DrzCQpJ65EtH5nUpDt/pGPro2adEzNY0okYMRI2katMmHtNVAsdkVglVm/Zl5fbOpTZ3fk6T/EzhPGLnrmxbclhFkw8d4T8vONgZpPJVKI5/iguFdNPK1MadfzkEQLmjyGX3s9fkAm/sIiCex6WfIkrH4FEC3sTCG4gYQIh+HHW
X-MS-Exchange-AntiSpam-MessageData: NH60QbvqCZRXJHOL/60INapyzM7PBET0OhAHTRVbwU4kKFB169GApEU0NBJhMbw+7uvrXC033+yLEpUBPRl9JLOsPL/EkCqoaNTZHVhLtDImn2LgQaYew0qq24Yd1pAPgMytjK6dDWbp/EURC4P6EQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9c102a-8cb3-482f-7024-08d7b4572835
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 09:44:32.7598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUMf3sdJL3MGQQb8JcbJD6CWjrxExXkewPq11HO2YP0H60gR4w3t8QSvDtuz/OSzweQ1l2dTUmsWc/vBMvx/kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3375
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

On Tue, Feb 18, 2020 at 05:35:35PM +0800, Huang Rui wrote:
> On Tue, Feb 18, 2020 at 05:15:33PM +0800, Koenig, Christian wrote:
> > Am 18.02.20 um 09:55 schrieb Huang Rui:
> > > On Tue, Feb 18, 2020 at 04:50:01PM +0800, Koenig, Christian wrote:
> > >> Am 18.02.20 um 09:30 schrieb Huang Rui:
> > >>> While the current amdgpu doesn't support TMZ, it will return the error if user
> > >>> mode would like to allocate secure buffer.
> > >>>
> > >>> Fixes: 17d907c drm/amdgpu: implement TMZ accessor (v3)
> > >>>
> > >>> v2: we didn't need this checking anymore.
> > >> You misunderstood me.
> > >>
> > > ok...
> > >
> > >>> Signed-off-by: Huang Rui <ray.huang@amd.com>
> > >>> ---
> > >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 5 -----
> > >>>    1 file changed, 5 deletions(-)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > >>> index b51a060..5cbc63a 100644
> > >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > >>> @@ -235,11 +235,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
> > >>>    	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
> > >>>    		return -EINVAL;
> > >>>    
> > >>> -	if (amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
> > >>> -		DRM_ERROR("Cannot allocate secure buffer since TMZ is disabled\n");
> > >> Only the error message should be removed, but we still need to test the
> > >> flag.
> > >>
> > >> E.g. in general we should never log that userspace sends invalid parameters.
> > >>
> > > Why? It probably can help userspace to understand what wrong input it is.
> > 
> > That's correct, but it also allows userspace to spam the logs with those 
> > messages.
> > 
> > While the kernel tools are rather clever and filter out repeated 
> > messages this is still considered a bad idea because it might hide more 
> > serious error messages.
> > 
> > What we could do is either make this debug severity or use something 
> > DRM_NOTE_ONCE() to print it only once.
> 
> I see, make sense. There is no DRM_ERROR_ONCE() and I think this case is

How about about DRM_ERROR_RATELIMITED()?

Thanks,
Ray
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
