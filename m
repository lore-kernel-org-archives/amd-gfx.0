Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6D0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 07:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4107110F057;
	Tue, 29 Mar 2022 07:36:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE7E10F057
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 07:36:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1bRodw9vlB8qe3moSLJHc8zlrsNvB8EuQ7B1JkriPV25JU9CarvG6zKB4bjZzXJTBD0fK7POLbCMa2a3h9Xz82LkEHut6GD63OE25XcQSN2Od3RUGGsl9FarqW0CRfZ03RsMXM28RMBwBN4xJreHaxboq+kr/P7Q47zN7P1mHWfJaqPSVL1L41ZEeCc5k+Yi6IChGpYmtpi59P8Xqn9eV4/wpezgvqHJFmYRVUVc2GuN+bT2lRNnNbcf1rasu4154K1GkXHfD0uDATfzVkmk8fuOw35uWOSaAjtbsfKyoYK7ligBdkpDj/6eXFwuggz/J3wSXVs/2ZvsA5W5shWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOO5wxvgGDNI2j/kuza2Q2zOAAFBS2DoFAP0PP4RzyY=;
 b=LZyTf3lzH1wCymhcfiGpgCSy7mj/szZE1BH5DVqVaCOKRV5I7eYwsos486d0UnfPgLLHVrPxeumqYJ1avsxgPbu5+sgoK2SwbnAV5aOIU1+xgPPvSA17UBv0tiE+AoG48Df/JfQZuIaGsqigheWuOMqFQX9BYuBUDlZvYj5ufzlGuvEo20z+071fFgCPXg8q+qqoZ7qSo7w21Kom+YKncgI9xoSUb582ERnA8wRBkVXbQRFAT2Fi6OIkvOYmhTJJp9ro6B2LhJro61WUQRuTvm+koVNyTCifdtFTsXbYOVnqlFkANL4NFIRxwIBNF5HbryFkGAwIim3uawBr8jZZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOO5wxvgGDNI2j/kuza2Q2zOAAFBS2DoFAP0PP4RzyY=;
 b=5pjKXjj24xlof//8WvzsC4eSLjyWZGKwYhYYCe9hEx1uehMafo0gWGq7Lm6msQ6xV9K1q55c5CyRXtN208UaKq5Tmcey2xkg1IMloK4wcwYditpXrWqGjZTt4u7NJXKUdOG289zs02CnrgI5mbP96FeMua4OtOsi4r3//PibWW8=
Received: from CY4PR12MB1189.namprd12.prod.outlook.com (2603:10b6:903:38::17)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 29 Mar
 2022 07:36:54 +0000
