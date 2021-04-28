Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8B3C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 13:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B706161411
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 13:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B706161411
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ABDE6E202;
	Wed, 28 Apr 2021 13:19:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E26676E202
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 13:19:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhTGUBtevLbtunP2OvX/JKK/NZi70fps1g+tKlxZ5k6cE1cgET4cY6Z1K+tJK7f4s/3mE/6NI++Knpx9X1rpLUe4RP1+loP6c4aXtxuf8A1boE4HpN5OINt+w8w8f88Ysp7JQ8Z3WObbGKibpnaj7xBRFlrCo2vGIdQLoDdjYj/5pzBNYwJQugV+U37o1tJoCD//5nhz3siaHzsQ1gUIS46XvTeFWL0jXtBbIk7D3B6vyJPZJDTLFaiZ0n79jCEfDyb2ne21ZoSUfUMsthhRFYmbu6NbrvOxvEU7qlLGB7AyJJcONUuB6EByPFQR6t2zGgp2mZeGNJUTGn6PJD91ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXsxUHshy1Ih5tWjmZAcmUBIfZibX63UZyWAPVQ+cDk=;
 b=l5/WquC+3hSl+qzaURglZaW8gR95+j8dKg15lsXjAjjdWXFTJp22byVOSzk4omJVoULDspl0iRsJUQm8MyGvZjkHAwwmwtubSaveIWfZ04flLkvH5n/9iG1/QeI5MU142av8usG71FqUGfX2FlNhcgzfYLj1QGEW3sDkvBQqqA/DHpM/rj5ic0E8dLvj+w72LrfFs5hcOfM+kzhnzWjOpj0qbS/kSgVasMPEJxRP1l3uHI5hXT+tOlbTK7/SoEtMdRnU8P1RSa68u0ZeAmcgN5Ahzi6DFDxGlyTHiteA5Pu4mAD33H03Gdl9895WtzEXU0R7De9jAoXceFUM/0vQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXsxUHshy1Ih5tWjmZAcmUBIfZibX63UZyWAPVQ+cDk=;
 b=fW+oe/HXluRZE9Vtx3WwjVEyL9JmnFFuUhwHuCDsvvOFBOQtnLwBTy+Rmf9T220TO/eqwhhJqUfuhjzM4CPpmFlNp20mClwoYpXylJgi/mMNodfaMweRnAmRAYrL24sy6JQNSQuLQ1/sC939Q1y2/j0FeZ+zTaXj+mLVD7CcQVY=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Wed, 28 Apr
 2021 13:19:45 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4087.026; Wed, 28 Apr 2021
 13:19:45 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix r initial values
