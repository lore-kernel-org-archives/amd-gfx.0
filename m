Return-Path: <SRS0=pLrr=6K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634CEC54FCB
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 12:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333EA2071C
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 12:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L6uqFVlp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333EA2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A651D6E29B;
	Sun, 26 Apr 2020 12:55:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88A2D6E29B
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2020 12:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ja8WYPjHKcyqglKTNXtyiQUpzqdRqAHk4Lr1ASF4oJIQvOnaJXtXSALIkkZIn7MaRj+h/Swp5Yj7KfAyJi2DQZ0egHaCu9N8ykfP7+KTAJYj8j1eUlH+x87MYRZZkrcI/a/fSNRB5CQ22Iv15h9qVDh+e/pZh6eKx1PCYZYRszmTL5vsfVEVcJih0QizLPr5izhd5MaNt5TymDw3a7LXyKA4DExTML6X8LmjQtMAolsrC8rtKBRcXwpyFqJE1nS6FBlIV+uNqQi4AtudHHhu5/AHsFFKNK6SJrnfcivXxkYyLTJn/8XuD6oon35H+LEsU6IT1Wou9CNuMCn3U2dAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEs8GsBFh2UGv77pL7m5/XXR95ZLvTZ67I9LxlWjBto=;
 b=PxxTLsTS0Ra29jXJO3fTIIDjc1K72mVwyn7yOpNRrhhZHEKDNBs09/KHufycBTttXgmfX9BBnD3rcA+ew639dv4O7cFeShjGSNvVfkaYDbqN+/oqACXFQnYku+No9zPXzausa9W30lCPe49+MoYG41HFDq01E5ihN61DOXJzd1QJf6VsKpL62b4WTgn6Ou/NfalPFmFfA4Mc/6zmzhFo6NTO6j74EtJ8/w4N9yH81EMcQ0ZafTAqaEoigOzQI0FHV4ZS8QA6ww2diWmgSlGwBVZy0ax4cwaCM6N6hCha7PRcZDEaC5Uc69QCv3eOokJ/FDCGBKXiAToKkwkxLPQicQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEs8GsBFh2UGv77pL7m5/XXR95ZLvTZ67I9LxlWjBto=;
 b=L6uqFVlp7nIGVXdbC3u38lo1xdra5n6MXDubI4XsUiWlhky6NsoYK7QPDk4+Stgt9JHaRYj50K/tRlgWyC6XfIMAEXSLmZzJYeYK+IDHU+d16P4LDe+JY3xxx1ooZNFoWdu8nLVO5UAHh/14HtViU06KVJqUN3WCNl7cbs10dKA=
