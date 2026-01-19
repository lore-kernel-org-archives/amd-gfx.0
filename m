Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E126C98315
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 05:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B5810E0A6;
	Mon, 19 Jan 2026 05:43:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qGKzOP1B";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DB3610E0A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 05:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKy0yR1at54Jo+97bfpO7tPq6UMGBrLQB8OatF7y3c5Sb7GxV7bcWMo77MmQxf9OjMHlfKz/0+qEtpH325svZfDzbtMug1o+flf7Z7u2Y1o2FvZDtEF1c2QkE98vmV4XiHu9J9NazrrpHHkB/g/kqNxX2eNlzwznKRP+1GzvMb7vRf/SfmgSY+0boEsC0w2RfxTq3YZ4jmmv8KDarLWby+vuQgMXRAeYwHIC8oV3o4tLpiIkGxzIIvwgyGFiMqENsgQSUf52PbRjxWwt2Qth1FP67cWlCUUcMlS40a9CRpMCH2C7P6PyN2hvUBAZgh1HhrgYT5drZ6yIAK9Ek+D0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf8vD7ELeOPWYdCSb/7bsvJCKGJZrg+NYs4PWz96gjE=;
 b=Dv25PAkQmvY7gv5TdD4h4o2n4OBc9t26w/TZGI1/FUMmk9RbP/ozlwocs7zZqdykdEsQR48sLIDJcKFmodMLcWiIceXuELyI2HBxP/YvuMWSq4EoAqnLFqd/M1jzPxX18Il5ZGZr6RE2DLs+hxV0ouoWrytDS9HVxS7OIH4tWk4gb9udvF9uOyFNu1KJ0cQkW/4hZClsxEpYHaFqUgKRy6bkBSBrAe5T1ifO0hUvNqaFPzMSvHReixtXfVNHxivS31SY/65QsmeKgGXGSJvaog3rWNfsoNSpjSDckcy7dPkyu2lxcx1/s+zm5XIb26IRduq9y/GFjzBQzbATW754RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf8vD7ELeOPWYdCSb/7bsvJCKGJZrg+NYs4PWz96gjE=;
 b=qGKzOP1B6KsXpFFU9QIoAR9ojXP7I7OphBjQ1PW9VS/nppNcicm4y8QwQf3sn0Ehpn51KXyxsyNdGEnXpwwCSCz4NqLSBe2NwyN4HYuf0jdMXjidYeNUtuWnhBtsgbGVEB6+PahLCtcoZEItUlx9hD39eMu822QAeqnZOFJ08Do=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 05:43:20 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 05:43:20 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] drm/amd/pm: Fix unneeded semicolon warning
