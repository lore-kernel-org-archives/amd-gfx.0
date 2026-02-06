Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A978BEB28F8
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 09:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C4C10E110;
	Fri,  6 Feb 2026 09:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C4MFmrq4";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6502D10E110
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 09:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pa4yAExCrpJGJCxdPf/Hs4u7TD/YfcY7hbS3Zfdl+Z1qxzJ14L4HxUN265vbXynj0+iXz2cFWMtM1exN/rX7X4123wordMPKPObP/Y/uZwJY2S1ntdon5tTVuyqKkeAmwo7p/vYsWZDYocX1s4Rj9g5uwpkSr52qPhSvuS3sZDaQOT5aYpg6DVGotRhLU5f/96oGQD9BmKW6zjspejlupjMvZe1rcAW+rWD4VgZf6kQ3ym99WA36HBE1t9m8UhcQBLslQkmt0wzNhA2b+hBQYkr9CJ9nBlG7Rhm4IFkS2vnBVmboM16JAaAXlJqvgQX6t6ycEslhnNxkczGl+ibr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbicjV2IpCMWq4BsFkZKWShnk/NuWSMvYREw0q+Oa5g=;
 b=C9l1Exdvh6HXbU1VQU+tvbegcwXpitsdCcJKq4S0sUfGUIavh+K7ZDu5L5z8SQp3MfeDL8SI4ZDnSBzybaB0ImIEjUh8SIHwSYUBmR9yO4eYQNtrvsmW1MRulAic/SuU8k/ehn1MheGzkDHKebiTcfdWDSSZgAYD1cUGdDSo2hFZU4LdO7UvXy1NK7/8uuRE4EMEeu8iLNNVcj5P4/UE4UkvoCfWffLkifLdG0GEaOmSCzQfBD8zbYaIRG+ymT8WG2Bitdvls1GTiSWSrWP5weG9aBqFVHlxxiWcf4nghYXK2wJpYduuDNrS/Mpx9oiAB9v9pFC1tXwaiobN+M6Wew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbicjV2IpCMWq4BsFkZKWShnk/NuWSMvYREw0q+Oa5g=;
 b=C4MFmrq4tEhl1I3VX14pWj26pEJIJn04aPlPlN73deKuOxpoNn8Gcb6gn5GS0SKO8iRfB/F3sP5265bA65/ebeQvM1ziTbynrKw28p/x72OTE4q8KE1yG5oWlSA6PzUbNdSeEVBAtxf173pew/0XLM792bF2tzRmhTDnC1/88SI=
Received: from DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) by
 CH1PPF68E8581EB.namprd12.prod.outlook.com (2603:10b6:61f:fc00::611)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 09:17:16 +0000
Received: from DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::b9bd:39b2:7686:72e5]) by DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::b9bd:39b2:7686:72e5%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 09:17:16 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: Add acc counter & fw timestamp to xcp
 metrics
Thread-Topic: [PATCH v2] drm/amd/pm: Add acc counter & fw timestamp to xcp
 metrics
