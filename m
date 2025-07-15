Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F174C83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 06:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A26A10E084;
	Tue, 15 Jul 2025 06:18:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d1pyEmFq";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E7A810E084
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlI+4IhPKsZapP4hmVJMsG5mlcNDJt9hb1M/ADpTyidSVp8NnflJzJrcbqhTemYvRpdBFU7uUZIYwBJY6nuCkCR8gaAtIyOcqsgDKCAvSJKdjiTXBMoDa6GqI83MEQmc7sbicsXu/Z2voEPNuuSFb9l5xnchN4/3dbzzDSVqzzvGW9/8NcjHMcfVmkw66uVMJzVbFcqYjY7LyJfOthH1q4lZEJe1VsHbYE71LWv3xAzuqsmHs2nfnN8q7Z0TgCnuowx2LWURdLceEggJTXVdYm3ag6jHPXr7f4b7BM3ZGn7Q45mAMlNGR8fR2+HdfiASC/fQbSWujlGsXokpoMdR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLlnQEwBu3+wV1oPhF6uFYDVlt3clcHnHHJ6oKwm+fE=;
 b=tYlMHWpg/e0QDXD/5nNfryJwvbYpepppOnqyvoAL6T52NwvbygRACMsihcfzSA9LDWQHeff38VT9CRC3x3Tvtgls5vnjS4zMMIX/r6hsJunMRlANtvLP0RoUXesfbhGSVbdro1iZktQBWQ7//1caMn9Y+wKzWWv/BImT4ghYFGaFGq91Jdt+LwnxtY2aMZR5xbhNy0YN0lCSISVUx0gqPTbFz/opeFzH65diOk9wYfJvevOv8eidmvBLaOzArsebUcdqM2vElwGg8i/luQjBWLWe//mez+zZ3OrlxtDnunkn9z7xhdiw70FQaK71VmRnYcjEk7D2xBgL/E7YjmUomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLlnQEwBu3+wV1oPhF6uFYDVlt3clcHnHHJ6oKwm+fE=;
 b=d1pyEmFqBt3OcxzlmBOv22k1rx97zeEGxmnu5QnDlp4IjeefQAX0jnTxHy8mWCD9gk9swzEn0bN7+i1ezSooDGdm2UwQZR62msM8zGiA4FiW68zrPW+qVIHd02DYQL7NjVtZ6ib4oKZ6Eh/y7yos05RWqZGAaGtTjOzhIFPTiNI=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 15 Jul
 2025 06:17:58 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.8922.025; Tue, 15 Jul 2025
 06:17:58 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Get max/min frequency on aldebaran VF
