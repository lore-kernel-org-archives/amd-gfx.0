Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570F3F36C2A
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 07:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A70DC10E10E;
	Mon, 20 Apr 2026 07:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uWfqbs8K";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CE4310E10E
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 07:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YG2/YB9/JCaVHGTadTGnqQde9KXBOtwqKKz3SH95C0QVL+fQbUfsZlQ8/xKx8bKZGH8wY4zTWAE0+5vtnvWem0lEYblJO43ta+XdVa5oh2HDE0fd6QOa6UXmmuJtPvXeFIaK2KP+eIzRf5bmyHCgl0kHtiFlzkhVy4GdUhTRdBHSK7Gr5BRl5wEr0+q1RxoFdKfDoWYxHe/Pj1SGi5LFdfH1RUY5r6haCmocDK76bJTs8g1vtwAgyjZ0nu+vvkhaHW+Xd+nX6cKjxqgQqH9aT9U7EIMYqD1ubuB328upEMBgF74Kx5gt7/kaA6y5OfPg8hcy+wt2v2TFoH7kWbYGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvAxv7yLFTCm2v0BiSFECaQgos7tkgyZvapDkWxHq6A=;
 b=g9R20myKDtH+y2AwI561M0uYXSKn5ojonkFFnuPiRKhtQ1iJ3SE+lPriog2mZBF1St+w3la19Se5oSYJSnSXVxQ04Ozx+uIRqncpMfNk4GbyZ3PxzcvsK8BWIU+Bo+dq6jkt2+zA5BJKWnm/bD1JIKgLherI1AiTaXS1CVZXWcHKRdKyY5egqxYmQpCLjXfRll2guEViDIxIdCIT3sz5Puccswh7rA2LydjjpfHnAaEyyOeEKgrRU97kf6QhPYynHuIzSFTMWj2OsOqAhO9M8Ytb+KbtLn/sHz5ATQ5MtoK2reCDD+5/Hl4OpfTlB5XTDsZg8He8svpIPeaO1VhJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvAxv7yLFTCm2v0BiSFECaQgos7tkgyZvapDkWxHq6A=;
 b=uWfqbs8KEFGUpOALWB9x0JHbb1ApR72u131G6Fp9AMohTJujI5k+bE+705INtD6vAEFJXeu6hGGjAhexq5TtTa+GyLf2kmp92uBTyEfDASBYle3wgAauLo5r4lclwWxcPoC9u5gUVV4LI/O2UToPoq6YgyUEd3u1DZ/iAvXGdys=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 07:03:10 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 07:03:10 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Guttula, Suresh"
 <Suresh.Guttula@amd.com>
Subject: RE: [PATCH v3 3/4] drm/amdgpu: smu: cache and reuse averaged unified
 metrics values
Thread-Topic: [PATCH v3 3/4] drm/amdgpu: smu: cache and reuse averaged unified
 metrics values
Thread-Index: AQHczccA65LgKUOigEO/GO7YSNLbiLXnihsQ
Date: Mon, 20 Apr 2026 07:03:10 +0000
Message-ID: <DM6PR12MB29729752B61F9DAFFE56F948822F2@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260416173145.856326-1-Kanala.RamalingeswaraReddy@amd.com>
 <20260416173145.856326-3-Kanala.RamalingeswaraReddy@amd.com>
