Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3DFC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 10:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D3C613CA
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 10:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D3C613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2186E08E;
	Wed, 28 Apr 2021 10:38:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB86C6E08E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 10:38:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7UVDSmbN+Zu+E4/mG9YLS5cZTR4oQ8tarMSNC1EOjNBnz0mzsFHUhAh7zk2OYj+IrKhnIy3ly4MQlWAZs1m3FYwcsLivGQ7q2zgWb7E8OcnK7lVKL9JlPO1++a2rsqCyWwngjUFCdvGYQ9cchtC/r4Qy6Y1YwHTjjDUFrbb9JD4tHo/qoKV48BkBNz4YOjBxujNwDGuS9gLc7endH2i38x6z0MsqDC3GLukOHZV5X9ZWOETCrw4o+q6wsdUkt3xDmQVaV9yj0ol2+9g5BARsUT1ULW1FagqOQTgdDn6XMtEkaaUGH+TscAebd9uByjzQQwMjJwxg21kh/0dbYWlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKxHPjQlks05bjclCc8lKAG5IVafltd1Qa6B+Hmkgsc=;
 b=VXfBKQ8OlY6QW5BGN+gn10o4/djpw98xfbN9QECdsdNO+uM+hdumcm99BbzUXmgw1Vvk7hHa1PyMeYWWEG+R80fLBW6oazrBqdYmccDV04/7Pe62JgFbQmBZcQ/ewnl7eFf3aWM/o2hHBiXCiVv8Wh3Hql7mfLv95R9fSiNVsNGN5YM2WjwYLtTi9dOclHX9nso73/q/ynl+1cnLoSyui8DAMJOVUICyh7wjM3RsVlIgus8HvegKQ951VNt/bUf9+UQ2YtARERuAMNrdj6WxKAk38ypxnM7gzS4Gr2aUcUX88gzVoSaMuNj1gFOAphxu0vGpDG2+wr/W134v0i/0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKxHPjQlks05bjclCc8lKAG5IVafltd1Qa6B+Hmkgsc=;
 b=YgziflI3gmpRYp/GTo8W9W6i9f2FFpNSk7NrR3QgY9qsCC3ZuX66GeE/oUDfmAYlX5okMnpeT/M2qsIqJWfuTDJAsJ0rOBenIjieW7rFaXXPTkIsCwVXjUVgBzshNhZom/Ktw81oVgoHEYTBFA5JGStpsb4kbmYvCQddQEag5mU=
Received: from DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20)
 by DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Wed, 28 Apr
 2021 10:38:25 +0000
