Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF18DC433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 16:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A1361942
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 16:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A1361942
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D066EA51;
	Fri, 19 Mar 2021 16:45:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 810866EA51
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 16:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEjXrRvevuD/nueAv0OJso3AZZfWY3ARrwY5IQt0GpdbVmuW8h3yH3jvN2s4gEtY41mpF5OkBD8yO2WTasCrTXbq6vsq7BHkdaJTyHmh8SCrGCEFJD8Zi+lG9jcWOWk8aSovjE+yzvEs5bog+77t3NcTofJFevFcqCEDQodcx+pU/xMSko6Z0S3VviJFrj0e4Fy08LYqaSfHWwrIBxXVQyFeVYYG9ht4t8iMORfbI5JCCIbqWznw7ULB2PSZRyQuOhJFEaO+ofbvRA1o0EmtPmOG0w06uGHjHXIIWpvSMXnLNDX62ASPUAu5bSTDRa7A09A3PGypa76oHEOIbPxMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyNOKFxlHaWVvbmqTCysBuIuHppkIUoLYlTlrk/gb4s=;
 b=VqwHzUruNQ0qWLAtAZQ+6D/GyVVCe/4jTqHPp4H/ozC19kpAe3YfXtzH1+2N7XMBFn6ac0xEH2tzqWW4kU8XbO1qPdILJfnlpjlLdnUM6eu6wDepDOH5KIFG66GPBnK6LrxKug2rXX68kY8cJVipgpLSN5zp1meWoSwh0a1JiIfOgKZIHJjVhM2IuNRXss6E9ZvUKPED5oUdmtVSlyPIh5XrjtNLUkQQlGbL3guVaOwqwNL7Bq1mUwhAdlBhE1+qxgvcqyRplT4xt/USnNCs6REAH+4D4dOSQC4aYm/y6WWZ+gz0BKk7mIr5Oj/x4UDD1fVwKyRkyP5++u1ZZ454lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyNOKFxlHaWVvbmqTCysBuIuHppkIUoLYlTlrk/gb4s=;
 b=4585Gu+WcyQ+TWOID0mApiPXXxNoAg7ByfhKA5Gn5rFGwoKwky466HFa93R2Z/tEG+CUK+Q0M0ULvzz2StXPuOtJSjRFaR98nG2E4IRxC5Dp2TdoGswNKJtZqJBk+885Ksv72c1LPnXL5/WZ92SqWMvpc2ZZNat3NmTjScSmRYk=
Received: from MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 by MWHPR1201MB2510.namprd12.prod.outlook.com (2603:10b6:300:e8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 16:45:34 +0000
Received: from MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::a10d:f9c9:4529:6422]) by MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::a10d:f9c9:4529:6422%8]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 16:45:34 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: disable runpm if other reset method not
 runpm capable is chosen
Thread-Topic: [PATCH 2/2] drm/amdgpu: disable runpm if other reset method not
 runpm capable is chosen
Thread-Index: AQHXHKAB9o9/PmV/nkGZU7mShcDHKKqLLE+AgABYtKs=
Date: Fri, 19 Mar 2021 16:45:34 +0000
Message-ID: <MW3PR12MB4491B515900092DED297EBC7F7689@MW3PR12MB4491.namprd12.prod.outlook.com>
References: <20210319091155.537787-1-evan.quan@amd.com>
 <20210319091155.537787-2-evan.quan@amd.com>,
 <MN2PR12MB45492A307D0D53E9ED04F1F197689@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB45492A307D0D53E9ED04F1F197689@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-19T16:45:33.368Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c04db5cd-dd28-4bb6-80cb-08d8eaf66a7f
