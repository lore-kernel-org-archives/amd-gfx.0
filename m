Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4545AC2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 17:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130D022522
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 17:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IKVo/x4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130D022522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE66A6EE0B;
	Tue, 21 Jan 2020 17:50:31 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690054.outbound.protection.outlook.com [40.107.69.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B9476EE0B
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 17:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aH0r8JjM0A5Kgb48nvyMqMUs3XlUuWClZrbhRuYWsf8jD+1uUr/tZdpDTaWam4Mn/GLtWgGfy6Bx97GE7B2nZSZukwQFsFSj9NAoVcxJq8arvjP4GHVsbpas1vY3ak53XNUwDQ3UzQVdqi+FEGkOxNC/Ye4zfgOu/E0/EPWeQX9XiAN/jvQQQcOVfRS9z14PwC5SuvsvwYyh0/zUDplH+rys3ZYQORP0dHd8mOgWM+8WZQEveKKO46Hk3mUJhhchXWDv9ehhex1iC2xAatJ9RsX1/lyyUeXHg2teppVAuBXoWZQQ1xTrlgZvIuX4+zAP9mRcRDmcR/zpOSKoayd9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DK2vhDOeQ8WlbGrxKaG416lscVlM3x8wKSsRZX5ep8E=;
 b=LzshMusdf3oZnLSrVW/GeBmofzsKflBVXBmBJLrS0M6msSKe9WIQ1uQut9Wy/eF+RxgBt3/hJOiGJwQGVBa0ri5yCtUsnv02SF7EYe6GOBtjV15I+E9TbKTuZB3UE+PoNWpYk+CmK1R3gBWHD4m5oNkUFzNhTABw/mt+f1YHwCaf+Zj0vKNoi/FB1I5MJhk6cPLE2UaesQpOtZgC288k7gul/h8ihn62hgFRGYrVDozHvNzX8XWIG+HejdP8oTEUfgEoQQIt892Fw8vQx6rhe4PYiV6SOvPvp6t8ZxNgmeYYYt8Nstyd7O6LDF+y4Ees7aIkI0lwEALJWwU69BuU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DK2vhDOeQ8WlbGrxKaG416lscVlM3x8wKSsRZX5ep8E=;
 b=IKVo/x4Sge/jy/6mCSm9tVHshdGKkWNpcgf4g0Mg8wjb8+rLwzmZRnlpcjjsfsarOiBbYZ3p9+95gbohM5YOvdmkqMZIuC9OOUyE6TVY9cBw2tw7Ea9mGt1c+YNmuvnRlga+a+IFfdxSx8rMgOeBLI1Oo0Nd+V9ulvIV/z5qYzU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB2709.namprd12.prod.outlook.com (20.176.254.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Tue, 21 Jan 2020 17:50:28 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 17:50:28 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu/vcn: use inst_idx relacing inst
To: Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
 <1579623556-30941-4-git-send-email-James.Zhu@amd.com>
 <67ae3044-0701-1e76-e5ef-683222b4f458@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <cd7c56b2-6c0a-a594-1970-ce9849c7c17d@amd.com>
Date: Tue, 21 Jan 2020 12:50:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <67ae3044-0701-1e76-e5ef-683222b4f458@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::14)
 To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from [172.27.233.155] (165.204.55.251) by
 YT1PR01CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Tue, 21 Jan 2020 17:50:28 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5038b025-a825-49aa-2d6f-08d79e9a66e1
X-MS-TrafficTypeDiagnostic: BYAPR12MB2709:|BYAPR12MB2709:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2709D6AD3DDCA69E6DABD66BE40D0@BYAPR12MB2709.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(199004)(189003)(5660300002)(2906002)(31696002)(6486002)(2616005)(186003)(16526019)(26005)(36756003)(36916002)(956004)(53546011)(52116002)(31686004)(16576012)(66946007)(66556008)(81166006)(8676002)(81156014)(478600001)(110136005)(8936002)(66476007)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2709;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hifa9ZQL8lstzqb+1qg7qNj88PGn6SftJ0bDoQNj3rYSiFaJi0k8yh/sxwHlyoGhsVtrcxd/qMVipUG1x8E8jfsHJeTN87l+Aoo2VSsQjQ5OC+EzpkJYvvUHHZa24Gj90EnIqF8flzlG5dcZJWUCmt4lHRTawbXW86MCcae6m5XnS9p76H7AU8oJ9L/gN9NIOmC6BqhM5s32FUF8LYGP6MnqFYnF2IxfxtOO2hVkC9ljXf79bbG9G+dKPVrpya68WG77786AyyilYAPLxf41x35H/kMNpeS671x5l2ZSS7zhQsYGqoQeg0CRj5QqIHGtJmoLPa/P45zrhTDMJeJoxh1g0IpAziXRD+feuqRsciQJp5duTyi8oO5Gg3HRqEkt2EI/42HX1eYOI4FkBeOJ/tjKLg7y4UH6ELFZi4Ug6TnjXi5+W3skJ4G8QO4rmfaT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5038b025-a825-49aa-2d6f-08d79e9a66e1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 17:50:28.6508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvVjiZYJCGmhv5JYN2WdnThUi+q/6rb8gcwofOkt0zFyRsG6F/KhCrweDegE02qX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2709
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

Ck9uIDIwMjAtMDEtMjEgMTI6NDMgcC5tLiwgTGVvIExpdSB3cm90ZToKPgo+IE9uIDIwMjAtMDEt
MjEgMTE6MTkgYS5tLiwgSmFtZXMgWmh1IHdyb3RlOgo+PiBVc2UgaW5zdF9pZHggcmVsYWNpbmcg
aW5zdCBpbiBTT0MxNV9EUEdfTU9ERSBtYWNybwo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBa
aHUgPEphbWVzLlpodUBhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Zjbi5oIHwgMjIgKysrKysrKysrKystLS0tLS0tLS0tLQo+PiDCoCAxIGZp
bGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmggCj4+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCj4+IGluZGV4IDYwZmUzYzQuLjk4
YzE4OTMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
Y24uaAo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgKPj4g
QEAgLTY1LDIzICs2NSwyMyBAQAo+PiDCoCAvKiAxIHNlY29uZCB0aW1lb3V0ICovCj4+IMKgICNk
ZWZpbmUgVkNOX0lETEVfVElNRU9VVMKgwqDCoCBtc2Vjc190b19qaWZmaWVzKDEwMDApCj4+IMKg
IC0jZGVmaW5lIFJSRUczMl9TT0MxNV9EUEdfTU9ERShpcCwgaW5zdCwgcmVnLCBtYXNrLCAKPj4g
c3JhbV9zZWwpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+PiAtwqDCoMKgICh7
wqDCoMKgIFdSRUczMl9TT0MxNShpcCwgaW5zdCwgbW1VVkRfRFBHX0xNQV9NQVNLLCAKPj4gbWFz
ayk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4gLcKgwqDCoMKgwqDCoMKgIFdSRUczMl9T
T0MxNShpcCwgaW5zdCwgbW1VVkRfRFBHX0xNQV9DVEwswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgXAo+PiArI2RlZmluZSBSUkVHMzJfU09DMTVfRFBHX01PREUoaXAsIGluc3RfaWR4
LCByZWcsIG1hc2ssIAo+PiBzcmFtX3NlbCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+PiAr
wqDCoMKgICh7wqDCoMKgIFdSRUczMl9TT0MxNShpcCwgaW5zdF9pZHgsIG1tVVZEX0RQR19MTUFf
TUFTSywgCj4+IG1hc2spO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+ICvCoMKgwqDCoMKg
wqDCoCBXUkVHMzJfU09DMTUoaXAsIGluc3RfaWR4LCBtbVVWRF9EUEdfTE1BX0NUTCzCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4KPiBJIGhhdmUgb25seSBzZWVuIHlvdSBhcmUg
dXNpbmcgaW5zdF9pZHggdG8gcmVwbGFjZSBpbnN0LCBoYXZuJ3QgeW91PyAKPiB0aGlzIGlzIG5v
dCBuZWNlc3NhcnksIGJlY2F1c2Ugd2UgYXJlIHVzaW5nIGluc3QgYXMgdGhlIGlkeC4KClNpbmNl
IHdlIHVzZSBpbnN0IGZvciBpbnN0YW5jZSBpbiBzdHJ1Y3QgYW1kZ3B1X3Zjbi4gVG8gYXZvaWQg
Y29uZnVzaW5nLCAKSSBjcmVhdGUgdGhpcyBwYXRjaCwKCkphbWVzCgo+Cj4gTGVvCj4KPgo+Cj4+
IFVWRF9EUEdfTE1BX0NUTF9fTUFTS19FTl9NQVNLIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBcCj4+IC0gKChhZGV2LT5yZWdfb2Zmc2V0W2lwIyNfSFdJUF1baW5zdF1bcmVnIyNf
QkFTRV9JRFhdICsgcmVnKcKgwqDCoMKgIFwKPj4gKyAoKGFkZXYtPnJlZ19vZmZzZXRbaXAjI19I
V0lQXVtpbnN0X2lkeF1bcmVnIyNfQkFTRV9JRFhdICsgcmVnKcKgwqDCoMKgIFwKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgPDwgVVZEX0RQR19MTUFfQ1RMX19SRUFEX1dSSVRFX0FERFJf
X1NISUZUKSAKPj4gfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIChzcmFtX3NlbCA8PCBVVkRfRFBHX0xNQV9DVExfX1NSQU1fU0VMX19TSElG
VCkpO8KgwqDCoMKgwqDCoMKgwqAgXAo+PiAtwqDCoMKgwqDCoMKgwqAgUlJFRzMyX1NPQzE1KGlw
LCBpbnN0LCBtbVVWRF9EUEdfTE1BX0RBVEEpO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFwKPj4gK8KgwqDCoMKgwqDCoMKgIFJSRUczMl9TT0MxNShpcCwgaW5zdF9pZHgsIG1tVVZE
X0RQR19MTUFfREFUQSk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4gwqDCoMKgwqDCoCB9
KQo+PiDCoCAtI2RlZmluZSBXUkVHMzJfU09DMTVfRFBHX01PREUoaXAsIGluc3QsIHJlZywgdmFs
dWUsIG1hc2ssIAo+PiBzcmFtX3NlbCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+PiArI2Rl
ZmluZSBXUkVHMzJfU09DMTVfRFBHX01PREUoaXAsIGluc3RfaWR4LCByZWcsIHZhbHVlLCBtYXNr
LCAKPj4gc3JhbV9zZWwpwqDCoMKgwqDCoMKgwqDCoCBcCj4+IMKgwqDCoMKgwqAgZG8ge8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4gLcKgwqDCoMKgwqDCoMKgIFdSRUczMl9TT0MxNShpcCwg
aW5zdCwgbW1VVkRfRFBHX0xNQV9EQVRBLCAKPj4gdmFsdWUpO8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBcCj4+IC3CoMKgwqDCoMKgwqDCoCBXUkVHMzJfU09DMTUoaXAsIGluc3QsIG1tVVZEX0RQ
R19MTUFfTUFTSywgbWFzayk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4gLcKgwqDCoMKg
wqDCoMKgIFdSRUczMl9TT0MxNShpcCwgaW5zdCwgbW1VVkRfRFBHX0xNQV9DVEwswqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+PiArwqDCoMKgwqDCoMKgwqAgV1JFRzMyX1NPQzE1
KGlwLCBpbnN0X2lkeCwgbW1VVkRfRFBHX0xNQV9EQVRBLCAKPj4gdmFsdWUpO8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBcCj4+ICvCoMKgwqDCoMKgwqDCoCBXUkVHMzJfU09DMTUoaXAsIGluc3Rf
aWR4LCBtbVVWRF9EUEdfTE1BX01BU0ssIAo+PiBtYXNrKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgXAo+PiArwqDCoMKgwqDCoMKgwqAgV1JFRzMyX1NPQzE1KGlwLCBpbnN0X2lkeCwgbW1VVkRf
RFBHX0xNQV9DVEwswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBVVkRfRFBHX0xNQV9DVExfX1JFQURfV1JJVEVfTUFTSyB8IFwK
Pj4gLSAoKGFkZXYtPnJlZ19vZmZzZXRbaXAjI19IV0lQXVtpbnN0XVtyZWcjI19CQVNFX0lEWF0g
KyByZWcpwqDCoMKgwqAgXAo+PiArICgoYWRldi0+cmVnX29mZnNldFtpcCMjX0hXSVBdW2luc3Rf
aWR4XVtyZWcjI19CQVNFX0lEWF0gKyByZWcpwqDCoMKgwqAgXAo+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCA8PCBVVkRfRFBHX0xNQV9DVExfX1JFQURfV1JJVEVfQUREUl9fU0hJRlQpIAo+
PiB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKHNyYW1fc2VsIDw8IFVWRF9EUEdfTE1BX0NUTF9fU1JBTV9TRUxfX1NISUZUKSk7wqDCoMKg
wqDCoMKgwqDCoCBcCj4+IMKgwqDCoMKgwqAgfSB3aGlsZSAoMCkKPj4gQEAgLTExMSw3ICsxMTEs
NyBAQAo+PiDCoCDCoCAjZGVmaW5lIFJSRUczMl9TT0MxNV9EUEdfTU9ERV8yXzAoaW5zdF9pZHgs
IG9mZnNldCwgCj4+IG1hc2tfZW4pwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBcCj4+IMKgwqDCoMKgwqAgKHvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+
IC3CoMKgwqDCoMKgwqDCoCBXUkVHMzJfU09DMTUoVkNOLCBpbnN0LCAKPj4gbW1VVkRfRFBHX0xN
QV9DVEwswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+ICvCoMKg
wqDCoMKgwqDCoCBXUkVHMzJfU09DMTUoVkNOLCBpbnN0X2lkeCwgCj4+IG1tVVZEX0RQR19MTUFf
Q1RMLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAoMHgwIDw8IFVWRF9EUEdfTE1BX0NUTF9fUkVBRF9XUklURV9f
U0hJRlQgCj4+IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBtYXNrX2VuIDw8IFVWRF9EUEdfTE1BX0NUTF9fTUFTS19FTl9fU0hJ
RlQgCj4+IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBvZmZzZXQgPDwgCj4+IFVWRF9EUEdfTE1BX0NUTF9fUkVBRF9XUklURV9B
RERSX19TSElGVCkpO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
