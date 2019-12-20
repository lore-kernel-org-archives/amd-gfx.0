Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB573C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 23:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DAC206EC
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 23:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LFCmq4kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DAC206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ADC76E15A;
	Fri, 20 Dec 2019 23:50:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF1086E15A
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 23:50:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUCxs3U9+iuDk1cIyNc/MU+yag10qEVQ3NkokmleRZ+mvNPVHqRW2agQHGo09eL1CQFsj7VSjC8dpL/TzczP3fp5wl5m8ccuSnaXQdixCI6hgdzpAml+6Wx2pfYi8T7HvRDW4uh4qVtmb4jGBHeIx9MxF2FCig/24tA5dEMjhia/iFBV9Sk52g7nMFW8iMxc2ufvL+Mze4UwcI2b1dbASNF+8iGOBZnWQqxns1em4el67mxub38yBd9f7NTxpHkSOXtTVOmYXrk3RbskpDhCvTodAT4U0qoSTTr498zqsgHp3qFbu8GCtBiMRCYt/JNwkN22V7iXjasIVnLI06kIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABiVKJMnbsoT5VAusQjeLS5627Aey9bMABWA2B7AKcI=;
 b=EiX6dumUjbk4hOWWkiiwglW/6ulyxpBaxfGmdvygStF9AsxD/MLY8OnXZCMYkU9zaAiOu46tZGjXo5dqCReOEI31oe1NbpvfAe+0NHwmvOKpJPQqGWts9A5R3NUqqmm329ih3lpbT9bI0V6FK1bMrR62bFEXzOPQDEPt7aWvmxH+y4AszWYD2/I8Vh9b3bQVwH+IAYmi95PZKN8Bf/w3aQ44PsWefhM21KJy9OJfru1V4U3E/UzUiNr27hX1fDYLmD0asWeEyusu3pJl/zzw8IV7j1uUnLLUv9WVD/v7IEXoOn9vA9yzF58OKX8W5kymFlJhoJ4JdX9jtYcMTVCOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABiVKJMnbsoT5VAusQjeLS5627Aey9bMABWA2B7AKcI=;
 b=LFCmq4kjL9lxDLGjHFrSF0anMGfLQaxE6668tmhler+XX0uEQhsdXhCHv+jhpNHXJfRx7846202s28BpXGFmdkjVPTbHTsLj083jmEUWTJbeoFqKTRwzomzqyJV9PhGuQetLi9hKU4g35He46F88WttmXTbkwege4R+nRpSHcC0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com (10.174.106.18) by
 DM5PR1201MB0025.namprd12.prod.outlook.com (10.174.105.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Fri, 20 Dec 2019 23:50:54 +0000
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22]) by DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22%9]) with mapi id 15.20.2538.019; Fri, 20 Dec 2019
 23:50:54 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu: GPU TLB flush API moved to amdgpu_amdkfd
To: Felix Kuehling <felix.kuehling@amd.com>, Alex Sierra
 <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191220062442.33635-1-alex.sierra@amd.com>
 <20191220062442.33635-3-alex.sierra@amd.com>
 <41542c9c-a668-0a4b-1f3f-9b38c8e48d12@amd.com>
