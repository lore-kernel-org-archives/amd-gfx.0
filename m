Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E37C47422
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 06:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C1A610E02D;
	Wed, 17 Jan 2024 06:34:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C03F10E02D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 06:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Li9IqMriqvLgJVQTs8awrd6XI2MqhVQhN0+tsPaDZFx2Rfl+MlpBm4Rxm0h8mJlb2Ag1HQHwyjNjqD+V01UpciuXa3aTagzjdSKe+d2LkfoO7d98WaHuefqdLbN4vWJCS+Eqpwq4ol86Un1rFturMS5lDZ0klMz4KJxk0usnHKdxAnRHbSf5D1DZP1/QCgdhD1QAO/rCN04qz8cuwkjQYWxg3hlOhpuGrgUDgsaR3v6d3CnojGLAKyJrvHioUB3KQjS2bdXyZS/kZfgMAadxJeJvs6us2N3VAnV+n+lMRoDaPVy2F2tqiAB3pe2rodxhzGuIOlmHXWjhXWaU3QoPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpZeUxKZqyGR8V/D9m8i7SzH00ZPUYVuqzEhFD5252k=;
 b=CXaX4DAsejlHFcMC2MhHmoY0oTZ3Yj47Jfe5K3jtUuuH4amiMeaazTosUAvWjKcjxAaeI4gohIbV/UO/EUPi1egajtsqtdYOSr+4je1GtNeP18VzioPMz1PAIaEebqb6DhTfs4ovE9s3TgeO/TQcbbknh+ShDU3Kkn7/piEsDS2L35cjm/JY0o7O5IQoHTPPsNfBV9rbgjPwuttkf7GbGS5wb4AEVxCbf7CeLNdy6kdnRB1xAWRt3W+4NZwM+JCHD1oCur6Qyk2LSV/R/vWHFEJbE5iLW/NBx+T00mdKl3Q5iKOnlSPF9ofGSM6m8ELa3+KycysKNnNGbaZ6Tt+2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpZeUxKZqyGR8V/D9m8i7SzH00ZPUYVuqzEhFD5252k=;
 b=GrckmJZDQISULtS+6TvJktlryNhj+XA/JHikGezlhLQ0s8Aaxv4TlJLyyzT/V7RLOsCgCdkv4YvUAYOb9aGtMZVAH6i4PmlGP7lgl/ziO9h7hWjsxm9wTJOdFYlvhhUYXlhqaVhXzWr4arbF3NfEXvHKQhZqdVO6Y1Daxcq0V3E=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 06:34:46 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66%3]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 06:34:46 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix UBSAN array-index-out-of-bounds for
 ras_block_string[]
Thread-Topic: [PATCH] drm/amdgpu: fix UBSAN array-index-out-of-bounds for
 ras_block_string[]
