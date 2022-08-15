Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44FCC00140
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 16:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A56A7BB8E7;
	Wed, 24 Aug 2022 16:37:13 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CEC1AE13B
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 07:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctmF5OEbS7I1e+GVjt2N6itXsxMkvtAi2vekdgVaS/F9Wc7xeTTBOe8EzV3z6pGpwty+TyobB5JAzaYpGbdk7b1Rns2katy9uVEoEi1iA5TX19DecTn2L3AHJAXbxSGClhCK45H+g5QGqRc5jfoYJM1cLOPYklq0oRTQgz6cVldN2QsoTF+ZJFHucKjWTETFcIXWQQybtBO2Krz6GZ+e4BVaaJc5c4qSf45aVWxT7ZraK3vO5c0Jrxze3yV0OUrcNVOe2uk/4LjLmXVfMmryaIui2xLjtXyQkWbqOi1BzWlXHlhoEq+LGwQ+ukzLScDV7xAMFC+j+Av2olW2EFBAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGx8eZGoUhl5LPuUMhKY5a6e0+lHrAbhmerfAHFNoM8=;
 b=Polt+QWLKpKpRuEi0KlF1xfUkpr8AjxVbiN0dEZDzlYZwLh4ijOSy+34iKroNeMHoO8okjcBtn90FZmqYbTIhGL2p4oREpjbYst3AIoDl9IhZm+HRWz82d1E54+MV6fxnIUjFFOM6fyMBYCwLcTtVQSmBEniTvDTHGMyVRrBODtTUs1OXyo821auVyLAI2isiaQOUqElMeRo9M3ID5p3MIu8ubxMAwTGDd7mFcr+NkegTR+1cBb7o21GGQ7OxaYRKtMM2k0xJVoYoRV/QLSquusqircuSsyb5W0KHcIx7WGwVEFMepr5DNysd2sQ9jQ1xySjbZXH0ro8gGEc24EUTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGx8eZGoUhl5LPuUMhKY5a6e0+lHrAbhmerfAHFNoM8=;
 b=n6szOXhbhX6++er/Y7/+Gm9Q3vURooRe/QbJZw3V1VKGFjIIaTD+LuFWedDgT2NKogNZXwT8eU4TEJtt5rZzXgzzwtzIEDMBcMwv7I90l2dzm3j8Uj7Ho1E4nPo7QoQMozgIAvOGPZdH7OrEiR16ZrWKaxD/48ZnuJHBrllBlto=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by MN2PR12MB3967.namprd12.prod.outlook.com (2603:10b6:208:16c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 15 Aug
 2022 07:02:46 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::c85:7688:fe17:4256]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::c85:7688:fe17:4256%5]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 07:02:46 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device
 needs to be earlier than psp_hw_fini
Thread-Topic: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device
 needs to be earlier than psp_hw_fini
