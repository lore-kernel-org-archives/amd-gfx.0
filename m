Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAEEC5AD49
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 03:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 681DB10E5A5;
	Tue,  3 Jun 2025 03:04:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RxfOemt9";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD37910E5A5
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 03:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJzBwUgPCLTQjDJj+kaSDwm1e59ygDBNAcK9kfyGKQ+ORfIVk7/MJnoL2To32QjWzeB8CinwMgSmkhldsTFibJ6MFnE6XobdgURbTFDqXRENseyEqSGp7/aBkr89/4VhlnC7MNivmx6GFhZ0wHBdufHHy877VcIFSIGvie18FoKHBq3aWJxwD5a0bhyzIxNSXOabdGNL/7Y17gqeklEp8FVGoxhb8MiEgeWnBrLB94EDv0dFki6UkD2WMSLf01Yuqa9zcayOxBHoPY86Q9E916kLyIsNUfXjX24UN9a95pN1sUxYbX4kUVuH8i+FVQnGPZr74hW7H+q/FUiPcSWTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yulOVUWqHYR7v846ZaL7uLKUYy95nZlV5uIcIC8p8Es=;
 b=Q3nufu4Eu+Znm1mRnWr5240y8co1+t0f0v4DOkYhbBPBCEvRtqN+1WImteo38gJwU4GqC3d97k/PxxzcUc4EzEDtnFMK+/5S/AFnqGl2krDlr6HfsIh0WBsTUUW+cfDxWcAHDQ/C8sM28q2CaYxpNRO352OvIPNqH513Jeg3/aUj6nv4p8p6aOPdaL2EgXKrJcVYfXZh0nk6wyJgQZnGkAJ7BEi73Apxa8//3fZg6pokfiC0wnKk78HmjTrmhmGAdbVp7BMhSpXv4f1WBqdq853Pxk9hVUaqvPllsd17KpGebURl7UdpSt0i6C+5ltkT2/vAmXYFGknbjg6LXIFdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yulOVUWqHYR7v846ZaL7uLKUYy95nZlV5uIcIC8p8Es=;
 b=RxfOemt9d9kWFKmZpI/JyzFU0+npA5aAaqtn2n91kq+SwUwwYTkgpnZWWc7zAcDzRhqrU9oCtw1pKJkOJvgjl2Lm+xgGuom2jxejyghIiznFm/C0W64MU+i0d0OQAmxgXb3gpXU1tUnEOIBzMnes/rGX+UHJGZLaDWv+YXZzWPI=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Tue, 3 Jun
 2025 03:04:49 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.8769.035; Tue, 3 Jun 2025
 03:04:49 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH V2] drm/amdkfd: add late initialization support for amdkfd
 device
Thread-Topic: [PATCH V2] drm/amdkfd: add late initialization support for
 amdkfd device
Thread-Index: AQHb0G9q76cVphZh4UiNrtPsGsm1JLPrQryAgAWDdaA=
Date: Tue, 3 Jun 2025 03:04:48 +0000
Message-ID: <DM4PR12MB51524E91A24CD22D5B9F63ABE36DA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250529075802.2932430-1-Jesse.Zhang@amd.com>
 <CY8PR12MB74350320629D6E41F5519A8E8561A@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB74350320629D6E41F5519A8E8561A@CY8PR12MB7435.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=9e7c0ba3-aba9-4bf0-868b-6f983cd01eab;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-30T14:27:35Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|LV3PR12MB9257:EE_