x-ms-traffictypediagnostic: MWHPR1201MB2510:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB25109C153E1AC75A1633A8C4F7689@MWHPR1201MB2510.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RrqkLufsoJTASdgGfkd5uFXs9GwIVg6SzZtEFiR7KnZ07BhO+ypL2/p53Zfbs9VEKSp5Z9fsMAqZAN0GT2vIreHhLDU38Fyp/tVvMXAa5FEM6iU+TkkgQT5OJRnwzPw2j02iag1Va2C8lLehW0xsCoQpx/9Mwk+Xw+EMPzRLX1oa3eWE7b6LovyLuhE9aPPl/jxFtPF+SqtdzrrMSk9QfL31sA3MBC4G/ub2fHsLHTgmzircDAn1sl0wosOlQPjICY2AMi9YAwZ8jB96MCpSHvD38c2t6au+0Jurj3855smKMpM7iCenOlDA6QDtu+BLeofiBELuue/Kxp0TlUmr1XbsovvSOrx9BmoBT4obUVYKdHC0MhTGPl7Lz7HxpSFFKigXWeIzkP3Xg5zdAmJndihiJ2SuasYVAI/KKh273xr5VpuPlisJWs91Kq9jXHZrn3tCs0qyojgZhC9OPkKsuFfe7Rb2fG+p01YpO8Y5A8XhKWC9VwSKBVuhJp0Kzugap3RRmLoY4xJDso5Vu4qE4f5nvZLDvuAy70w/9xq4tWYzT+aw924Gsg5Yu7YFN3qYsnh4QNKEwNL+YQAO2xiQjUm6yMPPLmmQEpnKQlQF7uw4/wg/sqdwfrvxO+AIfBaqeNr+Ey9wRk64QPt/8h7aGX1R/i1MQ5Ix5/aQuXdkbR3yBqpFz5mlbZ9jW/xz5zkC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(76116006)(66556008)(66446008)(38100700001)(66946007)(66476007)(7696005)(6506007)(166002)(53546011)(55016002)(86362001)(52536014)(9686003)(2906002)(45080400002)(316002)(5660300002)(478600001)(110136005)(71200400001)(26005)(8676002)(186003)(19627405001)(33656002)(966005)(8936002)(64756008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PctmsKpslLPuXL/Q3cv68UhiLencRWLEVmbsUKqvtN4T45zuAJwMsxIj1baG?=
 =?us-ascii?Q?AyM1PxrVcvm8Xp0ErJzpV1vCl4wVBJr5nkyXv/fP7T3htwG7M4IA+dGsNrpI?=
 =?us-ascii?Q?S5jRaIDKyVUxFYdziIMHHRPMo/XHeqvf77+S2U/7XoKbu2HC7YBhbrHdqc+v?=
 =?us-ascii?Q?X5DyHeG+f7E8itb3y/M9boHdHMXzuCm1dgWueg0VC4De7KMNBqSKe3jUBX4g?=
 =?us-ascii?Q?EFaBAL27DFjm/LBQpRcxbwFjxsdlBuMTNZFIupsKMojK8TbTfhFkQaknNbUp?=
 =?us-ascii?Q?2DBmsUapS21QqLRb6uS9DKrgSBFyB8ZBRqgt1dgYXuFvXlcAXT9KlfrBk2HG?=
 =?us-ascii?Q?YxxSNfePRfMRcrNaNMksAxUkz6iD3VBoR4FrVTYjSm5TzPfSSvf/CD9vxpn8?=
 =?us-ascii?Q?gFYd83nrVszBKw3+9m2Q245LDd83buAKmG4EAowXjlkN5gqeKRTvPpN16n6v?=
 =?us-ascii?Q?yfk8gXmLMwXjRFfCqfr1jJTCzjCiAtS4cN60oiYC2Ha3hd+4OFbG4FSwSigz?=
 =?us-ascii?Q?B1nyU69yxDNpMqwPfxw+kiCFRnLMaBqBS6hPslUjAjdUmUMQjIcJF4mINPb9?=
 =?us-ascii?Q?aqaA107Z2XJ3j0gs5OfD//j2AUWBa2LrTcHvsJaHE5tkfKBHtORwLAXQhhMn?=
 =?us-ascii?Q?RReoUr5/iUUqzTIDYZCc1n2KU/fGOFCVZVJZUuVAl48pGnhSzPgNSB03zul6?=
 =?us-ascii?Q?a2EHZLsoX5cx+0pCb6uOIoWelRAGrTB5tOnTun6wUzU2r4rbpOKJfJwJfB5k?=
 =?us-ascii?Q?Wxw4CsOby25SkicVZGGDl/7j6QL/tsID17kajR2FBtR0c7JX5VSDAFJWJV1h?=
 =?us-ascii?Q?t7JGQTQ2eQbxgRAwDJba2q/0jQJP9JIn8wUuglXbr6Gp9KeOenhcKjGkTQm4?=
 =?us-ascii?Q?5mRI3uBnWG3mGAIUufbT7E1V/a7nllnWr4IU1p97fowa4iUPfvoXkj+PQyui?=
 =?us-ascii?Q?/ABvWd7N4r9glhYJAxkzZ5N1Usbr/a6cuTSzRfJUyjOXAuTjgBs086M/7axa?=
 =?us-ascii?Q?U7/JbWWfY5yGGvK3BdD3+/hgFo2ZGWiDuvfHyOJ+ShLFcuJNsdQcljHnVBVl?=
 =?us-ascii?Q?ps7hxEd8QEXJ7+5SxCqbZLxmssG+pIVaCVT14t9wet2CS2IGOyXDnC/E1aET?=
 =?us-ascii?Q?eurxbJ5qROQ02AJulPGQYgXKnZDcsUGfPsR0pIBUDuu2IpBC2hwmhvViloTz?=
 =?us-ascii?Q?+BYughb4wLRLihtRUTl8CD2+XTymzMb/Y2zB3VtcDrZEcreIPgZflFaHaLV1?=
 =?us-ascii?Q?NOSR+Z1HuKYlzzWACk5uZbsO5TJ8fL3SO++uYh1SCEiaupGLnkn37aRCfuli?=
 =?us-ascii?Q?EHIc+sZ4gfNriMZwTE0kHQPy?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04db5cd-dd28-4bb6-80cb-08d8eaf66a7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 16:45:34.0808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RU5OjPQz1ee0T/+WyutYFQ8PFmLYy5t2M30NNd3ScvkxknXyj3QeTFQ2NKAxjxHLRawbWp52C810c31SBFk0FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2510
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
Content-Type: multipart/mixed; boundary="===============0000628482=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0000628482==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4491B515900092DED297EBC7F7689MW3PR12MB4491namp_"

--_000_MW3PR12MB4491B515900092DED297EBC7F7689MW3PR12MB4491namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Yeah, the reset method is independent of whether we can use BACO for runtim=
e PM.  We can use BACO for power saving and use mode1 for reset.  Is there =
some issue I'm missing?

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lazar, L=
ijo <Lijo.Lazar@amd.com>
Sent: Friday, March 19, 2021 7:27 AM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: disable runpm if other reset method no=
t runpm capable is chosen

[AMD Public Use]



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Friday, March 19, 2021 2:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: disable runpm if other reset method not ru=
npm capable is chosen

Otherwise, the runpm will be always enabled on a BACO capable target even t=
he reset method was forced as like mode1.

Change-Id: If6bf55c533e91470c9c83383788466161608f68d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-  drivers/gpu/drm/amd/amdgpu=
/amdgpu_kms.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/cik.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c         | 2 +-
 drivers/gpu/drm/amd/amdgpu/si.c         | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c         | 2 +-
 8 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 963ecfd84347..be12dd2550b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -589,6 +589,7 @@ struct amdgpu_allowed_register_entry {  };

 enum amd_reset_method {
+       AMD_RESET_METHOD_AUTO =3D -1,
         AMD_RESET_METHOD_LEGACY =3D 0,
         AMD_RESET_METHOD_MODE0,
         AMD_RESET_METHOD_MODE1,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 6a06234dbcad..78e5445b28b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -168,7 +168,7 @@ int amdgpu_noretry =3D -1;  int amdgpu_force_asic_type =
=3D -1;  int amdgpu_tmz =3D -1; /* auto */  uint amdgpu_freesync_vid_mode; =
-int amdgpu_reset_method =3D -1; /* auto */
+int amdgpu_reset_method =3D AMD_RESET_METHOD_AUTO; /* auto */
 int amdgpu_num_kcq =3D -1;

 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work=
); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_kms.c
index 8844f650b17f..49068ad698a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -168,6 +168,8 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, =
unsigned long flags)
                 adev->runpm =3D true;
                 dev_info(adev->dev, "Using BOCO for runtime pm\n");
         } else if (amdgpu_device_supports_baco(dev) &&
+                  (amdgpu_reset_method =3D=3D AMD_RESET_METHOD_AUTO ||
+                   amdgpu_reset_method =3D=3D AMD_RESET_METHOD_BACO) &&

< > Why to link runpm suspend method with reset method?

Thanks,
Lijo
                    (amdgpu_runtime_pm !=3D 0)) {
                 switch (adev->asic_type) {
                 case CHIP_VEGA20:
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/=
cik.c
index c0fcc41ee574..e671871f4d28 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1395,7 +1395,7 @@ cik_asic_reset_method(struct amdgpu_device *adev)
             amdgpu_reset_method =3D=3D AMD_RESET_METHOD_BACO)
                 return amdgpu_reset_method;

-       if (amdgpu_reset_method !=3D -1)
+       if (amdgpu_reset_method !=3D AMD_RESET_METHOD_AUTO)
                 dev_warn(adev->dev, "Specified reset:%d isn't supported, u=
sing AUTO instead.\n",
                                   amdgpu_reset_method);

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index 2670ae00c2e5..1e751d415f15 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -529,7 +529,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
             amdgpu_reset_method =3D=3D AMD_RESET_METHOD_PCI)
                 return amdgpu_reset_method;

