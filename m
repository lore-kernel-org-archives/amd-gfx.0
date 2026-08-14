Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACF2C5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 16:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A48A10E191;
	Fri, 14 Aug 2026 16:47:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1DDyVojs";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010058.outbound.protection.outlook.com
 [52.101.193.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE7210E191
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 16:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEFnwrJbcfZTnsCrwZUWAWFQ5o3vcPaNWROJrbl4Q+8DF0TmXYy6pRHVwcR0pna9lWMGGjApNxDN/O28uqEiBESS295FXfas1RqKPMHDnwM+IqNvnbMh3+9Toc2SuyeMWzFtwEWT3f5n22h6GGJ1f88TRufh0fb2E8izv65P1yobjSVPxFE1jSbomsMFxle7i2gSa7ibTyfrKSTVqW0KT47ZYKIDc3v5v/bVCdlShV8q+UGudesZVdSYsb0vUX7kxp+31Guvtv3aXNCFFAi9qxYGZNyRBoXff/HW76tE+EMeFLDKn7Vh10unGVGvSK9SIzaty2p3sul/CBqDSjwxOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAU0Oem7GCiBxIH+8gQWFeLTdSLbUlqwN+vXZjlI1Vo=;
 b=RkiRUc3nTnpEWBPBtFyPipcLhvG3Y4wk1g0Mj8rk5nMCC4yyIChZmtF5LvAUoZ5lVOEr1QIQ3nBpVaBEAhAOBA/45WpKk7HPoOBTTuP79Obc6PMe1NMyTiT0lvM1/id/uVGiJmpuQL+AgbyCpF1HLvfszkQgFFdM+Y4jnK1MMcQ+aW3Volr6J/nd5ltZ5VJZZvbfVsMgNPft8x4e3+huV4kp1QsgJVdMl8/Z1Sgly1jh9HL/8DXoHQ3yyPsYdMjv/PnG24SuE5SYfgjwj8i8rW4DjKRaEJ+q3eHTBRagfO7fVIxOyIYt13Km/bD3qo/9+p+ZMBA/gMzyVibOFFUp5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAU0Oem7GCiBxIH+8gQWFeLTdSLbUlqwN+vXZjlI1Vo=;
 b=1DDyVojsy2INXw6DA0hq8rPsL1UzWnF39q+xAEsYM+ELOsntuDUihSj6azWn3SmefPcTN5Vwy8DBC7DdbkuAFFpQmSFB2j9eZSWkiMnd3JfQ4tvUejkXx4vbDj8iM4TQ0SYF+aAydlVelbyTczXIOl3kUMaxhRVLrXAtbCtENT8=
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by DS0PR12MB8294.namprd12.prod.outlook.com
 (2603:10b6:8:f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 16:47:51 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852%8]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 16:47:50 +0000
From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Hosur, Priya" <Priya.Hosur@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue
 unmap
Thread-Topic: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue
 unmap
Thread-Index: AQHdLAilqY7k/FT2/kiiGQxlEdR407advBMAgAADta8=
Date: Fri, 14 Aug 2026 16:47:50 +0000
Message-ID: <DS5PPF78FC67EBA848622BC6037F917872992DA2@DS5PPF78FC67EBA.namprd12.prod.outlook.com>
References: <20260814161841.5906-1-Priya.Hosur@amd.com>
 <20260814161841.5906-3-Priya.Hosur@amd.com>
 <SA0PR12MB7091D3AE34006DC6797EECD197DA2@SA0PR12MB7091.namprd12.prod.outlook.com>
In-Reply-To: <SA0PR12MB7091D3AE34006DC6797EECD197DA2@SA0PR12MB7091.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-14T16:47:49.776Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF78FC67EBA:EE_|DS0PR12MB8294:EE_
x-ms-office365-filtering-correlation-id: 8b1f33e5-016b-42e7-29d0-08defa23c6ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|921020|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|8096899003;
x-microsoft-antispam-message-info: XWw0yl+ZevWczQKjXD1KacyVnYyhLiJlPQl8/LtvyheoDtFomH7FEW0x0aD4zg5RRYHZHuSbkzbeRzuUfJTJsXymxlbFnMccfOh6BYeCCDxcJwBIHycbNtK5MyxjSzsTXsoGTKwmUNPHedgfLNDvTR0UtdMTGiWbm2qEMukft78okR15yJtdWYDQGYrHMOQgXn31o29Pr3YML1EDQhayN1SI10nQh4IrYH3+XmpK2ZLDzXKdCJwLYoLzKmhmvCKx+LcoX/fVZjkXFb8bVSF3zubs/n+lQuo7Q2Fa1GY2hoEB7gryTSz3NWWOFqTeS6ZLnwzQWXA/jn1yGzRDnx77eU2FY9wQ2F3Cd/AVUv/2q0CfhL4RrixQhve0xsU47bDhAJc0isIw5L5SLJKMwOdksYLIquWr8+aKtaw5z6j4ftyLFV3GkXQlnSgusj+eo8eogHdpXjZBZuxrNq09huGxSIjoDnQ2xS2wd0N7VeoKiyJdVA/1iTzexxnpH1NkR2pxlj0olQP+osHhXX/P9LBTHn8Z8hyev4wCrpw0mH+8d8aPa7l63P7PTW7oEnVHxId3gYHafeIlxmaH5lvUE94q8Stx2i8SGGG5Shx08Mz9ztxnahBWaWe6aBGerNpf69wfIuTLIavd9Kku+h3+O7WeZHO3zbVZvdbuWHovZ7qnepHqSTpP7pj93PmKewKux+js1w2w0UwUfdBGbFDBfp8vHbUsrU7J0C6SqMHxu3P68YMSuD1cSKmMGcGV9RTBKlEp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(921020)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p0iojLyMMRQACaP6csUkp+PJy9kuRUzFSM7CCEM9i+IRmbuz6PzRERlrKXD4?=
 =?us-ascii?Q?9qr+E0BdZcgn79sxlp0fbz73dtLDpPc8Pb0cy/JVHwnVw9Q5TAO2FUlJoN5y?=
 =?us-ascii?Q?9G08upgiA8Iot0/NOqaZlviqaPCqi5moTWA0egG7Jg3m1U5WnGsxZQb118WG?=
 =?us-ascii?Q?u+IjdDUmU58AzrmFRrn0wujzZdw0JVTvsBq6Vvrb6dhqkUgyOgN6yxCTIyO9?=
 =?us-ascii?Q?Yk3ZbSDwiDoEMHvf0C/tgTS5YplKvdTxNIOhB+TbD4c3QabBy6L3FlfS5b6z?=
 =?us-ascii?Q?hLLshtAVQ2gDnIcNJhF62kNl2wdkcuqQy7enm8PcgJUITkkGmC0F1qYCnHvL?=
 =?us-ascii?Q?P47/MsamKfUWHdfgKRS1QH90amFjp4rNX/JI7gXQa6fxv62Yxaj4CkpFgKgx?=
 =?us-ascii?Q?O86ayT//mqHBB8jhJMJvm67oedzSNpX6vqrihRlifo1QvKmKI0ePOzwfgmwF?=
 =?us-ascii?Q?y5k8DgfmougvobDi51YY4QCpnBysjalXIC2PCDpxKh6TMeG/PXkv88j50OtX?=
 =?us-ascii?Q?R8Ss4/XQlc7ZAQU3zgGKIFwx4zKyURgo++GPi7Jk/ABqT6vCy9V7yBNmolni?=
 =?us-ascii?Q?G37uvDtLvoNeNfyIlY58+bEyIJZb3p6A8+os99MmRLloVOZfxE89OvTqqilY?=
 =?us-ascii?Q?CZaGd+hIG98sdzxfYTJGk+3Li4wJ+1eosBR86s8O1wJjSaKCJHWBk/957Hj1?=
 =?us-ascii?Q?imSSRT+M3rolzNV4GDbVyOZ8NDye/Wmh8VZRpMACv4J/CCQMVkZEPMv41JXY?=
 =?us-ascii?Q?OHeflte3b3MYP1peiid18xWEOZACDSw0vp2ekvZV4PL8IeSA9befINN5xDBi?=
 =?us-ascii?Q?bQiUzOVS0nKvfuxcn0iPvNbKSZLkgA6bbsZtxRDFkjWoVYQwzCr9AJuwQyQY?=
 =?us-ascii?Q?XPstJDmyE8z0Q+uNthaTXJ3V4bUy9q+/kxkIhFL6hiH8MyDCNyha6rInsVsP?=
 =?us-ascii?Q?ZMUEE1TX7L15lxiLrB8J5S6L1uLSwBambb9Uox2XOulaJqrP0ORu+bKPLEIh?=
 =?us-ascii?Q?jVt9ITXd/DzjLuxOA7gYjArACxlSgj6ACHvGS70LplEE5lSVH3k0UVb9Ta1M?=
 =?us-ascii?Q?WYDnv5KD3HNxtU8B3zVzq+gU/0V6XMDbhPFdxbOXYrs+Yn1rlbH/cnCnBJeR?=
 =?us-ascii?Q?hQejLsMvsW1GQkD1Gn9xuNswKdQfFQ8I4pFD1Nyd5VJfWki3sYrhMmPIEuM6?=
 =?us-ascii?Q?v/q3aJ69InAf7enHUZn+VYlsJcKngfLO8kwasMeP+10Avl6ytPou3ZcT1isF?=
 =?us-ascii?Q?YrpizSuZdfc6AsUWocLiD6az+krjFo6/bRNpT9ojEB7p3y73hs3Qaod18raW?=
 =?us-ascii?Q?ez2nbEq/oUJa7XEms4JAxPkx8IEdmDG7MlLBBv77HyhRCy/t83oUu/HZT4iR?=
 =?us-ascii?Q?QUxMWx3vcqGDrDEXQRUh6IiYzfvSTfRom++/wNkj0oGGhakfYGP1kZdNrgmx?=
 =?us-ascii?Q?rMfVddbD2YZ8LZ6+n+XlQjtQP74eJUf0Z/2UFe6n/sNkuha/KYocYIg1Za4m?=
 =?us-ascii?Q?oZX26mVtRKmBy9Tq8OZKHpvliH+nApAaqk077smI7Hbr9yVNAVcGWXpCsiv3?=
 =?us-ascii?Q?wjjpNc4cuIBBgT5BgMgCbrsGeOWWgWbey99mm1RhVhnb7J4s6Bc/U8hEazRJ?=
 =?us-ascii?Q?+MRvtHoI0ZKhMhiST+nLCDlLoEXQXyTXEYGahBA0xhRrswtafkrJ7aWu8IDc?=
 =?us-ascii?Q?lGS/q9DcP2htfagseR0DOYIa71h05S6Oifdf8ER6f/fgsQvT?=
Content-Type: multipart/alternative;
 boundary="_000_DS5PPF78FC67EBA848622BC6037F917872992DA2DS5PPF78FC67EBA_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1f33e5-016b-42e7-29d0-08defa23c6ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 16:47:50.0719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4gYUXxMYpcen5gLNs1fFP7wirBjh7GyKYnTLCotDdrwlIr77Izdnfn8NlVtcZ4FT22FUJLb1+A/XK7R1RmyHiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294
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

--_000_DS5PPF78FC67EBA848622BC6037F917872992DA2DS5PPF78FC67EBA_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

We don't need to flush TLBs after every queue unmap. We only need to do it =
if there is an expectation that memory access is quiesced after unmapping. =
In the case of KFD, we are doing it when we're unmapping all queues, e.g. i=
n MMU notifiers, evictions or when the debugger needs to stop the queues an=
d look at memory contents. We only need one TLB flush after unmapping many =
queues.

Therefore, MES should flush TLBs after every queue unmap. OTOH, MES must fl=
ush TLBs by itself when it switches VMIDs. This is not under driver control=
.

I don't know what the requirements are for quiescing memory access after un=
mapping amdgpu user mode queues.

Regards,
  Felix
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, August 14, 2026 12:29
To: Hosur, Priya <Priya.Hosur@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>;=
 Khatri, Sunil <Sunil.Khatri@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.=
com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Limonciello, Mario <Mario.Limonci=
ello@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veera=
badhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Hosur, Priya <Priya.=
Hosur@amd.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue =
unmap


AMD General

Hi,

Shouldn't this be a FW fix?

Thanks,
Lijo
________________________________
From: Priya Hosur <Priya.Hosur@amd.com>
Sent: Friday, 14 August 2026 21:48:40
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com=
>; Kuehling, Felix <Felix.Kuehling@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.=
com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Limonciello, Mario <Mario.Limonciel=
lo@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veera=
badhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Hosur, Priya <Priya.=
Hosur@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue unma=
p

Similar to the KFD fix, MES does not perform heavy-weight TLB
invalidation after unmapping user queues. Add
amdgpu_gmc_flush_gpu_tlb_pasid() after MES unmap succeeds in
amdgpu_userq_unmap_helper() to ensure in-flight memory accesses
complete before memory is freed or migrated.

Change-Id: I94fe2c84547723b6b73816ce8d727a54bd773a6a
Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c
index 6d3ed55e9ab4..9fcf15d69b7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -375,6 +375,12 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_use=
rmode_queue *queue)
                 } else {
                         trace_amdgpu_userq_state_changed(queue, AMDGPU_USE=
RQ_STATE_UNMAPPED);
                         queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
+                       /*
+                        * Heavy-weight TLB flush after MES unmaps queue to=
 ensure
+                        * in-flight memory accesses complete before memory=
 is freed/migrated.
+                        * MES does not do this automatically unlike HWS.
+                        */
+                       amdgpu_gmc_flush_gpu_tlb_pasid(adev, queue->vm->pas=
id, 2, true, 0);
                 }
         }

