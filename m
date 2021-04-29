Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2DFC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93D86115B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93D86115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 476FE6ECEF;
	Thu, 29 Apr 2021 08:31:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D69606ECEF
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCxDgkTRBDCxjMRPUC0jcBkt8aJUcve5t8BMcoYEexsShb+ISsJ4rWKHVOY1lxnGj0JC/krSyTLmlKq7yxbH7XLOHdb9kY36ktgESScya6LLDgE6ccOfRDwfykaXkCyemWZs8fdgKfrUUF2NDXMJpNRSCVr4rVVvm3j2W/2BJds6codE0Tz3kHeTbU4g+f3VSV5ofT7rM4eAq7pBfPCYk/ZJxgFSBOqj7fTyZv57Sf6ztV/7RRPCKwk5s76ysE5nO0bSF6S+KFZhpNM0NlmqionMseRngvI03EAjrMgql2v48Vd+i6dit9Pyg4hrQN9/vMQy6quC6KjsqBwdN2psgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcXADZPr93nNoBoWG1E1sEQQhp4GPW8qelpQwBnnd+s=;
 b=MoI/uV2Un6QAfKr9miJwqwvvnydS9ed5RE7z3FOv+OuDnJLnERl8ebEVzb+oW9Hc1NCYchg2M2OpePG+wWJSiIRlztx0kj9aztzE+SvUFl7+RWbsqZ7GLotxbItSeScPjPrbFiICj2N3LH/7H0RH/kyzB3QSVAxJqy0gTPIS2B3nJTQ+xzHQhZ0BPdzRr2cr4QgUqPB8Crt3cQOb331ayA8fueVlQGFUPinmDWxWxWmvHLDfW0OjS35zSZAHrAm+/9zbgaI1s44P3s7zxD/8UEm3F64ViZAobDNwbAb36H0SY+2EwSeFSKAzOSYqws7TqUTp/nZWgxNbUu52ZNySiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcXADZPr93nNoBoWG1E1sEQQhp4GPW8qelpQwBnnd+s=;
 b=ycjI6TLlhtL78Rbm+bi/5QWqG6dEedrQvVK+1FK2NUrrUsfb0lmcaLtk1tOlIUa7lfK9h7UALiPIIZ29Qy0ZniVTu+9n5SCGuBPr2q1MtQYZXcHAJ8qpWdzzGw2m8w6xqOysJ7UjPfuAacElqCljPQmV5PQ7o6J/qZ+9nnvQBi8=
Received: from BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Thu, 29 Apr
 2021 08:30:57 +0000
Received: from BL1PR12MB5350.namprd12.prod.outlook.com
 ([fe80::2da6:ea50:5bed:f029]) by BL1PR12MB5350.namprd12.prod.outlook.com
 ([fe80::2da6:ea50:5bed:f029%6]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 08:30:57 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/7] drm/amdgpu: initialize hdp v4_0 ras functions
Thread-Topic: [PATCH 4/7] drm/amdgpu: initialize hdp v4_0 ras functions
Thread-Index: AQHXPMCIcleNTl5GZEmUox/jYTurQ6rLKmkA
Date: Thu, 29 Apr 2021 08:30:57 +0000
Message-ID: <BL1PR12MB5350D70A7CFF512C26639FA8ED5F9@BL1PR12MB5350.namprd12.prod.outlook.com>
References: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
 <1619677546-2630-4-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1619677546-2630-4-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-29T08:30:53Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d307be8b-caf5-44dc-95a8-21d23addc362;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1c9a828-9e7f-469a-565f-08d90ae91c91