Thread-Topic: [PATCH] drm/amd/pm: Fix unneeded semicolon warning
Thread-Index: AQHciP64fJO6cDg/5U2oD9wSAUKvarVY9c6A
Date: Mon, 19 Jan 2026 05:43:20 +0000
Message-ID: <DS7PR12MB6071520E8F4448C9ED1236A18E88A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260119044701.1026057-1-lijo.lazar@amd.com>
In-Reply-To: <20260119044701.1026057-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-19T05:24:34.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SA1PR12MB7200:EE_
x-ms-office365-filtering-correlation-id: ec3512dd-f484-44c5-28c6-08de571da713
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1JPnYda4GI/o56G0eJ+nPm7RvejXKXsHFhzwGfZQ1BWkEI6mmgwh/WvfUf6Q?=
 =?us-ascii?Q?3QiFlZsyI/+CR8Xg5E0Ky3GF5tS1UH62nc8L1wfL6UXiVpj6cfxVljbpn4Gy?=
 =?us-ascii?Q?KAtbx0imC8kOx2eb7gsuJHjw7krNgLaZRJhkdfozc6+t8CKV7XU+pYdPeVwx?=
 =?us-ascii?Q?X7CdgUrl8BZuVEbQNxHDE0q7/LprzLc9jQh3TFdORTXrnA2QpYeozDcncEik?=
 =?us-ascii?Q?vEtPmXhBkpmPB6UUoT0GMG3xyrJkW7S3S5Svk1U2bmpV8uSno7tFMXHZx7m/?=
 =?us-ascii?Q?+KWNhAGp5Aky7DEDzG5+BbXudULRbOjQb3nKPjwmsRuz4PVN/Aw3nVaF/MjN?=
 =?us-ascii?Q?9ewbVp0Lb72DT1qd0pfijmcVmezRG7RY11A1yPn9tLVFGfGG7D3W/6SsXlTl?=
 =?us-ascii?Q?Itw5BC3Y6a6XeCY2glMmK7D7bX7hhD7lFYH1NWOT675eYw7GAnXB/Hun6uhr?=
 =?us-ascii?Q?bedIdtdBc1y7Ze2k5Tp2lpmceSrRVA09QiTb38aIkKqwUD82yWA7D4VBXIed?=
 =?us-ascii?Q?milRyGWlqG4HgveGUWNMYX+4DYX6Lvw7jTuwxYEtJH5b0hD8GswL5SR7D5gf?=
 =?us-ascii?Q?4F9TT9RKhvmCtghf61VK3Xt/BAaKblBs1zIclTW62Qdae+WV6f3/CrH49sCN?=
 =?us-ascii?Q?SW1fEuXcl1t5ar36nUFdqwxoQiGWX3BBC0O70bZKek/73DkC13121BESkhXV?=
 =?us-ascii?Q?pjg/26PzjRn7GKegfZcjjAiaPIofm8bkAD2bll84LMOEOFcbFFsbW4gOKgcH?=
 =?us-ascii?Q?cdtaFSkad2bCA+gdsh1M7l02e8dYAZsqAs1sQts2kxlRkAyKZ32w5Hto9BJK?=
 =?us-ascii?Q?bET66Ak5GbSRDdN0TTpNnqO4kY5UXCjw+o+O4or6NGJsEQAUICAIruL6pm0X?=
 =?us-ascii?Q?dI/T9yWFIWY3zYCpBfjo5re3wwufFX0JlMCeTfWt6uBzNF+h14XTf8ok51A9?=
 =?us-ascii?Q?AnsQyonfatz0np7fBfHY4K6Zbt7Pa7fMAjxZ0vMEuVjR18cpD8/gvMmObPSi?=
 =?us-ascii?Q?wJdDHpoGbZzXkvadq4xQ6to/vTK99fM4uzSZ/gQ3crfCPZJIanGFS8EvZa+l?=
 =?us-ascii?Q?7MKwGjyk5KALGIAH7Mxs8mB7/42gTuo6fgYJvPsVx4Prgf+f7VukcVRYdS5z?=
 =?us-ascii?Q?wzkR8ppH6Cphht+S3+H1FTGRblQ9jTebl7wAJkqAhoQ1zqV0RpwwG8FicLlY?=
 =?us-ascii?Q?wMdeOlWpA8mk8IbtO2fusH2YZgPL5lAlCJRqyMIFUciXHURlc5LV0BpiyD6Y?=
 =?us-ascii?Q?8M5q/00hKNufi7Dlw+lHHnu5gcWNJ1lwXQYNKey0VMvSTmwV9aAZCpYjXZ5S?=
 =?us-ascii?Q?u2b9ZwpS0nvwXRXMQNnb22HOxF1iK9ckpScZNLi8WbmTKzymGsjv1OUpZOYO?=
 =?us-ascii?Q?OupA9zq8k6XbUijX6lbyODFZNreboKQUoYzAUp8D2jwM4Ygwba8PyjZ8hzBF?=
 =?us-ascii?Q?SHLq/MOGL+s/tKX3haJVKPex8p5DBpem5lM5xwqDvtIePbZSRA1+NzXTaX2O?=
 =?us-ascii?Q?Jy5sbil9Q2Zc6N58des67QSXOpBBuHlXVuhDFPVbB2LSaOHCAI2hMmBOsK72?=
 =?us-ascii?Q?pm8p1HNB++7Z8hcgwCGWUncAWfqTEKWLS1J6SLbKYGecezw8H3N9QrdbBCyp?=
 =?us-ascii?Q?kbR5mdRYRtTxNWVQNh+JDmQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EjdUdz6qkR+lct2PiDcjwAEzp4QGAGeMYcqtjO29CjPxDvpq4tuRDFWYga7s?=
 =?us-ascii?Q?gqmIeXyb9TlL++dWw4KdXy4VtftNbckHv10k9cTGr3pvX1onrM6DbcZZFij4?=
 =?us-ascii?Q?DJO97+f8Zhov/eb+aCCNoLDQnA8uAArgvy2ZH9PBih6ydhkvoETHr0k81hoB?=
 =?us-ascii?Q?IBFf5gkciyoPpwVb8C1JX71q6A4C1MVqqpXs6TdGTeYfdHdf3SQAavLq2aZK?=
 =?us-ascii?Q?plfjz2F7/s0oPd49JGoIi5GGpfq+4yeXncg20ahYzy7aWeWm9q/C0bwiCj1T?=
 =?us-ascii?Q?fMFECuQPI45hXXofBxRw9gAuZuMp0ERjxQG8QKL/B/1mGxglUUL1+cnHq5Eh?=
 =?us-ascii?Q?ZXSPUeX6S2jTfopDWj/OS9DOsI9mXIrjKELFLV6rc2zT5ywdUcatLAcAEgsN?=
 =?us-ascii?Q?bIAjPfij5M3hubTHxemENzGNyOyRKfcqMiVThDMvbOD4d6E52ZuMTSJeQAEI?=
 =?us-ascii?Q?hagr2OnEivaj/vYUGy1JxZ8q22a+8GD4YjJOr6OS0AvY6fea2iDe0GlopYbH?=
 =?us-ascii?Q?dsEsaFDR43CngRpH+cdoVDeb83fSZ0PVPBG9ufMxxLnJjVeAFz2v3jLKyTq0?=
 =?us-ascii?Q?sjsEGcaIFjAmv3UDeaAhBcN6FMUA2zY59nJAriFmQh/bIK1/y8xNFu+kc3OF?=
 =?us-ascii?Q?G1Wxi/+LaHEi1IA2CUtsFRRGcaH/YRa/5qKlf8EJfh76xh5T4i4GE+jQF2E4?=
 =?us-ascii?Q?1QLkb+hmb7xnEB3G7scKiM4tVUg1JN0rIHj6fw/P23qelXyCYurR5Nn1PJeL?=
 =?us-ascii?Q?C665cP9QZq90eJ4o1y+C1FonapIzxePwVbwrCUtK3Z/YgJ38gGqejySj0JwS?=
 =?us-ascii?Q?hlmTpJ5DivL1Zxk2UC242GbnKOsPVNBUZ8Q5QEluFOrXIdAbswHN5Lc6NuBd?=
 =?us-ascii?Q?ZmE82Q7WZ5NzaVI+yCYBg1Pj6MJXgk23sCYxCTVaablG9Q1OEEBKzYpx/QZF?=
 =?us-ascii?Q?eKG8QdcejivNYIkgiUXcLCPf0od7X7gtlqovRnPW8MAzlRdEK0+k53l0JAcW?=
 =?us-ascii?Q?vSV1uPDZfddDrXBPDUTUuDQhIIrhLRrinJ13q3Kdmmhm2k/sIZAFZ2IwrfZC?=
 =?us-ascii?Q?1V8oGjBW5qIehO0GKqO7QHmXYJbeKuUuKTRQporuItSt5VeZrK3ZRY4nodxx?=
 =?us-ascii?Q?IVYbwEYsa0lz1Wk0n4ab9Jlu2/mCRR6iRWuHkX4bECUAjxVVM/KSdFvAwSv0?=
 =?us-ascii?Q?ZpzqXe3cc7Btkuw4Uk/rUQoqovjTtDUeocDeV1c+oFGj7w/uB3NGG+fnyQmz?=
 =?us-ascii?Q?jeebZBxtvhux3K4gNJPSG3dkuiOnK+RbQPqzvcXRZGsWt5y8ocVyMvCRESLB?=
 =?us-ascii?Q?a2KfaIQ64Xfhjtq1OzuiyDN9fi+8weL22KIWVhPof68JFZlehB9CR38RS6Hj?=
 =?us-ascii?Q?EgDGn+ItLT674ULKkbkQsx1cXibmISD5ZEJFpWNwTZV7xFu+QDhgdg5t7hMi?=
 =?us-ascii?Q?2qmnESni+gTtLTYiK0SmcE1Ue7cjRiHHCDblA+SpVgVKtPjS37+hI6StL/w4?=
 =?us-ascii?Q?WFvJBolkiNHenKa1vgbHvC6an2KeBwPfHik76wbQlMwG4gDprnv5N2FMM4Rx?=
 =?us-ascii?Q?KZhW8NsVswb+sGjczr22KkrsZ+89YnwavJfLv8Demxwp0dIunzHswkMfCZbJ?=
 =?us-ascii?Q?qE0HnU4Qv6h94lQUKfmGTixYbtOdJI7zesjVkoUV6wXV7uQGR23EGSfq6wST?=
 =?us-ascii?Q?pdGR2044VlFs7BFbNNd66D++SzZjwoqZ1pkzzpLhg6x0z+G7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3512dd-f484-44c5-28c6-08de571da713
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 05:43:20.1889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IkvXAjwdG2yDljvnA5rVYqdb8r1ssU8QI+jWk1EWeuYMzjC5NayoNImQfVjGgFjjm76tNakWPnrgiHhMMQtItg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200
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
Sent: Monday, January 19, 2026 10:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>; kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amd/pm: Fix unneeded semicolon warning

Fix the warning reported.
drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c:909:3-4: Unneeded sem=
icolon

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601182157.r1AfndME-lkp@int=
el.com/
Fixes: b480f573a8ab ("drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.12")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 44d5f134a87a..9a34e5460b35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -956,7 +956,7 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *s=
mu, void **table,
                        gpu_metrics->gfx_below_host_limit_total_acc
                                [i] =3D SMUQ10_ROUND(
                                metrics->GfxclkBelowHostLimitTotalAcc[inst]=
);
-               };
+               }
        }

        gpu_metrics->xgmi_link_width =3D metrics->XgmiWidth;
--
2.49.0

