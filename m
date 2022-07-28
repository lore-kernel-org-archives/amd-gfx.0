Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F33FC04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 17:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 240C3113F79;
	Thu, 28 Jul 2022 17:16:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1AF011A015
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 17:16:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gP1hd4PwJGtpWzjTCjQ9y57AdGNAYs6JG9kPcN1bvwrGftt5bTHUnij7oCS0b8mc6svsAJagYu+5C39pAL+/pR+1S6arM36fZ1gAh4mAC4RyIlfxkxwn/UePCm36vZXu2o3Axn3KE9OOoQ4zAQqmPn7XQXwQc6PfBTal9qkeWSJvjbyBuFgkEGUK7IlzuWwroplMt/m2OLHITAbhOpLg5xzx1yxf/msqZ60s3rhzhyGv7Y1Fkprpkt6CIzpgNAFJw+Me+FN5w4TmMFTmz+4qGzjoyCBcZ3DyqXXNNKKgaEzlU3oeUD914xbCvTsgqQha5/caPjXGP2inGATYjxH4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7XkfCvFh6HyKP3may5CTz5sJ7ip62nM2CahvgoZYdA=;
 b=diwkEmWayP0LW7be0pebk/kD++61VuwOcvOPY8/VtNmXBh8ddrPExhK2Gto2F1iPUc74Xasu3lr9ciPya+u4jZSWWtsK4YU72ddt/gUmps6M9wLxsacEPpp1gk7/MR4+xKPk2bbZKwSWRHMFV/N0ZeA9fqlA5Yl5KtgUkYrr2XMgIqyXFJQMwn00bsJ4elVaqYGN4cAAVD/eEME5Bs7L2oYQJvk58InGOacZVQWLHVXw4RF0T6WBNpj8AL+KKnoCDWlv80xHvQXG/SNPZc8Yen6hUykm7/r7dK4QPWelFfi8jhqRaRJ5ibZVHLkln8CFi3p/6pGi0P7iVaseDEQSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7XkfCvFh6HyKP3may5CTz5sJ7ip62nM2CahvgoZYdA=;
 b=weR8oOsiLpVt89EcyVPrwYKbfrIujC/owLLzz9oPcyNN0eseRd+++ogrvbY0KCpF/sXmPNZlQ6GldBHUMTEfxf/7Iwm+4C6wBnXhBu+TIA8YqUGpwaftmvPrK26dhOM9MJK3Xi+dovlpuW3pwofqtIIXObWz8/tJ3jwCT3Kb66k=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by BN9PR12MB5274.namprd12.prod.outlook.com (2603:10b6:408:11f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 17:16:40 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::7d98:3dd:d8a9:9b60]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::7d98:3dd:d8a9:9b60%5]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 17:16:40 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix hive reference leak when reflecting psp
 topology info
Thread-Topic: [PATCH] drm/amdgpu: fix hive reference leak when reflecting psp
 topology info
