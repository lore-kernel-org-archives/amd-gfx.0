Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5B7CD612D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 19:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79F0E10E2D4;
	Mon,  9 Oct 2023 19:44:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E287C10E2D4
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 19:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1WJfD1P/CieQbJHSYKGq8cmyaAvfY05olCB6o98QQGBA5bYrXMmmUHbunqMCGo8Mh+KEiwrFLnDkVbMW6opwnoxWhLTQLjLgNjcRj90uNEPCCl7qZC3l2+kwZQbJTHwQmigmeiuy9rXk1/355ojKqndDn9yv42fvT5yYu3t9Ia8AuiPYcEyR32O/Q0M+C1P8FFzDdgMh4KC73UxFvAZ19o7Nf1aksXvH3dheUuGt6wMi86zZDleKaLKSXJzYwYqXKTGu/04U5hnrJ+KN8Yhqeiw0oLyntRufAEILFCb1hMSk8IcT3xKkEdkpvvGSwOwnrU3IlKUjnEHGFxXnSQSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UvscshB667nudDZhPr8L09ZYYGBUqahrOW7IqtHEgM=;
 b=NKggr6geYeYYOHKVK9MWzEp5uBdKlTHfUhevTmpxcqjvuAGqvHq8bvh9MmgwaNo5oxVhPnQliBoiWoRK7021WOalb9rNCxrDRs6lTRv+i9tQlQyBIBa2sxukQ6FVBG3JTW4rqHNEDPvqRWO0hzYYW3NmqMdZDVbO8YSaWnqzeG2H4YzmA/H0IfWqMB/y6AU2eaJvDzmjVPSM1i97KsaMallhxYMy+p7WC9wSDj3kWwoyYIvxFs3opvpoD36KvVY+xXmPIqvKE8VarUaqWojmYH/p7KcA4mix2DhTXCnn4Ywt7I0nXPFUC2aYUC8KBk5y+VlK3kEYnov58PTBAOmDjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UvscshB667nudDZhPr8L09ZYYGBUqahrOW7IqtHEgM=;
 b=Bx1bESds0svVfF8TYgT9bAwg3+XwfzGNDF9GmBq7jfrtH1q8tm7i1aRY0m/g6q2y8UG3mQ0HBVJkjnu4GdU6Xr2Yk3dl6H3i/tqQau/aWATQ3ESKFkC4fUi/U0uMjpFq0j1iIugJYnY2oZiYdl/6KVAMGGM/GzrOwgBfP5gJZtg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Mon, 9 Oct
 2023 19:44:11 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%7]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 19:44:11 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu/umsch: power on/off UMSCH by DLDO
Thread-Topic: [PATCH 2/3] drm/amdgpu/umsch: power on/off UMSCH by DLDO
Thread-Index: AQHZ+PveQhpG0vW6AkCyE4KdKecuvbBB3x9g
Date: Mon, 9 Oct 2023 19:44:11 +0000
Message-ID: <BL1PR12MB5144A7CE930A1DEB9778671BF7CEA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231007085402.67350-1-Lang.Yu@amd.com>
 <20231007085402.67350-2-Lang.Yu@amd.com>
