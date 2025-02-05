Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F92C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 10:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB59710E776;
	Wed,  5 Feb 2025 10:43:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Oe/rFzvO";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2699B10E141
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 09:08:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8t+zQ13nk0Qtx6wRayoVJ8m9MBB9V67l2mjebBDmZqoFgsUhWNjPcfD9Vv72MjuWRmVr4FhyIzyYU6RwubeVQiFl912vZAtSb7gITNm0+oHLz7E1OckHd0K6aR6NUYF6iz29pTukC1fmH/nM/b/9z5pGMeQPO6oqln1yNFCTX6QRsPLpQKFdkhQnXB6ZelFsXmrQ/aV8kKCJl5w3IuDn2gMOCXJf4WwNOp5jNmsD7/dgbQroGNxaVU6nTDGLy1nJDQitqYVITgrt341H7Prpiq80kXeluWPtUe/mwEeDtScGtRVKu5ZM4aGDDAewjJf2ASOl3Bl60dHr7aOGW0vcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LD31uveTRhJA17Mg1YSTC0nB09WOa93B6MqKRbe2X4=;
 b=r/io431i3HaJCGWdeXeL4t7bisvKPah0VHePg0syOA47PIeBVMHTfkpun5XtO0EIo2v+SE2IOh6YPkLm0sOsVQfiAOVXMsTN4VAQVSAFRvWD2ytH3bBcSPk0/rZZrproCtHczNsxVxxlV923e87xdcIVFk8Gl1AVe8YrEb9sTekgn8MDJSkxpy0un9iXVMLonilx9KIu5QfgDO4fepDPboG1lPYIccAyq4wQ1AVgzX6yYKMMTvDiJHSiI0N/pnnyxmLAspVuNWSrgfyOW4OamRO/Ehup+oh+B8pHnPIvrMIqkkA4jr6bYeTM5yZ1V8ddO+f3WB57gqQ6iuudI6G7aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LD31uveTRhJA17Mg1YSTC0nB09WOa93B6MqKRbe2X4=;
 b=Oe/rFzvOlUhSSI/OBkndfRca4NItUBeqER5JQlw7EzTG2iJ0PPRuZqKE+8s+5GF1HZ/RZRe9O8jnyUHSIHvZg5R4vSSMKNgx3BVwRpNNAVjC9jA4Dt698nERnrIspbugVHEUZj9CDHLFb16hqSwLE052PlGhBmYMAnxdVepoi1Q=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.24; Wed, 5 Feb 2025 09:08:22 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%5]) with mapi id 15.20.8422.009; Wed, 5 Feb 2025
 09:08:22 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sdma4: drop gfxoff calls in dump ip state
