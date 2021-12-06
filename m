Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05594C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 15:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51D576FF6F;
	Mon,  6 Dec 2021 15:22:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B25DC6FF6F
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 15:22:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gS7eKPCr+9AbIBaQUj0w7E9/xr1uuxNp/gSz1SmH+VE/f5bu4awF/tJ7X1863gOUufqdRB7RkSPl1QVfi04kVl/7f6VMYlssb5kKJtUyjrFDSvn7H/VWVsHGv6s6Tblt8rtdVMmS/GBG+ZQaBoV0R5qwuJg70qYNmpDxJeR6J1A4U0sqffyR6Ygk3k/Sofm9Cpzej5tYafZsOxUv4BOlNDuvuBDJkKVz2HNjN/BiOUa6jlsQFJF7ORsf4bEYeKFBlVTg49qUktbwIDXOf/PqVm5wCCpHCS0lTa/J4GVfAOXLed2GRLSk5aH4p4mU6r4KWhZ4J1OSyIHgRdLYzlYVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmmuNq0wKS7Wz47vaIMoxNsRvfsfHrTNrV04KRfvyVQ=;
 b=EQ0Z99X1XhlGXVcK/pfEjgYFykw8qsphAcjU0Lf6XKlzT0p2wNAo9pTsAQpy8t+pThET+psphEOUnFxza5W7gtfINKB+28B0dlRQv4DuK6tT9+be+j3iR97HKH8PZag627NHz+4dfdW6cOMbAHe23hK8HnSyjycuPLmz3S7rszvKn/WSnc9MYIjF5QYtN2a11uVl1RmerTtPZrRV7OMr0TJpmyFKADS2KFKIVL1++04dd/xMJ/Csn1p+x9ex0RBKbdegQrc/wRzuFaAqA3m3fCObA1oPHpNUiVjjnzOR0aWOJQ3q5pIrDqnbgsoSU4r24gpgNBgPvlYVsIWyPuWAyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmmuNq0wKS7Wz47vaIMoxNsRvfsfHrTNrV04KRfvyVQ=;
 b=gkNBfzn8ETo3LbXmNZvPTnLSZ56iWWtG409RAVTDnGFzpYapgUBappp/3wno0YA0YBdZgRQQlQJUTwEzAO2/ytyytgjyFm9z7Te9b3C4n9YZAAKhP9BuppWWYt7d1W0c1aQSOGO3I+GiaNxd6ofb2eML4xcb0vZAvUVYgo1HCto=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 15:22:06 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830%8]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 15:22:06 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: don't override default ECO_BITs setting
