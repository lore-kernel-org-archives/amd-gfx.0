Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94523CD98E0
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 02:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C75FE10E19D;
	Wed, 11 Oct 2023 02:17:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF42C10E19D
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 02:17:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDWRRkx9Gi1hSUw0QE8i+StUD0fkvjGnheWcFQzWxnocRsuabzOctMUoMPveTNH+b7ZIO8RwRSemk8l+aOuxU86dsUPbkT/ZW4oq1uHMmYUiPcCxd7b5sJ32Mq1fraANva5gP+x7Af1s2YTRapZ0k38Eqjnp1QaFxvX8WFd57LRVi+q8lZ1KMZ5O4hUMh2Rzj+UXLlsgdHhsqrwzq8dLWmdGi1RkwZkuXYboEbgtr5GuV153EQlpGQxl/oX8QoEXoyeznNGaBfnG/gYdkHhWI7msgY5zg5PRTh6j0SiU4ZYwgSmkpzQr1IyDurrI2xOnJSxYY/EE1fPnKkw3kDiLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSU/1oqFuEBxCXUhD1xpwzFbx4W10Y6jrNmoXScSNWc=;
 b=Dtnj1aBdIdKjPjuAmZ9oubd6wemvA3uOUAOsWJCnalxgc5qp6x2QQ7bLppXvvAHUsCUxJIAo5k3rM0b5BHyzDJo9Iaxv8KNZggM0SkxIO74qt8vfZZHylDYphAs9zbN4D/AsjyxCiGmq77N77qnWooi6QVc3DP6QxitEuoNNtHIJmGi3H9AknefL6bLInx/NIz8sNSufq4qUnmtaVseoKJYjoLit2/laYZcLOqOOLVbjUnYEMByGQwPZ5bqwNrJf97JEecX/dyKruZP0Jj/Jry+vrZYT8PLX9ZQUGIECvLohNTT8c5xjo37ung7W6Tu3FNWw4KazEqYkFUx9kydb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSU/1oqFuEBxCXUhD1xpwzFbx4W10Y6jrNmoXScSNWc=;
 b=GD6YNkFy3ZrO79mQGwcyaKvLdKS0fwUiJhWQiVQm2nozlG3bubkgOqkAY9Rr09LS2YcpgB4myNdJkq7tFkTY8dbNiaZBzY21oaMY8fwW+WtVAxxaQt/qinp/R4BxI6Fuh89jyZhSmejGbV386D7E67+rI2Depy7o0klyT7cDIg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 02:16:57 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce%3]) with mapi id 15.20.6838.040; Wed, 11 Oct 2023
 02:16:56 +0000
