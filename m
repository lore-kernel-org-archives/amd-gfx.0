Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F3EC2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 09:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132BD20CC7
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 09:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SWE7oJGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132BD20CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D08CB6E8FA;
	Tue, 21 Apr 2020 09:54:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1720E6E8FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 09:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRmRvxkfWRpyapZn9Smh3bjwk0Q2YNZjc2KrLVVvlTwMx6nHkPtWB+93I3fJExxe0bkfCNEAsQZPKNz9Ud8qY5hxgCUi+IfSZS/eLaBqRnlBNkDO3YUfbvzKQyE+epMtwHHItZtzyjP8G6vC2eCZTf65Wom+pMnucWD3/AOSOAQcwMV3rWvA3ThGw03ztNEJI9YdTKVsyJuoL8jVgZp54Bgg7o9GzmhnEhnifqcTyRsho2YO2t5wANwgtYEhHXoBmUi/2hJMXbQAnsxIRAOPBv77KNnAIRWi8TmnpXPOJuQtIi4s1QWpiM1RBy3wGUnuulBD4JNxc7hvipaUv55AgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0LssgMzVEwbVSHn3kz5w0PL53AEm02rYUUEPk4mpb4=;
 b=NhpUWE0wGQNP9mJWHJhjp8xdwkIgqLdlf2j6UIjGKPhxUE3k0acfSMNVLSFvgGSg6eUWo/TCE9TVirm253lfiVQVnwdaCyuhyo9+6nV1XvO2oEByWWGA7Xh6jt63TpvN2tnd8/c0BQhDs4GC1HB/6GqS8uKQDergZmv8pE66FekG3gaIafzlsEjmxCsh9v3sS6AJ8gV5bFQRvn6M2rXNoJJsj8uz8ycUo3anm6y2jutL/q3iuiIWqH90kMm7w6p+tK1LJaJiPkvTqiC3d0mZe3eoW7gnmnOmC6KZMBoVnKudN72N1fPTzOv59nnFEFso2YI2yqHldAXnk+ZsrvY92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0LssgMzVEwbVSHn3kz5w0PL53AEm02rYUUEPk4mpb4=;
 b=SWE7oJGoc/jbQ9y0gX5nxNGVeVekgJ7oKoIye5OlQoE633y13TVnUjwsdyl1JMDXc0TE9bmTKbq/SyXbw7n+paTJqsA37KLfXfGsQPa7O4pw+s/MUPpDqD16oZd/BJTyq5a9tKzTvkGT3088qRvyupCIr75va4cUFwJ+lCV2i1A=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1771.namprd12.prod.outlook.com (2603:10b6:3:110::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Tue, 21 Apr
 2020 09:54:27 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd%8]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 09:54:27 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Tao, Yintian"
 <Yintian.Tao@amd.com>, "He, Jacob" <Jacob.He@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: cleanup SPM VMID update
Thread-Topic: [PATCH] drm/amdgpu: cleanup SPM VMID update
Thread-Index: AQHWF7ynCIwJx8CEhk+r7oFgdDlF66iDU8OAgAAB0ACAAABnMA==
Date: Tue, 21 Apr 2020 09:54:27 +0000
Message-ID: <DM5PR12MB1708CD99E8C25337A7766CA584D50@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200421091004.130041-1-christian.koenig@amd.com>
 <MN2PR12MB30398FD163EB6424F5E8E502E5D50@MN2PR12MB3039.namprd12.prod.outlook.com>
 <3c1996ea-82a6-7962-7ef9-d6b5b1a4e6e1@gmail.com>
