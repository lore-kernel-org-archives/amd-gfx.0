Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF43D609A0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2024 06:25:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA78710E0E5;
	Wed, 27 Nov 2024 06:25:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0XD49Cnt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B763F10E0E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2024 06:25:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=om8BsabkwGUPWXeYCh1wppJ41nC7TbtCc2Y9BUqKIpVI+jdAx2yLVEKSFtMGmf8u4x7Hb/BiMD0X7Yv44jYntHpTBf+QiosAyo9ymT8H+QWJTQgqoRJkt6+lDTM9Fi8tmgoqNmEIZ1IkReBLPpQ+YxRKC/KbLuSoQ0MQIMlAW3/WWoEiW39IG7ZwUnpKT5lQxH4M6PBLDYgUrxZynC6DK3DQE48on7tWLvymHUqf7YZAHccWBl/dIny2izHJ5mVSCiZWTEoyKEw1IL80p5IzfH40d6KLZXBH9frEVJRpwJeYbWNnFYKFCtKDseU8s/z7q/M89tnYIFUL3LxbM17Y0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dKgXjXT+EpXe54w+h9SLwMwZpjn9HTO0LbOJ2TXO3w=;
 b=kmlUJZ0OPUYWFbzaSQl6roWac3Y5BWPc7qf7MM0MasNQp3dN5gGTZ8ZANJPYPb32bTpZaN+VAhOsiE4SqLe65IkMJsyUBMyAjtVCuIh5f7CDgy8KT0k1OwWnXnKTTZ/xRerSqvAU84WT1oZMYgDpuKHcj5fJXr1dn/CVNAhIcTlLOjQYd2RNZN35MY/X0KmeAoPp4PbJj08psx6jfCvRu2t4hj357+xdP3ULSt8EwLHYMcIp1HwuTbF5WiaDum2fQsA2aHRXgUafEI/0HUuMv1iC6VH0xtsz2GJRy2AFv9WiRE9EdYh8R4+I89XTtSHWYaiCj9zQGUAdiu36Vv8RiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dKgXjXT+EpXe54w+h9SLwMwZpjn9HTO0LbOJ2TXO3w=;
 b=0XD49CntDS6AcibPKw6T2XHzGnM5KK/qx+O/FmntE6iv0AkU39yk0mzRSRLgXSs4ksmlb4MhRlhb9Jfc5dRE9w9dd5P7ROQRoW4HojaSkTXkeiQ7N+/uwQ0kJiqXgJ+nDBIGKLHVli0htQQqtPp7rH1cwOM3h3cwHaVVRoyhiu8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 06:24:59 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 06:24:59 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Remove gfxoff usage