Received: from DM6PR12MB4170.namprd12.prod.outlook.com
 ([fe80::34da:800b:41ca:19ba]) by DM6PR12MB4170.namprd12.prod.outlook.com
 ([fe80::34da:800b:41ca:19ba%9]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 10:38:25 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Nieto, David M" <David.Nieto@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "StDenis, Tom" <Tom.StDenis@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Thread-Topic: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Thread-Index: AQHXNyAZxU02AtWA5k2SdU2Ic9ArhqrAgz4AgAACZoCAAAKEgIAA50OAgAehugCAAH0wgP//jWwAgAB6H4CAAAo+sIAAJJbQ
Date: Wed, 28 Apr 2021 10:38:25 +0000
Message-ID: <DM6PR12MB4170C06A2E0C61C148F0D82BF8409@DM6PR12MB4170.namprd12.prod.outlook.com>
References: <20210422023448.24689-1-Jiawei.Gu@amd.com>
 <BE86C24E-8E22-47C8-B737-E7F58F8B9326@amd.com>
 <F593F9B0-C6CB-4245-BC82-0B63F65DF33F@amd.com>
 <84a7de3b-b6a1-2acf-247a-0c93e84db09b@gmail.com>
 <DM6PR12MB4170A07B0FADBEF73D359B6CF8459@DM6PR12MB4170.namprd12.prod.outlook.com>
 <0C1CB3BD-37DD-4F05-9E6E-2DED8A6CD44B@amd.com>
 <27103289-b51a-8e4b-ad09-0169829efeb0@gmail.com>
 <E87E8A3B-7BDE-4286-A71D-3E242D30A1C7@amd.com>
 <15f3858a-fe68-9e21-37f0-2984c465051d@gmail.com>
 <DM6PR12MB4170A81523B8050F3BCCCDF8F8409@DM6PR12MB4170.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4170A81523B8050F3BCCCDF8F8409@DM6PR12MB4170.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Tom.StDenis@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-28T10:38:09Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=50d418cd-3a62-45d6-b076-c471ae9ad658;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e14ce591-87b7-4040-d32f-08d90a31c0f5
x-ms-traffictypediagnostic: DM6PR12MB5021:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB5021C0AF24D8C8E0E071D96AF8409@DM6PR12MB5021.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9e6nVcPi4pTDPTTvhfyF4KpKy2/u/cGKLPzupJoMW5wxBq2DAtw2YuihE1WB6OL294dxd4JvMZVwpoMpG3AQTBNoX4R1lSyEvvJsSHk13G+1hM4wz+IF6mDugYSAbPpvKnBMFz3HPUQS+ZtZwZ5bAM/VkPS9y/Itm7SjWt9LgDcO+UsqOjSR9rsAnJ4ekMQ/0KeUVDGu4up9n+xkwX9UuCE6jUv2Z0kly9j06T3KlAE8v80pnU54tNbQeHy9c6KlUDxLP8ASd6LK0tQBxM/C1fFp2yrXSBVVBCqsj/ucDxdlJRqfP8iRvzHpqiqEKnB5DPnIvajLSybHSfA7V30PliMkSrK96RmwKY4/kqp/lMe9wO6nPnelP+Yp26Vr3siJ1RVPkFom7PJxph2v0KfqXyQk8Q0iQM0AI9s/KpCzAFc25KJSf2efRZ84/qzhzKomsa6VDNKnQ0lyH2C/H9pWt6eOqgbGNSuo7mPwyFDS2AP8hUWjdUey5b0WoEQlNxs9HyoAcrU6B4p2Dd+lAajqdW0TXfF2xc6BQGomcnjnIkFpRQ79ZeuvXsaiYYSCyUolNwEvpKsUTt8Nqp39ZBVt+Dk0VaESq/s7QV1rr2aR9XkDjg2zzCjcho1eWu/twDFZ0a4r+ueqT2ZHh2hhHftbbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(66946007)(83380400001)(71200400001)(166002)(76116006)(86362001)(38100700002)(66574015)(186003)(8936002)(52536014)(66556008)(64756008)(9686003)(122000001)(66476007)(55016002)(30864003)(8676002)(26005)(5660300002)(6636002)(4326008)(2940100002)(66446008)(110136005)(316002)(966005)(478600001)(6506007)(7696005)(33656002)(2906002)(53546011)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?A+P6EOxz03dPRfQ9uyDGI5zKklMQ8OxDWE3XnH1MaFXGDbbMBMb0EuyHyu?=
 =?iso-8859-1?Q?W5Blb5ooybTN0dGchHCgPFYoZE3LFTL2EsAS10PjQm2GoneRuJ8i+iarxm?=
 =?iso-8859-1?Q?lVPsS7zEHc8fzvNwtspQnmdAMzo+QOBa0VgzhoC59bT+ZwhXc4EBciuY56?=
 =?iso-8859-1?Q?AWy3rYJemIkZrobTS8rpS2hPGhFJkNepvjWgJplUWhUJEal7bQMk7xuaNL?=
 =?iso-8859-1?Q?oUKH5oI3SsF8VS5nOvUp+0zyPBKGVLwhozKngTnHBjKHusSt/zs/58QeFv?=
 =?iso-8859-1?Q?/Whq7Kv/d9P3IARMvWadL3/kea6/bi++e2AAPu82cJox18xzmeB1VF6dth?=
 =?iso-8859-1?Q?zeomcFP6JkgLwTI8mf5z8Ny2n3H+Y2q2/vf7KuSbvOdZhSdQH/g3noJ1QV?=
 =?iso-8859-1?Q?M9AXJQAT3eKSyeqX5VvJzqRaZgLWjzbH3iRasa/tST967wLFIB5IgYvLYP?=
 =?iso-8859-1?Q?YhK6c4cvKObkzokSWVPbYxngMBfyxaVbVRn2nt3uqyIa2cWyFYOiQMoUAQ?=
 =?iso-8859-1?Q?xq8iJ3ulr4epBKlKh3lywLyCsrQHO0WsBTqfIPBVjUJSvNWS3FEEk9G193?=
 =?iso-8859-1?Q?Udaa469kCkML6MqWGre9/w966f9RCZQUfzVWhjXvqEVqMON2s7W1VN0yeI?=
 =?iso-8859-1?Q?/54jA6obJ0y2tZLQFy9AQFkeGsuV0Tc24NUmjYJjr+SjlVQc/ooSxFoxj0?=
 =?iso-8859-1?Q?ffmCrtXgClm03l4RYYUdLKQ0noMg3HC7zuPvF+FmRLGGSJ7MWDHL4rKDGK?=
 =?iso-8859-1?Q?GSUlURJ06tWuD3GW+bSUbq9EpQa4P8Gc4Vj5sBfOiaHiFlyFPcpaF+SXyn?=
 =?iso-8859-1?Q?qaiS/DLWG2v0HFiW4fqxCRnyoE6j+ETvmZN77grF4N8rJKjiRCNdEdWfbw?=
 =?iso-8859-1?Q?pPXHiG0N+xToxlTOcWt2xFku9Nll0kJ404kCTP+ysTZZx6FIud4yQt8GUe?=
 =?iso-8859-1?Q?z1OKsiGnF9AtJT+TQVuTpwQ1W7lve6lPZlkp3Soq7ZDsv/wwl2+LO6PMgU?=
 =?iso-8859-1?Q?GJ8QTDKhHxdZX+6iQ6MF2E4pCDXYewrO159Bf0FFgJlZ58NovxQLO6HIDa?=
 =?iso-8859-1?Q?J4ZLZ8WzmSEUZcPB7sB6f2wsXxpIn86q7DkYZw/3SOqOD4ADrdeslaEP54?=
 =?iso-8859-1?Q?MVI/zpPHH/zOtioScCFSgVEz+runaaJAA4WDrUrnOttUI03PpA6w9xLhLD?=
 =?iso-8859-1?Q?Q0eryk5dDStU5XKZgVHhpME1VroazzfWGdNrTxzuiCnKq9mlPBwO4WHNlC?=
 =?iso-8859-1?Q?OlH+H/kpPzJ2OauRRMwB9MXTVBp5sRqD8JVwZc5ntHj+IYkxTS9RnhiIF1?=
 =?iso-8859-1?Q?YvrIoEegNJfEPfcSNJhU9QkJHtMHP09Q1xgGSFbgRbFsY8Z0ky+KPJtKRn?=
 =?iso-8859-1?Q?FOuwbvw/8p?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14ce591-87b7-4040-d32f-08d90a31c0f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 10:38:25.4775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /evGfmtmkbjgEIBGA1H/0xfSNfNPEIW17mqbVNTcCOCjvFEakYix+MX4XTDX6oKRvd7fyz0J/1/uEimr45oZ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5021
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="===============2088095799=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2088095799==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4170C06A2E0C61C148F0D82BF8409DM6PR12MB4170namp_"

--_000_DM6PR12MB4170C06A2E0C61C148F0D82BF8409DM6PR12MB4170namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi @StDenis, Tom<mailto:Tom.StDenis@amd.com>,

We have merged vbios info ioctl patch.
Could you help re-merge the UMR side one again if it was reverted before?

Thanks in advance!
Jiawei

From: Gu, JiaWei (Will)
Sent: Wednesday, April 28, 2021 4:21 PM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; Nieto, David M <D=
avid.Nieto@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; StDenis, Tom <Tom.StDen=
is@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add vbios info ioctl interface


[AMD Official Use Only - Internal Distribution Only]

Thanks Christian,

I amended the commit message and resend the patch out.
Please feel free to let me know if message is not clear enough.

Best regards,
Jiawei

From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.le=
ichtzumerken@gmail.com>>
Sent: Wednesday, April 28, 2021 3:43 PM
To: Nieto, David M <David.Nieto@amd.com<mailto:David.Nieto@amd.com>>; Gu, J=
iaWei (Will) <JiaWei.Gu@amd.com<mailto:JiaWei.Gu@amd.com>>; amd-gfx@lists.f=
reedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; StDenis, Tom <Tom.StDenis@amd.com<mailto:Tom.StDenis@amd.com>>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface

Yeah, makes sense. Please note that in the commit message.

With that feel free to put an Acked-by: Christian K=F6nig <christian.koenig=
@amd.com><mailto:christian.koenig@amd.com> on it.

Regards,
Christian.
Am 28.04.21 um 09:25 schrieb Nieto, David M:
I think this change may be orthogonal to that. Here we want to provide a wa=
y for the user application to get the VBIOS information without having to p=
arse the binary...

And I agree that we should not have strong dependencies unless the encounte=
r buggy VBIOS on the field, but I still think it is useful for the user to =
be able to display in a simple way the VBIOS version in their system if the=
y happen to encounter an issue.

Regards,
David

From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.l=
eichtzumerken@gmail.com>
Date: Wednesday, April 28, 2021 at 12:15 AM
To: "Nieto, David M" <David.Nieto@amd.com><mailto:David.Nieto@amd.com>, "Gu=
, JiaWei (Will)" <JiaWei.Gu@amd.com><mailto:JiaWei.Gu@amd.com>, "amd-gfx@li=
sts.freedesktop.org"<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.f=
reedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com><mailto:Alexander.Deuch=
er@amd.com>, "StDenis, Tom" <Tom.StDenis@amd.com><mailto:Tom.StDenis@amd.co=
m>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface

Well displaying the VBIOS information along with the other firmware in user=
space is certainly useful.

We should just avoid making strong dependencies on that.

Firmware and VBIOS must always be backward compatible and the driver must a=
lways work with any released firmware and VBIOS combination.

What we can do is to display a warning when we detect and/or old/buggy firm=
ware.

Regards,
Christian.
Am 28.04.21 um 08:47 schrieb Nieto, David M:
Besides system management, it provides parseable details on the VBIOS versi=
on and information. This is useful renderer information as the GPU behavior=
 depends not only on the driver version but also on the firmwares running o=
n the GPU.

The AMDGPU_INFO ioctl contains a method to get the versions of the ucode fo=
r all the IPs, but for VBIOS, only a way to dump the entire image is provid=
ed. While it Is possible to implement the whole logic of VBIOS parsing on u=
serspace, it requires the application to have details on the header and tab=
le formats to parse the data. Moreover there is no guarantee that the forma=
t and header locations will remain constant across ASIC generations, so the=
 maintainance cost and complexity seems unreasonable.

Providing a simple, and stable interface to the application seems to us lik=
e a sensible choice.

Thanks,
David

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of "Gu, JiaWei (Will)" <JiaWei.Gu@amd.co=
m><mailto:JiaWei.Gu@amd.com>
Date: Thursday, April 22, 2021 at 8:25 PM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.lei=
chtzumerken@gmail.com>, "amd-gfx@lists.freedesktop.org"<mailto:amd-gfx@list=
s.freedesktop.org> <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.fre=
edesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com><mailto:Alexander.Deuch=
er@amd.com>, "StDenis, Tom" <Tom.StDenis@amd.com><mailto:Tom.StDenis@amd.co=
m>, "Nieto, David M" <David.Nieto@amd.com><mailto:David.Nieto@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add vbios info ioctl interface


[AMD Official Use Only - Internal Distribution Only]

Hi Christian,
It will be used by a user space SMI-lib for GPU status query.

Hi David, please feel free to correct my statement since I'm not sure I hav=
e a view of whole picture.

Thanks,
Jiawei

From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.l=
eichtzumerken@gmail.com>
Sent: Thursday, April 22, 2021 9:27 PM
To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com><mailto:JiaWei.Gu@amd.com>; amd-gf=
x@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com><mailto:Alexander.Deucher=
@amd.com>; StDenis, Tom <Tom.StDenis@amd.com><mailto:Tom.StDenis@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface

Is that useful to Vulkan/OpenGL/other clients in any way?

Christian.
Am 22.04.21 um 15:18 schrieb Gu, JiaWei (Will):



CC Tom.



On Apr 22, 2021, at 21:09, Gu, JiaWei (Will) <JiaWei.Gu@amd.com><mailto:Jia=
Wei.Gu@amd.com> wrote:



<[v2][umr]add-vbios-info-query.patch>

UMR patch which calls this new IOCTL attached.



Best regards,

Jiawei



On Apr 22, 2021, at 10:34, Jiawei Gu <JiaWei.Gu@amd.com><mailto:JiaWei.Gu@a=
md.com> wrote:



Add AMDGPU_INFO_VBIOS_INFO subquery id for detailed vbios info.



Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com><mailto:Jiawei.Gu@amd.com>

---

drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  19 +++

drivers/gpu/drm/amd/amdgpu/atom.c          | 158 +++++++++++++++++++++

drivers/gpu/drm/amd/amdgpu/atom.h          |  11 ++

drivers/gpu/drm/amd/include/atomfirmware.h |  16 ++-

include/uapi/drm/amdgpu_drm.h              |  15 ++

5 files changed, 213 insertions(+), 6 deletions(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c

index 39ee88d29cca..a20b016b05ab 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c

@@ -861,6 +861,25 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *da=
ta, struct drm_file *filp)

                                       min((size_t)size, (size_t)(bios_size=
 - bios_offset)))

                                   ? -EFAULT : 0;

             }

