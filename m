Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4616EC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 11:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9682075E
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 11:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SpMNbsfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9682075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 978EF89A83;
	Wed, 19 Aug 2020 11:04:59 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690069.outbound.protection.outlook.com [40.107.69.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7CF789A83
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 11:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPUQg0dW0/EpfjgkStAYAF5mgEroagQVW0phNPpa1IutfTjvQb+VM21FpvsixwypnPt9vcLb6fFHfNzniFCcdFyRSIenP6wVmtMy7Ljc+OdFkMngSdu8b9DuQGDnN9MO/qfelFeLp/9KOIgxJeXlfDe6o5CbXh9ricAh3R1l22XTR+Wu7pYd1AqV3YH80jwA4hz0g73sVmQZ9XOdZqNyR0akgSRA2s9wa+lBqkcmTIWtJuUE37F/BvmbShzrG7TAQTy3xhx95kNXDYghl2ngnSSr9AAmKaTxdNSdbr7mrDYcJGYE9UnhVImaORUtKJSUR25eZ0uhD6Mdz8OSBHlteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUcqMxhxSG/38Czs6IrdZh+HryTJ1Ei9FXT+RqIxJLE=;
 b=cIAyn0wOnFUIRiQKX+BmO6fb2IumYxO8zA+uCRsBAW4cMtqmhqlq4GnzHlOpIzkp2dEolWx/yNLNcbF355HTWtr49gvNAJtrP0epeb3pVlbx5/3VpMXq183HhqgQJGrgKUD83FYz/rACEMd2rnGLXjzAYqqGnU2XNa9/V9BoPYXR9Zm1ISGwS2CiqtJnJxqMuB5AsOL4S7pKj8nGDtQXPQ/ttB8Y3NDsVM1AUyY4NJhuWM7QqWPq+fThkEYeTh+ObUCP19NJdSHBLMG2fKXY2pUDkuxlzeLXLiVRI3IEXNi0hgJARt6AYEWfzrPWm9A0iPQ+PCZF2Qy65qWJNJf8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUcqMxhxSG/38Czs6IrdZh+HryTJ1Ei9FXT+RqIxJLE=;
 b=SpMNbsfMJhY1j7tUP9Zp0k0gl8A+g1ONb+9pCX4ck+PVspXKnhrPj5N7Q33/MJJKlaVDTqAIc+5JOi7eDKqcyA90zIilvueu2wiXqxFtIWKtmL/ghDIkFhUpR86tlcfM5ydEUtS+HnLTQI3NjHMDZbxnh1JElKB9SCBhy7m+SzY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 11:04:57 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 11:04:57 +0000
Date: Wed, 19 Aug 2020 19:04:49 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v2 3/3] drm/amdkfd: remove iommu v2 for old apu series
Message-ID: <20200819110449.GH201546@hr-amd>
References: <20200818130932.180114-1-ray.huang@amd.com>
 <20200818130932.180114-3-ray.huang@amd.com>
 <5b0f4e19-d4e5-4c67-d4fd-22602d663ab0@amd.com>
