Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4193DC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 03:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0203F206EC
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 03:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gHVlSupS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0203F206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 859866EA7D;
	Wed, 11 Dec 2019 03:54:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 905196EA7D
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 03:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GED8InHd2wz5egM4p6f9+xgFKY69dwUCkIRAETngPqsTMK41YehDX/gM3v2FV1/j1FSTH11rJSLfsxdMo+/0JCpqELpss8HfoIyJmSbPYxxC5sUdaVKWSKL27OF2e+vFr2aDKbgx7OwBzdSX9wmCLYwJEy+F/OEumG4oCjlubXovXUPPtiHoXApv0SUdFaDDrWVdl6MxqipgCP4P/gjoOFrbXTv2JwSg5A5PcX6866UIZZvTdm/9BsZAFFxkOP9No0hjEqZSvm+FbJqqQHVGkdls/GCUk38p88V9kilqv/hTJqkLGXxZ5tgSNXfbXUVnPzxvKw3AydyTivwpsSQwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yv4G75ybwBa27rb2qHgIL5m1OEXbLJcEPeRY+aSco6U=;
 b=g56x/O53eeEeH6DKMvkqXmWAwyk8Q4diY0CaLXsJPvliKLgvs0pYgwNmo75ujdhWvP0UOSMozCa9P6/GdoM4rPR2zSTqNTyukb3wHIkWr0t8GfB8233+3WacqS32ID1M5myEY9n+hCujIphT0J78LA8MyVHDVCo66f+PTFCJ82CZgrdD9oLxlqFYUCsYWWBhmoLGtm1jqQVUeuNl65qQ8xVwNAM3l0KD7fS+tOJAU+VtsTf6qDCmpREaZulklr7ELz61xGLOYasbInqFPq6uoBfVoDX1hnM8i8rODsmhw/KmLHOWbB6OLzkjbQcABM/+2gjjWCCmzXmI//BS6zhm9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yv4G75ybwBa27rb2qHgIL5m1OEXbLJcEPeRY+aSco6U=;
 b=gHVlSupSCkhgUSKKEeKpTq7TNqpQOJPqF1zezEhFo6N0FCiMypFTfbFy3XdRsOm4TBt/v0O2GLsMeodck2TfSeMJZcTr1RS26LhTCTAS4VdKDmVK0INy4Nd5Vd/Aq6vI/SF4xHgCQ+bilKON5yFdh1/VhpXSIdIUZI/CGwsqkoM=
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3072.namprd12.prod.outlook.com (20.178.241.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Wed, 11 Dec 2019 03:54:35 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::58ae:be91:c063:b2a1]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::58ae:be91:c063:b2a1%6]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 03:54:35 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Tao, Yintian" <Yintian.Tao@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Recall: [PATCH] drm/amd/powerplay: enable pp one vf mode for vega10
Thread-Topic: [PATCH] drm/amd/powerplay: enable pp one vf mode for vega10
Thread-Index: AQHVr9azvo4vlPFmLkubkWNN4SNTzg==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Wed, 11 Dec 2019 03:54:34 +0000
Message-ID: <MN2PR12MB359875E47D5719FCF93284428E5A0@MN2PR12MB3598.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4b4b013-bf3c-4646-e558-08d77dedd65e
x-ms-traffictypediagnostic: MN2PR12MB3072:|MN2PR12MB3072:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3072F6A43856D2ECDC05135C8E5A0@MN2PR12MB3072.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(199004)(189003)(9686003)(71200400001)(81166006)(8936002)(8676002)(558084003)(478600001)(52536014)(7696005)(81156014)(2906002)(86362001)(4326008)(5660300002)(26005)(6636002)(186003)(316002)(6506007)(110136005)(33656002)(66556008)(66446008)(64756008)(66476007)(54906003)(55016002)(76116006)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3072;
 H:MN2PR12MB3598.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q+fc3O272VT6O/pVhn6oqwVY0dDLDuWJ7LrgrRyS6xbsGBzDJbenr6OFMjzOjsDVbZGHk685lbg0X1uR/gr5lR5Vir4oUPXjEXeUKDVX0MAm9RLh1x+Zl1EYEsl0Qm1MwqDKCiDlDVhO+BEwiHUZnTv36sxLTrL3UOgS6bfF9PPkuNDD1elkGQh41bPgKeLuPBreBdlfsCg3JODRf1KN+dM6ePx7fBuB9SjREv5wXgPx1R0zH2pyYgtxbA2uL5jT5dHuFcdj52rvIoYGnbm0wRTD4l3gAvzMisrgAPXZoAJh/zMQXhm6nPT0cJ6LfvXweXauvSFvov9u2TZADpZMIo98VoK/KLZ+fxObJrXQBxT9WuhlxgApABLqhmbt8sFYzimjO7AIwv6n6tw8VOn5GkZRlwoSHabarHXeTecu1vD0KN8vL+57ST47nzO2xkqR
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b4b013-bf3c-4646-e558-08d77dedd65e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 03:54:35.0430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8LLGffz5+h3oQv3ktNGxvzCkZdjFKT0T8znuUGSvakS637qTKsz7gM6B3WwHUNQn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3072
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
Cc: "Tao, Yintian" <Yintian.Tao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Feng, Kenneth would like to recall the message, "[PATCH] drm/amd/powerplay: enable pp one vf mode for vega10".
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
