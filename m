Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF92C4345F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 08:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC64C11221C;
	Mon,  6 May 2024 08:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ET3gXgDK";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 219C011221C
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 08:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSH/Heii9cIRqiWOypYGfQKZrn0ljoUFQcSHfb0fuKD23sUXh8v7oyHIyX6eNEEHyof43+GzabB+CVFJ2hw4eTduMreapBRQC+tm6IlWkM+EC04IoAL40xf6sKGszDi9sYPQLAGAOczdfqzufWgEFKXnH6+FhMSKvs/GipXZPoNpo311GFB8/kDEMQqtSpvLu8fh1EVQbcV7H/0vHMYnL+4Db4jBeklHe/NShPLV+kbsdMX4q+carT4FKGeOw8db31/qSpoVkhZVPcv1zvMf+6m+TcwFnX+bfpzkKV1fg6qrZkRRKPR1eEE/kxcxjKsxqg/bKqDgO5YjWLWnOwAIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGqCIbHxRociSTHFUlSJkAdtZPYM6Fr/j4uoDUetz1Y=;
 b=bXLECU4U0yhQ+CzRB0XQFg+YM3z4r0NRgGuYDRx4h/+1xUU3Unvox9h+PYXwuxifC1GkXN3df1tsggG11JhX+EaSbbskyXbdY++Yges81RcnPTNRtOlhsnO530wVQ1kt+ekTV43LIk/7asopsI8LtdwvroN/DFwDA9iyoUfsaxDXjA3ac7l2hnDnPgNn9iWslXA42nyO3B4E8+g+RjEJfHrKN6oCjhN9zwJ574RzvCr2xIflN/2jOrffmOPyupYaYIr0w+R9SVWB+/fwCk7kODp11H39mZBPBpgXrFNglK4U6e1WPlTQMmGIn/zQ4rZzaxJ4r1ko5ovpb7/Q4txQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGqCIbHxRociSTHFUlSJkAdtZPYM6Fr/j4uoDUetz1Y=;
 b=ET3gXgDKKX0QBcHc1WJ33/Xw7vpyxCxffprzfi3D+xd139Ox109L7XT2I9sNeMbVp3nPUh5btpv+cKCjIAY50ulrUyExR+gWcSH+eC/HsrxJT7gk73hZvVhGlMtQmeVQ/AIlNCJuWyudTB+QmvjkKL6M3gNUkYk1x1RpV69myzw=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 08:16:59 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 08:16:59 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Aldabagh, Maad"
 <Maad.Aldabagh@amd.com>, "Ma, Qing (Mark)" <Qing.Ma@amd.com>, "Li, Yunxiang
 (Teddy)" <Yunxiang.Li@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu: use the default reset for ras recovery
Thread-Topic: [PATCH 2/2] drm/amd/amdgpu: use the default reset for ras
 recovery
Thread-Index: AQHamgdH8C+QpXQhDkegr1Uk0YVyK7F+5pzQgAr8c6s=
Date: Mon, 6 May 2024 08:16:59 +0000
Message-ID: <DM4PR12MB5937E1C985C21BCDC3C96FE9E51C2@DM4PR12MB5937.namprd12.prod.outlook.com>
References: <20240429073132.12611-1-kenneth.feng@amd.com>
 <20240429073132.12611-2-kenneth.feng@amd.com>
 <DM4PR12MB51656C0277435B3DB92BBE608E1B2@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51656C0277435B3DB92BBE608E1B2@DM4PR12MB5165.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com,Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-29T08:15:01.0000000Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|MW6PR12MB8951:EE_
