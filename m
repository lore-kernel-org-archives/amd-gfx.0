Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146C1C2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 04:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8765D22228
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 04:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EA2rGp1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8765D22228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C30BC6E89C;
	Fri, 27 Nov 2020 04:36:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B4C46E89C
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 04:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGIP1iE1HzKS7ARGZ7oQoeBUe0srbZ0kIcwCHbf/ozQwnlgZFOxIrNX16GQMWobfV0YnUpCxD30Ph1cgJMU69rVN0srWHuhZ2o5diEQkyHhCeI3VEB2AUA9zsNRiy8Xv6j0kHqT0rqCidyPaB2HAAUCZzR/vVAjJgntLHiNuPbAeReMFpVsyIBBkEgkF3/Mq/licejuBqDvTlEjvZEc5YiGcQ5jDjZG5TjMjFLnxEGihAx6tQJG7Wx9vCY2LLzuIV2T3WYiSZZqn4QNpk+VbOX7wYjqZbwgEBnOP9CXwUauFZqebLknaKA9ZoXeLCiw2U1xvD+hvF9Od0RotlhyVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHD0BA+Jm40dvylTNHzjZ5d2z/X4tg24TQwoOnwW58E=;
 b=aThsHZohlLIFdntHceJPGG7rtc9ntfMNVutRk5Y5cIprOUO60pniOF4g+CW8gbwSim3cWXE5vdgZ1BudMUk0wvRHqTHL9x5nmf3lGyye2vlmK/B12v4kVonbjzd8ns+dr8X0cPHfAZEnJgmYXeR444Qz9HyMRnSZ0H4j057o17Gf0xdcklPtxitdiChvsE+KJ7Dwyg/UxSUGJdDFrK5HdpMFiA1hse7WL8EC2trTRSqf9AJ6dzp4fA/r9QX20m4+ApKkRRrKOZNDxEqQyMCIr1Njy2xqPvcEf92e+ne+vk3bLrCATgCOdGP2pXxrkSykOctX602G3u2NxZaEgZuhKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHD0BA+Jm40dvylTNHzjZ5d2z/X4tg24TQwoOnwW58E=;
 b=EA2rGp1oH3VdpfuhcLV4hqt8Y86wJY8nShisQSQGfQ7DITIAuGnraEVWyk5V2rBn1ggI6ZeX+b89BiDgZ4KBLVoe4ws7kCjmBOfcyA4QQ47brDzZIFTkdXE43eibwVs+BddPjD9KyiY20plSGJFHIbvTk+mcKJXK+h05ELuDULM=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.24; Fri, 27 Nov
 2020 04:36:26 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a%8]) with mapi id 15.20.3589.030; Fri, 27 Nov 2020
 04:36:26 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update GC golden setting for dimgrey_cavefish
