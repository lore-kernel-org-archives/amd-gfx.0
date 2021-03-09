Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F108FC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 20:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C50A65224
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 20:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C50A65224
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 498D56E8E8;
	Tue,  9 Mar 2021 20:17:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAB696E95E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 20:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHLB/+6NMdWJBBf1qSTISchzM5jv20tEwbcAKdEZmCiBFuFklmSe/dzOfx1IpeEBvl8wlD0CcVw9NTTVnJod81HtdEDTM8nF8tsn8jylbg8jz9JcZ/R8JOOEzDuQPcw2IMw0KhhfHy43JJGka1A4NUYHZ7Vy5AfURlQFGx8yC3IwJLQnbkAxDfs/5Mo8eMdgOt3VAAcGw3nsjYQqVnZ2xxrYe4Ep/IEaGgYbRixG+TtW35wS3PO9sean1bLLLMbiZEOEe7XIQfRxSi2nPw7nc3GYtM4/B54VDisCMtBMOEEimleEfK0qsiy+ix+hiaPsB6UfFL8amE5iQMMMSVO3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrgprjxKRIU4YQZnJssGC3iVF3rvQi3IzvN4IFLDTFA=;
 b=VdT4SzpRqb2dRvhApBuZeDk+oFFReOmlLhemIily3qu6ss/NG5crBPn6n6K87dSYq/TCJH4K1Z36e09X1sO0x3/2VLjZ1e20RtWK2sHV5ReYw0V9vPlkJkHCtSkttHJa1mN1AeViXz2HLSNkf422gvJAf1OvybfRmPYKxd6W+p9nk0xG9SOBT6jxgJbNs69t2LQSeUY3vfr3E9p6HjgV1/cNVgLq9t02jJmeqLC3hPfcimPS5PASBp1cjRYrqqAjsFFdHg/xpzS1FzmErfXLzFDggercKuas/uaCzWNSZSGJNaaa4MGp8LiHPsA8JbuzG46QxtvqrcmdHo8yBbMb3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrgprjxKRIU4YQZnJssGC3iVF3rvQi3IzvN4IFLDTFA=;
 b=I5p1h5KaYZ9QBJgkkvqBbv0XBokSnz1edhR+KG67OEF49ruDSloyplEUIA7A+unmvuIvGhEMqk2Sgh5Q6vlq1w2Bx69EojDGQKO8lcNufuYoIV3K+F9nFhEQaW5p0jVpkpn5yzwDYgcbSQysCwyUli7VAaD3SSWd/Tg59wIGbvQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.29; Tue, 9 Mar
 2021 20:17:16 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%4]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 20:17:16 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdkfd: Bump KFD API version
