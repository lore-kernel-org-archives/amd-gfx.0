Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BD7C43461
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 14:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1939A60200
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 14:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1939A60200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85FF76E1A3;
	Tue, 11 May 2021 14:04:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A366E1A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 14:04:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwkPEthWE9uv6xrWi7qk0YwDVJxCBtF4q4rxG2qZfSF6hs2j801VehFYcwTXtzQ63E76kUmZCQsIzb5FToi/Y8f7jBwlxhVgxhg7keCkS125zrZTzDjNUnDc0zcj029uhG2HpUVNSrwEi82V4DilydIwVy3AAt5LkmZtkTMjU6Zr6+bpwIPFjIy9r/G9dE5WAKB/UT9Lv7ewaqlxdhDCNPTsx5+V02hkKyQleX8uROVNNz8hHh+N79bpXIVRlTDWvj3zXmaz2H77A9iSD65YtCQCc+TsXAfvsIrUo2GbncBbiJciSgrBd77ow2F47fWRdk23bt5QKqtFww7Pu/JFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+slpepyUheKJGg9UGvoosTH7lPvlJWfupXlvlUAYr4=;
 b=arBhZgVIO9CmBOyQU/nndyDg0O1+Pv9OdvHTBhlBBkGR51/Iy5YUofH1cKni8cWKsR45atjwbOHvXkZH9VVpckRM7UYrVyA2lx793am/+sfCMszURPUVkPjkvK8fsVtHuVjReXPVD2SUmITcw9naa4G0+D9vANCyuYiFYsXSMmrAdImzDCzalZNzBoMESu4DMiZdryYZ3JTG9B9z978z1kEGGBQdz+wQyH6DI1UbfC2Qe5xPSIw/D7gLew7orNa0lBNcZSGmQrL1pog8es3B/OQa1LOudYZNWyTKy7cyCAVyrIYRtEgpWnJMFtIl+JDkZLa++2H8R5eqD81i7WfWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+slpepyUheKJGg9UGvoosTH7lPvlJWfupXlvlUAYr4=;
 b=YOcUDveLghAjoz1qK0+1dyQ8+Doqma75/OOUlpjpbBIVI4xeUqUk744OEu60Efo0u3Il2YQYwB/XYbF/rUWIRnX3sHInXdQMRR4GgoCepFzMMaHngZUPF2EKC0um7sguHzQpuEHnp1kdUHgGEkoL2szEUGXSbfXIYlKjxeQ60ts=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 11 May
 2021 14:04:45 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 14:04:45 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?Windows-1252?Q?Marek_Ol=9A=E1k?= <maraeo@gmail.com>,
 =?Windows-1252?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
Thread-Topic: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
Thread-Index: AQHXQ9YlvIFc8fppMkC+tA7DX/OMKKrbUMIAgAD0PQCAAAWogIAABYaAgABsrACAAAHZgIAAbT+AgADBMACAAAe/gIAAYE12
Date: Tue, 11 May 2021 14:04:45 +0000
Message-ID: <MN2PR12MB4488E0D428871797E08DEE2BF7539@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210508064740.7705-1-Jiawei.Gu@amd.com>
 <CADnq5_PEogZDyFV_NOzbsajJQ_0A1+Jui-Mx7N_xsyWR5wXb8Q@mail.gmail.com>
 <CH0PR12MB5156FA453692B69100C3ADE7F8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <D7E9BE46-8E25-4A62-BE91-947898903A04@amd.com>
 <CH0PR12MB5156AF69D9E04020FDA5354AF8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <BYAPR12MB2840BA4077C73311A671CCBEF4549@BYAPR12MB2840.namprd12.prod.outlook.com>
 <bbf8cdf1-00a7-3e2a-74b0-71e85f1c7697@gmail.com>
 <447046CE-6FB4-49D7-A74A-2188654F5D5C@amd.com>
 <88e868eb-347b-611b-8d88-ba8d9d61c23b@gmail.com>,
 <CAAxE2A73V5PLVgrcd+_KYYbK=n+POZajdVYMcMdj8A38KvTerA@mail.gmail.com>
