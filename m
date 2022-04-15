Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56DDC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Apr 2022 03:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D2110E6C0;
	Fri, 15 Apr 2022 03:20:46 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95BD810E6B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 03:20:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1Lgy6fZQRQ2U0XdN+2re0/bt5OqdPUGL9mNtRYiJPkXEBo0FX7AzsUcYigUFEUGWLfe3OfWkRaoqJyg3sQGF/76CxqbBD2KsZOlXZ2XM1cIyqcIh6hKw4JtuyG8+NsXNh9L2VYAQp4Ziixqs2hdHsS8138o5mCzT3nNxRgM5VeD4fUPZ7Rp5pqwp1ItQzW3HiSpsJ5D0+bH3WrwLvUvg9WafqDYAyPTJZvlVz3sW15wg7aEHwi9w9eoGA4nFtDa2+dBkp3Een+DdnZ6VQOE1fsOvHUWAVLIPQAucB7c6UBVv6WGCj0rrlr3q6L563pN9QoOM/Q45o9n+LIrMlq/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn/ecDBVQouqHr6wBr26xx5AvX6wvpOgIlSCMvum0qk=;
 b=QYxiccYun31vktppTdv5TFoTukUPSsiL4Y0zpCnc9sPuVK9MiNzIYWAifW3MZj4g+Gu5MAngqSK9ekwLXXquORbQbQii5SiyczLelXGWE4qQG1NLY4dAIc1gkkne7vR1XFY651lYgULyKjeacqf0NP8FdtxqtrNlnISX9qGugDsUddcjJjdK2UkgGdU62VPLCzkOMz0cUFfAgtjBf7UdZTu12DsVPykDOEZdXcXJWOfZSmP1n63QVzcNpHeKtumYmG8Q9hCvPvC2Ug57xER5SSoZhJdpG4UYvb3cTmDArh1B4hk5p4rS5uOgCABGlcVCvauZ2I97Qbyu8vNSWt75tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn/ecDBVQouqHr6wBr26xx5AvX6wvpOgIlSCMvum0qk=;
 b=SrLP6glNN+zdwfo3hN3XJhHnKOrYzffhXlwk2pUQDAmD0XGC8YEYSj3ZNtI9b/dI42HZWkBREWt2x+q48BEne7cdd2OZ4KqRvZi+3pHEe9x2/r5Wy1+RkNPBGaX8romlJ2tW+NAtcj7N6q/lfRQhYLrCHNvHzKeksPfQTW0h7JA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Fri, 15 Apr 2022 03:20:41 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::4d1:7b99:6fa4:dc2]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::4d1:7b99:6fa4:dc2%7]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 03:20:41 +0000
Date: Fri, 15 Apr 2022 11:20:31 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH] drm/amdkfd: only allow heavy-weight TLB flush on some
 ASICs for SVM too
