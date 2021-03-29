Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4CFC433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 04:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838BD6191D
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 04:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838BD6191D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 396676E1F3;
	Mon, 29 Mar 2021 04:06:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A8EA6E1F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 04:06:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKFfSdSSy3X9d4owRWtVWoO3yoaFmpsx8a5o0Wmo0KyzW/jsWJgOl+CmAFsi/nan75vIeUBQIDa/64NSkt4SJzxCTY7dL3Vqw47stW13qsN3u3tEjEa6vdWKMS8l/UMpnkyumgWssWVUQfnFtjxcoicUXF8MoDpRw0KSGD/1OEPqH/ANZmhncOivNsTnXM3jMJR9k2QMkBb4bSAGisq/4AGNONCDED58d4m4aG6ZnlZv5AzE0jiP34nw+2y/ezS60Ioo/gK+sP+1td9up+gy53KJU2pY3zVW5iI0dgPp2YTjsB8HtsRn+wCDM7Q7umHZEuBRjnBJsLuSyLrGWqph7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0i7S/O9IwQzqKn6x0lsHE1X7Szio/FJuHr4NenxyN8=;
 b=f/BWoJuS3CWLUR/ZnyHz+NJ9Dy9kKcXWVNcOmEM13GPtNTGbKE7TGtAnlNq9VAWh9R9phWNQvglMg5nGhzLmqhpQXcbh0X1wD0dfXZg8legEowWpYvEvyh01X0NoikQ9yRl6eCglznfXCmOFjtjGwUkBfC+PCae5TcLBkTanJ9RXvbtsUJSEuP5dnoMiTdxM7KK/ft30h1e9YQtag6CsEKUy83yQLhhvbyOo4y4dpu3bntV+bpzmNktVAJC1KEIy+akR90D4SyZCmYmEDe6FeKTc4hyLkLv2iI2uG3Q3ar4yliu2HjZl1RiTzH6T0d75RQh2nJ7bhZAGaF5AhVa8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0i7S/O9IwQzqKn6x0lsHE1X7Szio/FJuHr4NenxyN8=;
 b=q5SbRRdFSMBnv9uAKEqPb1dpR/MEZOZVcfeZcGvbqG2ZtZ2IWIdSygYEkab7P9b+pqY/8euuiar/sc/GbjiqGdnv9FIzP+2BuBnla/Pf9ICp4OHS1mhVP5k9fZSYGoCr7DkO68ak/rVFIgNExQs4L6A6Wix/fFYdst5Ut+uYjQE=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1288.namprd12.prod.outlook.com (2603:10b6:903:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Mon, 29 Mar
 2021 04:05:59 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3977.032; Mon, 29 Mar 2021
 04:05:59 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Reset error code for 'no handler' case
Thread-Topic: [PATCH] drm/amdgpu: Reset error code for 'no handler' case
Thread-Index: AdciLGCHGYcjSM60TJ+lHEEa2KmumgCJGDVA
Date: Mon, 29 Mar 2021 04:05:59 +0000
Message-ID: <CY4PR12MB1287455DD7DEB4454043765FF17E9@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <MN2PR12MB4549FFFC9ACA184CD96B1DA8977E9@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4549FFFC9ACA184CD96B1DA8977E9@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-29T04:05:57Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e8d0f4d9-db1d-4001-b4cd-efa40f81f9f8;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b085837d-e228-4062-95ce-08d8f267f609
x-ms-traffictypediagnostic: CY4PR12MB1288:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1288274C8BE64E5A19820AA0F17E9@CY4PR12MB1288.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NXtcNEG4ymwFR4Q8OcAu/P45f0aG5zpKRYJUjxXXnrdH0K2g+gD5ou7y1H5oHLtT07qstwh8d1XzkXwRgVcyWocEpeRGm9NHLxzWLIR4BqJ6RviqDzLTtIKKgYnX8r7aAvamAicncP5Zc4wx4dEKoucDnsVOlk8/Adsh4OZYHfnxSbd0Jgw35mV7sw8DQMJ2RCAin/509tOaqT78xDGpNS7YZw9E6YO8iAnx9Wca1fiutk3023dFaRMJRh5QCYgEW3vzjgCDkE9M/hY/G6jKjT6Hp9U5J+UaONmG44oUxYh8oihOLHvzBINQOwgh1+YOITUY9SrGwnbdxjN3dsDkZqmWkAkZkf+epVFLsTPeA5/zXdUVcXy+CDC573bpafcZBwVXrPWinA05UQXEErtM7cL1Puol/PVo+wpsArwM3eTgeWttoK0R38KKszvlsglMo4SLI+xs9V1zCkzx0oYMVB+puvP5G/guCypUK2oslqfELD31g7uLeR+FbNEhI3bwaSiAIVtfQ4gpbN75SCYZCYGVppApH1qNPnBan/miUxpUPqd4eQQiLRS/20EfIpyBbOy1zjFPi5JYrczTePqktGoQrthmbY6swnOe91UAKNp7NEhid/FSIzY3ecVR0VymIJcO2MKNBdBqv5X4L6a6P8x7OFX8Awu3h49f/Tpea14=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(4326008)(26005)(55016002)(2906002)(186003)(66946007)(9686003)(316002)(33656002)(478600001)(83380400001)(52536014)(5660300002)(53546011)(6506007)(8936002)(110136005)(76116006)(54906003)(86362001)(66446008)(71200400001)(66556008)(64756008)(8676002)(66476007)(7696005)(38100700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GrV3LpRcVZlKn4+Q1U5RI3+0ZITjWigJi9vVXb7C6ojwrMVvcPutHj7C+1il?=
 =?us-ascii?Q?qgIH4mW0vJ6o9K+atjOwnJ4Rz7hD1ozgxkrlrlGypLAPP5gSfVRA1aQ1U8Ez?=
 =?us-ascii?Q?s/IDBMlvNeo6lZAGXNMVJq9vwjTWAaIlQl+VutxdAleBEWmLZNJ9bTvo1Xmt?=
 =?us-ascii?Q?qpsMVCrjXzXCnt4nPKugpkZLu5hhrgt6vyESVQOROXjrHjX1ZNs3S+xiJemc?=
 =?us-ascii?Q?5VfALvYphVscNgL+0rKDILEfk/QzLqpRo0lFqknh/NJTAdKW5qD8qTyDOy21?=
 =?us-ascii?Q?t6f8kQMvrx3FBGBD2XnOveOFlyLZzhaFBsVDMh18r7w8c6NCtEEW+h7fTKYe?=
 =?us-ascii?Q?+iVSOBMlniQvVOtmNS2eJJmddnXV0g0gm/27ex4kfJoUpM8KY6r6AI4YNe5z?=
 =?us-ascii?Q?rDDlLsr6knbz5BcdTw/tivmOCWqFDkSbd+izIA8/OORVo1fbPeh7JF13kGZV?=
 =?us-ascii?Q?s9SraQ8jeUkIlBHhUNdp2hQBXk/FEba+eC/etmQXw/yasteJ7RVzmOmOcBH6?=
 =?us-ascii?Q?scoVwa4ejQ/H6mIlymH0h1R8NjOSfpk74GQ8wSBpH7iIDhGlJSLrkqPsLTWO?=
 =?us-ascii?Q?VIJsJrbNI+btR+tcOfuMGMvqFC2TVJQaSA2M5C0Zoz+xRbxn7LGtQrmxfipM?=
 =?us-ascii?Q?FemY3OG1w3uEDrCeO1Z7cjvJiMBXW8OFa8p/OCa+ZgueEguq+LwrUjveFmaM?=
 =?us-ascii?Q?gawImXh05pXtQ7KgG+BePG5Zol/eX1gQousEX+JLbt5faWTggJmWM5rWe67t?=
 =?us-ascii?Q?L4+nRww5e+Avg/RWG+YOKPQJcOXhn1oqQqNHq6ehWmL2Q8LwiJEoDmdlb0UZ?=
 =?us-ascii?Q?NmD8BooWQk2MqcvoiKwIqG3RGTkOM4zHO5dRZpVbhnqJIJjqsdH7Id1dDhxz?=
 =?us-ascii?Q?8l1PxlL2t7ENqrMN3WipmGQBqeKs1g4Nc9JAHb48wWsAjVqyohpXIz5KPUWp?=
 =?us-ascii?Q?Ujrqbt8bF1s+6WzljMdknMyQa49UgtVWyUmTbvGl97soBj/IJx6JaTWZVIOP?=
 =?us-ascii?Q?dxMezcCZvcT/tCYmVLDES+rFdqX/1DLqjlyAbtMXJ+pGhKHXmvJfKZiv2jM/?=
 =?us-ascii?Q?F9N7t8V2zhjqdSKbmRoAmuK15gUBkMnAxaxrH3AOxhbdYi/D99qCREOBIUn4?=
 =?us-ascii?Q?vaCuHgNegweTn31n/2HLzmpjQQ8ik/W6x+hI5CeX8fy3mAj0aP9cfGxWSohE?=
 =?us-ascii?Q?JfPwoywrQI4G1fWtNSUfMYJP7cTwASn/LFGE7JpKOHvo0L4WNAUaWLKh2BCz?=
 =?us-ascii?Q?WE7YBNZXtHOGO5ij1+4pe/XCjFT6jRE1UXrnCs4/HcdVK3EPoGxsRhj//1eg?=
 =?us-ascii?Q?WVFI6e5b3QwOvg1i+z7W+wY0?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b085837d-e228-4062-95ce-08d8f267f609
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 04:05:59.4572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tqIbVbm879L0F+mj/gVqtar1mRTkfDwjXpmI3/2UJovSwdcsc5LOQccf+WhdRF1700beEse6bpCYlBjF0F3PsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1288
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0697131272=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0697131272==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1287455DD7DEB4454043765FF17E9CY4PR12MB1287namp_"

--_000_CY4PR12MB1287455DD7DEB4454043765FF17E9CY4PR12MB1287namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-and-tested-by: Guchun Chen guchun.chen@amd.com<mailto:guchun.chen@=
amd.com>

Regards,
Guchun

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, March 29, 2021 12:04 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>;=
 Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: Reset error code for 'no handler' case


[AMD Public Use]

If reset handler is not implemented, reset error before proceeding.

Fixes issue with the following trace -
[  106.508592] amdgpu 0000:b1:00.0: amdgpu: ASIC reset failed with error, -=
38 for drm dev, 0000:b1:00.0
[  106.508972] amdgpu 0000:b1:00.0: amdgpu: GPU reset succeeded, trying to =
resume
[  106.509116] [drm] PCIE GART of 512M enabled.
[  106.509120] [drm] PTB located at 0x0000008000000000
[  106.509136] [drm] VRAM is lost due to GPU reset!
[  106.509332] [drm] PSP is resuming...

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++++++++---
1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 319d69646a13..a501d1a4d000 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4281,7 +4281,10 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_devic=
e *adev,
                               drm_sched_increase_karma(&job->base);

                r =3D amdgpu_reset_prepare_hwcontext(adev, reset_context);
-              if (r !=3D -ENOSYS)
+             /* If reset handler not implemented, continue; otherwise retu=
rn */
+             if (r =3D=3D -ENOSYS)
+                             r =3D 0;
+             else
                               return r;

                /* Don't suspend on bare metal if we are not going to HW re=
set the ASIC */
@@ -4323,8 +4326,10 @@ int amdgpu_do_asic_reset(struct list_head *device_li=
st_handle,
               tmp_adev =3D list_first_entry(device_list_handle, struct amd=
gpu_device,
                                                                   reset_li=
st);
               r =3D amdgpu_reset_perform_reset(tmp_adev, reset_context);
-
-              if (r !=3D -ENOSYS)
+             /* If reset handler not implemented, continue; otherwise retu=
rn */
+             if (r =3D=3D -ENOSYS)
+                             r =3D 0;
+             else
                               return r;

                /* Reset handler not implemented, use the default method */
--
2.17.1


--_000_CY4PR12MB1287455DD7DEB4454043765FF17E9CY4PR12MB1287namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheader87abd423" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-and-tested-by: Guchun Chen <a href=3D"mailt=
o:guchun.chen@amd.com">
guchun.chen@amd.com</a><o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Monday, March 29, 2021 12:04 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Fei=
fei.Xu@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Reset error code for 'no handler' case<=
o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If reset handler is not implemented, reset error bef=
ore proceeding.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Fixes issue with the following trace -<o:p></o:p></p=
>
<p class=3D"MsoNormal">[&nbsp; 106.508592] amdgpu 0000:b1:00.0: amdgpu: ASI=
C reset failed with error, -38 for drm dev, 0000:b1:00.0<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; 106.508972] amdgpu 0000:b1:00.0: amdgpu: GPU=
 reset succeeded, trying to resume<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; 106.509116] [drm] PCIE GART of 512M enabled.=
<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; 106.509120] [drm] PTB located at 0x000000800=
0000000<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; 106.509136] [drm] VRAM is lost due to GPU re=
set!<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; 106.509332] [drm] PSP is resuming...<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++++=
++++---<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 8 insertions(+), 3 deletions(-)<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_devic=
e.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 319d69646a13..a501d1a4d000 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">@@ -4281,7 +4281,10 @@ int amdgpu_device_pre_asic_re=
set(struct amdgpu_device *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_increase_ka=
rma(&amp;job-&gt;base);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_reset_prepare_hwcontext=
(adev, reset_context);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (r !=3D -ENOSYS)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* If reset handler not implemented, continue; otherw=
ise return */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r =3D=3D -ENOSYS)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Don't suspend on bare metal if we=
 are not going to HW reset the ASIC */<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -4323,8 +4326,10 @@ int amdgpu_do_asic_reset(stru=
ct list_head *device_list_handle,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev =3D list_first_entry(device_list_=
handle, struct amdgpu_device,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;reset_list);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_reset_perform_reset(tmp_adev,=
 reset_context);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (r !=3D -ENOSYS)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* If reset handler not implemented, continue; otherw=
ise return */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r =3D=3D -ENOSYS)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reset handler not implemented, us=
e the default method */<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_CY4PR12MB1287455DD7DEB4454043765FF17E9CY4PR12MB1287namp_--

--===============0697131272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0697131272==--
