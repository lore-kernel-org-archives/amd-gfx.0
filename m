Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B717C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Jan 2022 14:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AED6610E3AE;
	Sat, 15 Jan 2022 14:16:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 938FE10E3AE
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Jan 2022 14:16:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFCCKklQTRPxYwZ81sP1a3XC4PBYYEqNh5O9LH3JP3cLwqW6KfQp/NicFVPykgfl/l37LkqPvEUQCCdV53kpfJkSGKyFwadC4Vll5iax4yBO28LxUfj4Zsi0JHI29gc89okAA8LABXEorjjmiHc+gO1JELkIAUrpIOvi6v1gE1uUMoa4WqVN1rsLuGuMy812S/eyLsNkY5J/bbOr+arQGc9TGSjxfNggjS3+M6r/bR6fi39pwM1sUz1SAjLW9fI+gCvLuH5KILEBa+brOZXYqSCRPzf2GKXD7qePcs0IHavaa1UkNuGH1Upny4N5atwOk+cAo5KsE9CWA1j2XyEi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c976eVCeVqo0UwOgYSRVWZ0+qLqLX3M8lD3xNqyuG9Y=;
 b=D72oQkytPiTXl0Gfb8xVcv5r4Rj3H2kNEGMrfg4KA7mAhEu5t/81Sui6IOKqInuIQylnCoAhvPdN1usUuGZ1bqieToNaj7HuX7gjfR5UNFZi1hVfpwV53rVHFFPUSNYvMKbfjb8lqhLEXO+4coxDksMHS6v5TEiT2ZW0K6zJD2ZPAZTws3Ub30RzySJbVwi65QQJHOQyNRxFyNyD3aOKpNR+NuCi97ETlJ9BV8pS89qDDImU4CEFQ+F+AIhwLgrsanEdhhDzNl9kOg2jLBjC37UXqx0ayFn+Da8qR1ExJpfOStQQ+Fa1f0EjUMUdI0ak7pTpIME5tw9GX6zF9dzkiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c976eVCeVqo0UwOgYSRVWZ0+qLqLX3M8lD3xNqyuG9Y=;
 b=LUR/55T+BSX1q+SzoMcqzDGl/HGu9e3g9LpByzJvjKzaH4e7YEpkw828rSbnL+P67A0aOQ72GxEMB/RZRwg/m23N0dmCJw1vx28svkdLrAWiZuq5iaKP9SkLGsKKSqEXqIq43i8K7CgNfmR9QdQX1SMKsARH4b00qbjOQ+T8TfA=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BN6PR1201MB0019.namprd12.prod.outlook.com (2603:10b6:405:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Sat, 15 Jan
 2022 14:16:01 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672%4]) with mapi id 15.20.4888.013; Sat, 15 Jan 2022
 14:16:00 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: drop flags check for CHIP_IP_DISCOVERY
