Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54566CDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 10:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE89410E0D2;
	Tue, 17 Oct 2023 10:30:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0DB10E038
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 10:30:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GE3tzK7Yp2YOd3EG/yeFIhWZ+I0U/v42K2VIeBbVslFKp48y7Nl5yHwNF6+kJoZ5T23s1Vcj1Mwshu+uAGDeh+H7o0QGusM+JVd34d5LoV2O2tz6nalxewjTecqL0vTeaTVRoP2bHIGP5QTF2GgS8jESCy7Uv/tbAUmOnVxh8lycQ4zXDnRG3StJjq7n+Ox7sovj/Urm4X9KXP4xQwDPHfn8b6amE7FR/TV4/IcpWsV64/EOzlAVRC1ZOb57zthLYhREGw24oOrrREMLcfCevp6ue6DH98PbOR+hZasZ/nQg3v/vn1q7B9ofgtoFrx/iUW1CVE1F+N4xj3UNLxYlnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wx7oUwkug3Q4YCyXkUojQ/a2JwAxZo88++eq/tCy8ag=;
 b=oXGKmDM3CEi087jFOO1960U4mtgOvNjS3fdXJXdGfbN/+iz+5IvNWTVuRcqp4IhNm1r9/vhkTrzLGoIMkCEdYzABTmj75H5hRCUPOMPQKPlHJTPfHVeAQy2QNPFKLP/u/UWn2aI946I2T1WgIUZceu6ynAp2NgCmvd8RHsAoUnh0yUfG0N0DhdAN+N07BAXEsd5SWugUlSGY9LSmj++KH5mSDCtoUvq2KTyClwa1+tDxMgD3GC8DCe2dnSPUqysLo5ryvRpOfwhHCywcB5PNqxp1mblGvXc1v8IgncU1HZrNe+KzTbjVNaMZ7y9Er3KwaQmlJo9cxxkIaJ/WekA2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wx7oUwkug3Q4YCyXkUojQ/a2JwAxZo88++eq/tCy8ag=;
 b=QZl1EBCZmjCwmy5k3e/fCMcG7oLqPRJqOaVMKPImxMQGkyM1FpQifyuAPiwiWDvGkcz6XCYC+Z7Q/JTRYoRrmyz+iAdsG8zRkhTwVCWWp9vE5fdPVresL3reLV2wP44B/3O63RqQciAlkomK2SPidEd4znLPiqphpf8p76LTaKw=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 10:30:11 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::8a99:3210:8bbb:a65d]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::8a99:3210:8bbb:a65d%3]) with mapi id 15.20.6863.047; Tue, 17 Oct 2023
 10:30:11 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add clockgating support for NBIO v7.7.1
