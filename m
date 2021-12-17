Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B011EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 16:53:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D2510E18B;
	Fri, 17 Dec 2021 16:53:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD5E610E29A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 16:53:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLHbcXC/1ieu8x5XYc0CTmhwd8z7DvDFXxw/4CKPWhckdtQGhsv2Vssc6vC9L/rr+fOwbApeTym2/cok5l0jfScRZjchZtXT/6EQS9p/kGnXiADZ1SUJ3RKep6xnyiQD1gAccIl36AiC4CO2CB+tK4Ei+XQEzdpZouVF8uy6WB4pP02HXpem0uQPTWjhIrDs17Kxb6tSIE/f7N/MsD6HnqZAoQNGrl2GHnB2q0gySNo2jd7BJYJjshTp9a7S/+G8/2kf5ewMzGDi7F/PEjSBoatJH9ZhmSnD+aP8d+pTWSOYVSUhEvDFYJ/lRZNhdv0yKo5lyT6MRDpX5KHwdWg62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbkKGFdU07m98aI7cklzSy+fzkDPzvXBI/OwZEMVi7U=;
 b=AZ89dhwKwTemvHHrSbeX45A4dyB4fO0cSlqSFudDtqc98YBsQQCRQfwcFq5F4iVzlF4G92blHv0BaYooWno0QGG6wvXWB7gRj+HOWFCnOokBVt2mFVGLvdXaIpaioIDqabhYGbi/Is71Oap3gPJ8BaTtllBqXizukRF8utvENjbm0DKTfwNQrP0tzDWNpQ8qC/FzxuToj1bvgLse1g3gDsj3vRnH307+J8vaFS1GTgeI0iL1jStnLaEXe7RChKBVJ7rMXmjhputmcRn3dmHuPY6NByYM1Wc6PSRZd+qXMBJPWlWOAeUUuQiuXQtAgBaM8uJ2cEPopwXOJNZjbV84tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbkKGFdU07m98aI7cklzSy+fzkDPzvXBI/OwZEMVi7U=;
 b=zNW8HLW4lA1EBQpB8HsKU5yN2vlfiWy9/yCk5tfAFm24mNGwV1qumNDmYz3plT5Wp+A2cb66zX9DAMRqrMvoFKfWOHLvB+OU5OI3aLMlbvh53UuqsZvs6WZg0UvOU59WiN+Q/9l2Q/eeS2X77FGsGdmWXEqEaxro+lBCORsIDKY=
Received: from BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 16:53:13 +0000
Received: from BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::950:57c2:75bf:aefa]) by BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::950:57c2:75bf:aefa%7]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 16:53:12 +0000
From: "Saye, Sashank" <Sashank.Saye@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough
 for sbr handling
Thread-Topic: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough
 for sbr handling
