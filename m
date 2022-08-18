Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E129C25B08
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Aug 2022 01:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8917DAF179;
	Thu, 18 Aug 2022 01:54:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D60946C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Aug 2022 01:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuqBwaZiM0t7uD+6yZjkq6euAkZu9Slew2rUDA0QrwdYU5+8AeNyTY57iN2VMNZoLj2pnVDRvTaX12mJyv//Bd2EQgaZEOencu8vwY5sDF8akjMDhivy/UOmKBoLkSh5JWAJcJnNbF5ffzRN0oJLvP0A9ZEo02AA4pGY46ayHCqZ/V8Iq5hbij0iCzzBTAD4cMtaEofVe0JVPW2TL8lDVOf0lJ8F+YmKimDZayEtCCILTZVWA4qg6Z4QF3OHhInzAN5SjOzZP3zcrcra4J+Qj0u71fmYZowBEuQMFIufOMiLTkH2UDQgeZgPLwm7aDV6wpRkMFVw/gDBmnGxz1XB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDOnSkkx7bOU6f4Bo2Fblf9ZnWodCN125BsND5CJ78g=;
 b=cn5ZzsuV7Mu1LApBJFp1GUxnpGUnUiHHi/sUJTP2bb8sQywYHvZfhqImR3nFVljrUKE9zHnKsTLeMiKCKRQ5FvpcG+VWJiwleoO2zxlzUg1ZwmbnmPAcQQubRh/weiAYCViDaxqwnBSgdFzhtXb68o9aV/UZ4FGSI2yD6cBJElwSqSelWOfdyv0A1XcgoepvAlFamEWaFH75Dl+L7g0sQcGTp8dQoLlZkQQENbOZ9ccGV4nPY02fKBTe23me8sslBoO1ZsctLDeET9rdMqG8gM5qsU/m0vajKuwaA2tXDs1n/rmishdwZLKbggaFcehGhixSUpIMhaoUa5HfaoKn/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDOnSkkx7bOU6f4Bo2Fblf9ZnWodCN125BsND5CJ78g=;
 b=wYeAiTKSsiG1k3hthON6Wwc3RFFJvvcitMPnSHJTsY5OfCePxT8zA0TThZbCkLpqoWv5EBUK5kbl4FC0cke+tcvkc/B5LCEZPF7Bq2/+PZugzxhOEOynGzej8uhgON21DV2/5IO+UBwXgktE5YT8iTokpDXB+mTSuS0Vi3egadI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB3915.namprd12.prod.outlook.com (2603:10b6:5:1c4::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16; Thu, 18 Aug 2022 01:53:46 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::4c72:7cbc:e401:c43f]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::4c72:7cbc:e401:c43f%7]) with mapi id 15.20.5525.010; Thu, 18 Aug 2022
 01:53:46 +0000
Date: Thu, 18 Aug 2022 09:53:34 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>,
 Jonathan Kim <Jonathan.Kim@amd.com>, David Yat Sin <David.YatSin@amd.com>
