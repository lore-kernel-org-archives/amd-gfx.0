Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D167BC71153
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 13:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E598D10E2A6;
	Mon, 28 Aug 2023 13:53:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8616410E2A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 13:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESmsbr940hWNIyrZBASGCGYiac2fI4FfkTp7R+2zIDkjSH+zoa9v/Fp5BCzxL3FLljo5Kt9ErCk/50j5tg1O9N75tOrhGRNjWhFcpPMkEnsiNswQ/ma9J55ldFiT66OsUeauAW0fMkFuZ57m1kY4CgTQgWlfkOJgPtwMlk/ZB3OcUFAz40lLCInMr01tfJC45IlE1mBdfnNQ/KcfEx7K1X3VFnEI8vro54tN5+2GnXPqQN24cM7XgBb2iIIxWEubfajiSfIF+u6Rm2kLymuRc/LMjZQZGGUYyovKrvtEF/L794YUxcJlJlDOAhIMjFo2dw92OgPSuNR3lD4MKCsOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmHwr1ljTBU06S3Y0+cww+Ju+Dg3olVt7xbPKpUmJK0=;
 b=Rj0X7ojPFpsEXTZrBePXpclTwDg6ApvsyOquKtw2WTwmkk7jLl+vHYgK1UzwyZzJgVOfdNzE5FisXsxEqgFwBgZnGXGZQ+YXFRfoM7hpjTZUf9738BqyQ8KLPVXGcwqzR5D21ARqlac4d0/xTMVFGV8qOHsq9Nm5bUBrpgAYgnuj01bGrll85E+dX9V+cnDHiY8zqDG1oyYqSCLqX8GW9DFPgxUmqRpAOvwNiJ1vWEIeVIDqHpBq+n21Zut+mHDXhaR96v/TCvdFUPKHoWQPm+36MC9FGtJNL5TxEcsfRleaLa45pLbDPv40wuy5OgOhbOzqsjqBqkc4NlEfmTBt5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmHwr1ljTBU06S3Y0+cww+Ju+Dg3olVt7xbPKpUmJK0=;
 b=SrMUDPGD6OqM6iQR81Khjy/kT+SkyvbAEjHAvAAzz81wB+aepUiaM9cr4quQdFV7steJ65JPp5tVHdP48QWKq/bRjCBm7ezBQJdL17idxi9qOgvIwdLAyAjQAXkM36YnZQxfCRrGGufPaPvz4lL0k9Si36mW7XGX4LXsjclOVqw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 13:53:09 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6208:cab6:bc19:7aa3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6208:cab6:bc19:7aa3%2]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 13:53:09 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Add missing gfx11 MQD manager callbacks