--
2.43.0


--_000_DS5PPF78FC67EBA848622BC6037F917872992DA2DS5PPF78FC67EBA_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
We don't need to flush TLBs after every queue unmap. We only need to do it =
if there is an expectation that memory access is quiesced after unmapping. =
In the case of KFD, we are doing it when we're unmapping all queues, e.g. i=
n MMU notifiers, evictions or when
 the debugger needs to stop the queues and look at memory contents. We only=
 need one TLB flush after unmapping many queues.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Therefore, MES should flush TLBs after every queue unmap. OTOH, MES must fl=
ush TLBs by itself when it switches VMIDs. This is not under driver control=
.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I don't know what the requirements are for quiescing memory access after un=
mapping amdgpu user mode queues.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Felix</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Friday, August 14, 2026 12:29<br>
<b>To:</b> Hosur, Priya &lt;Priya.Hosur@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander &lt;Alexa=
nder.Deucher@amd.com&gt;; Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;; Kuehl=
ing, Felix &lt;Felix.Kuehling@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd=
.com&gt;;
 Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> Vishwakarma, Pratik &lt;Pratik.Vishwakarma@amd.com&gt;; Gopalakr=
ishnan, Veerabadhran (Veera) &lt;Veerabadhran.Gopalakrishnan@amd.com&gt;; H=
osur, Priya &lt;Priya.Hosur@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user=
 queue unmap</font>