In-Reply-To: <20231007085402.67350-2-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=45152d25-efc6-4323-ae07-ec47173d9b0c;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-09T19:43:56Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA3PR12MB7858:EE_
x-ms-office365-filtering-correlation-id: 86f610a4-6d04-481e-4639-08dbc9001c1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R0NJl7UMZ9CjO60+ihKgO28FDY01WwGSbPwrEy1S81/w090qlrxa1jtCAPfM469soa5TD+Ro1VFdF8FTvTj0RJVZIeGfqm7o+TOxba65wwMD/7BiywZOOC0iVd8omGag6VSU7KcVme0ZymIjQ1tS0XpXKW2GaCkYvA7E5enCZKADMY7kdbUZGNo5fmZblby1+gr+3eUTF2K9EG6s2imYhe5UuLxHoSuzr84/9fGEn5P7t9WO99QAwB1zzpmHgag3zyfPfcIRse/8EyWAmSbVqBcSLE62+8GhrLBCA7+xWwn/ghE7pvN1F4rTyq0y23vG6/eOC2ObTXZMMMfe5OWEN20OI5x7JOqIbMw5HDNxs+8gsO5xbZLAy9D7bvvSPos0bJCn44Qf3uUri3ug56F4vCrxQmDr6AfOivX6CX8A2NTO2Nt94axxUSZpVnjaO58U61UysgHinznDeXSwHLHaflhk+kB//FZ5AgeuGEv7TNOc77EMeba+B0K8/Bc9X6fKUHEa6EEqyVcCImdN2jEz3WH4WSq+XLAvoC1sDo15UMK+MERam634X0s/vEU67P1rWDv94Fjby+CcdB8w2untj8vI1G0l91B7PSrKKyQ3sPbpooMOsRwBfweq/ue+DoUw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(53546011)(9686003)(7696005)(8676002)(6506007)(478600001)(71200400001)(4326008)(2906002)(83380400001)(41300700001)(66446008)(64756008)(66556008)(66946007)(110136005)(76116006)(54906003)(52536014)(316002)(66476007)(5660300002)(8936002)(86362001)(38100700002)(122000001)(55016003)(26005)(38070700005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pE3ecVr+ve6xyuzHzgp2YgXJEnH4yRQsEeFk2WfwH8TGC84uLaS/26S41dO9?=
 =?us-ascii?Q?m3EuH/mJDtzEKje0Hpcq/pm7tYdffXVYEyuoKIkyuJgNtL9MzdzFmWKWXxjK?=
 =?us-ascii?Q?y/Op1EREFDa+iCFk3WiEGSFiTbY68rihf2mk1IpfHdpOO0kptSqiVHoTQcEK?=
 =?us-ascii?Q?SQpme4wiUinVF9ZtLSAawDVklDYeoY2XDoH3GIJ0Tr9kqjcxJWg3vikJpJsN?=
 =?us-ascii?Q?5WdcuYg9RLtST/zyEFobwPWurtXaHsyoPduj5BQJd8DpPyUtbN5PGTSGYEVH?=
 =?us-ascii?Q?lmpeGc4ykYJzl7bXDmzJkA9xssU88/VA1ALn52+YL/G70b8e1BgMDXpisUNX?=
 =?us-ascii?Q?A92Fw9ZYBIWmJre8nMiq0mhHuIHZCOL/CtMylwIABZXp59L4Gnm9JjvPjo4e?=
 =?us-ascii?Q?IyLmPNAn02RgsKBzn2r/+TlcOMAf45W1YcWxDjhfE8gcS47WBGMwKccqhPv/?=
 =?us-ascii?Q?gcu9UGA6k/caNE7zNj0Icp/fVPtvJI7EorTDcszvlfhojkmR5YSe+IzDAghc?=
 =?us-ascii?Q?eOQ3oMOSbt0mW8vECE9WykcS0B9C+s9gFAOSMtaZYXDSsDr/qdnvpentP78q?=
 =?us-ascii?Q?/PM9WVeIRceiWL2HH+JpJp/r9ANXUCxMljhri1S7lMXuRgRwZjJcawA9rQXG?=
 =?us-ascii?Q?rR55mXdsJwE3kIgHGYpuBrOak++r6k9dMPDhOj2ke+xJvaHlYeQtWRjG2tHf?=
 =?us-ascii?Q?LLiC1bv8shGwe4iihHwIM4F2jH6gEjuECHi1fOTalMFsbF6vCoWkS2bb6fWI?=
 =?us-ascii?Q?AQnFu6lSKtJ6i55LDDkQEd7cFNweFRjRf17G95bwkohHKDI6w+d3yI/8jly1?=
 =?us-ascii?Q?ZzZtHbdYgsHQq7Vg1VpPE5z2N7Km/n5sW2Si0yafR8hXQb8wNH/u/HH4rxoY?=
 =?us-ascii?Q?euKVNxpK6YNG0tMdJDOZ7yeq7Pee1rGpr6ALTDwxoD7uxRPeBNKBbOeP2bq5?=
 =?us-ascii?Q?W8n6mKU4yrJL03UB4N/MUjvYFB8mj2IBhBKokThry/aczIZXKiu9JHE/B56p?=
 =?us-ascii?Q?DfVYZV2XT3OyelMAg9bSePaSTCuZzE/i89+kjKBpf3wYbaRXSAfT9N+7xquZ?=
 =?us-ascii?Q?Wm7oel3fLGvR5XyfRfEBcRI+QwpoBZ4gZ30gJi1QDvuuLqELOwgcGxxdsuxw?=
 =?us-ascii?Q?wmYtvBJ5VcXqyBjVOjxgM2BcRZMJRJug8Zynx7NaTg19TzqJLX+hzVxcz2db?=
 =?us-ascii?Q?NqRppC1GPYmP/SjRCErYwY9wRFcJnbRnLxcIOQ1x0Yj3sEGFygErOEeSBcAF?=
 =?us-ascii?Q?+HLwUUqMm5P/wgXssfELiOu6AHUe2vNJK7KmqidsnhmVJj7Xwww375fu6Hvg?=
 =?us-ascii?Q?hS0PzRhHrstlXp9NumGHgabcssBRgMtb9oWjnjX577DSmrAR6YF9Zol/qmEK?=
 =?us-ascii?Q?p0L6OwhQpkw1lVDG+UJ3n1XIbIMzqqtZuGrhG+nVUWCglk1WT2+CpRu5+rwJ?=
 =?us-ascii?Q?py7s3CkTH5clsilMv5pP4togX7EwVnRdZSzwxBlZBdMi3/JkzIb6fECXBVMz?=
 =?us-ascii?Q?i9t032IukYPmqpmpV3S0fI3PVB3eCoZ8r5n9Vu3BRQNGIMOdSousevhg0RhD?=
 =?us-ascii?Q?C2TdHkl8Hr/0Z8QYx8M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f610a4-6d04-481e-4639-08dbc9001c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 19:44:11.1168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7s9BA8aWkEBggHY+Dfvw/1f1A+plkpZ3zlYPfMfo7bn5scZCXd/aCfjuqNzzBjwGYgKK5oDNH478MZFd44gD4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Gopalakrishnan, Veerabadhran
 \(Veera\)" <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Yu, Lang <Lang.Yu@amd.com>
