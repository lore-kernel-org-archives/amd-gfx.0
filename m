Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A426C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 04:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2812070C
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 04:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2812070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 884326E50B;
	Wed, 27 Jan 2021 04:43:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770054.outbound.protection.outlook.com [40.107.77.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CFC56E50B
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 04:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8Xc3LGTscdPML4yNvC4KRy4NMb9IDmx6Gr7a4WnKjfGndhPPMCRzQLDfja28Nz5hi8rvKU9lCP1viVWMUOlEUHymK62WO5lpr/y/f6x9MFXnOASwbc0k1DSK/vjSkFjnm0awoX9z4D0kkTmj5HGk3qC27E9bSuQE/Nu/RmCCKzmeicXAzbaRKAPRfTwT+DavmrYTGuTKAZje2j5LbMUL16KPpnVBW+DN54z5i+3RDl1FVnrUaREu5KNL+i0fN0EjhpjKCCQZz4s9hZeiw5uEWUNJBFSUQrVVjBUATXuFUe1yF1Ya8EqQMHacLG1vzb1W0osl2xqQ5ZdpTqaHi6W6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67W9Z2Iqdx+nMAByvHwXfcND8rs9dXtumbKAxyg775E=;
 b=YomxdHUsA71LErNw+MlhJjtHnJtqBFK2zMq+RMJ6tj1FJw8dReQ4OQ+Q7C6KxvElZJXdTCQZxBEhxLg58oHyThJ9ifikuwR4sYqp6MjGVv6U0NP5kEbXMCI9fnkE5eFYekPOQ7F0RqmelETLwGY5EJ1HxtVMOKLssLrsv5qHVgVUv9RjwO84RBt4Ue8JwPmby9PoVh0o9h0+Vujl5GVBbT+AegFiXF35tYZlkHBNrsZkdtX1nqCPJXao+evn8f6YR8MChGkyuDzegJp2Z+jea1A54gJASy22O/iyURs/is07Gi2TFdOop8H5mblwd9AJw0Q/MDwrFAdCYxYpuRom+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67W9Z2Iqdx+nMAByvHwXfcND8rs9dXtumbKAxyg775E=;
 b=L2fP1ma9s12hrUIRQhrb6E7uvpqYKffEyIuo2FLVgbQ1TWizx2FAiA8d58fahBCVuk1DCKZ/ZckDKhuQxyhxheqvqx6RXpKsajJwEsHfPjQJ7JbQZ6Z9iRAYgNjOm6kF4ujpJEU5iumiR1tzkYcIwKp/M9Ud1y5G4M6b+n2A2Eo=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 27 Jan
 2021 04:43:28 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%6]) with mapi id 15.20.3763.019; Wed, 27 Jan 2021
 04:43:28 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, 
 "Quan, Evan" <Evan.Quan@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback
Thread-Topic: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback
Thread-Index: AQHW9A98ZxpgT84YPE+wX+X9OURxBqo61ZoAgAANYYCAAAAU9oAAAQkAgAAA9QY=
Date: Wed, 27 Jan 2021 04:43:28 +0000
Message-ID: <MN2PR12MB44889D2E33706C0208837EDEF7BB0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210126181702.48944-1-alexander.deucher@amd.com>
 <DM6PR12MB2619EE40237D99D8A666CEFAE4BB9@DM6PR12MB2619.namprd12.prod.outlook.com>,
 <CY4PR12MB1287945849A59414A6B38144F1BB9@CY4PR12MB1287.namprd12.prod.outlook.com>
 <MN2PR12MB44887DFA0177C949C1F99166F7BB0@MN2PR12MB4488.namprd12.prod.outlook.com>,
 <MN2PR12MB4549DE6D9D34295D8E63402B97BB9@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4549DE6D9D34295D8E63402B97BB9@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-27T04:43:28.046Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.237]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e74857f-45f8-4455-f18c-08d8c27e1759