Thread-Topic: [PATCH] drm/amdgpu: fix r initial values
Thread-Index: AQHXO+irhkmTzORotkyWenue0vdTbqrJ6mdi
Date: Wed, 28 Apr 2021 13:19:45 +0000
Message-ID: <MN2PR12MB4488DD9732DB8AC1DAD3263FF7409@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210428044037.185163-1-Victor.Zhao@amd.com>
In-Reply-To: <20210428044037.185163-1-Victor.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-28T13:19:44.848Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fc7082f-e0c9-4cd6-54f3-08d90a484aaa
x-ms-traffictypediagnostic: MN2PR12MB4488:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4488ABE2CB40F9BF20EB557CF7409@MN2PR12MB4488.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kBNZoqJ4MGrGKWMNmF6bnObPBDjfFYjEZmU1bP15FYkVs8TfQlNr8DVRnQc9KaBdKOsr7we3nPhsOlkO5yHRpVbsg04A69WOqPNfCb2gOiAYt6stucJ8YXNh1XXL0f72vCwfdQ7dwQj5WzMiVOmuJf48OyXHhf4/WFj/nYVczwgProiBZdYtx2r3/E6hFttsxwcmebX4wBGLjKPSeVTnGvGP4zN+AYzD95viEsw1t//7DWI5gjnPoka9t0HhW7/fYo/XFWPVfOhomGakdSe518u8ojNcrSHwzYwLzpw3CKeGiKG6G3uYo5iMxCWAk2Uzv/Kyrrh1mYX2HKsikvOouXtVQ+ZFXkQvIoEUZdogyxSTSA6iFcQUGsCmlRZpxGJ2driAXyiUqwtXfRP0nN6Or/RwmiYDg1wBmU+QpV0Ytzx6w68zxi1BLD+WN14vyOEsV7fw5S9N/i4jpSisteBzaXalCheOIlQXymzNBYNXhQeb2fVTEGAcZDLxTH2frHM2nV97m930uNFF6A55zsxiQ1NxvtH+znQYCdU1+9Aa3Y9BARmw1i+VRiwmveX7WZv5RC0uTkpDnLA/TR43k8z8gqdblytAMJgnOnoBaeZFlhfA2BwAvewkYz70UtbN+g+Ws38oDGcORY+XcyEz9WG6ew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(86362001)(8936002)(966005)(5660300002)(45080400002)(8676002)(478600001)(7696005)(83380400001)(33656002)(166002)(316002)(9686003)(64756008)(2906002)(71200400001)(110136005)(38100700002)(55016002)(76116006)(66946007)(186003)(66556008)(26005)(52536014)(19627405001)(53546011)(122000001)(66446008)(66476007)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xHI+Mk2vY/HIjHa6DR0IpS7lTkGVMTWh7P4KBse4tM4OwrYnQ4ALw19CBiAP?=
 =?us-ascii?Q?NlwZEWa7sqQd6Hc2BOPLQCZRVHOKPkmdwFCtvaMt50SGqgR2TlyRHAwiD+Vu?=
 =?us-ascii?Q?2E8/5cU7aVEncd6iq8Z1mpGT56TWCx3taSB3V8fAsG4kmTkIk5GXhFTdEoVr?=
 =?us-ascii?Q?JcN9NtmmIpwlpeb/wqy+adJQ3G+Kozt/Aqb710cGveHVcz6mRdW7hGjXY+Gt?=
 =?us-ascii?Q?DsxUAtoNob1MQbg1Q4fvwVzz8oYC5WFQX+/4bvguwmfv0f8y8W7XSEmHxsE6?=
 =?us-ascii?Q?owmFzlI6zRsL2J9N4h5JrlcDPaCuHBI4L/wK8ZyGz0eXs9f02xR2aR/lY7W3?=
 =?us-ascii?Q?v2qjOstojkeWA5rmuEtKN21o2l3TuTEwa2aA51nVhj3DmUT8Nj4T9HoQ6puF?=
 =?us-ascii?Q?DUC3AX+/uVjRJPCqidfJdkAt1tUDQPX9EEasEpZbNP72SI4+2s02jWqEfVox?=
 =?us-ascii?Q?8qV6VoeCgpb3LSfYTcVyyVkIj58l5ZaNc9aVT26yL9oD4vwKi3I+GlGqCHaa?=
 =?us-ascii?Q?MJq+0dGwzr3sgjAlCUgN0qOHfAiZIS1wDQSiJMgJF1uj93mRkowcvqA45QgO?=
 =?us-ascii?Q?CYnVQ4sMOiWGwfUUgTb0nuDU/sJ4lSDQx8rhGlhZmmNJw3lgtjmkeeixElwW?=
 =?us-ascii?Q?9BVPZ6SdPTuO01iBsaSkif33+/deyXgAFpImIQWS0izG3qIRJoof8f6YUoHS?=
 =?us-ascii?Q?nMVZq8fmSygs9ZnuBJNcRmWBuK+KeflKM//G8MwAapZbycaUwM+JAG6NINWc?=
 =?us-ascii?Q?UkhnDdWbCfdfAppVv6fLbizaXBzqxDdH2tPwJYHXOOpu1opGfxIE8uOS5cZ1?=
 =?us-ascii?Q?qsSJtTk3NAGUgtOaydF0h6O7M4Ky6PTb11rzkMi2OJaLbooX1YPr8BFoK2PB?=
 =?us-ascii?Q?0Ped6kpjD63p+6xKY1Kth/oK8l/kinYxFLLlIvJZoRa/2+QzHDOpDrdlW8r5?=
 =?us-ascii?Q?Jwox/PLOc8IdLSxKCA7CzMJ4qvUq51xx2JFyi1VKOdmyEUBeqrNASTmymQlg?=
 =?us-ascii?Q?lffuBjKbLHYTN3hkHIO9qaTM3Z8enI1EopqY45zNn9jfut3w3a5l0bhuZnL5?=
 =?us-ascii?Q?OOnEjgpgh6J53OAqqdg4TEGrT6w+k3I9PRaAXX1HRVubgBgcWJZcvHwG8PVy?=
 =?us-ascii?Q?l1opdcdoLKG8a1LHaPQ0EyPL9C5Bw1JsEAKwfqU2xeicN20USPMyLfuvILVr?=
 =?us-ascii?Q?kf8ZDEX2qd1xMcnXBkBJxTtKsxCRwJe9lk3dmzqE/AF3cvE+rcDfrh7bQhQj?=
 =?us-ascii?Q?BLgBcxbmswCFJG7KYfr91X+PexXV38HKBOY+wqJyPTOzAOv8erZ01zxNer0L?=
 =?us-ascii?Q?8UDh4KW1X/bj/GHWSVqHdfpF?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc7082f-e0c9-4cd6-54f3-08d90a484aaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 13:19:45.4583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rqcsm6rf429I51aTjgysCRSsLczr8Q3HeOVRaDIe8PG8VTvnk+R/4Ll/dRIQS703XZB9p2mirAGiIYCCc1VmwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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
