Return-Path: <SRS0=shUv=2Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD15FC2D0C8
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2019 02:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1366207FF
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2019 02:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VyIzjXaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1366207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 633E68992E;
	Thu, 26 Dec 2019 02:57:47 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690065.outbound.protection.outlook.com [40.107.69.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E15758992E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Dec 2019 02:57:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mD8LpxT8y9WHR2aVLQnA73mqhqJWMjzWazUHtj7lxTM4er8cp9YbneDhom6IKC2V8xAQD3zJapaqkDRwOH6HtCrdouw9aCYRW1JY4/wvDFKY01AoU7O8CJGDUCsW7UKMThts+c7uG/dMiwSW1G1z9tFz1RZG3V3NpQ30iZnBMrfNLj8v+6csy64Gg8mh3waukWbvHOJWjjpPYf6Sc+9lNx0n2NplkrEtXTCudfvBUtMB7X+YwSEUHS8FQ1z03shy2f2Lc+QEeoOy/UWC0YsvX/QrV2CcdboKsS+noTthXhxuFjWdYbTYhtE7kBCSy8XSVyNr/jk0g5CWfSFqgr4Fgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pBigjXMN+ImIHtROWCkgCPHE3QoTAQgIJ/C6ILXILo=;
 b=OcAYPO39jvxbLss56VBxc4fY+4mwB1kDN5dREyAj8perXuo7z5t+XO3VFbCCpNgDkscvLrtudmfTSXVLVO3iJs8fgTTaUTQZAPz0ASKjcO8ZJrdP/zVYAg/UqNxBpb4yBvpcLICuQdiJHRWjohsioe01BIH2Hp/LIVHfx5sv567t/bP84Kl/25WiNuYjolAYtQpns5jSEYHfYiXvO4QzPpXavT7ACih7EqWtJw0eQqtAXeIThnbJRq4TBZvp+Nk40md4ARQGkGswBKUnYfc61xalH6VoDKeSHX1bj0cu2PuhmCae4rZE3GCOIe/S8VOd+y9m1xiOEaJTGIEpQwhfpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pBigjXMN+ImIHtROWCkgCPHE3QoTAQgIJ/C6ILXILo=;
 b=VyIzjXaDpf9yfjDI3vr1h/wT4q22wVzFDt9tRzIzUpeDfAubrk2FWZhBsjarOPbYoGT+31k+Cpbj4apl7FR66Paj/cLrrGJHXL7ZQezjGDKnlIYYwmyEy/EIrGM6tceY4nHlLg6Nkhw4esT/C9FjwkXyQlVxpQEgNt9S1tfjufA=
Received: from CH2PR12MB3672.namprd12.prod.outlook.com (52.132.246.139) by
 CH2PR12MB3752.namprd12.prod.outlook.com (52.132.247.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Thu, 26 Dec 2019 02:57:45 +0000
Received: from CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::8dbe:e9a8:801e:9b9d]) by CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::8dbe:e9a8:801e:9b9d%7]) with mapi id 15.20.2559.017; Thu, 26 Dec 2019
 02:57:45 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Zhang, Jack
 (Jian)" <Jack.Zhang1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay free driver_pptable for smu reinit
Thread-Topic: [PATCH] drm/amd/powerplay free driver_pptable for smu reinit
Thread-Index: AQHVuhemLl+B7+75+0qe2ZQ2gTLpLqfIuyRwgAMBINA=
Date: Thu, 26 Dec 2019 02:57:45 +0000
Message-ID: <CH2PR12MB3672A9532F7B66EDF11E716BBB2B0@CH2PR12MB3672.namprd12.prod.outlook.com>
References: <20191224050436.14641-1-Jack.Zhang1@amd.com>
 <CH2PR12MB3672B764698E7096C75B1ABABB290@CH2PR12MB3672.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3672B764698E7096C75B1ABABB290@CH2PR12MB3672.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jack.Zhang1@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d77222ff-fed7-4cfa-fcd0-08d789af6259
x-ms-traffictypediagnostic: CH2PR12MB3752:|CH2PR12MB3752:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3752B7B209E0EE1A7DAF706DBB2B0@CH2PR12MB3752.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(13464003)(189003)(199004)(7696005)(316002)(86362001)(52536014)(110136005)(5660300002)(66946007)(2906002)(66476007)(64756008)(8676002)(76116006)(6506007)(53546011)(8936002)(26005)(66556008)(66446008)(55016002)(478600001)(81166006)(186003)(9686003)(81156014)(33656002)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3752;
 H:CH2PR12MB3672.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nrdIrT27kQI9uaK/BgjQ8IwTSZxAIo4L3WNYFbGU8znLeHu6D1K96EZJRcF0IsCG3oM7g99TjrecKw5ARe9dKQ9XIIGmwF1yP0n+OM8MvdCBxpKIfjoVo6VErqR36hs86Om5vfLtHxnqkLSwiRXDqRvq0VzHFrwBoedBM27iKZWV/KYqNBbr7x4LQnu7TvYZjV7o7mbwXAqkzJ7jUN91uC3kiCNr80Q5L14chrrJXV5WxOL+czGl+rlTi5q8HE6YGTgpm5GOEoTWwObSXOKHy+Iw5Fj6Q7I4iOmN9oZi/IgK8XoYwBDObl0v195TkKexHUjRduuLTdrJCsOUmLxHc58tqRuIYBEtRbcFyfoBlz2uF4pgZXSTb3Egj93RwPcOXAFf113wFIeYNtt1ny4zaM9xQHZzauhXYFmxjK/LCDfjWV5kHBHGFG+Uv46R9N6zzr1bq3+uDxLRfJR0UQr5NhpfJuhDPHPN8XBd9pbqQmdQV5LGapd6mdjBRpsbdpdn
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77222ff-fed7-4cfa-fcd0-08d789af6259
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 02:57:45.5652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yViXzQzezDXVJL/OFOsQbjGWHodqszjVx8uX9stSbWn6AbEUFK52wbUxeYOePFcT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3752
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping...

-----Original Message-----
From: Zhang, Jack (Jian) 
Sent: Tuesday, December 24, 2019 1:05 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Jack Zhang <Jack.Zhang1@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amd/powerplay free driver_pptable for smu reinit



-----Original Message-----
From: Jack Zhang <Jack.Zhang1@amd.com> 
Sent: Tuesday, December 24, 2019 1:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH] drm/amd/powerplay free driver_pptable for smu reinit

During gpu recover, smu hw reinit will fail becasue table_context->driver_pptable is not freed and set to NULL.

Free the driver_pptable pointer if it's not NULL.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 7781d24..ca877bd 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -713,8 +713,10 @@ int smu_v11_0_parse_pptable(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	struct smu_table *table = &table_context->tables[SMU_TABLE_PPTABLE];
 
-	if (table_context->driver_pptable)
-		return -EINVAL;
+	if (table_context->driver_pptable) {
+		kfree(table_context->driver_pptable);
+		table_context->driver_pptable = NULL;
+	}
 
 	table_context->driver_pptable = kzalloc(table->size, GFP_KERNEL);
 
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
