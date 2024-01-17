Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3C4C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 11:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8204C10E0B0;
	Wed, 17 Jan 2024 11:40:14 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B11410E0B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 11:40:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3VdoMaNtYfH/CExo/k7dlTxqRkzYkupJkV3Uufko4e1P0U60JmU6jpnLLGUcxwTntyGtEMRguMWpyEFRNR3tMWdDMMjJQeapDXUiG3Xvw+IdTtQzAxTJGaXH7ejL8RBADd57gSMxI+gyqBRLWwCP1OOX8vOSFETB2ncGUVzIVlQ0opdYIBBR74R/KOSYRAc7SyBIdXGTCKNie5wUiJ6s0s8R6/B/uazLTaP1n1P5MKzRjyOw/Dlfn+rKL4zMsMAUsRwh0fFmv4Y3YbiblCbVLrgYOPDuysTjzDK4XZG/Hoqh6lhmMlVrxvBCdDy5PfWbozLVvG7AVhNNGzVH4gN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXisouodqbwnNUqJ7SMHa9R8dWKaB4zCzxMfvyizzzM=;
 b=Ehj4lQmDemEbS3EdLI0Nvh92mC2QPShbz6N/r97sAfoiZC8OPJnr8pwtt2XmZphFkwH/GB3RBktCtnthXEu6FQ4ae0fB5u4fnehtaU35toqJmP0eX51Y6zJ6XVfyNWe8c72vK2t0sm7Oeas98zz1jkQ1LG4xiVmEj4c28ttADblbaDZvfkJ7ykz9Z8mAp/0edQiqK4+WMEJ/f0DCOWaTg+iajs4D5gUWTbaFlNXzyTT/gm0NbVD7fPLBGvruZZzEfHYVDEZUlRF/durypv3s/A1igqFOlWXeurWRXD2waceLXAH00CTJnKiJ/rU1JT/T+bbvQwdD2qDZOL36FpJCAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXisouodqbwnNUqJ7SMHa9R8dWKaB4zCzxMfvyizzzM=;
 b=IRfuc35FAnKSmaOH5QQk3NVZBPHvvrwF0GW50ipSW8bosSSVWVpTmtZFeZrYMgQvLubXxIHYtJT14aKtHgUqD/iB2mofysI0VEHY9dGtkTGf/mtaLckgNO9HVyEVombg3rI1/fKRQUSWiaYNiK70wUwThat9rrIpqIP7fAOB9cg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Wed, 17 Jan
 2024 11:40:06 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 11:40:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13_0_6
Thread-Topic: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and
 smu_v13_0_6
Thread-Index: AQHaSFT4B/Amse4OtUiOCV4I8p53EbDdtOfwgAAt8JA=
Date: Wed, 17 Jan 2024 11:40:06 +0000
Message-ID: <BN9PR12MB525743F76BCCE9CFB6598A66FC722@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
 <BN9PR12MB525769654D72081918DEC822FC722@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525769654D72081918DEC822FC722@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0b419208-df91-42f7-9c5f-36641ae16d59;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-17T08:54:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5133:EE_