Content-Type: multipart/mixed; boundary="===============1509989110=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1509989110==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488DD9732DB8AC1DAD3263FF7409MN2PR12MB4488namp_"

--_000_MN2PR12MB4488DD9732DB8AC1DAD3263FF7409MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Victor Z=
hao <Victor.Zhao@amd.com>
Sent: Wednesday, April 28, 2021 12:40 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Victor <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu: fix r initial values

Sriov gets suspend of IP block <dce_virtual> failed as return
value was not initialized.

v2: return 0 directly to align original code semantic before this
was broken out into a separate helper function instead of setting
initial values

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c
index 0f17984fdea4..e0234d6762b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1422,7 +1422,7 @@ int amdgpu_display_suspend_helper(struct amdgpu_devic=
e *adev)
                         }
                 }
         }
-       return r;
+       return 0;
 }

 int amdgpu_display_resume_helper(struct amdgpu_device *adev)
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C7925d9ce21714b35330b08d909ffcd6f%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637551816535414647%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DsSBSp4Gdor1FBEldOCBMYd7ZZkYOUFLCh%2BJVrMus5zU%3D&amp;reserved=3D0

--_000_MN2PR12MB4488DD9732DB8AC1DAD3263FF7409MN2PR12MB4488namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Victor Zhao &lt;Victor.Zhao@a=
md.com&gt;<br>
<b>Sent:</b> Wednesday, April 28, 2021 12:40 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhao, Victor &lt;Victor.Zhao@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix r initial values</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Sriov gets suspend of IP block &lt;dce_virtual&gt;=
 failed as return<br>
value was not initialized.<br>
<br>
v2: return 0 directly to align original code semantic before this<br>
was broken out into a separate helper function instead of setting<br>
initial values<br>
<br>
Signed-off-by: Victor Zhao &lt;Victor.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c<br>
index 0f17984fdea4..e0234d6762b9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
@@ -1422,7 +1422,7 @@ int amdgpu_display_suspend_helper(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int amdgpu_display_resume_helper(struct amdgpu_device *adev)<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C7925d9ce21714b35330b08d909ffcd6f%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637551816535414647%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DsSBSp4Gdor1FBEldOCBMYd7ZZkYOUFLCh%2BJVrMus5zU%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C7925d9ce21714b35330b08d909ffcd=
6f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637551816535414647%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3DsSBSp4Gdor1FBEldOCBMYd7ZZkYOUFLCh%2BJVrMus5z=
U%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488DD9732DB8AC1DAD3263FF7409MN2PR12MB4488namp_--

--===============1509989110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1509989110==--
