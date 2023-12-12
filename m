Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33ACC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Dec 2023 14:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 889F910E1FF;
	Tue, 12 Dec 2023 14:05:46 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B96310E1FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 14:05:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOL719CtmO7lkOEEwg2jeW6b0XN5ktq5sG4xG30AfnwDRwJ/uCeiJcv4A0pOkoPJKXE8TWo/a3LP+O2bMG2vfx0dxNB9DrzPqFTbbI5mle3JvJwwSqkxr9miepieSgjAV7v3j/XLIyvhfD4OQ1AElDSYLSTn2ZAYOpqR5hamDHBBi1xars2G7hG/niOpXxOJebFaTiisObdidXw3HSv5eW4g47GzoALESyaapFJvWzuK/4ymm5C4QlHNq5iZHDBpVxMGQ9jbpokglstDaHI128JygCUaN87w3WICFamhHIzVBWycHtgx+ugYW5g4VOSHrSTvvE8JgzUyoP8hYsxLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAjBGsNNDNX+flkvC27fxgS0cfLN4AFb4QqLM7MXrBs=;
 b=YEXCf1EpXgNCT+dv3VVA85/8BB0E9SSiW0fHJTEgbgFVLlXgPn0jmZ9BG/hSpVO3gi9DzInH1SDEwGGbKrlgTuwKXL8BYvr/nQh2+h41hnR+uOgHOt29ESj9JAFOnG9PoM4ezGOuKwsDNn3lBcCW5SOViDWKQ2CnznlyyUkX1FdLb4amq6PJLADIgNuiA5BqjkNY4/sil5L0L92VAMUC6Q//hitObSO6NfGjKjX8pyvOGtGZNer4rHe/FLK0u3s+rmbftDxibSNr6VOQnt/Qq63iCBvOejQHhiK9P1eA9JXpIMAoWCffi/XluVcIa7N5RAtedwY9d1SJnMOsYC0YQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAjBGsNNDNX+flkvC27fxgS0cfLN4AFb4QqLM7MXrBs=;
 b=LT5Rd8lsc+zck+5rDhfFLo6X2zSHIyfIH8VD1xen4AtqiGc8V6lJ7dxyv4q+Oma+pt5monYLHy4y55r/h5yekgs+xQ/2yYXvq6m9zE4vD2xVnM19opyZ6lEFIak/2FX1aon361HPtGt6ub//VELYUf/VQ/4zzLb1XZSyn2lRYLk=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 14:05:42 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::7092:c19b:bd71:3b0c]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::7092:c19b:bd71:3b0c%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 14:05:42 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Wang,
 Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Switch to aca bank for xgmi pcs err cnt
