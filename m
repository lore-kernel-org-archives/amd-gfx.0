Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401BAE83EED
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA25A10E4AD;
	Wed,  4 Feb 2026 08:09:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a57Tpefx";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89BF510E4AD
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 08:09:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcxneyIuA4bm/QhZjaxP38ZYgzoglieRlEIvZaeezUsbCzFq8bDYAbUxKto2W18qlx8YO8syPRJshq9GUGypJ+BF8claivf2pkMoSgDooNi57BQ5V+AuwEYmQDBiI7WSaMDqcIk4ncSeTMJaQl+htYo32Nr12QTa2H68fHV/pBMSY8ESwPELXR6GmqRvYUHoqjB+aorvqdSUDO6kIa3Jzpu7jBCBuHttAV68JY6hneBPWYdJ51lvBDDJ/xS2Y9yBgKLa5qIlHqmrJ9gQn6tz4yYXN2lnMR9zmMGYN4NXB7OwI1Kf8f9qXK8aKddHOJs6e7B5X/emY5inTvpobmNJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8rPuz91lc5Iv6vWtQQ537ks+YBISrukjJelHohkE1U=;
 b=lhazeOlZU4Z5wujunWaiEw99grzxnKh+Bl/kmZY/s1x0fDXQGLJ3Zr1Pbc0LYnHoi/PlCGJKb/K01EuUBozM2+dwyyLOP5BboxkUEXEjJ8DUVnhGDKIKg0YnGa+PwtDqgLGDxaD/4keDGpozVSIgQ/NuGuFGkwGHXUWHq3KrcDSUynR+a5kml5aN+TVmH8qNP6MRTPiyGWWXPVQiG36ShMPNhvYMw/Mom4e3hseEjkOjJBzSXGbVUmeI9GHkR1TnH4rGa5nFiCkqndzc1f9/CVcAHpZwXSn85fNb8hMn4qqAAy0f+Q9J+9xzvg0bgatyheXu+1Lnwvtyc8xAKGj6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8rPuz91lc5Iv6vWtQQ537ks+YBISrukjJelHohkE1U=;
 b=a57TpefxoCfnDArJDeJmFKNTFQMpkU9W5CkmYzRjhR61QaQRx0BjQYS9A9w4HgPWTY9kypFN4yuts+q68r9nogp+WArJHZsJ0viMY39Dy4xMAa+mOZjhjfwXPOFynQiUGw+ESyKcBzFXTqYZfBoKsNSZfIZY92z1JiBCZlcpcgg=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by LV0PR12MB999094.namprd12.prod.outlook.com (2603:10b6:408:32e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:09:26 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%3]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:09:26 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Use correct check to skip setting in multi-vf
