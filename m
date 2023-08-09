Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B10EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 08:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5074710E400;
	Wed,  9 Aug 2023 08:40:09 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDD4710E400
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 08:40:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atgTHx8wZV1TiVTLBFBR+YJF4RDKPfE1SVpgJa4t/1ODcdTDcrb8C1DN8DNzTXzWyjpZyR5mNlpUiGm45DXZOkbJCgb5giVhFVCbADKfj5jRfN+L3zXf8/lawGe+BQI5ozUNwdphA5Xd8hiDkW/dCFngdEHLiJomXJwl23TNqkUw070OgwTP7Md21YMFQ48Tuwqfa+U4dmRTCvsr/o4QVRdPih+C3SYXNvVCqHWsAxAy70yrQLetUHf2NSKRf6ZTDzVxOOm2KQqBOejlB7G7mFmqRFUHa/8R/+IgV7eONEeCXZRpzFmNf/UfMmeYahVZKm13zn7U3Mt6IArZ2keIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm70+0p0kb6kOUvpS8HZ9hMMOs+eQTn5xpOW4Q9a9So=;
 b=eTDYfKuSycmMTaE82PBw1U3vYsNSR0R3GuN2d5hSTBKIXAJNfFkNB/IfSQ9r7vC/PUfMJfqrRcUMlDOXGeEv0Jb+hPdCZGC4U3AAS+q4qpscx6To8FX2tzqv8zxHlyVlkUVy3pHMWcvVIywvsRDaV4R60gd3qKVFeZRO8S8v3+rV+qrZTspqO6SkRDcKPg/2xQg/VLZTEXeCQaWeN1uSTRHfQdKVijMrxXdxFrnhSVCPt46Ff9rUdRxfs0RL8oIPj8FQVY56OctS1F7R3sz2h69619l684NmUS+1wDD9RQbMIWjn+pgPfIkFIeanebRKoiaHtaru0eU6I4ZF/OOXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm70+0p0kb6kOUvpS8HZ9hMMOs+eQTn5xpOW4Q9a9So=;
 b=i8LtDnK05qJpdQkFYeRCctGUH3VfMZMnkrUHth4iA6fnTK/mlDIXWx7aSxhXKUm1bJmg98q+L+Gz4xCzyBXdGpZ80WNKvGe3yXgsGTANrmER+CbnYHUxr5zTwt8HgSLRL7/7CB58a5v9H3229vvlXz+Uvf7XJDjkKJ1x9ZEnhWE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 08:40:05 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 08:40:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add pci usage to nbio v7.9
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add pci usage to nbio v7.9
Thread-Index: AQHZypvp+Xm9SOo4q0W5vYPP9WzBVK/hpNwA
Date: Wed, 9 Aug 2023 08:40:04 +0000
Message-ID: <BN9PR12MB5257F76D02901011EB9CFF94FC12A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230809083023.427025-1-asad.kamal@amd.com>
 <20230809083023.427025-2-asad.kamal@amd.com>
