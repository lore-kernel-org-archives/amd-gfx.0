Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38880CD68E2
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 00:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DF9810E144;
	Tue, 10 Oct 2023 00:44:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A17610E144
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 00:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0tqy445CxmMEKJdNEnc81zSdK/ZzdzXuxEr3q0fNaWuHXOuBkAiBa6h9h44aNffXEgUQpZxPPRYd/8iTGZC2NxFjKuZP3felVpLw1cpz1y0CKxycHEkCutoitz0A0RiQXXqUXCUPDXHtyOXV7k0XuIKSDVS1CSWeBcabWHF9xankbnkzWOj17y5kCmC9KVZQ9xuElIRwXxu8J8r7h+N9994wct3Jo/GHPatO/dLzWiCp2ISUUPZ6/Bf9Q94FJcS3Y7iEU0SlsSxHXEyWYJML2UrtZxg00geVC3SAINIonMEusBY+ljubEbXjp61GV3hQsiQZXTn+uzvRiYJpWoRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHIKXDY4lxBdk/NTLj9/dapzPYLD42Af675n6LYuy/I=;
 b=QARY61aEpq4C+3R0k70P5YY+pOON3MujHU3s679BsaWms7c52xEVTbTvw4p9uudO+JTTNIuD+bGl4ODe6x+hVSln1bd1z1kcza2jxXvw2ZbKK9xl/hH5Tch2s7LWWDNJvXC57C4bCNtGcdjXTkE4cwxS8RyYaGxswXUiHGQ36XrUERS2FCd+fHYp3ymVDMI5QwBQjBjAn/ykQMRmrkavNPsJVwz066K5t5IU400TCfPTImWPla2J4t3druWha4Nb3Cq+AKxTDtIRXICK2u+sgvW680QCOnlOIP7+oiG5d5RJKIESFvKbKRplhPWHdd2hjPc7XOX9hzZ/k+n8ZnWHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHIKXDY4lxBdk/NTLj9/dapzPYLD42Af675n6LYuy/I=;
 b=M33oAT7SFnCZxaxjd04rTH1/2HfYEhPI7reZ07+F14L4ZHBKv/Om4KF8AOWZEAZM1dPRplzCDl0GqDJ6qBaSL6p8HlJs1KnuVcNGjvhy+8I7H3mYhdlpWwdC7VQmFCzslp/HJdr8YrQQlmZvT1wLMyuhNvmngm5DMex8CrXwzRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 00:44:20 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce%3]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 00:44:20 +0000
Date: Tue, 10 Oct 2023 08:44:08 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 2/3] drm/amdgpu/umsch: power on/off UMSCH by DLDO
Message-ID: <ZSSeWF+QzRG8/CNa@lang-desktop>
References: <20231007085402.67350-1-Lang.Yu@amd.com>
 <20231007085402.67350-2-Lang.Yu@amd.com>
 <BL1PR12MB5144A7CE930A1DEB9778671BF7CEA@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5144A7CE930A1DEB9778671BF7CEA@BL1PR12MB5144.namprd12.prod.outlook.com>