+            case AMDGPU_INFO_VBIOS_INFO: {

+                   struct drm_amdgpu_info_vbios vbios_info =3D {};

+                   struct atom_context *atom_context;

+

+                   atom_context =3D adev->mode_info.atom_context;

+                 memcpy(vbios_info.name, atom_context->name, sizeof(atom_c=
ontext->name));

+                 vbios_info.dbdf =3D PCI_DEVID(adev->pdev->bus->number, ad=
ev->pdev->devfn);

+                 memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeo=
f(atom_context->vbios_pn));

+                 vbios_info.version =3D atom_context->version;

+                 memcpy(vbios_info.date, atom_context->date, sizeof(atom_c=
ontext->date));

+                 memcpy(vbios_info.serial, adev->serial, sizeof(adev->seri=
al));

+                 vbios_info.dev_id =3D adev->pdev->device;

+                 vbios_info.rev_id =3D adev->pdev->revision;

+                 vbios_info.sub_dev_id =3D atom_context->sub_dev_id;

+                 vbios_info.sub_ved_id =3D atom_context->sub_ved_id;

+

+                   return copy_to_user(out, &vbios_info,

+                                  min((size_t)size, sizeof(vbios_info))) ?=
 -EFAULT : 0;

+            }

             default:

                  DRM_DEBUG_KMS("Invalid request %d\n",

                            info->vbios_info.type);

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu=
/atom.c

index 3dcb8b32f48b..0e2f0ea13b40 100644

--- a/drivers/gpu/drm/amd/amdgpu/atom.c

+++ b/drivers/gpu/drm/amd/amdgpu/atom.c

@@ -31,6 +31,7 @@



#define ATOM_DEBUG



+#include "atomfirmware.h"

#include "atom.h"

#include "atom-names.h"

#include "atom-bits.h"

@@ -1299,12 +1300,153 @@ static void atom_index_iio(struct atom_context *ct=
x, int base)

     }

}



+static void atom_get_vbios_name(struct atom_context *ctx)

+{

+    unsigned char *p_rom;

+    unsigned char str_num;

+    unsigned short off_to_vbios_str;

+    unsigned char *c_ptr;

+    int name_size;

+    int i;

+

+    const char *na =3D "--N/A--";

+    char *back;

+

+    p_rom =3D ctx->bios;

+

+    str_num =3D *(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS);

+    if (str_num !=3D 0) {

+            off_to_vbios_str =3D

+                   *(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_STRI=
NG_START);

+

+            c_ptr =3D (unsigned char *)(p_rom + off_to_vbios_str);

+    } else {

+            /* do not know where to find name */

+            memcpy(ctx->name, na, 7);

+            ctx->name[7] =3D 0;

+            return;

+    }

+

+    /*

+     * skip the atombios strings, usually 4

+     * 1st is P/N, 2nd is ASIC, 3rd is PCI type, 4th is Memory type

+     */

+    for (i =3D 0; i < str_num; i++) {

+            while (*c_ptr !=3D 0)

+                   c_ptr++;

+            c_ptr++;

+    }

+

+    /* skip the following 2 chars: 0x0D 0x0A */

+    c_ptr +=3D 2;

+

+    name_size =3D strnlen(c_ptr, STRLEN_LONG - 1);

+    memcpy(ctx->name, c_ptr, name_size);

+    back =3D ctx->name + name_size;

+    while ((*--back) =3D=3D ' ')

+            ;

+    *(back + 1) =3D '\0';

+}

+

+static void atom_get_vbios_date(struct atom_context *ctx)

+{

+    unsigned char *p_rom;

+    unsigned char *date_in_rom;

+

+    p_rom =3D ctx->bios;

+

+    date_in_rom =3D p_rom + OFFSET_TO_VBIOS_DATE;

+

+    ctx->date[0] =3D '2';

+    ctx->date[1] =3D '0';

+    ctx->date[2] =3D date_in_rom[6];

+    ctx->date[3] =3D date_in_rom[7];

+    ctx->date[4] =3D '/';

+    ctx->date[5] =3D date_in_rom[0];

+    ctx->date[6] =3D date_in_rom[1];

+    ctx->date[7] =3D '/';

+    ctx->date[8] =3D date_in_rom[3];

+    ctx->date[9] =3D date_in_rom[4];

+    ctx->date[10] =3D ' ';

+    ctx->date[11] =3D date_in_rom[9];

+    ctx->date[12] =3D date_in_rom[10];

+    ctx->date[13] =3D date_in_rom[11];

+    ctx->date[14] =3D date_in_rom[12];

+    ctx->date[15] =3D date_in_rom[13];

+    ctx->date[16] =3D '\0';

+}

+

+static unsigned char *atom_find_str_in_rom(struct atom_context *ctx, char =
*str, int start,

+                                     int end, int maxlen)

