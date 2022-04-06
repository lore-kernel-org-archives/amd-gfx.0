Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3809FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Apr 2022 14:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A587610E2FA;
	Wed,  6 Apr 2022 14:27:00 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02AE110E487
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Apr 2022 14:26:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYOfy7vA5PbI9j7Q7GdyETxmBeE1M6yUF47YtOT3lERTqvgjQh6gj9saRZBKBOjTy2k8KmdlUiZWfalYAQe0IOyAVhS75WwKDKPCiUeYA5XZ0tkn5G09uNPVUL2UWVhGOrym7tbEUFvzatvafL5xPiT91hLdW+e0F2Ndn9sqFOsX7h/iCa2FlPCARstY1rnE1Iu8cD1/YLMW2hVQOTITK9p2oyqPwdZhqX/C2tFR/nZwf4ZiXJyNxUPMlBcRn/dpih0N0KmyaPpUvoubfPPMmS/sk76VzCUxEOR+6OUl2a/IhDfPbArz4O9XopRA8E+MbEQ/4o1s1loZ5Ivq4+POTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbqpBlSYcQixapbGDqqFoh75mbnw/sikV8qgyACR4P8=;
 b=Qa+akXGvVEMB7TPzLBYMvUg3lgJF5UomMO2T+ifecpmJy4iILN0OP+4gfc51W+yvaJSoFl7os7JHRV6QOUQ+NFkPp5uzBvIdek618rYqhlaZF6oXgFlJyHZsNhKLmZg+jK8NYWXb1YRoGa8veAXZB8WS6KXRtjSLhxU4jIn1ruXqeVNcqHjfXxX4evDFD7yqx9U4VtdsG3N26Xpxp86l8aQU8sBxto3FZ0y0FgM9sYZQbRw7V1LgoSFt+zNM9HnEYpP7ZZ1NBhciXIW2OO0mo8zrOM0UNqGuiExMkbj1UDpWdu7c0E5dtE3sWJ81ajE6t+MlkT/9WMYK32+JqwYQXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbqpBlSYcQixapbGDqqFoh75mbnw/sikV8qgyACR4P8=;
 b=YV7wjO2nZd55NIL4pjrqk2wuMEv1yhaq8SLeckrHFTMPosvg2ZgnCSFh5Wvi6I3yL5aBTepcGXc43kprS4h60R19J4FnmQSTt8++HGNJxydXmQIxdJrehtUFrB9Gp4SPfyAtpryVN/w2hcMEN8bONGNvsnKSrZDrsutpsFDIeuE=
