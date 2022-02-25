Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E974C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 05:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 793B910E1BB;
	Fri, 25 Feb 2022 05:36:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3879510E14D
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 05:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baUpywADdStMRcUQfY6Rh+3nxFhkeJqdHCg71u1ApOPTRm7PYfOVT9nf7XsKtfz5UySy+v2fWsYTpdCb97pHV4/PuMHMhZgApbhvlsoboHDMKrbJ71/xDS9HXVGjiCAcYFS2HzYp3d95M9EI/nRDSJwrYOo7Di7hygmDnTX7fuGbGXCJduUt6BbU1h/hOv8cY9gBBWOIu+7oxwQcta3YwOtuO+PTkiJRtNEeFPu70GsK4DnDCXotwWc0HgdCBmSvB5R3a247STwcfQtKLo8YeM2HwyCyT9fnep1AGAEn0FP5roYBMz5h1bH6YloZWIq+XGVNVpTuWwVUHL3eM1oidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxa5iYVHCOUrGcVD4irZaPKg4vcSTLpXS4YERSesDcw=;
 b=NghYnrqTEOnovTh+TyqS0vWtfZbfnmMF7WVc5JJfUrDg9U4v2xUIGTokUEiPdUYzDpIcOmYgntJNU4CBQWVPTGuIdvXRwxLE82mmSxDpom8NrpvMC/mvMDO6WOMUxMaPCuycJhBNFGpGLBnz+xY0jvy/V4PI6XTNcN8WFtsqhxe588qr3olxWnW7UyWF0LHxIBOIT7iX/1iBmi5b/qa6Jvpe+cTSw8Z0DMM/Gsmv8M9HpujHj77QTbMA85zUSo3X6CU2NtNxEPKWElZ5Qp3B9FOSWlQp0z0Ajg8VwsTVa1x4/lyaHuHlnPVZK6L7KjLOQDGDgbXrGor1W0hha8eaig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxa5iYVHCOUrGcVD4irZaPKg4vcSTLpXS4YERSesDcw=;
 b=POdZTMLs0a1tW/ZRxw3hRx+MnCrQ7QCJtDfbfe/oVQeGm9dzAEWf57Nv35nl2weefs4t8xL1OZsYSaoXpgkhIUjw/nSb/O/S/RQ4PbT7/OjAe6RMCHrhxeSirKNRGchWICgYvVg+/vlGQNT23C7KigxtS6ojhm3S7wwj+26yTag=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BL0PR12MB2530.namprd12.prod.outlook.com (2603:10b6:207:43::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Fri, 25 Feb 2022 05:36:46 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::7d61:f517:f3f8:9ea]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::7d61:f517:f3f8:9ea%5]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 05:36:46 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
