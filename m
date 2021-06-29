Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E887C11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 06:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0384061D92
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 06:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0384061D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C4F26E558;
	Tue, 29 Jun 2021 06:05:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D5C6E558
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 06:05:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IM+XgSJp9cPM1MR2zDcyKSTfowrgK2tm1Cbyvkx3Sx61l2tJBZNYYv1zx+bgoA9OIEnqFVy+Aa8AhfkCo4PDfh8YfFTA8rJiDmtid56bPmffy/v8R4Mijxa8WkxmwRy19VbtPBC3FU6Ntxj41h/hEtxSDrBKhSVnOVaFHy+YlIstqHFMJFKfm1eGO0J00U71ofgIg9M9T/XHQt09AJWvbcV7O0gzSl6cX8YaYymErARrzU0tWUVAOjngol5kgoSJ+b3cjlm9uIsSNQwWOSe529Uq/jk40zUj4LswY2tgLqxk3uxkI3YJoWzilyz7qUB5vSfxh143BPvR1wZJhZc1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3uXHJRN8dJrzrmGPm2qYJ7Dk64FFiGawF31oOJAqQQ=;
 b=R1lkLmnwpHa4w9XpeJwZcWJOXUanQO1FuxlscxgKOeDKihatqg7RZSKbxYfWRMlm5TIkRurDCeJJxfIZmOw+qHu505RTJ3FZJhZQp7i+VKnYybxw+EW2PcA4kNtAdBsdvT0lj04J5579uxidI/MB2cAPRlZRjgqK+7KYBlGE5uYd0b70oE6yRF/pwbjyXozqHpXTBzkpbC3E60Dj7WK2Zf5LmaIMOAD4fuV9lVprxuDPKxxVrf8yhpb+r1JxLyOetym5Lh7OyfpnOCauiRB8ZjJqEifJNeJRNgg1F0XRuN0tCOBRzhpZrUAFZz4B28PWeeWld8BCkUvGKlnyVqL7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3uXHJRN8dJrzrmGPm2qYJ7Dk64FFiGawF31oOJAqQQ=;
 b=veFbkI+qNn4hykTQzDpg7wSV+lSLrQ0Cl+ZfbUbMe7Rx0fdxPSTfsSyRGF3CpNYROMYVXCuIjg8XQh1bQzSr75N76nM/ui+WnPUUcA25o7t9uEDCQK1EzUrnmUA7HZhR2kztMRL03jB9vRaAMSFgVgJufHnOTCsB1fCv8XyRJ+U=
Received: from CO6PR12MB5412.namprd12.prod.outlook.com (2603:10b6:5:35e::15)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Tue, 29 Jun
 2021 06:05:03 +0000
