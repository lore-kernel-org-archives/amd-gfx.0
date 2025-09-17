Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1931FCAC598
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 01:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6309810E3ED;
	Wed, 17 Sep 2025 01:15:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WrTgtCTp";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010024.outbound.protection.outlook.com
 [40.93.198.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD1FF10E3ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 01:15:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThrkwY358NKUc4R1SnvYUIhArBA8l0JmeP+FzwavVCtzQvRcqKD5Qucuds18McI7iT5gJiaXDh6GaYt+hT2NFAvMDMPF09AO506o9CIFI994JZcV15DUm166cfD/KN/+hCsoGpMNcOfT1X7rAlYamTR1iIZREPwq8nQHnE9KNninCfkmSdyt4k7EyF8wK/r47YZcnCLi/SjACdtLmLn3ttjL34B3Fflzj74Kcy7Y9AP+XWUv2OZN3WnT5+zWwtoKFWBhA6OzIZqczV89MK0j7RUGu8CARaEcWdIEQL81oCYSbkktGwjIFxxEjz2GxYzSfMoqrk9ephoG79/imIAwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jzxk8v96/L4HDj/T4nanzOnQHqDhgDE+nGtIR1xwLng=;
 b=jP0Yztl+Ad8kI7NX2ItcCOZydIvqwJfr7UPtoQzMVtjbimfRCDwYHmDQKqvqsPmievBk2g1EHtRW9/r5Cosee5i7FRsbzblE6FOOogJZNPeHAaln6nX1i7acb8TVg9O04NpLItctv90awj8x/xTc7MnmbIYhIaWN2QGvgUV5Oi7CJ6RGcqoTknt6NsfQ6uovkuKJVXoEpvgKHEVTOR66Gfjsde3eXnwyzVd8fB8KQiuSLV9mrxlFWy3ZTaspaHaA8v1vq3j4waLKeBcmKyjJPFnlpFlFJJToUdBGtamoMf6hiRa+cQX05BxmEhxBKNmGDzJtj5MDrV3xEvAn4EkXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jzxk8v96/L4HDj/T4nanzOnQHqDhgDE+nGtIR1xwLng=;
 b=WrTgtCTpcLsTsJ5dZKLLshyTGleQIMw8GfiS9WqicqkWxfe2s47iPlRKLhMRf0dPZSinHtihpHekY/djIN56jZVJBm3xurjiWE6Tp7V2zB37kvk8d/a3sTOhRKj4TxP0C38nrBmADXMuWxRXGDkqmNCVrxgQj91GI8U/o1MuI4s=
Received: from CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14)
 by LV8PR12MB9689.namprd12.prod.outlook.com (2603:10b6:408:296::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 01:15:04 +0000
Received: from CY8PR12MB7657.namprd12.prod.outlook.com
 ([fe80::dc50:9698:ac9a:b44b]) by CY8PR12MB7657.namprd12.prod.outlook.com
 ([fe80::dc50:9698:ac9a:b44b%5]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 01:15:04 +0000
From: "Gande, Shravan kumar" <Shravankumar.Gande@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Liu, Xiang(Dean)"
 <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS
 poison injection
Thread-Topic: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS
 poison injection
Thread-Index: AQHcEMnHb9eQhaVCNUiZtjHvLhyIMLRpeHOwgC1G5xA=
Date: Wed, 17 Sep 2025 01:15:03 +0000
Message-ID: <CY8PR12MB7657A896AB19ACF83F7224DF8B17A@CY8PR12MB7657.namprd12.prod.outlook.com>
References: <20250819052548.124897-1-xiang.liu@amd.com>
 <20250819052548.124897-2-xiang.liu@amd.com>
 <BN9PR12MB5257589DCD61DB49E52EE54BFC30A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257589DCD61DB49E52EE54BFC30A@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-19T05:49:23.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7657:EE_|LV8PR12MB9689:EE_
x-ms-office365-filtering-correlation-id: bc7fc68e-3f2a-4f9e-b04c-08ddf587a1bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?56fInPy0VsJMqSwn47t7QZ9US5jkE6/acnBcGrnlG/6B4PcoFJKxAvezOy4N?=
 =?us-ascii?Q?VVjP1DnLM9kh1sdp5J2sVtC+nDH0RIY/V0XnJxgz4XE/VH3pOwzofotDyuQp?=
 =?us-ascii?Q?Z5ZPF54gyd/uL2ONhPk4qOee64/SMfV6kn2sKUFqeELdTYxYpWOyNO7qiuSw?=
 =?us-ascii?Q?1nbged5CpF6SGdLXRunMsoK5N2MCS0BLiWWA1eUsjAo5/DK9B2BveUai9/ad?=
 =?us-ascii?Q?dZLG+dj4G2f8w4jNFcji6+NLxHLsKW7U4pQaytwADzFvJ8Etz2vW04LxePjq?=
 =?us-ascii?Q?Sd8DhLYEPJOJaRE4Z/GZstRYnerpsCDnexvJwwo9jPyTLWMjV4m++GDk1HfV?=
 =?us-ascii?Q?Q4pytmQeUYP+V4ohSOsecks9pv2Te7eWcqytmGNK0Rc5gOH8Q6A0SxnX5t9M?=
 =?us-ascii?Q?pn18V515BNIcqx5nhHpe1qZjJlwIbYjn5ZRQqndy8mc2CYaLdtyleJwgtajz?=
 =?us-ascii?Q?SOwPgU/7Ig0fON4GqSw/1hUQN36bFKDzUGnL5ldqobDVaPEieFe1RzejIbLN?=
 =?us-ascii?Q?2PMjEBpl54IECcFq8nZ+OTNC3LNN7WqJ+YhoJ2AfPf8Q7E1awVykT/gGaUtc?=
 =?us-ascii?Q?7uTIhJvwUcX0Fex9KokXzUsDUAtJba83b7tcMYtjItbJcmDEhh6MaPhGNXf+?=
 =?us-ascii?Q?101Kp8ghrOpi+cnJGVuZVq35Q5Ok6EEoO8CYH1mWiM72C3lwBvAvtyP3FHJ/?=
 =?us-ascii?Q?IAV8X2glPcrPD9FL+ECDShUCykCl5G9yNcmHr8mgSgxpUa/YRnroKXF4QUrj?=
 =?us-ascii?Q?9/nj4MRhEZjn0JnGYmbJE1TLNmKPdWKU1P83a+JIG1PPd6U6Hd2v3asCZLRV?=
 =?us-ascii?Q?wq1F3HMn1eQ69PU5eiHLff7SsNcwqX8nYIoESW/vDFjxTdwrlAuOv//mU+IW?=
 =?us-ascii?Q?AOAQ0wxYNc0FhxZT3Y4cNJ257ZRGqfkeTbeNOAANXIjpACcMT4dLsaU1V4V/?=
 =?us-ascii?Q?+1J1p4hK7j7m5a/c4ZL1yIjGHrU4KRxjL6na3o4rEDIL6rMZcgxo5mSPDKrB?=
 =?us-ascii?Q?XJqNdsiRYOAKTLbwFkynThJtBoYA7WKxclQew4g0IjqyyIL6cD82IFrCgVEZ?=
 =?us-ascii?Q?gSVU57i5oiiwdICSo2xrQar9zPQ0C8qx7MP4wjyGl28qJM0gKDzd1i+wFmBS?=
 =?us-ascii?Q?NPJJCoDTfBYYf/WnjFLwVwATqHoKiffTwVnBq/cp1zFrwy+flwBtCY7gd4ng?=
 =?us-ascii?Q?6QJL4/Jn9JpVI07RhJMDluFMiwflsAj3evOYdicI1Ko2DydiPUcY5fs5el7J?=
 =?us-ascii?Q?qqy8h4eKkg9c7UFKtBSdmx84t8FQaFCe+qxbN0/34tpvkdmgZkMiD26opA60?=
 =?us-ascii?Q?Ioyaa4pUOCdrUZ79qa8TNfINc/62j4H980r/roT3ZpsfMKSHphWHU2kgIfTX?=
 =?us-ascii?Q?5ayv072gsd1vY03s5gEVr1PkrNY6zQAMXSD2T6I0C6rBD1SSc8+M735wKimT?=
 =?us-ascii?Q?luzeCzUsdKS1QX10majRrUk+kr4aHH8o5Dm543iAECwETRhtobUBJkq7wpvD?=
 =?us-ascii?Q?s7Zo6byUMPAL9Xg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZYkcwg5Y8tvcsJ6PMalb2Nb4FeeA51j9zsGj75xp6ew0KM4yOHtDCH2JY47i?=
 =?us-ascii?Q?BrmfSCUK7DDuguqNZAFbLiZeUrE6yPv8V9Qr4GmCUkB+iCXp2x3UsIkt9brN?=
 =?us-ascii?Q?OO+2msBUW3d0isirm+dUhcKYJO21VHWt76+hSY9XwD3qS8jgYbd1Gf6lbyfm?=
 =?us-ascii?Q?ciRcsyjSoMXY7JAWpDDXk+qItB8gtlHyW9T3YaMCJxUfAAUXGeN567gdDZUw?=
 =?us-ascii?Q?LgmIL7Zj6kM7zmnFOfUrOj93f5mI0liUhjZwPsPburNmo2HnrGgJxpHjSGy+?=
 =?us-ascii?Q?POcgJxW+iVqnblWvQx9DZ+JZGfHEiu74W2cn7ukskpA1lNuCmR7CBf5s3tnF?=
 =?us-ascii?Q?+G30KSN4nT4EyBcgTjDit44t5DciJRPAbpPoXGMlm9XxnQkg7bcqa3z+r1x6?=
 =?us-ascii?Q?ME1ks8CpnpS4yVqfvNny7bCUytFRHhepUkZwNOOq2OtuvfJnZcAg26x9s/q1?=
 =?us-ascii?Q?edDKfOULYyTI2Ehd6BW6ztMYoDk6K6tYS16l+CMKid7/RrQ5FWgpl9Fm19gq?=
 =?us-ascii?Q?kXygvZkhjVfH56UeCYbdSvoL5TerKGn8mh3J/6WJCXD/7t5/WD8xyu4Q9p7Y?=
 =?us-ascii?Q?DIrfaEBoCkOoUSzbUmz2I1jPcRFPwwqpQKnQJTVzoKsPMPGbD54JBK74gvOM?=
 =?us-ascii?Q?pok5saqfFmiN65nAl1XYDMWNxANCXXqVascGyhb9kmb8JiuJlwZ6NoON665l?=
 =?us-ascii?Q?RVJENqJLJ4cVYxsNmp5jdEVBQ1ncTulH/lezF0jU8T8L+BJ03S5DnL+hKBT6?=
 =?us-ascii?Q?Zdpe1x/eRhA9cYPIwNuazqQAsUh+mqrzVRy8alZin0uQ5h3timUGejW/WNdY?=
 =?us-ascii?Q?S0cLDgmghw8+t4d+4jDT1wgn1Aif+sbQ/OJHnpzn39rZchQ0110YE9iztq2n?=
 =?us-ascii?Q?FsHITtfBgwjbQpiGfgH9jOKWMEp3OSre642uWVWNci9b5AVD7DKUlOVnvWoj?=
 =?us-ascii?Q?cmzn2lY1TII1AA/RQvkRfAF0y2VeUrQYkjttAWgnsXEUc0KjSrJO4suXTeSP?=
 =?us-ascii?Q?UW2GOdGVHwWtX9c9VE89ekzojANHBK/l4v7zVVboBzcaTrpHu/3jlKNSIacA?=
 =?us-ascii?Q?2e8gScstKTBLJ8btuI/aVPjOPoKRXLVFNwAO13aNaEcdZbJk5BbFe6vsB1V4?=
 =?us-ascii?Q?bfr4uKG1ObIMKmXS02cR+lGeXXFtZw+us0CDIpHc4ibgTGuUrQYNkb4nq0gX?=
 =?us-ascii?Q?dkwoGYBRsJef508MQ+LSL7/BgMefd3kzKUVJyjcew5QsFShHQJt/9eERN2L2?=
 =?us-ascii?Q?cBZnMfUZZuE945b+/e5f6W9OurBnJ0T8llT+7Ao5Pmj13A4GypfyA+EHHEqA?=
 =?us-ascii?Q?sSsSY9R9wKqQQsjN3R7nzHWFK8Tk2IKRNKm1+BraJ/B+8+CmGu8NvjHJvoz/?=
 =?us-ascii?Q?zxzriDMr3k2F+atk9I3UHOnH1tXSwXHjOcRRDVEKqsUohXz1OE3OKUx3vUnr?=
 =?us-ascii?Q?riTaYe9IyZJOZ8aPLKFZDU9Z6671w3Pkgi24t+vVra3WYLHNWa6L1URub6fU?=
 =?us-ascii?Q?Mzr2GAy1O16X2gzsCaWt9hV2TX/t4zxbg9IaJr8D+npphh/J9dss1+riqIeq?=
 =?us-ascii?Q?2E2JZ+qXB8gNmEJrD64=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY8PR12MB7657A896AB19ACF83F7224DF8B17ACY8PR12MB7657namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7fc68e-3f2a-4f9e-b04c-08ddf587a1bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 01:15:03.9182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQe+Y/I7iPdQSgJpcMmfGEJuYiW16oWMo/CYSkQBGggtLA1RkTpBDp7vS8S2E+bI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9689
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

--_000_CY8PR12MB7657A896AB19ACF83F7224DF8B17ACY8PR12MB7657namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


The series looks good.

Reviewed-by: Shravan Kumar Gande <Shravankumar.Gande@amd.com<mailto:Shravan=
kumar.Gande@amd.com>>

Thanks,
Shravan


_____________________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, August 19, 2025 1:50 AM
To: Liu, Xiang(Dean) <Xiang.Liu@amd.com>; amd-gfx@lists.freedesktop.org; Sk=
vortsov, Victor <Victor.Skvortsov@amd.com>; Gande, Shravan kumar <Shravanku=
mar.Gande@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; C=
hai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS po=
ison injection


[AMD Official Use Only - AMD Internal Distribution Only]



+ @Skvortsov, Victor<mailto:Victor.Skvortsov@amd.com>/@Gande, Shravan kumar=
<mailto:Shravankumar.Gande@amd.com>

Hi Victor/Shravan,

Could you please help review the code at your convenience?

Regards,
Hawking

-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com<mailto:Xiang.Liu@amd.com>>
Sent: Tuesday, August 19, 2025 13:26
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Z=
hou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Yang, Stanley <Sta=
nley.Yang@amd.com<mailto:Stanley.Yang@amd.com>>; Chai, Thomas <YiPeng.Chai@=
amd.com<mailto:YiPeng.Chai@amd.com>>; Liu, Xiang(Dean) <Xiang.Liu@amd.com<m=
ailto:Xiang.Liu@amd.com>>
Subject: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS poison=
 injection

Check VF critical region before RAS poison injection to ensure that the poi=
son injection will not hit the VF critical region.

Signed-off-by: Xiang Liu <xiang.liu@amd.com<mailto:xiang.liu@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index b00cbb927ca8..6730de574fdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -219,10 +219,17 @@ static int amdgpu_check_address_validity(struct amdgp=
u_device *adev,
        struct amdgpu_vram_block_info blk_info;
        uint64_t page_pfns[32] =3D {0};
        int i, ret, count;
+       bool hit =3D false;

        if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0))
                return 0;

+       if (amdgpu_sriov_vf(adev)) {
+               if (amdgpu_virt_check_vf_critical_region(adev, address, &hi=
t))
+                       return -EPERM;
+               return hit ? -EACCES : 0;
+       }
+
        if ((address >=3D adev->gmc.mc_vram_size) ||
            (address >=3D RAS_UMC_INJECT_ADDR_LIMIT))
                return -EFAULT;
--
2.34.1


--_000_CY8PR12MB7657A896AB19ACF83F7224DF8B17ACY8PR12MB7657namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - AMD Internal Distribution Only]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
series looks good.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Revi=
ewed-by: Shravan Kumar Gande &lt;<a href=3D"mailto:Shravankumar.Gande@amd.c=
om"><font color=3D"#467886"><u>Shravankumar.Gande@amd.com</u></font></a>&gt=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Than=
ks,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Shra=
van</span></font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<a name=3D"_MailEndCompose"></a>
<div><font face=3D"Aptos" size=3D"3"><span style=3D"font-size:12pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">____=
_________________________________________<br>

