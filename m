Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A01AC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 03:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D76A10EBCC;
	Wed, 26 Aug 2026 03:29:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SLOmSn4p";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4803010EBCC
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 03:29:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKMBMztFlU5TA4Y3zGHzkT0xnv5h1lGbhxaGRMH+CH+C5mD0AMA/DsAoy15y+vlGuG2tjTjnFMFTnr4SHolDSifL0X4SGRyPMnpUTMk8c3qkiUQksdvtPAJozjRKSzu4XMTCxeG+kf4ghsU+wFMXzn4ZYte7CXAu9IVs+JbSwF13+/aY3CvHFR01czo8/V0Wz/xsytcL46Fx+LFDXxZ6ZuUZJY8MqHDEi6OXTsML80cJK1lfOonyOO72jZ1l7JnFpqIFzSmQqPcjJ4/BzM6JY+bqLr9Pugu8nclp8gAurLKskcpi2eMQO5+CaLj7JBq4SM7L2VxujiX51f/5hcSIYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2q8FASz/ZXIEwZXEewKfDa9o1cMe99pqWSgkIJ8+p4=;
 b=pWFFL6MTBYs6/HLlFfX44uRuM2VDVenGgXcL1gIWw/Wl7o++esVTn7vmcAuxyKWf7ok0dbqlwuxdt/sukYSZjbmZMy2+fufoiSOKfoo72nqTJ1roeeT9JHMkihcxZhOqJFBC+3BQTnoEIjEf7hoRvuQw/nJmOZKu768XplcMni1AZRmwXDUaxeonCME/E/K1Xw/MngOqWjoWQK6NmA4j9uhry6CaL19QcaHnLV4kkMjUoEWBdR/J9TxkucGgveqs3xrP4dXsfx09/1yythp41z0eNMs5BQbIUaxx/ql4O3R7Rx+unTuHDYs6gVkb4h1PGHcv4MttklznKNyp2URFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2q8FASz/ZXIEwZXEewKfDa9o1cMe99pqWSgkIJ8+p4=;
 b=SLOmSn4pP9DXrPPJW143N898IJPL7De19AvgSrSXmaba4zbLXurBOruECBJhDOTEdkXTOhJHwbElqFHBwwfVvJe6/XnKHRR8DSkp8Z/6oSfMf7I48XO90n1pqoc0lnNK0m3FT2t/PKx6tVwlt3soWA55r3pMOAxnKXe8cVgoVHs=
Received: from BYAPR12MB3192.namprd12.prod.outlook.com (2603:10b6:a03:139::14)
 by SA5PPF5EA4322E1.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 03:29:28 +0000
Received: from BYAPR12MB3192.namprd12.prod.outlook.com
 ([fe80::b4a2:3223:31a2:ab7a]) by BYAPR12MB3192.namprd12.prod.outlook.com
 ([fe80::b4a2:3223:31a2:ab7a%4]) with mapi id 15.21.0339.010; Wed, 26 Aug 2026
 03:29:27 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 3/3] drm/amd/ras: report the banks the scrubber logged
Thread-Topic: [PATCH 3/3] drm/amd/ras: report the banks the scrubber logged
Thread-Index: AQHdNQrOJYM6aF9FnUu6U8CYOGWiYbavrAHA
Date: Wed, 26 Aug 2026 03:29:27 +0000
Message-ID: <BYAPR12MB3192E5EDD0A6D119965ACA8EFCAE2@BYAPR12MB3192.namprd12.prod.outlook.com>
References: <20260826032606.470702-1-xiang.liu@amd.com>
 <20260826032606.470702-3-xiang.liu@amd.com>
