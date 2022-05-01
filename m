Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD62C433F5
	for <amd-gfx@archiver.kernel.org>; Sun,  1 May 2022 02:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32F6210E17E;
	Sun,  1 May 2022 02:13:52 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2062.outbound.protection.outlook.com [40.107.102.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7441410E3DC
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 May 2022 02:13:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeglIzB0MhlAqo4tyjLn9sODoHRGKqSiCo9o/JL6nZXuAMg01553Up1NlKM4uVe1Sdhcm6IXzQnHc+0RdmLlp6NXSDGqDHbAoVB8bv/7FqmWtmSj9aWdaw/Qng1xLTwHKhYgb+fM6/WusHuJRM1WHMie/o5lGg/Q98tddiPE2JukZzl8jNMPekA1VGCdj0w3aT2cfcAFcYznGat3lbvjYaRvAfCsvfZaHZBwg9SWqrrzqOdBpi03jQoOucUnVX/Q5Q/nN6AeZV90G/9C9UEeyPt3GU6gtS9OmKHFiMt7rDYxI2nXVPxV9s1id9TCVSOUN0CoV+uJrzKA8iQ3Nr93wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WJ2hmq48GElC0rC7zeGcjJVpaB/g7qj9nqlqmpbEPU=;
 b=RIEmKOLBzJXp6xY9Ow/CnI5OnAGzywUOaUjRTFegaZm52MGoJ4tQrI5IMEO3rr+2KMeOMEBvwfzuCbuxxnDBatDGAOasr4x310A13tJWY+OxDuQDXCpMnwWv1NKXsihZmB1S35N2tav2zaS84E7XKAyViIM/3ccyHO5qgw95vzdWhL/NfqeKrLj5tSov7NKx/8bSkKmcGTDFvhFRxBky+Nc8LC8taF4bYVaHaLXBvxLMx9nXJ1IIMRU1cKc9vSVhhyCcHA0g2R2/Q0uTpVC56RTaJnNCE+JwsCJRMBmV8D9PH0WEPURlV8ErNReVpW6CuNv/zSLS/kq5yLt9R0SRyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WJ2hmq48GElC0rC7zeGcjJVpaB/g7qj9nqlqmpbEPU=;
 b=x0Uf4EISUwYbTF5Gnjj1Ho5UCMeK7kCg2T8VyX9vjICJycaIr0WPpE4FbmEjbnNACOb3Os0yNZ7yRC/+edl03Pj3Q7PYxr6waXEmKM+BPBLfNoxxYxJ1RcJkIavPkvzjApMG9ADZU3ve+WWfaLEqEFIdp7tN+IDVp0C3hEbVQd0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY4PR12MB1607.namprd12.prod.outlook.com (2603:10b6:910:b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Sun, 1 May
 2022 02:13:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da%7]) with mapi id 15.20.5206.013; Sun, 1 May 2022
 02:13:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/6] drm/amdgpu: add FGCG support
Thread-Topic: [PATCH 4/6] drm/amdgpu: add FGCG support
Thread-Index: AQHYW++164AYwKnmrEi2MJnAcDN8o60JSj6g
Date: Sun, 1 May 2022 02:13:48 +0000
Message-ID: <BN9PR12MB5257558C17EE2E8CE0F35E71FCFE9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220429173617.433334-1-alexander.deucher@amd.com>
 <20220429173617.433334-4-alexander.deucher@amd.com>
