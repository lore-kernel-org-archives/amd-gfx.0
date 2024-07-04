Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AE7C30653
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jul 2024 06:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E2410E1E1;
	Thu,  4 Jul 2024 06:20:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pVk7k7AL";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 709D510E07F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jul 2024 06:20:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqfPaFcFJ9JMzxVsY2yZRL5iqLieeyggZxXpjFcvRdBLoJsy0clfD01rZ8OkVheft4G9abX+ZOD4O6APh0jShImBvnQg62+rUZSc+y0vjOTRoQXHxWpSv+Ii123PpN0YRW+CuGnaPZRGnddL3CkO0GHR1IsUF1lurlOPUZ8Uz4bqdHS6A+9F+5adstxRCQ+w6V5/y5YiJlCcvPzytwhE4aqpAAqGVm1qi49Qt1xOO1T7OarqARCkf0owAjTFc/wPexV01OFoOiC5TdnV9Xoqw+tYtbQ32dJhr2HrLxt433sPKu5nPY2k7t7MEtCt+1/Ny8xkBse5gPByI6PnuxrxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKBGtzjE556MtRp04A8oodxa+VcwSDT0pzVI9CCw1gs=;
 b=ldMyKVAl2miyjXfDJ5zdSgwLgigwTkCHnkLAjK7n7soJAaRngs5lPOire6ZL2+zP2+JPDLChNbl/qLOuguhIEd1kQWKES8fe4SAsD3IO/bDfTNLdu1oV5tI32gr7769jHsnjF5j/27VjHCtkIZDNkbo5ouL9xtdfWBc8cw5Elrnjj/nN5KKCMlanJetLl28G0fJi14LWEz0GYfLjJuBCLQjjiN/vZNbTPN+FCC2gQ3JkcvX0cnZb2TIozG6ihgDMAg8yvNzVKSqXC9+dA+M/da6yS2WweZfCXIPPUnSUdOQb43S3HQVGBROwCkVmFHQx1ewG+yYTlfEIXdnZpj/J2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKBGtzjE556MtRp04A8oodxa+VcwSDT0pzVI9CCw1gs=;
 b=pVk7k7ALR51kvU/eFYLfTL2t6bPzm52GfmlU4wkGClT78xiytk7XkO2pSnEeyOQOVGJh4ghH1D1KvpG7UEC/75rDsc6A21HfCFlpfOLf8vMqGL/jrqtsxO75TK6p+01t9DJtHr9MoPKH/g6LXszQhztvkCHyONwQBIgIDpvZ954=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 06:20:16 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%6]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 06:20:16 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: timely save bad pages to eeprom after gpu
 ras reset is complete
Thread-Topic: [PATCH 2/2] drm/amdgpu: timely save bad pages to eeprom after
 gpu ras reset is complete
Thread-Index: AQHazSTzKueeyxWXXESfbp/jckGzNbHl7WcAgAAsi1A=
Date: Thu, 4 Jul 2024 06:20:16 +0000
Message-ID: <CH2PR12MB42151A5B5CDC8E6D23B77E9DFCDE2@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240703084127.478058-1-YiPeng.Chai@amd.com>
 <20240703084127.478058-2-YiPeng.Chai@amd.com>
 <PH7PR12MB8796A71B78569E3D10D68ACDB0DE2@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796A71B78569E3D10D68ACDB0DE2@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9ed1d75c-486d-4d3b-87ee-ad91d615dda1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-04T03:35:27Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|CY5PR12MB6407:EE_
