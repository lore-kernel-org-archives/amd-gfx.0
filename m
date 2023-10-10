Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C2BCD68E2
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 00:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E4D10E14F;
	Tue, 10 Oct 2023 00:45:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A879010E14F
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 00:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDtIOD+tkhj8LHa5a+v3RO7r3/6KytvViYzcsV/aAHBkheYjDD/4/pYDO2p9lLdrDE/h95gkcJoEO4Z9z3DbhDG+VYElVOS/SgX37C+1nYSzMQn1WlPQlxE/H8K+nqhIaGE1SmG7//iu5Cfn4NbSHwTHA6M/kLpLXE8d29mlkaSNX62+GmPM8zO6OTESja1fM4Yr4hzwH01892/Stm006eTryxQnmBd7fS+AW+W8H0HHC4BjtFLU0d0ox7mA+j/KvM0kU/7/EHXxBvk1F6f48BwKlG9xYkgwB4b5IqJp1OAhsXyRA7X3jL0HpSBapIz9Fz2MeNK+bjAkTNzPgHcQIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWCOl8B9A0SudgLjm0yfIOB1IUhqKwBV7a3/oHwKQEA=;
 b=RqxMQoD5AGHScfQkUnoN0u01fXAHHtkR4OWXrjpyzgJXJ/uJh86GJjXHs8gVeFn6iJhXeGgoQCR3U1kmni0oFP1X7+lTbiCy1W5gamlLvbJ+E3G4/8pcr0OPbj63HR8xxqmEQrudzhgFwzwjdh6TQKEPD9asndZ7z/dPr4NrqnXsHDUOoZDf1nCpmpgpGlzTQs1fANLzrVtf81dW+Ej1XeF3ILbbzYQEgNEH/kbFF83IaCjCBekyFE1E29yl2kjtc/DawgPRmZ3DEQquhV+2CE0A03pKEYh8JeIRv1TfDBSPsqfTFC2EAbPHz5VvKfFHC3q2koNlLg2kxyB0aDtZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWCOl8B9A0SudgLjm0yfIOB1IUhqKwBV7a3/oHwKQEA=;
 b=WmRt3S5igrszIR+xfsIUPdxHKHw1puSuNuq+Lptct3r1BusRNNV56eW1/MP9v6FeV6Fkxx14Cp/DhqFDYCzmUwkVcYFW4af0yj1ZxsZg7C/y0HzclO5DxP9H65Fbc+e3Fuu/8R09+czGxCxwKGZmi4CC9VZpDl66InKW4U4AMdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 00:45:29 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce%3]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 00:45:28 +0000
