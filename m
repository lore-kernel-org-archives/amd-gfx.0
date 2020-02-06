Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AFFC33CAC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 18:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CAC24658
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 18:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="crH+3fDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CAC24658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 647766E13C;
	Thu,  6 Feb 2020 18:00:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3691B6E13C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 18:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yg1CyPp8ppxyqMR3mcAMzvBIcIXwYsDR0ezL2ou6wYbp2kt7zQB72l0LKS9p+VPbj3d8XssbeJxi1hp7nI4YhxhWbGXQNe5rb2V6S6CpMTsGBZgpl/1sJNahZAIO1EYKpmrO4D2IFJGgm1TxjAa8X/8Q2X3I6sq/TpUarxKkgSNkX5a6ynKFPciIeK8NUQH4NHJguMmInLg3VjTOr+7nS0BJcDUtzXzJ7Syoxn3BEZeCkEneJdpZfjiXgjfCdvPbluZ3bOj6fe3Zsv/zL1k+fDP2ykMLYUCSAwgcu3kYRu23A6C6lCMphW22qOFyAw7i7bChD1F8M9VwlOcU93cg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPzz+hXxeqHWe49BlHK6GZEZdS395jybks7ObEWaDDU=;
 b=ImEAyEwddmXu5qFs4Ykx+v4bHEanXq7GYbsXWpNeoSAgoUSRTVcNEcSD3GvVFMCl2Ysa+gkMLN2CHFPm0nMTC0rw39wKsSq3lCoPzemqbqPF9lIUq2rsO4tbKWbCWMH+lM9RCPTkySkbCmOG+g2cY/HSoRWy1ez2E5/dKMDFDUdBtOT8mSKiHdW4QzEuDualQ8HRDB6xOfK47x9i+yiDtRIKY0vlDX5jNGJ+ijqRjQDFsP1lhWREwd9tu4MqgA0AYtf1zLnnDuZpkLBqrTe7sol1dZFBVzyeEoFGWErZXzhAWyuic8skRudvZnvQPCcpecmQxaSQAJLCnqgTGPYTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPzz+hXxeqHWe49BlHK6GZEZdS395jybks7ObEWaDDU=;
 b=crH+3fDZ/iRSfPNyKhEaMLM1tFnV9vALGaTtcvk96XjjsaFRUsrSSLnrdnBH289rzu/S/KCodDYAsuf3esGH5kauNebFVyWjoDkn7LHjsxXy88S88BB/kN8NQL9MgaCTkeSAdgf2Nbx2iM1dOvVQGJTvcZrkaTj9ZrQU3X2wXWU=