Thread-Topic: [PATCH] drm/amdgpu: Switch to aca bank for xgmi pcs err cnt
Thread-Index: AQHaLQQByAxD/PywGEaOLT7omq4vhbClrjMw
Date: Tue, 12 Dec 2023 14:05:42 +0000
Message-ID: <PH7PR12MB7988AA212C51240B25FAE45C9A8EA@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20231212140304.11894-1-Hawking.Zhang@amd.com>
In-Reply-To: <20231212140304.11894-1-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b7629c3b-ff96-437e-8b6f-5af5c7cf109c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-12T14:04:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|SJ2PR12MB8036:EE_
x-ms-office365-filtering-correlation-id: 33f7f838-8f15-48da-8995-08dbfb1b6d7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3YqiuBkqu69uE+o/vSQl58dcHapOog/vpKcYbtH0xEfIhdWHZksmFhg4NL1YBPGY/Z2XQxA+YC8v1PPG5C4BmPg2T1ikoX//36HjuZVuHMt3HR8onZU0VaytroITWrm1yzW+vJ+Svn6cwTxAHhRsCpxG2CWqaFqPzvzfAECI63A1Tvy5amwf/8TbNGgbFL9O9Gh/g7/tWDFbWZpamXtRtQbDnIBDBUQ5obDtijCb3EwjuFDMPSy7Rqk9S+AR6qYGOy+nD3M3NhDtPknHnCDU/kPEt2u/fKh686K/fv+j5/QFxN2l17dmiiCMBnn9nEa+NGu2Sm7tpJsm7GvupxF7oOCtgawuU4SzOLXKB/TOp2kibBpm4Zm+gnkSULmMGsz4DTSmUud7iMGzobQDN8B6OABCkCTRzRrnNC4XBd8/lu9Y+me8ASixihhEkZ39G2lGxVXMzoHz+tSSAjBxpMs5jK/QidnNHBcwaIGOoVlxiPUdbuVpJwxrBTwaQs7buf37hJ1u2w9OoYfN+TEMWLbsXfVSiKN2IOm9snTJ2MZAK3AIcGfMqxTQqcIQSfCb0r59UB+hnA11ZP+zvky/pydGtwemzVPjo4x/zGVOgqVuGzbXkTTpYK0/W4WfGbDSqhz8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(366004)(346002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2906002)(15650500001)(52536014)(5660300002)(55016003)(71200400001)(38100700002)(7696005)(122000001)(41300700001)(38070700009)(8676002)(8936002)(33656002)(6636002)(316002)(478600001)(86362001)(83380400001)(6506007)(53546011)(9686003)(66446008)(110136005)(64756008)(66476007)(66556008)(76116006)(26005)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7itPf3AOXBZNtAt3rOyK4DEJGU9JT36paKG8Maz3AooES59370iAHJaKcqSv?=
 =?us-ascii?Q?ElYZkamVCuQ+sLihRHpymaiYctl3w0RzGV2CjDycxAVKe6VylOCjCz8mSw0l?=
 =?us-ascii?Q?srTqKjf9yvqz2xzMVF0k1akuM9EoYotgk9GSWM8FRFk/7Br+TsJpZzXgeI6i?=
 =?us-ascii?Q?z4Ndr+H6xXP092o44jrWgNaLXn5/WdZD7/f1WKdP/vN6TZtVNBrj+qH7soPh?=
 =?us-ascii?Q?PyM8pJMdyUlQPEGkA64jx7qvkgrahnGen/ZdexuYieowWRqRXTjIHgYheGIq?=
 =?us-ascii?Q?N7ub2ctX88ds54gHeqrc9yQbm1yGxpeCDDfd+HvEhh8743tYHJWkTVivrkxr?=
 =?us-ascii?Q?E+hmzFubFOS8q7QOJPesY2gcJZIorenZJPL0d+3B9a/ALtDPyC6QG2SYwZqP?=
 =?us-ascii?Q?FD7iZ/1XGpy/QO07BwhDJbOAjDPc6EHsWiEDWIRCHxBi60KjGWje/ZjzS0bo?=
 =?us-ascii?Q?Msr9oH/0FsJ38kDxZge1dryfL8HSbjkGV/Rn6hc5pKexSxDTpQL6BJfzMo8h?=
 =?us-ascii?Q?foUzlSqIsJF/oW7RZ6BtuWaXBqQpO8rPCrNsL/Sc6HroTI5xNJr0ZlXjwsoG?=
 =?us-ascii?Q?Njd+2tQesToyLfAkmN5OwqJHzMohfTCg1LkKB7SDwOoYXnrlKYWSz1JhRRqg?=
 =?us-ascii?Q?rcU8Wp/Y1KlcXVEq7uofZklCdUA1MVe4TqkxdpYaFhPMNKZFpYAB1Q7jVAnd?=
 =?us-ascii?Q?IgliY62do6qvLO3ObTZvdiN6K8DxipdRvjpC846RnVYFrmzV4flNH0Mqwfxg?=
 =?us-ascii?Q?EzOgoDj07cB5J0qhx2NynK81Jn7gldkEW5xH9Gt6SJDLPtggH/+n1nM+G7fz?=
 =?us-ascii?Q?JSLVqnphSJs/kii5lAk43QJFAo/Uj2CnaMfiR1HGhKZsVfdSyloeg5wpoSqA?=
 =?us-ascii?Q?tGPzQRR3hciZ8W01cqaKH/6FjFuZwpfV04TczLaUSLljQv/0o9qItkQ/agb/?=
 =?us-ascii?Q?5ifp8MXn6Ubg45aDg/QNJ991ZET7qwVz4Owgq3ZOKf8a6kbzqwbx5j1oAkvk?=
 =?us-ascii?Q?1h8sQR8NwvhrS6svI/DDf4EJacbjJbdxyMMViIdn1UTHf5Q/fr6AXLU5szeM?=
 =?us-ascii?Q?bONoeZne27hRm+IhUCVNiuvNwhNb+DJsNQj8czy0kZYh8nI7zx1JwTUEuUHg?=
 =?us-ascii?Q?gKgb2FwYi+NOI2jXOGxZ/eV8Xj+/kkmeRzYT8960LGVbZP/s7ojNA/xzLtn8?=
 =?us-ascii?Q?CKeCyRO7QArotIDQYMU7OWwUBkZ3JlUDwo+Uzvkcd/gbsQgY/a6lrCIUsW3s?=
 =?us-ascii?Q?12o1dBqQHVam+4FRi0nCZF2XlRrYUwIZxMuSHx6AwoBcKJjszdrAFrMgYxhZ?=
 =?us-ascii?Q?Y9ORSklnUkBWv35iphhVJu6pOURoPPrYQ/IhTZvaiXQrBhYVocFwoAFzyqf7?=
 =?us-ascii?Q?jNQSo+q4FMOHTrSVxujiZ0Y1Rsngw2xO5RW0Ml81TxStHO9KiOh06NUVtISS?=
 =?us-ascii?Q?Ikh1DRZ/7Oj+IxC+FkZl0ZlYAAB2yb9BuQN4eaCtpwB26igYpOb7U8v+VOHF?=
 =?us-ascii?Q?NfoauJ0t7nu7DNJktz6qKdNc65wVbW28BtpakPdZiFg6j8jzl26vY01Rl+9Z?=
 =?us-ascii?Q?V2BP0c3LuGJifPcjuPw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f7f838-8f15-48da-8995-08dbfb1b6d7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 14:05:42.2340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJUkqMMxRNPGbYhdbVjU66h20k/rLE1AGE06KjsFraClirKK/3PW5DBfb2CfMEmrFHez61HCxKMUUytPIcxjMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036
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

Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Tuesday, December 12, 2023 10:03 PM
> To: amd-gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>;
> Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Switch to aca bank for xgmi pcs err cnt
>
> Instead of software managed counters.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h              | 2 ++
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 6 ++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> index e51e8918e667..b399f1b62887 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> @@ -46,6 +46,8 @@
>  #define MCA_REG__STATUS__ERRORCODEEXT(x)     MCA_REG_FIELD(x,
> 21, 16)
>  #define MCA_REG__STATUS__ERRORCODE(x)                MCA_REG_FIELD(x,
> 15, 0)
>
> +#define MCA_REG__MISC0__ERRCNT(x)            MCA_REG_FIELD(x,
> 43, 32)
> +
>  #define MCA_REG__SYND__ERRORINFORMATION(x)   MCA_REG_FIELD(x,
> 17, 0)
>
>  enum amdgpu_mca_ip {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index ddd782fbee7a..3998c9b31d07 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2537,13 +2537,15 @@ static int
> mca_pcs_xgmi_mca_get_err_count(const struct mca_ras_info *mca_ras, st
>                                         uint32_t *count)
>  {
>       u32 ext_error_code;
> +     u32 err_cnt;
>
>       ext_error_code =3D MCA_REG__STATUS__ERRORCODEEXT(entry-
> >regs[MCA_REG_IDX_STATUS]);
> +     err_cnt =3D MCA_REG__MISC0__ERRCNT(entry-
> >regs[MCA_REG_IDX_MISC0]);
>
>       if (type =3D=3D AMDGPU_MCA_ERROR_TYPE_UE && ext_error_code =3D=3D 0=
)
> -             *count =3D 1;
> +             *count =3D err_cnt;
>       else if (type =3D=3D AMDGPU_MCA_ERROR_TYPE_CE && ext_error_code
> =3D=3D 6)
> -             *count =3D 1;
> +             *count =3D err_cnt;
>
>       return 0;
>  }
> --
> 2.17.1

