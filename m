Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A955FC47082
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 01:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB50610A8
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 01:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB50610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DAFC6F552;
	Fri,  4 Jun 2021 01:13:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31FE76F552
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 01:13:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQJvv1ke1VbDRgtMRvZtoT9TWcz1Okkc+1TDfX0hK6Eod8MrXSR5r5gZru7SmgdvXnIawy3gw239QwKc2xuNK0Euhx/+eph2E56rybcQhjspBOIWFlOZpC8txKyFmI6hzEtNhrdtIKmNGfaPfRLpb9mswCP7NO2/CcyUD4SMEuFKW/z5nyfYY7KzFDPWIW9x0RYbvr/ky+d1et1IuheQEJPPq4bCdyXlcnbl2B2Mv97j+SrRfCqvNJcn3nIRpwqKNeBHZVmpnOuf6ZR+yEh3qaG+v3fePqe1xhe2CNE9n1xqJAVg+iZU79BQ7ARn7DKyXvSbjaB20cjD/U6+uiEu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qss1QHO66phqSGbo/t63IK6YecB4MW0CDoo0pRnHNDM=;
 b=JETFBF8LQam5wj5LbxCWjrKV9T2K8zFBA5SVrawylHUkFFFm7jvQROjxtv6P/JQsOH53lYu9VY7FhljDp/mUY1OgVcjqn2chSiEKkvqEGnkoF7ougSQuomU7B/JXLppclUdxSQQOdVuTrRWY9g8dYhkl6iSeVGg8SQFIyF7GDv7Ru35yVZAJdHWJaL00jioGzJdHJTEbKbE4B3CnC4/3t/HtOPFdaFOpd952rX/wxnK/2U93QrY+oKGCtMX0liw12qKHJNazj5zaGai55nBuCt8tSEemJnAQk5EFeMqgl5N1Bz8aW2gXosqIg7vyYcTPjvtTkd+iSSPJCG62qpykqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qss1QHO66phqSGbo/t63IK6YecB4MW0CDoo0pRnHNDM=;
 b=Nbrp5XwpAEWUyus+A0rJqZzGXjKkIepQHmxnhOFv3x/9lKfONOIkdz5IyKYV2nGdd4ROMTkvWsJTL9Oe/zAn97fG5dL6dfSs2AbmKw/r3lJXoAtvGHDvzqGzIyc4uLcYghACUhw8WE/jvbcVM/MtMtoeGRcMViiKeltWkurgpCY=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH0PR12MB5434.namprd12.prod.outlook.com (2603:10b6:510:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 01:13:10 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::b822:fe51:a6e3:817d]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::b822:fe51:a6e3:817d%7]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 01:13:10 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from getting fb
 location
Thread-Topic: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from getting fb
 location
Thread-Index: AQHXWIKl0z0N/qODbkGsIGtdXRqenqsCY/aAgACodKA=
Date: Fri, 4 Jun 2021 01:13:10 +0000
Message-ID: <PH0PR12MB54171568B27151FC487210928F3B9@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
 <DM6PR12MB5534D815A3DBF82EBE78C576F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB5534D815A3DBF82EBE78C576F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-03T15:09:46Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=dc0d67b5-4871-4759-98b2-407e1a34d35f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11c7dd69-88ea-407f-3a98-08d926f5eb48
