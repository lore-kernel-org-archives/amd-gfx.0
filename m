Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EE8C33CB2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 15:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D96A2467D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 15:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Wm4yDTwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D96A2467D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 149876E418;
	Tue, 14 Jan 2020 15:30:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D406E418
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 15:30:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpA+W4lFHh174LnLgmx0mIriIjw7Bje6ojUgV+J1qIRthMH4lJx5EdA2CHRj9Fpyg79Hw36FwpWrIR8a7kvD5Xiu9zctEahZapX+6u+ahGivAafR9+NVOBnji8GhP/QA/dWRLrZVrH3W3frxEQFQ5tMW2Rk6oc7SWmKFqWKDA2yCtRp2tPGzHfxsBCUTdziXhNfwPoNxeMzzHWglvVkgSzClLS0VACvcagU1bRhIBVdiPw7HuOAmKk/AND3BkjfyZVJPI0Y2BQtqF/kJtFJaS9pUzt8+GnRRUNIWt2FlJuuI+9qANA9tx7ZA4He2Mi46Iv9O7TFnKqcMW5HbXpn/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=744j25bxHg+ZLEukJAXfnWg5vR/Oy/1QP+jDr0ZITdw=;
 b=TlWY07tGN9k6Laj84NA18LdTgRNMXgpsjLlRpFAOkpozfQZ0/7IVVgM8BojNLM9eKWn0KiRnoSG+NVjKyq2sgWvuyjQX9Oa+hDUcQFwoCxMIaUQut7RHj/VgAvy2HwBymSHFd1Qsmu7pLCZpY5CXvvKsIisBfQ+OspKaMY9rmm/J/2YQE/vZ7vvwraj7S4+kHttl+06718n1TmbRN1s36dQH6c5IKRTHbs/wC/8dAv9aHcyw5ToOCafDwHqtU01RZur9g+CPIQhXOD4lhlVPEXrZWJDq2RawtKVFnn676JbyKRfUgj1RUwlovAe+qFF+pXw3JEkrjTTlvEupYSy+zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=744j25bxHg+ZLEukJAXfnWg5vR/Oy/1QP+jDr0ZITdw=;
 b=Wm4yDTwy53LkgEdI2mWtpXWtKtNhoEVCS5hSwWAKj+AZGVeE+OdFQTnL5yg8l6AFv2JSSOa2D49N4ffyAZtzYO5JLuytjYiaYlPix/cFaNMfiVQYsSjjsLOGpBKTZPB/bnMQm2+2vfjfGZyfoTuxQKXOlOFpposNAPg2/9iFjs0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0220.namprd12.prod.outlook.com (10.174.247.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 15:30:17 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 15:30:17 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu: only set cp active field for kiq queue
To: Huang Rui <ray.huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1578638233-9357-1-git-send-email-ray.huang@amd.com>
 <20200114093640.GA20112@jenkins-Celadon-RN>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <e9462ca9-ffe9-0bf6-8fa2-881c40f24bef@amd.com>
Date: Tue, 14 Jan 2020 10:30:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20200114093640.GA20112@jenkins-Celadon-RN>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::23) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.31.19.228] (165.204.54.211) by
 YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Tue, 14 Jan 2020 15:30:16 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eddee46c-5432-4166-bdc1-08d79906a835
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0220:|DM5PR1201MB0220:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0220E073129B5AE31D7FF3FD92340@DM5PR1201MB0220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(199004)(189003)(956004)(2906002)(44832011)(2616005)(110136005)(31696002)(16576012)(316002)(5660300002)(36756003)(31686004)(478600001)(86362001)(4326008)(52116002)(81156014)(6486002)(8936002)(81166006)(16526019)(186003)(8676002)(53546011)(26005)(66556008)(66476007)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0220;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mAFzHYBgMUYVcX3zXAKQVNz1bUe/W/gtURqSF+KK9aYkfX8+Af/6tOaCt8kECGtCsUJvHsMETILIvjYPXp9zx/Dw398ATdG9yGOBaiSvBjD6L/mpiKa7GLW0aFRpmVj5NK0LkLVDUCeCa3Vz+tCcauedOv9gc7aMGBzZEC52hcE5eBjL0uh0mAf7BxaDznr6n9JTA9NIHamPTSrx/uKSvxAzlm5cDaj3plXP6NQc9LDP5tsiXx/pnfYh8U4Kb17Vf4igdn9TDnM+uJJ4grLjV9+2eLg0IYdorwVVxrRLc7xxIz18LT4gCoTA6ZDUF0D+Jrq8vMJIQFCaXrs2DvSbJB7lUXWK4GnznnS+sl0/cvA/3NFwTOHPd+luQBjmdR6OOQwXUrTmX3FL9j2CC4H8ZcCeqhKFinnumPnjw6BFETDi9chhSNpR3eYy/fovik1q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddee46c-5432-4166-bdc1-08d79906a835
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 15:30:16.9971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnRp9oPqYYoULHn5AkrPZ0So+Iiz1g/ccjcqJDq/BeSTu+gpWiLO2owk3rLzh3GM3z/pWohqwB5eABsx8wE3kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0220
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UGF0Y2ggMSBpcwoKUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0Bh
bWQuY29tPgoKUGF0Y2hlcyAyIGFuZCAzIHNob3VsZCBiZSBzcXVhc2hlZC4gSW4gdGhhdCBjYXNl
IHRoZXkgYXJlCgpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFt
ZC5jb20+CgpQYXRjaGVzIDQgYW5kIDUgbmVlZCB0byBiZSB0ZXN0ZWQuIEkgdGhpbmsgeW91IG1l
bnRpb25lZCBHRlgxMCB3b3JrZWQgCihwYXRjaCA0KSBidXQgR0ZYOCB3YXMgZmFpbGluZyAocGF0
Y2ggNSkuIEhhdmUgeW91IGZvdW5kIHRoZSBwcm9ibGVtPyBJIApoYXZlbid0IHNlZW4gYW55IHVw
ZGF0ZSB0byB0aGUgcGF0Y2guCgpSZWdhcmRzLAogwqAgRmVsaXgKCk9uIDIwMjAtMDEtMTQgNDoz
NiwgSHVhbmcgUnVpIHdyb3RlOgo+IFBpbmd+Cj4KPiBPbiBGcmksIEphbiAxMCwgMjAyMCBhdCAw
MjozNzowOVBNICswODAwLCBIdWFuZywgUmF5IHdyb3RlOgo+PiBUaGUgbWVjIHVjb2RlIHdpbGwg
c2V0IHRoZSBDUF9IUURfQUNUSVZFIGJpdCB3aGlsZSB0aGUgcXVldWUgaXMgbWFwcGVkIGJ5Cj4+
IE1BUF9RVUVVRVMgcGFja2V0LiBTbyB3ZSBvbmx5IG5lZWQgc2V0IGNwIGFjdGl2ZSBmaWVsZCBm
b3Iga2lxIHF1ZXVlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0Bh
bWQuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAu
YyB8IDcgKysrKystLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMg
IHwgNyArKysrKy0tCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyAg
fCA3ICsrKysrLS0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4+IGlu
ZGV4IDViMDUzMzQuLjIyYzY5ZDggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92MTBfMC5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92MTBfMC5jCj4+IEBAIC0zMzIzLDggKzMzMjMsMTEgQEAgc3RhdGljIGludCBnZnhfdjEwXzBf
Y29tcHV0ZV9tcWRfaW5pdChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4+ICAgCXRtcCA9IFJF
R19TRVRfRklFTEQodG1wLCBDUF9IUURfSUJfQ09OVFJPTCwgTUlOX0lCX0FWQUlMX1NJWkUsIDMp
Owo+PiAgIAltcWQtPmNwX2hxZF9pYl9jb250cm9sID0gdG1wOwo+PiAgIAo+PiAtCS8qIGFjdGl2
YXRlIHRoZSBxdWV1ZSAqLwo+PiAtCW1xZC0+Y3BfaHFkX2FjdGl2ZSA9IDE7Cj4+ICsJLyogbWFw
X3F1ZXVlcyBwYWNrZXQgZG9lc24ndCBuZWVkIGFjdGl2YXRlIHRoZSBxdWV1ZSwKPj4gKwkgKiBz
byBvbmx5IGtpcSBuZWVkIHNldCB0aGlzIGZpZWxkLgo+PiArCSAqLwo+PiArCWlmIChyaW5nLT5m
dW5jcy0+dHlwZSA9PSBBTURHUFVfUklOR19UWVBFX0tJUSkKPj4gKwkJbXFkLT5jcF9ocWRfYWN0
aXZlID0gMTsKPj4gICAKPj4gICAJcmV0dXJuIDA7Cj4+ICAgfQo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OF8wLmMKPj4gaW5kZXggOGI5ZjQ0MC4uMzA2ZWU2MSAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwo+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jCj4+IEBAIC00NTU4LDggKzQ1NTgsMTEgQEAg
c3RhdGljIGludCBnZnhfdjhfMF9tcWRfaW5pdChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4+
ICAgCW1xZC0+Y3BfaHFkX2VvcF93cHRyX21lbSA9IFJSRUczMihtbUNQX0hRRF9FT1BfV1BUUl9N
RU0pOwo+PiAgIAltcWQtPmNwX2hxZF9lb3BfZG9uZXMgPSBSUkVHMzIobW1DUF9IUURfRU9QX0RP
TkVTKTsKPj4gICAKPj4gLQkvKiBhY3RpdmF0ZSB0aGUgcXVldWUgKi8KPj4gLQltcWQtPmNwX2hx
ZF9hY3RpdmUgPSAxOwo+PiArCS8qIG1hcF9xdWV1ZXMgcGFja2V0IGRvZXNuJ3QgbmVlZCBhY3Rp
dmF0ZSB0aGUgcXVldWUsCj4+ICsJICogc28gb25seSBraXEgbmVlZCBzZXQgdGhpcyBmaWVsZC4K
Pj4gKwkgKi8KPj4gKwlpZiAocmluZy0+ZnVuY3MtPnR5cGUgPT0gQU1ER1BVX1JJTkdfVFlQRV9L
SVEpCj4+ICsJCW1xZC0+Y3BfaHFkX2FjdGl2ZSA9IDE7Cj4+ICAgCj4+ICAgCXJldHVybiAwOwo+
PiAgIH0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8w
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4+IGluZGV4IDQ1MzI4
ZjkuLmUyOTgxOGIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92OV8wLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+
PiBAQCAtMzMxMyw4ICszMzEzLDExIEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfbXFkX2luaXQoc3Ry
dWN0IGFtZGdwdV9yaW5nICpyaW5nKQo+PiAgIAl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgQ1Bf
SFFEX0lCX0NPTlRST0wsIE1JTl9JQl9BVkFJTF9TSVpFLCAzKTsKPj4gICAJbXFkLT5jcF9ocWRf
aWJfY29udHJvbCA9IHRtcDsKPj4gICAKPj4gLQkvKiBhY3RpdmF0ZSB0aGUgcXVldWUgKi8KPj4g
LQltcWQtPmNwX2hxZF9hY3RpdmUgPSAxOwo+PiArCS8qIG1hcF9xdWV1ZXMgcGFja2V0IGRvZXNu
J3QgbmVlZCBhY3RpdmF0ZSB0aGUgcXVldWUsCj4+ICsJICogc28gb25seSBraXEgbmVlZCBzZXQg
dGhpcyBmaWVsZC4KPj4gKwkgKi8KPj4gKwlpZiAocmluZy0+ZnVuY3MtPnR5cGUgPT0gQU1ER1BV
X1JJTkdfVFlQRV9LSVEpCj4+ICsJCW1xZC0+Y3BfaHFkX2FjdGl2ZSA9IDE7Cj4+ICAgCj4+ICAg
CXJldHVybiAwOwo+PiAgIH0KPj4gLS0gCj4+IDIuNy40Cj4+Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
