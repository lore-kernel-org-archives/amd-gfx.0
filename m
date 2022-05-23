Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9297DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 23 May 2022 08:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBCA10EDF8;
	Mon, 23 May 2022 08:58:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 333BE10EDF8
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 May 2022 08:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5wDO3iQ5QgA9zGkyN75WgLZ93qMjaduoUjV44RgJNfISahMlZ4JmRBMXL5hHskfM381d9v8me4Z9nGT/eTWCc0qIy1Z9VcH/mbfF90LNPy5NxWzjx3C7BcoP01lk+cxxXezpCibqoB0aVBSSUINIlLY3+ZCzVqtUfZaDr8hOJ7yxwtCL3AqZsfk0SVTY2CcXO4+NpZ+DOkccbpxOUAgprKkViD3QvzGj9aJf9oz1F8SGRGPUI8rcspT+GupvpdvcMUKWhMvzp+dVXePPg5/ZaB+fWQcRED2J2HqdEIFRUPMYVfmZZoDO+b1ymjCIEQsBTEk+YeNC0/HJOOUxtcBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtygrS2OEyWQF02ek3V1xSPfp4krP90qTcauRx1V8qg=;
 b=fCVPNiBeO/+WzrX8P4CpbgXdAcNslDhSf1WapBztFEeixZG8dAIxUjFd/Hl5i1NZMdWa2GM1ogKxVvHY/jXMwj9Db8dNkC77jbqEKoG2nQGEZkVs6QVPaD8fbvP5hjeMTmKeKIgG5ZadXubOFtY2+bOdn7UjCpXWYuytgApOcI73Miwfuupk3jBgzL+pI2onPHzHNsfagRDscXKuuP5dGBWkpKd+g9+3poipQUiUF5B7Qfe0YMR87LFueeYuG8T7ZzCT4DG+db6q7JayoDSAA6crh6ypEX2wZcEMimM/815HdmsWkHZQsHvflde7PK1ZXMBxFklKU1R4w+53g7f4LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtygrS2OEyWQF02ek3V1xSPfp4krP90qTcauRx1V8qg=;
 b=A28nG0tWdT27wTtWc7AQx5AW3l8yg+5JWTonQjorITBS4mK38v2JXCMC3zrGwCDmbz2FBpmZZYD4ERKQXr45Oa+29ZeCXXLLBDwtEOz3aonLlPPZKmZor+JFGLoUZNTkZ/kHCzthPtc0Of7LQ5JL7G/cUkyFsNBjhEaRAx6fens=