In-Reply-To: <20230809083023.427025-2-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=26f5e648-63f0-4c52-b40a-47f3b527f1b6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-09T08:39:41Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ1PR12MB6340:EE_
x-ms-office365-filtering-correlation-id: 70a4df05-d340-4b7c-0cbf-08db98b43aa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ojikKlCSHIk8GKyl7/vnIRnjkJmAmWGyA7muZ4RBuuZZCEG/H8l6/XLT1/WZ6DDqYhXv45pdnqkTE2c5HGV9UwUWuDNuRObxxw/cfZIwiASK4jgE3sOGbG+mrAWWejKfDXn9mqI1RG5C0XSRvO0ktdKzeYuzg+0tgezOj9T46BiV2lG1mrRt9Z+T5cpQOCMCoqNvCcEs+PdEZ+ZejJh9TmyKpSmvz5ZGllno7OClv1I8g/kU1OXY05KMSgF3j4+Mt40LpCsVuibKU+7veTx9gUZODUK9P2C5H6Bf7QaLzD9adTYj7n7GIo/U5IgNiyTEWMWdTJV5cQGAF5P3DigkxHgJID6/jAfPZ+LUJp0VE0pgYQzaD8lhfwBuwL79qFR7lTXYqfgwLsioHnrWI4gO4tUz6b3A4Bop1Z65bOB4MfxSS3Z/p3nel2ylXbYTOKvf7GGielqhePqZoXHYnVx1vJLkWsPLHHYVMa3Y1pX4bpqSUvMVvtaiOmrphyR9W62pQULN8kqIl6X8OlEAnlaxTofEp1zvNj1DE0hS8Xlj9qADYr11UVtfY0CxpZjID79pwnKR5B7HNftNT3fIy1e3wvQiBFN12Iu8pA9EYRrhak7uArPQYlViBlh4aBrefMVN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(186006)(1800799006)(451199021)(122000001)(53546011)(38100700002)(6506007)(26005)(38070700005)(83380400001)(2906002)(52536014)(5660300002)(54906003)(478600001)(33656002)(86362001)(110136005)(9686003)(71200400001)(41300700001)(55016003)(316002)(7696005)(8936002)(8676002)(64756008)(4326008)(66556008)(66946007)(66476007)(76116006)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2G4+RTEB1qIU9KtBfMcRCn/Hc7u9meFVQlCvu2A2OhFDeseQOHIJwt/iYF96?=
 =?us-ascii?Q?mdOU6/IMUEoAmlXDHHxymqh9TbAtVJdbY6jo2pJI9SvVCLeEUsIB2XBUYjIE?=
 =?us-ascii?Q?DUsQvJqFDhOf2YfFVAWw2bhrupoaAeD3uQ3AJvXaJcEACOlJCBFG+RFT3obk?=
 =?us-ascii?Q?HO2nJkF53yY/KNW2TJMCdHLFRp0o47VD64sTWPrvAE31337zvKo/EpY4fP1/?=
 =?us-ascii?Q?wJtcHC6oDmJvP7qAvkhfrCZgSc8ihvNqEUwYZyChxWPxsFcuCyRVQ/uP8LRD?=
 =?us-ascii?Q?fvncVI4KGKYa1rwaqRgahHln4eo2v9EncvynOshFAWlPCXHrDEpPOcWFHly8?=
 =?us-ascii?Q?MuusAvS258y8HPSilK8xx0XfKAzNO3aIrJmC+jdCZ2P/QZ64ZEQ8dvsfgpQf?=
 =?us-ascii?Q?dwNiIIZIEhV1EAgi88pMtNoV7TJCso0HVCeg2+BlV25LUz5JJ46WfQWQdpp9?=
 =?us-ascii?Q?msVwb9cO+l25jfdrZ5t3+nqcwGGryu07Kj2Q3PzODmdimbfQRd0XCJCJkN9J?=
 =?us-ascii?Q?XhHt8SZGS8MFsbvQfQVCIKaQFj+GV//dmIjZSjuj0Ho2SsimIEvI/fRUHslU?=
 =?us-ascii?Q?FR1M9vkBL1AtvP2HcapWxCq4kpZUVcf/AfBEyI+arx0pD+0oBgQhzQbfTNeb?=
 =?us-ascii?Q?CtqbRzTR2gcsR0Ug3TM2bMDj3cbWD3Gm9NA/ZncMbaIUN3M5JVTooquNukAp?=
 =?us-ascii?Q?l9z9Sras6GnmMcUgY/gezjk2GG+ljgzZ03S+tec0Jx3UXp33XSHKkL+wfysB?=
 =?us-ascii?Q?kLcGOCELxbRitqLhPheYbbVGPZPX85xwTqd4eJwiIFNUiM1lycAxCbj4PGpo?=
 =?us-ascii?Q?vNJ+aHchbIJUMlkgXkm5WNWVWkr6nwEy/IdzgW4FKt5HtfOpAsS63/dMQh4e?=
 =?us-ascii?Q?F9NquRgarktOCugpDbpTxNb/TngiRkgUdcx6n+TDBtIB9qATWYjiPskhcjaT?=
 =?us-ascii?Q?lCwaHgR+l4oDEZchxBoXdatzcTNEUWT5jnUgpHPMsr/Pp4sFpAz1TlRTvQJI?=
 =?us-ascii?Q?cTrI+9yFNvrWbgUCgJxLgctQnnPOlEhU2D/0aXLtMKTJMNxNAoIYIl9sy4n8?=
 =?us-ascii?Q?3DgR8nsHEa6RiDLGqW+qP9LjQb1q64Se989+lvkbv3T4C168YQURWlAQFX3u?=
 =?us-ascii?Q?WaXlxO6n5MuMGa90BjGRASeG2L1WU/kTmVbtlX8Vie6jTM6J0YvuYFGqgaTc?=
 =?us-ascii?Q?hsX/XExhF5Pj6Xx5Qeo9sgDm+N7+5LQ922UJhI6p4pjyFi/bTmb2RyaddmdZ?=
 =?us-ascii?Q?DCcR+AFJAN+mmQZgQAzKkLuZ/iMVTgDoJW4xQy4zB70gaVB2HjAMQafeyJYM?=
 =?us-ascii?Q?zGLHRt/QsmkqQSOv2dQhmISCaYAVFyNV5P1OaG31+UehAxRzDhwVZif9MzcC?=
 =?us-ascii?Q?ooMBDs8lb0ARFpocMjZJ2EIzNNwxbLX3SkKAuf8nkyxZbCE1FrE2FLeLydQc?=
 =?us-ascii?Q?E3ZhN9a/RZdrgFwnefdR5+xkgETQlOOAr/KzKZu6c03H1fHrXTPz8wXAItQu?=
 =?us-ascii?Q?fYtR+syPUjklTwtpq2q2BcH1SuxYWhO92heI9yPL6p/PoWU5d1GqzUQjMJ8g?=
 =?us-ascii?Q?OKMn6N3tgzLFQd9bsTHKCEnw8aDhMZ+BHWh9bTK3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a4df05-d340-4b7c-0cbf-08db98b43aa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 08:40:04.7753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WcDwWT75ogF5dHh/zaZfeZsN21afHRDzdD4PWuxbIReLx844hRcMM0UZtmHk8MDEo1/ch9HHsCG/mg2PbPCxzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Wednesday, August 9, 2023 16:30