x-ms-traffictypediagnostic: BL1PR12MB5223:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5223DD1E6C4AA377E1FDC84DED5F9@BL1PR12MB5223.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:311;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LFu12E7TheG9cvI7N0D/IgnO2RMRGdmosTMBDJB5toLVJH6+9itgFKBZGB9gYZNgc0m5Y9aOuGd4BSzth2BVE3oEx9MD6fM3AAAtutGqO7cbfBJcsVV4RpY+u+B1fl7/UdEk+q3g79SKTsXJUgOuUyVTeSqAQImu5YEQj657rpxaQKenPjixF9XEHiEqPy1F5fNvcdR9kzx4bbzIhyijw54znqIy/ml5CbOAbBHp1B8j9ikvkEowaqkuvsmQcJqOw8lAZsMIkB3p5MCRq4c8xHmDbFoZeJ50ywB1dgrh14nbNS/W+MxaKye8HSG4HLQQvVBdNWbwLM5HpSFeSfDWmNPnIvvDJ8YLEHqD1kOP3q81tLgqQYezHmeg6ZF3lzuEG6AEkuB+G+zayz22utyV8XMiBMAEMAciMjslVFRCjB00kpIM1WbpY5DMJIWVU/T4L3sydGYq7ry7q9QzBz1PIA7awd/u71pei+Nh7gkQMCTObQaQDLkpmbBFOyWNE4/u0Ptu1RgCFxRzaYLpRGSdIqbRm41W2xHLkbcMXR546Kgf2ovPVLY1gD8lErZUqidPJB1+OTwNhQh/GJ9WKoG11FZml8ZH/q4otCkrQ2XApdg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5350.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(7696005)(86362001)(66946007)(66476007)(122000001)(186003)(9686003)(26005)(38100700002)(66556008)(478600001)(33656002)(53546011)(6506007)(64756008)(110136005)(316002)(5660300002)(55016002)(8676002)(66446008)(76116006)(4326008)(83380400001)(71200400001)(8936002)(52536014)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZFlSZDF2eitWL2UxVjJkQ0p0SnVlTU5aM0NPNzVUMzlHTUVha09tbnpaUmRo?=
 =?utf-8?B?NnBLNkd0aTlNbEJKbUxzaWNYaWhaS1lIMm4zTXg1WTlMQTdmVzJqUzFvTlMr?=
 =?utf-8?B?Rm9NVDFEQzluV3BnUlcwaFkzNjlaeTlRMUpWeXBGM2UzRDQ1SVgvbGUyZTE3?=
 =?utf-8?B?ekFjcnlZYVk2VVRieGJkMWJNSWFacnZqb2VPeU51U1RheFkrVnpERitBQWxk?=
 =?utf-8?B?L1QvcGs0Z2lsOVU2bDRLS1RJVU1veGpCMmtvSHlXc0VIeDNraDY5S2puT0xw?=
 =?utf-8?B?U1ZIeU90RHlHTmZVYVloNkNUVEJtMGN6UHlGUGhocG5QNGhIdFNwT2RwWkJI?=
 =?utf-8?B?SG03a0xYQVREcE5YSTJOUmZWdVRmWGZhL0Y3TWh4M01jVU50d1RLK09GamNC?=
 =?utf-8?B?eHhla1RVclV1S2NsTXV0MWFIY2ZIRDZFM2VwWVhMMVNRdmhiaEw5cGhnL1pj?=
 =?utf-8?B?MkI3R2E3a1l0T2pRWVU4WWpCQXoveWNxbVBFeFp1VGdFUUtrSzJ5OWVGelNj?=
 =?utf-8?B?RllZZktwWHc1Ym9HekJrckI4Qmc0enp1eFNtVFJHRkxRVmQ3UEFkaHZtaGx3?=
 =?utf-8?B?M0lRQUlvN09KTU9PUzlCaFB2b0dOOGs4a2JmR1krams1UUZSYjNDZE42OVhu?=
 =?utf-8?B?WDV1V3pmRlRIZ1BsUDRoZU00blA1aERvSlBQNWo2ejd5NGh4Q0g1bXA1VzVa?=
 =?utf-8?B?UFRqUTZSTnBFUmxOd2ZKd1gzRWZjblo5UVBycmMrdWFaWVdHRGN0OUhuaVhL?=
 =?utf-8?B?THZDWk9ScWQyTWZENE5FSndQTjJ4cnBZVU5DN2JRZnc5WG5DMWIvZFdYanVI?=
 =?utf-8?B?ektkaWpNYmdXcE5BTWhyenhNdHVLYnQzRlNsbDhFSFBoTHNDMWo5eXFyZFBx?=
 =?utf-8?B?U29FQk5ZZERBc3NrRUNCUkZDNWFQNzA5S1pGL0lXNlc2OHdDMVpQZTFEKzQ3?=
 =?utf-8?B?UmF2b1ZabEtURWErK3p5SXRDVmEwZThjSCtoN1JReFVGMDRzRjVwS0JoMEd3?=
 =?utf-8?B?dGJPTWhNdE5NbXBHWklTdERESS80aXRRMEhrOGlrVnd1WCtuYTVlS3M4Vm5J?=
 =?utf-8?B?Um82cDZhVWEyWDBrajN0b0pDOGErSDA3c3hCWnBjQjNPYXoxc1FibTRQUStZ?=
 =?utf-8?B?Z3FpOUZNT0ZLSXVIMzlOcXhTL3h4SXJBelR2eCtQVkJLblFJUS80b3lCcThX?=
 =?utf-8?B?QWJRZWYzN1RjVEM2OS90MlR0NjZuS2hmdmJyOE5oM3VlS2xVbmpzUjBPVFV6?=
 =?utf-8?B?ZVBJV2dnSytYempSSlVpNU95K3ZnQmlBcXRtUkN2UGNLUEJWeldNRjBLRzQv?=
 =?utf-8?B?TWMwNGY1UVJ3enNPSUFXdlRDekFNakNCR1BpOXVOa1JkZ2lxRldTYmlVSkRi?=
 =?utf-8?B?RVNlUlRjWkdrZFE5M3lwZndES1pjQWVZVElERzhvZXNqUzNjV245MStwMzVV?=
 =?utf-8?B?aFAxNE1nYVJoNENqbFpNcXExWTN1RWVJUHVFbXZuY3hic2tZeUlCQjdteDVH?=
 =?utf-8?B?V2Q0a1M1elNKbTlVSHBvc3NyME1vU2MwUFVjc3Y0bXpxdHAxcitKbnhEeXFz?=
 =?utf-8?B?TkJ5R1hlZHJabmRDcnQ3WlNTSjYvbkVjYzlUTFptZnNjRDlWTlMrZDd3TTlq?=
 =?utf-8?B?RHZXRjV4YnNtZW51dVZzNFl5NERLSEVxVW1rd1JzQm9QekorVTBxbDR2MXl5?=
 =?utf-8?B?Ni9KNVJqWUtxS1hwNWN1WW4yaS93THQrdzRJR29ZRE1zazRsMXJUY01TeWkv?=
 =?utf-8?Q?U+Zn/IVGFYKr23gUfTTV+alOSEY21xf9X/8hll7?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5350.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c9a828-9e7f-469a-565f-08d90ae91c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 08:30:57.1007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRog1WtsATBeXnsndOmpZHazW6JQWyeGHUgAZENjUChwyKB5FGfOMWel1qEX/AHB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

