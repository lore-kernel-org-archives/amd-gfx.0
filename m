Return-Path: <SRS0=NM/7=3Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E3AC3524D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2020 02:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A6E2086A
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2020 02:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SwliE04q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A6E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C1236ED7E;
	Tue,  4 Feb 2020 02:07:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94F2C6ED7E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2020 02:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggMRIcVQk32EWTEDFosHkrOELn6cl06rtNLhoCTUVVUvjV7uN8IrhNPgzMVAfv+3FxftFbZcSTCnF8kJLnvQy1bxl7+Cogh2qWxlwp6Gl4VmRteAZNYc4eTL20mf9kERwQSHci4uFd2+sM2Axzi4VlsRwC4C1ON7Tkmc91wijkMgk2S/8s5pB8e3kXqxdUjEjWg/YcJ06BYYEB44746YQV1uvIUKV2u/ILw0vMxBxlVplnStYY31waWEEVZyQQq/P6VddwdVQijiFZoDWp2Q0mw3yI/AifPnUd2GeMwoW9Z1ZiYxofjXqudJ0g3+yIrwmMX/lja+b497f1Elun8gwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwimLOEPZ4J36W6xS8uFhabgc0nM9xiwSYVzLA/F5xY=;
 b=mgYiS5RAhSFfn+kfaWmRBd3FFuwew65GUnvi+Zm1XbsscC5Px9wH7x3aVJESVyL0Ubz0zXX0cCgKfpJ6NL410Yoa+2/uLlM9OtUuhJcv+FrzKnL/R4r56+3sJzbeMdpcXVBl9z/1XWgbQn7TZXPytYQP4GToCn6XCexcbCtQhQRL2/sq+hpykMuw2JK5/+zhNLMvIYt+McHDzY247jjBHNkUk+EEeBxv6CNPWUKFEyPiNhxw2kJF6CymhqdohlxtSbZn7iRgYmp3zHm/wiU90yrdPLmT/LXOmZv0p9tuaqbQ3J7gs9q9IXCAEF7eMe5FcuueuDaE656+jb74eYTYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwimLOEPZ4J36W6xS8uFhabgc0nM9xiwSYVzLA/F5xY=;
 b=SwliE04q1Yk4xvdxJ1DrG2JUsTmoFM8hgumMamh9sxtZyHtZz+qAefDwYQquOJCxoVLJ+1dH5TqPFYW0a7AUHiDh7HpZQNvGNAleFIJuEt8xu0cF99P0Sw7hH4H5l2CJ52BUSADWYQe1I0M+y3wpe+6AMogWyl0MCPzoiOCxDC8=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3247.namprd12.prod.outlook.com (20.179.81.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Tue, 4 Feb 2020 02:07:08 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 02:07:08 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/smu10: fix
 smu10_get_clock_by_type_with_latency
Thread-Topic: [PATCH 2/2] drm/amdgpu/smu10: fix
 smu10_get_clock_by_type_with_latency
Thread-Index: AQHV1hPmkQtzYOs1jUObFKlj50K/bagKU2lQ
Date: Tue, 4 Feb 2020 02:07:07 +0000
Message-ID: <MN2PR12MB33443E604BFD6A91CD4848A2E4030@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200128194707.87898-1-alexander.deucher@amd.com>
 <20200128194707.87898-2-alexander.deucher@amd.com>
In-Reply-To: <20200128194707.87898-2-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [123.127.234.234]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c49b3db-32e4-416e-1ab2-08d7a916f042
x-ms-traffictypediagnostic: MN2PR12MB3247:|MN2PR12MB3247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB32470AC7F963DAC06D17B954E4030@MN2PR12MB3247.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
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
x-microsoft-antispam-message-info: Pxnwj7x05Z4Y01/6Cq+lcjUB37MpR5lltV0PGaUJZAz6+wSg8AxQ0DVa3IhUk9oJ7BPUAolEUo2t+Ljm4pD/WwqBAkN/jEBKq4LO79BrN4G0BE4P6ClvWfSk4m0CGx/vvOHvQn3trnYKAdD/2V35Hr+5vYQ7YxjCmOyM6gmT8UOcT08JG21FWZK4i5Gsd2TPHyF6zULVrKWpfTDYGYJKIYn5OrSJN9e/MVrzqtxVtZy84Xbpzui9FJctml1TLqekw6zuWZj5ab6PK1nvnynF4GQLXjz4g1E1F/lUZphFC5tx9DOl4A0eIRM7hcgTQrcMwSLRDJKd701kNMJSoaROjWZ6ECSIqV1LM4et3uz6WLPqE4Yq8/8otqxJauMqG2Nb/kj7jdMt++MkXNgLs/FELqm0CLjKfZcrx+pjKVkSYltbOY0VYae0k6SMnZfIKkClXoJtKMeMq/18jllQaJdy1+w97DXHfNmv5OqUJ8JQIW52Vu2JGlA18pO9wlPtoVuur5qD6xrNBD3dL9IQu93BACmrYQxy4GvkCh+BI0rBTTLpS89SoU5Cf4JgqF8bklzI
x-ms-exchange-antispam-messagedata: EP1IneDCArR9wV7pbcyxRei6rlh49t4J1KO31NE6tEykzx0VE9cB/Lo8E9K6T4cMh9SUgfkVZ8LjNOby5Oo9hxBRU5F5xCXHUU86W0I56BWhLGYhkDX351Tt6N2o4h7giJTJceYgv5oTzhaLcruCzg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c49b3db-32e4-416e-1ab2-08d7a916f042
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 02:07:07.9844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNw+ZKJ3tCBKrISPKwjbRLblUhVrRYcUOzP71I9z3TieZLWJv5kmGcDytjIYnRAo
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
Sent: Wednesday, January 29, 2020 3:47 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/smu10: fix smu10_get_clock_by_type_with_latency

Only send non-0 clocks to DC for validation.  This mirrors what the windows driver does.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2Fissues%2F963&amp;data=02%7C01%7Cevan.quan%40amd.com%7C201c9325bf144200f84208d7a42ae179%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637158377025664935&amp;sdata=n61wTpS6nqQjPoeM4gDHg9fu79rQIBgtOir%2B%2FJzvj5E%3D&amp;reserved=0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 4e8ab139bb3b..273126cfc37d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -1026,12 +1026,15 @@ static int smu10_get_clock_by_type_with_latency(struct pp_hwmgr *hwmgr,
 
 	clocks->num_levels = 0;
 	for (i = 0; i < pclk_vol_table->count; i++) {
-		clocks->data[i].clocks_in_khz = pclk_vol_table->entries[i].clk * 10;
-		clocks->data[i].latency_in_us = latency_required ?
-						smu10_get_mem_latency(hwmgr,
-						pclk_vol_table->entries[i].clk) :
-						0;
-		clocks->num_levels++;
+		if (pclk_vol_table->entries[i].clk) {
+			clocks->data[clocks->num_levels].clocks_in_khz =
+				pclk_vol_table->entries[i].clk * 10;
+			clocks->data[clocks->num_levels].latency_in_us = latency_required ?
+				smu10_get_mem_latency(hwmgr,
+						      pclk_vol_table->entries[i].clk) :
+				0;
+			clocks->num_levels++;
+		}
 	}
 
 	return 0;
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C201c9325bf144200f84208d7a42ae179%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637158377025674893&amp;sdata=JpmMpRxri5d8oNC8YeMG2SVtJjBucL8H4gmrNDYpVi0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
