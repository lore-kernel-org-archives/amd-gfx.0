Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D174C3F6B0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 11:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4006C1134CA;
	Thu, 25 Aug 2022 11:46:18 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DEC01134CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 11:46:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBWlLLI/z2Qb+JU5A/zDHEAMwNlJ/iAg25qaUe7EvxGQkmIaGrQjyyb1l8Lk/VHAUNwZ1ik7zh33408L2gP4U95K/Tyk1jmZmfuAO3gCBdh5UOKHb7DS0SPNO4dB97gPVfwuULI4Nb6ylg2Dc5DJLrzjTZoP8JQDY90RLd1Bev4162AM7B0Ib16A9HWO5gWZmRZjjWW+DtrbKH1lP8mf/kcWxDuU1Muy6iq0POa+oOsTfVJbTs5rwGHqDzvtZ6TCUl5LD01W5kdfdRCRwDAh/d4N4le1p05wa/pACSTM+UzAUQ98r2nVtqbvDgaR8AkHWhZ/O61JqysVBakKKwwy7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkokBw2xg8IxKOn59DnFE+hO0M+gEHZlKyWtqYvXtHc=;
 b=MNcMECuhwe6QABIUoXnMa/PX52G0kNXGRBCRLvr2bBOWvBuRttoFMj3PlTSMooKDmVt2+xPpXCL5znFRw92jwf6O7BlFsuVSSS3SV1bGQ5BK1KFnNghh3X/V0l0ZFO7rRIja94g+Is7DIioCrFauTpTg7ShEUBduXw6WLRPqAq2AXvaRki3f54EdahlrJihY0/paieOEE/8f31iVsJbWmxHXf+uBlyKfZoYWjhQlxhsMUif7RhK+80DcRQjsu5K+D+xVXT/VzOnYmAvL2qfuL1GTmn/lZ7Vo9frDV/EdFSeai3kRw/ZZ8vnjOPju4yXqnR0qR1Mp0sWejVfCeJCXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkokBw2xg8IxKOn59DnFE+hO0M+gEHZlKyWtqYvXtHc=;
 b=oiGhSy5j345ewihaKs13dfUqccGD+WKO3RedjAOqx+L0Who7z1BeZHevFqrZK6o1B/JdHFm72PpgY0U1d/Xit0OJjVX22iOwORMC+N0es/+lQc9P0yLhwblfcRq351EoYe2qmxXTO5y+lkCMSLUDoi4lSA9R4vPXQu3kR1Jny2k=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 MN2PR12MB4797.namprd12.prod.outlook.com (2603:10b6:208:a4::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Thu, 25 Aug 2022 11:46:12 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::5097:87be:3557:c681]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::5097:87be:3557:c681%5]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 11:46:12 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Handle potential NULL pointer dereference