> Sent: Saturday, October 7, 2023 4:54 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Gopalakrishnan, Veerabadhran (Veera)
> <Veerabadhran.Gopalakrishnan@amd.com>; Yu, Lang <Lang.Yu@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu/umsch: power on/off UMSCH by DLDO
>
> VCN 4.0.5 uses DLDO.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c | 26
> ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> index a60178156c77..7e79954c833b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> @@ -34,6 +34,16 @@
>  #include "umsch_mm_4_0_api_def.h"
>  #include "umsch_mm_v4_0.h"
>
> +#define regUVD_IPX_DLDO_CONFIG                             0x0064
> +#define regUVD_IPX_DLDO_CONFIG_BASE_IDX                    1
> +#define regUVD_IPX_DLDO_STATUS                             0x0065
> +#define regUVD_IPX_DLDO_STATUS_BASE_IDX                    1
> +
> +#define UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT
> 0x00000002
> +#define UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG_MASK
> 0x0000000cUL
> +#define UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT
> 0x00000001
> +#define UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK
> 0x00000002UL
> +
>  static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm
> *umsch)  {
>       struct amdgpu_device *adev =3D umsch->ring.adev; @@ -50,6 +60,14
> @@ static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm
> *umsch)
>
>       umsch->cmd_buf_curr_ptr =3D umsch->cmd_buf_ptr;
>
> +     if (adev->ip_versions[VCN_HWIP][0] =3D=3D IP_VERSION(4, 0, 5)) {
> +             WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
> +                     1 <<
> UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
> +             SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
> +                     0 <<
> UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT,
> +
>       UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK);
> +     }
> +

Is this the right place for this?  umsch_mm_hw_init() only calls this for F=
W_LOAD_DIRECT.  Maybe that check needs to be dropped?

Alex

>       data =3D RREG32_SOC15(VCN, 0, regUMSCH_MES_RESET_CTRL);
>       data =3D REG_SET_FIELD(data, UMSCH_MES_RESET_CTRL,
> MES_CORE_SOFT_RESET, 0);
>       WREG32_SOC15_UMSCH(regUMSCH_MES_RESET_CTRL, data); @@ -
> 229,6 +247,14 @@ static int umsch_mm_v4_0_ring_stop(struct
> amdgpu_umsch_mm *umsch)
>       data =3D REG_SET_FIELD(data, VCN_UMSCH_RB_DB_CTRL, EN, 0);
>       WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_DB_CTRL, data);
>
> +     if (adev->ip_versions[VCN_HWIP][0] =3D=3D IP_VERSION(4, 0, 5)) {
> +             WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
> +                     2 <<
> UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
> +             SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
> +                     1 <<
> UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT,
> +
>       UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK);
> +     }
> +
>       return 0;
>  }
>
> --
> 2.25.1

