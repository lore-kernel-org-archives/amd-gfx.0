Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23FFC433E5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 11:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0B322D37
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 11:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZYrT6ZDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0B322D37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1AC66E8B0;
	Thu,  6 Aug 2020 10:32:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CC356E8B0
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 10:32:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IksI6XhBP7KQLZloqlhmAG34ImX8Q4+Gb0y2UbctCww3KGhWOSvMxYh7BrXAdGZ/CZtRnzjW1vV8F1Scu8PRLROHKlmz3MAvTJ2PI9TJu22cXa67TbctE5R9RXT9FP8+H9T6RR87gydjVfe6dmtSna/BXMbzEMQjQ5JWc2tLbh7+TfMzpMmL2CuoUOeoeVrea4Dlq2PXy4xGMi1YDFgfmLW3YCKYJnDHuEn+QiekFDGw+nI5ml26icjnaGPkV/nJvpdYKl70cJz/fMiEb8BUJM+kAQTUkhW5Gcgl+n1pAjTGnmyh2/RGUwYgRDGOKIVDudtOx3Wgxkjv0owlMeD5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShH1yR7Q02PiYdgjiNHIFMERBWSNswIiuf1L3ACBn8c=;
 b=afVh45PEdzKDaEq35eR0/tyLBK9XGmZBHTvereUIdPcMglf0M5vrQWy7+ke5tb/4h6XvzVQlNiK7ocxtVNVYaEU50Ue+84okHzOpOAWsCVQvFNhcDoUKHoqBbcj4HYqrKCVjU1uwSHD9NFDpf8WELeuR9wI9ET9rbmhcvovQZ3T0FYwVBUHM0TxWJSyq1KIYWOrXN4EJpOJlcByzGbEsYZBf/aB+VYdK+kXiYlBwVtRP13BsD9667mj/UqtSRCbBEMJYseb8ClRVLhDRygXtSTyRrevgfXHv4McnZ7zEm1J+evs79Hn7DA9N/pZwDLPbdIMh3/1nlVLyhVx13k/mcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShH1yR7Q02PiYdgjiNHIFMERBWSNswIiuf1L3ACBn8c=;
 b=ZYrT6ZDrAivowe9TtBvirCKLf9K3sZH1ettZ2K3ML5hzYmwESn5G31CIxgxQdQDTXNobf3V1p+sT46XsqfKoxIuYEC6SZxkbOfOabiEk5c5CkhwhCxGADS4LCTE2SqyIMHCpyjVwZ4TKOL1+tvo0hMmF0R9oujV55A8YrArYI2s=
Received: from MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 by BL0PR12MB2466.namprd12.prod.outlook.com (2603:10b6:207:4e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Thu, 6 Aug
 2020 10:32:55 +0000
Received: from MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::ad86:4e5e:66b8:3045]) by MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::ad86:4e5e:66b8:3045%8]) with mapi id 15.20.3239.022; Thu, 6 Aug 2020
 10:32:55 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: update driver if file for
 sienna_cichlid
Thread-Topic: [PATCH] drm/amd/powerplay: update driver if file for
 sienna_cichlid
