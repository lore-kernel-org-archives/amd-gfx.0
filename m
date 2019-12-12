Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CF7C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 16:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6932073B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 16:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KrNtbJ0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6932073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EFAC6E1CE;
	Thu, 12 Dec 2019 16:12:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C966E1CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 16:12:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrREyURPqFgZW73zqGL7RqmN1OdBioYjKoBeG3Su5X955B53FT4X9hNPUdQlfplbsKxuEvk5kVwEWiKuBpTKnCKDV1cSznrK4AcxmSS/7IKf/mo3FDO9YHAHDfGEa2BmuYirPHvLUyBoW0Z/Fn7OPJ1kfr39MmGhngDGRUc1xoe0JB2Bx2YEySH7gIz/aGgFWQ4gB/lE4zbNRQNSQHhWbej/sA75fu4kk+9nOHDzOMG78aNyCejcRr3+MfX8gGq/7gq0TxNwBs1vZYKUtLkec1PaVZ9SO9ZVrSPof0SiHBQiq8vOwcJGRh8mHdc1T0K7sdKakZpcnnGOV0q01oXqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imCGVt9KFwHuCqiXQkA5VZImNxynTsLfYzDhf3lTPV8=;
 b=JxPqjwMiGWmNcj5W1Q4yL9PUQWXb12FLAykjs2p/1koDtyzEtmr1noUeTJUp2rJ5mBQtr19sydODPEJ5W4vOahpBLRL9X3KoGyVlrOtvy3XvmQRpvwPUCYyNsk8C6TMpqoiT6Ep6wcU8tESr5ZtDpI1EWbEPu/x/1Eso3eBzwoFEheYHRaVjoAK3q8HBUGkBuufv7pzrybnXAL1QFtFhPxHPzMauC0SG/vEBelWNGdYF7iNsK4YtjmqHDVA8UM7/YPfKaVf/jX9VqPFMUh1oT2lTYNDtfkme7UTfUQhbM5uMlD6DOFjFsMHxgQMQ9a2hauvn0K3be75reBWe4FYoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imCGVt9KFwHuCqiXQkA5VZImNxynTsLfYzDhf3lTPV8=;
 b=KrNtbJ0EC7qiRy1A8qmCWaQvKE8DKvjWDr3f140EmR7ypTJXYCH80GKhxCSWassdTJiRq8L92kUgbBHeMQs5zxnV6X5/LwIbEKi/peGdrzqVCVkj2AnVNLbmZ7oIfVPbJXvbKQrStf3JDdvnPuDviNUlB95TDBf4B6koDSDNkFI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1289.namprd12.prod.outlook.com (10.168.239.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.18; Thu, 12 Dec 2019 15:57:06 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f%3]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 15:57:06 +0000
Subject: Re: [PATCH] drm/amdgpu: add JPEG check to VCN idle handler and begin
 use
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20191211194824.11146-1-leo.liu@amd.com>
 <05c7579c-d373-1367-35cc-e1f5f69dc7a4@gmail.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <d08635c6-1d49-b0d7-1d47-99e69d98f432@amd.com>
Date: Thu, 12 Dec 2019 10:57:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <05c7579c-d373-1367-35cc-e1f5f69dc7a4@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: BL0PR01CA0033.prod.exchangelabs.com (2603:10b6:208:71::46)
 To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Originating-IP: [2607:fea8:a200:445:d476:36a3:2d63:7acf]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c668590-3fe9-4553-dbfb-08d77f1befea
X-MS-TrafficTypeDiagnostic: DM5PR12MB1289:|DM5PR12MB1289:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB12897984D1FFDCAC1FDED71AE5550@DM5PR12MB1289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 0249EFCB0B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(136003)(396003)(39850400004)(199004)(189003)(81166006)(186003)(52116002)(4001150100001)(44832011)(31686004)(316002)(6506007)(36756003)(66476007)(66556008)(53546011)(66946007)(5660300002)(31696002)(478600001)(81156014)(6486002)(2906002)(86362001)(8936002)(8676002)(6512007)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1289;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QO2xs9VpwT6gSfjLM5V8kFMqnooac/Rk2bth8owjdKQFmwIXyCal+ks9hkXqf3X/Bnpi1xHZdD2GPioPSZBRUOxrp6VAOE7uctqqTQcsFWlo0wM8HB+p2v1cBd6HAm8eqXkfTlubUTYRSKgokKhYlljczXAgtcFadGV0NrmKGfXd+PzgHNmRm+fQgHrYixq4Y0uOE3UcyzI1lCZQwnAVe2KqexdQOmx6Qb04dDQtRgR6caO9dKcUySTPJTzIYJjifKTwk55lS+17oOT8N9sSvQIw8+MdDmAhjf2huSKhum+u3jLbRm92qzTGti2ab9wgad2UY8yjaZYGeT2VG+Fgc5HR70q/kWRLYFxVY/kKaBUtFWY71IN+oAFFmur3NuaabU3eGXKI7VV4o/QG6IoCx6eunHOQly2dnPEgc50EOvbbhnLLOm5YyCkUgTgczp5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c668590-3fe9-4553-dbfb-08d77f1befea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 15:57:06.4703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oimGMH+1EGCuxEuHiDlLGFwwaCn5rhmcHKhODhqycrpb/u5sj5ncD8OfbOAk4xZV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1289
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

