Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1950DD70E03
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2024 02:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6E5A10E287;
	Fri, 29 Nov 2024 02:09:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5nzB/xLC";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67EAC10E287
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2024 02:09:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOfltAKICs5HEctuXhJIxuNFioWIF0IQVWWifIUzX//zLbS3ewuF1vyVJpoPtBhF3vzFHsPIL8ntxzEfj0u9peV9Hd5ZjAUENVQ9PLOEQvwpadv8nudBsUAhdd/BQd2AlOf5aE5UpubFU4mN0gVneVF5NjJCjqXs+Z5IUqhJwL1Yn6NE2kqZbLtzrtZewcysCrM63yEiqBGD8EbZcZe812zXYi/IFpNghOIIMShhS+4nOe+giFmBBaqsA1ASDiyWlb5Dd9rxf6fwGInRtORG7CmqAXwcq/mbNWJkPFlzKOruNY0e/VDFJsp9VT+rY9P1nsQlfNdDAVxZ7vzqRFwYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWeLVbhUhSSNDTC5zu1pgX/eZwQ9wlfAkytyzzde6eg=;
 b=wWCZ6FaBFyS3k10K/hzA7ZB3eM/V0/4PQdSTGuuYjP2Uwu9/A/oXkv+8fSYnFv1PqCrlEfOZyjhZIcl2cfVcoheeNbAdRVMpGHHl3Jf7h8PkjoyhhlievdogL4YhqaeOfLn9BuyNU701W0jVX6e/Db6nC6YyQiIPnlmXmP1QcefnsvpXqSZJKJZ4+hgkNi15XD6bk4va60fgkwfrGmsfwNdROpBlqBFivF7U8d2k/fdYfvKbOb6RmrXOkGejY8b29qhiLZyQVGosT/tpbvYOYOLU2dViznYujdjJL72+60RDNZ43CW8vJDYvDZIr2a24I+tO7BY0QT3X41X8ehdAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWeLVbhUhSSNDTC5zu1pgX/eZwQ9wlfAkytyzzde6eg=;
 b=5nzB/xLC8jUQ6wzJEc1yHLdiSRCtPBB653mfSMUhHRwcyO4Fa84cu2NWOMf0nfKgVo5GeD+M7laoK+oWFR3r4wD+MUjsvptPDCwmJAea/nUfUQqq1SkMPjtlNmb0UkZL4viG0PZ7fCarS5onk6WXau1T0VV3uxH7SXmjBzufigk=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 02:08:58 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 02:08:58 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Su, Joe" <Jinzhou.Su@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "Strauss, Andrew" <Andrew.Strauss@amd.com>, "Su, Joe"
 <Jinzhou.Su@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add secure display v2 command
