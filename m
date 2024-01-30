Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDEAC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 12:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A04D113048;
	Tue, 30 Jan 2024 12:13:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA9EF113048
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 12:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGbYiDHLKxmwVLN0Pdhap8no6IVXqWROZn1Cj4plUdbLCvuQHAHu4eEI39gajlVnl0VfhBd5z6YTAjK0wPTucvdjLq+2eTxtVx5p5qctbTwJ5UcE8O+fznnaIJzyWWmunN6wkznH5WrV+UG1Og1A7PLbH9U91xqvn+CuMIgQSycU/MQaySXt5zan/ThL/8FbbNQVcbcVRc85KnIk3F5OcFaSx9hjt+GoAEzbb0z2Knkk7u0yU2ncgsdGFNWqVyeDw4wO4XVZ1NclLqr0/zf+6xzLP2Y9XAqRfwOCOXvADN7nccjLAHfQ6VppiZgvmh5QT2a0gjdsl9HV/BtCCoyfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPJdnODRLDIEDDrTgg09h8Jpc1MF1BhRhBSiT5Hsqi8=;
 b=R4ALk4T/B5vYj+odyYPcdqv6BBvnzn3NcL3iyiQ+ZZ8JjgVgSHw6W6yKk+WS4rXSJKQFaDpzp/8ukNxzk1S5MYvGR4q6scMoQopkbsxXAY0di0PxOt3We2c2Js6O2NFlHQFpbxM3vJeFkgjtANJnEKeuBHecv0ZvV6XXBOU+LgpRJmMH0k4a7xwaX0fxSfqFcoiEsy1kHIYVvjXIUeGz1EgkXdKfYM2COvDhuROr9TZHSr3rX13JoQ2usn4IPi8EDxIcmTldPY9vuINml9ZmP52wVi4cJlzD2N8RjEmnPKlk9nnKWY/NjvAPfQiy26fktMqGVje+96txmJcFZLMm7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPJdnODRLDIEDDrTgg09h8Jpc1MF1BhRhBSiT5Hsqi8=;
 b=lJproCPPYfH4N0YzX6Fa+pkXkfuNF7C3MEWaRR+dlEGzyseGzPqcdRN/j+jAXgAJK01l/UmrBJxeTl6i67i04hmf8Flbw28qksvm7wh1ZhmfhDb9f6/vjSaSKxkkWZvUnfBPN4edhdJPuYIzYYaywymbgzmE+IVQlXVLD+TyO4w=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 12:13:43 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 12:13:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Need to resume ras during gpu reset for gfx
 v9_4_3 sriov
Thread-Topic: [PATCH] drm/amdgpu: Need to resume ras during gpu reset for gfx
 v9_4_3 sriov