Thread-Topic: [PATCH] drm/amdgpu: Handle potential NULL pointer dereference
Thread-Index: AQHYsLzZTS2TJPBDNkGN/BMXH268U62/jwIA
Date: Thu, 25 Aug 2022 11:46:12 +0000
Message-ID: <DM5PR12MB1308B61FF812A91CA0FC77EC85729@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20220815153123.138156-1-kent.russell@amd.com>
In-Reply-To: <20220815153123.138156-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-25T11:46:10Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=64bce432-bced-4842-8fbe-93204198c58b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfe394d7-2d2f-4618-3413-08da868f690a
x-ms-traffictypediagnostic: MN2PR12MB4797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ruy34+4Z5ektS7lfyUCgQwVri0Vqm/q8qVZiP8H/gckck4KMJC7kuWIt2+Ibn/xf6A8tBF/2cvWG7ghINEoo738KPySKTyKgNdp43rO8svyNoKt+rjB12G6PJvig8634CSVtbi2LEzsurv8jSVnS2GUkrsqHsg+67khtzZhN4MLsN3i7Cnt6zLX6zZ9Vs1F43x2TJKfOCZm2owrykzDoPyxRCDyIabNo0LaIxIdT8av9q/VXdJu2Vdv9DzbDAT8ZdKwfY5GZ8UHpbn1ZQ1EqU9P7xFl9MINcQCrgIOkX6mLLaDzk3qHrwEVZ1gR7Do86wTV+OLxQ8IH94tefAIupIQq+aRxiT7QAJVPvxAwoFAEgDZH0gIOV2Er5Ncwdo84QuZYntpgwnLGQ1fHm7o2W1PtZwjm6qtyGYZg9ePjTzhqh9JI7UFIWEpt5KXwceyEzC6JWJINsMX4iQguXVxUjI0s7tpWGLTvl2iSiC72XM7Xds+lg8UiiAcP336XsqFxnqCJsLYvOtW8XTVmtrn0dfiYdeZ/67iMQLuGbrNTOudR4sRyRVsmVophbGgPl2qAMdZK/WWy5BA/7iWhCZzUai7vxFnt+hNsbcoRCh3z47Ugn47yrd+sYGBf7DjxwpqBdbWbruQF1SUfzHIlol5aG8rzx1hmb6IFv6ta/FYsfhY4oDX6VluAUtoNs5hQ9YXdgkbAmdix2SU+Gw+4fSAvxNORg4Qj+QlXVNqvcvd4kSIogN0LqKcKUCXOXMcpKJ5UnUTT5hd4EncI1sEUSNNZzBQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(478600001)(52536014)(2906002)(6916009)(186003)(76116006)(8936002)(33656002)(8676002)(66556008)(66476007)(66946007)(64756008)(66446008)(316002)(4326008)(6506007)(7696005)(55016003)(71200400001)(86362001)(41300700001)(53546011)(5660300002)(9686003)(26005)(38070700005)(83380400001)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jGoUF05RVq80Akj74omQ/pLQiEbjUWbtfxjZ1+1DITb1ir5zzJcsvoAMalQG?=
 =?us-ascii?Q?/+vQBDo/PDYtayriQkgiyJXcew62ucb6rXQDBJx7qDI6czDIRGLvWoUpIQPS?=
 =?us-ascii?Q?hyoo6nqJooKJdYb4hQ8f53piqJf7k5j0tD96+vneVptV9blicCYM/eppaf/m?=
 =?us-ascii?Q?sAQ8q3Eupaa3bTZ2sEp883SofPNRComZJmRpJuWPMc0YTq6PFHNth6NF8Cmf?=
 =?us-ascii?Q?FpS/J7OsIM/ymfYpOlDM/IgUurfqjh6UidTiETEemTl+zgPmgxkPZLfOU6hL?=
 =?us-ascii?Q?80uWlkYKdZ5T/6LZJ7QF3fZgiX27uA/FEqcU1Jeaj5UcZgIvMPqJ41TiOl5o?=
 =?us-ascii?Q?CxPTq/iAUtwPHQtMaLQ89T12lhWv4MYVmwVDIhQNprYDbaAPRt+JK5cfgq9d?=
 =?us-ascii?Q?Ao5r0e/VlZ7Ak1gU6CRKQyRLAgnR2n+ybGVi6yPo2sjQ9sddN6+jXU+koGe4?=
 =?us-ascii?Q?njzy/mJsRE0KMBnML9AdRsbCrauoVFFOa/VCOB/hoPPJrCU2HuHUkBa7Khal?=
 =?us-ascii?Q?UbzjOO9fmTBLGTAw4yEyuO4oP34ijL3lDUS6xBov/6av0SNNk4t9bKqRjsJq?=
 =?us-ascii?Q?BTw1VEA/frXFKytc5J9Yl4NmjGuK2AVd9Y3vCX9i9BnLy503wqvB5wCT48mf?=
 =?us-ascii?Q?d9FUPJzF6nJqnPe41nWmZZmvi8Ky9FgHX/5NBnAi5SlJd8NoLLA33CyLTnFW?=
 =?us-ascii?Q?8ADM0UA4uQjrzDjX9551/EcGfuB3D3YHpvmM2NK7igqdVroaYEXD0b0couPw?=
 =?us-ascii?Q?XlGlbC27VqegC0vCdR75uztUcmK+/YW0uKI7aZrpXmxzs+Rzq5L0Y1a4Om1b?=
 =?us-ascii?Q?IQsF396UxokD0zF2BTx47Mt5n4D/viXzOoA06iLltCMUUwv+CP5VgaA//JAs?=
 =?us-ascii?Q?MX3eYLQontvWSFi+qLJgPrOoWIar+P9nJa1jldv6ThhUuLRTbvCjJRd3ZDmw?=
 =?us-ascii?Q?kfCnods7IV8NY57yS0yRJ3Mf56kMQlDJeQ+bTVI1wN+Q+2NZ+nvjNklfl2hQ?=
 =?us-ascii?Q?Hh6TRv1F6XL5gzn/C0tuDqoHaMWe3jr2b9Cvre7dlvEVCGSrMz0f+0Hg6Ro7?=
 =?us-ascii?Q?R56ZdpTi6wHxGU71mtFReb4o863vjxzH4gD2lV/tutexFP4Zs1AMwQgwVMYA?=
 =?us-ascii?Q?DRP5Hx5AcU5Wo+oiE3XDmvOJdsnXOdw78FRW7eQtZJT1HmO3m/0RsaMktWmm?=
 =?us-ascii?Q?TdxJEsKPryWXnU9ecrHJF1FcxJ5USpXZnj31PqAwT+E56Tan/qjj+iJS5zK3?=
 =?us-ascii?Q?YTX98nHwr50coqcMMMaZV+ahfmGYwUi2opIzj4E6WxP/EZXCgHQ3whoOKcW7?=
 =?us-ascii?Q?UKaDY6Ge3S//vvMtUTrpVPS3rVoh+6YH3NIVT8DcRLbBHWKcCYOld9ZkItsK?=
 =?us-ascii?Q?2O42PCCYsiftX4XhhlvFu42KfX5MN1oCBrQo7piqiGiDMVEU4oeXGmrN30oL?=
 =?us-ascii?Q?tBqxKLpDzHdummBBmYGb7/jm8SGXFr8ocr0pMTZ8GLLZDw+0+L1NfcV9reWC?=
 =?us-ascii?Q?BHw7qojyAe81OYOAHiIkFWyu+vpTY8J8c9dwaoPijVv1C2DZMEQfAUcceNDv?=
 =?us-ascii?Q?4Wyhunghafk2HdBv8Q8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe394d7-2d2f-4618-3413-08da868f690a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 11:46:12.6599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SD1mwYmhXItBiBnev5EQznczqcmu7ZFNQI91m1YoRNrlw1cyhljmulPv1XADPETMj2rHK3PUbv55ldUzFIBAhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4797
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
Cc: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Friendly ping

 Kent