Thread-Topic: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
Thread-Index: AQHYKf9K+ofRHyEfkUKWe1QTzunzDKyjvH1Q
Date: Fri, 25 Feb 2022 05:36:46 +0000
Message-ID: <DM6PR12MB2619202956D5AF431734D5C8E43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220225042156.676421-1-lijo.lazar@amd.com>
In-Reply-To: <20220225042156.676421-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-25T05:36:44Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b109171f-1a1d-47be-8559-ddfee2a8b805;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-25T05:36:44Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 0dbc0e8b-40ed-4529-ae23-4406fe6633e2
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7978d32-ee28-40fe-cf44-08d9f820d044
x-ms-traffictypediagnostic: BL0PR12MB2530:EE_
x-microsoft-antispam-prvs: <BL0PR12MB2530337D9D868AE9BAE6518DE43E9@BL0PR12MB2530.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qu7c0ra6h9YjVQCgpSz6kpN+qTClsY5qIkyTwWaR/ne3//4gXXqCHtfQcolvIidldAbW5ldcDmY4WslVbUQVcFXj13Dqd/ZaiiP4u8XiVT8vWEY8G/YVzKJB3sDO9oE/D3SJmAbWyz3p0KAN6q8V10nhyT6C7yLOV8pEor10yIQuAqbldt9nGTPOF3PlpNlt7NbenYeIcnWXBc4+QRaarGPm+hlyR2Z2z4ed2WABJBiXKnM2jk0mJUWV1lNqxspbKwLl4stm6XvDgxEHEb8XFD11yfyQOr4NryP1mKN31Qsn+hICMw65ku73wZND3XKDSW42GFgECaPzRTg++2GSYfI019QpmyQ6C334wwsGhzrB3g2xZohODAySWii7EFDqBRleSMQ5MNSvi2oTTSTnlnpIWjLK8Kl+eDXfM2lTTvrWXJ8p5hCTd8jS5dM1c+HVDd8DuT4TdlEgcUpR3oEx/TuVNkOZVdL4MrDhXjKRbCmvoxF/SzAGGDalGGeUx+ZYGnNyTkc7pyibzXErCJa6fa4WlGnDu8GEzqUFqRaGF0VHmBdJQueR57FEVLq8FTlP5ihHfpn1aFdp3HgltDumEYFNfyvBBM3RGhrikmy0QmnZWIK7UBxmVav0WDear0g36Sh4IGcDLZM+ABNniI20s2ppxmQagRjU8MbCxBi+zByMYtifgmo9HqR43ftr3Fi/FAtv4liG5dQglmeyH9tPCQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(110136005)(71200400001)(4326008)(9686003)(316002)(6506007)(7696005)(54906003)(33656002)(53546011)(8936002)(76116006)(52536014)(5660300002)(2906002)(8676002)(15650500001)(66946007)(66556008)(66476007)(66446008)(64756008)(55016003)(26005)(83380400001)(86362001)(186003)(122000001)(38100700002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/f9TYqo1wvsSha+BFDQMJwtuPWumsnMU49f2f3mQpnMXkxbFe1Qko+VqSQaj?=
 =?us-ascii?Q?CJSkiHnAg6lie+Kc01bhKTLI2OEG+NsNPFz5aliwfg0Qh+tJxpIUCVHUrMFh?=
 =?us-ascii?Q?Lmr74A9z6f/4kSdSkuz2FGgLk9+KzKjlWlXpdFKOFBJM87A/XZ/AdygQeVUi?=
 =?us-ascii?Q?b+eSz6nkc598EPhgkgkDy1RiFX5Lnt4P8RFATpblTlIPWa31UxJkyeLfeKWx?=
 =?us-ascii?Q?xH0CpZw6TS4V26vD22IyUMZ6DQxj7nUNn8iwRcTfcBxUTaA/fhYwLeVryLui?=
 =?us-ascii?Q?qcTivoCyGz5AqQ0UhIH2DrRz0B7fLZzNPK80t9SNCjpENNGv7d6yx59D6O1m?=
 =?us-ascii?Q?EMWT4dSH0mTpV/qXMZkA+RyJ+WXovtDtQM9Q2/S7kR0p4/EkHc2oXI1mQlSP?=
 =?us-ascii?Q?B4DuUfnNo8G6asnDKtiUkJ2aIoy3BuZiV8p5eE4PA9dBXS0wl8orIteGt4ZO?=
 =?us-ascii?Q?0hx30MzoCVuVQObJ6wt9pg5RsNz1aSduonFzcCvirok/jy9M6AGbgfS997sd?=
 =?us-ascii?Q?UhAqfYjayiJdbzNPPma4bVxldnVob+TAbNDQu6ul2zZ/EvAhFao5QuY8FObK?=
 =?us-ascii?Q?1OjP/AXUEjBFwY1HenlYmRJ6r9WhCUcfWOWI8wlxvzorfnt+uTjLgj6MdcgB?=
 =?us-ascii?Q?AYWosC0Jjy5BDePMX8569tv4ULE0N2Jv8n1tcfc+SVPeSVrpvZT9rQDXpBib?=
 =?us-ascii?Q?GXlwNQ7Tg6jlQ98qoEXzB9ba12wDA/SMbZThM9s6vIwKVodLM/v3o3l0ki7v?=
 =?us-ascii?Q?IfIR3QQaiC1giTEDw5pPNghnQJveEUR1i5V37DHaW1PUpK6aeb27HuY5tMcG?=
 =?us-ascii?Q?CAuBKa6KNYQCoASDZeEe8VFLMIsm8j/Q/o2gmNXYkVWHm+++TlNJBdUkNf8X?=
 =?us-ascii?Q?u+s0vniBSPYjGgh2nFS3PC8rYdQ1TwvfubX4s0JEoqaXL9fcHnLcX8sTsZAF?=
 =?us-ascii?Q?/mcBfZJ+dYRcLzNU67FXa8fg+pj5vKgnq4rWQ3WEXIk0c40ruXG/a4pA3QVB?=
 =?us-ascii?Q?3lXX7DgwdnySJ8HSxb78URYsZp2wDcR1r7LqPx/sVJjaSCKvDsjEdjb3o8iJ?=
 =?us-ascii?Q?XJ7SuITBgk7xPJef3dV5boyJCTC+lgl2b1TqyWSjdRVbHCaHhXzuhcCTIYIA?=
 =?us-ascii?Q?Ou5uz9WuVee4E2HMX60imIOW42/Mw5r/HQq5JdD0scLXrUl+BXmuVK03VzaD?=
 =?us-ascii?Q?hVkBulF7d/tRYUffc7q8n0tGXRI8e7mzXedF42ie06sGrfF45A3sb7H2noG9?=
 =?us-ascii?Q?+n2bcimxU6r/i6vvUhbQTmxfgzYnCSPRWs0PPF+5E5wnjBa7k1JzXvT/EbUZ?=
 =?us-ascii?Q?lxC0A6xqZQ8w3Q7rKwSxHhFhSMFwHqxBjsmmL/GwK4RITIV1dFDQVVH2n9U5?=
 =?us-ascii?Q?0XCPRk0aSAe3cZhTt3wAUTRNmuFMkFWnxR+PrPxgI7Bh9NaKtLkmzOVF3IQU?=
 =?us-ascii?Q?LXYzu09YMHIIDPkZFz8NZTq7yES5K7wPSkDkmVK3XqxA7qnBv+ImaKRSHkNz?=
 =?us-ascii?Q?QGYqkzZNvI0nxgWAu8FHTqWRj2GRU0TDG50wJjZCI6Y+O81HekmDqrEvBGTy?=
 =?us-ascii?Q?HPD947u70nWOLUL8Gp8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7978d32-ee28-40fe-cf44-08d9f820d044
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 05:36:46.4729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRhzNKWBQob52ySuHRINE8EOO7ifg9ptfEN0Jcp43qQe++CQabnV9MPpkk9YJuO8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2530
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

