Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB75C35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 17:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C701F21741
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 17:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HMpMxbIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C701F21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6393F6E9D1;
	Wed,  5 Feb 2020 17:12:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 701F76E9D1
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 17:12:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdSJJYNxtY/UfuJe46dnhn8hblddx1BiLXR3YCxFLu9dBs9ykIp7jDWDnVYjnbWOkun/jUmr5NQjOBePZh5/KunXquoMTxi0Nez/UPjHL1FpC4yLYGDqF1X4yPUyT8qhdWdD2csKbS8fKxE+WlRXivFsIzpOn7yVutO/KS/JluLcTSSmBMYCEiMUlSCVjaHCDPqqr/29OBe3EDnsc0GY+gGPnHVL0QmY7G3U1ZwDF1K0VZZm8VkrkHnA1pyHeLfF67spUmWanReIlHARPyYk8wLSOgwjnyUsxpRAGhEeFiH70rtlKtkdUck56At9i/uM+bxGxyksU2F6JMaJH7WCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wkw0qX8gA7GFa+I/pi8GTLE2L210Fd5bnZYl7h00obc=;
 b=L0aiucvhW9cciknInkpmCu25R73mGVNjNvFjg33Kb9TAZXUgARC19a+r4IXuO9Nix1ozwOI1uNtQx+LjGfXlNqbs+Orr4fGgdrwVfAVZhnh/f3oGoE7+0UeMCCMY0fzT07ZweNu6TEIZFPIye82hMfnL2bK0GRgnf9aC3LxDBaqHpwquXkXkU+li5on1+Hghp5++W54Hdmk7ujoyMuN6i05R/8fM2SS3olG2nCIRSpCYsDdUyVOGwXZK+D6lWvoiDTCXLD09NOo5e+SW5bT16eyn7mAoEAgYEZdQ2uRSEzoi65cDdYpNHP3vUdFzEDJDpzK2PD3GUSbzOTSfbfvSgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wkw0qX8gA7GFa+I/pi8GTLE2L210Fd5bnZYl7h00obc=;
 b=HMpMxbIHZTbf8nmqQF2eEwQfCCEH2XrX2U7C/uPlKphvCo3WRA80k8/XxJm9ydA+dYRhj3hcqhxOFfDSljfQrE6DnWb/ozq7wNeHe41/BI2lnmWpRHakXNvXQqS83vtfQqjDWhADcb8U/uqEafWxObeRe15mdka1cTfjpbEtFss=