Thread-Topic: [PATCH] drm/amdgpu: Remove gfxoff usage
Thread-Index: AQHbQJOYBSNK3QPC00Scnkuwz2sPubLKqOrg
Date: Wed, 27 Nov 2024 06:24:59 +0000
Message-ID: <BN9PR12MB5257A52B86130AC5157B4C63FC282@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241127061353.3461098-1-lijo.lazar@amd.com>
In-Reply-To: <20241127061353.3461098-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a6de619e-a912-4852-a600-21b6fece9bcc;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-27T06:24:38Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB7987:EE_
x-ms-office365-filtering-correlation-id: 5fcef78e-3057-42c9-aca1-08dd0eac3831
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nu81Ckv57d10z5PxcOxCakP/a8seIj8Fq3y3rqgc897+ylTdHgL635b1jAjD?=
 =?us-ascii?Q?pUGbv39dlcVDhQTUzDs2biPEafhwTD0gRKqjs1dUbcRxbKmkegUYpMSwY0Bz?=
 =?us-ascii?Q?ntHAHSJ9bZKXm2cbkZodUWUr0bWyAtyBiDzqEdOyHS/De0+3/WRfBXwRXEUs?=
 =?us-ascii?Q?VTvkNIGfW4QO98WkCeuLwr98szdBYUDPCn3cVvE2lgICR8YoGLEzokGOFsaX?=
 =?us-ascii?Q?GlLPCpu2OoJRv4OjMwXrLMRVtfCBzC0RZwuNIm03ZW5CA4X6P9udYIZggvcL?=
 =?us-ascii?Q?jqv+2l1hFc6nsRzinfKEfToT4t0voebnjlorNfT5H9j2cvkbES7KzEz0g+z1?=
 =?us-ascii?Q?gr/Z0bggHLFu+t5x95/7d/9gyqMi1cjVa2E0/mbytN27lbF+3hZs+uTqE538?=
 =?us-ascii?Q?I4qpWgYiL0xu2n4ZN0EiNjXUVRplWhPdcOA/9jnUE/zDda/MXHOIz67WseSD?=
 =?us-ascii?Q?c9kCH8/OFO07qUpBa4HsUN25xOvTn6hAyiiUD15tl7gB4UgDfhEaEKmlMUfz?=
 =?us-ascii?Q?9/SfV4e5lCrV6z+CmiOEfYthsWHXlX3NkudfHCNKfpi+RA8u6VQEGNtYEgQ4?=
 =?us-ascii?Q?PvePMIbCp63RHVnes/UOeGx4KD9RXxzn9bUZ2DSFwFD/JX8/jqTe6e8OpBO/?=
 =?us-ascii?Q?9p8FegTDR8Oo7vgWY2U0w3l36sN4xnVBI0UXhBjk5AoK8r1gemny9pGVnrYW?=
 =?us-ascii?Q?MnA4YblxJAqC6UUfAVzis6yPaylzU3L/+incEKLITIROXTe5UqJ5PhQXHtic?=
 =?us-ascii?Q?J8B7pnaPl4yxnnJtBTR9Ma9dfe32bYL4ksKMY5ufY+Tq5UGMABfo9ztn43Eu?=
 =?us-ascii?Q?iM4GYQjUQAlimE0kv2wgax4T9KH5tScQy4aIYtOCtx/ZSOc4pAXMuY2wU9wr?=
 =?us-ascii?Q?TxkejfWRXO0wl/+ah0gmLFz3gz+C7Idkxt3Mo3pKQrnat+SE8OXFXRaj2XjW?=
 =?us-ascii?Q?D6oBocX4V83cnBkLey1WPgbVbsFxC3C4go2PemsHMC8RwP8jt+mDDj64uZiA?=
 =?us-ascii?Q?yjKM8osDaqYAFpihyz5JWgkcDbcsV1aQMphl+uCQF3gQ5bnwVm8Z6YXeFPhY?=
 =?us-ascii?Q?ADk3mIwUG7I0qZA3Yz6phThzDllVayxi3Ls7O/BZlbElVH8mWKzajYYPqCey?=
 =?us-ascii?Q?L/aKHtJK9M8A/YPTNR1HX3ULJ6Af5hrV4QUdSXcMQb9yrtw7b35wS1GxQ7pg?=
 =?us-ascii?Q?CIAnL0ivhPIvZn/XXRceiuQgg58TTtsMHrxpIJB6mrTEFVQ/SScMtchmftO7?=
 =?us-ascii?Q?jla87Ph7Vhx1WL1vhv69ZHRcLr9Rcq4/Qaeag672V/L9ggL8bbHUz+ESetmL?=
 =?us-ascii?Q?+DwoHhjmkN3DZff4obWtGDEXKHq/NnoEEb2ZMye7flnjZArd71Q0uDyIRN9x?=
 =?us-ascii?Q?JHxBLCTCFF5trqAFucyL+yXpLIp9zIzcubPoDC4899jJAEjJoA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xrtUV6quOC12ZI0dTZMMx7VI0WvTtkhjPLZEzvNpn7NNbr6FocIJ7K1Jz5+n?=
 =?us-ascii?Q?Cx5wHXfUdNwQbj7caexqrEUxup3xR1aG8S0ymISOMwN3pKKu4yf/DMJfKk/L?=
 =?us-ascii?Q?YHAsn5Fl9B5GtA5dZ1dwVpPRDCNMevJh5Tj1HnbwRGgTXsu/wtiOnFZXvrGt?=
 =?us-ascii?Q?zFLR+QF+5HRnqohDEXcLaNJtPP2uIvFtHwY73tc0GyEJv6p4UCG0xGa2GvY1?=
 =?us-ascii?Q?ePwypn1RgAPPbSWO6E3gEemAUpOG4l1RI4WGGiSRtIzI7huua9mQsSF2qmCZ?=
 =?us-ascii?Q?pNVvPCAcFwVXxY2Ec0RDjT1KKSAyFo9+YplYWa9RBB6ZhoR2G643lYLseGFP?=
 =?us-ascii?Q?+cGcZObKkPILjLdWogc+0DbGcx9KjPX23J75nLVK/lDIIGzm+F436w9nwZra?=
 =?us-ascii?Q?Ftj4Pi9m7mAzeOXBwqJI4ED+6zjXGUqDNlz5h3KHLJRs1XtUqi/jkqzTIpJs?=
 =?us-ascii?Q?lnzI4x+s3l0XiUlBmjHoWkvdVxDoyizM0wIp6QiRWZRykAuzCKDeIz1r+6ug?=
 =?us-ascii?Q?bUlJ30eu7TP1Ab0tsbYW0bM9VLn7ge7Bz1LNy6gesGDD8v0kqp+09buRc4pB?=
 =?us-ascii?Q?0H61mQwuLCVyYdGzTrefdJf/2R9n4gefcp7ekr4fD/sGI2Kzo1epbi4wuBKl?=
 =?us-ascii?Q?U1ziWrEMIT6JDaeHqjPA7OY6K4ihvoQ/eIOspKvoV6nK7v6/UGP8uxr4iFDG?=
 =?us-ascii?Q?lVTumC60mfEXUkrYw5PXW2WkL5WRSonvDz+QYRJTRtQ/68nvLqw3ceas0BWK?=
 =?us-ascii?Q?627ic4Pj0E/eAXs2ZI7OQwmSBv+QxwMDbf3OnMubsMJCCFzqH9jDK3Q2s/nM?=
 =?us-ascii?Q?SKrq0NrLfrasDOYbQMk/PTVu509WpTBMI3LSkfrW9domZlLA28QV/eTPDlOs?=
 =?us-ascii?Q?F2H3gsK9OBY0VO26PQsUOpBZULSU1rsyYx2XZqWH2CQTnMvQsPhUjf+5rh9J?=
 =?us-ascii?Q?smzLK6fG616V4RcCtY88TjW2/9icH0NulItdhbglX04YMd6K8X/a4C7K0P0G?=
 =?us-ascii?Q?bQyy1eGLTjsIUGQJchcRRlSzlSsZ8ih2p4Jy/1cIurTLrO2iDXVB3WlKycFY?=
 =?us-ascii?Q?TOa8g1lMeRcVtIdR1ZWml/ElzCAvSVBZOJeeQxiuT1qOjXcUvfSaA8Ct5SRo?=
 =?us-ascii?Q?iA00NBYPRjroTZ040caltO69Pcr7O71cYqf3mian2TEDMCtKbedZ6sX/s6gT?=
 =?us-ascii?Q?SAx/JleLYcdJoC45NcelkqX0QjL7TJsw9lVSXpZuwoFkc+OUQ44B5DeMYQzD?=
 =?us-ascii?Q?+npIIlqe62PSPI+8m0R7Eg+5uadi0k2LA5zDoyzyArYHsgwBTbHzjFoAaqYM?=
 =?us-ascii?Q?lZtdrSfYcb/NwsIM1U9oBOLhFJlbJljwweZQmMzte0OoDagB08WINpoXmdbD?=
 =?us-ascii?Q?3P27NYcAUGvHpmDMKKBdcdKd9hsPHtphoV1khp+woSAm3ucyzb0kjwl7QHEd?=
 =?us-ascii?Q?tRzXr+yCEQCpJZhPKBlvecAf0U0dUACm7pDal+P/nus98TRe5rEk4CK4LBUB?=
 =?us-ascii?Q?ilZ9aQAZ1WDziAIQF0mkYkpsqp0wsE794Ch2ccn8Hql8m7TuVelpHqp6QeXM?=
 =?us-ascii?Q?xAUpa/MTNrGQPiEFrsg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcef78e-3057-42c9-aca1-08dd0eac3831
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 06:24:59.6132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FW8xBCuXH+xun7E0ih8BsuQohmw4wWF/GYBua+0cCml+4jQbeZixRhwWe6NEChD/A2BMQKGDlIe4wQnAZZnMbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, November 27, 2024 14:14
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
Subject: [PATCH] drm/amdgpu: Remove gfxoff usage

