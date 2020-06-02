Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161EEC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 12:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE652053B
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 12:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F9ObOihy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE652053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C7C96E1EE;
	Tue,  2 Jun 2020 12:34:30 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760047.outbound.protection.outlook.com [40.107.76.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 606316E1EE
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 12:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxtB/Gtrgx2UJyDqTSDrTfzZ+Qkmx60NZTqxks8dNgPbNhd0rbl+MxrHlFrN6udjCHw1W3x60DiJqXfGHGZEaCvlAZ1xltHWXzloe3W/BzS3PJ/yN7HY52yGNSPpEa1jrw23cxR+84783nBgwe2Hn5qTONQrhtbxupp9nPNbR4dBr0YDfWbgse5LdfF1Hg8FZ2npYd1fF7M+WzD3EvAD1sLwIfW5EV0aoQU2qpdKANMOlyoin0XCB2ATYikZimrPuoNPQGsONb5UByDuwl4DvGf10PGC/e2gCZwFqvX1y51Zm7u7RS9HOagf+oF0sZcOsxnrC6DPTHIyBpgFOZUZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsnuvzVHJK6X4P02wDttScBkBHs4+cXqlqNP+Wk6QGQ=;
 b=nRZbulJIBPF0gtGeSj59DSu7VevjEOWJj7sSlEXT8CnqdA1l88luPi6yz1qnWTvvzYvy7mV5v9yE4KP/+warwrrcefJfmpeWNbCFzNbMgEvMFsHoReVwE1OBHUF9NxzmArlCw/yhUKBEiXf0Ihgn1lG5STmXV0gvLRk8pmXdEkdduozf4Wcs4B2OXIzu/pbn6KDwfqh1XMC/IYxbXS8TKAJqKUHv3i+VSkBIq1ioLTqv4b8bN3youHUVXi3Eefqol8DsBUQAGXJwW804tt8GMiDQJfvqsFh0fooQ9wB5hCdqUM62G7S60V+RNASZ0tzdrUtghleJmk8DUy80lUbzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsnuvzVHJK6X4P02wDttScBkBHs4+cXqlqNP+Wk6QGQ=;
 b=F9ObOihyDz9Jr3GgFlpTzmOrXXo+W1rgywD3BV4TdvybiwQW9CXaCGm6LkkFEyulJr+Hypcsu+eSzBmoLSakUOcOVF8IlhK8ZCHNo5GcxZwvcrdiadG5yJ3sCr/Qdg20iODn+17HGKCMoS9ni/d4aDh7w1P7VD0mEfB9rbzT1E0=
Received: from DM6PR12MB3500.namprd12.prod.outlook.com (2603:10b6:5:11d::16)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 2 Jun
 2020 12:34:28 +0000
Received: from DM6PR12MB3500.namprd12.prod.outlook.com
 ([fe80::81ca:e163:cc2f:5216]) by DM6PR12MB3500.namprd12.prod.outlook.com
 ([fe80::81ca:e163:cc2f:5216%4]) with mapi id 15.20.3066.018; Tue, 2 Jun 2020
 12:34:28 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBkcm0vYW1kZ3B1L3NyaW92OiBEaXNhYmxlIHBtIGZv?=
 =?gb2312?Q?r_multiple_vf_sriov?=
Thread-Topic: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
Thread-Index: AQHWONRHOcIppdIJ50ObNi5qBLFWX6jFO1MAgAAEhsA=
Date: Tue, 2 Jun 2020 12:34:28 +0000
Message-ID: <DM6PR12MB350083730A045D351FF41F49E98B0@DM6PR12MB3500.namprd12.prod.outlook.com>
References: <1591098822-12353-1-git-send-email-Emily.Deng@amd.com>
 <BY5PR12MB41158534A80BB0A0D3DC328F8F8B0@BY5PR12MB4115.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB41158534A80BB0A0D3DC328F8F8B0@BY5PR12MB4115.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0f8d91d1-4103-43d1-9ad8-00004b637f65;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-02T12:08:15Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a78a4ab-aec1-4ca6-b71d-08d806f14acc
x-ms-traffictypediagnostic: DM6PR12MB4155:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB41552F75A45005A754BD3698E98B0@DM6PR12MB4155.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QwEpuebrkzJdcAaxHnWM8oZAmn2VhXhAp32sWx2ZFK/taqohOGZ8kZKdGqMRKSgHbvfd6i8ANuQlKocseAblMjE6L62MNTnlLh1suBmfkJYpgkIi8yU6O/Z0RjhNQZlebFZ0XULgzcpX23OcRb5XACk+rYjgRMG0v7UGbfRuZlvT5UDndLgn0qR5oiadR/7IwRp/EH5/DSRz46I/w3hHq5/p4/FbruzMyaghooX0dBynB4hZ4+bXWv3vXm3AbAgDzL1Nd1HZD0dl/bd85eMWoIj2PkcIAN27pufVuKtByd69LBwHZzf1ZhJEIUzNRD+1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3500.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(8936002)(316002)(6506007)(7696005)(71200400001)(66446008)(64756008)(52536014)(5660300002)(55016002)(86362001)(66946007)(66476007)(66556008)(76116006)(33656002)(9686003)(2906002)(186003)(224303003)(26005)(478600001)(110136005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: lOl0w/pe7kOBWGwx54yqUqWsPQmIhFN70pI1mvBCYKKTldTfAyFDsQ90MK5SQgKqqGYo5uoZPfe3CioL8A1r80pqUWyPi9Ea6thyTSRAeobtTTYISlC7A52+MfUsF7JLCJw6V1gf/Pl/yG1UcfJOD0S2m8v+Oh6AS0W86PeHIKydEz0Bj8XnybZZ03UDUGlC/mRQB5zgycg05MHFrLAdljqXpvNxdLBKAHNUjmxe2rULnNHo3fSkSYDOxIcKAPdj6bhl62WBuFIX2u1R+Ws2gT++1316QQ+KRS2AdjNNFopbcwKFAiGW9OU0CAJgia2Z1CW20635KrDEpTWatmsXBg8fkyq2xIDAm7lMVSepu2Bryaw/FRMGQirENACQKxhS+UTzIyXeyDLU8U57vAj6JRbLKa6SMM1EqHN8E2GKJ6v945qQ0VIpBGY+m0LvpbVfrV75tIXYf+GpPEf/UYS2jibMTsMG6Q6oo0ff3rWshL3AlW3t1lrifk3+2Pqds4LT
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a78a4ab-aec1-4ca6-b71d-08d806f14acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 12:34:28.4470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVTvaYjQd7laZD08RaGhrlmu9RX/kk9UYiOLIoPqhTKZaKE981ucP4WNR/7vP+Tk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSBFbWlseSwNCkhvdyBhYm91dCB0byBtb3ZlIGl0IGludG8gc211X2h3X2luaXQoKT8NCg0KQmVz
dCBSZWdhcmRzLA0KRnJhbmsNCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IERlbmcsIEVt
aWx5IDxFbWlseS5EZW5nQGFtZC5jb20+DQq3osvNyrG85DogMjAyMMTqNtTCMsjVIDIwOjA4DQrK
1bz+yMs6IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0Ks63LzTogTWluLCBGcmFuayA8RnJhbmsuTWluQGFtZC5jb20+DQrW98zi
OiBSRTogW1BBVENIXSBkcm0vYW1kZ3B1L3NyaW92OiBEaXNhYmxlIHBtIGZvciBtdWx0aXBsZSB2
ZiBzcmlvdg0KDQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9u
IE9ubHldDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVtaWx5IERlbmcg
PEVtaWx5LkRlbmdAYW1kLmNvbT4NCj5TZW50OiBUdWVzZGF5LCBKdW5lIDIsIDIwMjAgNzo1NCBQ
TQ0KPlRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPkNjOiBEZW5nLCBFbWlseSA8
RW1pbHkuRGVuZ0BhbWQuY29tPg0KPlN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdS9zcmlvdjog
RGlzYWJsZSBwbSBmb3IgbXVsdGlwbGUgdmYgc3Jpb3YNCj4NCj5DaGFuZ2UtSWQ6IEljMDEwNDQw
ZWY2MjVmNmYyOWU5MWYyNjdhNmYyODRmOWI2NTU0ZTFmDQo+U2lnbmVkLW9mZi1ieTogRW1pbHkg
RGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPg0KPi0tLQ0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAzICsrKw0KPiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspDQo+DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYw0KPmIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
DQo+aW5kZXggYjYzMzE3MTIuLmZjYmQ4NzUgMTAwNjQ0DQo+LS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jDQo+QEAgLTIwMDQsNiArMjAwNCw5IEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X2RldmljZV9pcF9pbml0KHN0cnVjdA0KPmFtZGdwdV9kZXZpY2UgKmFkZXYpICBpZiAo
YW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KPmFtZGdwdV92aXJ0X2luaXRfZGF0YV9leGNoYW5nZShh
ZGV2KTsNCj4NCj4raWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJiAhYW1kZ3B1X3NyaW92X2lz
X3BwX29uZV92ZihhZGV2KSkNCj4rYWRldi0+c211LnBtX2VuYWJsZWQgPSAwOw0KPisNCj4gciA9
IGFtZGdwdV9pYl9wb29sX2luaXQoYWRldik7DQo+IGlmIChyKSB7DQo+IGRldl9lcnIoYWRldi0+
ZGV2LCAiSUIgaW5pdGlhbGl6YXRpb24gZmFpbGVkICglZCkuXG4iLCByKTsNCj4tLQ0KPjIuNy40
DQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
