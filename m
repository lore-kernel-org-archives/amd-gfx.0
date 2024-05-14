Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614DEC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 08:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C115710E7AC;
	Tue, 14 May 2024 08:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cG/5PD/r";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F6DA10E7AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uuf+m6wAv1ZV4hMAzUUEzKOc3HtmfpvWOj3+C/bDyozXjgbCF2gzvNq8XZvZ58/TWpUNWXuzjeGGxURN3Kw5T7wdapz5dPInGFpuDl+Bn2/tOMSxnnmWWM5NxTTP8QtIZ6v/ZY1pGVcX6ULGbysnPZ7Bp4M4oZQBrV0yiPbA7xYXMSBBJuktK7wO3MrrC8Zz77TwPWaiu6g1FBTME4Ot5Ncn1H0BtuM630nUU2epaJaYFcgoX/47h+hcXq8vTpEGP87mjZzIE8yu+KRtpPnk6pRJIGKVURwHmvpQw3tVVnCW6s/qznMEcgYgUnftssuhnYfgGG2K2Lxi/08MG0jCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0Rxk1H8+rSgH6wNUs+SyfoGNgh1WnSM+kBAqnLbNAk=;
 b=la1Q1D53MT5tNwN6k+KQixXIFUtLsyWByYqhxP18P1I72H/cbnjr3C3/Mw1tLMHDJbsnN3AeEO93qg0UFtFFhTISo6dyFdISwDJ7BBfGUAk1h5bd3pGYM5czYQHIdxCwKBNRLBNd1d0dbUqvwP9Ks54NORyMwpWwG9WRLJPdrWxYcJio23MlRyQ3Wc09M2CLabaZSufE05JXAGh7a6b2M5pd/SB1rETpB7nAQrplPGLp1AgY3JYmW/RRqN9FgguPriCcOLyZMytePW9mU+HK0tKaAaGnAhAN0pPmyvcHQyVyEVqews7+MwWaUlOUde6AaxRrXbMdNp32tWHZmrQv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0Rxk1H8+rSgH6wNUs+SyfoGNgh1WnSM+kBAqnLbNAk=;
 b=cG/5PD/rvGShAKaV6P+SLwXd5wPnf6iLrNbWhK+Z9PshUHzvkVmABdjeiBz+rOWH3S7hM7JtHZfqdN6qZ1ridyxPB2mxVqONFhK9wNt/+qmoXp0APwFm0ZVxtVOOM8Uf6M0F/T2W833n7gW/ebsqx484tPA85l3d+7atG6IhOM8=
Received: from SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:51:30 +0000
Received: from SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166]) by SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:51:30 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Xiao, Jack" <Jack.Xiao@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu/mes: use mc address for wptr in add queue packet
Thread-Topic: [PATCH] drm/amdgpu/mes: use mc address for wptr in add queue
 packet