x-ms-office365-filtering-correlation-id: bbc3238a-ae33-48fa-1a02-08dc17510d64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uI4/FumkEYhglT82MbHRC/eAq9QxE64v7MMDOuivJg9v9soEh7lrCsYoSeTzOZd/lG1UH7bE3RVs4OUp8y1Na6dtJhYZ4htia1k005XDvni5D6ugwC1Grp1LhOX4b8kn33udILfjdZsCh4L+t8dckvriA/TqJmrP72k0iOPVBz7DavQ+cj+cv45yN5IIK2nnFpWNbXokT0T9LI16joeqpTFZlCTQew4T/uAtBNe1GRO49nrPvujq7UU4GIsOApN4BLP+sm0/yp6bqHRxeXfC8bN5UUxR5GYasNGx42tOwKkewGJXJ33tQLZCq6jnP+VkLcTdLljBWYq6kxAlNdI3iuyglUmY9fkxPUlMh8ZBSqJINw2rMiX4Yqf8p1GZyWjtetq/WsGer7QQUn5vFkK5ybzmYJySpfTAxOl+OGzycIZCA2bVpD85EM5Wt1ssyQkFl/S/kTQBybej1wQoLxjLUxOzt2XFQnTy4OLGD3YmVI/MO/6jBdOb+NFnq1le63/Nj2hjQrGvMn3fxSsfEKlZUbuE8TrM9Zp+EYU/LtSL+/PolLWakslkv4aaywjRsyspmIUeQmJwJip0Ji/pK2jShatSSYGG8OadkJbvY2tkLXsVK0w3RZw358DdoBhGfbbj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(5660300002)(2906002)(9686003)(6506007)(66946007)(76116006)(2940100002)(54906003)(66556008)(64756008)(66446008)(53546011)(7696005)(122000001)(4326008)(8676002)(38100700002)(8936002)(71200400001)(316002)(52536014)(66476007)(110136005)(478600001)(55016003)(38070700009)(33656002)(41300700001)(83380400001)(26005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HcUWLEWXqNxRgdE6C+47dQPBRuf2JEgyclwMNuMZPZutJzVGYNM4dX5Oq5W/?=
 =?us-ascii?Q?0bNtVhFZTq5IUzRnGnVhQWRCKboxIi4K5IukXLiXIPBHWwY7TlJv7ZIihs83?=
 =?us-ascii?Q?Ei6klIPg/nIf+YOy9eBeXneqBrEUaNm06rU5O+l3sWD0p6+LyKs/X9XCpyZx?=
 =?us-ascii?Q?Ka+E8rqYMA8zpr0sF4CcXMh5sPymEXeVu9BqQ1085WaKh1Y7rkGsUNjOHDOL?=
 =?us-ascii?Q?trQSnGZfUtr5YJqaBNjC25tj09xB7loWv68hL39Vr4OWLMCsq/cHRJSED/wC?=
 =?us-ascii?Q?ku9Z5poAGVZQVKyPxiir898mvDZLHMOrCDd7RA3qYT4VUmqkAOWnKOBST1d+?=
 =?us-ascii?Q?oIFFEl1LVZfWRhTm2ZDUUpJNZS1xd8hVXeJuJU8FVe+IfbVADRikLcCYJ3mw?=
 =?us-ascii?Q?HZQt1I4spMx+OGv2s+OGYq4SRlXpii2dDF8h9x36B8CPQL9rE3w4Z9S5UJ4G?=
 =?us-ascii?Q?HDiMV5G43FDBetqzdRKId/6BCtj5ZGl9sOiAnGtUEDXY22s3511gQ8nIGtDX?=
 =?us-ascii?Q?KV2ub/R9iisyn9xpoqSrSLl6brls/NlfWz3empErdZ3Xhl5GEHPQH+g3ezY9?=
 =?us-ascii?Q?qkKmmVxMdJiPSOWsNSDHEEf00Kq9kxiA6k02U0/ixRA4i7Hoy8N8GSziG/st?=
 =?us-ascii?Q?3D67M7lVJapuDGjO40mRjEmrsY0o6arb+MUOLXsCobWv7xZCIx5lJh8nXCyR?=
 =?us-ascii?Q?l2bc7AMOuGqx6aKyTUZmBNEUpJL5RKEDYD3jSlTpOYFOqnJN6yA9LDrY3gla?=
 =?us-ascii?Q?elpaPDjqwFyoZowvMCkqLTwxj2/vBIC2++SABYf9jRMNZtSMMuVe4OiPAu2W?=
 =?us-ascii?Q?bcvj5B96dvK46fU4stX5MFHE0rSI7RqJ8T3k/LwW5qx0TFwSs9FxqiqXjytF?=
 =?us-ascii?Q?+biYKbZcGqG5m7VcGrOyxwb47h/VfdzwKyzIWtWJMfGv2R8U5QLCxIERubic?=
 =?us-ascii?Q?weGLDzH0YCOMs/Cg34htd738CB+tZixZniBQhBO+VdofCgn8RHP7lHJH3YbG?=
 =?us-ascii?Q?yeg8+Y5SxGSG1VnFeEKoGPPwcco3a+9OYjq7U+8IREKnc4/UaRbkMPK51aK4?=
 =?us-ascii?Q?pE+Rlv1subt9lwBu+1SALHT1G7aM5R6WiuRQBYX4IwWJcUvThwlU6SZdtyfE?=
 =?us-ascii?Q?P8iOkq1vFXWoks3i8G4EZyzKJhbB57mtDShcnbi2hUPHl029DWX66OzeSRPc?=
 =?us-ascii?Q?RRaN4gzUfJeQolC1kS8ioZpG0zamLhf+KOyChcKB+CUCKZNomNmt1xEQ6jjU?=
 =?us-ascii?Q?jK6VsMy7kp63O9xaFHLj8XpkQtrrNDpN+iDe3x6d2jYgQgy3V762znWjQKAT?=
 =?us-ascii?Q?KwOoEJ2TXT7OW7u4Y2lx+BXAm1VchSo6IzFN8mOvB1yxquoca7/jO6plLps8?=
 =?us-ascii?Q?m2koFw9xi+hCublZauR4b/1I9guOjOdi+NJJGtOQwLu/mnHBiOMgkqkHaO5w?=
 =?us-ascii?Q?ka5/iDmoEDyMyiNnFgGZO+GY+gqqEPdUCwzgjTMusPl7NyWfGgYKOZeT8wXm?=
 =?us-ascii?Q?6i1K9FFuEGKryU8Znfz0UDo6LB2Jv7tfw+YvHVSaC8t7NcEg5dVq1WkToMKq?=
 =?us-ascii?Q?drhGnADA0WU1TighcJUwOZENlBtx4mhlvlmmHmgD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc3238a-ae33-48fa-1a02-08dc17510d64
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 11:40:06.3684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89vhhTWpsL0LPRCMTvfFEqjAot3b5xsJmjZuhbamQZPIbvpNB2d6NlZ++Xdi3SGo3zLHsW7uMfSRduRdG13uMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please ignore my first comment. It doesn't necessarily associated with sock=
et  id in UMC MCA status log at this stage.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Wednesday, January 17, 2024 19:12
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; W=
ang, Yang(Kevin) <KevinYang.Wang@amd.com>; Li, Candice <Candice.Li@amd.com>
Subject: RE: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13=
_0_6

[AMD Official Use Only - General]

[AMD Official Use Only - General]

+       dev_info(adev->dev,
+               "MCA_UMC_STATUS(0x%llx): Val:%llu, Poison:%llu, Deferred:%l=
lu, PCC:%llu, UC:%llu, TCC:%llu\n",
+               mc_umc_status,

Please also print out socket id for UMC MCA status.

+       dev_info(smu->adev->dev, "MSG %s(%d) query %s MCA count result:%u\n=
",
+               (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ?
+                       "SMU_MSG_QueryValidMcaCeCount" : "SMU_MSG_QueryVali=
dMcaCount",
+               msg,
+               (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ? "CE" : "UE",
+               *count);
+

This seems redundant or was added for debugging purpose. We can drop this p=
rint since there is log to cover failures.

Regards,
Hawking


-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Tuesday, January 16, 2024 16:21
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13_0_6

Add log info for umc_v12_0 and smu_v13_0_6.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c              | 11 +++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c             |  6 +++++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 13 +++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 6423dca5b777..fa2168f1d3bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -91,6 +91,17 @@ static void umc_v12_0_reset_error_count(struct amdgpu_de=
vice *adev)

 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_u=
mc_status)  {
+       dev_info(adev->dev,
+               "MCA_UMC_STATUS(0x%llx): Val:%llu, Poison:%llu, Deferred:%l=
lu, PCC:%llu, UC:%llu, TCC:%llu\n",
+               mc_umc_status,
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, V=
al),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, P=
oison),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, D=
eferred),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, P=
CC),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, U=
C),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, T=
CC)
+       );
+
        return (amdgpu_ras_is_poison_mode_supported(adev) &&
                (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
Val) =3D=3D 1) &&
                (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
Deferred) =3D=3D 1)); diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c =
b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 11923964ce9a..51bb98db5d7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1297,8 +1297,10 @@ void kfd_signal_poison_consumed_event(struct kfd_nod=
e *dev, u32 pasid)
        uint32_t id =3D KFD_FIRST_NONSIGNAL_EVENT_ID;
        int user_gpu_id;

