Return-Path: <SRS0=VOM3=FU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E8AC4361B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Dec 2020 02:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87969230FF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Dec 2020 02:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87969230FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9247A8991E;
	Wed, 16 Dec 2020 02:12:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A61858991E
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Dec 2020 02:12:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVCoDF3UABD8cvfjDCFNKtJNIH+0tMQmtu0jb3b92loEUog/ldiqzoKHvT0WhL5jprtMmpWJDjteajcf0gye3pGZBaeZMxqPeHclVaCodSQ8P4oMIVaMS3Ly3thlgkDyOhx6ueU/d+GoOg6O91gEcBSA2/MaFG1xH90UfEwL831FhPAJ6ZSqI598666AwpJFEYnUl0xFJNiDIy3J39e242GEUVVQYiFRmOE0MLmzrbNjKk4EX1kvhTHpRumSIaWH3Fan9jpsIcGrs+RFjFccTGD8sxDR5kG9k9P5hLoB41FvmCGVqVp/ucjoNrThBN1gyTSXw63wEhhCMWmHJfZ13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ahrInSRnSdqxGv+wx5d8r5UeShhO1+5d0tuLoAlt8c=;
 b=PiRvNMxZIYS2PdJyg+P1mOV1oe3ETnzW6IUeqgCwN0ru9rnuhxKgIYF5GYs+ETgEl4f2itChKY6Xir0tAfO8unAfYJA2/iQNYy5M3BTQh8MYyQ5omEK9qX0Dr/L4htPRDpVH55F8ex/5ykkLgf7sH0G8hH7XqJ2fx2peANB6PT62VrUrzEX1tVAraoawvYh/8DI2BNfbWRbj/RxB4uH0YNJdTIUdKnCiatvYhSaR7v3ETa/sqtizqCm+5XvdTKHBXDVXMFCNg0YvHMW1/I7yrkw1FyiYDqIaeE+v60nfqaJn5RfMP0fAH1bkGdbGhZvIAEmfYEJQkcOG8ghQrBwVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ahrInSRnSdqxGv+wx5d8r5UeShhO1+5d0tuLoAlt8c=;
 b=f//xT9FzRGdeXRytymbzWo/YHj8aN5mORq4yCCEgUBHzw1XLQ9Z68dDtgn0xh6xBkgLt+Zt4E4eljyzff5GVvXOE6rYuAf8EekOmzvoc3f2AVJYxqsfN5pEsAi1gH/brTHfvetvj0EFZAv7KsXglduqZOcbidJ4xjocrCdJiY4g=
Received: from BL0PR12MB4961.namprd12.prod.outlook.com (2603:10b6:208:1c9::24)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Wed, 16 Dec
 2020 02:11:58 +0000
