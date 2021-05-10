Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0E5C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 13:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05575611CA
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 13:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05575611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B5226E3D6;
	Mon, 10 May 2021 13:17:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AC646E3D6
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 13:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjTRS+75iHHC+tUfDPC0T5tV2WvTu0GKKsGtXFIjohg4Y9PHyfqwYT+ucw8jYqght54wSiZhgRRJx6zI7lO04srRNal90gRUH/I+Y2JT7BisgYU/zujB3deIU7oUDmnsSlMgkpxtTxDw2fWYvSobNUuHj94oiUQwSiDBGuH2vS7B/6+RM9FGHbfDO9XaIH66GomeFFp5nts99LfRZKSvvmxuvBMzDgqzNFAkw31uh+975dw0C8UyAcML1d0WZPiSZNHjkehDHpOproY2d2GpGVQ/90YCabx+0jLYWFyMFyb/o3cNb6cbya/UVljRWtmixF5x7mAraiy8JnKdqEPM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU22EwrjXGDfgZAK0WnwGbb+ICqLlzzEg708A7qkCFM=;
 b=KmGJI7XqKVi6Ef/9iZq9dhLib34oKd9gjHD5m3w+kKcFw2VZeS0+JMw7ZH618LD2MkLZYVOinRzyvusyS2E3IFVXQSnPFFIiyipClXZCNik1zN2XIKQiZ14k54kUjNv5KeBZoH+hfWvxwP9pwBDysO974JUGLotZrdXgRKUCX2ePsEOKeE4plFHwLlyrU8kZxHlGNK7Nxrk/M8Pp3pth1J/KRByoW+R4XTgnGFl3FlDD00ZFCGRwj1R6lduvhuxkc01p1ZtzJo1ELg6ryyuIaXrjMz3w8+hc1MK4L7g0txBb7AUNWKACDiADqybKdJlF85W4I2QOK3GnyVUe0E0dsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU22EwrjXGDfgZAK0WnwGbb+ICqLlzzEg708A7qkCFM=;
 b=XrcJsJ89ZfZ3CE9W8mu7MHwYND3+pz7NrEGqM5dmXJ8cycCsF67iQk/ThRELk/9MpR0Ni+WSvnDzHmYT+5Krqm3nIkIOXiOtzhGm0y5goiNQ9JDxjeQlgCNUvUKsapMb1seWrhFbIBt5VVHr+pmBXFUXjGZ+8rAFQ+9TwFBnyYQ=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5312.namprd12.prod.outlook.com (2603:10b6:5:39d::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Mon, 10 May 2021 13:17:07 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::4543:6802:6acc:c92d]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::4543:6802:6acc:c92d%5]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 13:17:07 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] MAINTAINERS: Add Xinhui Pan as another AMDGPU contact