Thread-Index: AQHcl0MOoX9z4iacEUWJkfRH8l2wF7V1ZCXw
Date: Fri, 6 Feb 2026 09:17:15 +0000
Message-ID: <DM4PR12MB601292B80F73AD60F9FF70578266A@DM4PR12MB6012.namprd12.prod.outlook.com>
References: <20260206083128.4134355-1-asad.kamal@amd.com>
In-Reply-To: <20260206083128.4134355-1-asad.kamal@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-06T09:16:54.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6012:EE_|CH1PPF68E8581EB:EE_
x-ms-office365-filtering-correlation-id: fe2d552d-826b-40a4-5073-08de65608546
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?mvpZ4BKkgJz9RBSbO2J9cAQhvT3eD4rhbH6MtFY4KNAkpdBedM/hD2kedpg5?=
 =?us-ascii?Q?BKlL0ruXwZa6V8QGE8GpXT+oV0Z8k7tCv6bwEX7yDI6JTcvO1kMHRS3P8jk+?=
 =?us-ascii?Q?mgiJ6VtR7DRaaUcPu8aeUK7J6BdJ6yhN/dMI1V/YRPCaCcrdB0txwBeyXU/Y?=
 =?us-ascii?Q?KLP6RAoaQfHMXpN+RGZLzCJokoKbl5FdjA19tKbRKDTkGajnivEeZLruI/WR?=
 =?us-ascii?Q?TjQXWQFaW88fEW/y6RzDcaO53tyOVyvBDSXhTyTBqOKc66GjR6mzFMRoDzKh?=
 =?us-ascii?Q?To+nge/3XzuqNxYRNHMLq5S97q76vXPcfr2liYaYKn/3udUMnKVqH2LZLea8?=
 =?us-ascii?Q?qFkXUkwbexCT5GNi/dvYXfMCkrGa/Mk+sSJNyHhytH8bzmS5KV7VyD4b/z69?=
 =?us-ascii?Q?Ocn1wO4gEtYRtqQZp8/KFVA/DVhJuFuYy0pxNz8Kb58zHsLgUWpfAoAM2j9r?=
 =?us-ascii?Q?3oWuRhuDQRZUe7b2IVIEobSvP4OXRmb6DQ75rpSAc4mixca0HP8m7eI/qSAS?=
 =?us-ascii?Q?LG7NIWVJPvDBEw02KFCUh0rJgdTD+yljdszIGot1cKVVYXmArq2SADOZ2omd?=
 =?us-ascii?Q?PhplvvtGo2X5A8zQr3v5Jldusw+RcRnQf7cgFYnLP7yNL+Jy+PgQUR5SLtSZ?=
 =?us-ascii?Q?DJ6XOpvycIvVQr2i+FaUffgwyMXh6vVFTEO93xnOF9FCzzy7uTP1DQLHj8ec?=
 =?us-ascii?Q?1vq2Gg1QnjPQzuAZA8py32GyDTF63WBwA69DsYs20FlTh9QBOUPdUktdyPYE?=
 =?us-ascii?Q?1SCJOgZhc+aOTHPL8yXuFFvq7jU5HoCtprGdocIiYRC5Doi/kJMwlXpja8B9?=
 =?us-ascii?Q?/AFx1LHt0j9dQ7CI+y25vepxaVjIpEiDiI4xUPsoqCtEGGJolu4XhovVoJOk?=
 =?us-ascii?Q?ucPXuNz+9jiK/wL4WFM18HkReJPxZuNOlAzlDvaVwmUYqFZjMWsKhqlfBIFs?=
 =?us-ascii?Q?vHU3VuKX7pSqtzBHamD8e+9GDslxJtLxMkkIl1kaJ6iC2ga0hIOeqBH54wJC?=
 =?us-ascii?Q?NMVONfZxEunk7Z9Wr7Rs7Ilm/6xUG5kNmCCxWhPKUBsTVVQqmVe9gXHUBiWM?=
 =?us-ascii?Q?2lVUR2efZFUnfPCeKriRitrtUWH6sziZH8v6yFDScsjOSK1SdoB2tRMilVqU?=
 =?us-ascii?Q?7Z3HkPq+cdrdqrsvDYPqZEeeeTp1cn4cCI46f1O2jBSc66VXkBmuLtmKJbc9?=
 =?us-ascii?Q?zXhM906O+f0tuL3TTKcYah3ybHup7rvxEW2PDGadqmBeQ8PgHRQCOImkMIR/?=
 =?us-ascii?Q?yg4qr6gu+9A3rW6XJm22NXmPqDM2+3dL1xF9WNrU9Ge0Ru32xSsgtYuU8o1H?=
 =?us-ascii?Q?iDaig6rB6z6PhRiwv4I7vnTymtIwBsBZ0MqmxEhNFQ2jBC5ByQrAG9Ec+oP+?=
 =?us-ascii?Q?qoRPskwXihVTncpGT0OAgzDKi+6ZZB3U+jIfi1FgTCrkTcNo9XkaH+D3SDmp?=
 =?us-ascii?Q?VPd1XPb2JmoTh0KR8QOVFayRW8nvfnrulsUgF9grUU/XaIYwe7krg8m6CJRV?=
 =?us-ascii?Q?Tqs22ibt9C+njp8eG4ub+EuFNoCMPkZw6TmArfzWfUwwvJUbh2Ai3wjlGtsD?=
 =?us-ascii?Q?MdetQfMcuhB905H4UGpoUr1KAfDfnAiO8IZBREwS1RLaWv4D1vTL/yQcWqOp?=
 =?us-ascii?Q?qLYDrH2J4TaxeY6aeY0IJOY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6012.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SrnFR6HIIl901HRMvw8cKxcjFBhumNzThQbW+XbieClXAC7H+LVIcXGOYZfB?=
 =?us-ascii?Q?sw0xVLW/+t7Oz7eA7Q/DUFQ+dlvLrQ/2mnnU+pAJJep98x05Ae3kbtf+/t3J?=
 =?us-ascii?Q?xzer3semqHDwOgu7fB32rbF/e5lyBxETino5ew7qzD2BCn7UsMxmTA1F9jC8?=
 =?us-ascii?Q?oGwvDw/kgbzvZ1nEdODuCtrMIwO7z7djDm62g/4mTJCPWdDiq6PHTB6+Nlb5?=
 =?us-ascii?Q?Z+GE6DgS6VVtV+OsBZEtwt/1w19glhcdoDX0NOXXBWLNrWHy5OK8wf2f4Uyi?=
 =?us-ascii?Q?75G2g2DPNnN4jXByxw/Nq/dVKpG4t4SmYP4HaIq0lBxAJb2qZQzVhiFsALI9?=
 =?us-ascii?Q?OhgSnUJlj6yhvW99bqnqsbnvSlsyLWnc5T99IPmz/zgCWYPwxt8+YsvJO1Iw?=
 =?us-ascii?Q?9F7K4mgg6Y13jVoMEB7FZ8+VNimV2/nlzBmf0yah+550pR+40twy8qAMZM7Z?=
 =?us-ascii?Q?ZuqSDE3sW5SmAfBzWsKsoDAAmTNWWgwibgZ6GR4K2AF0Pjrhy5FL0agPFEUY?=
 =?us-ascii?Q?I6kebwjWjTXRkgnNFrT+3DKBI/GOoWslyKjldpNOXWx4KUVMIwzRIM/zE/jw?=
 =?us-ascii?Q?7nobx9vBX66RUVxo61i8d/aI4n6XHNbxblJ/xxG0uRctbcWjye9Q3qEm3yu/?=
 =?us-ascii?Q?spfMNzvk7wcA5/098YCFkPohg+hr2fLzLz8OYu/9f5Je1CKImJEpxEZa4ifK?=
 =?us-ascii?Q?h5qqslNwTh0VXcLQ0uo37oO27CHDdPaU92oiujkzDrHMVEcLsrj8a6m/7mal?=
 =?us-ascii?Q?jW0XxdkZzCDmsiYGJRs4s5XoCGsFWy6DcXbcCBUMOF0aWfzs0X8IZjBFs9Ak?=
 =?us-ascii?Q?62DStZU5E+umTJ38OAufzc3rcO9ohBlT0vd+ZoDXQHI/lr4yYN58OXzfz+UD?=
 =?us-ascii?Q?iuu/JGoPqm3rsgdaSeGYhF+EjDHjnULTke6gCjBS48gjcl88bJTYq+D+EB6D?=
 =?us-ascii?Q?dhcFKT5NElzOPhc7z9gN6+U1Jx+JkNGIPGQscLJ9joPHXctGmNH8gOKGsnFj?=
 =?us-ascii?Q?Vt2beY3XNS1Ch3WolwxzsidBeMelvkd01o/rs78MW/N6nkA7PmtOHXF1uiCf?=
 =?us-ascii?Q?jS5bO8wB26EvYyhO4xHDA90omwHLvyIasO7AN51n7Q5cRK7a2a8/aJqxRdyC?=
 =?us-ascii?Q?ZQ9FdGTW5WZNaX9iLzDo/WIPRNVe0LjGvks0JI0Qe0D7XhDi9IEMfuwto3ld?=
 =?us-ascii?Q?wKVm9wJNahDjc/F/2Anbq/euayuOqapNTmHRC2kRxs0cg+95eCLAWneWY/gA?=
 =?us-ascii?Q?xj68ZPkCfZWuBYd91esUt+arYSur3k1yRQqDJoQXPO7I35vYUq8j9cMBWwYK?=
 =?us-ascii?Q?T3L7+/ndETjpsWZ8BJD+OJAlQ93ERm+EoYI1cKuQ132WQQ1kHZ9Av/RJSVXn?=
 =?us-ascii?Q?eDKHeXnfW98fVrUoxh7ct2mATWT9kbV6pmn8fooQFdh/aXo+h9dJlYIBPU4Q?=
 =?us-ascii?Q?/gpcCiREATj20zCZ1yp1WYxcSDuaMRNJGeRq87SQUrBMJ5jYBPiaY5gNbqM0?=
 =?us-ascii?Q?GKOYN5jgcPY+sMtHqiaQDGBkvsyWimyIdK1wA5+lksiiT+82GQCynv5rAOvf?=
 =?us-ascii?Q?2SY9ISDTWbDnuflXDwvVlrlTnS9ch68g4vq+HnpsEs4k4xZA77Ax7Lc49wC3?=
 =?us-ascii?Q?L1Hd85i0lD+WOg2MLCb3qEiL9jTBUEWDyIYjVF96fO1N9vK34+StLrGc+Qks?=
 =?us-ascii?Q?++r3xXgpIIZvV0LoqO1kiM3O2FvznLlDbBbCm3SrCnyt9JHp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6012.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2d552d-826b-40a4-5073-08de65608546
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 09:17:16.0073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: us7m/FNdTgYlR1zwQRMFf7+mJ+pGZ2IXcwEzKok/nMeRkyswquCovU2fhvx18rLJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF68E8581EB
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