In-Reply-To: <3c1996ea-82a6-7962-7ef9-d6b5b1a4e6e1@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a9120586-e282-4994-3842-08d7e5d9fb00
x-ms-traffictypediagnostic: DM5PR12MB1771:|DM5PR12MB1771:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17712397DE7B485DDCC6519C84D50@DM5PR12MB1771.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(53546011)(478600001)(8936002)(186003)(71200400001)(66574012)(8676002)(81156014)(5660300002)(9686003)(6506007)(66556008)(64756008)(66446008)(55016002)(26005)(33656002)(66476007)(52536014)(316002)(86362001)(4326008)(15650500001)(7696005)(110136005)(66946007)(2906002)(76116006);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e8Z1ioBjga3hK/ZSOaUkkAanX2DCFIH2pw998RZFOWk29g6M4Y3EdL4Y1USTAUykciTCDLWehht6xu9FWLxBfOOm0WM4vEUxLFzd9XdWf/FQy8xHnggEyoUFIk3l5ngD0Hfi6EW6Nj0fhy671VoqEidqCve5Ipi/CvW4zSuJKXFhlmxbIMTyemKlS+Lb+VopRSzLr0WMPvYSc9Cs/U82L80Sp3Z/EHdPh1kluNBq1q/bVo3kMJ/A2dwKCPXQSEEh+/dBfVA+SiHZg8iNh/TPURFujLpQM5BZDe3k2R6ipNkXACplTT7pe7ktDQvF0Q0KYbU5nwughutXRn9V0o6tQ8ag11fbiOHifaw3Y1LKNoCk72j8ojY0puiY/YBWYk0E74ConADOPhxhYCMrQoaJUU181FBlQKPcPkudQ9fgN2g6osFh5xJ3IvFNodhuMW6r
x-ms-exchange-antispam-messagedata: 572nXIZ+RVK74GxXVxCUBbHch2UkvTAuui75LMuyXDtHFZOhMQQKM7RqQUGcyhh5uWlGtyrkSv9KTmI57XrmgrxLo8qDYKC0diTEm3GTAb6Jni2HZ5eS6ED+MdBWxQpfU0sBKDdVhKlkRtU6+ohuLA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9120586-e282-4994-3842-08d7e5d9fb00
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 09:54:27.6024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWfljhEgPklW5K8Or79mZgAeFV69AIFvLMw2mySCttT/ZDaMgR3sxScWJdQ0XnpV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1771
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
Cc: "Gu, Frans" <Frans.Gu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Pj4+IENvdWxkIG9ubHkgYmUgdGhhdCB0aGUgZmlybXdhcmUgdXBkYXRlcyB0aGUgYml0cyB0byBz
b21ldGhpbmcgbm9uIGRlZmF1bHQsIEknbSBnb2luZyB0byBkb3VibGUgY2hlY2sgdGhhdCBvbiBh
IFZlZ2ExMC4NCg0KSSB0aGluayB0aGF0IHdpbGwgYmUgYSBzdXJlIGFuc3dlciwgb3RoZXJ3aXNl
IHdoeSB3ZSBuZWVkIHRob3NlIGZpZWxkIGlmIHdlIGFsd2F5cyB3cml0ZSAwIHRvIHRoZW0gYW5k
IHJlYWRlciBhbHdheXMgZXhwZWN0IDAgcmVhZGluZyBiYWNrIGZyb20gdGhlbSA/Pw0KDQpUaG9z
ZSBmaWVsZHMgYXJlIGtpbmQgb2YgcGVyZm9ybWFuY2UgY291bnRlcnMgDQoNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCk1vbmsgTGl1fEdQVSBWaXJ0dWFsaXphdGlvbiBU
ZWFtIHxBTUQNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IA0KU2VudDogVHVlc2Rh
eSwgQXByaWwgMjEsIDIwMjAgNTo1MiBQTQ0KVG86IFRhbywgWWludGlhbiA8WWludGlhbi5UYW9A
YW1kLmNvbT47IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT47IEhlLCBKYWNvYiA8SmFjb2Iu
SGVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogR3UsIEZyYW5z
IDxGcmFucy5HdUBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogY2xl
YW51cCBTUE0gVk1JRCB1cGRhdGUNCg0KQW0gMjEuMDQuMjAgdW0gMTE6NDUgc2NocmllYiBUYW8s
IFlpbnRpYW46DQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENocmlz
dGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0KPiBTZW50OiAy
MDIw5bm0NOaciDIx5pelIDE3OjEwDQo+IFRvOiBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+
OyBUYW8sIFlpbnRpYW4gPFlpbnRpYW4uVGFvQGFtZC5jb20+OyANCj4gSGUsIEphY29iIDxKYWNv
Yi5IZUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IEd1LCBG
cmFucyA8RnJhbnMuR3VAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBj
bGVhbnVwIFNQTSBWTUlEIHVwZGF0ZQ0KPg0KPiBUaGUgUkxDIFNQTSBjb25maWd1cmF0aW9uIHJl
Z2lzdGVyIGNvbnRhaW5zIHRoZSBpbmZvcm1hdGlvbiBob3cgdGhlIG1lbW9yeSBhY2Nlc3MgaXMg
bWFkZSAoVk1JRCwgTVRZUEUsIGV0Yy4uLi4pIHdoaWNoIHNob3VsZCBhbHdheXMgYmUgY29uc2lz
dGVudC4NCj4NCj4gU28gaW5zdGVhZCBvZiBhIHJlYWQgbW9kaWZ5IHdyaXRlIGN5Y2xlIG9mIHRo
ZSBWTUlEIGFsd2F5cyB1cGRhdGUgdGhlIHdob2xlIHJlZ2lzdGVyLg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IC0tLQ0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgNyArLS0tLS0tICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jICB8IDcgKy0tLS0tLSAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyAgfCA3ICstLS0tLS0gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgIHwgNyArLS0tLS0tDQo+ICAgNCBmaWxlcyBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCj4gaW5kZXggMGEwM2UyYWQ1ZDk1Li4yYTY1NTYz
NzEwNDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBf
MC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQo+IEBA
IC03MDMwLDEyICs3MDMwLDcgQEAgc3RhdGljIGludCANCj4gZ2Z4X3YxMF8wX3VwZGF0ZV9nZnhf
Y2xvY2tfZ2F0aW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgIA0KPiAgIHN0YXRp
YyB2b2lkIGdmeF92MTBfMF91cGRhdGVfc3BtX3ZtaWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsIHVuc2lnbmVkIHZtaWQpICB7DQo+IC0JdTMyIGRhdGE7DQo+IC0NCj4gLQlkYXRhID0gUlJF
RzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19TUE1fTUNfQ05UTCk7DQo+IC0NCj4gLQlkYXRhICY9IH5S
TENfU1BNX01DX0NOVExfX1JMQ19TUE1fVk1JRF9NQVNLOw0KPiAtCWRhdGEgfD0gKHZtaWQgJiBS
TENfU1BNX01DX0NOVExfX1JMQ19TUE1fVk1JRF9NQVNLKSA8PCBSTENfU1BNX01DX0NOVExfX1JM
Q19TUE1fVk1JRF9fU0hJRlQ7DQo+ICsJdTMyIGRhdGEgPSBSRUdfU0VUX0ZJRUxEKDAsIFJMQ19T
UE1fTUNfQ05UTCwgUkxDX1NQTV9WTUlELCB2bWlkKTsNCj4gW3l0dGFvXTogVGhlIG9yaWdfdmFs
IGlzIDAgd2hpY2ggbWVhbnMgZXhjZXB0IFZNSUQgZmllbGQgb3RoZXIgcmVzZXQgZmllbGRzIHdp
bGwgYmUgc2V0IHRvIDAuIFdoZXRoZXIgaXQgaXMgbGVnYWw/DQoNCkFjY29yZGluZyB0byB0aGUg
cmVnaXN0ZXIgc3BlY2lmaWNhdGlvbiB0aGF0IGlzIHRoZSBkZWZhdWx0IHZhbHVlIGZvciB0aG9z
ZSBiaXRzIG9uIGdmeDkvMTAuDQoNCkNvdWxkIG9ubHkgYmUgdGhhdCB0aGUgZmlybXdhcmUgdXBk
YXRlcyB0aGUgYml0cyB0byBzb21ldGhpbmcgbm9uIGRlZmF1bHQsIEknbSBnb2luZyB0byBkb3Vi
bGUgY2hlY2sgdGhhdCBvbiBhIFZlZ2ExMC4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KPiAg
IA0KPiAgIAlXUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1NQTV9NQ19DTlRMLCBkYXRhKTsgIH0g
ZGlmZiAtLWdpdCANCj4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jIA0K
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmMNCj4gaW5kZXggYjJmMTBl
MzllZmYxLi5hOTI0ODZjZDAzOGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92N18wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y3XzAuYw0KPiBAQCAtMzU3MCwxMiArMzU3MCw3IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y3XzBfcmxj
X3Jlc3VtZShzdHJ1Y3QgDQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgDQo+ICAgc3RhdGlj
IHZvaWQgZ2Z4X3Y3XzBfdXBkYXRlX3NwbV92bWlkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCB1bnNpZ25lZCB2bWlkKSAgew0KPiAtCXUzMiBkYXRhOw0KPiAtDQo+IC0JZGF0YSA9IFJSRUcz
MihtbVJMQ19TUE1fVk1JRCk7DQo+IC0NCj4gLQlkYXRhICY9IH5STENfU1BNX1ZNSURfX1JMQ19T
UE1fVk1JRF9NQVNLOw0KPiAtCWRhdGEgfD0gKHZtaWQgJiBSTENfU1BNX1ZNSURfX1JMQ19TUE1f
Vk1JRF9NQVNLKSA8PCBSTENfU1BNX1ZNSURfX1JMQ19TUE1fVk1JRF9fU0hJRlQ7DQo+ICsJdTMy
IGRhdGEgPSBSRUdfU0VUX0ZJRUxEKDAsIFJMQ19TUE1fVk1JRCwgUkxDX1NQTV9WTUlELCB2bWlk
KTsNCj4gICANCj4gICAJV1JFRzMyKG1tUkxDX1NQTV9WTUlELCBkYXRhKTsNCj4gICB9DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIA0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMNCj4gaW5kZXggZmM2YzJmMmJjNzZj
Li40NGZkZGE2OGRiOTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OF8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAu
Yw0KPiBAQCAtNTYxMywxMiArNTYxMyw3IEBAIHN0YXRpYyB2b2lkIGdmeF92OF8wX3Vuc2V0X3Nh
ZmVfbW9kZShzdHJ1Y3QgDQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgDQo+ICAgc3RhdGlj
IHZvaWQgZ2Z4X3Y4XzBfdXBkYXRlX3NwbV92bWlkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCB1bnNpZ25lZCB2bWlkKSAgew0KPiAtCXUzMiBkYXRhOw0KPiAtDQo+IC0JZGF0YSA9IFJSRUcz
MihtbVJMQ19TUE1fVk1JRCk7DQo+IC0NCj4gLQlkYXRhICY9IH5STENfU1BNX1ZNSURfX1JMQ19T
UE1fVk1JRF9NQVNLOw0KPiAtCWRhdGEgfD0gKHZtaWQgJiBSTENfU1BNX1ZNSURfX1JMQ19TUE1f
Vk1JRF9NQVNLKSA8PCBSTENfU1BNX1ZNSURfX1JMQ19TUE1fVk1JRF9fU0hJRlQ7DQo+ICsJdTMy
IGRhdGEgPSBSRUdfU0VUX0ZJRUxEKDAsIFJMQ19TUE1fVk1JRCwgUkxDX1NQTV9WTUlELCB2bWlk
KTsNCj4gICANCj4gICAJV1JFRzMyKG1tUkxDX1NQTV9WTUlELCBkYXRhKTsNCj4gICB9DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIA0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4gaW5kZXggNTRlZGVkOWE2YWM1
Li5iMzZmYmY5OTEzMTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OV8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAu
Yw0KPiBAQCAtNDk1MCwxMiArNDk1MCw3IEBAIHN0YXRpYyBpbnQgDQo+IGdmeF92OV8wX3VwZGF0
ZV9nZnhfY2xvY2tfZ2F0aW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgIA0KPiAg
IHN0YXRpYyB2b2lkIGdmeF92OV8wX3VwZGF0ZV9zcG1fdm1pZChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwgdW5zaWduZWQgdm1pZCkgIHsNCj4gLQl1MzIgZGF0YTsNCj4gLQ0KPiAtCWRhdGEg
PSBSUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1NQTV9NQ19DTlRMKTsNCj4gLQ0KPiAtCWRhdGEg
Jj0gflJMQ19TUE1fTUNfQ05UTF9fUkxDX1NQTV9WTUlEX01BU0s7DQo+IC0JZGF0YSB8PSAodm1p
ZCAmIFJMQ19TUE1fTUNfQ05UTF9fUkxDX1NQTV9WTUlEX01BU0spIDw8IFJMQ19TUE1fTUNfQ05U
TF9fUkxDX1NQTV9WTUlEX19TSElGVDsNCj4gKwl1MzIgZGF0YSA9IFJFR19TRVRfRklFTEQoMCwg
UkxDX1NQTV9NQ19DTlRMLCBSTENfU1BNX1ZNSUQsIHZtaWQpOw0KPiAgIA0KPiAgIAlXUkVHMzJf
U09DMTUoR0MsIDAsIG1tUkxDX1NQTV9NQ19DTlRMLCBkYXRhKTsgIH0NCj4gLS0NCj4gMi4xNy4x
DQo+DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