Received: from MN2PR12MB2893.namprd12.prod.outlook.com (2603:10b6:208:107::21)
 by MN2PR12MB3647.namprd12.prod.outlook.com (2603:10b6:208:c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sun, 26 Apr
 2020 12:55:49 +0000
Received: from MN2PR12MB2893.namprd12.prod.outlook.com
 ([fe80::10f6:bddd:34bf:a899]) by MN2PR12MB2893.namprd12.prod.outlook.com
 ([fe80::10f6:bddd:34bf:a899%6]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 12:55:48 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 0/2] add correctable error query support on arcturus
Thread-Topic: [PATCH 0/2] add correctable error query support on arcturus
Thread-Index: AQHWG6t3JRnVmB82lUKo9a4+8rUi7qiLUuYA
Date: Sun, 26 Apr 2020 12:55:48 +0000
Message-ID: <MN2PR12MB28932446878825AE7B9425C0B0AE0@MN2PR12MB2893.namprd12.prod.outlook.com>
References: <20200426091644.26776-1-guchun.chen@amd.com>
In-Reply-To: <20200426091644.26776-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-26T12:21:02Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=812a00ae-fd67-4023-9839-000099c38dac;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-26T12:21:02Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a142c6d1-8384-417c-a9ed-0000036f8fe2
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tao.Zhou1@amd.com; 
x-originating-ip: [101.69.200.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db7a9a35-333c-4f6f-c690-08d7e9e124b2
x-ms-traffictypediagnostic: MN2PR12MB3647:|MN2PR12MB3647:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB364754FA2D25B9656665AB59B0AE0@MN2PR12MB3647.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 03853D523D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2893.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(4326008)(5660300002)(71200400001)(110136005)(6636002)(66946007)(66476007)(33656002)(52536014)(55016002)(66556008)(66446008)(64756008)(86362001)(9686003)(76116006)(478600001)(53546011)(7696005)(8676002)(8936002)(2906002)(186003)(316002)(81156014)(6506007)(26005)(921003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f7eBlrUCnx6KK+hyTZdzwo30jY2GA82L2LKV9FUUsJEbZLoz91tHmD2eGfrl6Z/Ct4TKxfuX4VWyxteIXsofVwWLC3ziNNj1HgU8SPGo9VfqNqgNi6ucRM35IuZqfII5AXBmki0Z3JVx8RSc0vmOX2r5fotLebgn6lU9ThAxYqutpQCZTtcD0ggim7Y0l9UX8IydYlsCxIeSveGPc6nrELtTKpiFmhAsbgXnuWmYhbw+joVJvIsYT09l3vw60SeG7yCS2CA67WkeuJQpH/AfBs6N2A+FjjahfQo6B1XLxmO/1Lg3ejEoIGshW92qNtgOMKAMgi4bkr3YFNSvFHz9hySyIRty65S82RkUhA/fWE9eUIp45icubfra7dKaHwJpsC28FXUUbsJEcePMlhqRGTDXXo3sZVGXyqeUwZCjT48/USz9d0v9qfkV0TpmLjjqvgxEcvP4o5HDm+X5ovlv1kUMc0zS6xt0dluQgENxUFo=
x-ms-exchange-antispam-messagedata: U6095luRR54UrVGzMQBo+ISZtmoxbWwNq6mTlBRDDAFqk+lWPPmDbcE7WIXgPeHQ3sEhC0I8aHkSC3T1UBNnrGdJtHGgqCl1WKq1UOcY4CmHGlgBX8Xc4QSAYGOZiESiV1S2Fk0s3NihvV5dEwYnM+4nMlrJEJ4U6V+mEl0b5UJVJOeExdwTsuIsDc/v5xFgV4frLS50nVppjCJhulB2gkZs/rDMtbmLM5B1JY4yPsqvkiRx/jfowHeyyFKEwMqAs2tFYYBN4HiUhl/fmx/NjTgRzLMdicDnrRu/TDzgD/KS2Iu7LoDgNfdiMA9T7KZauE82aN2jsFiMTSIPp94XaJjKWgb0HY0XAT6EqFWK6eu7MegEZHCYgl57FzwNkjCKn4hHR2livu94BRaPPOKbcvpBKrfYvCvtOwcZXPQb0K3N9Q22gdKL8jrtjPanH9iOE1CIg8EVJapBper/G01Nqga6WEf7t2E+gK+6kHZL8rW9BUQS9JCfUvjVAPunGIfFq93BDaebUY5h3h2dcg5WNYWCM+56CtfRIEtYYBXcWhjx0G7ssH4VZwsawK5BYKOcoszyzoUhYC2fdIY88ui0ZZT0kwPEjwhoViQoV815zbtU6K8PQzEk5o0tavDXh13g6OlytMvuJizh5ZVQBmm4o+EklJPCw9/cGYJDTlqPcYHuF3w+/+EONaHThjMFaJ4WQNSSGkOl+6EE0eobXxrUi6fd0z38xewP8q7UkEIOsAjJdIacyQGLhtTTsJ9P+niPbogeZ2Q0giftgPX0htkQAIbUBjp7JzJhLRZ6b7tQd1g=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7a9a35-333c-4f6f-c690-08d7e9e124b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2020 12:55:48.7534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HC1Db7QD2qszldQ4kWy+jX5gbN3k3x56/eiIwc/A3ZkqVJXzfKgKFvT19FBXMnVX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3647
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpU
aGUgc2VyaWVzIGlzOg0KDQpSZXZpZXdlZC1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29t
Pg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENoZW4sIEd1Y2h1biA8
R3VjaHVuLkNoZW5AYW1kLmNvbT4NCj4gU2VudDogMjAyMMTqNNTCMjbI1SAxNzoxNw0KPiBUbzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5nLCBIYXdraW5nDQo+IDxIYXdraW5n
LlpoYW5nQGFtZC5jb20+OyBMaSwgRGVubmlzIDxEZW5uaXMuTGlAYW1kLmNvbT47IFpob3UxLCBU
YW8NCj4gPFRhby5aaG91MUBhbWQuY29tPjsgQ2xlbWVudHMsIEpvaG4gPEpvaG4uQ2xlbWVudHNA
YW1kLmNvbT47DQo+IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT4NCj4gQ2M6IExpLCBDYW5kaWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+OyBDaGVuLCBHdWNodW4N
Cj4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAwLzJdIGFkZCBjb3Jy
ZWN0YWJsZSBlcnJvciBxdWVyeSBzdXBwb3J0IG9uIGFyY3R1cnVzDQo+IA0KPiBCZWxvdyB0d28g
cGF0Y2hlcyBhcmUgc3VibW1pdGVkIHRvIHByb21pc2UgVU1DIGNvcnJlY3RhYmxlIGVycm9yIHF1
ZXJ5DQo+IHdvcmtpbmcgZmluZSBvbiBhcmN0dXJ1cy4NCj4gUGF0Y2ggMSBpcyB0byBzd2l0Y2gg
UlNNVSBVTUMgaW5kZXggYWNjZXNzIHRvIFNNTiBpbnRlcmZhY2UgdG8gbWFrZSBpdA0KPiBzdGFi
bGUsIGFuZCB0byBiZSBjb25zaXN0ZW50IHdpdGggb3RoZXIgcmVnaXN0ZXIgYWNjZXNzIGluIHRo
aXMgZmlsZS4NCj4gUGF0Y2ggMiBpcyB0byBkZWNvdXBsZSBFY2NFcnJDbnQgZXJyb3IgY291bnQg
cXVlcnkgYW5kIGNsZWFyIG9wZXJhdGlvbiwgZHVlDQo+IHRvIHVua25vd24gaGFyZHdhcmUgY2F1
c2UuDQo+IA0KPiBCb3RoIGFyZSB2ZXJpZmllZCBvbiBhcmN0dXJ1cyBhbmQgVmVnYTIwLg0KPiAN
Cj4gR3VjaHVuIENoZW4gKDIpOg0KPiAgIGRybS9hbWRncHU6IHN3aXRjaCB0byBTTU4gaW50ZXJm
YWNlIHRvIG9wZXJhdGUgUlNNVSBpbmRleCBtb2RlDQo+ICAgZHJtL2FtZGdwdTogZGVjb3VwbGUg
RWNjRXJyQ250IHF1ZXJ5IGFuZCBjbGVhciBvcGVyYXRpb24uDQo+IA0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdW1jX3Y2XzEuYyB8IDExMg0KPiArKysrKysrKysrKysrKysrKysrKysr
Ky0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwMyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygt
KQ0KPiANCj4gLS0NCj4gMi4xNy4xDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