Thread-Topic: [PATCH] drm/amd/pm: Get max/min frequency on aldebaran VF
Thread-Index: AQHb9Te/+aEnZYQ9xUS9oF92x/Bb5LQytfMQ
Date: Tue, 15 Jul 2025 06:17:58 +0000
Message-ID: <DS7PR12MB60718CDAE9F88057AC358FB28E57A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250715032230.1531865-1-lijo.lazar@amd.com>
In-Reply-To: <20250715032230.1531865-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-15T06:17:51.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|CH3PR12MB8972:EE_
x-ms-office365-filtering-correlation-id: 7b84cbab-21bd-4748-afe6-08ddc367581b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YG2tRsrsO66eNZvFD60P5zpgFpsEUwlsWOyhcVe7NZ82Jc+OdaUTvdfssIdV?=
 =?us-ascii?Q?MoeRo5JFPwdxNETkSGjR8m1VVbZqoVUAgDLxqfJo03IIvnJQw8/654X2OV7S?=
 =?us-ascii?Q?spJIRPh0yfmknbxHfXtgECcOrg/+IkZJwDbLMh9mOgFWtubR8j+g1LyIqUGg?=
 =?us-ascii?Q?Vw7vUkNAcGTmKsVJ6Rb+fccImCV5u9KAeoNqq5jMgxMkq8I8uCXUwqzmHIat?=
 =?us-ascii?Q?xS9DnoZxv/Uhrc7E5IakNGS045GIvv0FTrCVGwYYG9Mns+vU6Ihqg9DsusIA?=
 =?us-ascii?Q?Seb9o8FmBeXov0aA/9Awg5mb4aqX9ak+QE99jWlA31zBEdhXlcQDKCqBOVWb?=
 =?us-ascii?Q?TPFcjQxzE5z05BUhsuiRCf+jt3ahDAVm8CaLBp/UcalYQdh37rbXyac8LqE4?=
 =?us-ascii?Q?0GJYI2Gxrdr3GyGsO45duQtV3zNRdz4gZlVv5ntdq9vDpC0l3hg3Da3ih9CM?=
 =?us-ascii?Q?7Hs5F/q/batWNu9aJxWsFlWHhOQJYbztv1dz8VT/4dlU/05clkEMarOo4Gqf?=
 =?us-ascii?Q?PYnAIanzDvhqUaoV9S/Bke24EQfHLI5hbOp7np8AYo3iZTzlLr658N/MYMdc?=
 =?us-ascii?Q?quhRm/5j0ERcGbcFgaxS4AV01+gYewoEIgtoECvPpCFtZeMO7Vrc96IwIPkq?=
 =?us-ascii?Q?gNSCUTAG+yoXH2T7zT9o622rqaCCjYak2kTL3bhu3eYtOPKY6wdDM4PzknUo?=
 =?us-ascii?Q?uaq/24UiSHK5F/PlpBjkxRLGgtVX9tVk+zU3NhgRE9FqHHOyxvujW8JgbGA3?=
 =?us-ascii?Q?mw1gZZB1CkgBQu7IbG/XfPpFCg3wUhziN4lRphoG0tHgpYasb//Uy5kfGiZZ?=
 =?us-ascii?Q?gwlmjDMztvsjU8nSCV4dcHX0SPkppi24Y3i28PLNDtiOX6ekrnhKFZTs4d3u?=
 =?us-ascii?Q?JxuDYHk9l3LkCCymdRXTF71dPVUlKpgrKkYWKcFj6AHRO8V1MKtIP+jT6qwZ?=
 =?us-ascii?Q?25oZsKdy+uGB4jNQgYJNbOJYYksZqotkmHUk8k+PVtUNjTcPWm8RLai7d0jv?=
 =?us-ascii?Q?a9R9bHQiqajvGYmXO/I/L29W42KCJfUtwzipXerGXfpCZ4lU+ctIoQPrt4gd?=
 =?us-ascii?Q?JsynpUK2nn+G3xdCGDBWKNNcYLTi+41DDN+gbGcyhbdnSphJ2Zyn/4i4mmSm?=
 =?us-ascii?Q?MtXOmmcYSPxUkCd1Cg7khjkROZp7bjtmphH55QQqM7tGdMHEAPoCSJFAi8Cc?=
 =?us-ascii?Q?XKls6eeuqMUKzdiSviSPLrJwwC/lvJip0fw5ikfyH96MUVAlQAZz+sxC3G1h?=
 =?us-ascii?Q?I5Iydc03WgMube6Qa2bCUESocdLKI2FAVFb4kG87M3rtoYlE4OiESqaM1GFK?=
 =?us-ascii?Q?2K8gTfcR4hA4Tpm173o+XMwNwjsp24vZWL+ZPiS5Gj2EpfdLxTfENQse82Za?=
 =?us-ascii?Q?xaavmNROHtLF9Di2y8VeU1Q7Wfh8Gh84x7Iwpp3XP1Y6cZrH/GN3npvBujx+?=
 =?us-ascii?Q?UR3qZUw0VL1ckUY89NkWU/lACIQOfqKE8wO8cog2JtzIf5FfWxLpNw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rZccf0W8gGkWgFmBYYlOAKETRzKi0fNiKRyUtu2Dp2EWrRVevFPYjG532qrj?=
 =?us-ascii?Q?B8BeJchVdN6g7sMTMZIbTQCDdrrN6qXJetpF75W3H7mdNZWFmFdcZQRYdB7D?=
 =?us-ascii?Q?UQ4syi5WoQ9kiymgtR/dbJvpp7CPUV/16zR+0kH1IxIfc9fUqXVqQSAUpkVG?=
 =?us-ascii?Q?C7+xEA9Ok1ZEw+N4tnyDrdB4jWiGoChzeWZVaEXviWbfJOOn3VBlyhLYyMWJ?=
 =?us-ascii?Q?Uy83KSR8Q+5MC6dLKYBiDHLDvcj1xHHCTOmE3+LwSLlJHSrP5MdXbNdSI8jo?=
 =?us-ascii?Q?6Oq6f1gkcry1jq5UjFRa01EaCu1EGaAdpOYtddj/c0QJsLL0VZ8j8EzO0VXs?=
 =?us-ascii?Q?r2/p3S368By7Rp10SzyWMGe0mf8sUtNOhO4RkEZFm3uTtIf88CrEbrh3jTYG?=
 =?us-ascii?Q?kzElDI5QLgu1Hf1aP+JMbvoWAOK5rLvWiZhh8scCfVFB9o26u+hfA+ZzEJ/c?=
 =?us-ascii?Q?cWNilzORnS7YUbAMyZHd2gDRlYtRPRHYFCX5VNsXUuP9yFMl7QM/qwlgVcK5?=
 =?us-ascii?Q?X5j1BikYD3xJK+l8g1L5tR7rrmUc10MEsEcSoesObUqxtJRpBLu3UvjbDXKB?=
 =?us-ascii?Q?oQ4wf9SPhoUVZEAIPwTeRVJ+YZif+lNKev3bVLKOpD5yFuyYwXlgPs4fnAnz?=
 =?us-ascii?Q?1THFjzIxIpLgWvM8oypz+1ALkve8gKRcmUdtwoqFj5kIcRsFrnazOPQ2QHz7?=
 =?us-ascii?Q?nrlfW0cFh9h5AyU2lW5EA8xUGT4Uz2GB+2TvUNpo9IVtXPuSrGqDVXXRr7OC?=
 =?us-ascii?Q?UaHyI0zgTe4s/8WJ+sY7S1x2/HNnp5yeU7chrDlRZ6VMUGv9CJB3y/TOKDmg?=
 =?us-ascii?Q?E9xTbUsY282pzDQy+tpUXTk5DuSL23cJYdmEuLB5xKsFMeTBddx3Y0lwk9aV?=
 =?us-ascii?Q?QVe7AflwXDIzJU0EfodahaNpoG3lZS3lXXXn0knOnuDBa9+W8QubJ1gqoNVG?=
 =?us-ascii?Q?BVUvSq7oI+nNS0c7Y1BAw7WLWqKbqVWUcmI9+wIksx9U2PF2F4eHlmBcNqZo?=
 =?us-ascii?Q?giX+mfXAXDiV9QRrP8GOwnU/qOS7W+aTDfzcMSqA1DZEiVnt7V1GY6D5BHi+?=
 =?us-ascii?Q?ENfs37FPHp9im1BMaNYCp25SciN71AACG/ot+6/nWFML+VRNAGzD0FDXcm5L?=
 =?us-ascii?Q?ajWO35CQne9jY0Y/ErIRzPZfSUnTTwcWKrHyYjpqB7S2XVmD2o0DjZ2GT8Zj?=
 =?us-ascii?Q?3lgjyI5/bYPzfZi6yGKNeaUP1NEz7F+YUw2Mg/0dAHaHc1lEdyzRGQQJV5Pb?=
 =?us-ascii?Q?6eUl33/orvk8DLQy+W6JCJsJh2eM23LpAX+rsvQEN+dx0u48ZMtNY2ek+Zns?=
 =?us-ascii?Q?KoobCxcwdg58avts/qOAq83GDocfLSt4Bp9kpZxQ7+f9sJmtu8uwu7IhJlSP?=
 =?us-ascii?Q?dyldLBmzNjDQn5Kp+aISDgmz1NCPgabDIjzzChku2tXsW+dG6beqKN7Hb6F7?=
 =?us-ascii?Q?7YgRmk8dkJ+fWwoOXyjFkzCrTc+3ySpu++NS0uQ863YJ8rKtUTRG7QZZHOSB?=
 =?us-ascii?Q?94lFlkNAKrwfzU6Fv39AZu2kTZdA0hOWVk92HZLzOztQb7phXFlZADWM0q2+?=
 =?us-ascii?Q?fpkSWHPt9vS/ocbj0l8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b84cbab-21bd-4748-afe6-08ddc367581b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 06:17:58.3417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0bj6zHzgt4pP9QsaTsUZbU5jUJujO7SlCyYPqphfdBswhVfqUK4W7Y+dMmS3CUXw3PK2IGm3MHJiQ48l0iyGjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, July 15, 2025 8:53 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Get max/min frequency on aldebaran VF

