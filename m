Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A60C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BFCB7B3EE;
	Mon,  6 Dec 2021 10:21:53 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8176FE39
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 09:31:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgyUUPuQliYmScciE6qpv3cyr42SBThrUGMiRvYgS963ArkaES4lF0nAU0qpn36/PHgt6i42lirc5knGUsFm12npbbt67uSU1KXXf9p21EezBPoDnFLcz+FrxAujyIUoWU6AZjrrALgn+OrknSYnMROW5PNnhpN0xG1rXpjAY2TwIxdWxYbjQC3dGmHahQq2452mcp5QuWUcwi2jFTepOHZvEH3LybjkbuD7wUF2d2FIU9UTAa5tUn/8XF+78Gevtp6OBvivZtZGU/iemLtyzbEz4JOrPmq2hMsPo2NS5CQAI9J5EsSd9MDJPYDslIPnQpVK1pWSv0Bzwc0TpvbE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6k3/ae4galUBWiJkEwPP3XS65+wDrMh1D2R88fao+Q=;
 b=Dl1gkVDf3ArQHbQOKjI1bhGMnMtQ2bnro29L6DLUjWM7cc59FC3Z67JnBMpipKtGnA2llvrBFoCM4Kwk2jXV4DdSOzjeBeADBwyRWVO9sUrI9HX/WoMn61UMsdGANPh6mHYZUNINsi4ib6KrG4+v6m5t3UHsUm72uVEml+BILDnPnJnZc4cxK/cU4wguWWHBGe8S3TMtZ6dMUczkQ/8qw/reXIpWiMxQ1tuHuLK+SFfZavJpCUzlG5zniyMdFGR5Q+kmgJTlNKuY4Wua8EFbALXa5PoGpenZ4nXyzNjkF4i4rm+msJj/6C3E5+Sy6+ijtYDqgy1DH8YTPdP0lOZLew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6k3/ae4galUBWiJkEwPP3XS65+wDrMh1D2R88fao+Q=;
 b=KhrWNXxcJL9kEF6psxlgYKizK42Qgqlnw7S71F7VjTWCiJ7cmg1nkZFEhxejn97Y+bqRaEsIarzmcovNurKbDhGjc6gHfPyD6fcvHq02IAfZV9cOaDmKV6SZ648nqwgCCxPg+DekACrQE1Zj/v2nogFdUfy7Cbxq37fN0N1ey3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR12MB2437.namprd12.prod.outlook.com (2603:10b6:4:ba::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Mon, 6 Dec 2021 09:31:41 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 09:31:41 +0000
Date: Mon, 6 Dec 2021 17:31:28 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: allow APU to send power gate message
 when dpm is disabled
Message-ID: <Ya3YcFRc8foqJY8R@lang-desktop>
References: <20211203065407.3714697-1-lang.yu@amd.com>
 <20211203065407.3714697-2-lang.yu@amd.com>
 <52f4d894-b122-a831-8182-70bcc2e1ce94@amd.com>
 <DM6PR12MB4250A082C1B20249D79406E6FB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <8f7f1c6f-2f01-00b0-ff52-e50864ab78a7@amd.com>
 <DM6PR12MB4250FF2A11037B18176DE1EFFB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <DM6PR12MB42500FDF83B2FF999385D5E3FB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <ec924948-c76c-08b4-c788-5017a2a18692@amd.com>
 <Ya3NXykr61OqR9fS@lang-desktop>
 <0f781749-bdae-093b-5408-5512ad62719a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f781749-bdae-093b-5408-5512ad62719a@amd.com>
X-ClientProxiedBy: HK2PR02CA0171.apcprd02.prod.outlook.com
 (2603:1096:201:1f::31) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
Received: from lang-desktop (165.204.134.244) by
 HK2PR02CA0171.apcprd02.prod.outlook.com (2603:1096:201:1f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.16 via Frontend Transport; Mon, 6 Dec 2021 09:31:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ea1785b-bd16-4ae7-3a23-08d9b89b35e5
X-MS-TrafficTypeDiagnostic: DM5PR12MB2437:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB24376F030AE10F6A81992C89FB6D9@DM5PR12MB2437.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vPZRM+PozpdxFqzy9ar4JVXJJ8VZFQ2jVIs4Ru+g/o2YbNeJTtxi4thkOxUc+aOJKe3oYKaXWlEa3/YGbZc3IDqDxFs+ST6oAYZx9C+kMhwSZ+zClVe8xq/d9pqvlWW2apL/QOYoaRUYNLqGTr3WmKBvmdJTXoUYXy2edEuLhqukoqNdaZmlXlUDRSZcvA/QATpus0TPfhEfNpz/DTaY0Xens+hAJUfwm1NbxxX5Hq8PE3geOhDsGmEVoT1gvNgRocJBzQQdT3mK074nlAX+l2kh6VRuxJjYCodSftG0R9YTMbgq4PFCz+FNeT4JBBHYJroKLdCR2guGIoYHFJzw7fWCOyL5qvsTyh0H9sOdt2IKIkylhZhnROEIQCxwrucywHHlPs8UGjCyHzAR2TYz4+TqHW0w64tlpO7pyUUY6vi73JyGaL36v7XQIZz5YMjLTjYGoYc57vOXtfhytYoM+TTsfCSXiFuwexjwmlyABK8suVctB6LZg2xJaWAM4VmWjR/+Id9RjrvdB3gxMEdXrqw1jtqPp38p26xzX8OgEzkCOnsvgQVWb5m7RDmtOIDV/kdKQ/nrMdFP25lyiAtp76fJXd0UU7A4VAYkfCfWw7yY0SD53/IsRQSj1Qe/Va48MVqSFH8vTd+MlzHKK9lS5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(956004)(66476007)(4326008)(66556008)(54906003)(26005)(186003)(66946007)(53546011)(55016003)(5660300002)(6496006)(6636002)(9686003)(86362001)(8676002)(508600001)(83380400001)(8936002)(33716001)(2906002)(6666004)(6862004)(316002)(38100700002)(15650500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z60OQ4oTHmbsSLkAn89Hx/U+IQJ46NgbOGlfkXndgi3XqlA4j9QAIcPsulrT?=
 =?us-ascii?Q?DbbHotP+vLVEXR5f9xCwwc4Iw5nGTugVd3jGUkpnpUNOGAo2RL2cziO/cUN4?=
 =?us-ascii?Q?L3BNdimQTux44PdybdsFD4zL2s1NiAOMrvxV/xlPUSqg5qOcghHwCncWAHGn?=
 =?us-ascii?Q?uREYupoCk9bQQoQvTzB8xM5rGnSxeVQT0FdkTnvCTbbAp3EtgEam8jbmoQgw?=
 =?us-ascii?Q?A0PzGLW9+Lpu8OGlMr0ZaVRwLuEz0AG4ERAlJTXFRp2GMT1vmTBFzPYC1ckT?=
 =?us-ascii?Q?48QMMuorRsvNf2/2F+wN/Fgk+wrY/k12Zbj4ExeSynl+/I/qbRuElWQz0WRV?=
 =?us-ascii?Q?jtRcBRAoztAUOXzJ7BDLeIu4ppZ1qisJ4M9/NRBXe93dMei0/rRhe7dEZPUA?=
 =?us-ascii?Q?OcYJo/41RF8EHPzt+bPbK4a5r9PwtHXvMLFbrSKZUqwKRlQBBCzyIa41vhgU?=
 =?us-ascii?Q?7T9+nxszMayvTNHYrW5OSlrju2jIVUa+Y3IZGgQfeJ4+kLOL3jhw3wGYTlKC?=
 =?us-ascii?Q?N0obMGVxbRD/FJnQBz7uHeT9iHuOvII+14n4LKk5OcP/atUKtNXqYS0SLvNS?=
 =?us-ascii?Q?OhYZ2gwFTGqdBMVlESRGy8DL88J/1EI77dGuni8V2RjuyxvkjPetDaxxxLU0?=
 =?us-ascii?Q?Y1Yn3mJvMUqj084zaHigeQPND1jHKMzFX86r5f3xyL6yszsFPYS/nwf/s5rJ?=
 =?us-ascii?Q?gHjyF2ndNBFWvqyYC0b0d2dvxRgaIOVR0vOrpFo5O6fFiRapd1hpmlRFODPA?=
 =?us-ascii?Q?FguVxUbsliIFmtuz87z95XwajVZZ1lELusIz9BI7+lLpx9epjv8xcwcvVh7i?=
 =?us-ascii?Q?KIBelFDEyurPYayoVCJUcMNO6RGRZRANp+7DOhna1YFDWLcozE0ts/pFnw8r?=
 =?us-ascii?Q?AbAAo/EuhtWU9g0diBL4ohRJfq75W5md8jESBZ3uA9wyVF1KayPyxiVVP2u+?=
 =?us-ascii?Q?ec7tGtX3neuXMT12XYcAEGjAPqUS9UrLjAhaH56bHsw/LsDpt+EF7iIki79b?=
 =?us-ascii?Q?jym1ZWizKkfvVr6sE6sy12O7VKGcXKACEzsVigChgsmJWM87KS8V2EW9HFh/?=
 =?us-ascii?Q?87O7GL5SAgDGgcnIqEgfwVaPrjB5qo9/d+wp0DASWIyEXSfMPSzwhx8cxXNY?=
 =?us-ascii?Q?uK1LorGAekZOr95IGAkM01cPkhA+2PPG+GzHVteKoHbeOoA2gcGZEQlAScqB?=
 =?us-ascii?Q?yW31YNXi9UxMIHwnR9JNqf9AGOhw2Wgd2XS5tdRPyx04fyULmk6qsDOjaeAn?=
 =?us-ascii?Q?Cw/KVv6b6n+1AmljrGxzKLdbeqDOMbeApN8bCuE1MpCQKMIsuZ3Zb1YzraFT?=
 =?us-ascii?Q?6ZkTpkQohhHgPuLDhmKXUdshuGEN8G9mVMWKDHv6GsAGC8plj4vsRCFXkemQ?=
 =?us-ascii?Q?0cUIyWjIW+F2i0arClVBSoDrktR++n9dS8nLo7M/j234zqXNkaHnrezWU9Dp?=
 =?us-ascii?Q?e2LLYB2GxFWx45BMRiX3fbxkC8YiwLdwZ3F+ceFNMvo/533vP228EDsn9TwZ?=
 =?us-ascii?Q?JzILvd3fodGnx+S9OO1OSrToSYfSTHcCZi0PzhzMRW/whXq9gvGAUh/899Qi?=
 =?us-ascii?Q?pRx8zc0imjlvPszcO5fSCAO2glYFSsxKsCS06tcSX4dH8VoIQgU+HdBESTR7?=
 =?us-ascii?Q?KA4lK1GTS317xaGoPFnbsxk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea1785b-bd16-4ae7-3a23-08d9b89b35e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 09:31:41.6199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckuRX71UlhODScGtH84QWbnc0YtCgRWM2sXnscwqXBpMN33UA2Kg2Jyp+YUMrt27b3l5vke8BD+L6/wWIdX9jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2437
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/06/ , Lazar, Lijo wrote:
> 
> 
> On 12/6/2021 2:14 PM, Lang Yu wrote:
> > On 12/06/ , Lazar, Lijo wrote:
> > > 
> > > 
> > > On 12/6/2021 12:18 PM, Yu, Lang wrote:
> > > > [Public]
> > > > 
> > > > A typo.
> > > > 
> > > > > -----Original Message-----
> > > > > From: Yu, Lang
> > > > > Sent: Monday, December 6, 2021 2:47 PM
> > > > > To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> > > > > <Ray.Huang@amd.com>
> > > > > Subject: RE: [PATCH 2/2] drm/amdgpu: allow APU to send power gate message
> > > > > when dpm is disabled
> > > > > 
> > > > > [Public]
> > > > > 
> > > > > 
> > > > > 
> > > > > > -----Original Message-----
> > > > > > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > > > > > Sent: Monday, December 6, 2021 11:41 AM
> > > > > > To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
> > > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> > > > > > <Ray.Huang@amd.com>
> > > > > > Subject: Re: [PATCH 2/2] drm/amdgpu: allow APU to send power gate
> > > > > > message when dpm is disabled
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > On 12/6/2021 8:19 AM, Yu, Lang wrote:
> > > > > > > [Public]
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > > -----Original Message-----
> > > > > > > > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > > > > > > > Sent: Friday, December 3, 2021 5:52 PM
> > > > > > > > To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
> > > > > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> > > > > > > > <Ray.Huang@amd.com>
> > > > > > > > Subject: Re: [PATCH 2/2] drm/amdgpu: allow APU to send power gate
> > > > > > > > message when dpm is disabled
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > On 12/3/2021 12:24 PM, Lang Yu wrote:
> > > > > > > > > The general hw fini sequence is SMU-> ... ->SDMA-> ...
> > > > > > > > > We need to send power gate message to power off SDMA(in SDMA
> > > > > > > > > hw_fini()) afer dpm is disabled(in SMU hw_fini()). Allow that for APU.
> > > > > > > > 
> > > > > > > > This message is not right. In APUs there is no message provided by
> > > > > > > > FW to enable/disable DPM, it is done in BIOS. Rephrase to something
> > > > > > > > like after smu hw_fini is completed.
> > > > > > > 
> > > > > > > It is power on/off SDMA message. Not enable/disable DPM.
> > > > > > > 
> > > > > > Bad choice of word :) I didn't mean FW message, it was about this line
> > > > > > in "commit message" - "afer dpm is disabled".
> > > > > 
> > > > > Ok. I got it.
> > > > > 
> > > > > > 
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Lang Yu <lang.yu@amd.com>
> > > > > > > > > ---
> > > > > > > > >      drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
> > > > > > > > >      1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > > > > > > > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > > > > > > > index 2d718c30c8eb..285a237f3605 100644
> > > > > > > > > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > > > > > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > > > > > > > @@ -277,7 +277,7 @@ static int smu_dpm_set_power_gate(void *handle,
> > > > > > > > >      	struct smu_context *smu = handle;
> > > > > > > > >      	int ret = 0;
> > > > > > > > > 
> > > > > > > > > -	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
> > > > > > > > > +	if (!smu->pm_enabled || (!smu->is_apu &&
> > > > > > > > > +!smu->adev->pm.dpm_enabled)) {
> > > > > > > > 
> > > > > > > > 
> > > > > > > > This check was there before also, only the WARN is added. That means
> > > > > > > > it was skipping sending messages in APUs also and so far this was
> > > > > > > > working fine (until this gets noticed because of the warning).
> > > > > > > > 
> > > > > > > > Now this would try to send the message to APU without any check.
> > > > > > > > That doesn't look good. Ideal way should be to fix the sequence.
> > > > > > > > Otherwise, suggest to do something like below as the last step of
> > > > > > > > smu hw cleanup rather than sending the message blindly.
> > > > > > > > 
> > > > > > > > 	if (smu->is_apu)
> > > > > > > > 		smu->pm.dpm_enabled = smu_is_dpm_running(smu);
> > > > > > > 
> > > > > > > smu_is_dpm_running(smu) will cause errors in suspend.
> > > > > > > 
> > > > > > That is interesting. What is the error you get?
> > > > > 
> > > > > [drm:amdgpu_dpm_enable_uvd [amdgpu]] *ERROR* Dpm enable uvd failed, ret =
> > > > > -95 That means EOPNOTSUPP.
> > > > > 
> > > > > Actually, in resume process, but adev->in_suspend  is still true.
> > > > > For Renoir series APU, smu_is_dpm_running is hardcoded as following,
> > > > > 
> > > > > static bool renoir_is_dpm_running(struct smu_context *smu) {
> > > > > 	struct amdgpu_device *adev = smu->adev;
> > > > > 
> > > > > 	/*
> > > > > 	 * Until now, the pmfw hasn't exported the interface of SMU
> > > > > 	 * feature mask to APU SKU so just force on all the feature
> > > > > 	 * at early initial stage.
> > > > > 	 */
> > > > > 	if (adev->in_suspend)
> > > > > 		return false;
> > > > > 	else
> > > 
> > > Renoir suspend shouldn't be a special case. FW should keep running with
> > > features enabled after driver suspend. Could you try with a return true all
> > > the time for this?
> > 
> > That worked.
> > 
> > But we just send an IP power on/off message here.
> > 
> > Do we really need dpm running?
> > 
> 
> Yes, but it is a power management message. From a FW perspective, power
> management starts when DPM is enabled. Without that, it's not bothered about
> any power management features. Only a few non-PM related messages like i2c
> table transfer etc. work when it is not enabled. Usually for APUs, DPM gets
> enabled early through BIOS and driver doesn't have much control.
> 
> If dpm_enabled is not causing any SW logical errors, better to keep it
> coherent with FW DPM for swsmu based ASICs.

As you said for APUs, DPM gets enabled early through BIOS.
Are there any cases it is disabled by diver or BIOS or itself after that?

1, If not, why we query if it is running for APUs.
2, If yes, who enable it again for APus?

Regards,
Lang

> Thanks,
> Lijo
> 
> > Regards,
> > Lang
> > 
> > > Thanks,
> > > Lijo
> > > 
> > > > > 		return true;
> > > > > 
> > > > > }
> > > > > 
> > > > > So we got such an error.
> > > > > 
> > > > > Regards,
> > > > > Lang
> > > > > 
> > > > > > Thanks,
> > > > > > Lijo
> > > > > > 
> > > > > > > Here we just  send some IP power on/off messages.
> > > > > > > Is it necessary to enable DPM to send such messages?
> > > > > > > 
> > > > > > > Regards,
> > > > > > > Lang
> > > > > > > 
> > > > > > > > Thanks,
> > > > > > > > Lijo
> > > > > > > > 
> > > > > > > > >      		dev_WARN(smu->adev->dev,
> > > > > > > > >      			 "SMU uninitialized but power %s requested for %u!\n",
> > > > > > > > >      			 gate ? "gate" : "ungate", block_type);
> > > > > > > > > 