x-ms-office365-filtering-correlation-id: 3b0d1727-8903-4f8e-30c8-08dda24b66d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8FGKtwG1jMy1rokCRo+1naYnH9yspPHT7SbMqt1I47st6t4U4vA1x7FDMHl4?=
 =?us-ascii?Q?IZH2ky8v6qFXoaRxhuZ1P0VIQCwZIAoYsLDw9GvcqYFKBwbsU1iLAdJ1/9mb?=
 =?us-ascii?Q?Rh2FQug4WivvcXHOL/7ip8bzzoqfvVH7KK9cF41BCHdZBEhlhhdFvXXvJ4EV?=
 =?us-ascii?Q?N9Bi2KyGJPOsqS3YvkqGWyI+larR3NOwIqO3ZPQx+nw/jA1YM+JoJg53z2xj?=
 =?us-ascii?Q?Sv21axsH1lQlDuzNAddlKMtCxT6crxCg2Q1juvINfA0OvYNOSHCnpAX5ymc/?=
 =?us-ascii?Q?S1KHUDuFZ9dvcjB1E72ubnUd2m1axDZHgs0CEpUFa8mcqhFGBSWw2svhzmiI?=
 =?us-ascii?Q?lUnuTLnewNQqogJT/kPbZAiwpf/phyy9HHBXxQaAaPT7dTw8FMSW3cRvXNkn?=
 =?us-ascii?Q?tqiywekCuTWy9csZ2vPIWuEAbwRePmWXzKJNqi6NG/7PqqM3Fp502UCn2cGO?=
 =?us-ascii?Q?62IMOHTvHzisMOmp4e8UcxTnQSQQ4TTuWJV0TqibIr58c2SE6pcV+bdofzaS?=
 =?us-ascii?Q?jnCjIVMpmWQmXCtfMBNK1eTbHdKupbc2RwZs7LPWPHzEwVoqWoKPbdgz9wpJ?=
 =?us-ascii?Q?zOStgqtzIfs9Pcj7/SiWSwn0AoxLQHJgh52CGhC6S+KqN8b53ahUm8yEE2uK?=
 =?us-ascii?Q?i8L5GdcyJc8QbFQ25R8bBpJHsQbWLqpeF8QNiHbpoS4cbvyEK9IPK0sjE0ix?=
 =?us-ascii?Q?0uKM1Ur7WpTmvSxAatSHNLFZKzdvtIhZC9bnm94p5iG35ABvdTMR81h5wqAC?=
 =?us-ascii?Q?8mhFlzv+C8Uge97DxDXTffVmH7gBqtEFw8ku370pDMpVH85la9lNZjNsp4RS?=
 =?us-ascii?Q?vUPwZuvSaH7PU2GDX8jZ4ge1wKeLx1GHMN1L6h4PhVW6RKTYxCiUA3G+wGTa?=
 =?us-ascii?Q?DOsNUX0wISOc/kOhci15jHGM0NaHIsI2JtZHK+E3bVoKEiOWyBIZRXThJhq8?=
 =?us-ascii?Q?EHaYtAKtP3V1M1Le+j2gyxDM3JiZGM/zij+cf66hhvUQaK8AvYqXl5r16T6K?=
 =?us-ascii?Q?yMKtjBcim5OVrz4SMzmYkwO0SyTPzyiZyxQ3lFl5tYNrHIecbQcS7Wg6sxht?=
 =?us-ascii?Q?m36H6jXQVW/ab24Bete3YzXm0sP23JGXHs1vTp4sLX6aGeOT5uPPKea/nBRe?=
 =?us-ascii?Q?05AWwrA879LrPby4ESj2yVJ7Jw+zzkIHoImUPREEXXkbFegcYF3HR3VOBIaf?=
 =?us-ascii?Q?VNg/0p+uzAzmEjNhz5wovLgYBeIunK2+x8Yn7kKmmg/puLtnGF4yvTdjEsu9?=
 =?us-ascii?Q?TYkvT7OCT6ocnSQdJqf+qfTL+va2xbABmtpxRjQs6VTTFZ9krFX7jbTsoKPN?=
 =?us-ascii?Q?qsDPPATfFGWhI+OVZPiEjBN6W5SG89VU4vFyX/KaSWqOkMPFLWRXZsPUupyA?=
 =?us-ascii?Q?y1QdouGVsgmaK23lI4kvNdBVYjUfnXmNMxdKZwU+JOndoBClZ+ZgTWi2Gzni?=
 =?us-ascii?Q?eX6X1EvT6CoM2PXdSLQIN+1auYXfY0NLCX3sQInvuMA41RPjAkUO1/JyLrdE?=
 =?us-ascii?Q?Y1ubEwyESCDovic=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cYIlWoU9VcFlogiLGfkSEGjZDypH5PvZXvkcRzIMRgIIWKp13+JvTJJ2Bigq?=
 =?us-ascii?Q?VWSJqTPofa3OLQWhCN+dRKpXL8vI+umYkUkdCsh15SolxTRIOA4UP8ydcJpP?=
 =?us-ascii?Q?at/E+Vz7w+OoMyAGrNSyIrHXG0gH/d8+ifnIZOywvNIfa3PnthNpe4yNUeCv?=
 =?us-ascii?Q?OXOjX9fnKlgyBiy39P7gICKpc5HKxqUsEk0kyXwit70iB8kbT22Bb/JIXyIP?=
 =?us-ascii?Q?TtnEUzqkNd7SL48B4H9TN92p2akkAvkASRc+svGKfctxEerG5kt1/w7eC4UI?=
 =?us-ascii?Q?OhP60pWLfE2B3z+68JxbhzCuHomlUqCGGRu6hqHUbMl2Y0tnUhyCakKvvBrM?=
 =?us-ascii?Q?hYf75aQNFv1ES7YIHZ8U7vu+Vg5IjauBZww5VcTL19BQY1Gm2+b8IpmINf/9?=
 =?us-ascii?Q?BGuixd9mF1dw7QBKusalSlfIJMy3Sl+vo/ZxFokocVoPJWN1eyXXrpi0wX7F?=
 =?us-ascii?Q?FQwlU6YHHb8By6168EOhFKypijilEN80DEEcyIJpgLJ/pm2i1N1uM9MDxO+7?=
 =?us-ascii?Q?eArJ6m4o+Uha1rjtOerDqhN49ImNX7L0p0n75veFyL9UHb6tIf1JEGHEW4IW?=
 =?us-ascii?Q?DR3l48N1+Kiwmop1Fih1dYZneoQ+6GlpEe7GOWLO3Kv15YvV86LulcjXh1hU?=
 =?us-ascii?Q?Q1J1vseHz4TjomWSfhDxxCMrzgYmOLkgIZD6V7HGFeBCvo9nn9KSnpfroTpb?=
 =?us-ascii?Q?/spd86+0mQyTsXYCaB5ygo1ZSIkXttLgfwx98tyjIbx7R9KhFhycWIYwXCon?=
 =?us-ascii?Q?T0InnJErj4jodAHsG1gDUGBEz4YkGNOInp/5b5zudDj9XPygBg4MnFmUdkK4?=
 =?us-ascii?Q?0lLtcVdVw3ZVPX4WM8FN4LvYWkwInA0OgtrKXGQ0I6m40DNKMxkN+PnQpkuw?=
 =?us-ascii?Q?MTdPglJ+Bg3rlZK3FwOasM2sCss2ijWESH93Uor50OmZPcRJMzqBong68GJX?=
 =?us-ascii?Q?0v0MQ58AllEbJpEhBf6s4FSgn/islfQGkHf9lYSuZnpwJUZGFYc55aaJjeoh?=
 =?us-ascii?Q?M5fMjgPTIjufq/OCLKdOHBfo3vFx/zIEtE+WXs9gd7CvuyxgG9nj6QJPMozA?=
 =?us-ascii?Q?Ytv9Uf5TpZ7KlstVrRseyhXxD+H4M+0somNU63+Ym1TlCR7FrCEtpwTOENXD?=
 =?us-ascii?Q?JI53QCkJdMN2ATN+Ck4Gb/EE04MLE6rG2C5tpFQLJcA2hRFxutTWxjvogqam?=
 =?us-ascii?Q?IiebM2AI9pKc+CI9zzgt5pdexrooWqg3BZWuB1M7thbBNv9sX8fJu3itsG0F?=
 =?us-ascii?Q?kTNOPQFoqketOt5csqH5c3yib6o7R0Rjd355TDJwlZEgonqI/Sgi8tATOIaK?=
 =?us-ascii?Q?LLbBCD77xGWTwVkSYMjxdaz4cmMtC5Pi6EKSGJaFlEuxsqhnUR+UntVTOFwH?=
 =?us-ascii?Q?DOvCrvPs757yb0l5O5Tdf1XhcpA1cJq1fryy6Lsd88nRCf6suCWSWtnocl0L?=
 =?us-ascii?Q?PHwKfzRrxOIPkiIFQ48SffOnfrADpJ1J/xfYpnspjAszHJn3iZuzYfv+8zj8?=
 =?us-ascii?Q?IA/AiqTGIOOOY7R3PiGig+Eh6SFOdDn3/KNq5o/0QZhGSSFazEVaLKA+rKjL?=
 =?us-ascii?Q?imZP39Q9mfCJqFAhs2k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0d1727-8903-4f8e-30c8-08dda24b66d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 03:04:48.7772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nF+sy8ZYi4x5NDnVJEBr3m/T57XBa5k1uGH5Q4HltsleQv+d/5XYQD0HLpazWjdubxiAM9DiYg1ycJQ6kq1b8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257
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

