Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14812C63777
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 01:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C67F207FF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 01:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jjyqVTbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C67F207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA76789E52;
	Tue,  1 Dec 2020 01:59:24 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770041.outbound.protection.outlook.com [40.107.77.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B27C89E52
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 01:59:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdHjI62O6RbLXiENNlPmMa9xwBkbPxes3xirdv6T6nyH9ERmtx6PUml5d5Ym7ic+emlB/nY6e5rTTwMBgvVvliJ13CBGzYgl060pdQN1/ElBWwe6QjR0rMENhdcTNID/kcQDRL3bCsL6DXeGLO1eqd9YlTvHRxeH/E4yub3uWwLYrBufEr72lstSDvP4DQXgEGAtYxsQwG7qlKC8UE1CclAjwqwRp5cBJ5JrMDSYk38+WvsQ+Q8lDhx6NWoojECQSHjKZP0HiXODpkZbd2QdHhRNH/1PAJ20q+zA5WLXKMINIaz/sWwaY6fYWSRoYH5mmt2aWxswssKVYeJjtyc5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqhLXCCfBFt1kUn9L3RygLfrQ7ySARLM9lSxfw82tzY=;
 b=MktsokJeS5fsjeeEID53MAnyHk5L4JLjT4a2ViXbqRvmgv57r12+neykhJeMVZ77+2/gVs3Kbawa6DgB9RXSpuKYDp2V+S9QiYP+w33/ROXl0p/PufiGq/H2ZP8xqgJ9D8kyYf4Sb864SPAv+qMrjOaxm3hSIqKCqxfaKyWCQnRRjky00e0MKS01bQpy1PVptvgsV9psYuqEX524QCs1cL5uF0WqVfVU/GJhESo25Qgg+v+EgEbBHbfX1GF8Vo99Kl/n1NV5j47LWFm/e60G/E+K0FlL5WGusH7FMtxsouyazPoOjmlL7usFLwKBBBW5IpLuTooAHn6asz47NeodXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqhLXCCfBFt1kUn9L3RygLfrQ7ySARLM9lSxfw82tzY=;
 b=jjyqVTbgrg+5EffjH2ApC3Rw2qNXZwXwEPU3OHa0j8xiyCX5GGaiTJR5er64H2dmAcvZeaWXBVRl3yRxWIJLpFBCbC88i+EN4JJB0lVLDbWPh3qO0MyabwdCM5Q4GPrt2yO53v8OKuxkm5o3+7AXSjP4Y1CJjeEaBSLThcU9Oys=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3867.namprd12.prod.outlook.com (2603:10b6:5:1cf::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20; Tue, 1 Dec 2020 01:59:20 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Tue, 1 Dec 2020
 01:59:20 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay/iceland: return an error if copying
 to smc fails
Thread-Topic: [PATCH] drm/amdgpu/powerplay/iceland: return an error if copying
 to smc fails
Thread-Index: AQHWx3HZrECYKFigdUa8xWWuJJHmYanhfD0g
Date: Tue, 1 Dec 2020 01:59:20 +0000
Message-ID: <DM6PR12MB2619F76F33DE77CD658D23ADE4F40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201130233749.387023-1-alexander.deucher@amd.com>
In-Reply-To: <20201130233749.387023-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c78e9bbe-0039-4665-ab5b-956b05b4c749;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-01T01:59:12Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4146cb45-f71f-4136-cf7f-08d8959cb7af
x-ms-traffictypediagnostic: DM6PR12MB3867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB38670468BA34DB092A47D104E4F40@DM6PR12MB3867.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:480;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: crlJXQ2qeZG6q2RNgE2Pr5a3i0bWj8jCqQW1252mX0WLQR8BsppZQZM8xIM9LgdR20dA3Dvpyl08D2D71yxIzuGt4Do1wsu3YF/JLuBaSNEsBolL/n+VmJlN+Bpx7NWI2XHRrB7A/HxXlzIk4VKqfgcyHWu4Sb024jN45NgeJQQ2XTXZqHasxh5hddqFApQeyRqNXnldzz7gxEd6aM3/BkKZUVbZxoIB6ov3LRIrJ7umtJZfwsJblOuDQiXG4y9ozVv0R+xQk5QF3cQtO6k5aeKkeZzqYfywJlqnOPb7GEcZSYaxxShLyyoKFCOUdSRc3VbbHrIXNJD6GTbgllVPLoUms/C7u4RuChbXRhEHZ1c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(4326008)(33656002)(316002)(86362001)(8676002)(66556008)(55016002)(66946007)(5660300002)(66476007)(64756008)(186003)(76116006)(26005)(66446008)(52536014)(966005)(53546011)(2906002)(8936002)(71200400001)(7696005)(45080400002)(6506007)(478600001)(110136005)(83380400001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KtmSosSfElbK7lZePEvuH4HwwPK8WX/QNZOUuWi3bZ1194fiyEqAyTspy2Bg?=
 =?us-ascii?Q?x2bVJM5mxMxozovDjgtmd7MAazjasw+KLPEWUehvAzLD1Y2/Rt8XXdBj1HMr?=
 =?us-ascii?Q?jTkqSOiGwvK1iFJXWMhXiBV/GdVETM3OzFbiJSYPa/va7RfUNEehOGbNazL7?=
 =?us-ascii?Q?Lq6tgx8t8NNZRap9uY4cIz6d1q/FHBKv3PDlQrX8RN8CcZGGy6TA/AC6/LgC?=
 =?us-ascii?Q?nCVAgRabzOE2W4sIc2XVk9uiTpmmZFFIBICMhu4GzioyBGsUnbimnNSfU02j?=
 =?us-ascii?Q?n7z7Ss5sJdU8Zcxk4hiAx6XYn4kBp6Qpcgwwbv7v3uli+khsh0g1Cg41zaGK?=
 =?us-ascii?Q?mPv8/qkCRALg14rEofHQm9PA50MqTGKQZ97jNqIPbyOT1GIS+zPdbUH4HL5s?=
 =?us-ascii?Q?hOjwqGySeTdvM/UMKSdaQfOaBL3qyTKOTA9L2xMVHJd07QbZl5iV99Wnihvs?=
 =?us-ascii?Q?mmHPJUQdDVWMVlA+IQbunl1+8JLLHlN6WoynCr+wd4lQuB+fmWKLbfgkWTnL?=
 =?us-ascii?Q?q3bfudh7qF5PTWCCVpQDJpAV3yqW/jU+MtcJuWT0PyS6fu4ehSKcHH93Fl7N?=
 =?us-ascii?Q?3btuCD1NgKBSD35qk75O5k7tOvlMNfNmVvwJnKImViaZaPC1hk3Xs0yLWRbo?=
 =?us-ascii?Q?TgmFQMjSGQoe7GhJCl4X1a4NlKdcrbuM/M20AX8ZwRb4Y//H9SBiASu6VJ+Z?=
 =?us-ascii?Q?bI3sI1eoKZPF1NLrwDfWbbrIZwehM3RAOAkQAQdggFFbzgxiPtgZwAjP5Lfz?=
 =?us-ascii?Q?tLb2/FLz4alyMKeh7xJoGikzQeYbboFHygJ1ZA2DhKgiVceNECIoWz+8P5B3?=
 =?us-ascii?Q?uWN5wtFwHbL1x8IHMJMVyZgySmMLm+BT6v5wEO2ityUk2+DiXLiqa2WP378W?=
 =?us-ascii?Q?dqCjrIUJ8POl10tbftxvhuDVOGqp6OBfvM275UHbxCLZWnzmxZFDAly4sVv1?=
 =?us-ascii?Q?wQKU6Y/l6InhTFUNDdTKs8EZVPAqZwu2aYA49lPkXYw=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4146cb45-f71f-4136-cf7f-08d8959cb7af
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 01:59:20.0597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m2g5BkTdY9DXbrz3sMvUXW3VHMjkSRLC3MWpsnRZylVsumSGxBrsJLEuESAiaMCx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3867
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, December 1, 2020 7:38 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/powerplay/iceland: return an error if copying to smc fails

Rather than just silently dropping it.  Also fixes a set but
unused variable warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
index 6a0f581de999..03df35dee8ba 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
@@ -2156,7 +2156,7 @@ static int iceland_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)

 res = smu7_copy_bytes_to_smc(hwmgr, smu7_data->fan_table_start, (uint8_t *)&fan_table, (uint32_t)sizeof(fan_table), SMC_RAM_END);

-return 0;
+return res;
 }


--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cb5c7fef8fc33490389a708d89588fb18%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637423762842822121%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=sNFPNZLPera5DF6BUa6RZf0RsSTLlv9vaaGp9FlG7YM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