In-Reply-To: <20260416173145.856326-3-Kanala.RamalingeswaraReddy@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-20T06:56:37.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|PH8PR12MB7254:EE_
x-ms-office365-filtering-correlation-id: 418b1c1d-c932-49ad-2417-08de9eaae1ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: hhq38YrdANtkMv0ClNjs8YMjqMWqif+7ZfyLYjtXLXKWgixEOh0KyYESsoHiXw8aXAf4DXnrUutSTRiiLjgiOa5gfE2fgjiEra2U4Wo8Mg6CvKRzJfk5tljs3MLxCNgRO60dHOJCxwifFYhZq+F8H5CGFQiJKCzd6m3LlCYZvM6mivoIhxFVhRL+OF4bpqWIBYxkdpvmShLuGLrXGnO8IapzOyId+y6uz+4DzooYKcL1BLBTZCLDr/wmoFywb7bNk41Cxn36yTTbDMAOUwZTB5LffLhWqCW1ipCPZOWMMBK1pxO+pugy2PiOSDjzH7w+EHH8EVsEFy0xMQwW9qu5Gai9PZly8mv/a4WfEWRDR2okIyDyalyUWlmhcFWLeh5ca0KQAF0Z4T16CtA/IGegicQA7EfW3BvcDZ5cPxdfpoyH9SW5Hj+eaFiJ8iCUa6Zlyb3mazuIctZ9wyFtcggdhH3EKHzzo3tGAPz6rQQCndKEG/xSKIDeU8GysKeEapLN06ISzs47ElK2UlI/h0tTpY49C+pbEOjQnKj35CQup79lpP0WLlZz0GhlWBLFyG2XSwy2K/xSZtU2F7rgoQIP35Q3IKlnfbBE/7AJ1mFyV2PkEl+rwSC0Zbzj1kClBDzh2zgOpJYiULg0dOViFOBWB6aEgX8ZkIBpeVGWhBrwvdFq0vHKlt5hUf0gG2ht0k2i5Wuu+yDEkMajAKY3udcVNaw2pKDbZSy3ie/tfOTVG1/uTXXEkwM93ZIw4WQw56kO1dPjSEUud5mGzeimPYfX2YwOQkjl03scLBZCPrMTwJ8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vc/A3yrobVDKqH2uMAzqv+0VkFXVbag9oPCz4ljugCfG5T6N2B2Yd2HEIBzq?=
 =?us-ascii?Q?bVWw7fVSY/GjYfSaiIN/mzEG28AChXPtVRU/Olkb5nFxIhzzNGaPN7NcuP59?=
 =?us-ascii?Q?zauhsG+H4NCS2oi0V5DniEEEJ5P/Fg07uD0ryvpsdg8z464H7zh5HrKYn18Q?=
 =?us-ascii?Q?USw5cCP7zhpQl3WDvgm+6QvXm62TxMNGFvFG11AXfs6/xdmcC5VWS53k787l?=
 =?us-ascii?Q?ulVr9Z+vDkLx+mvDPQCxO4lpaBrxRpRqD16VsMYuiah4gSXU4cFjWaVp0rj5?=
 =?us-ascii?Q?D9n/vmxjlASWHPptLu2KTArMq6HX/EQmudto6xDuXKpsQQawGBhT02FTpMpk?=
 =?us-ascii?Q?frBIaUd+03GHylKAgrUW/QLwH5Epao2N6PJavytTVHe8Oow9y2M73SktRKLb?=
 =?us-ascii?Q?HK8swGtOkpIMtWLtS1/6q/rqCgJ+kKKWPJL4dkYOdrSwRAo9VHPnqTmLRYWx?=
 =?us-ascii?Q?MjU3bHEpxsSa+L5ffenNSjt6aek/BVgJCY1KPJ8amZPoCP+PmhnXx/HMKdbS?=
 =?us-ascii?Q?ff6MvZ27+zTHt4aaqdRTM5LoluPXyV05NoDcxGxX0nk7Ragwt8LyRFzaeQMg?=
 =?us-ascii?Q?cb211Yyt3oA2Zdfqs2pBArJhp3SHrOlseVK3R+BHQdz7bBKFFsRxGaOXuXaB?=
 =?us-ascii?Q?hEtlSjcmQoJ7lCZPVPFMOXPsCdrxQD4WOxREqY61UA5QA/IEhUIkW3CUBVh1?=
 =?us-ascii?Q?UW+67LBs8M+po1qB9xlYlSuOONsLApgg9ybbRz59TBiRlgAJoj521no4tbPT?=
 =?us-ascii?Q?rDtqYqdsMT7lbUIs1ZHd0aOu0JNbN3FTv2+hmXAMMmpqxHlOoeEuEd93t3Ar?=
 =?us-ascii?Q?RCf9UUequO2qiJkoWO/jyhy8LxMQFeaIcFzW19P+jks2l/a5yrcN7SHDbcIO?=
 =?us-ascii?Q?70znaUnFiiSRxHlyfgcAZ5WksF+z5Wn1epo1C6hWTKseWiefN2uWg+BkYdoV?=
 =?us-ascii?Q?pa0CBxw34TuTzrYLuJKqa9S7/pU11O7Gl9aYwJPWLEr7JcsskVeZu8WY7V35?=
 =?us-ascii?Q?wGnE7TZm56fGggU9GYb/WzTEVRvkg4RRqWgOgTnpcKASK5bvKStvm5mcyMf6?=
 =?us-ascii?Q?DLqZdu3VDMBjNKLefjMGpWFx7wSxNqxqiCRyWMCXlwix4SIVEgNx2C53o/KE?=
 =?us-ascii?Q?gUXhlFdrrqoTbkOQ621Xw9gyC3YCOBsvrYjwPkxOz26sSdSerPtXokN3/91v?=
 =?us-ascii?Q?xtM0ivm07uHdfkPh1rHsI+PpCa81fizwD0cZbeslyyeDebQSEjJsQ90M4LtO?=
 =?us-ascii?Q?0J+GLjnBuRnVdFDUW3LNZ5WA9ueMK20gN47P0iOTzx5RY9gZFPX5DQ4H9mCI?=
 =?us-ascii?Q?DiKihNkdmRq6I8WWpMMxC0tSqTeiEoozfj/84/RInM9NS5N79Xsl0cmPiyZT?=
 =?us-ascii?Q?d10VFZUg0k1w1ORZiaGsN9a1f5mU37ASuTr0GiBoGwk9OgNR2i587tlweGyC?=
 =?us-ascii?Q?jOm6bJ9WGrYM6Y5HiNUliiiKnFZo24POjy91H4aQAEXwFbQ8yPQ3CFtyHino?=
 =?us-ascii?Q?2YZDBpy9hWuw65/Yj7hnj9v7rsACoPhEjLX3A2fQbnYMIkThUPK80ZtAemB9?=
 =?us-ascii?Q?+Q5H3SM2gLkIrsONcPBVtfX0KwrY22qem0jDozyc12xPQA1poMujZ2xJqJZX?=
 =?us-ascii?Q?e1JSkxbqt/5aLlN0sPveQ9ySIHgdJVQgPeaK3QHgzp7G0/F0B0HpeedvlCM9?=
 =?us-ascii?Q?4whYKCyxCvMNUfdOB9ThTmEbd6k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418b1c1d-c932-49ad-2417-08de9eaae1ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 07:03:10.0775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3I64ji0HnrxiknJjNrQ9vUvKAh/dBWuRQT7AvEwwf7cC7RuBWj5zFWibiBoWVrvd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254
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