To: amd-gfx@lists.freedesktop.org
Cc: Kamal, Asad <Asad.Kamal@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add pci usage to nbio v7.9

Add implementation to get pcie usage for nbio v7.9.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        | 63 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  2 +-
 .../asic_reg/nbio/nbio_7_9_0_sh_mask.h        |  8 +++
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_9.c
index cd1a02d30420..77c9625dfb8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -32,6 +32,15 @@

 #define NPS_MODE_MASK 0x000000FFL

+#define smnPCIE_PERF_CNTL_TXCLK3               0x1A38021c
+#define smnPCIE_PERF_CNTL_TXCLK7               0x1A380888
+#define smnPCIE_PERF_COUNT_CNTL                        0x1A380200
+#define smnPCIE_PERF_COUNT0_TXCLK3             0x1A380220
+#define smnPCIE_PERF_COUNT0_TXCLK7             0x1A38088C
+#define smnPCIE_PERF_COUNT0_UPVAL_TXCLK3       0x1A3808F8
+#define smnPCIE_PERF_COUNT0_UPVAL_TXCLK7       0x1A380918
+
+
 static void nbio_v7_9_remap_hdp_registers(struct amdgpu_device *adev)  {
        WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -427,6 +436,59 @@ static void nbio_v7_9_init_registers(struct amdgpu_dev=
ice *adev)
        }
 }

