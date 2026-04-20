Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D463DF36C2A
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 07:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741B910E0F5;
	Mon, 20 Apr 2026 07:07:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fistbIlM";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010056.outbound.protection.outlook.com
 [40.93.198.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0039C10E0F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 07:07:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waeSpWGdwnKlNOHZazwRZ1EF+mfGD0q5/vymIq4/yS8rZ/ywX1X1fY816YJQ3+42u40g536gbeconaGgriEKH3vcwczJkCCmR91Ytq8XGs7PDQNmzu39p9ck/wINeqOsr46gVIdJV5jdQFAY0mFuPFhm9SEin80bKHEF8Ta+t13L5YINwEspcw9WE/kqUEWFKz0ff4lFgwlw8rMtvbPrgKa6heRXUEG0De6VeMWy1xenp6NNDnv09WsFYvMVt43wwA3lVcPv0cp2d2Ntl6L2eSM/VX5VMInoLKMC+NNoa85ITmwXDH+cuR78SWXBjiN/0rfnCMmZyUOMDiVDsEbdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TP20nid8d5q2OlDUd8YhHEo2SULmWHDcv1CwSCBZgq8=;
 b=a1+Ri7Ka72668qEmMZXqvokhmARqE3RWBTJE/S01AZtAFuDNV/UFM1vkDdewDRqFfl0MayXu91k7QW/og8jIhGCtaDnIFFpRQq06LGOoiA0Y+H/5ehFfNphoFYCfw594rJEgagw7uSJR4MeZxm98K2uiG3OMF+mV15XBzjVJ6moRb90SAN51LGe8FCXiXGSpq2Z8RFLPZ3jD5ze2Fvwbox+viCOaC4o1v2Fg0+sbRBk2I8q5jGhUX09e4UiuCw5Q/p3B89h0CP5UWH2Anzf00SCBwrZesiVnWlf4dDaeR6mk3vcmk8vDvWdFkoxLpMeGJ9LfvDLUikK4eU/vHTN6TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP20nid8d5q2OlDUd8YhHEo2SULmWHDcv1CwSCBZgq8=;
 b=fistbIlM95MFRuy8uKYKBdMcQ9ErJsG3P1q1NUl+0xYJ95k7w5tlPGMWxYK4YMRnRnWuCt/qW33L3Viz+vTJVQ6g5AbdtJBE4J3UJm1J0QoVlTsN4J+eN6O4o0rrvg0glcoazY2Djx5juaG1CsFlbaGh9G2eaWODagbdprg7I14=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Mon, 20 Apr
 2026 07:07:24 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%3]) with mapi id 15.20.9846.007; Mon, 20 Apr 2026
 07:07:24 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Check SMUv13.0.6/12 metrics integrity
