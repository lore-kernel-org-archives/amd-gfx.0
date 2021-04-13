Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA24C43460
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 14:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9A0610CA
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 14:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9A0610CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3864D6E1BE;
	Tue, 13 Apr 2021 14:12:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D7F66E1BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 14:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzxgLoHBkMpjo848bTqUb2Y5sBsZs/ZLRMz/sUh0oajxIlvjh1PTTHyH/5y3qCpTQCtRKOzEmlbGSrMYqkaEF6kawm/TQIKOiXQuY3WvYg/qV9lUjhtNlBb3/bj2we5hg3MxTFBcL6ovN3CP14TNRDkjrcC/t3dl4XrpU/8hc8alwin+FRRug82IHOIKxat9LQjngVCnYYxFtKX+/Io7dsVVU+rNeljd1fn/B573IuUwILjV1dKyVX6LsRo9cTrdW95TiZ3zA7qIXgdEdGB3oyMNwH4AvHqM6iNs9uGvUnIovP2/YrzU6yAYfcvIVo2iSVrRMiiSbc6UrDzulIKbWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmHW3E94bVV3x+VhntRiyAC5AF+wU9mE3NqmeSZTBTY=;
 b=UBAoNGNImUTUH1lZffKN8V3YmPtpIunyTvSUCMQG5LqwS8H7ctFSZ4cWDH9IjzOLbaOArmRYPG4nPr2WS8bsAV/EBkGI0Se+ysY29VbZMsxR4oBByDoWInPAUPIZpjjAQKmzznWh6B+109qKsbm6GJUYnh6IYXPBTensLuCekc6dLwRYplrHI5qbMgPr5mk0moGS57wwvZP/aBFup+MI9bpArKbAG2kmjONuUQS8CseoOBmbUNOb4MwKz0jJ6atAwMbLMMAIJ709W4egrVvH/+7HE8oi9Qb1U44OnobmVOR+52rwu3W0+sWHKNi0+mcqGkwJLK+j7vC5MK7IMqDPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmHW3E94bVV3x+VhntRiyAC5AF+wU9mE3NqmeSZTBTY=;
 b=owteBPTJPQyru3mWuXP4HYJUbd0UWHw9sYDNKHnrjZPVNIgAD8w/hVzAo5c27dJBbGcWmbgWMQ1u2ybMOuWbyjk4AhIzoMOLgc3rsPAsuPj7CIXyk8QNt4n3ASWwCM9CCRUkTKucJkNnTvlN2vKRV59tyMrhQCvkRreA6/m75+s=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2434.namprd12.prod.outlook.com (2603:10b6:207:4d::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 13 Apr
 2021 14:12:08 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 14:12:08 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add graphics cache rinse packet for sdma
Thread-Topic: [PATCH] drm/amdgpu: Add graphics cache rinse packet for sdma
Thread-Index: AQHXMC2Cvv7O1bkp80KwKEz8wqMAk6qyfXff
Date: Tue, 13 Apr 2021 14:12:08 +0000
Message-ID: <MN2PR12MB4488C415C75E74F4A2A420F8F74F9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210413062300.12558-1-Jinzhou.Su@amd.com>
In-Reply-To: <20210413062300.12558-1-Jinzhou.Su@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-13T14:12:07.664Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae03dcf7-7f28-475d-9b47-08d8fe861faa
x-ms-traffictypediagnostic: BL0PR12MB2434:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB24348EA894CBC24F50C65BCBF74F9@BL0PR12MB2434.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BLBiQZxujm0fkgN7KpYQ3e+sCBt0EJrXw2U4+JlNG7qqck/5HCakL0n0cUEMMijGx2MG3uxYKnVnbHTmFyD63w5eEmADpEahK6sjwxpz0NG3dtYhAafBP8346AI2pwR04lN0KRSsfqrJD3OHtEkdH8FWtznHOctDa1UauBQmK10vP5pe2PEPGG8vn2QsEBsafeAY59jkP8hLNtR2BQLkvmx0D7bzmE2h2/KpS0a/bZDsKQTRfkoITjV18j6YIUKyzZ6XvWMrPRqdH9NuSJa/N0lYjB+kF3+cmL28WVqCgMGPN09b6RRY+w+l77GVAA37mb/w470WLmtaSboBZw23UQWhLNirfm7CgclX81DuVun9OYC6NCaHbL59NOIMEbefTX+82RaKCkQHGx7JbNuvl2oyejhHbwvtbPyNtG1Ou0wN2ym1RWlQNl2yWmmkUbYZqMz5gMsbii4RyfSCrRalNXIWvljZzF8kYi+N6tK2LhwP9ahbdbWrY+PgguPexMvvRi+aGdba6N962Ybf1YyX4EcAKefDsDec+0rpfYmAZEQdpY52RLnPtGJQnaQm+zWFO/xLxHvfYxn+2utMlX435K5Uum5P12NBMQ7tD634Q0A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(110136005)(7696005)(76116006)(2906002)(54906003)(66446008)(38100700002)(122000001)(5660300002)(186003)(66946007)(33656002)(71200400001)(86362001)(8676002)(4326008)(6506007)(55016002)(478600001)(83380400001)(8936002)(66476007)(53546011)(26005)(19627405001)(66556008)(316002)(64756008)(9686003)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mOAYknpIlzTuVNJ635dTdxQ8KtSOCiLgdH+KstzQtZu0N2hS2EEy8AUE6Awq?=
 =?us-ascii?Q?xpGpikGKQCsNO5h4au+/x0/dP/qgRGSklEpV5BuZYSBsL8C7GF0liv3TzvpU?=
 =?us-ascii?Q?USVp7TQti/76JJUMCrZQNSgwRnV34Ga1wSiUTiAMQHNa+710YAy0C4NpzC5K?=
 =?us-ascii?Q?YWy1SYN72aOCwdUJQrsnw62OmGnhwv1yK0V/Dr5/bkZkjqQbOZZVA3/FcLY4?=
 =?us-ascii?Q?oR21E0KHQatRZDEr5LXoP5anYdmQ+tSuO6k3vz6BSXHAl2uh6kGfsoDbdL0p?=
 =?us-ascii?Q?M2GPqS+GVXZzwNeJl/0P2G5IfnIlyAt34XxvzW5Ff6axAS0a8vV4i6mT4mXr?=
 =?us-ascii?Q?Ao7RE/vbb+X1TL2dG0hygmGGphTR857wzBtLMs+gHyzbWveIJhI0/nPyy0ie?=
 =?us-ascii?Q?RiEco8Oav1u/WvhRQaYDn4cofnS3lzS8rnPC2GiuU/GMNwJ+yQ9JhwPpAy0t?=
 =?us-ascii?Q?CWq/P4Tw2xCVe7Ev70Kw39nvwjlOYY0rAw8OMVgscsKfxi/wfihBvQSZ0iWo?=
 =?us-ascii?Q?wgN9Ho1xbFbxSl8TM19HakC6V0CimkPem4MKQ9hAVpRMktWWpjOinSfPDcpW?=
 =?us-ascii?Q?JF2aQVvGS1nO8WxOQEHRg3Fkx5ZDNLwSHREszuvBvmyGPGCc1GVAJGib7bHV?=
 =?us-ascii?Q?3D+zT1ZbYifI9r0pdBd5SiBD2M/YsbKVSa4suYCCFYfHGD+vmF0T2lnLMSUG?=
 =?us-ascii?Q?42i/Uz4vDIDc1xEjZ0ehU3Yn9LSb5Fpz9kujQ554LHh+2VfyFdydKRO0rhR7?=
 =?us-ascii?Q?GSqN/VLaUipsK4IRfVgeso59bVNJ5QF3VZr/os2h08AdvlZAsV7iy5W/NJa8?=
 =?us-ascii?Q?JVn6l3MilX91kehecTakbJ6aJxAMd44ZKQPRLveEFp33EWs2mwnRNW5s8d5x?=
 =?us-ascii?Q?3zegdqmietHYllYzDhd91uiv9H6f/iHV2ALnmoSW6Qrl19ezlWsIgKuwc366?=
 =?us-ascii?Q?LpZEDMk6es9KB7C5gyjZbcWoJdzqYeUgXtGPXmCvz6qonjIm/j+aWy9R6uf4?=
 =?us-ascii?Q?vOUcd1lU0k5Y6d09ElFGMF/m9GIe/RE6LZWBnbH/JqGalT0DJKSi5UvPL3Ty?=
 =?us-ascii?Q?OGoRDNXf0UAadaSWvpQdDW888YVWd3BtVVptLj9wAFyiigLhtPsh6G7wLl/w?=
 =?us-ascii?Q?5xEKunB9BVzhIDNWbbh9DGpLdmNDhZl8NyRa9DkEd4P4YJHDzO50Utw1aK9j?=
 =?us-ascii?Q?liymEmM2G5hQWI2ift/H/dK+edYXLM9ireXgknlp1eOoPyPVFjo5PWixmxxe?=
 =?us-ascii?Q?CM11pkZv/CUjXeMugH/wuGz+fAtl3sBKJolg97oVaF+4wyhYFIu4kSWztNow?=
 =?us-ascii?Q?Oqb0es9qGm6m6wkyJ5oh2B3o?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae03dcf7-7f28-475d-9b47-08d8fe861faa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 14:12:08.2366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CbBoMcundHgX56lFUNRC/1D5KiP0DDh/YPIIit5PFQ7SpmvdJq1zXbvgwnulk1YRJ/F5QoHE/ifGJunZhjg3Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2434
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============1040740718=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1040740718==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488C415C75E74F4A2A420F8F74F9MN2PR12MB4488namp_"

--_000_MN2PR12MB4488C415C75E74F4A2A420F8F74F9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Shouldn't we so something similar for sdma 5.0 as well?

Alex

________________________________
From: Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>
Sent: Tuesday, April 13, 2021 2:23 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, Ray <Ray.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Koenig, Christian <Christian.Koenig@amd.com>; Su, Jinzhou (Joe) <J=
inzhou.Su@amd.com>
Subject: [PATCH] drm/amdgpu: Add graphics cache rinse packet for sdma

  Add emit mem sync callback for sdma_v5_2

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index 93f826a7d3f0..b1ad9e52b234 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -369,6 +369,33 @@ static void sdma_v5_2_ring_emit_ib(struct amdgpu_ring =
*ring,
         amdgpu_ring_write(ring, upper_32_bits(csa_mc_addr));
 }

+/**
+ * sdma_v5_2_ring_emit_mem_sync - flush the IB by graphics cache rinse
+ *
+ * @ring: amdgpu ring pointer
+ * @job: job to retrieve vmid from
+ * @ib: IB object to schedule
+ *
+ * flush the IB by graphics cache rinse.
+ */
+static void sdma_v5_2_ring_emit_mem_sync(struct amdgpu_ring *ring)
+{
+    uint32_t gcr_cntl =3D
+                   SDMA_GCR_GL2_INV | SDMA_GCR_GL2_WB | SDMA_GCR_GLM_INV |
+                       SDMA_GCR_GL1_INV | SDMA_GCR_GLV_INV | SDMA_GCR_GLK_=
INV |
+                       SDMA_GCR_GLI_INV(1);
+
+       /* flush entire cache L0/L1/L2, this can be optimized by performanc=
e requirement */
+       amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_GCR_REQ));
+       amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD1_BASE_VA_31_7(0));
+       amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD2_GCR_CONTROL_15_0(=
gcr_cntl) |
+                       SDMA_PKT_GCR_REQ_PAYLOAD2_BASE_VA_47_32(0));
+       amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD3_LIMIT_VA_31_7(0) =
|
+                       SDMA_PKT_GCR_REQ_PAYLOAD3_GCR_CONTROL_18_16(gcr_cnt=
l >> 16));
+       amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD4_LIMIT_VA_47_32(0)=
 |
