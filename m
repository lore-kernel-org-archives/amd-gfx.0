Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F62C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 11:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C0261402
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 11:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C0261402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 131D56ECA3;
	Wed, 26 May 2021 11:34:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A58B6ECA1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 11:34:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ct4sGpNhO79SQGHxvw62A9OX4A+HtIWVo9TET9V7UKBqCpDAO15AguDVvnfYu+EjXt1zhXIu2YTY3cRvY/K/h0lhO5H/ba3bMo5OBhxd9nL1U4qs7nPz87ePNuyKlb1myGINJLFhMd+tt0vFjeAwu7BqMDswPh+0l8zuCsxjPB0LdV5Kif1p91Z4pb3Dxu1R2GdtTJ57ZgccTVRPSZ3wZWtdCZ2zGeu9ibc0iC11J7QIrAiQHG+alt+//JL2eqiQM11Tt/0v08Y/RZHGcW4WveO3WJTSmqGUIj9zHaj4QBKg3eWWyPpoGH0NKpqaDlxG4jEzvuoAmbIjClUC/G7U+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlNaAcCDFlc9h8cYAjxROyMwp9ejVictkYt60+GFtoQ=;
 b=b7g55cl6hx0aNMXUS/N1INsuqnaQfd2zijbHk/Q8FhUIN4H/+qc67OmQdkP25ZfesCNisHNVirLBeD76Ac1KV8fIdNU4GFXlr6sDw9sFQGZiJsfI0JmuA4LPiZMImCGLdMLoYYI65/RJbqx8ZM84paN/8Fuwbb92ZU/q09tiIOrjqHmDmanvWtC5/Glap1arA1ooAkzy9m4nKgjountMO7+QoA0GeOYenphfOB/USLydKDkDaGH8VTHJV1wi/nHdDHXIo5Gl3o+lzMAFhn/fs0VZGpcrWWseNcSZc0Bdl4TZDodVsMxBNJgNg0WBF3boG9OtYKCuRdlamD6w9cpT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlNaAcCDFlc9h8cYAjxROyMwp9ejVictkYt60+GFtoQ=;
 b=v3TBNp1TF32RKM/IaUWPvDR8FsAXbKp2/1urKneiBPVDwSApIZSn6E+k8aci1ACSd1gjEqfYDOrZxyLUiNAUxpdWmbLigtP6BoDDXmgu6Usd4RIsnrBGqk9BxghoCTN/dyzBivsYeudnen0XYbCd7+sybxfZ+zK1L6siYsS+UZc=
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5326.namprd12.prod.outlook.com (2603:10b6:5:39f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 11:34:05 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 11:34:05 +0000
From: "Das, Nirmoy" <Nirmoy.Das@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 6/7] drm/amdgpu: remove unused code
Thread-Topic: [PATCH 6/7] drm/amdgpu: remove unused code
Thread-Index: AQHXUhdqpf0tccU+lkaRrDZfcKCPjKr1oZ+T
Date: Wed, 26 May 2021 11:34:05 +0000
Message-ID: <DM4PR12MB51365E1501638EC03C048D3F8B249@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <20210526101027.14936-1-nirmoy.das@amd.com>,
 <20210526101027.14936-6-nirmoy.das@amd.com>
