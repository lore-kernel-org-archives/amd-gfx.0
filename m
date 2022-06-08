Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B464FCCA482
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 02:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D9CF1129BF;
	Wed,  8 Jun 2022 02:22:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D827A1129CA
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 02:22:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKbgml4bSvkaUajrjSXhhQ/Lh0H1Eg9cY0soGQFZrSxBiRsUt/h8HGvDWa7hI2Og2Hjsh+0VqsIxbcxgvFkFcLQJ+u/Z6L4+5/889inSDFY0A7BCsUi2QT1ST8qS3/4bATe2mtK6cEUdbM6zqYHb3KyYizmZ4ur5Qdb9OZ4TOYh2LOuFiT900LzBZMizmfZXSQJE94vBxS5+rEiG9YA8/9/KThIljfhid7QfHI0GBqaNQIroba3Mx6nE6cRwpuHDNojs+VfDbAFd4U1vjbLM69cjXAg1ESGCdna9riblquyyfCq4Zy5dX4AlFzfri5EgM7Ng4ghXsopMii44YUO8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXwXRbOAMrs66kp8W+XR0pKjsZw2feP+0t4ANoi7G6g=;
 b=HwWEgRhAQUlxUaFLnpnJMdoQGSb1BV/2Qz68BpL4ycb4rqzrYhwGLTYhntVJpyIepz8SwwXc9GCqd3hLpglKpGDZ8fuh+ZaRBQsDEPX5lzbECkd4Xe2+ntmDDyUtXUQ6hsgXike2rNGtLuRRj91p7VZoPIqDCX8Tt5jblS3aAXOKJKDEhzW1+v77fGNhYMfkgWp4MGQ7KFYcyWSQsPUK5ZS2HZaH2IO8JIjoEI3bv2z4q0riRfb+kh+uyXZnBVsbHv1HCitV3g6TQwokxFF4paBr8to3nAd2ErtLK+Gh22mrPu2gUPfHWIXuoFh21Mb0Sj+GWFupH5sieQWSz26oqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXwXRbOAMrs66kp8W+XR0pKjsZw2feP+0t4ANoi7G6g=;
 b=icNaD5jBkPFoIg5y3djqTzHsU/Iz2UlFUU6AC4ug3jrJnBuPJ3cEuyupn+U2lw3dYl9V6rzCM/tDYHVCxabwiPGrykmJranVJyhoGA6XhIvCClaOOTYbif11nTgRz67+AQWLdSYmADXXKhKVMy/we6ZGwC9dwWMIMaElJWFM0Fc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12; Wed, 8 Jun 2022 02:22:06 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5%4]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 02:22:06 +0000
Date: Wed, 8 Jun 2022 10:21:57 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH 3/3] drm/amdkfd: use existing VM helper for PD and PT
 validation in SVM
