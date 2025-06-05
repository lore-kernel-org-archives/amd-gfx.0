Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D93C5B543
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 07:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F31F10E93E;
	Thu,  5 Jun 2025 07:20:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jzLJiUBN";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E8610E933
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 07:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFueySKe+t0I5bKJxyMQih2Hd4+xDxk2V6jOShiBqIIw2ADLdGqbER4NH7qQjP+2TdfjtSuSqSoTILhDYOpeMNV4nbDC3wgydlMnHB/X3TBwsO5kZneEzOvj5Zu8xEXa0IqOm2eT3ofTutQXFHPcHRJiEv9svan9KqRSG5xTN7t9UCtNH3MO0PX0hWhW9qcSyeRWYzWC7J1aEgdLgzMgxl8C/MglqcXXby+/iNcFS17DYnfq5UrOCW6I+FqUPP+MJICe0IY9/cYtPXCMrBe8UNF6gn4xzXayJJNB8RWwNQHoF2g2QalUYzrSdhgSLAU8brFN5s9fxypxI7KfVJ2vuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uy0CMENDUHHo+GGOGNBgscTy2VHdtrmCyI6sS3qflTI=;
 b=DWL52aBXaKaIRp0uKeHT6glhCHutacO7L00SrWE1VWO5m5na7iwLSNG90934g8BXhxAWZoo9jsoYEt0A+C8ArpQvf3TqF32hBCG1OyZBI/ijk2NcVsTvDkwkTbPDlcGAvi3v/La4zGJBNsv7OV+i6p0NL6ZA0lp10gssOmSD7EsNTHRx8dV3/+sOgB/dNThRUh2vR0Ev8ZMxh6dokvleqJVkV70J39ALJI8WFwelgIA4zL/9DU9ZUNCHaZKjaLp9OMBI0ip4WAWSh29iZ04sbJEiceJAr+5MNKWlK/W8ZOVyIQEcRuq7i86wYdQzN2Z60OeYGI9oei8n11j7Whr4SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uy0CMENDUHHo+GGOGNBgscTy2VHdtrmCyI6sS3qflTI=;
 b=jzLJiUBNMXKajrb40mmpxUgzZg8D8Zt44KitxcFPYqedDhd2OViP+u42ikOujT5hT3LGqnDigB+wpEMxKlxkmIUL8/iMllqAs2rHRZexU1yOVtYkypoD34WUDmAbv6biURPwwYDwdB+3g7i+njzYpZ/8F3imBnnRQojbSkxnMd8=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Thu, 5 Jun
 2025 07:20:38 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%5]) with mapi id 15.20.8792.038; Thu, 5 Jun 2025
 07:20:38 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>
Subject: RE: [PATCH v3] drm/amdkfd: Move the process suspend and resume out of
 full access
Thread-Topic: [PATCH v3] drm/amdkfd: Move the process suspend and resume out
 of full access