Ck9uIDIwMTktMTItMTIgMzoxOCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDEx
LjEyLjE5IHVtIDIwOjQ4IHNjaHJpZWIgTGVvIExpdToKPj4gU2luY2UgaXQncyBvbmx5IG5lZWRl
ZCB3aXRoIFZDTjEuMCB3aGVuIEhXIGhhcyBubyBpdHMKPj4gb3duIEpQRUcgSFcgSVAgYmxvY2sK
Pgo+IFdvdWxkbid0IGl0IGJlIHNpbXBsZXIvY2xlYW5lciB0byBqdXN0IGRlZmluZSBhIAo+IHZj
bl92MV8wX3JpbmdfYmVnaW5fdXNlKCkgYW5kIHZjbl92MV8wX2lkbGVfd29ya19oYW5kbGVyKCkg
aW5zdGVhZD8KClllYWgsIHRoaXMgd2F5IHNob3VsZCBiZSBjbGVhbmVyLCBldmVuIHRob3VnaCB0
aGUgY2hhbmdlcyBnb3QgYmlnZ2VyLCAKdGhlIG5ldyBzZXQgd2lsbCBiZSBzZW50IHNob3J0bHku
CgpUaGFua3MsCgpMZW8KCgoKPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+IFNpZ25l
ZC1vZmYtYnk6IExlbyBMaXUgPGxlby5saXVAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyB8IDI5ICsrKysrKysrKysrKysrKy0tLS0t
LS0tLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oIHzCoCAy
ICsrCj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25z
KC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dmNuLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCj4+IGlu
ZGV4IDQyOGNmZDU4YjM3ZC4uOTVhYzcyMWYyZGUwIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCj4+IEBAIC0xODYsNiArMTg2LDkgQEAgaW50IGFtZGdwdV92
Y25fc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIH0KPj4gwqDCoMKgwqDCoCB9Cj4+IMKgICvCoMKgwqAgYWRldi0+dmNuLmhhc19qcGVnX2Js
b2NrID0gCj4+IChhbWRncHVfZGV2aWNlX2lwX2dldF9pcF9ibG9jayhhZGV2LCBBTURfSVBfQkxP
Q0tfVFlQRV9KUEVHKSkgPwo+PiArwqDCoMKgwqDCoMKgwqAgdHJ1ZSA6IGZhbHNlOwo+PiArCj4+
IMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+IMKgIH0KPj4gwqAgQEAgLTMwNiwxNSArMzA5LDE3IEBA
IHN0YXRpYyB2b2lkIAo+PiBhbWRncHVfdmNuX2lkbGVfd29ya19oYW5kbGVyKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5ld19zdGF0ZS5md19iYXNlZCA9IFZDTl9E
UEdfU1RBVEVfX1VOUEFVU0U7Cj4+IMKgIC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIAo+PiAo
YW1kZ3B1X2ZlbmNlX2NvdW50X2VtaXR0ZWQoJmFkZXYtPmpwZWcuaW5zdFtqXS5yaW5nX2RlYykp
Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV3X3N0YXRlLmpwZWcgPSBWQ05f
RFBHX1NUQVRFX19QQVVTRTsKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZQo+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5ld19zdGF0ZS5qcGVnID0gVkNOX0RQR19TVEFU
RV9fVU5QQVVTRTsKPj4gLQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWFkZXYtPnZj
bi5oYXNfanBlZ19ibG9jaykgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IAo+PiAoYW1kZ3B1X2ZlbmNlX2NvdW50X2VtaXR0ZWQoJmFkZXYtPmpwZWcuaW5zdFtqXS5yaW5n
X2RlYykpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXdfc3Rh
dGUuanBlZyA9IFZDTl9EUEdfU1RBVEVfX1BBVVNFOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGVsc2UKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG5ld19zdGF0ZS5qcGVnID0gVkNOX0RQR19TVEFURV9fVU5QQVVTRTsKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGV2LT52Y24ucGF1
c2VfZHBnX21vZGUoYWRldiwgJm5ld19zdGF0ZSk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+
IMKgIC3CoMKgwqDCoMKgwqDCoCBmZW5jZVtqXSArPSAKPj4gYW1kZ3B1X2ZlbmNlX2NvdW50X2Vt
aXR0ZWQoJmFkZXYtPmpwZWcuaW5zdFtqXS5yaW5nX2RlYyk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBp
ZiAoIWFkZXYtPnZjbi5oYXNfanBlZ19ibG9jaykKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZmVuY2Vbal0gKz0gCj4+IGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZhZGV2LT5qcGVnLmlu
c3Rbal0ucmluZ19kZWMpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZmVuY2Vbal0gKz0gCj4+IGFt
ZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZhZGV2LT52Y24uaW5zdFtqXS5yaW5nX2RlYyk7Cj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBmZW5jZXMgKz0gZmVuY2Vbal07Cj4+IMKgwqDCoMKgwqAgfQo+
PiBAQCAtMzU4LDE0ICszNjMsMTYgQEAgdm9pZCBhbWRncHVfdmNuX3JpbmdfYmVnaW5fdXNlKHN0
cnVjdCAKPj4gYW1kZ3B1X3JpbmcgKnJpbmcpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5ld19zdGF0ZS5md19iYXNlZCA9IFZDTl9EUEdf
U1RBVEVfX1VOUEFVU0U7Cj4+IMKgIC3CoMKgwqDCoMKgwqDCoCBpZiAKPj4gKGFtZGdwdV9mZW5j
ZV9jb3VudF9lbWl0dGVkKCZhZGV2LT5qcGVnLmluc3RbcmluZy0+bWVdLnJpbmdfZGVjKSkKPj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV3X3N0YXRlLmpwZWcgPSBWQ05fRFBHX1NUQVRFX19Q
QVVTRTsKPj4gLcKgwqDCoMKgwqDCoMKgIGVsc2UKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bmV3X3N0YXRlLmpwZWcgPSBWQ05fRFBHX1NUQVRFX19VTlBBVVNFOwo+PiArwqDCoMKgwqDCoMKg
wqAgaWYgKCFhZGV2LT52Y24uaGFzX2pwZWdfYmxvY2spIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgCj4+IChhbWRncHVfZmVuY2VfY291bnRfZW1pdHRlZCgmYWRldi0+anBlZy5pbnN0
W3JpbmctPm1lXS5yaW5nX2RlYykpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bmV3X3N0YXRlLmpwZWcgPSBWQ05fRFBHX1NUQVRFX19QQVVTRTsKPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZWxzZQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5ld19zdGF0
ZS5qcGVnID0gVkNOX0RQR19TVEFURV9fVU5QQVVTRTsKPj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4g
wqAgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyaW5nLT5mdW5jcy0+dHlwZSA9PSBBTURHUFVfUklO
R19UWVBFX1ZDTl9FTkMpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5ld19zdGF0ZS5m
d19iYXNlZCA9IFZDTl9EUEdfU1RBVEVfX1BBVVNFOwo+PiAtwqDCoMKgwqDCoMKgwqAgZWxzZSBp
ZiAocmluZy0+ZnVuY3MtPnR5cGUgPT0gQU1ER1BVX1JJTkdfVFlQRV9WQ05fSlBFRykKPj4gK8Kg
wqDCoMKgwqDCoMKgIGVsc2UgaWYgKCFhZGV2LT52Y24uaGFzX2pwZWdfYmxvY2sgJiYgcmluZy0+
ZnVuY3MtPnR5cGUgPT0gCj4+IEFNREdQVV9SSU5HX1RZUEVfVkNOX0pQRUcpCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIG5ld19zdGF0ZS5qcGVnID0gVkNOX0RQR19TVEFURV9fUEFVU0U7
Cj4+IMKgIMKgwqDCoMKgwqDCoMKgwqDCoCBhZGV2LT52Y24ucGF1c2VfZHBnX21vZGUoYWRldiwg
Jm5ld19zdGF0ZSk7Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmNuLmggCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5o
Cj4+IGluZGV4IDQwMmE1MDQ2Yjk4NS4uOWEyMzgxZDAwNmM2IDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgKPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCj4+IEBAIC0xOTIsNiArMTkyLDggQEAgc3RydWN0
IGFtZGdwdV92Y24gewo+PiDCoMKgwqDCoMKgIHVuc2lnbmVkwqDCoMKgIGhhcnZlc3RfY29uZmln
Owo+PiDCoMKgwqDCoMKgIGludCAoKnBhdXNlX2RwZ19tb2RlKShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBkcGdfcGF1c2Vfc3RhdGUgKm5l
d19zdGF0ZSk7Cj4+ICsKPj4gK8KgwqDCoCBib29sIGhhc19qcGVnX2Jsb2NrOwo+PiDCoCB9Owo+
PiDCoCDCoCBpbnQgYW1kZ3B1X3Zjbl9zd19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KTsKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