From: Yong Zhao <yong.zhao@amd.com>
Message-ID: <69ea408a-1f03-a6f4-34be-193bb5a17dec@amd.com>
Date: Fri, 20 Dec 2019 18:50:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <41542c9c-a668-0a4b-1f3f-9b38c8e48d12@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::35) To DM5PR1201MB0137.namprd12.prod.outlook.com
 (2603:10b6:4:54::18)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7e706e3-079e-4f0d-aa00-08d785a773c6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0025:|DM5PR1201MB0025:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00252CB41742E6A4B94709FFF02D0@DM5PR1201MB0025.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 025796F161
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(189003)(199004)(66946007)(31686004)(8936002)(36756003)(478600001)(186003)(45080400002)(52116002)(110136005)(5660300002)(44832011)(316002)(966005)(6486002)(66476007)(66556008)(8676002)(81156014)(2906002)(81166006)(6512007)(26005)(4001150100001)(6506007)(86362001)(6666004)(31696002)(53546011)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0025;
 H:DM5PR1201MB0137.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pIsIXHtUdMZNocUJhkjUsoWkkA981VF+9bjwxrmOrMkhWiXDzn2FILcL6v7mSdtmcQllpFX+P/hD+ANWwkY+2/eyCZn+uzlQriQPA2WXX9jkLdOx4UgrMci52F6wslARTWJn+Rps8wwB/8YN5aKcBATLKj2huhjkiOT0qwjpd99520WQRP4M2B6q7Yvm8VKA3eo88cEmkQ8BUuILMYLcLQEpsOIP1tF2EoNXoVQOzhW9MaGvtyUO9nsKBrIvzDITN6kWBHhvEEkYYAczqWJYZ4FBKtpdKvxztXe7GcPVp1Q/GQ1nTOsdyc//jg+Q656Kvh9J4h1ScZy50Nn/monfR7IG1/M6RXeV5OLtnT5it5+pu50EYEZK+cMjHyKM+NI/F7Vq9Xnj7IyQnHvWEXAB7oQ/mVCFXXBSY9ZLuO1hAJxWQo2x0vrlk48FtILi92RbUpVfRQ9Z0NVnfGIEOj8PGETKcN5vddgL3fYj8yRXF6w=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e706e3-079e-4f0d-aa00-08d785a773c6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 23:50:54.7555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAfUpilHi9zsMfnmFtam6n6d/2xvsUT7sUH6u72gk6l8COHfVWNYAg288wlaKNrJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0025
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SW5saW5lLgoKT24gMjAxOS0xMi0yMCA0OjM1IHAubS4sIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+
IE9uIDIwMTktMTItMjAgMToyNCwgQWxleCBTaWVycmEgd3JvdGU6Cj4+IFtXaHldCj4+IFRMQiBm
bHVzaCBtZXRob2QgaGFzIGJlZW4gZGVwcmVjYXRlZCB1c2luZyBrZmQya2dkIGludGVyZmFjZS4K
Pj4gVGhpcyBpbXBsZW1lbnRhdGlvbiBpcyBub3cgb24gdGhlIGFtZGdwdV9hbWRrZmQgQVBJLgo+
Pgo+PiBbSG93XQo+PiBUTEIgZmx1c2ggZnVuY3Rpb25zIG5vdyBpbXBsZW1lbnRlZCBpbiBhbWRn
cHVfYW1ka2ZkLgo+Pgo+PiBDaGFuZ2UtSWQ6IEljNTFjY2NkZmU2ZTcxMjg4ZDc4ZGE3NzJiNmUx
YjZjZWQ3MmY4ZWY3Cj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggU2llcnJhIDxhbGV4LnNpZXJyYUBh
bWQuY29tPgo+Cj4gTG9va3MgZ29vZCB0byBtZS4gU2VlIG15IGNvbW1lbnQgYWJvdXQgdGhlIFRP
RE8gaW5saW5lLgo+Cj4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hbWRrZmQuYyB8IDMyICsrKysrKysrKysrKysrKysrKysrKysKPj4gwqAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oIHzCoCAyICsrCj4+IMKgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmPCoMKgIHzCoCA4ICsrKystLQo+PiDCoCAz
IGZpbGVzIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgCj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCj4+IGluZGV4IGQz
ZGE5ZGRlNGVlMS4uYjdmNmU3MGM1NzYyIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2FtZGtmZC5jCj4+IEBAIC02MzQsNiArNjM0LDM4IEBAIGJvb2wgYW1kZ3B1
X2FtZGtmZF9pc19rZmRfdm1pZChzdHJ1Y3QgCj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHUzMiB2
bWlkKQo+PiDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsKPj4gwqAgfQo+PiDCoCAraW50IGFtZGdw
dV9hbWRrZmRfZmx1c2hfZ3B1X3RsYl92bWlkKHN0cnVjdCBrZ2RfZGV2ICprZ2QsIHVpbnQxNl90
IAo+PiB2bWlkKQo+PiArewo+PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0g
KHN0cnVjdCBhbWRncHVfZGV2aWNlICopa2dkOwo+PiArwqDCoMKgIC8qIFRPRE86IGNvbmRpdGlv
biBtaXNzaW5nIGZvciBGQU1JTFkgYWJvdmUgTlYgKi8KPgo+IEknbSBub3Qgc3VyZSB3aGF0J3Mg
bWlzc2luZyBoZXJlLiBOViBhbmQgYWJvdmUgZG9uJ3QgbmVlZCBhbnkgc3BlY2lhbCAKPiB0cmVh
dG1lbnQuIFNpbmNlIFNETUEgaXMgY29ubmVjdGVkIHRvIEdGWEhVQiBvbiBOViwgb25seSB0aGUg
R0ZYSFVCIAo+IG5lZWRzIHRvIGJlIGZsdXNoZWQuCj4KPiBSZWdhcmRzLAo+IMKgIEZlbGl4Cj4K
Pgo+PiArwqDCoMKgIGlmIChhZGV2LT5mYW1pbHkgPT0gQU1ER1BVX0ZBTUlMWV9BSSkgewo+PiAr
wqDCoMKgwqDCoMKgwqAgaW50IGk7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7
IGkgPCBhZGV2LT5udW1fdm1odWJzOyBpKyspCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFt
ZGdwdV9nbWNfZmx1c2hfZ3B1X3RsYihhZGV2LCB2bWlkLCBpLCAwKTsKPj4gK8KgwqDCoCB9IGVs
c2Ugewo+PiArwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxiKGFkZXYsIHZt
aWQsIEFNREdQVV9HRlhIVUJfMCwgMCk7Cj4+ICvCoMKgwqAgfQoKVGhpcyBpZiBlbHNlIGNhbiBi
ZSB1bmlmaWVkIGJ5Cgpmb3IgKGkgPSAwOyBpIDwgYWRldi0+bnVtX3ZtaHViczsgaSsrKQoKIMKg
wqDCoCBhbWRncHVfZ21jX2ZsdXNoX2dwdV90bGIoYWRldiwgdm1pZCwgaSwgMCk7Cgo+PiArCj4+
ICvCoMKgwqAgcmV0dXJuIDA7Cj4+ICt9Cj4+ICsKPj4gK2ludCBhbWRncHVfYW1ka2ZkX2ZsdXNo
X2dwdV90bGJfcGFzaWQoc3RydWN0IGtnZF9kZXYgKmtnZCwgdWludDE2X3QgCj4+IHBhc2lkKQo+
PiArewo+PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICopa2dkOwo+PiArwqDCoMKgIHVpbnQzMl90IGZsdXNoX3R5cGUgPSAwOwo+PiAr
wqDCoMKgIGJvb2wgYWxsX2h1YiA9IGZhbHNlOwo+PiArCj4+ICvCoMKgwqAgaWYgKGFkZXYtPmdt
Yy54Z21pLm51bV9waHlzaWNhbF9ub2RlcyAmJgo+PiArwqDCoMKgwqDCoMKgwqAgYWRldi0+YXNp
Y190eXBlID09IENISVBfVkVHQTIwKQo+PiArwqDCoMKgwqDCoMKgwqAgZmx1c2hfdHlwZSA9IDI7
Cj4+ICsKPj4gK8KgwqDCoCBpZiAoYWRldi0+ZmFtaWx5ID09IEFNREdQVV9GQU1JTFlfQUkpCj4+
ICvCoMKgwqDCoMKgwqDCoCBhbGxfaHViID0gdHJ1ZTsKPj4gKwo+PiArwqDCoMKgIHJldHVybiBh
bWRncHVfZ21jX2ZsdXNoX2dwdV90bGJfcGFzaWQoYWRldiwgcGFzaWQsIGZsdXNoX3R5cGUsIAo+
PiBhbGxfaHViKTsKPj4gK30KPj4gKwo+PiDCoCBib29sIGFtZGdwdV9hbWRrZmRfaGF2ZV9hdG9t
aWNzX3N1cHBvcnQoc3RydWN0IGtnZF9kZXYgKmtnZCkKPj4gwqAgewo+PiDCoMKgwqDCoMKgIHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopa2dkOwo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5o
IAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuaAo+PiBpbmRl
eCAwNjlkNWQyMzA4MTAuLjQ3YjBmMjk1N2QxZiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuaAo+PiBAQCAtMTM2LDYgKzEzNiw4IEBAIGludCBhbWRn
cHVfYW1ka2ZkX3N1Ym1pdF9pYihzdHJ1Y3Qga2dkX2RldiAqa2dkLCAKPj4gZW51bSBrZ2RfZW5n
aW5lX3R5cGUgZW5naW5lLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVp
bnQzMl90ICppYl9jbWQsIHVpbnQzMl90IGliX2xlbik7Cj4+IMKgIHZvaWQgYW1kZ3B1X2FtZGtm
ZF9zZXRfY29tcHV0ZV9pZGxlKHN0cnVjdCBrZ2RfZGV2ICprZ2QsIGJvb2wgaWRsZSk7Cj4+IMKg
IGJvb2wgYW1kZ3B1X2FtZGtmZF9oYXZlX2F0b21pY3Nfc3VwcG9ydChzdHJ1Y3Qga2dkX2RldiAq
a2dkKTsKPj4gK2ludCBhbWRncHVfYW1ka2ZkX2ZsdXNoX2dwdV90bGJfdm1pZChzdHJ1Y3Qga2dk
X2RldiAqa2dkLCB1aW50MTZfdCAKPj4gdm1pZCk7Cj4+ICtpbnQgYW1kZ3B1X2FtZGtmZF9mbHVz
aF9ncHVfdGxiX3Bhc2lkKHN0cnVjdCBrZ2RfZGV2ICprZ2QsIHVpbnQxNl90IAo+PiBwYXNpZCk7
Cj4+IMKgIMKgIGJvb2wgYW1kZ3B1X2FtZGtmZF9pc19rZmRfdm1pZChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgdTMyIAo+PiB2bWlkKTsKPj4gwqAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3Byb2Nlc3MuYwo+PiBpbmRleCA1MzZhMTUzYWM5YTQuLjI1YjkwZjcwYWVjZCAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwo+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCj4+IEBAIC0z
Miw2ICszMiw3IEBACj4+IMKgICNpbmNsdWRlIDxsaW51eC9tbWFuLmg+Cj4+IMKgICNpbmNsdWRl
IDxsaW51eC9maWxlLmg+Cj4+IMKgICNpbmNsdWRlICJhbWRncHVfYW1ka2ZkLmgiCj4+ICsjaW5j
bHVkZSAiYW1kZ3B1LmgiCj4+IMKgIMKgIHN0cnVjdCBtbV9zdHJ1Y3Q7Cj4+IMKgIEBAIC0xMTUy
LDE2ICsxMTUzLDE3IEBAIGludCBrZmRfcmVzZXJ2ZWRfbWVtX21tYXAoc3RydWN0IGtmZF9kZXYg
Cj4+ICpkZXYsIHN0cnVjdCBrZmRfcHJvY2VzcyAqcHJvY2VzcywKPj4gwqAgdm9pZCBrZmRfZmx1
c2hfdGxiKHN0cnVjdCBrZmRfcHJvY2Vzc19kZXZpY2UgKnBkZCkKPj4gwqAgewo+PiDCoMKgwqDC
oMKgIHN0cnVjdCBrZmRfZGV2ICpkZXYgPSBwZGQtPmRldjsKPj4gLcKgwqDCoCBjb25zdCBzdHJ1
Y3Qga2ZkMmtnZF9jYWxscyAqZjJnID0gZGV2LT5rZmQya2dkOwo+PiDCoCDCoMKgwqDCoMKgIGlm
IChkZXYtPmRxbS0+c2NoZWRfcG9saWN5ID09IEtGRF9TQ0hFRF9QT0xJQ1lfTk9fSFdTKSB7Cj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBOb3RoaW5nIHRvIGZsdXNoIHVudGlsIGEgVk1JRCBpcyBh
c3NpZ25lZCwgd2hpY2gKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBvbmx5IGhhcHBlbnMgd2hl
biB0aGUgZmlyc3QgcXVldWUgaXMgY3JlYXRlZC4KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChwZGQtPnFwZC52bWlkKQo+PiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBmMmctPmludmFsaWRhdGVfdGxic192bWlkKGRldi0+a2dkLCBwZGQtPnFwZC52
bWlkKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2FtZGtmZF9mbHVzaF9ncHVf
dGxiX3ZtaWQoZGV2LT5rZ2QsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcGRkLT5xcGQudm1pZCk7Cj4+IMKgwqDCoMKgwqAgfSBlbHNl
IHsKPj4gLcKgwqDCoMKgwqDCoMKgIGYyZy0+aW52YWxpZGF0ZV90bGJzKGRldi0+a2dkLCBwZGQt
PnByb2Nlc3MtPnBhc2lkKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGFtZGdwdV9hbWRrZmRfZmx1c2hf
Z3B1X3RsYl9wYXNpZChkZXYtPmtnZCwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcGRkLT5wcm9jZXNzLT5wYXNpZCk7Cj4+IMKgwqDCoMKgwqAgfQo+
PiDCoCB9Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
aHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBz
JTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1k
LWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDeW9uZy56aGFvJTQwYW1kLmNvbSU3QzE5NmFmZGFlOWI2
OTQyNWU1OGFhMDhkNzg1OTQ5MjdhJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2Ql
N0MwJTdDMCU3QzYzNzEyNDc0NTUyMTA2MzQ3MiZhbXA7c2RhdGE9NVpaTnRxJTJGeU9aWCUyQmRR
ckcxeWRvaWRPVTkwWnJiV0d6OXRudXljRWc0RjQlM0QmYW1wO3Jlc2VydmVkPTAgCj4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