In-Reply-To: <CAAxE2A73V5PLVgrcd+_KYYbK=n+POZajdVYMcMdj8A38KvTerA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-11T14:04:44.505Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8544c091-b5cc-4518-dda3-08d91485bb1d
x-ms-traffictypediagnostic: MN2PR12MB4423:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4423F1E96049CA8FB5146FB4F7539@MN2PR12MB4423.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bCqIFzL4ya8+NYUP/kNGbXUZQ1qTPual5c0YnC07FKyEp0KG7SiIjSGAAZ7sSEMika1j4lKtmZ0cIwLbCqfQYnNtOatzB0hOEt+N3o90gbze1P2q2L0D/0IGMkc+6t1V4PrXvDISEceID7GTr+OR3isDJgQjtukshVODqMkof3UE//UidRnaOVIhay1lgsKUO4nfxLnR5i7EjYLDsUYfoa9y0T/kP1+ej5qUDjFEds2Un82wAml25xdaLC64XeyzPOAdhfHEsSdilrawqKaiSkxYTkxfi2wGPc7c6J5FqmJzerugfPOtF9/c7rXljTFhNIpjsEsApSuqgzJ6P+xvDkh1NJ+k2Enjbb7Dd5/oe4HTVXuFtbJBsC4WeG9dHP6mE6i/TMmrqn1QpKPwlrBfaA84qI6BHdUdwsn6GiQ7zi8BlZ8KKFhpzqz/5yePyQuI/nsoT1zu27wxd48nRfZXk4Pj2XnDfubdNvyVzr5hEAO0ZncEalTBtEosEe4miCTnaRATIh8dG0hksmTDHZ73V/3gCVm7epOW9SvIvqgz+DGO1fpjUqmpCjgE5nf2z17sI7Yvl8Qga8qNTUQUzyqofodQnLot5kabm4fOGtsh6GS2j0l6Q7h3/fLRdMhRzVx8a5KsFiEqnNztI8IFBgLf/wcnxSXVWwF7ooFMvqjHsRsfgvCCl02ZcT+6UxFtMP9B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(366004)(396003)(136003)(346002)(86362001)(45080400002)(66946007)(64756008)(478600001)(76116006)(66446008)(66556008)(66476007)(7696005)(53546011)(6506007)(5660300002)(54906003)(4326008)(52536014)(2906002)(83380400001)(55016002)(110136005)(9686003)(8676002)(66574015)(186003)(966005)(26005)(8936002)(38100700002)(19627405001)(166002)(71200400001)(122000001)(33656002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?Gec4wHO9jciPPwGWCHAg6nZwzSHIF8yoLKcMIVvbdpyYdTrsW+RPbwpu?=
 =?Windows-1252?Q?4bj92D8qvVpdbrsIrJ4L3E3Oh9Yw+L1724Jx55FJCCDmybLZ247RpIKm?=
 =?Windows-1252?Q?AIL0NqHCj5ucoF+Cv4hL7hfLY9TqNIoxEW/PEDXvB2/zY1/rc/ZPM7PH?=
 =?Windows-1252?Q?gmmVtWSdw9gyG5F2kQMhGXL1GdSGbmy0q09z0Mo3CjDevIdzW84PGXZ/?=
 =?Windows-1252?Q?n/5XeQ6pn7h1/hzDltm4Kif8YzCZ4y34R9+KhXbH5JPCOB4Skm9/uijs?=
 =?Windows-1252?Q?4CksYhKXQJVU1uotyrQtA30fblylsrJTg2kbjpZmopBzxzYZJvka4pwo?=
 =?Windows-1252?Q?lSYIZAoxpfogcfzPdnKtrmuVqhh3qt9jT09DUjiWL7cmWj15ya+BESNI?=
 =?Windows-1252?Q?WBTaS9hrcJqZS33qKKCVCPF4vwkwBxm7FnhZtTnU4Xp4MXIclLuY7zMm?=
 =?Windows-1252?Q?UWjn0l0D4b/mJX3tZWQTpVsGJB5MfPV6KmonsVPCDBjeZJd1HrI/AGsk?=
 =?Windows-1252?Q?euzijFaaCqrwRh3/bc+5ksq2ipmQ11xjdtpZ39zLNcJ4vspYSMZbNyqg?=
 =?Windows-1252?Q?O5KGSpSREgFOg2GpCXm6u1MSdOcVNp+QUTBZSEbs5p7gHeO63x9P5X7t?=
 =?Windows-1252?Q?63hx9cLug3BM/a8bWUd3r83r06+F31KhjG3qi6KTP7/7qln7e+cxNXT2?=
 =?Windows-1252?Q?//sk/q720a5mlWA/DWJ8MiOvoDDQCjqpsoDP/BVmaKZh2O7RkPskWsYt?=
 =?Windows-1252?Q?nx0XshhWmdlIknt4zFy31KeRJQf51RUlM576sYQSKJ1s/X1hCYc9xRTQ?=
 =?Windows-1252?Q?lULskrETGnWpvO6TTnrAv8mJ+fyxbr+vJVVC9BcMEOstOGGhp6GaNvHg?=
 =?Windows-1252?Q?6dS/Hq7+4CeQ72MOgK9tSguucEdXjdIg9VE21eQNlmDXWn8teVSipJHx?=
 =?Windows-1252?Q?4iKLcWTB0x3IubSoGQm5m+YNvOBniSkZT4pcQEIoeWLQ8WBwt61ZWaUj?=
 =?Windows-1252?Q?lWXIJOVhm2r00Bo+fgvhLEBoc/P+yP/QKuW6x/RhsV0FImHEciHAtl5d?=
 =?Windows-1252?Q?2rooVTWkc1pybgYwuAo06er8j01oueV+JH7PSILsBpkrV+gGWsw0hCA6?=
 =?Windows-1252?Q?9wuB4xnHgM2w/qOT78fsaL5770/QxS1crpQeRXhnTfdy8ofjMtSU4HST?=
 =?Windows-1252?Q?WsX6kiZ2IjcxrsBYU64cghg+l0dpWmWXnGE+PZ5YsoZGEs8KZyxXaSWc?=
 =?Windows-1252?Q?hMCozXDN538A4yQcLmB5jLIv6FeEEW4/55Z6rurG0xqM545i77jT7naW?=
 =?Windows-1252?Q?FIQrWVEUv8Sft5qKLsFIjjQAZVrbQ1esazV/bf2OJK+ZUc21/gC3LavT?=
 =?Windows-1252?Q?sdJ5xKKSeyAGxg4Me2lapmtI59lu0Jw8zvyBBXaCKQqmBUUnvPN0RCOL?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8544c091-b5cc-4518-dda3-08d91485bb1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 14:04:45.0684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tLxK50ixpD3oOBzkH3HE1ksAMH8Y6HgcKZ8xrSrIGnoVCnPYPnSYVas+1ez5idcjnNM/EbG98HYK+Npntf3fGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
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
Cc: Kees Cook <keescook@chromium.org>, "Gu,
 JiaWei \(Will\)" <JiaWei.Gu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deng, 
 Emily" <Emily.Deng@amd.com>, Alex Deucher <alexdeucher@gmail.com>, "Nieto,
 David M" <David.Nieto@amd.com>