+{

+    unsigned long str_off;

+    unsigned char *p_rom;

+    unsigned short str_len;

+

+    str_off =3D 0;

+    str_len =3D strnlen(str, maxlen);

+    p_rom =3D ctx->bios;

+

+    for (; start <=3D end; ++start) {

+            for (str_off =3D 0; str_off < str_len; ++str_off) {

+                   if (str[str_off] !=3D *(p_rom + start + str_off))

+                        break;

+            }

+

+            if (str_off =3D=3D str_len || str[str_off] =3D=3D 0)

+                   return p_rom + start;

+    }

+    return NULL;

+}

+

+static void atom_get_vbios_pn(struct atom_context *ctx)

+{

+    unsigned char *p_rom;

+    unsigned short off_to_vbios_str;

+    unsigned char *vbios_str;

+    int count;

+

+    off_to_vbios_str =3D 0;

+    p_rom =3D ctx->bios;

+

+    if (*(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS) !=3D 0) {

+            off_to_vbios_str =3D

+                   *(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_STRI=
NG_START);

+

+            vbios_str =3D (unsigned char *)(p_rom + off_to_vbios_str);

+    } else {

+            vbios_str =3D p_rom + OFFSET_TO_VBIOS_PART_NUMBER;

+    }

+

+    if (*vbios_str =3D=3D 0) {

+            vbios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1=
024, 64);

+            if (vbios_str =3D=3D NULL)

+                   vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;

+    }

+    if (vbios_str !=3D NULL && *vbios_str =3D=3D 0)

+            vbios_str++;

+

+    if (vbios_str !=3D NULL) {

+            count =3D 0;

+            while ((count < BIOS_STRING_LENGTH) && vbios_str[count] >=3D '=
 ' &&

+                   vbios_str[count] <=3D 'z') {

+                 ctx->vbios_pn[count] =3D vbios_str[count];

+                   count++;

+            }

+

+            ctx->vbios_pn[count] =3D 0;

+    }

+}

+

struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)

{

     int base;

     struct atom_context *ctx =3D

         kzalloc(sizeof(struct atom_context), GFP_KERNEL);

     char *str;

+    struct _ATOM_ROM_HEADER *atom_rom_header;

+    struct _ATOM_MASTER_DATA_TABLE *master_table;

+    struct _ATOM_FIRMWARE_INFO *atom_fw_info;

     u16 idx;



     if (!ctx)

@@ -1353,6 +1495,22 @@ struct atom_context *amdgpu_atom_parse(struct card_i=
nfo *card, void *bios)

          strlcpy(ctx->vbios_version, str, sizeof(ctx->vbios_version));

     }



+    atom_rom_header =3D (struct _ATOM_ROM_HEADER *)CSTR(base);

+    ctx->sub_dev_id =3D atom_rom_header->usSubsystemVendorID;

+    ctx->sub_ved_id =3D atom_rom_header->usSubsystemID;

+    if (atom_rom_header->usMasterDataTableOffset !=3D 0) {

+            master_table =3D (struct _ATOM_MASTER_DATA_TABLE *)

+                    CSTR(atom_rom_header->usMasterDataTableOffset);

+            if (master_table->ListOfDataTables.FirmwareInfo !=3D 0) {

+                   atom_fw_info =3D (struct _ATOM_FIRMWARE_INFO *)

+                           CSTR(master_table->ListOfDataTables.FirmwareInf=
o);

+                   ctx->version =3D atom_fw_info->ulFirmwareRevision;

+            }

+    }

+

+    atom_get_vbios_name(ctx);

+    atom_get_vbios_pn(ctx);

+    atom_get_vbios_date(ctx);



     return ctx;

}

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu=
/atom.h

index d279759cab47..c729f7ceba4f 100644

--- a/drivers/gpu/drm/amd/amdgpu/atom.h

+++ b/drivers/gpu/drm/amd/amdgpu/atom.h

@@ -112,6 +112,10 @@ struct drm_device;

#define ATOM_IO_SYSIO              2

#define ATOM_IO_IIO         0x80



+#define STRLEN_NORMAL             32

+#define STRLEN_LONG        64

+#define STRLEN_VERYLONG           254

+

struct card_info {

     struct drm_device *dev;

     void (* reg_write)(struct card_info *, uint32_t, uint32_t);   /*  fill=
ed by driver */

@@ -140,6 +144,13 @@ struct atom_context {

     uint32_t *scratch;

     int scratch_size_bytes;

     char vbios_version[20];

+

+    uint8_t name[STRLEN_LONG];

+    uint8_t vbios_pn[STRLEN_LONG];

+    uint32_t version;

+    uint8_t date[STRLEN_NORMAL];

+    uint32_t sub_dev_id;

+    uint32_t sub_ved_id;

};



extern int amdgpu_atom_debug;

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/a=
md/include/atomfirmware.h

index c77ed38c20fb..3a8e404099b0 100644

--- a/drivers/gpu/drm/amd/include/atomfirmware.h

+++ b/drivers/gpu/drm/amd/include/atomfirmware.h

@@ -197,6 +197,8 @@ enum atom_dp_vs_preemph_def{

 DP_VS_LEVEL0_PREEMPH_LEVEL3 =3D 0x18,

};



+#define BIOS_ATOM_PREFIX   "ATOMBIOS"

+#define BIOS_STRING_LENGTH 43



/*

enum atom_string_def{

@@ -209,12 +211,14 @@ atom_bios_string          =3D "ATOM"

#pragma pack(1)                          /* BIOS data must use byte aligmen=
t*/



enum atombios_image_offset{

-OFFSET_TO_ATOM_ROM_HEADER_POINTER          =3D0x00000048,

-OFFSET_TO_ATOM_ROM_IMAGE_SIZE              =3D0x00000002,

-OFFSET_TO_ATOMBIOS_ASIC_BUS_MEM_TYPE       =3D0x94,

-MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      =3D20,  /*including the termina=
tor 0x0!*/

-OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   =3D0x2f,

-OFFSET_TO_GET_ATOMBIOS_STRING_START        =3D0x6e,

+  OFFSET_TO_ATOM_ROM_HEADER_POINTER          =3D 0x00000048,

+  OFFSET_TO_ATOM_ROM_IMAGE_SIZE              =3D 0x00000002,

+  OFFSET_TO_ATOMBIOS_ASIC_BUS_MEM_TYPE       =3D 0x94,

+  MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      =3D 20,  /*including the term=
inator 0x0!*/

+  OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   =3D 0x2f,

+  OFFSET_TO_GET_ATOMBIOS_STRING_START        =3D 0x6e,

+  OFFSET_TO_VBIOS_PART_NUMBER                =3D 0x80,

+  OFFSET_TO_VBIOS_DATE                       =3D 0x50,

};



/**************************************************************************=
**

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h

index 8b832f7458f2..77980445d486 100644

--- a/include/uapi/drm/amdgpu_drm.h

+++ b/include/uapi/drm/amdgpu_drm.h

@@ -758,6 +758,8 @@ struct drm_amdgpu_cs_chunk_data {

     #define AMDGPU_INFO_VBIOS_SIZE             0x1

     /* Subquery id: Query vbios image */