PMFW interface to get max/min frequencies is not available on aldebaran VFs=
. Use data, if available, in DPM tables to get the max/min frequencies.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 57 ++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 9a61cf904275..b067147b7c41 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -342,6 +342,61 @@ static int aldebaran_get_allowed_feature_mask(struct s=
mu_context *smu,
        return 0;
 }

+static int aldebaran_get_dpm_ultimate_freq(struct smu_context *smu,
+                                          enum smu_clk_type clk_type,
+                                          uint32_t *min, uint32_t *max)
+{
+       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
+       struct smu_13_0_dpm_table *dpm_table;
+       uint32_t min_clk, max_clk;
+
+       if (amdgpu_sriov_vf(smu->adev)) {
+               switch (clk_type) {
+               case SMU_MCLK:
+               case SMU_UCLK:
+                       dpm_table =3D &dpm_context->dpm_tables.uclk_table;
+                       break;
+               case SMU_GFXCLK:
+               case SMU_SCLK:
+                       dpm_table =3D &dpm_context->dpm_tables.gfx_table;
+                       break;
+               case SMU_SOCCLK:
+                       dpm_table =3D &dpm_context->dpm_tables.soc_table;
+                       break;
+               case SMU_FCLK:
+                       dpm_table =3D &dpm_context->dpm_tables.fclk_table;
+                       break;
+               case SMU_VCLK:
+                       dpm_table =3D &dpm_context->dpm_tables.vclk_table;
+                       break;
+               case SMU_DCLK:
+                       dpm_table =3D &dpm_context->dpm_tables.dclk_table;
+                       break;
+               default:
+                       return -EINVAL;
+               }
+
+               min_clk =3D dpm_table->min;
+               max_clk =3D dpm_table->max;
+
+               if (min) {
+                       if (!min_clk)
+                               return -ENODATA;
+                       *min =3D min_clk;
+               }
+               if (max) {
+                       if (!max_clk)
+                               return -ENODATA;
+                       *max =3D max_clk;
+               }
+
+       } else {
+               return smu_v13_0_get_dpm_ultimate_freq(smu, clk_type, min, =
max);
+       }
+
+       return 0;
+}
+
 static int aldebaran_set_default_dpm_table(struct smu_context *smu)  {
        struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt; @@ -2081,7 +2136,7 @@ static const struct pptable_funcs aldebaran_ppt_f=
uncs =3D {
        .set_azalia_d3_pme =3D smu_v13_0_set_azalia_d3_pme,
        .get_max_sustainable_clocks_by_dc =3D smu_v13_0_get_max_sustainable=
_clocks_by_dc,
        .get_bamaco_support =3D aldebaran_get_bamaco_support,
-       .get_dpm_ultimate_freq =3D smu_v13_0_get_dpm_ultimate_freq,
+       .get_dpm_ultimate_freq =3D aldebaran_get_dpm_ultimate_freq,
        .set_soft_freq_limited_range =3D aldebaran_set_soft_freq_limited_ra=
nge,
        .od_edit_dpm_table =3D aldebaran_usr_edit_dpm_table,
        .set_df_cstate =3D aldebaran_set_df_cstate,
--
2.49.0