Received: from PSAP153MB0517.APCP153.PROD.OUTLOOK.COM (2603:1096:301:67::8) by
 KL1P15301MB0571.APCP153.PROD.OUTLOOK.COM (2603:1096:820:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8; Wed, 6 Apr
 2022 14:25:59 +0000
Received: from PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
 ([fe80::c88f:d71a:2b3d:1c32]) by PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
 ([fe80::c88f:d71a:2b3d:1c32%9]) with mapi id 15.20.5164.008; Wed, 6 Apr 2022
 14:25:59 +0000
From: Shuotao Xu <shuotaoxu@microsoft.com>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
Thread-Topic: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
Thread-Index: AQHYSV+lQh0DehaAkU6mUF/D9OJf/qzi7iYAgAABCGM=
Date: Wed, 6 Apr 2022 14:25:59 +0000
Message-ID: <PSAP153MB0517571E0AECDB007D90A8F3B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
References: <PSAP153MB051776C60FFB06BB3278EEB4B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
 <2cdfcdee-bf4d-006a-19c1-c806feb4100d@amd.com>
In-Reply-To: <2cdfcdee-bf4d-006a-19c1-c806feb4100d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-06T14:16:53.0934595Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ba83fe2-aecd-4d06-1cd5-08da17d95ee5
x-ms-traffictypediagnostic: KL1P15301MB0571:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <KL1P15301MB0571DC5253A128117A134FA0B7E79@KL1P15301MB0571.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y0EGXjI4jtiASaImkCpnHQSUG/WUzDlOMGezhkwfgHpr1sQ3jaCTgGmQV4kn5MAWo/Fw2a7lJpZ+Mb0q727BvpAi6UDDXqwIb0zSaO9dMvjPGwD4FHcnjH34Exks53JP2TN+GshgXn5M5x/Y7i8J/iUwYctBOWWF8jeeUWMwCu+7mBQ+hbVAQK5xP1lz2a/f4I7f/PJOWPxQSA/FbHPiTXKgq369PimzDh2JJ77jtOD0hWbyDjJAeziUCQcFiBKNWAKk/PZw2DSRwMd+1/KpreaASSzOeDXdHqQIg6gkRmqGCSbY0q/8pekWTGksXIk32AwXGA5QkAK8+qALjbXOI8Lh1vqSXOYaQIhMkY9RojCeg4YZXLxBOeIWBBgIPN2DR8R41xmAZ36weUJb7v2VayB7xHu4axyhCmS+G8K0JNLz1I+/UI7Qvc/0AfH2vemuSloLyaY/bu0PsU7SnR+JcN2K7NTTNRE4uVlVm2CisMXH+7bMorjhEAcdVdsP1j8Gf/9WjEpliXRQ4jHunpFce0fNLaV0JP6Kp/clnfnQPi4m9zYaHB0RuDzfmmbgoOK1olJPAmE8Ux9usDUMTxI0QL5HpL2aB4SdzW1VlvPTaZuqzPyQBZmESqc1ehTBa1J40swWNq8CFOGa7hBFx+yPE0re9cA3ny8jDwNHmPUOomkLXYELLpkeQsfX0qiQDnlkA+kuVPnZSOodDJGQ3o+bgfOK8EI+NlRKbcSPOLPMykN/a79ad+B2T26JpLh6DzOfMXXL+Rq92RlH6t/WcbDJPlkd0Ky4LpWjbA3b3jKFeQrzPxRnx2WvjdTlnadHvWx2UZ5yaZPmSNi82c2eeJiuGk71HOY5oUEWfJNsW+gOl4GBk0v5eXXYs6mQIwkh5O+ZuOQ/YeHRi25UULYagHP9VQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAP153MB0517.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(99936003)(16799955002)(38070700005)(82950400001)(82960400001)(53546011)(107886003)(166002)(55016003)(54906003)(110136005)(316002)(38100700002)(122000001)(71200400001)(64756008)(8990500004)(10290500003)(508600001)(9686003)(2906002)(52536014)(8936002)(66476007)(83380400001)(66446008)(9326002)(66946007)(8676002)(66556008)(76116006)(966005)(4326008)(5660300002)(6506007)(33656002)(91956017)(186003)(86362001)(7696005)(10090945011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jJjMmriA09+/U+aL4BN8H8MF2mZgTYwOnvl3zWwJyPVMi7N2foB46pgZUK?=
 =?iso-8859-1?Q?IGT3cEMUQnNZzA62vM+kcAHwrk9SRZJn8DkUKdaKmDDPlWGegcncqTo5H4?=
 =?iso-8859-1?Q?WkoqQoTqPGHb+s6xUU3yZ3e2VcaIaWU0RqE60bDNmY//KZ2AFqhhyxJiEM?=
 =?iso-8859-1?Q?2zxT/3NmGwot+gHLLKoflcycnjKP9iZyGoZ/nKm4cElemihuravMV3ZSs8?=
 =?iso-8859-1?Q?NaoEpHXRy7eZvXLbJRc7iuALUrMum6mEQk+CuZBf2e9Y4OcupTNfWBG30E?=
 =?iso-8859-1?Q?JwieIb70LvZJ2vQl8vgpT/9BgD3blT+UbeWbRItv4wui+kFqfBNh6Dbw+/?=
 =?iso-8859-1?Q?T3OXA4fWy/iK+KS5gTIcTHXkQD360Hpz6J9MdfQpXN1eQ/5Fuj1a3M0gvs?=
 =?iso-8859-1?Q?2n80RichCyxi871zApUvRufNrfIE+BPLoz3iMwMNGjykqtVG/CbRDcZ86y?=
 =?iso-8859-1?Q?2aUbQ8KpB4FbCkr7VlQmdC8CBVk9Z+jSn9H22r5RgAOkTDrBfoN07gGrnU?=
 =?iso-8859-1?Q?/G0Bgdg3k6mKJMG1ktF3cbmD8pyeD1AFc/pc2z6zKkb6AdpIiAUNuNEltL?=
 =?iso-8859-1?Q?gc4h/UQQKjVWnw5FXzznQ5BZ9ipuMwcc2p4+mCHcRM9qcEy5D/7c5R/6HE?=
 =?iso-8859-1?Q?ZoRmUwc/avqyCMrpsCq8/JsGmsXc3waFNtiYWUbAgVbxNY8CngNEq53DWY?=
 =?iso-8859-1?Q?SWFm5OGawfUp2WUnEhC/grvUtFAR+euJn4PDe3pnTO9bWGXJ6ixELIf5Xg?=
 =?iso-8859-1?Q?48rqBiKXgpIR9h8SPwas4ixuOnOOSSzYJr6syf3soxl0kqV14O7bzJZlMW?=
 =?iso-8859-1?Q?kFoxtME29EKJH+syAGUUM6jWijBQnn3ap6OXUywAXfR5/o83M5cuLjkcyK?=
 =?iso-8859-1?Q?qyyahEDoRZdz8NRiLIVNKaNThTdegKGEl0lsEle96EjxZal6d1qWCl1Hf/?=
 =?iso-8859-1?Q?mzp58MqvDoL8eyI7Lnuyyxd1J8n+hv0uknc/wjHlL/ulIHnrdL0kZxVnh/?=
 =?iso-8859-1?Q?PVazBDk6aJpemzCol50MjF71aQN1l17NSWFkheJl0iK9bVcLYxipUDz5nG?=
 =?iso-8859-1?Q?WedfPrF9o5+Qeecd9Q69mk+poa1xABIsVUSrw/8Aa0dn5LlwiTsyzepDT4?=
 =?iso-8859-1?Q?sBvPJgosGcstGx/B9ag5piWgtSgljwLXaZTyka/7UTIk+6r30GnL9xqttJ?=
 =?iso-8859-1?Q?lQjOGTMlr4bNC63iiPaSgNghnh8lZLj0RQ+a8iFeCWwWU5sSaTn6ohpJRk?=
 =?iso-8859-1?Q?XnocaYN5yH3j0D/UDXLUPMAo72X0+cRDZ3ktPld0C7CC0yjviC1Z4MHLKP?=
 =?iso-8859-1?Q?l+9bOIzNYgoV4EEqEGfQdOHlELggFqZ3geKCJX2Qaktimgnb4byk0Hth0p?=
 =?iso-8859-1?Q?DK7ozzBrbjTpcORYKM/Vf6iQ3HxW+ukb1PL/jwx0XeLVsroSc+N8iXdOmU?=
 =?iso-8859-1?Q?zxz6+zkrCIdKjhaL63ITmTGZrtGIMjMHN61I3LTGqVfP1qSaY6dINI27Cm?=
 =?iso-8859-1?Q?84MkcnVFvQ/KK95gnnm8WIKDRHt1I87GlmWijtNrixfBqArFoJwWypcZ6c?=
 =?iso-8859-1?Q?S5aA2bIYyktpGRMkneP96dVVph9NnHT5DaEoaqMUzjq6vDYY00TlSIWjAf?=
 =?iso-8859-1?Q?qDNG1A9ngdpyMs8gEBY+OXFFGd6L9o7g5m0pM5HFqPodC4IJyfzBN1ftGJ?=
 =?iso-8859-1?Q?cMMxIL19WU0Bwwx9SPlYIcBskSYxYF4g/J01RatKDvq8l2tJrDd0RHnhJO?=
 =?iso-8859-1?Q?9z2sIw9LfrFa9ONE/MBxnsVdG5Gy6eA+atfg9BEijFAYnkDaITn07dWhvB?=
 =?iso-8859-1?Q?1OV/RaHEiQ=3D=3D?=
Content-Type: multipart/mixed;
 boundary="_004_PSAP153MB0517571E0AECDB007D90A8F3B7E79PSAP153MB0517APCP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba83fe2-aecd-4d06-1cd5-08da17d95ee5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 14:25:59.0051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dhYDoeTpXcoeJukwrS33L+wKNHGpEiRnPGPs4/G+rhNehUDUiC71h6l02Z3eMwvRnpBLP0qhOdY78/NxJ9V/VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0571
X-Mailman-Approved-At: Wed, 06 Apr 2022 14:27:00 +0000
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
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com>, Lei Qu <Lei.Qu@microsoft.com>,
 Peng Cheng <pengc@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_004_PSAP153MB0517571E0AECDB007D90A8F3B7E79PSAP153MB0517APCP_
Content-Type: multipart/alternative;
	boundary="_000_PSAP153MB0517571E0AECDB007D90A8F3B7E79PSAP153MB0517APCP_"

--_000_PSAP153MB0517571E0AECDB007D90A8F3B7E79PSAP153MB0517APCP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Andrey,

We just tried kernel 5.16 based on https://gitlab.freedesktop.org/agd5f/lin=
ux.git amd-staging-drm-next branch, and found out that hotplug did not work=
 out of box for Rocm compute stack.
We did not try the rendering stack since we currently are more focused on A=
I workloads.

We have also created a patch against the amd-staging-drm-next branch to ena=
ble hotplug for ROCM stack, which were sent in another later email with sam=
e subject. I am attaching the patch in this email, in case that you would w=
ant to delete that later email.

Best regards,
Shuotao

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Date: Wednesday, April 6, 2022 at 10:13 PM
To: Shuotao Xu <shuotaoxu@microsoft.com>, amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com>, Lei Qu <Lei.Qu@microsoft.com>, P=
eng Cheng <pengc@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>
Subject: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
[You don't often get email from andrey.grodzovsky@amd.com. Learn why this i=
s important at http://aka.ms/LearnAboutSenderIdentification.]<http://aka.ms=
/LearnAboutSenderIdentification.%5d>

Looks like you are using 5.13 kernel for this work, FYI we added
hot plug support for the graphic stack in 5.14 kernel (see
https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.pho=
ronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unplug=
&amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7Cf1f7980b198541d7196d08da1=
7d79838%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848512015144682%7CU=
nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC=
JXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D26qOd5vKzOigo0SaSc5%2FF8BOI9yzRlqC=
08xUMC01Jzk%3D&amp;reserved=3D0)


I am not sure about the code part since it all touches KFD driver (KFD
team can comment on that) - but I was just wondering if you try 5.14
kernel would things just work for you out of the box ?

Andrey

On 2022-04-05 22:45, Shuotao Xu wrote:
> Dear AMD Colleagues,
>
> We are from Microsoft Research, and are working on GPU disaggregation
> technology.
>
> We have created a new pull requestAdd PCIe hotplug support for amdgpu by
> xushuotao =B7 Pull Request #131 =B7 RadeonOpenCompute/ROCK-Kernel-Driver
> (github.com)
> <https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith=
ub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&amp;data=3D05%=
7C01%7Cshuotaoxu%40microsoft.com%7Cf1f7980b198541d7196d08da17d79838%7C72f98=
8bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848512015144682%7CUnknown%7CTWFpbG=
Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C=
3000%7C%7C%7C&amp;sdata=3Du2NtNDfuiCfKNKqeZ337KLq2uRDB1oGyO3%2BxIMQweRA%3D&=
amp;reserved=3D0>in
> ROCK-Kernel-Driver, which will enable PCIe hot-plug support for amdgpu.
>
> We believe the support of hot-plug of GPU devices can open doors for
> many advanced applications in data center in the next few years, and we
> would like to have some reviewers on this PR so we can continue further
> technical discussions around this feature.
>
> Would you please help review this PR?
>
> Thank you very much!
>
> Best regards,
>
> Shuotao Xu
>

--_000_PSAP153MB0517571E0AECDB007D90A8F3B7E79PSAP153MB0517APCP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
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
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle19
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
--></style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi Andrey,<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">We just tried kerne=
l 5.16 based on
<a href=3D"https://gitlab.freedesktop.org/agd5f/linux.git">https://gitlab.f=
reedesktop.org/agd5f/linux.git</a> amd-staging-drm-next branch, and found o=
ut that hotplug did not work out of box for Rocm compute stack.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">We did not try the =
rendering stack since we currently are more focused on AI workloads.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">We have also create=
d a patch against the amd-staging-drm-next branch to enable hotplug for ROC=
M stack, which were sent in another later email with same subject. I am att=
aching the patch in this email, in case
 that you would want to delete that later email.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Best regards,<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Shuotao<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Andrey Grodzovsky &=
lt;andrey.grodzovsky@amd.com&gt;<br>
<b>Date: </b>Wednesday, April 6, 2022 at 10:13 PM<br>
<b>To: </b>Shuotao Xu &lt;shuotaoxu@microsoft.com&gt;, amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc: </b>Ziyue Yang &lt;Ziyue.Yang@microsoft.com&gt;, Lei Qu &lt;Lei.Qu@m=
icrosoft.com&gt;, Peng Cheng &lt;pengc@microsoft.com&gt;, Ran Shu &lt;Ran.S=
hu@microsoft.com&gt;<br>
<b>Subject: </b>[EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Suppo=
rt<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[You don't often ge=
t email from andrey.grodzovsky@amd.com. Learn why this is important at
<a href=3D"http://aka.ms/LearnAboutSenderIdentification.%5d">http://aka.ms/=
LearnAboutSenderIdentification.]</a><br>
<br>
Looks like you are using 5.13 kernel for this work, FYI we added<br>
hot plug support for the graphic stack in 5.14 kernel (see<br>
<a href=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU=
-Hot-Unplug&amp;amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7Cf1f7980b19=
8541d7196d08da17d79838%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6378485=
12015144682%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ=
BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3D26qOd5vKzOigo0S=
aSc5%2FF8BOI9yzRlqC08xUMC01Jzk%3D&amp;amp;reserved=3D0)">https://nam06.safe=
links.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.phoronix.com%2Fscan.p=
hp%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unplug&amp;amp;data=3D05=
%7C01%7Cshuotaoxu%40microsoft.com%7Cf1f7980b198541d7196d08da17d79838%7C72f9=
88bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848512015144682%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C3000%7C%7C%7C&amp;amp;sdata=3D26qOd5vKzOigo0SaSc5%2FF8BOI9yzRlqC08xUMC01Jz=
k%3D&amp;amp;reserved=3D0)</a><br>
<br>
<br>
I am not sure about the code part since it all touches KFD driver (KFD<br>
team can comment on that) - but I was just wondering if you try 5.14<br>
kernel would things just work for you out of the box ?<br>
<br>
Andrey<br>
<br>
On 2022-04-05 22:45, Shuotao Xu wrote:<br>
&gt; Dear AMD Colleagues,<br>
&gt;<br>
&gt; We are from Microsoft Research, and are working on GPU disaggregation<=
br>
&gt; technology.<br>
&gt;<br>
&gt; We have created a new pull requestAdd PCIe hotplug support for amdgpu =
by<br>
&gt; xushuotao =B7 Pull Request #131 =B7 RadeonOpenCompute/ROCK-Kernel-Driv=
er<br>
&gt; (github.com)<br>
&gt; &lt;<a href=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F1=
31&amp;amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7Cf1f7980b198541d7196=
d08da17d79838%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6378485120151446=
82%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h=
aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3Du2NtNDfuiCfKNKqeZ337KLq2=
uRDB1oGyO3%2BxIMQweRA%3D&amp;amp;reserved=3D0">https://nam06.safelinks.prot=
ection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FRO=
CK-Kernel-Driver%2Fpull%2F131&amp;amp;data=3D05%7C01%7Cshuotaoxu%40microsof=
t.com%7Cf1f7980b198541d7196d08da17d79838%7C72f988bf86f141af91ab2d7cd011db47=
%7C1%7C0%7C637848512015144682%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL=
CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=
=3Du2NtNDfuiCfKNKqeZ337KLq2uRDB1oGyO3%2BxIMQweRA%3D&amp;amp;reserved=3D0</a=
>&gt;in<br>
&gt; ROCK-Kernel-Driver, which will enable PCIe hot-plug support for amdgpu=
.<br>
&gt;<br>
&gt; We believe the support of hot-plug of GPU devices can open doors for<b=
r>
&gt; many advanced applications in data center in the next few years, and w=
e<br>
&gt; would like to have some reviewers on this PR so we can continue furthe=
r<br>
&gt; technical discussions around this feature.<br>
&gt;<br>
&gt; Would you please help review this PR?<br>
&gt;<br>
&gt; Thank you very much!<br>
&gt;<br>
&gt; Best regards,<br>
&gt;<br>
&gt; Shuotao Xu<br>
&gt;<o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_PSAP153MB0517571E0AECDB007D90A8F3B7E79PSAP153MB0517APCP_--

--_004_PSAP153MB0517571E0AECDB007D90A8F3B7E79PSAP153MB0517APCP_
Content-Type: application/octet-stream;
	name="0001-drm-amdkfd-Add-PCIe-Hotplug-Support-for-AMDGPU.patch"
Content-Description: 0001-drm-amdkfd-Add-PCIe-Hotplug-Support-for-AMDGPU.patch
Content-Disposition: attachment;
	filename="0001-drm-amdkfd-Add-PCIe-Hotplug-Support-for-AMDGPU.patch";
	size=4008; creation-date="Wed, 06 Apr 2022 14:24:30 GMT";
	modification-date="Wed, 06 Apr 2022 14:24:30 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhNGU1M2JkYTZmNjViNzJiMWY2YTM0NGMxOTY3NzU3NGQ3ODQyY2QzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaHVvdGFvIFh1IDxzaHVvdGFveHVAbWljcm9zb2Z0LmNvbT4K
RGF0ZTogV2VkLCA2IEFwciAyMDIyIDEyOjQyOjEwICswOTAwClN1YmplY3Q6IFtQQVRDSF0gZHJt
L2FtZGtmZDogQWRkIFBDSWUgSG90cGx1ZyBTdXBwb3J0IGZvciBBTURHUFUgMS4gRHVyaW5nCiBQ
Q0llIHByb2JpbmcsIGRlY3JlbWVudCBLRkQgbG9jayB3aGljaCB3YXMgaW5jcmVtZW50ZWQgd2hl
biAgICB0aGUgUENJZQogZGV2aWNlIHdhcyByZW1vdmVkOyBvdGhlcndpc2Uga2ZkX29wZW4gaXMg
Z29pbmcgdG8gZmFpbC4gMi4gUmVtb3ZlIHAycCBsaW5rcwogaW4gc3lzZnMgd2hlbiBkZXZpY2Ug
aXMgaG90cGx1Z2dlZCBvdXQuCgpTaWduZWQtb2ZmLWJ5OiBTaHVvdGFvIFh1IDxzaHVvdGFveHVA
bWljcm9zb2Z0LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNl
LmMgICB8ICA0ICsrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyB8
IDUwICsrKysrKysrKysrKysrKysrKysrKy0tCiAyIGZpbGVzIGNoYW5nZWQsIDUxIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rldmlj
ZS5jCmluZGV4IDYyYWE2YzlkNTEyMy4uYzk2MzhiYzI5OWRkIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2RldmljZS5jCkBAIC01NzUsNiArNTc1LDEwIEBAIGJvb2wga2dkMmtmZF9k
ZXZpY2VfaW5pdChzdHJ1Y3Qga2ZkX2RldiAqa2ZkLAogCWlmIChrZmRfcmVzdW1lKGtmZCkpCiAJ
CWdvdG8ga2ZkX3Jlc3VtZV9lcnJvcjsKIAorCS8qIHJlbGVhc2Uga2ZkIGxvY2sgYi9vIHBjaWUg
aG90cGx1ZyBvdXQgICovCisJaWYgKGtmZF9pc19sb2NrZWQoKSkKKwkJYXRvbWljX2RlYygma2Zk
X2xvY2tlZCk7CisKIAlpZiAoa2ZkX3RvcG9sb2d5X2FkZF9kZXZpY2Uoa2ZkKSkgewogCQlkZXZf
ZXJyKGtmZF9kZXZpY2UsICJFcnJvciBhZGRpbmcgZGV2aWNlIHRvIHRvcG9sb2d5XG4iKTsKIAkJ
Z290byBrZmRfdG9wb2xvZ3lfYWRkX2RldmljZV9lcnJvcjsKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3RvcG9sb2d5LmMKaW5kZXggM2JkY2FlMjM5YmMwLi5jZmEzYjE2ZjY5MzkgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jCkBAIC0xMzIsNiArMTMy
LDIxIEBAIHN0cnVjdCBrZmRfZGV2ICprZmRfZGV2aWNlX2J5X2FkZXYoY29uc3Qgc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCiAJcmV0dXJuIGRldmljZTsKIH0KIAorLyogQ2FsbGVkIHdpdGgg
d3JpdGUgdG9wb2xvZ3lfbG9jayBhY3F1aXJlZCAqLworc3RhdGljIHZvaWQga2ZkX3JlbGVhc2Vf
bGlua19wcm9wKHN0cnVjdCBrZmRfdG9wb2xvZ3lfZGV2aWNlICpkZXYsIHVpbnQzMl90IG5vZGVf
aWQpCit7CisJc3RydWN0IGtmZF9pb2xpbmtfcHJvcGVydGllcyAqaW9saW5rLCAqdG1wOworCisJ
bGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGlvbGluaywgdG1wLCAmZGV2LT5pb19saW5rX3Byb3Bz
LCBsaXN0KSB7CisJCWlmIChpb2xpbmstPm5vZGVfdG8gPT0gbm9kZV9pZCkgeworCQkJcHJfZGVi
dWcoIiVzLCBpb19saW5rIGZyb21fbm9kZSA9ICVkLCB0b19ub2RlID0gJWQiLCBfX2Z1bmNfXywg
aW9saW5rLT5ub2RlX2Zyb20sIGlvbGluay0+bm9kZV90byk7CisJCQlsaXN0X2RlbCgmaW9saW5r
LT5saXN0KTsKKwkJCWtmcmVlKGlvbGluayk7CisJCQlkZXYtPm5vZGVfcHJvcHMuaW9fbGlua3Nf
Y291bnQtLTsKKwkJfQorCX0KK30KKwogLyogQ2FsbGVkIHdpdGggd3JpdGUgdG9wb2xvZ3lfbG9j
ayBhY3F1aXJlZCAqLwogc3RhdGljIHZvaWQga2ZkX3JlbGVhc2VfdG9wb2xvZ3lfZGV2aWNlKHN0
cnVjdCBrZmRfdG9wb2xvZ3lfZGV2aWNlICpkZXYpCiB7CkBAIC01NTYsNiArNTcxLDIxIEBAIHN0
YXRpYyB2b2lkIGtmZF9yZW1vdmVfc3lzZnNfZmlsZShzdHJ1Y3Qga29iamVjdCAqa29iaiwgc3Ry
dWN0IGF0dHJpYnV0ZSAqYXR0cikKIAlrb2JqZWN0X3B1dChrb2JqKTsKIH0KIAorc3RhdGljIHZv
aWQga2ZkX3JlbW92ZV9zeXNmc19saW5rX3RvKHN0cnVjdCBrZmRfdG9wb2xvZ3lfZGV2aWNlICpk
ZXYsIHVpbnQzMl90IG5vZGVfaWQpCit7CisJc3RydWN0IGtmZF9pb2xpbmtfcHJvcGVydGllcyAq
aW9saW5rOworCisJaWYgKGRldi0+a29ial9pb2xpbmspIHsKKwkJbGlzdF9mb3JfZWFjaF9lbnRy
eShpb2xpbmssICZkZXYtPmlvX2xpbmtfcHJvcHMsIGxpc3QpCisJCQlpZiAoaW9saW5rLT5rb2Jq
ICYmIGlvbGluay0+bm9kZV90byA9PSBub2RlX2lkKSB7CisJCQkJcHJfZGVidWcoIiVzLCBpb19s
aW5rIGZyb21fbm9kZSA9ICVkLCB0b19ub2RlID0gJWQiLCBfX2Z1bmNfXywgaW9saW5rLT5ub2Rl
X2Zyb20sIGlvbGluay0+bm9kZV90byk7CisJCQkJa2ZkX3JlbW92ZV9zeXNmc19maWxlKGlvbGlu
ay0+a29iaiwKKwkJCQkJCQkJCSAgJmlvbGluay0+YXR0cik7CisJCQkJaW9saW5rLT5rb2JqID0g
TlVMTDsKKwkJCX0KKwl9Cit9CisKIHN0YXRpYyB2b2lkIGtmZF9yZW1vdmVfc3lzZnNfbm9kZV9l
bnRyeShzdHJ1Y3Qga2ZkX3RvcG9sb2d5X2RldmljZSAqZGV2KQogewogCXN0cnVjdCBrZmRfaW9s
aW5rX3Byb3BlcnRpZXMgKmlvbGluazsKQEAgLTE0OTAsMjAgKzE1MjAsMzQgQEAgaW50IGtmZF90
b3BvbG9neV9yZW1vdmVfZGV2aWNlKHN0cnVjdCBrZmRfZGV2ICpncHUpCiAJc3RydWN0IGtmZF90
b3BvbG9neV9kZXZpY2UgKmRldiwgKnRtcDsKIAl1aW50MzJfdCBncHVfaWQ7CiAJaW50IHJlcyA9
IC1FTk9ERVY7CisJdWludDMyX3Qgbm9kZV9pZCA9IDA7CisJYm9vbCBmb3VuZCA9IGZhbHNlOwog
CiAJZG93bl93cml0ZSgmdG9wb2xvZ3lfbG9jayk7CiAKLQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3Nh
ZmUoZGV2LCB0bXAsICZ0b3BvbG9neV9kZXZpY2VfbGlzdCwgbGlzdCkKKwlsaXN0X2Zvcl9lYWNo
X2VudHJ5X3NhZmUoZGV2LCB0bXAsICZ0b3BvbG9neV9kZXZpY2VfbGlzdCwgbGlzdCkgewogCQlp
ZiAoZGV2LT5ncHUgPT0gZ3B1KSB7CiAJCQlncHVfaWQgPSBkZXYtPmdwdV9pZDsKIAkJCWtmZF9y
ZW1vdmVfc3lzZnNfbm9kZV9lbnRyeShkZXYpOwogCQkJa2ZkX3JlbGVhc2VfdG9wb2xvZ3lfZGV2
aWNlKGRldik7CiAJCQlzeXNfcHJvcHMubnVtX2RldmljZXMtLTsKIAkJCXJlcyA9IDA7Ci0JCQlp
ZiAoa2ZkX3RvcG9sb2d5X3VwZGF0ZV9zeXNmcygpIDwgMCkKLQkJCQlrZmRfdG9wb2xvZ3lfcmVs
ZWFzZV9zeXNmcygpOworCQkJcHJfZGVidWcoImtmZF90b3BvbG9neTogcmVtb3ZpbmcgZ3B1IG5v
ZGUsIG5vZGUgaWQgPSAlZCIsIG5vZGVfaWQpOworCQkJZm91bmQgPSB0cnVlOwogCQkJYnJlYWs7
CiAJCX0KKwkJbm9kZV9pZCsrOworCX0KKworCWlmIChmb3VuZCkgeworCQlsaXN0X2Zvcl9lYWNo
X2VudHJ5KGRldiwgJnRvcG9sb2d5X2RldmljZV9saXN0LCBsaXN0KSB7CisJCQlrZmRfcmVtb3Zl
X3N5c2ZzX2xpbmtfdG8oZGV2LCBub2RlX2lkKTsKKwkJCWtmZF9yZWxlYXNlX2xpbmtfcHJvcChk
ZXYsIG5vZGVfaWQpOworCQl9CisJCWF0b21pY19kZWMoJnRvcG9sb2d5X2NyYXRfcHJveGltaXR5
X2RvbWFpbik7CisJCWlmIChrZmRfdG9wb2xvZ3lfdXBkYXRlX3N5c2ZzKCkgPCAwKQorCQkJa2Zk
X3RvcG9sb2d5X3JlbGVhc2Vfc3lzZnMoKTsKKwl9CiAKIAl1cF93cml0ZSgmdG9wb2xvZ3lfbG9j
ayk7CiAKLS0gCjIuMTcuMQoK

--_004_PSAP153MB0517571E0AECDB007D90A8F3B7E79PSAP153MB0517APCP_--
