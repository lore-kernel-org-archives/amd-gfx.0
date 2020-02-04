Return-Path: <SRS0=NM/7=3Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC73C35247
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2020 02:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EED92084E
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2020 02:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EUvVvcFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EED92084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C98796ED80;
	Tue,  4 Feb 2020 02:07:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97CFC6ED80
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2020 02:07:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAVAEkWZXPnJ5NwmlItxcL/ROGi7lKfmlBnOmnF4bvPAOwHkksrWhTyHgtuV9s0XjA+733XQoJh2UNeSD4jAr0b9v5Z12Tm4ErSkiwr2JvxMGzXZHTPcM4syy2egkvi4ErMxdHHEggxlyX/A2W178RGYCr/FEuhcAWe8WMrHDyhq+dbBBBOUJMDLXDj8a06REdySF4tDqECY2SDzk0h3oE2IQZ4SudEL+fvAsW5ynsdTg563KYlNav2cD8JUaWbV9hHCu9lL6x3C+fe1anXJsvyoJbyd+Lm1t+jvalNrUNVW8NYNEluVVMhRKmmCBeufw2UYRTcQNGRZbYDJ5BbTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3d4O+v0vWG0rCNcq5NkRL+McYFlmB7zfWLXCnJE85E=;
 b=ft1L3XrzhIoBMFTiCceBQDMqLEoaJFB8qZKX2a6uhQxkv+FEHAIDS1L/pnSLElap+5w3xyVFCOJ9vn1Bi6Z+4uB9IYdr6TGtyTkv3KiDm2dPbGWPle+nO4LnflYHQ2BtOmvvE3R4oCFx0wybQ8Wv5v/0yHpPTulR/kUqy++EVTeF6HjjY1aY/WlYgg6hl/RHMCnvt5iVk+OVArg4GlIa50VdoCIpLP9esZenWaeojrZEXZcIIk5gR+XHvsyqML+UDSggmMmHQeCZLlXQj71rUov4pU4Z387pS6pxHD9XTo7RoIig472fCU98WZw2wKxbpXxr7eKaZQ5XsJL+5ElZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3d4O+v0vWG0rCNcq5NkRL+McYFlmB7zfWLXCnJE85E=;
 b=EUvVvcFi6faIAvxbujG5X6fafoM/4F4TP+PqHugkqCI+ZDRd7eZEJWxcxvJUQOPeEvF5m3ow2+3vSxPY9nA67shwiMdZOD6+Id8UrQEVhGrnpvhAp2+xTDPviq8x/VL5yZM+dygBHAicEr2eEeYf701sZWrxVmhDu1VITQPMFkc=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3247.namprd12.prod.outlook.com (20.179.81.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Tue, 4 Feb 2020 02:07:24 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 02:07:24 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu/smu10: fix
 smu10_get_clock_by_type_with_voltage
Thread-Topic: [PATCH 3/3] drm/amdgpu/smu10: fix
 smu10_get_clock_by_type_with_voltage
Thread-Index: AQHV1s4u1PY5GXK3KkSeys1FDUM65qgKUgpQ
Date: Tue, 4 Feb 2020 02:07:24 +0000
Message-ID: <MN2PR12MB33442E5B4EFE783F9F61E796E4030@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200129180130.585870-1-alexander.deucher@amd.com>
 <20200129180130.585870-3-alexander.deucher@amd.com>
In-Reply-To: <20200129180130.585870-3-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [123.127.234.234]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 06b12eb2-2947-4341-45c1-08d7a916f9f5
x-ms-traffictypediagnostic: MN2PR12MB3247:|MN2PR12MB3247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3247C4D393DFF0753EFDC229E4030@MN2PR12MB3247.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:475;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(8676002)(81156014)(81166006)(66556008)(6506007)(8936002)(66946007)(76116006)(186003)(7696005)(53546011)(478600001)(66476007)(66446008)(26005)(4326008)(64756008)(71200400001)(45080400002)(966005)(9686003)(33656002)(52536014)(55016002)(86362001)(110136005)(316002)(2906002)(5660300002)(9126004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3247;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G0GY8ZTGq24rzHmx1mKL/ZV0KHpH5TqbVodq6UsyW4eKpu+977fdxIUw2NcM1IvELo093KTzMBZp+yng+gDlP9hHqb+NpnihgCTJwdEw5W7GJpUQFkuqZP8AGYw4MDxH62+qfME+Sl4O5i47BJ0Kf28x89NNYo9bLfHvVa/qAxHOLz+e4YvvmM+fgoKH6RSgzUvxcnRJ1IUfOhLE31aSnQfEBAzr59PZLz6wzkLBa6tCGKzEScG062BQ0JBvW1Q21g+lnlGKJxhZemGVInumHsEnkewda5IGBGm2Gd0kLZWYbxKAGHxROZneEXGdM4KRHm2uLao0tDGQa+Zt3pX6fmSoJn3vPSHLvS4LSFZsJ5kNjjXQ6Hh2tlJ2V//canIsK3usEfQxypZemreLmLuzU7qVx96E8IE71bRgE9s1rS+9wFc8Ltv+KJvqDpmMUK6V0JIa+1IFdDlGMdc9OvpICw04jVGrQhqYORSVdI2MImAm+iX488Wq1IQujiPfn35jDxztc97amN34WLfocIDHxxdzC7wwLtll5skeCEG4sgLj7Y6ruOAlNic3We9wkS35
x-ms-exchange-antispam-messagedata: Oac4UravOwpfxCevVbNtgWwyYR+2xnoTBTexD0C1eh6vKGVglicU1Ic3tbO9T35G3kJBh+iE4zE+4vM2cV69KQ4nSiE5QuCJYKg5QFRI53FfuT1j9uqa+1FR8TR06KeX/AAz1s1LYa3GpDXtm74cNQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b12eb2-2947-4341-45c1-08d7a916f9f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 02:07:24.2551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WopYo2biZVecADfXM85eKT6EtpdQjKMi0bgR2Z5H2DIAYdprBIEk314G3kn1oFU8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3247
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

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, January 30, 2020 2:02 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/smu10: fix smu10_get_clock_by_type_with_voltage

Cull out 0 clocks to avoid a warning in DC.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2Fissues%2F963&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cdb4d6e0d0d9940cf353b08d7a4e54d7f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637159177099605051&amp;sdata=qugcyFk3Qu6xc%2ByuuhAVZ8Am2KRrhp7zZl37p023TW8%3D&amp;reserved=0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 273126cfc37d..689072a312a7 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -1080,9 +1080,11 @@ static int smu10_get_clock_by_type_with_voltage(struct pp_hwmgr *hwmgr,
 
 	clocks->num_levels = 0;
 	for (i = 0; i < pclk_vol_table->count; i++) {
-		clocks->data[i].clocks_in_khz = pclk_vol_table->entries[i].clk  * 10;
-		clocks->data[i].voltage_in_mv = pclk_vol_table->entries[i].vol;
-		clocks->num_levels++;
+		if (pclk_vol_table->entries[i].clk) {
+			clocks->data[clocks->num_levels].clocks_in_khz = pclk_vol_table->entries[i].clk  * 10;
+			clocks->data[clocks->num_levels].voltage_in_mv = pclk_vol_table->entries[i].vol;
+			clocks->num_levels++;
+		}
 	}
 
 	return 0;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cdb4d6e0d0d9940cf353b08d7a4e54d7f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637159177099605051&amp;sdata=B33UJMbMy0tRJkG%2BM7ajYKktcka%2BDz1ehc8tbpOCh0s%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
