Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DDBC19F2D
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Aug 2022 03:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 005439D1E5;
	Tue, 16 Aug 2022 03:51:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED70112B9B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 03:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffbK7tLZBzisHbaal3hV8jkannV/P37rkJ71B3g49GSRErbs3APnw9vDcdIbcLvKZL1kcjv9bMvNKIO58PM6E2hj8exzX2CohMF6HB4nX1FFZEVFMpgkyun+U3ewii5xUH70+HIVihPitgoUuvH3KmrB+zKTNHUX8DqKFotmISlubYAyyOtumqY/0caBVWsmNBKliJOsjlLTgiaMzko/4SsAniTvuE8SXmv1S3hjVH12YlpvrIgnk3ElrhiAvPP+8OyW+QcRRhSW5GpTvVNqRIoYX9v+5J7w1/u6s3sj7jpfXD2Cnyo1ZOWuS5Zh5VOHWh9PXscjPPk/gKFLvZs7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkiuoS+gpylxWeUtV9y7NfHHkfj1L/Nm7d34w8JuvEE=;
 b=Olyj9QL8WyxHkb/yHFu4Teb/K2JXE0OwYpmIY9oGTNwsNRzxMOWJllD4MMd4YQyyiWtFHU18CdO6FtI7kcgQdGOas8h5ZQF8SPSQCMBK+HzLMUoPpWcg5SZV0J7yMfzURoF2pOq41jE33d7bnQ7PoccpA4p5WBE1L6bdqyRwocvNyPXgelfYQfcKy/p9bZXxRlqzgw38EKTK0xOvmRvOXCcGSCXvtUQl9n7mLTib6ILVJq+Ujzb5bkKnoK5bG0FAD+WtWdc/DnPSYxXw1IWAjriLm26zqRnWr5MW5i3DWpGhStDTtnFwLrCnrBtdt+s2GfvmjLef3530Gap36yJcwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkiuoS+gpylxWeUtV9y7NfHHkfj1L/Nm7d34w8JuvEE=;
 b=wI+uQxDjdVT0JFLfRkguHAV6PxvrdTnlafYNcchRY0R+TNWkP4j6cnUt+PREXQyKOyVtk2oVpoL77YfbB0iJ+dUcSGKuer/SWayxJkbFtRSzyPLVrYS0WX3Mas78eFdmNH25oLWHHsrtMuDNhwn+Ib+zYhU0hCSxyx4T2DmYOZg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:75::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 03:50:36 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe%9]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 03:50:36 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device
 needs to be earlier than psp_hw_fini
Thread-Topic: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device
 needs to be earlier than psp_hw_fini
Thread-Index: AQHYrivZQ1ZxQc5EMEu67MeMVCuf/a2vjbKAgAFb3jCAAACt3A==
Date: Tue, 16 Aug 2022 03:50:36 +0000
Message-ID: <BN9PR12MB52578F51FC2A5E2915A6BA56FC6B9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220812091317.338637-1-YiPeng.Chai@amd.com>
 <CH2PR12MB4215CBF380BB28417AB5C82AFC689@CH2PR12MB4215.namprd12.prod.outlook.com>
 <BN9PR12MB52573C7C4242760F14E0AC2DFC6B9@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52573C7C4242760F14E0AC2DFC6B9@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-16T03:49:47.0000000Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56ef4482-7cc1-4f0f-528a-08da7f3a7a9c