Date: Tue, 10 Oct 2023 08:45:19 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 2/3] drm/amdgpu/umsch: power on/off UMSCH by DLDO
Message-ID: <ZSSen6HCYz1xtXXG@lang-desktop>
References: <20231007085402.67350-1-Lang.Yu@amd.com>
 <20231007085402.67350-2-Lang.Yu@amd.com>
 <BL1PR12MB5144D16BDCD4C881F3534C3DF7CEA@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5144D16BDCD4C881F3534C3DF7CEA@BL1PR12MB5144.namprd12.prod.outlook.com>
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To MW6PR12MB8898.namprd12.prod.outlook.com
 (2603:10b6:303:246::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8898:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ca2b12-ef96-43d6-b3ce-08dbc92a32ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lyjFmO5Qt6RZqeHTDtjCED/iBkO4jQABtuEmmLPVSHeG8FPb9ZJ+2/nGDq3JdYwoXtwZO0w8lEAGjGVNX8A88ojEodG35nQr+SOgEtD+HIWgd9C9Ln9slewLnGhErjn9Oa1BKyQszE9CJ/DGdKEVUBP0MjEBoyy3FQSTyILuH4tIAJ2bSStdFuoluJMGcs6K+iWbkXvDIlB/jBRob7BFMwgRR1IThLiVN+nQ3e++L5VSE/KIvqB9ag/FcxP98dH/MBIz5DYFn/6BHSXGCz4vnVml6XMt8Jm4E3FUM0cvNnsMNY3t8Wc+j74Ny3+VDUHCIWSbd7EKeKiGgmx8QPZ1Z81Uhiu6tJkc6fC1qvziNIbf41hIazTNqB6xpvtOhczpiIn4JCCSPw09gqCEPVhwlNJjQe9IDJ3+WMQjHcMH3lPsbA4rhK0Fjwa2iNCxm2GcLNjk1zhR0MH4JUqEmxaA8JOKr42pny8RrXkqjspmDRAt6SgJqY7t8hEfxru6+J7rdbaKYVPyPezTr8QlRJsL82js7Rn19IMbJnxlt73u5okRBuXwFT9kj3ZsBWByYi8/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(53546011)(8936002)(6512007)(6666004)(6862004)(8676002)(478600001)(6506007)(2906002)(9686003)(4326008)(83380400001)(54906003)(66946007)(66556008)(66476007)(6486002)(41300700001)(6636002)(33716001)(5660300002)(316002)(38100700002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NNsFC4Yxn4+O6s46kZjgyq31c4xWqihvEx0mc+5EtCzN6KxzDOk9ss6biGeD?=
 =?us-ascii?Q?J2e4Bvq6mv3p25+AcII2vijBYsCOQeb5YhD0uWELAGYPgwhohJyLTZKwrUcb?=
 =?us-ascii?Q?2uQf8dnb/8qYDE5rv/lUJhXHsXQLgvbuvotxZgIM1z1suyVGSMvTXguS7FIB?=
 =?us-ascii?Q?XGmmYJ4inyVdHfb3arWlNxFFt6chregcWDUhodvDLZCyRqsXTIhAdhdi/aJC?=
 =?us-ascii?Q?ocA54Rv//KcnFCHIsDloYF8yAwi8u7U0s9p58Q0zCLVBtffEWvNVwi+jG2/O?=
 =?us-ascii?Q?pLUSTcatBMxhXiGtOSJ7BhR32+h/743O/9XMxlWlRAGQ6EjbrwFZjtxNsZGV?=
 =?us-ascii?Q?xV+mjd/pOe2iEWNQboV0K71U8JHQouaaDqkHr8B2m3WYpSlygvOw1pfLyAv6?=
 =?us-ascii?Q?TQdzGbwxVk6hlb2ay3o4Gd4FeZNM46/ix2pBTblpkuwZ6ijCiF4i36izoP8c?=
 =?us-ascii?Q?lRvDq+rcidJK1/WX54G97HtDPO6ChfWLbfODXh65jUNcXKOCUlrbEY5Yyyg3?=
 =?us-ascii?Q?XODuXrrbRv9nmljE11F+Auajk2mTN1SiXQGo+GtKbmCcypslalW8DLMAjePA?=
 =?us-ascii?Q?VkLADazjmHjIF2Ff7T+IVvjYbIgjhOyXfS9Er7Sr9d+M+vnYieQWQPSjpIJj?=
 =?us-ascii?Q?PT9NBzQ0KZ3YKSo7E50EutWqscCFRLSbZIyBHAA4+uWDCL+ryfH/Vo5akRq+?=
 =?us-ascii?Q?o1MsFH1fU0mhUent/H+1zMiip8UVWqlq0gJyNe2PdYDOETmLxw2aIvGGTDJe?=
 =?us-ascii?Q?DTkS1fJHkmMuL+zDZUnmHUAPvIQlFJvUsEOMuRCrh4GYdWUK9s0dc4HY6h5M?=
 =?us-ascii?Q?m10tVDRAXwbdCJKGCcSfIERoLphmPpRO1TlAAH2brKdJrqFOj2Ht0pz+FMdi?=
 =?us-ascii?Q?dA3y0reO3hlTQb2pxKU0J0NBxx7Cj6uuSzrleWmKb4NWd7W6e6GkNoZa85A7?=
 =?us-ascii?Q?9E+0o5bNz5IwqUI+ZJ7cTzCSqpUHm9L+vtI/KDd8yMu4sBTmjzjVkhWPx4zn?=
 =?us-ascii?Q?l27okmAVGsajG9Vv8ynN9zgK/YBH910vI0lGBmOMqBRCB2bNOGeUQHaJKhzz?=
 =?us-ascii?Q?WY6yT2nQgdcvPAWSMo/STTzfPoK2oMAYoIZNXAt0scBUpLd2eXXej+GiSr8/?=
 =?us-ascii?Q?Euhbug7jTTemNBRvB3RMXUXdh2+p5n4lrE+/T5NS6WHLPZb2ohUyxwfemmiV?=
 =?us-ascii?Q?/9M8SkcqRIL3/9E03QyXyNr8Qm3vbWQL4Kq5+wBQnNZtzjYS4XJuCx6EaGGc?=
 =?us-ascii?Q?CdeNkjHdmScLi+27eqQbAz/CvvhRl0mZ2auNKHJFwQmobnzKGwLnwXVNKito?=
 =?us-ascii?Q?CujftcDp5tH0aO1v2RN3BgMhyPI5YarhhwoIvgPO5RGmrso92WG7+N0klBpH?=
 =?us-ascii?Q?rDaGYsfev9n/yxnQJ160VvfA5SgAekDNByP0j+6MZvKPuj6fSk5VT4gc5QhB?=
 =?us-ascii?Q?pTv2LRM6WvqhqFf0Zn/tUy8euKz2Mpo0JjelvbDusgOWC0UYI1MSzQpGMDTz?=
 =?us-ascii?Q?mRdyrOtxyBcRAlXQdnYJZWNgmT8g5Sd7eJjSqgkB229WTLJlPLpdkP0Nuixn?=
 =?us-ascii?Q?QW+9hHQUuQ/qHYYzCyFFvx3J74gcHCqJrp+NSFkV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ca2b12-ef96-43d6-b3ce-08dbc92a32ff
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 00:45:28.5185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaZ0HLfAXFii3ODXBLslYEjyj91mW9Mcl+Eu86ja3dgHkSpz+xOy1rZE8saD2o9NO0FPAANxLk/zhR7qCbuAQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322
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
> 
> This switched to a function call.  Amdgpu_ip_version().
> 
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
> 
> Same here.

Thanks for pointing out them. Will fix this.

Regards,
Lang

> Alex
> 
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