x-ms-traffictypediagnostic: PH0PR12MB5434:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB54344A36CB577F54AF21E2A88F3B9@PH0PR12MB5434.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1++Zdsw3cr9yfAPyflHVoDDqGYyZlSV0RCtOQoVU+poNfbpScCA5gwXepy42bAE56NywCCo7o2GZJIgXtYYGk27Sbpu7Wei94G4C8bNfspbZCX7xFDr2ahUeWotKLQx1HQ3g57IbxsnGWshWwBrbtgpp2J9HYL45MyDxevqcHfci/NTfRCZ2JZ33SwqpQTp/qg8CTYReWFTIcfxYyCge71k2w7aylRPYNIuD4r/DRwiAm21YyUok8dYzYHiNtR1Q2ASG7a2xhK6elY0uQMJGwQKZobEMv4CnB1gEhDmy8u8+Bp3cGpCPiISPW//3NC3WVR5iHof4ct++y/gO7BWHbkdFxXv7xFk4wtl3VXFspehq2uWiv8avZ/dHPr0nXWEfdQJw5ow2HkLA/ffvXQ52lx1TyZFRBeo+1nciHAnv+91asPXWgX1O8s9ui+Eh1RF9J3T5u6ubGokbxrwD6MqGSil6+GxbaiOAY3mSMuNZUUVfkHpZ5NFZWkXDnhYjqh4XqbScowBjMwVTKaa8nAjo7baKh0pdU4ciHyDy4w42A3foBahFR31Lc/0J2x7c//bTNKiuPST1u5cJAwDwK/U85NYJA7wHG0JsCuTjVpRjmDHu78bCbTbHWqPZ5q82hR3z3c8HJecJjG4flmnvqSLP/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(38100700002)(122000001)(9686003)(186003)(26005)(2906002)(6506007)(45080400002)(33656002)(55016002)(71200400001)(86362001)(478600001)(7696005)(8936002)(8676002)(316002)(4326008)(110136005)(52536014)(66946007)(76116006)(5660300002)(66446008)(66556008)(66476007)(64756008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OfxvXK9+H5HayXn78d0uuhyvT2ufB0v4JWPQqKxKiG5MTmuHbqohdJA7p8g5?=
 =?us-ascii?Q?XJDP+XgSj+40kfw9ah2iiJA0ny2KUorQvVlVXK5CqrYtqk7Pe1OSFiJdV7Pa?=
 =?us-ascii?Q?wj40e9kme8GI4DnrusJtSQ/s6GbydnHjIA3m83HV8mUz3eO5zQwmYbQD/Ga2?=
 =?us-ascii?Q?j986rvalUi3aUW7KnV/qldLJY/qyK9BeqDvJpfPtRYI3J70T0DXFsoLNDJG5?=
 =?us-ascii?Q?vraYzNcH1xU5N01P0NRXgWeZJbldbql6Zgb7Jnh1uhct2bYknmfNmdsuV/G3?=
 =?us-ascii?Q?oky6jI9NT3uvDebgOu9WjNc+hcqyOQRNy2cS7HlgPTnuLxAIPUaYA5sXNsbL?=
 =?us-ascii?Q?PK4MDae7bVSmMM9C5f0nR8yBIMCZsqKhcazR3/cI5/LVyXOZ5fqFHBYgwLBx?=
 =?us-ascii?Q?q9RBs+QgiF2rR8L+Aa4cC60gd7eNGI+O0EvrCfRxwu4YB+X7O5vxu3lYso8p?=
 =?us-ascii?Q?Zv8ICqa0ywLKS8GYGFpR+RgNg6nJP/aNA259KH13e7U/BT30NSuDHcGRj2rq?=
 =?us-ascii?Q?C8qVxCdvuC+XipBZT4KkwFPh/Ziv+gap51zXP9tcAkfM2SNxbWNkdtueh4Cs?=
 =?us-ascii?Q?1uF7I9lXNyXrTiyZewh87xiCHitCPmZhePIS6BPuU0qsW5a2K+HqlnMOv/Se?=
 =?us-ascii?Q?BWwyC7fCbNczJhUd3Alky7eMzuw6FyvaF4ARR1/WHoifsF3Uv2FmkksHjhoV?=
 =?us-ascii?Q?e2Jo0UCMxC6SPPrtOchV9hDIRGansp2HiK6dGM/E1qg2f8BV6tmYUud32Vcf?=
 =?us-ascii?Q?hylYDw5yaZcl6X1NdMuQSwCnIDEhgbowq+oVPx5VOUG336KtwdaArbyu90qd?=
 =?us-ascii?Q?68VDIfg7s2NOV4WZzvYftyNqEodTGTLLjhpHVVPVSmoHt9q2wCBOzp86/tym?=
 =?us-ascii?Q?T8TrY71rch9CkxwqPkYi12XPQ7SWbtRCpHK3L5qyJdvahnh4ihKQGw3rRr5c?=
 =?us-ascii?Q?Hfb/Th75WOi8/Fy48Xo1P+rwTUUGTOXo5I2zVCN1GrXxeko7V2vncxoVXA1u?=
 =?us-ascii?Q?6YBWfZnbhx4X2G1126oByRFPI5fQwHuPNzncJ5Z/m1ZS2Heifc9/6yJO1H8J?=
 =?us-ascii?Q?1ntbzzeelOm9JfBITimP0z6ubcIxk1nF/wpO6Ec3muC46tlNGrF1mpP4qdIh?=
 =?us-ascii?Q?hT2+vEUkYsi/HLJYTJ/GJe/pYdf+/XemoW7r+3+aHDnJDVOX4YOVESHMEbBD?=
 =?us-ascii?Q?KQXvuqL+v958eQ+A2dzR6O4wK89NnYtLtxcnE2jUfpbgiJH62CfAQtzWnJoy?=
 =?us-ascii?Q?zOOAH+85cs565GaFDGGsi7cujAe8/VzsT2foZ0zULGySq8m8N+8sL9UOO327?=
 =?us-ascii?Q?NOvqs169QjvdW+xKsEzqXLUw?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c7dd69-88ea-407f-3a98-08d926f5eb48
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 01:13:10.4066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CwL8U2dTd6c0utfXdEhZEtsUz/M88h0zw0v/eIZ1kMiuD4AAXq5idt5q3zCAb1a4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5434
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
Cc: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do we need to consider backward compatibility?


Best wishes
Emily Deng


>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu,
>Shaoyun
>Sent: Thursday, June 3, 2021 11:10 PM
>To: Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
>Subject: RE: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from getting fb
>location
>
>[AMD Official Use Only]
>
>Looks ok to me .
>
>Reviewed-By : Shaoyun.liu <shaoyunl@amd.com>
>
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang
>Luo
>Sent: Thursday, June 3, 2021 10:13 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
>Subject: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from getting fb
>location
>
>host driver programmed fb location registers for vf, no need to check anymore.
>
>Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>index ceb3968d8326..1c2d9fde9021 100644
>--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>@@ -1292,10 +1292,7 @@ static int gmc_v9_0_late_init(void *handle)  static
>void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
> 					struct amdgpu_gmc *mc)
> {
>-	u64 base = 0;
>-
>-	if (!amdgpu_sriov_vf(adev))
>-		base = adev->mmhub.funcs->get_fb_location(adev);
>+	u64 base = adev->mmhub.funcs->get_fb_location(adev);
>
> 	/* add the xgmi offset of the physical node */
> 	base += adev->gmc.xgmi.physical_node_id * adev-
>>gmc.xgmi.node_segment_size;
>--
>2.17.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7CEmily.Deng%40amd.com%7Cd41e78b1a3af4f08ff
>d108d926a1a2d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
>7583297946242271%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
>LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Nsz
>ZyRZHCxj%2FIJ1hYoSrkv3LpTmF9FbchpNMtQ2GE5M%3D&amp;reserved=0
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7CEmily.Deng%40amd.com%7Cd41e78b1a3af4f08ff
>d108d926a1a2d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
>7583297946242271%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
>LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Nsz
>ZyRZHCxj%2FIJ1hYoSrkv3LpTmF9FbchpNMtQ2GE5M%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
