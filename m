Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B622D39013
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 21:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD24310E19D;
	Wed, 14 Jan 2026 21:32:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g0bcae2P";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010062.outbound.protection.outlook.com
 [52.101.193.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2FC410E144
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 21:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPRMKRDm06ny56WNgoGHPT30wR5Ao2pjZu1EjQuScDGQOd6gY3iyKSs7U/jc1PWqNvK9sJw318TC1KPX5sv5AXybDhlgre9xAapHa/rmwhI6BNK5wtTDwkjuO0hMpoCwoyqIbQZORlm6z52g25icWNgCGAz9EbxahICJnGqqw0+A5VRaNgkE9QzKgNWd/BnbsNOwMgTApA3go+ZAQhyzVibgYIz4DSFU4p0bCDsarYM/Sco7WkB8WCicPFjBOp9U/0r/nJwMNfd0+2sYD9o/rCFSkjJaHFHrAzAh+/yAe5Ln5k3VyDjdpg0eJ1yD+DyO5lEyr4uqgON24ClZgQa1kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nz/ps7knya7lgKdu7dc03uXl8zX5TTjWvafmuC6XT0=;
 b=F86YcL+hWo+4ddPGEKsgKa4R0mK03PBuaf/7c6vYkgLCJCPMU9GJR4XnsGcEy7bJt4if2q4Z6z8BrumBRQ2eKS381Q29orkuFhvmometPfkjB4hC5mZ3dYicOqnCOgkwrcmBTaxBaafCJAVzFpHIVF4nHSnAmVHdeM+lPXVS4dhLQ8H/IT0CI/FSTix6khmiuOtX5LAAqe4lA3dooWVM5XStDMMEmOIOHUUz87+VxxfF/usddEYi/Gfhg+LcKJeLjJbJLj2r85eNt8kKhdh0Cwbdkubxx8cHLjdh8RQm7lL3mzx/+y0hBstwBqKiyqgBgunm0tJDOC7vW/ZDkCM3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nz/ps7knya7lgKdu7dc03uXl8zX5TTjWvafmuC6XT0=;
 b=g0bcae2PIw81fEr9/0gUP76+W50aOrEmfXD62I7pbDQORLwM1awftSdGEgFpzCB+wqaih7e0QIpK/DpD3XvM/g9Tqgoc1CnpWpWTcyKkc9Ucu5tAQUW/SBCTFhtQybLd5V+tDrgZuGwI36oeOP21sr87NZUQFBgQxHIE1U2Fwtc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN7PPFB3F5C406F.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 21:32:40 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 21:32:40 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Ingyu Jang <ingyujang25@korea.ac.kr>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: remove dead code in
 smu7_patch_dependency_tables_with_leakage()
Thread-Topic: [PATCH] drm/amd/pm: remove dead code in
 smu7_patch_dependency_tables_with_leakage()
Thread-Index: AQHchXQv9h2tJf6uVUeYpCRsr5GdBrVSLvVA
Date: Wed, 14 Jan 2026 21:32:39 +0000
Message-ID: <BL1PR12MB51446340604C80E747DFC608F78FA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <BL1PR12MB51443B02293AA31A924754C6F782A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20260114163807.2525868-1-ingyujang25@korea.ac.kr>
In-Reply-To: <20260114163807.2525868-1-ingyujang25@korea.ac.kr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-14T21:31:47.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BN7PPFB3F5C406F:EE_
x-ms-office365-filtering-correlation-id: 33dc6b58-86c2-4ca0-f356-08de53b471ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?rx2DDEs9wSamQ6qCz2z8eRtmpHYrsdBZTgnhYuii3F1UrAA4i531Kbbd+/j9?=
 =?us-ascii?Q?fQM2NFkuCBKs+qE+QE66aGesxoLUF3myEk0bgpO4B8nGGBsRRG9i/1PSJUr0?=
 =?us-ascii?Q?RlN73B1hXMDFULivGL75f+Igbcrii1zA1Ngqxn0K7uvT26Y1aMrirGl0yN08?=
 =?us-ascii?Q?NE0MuQjlkFxCKywuXq/S9C9sMRPkryxj5ve61r2QPRhrqZ/15fCcchg9Z80U?=
 =?us-ascii?Q?PzRVIfYAiteGhf6BHj+VdPcnC5qpwoHpWyHwLOaBoqF9kBPlNHa4+EYOdjy+?=
 =?us-ascii?Q?KW67Bn1HJ8phn0nZOPJqIM3sWiO+7MwwhNmH3difIfQma56GqqaXVSQ+8Vw1?=
 =?us-ascii?Q?yrFzbh6pZWlf03UcQLmnfBC57D+FR+b9JIoAK1s43op7lSvTkbrJVszzFx9W?=
 =?us-ascii?Q?bM+sybGIP0E+DDCFV7zCqTRXZFTAQJKczTfL2/0WwRzS6a3iMEKzEMXdPlrG?=
 =?us-ascii?Q?hoeo73WpvtgnbOTt6wkye1GynwRWC1JNSNJaj+wtSJ7j4DLByb8F5ZsAJ2D3?=
 =?us-ascii?Q?srpYRutbzoKPs1O21dt2WoTtw9mUcQDeGsD0G9JjMJupFnKbI9Ya8YHlFnaP?=
 =?us-ascii?Q?e86c1DQ7+h0PVvwXouuhMtJdcH3dEDfeMrKiH98Juq0Eerf3BUF50tfhhQSe?=
 =?us-ascii?Q?5FeXV4vEZ7bqgoMkXmll8ADC1y9pBh/edqfdElQsC7b2nuROeewOIpeKbmPI?=
 =?us-ascii?Q?VBP2uNGLUBnPOZDOo0QQIP3MXQke5IzwHDqlx0eDIfYoryM1hldwbEHsoUFE?=
 =?us-ascii?Q?n1m6lwsDG/0fAXjsif9186r5xaqXoWmqGDij6o8+pW6Km6Pii2zdyeQVyURj?=
 =?us-ascii?Q?Ac5lYAw2LOMcImBZhEyCMf/niZlxZgPKSKVayBjeUMSVD6BJAnHgFn46WMI9?=
 =?us-ascii?Q?TbrX0xcrvQnV3o2ts0mCIgYV5GOlVJmTkGrQbb6x3vcDmeH32St6PsyEMIQW?=
 =?us-ascii?Q?9r+PxT/Soe/sQKgfnuMiyA2YDRL07H02E8qg2qqwKV8K3fKP2CvKji1AoR01?=
 =?us-ascii?Q?0HXqqwFv/qxQY5gBwcJ78OwFOTBElTpTG8LSriRDmxoYD/Ci4s49ArV9qhXS?=
 =?us-ascii?Q?YzHepxoXshTeqPJPyDe8XKCxGIyHVQM7cElsl2FBZUXqU8cHKepftoCnBtQO?=
 =?us-ascii?Q?+ovbNjcp/NIbaok+OVfOZMFn1xXxw50ihhW9ia4Ts/MVdQYz4yx08WrtoYnp?=
 =?us-ascii?Q?+IPEyapC6xAgPXcbW0vW4LcSRSBdWWKKnbST7G3I0E3s/jGBQOzI8s94+gsH?=
 =?us-ascii?Q?TNPlqlIIQnV8DMPM7j5xCzl0ABET0xXwCVScn6iH7b2o5ht24KIQu8wKKP15?=
 =?us-ascii?Q?uPiTHiGeHUTJjbpon14q3qcuhj7kalkpb18YSpRlm9yN+/om1AbeYfoJbC//?=
 =?us-ascii?Q?gtMI7ncVOWml4+Ci3B0lD6St0VG9xVCefWlvFSa9aIXlmPrA8gB7KjMxZ9eo?=
 =?us-ascii?Q?tBfNvr41DZxr/Tc5tVAaF3eIGTmNlWe6Il6mtzHYwowPJmp7rl1/gdzFB/ED?=
 =?us-ascii?Q?/1B615b7YmeccWVmzJwPh9MaOLlFBrhJOlayYR8a+Bfn5ypC7rYXhR1h//f3?=
 =?us-ascii?Q?V8sRnGLNbNByZk1JJEDSdngECR5pt4GHNA2SigVvB+Uzy++t4+tOHyvoVlFq?=
 =?us-ascii?Q?eNp62Q+fvt4aUkTrT83TsCM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BkRaEPkSMvlLtTR+xooKfjlRuIyzi7ldkn1G9u9fV5WbxOrld4OBgyAoBz0X?=
 =?us-ascii?Q?qC8QZyIeXqZdWoGx3nyJCWICNuZd+0PeG9wknngKyb9OAQy9CiTa+u1eIsVm?=
 =?us-ascii?Q?lBKTPt3jTzs8Oxh0aYTdUM9smhaH3O4e30JTuBJACyOOJiCsXHgH3iDxYGqu?=
 =?us-ascii?Q?Z0w0GfrUZCmoiOEQdQR4OvjVlu4ZCf2NiszRp+nIl1r5hHqsCWM0aBRlvU05?=
 =?us-ascii?Q?A8SBWWICXnhC1z3Imk3YX5TbowB4TexD8cAXE6zf8M9RXVloZhxozYYaqm2E?=
 =?us-ascii?Q?ftX7ndLBuGX5muuE82EMIUnzW8dE/4rYyb670eH5ZfyFmrRl84mgqaw6LxHu?=
 =?us-ascii?Q?XQ2CLKScvxlOoUMr0ysQO0ejbrmjiNZHlahbebq0KiIcYgel3mEBEMbnZQC1?=
 =?us-ascii?Q?kZP4FHyYVChXfduz2e1tzPdp65DVPu2oNxx8kGmGrxCR9aLCBpROuwQKxx8P?=
 =?us-ascii?Q?GAg/ByLRitXW2FbgjhbOkiEl9ScaCA/0hr+YbjwB35K+ot6cc+Ex0Sj2yfXA?=
 =?us-ascii?Q?O8s5F8M8FP9OZOnrtlAb+ZqecjXZedeI99eGY5TalrbRuYfSdRthQEoGAD3I?=
 =?us-ascii?Q?ujOK11Tu9Ai4847qaVNVl25DoDGAjDtwPjWq3u87XPhIiP0iC1TJoBhFHom6?=
 =?us-ascii?Q?7LcFEq481hyT/9wEX9w0C3vH1MoXfAFOa8EKc7os5U36FxEhYmeB1a5EA6qE?=
 =?us-ascii?Q?MI0yYoaePfivdT5M6J7R1gnYwowcqSpjwGAO3XVPIW8xHi3wDUQ+DioZxL86?=
 =?us-ascii?Q?QMfLp078p7b/K8RDQGIUOabkOoi0ndeR9HHjaGzmyDxzBGBx41NMNFzt+pMx?=
 =?us-ascii?Q?dRkfJfpjR7hVc6p7nY8DYv1GQTh1XuiL//AFpeBF40Jv7xN0jgqPMPvf+Mlc?=
 =?us-ascii?Q?tvz0GCXo6reVK2V1ekDAfh9Sztfpo4BAJKVqjcjuEAW9wa8QrL/AqQ6cKw5s?=
 =?us-ascii?Q?SujJKFODfDPFv97nS9BVKS87JewS9wGSO8GUo/Nwha+yVyruWC5UV/od1OBj?=
 =?us-ascii?Q?b+LIFKhzn9xUHKPu5raoXf+NEtiUXHdw4VfumJuhIWLyarCDqit0RRrpktI2?=
 =?us-ascii?Q?07F09E+q6nqZ14x2CgdIpAwlg7FWovINHgdJ6ta4HmMz5PNsFBeNSCXjT9Qj?=
 =?us-ascii?Q?hvGWXQXpmpC4g6v8m1GAJbYqyMGmXXv2ggi+p45NklKJbT7SZOcJZWgltlnQ?=
 =?us-ascii?Q?d42w9mRrMRVwdLuIPJVww/whESNALF6X/S9EuGLvlrd52ZyHI4zcr+vqX5pk?=
 =?us-ascii?Q?xMLolF58lc//J/xKmUeJAiZcp3gz06zxOOu9XdQKAy1i4DFQKLKo89uan/un?=
 =?us-ascii?Q?QKiQ5CZnndlm2YDYEKrDxLyxvv64R8RsufkqgYGpkQ36DTMTsgmpq9GJU72P?=
 =?us-ascii?Q?NB+ik6KpWYhLWH2kSyVmNG1O0u1z1AxStyP8s2i7wGqqOT/IlQ1KxrmqhGzZ?=
 =?us-ascii?Q?IhxW1eGBsjxt38/WhbQlXKnyIYZIPjJzGmoZGRU5kav3vR2S1StJnGoBJIPr?=
 =?us-ascii?Q?QzNQCakyCWQjSfMSa487iM+10BVEX3EbmFT2uHQ5dxGgHMuQr4ESlKlk7sAi?=
 =?us-ascii?Q?5bEBksteKeuwGUZV0PNNDWQX1QEXnFiA/9j2Vno9ERVej1OvUE0jNBuLkNj/?=
 =?us-ascii?Q?3/7Mos71l7+/H0Oux/cBe8Cv6c5vLvmJceljYkxlBnRli9AtVMGcFvSTn7SH?=
 =?us-ascii?Q?DPOEr/lMyaFoBUDAsaMlfnpyfgZxxWToOZ/+gMcnlGwqy5u0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dc6b58-86c2-4ca0-f356-08de53b471ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 21:32:39.9450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enUGkr/t4qUB4ZTnvm+nQvzK0l1+6I3hgZRJnFBw75bqYkt7b7WZLu/5aZqSGswv5icuXdGJrths0c2Xk17Fag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFB3F5C406F
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

[Public]

> -----Original Message-----
> From: Ingyu Jang <ingyujang25@korea.ac.kr>
> Sent: Wednesday, January 14, 2026 11:38 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Ingyu Jang <ingyujang25@korea.ac.kr>
> Subject: [PATCH] drm/amd/pm: remove dead code in
> smu7_patch_dependency_tables_with_leakage()
>
> All smu7_patch_*() functions called in this function always return 0.
> They internally call smu7_patch_ppt_v0_with_vdd_leakage() which is a void
> function with no error paths.
>
> Remove the unnecessary return value checks that can never be true.
>

While you are at it, please make all of the patch functions void.

Alex

> Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 61 ++++---------------
>  1 file changed, 12 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 9b28c07282699..cabf1a5db5e61 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -2784,55 +2784,18 @@ static int smu7_patch_cac_vddc(struct
> pp_hwmgr *hwmgr, struct phm_cac_leakage_ta
>
>  static int smu7_patch_dependency_tables_with_leakage(struct pp_hwmgr
> *hwmgr)  {
> -     int tmp;
> -
> -     tmp =3D smu7_patch_vddc(hwmgr, hwmgr-
> >dyn_state.vddc_dependency_on_sclk);
> -     if (tmp)
> -             return -EINVAL;
> -
> -     tmp =3D smu7_patch_vddc(hwmgr, hwmgr-
> >dyn_state.vddc_dependency_on_mclk);
> -     if (tmp)
> -             return -EINVAL;
> -
> -     tmp =3D smu7_patch_vddc(hwmgr, hwmgr-
> >dyn_state.vddc_dep_on_dal_pwrl);
> -     if (tmp)
> -             return -EINVAL;
> -
> -     tmp =3D smu7_patch_vddci(hwmgr, hwmgr-
> >dyn_state.vddci_dependency_on_mclk);
> -     if (tmp)
> -             return -EINVAL;
> -
> -     tmp =3D smu7_patch_vce_vddc(hwmgr, hwmgr-
> >dyn_state.vce_clock_voltage_dependency_table);
> -     if (tmp)
> -             return -EINVAL;
> -
> -     tmp =3D smu7_patch_uvd_vddc(hwmgr, hwmgr-
> >dyn_state.uvd_clock_voltage_dependency_table);
> -     if (tmp)
> -             return -EINVAL;
> -
> -     tmp =3D smu7_patch_samu_vddc(hwmgr, hwmgr-
> >dyn_state.samu_clock_voltage_dependency_table);
> -     if (tmp)
> -             return -EINVAL;
> -
> -     tmp =3D smu7_patch_acp_vddc(hwmgr, hwmgr-
> >dyn_state.acp_clock_voltage_dependency_table);
> -     if (tmp)
> -             return -EINVAL;
> -
> -     tmp =3D smu7_patch_vddc_shed_limit(hwmgr, hwmgr-
> >dyn_state.vddc_phase_shed_limits_table);
> -     if (tmp)
> -             return -EINVAL;
> -
> -     tmp =3D smu7_patch_limits_vddc(hwmgr, &hwmgr-
> >dyn_state.max_clock_voltage_on_ac);
> -     if (tmp)
> -             return -EINVAL;
> -
> -     tmp =3D smu7_patch_limits_vddc(hwmgr, &hwmgr-
> >dyn_state.max_clock_voltage_on_dc);
> -     if (tmp)
> -             return -EINVAL;
> -
> -     tmp =3D smu7_patch_cac_vddc(hwmgr, hwmgr-
> >dyn_state.cac_leakage_table);
> -     if (tmp)
> -             return -EINVAL;
> +     smu7_patch_vddc(hwmgr, hwmgr-
> >dyn_state.vddc_dependency_on_sclk);
> +     smu7_patch_vddc(hwmgr, hwmgr-
> >dyn_state.vddc_dependency_on_mclk);
> +     smu7_patch_vddc(hwmgr, hwmgr-
> >dyn_state.vddc_dep_on_dal_pwrl);
> +     smu7_patch_vddci(hwmgr, hwmgr-
> >dyn_state.vddci_dependency_on_mclk);
> +     smu7_patch_vce_vddc(hwmgr, hwmgr-
> >dyn_state.vce_clock_voltage_dependency_table);
> +     smu7_patch_uvd_vddc(hwmgr, hwmgr-
> >dyn_state.uvd_clock_voltage_dependency_table);
> +     smu7_patch_samu_vddc(hwmgr, hwmgr-
> >dyn_state.samu_clock_voltage_dependency_table);
> +     smu7_patch_acp_vddc(hwmgr, hwmgr-
> >dyn_state.acp_clock_voltage_dependency_table);
> +     smu7_patch_vddc_shed_limit(hwmgr, hwmgr-
> >dyn_state.vddc_phase_shed_limits_table);
> +     smu7_patch_limits_vddc(hwmgr, &hwmgr-
> >dyn_state.max_clock_voltage_on_ac);
> +     smu7_patch_limits_vddc(hwmgr, &hwmgr-
> >dyn_state.max_clock_voltage_on_dc);
> +     smu7_patch_cac_vddc(hwmgr, hwmgr-
> >dyn_state.cac_leakage_table);
>
>       return 0;
>  }
> --
> 2.34.1

