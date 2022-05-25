Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAE8C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 03:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF35C1120FB;
	Wed, 25 May 2022 03:32:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 771531120FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 03:32:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgyLcDAjBeo9ARxSM/g3nEcsn1523J/IlZPdMI+drWnfySI/clqX7aHZGHSYhPotfzbakIixe9p1wGZSUh6LnSZKRrERwvVn1usL4kmxRRlKRBX8P9+KN8ravtr6LweNl9AFkKIM98OuYX40eeIUYvj+Ha8y5o0OC8WbYnjECZ7O4f2tIYGP7dfUsF4Dq2TEVdAlwH9cnJHzhx4FmrUVo7HiC5OzaE7vz6Corw7yy8Od34KANGUm27Sva15vS+z/vNKJgMyEoG3Bm1b/ZZS/Nxc8Oue5d/ff/FNT6X1qj+163BQ4X6+TQtQraMYwxBo6KwHerj1xhbZYyPypF6HxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4Prz7SKT8lpfYvpSCITu1LKncmKiXfHajoURWZ0168=;
 b=GNJ3pQnDKWfTca7JDGWJMQTPYGW3BaY9UaM60/Au+BlVkTTZD9McSj5v6QjlncMGoUweUg8Jcwqkl1kTwy3ul/lzmIh8iw20Y3qZCMY3CUP9pxQqbC9OWedr4P174iuL9RV6V+ip96Tk4R3mNy82dmgxOHoRhdGBw6uZeIlV6ZrnlaqG5DHaaxRAzyR96aOKROIuk1QLwI2MRS1EJm5TYgPVsN6M9hPFWPrkFKpSMmgnuwz5XN/E9ezfz+s6jhvOi6ScQ30qc84dQzRWovmRvpMncoJn0nv6D+C9TfNRg65z4OiQ6imQEVo1+UcKcXRgB1Nh+guPwwuNwbG5ychfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4Prz7SKT8lpfYvpSCITu1LKncmKiXfHajoURWZ0168=;
 b=OXxPwt4G5/SAOIL0daFPpPhbUWGVHKCNTxCg8inRjERAeX8wFWtiutVb5p5sbX7AgnPFNULHEPtzNI3FQCiU8kj5fFbxbfmznSYHcB+6+GvgBs1zKT8dy29h6uNl0D3vYfj5JQmI/lIaXTUo5N/N0PPfzfoJMMyCrFJYP+qFWm4=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB1372.namprd12.prod.outlook.com (2603:10b6:3:77::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.16; Wed, 25 May 2022 03:32:46 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::f9e4:75ff:738d:8050]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::f9e4:75ff:738d:8050%7]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 03:32:46 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add beige goby PCI ID