+       static uint32_t Avg_Metric_copy[METRICS_AVERAGE_NPUCLK+1] =3D {0};

It is not appropriate to introduce a static local variable here.
Even though only one GPU device exists on this APU platform, coupling logic=
 with a static variable is bad design and should be avoided.
(this will cause issues when there are multiple gpu device instances on one=
 platform)
please fix it.

Best Regards,
Kevin

-----Original Message-----
From: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd.com>
Sent: Friday, April 17, 2026 01:32
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org; Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Guttula, Suresh <=
Suresh.Guttula@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Cc: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH v3 3/4] drm/amdgpu: smu: cache and reuse averaged unified m=
etrics values

Compute averaged metrics from accumulated SMU values and store them in a lo=
cal cache. If the metrics accumulation counter has not changed, return the =
previously cached metrics instead of recalculating them.

Signed-off-by: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd=
.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 45 ++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index a6a7df683b7e..f0a798631903 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -384,6 +384,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_=
context *smu,
        SmuMetrics_t *metrics =3D (SmuMetrics_t *)smu_table->metrics_table;=
 //TBD

        SMU_15_0_0_MetricsTable_t prev_metrics;
+       static uint32_t Avg_Metric_copy[METRICS_AVERAGE_NPUCLK+1] =3D {0};
        uint64_t counter, val;
        int ret;

@@ -394,6 +395,12 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu=
_context *smu,
        if (ret)
                return ret;