-----Original Message-----
From: Russell, Kent <Kent.Russell@amd.com>=20
Sent: Monday, August 15, 2022 11:31 AM
To: amd-gfx@lists.freedesktop.org
Cc: Ghannam, Yazen <Yazen.Ghannam@amd.com>; Russell, Kent <Kent.Russell@amd=
.com>
Subject: [PATCH] drm/amdgpu: Handle potential NULL pointer dereference

If m is NULL, we will end up referencing a NULL pointer in the subsequent m=
 elements like extcpu, bank and status. Pull the NULL check out and do it f=
irst before referencing m's elements.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index ab9ba5a9c33d..028495fdfa62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2838,12 +2838,15 @@ static int amdgpu_bad_page_notifier(struct notifier=
_block *nb,
 	struct eeprom_table_record err_rec;
 	uint64_t retired_page;
=20
+	if (!m)
+		return NOTIFY_DONE;
+
 	/*
 	 * If the error was generated in UMC_V2, which belongs to GPU UMCs,
 	 * and error occurred in DramECC (Extended error code =3D 0) then only
 	 * process the error, else bail out.
 	 */
-	if (!m || !((smca_get_bank_type(m->extcpu, m->bank) =3D=3D SMCA_UMC_V2) &=
&
+	if (!((smca_get_bank_type(m->extcpu, m->bank) =3D=3D SMCA_UMC_V2) &&
 		    (XEC(m->status, 0x3f) =3D=3D 0x0)))
 		return NOTIFY_DONE;
=20
--
2.25.1
