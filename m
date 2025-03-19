Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1068C35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 18:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD5D10E570;
	Wed, 19 Mar 2025 18:16:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R6ezRisM";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5F6610E570
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 18:16:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyOXEQAjmIqDh2TPeFFvqNeUyyvbAr7Ssnn56451dj1frtkzrT7TsMPNH6Fk4hXB30SjF0IfEvAwseBCFntJfRR5VNylWf2e3EcW0KWvJgg+Cka0FejjSpPceaq7T28Q9XHWVnW9OrKUM7pZ/ueVvwAs9B2/vhZYx6KOa0fWxLo7FycoLkawfUGeAmnxDWCZgFPY6Lf/ZdqVL+yQhBhFUOi9Vw9moEAF8V0ZtNrpzhCgBWUhSXwdL5j1EDL1BO2rXe55G4CqzN+TgLbKmyymgf3PEUOElC746+oODiYuwDKDLxYLfqiyWknUlbBN1CkCFtQ8yWIP32nizYKBHo0mSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWZdwYstgys/bVsEz9B7RFUoLaF8Som0aGqesRS4gTI=;
 b=qIib+PhU7N4YhdL3zbI68CcoCDX8IB1uR65jIemRdFar9GjNiIIe00UhpLpcCgThQe/fp8XCwkx78RnAz7sJp4pwPAAoRQedZ9uDA+k0Ee78BM3Mxt+o8JfCJYiBWiomPQjykfgpV7LaHRVUV2WRr3N8SHb12tC+yAjORHn4oiT5y+31L9uVrhGtfi/33Oo7sth+YQ3plZsI4nJuhYEgCqvBat3J5IEjDCLq+aL47gYEgNy0ejdgqaPuxKUDMrIOI38Jy/k0y99/WpeeYj86ipn97Pa4IflkCo21iLh+sAOU0JEMNmQmi6J4L1W6wbjH18I+qq9hFZqFce7WMklPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWZdwYstgys/bVsEz9B7RFUoLaF8Som0aGqesRS4gTI=;
 b=R6ezRisMS5tvd6+31i3l3Y1+Z6i1ilTmw4oApfmoghjGX5/lFHz8blD88U+7//r+C00LnzUT5VxpQK6b183z7BE+PdpDGyV9mY0JAL/aCJ1zNFmSHAYqCv+FWKuFL61cSa534WbpD93mIxS1mHiOv9jTcp1MInX70/lfV30ni/Y=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 18:16:15 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 18:16:15 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu/mes: optimize compute loop handling
