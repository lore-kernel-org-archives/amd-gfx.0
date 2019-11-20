Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3AEC432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 09:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E85D21D7A
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 09:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E85D21D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E27CA6E117;
	Wed, 20 Nov 2019 09:49:55 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790045.outbound.protection.outlook.com [40.107.79.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D17D56E117
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 09:49:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQtATxAGqOi1xqetTcZVS8z3b8Ah/Z94G1uI/lgm105LNfLi/551oRfL/MVKExFtYIPloc4GVlLtNCGy2jHp4XkrR0dzh/XwdyQvCpKHwrNv+ugXcw1smJZaLhDIWpL+rsQdJUzHiaLlGBHxDItJWRc1fohn5CL2w8HYeDloKZRgsvZZKDqHaHrCR19xFN88O0YhuykOatlYSHrrDPaIqt27F4jX9qKTIavFqK+5SYZrSc99TI6U6ehOk710R9qdn2RXKC9n36xIWUVO0SsXRTdsBaJm9ifmhlrbEpwfxzxzxak+5qR6P1DuxrZeXd+d3K8FjYDWN7b9pEdfSluzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLwnMiXOYZjJrrFmqdSFkCkG4ar5RtXHXs38rsZfa/8=;
 b=bfW+BQ/n0MwOhVmzzzSiivaApEJ0vLGSGe8xMrgrd6EGUmmk97tdfdkkL+ttTO7qohD7ISNa6J/J1JH55Twof1mPRdUr39IQzAZk5AjkC0bb03E3j26xGqekMXSE7yvD+hVAa24o5aaM+la4JVsJpodBy0ZosPjoJqzxKkV476RtHmNhJ1sRc22dyClhWrU823C3I/HHjZVP4dCx4wxMM43fokscX2iwIsqbIAckkUSKd67u0FhWBqlB8Lk58viLRN7NapYRZAxcO1EqJunEjJIViRqIoZCDBo58iGAM6r6SZGkZqlf726T+HkmPies0kM2aKVjvcdakBvSxFcSthQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (20.179.80.214) by
 MN2PR12MB3326.namprd12.prod.outlook.com (20.178.242.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 09:49:51 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580%6]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 09:49:51 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Xiao, Jack"
 <Jack.Xiao@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>, "Huang, Shimmer" <Xinmei.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Recall: [PATCH 2/2] drm/amdgpu: invalidate mmhub semphore workaround
 in gmc9/gmc10
Thread-Topic: [PATCH 2/2] drm/amdgpu: invalidate mmhub semphore workaround in
 gmc9/gmc10
Thread-Index: AQHVn4fabGXHkdwZuEW+nnqUfBi/Bw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date: Wed, 20 Nov 2019 09:49:51 +0000
Message-ID:
 <MN2PR12MB2896BA3868102F7D05E934EFFD4F0@MN2PR12MB2896.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2efceebd-ec29-4139-5a52-08d76d9efd29
x-ms-traffictypediagnostic: MN2PR12MB3326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3326B70E84159E85E78F5813FD4F0@MN2PR12MB3326.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(25786009)(55016002)(52536014)(76116006)(476003)(64756008)(66476007)(9686003)(66446008)(81166006)(81156014)(66556008)(66946007)(5660300002)(86362001)(2501003)(186003)(7736002)(26005)(14454004)(305945005)(6506007)(102836004)(71190400001)(8676002)(4326008)(7696005)(6116002)(478600001)(558084003)(8936002)(256004)(71200400001)(99286004)(110136005)(66066001)(2906002)(74316002)(6436002)(316002)(486006)(33656002)(3846002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3326;
 H:MN2PR12MB2896.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8IEPPAOZfS1oMkegbWXFIW4PldFmUEVbe31cVY3oaqZ9fEA4zmj7KLw6iNseb13jXdx9KlsW9WQvIykAgnxm0H5wZpTbrNXWbe5r9tCq34dqc3Vl2AxOZAc5TVrfd9WWpwtlN8e6Lti3U1+tp8uljkhTBPiBFuf4cBoeeD7o/Q+9ARp+4XkXfzaQ2a+ValrQqbE8IM5DojPzFzCJyXXhV2dfAKZ0HI/IL80klKzic4oKxsVhbxOtMiFr6ebyKrrZgr3STjgsypOQ9681STpl0OLhEGvX4PmuhRbJdPoe2TvM8rgedBW4ONl1ofXW7rXEBTD7ycgTMgeKmlEfHJ4K3rNN+LivVwYv72s62rq6rOGLKzRi6wrm6FV7rpQBI+SiGMWtTEMGyHInwUjYezbxhUA6OR6AgEwR9SrGfZ0zoF+JJ575twcAOTq6p/ialcRd
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efceebd-ec29-4139-5a52-08d76d9efd29
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 09:49:51.4841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dt1s5PT0LxbjsTuHf00AwAVeafiCovJtR5MyMZOuYUQBMg7iZNLEalotwrvzjC9FgNPS2ECu0Gw4eBi1IaWaCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3326
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLwnMiXOYZjJrrFmqdSFkCkG4ar5RtXHXs38rsZfa/8=;
 b=naB6wwk/z+HWt4MJdsClOaMML2ZiRxRcpWTPrWOeMWTsPpJ37+XiPklJaB5CkKeC3Z3CfxZ63OkvTFeY5eGnRhkysnddPZY2E82D/Iw1Pvg39Ek9PyWid2QivRN1Z8wgVFaWQRPczI6QONNEOTvKk5EYdVLyHzXhU1AhD402pVw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Changfeng.Zhu@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120094951.YpR9skf8Nx6sttvWDomXQMbq5OtHlpIJB3EDZydphc0@z>

Wmh1LCBDaGFuZ2Zlbmcgd291bGQgbGlrZSB0byByZWNhbGwgdGhlIG1lc3NhZ2UsICJbUEFUQ0gg
Mi8yXSBkcm0vYW1kZ3B1OiBpbnZhbGlkYXRlIG1taHViIHNlbXBob3JlIHdvcmthcm91bmQgaW4g
Z21jOS9nbWMxMCIuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
