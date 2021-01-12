Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C5DC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 03:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62670206C2
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 03:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62670206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E7B889EBD;
	Tue, 12 Jan 2021 03:13:11 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760079.outbound.protection.outlook.com [40.107.76.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13DF689EBD
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 03:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCDntIewcPwWZ+gnuDfnK5z9oOlCe974fSIDl/vHhXfjQbpwTqjeu3oVkryb52/IpJm7kQQL95YZ6doSWTE29rf6odjbbpV7n5TrWPhZZryDzjQRFmziFZbllT9qKboQGJ7U2u1p2d730OzdPQ6Cuq+MohiiKlbT3VGE6CCqDaoRRVJwfDmnQhVEBhS7AkmytE9M1XjFWgPIv4gxCNSzHLZlY2QWdoftRoBkyzX2lAxTqYUDPuW98J1SY+4XVk8SVPRJeZN+UmrO780q5jFKSdN6BbbYq1YnmiqUQVuA+J0fGWhLPtXu8oN3fuXvpxhJ03bP1lvci7prk4dv8ZhPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEsKjwp6G2b2Hd4LlSrbvGIYfUbB57g6BzXc6+H04H0=;
 b=nQbWGkSJ/FC87mZTchjEcXt2MXk7AGjIqnGyxlEXFvQuMR7KBcFyE8G3xmoFxfJArFeVQEvM/SecTtUZ9kmdy8bOqtX/WaIbPrh7cM4NqJcVGylG0IX4AttuSE3XtS384wufGvSDdUrsXSo/nwz57mAYdJdgGgjnMpYYZihAb03RBimbtAY7dcoiCYki2IiSl1GE9CGj1gDQoqG7dokXINaqzdbIjkHPaB51duKmQ/YxAay02Kwc2duUulHS56+x35x3HIdH+5B58ZZcEXmtpb2XM61LfUOgjsW0ylrKKDlOR3RjRb7B8O40XnTOrs3HODPRRuaurLQtmTKuL8oV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEsKjwp6G2b2Hd4LlSrbvGIYfUbB57g6BzXc6+H04H0=;
 b=1eUNbwnyGOx6J3Qc3h6NHKtnbjgOiMX/LYCRMOq9zMLCJ7o6I6CXtkysyXIcMaHHiELlc/RjxegA2V1YvXARQ4tx4p0CpryJNXfF2ks591QP04Ot1icItPHW/ksKqt2Wr5KhMAmuOSesSIqDQ7IwoWXgHiij0uE0P5TNAr6rfdM=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4967.namprd12.prod.outlook.com (2603:10b6:a03:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 03:13:07 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145%5]) with mapi id 15.20.3742.006; Tue, 12 Jan 2021
 03:13:07 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: RE: [PATCH v2] drm/amdgpu:Limit the resolution for virtual_display
Thread-Topic: [PATCH v2] drm/amdgpu:Limit the resolution for virtual_display
Thread-Index: AQHW5KVRqTF27MuwQkGt+AIkPIfolKoc9qJggADh7YCABAnEIIAAdFwAgAAAaoCAAQDtoA==
Date: Tue, 12 Jan 2021 03:13:07 +0000
Message-ID: <BY5PR12MB4115389DBBF968DB533CF3A08FAA0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210107032927.660772-1-Emily.Deng@amd.com>
 <BY5PR12MB4115BE023BAF8FE53E2070158FAE0@BY5PR12MB4115.namprd12.prod.outlook.com>
 <CADnq5_N0hYURmnApHxhk3xmY426jyRNCBn97JoNxAq8t3f=Ojw@mail.gmail.com>
 <BY5PR12MB411578DED560A6B45727AA2C8FAB0@BY5PR12MB4115.namprd12.prod.outlook.com>
 <e6fe7c66-6033-9556-dcac-cb5970ce87fe@daenzer.net>
 <e21ec168-a4e5-2280-e3bc-42ee11c4476c@daenzer.net>
In-Reply-To: <e21ec168-a4e5-2280-e3bc-42ee11c4476c@daenzer.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e52e59ea-88ee-43b8-afff-1f69564323fb;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-12T03:11:45Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: daenzer.net; dkim=none (message not signed)
 header.d=none;daenzer.net; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0246b423-772e-4894-96c2-08d8b6a7fc0a
