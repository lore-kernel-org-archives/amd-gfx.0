Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07594C0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 08:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2168E10E566;
	Thu, 27 Jul 2023 08:24:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DA2410E1D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 08:24:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDuILmREqde4Aaq+gtavV42FDMIAtjQN/NuxYY1jL/1Eelsw+IedfrXj0JtyOjYNU+jYSZLHz7yqPPRjgByNSAmxlkht6uAP14wjojyC7CoTTGS/4BBE1+K8+GhjChJjioTPp+B5hlCD2Kq6O+ktJ4aceEu+1psR4ZbluuZPSm5KowLeFCDpIK9c4hyk4J5Arwm3iz1cW9Zj0Az34NziGycXElmJtzNvApDIerNSlaEKmYpIAU9v/zg6EqBNKalkqxH1EsRHVRJhghlG25ECjOGpCyHmjQ2r6/HkSz3SqT7vCIVHV2cz2Wf3AnjEER6QwuZC34ltoSsgMXA/LHlfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaxcGmxZbYftPHpzC14aEZiSpttHfEqJLPNXwTuYFGQ=;
 b=h3IT3jWhVvvAN+PAdXpQO/zGS//AWT+cpYAnbyfq4vjrLTjRQiayoJ65obKzRvoiO1cUukkgQZfDdNimV+x4ajWW9iFRwVY6PATC3+48AewJUSbOOkLoNgzzmNY1L2l/fltz4/leT26qVGY0j6vXa6CKX0sfmcNsdkhPZ5VpxmzdUD5IjBxEsWZKAYYksHVt28KyjRGXb6p8vO2CSOm7rLC+olz5yPCRNYaLnTAZHlHVEYLg6Z+2XkNkZM7NlwDTZiAfkVLj/QzUfCcokIEJahBiKAfrntbEnwA9mCsEk3AsJ9HV7n6JFQmaGUlPhYIu+ERjnoh2YFTu9aGqzpMk5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaxcGmxZbYftPHpzC14aEZiSpttHfEqJLPNXwTuYFGQ=;
 b=yMsvVsk1+c83o+nr4f6SWk0Vkjvhl/wH2HzOt6XMai135hE4A8otgfd3iP+5p7DPFu1FN0JlerwkZQt/n3fuKi4qjpEyjPGP84tJ7k/nO24F/GPTa6X7CC65dxD+g06LAD5Wwi6FPPVdArCgfcoiXuwEgBgwqEIMGv156XE6abA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 BL1PR12MB5239.namprd12.prod.outlook.com (2603:10b6:208:315::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 08:24:40 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 08:24:39 +0000
Date: Thu, 27 Jul 2023 16:24:28 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: use amdgpu_bo_create_kernel_at() to
 create large TMR for APU
Message-ID: <ZMIpvO4RynD1J1VW@lang-desktop>
References: <20230727075620.728235-1-Lang.Yu@amd.com>
 <20230727075620.728235-2-Lang.Yu@amd.com>
 <f786e262-4d64-2274-c740-8a69cc7b8ea7@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f786e262-4d64-2274-c740-8a69cc7b8ea7@amd.com>
X-ClientProxiedBy: SG2PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:4:91::22) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:EE_|BL1PR12MB5239:EE_
X-MS-Office365-Filtering-Correlation-Id: b782608b-109f-400d-dd0f-08db8e7aebe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1h9L+EKVZ+P6+HSKbBvgvp9f2vHCuQxg85LMEZHxqjs40m/fX4nCsc5laqqzy77H9pHuIlk2NmVfm2PAwGSf7g5hSyaapYo6s8DAJqzOIf+CQ5zdU7IORQtGjU9n25iC6U6aN2H5ytVyNotVyEuj2toHeBIj/GA23EnJLM+eETcRKPFw/egCbuC/5twNTbW7+EB+hF/Bxp90V10I1o2OomZJL9jnmSFlXzFvu8VixPZt8xq9khI8R6WbvYwNJ5VwTNPOHkhNSHdUeFLtqqfh9HY0/1+KQiN8vi6nIKSaWyfkH1r77cyu602310pj095HyjK6aoWfaA3+Cp4s6RBWjTy/CB9AO48xfoMHOA+RMQaw95snZjllUX0TLaC8IsRRO04qBXQ/xCh1pmbQmLALulCnMHEMAkqloTjhwAqfkyN3SKoP1GMS8p0hu+nzKx9nOhCq72CAnza5HBPy4YbIpcKN+tHX9izgOLginTFGGjs387buKLCZ2Xk+eJesO5MMF3oN024A2/RvTBMr9/TMHpLZxVOEIuEz+/sV/hVJwHFT0cHJV7Syh6auXe1eDSqS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(7916004)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199021)(83380400001)(54906003)(478600001)(66574015)(8676002)(8936002)(6862004)(5660300002)(41300700001)(2906002)(6506007)(316002)(66946007)(38100700002)(86362001)(33716001)(66556008)(66476007)(4326008)(6636002)(26005)(186003)(6666004)(6486002)(6512007)(9686003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?PM4hdYcGu2gUcdU9nUoZ+CANy6oYo53dgn8oUcBtGMQMf6blnBpq0/bvWN?=
 =?iso-8859-1?Q?QAoM8tFtv4EG43fTfJCwA0ygb217Uk4i5eudhb1b6JlwtNzds+MdPt03rR?=
 =?iso-8859-1?Q?7/+9w9k7mo9o3XQX7qA1kd+rPPbOfdAietk8bgojpzeYqKABgMwQxpmNxd?=
 =?iso-8859-1?Q?1gSNr8WgOC6+93neNEtOeiBZRy5q14vV9wzxHVSnwySTt24I5et+4I3q8Y?=
 =?iso-8859-1?Q?ryqrLBAweecqk6cM5k0FTkW0BQpjwoNizgN4EMvsgMQghvrvuVYnzzatIy?=
 =?iso-8859-1?Q?veHgpWhjMLAy0K1lNZIK7HOh9xObvNflqwtCentM020g61lP09+15Nj+1V?=
 =?iso-8859-1?Q?4TApQDOHmRh+hTC2Ux/vGKwYxXhdIKMDXac/Fh9VRUKsF7M2mmPFMHMtxz?=
 =?iso-8859-1?Q?bK13IhbAxxcj69PVRMJs+VaJzXyMyvKMtMU+jFr23zR3S0+4UAuFE813b6?=
 =?iso-8859-1?Q?t7q87z0GfwHdgvk6IhRjB9szV5r/m9sOEgo1nAxf57HGn7o3lW2yFHBleu?=
 =?iso-8859-1?Q?DhqjD7Qm3uNPLynhpmr8r2TN6ZW2TVnOOqEmL3s2+3AhKJF/FvlAw32rVp?=
 =?iso-8859-1?Q?p1iaZFL1dATv4F13hFBEHYSkYenZPKOyjQrTU1N+2TkDg0MlEFcvZrLPCb?=
 =?iso-8859-1?Q?HUzuMmsDPZHUtJZUjLZE4XJuwQMvs+7pu/u8BpSBn224ADJVxdgUFL4Vr/?=
 =?iso-8859-1?Q?py5XVzLXob69NhqdmWb7vSdfSffK1mzw/h60FC1Hdm9gArN57qQUtuv1UV?=
 =?iso-8859-1?Q?zuRm/Xp6S8Tf2aIrHvHaOaghXMrUCcpFybfnv9ua1o5oEaYSZQtN/QjO1p?=
 =?iso-8859-1?Q?UJ0UxDa1v73HbYPK26tJMCmaeS/JjMsCjldgHFDHsU1Wwu2ra2ytQE+7AI?=
 =?iso-8859-1?Q?GbcTCkXQN6Lj9aetsO5Ns4sGg3mGP4MCkxKKgc9Z6hi2HXN0mXMPWMCFZh?=
 =?iso-8859-1?Q?wlgPNkZT/FVmbp9qHv96hpkIAi3bPXKLxlfGq40hwevNmRhO6GZGNtc07I?=
 =?iso-8859-1?Q?fGEtn8F6Q0YRNr3g8b6rCRXcXaGygrkG3p6RgSOaznxTQ+Ql1apOe/JvQZ?=
 =?iso-8859-1?Q?5Nx73n9St/2dcPS6K2nD9MhWL8T2gfcMLYEd2/kEZz7X+7j1/iBdy8JMka?=
 =?iso-8859-1?Q?FHJ+hLsmcOdX+BPS9jHDC68Mg47uOFDh+S/KgIauGvblKxlomAnD9wE7MC?=
 =?iso-8859-1?Q?KPU0QDGb98LTUw0fhTnIk/cUGaIiqBFsm2EoXi7o/CBxJwuXVD9Gn4E8Q9?=
 =?iso-8859-1?Q?vChcCTsIPHhSSunAzSch+rcOsY2puk8A47x/V24lYXLt2iViJgmUng4LMp?=
 =?iso-8859-1?Q?uN1rcQU7dNug8e2zelB4TLOggvrO95wjzQ9ryWuInTHg8npLwrExq8f3Nu?=
 =?iso-8859-1?Q?bR4rJs+fSJi+fQ0aRrrxD25rHegYmQy0xFE4XUemIOx0rvzH7xk09/v55O?=
 =?iso-8859-1?Q?siJlXf5njV6JucbZG/R+lUxf73En8YPo8O0xYgZin+EW1JXQgPbu0r73lB?=
 =?iso-8859-1?Q?tp3To0uUdAgOkr1Ky8LVGPyFTkUC3TPoxjk2t1zbWjbKlfG5AlUehuT3D4?=
 =?iso-8859-1?Q?64zYdEis11Olt6iLy4JiRK0yys9RUw7woNZvK9RR6PiTNxPYnjug6lefDV?=
 =?iso-8859-1?Q?yU0/OGdIQu1OrI0FVTTJopdfFc9NwntBNI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b782608b-109f-400d-dd0f-08db8e7aebe7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 08:24:39.9197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8actmIF+h4OFIyUtmgaRYEBKXw29XJ7eOhpVxti7bYHHLj715Fb7Jzl9VnZDrwp25KXGMzKHYKuWG/09uNJ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5239
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 07/27/ , Christian König wrote:
> Am 27.07.23 um 09:56 schrieb Lang Yu:
> > TMR requires physical contiguous memory, amdgpu_bo_create_kernel()
> > can't satisfy large(>128MB) physical contiguous memory allocation
> > request with default 512MB VRAM on APU.
> > 
> > When requested TMR size > 128MB, use amdgpu_bo_create_kernel_at()
> > to create the TMR BO at offset 64MB.
> 
> Well complete NAK, you have misunderstood what amdgpu_bo_create_kernel_at()
> is doing.

  OK. Either taking over or creating memory area, amdgpu_bo_create series
  functions should satisfy the client's memory request.
  Anyway, amdgpu_bo_create_kernel_at() just works.
  
  Regards,
  Lang

> Regards,
> Christian.
> 
> > 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 42 ++++++++++++++++---------
> >   1 file changed, 28 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > index 15217e33b51d..2eac82113d34 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -783,13 +783,38 @@ static bool psp_boottime_tmr(struct psp_context *psp)
> >   	}
> >   }
> > +static inline int psp_create_tmr_bo(struct psp_context *psp, int tmr_size)
> > +{
> > +	void *tmr_buf;
> > +	void **pptr;
> > +	int ret;
> > +
> > +	if (psp->tmr_bo)
> > +		return 0;
> > +
> > +	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
> > +
> > +	if (psp->adev->flags & AMD_IS_APU && tmr_size > 0x8000000)
> > +		ret = amdgpu_bo_create_kernel_at(psp->adev, 0x4000000, tmr_size,
> > +						 &psp->tmr_bo, &psp->tmr_mc_addr,
> > +						 pptr);
> > +	else
> > +		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size,
> > +					      PSP_TMR_ALIGNMENT,
> > +					      AMDGPU_HAS_VRAM(psp->adev) ?
> > +					      AMDGPU_GEM_DOMAIN_VRAM :
> > +					      AMDGPU_GEM_DOMAIN_GTT,
> > +					      &psp->tmr_bo, &psp->tmr_mc_addr,
> > +					      pptr);
> > +
> > +	return ret;
> > +}
> > +
> >   /* Set up Trusted Memory Region */
> >   static int psp_tmr_init(struct psp_context *psp)
> >   {
> >   	int ret = 0;
> >   	int tmr_size;
> > -	void *tmr_buf;
> > -	void **pptr;
> >   	/*
> >   	 * According to HW engineer, they prefer the TMR address be "naturally
> > @@ -813,18 +838,7 @@ static int psp_tmr_init(struct psp_context *psp)
> >   		}
> >   	}
> > -	if (!psp->tmr_bo) {
> > -		pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
> > -		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size,
> > -					      PSP_TMR_ALIGNMENT,
> > -					      AMDGPU_HAS_VRAM(psp->adev) ?
> > -					      AMDGPU_GEM_DOMAIN_VRAM :
> > -					      AMDGPU_GEM_DOMAIN_GTT,
> > -					      &psp->tmr_bo, &psp->tmr_mc_addr,
> > -					      pptr);
> > -	}
> > -
> > -	return ret;
> > +	return psp_create_tmr_bo(psp, tmr_size);
> >   }
> >   static bool psp_skip_tmr(struct psp_context *psp)
> 