Received: from CO6PR12MB5412.namprd12.prod.outlook.com
 ([fe80::4858:55fb:a5d0:d3ad]) by CO6PR12MB5412.namprd12.prod.outlook.com
 ([fe80::4858:55fb:a5d0:d3ad%8]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 06:05:03 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable sdma0 tmz for Raven/Renoir(V2)
Thread-Topic: [PATCH] drm/amdgpu: enable sdma0 tmz for Raven/Renoir(V2)
Thread-Index: AQHXa8kBZaNodJqexUKX30SufA6F6qsqgcIw
Date: Tue, 29 Jun 2021 06:05:03 +0000
Message-ID: <CO6PR12MB54126823D6EFC1AA36BE6E63EC029@CO6PR12MB5412.namprd12.prod.outlook.com>
References: <20210628025449.3404-1-aaron.liu@amd.com>
In-Reply-To: <20210628025449.3404-1-aaron.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-29T06:05:00Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f22ab6a1-c065-40db-9b6d-a1b6ea7a8dcf;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c232d16-b4ec-43b4-502b-08d93ac3d62a
x-ms-traffictypediagnostic: CO6PR12MB5427:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB5427D17FCBC0B09EC7F9F120EC029@CO6PR12MB5427.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AQnZ8DiSB+HD2QmtHfOr4Q72mBEN2BwSq70tE3YfqfWcXO1COsCb9l0UUHPoWwwIRnGHKB60duDNWvIF0SlZ47uFlAFkwi7rNImC3tn8dS2s7qic1SiNfATkVxqNfVpFDRbBK9nhE2pQ5xtQ7Rjqmvpp0szLY2cVdIhdqi1Zej3juCUqRuosLHJzoipI5DkRuQAEzaP14mnoGGif+GUscNpk553RGOV6VS4d783WM92z+t3gK7+wCfClKFFVR7QXp+E75awgo7dxUFEdTmadcz6E6+L0JpACcRxx5osVVgXl9SezvO3NmfUYh9fKUywZjfCuXZGpeNBfAhJEwzybnOxRcJB2ed7M9JhpxmIauN2yWWE4hoffF3z4EXDI6fAoFvR6SDJo6U3Wxwu5cUAUfGN5ciL0MdLx1FNIO+y18ZnjZZTGBsY+KL++b6KBBDjfitx9QjQj3thyZ3skucWPz8mi1nyoe8lxYVdHgBJR2epxd+q3TA2H/zhafB/NdqOTWlHojcFEVXvRl/ep69v1zqfIKhxK0c7gp0N3y35mW327tSLoW+GWBMvPbMU8H6w0UzayUunKl248ky8QX+1uGnrevJlsh0BH7rA0R+CYAETbmu3EJz4/8nFlOryRwpe1SjCrMPRmYxgiugnn9jdeLw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(86362001)(52536014)(5660300002)(38100700002)(122000001)(9686003)(26005)(55016002)(4326008)(7696005)(33656002)(6506007)(53546011)(8676002)(186003)(71200400001)(2906002)(8936002)(316002)(76116006)(66946007)(54906003)(66476007)(66556008)(64756008)(66446008)(478600001)(110136005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HwQ25XrVDaSgF+6ArSeu6XwUq6mfmZCxjYL/2Is6cQT7J8VVMNKNAyojIq8w?=
 =?us-ascii?Q?6drNQuBnAZfzpWRxfgObR26gSOsv/T1LFiIgsbIlsZr0zm+JWF45HOo8/gHv?=
 =?us-ascii?Q?lYZREY8awMqe4OpyWUGveHaKkJlZsLW6C1FAE8UichC4Sf3K8G6lCluSe5qL?=
 =?us-ascii?Q?7x+5KiYWY+Nl3n94dFAMq0b1UXiPCbTZfKU0+SJEf2ZS4k6Mcl/9lhRZ8Li1?=
 =?us-ascii?Q?DjnOOWCTkII37e0aGFJ+Huibd/UHKA3bPv+4SEpjK8l79Caqk+SCuZbuVfZ/?=
 =?us-ascii?Q?pwgHx3UB7jWcatMS59fExXZ3P1tFuUnY8a3W4GxpCucGn218YAFejetmUH6H?=
 =?us-ascii?Q?bAXvpIjOaWCsBcm8KlvhmuCm6uGf6fph7WIEX9A++He2RSaCKAgqeOVSu3gS?=
 =?us-ascii?Q?KgTxc9ZgLSAOyqlPdFz37SRTNWGY+AN+Y2gj2nbbi6TJ2nCIu/wAaK17Gwms?=
 =?us-ascii?Q?8eo1YF1hdODnlXlH8jraKjbDtFPln/URXpBYQkJYTSoZuS0EOT19ZALU7Zm5?=
 =?us-ascii?Q?Iq1U/N3WH+1RuPchn8dK5DQ+KY7/BqUlcPJ6Bj/2I+KeWEnsTCu2HcS29eV1?=
 =?us-ascii?Q?m/k4DjDMHa439cWPMVn6hQs0HTpHauycJHS9vUdrkTl8W3ACO/X7Yi1S+MnN?=
 =?us-ascii?Q?fVL5/j+y9NdwKcwH7weO4klUC1hfPHsMV5NfiaR17peIamcEs6P2DSUrzusI?=
 =?us-ascii?Q?Kh+gOv7U6WN9BBRtbTudACw6XWGO2kaGx1wdN8ok09ru+upEWwmio16VdVwp?=
 =?us-ascii?Q?D72CUszc53sQW5fOPhDMxPDUZoVFRTiTh7RNCGuEkc3NaBk7Eds5tfKykdup?=
 =?us-ascii?Q?17LuKH21NsKLwTRyWg8sA5KXWELHRyN2BMXPAJdQskMB89QBUaDKJHzVgt8R?=
 =?us-ascii?Q?qiVGiw46zykG6nxHtJShhpfY9IqcVAuWfOmEw6FVBDPHhMPsPNXqYek8Tnbf?=
 =?us-ascii?Q?U5peqBa0yErIycwsncp5HBzIcsE092VZijejcqgiCrEVU/mD9JOeb/2CEkX9?=
 =?us-ascii?Q?0mdlOKJPXJbGSd3k5PAxgo/ALPaIw/3Zo8DkHdF0vU+PTXxqAEE6jMLQRLsW?=
 =?us-ascii?Q?h0YITeLzbTIBtgrbkrkttDn6F+FRyJaTBtVWECJbh+LkjP73vDiySIZVcFlf?=
 =?us-ascii?Q?dDoh61uNVymev7JWGa6mdnhHek0F+qtmgIRH3QaVV7Um5DgG7DTWDUQkfKsZ?=
 =?us-ascii?Q?YsMQyXUC2fyJZnGmKJ6HhkM/G+95K0jxTQsb0JW5uE+oFCMyH906vNjoeuLG?=
 =?us-ascii?Q?VTzbgw74r9K6PCeyKauA+++pgB3/Sf7iZJUNYeAYpU73nMqcS7Fln/Y2hKy2?=
 =?us-ascii?Q?/+ogYD9+iw9+v3T5C15F3MEi?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c232d16-b4ec-43b4-502b-08d93ac3d62a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 06:05:03.4353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iP48EPY/OyoeQURtwx4VqvYWqZrcnHT127yJSgFhGiXxKjNmpT+ydDkLKGvJEpm4xBAgthMaR0UPRwtb6moCdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: Liu, Aaron <Aaron.Liu@amd.com> 
Sent: Monday, June 28, 2021 10:55 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: enable sdma0 tmz for Raven/Renoir(V2)

Without driver loaded, SDMA0_UTCL1_PAGE.TMZ_ENABLE is set to 1 by default for all asic. On Raven/Renoir, the sdma goldsetting changes SDMA0_UTCL1_PAGE.TMZ_ENABLE to 0.
This patch restores SDMA0_UTCL1_PAGE.TMZ_ENABLE to 1.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index ae5464e2535a..f6881d99609b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -144,7 +144,7 @@ static const struct soc15_reg_golden golden_settings_sdma_4_1[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_IB_CNTL, 0x800f0111, 0x00000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
-	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0),
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 
+0x000003e0),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x00000000)  };
 
@@ -288,7 +288,7 @@ static const struct soc15_reg_golden golden_settings_sdma_4_3[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_POWER_CNTL, 0x003fff07, 0x40000051),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
-	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0),
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 
+0x000003e0),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x03fbe1fe)  };
 
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
