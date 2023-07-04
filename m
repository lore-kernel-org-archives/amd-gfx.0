Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F56EB64DA
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jul 2023 07:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3183A10E2A5;
	Tue,  4 Jul 2023 07:51:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 651EC10E2A5
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jul 2023 07:51:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0lJ8Kk0ts5AR+YLxxvZPH1UJzWRpawHOI30+dIe+6HHiOgMinTXCY7db15Ovyi4uUuYXJUqwKGwsQChda2SyejO1ruqfb5ZjDXyrxu67JxDh1FMxY/z5zUTrUgzdO+nMJ62hJe3LxR+CGrktlTa2IhLzUjf4o++5GXP2yBOQ/Lb/K00sA2Wi/sAWh1xCMSe/4DeUopkkBWfGvHVSIJ9Ku7T6/6+7ORei59tNPSmc4fd180bydwQZdPMg8MoIs+cA/zbyxr0sKuTEZmi2GZdh4xkOBpM+gvAQpyJjuWr/hdJOEUOktu4rsVDG8eNHVNIgBSSBtJzHWLr+8Ls5rLYDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfli8Kv6ij9UQfSBw3Fc/DGb8BqtdVEFyyujMBj45iU=;
 b=mRqurSnrJhSRzonx0n1rLCedQdmmDDQ/YNd8UfTUXcTC1l48SQ2JY6VdJpJ3bHZ6GerIVKrdH04pDmBRJ6dRne8v9+YUtZSKVq9x6nzk0CJ6LQRvmQerZeYWusx+vOQKf5d16YL030lV4PayE3iIP0TStjwkW4R66U2+lk/xj7VQZpKR5lS6oY4uV1EIiAn+rofiuFUNUC4WVJDYrGNgxLSaHhmFhtU3qWbth3ABZNjMtghios3y3keMkLjoRgb0nnED0x0bBp7FUUd17tERks77dGkCnoMJFj2RSkWNjgLAk2vyftUZHcmb+6GEcWIiX1efWrTtY25yJBsCHhkggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfli8Kv6ij9UQfSBw3Fc/DGb8BqtdVEFyyujMBj45iU=;
 b=KMI7mBwiFZu1ohlNtsYKYaE5Ep9ZcseaKYsjWuzJ6cKEJ6RS7n5OgTXn93EbZBnAiU/PmpWrl8dJSHZDAlnmPqDdX5YJPpcuYxm2ts/9l8dkCVomlggSONMhw6aWdhwWPBqQ4UykslCuCCauLbH/m0sb0LQ54CpiM072h7gpSDg=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 07:51:49 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::38f2:d04e:61b8:5720]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::38f2:d04e:61b8:5720%3]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 07:51:49 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Change golden settings for GFX v9.4.3