x-ms-traffictypediagnostic: MN2PR12MB4270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42703B494A10171DB4F78BA0F7BB9@MN2PR12MB4270.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tlx2kJhljV9J8ayo9UD6arnacAkgC/qo26jcaJjg7Hj+Qgi1Wc64qu2qbUY1puTnDVB9EVbsWC1rC8+j8KfXD09ZUPeAtPi6h6mKngQXYn37s+7a3fczxcqvCCUJFxfSWsUoESyVnZ63Inwzq6UdLgsa0u4a7fSKOmYCKJKIWnNWkNgvjzPt38X8MHDHjJ+c92acR2ibwda2+cvxcCN1MlMJyprwbtF1OYS6NNXIrXSwHxyVZPOeDjNiDAoZMqzyqYiXeRRatgrkuxA35A7QSLT1qN9KrysJjsK4DfHgYqlmMNxn09yb0b+0IJexLQmVvwP5aM33jQuSzOJc0iIGoinyU23+1MBchydZ8otGGLConPi1yJMzq1bRO0OhAx2SJ9YFOUwiQFqzY97fExr/fbNaoa3AeQNfHBti37zig7w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(76116006)(53546011)(66476007)(66556008)(19627405001)(64756008)(66446008)(66946007)(45080400002)(6506007)(26005)(478600001)(2906002)(186003)(8676002)(8936002)(83380400001)(7696005)(52536014)(166002)(966005)(55016002)(86362001)(110136005)(9686003)(316002)(71200400001)(33656002)(19627235002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dVFUg2ojb3+X952DWSJCRbUmiyTw0RtxeSLjRdtWh8nWkASgappfszC2vNW+?=
 =?us-ascii?Q?9h5incHn2ziR5U4qQlO4K8nqwyJmH1Gyn5WLM5JYOTducS6tcS+/GH4iRvwk?=
 =?us-ascii?Q?HiEyqg0YaQANzaAfdzrYzBdf/0lTLYxu2DJGGhvU8adOw8XOBrAKWq5x1CUF?=
 =?us-ascii?Q?3144pdgrW53aWqCodk3RY8kMH6wuRveBmfyoSlCSHiDmVulJnRiNleBWAzHg?=
 =?us-ascii?Q?A/1VitYXtiJ/8wKRSu0DdDTTFvx14Bw8zVSAuzA0elRd488yJsikST11J5z/?=
 =?us-ascii?Q?mcdIa5BsI4wCki0YP39NoZ2P9tYN6+ZZlkGqX/kpleW4CUtdoCGF+l1OzjEU?=
 =?us-ascii?Q?P7tAdhVia5fj5GI1tJVxxoT8wh8PERy9qWstCxWAuCA+xe457bL8QbnuwYpN?=
 =?us-ascii?Q?pdkugtW/L10jgtenymx5JbFsqdxy6iMYbxz1lHj0+UwiYKiwDt8Vo6Sd6jT9?=
 =?us-ascii?Q?M30yx02WkTndVFeM1bw9u95Z/KlYsmLiJiBH49s/0dWcevW8WhVqazfV6N8C?=
 =?us-ascii?Q?icTRSV0ZI6xreN74RBiBu2R4VVL6EzYa3T8CkKozE1nQ0wHTvY2yRtY74cTk?=
 =?us-ascii?Q?rIGS584pXZ25V+MgZo04gDt+AHVkq4R9aKwHL/Ln5QcL4LXObxyfRz/KLonz?=
 =?us-ascii?Q?DpU1SKYJ3EYiXVcKPGPUe6JSSTkqzwN8ni8JoLS0lQabkRUA8LSDD844kEVD?=
 =?us-ascii?Q?T8KWWUVTC0bfcM99+bn7Mm7no1hb1bg88fmeLZB/HzpWG156X6c9n3gtRARN?=
 =?us-ascii?Q?7gcI7KmQwFJbWBmnrm1C5oMDkvqCX6B1ES1aXR6SuDXiDP1MV3f1LdA3t/KC?=
 =?us-ascii?Q?RFLFkMoKuR8PA5XvcK9tBriDZbQr/uf7GRm7j9PLaRs7cYZFOoTwYZ+l1RMl?=
 =?us-ascii?Q?XNlhAhxj/N0MT/1n5QDcHZR0E/Hj7sUmWuWuiDCMeTz4FGA5aXUbxUXCZ8H8?=
 =?us-ascii?Q?+rwnP7ykbUKJTUrCpB4KPYsNUDppyedenDgPqJa/KZKu3mKpDtsO434bt4jG?=
 =?us-ascii?Q?RMOuNq7/rZ6htL1OjZh6d+NYv3nFzfm1JC8YW2JYIC8kvvuawwbYWwx/qNoy?=
 =?us-ascii?Q?vpctfgtO?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e74857f-45f8-4455-f18c-08d8c27e1759
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 04:43:28.4999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+N6KSBULBmy5bncf5gOd4BEsk82TUCjZa2rvLSkaUxnb4HAze5Ax5JLDZKenxf15G3YwYZfQMo1OiQ4SjhLiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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
Content-Type: multipart/mixed; boundary="===============0292818163=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0292818163==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44889D2E33706C0208837EDEF7BB0MN2PR12MB4488namp_"

--_000_MN2PR12MB44889D2E33706C0208837EDEF7BB0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

As Evan said, this code is unused anyway and I have a patch in the works to=
 drop all of this anyway.  The manual manual rpm interface seems to not wor=
k on some boards at all.  I guess the pwm interface is a better bet for man=
ual fan control.  See:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/892cba31627b019c26a9c56=
016e6ebd442166678

Alex
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, January 26, 2021 11:37 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Alex Deucher <alexdeucher@gmai=
l.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback


[AMD Public Use]



As far as I know, refclk is fixed at 25M for TACH; no need to consider ASIC=
 refclk.



Thanks,

Lijo



From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deucher,=
 Alexander
Sent: Wednesday, January 27, 2021 10:05 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Ale=
x Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback



[AMD Public Use]



[AMD Public Use]



Is the xclk really 25 Mhz or is there some divider for the fan stuff?  Chan=
ging the xclk value will affect other places where this is used.



Alex



________________________________

From: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Sent: Tuesday, January 26, 2021 11:33 PM
To: Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>; Alex Deucher =
<alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>; amd-gfx@lists.freede=
sktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.=
org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback



[AMD Public Use]

In soc15_get_xclk, we have independent handling for CHIP_RAVEN case.

If (adev->asic_type =3D=3D CHIP_RAVEN)
        return reference_clock / 4;

I am not sure if it's better to squash the patch into the asic specific fun=
ction? Then we have one unified place to handle it.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Quan, Evan
Sent: Wednesday, January 27, 2021 11:46 AM
To: Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>; amd=
-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Actually after switching to retrieve fan speed from metrics table always, t=
his API is not used any more.
Maybe we can just drop it. Either way the patch is reviewed-by: Evan Quan <=
evan.quan@amd.com<mailto:evan.quan@amd.com>>

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Alex Deucher
Sent: Wednesday, January 27, 2021 2:17 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback

The xclk needs to be divided by 4.

Fixes: acab02c1af43d3 ("drm/amdgpu/pm/smu11: Fix fan set speed bug")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deu=
cher@amd.com>>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..36dac106ed4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1245,7 +1245,11 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *=
smu,  if (!tach_period)  return -EINVAL;

-crystal_clock_freq =3D amdgpu_asic_get_xclk(adev);
+/*
+ * crystal_clock_freq div by 4 is required since the fan control
+ * module refers to 25MHz
+ */
+crystal_clock_freq =3D amdgpu_asic_get_xclk(adev) / 4;

 tmp64 =3D (uint64_t)crystal_clock_freq * 60 * 10000;  do_div(tmp64, (tach_=
period * 8));
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cguchun.c=
hen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637473159431451098%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3De%=
2BzrZgRQDkOb4ElNJNiLWP%2FHBM0cIQl4GwKFuYfvsP8%3D&amp;reserved=3D0<https://n=
am11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedeskto=
p.org%2Fmailman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7Clijo.lazar%40amd.com%=
7C8cdef44e170e4198c00e08d8c27ce642%7C3dd8961fe4884e608e11a82d994e183d%7C0%7=
C0%7C637473189035661354%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo=
iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DpfK0LTxZUBVlvvX3zs3D=
QjmtYyOJkNdFIBUGkTCyopg%3D&reserved=3D0>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cguchun.c=
hen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637473159431461091%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dlp=
9Gu3pJ7GdDbF1BJNlIQr4Z0TCY%2BTVDGtDWzZ2bR2Q%3D&amp;reserved=3D0<https://nam=
11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.=
org%2Fmailman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7Clijo.lazar%40amd.com%7C=
8cdef44e170e4198c00e08d8c27ce642%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0=
%7C637473189035671303%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV=
2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3Da%2BTTK%2BJ0YjbNe9irLE=
9GRgK0koyGYKfrtcMUR0wkvxs%3D&reserved=3D0>

--_000_MN2PR12MB44889D2E33706C0208837EDEF7BB0MN2PR12MB4488namp_
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
As Evan said, this code is unused anyway and I have a patch in the works to=
 drop all of this anyway.&nbsp; The manual manual rpm interface seems to no=
t work on some boards at all.&nbsp; I guess the pwm interface is a better b=
et for manual fan control.&nbsp; See:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://gitlab.freedesktop.org/agd5f/linux/-/commit/892cba31627b=
019c26a9c56016e6ebd442166678" id=3D"LPlnk798197">https://gitlab.freedesktop=
.org/agd5f/linux/-/commit/892cba31627b019c26a9c56016e6ebd442166678</a></div=
>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Tuesday, January 26, 2021 11:37 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, Guch=
un &lt;Guchun.Chen@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;; Alex =
Deucher &lt;alexdeucher@gmail.com&gt;; amd-gfx@lists.freedesktop.org &lt;am=
d-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readb=
ack</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
span.x_EmailStyle18
	{font-family:"Calibri",sans-serif;
	color:windowtext}
p.x_msipheader251902e5, li.x_msipheader251902e5, div.x_msipheader251902e5
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:break=
-word">
<div class=3D"x_WordSection1">
<p class=3D"x_msipheader251902e5" style=3D"margin:0in"><span style=3D"font-=
size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; color:#317100">[AMD =
Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">As far as I know, refclk is fixed at 25M for TACH;=
 no need to consider ASIC refclk.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Thanks,</p>
<p class=3D"x_MsoNormal">Lijo</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.fre=
edesktop.org&gt;
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Wednesday, January 27, 2021 10:05 AM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Quan, Evan &lt;Evan.Qu=
an@amd.com&gt;; Alex Deucher &lt;alexdeucher@gmail.com&gt;; amd-gfx@lists.f=
reedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readb=
ack</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">Is t=
he xclk really 25 Mhz or is there some divider for the fan stuff?&nbsp; Cha=
nging the xclk value will affect other places where this is used.</span></p=
>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">Alex=
</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@am=
d.com">Guchun.Chen@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, January 26, 2021 11:33 PM<br>
<b>To:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@am=
d.com</a>&gt;; Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">al=
exdeucher@gmail.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readb=
ack</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal">[AMD Public Use]<br>
<br>
In soc15_get_xclk, we have independent handling for CHIP_RAVEN case.<br>
<br>
If (adev-&gt;asic_type =3D=3D CHIP_RAVEN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return reference_clock / 4;<br>
<br>
I am not sure if it's better to squash the patch into the asic specific fun=
ction? Then we have one unified place to handle it.<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Quan, Evan<br>
Sent: Wednesday, January 27, 2021 11:46 AM<br>
To: Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@g=
mail.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Ale=
xander.Deucher@amd.com</a>&gt;<br>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
Actually after switching to retrieve fan speed from metrics table always, t=
his API is not used any more.<br>
Maybe we can just drop it. Either way the patch is reviewed-by: Evan Quan &=
lt;<a href=3D"mailto:evan.quan@amd.com">evan.quan@amd.com</a>&gt;<br>
<br>
BR<br>
Evan<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Alex Deucher<br>
Sent: Wednesday, January 27, 2021 2:17 AM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Ale=
xander.Deucher@amd.com</a>&gt;<br>
Subject: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback<br>
<br>
The xclk needs to be divided by 4.<br>
<br>
Fixes: acab02c1af43d3 (&quot;drm/amdgpu/pm/smu11: Fix fan set speed bug&quo=
t;)<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
">alexander.deucher@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 6 +++++-<br>
&nbsp;1 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
index 147efe12973c..36dac106ed4b 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
@@ -1245,7 +1245,11 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *=
smu,&nbsp; if (!tach_period)&nbsp; return -EINVAL;<br>
<br>
-crystal_clock_freq =3D amdgpu_asic_get_xclk(adev);<br>
+/*<br>
+ * crystal_clock_freq div by 4 is required since the fan control<br>
+ * module refers to 25MHz<br>
+ */<br>
+crystal_clock_freq =3D amdgpu_asic_get_xclk(adev) / 4;<br>
<br>
&nbsp;tmp64 =3D (uint64_t)crystal_clock_freq * 60 * 10000;&nbsp; do_div(tmp=
64, (tach_period * 8));<br>
--<br>
2.29.2<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01=
%7Clijo.lazar%40amd.com%7C8cdef44e170e4198c00e08d8c27ce642%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637473189035661354%7CUnknown%7CTWFpbGZsb3d8eyJ=
WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;=
sdata=3DpfK0LTxZUBVlvvX3zs3DQjmtYyOJkNdFIBUGkTCyopg%3D&amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Cguchun=
.chen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637473159431451098%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdat=
a=3De%2BzrZgRQDkOb4ElNJNiLWP%2FHBM0cIQl4GwKFuYfvsP8%3D&amp;amp;reserved=3D0=
</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01=
%7Clijo.lazar%40amd.com%7C8cdef44e170e4198c00e08d8c27ce642%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637473189035671303%7CUnknown%7CTWFpbGZsb3d8eyJ=
WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;=
sdata=3Da%2BTTK%2BJ0YjbNe9irLE9GRgK0koyGYKfrtcMUR0wkvxs%3D&amp;reserved=3D0=
">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Cgu=
chun.chen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637473159431461091%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;=
sdata=3Dlp9Gu3pJ7GdDbF1BJNlIQr4Z0TCY%2BTVDGtDWzZ2bR2Q%3D&amp;amp;reserved=
=3D0</a></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB44889D2E33706C0208837EDEF7BB0MN2PR12MB4488namp_--

--===============0292818163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0292818163==--