This patch looks good to me.

Reviewed-by: Dennis Li <Dennis.Li@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Thursday, April 29, 2021 2:26 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 4/7] drm/amdgpu: initialize hdp v4_0 ras functions

hdp v4_0 support ras features

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 4da8b3d..8e0cab5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -53,6 +53,7 @@
 #include "mmhub_v1_7.h"
 #include "umc_v6_1.h"
 #include "umc_v6_0.h"
+#include "hdp_v4_0.h"
 
 #include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
 
@@ -1210,6 +1211,11 @@ static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 	adev->gfxhub.funcs = &gfxhub_v1_0_funcs;  }
 
+static void gmc_v9_0_set_hdp_ras_funcs(struct amdgpu_device *adev) {
+	adev->hdp.ras_funcs = &hdp_v4_0_ras_funcs; }
+
 static int gmc_v9_0_early_init(void *handle)  {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle; @@ -1230,6 +1236,7 @@ static int gmc_v9_0_early_init(void *handle)
 	gmc_v9_0_set_mmhub_funcs(adev);
 	gmc_v9_0_set_mmhub_ras_funcs(adev);
 	gmc_v9_0_set_gfxhub_funcs(adev);
+	gmc_v9_0_set_hdp_ras_funcs(adev);
 
 	adev->gmc.shared_aperture_start = 0x2000000000000000ULL;
 	adev->gmc.shared_aperture_end =
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