x-ms-office365-filtering-correlation-id: 8bcb71bb-8821-410e-453b-08dc6da4e694
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?Windows-1252?Q?4KAvLSXXzLdZadmStYDLTsQ8qVOdTnfvu6zTpJJZk0LsxZ4d6yppdu+o?=
 =?Windows-1252?Q?+u/4kzAxhK/z14Nx3xjNDoq0GNGWwCKcWsvSWLR7hqrUNkQ6yh7L86QI?=
 =?Windows-1252?Q?nyJv7bodp31/JNtlKKtvjChkbPDB3dhFzDXTgMtpxY3vCpmEBBxNzfnX?=
 =?Windows-1252?Q?mUNEDjPiG4Sj+O8OZvAqreGTHl1wLp70AsaBcCZZGLzjZ2/qxG6es0c7?=
 =?Windows-1252?Q?09WAuwISxm2Cq2L+qUsqt6Sm4MZ0ajIB6exZiBr2z42IV+5nN+UnO10o?=
 =?Windows-1252?Q?XZj3rtbyLp2q4x9jZz0kDmITVEC94rvdyLcaks/Y7zQ0uIOoVJZxUfCy?=
 =?Windows-1252?Q?fpFdM1Bfw1zg6+dQL2YswtLa4uWoRhwMR017qyo6V+8BIyBvFqg1jpSx?=
 =?Windows-1252?Q?LZfQ+FXTWZAN5AG//pdBlEKZ0hsmckpo8rGHqsXudQwuBGlozJn9WxbT?=
 =?Windows-1252?Q?mRP9iBstPuP77z+R8LHOIxEriUkH9R38hwLH0IBF/QfH5RMDKX/aN7Tg?=
 =?Windows-1252?Q?yM31/kSVDNl8WHztrmwbH0ZVtfnQDek1rJagrsbAS7WszdeyzuH3UcX6?=
 =?Windows-1252?Q?i70FnAAqwAIB7W7xOKCxEgCcZADwinLQ3T/5curryyksoAEj50sdq+PB?=
 =?Windows-1252?Q?mir9esHcJvC5WQbJazb69wo/Kls5fMkYJBur9pzw3Z5ruJVcVkENjom9?=
 =?Windows-1252?Q?VHwiaxJf3sNcXiFffl0mfHBeHSA8s9w7QWw2yQ9KzO9lnjMZzoCItQ98?=
 =?Windows-1252?Q?Er8ZwLN4M9+jKTc4LN9V80vneMxEIZvORL6rSZAuz2nHY11XVRDQOvEU?=
 =?Windows-1252?Q?byC8ulb6s3bMHUMuCEeXXkXGKOOq0TnTVzuCPThuEAzfB/c+DsaMrB8y?=
 =?Windows-1252?Q?nnWeXFLfF2dkR7ZHC3eqHdm1tjOZi+dcwRq/Y8fwbWws3sAqFlns0sjX?=
 =?Windows-1252?Q?2PcjUqdf3MTiVJaiN6q1kEwjpoJWcp/0/kIKXZmVDv1P211MPqrqXWQJ?=
 =?Windows-1252?Q?eZKjtV7h9GRJohzGdfGx3dk8mVzHEC7o5G04/rRNI7aFHhVqB1GCG3sU?=
 =?Windows-1252?Q?J24q1YmVyaPac3YM9UJZpYZll4F8FriykTTEjVnG7WCbdCnJ9kkIocmD?=
 =?Windows-1252?Q?J9yMpgHogqGoTAh5d7mzYkNKJQmPq4AJSVdpUQACpgoRvNIHxaUpV8Bx?=
 =?Windows-1252?Q?u8vvEIuEylIlX4pkteNTXy4cGdhWfp/2MxEV/16mSBIR8q1Z+UwRr5EZ?=
 =?Windows-1252?Q?Xi4ECGlcwx7D8LOSLbxs5PqcIw+qCOQ2my6mXke0MCZ2fMg9jRmuXWQS?=
 =?Windows-1252?Q?QNiB0P9iDc6aPGRmd2FAhyY/x6go9f/BeZ6FC+O72LiAfgmUHo/hM8zP?=
 =?Windows-1252?Q?4i2SVGbON4e9SFJnKaNAFhcY1PBMu1yEas6OLp6YE+zpSI/tS9D2GhVr?=
 =?Windows-1252?Q?P7edxQceisZuVBl91IvC9w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?obVF1lNlsKC8PgDGq4rDfmI8vG8mlvWQRlAOSuF7BjubDtBojCBzIktw?=
 =?Windows-1252?Q?zJZ5jZkGbdWrE/z72BuxqmxE8+p/njvoPN80DUruSYI8nZcrdyXvk0hf?=
 =?Windows-1252?Q?EmezFWjwfE49fPDVsI7F2zBpbDLrZ96KyoanvTTBTHcZpzB1BkDVguZ6?=
 =?Windows-1252?Q?gV1qwBm3tLTVtUX2sqO9uHuouzogp3iOp2kZ7q5Bo/QOyFNkolitCSX3?=
 =?Windows-1252?Q?bUSeQWx+CWt7bC8p/p1gK2z6U9cC/jXiAZw+5pBSl5NlXBpkSAyr16dG?=
 =?Windows-1252?Q?kD/N5FLSg6shN+PBKR+vwfQtdrM6INgWMvHhnNbQEfBhFfCvhtLPr7d/?=
 =?Windows-1252?Q?s6cZb7NVUctV+YYJJFUmb3rIgDzIevzMPiieMK4f8Cu5K+iNdbXxhhoN?=
 =?Windows-1252?Q?vWMDImprdXWVbNYOEe1BOMpFDzamCl7mjJO+rKyw/ACZ/yFV9xU/ppUp?=
 =?Windows-1252?Q?SmaP1nhbBbEtqCcKvZ0HTW9LA5s3W96Q+L09df3QHvPqu1iA7ENCNvDT?=
 =?Windows-1252?Q?bhZ/FYfZz4+fbu/mabyv/02YtkAIAn6pMTNq3LrVtKp9EMWqyfOaQrho?=
 =?Windows-1252?Q?i/4bnhhVtnigUOX+FP7CyqjNVzlCrncpcRaTANISsbLz5sZpk7xmoKI6?=
 =?Windows-1252?Q?qPtNQfSyxX2oVIGWYuW3fFsq2SlmJhYlyqWTIkuKBHvjfdBZ4FApwR5d?=
 =?Windows-1252?Q?tRcU8ZuaD+85bOdGA54kS6UCjFOpc8uI5CXd66/skYqoxy/xd8WfKkJp?=
 =?Windows-1252?Q?qes93IVWMYvWv8zmpo/hm4LoYyuA6LaGUMsgSD7mdYnSfm1UL3NJgkgH?=
 =?Windows-1252?Q?1wulO7k1BLW0X2GrUMFfVGsiVoZ4GoTHuEVdLaR9K1ucXa77uNsVW0vX?=
 =?Windows-1252?Q?I+elQQjlM3iC+yfzM5wJBPY+6m4OWwlG1ShQD/leI04XhZcIMXH4hBcT?=
 =?Windows-1252?Q?b6XBIO3aS3Iakb+nhGIsnkLvlHRaYhtgBQ1QraZQoEq6RctO9nYNN6ff?=
 =?Windows-1252?Q?012WpxTTA5BG1hS+aInA5HnqAouMh33mAjXclBbg9t7Jh+aHxS+1g5PK?=
 =?Windows-1252?Q?L6TcI8Hjk8M9RCw35BWmyADC4Y7AsTTJRXlHm19wmg740YNVi0MxS3Hb?=
 =?Windows-1252?Q?eDDDxI2v5ON3OzRDRehN+REakHKJhqIhvInN1LceDNJLCAd2lJ8C3JHJ?=
 =?Windows-1252?Q?LDFXUO6DgP1nXEy5//wDcq9Jd/6RZWzwJeo9VHyjfCzPirV/iyVSK+9O?=
 =?Windows-1252?Q?CpjxRkUqebHfBsnA1yPBUpA2jTmU+rfXW8xgXaH0aP3oCkPyS8hkBEYK?=
 =?Windows-1252?Q?MybHhBEiFZdzMka7eawAgirdIIm17KMUOurfHtnnf8oYwUA2YcPruSoq?=
 =?Windows-1252?Q?YzWax2SzyZqWePyxHTJVYETYKv7zGd54H5fG9zfNnpDu2i8iJVjxkw2E?=
 =?Windows-1252?Q?yzK9LWYpfe5FfQawzuux/JNFQG4JRsknq/KPOAv9/jx4+5pdMPzHAXPz?=
 =?Windows-1252?Q?kVUvUIc055woeNXzG1eeriCxYEBu5y4MulRVNgb85xZ11mQUcHIPAJ7I?=
 =?Windows-1252?Q?DAAhuxBZA0aFShI1qMHs38yh3HqJiqTIN55gv7jqR3uNBq9M9atoNOfy?=
 =?Windows-1252?Q?6mPzSXcFfbq8B+IWt3S05tnEuWtWM1UtaPhPn1ot7N+vBI60EU0gSkGr?=
 =?Windows-1252?Q?KIxRcIST9xMxOmb00NBH3kG+ydx2HcQfEqSQ9LIGYdqC6GQd+9X9hw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5937E1C985C21BCDC3C96FE9E51C2DM4PR12MB5937namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcb71bb-8821-410e-453b-08dc6da4e694
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 08:16:59.0195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5li8ouq3Wol3PwqJ8543g6YM+pBpIAt5lzM+I0BCxpaRYZyo9ery5+OpArK3uu7Mri9O7lN9+PcuGmBwh1IZ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5937E1C985C21BCDC3C96FE9E51C2DM4PR12MB5937namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Hi @Deucher, Alexander<mailto:Alexander.Deucher@amd.com> and @Koenig, Chris=
tian<mailto:Christian.Koenig@amd.com>

