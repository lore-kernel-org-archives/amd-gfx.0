Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E773CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 09:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8117010F652;
	Fri, 28 Jan 2022 09:17:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B58810F652
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 09:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMzibzSTAnkEic+eXXohHj2YlZswQeUVcS18sDoogJMp2capBkBTcUet8ha1ITdOvzyuCAEI6dP8CpDgV/tjrtRFmYwKq6HpO4K8EfovNBWu4+ZmVNCP+HcR3QJ+Uo4T2o1Q2EHo4t0axkMpJ2dwKzNeFcLo/DdGIBVjAKwg20NN/Y94Dcu0fwA25CgEjyxf2Kof1h/oEZrdQ/7YVdhhRaUMObw1N4jvygEUl4RbP3TUlYWnco+JvMnhTBzW87IkvK3TQszFQKUrHYCxTij7816589lXMH9PwQWzBzEl4skOoach8PN9EQ1TGf78VDZjULqAe06JpEy7wlK2+ircvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qlew3GReGpEIFeFMDLCILjl8jRueWZt8gPD5OgOnm6k=;
 b=SJf4YVkgQnUkTbblsiiLCROWjhfM88JFwkDLIAB/N6l9dh8Ti6tgmX3+w1l1Cv7IwSgST+L/7YfiQdJOiGEDIsYyaqxGo5nORzgWDIvth5GyvEOV0kAPVcs40je25fKATOHgSsXLNOyF1N2jjY7JqJNwVKMq7B8OsrTfVj30RdVIs/softQlUVaAHZYzgHwWoYUSlx8C02Ohdvx3b7jLY6wA6VwdYNdm0uznCcO0evkRV/wRDKuLcZ+pOiZhSIVbwbs0JO+/HVxeiFibCS2FHTK2IRUHL4OTrVKdnagrRP68iFMnZthFhezlAHUcLdDhtM3w4Or7YSMPmSSSmW4MkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qlew3GReGpEIFeFMDLCILjl8jRueWZt8gPD5OgOnm6k=;
 b=37/A+nOCzjelKUMVBg95rFyF4ylZSUVtlU05wb9lGJ8gJJs6hBdpLzFA0TwGopT+xIThEH4fV2FFGYRYnA5e+nnjDFTl8+gYAwU/CyJuPZAk03Ag5ad8jKaG18UlkVGGCmVFiagctr49rOUD7yfW/6IPoiTJf6Yyc3J/fXiI3oo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 MWHPR12MB1469.namprd12.prod.outlook.com (2603:10b6:301:10::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Fri, 28 Jan 2022 09:17:03 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::989c:5eff:f1be:c7ac]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::989c:5eff:f1be:c7ac%8]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 09:17:03 +0000
Date: Fri, 28 Jan 2022 17:16:55 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: add safeguards for querying GMC CG state
Message-ID: <YfO0h5OHkLZj7Dtn@lang-desktop>
References: <20220128065409.1479854-1-Lang.Yu@amd.com>
 <d8bf41f2-6aa8-8af5-c5a7-ba0750549a82@amd.com>
 <YfOuy/sVoKBpJI5+@lang-desktop>
 <e2976675-f3a3-084e-2d90-b3000f216098@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2976675-f3a3-084e-2d90-b3000f216098@amd.com>