Thread-Topic: [PATCH] drm/amdgpu: update GC golden setting for dimgrey_cavefish
Thread-Index: AQHWxHXrTD93Mt4qp0SBwX0j0tocianbZLBw
Date: Fri, 27 Nov 2020 04:36:25 +0000
Message-ID: <BY5PR12MB4885150BE601F414E4518ACAEAF80@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20201127042805.765-1-tao.zhou1@amd.com>
In-Reply-To: <20201127042805.765-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=745c1802-1037-4d3a-b931-7d5f93429fe3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-27T04:36:00Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5954f89d-e645-4e2e-2c31-08d8928e004f
x-ms-traffictypediagnostic: BY5PR12MB4888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4888BB44F3F8F18BE5F988F2EAF80@BY5PR12MB4888.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L9MyP2ENi9w+NUHT696YAhJCVLebToeDgun5wF3YxSS9yyBQoCaaitbGovCp9Eunpas9FuahSxi/hEAv979w5s66XE212Tc6IOXfF4xXtUHPlIRPpXpjm2MiAqpOsNY28sAiusOW5cEocO2zOQU/frJ3rTJaR+gmKnn9cb1sAqlgtHtCXvvTUELojfdPMtwv9gLZPk+piuboWJgtezubmfcv6rpTZwXr21WoQ4eN7GWpGr6Cn8IIYQ2r/0Cq4WJ0fgZ5TOkPPkuzCB5UxOGv5SJJLWsOun1CmFkb5yjJi6lVItLaYmTmj9AblzVyRWw71Bc94z8xNgBE1y3HgwGLnw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(66946007)(66556008)(64756008)(76116006)(52536014)(66476007)(66446008)(5660300002)(7696005)(71200400001)(6506007)(186003)(53546011)(26005)(83380400001)(33656002)(86362001)(110136005)(316002)(478600001)(55016002)(15650500001)(9686003)(2906002)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UsPmqBy5RPJqoEuRt8GulzjBKVSmwJXW6zrE/NSbr53iUThgH98e60Q8hBv7?=
 =?us-ascii?Q?CYMfBNAegADK5DgapWHrBtws2B7rhnuf80Jrmlg7oaOJaJXxboNXH8OBsrh8?=
 =?us-ascii?Q?/n60dNabiSFAR8r/mOidQJQEDK4tKQoWZFSGQkWbJW4+e62MRy7pjfmhPbQB?=
 =?us-ascii?Q?AuDuHJqBJy2IJH0dNl/SKPU05T1ZtuuV2qABjvhm4GPiFglYDmhcWe9peW+R?=
 =?us-ascii?Q?uyoYiNyGHShKvRx/V2Y/DHvvtA1kun4G0/st3yxvizwh/U3QznHRLmbzYklI?=
 =?us-ascii?Q?vCUqC+0xrbcH3SeM0+N8mxYq7xhyL1XMyjmX57VuldCdn7OzpyBbvxBDIzMy?=
 =?us-ascii?Q?VijGviG366KLdwWU1xjh+vICXoiZ6kCu+mVF0yG3FegwUNWlezkheSMDblhV?=
 =?us-ascii?Q?XcKaw/PFeLNdVTyr9/u4uwNGjy7PcCZtNygUA9O16F86LUjXpIzjrtFYQbph?=
 =?us-ascii?Q?1nEjJPkTD5MeGPar+tdGXIJNleu3NDJ1Zf9V0GJ/0iX9lAyG0XBknhL287RO?=
 =?us-ascii?Q?wxwCP755SgZZo3OmivcBNiWYP0Ci54Ssc4cXkecRGfGTgTCjVXnonPkn46wD?=
 =?us-ascii?Q?KAdmOky7t3mIbVyCHYishAv2YI8o1AkU/q75+7KhHHCSz5vyBdGJQ3TpWeyk?=
 =?us-ascii?Q?qC0r0aLoPaS+3ETUtfc1Es2OjvV+6acZDrP3k7CYIJEBFyMv0AmtC/GfIm1I?=
 =?us-ascii?Q?GDtBVJseDVdt9JuvapA8bMr1b8SKc3CInfE0ACSOZCPlPrIq8ANGvaQcl2Uc?=
 =?us-ascii?Q?ibIxDR0HHQU/ZmYmGT4sePsl9O4KB5+3W7l2ceCvsr1lZ1ApkA8ZiwTyaRiu?=
 =?us-ascii?Q?icHF1yHTjX+X83CXiRJ0GOgRGdQ7yTgjNreBY9n92OV0kElG2likE9l87JMT?=
 =?us-ascii?Q?ehf0aIK+AM3tkY5wGiuuPc/O2/9TYddrx1ZQrZ6Mq7LI1pzpBGZObLgeyCs1?=
 =?us-ascii?Q?JFpJVMKfQ5N8g+EuAi/5Bjj+A7Z7OfV5BBn/KMmZf7g=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5954f89d-e645-4e2e-2c31-08d8928e004f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2020 04:36:26.0000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 464BdU5GySZrlqrJhhJ0RVeofbrn8VJ3nP2crr6zgXRmxY4DibYJm6OSXcXDvgSECQB9I+MATi/aeDQQx6+HFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Friday, November 27, 2020 12:28 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: update GC golden setting for dimgrey_cavefish

Update GC golden setting for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 841d39eb62d9..ffbda6680a68 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3266,6 +3266,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_vangogh[] =

 static const struct soc15_reg_golden golden_settings_gc_10_3_4[] =  {
+SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CS_CLK_CTRL, 0x78000000,
+0x78000100),
 SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA0_CLK_CTRL, 0x30000000, 0x30000100),
 SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA1_CLK_CTRL, 0x7e000000, 0x7e000100),
 SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c000),
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