GFXOFF is not valid for these IP versions. Also, SDMA v4.4.2 is not in GFX =
domain.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 4 ----  drivers/gpu/drm/amd/amd=
gpu/sdma_v4_4_2.c | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index f23df55d72fd..decb709707e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4651,7 +4651,6 @@ static void gfx_v9_4_3_ip_dump(struct amdgpu_ip_block=
 *ip_block)

        num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);

-       amdgpu_gfx_off_ctrl(adev, false);
        for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
                xcc_offset =3D xcc_id * reg_count;
                for (i =3D 0; i < reg_count; i++)
@@ -4659,7 +4658,6 @@ static void gfx_v9_4_3_ip_dump(struct amdgpu_ip_block=
 *ip_block)
                                RREG32(SOC15_REG_ENTRY_OFFSET_INST(gc_reg_l=
ist_9_4_3[i],
                                                                   GET_INST=
(GC, xcc_id)));
        }
-       amdgpu_gfx_off_ctrl(adev, true);

        /* dump compute queue registers for all instances */
        if (!adev->gfx.ip_dump_compute_queues)
@@ -4668,7 +4666,6 @@ static void gfx_v9_4_3_ip_dump(struct amdgpu_ip_block=
 *ip_block)
        num_inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec=
 *
                adev->gfx.mec.num_queue_per_pipe;
        reg_count =3D ARRAY_SIZE(gc_cp_reg_list_9_4_3);
