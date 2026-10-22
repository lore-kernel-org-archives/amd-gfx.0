Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A80606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gLy1FLIE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAF7910E126;
	Thu, 22 Oct 2026 02:35:55 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013041.outbound.protection.outlook.com
 [40.107.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F98A10E126
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 02:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZzwlfgnponF5gTQrvUfqbA8bGCGR8qYK9upsB6WIbvU/1kqkmuSV+GQbkBm+QBq+KTKyf2D6vfnAMpdZF2JFNGPHtm7+S0k8V/qpLmeUEBPpfqdxiC3mFigime7CPw/GnnVbKV+f5exrhMOevBLnmayZyOtht8PJxNcc6MYJqPtZNYMs6V/Pe4l4/4hRJeQCzHq7GuuCsiPp5MyPm+yTwtAVK9TFXh3O+hJILJTjIFaaNSnC73yyC0BseZlwJwrVeccQhcEU1pfyLkzply7Ihrh58Yt2nCml1Se8eMuux2GoR+qpwZ+47g0mJ8rRQ4Kvw9/CjEY85lVERc4J/OtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjAEWV26zDUH3IwRPZfDJr9N/aixHA1L6sEPkHbgxFs=;
 b=CO9dJJGO0Yh4NJ2sDjWP0UFRQaaTVDGENn9VsTjaCeRKLEv0R2N/HkWBCdiN80ciXAr3+Iz3LjJEfxistTuKFisW9GEoTZJ1UN0nJ202FwbjxKkZ0j/qJ0EZFgVgvcCBK6ly84xOO8c0wdW3z7SPm9QeOoEtlo/JX94C+LLjJyaM9LFEbdbJnCvgPB2MnjZM9P9LxCg8y9V/OhqgQ0QUjO0XF+pX3GIRSF50FLguE9raW9+irGyj6AiiOIFwOZ0Kpt7xsBN3/rKoZvZUXgBHFCgt7X2W+VCouhmQ0LwqhBgmoO+BByD8SUIMTi2K1e6+GWX9RTG0QILq530Teb1nFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjAEWV26zDUH3IwRPZfDJr9N/aixHA1L6sEPkHbgxFs=;
 b=gLy1FLIEM9kejYexhfI4ckKd50QDf7zMWtJLIrWV7oj7XKRhjzfgObvQwQbsMy64eOf8Dwv9z51PKBCUqARNhh0V/EZfN9nl/cjS0Ms+p0i75YXZarTqJb9fp+zC4Rh+274I7fL4w4r0ZK834mDyNhi0fOXhQfJIW9XM90vMNhs=
Received: from BN9PR12MB5258.namprd12.prod.outlook.com (2603:10b6:408:11f::20)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 02:35:45 +0000
Received: from BN9PR12MB5258.namprd12.prod.outlook.com
 ([fe80::3420:a950:a599:eeab]) by BN9PR12MB5258.namprd12.prod.outlook.com
 ([fe80::3420:a950:a599:eeab%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 02:35:45 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Gadre, Mangesh"
 <Mangesh.Gadre@amd.com>
Subject: Re: [PATCH] drm/amdgpu: skip RAS error count reset in debug mode
Thread-Topic: [PATCH] drm/amdgpu: skip RAS error count reset in debug mode
Thread-Index: AQHdYTza2Jb51G62YUyVrQsoErMt+LcIzIoAgAAMt0o=
Date: Thu, 22 Oct 2026 02:35:45 +0000
Message-ID: <BN9PR12MB525882B57116D93B788066B09D652@BN9PR12MB5258.namprd12.prod.outlook.com>
References: <20261021091607.245415-1-cesun102@amd.com>
 <BN7PPFFF39339DD155315E1E27AD5DFB060FC652@BN7PPFFF39339DD.namprd12.prod.outlook.com>
In-Reply-To: <BN7PPFFF39339DD155315E1E27AD5DFB060FC652@BN7PPFFF39339DD.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-22T02:35:44.472Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5258:EE_|CY8PR12MB7315:EE_
x-ms-office365-filtering-correlation-id: e1f87d21-a5f2-4eee-91fd-08df2fe52c9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18092099006|22082099003|10067099003|18002099003|10086099003|261021123027099003|8096899003|4143699003|261009223027099003|11063799006|5023799004|261021121427099003|56012099006|38070700021;
x-microsoft-antispam-message-info: Tq/V2K0TJGU22zQYA1qne2Lxo69PG4KZhhr5zqtqAmQpDj+Pq9wpB3a/XPCpdg7/yYJ3vxOrA6NMQGq+8hhiwE/E8CcHTY8r8Q4oAQWhq1njzfNqXWx2Mvwzz+tBSr0187t6IbNhSoLjTCZ0rhtCOHxl3wCjWLcaDkzUnJBXlVIAXffucU7J7TQvyNzLInGJRG0xFqvmnsU9JMrRTFbnY/mIEx7AuPBslxw94jtJxtwQl7NZ/H5dMshBdi2XDMFsz2BgQvFDRwZwdwJ5k+s5KNlm9MC1tkxQTBeNMuqXaqIGmwDonnh4SfFkSEpQ1hhMaVs2EZfrWQhp6Ry0a5RleLr6+ZmB7NmXCWBXgJRcGal4ZLNxRg4IFCMJLBseK1E1bTu+ZjXAUXwyNvG09Uc60dqdDgid46XHPowoHfOS3PM4lIeVk0lNtHiTh8XKhMrw1w4k6W9bGJTf0od2I/ls2DBpSyXyTU/ShsfCRFnN0w1Bl+RzkSbPeYcSLJYRIykGptzpI0JCMgMETu83FYggTf0cPTyQPvq4AQpG5u1PTxDFTVd3PBBKWDuuvycPMKymxCiFIaYqkzVZoTLeVLd05zfy76iWkN5kt47c7r0dtFOi+7AV7Z6awuwTUT1SozHNp6vcn0Yx7YmUwWhn38xHRNF6+YEao/v5TG9SYelugoCs3skH27lEir3Hs+OsIMj+cgmkLki9CM1QjsnQWI3hoWb1P/M2xdKGHofYZ/kiDf0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5258.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18092099006)(22082099003)(10067099003)(18002099003)(10086099003)(261021123027099003)(8096899003)(4143699003)(261009223027099003)(11063799006)(5023799004)(261021121427099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BFxCpiZf1aYob9NrRCDgdP5SIEeNAyy88s20WqvDEynzOBX4PRfjx3sjgEnZ?=
 =?us-ascii?Q?jJK63/ANkFdVq1nbJx7zs54b7MpdaEeOS2ThO8QqMvdPRiI8KmndGoDD+PmN?=
 =?us-ascii?Q?3UMhQRs1xwIJkkmZShn2amwLcYsDgCMQeCjexsklpF+wUGa/6nNkvrU24umf?=
 =?us-ascii?Q?NyAsM0qeELiyyONX5P5Y5nFca07KcCz/HSUAwCInUesy74w0WAx9KHPK2oVc?=
 =?us-ascii?Q?U01oTLaUhWIjCGphSBCNLAI23MTUA5Qf0yINa7DyLb4fBbBgJiKeFtHFMQgx?=
 =?us-ascii?Q?EEPw1wv0wm/3MIuLAganTgsmYNHLp4j1cb+onuEJzJX7zvmQS4U6rtSoQqWp?=
 =?us-ascii?Q?bOp6NpR+1tE4luHwi1qeNHFO0X9hBeWVb28crQSMz59IROMlkHPmzwvWh42U?=
 =?us-ascii?Q?n+DkqnC38eZTduD7AJeKXd3QvKtXECiqAa1dtEhjE2vPeErhfXvbwLt9KQfk?=
 =?us-ascii?Q?SLGzeQO4p+YnFRVy1XqZ6kGdsiUoQ9zJgMTI6HTG5gjp0WrR19Shx7X2zkDB?=
 =?us-ascii?Q?CgdEBg7u/GJ08vOTojDkoEQYOKIiXF1yXxQNPim6nkJbArITrG6XsEn2g2Su?=
 =?us-ascii?Q?SFadUvBvbMgXxtx/SJlamL3o58Zy76/CRCa8G5d/pJ6Qtv4orjCm++95etwc?=
 =?us-ascii?Q?4kqPuyfYxxBv1QR6nWnFzhVvvenohQkxIim2ubCzJA8G596MQdCv4DQcfbQt?=
 =?us-ascii?Q?4OZ8Q+bh3aT8rOvaTAsslss9XPuDqt1QLtLXjT1RjD6vRfrGWW6HOmx9XhoI?=
 =?us-ascii?Q?D9LTzS8CdbOzyAazCQoCUO5KTOTd2nb3Q7xXKl1wlA42d/vnEn5hz976Xh5T?=
 =?us-ascii?Q?smfS56j4ppaac9cBt/ynyIsKjnQvQTQP+tlF7tUY+ptfj9cIKvmGbaDIaVf2?=
 =?us-ascii?Q?zqjEsBOHWU/I4jg67Jbj5vq2ZesBbSXjOjjAF+EozewblPhMKdgJC8i8vr06?=
 =?us-ascii?Q?h3LYvrgcOq6JsMvryyhuqaTbn2TxVFrUa9jand2FZUJuwXHS3CbnfKyN02Jq?=
 =?us-ascii?Q?DV+TKTKOyUw+ggiyAhVXRB1C4h6OXvBrmSuEGvjVayOrL4Gi8uS2XyRe2T77?=
 =?us-ascii?Q?x4wg8AIWM09V7zhepMV6PSjCVu1IpMjnP8Yfr77vneKEnPibK4s8NePX3YVJ?=
 =?us-ascii?Q?LiKztzJ3LQ9LDJSVv3CSrOQ9RmWCb7guUMHrxEyDwB/RnEgAoPFvIx+VJIbF?=
 =?us-ascii?Q?2CI7OR4eGQkETK78e9El3cz+huB7HDrlWdWPnLpu+EdnN5TQRsWZBg5IdNAx?=
 =?us-ascii?Q?TTS+7tEuqjUJzMJrPF/vbJAKqQlH3NSobsK58NiWuxPxMsog/fbavcrmlKib?=
 =?us-ascii?Q?1GoX8HPJnKgouZ94wx29Ck/QzmBODNDrbR3bcW3A7CehJyEkovq/l1zWA0nf?=
 =?us-ascii?Q?N5CNPQRJv/sKSUtGE9ECGV9B7Zhf+rf3OwTfyE5F7YGBpZEaFsbD1p1muXqV?=
 =?us-ascii?Q?R9rZwQwRgM8UDdOdew3npe4ifqRjLc6RtKoxab8NlN0LzewRsi8tpqwOOo+l?=
 =?us-ascii?Q?DUkOTRDzQcayjivA2IVqTtDGOM6DXORJGpiKF0gxBQwV1iKE9890ZmQ4wJLp?=
 =?us-ascii?Q?0Ldwx/DaxpQDBlHhaxbd2CwMDPkdgFh4EwEy8AKIpQHycb22njl9u2c64qHy?=
 =?us-ascii?Q?Y+cuf19VC7ioP7rFIDfTt0dXAG4tZUE5xyHTfviFdX7pLZ5sic0FgfEE3X0W?=
 =?us-ascii?Q?xpMKhboYk7u+79an9fuP/trerl4+XnLupjuX8R2e2xLdgmLT?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB525882B57116D93B788066B09D652BN9PR12MB5258namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f87d21-a5f2-4eee-91fd-08df2fe52c9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 02:35:45.1639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxQWa63jgFXBzmTuhBBSCNKdYKkTyrEDaGE+wvxFlgIn2UGTI316wYeiehdUQOZW/ucp0LPlM50RaTPaGD22xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_BN9PR12MB525882B57116D93B788066B09D652BN9PR12MB5258namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi Hawking,
Thanks for the review. The current changes are based on the legacy RAS impl=
ementation approach.
I'll further investigate the specific reset operation that is triggering th=
e security violation. In the meantime, I'll also try modifying the flow by =
either skipping the reset for the affected IPs or removing the direct reset=
 call altogether where the security violation occurs.

Regards,
Ce

________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Thursday, October 22, 2026 9:49 AM
To: Sun, Ce(Overlord) <Ce.Sun@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yan=
g, Stanley <Stanley.Yang@amd.com>; Gadre, Mangesh <Mangesh.Gadre@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip RAS error count reset in debug mode

AMD General

Hi @Sun, Ce(Overlord)<mailto:Ce.Sun@amd.com>,

Have we identified the specific reset operation that is triggering the secu=
rity violation?

Would it make more sense to skip the reset, or remove the direct reset call=
 for the IPs where the security violation occurs?

In general, a reset is still required on some GFX v9_4_3 products to preven=
t stale or invalid error-counter data from being reported at initialization=
 time.

Regards,
Hawking

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Wednesday, October 21, 2026 5:16 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Gadre, Mangesh <Mangesh.Gadre@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: skip RAS error count reset in debug mode

Fixes: c65c9fc19b6e ("drm/amdgpu: retire legacy ACA support")

After legacy ACA support was retired, some ASICs systems may trigger securi=
ty violations during driver load when
amdgpu_ras_reset_error_count() is invoked in debug mode.

The function only checks whether RAS is supported for the target block befo=
re proceeding. In debug mode, ACA/RAS handling is not available and attempt=
ing to access the reset path can lead to unexpected HW accesses, resulting =
in security violation reports during driver initialization.

Prevent this by treating debug mode as unsupported for RAS error count rese=
t and return -EOPNOTSUPP early.

Signed-off-by: Ce Sun <cesun102@amd.com<mailto:cesun102@amd.com>>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 557baca454a9..e8a4fe22317f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1506,7 +1506,8 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device=
 *adev,
                 return -EOPNOTSUPP;
         }

-       if (!amdgpu_ras_is_supported(adev, block))
+       if (!amdgpu_ras_is_supported(adev, block) ||
+           !amdgpu_ras_mgr_get_debug_mode(adev))
                 return -EOPNOTSUPP;

         if (amdgpu_sriov_vf(adev))
--
2.34.1


--_000_BN9PR12MB525882B57116D93B788066B09D652BN9PR12MB5258namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">
Hi Hawking,</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">
Thanks for the review. The current changes are based on the legacy RAS impl=
ementation approach.</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">
I'll further investigate the specific reset operation that is triggering th=
e security violation. In the meantime, I'll also try modifying the flow by =
either skipping the reset for the affected IPs or removing the direct reset=
 call altogether where the security
 violation occurs.</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
Regards,<br>
Ce</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Thursday, October 22, 2026 9:49 AM<br>
<b>To:</b> Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Zhou1, Tao &lt;Tao.Zho=
u1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Gadre, Mangesh =
&lt;Mangesh.Gadre@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: skip RAS error count reset in debug=
 mode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Calibri" size=3D"2"><span style=
=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">AMD=
 General<br>
</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hi <=
a href=3D"mailto:Ce.Sun@amd.com">
<font color=3D"#2B579A"><span style=3D"background-color:#E1DFDD;">@Sun, Ce(=
Overlord)</span></font></a>,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Have=
 we identified the specific reset operation that is triggering the security=
 violation?</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Woul=
d it make more sense to skip the reset, or remove the direct reset call for=
 the IPs where the security violation occurs?</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">In g=
eneral, a reset is still required on some GFX v9_4_3 products to prevent st=
ale or invalid error-counter data from being reported at initialization tim=
e.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hawk=
ing</span></font></div>
<a name=3D"_MailEndCompose"></a>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>
From: Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt; <br>
Sent: Wednesday, October 21, 2026 5:16 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Chai, Thomas &lt;YiPeng.C=
hai@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;St=
anley.Yang@amd.com&gt;; Gadre, Mangesh &lt;Mangesh.Gadre@amd.com&gt;; Sun, =
Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: skip RAS error count reset in debug mode</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Fixe=
s: c65c9fc19b6e (&quot;drm/amdgpu: retire legacy ACA support&quot;)</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Afte=
r legacy ACA support was retired, some ASICs systems may trigger security v=
iolations during driver load when</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">amdg=
pu_ras_reset_error_count() is invoked in debug mode.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
function only checks whether RAS is supported for the target block before p=
roceeding. In debug mode, ACA/RAS handling is not available and attempting =
to access the reset path can lead to unexpected
 HW accesses, resulting in security violation reports during driver initial=
ization.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Prev=
ent this by treating debug mode as unsupported for RAS error count reset an=
d return -EOPNOTSUPP early.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Ce Sun &lt;<a href=3D"mailto:cesun102@amd.com">cesun102@amd.com<=
/a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">1 fi=
le changed, 2 insertions(+), 1 deletion(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 557baca454a9..e8a4fe22317f 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1506,7 +1506,8 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *ad=
ev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_is_supported(adev, block)=
)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_is_supported(adev, block)=
 ||</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu_ras_mgr_g=
et_debug_mode(adev))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font></div>
</body>
</html>

--_000_BN9PR12MB525882B57116D93B788066B09D652BN9PR12MB5258namp_--
