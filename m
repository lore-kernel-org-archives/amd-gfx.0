Return-Path: <SRS0=u850=HL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F179C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 17:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8143064E31
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 17:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8143064E31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0323C6E094;
	Tue,  9 Feb 2021 17:06:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D986E094
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Feb 2021 17:05:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ato3UYKj/S+asjf2pU7/Jq712lp8J0Ad4waIBftmIh88oJ3Xknpb4CEAFpeL+/8a49TgLGdzhIfa+ENh7eg7906EFZL2ejQ5bjSjGfd46Iq9XgBi7OKH/8UrXcFlFKj5LoyMkoycKIAy3uCVJCVxiMKcMrIvvh4S8gCbF71DReAilZ+nSydhhzUILQrLoJydmpgNUZK06P5juENB9G/jdhxsizWAd0WBX/Td+28qTsQopEGvHefWQXohTsBjsUGWnHA9ljiZFF2dOvuMr/tX3DGJzwM/QtqqZ6WhanAuVBdJxihMTVrLas6qdYTUIB8VNBGqaXuCD69deueIJNXHIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IH/E3Kv4ViZg12GbDO6Cn37omsijzFOqnUkpno1CtE=;
 b=eOA4/N/J7zYzMuCBnlXqieB6frcDv/0MAKldIG4waqM8d37adC/AdXIurJX8ZX6Krlzrgij/h6rKIhlw6G6GX0h5NWWdNBhFTuHU9RRob2DLgp1CQM83WNAvsVB+yz+nSYGzuhyr3tiRlS+LX6oAV++nDGnTvsQ3xmeWhThIbN3vfJpeQcM4oaFAWzDFdBRsjubV02hcik85xChLxKFowYJoe0lr8rGge3nUZ+3qmyiR66JclDILoKz7GZ23db3M2JZ/vrqCqJQgPq+kpP+G3kCcjXgCdtFRJzbeOegr3djGCMdsTCweAkKmtDTuDz+qJJB0yAUX5n4RME46RDrTEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IH/E3Kv4ViZg12GbDO6Cn37omsijzFOqnUkpno1CtE=;
 b=ba0jeRKB/IM02Hp6jKj0UNbyEadKaDQYlNi+H/G9DCK91N1yzbfsUrni1GeSLFG37u3qDTtWngoZQQ8Pc7lbZyrSq+o+gHdfcbYvFA33YEgeoT/+gFg8PgohnbjnPZUUR2FsNTogDaip1MYC6/5D1s5ftSpI3i2js3VVAauQ4dk=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3759.namprd12.prod.outlook.com (2603:10b6:208:163::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Tue, 9 Feb
 2021 17:05:54 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%8]) with mapi id 15.20.3805.038; Tue, 9 Feb 2021
 17:05:54 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: make the error log more clear for fine grain
 tuning function
Thread-Topic: [PATCH] drm/amd/pm: make the error log more clear for fine grain
 tuning function
Thread-Index: AQHW7t8aliJlX2EueUanhcvbh2+ZoKov5oWAgB9u2wCAABViAIAAwuI7
Date: Tue, 9 Feb 2021 17:05:54 +0000
Message-ID: <MN2PR12MB44886676E993E8096C277DCFF78E9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210120034821.15400-1-Xiaojian.Du@amd.com>
 <MN2PR12MB3022DF9FACBC945BA0E7750CA2A20@MN2PR12MB3022.namprd12.prod.outlook.com>,
 <MWHPR12MB1248C40D2A09B5DED1C179F5EC8E9@MWHPR12MB1248.namprd12.prod.outlook.com>,
 <MN2PR12MB30225E137752C5FBF8B5D6CEA28E9@MN2PR12MB3022.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB30225E137752C5FBF8B5D6CEA28E9@MN2PR12MB3022.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-09T17:05:53.989Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.237]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b3049b0-edc8-49cf-c59d-08d8cd1cf641