In-Reply-To: <20220429173617.433334-4-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=45df4c42-a87e-494e-8a0d-0ac0f8f3530c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-01T02:13:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cb0723c-ea1a-487f-6bb8-08da2b183a64
x-ms-traffictypediagnostic: CY4PR12MB1607:EE_
x-microsoft-antispam-prvs: <CY4PR12MB16072CCE8213D91F449F1D9CFCFE9@CY4PR12MB1607.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WM9xFSC1SFF5FlBIafWsGWgYGyUX/0KD/NLC3KZ+iO0XE1sPva/+lGuEIMAaPr62/Nped8SalcWVS5gYkmNVnOUgTUF9G4ozu+XBqnEzgUMbOQAJaDpQhTDfVMxShUqpyKWgKMAE3HZ8Z9uM53kWXX2auJtOg3AjkSfZ9hnuvCIb8Hz/a7bIi4Y50vnBgibEqWAEGXYDIiJWlZhamv4kXsZeo+lj7lsV8jvl77uhaLopLnWxyGXo2PnP4G1FKLCJBc/CNwHFJoAXZW7SYG+qLuvh8qwWsmz70rhRocX9mdYmLwJTh8RTxLAPusHvFDFO26tDaVEooia/XQY2FbTuaypalv4r685CBGi9oGxTxUD83xJriSeNR52YkT3E/0kMvJ6YJifbW3acRx10DTcvpRVecWqHU6MtK6xDSdgBtWa26szF2tMvrVYv918y3X77R6Dh7JNlHZEeYJjQkwU1KhAelbIsfTp0YaF8utlrnZ5dUYU0mkK+2StIE3IR2BFwczbA435sD9ZTOYaW78Ho9Mg9lZ/pENFasMOqRgBynnEPQm9gg8lXLIyYXNB8v1ODNR20gQtssA87YHcskiTlw4mXNnelkYCZLRGMzVHP8UlTflxp07TKSXgArBMJiWjIn24ur2b3LjjmWQgP+BABfj8GQi2K3URYEJj7/VF2tdHw9on/mipIfzhn+zP5FBZlmJ5TQCI9mvpk+ZDsQdEnnQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(66476007)(64756008)(316002)(66556008)(66446008)(76116006)(66946007)(8676002)(4326008)(53546011)(508600001)(26005)(38100700002)(71200400001)(6506007)(38070700005)(186003)(9686003)(7696005)(122000001)(54906003)(110136005)(33656002)(83380400001)(8936002)(5660300002)(52536014)(2906002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?feDdz3tHeeOapFg1fEX0GNjv/ngTjgYmiJUyORGd0epC518WRJlpUeGyGKLF?=
 =?us-ascii?Q?ibxEVkLBbCUlGnISoug2YmMFVyUxA8JRW/PFvJu7B1bdFNf7gcSdYTucRtYu?=
 =?us-ascii?Q?TfhikgRTowikaPmfSk+bktOMlCR9nHaS3oavNf/qFTqCBLL2CT8my75ZALu3?=
 =?us-ascii?Q?lodwlG+2NcgvTEJjPycmC7JJr/L/Nfc5j/nXzZX+Aa4C6OupE3I3NGLI/fA/?=
 =?us-ascii?Q?1geWY0VodIb9/ogximy9YpwCbTWZTk/TAC0xKDCVAuplzoTB44FbtLzvzKKR?=
 =?us-ascii?Q?qFtEqTokH6hK/GKWgkL4sJPwfGUEWBi0VLdTQoJopkRtRa9xBuyZOEDizdbl?=
 =?us-ascii?Q?5Y6Mx2KpYMQgl7evhiFta05JRQxafKIfPkwDmrmB849Yso3OiQMtXoaVjZHF?=
 =?us-ascii?Q?MmVyhVLHE5DebHTKqFJ6xi8+wwIr0IVfQ91mDzBcGt8KxuEu6qsWaSkV1txA?=
 =?us-ascii?Q?KroCA3s+HT3NlTLDDHOBLmqz7vyK6r41LIs3blFcnsjDZWg1QZJxyOVs3nnx?=
 =?us-ascii?Q?5EtgOLEyLqctfsmuBI7z3hF6SMaQJPQPDeZW8WH6vnx+HlVjONdVMqcpnyWd?=
 =?us-ascii?Q?mBu9iLypwYNe+BuIOa7kfoPyrSk9/+V9uoVTOu4Ta0QUME1LiTKrPywUkVFk?=
 =?us-ascii?Q?CiBtOb4P2ULMpSqr1A84a9eLXNy2dhRswUNLZwWw6e1brd/5Y/LnjQp2aTsz?=
 =?us-ascii?Q?hqO2p2T+J3OjY8wWNn1XKCUxLgxbZ0TREyKAg1FNnwbAjPBfvzPFlonH1SY+?=
 =?us-ascii?Q?rRaveyweRJkJcX/WpfxdtEAuig1CEyV/hytkdVh25bQosrerjCx59qoyAZBO?=
 =?us-ascii?Q?NNQ9mX+YLS5uS4PtjSJlmBSeioft+TnImtVpK3DSs+9Yp2n0OdB+66Xlnqfg?=
 =?us-ascii?Q?t7haNfN1vjmKA3kmqpPOUlM+k4HBxtce/I5Jk03mQb2/HVG6qYCl+u/BqzJY?=
 =?us-ascii?Q?VTmB4EZQlCL+K2dRdJT5qI+tET3KIGMnZuwx1Ga6vipmpUY1bC2gGwR/PW6+?=
 =?us-ascii?Q?qsih2Y1jr0en1jCPUkglYoE4WChGlzJQulVs6+TJct9c+zY6WvguoUxZr1Nb?=
 =?us-ascii?Q?fmjwKCtHnmaTbV5YXlwiVrwwe/zcjBul7m6gW/aWtLXHgeuHvCKGzEQyXg53?=
 =?us-ascii?Q?Xl6jof51Yc5QSQgCov1AmWO5ksVt8f2L77YiI0wI2CTp7MUq0sXUaeg/fR+l?=
 =?us-ascii?Q?A5qy0DFee0L3p8z7WsTNeiQxFNjtFCVlqnkPj4Qk26GIGefwCQ0CQrpHLXt1?=
 =?us-ascii?Q?5AKDQttN0iBx4FVnM0Ndzk4N1kZxiioQXgL9LCN4dmNbRv9/5WQPOBr/Y6MV?=
 =?us-ascii?Q?rJKBAPcNjMc9vUlnKwUzLvJlBBIjSgFGB9fQ3fWJpme2LkIsrjHMv7UGJVRt?=
 =?us-ascii?Q?4Po9lmiGDKidmx3TP6KGx35JqIaqOulufht+hoToPMNugOWoB2yDBwBPtDyV?=
 =?us-ascii?Q?DC10nTpcayjJaf74BLszCTj0O7fxwVKILO59JBZSaKI+dkyUE77vCJi+1gXp?=
 =?us-ascii?Q?0WvljB7XNPs1CxWqAN4O9n5b4gAuXLOjQiDU9FNyP7oCfRdNTD+GoA0eH9OZ?=
 =?us-ascii?Q?Tny3D2wEbPE5jKKgjopRkYK5AcdKfHfOUgDqV2qxbuynCBdEXVmlfJP3y2KL?=
 =?us-ascii?Q?TSGXj3iya6p69/+4EKq+e9V44QAzbgF++GDcFvE2Z/n0Y5hB1cX2E0utX3oq?=
 =?us-ascii?Q?p9x5rDAtd76mxbM+wwraL03ZH+9QJDR1zWtnuhbWnbAzWaQXoRIJRJspyhY2?=
 =?us-ascii?Q?6gdYvCQEWA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb0723c-ea1a-487f-6bb8-08da2b183a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2022 02:13:48.4903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZ6w1+DGlybAPGDNUbQKKlD3ZxBhtQA0BXnF/e27S3qXPJihSLOEheKU0AuejvzAWdMXhTfjFzjrg7E6dY5fWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1607
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Saturday, April 30, 2022 01:36
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH 4/6] drm/amdgpu: add FGCG support

