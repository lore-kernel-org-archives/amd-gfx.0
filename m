Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C7606A335
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Wud58Ku5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B0D10FC97;
	Wed, 28 Oct 2026 13:44:09 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013038.outbound.protection.outlook.com
 [40.93.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBD4010E2FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 13:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uck32LtvBvIn1t+YGoBrzGIdYpM/L6cUyPXSxBDt0bsOByt9ick3v8Gj+K1nU41YNqNxGCyj8ZEK4C8O+WQccO4sqSYn35eCupfbfbl4LUmAiBlRHQSwNBbhma6SBFEJV6Nod8/jXVpVY2LGIVszilGHTIShA6Jcu2dKwqV6LYwONuUZ074BP8i6ipUfpqV6VlXFVRRLz+q/E6PKTK/lb38OEOSH4UECcXHHJIHBKaUj+h19bE2RZ7toXcVZWkGshIAeR9iuj4PfGbldpHq80v07K5+DPqx/Ci1HUiHbGkiMMvX+fqABcTfLQ2VMIkDxtrQ95cuYrA1aOwl2+Jz7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8GGeHUyboaOyv56HtK2vxihmxuyRmIFSKa0D/Duwew=;
 b=JEDkYqAZZMKTP/c482zduvS6/myqZ9AQWvPAaOpHmUOO4Z7+RXlZhSy5gOn3+X5SAjZmkXd66YbSMlhiBvxAEN7UWSR3NmXyTZRi2KImKh0/oIa6S3XrJdpFYRFCSBI146eQB67F731jX8Bt/jHaxnQyJdXPQc4JH1oqxXTFABzR9F4dPRWlInlV1rnb6UC/RUY/uK+nt1tYCIo0WKtAdutOAv5fy8kYNpNa7njCh0Q0k0l9R46OgX4G3gKlr88E4behnFQ2O0WopYsVpZYoqOc+p3oH8JgJwz2Kj3a4jI8pue7im+5z7Y44bHo/jQcVrgcacb0nVLP1tNQdw29/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8GGeHUyboaOyv56HtK2vxihmxuyRmIFSKa0D/Duwew=;
 b=Wud58Ku5sjIAXbgSuZalm4iHOqy/wCKnLtFngtcRDjCgIIZiY/7zCG+eZwdVi0AZTX08P0OQkuW0SVyr700qfZLSA2QQMJEIg4kPOwgmgDuWhQpc63PJupU2cCI2HkN140PS+N2ARj7XbnVA5YnLyVSr/tuAOU3wl+fL3UFUnbk=
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 by SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 13:43:57 +0000
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67]) by SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 13:43:56 +0000
From: "Xie, Chenglei" <Chenglei.Xie@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
CC: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: initialize VF2PF work before it can be
 cancelled
Thread-Topic: [PATCH 1/2] drm/amdgpu: initialize VF2PF work before it can be
 cancelled
