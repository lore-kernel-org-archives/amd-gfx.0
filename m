Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B28C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 07:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6D2222C5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 07:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6D2222C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 742BB6E172;
	Mon, 11 Nov 2019 07:00:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770051.outbound.protection.outlook.com [40.107.77.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B79E56E172
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 07:00:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHyX23/xk66I51OrWtZm7IE/FdUFlUGTXV7QT9NZKOnG/ut7VmByqe5Kgj2lz97oTscj3ESYNtsjucrtTwhb2lX4333ra7NYDzYiEy44Ti49ZagGVjoLBoYGAbl+ZbbHZgDoCjyUAJeGAvoYUOmEhT+xvYbWWojj5eDqKA7ewxB7lEsXe3MXtY0djfjxAFcyrYWyclhxLwapO6mIyLXTycAoT0AjqXHQE5zX0m1ieACWzXyX7r51cGhlLXVDNeolDhDpuz2C4RwHVzyUwSV8+uCCT+L1kFG0i59LC/BRE11dGHTvrgbbkgIcUDjU+4WDGJ7mJY/V8xRLYnYnDdWBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMplgNwCaxyB+J9yXwbpCfKRGYuoxhs4I/l/QRtwVlY=;
 b=WSvxUXK9HAM0SwbMFH5cFfe8Zh53TnZcvvEz2t3I5dG3dl4hZNvuUa0ZygqWDG+MsdP0BiqSZxkmom3RXWJf6d784+Ua9fWWTvWZHtr8yRDGGRnhhqKkWFqCqLz85l5Tdsqb/ly3TB+PKmHEmvuZi4BzMaDgVn3ockYdfFwoKawR0ZRl6CrBTxxTG0XtfuVGtT4cI4z40RFaCZr9s5KnyMi7ieUBqsQetkPokWOOR/mfcHkGkn6gcMwqn9cj/D688L5Lrlidw2ZbQC828IagUG8MmQEsR7Rh/eBtjWyhuXRbVTn6e13ABzXvSILFSh3XgYjSSZG9WcKydSrwSLQFVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3583.namprd12.prod.outlook.com (20.178.241.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Mon, 11 Nov 2019 07:00:26 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::111:5294:f151:3846]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::111:5294:f151:3846%7]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 07:00:26 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Recall: [PATCH v2] drm/amd/powerplay: dynamically disable ds and ulv
 for compute
Thread-Topic: [PATCH v2] drm/amd/powerplay: dynamically disable ds and ulv for
 compute
Thread-Index: AQHVmF2xgFDhVg0tXE6vzYUXGYt6Dg==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 11 Nov 2019 07:00:26 +0000
Message-ID:
 <MN2PR12MB35981F1430CD586518B6295B8E740@MN2PR12MB3598.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b999ae36-2b1b-4683-33d3-08d76674d489
x-ms-traffictypediagnostic: MN2PR12MB3583:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB35838AE42A11448E4018F5F38E740@MN2PR12MB3583.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(189003)(199004)(478600001)(74316002)(110136005)(305945005)(102836004)(186003)(8936002)(6436002)(26005)(99286004)(7696005)(5660300002)(9686003)(14454004)(476003)(52536014)(6506007)(25786009)(7736002)(316002)(86362001)(486006)(33656002)(2501003)(8676002)(71190400001)(71200400001)(55016002)(66066001)(3846002)(6116002)(558084003)(256004)(2906002)(66946007)(76116006)(64756008)(66556008)(66476007)(81156014)(81166006)(66446008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3583;
 H:MN2PR12MB3598.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3rFYIRrevHOLxAdUNXdeRYkDHjS3vWosys9lgKiE3y04KOFKuTPWY8ZlpZeseoOQCW9xrNj7TnM2awBCj6zogN2y6PRWLTArLQVvWpipSRVkR+etDGb8ABkkw7rBuUqjjN7kuZdiCP4/k9pQGQ6mZiUMj5sj7skEpXeuJQoILpgAKhqhITLY3VibV6HUdr5vmed0ZRO7OPnsxXZhFyK2vV50hUTqEn/NXDOCwOW/0WruCuyYj4oORVDB8keVyPOqVEWfY9jbvbfdSQdciMXt4S8UUUPcbnMYpEyZt+lP9FaGtc+txE40aTLqktZo62STXC6orYTXjDJrPqHR97QHsQHB2PhwLpWT9U0l51/9z/gAsf0PeCRl6N18RpawE2O3fKWasfcJJpieFJ7SGR6+W4LeNngSuFbrwLR/zdppLWtKLbSua3wjeOmozk7Ubu1V
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b999ae36-2b1b-4683-33d3-08d76674d489
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 07:00:26.3016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kdFs2x1tM2JsZG9fr2CQJs8F2o8vmjlTlIlIqDAHSQtJW2kDJVpRCtAemLPHnGkQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3583
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMplgNwCaxyB+J9yXwbpCfKRGYuoxhs4I/l/QRtwVlY=;
 b=X5h9UxM4GBbdkW6+nESYol+d0F4r0Ll1vb34UXlcgh6XjqydFRrcAFdJlScQNGHdfiwY70AAY9QjKa0Q4EDvmHy197qT4q+wmSsjlDTLSShtjH+MMZOCk+x14AI342Nu4rjYyea8VQ5flTxMwO3+/nobL3NkHgBGIXaTxF7+Uyk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111070026.M0J9pawVV_3rfkCm8R995w_GBbPaq1E6mRuevz-EzyI@z>

RmVuZywgS2VubmV0aCB3b3VsZCBsaWtlIHRvIHJlY2FsbCB0aGUgbWVzc2FnZSwgIltQQVRDSCB2
Ml0gZHJtL2FtZC9wb3dlcnBsYXk6IGR5bmFtaWNhbGx5IGRpc2FibGUgZHMgYW5kIHVsdiBmb3Ig
Y29tcHV0ZSIuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
