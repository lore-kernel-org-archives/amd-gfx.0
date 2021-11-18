Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA17EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 22:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884C66142A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 22:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 884C66142A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D563C6E062;
	Thu, 18 Nov 2021 22:17:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2060.outbound.protection.outlook.com [40.107.96.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC77D6E062
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 22:17:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJ82f3bQXTFtMmkRVhZ1OTFpjpkEvyEwXXIzKolB8Rb2f6I93xMxgvHTu7zCifhhttns7MnCCQtMQFVI435J0R3T/11lv4ZPMUVk4TpN+HMDKfDo53St/kfej4OkS63EwIyDwut+jUXHRKb1VooEK2l++XPas+2utjrWPa7zNKTB2r9186bTW34H+4jF9JdYhfrU4cjVyYBm9LOFkQGny1QdZZM6FgQe65CBKjeRdUPD+3Nk3KwX2mC3gCyrnCR5A8nPEpIWyoxykG3a6otTtnftuWJOR10CLIrutSqGhNXHGkzl24A0ghz3eiqJegYFfoqafjsjDExZeUW0VYa+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caCct1i6+cCVQPUwwaTDZNIi5fx6OnfbiqqHrnfctoI=;
 b=X4fA+bZEAOtW2Cfyyg1XLoLMlbI2/jMXMZXIjXL+NjFTua1rs2jVOlulBYo/F+fUtxp9BS06HFTfDNBjN5OdjdTNlu5b5SB9JbidiQnhWUwO6jvl8Ay+bclYS4rdTDj3x4ju4o3D+t73q1XGY/v1MeCux1chU9yhL48Z5oxF3GY1bpWbDpDx9ssR0ZPOzWv5UGUJ5J5QDd6WmSZTNQzU8WRh1WK4tVSmH8jIOgbbt/ZgUSLR939PhGXztO4PTe+lrU0pRZmtO3bDTYi8rZpbHsXn4k7aEEslpw9JLeAokKNqAFBXYf7By6sk++ZGJZw4bvsLOrJTtGD9Vm3oANnrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caCct1i6+cCVQPUwwaTDZNIi5fx6OnfbiqqHrnfctoI=;
 b=3aMCudbl2Di8Atczr5s0Dle6nJP+5/HkixOqVE6QHesPM+zKRvihdSxbQDiyjF1hkaTef06WZfePgdeWrZahA0sMihVOOIHu4Y7Q7qF9XV5FfX9ZwLfRbS76Q/9IYYh1PlrGQFBbsmodpcVDLF7EMsC3SOBc3Dq2CV5jhIzoG3c=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 22:17:44 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830%8]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 22:17:44 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Declare Unpin BO api as static