x-ms-traffictypediagnostic: MN2PR12MB3759:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB37597CFA60791CF85A1B2FD2F78E9@MN2PR12MB3759.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WFernjREjcPbKEwOJe2VuLDfYwy5NgqLuwOi22/4/+G0vSrrw4a9dewD7G6s+93nmqAPuErxjPngS/7dOqMsl8crdnRISnbB/u7n24QG2heXcxBHcILoMm7z93ZRPS1pC53yCbloBOrginEiv3q6UCnAKV3kaBU8XT0rPNTepd6iYLQNDPNDAFixO0ErKSeLzGCuTSL4SB5jE+3fYpdemxIAre06TWfxhDoZ4aT9VTlYMJl9CkrBvra50zB2H6S+j5zRSk/EYxpKnnNbIjAYw5ITUU0e4iPAT/S2+LVftk+lMVjSHYK1CzbB/2R0X89OW7dun0Oku1DxWTtMK0r/rYPPKGMdcT9A1lLihfM1pkcvVY7urfCdnePhLZ58qlsPdYbj/fmWpjLc2iMAH/AnDhcFd0ed7EMUYKtC8ZI4YGISP7u3K4kLpMatsPKCUR6UBwTiCX6s45xto/lYCVfYxZPD6f01RKIU5O2P1FteTZy9xEqEWGq01NT7UiRj1DISo1JMdL1T5Bq2YjnFboay0w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(9686003)(83380400001)(6506007)(5660300002)(55016002)(53546011)(2906002)(4326008)(33656002)(478600001)(52536014)(8676002)(316002)(110136005)(86362001)(54906003)(8936002)(71200400001)(66946007)(76116006)(64756008)(66556008)(66476007)(7696005)(26005)(186003)(66446008)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?dRPKGIqC4TJxsaU/gU1jZy6rabCG9UmUE+C50nPFTJfN8CdcT+jO4K6A?=
 =?Windows-1252?Q?nU8vw3RklsQGQyxYyxzC/5Fyw3sg93TsrNT7iYRRxxvjC7r7uTCBwb+Q?=
 =?Windows-1252?Q?KvIUVYrEi+Ewh/SsNPmlegnss/k2LDJoEMRbtWU+rmXrIPevUkcCjaKL?=
 =?Windows-1252?Q?o+GOJxxdvu8bpAypvtd9zRm4Av2gjzAegbae4TYdND1MdeQZsBKwT0kR?=
 =?Windows-1252?Q?HqLPPUc1S621MeH2Wq2ybmNDn3+sNlgNMvsWdG+dZtRwmY7llPXOUhiv?=
 =?Windows-1252?Q?AFQDEAsTl5NApFFPkStYYQ75GaGYc5ex2TirhsDBxyoOOOyZdf/FatnV?=
 =?Windows-1252?Q?K7IWwyb8XGKVre6fKs2oYTW3O1BsjbNMkW8MAOGhKriJ0qiV4SQ8N72D?=
 =?Windows-1252?Q?ch+XT4JdAwjCP7l/opRnxiK7YtcSPCjXCUlnkcJuYA8XHxs8Lwzr9FAp?=
 =?Windows-1252?Q?GNEYiftMRg39ADBaA4ycgzRsLSyJewhwmpTtquLVgrjDw8BrLKkgxzl9?=
 =?Windows-1252?Q?GpYzxk77cqKdaBxpU3TdpIZKzYfKLs/528mevlOLbFsEy33UVVWV5UGl?=
 =?Windows-1252?Q?neK/EZFJUq8gz1RVxWKDwZe+TPbmKZEwl0nVoKxfTLEacwTYGE5mCIjL?=
 =?Windows-1252?Q?RDHlhuTGXuKbOPkOxE/4ZshkvSS0qaCmvf7stA/FvcMNZYLYUtDTLMDV?=
 =?Windows-1252?Q?cByNUFkaFK5CsGww/Li5DXkDjNAv8NhXtnyQKpF9rWxzFu5mczHOaNY2?=
 =?Windows-1252?Q?yF9gzLf80/4i34GstokvDWeLlEXBJHIYPEf16K6LLVc63P4HM/5hmwY/?=
 =?Windows-1252?Q?FAO8OSuiTueTZOfbAD38UKYrF/DGB0fLucG6PxsNSlv/WCYZqFdMqA7r?=
 =?Windows-1252?Q?ryPFX/e+4JsopfPy9DtFGKSFouDAJHeg3teuzxYSNI10deL1R9v9nh8k?=
 =?Windows-1252?Q?tU8YcfQUGLtQQ8lGzfcwGZ5lEQvf5U0WS1mbzIswnCCiTsWBH6RUskX8?=
 =?Windows-1252?Q?lDhHGUM0fmHEjcRFwYJYKwxflJNjzjVkC2/dglHXDYc3ee5be6j9JaGb?=
 =?Windows-1252?Q?mNqRRA9ZVAS8sJiDvMXX9rCGC9AqW2K8+B/sBTAxz4zRzR7kpUxFH6+v?=
 =?Windows-1252?Q?O6ET0YnR437rbNyIEOrw1iu3mZDhQdWWLxl7nEHmJ0l5jGpHQZ2/8pqQ?=
 =?Windows-1252?Q?4GM4V4aoODgBPtVRDDtTcGRVKMPUtfU3Fvsqo/v+v6n1DetX9809mjbW?=
 =?Windows-1252?Q?mU+aOngElSEzzlJUkczdLTEsXGCtR8hu+Ulwq4L2FDvnfhOb2nczowqP?=
 =?Windows-1252?Q?O3MCpz1/mVU96TJzBsGU6ToluZMuBMFp03afIvPCeqj2SsI4/uB7rJw4?=
 =?Windows-1252?Q?0Hd/0MtBZX+g9dH4Az9y93ytrFqt5voNxJHdf8bqYoKrT48AqbTZTOMV?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3049b0-edc8-49cf-c59d-08d8cd1cf641
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 17:05:54.5207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U74jas4mmzfY4/3apCqB3S/6/3k8y8oSubDQwueCfckouwx8QBwefCaqyxd1WAsVX36VjTXWV0UYBlXp3oIj8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3759
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: multipart/mixed; boundary="===============0002274858=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0002274858==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44886676E993E8096C277DCFF78E9MN2PR12MB4488namp_"