In-Reply-To: <20210526101027.14936-6-nirmoy.das@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-26T11:34:05.577Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2003:c5:8f26:4300:d522:207b:ae82:4dad]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62a79767-f9b2-4c26-5482-08d9203a2b43
x-ms-traffictypediagnostic: DM4PR12MB5326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5326ECEFF62761E82A1B885F8B249@DM4PR12MB5326.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SOChLsXBZ0Y/ZAa+6S/JO6H/b4wPYS7vHBO2Ak+DbKwFzs8TQS4fJZgZBr4fTat/mo8PnzW6GJpeTslN9CU8i4zap65gtFalyFY5KDCrG8OOOcRovwzXC7iBTISmjeAJwwVypKo/bmT45ZgNVVoTkc49G4BZsaL42lilux16npTZj3WuHoIHCdIJuYM2kL0+ZGt8+BB8wRS0UwV68ohZ4BH1qi+LgouGWqJ8THC8NF3jH4jLrQeL+kQuxbKfEhpSk7oN6cFCH6shBU/lr1wfAJwA27YhOMpIK5mW5WFZQDQr87lTy6j4YVnvs0YIduRrLSHxfZXD7sHfo9Q+KZ4oBOwc2m8JVKtgk8X16L9q1XE/P9K4tneqAcFXSShQj5WHRHiLvXjpToqTEPPYgAyPxnrNkcg8rOEvKj6RF5CBS/WE/9V6Gp4PHm4NLjuCQ8o1uZpYRlj15tWXzeRoqGOUcz6X8KPZPEmvjoq0HPrOx9txgQDsMhVZjhG49Ciahivf3ZNReY1Amy60DppdDb0RKoUkM/msgzTthThqAJPnn/MRIWYW+nhFg/RKm10b7R/iwX4EVInMuE0hw/PMOcW7RvUudmaeiRdiqH2oZg8rU1A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(71200400001)(2906002)(316002)(8936002)(4326008)(33656002)(6916009)(83380400001)(53546011)(76116006)(38100700002)(52536014)(55016002)(9686003)(122000001)(5660300002)(54906003)(8676002)(6506007)(19627405001)(86362001)(66446008)(7696005)(66556008)(66946007)(186003)(66476007)(478600001)(91956017)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?V3Ev3xqBwcGPv8c1/Pesa8x/MB38jl/hB6WBF3FLhixb0AbfcWo2imQ/xIl2?=
 =?us-ascii?Q?zEav94m8qlIIRCUmEdOgSla+qzyWYCfF2erB8c82EaHttILdMxmsHmV9wE/D?=
 =?us-ascii?Q?bQ5c/ntQt0NGGi+16VH2ALj9HsI8JIDvDbljeeQIxK3a42OF2uWqXQX42rbu?=
 =?us-ascii?Q?KMa4d8AnvCxHreCyPj93nuzM03avwdNVVWxdqePiV8xMBLnzOfazNgBGdntx?=
 =?us-ascii?Q?EJ8LXwsv9JLTDdd9SnkuwACorS+KIekCha86gJPsfbKRFXCKV2rko1RZqsK0?=
 =?us-ascii?Q?owApVvGBP8/hcSTo5mtw6nyMGZYNCo5S5eTfIgR8OtDTsGojnpvEOYb4uH+G?=
 =?us-ascii?Q?1lH0eELZvP5XcEpjoopa7fOSR/ZFftSnJELpumyOFu//VAwpzy09ZvtRkGEi?=
 =?us-ascii?Q?3dpCAQG6Luwt1C66ZjKlPAzYWGlpjx87EEE3t2p8Mak+Lco7EcZ9rTRVnbo+?=
 =?us-ascii?Q?zEhpe4SKRp9zx9C3PQlzXW6SzztLBARKWgJjmqdoLWn0GKBVhlrT4u+w/287?=
 =?us-ascii?Q?4mV7BgIhMSHlVAnHCWvNItgH0PLIRkj8Jkt3xozzcSU/ME3viKEaYTQtf2NP?=
 =?us-ascii?Q?7QfFAApWuc26Myer7FNDCSHENs03HaYeqpufDXQD0TFu3fNhC2RWG0TpYb+S?=
 =?us-ascii?Q?Q83/VVuwaF1LHu86OYnwn5E1IeP0fKDNcVKOizjjNLxw5S9+PGoxrjwHC65A?=
 =?us-ascii?Q?IK4wfXN5EQv/y/8pvd5xrvTC3fkTJAZAh+gNb5elD6ZVhiT1Re40DtMApz3t?=
 =?us-ascii?Q?IE5GVvcP+3NUKLQz3TzSX8n52C2PsU9swiQ7aBVrY+5AplIVPforrhlMRatI?=
 =?us-ascii?Q?kY3D2WFeaaXYanFHTRh7fwTIyfH2JVGgpZrla/PuJvs4Bben0KDtwkx6MLCX?=
 =?us-ascii?Q?KYhvPiYuYZcpASgw3FI12ljathAzvYXO+X3xtgQ5vVaqMORtPGiej2TbowkK?=
 =?us-ascii?Q?6lg8chhjoo6AfrmBJidzoB9AhP9zadn9Ui4wpCNfTlJruYvcrmWtIApToAGA?=
 =?us-ascii?Q?75DP//HIK2tGBYEuu0WLbcfATDuEPTDIWmsm07Tx94NUSSuWgljGSUsEKMw6?=
 =?us-ascii?Q?7lBfm7DyGapjzGYhuhV/x0ctMLIW5qmFdE6yGJ4TqaSp8e7zKDkCrJghRHb9?=
 =?us-ascii?Q?f24g3X0GA62ijP9zR3EFKJ1AgaeSJ0eyQg/PrY6YCCZhD+/MzjCHTygG4lH1?=
 =?us-ascii?Q?vYhVz+5zPv4JlC2cJUVS7QZ7t6JdosOKARXck98GXUdvh5pUnwUDs+7C82mU?=
 =?us-ascii?Q?fBa7XwrZo7oMpmvniifBRYN6BBgev1BiscPN8Cc70xgSXNtDVRQNC42kYWtH?=
 =?us-ascii?Q?vFz0gEu4TbOi9yFaAOHkLUF4zclipd2RFWlz+Fx40h4Dd2tdhAj06/u2tOAg?=
 =?us-ascii?Q?TZto7iA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a79767-f9b2-4c26-5482-08d9203a2b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 11:34:05.4884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jalN9IK3uNQlQTUvgrok9M4wMejrTDviToLBfJQPyNnu+KyAy+f6N11LqcABf40nmDdcolPgVLsqpE+zo27ZqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5326
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============1755351001=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1755351001==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM4PR12MB51365E1501638EC03C048D3F8B249DM4PR12MB5136namp_"

