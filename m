Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B49EC3F68F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 12:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42AD821556
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 12:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q2pAvH71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AD821556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEAA86EB1C;
	Wed, 11 Dec 2019 12:01:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770052.outbound.protection.outlook.com [40.107.77.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 765106EB1C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 12:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8Wg5xNa2kdIG9lbAz2vot4jwCbz2CtINO3wKFzUnec3KlIpSttCFYORSxum1iMGJRn5gPH7eZLU623YDLB0kQSor8bsZRtr1fJG1PqsGgk0KlAbSJv/xu7NITn1Wm+ZNpzND0LVcSaTqJEb/SjRtuGUMM8X4z35AEtoEOUCQuPxqUR/bCVJKAReCV2gCJkFLgUVHJM/bBxjH24f3oXgfAvYhsSvoQQGQPw5Fj3YXhJ+hAbggiRB2D3rQOHeZIe3yyxSTO8PB+HI8PF1ZyPvHm/T4JV32AT8TzmI5UhQ6Gpjtprj1xfU5LRBl85Uuq14A5cr6IbQRcc2FamHS/bDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPZ0yZ8ABAlVLsU+WmK+E7WpUEM0xgDvrLJbtoSdWOY=;
 b=PDvRu3KErKB87ynDm8LUSQmjHYLvk9eGCK9XjLLsmryRCNZFNjwLPaIQE0+6yuGDAey5min4X0PV1u1hfCbHWChy+n99bjUzK8IXZU6QDALRbKBxu4tyDO976QHoWdchLMm+OeFYBXb4u8cEgDNkAqrlQjtVVIFPAQcUgeXzbGHuAA0qUpg6eulohPyXYWIo6Vtiaaf+ZdJ6Hj0s4ZmA1IgU3GRqSnQR6IRTJWcgSnVssVKj0SgYVK2Tr2u8MSbX96A2X7dbo6Yx9X3gxl0JLArpxyRW8zFN4zRuADsIGlQYqqe5mx7z3SUvC3CI3iBsbRQRcc98oNcAGjRQB7Y+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPZ0yZ8ABAlVLsU+WmK+E7WpUEM0xgDvrLJbtoSdWOY=;
 b=Q2pAvH71X4SkOq9llP9/ozAgTANEa1YFVHHWJF/x1+eKs45imOaIl6TY5q0mhA4DmXMZFFkvVg2DMnpRqWWY2SWAyMjQjZACF6TWzJeELF77tz1jEaUbdBGlMR9H/bsbqYnjp8+F70leDDZih5IV0kX9UI9P4NMq4501YUeLfWE=
Received: from CH2PR12MB3767.namprd12.prod.outlook.com (52.132.244.213) by
 CH2PR12MB3717.namprd12.prod.outlook.com (52.132.244.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.18; Wed, 11 Dec 2019 12:01:52 +0000
Received: from CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::4881:e645:b5d:421]) by CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::4881:e645:b5d:421%5]) with mapi id 15.20.2538.012; Wed, 11 Dec 2019
 12:01:52 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/gfx10: update gfx golden settings for
 navi14
Thread-Topic: [PATCH 2/2] drm/amdgpu/gfx10: update gfx golden settings for
 navi14
Thread-Index: AQHVsBqBw3NK9yw8VE2HdnU6qAuP+ae01U4Q
Date: Wed, 11 Dec 2019 12:01:52 +0000
Message-ID: <CH2PR12MB37675186B6B47A0BA685C3D2FE5A0@CH2PR12MB3767.namprd12.prod.outlook.com>
References: <20191211115944.23206-1-tianci.yin@amd.com>
 <20191211115944.23206-2-tianci.yin@amd.com>
In-Reply-To: <20191211115944.23206-2-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Feifei.Xu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: faf11b52-b44b-4a2a-6b89-08d77e31e8dd
x-ms-traffictypediagnostic: CH2PR12MB3717:|CH2PR12MB3717:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB37174BD3E02EAC2ACE7CC079FE5A0@CH2PR12MB3717.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(13464003)(199004)(189003)(316002)(9686003)(186003)(81156014)(5660300002)(8676002)(6506007)(53546011)(15650500001)(33656002)(55016002)(66476007)(66556008)(2906002)(64756008)(7696005)(4326008)(66446008)(478600001)(66946007)(81166006)(54906003)(110136005)(52536014)(71200400001)(26005)(76116006)(86362001)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3717;
 H:CH2PR12MB3767.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9EFLG8xXpaXjx1H9kTHbHendchwvVVad7yu4T3C/202k4J+11edmwkojYe313K6vcH1FFKc4e6SMYy74dQ+gENhi0JsuMP5w3cuvlMMjXZjqWEC0EqPuIeDLONL6LEUHOeCamlTCZudSrACgH660NxsYgAtGC+5m39bxnJsdJo0hW4PTA0o3ASN44PsatFNVG5F1p67OL9dTq00X+vezEfXfNb95aGzl0HlmzJG5dkht0ymOFsoEVlJMxQUBXpRjs9UOlF+md14w9n7gKSxYfNH7hVxLOIeeo01CfHMWeH3vQ2fkBBNizhNYqp2iVbI3JaQW9gFRJ1nLjVT/N3+ckq5U5oN0vVdNigZvVteKkFbAcklP71whRGJ7aSZEg+I4sJOxoervOW+/o8qDz/ERfgI+02GF3v5I7e4s700Jf8oYq9zRqAhJgmZQMyO99lvt/OhgMOjxrtm4yFeX5Q5yO2TbRINFPfGuOQmb1TDrNExyYDz7MFvQMu3IfUafINsd
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf11b52-b44b-4a2a-6b89-08d77e31e8dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 12:01:52.0267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F3impFc5CknuFc4F1NYqXh/Almsp6+7jA7D5QpqoJPhKAGhIKV/SDukqKlwUQ0VO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Li, Pauline" <Pauline.Li@amd.com>, "Yuan,
 Xiaojie" <Xiaojie.Yuan@amd.com>, "Yin, Tianci \(Rico\)" <Tianci.Yin@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Series is Reviewed-by: Feifei Xu <Feifei Xu@amd.com>

-----Original Message-----
From: Tianci Yin <tianci.yin@amd.com> 
Sent: Wednesday, December 11, 2019 8:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; Long, Gang <Gang.Long@amd.com>; Li, Pauline <Pauline.Li@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx10: update gfx golden settings for navi14

From: "Tianci.Yin" <tianci.yin@amd.com>

add registers: mmPA_SC_BINNER_TIMEOUT_COUNTER and mmPA_SC_ENHANCE_2

Change-Id: I1fc3fb481b2d9edc482a32497242a8be6cd6b8d7
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e5637a6efb05..8cdef79de9d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -162,8 +162,10 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_1[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CGTT_SCLK_CTRL, 0xffff0fff, 0x10000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL2, 0xffffffff, 0x1402002f),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL3, 0xffffbfff, 0x00000188),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_TIMEOUT_COUNTER, 0xffffffff, 0x00000800),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE, 0x3fffffff, 0x08000009),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_1, 0x00400000, 0x04440000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0x00000800, 0x00000820),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_SPARE, 0xffffffff, 0xffff3101),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL, 0x001f0000, 0x00070105),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