Message-ID: <Yljkf/yGk8YFEV9R@lang-desktop>
References: <20220414081909.796653-1-Lang.Yu@amd.com>
 <e0a1119a-3cb4-4449-142d-a51baa8ad396@molgen.mpg.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0a1119a-3cb4-4449-142d-a51baa8ad396@molgen.mpg.de>
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f203c54-33b0-4855-b04c-08da1e8eeb62
X-MS-TrafficTypeDiagnostic: DM8PR12MB5414:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5414361A0222573DE492636EFBEE9@DM8PR12MB5414.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ENA12v2WdE6WS/6Xr5hLcMkmb87XYGvPNfUgac8RdpCR8J14tyYidNEMckLEupWPRpETqSIDU/tTsBy7029GJlZy+9OOHQL07Lksmal5Aet5iwnxUaDHbTOry4NeHKL4uoPGMr6Ckpko26xow0Bq52lfd+1uvP4EBKcc+/UKRCQlU3fbBdciXflfEMNUauduG0bksEDaAwCO8aNjv9fjDnn327DtuiSw3fUfFVye+nm7vVuqV9BpvyMombui99+e6BMU1Zg1YG/hiUz52ZSU4mR8cchcVkl4/uwVCZedpkEsewe4IQ2Nv15QwRMG5Mw05LiKV6XTrYW6Zk6ZtJQjfb9JsHubDhDPZqIi+909WiMeogmWWK9uWrv3L+xm7dawwYYZpF8ol4+24CfKyahVZyd0RjnI8CRef3U3bUPyyssuwKKrNlUXe4T7ssNdqT+1ZDapmEAlVC/Sd8DzRRZaVfNwHo3dgax45Rkh6gCilSfjqkq018VVkU91sn9Pk71mtgy+EumU+qih4L2Mzg/KQ75xWlMG3aukdN244YeRP4ZRSH9ASPYraNA3jHvFNxU5vtgermLWt8/Q+iDZy1bKTsqQEyYKGTN8cUgOGiIaSYdEe5gzt8a3alkiedVdR3VKBZJCfchn6S9vrfe0Y+ycwvQzLE+Ct5P8ZhDrWvXaF+xp3h9tCs4NO+vroI6iinBhXjG09pJVqQY+uj/bAjwdAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(7916004)(366004)(26005)(33716001)(2906002)(83380400001)(186003)(316002)(5660300002)(508600001)(8936002)(6916009)(54906003)(66556008)(66476007)(8676002)(4326008)(6506007)(6486002)(6512007)(9686003)(86362001)(66946007)(38100700002)(6666004)(16393002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bf7I3/IKG0Y38xSL96w6KOWxE65pl0UmMDLywGGG/xz0BaojHPkBwBvq+dsK?=
 =?us-ascii?Q?+I8OSqQSjPYDuSTStMM0GC+avRJ8RbYo6D+PkJSKDqxTOWe6iybCJ4OMXixu?=
 =?us-ascii?Q?N9b6epfNZeXyNT1ujGQs0YmE1cmsoKR4AsbNpb4OLe5Q8urexyGgDyzLvsjV?=
 =?us-ascii?Q?wptwpNp7nQOf2S83RdE1HcI6IusiDY7z9S8yn2Ltfyk+h4G7lzFE9ctHYWH5?=
 =?us-ascii?Q?0/BQJUAtFUTiCNrbemTY+DT8ucfjW1/mJgf3HXhGvTKY7OO+JldG/Eq7EFRS?=
 =?us-ascii?Q?cGSx2aqOcqDtMgEiY5p5VLj+OQ4bsGd+ns/UjOF0M7qSW+24fHjm4fTHpLBe?=
 =?us-ascii?Q?DxaaA9l++2n3ycKO59Ft3AZPSP37zVcHvsszEhO61TGPUAFWHBIqxH69btpt?=
 =?us-ascii?Q?8+zj/exOOTnnRLsp6clBgEFgUlZV/IeaAK2pAyKz2Thh1QxH3KIw8/tQe/xm?=
 =?us-ascii?Q?klFbn931YEws02o9fLCwqCi/e9iBvRA+QX7OkioCkF/SWObZCjZkIvwKU52l?=
 =?us-ascii?Q?fIAAvAHLbWm8SjScF8/BjSe38Mj9UqHKDZZnokyfJoWdA3cWdAw8MqHjYOEe?=
 =?us-ascii?Q?BD39FZA8Xf/Gz77iK6kxhUnSzjD03MnmpG14Wqd1S/Vw+qebQMuT5xKD3rfI?=
 =?us-ascii?Q?V8kZqGWKLfOb83M0nyzuKNpvk1Yw+tqzUGxy2mG1BpO3X7M7a4PMqGKwjqNR?=
 =?us-ascii?Q?ujinJK/xubYjF/gjYorzGeynegCpMtLBJaWoNqQ6800yUNEI0ya7eqEu5TYE?=
 =?us-ascii?Q?GcDe7Xxs33zIEkaRCqPaQ4RS6hRE9JYeGtrYp9qsb1Pfk4eHARea+1YAnjig?=
 =?us-ascii?Q?chFGMj4nAFKabT9zPeVXhrFDOH6ruaxScnkAPmLT6wJXPmcHMDQ8AzXuXskT?=
 =?us-ascii?Q?jo3QATLMrbE+94SFikFSLj8RuNMwAOtfh97FUXwk8/ujmDSjBRU4Dds7/3rR?=
 =?us-ascii?Q?xR+PoRTRPoPaHThXZ+yipoFdwh759vrC2poKIN/kyVAorU2C6tz7g2KlppdP?=
 =?us-ascii?Q?E385xBCYXqoQiH1bBKQ05GjxOR+VntpJiIcAUfET+XynRu8RbfgP7CCHM/Uj?=
 =?us-ascii?Q?Rm+Egs6x9CWW09QpffVIm9Y3uG0eIaR1phAyGs3mmrgVvVrjY7Hu63We5NaE?=
 =?us-ascii?Q?5W5aMS/Fvj7KCP2b/3frpX56hav8vX17cY62+bXMBlkbmu0b6OWufU3dHGnr?=
 =?us-ascii?Q?o5zXGnM/Te71kGtBGLLqNy/HhuTvbr/Ib+gcpzd4wNVf06KsIj9CaZkzPw7E?=
 =?us-ascii?Q?GiJ5OHz++gVsy39eF/3fVrayC/iLlN+rw64q49KaG/Qg7lra9VlZPVutYmJo?=
 =?us-ascii?Q?Cx5qp0M2QIhU9Ij2PP0krE3k/WYZYRjg3iaCh+UEQHL3u5gqUB6lSNU4oqs1?=
 =?us-ascii?Q?JYmdLAZ9adBjzTXCZG+ZTDbjmgeCKu4YyKsfm4k6O8nSZqKi6LVzbTx3V7jf?=
 =?us-ascii?Q?6B6nEIB3kL8NwFHLB/jKVUPxgRAt0rBGfOf1AKwdIwf3veKkSAwRdmmd+m+x?=
 =?us-ascii?Q?HDBEeCEYo+rfTGe5URxlUh0mAEujQiiVvk/n0+bgawDvYp6ParXdUCA92Ko5?=
 =?us-ascii?Q?kU4dBUh4THaXRSte4dQB8kJaIw19skub00IpjgwpKge93rCdUx/rZ99zJMUe?=
 =?us-ascii?Q?neob36lYjnbPICXJ93LBh24+T2gvXTgwlOb5eqK+oOZQApmYrR0Ly3GReJs2?=
 =?us-ascii?Q?BQ4ah+r7xXh+73gH5kA9qbDIUPFdxMqu3dbt0UOTQiIEHKMv81fF49zuBrRz?=
 =?us-ascii?Q?NCRwCY4MgQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f203c54-33b0-4855-b04c-08da1e8eeb62
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 03:20:41.2929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNglv4pi/eJpJSxvKbW8udo3Dor4mx2TW73W3JTYSx0XYE6ru00zgjmMFws5OybMYS1Xhz4YXFLw9wQiyObcig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
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
Cc: Eric Huang <jinhuieric.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix =?iso-8859-1?Q?K=FChling?= <Felix.Kuehling@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 04/14/ , Paul Menzel wrote:
> Dear Lang,
> 
> 
> Thank you for the patch.
> 
> Am 14.04.22 um 10:19 schrieb Lang Yu:
> > The idea is from commit a50fe7078035 ("drm/amdkfd: Only apply heavy-weight
> > TLB flush on Aldebaran") and commit f61c40c0757a ("drm/amdkfd: enable
> > heavy-weight TLB flush on Arcturus"). Otherwise, we will run into problems
> > on some ASICs when running SVM applications.
> 
> Please list the ASICs, you know of having problems, and even add how to
> reproduce this.

Actually, this is ported from previous commits. You can find more details
from the commits I mentioned. At the moment the ASICs except Aldebaran
and Arcturus probably have the problem. And running a SVM application
could reproduce the issue.

Thanks,
Lang

> 
> Kind regards,
> 
> Paul
> 
> 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 --------
> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 8 ++++++++
> >   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 4 +++-
> >   3 files changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > index 91f82a9ccdaf..459f59e3d0ed 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -1128,14 +1128,6 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
> >   	return ret;
> >   }
> > -static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
> > -{
> > -	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> > -		(KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
> > -		dev->adev->sdma.instance[0].fw_version >= 18) ||
> > -		KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
> > -}
> > -
> >   static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
> >   					struct kfd_process *p, void *data)
> >   {
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > index 8a43def1f638..aff6f598ff2c 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -1328,6 +1328,14 @@ void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
> >   void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
> > +static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
> > +{
> > +	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> > +	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
> > +	       dev->adev->sdma.instance[0].fw_version >= 18) ||
> > +	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
> > +}
> > +
> >   bool kfd_is_locked(void);
> >   /* Compute profile */
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > index 459fa07a3bcc..5afe216cf099 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > @@ -1229,7 +1229,9 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
> >   			if (r)
> >   				break;
> >   		}
> > -		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
> > +
> > +		if (kfd_flush_tlb_after_unmap(pdd->dev))
> > +			kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
> >   	}
> >   	return r;