From: Evan Quan <evan.quan@amd.com>

Add the CG flag for Fine Grained Clock Gating.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h
index 9086df53660c..9ae4060a9d0f 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -148,6 +148,7 @@ enum amd_powergating_state {
 #define AMD_CG_SUPPORT_ATHUB_MGCG              (1ULL << 29)
 #define AMD_CG_SUPPORT_JPEG_MGCG               (1ULL << 30)
 #define AMD_CG_SUPPORT_GFX_FGCG                        (1ULL << 31)
+#define AMD_CG_SUPPORT_REPEATER_FGCG           (1ULL << 32)
 /* PG flags */
 #define AMD_PG_SUPPORT_GFX_PG                  (1 << 0)
 #define AMD_PG_SUPPORT_GFX_SMG                 (1 << 1)
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 05f1ac355ba8..e92d07f88048 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -66,6 +66,7 @@ static const struct cg_flag_name clocks[] =3D {
        {AMD_CG_SUPPORT_HDP_SD, "Host Data Path Shutdown"},
        {AMD_CG_SUPPORT_IH_CG, "Interrupt Handler Clock Gating"},
        {AMD_CG_SUPPORT_JPEG_MGCG, "JPEG Medium Grain Clock Gating"},
+       {AMD_CG_SUPPORT_REPEATER_FGCG, "Repeater Fine Grain Clock Gating"},

        {AMD_CG_SUPPORT_ATHUB_MGCG, "Address Translation Hub Medium Grain C=
lock Gating"},
        {AMD_CG_SUPPORT_ATHUB_LS, "Address Translation Hub Light Sleep"},
--
2.35.1