Series is
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Friday, February 6, 2026 4:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v2] drm/amd/pm: Add acc counter & fw timestamp to xcp metri=
cs

Add accumulation counter and firmware timestamp to partition metrics for
smu_v13_0_6 & smu_v13_0_12

v2: Use U64 for accumulation counter (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 3 +++  drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 2 ++  drivers/gpu/drm/amd/pm/s=
wsmu/smu13/smu_v13_0_6_ppt.h  | 6 +++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 3d60d3c1e585..f2a6ecb64c03 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -823,6 +823,9 @@ ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context=
 *smu, struct amdgpu_xcp
                idx++;
        }

+       xcp_metrics->accumulation_counter =3D metrics->AccumulationCounter;
+       xcp_metrics->firmware_timestamp =3D metrics->Timestamp;
+
        return sizeof(*xcp_metrics);
 }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3a9210083ce3..07592e285cf5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2668,6 +2668,8 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu=
_context *smu, int xcp_id,
                        idx++;
                }
        }
+       xcp_metrics->accumulation_counter =3D GET_METRIC_FIELD(Accumulation=
Counter, version);
+       xcp_metrics->firmware_timestamp =3D GET_METRIC_FIELD(Timestamp,
+version);

        return sizeof(*xcp_metrics);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 0588a5aa952d..07d4cb6562b0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -259,7 +259,11 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *=
smu, void **table,
                  SMU_13_0_6_MAX_XCC);                                     =
    \
        SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_TOTAL_ACC), SMU_MUNIT(NONE=
),  \
                  SMU_MTYPE(U64), gfx_below_host_limit_total_acc,          =
    \
-                 SMU_13_0_6_MAX_XCC);
+                 SMU_13_0_6_MAX_XCC);                                     =
    \
+       SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),       =
    \
+                  SMU_MTYPE(U64), accumulation_counter);                  =
    \
+       SMU_SCALAR(SMU_MATTR(FIRMWARE_TIMESTAMP), SMU_MUNIT(TIME_2),       =
    \
+                  SMU_MTYPE(U64), firmware_timestamp);

 DECLARE_SMU_METRICS_CLASS(smu_v13_0_6_partition_metrics,
                          SMU_13_0_6_PARTITION_METRICS_FIELDS);
--
2.46.0