Thread-Index: AQHapdnc0P6yJ5iRQk+4GhtWfG7pKbGWa15A
Date: Tue, 14 May 2024 08:51:30 +0000
Message-ID: <SA1PR12MB565945AB698B03BCE837A1F5E9E32@SA1PR12MB5659.namprd12.prod.outlook.com>
References: <20240514083440.15519-1-Frank.Min@amd.com>
In-Reply-To: <20240514083440.15519-1-Frank.Min@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e72b4b46-e00c-4d67-89df-03ee127ca3d3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T08:48:47Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB5659:EE_|MN2PR12MB4288:EE_
x-ms-office365-filtering-correlation-id: bb7b8296-5633-4c43-18d2-08dc73f30c91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?2X3DDVHirqtnYRBlnJ5w2ZkLOYnndlUM7h63lghwRw2T+vxb12lUV8KTFOvM?=
 =?us-ascii?Q?L76eygMgKDMtVseEWCDVDD7GlVLPGq2+cMo+NshD/wXgKPuoIhZ5XDpC0F2e?=
 =?us-ascii?Q?Dvpnjk1qhjgRS4EUmSIhHSFDT91XSA8suRWPi0KSQM/Z1sik3531rh4wPZwD?=
 =?us-ascii?Q?cSU3jA/gUv5pJLnhJZm3pDhI+AndNPzG2/VYmIwfrhylRwxGK/WIXUXDu9f3?=
 =?us-ascii?Q?0bJYy11QUUC33uvymv93aHVusaT+khPOriFJRJ+NtzeyyztDdTwOy2wCBMUx?=
 =?us-ascii?Q?e/1BW3YC4GPLTnOC24ZHd3wAnVMKyylUQLedLNYT9t1LuLZ/UD34AzqF+5NB?=
 =?us-ascii?Q?zPka+yyecjqJCX6V5/8I5Qo7w7YE/kdqKwhhb0Um4oHklb/dHvtM1kEk3bEu?=
 =?us-ascii?Q?vs7ja2mY25VEfdlWcjCY0Fy/rlmBkPC3YfYk9wQQ4pEGB3/dkGOs86zgMeVa?=
 =?us-ascii?Q?mLU5OAvyaw0NiDn3nx+b4JCqKTJvuTRgcHTKjqQs01gc6PiXcJcoafxkLhYi?=
 =?us-ascii?Q?8xb7Qg3TK3rfwNmwxnsWkHWXhEaYi8pnAGlJgU36v14hKf1ZSNZDtfJ6LfkF?=
 =?us-ascii?Q?PlOqtYhJmSxuG0u5A75pfdk+/eu0wVkuSZavPSMWEB0ZdIdt+UbyxcTwp5YT?=
 =?us-ascii?Q?THDC0d937QhNZciLUG2qQHUrNAAIglK8EB6/sUCw9S2DkZuSDX4YdsTyEj/q?=
 =?us-ascii?Q?kAMQxlifLDi+dbDZkgeBN2nVwwFPloA+uex3ECqSTjclvpKoJOKxenpiQaCT?=
 =?us-ascii?Q?RksgzuABDk9hwgMrSoP/zEClBNM6PL03qMtGcXE64vPEUooUEgFrTABZsMML?=
 =?us-ascii?Q?2soR50l+mZck/HadwkKhD1LTBxuPj042i11aGboTVi5RP08zZgh7OtCsXuCR?=
 =?us-ascii?Q?irlEyjhFiRPLKUGXToAtm0zHMEFM7XmKZkMLV9yNqwf9uiBLhgSvoMLCNPMc?=
 =?us-ascii?Q?JklfYksfPcXMyLBPRbc337lAD6pJT60sU4KVAKtxSHVKNlUj5toXl+3IROuN?=
 =?us-ascii?Q?5LhFM3ezuKECfI2juIb0XfiMbt4n8vA3FBL9ifglV1gePjmjfqfPQoOKcLdo?=
 =?us-ascii?Q?1WzCUkn1Jog0IbEmUU+eirk7TCU11Ad++Pf/gdiBzcdOQjch544BbYArlWGg?=
 =?us-ascii?Q?Y8jJGhqyfnWowEDiJNY+sKjuUp8CORr19R+wv30gUFGokJu5jAgUnUlqLpSD?=
 =?us-ascii?Q?zPR4KhF12lIS5T2B2FUK00BBHviYo6RoKMroFqPCJygRV2KGP0Q67Le1dtFd?=
 =?us-ascii?Q?PzPT+VWePKmbfR3wvvVxPYs//IV2xuRR7CD9dvg0l6rqZZJHQBhy4fnFd5P5?=
 =?us-ascii?Q?QAseGCv5yFh0qmRoRteMBjbvFBh5vagSgCVZniWkZ+6MBw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N9GiRCHJ0x27XuJ1Ce45HIjOmIytO7KHxqwiaEuhwSvZN1P6Mhc6MTri9sub?=
 =?us-ascii?Q?0egDLBxQAjOtsXhEFyr/9ShNkS7Q1IruIId3F5I6cB444FSQESWitA4Orqmc?=
 =?us-ascii?Q?1a5lR7GHIHoU9lPaxa0PWetH1AraRQ3m0rZc3ZWSmezHhDBxHQV9BG+b9f+U?=
 =?us-ascii?Q?wHG5eqymVWcVkJrlAkKeyaAEsxvD6FmQEU+X7BK+cmY+j2pm2yF379pwXFPk?=
 =?us-ascii?Q?7HmaG5zVIMO+3EUR+495Ot327VCg7xF1OskQWhyeZWDh0NueVQ5upS01uL8V?=
 =?us-ascii?Q?tn2IufGybUKybcTdRxEOtnck/hN2bPgVyseIVg9c0MVz6reSKLxVoUnJfzYp?=
 =?us-ascii?Q?h0xM55hN/r7QIU1jeN3aPyfO5zYTGQ8tyxjpGqF8pncg/jBLa4+Ke7lcr/Kr?=
 =?us-ascii?Q?FPLSFSIdkIjrRZzz4suWgZjTnhSx/QlJSaKMfit5Btxn04Ms1ApXmS+IIu82?=
 =?us-ascii?Q?OFM16RzkarMndPwVVtaXC/v3ccGaqwf78bqQ3kSadYiwz8QTt3rkHUuWJj+i?=
 =?us-ascii?Q?sZbM2Y34NtrG6mCJoBO2Se0UXMnz89MF3KDsjjMYr1XGyua7M07yiGj7epPo?=
 =?us-ascii?Q?p9sWRYQCA4IWST6yWLn750wah46Ep0M4zliFA8HrLJM5BDroXeoU/Rub8O8H?=
 =?us-ascii?Q?X6r3STpW4E3xR2EihPmsqn+I+AWK8pVgJiLVTEVe2g4PJsUofdbnjeCEw+nU?=
 =?us-ascii?Q?eYnRUhAJ4iXMt3GJj6nIOKU9x3HYlXmAOumHMi80jsrNWyU9CeLLgqjRijtA?=
 =?us-ascii?Q?AB1yBLiIUDVPlIg5JnE4mxpZqG8/tkLAaPe4HlWpUKWLwAd/KnfNz2bmlrcU?=
 =?us-ascii?Q?gudf5pkK8RUA7/K+HfI1nX2rWZ0ujDvm3fuwGKP1C7tIoddjsCYQUtloJlI6?=
 =?us-ascii?Q?dGzSF2iTNNSi3ZTSnumXpQOchvJ/3aQxOCG7U09zh24kaI6u4+aKU3Ef1xJK?=
 =?us-ascii?Q?O+kS1Aca228dTOy4C87VRewQLbi/ieRdCfpKwG4QYL8NGC/5cqt11MAcFur6?=
 =?us-ascii?Q?5ny+QlgClx82qhrtca8jRubKHVRL8yh83aXPE0GEKar5qioLx7bRwcaqXGog?=
 =?us-ascii?Q?oW4EQlrrFlmTknN1ZG+Ls8lbg/9wA+kiP+UpiKTeOiyztto5m9CH+HHFoytQ?=
 =?us-ascii?Q?tALryEoE5vVILicv2uebM9i8Ip3pOS+8Z69xUxELf6XAvMLQXSji8x0vf037?=
 =?us-ascii?Q?wtkQd8sg6dheEXKRWNWZpejfVB3dwgrnCi2vBS9C4KnfmQkWrSIXGntFsbUi?=
 =?us-ascii?Q?5UEWJzGrloe8u4eK3lB7lkzDZsxpJHaCY/59aV0em9xwabfMtaCyTwOJ1hQ4?=
 =?us-ascii?Q?G9gRbjMNHSaxmWNI+GnT8lJLUvlr9uOUqAmCj/p+VvWt1BZLVLVX7c3w3dnG?=
 =?us-ascii?Q?wcU2771dy4NT55Wd2JvVqLz7W/rTD5FsBHRJ2vJ+Ggqz7siOOL6iwN+ZICXi?=
 =?us-ascii?Q?WtI/BW+VYP5Uci1tBzz1JPy2lwDnc9gg0jEJfqsVM+9dERVTYbtAcA00H6IS?=
 =?us-ascii?Q?VC79lr2jMX+8/thSFFLLxszU3pYRjw9NBsw6piYC5S4hzp8dT88XxxrS/CWR?=
 =?us-ascii?Q?PEtbDWWp8lZXsV3q92w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7b8296-5633-4c43-18d2-08dc73f30c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:51:30.4742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfXyMVejxZCal9ggZUYU3gyGmqCiPxXUDP9REO4H2EoW/aoVuuZiBY2e5bbuAPCI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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

From: Frank Min <Frank.Min@amd.com>

use mc address for wptr in add queue packet

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 5519655fd70a..6256b21884ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -267,11 +267,7 @@ static int mes_v12_0_add_hw_queue(struct amdgpu_mes *m=
es,
        mes_add_queue_pkt.doorbell_offset =3D input->doorbell_offset;
        mes_add_queue_pkt.mqd_addr =3D input->mqd_addr;

-       if (((adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK) >>
-                       AMDGPU_MES_API_VERSION_SHIFT) >=3D 2)
-               mes_add_queue_pkt.wptr_addr =3D input->wptr_mc_addr;
-       else
-               mes_add_queue_pkt.wptr_addr =3D input->wptr_addr;
+       mes_add_queue_pkt.wptr_addr =3D input->wptr_mc_addr;

        mes_add_queue_pkt.queue_type =3D
                convert_to_mes_queue_type(input->queue_type);
--
2.34.1

