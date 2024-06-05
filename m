Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596F2C25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 07:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8857C10E181;
	Wed,  5 Jun 2024 07:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZlZPP29X";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C91310E181
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 07:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7vKwuA1OmrCPhF1Gt5hum/O3cacS4PRs7mislq0QdIMzbfJvB2xg0+CgGZnvTUnExZPFMEnJkRs0I+AQtPYeG/xstuJ3u/xLlr/C6d/jNAZBEvVJnyUAQMJChHkmpak6Rhq6REZOpNBV9E6XbN3KJbRFr82Fgh86sxUaEOcObH2C1aLRQLuRATaC1g0BNuVZkDdK046XyhZYKbMLkaMeWcpKrnsgSAc1Fg4LwfDDBGRzsXA9ivDlCq4ANW9PAHbslEsELRv1p1BgsNEfzb1CST4A5nlvU+16orsO6noYys7mnLTrTwnfkpe9GtjPbLGqE9tlVwK3fR9c5gcr44sgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPZQM5x0x0oze85QVGsjY9WRFPDktKSf5AJVADFfHoY=;
 b=LVpt3EYtkAVrfSwdClHM+GrKBKDLxBV/EkrK7T66RvhzamuRl2Xoae7QkagwobiNhxNzU4GJFO/Tt2Nlbu9zzERNrIvKqksrx1Tln3+53ElzQ3lQFjAUj+6/B0X/ob98c6+Y0A3dnDRbC+cYP9DklRH23y8U9cYNGTzwg3JARCd7srrvWV65NYstV0bLQiMesaZ2m+irSldH2QFGl329DuzHij3Sz3OvgfNqRo2IdIvwwiQNvwukWc4KsO1PCFVRusab4ePH0i46lumumRSVhjirYHoF00srFILwULjJfO5m/+bjxFR+GlpF6WXyE47wVvXYgOFwIZePWnKPpZjkVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPZQM5x0x0oze85QVGsjY9WRFPDktKSf5AJVADFfHoY=;
 b=ZlZPP29XK1FeJT7JpN5SfnHXtBB1rQN3P+dfZO4S3kqKZlexeARA55LuDns2wKhQEu6lM00C3gdmwSTPrRnMktSVBVy1DOqMwyc9WIPhxVr6W36oH0vcrf3ebMaQQTaUCxkaZDH6vim1UalH9BsNrFMmsdZ9CWT6L85PDcmSsq0=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Wed, 5 Jun
 2024 07:32:10 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 07:32:10 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 04/12] drm/amdgpu: remove dead code in atom_get_src_int