Received: from DM5PR1201MB0139.namprd12.prod.outlook.com (2603:10b6:4:4e::8)
 by BN6PR12MB1203.namprd12.prod.outlook.com (2603:10b6:404:19::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 08:58:28 +0000
Received: from DM5PR1201MB0139.namprd12.prod.outlook.com
 ([fe80::4a8:b6a7:d23:1884]) by DM5PR1201MB0139.namprd12.prod.outlook.com
 ([fe80::4a8:b6a7:d23:1884%11]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 08:58:28 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Resolve pcie_bif RAS recovery bug
Thread-Topic: [PATCH] drm/amdgpu: Resolve pcie_bif RAS recovery bug
Thread-Index: AQHYbExx1IeYsLLuPUmw0zJkOzEZZa0sLb1w
Date: Mon, 23 May 2022 08:58:27 +0000
Message-ID: <DM5PR1201MB0139BC4F536F17C586EE60BFFBD49@DM5PR1201MB0139.namprd12.prod.outlook.com>
References: <20220520132033.25135-1-candice.li@amd.com>
In-Reply-To: <20220520132033.25135-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-23T08:57:45Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=728854b5-8fa5-47b2-8b33-acbd3a898bdc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-05-23T08:58:26Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 8464fbc1-42a4-44d2-a48d-ad05e0fe5912
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6326f8bb-7c45-4ac5-ab3c-08da3c9a6721
x-ms-traffictypediagnostic: BN6PR12MB1203:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1203B09F5F2C144A95D28DFBFBD49@BN6PR12MB1203.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EYQhp2OQLgwXFsmjMA/8yiR+ZoxRBesoD4F1qqsMUqYuEeOaKWJu/MtmOKnVxItJYOP/RiDTaZlrGWQdoNedpm27AGmZyC7qw079+PPZOnDrrIHUzVylDR2b+JXCki750JNRqa2VuSyfFwCzVk+waJ16UqV/e1mUypP+rZkkDM7QO/DSiL/bEtZlRnS66njK3bR/LcJK6OheNfpgFk7qyLgO++1F7N8uG238/YF2Ohb0fnrHivlHTCuAtyZdKg3E4LMuvQqGZSnt4REar9l5eb+t8jmPe/yYDRQZ9RL0mmMWd6P82I996Zmb0e0D/MMXJJXUU2q4AsA/gVDbq54Y00fO4EaaNSoO0H9Y4TYw41+Y/40uzrCwe1qKqTWw8xPZ9gsB3mA+YOnEUq1UEFyPReSVvbJuH7NoiYZi/X5qeBmAhGBwma50EpBxWOu88v4IchYmyWSo2Mv1MMOLJaTIaLBR0mdxV3mnayGpBKv0RX5M1f8oj/RisRdG6uNxVF/ezfiq256YSKoQOtiXXT+VSHYhPvaCkZv4ASUFbnZZrQlPF6F+2AeiZJPfXy9g84lyTn2CsfPzcFXkB1NAxh7/Jm0kqcucf3brHDxtK9rruVdsq/tdJM2XS08b2Vk0R9/AxA+oVDTnZfJDrNj0vlb2gnjkxGMkl8DSkvTxFDUbOfm9vSt6f6MSOhZWjiekuWt2wEHFu+PRm1htsPJw1TDqsA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0139.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(66556008)(66946007)(64756008)(66446008)(110136005)(66476007)(76116006)(316002)(38100700002)(38070700005)(122000001)(55016003)(2906002)(186003)(71200400001)(508600001)(53546011)(26005)(7696005)(9686003)(6506007)(83380400001)(8936002)(33656002)(52536014)(8676002)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wjx7KcOJ4z6uyx57hxhkNwTdT5WQgTXVR79pra5Zr7MULOxrcenSp/e31leS?=
 =?us-ascii?Q?O1yf9mpru6ACu6StnOx7cZPjuC5he9mgZvuiNYM57dZ94MD79AaEHZbmReZe?=
 =?us-ascii?Q?PD5yW5vydvKh0FTSGfs7jdgM38kJJEc8UcX+OzTKkUHvbrOyDzFbnTgsRxSK?=
 =?us-ascii?Q?1IXU9bKpAecxuS452ngwdPwP0sl6Uls2v/JIPaiLGpZlosOoOvrpeOFvO1uw?=
 =?us-ascii?Q?XHgBE7ZKA4hGMGvXzyGL9BfPl6g8zynIUbTT5e9cs0L9eaQlo2S2pTeUs2LP?=
 =?us-ascii?Q?Sxi3zQOiejOVnEjdY9u+zdZI+wsCznruwWtl4S/3Iv7lf/jBJ9wBoSbpxXOS?=
 =?us-ascii?Q?hXzKPnKzaAbfgytdziXuXkTCbTL7k6Av5AIulMoU1ci02wZfBk6+DE6FWJyy?=
 =?us-ascii?Q?1FA51rIWkW3kxWW10csy6S0XUBGbeDvhX0uBLwS9/t91+y8YArf5zLcMV2fm?=
 =?us-ascii?Q?T95uOARI2gFWNM3s8+nUzshkpf8wvAyVNT46GVin5RabzVJTTxVKieyILtV3?=
 =?us-ascii?Q?tM98Vovn2fZEZZueamEEos04qAf1L0GSONrxugoXmFSP1pGsCTp62fdVjGyY?=
 =?us-ascii?Q?C0vJ7hlVoO3NcRAl3+Pf1OIsY2pEXocgnZztMwq7E/KafuLiF5wXT2359Wwx?=
 =?us-ascii?Q?2V/R81dao/MSaCLISGcpJBLEMu7kjO4Ri2SccHVi4ZyDBqV5qPx05o9zjWfJ?=
 =?us-ascii?Q?AoByCiPIaAWnSGeX/d526s51L9EymGP1Lw6HUdCGSLClJe263/Hsl0/mgDgt?=
 =?us-ascii?Q?KaKZ8MBEMXU2qJ7I/GIScViqK4A7lq7s41et8mi4lCw1gvuSbyyQ4AAVbeUt?=
 =?us-ascii?Q?fP7tYN8qW785beL/DwvOSEZYYKjE8e745hvCVgLwpfQPbuyJHU75LeyWV/qL?=
 =?us-ascii?Q?6VN4yr+C1AA/tl8RUqc6IWqonrL2PiUiXPd8YkYcOGwG75uft8tVoP7BIIB5?=
 =?us-ascii?Q?KPR3xr63uAcbRC4QGMe31Go5lnuGt3YQQksfQ2C7njuyREu21c2+9D4Is8yt?=
 =?us-ascii?Q?uuGb1CJFEl0Mr9o3vEfejls5Z1496tA8j21kHk2NYyGmxoI7eEZCybTdpifZ?=
 =?us-ascii?Q?xUO/xQ1rP7vsDUyFZug4tNVz7MnDvwGTnvuQhvJB09gn4WmjecUZIFAFWhRp?=
 =?us-ascii?Q?Vwe+ItZ/ZTl9fucm8IajcAl7ujQxXQcEW4jagqUivEQeAd8VinioBLz2WAvy?=
 =?us-ascii?Q?ftWhIRWEtBozufRwo4u38K0OBxwtNAEPWEmg4Tb+Uljg5ZM4PRdjzGHgjcwc?=
 =?us-ascii?Q?LTAjiILRBoJ8eBEZ48I61BHtSPOXw40eKC8SKurfLTbAibh3EyheK+GzBH7i?=
 =?us-ascii?Q?zbuCovqs7W28Qam9+SkLKKmaAatzFAFzAQPv785wjJ72a4OTyu6Jo6Hi9hdm?=
 =?us-ascii?Q?DaEEYsGEfIUc8MIWI3Vn3UQtpIARYFnuHyvskTs77o/hov4Jf91afogdiFGV?=
 =?us-ascii?Q?naHbvguG6wYCw0k5FtDiw+ffUHgaepPPD/TAN6CabvqlK9ZLuXwqny71xfeT?=
 =?us-ascii?Q?+hh6cDgN0uom+uHPBmCNuqmoGB0u+46E5qhpMrIU5gL2oT6PW2S23WiJ1VH4?=
 =?us-ascii?Q?J5e1xcVUOe4zfUQZ3L9tRpW9jcqFvAFeY4aZXYy7Se7YYlU6nyQa4tb7Nh2I?=
 =?us-ascii?Q?eG/jCaxMfTB1xm6RtnRRnPgYauA5Cj59SPDR1iN6SpYx9jT22aVvhGI5kIB5?=
 =?us-ascii?Q?9LRNft/6WxD3CS23RTSnueq77a4YIt8xeavK4oTW7jjm1TvjQVI1Ff003OsM?=
 =?us-ascii?Q?YneDeqAF4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0139.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6326f8bb-7c45-4ac5-ab3c-08da3c9a6721
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 08:58:27.9080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOjVoNRMrRBsTFUK0gHY7KSprwuBSPgU9TNnTHmRcWb3djYI5jD8g4taAcAa51xIyK3z7fjIFOdoXx6umfhzUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1203
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Friday, May 20, 2022 9:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Resolve pcie_bif RAS recovery bug

Check shared buf instead of init flag for xgmi ta shared buf init during xg=
mi ta initialization.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 214e4e89a02876..e9411c28d88ba8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1177,7 +1177,7 @@ int psp_xgmi_initialize(struct psp_context *psp, bool=
 set_extended_data, bool lo
 	psp->xgmi_context.context.mem_context.shared_mem_size =3D PSP_XGMI_SHARED=
_MEM_SIZE;
 	psp->xgmi_context.context.ta_load_type =3D GFX_CMD_ID_LOAD_TA;
=20
-	if (!psp->xgmi_context.context.initialized) {
+	if (!psp->xgmi_context.context.mem_context.shared_buf) {
 		ret =3D psp_ta_init_shared_buf(psp, &psp->xgmi_context.context.mem_conte=
xt);
 		if (ret)
 			return ret;
--
2.17.1