-       amdgpu_gfx_off_ctrl(adev, false);
        mutex_lock(&adev->srbm_mutex);
        for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
                xcc_offset =3D xcc_id * reg_count * num_inst; @@ -4695,7 +4=
692,6 @@ static void gfx_v9_4_3_ip_dump(struct amdgpu_ip_block *ip_block)
        }
        soc15_grbm_select(adev, 0, 0, 0, 0, 0);
        mutex_unlock(&adev->srbm_mutex);
-       amdgpu_gfx_off_ctrl(adev, true);
 }

 static void gfx_v9_4_3_ring_emit_cleaner_shader(struct amdgpu_ring *ring) =
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index e70460693ef2..f206e98f2069 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1948,7 +1948,6 @@ static void sdma_v4_4_2_dump_ip_state(struct amdgpu_i=
p_block *ip_block)
        if (!adev->sdma.ip_dump)
                return;

-       amdgpu_gfx_off_ctrl(adev, false);
        for (i =3D 0; i < adev->sdma.num_instances; i++) {
                instance_offset =3D i * reg_count;
                for (j =3D 0; j < reg_count; j++)
@@ -1956,7 +1955,6 @@ static void sdma_v4_4_2_dump_ip_state(struct amdgpu_i=
p_block *ip_block)
                                RREG32(sdma_v4_4_2_get_reg_offset(adev, i,
                                       sdma_reg_list_4_4_2[j].reg_offset));
        }
-       amdgpu_gfx_off_ctrl(adev, true);
 }

 const struct amd_ip_funcs sdma_v4_4_2_ip_funcs =3D {
--
2.25.1