Hi Jon
1. Is it possible to just push KFD device initialization later during the K=
GD initialization?


The challenge is that SDMA reset capabilities depend on SMU initialization,=
 which happens late in the IP init sequence.
Specifically, in sdma_v4_4_2.c, we can't directly access the SMU version ea=
rly.
We rely on smu_v13_0_6_reset_sdma_is_supported() to query SMU for SDMA rese=
t support,
but this requires SMU to be fully initialized first. Hence, the need for a =
late-init phase.

2. From a brief look, it doesn't seem like the KFD would operate (let alone=
 the KMS driver not surviving) if late IP initialization failed anyway.
Chunking KFD topology settings into separate phases seems a bit awkward.

If late_init fails at amdgpu device init, it should has a fatal error . The=
 driver will unload kms
kfd should exit as well.
how about kfd get the reset flag at node show show ? will update the patch.

Regards
Jesse

-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: Friday, May 30, 2025 10:48 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: RE: [PATCH V2] drm/amdkfd: add late initialization support for amd=
kfd device

[Public]

Is it possible to just push KFD device initialization later during the KGD =
initialization?
From a brief look, it doesn't seem like the KFD would operate (let alone th=
e KMS driver not surviving) if late IP initialization failed anyway.
Chunking KFD topology settings into separate phases seems a bit awkward.

