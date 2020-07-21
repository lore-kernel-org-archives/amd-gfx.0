Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CD5C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 05:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17CB8207DD
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 05:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Xwq8OFz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CB8207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C66D98800B;
	Tue, 21 Jul 2020 05:33:18 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690074.outbound.protection.outlook.com [40.107.69.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0A36894EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 05:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnPAXpy+4UKxSYDDZO4EpQDjSwcdevY42AJxmnJi/DlRn0fKeiQlNlOl2AOw10UmjPb/B4xKCmToz/jlIf5QAdXLXYZiQh0gzw88tlsq1NgD0yhbUg+wXAtMic4mFHPBDX2qMdjpFvxEEd+Gb7Nb+m0KxIMMf+2imRLiqwqD6/glK+PjeBcXLGfG+5MSLLDrRvAelHlbXt5nqId/1Eo5Bhe9Air2RqlTea21yMCBBjGpvgvtAyIZ9ERnb/sWj6qhhKAJsPqiELX5kjo3tzDUmfXPOyVN1cG3GtUsuVm4n6tms6FRrlnFhdTq3kX63vjOqGAYZQwubD4A0Jfmk2J/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIThmZjk/+RqKsMn/mCHkZkrYiuBeERT24HAwoYboSg=;
 b=bZAc1+Tkn+bAW+fT6BdoY9b15HJUjM+5Y0vfnwrYiIlTDnDEicyO3aGJyRKTUVALKoC1E3j4Ak9XpqtjXYv2Mwau6Py78mOlurd2+69OQN3jNYurm9NL0s3DN+3Kie2xpdCDhMs7KNsqLtabfzpbtFhV3DsY/HkxUKZrHu+KyN6zHj58ssgW3L1Z72QtWeFIlVwS3ymKJFLR5AHlLh3QT8wkD5TwuhoPtmzwulkK/37KjCpMBoid+b9xE7D7bKGckOqq/EC8AkWqYIdTerMyBaWsVH+c8qXXnj7XiP7p2zZeYjXeNj6Ql4Z5ADdjb1Le4ZI5GRc36hh/tvzmykW3aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIThmZjk/+RqKsMn/mCHkZkrYiuBeERT24HAwoYboSg=;
 b=Xwq8OFz9WnvyGB1cWtcmo0GUVgvIPRkA2jMbQdSpj3dXlVOJ5bwYvHyN8aJ+VuifkWiyJAFGdIHqmTOS8Fg7z+eJD2P1UFV5NeCgJKzwmDD8t28/NmFzOg5s3ZXW5I6JChe08fqVCwEXxUFGsjJFh32Kk7Ec1GxCyp/l7VLDfRc=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 21 Jul
 2020 05:33:16 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::f8df:794c:7431:2440]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::f8df:794c:7431:2440%7]) with mapi id 15.20.3174.030; Tue, 21 Jul 2020
 05:33:16 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: fix typos for clk map
Thread-Topic: [PATCH] drm/amd/powerplay: fix typos for clk map
Thread-Index: AQHWXxhoA6DE1btP8kydZBMyny8LVqkRgk4A
Date: Tue, 21 Jul 2020 05:33:16 +0000
Message-ID: <BYAPR12MB288847576331C1D8117D0F9FB0780@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200721043533.2227-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200721043533.2227-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0144efdb-29a1-4dd1-a3f3-00001632eb02;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-21T05:31:57Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21534ca0-d635-4bbf-e581-08d82d3791cf
x-ms-traffictypediagnostic: BYAPR12MB3109:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3109026CFAEE065633B0F683B0780@BYAPR12MB3109.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pUm5GqRSqLviwu54XfBAwOJmMNuWFBPLHoof/m7d/sovXeu/AkMbSREFHV7vX70LrU5mNCITpjo/CmzU6l4LOC6z74uzt04Vhgnxnh8empPDKHOYWlsoqdFcBoXsDKtHzopCUl63t3nK8ZmLJ5J10+fSUPf/w2aARyPw8YM//K0VZHh4jHYviTP+iRHX7LfgA7eM1JIFjracOZ2ajaK15ZqTHxhqa+Bs7GGNsNX3PkWzU8S31jckG14l20Byx3gVUSDwrsg2HyubVZUTLA8BFLGxlscYmS/9hkUqEf+8cuuSMblXw4fao5i/ktJ1jSrVH2AW2xBsdIewotdtEAovmA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(53546011)(6506007)(71200400001)(26005)(316002)(110136005)(55016002)(7696005)(2906002)(8676002)(83380400001)(4326008)(33656002)(186003)(52536014)(478600001)(76116006)(66476007)(66556008)(66946007)(66446008)(64756008)(9686003)(8936002)(86362001)(5660300002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 3zbMw6Yzqsg9GzBBACLrTCg9tnehFgBJUh6yNuYMRh8mel9zIkp6SQZ3oIfcJE/3e0aqKuk2cCKQ33h1nJ7CV7pFeBPKkjTwn0fp2qQ5lMY8tCwrP/IgM43W91EHu68ixSRWBc4pAK4MXaXM8eX9z3jqfOqI+P72NXSy4C/7byXVNJ9TZBUggvfKyCJiGZvUIGLSJ7sI5PKnrhYTA18onC1UJ45QkDcWxC2NvKnsLoezilYuvq8w7fE91TI+o5uUV3U+6TCPAiPX4r4RPNiaWXsFLpPOy6dJNufgZUc/VFV64TzoWSsSygwWRpM0Ekjv/g8K2QDZ/jX/bZ0niR6N6Tii7V6qA3xLC4Vtvfn24t/KexGFZL+P1aGC/gPhX0wgns2KThrxlLuoYJ6+EWk1tk9oOVJWzQZDMbbok2UycTj09lnYbmCUhpl7kKhuUoAG8qx0aGmSsNCN19JxQZ/OqmhlzAI24DxaEwUUgzuupg/7yRC1GLdJFPieKyNe1CJu
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21534ca0-d635-4bbf-e581-08d82d3791cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 05:33:16.3788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PIgvrNKWoONywO29myyGzuNshwa0/EUmb6dEbQ+1W4mblR5uVnNXmYfnjLbgozrQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3109
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Tao Zhou <tao.zhou1@amd.com>


-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com>
Sent: Tuesday, July 21, 2020 12:36 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Gao, Likun <Likun.Gao@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amd/powerplay: fix typos for clk map

It should be DCLK1->PPCLK_DCLK_1 and VCLK->PPCLK_VCLK_0.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: Ib2239b35840d3774a0e1aa3114d2f965e6d88e7c
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index cae8e776fafe..87eedd7c28ec 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -128,8 +128,8 @@ static struct cmn2asic_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
 CLK_MAP(UCLK,PPCLK_UCLK),
 CLK_MAP(MCLK,PPCLK_UCLK),
 CLK_MAP(DCLK,PPCLK_DCLK_0),
-CLK_MAP(DCLK1,PPCLK_DCLK_0),
-CLK_MAP(VCLK,PPCLK_VCLK_1),
+CLK_MAP(DCLK1,PPCLK_DCLK_1),
+CLK_MAP(VCLK,PPCLK_VCLK_0),
 CLK_MAP(VCLK1,PPCLK_VCLK_1),
 CLK_MAP(DCEFCLK,PPCLK_DCEFCLK),
 CLK_MAP(DISPCLK,PPCLK_DISPCLK),
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