<div>&nbsp;</div>
</div>
<div>
<p align=3D"Left" style=3D"font-family:Calibri; font-size:10pt; color:#0000=
FF; margin:5pt; font-style:normal; font-weight:normal; text-decoration:none=
">
AMD General<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family:Aptos,Aptos_MSFontService,-apple-sys=
tem,Roboto,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(33,33,33)"=
>
Hi,</div>
<div dir=3D"auto" style=3D"font-family:Aptos,Aptos_MSFontService,-apple-sys=
tem,Roboto,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(33,33,33)"=
>
<br>
</div>
<div dir=3D"auto" style=3D"font-family:Aptos,Aptos_MSFontService,-apple-sys=
tem,Roboto,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(33,33,33)"=
>
Shouldn't this be a FW fix?</div>
<div id=3D"x_ms-outlook-mobile-body-separator-line" data-applydefaultfontst=
yles=3D"true" dir=3D"auto" style=3D"font-family:Aptos,Aptos_MSFontService,-=
apple-system,Roboto,Arial,Helvetica,sans-serif; font-size:12pt">
<div dir=3D"auto" style=3D"font-family:Aptos,Aptos_MSFontService,-apple-sys=
tem,Roboto,Arial,Helvetica,sans-serif; font-size:12pt">
<br>
</div>
</div>
<div id=3D"x_ms-outlook-mobile-signature" dir=3D"auto" style=3D"font-family=
:Aptos,Aptos_MSFontService,-apple-system,Roboto,Arial,Helvetica,sans-serif;=
 font-size:12pt; color:rgb(33,33,33)">