x-ms-traffictypediagnostic: SN6PR12MB2639:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GeeDRXgLVsVe2uERvzNFiZRa4pYeceNNQuIhbQUrMBYO1V+ZfiMBhpFjeFdvsKAcjtb+xzYrMitFqJX4n4UUv6QnKZO+p6njtJ7C2bymcOQVQAo+1Z1KhKtfAuioYzkAKtyCzKHB+EygkqXLbmYlN4Q/mdgwXDhdAW8PjaqxiYvVd4NsbOzWAISsdKJQUhFUpmiD0n7mgEAyBD/6cy5aMAKiJmhbmPj0VtB4BcFLcULoWQ71gKk3DQVyewr2v+nzQJ/TjtR+1VU0DbHU5AAlDfYSUXr3NPx6F8hbnSVbJZ2AmovN4tuhifmzCvQxHJ7ADbs5IJxXsHrQvRX9+UTdCZu1d3LQ3pQf/42YcwV4fomSswFWFXTph0Wj4zdvGGjS+K7lw7zFAoEddd1AsDg9/mKqIksP4VO+mRHFo5HXJ6XneFCi2TgQKavR+9FRElhGeFFx9N5lHlTqPtyTHkL7z56pgs3gLo5kEWyV4rfcOJwlOHsf+u7IFuJa+URcuJR2abfNprKAGmQdypy6uNwfbN2fpmmqV6sz3HUoD+HI2vzW97TvcUESCRjley/t6W0FS49kF0/X/8hvOOSpWRTebQ3dKLITFkGaQ7Blzsixg0GvE0roPeQaBxByGJd569hXXSsJTDCTSr3Jh/HBZqkzpqkkovBDIAvBgu9pgR+EBOeE/632LsrTKMKvC/5jmMzGOq5V2VCGAcrfoSrm2Rxeem1F1qPAt1XRxJmfFOf2rkZq6smUMigjY+Zyl24PVecPZuccz7m8AbvwIBWpkoI0oiVRNINPaSo+GEQBDLyM+ruQDfulki7o033lv/R5BH0p
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(53546011)(316002)(64756008)(38100700002)(66556008)(8676002)(4326008)(83380400001)(76116006)(478600001)(91956017)(66946007)(66446008)(110136005)(2906002)(86362001)(26005)(55016003)(33656002)(5660300002)(8936002)(52536014)(9686003)(6506007)(122000001)(71200400001)(41300700001)(66476007)(186003)(38070700005)(2940100002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NVWUHb5tUEH3uCdEiUjQC3LYpqtnsdAgdRanCG2XQnD/6qfbKAfy3lAE2DPq?=
 =?us-ascii?Q?FcS25QPuNLTYMo9YAi9W8C6irEg3rzezyZNUHQaJGKOKg5CJT63vTJhdCs3/?=
 =?us-ascii?Q?q0cZFkMpoA+sT4aUaISmLwkd+OqceLDG5tIo3m3bWC21xTDPBxoHMf7mS7ux?=
 =?us-ascii?Q?EVTqVkzvIep5drCpi1yv7QDagt5OE2ZWb02DjdjRR+T/7Urm3iAruE0vZKOH?=
 =?us-ascii?Q?Q7XFVZlHo0QuvP+lbnRpiIc8xO7lSpjOsibcEijApuKen/nO57/8fjLi0mMV?=
 =?us-ascii?Q?h2H8TsT+WaYTaZcXC1GFdO9VG+9eTlh1Z/EPcjuRnzciImYr3InWM9p71NCn?=
 =?us-ascii?Q?1bFyz1QlQfXemBwYM8G8mC1xuQ/APZeG4VnRaCx6ySTjVcjq0K8cBWbByjnl?=
 =?us-ascii?Q?yf+MuZHFM+FkcYsbyooIFKNvNo4FaB73gPYkP3FIzuetcuVNOZ4Grdq+E1d0?=
 =?us-ascii?Q?RzhDZ0qT/aS4fksHDM9e3Yz9RwgoH5sNmPZewh2Q3fA/MAdXn7GE30kx7cWe?=
 =?us-ascii?Q?UyZBDT92HP2KPWFQMfufkMYnl4jisvibTt6Pj6QdihT2i1EVX72I0+gVOBYm?=
 =?us-ascii?Q?r1vu7QshNcrUqBp56w0MLtOCe9aoSeAZHPDoM95t8SbszX/+68ZXDZX+Dof7?=
 =?us-ascii?Q?FcVRFpkdr3IDm4RxZbn5THk/BXWiIyLvaTg36ElDLuE5KiGneSQ4ehJ0rd8D?=
 =?us-ascii?Q?P3Ka81GCXwpoBJsU9Hfof9svLxzgo/ssNemCQtPiYPBcnq5de77U2gX2UJaf?=
 =?us-ascii?Q?xnpGJzIVPf3SyUsX6mSOiGKH9ceF5pdC4s3T5SjJm0biNuRNQqyYWURkVeRl?=
 =?us-ascii?Q?QudB1sSfhDtDCcz7OQTEiVqbaM+JjxP/MmdET/aX9o1OW+ffUsNYrqKk12ZJ?=
 =?us-ascii?Q?lhJA4nlmId8mHH1eIJBqiWrV01ZTtrMI9+yjDNY61/+/YbQedUs+CFnc8aXd?=
 =?us-ascii?Q?yQu0gTNHMuPr6hMEgc+LKLYABP9BTK9gimBGDdS9Gt0T+kf1jCkvcDX4i9ke?=
 =?us-ascii?Q?ms6rVTFQKac1Hw0K/vcmuVLydAEOk+o7jZ/IHun3rOQwFsIn/jVQWNQ6eJtK?=
 =?us-ascii?Q?R5wTbh8stS82iFXRiAklX6e7YtIIzUxcRjSW05Niw0cHt9KgXKfkm4ZXItTi?=
 =?us-ascii?Q?Z+NexxJrb79lBqIsT0X0084ZsvvvuMeyH4oxe/Mm5jSa7hgADfiTqpV3tIKf?=
 =?us-ascii?Q?Bb5MAYQdjX8ZXGlwuEpB1U3D/S+SQn1zJ/9naONVD8RcACidwrx4x4Bq6VJm?=
 =?us-ascii?Q?WASAhkjMIy5kF81cwpg05IXrFL4UtuaeZzK52XossfFioUQnhjMR07F1SHG0?=
 =?us-ascii?Q?PqibSpXKVAswpoEemrhy8Y3spCPxzkPDs4jhg/FbcECkDsJpeAzO9y0ry+ax?=
 =?us-ascii?Q?nFCR7n5mjF04Lq7btvbt9piWMf6HUjPN5FLa2uc5X8KJakpvoow+MT8LLNkj?=
 =?us-ascii?Q?eHk0XbL70bTbkVVcR98WLBZE0IEdp9X4Eo1gcn+cX+5HxaoQD6KMHX8rUyAp?=
 =?us-ascii?Q?2VwZuCbw902kk51Y28URATNsRbY7afU9l0jfo5XoHhkWX+Pm01TYHKFFdopT?=
 =?us-ascii?Q?fYOVuXs0tzBrX00+OGUHLyugH7D2lbFo8JH++XjBrPlMth63vWOczVTieJXv?=
 =?us-ascii?Q?0w=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52578F51FC2A5E2915A6BA56FC6B9BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ef4482-7cc1-4f0f-528a-08da7f3a7a9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 03:50:36.8085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pnim0vebzbmDYP1WLpJ2d2FDrC0T8LintjB+ddCEDLqpRV6Y5FqpEta2CwXW5dk5aOgKrcvBK9xRY/mY8LN2kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2639
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB52578F51FC2A5E2915A6BA56FC6B9BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Fixed typo

Regards,
Hawking

From: Zhang, Hawking <Hawking.Zhang@amd.com>
Date: Tuesday, August 16, 2022 at 11:49
To: Chai, Thomas <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device =
needs to be earlier than psp_hw_fini
[AMD Official Use Only - General]

Alternatively, it might be better split xgmi ta terminate from xgmi_remove_=
device. In psp_hw_fini, check ta->fw and num_of_physical_mode to terminate =
xgmi ta. and make amdgpu_xgmi_remove_device only deal with software fini, l=
ike add_device.

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Monday, August 15, 2022 15:03
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device =
needs to be earlier than psp_hw_fini

[AMD Official Use Only - General]

Ping on this series.

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
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

         amdgpu_amdkfd_suspend(adev, false);

+       if (adev->gmc.xgmi.num_physical_nodes > 1)
+               amdgpu_xgmi_remove_device(adev);
+
         /* Workaroud for ASICs need to disable SMC first */
         amdgpu_device_smu_fini_early(adev);

@@ -2830,9 +2833,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device=
 *adev)
         if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
                 amdgpu_virt_release_ras_err_handler_data(adev);