Thread-Topic: [PATCH] drm/amdgpu: don't override default ECO_BITs setting
Thread-Index: AQHX6osXxVuB3ETKdU2h37ji6XlK2KwllNRo
Date: Mon, 6 Dec 2021 15:22:06 +0000
Message-ID: <BL1PR12MB51448CB40D2F4D41F5D94464F76D9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211204112402.16229-1-Hawking.Zhang@amd.com>
In-Reply-To: <20211204112402.16229-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-06T15:22:06.169Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 52fa23de-c07d-100c-6a30-ac4fd8fdfb98
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e15325dd-dd1b-429e-25fd-08d9b8cc2a1b
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_
x-microsoft-antispam-prvs: <BL1PR12MB51449B1F4C655919A4A56F5CF76D9@BL1PR12MB5144.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D+X9WftvEFw+Zzv5JEJu0HpByC2abf6hUzx7RCtU55vs3/1qX6t1R7TXPjyBdkDNwTXNKMGxmDuBdxWrpwpOhlusaDgewpNrfv9rdGuh4HSAYzrf6qDoLIawcTlmkTxIK9wkNDRHy53erT7svZrA7b5GlpcRvXb3c/zDt2tNceJk+zftTDxIw/LrYOrF3L5pP9RaYrid2CozmtezrMm0NIvzRZzyvtSJ01oULxl+QWz7QGJu/Z0LlYTbvUskmdkr5SXLnmDmMWPmawQaj5yNMJUlUL8voM+ZnYDeJh8YnBhMnqY29hxnZEkPrBvJLEdp++BIWyJeD0yKzbd4lX7PQWI4jHRgwMj8jiarJqCPNXS2a6cSxw24LVbWnRpe50vJa7wz6KUYS+oVhiZbYZqhT9ivuXl1avDs6EDt1esmxVwO8XKdi/uCzZkfsGl1N20Y90GnXUBM5tJ5Ml2Gsni/3afeMlIbH0oos1Rd71RUf9uE8/byHSIXfzN1GppkieslFAASCL7e1uki4GKeRt1ynKhM+RNH2WUyp76Bxql0xNkQ1zdJ/tvvkd7PSuHI9xauMvrrQdZhT6k/kYIQtMLi9rCEPb44aKqoyQJs/A+6RlSw68+sXaq9wfUegp6G4mvWwnoHrp00xcrQmNYxYVkLF/BBmcYcqQA1e1T7YdzwOMWQkFKyG0se77Go9uxWt1GE13tDJHHvyrGCZKMS/MeyM43PvezkCicsHpXmK2YWC4U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(38100700002)(122000001)(66556008)(5660300002)(66476007)(316002)(38070700005)(7696005)(186003)(9686003)(66446008)(2906002)(33656002)(76116006)(66946007)(71200400001)(86362001)(508600001)(26005)(52536014)(8676002)(8936002)(55016003)(83380400001)(6506007)(53546011)(110136005)(19627405001)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FSP5WaZ/Bon0Qf5NqRfwlhu53ovE8h5QIv3Y7WMILvOlslbJaAgBPhdIO49w?=
 =?us-ascii?Q?2DxWhIQEqOfGknS3rsiIx+6iWymtoRUNiiezwS4GL4bO8iGnV6J+e6gE1Nps?=
 =?us-ascii?Q?eTxhDhKwy0ULU+Hsr1dlJ7Uq/p/rFQkV4lIgebwMG/0gDy1GhqDRkMDuLeMl?=
 =?us-ascii?Q?g14FankKM/lNcIJ6ItRbUIcnCjAzX1oDpzB6I/eZyi1eyO7VIsJAIRHNMpgB?=
 =?us-ascii?Q?NRQU/jyOv4YEriy+lyx7MJ83V+cQF8eOnio4Hsao8HeHZRAntA17hx8LqqpK?=
 =?us-ascii?Q?ZwISHzEz8Y0uRGWTZ0ZBVHj5RsjT15neTH4/5TdazHSVAi3y5qeRSJu/ksOl?=
 =?us-ascii?Q?VJV9HTh9lzdJm7i5TYOLEmABKcUjRerrpxAwxs60c+jcIQl+MRzo2tqa+B5D?=
 =?us-ascii?Q?edt7++doaKb8M0B1gwxMK2OK/k6/tD5xw2D1PMmVR/W2FCFBK70CZjhtMm3W?=
 =?us-ascii?Q?gKpL7KY5dQUe93E1Yvoy9D+KbUEXiPqnHjsfy7nbXeeZ0uE4geWJq5qmx5th?=
 =?us-ascii?Q?k/TP+Kfe4ren5lKowDB1aJBK8GBnEywiqnXCQe4sMb2fk8+FSEouBQaaIcv2?=
 =?us-ascii?Q?/jJZjNKWEmUq/Jnm2CWr5h0va62sqnSLnQACyltOuWgoo4oVoU/YLoucJak7?=
 =?us-ascii?Q?Bx/pwurZP6dYdXvadCuICt3m4RAGcTDLleddIHoU3shFswtQdzjzRcVT3sm8?=
 =?us-ascii?Q?G/ZzbN8kuC/Cqogor63digHsUjY9zDY545xhggbWLPjETDeHjlZtDaevOoHX?=
 =?us-ascii?Q?ka7mtxABFF6i0FelN7K9xY/lcIj8jnzVxqMhwlQoT5Ot/KMi0lMaZimzEW5r?=
 =?us-ascii?Q?5wJdEkgsLa5PL062VXu+zfOrjKJSpTsYXzzr93b3JsB0eMy0QIRfEdx3gG1v?=
 =?us-ascii?Q?z8a1GakfYPoG59oML4vkheN8gnDYQT7Iq/HljBladapM+qqrR86nP7V1n7zG?=
 =?us-ascii?Q?pltQfW5wyFl4eiat1cVx+wNlLzE4JFrEfhgzYAL77Zqz9+miYoESvBXtJDgW?=
 =?us-ascii?Q?5WrpIo+2fgg4ywh5y9HBDCXXtjRMBkANyTOoVxMoHLAZrgXGXaoPduYQ/99y?=
 =?us-ascii?Q?dCbg5JFo/u+ftGat/+zVnyLE53d0tcsNx6zw3FWXiMv4W/HuY4jvTFG7XgPk?=
 =?us-ascii?Q?EGBRNstZk8R1vDDeHGB2Od7ZFGBlPHrOqk/6lGt22PEjbYk0NYyFmTwyIbny?=
 =?us-ascii?Q?mfXeNyQ3wdAncaNwNSWqesukMgc696Co/KqrKQGj4hOAjO8Wnkg+hK0UgvRr?=
 =?us-ascii?Q?9sqMQqTYofK07g8o1OmODLvV7UscaKQRcvvQUzqwQoVJlzYZ5ZN5rFVJS5Mo?=
 =?us-ascii?Q?glyu7HrkLxZNNdA9dLYTmEivJtryrqvJZYjDPAhC52byKatxdVHoNbxfGxHT?=
 =?us-ascii?Q?9apyzuDACT8BMTrn0MESZC6S1c1RLtq2yzC2V3giL6RrvlMtfh1qnMMQAh1i?=
 =?us-ascii?Q?FzuNicHkJBl8aoX7T9boRdKEqIr+DZSl6tMw315aPPtYU3mitPRdqnZYcOq8?=
 =?us-ascii?Q?m1oVgO1MrsHKl9H1UTlRruRkCKU/ynyBJIq9gnuMkltEqNEn88Kbzx4sT/1A?=
 =?us-ascii?Q?9Ph2pDp9WlIrLsOAE1CA66F07Y6aYcBTAyfcoRKIOPLBK/sjKAAgCT8CTKzs?=
 =?us-ascii?Q?AA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51448CB40D2F4D41F5D94464F76D9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15325dd-dd1b-429e-25fd-08d9b8cc2a1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 15:22:06.7045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: noexC5RslkZ06bJglkDBRSdRtiWqON0zKt0DR/oj5LncD8VwKgA+cywTpTF8D1tDSZEJ5mDgzviq+v+NQZLHmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
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

