Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE7EC2D0E2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 13:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5541620719
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 13:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YTW19GmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5541620719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D6D6E86E;
	Tue, 22 Sep 2020 13:56:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCD3E6E86E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 13:56:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXVRPphqZZyyM9lIpH6yqpxcDRe0TqYEKGD507oPTlE8w6HGKwW6REyTs3olDmyyAt8IJcdXPzVR0S9oGrflj/IIJbSL50OJCcItsOH2htYO5m3Q5ubiUQwMwn2gSMiCI4/pO9Rv6oVmuqw/BipYACgyA4DizineIyf+cLFonJDP7komSiyF56BEXIXrSveiPGseEO4pd5WRHchvX6WgSxCfVkd+ulygzJAOBw7eMPr314b0rad47Qma9EXNB5oOewuI6CP+nnOfx3CxlHor9m9ngVH33AdR5wnriwxjWxz54Ojt64m0tXOoeDnl/Dl3TJx931Nlm2C4FWYlqx+kTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwgmEj6e6gsJsb0KZ3T2LsJRgWV/B1tbTZfQ4RMmQU0=;
 b=RIEgMHKPaUAGa4fEF8XQr64poJXk46qBw+7UYj9stHGn97XkWJwkk+2D+7SEc0/IbY80fvGJO75lVy8OD+p51o7ZeH+a3u6JEr7GnMepO1fJbRGSwAZZWDU6IZLlYXkE9WURxs5KZwIVe1ooYrwPFg3YzeKIj7opNgTEH+Rq7Ry4jELSWX7DYK9DWtPRRrVLqzM80ToHE3T5fEbqefKFIl/x4riJm9IPJkzDU2tSflbPIMInN1XZQk3QB2wslSC0UHTqR/XDfGssPiJ6sUT1a+xFU4L0BJJQCW21fCva68KCwRXcN+g+zVeIjPRHjEsGV1qbuMeMQ4KDbwEyfcRY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwgmEj6e6gsJsb0KZ3T2LsJRgWV/B1tbTZfQ4RMmQU0=;
 b=YTW19GmIYDOmKB6RkRTBj45NEzS3Nh3kAUybWQRkiq5xyNUUH7ky8Trc9narcyZx4eWO+TfCx3B0E3DazCLVUbxAW4Ff68exiKR2L4o3xaIOYm2klXEQtPSzKpiPlkgFpu8fDWhMHOA5TULK12Lh/gQ5IqHyOQXYaH/KFZAPY8E=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB2778.namprd12.prod.outlook.com (2603:10b6:5:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 22 Sep
 2020 13:56:25 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 13:56:24 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix wanting in print statement
Thread-Topic: [PATCH] drm/amdkfd: fix wanting in print statement
Thread-Index: AQHWkF0S4ZbUek2vxkGaUWHudWtbmalznLSAgAEStsA=
Date: Tue, 22 Sep 2020 13:56:24 +0000
Message-ID: <DM6PR12MB3721639FE926748D47E245F2853B0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200921212026.364094-1-alexander.deucher@amd.com>
 <CADnq5_M58bpM9WjFbM9NrmhwVVwtzyvFGC-3ev5J=kHaLBfs4Q@mail.gmail.com>
In-Reply-To: <CADnq5_M58bpM9WjFbM9NrmhwVVwtzyvFGC-3ev5J=kHaLBfs4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-22T13:56:22Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a8cb3c41-c247-4a9c-8b8e-0000c80112ba;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-22T13:56:16Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: c0e836f1-757d-4acd-882f-00001704c9d1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-22T13:56:22Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 28c484c9-3c45-40cb-8fb2-0000ccd9208a
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1c80:6680:9dce:1d67:cc43:ab08]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3df78f21-0f7a-4120-6a93-08d85eff4b79
x-ms-traffictypediagnostic: DM6PR12MB2778:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB27788C721DB6833477564ECD853B0@DM6PR12MB2778.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G7Dtr1sEx+FiwkyJM0xJUSPKxFfgO595Xow4FjcSZIdzQhRRrM2OCWKiZbZ+isVHxepZToM7wHlA6QpMMoMTfVAv1sfle6ekxm2cA82/dh/I9NtBbsiuZAhHB1AiFQFELTJ3JSo7A0Tm56OZhicqKnmi12tCkGJkTPaDA/gneqXRcMwTKpYWj/2qRj8rdvumlIUFenYZBCUaB/ERvhvmymxr3AJZtJ/ZJ1A5l8orAemNZL1QdB6k6CfiLRb7AAKf7FvyXcQaY4DFCa1lTfcrEfbp/0c/I+D7n4WeLBZfUO4SFTEyhGf4IOCUbPsjF0eXAv6v7MWcn1Pk+H+VKwU5ShVoapRWhaHgd4GRSkW4K7c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(8676002)(186003)(64756008)(66946007)(66476007)(66556008)(478600001)(966005)(76116006)(45080400002)(55016002)(8936002)(2906002)(66446008)(86362001)(110136005)(4326008)(71200400001)(6506007)(53546011)(52536014)(33656002)(83380400001)(9686003)(5660300002)(7696005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: bjkwDW0Mya0T7PpUdRtn4QBlYlqVnl7mwpuz/l5ji6hpO95y2O/UKFQfh3xkHv4onvqbZyONCP3GmbfDLluwPO7ApiHmCXhjM4VkxmaL32q+BBBzmKTkQlnEVmEtn4mv/ldFyubvgogovbZl/F1XLhd+nTggtDeZ31BmgxzcX2POqcFOmI5B40qmNCmJIsDfD4tDhtDr7hNiD1rZ/04nc/Q7ePhmLGGj5/8nX7wXQ/UERO1bPzoe1y7PSbcTHb7D38xuay7/eQPoJ8KxxRJuTCgzO99gIUSEUsbTgwjajJPRvpjIHVpNJ9qOdYdaZf+fruER7Dh0MhQLy+FFUlzNSK9GDo9GOTHyTBhnwoJjcbSq5DsgWrhpB5v78WbRQC07y7sohUH+ZS5VtrTv67TFSGia8oNYHuRUjhWSSvyCJa49+OVtbPdbC+073mvVkj94wMvhUMA1wMq9YdHMkj2JfRBg7+Wd0UOXp5+SM9IcqYUMk1ScZOIzIbXmpU3zeKTW5A6GIDqwSxv3Sjt5sPnxctmkkLug5zsSiLjOxKaqB7/y+jEuba+UzZoibx5C3tZrddJUZMwZfnZ0I3KzO2sUZDgrBqi8SJrcyoSDYXd5cxTkC6rKF1kmKrWg+L3DT8Uder7Iyk8ksSTf+B4J6NWgaWXwo2NwPACQFNx1pfAScmvtl4QVc2I1DGURkU8s+QHASUkero5fhJ6/9yAbiPjPaw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df78f21-0f7a-4120-6a93-08d85eff4b79
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 13:56:24.7245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+6mvPz0x+xISWstAnlN0NJuzpOCSztbV2BhmnJr3Z5i6J0gUW/liBQeaBFAgQ+oWvVxjeEoHuuRxrZatSIxyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2778
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpUaGFua3MgQWxleCwgc29ycnkgYWJvdXQgdGhhdCENCg0KIEtl
bnQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQt
Z2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleCBEZXVj
aGVyDQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDIxLCAyMDIwIDU6MzMgUE0NCj4gVG86IGFt
ZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQo+IENjOiBEZXVjaGVy
LCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRrZmQ6IGZpeCB3YW50aW5nIGluIHByaW50IHN0YXRlbWVudA0KPiANCj4g
Indhcm5pbmciIGluIHByaW50IHN0YXRlbWVudC4gIEZpeGVkIGxvY2FsbHkuDQo+IA0KPiBPbiBN
b24sIFNlcCAyMSwgMjAyMCBhdCA1OjIwIFBNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21h
aWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Ft
ZGtmZC9rZmRfY3JhdC5jOiBJbiBmdW5jdGlvbg0KPiDigJhrZmRfY3JlYXRlX2NyYXRfaW1hZ2Vf
dmlydHVhbOKAmToNCj4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9hbWRrZmQva2Zk
X2NyYXQuYzoxMzkxOjEyOiB3YXJuaW5nOiBmb3JtYXQg4oCYJWTigJkNCj4gZXhwZWN0cyBhcmd1
bWVudCBvZiB0eXBlIOKAmGludOKAmSwgYnV0IGFyZ3VtZW50IDMgaGFzIHR5cGUg4oCYc2l6ZV90
4oCZIHtha2Eg4oCYbG9uZyB1bnNpZ25lZCBpbnTigJl9IFstDQo+IFdmb3JtYXQ9XQ0KPiA+ICAx
MzkxIHwgICBwcl9kZWJ1ZygiQ1JBVCBzaXplIGlzICVkIiwgZHluX3NpemUpOw0KPiA+ICAgICAg
IHwgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fg0KPiA+IC4vaW5jbHVkZS9saW51eC9wcmlu
dGsuaDoyOTc6MjE6IG5vdGU6IGluIGRlZmluaXRpb24gb2YgbWFjcm8g4oCYcHJfZm104oCZDQo+
ID4gICAyOTcgfCAjZGVmaW5lIHByX2ZtdChmbXQpIGZtdA0KPiA+ICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICBefn4NCj4gPiAuL2luY2x1ZGUvbGludXgvZHluYW1pY19kZWJ1Zy5oOjE0Mzoy
OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8NCj4g4oCYX19keW5hbWljX2Z1bmNfY2FsbOKA
mQ0KPiA+ICAgMTQzIHwgIF9fZHluYW1pY19mdW5jX2NhbGwoX19VTklRVUVfSUQoZGRlYnVnKSwg
Zm10LCBmdW5jLCAjI19fVkFfQVJHU19fKQ0KPiA+ICAgICAgIHwgIF5+fn5+fn5+fn5+fn5+fn5+
fn4NCj4gPiAuL2luY2x1ZGUvbGludXgvZHluYW1pY19kZWJ1Zy5oOjE1MzoyOiBub3RlOiBpbiBl
eHBhbnNpb24gb2YgbWFjcm8NCj4g4oCYX2R5bmFtaWNfZnVuY19jYWxs4oCZDQo+ID4gICAxNTMg
fCAgX2R5bmFtaWNfZnVuY19jYWxsKGZtdCwgX19keW5hbWljX3ByX2RlYnVnLCAgXA0KPiA+ICAg
ICAgIHwgIF5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+IC4vaW5jbHVkZS9saW51eC9wcmludGsuaDo0
MjA6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmGR5bmFtaWNfcHJfZGVidWfigJkN
Cj4gPiAgIDQyMCB8ICBkeW5hbWljX3ByX2RlYnVnKGZtdCwgIyNfX1ZBX0FSR1NfXykNCj4gPiAg
ICAgICB8ICBefn5+fn5+fn5+fn5+fn5+DQo+ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vYW1ka2ZkL2tmZF9jcmF0LmM6MTM5MTozOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8N
Cj4g4oCYcHJfZGVidWfigJkNCj4gPiAgMTM5MSB8ICAgcHJfZGVidWcoIkNSQVQgc2l6ZSBpcyAl
ZCIsIGR5bl9zaXplKTsNCj4gPiAgICAgICB8ICAgXn5+fn5+fn4NCj4gPiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS8uLi9hbWRrZmQva2ZkX2NyYXQuYzoxMzkxOjI3OiBub3RlOiBmb3JtYXQg
c3RyaW5nIGlzDQo+IGRlZmluZWQgaGVyZQ0KPiA+ICAxMzkxIHwgICBwcl9kZWJ1ZygiQ1JBVCBz
aXplIGlzICVkIiwgZHluX3NpemUpOw0KPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgIH5eDQo+ID4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50DQo+ID4gICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICAgJWxkDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfY3JhdC5jDQo+ID4gaW5kZXggYzUwZTlmNjM0ZDZjLi5kMjk4MTUyNGRiYTAgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMNCj4gPiBAQCAtMTM4
OCw3ICsxMzg4LDcgQEAgaW50IGtmZF9jcmVhdGVfY3JhdF9pbWFnZV92aXJ0dWFsKHZvaWQgKipj
cmF0X2ltYWdlLCBzaXplX3QNCj4gKnNpemUsDQo+ID4gICAgICAgICAgICAgICAgIGlmICghcGNy
YXRfaW1hZ2UpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+
ID4gICAgICAgICAgICAgICAgICpzaXplID0gZHluX3NpemU7DQo+ID4gLSAgICAgICAgICAgICAg
IHByX2RlYnVnKCJDUkFUIHNpemUgaXMgJWQiLCBkeW5fc2l6ZSk7DQo+ID4gKyAgICAgICAgICAg
ICAgIHByX2RlYnVnKCJDUkFUIHNpemUgaXMgJWxkIiwgZHluX3NpemUpOw0KPiA+ICAgICAgICAg
ICAgICAgICByZXQgPSBrZmRfY3JlYXRlX3ZjcmF0X2ltYWdlX2NwdShwY3JhdF9pbWFnZSwgc2l6
ZSk7DQo+ID4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgICAgY2FzZSBDT01QVVRF
X1VOSVRfR1BVOg0KPiA+IC0tDQo+ID4gMi4yNS40DQo+ID4NCj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4g
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0
b3Aub3INCj4gZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC0NCj4gZ2Z4JmFtcDtkYXRhPTAy
JTdDMDElN0NrZW50LnJ1c3NlbGwlNDBhbWQuY29tJTdDNjExZmMyNTczNWUwNDFmYmQzZDcwOGQ4
NWU3NQ0KPiBlMzU1JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3
QzYzNzM2MzIwNzcyMTczNzc2NiZhbXA7DQo+IHNkYXRhPUJ2TVJDUFlLMFd1WFRKQW90Tk1GZkc3
bEJuMnQ0ZFlvZ0RVb1JaUXJUZEElM0QmYW1wO3Jlc2VydmVkPTANCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