--_000_MN2PR12MB44886676E993E8096C277DCFF78E9MN2PR12MB4488namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

We should try and the behavior as consistent as possible.

Thanks!

Alex

________________________________
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Tuesday, February 9, 2021 12:27 AM
To: Huang, Ray <Ray.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; amd=
-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher, Alexan=
der <Alexander.Deucher@amd.com>
Cc: Quan, Evan <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amd/pm: make the error log more clear for fine gra=
in tuning function


[AMD Official Use Only - Internal Distribution Only]

If it is not in manual mode, we should give the user a hint.
if possible, we should move this check into amdgpu_pm.c , it is also can be=
 used swsmu backend.

the patch is
Acked-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: Huang, Ray <Ray.Huang@amd.com>
Sent: Tuesday, February 9, 2021 12:10 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.=
com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deuche=
r, Alexander <Alexander.Deucher@amd.com>
Cc: Quan, Evan <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/pm: make the error log more clear for fine gra=
in tuning function


[AMD Official Use Only - Internal Distribution Only]


+ Alex



Hi all,



Recently, many users reported the issue to us that fine grain not enabled. =
Actually, most of them are just caused by not switching to =93manual=94 mod=
e.



         if (!(smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) =
{
-               dev_warn(smu->adev->dev, "Fine grain is not enabled!\n");
+               dev_warn(smu->adev->dev,
+                       "pp_od_clk_voltage is not accessible if power_dpm_f=
orce_perfomance_level is not in manual mode!\n");



We have to need reminder in the warning message to tell the user where they=
 are.



Any objection for this patch? I found Navi series actually didn=92t need th=
is operation to update max/min clock levels. Would you clarify whether dGPU=
 still needs this before we move the prints into amdgpu_pm.c?



However, in APU fine grain design, patch looks good for me.

Acked-by: Huang Rui <ray.huang@amd.com<mailto:ray.huang@amd.com>>



Thanks,

Ray



From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Wednesday, January 20, 2021 12:10 PM
To: Du, Xiaojian <Xiaojian.Du@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Lazar, =
Lijo <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amd/pm: make the error log more clear for fine gra=
in tuning function



[AMD Official Use Only - Internal Distribution Only]





________________________________

From: Du, Xiaojian <Xiaojian.Du@amd.com<mailto:Xiaojian.Du@amd.com>>
Sent: Wednesday, January 20, 2021 11:48 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Huang, Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; Quan, Evan <E=
van.Quan@amd.com<mailto:Evan.Quan@amd.com>>; Wang, Kevin(Yang) <Kevin1.Wang=
@amd.com<mailto:Kevin1.Wang@amd.com>>; Lazar, Lijo <Lijo.Lazar@amd.com<mail=
to:Lijo.Lazar@amd.com>>; Du, Xiaojian <Xiaojian.Du@amd.com<mailto:Xiaojian.=
Du@amd.com>>; Du, Xiaojian <Xiaojian.Du@amd.com<mailto:Xiaojian.Du@amd.com>=
>
Subject: [PATCH] drm/amd/pm: make the error log more clear for fine grain t=
uning function



From: Xiaojian Du <xiaojian.du@amd.com<mailto:xiaojian.du@amd.com>>

From: Xiaojian Du <Xiaojian.Du@amd.com<mailto:Xiaojian.Du@amd.com>>

This patch is to make the error log more clear for fine grian tuning
function, it covers Raven/Raven2/Picasso/Renoir/Vangogh.
The fine grain tuning function uses the sysfs file -- pp_od_clk_voltage,
but only when another sysfs file -- power_dpm_force_performance_level is
switched to "manual" mode, it is allowd to access "pp_od_clk_voltage".

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com<mailto:Xiaojian.Du@amd.com>=
>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c     | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c      | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 88322781e447..ed05a30d1139 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1487,7 +1487,7 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwm=
gr *hwmgr,
         }

         if (!smu10_data->fine_grain_enabled) {
-               pr_err("Fine grain not started\n");
+               pr_err("pp_od_clk_voltage is not accessible if power_dpm_fo=
rce_perfomance_level is not in manual mode!\n");

[kevin]:

for above codes, the old one looks better for me, i prefer to keep current =
design.



Best Regards,

Kevin
                 return -EINVAL;
         }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 6d3c556dbe6b..a847fa66797e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1452,7 +1452,8 @@ static int vangogh_od_edit_dpm_table(struct smu_conte=
xt *smu, enum PP_OD_DPM_TAB
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);

         if (!(smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) =
{
-               dev_warn(smu->adev->dev, "Fine grain is not enabled!\n");
+               dev_warn(smu->adev->dev,
+                       "pp_od_clk_voltage is not accessible if power_dpm_f=
orce_perfomance_level is not in manual mode!\n");
                 return -EINVAL;
         }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c
index ab15570305f7..4ce8fb1d5ce9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -350,7 +350,8 @@ static int renoir_od_edit_dpm_table(struct smu_context =
*smu,
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);

         if (!(smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) =
{
-               dev_warn(smu->adev->dev, "Fine grain is not enabled!\n");
+               dev_warn(smu->adev->dev,
+                       "pp_od_clk_voltage is not accessible if power_dpm_f=
orce_perfomance_level is not in manual mode!\n");
                 return -EINVAL;

[Kevin]:

Just tell the User what's going on, not why.

and we'd better make a function to check manual mode , then embed it to eve=
ry sysfs node in amdgpu_pm.c

using a unify interface to return result to user.



Best Regards,

Kevin
         }

--
2.17.1

--_000_MN2PR12MB44886676E993E8096C277DCFF78E9MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
We should try and the behavior as consistent as possible. <br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks!<br>
</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Kevin(Yang) &lt=
;Kevin1.Wang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, February 9, 2021 12:27 AM<br>
<b>To:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; Du, Xiaojian &lt;Xiaojian.=
Du@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar=
@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/pm: make the error log more clear for f=
ine grain tuning function</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:11pt; color:#0078D7=
; margin:5pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
</div>
<div>If it is not in manual mode, we should give the user a hint.</div>
<div>if possible, we should move this check into amdgpu_pm.c , it is also c=
an be used swsmu backend.</div>
<div><br>
</div>
<div>the patch is&nbsp;</div>
<div>Acked-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div><br>
</div>
<div>Best Regards,<br>
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Huang, Ray &lt;Ray.=
Huang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, February 9, 2021 12:10 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Du, Xiaojian &lt;=
Xiaojian.Du@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.fr=
eedesktop.org&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar=
@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/pm: make the error log more clear for f=
ine grain tuning function</font>
<div>&nbsp;</div>
</div>
<div lang=3D"EN-US" style=3D"word-wrap:break-word">
<p align=3D"Left" style=3D"font-family:Arial; font-size:11pt; color:#0078D7=
; margin:5pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"x_x_WordSection1">
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
+ Alex</p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
&nbsp;</p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
Hi all,</p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
&nbsp;</p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
Recently, many users reported the issue to us that fine grain not enabled. =
Actually, most of them are just caused by not switching to =93manual=94 mod=
e.</p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
&nbsp;</p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(smu_dpm_ctx-&gt;dpm_=
level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev, &quot;Fine grain is not enabled!\=
n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pp_od_clk_=
voltage is not accessible if power_dpm_force_perfomance_level is not in man=
ual mode!\n&quot;);</p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
&nbsp;</p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
We have to need reminder in the warning message to tell the user where they=
 are. </p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
&nbsp;</p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
Any objection for this patch? I found Navi series actually didn=92t need th=
is operation to update max/min clock levels. Would you clarify whether dGPU=
 still needs this before we move the prints into amdgpu_pm.c?</p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
&nbsp;</p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
However, in APU fine grain design, patch looks good for me.</p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
Acked-by: Huang Rui &lt;<a href=3D"mailto:ray.huang@amd.com">ray.huang@amd.=
com</a>&gt;</p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
&nbsp;</p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
Thanks,</p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
Ray</p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
<b>From:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt; <br>
<b>Sent:</b> Wednesday, January 20, 2021 12:10 PM<br>
<b>To:</b> Du, Xiaojian &lt;Xiaojian.Du@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; Quan, Evan &lt;Evan.Quan@a=
md.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/pm: make the error log more clear for f=
ine grain tuning function</p>
</div>
</div>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
&nbsp;</p>
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif; color:#0078D7">[AMD Official Use Only - Internal Distribution Only]=
</span></p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
&nbsp;</p>
<div>
<div>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div class=3D"x_x_MsoNormal" align=3D"center" style=3D"margin:0in; font-siz=
e:11pt; font-family:Calibri,sans-serif; text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
<b><span style=3D"color:black">From:</span></b><span style=3D"color:black">=
 Du, Xiaojian &lt;<a href=3D"mailto:Xiaojian.Du@amd.com">Xiaojian.Du@amd.co=
m</a>&gt;<br>
<b>Sent:</b> Wednesday, January 20, 2021 11:48 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Huang, Ray &lt;<a href=3D"mailto:Ray.Huang@amd.com">Ray.Huang@am=
d.com</a>&gt;; Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Qua=
n@amd.com</a>&gt;; Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang@amd.=
com">Kevin1.Wang@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.La=
zar@amd.com">Lijo.Lazar@amd.com</a>&gt;;
 Du, Xiaojian &lt;<a href=3D"mailto:Xiaojian.Du@amd.com">Xiaojian.Du@amd.co=
m</a>&gt;; Du, Xiaojian &lt;<a href=3D"mailto:Xiaojian.Du@amd.com">Xiaojian=
.Du@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: make the error log more clear for fine =
grain tuning function</span>
</p>
<div>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
From: Xiaojian Du &lt;<a href=3D"mailto:xiaojian.du@amd.com">xiaojian.du@am=
d.com</a>&gt;<br>
<br>
From: Xiaojian Du &lt;<a href=3D"mailto:Xiaojian.Du@amd.com">Xiaojian.Du@am=
d.com</a>&gt;<br>
<br>
This patch is to make the error log more clear for fine grian tuning<br>
function, it covers Raven/Raven2/Picasso/Renoir/Vangogh.<br>
The fine grain tuning function uses the sysfs file -- pp_od_clk_voltage,<br=
>
but only when another sysfs file -- power_dpm_force_performance_level is<br=
>
switched to &quot;manual&quot; mode, it is allowd to access &quot;pp_od_clk=
_voltage&quot;.<br>
<br>
Signed-off-by: Xiaojian Du &lt;<a href=3D"mailto:Xiaojian.Du@amd.com">Xiaoj=
ian.Du@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c&nbsp;&nbsp;&nbsp;&nb=
sp; | 3 ++-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; | 3 ++-<br>
&nbsp;3 files changed, 5 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
index 88322781e447..ed05a30d1139 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
@@ -1487,7 +1487,7 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwm=
gr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu10_data-&gt;fine_g=
rain_enabled) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_err(&quot;Fine grain not started\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_err(&quot;pp_od_clk_voltage is not accessible if power_dpm_fo=
rce_perfomance_level is not in manual mode!\n&quot;);</p>
</div>
<div>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
[kevin]:</p>
</div>
<div>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
for above codes, the old one looks better for me, i prefer to keep current =
design.</p>
</div>
<div>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
&nbsp;</p>
</div>
<div>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
Best Regards,</p>
</div>
<div>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
Kevin<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
index 6d3c556dbe6b..a847fa66797e 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
@@ -1452,7 +1452,8 @@ static int vangogh_od_edit_dpm_table(struct smu_conte=
xt *smu, enum PP_OD_DPM_TAB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(smu_dpm_ctx-&gt;dpm_=
level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev, &quot;Fine grain is not enabled!\=
n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pp_od_clk_=
voltage is not accessible if power_dpm_force_perfomance_level is not in man=
ual mode!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
index ab15570305f7..4ce8fb1d5ce9 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
@@ -350,7 +350,8 @@ static int renoir_od_edit_dpm_table(struct smu_context =
*smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(smu_dpm_ctx-&gt;dpm_=
level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev, &quot;Fine grain is not enabled!\=
n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pp_od_clk_=
voltage is not accessible if power_dpm_force_perfomance_level is not in man=
ual mode!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;</p>
</div>
<div>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
<span style=3D"font-family:&quot;Segoe UI&quot;,sans-serif; color:#323130">=
[Kevin]:</span></p>
</div>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
<span style=3D"font-family:&quot;Segoe UI&quot;,sans-serif; color:#323130">=
Just tell the User what's going on, not why.</span></p>
</div>
<div>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif; text-align:justify">
<span style=3D"font-family:&quot;Segoe UI&quot;,sans-serif">and we'd better=
 make a function to check manual mode , the<span style=3D"color:#323130">n =
embed it t</span>o every sysfs node in amdgpu_pm.c</span></p>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif; text-align:justify">
using a unify interface to return result to user.</p>
<div>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
&nbsp;</p>
</div>
<div>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif">
Best Regards,</p>
</div>
<div>
<p class=3D"x_x_MsoNormal" style=3D"margin:0in; font-size:11pt; font-family=
:Calibri,sans-serif; margin-bottom:12.0pt">
Kevin<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.17.1</p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB44886676E993E8096C277DCFF78E9MN2PR12MB4488namp_--

--===============0002274858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0002274858==--
