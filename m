Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE43C2D0C2
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 10:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E80C217F4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 10:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3L+5HJr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E80C217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B49D46E1BB;
	Fri,  3 Jan 2020 10:42:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A24D6E1BB
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 10:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuSFboKuIJG7qwWJWKQtvohwZOcqKRtDIB3iRO5N635SkHqF5gfQM3HEiBXvBNDyAXu42w5pi5OlN+sDvTKdPiMqlbheAIiEm32dv91+9z8kaHNWqiWrObAKhm9ESdmcERARjLczte3Y9Oydp2EhouisWiYw1jMPQXyNBtEq8BNHbboaoMT4AeJxCOTa2p5PHZKIQNCoPIbWFi5u3qIF/xAUuGmenYIomYxYer90y1079pZ1PBGFT6JgTrEQfSorkfAh6hqM5Uj0YH9lPazWTilBrIIOepRuIqiiZ//quqCkCQBr954N2o4175FOKOUXJylRSH1V0h2wD3w2y/gNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYP8RzjSbjPN4DJLoAUNYE3Y3BCX0vsQR3BvDKS2J2Y=;
 b=OHzk13u8ZW69PurWdXUO04j+Qh0rhRFv75PUAlIfyHbEKPn8SIAzZncUhmHA/21B+iq+JUx/VOEOsUIqh4xcB/oqNrLdG+6fWQkIRMGNVZOxqJKKoqV4p+KSBOMhJkzbPGlYxYDMgTXsGSuJkwjfi7qCsHYdRbmS4j2rLdzo/8w34g1XBRTjOLHoSbG919ua36OUyqntOkrYCSltTBjQ/IuQkJcb+A5vuisOt6ubfU9HwDo92v123Maf5qSUC0gGrABTDSXLuaRAll7S0PuQyfapRJNZTAB6tc+IwgrVAeoV44AaydbBljnXN7wVHn9pjyTWQ97yyqtMzWSSXSDibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYP8RzjSbjPN4DJLoAUNYE3Y3BCX0vsQR3BvDKS2J2Y=;
 b=3L+5HJr9Y5oh/3SKal9yC0Adc/HxGUHIcE9KMv5JjnSW1c5UZbJJTfvqiROOa2Rsnq6qa9z0hd/bxlXEdWeQexHmrwDT1WRbg23t7kcw/zdGYTBBu3eepQXdECyBjuWa1sAc5FtXUYSOVpt5RQlrrt8YyRrhda4BBL5apkoA0gk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1721.namprd12.prod.outlook.com (10.175.88.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Fri, 3 Jan 2020 10:42:19 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::d79:116:e097:801b]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::d79:116:e097:801b%7]) with mapi id 15.20.2602.010; Fri, 3 Jan 2020
 10:42:19 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: fix ctx init failure for asics without
 gfx ring
To: christian.koenig@amd.com, Le Ma <le.ma@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1576755748-9800-1-git-send-email-le.ma@amd.com>
 <468e6ef3-e08c-17ad-8c83-f3efc3b04f85@amd.com>
 <cb750a50-6f57-316f-e8fd-14e39112ba53@gmail.com>
 <d0bb3341-c4c3-00be-87c1-20c3408340d1@amd.com>
 <ec36056a-4d95-7b56-f24f-72045c66b68b@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <9786994e-1e64-b322-bf49-1d19f5733a55@amd.com>