-       if (adev->gmc.xgmi.num_physical_nodes > 1)
-               amdgpu_xgmi_remove_device(adev);
-
         amdgpu_amdkfd_device_fini_sw(adev);

         for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
--
2.25.1

--_000_BN9PR12MB52578F51FC2A5E2915A6BA56FC6B9BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
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
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Fixed typo<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<br>
Hawking<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Zhang, Hawking &lt;=
Hawking.Zhang@amd.com&gt;<br>
<b>Date: </b>Tuesday, August 16, 2022 at 11:49<br>
<b>To: </b>Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;, amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc: </b>Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;<br>
<b>Subject: </b>RE: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_=
device needs to be earlier than psp_hw_fini<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[AMD Official Use O=
nly - General]<br>
<br>
Alternatively, it might be better split xgmi ta terminate from xgmi_remove_=
device. In psp_hw_fini, check ta-&gt;fw and num_of_physical_mode to termina=
te xgmi ta. and make amdgpu_xgmi_remove_device only deal with software fini=
, like add_device.<br>
<br>
Regards,<br>
Hawking<br>
<br>
-----Original Message-----<br>
From: Chai, Thomas &lt;YiPeng.Chai@amd.com&gt; <br>
Sent: Monday, August 15, 2022 15:03<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Wang, Yang(Kevin) &lt;Kev=
inYang.Wang@amd.com&gt;<br>
Subject: RE: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device =
needs to be earlier than psp_hw_fini<br>
<br>
[AMD Official Use Only - General]<br>
<br>
Ping on this series.<br>
<br>
-----Original Message-----<br>
From: Chai, Thomas &lt;YiPeng.Chai@amd.com&gt; <br>
Sent: Friday, August 12, 2022 5:13 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zh=
ang@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Chai, Th=
omas &lt;YiPeng.Chai@amd.com&gt;<br>
Subject: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device need=
s to be earlier than psp_hw_fini<br>
<br>
The amdgpu_xgmi_remove_device function will send unload command to psp thro=
ugh psp ring to terminate xgmi, but psp ring has been destroyed in psp_hw_f=
ini.<br>
<br>
Signed-off-by: YiPeng Chai &lt;YiPeng.Chai@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---<br>
&nbsp;1 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index c84fdef0ac45..2445255bbf01 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2787,6 +2787,9 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_=
device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_suspend(adev=
, false);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_physical_no=
des &gt; 1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_xgmi_remove_device(adev);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Workaroud for ASICs nee=
d to disable SMC first */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_smu_fini_ear=
ly(adev);<br>
&nbsp;<br>
@@ -2830,9 +2833,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) =
&amp;&amp; adev-&gt;virt.ras_init_done)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_virt_release_ras_err_handler_data(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_physical_no=
des &gt; 1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_xgmi_remove_device(adev);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_device_fini_=
sw(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D adev-&gt;num_ip=
_blocks - 1; i &gt;=3D 0; i--) {<br>
--<br>
2.25.1<o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB52578F51FC2A5E2915A6BA56FC6B9BN9PR12MB5257namp_--
