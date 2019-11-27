Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30792C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 12:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087282064B
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 12:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087282064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A549289268;
	Wed, 27 Nov 2019 12:04:12 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770043.outbound.protection.outlook.com [40.107.77.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2641A89268
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 12:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQ5PF4QnfomAXrrEjqoKfnWZSd5Ppb9o0U+OHKlPiT9TILuRf57Oi49uq+DMagp/zrVon/tCGd5PNXXI5bdV4BpKd96ZqTgD4vNWGNhqVA1f6YcRl5Gl+ntJMPyVpXlRHZqfNfw08DM95hlk0scZgVHmOQjpS9QJXlpQL3gJ3jcrdx1dgVRPSF86WZbT2dkI9dYgBelj1y+T5hEjAhkNKfnAuN0iKY1S+XIDTruM7Ki7I6jTXc1j9PaWqqIMmGvWRVQdtmtLm13KiFY7/bh+M0UNYXacCBgZ+mEAf53CpdzWfktCp9TaWkKascME6pHv4Sm00Fnk+gpqBrHGZce4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twrCbu7/S14TZtAJi7AoijJNRgnSW/cvXAw4371aRAo=;
 b=MglkLHfY08b+9LNf5V8tQi6IMYnGUYg/usa5NFRYwX+wDmjstRXkeRZF3q3tz/8uHwEtxbgMtuM/FI5mazGWl3PA2pfHJqbgAUaPLn6G/r9/E3/0kSipB5GTxefRVHIEJKnYJRG0+xh5di2LJ2A8+2ZDh68ASNRdUTJ1JjgUxuq9DI8b12FEaC/VvL5U3wapG0fxXcNxaGQCEImxGsxU8EHKQU1tVUyAvsQCoKzaXQizamD+rheu/FbsEKMZL1gEQAN3dOmwwCEXa35RZzEfEURgKxC60hhm3qsQapXeTf43zQ6KXKCGjXj77shPSQugnQW4xZ7RTbcWYdLY09DXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1724.namprd12.prod.outlook.com (10.175.89.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Wed, 27 Nov 2019 12:04:08 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 12:04:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 05/10] drm/amdgpu: enable/disable doorbell interrupt in
 baco entry/exit helper
Thread-Topic: [PATCH 05/10] drm/amdgpu: enable/disable doorbell interrupt in
 baco entry/exit helper
Thread-Index: AQHVpQNEoujZ8dS65kqoo430ifDjqaee6wvA
Date: Wed, 27 Nov 2019 12:04:07 +0000
Message-ID:
 <DM5PR12MB14184CF08E965BAF369F4249FC440@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-4-git-send-email-le.ma@amd.com>
In-Reply-To: <1574846129-4826-4-git-send-email-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-11-27T12:04:05Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bba7b64e-a35b-4685-8bb6-00007dff43d1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-11-27T12:04:05Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: da13e00b-e1cc-467f-88ac-00005229169d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d181c678-e1cc-46c3-c4ee-08d77331e835
x-ms-traffictypediagnostic: DM5PR12MB1724:|DM5PR12MB1724:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1724635A941E067892461999FC440@DM5PR12MB1724.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(13464003)(189003)(199004)(2906002)(186003)(6306002)(53546011)(6506007)(446003)(66066001)(99286004)(316002)(54906003)(3846002)(26005)(66476007)(66946007)(76116006)(4326008)(66556008)(64756008)(66446008)(6246003)(11346002)(110136005)(14454004)(102836004)(229853002)(81156014)(81166006)(33656002)(6436002)(52536014)(71190400001)(2501003)(25786009)(86362001)(76176011)(55016002)(256004)(790700001)(6116002)(7736002)(74316002)(9686003)(5660300002)(8676002)(54896002)(236005)(8936002)(7696005)(71200400001)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1724;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8UTNvGjsnxOhg6ZoFHhFHytynIM91Xn8Uhsy3rXBq0/GLBU37H9X688XA5tfIbSZYHmTV6FHAozjPTyrIret1anuIko1rVNl+bKJlPwrQqcxuHTxMYZpsVraOMlRM5fKnvJjwv1WEaI79Yu2hHRvERTMAc03GJ7zQUmX2aTYA7l+f6KxjHutl2UUO76IW9kC9lpHM+/yzunoDcYpdR3oPogmQiDvqHNZ8Z8eguYtI0II1aHcu0JY08f3y39CZyQTtGBQZ7ZhFl0Xo7fHGHTkkjFxeXHMuWDKTYvdfzZ0dAAgHXusfOo9o+6Vz3+fmkpRWCldO1zieHl7iWr7kksakqywtHOhWAN5u9JJvhbCyhRRuXBI6LOQQ5scNkGX3iKHVAPUgk61Hs3QCnvFGhI6UkWoAZm65CNxumWHSOjWMbFWjVIN0PsV3sJ+JjG0u0Ni
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d181c678-e1cc-46c3-c4ee-08d77331e835
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 12:04:07.9055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wVAgFOsME/vkW7B1TffefSrcs9INHzQ+9xUG2FmtoVs5/egb2s0Xz4tnT3lu5kQGbc4IOa6vUKGoU+8WdkVCvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1724
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twrCbu7/S14TZtAJi7AoijJNRgnSW/cvXAw4371aRAo=;
 b=d/HQL1u4yum+5vCAYQChxlpGc2dF6p73jneAsKY0f7chk/wdKQ9TO6+S6/LZsXUT3baFSlM6mS1+xlCLMH8DXKPSd1fu2CcIrr0p56jcrrh+9uqZN/oSXCXfBGCALqkWgTScxfEF1b/oIA6UGxp2+hlZUfKcnVy9sm2P1ulU27c=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Content-Type: multipart/mixed; boundary="===============1352113411=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127120407.uHYNUuWlslfqa2DCR4R8AfI_npLsBAo8QtN51VKQu9g@z>

--===============1352113411==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB14184CF08E965BAF369F4249FC440DM5PR12MB1418namp_"

--_000_DM5PR12MB14184CF08E965BAF369F4249FC440DM5PR12MB1418namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQoN
ClBsZWFzZSBjaGVjayBteSBjb21tZW50cyBpbmxpbmUNCg0KDQoNClJlZ2FyZHMsDQpIYXdraW5n
DQoNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGUgTWEgPGxlLm1hQGFt
ZC5jb20+DQpTZW50OiAyMDE5xOoxMdTCMjfI1SAxNzoxNQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQpDYzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47
IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT47IFpob3UxLCBUYW8gPFRhby5aaG91
MUBhbWQuY29tPjsgTGksIERlbm5pcyA8RGVubmlzLkxpQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBNYSwgTGUgPExlLk1hQGFtZC5jb20+
DQpTdWJqZWN0OiBbUEFUQ0ggMDUvMTBdIGRybS9hbWRncHU6IGVuYWJsZS9kaXNhYmxlIGRvb3Ji
ZWxsIGludGVycnVwdCBpbiBiYWNvIGVudHJ5L2V4aXQgaGVscGVyDQoNCg0KDQpUaGlzIG9wZXJh
dGlvbiBpcyBuZWVkZWQgd2hlbiBiYWNvIGVudHJ5L2V4aXQgZm9yIHJhcyByZWNvdmVyeQ0KDQoN
Cg0KQ2hhbmdlLUlkOiBJNTM1YzcyMzE2OTNmMzEzOGE4ZTNkNWFjZDU1NjcyZTJhYzY4MjMyZg0K
DQpTaWduZWQtb2ZmLWJ5OiBMZSBNYSA8bGUubWFAYW1kLmNvbTxtYWlsdG86bGUubWFAYW1kLmNv
bT4+DQoNCi0tLQ0KDQpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMg
fCAxOSArKysrKysrKysrKystLS0tLS0tDQoNCjEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25z
KCspLCA3IGRlbGV0aW9ucygtKQ0KDQoNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYw0KDQppbmRleCBiMTQwOGM1Li5iZDM4N2JiIDEwMDY0NA0KDQotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCg0KKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQoNCkBAIC00MzA4LDEwICs0MzA4
LDE0IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kZXZpY2VfZ2V0X3BjaWVfaW5mbyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikgIGludCBhbWRncHVfZGV2aWNlX2JhY29fZW50ZXIoc3RydWN0IGRy
bV9kZXZpY2UgKmRldikgIHsNCg0KICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYgPSBkZXYtPmRldl9wcml2YXRlOw0KDQorICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVf
cmFzICpyYXMgPSBhbWRncHVfcmFzX2dldF9jb250ZXh0KGFkZXYpOw0KDQoNCg0KICAgICAgICAg
ICAgICAgIGlmICghYW1kZ3B1X2RldmljZV9zdXBwb3J0c19iYWNvKGFkZXYtPmRkZXYpKQ0KDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9UU1VQUDsNCg0KDQoNCisg
ICAgICAgICAgICAgaWYgKHJhcyAmJiByYXMtPnN1cHBvcnRlZCkNCg0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rvb3JiZWxsX2ludGVycnVw
dChhZGV2LCBmYWxzZSk7DQoNCisNCg0KICAgICAgICAgICAgICAgaWYgKGlzX3N1cHBvcnRfc3df
c211KGFkZXYpKSB7DQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc211
X2NvbnRleHQgKnNtdSA9ICZhZGV2LT5zbXU7DQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQgcmV0Ow0KDQpAQCAtNDMxOSw4ICs0MzIzLDYgQEAgaW50IGFtZGdwdV9kZXZpY2Vf
YmFjb19lbnRlcihzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQ0KDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcmV0ID0gc211X2JhY29fZW50ZXIoc211KTsNCg0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGlmIChyZXQpDQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCg0KLQ0KDQotICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIDA7DQoNCiAgICAgICAgICAgICAgIH0gZWxzZSB7DQoNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpwcF9oYW5kbGUgPSBhZGV2LT5wb3dlcnBs
YXkucHBfaGFuZGxlOw0KDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3Ry
dWN0IGFtZF9wbV9mdW5jcyAqcHBfZnVuY3MgPSBhZGV2LT5wb3dlcnBsYXkucHBfZnVuY3M7IEBA
IC00MzMxLDE0ICs0MzMzLDE1IEBAIGludCBhbWRncHVfZGV2aWNlX2JhY29fZW50ZXIoc3RydWN0
IGRybV9kZXZpY2UgKmRldikNCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qIGVu
dGVyIEJBQ08gc3RhdGUgKi8NCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChw
cF9mdW5jcy0+c2V0X2FzaWNfYmFjb19zdGF0ZShwcF9oYW5kbGUsIDEpKQ0KDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlPOw0KDQotDQoN
Ci0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCg0KICAgICAgICAgICAg
ICAgfQ0KDQorDQoNCisgICAgICAgICAgICAgcmV0dXJuIDA7DQoNCn0NCg0KDQoNCiBpbnQgYW1k
Z3B1X2RldmljZV9iYWNvX2V4aXQoc3RydWN0IGRybV9kZXZpY2UgKmRldikgIHsNCg0KICAgICAg
ICAgICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBkZXYtPmRldl9wcml2YXRlOw0K
DQorICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfcmFzICpyYXMgPSBhbWRncHVfcmFzX2dldF9j
b250ZXh0KGFkZXYpOw0KDQoNCg0KICAgICAgICAgICAgICAgIGlmICghYW1kZ3B1X2RldmljZV9z
dXBwb3J0c19iYWNvKGFkZXYtPmRkZXYpKQ0KDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FTk9UU1VQUDsNCg0KQEAgLTQzNTEsNyArNDM1NCw2IEBAIGludCBhbWRncHVf
ZGV2aWNlX2JhY29fZXhpdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQ0KDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKHJldCkNCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KDQoNCg0KLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiAwOw0KDQogICAgICAgICAgICAgICB9IGVsc2Ugew0KDQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqcHBfaGFuZGxlID0gYWRldi0+cG93ZXJw
bGF5LnBwX2hhbmRsZTsNCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0
cnVjdCBhbWRfcG1fZnVuY3MgKnBwX2Z1bmNzID0gYWRldi0+cG93ZXJwbGF5LnBwX2Z1bmNzOyBA
QCAtNDM2Miw3ICs0MzY0LDEwIEBAIGludCBhbWRncHVfZGV2aWNlX2JhY29fZXhpdChzdHJ1Y3Qg
ZHJtX2RldmljZSAqZGV2KQ0KDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogZXhp
dCBCQUNPIHN0YXRlICovDQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAocHBf
ZnVuY3MtPnNldF9hc2ljX2JhY29fc3RhdGUocHBfaGFuZGxlLCAwKSkNCg0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsNCg0KLQ0KDQot
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQoNCiAgICAgICAgICAgICAg
IH0NCg0KKw0KDQorICAgICAgICAgICAgIGlmIChyYXMgJiYgcmFzLT5zdXBwb3J0ZWQpDQoNCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPm5iaW8uZnVuY3MtPmVuYWJsZV9kb29y
YmVsbF9pbnRlcnJ1cHQoYWRldiwgZmFsc2UpOw0KDQorDQoNCg0KDQoNCg0KW0hhd2tpbmddIFNo
b3VsZG4ndCBiZSBlbmFibGVkIGRvb3JiZWxsIGludGVycnVwdCBhZnRlciBleGl0IGJhY28/IE9y
IGRvIEkgbWlzcyBzb21ldGhpbmc/DQoNCg0KDQorICAgICAgICAgICAgIHJldHVybiAwOw0KDQp9
DQoNCi0tDQoNCjIuNy40DQoNCg0K

--_000_DM5PR12MB14184CF08E965BAF369F4249FC440DM5PR12MB1418namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:=B5=C8=CF=DF;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
span.EmailStyle21
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0cm;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:=CB=CE=
=CC=E5"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText">Please check my comments inline<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Regards,<br>
Hawking<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<br>
From: Le Ma &lt;le.ma@amd.com&gt; <br>
Sent: 2019<span lang=3D"ZH-CN" style=3D"font-family:=B5=C8=CF=DF">=C4=EA</s=
pan>11<span lang=3D"ZH-CN" style=3D"font-family:=B5=C8=CF=DF">=D4=C2</span>=
27<span lang=3D"ZH-CN" style=3D"font-family:=B5=C8=CF=DF">=C8=D5</span> 17:=
15<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Chen, Guchun &lt;Guchun.C=
hen@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Li, Dennis &lt;Denni=
s.Li@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Ma,=
 Le &lt;Le.Ma@amd.com&gt;<br>
Subject: [PATCH 05/10] drm/amdgpu: enable/disable doorbell interrupt in bac=
o entry/exit helper<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">This operation is needed when baco entry/exit for=
 ras recovery<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Change-Id: I535c7231693f3138a8e3d5acd55672e2ac682=
32f<o:p></o:p></p>
<p class=3D"MsoPlainText">Signed-off-by: Le Ma &lt;<a href=3D"mailto:le.ma@=
amd.com"><span style=3D"color:windowtext;text-decoration:none">le.ma@amd.co=
m</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">---<o:p></o:p></p>
<p class=3D"MsoPlainText">drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 &=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<o:p></o:=
p></p>
<p class=3D"MsoPlainText">1 file changed, 12 insertions(&#43;), 7 deletions=
(-)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_de=
vice.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
<p class=3D"MsoPlainText">index b1408c5..bd387bb 100644<o:p></o:p></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<=
o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdg=
pu_device.c<o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -4308,10 &#43;4308,14 @@ static void amdgpu_de=
vice_get_pcie_info(struct amdgpu_device *adev)&nbsp; int amdgpu_device_baco=
_enter(struct drm_device *dev)&nbsp; {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D dev-&gt;=
dev_private;<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *ras =3D amdgpu_ras_get_cont=
ext(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_supports_baco(=
adev-&gt;ddev))<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOTSUPP;<=
o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ras &amp;&amp; ras-&gt;supported)<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;e=
nable_doorbell_interrupt(adev, false);<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context=
 *smu =3D &amp;adev-&gt;smu;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p=
></p>
<p class=3D"MsoPlainText">@@ -4319,8 &#43;4323,6 @@ int amdgpu_device_baco_=
enter(struct drm_device *dev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_baco_e=
nter(smu);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p=
></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return ret;<o:p></o:p></p>
<p class=3D"MsoPlainText">-<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *pp_handle =
=3D adev-&gt;powerplay.pp_handle;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_p=
m_funcs *pp_funcs =3D adev-&gt;powerplay.pp_funcs; @@ -4331,14 &#43;4333,15=
 @@ int amdgpu_device_baco_enter(struct drm_device *dev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enter BACO stat=
e */<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs-&gt;s=
et_asic_baco_state(pp_handle, 1))<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EIO;<o:p></o:p></p>
<p class=3D"MsoPlainText">-<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">}<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&nbsp;int amdgpu_device_baco_exit(struct drm_devi=
ce *dev)&nbsp; {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D dev-&gt;=
dev_private;<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *ras =3D amdgpu_ras_get_cont=
ext(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_supports_baco(=
adev-&gt;ddev))<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOTSUPP;<=
o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -4351,7 &#43;4354,6 @@ int amdgpu_device_baco_=
exit(struct drm_device *dev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p=
></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return ret;<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *pp_handle =
=3D adev-&gt;powerplay.pp_handle;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_p=
m_funcs *pp_funcs =3D adev-&gt;powerplay.pp_funcs; @@ -4362,7 &#43;4364,10 =
@@ int amdgpu_device_baco_exit(struct drm_device *dev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* exit BACO state=
 */<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs-&gt;s=
et_asic_baco_state(pp_handle, 0))<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EIO;<o:p></o:p></p>
<p class=3D"MsoPlainText">-<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ras &amp;&amp; ras-&gt;supported)<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;e=
nable_doorbell_interrupt(adev, false);<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;<o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span style=3D"color:#2F5597">[Hawking] Shouldn't=
 be enabled doorbell interrupt after exit baco? Or do I miss something?<o:p=
></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">}<o:p></o:p></p>
<p class=3D"MsoPlainText">--<o:p></o:p></p>
<p class=3D"MsoPlainText">2.7.4<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM5PR12MB14184CF08E965BAF369F4249FC440DM5PR12MB1418namp_--

--===============1352113411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1352113411==--
