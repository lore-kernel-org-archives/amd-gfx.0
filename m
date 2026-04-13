Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46510E93817
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 04:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C15F310E081;
	Mon, 13 Apr 2026 04:47:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NLnvNc8W";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7040810E081
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 04:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlhSUvsNJUMcmViltMhQTzLqiQrFZsOYeYRD4b1mprerEDm0w7AucSu8riXnHIT9p0387YDMmdy2wmC9YjcpKGwO9xs0IJmAxfuLCp19VGf+lW4Pns4zHcgFt8+obrUfCNOUTCLCiWnolI5AnUlT/LhI49FI3JIRHHWDvVBXi7kEoGcRCiZTRne0gisYf514QADF7m3560dIccWLuEuu1QmhxDoRJbWKTC0xbnuQpaQUFIFEDg0cjyKEmAv+bjgXTwq1dpxJDBs2KALdin6cs5yV1Xdr6ow4XQddsoRLcJ0sFIPQp87Em2mXSeVQt2uVPDg0qDY5H2vl3AXOHfYMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jnu2a0Gyfs8tOeQq0Lc/ZvTbbHUxJP+nxTkLAxE4y7Y=;
 b=j1oP37DXJyKnAhe0g2KKiTWx993M+w7jwsBTGWvBUdEGyG3J3aNDsVgjb7g5Coi3wllZVrbtKxRNg5eZS383OAanhpJZ9k+Gj7A0N0V1LChkzoSmn8sc/imQlioXgJeEuowbDMDwiQ6wINKXI3tCC76tNYBtftJSC7QCxSeUL/FB3mcCaLSEQ7FzKspLXXKso3cUox689+0Po1EEpYYj98O4cu1gVI+QvCJrKO+jFPDqD1oH3lGXvjNEdXMpWLLtH++oRIihtcvc8FfnX2/lPnMqiDqSK8V4CZbZZZMNQ/4RLFEZR33miV1t44994ifo9j41qC266nFl6tBvYL0LCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jnu2a0Gyfs8tOeQq0Lc/ZvTbbHUxJP+nxTkLAxE4y7Y=;
 b=NLnvNc8W8IVHBwi809oHIVcfMw3f3QxUYFZI7PWatnhFqPX2ylPdZA3Ha3uUQIgOoNaTqduTVM2Dg8EOZRgTItk1/32vMzXxYiIXvOqc1XTGXmrbaPMSWmqxIFsleJV+qvBy+/tdcVwHwIEJrVIS/IgfUtbMI6FMjp98OLKoFyY=