+                       SDMA_PKT_GCR_REQ_PAYLOAD4_VMID(0));
+}
+
 /**
  * sdma_v5_2_ring_emit_hdp_flush - emit an hdp flush on the DMA ring
  *
@@ -1663,6 +1690,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_=
funcs =3D {
                 10 + 10 + 10, /* sdma_v5_2_ring_emit_fence x3 for user fen=
ce, vm fence */
         .emit_ib_size =3D 7 + 6, /* sdma_v5_2_ring_emit_ib */
         .emit_ib =3D sdma_v5_2_ring_emit_ib,
+       .emit_mem_sync =3D sdma_v5_2_ring_emit_mem_sync,
         .emit_fence =3D sdma_v5_2_ring_emit_fence,
         .emit_pipeline_sync =3D sdma_v5_2_ring_emit_pipeline_sync,
         .emit_vm_flush =3D sdma_v5_2_ring_emit_vm_flush,
--
2.27.0


--_000_MN2PR12MB4488C415C75E74F4A2A420F8F74F9MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Shouldn't we so something similar for sdma 5.0 as well?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Su, Jinzhou (Joe) &lt=
;Jinzhou.Su@amd.com&gt;<br>
<b>Sent:</b> Tuesday, April 13, 2021 2:23 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; Deucher, Alexander &lt;Ale=
xander.Deucher@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&=
gt;; Su, Jinzhou (Joe) &lt;Jinzhou.Su@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Add graphics cache rinse packet for sdm=
a</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">&nbsp; Add emit mem sync callback for sdma_v5_2<br=
>
<br>
Signed-off-by: Jinzhou Su &lt;Jinzhou.Su@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 28 +++++++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 28 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c<br>
index 93f826a7d3f0..b1ad9e52b234 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
@@ -369,6 +369,33 @@ static void sdma_v5_2_ring_emit_ib(struct amdgpu_ring =
*ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, up=
per_32_bits(csa_mc_addr));<br>
&nbsp;}<br>
&nbsp;<br>
+/**<br>
+ * sdma_v5_2_ring_emit_mem_sync - flush the IB by graphics cache rinse<br>
+ *<br>
+ * @ring: amdgpu ring pointer<br>
+ * @job: job to retrieve vmid from<br>
+ * @ib: IB object to schedule<br>
+ *<br>
+ * flush the IB by graphics cache rinse.<br>
+ */<br>
+static void sdma_v5_2_ring_emit_mem_sync(struct amdgpu_ring *ring)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; uint32_t gcr_cntl =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDMA_GCR_GL2_INV | SDMA_GCR_GL2_WB | SDM=
A_GCR_GLM_INV |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDMA_GCR_GL1_INV=
 | SDMA_GCR_GLV_INV | SDMA_GCR_GLK_INV |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDMA_GCR_GLI_INV=
