Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1B1C282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 23:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA1520661
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 23:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U9xUsspd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA1520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADE3E6E0F4;
	Fri, 10 Jan 2020 23:05:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 396506E0F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 23:05:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbA/j7WU83O4+02EhLq5wf8e4ECoYGCKINSp/KCgmT9M8TPZRqos2x4yxGvvKbtkIUpQwSODxxwNxrUWXb6vrmGoOGPxjPoiMjj28kInu+LjwHIaUgNNyoCu1pH5MCbie6YphnjonA38YIzE/bFEqUSJ5rXta/RNf6DAXM23b24MxlsfE0o+sZv2QJKTEMf9lJEFpZn1cYoaev6lrfSFgsiG011S9tIPaaMzq9OMhEAD/npSvLgIiq2SQumB48nxUijmF5jDs82WgM7ikOWFbEEJasxK49ObEZeAa4LIxOdjagf7Q4VA52MpKEHa5oH0SzVevGZ37YeeSRyMTzgMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaQpm2O7jdgLuvbRSVccxMl6j7DpDyXfva6mbXmu2H0=;
 b=D3a5JMOzyWRrXJMIMBPO4Awpoevckf4Pat2/NB20g+se2JChgXknp1OIWJfvQXc5PVQHQBAB28KWWY07Gb7F8jdcPO30c6+AovsW1k87eJ8mo2xdj89ma09Xv2JfM2ZjcQcVkXNpjxowEmBpiLvbZkx1myn33XF6xFBUB/eZOqaqMO2Ehulxh/kfGHd+CZrpo3HiyEESMlyeTyv0v23BBSqmuRKgn+UV7C8Cv4U4c4ukBa0bgBXkQW6XXbVaxe6/ld8ma+BC+ql+6OvUBDhWZxFfdSDB//oYM9wY83WfipFr+rpjJUBudRahXZWvuU6O6bDTcQTYQAP0ukpUFYHt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaQpm2O7jdgLuvbRSVccxMl6j7DpDyXfva6mbXmu2H0=;
 b=U9xUsspdrrK4tVMSKIyS63cbp+PmzhnMSOUa9XZXscyusZMwwRUynD4CE8WtQit2gTy7nxx35FeO7CDXspG1hh/pCarLe/p3Xvy/r3sgu5ZlIGu0g7Kzw07WorWHIHe5Pkyrh/6UBTMYQ+s8eLMRm5T9x+0riaTzOowhUZ5cgvo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB2536.namprd12.prod.outlook.com (10.172.90.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8; Fri, 10 Jan 2020 23:05:42 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2623.014; Fri, 10 Jan 2020
 23:05:42 +0000
Subject: Re: [PATCH 3/5] drm/amdkfd: use map_queues for hiq on arcturus as well
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1578638233-9357-1-git-send-email-ray.huang@amd.com>
 <1578638233-9357-3-git-send-email-ray.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <3eb4c086-94ba-2159-50ff-df497586d9fa@amd.com>
Date: Fri, 10 Jan 2020 18:05:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <1578638233-9357-3-git-send-email-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::24) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTBPR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Fri, 10 Jan 2020 23:05:41 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: adce1566-6dbd-4da6-4d42-08d796219daa
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2536:|DM5PR1201MB2536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB253667F37B68F333AEEB9EA392380@DM5PR1201MB2536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(316002)(31696002)(186003)(4326008)(53546011)(8676002)(36756003)(2906002)(2616005)(5660300002)(26005)(44832011)(478600001)(16576012)(6486002)(31686004)(52116002)(81156014)(36916002)(8936002)(16526019)(66556008)(81166006)(66946007)(66476007)(956004)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2536;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cXcc3k/KJED8/j7STW6+LTfa7io4gs7NkqZ+ggE2qhJDVzZkzMenJ+ndYjvLyKFgrRi5UPDLRQlIJTjnGGGMXQ3AiYHF0KF4SrU9jtI0w3ib0WQkQ/CbEm7QtPEqKpeFd0bSk+G8k/LTakaan1N/eYPsdH8XV8qOQjfSlNp6bFWz0X+oOwI/00N085oM00p+lupQp4i2cqAl+SkCS5PuRnYBFlpN9vjbRhoLf0coRUO7Zp1/Gc/OWUjvg/SOCsovizGpFkfviwmTrz7Nk6oNvDg5g2dOhgT9MAgLtmfxmWJoGLWg5EJVp7OnUvU97isR4hVRx4vVEqOhNzHFBwVFm9iPP/183bl4YfuASvJ63ce0+N7ax6YNm1l1qTk9ppmhXfEhIIVVhoU1KHVNbEghZyKAsWvjWrt/E98De7mG8Or8kGna4gW3LpT/IA68h2wi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adce1566-6dbd-4da6-4d42-08d796219daa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 23:05:42.1334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNIa4Fplbcuencg9f2sFX4tLCRERYAp9HMpOREUwplZcjBlqnIlrjN+1K8zgIFNlHHWwnepDtMtHgBx5eg4iYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2536
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V2hhdCBoYXBwZW5zIG9uIEFyY3R1cnVzIHdpdGhvdXQgdGhpcyBwYXRjaD8gRG9lcyBpdCBvb3Bz
IHdpdGggYSBudWxsIApwb2ludGVyIGRlcmVmZXJlbmNlPyBJZiB5ZXMsIHRoZW4geW91IHNob3Vs
ZCBzcXVhc2ggdGhpcyBwYXRjaCBpbnRvIApwYXRjaCAyIHRvIGF2b2lkIGEgYnJva2VuIGludGVy
bWVkaWF0ZSBzdGF0ZS4KClJlZ2FyZHMsCiDCoCBGZWxpeAoKT24gMjAyMC0wMS0xMCAxOjM3IGEu
bS4sIEh1YW5nIFJ1aSB3cm90ZToKPiBBbGlnbiB3aXRoIGdmeCB2OSwgdXNlIHRoZSBtYXBfcXVl
dWVzIHBhY2tldCB0byBsb2FkIGhpcSBNUUQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkg
PHJheS5odWFuZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZF9hcmN0dXJ1cy5jIHwgMSArCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jICAgfCA2ICsrKy0tLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuaCAgIHwgMyArKysKPiAgIDMgZmls
ZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfYXJjdHVydXMuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfYXJjdHVydXMuYwo+IGlu
ZGV4IDNjMTE5NDAuLjhiYWFkNDIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2FtZGtmZF9hcmN0dXJ1cy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9hcmN0dXJ1cy5jCj4gQEAgLTI4MSw2ICsyODEsNyBAQCBj
b25zdCBzdHJ1Y3Qga2ZkMmtnZF9jYWxscyBhcmN0dXJ1c19rZmQya2dkID0gewo+ICAgCS5zZXRf
cGFzaWRfdm1pZF9tYXBwaW5nID0ga2dkX2dmeF92OV9zZXRfcGFzaWRfdm1pZF9tYXBwaW5nLAo+
ICAgCS5pbml0X2ludGVycnVwdHMgPSBrZ2RfZ2Z4X3Y5X2luaXRfaW50ZXJydXB0cywKPiAgIAku
aHFkX2xvYWQgPSBrZ2RfZ2Z4X3Y5X2hxZF9sb2FkLAo+ICsJLmhpcV9tcWRfbG9hZCA9IGtnZF9n
ZnhfdjlfaGlxX21xZF9sb2FkLAo+ICAgCS5ocWRfc2RtYV9sb2FkID0ga2dkX2hxZF9zZG1hX2xv
YWQsCj4gICAJLmhxZF9kdW1wID0ga2dkX2dmeF92OV9ocWRfZHVtcCwKPiAgIAkuaHFkX3NkbWFf
ZHVtcCA9IGtnZF9ocWRfc2RtYV9kdW1wLAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYwo+IGluZGV4IGFiOGMyM2EuLmQyZjkzOTYgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhf
djkuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4
X3Y5LmMKPiBAQCAtMzI0LDkgKzMyNCw5IEBAIGludCBrZ2RfZ2Z4X3Y5X2hxZF9sb2FkKHN0cnVj
dCBrZ2RfZGV2ICprZ2QsIHZvaWQgKm1xZCwgdWludDMyX3QgcGlwZV9pZCwKPiAgIAlyZXR1cm4g
MDsKPiAgIH0KPiAgIAo+IC1zdGF0aWMgaW50IGtnZF9nZnhfdjlfaGlxX21xZF9sb2FkKHN0cnVj
dCBrZ2RfZGV2ICprZ2QsIHZvaWQgKm1xZCwKPiAtCQkJCSAgIHVpbnQzMl90IHBpcGVfaWQsIHVp
bnQzMl90IHF1ZXVlX2lkLAo+IC0JCQkJICAgdWludDMyX3QgZG9vcmJlbGxfb2ZmKQo+ICtpbnQg
a2dkX2dmeF92OV9oaXFfbXFkX2xvYWQoc3RydWN0IGtnZF9kZXYgKmtnZCwgdm9pZCAqbXFkLAo+
ICsJCQkgICAgdWludDMyX3QgcGlwZV9pZCwgdWludDMyX3QgcXVldWVfaWQsCj4gKwkJCSAgICB1
aW50MzJfdCBkb29yYmVsbF9vZmYpCj4gICB7Cj4gICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYgPSBnZXRfYW1kZ3B1X2RldmljZShrZ2QpOwo+ICAgCXN0cnVjdCBhbWRncHVfcmluZyAqa2lx
X3JpbmcgPSAmYWRldi0+Z2Z4LmtpcS5yaW5nOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5oIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuaAo+IGluZGV4IDAyYjE0MjYuLjMyZGQxYTkg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9n
ZnhfdjkuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRf
Z2Z4X3Y5LmgKPiBAQCAtMzMsNiArMzMsOSBAQCBpbnQga2dkX2dmeF92OV9ocWRfbG9hZChzdHJ1
Y3Qga2dkX2RldiAqa2dkLCB2b2lkICptcWQsIHVpbnQzMl90IHBpcGVfaWQsCj4gICAJCQl1aW50
MzJfdCBxdWV1ZV9pZCwgdWludDMyX3QgX191c2VyICp3cHRyLAo+ICAgCQkJdWludDMyX3Qgd3B0
cl9zaGlmdCwgdWludDMyX3Qgd3B0cl9tYXNrLAo+ICAgCQkJc3RydWN0IG1tX3N0cnVjdCAqbW0p
Owo+ICtpbnQga2dkX2dmeF92OV9oaXFfbXFkX2xvYWQoc3RydWN0IGtnZF9kZXYgKmtnZCwgdm9p
ZCAqbXFkLAo+ICsJCQkgICAgdWludDMyX3QgcGlwZV9pZCwgdWludDMyX3QgcXVldWVfaWQsCj4g
KwkJCSAgICB1aW50MzJfdCBkb29yYmVsbF9vZmYpOwo+ICAgaW50IGtnZF9nZnhfdjlfaHFkX2R1
bXAoc3RydWN0IGtnZF9kZXYgKmtnZCwKPiAgIAkJCXVpbnQzMl90IHBpcGVfaWQsIHVpbnQzMl90
IHF1ZXVlX2lkLAo+ICAgCQkJdWludDMyX3QgKCoqZHVtcClbMl0sIHVpbnQzMl90ICpuX3JlZ3Mp
OwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