Thread-Topic: [PATCH] drm/amdgpu: Declare Unpin BO api as static
Thread-Index: AQHX3MlVW9ZXMEb6S0+w7I/pB6756awJ2ohJ
Date: Thu, 18 Nov 2021 22:17:43 +0000
Message-ID: <BL1PR12MB5144B3DB1117FBA4513F6F48F79B9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211118221154.31176-1-Ramesh.Errabolu@amd.com>
In-Reply-To: <20211118221154.31176-1-Ramesh.Errabolu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-18T22:17:42.761Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 96a3f994-c0c8-b365-41bd-26a231e84aa9
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc0fc85e-9ef6-40e6-06bd-08d9aae13e63
x-ms-traffictypediagnostic: BL1PR12MB5349:
x-microsoft-antispam-prvs: <BL1PR12MB5349991ABD8D5AA71F70BC2DF79B9@BL1PR12MB5349.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TYbftl5iRdHo8vuymZM3pN4pcnbIJSxM7rHE5G+/2vILzPqJ3OQL5d41EEQY5h+PMx13qEfxErfGsn8tkebW67CNqrwtjImAF/nwLGn/u48TPEKxYmsUd8CMGll8mnul80VQmPbGn64hVXz2xAJP07nJNAXKG8t4pqttoV9aMfKCwu2+VHycM7VIAz/v5FEBQ7zTslyEcML21GcvtvtSvUDlP6UFGiedqs1mWvacjThxvnGHpbXVuDKzK01AnF5nstRxunWOPT2DbmrqzqslCUxC7JC3s7zQ1MOYUPPXb8j9FjhnMhJUnCcZPdyaWSwbN8buRP2pSY7JDpOwiiQIPFThmlsEU3Ga7kTdAyYP53A+HQ74GuDIlUma1uszR109O0O6M6H3slw322PMLYXlJJCDrmHsLjf9IKz1YvpVQoxNndgMOh5TdiE0T3wUI0jpQCMWKfhPVOtIIRgFxqD9MMVTDK3RYaSAw0hZOpveii4KZk+W5wvHNyHwOevOySCrx02nVa1abXZMxKCrsgayBg5iX2JmBhhCv2X90vXisFTXtIvLdooEoVbrwrWiBn/31ltRnkhZkKsJb2KJ/HJ6OToZetT+3z4juYvrbmNN9dMF6BGg3XNqU/IetlrlDKdVKoCJwOq8TZJIG1hbgE7jgygvwq1M6FSu8AdBSPEh1eua6AafGnIQVwf0gLF0JZCeGG4f+TK7Rhz4oe1kFinn+Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(19627405001)(66556008)(6506007)(110136005)(316002)(53546011)(66476007)(66446008)(64756008)(8936002)(2906002)(38100700002)(122000001)(8676002)(83380400001)(76116006)(66946007)(7696005)(9686003)(26005)(86362001)(4326008)(38070700005)(71200400001)(33656002)(55016002)(186003)(52536014)(5660300002)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KpGFY7ST/f5sIV1/1vzprA9K/nCO1I/wa3COIcwEQmhThtKaOwSegA6LbxxO?=
 =?us-ascii?Q?4k/js5HK6ys8exndQAUTsXLqz3+8X7amGRwx9tFknpdo+CEhtLLXiIx1WgOy?=
 =?us-ascii?Q?0LThdSqmcvHUVsC7UeQnrfdiDORv1TDvzo02VVN0ZKjv7xubmykE+klNBryT?=
 =?us-ascii?Q?1+W4fEzFRnk5lERbKD4o9fhpXNfsQ5GgZMx6ZWapK52ikHSILmCDf1na3KA8?=
 =?us-ascii?Q?rjGqg85h4nmmHHZ+2AH/yLibefx51SEKVITyeZyALblzhivoP57v3z5iSwmG?=
 =?us-ascii?Q?D6GJeTukXSxQilAwSuvTR5Wkn+YaCHiSY3jGmiJudMRadL3qYhk7VD+So66c?=
 =?us-ascii?Q?Op115AJwXuorRqgq/ggsx+g/nwUyyoAOOw6dRFsz40/ATj0if2Cb8RjiRVtW?=
 =?us-ascii?Q?BIWqrTzSsrWT6rc41qOmbijM01HXndSzNfn6EOqjLJ/F/qq+TEXelFvUCqv5?=
 =?us-ascii?Q?kJ53jOJNfBRsvDfqso73+s1sPldZ9tLlFRAxxJmzaJZQmpxsN50+3z1PvGvM?=
 =?us-ascii?Q?itcqQA27YiNcRe2blBsnWvEABRshvuEWXgcwJOmT61ngLvZPqjYlJ/pEjfKx?=
 =?us-ascii?Q?mJHEhHj3Uy2ns6C4UV59ZzSlo9O2xfFdGCUmVEb5LRwYdTlfzMY/vBxFLbcE?=
 =?us-ascii?Q?VQy74DN+josmVaWwHYCRbhexihF3Hsmm4/bVg/sU5SrHu8txx/Wfo3xAWROb?=
 =?us-ascii?Q?SCNeUcX9EqQ54BWHlJUTzbkQS9aNc7eDkGKE+4gAKxJuTqcnjTEZYCTni1pa?=
 =?us-ascii?Q?9fctZpWtnLQ67w02oCEvhz/XZf1qXNfLse7IJI8FCfHgNvyhvqJqAJUPoPfa?=
 =?us-ascii?Q?7ivWGkyGEbf3pXbePdh0yIqgUTmpWyyQH2VZPCasOVJelLcR28XWiVZndJ+/?=
 =?us-ascii?Q?tXu576UdHtP06x1B6i5iUyrr82/xmr+VfTUe1m+IKI+dDDWvR+gvStT8LtMW?=
 =?us-ascii?Q?Hc1f63Cad5NtpA20CaRHJYzjn+t2rUydXLk0GiPS9KVdtBgxwc6C0Td9jPxf?=
 =?us-ascii?Q?od18Apuj0cN/dEdhQ6E++paluuqj37pxPiKo4ZK+Geg6XINfHCLz21EYLCzD?=
 =?us-ascii?Q?mRKub+mRfNoAgpuRXarES6kg31ow8r8BXL2XrRSXjGnrNOzE2G7RRvF7/Rg1?=
 =?us-ascii?Q?tPwgrC2l9ONSiXzsXDo/uwIviSLZ8COrowlURuRe+UUe5RUwl/fnb+H+csaA?=
 =?us-ascii?Q?3AU8Q5WU6J1Wt2JjHPBMJxDBmDTOPslGGXqFV5mL1O1Znoc3bIVT6lw2fxwV?=
 =?us-ascii?Q?aMKXhLpdLKCy3h1qHvn/ZWgutXWrnryx9t2Mu+BkwehJnLYff2nC3HnTlsot?=
 =?us-ascii?Q?xNBNZVJMvZDLdz/YHkD0Vc+SLM4kLDFYazrbyHHG31d5bUNqE6LlpWl58WLB?=
 =?us-ascii?Q?JKiynEXBS1fbJKThUviQbACopk3Z4cbF7iMHG1j4NdMiZllfxo4+LnI1Nmr2?=
 =?us-ascii?Q?jF0nsoJJxTLFKTmWpg9+ADwUEvjqw+uV5Muu6uFj4uLx4QPboEVQuuCjDlUy?=
 =?us-ascii?Q?XLw8kLQwcdQN6borZsWJu4Ci35ALYPszYjrZkBagRNMH58pwVAmAIjWYaBib?=
 =?us-ascii?Q?RPXPq7umf+zM9FWkpEzA5D2QAqyFpPFXZIZek1wK5/SMUO4G1W3VbrnjquSY?=
 =?us-ascii?Q?hQ3+STrAJqvF0TXNBtmHgXs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144B3DB1117FBA4513F6F48F79B9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0fc85e-9ef6-40e6-06bd-08d9aae13e63
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 22:17:43.8914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rFNDU16wt6FElRmUI9Jg6tIMI/BWbxVKSvyZKSGg0ZS8dUF83S1SLY4m1ve3hubcRY1cCcTu3w5pYXKxY6+ASw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144B3DB1117FBA4513F6F48F79B9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Ramesh E=
rrabolu <Ramesh.Errabolu@amd.com>
Sent: Thursday, November 18, 2021 5:11 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>; kernel test robot <lkp@inte=
l.com>
Subject: [PATCH] drm/amdgpu: Declare Unpin BO api as static