Could you help review this patch?
Without this patch, when customer set `reset_method=3D3` modprobe param to =
use mode2 reset, ras recovery will also use mode2 reset and skip mode1 rese=
t.
When ECC error happens, GPU can=92t be recovered with mode2 reset and mode1=
 reset is skipped, this will cause GPU reset failure.

This patch is to always use mode1 reset for ras recovery (ECC error) when s=
etting `reset_method=3D3`.

Thanks
Sam

From: Feng, Kenneth <Kenneth.Feng@amd.com>
Date: Monday, April 29, 2024 at 16:15
To: Feng, Kenneth <Kenneth.Feng@amd.com>, amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>, Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>
Cc: Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>, Aldabagh, Maad <Maad.Aldabagh@=
amd.com>, Ma, Qing (Mark) <Qing.Ma@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/amdgpu: use the default reset for ras reco=
very
[AMD Official Use Only - General]

+@Zhang, GuoQing (Sam)

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Monday, April 29, 2024 3:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>; Aldabagh, Maad <Maad.Aldabagh@=
amd.com>; Ma, Qing (Mark) <Qing.Ma@amd.com>; Feng, Kenneth <Kenneth.Feng@am=
d.com>
Subject: [PATCH 2/2] drm/amd/amdgpu: use the default reset for ras recovery