Thread-Topic: [PATCH 1/1] drm/amdkfd: Bump KFD API version
Thread-Index: AQHXFR/YgF1yRj6B10CMF1YNmG2iLKp8F+O6
Date: Tue, 9 Mar 2021 20:17:15 +0000
Message-ID: <MN2PR12MB448886713A8239A84D2FEF69F7929@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210309200644.28188-1-Felix.Kuehling@amd.com>
In-Reply-To: <20210309200644.28188-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-09T20:17:15.370Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dadeedaa-808d-4726-7028-08d8e3385533
x-ms-traffictypediagnostic: MN2PR12MB4454:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB44548F9ACE941AEBE7A4C239F7929@MN2PR12MB4454.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eg1RFFscuS26gItXFHGmql+xXb2IMs+S3HvsG3f3x0+ILbQjALbqXuVYo+NvzgWS97B6JnDnCMKYzIWcJEGzBgVg4vlYkLpdWSu1aETvlrhIPU/1OSLN16/M5iB3VrO7bWySwqy71I6E9TrCrWr+IPsFJRoqhtFeH+oOOo5+XEEeE0L9bI86X2keofAsu+II96LbLNroXKK1Ntuu1O6oRhfgctNwnn8scxujafau7pAsWrpXpBOKS7TuYr4yzvinwSvaiVQ5XZbdkdC7nTZJYYEaqR5s3kLt6cjJX3/XOa+YfRcFhXn6cRID4Jd/rz3n8TCHNJ0qJ+04XEOaxnv4BSKqXnJ35T9R3YZBKLFkcpEJHbDjPz+WR6dEcd+P5D2guFyo1nD6vv0Z8yRioDba+BmwAHJTBCbeoyHf7ukpHjbhDugmWJqMz81p4V2cHsZeV029RRVJZOLQ1wtHydyloV6/luw/d5YuMCN3wtBI8+//T1QsYoLRak83tdjjGLRIs5ICx8ESNns+7Q4YW53VvYYzVqfczcOG58Du1HJ5XuP+vDp33wopKKevh4uNKQMW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(66556008)(86362001)(478600001)(166002)(66946007)(76116006)(45080400002)(64756008)(4326008)(83380400001)(110136005)(5660300002)(66446008)(66476007)(33656002)(53546011)(6506007)(966005)(186003)(26005)(2906002)(316002)(7696005)(71200400001)(8936002)(52536014)(55016002)(19627405001)(9686003)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bHqrjoKFv3GlrIb6ZGqzcVPzmSINcl/7daK93bG1+m8IEaPAVaCieCzU1FhJ?=
 =?us-ascii?Q?C4G1Ve7xLTw/zb2yqk/gOMiN59aE7kS0fwk1Bm5EaXsO+mFkI3wKOtC4sHdN?=
 =?us-ascii?Q?96hWkKAAU4hfz15BTTiPknFo6tPk0a8GmowxGfT4RAQtlGMoMQxMpyoPZBbe?=
 =?us-ascii?Q?AW/uZQey1c+Ej0okO77Mc24d5nPFRjg/iHgTG8pvU5rZCCxwpVdH0tc3720v?=
 =?us-ascii?Q?Wt8ydt8+UDncjNmC6MfInleGy6TNGh0x//vj+AZem57e5VQVb2CumQjJ1tqM?=
 =?us-ascii?Q?vSkTB+RGn/iDDv+P2eZDmWRJvNd3pEwuGqDZR0a5BWR3vKKOaPBCLj8D8Lal?=
 =?us-ascii?Q?/prd1rcmvlSTa73sNiryWFPYQRKTUFUYEArfAQ3X7U6EemNtLNyNlQDHdKVA?=
 =?us-ascii?Q?md8nLFVFF8PJ64pw4u5QNpZxjlGbS91fdEWp0tiWFLVb6LfwmHTfMO/sJxUN?=
 =?us-ascii?Q?jGS8adc7TGDOpzNzWsRlMVbOsto/GLs1spt6OMest3NoWENZtg+pn/peWBkY?=
 =?us-ascii?Q?xXfLk+vPjMdxHElNFUSyON2M4488+vuagvuPBmuaLaBubctg1gTt2DKyGjOK?=
 =?us-ascii?Q?0se2hGGnVKEnExHJO67rvzlEgl7a0SI3FsYUkuQ0upwu/pACmMbs9wN6nb9p?=
 =?us-ascii?Q?8UOc2COIqCNgeEWfGXCKAkdOzVSmHnH69UN4l4gVFZpgxtjwFaS+MH71BaV4?=
 =?us-ascii?Q?i4U28SSYedz/zkoikwIUAklHjV6oAFAAGIbGgJevztMlrJFw0gTSbcgdpn+T?=
 =?us-ascii?Q?GC3brtyhJpYjZ46VOZ9eEKOahAolYoPShfNYXPDXusblI+/8Q2DmoQ6ciE6k?=
 =?us-ascii?Q?icpTWf+MFaqOidMQDB947jKCz6lLZzx2maMKRSODBa3sH3VvppDkLqgmAn/D?=
 =?us-ascii?Q?u/fFhhnt7YOA3Vs1rWwIFqtAVoqmaxDNumel9gdb7sSojA0QwiQM7U6q3StY?=
 =?us-ascii?Q?nfj1t6uecbMK9BB9RSxGAZIMyWZ1LOUqHodJOcg4Dq129iqP0G87be3aqqpJ?=
 =?us-ascii?Q?cY88rv8x0lms2mONabU4CfFw9NOaPJCWF+egtWy+kMs451LpVZ4c8xskjoRq?=
 =?us-ascii?Q?sQ6nbz+xEO9QHY6c9mmNq73wfzwk/zfIbcRxLHxB8Ffi3rSrqj09uHAZ3DSZ?=
 =?us-ascii?Q?EJyv2etzrYq0W9T/nyxs3Z4J0Gs3J5c0ehGfG+xsC/tLmsTMZnjAHsjlrcfJ?=
 =?us-ascii?Q?3/TZEU37e33Fwk9NQR97CTYAKsXyGJLy4Ue9UcP622BT2btQ8GduqDcVh6i8?=
 =?us-ascii?Q?3qCt0gj53cdYTi2rgZAa/7T5JwVUCYUjnC7qCeLCqseurSFGOtyjKzdfkdSU?=
 =?us-ascii?Q?YykW5XW8PRLKqDncMSk99C4Y?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dadeedaa-808d-4726-7028-08d8e3385533
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 20:17:15.8928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 753UdXJHTT230FItIErQbQEy6Qtg0sHj6D4J7zCN6OUakkWGSGuid+6NtIUyoobGD5b+HPblU8jq9L7P7vEq8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
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
Cc: "Keely, Sean" <Sean.Keely@amd.com>
Content-Type: multipart/mixed; boundary="===============2096605209=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2096605209==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448886713A8239A84D2FEF69F7929MN2PR12MB4488namp_"