+static void nbio_v7_9_get_pcie_usage(struct amdgpu_device *adev, uint64_t =
*count0,
+                                    uint64_t *count1)
+{
+       uint32_t perfctrrx =3D 0;
+       uint32_t perfctrtx =3D 0;
+
+       /* This reports 0 on APUs, so return to avoid writing/reading regis=
ters
+        * that may or may not be different from their GPU counterparts
+        */
+       if (adev->flags & AMD_IS_APU)
+               return;
+
+       /* Use TXCLK3 counter group for rx event */
+       /* Use TXCLK7 counter group for tx event */
+       /* Set the 2 events that we wish to watch, defined above */
+       /* 40 is event# for received msgs */
+       /* 2 is event# of posted requests sent */
+       perfctrrx =3D REG_SET_FIELD(perfctrrx, PCIE_PERF_CNTL_TXCLK3, EVENT=
0_SEL, 40);
+       perfctrtx =3D REG_SET_FIELD(perfctrtx, PCIE_PERF_CNTL_TXCLK7,
+EVENT0_SEL, 2);
+
+       /* Write to enable desired perf counters */
+       WREG32_PCIE(smnPCIE_PERF_CNTL_TXCLK3, perfctrrx);
+       WREG32_PCIE(smnPCIE_PERF_CNTL_TXCLK7, perfctrtx);
+
+       /* Zero out and enable SHADOW_WR
+        * Write 0x6:
+        * Bit 1 =3D Global Shadow wr(1)
+        * Bit 2 =3D Global counter reset enable(1)
+        */
+       WREG32_PCIE(smnPCIE_PERF_COUNT_CNTL, 0x00000006);
+
+       /* Enable Gloabl Counter
+        * Write 0x1:
+        * Bit 0 =3D Global Counter Enable(1)
+        */
+       WREG32_PCIE(smnPCIE_PERF_COUNT_CNTL, 0x00000001);
+
+       msleep(1000);
+
+       /* Disable Global Counter, Reset and enable SHADOW_WR
+        * Write 0x6:
+        * Bit 1 =3D Global Shadow wr(1)
+        * Bit 2 =3D Global counter reset enable(1)
+        */
+       WREG32_PCIE(smnPCIE_PERF_COUNT_CNTL, 0x00000006);
+
+       /* Get the upper and lower count  */
+       *count0 =3D RREG32_PCIE(smnPCIE_PERF_COUNT0_TXCLK3) |
+                 ((uint64_t)RREG32_PCIE(smnPCIE_PERF_COUNT0_UPVAL_TXCLK3) =
<< 32);
+       *count1 =3D RREG32_PCIE(smnPCIE_PERF_COUNT0_TXCLK7) |
+                 ((uint64_t)RREG32_PCIE(smnPCIE_PERF_COUNT0_UPVAL_TXCLK7) =
<< 32); }
+
 const struct amdgpu_nbio_funcs nbio_v7_9_funcs =3D {
        .get_hdp_flush_req_offset =3D nbio_v7_9_get_hdp_flush_req_offset,
        .get_hdp_flush_done_offset =3D nbio_v7_9_get_hdp_flush_done_offset,
@@ -450,4 +512,5 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs =3D {
        .get_compute_partition_mode =3D nbio_v7_9_get_compute_partition_mod=
e,
        .get_memory_partition_mode =3D nbio_v7_9_get_memory_partition_mode,
        .init_registers =3D nbio_v7_9_init_registers,
+       .get_pcie_usage =3D nbio_v7_9_get_pcie_usage,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index afcaeadda4c7..4b8dce091bcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -893,7 +893,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asi=
c_funcs =3D
        .get_config_memsize =3D &soc15_get_config_memsize,
        .need_full_reset =3D &soc15_need_full_reset,
        .init_doorbell_index =3D &aqua_vanjaram_doorbell_index_init,
-       .get_pcie_usage =3D &vega20_get_pcie_usage,
+       .get_pcie_usage =3D &amdgpu_nbio_get_pcie_usage,
        .need_reset_on_init =3D &soc15_need_reset_on_init,
        .get_pcie_replay_count =3D &soc15_get_pcie_replay_count,
        .supports_baco =3D &soc15_supports_baco, diff --git a/drivers/gpu/d=
rm/amd/include/asic_reg/nbio/nbio_7_9_0_sh_mask.h b/drivers/gpu/drm/amd/inc=
lude/asic_reg/nbio/nbio_7_9_0_sh_mask.h
index a22481e7bcdb..e0c28c29ddb0 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_sh_mask.h
@@ -38896,5 +38896,13 @@
 #define RCC_DEV0_EPF0_VF7_GFXMSIX_PBA__MSIX_PENDING_BITS_0_MASK           =
                                    0x00000001L
 #define RCC_DEV0_EPF0_VF7_GFXMSIX_PBA__MSIX_PENDING_BITS_1_MASK           =
                                    0x00000002L

+//PCIE_PERF_CNTL_TXCLK3
+#define PCIE_PERF_CNTL_TXCLK3__EVENT0_SEL__SHIFT                          =
                                   0x0
+#define PCIE_PERF_CNTL_TXCLK3__EVENT0_SEL_MASK                            =
                                   0x000000FFL
+
+//PCIE_PERF_CNTL_TXCLK7
+#define PCIE_PERF_CNTL_TXCLK7__EVENT0_SEL__SHIFT                          =
                                   0x0
+#define PCIE_PERF_CNTL_TXCLK7__EVENT0_SEL_MASK                            =
                                   0x000000FFL
+

 #endif
--
2.34.1

