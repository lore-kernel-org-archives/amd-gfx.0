Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BF5C07E9B
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 15:27:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65186140C
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 15:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65186140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C60489D5C;
	Mon, 19 Jul 2021 15:27:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D87C89D39
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 15:27:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCsFFVjDhhcdUM05V8bKXxSl/s3RqzBrboGT2ml8HjxD01X77jQuGfD6optWY7MlHSJNjGXK+n0YKxTjZP7PIPgFKSuyUnEd8NBg4dh3HSQ1Gn4uTDYLeVVi2kv5ENvOkLlh01qH+aM0S24nxdqgxB9AwT+4SNjCBhP8ZbDY9/Roml4HpdowJOWKupBwmVBNF7wEMtP4cjcYjTaP+8XJqvaYxbv9UTmAYCkqbKdRd3VKkoRfetlfUIsUa96Sm/a0sKBcIuJqpvW6/Aw6DT5XvoqGxBXvW6ocOJiB6nfwbzgUneVNDvNXur7+9Yy09kuC/5mQ11LXGFdxRwHJYZzuyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBwPRogZsofVtMrIk0AvlvkYamYkViDa5d2ZSXu38l8=;
 b=PE1scvSP1VzfqQjcNA17aBvlm4ggL0QrQtq+XpSVrklSzOn/kZVhH2mRLY1Lf2hxe1GbgHcgqquT05MszoDt2k6Rm5asOgAuYuMPIiHaQhaeCOMKQb6p/fwzpWtzmkueJM7wcrsLwAxR1RHM6ta0etGuXsJrWZBcQzwPAgRF2Ka9LHzKFlGIlNZKhdURB5Uff54n++IPtbkqrFEt5DgsLsje/wihAEBG4r5dhqMBjY95CQ0ywCsKQFzArdYvfQLFJJUiLQ00MqpYcokGsH6fXJRbL+D47nvTrdiGPpQscmTVYCC2veYe5Fuy2ijumCA2n9seKePOK+p0MxajB6eVow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBwPRogZsofVtMrIk0AvlvkYamYkViDa5d2ZSXu38l8=;
 b=nxK1WBFEqz0EavUbwubs5AQ3vXwc2btHEp/IvSnYs4kgg1BDbH06xaS806cDWlpRc/UIC6mvAHLWOom3ezr+xrIIgQtgZp5vINVGkGLVH+2jG1Qa8b8oxe7JZttZfEGLN7vp6vzD6g+ABBy/upFdgWmjgn/RRAzj5VtQd89+sEg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 15:27:10 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 15:27:09 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Jacob, Anson" <Anson.Jacob@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix documentaion for
 amdgpu_bo_add_to_shadow_list
Thread-Topic: [PATCH] drm/amdgpu: Fix documentaion for
 amdgpu_bo_add_to_shadow_list