-       if (amdgpu_reset_method !=3D -1)
+       if (amdgpu_reset_method !=3D AMD_RESET_METHOD_AUTO)
                 dev_warn(adev->dev, "Specified reset method:%d isn't suppo=
rted, using AUTO instead.\n",
                                   amdgpu_reset_method);

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/s=
i.c index 7cbc2bb03bc6..b9db761a7cc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1420,7 +1420,7 @@ si_asic_reset_method(struct amdgpu_device *adev)
         if (amdgpu_reset_method =3D=3D AMD_RESET_METHOD_PCI)
                 return amdgpu_reset_method;
         else if (amdgpu_reset_method !=3D AMD_RESET_METHOD_LEGACY &&
-                amdgpu_reset_method !=3D -1)
+                amdgpu_reset_method !=3D AMD_RESET_METHOD_AUTO)
                 dev_warn(adev->dev, "Specified reset method:%d isn't suppo=
rted, using AUTO instead.\n",
                          amdgpu_reset_method);

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index c354a11e2fd9..ad11f2e1f4db 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -689,7 +689,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
                 return amdgpu_reset_method;
         }

-       if (amdgpu_reset_method !=3D -1)
+       if (amdgpu_reset_method !=3D AMD_RESET_METHOD_AUTO)
                 dev_warn(adev->dev, "Specified reset method:%d isn't suppo=
rted, using AUTO instead.\n",
                                   amdgpu_reset_method);

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/v=
i.c index ea338de5818a..6b380a25e22e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -895,7 +895,7 @@ vi_asic_reset_method(struct amdgpu_device *adev)
             amdgpu_reset_method =3D=3D AMD_RESET_METHOD_BACO)
                 return amdgpu_reset_method;

