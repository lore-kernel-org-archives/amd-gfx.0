Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579B8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Mar 2022 09:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE75410F04C;
	Fri,  4 Mar 2022 09:38:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB6A10F04C
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Mar 2022 09:38:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E78VzlDlOi94pIa1fsv5r6nvrwUb83K8I7o1SH40l1hDbyFjXISGokt1/z9dV7YpUZjQjBDK5q+VQ/NL9nOgsKW3ju3NNg8OnqbK+OnVRBjj8yLz65sfsXexZ5EUI6MYwxMcqbcYbeF/QXwavw5lPfSl9gos2QlNDqg1pg7/j27HPtggGWa1h/Qql8sgqY6Zee+jD+/kmQvs2UpbyvPLYnm49ymPOLpxmvflCE1PPk5W0KxGMkXTkRRXr7FcI58fzX2pHl2IB56QsjLgDhUMtfMf7e8lr7NXZuAxlqYj5lUQeuE2FT7JyzuJqokhv2h0COg7GWgUUxzqS5GtS/S/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Gzv1xO/geoJF1rYOqL13Y3/PaPIyk7UAPQSHlTeewo=;
 b=YteFGgSCbKD2i9Yl6aWeZWQ0IXixoL5uanEX4vgQ29S8hKWQmD0cAV76cyQzkICylMHl4VlUM+GJVrqN/v7iabZgUsash3KHAGvCy0uP+lcAGyG4QpKA/z8css76x2I1cmq2s++TAUWHNo9PeNxe3OoA6sDKmwj/XL2rhw+5h/lXYtYDUDyV+2ULYkPoIy6p+seBdG6yN5HWvewFAefDaR4RwcsCwpTNMGFOVZJS/P3WLOSgqPhFBTMeAXDwDa89+GS77ZahrDiMC4XQCcCDKbOJvrfaibLkov9Lwzkij8GhWjAMRgkVVSX2xfgDh8lq7Uap/GLTASI/RMyz2w/GXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Gzv1xO/geoJF1rYOqL13Y3/PaPIyk7UAPQSHlTeewo=;
 b=jCLZr6cnhAmpzbJgdU3JDLV/P3idd6QT/GK987dpH+GcnwCaPDOPR57q+pVBK3coNrtrUF8Q5Emh3SNjGh6IzlzhgP8pOXAQ67GlXgP49ZcHHKHAt+xlORrCb+yKadsMuuAafJM3YUbsuA2fx20RdK5VHbjRMPW4Ll9bARkZqbI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 BL1PR12MB5271.namprd12.prod.outlook.com (2603:10b6:208:315::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Fri, 4 Mar 2022 09:38:37 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f%9]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 09:38:37 +0000
Date: Fri, 4 Mar 2022 17:38:28 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add workarounds for Raven VCN TMZ issue
Message-ID: <YiHeFIKaBk6b63gj@lang-desktop>
References: <20220304091555.4094582-1-Lang.Yu@amd.com>
 <6edf5bbd-e498-5979-9449-a824706532d3@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6edf5bbd-e498-5979-9449-a824706532d3@amd.com>