Thread-Topic: [PATCH] drm/amdgpu: add beige goby PCI ID
Thread-Index: AQHYb+c6qSMTyNbCtUujAm15FTGITK0u8D2g
Date: Wed, 25 May 2022 03:32:46 +0000
Message-ID: <DM5PR12MB246901150E60ADC8035E95E4F1D69@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220525032602.2250343-1-alexander.deucher@amd.com>
In-Reply-To: <20220525032602.2250343-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 201799bc-7dd6-402b-b121-08da3dff3c3b
x-ms-traffictypediagnostic: DM5PR12MB1372:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1372B2693FE1356F16B5BBA6F1D69@DM5PR12MB1372.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: glQQbvViInC9S2F5C1mqq4lrYbhETT8CDoa6RUaeC02JUqNPMhTKYyzf5GfQJSbjlOJfwkhStg93eEgrI9NfIqWVgJcF2pym6b27vb1BIQDBxqSr0kMSPQkgwveNKurXnke25U8uMnVunvUZrJqgoCmkMmgidT7oyqBdKiaFlF7nsk8oJyw5bf7jpiv3Bnr/lEhS947O9IZMKacMcxqnt6s2L4avGvH8B82YzmJnbyfleH6goNGrcj9Rk/lncyhLggUBOqwT+XWLLXhU1lKSP4YjsO04L7EEqCp6qbR7U/z09WTpt61cLCY0dqmz3OCg1uvTxaHTS+exRujZjiS4l0wGnwG0s/yKvnZHRni6CBKYhh4d6sBaypMXWBeDRGeEn1vvOpvUfH/I63AHjgiiYWz88M+RssaeCykbPPLakxqzqfeK0yBzfZG6jh5FpXBkPXfqWixTWdHZsqCIvl1r0QZYJP101SMPeuuuJuEhjuCbQyMK8rCJmGhy+hkRjBwZyXwGSEk2y/yVw4YwRUnFcU2/O6JoOKzCh9SI7V00ZmauHWtdOfVescz+ZKiaYB/mF8kF2G1x/2lbX7D9u6Ue1R46NFNnz+x3/ZQxBsoghVEyfeC8E4Nrozvu8zOF9t+QIkp/eomol0UfL1XODmU8dn3ZrLY9XY7CQcD8CYF7602w+i3xt01hIYsEvClhpt8nHmpibVYOyfU5cFvWnNMV8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(7696005)(26005)(316002)(6506007)(186003)(53546011)(71200400001)(33656002)(83380400001)(110136005)(508600001)(66476007)(4326008)(122000001)(2906002)(66946007)(66446008)(64756008)(66556008)(5660300002)(8936002)(8676002)(76116006)(38100700002)(86362001)(55016003)(38070700005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rCiAK/4/tUjlIONIwdAD1arOef+WLcxjfehfln0s6BdZpnlCCn4H8f5QMbMU?=
 =?us-ascii?Q?qbrRsF1RQnDv1aVkAsKh3wt/EWXGeSre2NbWpDvey46eyT9wJvPZGwDd/+lb?=
 =?us-ascii?Q?ZAcTWQ2MhqMYp3G6Mb6n71VIjYZi+TmfrazQcu9G20Zs+RE0SpHJXAiCck2X?=
 =?us-ascii?Q?J5VFCHxmdmLuVM0V4rpYjgthRwHaQ84SFd9ArJRXVk0o5FgGSgcyA/eeL2fM?=
 =?us-ascii?Q?lM+iLzhcZelGzRZV9vJtqV7rKZFxA4x4us4z/Ak5FAOdCeqjp5DTqR1KC1WG?=
 =?us-ascii?Q?QHDh+szGAC5r0sPknyodWYRmE/LFbpD4dpwciU2z5LIjLUO6rdgbMyvBMo9O?=
 =?us-ascii?Q?6o3zbdTT3HRiF4Xo35sDuaQC8JVamFbr1BU95fIChehtJxBDvvm3L3wMa/ii?=
 =?us-ascii?Q?ow/Sz4FYbbTzaoBICmarLvXvTzc/mkhnKl+Mjy3KosHbiyqxn5CX3fES7ISG?=
 =?us-ascii?Q?0I4Bcq407aiYu2/ccB5GfNu5/2H0MM2tVPCZA8Ue7Xa34pSwWdPQlUUvgOWW?=
 =?us-ascii?Q?wcPp6KN2wxKBjJRrNt3ri/fsIj4VILPlvPm8hdb/R1zUAhzP/YfWsi+dj+IO?=
 =?us-ascii?Q?wD+cTfRlD1VuhQRbjRj5M+0SZ7/ePmtvMX4FtXqAv9o7pGJRMRCGRbjRPHD2?=
 =?us-ascii?Q?8o2mFbMN4F5IeZsFi4+Th6Gt2vjpcx8fahAO6hWnxfiVMGDam4gXTddhefua?=
 =?us-ascii?Q?CA0RiiEY03kQFm9lhb16KrcjfRcvHcUu4GWCivEDpu3Vpu47hhavagKciJA1?=
 =?us-ascii?Q?lHDddwFdwbC2GjFN+CDgkqohHy/9SJZc0Twb7jsNk4NiNpUsCg1TlKK2oJtY?=
 =?us-ascii?Q?mcccoOuRIL6xRyxcPFU1c1B7mgycT0NJ9AzbZZkykF/Ed2D5t6sRFniB07AP?=
 =?us-ascii?Q?7dhI/zNyux7n4jM2/Qr5BGEzlXdZTwQGOVkNi+K7knW0c8X6LsGZIfLToeC2?=
 =?us-ascii?Q?5237tKUJcI6lhTeH3VwN4hThRs2gfLPGwnJkdH7EH2U9h6BlzsBp6bXNAuMx?=
 =?us-ascii?Q?BSL1jGAxET9S2ZK+zyR3zD1X79D8zEsIhHEEMOHnW/evkEov2BOFEzTWMZDF?=
 =?us-ascii?Q?+DOgdOmfyGWKD5NkKhIBac8ODjpGg9yopiPFRar2dVYQxWhG+A3406BXJlVI?=
 =?us-ascii?Q?TgehVVtUTMQaWolEinIzXZ+elQYgeSZpaq22pULBDgZfSo6E3hf3c95urU9L?=
 =?us-ascii?Q?kyo/8HNWSfKkUvqOMPj4VodWuol27E+/huLb7hTkB7oWiCuWFy4ecVJW18Od?=
 =?us-ascii?Q?1xtqX+jk4+RNCHe2pHhu54D9/PNnu1kMO2LwW7MaeBxGJzLUILoZBc2ZplL6?=
 =?us-ascii?Q?RuvTWsbO/GkuyomvVyHEqBRBDW4q8I37yv3nyvIVL3BwztsVfEl0k093iOVF?=
 =?us-ascii?Q?vA6bWL4enpvMEa2vcODCex/VNcENW5IXM3QlYaWlPSQxgKfF/5Y8pYkdn5bG?=
 =?us-ascii?Q?oSgz3ibLUkaE+FwwEFECqAjbX2FqHypiv56gxWCHNfbAt6OdtTB0bHPVBpt4?=
 =?us-ascii?Q?7Eb9BzyBO6CnNMLtn82cyGfwYAMlTi6KsIqIRmgTrikvtwlq6bsjgcRiHDMM?=
 =?us-ascii?Q?LT9bF5sVoevhDneirMlSLETgJiS+Z/ZUYJqk55yNJXBs7frkTpSr6n2fjUkH?=
 =?us-ascii?Q?7Ae0WoHrWPCD87ptwa6Om8tonjPDA36CTSLx9yByFoZHBc3BSQgyu96U4xgR?=
 =?us-ascii?Q?Lxt5iCkfTtlg+v2S7T43Pkeuj6UrN8GhoHy/KHUP+r6EiuS5nIaY6HKyaCJE?=
 =?us-ascii?Q?Fs+FCkMT1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201799bc-7dd6-402b-b121-08da3dff3c3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 03:32:46.2221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUeKR4/mU882emJUDKXHHb4H5qayeEO0Ar7z1CqV4hE/0lr7MlV53Z4yOYbV6+PLih+i7NV1ss9MidLAoGcWZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1372
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
Sent: Wednesday, May 25, 2022 11:26 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add beige goby PCI ID

Add a beige goby PCI ID.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 0bc6b2369e65..02731e28f18d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1942,6 +1942,7 @@ static const struct pci_device_id pciidlist[] =3D {
 	{0x1002, 0x7421, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
 	{0x1002, 0x7422, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
 	{0x1002, 0x7423, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
+	{0x1002, 0x7424, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
 	{0x1002, 0x743F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
=20
 	{ PCI_DEVICE(0x1002, PCI_ANY_ID),
--=20
2.35.3