Thread-Topic: [PATCH] drm/amdgpu: add clockgating support for NBIO v7.7.1
Thread-Index: AQHaAOH4N7yGywwL10eHBMcyqeAX8rBNxzug
Date: Tue, 17 Oct 2023 10:30:11 +0000
Message-ID: <BY5PR12MB387354DDE5A9735C62CD8F59F6D6A@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20231017100857.2419826-1-li.ma@amd.com>
In-Reply-To: <20231017100857.2419826-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=692277b7-a53a-4fd8-9609-55b34d55de9b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-17T10:29:48Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|MW6PR12MB8915:EE_
x-ms-office365-filtering-correlation-id: 7fd56041-9f01-4339-7a6f-08dbcefc0af5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xZzCO8Vw75d2xqXrxg/mwVVpo0ssVh68L7DdVjQ1iPXDJPvdaYqn/myQ6N5kGJuI+cdqHCHXG227V0pYxMEsa64yRpPpemNVXzniQwni3bI+gTXWfb6eHES0PA0blvBSTmaV+KCSxsrWzbcggLZturkn5dVpKvNabFNpipTbKrsJ/Mmf844II2bBCWR3XPnFfR3xuaejfeGchUMb7ur8M+4eMYqLZNXHRK3rL1fsNzNOeamAeDbHTvnBlKkg2bm2avIJqT2Dqt1cYvajXhaqBJjTJrfgyAhvJn6bSId038NUjGQkb3ai51AGNMr3EXHFQSJwRZA5vZX1HzS7Z3OiIW5Ucjz8j+CdGOIckcd+i91A6P7ZIwGxovO8wu4iUPWVrQuIGMp3R/qaXTiws8zyR6yWluIAq/gC1A359K2z1KWqOermqv8hePbAVnthIXUODM/Y46vVEwaJIyapI+tgvtn25pagwE0CqcGLZ3xKvNwXHh5POcYnLETTA7Mf6f+hIZTwDFV71eYb0NjZrW1rFxheit9EoXBspcd2Uoi2OD+YLCjumviJWHm8GlA2HJK1KYMkbazd5GnYeuilYrXnLaSJjPIt7AjAK+WdIR74LriCWWBHnKOWfitAjZr1vPLH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(33656002)(53546011)(26005)(41300700001)(83380400001)(9686003)(86362001)(38070700005)(38100700002)(122000001)(2906002)(6506007)(7696005)(71200400001)(55016003)(52536014)(5660300002)(64756008)(66446008)(66556008)(66476007)(66946007)(76116006)(110136005)(316002)(8936002)(478600001)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BWEvy6JKaHV/1ZZROpHW6rp3w4j4bK1wACGfwYQMpVBAp5WgGIy2ROtCt/+T?=
 =?us-ascii?Q?v6t8JFmIfVzWQujKQGSR+Ttp/mF5wANEWxoR8gbx9Ba7gkkZMHnHONBPLGMn?=
 =?us-ascii?Q?tiLvkAiFugjmOHctT8rMO+NFuWjPGUy2yCI81zyQokn+GTbYcahodwGoZKOL?=
 =?us-ascii?Q?IOofUDNVh3T2sznJAv6xgD0tf21tUHBSL3t6vaTc9oQ3JAF13H4IakoIQwNL?=
 =?us-ascii?Q?0TR+/B/xPQ0qmkVk2s5I3qL2plD9/jjxl+k+e5IeM2R9bmeE/f0Aei5dnkf6?=
 =?us-ascii?Q?Vehz/ysQg5RRcU3p4LXlsj5zT0GXAWz/OFJXsGui0jBVOLohbJMaVPwi4JJc?=
 =?us-ascii?Q?WBFP5cRNA+wbg1TnOmZVuFbG21Nm0syxhbBEz1suSiagF5Hh5Czj33Ec2IuY?=
 =?us-ascii?Q?OD7G4wrGs6EizGR7CdaSwoMUgEHuB5dm4R41NEdFRLCw9cT9X/o9Dit/l0M9?=
 =?us-ascii?Q?tuOmD5VqR1j/QEtvifF4BFKoANCI75NH0RgBW+h8VnEBrElz4+hFhAAz8IcV?=
 =?us-ascii?Q?NlPRLje5camR4LqPP16BGk7lcJLh8yB6y3siQE421drdqoRxJja06JOypapx?=
 =?us-ascii?Q?8oJhXVxxGADQOgbAVRGWsZWwz1A0R2mN76GgyG+oDOIIZ3tXii+U8aUK2Ey3?=
 =?us-ascii?Q?Z2d2GL6vp7qOlkW30tUVK4kTLxx7kkvu5JpsNdAcGxH+WCLCgmigvUjK1WXi?=
 =?us-ascii?Q?pA1BXhElNx1AVtG5bphPhnPK6rLztBMmdzxxUlJ6G+9uMUKM2eKsZp0k9eRC?=
 =?us-ascii?Q?5Jn+i4JVW8zbYnk/+vS7pAwT3rQcjRpDZnpJH5MLx1trJk57A6NWxpp6RA7O?=
 =?us-ascii?Q?0dGSz9Qr/ks/wuAgnZWRGAHgbfZOuR3IUfRzKW3RA8vxe/pZ3nhbjCj7pPiF?=
 =?us-ascii?Q?nn4ou62N1/jKTKXgt4gZkGUSXwjvz0iDnmLblGrqYjCR1AYzLBF9U39s9nzL?=
 =?us-ascii?Q?TFVv9DoHJwKRA8uXMAJ0MzSeKchrHVCZYJR2bTJ+SLX3GvCLIrLMsqZUngIM?=
 =?us-ascii?Q?GfD92A5sf//zHKi9ifZSejFOHx0FcX4/llaE9VkI+dW1lv8W9FwI5ryFpbq2?=
 =?us-ascii?Q?nOzjugL5vmik7StSPAKklcoJ3XaEnksaXEI0OZcGqs2C8GRz1LAMAP/47R9e?=
 =?us-ascii?Q?wwqEVrhMo3/EEI9VW3+ZVTHxtGofxPb9pIBz0rg7tYWFcwxhSr/MLPDHCwOp?=
 =?us-ascii?Q?BxT9kiDfFnTi5sXqFrUEM5ZM0D+rNaz+gNhrypuYatAgz9GVsYmXDsXtZPya?=
 =?us-ascii?Q?WDcrBUCar27tLFa7tmomXB3grq/kRDD2wReMNeaVbHjn/SnORiL8CMlyMd+8?=
 =?us-ascii?Q?1RjsWSPCM40eXUq72CoVS+ZCUK6pIDDEgyMekT2NcCcJxPhHXxijor6oriso?=
 =?us-ascii?Q?V9g0Z2g0hJ7VHfyy1/ITa6gbbV9BuRI2D+uAKH6D+PJ1oK/IuIM+MyY+6S93?=
 =?us-ascii?Q?AUbYdtr3c+JGkHGwRybvEvBLUsKD2bu+YOOKDlet0OOw1x45uDWvk+1AnQQT?=
 =?us-ascii?Q?q8GfSoiHozrGkLLrwWwyVmn/Vc9OcJjobr9Vmto1StnsaPhEegBlXeeOye1Q?=
 =?us-ascii?Q?fT1os2x3mzR3nB3Qdg0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd56041-9f01-4339-7a6f-08dbcefc0af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 10:30:11.3992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ow9cnw849khP5pHy2SWPHOoGsn4s8jkhrVGUmMiIx4XjPvKxMwaryzhzQ31dAzKiGX4NHFvviEKh9AtMObLmTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Best Regards,