Thread-Topic: [PATCH] MAINTAINERS: Add Xinhui Pan as another AMDGPU contact
Thread-Index: AQHXQZ4NeEA9LIdHQ0+PIpBevstETarcukkr
Date: Mon, 10 May 2021 13:17:07 +0000
Message-ID: <DM4PR12MB51650B6A0AC1BF505DE37BC287549@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20210505110146.11689-1-christian.koenig@amd.com>
In-Reply-To: <20210505110146.11689-1-christian.koenig@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-10T13:17:00.4593157Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [183.192.238.30]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35f4585d-66a0-4286-633c-08d913b5e967
x-ms-traffictypediagnostic: DM4PR12MB5312:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5312376F3F7B58FF6FCF086487549@DM4PR12MB5312.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:381;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fy/t0f6A0jNYF5WIL+xZA7UHaT3wfcV6b3vJxJgUrwvA68xO27Igr4IONIGXdG/kl0yxwVKks+iEBLVJSlJPnZevSIbe9ELkENI30Mgf2iVRJuhDX5NhdUt8B5wkRaEj7p6ek/eP1B11ZXrF+yGv8DUY/gAHFsVspy0GtjCc597Q8E/VB+M6SJgYDgkzmnr0isHoEuqPPrNUytYudJs+s10ynEUVQfPote8KkNipgDWBfffd9r/4D5cxDDghqm75vhml5fXJVuiAdD1nnmCYQay3QCFW9bz9ZYES+dJ1dfv1oIwcHYqTgmT4YBSGLUr+fCoUsv+v2vpHBbbzZOlsj655b8jkirTpIFBqI3geqJ+60TuH0eOcgtunq1pjk4JA8zvWC++tlxo7yPoscTSe0RCNDvHKFHdC5TsW3DrqyjUYmDfg4MvcCPIVvyVCWtHxJZukMnBhBrZl0ySNSIp8Had69CZO7pt/CMj6GQZnMg0lRjRtatX6RqtqArG8BNlod14KrdQ2zBMqcfTPtSoEhaYt5In0JT9tPjTPfLTmgy+JUMejk+OLtkjXz3CJiAAXKen12OHI2sSxQ8t0PS16bbdBl89l7j/VGvyvyi3iIkPbuvwvMkZXOwTZX248aREw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(396003)(39850400004)(376002)(8676002)(66556008)(38100700002)(2906002)(122000001)(8936002)(9686003)(53546011)(55016002)(6506007)(64756008)(76116006)(66946007)(66476007)(91956017)(316002)(66446008)(26005)(33656002)(5660300002)(7696005)(86362001)(52536014)(166002)(186003)(478600001)(71200400001)(110136005)(966005)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?elpEWKk+hQmoyidZVsK56TwZcvS+WItrRyNofDacqCsjBq/RIt5be1gaVP?=
 =?iso-8859-1?Q?6mWPRLw1wF1XlCebF9R0C9QuRLz28nQY8wlbTQ4vke6zVRsMIiODrsrqHR?=
 =?iso-8859-1?Q?Z5qP+ktUb5Krg5YlMqjIzKNO9Ipt15by5UiHATl7BWd8c6yqm3dD6BMX71?=
 =?iso-8859-1?Q?jKSY8l2Eq/Gumv8crGCc1lBsWro1Z+rkDkWb/OVg2ybeUnLuf6/EqLO2U8?=
 =?iso-8859-1?Q?zBpll4c03ev1A2QEYBSHpEIVudxHV5QHAfKDrXfPBrAXU5lmr9wOzNEcFl?=
 =?iso-8859-1?Q?RREY+aufPuB8RQ4N0HVFYq3G1LcTrYKdJfLhX2inUsXul95C0wu+gMHpa7?=
 =?iso-8859-1?Q?ycWYv/UgeI4gBFq3cLaeKDsszFJjSnjFsAkzOsnB26BZ0EmISD1D0td04C?=
 =?iso-8859-1?Q?s3tWpX572sM5xT1UgdPH4RJuO2Eo02leEzm3fLSH7uQXu18asy3NhXPyT0?=
 =?iso-8859-1?Q?lKAEsg9FknXlZABdEET8vdkfsXSYBIiYtJ41Co3zfb/11MEKKtpxJFGEhx?=
 =?iso-8859-1?Q?fC/mq6S6iouCXUY6+fwrOd2ebthZTXUdEqAxBAE66o04vdjvePYkXjYVl6?=
 =?iso-8859-1?Q?gZzPSzT+JfEedEsNBy1X2EQiyW5fXSF4JRNwua3Byo6LalUXIC1maHR32X?=
 =?iso-8859-1?Q?jcg09Zoj1esXRjWX9xe/JSacvvHKKWJy688qUIN8bc3g71xz9U43E0Wcu4?=
 =?iso-8859-1?Q?nVR90sNTjjoKODcbjqSbytotJuZ6/TJXGuP/gVnayFtg9M/m1wYGLpxAQS?=
 =?iso-8859-1?Q?RVZYZRoswTRhQudqUALUVe79804yh9hkCg5wOyhTpOuzx7qzpbYfO3LfJq?=
 =?iso-8859-1?Q?38S4Y1CArJ9CFaVPOHK+jEnqHa8fvw78XNiKl73XfTnoWfwQf3k+7MWTfz?=
 =?iso-8859-1?Q?r8DxcmfX2E9sUnI1rBX0NYVhvsTyGxue5v6yXP3vMZwJoVSafOViwZ5P6M?=
 =?iso-8859-1?Q?/3ObDdtwNBHe+YqRrfLdz+AYCw4XY2Zrs6tDLYalbNLu7o9rKZrS0gz3Kr?=
 =?iso-8859-1?Q?L8bO2MYcoT04gOIZW473Yz0cK97iZ3XX473cMMXGPTu3Sl4pmqClX4c6Kx?=
 =?iso-8859-1?Q?sYSysCHOeYVik2YjWufr8Xe34z8HtmUqKJT0gmAOf0fe+cMpe9vbECMc2j?=
 =?iso-8859-1?Q?Hq+Ef9RbEuXYrXRYK+iZZI7o2ubXj5xS8ed44ucGapP+l3jyQB8Hn/EAQl?=
 =?iso-8859-1?Q?W8IVRM/0UEC704LWjGDvtHCz1zXQdK2xfWwkM3QSRz0T2mE9yU7UPFm35j?=
 =?iso-8859-1?Q?RCKE8sUFRolgbytIK5c14wfjQuXoxhnfMYZseBCS7ayL2/KoTQ36OiRAlU?=
 =?iso-8859-1?Q?nf/BJom7Du5em77fkVxy7ZPjOiukHD8/N4oApKNBD3wKKAkBijdZnzBogz?=
 =?iso-8859-1?Q?XUtsmBDSBwY6/lsOBF244peSpbgVxSBA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f4585d-66a0-4286-633c-08d913b5e967
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 13:17:07.3997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2twG91IcnioKX2q7035wu3K/vrvCXssEi+32Ob2rIwq0paCcjGDkBuxAFNw67D3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5312
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
Content-Type: multipart/mixed; boundary="===============1901162576=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1901162576==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_DM4PR12MB51650B6A0AC1BF505DE37BC287549DM4PR12MB5165namp_"