Thread-Topic: [PATCH] drm/amdkfd: Add missing gfx11 MQD manager callbacks
Thread-Index: AQHZ15txZwq600NI3U+q5U2jRwBlZ6//vq0l
Date: Mon, 28 Aug 2023 13:53:09 +0000
Message-ID: <BL1PR12MB5144B2467EDB0DB413D7FF04F7E0A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230825213029.194197-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20230825213029.194197-1-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-28T13:53:08.560Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|LV3PR12MB9265:EE_
x-ms-office365-filtering-correlation-id: 86ecfa40-84ff-490e-c1cb-08dba7ce1ce5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /4WtKwMVLQvENtzlKAzwlMROF+Ij38UdPt7VHGD/IJw7Y5DMU/53WfAefAsuk9mWCmCAFKhGN+Ty+2vEv3he3sgjTgace48OjR+G4+LpUK5goKICt+0WYFM79HtRB56a/pPZiLW4S6MF/u1g9/ZkH9OnN/AKNsZS771sjKieOySB+UUXa1bQvUgJKycEIxMgpvkhZ4ujKSPc97kfvE+/dmHPBJm7o23CTRjyrrE5bV/5RLEkcKGglC8TT7GyiOKoObfzH0M+M6Dv/PztQ0/zaUMQBUrd3yU7AqpotVaSqNJkNXpPvBPE4lW9gL4D9GJqn7WRjacOHlDnBsjaih2N0y8RDabs5q2R8F6oGeaTbvpVUGiCudAdzN8XpLxBLKh1eYYulD/XTrwI4RZBnELz1IzPXnweAHcYw/mTXerxfmXbOvsTMJDf+rEvv9NlO7VTnQBG6i+8qZrHGfcrKGEHSi0SZkCWhISFmIP3I9Jco1xTMmIK0Af82A4507No5qyCjSqAOrcdgo1NMK8Aw1cHVZifNxEEev3Y5ns+aW3Eza8r+haF2/bYX2/Tr8QBkGndJha0x1QIDLFPuxk+CIQwrKnWkpfQqf90KPD3JZzxzwe6csUu0BR01IIKCsaDGP/C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199024)(1800799009)(186009)(83380400001)(478600001)(122000001)(26005)(19627405001)(7696005)(9686003)(53546011)(6506007)(110136005)(71200400001)(55016003)(86362001)(33656002)(2906002)(52536014)(316002)(38100700002)(38070700005)(4326008)(8676002)(66446008)(64756008)(76116006)(41300700001)(66476007)(8936002)(66556008)(66946007)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RSYLup95dASfMN0JxfUUL89uclD/HFwPPswFzZC7pQFraBe36/s/rbsRxlwP?=
 =?us-ascii?Q?zksV0972g+fOgFhVNn85cNN8mT3K1LfL/Y2bShsPEUVsM/yk1SK+HepiD4qX?=
 =?us-ascii?Q?DnFjGuII/FIeKS8sxfxHOzSqW0HEy2QWPLE8onAx8bqX0Yc9hxgnkAYwU3If?=
 =?us-ascii?Q?kaE11fG91zbuijfkeZq2FNDr+k1GVYcadPFVTAKfWBYfOMfY05OH03aTt0/w?=
 =?us-ascii?Q?sqWmSgv7fNAY7dPsXrXk/zigw5WaLO6lEEx/1LHYpyGQFFXCw5x28A9Dfkzf?=
 =?us-ascii?Q?BQVntnZSnshk93pZUVcPmR3PBaElJTbfaBeTR0ZADHbYqmvXBAdazOKYXmFH?=
 =?us-ascii?Q?in8ewLhTB9+auSbbbv3JqMjp/2DsIv+bH0o6Ftv4rFc0aBd7vvOwf2MatVTC?=
 =?us-ascii?Q?u3aoGTKFt5wcw18PuG9eQY5yc81RHPzxx7FkqhebWQe+/qHfRmfrKgLlf1Si?=
 =?us-ascii?Q?Yuy9XW8Mg1dl1wCfoGDuoeaP9+ivRXJm6fQ2VW1sOqWUO+NXwM6SsB16Y3nt?=
 =?us-ascii?Q?xynQ1bJ5YiX6YP920gZ0DOl/wog2mrArQGCbgLCyvdQt+McTZRH45bQoOPph?=
 =?us-ascii?Q?l+zbd4phyvi1m34eLQkZyUeKtdQrQCbCSYYEdzE1TPv9TSl+Q54AE0cPpQwm?=
 =?us-ascii?Q?ajax1sgLmcyl4roYOL+BY4rgOem21Am1QpopxEzTIrv9ZSz/uzQ5J6j9PMHl?=
 =?us-ascii?Q?vxZSFjdsaLgtA/yyBtoDXQrDwPurgkGDEe5GRGwBO50xrrn4ik97LjwUp2N+?=
 =?us-ascii?Q?2t1XcFdxuxa9CAiDBuiYGt8jYuNSKWYzrZF+7ysfaNRyy+z+tpcrc+l+BFYn?=
 =?us-ascii?Q?v0CIqHQsll9Sa6ZuZa+OYkuqrhKdtmWkSWa7BG908/Lx2ARGYC0nTtkYuco/?=
 =?us-ascii?Q?4zBptd4rev8aaxTRGrGW++ojPIdBIYq5o8p+03tlL0Y8JYfu9Ubyq2BvUfx9?=
 =?us-ascii?Q?GahoOBGNQoBmGe+9VUG+hlRQdSctYI2hVluQ2HLPMGwOgclsAh6zzEvhRdSq?=
 =?us-ascii?Q?izMMqklh3BlC55lHcKzWn9noBd4U/8Bo3QY05TJX9Kdp+vFz45lFqwDF+FL2?=
 =?us-ascii?Q?owJ5cnBH8YUi1e3E5PpyTltR/N0uw+xBhK0ErVGPcBVTkY5XnBdd0BC0GHoj?=
 =?us-ascii?Q?tinTVRCv6ydrJbeWx6hXEklm6l2/RcXkwsTWbU1F0XpjX6hw3TazRcHAyCsN?=
 =?us-ascii?Q?SWTUxzPiqJKtwaV/WH36we4vFtorhGvLlNKTckILWt+iuEnwsEaQEa9ur3uK?=
 =?us-ascii?Q?nAz7m/4KYPstD5RxfGgtFsQ/XMJ9fTXSHxMp/BDVy1OP+enb9Nq6kq5wa8aG?=
 =?us-ascii?Q?jYAHuUp8lIxSdHZjCkOUIJ/uoJDqSnN4vxa+FTIqu+/cYVpzl4Vm6dFHGDpn?=
 =?us-ascii?Q?qKpywE7aEiw1/Gzce6ULpSijW1uYMMxqIYEv7WDyAUZctE16osI7MsoJHTwi?=
 =?us-ascii?Q?fg9i8cnaOlt1Q5iFHDHcAdMKu3AkOtUndj0VX3FW8drTScaiXL5yj/JMqQm0?=
 =?us-ascii?Q?sQXU50FMWc/ILCjune69g0bgHnQiszzYGeDHn+Kb6BkZ9D2ZHKfAjYUOConB?=
 =?us-ascii?Q?sBd7aHJZLFUhjY9nbEY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144B2467EDB0DB413D7FF04F7E0ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ecfa40-84ff-490e-c1cb-08dba7ce1ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 13:53:09.2739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XlzVemRNuMJ+G14S7gcankfpoLC9+MBO0eC15zSfaKFlZV0vFu4PaoRwuDY7QYNy65j9tAt7nd7HtJkLb4IAEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9265
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
Cc: "Cornwall, Jay" <Jay.Cornwall@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144B2467EDB0DB413D7FF04F7E0ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Harish K=
asiviswanathan <Harish.Kasiviswanathan@amd.com>
Sent: Friday, August 25, 2023 5:30 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Kasiviswanathan, Harish <Harish.K=
asiviswanathan@amd.com>
Subject: [PATCH] drm/amdkfd: Add missing gfx11 MQD manager callbacks