Thread-Topic: [PATCH] drm/amd/pm: Check SMUv13.0.6/12 metrics integrity
Thread-Index: AQHczs2GS+Um+ZOLbEOVyHCtui24E7Xniwtg
Date: Mon, 20 Apr 2026 07:07:24 +0000
Message-ID: <DS7PR12MB6071F860E1C782215816B0DA8E2F2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260418005117.3437052-1-lijo.lazar@amd.com>
In-Reply-To: <20260418005117.3437052-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-20T07:07:18.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SN7PR12MB7348:EE_
x-ms-office365-filtering-correlation-id: e8a1f33a-8346-4fd7-672f-08de9eab7941
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: LhzTjtuwrKK4sPHdEMgUDB0wDA1Ka1fuoaZDoMcpi14ZPd1s6pSkgG63HJJqQZoyd1Fw5IgXJStzo9h8kN88OpV27mwNhpU73zyHoE9dyKCnTe+zssLRSgFjtph6mtjF09XoCZtOaD7umVYovLENV/XZZXvkEVlDHmh8QUAUxnsHo95OakP4qN2XB++k+nsHbkaG24kWFW2/hrLFUfUr/SeJvwWvSJYaqM+7qIh2GhLto4GHPWWj2AUBYXogSaR0VXwjcN/cEsZ26uj122Elt7QcJx535s5q4ttT8rFjvWLiPuYhttKN7vLGjTfhL1PoGQRjdOF4hiY4sXbzz43VHLMYNr1I6trdkpleu2VNNTIdDtUBToZMfZjUsaFH8jdr/6jM/9rvAM12m0ZGQC0Ll63whCae2RuTg85zLtb2Erqpag95MjKsD7phz3gjB1IbYnHHRiBq88yqRjK8/q0UCqp18C3BfjdysXXsry6CEUcp2VAhxSSR4dlE6b2IM7dJf1oelaJ+q5+Xxrr7BOWJ1P79x0rbbXkSlJqNLGU5Is/61zxmb3ghHhYE/tJ9+HGD6FALzENkafsDAydlx2yQnV+bVHCBig2tCcnFJStpUyUJuxYMCQ2HhndE5siddqKh1Rn4qYxBmpw0pYwjksoUU6sZL1SsdSu6MdP6qJvldAAFsWSXSZ6yQYPkbmhmoQGxO1UEpjQziYeEfuh5zPy7q0a//RS/yR3H59gbgDEW7fOGeLRU4R3AzJK1kk1Q8lKbErWbjdsardclUNKhWnO4qWk0Rc3+75O6+1yhbA0P9E0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B541ep8nPyZOzoWsD5m+k9iQpJEdabk3DuupjzPaGMeihjExufz5LPsq8NGR?=
 =?us-ascii?Q?E8d2yVaZeyy8srFvm3qQ0dOwit2u/dxeBz8VlYDzEfuTNEhO2hqopYiT4rEM?=
 =?us-ascii?Q?xBcrZaL+BBRovHsX0AGwcc4AdxSJjznBHcZn4b7xdYrmNbAuWQUaWxgKdYxR?=
 =?us-ascii?Q?NaZiO6HCFOkAyGojJxcu4al5G+f54H6756dIjf4iwQQYrvyh/dv/aCHA3jtb?=
 =?us-ascii?Q?30JwltJD+dG5QLI31+SIFy75Qma2Et0b5vW5/n7ilbXdkwLIhkNv9wzW8QyV?=
 =?us-ascii?Q?Ti+HFjaC96n4ssBeAUVYaOKdDISNWWqssUYrHIUkcoKKmyeWZhA+EsJ0q01T?=
 =?us-ascii?Q?c6Sk/MF4hqb0ZGdlhYvIBMeSGnOAjWWaq36Wu3i+Bx1YWGV4OKcM974WYJoS?=
 =?us-ascii?Q?pwXFNBSA/+mpmZnl8oUuJfu47OTHvtmQ4IK+038zWIMWfC1NAKrDTHc8auFd?=
 =?us-ascii?Q?94wCQ18D/LSDBMAoIziLt2RftqPz8VysnEGGj820wIrrC3LXfxiTo0M2/2yx?=
 =?us-ascii?Q?6S6pNkNypgF9c7A+j5vMqcVTDTbyJJmhHHiFBvwuUa+Cy4JAemlVKQWHxyxo?=
 =?us-ascii?Q?K93uuQSV13c8iuhdyIweXKPszEvJRTDU6mWyYwwAtg9hK53k8tjafgif0hXI?=
 =?us-ascii?Q?BdrOyK9v4Kr+r2WHPkkaSbTtz6e66uJhFjNiMgwTohzNeBZznjEl8lo+lB+j?=
 =?us-ascii?Q?jYPeRr7I5+kqf0wB9QTIa+SXWhJIJK81mA7lH+42kC+ys4adqHVrpv6ftQm7?=
 =?us-ascii?Q?/1YMBUW7DuEZFVmyhw9r+mp+Yg29oSa7vMQAlfb0BidKCcChwhryxoGhoWjC?=
 =?us-ascii?Q?TYwOLUp9yg6lt9HamVrOeReSoQp4KHnBW+bdRm+RbgBrqjUyrlQIaLu5qCgN?=
 =?us-ascii?Q?A8/ZpCm5r4XtBrWer4BCxgCSJa7AZus96z9/vyx9by3WArXf0X/qJC/fzh6x?=
 =?us-ascii?Q?MG8fFVKFlWP+DPp78YBkBQpN0MwQKwsMpJsIm4XL0wA/8O4yLJA2nI3uNB/t?=
 =?us-ascii?Q?o5+LrmK9nEQ6wn7rLUSAvQznftl+JoMRlVJUhD22NwZu9+7CPXUBYruE9q4r?=
 =?us-ascii?Q?FzmyNzdIGjQv34ZS1B4YCKfYnfhKyqu86ewOw7yNu2S3pqKrT+WwD5N0ynNU?=
 =?us-ascii?Q?r3qJegWW1KS8QP7vw8KubWeEQ+3ykrsQmhwf4xXPLEcfqLOYo7iiZ2tPQ644?=
 =?us-ascii?Q?nbWCBlZIMPxP53tOb3aPX+uNe7Ppct5aMLpFdDUa+krlz0N+3TSCUILkauP7?=
 =?us-ascii?Q?HV8MR7LvhgmP+9Vh/TKRO7i4BQNlpkYtraA3L6x6kqLWnrD8IBuPTSLZ3gJP?=
 =?us-ascii?Q?oSynRZNNi5HA51S4XgewbbV8oxlI1sCO8HbwoGn7fj4AiDIE0+D0TuIp6FfW?=
 =?us-ascii?Q?PK9aJvj6WbgLjlYLCiWZlNDl/9CGj16H+Tzqm05LHdT3a22crVtfZ6JQCJif?=
 =?us-ascii?Q?HoEHDBjImiHtPRk8WYD6U6Qcp2Ga7qSDTcgVBjG/18MY81ujnG4p5yRLWXfz?=
 =?us-ascii?Q?uIwujzy8jV0VrY2lozBNk9qJjykrmKnsslCkKLf52dZH8qGhS6tdL95iuXlN?=
 =?us-ascii?Q?dH0DTlmVCKl6Lyr1nTXTNMkBMOkbTNeZYWU9nrGFQV1wndfJTig7ZnHtYv7x?=
 =?us-ascii?Q?Y6MeLNd24dbSfDrGawfAW7+/CIRv9/StgFr20nx0wMk/Q5HQvM2/nBHaDAPq?=
 =?us-ascii?Q?TM5G04ycERx6UM5qsLr4kx1APUnxWwUL/JDzOuRZ/Th0yU+P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a1f33a-8346-4fd7-672f-08de9eab7941
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 07:07:24.4038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KmLOOMcD61LNaa9xLZ+acZ+wtD2V9V4afCilosV/Way0vSM265N4Rvn7ypl75i9ArzkLVDwPRCtKbE1k98kCEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348
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
Sent: Saturday, April 18, 2026 6:21 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Check SMUv13.0.6/12 metrics integrity

Check if data fetch is proper by matching the first few bytes against 0xFFs=
. If 0xFFs, that means data couldn't be read properly.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 03a4a3513228..40f0d8a685bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -783,6 +783,10 @@ int smu_v13_0_6_get_metrics_table(struct smu_context *=
smu, void *metrics_table,
                if (ret)
                        return ret;

+               if (!memchr_inv(smu_table->metrics_table, 0xff,
+                               min(16, table_size)))
+                       return -EHWPOISON;
+
                smu_table->metrics_time =3D jiffies;
        }

--
2.49.0