Thread-Index: AQHaU3VhBkNxlgn6+0ayhhDUxrMRFbDyRITQ
Date: Tue, 30 Jan 2024 12:13:43 +0000
Message-ID: <BN9PR12MB525772DDAC1C4C8195A9DE73FC7D2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240130120958.3007422-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240130120958.3007422-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0f9b54a5-b612-46ae-ba04-3f6767338e10;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-30T12:13:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ1PR12MB6050:EE_
x-ms-office365-filtering-correlation-id: c18b6df7-58eb-4d0f-b032-08dc218ce6f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ON32rDkNRxxeB/NGmXSKGxQuo3qXCHeL/S4itBCyd4mxaw4xch/pnq/QlU9pV6nidmCthVQRyYB/nPw8oNDxYSLvG3MdUVWQ7vbX7uO9OfqkWgzMEviSWaPJZLFAJxjOdg6ud8IhVdO7zHjYZWz45KgLLhBvDu5N/kH+URXtQPelDLatQFq6pIblpgkDqbmmRP2kj7L3Scsrm1ER0lsO88/Ytf55Ms+crfMZ/aMcmm3epU9RjJGWYlTapyE00txbTCH9So7RJjcYzrxhkvcm7l3rOSVCGpi/t6w7l1VrNPyO8rXq++8ia0lfsbsUMaDRgTXAbbmTVAqGcUymBQ3bZXy9Heqd8IdbocZf+aMPN/pZ/BGPdmJ1K15knc+Hq8/LKA/NhatdmJamHG/FMG+/w7YtlSyPiXKXjasl8AVrXjWs0S5z0G/tShNpnw+dzPCsXjBIBDLT2CoxPIEgGHRepebjPTNXC0lo2fCBkiH9dK+KNTPzKcIFBUaxk0uyp6Wsmo5LEM+HTF+oO2MTrA+RcuTheMJEJdV5pr0h1c02eWIfgvWb2tPSQhgySyyX+qVEuME9FLtMr07PytbnsLlOeTB6vQHUTFqf0juawUmAB8VHFFN6mW1jut9IFTApXCy9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(83380400001)(110136005)(86362001)(33656002)(41300700001)(38070700009)(122000001)(38100700002)(26005)(9686003)(7696005)(6506007)(2906002)(478600001)(66446008)(316002)(66946007)(76116006)(71200400001)(53546011)(66476007)(64756008)(54906003)(66556008)(8936002)(8676002)(5660300002)(52536014)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8qf9SzJ5cLLFBYW8qptIEtqGzdqiuu5mP4Le10EtGYoJKus1IwHGlataUxJL?=
 =?us-ascii?Q?eKcXzMQ5DJ6NWbHRGgo3gYpTgaOUcoy1UAZgUH7QiPKX9mWIu6XZbBH67IHN?=
 =?us-ascii?Q?COzSC46Q67v4eOJIlKT0xzDPtASN7g+7qnIgKZnEsci/xDGvXThQdsQ94oTl?=
 =?us-ascii?Q?7raAEpmDY0YQhPbY1hymGBvPvbiNT1txKCGTM32peBCmXPKMRjUchxrPE0pF?=
 =?us-ascii?Q?Qm5cegi0HHwMKY6iIktf/XoqcjaViiRdipu06kRTB8flUVBbaaWS2fE+NTQe?=
 =?us-ascii?Q?oWY5Rk1GlJyQLE7wO3TVWWwfd7ysFoem+P0VQu/E35yF1SVvBfeaYqLNGlhW?=
 =?us-ascii?Q?4RuqYX5wch3v7PlQotD/n39oORO3aKEUunDcovXghe0XfXq99/ldVsmeR25B?=
 =?us-ascii?Q?cvN7ZQreUK0TEj0uDaV6e7+aZlnZ/6+baZcNgPtUVBLR/l1YP/05FMozfQWA?=
 =?us-ascii?Q?jsHAzYB+ezHT5c1oCaRUnSpD2F0bW6pmcIw0BLan9phOkgosmylHQT7h7pwU?=
 =?us-ascii?Q?uCYQ6Ey1b6HI+HyvO6yM3blUWr08S4I3KxNbdjOibKvtlaWby/C378LW9+nE?=
 =?us-ascii?Q?MGaSRzM30WsjK+1n9KPqxFp7sKUI/zsKc3Fi2HKs4Y6yCNtgFsepc3T8Z0Wp?=
 =?us-ascii?Q?ZL/WV8XQxtEwly/rKgclOSI+4iB4dD9kV+Mgzi5EVBZZ/JIvfTBZlhPeCWJW?=
 =?us-ascii?Q?S+Uxwg+yWFNgDIzZODijou9a07iw0tbwGwBHfPwnxDRYjXY55n9nIQ+HV2Td?=
 =?us-ascii?Q?vIRxhLijGvrXQL7zOR+kCUSBM/FGef3lRabASkQ0Zq2xIQ47sZEMeExzsx7v?=
 =?us-ascii?Q?rJXZ3t36dQsMva5uRZdII9ZNGakqO3jlDm9EIx0zBF231cfl2TWjTY2Zwm1/?=
 =?us-ascii?Q?Y49PjvGkWJSXstbZR5Ljm1l/+bdG373gbWWHwIueNOBboWysnuieWMpZrT6W?=
 =?us-ascii?Q?PzppzzJiVoLHV3aoRXOdnfDLO0MsdjCR0YEKuoJbchv9oyC3O/6RzdBz4KFL?=
 =?us-ascii?Q?9urX1mISaLmEM5zCgzOHLRrEtVxAUXdR3t8LBj/7T2sff+QcG+ajEGDPIC/S?=
 =?us-ascii?Q?CuZpDlGQwhWqBW6htmBaAa59XaX3qzlVbsGA/HwIdEJWLGBK4teNTfUKjoZl?=
 =?us-ascii?Q?K8RtpaZNKObvbhO/WNTBmNDMB5iWW0hj42m2/xM2oeuzt5AzBc4Hh9w7WaYT?=
 =?us-ascii?Q?Ke2yZBpbYDKcOvWdkU3DFyK9rzkXwFRNSnbb/wfaC+l+eFG0K60CY05QuD8v?=
 =?us-ascii?Q?VH4lI3KD6x0siLB1yGLTbjvFNHZlqg9Hq4RCq4nPBXGqB8PTeslpsighi6sK?=
 =?us-ascii?Q?Gs0mbcsZ0OVxVQr4AyD8B5OB6HJw1kL+D9z20lGZiIIeuTeegdmwb8NJU72d?=
 =?us-ascii?Q?M8TTZ5knC199ILFCTA/rTDVc+u+CxnMq7rAmV0YxDml6h6/kUBlNplsjiVSU?=
 =?us-ascii?Q?Z09CjFPBX3axm4kVPRKdBaC58zAH0GVjmqpsJwCsoDOrzig5p5+U3PwFK13h?=
 =?us-ascii?Q?v+/lnZzaix3gYUYtUbfdr4GoYmbsZsBjPojeU6akOYXpJ7nhRAZ2WeIYN8x9?=
 =?us-ascii?Q?zoXAccENfxDy0I0YB28=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18b6df7-58eb-4d0f-b032-08dc218ce6f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 12:13:43.3448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qz6A0Gzl/7Xg2LW/oeVt9ATmg1XN7Wp6xIVnDEIzuCCId2fph73TlqFd1om7zSST3zl0DnTqV+/iEuMxEEd3dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YiPeng C=
hai
Sent: Tuesday, January 30, 2024 20:10
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.c=
om>; Chai, Thomas <YiPeng.Chai@amd.com>; Yang, Stanley <Stanley.Yang@amd.co=
m>; Chai, Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Need to resume ras during gpu reset for gfx v9=
_4_3 sriov

Need to resume ras during gpu reset for
gfx v9_4_3 sriov

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index afc0b4eb7f8e..3c393d7d9672 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5724,6 +5724,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
                /* Aldebaran and gfx_11_0_3 support ras in SRIOV, so need r=
esume ras during reset */
                if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
                            IP_VERSION(9, 4, 2) ||
+                   amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9=
, 4, 3) ||
                    amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(1=
1, 0, 3))
                        amdgpu_ras_resume(adev);
        } else {
--
2.34.1

