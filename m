Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB856C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 11:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7745C23A79
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 11:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7745C23A79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B1FA6E92B;
	Tue,  8 Dec 2020 11:47:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C45C6E92B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 11:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnyiLOVQKLQpJagKIxpa+fEPWP8gmzncT5hG2lYm5TE/TD4f0oaoSu9WTvuHPbR/UpQ/G+sbNXVaIvkSKdqNFRti7Z6CwgPEGmC7zq+XDBHV7veUeRxedPpHDt2uWnKlFkDEza/eHfR+jodkA1yIJ/YcAVQwxU0DUOS9uTHYFJKTCGkYB8e3pY4gWBwCIoAdrtwBJgKp6ofI58G0+M0vp3XORhUdGT5rXJ8grvLbWNqIK8soFpX4xVPzER+QcXmmAmtOA1/Qh6Rq+chY2MRrTY9DzVRhrufCgFZ8IDHUaXnXF1hZT41ItOSIMY43e89+Kr+bYqeKbIUjWDD5rlK8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uV/KimVJcCApvt3QvZrTrSs8npI+HkyiE5I/9cOFqM=;
 b=gb0eFBFgsl4tOOGU2czdBu7Q/lxu/M0Y3HdfUY8J+4U5lHOkxIM6sNtUBpTpWKXJX7eeMr1k1G6e1NIbDojhwXKiTvyGFzyd1sN3W2P2EsDfZFZhBMhphqF7cW+G042Q0CDFIst6yKzq30Mq8Bw3yVsArXDJ42a/VqRBMSZhrNd/lnGhrvGTNjW0LvCaE0zcltXUe4fyAM1AXI9YGqYhr0Wic/3J3sqlz1RuUMO+U/RXVvXaMz+r0/tDDqCfq4CH+6hF9A9bPanxYFdkjhhRe2sCt5+SB4woIRuSVWcb1GHTQ6UyZjW6iRY/VekYqlfvtwxQ07WkQvG7TD4gTFrmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uV/KimVJcCApvt3QvZrTrSs8npI+HkyiE5I/9cOFqM=;
 b=C2P1Q33OlmIDEGaxOI8ASqmZfPl/zocGIZVcYdESFpQxlX1woMyO++23Y2wJ6NrrHnr77qm51R87MPAQItX5XHJZDtDdEbytVbHAaN6W90kKrSLXvnPght2R2L1heD581Y1b7kt/o0mkWho4od3HWDkWJVndw9PGfvUDrWFlVN0=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3469.namprd12.prod.outlook.com (2603:10b6:208:ca::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 11:47:00 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6%7]) with mapi id 15.20.3654.012; Tue, 8 Dec 2020
 11:47:00 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amdgpu/pm: inform PMFW rlc status before
 start/stop rlc for vangogh
Thread-Topic: [PATCH 3/3] drm/amdgpu/pm: inform PMFW rlc status before
 start/stop rlc for vangogh
Thread-Index: AQHWzVQucJuK/CdkJ0+uNW+t2SIam6ntFA6J
Date: Tue, 8 Dec 2020 11:47:00 +0000
Message-ID: <MN2PR12MB3022E4DA8FF86B8C6B43CE8AA2CD0@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20201208111942.6292-1-Xiaomeng.Hou@amd.com>,
 <20201208111942.6292-3-Xiaomeng.Hou@amd.com>