Thread-Topic: [PATCH] drm/amdgpu: Add secure display v2 command
Thread-Index: AQHbQUY8iDDj+ZM870SGlxWT6ycl8bLNgvjA
Date: Fri, 29 Nov 2024 02:08:58 +0000
Message-ID: <MW6PR12MB8898D6193BF2E9AEF0DC4FEAFB2A2@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20241128033106.45592-1-jinzhou.su@amd.com>
In-Reply-To: <20241128033106.45592-1-jinzhou.su@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=149b7470-9c57-486f-b1f6-9b0149f381b2;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-29T02:08:51Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|MW4PR12MB7016:EE_
x-ms-office365-filtering-correlation-id: 140c3d0b-3e77-41e5-703f-08dd101ac8e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?yxE4bmjqp1lDcsx43Sk4ZzwpzfqkzYpqGl74BdTa2fLUVhxjtVe8WAqSnLQy?=
 =?us-ascii?Q?ymjbbMQL7t//dtIKYQuQCX6PqmPszneTNkc1x8bT+E8JZGsiOpWo1Cw5R9XO?=
 =?us-ascii?Q?ji19JASiIbqlgIwTxA+Tp0Osecuvv9ouLE9KoowgmT5FT5IZBzURYOVqRbfl?=
 =?us-ascii?Q?5JRPtfVEkdSS5LDmbKjn/fANuTmILj3ECJDTIkXh750UsHlJYj+lar3sKGPd?=
 =?us-ascii?Q?oqClOwlwUC0HIlO2XI03Cx2DAhhQngyf2HJhgV9O2ugphQSCvTt2jqCBZWr9?=
 =?us-ascii?Q?cAu4UuC3OaMkxsp5GRig65VGu3Ca+NcVg0E9l0Y8fmlqlEDnDt3f62YDgloc?=
 =?us-ascii?Q?DEAodwo/AOyuC+wo4kG9ZvLFh+I5kMX2fqdRmhYwfOb4/v9n+N7INL3FCOeb?=
 =?us-ascii?Q?j8jTk2C2Or6dcXcQurj2rMoc0u1jIW4/sUthFZkVwy/tuYR4eiNObmnCE/wu?=
 =?us-ascii?Q?LLV28bF2Vn8wKR/49KaAZ0rIGR04ii4odGRXTEsLVX5y5+dgwefxsSgA4Xuo?=
 =?us-ascii?Q?oEwYF4TbFJaTUoU4gFfzG05bq4lgY3yiNLoCRy5t9urgecsd7WnostAVqXrY?=
 =?us-ascii?Q?+hc1wk85jO+c2FOJarBfeA+O6//B66dYhJCFefLFnmMQHIrnDqLpTD3LZ1dx?=
 =?us-ascii?Q?3jbnL+/1XLcoJkt79Tf2xWu7jylwQJHTYtDVyaRF3goHujs2Kpt86plDUdX6?=
 =?us-ascii?Q?E/kUiHeNrElxUMDYWhlTfGJNrxK+dKZvk983luXNc9IXPFGJ6Nst5b9HSMy0?=
 =?us-ascii?Q?YNEQzaDRCfzlEcBGK5Q1qcsp41cRi5LeL4+HfUQohXYxktCq3FQRvFBCFq+4?=
 =?us-ascii?Q?t67C6Gfo5oshZo949n5WnAZ2j6JcrxyuwxwdcTITVZcl71J+2EKM20so9GG2?=
 =?us-ascii?Q?Wtw8EIlcWXH/No+P8OjF0CT+w8YG7zo/ipGQHbXrjYbH+pyFpuuA0KDnN6iL?=
 =?us-ascii?Q?E1uIXTuKr/M24BlA2rqbj7uH2mJ2Wb3tERJFktwaOGtE8YiEeSCxEA/I0KCM?=
 =?us-ascii?Q?rMVBtPCeS/cuyVTrkyZSInu41FrMfZxGPb6rGm123oDNJG5jKHAYCFYRE1ru?=
 =?us-ascii?Q?Hy0CFUjnYD4hcTy7p0vtJjcB9ENKYoo3rV/ytMNO3+UwOI1idirRPpHBZJ8n?=
 =?us-ascii?Q?G1WHS/jHU1F8TQf7lrENavbyaPNM2qeeBJynu1AyqIwTS3edkBD6oR4wOCO7?=
 =?us-ascii?Q?xgeABKyEYsW651cm1ljN0qi0Ec3hquq103tAF9sgyDY5Tbxkn4LEjheigons?=
 =?us-ascii?Q?SvmEUbaGu7Cw9YI+/rryPpDT/IfAEohYWg8tcaK2q4OyTsaLyT8Mz/qjWJzQ?=
 =?us-ascii?Q?tNxgOmOK/2iEyQZK1dG3yTLI5I85Ut71X/sFZoACN8pHvt0Lda2o7/FU3mWE?=
 =?us-ascii?Q?az6VXOmpyX/OX2uXVulkCCMDgdq3pH09DC44zorv+zvb4E6mAA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sjrZyuLqZpSNFKCfFWR3MnuuyKAui5viAVjabBfdQCnWkn1m7RT+UIb/LuPo?=
 =?us-ascii?Q?+QVzz/1/8UXszvev3WrbfS3oy52UsFo5XOLDPN/WfrwGPhDZczneHUanX6Kj?=
 =?us-ascii?Q?v5t1RiNJQiJeVJvN4JuESJuJQeUMSWOCa5IfuR4obzVW99Aj6NnmtXFzNAO8?=
 =?us-ascii?Q?JpF4Ozbkmkileqjl443iakVYfCIt4L/OtDgIM591RvAnYjbi5cgScVX6ge5w?=
 =?us-ascii?Q?gMnt5rYrzb9TVaLfwI+KZ5qLeFtRJ3St6hqSgui62YLX5XHmXcXGarrsEVkx?=
 =?us-ascii?Q?9Kg691OUjUjzEZ39EKNmZGDfFVyKjSp5y1w0QfP4aPD+pq8X4FFILchrCtxB?=
 =?us-ascii?Q?THFvOIh4RwndtIzAesNjLuuJk2IfUCktoygVzaVbWMMLZOp92+U2+OCPXMhA?=
 =?us-ascii?Q?JwyBJDfBrIqSRnlFOQkFU3ncKK9a5RUWFboIXdpeLeiBLH5kdV+1ak64wFZF?=
 =?us-ascii?Q?i/tVCOKgziIleL41YyuzxOP3MUPW6eENHOHq2dNPrH/EVCyM40oMu+L9RRfl?=
 =?us-ascii?Q?it6AftO4MqFXvMXdp+F3sNAYuteiSrZlPTohAjp9gqrrCAn7NOsVl3Rm261e?=
 =?us-ascii?Q?HGwVkYTR5yTIU7T4dMczrrfGsv3cki/xKVClPvukdKhgqIJSy3LVLeGzZzNu?=
 =?us-ascii?Q?NNRoLKWUwWQl98MF2QHEaHNFPfJ1Rh260yHD9dYKJlKwp1+HJxvEo9jJFFD7?=
 =?us-ascii?Q?S8iTXgb/12mJw0zfe8O+kDfBojpheYJG7nwUBX55XgKb7M9A1rawJR01VcFH?=
 =?us-ascii?Q?iKtWXoY59g1B6/rHsvL6FXIC8IY1722FQiFgppG5lSrsPtAKtFkfaKHdfA8D?=
 =?us-ascii?Q?SvcvwouDe0m0YGnlwdUJZ2Hw0HYVhkpEXVM+9VBvah4sktD6fe4MbSSfGIdv?=
 =?us-ascii?Q?M//7C8gG2SnaXAIcLjb73eJ+9HMgXHVxObtlPyaNK9M8PjZorM1iU6C5S2Qt?=
 =?us-ascii?Q?KTQQUHUPqyHRXR/8cemGE4uUYR4KQV6U57bh/cJ9Hf+HjqCU8ViOBWu2NNRQ?=
 =?us-ascii?Q?v06DJUZfd8Ak4pgE0Lmg1DjP0cKqjdMEjx4K4zHIKSDn74bTmBvnfzCoUtEh?=
 =?us-ascii?Q?u8zX/MM7iiRdfksgVtFtyCBzmKr1HmZbmaSbnk5i5q8YqBs+YO4RH3Zygq9l?=
 =?us-ascii?Q?yF9gUeztujcdlwETINdCIdcRXxMYOUYpNw815DGBRktokR+bPLjqIPL9TYI8?=
 =?us-ascii?Q?MyTNopdJggie3xeXXhsiYl4Otm8ifIcffawj1uvg8/oMwGk9+BegdNUTfJAM?=
 =?us-ascii?Q?G4Ytvfv50fK89HcV7l5nsJNT6FKOvl3LwuJ1VVGrGtzw1c6/kOdabw7uDkFt?=
 =?us-ascii?Q?o/GTqWJD1Cozo2U8K7/9pUY9Ihc4JpS1YHkHsmJQsft1AQm1xVa+i/d+3KtG?=
 =?us-ascii?Q?THWPEaOw/iocLLJtrevEa6ieGZt6hVUIBu+hGECwF1pIkrAoIRGv3fuv8GWy?=
 =?us-ascii?Q?0n1i73I+XmQPJztWvN+sykil/sPtWyMFryyrP0avegjfGS2wDBiGzPvr+GlU?=
 =?us-ascii?Q?1pf6Dkk2HHHm043nPxIu6aGDGXnOTXi6g5a9tMFBjYxVi2r7K2sjm/dnLtr3?=
 =?us-ascii?Q?z1QhtMBS96/Fw0mFX2M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140c3d0b-3e77-41e5-703f-08dd101ac8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 02:08:58.1885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LhgBN0NkaG5Dp2IlLCgvtWBY1lhADm4J8UK6LKtjDQFTA8NUjb7jyA+IqYh9Cxj3ION1CJnkG+L7caXC32yGWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7016
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