Date: Fri, 3 Jan 2020 11:43:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
In-Reply-To: <ec36056a-4d95-7b56-f24f-72045c66b68b@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::21) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f28:af00:4b7e:4ca9:65d9:936]
 (2003:c5:8f28:af00:4b7e:4ca9:65d9:936) by
 AM0PR07CA0008.eurprd07.prod.outlook.com (2603:10a6:208:ac::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.4 via Frontend Transport; Fri, 3 Jan 2020 10:42:18 +0000
X-Originating-IP: [2003:c5:8f28:af00:4b7e:4ca9:65d9:936]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb4b0685-7a7c-4330-99ce-08d790399b7e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1721:|DM5PR12MB1721:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1721123538A6BD2E24DF44E98B230@DM5PR12MB1721.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0271483E06
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(2906002)(316002)(966005)(6666004)(31696002)(81166006)(31686004)(66476007)(66946007)(66556008)(2616005)(5660300002)(81156014)(4326008)(8676002)(16526019)(66574012)(36756003)(52116002)(45080400002)(478600001)(8936002)(6486002)(186003)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1721;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LXZiYBoeRNqvX/7ftZJkp4a96gnRN0T6m+sMH4MtVq6JniFguoDiBPiWzPgSF7RQjlvgeVecauS5l95flRUt4AVQGTnRCmXrEkQHT55wMSlW5L5imtJPidUtOv0TkHf9RrkOfFbef6iClhQJH8Pozg8dTmP3jeAITKOUqU3W0r3yZ9qXJK7XQi4n8N1QKK/lWTkAANOpkgMdbgJanVITEDrsWSJTued+VnHoa2HUouEGMQxk132KFQH8s/3cUSySobB3982Ymlo4CZfn5eMTp3fxb6TjHleA/MVQ7V2zQ8OhipQKs3lmr6jKW6tystnOv1IoUlhwHrKs1cKEPmvyAyz/cLcd8Xqk1/E/8uE9CzaSIWXy6RlhXP+TIHkzWmF9ug+fZCMU8dDbnrDFWVmiL5WUkx8KlgBF+3c6M/m8tMOISMfqPoS2pnD1yG11NsRZZ8D1TCjCiq4yfng4L5g45JQrqhbPJB+2nHM71hy+BCc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4b0685-7a7c-4330-99ce-08d790399b7e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 10:42:19.3954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUOc23Kul88UVCa9gA1f02dwNz4JWEjDAJqBCszd+tsKWyoYafCMPz8ynRXlK8RnJOmYY2QymDnqOBvFDj+u5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
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
Cc: Feifei.Xu@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDEvMi8yMCA3OjEzIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDAyLjAxLjIw
IHVtIDEwOjQ3IHNjaHJpZWIgTmlybW95Ogo+Pgo+PiBPbiAxLzEvMjAgMTo1MiBQTSwgQ2hyaXN0
aWFuIEvDtm5pZyB3cm90ZToKPj4+IEFtIDE5LjEyLjE5IHVtIDEzOjAxIHNjaHJpZWIgTmlybW95
Ogo+Pj4+IFJldmlld2VkLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+Pj4K
Pj4+PiBPbiAxMi8xOS8xOSAxMjo0MiBQTSwgTGUgTWEgd3JvdGU6Cj4+Pj4+IFRoaXMgd29ya2Fy
b3VuZCBkb2VzIG5vdCBhZmZlY3Qgb3RoZXIgYXNpY3MgYmVjYXVzZSBhbWRncHUgb25seSAKPj4+
Pj4gbmVlZCBleHBvc2UKPj4+Pj4gb25lIGdmeCBzY2hlZCB0byB1c2VyIGZvciBub3cuCj4+Pj4+
Cj4+Pj4+IENoYW5nZS1JZDogSWNhOTJiODU2NWE4OTg5OWFlYmUwZWJhN2IyYjVhMjUxNTliNDEx
ZDMKPj4+Pj4gU2lnbmVkLW9mZi1ieTogTGUgTWEgPGxlLm1hQGFtZC5jb20+Cj4+Pj4+IC0tLQo+
Pj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgfCAzICsrLQo+
Pj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+
Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Y3R4LmMgCj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4+
Pj4+IGluZGV4IDYzZjYzNjUuLjY0ZTJiYWIgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKPj4+Pj4gQEAgLTEyNyw3ICsxMjcsOCBAQCBzdGF0aWMg
aW50IGFtZGdwdV9jdHhfaW5pdChzdHJ1Y3QgCj4+Pj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+
Pj4+IMKgIMKgwqDCoMKgwqDCoMKgwqDCoCBzd2l0Y2ggKGkpIHsKPj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgIGNhc2UgQU1ER1BVX0hXX0lQX0dGWDoKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc2NoZWRzID0gYWRldi0+Z2Z4LmdmeF9zY2hlZDsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc2NoZWQgPSAmYWRldi0+Z2Z4LmdmeF9yaW5nWzBdLnNjaGVkOwo+Pj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzY2hlZHMgPSAmc2NoZWQ7Cj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG51bV9zY2hlZHMgPSAxOwo+Pj4KPj4+IE1obSwgd2Ugc2hvdWxkIHByb2JhYmx5
IHJhdGhlciBmaXggdGhpcyBoZXJlIGFuZCBkb24ndCBleHBvc2UgYSBHRlggCj4+PiByaW5nIHdo
ZW4gdGhlIGhhcmR3YXJlIGRvZXNuJ3QgaGF2ZSBvbmUuCj4+IEhpIENocmlzdGlhbiwKPj4KPj4g
RG8geW91IG1lYW4gYnkgbm90IGluaXRpYWxpemluZyBlbnRpdHkgZm9yIGdmeCB3aGVuIG5vdCBh
dmFpbGFibGU/Cj4KPiBXZWxsIHdlIHN0aWxsIGluaXRpYWxpemUgaXQsIGJ1dCB3aXRoIG51bV9z
Y2hlZHM9MC4KCkhpIENocmlzdGlhbiwKCkN1cnJlbnRseSBkcm1fc2NoZWRfZW50aXR5X2luaXQg
cmVxdWlyZXMgYSBub24tTlVMTCBzY2hlZF9saXN0LyhvbGQpIApycV9saXN0LiBUaGlzIGlzIGZv
cmNpbmcgdXMgdG8gcGFzcyBhbiB1bmluaXRpYWxpemVkCgpkcm0gc2NoZWQgd2l0aCAwIG51bV9z
Y2hlZHMgdG8gZHJtX3NjaGVkX2VudGl0eV9pbml0KCkgZm9yIG5vbi1leGlzdGluZyAKaHcgaXAu
IEkgaGF2ZW4ndCB0aGluayBhYm91dCBzdWNoKG1pc3NpbmcvZmFpbGVkIGh3IGlwKSBjb3JuZXIg
Y2FzZSAKYmVmb3JlIGJ1dAoKSSB0aGluayB3ZSBjYW4gaGFuZGxlIGl0IGJ5OgoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMgCmIvZHJpdmVycy9n
cHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwppbmRleCAyZTNhMDU4ZmMyMzkuLjU2MzU5
MjI5OTgxNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRp
dHkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCkBAIC01
Niw3ICs1Niw3IEBAIGludCBkcm1fc2NoZWRfZW50aXR5X2luaXQoc3RydWN0IGRybV9zY2hlZF9l
bnRpdHkgKmVudGl0eSwKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHVuc2lnbmVkIGludCBudW1fc2NoZWRfbGlzdCwKIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGF0b21pY190ICpndWlsdHkpCiDCoHsK
LcKgwqDCoMKgwqDCoCBpZiAoIShlbnRpdHkgJiYgc2NoZWRfbGlzdCAmJiAobnVtX3NjaGVkX2xp
c3QgPT0gMCB8fCAKc2NoZWRfbGlzdFswXSkpKQorwqDCoMKgwqDCoMKgIGlmICghKGVudGl0eSAm
JiAobnVtX3NjaGVkX2xpc3QgPT0gMCB8fCBzY2hlZF9saXN0WzBdKSkpCiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7CgogwqDCoMKgwqDCoMKgwqAgbWVtc2V0
KGVudGl0eSwgMCwgc2l6ZW9mKHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5KSk7CmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgCmIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCmluZGV4IDY0ZTJiYWJiYzM2ZS4uNGM4YWQ2Y2Ix
MWVlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCkBAIC0xMjcsOSAr
MTI3LDggQEAgc3RhdGljIGludCBhbWRncHVfY3R4X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsCgogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN3aXRjaCAoaSkgewogwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgQU1ER1BVX0hXX0lQX0dGWDoKLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNjaGVkID0gJmFkZXYtPmdm
eC5nZnhfcmluZ1swXS5zY2hlZDsKLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHNjaGVkcyA9ICZzY2hlZDsKLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG51bV9zY2hlZHMgPSAxOworwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc2NoZWRzID0gYWRldi0+Z2Z4LmdmeF9zY2hlZDsKK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9zY2hlZHMgPSBhZGV2
LT5nZngubnVtX2NvbXB1dGVfc2NoZWQ7CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGJyZWFrOwogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNh
c2UgQU1ER1BVX0hXX0lQX0NPTVBVVEU6CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHNjaGVkcyA9IGFkZXYtPmdmeC5jb21wdXRlX3NjaGVkOwpAQCAtNjIy
LDYgKzYyMSwxMCBAQCB2b2lkIGFtZGdwdV9jdHhfaW5pdF9zY2hlZChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGV2LT5nZngubnVt
X2dmeF9zY2hlZCsrOwogwqDCoMKgwqDCoMKgwqAgfQoKK8KgwqDCoMKgwqDCoCAvKiBDdXJyZW50
bHkgdGhlcmUgaXMgb25seSBvbmUgdXNlciB1c2FibGUgZ2Z4IHF1ZXVlICovCivCoMKgwqDCoMKg
wqAgaWYgKGFkZXYtPmdmeC5udW1fZ2Z4X3NjaGVkID4gMSkKK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYWRldi0+Z2Z4Lm51bV9nZnhfc2NoZWQgPSAxOworCiDCoMKgwqDCoMKgwqDCoCBm
b3IgKGkgPSAwOyBpIDwgYWRldi0+Z2Z4Lm51bV9jb21wdXRlX3JpbmdzOyBpKyspIHsKIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGV2LT5nZnguY29tcHV0ZV9zY2hlZFtpXSA9IAom
YWRldi0+Z2Z4LmNvbXB1dGVfcmluZ1tpXS5zY2hlZDsKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBhZGV2LT5nZngubnVtX2NvbXB1dGVfc2NoZWQrKzsKCldoYXQgZG8geW91IHRoaW5r
PwoKSSBoYXZlIHR3byBtb3JlIHF1ZXN0aW9ucyB0byBjbGVhciByZWdhcmRpbmcgdGhpcwoKMSBX
aHkgZG8gd2UgbmVlZCB0byBjcmVhdGUgZW50aXR5IGZvciBub24gZXhpc3RpbmcgaHcgSVA/Cgoy
IFdoYXQgaGFwcGVucyB3aGVuIHVzZXIgdHJ5IHB1c2ggYSBnZnggcmVsYXRlZCBqb2IgdG8gYSBH
UFUgd2l0aG91dCBhbnkgCmdmeCBxdWV1ZSA/CgoKUmVnYXJkcywKCk5pcm1veQoKPiBDaHJpc3Rp
YW4uCj4KPj4KPj4KPj4+Cj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBicmVhazsKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgQU1ER1BVX0hX
X0lQX0NPTVBVVEU6Cj4+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+Pj4+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4+Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRs
b29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1h
biUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDbmlybW95LmRhcyU0MGFt
ZC5jb20lN0M3NjAzZTlkNDQxMDA0NWMxYjYzZDA4ZDc4ZmFmNmU0MSU3QzNkZDg5NjFmZTQ4ODRl
NjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxMzU4NTU5NDgwNTA5MjYmYW1wO3NkYXRh
PUpPdEp3cXNYTXVYZXlxOGlneHVROGY0SkhDUzZNWmk2UEFKZEdXSTIwMmclM0QmYW1wO3Jlc2Vy
dmVkPTAgCj4+Pj4KPj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZs
aXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q25pcm1veS5kYXMlNDBhbWQuY29t
JTdDNzYwM2U5ZDQ0MTAwNDVjMWI2M2QwOGQ3OGZhZjZlNDElN0MzZGQ4OTYxZmU0ODg0ZTYwOGUx
MWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTM1ODU1OTQ4MDUwOTI2JmFtcDtzZGF0YT1KT3RK
d3FzWE11WGV5cThpZ3h1UThmNEpIQ1M2TVppNlBBSmRHV0kyMDJnJTNEJmFtcDtyZXNlcnZlZD0w
IAo+Pgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
