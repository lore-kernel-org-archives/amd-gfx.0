Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FA6C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 02:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122EC60F5E
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 02:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 122EC60F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A736B6F3A1;
	Fri, 30 Jul 2021 02:45:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 653656F3A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 02:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwzMwPEaRPdYhDgcdCTrZMjqcXgwGpHFBQktZgmyj8lNXjy1w0pfeYhal0+KdXe7ZNPaNs0k7A2i71qNtv/kP15nlVvAj4109keVxiKWUmiUhAjQw6q6DeRO2b4SOOi+9S/cJy40JWfbBCubzJ5pbJ6o/zGsKR6fxXXTv3N+OkjjmBD/NHo5/j8JKAz3kUYEtdYARwC2bVLCKgkb0/WLj2F16oFC+d1djkzd0Sh5Rqzv4Z4xVxtJqeBNNSVuW5gXKmQoK73+lvTPx68y3IDPznDQ/ssNpXgIhPPAsxxN00BGcHcR+hlQK8FeLBHk3ZehpXPp5vog9EpTPKak7LDbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d28uIWS6rvbP6xH2LIJ5uHYJvw8vevwBiT7DgGTxW4E=;
 b=iaGM8faU4y9g8qrUfOieaxdILd0USN/Y7CXyo/q6hrtpVE9fQBcpDWkZGg0PY0XSZ54iyql/efTxbPtemE7NlWv/5GMmV0b5T/NZvQCeGYWEJk6+zDmAiyR/yWMs7xrtci3fiUPXw1rUmEVzk+EKqndbR8uwqI8MleYFia7o5sgI4fXZPeggkBVUynWhc+lnleDLvLvf9USrQICOrCZQ1wtrAwgKp+7rujQYEYYr8GRhJyKrw2MyJ54Xlur1TnizOzemqv8zz5WLYa3i5ZXTe3Vs3JbP7jCpr+eLhj7j4AQNj2zh+TDOOArSFgfXZryLta63vzwSFFPyDJESOjhFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d28uIWS6rvbP6xH2LIJ5uHYJvw8vevwBiT7DgGTxW4E=;
 b=Zv3jLv+GQ2LAa40VTzT0/l3FLJVVIdmNx5hXoAriZyj2mmKr2dM86V1T+wivF2phekHsFquYX+nQwolTcB0+TrxuQeWilgFgbeHKVV+c0ecUVUn9OviOFAy6zrevO2V+R7U/km0PfoBL5PRIERMjlOrU8+EHQjkDR+t68ZsZVlk=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5029.namprd12.prod.outlook.com (2603:10b6:208:310::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Fri, 30 Jul
 2021 02:45:15 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 02:45:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: update yellow carp pmfw interface version
Thread-Topic: [PATCH] drm/amd/pm: update yellow carp pmfw interface version
Thread-Index: AQHXhOxRNWd3ZI5rh0uaA+R0FX4gmKtaz+x5
Date: Fri, 30 Jul 2021 02:45:15 +0000
Message-ID: <BL1PR12MB514451D7948C1A1FEB8709F2F7EC9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210730024018.4356-1-Xiaomeng.Hou@amd.com>
In-Reply-To: <20210730024018.4356-1-Xiaomeng.Hou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-30T02:45:14.447Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1fc1112-fb7a-494a-ff1a-08d953040f6e
x-ms-traffictypediagnostic: BL1PR12MB5029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB502932E8D30CCFEB24E6F262F7EC9@BL1PR12MB5029.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:446;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kPw3NDi+m/4Uo2hdBXGPx0oFC7GnySbhikPDMqfA5rIuMgeoCGtZjUVxzYj8yMyxm2JLK68pL+/Jih1PJ8JWBTg6lKg9KqFaD6nyMVLRK+i2HvdF0Cqmwl23EEQr1duGoNieL5F7QJ0+6j7jRBrrYEfwFZQLecyy9TVynFxDY7AUvVsKo3O4eMwB8NK/yWrtE7EItOS8m3rYP9ETFmgOB0rb2Zgzq3Ji94LSdWDzqlm6Mp0FBle9LamTrxdZ0yRogIIVP08Xb8cGNx1Krrtej2FBphWTFE+RmN8UvwtKj0j0YbeB30jsT6E4eBQ64uB13uQ0pJqeTqjTgT++s3/pgXpy3J3I95arLLe7mWdbEbBhIDLfrnSfnQWMra6tmWDoqLMxIj9SGQqvi4RvGu0dgidltm1cFppBBdtOPkqgr3EVi1anCihfs/TtCrmL1Q3Q14xDdV/LePQkvKNMbTcNMKng8IdwiyvoyBS1mDQrNx6ETLlv/0OQ1XmzMeVX+VGK3jKTLiPPfrudU/c5jEpDZMp2JyE8rpRlQpPe1MT/QA3YxOCyUOQa5TOBRfic/PJ95DRv6J45ntxGcOFlhyPtYPtdcm1kRcvPHuaGc/Ly9+ljIKYzz0qqeg4YQ5qrcxg+S9bLny14kQllyNhjpPNiS60NAwkyGoRFvHnjsG+HAB2e6UKkbYD0rYHc9KtZBbJULq1G3lmFKYawuy37yk0oIg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(966005)(8936002)(26005)(8676002)(38070700005)(6506007)(19627405001)(71200400001)(15650500001)(508600001)(186003)(66946007)(2906002)(66556008)(52536014)(66476007)(86362001)(4326008)(33656002)(316002)(110136005)(76116006)(166002)(66446008)(122000001)(53546011)(5660300002)(55016002)(64756008)(38100700002)(7696005)(9686003)(83380400001)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VSpYm3+9EKumD7xsUtWaC5e+ZyAUBSm6fPrqIYYN1/lOgB4uqzSOu9ENhkXE?=
 =?us-ascii?Q?934MicP8IZqPNz4wCXq8S+D0ppheeuRRMB340NZ6RtYcqN82fhQfnDFEe5h+?=
 =?us-ascii?Q?f9bNRJFjmE5Dn95wkTbwUzOSlX179nzI6+sDvmh1mmDQLJWq5mlpWmhj1Epb?=
 =?us-ascii?Q?lwxsFxBM7gJdX4c0VMTNHuUjB2PuYrtwkpJKZS9/WOqm9BiYnhi+xeb6YERK?=
 =?us-ascii?Q?k5rvp4Z7MnqDsfDoaMemdw6EyQ5FNcdTK20B3TtMGwtXwGZOj1RMzsPdXyVI?=
 =?us-ascii?Q?l9US6yWtAOrMBPwhZxtqfXBXoS+j/chYy3gdSV+yyBsmCo4h8IXUBga4aWNL?=
 =?us-ascii?Q?QUjCHnWu5X5IfbYLeaV+eWgzNmn2TZ+l3Lra8W+YR7YFg7zBg8lt1iEzn1ti?=
 =?us-ascii?Q?Vs32m+5djFYcHTPI4nC3ch87apC/mz6qeUtk7ytlk1QpTOCCZOMfDUmhXxfP?=
 =?us-ascii?Q?Nan1+10Udu+HpfwfAel3tFcyBiLOoTgHshyePSuxBANj0Q2wa1QrEovLYAri?=
 =?us-ascii?Q?e0lurnkK/eCkHvRzZ9DE2H9FlZvx+nU4QMlwRvADvZICEvEfkdzaRxLoX5Un?=
 =?us-ascii?Q?xGXPNX14uWahs4RnNMZAkpYhTbRy/l3BNQIRT1qAXxOplT837afEOpueXa1J?=
 =?us-ascii?Q?ytt2UEDXClRPnhJnDDhAc0P/zJN6SIqmIrAdIgEbfbUhwteVYP+oThR1cN87?=
 =?us-ascii?Q?i7qpqPo0wrHQFYbAMtZwRkpzXS12SNsnY6aEZD5bkOJwchQ5MC7Eln49wZnm?=
 =?us-ascii?Q?ewbcG+0Uk8gZfZ7hDGbjsv/Z6kOOlv31ip58+4Fv2wyyNq3lVST1qtb3FRtG?=
 =?us-ascii?Q?CiHgMjWg5dXV7uRILjRlb2OGVnsJf+0Adk6eNO14YMcMD+HpegVg17GFxzks?=
 =?us-ascii?Q?zzu7M+6EdwLsWk1mBVRLOB36u4eP0GVPLEpaGWfJqBX0L7UKnr0qrc1/d5dr?=
 =?us-ascii?Q?J0xQwQeVcx5Bt9ZVX8m+QGReEMhM9pp3Bahg5mwtPNaYKDkizVDqLcMf8VZs?=
 =?us-ascii?Q?2xxKFm7r7TAjs5sxoD8+bzZuNU+4Zbqdzr4ey2evBR41GXyeTFz1LQLFaJQ3?=
 =?us-ascii?Q?VhK+uZvhUBL1uDvnmCBnO40SmVWJyty+v4clz0c71iXsOiP053KdUTHZsAmS?=
 =?us-ascii?Q?6B3OASh4qAs/djL2PFJtXWDgN8j6l8tgZRSkyig0+hUVh6cHfTvoAyINRtEG?=
 =?us-ascii?Q?iVLIk6inf/1XLbK2ET6YoYawoC2obtFjUOVSEsZ/q06C6I94ICxs92gzCnu9?=
 =?us-ascii?Q?T3qZl6R7a8G2M5Yixzz0zdMUzagpLBRhWZYvz0+BiWayEgVm2U6l9IOfm9U2?=
 =?us-ascii?Q?/a++6vIxCWdQ14k+yrfy1dBE?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fc1112-fb7a-494a-ff1a-08d953040f6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2021 02:45:15.2089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3tbvlVhLuMJb3q6x91ZxylZhZTglJu/Vp9Q0pmWLrwVneyT6JndMYNwgVEE4x1BoyIxIDc6oH3RdXQmDCj0fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5029
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
Cc: "Liu, Aaron" <Aaron.Liu@amd.com>
Content-Type: multipart/mixed; boundary="===============1765627897=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1765627897==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB514451D7948C1A1FEB8709F2F7EC9BL1PR12MB5144namp_"

--_000_BL1PR12MB514451D7948C1A1FEB8709F2F7EC9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Xiaomeng=
 Hou <Xiaomeng.Hou@amd.com>
Sent: Thursday, July 29, 2021 10:40 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Liu, Aaron <Aaron.Liu@a=
md.com>
Subject: [PATCH] drm/amd/pm: update yellow carp pmfw interface version

Correct yellow carp driver-PMFW interface version to v4.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/p=
m/inc/smu_v13_0.h
index 3fea2430dec0..dc91eb608791 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
@@ -26,7 +26,7 @@
 #include "amdgpu_smu.h"

 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
-#define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x03
+#define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x07

 /* MP Apertures */
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C0f2baa27fa96410b765508d953037228%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637632096543742534%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DqYE5Grju%2BZKQMhUVz3ZrieYCKLKNtxvbP%2B1lG7eOkUw%3D&amp;reserved=3D0

--_000_BL1PR12MB514451D7948C1A1FEB8709F2F7EC9BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Xiaomeng Hou &lt;Xiaomeng.Hou=
@amd.com&gt;<br>
<b>Sent:</b> Thursday, July 29, 2021 10:40 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Hou, Xiaomeng (Matthew) &lt;Xiaomeng.Hou@amd.com&gt;; Liu, Aaron=
 &lt;Aaron.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: update yellow carp pmfw interface versi=
on</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Correct yellow carp driver-PMFW interface version =
to v4.<br>
<br>
Signed-off-by: Xiaomeng Hou &lt;Xiaomeng.Hou@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/smu_v13_0.h | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/p=
m/inc/smu_v13_0.h<br>
index 3fea2430dec0..dc91eb608791 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h<br>
@@ -26,7 +26,7 @@<br>
&nbsp;#include &quot;amdgpu_smu.h&quot;<br>
&nbsp;<br>
&nbsp;#define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF<br>
-#define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x03<br>
+#define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04<br>
&nbsp;#define SMU13_DRIVER_IF_VERSION_ALDE 0x07<br>
&nbsp;<br>
&nbsp;/* MP Apertures */<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C0f2baa27fa96410b765508d953037228%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637632096543742534%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DqYE5Grju%2BZKQMhUVz3ZrieYCKLKNtxvbP%2B1lG7eOkUw%3D&a=
mp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D04%7C01%7Calexander.deucher%40amd.com%7C0f2baa27fa96410b765508d95303=
7228%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637632096543742534%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;amp;sdata=3DqYE5Grju%2BZKQMhUVz3ZrieYCKLKNtxvbP%2B1lG7=
eOkUw%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514451D7948C1A1FEB8709F2F7EC9BL1PR12MB5144namp_--

--===============1765627897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1765627897==--