Thread-Index: AQHWa9X3snjFjXWUCEO3i9MfIKLnHKkraFSA
Date: Thu, 6 Aug 2020 10:32:55 +0000
Message-ID: <A4B25907-0FAF-4E6B-A308-0284F3E9857F@amd.com>
References: <20200806094238.2022133-1-likun.gao@amd.com>
In-Reply-To: <20200806094238.2022133-1-likun.gao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=421e7950-4acc-426d-8733-0000844c4575;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-06T10:32:12Z; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [101.88.135.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc712616-2bcf-467f-5797-08d839f414c6
x-ms-traffictypediagnostic: BL0PR12MB2466:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2466D6ED46FC0B9E5A7287258E480@BL0PR12MB2466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FN+NfMR4EB/ZUWyOHn8nNBrPppMcfUbrVRMP+3fIlofV8r2boJ0QiWE5InGGYXHK7FwMo1461gaboRZjDzReroxk/rjOqh4RmNd/yJh/OV5XcN50PhMWpHsm7U5WyORF1X/bsw98P5Uj2mxyW8ZUFJDPOOfxpOc5GWrPIW4r310Vz9BdEOlcwgVKSqQ4hZjrZcdpz0dzG5VY2xgUxr62iTSDLL4FnVxltWTJ4TCNVx/3pFPi7B9B45TKkhsPNWy/aMGwLyUO8+/Lga9fyBiqzOy4v6qn8tOwz7puUwSWmFfcNuBwdXU1+UXqJhGo/URwljOSW5Ie3DMzai9E2kxUkQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4175.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(6512007)(83380400001)(36756003)(478600001)(2616005)(186003)(2906002)(26005)(15650500001)(5660300002)(91956017)(76116006)(66446008)(64756008)(66556008)(66476007)(6506007)(8676002)(6486002)(33656002)(8936002)(86362001)(316002)(66946007)(4326008)(110136005)(54906003)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: pPiBN/G03/Cg9Ij0Ba+ENNJh/YNzC7DGk4AWFocp1SMxlgFrUo2PqAvGNYlE639bnafYSIWjRretMNJ6nO0Y5lSAq0yc4C7XmyZzTp9FsKf1YwdIctEAGmmaL+s/YugMKiHACt+0IFB98WlaTe7alvZqY/qME3FKVwNcfuB7+8ynU579Hvug1hyKXN/NzGaGlMuYQiiuHlOwMZWNeTsP73spiZKjxll1eYBztSyS4xJsS6IUCexoE0+sb1t/QmZ+JaDLNHkOrNwtfoOOmCIQxhYRYv7/9aE2MGMk0B3VvmBYDVadTSNvlWIumWkrQKQdCxDEPQiVZUmiSgvLpT4gAxzit/IkvERl2w+dfF9Lk1vzPTEyHDdFR7AagSCTmCUj2CPTka6DXGMxya/8WAHE/ZpJ+f5YFfIPWnfLBz/23HDA6YfVt+9YO2x3lXGKSMPH4ijbZ+xNUZlkB7LWqjOdQrmcTOAV+sx+QiKoJV3w9YYBZsIcs9REtCxF6O38BFoNtgOZgISFVQI14DuTFLyUDTzCcJwU++Fh7e7knHLoYnrSO1W6DAeYQtiyKMyTUFRU+D9A5fXZwlUCEN3dU8KvD0on8iiReQuf3rlSDklQc2YJu4ho1YaHbrlFU2m3c3oRqoyrEy8r9ObDwfidLzfZpw==
Content-ID: <E5FCD3C196E5304989AE51092F4BA18C@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4175.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc712616-2bcf-467f-5797-08d839f414c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 10:32:55.5236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1UbQomdnzot1Bl4BfCtNBaLb8EkkbTPrctHZ1X9/Mi9SFs4JHmcrUYON273QCqK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2466
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
Cc: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpS
ZXZpZXdlZC1ieTogS2VubmV0aCBGZW5nIDxrZW5uZXRoLmZlbmdAYW1kLmNvbT4NCg0KDQrvu7/l
nKggMjAyMC84LzYg5LiL5Y2INTo0Mu+8jOKAnEdhbywgTGlrdW7igJ08TGlrdW4uR2FvQGFtZC5j
b20+IOWGmeWFpToNCg0KICAgIEZyb206IExpa3VuIEdhbyA8TGlrdW4uR2FvQGFtZC5jb20+DQoN
CiAgICBVcGRhdGUgZHJpdmUgaWYgZmlsZSBmb3Igc2llbm5hX2NpY2hsaWQuDQoNCiAgICBTaWdu
ZWQtb2ZmLWJ5OiBMaWt1biBHYW8gPExpa3VuLkdhb0BhbWQuY29tPg0KICAgIENoYW5nZS1JZDog
SWY0MDU0NjFjZmJlMDEzM2NlYjYxZmExMjMyNzJiMmU1M2RiOTk3NTUNCiAgICAtLS0NCiAgICAg
Li4uL2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXUxMV9kcml2ZXJfaWZfc2llbm5hX2NpY2hsaWQu
aCAgfCA2ICsrKy0tLQ0KICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211
X3YxMV8wLmggICAgICAgICAgICAgICB8IDIgKy0NCiAgICAgMiBmaWxlcyBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCiAgICBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3NtdTExX2RyaXZlcl9pZl9zaWVubmFfY2ljaGxpZC5o
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3NtdTExX2RyaXZlcl9pZl9zaWVu
bmFfY2ljaGxpZC5oDQogICAgaW5kZXggYWEyNzA4ZmNjYjZkLi41ZWY5YzkyZjU3YzQgMTAwNjQ0
DQogICAgLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3NtdTExX2RyaXZl
cl9pZl9zaWVubmFfY2ljaGxpZC5oDQogICAgKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvaW5jL3NtdTExX2RyaXZlcl9pZl9zaWVubmFfY2ljaGxpZC5oDQogICAgQEAgLTI3LDcg
KzI3LDcgQEANCiAgICAgLy8gKioqIElNUE9SVEFOVCAqKioNCiAgICAgLy8gU01VIFRFQU06IEFs
d2F5cyBpbmNyZW1lbnQgdGhlIGludGVyZmFjZSB2ZXJzaW9uIGlmDQogICAgIC8vIGFueSBzdHJ1
Y3R1cmUgaXMgY2hhbmdlZCBpbiB0aGlzIGZpbGUNCiAgICAtI2RlZmluZSBTTVUxMV9EUklWRVJf
SUZfVkVSU0lPTiAweDM0DQogICAgKyNkZWZpbmUgU01VMTFfRFJJVkVSX0lGX1ZFUlNJT04gMHgz
NQ0KDQogICAgICNkZWZpbmUgUFBUQUJMRV9TaWVubmFfQ2ljaGxpZF9TTVVfVkVSU0lPTiA1DQoN
CiAgICBAQCAtMTI3LDcgKzEyNyw3IEBADQogICAgICNkZWZpbmUgRkVBVFVSRV9ERl9DU1RBVEVf
QklUICAgICAgICAgICA0NQ0KICAgICAjZGVmaW5lIEZFQVRVUkVfMl9TVEVQX1BTVEFURV9CSVQg
ICAgICAgNDYNCiAgICAgI2RlZmluZSBGRUFUVVJFX1NNTkNMS19EUE1fQklUICAgICAgICAgIDQ3
DQogICAgLSNkZWZpbmUgRkVBVFVSRV9TUEFSRV80OF9CSVQgICAgICAgICAgICA0OA0KICAgICsj
ZGVmaW5lIEZFQVRVUkVfUEVSTElOS19HTUlET1dOX0JJVCAgICAgNDgNCiAgICAgI2RlZmluZSBG
RUFUVVJFX0dGWF9FRENfQklUICAgICAgICAgICAgIDQ5DQogICAgICNkZWZpbmUgRkVBVFVSRV9T
UEFSRV81MF9CSVQgICAgICAgICAgICA1MA0KICAgICAjZGVmaW5lIEZFQVRVUkVfU1BBUkVfNTFf
QklUICAgICAgICAgICAgNTENCiAgICBAQCAtMTY5LDcgKzE2OSw3IEBAIHR5cGVkZWYgZW51bSB7
DQogICAgICNkZWZpbmUgRFBNX09WRVJSSURFX0RJU0FCTEVfREZMTF9QTExfU0hVVERPV04gICAg
ICAgMHgwMDAwMDIwMA0KICAgICAjZGVmaW5lIERQTV9PVkVSUklERV9ESVNBQkxFX01FTU9SWV9U
RU1QRVJBVFVSRV9SRUFEIDB4MDAwMDA0MDANCiAgICAgI2RlZmluZSBEUE1fT1ZFUlJJREVfRElT
QUJMRV9WT0xUX0xJTktfVkNOX0RDRUZDTEsgICAweDAwMDAwODAwDQogICAgLSNkZWZpbmUgRFBN
X09WRVJSSURFX0RJU0FCTEVfRkFTVF9GQ0xLX1RJTUVSICAgICAgICAgMHgwMDAwMTAwMA0KICAg
ICsjZGVmaW5lIERQTV9PVkVSUklERV9FTkFCTEVfRkFTVF9GQ0xLX1RJTUVSICAgICAgICAgIDB4
MDAwMDEwMDANCiAgICAgI2RlZmluZSBEUE1fT1ZFUlJJREVfRElTQUJMRV9WQ05fUEcgICAgICAg
ICAgICAgICAgICAweDAwMDAyMDAwDQogICAgICNkZWZpbmUgRFBNX09WRVJSSURFX0RJU0FCTEVf
Rk1BWF9WTUFYICAgICAgICAgICAgICAgMHgwMDAwNDAwMA0KDQogICAgZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXVfdjExXzAuaCBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXVfdjExXzAuaA0KICAgIGluZGV4IDZhNDIzMzFhYmE4
YS4uNzM3YjZkMTQzNzJjIDEwMDY0NA0KICAgIC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2luYy9zbXVfdjExXzAuaA0KICAgICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2luYy9zbXVfdjExXzAuaA0KICAgIEBAIC0zMCw3ICszMCw3IEBADQogICAgICNkZWZp
bmUgU01VMTFfRFJJVkVSX0lGX1ZFUlNJT05fTlYxMCAweDM2DQogICAgICNkZWZpbmUgU01VMTFf
RFJJVkVSX0lGX1ZFUlNJT05fTlYxMiAweDMzDQogICAgICNkZWZpbmUgU01VMTFfRFJJVkVSX0lG
X1ZFUlNJT05fTlYxNCAweDM2DQogICAgLSNkZWZpbmUgU01VMTFfRFJJVkVSX0lGX1ZFUlNJT05f
U2llbm5hX0NpY2hsaWQgMHgzNA0KICAgICsjZGVmaW5lIFNNVTExX0RSSVZFUl9JRl9WRVJTSU9O
X1NpZW5uYV9DaWNobGlkIDB4MzUNCiAgICAgI2RlZmluZSBTTVUxMV9EUklWRVJfSUZfVkVSU0lP
Tl9OYXZ5X0Zsb3VuZGVyIDB4Mw0KDQogICAgIC8qIE1QIEFwZXJ0dXJlcyAqLw0KICAgIC0tDQog
ICAgMi4yNS4xDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
