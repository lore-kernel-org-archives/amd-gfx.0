Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A46C2BA19
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 11:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544EC206A2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 11:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gb78WE5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544EC206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02CAA6E0DB;
	Wed, 15 Apr 2020 11:52:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578486E0DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 11:52:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGdlD3Yq7HZZjZ3qYWhjY3kpFVe7bGq/uKmJfGrO27784sPGLzT2TSCj1fNtLQTMr7MZFAmsLIYQSQAGv0BBxwTD2RPXas2bXkwGTUCuz3paeMfhyJ0TC/yLwXTuMh8jmSo10DJXC6vSFX7DcjyoCFqtNNkpA1RvjZNPdyBqKOYA00a2Xjc8JrYhRJ/+Eq7qHWCDJWYM/+CVnHM8BfD1szMJaXJLVBhKeRlv9GibMWuEPiGI9xgoGquSObZROKpr117gkKMTUqpgutN9RUEU1PjkffnOda2YelvPVaWfcApzACQMH3ox/eVIeFEn9Cs1budNOckDY8Obq5WPvsYExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLiK/VJEe9scCr2t4TEXvYBf8MeZqdqryX63zXF5FXQ=;
 b=YKnXw/CVXb9ejYQeUm8wAsa5KtanyAA6pievUi+bUDoy0FKpyk6n3eD3jco0c3kHdlqJSuno0z0ZYt8auyh704a7U4CRtKG2J9w8aotgE3ulLBDxRiA1M0lzJlFp5jvdZrZDijpxm5ukDzmQ1CnW8xzhCDsAbqyxIPJGRct/bmKBb0JrgcvrrZuIZZukwF5pRz+yNma6v9Rd06yq9Uhkkj5XoJGceMTrj8ofd0Ka4rQb5hLLL/xmG0ZNYRZwvZtgDjqsd8xR1zwNDxp0NZ2BgJA3Gyt4flwFNdw2LjIOcFg3t+euRMmKmxxcZHmg9wxrYBbVsizf9IseDx+wVvJ0OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLiK/VJEe9scCr2t4TEXvYBf8MeZqdqryX63zXF5FXQ=;
 b=gb78WE5Ud/DHDaHIpIvtqOl+7BXuQ05kDFRRsOC97d2PsfLymPHr8J33UOXYPjaCw7QFL9NuM+s62F5MQToIvLDbfy6YJeZUVVf3dOhEBIy2PcEtY7nBOlf/oYORJYbspkaus2bkCMSd+xBHHHFJPQE0LFTozM6oOF4u9kxVHmw=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Wed, 15 Apr
 2020 11:52:10 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 11:52:10 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/scheduler: fix drm_sched_get_cleanup_job
Thread-Topic: [PATCH] drm/scheduler: fix drm_sched_get_cleanup_job
Thread-Index: AQHWEmgjjp9DRMNKvEm7SICOujgozah4roSAgAFP+YCAABT6YA==
Date: Wed, 15 Apr 2020 11:52:09 +0000
Message-ID: <DM6PR12MB372148B7DD5C3B5AC97E516B85DB0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200414142217.5736-1-kent.russell@amd.com>
 <404ae73e-fb1c-bbcf-5037-4afbc2f66410@amd.com>
 <2f1ac780-43b3-e58d-c45d-0dd69c2443f0@amd.com>