--_000_DM4PR12MB51650B6A0AC1BF505DE37BC287549DM4PR12MB5165namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: xinhui pan <xinhui.pan@amd.com>
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Wednesday, May 5, 2021 7:01:46 PM
To: Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander <Alexander.Deucher=
@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] MAINTAINERS: Add Xinhui Pan as another AMDGPU contact

Since Chunming Zhou left AMD last year we are down to only
two maintainers once more. So add Xinhu Pan as another
contact as well.

Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64ed8b77cfa9..e2cb5a8acdf1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14970,6 +14970,7 @@ F:      drivers/net/wireless/quantenna
 RADEON and AMDGPU DRM DRIVERS
 M:      Alex Deucher <alexander.deucher@amd.com>
 M:      Christian K=F6nig <christian.koenig@amd.com>
+M:     Pan, Xinhui <Xinhui.Pan@amd.com>
 L:      amd-gfx@lists.freedesktop.org
 S:      Supported
 T:      git https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux.git&amp;data=3D04%7C01%7CXinhu=
i.Pan%40amd.com%7C125c7d582eee46ba134408d90fb52e94%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637558093114409974%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D=
CMIlY5Lj2Yqvusz2HwmGtwX71KgjYHU0MnRLtbD8Kso%3D&amp;reserved=3D0
--
2.25.1


--_000_DM4PR12MB51650B6A0AC1BF505DE37BC287549DM4PR12MB5165namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
Reviewed-by: xinhui pan &lt;xinhui.pan@amd.com&gt;</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, May 5, 2021 7:01:46 PM<br>
<b>To:</b> Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;; Deucher, Alexander &lt;A=
lexander.Deucher@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lis=
ts.freedesktop.org&gt;<br>
<b>Subject:</b> [PATCH] MAINTAINERS: Add Xinhui Pan as another AMDGPU conta=
ct</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Since Chunming Zhou left AMD last year we are down=
 to only<br>
two maintainers once more. So add Xinhu Pan as another<br>
contact as well.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
---<br>
&nbsp;MAINTAINERS | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 64ed8b77cfa9..e2cb5a8acdf1 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -14970,6 +14970,7 @@ F:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/net/wirele=
ss/quantenna<br>
&nbsp;RADEON and AMDGPU DRM DRIVERS<br>
&nbsp;M:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Alex Deucher &lt;alexander.deucher@a=
md.com&gt;<br>
&nbsp;M:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Christian K=F6nig &lt;christian.koen=
ig@amd.com&gt;<br>
+M:&nbsp;&nbsp;&nbsp;&nbsp; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;<br>
&nbsp;L:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx@lists.freedesktop.org<br>
&nbsp;S:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Supported<br>
&nbsp;T:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; git <a href=3D"https://nam11.safelin=
ks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.freedesktop.org%2Fagd=
5f%2Flinux.git&amp;amp;data=3D04%7C01%7CXinhui.Pan%40amd.com%7C125c7d582eee=
46ba134408d90fb52e94%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637558093=
114409974%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT=
iI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DCMIlY5Lj2Yqvusz2HwmGtwX71K=
gjYHU0MnRLtbD8Kso%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.=
freedesktop.org%2Fagd5f%2Flinux.git&amp;amp;data=3D04%7C01%7CXinhui.Pan%40a=
md.com%7C125c7d582eee46ba134408d90fb52e94%7C3dd8961fe4884e608e11a82d994e183=
d%7C0%7C0%7C637558093114409974%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DCMIlY=
5Lj2Yqvusz2HwmGtwX71KgjYHU0MnRLtbD8Kso%3D&amp;amp;reserved=3D0</a><br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB51650B6A0AC1BF505DE37BC287549DM4PR12MB5165namp_--

--===============1901162576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1901162576==--