use the default reset for ras recovery

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index a037e8fba29f..f92b2c4f0d5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2437,6 +2437,7 @@ static void amdgpu_ras_do_recovery(struct work_struct=
 *work)
        struct amdgpu_device *adev =3D ras->adev;
        struct list_head device_list, *device_list_handle =3D  NULL;
        struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev);
+       int save_reset_method =3D amdgpu_reset_method;

        if (hive) {
                atomic_set(&hive->ras_recovery, 1);
@@ -2501,7 +2502,13 @@ static void amdgpu_ras_do_recovery(struct work_struc=
t *work)
                        }
                }

+               if (amdgpu_gpu_recovery =3D=3D 2)
+                       amdgpu_reset_method =3D -1;
+
                amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
+
+               if (amdgpu_gpu_recovery =3D=3D 2)
+                       amdgpu_reset_method =3D save_reset_method;
        }
        atomic_set(&ras->in_recovery, 0);
        if (hive) {
--
2.34.1

--_000_DM4PR12MB5937E1C985C21BCDC3C96FE9E51C2DM4PR12MB5937namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Hi
</span><span style=3D"font-family:&quot;Aptos&quot;,sans-serif"><a id=3D"OW=
AAMF8548CD07BB205478DF776E1014D2B98" href=3D"mailto:Alexander.Deucher@amd.c=
om"><span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration=
:none">@Deucher, Alexander</span></a></span><span lang=3D"EN-US" style=3D"f=
ont-family:&quot;Aptos&quot;,sans-serif">
 and <a id=3D"OWAAM645E9576D2BF254CB415F66326EABD7B" href=3D"mailto:Christi=
an.Koenig@amd.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Koenig, Christian</span></a></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Could you help review this patch?
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Without this patch, when customer set `reset_method=3D3=
` modprobe param to use mode2 reset, ras recovery will also use mode2 reset=
 and skip mode1 reset.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">When ECC error happens, GPU can=92t be recovered with m=
ode2 reset and mode1 reset is skipped, this will cause GPU reset failure.<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">This patch is to always use mode1 reset for ras recover=
y (ECC error) when setting `reset_method=3D3`.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Date: </b>Monday, April 29, 2024 at 16:15<br>
<b>To: </b>Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;, amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;, Zhang, GuoQing (Sam) &lt;G=
uoQing.Zhang@amd.com&gt;<br>
<b>Cc: </b>Zhang, Owen(SRDC) &lt;Owen.Zhang2@amd.com&gt;, Aldabagh, Maad &l=
t;Maad.Aldabagh@amd.com&gt;, Ma, Qing (Mark) &lt;Qing.Ma@amd.com&gt;<br>
<b>Subject: </b>RE: [PATCH 2/2] drm/amd/amdgpu: use the default reset for r=
as recovery<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><span style=3D"font-family:&quot;Times New Roman&quot;,serif">[AMD Offi=
cial Use Only - General]<br>
<br>
+@Zhang, GuoQing (Sam)<br>
<br>
-----Original Message-----<br>
From: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
Sent: Monday, April 29, 2024 3:32 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Owen(SRDC) &lt;Owen.Zhang2@amd.com&gt;; Aldabagh, Maad &lt;Maad.=
Aldabagh@amd.com&gt;; Ma, Qing (Mark) &lt;Qing.Ma@amd.com&gt;; Feng, Kennet=
h &lt;Kenneth.Feng@amd.com&gt;<br>
Subject: [PATCH 2/2] drm/amd/amdgpu: use the default reset for ras recovery=
<br>
<br>
use the default reset for ras recovery<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++<br>
&nbsp;1 file changed, 7 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index a037e8fba29f..f92b2c4f0d5c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -2437,6 +2437,7 @@ static void amdgpu_ras_do_recovery(struct work_struct=
 *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D r=
as-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head device_list, *d=
evice_list_handle =3D&nbsp; NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *hive =
=3D amdgpu_get_xgmi_hive(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int save_reset_method =3D amdgpu_rese=
t_method;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hive) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; atomic_set(&amp;hive-&gt;ras_recovery, 1);<br>
@@ -2501,7 +2502,13 @@ static void amdgpu_ras_do_recovery(struct work_struc=
t *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_gpu_recovery =3D=3D 2)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_met=
hod =3D -1;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_device_gpu_recover(ras-&gt;adev, NULL, &amp;reset_co=
ntext);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_gpu_recovery =3D=3D 2)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_met=
hod =3D save_reset_method;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;ras-&gt;in_recov=
ery, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hive) {<br>
--<br>
2.34.1</span><span style=3D"font-size:12.0pt;font-family:&quot;Times New Ro=
man&quot;,serif"><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5937E1C985C21BCDC3C96FE9E51C2DM4PR12MB5937namp_--