X-ClientProxiedBy: HK2PR02CA0209.apcprd02.prod.outlook.com
 (2603:1096:201:20::21) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b83fefba-edd7-4956-5c49-08d9fdc2c1a9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5271:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5271F740AFF822EFB363D638FB059@BL1PR12MB5271.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFJni1TejvUAG/Od/JPpllNvzLsk7/dF8QvX12mbViszVpoH9+IfDgGRNwkdbdxRM+L6ONkw3FUxpI4AODjXXACpH6b4guTKXzR6nt8aMaSopOfLIwoFB5x91DIRCbTQUZL1kfK0oEvAM/Qd6Vdsc2S/G0xptfye/Dt2eLvhIyAZj5xJc3bCIPgIIkMUpFersk81z1rWs+r7xiZgvTLcnL2l4rwD1Mw1PL1K+B5Qs/8ei366khDhxwGECArm8BnE2VZGjr9HB3ItbV8BSTk/KoBKoVoiLTBQoxSo+GI+mhezSGzvZcOaPTOaK/XSDS8eMcTKfFqAHlZp6SDFUsQEc5begV7xifrt/0yTTi8tp/Dw4/SY4aPHIuRuxLzPf1j6pRwuZG/U5M4XAilMSRnAv82i0u2fBmFHI8CnyRBRUbzSgN0p/92C5A8MvvaW7kNpPJlJwQ3i3vEYf1PmREj/n2pE2szAgYElXA6SoPZnZ35/M632hjCPKTocqQCsCV8jlLrmHrnrS3vp8mI6ui35J78MfmI5h3DTxJMeMSQ9C+U/0QnxEM4hnAGrSthpJq9X76jufh7sx0PRMBLtwR4XaDGKZ3z21bXRaMPNpU0GmS79cAv9eSPMGZn9YbgVbB9/3yU8xXPYZF1nJmKEcAGFfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(66574015)(83380400001)(33716001)(2906002)(316002)(86362001)(66556008)(66946007)(4326008)(6862004)(8676002)(6506007)(6486002)(5660300002)(9686003)(6512007)(66476007)(508600001)(6666004)(26005)(186003)(38100700002)(54906003)(6636002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?L0wjUFxkIwoVPX2nV+snZPd15LewXi+kqAlIHzLRxatDqI3BLtHj4nWkXP?=
 =?iso-8859-1?Q?81hmySd039IjKxRWbwTSsmkurHS4DlNqHgV3KatCHE4gWk/F3Lr9UE4IEf?=
 =?iso-8859-1?Q?qJJT4fDikGWEO0I9DlLcjrZYYRkfZXBo6XPzayKn/blVm8kYPaTCRlvWI0?=
 =?iso-8859-1?Q?WVdiPCNZp1bbQF71oYjTOT7ot/xtaWjzXotz2reBmNV4QcKYQ/A44+VnNh?=
 =?iso-8859-1?Q?xtxq6eDp3HxMwotOrvhcz2+CcuMOtjLr31jGKM0/UCbBZXhEi98nny9G7L?=
 =?iso-8859-1?Q?VMZdvZqiKJcPXfqN8+P4RT8f+8S83gaKXAFc2jA4yDMfdATlsVBwZwivYh?=
 =?iso-8859-1?Q?7oL1mUIFJFiyaL/E1WqgznVNZ/VRfaOQ7TY+4fLMFSaXDVSDgixepWeRIp?=
 =?iso-8859-1?Q?ZGMvGA7QCBiuqw3HTTQg9F+apIu2UJ4weDjjEGJIxoI5vhHZxFF28n090I?=
 =?iso-8859-1?Q?ojjB4OB3cRyPvsLei0ybtgdRj/ZTJmYLLn3LWh7CKvxVisbo8oJWdwivWa?=
 =?iso-8859-1?Q?3+YqvwI7mlR6TkifV9wIcXYQMZxsuRapTYux4SGn+OXDA5vYFWaMefPS1v?=
 =?iso-8859-1?Q?oGDkMMChniVfYz/I9IfSdmKqjfteKL/X8ZoXvoU59Ff8AwN5mQOmppsV55?=
 =?iso-8859-1?Q?q/YxBi0FiBvG16MgXrkNkngQKLNBRu6ZQJLMpT14F/A9JpKwt1j1shi6Wo?=
 =?iso-8859-1?Q?J61T8y5J4Y0p8trVzDqAyzdB9FsfyjVEnKGUHLT9+zy2yXpeXfgAaYm8aq?=
 =?iso-8859-1?Q?eV88NciZEez8W1FYMtZszVRxZsBLYZtUDazwuQPY7knpyvjKMcXPccYjRe?=
 =?iso-8859-1?Q?PZpgf75xWvnDv4ry6qQmblDan3xapCuYhBQa5loqJri3vgmbKKhGJrZhUF?=
 =?iso-8859-1?Q?y0J0gjaxNkZQmEseOQ1NfE2GqzVu6PoZnsOZamsjLdILIZ/6S0OfU3UBVS?=
 =?iso-8859-1?Q?hfTR6ZTlv8FzfntTGHJcdV1VdRZHkRf0TDeGaCc3sKe6xCFEbO0zwsCCpY?=
 =?iso-8859-1?Q?L+8d0z/I6bVAU+fEkvXRGzXtjJRUEBPh3ecERVbZKTwRbMfoPlb18X2hcT?=
 =?iso-8859-1?Q?V6mZd1wEZAeygSiJ3dxuZY/bzU0dhDCOYBU2njh//SsjCxpPQsrwHtjOhe?=
 =?iso-8859-1?Q?+TeKXL5RGtOa/WYSr1CjtKc5FM9w/zSqZU53cV6c/3P6UlLioz/SmcvZKY?=
 =?iso-8859-1?Q?+8553JB27PsRl7uKlpZBYeZxBQrilDboVFdPA4wK1K6jBABoXBVYLP0Kn5?=
 =?iso-8859-1?Q?ldIsvVkFReSmFK82vvk9ZrEfGPJrEVezY7VBUp3/CeaOV/dM+sdw/wNBTW?=
 =?iso-8859-1?Q?l5SSt4R58Ur8pooUMTars4OTLVA2w+czXDHPjg/zQsDOfkKSgnOLG6j7jD?=
 =?iso-8859-1?Q?gD/gp0R1DgmgF1mUeovA5gLj79lKZeDN7Q+b5CpdBD1DkVkoMa/zKUJIJu?=
 =?iso-8859-1?Q?/rO8gTkMwxDZU4RBcCdx6TMCryEGesEulC1x5N0632cGn12OWXI7rE3tig?=
 =?iso-8859-1?Q?W8cSr3g2jsH/kyvpmhm9J/Bp/l9e3VC395gFtNuX9/znLt3Ho0L0rXKu8c?=
 =?iso-8859-1?Q?Fn+F7ir8uYAjWGBMPbMdLWQyzvpPk7IO6Q1odOistsBa93fTxEgz0zalBE?=
 =?iso-8859-1?Q?mK9Uz+IyUbdfMdowdus7UpadZtCeQx15UiJUHiJ/J2GQwOCQIWz5qH8U1s?=
 =?iso-8859-1?Q?gfgpwCzaKUFZG3snXEc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83fefba-edd7-4956-5c49-08d9fdc2c1a9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 09:38:36.7188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRgfpfXPgXVYALDCchL8m3FvQB8HygZNmsNpmBPDZ1Fe6Km+7WwapsgyBuBD2elqsfTS3pxw26Ubt77kmL/lRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

O 03/04/ , Christian König wrote:
> Am 04.03.22 um 10:15 schrieb Lang Yu:
> > It is a hardware issue that VCN can't handle a GTT
> > backing stored TMZ buffer on Raven.
> > 
> > Move such a TMZ buffer to VRAM domain before command
> > submission.
> 
> Please don't touch the CS code with that. What you can do is to implement a
> Raven specific patch_cs_in_place callback in the vcn_v*.c file.
> 
> See amdgpu_uvd_force_into_uvd_segment() how we handle the 256MiB window on
> really old UVD blocks. You just don't need to implement the full parsing of
> the command stream (yet).

Thanks for comments and suggestions. I will have a try.

Regards,
Lang

> Regards,
> Christian.
> 
> > 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 27 ++++++++++++++++++++++++++
> >   1 file changed, 27 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > index af12256e1bd3..66345f2ce6ba 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -393,6 +393,24 @@ void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
> >   	spin_unlock(&adev->mm_stats.lock);
> >   }
> > +static int raven_vcn_tmz_quirks(struct amdgpu_cs_parser *p, struct amdgpu_bo *bo, uint32_t *domain)
> > +{
> > +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> > +	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
> > +
> > +	if ((adev->asic_type == CHIP_RAVEN) &&
> > +	    (bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED) &&
> > +	    (ring->funcs->type == AMDGPU_HW_IP_VCN_DEC ||
> > +	    ring->funcs->type == AMDGPU_HW_IP_VCN_ENC ||
> > +	    ring->funcs->type == AMDGPU_HW_IP_VCN_JPEG)) {
> > +		if (domain)
> > +			*domain = AMDGPU_GEM_DOMAIN_VRAM;
> > +		return 1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >   static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
> >   {
> >   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> > @@ -403,6 +421,7 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
> >   		.resv = bo->tbo.base.resv
> >   	};
> >   	uint32_t domain;
> > +	bool need_retry = 1;
> >   	int r;
> >   	if (bo->tbo.pin_count)
> > @@ -431,6 +450,8 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
> >   		domain = bo->allowed_domains;
> >   	}
> > +	raven_vcn_tmz_quirks(p, bo, &domain);
> > +
> >   retry:
> >   	amdgpu_bo_placement_from_domain(bo, domain);
> >   	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> > @@ -442,6 +463,12 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
> >   	if (unlikely(r == -ENOMEM) && domain != bo->allowed_domains) {
> >   		domain = bo->allowed_domains;
> > +		if (raven_vcn_tmz_quirks(p, bo, &domain)) {
> > +			if (need_retry)
> > +				need_retry = 0;
> > +			else
> > +				return r;
> > +		}
> >   		goto retry;
> >   	}
> 