Thread-Index: AQHYoqRmS3PuBEnds02TNI54R5XG1K2UBG8AgAABPAA=
Date: Thu, 28 Jul 2022 17:16:40 +0000
Message-ID: <DM6PR12MB31637D77D82EECDF898063AE85969@DM6PR12MB3163.namprd12.prod.outlook.com>
References: <20220728170625.2724081-1-jonathan.kim@amd.com>
 <CH0PR12MB53729A99311F0466623247BCF4969@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53729A99311F0466623247BCF4969@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c55eaa36-9152-47e6-91fb-2382118890aa;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-28T17:14:40Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-bromium-msgid: 5a94cc89-1b2e-45a8-9a17-badda5743863
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7754dcfa-4cac-4202-06ed-08da70bcefa9
x-ms-traffictypediagnostic: BN9PR12MB5274:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ubOXKfWa6pvUAMNnOs7ieiIuK69hnLQy7k6slYiqMgxnDIGdiSN8yC5SjK23C4qg79TOChs380lTtjIMPbEj1oBOZoXOSrqwWHaBjVlbXAaUNibY8zIZ0bukg/Rlo92Ud2U/7FBp8FdngSEZVkadYd7sD6x7Z0Wir1oF+UKNkRTS2d2LPp3qbI+4fOdoqnS8UVOvzLa9Sj8JYhrZX9hrjnEvsw6iqozjBq95jndydG83ABoMdrfV2WUlOvauOkdrQiHY1+BZ/XcJCZp8aC4MyG2loavqTSHKcqQ5kAEAHLxLOYXHL4wqxP3FlJg+K7uTu1OvJ3cITSOVpB+JCaIiH5zpwe2qxPOpbke/J5MKt3OgCmxLCDmXJZhiSDeHnLruOTO7NHw6S+FpKo9mvASPHY8aJwbXA9ZpsuETX+t2FjXxI3MD8XV5jwovb+5/XZynEIvMpAWXX+/l/nuKaDEvJKHU4VCitWYV0PhpbNErq9KOS+bwUDhOh5FSFjA0gvHMA6Ca/uM83KeZuaCm/OpexChQbj5LOC/jodNqnumul1rY4B7n3eF3f8cDh9O752a2tQ59Gs/zbXpnjWN6w9fspC0JdkG/JvTd7uWZUC0fKKCReQ68HojDFYN9XPitJ7HphfZnqXLuGtdrD5L1okXdl5S15PIkX5bloQ+mMLqNsWI6NmdfRrGXACA7tFY73bGj7hS/MeWzs8G7rDjnIpZvzxdkpSv4WqafASgwAougshHq+v+oe+3j6k3t2kUdZZMpvot8htrCeByxfm0AvXGwc7I/N/I4BopnesD1APAKQvl95HNz04D4+RZAEbjnKZd7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(38070700005)(41300700001)(316002)(38100700002)(186003)(86362001)(122000001)(6506007)(83380400001)(110136005)(55016003)(7696005)(2906002)(66556008)(8676002)(76116006)(66946007)(53546011)(66446008)(478600001)(66476007)(26005)(5660300002)(33656002)(71200400001)(52536014)(8936002)(64756008)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U5hvXNOLl+sYoNljsy+R8knlooLcmaJyZsbZ2v+SsNuhpbK0HwJrh6OuZq5t?=
 =?us-ascii?Q?QvACO8MpnCv1kuqPVTRbWhVFZr80be/iPKAWJ9VVDpEleG13uD4FIVM9sB3R?=
 =?us-ascii?Q?sHhQSYJSDRwsU2PpqnteRmfLxM5Duqm1S5kqHOiw8M8YXDHVPGCFi3237qxT?=
 =?us-ascii?Q?D/2H0jtBqPM7ffvqDUBQudNLmCLyeZUcWhaitIEt46cpa04fiOzThvJhpro2?=
 =?us-ascii?Q?hFbPkzbzTnk45CdEfg49WW6/bjTtBD20h7haoDayzTDfaJo4kO1dGUUZMVf7?=
 =?us-ascii?Q?8HTFq5C+4f3icFTmOk5kvYl5xNmzVwNan6A0jYSQOailYOJfawF30A+59DGR?=
 =?us-ascii?Q?vgQKrzY2TyGXn+jhtF6ZZbF+TTwh/fc33ulTX2E328qy8FSnObA5DbDWBPUH?=
 =?us-ascii?Q?/CBRmJhB7SNU5zeEmXyCSIU0dwYAHXbS+03epSkDPMVS6XyYTSJVc6H7V25R?=
 =?us-ascii?Q?cFwUvLws/HHhjAa5ozT/CBdAJOmkuM+mGDn4w9E2myzJxfVfwnpM0SPTMBua?=
 =?us-ascii?Q?5O7ULR14zVZHqWyUeQHJalfcCWkFbolrb5uHzwpv+qa6kd9bsBjnXGBjyeFo?=
 =?us-ascii?Q?aDMrezsaG+d5qb9mV+6dfjHfRgwAdNxF4ArTi3s+kW9S0ryVrCJ1Z8Q6Sbqf?=
 =?us-ascii?Q?UJORW3NuRMlEdElygyQYVIWeI2iKp7+zWoUwtI3cPaSokl0sbBUdu1SiO9j5?=
 =?us-ascii?Q?ME4Fx57CWvm0qB69CtMa2DAeKsBqJQCJEdBt/MdL56jyC/ZFQLTEuoE42Y9W?=
 =?us-ascii?Q?1wedwMPMRLBsq0ZfN9aOSeWZLnO8/nPMf/byIWsD8Xt8BhoqUnf+JXqtE+81?=
 =?us-ascii?Q?ViGwEYAT1zKnPNnifLT0qCdbr7hzA0O6fCoKgFBwO4IQDo8Dh7KSnoX1cbNS?=
 =?us-ascii?Q?4yK2GYQmvtlfWL6H/v1SX4qV3ZHV0ZzY3SSe+Qe7Flh1yHCTHJthFpWJCl9k?=
 =?us-ascii?Q?DuXZBAV1MPCIFr924MeU6He4EuAdttqKaitIgiWLwpByQHYHlzCutv5wA4gR?=
 =?us-ascii?Q?VwLUjxzqLJs+pZbKXhUGdovz4yjEUAsLiCYHULNsy9y7vkno6e4h+OOfAVFT?=
 =?us-ascii?Q?YC3BY2lEgylqPwh4xO6f50MlGdEk8wvC1BjyVkLTeScf/5Q5I4iAOULxs8TK?=
 =?us-ascii?Q?wN1MU49tSw24hVA7iVLmPvEEK1bCSX9M+0OcrveDTnmuRRyMCNPtZwafoSIH?=
 =?us-ascii?Q?gklyHLwTY+GtcKTrP4YjK8i5rSdU4XXPdyZRZPXGvB+wpuVI4zBht6AYUt4P?=
 =?us-ascii?Q?YwzqcldopqBmYkxO0Ex5Mm6UvEk7URKNcFJOr/QqCq5cVVD6ICXNBlVn+xp+?=
 =?us-ascii?Q?PxqMmv0WAEbuLQUXqV6Lns7Ek0l4cJsYUvpShQiIP+GIMCQydB9iF0oWoI14?=
 =?us-ascii?Q?8SeIOG+znsxd4RjGZfb7izt8M2RbBw3EbslOH6Jv10MH185NgjinYcOV0M7U?=
 =?us-ascii?Q?FunJM2qIVH1CcqELCHJwrN11tdvOXkukL50LUv+Mx71E02VNdMwU1RAAAndv?=
 =?us-ascii?Q?tskKQ36QTiMyV2+SwHyTjxMSqThrzosMpJpUtDnFgZMLjO6U37uqzWf7v0DG?=
 =?us-ascii?Q?sFbE8nY+gJwJq9IliMk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7754dcfa-4cac-4202-06ed-08da70bcefa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 17:16:40.3028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUC40XLUHMQtRil/w/qC+obP9i4QxTkGArR+fpKP77KLzLEvUn7+52npirX0ngue
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5274
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Sent: July 28, 2022 1:10 PM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: fix hive reference leak when reflecting
> psp topology info
>
> [AMD Official Use Only - General]
>
> Looks good to me .
> BTW , why we didn't catch it on baremetal mode  ?

Thanks for the review Shaoyun.
Good question.  I'll double check what we're doing for unload testing.

Thanks,

Jon

>
> Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jonathan Kim
> Sent: Thursday, July 28, 2022 1:06 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdgpu: fix hive reference leak when reflecting psp
> topology info
>
> Hives that require psp topology info to be reflected will leak hive refer=
ence
> so fix it.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 3ee363bfbac2..6c23e89366bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1292,6 +1292,8 @@ static void psp_xgmi_reflect_topology_info(struct
> psp_context *psp,
>
>                 break;
>         }
> +
> +       amdgpu_put_xgmi_hive(hive);
>  }
>
>  int psp_xgmi_get_topology_info(struct psp_context *psp,
> --
> 2.25.1
>

