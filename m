Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2D9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 13:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA25210E4B8;
	Tue, 14 Dec 2021 13:14:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AF4010E4B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 13:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kj2YXgnhAPz1lzkpph0J9k/2VJPSuur9CE5QniUf9n1LLMFC+K3B7XOUJBWpHwq5AAxnD4D1SVWFSKDt54pFlzXvX16WrkfjYY8vLKOe4cCtLSktXFpTirhHSF2H0dHbWbVzwBaURbQO1CtSHDF5+jxGp59KpPu2R0labzvEMoPg91JxNeE9n9sstd2fPuiNowghV+Dj/EF4tXDWQzliCec7comaElYF9dyTFDRxEfxbR21VyUO8Uz1FRqhXUDKj616O5Zc/wlv7DoLARkvtotY2/VAwSafRC+3if4jyTlNy3v7d4VclD+pKtDWEmORoIidd/9r3wKiox6BnjVQBLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KrMNttXLIt5ju8a9Sh1PsOX++M4NEyMnBVi4YJCySY=;
 b=PCV2jYhVA99qvWs8WUhyAlsNqhcGHD/S7jC5lIn/u+8vOnmDInz1ImjKMeEGhlclREOOqgzwfz4pI+XlyixBt37jzaB4nXmj450wYRVEqKFty39ttcNZZm871eMqGc1H9/n3IBN/f748sSHyhUWsOmwJJIOz7swXMA/YIkKOyZjvAeKdF1XEXQyFZRaXEYuHuRdRQtYnIFgooj72BCnrCLHxHulk4nb75w/Y9Sldmo6BTtjKhYusFSNNqkGeT0m7dPtzz27h4HvtYN1rcFTOS0+eeDbYZoOLQcpS6fBg6Pub9t08Gb6Xj8G/bnRt+vm+f+FCKCoorVSykczK27zbgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KrMNttXLIt5ju8a9Sh1PsOX++M4NEyMnBVi4YJCySY=;
 b=vgvqUN8as+9CEEd8473EZc0we71PRom3M+6c/wn3fK58uhdPQOZpmwpA53VkyG1sgQ6aWIL5na7YdgXU2mZkMez0f2Da+6KDI/TaYcZa2W2Lt4YNz95mELdHybBE2rkZZoePTD5QNzZ/XhT2TN/eMd+U4k/7DsQ9X7GZZtlobM8=