Thread-Index: AQHb1SUN+3yi4SUyqUS/BxBpvAifgLP0Kinw
Date: Thu, 5 Jun 2025 07:20:37 +0000
Message-ID: <PH0PR12MB54178D04495A0F5D96B1DBA58F6FA@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250604074817.1444723-1-Emily.Deng@amd.com>
In-Reply-To: <20250604074817.1444723-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Horace.Chen@amd.com,Lijo.Lazar@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e283b701-15c8-4ef0-8677-b660297b1e9f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-05T07:19:51Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|MW4PR12MB7357:EE_
x-ms-office365-filtering-correlation-id: ecf8b782-5f5e-4d23-9b87-08dda401786e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/nwtE/qY9HtT4bxiNVGKyj4EOWguGoV54XGPxEx3bcOPX9lSS/HdRirG6srW?=
 =?us-ascii?Q?5B77tUGelbPOLBybPnHe1lch71EK+K7HdSRrldY+Zx2D/pdN0tjg/+0Jxc/k?=
 =?us-ascii?Q?tAKHJmdUINunNGvJBf1/qvjWFiFvddh886enXWANl85B278hzQckRKGN6YDH?=
 =?us-ascii?Q?b2ef+wT01lA366d0y9feK0M4g9HU+dd4ICpSEnTmxw3UoIu+R9Ncu1ft5X6G?=
 =?us-ascii?Q?dtdSRM7eKopXOH8U99lbjxYDaLUA5cExDUcmCzP/wYEN+k7GZMe2KJdYYOJG?=
 =?us-ascii?Q?M/DapNOlMfQFCsbHN+xYtObs3XmWQJ4IzRORhY7rRyhJ0bkx+QLVAyQgSPV8?=
 =?us-ascii?Q?2U/RoPs4Anfu3NB+RLw6Cf/oNVmb83u8CT7yrVMqvof7pZRR/2pDlkB0GS7o?=
 =?us-ascii?Q?7cE0CukxjQWAdknH2eLOqQJDMlKGaw3BjJjz4kGUo/KTof/9EorZFIPsdTA/?=
 =?us-ascii?Q?GpwuWFjlfxhrS/3GuTGdqhvQgFVmhKbpO71pTEGBhxFKb0yDWXiBFQSLR2iY?=
 =?us-ascii?Q?mMhIlus1P7es6ZOpU6ff6TIFhxZhIXJg+G84ZUy/gwfVMLdlbbIr1vYCRrpc?=
 =?us-ascii?Q?0kP1G17l+HJx1igX+t7XQALhvUyyAnsrPnPxOxFWk39UMLn1F/Si7kuxgBjd?=
 =?us-ascii?Q?yqN+pt0GiIjLi/SaUNiL5VuVuLIysgzllYBkdLT0LdPsRnNcR7TyrpYX8A1j?=
 =?us-ascii?Q?XDQ24bcwqU42wjuHrgdsmLn4aqvno/f2VZs5QDkC2Ji7P7UZhSbTvWqWpzAu?=
 =?us-ascii?Q?Wmsftny0htG4QGU2xuij5ClDaFWOvu6m4s9gR0tun84lwoVKNG8m9KWZ1VW5?=
 =?us-ascii?Q?DJTi0znKF8ixLZcFZg7HT4etM+ZIkNY07SqYS+8q6lM2SG0MPEPr1lYkkSMS?=
 =?us-ascii?Q?DlGPmtj4fhSEWADO1/N0ztTvv4bHAFAgy33YiIJ5kvHgRby4mvBc0U87FqUz?=
 =?us-ascii?Q?5vyKWC8jFHdVZS5myqwiP8aqxlzmh1kWjIku7eudIDd+jdS7nkT5OJc6q+Xx?=
 =?us-ascii?Q?Vt8o1JP+0rH17S4TwzWx9Ul70Uf5NaylWsssaUqk64x1izy1qMHAh3HD2bav?=
 =?us-ascii?Q?qII59zUpFx0Al6Ftfvnwc0QiIHhuT1mFi6lo1Am9Grv/Sn8eq7ucfxJokgSt?=
 =?us-ascii?Q?4q7xkR1005OfKA1xnKUhkNOqst1/EDTFCf1EQhzug4+X5sMdCc9DEx28KX/K?=
 =?us-ascii?Q?9SzgivmoOYrGja/cTJCjRHJH9LrySiEOrKAj56VATcRlhN9KlfZgYz1T8h1x?=
 =?us-ascii?Q?smzumJWuMZ0llsM8lmnPgmc/vTDNE8rdi7C3anq0FQXJpaw5mfgVWP9eQKlt?=
 =?us-ascii?Q?u1DbWgLIt2oZe3Uh/rrPFE/YN98mq7C9ycNGQK+23zY2ZrfIdhuKdOH/xtwe?=
 =?us-ascii?Q?oZdcj/XxlaCYjG1Q1CHJkRR5RbNwCAKBqSsEY1dwxUEYzqauwVcuhA2nlcTs?=
 =?us-ascii?Q?JpWWyY+VTELEyzpXKZ/cBb3hoJatcZoVFipG7kAy9jPsKCvHi2JxZXs2HL8B?=
 =?us-ascii?Q?y2PHZABHwizKZYg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZEdYfDbQkHj2BOhnnJijt9ztsh0XkI6n6CtTy26W5R5etRifywcQ3yGb1Cwr?=
 =?us-ascii?Q?lXMNddlOsYU3Yo61Ram4b5LvvCiO9ly8ofox5ZmHyzHOTplrVD8fovOrG4NZ?=
 =?us-ascii?Q?OqTYNxG75h9+7wMmgNLKfSn3XMwK5oasdR35JMKakQvy24iPJyxKxtL5YVv2?=
 =?us-ascii?Q?eHoBLKde7UxBR5vMiG9ITUSl8a6raFgMsHIK7nWlUJo8j405KC+lL5EXpIEH?=
 =?us-ascii?Q?LqEPd10cXT3K3/XVhYVPO5QsqwhLlRJdr9ZFmELmg6E7qLn5/V/u/leBcunL?=
 =?us-ascii?Q?v+4gf0fZsaCTR0ftIeFsXM7KEU1Nvf6uH1IPeZzdDFZZkb5X88F4JyHeeg+N?=
 =?us-ascii?Q?bHIOehD+21ti/fNQvrVJfs1ACxRvJZBExxG+ohnLhoaEBVR2RvEzljB+35Sf?=
 =?us-ascii?Q?19ZXKhyCsmbbK/rsv1tn9eEFiey6eJeMoF7NV4Dn0QuEaxTb55T9lVUD2/4K?=
 =?us-ascii?Q?N7AW/peTeLBU857BspH87wrVdwm9sS4Rwejf6aev/igbahEVOinkcTpw2i85?=
 =?us-ascii?Q?p2Jljo0277dJDeTS48te55SDX1mbyMkzOlce75pOe+WgtJPKy5YqgjMozoJI?=
 =?us-ascii?Q?dvZ2594TXcI5Qi8BcK2/FxJKUBgyBDwvc6udxxe4zeIwrP10CH1nzOvOm1zj?=
 =?us-ascii?Q?OaXRXhZB/RQPzG7ihVHEf/9qUm3rJ6aFclUIFXvaCErz+jmwGbGfcbGGHivB?=
 =?us-ascii?Q?BhJ21w3GSLacLrLO+yvhnrOGwLDoZuBmjVYtY2S6p5QHip4KNmwZlTUuTXvm?=
 =?us-ascii?Q?XjufiiixzIor8/ZMtubkt19XsJWMsbUvWRDz1Vb8nrWYfzfxWirhyYhujDUp?=
 =?us-ascii?Q?qjLtDszlc3Fy07eAP7xBMLpL0zXl1yKM/YmrzQbO7m9PhgllRPbnZ7S+rbhH?=
 =?us-ascii?Q?yEJ+XFpQL9nsd1XXI0P2a7KSALwpsPQiK87i0ae5J6UHVMtfHji2NFoiOwXD?=
 =?us-ascii?Q?pS3o4klVJt58bO7Roj/EtHmREc1uI0TTUmw0wNuOJcIrO70w2H2e6QUpFKgq?=
 =?us-ascii?Q?cUjEFbYHe3vbIpEWuYTRLSeEPlz7/WqPM6pUDKzdbD3O14qAvGD+cdUrMPlE?=
 =?us-ascii?Q?fei0aGQMpEYRvBuSaU3CDEHXyNumCaCdqasXGNrccrkBab0G0JcnBPP3Ju0E?=
 =?us-ascii?Q?j6BPDxH3GkCWr+8+BQcj1BDoz76ujJBSm94emceP3vdouzM1muoDQMAS6hu1?=
 =?us-ascii?Q?OKnFZzb25jVqbqcNtmaWyFWaMioyrXTYw5nAcgcSHTdHutulpLFeKB0NUFKf?=
 =?us-ascii?Q?tymIh9889GtRQVD5pk+6NWCP3xrOrpPweUw0WMnczXSMq8zYZFB0krQ3Amwe?=
 =?us-ascii?Q?T6BPPVfqcDDcTxr14bZ1opVfT1qbfTy6XrkptQz+P7UsUM47xDHKaFE+Fd4N?=
 =?us-ascii?Q?Qg+QXUTm9FX74Iuzc8G9x5SvceN51eiKs8lKAwjLt0UTjQIhQHbKvHa8KXCc?=
 =?us-ascii?Q?SUG29fOPTpY6bRgwsLLShRGD9sqap1XDkipaWWq6eksUoSCqHBYwUQSmS/S3?=
 =?us-ascii?Q?p8oMfM4K7qzp0ihWiNBcfn64YTXSPTPsfU1VlKDU91crRZXVbo8C4UyD7LPV?=
 =?us-ascii?Q?vjSSY+8ZwMVj4YJlHoE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf8b782-5f5e-4d23-9b87-08dda401786e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 07:20:37.8516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /aNN4/CUKnuFzlnry3cnQJQoa/ExqGxhp1nb2aGKoEQTzKAAgjJqTn31eXLPFix2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
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