-       if (amdgpu_reset_method !=3D -1)
+       if (amdgpu_reset_method !=3D AMD_RESET_METHOD_AUTO)
                 dev_warn(adev->dev, "Specified reset method:%d isn't suppo=
rted, using AUTO instead.\n",
                                   amdgpu_reset_method);

--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C5cacb7cb280c4055647a08d8eac9edbc%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637517500293380275%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D93jzFipkAGazXCqwfxbKUkvTDUHmuSZT6cNAcymg%2BRQ%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C5cacb7cb280c4055647a08d8eac9edbc%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637517500293380275%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D93jzFipkAGazXCqwfxbKUkvTDUHmuSZT6cNAcymg%2BRQ%3D&amp;reserved=3D0

--_000_MW3PR12MB4491B515900092DED297EBC7F7689MW3PR12MB4491namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yeah, the reset method is independent of whether we can use BACO for runtim=
e PM.&nbsp; We can use BACO for power saving and use mode1 for reset.&nbsp;=
 Is there some issue I'm missing?<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Lazar, Lijo &lt;Lijo.Lazar@am=
d.com&gt;<br>
<b>Sent:</b> Friday, March 19, 2021 7:27 AM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: disable runpm if other reset me=
thod not runpm capable is chosen</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ev=
an Quan<br>
Sent: Friday, March 19, 2021 2:42 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu: disable runpm if other reset method not ru=
npm capable is chosen<br>
<br>
Otherwise, the runpm will be always enabled on a BACO capable target even t=
he reset method was forced as like mode1.<br>
<br>
Change-Id: If6bf55c533e91470c9c83383788466161608f68d<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp; | 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-&nbsp; drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c | 2 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/cik.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/si.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 =
+-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 2 +-<br>
&nbsp;8 files changed, 9 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 963ecfd84347..be12dd2550b8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -589,6 +589,7 @@ struct amdgpu_allowed_register_entry {&nbsp; };<br>
&nbsp;<br>
&nbsp;enum amd_reset_method {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_RESET_METHOD_AUTO =3D -1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_RESET_METHOD_LEGACY =
=3D 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_RESET_METHOD_MODE0,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_RESET_METHOD_MODE1,<br=
>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 6a06234dbcad..78e5445b28b5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -168,7 +168,7 @@ int amdgpu_noretry =3D -1;&nbsp; int amdgpu_force_asic_=
type =3D -1;&nbsp; int amdgpu_tmz =3D -1; /* auto */&nbsp; uint amdgpu_free=
sync_vid_mode; -int amdgpu_reset_method =3D -1; /* auto */<br>
+int amdgpu_reset_method =3D AMD_RESET_METHOD_AUTO; /* auto */<br>
&nbsp;int amdgpu_num_kcq =3D -1;<br>
&nbsp;<br>
&nbsp;static void amdgpu_drv_delayed_reset_work_handler(struct work_struct =
*work); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_kms.c<br>
index 8844f650b17f..49068ad698a6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -168,6 +168,8 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, =
unsigned long flags)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;runpm =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;Using BOCO for runtime p=
m\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (amdgpu_device_s=
upports_baco(dev) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_reset_method =3D=3D AMD_RESET_METHOD_A=
UTO ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_method =3D=3D AMD_RESET_MET=
HOD_BACO) &amp;&amp;<br>
<br>
&lt; &gt; Why to link runpm suspend method with reset method?<br>
<br>
Thanks,<br>
Lijo<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_runtime_pm !=3D 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/=
cik.c<br>
index c0fcc41ee574..e671871f4d28 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/cik.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c<br>
@@ -1395,7 +1395,7 @@ cik_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_reset_method =3D=3D AMD_RESET_METHOD_BACO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_reset_method;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method !=3D -1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method !=3D AMD_RESE=
T_METHOD_AUTO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Specified reset:%d isn't=
 supported, using AUTO instead.\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_method)=
