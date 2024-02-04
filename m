Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED47C48286
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Feb 2024 06:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F9F31120A7;
	Sun,  4 Feb 2024 06:34:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ezR99p5D";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1971120A7
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Feb 2024 06:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JY6e1dHFCfY6UGLwhf35Ch6eA+Vji0GPPk1bXXsujEDVIw9kJbb/1zN/VX60wSiJo16E/rT1t43NomYjelnrUs1+ppa/1ttOhYzEIsmTtPVQzCB9eVdPH7OhS7EoOP/FH7vC5rUvB4upKI3OjRc74UEBAcMolmusFvcvqvZlSEMWCmk9eQ+XJ1hT4QXtVz0OR3NgGGIHoX7JB0BeFeQGTyZ0nCqg8U7wxtQbMPiQIdByDyjBZZaXwrVCEC+bbNcZBAEGfcU9KlDSG4eYy0dnZ4OSK7UnLI1+VLTxCSzDFNGjM6S3hAs8KXMuzqmueGSGqErVa1hGvg1NcBulhR4DRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPt5lFLlJJSWY2wjxUkATA5L2gXMkAVndYj6+NrnvPY=;
 b=RVUNX++b/fc3L9/ExSNNbZTK9yDZcl5pVl7rMJU4XiqVo9hNNdWt0Tl3mvyzrvaTPclO/RbJewz7bITbLtCaQb024Mkw+m8ZRQKACx1UqJpccaWBvsg/ykIaqj+3l46dgA++H+Jp62br0zCe0jfFkCK1ahhjRYhWZCcKlc84KTGm/Xw3fm3d1PK7atYYGwZHVOvdmL8dxuYibyhhLgXPZjNRPaoPEuYzuwtfc/K7xOagwMKCHbqlYBdydVHs6R7+W2GmuNcjr5lUcTZBTZfkq6HscT+jXa6xeeysPMu3f6iaU/seqxzsqsWHxxkyxnshP7+o8YUYLhXGWaInH9Dldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPt5lFLlJJSWY2wjxUkATA5L2gXMkAVndYj6+NrnvPY=;
 b=ezR99p5Dwr9llgKZvWgHj4/3K4w0LZN519kjWMscfrJgaeL8ii+YsVU7JgHNFxPOgNZ5UxqVbpfK+WX0V2bDW5sa2cqtIYGVARZ3w6KQbg+dG74bwc9iTQVDlZWRXWOpoFPV2F2Inm8pSbQKwPwuZj0ecvuLhH6uxls58rvNcbA=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Sun, 4 Feb
 2024 06:34:49 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66%3]) with mapi id 15.20.7270.012; Sun, 4 Feb 2024
 06:34:48 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Retrieve UMC ODECC error count from aca bank