Thread-Topic: [PATCH 1/2] drm/amdgpu/mes: optimize compute loop handling
Thread-Index: AQHbmOtq4TKdcijUwk+pdt19OuF8cLN6w9nA
Date: Wed, 19 Mar 2025 18:16:15 +0000
Message-ID: <CH0PR12MB53727B21C81C6709EE27BA85F4D92@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250319162415.3776175-1-alexander.deucher@amd.com>
In-Reply-To: <20250319162415.3776175-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6448f82e-ed0e-4523-bf44-852052e21ca2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-19T18:15:07Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SA3PR12MB7860:EE_
x-ms-office365-filtering-correlation-id: d0de9475-3d76-4f0d-7b39-08dd67122319
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Q3Pikg5oINx9NSzSmya2iQEMV9+8hqpuV4rAxuqYuaYD7zUcU2mTpAgsINiX?=
 =?us-ascii?Q?FkIcbLdIdeWqs5Tp5wsr8swtxf3pRzKeE0ID0YsL3vkOWmvgV3lTl7GI8oN8?=
 =?us-ascii?Q?Maf65+40HQWFvRQ01qKBSDuMr7R7it860cs8vp7AJWG4rfc+16II1JIvqZd/?=
 =?us-ascii?Q?qpkWIFzYCcwYayaPqZV650WUePYJ0/Z9badOp6VUfAxQ2ipTDDm7rXcLRqr8?=
 =?us-ascii?Q?9GCeoGtRwGUgqx//arxIejK8xV9F8d7Bq4TiVLKfrZPFO2zvx6gtPq2bVG2M?=
 =?us-ascii?Q?OW75VJyeY/otmC2ueGzPMeKUJ0zopTAM3h3cx4QKxyye/ZZhs44NO8p3Amwa?=
 =?us-ascii?Q?lfBhUGdvu4jjebBxRM6c+lMtvvXNn9UZWYxKv6FYZHO6Y/SdaRRDVtfyzTu0?=
 =?us-ascii?Q?jN9GjghvQUexnNU8gpX9Mnxh0XSUopJLc7K+fw5CkuVgHhvZWpIhOHxtO9pO?=
 =?us-ascii?Q?2o+8WTAfPxEujOYu6AeCOVFiqP3GsWPGWZZ8nfJpQ8BtQT42qcwdAX7nqRM9?=
 =?us-ascii?Q?sR+4RVAHUHf976+8E/sRY/hKOow9LYnvC87eSpTbOP0AYoHUJmWcXthZG9w/?=
 =?us-ascii?Q?bSMyPyEfi7003y8rewAsfD7JRULs/qOwwU2tvUG2cqEa0/qvGRA3CjhlqkwL?=
 =?us-ascii?Q?RmlpldFFnwMpAKtI1M4gJLJkokrOqnDaknyTmAC/6id/qem+YTv0WUKKkRGN?=
 =?us-ascii?Q?mHjE1iYMgo6A3evNAMZfn7zzq3nmg2BTLvCGV7fMse4/TPOyOAp8BaeAegHV?=
 =?us-ascii?Q?rTUra5+I4dMc5laWObQshMCDjNc2GPUcjL8z2Dno13RuPfSCurtFaas3nGNU?=
 =?us-ascii?Q?mJlJ65OGE7D68i5B4Op9dIOBKBkqxFCQJq60ZTn4vsvjmMP6rKedWf4H9P+b?=
 =?us-ascii?Q?e4tN8hnFHjF+VbmsbNE/Gd3TacCPfB50/HFG6RqJnlyLJ0YQbMJhZOTllNcr?=
 =?us-ascii?Q?xebSdiuySgFbGazoXuMfZ3SCIyvuUWX8wvhOdlpDF7tiWF8/Ao78C2OnZcVo?=
 =?us-ascii?Q?MNwpRFDsNkMFIUeM6S54o1jkLsprf9gL0us4VzO+rwGlLHDmIqysBlelxGVX?=
 =?us-ascii?Q?Aqw+sTSmlqibUyLVVRnVzqE7jbtUS74NsgrodAv0nyi0HcSYaxNpdLPmm0WB?=
 =?us-ascii?Q?Ni5un+hxfWKvtje2ievRyqi9banWWw7pHXHAPs9BIqpnXEnM6zqQZ7fVsoNM?=
 =?us-ascii?Q?abjKXgpMNf6ujGZZEH1byme76RuY/6wsw37V3wYAphjiefrsK/jCaJsfOsLv?=
 =?us-ascii?Q?fnBi3tEFOYtPcC5KwIQhnvmCyhZj2UI093JjjWr8evYi1t2wLc+PARtILkNz?=
 =?us-ascii?Q?1Vv3saafuh4KwcfQMKUUPHx3RynlAkigNxrCtz4XxpjMNm0VSlNCNcW+6QFv?=
 =?us-ascii?Q?7BrhBVRjEmXennpwkF9It2sFuTnGl84/l7M3eBgX/ZqB/5d486RBGWhpsxlD?=
 =?us-ascii?Q?XQJIhuv93D/iUtnUrSB1T6CUWUqRoRFR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BoDuWKD37UAfxb1+wDCLpFbbxIzaPw5uYqq0i7s41czEwGgCFWEP9UDSHxLw?=
 =?us-ascii?Q?jigFHL89iiQ1gnCi5sEktuQreyVrZoG4SfkIc4zhKzSRslNf9TQt9XBpBFac?=
 =?us-ascii?Q?mv4CaB+hjTDzc9H1/GA9r+ei2LDRgpM+gm5zNzfUPoBSPrcjpz1Vu5Ev0Rfg?=
 =?us-ascii?Q?fifUXTBwv+eExF+1WKHU+H/wE/rWQyedp0nIpuZVIk0BV1OSnKi+TyKyZiUr?=
 =?us-ascii?Q?+iLk/rPHpqNQP1U8yKbOkAt8Ifkoyqo9/lscEJ2Y/96ccl/HCE5AWzXAJPZV?=
 =?us-ascii?Q?hS9mFhhQMhFHrOXmU/+qxgZxNFBUXR0gPUVoMwjCNL0TGLoraHXFi5c63Qtr?=
 =?us-ascii?Q?uxttxGw7tgcJdziFAleTOuGJUKh8c7OCGiBngHanbZfe8sEX83tkKJQZHHGx?=
 =?us-ascii?Q?j5LCqb0HN22+54JG/lNJEBvZJtzDZsM8QCf/VTaZHqWpvLvoSLd6dnLtXX+U?=
 =?us-ascii?Q?UHKY5008iy3OWOYZvYdj80R2DC20C6BK5M/Lp1kDr8EB62zeRd3VXSBgRF5N?=
 =?us-ascii?Q?ONWd8PEUot2kX5NRftP04RyAl1h20vyEm3EC9ez2g8Zp01SIJAd18gnGWVhs?=
 =?us-ascii?Q?KAB7XJDQUq0ymUntkw+vqz85NisldeJgOD17v8tPivOsP5H2E7FfbcmAohyC?=
 =?us-ascii?Q?G3c8YywJgAv+BowpMsQktgvzirg8tu85Zg1BQSaiTdvYw7Eh0mNkBA0WX6AB?=
 =?us-ascii?Q?M6wRMfSVEZ5H2vgX/DTgOmFZnL04YauM8h6AmBRFitP99jXfUchGZlqmgTJl?=
 =?us-ascii?Q?23Fsx2mHR0QRQSxl3xMa0K5vNL7Ac+fODduc26ueU3OxrZg4ceSplbeBxlzS?=
 =?us-ascii?Q?rFTKUjIaTZMh2U6aBuFHM4wfV/doucmsBmRDTXrKZlrotmDgq1eln7yAZ6L9?=
 =?us-ascii?Q?G3lCRTEUL8QqPNIc6Fwlm92YiRzmPskfKOgfYgLRYLrOnIN40tLAPGR3XG7G?=
 =?us-ascii?Q?2/BrluaK2w8XPVyKF5yke5Z5l7ZidOJT1JUSXXHxJ3DK5Zlga6wkB/3jswcM?=
 =?us-ascii?Q?/0Cq+h+T5DWF9hPIvO0gpOYzqRode043LOeUcfIjpPkepzp8+64/7Z2K0qWH?=
 =?us-ascii?Q?Y5y9ZJ/tCYRhTAOa8sDQQV9JMYB8dKe5npR1qyCe2vi1rUaIrfCiGQ59wbJj?=
 =?us-ascii?Q?p2C6vLj6CzTlMZeQ+Op43b9pu1MzaK+5Vlivhr847DzxQe85ZFzxYSZhrFVn?=
 =?us-ascii?Q?hPd+e4B90b1a8B6aEkG5+j5S01KyTNGdRLMONu1d/KSzEzHdIHbmmKuFVbDc?=
 =?us-ascii?Q?6XaZowSX+B6SW28qCjFLyYyxzRrGmmqUgGtFGIuIp9v/VbrLUm9Ni0Snp6hg?=
 =?us-ascii?Q?8UfhOPei3O8eD1ReFlBupS7ZDuUVIsyaseXow+obTPq7c0MGmRaXHKVTSN+w?=
 =?us-ascii?Q?S3/cK0hzd/lRFZBG46A6SMQ0oS9rF9akwCr93bkK2+4mhMulmGmbNsmui8dC?=
 =?us-ascii?Q?sm+2LJI6OZWM4M5lBnw2WDQ56INrEuOUQclEYApzakbxt/AIuZRda9PMMhEj?=
 =?us-ascii?Q?x5CSB1SsNERqHk10RBm8T5nAggMDFaeLt5wUDFYy9m3M6ognxouCxyPXIika?=
 =?us-ascii?Q?DPFfCjPrcHh0WZsGSNM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0de9475-3d76-4f0d-7b39-08dd67122319
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 18:16:15.2406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3IaANilQrDgBsg65vHs/WQhVoRYAsjgRWeHmOq1pyPF/qF7xfDcCotruBry5cb+H9NEFAzoO2f92vSUIoDZ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860
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

Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, March 19, 2025 12:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/mes: optimize compute loop handling

Break when we get to the end of the supported pipes rather than continuing =
the loop.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 6f5e272d7ded3..920cd1c1eacb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -111,7 +111,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
        for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
                /* use only 1st MEC pipes */
                if (i >=3D adev->gfx.mec.num_pipe_per_mec)
-                       continue;
+                       break;
                adev->mes.compute_hqd_mask[i] =3D 0xc;
        }

--
2.48.1