X-ClientProxiedBy: HK2PR03CA0053.apcprd03.prod.outlook.com
 (2603:1096:202:17::23) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9f7f433-1b33-43f6-54cc-08d9e23ef28d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1469:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB146960D2E800FD5D9C958263FB229@MWHPR12MB1469.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LsDFxaiXesa4Npzm0g9lHoVjjGQLGkM+ZDDw2653HCvBQf6Dhr04D4C3fLlSGlzBAzrg4d6bI1WwC4T2nEv5kko6dePuBPfS2nk3pn3GxvtQqW+PzSOACHd7Ma+8NSilZ4gdFQaHEIEgO/HheLsMD/PXMQGgZbOiXLVJBgko3rDnJIcbsokFPlrle/RDBfS2K6KJysbYiw9+q5iq9lO2mxZOUzbNklAxGoJWs1kzLlZhizvOETqc5KXDj5/z3m4u1HFSzUZCzkg+ibdhb6t904M0Ea0G1MA6c2NXie/0D1RjEywNYaAJBKReUBbZ+yWb/D6XZErwSDGnannFCE2M4JqK7mziO3bkC8jYAnUwVuSipO6NDURkbGmesYHUFWGsBni4eFpqT3IRVihWgStLdEzc0folZj7uGHG6eTzmDYk8QWXvJ4+fzBFJt2rfCqGtrbZX+miCHGq5cSIv8bMMdQj/WaYafcf5n3EOibqe+GiBXwSeCq8D4FkDjiHxDQILRGF/CiC8Mb3ytAOvjQ87XfOulHQ/nnk5jR1EeJOXWpB+9POF8apv/GC64Pxn0/PeELPQaWupAunH+xE2M2FNPZphftLZNcuKnzytcqeFghyVpgNMccMZVnvMgTHx3dyKk45BCaI1YCPYQ3uT53k55A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(5660300002)(54906003)(9686003)(316002)(6506007)(6666004)(53546011)(6636002)(8936002)(6512007)(6486002)(8676002)(86362001)(33716001)(6862004)(4326008)(508600001)(2906002)(66556008)(38100700002)(66476007)(66946007)(186003)(26005)(83380400001)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vB+6XnytPGgpwv5RJhd5xYs9h9UXE3XxRPEHAPuHFIgl4Cs/j0IoxbEzFuC+?=
 =?us-ascii?Q?YplU843TUB11tPW0h7UPKhF6g4dv58bpjR4IROTDxjYrx/3HgJXZRDRdQH5G?=
 =?us-ascii?Q?E2sxXImz2GrMRRUNgbrgjSRB0k5ro2ehqZUNlDY/2aK+okVPnv5aViS/aSvA?=
 =?us-ascii?Q?K5ropg5cWBsfKiaj1difHfh/SExC9mOZx34ij2iKRMnnKDrXp9X6o1Ar0yye?=
 =?us-ascii?Q?nbMy1BkH2dvjwSJyiQzKz8LuMDN586eFo+SEuaRUK25bluO/u/YDD8zOIicc?=
 =?us-ascii?Q?aND7ACadT8INtf9agncvZJZOH6BV7qKQW4lebtNFRxrm6Gd9TPEK3Flh7Itn?=
 =?us-ascii?Q?QOoXRyYi94rmdwg670VnoREj7iOho4nJABSASiUcI4kH7/qOEYQVcm5E8DTW?=
 =?us-ascii?Q?NpVvuD2Tag9+/esgjlDDKXldRpbolRXA8yW7Z1I7K3BpBY9KtpTn3TWChiyj?=
 =?us-ascii?Q?oLgM16iTAJnq9WZIkKT+qGVSesirJENqNTlB3xpXEpwKyZgn+oMatE2BoYRv?=
 =?us-ascii?Q?PKiPZehOFhWM9l4E/NSaHBVW3+XqqKTgGoCKiZu5guRjAjAY7E193AjjnBg0?=
 =?us-ascii?Q?jNr6qBnxDB2RZAmQXTJK4GCAf2UZzYFcKo2I4RGu55ftJcurj30UCBLP9WA/?=
 =?us-ascii?Q?Qzl2JeMMZ004iwEAn6oB9+8lmsMNA4ptXTFRUEYK1SprvCy/PEov2ZxKWTZY?=
 =?us-ascii?Q?1Rwy8IfKjMdBctCPxjsn6o5n5jQlzlSZcpl6EnMWSd7zVE4G3Tc8YhaRxAxA?=
 =?us-ascii?Q?N+xeD6I7cvN5+AoU5d9bbzotoVKP9243u9C51QlXpisaHgUufjJrRtLNENuh?=
 =?us-ascii?Q?wwxSMwi4ywVI69FNqcTS2+M59wd0m4+wFDj3+AYFS+mlsWKQES7zdurvVUqv?=
 =?us-ascii?Q?povYxAwjrCWpbPSfNCOmDysanBQUknvKmyGdCGnq0CHr3qgm98w7nsKdiCiq?=
 =?us-ascii?Q?WmuPFWckWAkQ5ENpJvQj7Xb66MsjOGqgUtM8tWLZpz/Aqv4lGs8t6ryOH0Gq?=
 =?us-ascii?Q?q/WuyLYzwiuLeY9nuzQ8XXz9lbpn9V0m5kSCHn3xipi+Zd4FcUWf8h3jLs1t?=
 =?us-ascii?Q?867XmieiA/7NlcxulCLDFP1qdkHF9M13Rt8RGMnztj1P6fe1wRbDb4YBFw1U?=
 =?us-ascii?Q?CKGKUtxld5ELjCFt9Wm4YOkwvlN70DoU8mF4aoKCCXwK8qsbiNSoCCAUflhb?=
 =?us-ascii?Q?mPk/bGkFuPcdJgR6v9o482EoUQbgC4djsmymIUSO6yDb4ZevJNdKInyjZvlb?=
 =?us-ascii?Q?nlT0rm7DvTPmzGJb8jzBrJtkk1/4Ax2Pll8KcT1FCzCs5gHINe1nAdh51+U3?=
 =?us-ascii?Q?lpftFSa8xWLLcIqsYgf7LYFvdVtfocInOp6LO19Bah1DOceGy/8EnnzR7hnZ?=
 =?us-ascii?Q?69MdQDS7sfx6LPZqjWU/6qAVlt7XAKxtmYPcplYBzrnZlUhG8mTQlhX4zabz?=
 =?us-ascii?Q?xSJFdIeSssjg7MV2N9WmVCxCu9GBk+/ShUV9GdgHsZmqnjixyfrW2TYfplzq?=
 =?us-ascii?Q?vCZ0kW7ydE9FJ8+rdmFqacIm/zmCAeffYW+jnhhHMfCPPQZJ+gFtm5dDhewy?=
 =?us-ascii?Q?8UdcsByi8r+21vvGJTx0A/S4NWNqOTDaXfzghAzo2+GXRq37GvXBrEGJRMRd?=
 =?us-ascii?Q?OseSbohzWvmZkXhoabhlhio=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f7f433-1b33-43f6-54cc-08d9e23ef28d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 09:17:03.7347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dUWXKpLhDq9eUUOZ34H14DMEpGJK32wxuH2Eb4L8JP2n954DFiZ00Zy4uChhb0Pmq9low39CZcXK6V9AEzgGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1469
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