<b>From:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt; <br>

<b>Sent:</b> Tuesday, August 19, 2025 1:50 AM<br>

<b>To:</b> Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;; amd-gfx@lists.freede=
sktop.org; Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;; Gande, Shrav=
an kumar &lt;Shravankumar.Gande@amd.com&gt;<br>

<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.=
Yang@amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;<br>

<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: Check VF critical region before=
 RAS poison injection</span></font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div style=3D"padding-right:5pt;padding-left:5pt;"><font face=3D"Calibri" c=
olor=3D"blue">[AMD Official Use Only - AMD Internal Distribution Only]<br>

</font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ <a=
 href=3D"mailto:Victor.Skvortsov@amd.com"><a name=3D"_@_4850F40347FD4FCE89E=
6688462058227"></a><font color=3D"#2B579A"><span style=3D"background-color:=
#E1DFDD;">@Skvortsov, Victor</span></font></a>/<a href=3D"mailto:Shravankum=
ar.Gande@amd.com"><a name=3D"_@_78A74583C43C47C2ADDF0BDD349A535E"></a><font=
 color=3D"#2B579A"><span style=3D"background-color:#E1DFDD;">@Gande,
Shravan kumar</span></font></a></span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hi V=
ictor/Shravan,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Coul=
d you please help review the code at your convenience?</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,<br>

