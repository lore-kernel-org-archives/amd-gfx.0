Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7A8C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Nov 2023 03:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D91310E1AF;
	Tue, 14 Nov 2023 03:51:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 553BC10E1AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 03:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsfdyR0LcMKBq2lOqc37aTv2RF5YVbY7WuXsl6U/6otsQtldQTNc09MzqNPVuRUAdNpUmXKiDY3iy26iXO7iqs/fQxKIJCwBJL2z/5aOCzEn4x+6b0EiVD/HvE3y39E/wrpIVrpQooaGz6UP01cyprH2DoGKfHJgy0BiZ0/zd6P4O7Kzx/o10/sFC/oMnpRLxoh/fCwZtRoDLE+RgOWQ1duQgfQpvfTe6I9zATuMIdNwFQF78iD7kuKXtEnALyH3vW6WbX//tkW/79ZXO9iOS9gZuCoLPHx+3zeqZjdKUAT0lTPIjIpI/x+9//RIjzQ3yA9BK4TwLp/HlFBnlFbyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3R4EiZti5q6RzrEm6y8nvPHWv87mqZ5bXP8LHfzoBs=;
 b=ApIR/f+gUloG92LVWl03qyIQ2VV1ymcvFBX2GNbgZZYhdJV6xZ4YmXuB6M4naV/ESf6CLBEz7RLT1ufFjgSg8dm0q0G1qPyAL3bbo+jrykuU4W8vJws09M7Y4KEIXpD+aN462idwrqUhXvh8NUBpCys1v9xf4BIYTNjDRYWB/NRYhtDSs3i3+TR4K13ONsf33FWai+XaYzV18UfOQz54+DBpw/5MTV9S5hTJtWk0E27p/FQeYAc9rXTw8+PWhvglpeTHBYfxRJqGatVokr8sHPa0maKtzvyn4Dj9UlDTxAo8ExrDciCTwgWhFL5pzZ++skSCtANmC8MSlsMtP+edDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3R4EiZti5q6RzrEm6y8nvPHWv87mqZ5bXP8LHfzoBs=;
 b=sjxr0kEYfoFZF6SazwzcJfThGQFWk11SiTDOjcM3l6T7IIL+6tVu+cazaYKmgk/NL5Jer609hZnZvIFznHANPHAQRDLk/wSGGG57biZAwME97Qk2/yBfsVFZ/X1o80j3rBM2JnUlhF51DPS8wVqhwS7HmqS2cq37EoIRzMvQT90=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Tue, 14 Nov 2023 03:51:14 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::a294:a55c:ea32:7ba8]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::a294:a55c:ea32:7ba8%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 03:51:14 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: needn't set aggregated doorbell for map queue