[AMD Official Use Only - AMD Internal Distribution Only]

@Lazar, Lijo and @Chen, Horace
 Could you help to review again, thanks?

Emily Deng
Best Wishes



>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Wednesday, June 4, 2025 3:48 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH v3] drm/amdkfd: Move the process suspend and resume out of=
 full
>access
>
>For the suspend and resume process, exclusive access is not required.
>Therefore, it can be moved out of the full access section to reduce the du=
ration of
>exclusive access.
>
>v3:
>Move suspend processes before hardware fini.
>Remove twice call for bare metal.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 16 +++++++++
>drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 13 +++++++
>drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  9 +++--
> drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 40 +++++++++++++++++-----
> 4 files changed, 67 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>index d8ac4b1051a8..0a8e7835d0fc 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>@@ -264,6 +264,22 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev,
>bool run_pm)
>       return r;
> }
>
>+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool
>+run_pm) {
>+      if (adev->kfd.dev)
>+              kgd2kfd_suspend_process(adev->kfd.dev, run_pm); }
>+
>+int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev, bool
>+run_pm) {
>+      int r =3D 0;
>+
>+      if (adev->kfd.dev)
>+              r =3D kgd2kfd_resume_process(adev->kfd.dev, run_pm);
>+
>+      return r;
>+}
>+
> int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
>                           struct amdgpu_reset_context *reset_context)  { =
diff --git
>a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>index b6ca41859b53..841ae8b75ab1 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>@@ -156,6 +156,8 @@ void amdgpu_amdkfd_fini(void);
>
> void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);  int
>amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool
>+run_pm); int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev,
>+bool run_pm);
> void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>                       const void *ih_ring_entry);
> void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev); @@ -413,6
>+415,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,  void
>kgd2kfd_device_exit(struct kfd_dev *kfd);  void kgd2kfd_suspend(struct kfd=
_dev *kfd,
>bool run_pm);  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
>+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm); int
>+kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm);
> int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>                     struct amdgpu_reset_context *reset_context);  int
>kgd2kfd_post_reset(struct kfd_dev *kfd); @@ -463,6 +467,15 @@ static inlin=
e int
>kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>       return 0;
> }
>
>+static inline void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool
>+run_pm) { }
>+
>+static inline int kgd2kfd_resume_process(struct kfd_dev *kfd, bool
>+run_pm) {
>+      return 0;
>+}
>+
> static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>                                   struct amdgpu_reset_context *reset_cont=
ext)  { diff --
>git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 5289400879ec..08ff9917c62f 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -5061,6 +5061,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bo=
ol
>notify_clients)
>       adev->in_suspend =3D true;
>
>       if (amdgpu_sriov_vf(adev)) {
>+              if (!adev->in_s0ix)
>+                      amdgpu_amdkfd_suspend_process(adev, adev->in_runpm)=
;
>               amdgpu_virt_fini_data_exchange(adev);
>               r =3D amdgpu_virt_request_full_gpu(adev, false);
>               if (r)
>@@ -5080,7 +5082,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bo=
ol
>notify_clients)
>       amdgpu_device_ip_suspend_phase1(adev);
>
>       if (!adev->in_s0ix) {
>-              amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>+              amdgpu_amdkfd_suspend(adev, amdgpu_sriov_vf(adev) || adev-
>>in_runpm);
>               amdgpu_userq_suspend(adev);
>       }
>
>@@ -5178,7 +5180,7 @@ int amdgpu_device_resume(struct drm_device *dev, boo=
l
>notify_clients)
>       }
>
>       if (!adev->in_s0ix) {
>-              r =3D amdgpu_amdkfd_resume(adev, adev->in_runpm);
>+              r =3D amdgpu_amdkfd_resume(adev, amdgpu_sriov_vf(adev) ||
>+adev->in_runpm);
>               if (r)
>                       goto exit;
>
>@@ -5197,6 +5199,9 @@ int amdgpu_device_resume(struct drm_device *dev, boo=
l
>notify_clients)
>       if (amdgpu_sriov_vf(adev)) {
>               amdgpu_virt_init_data_exchange(adev);
>               amdgpu_virt_release_full_gpu(adev, true);
>+
>+              if (!adev->in_s0ix && !r)
>+                      r =3D amdgpu_amdkfd_resume_process(adev, adev->in_r=
unpm);
>       }
>
>       if (r)
>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>index bf0854bd5555..22c6ef7c42b6 100644
>--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>@@ -1027,15 +1027,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_=
pm)
>       if (!kfd->init_complete)
>               return;
>
>-      /* for runtime suspend, skip locking kfd */
>-      if (!run_pm) {
>-              mutex_lock(&kfd_processes_mutex);
>-              /* For first KFD device suspend all the KFD processes */
>-              if (++kfd_locked =3D=3D 1)
>-                      kfd_suspend_all_processes();
>-              mutex_unlock(&kfd_processes_mutex);
>-      }
>-
>+      kgd2kfd_suspend_process(kfd, run_pm);
>       for (i =3D 0; i < kfd->num_nodes; i++) {
>               node =3D kfd->nodes[i];
>               node->dqm->ops.stop(node->dqm);
>@@ -1055,6 +1047,36 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm=
)
>                       return ret;
>       }
>
>+      ret =3D kgd2kfd_resume_process(kfd, run_pm);
>+
>+      return ret;
>+}
>+
>+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm) {
>+      struct kfd_node *node;
>+      int i;
>+
>+      if (!kfd->init_complete)
>+              return;
>+
>+      /* for runtime suspend, skip locking kfd */
>+      if (!run_pm) {
>+              mutex_lock(&kfd_processes_mutex);
>+              /* For first KFD device suspend all the KFD processes */
>+              if (++kfd_locked =3D=3D 1)
>+                      kfd_suspend_all_processes();
>+              mutex_unlock(&kfd_processes_mutex);
>+      }
>+}
>+
>+int kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm) {
>+      int ret, i;
>+
>+      if (!kfd->init_complete)
>+              return 0;
>+
>       /* for runtime resume, skip unlocking kfd */
>       if (!run_pm) {
>               mutex_lock(&kfd_processes_mutex);
>--
>2.34.1