X-ClientProxiedBy: SG2PR03CA0129.apcprd03.prod.outlook.com
 (2603:1096:4:91::33) To MW6PR12MB8898.namprd12.prod.outlook.com
 (2603:10b6:303:246::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8898:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 5050561d-f0a2-40bd-31df-08dbc92a098f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NoxeSVW6ff+BI1OhDCLhurap88dQ+1Llor2gzX1Umpl2IX2ikkjM3FSdSklhlUF/RrfcLBM71oXCUgG206RnTLv1pnyHnIEsXsy6nzYlexQOGdLoTUgqnjglRI1KLcSa2QrcjigafzBVBlF6uUUencf52OGMUFoFnF0r9LOq4tXxyFhUNOIUpIaGh9q7j6I3x+2oZFfhtyJhM0hxHbTAthfPU1bl50qAqRNAP7T4EhtqU1s0dVDH+PXkBfMm/ordHwJ6ClF+35JnwN2Aq+nkQKfEpqfk9w1yHum0ZpQPSg2HTK6YnQENEoPn/jeJzqnC2tyV2ANzsqHZ9Kb58+SmVtVHFPZZVC5KEymdY8lcSTQ/4WAoB05FXSiAJIkC188iKWVYf6XvtugSvGyki8jz8XoPKLVywRaMbcPX1bqb89RF0pLXIkfcFo0jO87dGEbmvY52VSaGO5bWUuN7JXgknUkbF0+9fcYtkssxMuYkpb/LF3Oc1IqVeSM+ru1r2oTMJrPQrTArrd/IaFoeN9ICgiN8oCvmouAjezhCvp50sAnhdP1GxkLtEqZEFyb3/GK5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(53546011)(6666004)(41300700001)(6512007)(66556008)(6862004)(478600001)(6506007)(2906002)(4326008)(83380400001)(54906003)(66946007)(6636002)(66476007)(6486002)(8676002)(33716001)(316002)(5660300002)(8936002)(86362001)(38100700002)(9686003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BvbBVhrkfeEYqwkfF5eYs7q2LBEvDUZ/ENbGadtGsPoB2Mw3pPI1d9NsgcBF?=
 =?us-ascii?Q?bpTM+WIUkfo2TLhZM9RHftru2gqJmBpJtKwp9LXQeDNbhEC4CzAduPy6BA9b?=
 =?us-ascii?Q?p01tkaUq9chd7DotrR1tMb+M6EioTaXPyGKoevXnIRrYKAfpe1no21tpMREX?=
 =?us-ascii?Q?fFqs8FXacQuR1jJw/aGO0z8YLYz8aaD5BM6z26PuctVeWF8MKbZk4W7QgHCh?=
 =?us-ascii?Q?5WacLRDX5MsFkLJioSgAGZJYEMfIEzmpRg5DxJV9p7rUjg0xicpQ2u2lz3Us?=
 =?us-ascii?Q?YFsqJyz6uOS48uceUiJO3Xk+Kr6BtusGJwM6j7bRFaL02+WDoxeUVVHKvlxk?=
 =?us-ascii?Q?qU67n7so6tQ+YxrU3vEVEQb1V1blSalYT+IMU9IV2YEClb5SqzhohjCLFfIq?=
 =?us-ascii?Q?Z7+wWdOLdUiKEPotRBf3J3q7A2Dl3Cda8WW6qoBzvPIfAkyHZxqzrFvshokF?=
 =?us-ascii?Q?riZ8x8+hj4dOO9bB/9kEiR/A2UmWWgWZR8pVnP3SjNvpBouAsbRf6QG4ubZh?=
 =?us-ascii?Q?NT6PH3riGQTqMVl5KGwCoX1/hXw9FJZoB0YY3fPYnxgaHI/rnIlSmtAl495P?=
 =?us-ascii?Q?pRqikRpw9AX5Br0eVyP1EWowhebKsvFX5qqDIBFXytKpCf/SHWTgrfmAe6QI?=
 =?us-ascii?Q?N+T6aLifKZNfRrcem2qDtB4UO0rJ3sSs4FHAkQNDSydp+ygYhHrf4fJjaYM3?=
 =?us-ascii?Q?j3J+PjPf3y9O9BLnyJ+Dt6B6Nb7I1brnMLFjiyZpGl8Ba29eTrsJzjMDGzj2?=
 =?us-ascii?Q?x2ro84yUQapPEHxLRz13lrrUAyqId8ns8eb3X11/NETJ7wmIb5amCMW/A0NB?=
 =?us-ascii?Q?mcQdnHNdJQstV9++FHt6rfMn8EKzYe9TnVm7X487Km0KtMzAFpBhpgtAnUfX?=
 =?us-ascii?Q?Ogy/5qIp2qK/2ju/XP0bIISV77ZAxdnkWZZgKFLiA3v9lOxgf5J/CK4sXpAW?=
 =?us-ascii?Q?pcs1gzHfAyhAgEDPKQz52d53lJombgkxeEeDOIVH7PuCT1hA7aN0S0kXsyoH?=
 =?us-ascii?Q?jKRfsp3xMfMBSOI84DAk0yi8kjq4RbgdGrAbUb/L+07OuKzztfHQpFbjrhvs?=
 =?us-ascii?Q?8eqLYxZw6fHW8BbeFrs1oF3zkuyM/OrUMBq3hguUHxEzJQEG3jM1+CEPkY+M?=
 =?us-ascii?Q?jYXRdOZCo7Fe23qu4TVWDXt32TllCe2jI9g3zilsMuhFeuzby/CzxotNa4L/?=
 =?us-ascii?Q?096MRaFAUI5xqKvulmBl9wzyu2ghu68dFSVBPbZy+n6TCDp+wuejJGSrKzmy?=
 =?us-ascii?Q?a9U8jH2yAg8SvKVTEhByg5aYeh9LngcI6Xao7/oOOrM6sGAiH6XGyf/mQp3i?=
 =?us-ascii?Q?JKT+yQo+BKB6/ER0HqA7kUfDGoCiazqXpbZOzPZedM4vLsPHlN5qZN1yvAIu?=
 =?us-ascii?Q?+yvDCmTyKcCRyz3Cm9JWMk1MZdEFiI4gpMCfbZ0x7SPhszXa5nUnfv4e+iOF?=
 =?us-ascii?Q?vT+3U+oSbslt2NFYIoFqAqCmP9iZdKJwqlKLsyqUh7GVfX1XQ/DYpGufkdbT?=
 =?us-ascii?Q?JKOyLCSGQGtRGnjMUat7meN1iGbWcevvrm+dD768Wttnkf7GGnWkkwvY4X1o?=
 =?us-ascii?Q?bJYO1fjyhAvtDCBGRPb1Lq49fB1woXTk30PaUgDS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5050561d-f0a2-40bd-31df-08dbc92a098f
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 00:44:19.0431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpM+RdKyhaT/V44qpMN8NcsPwU9hWZQHi39voVgTM9GtXn6ucT5DqPU4OJhU7clVxlR2kxMmKhrwTXjlEF1z8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Gopalakrishnan, Veerabadhran \(Veera\)" <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/10/ , Deucher, Alexander wrote:
> [Public]
> 
> > -----Original Message-----
> > From: Yu, Lang <Lang.Yu@amd.com>
> > Sent: Saturday, October 7, 2023 4:54 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> > <Yifan1.Zhang@amd.com>; Gopalakrishnan, Veerabadhran (Veera)
> > <Veerabadhran.Gopalakrishnan@amd.com>; Yu, Lang <Lang.Yu@amd.com>
> > Subject: [PATCH 2/3] drm/amdgpu/umsch: power on/off UMSCH by DLDO
> >
> > VCN 4.0.5 uses DLDO.
> >
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c | 26
> > ++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> > b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> > index a60178156c77..7e79954c833b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> > @@ -34,6 +34,16 @@
> >  #include "umsch_mm_4_0_api_def.h"
> >  #include "umsch_mm_v4_0.h"
> >
> > +#define regUVD_IPX_DLDO_CONFIG                             0x0064
> > +#define regUVD_IPX_DLDO_CONFIG_BASE_IDX                    1
> > +#define regUVD_IPX_DLDO_STATUS                             0x0065
> > +#define regUVD_IPX_DLDO_STATUS_BASE_IDX                    1
> > +
> > +#define UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT
> > 0x00000002
> > +#define UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG_MASK
> > 0x0000000cUL
> > +#define UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT
> > 0x00000001
> > +#define UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK
> > 0x00000002UL
> > +
> >  static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm
> > *umsch)  {
> >       struct amdgpu_device *adev = umsch->ring.adev; @@ -50,6 +60,14
> > @@ static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm
> > *umsch)
> >
> >       umsch->cmd_buf_curr_ptr = umsch->cmd_buf_ptr;
> >
> > +     if (adev->ip_versions[VCN_HWIP][0] == IP_VERSION(4, 0, 5)) {
> > +             WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
> > +                     1 <<
> > UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
> > +             SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
> > +                     0 <<
> > UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT,
> > +
> >       UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK);
> > +     }
> > +
> 
> Is this the right place for this?  umsch_mm_hw_init() only calls this for FW_LOAD_DIRECT.  Maybe that check needs to be dropped?

