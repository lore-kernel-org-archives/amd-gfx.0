Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE71D606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uu7tuI3u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DCF310E008;
	Mon, 16 Nov 2026 01:56:33 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B752710E008
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 01:56:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9TMRKsLMcs2F9MtrzrFH6g2+tWr77lGxE2SbXRVtC0aXPa96M3s0c+DZgG3+UhVO2bStU4UhoeHVw12PWB857CzjBaoKO98jNHMPdXdHNRhuTgjeVkDne62TMBHHCnvLWvjTH91KhFS2A5UYnyj6egUPae6S78CoCyEoqkpbGWPYWLvTq1YWpfGBjKCMEK3WbUQfms7lG9fOxgtPD4NQSjzjc76YD9GNv8YGrGQotfokr/XT3ke13gbxjJFoQewGyd8VIIK0coPa5aSifg3ZkOWlGBwyp6HqOgUEUlCYujE9eIV51wweMEuHQZH1tGMWmUgP9DvnDTGoljrT69ecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Byint96SpCjOtNrciPWGHwyreEznz/yODTA2nfbmpQ=;
 b=A5KvrceiNd0S6f/iuk1zSzb6Zn6TnrQ/bglu1V+0uyEx1tqiitq6OUu1KFNWjTiJWz9xutphBAbp8OwZaC9a0T1pBqgS9FBCIzOlUFwME3mGAwtji2LGB9gmdit/oDzt9FNS8zMYm5tWih7zS4skTEZRdcfRoHblQBnM61zO6sTLbMCc+fGwbIKZM+VSsijJOJQy0bxARgL/edOyWwL/GnR3caxHpGr5l45ekZlqaFhqNNO7KkjaIDIWJbJnjSzVlRGsh4N4gr1aJUiP4AnWucBEPlmHu0b5uL1gcWXXPropbNlwt/IyzZPkL9Va7fX1uk8t4pjVI00CAj21kFY/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Byint96SpCjOtNrciPWGHwyreEznz/yODTA2nfbmpQ=;
 b=uu7tuI3u3DU6pe+DOoqflqCOPOmsVuC+RubE12AXd/dzSMFdo4jJOwpbO3gcs3jh7lemGxMQrVpV5qRbPQ4svNnvL+sAURFRJRB0JXfaoxiG3r6JZ7A5dzLKhfZ248gtCydqDp4vNFp+ayojun8uzRn48qGnBz+TzjH46SR/sw8=
Received: from BN9PR12MB5258.namprd12.prod.outlook.com (2603:10b6:408:11f::20)
 by PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 01:55:23 +0000
