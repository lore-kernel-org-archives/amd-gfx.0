Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D16C4708F
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 07:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B06E161042
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 07:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06E161042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 659476E866;
	Mon, 31 May 2021 07:05:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C257B6E866
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 07:05:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ss0gv1eS6CWVlsJ1oGHJ+4Y4VY7ho4xRCMkabs/fx7xUTEtF1UTkkt0io3llPuBONnoKksl46v4K0xBqzNbeELvw2uByZrY92jTKPB9vcmWu7ugkqs8R4K8YQxkWeWsW4PtcwdNavvlZtQWX+LOY/IyjGUFN5R8cu3HZwYRKmC1TDOx4aB5mMvT0o5+GPCrF7qQdyWHs7N6a+iwI/Yd/j0LURigtXBLbw/HuRnbIQmR93fSORmYOkdUEYWJhPnEWb4aYcfw5vH9k5rTVKdx4AJ/127A03yQV61VFlrq3XRxoooerrv7U/48VldGApq2NMl5uJsupLm2bDHEeBZsg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnqynQL3+CCZQQCIqpOeJyrsZZ9Ctw2mu13buE0McCM=;
 b=M9okJOFqiNkgxbuqzrgSvKfavaxBnhHim/0cf6HiN5o7Op9kIpaYQYpJ8hqtBxhK+epul2O1mcEeUFUGGjSP9V+sbs6TFa3Iyn3IqQdlyBzBXzNPLdoowMolHYz/IsoyZJ7M2heJc42TzrAnXbxMnpxZ3E9+2hGXPqjC+cZPhSRDlAEbl1MWGnHhfDwpLfUskbAPpD/NGdhWL2FwFjbfqJniP3VDjdkEp+JX0Ir0mHLs8h5QRJpiQ+oKvgs6AbU0VY8zoPiOp7A8Y3wTyVeI/2XNIu7K5929+UveCMQ4QjUE1/2ktEkiCjVtAIUV8HBicFkF43jNOEB1nkSAvG1wDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnqynQL3+CCZQQCIqpOeJyrsZZ9Ctw2mu13buE0McCM=;
 b=kMQDf0qVOXtEycUMNXv/1AxuXvYJoRQMND1bp8V4lGBaf6o3unRsJ1eiJVh76I55Dj7qlbUS1OCSQ54wMIyvQFw4Zinopre+SnXbqZPK+P+rMd1ykUS2IcJMr1Zvv5agOQ57axD5cT5QEJmHUlZp8/psEnv7uRhDZ9VLk37VAt0=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5442.namprd12.prod.outlook.com (2603:10b6:5:35b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Mon, 31 May
 2021 07:05:47 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb%7]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 07:05:47 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: use attr_update if the attr has it