Content-Disposition: inline
In-Reply-To: <5b0f4e19-d4e5-4c67-d4fd-22602d663ab0@amd.com>
X-ClientProxiedBy: HK2PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:202:2::12) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.242) by
 HK2PR0401CA0002.apcprd04.prod.outlook.com (2603:1096:202:2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Wed, 19 Aug 2020 11:04:55 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 745a79cf-aefa-42d6-d1e0-08d8442fb531
X-MS-TrafficTypeDiagnostic: MN2PR12MB4126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB412695CE169F2026414EC2E1EC5D0@MN2PR12MB4126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMrdIorB8N2Wqe4j1uWIGVJ36OwzZ4uBpz9R+uFm24lsKcpw8wl9QgERsoghS7+KiVDdKKfndjAdq5TA8cLzIVGEcMDcMDgaYeTEBMPdIjpQVV7NL9xnZqLHcZ+8gJrCmzuKFSKGDN7oMzysamsx1ORxRMvBVq4pGns8RsWk7JoPujGhGV1Ohyh+RIqednsOjyDeHCShgB/yoi4Cky1b47RDWfI1pR6XqyzKWusJb4YEXfp5NfuKJsQpII02TT5HenkTp2gr9hbELSgt4WtM08+Mhob2X2MonSMTtGPrFzQtAs65gJkWZa3KQa04r/3T
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(16526019)(186003)(6636002)(83380400001)(6862004)(52116002)(956004)(4326008)(6496006)(26005)(86362001)(55016002)(6666004)(5660300002)(316002)(66476007)(2906002)(478600001)(33716001)(33656002)(8936002)(66556008)(8676002)(1076003)(66946007)(9686003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4UHYN88wx6eQfh0SwBpVVX+4ihZU0Smv9ZJSo2zpM+iOo6EYHSeEt23JgFgiFXSdAOiFptwMd0fV3Vkc8mpa+5XBcKusXvXCd9UL8tuOyRUOqmlyy5jfeLNwc0oJicnQy/ri/kIlJG1pB41TDZmjEmJqFUTM/5hb+p0v4HUeEGrD7lN6NX4vewzt/D5QMRelf4UzxV5KDOJiNbXue5z+4FFKno+iwLJtx0aZUaTsDqxTw7ZedrimeroeySDaINnKoIYBAYuLdnlPo4PdMqp91XhgFBRCtB3MusyoUAZeot4ABQcU2I0pqzjni7ZRS0f5GxUd0f0yb/Vyv1ho3ggVuEdzEhWcrWa7ICQDHnZq1x47SqxWUnqJ8tPQzQm8R8f2NauIg3thIf7jIgbMw8LCoR6Q/nn982Y/B2l3tK4vyNO/uue8MMDWEBoFkCkGAm71HORReqJ6VrAxtYjVoRpyZnFiQ5fY3BiLTvlGOXeoy/LLFIRB1CQyrcA7b6FcoPszvrgUAowoxxW4lx8gBBOaezVjND16gGVu7CD78NITxzkwOLyo4fVOZ93eR9tBPeogJard2eBr4sSkfx1vUHO/xflmxeAlqzKFZno9vWl2NHRq78vpzbYY3ubwaNEfOtftC3UrBlkb60YYoxL9hUeRVA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745a79cf-aefa-42d6-d1e0-08d8442fb531
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 11:04:56.9886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rp//ykFKYFmy/9oLyrL4KklPGdAfe0KtAztD0+uf1LryeBbFuJHiFrY+5QEnzpCcdndHO58dbUyNKXBRDl6AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 18, 2020 at 11:15:47PM +0800, Kuehling, Felix wrote:
> Interesting. Does this actually work on Carrizo or Kaveri? I'd like to

I just found a Carrizo board, rocm info works well, and clinfo is able to
print most information. But it seems stuck in the ROCr (submit
SubmitLinearCopyCommand). Let me take a look.

Thanks,
Ray

> see any Thunk changes needed to support this before giving my R-b. For
> now this patch is
> 
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> 
> 
> Am 2020-08-18 um 9:09 a.m. schrieb Huang Rui:
> > We already support the fallback path, so it doesn't need IOMMU v2 flag
> > anymore.
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > index dab44951c4d8..731f7fdfe9d2 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > @@ -48,13 +48,11 @@ extern const struct kfd2kgd_calls arcturus_kfd2kgd;
> >  extern const struct kfd2kgd_calls gfx_v10_kfd2kgd;
> >  
> >  static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
> > -#ifdef KFD_SUPPORT_IOMMU_V2
> >  #ifdef CONFIG_DRM_AMDGPU_CIK
> >  	[CHIP_KAVERI] = &gfx_v7_kfd2kgd,
> >  #endif
> >  	[CHIP_CARRIZO] = &gfx_v8_kfd2kgd,
> >  	[CHIP_RAVEN] = &gfx_v9_kfd2kgd,
> > -#endif
> >  #ifdef CONFIG_DRM_AMDGPU_CIK
> >  	[CHIP_HAWAII] = &gfx_v7_kfd2kgd,
> >  #endif
> > @@ -74,7 +72,6 @@ static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
> >  	[CHIP_NAVI14] = &gfx_v10_kfd2kgd,
> >  };
> >  
> > -#ifdef KFD_SUPPORT_IOMMU_V2
> >  static const struct kfd_device_info kaveri_device_info = {
> >  	.asic_family = CHIP_KAVERI,
> >  	.asic_name = "kaveri",
> > @@ -112,7 +109,6 @@ static const struct kfd_device_info carrizo_device_info = {
> >  	.num_xgmi_sdma_engines = 0,
> >  	.num_sdma_queues_per_engine = 2,
> >  };
> > -#endif
> >  
> >  static const struct kfd_device_info raven_device_info = {
> >  	.asic_family = CHIP_RAVEN,
> > @@ -460,11 +456,9 @@ static const struct kfd_device_info navi14_device_info = {
> >  
> >  /* For each entry, [0] is regular and [1] is virtualisation device. */
> >  static const struct kfd_device_info *kfd_supported_devices[][2] = {
> > -#ifdef KFD_SUPPORT_IOMMU_V2
> >  	[CHIP_KAVERI] = {&kaveri_device_info, NULL},
> >  	[CHIP_CARRIZO] = {&carrizo_device_info, NULL},
> >  	[CHIP_RAVEN] = {&raven_device_info, NULL},
> > -#endif
> >  	[CHIP_HAWAII] = {&hawaii_device_info, NULL},
> >  	[CHIP_TONGA] = {&tonga_device_info, NULL},
> >  	[CHIP_FIJI] = {&fiji_device_info, &fiji_vf_device_info},
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