x-ms-traffictypediagnostic: BY5PR12MB4967:
x-microsoft-antispam-prvs: <BY5PR12MB49672F2DF8169F387CE33CF78FAA0@BY5PR12MB4967.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oI5gmZjwVjCgg+fc1CLqQ0aCFWzTNFoLFJ7DEQzSzZFl5aZ0OAOytFDFtijMuQoWcObDfh8bq4IFkwLKGwja6N4c0YfJLN1/LyLFITZQV2tJemo7Bp2egcHJpx8gOXk7oQvBn4mjfdooxlPY7bKsMXXuSJajrDoC3GrT5cuv2WnAz9fKw8x0yt/R+5Uxua8J9dtKvnRNsLXXVpLUCIYULnNVm1bbrKnSMH1QIuJfceaaDuKFneTRkert6bczJ3h0lwU3aAKd7df21CBpP2mg5qHAQJ4q1pNV4AqsMPfCc6btktCqwytzWHqJI/ZRSTj/KmiETnyYas20mo11Wd1lxLC0Tm841yYnZ1iPHrnVaH8RnqEqedpAfJyyt8/gupKNLAl2lVMUDwKFQyRCeX/GuVGKIAvMae04Mw2UGiekOTdRbY6XD+1Oi0Y4iDzrztnTx3uVh6Tsd1Z401rx6tum5g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(53546011)(4326008)(52536014)(55016002)(26005)(66574015)(66446008)(45080400002)(5660300002)(33656002)(2906002)(66556008)(478600001)(8936002)(83380400001)(9686003)(316002)(66476007)(6506007)(8676002)(86362001)(7696005)(76116006)(110136005)(71200400001)(186003)(66946007)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?JLg+/78yjmZ9c7DpIu3geIH6aBfT1lFO5dHJS1F7idhfbWrTwLPZtoP1G0?=
 =?iso-8859-1?Q?zPD3bOGKxHHvnZwxaQl/akcAEBoNkcQu8MFvHFF1l76nfwlabTqS7aqW0h?=
 =?iso-8859-1?Q?obhwbXjv1Oo/i4V1j9yjLaH1nc9R3vvTSysfeXRJj5FxdBq9ervgyPMT7M?=
 =?iso-8859-1?Q?9YwmRLJZtJlggF9Etrt+bXZXPc7E30yPOVhWoUz9AFigmXPL28YQHtmQrv?=
 =?iso-8859-1?Q?K1VC45IteWQfIXHjH95UJNbVChP1Ehs7/sx8NpArp/iqTPnSgCIam7M9oy?=
 =?iso-8859-1?Q?n8/IoPe28FR5AWr6/rH4gM6O9Qktxp2CdI+EveWnbRhh1lO5IyXoeji4Vm?=
 =?iso-8859-1?Q?rNKFLqp0QXH86CI0DsfIZm5ZfVTakPGjtA73OKefZdNlwAMJX0ExfG1EkV?=
 =?iso-8859-1?Q?RwPINEdh5Im1IVIS9IJCbQ5NevpuaNZ2UxIwEYjQuBxqBC1ePDQ1sp2XmA?=
 =?iso-8859-1?Q?Rm1WlsWnNalU90qilMrTm9q3YOuTVvFWv7XvT6X5NMdWfXKHeDZmjvTwQJ?=
 =?iso-8859-1?Q?VxFEieMB9lo7CAb+0w+4W+fYNCQORofUr+hAQpIwRJsrHUKHyfg/OokLW6?=
 =?iso-8859-1?Q?3qDgfqwPBpxLH+FpcRfVL7cYs8BNA0IWCxpozqcbDCyDY98sGMSu7SBWyC?=
 =?iso-8859-1?Q?mxHfD6ANILWpuGibJTUOwmngrs00M+keBtJfIUIX6j1FObccdAwUyZGUfw?=
 =?iso-8859-1?Q?3vrwjymiHpjxKe4K48s54Vg6x8Y37Y2HaOaUUsbTkfr31j0nPKkcFpOO/X?=
 =?iso-8859-1?Q?DxHK3ak8K+eoArUuDoaxKrHdiYGaVRHmVwt4URd/rQLmd5kdfruW+BSIuD?=
 =?iso-8859-1?Q?tP8yeDwNfWsabSrnbjcVzjh2FTJp7x5sHx6KesAGD5Yony5XrYDdoJp1FC?=
 =?iso-8859-1?Q?0MYPHajuvlH9mzOsSb91G25tuPaeFr1jwHWpxhtONt6XtqYAYdHmfE6YC9?=
 =?iso-8859-1?Q?y7M/IdeP6POGY+XYQfRfSV0fAZyz8PQKPc1PkDZqmVkQFWjS1alCIcuXH9?=
 =?iso-8859-1?Q?NVYW9CsVRvSUltiL4jkvT9vK0fplBqT5yi591V?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0246b423-772e-4894-96c2-08d8b6a7fc0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 03:13:07.6116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FKY+Q2SX/pchnDCriST+W+HFkyQmCUDu+rbxhILPYR+rDrrcVPqMAT67MSDra35h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4967
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Michel and Alex,
    Ok, let us abandon the patch, wish user mode driver could fix those iss=
ues encountered after resolution bigger than 16384.

Best wishes
Emily Deng



>-----Original Message-----
>From: Michel D=E4nzer <michel@daenzer.net>
>Sent: Monday, January 11, 2021 7:52 PM
>To: Deng, Emily <Emily.Deng@amd.com>; Alex Deucher
><alexdeucher@gmail.com>
>Cc: amd-gfx@lists.freedesktop.org
>Subject: Re: [PATCH v2] drm/amdgpu:Limit the resolution for virtual_display
>
>On 2021-01-11 12:50 p.m., Michel D=E4nzer wrote:
>> On 2021-01-11 5:55 a.m., Deng, Emily wrote:
>>> [AMD Official Use Only - Internal Distribution Only]
>>>
>>> Yes, it just won't report bigger than 16384 mode to user mode, as it
>>> won't work properly.
>>
>> ... with Xorg / glamor. It doesn't affect other user-space.
>
>Let me rephrase: This would artificially limit other user-space.
>
>
>--
>Earthling Michel D=E4nzer               |
>https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredha
>t.com%2F&amp;data=3D04%7C01%7CEmily.Deng%40amd.com%7Cae76e0607c
>d84ddba1c308d8b6275595%7C3dd8961fe4884e608e11a82d994e183d%7C0%
>7C0%7C637459627355417401%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
>wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a
>mp;sdata=3DDoZlNXoNACkAbfn%2FcobBOM3D6Q60TgMz0bMSdCIgAVk%3D&a
>mp;reserved=3D0
>Libre software enthusiast             |             Mesa and X developer
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