Tim Huang

-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>
Sent: Tuesday, October 17, 2023 6:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Ma=
, Li <Li.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: add clockgating support for NBIO v7.7.1

add clockgating support for NBIO ip 7.7.1 and modify if condition.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/soc21.c     | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_7.c
index def89379b51a..4df1055e640a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -254,7 +254,7 @@ static void nbio_v7_7_update_medium_grain_clock_gating(=
struct amdgpu_device *ade  {
        uint32_t def, data;

-       if (enable && !(adev->cg_flags & AMD_CG_SUPPORT_BIF_MGCG))
+       if (!(adev->cg_flags & AMD_CG_SUPPORT_BIF_MGCG))
                return;

        def =3D data =3D RREG32_SOC15(NBIO, 0, regBIF0_CPM_CONTROL); @@ -28=
3,7 +283,7 @@ static void nbio_v7_7_update_medium_grain_light_sleep(struct =
amdgpu_device *adev  {
        uint32_t def, data;

-       if (enable && !(adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
+       if (!(adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
                return;

        def =3D data =3D RREG32_SOC15(NBIO, 0, regBIF0_PCIE_CNTL2); diff --=
git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21=
.c
index df7462cec6ab..3ab188067d84 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -863,6 +863,7 @@ static int soc21_common_set_clockgating_state(void *han=
dle,
        case IP_VERSION(4, 3, 0):
        case IP_VERSION(4, 3, 1):
        case IP_VERSION(7, 7, 0):
+       case IP_VERSION(7, 7, 1):
                adev->nbio.funcs->update_medium_grain_clock_gating(adev,
                                state =3D=3D AMD_CG_STATE_GATE);
                adev->nbio.funcs->update_medium_grain_light_sleep(adev,
--
2.25.1