Thread-Topic: [PATCH] drm/amd/pm: Use correct check to skip setting in multi-vf
Thread-Index: AQHclavZUWjyvAwG30SOr5YRa9cnrbVyLjvA
Date: Wed, 4 Feb 2026 08:09:26 +0000
Message-ID: <PH7PR12MB599775EAD51A423FB9E7F1278298A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20260204075638.3797505-1-asad.kamal@amd.com>
In-Reply-To: <20260204075638.3797505-1-asad.kamal@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-04T08:03:46.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|LV0PR12MB999094:EE_
x-ms-office365-filtering-correlation-id: 882c69f8-edfb-4e1c-cef8-08de63c4b6bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?aGi+ETNyTBt4+ciomzjaogaa7Gf5QHK0feZEsbmftOWIqtHbO/VVNfXR4EF3?=
 =?us-ascii?Q?8hRZzQC9VlBcmNnW56CPHPAz2DSHoiWIAin8sE4FYiMFmAIw1h8+BtbHwpJT?=
 =?us-ascii?Q?OnKa0W+KQYPncWGlQOKrlkbtgjD+gTaSlqNm+eWHkdJrMpcvbsEcEM/Wgypw?=
 =?us-ascii?Q?Dcj4zDfdarP4eUL01s5Aue1+lPmEOwMuVKU/k/oWSWmrMUWu8zsRsqY6yZWV?=
 =?us-ascii?Q?sV+kq430qNWAErxMlvnWdv8CRlHxpQmd2u3+igaJPvuT48FTi13lVTkCK0Qe?=
 =?us-ascii?Q?tPfri/ALHn5FLNFzUclMbtd3EdNlXSa2YDkd1lC9FGuGSjZdpUs6xy9ISEbO?=
 =?us-ascii?Q?t57MMs6RSqEBXJ5oBNwe8f1nxViQLYWNosBWpFmlwdirrcSShD57/TlAD16q?=
 =?us-ascii?Q?Q6nTbFduyoaHUJnCbOtw063SnB3fTdXl87yNqbsIxSB+IM89rnugEKaiXT12?=
 =?us-ascii?Q?qMGz2isE5rGqwOnMXtD9Kk9N3r/lzmeM4iaMJq2KFA5RGOSZklB0j4G92E9o?=
 =?us-ascii?Q?2NpKX7dQGWqXqyHP7nv/4VS90QEsr3Kn2oYLEGev4HnXzmbOdAlmlWIVoD+Y?=
 =?us-ascii?Q?aHkz2MlgdHysrievWXQZOxg7OF+9mz8dtdr6wqjqQ6eG+FFYmh/q9SxFGf2p?=
 =?us-ascii?Q?YJQQWRNbkgeUvJNOuGVUZ44i+no6CXAzRv5t35k7oi3kyk70Vrwk78CHITdb?=
 =?us-ascii?Q?w8WYGsMuZy5PyMBsxJs42I7c4C0IuKuNxEsAwhf8afqL1dYVb1U48W9rs2qL?=
 =?us-ascii?Q?sw7luBRMvGJewiuZlij04dC0hULacwdWRVOY9Dx++ci2Xs2gNC1smUewvl67?=
 =?us-ascii?Q?yt9YRWFbshZJmn8efO8ow4G51T+kJ/6Y6k9unwHolUnMb7CQ9mblBT9w/qkd?=
 =?us-ascii?Q?f0JKT6zRHurxqn+QzkjsLfSQQ7UMH44StvgzsCPzjj2oDri2KNlAeuVoHhio?=
 =?us-ascii?Q?9/IsbAZk0lXj2otGHkQpgVQciJIdYxCL7eLlLG028bsEqrkL+LKXrHafBanq?=
 =?us-ascii?Q?fhB7lVJf6H3/PfFFdx0RKHeJpjc8/uVZE0dkk6limnHKusIB+Q9LrF4Ygvpi?=
 =?us-ascii?Q?q6zPqoZ9rl57+LxB4i9N6gUnrdw8MsUVoBJFUnl17LOoJuwzlPf8x3YSNXhP?=
 =?us-ascii?Q?qjJ3ijgykRYVQcb0dX+PZf5RckinpG2tA7+bn+Pi1lXP0WAuwV13qMMYGFTt?=
 =?us-ascii?Q?gPutASG9z22N4rV8DCD5yNxTqPgHglue0pT6PGaLSGGfWDixFxaalDd0z24E?=
 =?us-ascii?Q?sEoaNO1fRDKGFYxI+FyypYKP1HaAaDxBACMffWjRaD7AIS6J0glXPirtl7/c?=
 =?us-ascii?Q?nxsO5Zk+naDvqCY6vMUqQHH9v1Irt7uH8GMQqev/ctxw9y0Mz/aj4G23QZd6?=
 =?us-ascii?Q?aqRaAgBYL8hz522pJ3CnBZum6siqr3NX+qcQzve8bXeFQYtddSY09uloZJ3E?=
 =?us-ascii?Q?ia0vO8olYbMgoMKXAX0A4xtxh2oWmFo/fiMndM51EMunaRm7Hy31RhOs/Zpx?=
 =?us-ascii?Q?5e5mrt/7yohdkls8RAD8pMv6BRzKq+4OV+yjMlXDJjukRL4qskcWZi1ccjNm?=
 =?us-ascii?Q?4hlH6TmPK4di9c0ZC0GCjAqntOfwNJrT/eutMpr3PRi3O0L1dmd/19g6Ihio?=
 =?us-ascii?Q?P62gGSrwa/wLPzWggAt4XMk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fDJcCJ1dqMCz7814YmqAPShjJQj5oq0gC2PwPK/e8JNXfhN1HDHarko6sXZ/?=
 =?us-ascii?Q?IwalGIMjTT54vX9o74AGWM4LFOgN34SFtWTPPt63DO2IMdABFZgP8WS+z/kH?=
 =?us-ascii?Q?17bKPtmYSZV01EAjDFpSVxsZE5LhKJd3+vvt8V65YBtuKZpsAQzhGL93Y4Cs?=
 =?us-ascii?Q?eI88LZs14hK2f0CThqcudSGSs/wx63aY2BU0lV6JVrJTRc7eySqoPwktbJTv?=
 =?us-ascii?Q?en4idqEgvPF2MBSkAiqyIDetiVWYXiidYxb/WqqxUatx8y1gRrHPGcTChN/J?=
 =?us-ascii?Q?SKR6Js9vItYCYVAXhgnXgewxQM6mA7G+YFKEfYDt69qqmBVzozSZ2/05rE0l?=
 =?us-ascii?Q?joq0pvGOQaLbhAcvdvvwwzcdv9qyueUY/WSjDFZu2a7fHLJmMXj+9Da5PvRq?=
 =?us-ascii?Q?U7D0E1YDen/k/sjFva36/UXKbHvApuBPvY7qFCsUp3Qd1sHiDNv75MOt4yaM?=
 =?us-ascii?Q?nfgF8JAqcmS6oBBb/7NbNeTsIVWhxIPsvivDjOtkTTjZTpkaoQR/oytAfwv1?=
 =?us-ascii?Q?/enZM82s2MbZ6vplLPqpaAnlrMUioJ5bOMn2KUE/+KqZ7JVDSuT+O61dfCFp?=
 =?us-ascii?Q?2U6OJG2ff67Sqa0sNPtCz3sNnQgw22qlQp/GQ5o5LJdgH39WFhhyhmtI8tRu?=
 =?us-ascii?Q?E1mkrKi231G0sFv7PQlQOeIJvBT9NoFi9Gj4Bk/M+CupEIeyZr0Y/4IvzC9G?=
 =?us-ascii?Q?P2dV6Oudklket/h84dlp2gogTdLsjzl1lKgbVZBzdWkptgddw/4W95Qp8XKB?=
 =?us-ascii?Q?OStEjXRpvTAlKtjJB7vlOLKbfniE7DDZUGmUB40B6KclM8h2Hy05oLgHL58o?=
 =?us-ascii?Q?OBs8TFJJ9VtRoPhBCz/JCoZDhSv01v2KSHCOPjUeU4KLfgf6y7mZLXCUFyok?=
 =?us-ascii?Q?yQZVAp1eV2kwiy+b0HVkmKBvGerEyCeMYpCMghJA0NW2M5ksL1LI/mDTz0Z6?=
 =?us-ascii?Q?ATLIZt93YJtbLqhAjOkZyVMelFhiYmge8jMkl2h48vgWyI/XMSlpI7+u4s+Z?=
 =?us-ascii?Q?elWZJHfTDpBmdGtEBjwPc2BHkKjRkyszHPAzNOoIzCW/+UBicsqZy0O207bT?=
 =?us-ascii?Q?gp06nJtGUH0VAsoTuecv54Az5xBvqF1RD8ARfFaBNYadK1BV7eipiw51Zn41?=
 =?us-ascii?Q?ruWa7MFhEXL1dm+U3TmW1cC1X5wLzAGTKqGIVG5lBWkzWfqRpSeyCEOHdHNm?=
 =?us-ascii?Q?MwfdDLYVzehpfy9lhBAnVaciS57eNMI6a0mHZwgzNnj6VTbuoLx9c32bUa8K?=
 =?us-ascii?Q?w7aTjhFRe947sVq2h/aaoNYCUKNASLo3qM90ufWr2BCLaXrHquCvTcLC7a3U?=
 =?us-ascii?Q?UBOB8oqPGfQ3kZrnkOMwNZtTYV2DkpwVCdwo8z2y7VGJrbi0UE/IE4LpB0FX?=
 =?us-ascii?Q?0Swwy6XtaI2u2t7i4Jtrt56bdnslI9IbB7V2/xQB9aI7gBXVZ6xguiYJO2ap?=
 =?us-ascii?Q?cB1TnTHjeYOHtLHAg9UNnZ9lktOIy7ldF56qnSVj6CBf4qFHtZspfFMd/gc1?=
 =?us-ascii?Q?x94l3gLYw323I9aWcf9NWeyRbgNxoTEuiGgP0PIsThmfDVZWaeeVUfqD7zp/?=
 =?us-ascii?Q?RzXJkfLlFbMdmdPzXWR61aGOromoS/fvi7l7/Y5nZ8fFBZzYa0FSldQ5Y5eS?=
 =?us-ascii?Q?ZfZnn4N2ArXvrjoDtZG1yc5VAJj7ekqMKZT4sbAMS/s57vM1C3SVr2b4hflp?=
 =?us-ascii?Q?WyWtMXoj8fpMioQjDI1cR9vP38BcO7UDEf1M0veIFcg5e/rX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882c69f8-edfb-4e1c-cef8-08de63c4b6bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:09:26.3895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jzeDPbwQrMmHPOLIt6hAwlPSUmB/31+q6fqGeB8IWagndETBIcO9bOOlGoLMQ+Xc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999094
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

This code path should be explicitly droped, as the mask value is required t=
o be 0 in multi-VF cases, which would result in an immediate return from th=
e function anyway.

          case SRIOV_VF_MODE_MULTI_VF:
                  mask =3D 0;
                  break;

          if (!(attr->flags & mask)) {
                  *states =3D ATTR_STATE_UNSUPPORTED;
                  return 0;
          }

Best Regards,
Kevin

-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Wednesday, February 4, 2026 3:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Use correct check to skip setting in multi-vf

Use correct check to prevent pp clock setting in multi-vf mode

Fixes: 166a3c735c95 ("drm/amd/pm: centralize all pp_dpm_xxx attribute nodes=
 update cb")

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 07641c9413d2..6dac116eb492 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2058,7 +2058,7 @@ static int pp_dpm_clk_default_attr_update(struct amdg=
pu_device *adev, struct amd
        }

        /* setting should not be allowed from VF if not in one VF mode */
-       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_is_pp_one_vf(adev)) {
+       if (amdgpu_sriov_multi_vf_mode(adev)) {
                dev_attr->attr.mode &=3D ~S_IWUGO;
                dev_attr->store =3D NULL;
        }
--
2.46.0