Thread-Index: AQHX81t7hy2jKHuu/UiEWJtjhi9W/qw25CSAgAAASmA=
Date: Fri, 17 Dec 2021 16:53:12 +0000
Message-ID: <BL0PR12MB2433BF358DCC96638855549390789@BL0PR12MB2433.namprd12.prod.outlook.com>
References: <20211217153324.181888-1-sashank.saye@amd.com>
 <CH0PR12MB5372EAFB8ECE025BA088D829F4789@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5372EAFB8ECE025BA088D829F4789@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-17T16:23:06Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=122135e3-fada-41e2-a729-6a70502decbc;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-17T16:53:11Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 5f13e33e-0a5b-4344-af75-310f66a6efda
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f564965-e9a4-4f06-4561-08d9c17db6b2
x-ms-traffictypediagnostic: MN2PR12MB4175:EE_
x-microsoft-antispam-prvs: <MN2PR12MB417598CB1AD80563794CDBCE90789@MN2PR12MB4175.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TK7nOiYM3cu8L4teSLZ092XDQ54PghjlaVnYHWc4+qfslxYJX2tQY55UG8cbRWIkI9fFUsOv7wo/s/nNCuOuzdX43hWONa2HJ9gEVL14lW8YP80berydNYrjR68lIcOMiViKc9nj2m0fuBVur6Zioqxj2SSaJrWQy3UykUc8b3hfW+9Yh8eR+oebuw/qf2kJ+yLzIMaml3lrmGwid/tbb5Nqb1V5QdRh/BxKMe1IpY7iXT3eLxol2KVcBwR8fSH3aWq+8NVW15iXQ4RQOHYRW41Uk2ILK+LDeuQsR+PRnIKQauznC2VWOu+6fksIsvDj/5XWry9wU0PwSH+WskP+6cpVULO1vlUfsLoN5ETg1fiz5XM6yUlNwlUg2v+fAGu4MSj7c2AuKYNcaAbEGq/i2K7WVhU4msrWsxcbjR45QlQOVwu/B+hwJWa+jVuEhNqZiAjNFFqz9k0wBx/681fkJVwoTdRN6Xlw4Y1TCM6APc/UXLPMAE1QSqoYarWz7TDe7Al/V+zH70AsOB4K3DmPQK3WtLL6l3odcozse4htGD8qnTMo6ZJqdzlCIeJleWGcwvcvmLHVG9AeSIsbTBVh00IKXiO2UjJrguOGNrE3CqYStQYcpXphyVMo/N/COqzbWXQqnZ1CnoCI69XmkXO4DyFv/FXJdfAFMklDMy0jBQsAJd2Ip67lLJwd5WSYki4JSzWAw9PAuuajRdeh5YOuUw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(15650500001)(52536014)(76116006)(6506007)(86362001)(66446008)(53546011)(66556008)(64756008)(66476007)(66946007)(508600001)(8936002)(110136005)(316002)(7696005)(26005)(186003)(8676002)(55016003)(2906002)(5660300002)(38070700005)(71200400001)(33656002)(9686003)(83380400001)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x/bKnzeOl5KmJN1BfHVcwcjvN+YSc+tcQdpFhxAxommz1AK23ArAdVPbMUQx?=
 =?us-ascii?Q?jw29bdSnzw2VgY3OfnCUWgyPO+Wz4tMKJ6a4/zxajEUDfY36Tg21VG8ROcpM?=
 =?us-ascii?Q?Fm2mUelgC6LjIHzG+EmVZMfcakkuYnbpUamd96SWWOJA5+w379x8Y4VS+Zdk?=
 =?us-ascii?Q?A15UqUrbUjilVCOD+FTNVFI8VfSlGP+FO3+dTGkD0FNT6cuLUjAnu8xm9eqg?=
 =?us-ascii?Q?kFYpiLZBtVHCZjz9783IGlNz+RtAzhJT+4jG4LyS9RtY2jYyF9FHQzhiI032?=
 =?us-ascii?Q?ugyLNbSGPwzJVRQ6vfMjsr7/b4UVqc0Kybus79Z9Ls0T3H55PxKa4Qm5znpv?=
 =?us-ascii?Q?WEWcFsZfbrk0gr6gIL0yNv7AkRQ4PElwUWxjBmnMRbJlYFiQ9QdQyE+dEUwe?=
 =?us-ascii?Q?nlOr8jlqL+1bTd5yLt9NGkY6llT4I9wehmVjd38bgUH48bjMu+eJpfe5K0EL?=
 =?us-ascii?Q?5M2A/Zbo3kqMXVVN++EOnjIaOTAJ2t6AZb05v7vIHvavEGWYARY8Vg2b6r7m?=
 =?us-ascii?Q?NciVNFG4/4UBwhXiqk1l907uYIQdDc9Y7BW4+7/rrLP0YqVf8aEE8HybgSaJ?=
 =?us-ascii?Q?GOI0SV5FJ1oTKpi2KbpWhJ4Bc6hANu6b8ldT6Dv0Fm8M8JgXiD6ak0+6LFzW?=
 =?us-ascii?Q?RElMLi66FPECNXpsQ9Ea6n1L9clkAu7M8y9Qul9eawNqiVhPNJprnBKkozb+?=
 =?us-ascii?Q?IqhUxp2qj+nB1RY5VnwkEv1BaoHlXxm0QyIS9O6GaYyFctyuX8+p5n8zFk8q?=
 =?us-ascii?Q?IZKPsoMxl7enujVAHMOXqUMgSMtLaVWhDgmJabo3idfUcQRTq2zrD7KN7z2K?=
 =?us-ascii?Q?ehn8M2sqZeWKdyVWwrPiDQLz9FZ+KP864hN77BdNR0FLonjUZ2R0xVW5DP8z?=
 =?us-ascii?Q?d9rZi2EzRNOCSu4FHG+gODd8PmKqBsJ5F7v+QA+OR7ydzPrG9D3UqoWGL3/4?=
 =?us-ascii?Q?6LFvtln/4pBaRAj8V4AjZIvdTuEe2ZgZVDCsU4NlZyPivkPsWK3pP9dDtDdt?=
 =?us-ascii?Q?x5elOkq+95yUpFMn2482sEjZvExIlsoE2JBK+lvKtXX9t7JPfMTVJzJClow7?=
 =?us-ascii?Q?bsIBdV2jrghKKCClW3MrosLru5NIBR8C6WJOrnwJcxKazTLDCDR0zSw8KALM?=
 =?us-ascii?Q?XzM6Q7Rd5e7lHCEMAPtswUFX1ojbtRp62XdjK7Dm+htodDzEQv+AD8tLi0yx?=
 =?us-ascii?Q?STW/XLIykpepkp6Np+JrHreg1tNzf0sB3jhLFWsIb+OuyVG4R1M3t0Pp99zJ?=
 =?us-ascii?Q?js+WLly/6GrYaFTrZx729Kp1683+PQGw354ffiwfqW7+U/uBlNLscNcUuLPZ?=
 =?us-ascii?Q?X8nCHOEfBa4zHQE9NXfEko32pRhjx9uPPihqvXA7MuBTy38XmXPzT5vfJwXX?=
 =?us-ascii?Q?l6r0GhBCavI+NAcSOXlrq0FaaojZyQrGysltRK+yfoHaTYXhmPTZVf1l6hlA?=
 =?us-ascii?Q?UvUt9n/EUN8KmoZzXC5FfzCPo9ozG1AM0ku8TwYFn7OjMlm4TBgdmf5xzh2L?=
 =?us-ascii?Q?1MFXXtmlX8JhQwyIYWWD7NUdXhRMglHqZCxw8JZRekUs0t7mlAk3pVviW8JG?=
 =?us-ascii?Q?+CWkfBMjEISW9i6wQ0A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f564965-e9a4-4f06-4561-08d9c17db6b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 16:53:12.8375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7sDgx0u0a07UPOQ5p0wELPyuxFrsicKwUb296d6S5DgarI3aaA7LCpNGCrdBKeCa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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