Jon

> -----Original Message-----
> From: Jesse.Zhang <Jesse.Zhang@amd.com>
> Sent: Thursday, May 29, 2025 3:58 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH V2] drm/amdkfd: add late initialization support for
> amdkfd device
>
> Add support for late initialization of KFD device capabilities that
> depend on information only available after IP blocks are fully initialize=
d.
> This is particularly needed for SDMA queue reset capabilities which
> require sdma.supported_reset to be populated during AMDGPU IP late init.
>
> Key changes:
> 1. Added amdgpu_amdkfd_device_late_init() interface 2. Implemented
> kgd2kfd_device_late_init() in KFD 3. Added
> kfd_topology_update_capabilities() to update node properties 4.
> Integrated into amdgpu_device_ip_late_init() sequence
>
> v2: remove the include "kfd_priv.h"
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 +++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  7 +++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c    |  6 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 22
> ++++++++++++++++++++++
>  6 files changed, 47 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 4cec3a873995..d80745f60873 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -232,6 +232,11 @@ void amdgpu_amdkfd_device_init(struct
> amdgpu_device
> *adev)
>       }
>  }
>
> +int amdgpu_amdkfd_device_late_init(struct amdgpu_device *adev) {
> +     return kgd2kfd_device_late_init(adev->kfd.dev);
> +}
> +
>  void amdgpu_amdkfd_device_fini_sw(struct amdgpu_device *adev)  {
>       if (adev->kfd.dev) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index b6ca41859b53..6c8bbcc7f177 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -160,6 +160,7 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device
> *adev,
>                       const void *ih_ring_entry);  void
> amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);  void
> amdgpu_amdkfd_device_init(struct amdgpu_device *adev);
> +int amdgpu_amdkfd_device_late_init(struct amdgpu_device *adev);
>  void amdgpu_amdkfd_device_fini_sw(struct amdgpu_device *adev);  int
> amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev);  void
> amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev); @@ -410,6 +411,7
> @@ void kgd2kfd_exit(void);  struct kfd_dev *kgd2kfd_probe(struct
> amdgpu_device *adev, bool vf);  bool kgd2kfd_device_init(struct
> kfd_dev *kfd,
>                        const struct kgd2kfd_shared_resources
> *gpu_resources);
> +int kgd2kfd_device_late_init(struct kfd_dev *kfd);
>  void kgd2kfd_device_exit(struct kfd_dev *kfd);  void
> kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);  int
> kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm); @@ -433,6 +435,11 @@
> static inline int kgd2kfd_init(void)
>       return -ENOENT;
>  }
>
> +static inline int kgd2kfd_device_late_init(struct kfd_dev *kfd) {
> +     return -ENOENT;
> +}
> +
>  static inline void kgd2kfd_exit(void)  {  } diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d9d8cd063829..b7c0281cb6ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3395,6 +3395,12 @@ static int amdgpu_device_ip_late_init(struct
> amdgpu_device *adev)
>               return r;
>       }
>
> +     amdgpu_amdkfd_device_late_init(adev);
> +     if (r) {
> +             DRM_ERROR("amdkfd late init failed %d", r);
> +             return r;
> +     }
> +
>       if (!amdgpu_reset_in_recovery(adev))
>               amdgpu_ras_set_error_query_ready(adev, true);
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index b9c82be6ce13..3aece03ad092 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -947,6 +947,12 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>       return kfd->init_complete;
>  }
>
> +int kgd2kfd_device_late_init(struct kfd_dev *kfd) {
> +     kfd_topology_update_capabilities(kfd);
> +     return 0;
> +}
> +
>  void kgd2kfd_device_exit(struct kfd_dev *kfd)  {
>       if (kfd->init_complete) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d221c58dccc3..1eee4d625ba2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1134,6 +1134,7 @@ int kfd_topology_init(void);  void
> kfd_topology_shutdown(void);  int kfd_topology_add_device(struct
> kfd_node *gpu);  int kfd_topology_remove_device(struct kfd_node *gpu);
> +void kfd_topology_update_capabilities(struct kfd_dev *kfd);
>  struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
>                                               uint32_t
> proximity_domain);  struct kfd_topology_device
> *kfd_topology_device_by_proximity_domain_no_lock(
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 09011d78f700..052215faff76 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -2026,6 +2026,28 @@ static void
> kfd_topology_set_capabilities(struct
> kfd_topology_device *dev)
>       kfd_topology_set_dbg_firmware_support(dev);
>  }
>
> +void kfd_topology_update_capabilities(struct kfd_dev *kfd) {
> +     struct amdgpu_device *adev =3D kfd->adev;
> +     struct kfd_topology_device *kdev;
> +     struct amdgpu_device *node_adev;
> +
> +     list_for_each_entry(kdev, &topology_device_list, list) {
> +
> +             if (!kdev->gpu || !kdev->gpu->adev)
> +                     continue;
> +
> +             /* Compare the underlying adev pointers, not the
> + top-level structs
> directly */
> +             if (kdev->gpu->adev !=3D adev)
> +                     continue;
> +
> +             node_adev =3D kdev->gpu->adev;
> +             if (KFD_GC_VERSION(kdev->gpu) < IP_VERSION(10, 0, 0) &&
> +                     (node_adev->sdma.supported_reset &
> AMDGPU_RESET_TYPE_PER_QUEUE))
> +                     kdev->node_props.capability2 |=3D
> HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
> +     }
> +}
> +
>  int kfd_topology_add_device(struct kfd_node *gpu)  {
>       uint32_t gpu_id;
> --
> 2.49.0