--_000_DM4PR12MB51365E1501638EC03C048D3F8B249DM4PR12MB5136namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

I just realized that I didn't remove the shadow pointer from the amdgpu_bo.=
 I will update that in the next version.

Regards,
Nirmoy
________________________________
From: Das, Nirmoy <Nirmoy.Das@amd.com>
Sent: Wednesday, May 26, 2021 12:10 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: remove unused code

Remove unused code related to shadow BO.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 29 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ---
 2 files changed, 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 6870cc297ae6..7930b7d9a3b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -638,35 +638,6 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
         return r;
 }

-int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
-                           unsigned long size,
-                           struct amdgpu_bo *bo)
-{
-       struct amdgpu_bo_param bp;
-       int r;
-
-       if (bo->shadow)
-               return 0;
-
-       memset(&bp, 0, sizeof(bp));
-       bp.size =3D size;
-       bp.domain =3D AMDGPU_GEM_DOMAIN_GTT;
-       bp.flags =3D AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-       bp.type =3D ttm_bo_type_kernel;
-       bp.resv =3D bo->tbo.base.resv;
-       bp.bo_ptr_size =3D sizeof(struct amdgpu_bo);
-
-       r =3D amdgpu_bo_create(adev, &bp, &bo->shadow);
-       if (!r) {
-               bo->shadow->parent =3D amdgpu_bo_ref(bo);
-               mutex_lock(&adev->shadow_list_lock);
-               list_add_tail(&bo->shadow->shadow_list, &adev->shadow_list)=
;
-               mutex_unlock(&adev->shadow_list_lock);
-       }
-
-       return r;
-}
-
 /**
  * amdgpu_bo_create_user - create an &amdgpu_bo_user buffer object
  * @adev: amdgpu device object
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.h
index a7fbf5f7051e..b8555c527613 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -284,9 +284,6 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
                         struct amdgpu_bo_vm **ubo_ptr);
 void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
                            void **cpu_addr);
-int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
-                           unsigned long size,
-                           struct amdgpu_bo *bo);
 int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);
 void *amdgpu_bo_kptr(struct amdgpu_bo *bo);
 void amdgpu_bo_kunmap(struct amdgpu_bo *bo);
--
2.31.1


--_000_DM4PR12MB51365E1501638EC03C048D3F8B249DM4PR12MB5136namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
I just realized that I didn't remove the shadow pointer from the amdgpu_bo.=
 I will update that in the next version.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Nirmoy</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Das, Nirmoy &lt;Nirmo=
y.Das@amd.com&gt;<br>
<b>Sent:</b> Wednesday, May 26, 2021 12:10 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;; Das, Nirmoy &lt;Nirmoy.Das@amd.co=
m&gt;<br>
<b>Subject:</b> [PATCH 6/7] drm/amdgpu: remove unused code</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Remove unused code related to shadow BO.<br>
<br>
Signed-off-by: Nirmoy Das &lt;nirmoy.das@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 29 ---------------------=
-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |&nbsp; 3 ---<br>
&nbsp;2 files changed, 32 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c<br>
index 6870cc297ae6..7930b7d9a3b1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
@@ -638,35 +638,6 @@ int amdgpu_bo_create(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
-int amdgpu_bo_create_shadow(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; unsigned long size,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct amdgpu_bo *bo)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_param bp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;shadow)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;bp, 0, sizeof(bp));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.size =3D size;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.domain =3D AMDGPU_GEM_DOMAIN_GTT;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.flags =3D AMDGPU_GEM_CREATE_CPU_GT=
T_USWC;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.type =3D ttm_bo_type_kernel;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.resv =3D bo-&gt;tbo.base.resv;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.bo_ptr_size =3D sizeof(struct amdg=
pu_bo);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create(adev, &amp;bp,=
 &amp;bo-&gt;shadow);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bo-&gt;shadow-&gt;parent =3D amdgpu_bo_ref(bo);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_lock(&amp;adev-&gt;shadow_list_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_add_tail(&amp;bo-&gt;shadow-&gt;shadow_list, &amp;adev-&gt;=
shadow_list);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_unlock(&amp;adev-&gt;shadow_list_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
-}<br>
-<br>
&nbsp;/**<br>
&nbsp; * amdgpu_bo_create_user - create an &amp;amdgpu_bo_user buffer objec=
t<br>
&nbsp; * @adev: amdgpu device object<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.h<br>
index a7fbf5f7051e..b8555c527613 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
@@ -284,9 +284,6 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t amdgpu_bo_vm **ubo_ptr);<br>
&nbsp;void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; void **cpu_addr);<br>
-int amdgpu_bo_create_shadow(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; unsigned long size,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct amdgpu_bo *bo);<br>
&nbsp;int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);<br>
&nbsp;void *amdgpu_bo_kptr(struct amdgpu_bo *bo);<br>
&nbsp;void amdgpu_bo_kunmap(struct amdgpu_bo *bo);<br>
-- <br>
2.31.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB51365E1501638EC03C048D3F8B249DM4PR12MB5136namp_--

--===============1755351001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1755351001==--