(1);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* flush entire cache L0/L1/L2, this =
can be optimized by performance requirement */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, SDMA_PKT_HEAD=
ER_OP(SDMA_OP_GCR_REQ));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, SDMA_PKT_GCR_=
REQ_PAYLOAD1_BASE_VA_31_7(0));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, SDMA_PKT_GCR_=
REQ_PAYLOAD2_GCR_CONTROL_15_0(gcr_cntl) |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDMA_PKT_GCR_REQ=
_PAYLOAD2_BASE_VA_47_32(0));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, SDMA_PKT_GCR_=
REQ_PAYLOAD3_LIMIT_VA_31_7(0) |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDMA_PKT_GCR_REQ=
_PAYLOAD3_GCR_CONTROL_18_16(gcr_cntl &gt;&gt; 16));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, SDMA_PKT_GCR_=
REQ_PAYLOAD4_LIMIT_VA_47_32(0) |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDMA_PKT_GCR_REQ=
_PAYLOAD4_VMID(0));<br>
+}<br>
+<br>
&nbsp;/**<br>
&nbsp; * sdma_v5_2_ring_emit_hdp_flush - emit an hdp flush on the DMA ring<=
br>
&nbsp; *<br>
@@ -1663,6 +1690,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_=
funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 10 + 10 + 10, /* sdma_v5_2_ring_emit_fence x3 for use=
r fence, vm fence */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_ib_size =3D 7 + 6, /=
* sdma_v5_2_ring_emit_ib */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_ib =3D sdma_v5_2_rin=
g_emit_ib,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_mem_sync =3D sdma_v5_2_ring_emi=
t_mem_sync,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_fence =3D sdma_v5_2_=
ring_emit_fence,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_pipeline_sync =3D sd=
ma_v5_2_ring_emit_pipeline_sync,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_vm_flush =3D sdma_v5=
_2_ring_emit_vm_flush,<br>
-- <br>
2.27.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488C415C75E74F4A2A420F8F74F9MN2PR12MB4488namp_--

--===============1040740718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1040740718==--