+       if (prev_metrics.IOD.AccumulationCounter =3D=3D
+               ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IO=
D.AccumulationCounter) {
+               *value =3D Avg_Metric_copy[member];
+               return 0;
+       }
+
        switch (member) {
        case METRICS_AVERAGE_GFXCLK:
                counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
@@ -401,6 +408,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_=
context *smu,
                val =3D get_diff_val(prev_metrics.IOD.GfxclkFreqEffAcc,
                 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.GfxclkFreqEffAcc);
                *value =3D counter ? (val/counter)/1024 : 0;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_AVERAGE_SOCCLK:
                counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
@@ -408,6 +416,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_=
context *smu,
                val =3D get_diff_val(prev_metrics.IOD.SocclkFreqEffAcc,
                 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.SocclkFreqEffAcc);
                *value =3D counter ? (val/counter)/1024 : 0;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_AVERAGE_VCLK:
                counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
@@ -415,9 +424,11 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu=
_context *smu,
                val =3D get_diff_val(prev_metrics.IOD.VclkFreqEffAcc,
                 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.VclkFreqEffAcc);
                *value =3D counter ? (val/counter)/1024 : 0;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_AVERAGE_DCLK:
                *value =3D 0;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_AVERAGE_UCLK:
                counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
@@ -425,6 +436,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_=
context *smu,
                val =3D get_diff_val(prev_metrics.IOD.MemclkFreqEffAcc,
                 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.MemclkFreqEffAcc);
                *value =3D counter ? (val/counter)/1024 : 0;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_AVERAGE_FCLK:
                counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
@@ -432,9 +444,11 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu=
_context *smu,
                val =3D get_diff_val(prev_metrics.IOD.FclkFreqEffAcc,
                 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.FclkFreqEffAcc);
                *value =3D counter ? (val/counter)/1024 : 0;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_AVERAGE_VPECLK:
                *value =3D metrics->VpeclkFrequency;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_AVERAGE_NPUCLK:
                counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
@@ -442,6 +456,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_=
context *smu,
                val =3D get_diff_val(prev_metrics.IOD.NpuhclkFreqEffAcc,
                 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.NpuhclkFreqEffAcc);
                *value =3D counter ? (val/counter)/1024 : 0;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_AVERAGE_GFXACTIVITY:
                counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
@@ -449,6 +464,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_=
context *smu,
                val =3D get_diff_val(prev_metrics.IOD.GfxBusyAcc,
                 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.GfxBusyAcc);
                *value =3D counter ? (val/counter)/1024 : 0;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_AVERAGE_VCNACTIVITY:
                counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
@@ -456,6 +472,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_=
context *smu,
                val =3D get_diff_val(prev_metrics.IOD.VcnBusyAcc,
                 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.VcnBusyAcc);
                *value =3D counter ? (val/counter)/1024 : 0;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_AVERAGE_SOCKETPOWER:
                counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
@@ -463,54 +480,68 @@ static int smu_v15_0_0_get_smu_metrics_data(struct sm=
u_context *smu,
                val =3D get_diff_val(prev_metrics.IOD.ApuPowerAcc,
                 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.ApuPowerAcc);
                *value =3D counter ? (val/counter)/1024 : 0;
+               Avg_Metric_copy[member] =3D *value;
        case METRICS_CURR_SOCKETPOWER:
                counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
                 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
                val =3D get_diff_val(prev_metrics.IOD.SystemPowerAcc,
                 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.SystemPowerAcc);
                *value =3D counter ? (val/counter)/1024 : 0;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_TEMPERATURE_EDGE:
                counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
                 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
                val =3D get_diff_val(prev_metrics.IOD.GFX_TempAcc,
                 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.GFX_TempAcc);
-               *value =3D counter ? (val/counter)/1024 : 0;
+               *value =3D counter ? (val/counter) : 0;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_TEMPERATURE_HOTSPOT:
                *value =3D metrics->SocTemperature / 100 *
                SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_THROTTLER_RESIDENCY_PROCHOT:
                *value =3D metrics->ThrottleResidency_PROCHOT;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_THROTTLER_RESIDENCY_SPL:
                *value =3D metrics->ThrottleResidency_SPL;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_THROTTLER_RESIDENCY_FPPT:
                *value =3D metrics->ThrottleResidency_FPPT;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_THROTTLER_RESIDENCY_SPPT:
                *value =3D metrics->ThrottleResidency_SPPT;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_THROTTLER_RESIDENCY_THM_SOC:
                *value =3D metrics->ThrottleResidency_THM_SOC;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_VOLTAGE_VDDGFX:
                *value =3D 0;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_VOLTAGE_VDDSOC:
                *value =3D 0;
+               Avg_Metric_copy[member] =3D *value;
                break;
        case METRICS_SS_APU_SHARE:
                /* return the percentage of APU power with respect to APU's=
 power limit.
                 * percentage is reported, this isn't boost value. Smartshi=
ft power
                 * boost/shift is only when the percentage is more than 100=
.
                 */
-               if (metrics->StapmOpnLimit > 0)
+               if (metrics->StapmOpnLimit > 0) {
                        *value =3D (metrics->ApuPower * 100) / metrics->Sta=
pmOpnLimit;
-               else
+                       Avg_Metric_copy[member] =3D *value;
+               } else {
                        *value =3D 0;
+                       Avg_Metric_copy[member] =3D *value;
+               }
                break;
        case METRICS_SS_DGPU_SHARE:
                /* return the percentage of dGPU power with respect to dGPU=
's power limit.
@@ -518,14 +549,18 @@ static int smu_v15_0_0_get_smu_metrics_data(struct sm=
u_context *smu,
                 * boost/shift is only when the percentage is more than 100=
.
                 */
                if ((metrics->dGpuPower > 0) &&
-                   (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
+                   (metrics->StapmCurrentLimit > metrics->StapmOpnLimit)) =
{
                        *value =3D (metrics->dGpuPower * 100) /
                                 (metrics->StapmCurrentLimit - metrics->Sta=
pmOpnLimit);
-               else
+                       Avg_Metric_copy[member] =3D *value;
+               } else {
                        *value =3D 0;
+                       Avg_Metric_copy[member] =3D *value;
+               }
                break;
        default:
                *value =3D UINT_MAX;
+               Avg_Metric_copy[member] =3D *value;
                break;
        }

--
2.53.0