Received: from DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21)
 by DM5PR12MB1739.namprd12.prod.outlook.com (2603:10b6:3:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 13:14:08 +0000
Received: from DM6PR12MB4300.namprd12.prod.outlook.com
 ([fe80::5da2:b748:bed:9e49]) by DM6PR12MB4300.namprd12.prod.outlook.com
 ([fe80::5da2:b748:bed:9e49%5]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 13:14:08 +0000
From: "Nikolic, Marina" <Marina.Nikolic@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>
Subject: Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Thread-Topic: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Thread-Index: AQHX7ddpeUjnKdMMFEuQ7xU45j9h0awwtVIAgAACzACAAJoDAIAAGciAgAAAzwCAAI2J4w==
Date: Tue, 14 Dec 2021 13:14:08 +0000
Message-ID: <DM6PR12MB43004466F568E846C9AD44418E759@DM6PR12MB4300.namprd12.prod.outlook.com>
References: <20211210150533.1509-1-Marina.Nikolic@amd.com>
 <DM6PR12MB4042C81DE457BFDB7007995D8C749@DM6PR12MB4042.namprd12.prod.outlook.com>
 <DM6PR12MB404216720C63071561C3675F8C749@DM6PR12MB4042.namprd12.prod.outlook.com>
 <DM6PR12MB2619DFBA6CC70A93C3547BECE4759@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM6PR12MB393064EE17A327FCA213831897759@DM6PR12MB3930.namprd12.prod.outlook.com>
 <DM6PR12MB3930E43AA72957083762380D97759@DM6PR12MB3930.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3930E43AA72957083762380D97759@DM6PR12MB3930.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Lijo.Lazar@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-14T13:14:07.785Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: cb6e7886-5c92-dbfd-aafb-780331648d53
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecea691e-4324-4eb3-74e7-08d9bf039cb3
x-ms-traffictypediagnostic: DM5PR12MB1739:EE_
x-microsoft-antispam-prvs: <DM5PR12MB173907D204E54BE5041D51078E759@DM5PR12MB1739.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +kTxLZx7rtGZ77X6dotwbU/fe68pOvrDg3KkHUgNOJ2vMZx5jutcKPugNZ1ZI6O7/hYkbibAxovV7rsSHjk3dNCvmBPoC4diz5deI0X1pxaNBg8++zZNENKihaxQuMR4g19N4GvZPNoAfxLwKqyqR3FkEjnvyLf0CQdXjRWH6HHsmQoFY/021BUm40qlKjTcVMdZQVcrV7iMSTiEd2pkxliy+9n4bTF/1lKiQenp3y2sDOotlfA85cGkwOez3m2O5xL9aTDx0aytomDcL7qqvT3d6QAL8G3obh4fRZCoIzBCEankBvSXX6McKg1v1/mOdjfJyiRi2m4Y+J8D1ru5C89qWk51m+ibLwKgYFZMWqyh/i/aF6wBVBsAeDdTQz9tK4VUafTAcxn9Ms2y+5z5yIA0eP2zUX45K21c6symN3nZ4l3rkjPJqzync3rjyFBnQJDG1RUuaBLmzkPXp3fbQ6+8z29juBXIUDmGONHzMzI92kEVFHtX9SY4bvabbhPyDSpFtohybCSUQ9dgU3Yg2F8Yl3hnoL04p/ic4HfW8lvvJnuNRVccmIKj95NpVQjC0pyi5XDOuK5QPOgYxxhOKtcfFDnAeiz9ColBHsMInaD16bMEsSd0L5Hw4LB1xESDbU/FbzzzsKsT8hyGcNmvViSAPpXA7fwOpddxSNGWt4RI0nB03Oi4smK9Vt/juEgnXCvs13tawDgpP8ERiV8oUQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4300.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(122000001)(66446008)(86362001)(316002)(4326008)(5660300002)(53546011)(6506007)(33656002)(66556008)(38070700005)(26005)(7696005)(64756008)(19627405001)(2906002)(186003)(508600001)(66476007)(110136005)(76116006)(91956017)(8936002)(66946007)(9686003)(54906003)(55016003)(8676002)(71200400001)(52536014)(6636002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ggJ03Of3gvCCTrDfzqLBpwXPtgjh74/v6Oj+PBYUqvWq/8vYtgJkTUnl9R?=
 =?iso-8859-1?Q?FY3wK7rwfX6aWC8e/mqNBp/jJ3rI+hDnDujUuuu4ylycGLhboBMBTwX5oV?=
 =?iso-8859-1?Q?pwpwwr/1ceAovuPDDo6fbml9/kuNnumUBKEQtwJXr52wPx8U1wCbOawdgM?=
 =?iso-8859-1?Q?rVas4nTimpTAphq9BM6NnRiN23AOTnybn7JXJhcltUNC0trR3nqKchRBo3?=
 =?iso-8859-1?Q?fvMw/Ic01eajET+DBe8cgp95UHvmoACUzCVFgyzT1hu36SdVhkg1lJmS4t?=
 =?iso-8859-1?Q?JgKjJyE99mctlgzpAQ672lSTHAk9F1tM+ZOT8yMFUA0GXw8FQa7Cb/LI62?=
 =?iso-8859-1?Q?oQ7dNwcF2wrZE6AhJT9pXZUDR4x8B4oxLhzYrDu6fybC+DIOQvGvxJm7+7?=
 =?iso-8859-1?Q?2lpUe6H5WdE1xZBoqNqDQO2IG9C1JutKlksp7aOhqUlQF8ZJZEcK24Qk3F?=
 =?iso-8859-1?Q?WQ5Soa6W4wyWBsXUYLopQqvWkjzUqjIO4zt05TMNSAnLjx+RzprM0DAWH6?=
 =?iso-8859-1?Q?i20uQ6NkzDMiqbmARKXlQkEEJQJ71c2qwSBkZ2UphhiZqqvrEU1pPPLfqF?=
 =?iso-8859-1?Q?GTnk8KUyU4uioWtAe0mfQ0CtcGEk1VJmYyOkPxjrzxqifQUtAYzae/JwoW?=
 =?iso-8859-1?Q?EZ1oF3t7X+4gOR4NmNeTnrcJcRklVWDGNdVocBCvn6fxRbrlSwviIJoLwA?=
 =?iso-8859-1?Q?IucexTcXMfDN43UZMIQF0aUPWnmNvxUAOHUjIynlOXnWkdxP7wVjw2p6CE?=
 =?iso-8859-1?Q?z686opNiTuWGSKFoLVSgrVebuODR7Qa0PYi5FWttyDgrF5qKwhVXQzRTr7?=
 =?iso-8859-1?Q?v0mpPoJGUiaVX3oL2u9I8+Q3j5FTLvFnQnKz3jWXMjiDQG3ySRAO9e0oC1?=
 =?iso-8859-1?Q?ZaVHKd5F/vLBYPpURIEqta/3lhz/6hl2Ol5Q3DTlTCYX/BdEkb+92fJVvH?=
 =?iso-8859-1?Q?BzVLQ30AMuV1l/egostEuY/+RgijnvTg6evj3K2mPvAqho8+tN97gYIVNK?=
 =?iso-8859-1?Q?vt3VSFzGaEQ92mAsFRPizCFKFHAgXU92jkVlEMLeuTFOEM0Krt7yMZTRaZ?=
 =?iso-8859-1?Q?vpSZKDcpaGM1kLnHZZbpGZpIjePG3YVsn6ldF+5P8VbFcEHBlZImOAEI+d?=
 =?iso-8859-1?Q?jrKfF3r+Ap33STCEJFZIKCws5ab5mMgKy4PiRhHMDbFT9zDp207jS4e308?=
 =?iso-8859-1?Q?UdWb7MfMJELBZtCmezsZ3JjReJlrCgZN/rswBWzXlkHKaA56s78euRXRJc?=
 =?iso-8859-1?Q?LmY5zXveN87/YWgjvBkqHEdXpX3zaldfAy074JedIkkAiRGL7Tssw3S4zn?=
 =?iso-8859-1?Q?m773HkGllAm8lx5bAv9LwrUZ1vY36gJQcX0tGXvDj5W/3e3zmqRgsO54e6?=
 =?iso-8859-1?Q?Z8TiikCwIfpbrAW860lheyx/Pe5XclEEEGDUyeBVxGcnkW8q6jHuBJtJ8c?=
 =?iso-8859-1?Q?5AvV5eF1E7W0BMOOM1AYGjHlkNhB3D2OFVYDY77+vPFDmanP8xirKSyfYd?=
 =?iso-8859-1?Q?O5ESMH/kGMMCy1FSZBGUFofxp4iaUDtEa69yxscKPICbJ4VAIH3fx0UsOo?=
 =?iso-8859-1?Q?8rFa5hqp50ietxUXTDBfuzDi+tJ1ER4ZwKN9lD/C8NEIeaBBy+fiAwC/4e?=
 =?iso-8859-1?Q?va0IVoOFrR8xrdQJ9Mn1wMTCtpZ/xw8erKJx2aI5zAGMo6Jisz22gS6A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB43004466F568E846C9AD44418E759DM6PR12MB4300namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecea691e-4324-4eb3-74e7-08d9bf039cb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 13:14:08.2574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BzJjx/UtrTWLmWmkQoZw3Ydvaw4KMyGFXp3lx7nKSgKOXdH4mNml/51JBLfKuWxCnVtcHLJFU4cADYlAZ6bewA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1739
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kitchen,
 Greg" <Greg.Kitchen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB43004466F568E846C9AD44418E759DM6PR12MB4300namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hello,

Thank you all for fast response and useful advice.
I made new changes based on suggestion from @Lazar, Lijo<mailto:Lijo.Lazar@=
amd.com>.
Though, I have made it general (any setting in sriov case) as that is in my=
 request (details: SWDEV-313004).
Please find the new patch below.

Thank you and best regards,
Marina



From 9afe76f6e4036143bed0047d71c05069fdeb44ee Mon Sep 17 00:00:00 2001
From: Marina Nikolic <Marina.Nikolic@amd.com>
Date: Tue, 14 Dec 2021 20:57:53 +0800
Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 permission in ONEVF mode

=3D=3D Description =3D=3D
Due to security reasons setting through sysfs
should only be allowed in passthrough mode.
Options that are not mapped as SMU messages
do not have any mechanism to distinguish between
passthorugh, onevf and mutivf usecase.
A unified approach is needed.

=3D=3D Changes =3D=3D
This patch introduces a new mechanizm to distinguish
ONEVF and PASSTHROUGH use case on sysfs level
and prohibit setting (writting to sysfs).
It also applies the new mechanizm on pp_dpm_sclk sysfs file.

=3D=3D Test =3D=3D
Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.
Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:
"calling process does not have sufficient permission to execute a command".
Sysfs pp_dpm_sclk will not be created in MULTIVF mode.

Signed-off-by: Marina Nikolic <Marina.Nikolic@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 082539c70fd4..d2b168babc7d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_
                }
        }

+       /* security: setting should not be allowed from VF */
+       if (amdgpu_sriov_vf(adev)) {
+               dev_attr->attr.mode &=3D ~S_IWUGO;
+               dev_attr->store =3D NULL;
+       }
+
 #undef DEVICE_ATTR_IS

        return 0;
--
2.20.1
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, December 14, 2021 5:36 AM
To: Quan, Evan <Evan.Quan@amd.com>; Kasiviswanathan, Harish <Harish.Kasivis=
wanathan@amd.com>; Nikolic, Marina <Marina.Nikolic@amd.com>; Deng, Emily <E=
mily.Deng@amd.com>
Cc: Kitchen, Greg <Greg.Kitchen@amd.com>
Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode

[AMD Official Use Only]

Ah, just noticed that below code won't compile (misses one '{').  Regardles=
s, hope you get the idea.

Thanks,
Lijo

-----Original Message-----
From: Lazar, Lijo
Sent: Tuesday, December 14, 2021 10:04 AM
To: Quan, Evan <Evan.Quan@amd.com>; Kasiviswanathan, Harish <Harish.Kasivis=
wanathan@amd.com>; Nikolic, Marina <Marina.Nikolic@amd.com>; Deng, Emily <E=
mily.Deng@amd.com>
Cc: Kitchen, Greg <Greg.Kitchen@amd.com>
Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode

[AMD Official Use Only]

Hi Marina,

attr_update is the recommended method to dynamically update the attribute p=
roperties.

If it's only for sclk, you may do as below (I guess, passthrough and VF are=
 mutually exclusive).

--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2132,6 +2132,13 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_
                        dev_attr->store =3D NULL;
                }
        }
