Return-Path: <SRS0=fEJB=IO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968F3C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 02:35:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5245364FF5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 02:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5245364FF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADDCD6E1EC;
	Tue, 16 Mar 2021 02:35:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C83566E1EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 02:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpMM09SKzYpwHZwgfEHsX3Q6duNzLlH52HnfkSu1kjmbZs0Gt63RGTWzQq41ye4sIjOLilw/jvggDPzcfNw8V+dmyO9VUF5B8h8YuFemTgDmJCyHb+puvyb9g5I2RYzpf+aoiKLLzv2S599DirVDdQ6PEo00OzVfZ8vCvo7429PtDVcLqd26MjJDpyCpz9iZMc7KSdHJ4eCc62rIEQRK+36BmDGPC05TESe96cCKGvgw1EzmiwHuI01m9HkDhTM1TX0qNNnK2boGpXaNw31kZt9R5YrfmwrnkdcZRruN54k4WNbTvTRv1rzN1jSRUVe/0j5/DkxVQl7NeQkNukLShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YsIw/PJTN0TZigdPmxiTKm/gjY5zKCjNH3r2Mos7eo=;
 b=gTouPR/KXeTBk/UbirVJRVLyQ1xBb26Swh4r8gDU+7CAWExRy/3Qwh8B9NtyJmB3wPJhmbVue9w0UBnFMv5G/MNblN8gyBhwVw7umbs5N3kMCABDOnklokurZNWfcZz4mftRi7DxFCW4DC7puuxlctEWccTDbTlMb770/X9j4oY3g02EOnSW7gIXvHeZvtILgF8Xk8v75nE+HpTVZEhztkBB/ywIdYxPoZPm9S8XdkWwjLaRapXROaGGxHjDef3RFPVnRgqFNjGJNv+UuP4vt2QDiOkWgowwPJPvkWlvCSSI7GnHNUdWaFd5P5lfwLfvzxUKXH3sQCN1bNhVfHsnDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YsIw/PJTN0TZigdPmxiTKm/gjY5zKCjNH3r2Mos7eo=;
 b=0SceToxmtJF53vkM9gVgXPQT3pSgynBtz61alz0+r4+JVhRC51tOBT7jcV8HsMOPlX9CJCEGwMDMS4LR1NcVj8GF3aaM/aFbMvbMK/VpSQprCDz9lWlxweo5dFRysmBH2L2kOGrM/jr+55FT/6cOGN9DlkJ5blX988gYU+qadlU=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2928.namprd12.prod.outlook.com (2603:10b6:208:105::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 02:35:10 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 02:35:10 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: fix workload mismatch on vega10
Thread-Topic: [PATCH] drm/amd/pm: fix workload mismatch on vega10
Thread-Index: AQHXGgxKiufdcdzBCUWu6NjaPxUzKaqF5Wox
Date: Tue, 16 Mar 2021 02:35:10 +0000
Message-ID: <MN2PR12MB3022A694EF464F7E036D53F3A26B9@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20210316022951.9544-1-kenneth.feng@amd.com>
In-Reply-To: <20210316022951.9544-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-16T02:35:09.740Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f24648b-d252-49b1-1b55-08d8e8241ea9
x-ms-traffictypediagnostic: MN2PR12MB2928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2928974C9651BE7730EA8363A26B9@MN2PR12MB2928.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JBXSF0vX2sLMghfJ19SgFb5TM8+ZCyU7tQD1DClZnOzmTCsGyzsmexFjc2cR2wAk4PtXLHnLAEpNBvDtIYZxJVKnOUaYeqlmv+v2CZthQRTN4FfbPYhK7E4scfEuRjBypPcgNjkS/ydEoYdcMUNduUr0d6bjJKZQqX9uc5xlNz0OF19wfajTDZ4Hj/2DJYAf4SbtjIUPPirgiaCULBLfnW8X2QffhWV9crmAvZpWfC4ONResaBjB8qrGTxjthCtTo67RdGuXRTcwlo7+oqtIUrzONJ+ptI2cU9z6bvAYWReSNR6bIT79rCdNuOR1wHz0q7WTuOIb8xVAgMhvdN4HV3surV400N2M4FByG+V/jDq0ZQPRgCZqVpOJnL++8jC78xxcOoxxJNydcvnGw8bVbzv91nuJOACfTQUm/dYPxmqOvkdnP9+t+MKFDPnU7nUMQOjVQ7FqQOHvHLHnUcZ1np9r1/7MVk4VAPjBPlNVRpZRNXFcfzHT+nRzMbDotqxj5y4S03xgu9FUvv5MlHqv/DTJm0g9E/4OWvYvE9/95cgrla9Gj2ugTv4+5Cu2nor/51APTPmZdY3sB7PZOzOoR75IxEtuB3n+/s0CjdVqDoo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(8936002)(966005)(166002)(66446008)(478600001)(110136005)(83380400001)(45080400002)(52536014)(71200400001)(19627405001)(86362001)(186003)(26005)(66946007)(8676002)(2906002)(91956017)(5660300002)(9686003)(7696005)(316002)(76116006)(66556008)(66476007)(6506007)(55016002)(64756008)(33656002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?5cslsCaXJz2QOMhRVtFH4o99qQU4uKQZRkQJVDhqUQNPfUr7W2GXuuUQOb?=
 =?iso-8859-1?Q?71o+Krucf0J7Pn1+oC7ERKWbZtV9RkbC8Tg9OKbW5FEKCcyMw/w89Rq3S7?=
 =?iso-8859-1?Q?9gIZ9QxRwec6FWw3rMuJ6byTHaz7GNMxCI2gOLD+VCeEgpRL72Kx9tvD6G?=
 =?iso-8859-1?Q?2xh4zvhFCzEdMirHHTApOlC1Yw4s0fFl6INrkXkiUBTIR2+rrDSVxJamry?=
 =?iso-8859-1?Q?vBPPCCCW1m6Z8WbKkkdJRMhMrL/GMx6hZMKndJrTkj4E4oMZkMxpmJIljB?=
 =?iso-8859-1?Q?+0Gml5psVjHe4edEbLP8gOGKBZ14YmpSpmq55+I1Y2xhgcDcRBXt0G7J4j?=
 =?iso-8859-1?Q?UF7fnFqJ6JjLDzF5yCJp8bbpHmfP49uhDgrpcsZV6NsOYuQjUsX72/cCfs?=
 =?iso-8859-1?Q?BUoegZk+TlTCa0TrxptlnU7rct0XB4ZHnXkyTuDViNd2aNF47QSsRWkthy?=
 =?iso-8859-1?Q?S0ovcy3dhfkONwKlfje1pTP81a+x2pTv9ysCQlRyr0XhqwP7wtkGYsmg9m?=
 =?iso-8859-1?Q?N0ewf8uXPpbsSYJo77iDthX5BUyn57sxHI3fbl86TfYKlFTjBo02JkAexu?=
 =?iso-8859-1?Q?4u+rNqRBko1HgZUvPLQUgzbLglzMSLmBeVDwnWGXStBiZYMh6jbOdl/beE?=
 =?iso-8859-1?Q?Tp0o6FpF1tmsuBP+75hS2jMNmFBBKhafG5ReAXsK4oLLIvvlxw2Y8XvMRU?=
 =?iso-8859-1?Q?jDqhZiaFlGEFwYIa1ikc07FlNjHVg8G+agrCCdFV3Wea539zMWgtgFYbzz?=
 =?iso-8859-1?Q?11MMN3WVF3qI0k3ak81BKoxwDvAtuzHnPJTh7IL0GtwocGlXGKmRUoSVXU?=
 =?iso-8859-1?Q?h0yXDqUapWQrFq4SLTC8jDOWrk1D3+Ehwk+x1qHuMqBFO4FShA1fERYD5s?=
 =?iso-8859-1?Q?HlKY4246JZFqSE7c6BZJQ+SSw0ot0xTA3u5i5a6Rly8kCoXM+G3g6Di+AC?=
 =?iso-8859-1?Q?js3mcf5fYatkHqhe9ko2qFy+cMwO/vJgcRJijLkPmpBTyVvHQEtiZInkPG?=
 =?iso-8859-1?Q?UVM/OvxcuEjFK1wzR0y3tXuWHsEzKryrki78zfzvBKF2NNRk5BhY7ab7zh?=
 =?iso-8859-1?Q?in1pKsEo2wWMKn5DUeE7+Qg6Pc9QkGCD1YRgaeQp+gTZOs6wzxCxiy55B0?=
 =?iso-8859-1?Q?1ykNHbkZzVuLZScTaAnyrL/+29M0blS86SUldJfMmzJcb9GO2k7lgnr/ZK?=
 =?iso-8859-1?Q?wqkxKrCSNK8ExoOPX6XVZ0ogiOyBX7Gu+9l+9emiejc2nqFEhLS1AaxEzd?=
 =?iso-8859-1?Q?HFWnlI3dNA8vTHYDDplS89MydsN7NTrdH5ptHErGLmS/7qcFl7m3ECTK0M?=
 =?iso-8859-1?Q?ZN+ZhwDR6lSPTrm4P5eI6wvZhtETH23dwY4vKVa5/sY0axjWH2ZTe7fHL3?=
 =?iso-8859-1?Q?EzBm/uVcGM?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f24648b-d252-49b1-1b55-08d8e8241ea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 02:35:10.1981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JczaJ0m0Xfn1i+MAG5iVUvKunx8z8eVTQ5C1MhPUUSc3Vy6Tr4v5ls4FJVOBLWS4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2928
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
Content-Type: multipart/mixed; boundary="===============0045677606=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0045677606==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022A694EF464F7E036D53F3A26B9MN2PR12MB3022namp_"

--_000_MN2PR12MB3022A694EF464F7E036D53F3A26B9MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards.
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kenneth =
Feng <kenneth.feng@amd.com>
Sent: Tuesday, March 16, 2021 10:29 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix workload mismatch on vega10

Workload number mapped to the correct one.
This issue is only on vega10.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index f5a32654cde7..31c61ac3bd5e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5160,7 +5160,7 @@ static int vega10_set_power_profile_mode(struct pp_hw=
mgr *hwmgr, long *input, ui

 out:
         smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_SetWorkloadMa=
sk,
-                                               1 << power_profile_mode,
+                                               (!power_profile_mode) ? 0 :=
 1 << (power_profile_mode - 1),
                                                 NULL);
         hwmgr->power_profile_mode =3D power_profile_mode;

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7C42f8a4ebbae1442d2b4a08d8e8236ae1%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637514586124157424%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DIs=
JaWeIqqZxzNcPL5wCOC1AvwDUoDHB%2BLRPkjdvPqng%3D&amp;reserved=3D0

--_000_MN2PR12MB3022A694EF464F7E036D53F3A26B9MN2PR12MB3022namp_
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
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kenneth Feng &lt;kenneth.feng=
@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 16, 2021 10:29 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: fix workload mismatch on vega10</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Workload number mapped to the correct one.<br>
This issue is only on vega10.<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c<br>
index f5a32654cde7..31c61ac3bd5e 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -5160,7 +5160,7 @@ static int vega10_set_power_profile_mode(struct pp_hw=
mgr *hwmgr, long *input, ui<br>
&nbsp;<br>
&nbsp;out:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_=
parameter(hwmgr, PPSMC_MSG_SetWorkloadMask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt; power_profi=
le_mode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!power_profile_mode) =
? 0 : 1 &lt;&lt; (power_profile_mode - 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;power_profile_mo=
de =3D power_profile_mode;<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7C42f8a4ebbae1442d2b4a08d8e8236ae1%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637514586124157424%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DIsJaWeIqqZxzNcPL5wCOC1AvwDUoDHB%2BLRPkjdvPqng%3D&amp;amp;r=
eserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D0=
4%7C01%7CKevin1.Wang%40amd.com%7C42f8a4ebbae1442d2b4a08d8e8236ae1%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637514586124157424%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10=
00&amp;amp;sdata=3DIsJaWeIqqZxzNcPL5wCOC1AvwDUoDHB%2BLRPkjdvPqng%3D&amp;amp=
;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3022A694EF464F7E036D53F3A26B9MN2PR12MB3022namp_--

--===============0045677606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0045677606==--
