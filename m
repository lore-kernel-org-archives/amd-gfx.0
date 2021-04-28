Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0192C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 11:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8089561422
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 11:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8089561422
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C715B6E092;
	Wed, 28 Apr 2021 11:30:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D6186E0CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 11:30:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tfy44Yqim9bqrUhBX+SpVo0/jDJPKE2+jSkAaHQ3bbD9UWP83mg0O+9QBChJSoULGmHAAS5XSqVyLKCUvzDuE2Kx/QYi2JRm9fgZlRNU4PMVnvfIBPfnXSs+5m7F7sAfhgczSr2d9doQs8J2aOiOH3xQxrY4j4xWiGqIfKo9iKu9FVJr0Aj1sVJ8H3CwzEhXUklqElSnGIxr0mlceqmXZO5uup7r8WvaTcTYRoIwpXOwycMFMzl+uXtubobx7oCu9JekAr6GqVW9qfC3Md5BHrLPOzgTXehQOq0qbLgmgwuHj/6hbRk4n3OzPeObn1F9we4jxvA69P7nNiMQcRtADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3iCgnBw/EcQKhy1r/MgZJxXOoFU4o/3M5flpD39qA4=;
 b=PIIwg5XxGonqSPgfnuT+tes2ZlB50azQMoQq5kzc+mOc8xYI6DucDs10iIUFxe0hsJmnhBXmSL9sDQoMnZMgBEuTUDgx4sv061rsM8o3b59PsIKubqPyh0NiTtQg2xySMsOVglWcJWcq+XYzAfySteTo+astq3LM+5G1vFty7m+C4WT4CQ39hRNeFaUmLB/uepQUu6il2Qr34pMY+CiTuBQePUVQvqYoudraCFegfn6Y6H717V2/D6t7HBxsZXHArvUG+4YBmXOSQHf+cCEjgTkhxEh1PzlXeyVjDI+n5xpnJLOacux1mRrvXCN0chWOrX312ztly8iluH84j9pSCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3iCgnBw/EcQKhy1r/MgZJxXOoFU4o/3M5flpD39qA4=;
 b=LMHSUm2HN6/qBxx5VLAekuCcRc6e4hQvfERnT7EmDf3/OQ6IZk0J825bgcFz/fIb/5ZfEiEaEoj+OuCXKiMTCtirN2TYTJlfhbSLgblUIU8Vc0OmXPoFhDDoV0wCunyGmALsZwgqeYusqWzQDC7IYU+V0BsqbOX+Lb4fIfDheCI=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB3052.namprd12.prod.outlook.com (2603:10b6:5:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Wed, 28 Apr
 2021 11:30:00 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::6c1d:e14b:dc15:7e56]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::6c1d:e14b:dc15:7e56%2]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 11:30:00 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>,
 =?Windows-1252?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Nieto, David M" <David.Nieto@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Thread-Topic: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Thread-Index: AQHXNyAZxU02AtWA5k2SdU2Ic9ArhqrAgz4AgAACZoCAAAKEgIAA50OAgAehugCAAH0wgP//jWwAgAB6H4CAAAo+sIAAJJbQgAAQmTg=
