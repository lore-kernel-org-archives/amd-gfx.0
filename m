Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941A0C3F2D2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6784B246B4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V8icKE9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6784B246B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FEA66E209;
	Mon,  2 Mar 2020 09:30:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D316E207
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 09:30:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ijt7WCnRnikC6qzRVcq/ZYPKv1D8UKhCFTFfv4U2hc3ibp7EX+h523q6BlB+atlfNtkJ13hL7GZVEwm4sV3XTcM2PjSsHQY27HWjwDvAacC4w8Hk6ROQeD7Tpvd552fthy+fRp2nWn/Kcdt1MSotCrUX60zeT15FoTruH2hLIzpRXFOlMtDRjhZ7LCWTDNwVNGULkaGK75DOBk9SMhyUFFdDB1n9spfU3L2L91z7tk4Q9wyqHQlsObA9tqVznyFaPie6XQJ89IzHdb3rVaAvnyy1yNZYOO2q/mdOOSvtaFQhO7anHcJWJjiifDYbiI9CpdRMxoOk62+xX82c7oQm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NocDHcBpP//5u1y2zPLTQeEi8bX6HtMUpNLB9UF9z1A=;
 b=XfzdudDaMElBfEXeEf8AM+WoLryexGDg8lS2/hOe1b+fCyHzSqH+Q/9adefiB3IV6XUevZBBxNUO451SLOUd/wLF7JzxtcIPmo/VbZ903UVF53tpsYm/k7m3gb4mr8ga86tmv+XrWE9k5ZxPmsAy9XBjJVtlxOu6SRt8zj1fG4Evxzh6kVcayTSbZZMv72M57+32buI0PBCuDamqbqYah60Rfr2dmA8jfDTMeEbGeplA035ZnzT+BC1eodKa7GnZURjQ+W81JG7BDWp5sq7zRHZ4Py//7T2mgyV8gHa9fkxEISlftXuapaj8/xkpp040Xeo/UgrW4Xh8be65x2lWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NocDHcBpP//5u1y2zPLTQeEi8bX6HtMUpNLB9UF9z1A=;
 b=V8icKE9QW8A8CvilHdLrZEJ+N3TIDZ6DuEL/7diZ69XhiQ15pCRok19RdPGS6qrXSnHIxAeqQVN7RPDKg+jS2FVmIDDm4Y4XEWlLyXJrhSBz8KqKlQI0dYm5kSgzKhpiag/LCiwH45KXzbzKjz4Xw+93nYHNyq659Q0SMsH6QTU=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) by
 DM5PR12MB1321.namprd12.prod.outlook.com (2603:10b6:3:78::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Mon, 2 Mar 2020 09:30:05 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 09:30:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: don't use pipe1 of gfx10
Thread-Topic: [PATCH 2/3] drm/amdgpu: don't use pipe1 of gfx10
Thread-Index: AQHV8HQSiG/n8W0dx0uvGVzhfrMymKg1CU8Q
Date: Mon, 2 Mar 2020 09:30:05 +0000
Message-ID: <DM5PR12MB14181B0ADC4E78F78BF88590FCE70@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1583140927-19809-1-git-send-email-Monk.Liu@amd.com>
 <1583140927-19809-2-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1583140927-19809-2-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-02T09:30:01Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=cda4363c-4aa8-4a73-a156-0000ca7c1a45;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-02T09:30:01Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: aa934e4a-a337-45c1-b6ef-00008699498b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 117b306e-0850-4f5c-7a9b-08d7be8c4ab1
x-ms-traffictypediagnostic: DM5PR12MB1321:|DM5PR12MB1321:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB132190390F8347B5ABF92FDFFCE70@DM5PR12MB1321.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(199004)(189003)(9686003)(76116006)(66556008)(64756008)(66446008)(66476007)(6506007)(186003)(26005)(33656002)(7696005)(71200400001)(66946007)(55016002)(53546011)(4326008)(45080400002)(316002)(478600001)(86362001)(5660300002)(110136005)(52536014)(81166006)(81156014)(8676002)(8936002)(966005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1321;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YvDkFG8acH+wC3wYm1X8rw/371OmcSuTuLkZTJyK0dDs2Z0c2LvQ9Usj8WeWx818qcEyj3Wf/srPCHzPH1vSip4V3MF2HfZyzF2yUcxGaS1a+ydVFDdtNQBGOkgQ7CxtPjWhPE+pZ1qQD703P1xsKZltrQQRhgq8v9Xc6fIjFgkRQCtH/Pc4pXnW62IofZ4uBYb3hkAsrPs8hn65tfaNDBc0cGTY/8SjyBpBZJxseEcGrXnai6m+6qwLvTovix/9nEZXPQsKmYSmdR0+pd7ROKTBXAfP9X3UQTB3uMBmr7+jSQLUeOtXiCT995K+CMYD5DmCjLTegAV+bWcRdxPctD62UU8SJbOtMXKHIHxw8Oaw3Vvd2BkPWkuP5F6EtmVWRNNXHtlETL6W88hGipS0+U0g3xT9bPWM7tZjdywX7CodJl4YnDaHMmFV11hnNs8PL6AqA9FZeTx0gNxshwlHlG3TugGdq54qwAEwZTplzn8=
x-ms-exchange-antispam-messagedata: WBs3A+PhtY9IQj5w9RS/7U0lRsBUbIoErgOzhYL5T6VRcAT6LRsgGIMd1pFgRATDQAxJiOjSPec2HMw1nk6sz3DvVZIMWaOiBQGnYNMDSHXAucAxvMw2HJFJHeLuDkRJbdDbBurKJ8xNYwQEPPqlXQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117b306e-0850-4f5c-7a9b-08d7be8c4ab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 09:30:05.2479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/YAZD+M8vs2mPzF/oqYaIFt8Ky8LO+R6hioF+yNVFpGk/Ujpeo2KlMPE0Mmje3fI5UQ0owxSbT2OO3KLylOjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1321
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpU
aGlzIGhhcyBhbHJlYWR5IGRvbmUgYnkgVGlhbmNoaS4NCg0KUmVnYXJkcywNCkhhd2tpbmcNCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNl
c0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBNb25rIExpdQ0KU2VudDogTW9u
ZGF5LCBNYXJjaCAyLCAyMDIwIDE3OjIyDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCkNjOiBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggMi8z
XSBkcm0vYW1kZ3B1OiBkb24ndCB1c2UgcGlwZTEgb2YgZ2Z4MTANCg0Kd2hhdDoNCndlIGZvdW5k
IHNvbWV0aW1lcyBJRExFIGZhaWwgYWZ0ZXIgdmYgZ3Vlc3QgZmluaXNoZWQgSUIgdGVzdCBvbiBH
RlggcmluZzEgKHBpcGUxKQ0KDQp3aHk6DQpiZWxvdyBpcyB3aGF0IENQIHRlYW0gc3RhdGVkIChN
YW51KToNCkdGWCBQaXBlIDEgaXMgdGhlcmUgaW4gSFcsIGJ1dCBhcyBwYXJ0IG9mIG9wdGltaXph
dGlvbiBhbGwgZHJpdmVyIGRlY2lkZWQgbm90IHRvIHVzZSBwaXBlIDEgYXQgYWxsLCBvdGhlcndp
c2UgZHJpdmVyIGhhcyB0byBzYWNyaWZpY2UgY29udGV4dCBzbyBhbGwgNyBjb250ZXh0IHdpbGwg
bm90IGJlIGFibGUgZm9yIEdGWCBwaXBlIDAuIFRoYXTigJlzIHdoeSBJIHNraXAgc2V0dGluZyBv
ZiBzdGF0ZSBmb3IgZ2Z4IHBpcGUgMSBhcyBkZWNpZGVkIGJ5IGFsbCBkcml2ZXIgdGVhbQ0KDQpm
aXg6DQpzaW5jZSBDUCB0ZWFtIHdvbid0IGhlbHAgdXMgdG8gZGVidWcgYW55IGlzc3VlcyB0aGF0
IHJlbGF0ZWQgd2l0aCBnZnggcGlwZTEsIHNvIGJhc2VkIG9uIGFib3ZlIHJlYXNvbiwgbGV0J3Mg
c2tpcCBnZnggcmluZyAxIChwaXBlMSkgZXZlbiBmb3IgYm90aCBiYXJlLW1ldGFsIGFuZCBTUklP
Vg0KDQpTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgMjkgKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTEgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQppbmRleCAw
NTU1OTg5Li5hZmFlNGNjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3YxMF8wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5j
DQpAQCAtMTMwOCw3ICsxMzA4LDcgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfc3dfaW5pdCh2b2lk
ICpoYW5kbGUpDQogCWNhc2UgQ0hJUF9OQVZJMTQ6DQogCWNhc2UgQ0hJUF9OQVZJMTI6DQogCQlh
ZGV2LT5nZngubWUubnVtX21lID0gMTsNCi0JCWFkZXYtPmdmeC5tZS5udW1fcGlwZV9wZXJfbWUg
PSAyOw0KKwkJYWRldi0+Z2Z4Lm1lLm51bV9waXBlX3Blcl9tZSA9IDE7DQogCQlhZGV2LT5nZngu
bWUubnVtX3F1ZXVlX3Blcl9waXBlID0gMTsNCiAJCWFkZXYtPmdmeC5tZWMubnVtX21lYyA9IDI7
DQogCQlhZGV2LT5nZngubWVjLm51bV9waXBlX3Blcl9tZWMgPSA0Ow0KQEAgLTI3MTMsMTggKzI3
MTMsMjEgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfY3BfZ2Z4X3N0YXJ0KHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQ0KIA0KIAlhbWRncHVfcmluZ19jb21taXQocmluZyk7DQogDQotCS8qIHN1
Ym1pdCBjcyBwYWNrZXQgdG8gY29weSBzdGF0ZSAwIHRvIG5leHQgYXZhaWxhYmxlIHN0YXRlICov
DQotCXJpbmcgPSAmYWRldi0+Z2Z4LmdmeF9yaW5nWzFdOw0KLQlyID0gYW1kZ3B1X3JpbmdfYWxs
b2MocmluZywgMik7DQotCWlmIChyKSB7DQotCQlEUk1fRVJST1IoImFtZGdwdTogY3AgZmFpbGVk
IHRvIGxvY2sgcmluZyAoJWQpLlxuIiwgcik7DQotCQlyZXR1cm4gcjsNCi0JfQ0KKwlpZiAoYWRl
di0+Z2Z4Lm1lLm51bV9waXBlX3Blcl9tZSA9PSAyKSB7DQorCQkvKiBzdWJtaXQgY3MgcGFja2V0
IHRvIGNvcHkgc3RhdGUgMCB0byBuZXh0IGF2YWlsYWJsZSBzdGF0ZSAqLw0KKwkJcmluZyA9ICZh
ZGV2LT5nZnguZ2Z4X3JpbmdbMV07DQogDQotCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIFBBQ0tF
VDMoUEFDS0VUM19DTEVBUl9TVEFURSwgMCkpOw0KLQlhbWRncHVfcmluZ193cml0ZShyaW5nLCAw
KTsNCisJCXIgPSBhbWRncHVfcmluZ19hbGxvYyhyaW5nLCAyKTsNCisJCWlmIChyKSB7DQorCQkJ
RFJNX0VSUk9SKCJhbWRncHU6IGNwIGZhaWxlZCB0byBsb2NrIHJpbmcgKCVkKS5cbiIsIHIpOw0K
KwkJCXJldHVybiByOw0KKwkJfQ0KIA0KLQlhbWRncHVfcmluZ19jb21taXQocmluZyk7DQorCQlh
bWRncHVfcmluZ193cml0ZShyaW5nLCBQQUNLRVQzKFBBQ0tFVDNfQ0xFQVJfU1RBVEUsIDApKTsN
CisJCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIDApOw0KKw0KKwkJYW1kZ3B1X3JpbmdfY29tbWl0
KHJpbmcpOw0KKwl9DQogDQogCXJldHVybiAwOw0KIH0NCkBAIC0yODIyLDYgKzI4MjUsOSBAQCBz
dGF0aWMgaW50IGdmeF92MTBfMF9jcF9nZnhfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQ0KIAltdXRleF91bmxvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOw0KIA0KIAkvKiBJbml0IGdm
eCByaW5nIDEgZm9yIHBpcGUgMSAqLw0KKwlpZiAoYWRldi0+Z2Z4Lm1lLm51bV9waXBlX3Blcl9t
ZSA9PSAxKQ0KKwkJZ290byBkb19zdGFydDsNCisNCiAJbXV0ZXhfbG9jaygmYWRldi0+c3JibV9t
dXRleCk7DQogCWdmeF92MTBfMF9jcF9nZnhfc3dpdGNoX3BpcGUoYWRldiwgUElQRV9JRDEpOw0K
IAlyaW5nID0gJmFkZXYtPmdmeC5nZnhfcmluZ1sxXTsNCkBAIC0yODYwLDYgKzI4NjYsNyBAQCBz
dGF0aWMgaW50IGdmeF92MTBfMF9jcF9nZnhfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQ0KIAlnZnhfdjEwXzBfY3BfZ2Z4X3N3aXRjaF9waXBlKGFkZXYsIFBJUEVfSUQwKTsNCiAJ
bXV0ZXhfdW5sb2NrKCZhZGV2LT5zcmJtX211dGV4KTsNCiANCitkb19zdGFydDoNCiAJLyogc3Rh
cnQgdGhlIHJpbmcgKi8NCiAJZ2Z4X3YxMF8wX2NwX2dmeF9zdGFydChhZGV2KTsNCiANCi0tDQoy
LjcuNA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
YW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpodHRw
czovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4
JmFtcDtkYXRhPTAyJTdDMDElN0NoYXdraW5nLnpoYW5nJTQwYW1kLmNvbSU3QzdlN2RmYjE2ZWI1
MzQ0YzQzYmNjMDhkN2JlOGIzMmU0JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2Ql
N0MwJTdDMCU3QzYzNzE4NzM3NzM5MDk1OTE5MiZhbXA7c2RhdGE9MkdiNWFwS1phbkNmdmdiY2xL
TE8lMkJBQWJhc3hOYW1VZ3cwajU2N0hJJTJCQnMlM0QmYW1wO3Jlc2VydmVkPTANCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