Content-Type: multipart/mixed; boundary="===============0482945632=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0482945632==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488E0D428871797E08DEE2BF7539MN2PR12MB4488namp_"

--_000_MN2PR12MB4488E0D428871797E08DEE2BF7539MN2PR12MB4488namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

It's being used by umr and some other smi tools to provide vbios informatio=
n for debugging.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Marek Ol=
=9A=E1k <maraeo@gmail.com>
Sent: Tuesday, May 11, 2021 4:18 AM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Cc: Kees Cook <keescook@chromium.org>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com=
>; amd-gfx list <amd-gfx@lists.freedesktop.org>; Deng, Emily <Emily.Deng@am=
d.com>; Alex Deucher <alexdeucher@gmail.com>; Nieto, David M <David.Nieto@a=
md.com>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios

Mesa doesn't use sysfs.

Note that this is a uapi, meaning that once it's in the kernel, it can't be=
 changed like that.

What's the use case for this new interface? Isn't it partially redundant wi=
th the current device info structure, which seems to have the equivalent of=
 dev_id and rev_id?

Marek

On Tue, May 11, 2021 at 3:51 AM Christian K=F6nig <ckoenig.leichtzumerken@g=
mail.com<mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
Marek and other userspace folks need to decide that.

Basic question here is if Mesa is already accessing sysfs nodes for OpenGL =
or RADV. If that is the case then we should probably expose the information=
 there as well.

If that isn't the case (which I think it is) then we should implement it as=
 IOCTL.

Regards,
Christian.

Am 10.05.21 um 22:19 schrieb Nieto, David M:

One of the primary usecases is to add this information to the renderer stri=
ng, I am not sure if there are other cases of UMD drivers accessing sysfs n=
odes, but I think if we think permissions, if a client is authenticated and=
 opens the render device then it can use the IOCTL, it is unclear to me we =
can make a such an assumption for sysfs nodes=85



I think there is value in having both tbh.



Regards,

David



From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.l=
eichtzumerken@gmail.com>
Date: Monday, May 10, 2021 at 6:48 AM
To: "Nieto, David M" <David.Nieto@amd.com><mailto:David.Nieto@amd.com>, "Gu=
, JiaWei (Will)" <JiaWei.Gu@amd.com><mailto:JiaWei.Gu@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com><mailto:alexdeucher@gmail.com>, "De=
ng, Emily" <Emily.Deng@amd.com><mailto:Emily.Deng@amd.com>, Kees Cook <kees=
cook@chromium.org><mailto:keescook@chromium.org>, amd-gfx list <amd-gfx@lis=
ts.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios



Well we could add both as sysfs file(s).

Question here is rather what is the primary use case of this and if the app=
lication has the necessary access permissions to the sysfs files?

Regards,
Christian.

Am 10.05.21 um 15:42 schrieb Nieto, David M:

Then the application would need to issue the ioctl and then open a sysfs fi=
le to get all the information it needs. It makes little sense from a progra=
mming perspective to add an incomplete interface in my opinion



________________________________

From: Gu, JiaWei (Will) <JiaWei.Gu@amd.com><mailto:JiaWei.Gu@amd.com>
Sent: Monday, May 10, 2021 12:13:07 AM
To: Nieto, David M <David.Nieto@amd.com><mailto:David.Nieto@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com><mailto:alexdeucher@gmail.com>; amd=
-gfx list <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.=
org>; Kees Cook <keescook@chromium.org><mailto:keescook@chromium.org>; Deng=
, Emily <Emily.Deng@amd.com><mailto:Emily.Deng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios



[AMD Official Use Only - Internal Distribution Only]

Hi David,

What I meant is to ONLY delete the serial[16] from drm_amdgpu_info_vbios, n=
ot the whole struct.

struct drm_amdgpu_info_vbios {
        __u8 name[64];
        __u32 dbdf;
        __u8 vbios_pn[64];
        __u32 version;
        __u8 date[32];
        __u8 serial[16]; // jiawei: shall we delete this
        __u32 dev_id;
        __u32 rev_id;
        __u32 sub_dev_id;
        __u32 sub_ved_id;
};

serial[16] in drm_amdgpu_info_vbios  copied from adev->serial, but there's =
already a sysfs named serial_number, which exposes it already.

static ssize_t amdgpu_device_get_serial_number(struct device *dev,
                struct device_attribute *attr, char *buf)
{
        struct drm_device *ddev =3D dev_get_drvdata(dev);
        struct amdgpu_device *adev =3D ddev->dev_private;

        return snprintf(buf, PAGE_SIZE, "%s\n", adev->serial);
}

Thanks,
Jiawei


-----Original Message-----
From: Nieto, David M <David.Nieto@amd.com><mailto:David.Nieto@amd.com>
Sent: Monday, May 10, 2021 2:53 PM
To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com><mailto:JiaWei.Gu@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com><mailto:alexdeucher@gmail.com>; amd=
-gfx list <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.=
org>; Kees Cook <keescook@chromium.org><mailto:keescook@chromium.org>; Deng=
, Emily <Emily.Deng@amd.com><mailto:Emily.Deng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios

No, this structure contains all the details of the vbios: date, serial numb=
er, name, etc.

The sysfs node only contains the vbios name string