Date: Wed, 28 Apr 2021 11:30:00 +0000
Message-ID: <DM6PR12MB35470C81D095A1CC4D1E859AF7409@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20210422023448.24689-1-Jiawei.Gu@amd.com>
 <BE86C24E-8E22-47C8-B737-E7F58F8B9326@amd.com>
 <F593F9B0-C6CB-4245-BC82-0B63F65DF33F@amd.com>
 <84a7de3b-b6a1-2acf-247a-0c93e84db09b@gmail.com>
 <DM6PR12MB4170A07B0FADBEF73D359B6CF8459@DM6PR12MB4170.namprd12.prod.outlook.com>
 <0C1CB3BD-37DD-4F05-9E6E-2DED8A6CD44B@amd.com>
 <27103289-b51a-8e4b-ad09-0169829efeb0@gmail.com>
 <E87E8A3B-7BDE-4286-A71D-3E242D30A1C7@amd.com>
 <15f3858a-fe68-9e21-37f0-2984c465051d@gmail.com>
 <DM6PR12MB4170A81523B8050F3BCCCDF8F8409@DM6PR12MB4170.namprd12.prod.outlook.com>,
 <DM6PR12MB4170C06A2E0C61C148F0D82BF8409@DM6PR12MB4170.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4170C06A2E0C61C148F0D82BF8409@DM6PR12MB4170.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-28T11:29:59.612Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:f2c0:e4c0:b2::8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4297381-f7ad-4971-6897-08d90a38f585