Thread-Topic: [PATCH] drm/amd/pm: Retrieve UMC ODECC error count from aca bank
Thread-Index: AQHaVcjLSPaDhx2nFEOmjIsZ+L52xbD5vMrg
Date: Sun, 4 Feb 2024 06:34:48 +0000
Message-ID: <PH7PR12MB8796AF864BA3AE5E9AEDCFC0B0402@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240202111230.1153924-1-candice.li@amd.com>
In-Reply-To: <20240202111230.1153924-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=add44c85-12c6-4b16-a173-88583bc9335c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-04T06:34:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MW4PR12MB7357:EE_
x-ms-office365-filtering-correlation-id: 148a94e5-594b-4007-1746-08dc254b6249
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8DzwtEsja0aq9z7dSPTUvAsUOqxJoxrJIvnGtbKHrtwlOdGZFo+R5+pB7pyG7W3AJbuEIhfUtAWtX0ACvXIq4x1WqJvWDz2bS9/XZhEHjFTrPeds+6Hlzro0tk4/CB9Y5Tz4KT/lJdgK3GPHsnWLPKPlfrLE1Ht7/HqaVp7PRFEI82kkyv6S516DWoOredHxBGRQO7Rh1GzanucojSpmuVfpyZc9u7dBKQwHLuL+LQEiFB8WlvR6+KrAk1DlRc8AcR792qqGjbWKSLOGgU8h+lJuKDOJZ1YmYrajlQm7cL3CyOBy+M3qZb+aR9qCWGCPm7fEhJ2cVvIW9fst4C0u+ojdydcnTtKZJdJeeOaZGtgVmv+SzyvvQfyUJVBN9G49D6SNhdBMjh7+vbH+JBC4Y4cQuvjrR+uvMoScLLVlTNNtxk8r9nwNyxOnei2uM/WAGZeWRQIrGzOPXzO6iPfSfDCgLvkuCb5ROfQwp/wqgZA/Ekab6tpd51AJrgo6sPbAiFPlkfacKD83hR8s75rJ3qNGPWdspSatQEHEAJ4m51+CrDd6fSDNF5fEg+w0EZ0dOrMWZthpYdnL84wbSooKh5Dh7YEDQf6YA9TVJoLWThFM4PCNWE1sU0uxms2nLSz6uy88a26rGgH9G4nQkvNWCg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(55016003)(2906002)(15650500001)(478600001)(5660300002)(83380400001)(52536014)(38070700009)(66476007)(66556008)(76116006)(8676002)(8936002)(66446008)(122000001)(64756008)(33656002)(86362001)(6506007)(71200400001)(9686003)(4326008)(53546011)(7696005)(26005)(38100700002)(316002)(110136005)(41300700001)(66946007)(171953004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wn7JFN9byLQlQT02/tg6u+a2C8czGI1GLg4aTMN2THkalDUB07TlVaMEwpJS?=
 =?us-ascii?Q?rmXTISI1BgDsf2F1W4PUT4kEOcMFNllFKhTcntX1gVhrNz6BCZ6J2ejwRQvF?=
 =?us-ascii?Q?iu1RgQ1+UM1TwcYevKKzb4d6EBKTRfvBfAEUAN4jZV1orkX6XY+tELCM45Ee?=
 =?us-ascii?Q?sEFg0OFkKZeytgmpMRld2WktAGHqazslTqvp2u5ZYA2NQxfjGjduIJPhiLXH?=
 =?us-ascii?Q?U/iG+18ruvwFTimhFge1WYPgg4DoMbD2Inf3VYA9FeFdY8rvcPDXBODZi0IU?=
 =?us-ascii?Q?l3s1QZYOJ1uBEUKAwDqkRzOzJjvtlDvYrP3+lRp0NGjPnJ/Sc7Beg+kVJx9H?=
 =?us-ascii?Q?LpDfSDh1WdnpBnpjWpmQR6rHiOx3sbDN1w8WGEXYyFbLVockEWdTsC2rTDRk?=
 =?us-ascii?Q?aPNsXzCO8ThJfPwYR9I0fgqoyzsripHA+y3FU0koQpAQ0F0aPc8iBTGSv0PL?=
 =?us-ascii?Q?t4ZnxKUYIwq4PQTJEw5YpYcRFJ4v0vaV6EjhvVh5deeFMrplqS0GVmzH8bg1?=
 =?us-ascii?Q?NncwBkiwDpVHJ9EV1XlP9bgO2BMyzMSq8UP27wV7z8T6XIO0H3nJPMoq3KaW?=
 =?us-ascii?Q?E4rYOitNiTZ75npbEtSXJzcSnZzO7d/1yRGNi+836FKGZ+jQsHpVR9pIyk0H?=
 =?us-ascii?Q?XgJct1IFiqyXH8uVf5jQpR8ubDLeOOU9vAiEPRJKM1ZL9O5/bEaVHZqM0mrF?=
 =?us-ascii?Q?Kdrod6KEBiV0s5m5b9sAq/r6ahwRbHhwjJAS1iIvU/TsfvVe5sTkgxhRJafh?=
 =?us-ascii?Q?injUZbZiVrv9KZ5jHdNvUbryaC4kJy+wq7Lg2N4PWsBEZtHcPj7v6Hk3sXNN?=
 =?us-ascii?Q?ze9NHs4cbeR6lm9i6YFXpJJSU9ohCQ0mRP9jqfV1VNqx1m3pln4g4u6sqBT4?=
 =?us-ascii?Q?P2SQv/T60qiVtseVjDln9BychGgkexchcEv+RjFMUUDgMK+4stNBs8s6XISX?=
 =?us-ascii?Q?x7aWAT39vT+VOCyVoulaF6x5p2qzDXbn3eIbmIa0UsvYIpcXVuZf12cxs2oJ?=
 =?us-ascii?Q?eCvH7UlFm/gMuOmK5UUCqNwtFAICs6gHyB4qKHR23v5xnSNkZfs43CQ6qq/I?=
 =?us-ascii?Q?6PrKQXgGQ6lbwLZVAVbQLdmVUgk3D0UmymNRmkjs8dr2O8xIWY7A2rIoGaiX?=
 =?us-ascii?Q?EGPbV9TnG4Jh/ouR0fDMhB7t7S+9N/cymQcFWiOqBnFe7+l8lX/5AkHmLc++?=
 =?us-ascii?Q?uqhgn+RT2maz17ogPJfKnvEL+/5XBhSmxKhRKPptIjPlm2b+aclCHzj94q4N?=
 =?us-ascii?Q?DtblnOVTM4DuPOA8BOsjj7yq2hkhW/DR4rHWHqzVBhRgPqaxhqIx/AEOr2vP?=
 =?us-ascii?Q?Jb8Q1/ARqWvZMgDaQJJX49SsoKSODE5Jp1pDB2ruTXqCAqag8h3N8u4LSUPa?=
 =?us-ascii?Q?0P1ZKbyDKuoBijRXs2j1FLuXqvvufxkIEpr2Z7UWY/sLcRs4vurpW+0wHQ7m?=
 =?us-ascii?Q?CyL8NJOWeHtORf62Ck3MuonbnvveUrdnG6FdrBhJwwYY+J3Lo+IUKt3jWD4Y?=
 =?us-ascii?Q?QMZcfDsYmnTcyuGMzyp0rj0sEzNLG7ssuPSdqxXwcghAe7OpjyjJ3UrDalOc?=
 =?us-ascii?Q?KAxhrD4VwVbf11g6nL8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148a94e5-594b-4007-1746-08dc254b6249
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 06:34:48.1381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +y3BwOgv7huv+XjuKAMDFp+7lFPUpyffzNohFJC5ZjL4E5aFZXeSi9w+X+cutzLe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
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

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candic=
e Li
> Sent: Friday, February 2, 2024 7:13 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH] drm/amd/pm: Retrieve UMC ODECC error count from aca bank
>
> Instead of software managed counters.
>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index d6e14a5f406e63..03873d784be6d6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2552,8 +2552,12 @@ static int mca_umc_mca_get_err_count(const struct
> mca_ras_info *mca_ras, struct
>                                    enum amdgpu_mca_error_type type, struc=
t
> mca_bank_entry *entry, uint32_t *count)  {
>       uint64_t status0;
> +     uint32_t ext_error_code;
> +     uint32_t odecc_err_cnt;
>
>       status0 =3D entry->regs[MCA_REG_IDX_STATUS];
> +     ext_error_code =3D MCA_REG__STATUS__ERRORCODEEXT(status0);
> +     odecc_err_cnt =3D
> +MCA_REG__MISC0__ERRCNT(entry->regs[MCA_REG_IDX_MISC0]);
>
>       if (!REG_GET_FIELD(status0, MCMP1_STATUST0, Val)) {
>               *count =3D 0;
> @@ -2563,7 +2567,7 @@ static int mca_umc_mca_get_err_count(const struct
> mca_ras_info *mca_ras, struct
>       if (umc_v12_0_is_deferred_error(adev, status0) ||
>           umc_v12_0_is_uncorrectable_error(adev, status0) ||
>           umc_v12_0_is_correctable_error(adev, status0))
> -             *count =3D 1;
> +             *count =3D (ext_error_code =3D=3D 0) ? odecc_err_cnt : 1;
>
>       return 0;
>  }
> --
> 2.25.1