Thread-Topic: [PATCH] drm/amd/pm: use attr_update if the attr has it
Thread-Index: AQHXU5fHIcRoI0CQJ0OCo9SnQCqfCKr9L4C6
Date: Mon, 31 May 2021 07:05:47 +0000
Message-ID: <CO6PR12MB54735FBE5D74F5D38BC76C64A23F9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20210527042342.29763-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20210527042342.29763-1-sathishkumar.sundararaju@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-31T07:05:47.024Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00b782d2-2d00-4eb5-68d9-08d924028455
x-ms-traffictypediagnostic: CO6PR12MB5442:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB5442DA2F99C7CEC0BB6679EBA23F9@CO6PR12MB5442.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6eQMODF7Ri+0K+F1gQ29noKjtjH92POFEv+3IOoZq/84zFpJdWXDxABOTrVDAGqeIajFrO1fhY8lbFyoZIc36Nr34hd4metaeXYRDpCO4g/wVE2LA3GtdkRBT3jyb6j8hCKvhGn9shQKv5Nf2IueSBw4MYjGbdhtWtUuM9tqyZSuhHjAPTR8q8mOXt9hM31BPyo4o+kPcOA4VshQleAeKpg+LQpRE78FVtVoqiMeu+OVkmuEF4NFGHmnY4SKNkAKcqgEj9Q4vMX3hp1m8ReJCxI9TRIrFlRcJKQ3jZ7z1x0UCTIS88zXWLUrrmqwoV5Q6Hv8KzYor/uK+M+9fXAag6NVm4RxytBl2av0AkhCgkROzGbwDLb4konGYXHSd/wOFle9IMJL3mRQIT6XwHCJbx1NPWiav2AoRsqAjPNHJEljBUIn21ow8JctNKtDsEhF/Pn1O6T2O9sfvZa8qyL9i33xQhZ9yVEtQyxgFcloWE526PpUdiPKVnDE2pNaJiFtcT7MfOJuJzjffu1u95qbK2rewcWl9teqoMzQm38w0hmVrMqIiQmeRI4tki1cPp4mszOksjxuBf6kEYe+oPMAbF3/qcx16dE5QQoV6NKPshitDV4q9M8NwMBsc7OlQjyP0duRqoXv4nledgT9arl3Bg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(83380400001)(86362001)(19627405001)(53546011)(7696005)(110136005)(66556008)(316002)(66476007)(8936002)(6506007)(166002)(33656002)(76116006)(66446008)(64756008)(66946007)(54906003)(91956017)(478600001)(26005)(71200400001)(8676002)(45080400002)(2906002)(5660300002)(966005)(186003)(122000001)(4326008)(38100700002)(9686003)(52536014)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?/6M+pBRPr7qTYBIvuSJK+UgX6nQxXVNNaB5+9q9QdI15FEn9weCMYE+I3v?=
 =?iso-8859-1?Q?PzP2+ZfNmk26hiIcOoo/UWuBuGE1NottiWBjhrTvaPXVymU44gPpH7WcFy?=
 =?iso-8859-1?Q?YMyT08m4BM2toPI7ZHBAYKhLNKqGeLfY0mt2Rre5iAch+REvaXNm8H3iRf?=
 =?iso-8859-1?Q?Bmv3Ga9tRuk+CTZysVOACJVnmkjI73TBd0ZSLzYmhktHJC7ReX9cOF/OJW?=
 =?iso-8859-1?Q?BAjmaaUflNlq3xQ8EfrLB6yfSsiyhjfJ4Zo2NdMyHvH/VIxsxCMWYfghsG?=
 =?iso-8859-1?Q?F6HMn1QhKHjs8rO5xtsj0I+kYEpvGTShbSTUEdRbn7+Ucaq3TApjEhQ+rp?=
 =?iso-8859-1?Q?uzKa2laxlmV1d8iUwAU/lZQJL74Yr8O7/AS+B7WZJygYansCK3u5oPrPkQ?=
 =?iso-8859-1?Q?8gsHQtx2L7t6zFUUz7URWb1nUtgfEliwdfH4pXZCyajqef/uC3xoZfdyhQ?=
 =?iso-8859-1?Q?3NEVhkw+GbVa3WLOFJQNW8C4Ce98xHaVmYb9WcNLuaRHhOBx8O7AaiICRB?=
 =?iso-8859-1?Q?Zy2k/4iuNq4WiQO7KocdmTDOkFzMFT9usPaUfVOqmnaWhO2BEh31y+zyUe?=
 =?iso-8859-1?Q?hZbzfaNC+O36AynEYSTXsI41AHtG2cUlYtC889Or12ve8n5DvQvIYErjm9?=
 =?iso-8859-1?Q?/jL8bXlddVzrcloyNSdzwe/ctI7xEDd+swrfcqRC/yIqp5LjxlEvCvWYU2?=
 =?iso-8859-1?Q?oUXseYHVA7hTltwasjQLjFktb7Mu6G8iFeUAzsWZDI25tewbRDm4wRpRki?=
 =?iso-8859-1?Q?IKByjrd1D/VuOwGgbszD55vH31Z/GtbFoeBCz6JDZzLEXNadUoS47p8Zh3?=
 =?iso-8859-1?Q?Pq5UhvVTz3RLmJ7uIImiD5KJ3aax8rFjZCJ3lMpJaXTZnoAv8OZ6TrxyUX?=
 =?iso-8859-1?Q?2BGSbl6Dj2+VtgUmgjXNsdqURfltsG4MOJFKcdiL2wj205VTGSaHLVYUtQ?=
 =?iso-8859-1?Q?FODrmtdPQA0KqT/qLQn8nbm94WGWzzdzQJagSd2IeY927vlwg07v9hgwvT?=
 =?iso-8859-1?Q?dmsVZwDGHIRTZrJXYUFNSLfIsFcFz/+KbrG7JFeboSgODpvP5g47cPU4gB?=
 =?iso-8859-1?Q?/PFxfIQMkm20w1qp0ghIky5O6C6vAX9sjuHGKZX6qS6/4IrdaMNrdNGx9s?=
 =?iso-8859-1?Q?czwifup2vPdBCkXAtrOAP3PzOOATZ9p27qYEnKnVQ8YawLfzR0H6eZHYI4?=
 =?iso-8859-1?Q?qNf7hgqrUVuTlWHj2UbB0Blz8qgWPEjc3+m53cqLr4mxNjvZa9uxYl74ek?=
 =?iso-8859-1?Q?/n56EEfLLJDudkckVv9gPa0t6kBrMSFIMhcvjCLwC+LfXtCdr7og6aMHIj?=
 =?iso-8859-1?Q?zqQYQOBDkNyQWjIUuZUcOlNztFGzBg3R9cZPX6G2pTJWdnDeYE6toGP0u7?=
 =?iso-8859-1?Q?0crxVBilg8?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b782d2-2d00-4eb5-68d9-08d924028455
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 07:05:47.6767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQ8v+R6NrtQq1Pz0MB1rnjwjyvw0+ZywuL6V5vdPoa9PJyH4LS+khc0s+R3r6uci
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5442
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Content-Type: multipart/mixed; boundary="===============1292355503=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1292355503==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CO6PR12MB54735FBE5D74F5D38BC76C64A23F9CO6PR12MB5473namp_"

