Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E250EB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 13:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13F1610E1CB;
	Mon, 10 Jul 2023 13:52:24 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 612F110E1CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 13:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYhe6Jw1T6dfi7kTp1gGhw/SqJ4mcumnp66nN9tDqeYcC0f7epnFDZHs+pBiH4m0FkJZqwuS9BrmG9deCaUj+sZqmng+aTch1yercWUvTukgRrnUowfKIACmzUCa/YINQAVKMyaZwCb9oTCprIMsiV0YW09MA8ZaUDhIJ+XYnvdtQ1HcVdi4I5zO6nOJMMhtmUtF6UY7xrIs9XVlR/x9xRPV7FekxoVqsu6mlkP18+jJg1hV5ZfLKIWTRCPviZ3ylZsZJuRy+pxNMVvaNijuqzATxM8HtPznXJrRFytBvRgQQLPVAG+63EHlaFuqufM9zcMAzyqOOSLIsHPVictUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWXKrwFrSIkl/+VWU9zAa/biJh+aOB8KixpnFD46+m8=;
 b=jzKPB+TIcb4Q3uUpyxIVPLz4///7I/HVSNqh5sKAf74OLWdDdL98ozireAvfAEXNqutXwNv12vjDAzK/btWKwRCD4zMoocwjx9HiM89bOv2q9ZSgQkEBe5pDQLhkh/vzrcMaVH6R/ihSkrb9k0xLJrwK23H9SNM6c3g4f5FXJ072JCE3phOcdnq3pqf60kXqbWctggRf422VpX+gz4J8PQhQX/Hdkek0hhfyfwXwToDE5+EnOZ1FpA2niplg0/6PiiJ7fJYKSU6YD+okX9rOW1pwLfXu5C8CCSHSOadh3jObTZPzO/7JwsU3CdCRq6ETIvPTBHt2gM+H9O+yRMWHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWXKrwFrSIkl/+VWU9zAa/biJh+aOB8KixpnFD46+m8=;
 b=je0MlBsUDI0nAkL8VAwS8uWpUDKuLItV7ssEWTi9gvyRmg4TVegII1V+y8YMxseKpH02jBBiN2Hnm4yMMKu9174it8Raw2go70XD/QI5yyY4Dcsdje4uINE3BEOVs25uJogffGoMA93EDuXOowK5fm8F3Y4iHPf3iDPFJmSJnUk=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Mon, 10 Jul 2023 13:52:19 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 13:52:19 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Jamadar, Saleemkhan" <Saleemkhan.Jamadar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Gopalakrishnan, Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>, 
 "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: update kernel vcn ring test
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: update kernel vcn ring test
Thread-Index: AQHZswfwbk32SZPJj0q89T6rwVt43K+zBP2Q
Date: Mon, 10 Jul 2023 13:52:19 +0000
Message-ID: <DM8PR12MB53996FDB1FC4A041382FB697E530A@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20230710082357.57516-1-saleemkhan.jamadar@amd.com>
In-Reply-To: <20230710082357.57516-1-saleemkhan.jamadar@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9077e3c8-dabe-491a-abee-a986a591367d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-10T13:50:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|IA1PR12MB8520:EE_
x-ms-office365-filtering-correlation-id: 81a5c1e0-931a-41fb-4721-08db814ce0e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P7wtO7WEqDT4XWhCEovLJ3bC8Cs4+SPoHquFzR8sg6NY2Opoq0eMBD5g0oLaolDq9LvQHqHb6xX8deZe60ke/6Cl104qemCidmHNXrA3q8aMt+K7cx49nJruV97PagAq+1CURHFf9jpk9pgMaIPlwSvDOtU3OnJkgmhw9bJfrmqNDK7j+Kl5mLDjDYrKVU8D6puIbAk7lJH6cf1ya+uUcKbTIApZy6iqiBTybpdJCAhO8vNU+Wcm7XmCBj/DqLdflzeDdz4+ZHmvSkGR0yQcD/k+npPozfP3NOySBUJxv+FkGUgObc6tEEopEpCiz7xnFpI/PCN4rGwUC1oLSXkvpmHoF6lZGo6/ZdQ6HybZzs+jqiwoKKptMu+ayfJ//C521R2XEa5kgg4vJpGCz0dC+B+tIv4Bvp27JkR1mhZTyymfFa/siRzubhHZWup9taB+U3RqjTU+zsHUHY5EsAhufm3SaXfSl9Y28ZY0LXk5MmFCB28dvQBm1t5tgb6IgoD3UJ8kKGc9SaJ2mo66TqCvVLg3LJd95P5cYKFNBRRDgUA1JSz70/hdPKk9/nbpdVxgEqnDypaenuPv+mNIIUI7O4hutsy4kkAFx/8U1rWQHqAeaoHkxOnsKrdexKvhym6U
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(186003)(9686003)(53546011)(26005)(6506007)(83380400001)(41300700001)(4326008)(6636002)(64756008)(66446008)(66476007)(2906002)(66556008)(52536014)(316002)(5660300002)(15650500001)(8936002)(8676002)(478600001)(66946007)(7696005)(76116006)(71200400001)(110136005)(54906003)(55016003)(33656002)(122000001)(38070700005)(38100700002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YXgTrHQAXCXtgi9T/GJYAzNx0aJ+NXWpDVwYTub0WRNHVqnjSVVZUSr/OTLg?=
 =?us-ascii?Q?sbPXT3Ro6TYjCxFinh+4/8UhLTebozYOMLW/Qmod18c6VuFTO6hOXbzZX/EE?=
 =?us-ascii?Q?hHi9lqFMaEsQaygxAn8F3Avph+EdszP30z/dR8Y9zvWPU95qWFgA17+oYe79?=
 =?us-ascii?Q?TSK051ctKwHPFV9i0wumC9l85Lwn5AX+1Xy/BQjYojG+AwmiXRmXBjMVjy1V?=
 =?us-ascii?Q?9/gcyhQvXj5NJ8BYMWzCBGI5Qub6YI5oEkxhDoSwcCkvpk4xWnwo+qnpE2Pn?=
 =?us-ascii?Q?93VNA665Ea/VaKflqiEAKdo6mt46gERN9DJufT+k3Ag13uH1ISh9pEM9nIeH?=
 =?us-ascii?Q?RXw+wR+4fqkS9Nmw6tH4e8ESkMhAoY2ONsc8m1Hff1vR0P9moARPbBezWN4Q?=
 =?us-ascii?Q?F5eAkEF0t60HM6w+pA3BiNfuKcuIwqkkMEIvX+Bt5IHzdmu+raUSPRXWU4P3?=
 =?us-ascii?Q?EQ+QRYtUT5mm8g44cTpunWvVEdTirTwTGrSZ49tzDzEIma9TTZHnqy1YupRs?=
 =?us-ascii?Q?5NrQop+6DKka5Y1R6w141f7WTiDLqUu/QuvHcb+k7810tGgyW5/IL/aRVJXS?=
 =?us-ascii?Q?3omOmhD4ORbupGVqKRpKDupVgs1udL0GzWypfbkLxVXVjwj2YE0N29YmwZgE?=
 =?us-ascii?Q?ub5MWWSdKXkpNO2e3hy7vrjqWREnx8P9WN5KgwnG/3qGbEjLsyUNW0v/9ru5?=
 =?us-ascii?Q?rlSQqbMQb8QkKIzfmaJbeh7na7FD9ezfPtDYIeM0i5HeGazjQzNTIzPD3iiN?=
 =?us-ascii?Q?4b8QtRUFdjmhmvQABovQapMiXAz0VrrdxbtHsXJjIfOd0KBKHV9vjtPQAWc0?=
 =?us-ascii?Q?kd2y0a3/bDA/BhNgkb/yvsdL2723jlCm1HExMjZCLoY0Mo0qojyvAX8Os5jE?=
 =?us-ascii?Q?fLxapCjLk8h0eNIrJEOiPu6zfgP/4n+uX1NPuXO0etDfZIrIeMfQgrByMSJ3?=
 =?us-ascii?Q?rmTlcD1qvfWuPxV8ev0aIm3tDJpmytxpy65iTBvpLfKLTmII7SEMkwZ8J7O2?=
 =?us-ascii?Q?i9/tcOrjvMRme1HtO0pJIIQpwRSmwl32sE7M1G1eU9pfSOoYzFnc52XokAT6?=
 =?us-ascii?Q?6hxx5JvlMpgQ4I8lfMGHZgkFYhUWBho+bzHbZ/qTN28W5MAkZC/trx2POw50?=
 =?us-ascii?Q?8dm+1AdQm285MIXL82gcYEQFpv4axf+qoXgPGYcB2pW0vR6j0/S+xjtt6uhZ?=
 =?us-ascii?Q?kvXbDo3zowUYTjMdlNxxomLoRwGU3eL6Zoc7zUZIZaVO9kcQJJoi4VsASYvg?=
 =?us-ascii?Q?IPDjjhtLLpvnwrqU4917p2nci7ITF2fn2ViWem2MIfWMSYnhi2xrj6VmAeQM?=
 =?us-ascii?Q?fsQ8FFyAark9zXQIqS6yZRVlzAJB8jAA3Oq8BJAiTKo9kxuU4I54Krt1V5XE?=
 =?us-ascii?Q?YAALzEDCaoZlK1rrSNbB45u421NC7kQ1Cy3TG/vVV32UN+M62JwMqDNaqahq?=
 =?us-ascii?Q?afXBDNWQG2G6T/uuscXBQVjKMmz44IqePXmM8ovqMfWBa4DJqeGxX0TRD2vK?=
 =?us-ascii?Q?WFzEg/prtz1zefo06uLWBYdpi5OqJ3jlW0Bz41asM2WZnhuzq7F9oeV2F7nN?=
 =?us-ascii?Q?6holok2UVW460SSJmY0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a5c1e0-931a-41fb-4721-08db814ce0e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 13:52:19.3520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtMtCrKT0MyP+4e7Ajaulb/snmPh3rrjVNsZxsuGfWNu2E12/gb9u0LUQ8Y8qGTR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Rao,
 Srinath" <Srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

-----Original Message-----
From: Jamadar, Saleemkhan <Saleemkhan.Jamadar@amd.com>
Sent: Monday, July 10, 2023 4:24 AM
To: Jamadar, Saleemkhan <Saleemkhan.Jamadar@amd.com>; amd-gfx@lists.freedes=
ktop.org; Liu, Leo <Leo.Liu@amd.com>; Gopalakrishnan, Veerabadhran (Veera) =
<Veerabadhran.Gopalakrishnan@amd.com>; Sundararaju, Sathishkumar <Sathishku=
mar.Sundararaju@amd.com>
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Rao, Srinath <Srinath.rao=
@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: update kernel vcn ring test

add session context buffer to decoder ring test for vcn v1 to v3.

v2 - add the buffer into IB (Leo liu)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 76e9a2418286..4c44d76f69de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -521,6 +521,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *=
ring,
                                   struct dma_fence **fence)
 {
        u64 addr =3D AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
+       uint64_t session_ctx_buf_gaddr =3D AMDGPU_GPU_PAGE_ALIGN(ib_msg->gp=
u_addr + 8192);
        struct amdgpu_device *adev =3D ring->adev;
        struct dma_fence *f =3D NULL;
        struct amdgpu_job *job;
@@ -546,6 +547,17 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring =
*ring,
        }
        ib->length_dw =3D 16;

+       ib->ptr[ib->length_dw++] =3D PACKET0(adev->vcn.internal.data0, 0);
+       ib->ptr[ib->length_dw++] =3D lower_32_bits(session_ctx_buf_gaddr);
+       ib->ptr[ib->length_dw++] =3D PACKET0(adev->vcn.internal.data1, 0);
+       ib->ptr[ib->length_dw++] =3D upper_32_bits(session_ctx_buf_gaddr);
+       ib->ptr[ib->length_dw++] =3D PACKET0(adev->vcn.internal.cmd, 0);
+       ib->ptr[ib->length_dw++] =3D 0;

This is not right. Again please check with Mesa.

+       for (i =3D ib->length_dw; i < 32; i +=3D 2) {
+               ib->ptr[i] =3D PACKET0(adev->vcn.internal.nop, 0);
+               ib->ptr[i+1] =3D 0;
+       }
+

Do we need update the ib length?

Regards,
Leo

        r =3D amdgpu_job_submit_direct(job, ring, &f);
        if (r)
                goto err_free;
--
2.25.1