Fixes warning report from kernel test robot

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 90b985436878..3463e0d4e5ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1332,7 +1332,7 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_b=
o *bo, u32 domain)
  *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
  *     PIN count decremented. Calls to UNPIN must balance calls to PIN
  */
-void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
+static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
 {
         int ret =3D 0;

--
2.31.1


--_000_BL1PR12MB5144B3DB1117FBA4513F6F48F79B9BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Ramesh Errabolu &lt;Ramesh.Er=
rabolu@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 18, 2021 5:11 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Errabolu, Ramesh &lt;Ramesh.Errabolu@amd.com&gt;; kernel test ro=
bot &lt;lkp@intel.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Declare Unpin BO api as static</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fixes warning report from kernel test robot<br>
<br>
Reported-by: kernel test robot &lt;lkp@intel.com&gt;<br>
Signed-off-by: Ramesh Errabolu &lt;Ramesh.Errabolu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
index 90b985436878..3463e0d4e5ca 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
@@ -1332,7 +1332,7 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_b=
o *bo, u32 domain)<br>
&nbsp; *&nbsp;&nbsp; - All other BO types (GTT, VRAM, MMIO and DOORBELL) wi=
ll have their<br>
&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp; PIN count decremented. Calls to UNPIN must=
 balance calls to PIN<br>
&nbsp; */<br>
-void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)<br>
+static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-- <br>
2.31.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144B3DB1117FBA4513F6F48F79B9BL1PR12MB5144namp_--