Received: from BN9PR12MB5258.namprd12.prod.outlook.com
 ([fe80::3420:a950:a599:eeab]) by BN9PR12MB5258.namprd12.prod.outlook.com
 ([fe80::3420:a950:a599:eeab%6]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 01:55:23 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: Re: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path
Thread-Topic: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path
Thread-Index: AQHdc2MgE3a5866aLk23oF741Y61nLcsJV2AgAPOpaI=
Date: Mon, 16 Nov 2026 01:55:22 +0000
Message-ID: <BN9PR12MB5258298CA6113F58984B6FBD9D7C2@BN9PR12MB5258.namprd12.prod.outlook.com>
References: <20261113032813.352632-1-cesun102@amd.com>
 <DS5PPFFF21E27DCC7BEC4115A3B132AF3BCFC7F2@DS5PPFFF21E27DC.namprd12.prod.outlook.com>
In-Reply-To: <DS5PPFFF21E27DCC7BEC4115A3B132AF3BCFC7F2@DS5PPFFF21E27DC.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T01:55:22.335Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5258:EE_|PH7PR12MB6696:EE_
x-ms-office365-filtering-correlation-id: a0057ebf-700c-4cc2-23d0-08df4384ad32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|10067099003|11063799006|5023799004|4143699003|56012099006|261022105027099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|8096899003;
x-microsoft-antispam-message-info: L7byzMlH84eLC33ssOFYtewrusT9Viq26duoU5MaRqlg2K1DvyTxapg82sQ1EbRIrtPzGFZOdKyvwvVTohxlYhzMNd5NGQlJVpOEW1ZE5cntvp4ZjM2Ea9pVwfM8MegOtQF47nognhd1tYsj5njvM1aoJ+uIhiLTSlKcDuoBu6B95RIbk7IMuFrTRWYWhP+5QcFztX5zyfpLCp9CQYotLMx6+g4abuWStb27XimGr5B+pzCcA5wH6Aa/VObNd2187GaEYTNLQG/20rZsbtEdBtdutPofVqCzRgcLmX1OKwZ6vTvfttdsd7C7Np8+hKzVAaVngg9i4keublckVkp+wdk8//rSQuTPlLBOMdjgrCKnZ7XPQvkcfIeWTfaCxLtTGA7vFkbbf4sU9Pm+1HklPxPirCLnYQ0puE+J0lCQYYbZ5ZLt58NMRWs5czit3dY/rfXJ6UnPWM+Yy3VtNfaBU+/cq8LTR4UOyk5lbNfcWYmCW1kXf4Od5aaE0f4n6Kuxj4+BZ2uXyM3xtfD4+TK7gmkyThJd9IzGbOQQoQcWoDHJTq6lC0vbr9cVnK44ib3er0RXHDaUablFjUI+sGi++Q1lFIbm+MEIqj8wbihHouGF1QjUlzqERAnlYfI4yCSijvK8eQ8HbvIYG8Lf6lkhhTmgVCO+ANjcni+O5srxfXJXrwGsmgG9HhymSv+KeFJx41ttmvS/5wRZMRt4s5S43dlUvmaL+ozxT7TAPK+L+m0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5258.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?qlyHicJDWYujl0KqapJZ6/KCJ8rUxUkU8LFB/l17KAti0bPIdXPVS7+b?=
 =?Windows-1252?Q?F3S6XhLE7DthLZdNWh2Q/uI8h9n6a2lXVCxEO6avi6muy5kVzTJt+Vsu?=
 =?Windows-1252?Q?ibJx8YWRkcx4+31aFpgCWiFC64iKehFLKVCSQhStyn+DILLIIKMOndIV?=
 =?Windows-1252?Q?Wq5hzbQTTovwrCeALM7NJxT8x5/iQyANN0gRsSL7l9/p4/ecdcWkAW+U?=
 =?Windows-1252?Q?ran+KDFFP3fH+BvJ9hjWf38fgUqkXV6I8SJ7cz0M8U78bKX8z1BNXiCJ?=
 =?Windows-1252?Q?181csDXxBmK8xiHSXjTYV8mwamwCEqgofn2nuU3dif59xjKnz4qOOLSc?=
 =?Windows-1252?Q?jJu9O/HauBUKmyvF2GEPDUdz9wQu4Se/59/uoO8CWyV6SfOvm947dl71?=
 =?Windows-1252?Q?5GATVYrTv0orrSgPmsR5XSPSbB3iuoP5DDZyWN8jmsYdqppTmp4XiA3g?=
 =?Windows-1252?Q?4kLXZ1iAI6VuzYQKfePJRBy9Jl7lVAjaYOJjj0Y2HQD6J7wZyBvfCxUu?=
 =?Windows-1252?Q?0OuviySCYQfR2FNms6Q8J5Yor43R3VZkQaWPCcTW01xWgwgb3BWRXMw7?=
 =?Windows-1252?Q?grWzKVjjsWU6PrIjvS3N03fqpRdPbTv7V8gYHXZNwHSRG+RalEJUMw4I?=
 =?Windows-1252?Q?Gxc3IhWWBgesl9fZMkg8j4vtSdQPn1G/RCEVKer9V2zJCZ54eLPtfsc4?=
 =?Windows-1252?Q?0MDXb6z2u3/Lb2ky646wiyUXOenFMmuNPwFzu7YCN4crBQyzeCPtuLD7?=
 =?Windows-1252?Q?+G/YjfQnAePSwdv6fBGN1nqs1ksYJ6OPNcmOkZbpx0Tc69xQAck5YW1Z?=
 =?Windows-1252?Q?J5+8OVYWkzPBeqa3VsODQw6XXv4vWcTXl7RA9u/ws0f8UakAgJDvfL2K?=
 =?Windows-1252?Q?HkB1Di93e5rcswjnmN80KKSLHjIP/zHdEmMlwd7YMbY5uj4gp/wpqwSY?=
 =?Windows-1252?Q?wjSmaTQ8CVU4MS5k5E3pJbTaXn8005yc09O0ELIxD4HPEisOWEuXZNgb?=
 =?Windows-1252?Q?P1POpE2kge2r+3gIlbIuXzB8nUAd7CH9SckXUT5clu5ZjMMaa/6+b3s4?=
 =?Windows-1252?Q?gFp5BlBtR4RXPqA67+WRTDRd1DZisqNz/jwrz9R5A9oQMHZH4ekIRGGG?=
 =?Windows-1252?Q?PFpFWO684atRcix28kwWMqlsY23ay0mqCXiPO9E1eOSKXz14vClDZtfR?=
 =?Windows-1252?Q?mMtId+cY2YTerOkc/QIhwBlyzLYSkTrXS7HMOAKj+AQl4T5bedPuXU3n?=
 =?Windows-1252?Q?1cXQZQcWPgn+kN0Ftno/qxWNssnxjZ53ztBmuRg2QcSlID5mFP31jCzV?=
 =?Windows-1252?Q?PdesCa+kPzyUQiychE8BDdsNu/OkeLdttwOELU+PmteFAtbHQUC9Syue?=
 =?Windows-1252?Q?gYQbVLVYmKk84QImvCfsiC01wHlVTRG0ImT3udRpdc6Aw74KMC9nTfIB?=
 =?Windows-1252?Q?5pYALp0SYVHVkVuDC2jIhGer6g1myv2xcwke7SldYsNb86mL0HVI58Uw?=
 =?Windows-1252?Q?1FMluDygc/GMTrxi4ExOuzV3o0Fb/gerqgWfyIfAOWwiJppsDRjKw1WF?=
 =?Windows-1252?Q?5L4l+5xRZBh4VGV13vH3EUKcdgHM+reIk/SKA37vjkU/G8bNmgRLpdAd?=
 =?Windows-1252?Q?f7Q2GH77JHFRzTFcMWzP+9OkKeDfedXI6TjzLI0aWJBHvVVlaqaAEO5w?=
 =?Windows-1252?Q?2J/ciNSvoe4ZecSXQjlO9aDKtgw7cJXe3OOwOMEHU91L0nMFeCwuhUQ3?=
 =?Windows-1252?Q?MvOLrZsDhWCePa9JPO1A6GLyrS8mXYpMYER9Jd/ue7Sc+52YfTloDQTh?=
 =?Windows-1252?Q?Do+qu1IEl5HPS/WUEJLdtwvpiQ4v4dskMGb5Iv4mm+HtJSr6?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5258298CA6113F58984B6FBD9D7C2BN9PR12MB5258namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0057ebf-700c-4cc2-23d0-08df4384ad32
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 01:55:23.0197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cFvvIip4Hb5XVn351NJBo2KrwI2aHo7DN5ifM/VShYSmjN2aolttDfDLquJ0USk4MM+s/itROAhYatlr9p14OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6696
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

--_000_BN9PR12MB5258298CA6113F58984B6FBD9D7C2BN9PR12MB5258namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi Hawking,

Thanks a lot for pointing this out. I fully agree with your concern. I will=
 send a follow-up patch once the fix is ready.


Regards, Ce
________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Friday, November 13, 2026 11:45 PM
To: Sun, Ce(Overlord) <Ce.Sun@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset p=
ath

AMD General

Hi @Sun, Ce(Overlord)<mailto:Ce.Sun@amd.com>

I=92m concerned about the current amdgpu_uniras_query_block_ecc implementat=
ion. RAS_CMD__GET_BLOCK_ECC_STATUS is an SR-IOV VF-specific RAS command and=
 should not be invoked in the current UniRAS code path. Using it in a bare-=
metal environment would trigger an unsupported RAS command error and could =
cause GPU reset to fail.

Could we evaluate updating amdgpu_persistent_edc_harvesting_supported to pr=
event inappropriate calls to amdgpu_uniras_query_block_ecc? We should also =
consider adding an explicit check to ensure that amdgpu_uniras_query_block_=
ecc is called only for SR-IOV VFs, or retiring the function if it is no lon=
ger needed.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ce Sun
Sent: Friday, November 13, 2026 11:28 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Sun, Ce(Overlord) <Ce.Sun@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path

amdgpu_uniras_query_block_ecc doesn't support being called during GPU reset=
.

Signed-off-by: Ce Sun <cesun102@amd.com<mailto:cesun102@amd.com>>
Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>=
>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 08c6e55a7927..7be33d5559ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3770,6 +3770,10 @@ static int amdgpu_persistent_edc_harvesting(struct a=
mdgpu_device *adev,
         if (!amdgpu_persistent_edc_harvesting_supported(adev))
                 return 0;

+       if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
+            amdgpu_uniras_enabled(adev))
+               return 0;
+
         if (amdgpu_ras_query_error_status(adev, &info) !=3D 0)
                 drm_warn(adev_to_drm(adev), "RAS init query failure");

--
2.34.1


--_000_BN9PR12MB5258298CA6113F58984B6FBD9D7C2BN9PR12MB5258namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi Hawking,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks a lot for pointing this out. I fully agree with your concern. I will=
 send a follow-up patch once the fix is ready.
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Regards, Ce</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Friday, November 13, 2026 11:45 PM<br>
<b>To:</b> Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;; Sun, Ce(Overlord) &lt;Ce.Sun=
@amd.com&gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Chai, Thomas &lt;YiPeng.Ch=
ai@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU =
reset path</font>
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
Overlord)</span></font></a></span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">I=92=
m concerned about the current amdgpu_uniras_query_block_ecc implementation.=
 RAS_CMD__GET_BLOCK_ECC_STATUS is an SR-IOV VF-specific RAS command and sho=