Thread-Index: AQHaSGuR1xDYTYlKqUmM949xFvK73bDdjZiw
Date: Wed, 17 Jan 2024 06:34:45 +0000
Message-ID: <PH7PR12MB87960001C5E3ACB2F3CD93CFB0722@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240116110204.1352227-1-kevinyang.wang@amd.com>
In-Reply-To: <20240116110204.1352227-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8a5877c7-1258-4583-a590-a0c3652b733f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-17T06:34:26Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA1PR12MB7367:EE_
x-ms-office365-filtering-correlation-id: b351e2d7-f6f0-48e0-3508-08dc17266598
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AeMCA9zfc7GT9lp7kYJ+3ef6uV0Wwt7JC4Pv8CSjprULdzZKe7eSMTKRkxb7l+7SF2ZHIOF362NZCqcjWaEi8xU1h71t25c9eBghs752scQKsLr/p/4IEY4WnAe1Dqa2xSW44mj1r4ChxTQ8ShmJMf1Ilvz4e1nhVZ/y/tls6vV0LY+Toqj5LUCJo4gsHH+IBT2ULbhcsk+Mxl5kuGyo/PpZTSwTh/+dTY4wAAOpAv6kkzNBvp0Mbh4x1JkqSPFFwmOvCd4hTrjupaul0Iqxv10wbcWUgQQyJMZH0GyIz0dtexEVgq9pX/aIMroVaGxQRTyQ+shaAHN7cybrIur95S3F894a6JdWUxMGHAsmNW/LYSI8JsIiTuPvEA/LaKVI+OufkF1atNeYoyd0Q1GcKTadxGeIA4x7Cm+o1TwNQ2Ah791udlY4yY/i9P2uV/eNrZU6AThFa8GOnqgzgm2+Q1D28uRM5H8aF51Wcw0Xmwl+nk0nz860VajVpbd74U+YALbkbeGTkzpm5WDjniL5SOGbot8rlotZ72vCI5SQJvxIJKz6n1He4BuZvEuJaYWON6cin4MLTeyIccbwBtiSAf1a4XN70LwAlZgVw2AHpcjQtR69rvUMijOzW9nxa/pt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(83380400001)(122000001)(38070700009)(86362001)(33656002)(38100700002)(41300700001)(66556008)(66446008)(64756008)(54906003)(66476007)(316002)(66946007)(110136005)(55016003)(76116006)(5660300002)(2906002)(52536014)(8936002)(8676002)(4326008)(9686003)(53546011)(478600001)(7696005)(71200400001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9UIpIW9m46hZMe7yeFlCv+1JDTGckPijNi2r+69nULUG/7jsJUma6r4Zv3Mq?=
 =?us-ascii?Q?RrPj8tEuM89ADATbDO96wtuAWk66kN26cUpCEXyNFtYm0Ulac7Q5JunT6C5g?=
 =?us-ascii?Q?qeGwmgtbjqq1KbpL31QGvarQ3xTjxbnwM8NJaBlueFxf5/Mp/fnJqXYDbrR/?=
 =?us-ascii?Q?9JycaUNhkVhJfXZTtv0ACtfD5yUAlBiCd3+7HaU5uVOPbC+nQqhj7KXhPS23?=
 =?us-ascii?Q?fKlkW1Gvj4PmHfdCtT4q7qoBY03FJr1xmL3wAWPaBnNC/GWZcDzTnxrh78LI?=
 =?us-ascii?Q?6sFFAP+xSdgpfD4nc0Y/337I0JXNRERCgdpR+ZrNep996MMmfxQfTRL1ISEH?=
 =?us-ascii?Q?KxIscRaSA3GwGbM3sTep9rzwAGiLVPeLyrltZ6WaWA+riRHC8DVu/BTu+eJQ?=
 =?us-ascii?Q?o4LrvOuT/pIideLARR6rDoUsosk+ctSuWGm6e++ouuggH2jcqaRCY3shaq7v?=
 =?us-ascii?Q?5x1QlXbHB9fnwpCVfSdSikkNMUH02tSL/8WZV5S7LYHjs0t6uJ9EIL6bB6kO?=
 =?us-ascii?Q?4DFKFt8veuFl61L9efSvN3MBCavIj9wflA2UiyfoD2HYPgsX+3aPMV99jmed?=
 =?us-ascii?Q?fmouz4bm4ZNaos1gtJtznk9YocxZLvzIPkpoyGixVYZ4Jmb8jTcmyaYH8cA6?=
 =?us-ascii?Q?mGXQYq7RaNSW7sNrTs2QYPAlK+YJlipFjLSPUFZemBNHniexfx0c3EcTWUDG?=
 =?us-ascii?Q?qZnEiD9l8SctQxm8L/fWHkq4buLBuMXFNhHPZDYKN4MOKv2LDoPi89ZB0O3C?=
 =?us-ascii?Q?VhbpEz00tFQ1A1Xudahf/2zDbkPKqrAPgC5WuwPIyxPsX5npW18eg0mdq8iX?=
 =?us-ascii?Q?Qp3r9s04lApgrrNZlCzKgTKZ4ktulIKh7UDWsYrWZgToh+sNFy1Y9XO7aivO?=
 =?us-ascii?Q?5uuyEBFl/IcPnTWvW7TeaqFi6GdDa86LoVpDG1tdvJim3D7GPynKZ+ba/rfX?=
 =?us-ascii?Q?a5PKl/jYrf42nE2ZdlUoem5RCGujYxvcUrcJ/6WzMptYFtbXIiBH/DxhkBDe?=
 =?us-ascii?Q?4Y68vT3soa1TfUCPlz0ZWsCxnttCFwxcbmb3FVcS93nl/TuLb+Yy5ABCp2dJ?=
 =?us-ascii?Q?zsU4wqZJb9vPbIbmG94Df35PO7WYRxH8lFRUhohKLA8XAsMO2oUyRR4j0RsT?=
 =?us-ascii?Q?WsnDETlGVaNZIDHk+GHalu5yQpwhvKFTK1XkoWtHnKF4Bd8guj0/5O4Tvsd7?=
 =?us-ascii?Q?o7Gy9ICjfCxMe4Ghm/gkdgSFp9PT9Id3HfcRCZEj0Ls4641AXdSodvQmG2+N?=
 =?us-ascii?Q?JGpz3LKlfeE+xGVz6piV070QOfdqKP2uMM4pwbOcJStvhiHeTgwjRxtelpwh?=
 =?us-ascii?Q?YGsA/LZTPsbon2yK4c2mBA/vn21KPQlrTakkz24J76SkzNEMzVejt39bQgGE?=
 =?us-ascii?Q?FAVxXGQt5ddw/YBF9d0lI6N8rucfX+mu+qpyg9wuqdeVqUKizI4aqVWDLO1H?=
 =?us-ascii?Q?vwqlluvIB+c38tX7zYyDcxk9Xzyahre5FJ9wW/GP1ys6zaX0sCfZDnWIGIa0?=
 =?us-ascii?Q?iucepBAU+L5KYBm6FScvIusaFZxckM62l63FBVtbirP/9V1IeSaExDFb5f23?=
 =?us-ascii?Q?ff8aZ2ziMtM0EUkyiak=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b351e2d7-f6f0-48e0-3508-08dc17266598
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 06:34:46.0060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JBtemCcS5hOQd0Snmcj5HXT46CEPgm8OfjjCiGr2u7NIQMVQFoBguUZrfg0wK6/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang
> Wang
> Sent: Tuesday, January 16, 2024 7:02 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: fix UBSAN array-index-out-of-bounds for
> ras_block_string[]
>
> fix array index out of bounds issue for ras_block_string[] array.
>
> Fixes: 2e3675fe4e3ee ("drm/amdgpu: Align ras block enum with firmware")
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ff6f84714f68..8004863719d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -74,6 +74,8 @@ const char *ras_block_string[] =3D {
>       "mca",
>       "vcn",
>       "jpeg",
> +     "ih",
> +     "mpio",
>  };
>
>  const char *ras_mca_block_string[] =3D {
> @@ -95,7 +97,8 @@ const char *get_ras_block_str(struct ras_common_if
> *ras_block)
>       if (!ras_block)
>               return "NULL";
>
> -     if (ras_block->block >=3D AMDGPU_RAS_BLOCK_COUNT)
> +     if (ras_block->block >=3D AMDGPU_RAS_BLOCK_COUNT ||
> +         ras_block->block >=3D ARRAY_SIZE(ras_block_string))
>               return "OUT OF RANGE";
>
>       if (ras_block->block =3D=3D AMDGPU_RAS_BLOCK__MCA)
> --
> 2.34.1