Received: from DM6PR12MB4314.namprd12.prod.outlook.com (10.141.184.86) by
 DM6PR12MB3676.namprd12.prod.outlook.com (10.255.173.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 5 Feb 2020 17:12:34 +0000
Received: from DM6PR12MB4314.namprd12.prod.outlook.com
 ([fe80::91ff:bd7c:2bb2:d8b9]) by DM6PR12MB4314.namprd12.prod.outlook.com
 ([fe80::91ff:bd7c:2bb2:d8b9%3]) with mapi id 15.20.2707.020; Wed, 5 Feb 2020
 17:12:34 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: use amdgpu_device_vram_access in
 amdgpu_ttm_access_memory
Thread-Topic: [PATCH 4/4] drm/amdgpu: use amdgpu_device_vram_access in
 amdgpu_ttm_access_memory
Thread-Index: AQHV3DgegInvuFdfhE6tzr9MioBjKagM1aQA
Date: Wed, 5 Feb 2020 17:12:34 +0000
Message-ID: <DM6PR12MB43148365ED00EECF6099838385020@DM6PR12MB4314.namprd12.prod.outlook.com>
References: <20200205152238.45258-1-christian.koenig@amd.com>
 <20200205152238.45258-4-christian.koenig@amd.com>
In-Reply-To: <20200205152238.45258-4-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-05T17:10:02Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c04e2041-ee93-455c-a230-0000c6604b51;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-02-05T17:12:31Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: e72ebdfe-d219-4b8a-b241-0000f46a7399
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jonathan.Kim@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c69bc227-0a24-4dd9-b1b0-08d7aa5e97bc
x-ms-traffictypediagnostic: DM6PR12MB3676:|DM6PR12MB3676:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3676E68BFDC5B981EB710A7385020@DM6PR12MB3676.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:187;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(189003)(199004)(53546011)(6506007)(76116006)(9686003)(55016002)(186003)(71200400001)(66574012)(6636002)(8936002)(26005)(86362001)(81156014)(316002)(8676002)(478600001)(66476007)(110136005)(66446008)(66946007)(64756008)(33656002)(2906002)(5660300002)(7696005)(52536014)(66556008)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3676;
 H:DM6PR12MB4314.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kZcnbhvPdTwYJ5BbjrbGqgBh3fpWApURViRY/7BAEd1h+NfqV+ujAvCXXDENHEPP8YFhaZmVsvU5gp/SM0o3Y8wI0/LppaWG7Gmap1b3187b90d+qNb2LsSyYL95YtuxDvEr8QmU2GM/DaGAaxT3gTdSmQEd+5OcPM1SYTqLdrnBOS0SRm1NQogEF30yRslsL1s98vnKp/c1weKrjMI7PpKw5x50W5UQcyM+vYngdYK0R1SZ1bYUPbU4EFlD8XZkLf5DBj/tLW6VA7kxlS4sTdM5aBvTR3owgq/d0RWf4vd8kZzRNzxK0rVpvy3y3fRUzUkZqRmqZxL/wQq+xkWZQV2kYTEoL4hWbZWehsuUwsDgFAVPyT/H+rbYvSRaIaKPZl7jeDuRj0tZnQLH2TUOZPahKUte8yha9t5eVGELYGXWH9XltOnz9WdWst5b9vyU
x-ms-exchange-antispam-messagedata: Wqr1DqcAuwO1c0i09JlZHVOy0/4Hq2q6iAg9B59PfDQ4f1CTby4P48vGnyTYtMGWgR5umCMLGVRpkjAUxnZRp+KhytHb3e1BxfUS/IRTk7EmhLw//Ahb3/w0tfV8fcnkI8n7s3pRaw09dHOD26hmOQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69bc227-0a24-4dd9-b1b0-08d7aa5e97bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 17:12:34.3462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oStDmWYLICW/ymjLU5dzHhGtqqoEI3dHzBLNKr/qF1SZmo0ZErKbPjIh0CdiwbWr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3676
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpUZXN0ZWQgb24gVmVnYTIwIHZpYSBwcm9jIG1lbSBvcCByZWFk
cy4NCg0KT2xkIE1NSU8gfjIuN01CL3MsIEltcHJvdmVkIE1NSU8gfjMuMk1CL3MsIEJBUiB+NDRN
Qi9zDQoNCkFja2VkLWJ5OiBKb25hdGhhbiBLaW0gPEpvbmF0aGFuLktpbUBhbWQuY29tPg0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5p
Zy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSA1
LCAyMDIwIDEwOjIzIEFNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEt1ZWhs
aW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT47IEtpbSwgSm9uYXRoYW4gPEpvbmF0
aGFuLktpbUBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIIDQvNF0gZHJtL2FtZGdwdTogdXNlIGFt
ZGdwdV9kZXZpY2VfdnJhbV9hY2Nlc3MgaW4gYW1kZ3B1X3R0bV9hY2Nlc3NfbWVtb3J5DQoNCltD
QVVUSU9OOiBFeHRlcm5hbCBFbWFpbF0NCg0KTWFrZSB1c2Ugb2YgdGhlIGJldHRlciBwZXJmb3Jt
YW5jZSBoZXJlIGFzIHdlbGwuDQoNClRoaXMgcGF0Y2ggaXMgb25seSBjb21waWxlIHRlc3RlZCEN
Cg0KU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgMzgg
KysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25z
KCspLCAxNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90
dG0uYw0KaW5kZXggNThkMTQzYjI0YmEwLi41MzhjM2I1MmI3MTIgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYw0KQEAgLTE1NjUsNyArMTU2NSw3IEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X3R0bV9hY2Nlc3NfbWVtb3J5KHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8s
DQoNCiAgICAgICAgd2hpbGUgKGxlbiAmJiBwb3MgPCBhZGV2LT5nbWMubWNfdnJhbV9zaXplKSB7
DQogICAgICAgICAgICAgICAgdWludDY0X3QgYWxpZ25lZF9wb3MgPSBwb3MgJiB+KHVpbnQ2NF90
KTM7DQotICAgICAgICAgICAgICAgdWludDMyX3QgYnl0ZXMgPSA0IC0gKHBvcyAmIDMpOw0KKyAg
ICAgICAgICAgICAgIHVpbnQ2NF90IGJ5dGVzID0gNCAtIChwb3MgJiAzKTsNCiAgICAgICAgICAg
ICAgICB1aW50MzJfdCBzaGlmdCA9IChwb3MgJiAzKSAqIDg7DQogICAgICAgICAgICAgICAgdWlu
dDMyX3QgbWFzayA9IDB4ZmZmZmZmZmYgPDwgc2hpZnQ7DQoNCkBAIC0xNTc0LDIwICsxNTc0LDI4
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3R0bV9hY2Nlc3NfbWVtb3J5KHN0cnVjdCB0dG1fYnVmZmVy
X29iamVjdCAqYm8sDQogICAgICAgICAgICAgICAgICAgICAgICBieXRlcyA9IGxlbjsNCiAgICAg
ICAgICAgICAgICB9DQoNCi0gICAgICAgICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmYWRldi0+
bW1pb19pZHhfbG9jaywgZmxhZ3MpOw0KLSAgICAgICAgICAgICAgIFdSRUczMl9OT19LSVEobW1N
TV9JTkRFWCwgKCh1aW50MzJfdClhbGlnbmVkX3BvcykgfCAweDgwMDAwMDAwKTsNCi0gICAgICAg
ICAgICAgICBXUkVHMzJfTk9fS0lRKG1tTU1fSU5ERVhfSEksIGFsaWduZWRfcG9zID4+IDMxKTsN
Ci0gICAgICAgICAgICAgICBpZiAoIXdyaXRlIHx8IG1hc2sgIT0gMHhmZmZmZmZmZikNCi0gICAg
ICAgICAgICAgICAgICAgICAgIHZhbHVlID0gUlJFRzMyX05PX0tJUShtbU1NX0RBVEEpOw0KLSAg
ICAgICAgICAgICAgIGlmICh3cml0ZSkgew0KLSAgICAgICAgICAgICAgICAgICAgICAgdmFsdWUg
Jj0gfm1hc2s7DQotICAgICAgICAgICAgICAgICAgICAgICB2YWx1ZSB8PSAoKih1aW50MzJfdCAq
KWJ1ZiA8PCBzaGlmdCkgJiBtYXNrOw0KLSAgICAgICAgICAgICAgICAgICAgICAgV1JFRzMyX05P
X0tJUShtbU1NX0RBVEEsIHZhbHVlKTsNCi0gICAgICAgICAgICAgICB9DQotICAgICAgICAgICAg
ICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYWRldi0+bW1pb19pZHhfbG9jaywgZmxhZ3MpOw0K
LSAgICAgICAgICAgICAgIGlmICghd3JpdGUpIHsNCi0gICAgICAgICAgICAgICAgICAgICAgIHZh
bHVlID0gKHZhbHVlICYgbWFzaykgPj4gc2hpZnQ7DQotICAgICAgICAgICAgICAgICAgICAgICBt
ZW1jcHkoYnVmLCAmdmFsdWUsIGJ5dGVzKTsNCisgICAgICAgICAgICAgICBpZiAobWFzayAhPSAw
eGZmZmZmZmZmKSB7DQorICAgICAgICAgICAgICAgICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgm
YWRldi0+bW1pb19pZHhfbG9jaywgZmxhZ3MpOw0KKyAgICAgICAgICAgICAgICAgICAgICAgV1JF
RzMyX05PX0tJUShtbU1NX0lOREVYLCAoKHVpbnQzMl90KWFsaWduZWRfcG9zKSB8IDB4ODAwMDAw
MDApOw0KKyAgICAgICAgICAgICAgICAgICAgICAgV1JFRzMyX05PX0tJUShtbU1NX0lOREVYX0hJ
LCBhbGlnbmVkX3BvcyA+PiAzMSk7DQorICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXdyaXRl
IHx8IG1hc2sgIT0gMHhmZmZmZmZmZikNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dmFsdWUgPSBSUkVHMzJfTk9fS0lRKG1tTU1fREFUQSk7DQorICAgICAgICAgICAgICAgICAgICAg
ICBpZiAod3JpdGUpIHsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmFsdWUgJj0g
fm1hc2s7DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhbHVlIHw9ICgqKHVpbnQz
Ml90ICopYnVmIDw8IHNoaWZ0KSAmIG1hc2s7DQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFdSRUczMl9OT19LSVEobW1NTV9EQVRBLCB2YWx1ZSk7DQorICAgICAgICAgICAgICAgICAg
ICAgICB9DQorICAgICAgICAgICAgICAgICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZh
ZGV2LT5tbWlvX2lkeF9sb2NrLCBmbGFncyk7DQorICAgICAgICAgICAgICAgICAgICAgICBpZiAo
IXdyaXRlKSB7DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhbHVlID0gKHZhbHVl
ICYgbWFzaykgPj4gc2hpZnQ7DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1lbWNw
eShidWYsICZ2YWx1ZSwgYnl0ZXMpOw0KKyAgICAgICAgICAgICAgICAgICAgICAgfQ0KKyAgICAg
ICAgICAgICAgIH0gZWxzZSB7DQorICAgICAgICAgICAgICAgICAgICAgICBieXRlcyA9IChub2Rl
cy0+c3RhcnQgKyBub2Rlcy0+c2l6ZSkgPDwgUEFHRV9TSElGVDsNCisgICAgICAgICAgICAgICAg
ICAgICAgIGJ5dGVzID0gbWluKHBvcyAtIGJ5dGVzLCAodWludDY0X3QpbGVuICYgfjB4M3VsbCk7
DQorDQorICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfZGV2aWNlX3ZyYW1fYWNjZXNzKGFk
ZXYsIHBvcywgKHVpbnQzMl90ICopYnVmLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBieXRlcywgd3JpdGUpOw0KICAgICAgICAgICAgICAgIH0NCg0K
ICAgICAgICAgICAgICAgIHJldCArPSBieXRlczsNCi0tDQoyLjE3LjENCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
