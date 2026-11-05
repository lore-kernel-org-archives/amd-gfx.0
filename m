Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835CD606A326
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qcHDyDdJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20A6310E0A3;
	Thu,  5 Nov 2026 03:25:15 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013010.outbound.protection.outlook.com
 [40.93.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70A8210E0A3
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:25:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVg6Ej+jQFXM7GemzIC3I1+j/vlymm/NrmL+riBHhlKnbL5GyQFBJd2ndv+VBqizAgWjKTAKLfvV815yTrJUMmYdm2hUZnjHY6wg+pvarPUxwtQBHRKFEZn4NBQM/xAObt5bqnhf/AbzAXAzYCkKoK6AX1QpSykIrzn2RXA0iYK7xdRfZpnewdXRgIh4YjT4U8FUg+0Wmd/Y2cgiyzrmboqs8gLiM6HWRcBN0yif/SfGC8YrEZ2imqmR5ewqe7y7SszxsydHW7Pya0r42s6x7OF1L5ET8pduL5C5ojSAzXiebCrAZe2+e1QQlhI703KvTz75ei+41p4jVA0nEL44wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PibQ2w7AwZkA3+d5UMd7Y1snb9ZZZZDeA0sA3sCRBaE=;
 b=ZxzdalIVUpzxpqVAV+MHTCBRGebczglU9qy7SZHFC84n8je9BGLMWGLMg/b0l+nGPd68qdi0/y0cp/7quvwFzg2GwNMow5oJVIxbGaXOGDUgm1io+Z71B72+cl0/5xTRe0w6QDchuEr8bLwq0TdX5mNZ8CcfPU2MtTzjmbKoY1q1mN1oVMgbHExAEO+id1d4//S7fFoyzoHrbbJogrZbpIGJYgOPCAuiX7EhpM2gXOWTBeuZ1AwMbUJcZDn/2sm0BI+3ECpVOp77Xd2ybnqwHTtUJYqBYnHp9CBNIOt1sWR30Kc/MOm1keE1QczfyxctKQrf2/5wsuIkuW4HS7HHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PibQ2w7AwZkA3+d5UMd7Y1snb9ZZZZDeA0sA3sCRBaE=;
 b=qcHDyDdJvzG8K7aP11ple5wh0iNruhC5VtqUjS6YUzzecYd5S2/+oIXEYfw+sx90CjrHxdkMdhGIW9SGAHst/6i5vlTkfHHA+BhAbSU10hv0GC73FwKuQaoyxazYeuL3EXC07xUJ0p8buM0FZU3Il0sOYVsjJi9K2fmslfl9qEg=
Received: from CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 03:25:05 +0000
Received: from CH2PR12MB4168.namprd12.prod.outlook.com
 ([fe80::762:c8d0:c9ed:ebcd]) by CH2PR12MB4168.namprd12.prod.outlook.com
 ([fe80::762:c8d0:c9ed:ebcd%5]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 03:25:04 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdkfd: check CRIU SVM priv data bounds before
 allocating
Thread-Topic: [PATCH] drm/amdkfd: check CRIU SVM priv data bounds before
 allocating
Thread-Index: AQHdapgstc78wZz59UicwINawhHKHrce1LeAgAAAcOA=
Date: Thu, 5 Nov 2026 03:25:03 +0000
Message-ID: <CH2PR12MB416886AE6AD6E1ED2C9F65819C772@CH2PR12MB4168.namprd12.prod.outlook.com>
References: <20261102070227.2217976-1-perry.yuan@amd.com>
 <CY5PR12MB6369F84397F79AF295E20006C1772@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB6369F84397F79AF295E20006C1772@CY5PR12MB6369.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-05T03:22:38.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4168:EE_|PH7PR12MB8016:EE_
x-ms-office365-filtering-correlation-id: 5bff486d-ae66-454f-bd95-08df3aec6203
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|11063799006|4143699003|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: H5aqrmLEaYcwGKchU+YmRDrC1jOHFZFX2q39U2Jz8D4cMI54KzeL98XuO2ItwJR0agHp9lbfPZR34JgHCe5A+BzhmbLGzWlGP9DcTXQvztpib5sLDXhC0UKIdsU92Rfx/dGuKQC77FZ7CwxM4chlxCidbg7m7X8xawZ5P9H1MnG28fGm7hrtOrLsFN2Z9I+cEj3szRzVvK+2/KIJWxV94AwgL2mVXHdW34JPZKubugP6Z++AOvrK4jV0qedYLx7kh33IGcNdgFZzi65Eq4weNR2bhjUUkSz7sRefmbdbMGwtpwYwZvV0Pb2T6GA6SBWaUOawUunxOZHHmv9P+yorOgdggHg9pXMQnAwk647qMTUWWaXtrIeRLKZ0FJpCMCJa1qgNPmwzG4sG+z8PdJeFBXwdhw7ChbyjRIg2lH2kbiDvmPiSnqC2xFZPkKIR4oEdnIHA4SC6rwnywCiIWA1jXw3Swgk5sEti8Qa7aM7bukZglW1g6r7EdVMWqjm06g0gO89Xpk+gfL+RccZAx9ToROVUvj94b3AwTGIiuCzd9GI5Jyr1zqJ6rtYGZrIpZkYtw+T2lmRrmpVoW7Brmqz79WPB8EiUofmI7vluGu764Ay3Gjxz0h0BtdgZcnhhKQJEdlp2dtadLCM/EOIdsJNTjyVelQxlVlKfAxGWdXHzbSHqwgNcCofH30iPHGlI+q2AygvGg/kqqw1oE4aNgeHtkhgwYlAGSdu6M2goSdhVXaI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4168.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E4MjVbEjgiyfHqV5oT0j0+583eRn8uqQ/h5t02TXAotndW9DAgP/WYCog4qn?=
 =?us-ascii?Q?1GLWKAGI8RQY0KbHP2c2z4i19vYshMGXH5mZ5qGCW/Q+N8yXcQxGE8UnW+tx?=
 =?us-ascii?Q?F2B7uSLsIM3BuCiqSkz0WpuX67cB8d5Mw8YByWEfXRmD7PYVKz0tr8IvCtNQ?=
 =?us-ascii?Q?76YxvAwdr86MT0IxusqDFw9oVHHkhofcR5pvW0FIonRPawgaFocBdl3mbrkd?=
 =?us-ascii?Q?/6Lvg26QoH9JUgDFL5CNhxYYKWfthlibj7kPKv2TBovzaTU5bEydjzrEJ9L4?=
 =?us-ascii?Q?uEmf83SKFn9do0UZFCOKt4wqyHXd2u7lG9MT+9qU4W6RXSmKjEY1cQteHdOF?=
 =?us-ascii?Q?zYw6JHb6oHWgpPtH+r/z/PN6ESG7eK6xX8Yrj5phemsy7wpX+pvWj/B58/Gx?=
 =?us-ascii?Q?nasKG6b6u7VvuuRIl6hGq5IA0Do4e1UUlrupG5LAPKRCGQSk7WGobOIySHx2?=
 =?us-ascii?Q?4j87vSEEcOUabmqinV2IWiDvQUyi93OFdC0C+6gfOLrLiZbntcB+cyMQd0Pi?=
 =?us-ascii?Q?EFnPDZOFkJzsXkP51ma7aKDpg4EYl6hxrnjbqhiALASO3IMLNYMXwFys1NZO?=
 =?us-ascii?Q?lClk3Rh0bDb2ggdYcP7pjH+ptnx4agFIZP2thdkPcjg6fgP+ytypJYkwBblx?=
 =?us-ascii?Q?uOe9q/PPAKg29s/l6GgAQqP+LGYuHk4RGNcADxxxkjrk2qzfZGN6mFF/7rnr?=
 =?us-ascii?Q?WyFug+RfM/HywwnZm3sUaJFciW5oFmhXnCDym/L37Uf9y5rWxG/LmZtkaRBj?=
 =?us-ascii?Q?ImcR/gl1of4S71sDKogxUQmWWZfw3RQtd8laymT5NZDupAivsUcN+EUooWQ6?=
 =?us-ascii?Q?kUFnAZE3/ut0wzh6X4NmGXbp9tMo+80Sc6WVHHR6fx+yCjkoEi2rpWYextW9?=
 =?us-ascii?Q?/vQG49EwGoVpNlOlAm6C7EhED1J2jxUeKDGVlhwDkN9EmRzCDcWDnyxXwC3W?=
 =?us-ascii?Q?fSjPbDrSYBsp6Gaj7iyT56JiXGYXn3SNWF0lxHhqY1bRyWZAP/ABKhswwItI?=
 =?us-ascii?Q?XyckWgXYSSdPhqoTIZbtHqcm/wfRVorFt6+T76lHnh9o7x8DFKojykh39bi7?=
 =?us-ascii?Q?237r3jHax75agfBLIBJWHCcVFh7Nn8ns0Tjq2O7sZ5XQU7ugYcV6Y8qEYUnX?=
 =?us-ascii?Q?fjk4lJUZ2e+D4KB4FwMu6dg+xj/kSlJHSHOeUgKrhqGUSzPnyML8QzvcDrRF?=
 =?us-ascii?Q?OBAxACKpv68kYqXrNEH5bWYEOCGhO6O6NeIxEqZq8z2Y833Duf3LqvxAP6SU?=
 =?us-ascii?Q?auH/ssMzsFXr8KhQkU382DY21CzMtvpbjNoZ4hzZr4jA8iGmvBUfdfn2HeOD?=
 =?us-ascii?Q?iJstleyiVKrcnjsonrLKYp3yYxT/bIa9msm+qjPes3R8VVTHmjhmd0s6s8e/?=
 =?us-ascii?Q?LiaVFWSFtCJJ9DTgxgp7X8nvL3WTnyDdAtyL7D1rNSezKm3E5rIHnaS5M+OK?=
 =?us-ascii?Q?TqxENfOKliwuH5AM+YxsgUirYjCW1RlDU16mjICmDNg1GVGFjQBQM45jOQs3?=
 =?us-ascii?Q?mcCZrpHfFCmh9Ge7KEs8tvQdgM0OWRFDHDNrKnEpJWfzRQU4aAT6l255yVz0?=
 =?us-ascii?Q?qsqA3EuCD77jaOCmr0pkbWXQmaX+/+OkGHzzx7pXEhwjPPJc+yb1hnRAd4KA?=
 =?us-ascii?Q?Mo6UDGAIahcmiRqmOutxbnH6Slri0EgOatWon9Ahb+FzNZHkwR7yEDaNG7o6?=
 =?us-ascii?Q?gOffXXVm7WrDsQyXr/NMHLF+WTsTaEQKmSU1YpdlDanZNd5g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bff486d-ae66-454f-bd95-08df3aec6203
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 03:25:03.9965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJ1KmIapSZDOpEphhxcMvu5d07rAR2H9HaGM0gLOeDgVkxM+GLeanktnMmaUKJsThWpkSb64ZX5D333MOGL7Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Public

> -----Original Message-----
> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Sent: Thursday, November 5, 2026 11:23 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: check CRIU SVM priv data bounds before
> allocating
>
> Public
>
> It looks like this patch contains two separate fixes. Could you split the=
m into two
> patches?
>
> Best Regards,
> Yifan

Sure, will split into two fixes patch in v2.

Thanks.


>
> -----Original Message-----
> From: Yuan, Perry <Perry.Yuan@amd.com>
> Sent: Monday, November 2, 2026 3:02 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Yuan, Perry
> <Perry.Yuan@amd.com>
> Subject: [PATCH] drm/amdkfd: check CRIU SVM priv data bounds before alloc=
ating
>
> kfd_criu_restore_svm() allocated the per-range metadata before checking t=
hat the
> range fits in the user supplied private data buffer, so an out of range o=
ffset cost a
> pointless kzalloc()/kfree() round trip. Do the bounds check first and ret=
urn -EINVAL
> directly.
>
> copy_from_user() returns the number of bytes not copied, not an errno.
> Test it directly instead of storing it in ret, so ret only ever holds an =
error code.
>
> No functional change for valid input.
>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 3023b0159ba5..b9bf369a9fe3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -4236,19 +4236,17 @@ int kfd_criu_restore_svm(struct kfd_process *p,
>         svm_priv_data_size =3D sizeof(struct kfd_criu_svm_range_priv_data=
) +
>                                                                 svm_attrs=
_size;
>
> +       if (*priv_data_offset + svm_priv_data_size > max_priv_data_size)
> +               return -EINVAL;
> +
>         criu_svm_md =3D kzalloc(svm_object_md_size, GFP_KERNEL);
>         if (!criu_svm_md) {
>                 pr_err("failed to allocate memory to store svm metadata\n=
");
>                 return -ENOMEM;
>         }
> -       if (*priv_data_offset + svm_priv_data_size > max_priv_data_size) =
{
> -               ret =3D -EINVAL;
> -               goto exit;
> -       }
>
> -       ret =3D copy_from_user(&criu_svm_md->data, user_priv_ptr + *priv_=
data_offset,
> -                            svm_priv_data_size);
> -       if (ret) {
> +       if (copy_from_user(&criu_svm_md->data, user_priv_ptr + *priv_data=
_offset,
> +                          svm_priv_data_size)) {
>                 ret =3D -EFAULT;
>                 goto exit;
>         }
> --
> 2.34.1
>

