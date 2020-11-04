Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39B4C2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 01:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F046C223C7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 01:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ftLmhvmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F046C223C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 636B06E926;
	Wed,  4 Nov 2020 01:12:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E49E36E927
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 01:12:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHTrOeFpFov3o11+s0YC9ISbnTXtz1BufbvTbVCOpqso7gB3vDTq0mOk4js38tI+9tzrqSlcKY7syojlo5J66+0vClJtjfQm6QLFZ9Nbatrn44m389ZCi8fTlGeOE/7PQHtzoN5VjEnfW7ck6/u8tV+Z3dH6UY4VkxFN6djx3fsMIi7U6NdFGcr2Usd6nvI0PTDV7rrEVTm2AsRMViZOe06VajkPbsxlQirnySUGFWm3NCwaPnlOYe157OZlIU01H94zwr2/n6RBNMUNKOIK1WQ6D/u5+4k/C5esbJYBRbvomehL8lObq6QgjQVWXEszfwYxCfgGYAHwF+iismqHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MmsU33qa1RijmMogQ0Tyzdwq6uY454lGsOYQzSsYTk=;
 b=bStyN0c65UtQ3gf3myscknSioG1vZd7W3E9lUmOF89hvlINFnb1nHzoyDsoyBqWuXEsrx33VykzJWFYNHKBjhQnEHXYik7vP2RdcC704EFzF+7QhWofHUyUvnQgZwCfgsqEsn32VAKDVav90tHVCDzgRGqHXOwHunBD8siqA5y4Hn8rab1yEXX9svR9tJLytWUSPlTqoUzcS963Jfn4pxDflivP2R1PUDoVfSWqO6LTFeBEM3f0hIS6H4doULFnzM7AG7sdeABMYQ8pU9PKGJnyjwRtl7PEk+6agPJaKU6VpJL8YV96u4y5XQFSpyGjSyNVgN5FbET97tgCS//OVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MmsU33qa1RijmMogQ0Tyzdwq6uY454lGsOYQzSsYTk=;
 b=ftLmhvmCBhealUXnywW1/pIX6r/pBoBKyT4uDarmqXwzNZ638CsendpS/ChxyG47QRDBzK3HhQaS/P/DsBOqNGRLSNx/8GS70OTLXxHmQ946n+Vbt2IzDgnUlqeh+tBQ2QO9HPCRo5kubmbOxSjzlbi486j4sPPzGIVcuMF1hd4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3579.namprd12.prod.outlook.com (2603:10b6:5:11f::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.29; Wed, 4 Nov 2020 01:12:33 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 01:12:32 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/swsmu: remove duplicate call to
 smu_set_default_dpm_table
Thread-Topic: [PATCH] drm/amdgpu/swsmu: remove duplicate call to
 smu_set_default_dpm_table
Thread-Index: AQHWsjiHk6UPofFMn0yXUFKJG36Qwqm3KcjA
Date: Wed, 4 Nov 2020 01:12:32 +0000
Message-ID: <DM6PR12MB261967F844E1050529EFAC71E4EF0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201103232434.832933-1-alexander.deucher@amd.com>
In-Reply-To: <20201103232434.832933-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=de421256-59c6-430b-87b7-98c6485e2e3f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-04T01:09:16Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c79f40d-482f-4166-985b-08d8805eb544
x-ms-traffictypediagnostic: DM6PR12MB3579:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3579F993E2A2AA86D020434CE4EF0@DM6PR12MB3579.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ThKjvtpLB3ylJJskFDfFc/wI1GTML43m4pF069Py8Vm/V8NyfkjF0XM6yGXz6CkvtbNrMh23M6+wqY2N3ufG/Idj8qU5BJgM+0zKtb5MVEou13MvuKEhVGnRGlc+jIX0pN8jInxIGg177KshB0UDytuGVKNzc9z+edt5CpMECQcKKmX4uwUmpoLObumhk8gIvB5KIvQnwx5pcGVOcvVk+BPv1WI8kp3EK9gd6GfdItcfkHahcCDZD/iv0dTngvj0HOneiReSHt9+sx0LUow1PG2jQ8caFMLvkxWDMz9889Mnm1JXkbJU5X4JAOrA8grflSFCMuVIVaBai8u1Jw+Nptd1JcdQVOk7NM1DsBJib7Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(966005)(66946007)(66476007)(316002)(9686003)(52536014)(66556008)(76116006)(110136005)(55016002)(478600001)(64756008)(45080400002)(66446008)(2906002)(8936002)(7696005)(86362001)(5660300002)(71200400001)(33656002)(6506007)(4326008)(186003)(83380400001)(8676002)(53546011)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: WBRl/G5lRaI42R2+fP4Q2F/UeEz/p/IZJZdGkKD48uy/ona24WV+enmg0ohU8tj7lLaB5/n1/U+HWHMYQ1BijvZXXHMeqESuY7rI6hqKs0FsyLY4AgApxQEPr6yHQB3AlqFHLjQwhVc7UxLk4TQoze4qrrp4CHFzmtR0DxHGv123cJFjjGtbdI5ON7IcaLFMTqUh9h7gmmYM8l494B56BX2+FwnxI9FAxchHJF0qyc4+d2klZNxMS3Tz00dwu7hk7vCg/+7S/zeP4Z54BabMAZWjvEH85Ja/8l+D9ZLoxBVfEdnGMvhYyXNsbnz6x037CVrrfW+/V/GV+KI6oiBbvxg3yoBOVLfos4nLNT/iVup9kt++YhS4AKs5HGfa5XLUFRKFrziCRXZ6QfMqrjOYzHjTnbHcpQysC30IhvecDjcNckRT2mtWQ9PTIBo47tVc4+FzEcylJpZYPMQxA6XwkYajgN1pnqwYIlR+Xev0CY+nMxOGtVDMzVeZ1g3qRSST1o6u605nC7hmM5ac1m+zMkq5Bb9UYHe0FF++kDCs5aLn5lYQZBzUrXSII2Q+t84JdaKduKa+xmEnL1JKvHRSQZyWqxsdolTz9n87rbK2wTUpKTJ1W8SAcoNTj5hrsEItytZHB0fhF5hW0ma/YsjglA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c79f40d-482f-4166-985b-08d8805eb544
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 01:12:32.8008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNR5Zdho7ucqJ19dTHWmj77AoC+qZ7fua7MGnwExOCyqhjfYnLF5xfK33YvMfFpd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3579
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

Hi Alex,

Where is the other place the smu_set_default_dpm_table get called? smu_late_init()?
If yes, you probably need to leave the one from smu_smc_hw_setup but drop another one from smu_late_init().

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, November 4, 2020 7:25 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/swsmu: remove duplicate call to smu_set_default_dpm_table

For kernel 5.10, this function was called twice due to what looks like a mis-merge.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index fc4f95fa87cf..b1e5ec01527b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1029,17 +1029,6 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 return ret;
 }

-/*
- * Set initialized values (get from vbios) to dpm tables context such as
- * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
- * type of clks.
- */
-ret = smu_set_default_dpm_table(smu);
-if (ret) {
-dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
-return ret;
-}
-
 ret = smu_notify_display_change(smu);
 if (ret)
 return ret;
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cf1a68accb24f48fd825808d8804fa821%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637400426909200216%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=5MGn5WBff4yyAoZra9NGHILEKIWp0iH0ysL55Nj%2BFcQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