Thread-Index: AQHdYjp+/PX8+IaW3EWz5MOPLRk+crcS/y2A
Date: Wed, 28 Oct 2026 13:43:56 +0000
Message-ID: <SJ1PR12MB61211F97F73542D12674EE43806F2@SJ1PR12MB6121.namprd12.prod.outlook.com>
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
In-Reply-To: <20261022153132.211631-1-Chenglei.Xie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Lijo.Lazar@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-28T13:39:55.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6121:EE_|SA1PR12MB6894:EE_
x-ms-office365-filtering-correlation-id: b67f4539-a0ed-4d1b-63de-08df34f98365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|261026140227099003|11063799006|56012099006|261021123027099003|261026121527099003|261009223027099003|261022075727099003|261009221727099003|261021121427099003|261009221227099003|261009223327099003|261009220027099003|261022105027099003|10067099003|22082099003|18002099003|8096899003;
x-microsoft-antispam-message-info: lUr/kwRgu5HrfqG0apNjpqLL+t41UynM64F1h2hvmbq9y0BcdDJRGGYDWrKRhWQu0CtKCxSGQyqXJu7BrJj3D+wC74e38oIFEk49qJfS4POAJ94JNTjyMCC3xFHKdIswkcr41xLIyDpGZDKJYCQ2wopkt5I/AToCwq8y4z9wEoN4wL9f4amE0A4wDk8W/ayMSpRWQjkYs3BU1FByC1NpiTGMxAICDhdwozv35r8COMU/NHGjRkzom05nlOzTia3i7bOf5GJUEiCzZrZZrXqPsacDVhumYd1RfqwC/CjhRe+esunwfv2nTBXqHIE/V2VErbhTDhsW/7LOeMK4JpzEbRdaWUO/LeAX/GP0KSfMvwrtyq/tW+fYEkDW+dmUuB1VB5TrDBtzQ0zOAh9fO3QInCOpNnsNNJdoHKhKl4PMruLAjGw9hMd2emxYtYjkPSha/pOaTRK2Y/Uko7dQWJL5354CTScqePyTLQTpkK9u2yD2Qo2FGie+ybtlABfhnR5jf9qK9QrJODrYYZ9EITDWAMekTDeCwPvQucrf9XAhJYvQOYZIVJMI9jc8VIQhG88uJeFYihL/zgpkTY4oetN7duOcE1iB9mPQ1VWXsBdspsiy+oWTocZ3irUwdwb07TU+fN4grAf/LTlvtfbOJKnDhvpz8U9JzMAwyOni2xe3+GueVGq3LDq/6Yw9928dTls6RYm84H5gd3e2uJbUwIsWsZs6PJmHFbi5TG9Z7Mb885g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6121.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(261026140227099003)(11063799006)(56012099006)(261021123027099003)(261026121527099003)(261009223027099003)(261022075727099003)(261009221727099003)(261021121427099003)(261009221227099003)(261009223327099003)(261009220027099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DRb6HOtScviYaFXKeWuBOHBgSGJe9ehBTdUNOsznJkznLbq4fazp/4JgRpyq?=
 =?us-ascii?Q?afbytPklVsur247J6h6Wz2Uk7dNS8LAcoDp2Y73Ru14VsVXjQndaNDRIswcW?=
 =?us-ascii?Q?R6q0I09dWlnOfGZW0FQeD3E7+UQxd+6ZVIVFT4PQYcQpXM6s38KHn+JNNrSi?=
 =?us-ascii?Q?14sYH6FL4skOabGWPsnlFkUk0pvkBhOiK25J05MpcUxeiyR0y/O11iAy4/50?=
 =?us-ascii?Q?BJisac4uoajNOzWtYC0Vjr4gGyVBt2QqnDKtOQsyhCCNEqPRxTDSe5kEiRY1?=
 =?us-ascii?Q?/YS/J/VSt7tEPa5Kxjod8az/ZjsDaWXRPWc3QQhiAlsEFgnkbFTvA0OdVw02?=
 =?us-ascii?Q?ZTCwCQ0theHcUn65RDqiE4fYEEM1L9HNKSsNg2KBlXTVwibtVQrZBQzZDa/Z?=
 =?us-ascii?Q?zUnuGhsbdnBvIM+lwf26fTx2G+o349B0bBNi1YfN5N65UTsd+H215V8Mzwyq?=
 =?us-ascii?Q?VIIrGhIElbNSc5R3hyxbfJAeEm04lAqtydIVm4sMRWE9DwCVOp1YVVJbIEsH?=
 =?us-ascii?Q?OnP5t7wfdoTwqHSvvnztvOi890DDMUmP+ALjTY5u27yxLKtSzM4ZxMSXj/Ln?=
 =?us-ascii?Q?uoQQ+6xouqQQuNjrIuSMSXaYM+biI9AfYaFRfHbhSzcCdQeJTgoGplw4lFer?=
 =?us-ascii?Q?83iBqNyPoif5boJcr+jeylEnHhDThu0RuXeHsISbvIxtU/6CnZ1M3OgGmBUN?=
 =?us-ascii?Q?6OX4AFB5OPMZ6hMQEgrF5rl2o++9PLbZZWb9WGOCVW5GgmETM3GaaNga/UtK?=
 =?us-ascii?Q?cTM2r6UBMGerPlZDXe39bNGyrxnJH8GklR23vZrDvILm0WGlyo57k6dN33Ea?=
 =?us-ascii?Q?YfkzobUyCDz5Fr+eh756zejLpXv5rkXJQaQUKDHmg1B8uKMvaIJGom2EB1c7?=
 =?us-ascii?Q?05z29qOPv0FOEV5pEKFbPvyKCnE7KUGKT9iNsbGhlUyDhJWtrbSc5tq1H+tJ?=
 =?us-ascii?Q?CoCrKRmqsa5WJUsMkXBrKn7/sh4SVJtAy0M+RpaCvcWbabrYiaSZju6wOXd/?=
 =?us-ascii?Q?t/VmYvWScND+k0vh+ZwnRi0YeQZq3PXAqiPXv1ZVpLZj0Mpv3yZLl2sRRAfZ?=
 =?us-ascii?Q?S7gdyHJNGOaggFxjRMg0lZ1PmP/BfezwHRaPk93zm3go/j0/hNBhSO8eR2DA?=
 =?us-ascii?Q?bF9fFKl1tETEd8emOgLJBFnIO9UVP5rsEqiyH5vctJprb/LlE9tpOoqMMfNw?=
 =?us-ascii?Q?NE4XDKJpj9U4yubgGPlcUCdKtJIHE9gzORlGiw4EcsUNCcFm4DtzMb3l8KNT?=
 =?us-ascii?Q?Ydg3i1os+84p+A+4mfhiRnKBUavnQLroBJXpTXjbfez7IHT+1k3uvtlR7AXf?=
 =?us-ascii?Q?ZJFv/TK2hOY5hkFNE9QeNbG2CnA44pgfG8ImHaHjlGfaJPG/706G42GjqKnC?=
 =?us-ascii?Q?JJYh5aDdhoCeuh4bw318CeGcEBWhCdBh1kwzz60oR6YxlJ4GiHhojFva/smt?=
 =?us-ascii?Q?Gea12eoa1wWEqdlbNuuARg08eVoFapMMj09THshrYx7tYJeFvlBThkUNPPnB?=
 =?us-ascii?Q?alWy5ejJW8YUYKSJOA66YuFedmoUkekuRUpKMjI771QAVEvtZN8U0pjzbglM?=
 =?us-ascii?Q?ew793cTxVx+pcJbGSAQWJedOrBMHQyuvL9C2+4ImmeeA1UnMpmDH52D2nYpQ?=
 =?us-ascii?Q?sjaz2jj6fA3vT9/UTiRm9OG5AenbJy75nFfbmSeQf+sGpnARk5dcrpIDGppi?=
 =?us-ascii?Q?1LC/AZ9jdbadIxwDO4IMwLFxcAZEWRpq7GLcGrWFiTe7/VNC?=
Content-Type: multipart/alternative;
 boundary="_000_SJ1PR12MB61211F97F73542D12674EE43806F2SJ1PR12MB6121namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6121.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67f4539-a0ed-4d1b-63de-08df34f98365
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 13:43:56.5342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2aivdp94q5OPcYujxNPQeQgVa5kv0by9gBJVmk2VKWYoaYgkKMTl2PtV/qfcm1EDvSut1uSjqFMzs4AX392drw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_SJ1PR12MB61211F97F73542D12674EE43806F2SJ1PR12MB6121namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General


Hi @Lazar, Lijo<mailto:Lijo.Lazar@amd.com>,

Could you help review this 2 patch SRIOV VF changes when you get a chance? =
It's been on amd-gfx for a few days.

Thanks,
Chenglei.

-----Original Message-----
From: Xie, Chenglei <Chenglei.Xie@amd.com>
Sent: Thursday, October 22, 2026 11:32 AM
To: amd-gfx@lists.freedesktop.org
Cc: Xie, Chenglei <Chenglei.Xie@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com=
>
Subject: [PATCH 1/2] drm/amdgpu: initialize VF2PF work before it can be can=
celled



The vf2pf delayed work is only set up on the ip_init path of amdgpu_virt_in=
it_data_exchange(), which also schedules it. But

amdgpu_virt_fini_data_exchange() decides whether to cancel the work from vf=
2pf_update_interval_ms, and the early init path fills that in much earlier =
through amdgpu_virt_read_pf2vf_data(). When init fails in that window, tear=
down calls cancel_delayed_work_sync() on a work that was never initialized =
and trips the WARN in __flush_work().



Initialize the work in the early init branch of amdgpu_virt_init_data_excha=
nge(), before the interval is ever written. The cancel is then safe on ever=
y failure path.



Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com<mailto:Chenglei.Xie@amd.c=
om>>

---

drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 9 +++++++++

1 file changed, 9 insertions(+)



diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c

index 4b1b42fee6b4..c1843c3d2692 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c

@@ -842,6 +842,15 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_devi=
ce *adev)

                            schedule_delayed_work(&(adev->virt.vf2pf_work),=
 msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));

             } else if (adev->bios !=3D NULL) {

                            /* got through this logic in early init stage t=
o get necessary flags, e.g. rlcg_acc related*/

+

+                           /*

+                           * Initialize the work before amdgpu_virt_read_p=
f2vf_data() sets

+                           * vf2pf_update_interval_ms below, so a teardown=
 after a failed

+                           * init can cancel the work safely.

+                           */

+                           INIT_DELAYED_WORK(&adev->virt.vf2pf_work,

+                                                         amdgpu_virt_updat=
e_vf2pf_work_item);

+

                            if (adev->virt.req_init_data_ver =3D=3D GPU_CRI=
T_REGION_V2) {

                                          pfvf_data =3D

                                          kzalloc(adev->virt.crit_regn_tbl[=
AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10,

--

2.34.1



--_000_SJ1PR12MB61211F97F73542D12674EE43806F2SJ1PR12MB6121namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if gte mso 9]><xml>
<w:WordDocument>
<w:DontUseAdvancedTypographyReadingMail/>
<w:DontUseJustificationAdvancedTypographyReadingMail/>
<w:DontUseHyphenationAdvancedTypographyReadingMail/>
</w:WordDocument>
</xml><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">Hi <a id=3D"OWAAMC800A2543C7549698A201BC5D702F3CF=
" href=3D"mailto:Lijo.Lazar@amd.com">
<span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decoration:n=
one">@Lazar, Lijo</span></a>,<br>
<br>
Could you help review this 2 patch SRIOV VF changes when you get a chance? =
It's been on amd-gfx for a few days.<o:p></o:p></p>
<p class=3D"MsoPlainText"><br>
Thanks,<br>
Chenglei.<o:p></o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<br>
From: Xie, Chenglei &lt;Chenglei.Xie@amd.com&gt; <br>
Sent: Thursday, October 22, 2026 11:32 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Xie, Chenglei &lt;Chenglei.Xie@amd.com&gt;; Luo, Zhigang &lt;Zhigang.Lu=
o@amd.com&gt;<br>
Subject: [PATCH 1/2] drm/amdgpu: initialize VF2PF work before it can be can=
celled</p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">The vf2pf delayed work is only set up on the ip_i=
nit path of amdgpu_virt_init_data_exchange(), which also schedules it. But<=
o:p></o:p></p>
<p class=3D"MsoPlainText">amdgpu_virt_fini_data_exchange() decides whether =
to cancel the work from vf2pf_update_interval_ms, and the early init path f=
ills that in much earlier through amdgpu_virt_read_pf2vf_data(). When init =
fails in that window, teardown calls
 cancel_delayed_work_sync() on a work that was never initialized and trips =
the WARN in __flush_work().<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Initialize the work in the early init branch of a=
mdgpu_virt_init_data_exchange(), before the interval is ever written. The c=
ancel is then safe on every failure path.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Signed-off-by: Chenglei Xie &lt;<a href=3D"mailto=
:Chenglei.Xie@amd.com"><span style=3D"color:windowtext;text-decoration:none=
">Chenglei.Xie@amd.com</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">---<o:p></o:p></p>
<p class=3D"MsoPlainText">drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 9 ++++=
+++++<o:p></o:p></p>
<p class=3D"MsoPlainText">1 file changed, 9 insertions(+)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vi=
rt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<o:p></o:p></p>
<p class=3D"MsoPlainText">index 4b1b42fee6b4..c1843c3d2692 100644<o:p></o:p=
></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<o:=
p></o:p></p>
<p class=3D"MsoPlainText">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<o:=
p></o:p></p>
<p class=3D"MsoPlainText">@@ -842,6 +842,15 @@ void amdgpu_virt_init_data_e=
xchange(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_delayed_work(&amp;(adev-&gt=
;virt.vf2pf_work), msecs_to_jiffies(adev-&gt;virt.vf2pf_update_interval_ms)=
);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;bios !=3D NULL) {<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* got through this logic in early i=
nit stage to get necessary flags, e.g. rlcg_acc related*/<o:p></o:p></p>
<p class=3D"MsoPlainText">+<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Initialize the work before amdgpu_virt_=
read_pf2vf_data() sets<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * vf2pf_update_interval_ms below, so a te=
ardown after a failed<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * init can cancel the work safely.<o:p></=
o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;adev-&gt;virt.vf2p=
f_work,<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; amdgpu_virt_upda=
te_vf2pf_work_item);<o:p></o:p></p>
<p class=3D"MsoPlainText">+<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;virt.req_init_data_ver =
=3D=3D GPU_CRIT_REGION_V2) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pfvf_data =3D<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kzalloc(adev-&gt;virt.crit_=
regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb &lt;&lt; 10,<o:p></o:=
p></p>
<p class=3D"MsoPlainText">--<o:p></o:p></p>
<p class=3D"MsoPlainText">2.34.1<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_SJ1PR12MB61211F97F73542D12674EE43806F2SJ1PR12MB6121namp_--