Thread-Topic: [PATCH 04/12] drm/amdgpu: remove dead code in atom_get_src_int
Thread-Index: AQHatZKmXFDLDAmWfEGu8hmRgJK5A7G4x6jw
Date: Wed, 5 Jun 2024 07:32:10 +0000
Message-ID: <CH3PR12MB8074ACF3AD53D486F58BE112F6F92@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240603084711.2569917-1-jesse.zhang@amd.com>
In-Reply-To: <20240603084711.2569917-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ad786337-6a9f-47ed-992b-9aeb1ac1fc2b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-05T07:24:28Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA0PR12MB4413:EE_
x-ms-office365-filtering-correlation-id: 2edbe359-4aac-4bac-1d94-08dc85319c64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?nK4m1Q5V8Di6PTYdtEjv8vFRUyegzt4n+3EGlz+f1edl62Tp3y/Sy2W5HSO/?=
 =?us-ascii?Q?fYl6/DpAkygGKuoxnkesP+wjbTpgZywwPMMtykPNwreZjReHNlbfJ+pp92TI?=
 =?us-ascii?Q?gmACt/eaSxz6T6cyXzXv2Xw5iyY6pN+Mrqn3WDGLzCiVlQ7Te/QNqbZjqGIw?=
 =?us-ascii?Q?/c4c+Djx0xDhCDuU+2iZCTdr7zmuPUIs0Swt3au012HD8a2n3qd9FRe+6c1D?=
 =?us-ascii?Q?ZcT4ebQS1OVICF0T10gMlFSOdxfX5ZxeBv/QCbqAi8sOYDkgpyUejQU8nAxS?=
 =?us-ascii?Q?XdwK4mUXTghg4TdMbsjbRFwMgokGujm+odW+y7XOz2DYwfY0GOLLmYnaB+bz?=
 =?us-ascii?Q?9nPghMgYTyxl6rbgu940ortlfdwy/zUzcBMgwzwTB8PsBFnRBzdYq3NfI0xp?=
 =?us-ascii?Q?TIWPWzO5F5NXcLYYuZTaffdMledzH4KJnF8KeHAB2hh7zLSDJlOQjIxkr95n?=
 =?us-ascii?Q?Zn2umoX/qERs1G/i636nd8ZL3ODpv0ymoMjrvg2GW/MFvZ9DofVZYLiRksNv?=
 =?us-ascii?Q?lnE0WPMLGoAKtzxAsY+7XfTqUaeMArYY3YmvRaJjJSIkXXuH8uctlWKcLBoE?=
 =?us-ascii?Q?SUeBR5PeQZKkaqpGw/a5ULUIgHN+E9biXffsDCbU+HC2yf47cmAslGC23gSa?=
 =?us-ascii?Q?uct6vpGokiiCdqpYpmyl4wN7lLBpikS87Q94N4NVGpJvWzD8to13uNCyXx7k?=
 =?us-ascii?Q?uzIWaGuW8ZOxs8iKp1iVP1PTS84OSEYsZ5GUAhdFPT4DcZke06FYjLqRGVXu?=
 =?us-ascii?Q?zLqxDOsa9dA5jcdezAHS3JjKPYNT/QFLr8sWrYaV78A7DQjDLQ1rr5LVwexZ?=
 =?us-ascii?Q?60wDTEpVKH2HWYmmCzi4qefxJbclTMTqG3hPiyjdJKoglhmrHZpfqITpetK0?=
 =?us-ascii?Q?QSD8HdcNWqaUAi4Ago8X8DuW5ocI+Syi7iERRHfJtLHd9YLqOEQtA+/cuLxi?=
 =?us-ascii?Q?ABbTzB9sK2H2nQ4CkC5JdHgrQLZWpum7JkjkGcI25+Zz85y4VveSQN3AucAT?=
 =?us-ascii?Q?IQIDnh3OhppJTuRfeXkA3EwVA7KEf6IPCPjkYT6IA04h1BMKEJ+Vr5pdVvoY?=
 =?us-ascii?Q?3wcfbRjjY+rUQs2GbC3C0AOmLvLte5OY22fqqV1B/uleqPGtjWU0+n2OmocI?=
 =?us-ascii?Q?8N6hStPW7UuwxrESi1ylFyaBWyEVk2jkonlSqhv9rvAIvuWV2VB5m2+V+M+Q?=
 =?us-ascii?Q?na98/FWVS7kj7/2KJ+KVJgkJZ+ZA+hP6QtKEKIMTyj6za/c6F7NnFDJWVmSe?=
 =?us-ascii?Q?NFah9PmRbdzmyisw/nOlPqN/U/TbrIFGk/Memm/eu8fIGGWS8TGQgHet3K/c?=
 =?us-ascii?Q?8f4q/vguNYQEfMNqW3sZgDuNYu/PhsvGlOni4vxQzDTpqvX+mFhdOF4Nw97p?=
 =?us-ascii?Q?pUr3ogI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yk7fIZ8jgGh7OBIsu02vC0wd0ADVx2RupMprIEBvUywiyHuKLn/r4iGQqJW6?=
 =?us-ascii?Q?cv1a//0rm6mkm6cfra/cydeIFUr01miynb9CL/WtFGGd5PAI4zlQ1TPQ5cEK?=
 =?us-ascii?Q?3uLnc8qAK7vlXl7ycUtLfiBBqm2sHg122+avbTRkjeG/vaimAYlv37EVFLI4?=
 =?us-ascii?Q?4Q9pt81S21cw+tCsQuXEAQXg6+eE3WfYaKVm3LkJTUAIM8J109RY9gM6iOiB?=
 =?us-ascii?Q?HrW2S6Eat/5rBVxLNjQkxMogrKUN3FaDcPNnkubQKRDNIbcX5gLFKYOrKML7?=
 =?us-ascii?Q?uMobEL0cmVTRFHQaU8xOQCcvo2IMkTlkUM9ALn0xGr1O9yeZkyUpixg5mIh4?=
 =?us-ascii?Q?UfsGFZ7Hbp30o0s13h0DN5mh1rVf9heQJoqtSUZnLAqR5M4UwI/tw0o5x6UW?=
 =?us-ascii?Q?Pey8THp0AQ1Xn6/ZKDdy0p9kB/pyKpRqMAryI0oxKmlQQ4iRzzQCZB9NxSM7?=
 =?us-ascii?Q?Xdul0/YtrFZvTFERNS7UFVprQrNcDnbwCaLgOpkPiRhjLg9mbRObRz+iRAq0?=
 =?us-ascii?Q?CSU9nELBR78LSbUAtrXbgHM2jBC3Vc+FMCcId5U/FDxTBOdWHAiv8ZuOVWAC?=
 =?us-ascii?Q?42pxnxnG7lhsnytDAO0MGFg50gbu95WhM5a+NmyAjoRXHhenzZnNE6SwrKrP?=
 =?us-ascii?Q?XIGkoq3St8JlhF0WqAsxNGlOK/A02Zy7VyGJeEiPtRQFk4X98tbIz+MnRLvv?=
 =?us-ascii?Q?M/kzGdgrWZGjyd+cUcR0oIshXjlU7EGfuWK9T4yjffMSU2vtPah/wSRXELzU?=
 =?us-ascii?Q?Eu+6xL0m0Ph1WgBGG2dn2swQbkrZuJJRRWc4SgOwtaGztaW3ZR2u5GultCR/?=
 =?us-ascii?Q?pqFHkX2TuT5IDMqiwvOFjEn0+0nAoKkx6FT8rEStPZZwzyOU8j2Zyvo0/llD?=
 =?us-ascii?Q?hPpCDJ/jqS92XihJBWq/jt5zfVjpirYJqApKMn33/c0Ddkt4h79NicLmcGb7?=
 =?us-ascii?Q?XfbdTjKTBgeWfNsxvg+nPRP/J0pE6PS0MTd24HWI4Cat8GwOdT92fhefL6v8?=
 =?us-ascii?Q?zTDTagj7AMSNsDDGhStr37fm00rSSyOlOmtNyQER2iXfoQXmEU+iQ8o65X6W?=
 =?us-ascii?Q?R2Z5jMibFNLmrulqUwOh5NBl/RoHF3D+YPG6KQ0dIRITM2zfjF3x0MUP4+6r?=
 =?us-ascii?Q?+C054V82nFhq/QaZ2X14SarPd3dz9Gi71Wy6bzxaGZjih0ntOAklWj7YaQJL?=
 =?us-ascii?Q?OohTGSm1iTCGaVVBm9+VyZR++upQaiDhjmLeOqtC0WnbO3yJsvZfPLRU9SIH?=
 =?us-ascii?Q?fCtXtCF8rlxwjXIWylMzQmAkgJwwTo7eS8RJrWzKpTm4Aeyfh9iDLb1TZwna?=
 =?us-ascii?Q?tZwuqnHdnp6XKHNpV7arMkf0YQIevDQZ+LXkgcMbVAjJk1gNIc8wuj8uHZla?=
 =?us-ascii?Q?OFHtN4IZfjic4sWB6lMtVRVJj1RTbGjAvPzODcr7oEBVR607B0onwCst/UsY?=
 =?us-ascii?Q?VvcCmy7XVB+J/RZlRC9IUdVQQtQ7Tb6oUYjyvB9bLzzSiO/4WR8Q+7SJM28A?=
 =?us-ascii?Q?AheYa48KE40MJcPAcQiF/uph21qOY8T/LsWNi4rE19iTT3z8NdkdWrWUbzq2?=
 =?us-ascii?Q?GFnbYcOzcgP1P/g+D+s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edbe359-4aac-4bac-1d94-08dc85319c64
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 07:32:10.2923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2rHt0hx2pxw4SKyGL3HcKDSkT6GvN2Bq2qmUpKf8nKFpF3L3y3YqE2PvVAtZM+l5F/Zcjf2GPgQws0yFoZ4SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Jesse,

> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Monday, June 3, 2024 4:47 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 04/12] drm/amdgpu: remove dead code in atom_get_src_int
>
> Since the range of align is 0~7, the expression is: align =3D (attr >> 3)=
 & 7.
> In the case of ATOM_ARG_IMM, the code cannot reach the default case.
> So there is no need for "break".
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/atom.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c
> b/drivers/gpu/drm/amd/amdgpu/atom.c
> index d552e013354c..c660e4a663ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -320,7 +320,6 @@ static uint32_t atom_get_src_int(atom_exec_context
> *ctx, uint8_t attr,
>                               DEBUG("IMM 0x%02X\n", val);
>                       return val;
>               }
> -             break;

This should have new statement may fall through warning if remove the break=
 here?

Tim Huang

>       case ATOM_ARG_PLL:
>               idx =3D U8(*ptr);
>               (*ptr)++;
> --
> 2.25.1