On 01/28/ , Lazar, Lijo wrote:
> 
> 
> On 1/28/2022 2:22 PM, Lang Yu wrote:
> > On 01/28/ , Lazar, Lijo wrote:
> > > 
> > > 
> > > On 1/28/2022 12:24 PM, Lang Yu wrote:
> > > > We observed a GPU hang when querying GMC CG state(i.e.,
> > > > cat amdgpu_pm_info) on cyan skillfish. Acctually, cyan
> > > > skillfish doesn't support any CG features.
> > > > 
> > > > Only allow ASICs which support GMC CG features accessing
> > > > related registers. As some ASICs support GMC CG but cg_flags
> > > > are not set. Use GC IP version instead of cg_flags to
> > > > determine whether GMC CG is supported or not.
> > > > 
> > > > v2:
> > > >    - Use a function to encapsulate more functionality.(Christian)
> > > >    - Use IP verion to determine whether CG is supported or not.(Lijo)
> > > > 
> > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > ---
> > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 ++++++++++
> > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
> > > >    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 +++
> > > >    drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  3 +++
> > > >    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  3 +++
> > > >    5 files changed, 20 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > > > index d426de48d299..be1f03b02af6 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > > > @@ -876,3 +876,13 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
> > > >    	return 0;
> > > >    }
> > > > +
> > > > +bool amdgpu_gmc_cg_enabled(struct amdgpu_device *adev)
> > > > +{
> > > > +	switch (adev->ip_versions[GC_HWIP][0]) {
> > > > +	case IP_VERSION(10, 1, 3):
> > > > +		return false;
> > > > +	default:
> > > > +		return true;
> > > > +	}
> > > > +}
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > > > index 93505bb0a36c..b916e73c7de1 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > > > @@ -338,4 +338,5 @@ uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
> > > >    uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
> > > >    uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
> > > >    int amdgpu_gmc_vram_checking(struct amdgpu_device *adev);
> > > > +bool amdgpu_gmc_cg_enabled(struct amdgpu_device *adev);
> > > >    #endif
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > > > index 73ab0eebe4e2..4e46f618d6c1 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > > > @@ -1156,6 +1156,9 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
> > > >    {
> > > >    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > > > +	if (!amdgpu_gmc_cg_enabled(adev))
> > > > +		return;
> > > > +
> > > 
> > > I think Christian suggested amdgpu_gmc_cg_enabled function assuming it's a
> > > common logic for all ASICs based on flags. Now that assumption has changed.
> > > Now the logic is a specific IP version doesn't enable CG which is known
> > > beforehand. So we could maintain the check in the specific IP version block
> > > itself (gmc 10 in this example). No need to call another common function
> > > which checks IP version again.
> > 
> > Thanks. You mean just like this?
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > index 73ab0eebe4e2..bddaf2417344 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > @@ -1156,6 +1156,9 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
> >   {
> >          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > 
> > +       if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 3))
> 		*flags = 0;
> 
> Yes, add the above line also.

It may clear CG mask of other IP block. Does it make sense? Thanks!

Regards,
Lang

> Thanks,
> Lijo
> > +               return;
> > +
> >          adev->mmhub.funcs->get_clockgating(adev, flags);
> > 
> >          if (adev->ip_versions[ATHUB_HWIP][0] >= IP_VERSION(2, 1, 0))
> > 
> > Regards,
> > Lang
> > 
> > > Thanks,
> > > Lijo
> > > 
> > > >    	adev->mmhub.funcs->get_clockgating(adev, flags);
> > > >    	if (adev->ip_versions[ATHUB_HWIP][0] >= IP_VERSION(2, 1, 0))
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > > index ca9841d5669f..ff9dff2a6cf1 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > > @@ -1695,6 +1695,9 @@ static void gmc_v8_0_get_clockgating_state(void *handle, u32 *flags)
> > > >    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > > >    	int data;
> > > > +	if (!amdgpu_gmc_cg_enabled(adev))
> > > > +		return;
> > > > +
> > > >    	if (amdgpu_sriov_vf(adev))
> > > >    		*flags = 0;
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > > index 4595027a8c63..faf017609dfe 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > > @@ -1952,6 +1952,9 @@ static void gmc_v9_0_get_clockgating_state(void *handle, u32 *flags)
> > > >    {
> > > >    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > > > +	if (!amdgpu_gmc_cg_enabled(adev))
> > > > +		return;
> > > > +
> > > >    	adev->mmhub.funcs->get_clockgating(adev, flags);
> > > >    	athub_v1_0_get_clockgating(adev, flags);
> > > > 