--_000_MN2PR12MB448886713A8239A84D2FEF69F7929MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

If you have a link to the userspace patches that use this, it would be good=
 to include in the patch description.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Felix Ku=
ehling <Felix.Kuehling@amd.com>
Sent: Tuesday, March 9, 2021 3:06 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Keely, Sean <Sean.Keely@amd.com>
Subject: [PATCH 1/1] drm/amdkfd: Bump KFD API version

Indicate the availability reliable SRAM EDC state in the new bit
in the device properties.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h
index 18449f746097..bf5e7d7846dd 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -29,9 +29,10 @@
 /*
  * - 1.1 - initial version
  * - 1.3 - Add SMI events support
+ * - 1.4 - Indicate new SRAM EDC bit in device properties
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 3
+#define KFD_IOCTL_MINOR_VERSION 4

 struct kfd_ioctl_get_version_args {
         __u32 major_version;    /* from KFD */
--
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C08c1668cc28a4b5400ec08d8e336f9e7%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637509172551256043%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DWGCf9mTBpRHKQmLrDIr25Ua78aDEhn0OVxhGBRSgwAk%3D&amp;reserved=3D0

--_000_MN2PR12MB448886713A8239A84D2FEF69F7929MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
If you have a link to the userspace patches that use this, it would be good=
 to include in the patch description.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Felix Kuehling &lt;Felix.Kueh=
ling@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 9, 2021 3:06 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Keely, Sean &lt;Sean.Keely@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/1] drm/amdkfd: Bump KFD API version</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Indicate the availability reliable SRAM EDC state =
in the new bit<br>
in the device properties.<br>
<br>
Signed-off-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
---<br>
&nbsp;include/uapi/linux/kfd_ioctl.h | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h<br>
index 18449f746097..bf5e7d7846dd 100644<br>
--- a/include/uapi/linux/kfd_ioctl.h<br>
+++ b/include/uapi/linux/kfd_ioctl.h<br>
@@ -29,9 +29,10 @@<br>
&nbsp;/*<br>
&nbsp; * - 1.1 - initial version<br>
&nbsp; * - 1.3 - Add SMI events support<br>
+ * - 1.4 - Indicate new SRAM EDC bit in device properties<br>
&nbsp; */<br>
&nbsp;#define KFD_IOCTL_MAJOR_VERSION 1<br>
-#define KFD_IOCTL_MINOR_VERSION 3<br>
+#define KFD_IOCTL_MINOR_VERSION 4<br>
&nbsp;<br>
&nbsp;struct kfd_ioctl_get_version_args {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 major_version;&nbsp;=
&nbsp;&nbsp; /* from KFD */<br>
-- <br>
2.30.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C08c1668cc28a4b5400ec08d8e336f9e7%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509172551256043%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DWGCf9mTBpRHKQmLrDIr25Ua78aDEhn0OVxhGBRSgwAk%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Calexander.deucher%40amd.com%7C08c1668cc28a4b5400ec08d8e336f9e7=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509172551256043%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;amp;sdata=3DWGCf9mTBpRHKQmLrDIr25Ua78aDEhn0OVxhGBRSgwAk%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448886713A8239A84D2FEF69F7929MN2PR12MB4488namp_--

--===============2096605209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2096605209==--
