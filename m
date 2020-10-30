Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061F4C4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 12:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D86F206FA
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 12:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="erOCqF+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D86F206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87ECC6E9A3;
	Fri, 30 Oct 2020 12:58:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 003506E9A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 12:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZWKfWuiduP+RYNaGNdf0oW4irKxMS17erGAmDyUu+nfE9wcBmGHakVE73DCcKrp1Fzh8qMybfTAxT4nvbt7ZMRJVocSY0B23jxPN9ONuoAPao7WNgroZS+DR6JMOeQ/kHNK95qPJyIA+0BBeny9pfZ76Mrl1C6kIU4EYFyKxeuZxBN1oZWtG4PynPlwpjlmuGw+WWiv1NanReXZraTISa8AOuFDWV+prlSFndrBzs90762vmj7/nmObFrjAPeQ4cPU4EmZOF4YClJV3mKGlMjeE65PHdwHPHqqQgpC+lUquhEmadHHlHvKCmAzqwByQ9kgUtBbQyKHbdxtTFRQmqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKehQpug2LxREkXQ1CUBiV8CLbAippotcFU6mQhHDFA=;
 b=J9o1h9eIsMlO5VN+VxleMIjRqZ94A7DE+XDEOLWMVvUCiRcVTMrj3BhoIQ7G3m/7rDg/r2yCJBYuZP3f60Nfh1UcAzGw464asn9utlUcHtBfyDBWr8YQpIO+FLqqBWzsLwoU2U50Ai+h+AjsoiuQsJmW7wN4S6MOhwPcuMT59DfoLexzgWz7foBl/RNdUjvyob4wtvCDyFydD9WQl0OAva3SGUcbrsU50xgCeaaewwWqzPc60CqwuIQrlrWxMjRiN5K9FZR8Mr21aD9Cc9ffZIPsHNdA7S3cmmFfL0boF0exq5D8YvX98dhxdshPvGCsxspePA8rzPQXXJBvkZAL4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKehQpug2LxREkXQ1CUBiV8CLbAippotcFU6mQhHDFA=;
 b=erOCqF+8RuSyn5OGBzUjS0PapSsHYh/FRq21NrzMAuAIye5iIR51vEZMIHhb57eHd23JsIbL/E/na//RPXOqzKGfxxhYC22ND4flomk1paFKIornMQV1P6tqqdRa1Jzu2hJjcxLrfLT3Nw+VbIQl/yEqHfuJRzwGYqaSdAn8v0U=
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1519.namprd12.prod.outlook.com (2603:10b6:301:d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 30 Oct
 2020 12:58:52 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624%11]) with mapi id 15.20.3499.027; Fri, 30 Oct
 2020 12:58:51 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu: Add mmhub MGCG and MGLS for vangogh
Thread-Topic: [PATCH] amdgpu: Add mmhub MGCG and MGLS for vangogh
Thread-Index: AQHWrom1ZpUkyydiekagnVf6KOQu6qmwG6ow
Date: Fri, 30 Oct 2020 12:58:51 +0000
Message-ID: <MWHPR12MB12482F8BC13447D59739FF66EC150@MWHPR12MB1248.namprd12.prod.outlook.com>
References: <20201030065456.23396-1-Jinzhou.Su@amd.com>
In-Reply-To: <20201030065456.23396-1-Jinzhou.Su@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [101.93.226.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69a23c28-a6c8-4ed9-2a08-08d87cd38d12
x-ms-traffictypediagnostic: MWHPR12MB1519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB151967555B9EA864C1D3F556EC150@MWHPR12MB1519.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: equyrvnO1diSwi4jKqVDUir8pBnVvAqhCco2Z60uWuO0DIZA/QiR8xtPgCoVnsw3O9OQ18XYCQakN2Xgn1rXVWlrQTHVvyAXGWHaZoaF8vyRrmmn4JhcHOy71kyiDLO6B0eQCkD/ZWXyytNNI5g9F7NwFEJdRftDltC4R1TctljRjIqOrezOsT2n55jocutN7DHmot7xopb/tiWslFJ+i8wkQedI4P0P5cGVrQ6E2OtIIYDhedubL9QLdSmX7nwDAOAriHr0YDhMUJz2QAdeMuEQTHVdqoSbL1aQn0EsllPKEUhNgSvArhOeG7j6spQQLGAv0GVdSEmwNIjgi2Nl2g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(5660300002)(52536014)(26005)(4744005)(55016002)(9686003)(8936002)(8676002)(6506007)(53546011)(86362001)(71200400001)(7696005)(186003)(83380400001)(66946007)(66476007)(66556008)(76116006)(66446008)(64756008)(2906002)(33656002)(110136005)(478600001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: sF/yipKZg2Y4W8CiptG3AXXjRaBWuiSXknIhMxmJeqRpHnTEK4FotMJm1cCyPKt97bOsvLcVevrg08+Vv+aza+cEID3syqJ3Lm6lGqcTn1n630NeVM6J9olCXTysaVlwcR+pQcvcpEIQpS0VOmwPgCf+nJRLv4Bst6CLE7wZyzcLz/4p4D/Y17ubrFQQ0RYuxheg1sFc1Iwz6ru5st4EuYRxw/18zKllpaPBARSCv0nQuMwrIOYBgVHIVTrds4kKl9NdQlOQGS32XJ7hFOwk3Va013ImtXwuMoKbz2xzrBbRNYDT53WybRzL41Qlb0ogCemNuHs/vPnXjdHdJw6cjvf1eEQAJZCanwiC7cAR8LUaRm/IhpJIWXc1Gm2ptXu0xJw1+4ovBjLLiL/gDfnd4HW9Ec08SCvXhL7G3xjYD6/J+cpG3I7khNkXE3PYHoBA0340qkE8fdg22NbF/9Dn2g6Cjm7Xg2vLvJnYs02p2anzGs/V7iHHM4si1zSOv5mTwd70Dp2ZI0cPKUXEPrx8aWk8xvEUIE3VZggcIf3+y4mLCvne0P1QiWtMBzNIft7v1O1+yYYn683RGlCyVbZTXlRhIGBP0xhzw3IQt9qBqPsBST478/IkG4nNi5XxEblK34N2Er1MRrlAoe5SVZsFhw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a23c28-a6c8-4ed9-2a08-08d87cd38d12
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 12:58:51.8497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2UkbCsR0O608upA5fpdjrFGr57ouYUTCQSgN9nGEL0jpJj29XefNA6bqJlx+NjDpNkqMegv0A9X7D54a9eMHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1519
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

Reviewed-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: Su, Jinzhou (Joe) <Jinzhou.Su@amd.com> 
Sent: Friday, October 30, 2020 2:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>
Subject: [PATCH] amdgpu: Add mmhub MGCG and MGLS for vangogh

Add AMD_CG_SUPPORT_MC_MGCG and AMD_CG_SUPPORT_MC_LS

Change-Id: If58cc127a5b5b2449253af6d0f7f2522628639a3
Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 026e0a8fd526..1f8659a1a4cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -951,6 +951,8 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_GFX_3D_CGCG |
 			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