In-Reply-To: <20201208111942.6292-3-Xiaomeng.Hou@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-08T11:46:59.644Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e3132c8-83a8-462a-1304-08d89b6ef97c
x-ms-traffictypediagnostic: MN2PR12MB3469:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB34698B6F6CD59C7252722B62A2CD0@MN2PR12MB3469.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 03bO8YjlWVNyUF/pgVRYCBtX1RCbm9+ynannJlP1ZVcdTt0DZR2l/MLUdRGfjVwzsMLbSNfynryuDcfKt0smnXz01h8MVjIQpVP0og7Rrqf6iBsFqLgmZIzJ7I2TtdOhVJLlVUONeUcCKeET2jIB4+BNK9IxTO5GcGbe20j56wYS9hpH+rHyAuKXhvDW6yYrS7fHUY56g03qJ6eodkj7OmMRz6Ql96wZ+X7l7NHXKjtvUpectmx23zIYFzP+mWOtuF9TqFCPJyfd2Y++tu88zLoEGAYOu0shOewfIJDhzCNvQeBK7O2iOj16Dhmz0SgbOhA0Feg97ruYy+Yz1iNf4jC2B7vjez9qUtoNIhT4SEs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(64756008)(66476007)(66446008)(66556008)(66946007)(33656002)(9686003)(76116006)(26005)(2906002)(53546011)(6506007)(7696005)(478600001)(186003)(8676002)(19627405001)(166002)(83380400001)(8936002)(52536014)(91956017)(55016002)(316002)(54906003)(71200400001)(5660300002)(86362001)(4326008)(45080400002)(110136005)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?G0p3SBKK6UgHW3dWUxXn7Jk4qIYq7+0Z0U8OTs8F5g+SVPwD0B8PGvGe8y?=
 =?iso-8859-1?Q?tGgWFvJICgjC9swbXPs7T2a5bjy9vFFQa9wo4AB12ZAJSrqRZ/1CtPsOLw?=
 =?iso-8859-1?Q?0nofL77qW3wKdA6pVpRLOCnWxUCYvI3ybZBDA3Ie+2ZwtdmzSZSBPaJ8LN?=
 =?iso-8859-1?Q?Xr9YSVQssToiuHx57GNcHHTpCZM8ml9DtJCMj5iexuD1gXSAU2Uk8sp3bl?=
 =?iso-8859-1?Q?EasyE/ZtQVJegPtX9Nb8Fvg0P9/ILnvC5bJ5NQPncazCQw6zoT5O5iFKC/?=
 =?iso-8859-1?Q?phf38eFMnDv5CwO58TffnPsZVMOeku5/2/CeCgGUbfCMbg61LOu4t73/Md?=
 =?iso-8859-1?Q?jdFzpklhanmhz0QNGt3Ej/6VkReMiMycydQcrMJgVXxpp2ToOInZ1GDCAR?=
 =?iso-8859-1?Q?1fFbm51x5xV6ztjzqPExMrsp4guj9bL7ifjKhUNAeHxe78HtieQPLNN4wO?=
 =?iso-8859-1?Q?l/hfm4FM9pw5qsP3xI64iotOPuucvDsOJ7SHX5vK3pbgV+ov2dtT/RIvb7?=
 =?iso-8859-1?Q?3pBIxUNfNPRhyveEJFITHM0SH3Ep5jur3Zar8+Hl2XhxJ2ojxUgu8zXkpD?=
 =?iso-8859-1?Q?GrStU0hE5bRaUXTq0qZU8lRcYS+BXqPPArZW6H6sDxF5J1yr9w01jF66r8?=
 =?iso-8859-1?Q?iUMDyfxNMB5SpoTZtzEOPevt7UaepHLiIYlV3AQIUKmxUSAVjsB05XVaYU?=
 =?iso-8859-1?Q?q/jbXqKX0Q4EapVtnF+jHZP4GVQDxmqbkAOU3+jsTMqy9iOLKqu6ISLpf2?=
 =?iso-8859-1?Q?Hf+BVKavrNGY96dsGxV4NvQ77z0+TWmAvkNO/Ja/XE0vEI3CxV5wHrtqQw?=
 =?iso-8859-1?Q?giK8sbn+OVrkEuZX3Jwp9lNpqY9hh4ahNxRLYuW5D5WVahEd9AOxUuo/2s?=
 =?iso-8859-1?Q?BSjKZ2v9pcYQuq+KUlZfh/QA12FhBr2u/5JTlD9JJUXjMAfUF0VwwH53Hh?=
 =?iso-8859-1?Q?eg6s1UG/BykYZvz9k7b4DEzE6EisLQlq74ghXFFOk8sBNuTXrN/oHZa1Gz?=
 =?iso-8859-1?Q?6sy1iWZnLQWr1U5oI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3132c8-83a8-462a-1304-08d89b6ef97c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 11:47:00.5951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ii+TJLkPtDlT72VQUDxZ7nQJaxqu7IegvuatLUFLMKdTDP8DvnNi6wuUmLUDQYU3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3469
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: multipart/mixed; boundary="===============0767292398=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0767292398==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022E4DA8FF86B8C6B43CE8AA2CD0MN2PR12MB3022namp_"

--_000_MN2PR12MB3022E4DA8FF86B8C6B43CE8AA2CD0MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]



________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Xiaomeng=
 Hou <Xiaomeng.Hou@amd.com>
Sent: Tuesday, December 8, 2020 7:19 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Quan, Evan <Evan.Q=
uan@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/pm: inform PMFW rlc status before start/sto=
p rlc for vangogh