[AMD Official Use Only]

Hi Shaoyun,
Yes, From SMU FW point of view they do see a difference between Bare metal =
and passthrough case for SBR. For baremetal they get it as a PCI reset wher=
eas passthrough case they get it as a BIF reset. Now within BIF reset they =
would need to differentiate between older asic( where we do BACO) and newer=
 ones where we do mode 1 reset. Hence in-order for SMU to differentiate the=
se scenarios we are adding a new message.=20

I think I will rename the function to smu_handle_passthrough_sbr from the c=
urrent smu_set_light_sbr function name.

Regards
Sashank

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>=20
Sent: Friday, December 17, 2021 11:45 AM
To: Saye, Sashank <Sashank.Saye@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Saye, Sashank <Sashank.Saye@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrou=
gh for sbr handling

[AMD Official Use Only]

First , the name of heavy SBR  is confusing when you need to go through  li=
ght SBR code path.=20
Secondary,  originally we introduce the light SBR is because on older asic,=
   FW can not synchronize the reset on the devices within the hive, so it d=
epends on driver to sync the reset.  From what I have heard , for chip aruc=
tus , the FW actually can sync the reset itself.  I don't see a necessary t=
o  introduce the heavy SBR message, it seems SMU will do a full reset  when=
 it get SBR  request.  IS there  a different code path  for SMU to handle t=
he reset  for XGMI in passthrough mode ? =20

Regards
Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of sashank =
saye
Sent: Friday, December 17, 2021 10:33 AM
To: amd-gfx@lists.freedesktop.org
Cc: Saye, Sashank <Sashank.Saye@amd.com>
Subject: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough f=
or sbr handling

For Aldebaran chip passthrough case we need to intimate SMU about special h=
andling for SBR.On older chips we send LightSBR to SMU, enabling the same f=
or Aldebaran. Slight difference, compared to previous chips, is on Aldebara=
n, SMU would do a heavy reset on SBR. Hence, the word Heavy instead of Ligh=
t SBR is used for SMU to differentiate.

Signed-off-by: sashank saye <sashank.saye@amd.com>
Change-Id: I79420e7352bb670d6f9696df97d7546f131b18fc
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  4 ++--
 drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h       |  4 +++-
 drivers/gpu/drm/amd/pm/inc/smu_types.h             |  3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 11 +++++++++++
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f31caec669e7..06aee23505b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2618,8 +2618,8 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)
 	if (r)
 		DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
=20
-	/* For XGMI + passthrough configuration on arcturus, enable light SBR */
-	if (adev->asic_type =3D=3D CHIP_ARCTURUS &&
+	/* For XGMI + passthrough configuration on arcturus and aldebaran, enable=
 light SBR */
+	if ((adev->asic_type =3D=3D CHIP_ARCTURUS || adev->asic_type =3D=3D=20
+CHIP_ALDEBARAN ) &&
 	    amdgpu_passthrough(adev) &&
 	    adev->gmc.xgmi.num_physical_nodes > 1)
 		smu_set_light_sbr(&adev->smu, true);
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
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7433a051e795..f442950e9676 100644
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
{ @@ -1912,6 +1913,15 @@ static int aldebaran_mode2_reset(struct smu_contex=
t *smu)
 	return ret;
 }
=20
+static int aldebaran_set_light_sbr(struct smu_context *smu, bool
+enable) {
+	int ret =3D 0;
+	//For alderbarn chip, SMU would do a mode 1 reset as part of SBR hence we=
 call it HeavySBR instead of light
+	ret =3D  smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_HeavySBR, enable ?=
=20
+1 : 0, NULL);
+
+	return ret;
+}
+
 static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)  {=
  #if 0 @@ -2021,6 +2031,7 @@ static const struct pptable_funcs aldebaran_p=
pt_funcs =3D {
 	.get_gpu_metrics =3D aldebaran_get_gpu_metrics,
 	.mode1_reset_is_support =3D aldebaran_is_mode1_reset_supported,
 	.mode2_reset_is_support =3D aldebaran_is_mode2_reset_supported,
+	.set_light_sbr =3D aldebaran_set_light_sbr,
 	.mode1_reset =3D aldebaran_mode1_reset,
 	.set_mp1_state =3D aldebaran_set_mp1_state,
 	.mode2_reset =3D aldebaran_mode2_reset,
--
2.25.1