Received: from BL0PR12MB4961.namprd12.prod.outlook.com
 ([fe80::b520:3528:f738:8006]) by BL0PR12MB4961.namprd12.prod.outlook.com
 ([fe80::b520:3528:f738:8006%8]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 02:11:58 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen, Jiansong (Simon)"
 <Jiansong.Chen@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: set mode1 reset as default for
 dimgrey_cavefish
Thread-Topic: [PATCH] drm/amdgpu: set mode1 reset as default for
 dimgrey_cavefish
Thread-Index: AQHW0sxaajZkuy+q+0q/gKOccL1nn6n39cGAgABBYYCAAMP/wA==
Date: Wed, 16 Dec 2020 02:11:57 +0000
Message-ID: <BL0PR12MB4961000DCAD5F14F316928E1B0C50@BL0PR12MB4961.namprd12.prod.outlook.com>
References: <20201215102321.20233-1-tao.zhou1@amd.com>,
 <BY5PR12MB488509A067242B247E2C1906EAC60@BY5PR12MB4885.namprd12.prod.outlook.com>
 <MN2PR12MB4488488511B633CF55C1F390F7C60@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4488488511B633CF55C1F390F7C60@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-16T02:11:40Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5f77b599-6469-4685-b828-0000dd7927cb;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-16T02:11:26Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b97afde9-651d-4691-8fd4-00008bd023ad
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-16T02:11:55Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 928b64a0-b4a9-4884-a69f-000002008248
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.169.125.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e90bbc44-eaf0-4281-5942-08d8a167f795
x-ms-traffictypediagnostic: MN2PR12MB4552:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4552583D0FEBA81F22D13168B0C50@MN2PR12MB4552.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jYOTpLM74RoE0ecBoyuPS/MK3U1RRSdJGr5SyIJyYTNrUPE4ihH8l52D72kp77tRK6ZftPZaozmfc3xPge1n6VsXvze4y55kqP+UMNOQ8WD8W1lInUI0rh9s8d7pATUUAHJQ8S1axr9exlCN1NLSSNgs9+9p/5ZbCpGXwVhA5TMiJ7j4DPDecsV++4McUwNVFZ8XNL/iu9C853+21qfNzv3PVXdkKRnuZMorFcbcl9x/p1j7UYUIQrKFO6GI2/gmN2V4QBVNr1Z2sOohkSPfgdN/fPIwbiDLureqxXL5tlGt0gyChznCoHhzjaF2BNcdsCHclMRvkonF3MUrNsvpegQkjWWM1S/WvhFUt3gu8lc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4961.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(5660300002)(8936002)(33656002)(55016002)(2906002)(66946007)(6506007)(186003)(110136005)(53546011)(7696005)(9686003)(45080400002)(76116006)(166002)(71200400001)(966005)(52536014)(66556008)(83380400001)(66446008)(64756008)(66476007)(86362001)(498600001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cxVyr/Za2YNoiZ68Qmp9PHgtn9eoaKSZAqDa8pE8VcJULMkSRoTN2rgtwEgQ?=
 =?us-ascii?Q?UgsUdvArz4Ocq0gyNvwEr5k4VjBNz3xIeytCKP08nzNRHpyTjudV0Tr5pQ4Z?=
 =?us-ascii?Q?mef4lfTZt6OlHY8Yg0yYfQQdUnMWCUXQXLQeF5cy59G/HjmdY0EINsYVAaWj?=
 =?us-ascii?Q?PshmlhlTG/czWXfHoPBg59Ff3kNpvVlpHOIiOPPzjXFoFFVQ7nVOO5TZYgtg?=
 =?us-ascii?Q?LwY+k4HVdNGQL2SFv2Kkf73o7LR3OtCwyzO0b6jqmTGQe4QMWHcARgLI+JRH?=
 =?us-ascii?Q?7wckc0jFE7QnOo2md7HHT7MRRxJUTDpLRhR8YcKOwF7wRqAZMavhFbIMNtIP?=
 =?us-ascii?Q?BY9mQ5TAqZLstDpqq50YniMjDMMJ4koDtYOt6CyTjYjUkVaByL7+Jbx/uCwt?=
 =?us-ascii?Q?jk3V+K6TNZehbOG0Zd4AG8AZH3Qy0abMKt0YZKtbuN35UGVix3DxTCPNb7O8?=
 =?us-ascii?Q?FqSWCO9uh5AsnvzVOk97xk03cKd802SbPVNoa1MsgI5KfxohQ5MLmQET7BlK?=
 =?us-ascii?Q?MkVA42XuR4jYFF7nKy4CdFnSA2mWVDublG1MU2uogfaWjmMZIjITmUsgJ2uc?=
 =?us-ascii?Q?P7ZL61i48Q82r1PcguTqj4v3Dli8fp10+5fj0dSkQyihExc6bAqZ7l4UzyZ+?=
 =?us-ascii?Q?sVMbAGoXn0sB5aLmwe8ErcKnkUr1l7Z7+1n3Xzx5BtGExU/QhtzhSt242k0Y?=
 =?us-ascii?Q?IlJG1VcsFU1Tl5YeN2b6dd1mSPAy0g+ddgQTBYdo32FQErVZz0eyyTDrilhA?=
 =?us-ascii?Q?8KzyE8isGiLwFy/LbzepSzd5Gii3mHdmfkZmFPvax9WEsbsTQXBqBNN26GYV?=
 =?us-ascii?Q?91WLdpcNH2RcrAL0U68Bn6Lu6KeKt2eLuLVJLL6b+ZNwHyZGof3UyX8PKpGi?=
 =?us-ascii?Q?6tOYiueBZwwBfaNg71IHXqrSOEhqRRTVqKdKDO3OPUfCai0AZgnz8gGOJ2hd?=
 =?us-ascii?Q?1rzZwseZU1GM3Q8VCngatDT6Svk3BXtKdcNh/I7sIPw=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4961.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90bbc44-eaf0-4281-5942-08d8a167f795
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 02:11:57.8855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fieF0FkxDLUkXAug8gcCHnVTzxWsMwlZXr/xuJ2nyJmp0MpL8l2E0mQvpbRK3JNh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
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
Content-Type: multipart/mixed; boundary="===============0262813236=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0262813236==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL0PR12MB4961000DCAD5F14F316928E1B0C50BL0PR12MB4961namp_"

--_000_BL0PR12MB4961000DCAD5F14F316928E1B0C50BL0PR12MB4961namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Thanks for your reminder, I'll add another patch to enable gpu recovery.

Tao

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, December 15, 2020 10:27 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Zhou1, Tao <Tao.Zhou1@a=
md.com>; Gui, Jack <Jack.Gui@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.co=
m>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: set mode1 reset as default for dimgrey_cav=
efish


[AMD Official Use Only - Internal Distribution Only]

You will also need to add the asic_type to amdgpu_device_should_recover_gpu=
() if you the driver to actually use GPU reset when it encounters a hang.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Chen, Jiansong (Simon) <Jiansong.Chen=
@amd.com<mailto:Jiansong.Chen@amd.com>>
Sent: Tuesday, December 15, 2020 5:33 AM
To: Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Gui, Jack <Ja=
ck.Gui@amd.com<mailto:Jack.Gui@amd.com>>; Zhang, Hawking <Hawking.Zhang@amd=
.com<mailto:Hawking.Zhang@amd.com>>; amd-gfx@lists.freedesktop.org<mailto:a=
md-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org<mailto:amd-gfx=
@lists.freedesktop.org>>
Subject: RE: [PATCH] drm/amdgpu: set mode1 reset as default for dimgrey_cav=
efish

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com<mailto:Jiansong.Chen@amd.=
com>>

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>
Sent: Tuesday, December 15, 2020 6:23 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com<mailto:Jiansong.Chen@amd.=
com>>; Gui, Jack <Jack.Gui@amd.com<mailto:Jack.Gui@amd.com>>; Zhang, Hawkin=
g <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; amd-gfx@lists.free=
desktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>
Subject: [PATCH] drm/amdgpu: set mode1 reset as default for dimgrey_cavefis=
h

Use mode1 reset for dimgrey_cavefish by default.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com<mailto:tao.zhou1@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index ac02dd707c44..6bee3677394a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -362,6 +362,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 switch (adev->asic_type) {
 case CHIP_SIENNA_CICHLID:
 case CHIP_NAVY_FLOUNDER:
+case CHIP_DIMGREY_CAVEFISH:
 return AMD_RESET_METHOD_MODE1;
 default:
 if (smu_baco_is_support(smu))
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Cb3da8467a171425a6cf208d8a0e4d612%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637436252010819826%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3Dfr8uXVyoVz5WlYtYPRbKm1%2BN0ROBWuLuqPOuL3%2BHC0E%3D&amp;reserved=3D0

--_000_BL0PR12MB4961000DCAD5F14F316928E1B0C50BL0PR12MB4961namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks for your reminder, I&#8217;ll add another pat=
ch to enable gpu recovery.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Tao<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Tuesday, December 15, 2020 10:27 PM<br>
<b>To:</b> Chen, Jiansong (Simon) &lt;Jiansong.Chen@amd.com&gt;; Zhou1, Tao=
 &lt;Tao.Zhou1@amd.com&gt;; Gui, Jack &lt;Jack.Gui@amd.com&gt;; Zhang, Hawk=
ing &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: set mode1 reset as default for dimg=
rey_cavefish<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">You wil=
l also need to add the asic_type to amdgpu_device_should_recover_gpu() if y=
ou the driver to actually use GPU reset when it encounters a hang.<o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Chen, Jiansong (Simon) &lt;<a href=3D"mailto:Jiansong.Chen@amd.com">Jians=
ong.Chen@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, December 15, 2020 5:33 AM<br>
<b>To:</b> Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@am=
d.com</a>&gt;; Gui, Jack &lt;<a href=3D"mailto:Jack.Gui@amd.com">Jack.Gui@a=
md.com</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com"=
>Hawking.Zhang@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: set mode1 reset as default for dimg=
rey_cavefish</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Official Use Only - Internal Distribution Only]=
<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
Reviewed-by: Jiansong Chen &lt;<a href=3D"mailto:Jiansong.Chen@amd.com">Jia=
nsong.Chen@amd.com</a>&gt;<br>
<br>
-----Original Message-----<br>
From: Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@amd.com=
</a>&gt;<br>
Sent: Tuesday, December 15, 2020 6:23 PM<br>
To: Chen, Jiansong (Simon) &lt;<a href=3D"mailto:Jiansong.Chen@amd.com">Jia=
nsong.Chen@amd.com</a>&gt;; Gui, Jack &lt;<a href=3D"mailto:Jack.Gui@amd.co=
m">Jack.Gui@amd.com</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Z=
hang@amd.com">Hawking.Zhang@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
Cc: Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@amd.com</=
a>&gt;<br>
Subject: [PATCH] drm/amdgpu: set mode1 reset as default for dimgrey_cavefis=
h<br>
<br>
Use mode1 reset for dimgrey_cavefish by default.<br>
<br>
Signed-off-by: Tao Zhou &lt;<a href=3D"mailto:tao.zhou1@amd.com">tao.zhou1@=
amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index ac02dd707c44..6bee3677394a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -362,6 +362,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;switch (adev-&gt;asic_type) {<br>
&nbsp;case CHIP_SIENNA_CICHLID:<br>
&nbsp;case CHIP_NAVY_FLOUNDER:<br>
+case CHIP_DIMGREY_CAVEFISH:<br>
&nbsp;return AMD_RESET_METHOD_MODE1;<br>
&nbsp;default:<br>
&nbsp;if (smu_baco_is_support(smu))<br>
--<br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Cb3da8467a171425a6cf208d8a0e4d612%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637436252010819826%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3Dfr8uXVyoVz5WlYtYPRbKm1%2BN0ROBWuLuqPOuL3%2BHC0E%3D&a=
mp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D04%7C01%7Calexander.deucher%40amd.com%7Cb3da8467a171425a6cf208d8a0e4=
d612%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637436252010819826%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;amp;sdata=3Dfr8uXVyoVz5WlYtYPRbKm1%2BN0ROBWuLuqPOuL3%2=
BHC0E%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL0PR12MB4961000DCAD5F14F316928E1B0C50BL0PR12MB4961namp_--

--===============0262813236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0262813236==--