In-Reply-To: <2f1ac780-43b3-e58d-c45d-0dd69c2443f0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-15T11:52:08Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=12f78afb-a9f0-4475-9d75-0000b2e637ba;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-15T11:52:08Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 33ca6b9d-3549-41eb-abe3-000089b77581
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
x-originating-ip: [99.250.168.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c7f7c0a-4d15-4c63-bbf7-08d7e1336df0
x-ms-traffictypediagnostic: DM6PR12MB4266:|DM6PR12MB4266:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4266DDC11A5689A0DF0BFCDD85DB0@DM6PR12MB4266.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(55016002)(53546011)(6506007)(7696005)(66556008)(66946007)(9686003)(8676002)(81156014)(52536014)(8936002)(71200400001)(33656002)(66476007)(76116006)(66446008)(64756008)(5660300002)(66574012)(26005)(110136005)(478600001)(86362001)(186003)(2906002)(316002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KKSZTmVovk6px3E0fgOLxSOTTWpqxnI9ccldxt5jRTbmey8VCv6ShDb4jZohvFVHEYzm6CoD7Qf/4eXIGoS4HW8m2wVT/ALR0V+R0xvhIlDeqdI7z0VD1uUYTqC34VEvEFqRMmZqFb389ctV9TTNAiGOpbVMu3avFEVMtFgtqGJ99jAOVs2k3WOzjLmi+YvmugIk5VQgModxjv0iZmxqf7wA//NoNZ03m31H/OUsngw4P3N5nhpQqEFUnvky3k91WgNMuIrYCezvztHrpU30M2v8mjmVjLHkuENBHjtymgukT3KJuhSLp0fw+vi+VhSBTWwXMCAbM+3slyxt7X10fedkeE0NPpmA3vvJ2AbNEw407WfSfUL6t/yWylAsVez+fOD7f+9dCIQx0P9r1uYW3XGHasybuvfhXxcVeY9s5J+jhZJhRJUnYZb/IP4H7FJ5
x-ms-exchange-antispam-messagedata: W3/Adbu8klPVu5S59fmxpL0MBacatWvoDagHmhPrapfdU4/8/nWI7DpUfU9rTNyUatNLXS5xgiC6Iy3nsH9PrmdPS+4Q4XXpF13w5ircBqCueQ07Gvw4tDwM32YC56Wx2ul/j4911hkhFKFSshMuzQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7f7c0a-4d15-4c63-bbf7-08d7e1336df0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 11:52:09.8900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4AFTOePrbS3IDCTjimEbsO/c7joXc9Kb7PJsNmCEogbPQuFIpSsQ+euUUnCmny6BNIIPIEz2EMI46dPTiUiLGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpJ
dCdzIGFsbCBnb29kLiBJIHB1c2hlZCBhIGNvcHkgdG8gYW1kLXN0YWdpbmctZHJtLW5leHQsIHJl
dmlld2VkIGJ5IEFuZHJleS4gVGhhbmtzIGZvciBwdXNoaW5nIGl0IHRvIGRybS1taXNjLWZpeGVz
IQ0KDQogS2VudA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtvZW5p
ZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgQXByaWwgMTUsIDIwMjAgNjozNiBBTQ0KPiBUbzogR3JvZHpvdnNreSwgQW5kcmV5IDxBbmRy
ZXkuR3JvZHpvdnNreUBhbWQuY29tPjsgUnVzc2VsbCwgS2VudA0KPiA8S2VudC5SdXNzZWxsQGFt
ZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBkcm0vc2NoZWR1bGVyOiBmaXggZHJtX3NjaGVkX2dldF9jbGVhbnVwX2pvYg0KPiANCj4g
U29ycnkgZm9yIHRoZSBob2xpZGF5L3ZhY2F0aW9uL0NPVklELTE5IGRlbGF5LiBJJ3ZlIGp1c3Qg
cHVzaGVkIHRoaXMgcGF0Y2ggaW50bw0KPiBkcm0tbWlzYy1maXhlcy4NCj4gDQo+IEkgYXNzdW1l
IGl0IGFscmVhZHkgbGFuZGVkIGluIG91ciBpbnRlcm5hbCBicmFuY2hlcz8NCj4gDQo+IFRoYW5r
cywNCj4gQ2hyaXN0aWFuLg0KPiANCj4gQW0gMTQuMDQuMjAgdW0gMTY6MzMgc2NocmllYiBBbmRy
ZXkgR3JvZHpvdnNreToNCj4gPiBSZXZpZXdlZC1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJl
eS5ncm9kem92c2t5QGFtZC5jb20+DQo+ID4NCj4gPiBBbmRyZXkNCj4gPg0KPiA+IE9uIDQvMTQv
MjAgMTA6MjIgQU0sIEtlbnQgUnVzc2VsbCB3cm90ZToNCj4gPj4gRnJvbTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiA+Pg0KPiA+PiBXZSBhcmUgcmFjaW5n
IHRvIGluaXRpYWxpemUgc2NoZWQtPnRocmVhZCBoZXJlLCBqdXN0IGFsd2F5cyBjaGVjayB0aGUN
Cj4gPj4gY3VycmVudCB0aHJlYWQuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlh
biBLb2VuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gPj4gUmV2aWV3ZWQtYnk6IEtl
bnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFtZC5jb20+DQo+ID4+IC0tLQ0KPiA+PiDCoCBkcml2
ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYyB8IDIgKy0NCj4gPj4gwqAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYw0KPiA+PiBiL2Ry
aXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jDQo+ID4+IGluZGV4IDhlNzMxZWQw
ZDlkOS4uMmYzMTkxMDJhZTlmIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2No
ZWR1bGVyL3NjaGVkX21haW4uYw0KPiA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVy
L3NjaGVkX21haW4uYw0KPiA+PiBAQCAtNjc2LDcgKzY3Niw3IEBAIGRybV9zY2hlZF9nZXRfY2xl
YW51cF9qb2Ioc3RydWN0DQo+ID4+IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCkNCj4gPj4gwqDC
oMKgwqDCoMKgICovDQo+ID4+IMKgwqDCoMKgwqAgaWYgKChzY2hlZC0+dGltZW91dCAhPSBNQVhf
U0NIRURVTEVfVElNRU9VVCAmJg0KPiA+PiDCoMKgwqDCoMKgwqDCoMKgwqAgIWNhbmNlbF9kZWxh
eWVkX3dvcmsoJnNjaGVkLT53b3JrX3RkcikpIHx8DQo+ID4+IC3CoMKgwqDCoMKgwqDCoCBfX2t0
aHJlYWRfc2hvdWxkX3Bhcmsoc2NoZWQtPnRocmVhZCkpDQo+ID4+ICvCoMKgwqDCoMKgwqDCoCBr
dGhyZWFkX3Nob3VsZF9wYXJrKCkpDQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTlVM
TDsNCj4gPj4gwqAgwqDCoMKgwqDCoCBzcGluX2xvY2soJnNjaGVkLT5qb2JfbGlzdF9sb2NrKTsN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