That check is dropped in [PATCH 1/3] drm/amdgpu/umsch: fix psp frontdoor loading.

PMFW removed DLDO programing in PPSMC_MSG_PowerUpUmsch function.
So driver needs to program it explicitly.

Regards,
Lang

> Alex
> 
> >       data = RREG32_SOC15(VCN, 0, regUMSCH_MES_RESET_CTRL);
> >       data = REG_SET_FIELD(data, UMSCH_MES_RESET_CTRL,
> > MES_CORE_SOFT_RESET, 0);
> >       WREG32_SOC15_UMSCH(regUMSCH_MES_RESET_CTRL, data); @@ -
> > 229,6 +247,14 @@ static int umsch_mm_v4_0_ring_stop(struct
> > amdgpu_umsch_mm *umsch)
> >       data = REG_SET_FIELD(data, VCN_UMSCH_RB_DB_CTRL, EN, 0);
> >       WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_DB_CTRL, data);
> >
> > +     if (adev->ip_versions[VCN_HWIP][0] == IP_VERSION(4, 0, 5)) {
> > +             WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
> > +                     2 <<
> > UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
> > +             SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
> > +                     1 <<
> > UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT,
> > +
> >       UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK);
> > +     }
> > +
> >       return 0;
> >  }
> >
> > --
> > 2.25.1
> 