Date: Wed, 11 Oct 2023 10:16:46 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu/umsch: power on/off UMSCH by DLDO
Message-ID: <ZSYFjubrhYTPmkcm@lang-desktop>
References: <20231007085402.67350-1-Lang.Yu@amd.com>
 <20231007085402.67350-2-Lang.Yu@amd.com>
 <BL1PR12MB5144A7CE930A1DEB9778671BF7CEA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <ZSSeWF+QzRG8/CNa@lang-desktop>
 <CADnq5_PigFnW97EqCEL5x0joDBZO5qqaCyUSdXycDO-1BxSxKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_PigFnW97EqCEL5x0joDBZO5qqaCyUSdXycDO-1BxSxKA@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To MW6PR12MB8898.namprd12.prod.outlook.com
 (2603:10b6:303:246::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8898:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: f212da87-1d34-4146-8b93-08dbca00246b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVqZ951hveIZnVWbrXQa5w/qKoNAarRUzi0DTnoMS2/2AYmg6dW1IsajJ4A5BZVCl5eI36NXcxmGh5TO6ExKAaMT3JKs5Qg7oXC+y6zyHNmr3oTIxaLTCuz8gonQgnWPbaHM093f5zkG3VlhhDeUjMSEFcSSxZB0+tgaXeLNiF9z3bUi3opYg4MTu9+lTtP96r6kXuPWuNCqS8avU6YhhhxsxLSoP3tiJPrZxZ52a1vuMnJzzwhgZau64c31LXzf4Wj98h9LZkeAiU6+8HXe/U6vf19IXJxbnd4FysIlFIo16adshiTEGtj8tC9OAYhirsyurHht4eShxF+0vlr7mEnEldQKL5M8XnHntoAbziNnvv4vGSM83lrywRLU+WBy4Lne/1ykktb1Q569GPSq8EjTIeFFA+fbxNaTqiHoU3UbQWTeLKzf9/Eag2+1+VK2CNGF8lm+jEYPSwGE0JVXNM8wWQm6GIZXEwGCkGhq0Ag3Yzs+OA4NSre9fkPFYTohpbYpqbUx7ZRfBnJfkYBBYSOubCGIHWfh2siPg7GMX+71vC4cctWkBAWFVa/ZJJe3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(9686003)(6512007)(83380400001)(6506007)(6666004)(26005)(6486002)(38100700002)(33716001)(41300700001)(478600001)(53546011)(66556008)(316002)(5660300002)(66946007)(66476007)(6916009)(54906003)(8936002)(86362001)(4326008)(8676002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTNIdWQ4dksraUJPb29rT3FPbTZac1hVZjZFN2ZudDBOUGlrSWNidTllSDFp?=
 =?utf-8?B?b2F4ckRkZVU1aDh0NDBzS2RVRDhSZDVPK1VhTXRSUGRBVkM0YWNIakNEVzl6?=
 =?utf-8?B?a3E5MGZjZk9YbjFrTzVCaHlWRDg2L1ZNSDZzVmdRWEpadGRkbXdLMW10QUR3?=
 =?utf-8?B?Q05mRUZMNmZMQ21lclhvUWxyVFB6SjRoMVFWZWdCMUhYT2hDWUFQOFNlSXFY?=
 =?utf-8?B?WW9vdnZqenUzV3NreUZISHFkY01rdENsS2VPeVZhNWNSN3BZdlg5QUxmQXVt?=
 =?utf-8?B?UzFFb1pBdFI5VFlEYzZSOTZEM3NDR2JzQVo3UDRuTmtoYjYyVjNTK0dvazZ5?=
 =?utf-8?B?UEhIclMxTnlDNXI2RnhNZDJaOFpVenJZVkpqYmxXQS9oVnBjZWtxRW0wUEJP?=
 =?utf-8?B?ZG5vMjJXVnJUcGtkVDNqVXQvd3Y3YktWcmpmYXAxSlMrdXdIeG1Wb2NnUmxH?=
 =?utf-8?B?Y3l4ZmZQTWdFejNjdDhPdmlCc2R1d3ZEYkE0bWdySy9nb3JLSkdOMlhPME5L?=
 =?utf-8?B?bktoVE1vSjkvU0t5NVYwMlErSzdWV0lGM0FzM3NqL05JUXhKY3hBY2RRUHRr?=
 =?utf-8?B?dzFpbmE0S1dGTmpqQjFmS0N4djVCRlNHRjRvMFRMMUpCbXE0SWZPYW9VVlN2?=
 =?utf-8?B?U041Rmxod2pBRTkrSUNQSU9FQW1DQ29qUTQ2U1drcndjWHBFNXNCekU4VHly?=
 =?utf-8?B?K3lrMzk0UnROT0F5VGJXOEJ3SDdwa0F5MWIrVHRNUDhHbmxlMFY4cUZ5L0lv?=
 =?utf-8?B?L3AxNkNHNVlSZ3lKL1J4TklHNzdTZVpTODNpbDlQUVlXbXVJOXc4eHdyTWho?=
 =?utf-8?B?M2U0Qmp1ZDdJaDhEdnRqUzZVdWtHRXA1ZW8vSU5BNitVY1JUQlNjbXF6Uzgr?=
 =?utf-8?B?MzduRCtORnhVKzJwOVRvL2M0dmRGSXprOXBUb2MyZW1rNnJwZWY3ZTAyQTBE?=
 =?utf-8?B?YnRmU2pGcVlPL2N4bVpJT0U5UStVWThTS1AxMnZoOFJ5VmtveXBjVlpxVjl5?=
 =?utf-8?B?VlNsb256eUxqa3FFUXlVdmV5VFhQdDF3L0NLeG9vZ3liczBBOUxLYmVSSDhD?=
 =?utf-8?B?QmI4aHBBaHJBWDlsUXI2cGgvK2ZyZW5DZjVzTzl2eDdteWNRdGdQcjcyZEZ5?=
 =?utf-8?B?TitVZTl3WTJMK2FUNDFidmIyQi8xNWVRd3czNEg4S1QwOE9vUFRvNFFuNVdG?=
 =?utf-8?B?OUN6cUNhcFQ1S0s2NE5PNkw3OGRYeFIvZE8rVDEvM2JKMld3eWphSnNRRzUw?=
 =?utf-8?B?eVpoVXcrU2FlclBBZHZrdTFaN0Nnb2w5VFIyeDVyZy93dUUySTl0R3pHQmQ5?=
 =?utf-8?B?ZTQvRDNtb2tscUJVT0NBWE5hQ0E3ZVgvNXV5dWI4eVIyd2tZRGZwVlMwV21Z?=
 =?utf-8?B?TXV4aVFoNHRNb0ZHYnBuaU9ZdXcwbVp1MjVsS2xtVXV4ZWtYMHphRTNjNnpn?=
 =?utf-8?B?SDZqNlppU0w3N3lXeFpwQnhNdXJkckZBTWhzVm50TXFOaWhTT2llTzJGREF2?=
 =?utf-8?B?dlVTRDY5cnVjYjFXc045VzhIVjY5NGt2RjlkRXUxeVNNclArRUFEOWpLYUd6?=
 =?utf-8?B?OUNxbTVsWGJZZGZWZlZBRWkvQk9RU0g0ZTY4MWRFczJoaWVkNC8xZlM1Qzdx?=
 =?utf-8?B?b2ZoR1g4ZXc1ZDhEMXRIemIzT1NZY2NQNndGUm1YVklnUXM1UzRhWXZubUU3?=
 =?utf-8?B?Qll3WDFXL2FnZktRWE1NZXpMQzZvZlFwZFNtWWl1UTJSVFFWckVXNW1vWG5z?=
 =?utf-8?B?cTkwTDVwYUV0ME1ldTBrV0dKY3J3Qk5WZ1d5Y3dRd3YzN05QOUpWS1R5WXJX?=
 =?utf-8?B?RURld0NCa2hqSkhFaXRHSCtRKzREcDNidEo3NStUNkd6aHh6U2wwc0ZueU5I?=
 =?utf-8?B?TkJaelhmcVYyV092ejhNNGFsUXBObklGWHVPNDhtaFdnMkt4a2VjK2tkSkNz?=
 =?utf-8?B?ZWVaM0hnaTR4YURrcXU4SHdvWTZwdGJDbnJzUVVNZFI1d2p0UFYrZEFqbk9D?=
 =?utf-8?B?UHhJeVUyOE5oQ3FjL2FwdlJEREZvYWZ2WnJ1OC9MUU9WbEhqaTFmdWsyQWZY?=
 =?utf-8?B?ZjdPWFlkREpCdjl5bmdLbkwyejFUbmRrMXNsWWNPRDQzM3A5Y1BjcHJhUHlu?=
 =?utf-8?Q?kLVUEytJzLMHnkP3NePdv8S8W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f212da87-1d34-4146-8b93-08dbca00246b
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 02:16:56.4221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4sdhjNgE5IOv4iMaoDbELvZietieKdT0B2WsAohk/PcsuWI9akZlAQB7ibpLsdTbGeWDudiKhQKJOHK8QrEIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Gopalakrishnan, Veerabadhran \(Veera\)" <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/10/ , Alex Deucher wrote:
> On Tue, Oct 10, 2023 at 9:42 AM Lang Yu <Lang.Yu@amd.com> wrote:
> >
> > On 10/10/ , Deucher, Alexander wrote:
> > > [Public]
> > >
> > > > -----Original Message-----
> > > > From: Yu, Lang <Lang.Yu@amd.com>
> > > > Sent: Saturday, October 7, 2023 4:54 AM
> > > > To: amd-gfx@lists.freedesktop.org
> > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> > > > <Yifan1.Zhang@amd.com>; Gopalakrishnan, Veerabadhran (Veera)
> > > > <Veerabadhran.Gopalakrishnan@amd.com>; Yu, Lang <Lang.Yu@amd.com>
> > > > Subject: [PATCH 2/3] drm/amdgpu/umsch: power on/off UMSCH by DLDO
> > > >
> > > > VCN 4.0.5 uses DLDO.
> > > >
> > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c | 26
> > > > ++++++++++++++++++++++
> > > >  1 file changed, 26 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> > > > b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> > > > index a60178156c77..7e79954c833b 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> > > > @@ -34,6 +34,16 @@
> > > >  #include "umsch_mm_4_0_api_def.h"
> > > >  #include "umsch_mm_v4_0.h"
> > > >
> > > > +#define regUVD_IPX_DLDO_CONFIG                             0x0064
> > > > +#define regUVD_IPX_DLDO_CONFIG_BASE_IDX                    1
> > > > +#define regUVD_IPX_DLDO_STATUS                             0x0065
> > > > +#define regUVD_IPX_DLDO_STATUS_BASE_IDX                    1
> > > > +
> > > > +#define UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT
> > > > 0x00000002
> > > > +#define UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG_MASK
> > > > 0x0000000cUL
> > > > +#define UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT
> > > > 0x00000001
> > > > +#define UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK
> > > > 0x00000002UL
> > > > +
> > > >  static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm
> > > > *umsch)  {
> > > >       struct amdgpu_device *adev = umsch->ring.adev; @@ -50,6 +60,14
> > > > @@ static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm
> > > > *umsch)
> > > >
> > > >       umsch->cmd_buf_curr_ptr = umsch->cmd_buf_ptr;
> > > >
> > > > +     if (adev->ip_versions[VCN_HWIP][0] == IP_VERSION(4, 0, 5)) {
> > > > +             WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
> > > > +                     1 <<
> > > > UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
> > > > +             SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
> > > > +                     0 <<
> > > > UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT,
> > > > +
> > > >       UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK);
> > > > +     }
> > > > +
> > >
> > > Is this the right place for this?  umsch_mm_hw_init() only calls this for FW_LOAD_DIRECT.  Maybe that check needs to be dropped?
> >
> > That check is dropped in [PATCH 1/3] drm/amdgpu/umsch: fix psp frontdoor loading.
> 
> Ah, I checked that, but I missed it.  Thanks.
> 
> >
> > PMFW removed DLDO programing in PPSMC_MSG_PowerUpUmsch function.
> > So driver needs to program it explicitly.
> 
> Ok.  So is the SMC message still required in addition?