Thread-Index: AQHXfLF07eOTkI0p/U+G/3xm+yBJGKtKa5ns
Date: Mon, 19 Jul 2021 15:27:09 +0000
Message-ID: <BL1PR12MB5144912DBA7B28ACA0C0DBDAF7E19@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210719151906.215302-1-Anson.Jacob@amd.com>
In-Reply-To: <20210719151906.215302-1-Anson.Jacob@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-19T15:27:09.107Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22b560b5-c29e-49eb-ad24-08d94ac9acca
x-ms-traffictypediagnostic: BL1PR12MB5363:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5363DF1B99B9A1DB2FB806F3F7E19@BL1PR12MB5363.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lOPr7icLLwE6dzmn0tRfLJtHtuwqB71zgKXclUb89eEZuO5LkahW7Oa1R42BMZ1R6MmbJBFPrct1day0nkUrtOxG0H6NNGIO3EQtcB5PUCYez99RIrw3wrs27Zll9WRmSljBsTNVXSDN/lk/KEHGr2pgM0PJxrehj4rGHXZx6FoWOvG7l19MkErqb77cjDANQImQb1MvHLvvCpTWaEf9A7dX7Is4lYtcLmdsLuOVq/SLMwTr4hH5BWdVQX/rZzOjZk65lUFvYi3yN+NPMKagsL4L6BoL8YczDOTXT++2Htm6zm7u9vA8PAsIMDtdClpkRv+vs0UBO4eJJPGSvac8vXfcvE7Cjzm+8Uf4cePJ56LAVyetqGGEndUDh/dLJjyeBElK6ukXBrYyL2RxkXl/9FoNGeotcmLczul6aDXQWKOnqYiAX5rXDqklC5djp46lHeq3kHkNOgPj7lrm78K8E7wg5RfUJHTgINt+rzSMyw46axbxvokx2oeuqOMupiyuhSs0TjnTuq1y5LLRmJ4knB00rm/6JHKSn1uD3RH6l+J0w8hHn23ls1fg/BskxtjOHaygJImPerinTnK4hf6WxKRHqXYEwtwW96kyVgQhxhwcQGyUbbrXwU6nJA2AWFipInADmY12rhT3SgW4RBjPCy3FIfFrPLSIw5tpZbNkRxhoTdR07rdh3wMWEDDCFLfGM5FowG2sVx/7I5eAXsderg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016002)(26005)(53546011)(6506007)(7696005)(122000001)(38100700002)(166002)(966005)(508600001)(71200400001)(83380400001)(45080400002)(9686003)(86362001)(66476007)(186003)(316002)(33656002)(52536014)(2906002)(8936002)(5660300002)(76116006)(8676002)(66556008)(64756008)(19627405001)(66446008)(66946007)(110136005)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Ow2L3yt94QkEKp/t9wWI49bwvVHJuj8U5XE/qeaZZGQ2mzI1vR29wGNVsAl?=
 =?us-ascii?Q?YDh99ExJIz7hpCO5XKMSRPPwVIrKMXeSsKPAC/MxMeEBO3Sm+jYvF35vAKKM?=
 =?us-ascii?Q?EmUOrAa9OfeTyxM56fNhK6vmSJcyRVgeC45HgTR8Er/RVWq68zsCk5qJXa57?=
 =?us-ascii?Q?jpXej39Mg5qmCRTVdBOhlYr/XvgvBurMr65LqCv0O4a9c8Z+3zzxpnklsg1e?=
 =?us-ascii?Q?NAVAZrS6a7Wj5mksgekaZyAWfzNjWfF8b79E1fXHW7aiUyeaQnaXrxDC21w1?=
 =?us-ascii?Q?gGZwGGy9D4Q3OW2n01sPttNLiSQ9BPW0X6IKyhYLPpUzLR3li8R6nKIK0k/5?=
 =?us-ascii?Q?e7G0+tba7FpZkhSrJC6m4YGoFZQ4tZOLRMjYFdFH2cPvQfP+r3N1/znOXcrp?=
 =?us-ascii?Q?7oZt0k4Y4iqLgMSfg+OXjZKYORKp2mn0WQe8dLdMZmApFBboeM9S/ox+PuHW?=
 =?us-ascii?Q?y/Z1ZKQv2WFHkE4DINQbQsyY8OMgJkeqZy5P0KsSDs/IRrjgBFgE1mDxkIxf?=
 =?us-ascii?Q?8UhZshNgJi67if6dfo14+bM0ubZXIkQY5A3NvHtQ9ZrhtQoM7Jt67Om85bNT?=
 =?us-ascii?Q?I/2EZPJOtnDoGH23KHhHyHeM7+i5Rbwjcqpp1ymi03Dh2e/iz0zci9hP3w+5?=
 =?us-ascii?Q?QXaYFb+hx7ZCES87zjlfYIq+xLec9T4eMaTyZ6OIiApCLlD+rCbZmqh6NuWg?=
 =?us-ascii?Q?bjyPikxSmSpD+HOYFsheikXOUncQx5cT6/Ph2UPc9iHNQYFF1kuHEaoMWKN3?=
 =?us-ascii?Q?JiURTGMGCdKK2SVoG6+kgMAV8VIiVdgR0kVUY9KtGzT+qqH48X1Gj8AgfIMg?=
 =?us-ascii?Q?r8WYFEFPQRg382OAp0Nx49fGJ6v2uzGdpyImNIY0aV86D1xWS5qO8A0dyq1D?=
 =?us-ascii?Q?yUTUVauzzc5BSI9cgiY+rNqfYwYBTH+3Oqmh3XHzs3czXJIA6WqItBY2cb0u?=
 =?us-ascii?Q?ArT/94mUQBglR1vqjbZsMVwsFrjZKeC3UN5YDqgnuPpG0PskreFgxn1Ch8CX?=
 =?us-ascii?Q?sX9QJOyf6d+lunE8Hj8P1kcTTfFMIxX7n/0AupOp5/QPecYAJHC7rxycvMFB?=
 =?us-ascii?Q?4AHvX78W8pgjPD//0Af4tQxVabhYQ5s5Lejo5sqEulxAJIzvBsVdkBxZUB1S?=
 =?us-ascii?Q?Cm2+m3kxEQR2vrXzSEngXz1KcMQkxSRjQ2qLw6AtPyDoG+uVld0ttDwYL6UP?=
 =?us-ascii?Q?LK2wmNecdi0IyC4mOTO8fHkx8t3QVhvh+m+JRvw1WSNzNh5Ud14KctBlSK+l?=
 =?us-ascii?Q?MLsyaEhA6d72dhhSkwHxPcsokZuslQb2zHpbErVVsRVkGhIE8MIv8cL0lzWN?=
 =?us-ascii?Q?zpUZil59WJDuTa1Tzf20a/OA?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b560b5-c29e-49eb-ad24-08d94ac9acca
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 15:27:09.5948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7WuPosp2Du4iMZtqdv4rZEbQEStl2sxY19VjypmEEG9F5fxsp7xkI8+iUADJDM694GeOatO5awG+lOIUKoOu8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
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
Content-Type: multipart/mixed; boundary="===============0498162539=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0498162539==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB5144912DBA7B28ACA0C0DBDAF7E19BL1PR12MB5144namp_"