+       if (DEVICE_ATTR_IS(pp_dpm_sclk)) {
+               /* Don't allow to set GFX clock in VF mode*/
+               if (amdgpu_sriov_vf(adev))
+                       dev_attr->attr.mode &=3D ~S_IWUGO;
+                       dev_attr->store =3D NULL;
+               }
+       }

Thanks,
Lijo

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Tuesday, December 14, 2021 8:32 AM
To: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Nikolic, Mari=
na <Marina.Nikolic@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Deng, Emily =
<Emily.Deng@amd.com>
Cc: Kitchen, Greg <Greg.Kitchen@amd.com>
Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode

[AMD Official Use Only]

+Emily from SRIOV team

I think driver uses the Macros below to tell about the ONEVF and PASSTHROUG=
H support:
#define amdgpu_sriov_is_pp_one_vf(adev) \
        ((adev)->virt.gim_feature & AMDGIM_FEATURE_PP_ONE_VF)

#define amdgpu_passthrough(adev) \
((adev)->virt.caps & AMDGPU_PASSTHROUGH_MODE)

@Deng, Emily please correct me if anything wrong.

BR
Evan
> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Tuesday, December 14, 2021 1:50 AM
> To: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Nikolic,
> Marina <Marina.Nikolic@amd.com>; Quan, Evan <Evan.Quan@amd.com>;
> Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Kitchen, Greg <Greg.Kitchen@amd.com>
> Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only
> read premission in ONEVF mode
>
> [AMD Official Use Only]
>
> Hi Lijo and Evan,
>
> Could you please advice Marina on how to go about this? Does driver
> have a mechanism to distinguish between ONEVF and PASSTHROUGH case?
>
> Best Regards,
> Harish
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Kasiviswanathan, Harish
> Sent: Monday, December 13, 2021 12:40 PM
> To: Nikolic, Marina <Marina.Nikolic@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Nikolic, Marina <Marina.Nikolic@amd.com>
> Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only
> read premission in ONEVF mode
>
> [AMD Official Use Only]
>
> Some comment inline.
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Marina Nikolic
> Sent: Friday, December 10, 2021 10:06 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Nikolic, Marina <Marina.Nikolic@amd.com>
> Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
> premission in ONEVF mode
>
> =3D=3D Description =3D=3D
> Due to security reasons setting through sysfs should only be allowed
> in passthrough mode.
> Options that are not mapped as SMU messages do not have any mechanizm
> to distinguish between passthorugh, onevf and mutivf usecase.
> A unified approach is needed.
>
> =3D=3D Changes =3D=3D
> This patch introduces a new mechanizm to distinguish ONEVF and
> PASSTHROUGH
>
> [HK]: It is not clear how you distinguish between ONEVF and PASSTHROUGH.
> Could you please elaborate?
>
> use case on sysfs level
> and prohibit setting (writting to sysfs).
> It also applies the new mechanizm on pp_dpm_sclk sysfs file.
>
> =3D=3D Test =3D=3D
> Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.
> Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:
> "calling process does not have sufficient permission to execute a command=
".
> Sysfs pp_dpm_sclk will not be created in MULTIVF mode.
>
> Signed-off-by: Marina Nikolic <marina.nikolic@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c     | 4 ++--
>  drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h | 4 ++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 082539c70fd4..0ccc23ee76a8 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2021,7 +2021,7 @@ static struct amdgpu_device_attr
> amdgpu_device_attrs[] =3D {
>        AMDGPU_DEVICE_ATTR_RO(pp_cur_state,
>        ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>        AMDGPU_DEVICE_ATTR_RW(pp_force_state,
>        ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>        AMDGPU_DEVICE_ATTR_RW(pp_table,
>                ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> -     AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,
>        ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +     AMDGPU_DEVICE_ATTR_RRW(pp_dpm_sclk,
>        ATTR_FLAG_BASIC, ATTR_FLAG_ONEVF),
>
> [HK]: Wouldn't this macro try to create two sysfs entries with same name.
> The second time the function would fail.
>
>        AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,
>        ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>        AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,
>        ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>        AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,
>        ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> @@ -3504,7 +3504,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device
> *adev)
>                break;
>        case SRIOV_VF_MODE_BARE_METAL:
>        default:
> -             mask =3D ATTR_FLAG_MASK_ALL;
> +             mask =3D ATTR_FLAG_BASIC;
>                break;
>        }
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> index a920515e2274..1a30d9c48d13 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> @@ -79,6 +79,10 @@ struct amdgpu_device_attr_entry {
>                             amdgpu_get_##_name, NULL,
>        \
>                             _flags, ##__VA_ARGS__)
>
> +#define AMDGPU_DEVICE_ATTR_RRW(_name, _flags_full,
> _flags_restricted, ...)        \
> +        AMDGPU_DEVICE_ATTR_RW(_name, _flags_full, ##__VA_ARGS__),
>                \
> +        AMDGPU_DEVICE_ATTR_RO(_name, _flags_restricted,
> ##__VA_ARGS__)
> +
>  int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);  int
> amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);  void
> amdgpu_pm_sysfs_fini(struct amdgpu_device *adev);
> --
> 2.20.1

--_000_DM6PR12MB43004466F568E846C9AD44418E759DM6PR12MB4300namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Hello,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Thank&nbsp;you all&nbsp;for fast response and useful advice.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
I made new changes based on suggestion from <a id=3D"OWAAM634591" class=3D"=
J9Y1oNF3ZpoR5LC3M2PHm mention ms-bgc-nlr ms-fcl-b" href=3D"mailto:Lijo.Laza=
r@amd.com">
@Lazar, Lijo</a>.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Though, I have made it general (any setting in sriov case) as that is in my=
 request (details: SWDEV-313004).</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Please find the new patch below.&nbsp;</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Thank you and best&nbsp;regards,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Marina</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
From 9afe76f6e4036143bed0047d71c05069fdeb44ee Mon Sep 17 00:00:00 2001
<div>From: Marina Nikolic &lt;Marina.Nikolic@amd.com&gt;</div>
<div>Date: Tue, 14 Dec 2021 20:57:53 +0800</div>
<div>Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read=
</div>
<div>&nbsp;permission in ONEVF mode</div>
<div><br>
</div>
<div>=3D=3D Description =3D=3D</div>
<div>Due to security reasons setting through sysfs</div>
<div>should only be allowed in passthrough mode.</div>
<div>Options that are not mapped as SMU messages</div>
<div>do not have any mechanism to distinguish between</div>
<div>passthorugh, onevf and mutivf usecase.</div>
<div>A unified approach is needed.</div>
<div><br>
</div>
<div>=3D=3D Changes =3D=3D</div>
<div>This patch introduces a new mechanizm to distinguish</div>
<div>ONEVF and PASSTHROUGH use case on sysfs level</div>
<div>and prohibit setting (writting to sysfs).</div>
<div>It also applies the new mechanizm on pp_dpm_sclk sysfs file.</div>
<div><br>
</div>
<div>=3D=3D Test =3D=3D</div>
<div>Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.</d=
iv>
<div>Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:</div=
>
<div>&quot;calling process does not have sufficient permission to execute a=
 command&quot;.</div>
<div>Sysfs pp_dpm_sclk will not be created in MULTIVF mode.</div>
<div><br>
</div>
<div>Signed-off-by: Marina Nikolic &lt;Marina.Nikolic@amd.com&gt;</div>
<div>---</div>
<div>&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++</div>
<div>&nbsp;1 file changed, 6 insertions(+)</div>
<div><br>
</div>
<div>diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/=
pm/amdgpu_pm.c</div>
<div>index 082539c70fd4..d2b168babc7d 100644</div>
<div>--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c</div>
<div>+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c</div>
<div>@@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_de=
vice *adev, struct amdgpu_device_</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; }</div>
<div><br>
</div>
<div>+ &nbsp; &nbsp; &nbsp; /* security: setting should not be allowed from=
 VF */</div>
<div>+ &nbsp; &nbsp; &nbsp; if (amdgpu_sriov_vf(adev)) {</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_attr-&gt;attr.m=
ode &amp;=3D ~S_IWUGO;</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_attr-&gt;store =
=3D NULL;</div>
<div>+ &nbsp; &nbsp; &nbsp; }</div>
<div>+</div>
<div>&nbsp;#undef DEVICE_ATTR_IS</div>
<div><br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; return 0;</div>
<div>--</div>
<span>2.20.1</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Tuesday, December 14, 2021 5:36 AM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Kasiviswanathan, Harish &l=
t;Harish.Kasiviswanathan@amd.com&gt;; Nikolic, Marina &lt;Marina.Nikolic@am=
d.com&gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
<b>Cc:</b> Kitchen, Greg &lt;Greg.Kitchen@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have onl=
y read premission in ONEVF mode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">[AMD Official Use Only]<br>
<br>
Ah, just noticed that below code won't compile (misses one '{').&nbsp; Rega=
rdless, hope you get the idea.<br>
<br>
Thanks,<br>
Lijo<br>
<br>
-----Original Message-----<br>
From: Lazar, Lijo <br>
Sent: Tuesday, December 14, 2021 10:04 AM<br>
To: Quan, Evan &lt;Evan.Quan@amd.com&gt;; Kasiviswanathan, Harish &lt;Haris=
h.Kasiviswanathan@amd.com&gt;; Nikolic, Marina &lt;Marina.Nikolic@amd.com&g=
t;; Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
Cc: Kitchen, Greg &lt;Greg.Kitchen@amd.com&gt;<br>
Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode<br>
<br>
[AMD Official Use Only]<br>
<br>
Hi Marina,<br>
<br>
attr_update is the recommended method to dynamically update the attribute p=
roperties.<br>
<br>
If it's only for sclk, you may do as below (I guess, passthrough and VF are=
 mutually exclusive).<br>
<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -2132,6 +2132,13 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_attr-&g=
t;store =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (DEVICE_ATTR_IS(pp_dpm_sclk)) {<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Don't allow to set GFX clock in VF mode*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_attr-&gt;att=
r.mode &amp;=3D ~S_IWUGO;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_attr-&gt;sto=
re =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
Thanks,<br>
Lijo<br>
<br>
-----Original Message-----<br>
From: Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
Sent: Tuesday, December 14, 2021 8:32 AM<br>
To: Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; Nikolic=
, Marina &lt;Marina.Nikolic@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com=
&gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
Cc: Kitchen, Greg &lt;Greg.Kitchen@amd.com&gt;<br>
Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read =
premission in ONEVF mode<br>
<br>
[AMD Official Use Only]<br>
<br>
+Emily from SRIOV team<br>
<br>
I think driver uses the Macros below to tell about the ONEVF and PASSTHROUG=
H support:<br>
#define amdgpu_sriov_is_pp_one_vf(adev) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;virt.gim_feature &am=
p; AMDGIM_FEATURE_PP_ONE_VF)<br>
<br>
#define amdgpu_passthrough(adev) \<br>
((adev)-&gt;virt.caps &amp; AMDGPU_PASSTHROUGH_MODE)<br>
<br>
@Deng, Emily please correct me if anything wrong.<br>
<br>
BR<br>
Evan<br>
&gt; -----Original Message-----<br>
&gt; From: Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;<b=
r>
&gt; Sent: Tuesday, December 14, 2021 1:50 AM<br>
&gt; To: Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; Ni=
kolic, <br>
&gt; Marina &lt;Marina.Nikolic@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.co=
m&gt;; <br>
&gt; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt; Cc: Kitchen, Greg &lt;Greg.Kitchen@amd.com&gt;<br>
&gt; Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only =
<br>
&gt; read premission in ONEVF mode<br>
&gt; <br>
&gt; [AMD Official Use Only]<br>
&gt; <br>
&gt; Hi Lijo and Evan,<br>
&gt; <br>
&gt; Could you please advice Marina on how to go about this? Does driver <b=
r>
&gt; have a mechanism to distinguish between ONEVF and PASSTHROUGH case?<br=
>
&gt; <br>
&gt; Best Regards,<br>
&gt; Harish<br>
&gt; <br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of <br>
&gt; Kasiviswanathan, Harish<br>
&gt; Sent: Monday, December 13, 2021 12:40 PM<br>
&gt; To: Nikolic, Marina &lt;Marina.Nikolic@amd.com&gt;; amd- <br>
&gt; gfx@lists.freedesktop.org<br>
&gt; Cc: Nikolic, Marina &lt;Marina.Nikolic@amd.com&gt;<br>
&gt; Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only =
<br>
&gt; read premission in ONEVF mode<br>
&gt; <br>
&gt; [AMD Official Use Only]<br>
&gt; <br>
&gt; Some comment inline.<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of <br>
&gt; Marina Nikolic<br>
&gt; Sent: Friday, December 10, 2021 10:06 AM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Nikolic, Marina &lt;Marina.Nikolic@amd.com&gt;<br>
&gt; Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read=
 <br>
&gt; premission in ONEVF mode<br>
&gt; <br>
&gt; =3D=3D Description =3D=3D<br>
&gt; Due to security reasons setting through sysfs should only be allowed <=
br>
&gt; in passthrough mode.<br>
&gt; Options that are not mapped as SMU messages do not have any mechanizm =
<br>
&gt; to distinguish between passthorugh, onevf and mutivf usecase.<br>
&gt; A unified approach is needed.<br>
&gt; <br>
&gt; =3D=3D Changes =3D=3D<br>
&gt; This patch introduces a new mechanizm to distinguish ONEVF and <br>
&gt; PASSTHROUGH<br>
&gt; <br>
&gt; [HK]: It is not clear how you distinguish between ONEVF and PASSTHROUG=
H.<br>
&gt; Could you please elaborate?<br>
&gt; <br>
&gt; use case on sysfs level<br>
&gt; and prohibit setting (writting to sysfs).<br>
&gt; It also applies the new mechanizm on pp_dpm_sclk sysfs file.<br>
&gt; <br>
&gt; =3D=3D Test =3D=3D<br>
&gt; Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.<br=
>
&gt; Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:<br>
&gt; &quot;calling process does not have sufficient permission to execute a=
 command&quot;.<br>
&gt; Sysfs pp_dpm_sclk will not be created in MULTIVF mode.<br>
&gt; <br>
&gt; Signed-off-by: Marina Nikolic &lt;marina.nikolic@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp; | 4 +=
+--<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h | 4 ++++<br>
&gt;&nbsp; 2 files changed, 6 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; index 082539c70fd4..0ccc23ee76a8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; @@ -2021,7 +2021,7 @@ static struct amdgpu_device_attr <br>
&gt; amdgpu_device_attrs[] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(pp_cur=
_state,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ON=
EVF),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_for=
ce_state,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ON=
EVF),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_tab=
le,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ON=
EVF),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RRW(pp_dpm_sclk,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC, ATTR_FLAG_O=
NEVF),<br>
&gt; <br>
&gt; [HK]: Wouldn't this macro try to create two sysfs entries with same na=
me.<br>
&gt; The second time the function would fail.<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_dpm=
_mclk,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ON=
EVF),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_dpm=
_socclk,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ON=
EVF),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_dpm=
_fclk,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ON=
EVF),<br>
&gt; @@ -3504,7 +3504,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device<br=
>
&gt; *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SRIOV_VF_MODE_BARE_META=
L:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D ATTR_FLAG_MASK_ALL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D ATTR_FLAG_BASIC;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h<br>
&gt; b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h<br>
&gt; index a920515e2274..1a30d9c48d13 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h<br>
&gt; @@ -79,6 +79,10 @@ struct amdgpu_device_attr_entry {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; amdgpu_get_##_name, NULL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; _flags, ##__VA_ARGS__)<br>
&gt; <br>
&gt; +#define AMDGPU_DEVICE_ATTR_RRW(_name, _flags_full,<br>
&gt; _flags_restricted, ...)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(_nam=
e, _flags_full, ##__VA_ARGS__),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(_nam=
e, _flags_restricted,<br>
&gt; ##__VA_ARGS__)<br>
&gt; +<br>
&gt;&nbsp; int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);&nbsp; int =
<br>
&gt; amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);&nbsp; void <br>
&gt; amdgpu_pm_sysfs_fini(struct amdgpu_device *adev);<br>
&gt; --<br>
&gt; 2.20.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB43004466F568E846C9AD44418E759DM6PR12MB4300namp_--