;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index 2670ae00c2e5..1e751d415f15 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -529,7 +529,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_reset_method =3D=3D AMD_RESET_METHOD_PCI)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_reset_method;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method !=3D -1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method !=3D AMD_RESE=
T_METHOD_AUTO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Specified reset method:%=
d isn't supported, using AUTO instead.\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_method)=
;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/s=
i.c index 7cbc2bb03bc6..b9db761a7cc5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/si.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/si.c<br>
@@ -1420,7 +1420,7 @@ si_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method =
=3D=3D AMD_RESET_METHOD_PCI)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_reset_method;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (amdgpu_reset_meth=
od !=3D AMD_RESET_METHOD_LEGACY &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; amdgpu_reset_method !=3D -1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; amdgpu_reset_method !=3D AMD_RESET_METHOD_AUTO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Specified reset method:%=
d isn't supported, using AUTO instead.\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 amdgpu_reset_method);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index c354a11e2fd9..ad11f2e1f4db 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -689,7 +689,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_reset_method;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method !=3D -1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method !=3D AMD_RESE=
T_METHOD_AUTO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Specified reset method:%=
d isn't supported, using AUTO instead.\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_method)=
;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/v=
i.c index ea338de5818a..6b380a25e22e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
@@ -895,7 +895,7 @@ vi_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_reset_method =3D=3D AMD_RESET_METHOD_BACO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_reset_method;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method !=3D -1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method !=3D AMD_RESE=
T_METHOD_AUTO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Specified reset method:%=
d isn't supported, using AUTO instead.\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_method)=
;<br>
&nbsp;<br>
--<br>
2.29.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C5cacb7cb280c4055647a08d8eac9edbc%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637517500293380275%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D93jzFipkAGazXCqwfxbKUkvTDUHmuSZT6cNAcymg%2BRQ%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C5cacb7cb280c4055647a08d8eac9ed=
bc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637517500293380275%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3D93jzFipkAGazXCqwfxbKUkvTDUHmuSZT6cNAcymg%2BR=
Q%3D&amp;amp;reserved=3D0</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C5cacb7cb280c4055647a08d8eac9edbc%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637517500293380275%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D93jzFipkAGazXCqwfxbKUkvTDUHmuSZT6cNAcymg%2BRQ%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C5cacb7cb280c4055647a08d8eac9ed=
bc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637517500293380275%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3D93jzFipkAGazXCqwfxbKUkvTDUHmuSZT6cNAcymg%2BR=
Q%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB4491B515900092DED297EBC7F7689MW3PR12MB4491namp_--

--===============0000628482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0000628482==--