x-ms-office365-filtering-correlation-id: 37c9b0df-e3fc-45c6-75ca-08dc9bf15ee0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?duaCW/GLB6WHueNWivKP1Pk9BZxryBneQkr3Q7qFNm972INuXt7YQWnkqloy?=
 =?us-ascii?Q?1IeQiXZ/pm8Ju8K+opn8IZ/2c0ARxuphpLDDj2irM/Bd7JTc1vhkoGIJfVr/?=
 =?us-ascii?Q?eljAaIsMFKjzK+09hNXk0LiArPeGdPOPJMCKE087z2128Uixs+NoRqge2HOL?=
 =?us-ascii?Q?E4Pv9W1i9Uu3KnVrRNOSSjWFrMaeixM7PUodjBXCL/giYoT15x2pUTibwFpq?=
 =?us-ascii?Q?7lztN/LBDVFjLygxMFxrbsM/nsOkxgp/NqTEipA3u2uwaUMsMXjSS07NgKdw?=
 =?us-ascii?Q?mO0NT8ER4TFUavbKHruYRSlQkQoFP/jVHGY2L/fwczCNL4wdToh2PZ8n8y3T?=
 =?us-ascii?Q?eChK/AZAty+GJvL0bfm6Hwny2/c18b+o4j2aIuqNNLaNblmavQj6DkQKpkaC?=
 =?us-ascii?Q?Aqx2YJsHLK58QB37kiJb7Qpr/p8LTSlO/WsrYhxcSB0sZEeAGYIXfWdYa2AD?=
 =?us-ascii?Q?wIB/T7oUquaY92ZzlqTiITnP1DsPuLm4/Lie7GSp/J/2+V6HqWs2huS7tzoG?=
 =?us-ascii?Q?DKTsyJqVkaiW/vZkMTp+5wspeM66jXJ/C0Re1EPD52npfFfnLRoqjQ8cWetl?=
 =?us-ascii?Q?c6Mf9oe1C8CFGDE8QhoBvp9g0XDEsHJhMVvb0TBWA9RNOWc6AYoYXqYEwISx?=
 =?us-ascii?Q?i0c9ZQMuXXCXjQm6L57ii3MYIsu70C1qMNZ6pHoWocdky1ONNhgyj8cJNGT3?=
 =?us-ascii?Q?wncu/XOqNu9YmmgcYwlmgUyXEIakZgTY3T2jLfUAdUJ6MSFOJn902cL/VOrL?=
 =?us-ascii?Q?0ZHZVqKaN9VEMuFVPCmKVJenGejwTb4Vh862lfaQPeHho6I8NnSxiI4THFc2?=
 =?us-ascii?Q?PrbXttCTMWkmcd3cDqRen3QMV2TFTIadOzfo3deuO2b6vRFzKyzP9l+I/Mvi?=
 =?us-ascii?Q?UqjWdcmbG2jF5fpl4HmSAhHAgmMNZr7L7a8yEIH68U4+DwaLRdQJH+MkwRR2?=
 =?us-ascii?Q?W7BLUWm2xtimnGnYjo2VuODuq1CRuvcTRrrDux3mww3GZ328PJ/lsKkX3nGJ?=
 =?us-ascii?Q?OVsr38zaQ37/ejFtdZN/n7BiNbQMj/+03YfEJwDLitD4byG2lSb4feKFP2uC?=
 =?us-ascii?Q?MunIeDwIn8/bDZpzt2mhoPTRIyiODPdPpm1EbAfuG5V4urseLxexp5UQv0j+?=
 =?us-ascii?Q?QxsrpHqr6ms/fs6RS2Ioe8iYEEYro/lp4S4dDDAaxno/hZa80eWm8xRChg0K?=
 =?us-ascii?Q?NsISHf21lCAhYdw9y+2rNCuyMye8685jiTKR4tuVqf05CHd4ge/Y9Efg8dMH?=
 =?us-ascii?Q?i18eb7MHWKeQY+pso4UaF66XtNT2P8zSFITlINOuyyugIxViIUMTaI8q/8Ut?=
 =?us-ascii?Q?vzdqyMZO7XMMXAbQ43Zts0xwN5QgQ971H6jbwdzz96hHIOSd7xsxMV+EbSIW?=
 =?us-ascii?Q?UsZYWmF+TqTx7H1BIrldDRCbKeaUDtSJn3s7QDpKIMhw63FW1A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Khz/ngX1Ax9LqA8HCTE8fTIstmOsD5h+tjhn5TsTDdDky6XJ7FgXwN4A8yHm?=
 =?us-ascii?Q?tejbeefZNZLdwH52uoRCiP4QHoniJZftgR5iPCZ2teMvwJ8aWSI++0yOwKKB?=
 =?us-ascii?Q?2sM6mwSJ7Cfr4Uw/xw1/qJX5wsz+MeXMF6+vE+AOGhxdEb81WUTZFMys3gnH?=
 =?us-ascii?Q?CM9hVOEVHxw4eXmCbPAbQRm4KRlweYA+lP4CLsn1AiNxCfFdZ9rTX1m/7xl9?=
 =?us-ascii?Q?hT194zfH7sxlw13IGYXkeYj+1DFaoNfOVo0/55FpgoWQgJ51GXqYyCSBnA7h?=
 =?us-ascii?Q?EKkZ/G6l8wD0dlKaP0AzZFRUmIiN+97DaA1mL5gd+pd85v1bclnKEcwpVla/?=
 =?us-ascii?Q?VZ/OiGu5LNReU/VBB1/T6sK/xUOQ4kdRNBhxQY0eDRfvASEaXFFxwkepxV2N?=
 =?us-ascii?Q?HzyhmPkxT6DUrP90ak8TBVg7j39ipgaAz4GIFiYua+EJzyL7BFXqVgmBxCgt?=
 =?us-ascii?Q?qpyPmwyNcWh8Eja7CvxAVTPnNlEefbj4a3goOEeSgibrytTSUXRkLJXG8kTZ?=
 =?us-ascii?Q?hh2WSceYUIMSKI2FmpFRnhMhUMCZyNs5te7/7r6+tm68l1nfGQdGQ10MuRBK?=
 =?us-ascii?Q?T+JPgGHRgrIACv9i6EoLQauDAAzUqpv3m7YtCasvvWUEmSUYobqmrtOJ03y9?=
 =?us-ascii?Q?qnIMLoDZUaHYP2H/xUpNE+dEh/oEHgt06K3CXjr5iZCMdvBV5WzsUnOSwIW+?=
 =?us-ascii?Q?i3uAJNxj7ZHu018sRSaedI+1oiiNacvdYXHS+TyhhyS5oJWFKG4C7T/coR2r?=
 =?us-ascii?Q?oqouGZoe1MI8XLO+vpBT+IuBR1a9PPNrZeliJRWmzGJmKRC6PnNy34HBpPyH?=
 =?us-ascii?Q?PlLNzc/Ho6nEl2T3FWbO3jeW1wupUUtAQr5HUauMrA6tAk74feBIXQBzkMQf?=
 =?us-ascii?Q?nHHi3DlEKDLRVwuHnNxeAr7ZrCTJHJJKmXCPBANgyKyn5w9ibv37QOJXqVrn?=
 =?us-ascii?Q?H6Zr23cjU69qNpqpCW5fL0ItwH6VsL3SuAu/EfY6VvclRJQm9FIBYDeImPBH?=
 =?us-ascii?Q?KU18j+Y7KGTtELZIilQm0JSIcKLSKkkFmpNAH9szwufBa7AEu6wScgVcKiN8?=
 =?us-ascii?Q?Qn5jweFWHLSonpfeeSFZVu80A4ZGsU5xqiCN9XM7OVW0sn9dtxYemyVvRaOY?=
 =?us-ascii?Q?Q2gKLEtW5tGgSMFOLZsbGLky5xMzHzTkttiZAJ6cRVEebTjhtLAs5TpX42SC?=
 =?us-ascii?Q?/f8MSXAO4LeClw9bYiWdicbl/EPhAva+ipW2F3PoxvWBWxaEnTJGFb82rwn5?=
 =?us-ascii?Q?sd6bXegsLxq+/LUOuISi61MCUbMh/l7EOoHl/JK7IKlFHylFedIYL4EGVNWK?=
 =?us-ascii?Q?2VinNhJb2c8aiB/QEJbAHA24328OGlTvf9c/U5g+punRdi6n7RBd0hVFfW3T?=
 =?us-ascii?Q?NVr1L+x3yk7ap9qLbBlsLULsfA4XAQnkk4SnPTjZvfOY9sLDF5RJOs5Rs6Cp?=
 =?us-ascii?Q?Ym4Dy9WtGQIMA7ufwnyh9PJMqs9Xbh0yBhCbYQdlaoISoZtlottHo+VIeInQ?=
 =?us-ascii?Q?W9TXmd9NXZRDwQsAH0amNohh2k3xxC4Ro7qZW1QBD5PUT7xNTC2R3dKtiUx6?=
 =?us-ascii?Q?zL7Tbl/yU4XkEbsyLdI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c9b0df-e3fc-45c6-75ca-08dc9bf15ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 06:20:16.0802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xcxd9g7fjBVe3aK33vtbwDa2Dbc/bxoaF1Rckk6s17NYkT3tVtxdOWroTlaR7/AEfXb9encldrcTjnPUjs6waQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407
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