Thread-Topic: [PATCH] drm/amdgpu: needn't set aggregated doorbell for map queue
Thread-Index: AQHaEt989oyBBZsLEUuTKC1F3k5xaLB5NJpw
Date: Tue, 14 Nov 2023 03:51:14 +0000
Message-ID: <DS7PR12MB60059AD2E2CCE471EA628213FBB2A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20231109073625.1751945-1-Prike.Liang@amd.com>
In-Reply-To: <20231109073625.1751945-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=95ef8e3f-41b5-4cec-a2bd-95b1582de4ee;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-11-14T03:46:56Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SN7PR12MB8059:EE_
x-ms-office365-filtering-correlation-id: 93309ac7-a6c4-4a0a-5f0d-08dbe4c4f2cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pU7yItE09ICjquMaYXc6DFSL9v2Qd8PgONgI1siqhvqbvvHalG1ezilZvI46xWxjtE4b/nB5ehX4/WlW3x2gGmgOoDrrp2zJDeOzFp0W2kYyrh6vcPYTe8EwU9s/xdHvMFfLn4K8C7lfUzpVsLN/9qSwUFe2D9HLtVq0F2JNRYpOsiPyKHN3TpHBjw7K+yQGglXGVwvUOGC7WZ5UsySPJeS798TkzavhdwWBBG0ZHIt6BYjMB7fa22QncmaJXBeY91UaEse1LZkCQCRy6lCmtHaofJUQ2GJbssdF7hy++Hy7x2/YDY7YCCq+kvMqDF1p9jGcxKt8yPiXu7J4bS3GpZMwepaROX9AfiQFzQAHEEAkj8GtXGF27RBiLpJ45Ll3hQfeDy9wMSlafCcqEvOIXLz5gPFCMkfciFyl13C0dTq60gdnmlIzPlE0/CSabfuA9gh0TBPZed7pwJaGpkvjRocJN6yPo0N23kNwQ2/7ScGE0YRYAfj/Dy9bMi6cz35jSnKoUj1qnlzitSQSPpTPZO4xp/0PWSQtrHRdTjiYlGf4Q04YAj6Fe7tfSUwVZgHsBwD7wYVZAgs7wF3ONPsTdESaaWYhYuQFJBfOoxIvOB0ZhqHXPx6NF5fuQKXr0u9W7TaPzd0BHkdoDN6mVXX2uw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(7696005)(71200400001)(53546011)(478600001)(122000001)(83380400001)(55016003)(38100700002)(9686003)(8676002)(2906002)(33656002)(41300700001)(5660300002)(8936002)(86362001)(52536014)(66556008)(66476007)(66946007)(66446008)(64756008)(6916009)(4326008)(76116006)(316002)(26005)(38070700009)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oVDy2SBKhdTsAFmmGe2m/R7cGj7sROcodt8/22Kj0otDj7qlSL7WHm6QCmJO?=
 =?us-ascii?Q?vmvxUGWovDFDBtw0AUGpPdn/wB3/+y71ur+eFvitFREZCEHuuKoNn0SCCd9i?=
 =?us-ascii?Q?Q9cVQrohnulOwvbUgc2szcjnxk84/3rhDtbdI1DoTdSwICjTSiyQp8xUhYaR?=
 =?us-ascii?Q?jMU17atzUfq8C76/ZTBULzAJ1gvC4CRcFPDQZtmhPyZSpazDMOvtRCU/3Aiq?=
 =?us-ascii?Q?N0wpR87s1HJoC25PzH3jWdO44CIlbfkErisSRFG0yV2S81DlLpHqenfH+hcq?=
 =?us-ascii?Q?n21gI7+VL/cerJiBSG3ndGf7oBvavk3GEY7Qmj/lub+mHMcWTNYjMPAq91cn?=
 =?us-ascii?Q?uptghDq6474XS5pVhBFHyVTJg5njaP1mU5Qawh6dnHhNTGAvAfKH5KoYbJpD?=
 =?us-ascii?Q?qHZDReptTwjnwwtDK7+SimAmkRY17xMO0WMFWoaibX4X9l6xOB9bg3Z2h8J8?=
 =?us-ascii?Q?bLwQ75L9qmZRCSNP07i947hWOb9iOft5CivqjzMLTVAqEnLMhzAi6i4Bt1dv?=
 =?us-ascii?Q?og5H9jxL82eRl+YUNFqbBARSpDIV4FIqniTKgJIYo/kCV9Y5Y6mv6sQCV8MD?=
 =?us-ascii?Q?qHV9Z7U1E9Hlqijc31mhvvq8UaXwJqS9rk+D13M/Kwi6I9cY00IaB6MtENBZ?=
 =?us-ascii?Q?Xd1KMDCS4D1bXDzHOjnF14np5s1VSvYdJWdZgDkQTIRupuXEV/iZ/r441xL7?=
 =?us-ascii?Q?NXYGqiQIAhRNN3eFAxQgve8DZOPY52BgRLSjwHNih5st7HRIWdZXFgR0D8bK?=
 =?us-ascii?Q?mbsBPbVyM32gslnzvOO/hACuQ/eoik/klweYVfKKPKJb98WPo01Hz+Mqn8wc?=
 =?us-ascii?Q?lY+hJcNOAHL2pM3LqDedJ6n//mI32myvblawOc1n4NWhApUveu3Z40sw2d8N?=
 =?us-ascii?Q?XTPfR90YXxeNUQv/UmPaaVdJHz+SyC4+lxSRm90v35i03qCVFWlUSniuto2D?=
 =?us-ascii?Q?s9fUCpYIZaRu6okHJC7FBfaudJ/dz3Tfq7Z81No1YyXv4lD+7M/MLw8RRj17?=
 =?us-ascii?Q?wh7l7y8oCAJZlgJRs/vmKC6GAQZIc0I7LhZp8I8rIPoROHE0JoJ0XXwzrlhS?=
 =?us-ascii?Q?+Zy8n05Z5CL3XZVxUZi7pWX/ETqEq3WglMv9a6Zjq7A7YdPF4bg/JAlGYJ0A?=
 =?us-ascii?Q?qAT/XhOwNWJvIkpSGqhjVnTpvqMxkv9VJmeyqgCk98N9fpWlqtfhXK2Vm79A?=
 =?us-ascii?Q?kbmYo/GomUvqMJ0aqzeS1KmpPdC6RNAulwkvZ/qAph/WwMerwG//UlSYfxI5?=
 =?us-ascii?Q?lj8aZ30PCQhk9TOjoQZF3uPat9dBkw3dg44OWWxDgjEeCmq3l8Ayfl3F2wWW?=
 =?us-ascii?Q?JbtbQ/7XTOeVVBhi+C2uTY/wTRIKXO8k16GnLpmgU5hTCDCOoAIluwfJmT/Y?=
 =?us-ascii?Q?IlK0iNBPf9jNMq519Go8taFLkPtqFNY0eFbvNQk1r05OCc/TP5dKGNClSMqY?=
 =?us-ascii?Q?kOpyXoMXdQDVO6K1gV7f89Cs/SbeYyD0P4uxbUVIty+0lSljagSciJyrBkhX?=
 =?us-ascii?Q?aXj0g4uIjdS2A8hicSr7Qvf2gK4hNPoAnPprKciFAfS8Wp7Jv46kjsWd5IyI?=
 =?us-ascii?Q?GCFC7kZOQ6jIT+HUThw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93309ac7-a6c4-4a0a-5f0d-08dbe4c4f2cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 03:51:14.0727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xzge1+d850kregTv4lWReP6CVx8OajnB/ZSOO5eKPET8253Wr6nvRXSLz40Wp4fn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Please ignore this patch, double confirm from the stakeholder the MES map q=