Received: from DM6PR12MB3372.namprd12.prod.outlook.com (20.178.30.203) by
 DM6PR12MB4027.namprd12.prod.outlook.com (10.255.175.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Thu, 6 Feb 2020 18:00:04 +0000
Received: from DM6PR12MB3372.namprd12.prod.outlook.com
 ([fe80::dd81:9c2:53dd:9f3f]) by DM6PR12MB3372.namprd12.prod.outlook.com
 ([fe80::dd81:9c2:53dd:9f3f%6]) with mapi id 15.20.2686.034; Thu, 6 Feb 2020
 18:00:04 +0000
From: "Tawfik, Aly" <Aly.Tawfik@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [Dali] Raven 2 detection Patch
Thread-Topic: [Dali] Raven 2 detection Patch
Thread-Index: AdXcNMo4A9jV9vPHRUCOiC3R46hBTQALqySAACzhXiA=
Date: Thu, 6 Feb 2020 18:00:04 +0000
Message-ID: <DM6PR12MB3372AC10F1C908918A672AAC811D0@DM6PR12MB3372.namprd12.prod.outlook.com>
References: <DM6PR12MB33724602207E1D3B7839A4EF81020@DM6PR12MB3372.namprd12.prod.outlook.com>
 <CADnq5_Pb904Z_=4zcVkQHBpBghV-zevorL9q_zwHgL5JP57ypw@mail.gmail.com>
In-Reply-To: <CADnq5_Pb904Z_=4zcVkQHBpBghV-zevorL9q_zwHgL5JP57ypw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8a614251-0e53-44f8-ae8a-000006b8368d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-06T17:58:07Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Aly.Tawfik@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e8cb023-2198-4a1e-e399-08d7ab2e64ed
x-ms-traffictypediagnostic: DM6PR12MB4027:|DM6PR12MB4027:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4027522C3D4215004F1BC3F7811D0@DM6PR12MB4027.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(199004)(189003)(53546011)(6506007)(186003)(55016002)(54906003)(81166006)(8676002)(8936002)(81156014)(316002)(7696005)(9686003)(26005)(33656002)(5660300002)(52536014)(4326008)(66476007)(66446008)(66556008)(64756008)(66616009)(2906002)(76116006)(66946007)(6916009)(478600001)(86362001)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4027;
 H:DM6PR12MB3372.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bbdVmtxHkn8V+xRmGa2k9bTkzD9y74HL5Eu9u47N4tFiQCRApA6wcDrz55GbSGzvu1O7DTYfuVlbCgahXSLtJMDd2IVb9VHzIsn6s+u4cWIWl+lKQ3WSUYF+Lyk7WnRFicA96YaIqIagPWPawsvtzIbTqU6u2+HDQGVTxoBCCDM1nFOnKeAcRpXuSU9CziNHIWgomXO3S1QOoswwDtpTXxy7qd9guhMca9mR3fWdwi4SEr1BNnwN3pW3TSndjHgLpia0Yn+S7pWqj0xZPlpk6oxonqNMCgf8hNKW8Al83pwfcJLch9PGf/AEKJxiWF1azG0klNpQ2q3VGsGyMGVKNcmUhsjK5GNU9HawKT1C8Pl8fdJ6qBjA42oxl22zbIL0SdiX0fytW/g7L5MYo7U8NPh3Vlt66H0LUZJNpD5ZqGurAFXOwQkUHBZytVTDcxmZ
x-ms-exchange-antispam-messagedata: eECwGO6h0HOzA6e4sSS3yMFYjQnFA7RPCi5ao6k5LAbANqWNL5SaFJ8MCy4oO8US6ahTWd201Lbvi9WjlpZw3N7N4GDFmtB4w1EHjstaHgF8r7gL3YG1HhWRNiqqrYbJsY4YvR9MXCFSDdxWs3ZlSQ==
Content-Type: multipart/mixed;
 boundary="_002_DM6PR12MB3372AC10F1C908918A672AAC811D0DM6PR12MB3372namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8cb023-2198-4a1e-e399-08d7ab2e64ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 18:00:04.4153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbsgFdF1geyhkc3DgnNYNQKFPzQehhpjAN5uaQEalUk7PV8tCOgEbvwC4VuONhnm+rSlyLIxwzm5oqGzCPbbRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4027
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu,
 Michael" <Michael.Chiu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_002_DM6PR12MB3372AC10F1C908918A672AAC811D0DM6PR12MB3372namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoqKipSZWF0dGFjaGVkIHBhdGNoIHdpdGggY29ycmVjdGlvbnMqKioNCg0KRnJvbSBiODI4YTJi
M2RmMzA1NzQ2MWRmY2ViNGQxMzk0ZmU4NThjZWQ5ZDAzIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAw
MQ0KRnJvbTogQWxpLVRhd2ZpayA8YWx0YXdmaWtAYW1kLmNvbT4NCkRhdGU6IFRodSwgNiBGZWIg
MjAyMCAxMjo1MzowMiAtMDUwMA0KU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBbREFMSV0g
RGFsaSBWYXJpYW50IERldGVjdGlvbg0KDQpQcm9ibGVtIERlc2NyaXB0aW9uOg0KDQpDdXJyZW50
bHkgd2UgYXJlIGNoZWNraW5nIGludGVybmFsIGZ1c2VkIHJldiBpZCB3aXRoIHBjaSByZXYgaWQu
IEhvd2V2ZXIsIGZ1c2VkIGludGVybmFsIHJldiBpZCBpcyB0aGUgc2FtZSBvbiBhbGwgcmF2ZW4y
IHBhcnRzIChpbiB3aGljaCBEYWxpIHdhcyBiYXNlZCBvbiB0b28pLCB0aHVzIERhbGkgZGV0ZWN0
aW9uIGZhaWxzDQoNCkZpeDoNCg0KVG8gZGV0ZWN0IHRoaXMgY2hpcCB3ZSBuZWVkIHRvIHVzZSBw
Y2kgcmV2IGlkIGJ1dCBpdCBpcyBub3QgZGVmaW5lZCBpbiB0aGUNCnNjb3BlIG9mIERDLiBUbyB3
b3JrYXJvdW5kIHRoaXMgaXNzdWUgYWx0ZXIgdGhlIGZ1c2VkDQpyZXYgaWQgdXNpbmcgcGNpZSBp
ZCBmb3IgYWxsIGRhbGkgY2hpcHMgYmVmb3JlIERDIGluaXQsDQp0aGVuIHVzZSB0aGUgaW50ZXJu
YWwgZnVzZWQgaWQgZm9yIGNoaXAgZGV0ZWN0aW9uIGluIERDLg0KDQpTaWduZWQtb2ZmLWJ5OiBB
bGktVGF3ZmlrIDxhbHRhd2Zpa0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc29jMTUuYyAgICAgICAgICAgICAgICB8IDkgKysrKysrKystDQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvZGFsX2FzaWNfaWQuaCB8IDQgKystLQ0KIDIgZmlsZXMg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zb2MxNS5jDQppbmRleCAzMTc4MDNmNmE1NjEuLmY4NWMyN2ZiZTY0YyAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCkBAIC0xMDk0LDggKzEwOTQsMTUgQEAgc3RhdGlj
IGludCBzb2MxNV9jb21tb25fZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpDQogCQlicmVhazsNCiAJ
Y2FzZSBDSElQX1JBVkVOOg0KIAkJYWRldi0+YXNpY19mdW5jcyA9ICZzb2MxNV9hc2ljX2Z1bmNz
Ow0KLQkJaWYgKGFkZXYtPnJldl9pZCA+PSAweDgpDQorCQlpZiAoYWRldi0+cmV2X2lkID49IDB4
OCkgew0KKwkJCWlmICgoYWRldi0+cGRldi0+ZGV2aWNlID09IDB4MTVkOCkgJiYNCisJCQkJICgo
YWRldi0+cGRldi0+cmV2aXNpb24gPT0gMHhDRikgfHwNCisJCQkJIChhZGV2LT5wZGV2LT5yZXZp
c2lvbiA9PSAweEUzKXx8DQorCQkJCSAoYWRldi0+cGRldi0+cmV2aXNpb24gPT0gMHhFNCkpKSB7
DQorCQkJCWFkZXYtPnJldl9pZCA9IDB4MTA7DQorCQkJfQ0KIAkJCWFkZXYtPmV4dGVybmFsX3Jl
dl9pZCA9IGFkZXYtPnJldl9pZCArIDB4Nzk7DQorCQl9DQogCQllbHNlIGlmIChhZGV2LT5wZGV2
LT5kZXZpY2UgPT0gMHgxNWQ4KQ0KIAkJCWFkZXYtPmV4dGVybmFsX3Jldl9pZCA9IGFkZXYtPnJl
dl9pZCArIDB4NDE7DQogCQllbHNlIGlmIChhZGV2LT5yZXZfaWQgPT0gMSkNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9kYWxfYXNpY19pZC5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvZGFsX2FzaWNfaWQuaA0KaW5kZXggYTI5
MDM5ODViOWU4Li4wMzI5ZjI2YmZhY2QgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvaW5jbHVkZS9kYWxfYXNpY19pZC5oDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvaW5jbHVkZS9kYWxfYXNpY19pZC5oDQpAQCAtMTQzLDYgKzE0Myw3IEBADQogI2Rl
ZmluZSBSQVZFTjJfMTVEOF9SRVZfRUIgMHhFQg0KICNkZWZpbmUgUkFWRU4xX0YwIDB4RjANCiAj
ZGVmaW5lIFJBVkVOX1VOS05PV04gMHhGRg0KKyNkZWZpbmUgUkFWRU4yXzE1RDhfQjBfTFcgMHg4
OQ0KICNpZm5kZWYgQVNJQ1JFVl9JU19SQVZFTg0KICNkZWZpbmUgQVNJQ1JFVl9JU19SQVZFTihl
Q2hpcFJldikgKChlQ2hpcFJldiA+PSBSQVZFTl9BMCkgJiYgZUNoaXBSZXYgPCBSQVZFTl9VTktO
T1dOKQ0KICNlbmRpZg0KQEAgLTE1Miw4ICsxNTMsNyBAQA0KICNkZWZpbmUgQVNJQ1JFVl9JU19S
QVZFTjIoZUNoaXBSZXYpICgoZUNoaXBSZXYgPj0gUkFWRU4yX0EwKSAmJiAoZUNoaXBSZXYgPCBS
QVZFTjFfRjApKQ0KICNlbmRpZg0KICNkZWZpbmUgQVNJQ1JFVl9JU19SVjFfRjAoZUNoaXBSZXYp
ICgoZUNoaXBSZXYgPj0gUkFWRU4xX0YwKSAmJiAoZUNoaXBSZXYgPCBSQVZFTl9VTktOT1dOKSkN
Ci0jZGVmaW5lIEFTSUNSRVZfSVNfREFMSShlQ2hpcFJldikgKChlQ2hpcFJldiA9PSBSQVZFTjJf
MTVEOF9SRVZfRTMpIFwNCi0JCXx8IChlQ2hpcFJldiA9PSBSQVZFTjJfMTVEOF9SRVZfRTQpKQ0K
KyNkZWZpbmUgQVNJQ1JFVl9JU19EQUxJKGVDaGlwUmV2KSAoKGVDaGlwUmV2ID09IFJBVkVOMl8x
NUQ4X0IwX0xXKSkNCiAjZGVmaW5lIEFTSUNSRVZfSVNfUE9MTE9DSyhlQ2hpcFJldikgKGVDaGlw
UmV2ID09IFJBVkVOMl8xNUQ4X1JFVl85NCBcDQogCQl8fCBlQ2hpcFJldiA9PSBSQVZFTjJfMTVE
OF9SRVZfOTUgXA0KIAkJCXx8IGVDaGlwUmV2ID09IFJBVkVOMl8xNUQ4X1JFVl9FOSBcDQotLSAN
CjIuMTcuMQ0KDQo=

--_002_DM6PR12MB3372AC10F1C908918A672AAC811D0DM6PR12MB3372namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-DALI-Dali-Variant-Detection.patch"
Content-Description: 0001-drm-amdgpu-DALI-Dali-Variant-Detection.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-DALI-Dali-Variant-Detection.patch"; size=2748;
	creation-date="Thu, 06 Feb 2020 17:59:41 GMT";
	modification-date="Thu, 06 Feb 2020 17:59:41 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiODI4YTJiM2RmMzA1NzQ2MWRmY2ViNGQxMzk0ZmU4NThjZWQ5ZDAzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGktVGF3ZmlrIDxhbHRhd2Zpa0BhbWQuY29tPgpEYXRlOiBU
aHUsIDYgRmViIDIwMjAgMTI6NTM6MDIgLTA1MDAKU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1
OiBbREFMSV0gRGFsaSBWYXJpYW50IERldGVjdGlvbgoKUHJvYmxlbSBEZXNjcmlwdGlvbjoKCkN1
cnJlbnRseSB3ZSBhcmUgY2hlY2tpbmcgaW50ZXJuYWwgZnVzZWQgcmV2IGlkIHdpdGggcGNpIHJl
diBpZC4gSG93ZXZlciwgZnVzZWQgaW50ZXJuYWwgcmV2IGlkIGlzIHRoZSBzYW1lIG9uIGFsbCBy
YXZlbjIgcGFydHMgKGluIHdoaWNoIERhbGkgd2FzIGJhc2VkIG9uIHRvbyksIHRodXMgRGFsaSBk
ZXRlY3Rpb24gZmFpbHMKCkZpeDoKClRvIGRldGVjdCB0aGlzIGNoaXAgd2UgbmVlZCB0byB1c2Ug
cGNpIHJldiBpZCBidXQgaXQgaXMgbm90IGRlZmluZWQgaW4gdGhlCnNjb3BlIG9mIERDLiBUbyB3
b3JrYXJvdW5kIHRoaXMgaXNzdWUgYWx0ZXIgdGhlIGZ1c2VkCnJldiBpZCB1c2luZyBwY2llIGlk
IGZvciBhbGwgZGFsaSBjaGlwcyBiZWZvcmUgREMgaW5pdCwKdGhlbiB1c2UgdGhlIGludGVybmFs
IGZ1c2VkIGlkIGZvciBjaGlwIGRldGVjdGlvbiBpbiBEQy4KClNpZ25lZC1vZmYtYnk6IEFsaS1U
YXdmaWsgPGFsdGF3ZmlrQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
c29jMTUuYyAgICAgICAgICAgICAgICB8IDkgKysrKysrKystCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvaW5jbHVkZS9kYWxfYXNpY19pZC5oIHwgNCArKy0tCiAyIGZpbGVzIGNoYW5nZWQs
IDEwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nv
YzE1LmMKaW5kZXggMzE3ODAzZjZhNTYxLi5mODVjMjdmYmU2NGMgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc29jMTUuYwpAQCAtMTA5NCw4ICsxMDk0LDE1IEBAIHN0YXRpYyBpbnQgc29jMTVfY29t
bW9uX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQogCQlicmVhazsKIAljYXNlIENISVBfUkFWRU46
CiAJCWFkZXYtPmFzaWNfZnVuY3MgPSAmc29jMTVfYXNpY19mdW5jczsKLQkJaWYgKGFkZXYtPnJl
dl9pZCA+PSAweDgpCisJCWlmIChhZGV2LT5yZXZfaWQgPj0gMHg4KSB7CisJCQlpZiAoKGFkZXYt
PnBkZXYtPmRldmljZSA9PSAweDE1ZDgpICYmCisJCQkJICgoYWRldi0+cGRldi0+cmV2aXNpb24g
PT0gMHhDRikgfHwKKwkJCQkgKGFkZXYtPnBkZXYtPnJldmlzaW9uID09IDB4RTMpfHwKKwkJCQkg
KGFkZXYtPnBkZXYtPnJldmlzaW9uID09IDB4RTQpKSkgeworCQkJCWFkZXYtPnJldl9pZCA9IDB4
MTA7CisJCQl9CiAJCQlhZGV2LT5leHRlcm5hbF9yZXZfaWQgPSBhZGV2LT5yZXZfaWQgKyAweDc5
OworCQl9CiAJCWVsc2UgaWYgKGFkZXYtPnBkZXYtPmRldmljZSA9PSAweDE1ZDgpCiAJCQlhZGV2
LT5leHRlcm5hbF9yZXZfaWQgPSBhZGV2LT5yZXZfaWQgKyAweDQxOwogCQllbHNlIGlmIChhZGV2
LT5yZXZfaWQgPT0gMSkKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9p
bmNsdWRlL2RhbF9hc2ljX2lkLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVk
ZS9kYWxfYXNpY19pZC5oCmluZGV4IGEyOTAzOTg1YjllOC4uMDMyOWYyNmJmYWNkIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9kYWxfYXNpY19pZC5oCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNsdWRlL2RhbF9hc2ljX2lkLmgKQEAg
LTE0Myw2ICsxNDMsNyBAQAogI2RlZmluZSBSQVZFTjJfMTVEOF9SRVZfRUIgMHhFQgogI2RlZmlu
ZSBSQVZFTjFfRjAgMHhGMAogI2RlZmluZSBSQVZFTl9VTktOT1dOIDB4RkYKKyNkZWZpbmUgUkFW
RU4yXzE1RDhfQjBfTFcgMHg4OQogI2lmbmRlZiBBU0lDUkVWX0lTX1JBVkVOCiAjZGVmaW5lIEFT
SUNSRVZfSVNfUkFWRU4oZUNoaXBSZXYpICgoZUNoaXBSZXYgPj0gUkFWRU5fQTApICYmIGVDaGlw
UmV2IDwgUkFWRU5fVU5LTk9XTikKICNlbmRpZgpAQCAtMTUyLDggKzE1Myw3IEBACiAjZGVmaW5l
IEFTSUNSRVZfSVNfUkFWRU4yKGVDaGlwUmV2KSAoKGVDaGlwUmV2ID49IFJBVkVOMl9BMCkgJiYg
KGVDaGlwUmV2IDwgUkFWRU4xX0YwKSkKICNlbmRpZgogI2RlZmluZSBBU0lDUkVWX0lTX1JWMV9G
MChlQ2hpcFJldikgKChlQ2hpcFJldiA+PSBSQVZFTjFfRjApICYmIChlQ2hpcFJldiA8IFJBVkVO
X1VOS05PV04pKQotI2RlZmluZSBBU0lDUkVWX0lTX0RBTEkoZUNoaXBSZXYpICgoZUNoaXBSZXYg
PT0gUkFWRU4yXzE1RDhfUkVWX0UzKSBcCi0JCXx8IChlQ2hpcFJldiA9PSBSQVZFTjJfMTVEOF9S
RVZfRTQpKQorI2RlZmluZSBBU0lDUkVWX0lTX0RBTEkoZUNoaXBSZXYpICgoZUNoaXBSZXYgPT0g
UkFWRU4yXzE1RDhfQjBfTFcpKQogI2RlZmluZSBBU0lDUkVWX0lTX1BPTExPQ0soZUNoaXBSZXYp
IChlQ2hpcFJldiA9PSBSQVZFTjJfMTVEOF9SRVZfOTQgXAogCQl8fCBlQ2hpcFJldiA9PSBSQVZF
TjJfMTVEOF9SRVZfOTUgXAogCQkJfHwgZUNoaXBSZXYgPT0gUkFWRU4yXzE1RDhfUkVWX0U5IFwK
LS0gCjIuMTcuMQoK

--_002_DM6PR12MB3372AC10F1C908918A672AAC811D0DM6PR12MB3372namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_002_DM6PR12MB3372AC10F1C908918A672AAC811D0DM6PR12MB3372namp_--