> On May 9, 2021, at 23:33, Gu, JiaWei (Will) <JiaWei.Gu@amd.com><mailto:Ji=
aWei.Gu@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> With a second thought,
> __u8 serial[16] in drm_amdgpu_info_vbios is a bit redundant, sysfs serial=
_number already exposes it.
>
> Is it fine to abandon it from drm_amdgpu_info_vbios struct? @Alex
> Deucher @Nieto, David M
>
> Best regards,
> Jiawei
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com><mailto:alexdeucher@gmail.com>
> Sent: Sunday, May 9, 2021 11:59 PM
> To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com><mailto:JiaWei.Gu@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.fre=
edesktop.org>; Kees Cook
> <keescook@chromium.org><mailto:keescook@chromium.org>
> Subject: Re: [PATCH] drm/amdgpu: Align serial size in
> drm_amdgpu_info_vbios
>
>> On Sat, May 8, 2021 at 2:48 AM Jiawei Gu <Jiawei.Gu@amd.com><mailto:Jiaw=
ei.Gu@amd.com> wrote:
>>
>> 20 should be serial char size now instead of 16.
>>
>> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com><mailto:Jiawei.Gu@amd.com>
>
> Please make sure this keeps proper 64 bit alignment in the structure.
>
> Alex
>
>
>> ---
>> include/uapi/drm/amdgpu_drm.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h
>> b/include/uapi/drm/amdgpu_drm.h index 2b487a8d2727..1c20721f90da
>> 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {
>>        __u8 vbios_pn[64];
>>        __u32 version;
>>        __u8 date[32];
>> -       __u8 serial[16];
>> +       __u8 serial[20];
>>        __u32 dev_id;
>>        __u32 rev_id;
>>        __u32 sub_dev_id;
>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis
>> t
>> s.freedesktop.org<https://nam11.safelinks.protection.outlook.com/?url=3D=
http%3A%2F%2Fs.freedesktop.org%2F&data=3D04%7C01%7Calexander.deucher%40amd.=
com%7C3503a51f2fa04376040b08d914558033%7C3dd8961fe4884e608e11a82d994e183d%7=
C0%7C0%7C637563179729003008%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ=
QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3D5c730zpnFFOm3Ega=
bDFoiYlsl2tsaxImaTlVfap%2BfHQ%3D&reserved=3D0>%2Fmailman%2Flistinfo%2Famd-g=
fx&amp;data=3D04%7C01%7CJ
>> i
>> awei.Gu%40amd.com<https://nam11.safelinks.protection.outlook.com/?url=3D=
http%3A%2F%2F40amd.com%2F&data=3D04%7C01%7Calexander.deucher%40amd.com%7C35=
03a51f2fa04376040b08d914558033%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7=
C637563179729003008%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l=
uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DFzFHfe095%2FDzOYR%2BZ3tA=
zlF2wDRYsD5kOt%2Bf37nNVP4%3D&reserved=3D0>%7Ccea31833184c41e8574508d9130360=
cc%7C3dd8961fe4884e
>> 6
>> 08e11a82d994e183d%7C0%7C0%7C637561727523880356%7CUnknown%7CTWFpbGZsb3
>> d
>> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
>> C
>> 1000&amp;sdata=3DkAJiC6WoJUTeExwk6ftrLfMoY2OTAwg9X7mGgJT3kLk%3D&amp;res
>> e
>> rved=3D0



_______________________________________________

amd-gfx mailing list

amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>

https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7Calexander.deucher%40amd.com%7C35=
03a51f2fa04376040b08d914558033%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7=
C637563179729012969%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l=
uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DGA4tfIXNrbU98WUMQl%2Bkd2=
8DyNgqjlZcIAryQtVIn%2Bw%3D&reserved=3D0>



_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7Calexander.deucher%40amd.com%7C35=
03a51f2fa04376040b08d914558033%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7=
C637563179729012969%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l=
uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DGA4tfIXNrbU98WUMQl%2Bkd2=
8DyNgqjlZcIAryQtVIn%2Bw%3D&reserved=3D0>

--_000_MN2PR12MB4488E0D428871797E08DEE2BF7539MN2PR12MB4488namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
It's being used by umr and some other smi tools to provide vbios informatio=
n for debugging.</div>
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
ounces@lists.freedesktop.org&gt; on behalf of Marek Ol=9A=E1k &lt;maraeo@gm=
ail.com&gt;<br>
<b>Sent:</b> Tuesday, May 11, 2021 4:18 AM<br>
<b>To:</b> Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Cc:</b> Kees Cook &lt;keescook@chromium.org&gt;; Gu, JiaWei (Will) &lt;J=
iaWei.Gu@amd.com&gt;; amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; D=
eng, Emily &lt;Emily.Deng@amd.com&gt;; Alex Deucher &lt;alexdeucher@gmail.c=
om&gt;; Nieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">
<div>Mesa doesn't use sysfs.</div>
<div><br>
</div>
<div>Note that this is a uapi, meaning that once it's in the kernel, it can=
't be changed like that.<br>
</div>
<div><br>
</div>
<div>What's the use case for this new interface? Isn't it partially redunda=
nt with the current device info structure, which seems to have the equivale=
nt of dev_id and rev_id?<br>
</div>
<div><br>
</div>
<div>Marek<br>
</div>
</div>
<br>
<div class=3D"x_gmail_quote">
<div dir=3D"ltr" class=3D"x_gmail_attr">On Tue, May 11, 2021 at 3:51 AM Chr=
istian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" targ=
et=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br>
</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0px 0px 0px 0.8ex; bord=
er-left:1px solid rgb(204,204,204); padding-left:1ex">
<div>Marek and other userspace folks need to decide that.<br>
<br>
Basic question here is if Mesa is already accessing sysfs nodes for OpenGL =
or RADV. If that is the case then we should probably expose the information=
 there as well.<br>
<br>
If that isn't the case (which I think it is) then we should implement it as=
 IOCTL.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<div>Am 10.05.21 um 22:19 schrieb Nieto, David M:<br>
</div>
<blockquote type=3D"cite">
<div>
<p class=3D"x_MsoNormal">One of the primary usecases is to add this informa=
tion to the renderer string, I am not sure if there are other cases of UMD =
drivers accessing sysfs nodes, but I think if we think permissions, if a cl=
ient is authenticated and opens the
 render device then it can use the IOCTL, it is unclear to me we can make a=
 such an assumption for sysfs nodes=85<u></u><u></u></p>
<p class=3D"x_MsoNormal"><u></u>&nbsp;<u></u></p>
<p class=3D"x_MsoNormal">I think there is value in having both tbh.<u></u><=
u></u></p>
<p class=3D"x_MsoNormal"><u></u>&nbsp;<u></u></p>
<p class=3D"x_MsoNormal">Regards,<u></u><u></u></p>
<p class=3D"x_MsoNormal">David<u></u><u></u></p>
<p class=3D"x_MsoNormal"><u></u>&nbsp;<u></u></p>
<div style=3D"border-color:rgb(181,196,223) currentcolor currentcolor; bord=
er-style:solid none none; border-width:1pt medium medium; padding:3pt 0in 0=
in">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:12pt; color:black">Fro=
m: </span>
</b><span style=3D"font-size:12pt; color:black">Christian K=F6nig <a href=
=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">
&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
<b>Date: </b>Monday, May 10, 2021 at 6:48 AM<br>
<b>To: </b>&quot;Nieto, David M&quot; <a href=3D"mailto:David.Nieto@amd.com=
" target=3D"_blank">
&lt;David.Nieto@amd.com&gt;</a>, &quot;Gu, JiaWei (Will)&quot; <a href=3D"m=
ailto:JiaWei.Gu@amd.com" target=3D"_blank">
&lt;JiaWei.Gu@amd.com&gt;</a><br>
<b>Cc: </b>Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com" target=3D"=
_blank">&lt;alexdeucher@gmail.com&gt;</a>, &quot;Deng, Emily&quot;
<a href=3D"mailto:Emily.Deng@amd.com" target=3D"_blank">&lt;Emily.Deng@amd.=
com&gt;</a>, Kees Cook
<a href=3D"mailto:keescook@chromium.org" target=3D"_blank">&lt;keescook@chr=
omium.org&gt;</a>, amd-gfx list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">&lt;amd-=
gfx@lists.freedesktop.org&gt;</a><br>
<b>Subject: </b>Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios<u></u><u></u></span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><u></u>&nbsp;<u></u></p>
</div>
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12pt">Well we could add bot=
h as sysfs file(s).<br>
<br>
Question here is rather what is the primary use case of this and if the app=
lication has the necessary access permissions to the sysfs files?<br>
<br>
Regards,<br>
Christian.<u></u><u></u></p>
<div>
<p class=3D"x_MsoNormal">Am 10.05.21 um 15:42 schrieb Nieto, David M:<u></u=
><u></u></p>
</div>
<blockquote style=3D"margin-top:5pt; margin-bottom:5pt">
<div>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"background:white none repeat scroll 0% 0%=
"><span style=3D"color:black">Then the application would need to issue the =
ioctl and then open a sysfs file to get all the information it needs. It ma=
kes little sense from a programming perspective
 to add an incomplete interface in my opinion&nbsp;<u></u><u></u></span></p=
>
</div>
</div>
<div>
<p class=3D"x_MsoNormal"><u></u>&nbsp;<u></u></p>
</div>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr width=3D"100%" size=3D"0" align=3D"center">
</div>
<div id=3D"x_gmail-m_782079725653541167gmail-m_3184748164637597930gmail-m_-=
3452308432024396062divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> Gu, JiaWei (Will)
<a href=3D"mailto:JiaWei.Gu@amd.com" target=3D"_blank">&lt;JiaWei.Gu@amd.co=
m&gt;</a><br>
<b>Sent:</b> Monday, May 10, 2021 12:13:07 AM<br>
<b>To:</b> Nieto, David M <a href=3D"mailto:David.Nieto@amd.com" target=3D"=
_blank">&lt;David.Nieto@amd.com&gt;</a><br>
<b>Cc:</b> Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com" target=3D"=
_blank">&lt;alexdeucher@gmail.com&gt;</a>; amd-gfx list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">&lt;amd-=
gfx@lists.freedesktop.org&gt;</a>; Kees Cook
<a href=3D"mailto:keescook@chromium.org" target=3D"_blank">&lt;keescook@chr=
omium.org&gt;</a>; Deng, Emily
<a href=3D"mailto:Emily.Deng@amd.com" target=3D"_blank">&lt;Emily.Deng@amd.=
com&gt;</a><br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios</span>
<u></u><u></u></p>
<div>
<p class=3D"x_MsoNormal">&nbsp;<u></u><u></u></p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
Hi David,<br>
<br>
What I meant is to ONLY delete the serial[16] from drm_amdgpu_info_vbios, n=
ot the whole struct.<br>
<br>
struct drm_amdgpu_info_vbios {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 name[64];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dbdf;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_pn[64];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 date[32];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 serial[16]; // jiawei: shal=
l we delete this<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dev_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 rev_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_dev_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_ved_id;<br>
};<br>
<br>
serial[16] in drm_amdgpu_info_vbios&nbsp; copied from adev-&gt;serial, but =
there's already a sysfs named serial_number, which exposes it already.<br>
<br>
static ssize_t amdgpu_device_get_serial_number(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct device_attribute *attr, char *buf)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D dev_=
get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D d=
dev-&gt;dev_private;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, =
&quot;%s\n&quot;, adev-&gt;serial);<br>
}<br>
<br>
Thanks,<br>
Jiawei<br>
<br>
<br>
-----Original Message-----<br>
From: Nieto, David M <a href=3D"mailto:David.Nieto@amd.com" target=3D"_blan=
k">&lt;David.Nieto@amd.com&gt;</a>
<br>
Sent: Monday, May 10, 2021 2:53 PM<br>
To: Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.Gu@amd.com" target=3D"_blank=
">&lt;JiaWei.Gu@amd.com&gt;</a><br>
Cc: Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com" target=3D"_blank"=
>&lt;alexdeucher@gmail.com&gt;</a>; amd-gfx list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">&lt;amd-=
gfx@lists.freedesktop.org&gt;</a>; Kees Cook
<a href=3D"mailto:keescook@chromium.org" target=3D"_blank">&lt;keescook@chr=
omium.org&gt;</a>; Deng, Emily
<a href=3D"mailto:Emily.Deng@amd.com" target=3D"_blank">&lt;Emily.Deng@amd.=
com&gt;</a><br>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios=
<br>
<br>
No, this structure contains all the details of the vbios: date, serial numb=
er, name, etc.<br>
<br>
The sysfs node only contains the vbios name string<br>
<br>
&gt; On May 9, 2021, at 23:33, Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.G=
u@amd.com" target=3D"_blank">
&lt;JiaWei.Gu@amd.com&gt;</a> wrote:<br>
&gt; <br>
&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt; <br>
&gt; With a second thought,<br>
&gt; __u8 serial[16] in drm_amdgpu_info_vbios is a bit redundant, sysfs ser=
ial_number already exposes it.<br>
&gt; <br>
&gt; Is it fine to abandon it from drm_amdgpu_info_vbios struct? @Alex <br>
&gt; Deucher @Nieto, David M<br>
&gt; <br>
&gt; Best regards,<br>
&gt; Jiawei<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com" target=3D"=
_blank">&lt;alexdeucher@gmail.com&gt;</a><br>
&gt; Sent: Sunday, May 9, 2021 11:59 PM<br>
&gt; To: Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.Gu@amd.com" target=3D"_=
blank">&lt;JiaWei.Gu@amd.com&gt;</a><br>
&gt; Cc: amd-gfx list <a href=3D"mailto:amd-gfx@lists.freedesktop.org" targ=
et=3D"_blank">
&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Kees Cook <br>
&gt; <a href=3D"mailto:keescook@chromium.org" target=3D"_blank">&lt;keescoo=
k@chromium.org&gt;</a><br>
&gt; Subject: Re: [PATCH] drm/amdgpu: Align serial size in <br>
&gt; drm_amdgpu_info_vbios<br>
&gt; <br>
&gt;&gt; On Sat, May 8, 2021 at 2:48 AM Jiawei Gu <a href=3D"mailto:Jiawei.=
Gu@amd.com" target=3D"_blank">
&lt;Jiawei.Gu@amd.com&gt;</a> wrote:<br>
&gt;&gt; <br>
&gt;&gt; 20 should be serial char size now instead of 16.<br>
&gt;&gt; <br>
&gt;&gt; Signed-off-by: Jiawei Gu <a href=3D"mailto:Jiawei.Gu@amd.com" targ=
et=3D"_blank">&lt;Jiawei.Gu@amd.com&gt;</a><br>
&gt; <br>
&gt; Please make sure this keeps proper 64 bit alignment in the structure.<=
br>
&gt; <br>
&gt; Alex<br>
&gt; <br>
&gt; <br>
&gt;&gt; ---<br>
&gt;&gt; include/uapi/drm/amdgpu_drm.h | 2 +-<br>
&gt;&gt; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/include/uapi/drm/amdgpu_drm.h <br>
&gt;&gt; b/include/uapi/drm/amdgpu_drm.h index 2b487a8d2727..1c20721f90da<b=
r>
&gt;&gt; 100644<br>
&gt;&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt; @@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_pn[64];<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 version;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 date[32];<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 serial[16];<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 serial[20];<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dev_id;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 rev_id;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_dev_id;<br>
&gt;&gt; --<br>
&gt;&gt; 2.17.1<br>
&gt;&gt; <br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank"=
>amd-gfx@lists.freedesktop.org</a><br>
&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Flis" target=3D"_blank">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis</a>=
<br>
&gt;&gt; t <br>
&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttp%3A%2F%2Fs.freedesktop.org%2F&amp;data=3D04%7C01%7Calexander.deucher%40a=
md.com%7C3503a51f2fa04376040b08d914558033%7C3dd8961fe4884e608e11a82d994e183=
d%7C0%7C0%7C637563179729003008%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D5c730zpnF=
FOm3EgabDFoiYlsl2tsaxImaTlVfap%2BfHQ%3D&amp;reserved=3D0" originalsrc=3D"ht=
tp://s.freedesktop.org/" shash=3D"btj7NLDddPgpMAMLB3quP6ykf2ispDn5lwhdGkwRI=
rZZVTyHyNq1ssBpJhnsN4laG44hB4T0TgfxG02TLc3I6IjzSHPptuHwBRq9Sp6n9Q/XMg8Ct49C=
m1151nK1BGGldJQWTEAuULIrh/XGNTux7Thy4JSZ7ROPWWOrUswWfPk=3D" target=3D"_blan=
k">
s.freedesktop.org</a>%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01=
%7CJ<br>
&gt;&gt; i<br>
&gt;&gt; awei.Gu%<a href=3D"https://nam11.safelinks.protection.outlook.com/=
?url=3Dhttp%3A%2F%2F40amd.com%2F&amp;data=3D04%7C01%7Calexander.deucher%40a=
md.com%7C3503a51f2fa04376040b08d914558033%7C3dd8961fe4884e608e11a82d994e183=
d%7C0%7C0%7C637563179729003008%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DFzFHfe095=
%2FDzOYR%2BZ3tAzlF2wDRYsD5kOt%2Bf37nNVP4%3D&amp;reserved=3D0" originalsrc=
=3D"http://40amd.com/" shash=3D"cf/ygK275ZVbFfF5lVmCbvCl/B6PwIUkYnUG9wgvvtw=
cT2mXzRcsorOK9cwk01GKm9po/lqDU+gc9/3q+tUApaBm9jr04e4tQJONRS9Cx/Fdk4qcFUfsqB=
F1b9BLLYuiTck/Wc+Ck9ZATqKU0mMol8jES2vgx8WcF8g28sj3Zc0=3D" target=3D"_blank"=
>40amd.com</a>%7Ccea31833184c41e8574508d9130360cc%7C3dd8961fe4884e<br>
&gt;&gt; 6 <br>
&gt;&gt; 08e11a82d994e183d%7C0%7C0%7C637561727523880356%7CUnknown%7CTWFpbGZ=
sb3<br>
&gt;&gt; d <br>
&gt;&gt; 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3=
D%7<br>
&gt;&gt; C <br>
&gt;&gt; 1000&amp;amp;sdata=3DkAJiC6WoJUTeExwk6ftrLfMoY2OTAwg9X7mGgJT3kLk%3=
D&amp;amp;res<br>
&gt;&gt; e<br>
&gt;&gt; rved=3D0<u></u><u></u></p>
</div>
</div>
<p class=3D"x_MsoNormal"><br>
<br>
<u></u><u></u></p>
<pre>_______________________________________________<u></u><u></u></pre>
<pre>amd-gfx mailing list<u></u><u></u></pre>
<pre><a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd=
-gfx@lists.freedesktop.org</a><u></u><u></u></pre>
<pre><a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04=
%7C01%7Calexander.deucher%40amd.com%7C3503a51f2fa04376040b08d914558033%7C3d=
d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563179729012969%7CUnknown%7CTWF=
pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D=
%7C1000&amp;sdata=3DGA4tfIXNrbU98WUMQl%2Bkd28DyNgqjlZcIAryQtVIn%2Bw%3D&amp;=
reserved=3D0" originalsrc=3D"https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx" shash=3D"t9pEoIbGR/QdCWU78obt+C/sor4AByekPVkQZPvb6duz54OJw/r6a/+7=
5rBqHRpRw7idemSamNqzLoxesO+7RfIFrwyePU1Pbpr+go0REFs637qa4YUetwBREc5Ilu6Qsy5=
QX9jw41+/xFzr9+NOAGQBImNZ7pzucKWWycA5vVs=3D" target=3D"_blank">https://list=
s.freedesktop.org/mailman/listinfo/amd-gfx</a><u></u><u></u></pre>
</blockquote>
<p class=3D"x_MsoNormal"><br>
<br>
<u></u><u></u></p>
</div>
</blockquote>
<br>
</div>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01=
%7Calexander.deucher%40amd.com%7C3503a51f2fa04376040b08d914558033%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637563179729012969%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10=
00&amp;sdata=3DGA4tfIXNrbU98WUMQl%2Bkd28DyNgqjlZcIAryQtVIn%2Bw%3D&amp;reser=
ved=3D0" originalsrc=3D"https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx" shash=3D"t9pEoIbGR/QdCWU78obt+C/sor4AByekPVkQZPvb6duz54OJw/r6a/+75rBqH=
RpRw7idemSamNqzLoxesO+7RfIFrwyePU1Pbpr+go0REFs637qa4YUetwBREc5Ilu6Qsy5QX9jw=
41+/xFzr9+NOAGQBImNZ7pzucKWWycA5vVs=3D" rel=3D"noreferrer" target=3D"_blank=
">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</blockquote>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB4488E0D428871797E08DEE2BF7539MN2PR12MB4488namp_--

--===============0482945632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0482945632==--