RLC is halted when system suspend/shutdown. However, due to DPM enabled, PM=
FM is
unaware of RLC being halted and will continue sending messages, which would
eventually caused ACPI related hang. So send message to inform PMFM the rlc
status before start/stop rlc.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Change-Id: I7b1a04f6e249ac6753109079ecb3019c99161d9f
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index cf999b7a2164..42a32c0e5bab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -920,6 +920,14 @@ static int smu_smc_hw_setup(struct smu_context *smu)
         uint32_t pcie_gen =3D 0, pcie_width =3D 0;
         int ret =3D 0;

+       if (adev->in_suspend && smu->is_apu) {
+               ret =3D smu_notify_rlc_status(smu, 1);
[kevin]:
for 2nd parameter of '1',  why not use the macro to replace it which is def=
ined in previous patch ?
and why not put these codes into smu_resume/suspend functions?

+               if (ret) {
+                       dev_info(adev->dev, "Failed to notify rlc status!\n=
");
+                       return ret;
+               }
+       }
+
         if (adev->in_suspend && smu_is_dpm_running(smu)) {
                 dev_info(adev->dev, "dpm has been enabled\n");
                 /* this is needed specifically */
@@ -1213,6 +1221,14 @@ static int smu_disable_dpms(struct smu_context *smu)
                         dev_err(adev->dev, "Failed to disable smu features=
.\n");
         }

+       if (smu->is_apu) {
+               ret =3D smu_notify_rlc_status(smu, 0);
+               if (ret) {
+                       dev_info(adev->dev, "Failed to notify rlc status!\n=
");
+                       return ret;
+               }
+       }
+
         if (adev->asic_type >=3D CHIP_NAVI10 &&
             adev->gfx.rlc.funcs->stop)
                 adev->gfx.rlc.funcs->stop(adev);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7Cb3afedc0e8a34992b17408d89b6b4f02%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637430232491676693%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D2g=
yWC0ytrVqLqNX2OappS8ALSyWkNa0xKYp96vMpxfk%3D&amp;reserved=3D0

--_000_MN2PR12MB3022E4DA8FF86B8C6B43CE8AA2CD0MN2PR12MB3022namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Xiaomeng Hou &lt;Xiaomeng.Hou=
@amd.com&gt;<br>
<b>Sent:</b> Tuesday, December 8, 2020 7:19 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Hou, Xiaomeng (Matthew) &lt;Xiaomeng.Hou@amd.co=
m&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amdgpu/pm: inform PMFW rlc status before st=
art/stop rlc for vangogh</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">RLC is halted when system suspend/shutdown. Howeve=
r, due to DPM enabled, PMFM is<br>
unaware of RLC being halted and will continue sending messages, which would=
<br>
eventually caused ACPI related hang. So send message to inform PMFM the rlc=
<br>
status before start/stop rlc.<br>
<br>
Signed-off-by: Xiaomeng Hou &lt;Xiaomeng.Hou@amd.com&gt;<br>
Change-Id: I7b1a04f6e249ac6753109079ecb3019c99161d9f<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 16 ++++++++++++++++<br>
&nbsp;1 file changed, 16 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index cf999b7a2164..42a32c0e5bab 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -920,6 +920,14 @@ static int smu_smc_hw_setup(struct smu_context *smu)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pcie_gen =3D 0, p=
cie_width =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_suspend &amp;&amp; sm=
u-&gt;is_apu) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_notify_rlc_status(smu, 1);</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">for 2nd parameter of '1',&nbsp; why not use the ma=
cro to replace it which is defined in previous patch ?</div>
<div class=3D"PlainText">and why not put these codes into smu_resume/suspen=
d functions?</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&g=
t;dev, &quot;Failed to notify rlc status!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_suspend &a=
mp;&amp; smu_is_dpm_running(smu)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;dpm has been enabled\n&q=
uot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* this is needed specifically */<br>
@@ -1213,6 +1221,14 @@ static int smu_disable_dpms(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(adev-&gt;dev, &quot;Failed to disable smu features.\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;is_apu) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_notify_rlc_status(smu, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&g=
t;dev, &quot;Failed to notify rlc status!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt=
;=3D CHIP_NAVI10 &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;gfx.rlc.funcs-&gt;stop)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt;stop(adev);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7Cb3afedc0e8a34992b17408d89b6b4f02%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637430232491676693%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3D2gyWC0ytrVqLqNX2OappS8ALSyWkNa0xKYp96vMpxfk%3D&amp;amp;res=
erved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7Cb3afedc0e8a34992b17408d89b6b4f02%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637430232491676693%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3D2gyWC0ytrVqLqNX2OappS8ALSyWkNa0xKYp96vMpxfk%3D&amp;amp;res=
erved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3022E4DA8FF86B8C6B43CE8AA2CD0MN2PR12MB3022namp_--

--===============0767292398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0767292398==--