-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Thursday, July 4, 2024 11:40 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@=
amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: timely save bad pages to eeprom after =
gpu ras reset is complete

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, July 3, 2024 4:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,
> Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: timely save bad pages to eeprom after
> gpu ras reset is complete
>
> The problem case is as follows:
> 1. GPU A triggers a gpu ras reset, and GPU A drives
>    GPU B to also perform a gpu ras reset.
> 2. After gpu B ras reset started, gpu B queried a DE
>    data. Since the DE data was queried in the ras reset
>    thread instead of the page retirement thread, bad
>    page retirement work would not be triggered. Then
>    even if all gpu resets are completed, the bad pages
>    will be cached in RAM until GPU B's bad page retirement
>    work is triggered again and then saved to eeprom.

>[Tao] can we add this description to code comment?

[Thomas] OK

>
> This patch can save the bad pages to eeprom in time after gpu ras
> reset is complete.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++++++++++++-
> drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  |  6 ++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1b6f5b26957b..b6e047a354a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2844,8 +2844,20 @@ static void
> amdgpu_ras_do_page_retirement(struct
> work_struct *work)
>       struct ras_err_data err_data;
>       unsigned long err_cnt;
>
> -     if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
> +     if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) {
> +             int ret;
> +
> +             mutex_lock(&con->umc_ecc_log.lock);
> +             ret =3D radix_tree_tagged(&con->umc_ecc_log.de_page_tree,
> +                                     UMC_ECC_NEW_DETECTED_TAG);
> +             mutex_unlock(&con->umc_ecc_log.lock);
> +
> +             /* If gpu reset is not completed, schedule delayed work aga=
in */
> +             if (ret)
> +                     schedule_delayed_work(&con-
> >page_retirement_dwork,
> +
>       msecs_to_jiffies(AMDGPU_RAS_RETIRE_PAGE_INTERVAL * 3));

> [Tao] this section of code can be put in a function to make code reusable=
.

[Thomas] OK

>               return;
> +     }
>
>       amdgpu_ras_error_data_init(&err_data);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index 0faa21d8a7b4..7bdba5532adb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -29,6 +29,7 @@
>  #include "mp/mp_13_0_6_sh_mask.h"
>
>  #define MAX_ECC_NUM_PER_RETIREMENT  32
> +#define DELAYED_TIME_FOR_GPU_RESET  1000  //ms
>
>  static inline uint64_t get_umc_v12_0_reg_offset(struct amdgpu_device *ad=
ev,
>                                           uint32_t node_inst, @@
> -568,6 +569,11 @@ static int umc_v12_0_update_ecc_status(struct
> amdgpu_device *adev,
>
>       con->umc_ecc_log.de_queried_count++;
>
> +     /* Try to retire the bad pages detected after gpu ras reset started=
 */
> +     if (amdgpu_ras_in_recovery(adev))
> +             schedule_delayed_work(&con->page_retirement_dwork,
> +                     msecs_to_jiffies(DELAYED_TIME_FOR_GPU_RESET));
> +
>       return 0;
>  }
>
> --
> 2.34.1