Subject: Re: [PATCH] drm/amdkfd: add family_id property for kfd_node
Message-ID: <Yv2bntl7o8B59C6k@lang-desktop>
References: <20220817030926.80377-1-Lang.Yu@amd.com>
 <cc0d3857-0839-00ae-e820-863e02d07549@amd.com>
 <f1bbde75-c273-9a90-f966-bb670e3b24d6@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1bbde75-c273-9a90-f966-bb670e3b24d6@amd.com>
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b26d3c86-4f92-44d3-1e1b-08da80bc7ccf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3915:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xIn127fY0Xzw2wIP4LMcpFxfm8XRHVeSlQ5T6EAFn40bZXTfjfgHA1i0O8MyMRjk6Jy9fWGh2CPyyMrnj0OxgccAsXcbCEYMQ316GrafOohtsiWQhGq9s7/uowva24chwxeDvH30O2W7xuspDTCDafyMl4Vih86hKeH9/CyLf7pMrAF3TtL/AjQcbQ+cnRMRwJrqoGzOQl1vAd9BnW3YuIcX2jBimqQYkDV4RwJWMtLo+UuH8WqITaGktqB8yF6Ty/VM4+2pEywriYF9bt7LTETP3NlG6osSxS2t0Ygu8tIls1DFnl4hBoegHO5/MmNUdzX4zC3SmlUqaUnNdveayMUakjhbCS7GL6fa8A5xrGb82DCBU3nXEoAoWyUt8syGC/Silg1hUe5tsV1Xa0owSGS9aV1KkoBTndsEqf77kevhcwKxadKb06VCkiALOrZrJ5Rlzgsgr4m/kC5AnKa0kB75y6ydt8AL0NIrpUwtXSH2IclhSD5h6ud2KVEENvPhm1zSNwHJlThqlw2Gjvk8Fa+73wT8eAn286smkARpq2aTzU2TrosgW7GBXWZvHefqiTBmqCvm7oFjx/4m4zSbm/O08QMhuLpi4wsZyUyatqsE4l/+9YZVDUiy3eKj394z5lBSlrc7b68NV1tlTq4hu9oynGJfCogGGP5VPKqXid65tFlvZopa9qWumhFClrkvOvC4WeDK6MfbwONKl42FPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(186003)(8676002)(33716001)(26005)(9686003)(6512007)(6666004)(2906002)(86362001)(41300700001)(6506007)(478600001)(8936002)(66476007)(66556008)(4326008)(6486002)(66946007)(5660300002)(6636002)(38100700002)(316002)(110136005)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ph4xl19BRxZ23ucGoepHWgQnx0c4rqtxpOJtPIaQI9owrTt0HUfBTgvj4J?=
 =?iso-8859-1?Q?qI5Dna2Eh7P1GNvycVFsLGFzj1SfbIB3djDw+bGH9cFCbRhwDa2P0sCJjK?=
 =?iso-8859-1?Q?trvNcF7O0+6LY6pbFJij5auUP5oT4oNAurD1K0cPPp+zc/5kpDlzlfuRla?=
 =?iso-8859-1?Q?Z29pv51HGHHAgfYydlP8sQT2Pkw9B52u5UiGwCXdJdOr96EkM4fDN8YGTv?=
 =?iso-8859-1?Q?lAsP5UFGz9mvMXFTydEZa2aWwHwvBTFxLnyxjkUF+4V5s3yKY4cxYjsQf7?=
 =?iso-8859-1?Q?ihSbw5sPNnZurWcniJmSus2lmp97Axo7cdc4dqLXtNasanBfhCy337QzNP?=
 =?iso-8859-1?Q?a69rl9W+uXu5GxHJxtU5AIImyWxKv/C67swuxwyJStWcoqppSSB0G0upAW?=
 =?iso-8859-1?Q?Hxg18QHe1UkF+XgNz5rQMKBN5dKpfxDsBBqsSXUkY1WC/HXWheQV2/muLd?=
 =?iso-8859-1?Q?KIzd0NIiIKLFE6AH66OIOX6CaatmFA6v8ne5JXWvOvGZKzYGTcQXodpDPS?=
 =?iso-8859-1?Q?CnbF8goPPatSJb8F7g6SOr0lSEzETtkdx2ZmhsAExGR0TsZP4prxHHHlPb?=
 =?iso-8859-1?Q?AdeXaJyAqGaIZbgUTDtqR/1USU+2JrNs9PmjHNTgE3WmqHP83y94sd3M8m?=
 =?iso-8859-1?Q?HIyMzmlzHsGIMGnXXepPXz6zjA8k1w1DSClQf3mS3pVTqpfeontVepYsWT?=
 =?iso-8859-1?Q?2n+OmZjQEGJIY9xjUSAWWM1Sb96iKXLg0f4UU2fEx9Rxgpwu+6uHyt30RB?=
 =?iso-8859-1?Q?BFphBoD6KYtbsY57Hhs7qVHrzRUxUqUsqvcX2dS9AI/YuhY/UZmacLeDAO?=
 =?iso-8859-1?Q?M0giN6hPFDhb7JRbdTG1HD7IUbNiDuShtNIJRpqklcUmzQzGlRFI4P0yHu?=
 =?iso-8859-1?Q?6hZyiyTSnjfbR0dxo4HLQ+l6/MgZvUUuY0KUzmXzKYH2IqeKeEaVhuCUNx?=
 =?iso-8859-1?Q?rh8TIn2QazICSDFJIBgUwJwkR6k3oGt8gPBiNiD03IGxI0BQe714ATQLdS?=
 =?iso-8859-1?Q?MKcGqBB89GkCDcCPJfRBiKFLZW2H/82y4SfFlTcXlG+K5wb8gTASRROxMq?=
 =?iso-8859-1?Q?7UfCUb5ivATebqwL+xsV9KJE5AtKpcyKBOaWZ5XlGTyErMXfHkQ5Tbfmtw?=
 =?iso-8859-1?Q?N6DrhSMWwWAljI4YN1hvTmj4QI0pqm69sWicbxLXs2gWcHjgkwaJtFspit?=
 =?iso-8859-1?Q?PUeN/eengfzHFgER6eOGsSAYGu+pxjKm3q/g6nau9ljAi/dPNNgdZPQuGW?=
 =?iso-8859-1?Q?EVkyoz9zKkJpZ1U5zOAEITgADe4utc39SL+866dQNxI8gg4oUoUR3bgyxX?=
 =?iso-8859-1?Q?OrYDvnLjUDsq7W9SOs/3GV/OpulKFzuQdtYPnre5vPsOlh7BofDgIG4cK1?=
 =?iso-8859-1?Q?Z7BGRdxUh73t+ix4ZKghwapZ8CFPCQOTBHm8nfRNCO98kxNv6pPwzQ6g7E?=
 =?iso-8859-1?Q?C12T+6Am54ppg23n8yO4dJpdxCmAP7HnYdgYyZI4ocVSgsO5UaVhttuy41?=
 =?iso-8859-1?Q?OnhH0SUW5ijVwARlsjvdZxJ5Jv00mFQ9xpqxVdyRAnvbbYaJll7TqWlstd?=
 =?iso-8859-1?Q?99Whtx623KB9spEYAZ9vWt0mYFoPISTbKgXkiIn0gC0KjMdP86upvWxvOs?=
 =?iso-8859-1?Q?5TCx7x78OMPjxz/Twx6DsAMEImxtJXRcYy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26d3c86-4f92-44d3-1e1b-08da80bc7ccf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 01:53:46.4847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIM0Q+5GADvIInEVL95WTKpioAFqOWAAXOHuPsjtFXsXcfIP4832xYOwOmrFezR6KoL6/xIY/8XW9iiknRovcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3915
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