Thread-Topic: [PATCH] drm/amdgpu: Change golden settings for GFX v9.4.3
Thread-Index: AQHZriku3wIpL8ND5kWKkaCbYfxqra+pPF0w
Date: Tue, 4 Jul 2023 07:51:49 +0000
Message-ID: <DS7PR12MB6071E73F6F8B40FA2BF69AD98E2EA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20230704033920.2732815-1-lijo.lazar@amd.com>
In-Reply-To: <20230704033920.2732815-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=df0e5917-8834-4331-b991-4f7bc49dd32f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-04T07:51:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|PH8PR12MB7279:EE_
x-ms-office365-filtering-correlation-id: cc15b484-e74c-4469-8f7a-08db7c6385e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: exskUADoCH+67bgPSuLhYwzdOGMrA1EqNYOuDMgz88t7jvsiFkU1ZGdEYlDquzk4iry25eA1K6HfcHYP69ni1Aqb6LnFtTDV7fEVBq7Jx6dIOsXxNKTzAt+ILhNNqPb+XIF4BrX12tur2W85ciuvBOnwpND5yrwE6/wLkY/M9GtTlFuYlIts9HX5BLGfdO3W420PAR460zr+QNA0s+xDjWevsCBWOQ4i1o7zDWBQso8gp9RQb0VG903zlXMKg8iuubr5TDJUMM0cD1IdSUraDI1v2/i+BMLmTDotxt5x8TlySywfTw+TIq2UiRpKp8fDzwyQumoiz4SZXmOe96PKCK6/vkcV/95/DEugxX29xNffWpT5vCmhq9Dg9OA5Q8nW923bFFG1atrRSdpn2Kg2AmW6Qt3pC9dQ9XfS9F8vusDDyR9qsRuoRlzSTjboiul7lcB6fBqXvMDD+NfhymV9heGiUXQfgMsWKH64UsBwLd8j/drSKK1vJMQLMEueqUVZzfv3hnsfiX1KPxBnVrjhfVb391gVEQ0SHrzRIs6fVtqnJDy1SRJinYrrqM5wvcCz4740R6AdznFcNrvVThVUgxAkTFdltWCUnydI05RrngCgC1xIcvBFaBD4SLIh1KTk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(76116006)(66446008)(4326008)(66556008)(66946007)(316002)(2906002)(478600001)(66476007)(64756008)(33656002)(8936002)(8676002)(52536014)(5660300002)(86362001)(41300700001)(55016003)(9686003)(110136005)(38070700005)(54906003)(38100700002)(7696005)(6506007)(53546011)(186003)(71200400001)(122000001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pXqu14modUF3lv/hzTaLk35qaA2QtFfg8CvqW8U368B0wAA3hjMTlzbANSWb?=
 =?us-ascii?Q?3FWwk42CRtKxmg1XkvqJPeLyQH12prev4+6gnk+joFh3Hq/NoGT6UwH39QEK?=
 =?us-ascii?Q?qTzgdCK7zTijiEtkayivX1LEL4hoNseaDVF6pfqE+n50qpmXLcicw8wxOXYD?=
 =?us-ascii?Q?Y5HweoIUM03WBAmzgnSnqPBPBFJ2AofmG6OpogIe9WjB8V2k5euDoTPHjH0i?=
 =?us-ascii?Q?gOMpSx0yEas3mxhC0frKG6RpdxehQa50K4qD689xRPbg1baNTi5A5+wrrwwD?=
 =?us-ascii?Q?T682kZ7Rqo63DlBMPNxpAP6bgKDxoHuwANNrmrFK3LFEm2r/UqVr3QIsep5+?=
 =?us-ascii?Q?4pVFamoNB7OXQARRAUuN0w/rWmXHOyjw4nqAhVXKFSgP/TmFbsVEOYE5ngw3?=
 =?us-ascii?Q?0O9M2xe36Aj/32jBiVUgwg1ws28et6o3yRp+f9l9wDeI0vyDdpDphxgaTgse?=
 =?us-ascii?Q?1r3qk0Xo4h99+ywLVsEa1h8XoMC6Ruoqf9BCKRwrjxl86G8kce6QTf7lDmsc?=
 =?us-ascii?Q?ybKNxTMiyk5CcQ7Ro3cUu3V4n1MYot2Q+4uTw7i75SfUsJBu/A2icWmWjFCc?=
 =?us-ascii?Q?EKDm2sankMptVG1/pB/1HMrQmvVBAOpuAwjX3DhZ3IN0Vy7JTwjX5U+fR5Z5?=
 =?us-ascii?Q?d+bYYnP8eeXz1GnZDCP/u5Nz2rN4o2UYMaSSGj+ewxWYcUFBY4fl9iN+kTzV?=
 =?us-ascii?Q?qW2HUqZ0ws3usMKlz1xGfjXNjdemeJ1j4o0VqsH0HrSgqAk/yt4p90l6pNdf?=
 =?us-ascii?Q?Q2L3XW8GxcsZcCgmIN+0LSm9iExr3dKJiUcbLDJugQIOF5NtSunw8TrKbyKP?=
 =?us-ascii?Q?iEN2oiUPpDH3wSm1uCXwlaI9vzLK7BsGDLgvcvQ2zDhfXIcyAsO3rW3A46ko?=
 =?us-ascii?Q?cgo7wv0ODrpwqUJBs7TwMRFdmO+7H6OmY6eT4ldAMnKLgitj2O5hLrMUs85J?=
 =?us-ascii?Q?iNzdTtjdbPEZW7h7mZp7r2xsK1DuuOef0M5zUvbns3lwsC5MzuqzVjjbDYmn?=
 =?us-ascii?Q?zoBlKp7lns5Lgfr4G7EgLDV2kab6IHXh52RonexuyPz5V1lFLhQ7ljFZLjY/?=
 =?us-ascii?Q?bCLJ2HuagOq/0P6SbIIKIW8g27pUkLjYB8hCH84Bb1jQ5LHPbAnFy4J/VSP1?=
 =?us-ascii?Q?bDN5c1tzrbMioqS5J8tYEAxkSh1X3NMr9YPcve0afJcsVmYwzjtR5j04QfQx?=
 =?us-ascii?Q?KWMUvb3Rj9osMGnxrfE+zI/JUDkb0sAMINGWhFftU88b5IO6WYAQ/oTYEtRf?=
 =?us-ascii?Q?0XyVq5KzfTQlvgaiY2EMjvABaWB502EbD1V1BeB7eUpmrL9vd3U7b3ASNjZb?=
 =?us-ascii?Q?iehDKtXNCzjY82q7Ztxc6wzPh/BkeVRB1DXGvtKNQuehSqd3Qiif5yZGoLvd?=
 =?us-ascii?Q?Pc205lfD51eQ8coNijngS6G9fC/VfGnC1PEmFx8IoF1pq/6uwGODOHy5gsqu?=
 =?us-ascii?Q?Hq0rc2nZXtkYI4nx7QgqNv672z4DgodtqdfnwASjKbWc/bB5rn+LEz048YuI?=
 =?us-ascii?Q?t0Ys3otsxrOO4y0wqrTr45V5Zwdj8v4MpYScGEs5p/x2eaUBcjurydimwruE?=
 =?us-ascii?Q?njvuT4+QUjC2XMo4kJHvhgITWu8wVacY6qkADdJlBBeOVteSsAPnc1QjfAL8?=
 =?us-ascii?Q?km0EyFSOdcXAfKrxEZSgsm0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc15b484-e74c-4469-8f7a-08db7c6385e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 07:51:49.2830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/d76IiFuZcxl56Om5/Z/9gws0m0RrZYULOZm+w3tTxPN/N9oPrrwCFfi4QoMbAFMXNSTmpWz5WtQSwacqMtng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Gadre, Mangesh" <Mangesh.Gadre@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, July 4, 2023 9:09 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>; =
Gadre, Mangesh <Mangesh.Gadre@amd.com>
Subject: [PATCH] drm/amdgpu: Change golden settings for GFX v9.4.3

Change the settings applicable for A0. GRBM_MCM_ADDR setting will be applie=
d by firmware.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index c1e3625ad136..51532d0dd7a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -195,14 +195,11 @@ static void gfx_v9_4_3_init_golden_registers(struct a=
mdgpu_device *adev)
        num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
        for (i =3D 0; i < num_xcc; i++) {
                dev_inst =3D GET_INST(GC, i);
-               if (dev_inst >=3D 2)
-                       WREG32_SOC15(GC, dev_inst, regGRBM_MCM_ADDR, 0x4);

+               WREG32_SOC15(GC, dev_inst, regGB_ADDR_CONFIG,
+                            GOLDEN_GB_ADDR_CONFIG);
                /* Golden settings applied by driver for ASIC with rev_id 0=
 */
                if (adev->rev_id =3D=3D 0) {
-                       WREG32_SOC15(GC, dev_inst, regGB_ADDR_CONFIG,
-                                    GOLDEN_GB_ADDR_CONFIG);
-
                        WREG32_FIELD15_PREREG(GC, dev_inst, TCP_UTCL1_CNTL1=
,
                                              REDUCE_FIFO_DEPTH_BY_2, 2);
                }
--
2.25.1