uld not be invoked in the current UniRAS
 code path. Using it in a bare-metal environment would trigger an unsupport=
ed RAS command error and could cause GPU reset to fail.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Coul=
d we evaluate updating amdgpu_persistent_edc_harvesting_supported to preven=
t inappropriate calls to amdgpu_uniras_query_block_ecc? We should also cons=
ider adding an explicit check to ensure
 that amdgpu_uniras_query_block_ecc is called only for SR-IOV VFs, or retir=
ing the function if it is no longer needed.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,<br>
Hawking</span></font></div>
<a name=3D"_MailEndCompose"></a>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ce=
 Sun<br>
Sent: Friday, November 13, 2026 11:28 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@=
amd.com&gt;; Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;; Chai, Thomas &lt;YiP=
eng.Chai@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">amdg=
pu_uniras_query_block_ecc doesn't support being called during GPU reset.</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Ce Sun &lt;<a href=3D"mailto:cesun102@amd.com">cesun102@amd.com<=
/a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: YiPeng Chai &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Ch=
ai@amd.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">1 fi=
le changed, 4 insertions(+)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 08c6e55a7927..7be33d5559ab 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
3770,6 +3770,10 @@ static int amdgpu_persistent_edc_harvesting(struct amdgp=
u_device *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_persistent_edc_har=
vesting_supported(adev))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_in_reset(adev) || amdgpu_ras_=
in_recovery(adev)) &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_unir=
as_enabled(adev))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_query_error_sta=
tus(adev, &amp;info) !=3D 0)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; drm_warn(adev_to_drm(adev), &quot;RAS init query failure&=
quot;);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-- <=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font></div>
</body>
</html>

--_000_BN9PR12MB5258298CA6113F58984B6FBD9D7C2BN9PR12MB5258namp_--