From: Jay Cornwall <jay.cornwall@amd.com>

mqd_stride function was introduced in commit 129c7b6a0217
("drm/amdkfd: Update MQD management on multi XCC setup")
but not assigned for gfx11. Fixes a NULL dereference in debugfs.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 2319467d2d95..0bbf0edbabd4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -457,6 +457,7 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_T=
YPE type,
                 mqd->is_occupied =3D kfd_is_occupied_cp;
                 mqd->mqd_size =3D sizeof(struct v11_compute_mqd);
                 mqd->get_wave_state =3D get_wave_state;
+               mqd->mqd_stride =3D kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
                 mqd->debugfs_show_mqd =3D debugfs_show_mqd;
 #endif
@@ -472,6 +473,7 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_T=
YPE type,
                 mqd->destroy_mqd =3D destroy_hiq_mqd;
                 mqd->is_occupied =3D kfd_is_occupied_cp;
                 mqd->mqd_size =3D sizeof(struct v11_compute_mqd);
+               mqd->mqd_stride =3D kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
                 mqd->debugfs_show_mqd =3D debugfs_show_mqd;
 #endif
@@ -501,6 +503,7 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_T=
YPE type,
                 mqd->destroy_mqd =3D kfd_destroy_mqd_sdma;
                 mqd->is_occupied =3D kfd_is_occupied_sdma;
                 mqd->mqd_size =3D sizeof(struct v11_sdma_mqd);
+               mqd->mqd_stride =3D kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
                 mqd->debugfs_show_mqd =3D debugfs_show_mqd_sdma;
 #endif
--
2.34.1


--_000_BL1PR12MB5144B2467EDB0DB413D7FF04F7E0ABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Harish Kasiviswanathan &lt;Ha=
rish.Kasiviswanathan@amd.com&gt;<br>
<b>Sent:</b> Friday, August 25, 2023 5:30 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Cornwall, Jay &lt;Jay.Cornwall@amd.com&gt;; Kasiviswanathan, Har=
ish &lt;Harish.Kasiviswanathan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Add missing gfx11 MQD manager callbacks=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Jay Cornwall &lt;jay.cornwall@amd.com&gt;<br=
>
<br>
mqd_stride function was introduced in commit 129c7b6a0217<br>
(&quot;drm/amdkfd: Update MQD management on multi XCC setup&quot;)<br>
but not assigned for gfx11. Fixes a NULL dereference in debugfs.<br>
<br>
Signed-off-by: Jay Cornwall &lt;jay.cornwall@amd.com&gt;<br>
Signed-off-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.com&gt=
;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_mqd_manager_v11.c<br>
index 2319467d2d95..0bbf0edbabd4 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c<br>
@@ -457,6 +457,7 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_T=
YPE type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mqd-&gt;is_occupied =3D kfd_is_occupied_cp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_size =3D sizeof(struct v11_compute_mqd);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mqd-&gt;get_wave_state =3D get_wave_state;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mqd-&gt;mqd_stride =3D kfd_mqd_stride;<br>
&nbsp;#if defined(CONFIG_DEBUG_FS)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mqd-&gt;debugfs_show_mqd =3D debugfs_show_mqd;<br>
&nbsp;#endif<br>
@@ -472,6 +473,7 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_T=
YPE type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mqd-&gt;destroy_mqd =3D destroy_hiq_mqd;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mqd-&gt;is_occupied =3D kfd_is_occupied_cp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_size =3D sizeof(struct v11_compute_mqd);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mqd-&gt;mqd_stride =3D kfd_mqd_stride;<br>
&nbsp;#if defined(CONFIG_DEBUG_FS)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mqd-&gt;debugfs_show_mqd =3D debugfs_show_mqd;<br>
&nbsp;#endif<br>
@@ -501,6 +503,7 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_T=
YPE type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mqd-&gt;destroy_mqd =3D kfd_destroy_mqd_sdma;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mqd-&gt;is_occupied =3D kfd_is_occupied_sdma;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_size =3D sizeof(struct v11_sdma_mqd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mqd-&gt;mqd_stride =3D kfd_mqd_stride;<br>
&nbsp;#if defined(CONFIG_DEBUG_FS)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mqd-&gt;debugfs_show_mqd =3D debugfs_show_mqd_sdma;<b=
r>
&nbsp;#endif<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144B2467EDB0DB413D7FF04F7E0ABL1PR12MB5144namp_--