Hawking</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: Liu, Xiang(Dean) &lt;<a href=3D"mailto:Xiang.Liu@amd.com"><font color=
=3D"#467886"><u>Xiang.Liu@amd.com</u></font></a>&gt;
<br>

Sent: Tuesday, August 19, 2025 13:26<br>

To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org"><font color=3D"#467886=
"><u>amd-gfx@lists.freedesktop.org</u></font></a><br>

Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com"><font color=
=3D"#467886"><u>Hawking.Zhang@amd.com</u></font></a>&gt;; Zhou1, Tao &lt;<a=
 href=3D"mailto:Tao.Zhou1@amd.com"><font color=3D"#467886"><u>Tao.Zhou1@amd=
.com</u></font></a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanley.Yang@a=
md.com"><font color=3D"#467886"><u>Stanley.Yang@amd.com</u></font></a>&gt;;
Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com"><font color=3D"#467=
886"><u>YiPeng.Chai@amd.com</u></font></a>&gt;; Liu, Xiang(Dean) &lt;<a hre=
f=3D"mailto:Xiang.Liu@amd.com"><font color=3D"#467886"><u>Xiang.Liu@amd.com=
</u></font></a>&gt;<br>

Subject: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS poison=
 injection</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Chec=
k VF critical region before RAS poison injection to ensure that the poison =
injection will not hit the VF critical region.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Xiang Liu &lt;<a href=3D"mailto:xiang.liu@amd.com">xiang.liu@amd=
.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 1 f=
ile changed, 7 insertions(+)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x b00cbb927ca8..6730de574fdc 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
219,10 +219,17 @@ static int amdgpu_check_address_validity(struct amdgpu_de=
vice *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vram_block_info =
blk_info;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_pfns[32] =3D {0}=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret, count;</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool hit =3D false;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, UM=
C_HWIP, 0) &lt; IP_VERSION(12, 0, 0))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {</span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (amdgpu_virt_check_vf_critical_region(adev, address, &amp;hit))</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EPERM;</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return hit ? -EACCES : 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((address &gt;=3D adev-&gt;=
gmc.mc_vram_size) ||</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (addre=
ss &gt;=3D RAS_UMC_INJECT_ADDR_LIMIT))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return -EFAULT;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
</span></font>
</body>
</html>

--_000_CY8PR12MB7657A896AB19ACF83F7224DF8B17ACY8PR12MB7657namp_--