--_000_BL1PR12MB5144912DBA7B28ACA0C0DBDAF7E19BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Anson Ja=
cob <Anson.Jacob@amd.com>
Sent: Monday, July 19, 2021 11:19 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Jacob, Anson <Anson.Jacob@amd.com>
Subject: [PATCH] drm/amdgpu: Fix documentaion for amdgpu_bo_add_to_shadow_l=
ist

make htmldocs complaints about parameter for amdgpu_bo_add_to_shadow_list

./drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:739: warning: Excess function =
parameter 'bo' description in 'amdgpu_bo_add_to_shadow_list'
./drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:739: warning: Function paramet=
er or member 'vmbo' not described in 'amdgpu_bo_add_to_shadow_list'
./drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:739: warning: Excess function =
parameter 'bo' description in 'amdgpu_bo_add_to_shadow_list'

Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index ea339eaac399..4e2c0270208f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -755,7 +755,7 @@ int amdgpu_bo_validate(struct amdgpu_bo *bo)
 /**
  * amdgpu_bo_add_to_shadow_list - add a BO to the shadow list
  *
- * @bo: BO that will be inserted into the shadow list
+ * @vmbo: BO that will be inserted into the shadow list
  *
  * Insert a BO to the shadow list.
  */
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Cdd6220ed9b714257c0d408d94ac8957e%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637623047634433649%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3Dp6H1ou0jYE7BArtppdvJIdgtcXMqEMwRgUu9s%2BR6vEA%3D&amp;reserved=3D0

--_000_BL1PR12MB5144912DBA7B28ACA0C0DBDAF7E19BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
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
ounces@lists.freedesktop.org&gt; on behalf of Anson Jacob &lt;Anson.Jacob@a=
md.com&gt;<br>
<b>Sent:</b> Monday, July 19, 2021 11:19 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Jacob, Anson &lt;Anson.Jacob@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix documentaion for amdgpu_bo_add_to_s=
hadow_list</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">make htmldocs complaints about parameter for amdgp=
u_bo_add_to_shadow_list<br>
<br>
./drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:739: warning: Excess function =
parameter 'bo' description in 'amdgpu_bo_add_to_shadow_list'<br>
./drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:739: warning: Function paramet=
er or member 'vmbo' not described in 'amdgpu_bo_add_to_shadow_list'<br>
./drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:739: warning: Excess function =
parameter 'bo' description in 'amdgpu_bo_add_to_shadow_list'<br>
<br>
Signed-off-by: Anson Jacob &lt;Anson.Jacob@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c<br>
index ea339eaac399..4e2c0270208f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
@@ -755,7 +755,7 @@ int amdgpu_bo_validate(struct amdgpu_bo *bo)<br>
&nbsp;/**<br>
&nbsp; * amdgpu_bo_add_to_shadow_list - add a BO to the shadow list<br>
&nbsp; *<br>
- * @bo: BO that will be inserted into the shadow list<br>
+ * @vmbo: BO that will be inserted into the shadow list<br>
&nbsp; *<br>
&nbsp; * Insert a BO to the shadow list.<br>
&nbsp; */<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Cdd6220ed9b714257c0d408d94ac8957e%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637623047634433649%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3Dp6H1ou0jYE7BArtppdvJIdgtcXMqEMwRgUu9s%2BR6vEA%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7Cdd6220ed9b714257c0d408d94ac895=
7e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637623047634433649%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3Dp6H1ou0jYE7BArtppdvJIdgtcXMqEMwRgUu9s%2BR6vE=
A%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144912DBA7B28ACA0C0DBDAF7E19BL1PR12MB5144namp_--

--===============0498162539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0498162539==--