Received: from DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10)
 by CYXPR12MB9427.namprd12.prod.outlook.com (2603:10b6:930:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Mon, 13 Apr
 2026 04:47:42 +0000
Received: from DM4PR12MB7646.namprd12.prod.outlook.com
 ([fe80::71b5:d9dc:6686:a45d]) by DM4PR12MB7646.namprd12.prod.outlook.com
 ([fe80::71b5:d9dc:6686:a45d%6]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 04:47:42 +0000
From: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Guttula, Suresh"
 <Suresh.Guttula@amd.com>
Subject: RE: [PATCH] drm/amdgpu: [Medusa]- Fix Unified metrics average values
 reporting
Thread-Topic: [PATCH] drm/amdgpu: [Medusa]- Fix Unified metrics average values
 reporting
Thread-Index: AQHcySKNcD+LVSC1mkOpxWsUUYOdhbXcbrNw
Date: Mon, 13 Apr 2026 04:47:42 +0000
Message-ID: <DM4PR12MB764697C5D5B99A7C0916B8C895242@DM4PR12MB7646.namprd12.prod.outlook.com>
References: <20260410194437.1461287-1-Kanala.RamalingeswaraReddy@amd.com>
In-Reply-To: <20260410194437.1461287-1-Kanala.RamalingeswaraReddy@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-13T04:46:26.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7646:EE_|CYXPR12MB9427:EE_
x-ms-office365-filtering-correlation-id: 7505da76-135c-4370-1c3f-08de9917cc3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 1oLxITJSR47MHKtellTWBrzIsJLQSVQZXRf/t4K6LK10gzQuYmaozjGlmpmvLQFVOKSx/iQZOrdTPIubdbyVAd79QxdqzpkOY+BfMKU9/mA1EBn+LQ0Fyh53H9NIiV1od6+Yz4LYSRABYPbijvHqixYSqP3+ppGfo54kEqT+uLfJ6nZrH3wgsfPvWsuHSg2qUufRC/i1ozarbXfN9J2TqASrZUQkxsxhNfHzTC5GKWIkRZkth+zhG1ha82Wf4ic/zrHPjG6ya4820EKUVlLWvR63pMOsfbi4eUMuP5SxatyOd+Wa2eqDhM1NrnaAz6NPgdK+YXQZStu46lK5ZOU5I4bpqA+gnek9SLI6JZUK6IT9aSXTxLlPo2zK+x3HnVR0Yy2x4v7QJ0ox9e+UqVu1ciBp1CuxQZJxC/xNSa82ykqrS/5LjVbKWD/EzsQySent2DqyL+WmaT1ZEdI8mAXgh3yy7kV9ihtmnZHRduZgCNIon2AN75fnvT54dICy+M5wIdGg1I7Za4qNIpJnpnvP/CSxlDDmgJltwrGpki6iHO8D+3b0h4ThATZckLwjH6f80pjmSdBrP/71HMC+7nrR7aIEFie3VSUsf0/Nml3ejCkQsbf/0Teyz7Ja7G65kan4PdybYEA/eyxOBqXYjYV5C7iPcJ1QH1sQKuTHWPx6VW69eBAOra9F79ALd0lvabmsqBm8/mL5P7EjylJgrRKM4yZLZKLqnlu/JAqa9fwMJwTW+iO0GlWtjBdhgUpwMlGhsqitS2MoLcNAPG/fk/4L0vaOLFraCEvuarP2yq+JOsA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB7646.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CNAdAN79fLyWsZVl8mZXVFfUI1Y5irEdn7vPLwDA2VV8h+/+VcqBOD0+/s8C?=
 =?us-ascii?Q?oCuq5/Dob8qRwYOwlKZ36skYvTcf7mL8I9XebJ5cTUP5tjLWhYOXr/7kvHj/?=
 =?us-ascii?Q?VU+UsiiRJp7ugIaFnbycvQY4LyKJkk6r7vh2QcW3RoByl8XmJJjoZMQqy6Yl?=
 =?us-ascii?Q?SL+rc85MVqiEQ9Ettu13SUfHx1gcpoXNiSh+iGexrMmlMwaymGlywM7C7ddH?=
 =?us-ascii?Q?LFsjjZLp1NLM+RP+HDmZ5uf1KkHsyjVS1e9s3MBFA9ywbd5ThN37b0ptlZ1i?=
 =?us-ascii?Q?NisiK9ktVoqdQcftk1TGq2p9T+QbbwKhFdDXetRtahZl/rPs0ZB7Jq8LKarR?=
 =?us-ascii?Q?g5I4uq4fqYYjT1fcTxg1gbwCFQGBQTZ6lnWa+G3IXGXmT6lOavMWYR19PdRk?=
 =?us-ascii?Q?wetLnblLZH/FKitUvfEUjK00eV1aAv+SKLumny7/8NmIRqZOEcyvY1o78ILs?=
 =?us-ascii?Q?e4C0nCP1O7yo69sGOB93RLo9yhcxbuZvWIsTiZx3cUf9HpiHVu+SbjEtjlGL?=
 =?us-ascii?Q?AKXtqWc2wtGF/Hc1RavXNw1RVibJzYjO8Udzx6jfIn6oNkI3SEeq2yZCpW+U?=
 =?us-ascii?Q?0jQX1rcG61VXXkap8elG+w2AEqlRcDew5m0Aijk0/2M8q072+SvuZLpneOJe?=
 =?us-ascii?Q?54nx0/yZPkgPTqeSxZ/bLEIE0u4WI9vv4lGJfOFDPtPXXI+YXYhggk6/L5HV?=
 =?us-ascii?Q?brwRntI3LhwGVwu8wnJqw9V67jSHPCnWYqn3byUn5amohplmfQrX6AodiPII?=
 =?us-ascii?Q?NyJDCHW/+Bq4zTuBk4MJcIx3246WSF19qSL4ChvyX0EgoGJsvO1+f8O7f19m?=
 =?us-ascii?Q?TJjqsPxIn3v43m392RtijhYlJHryrGu3B8ruD33oGQJMrCXFJbMWxcqJGH8v?=
 =?us-ascii?Q?OpOFXASIZMHZqwh7QhrUHlj8eCWEGlIHwc36ByMBImLyRb5NwilNEjVjYo4g?=
 =?us-ascii?Q?zHDpOvYtKOaz3KVm+PZplR9wkCur3U/6l9yWQqHYdtJeOwxzv1HHOp9FcFRe?=
 =?us-ascii?Q?Fq4A7rsReuVDxImjfRgQQH4iYupRNKirozbA6P6kS6I6rF5d0AuPMAWNGPKg?=
 =?us-ascii?Q?B8wJ7N0bJzbd96z8sYLtteE0zJh7YJk4dSCceZO2C54YHVqerf2TRwq70DYN?=
 =?us-ascii?Q?X1NdSui2ZtuNPVJX8xzLPicSLu2LcIG1KCCWQh1dIrtLMS5tyvWBvgNKDPnZ?=
 =?us-ascii?Q?JKYAvP1HavpFDXZ3Ye6vedsiiUVqdJ/VHyaolR0IHAIl3+bzaV8+TDwXv8iR?=
 =?us-ascii?Q?6oVHNeF1ojdVWl21/Zq9Ug8Eu+qSzER6g7obJD9DpHpFA5cMyEmEkkPpzH6c?=
 =?us-ascii?Q?gvEWntPTAhg8NLfoFlmhUmL2tT4wCYvbFO4SWYC0Td0Clr0TcBzIHnYPZ3/s?=
 =?us-ascii?Q?udGlAPP0b3Yy4Zn5yFthiQhKOlHGb2vlls/uld8p2DdBJQzt2vflO+lGjRin?=
 =?us-ascii?Q?T+W0Jbs8an2gxlCS7K4Gr/nYBfP1xrdHSPSKdKGsymQBNxlB1IbdewocaugH?=
 =?us-ascii?Q?SVl7eJxMcFLGeuf2pOV/NAGyXzJqS327fhIp7OYSkAmfiBkVOPDeim6HW3VL?=
 =?us-ascii?Q?RQ+B3f5y2ztEWrIGmxdMO+KSe4sRUFwQb8N00uTjqPFAjYzrxftfNl18Tcmu?=
 =?us-ascii?Q?VJfPSD3ois//uJYUJlSJG2TrYnGl8ZJnAA0nevM3Ou+04oJh6WrhvqF46u/O?=
 =?us-ascii?Q?X16DSvJ7vV0FTpd6htyrQ/PXUU/yco6fTx5yCUOS9wPpvw/R?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7646.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7505da76-135c-4370-1c3f-08de9917cc3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 04:47:42.2393 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0oKQ9oyyI67xyakhSBnE86nQOx/NF6sDZqFoVWtvEqNNS2bd5r7qO3+aD43yjSBdKClBml9Omx11xirxZhf2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9427
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

Please don't review this, sent it by mistake.
Sorry for the inconvenience.

-----Original Message-----
From: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd.com>
Sent: Saturday, April 11, 2026 1:15 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org; Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Guttula, Suresh <=
Suresh.Guttula@amd.com>
Cc: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH] drm/amdgpu: [Medusa]- Fix Unified metrics average values r=
eporting

SWDEV-577922:[Medusa]-SMU Metrics:New Unified metrics table support With ne=
w design SMU is sending accummulated metric values, and stop sending us ave=
rage metrics, so needs to average metrics once read.
If no changes metrics accumulation return previous metrics only.

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

