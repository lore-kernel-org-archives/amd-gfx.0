Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAA7C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 07:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6CCC64E4D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 07:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CCC64E4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 558CE89991;
	Mon, 15 Mar 2021 07:27:45 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319F389991
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 07:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XILtK6KeQC9CyqOyGd+JrEdOTgV/3eX2y0yyj+F6sdoMvB5LrZAyedCUwdeH93kiGvQ2qOQX7Y8Mt2Hi1ZqAkFYNivbK90POeRmjXyD7r7VIuWZiBVbKa0PAFAB7myX3IvaTtI90b8xMSmtjWOmMRaVVpZwBmMbSRjqaVX5qgrSLW6GGSENp6DY4EfmXhp78uva9m5taTQiZ+PMWKdINyApragTI5fZ0R57m4sG8v1wzHZ571VQJP39EXp42hMCMVQnPH+wOXSOT0mRRjJ1zOn9TFxUlvIWgWPy6PDwIYCYo+/kalCNs+MSFHOddlOfA7sapUr3B8tvozTW0jx7UJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eej07gnNolUWmoO4qyWxqZ0KRzgyER2v3kwtaHgWHHU=;
 b=F+5MHhmjLKai+d0dSvNjMrR/xJQnEsu6VYDDLpPVjyzYvyRm8uXVQsKkHZEYp18WIsq7rh7WJYpxT2nifEne2ha+SCrMpC83aM8KJ3lx6tQ0rhhF3ch1EZVLSBrCIYmj1aZQjLJKQvfLDUf14jlAYe1lYBsjFsvNGrhE6H8I/esNvL6LCULLYl/t0fmSZWM1STpCbRYn7Rw6H/2lAGL5SAdfIjcRYhJGhx/yh+UST3LwVES1mR/wG8cyeJpM74rnh6JdR/tc7BGREzATdBSh0N32COoThryS+9/ljF12PVUfJCyggUfBld69MEHYFdPkLwx1Bj9mEXaqhsTZ2ZkHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eej07gnNolUWmoO4qyWxqZ0KRzgyER2v3kwtaHgWHHU=;
 b=mYk9oqHW0L3o93X2GjezKecCPngXNdbGBcFltyWuZwy/nC38fcQEAH8Wm9wCiDJ4+kpgcUfrZPTrkdYRsLisp4c1MZzXysF9AWna7/Yq0DvMvirjVz0ZAu3P8TNicikY2ACYYqS21FjqGTWVdvzsEOj+/opZeGu4SF00qZQER00=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3772.namprd12.prod.outlook.com (2603:10b6:5:1c3::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 07:27:39 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 07:27:39 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Use DRM_INFO if VFCT table not valid
Thread-Topic: [PATCH] drm/amdgpu: Use DRM_INFO if VFCT table not valid
Thread-Index: AQHXGWbWkomabpIyEEmvpjik70X9NKqEogaAgAAEOfA=
Date: Mon, 15 Mar 2021 07:27:39 +0000
Message-ID: <DM6PR12MB4075B656A7D1D04BA2064D34FC6C9@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210315064541.4620-1-Feifei.Xu@amd.com>
 <DM6PR12MB460380E2364B359753ED5D00FE6C9@DM6PR12MB4603.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB460380E2364B359753ED5D00FE6C9@DM6PR12MB4603.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-15T07:27:36Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=55840098-5439-4e53-897e-10c34fce3185;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50279560-65f1-447c-0d96-08d8e783d026
x-ms-traffictypediagnostic: DM6PR12MB3772:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37723D946501D1EAD546B2C0FC6C9@DM6PR12MB3772.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t1lUSc0rXOr9QgklI2VBaLMlJEHomHKUCS4Cyg5ppkZ1yHbG+eebEj29Oa7ksnoAUYykzxBG3XzwkX7IdnCF0fiWNnfCkQ4Tuc9wZu7RWG7HOLHOnXTaEcc4QCTx+5uw2dXmwT1TBnBYvuVVUnt6u2Wcikmsnbmh3fJBeYLBVx4FkQglNN+3WBdxRx1cMRMBhX1jryLPO7yGRHnT8/zrwAmwU1Ba1f1Ozg1u+9Swlo7MT/tZNOvW/YttNw107kVhnYer+ZiqRN1W8VfqQULQAaPTv4WiXAh9DbwVyfcPBbBgJiNoOp7da/zbJ0/dke/1vXtHrWgwCjmVfEA1Iw6+9MUR0bYJb8f5DWc6h5DvTMDy8qFZ8GMjmMphz06bR9UDxi9ATCgUN4/UuVx0llaB3K00ZfjwlzIzeFm+RIF5C0kk6NxbR77nNgbqQfWZGrqd1bLFMiTAxnG0aDdSGA3wbUJhEsywoleKetwlpm5KHYuSgMNTF2UrXO2FHrj9KJvgAAjiwhpwp5Xsj9cwYttCVsG65353lt0lHQ/uQYHEb8h5gn8UQTKhCsLj86s+Oj+R
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(83380400001)(4326008)(52536014)(316002)(71200400001)(6506007)(8936002)(2906002)(9686003)(33656002)(7696005)(5660300002)(8676002)(53546011)(55016002)(110136005)(186003)(54906003)(66476007)(66556008)(66446008)(478600001)(76116006)(64756008)(26005)(66946007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ySNWqW4CeYD72OvAyo71C7OUHty61NQua5xKmZNxFagXuZMT71tlGeYCSw/c?=
 =?us-ascii?Q?hFaEfYkWmjLe0GjCjl7Doio8hdUEO2iWsE11sKiHNyu8Dfgq3MKPvSUJ+5jR?=
 =?us-ascii?Q?HkZLo37zIBoE8GdJPfhQFnqPKY84yeynyHp5p16B8kEiBoqD3z/s7MZymCk2?=
 =?us-ascii?Q?R4poov4mVO5Pvb+CHcPFjMGJV/VxQs1njJZEGVyU5T1kY6exqzH63cg53AHe?=
 =?us-ascii?Q?CTC8soYA5B8kGDsV9Cj0m8ORXxqFeaiRoTbLg6A5QUNZ3Ye1A2Vd8OBOwt2N?=
 =?us-ascii?Q?xUJjB61g10K/YmjqIK/pdk/ncpCad3/9RBMjJ4IvmNvresQr1xscwHwZRyus?=
 =?us-ascii?Q?I9WVZYjdh73g8cMAuWEIOhXPbJe1jw1THyHg/hC4QgRbTmZewBejqe6NBCTL?=
 =?us-ascii?Q?C9zbVhoZQcc7fLHWBeLGFOGi+uRLSYrvtqlbp83P8AO1bhWiu6zyPqC2fwfn?=
 =?us-ascii?Q?lBQ4nTIfiD1UywDEmcW7Ob02XKXrvspfBJnbZpRwKfGhJh1zzQBzP8nz/sXP?=
 =?us-ascii?Q?A0FxZPzwTeGxxL3u0cSki+sN9aPAn5c0K9t7QWWhwS02sqemsaLaOCmtsJbs?=
 =?us-ascii?Q?wxd9F0J4kyKYBgrtURueZcLQef0DJYkimkiGzcpA6nMC6wyUNgdl3kS4TdiI?=
 =?us-ascii?Q?BD6GByDhfxCAT0C9ESagfHxio6I0FX5wbbFbNNfLFAOVTletBDUstCzGa0MS?=
 =?us-ascii?Q?epP8tsNB0IjsjayxmM+Q1PTJnCx2zfWLuTNhOUhEcSbhHVcJPwBxsp4I2182?=
 =?us-ascii?Q?xhzQaRPp6wI2Cp+SGFy29/NoT/yB3ZFbHyTCezBgfzon2JRuf1+uLOyyz0Tg?=
 =?us-ascii?Q?LISWv2rmmAbohtz/Pbu0YoUV0hBF0kkadCLbMpFn5iDJwmIGyFVdejCN30zO?=
 =?us-ascii?Q?buarkE8HUIBqHR6xC65ZOKStC+FHwIUFrlnSYGUeJMasIqT35W00nGcRUlNn?=
 =?us-ascii?Q?IxED2ris1Lt7Yfh4IccqOcTVf2tyVvZo1Qgo27qzbXw+JbElBsE4aw61V8tF?=
 =?us-ascii?Q?ANCNUeVsZxnO94NOaDMf315bUL3RXVpKAOORfMSb+OdPkmI+S0Cr+mPtybIu?=
 =?us-ascii?Q?PACCG9gVjkswhC4+WeG0BRJ1vudT4nZCjKk2sfoDtknaurcSG1H9DkWvziCZ?=
 =?us-ascii?Q?p29QhAvRMkehzWdPkyGraGE/gLw2dHZtgzEfl7evczA7FBDBQ+8B+EJXtu92?=
 =?us-ascii?Q?f5vb/LBDfFZNLvivDSvqKlnd3aBM85Awbr3o+IFkuYD+NN98AZ+P141P32Sm?=
 =?us-ascii?Q?ymiLjceQkpb711CBddCWFoD05dGalln5APk/iJTjQ5EIfCMR7WXreSdOcuCR?=
 =?us-ascii?Q?X35OvA33c5TDM817vQkM5C4B?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50279560-65f1-447c-0d96-08d8e783d026
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 07:27:39.0398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a3Vbt5Dfjhhe9nmaCs6nYjsOKE7RkyP/+0HIicxAnR2SYysSX0OWifV0QIZaDMNsumOek+chQNXSjfORxDMKKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3772
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Might be better switch to dev_err so in mGPU setup there is bdf along with the warning/

Regards,
Hawking

-----Original Message-----
From: Xu, Feifei <Feifei.Xu@amd.com> 
Sent: Monday, March 15, 2021 15:11
To: Xu, Feifei <Feifei.Xu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use DRM_INFO if VFCT table not valid

[AMD Official Use Only - Internal Distribution Only]

Sorry, please ignore this one. I will draft a V2 to remove this one:
if (!adev->bios) {
-DRM_ERROR("Unable to allocate bios\n");
+DRM_INFO("Unable to allocate bios,skipping\n");
 return false;

Thanks,
Feifei

-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com>
Sent: Monday, March 15, 2021 2:46 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: Use DRM_INFO if VFCT table not valid

Some ASICs has no GOP driver to copy vbios image to VFCT table.
In this case, it will go to next check.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index f454a6bd0ed6..dde27b26a735 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -320,7 +320,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)

 adev->bios = kmalloc(size, GFP_KERNEL);  if (!adev->bios) { -DRM_ERROR("Unable to allocate bios\n");
+DRM_INFO("Unable to allocate bios,skipping\n");
 return false;
 }

@@ -368,7 +368,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)  return false;  tbl_size = hdr->length;  if (tbl_size < sizeof(UEFI_ACPI_VFCT)) { -DRM_ERROR("ACPI VFCT table present but broken (too short #1)\n");
+DRM_INFO("ACPI VFCT table present but broken (too short 
+#1),skipping\n");
 return false;
 }

@@ -381,13 +381,13 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)

 offset += sizeof(VFCT_IMAGE_HEADER);
 if (offset > tbl_size) {
-DRM_ERROR("ACPI VFCT image header truncated\n");
+DRM_INFO("ACPI VFCT image header truncated,skipping\n");
 return false;
 }

 offset += vhdr->ImageLength;
 if (offset > tbl_size) {
-DRM_ERROR("ACPI VFCT image truncated\n");
+DRM_INFO("ACPI VFCT image truncated,skipping\n");
 return false;
 }

@@ -410,7 +410,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)  }  }

-DRM_ERROR("ACPI VFCT table present but broken (too short #2)\n");
+DRM_INFO("ACPI VFCT table present but broken (too short 
+#2),skipping\n");
 return false;
 }
 #else
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