     #define AMDGPU_INFO_VBIOS_IMAGE            0x2

+    /* Subquery id: Query vbios info */

+    #define AMDGPU_INFO_VBIOS_INFO             0x3

/* Query UVD handles */

#define AMDGPU_INFO_NUM_HANDLES                    0x1C

/* Query sensor related information */

@@ -951,6 +953,19 @@ struct drm_amdgpu_info_firmware {

     __u32 feature;

};



+struct drm_amdgpu_info_vbios {

+    __u8 name[64];

+    __u32 dbdf;

+    __u8 vbios_pn[64];

+    __u32 version;

+    __u8 date[32];

+    __u8 serial[16];

+    __u32 dev_id;

+    __u32 rev_id;

+    __u32 sub_dev_id;

+    __u32 sub_ved_id;

+};

+

#define AMDGPU_VRAM_TYPE_UNKNOWN 0

#define AMDGPU_VRAM_TYPE_GDDR1 1

#define AMDGPU_VRAM_TYPE_DDR2  2

--

2.17.1








_______________________________________________

amd-gfx mailing list

amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>

https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7CJiaWei.Gu%40amd.com%7Cfc8d3420d8=
8745c257bf08d90a1934d6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6375519=
25654186287%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ=
BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DY9%2B4WCgVSr0pS%2Bdf5PzTCddGhjit=
FaCsNhp%2Fu%2F%2FnmII%3D&reserved=3D0>




--_000_DM6PR12MB4170C06A2E0C61C148F0D82BF8409DM6PR12MB4170namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}
p.msipheader4d111418, li.msipheader4d111418, div.msipheader4d111418
	{mso-style-name:msipheader4d111418;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheader4d111418" style=3D"margin:0in"><span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - I=
nternal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi <a id=3D"OWAAM3D99380755554AA3900D2E689B75A4E7" h=
ref=3D"mailto:Tom.StDenis@amd.com">
<span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decoration:n=
one">@StDenis, Tom</span></a>,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We have merged vbios info ioctl patch.<o:p></o:p></p=
>
<p class=3D"MsoNormal">Could you help re-merge the UMR side one again if it=
 was reverted before?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks in advance!<o:p></o:p></p>
<p class=3D"MsoNormal">Jiawei<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Gu, JiaWei (Will) <br>
<b>Sent:</b> Wednesday, April 28, 2021 4:21 PM<br>
<b>To:</b> Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;; Niet=
o, David M &lt;David.Nieto@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; StDenis, T=
om &lt;Tom.StDenis@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Add vbios info ioctl interface<o:p>=
</o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d111418" style=3D"margin:0in"><span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - I=
nternal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks Christian,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I amended the commit message and resend the patch ou=
t.<o:p></o:p></p>
<p class=3D"MsoNormal">Please feel free to let me know if message is not cl=
ear enough.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Jiawei<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Christian K=F6nig &lt;<a href=3D"mailto=
:ckoenig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;
<br>
<b>Sent:</b> Wednesday, April 28, 2021 3:43 PM<br>
<b>To:</b> Nieto, David M &lt;<a href=3D"mailto:David.Nieto@amd.com">David.=
Nieto@amd.com</a>&gt;; Gu, JiaWei (Will) &lt;<a href=3D"mailto:JiaWei.Gu@am=
d.com">JiaWei.Gu@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; StDenis, Tom &lt;<a href=3D"mailto:T=
om.StDenis@amd.com">Tom.StDenis@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface<o:p>=
</o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Yeah, makes sense. Pl=
ease note that in the commit message.<br>
<br>
With that feel free to put an Acked-by: Christian K=F6nig <a href=3D"mailto=
:christian.koenig@amd.com">
&lt;christian.koenig@amd.com&gt;</a> on it.<br>
<br>
Regards,<br>
Christian.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 28.04.21 um 09:25 schrieb Nieto, David M:<o:p></o=
:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">I think this change may be orthogonal to that. Here =
we want to provide a way for the user application to get the VBIOS informat=
ion without having to parse the binary&#8230;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">And I agree that we should not have strong dependenc=
ies unless the encounter buggy VBIOS on the field, but I still think it is =
useful for the user to be able to display in a simple way the VBIOS version=
 in their system if they happen to
 encounter an issue.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">David<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:12.0pt;color:black">From=
: </span></b><span style=3D"font-size:12.0pt;color:black">Christian K=F6nig
<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumer=
ken@gmail.com&gt;</a><br>
<b>Date: </b>Wednesday, April 28, 2021 at 12:15 AM<br>
<b>To: </b>&quot;Nieto, David M&quot; <a href=3D"mailto:David.Nieto@amd.com=
">&lt;David.Nieto@amd.com&gt;</a>, &quot;Gu, JiaWei (Will)&quot;
<a href=3D"mailto:JiaWei.Gu@amd.com">&lt;JiaWei.Gu@amd.com&gt;</a>, <a href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
&quot;amd-gfx@lists.freedesktop.org&quot;</a> <a href=3D"mailto:amd-gfx@lis=
ts.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Cc: </b>&quot;Deucher, Alexander&quot; <a href=3D"mailto:Alexander.Deuch=
er@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>, &quot;StDenis, Tom&quot;
<a href=3D"mailto:Tom.StDenis@amd.com">&lt;Tom.StDenis@amd.com&gt;</a><br>
<b>Subject: </b>Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface</spa=
n><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Well displaying the V=
BIOS information along with the other firmware in userspace is certainly us=
eful.<br>
<br>
We should just avoid making strong dependencies on that.<br>
<br>
Firmware and VBIOS must always be backward compatible and the driver must a=
lways work with any released firmware and VBIOS combination.<br>
<br>
What we can do is to display a warning when we detect and/or old/buggy firm=
ware.<br>
<br>
Regards,<br>
Christian.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 28.04.21 um 08:47 schrieb Nieto, David M:<o:p></o=
:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">Besides system management, it provides parseable det=
ails on the VBIOS version and information. This is useful renderer informat=
ion as the GPU behavior depends not only on the driver version but also on =
the firmwares running on the GPU.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">The AMDGPU_INFO ioctl contains a method to get the v=
ersions of the ucode for all the IPs, but for VBIOS, only a way to dump the=
 entire image is provided. While it Is possible to implement the whole logi=
c of VBIOS parsing on userspace, it
 requires the application to have details on the header and table formats t=
o parse the data. Moreover there is no guarantee that the format and header=
 locations will remain constant across ASIC generations, so the maintainanc=
e cost and complexity seems unreasonable.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Providing a simple, and stable interface to the appl=
ication seems to us like a sensible choice.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">David<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:12.0pt;color:black">From=
: </span></b><span style=3D"font-size:12.0pt;color:black">amd-gfx
<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounce=
s@lists.freedesktop.org&gt;</a> on behalf of &quot;Gu, JiaWei (Will)&quot;
<a href=3D"mailto:JiaWei.Gu@amd.com">&lt;JiaWei.Gu@amd.com&gt;</a><br>
<b>Date: </b>Thursday, April 22, 2021 at 8:25 PM<br>
<b>To: </b>Christian K=F6nig <a href=3D"mailto:ckoenig.leichtzumerken@gmail=
.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>,
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">&quot;amd-gfx@lists.freede=
sktop.org&quot;</a>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesk=
top.org&gt;</a><br>
<b>Cc: </b>&quot;Deucher, Alexander&quot; <a href=3D"mailto:Alexander.Deuch=
er@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>, &quot;StDenis, Tom&quot;
<a href=3D"mailto:Tom.StDenis@amd.com">&lt;Tom.StDenis@amd.com&gt;</a>, &qu=
ot;Nieto, David M&quot; <a href=3D"mailto:David.Nieto@amd.com">
&lt;David.Nieto@amd.com&gt;</a><br>
<b>Subject: </b>RE: [PATCH] drm/amdgpu: Add vbios info ioctl interface</spa=
n><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<p class=3D"msipheader4d111418" style=3D"margin:0in"><span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - I=
nternal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Hi Christian,<o:p></o:p></p>
<p class=3D"MsoNormal">It will be used by a user space SMI-lib for GPU stat=
us query.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Hi David, please feel free to correct my statement s=
ince I&#8217;m not sure I have a view of whole picture.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Jiawei<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Christian K=F6nig <a href=3D"mailto:cko=
enig.leichtzumerken@gmail.com">
&lt;ckoenig.leichtzumerken@gmail.com&gt;</a> <br>
<b>Sent:</b> Thursday, April 22, 2021 9:27 PM<br>
<b>To:</b> Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.Gu@amd.com">&lt;JiaWe=
i.Gu@amd.com&gt;</a>;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Deucher, Alexander <a href=3D"mailto:Alexander.Deucher@amd.com">=
&lt;Alexander.Deucher@amd.com&gt;</a>; StDenis, Tom
<a href=3D"mailto:Tom.StDenis@amd.com">&lt;Tom.StDenis@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface<o:p>=
</o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Is that useful to Vul=
kan/OpenGL/other clients in any way?<br>
<br>
Christian.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 22.04.21 um 15:18 schrieb Gu, JiaWei (Will):<o:p>=
</o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>&nbsp;<o:p></o:p></pre>
<pre>CC Tom.<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>On Apr 22, 2021, at 21:09, Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.=
Gu@amd.com">&lt;JiaWei.Gu@amd.com&gt;</a> wrote:<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>&lt;[v2][umr]add-vbios-info-query.patch&gt;<o:p></o:p></pre>
<pre>UMR patch which calls this new IOCTL attached.<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>Best regards,<o:p></o:p></pre>
<pre>Jiawei<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>On Apr 22, 2021, at 10:34, Jiawei Gu <a href=3D"mailto:JiaWei.Gu@amd.c=
om">&lt;JiaWei.Gu@amd.com&gt;</a> wrote:<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>Add AMDGPU_INFO_VBIOS_INFO subquery id for detailed vbios info.<o:p></=
o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>Signed-off-by: Jiawei Gu <a href=3D"mailto:Jiawei.Gu@amd.com">&lt;Jiaw=
ei.Gu@amd.com&gt;</a><o:p></o:p></pre>
<pre>---<o:p></o:p></pre>
<pre>drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c&nbsp;&nbsp;&nbsp; |&nbsp; 19 +=
++<o:p></o:p></pre>
<pre>drivers/gpu/drm/amd/amdgpu/atom.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; | 158 +++++++++++++++++++++<o:p></o:p></pre>
<pre>drivers/gpu/drm/amd/amdgpu/atom.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 11 ++<o:p></o:p></pre>
<pre>drivers/gpu/drm/amd/include/atomfirmware.h |&nbsp; 16 ++-<o:p></o:p></=
pre>
<pre>include/uapi/drm/amdgpu_drm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 15 ++<o:p></o:p></pre>
<pre>5 files changed, 213 insertions(+), 6 deletions(-)<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_kms.c<o:p></o:p></pre>
<pre>index 39ee88d29cca..a20b016b05ab 100644<o:p></o:p></pre>
<pre>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<o:p></o:p></pre>
<pre>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<o:p></o:p></pre>
<pre>@@ -861,6 +861,25 @@ int amdgpu_info_ioctl(struct drm_device *dev, voi=
d *data, struct drm_file *filp)<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; min((size_t)size, (size_t)(bios_size - bios_offset)))<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ? -EFAULT : 0;<=
o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; }<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ca=
se AMDGPU_INFO_VBIOS_INFO: {<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_amdgpu_info_vbios vbios_=
info =3D {};<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_context *atom_context;<=
o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atom_context =3D adev-&gt;mode_info=
.atom_context;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_info.name, atom_context-&gt;name, sizeo=
f(atom_context-&gt;name));<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp;&nbsp; vbios_info.dbdf =3D PCI_DEVID(adev-&gt;pdev-&gt;bus-=
&gt;number, adev-&gt;pdev-&gt;devfn);<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_info.vbios_pn, atom_context-&gt;vbios_p=
n, sizeof(atom_context-&gt;vbios_pn));<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp;&nbsp; vbios_info.version =3D atom_context-&gt;version;<o:p=
></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_info.date, atom_context-&gt;date, sizeo=
f(atom_context-&gt;date));<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_info.serial, adev-&gt;serial, sizeof(ad=
ev-&gt;serial));<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp;&nbsp; vbios_info.dev_id =3D adev-&gt;pdev-&gt;device;<o:p>=
</o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp;&nbsp; vbios_info.rev_id =3D adev-&gt;pdev-&gt;revision;<o:=
p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp;&nbsp; vbios_info.sub_dev_id =3D atom_context-&gt;sub_dev_i=
d;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp;&nbsp; vbios_info.sub_ved_id =3D atom_context-&gt;sub_ved_i=
d;<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return copy_to_user(out, &amp;vbios=
_info,<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min((size_t)size, si=
zeof(vbios_info))) ? -EFAULT : 0;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; default:<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_KMS(&quot;Invalid request %d\n&quot;,=
<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; info-&gt;vbios_info.type);<o:p></o:p></pre>
<pre>diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/a=
mdgpu/atom.c<o:p></o:p></pre>
<pre>index 3dcb8b32f48b..0e2f0ea13b40 100644<o:p></o:p></pre>
<pre>--- a/drivers/gpu/drm/amd/amdgpu/atom.c<o:p></o:p></pre>
<pre>+++ b/drivers/gpu/drm/amd/amdgpu/atom.c<o:p></o:p></pre>
<pre>@@ -31,6 +31,7 @@<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>#define ATOM_DEBUG<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>+#include &quot;atomfirmware.h&quot;<o:p></o:p></pre>
<pre>#include &quot;atom.h&quot;<o:p></o:p></pre>
<pre>#include &quot;atom-names.h&quot;<o:p></o:p></pre>
<pre>#include &quot;atom-bits.h&quot;<o:p></o:p></pre>
<pre>@@ -1299,12 +1300,153 @@ static void atom_index_iio(struct atom_contex=
t *ctx, int base)<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
<pre>}<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>+static void atom_get_vbios_name(struct atom_context *ctx)<o:p></o:p><=
/pre>
<pre>+{<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; unsigned char *p_rom;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; unsigned char str_num;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; unsigned short off_to_vbios_str;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; unsigned char *c_ptr;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; int name_size;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; int i;<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; const char *na =3D &quot;--N/A--&quot;;<o:p></o:p>=
</pre>
<pre>+&nbsp;&nbsp;&nbsp; char *back;<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; p_rom =3D ctx-&gt;bios;<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; str_num =3D *(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBE=
R_OF_STRINGS);<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; if (str_num !=3D 0) {<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; of=
f_to_vbios_str =3D<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(unsigned short *)(p_rom + OFFSET_=
TO_GET_ATOMBIOS_STRING_START);<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c_=
ptr =3D (unsigned char *)(p_rom + off_to_vbios_str);<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 do not know where to find name */<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me=
mcpy(ctx-&gt;name, na, 7);<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ct=
x-&gt;name[7] =3D 0;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; /*<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp; * skip the atombios strings, usually 4<o:p><=
/o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp; * 1st is P/N, 2nd is ASIC, 3rd is PCI type, =
4th is Memory type<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; str_num; i++) {<o:p></o:p></p=
re>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wh=
ile (*c_ptr !=3D 0)<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c_ptr++;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c_=
ptr++;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; /* skip the following 2 chars: 0x0D 0x0A */<o:p></=
o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; c_ptr +=3D 2;<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; name_size =3D strnlen(c_ptr, STRLEN_LONG - 1);<o:p=
></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; memcpy(ctx-&gt;name, c_ptr, name_size);<o:p></o:p>=
</pre>
<pre>+&nbsp;&nbsp;&nbsp; back =3D ctx-&gt;name + name_size;<o:p></o:p></pre=
>
<pre>+&nbsp;&nbsp;&nbsp; while ((*--back) =3D=3D ' ')<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;<=
o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; *(back + 1) =3D '\0';<o:p></o:p></pre>
<pre>+}<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+static void atom_get_vbios_date(struct atom_context *ctx)<o:p></o:p><=
/pre>
<pre>+{<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; unsigned char *p_rom;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; unsigned char *date_in_rom;<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; p_rom =3D ctx-&gt;bios;<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; date_in_rom =3D p_rom + OFFSET_TO_VBIOS_DATE;<o:p>=
</o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;date[0] =3D '2';<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;date[1] =3D '0';<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;date[2] =3D date_in_rom[6];<o:p></o:p></pr=
e>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;date[3] =3D date_in_rom[7];<o:p></o:p></pr=
e>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;date[4] =3D '/';<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;date[5] =3D date_in_rom[0];<o:p></o:p></pr=
e>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;date[6] =3D date_in_rom[1];<o:p></o:p></pr=
e>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;date[7] =3D '/';<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;date[8] =3D date_in_rom[3];<o:p></o:p></pr=
e>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;date[9] =3D date_in_rom[4];<o:p></o:p></pr=
e>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;date[10] =3D ' ';<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;date[11] =3D date_in_rom[9];<o:p></o:p></p=
re>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;date[12] =3D date_in_rom[10];<o:p></o:p></=
pre>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;date[13] =3D date_in_rom[11];<o:p></o:p></=
pre>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;date[14] =3D date_in_rom[12];<o:p></o:p></=
pre>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;date[15] =3D date_in_rom[13];<o:p></o:p></=
pre>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;date[16] =3D '\0';<o:p></o:p></pre>
<pre>+}<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+static unsigned char *atom_find_str_in_rom(struct atom_context *ctx, =
char *str, int start,<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; int end=
, int maxlen)<o:p></o:p></pre>
<pre>+{<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; unsigned long str_off;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; unsigned char *p_rom;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; unsigned short str_len;<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; str_off =3D 0;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; str_len =3D strnlen(str, maxlen);<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; p_rom =3D ctx-&gt;bios;<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; for (; start &lt;=3D end; ++start) {<o:p></o:p></p=
re>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fo=
r (str_off =3D 0; str_off &lt; str_len; ++str_off) {<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (str[str_off] !=3D *(p_rom + sta=
rt + str_off))<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; break;<o:p=
></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (str_off =3D=3D str_len || str[str_off] =3D=3D 0)<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return p_rom + start;<o:p></o:p></p=
re>
<pre>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; return NULL;<o:p></o:p></pre>
<pre>+}<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+static void atom_get_vbios_pn(struct atom_context *ctx)<o:p></o:p></p=
re>
<pre>+{<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; unsigned char *p_rom;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; unsigned short off_to_vbios_str;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; unsigned char *vbios_str;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; int count;<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; off_to_vbios_str =3D 0;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; p_rom =3D ctx-&gt;bios;<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; if (*(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STR=
INGS) !=3D 0) {<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; of=
f_to_vbios_str =3D<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(unsigned short *)(p_rom + OFFSET_=
TO_GET_ATOMBIOS_STRING_START);<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vb=
ios_str =3D (unsigned char *)(p_rom + off_to_vbios_str);<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vb=
ios_str =3D p_rom + OFFSET_TO_VBIOS_PART_NUMBER;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; if (*vbios_str =3D=3D 0) {<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vb=
ios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 64);<o:p><=
/o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (vbios_str =3D=3D NULL)<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_str +=3D sizeof(BIOS_ATOM_PRE=
FIX) - 1;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; if (vbios_str !=3D NULL &amp;&amp; *vbios_str =3D=
=3D 0)<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vb=
ios_str++;<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; if (vbios_str !=3D NULL) {<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; co=
unt =3D 0;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wh=
ile ((count &lt; BIOS_STRING_LENGTH) &amp;&amp; vbios_str[count] &gt;=3D ' =
' &amp;&amp;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_str[count] &lt;=3D 'z') {<o:p></o:=
p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp;&nbsp; ctx-&gt;vbios_pn[count] =3D vbios_str[count];<o:p></=
o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count++;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ct=
x-&gt;vbios_pn[count] =3D 0;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
<pre>+}<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>struct atom_context *amdgpu_atom_parse(struct card_info *card, void *b=
ios)<o:p></o:p></pre>
<pre>{<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; int base;<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; struct atom_context *ctx =3D<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; kzalloc(sizeof(struct atom=
_context), GFP_KERNEL);<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; char *str;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; struct _ATOM_ROM_HEADER *atom_rom_header;<o:p></o:=
p></pre>
<pre>+&nbsp;&nbsp;&nbsp; struct _ATOM_MASTER_DATA_TABLE *master_table;<o:p>=
</o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; struct _ATOM_FIRMWARE_INFO *atom_fw_info;<o:p></o:=
p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; u16 idx;<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; if (!ctx)<o:p></o:p></pre>
<pre>@@ -1353,6 +1495,22 @@ struct atom_context *amdgpu_atom_parse(struct c=
ard_info *card, void *bios)<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; strlcpy(ctx-&gt;vbio=
s_version, str, sizeof(ctx-&gt;vbios_version));<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; atom_rom_header =3D (struct _ATOM_ROM_HEADER *)CST=
R(base);<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;sub_dev_id =3D atom_rom_header-&gt;usSubsy=
stemVendorID;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; ctx-&gt;sub_ved_id =3D atom_rom_header-&gt;usSubsy=
stemID;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; if (atom_rom_header-&gt;usMasterDataTableOffset !=
=3D 0) {<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ma=
ster_table =3D (struct _ATOM_MASTER_DATA_TABLE *)<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CSTR(atom_rom_header-&gt;usMa=
sterDataTableOffset);<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (master_table-&gt;ListOfDataTables.FirmwareInfo !=3D 0) {<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atom_fw_info =3D (struct _ATOM_FIRM=
WARE_INFO *)<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; CSTR(master_table-&gt;ListOfDataTables.FirmwareInfo);<o:p></o:=
p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;version =3D atom_fw_info-&g=
t;ulFirmwareRevision;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; atom_get_vbios_name(ctx);<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; atom_get_vbios_pn(ctx);<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; atom_get_vbios_date(ctx);<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; return ctx;<o:p></o:p></pre>
<pre>}<o:p></o:p></pre>
<pre>diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/a=
mdgpu/atom.h<o:p></o:p></pre>
<pre>index d279759cab47..c729f7ceba4f 100644<o:p></o:p></pre>
<pre>--- a/drivers/gpu/drm/amd/amdgpu/atom.h<o:p></o:p></pre>
<pre>+++ b/drivers/gpu/drm/amd/amdgpu/atom.h<o:p></o:p></pre>
<pre>@@ -112,6 +112,10 @@ struct drm_device;<o:p></o:p></pre>
<pre>#define ATOM_IO_SYSIO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<o:p></o:p></pre>
<pre>#define ATOM_IO_IIO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x=
80<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>+#define STRLEN_NORMAL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 32<o:p></o:p></pre>
<pre>+#define STRLEN_LONG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 64<o:p>=
</o:p></pre>
<pre>+#define STRLEN_VERYLONG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 254<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>struct card_info {<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev;<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; void (* reg_write)(struct card_info *, uint32=
_t, uint32_t);&nbsp;&nbsp; /*&nbsp; filled by driver */<o:p></o:p></pre>
<pre>@@ -140,6 +144,13 @@ struct atom_context {<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *scratch;<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; int scratch_size_bytes;<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; char vbios_version[20];<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; uint8_t name[STRLEN_LONG];<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; uint8_t vbios_pn[STRLEN_LONG];<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; uint32_t version;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; uint8_t date[STRLEN_NORMAL];<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; uint32_t sub_dev_id;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; uint32_t sub_ved_id;<o:p></o:p></pre>
<pre>};<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>extern int amdgpu_atom_debug;<o:p></o:p></pre>
<pre>diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/=
drm/amd/include/atomfirmware.h<o:p></o:p></pre>
<pre>index c77ed38c20fb..3a8e404099b0 100644<o:p></o:p></pre>
<pre>--- a/drivers/gpu/drm/amd/include/atomfirmware.h<o:p></o:p></pre>
<pre>+++ b/drivers/gpu/drm/amd/include/atomfirmware.h<o:p></o:p></pre>
<pre>@@ -197,6 +197,8 @@ enum atom_dp_vs_preemph_def{<o:p></o:p></pre>
<pre> DP_VS_LEVEL0_PREEMPH_LEVEL3 =3D 0x18,<o:p></o:p></pre>
<pre>};<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>+#define BIOS_ATOM_PREFIX&nbsp;&nbsp; &quot;ATOMBIOS&quot;<o:p></o:p><=
/pre>
<pre>+#define BIOS_STRING_LENGTH 43<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>/*<o:p></o:p></pre>
<pre>enum atom_string_def{<o:p></o:p></pre>
<pre>@@ -209,12 +211,14 @@ atom_bios_string&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =3D &quot;ATOM&quot;<o:p></o:p></pre>
<pre>#pragma pack(1)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;/* BIOS data must use byte aligment*/<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>enum atombios_image_offset{<o:p></o:p></pre>
<pre>-OFFSET_TO_ATOM_ROM_HEADER_POINTER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =3D0x00000048,<o:p></o:p></pre>
<pre>-OFFSET_TO_ATOM_ROM_IMAGE_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D0x00000002,<o:p></o:p></pre>
<pre>-OFFSET_TO_ATOMBIOS_ASIC_BUS_MEM_TYPE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D0x94,<o:p></o:p></pre>
<pre>-MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D20,&nbsp; /*including the terminator 0x0!*/<o:p></o:p></pre>
<pre>-OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS&nbsp;&nbsp; =3D0x2f,<o:p></o=
:p></pre>
<pre>-OFFSET_TO_GET_ATOMBIOS_STRING_START&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D0x6e,<o:p></o:p></pre>
<pre>+&nbsp; OFFSET_TO_ATOM_ROM_HEADER_POINTER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x00000048,<o:p></o:p></pre>
<pre>+&nbsp; OFFSET_TO_ATOM_ROM_IMAGE_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x00000002,<o:p></o:p></p=
re>
<pre>+&nbsp; OFFSET_TO_ATOMBIOS_ASIC_BUS_MEM_TYPE&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =3D 0x94,<o:p></o:p></pre>
<pre>+&nbsp; MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =3D 20,&nbsp; /*including the terminator 0x0!*/<o:p></o:p></pre>
<pre>+&nbsp; OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS&nbsp;&nbsp; =3D 0x2f,=
<o:p></o:p></pre>
<pre>+&nbsp; OFFSET_TO_GET_ATOMBIOS_STRING_START&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; =3D 0x6e,<o:p></o:p></pre>
<pre>+&nbsp; OFFSET_TO_VBIOS_PART_NUMBER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x80,<o:p></o:p=
></pre>
<pre>+&nbsp; OFFSET_TO_VBIOS_DATE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; =3D 0x50,<o:p></o:p></pre>
<pre>};<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>/*********************************************************************=
*******&nbsp;&nbsp; <o:p></o:p></pre>
<pre>diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_d=
rm.h<o:p></o:p></pre>
<pre>index 8b832f7458f2..77980445d486 100644<o:p></o:p></pre>
<pre>--- a/include/uapi/drm/amdgpu_drm.h<o:p></o:p></pre>
<pre>+++ b/include/uapi/drm/amdgpu_drm.h<o:p></o:p></pre>
<pre>@@ -758,6 +758,8 @@ struct drm_amdgpu_cs_chunk_data {<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; #define AMDGPU_INFO_VBIOS_SIZE&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1<o:p></o:p></p=
re>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; /* Subquery id: Query vbios image */<o:p></o:=
p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; #define AMDGPU_INFO_VBIOS_IMAGE&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; /* Subquery id: Query vbios info */<o:p></o:p></pr=
e>
<pre>+&nbsp;&nbsp;&nbsp; #define AMDGPU_INFO_VBIOS_INFO&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3<o:p></o:p></pre>
<pre>/* Query UVD handles */<o:p></o:p></pre>
<pre>#define AMDGPU_INFO_NUM_HANDLES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x1C<o:p></o:p></pre>
<pre>/* Query sensor related information */<o:p></o:p></pre>
<pre>@@ -951,6 +953,19 @@ struct drm_amdgpu_info_firmware {<o:p></o:p></pre=
>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; __u32 feature;<o:p></o:p></pre>
<pre>};<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>+struct drm_amdgpu_info_vbios {<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; __u8 name[64];<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; __u32 dbdf;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; __u8 vbios_pn[64];<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; __u32 version;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; __u8 date[32];<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; __u8 serial[16];<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; __u32 dev_id;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; __u32 rev_id;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; __u32 sub_dev_id;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp; __u32 sub_ved_id;<o:p></o:p></pre>
<pre>+};<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>#define AMDGPU_VRAM_TYPE_UNKNOWN 0<o:p></o:p></pre>
<pre>#define AMDGPU_VRAM_TYPE_GDDR1 1<o:p></o:p></pre>
<pre>#define AMDGPU_VRAM_TYPE_DDR2&nbsp; 2<o:p></o:p></pre>
<pre>-- <o:p></o:p></pre>
<pre>2.17.1<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
</blockquote>
<pre>&nbsp;<o:p></o:p></pre>
</blockquote>
<pre>&nbsp;<o:p></o:p></pre>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">&nbsp;<o:p></o:p></p>
<pre>_______________________________________________<o:p></o:p></pre>
<pre>amd-gfx mailing list<o:p></o:p></pre>
<pre><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedes=
ktop.org</a><o:p></o:p></pre>
<pre><a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04=
%7C01%7CJiaWei.Gu%40amd.com%7Cfc8d3420d88745c257bf08d90a1934d6%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637551925654186287%7CUnknown%7CTWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&=
amp;sdata=3DY9%2B4WCgVSr0pS%2Bdf5PzTCddGhjitFaCsNhp%2Fu%2F%2FnmII%3D&amp;re=
served=3D0">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p>=
</o:p></pre>
</blockquote>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><o:p>&nbsp;</o:p></p>
</blockquote>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4170C06A2E0C61C148F0D82BF8409DM6PR12MB4170namp_--

--===============2088095799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2088095799==--