<div dir=3D"auto" style=3D"font-family:Aptos,Aptos_MSFontService,-apple-sys=
tem,Roboto,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(33,33,33)"=
>
Thanks,</div>
<div dir=3D"auto" style=3D"font-family:Aptos,Aptos_MSFontService,-apple-sys=
tem,Roboto,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(33,33,33)"=
>
Lijo</div>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Priya Hosur &lt;Pri=
ya.Hosur@amd.com&gt;<br>
<b>Sent:</b> Friday, 14 August 2026 21:48:40<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Khatri, Sunil &l=
t;Sunil.Khatri@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;;=
 Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.c=
om&gt;;
 Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> Vishwakarma, Pratik &lt;Pratik.Vishwakarma@amd.com&gt;; Gopalakr=
ishnan, Veerabadhran (Veera) &lt;Veerabadhran.Gopalakrishnan@amd.com&gt;; H=
osur, Priya &lt;Priya.Hosur@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user que=
ue unmap</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Similar to the KFD fix, MES does not perform hea=
vy-weight TLB<br>
invalidation after unmapping user queues. Add<br>
amdgpu_gmc_flush_gpu_tlb_pasid() after MES unmap succeeds in<br>
amdgpu_userq_unmap_helper() to ensure in-flight memory accesses<br>
complete before memory is freed or migrated.<br>
<br>
Change-Id: I94fe2c84547723b6b73816ce8d727a54bd773a6a<br>
Signed-off-by: Priya Hosur &lt;Priya.Hosur@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++<br>
&nbsp;1 file changed, 6 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c<br>
index 6d3ed55e9ab4..9fcf15d69b7b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
@@ -375,6 +375,12 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_use=
rmode_queue *queue)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace=
_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue=
-&gt;state =3D AMDGPU_USERQ_STATE_UNMAPPED;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Heavy-we=
ight TLB flush after MES unmaps queue to ensure<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * in-fligh=
t memory accesses complete before memory is freed/migrated.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * MES does=
 not do this automatically unlike HWS.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_flush=
_gpu_tlb_pasid(adev, queue-&gt;vm-&gt;pasid, 2, true, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_DS5PPF78FC67EBA848622BC6037F917872992DA2DS5PPF78FC67EBA_--