Received: from CY4PR12MB1189.namprd12.prod.outlook.com
 ([fe80::75e6:5cec:f0e7:2850]) by CY4PR12MB1189.namprd12.prod.outlook.com
 ([fe80::75e6:5cec:f0e7:2850%8]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 07:36:54 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ji, Ruili" <Ruili.Ji@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address
Thread-Topic: [PATCH V2] drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address
Thread-Index: AQHYQmDHemyRCaft70K1LlLLBQ68JazV+ocw
Date: Tue, 29 Mar 2022 07:36:54 +0000
Message-ID: <CY4PR12MB11895F423B27EFCBCED0D7E6C11E9@CY4PR12MB1189.namprd12.prod.outlook.com>
References: <20220328045845.1986195-1-ruili.ji@amd.com>
In-Reply-To: <20220328045845.1986195-1-ruili.ji@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-29T07:36:49Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b47da9d0-2756-4731-b6e1-68ad3b1e7c91;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-29T07:36:49Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: e7c664cb-bf42-4c21-9db5-b9bdb5374f9b
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cba7cebc-127a-4b18-07b2-08da1156e5ae
x-ms-traffictypediagnostic: MN2PR12MB4205:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4205EB94B8B92F6F352BD95CC11E9@MN2PR12MB4205.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JfwaR18X6y9rPgrbGcUjHdzsOouvFY4OdCybetqmty5TE0uCTu8nY4y0ex8gPzr+mNxKM/nzxzFE8HLWeT1cywuwrmXN8zWYT9syin+1H30zA/Gi9wR61n3XliolWGTeGm98qATIOgF46OX0qREPgkdNQJn66NvxSgrHMS6E6RKdEFQgkF4KXOmQ1cjMmZtHngxB5GqCijY48IK2kLBPGaf5xAZgZV0wxrlMS75xAuGdgQGubxz887ecUVtR84xO0s9CMeaN3qeXsIfVmE/V7Yc/Bf+VoSP5j/QmdfTQ8Xoy1F+edCHIEBrDR44t1XcnHcR03VA2uHyaTsZk43Z8Ru2oDYhkQIKyre4Q17oIrEDOMniSh+xx/LfoUeamUw8RVtSfOTy5nU8irQ00sdjKI2qY1I3mQxiUYg3xNDCEyVxiTWv5KX8Udx6pIuBAvmkE5Ybtv9zT8emctmZHJ/TEvxXY0BEmUhUyJE5VrSzgRO212R1ecCTbNhkPq3eS7YwFd0q9FsE/Zw75wbCGdNJT2T071UYDG9PhLnun7OqzThLBgq193bN68pAdauGcfLqGLfik3A8s1GH9PgEjnjZ9LMXA8BfmtESgeucUbFOLUF/Efgd/YgbTFo7GHl3yEb07BisZatTnep3yBTAVfAUPfptbjLzIRiFbDVP4Lj4BlNwM00MZIur2pQkvdCnN3fmvsCJGmZ7q0RmPTTkHSo/Jvw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(5660300002)(38100700002)(52536014)(54906003)(122000001)(8936002)(38070700005)(86362001)(110136005)(186003)(26005)(316002)(55016003)(6506007)(9686003)(71200400001)(7696005)(53546011)(64756008)(8676002)(4326008)(66946007)(66556008)(66446008)(76116006)(508600001)(66476007)(33656002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TVOrGLtnz9T34edt8VJ0iLD30dyQYnKBdqTlrfepENpCt3Zlbi4kh3r7vYYw?=
 =?us-ascii?Q?zhzGOD8C3rdnz399+l2iS8dcdb6AuvExDZkR6p0gS2pVAneeD4y1x5BZsTTk?=
 =?us-ascii?Q?83TVi34ChvMYCDL0WUWnKAq3cSzGFIoJmGHFtpdCdfbl1dpG2KwS9wd4+xWn?=
 =?us-ascii?Q?KAh+SAdSmyI7PmUNuh26ZW8P/w8aiDWI2934uiCAoniPb+XxSpjT9cbcPplg?=
 =?us-ascii?Q?ksRCzbdvqKureMaGQCaZbecobdsLfoAEFQ9HvyJS/W3Xvi20k8TmcRZrdQd/?=
 =?us-ascii?Q?slfwivq2j+K1tqwycXi+l7B34dK3RtD+gaDXBeXsDBNx0FxgznsPKWCTEgXh?=
 =?us-ascii?Q?y3bTIutVUk0mlxiH3YT1X43LHAt2OgXDjijnd25xsbuv9feg4DGw/vorgHbe?=
 =?us-ascii?Q?m1J77FuHHvl0R9DmfZwKFYJX+jg+6p65zJjvnnKpEat1bfpLwgPBUaZHH7Ma?=
 =?us-ascii?Q?nHAbWVdS9vVd8kiGfMmnA/LpZOl0yerj5pg4gYuBBdCcucAmdZrpHWl3Bmo/?=
 =?us-ascii?Q?aUgPpfym/5hPpk3GTOlSaZSeqknpSWdZj2NyMl8GIY/00qW4h9dA8XumF8C5?=
 =?us-ascii?Q?9wHkGM8pWs5XSLTGAvMXXxYhcHWOlpdKFWTZmY6rMVBgZ0OtAxSzISC56kjC?=
 =?us-ascii?Q?lXJoChIFC0k/WsGClrnrhyxymnG9dA7YSs9nx50psMNUscosBsG2RzXUrHgw?=
 =?us-ascii?Q?Od2PYE1e45Cou/o/gojKFIeKbGwO8AY3WezwZ8aLp60opdQZycdhD0hvLlQv?=
 =?us-ascii?Q?VoVGHxN0huX0Nnk+aXQLOV8j+in9s9uUgOad7mR2wIGTZzqTWxgxJAaHs6fS?=
 =?us-ascii?Q?a4aS6kgqyJMIR+ykCpxWBOvmyeGHxsfUF51DTdWv8F29Ly6kPfjFzQUlryO+?=
 =?us-ascii?Q?QJ2I6nD4ZripGn5xtKUOIc/ymlGfMIdjXz500xSPOUFKMw3nK4Ky7pjAHrQy?=
 =?us-ascii?Q?ilIflKmf7c4gOAzDvQ83UL6LiuRbeTW4N4Ty7uuFJrfgNO0CX/WVgsxWIb9p?=
 =?us-ascii?Q?g2Ds2K4FfvbcLFqk3X9UYHqluXxP8/9nn3k7HilFq/9wIVs6w82KR+13Y/aG?=
 =?us-ascii?Q?oxX/Op+gC81MY6H+s67xvdEomMoesdv59eYmFP2r+Zm9N4YFwwayrevoXQJV?=
 =?us-ascii?Q?OouG5PCiTgr23dK7ERVUdyQiLg1SloHT13hAeWnJE81S1BFXpi2LMPh2X4wV?=
 =?us-ascii?Q?I3GhWthQKIN7YsEi60JALrk55p5japC9pBVm6BrVj6JhA4OUK1hxrw6h+mZQ?=
 =?us-ascii?Q?71p9QUh/Yp5pp5YPzZ+r2NVN6MEIz6q8Rzx55fRaokussgxyjDaQkpwbZIq5?=
 =?us-ascii?Q?LdJbHokURucEVQZ/LawyE1ln6QgtmWAFGKFHvXKavaTLAeTcClTf026i69N0?=
 =?us-ascii?Q?ODdbIZe5C9ufAMUQKlqLzVsVV8G5pWgvOoGj7UFCXp7W6feDrzTLDfAUq470?=
 =?us-ascii?Q?ws1C6p1yenxf6ow3SZVa4aovr0CG8gORSzj4WFDgkFKSF0IUDQ1xi1dvvkd1?=
 =?us-ascii?Q?JpEGeyF7ONxiQoMxD5cYEHzUFNfSJDVjWoZ7+yuGv44Ky5V8JMtNXK5r8xqC?=
 =?us-ascii?Q?QDV3OKJcgwLawJXZAigNxrHQGgX34wkdtdL/QELD7vNthbCGYro2Si27EH3u?=
 =?us-ascii?Q?vUfx1+tBrJ70vlp+e5GPjqPWc6vQRLp/0Y60SaTpk4klphFezf7cXTk7ig8/?=
 =?us-ascii?Q?JUJcJN8W76rdCWrx7Vu/9ofhsJcxQUrXuINlGaD8YnvkB/RU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba7cebc-127a-4b18-07b2-08da1156e5ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 07:36:54.3500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: citmNe9EQNv9j3w7dFRcE8yVhAPzH8WMdh4cbkXzJ/8g5DazkybLKSDeBFkbQ+8Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ji,
 Ruili" <Ruili.Ji@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ji, Ruil=
i
Sent: Monday, March 28, 2022 12:59 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Li=
ang, Prike <Prike.Liang@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Deucher, =
Alexander <Alexander.Deucher@amd.com>; Ji, Ruili <Ruili.Ji@amd.com>
Subject: [PATCH V2] drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address

From: Ruili Ji <ruiliji2@amd.com>

gfx10.3.3/gfx10.3.6/gfx10.3.7 shall use 0x1580 address for GCR_GENERAL_CNTL

Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 99df18ae7316..e4c9d92ac381 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3300,7 +3300,7 @@ static const struct soc15_reg_golden golden_settings_=
gc_10_3_3[] =3D
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1807ff, 0x00000242),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500)=
,
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff,=20
+0x00000500),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff, 0x000000e4),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0, 0x77777777, 0x32103210)=
,
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1, 0x77777777, 0x32103210)=
, @@ -3436,7 +3436,7 @@ static const struct soc15_reg_golden golden_setting=
s_gc_10_3_6[] =3D
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1807ff, 0x00000042),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500)=
,
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff,=20
+0x00000500),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff, 0x00000044),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0, 0x77777777, 0x32103210)=
,
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1, 0x77777777, 0x32103210)=
, @@ -3461,7 +3461,7 @@ static const struct soc15_reg_golden golden_setting=
s_gc_10_3_7[] =3D {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1807ff, 0x00000041),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500)=
,
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff,=20
+0x00000500),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff, 0x000000e4),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0, 0x77777777, 0x32103210)=
,
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1, 0x77777777, 0x32103210)=
,
--
2.25.1