x-ms-traffictypediagnostic: DM6PR12MB3052:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3052CAD371E619604355D867F7409@DM6PR12MB3052.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YX0splLmlO6jGT0x1nIr8xxkWp822RTK65q0Imj3gNCn7woTHvm3AQKGYtsm42qSBELsL6dUlbzxKJHh0gsVrfEJA00HtuMHHI6dJPphbmyKwzGZiCk+Zlk8bH7i1nsyr1zyeFm/UfQJs6dSQ66LY348mmiL0evDEw7Ese5J8S8oTgzeoaHXB8mQ/kE9+TaRZudsgZEimEFl0T87ZNaouYKS/st/dnrICr0SHW3M9BpUsSij6fG/DLkldmPfj+L3kEYxcpFtmiG4xtQ/BtMSrJ7QV7DJJulgWRnXa9baCsz5rdrlUYFgGgOddgEHYEUcpghivjy1G2Sg5KplD13W1e8ikVaLaDdwyHXkn+FBIEoniWF3ABUE2mK3QrM/NtQawmk5dkH3iPE0NNzfcRWpAmlG6TrbVB08GBr/8t6f7KrX7NaT6AKB7oqZojB4Mmt+dE0YAjfTDE7CGbC3KJNpysGC7BlKmiCd2tV8RpCYaJsonnflUPWPy9Y3vZ763hUWxQ+r8XhvMjmwBR66N30QplKzT59CQeFJub5teI0ylFNylSEdpc39RFwnFE32j3jAaQgOQntFs0XVA1MZ0pXq/aMWvAcIqtwPYwmIgtaiIgVARlbSTAntLF+1LgtVVljYjg0Fn3N41zx6t64f+6/PkQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(4326008)(38100700002)(86362001)(30864003)(478600001)(55016002)(5660300002)(110136005)(71200400001)(122000001)(76116006)(7696005)(9686003)(8936002)(52536014)(966005)(316002)(53546011)(6506007)(2906002)(66946007)(186003)(83380400001)(66446008)(64756008)(33656002)(8676002)(66574015)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?8gho7MWtez+jsl13Dm4HTvVLfbvCa/epU/fIcI+uH9YSkdvP65P8aMVd?=
 =?Windows-1252?Q?Cmt/+VKUihyygYzRRbaYPD7x93WPrdOqDRZhF1D+WN5K7yy+uGdVXant?=
 =?Windows-1252?Q?DspYgF6oP2e4p4E3fCrhrgicIYoaipW/+DyFAUOIndxCOhpatUOEOItz?=
 =?Windows-1252?Q?zMszErAIHJ386MwWmCojPoTtDhk/vPpUIifeXy6waV+6wknf69e78v0E?=
 =?Windows-1252?Q?WEdcajk1TioNnVO1XuLJCFa/cP633E67FrU6A7gpmLa7XT2vjkdGFfhe?=
 =?Windows-1252?Q?I4hqw63gm9o6hp3vRkKZnm2edM5vgPjoK6fOg8Gsq93r0+FlX8AiAVjs?=
 =?Windows-1252?Q?mpW9qJClZ7OTxxi58/ec5rp4f8HeU2H1q2/nSAmndUbIqwLHanwFk1jP?=
 =?Windows-1252?Q?P5HLeIfDPFqeCXqbwFUvO4cjCWWQk1yjJ58WCdtmYMmozHXPHVnQW4l+?=
 =?Windows-1252?Q?8neLTQm/VbMpjkzbewDI/zq2clMu/9yzf2FXojv1NytdMm2LS4dpRUlw?=
 =?Windows-1252?Q?jGaJds69mBmHddj+WidEiaOoPzkVQNJS/ehm9nfB3GeHu/1D6k6/60uF?=
 =?Windows-1252?Q?C+tds066dddmLbtKDNylNh+QNCY3JRU81GoxdjQLeGBHrEU/rMfhynOq?=
 =?Windows-1252?Q?CodXblp3SLz6BMqmzW7NSXg3rUQJrUh31QLcFa49qEXD5jDTXjfmObok?=
 =?Windows-1252?Q?C14enJ6ZF5yJoQP0fKkLT7zkjsIgjK8isHRmEq0QIqrV6yy3RHpEcGHC?=
 =?Windows-1252?Q?lKQy2qwB0TQCx/WY599wPx3yLICeCx0GN+IW6/+7TbDsCCZS003d32NQ?=
 =?Windows-1252?Q?aV4sqWCOe9khwgMP9/KvAuQc1lqtGXS2hNFmJFyPBAc3z9v9F81TFEOP?=
 =?Windows-1252?Q?us8EiY124W6DLCOjZmSN+DFVLIE8DtGR5FTe5f3dy+tbEGNBgNngq3nX?=
 =?Windows-1252?Q?yewqP5tdUVcqe17F0CSEgBhF9z7ftCxr8YklvmuJY3dYSTKSDmTMi5/W?=
 =?Windows-1252?Q?oMpjhcT2tD1CTkomI2xAz9MLwqcLupgOvEBz06YuIjGafVsYFAztaNKa?=
 =?Windows-1252?Q?Q0pwl8+h3ifi8sKOGAYCjh8GDbCehAojH7VzRiyISme3kg6YSpnT3cWJ?=
 =?Windows-1252?Q?U2gVbwkItT0J7SCc6GsroGZBESRbUn63hlK5vDTO1Bo11uzlkhW/X46B?=
 =?Windows-1252?Q?jyVzUFHOfyWN/RDjhwkY1t4X5IdOo3BjejQO/FaTJcIro+o7H1in/6rq?=
 =?Windows-1252?Q?DzaO76Zee2KG1ihnIhJOpt0f7KVQdytF2zIHsn4QzOKw8Ml0iePGhbTF?=
 =?Windows-1252?Q?2q/NlL/fML47obojV8vv+lNVKRZUIdw07DWxYJmNkVuRAnpPY6B5f0fC?=
 =?Windows-1252?Q?SuRDq8Ieh8AZiSBynMt+3R23hSddYnBcgmTyFvTI90Fg08EIUDhBTQfD?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4297381-f7ad-4971-6897-08d90a38f585
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 11:30:00.1334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9UQzV1ZUxECVzJgm1YCE15xiNBQ7PtKvpvNz/vpWbligtYlwpfCAgKBujxksQZXxeXprtKAkC/tInmXdJB2Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3052
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Will,

I've merged in your v2 patch last week.  If that's still the latest you sho=
uld be good to go.

Tom

________________________________________
From: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Sent: Wednesday, April 28, 2021 06:38
To: Christian K=F6nig; Nieto, David M; amd-gfx@lists.freedesktop.org; StDen=
is, Tom
Cc: Deucher, Alexander
Subject: RE: [PATCH] drm/amdgpu: Add vbios info ioctl interface

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
arse the binary=85

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

Hi David, please feel free to correct my statement since I=92m not sure I h=
ave a view of whole picture.

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



_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
