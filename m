Return-Path: <SRS0=dEFY=3I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C9EC33CB1
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jan 2020 15:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A982051A
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jan 2020 15:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kdhMcfI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A982051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF916E3F3;
	Sun, 19 Jan 2020 15:42:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D8546E3F3
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jan 2020 15:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7sqZj2VJ9HI1096XUty8FDQZm8zzgqU5XaaUUgCHE9i6XryXfwyFaTm3mSyynUJtmxKiB+PZDDUSK+3z2RYbzZt9DGBtbqvn270/RjIL7ikd/AHZ8mFs3Y5v9D7L55+IhLQQQQKTyocC4enpQnqxTVGPwM8Ozb1eyJEA6M50zAbNk49zjMevhRkixub7LgJBM/m4vwsBc9xScpUZOeLb2azfcJJL1B6igTqrWJCa2Rvg5LZGO5C2QveIj6NxCYDXbow/qwX7Z9LX555Ir0J6uVckVgmj79UifRKlfJCL9Dl1lzJ5rj7QTVbph7gmk5brO7x1BGoL92TwWN9eVlIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlptiEkzKzbK6s28YmnqVbUEeU4u5CUF7eyGIPvLOFE=;
 b=jR+YVIIddE7FLC/mz5ElmmBKpvSj4TS/z9n4nfFJ7LiwXvE0esKHskNBOtZbKHNaXtv6TQMbCGhp0XyPdZn0D+ABugZY51K35OMxx3Yqp9yJpgbpllaH+eUK/DphsZcSB4Od2/WCTG+H4zjMFYlQt2o9bpLRa49pJzsS4rzg0adfZ70PGyEaR95Ue90Adij37eADgAex4kBf852AuhiZprF27h8odCGdQrPMJMEuNKE1iZQlmOAmlUa0g9LQDEe+Ut4s/qe0WU1nOdOcw+KmSMWoCmia0J4L46FQF7am9knI1CJecuoaVBiuqhUdQUQCd90XoEemfR89JOVzdrgv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlptiEkzKzbK6s28YmnqVbUEeU4u5CUF7eyGIPvLOFE=;
 b=kdhMcfI+ReJC0svbzO0uuvXfJPeBo8LyJGBDrLLKi6EsSBn1QscL7y+mclB9gTBgZpETptzCeFW02iLwuBltngXkr0KZeeNliD6MJ4gpytIUN7cz52ldGB3qVAB+0pNEeMmFMpMuOyF5a/6rexeoDIlsEbcvLjWisggyjfw8F3k=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB2470.namprd12.prod.outlook.com (52.132.141.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Sun, 19 Jan 2020 15:41:59 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2644.024; Sun, 19 Jan 2020
 15:41:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>
Subject: RE: [PATCH 0/2] query edc counter for more mmhub sub-blocks of
 Acrturus 
Thread-Topic: [PATCH 0/2] query edc counter for more mmhub sub-blocks of
 Acrturus 
Thread-Index: AQHVznT5Jo9z9WF4P0qLhYtP9C3noKfyIO4g
Date: Sun, 19 Jan 2020 15:41:58 +0000
Message-ID: <DM5PR12MB14183FF4E4F628F676D29C44FC330@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20200119030252.23853-1-Dennis.Li@amd.com>
In-Reply-To: <20200119030252.23853-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-19T15:41:57Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3e2d0a89-9837-45bc-adcf-0000a9b28c30;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-19T15:41:57Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 353ef1d6-6263-451a-9c97-0000f22aa7fc
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6113ca7-49dd-4e33-e8f9-08d79cf61eda
x-ms-traffictypediagnostic: DM5PR12MB2470:|DM5PR12MB2470:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2470377B1D32C7090A886306FC330@DM5PR12MB2470.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0287BBA78D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(189003)(199004)(55016002)(66446008)(64756008)(66556008)(66476007)(33656002)(2906002)(186003)(76116006)(4743002)(9686003)(478600001)(26005)(66946007)(8936002)(4326008)(6636002)(81166006)(4744005)(81156014)(53546011)(6506007)(7696005)(5660300002)(86362001)(316002)(8676002)(110136005)(52536014)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2470;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cvy1vjE0npNLKlIinmTipHCoL/QTdJiOBFBbP/2OQlgv0sbr0SjN1oaRInc+gY9LRKno3uXJWMZPwMy7E84OR0/t+5IKKbqoP5EONYcdkTc0OoPSL2t+B+bkt1gl7U3kkAHkYFdpb/Uv7mhzOGrmnXjoty2moO6RuOHk0GuM7rIUjIO6I2SgeQJ1mj2A696CBxJWHhIKXmR+ERjx8lj5sXomeRZl2t8YJ14ny9tubCi71JXZPGfccaqw8AVw+sr5TA2Lk6bNErOtkXzFybsdYuZFwK7sMBz9mLbhLt0GmSVwp2JVBinXgt39/3TZMAQOKVC5XhDW3SmaxDx5D8qwmAl4YczpL4an+oqa2Z2lcgpGb4DjjEfS79vR3S2hD28cZZPJJYNXcOULOonbSjygYss3JhRS16qffaC0o1JAWS1kItvWPir60sCC5CHCNEBy
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6113ca7-49dd-4e33-e8f9-08d79cf61eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2020 15:41:58.8445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TwEHZe0r3PZFuNR/dvEIw/7wUZUnAHf9oP883AVyu5fzuIRMTSS3b2kqfG3kO57+ANYbNoJU0fwKmxeuRh3AjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2470
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Sunday, January 19, 2020 11:03
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH 0/2] query edc counter for more mmhub sub-blocks of Acrturus 

1. Add RAS support for MAM D(0~3)_MEM in mmhub.
2. Add RAS support for other mmhub ranges from 2 to 7.

Dennis Li (2):
  drm/amdgpu: update mmhub 9.4.1 header files for Acrturus
  drm/amdgpu: enable RAS feature for more mmhub sub-blocks of Acrturus

 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c       | 701 +++++++++++++++++-
 .../asic_reg/mmhub/mmhub_9_4_1_sh_mask.h      | 128 ++++
 2 files changed, 823 insertions(+), 6 deletions(-)

-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
