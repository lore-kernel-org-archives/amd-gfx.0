Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC6EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 19:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC1B610E58E;
	Fri, 17 Dec 2021 19:16:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2059.outbound.protection.outlook.com [40.107.96.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A43310E58E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 19:16:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSwEmwqg8kUPOCBh2Aq1THR1hT+uUAiyG+3Z8tGtlWkcBzrLn5zXXL/KkencnYS8XvE1Ffo5BQCi4huqRBHPmpnuFI/X1B5gSDAWiE9LA97daZqjD/tSaMi8ij2NH8MQxNAPWUWxqZNWxd2r1QEh0ph4VBE+toJC2YiD5L0y+bat+mPWiO/QmUGxszz2iewjY8xe583JATDP8p7WC1SURhcOdUrK+DoCm4bnxfdjM5UlZn4Ga9qqdGl1n9J5kltHOaFQD+caCodrYKADwDvSWgi8nf+cYdpNncGO2roBS3dj31ySkm7mNyXvhXgBmNntQtxnmH/9q3E0NsOvH430pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6M9jm/mT+W8dnQfL/zHB2iOCzVyTaGf4sEJS7FDxJ+Q=;
 b=XYgNLwwET0WxZCfSCjvXPspoyes7yyiV+ArNrm0LL+EXFT1s2yPBrajarQYqd27j2cZRbmrUwG4ddN/eW0JLgYAtNDCrSDaPxFFtFBq86snL7GnwUD4d4N6xwKG3aEaAwovQvIdOSYl4rof57gw1vuCpup5yz9/URFVePw3Os4jhmDtPDCE2ez+31JWJ5MQTbrj9XXsnAukakTUbTDYhRXwf4PVSpZkJS4kD+N+673tNcziEy4momJZUGo3RFOQP3Bqn6Styw+MgAQ/dbMHqzGHaNJyyVvMNEOclig813RZ2cTo+4/lzzscRTc0ZiZ5jEiB1PudvySCvwlRVGXkXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6M9jm/mT+W8dnQfL/zHB2iOCzVyTaGf4sEJS7FDxJ+Q=;
 b=QKweQVrbWQZtrPjuKQQXaLYczW+q1l4DXZt8DTQ7N9EIBBjXn+wF4sk9KmRqrtf9C2/JjpLiZDBH39x8jNvijx5r2g0EoMmQ9zmI1JkNaRTZTxDE6KUwLW7wgyt9HiSwwDey+tEuXAnFLvJEYXEKYazr1hKvhRGTRXmYNoXa/IY=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5252.namprd12.prod.outlook.com (2603:10b6:610:d3::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Fri, 17 Dec
 2021 19:16:50 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563%8]) with mapi id 15.20.4778.017; Fri, 17 Dec 2021
 19:16:50 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Saye, Sashank" <Sashank.Saye@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough
 for sbr handling
Thread-Topic: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough
 for sbr handling