-       if (!p)
+       if (!p) {
+               dev_warn(dev->adev->dev, "Not find process with pasid:%d\n"=
, pasid);
                return; /* Presumably process exited. */
+       }

        user_gpu_id =3D kfd_process_get_user_gpu_id(p, dev->id);
        if (unlikely(user_gpu_id =3D=3D -EINVAL)) { @@ -1334,6 +1336,8 @@ v=
oid kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
                }
        }

+       dev_warn(dev->adev->dev, "Send SIGBUS to process %s(pasid:%d)\n",
+               p->lead_thread->comm, pasid);
        rcu_read_unlock();

        /* user application will handle SIGBUS signal */ diff --git a/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/sw=
smu/smu13/smu_v13_0_6_ppt.c
index 952a983da49a..cee8ee5afcb6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2406,10 +2406,23 @@ static int smu_v13_0_6_get_valid_mca_count(struct s=
mu_context *smu, enum amdgpu_

        ret =3D smu_cmn_send_smc_msg(smu, msg, count);
        if (ret) {
+               dev_err(smu->adev->dev, "%s(%d) failed to query %s MCA coun=
t, ret:%d\n",
+                       (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ?
+                               "SMU_MSG_QueryValidMcaCeCount" : "SMU_MSG_Q=
ueryValidMcaCount",
+                       msg,
+                       (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ? "CE" : =
"UE",
+                       ret);
                *count =3D 0;
                return ret;
        }

+       dev_info(smu->adev->dev, "MSG %s(%d) query %s MCA count result:%u\n=
",
+               (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ?
+                       "SMU_MSG_QueryValidMcaCeCount" : "SMU_MSG_QueryVali=
dMcaCount",
+               msg,
+               (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ? "CE" : "UE",
+               *count);
+
        return 0;
 }

--
2.34.1