--_000_CO6PR12MB54735FBE5D74F5D38BC76C64A23F9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Sathishk=
umar S <sathishkumar.sundararaju@amd.com>
Sent: Thursday, May 27, 2021 12:23 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Sundararaju, Sathishkum=
ar <Sathishkumar.Sundararaju@amd.com>; Sharma, Shashank <Shashank.Sharma@am=
d.com>
Subject: [PATCH] drm/amd/pm: use attr_update if the attr has it

use attr_update if its available as part of the attribute.
default_attr_update was used even if attr->attr_update is true.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Shashank Sharma <Shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 13da377888d2..f48132bc089d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1942,7 +1942,7 @@ static int amdgpu_device_attr_create(struct amdgpu_de=
vice *adev,

         BUG_ON(!attr);

-       attr_update =3D attr->attr_update ? attr_update : default_attr_upda=
te;
+       attr_update =3D attr->attr_update ? attr->attr_update : default_att=
r_update;

         ret =3D attr_update(adev, attr, mask, &attr_states);
         if (ret) {
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7Cdc81930600ef4ac8e5fe08d921aee79c%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637577857383123909%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D7Y=
tvWuhj7sqCF%2BvKF8FG%2BcT8zFCZoNHU%2Bo1eiATTZQA%3D&amp;reserved=3D0

--_000_CO6PR12MB54735FBE5D74F5D38BC76C64A23F9CO6PR12MB5473namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
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
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Sathishkumar S &lt;sathishkum=
ar.sundararaju@amd.com&gt;<br>
<b>Sent:</b> Thursday, May 27, 2021 12:23 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Sundararaj=
u, Sathishkumar &lt;Sathishkumar.Sundararaju@amd.com&gt;; Sharma, Shashank =
&lt;Shashank.Sharma@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: use attr_update if the attr has it</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">use attr_update if its available as part of the at=
tribute.<br>
default_attr_update was used even if attr-&gt;attr_update is true.<br>
<br>
Signed-off-by: Sathishkumar S &lt;sathishkumar.sundararaju@amd.com&gt;<br>
Reviewed-by: Shashank Sharma &lt;Shashank.sharma@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 13da377888d2..f48132bc089d 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -1942,7 +1942,7 @@ static int amdgpu_device_attr_create(struct amdgpu_de=
vice *adev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(!attr);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_update =3D attr-&gt;attr_update =
? attr_update : default_attr_update;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_update =3D attr-&gt;attr_update =
? attr-&gt;attr_update : default_attr_update;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D attr_update(adev, =
attr, mask, &amp;attr_states);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7Cdc81930600ef4ac8e5fe08d921aee79c%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637577857383123909%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3D7YtvWuhj7sqCF%2BvKF8FG%2BcT8zFCZoNHU%2Bo1eiATTZQA%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7CKevin1.Wang%40amd.com%7Cdc81930600ef4ac8e5fe08d921aee79c%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637577857383123909%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D7YtvWuhj7sqCF%2BvKF8FG%2BcT8zFCZoNHU%2Bo1eiATTZQA%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB54735FBE5D74F5D38BC76C64A23F9CO6PR12MB5473namp_--

--===============1292355503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1292355503==--