--_000_BL1PR12MB51448CB40D2F4D41F5D94464F76D9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Hawking =
Zhang <Hawking.Zhang@amd.com>
Sent: Saturday, December 4, 2021 6:24 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: don't override default ECO_BITs setting

Leave this bit as hardware default setting

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 1 -
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 1 -
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  | 2 --
 8 files changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_0.c
index 480e41847d7c..ec4d5e15b766 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -162,7 +162,6 @@ static void gfxhub_v1_0_init_tlb_regs(struct amdgpu_dev=
ice *adev)
                             ENABLE_ADVANCED_DRIVER_MODEL, 1);
         tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
                             SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-       tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
         tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
                             MTYPE, MTYPE_UC);/* XXX for emulation. */
         tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_0.c
index 14c1c1a297dd..6e0ace2fbfab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -196,7 +196,6 @@ static void gfxhub_v2_0_init_tlb_regs(struct amdgpu_dev=
ice *adev)
                             ENABLE_ADVANCED_DRIVER_MODEL, 1);
         tmp =3D REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
                             SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-       tmp =3D REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
         tmp =3D REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
                             MTYPE, MTYPE_UC); /* UC, uncached */

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_1.c
index e80d1dc43079..b4eddf6e98a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -197,7 +197,6 @@ static void gfxhub_v2_1_init_tlb_regs(struct amdgpu_dev=
ice *adev)
                             ENABLE_ADVANCED_DRIVER_MODEL, 1);
         tmp =3D REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
                             SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-       tmp =3D REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
         tmp =3D REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
                             MTYPE, MTYPE_UC); /* UC, uncached */

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_0.c
index a99953833820..b3bede1dc41d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -145,7 +145,6 @@ static void mmhub_v1_0_init_tlb_regs(struct amdgpu_devi=
ce *adev)
                             ENABLE_ADVANCED_DRIVER_MODEL, 1);
         tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
                             SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-       tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
         tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
                             MTYPE, MTYPE_UC);/* XXX for emulation. */
         tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_7.c
index f80a14a1b82d..f5f7181f9af5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -165,7 +165,6 @@ static void mmhub_v1_7_init_tlb_regs(struct amdgpu_devi=
ce *adev)
                             ENABLE_ADVANCED_DRIVER_MODEL, 1);
         tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
                             SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-       tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
         tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
                             MTYPE, MTYPE_UC);/* XXX for emulation. */
         tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_0.c