In-Reply-To: <20260826032606.470702-3-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-26T03:29:04.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3192:EE_|SA5PPF5EA4322E1:EE_
x-ms-office365-filtering-correlation-id: de9568c7-1643-4e22-5bb0-08df03223bf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 8Hd937hCs4yW1CBLR6MXegYKzQ1dyMscGbobZSXBFokjVpRbTGDW/DdhXMDrOoNl23T/lnKQDHem9QUEtIGWbaFqE0R6dOXWrBU7GmvGEOYyJ4ZzE1IoIVe13ifTytVRw6Me5iaf41cWWHFD3ZeNb6UI4DA0G91ryl8bcdY3XcDKdLWdSdbaGutZrpinwcjQB+yePJNb2ajL48PYCWH5RzRDfshDupD9QU96CNvRPW6gLS8fqKKzuCP02/McZZODRQwJNtKfVumrT94Pt+zBi66PtzoZu6M/eS82j9T/7Vro5Gc2JVpp8MVUEayEV0RniVa77tJfcHpLQbsjUUiUSzG9IBF+Not0i2g/v4p51wKcBZMQEWsNVkdQGwH7selvUKx9yTm1+uYZ3uVA0XD+9wJrGJjbMTbc2j5SZkKi5SWLXWOivmGf6Td+PWqs6UNvaE1KAUJqwWah9VbogmKd+Q99dvkFZgOMPd7UoFId3yEsaPBYK6u6tMb5iAcXQprQbvM/aFHk4Vl+rlQN9PC2zqBu+XF7TmRS/g+c95LhM2EFXMFI/LdvaM8wHH3YEhn6ZnpcMTsazDQ8fOnvmPVH8OR5yL4CVVtOKgEmDvYC9aWBhIFFNLLKh91+ayGeDSI6GsWYDCGxobx4RGFBsmKX5N3/OqtiTxUgLHtL46kbQ8yt9NbLnVbp99fT0H8N8G/m7bvQooWnkvNhmrKFe1e33k5il/WHbHqz+7jdgO5t71U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x2GBxAWOOC2z/62JpsyXeGZUYQLfAUF1o2LfBe4A2SRAlFqA6t2im4/sbbNO?=
 =?us-ascii?Q?EO2jlhvMoG9sso/QBDfkdhVrggTfodGc9HpebztbU0KgBUbhrWc5aH1lAbv+?=
 =?us-ascii?Q?Z99ZeTUs8/Yp5HTXv7toZD2/X3Srwr2bSeabakAYKcQu8nEMTdiHOlvelQKt?=
 =?us-ascii?Q?0c0fkL7SPcbanHXtdUJDs8HXT00ylfhqUaHL/It4WquufsK7LAabPzNirzdX?=
 =?us-ascii?Q?1DR4Y7Z8msBL9zO0qPc0RVUevVBSLb6WbR3yY8OKzbB4LZ8JvtljWH901jG8?=
 =?us-ascii?Q?F5OX1EWNDv7anym/D81uvnl1qduRzfHShtHIKiIVQYCMmT8dPcIT9RpJzztO?=
 =?us-ascii?Q?DGdP6oIIh/K/5JiD0pkyLEsKpBdkTnj7Zt5VwSdiicBHPvjpbew6f9Qn+wJP?=
 =?us-ascii?Q?lH8WlAzPLTRC9bq/r/mrUR/OKJ6U3sU80PV1rS/XQ6E4ngM6OvgyyIm+hKf6?=
 =?us-ascii?Q?MqSG9JbE5CMY6+tMEslMi7vzqmKaSo9vXpyOzzilsaABVsyiFdSGE0gVKT4Z?=
 =?us-ascii?Q?80e1Yz3/85/OEmQ7ZRd9o8VT3/hMb+8iSE84cSWSaXWW55yuQk5i+ow8i4IL?=
 =?us-ascii?Q?cX0Y+AYkJPrYXFBomev7TYh5P+g0zKo07/9mD6qqkx57AvZkFngXlUHpbCa4?=
 =?us-ascii?Q?i/Ha1f1fdtjbpl8Lkhaj6rmjs8wayuSm9VhkmYA975EBg48aJntOIRYPtbUX?=
 =?us-ascii?Q?iQ//Oge3nMhQPqsAAyYWsTqmIpF4eIoudaG8WV6JUoCrUzjWhJU/rrnwQLdz?=
 =?us-ascii?Q?+DIDBvRy2JdquVLQUflWwuv8QChvbsGBzpX2GCXwM9emp1xBHc+RyGtgGVOW?=
 =?us-ascii?Q?nijsGrF9+QOIVTNagJZIFw3Upj8o/DznXuHsKge9AnkzhgZ2g5hh3g7SWQHd?=
 =?us-ascii?Q?Izr4SX4wJYdTncNdLghxP0bARbeoZ5WEuuTl+X05nfNFiMpeqsuuQ9+Eg99A?=
 =?us-ascii?Q?3GP44Llpqse55/7CgMVTc7ukieEnRn5lToa7fMuFV/7btAyZ+eZ3f48eX00M?=
 =?us-ascii?Q?U5FdEc+Carj1xM/dv/xiJXI6tz/aT0jTyZyihNM/CpaR35G5a8EjuMWjQ3Jw?=
 =?us-ascii?Q?2tG9I/xR9westPPClTKOguAr6PuPkhhrumJDsZ/0Pt5evi04g6knI5SE6FLq?=
 =?us-ascii?Q?4+XS4TNPlbcbNg/PYjvDPswjgvDznrMo6BhMQuK8v+8XZbop/K4vGnUZchRu?=
 =?us-ascii?Q?dZxmsee+CvyNz36894DGbz6WTrIqcybTdyJuCyWkoAKzaI/oXkFYcdbm7Pxy?=
 =?us-ascii?Q?+YYoNqsqa0v0YkbVatYiq+sw6btmaoX12qqo6MVI2HPKJbEfmOgYro+Uc4r7?=
 =?us-ascii?Q?1fMdC/36AAD+3Q9gZ6g4dHHrcdvv0Jo0qzFzDarNsZY9Xi3RXTC3DCFIqjJA?=
 =?us-ascii?Q?sTvvZTXfRJ/uf+KphmKUFP4z84NVC5rIqPS+8V5OsmVeDw9uae3rJ+uqEZkU?=
 =?us-ascii?Q?uub/bYWBxvsrX4DqGgpDZJ+pBudnKaaFVYBAguU+AFwJABz1aStzl1361SEG?=
 =?us-ascii?Q?oIsYlPOx9STHnuzp5q6IafmJ7f7V5sKY8TkNJqoF4U0boG5n76vHk7d2eTbl?=
 =?us-ascii?Q?xBMYCX5KPgeEdiD+sXrISqQaVdqI01qIWSH7h5li42lqujgl49w+D+mAD3BE?=
 =?us-ascii?Q?YV8JZvJD/1HSGapjWCTI7PP/qyAFaZ2VdA4YibqTJOgw5N6qi4MDWN4xdnAT?=
 =?us-ascii?Q?qOLFxxqvXnS0IbJO9LecIS3s30dAU04KFzpIhjqpx81wqSd3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9568c7-1643-4e22-5bb0-08df03223bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 03:29:27.8845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hr5aIolIkhWYzIZptJcJevE40//AY15TLVfooLsGgTVSFmWZkH/buR0IBwWxeOlKBupHZfY+dVbTffzkQZy9hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5EA4322E1
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

AMD General

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Wednesday, August 26, 2026 11:26 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH 3/3] drm/amd/ras: report the banks the scrubber logged

A bank carrying the scrub bit was found by the background scrubber rather t=
han by an access, which is worth telling apart from the rest when reading a=
 log.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/c=
ore/aca.c
index b40098406174..881681ea9f3f 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -128,6 +128,11 @@ static void aca_bank_log(struct ras_core_context *ras_=
core,
                        "{%llu}" RAS_HW_ERR "ACA[%02d/%02d].%s=3D0x%016llx\=
n",
                        bank->seq_no, idx + 1, total,
                        aca_regs[i].name, bank->regs[aca_regs[i].reg_idx]);
+
+       if (ACA_REG_STATUS_SCRUB(bank->regs[ACA_REG_IDX__STATUS]))
+               RAS_DEV_INFO(ras_core->dev,
+                       "{%llu}" RAS_HW_ERR "hardware error logged by the s=
crubber\n",
+                       bank->seq_no);
 }

 static void aca_log_bank_data(struct ras_core_context *ras_core,
--
2.34.1