Message-ID: <YqAHxfxEX1bitk96@lang-desktop>
References: <20220607095947.120493-1-Lang.Yu@amd.com>
 <20220607095947.120493-3-Lang.Yu@amd.com>
 <bed3638b-5b84-e7a4-669e-0c930b66ad60@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bed3638b-5b84-e7a4-669e-0c930b66ad60@amd.com>
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9639dcca-6a5b-4977-2a71-08da48f5aecd
X-MS-TrafficTypeDiagnostic: CY5PR12MB6105:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB61053C80E7276713F05909BDFBA49@CY5PR12MB6105.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hb5KluwwwZylH27Jo1NVYb8pUdR+CaKvx06nVswIGL62w89cIdc1hp6CVZKhwOQ6a7BLfuFA6pFucn751b26QxrDWLV3EkHiSfRThXnx0NW77b0g42BOYqbfMDi3Dryqasm8Q/AbyYtOmkFL6lEw4oV3CqBILp6hKtfc963KBavxkzsNc04jE98wmsLClfTEtVzHWHMoVmR4+jo74TVryUWv83b7I8lIMQ/3g5g3I2bwkgoOJU5n9qN13BOiIK2lHWyOuUPDwQf6wGTONE1Hc6h9GDsIViN6Df7cMpcK0OlowGTh0HhLoc6siL+JgmlhWwW2fAHFVeZkByenBR8YwK75pXOlcGq1s8VtQKmflZR/fBJHkS+imw0PFikLKAXatzaH4CM9v+8vsS7AVPNLX6BXUR1aRKeuCE+MBTvUr6gCfkjKKw3EcfpnmH2ZojGiSwa3YSnJsi2DKlDjMVFfBKA46wjlhJA7bq7WPeT+5SYJOTIlq2ty+zxwJw0/vlfa5GOLOIuAxsc7c2CDS80CYgI19GTjK8I4UAYpc2CDivbK2Fk0z49TLLydUjTo78lFlFqobzm+pGHRt4685KdQbdwrfhm/ybFg97DR7378dRFKeSR55H/eVk4pkUJDqXYTx/NvKP2npvhGvKQUJXxWNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(7916004)(366004)(186003)(83380400001)(316002)(66476007)(66556008)(54906003)(4326008)(6636002)(33716001)(8676002)(66946007)(86362001)(6486002)(8936002)(6862004)(508600001)(6666004)(2906002)(38100700002)(9686003)(6512007)(26005)(5660300002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?adKmrIPPARJReKsHEpqmdcPVNS8UUGhE5n/ORAkkUja/7M9AuzkQAzJaXk?=
 =?iso-8859-1?Q?a9EYGd1g6jq+LfJj0y0NsMEmZejaJOYv7iL8DKCua9iW6S9S0h4Up77IMC?=
 =?iso-8859-1?Q?523thVZEVSaxQeg8Le9kjydiPvyFc1eg7vxOKqBDoCJf5hndzV8kiZcEZI?=
 =?iso-8859-1?Q?6/k1TxfH+vktGQT/4LgPZ2JcJap2EWmquChn4xVehQQjpjNrjWt89H9GQ4?=
 =?iso-8859-1?Q?cBFeb0f2NIiv6yMrmUw67OqRCFqAF+mfA8Ee6VVKj0xx4WVwz4VvMCvzwf?=
 =?iso-8859-1?Q?z8yzMYQM8tizBSkHAYNQNE7bGoz8NHbJeZIrSmdW+2GlLbSGyiBYhxYZjT?=
 =?iso-8859-1?Q?+HZdUKxqtyUEcUSh0QREJQWiGIZXnV8FeVWD1Np5C6M2yvaJm+NhaBLH+W?=
 =?iso-8859-1?Q?Gh8fs78ku4cZuoggfV0Q3dRC6e3ae8+LyzqkZ28Cq/dx75i9UNdXqBzarn?=
 =?iso-8859-1?Q?BP46Fgz5ahjM7ddVG/EdFMN9DPmzPG70rJWez4yXQpve81Lhw5oFvwV9AR?=
 =?iso-8859-1?Q?k0T6GSxtXWlfgtk+FwWVct0QknDhGkYF5xVuVvZzWYzk+SoYI3tpL/iX+7?=
 =?iso-8859-1?Q?v8kvth0LtPJn05LPl18svo3o3xEj/4WZslf5iCM2957xQIyqFS1+wJYzru?=
 =?iso-8859-1?Q?sH7k1miK+WM591/G/2T6dCzX38LsuEEPheQ17rD73ttFrd8a+CtY1HXen6?=
 =?iso-8859-1?Q?oh9NNW07gcwy8Rb3WyMUyRkDrrtgkYYLtRhBbj0Adeer2XJTWsBGWTPV7l?=
 =?iso-8859-1?Q?mnoE0q5zRsexJ++44W+04FyNz9F8WbUA2WUK9vC4D+U+HrvFYR2OTss05Z?=
 =?iso-8859-1?Q?i7Y5IVMjTgpcM6qqlLkpnjx7zP9PHdjw0ZpLrBCh4LGHvjYxqu48ZcBWBK?=
 =?iso-8859-1?Q?2r7GCGIrAf3zNgXLGHsQ2b8RAfKk+gPiRCoIxXtg4wYX14nDdOpUGiUgNd?=
 =?iso-8859-1?Q?Prx5OL+d6yP51PQ/X7HgWhCHLSXiJbZmQXVXXRHtzhgf1bXy8D9g/qIK/s?=
 =?iso-8859-1?Q?00nPbLXJSJPf5CVbjtOhweTkVYz7eMPlJpJCAhwtP4wchPSC4GFS+8e+kW?=
 =?iso-8859-1?Q?JMHg7LDWB3vuOlTRw0jTW3mprHFclIDWe33a4jxZuPX7qMrsqrdOMZF9Fa?=
 =?iso-8859-1?Q?oxdD77rIPZPWQi2HEyfIa/AwVCcg+JcfFZ2BFjI5FBTeaafymBNbWTXFas?=
 =?iso-8859-1?Q?rLQAQlDmKjyMCDvHr6hXN349H+y4BoINPEZsc/+mFgqHELEz95NHjunTio?=
 =?iso-8859-1?Q?ykPYnTgSZivmwOf6KN4eoMB+hvpCGIoEyR3LHkHFK6ias+LBYmZjx8z/zF?=
 =?iso-8859-1?Q?u/qHTLw2cZI7Mn+ILLNkp8HyL91Q7WwwHCKRyY51f7obpdRFqCW1JhMKSl?=
 =?iso-8859-1?Q?v9LQZvT2n9M0AopphzwRPN1sg2TVc39zm17Qg54PzlVkyZxYL8toPH5hSQ?=
 =?iso-8859-1?Q?ZEBTD6nLNhy1NqGOKt6If5sT9EYUubcBtPH5uSxH+8R+lXu9fQY2qNrUB4?=
 =?iso-8859-1?Q?HhFVVR+yzsr5g8LUSxUbnKKB0rOL89xfIqSrg/ADi1hXv/2n6QcMU0sixy?=
 =?iso-8859-1?Q?wVd20HKnihUtSAgYrtVqRPB5rGAvNkcON4x6FCv+1xZHy2uF+9dS150xuD?=
 =?iso-8859-1?Q?gEpxEw2/j6QiuKdtJsDeWrk/oUapJ9Ye0fMAxl7RLlZY8hL/R5d3qN9MdA?=
 =?iso-8859-1?Q?EYmtDKBpnwCdMa3cQzlIk5+RBMUQEtdybsvhUmw0gbXU25lPXaf0ywe7SQ?=
 =?iso-8859-1?Q?BM16bejO4mwRQAOEALswJgCkHSgRBhLtbOnithGGdVeVOB0YOqr+dNB/xv?=
 =?iso-8859-1?Q?Zzo3NSSk2Q=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9639dcca-6a5b-4977-2a71-08da48f5aecd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 02:22:06.6352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rig0qvQdqA4PfjS2QCaYJPFeL7bm3653YVshvHhm90iCQpJaU+nryxHuyjuNZfu8V37eYfgbdRbsk0yfa7YPrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105
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
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 06/07/ , Felix Kuehling wrote:
> Am 2022-06-07 um 05:59 schrieb Lang Yu:
> > This will remove some redundant codes.
> > 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> 
> The redundancy is quite small, and amdgpu_amdkfd_gpuvm_validate_pt_pd_bos
> and amdgpu_amdkfd_bo_validate are quite a bit more complex and handle more
> different cases. Someone changing those functions in the future may not
> realize the effect that may have on the SVM code.
> 
> I'd prefer to keep the svm_range_bo_validate function in kfd_svm.c to make
> the code easier to understand and maintain. If anything, I'd move it closer
> to where its used, because it's only used in one place.

Thanks for your comments. I got it. By the way,
is it necessary to update vm->pd_phys_addr here?
I noticed that vm->pd_phys_addr is updated in
vm_validate_pt_pd_bos()? Thanks!

Regards,
Lang

> Regards,
>   Felix
> 
> 
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 +------------
> >   1 file changed, 1 insertion(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > index d6fc00d51c8c..03e07d1d1d1a 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > @@ -625,15 +625,6 @@ svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev)
> >   	return kfd_process_device_from_gpuidx(p, gpu_idx);
> >   }
> > -static int svm_range_bo_validate(void *param, struct amdgpu_bo *bo)
> > -{
> > -	struct ttm_operation_ctx ctx = { false, false };
> > -
> > -	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> > -
> > -	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> > -}
> > -
> >   static int
> >   svm_range_check_attr(struct kfd_process *p,
> >   		     uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs)
> > @@ -1428,9 +1419,7 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx)
> >   			goto unreserve_out;
> >   		}
> > -		r = amdgpu_vm_validate_pt_bos(pdd->dev->adev,
> > -					      drm_priv_to_vm(pdd->drm_priv),
> > -					      svm_range_bo_validate, NULL);
> > +		r = amdgpu_amdkfd_gpuvm_validate_pt_pd_bos(drm_priv_to_vm(pdd->drm_priv));
> >   		if (r) {
> >   			pr_debug("failed %d validate pt bos\n", r);
> >   			goto unreserve_out;