Thread-Topic: [PATCH] drm/amdgpu: drop flags check for CHIP_IP_DISCOVERY
Thread-Index: AQHYCVfbthlTp3cHS02yvOR7U8jT/6xkIg4A
Date: Sat, 15 Jan 2022 14:16:00 +0000
Message-ID: <DM5PR12MB246943662550ED245DF4B468F1559@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220114150240.1008818-1-alexander.deucher@amd.com>
In-Reply-To: <20220114150240.1008818-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afa096d9-d38a-4c1a-ca1a-08d9d8318ec3
x-ms-traffictypediagnostic: BN6PR1201MB0019:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB0019FEDF7456F251E13CA1C9F1559@BN6PR1201MB0019.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rdl36wHvQrkQd5/TI5ACwIqM53ehyEgLDab1qfaHg3VgViHw80LupMUB+WShimTJQD1rKuMrncQpIqUyR1KwknVvG8+QPIB09qrdAnYZtyBlXDdlbJNeE/Z5d5Qw0exx2a/VNpIJaS8WQrMwBJ/6JrtZZOQ9LQC8dGS0HdC5uh9FXZWasTJQAYMd9Gg0bsAf9unXAVSLc65qaqFv/xUKaGKaCnyGHQ/TTqZQ6ZBuTvbKYucf0NpLnEUIlqi2WHJNz/zaCkuCmjCkdulr1ZjPjn3TXTWlIF8EhyoVY3bqaGKvx5Q5o1YSuYcA6veGEEZ0QUpGtXlA6nl3syrUJwFjTZNtGWIfeNS6xOKztJK4OXbtqnHW5sTzLDeCnKA+2PxfYyW8mKHyn9ursbV3XnFrf8UzeJnjdLufsa7FDq/XxlH6hBRxw5vFLK+epIh+ojP/lpo862h0KgHVzCLGDb1BX54G5vkN9jJpzPvUfqEkLAhmvjB8zVzlew7cp3Oy+Z3gaSLtsBt1msNjIFi1Bl0Yx2bUiZOdgtE3TEqoxAzVp/560kyVtoFQMOwUHr+SNbJPuszhYUcEKlHlKRQP0hQRSgFl1Bza4KcqrIP8phVmL9CrwH/o8Akgz36SFL6uaNL98PC/nDUr1quqnlYyLIQRKWdhP4P7ZRdcAvoR93pMS5y5xi5CdYOmWE/VqKHvVepKsOaZezUqoMUr5/Rj17oNgQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(38070700005)(110136005)(122000001)(316002)(9686003)(7696005)(38100700002)(52536014)(4326008)(33656002)(508600001)(186003)(83380400001)(76116006)(55016003)(8936002)(86362001)(64756008)(26005)(66556008)(66476007)(66446008)(66946007)(6506007)(53546011)(8676002)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qZmqylzhIcyvsiyqwRX9oKemmJBGLrgrVElwdnfYK9SoNd3G/Sj4kBdQ4Xg+?=
 =?us-ascii?Q?AFItAKLOARAlP3EvC55t0IuVVR6vPvcH/r5a5hUQQC6V0WflSp1uSnA2JOfA?=
 =?us-ascii?Q?5bshyWUe6oLc2w8K512I8vySIM8VOK3E8rGuljnUEhhX7yAmaYd7nGVXxsRi?=
 =?us-ascii?Q?rwypb+75aQadmDjWs3+YRhekysOnC1mIREaMn0qlT8Pt/cFvkrKNVAkQKwLx?=
 =?us-ascii?Q?jaI84Kg/dCrELVH/L0w0SIURF4t2mGOsr/Fm5VFnA6Mgn8fF5S8X6PQe+iX9?=
 =?us-ascii?Q?gKmEf57Q2DLnUh5ZgU8lkpdLwQTPQAOfWdda01LjIDh3+uqWIS1pJ1TG++Kl?=
 =?us-ascii?Q?KtH/oKM1MfkRidiOBeEO22tCauNojxF4HbLINEDWor6lWbVxk7l+K0KbhkHS?=
 =?us-ascii?Q?8yRpKRHJTzDtVth+6xyujUkkOhys1SZmokLvMmswqdhndB+xCdEC2QTw/gTA?=
 =?us-ascii?Q?uDhXOXdyZfy3CsIP9YFcP9VJh3y2/XDS48DH4HiIjXAlqKbI6cLsOiRuujEO?=
 =?us-ascii?Q?XtbWe26Us04QYnFdqiS8Vur0UoH0KgopKamqadPzq8pStohl2Gno/UH/iNIf?=
 =?us-ascii?Q?/xAcvsF/xn7ez+7/VFN1W60iQhaC2ITrG/W/ANaK0lmapO+3JXy0CDBEgIiE?=
 =?us-ascii?Q?hiCfC6NcF5MuYUztQk7/cl5vZUvrnCzCKTsZc2mh6FT3/R10kcpLJAfFJEbS?=
 =?us-ascii?Q?c1nn7TK6JViphrN56WyT3QdaIWjPov0aOqoImaj+zsBsN3gWuQ3j5gLboGet?=
 =?us-ascii?Q?l1lQHS0k5ro8wy+iPdOf5NWKHWOZjUPM3HsGFwEnhXm+HPBGn4EkcbhpAWzD?=
 =?us-ascii?Q?SXS0/uFCECq/qer0xz5JQfspkl5Na9mgqxHhHyMAs+VLLrIbEQ9vdklL2pxC?=
 =?us-ascii?Q?T/EeNs0XhKTSQ40cqPDgRw8CU+NM6BLgfwT6VVKNWKAZOPCnS4ChAG7kEDES?=
 =?us-ascii?Q?EztSngJj9DLjcYGZJP1heMQ03WWFuWCL/nN0DM8EczSCzSGw9wL+aWJCx306?=
 =?us-ascii?Q?hrDWFP4J79y4PYsfJG88A7FBhPPGcdgyEDKX1Ld3XisSYtyS4GTAekdZHTUF?=
 =?us-ascii?Q?/It5tKGMpjdpMedkkkOwWvAeqhCBNMjGL0xm7jIg03RhaGOhIcNNUYw35gQN?=
 =?us-ascii?Q?G+zA6SoCAHms+bHNvhADLLTAOYXwsCwp35tRunjxbP6/Ig96wqeD4r2Dir2K?=
 =?us-ascii?Q?IbMaCTybxf0+iHe9YaVV5eBeemH5z2Tqdipq5w2fejVf6Q7ox87yi6wZ5dY9?=
 =?us-ascii?Q?b8G8pFMJYzSZyJVUKuzNCbCcp5xaP9/tmpFR3WFPJvpHFYNxMOPFousTNWD9?=
 =?us-ascii?Q?GKEyUDbJC64Lr7/e8jU4doG6x4yIDWr93CLH9ylrBevlzi1PgiklDARRD75+?=
 =?us-ascii?Q?nByvOFndmUViztrN6BehZLaTRDJsRYwM43Szv1dF0lF22dfz00hoopV7mhxl?=
 =?us-ascii?Q?RFPxf4SOFi8XyyY5lT2wt8j2W6qrBVBiYcQvPxJJ+4z59vWvETkqUOjCJMub?=
 =?us-ascii?Q?tkEioE0A2qA82E5bKEo2YsspH2n1H6MVjzGUbX7P+M7SnHOJGbP7Poxm7Mok?=
 =?us-ascii?Q?mU1ZO7KPDcfCtLU3hE3hVbSMgicNWyzvFxoKrO7a8GRTQwxG+8wouhX5p0Gx?=
 =?us-ascii?Q?GxocSiQxYPeRG401M8thioY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa096d9-d38a-4c1a-ca1a-08d9d8318ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2022 14:16:00.8110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gTuxygrRr7exs4MxL/khyo7N3c8FtOnrr8dP8tQT+W3AbA5PQTmedU8UNinwAlNpuTOm4cv6s45K8DzUC7MTFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0019
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>


Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, January 14, 2022 11:03 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: drop flags check for CHIP_IP_DISCOVERY

Support for IP based discovery is in place now so this check is no longer r=
equired.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 224d073022ac..25e3ed351fd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1903,11 +1903,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			return -ENODEV;
 	}
=20
-	if (flags =3D=3D CHIP_IP_DISCOVERY) {
-		DRM_INFO("Unsupported asic.  Remove me when IP discovery init is in plac=
e.\n");
-		return -ENODEV;
-	}
-
 	if (amdgpu_virtual_display ||
 	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
 		supports_atomic =3D true;
--
2.34.1