This may introduce some problems for two callers scenarios. That is the 2nd=
 one will still proceed even if the 1st one was already blocked.
Maybe the logics here should be performed by the caller. That is the caller=
 can perform something like issuing the same message again without prerequi=
sites check on PMFW busy.
Or we can just update the smu_cmn_send_smc_msg APIs to give it another try =
on PMFW busy.

BR
Evan
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, February 25, 2022 12:22 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
>=20
> When PMFW is really busy, it will respond with 0xFC. However, it doesn't
> change the response register state when it becomes free. Driver should
> retry and proceed to send message if the response status is 0xFC.
>=20
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 590a6ed12d54..92161b9d8c1a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -297,7 +297,6 @@ int smu_cmn_send_msg_without_waiting(struct
> smu_context *smu,
>  	reg =3D __smu_cmn_poll_stat(smu);
>  	res =3D __smu_cmn_reg2errno(smu, reg);
>  	if (reg =3D=3D SMU_RESP_NONE ||
> -	    reg =3D=3D SMU_RESP_BUSY_OTHER ||
>  	    res =3D=3D -EREMOTEIO)
>  		goto Out;
>  	__smu_cmn_send_msg(smu, msg_index, param);
> @@ -391,7 +390,6 @@ int smu_cmn_send_smc_msg_with_param(struct
> smu_context *smu,
>  	reg =3D __smu_cmn_poll_stat(smu);
>  	res =3D __smu_cmn_reg2errno(smu, reg);
>  	if (reg =3D=3D SMU_RESP_NONE ||
> -	    reg =3D=3D SMU_RESP_BUSY_OTHER ||
>  	    res =3D=3D -EREMOTEIO) {
>  		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>  		goto Out;
> --
> 2.25.1