On 08/17/ , Felix Kuehling wrote:
> Am 2022-08-17 um 11:04 schrieb Felix Kuehling:
> > Am 2022-08-16 um 23:09 schrieb Lang Yu:
> > > Then we can remove the burden of maintaining codes to
> > > parse family_id from gfx version in rocr,
> > > i.e., remove DevIDToAddrLibFamily().
> > 
> > I'm OK with the change. But you won't be able to remove
> > DevIDToAddrLibFamily as long as ROCr needs to support older kernels that
> > don't provide this info.
> As an alternative you should be able to use the AMDGPU_INFO_DEV_INFO ioctl
> from the render node. The Thunk already has the render nodes of all the
> GPUs. This will work on older kernels as well and will allow you to remove
> DevIDToAddrLibFamily.

Yes, topology_get_marketing_name() has called amdgpu_device_initialize()
and got family id info in Thunk. I will put the family id info into
HsaNodeProperties. Thanks for your suggestion.

Regards,
Lang

> Regards,
>   Felix
> 
> 
> > 
> > Regards,
> >   Felix
> > 
> > 
> > > 
> > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
> > >   drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 +
> > >   2 files changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > > b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > > index 3f0a4a415907..7e0331e853d5 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > > @@ -507,6 +507,8 @@ static ssize_t node_show(struct kobject *kobj,
> > > struct attribute *attr,
> > >                     dev->node_props.vendor_id);
> > >       sysfs_show_32bit_prop(buffer, offs, "device_id",
> > >                     dev->node_props.device_id);
> > > +    sysfs_show_32bit_prop(buffer, offs, "family_id",
> > > +                  dev->node_props.family_id);
> > >       sysfs_show_32bit_prop(buffer, offs, "location_id",
> > >                     dev->node_props.location_id);
> > >       sysfs_show_32bit_prop(buffer, offs, "domain",
> > > @@ -1690,6 +1692,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
> > >       dev->node_props.gfx_target_version =
> > > gpu->device_info.gfx_target_version;
> > >       dev->node_props.vendor_id = gpu->pdev->vendor;
> > >       dev->node_props.device_id = gpu->pdev->device;
> > > +    dev->node_props.family_id = gpu->adev->family;
> > >       dev->node_props.capability |=
> > >           ((dev->gpu->adev->rev_id << HSA_CAP_ASIC_REVISION_SHIFT) &
> > >               HSA_CAP_ASIC_REVISION_MASK);
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> > > b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> > > index 9f6c949186c1..4ff8dd2c9549 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> > > @@ -56,6 +56,7 @@ struct kfd_node_properties {
> > >       uint32_t gfx_target_version;
> > >       uint32_t vendor_id;
> > >       uint32_t device_id;
> > > +    uint32_t family_id;
> > >       uint32_t location_id;
> > >       uint32_t domain;
> > >       uint32_t max_engine_clk_fcompute;