Thread-Index: AQHYrivbAEp6fGMUDUKntPt1ke2PV62vjaFg
Date: Mon, 15 Aug 2022 07:02:45 +0000
Message-ID: <CH2PR12MB4215CBF380BB28417AB5C82AFC689@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220812091317.338637-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220812091317.338637-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-15T07:02:43Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=dbb0d066-7abf-48de-b639-38df0a7ba938;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-08-15T07:02:43Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 955d9df3-c397-4744-a6be-45a21f8d6f7c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47e06035-582a-414b-500a-08da7e8c281f
x-ms-traffictypediagnostic: MN2PR12MB3967:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZ7Sy2R6awy/6d7T6e4xcgdyY0tnUeuN/BsdQypn4N20oML0egH9+79Wsbys99VdOTxyhNMvPQAHlsNeh9SamUv47AMX4Kb6q3H0P5e8cR9HDq4whO59+4kXIEe/OlzOzzXSYBiPwmGNVoFKtuNXDF9tYX2kvFfQI31mkzJcRgalG69Ap61LfxgneK9ilSMrrYF9aX2LAvBPMWmfXXDVThZVjmuGY19jTI/megYktmmPDSkqL6OAjrgnykkBjjncc0x00sAZNCH9SC7CuVJTyTPiYXsd2vVmwx4ct4py432f3Fqc/MTTP9iImbr3cZb+rdbEZOG3Yt5f/rzbd8S8fzzIskP+QdzRXfzHdfJm1aUdZbE+RThSKvG0Z0Rij3ggCXhzGwsHiL1wXgVRGMVrIFmUS/Fr/52Cd6FoYWS+BvGYgV8ltmiz+SXZSfqlcMesfiwqsIhiKdixEVvEgtnWRgUedkhybvfq2u9chkqV6eV5gGKM39XwicnZRQWaJc0wYQX2HOwxr1LeZEqmUlv5OuWEMw6mV9c9dmDqIfTFbrgLUEHmw3JOIWBN7PviCQNrIRrmAsylGH5I8peq31UMIw5NSiuGqfTcWFDloAVGdRJuFMKr1CqZLw5LdYKf3lsOulD1B936m50o3z1Ur4+bEaGFbflTABkt+gUtCHXGS8oha8ggnaouSBHTwAgN83QRFvC81Kh+U5vUmAeEcynhwWQq9wNk48asHR+Vbq1SIwHadcM79aaF60CAMJWQoYbRpj3hA2FwKee7vjHk/ROB42TR2AKCxMv/WPLOfGjnJpaNGri5ZtXM51364BtrVRYE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(83380400001)(38070700005)(86362001)(122000001)(38100700002)(66556008)(66476007)(66446008)(64756008)(66946007)(4326008)(8676002)(54906003)(6916009)(76116006)(316002)(52536014)(8936002)(2906002)(5660300002)(53546011)(7696005)(6506007)(9686003)(26005)(186003)(71200400001)(55016003)(41300700001)(478600001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R2OmWODVSLnIY2x+ogJIyJbuEgz8wKjZuv9n3LP1Lqki+nMEcA0n1kLDeKp/?=
 =?us-ascii?Q?LDNJjTEJaOHbgCfsKDJxP1GB0VCeWCszogEbJ/Gg7WzR9XM39LO2JAOMSx/2?=
 =?us-ascii?Q?xiRuk1rMycI8Bbm59dr2ubVBPgu3tFQ9lklSupdwXOvkHgFp31PRPz1d9yJm?=
 =?us-ascii?Q?ufobYW31lu9t2MMw/oXbfeB09BYafhFxwe6vv9xyO3WwxF1Ikpw+2HuIu4io?=
 =?us-ascii?Q?V/GcyguQgM7rP76CpTs0HrN/vPcpZFPaJee7uV8OtlIAa0NMXlhxIEbK8sDe?=
 =?us-ascii?Q?JvzoBjXBNN7vfqkClZzfXpmOAFUy5RhG8S0Al35yHdzTdvbTlO3YyXM3A0OI?=
 =?us-ascii?Q?V8uq1+ds/yyKxwXSzSHFEdvPU9FdfG76kTxWQclDnjZLVWh2yLUT/I/ActqW?=
 =?us-ascii?Q?RyDj+hF/NiNaGbgqJPNnpmUexboOKkykzgaAlnI62E7KHpU3B8xXAaS9XvSZ?=
 =?us-ascii?Q?YYa4mP4p32hbPgB0K4DDxiV+0HmGZfbgDTCBlLTbALL6NNT1sIfn6PsgcJS7?=
 =?us-ascii?Q?dZDFcJBqt2Nl/O9bsjZ+W1dw2J1dftrfiqQm2cqLakWoHnHH6JEtBoeacxIK?=
 =?us-ascii?Q?QSOAQ9ldfPOGeCEklKV+3hoVhiyKLhHZQU9h2VVGdgIptzeYdUqQ9e+GFewK?=
 =?us-ascii?Q?kGEwnHDLB1fKeOUy3NRt/JI6uhhavDEsqKzU7U5zduo3t1+A4sXGG8DZnD0W?=
 =?us-ascii?Q?XZ0XxN+z3uYHub9gowzAg3fPAGIGRYq9k+q0f3XYOTCHaxRxoMWvjtAdsAdR?=
 =?us-ascii?Q?SivndZHCdBtvzGpo8iw1DCxuia3N2QV86D+UJRQVY2cz7zrbINPY4RT9Pfju?=
 =?us-ascii?Q?ksveVFLAPxi9g0nMvJjz/T5N89ydwRtejZRschhsbXCxaQDfnwQ0VEWNTn2E?=
 =?us-ascii?Q?C5Mq5CbNe3OAbVLeWdDtOPBq8hdl5m1oiaY6i+ZUBTjX3uO8D35EhWX6IhPC?=
 =?us-ascii?Q?/norgJW2Xr4PE7eBojJVZJAXG1vsXhz1gB+fc2/w87dKmPjMP+MyAIaAH3iq?=
 =?us-ascii?Q?TlaankKEtPdqAwLmnqsug1pCfXgpyVVzAaKiOFemAY5a/qvkyOI5JF5pxfLV?=
 =?us-ascii?Q?L6TBNHIQn2Kg/fthzRTHpl//CBUXfcK3xJ5sJGyefHgprHlnN6gpmAOUeqHY?=
 =?us-ascii?Q?h5KtvqdSNIF3PmqfsmeKMIt0WIiQAxyKuQ5b9YxlfvmF+CkkLxDb+2Ekf5WP?=
 =?us-ascii?Q?90sh0PYf7qtUtUa03KzVhVALBk5uAjaGRpU6iIYCGCEuGZRahTY2i87qX4Gd?=
 =?us-ascii?Q?muzXn7sj/5aF1ShXk2Mnb9yU/DLS057TDHs1x62OPSQhAA8Ue67CgsmGZNtC?=
 =?us-ascii?Q?NJATnvMDgCBOmQQalhplWQBRq7sZsWQ1/HXpoeXDP9hnio+4yLyJkWMvUyul?=
 =?us-ascii?Q?ZDw1Fgn6vfuhZiVDnhWSs8v/EwQ/WRk5kspwrQCS2GsYvovWNGzNJJlKq4Mt?=
 =?us-ascii?Q?MH6AsiMMfxDb8y0IgrtaD46ZffhWflytf1s6b9GWS3jsY83dwa6gD2TVFMHq?=
 =?us-ascii?Q?OuUzSgnqWdhYj4/S22CWMXMD9Ho+pFM/BfMKiZCPogiof2+GDCe+m80EpV+D?=
 =?us-ascii?Q?7MNeY91/zKNqKg7HWqouF3I/uAMNuEqdM4Owdup6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e06035-582a-414b-500a-08da7e8c281f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 07:02:45.9852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hohSJRyfkwjf2VdEISWBVrNShwFqZjjtFY2WekRASCpyOGxbDKC1tsk3pYHEayvIm/hvAXFvvHYPeQVBQTLP1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3967
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Ping on this series.

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>=20
Sent: Friday, August 12, 2022 5:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@=
amd.com>
Subject: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device need=
s to be earlier than psp_hw_fini

The amdgpu_xgmi_remove_device function will send unload command to psp thro=
ugh psp ring to terminate xgmi, but psp ring has been destroyed in psp_hw_f=
ini.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index c84fdef0ac45..2445255bbf01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2787,6 +2787,9 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_=
device *adev)
=20
 	amdgpu_amdkfd_suspend(adev, false);
=20
+	if (adev->gmc.xgmi.num_physical_nodes > 1)
+		amdgpu_xgmi_remove_device(adev);
+
 	/* Workaroud for ASICs need to disable SMC first */
 	amdgpu_device_smu_fini_early(adev);
=20
@@ -2830,9 +2833,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device=
 *adev)
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
 		amdgpu_virt_release_ras_err_handler_data(adev);
=20
-	if (adev->gmc.xgmi.num_physical_nodes > 1)
-		amdgpu_xgmi_remove_device(adev);
-
 	amdgpu_amdkfd_device_fini_sw(adev);
=20
 	for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
--
2.25.1