[Public]

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jinzhou=
 Su
>Sent: Thursday, November 28, 2024 11:31 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Lin, Wayne
><Wayne.Lin@amd.com>; Strauss, Andrew <Andrew.Strauss@amd.com>; Su, Joe
><Jinzhou.Su@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>
>Subject: [PATCH] drm/amdgpu: Add secure display v2 command
>
>Add secure display v2 command to support multiple ROI instances per displa=
y.
>
>Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
>Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  3 ++-
> .../gpu/drm/amd/amdgpu/ta_secureDisplay_if.h  | 22 ++++++++++++++++++-
> 2 files changed, 23 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>index f015961f257a..12832fd834fb 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>@@ -2264,7 +2264,8 @@ int psp_securedisplay_invoke(struct psp_context *psp=
,
>uint32_t ta_cmd_id)
>               return -EINVAL;
>
>       if (ta_cmd_id !=3D TA_SECUREDISPLAY_COMMAND__QUERY_TA &&
>-          ta_cmd_id !=3D TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC)
>+          ta_cmd_id !=3D TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC &&
>+          ta_cmd_id !=3D TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC_V2)
>               return -EINVAL;
>
>       ret =3D psp_ta_invoke(psp, ta_cmd_id, &psp->securedisplay_context.c=
ontext);
>diff --git a/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
>b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
>index 00d8bdb8254f..c5eddd685390 100644
>--- a/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
>+++ b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
>@@ -31,10 +31,12 @@
>  *    Secure Display Command ID
>  */
> enum ta_securedisplay_command {
>-      /* Query whether TA is responding used only for validation purpose =
*/
>+      /* Query whether TA is responding. It is used only for validation
>+purpose */
>       TA_SECUREDISPLAY_COMMAND__QUERY_TA              =3D 1,
>       /* Send region of Interest and CRC value to I2C */
>       TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC          =3D 2,
>+      /* V2 to send multiple regions of Interest and CRC value to I2C */
>+      TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC_V2       =3D 3,
>       /* Maximum Command ID */
>       TA_SECUREDISPLAY_COMMAND__MAX_ID                =3D 0x7FFFFFFF,
> };
>@@ -83,6 +85,8 @@ enum ta_securedisplay_ta_query_cmd_ret {  enum
>ta_securedisplay_buffer_size {
>       /* 15 bytes =3D 8 byte (ROI) + 6 byte(CRC) + 1 byte(phy_id) */
>       TA_SECUREDISPLAY_I2C_BUFFER_SIZE                =3D 15,
>+      /* 15 bytes =3D 8 byte (ROI) + 6 byte(CRC) + 1 byte(phy_id) + 1 byt=
e(roi_idx) */

A typo? 15 bytes -> 16 bytes

>+      TA_SECUREDISPLAY_V2_I2C_BUFFER_SIZE             =3D 16,
> };
>
> /** Input/output structures for Secure Display commands */ @@ -98,12 +102=
,21 @@
>struct ta_securedisplay_send_roi_crc_input {
>       uint32_t  phy_id;  /* Physical ID */
> };
>
>+struct ta_securedisplay_send_roi_crc_v2_input
>+{
>+   uint32_t phy_id;  /* Physical ID */
>+   uint8_t  roi_idx; /* Region of interest index */ };
>+

Coding style issue.

Use
struct ta_securedisplay_send_roi_crc_v2_input {

};

instead of
struct ta_securedisplay_send_roi_crc_v2_input
{

};

> /** @union ta_securedisplay_cmd_input
>  *    Input buffer
>  */
> union ta_securedisplay_cmd_input {
>       /* send ROI and CRC input buffer format */
>       struct ta_securedisplay_send_roi_crc_input        send_roi_crc;
>+      /* send ROI and CRC input buffer format, v2 adds a ROI index */
>+      struct ta_securedisplay_send_roi_crc_v2_input     send_roi_crc_v2;
>+      /* Reserved space for future expansion */
>       uint32_t                                          reserved[4];
> };
>
>@@ -128,6 +141,11 @@ struct ta_securedisplay_send_roi_crc_output {
>       uint8_t  reserved;
> };
>
>+struct ta_securedisplay_send_roi_crc_v2_output
>+{
>+   uint8_t  i2c_buf[TA_SECUREDISPLAY_V2_I2C_BUFFER_SIZE];  /* I2C
>+buffer */ };

Coding style issue.

Use
struct ta_securedisplay_send_roi_crc_v2_output {

};

instead of
struct ta_securedisplay_send_roi_crc_v2_output
{

};

Regards,
Lang

>+
> /** @union ta_securedisplay_cmd_output
>  *    Output buffer
>  */
>@@ -136,6 +154,8 @@ union ta_securedisplay_cmd_output {
>       struct ta_securedisplay_query_ta_output            query_ta;
>       /* Send ROI CRC output buffer format used only for validation purpo=
se */
>       struct ta_securedisplay_send_roi_crc_output        send_roi_crc;
>+      /* Send ROI CRC output buffer format used only for validation purpo=
se */
>+      struct ta_securedisplay_send_roi_crc_v2_output     send_roi_crc_v2;
>       uint32_t                                           reserved[4];
> };
>
>--
>2.43.0