ueue has possibility to change as an unmap queue after write the doorbell.

Regards,
--Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Thursday, November 9, 2023 3:36 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: needn't set aggregated doorbell for map
> queue
>
> Needn't set aggregated doorbell for map queue and remove the dead code.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 ------
> drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 4 ----
>  2 files changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index c8a3bf01743f..601bb6755bd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8220,9 +8220,6 @@ static void gfx_v10_0_ring_set_wptr_gfx(struct
> amdgpu_ring *ring)
>                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
>               } else {
>                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
> -
> -                     if (*is_queue_unmap)
> -                             WDOORBELL64(aggregated_db_index,
> wptr_tmp);
>               }
>       } else {
>               if (ring->use_doorbell) {
> @@ -8283,9 +8280,6 @@ static void
> gfx_v10_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
>               } else {
>                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
> -
> -                     if (*is_queue_unmap)
> -                             WDOORBELL64(aggregated_db_index,
> wptr_tmp);
>               }
>       } else {
>               /* XXX check if swapping is necessary on BE */ diff --git
> a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index c1ff5eda8961..14633e2ceac6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -358,10 +358,6 @@ static void sdma_v5_0_ring_set_wptr(struct
> amdgpu_ring *ring)
>                       DRM_DEBUG("calling WDOORBELL64(0x%08x,
> 0x%016llx)\n",
>                                       ring->doorbell_index, ring->wptr <<
> 2);
>                       WDOORBELL64(ring->doorbell_index, ring->wptr <<
> 2);
> -
> -                     if (*is_queue_unmap)
> -                             WDOORBELL64(aggregated_db_index,
> -                                         ring->wptr << 2);
>               }
>       } else {
>               if (ring->use_doorbell) {
> --
> 2.34.1