Yes. Some masks need to be updated. 

Regards,
Lang

> Alex
> 
> >
> > Regards,
> > Lang
> >
> > > Alex
> > >
> > > >       data = RREG32_SOC15(VCN, 0, regUMSCH_MES_RESET_CTRL);
> > > >       data = REG_SET_FIELD(data, UMSCH_MES_RESET_CTRL,
> > > > MES_CORE_SOFT_RESET, 0);
> > > >       WREG32_SOC15_UMSCH(regUMSCH_MES_RESET_CTRL, data); @@ -
> > > > 229,6 +247,14 @@ static int umsch_mm_v4_0_ring_stop(struct
> > > > amdgpu_umsch_mm *umsch)
> > > >       data = REG_SET_FIELD(data, VCN_UMSCH_RB_DB_CTRL, EN, 0);
> > > >       WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_DB_CTRL, data);
> > > >
> > > > +     if (adev->ip_versions[VCN_HWIP][0] == IP_VERSION(4, 0, 5)) {
> > > > +             WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
> > > > +                     2 <<
> > > > UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
> > > > +             SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
> > > > +                     1 <<
> > > > UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT,
> > > > +
> > > >       UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK);
> > > > +     }
> > > > +
> > > >       return 0;
> > > >  }
> > > >
> > > > --
> > > > 2.25.1
> > >