index 25f8e93e5ec3..3718ff610ab2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -267,7 +267,6 @@ static void mmhub_v2_0_init_tlb_regs(struct amdgpu_devi=
ce *adev)
                             ENABLE_ADVANCED_DRIVER_MODEL, 1);
         tmp =3D REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
                             SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-       tmp =3D REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
         tmp =3D REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
                             MTYPE, MTYPE_UC); /* UC, uncached */

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_3.c
index a11d60ec6321..9e16da28505a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -194,7 +194,6 @@ static void mmhub_v2_3_init_tlb_regs(struct amdgpu_devi=
ce *adev)
                             ENABLE_ADVANCED_DRIVER_MODEL, 1);
         tmp =3D REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
                             SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-       tmp =3D REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
         tmp =3D REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
                             MTYPE, MTYPE_UC); /* UC, uncached */

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v9_4.c
index c4ef822bbe8c..ff49eeaf7882 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -189,8 +189,6 @@ static void mmhub_v9_4_init_tlb_regs(struct amdgpu_devi=
ce *adev, int hubid)
                             ENABLE_ADVANCED_DRIVER_MODEL, 1);
         tmp =3D REG_SET_FIELD(tmp, VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,
                             SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-       tmp =3D REG_SET_FIELD(tmp, VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,
-                           ECO_BITS, 0);
         tmp =3D REG_SET_FIELD(tmp, VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,
                             MTYPE, MTYPE_UC);/* XXX for emulation. */
         tmp =3D REG_SET_FIELD(tmp, VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,
--
2.17.1


--_000_BL1PR12MB51448CB40D2F4D41F5D94464F76D9BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Hawking Zhang &lt;Hawking.Zha=
ng@amd.com&gt;<br>
<b>Sent:</b> Saturday, December 4, 2021 6:24 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: don't override default ECO_BITs setting=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Leave this bit as hardware default setting<br>
<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c&nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c&nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c&nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c&nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c&nbsp; | 2 --<br>
&nbsp;8 files changed, 9 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_0.c<br>
index 480e41847d7c..ec4d5e15b766 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c<br>
@@ -162,7 +162,6 @@ static void gfxhub_v1_0_init_tlb_regs(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ENABLE_ADVANCED_DRIVER_MODEL, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 MC_VM_MX_L1_TLB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L=
1_TLB_CNTL, ECO_BITS, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 MC_VM_MX_L1_TLB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; MTYPE, MTYPE_UC);/* XXX for emulation. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_0.c<br>
index 14c1c1a297dd..6e0ace2fbfab 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
@@ -196,7 +196,6 @@ static void gfxhub_v2_0_init_tlb_regs(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ENABLE_ADVANCED_DRIVER_MODEL, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 GCMC_VM_MX_L1_TLB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, GCMC_VM_MX=
_L1_TLB_CNTL, ECO_BITS, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 GCMC_VM_MX_L1_TLB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; MTYPE, MTYPE_UC); /* UC, uncached */<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_1.c<br>
index e80d1dc43079..b4eddf6e98a6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c<br>
@@ -197,7 +197,6 @@ static void gfxhub_v2_1_init_tlb_regs(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ENABLE_ADVANCED_DRIVER_MODEL, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 GCMC_VM_MX_L1_TLB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, GCMC_VM_MX=
_L1_TLB_CNTL, ECO_BITS, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 GCMC_VM_MX_L1_TLB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; MTYPE, MTYPE_UC); /* UC, uncached */<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_0.c<br>
index a99953833820..b3bede1dc41d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
@@ -145,7 +145,6 @@ static void mmhub_v1_0_init_tlb_regs(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ENABLE_ADVANCED_DRIVER_MODEL, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 MC_VM_MX_L1_TLB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L=
1_TLB_CNTL, ECO_BITS, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 MC_VM_MX_L1_TLB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; MTYPE, MTYPE_UC);/* XXX for emulation. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_7.c<br>
index f80a14a1b82d..f5f7181f9af5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c<br>
@@ -165,7 +165,6 @@ static void mmhub_v1_7_init_tlb_regs(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ENABLE_ADVANCED_DRIVER_MODEL, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 MC_VM_MX_L1_TLB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, MC_VM_MX_L=
1_TLB_CNTL, ECO_BITS, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 MC_VM_MX_L1_TLB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; MTYPE, MTYPE_UC);/* XXX for emulation. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_0.c<br>
index 25f8e93e5ec3..3718ff610ab2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c<br>
@@ -267,7 +267,6 @@ static void mmhub_v2_0_init_tlb_regs(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ENABLE_ADVANCED_DRIVER_MODEL, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 MMMC_VM_MX_L1_TLB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, MMMC_VM_MX=
_L1_TLB_CNTL, ECO_BITS, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 MMMC_VM_MX_L1_TLB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; MTYPE, MTYPE_UC); /* UC, uncached */<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_3.c<br>
index a11d60ec6321..9e16da28505a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c<br>
@@ -194,7 +194,6 @@ static void mmhub_v2_3_init_tlb_regs(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ENABLE_ADVANCED_DRIVER_MODEL, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 MMMC_VM_MX_L1_TLB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, MMMC_VM_MX=
_L1_TLB_CNTL, ECO_BITS, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 MMMC_VM_MX_L1_TLB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; MTYPE, MTYPE_UC); /* UC, uncached */<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v9_4.c<br>
index c4ef822bbe8c..ff49eeaf7882 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c<br>
@@ -189,8 +189,6 @@ static void mmhub_v9_4_init_tlb_regs(struct amdgpu_devi=
ce *adev, int hubid)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ENABLE_ADVANCED_DRIVER_MODEL, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, VMSHAREDVC=
0_MC_VM_MX_L1_TLB_CNTL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ECO_BITS, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; MTYPE, MTYPE_UC);/* XXX for emulation. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51448CB40D2F4D41F5D94464F76D9BL1PR12MB5144namp_--