Thread-Topic: [PATCH] drm/amdgpu/sdma4: drop gfxoff calls in dump ip state
Thread-Index: AQHbdlIFbFwsFLKSakiOJ8cvaae0xLM4bj9w
Date: Wed, 5 Feb 2025 09:08:22 +0000
Message-ID: <DM4PR12MB5165B53A9FF6DBC2D11CC0518EF72@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20250203154031.2824949-1-alexander.deucher@amd.com>
In-Reply-To: <20250203154031.2824949-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=da284d8c-ab14-4e3a-a36a-b347701863aa;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-05T09:07:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|DM4PR12MB6160:EE_
x-ms-office365-filtering-correlation-id: 0961ac6b-7952-44ed-800a-08dd45c4a421
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RjRR9dCeJdBEQvhYAUTlhrI8aeN+h5FuoqoMroiq4+bEjJ+qexfQB4ZzkFep?=
 =?us-ascii?Q?rt0pFwO2q2uTpvzdUQyIb8q0lcs6rTtNE0YusgUk/RzghasxADX/K+WLiitC?=
 =?us-ascii?Q?dzVKazwDBTQQWntwncscbYallpPKbOrL9O1zpTSDJMOT/zF3Pw3AActbUaud?=
 =?us-ascii?Q?UlNBg5u6mULHUY9zY75BH9wGykBHF7vjvljIc8XUA8GpaVHuhpLBo7mEKAFq?=
 =?us-ascii?Q?NEovdWw3OxffiCZ6XzCH0Vz7+X4v4hhkMqJ14lpKJODzcwNoS2VofKu4Cd29?=
 =?us-ascii?Q?suCZlIrVRGa740Y/dUneK3lKzV+2cBHDO52fALnD2CDZNqYnNenD8UFLeCWL?=
 =?us-ascii?Q?nTe9djk11jDF2UNYEaPBPJQAtTW7T9w/gyVv5ZwuMTr9IBKzxmSz/FpfIMdC?=
 =?us-ascii?Q?O22GbE3MRM8dI2vrwoWMQI8RPNx8g4iCZ+nvKk3HluszoaHkVZfJhO5qPZxE?=
 =?us-ascii?Q?96XLIZa5yM8OmIp86MjxHSV23kOHlkDR62Agq/fLnz5KWnSb0Avq+sXCfQSp?=
 =?us-ascii?Q?mEFUB45hrBC7zwPcaHlAZvTTkJZjL901dqeI18dRW0qT4/XBio7DGcQ/qv2v?=
 =?us-ascii?Q?7f2KmVzo21VdDRtbR8bcAqa+iA0JOJx4A8UJ5txrJlTQsRG2m+/ACiPX/+u+?=
 =?us-ascii?Q?4Zber0dwOQxWahathVs3XVrH4qwmGxzVLzTNiv7Z3f6bQBfD0fygo2iP+7he?=
 =?us-ascii?Q?3M7Ixg1XijSQs4xBiqztax5Qmpz4xeROmWO9ty+Ic8NlwnYhzjPgXbrVqk9U?=
 =?us-ascii?Q?EZGhFZ+noCrIZ8YylQR6FWSBjcIIfkIjBZg32NuI+Mh03zQLCoP/oH5XKb60?=
 =?us-ascii?Q?gQ+Vmryg9pHAtrhgBhl5xDuwkOtrArKjX4RwkVrRJ6o5BzSGCi6R0C1e6Z3x?=
 =?us-ascii?Q?uVq9HMMQG/fhiVtBQQLcnK/UuiZvvLdcw4lHkUefoPl045fbx8TpL9ADnGp2?=
 =?us-ascii?Q?eUMekKWLCkI9lf8tUDfL79gvqLgYTga9Pb1yBeEPspjYd+nIYM1Yx1DRHA6/?=
 =?us-ascii?Q?IUQKdaj5OrNOIVeOEzJfH/dYI9/Q/3Ja3BcYQL2Zd1SG/zA5tNz9vbW7caeu?=
 =?us-ascii?Q?LruMDeOPgnFtgG+4R8NwxVGvnR1pFt3LR+qUPXG6wHz/DwEA6Ky3Qrn5D1BJ?=
 =?us-ascii?Q?3nR/lqB9/3KAuCLcnUs2/lMsgHcsWK9dWqJ4GTPHkI+xdLx23mmk4Qlf9toV?=
 =?us-ascii?Q?u78WLIoc2LsE/R11ouQpXgI98+wQ0VqfvIDhhEBnJXzdSkErbome/wDTc3YZ?=
 =?us-ascii?Q?/QZKBRbEYZxh/H5SVxeO+LbNFQD6XRfEC98/KBKdwPi0/eewK7ASNKbdJy5B?=
 =?us-ascii?Q?eZmOnI2VOnjuezW9P8wD+a4wt0g2Uj0DtplOoNovLecpNcXZWpwuRouZ7DDn?=
 =?us-ascii?Q?zQBaBjyqeplwakTylqzsT05p5+CpVgVRT60e1YT8uSFL7gKRhuFxeZVF/C4Y?=
 =?us-ascii?Q?MyGsDaW9/HDcdbknkQS8zOpUtAgnlUEj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lzxhgfvPrGE6xChhf+kZmZ6AlbyL4X3V15Dnc1hm4apZ9Rs/xr3/cgntKClA?=
 =?us-ascii?Q?lP1KYDArSlGa4m1A9WRKefcpoiclXuq+6a3c5Lc9vL36YQxSrmswWw2zcJ3O?=
 =?us-ascii?Q?ZpX3mtBMcvLb1Z+EbBGKoRr0Svd7PmruzV9DhJYEUASZkaZH1TrJuu7pUlGH?=
 =?us-ascii?Q?xXesqAKBZuufuGN4np5fcCfOO/YcJVzQTaZH42a332/mk1xM25fMjui4IWCO?=
 =?us-ascii?Q?TEgEW7xqXDn4qnT3p2B+uRaa6OioMWs84Xz6jFa/XQo23NOE4xBUxwwN3zGZ?=
 =?us-ascii?Q?Qujo1GWfwu9W1Wvsyb9sdE7oXVTfsJ05Cig36SD5fZ/nsgT1osF7nRLMJorG?=
 =?us-ascii?Q?SNrgajLzcrgZmxh9msumuYuTLm1Mr7ytZb209KYpINbC8ZNgq/ueqOIzO81R?=
 =?us-ascii?Q?8P97yJqdgQb91ri4kjBmWvosma/BjxR0qD2mQquY4O1a53Px6pkFKOboJPag?=
 =?us-ascii?Q?7bvm7Hw2LHrNo3s8T1VhXZxKeXBa/fWSePBgco73XbycbL9ax7eJLBU6q+7d?=
 =?us-ascii?Q?YmsSX0rHl5bQbr/+5UZPtviS4m65+FzyV5gswTCppP/t12T4a8uT+QwAJlIG?=
 =?us-ascii?Q?XqjS0C6ouZED97bTcxqeJIQffjXlyY3NECzcHAmrtby11E02FINUKldnMDcb?=
 =?us-ascii?Q?ausi3Imwnit2REm3AUfg8hGmrI8zTVwZJunutgp+JH/LZKrxoodWyyy0SExR?=
 =?us-ascii?Q?ZYx9yGq4yrQvj5fJXh4S58XYV0r/lCq+CL7GVLfayD+ozFsVVDVPAOVPI37I?=
 =?us-ascii?Q?5hxSk/UZaYrKbxSfHYtxxeRmymzFzSDSSrtVBLqMqTLNAXocHf13IYPXUOvu?=
 =?us-ascii?Q?UIzytur92sXI5wybkXzwPPxiVbixHr94WJ6jb4PEiYeSuiXf5mdLC6NgNNul?=
 =?us-ascii?Q?snig9t+l7Lghf0ADqCM5h4y7Qm6OYzAAJKfLNGzIi96esF/P0PFF6PvVPxHg?=
 =?us-ascii?Q?8IYfMZ023KjRI3Nrry1bWIlPM/bp5yumNB7EKPCVf2xiJ75aaNRpqGdY/3wa?=
 =?us-ascii?Q?G/+QoL+OEW4xcBqamIkBBvKIe+7+ChR16Y1YhOaf5hcAUUQwocjayyHTuBV/?=
 =?us-ascii?Q?ocDY07Jw0aTjgHMTohJSvePeE/as93B4JRRs8OlGNUFVOitJ5tdRDFArVKK+?=
 =?us-ascii?Q?ZNiQkKgtevDexXzmm/rbMtQvyqGRqoK3//gCzKJVuPdWEvTYVzk3qVxxxaRy?=
 =?us-ascii?Q?CGxKZvFzIa2nVu7NngzumiwrLrsI9BKHXAd/O4EzPjTk2qf7Dte62Pv7w9fU?=
 =?us-ascii?Q?coaG+alhJLgeYsMG7FM814WT75HUgdPyXhoX3oI1RXbmJvQHvOH8rqHXHtqs?=
 =?us-ascii?Q?yvfXccUNO99BaUZKzGSJsZXcGTmO+V6YYZi0orh2x9s7aX+R25i+NgXMw/jn?=
 =?us-ascii?Q?9LgoWeXyibwRlupRE+iRDs2DByw/zasi6EcXPgBv/uOvY26d2bqGiWiclsWf?=
 =?us-ascii?Q?DbyL3Px42LVoa2RSuN6URjQcCvGUJe5LuRUvD2SrxFzV+AnKqMd8ZcZ4EYGi?=
 =?us-ascii?Q?tzST2oGP3BwpQA/epqv7fHJSC/bV3ydCkTf4IG3wmFG44G2DLyVeUgBwdkAj?=
 =?us-ascii?Q?lqtHoDyqJZ7d1N/1wPg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0961ac6b-7952-44ed-800a-08dd45c4a421
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 09:08:22.5985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RK6VjkhUBQDNCMXoyh+DOUXWjVJJuKOthhMKYm7+yUXwKhRXGFVI987jC2Y0qy+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160
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

Reviewed-by: Kenneth Feng kenneth.feng@amd.com


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Monday, February 3, 2025 11:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma4: drop gfxoff calls in dump ip state

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


SDMA 4.x is not part of the GFX power domain so this is not necessary.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index b48d9c0b2e1c3..ea42fb10d2076 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2381,7 +2381,6 @@ static void sdma_v4_0_dump_ip_state(struct amdgpu_ip_=
block *ip_block)
        if (!adev->sdma.ip_dump)
                return;

-       amdgpu_gfx_off_ctrl(adev, false);
        for (i =3D 0; i < adev->sdma.num_instances; i++) {
                instance_offset =3D i * reg_count;
                for (j =3D 0; j < reg_count; j++) @@ -2389,7 +2388,6 @@ sta=
tic void sdma_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
                                RREG32(sdma_v4_0_get_reg_offset(adev, i,
                                       sdma_reg_list_4_0[j].reg_offset));
        }
-       amdgpu_gfx_off_ctrl(adev, true);
 }

 const struct amd_ip_funcs sdma_v4_0_ip_funcs =3D {
--
2.48.1