Thread-Index: AQHX83faZIQ+sHygk0WQ2AECtiWmW6w3DjPw
Date: Fri, 17 Dec 2021 19:16:49 +0000
Message-ID: <CH0PR12MB5372587B8861F96A8C590E99F4789@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211217185616.207927-1-sashank.saye@amd.com>
In-Reply-To: <20211217185616.207927-1-sashank.saye@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-17T19:16:19Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=476f441a-29ab-4577-bcdc-aead50c4b4a4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-17T19:16:48Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 8e775628-2c4d-414b-9163-f79c855607c2
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7434e973-be6d-499b-4231-08d9c191c750
x-ms-traffictypediagnostic: CH0PR12MB5252:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5252A63E0D72F3BE8F13BCE6F4789@CH0PR12MB5252.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kN1f37/WI1OW/URIpwHKMBh77ONr9pxN08LrTIxX0enzwBhUUB4dYQLDnLYc4PyNXBEzblayQ5pd9lulI99CxSRFRZ/tEXzLV9+AfWEcd2gWVirVPtWxEndIcgGr5j+4qhbUYkbuQKbdDaR3U7nzeEw+KBdG1PMUHb03FCpTQZOwFMeZUXS4lVwLSmbSZi0sSwGo8K6k9uz1hZ2cl8/NidCa2S/T+UWbvJnMi2CtOf8wB4GDSgpMJl0c8e/QrgYn44zeZjhdSPPDBhQCDRUpULvCc5WnS3tolYBPhOqr8qCEg3OjdMIR5vno96b4shKHy2AdxnEoT3DEiAawV575uHkVFD+NCi+6Ya9ZrY6WI/Xtn0mfSO7jAx9BjrYbvoZyfzRM3Xb/5wkT+Cg++I34HfSXEmuPgA47QKpmhIHGFRE/J1tgsMpDdrciqRqSYNGWB11LCRPC48TSLRsPvifcTRHRMafkdy8a0Gmlpxcinmt2KRMSV+SUx/75moWHTUMK8SRFzbaxeHPMhmIdoViQx0qfzuqO9EjY78OtcyPwGY8vrVm+xXumOqRP9BLgAAuQRt1+8q/AoRy2pHQFD1oX8W8ZtrKKHpFyxFHg2p42ud2tx6ZGkt5YI7XZ633cVs1oPd01B1K8rNSS8uZgbYaPww1d5WTvaRSoCvCfw/NcHqvOn2sHfovu3cKGyQh1yHtvhN36NTtyWp7x+1APonBjOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(186003)(5660300002)(38070700005)(52536014)(2906002)(508600001)(7696005)(53546011)(83380400001)(26005)(6506007)(9686003)(8676002)(71200400001)(66446008)(64756008)(66946007)(55016003)(66476007)(15650500001)(66556008)(110136005)(122000001)(76116006)(316002)(86362001)(33656002)(38100700002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DZ0Nd1YxFNMhcV4fVJazOF9JBII6yMI74xtpEhgCnVmu4oVGiIQHXLbteMPx?=
 =?us-ascii?Q?UzuNVwmJWkjzyos6CW8SvKhlzCaZfRAk+SkehpApoOIKGccj+x7PvpLPksNN?=
 =?us-ascii?Q?dv4/4Mln1OTfyDRcz82zK48lAjVsRFIzuHIHzDqWrQ3TUJOFs0kvFrj3v24V?=
 =?us-ascii?Q?vIh7f+5BQo+/RWjCq/rh9MoPigwS1AXyttXtdMg3PebF2HY1Yv/NE7LsCOEB?=
 =?us-ascii?Q?qko0IIazRAvIPCSLAX73HfY4a30UatTS4oJ9Btgxe9eqRHSgmQlbNNsrzSUq?=
 =?us-ascii?Q?PjV5VgOmerU6o3Il/BaSfrUCSZvQHkTmKQ7Yhn6Ud0qfv1g8zW0FoHJ7w3a+?=
 =?us-ascii?Q?laDwbZmMqE/rovOhATCp+K/xYZRAWPoX1JXRHXCkIhnhfViQS0Fhahqwuhkp?=
 =?us-ascii?Q?8EbsfM7BlJjNZ3Xvg2nD5u/MUYeWIiYh5zTVNrgkjbNWUBSJtTKuYhPYwJOF?=
 =?us-ascii?Q?ygWWf5q9ouJ4grM8xuItzIq/mHAEoxXt5ZNaXboOsIPdd4hnq84k00PKVsDe?=
 =?us-ascii?Q?BGE2/2AgVwVgCXCcvssGP2UQNLlFOLhq/eLB+v75y08tTYOinah05CQZ2tkD?=
 =?us-ascii?Q?aQUeMu2n9t3yge/h8aI2dGkwSyU9PC8vZ2gFu6J6+cnppjedW3KYtix172A+?=
 =?us-ascii?Q?uyg/PQm4/llPQOXTvEKukn9YNw6l7u2aA0hHJqGatkIBgCXawBKYDER0tP+J?=
 =?us-ascii?Q?08yaH+qr6KkGFsbDQMPi2kXtcJKx3x5mdrfX9kOothldjCg1JCI9SeKG5y8h?=
 =?us-ascii?Q?Lln/zTjNYWAPmvbrD1MVo3Mf6oLWJUJL/sUoanA/zHh7kvpuTJp4oeYZdfqI?=
 =?us-ascii?Q?W6SvvHIjFNOAtkEi3uV7BUssaEBZSGsmpUSwBsiAERmTCICiDJyWkSwwWzn9?=
 =?us-ascii?Q?2VLDkoj5iBjd7VQErgseqId8MId4adhaR1txI+Ah2YjHHoQpYpOLuu7mQbdO?=
 =?us-ascii?Q?jM/sD/KVCM/Agq91pLnuREnyQXQVf5CHoz4ONCEmw17IQ5AEO2Wgf8ElAuSS?=
 =?us-ascii?Q?uL3fn7cSUAuSpkUAEXah++t3GWdp+VNR1hGwknJv4bi6ZDfQEldTorCdBYKE?=
 =?us-ascii?Q?R9PAcTq7DQs9n7oTHiUUmy5GZZcl4h3lbjJXJxAKuRent4R0pB6vJu4WVkoF?=
 =?us-ascii?Q?Vsqj0bR7S6p9HHUDvVUe+7OrGW4vul0YuwuJWfpCgw4IMDWmyB3grDOURlo7?=
 =?us-ascii?Q?g2dRRicQ/C8ijWJXM/KUNxtgsFm7gmd4bqxiclzK/Q/mDnImHXmnsw5a8om1?=
 =?us-ascii?Q?uTQ7ELTKPJeAWr6mLw6Ujr3H0Kui/J+ONRi7EdKBnzBXe2rJiNOIwsmws/+n?=
 =?us-ascii?Q?211F4SKmCjLgoPFSuRmu3IJrAwP+SdvAZsM9em/uA2TDWtnkgBYo69DO/ExL?=
 =?us-ascii?Q?YQfSMsuPq9VV88AhZODW35h53Tbt57W/+fJU1pLjBHHk0fdOSsf6USUNJnPU?=
 =?us-ascii?Q?R66JYNLey1fe6exsl8W8cMiBrLOYayddcTVEivSYxSL8knnFad/+++i64nj5?=
 =?us-ascii?Q?7MxFjpNnR5xCHaRtQPYKdChJxNAmfXDFyk7X/fc1762nhj7d95YO06IJ/945?=
 =?us-ascii?Q?j9PaVPh5ZT+B5NeUVMBLmPbHFiwIkeCxTEdL82I9MWTVZNQQya5umOzsYlDd?=
 =?us-ascii?Q?yv4wADDqlQC1chauAr1aGHo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7434e973-be6d-499b-4231-08d9c191c750
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 19:16:50.6855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UqsWLQmbRgEVlhmeNnEd8du4FB5YgzKbAEkGfXzxHQqy9wgtPkv0Gkp38nGDB9dQwb8RBLxGr/x3Fd7WIwyKcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5252
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
Cc: "Saye, Sashank" <Sashank.Saye@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed by: Shaoyun.liu <Shaoyun.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of sashank =
saye
Sent: Friday, December 17, 2021 1:56 PM
To: amd-gfx@lists.freedesktop.org
Cc: Saye, Sashank <Sashank.Saye@amd.com>
Subject: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough f=
or sbr handling

For Aldebaran chip passthrough case we need to intimate SMU
about special handling for SBR.On older chips we send
LightSBR to SMU, enabling the same for Aldebaran. Slight
difference, compared to previous chips, is on Aldebaran, SMU
would do a heavy reset on SBR. Hence, the word Heavy
instead of Light SBR is used for SMU to differentiate.

Signed-off-by: sashank saye <sashank.saye@amd.com>
Change-Id: I79420e7352bb670d6f9696df97d7546f131b18fc
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  9 ++++-----
 drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h       |  4 +++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            |  6 +++---
 drivers/gpu/drm/amd/pm/inc/smu_types.h             |  3 ++-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h             |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  6 +++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 10 ++++++++++
 9 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f31caec669e7..e4c93d373224 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2618,11 +2618,10 @@ static int amdgpu_device_ip_late_init(struct amdgpu=
_device *adev)
 	if (r)
 		DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
=20
-	/* For XGMI + passthrough configuration on arcturus, enable light SBR */
-	if (adev->asic_type =3D=3D CHIP_ARCTURUS &&
-	    amdgpu_passthrough(adev) &&
-	    adev->gmc.xgmi.num_physical_nodes > 1)
-		smu_set_light_sbr(&adev->smu, true);
+	/* For passthrough configuration on arcturus and aldebaran, enable specia=
l handling SBR */
+	if (amdgpu_passthrough(adev) && ((adev->asic_type =3D=3D CHIP_ARCTURUS &&=
 adev->gmc.xgmi.num_physical_nodes > 1)||
+			       adev->asic_type =3D=3D CHIP_ALDEBARAN ))
+		smu_handle_passthrough_sbr(&adev->smu, true);
=20
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
 		mutex_lock(&mgpu_info.mutex);
diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm=
/amd/pm/inc/aldebaran_ppsmc.h
index 35fa0d8e92dd..ab66a4b9e438 100644
--- a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
@@ -102,7 +102,9 @@
=20
 #define PPSMC_MSG_GfxDriverResetRecovery	0x42
 #define PPSMC_MSG_BoardPowerCalibration 	0x43
-#define PPSMC_Message_Count			0x44
+#define PPSMC_MSG_HeavySBR                      0x45
+#define PPSMC_Message_Count			0x46
+
=20
 //PPSMC Reset Types
 #define PPSMC_RESET_TYPE_WARM_RESET              0x00
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index 2b9b9a7ba97a..ba7565bc8104 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1257,9 +1257,9 @@ struct pptable_funcs {
 	int (*set_fine_grain_gfx_freq_parameters)(struct smu_context *smu);
=20
 	/**
-	 * @set_light_sbr:  Set light sbr mode for the SMU.
+	 * @smu_handle_passthrough_sbr:  Send message to SMU about special handli=
ng for SBR.
 	 */
-	int (*set_light_sbr)(struct smu_context *smu, bool enable);
+	int (*smu_handle_passthrough_sbr)(struct smu_context *smu, bool enable);
=20
 	/**
 	 * @wait_for_event:  Wait for events from SMU.
@@ -1415,7 +1415,7 @@ int smu_allow_xgmi_power_down(struct smu_context *smu=
, bool en);
=20
 int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
=20
-int smu_set_light_sbr(struct smu_context *smu, bool enable);
+int smu_handle_passthrough_sbr(struct smu_context *smu, bool enable);
=20
 int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type eve=
nt,
 		       uint64_t event_arg);
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/p=
m/inc/smu_types.h
index 18b862a90fbe..ff8a0bcbd290 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -229,7 +229,8 @@
 	__SMU_DUMMY_MAP(BoardPowerCalibration),   \
 	__SMU_DUMMY_MAP(RequestGfxclk),           \
 	__SMU_DUMMY_MAP(ForceGfxVid),             \
-	__SMU_DUMMY_MAP(UnforceGfxVid),
+	__SMU_DUMMY_MAP(UnforceGfxVid),           \
+	__SMU_DUMMY_MAP(HeavySBR),
=20
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/p=
m/inc/smu_v11_0.h
index 2d422e6a9feb..acb3be292096 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -312,7 +312,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *sm=
u,
=20
 void smu_v11_0_interrupt_work(struct smu_context *smu);
=20
-int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable);
+int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool enable)=
;
=20
 int smu_v11_0_restore_user_od_settings(struct smu_context *smu);
=20
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index af98fa140d83..76f95e8ada4c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3058,13 +3058,13 @@ static int smu_gfx_state_change_set(void *handle,
 	return ret;
 }
=20
-int smu_set_light_sbr(struct smu_context *smu, bool enable)
+int smu_handle_passthrough_sbr(struct smu_context *smu, bool enable)
 {
 	int ret =3D 0;
=20
 	mutex_lock(&smu->mutex);
-	if (smu->ppt_funcs->set_light_sbr)
-		ret =3D smu->ppt_funcs->set_light_sbr(smu, enable);
+	if (smu->ppt_funcs->smu_handle_passthrough_sbr)
+		ret =3D smu->ppt_funcs->smu_handle_passthrough_sbr(smu, enable);
 	mutex_unlock(&smu->mutex);
=20
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 58bc387fb279..505d2fb94fd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2472,7 +2472,7 @@ static const struct pptable_funcs arcturus_ppt_funcs =
=3D {
 	.deep_sleep_control =3D smu_v11_0_deep_sleep_control,
 	.get_fan_parameters =3D arcturus_get_fan_parameters,
 	.interrupt_work =3D smu_v11_0_interrupt_work,
-	.set_light_sbr =3D smu_v11_0_set_light_sbr,
+	.smu_handle_passthrough_sbr =3D smu_v11_0_handle_passthrough_sbr,
 	.set_mp1_state =3D smu_cmn_set_mp1_state,
 };
=20
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index 28b7c0562b99..4e9e2cf39859 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1724,7 +1724,7 @@ int smu_v11_0_mode1_reset(struct smu_context *smu)
 	return ret;
 }
=20
-int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable)
+int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool enable)
 {
 	int ret =3D 0;
=20
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7433a051e795..0e60d63ba94f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -141,6 +141,7 @@ static const struct cmn2asic_msg_mapping aldebaran_mess=
age_map[SMU_MSG_MAX_COUNT
 	MSG_MAP(SetUclkDpmMode,			     PPSMC_MSG_SetUclkDpmMode,			0),
 	MSG_MAP(GfxDriverResetRecovery,		     PPSMC_MSG_GfxDriverResetRecovery,		=
0),
 	MSG_MAP(BoardPowerCalibration,		     PPSMC_MSG_BoardPowerCalibration,		0)=
,
+	MSG_MAP(HeavySBR,                            PPSMC_MSG_HeavySBR,         =
               0),
 };
=20
 static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] =3D =
{
@@ -1912,6 +1913,14 @@ static int aldebaran_mode2_reset(struct smu_context =
*smu)
 	return ret;
 }
=20
+static int aldebaran_smu_handle_passthrough_sbr(struct smu_context *smu, b=
ool enable)
+{
+	int ret =3D 0;
+	ret =3D  smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_HeavySBR, enable ? =
1 : 0, NULL);
+
+	return ret;
+}
+
 static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)
 {
 #if 0
@@ -2021,6 +2030,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs=
 =3D {
 	.get_gpu_metrics =3D aldebaran_get_gpu_metrics,
 	.mode1_reset_is_support =3D aldebaran_is_mode1_reset_supported,
 	.mode2_reset_is_support =3D aldebaran_is_mode2_reset_supported,
+	.smu_handle_passthrough_sbr =3D aldebaran_smu_handle_passthrough_sbr,
 	.mode1_reset =3D aldebaran_mode1_reset,
 	.set_mp1_state =3D aldebaran_set_mp1_state,
 	.mode2_reset =3D aldebaran_mode2_reset,
--=20
2.25.1
