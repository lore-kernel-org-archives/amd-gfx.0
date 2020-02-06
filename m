Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB00C35247
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 02:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5EB420659
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 02:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CjhV0d6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5EB420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 642BD6F9A9;
	Thu,  6 Feb 2020 02:39:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AAB56F9A9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 02:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kl4TSAZvdwo6XLs4Vl6sXu8pqSOc2u9/+Ej7i9eIKkE+BX/SxEmXc70QKiMe8VhbUmGr4/l+60qfIgIgWLjwmitK7Cx+xnTnll2r/ajEGxttTnhJHYVffvHYHmhYPAZyn7B8yjUmxr8+zHewNp2vYg7Kl+LtPmvMQ4mZf3wECLb0RgvXIJVX7to6sMQlE5pQ9CbCDKG2gvEgC0ESnhwd2k2Xrkc59Uf1dbZTzSajlcHdghW+di/W+KnEDEFAh63ef+p/DA0z1S4rc+0SHz6yilHomzmmkCz9ZjUE1jVCVsH211vIZJnGnxZVRHi+hAHhwoPnlz1LFO+OL6Ch8Z4YWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COOZE5aqqJR9+5cT5FUY04n6pVWrgaFvLOFY4cof420=;
 b=A/Re8ZbnpHWOU2TdJh+5NV+QkkZ/P3vg8C1gQBz3YlKGpecMsNBg4GmtR5pkgBzl6tXUytSYDG7tqeeFWeDtd/2alGzUQhVQG5XwL1m8sEKrrMI7/B0MXJMF+4OoVYrDXukj7EZXaC64JfJwOj3314uoVgss9ITGLq2KkH8LaliFSOKRtt5nq4G1j+xqotnOaWPuqUpNtx4bd+oIN0v6hcj+x6H+th1nfqmyhf6Vuqt2YHXNqaByoix1haSzQdvO6fe830ZmD7iMhw4WgGFl+e04Cfu9R47vXnQpJLA+uSISeb3bZdSDeeJP0jqvV99YhD2e2RV1l8Qgsay65PKQiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COOZE5aqqJR9+5cT5FUY04n6pVWrgaFvLOFY4cof420=;
 b=CjhV0d6++UkNl14yaUeEeIPJk5BozdhKB6NoDhwbNsKMdkwIoot9IBcixMFsC29o/PLgPRvL0aejRz73XlTuBYRUqmT6JB0ZfjtlDP1DzMGjE/85r2GqYpQDuEWemv8jWwutbrnXkrKQy+aVK6NkmMrFccW8FbkuZJ1mAnDdFjc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0204.namprd12.prod.outlook.com (10.174.104.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Thu, 6 Feb 2020 02:39:50 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2686.031; Thu, 6 Feb 2020
 02:39:50 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu: use amdgpu_device_vram_access in
 amdgpu_ttm_access_memory
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Jonathan.Kim@amd.com
References: <20200205152238.45258-1-christian.koenig@amd.com>
 <20200205152238.45258-4-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <11397f96-251c-5bd2-7c24-268f02ee299b@amd.com>
Date: Wed, 5 Feb 2020 21:39:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200205152238.45258-4-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16)
 To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 02:39:49 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4bd0eef6-0466-4fd8-0d88-08d7aaadd682
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0204:|DM5PR1201MB0204:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02046933A412B47A90D49214921D0@DM5PR1201MB0204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(199004)(189003)(5660300002)(16526019)(186003)(2906002)(86362001)(6486002)(316002)(16576012)(478600001)(53546011)(31686004)(66574012)(26005)(31696002)(2616005)(956004)(36756003)(6636002)(81166006)(36916002)(52116002)(8676002)(81156014)(8936002)(66476007)(66556008)(44832011)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0204;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JxmsTsBpojxaFNPXvvwzN2t7L3oIpIeLOFdEoSpdjIAj5alNq9g38X87yD/T4DFzbLV83HiLsSiTW1M5FUI0Gg0Vi8rRcgDiMGT1Tmcby74HZbK1+ta5dRFWcNY6DPDdlKK9gT+aE5EVcHMh0JpqEdwRaSa8sTA7Z+LGM0vbRbb3FittRWc6jNXOVWbw1piQw0zAJJpvPYGkGna+JSbezhDoq5sBTn4AC4UebW4hZUYpxwRXqwAxHhBtD2x/WUWt9OyKFh4L5vI79Cl0a6F8SKXXNemTE3j2p4VVLjIVEoumv/O1Za35D61ZwEFT0HKo5FDkD5g6Xtn85o3H/IMCaHDT84d5xLLg5pBKACL4g6jBA48YMZdpzAPi7oKHC4csi6SujBOItzMbqSf3toEnjvuxhgYgvmbwlncXSEOpw9RdwhiSNEFm+D2ZXoI7CQ0U
X-MS-Exchange-AntiSpam-MessageData: sOd3REr49GecPl3A6LztYGDXeJQE2hqTd56bpacs9bxpPCtSj41QEUhKmfYbVnHNfdnAz+A5OAxJ1C4rowUrw3xBiZt2n76OH28mMWrV9DjTJOhLnV4WVa/SeCF6yy+XXH2FC/Hiypcut8tmNGDRmw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd0eef6-0466-4fd8-0d88-08d7aaadd682
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 02:39:50.2975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yijjxD4JSTQ3bao006OyJLYb07Fws1/gmEt37rjqc2C41evIJy7Iwe+UujE2KGyIzYe+0/t0E9ZZ5Ak8YOKbNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0204
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

T24gMjAyMC0wMi0wNSAxMDoyMiBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IE1ha2Ug
dXNlIG9mIHRoZSBiZXR0ZXIgcGVyZm9ybWFuY2UgaGVyZSBhcyB3ZWxsLgo+Cj4gVGhpcyBwYXRj
aCBpcyBvbmx5IGNvbXBpbGUgdGVzdGVkIQo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgMzggKysrKysrKysrKysrKysrLS0tLS0tLS0tLQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+IGluZGV4IDU4ZDE0M2IyNGJh
MC4uNTM4YzNiNTJiNzEyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV90dG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90
dG0uYwo+IEBAIC0xNTY1LDcgKzE1NjUsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV90dG1fYWNjZXNz
X21lbW9yeShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAo+ICAgCj4gICAJd2hpbGUgKGxl
biAmJiBwb3MgPCBhZGV2LT5nbWMubWNfdnJhbV9zaXplKSB7Cj4gICAJCXVpbnQ2NF90IGFsaWdu
ZWRfcG9zID0gcG9zICYgfih1aW50NjRfdCkzOwo+IC0JCXVpbnQzMl90IGJ5dGVzID0gNCAtIChw
b3MgJiAzKTsKPiArCQl1aW50NjRfdCBieXRlcyA9IDQgLSAocG9zICYgMyk7Cj4gICAJCXVpbnQz
Ml90IHNoaWZ0ID0gKHBvcyAmIDMpICogODsKPiAgIAkJdWludDMyX3QgbWFzayA9IDB4ZmZmZmZm
ZmYgPDwgc2hpZnQ7Cj4gICAKPiBAQCAtMTU3NCwyMCArMTU3NCwyOCBAQCBzdGF0aWMgaW50IGFt
ZGdwdV90dG1fYWNjZXNzX21lbW9yeShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAo+ICAg
CQkJYnl0ZXMgPSBsZW47Cj4gICAJCX0KPiAgIAo+IC0JCXNwaW5fbG9ja19pcnFzYXZlKCZhZGV2
LT5tbWlvX2lkeF9sb2NrLCBmbGFncyk7Cj4gLQkJV1JFRzMyX05PX0tJUShtbU1NX0lOREVYLCAo
KHVpbnQzMl90KWFsaWduZWRfcG9zKSB8IDB4ODAwMDAwMDApOwo+IC0JCVdSRUczMl9OT19LSVEo
bW1NTV9JTkRFWF9ISSwgYWxpZ25lZF9wb3MgPj4gMzEpOwo+IC0JCWlmICghd3JpdGUgfHwgbWFz
ayAhPSAweGZmZmZmZmZmKQo+IC0JCQl2YWx1ZSA9IFJSRUczMl9OT19LSVEobW1NTV9EQVRBKTsK
PiAtCQlpZiAod3JpdGUpIHsKPiAtCQkJdmFsdWUgJj0gfm1hc2s7Cj4gLQkJCXZhbHVlIHw9ICgq
KHVpbnQzMl90ICopYnVmIDw8IHNoaWZ0KSAmIG1hc2s7Cj4gLQkJCVdSRUczMl9OT19LSVEobW1N
TV9EQVRBLCB2YWx1ZSk7Cj4gLQkJfQo+IC0JCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmFkZXYt
Pm1taW9faWR4X2xvY2ssIGZsYWdzKTsKPiAtCQlpZiAoIXdyaXRlKSB7Cj4gLQkJCXZhbHVlID0g
KHZhbHVlICYgbWFzaykgPj4gc2hpZnQ7Cj4gLQkJCW1lbWNweShidWYsICZ2YWx1ZSwgYnl0ZXMp
Owo+ICsJCWlmIChtYXNrICE9IDB4ZmZmZmZmZmYpIHsKPiArCQkJc3Bpbl9sb2NrX2lycXNhdmUo
JmFkZXYtPm1taW9faWR4X2xvY2ssIGZsYWdzKTsKPiArCQkJV1JFRzMyX05PX0tJUShtbU1NX0lO
REVYLCAoKHVpbnQzMl90KWFsaWduZWRfcG9zKSB8IDB4ODAwMDAwMDApOwo+ICsJCQlXUkVHMzJf
Tk9fS0lRKG1tTU1fSU5ERVhfSEksIGFsaWduZWRfcG9zID4+IDMxKTsKPiArCQkJaWYgKCF3cml0
ZSB8fCBtYXNrICE9IDB4ZmZmZmZmZmYpCj4gKwkJCQl2YWx1ZSA9IFJSRUczMl9OT19LSVEobW1N
TV9EQVRBKTsKPiArCQkJaWYgKHdyaXRlKSB7Cj4gKwkJCQl2YWx1ZSAmPSB+bWFzazsKPiArCQkJ
CXZhbHVlIHw9ICgqKHVpbnQzMl90ICopYnVmIDw8IHNoaWZ0KSAmIG1hc2s7Cj4gKwkJCQlXUkVH
MzJfTk9fS0lRKG1tTU1fREFUQSwgdmFsdWUpOwo+ICsJCQl9Cj4gKwkJCXNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJmFkZXYtPm1taW9faWR4X2xvY2ssIGZsYWdzKTsKPiArCQkJaWYgKCF3cml0ZSkg
ewo+ICsJCQkJdmFsdWUgPSAodmFsdWUgJiBtYXNrKSA+PiBzaGlmdDsKPiArCQkJCW1lbWNweShi
dWYsICZ2YWx1ZSwgYnl0ZXMpOwo+ICsJCQl9Cj4gKwkJfSBlbHNlIHsKPiArCQkJYnl0ZXMgPSAo
bm9kZXMtPnN0YXJ0ICsgbm9kZXMtPnNpemUpIDw8IFBBR0VfU0hJRlQ7Cj4gKwkJCWJ5dGVzID0g
bWluKHBvcyAtIGJ5dGVzLCAodWludDY0X3QpbGVuICYgfjB4M3VsbCk7CgpJIHRoaW5rIHRoaXMg
aXMgaW5jb3JyZWN0LiBUaGUgZm9sbG93aW5nIHNob3VsZCBiZSB0cnVlOiBwb3MgPCAKKChub2Rl
cy0+c3RhcnQgKyBub2Rlcy0+c2l6ZSkgPDwgUEFHRV9TSElGVCkuIENvbnNlcXVlbnRseSBwb3Mg
LSBieXRlcyAKaXMgYWx3YXlzIG5lZ2F0aXZlIGhlcmUuIEJ1dCBiZWNhdXNlIHlvdSdyZSBkb2lu
ZyB1bnNpZ25lZCBtYXRoIGl0IHdpbGwgCnVuZGVyZmxvdyB0byBhIGJpZyBwb3NpdGl2ZSBudW1i
ZXIsIHdoaWNoIGlzIG5ldmVyIHRoZSBtaW5pbXVtLiAKVGhlcmVmb3JlIHRoZSBtaW4gd2lsbCBh
bHdheXMgYmUgbGVuICYgfjB4M3VsbC4KCkkgYmVsaWV2ZSB0aGlzIHNob3VsZCBiZSBtaW4oYnl0
ZXMgLSBwb3MsICh1aW50NjRfdClsZW4gJiB+MHgzdWxsKS4KCkpvbiwgdG8gY2F0Y2ggdGhpcyBi
dWcsIHlvdSdkIG5lZWQgYSB0ZXN0IHRoYXQgZmlyc3QgZnJhZ21lbnRzIFZSQU0gCihhbGxvY2F0
ZXMgbG90cyBvZiAyTUIgYnVmZmVycyBhbmQgZnJlZXMgZXZlcnkgb3RoZXIgYnVmZmVyKSwgdGhl
biAKYWxsb2NhdGVzIGEgbGFyZ2Ugbm9uLWNvbnRpZ3VvdXMgYnVmZmVyLiBUaGVuIHlvdSBuZWVk
IG9uZSA0S0Igb3IgCnNtYWxsZXIgYWNjZXNzIHRoYXQgY3Jvc3NlcyBhIGJvdW5kYXJ5IGJldHdl
ZW4gMk1CIFZSQU0gYnVmZmVyIGNodW5rcy4KCkNocmlzdGlhbiwgeW91ciBvcHRpbWl6ZWQgVlJB
TSBhbGxvY2F0b3IgdGhhdCB0cmllcyB0byBnZXQgbGFyZ2UgCmNvbnRpZ3VvdXMgY2h1bmtzIGlz
IG5pY2UgZm9yIHBlcmZvcm1hbmNlLCBidXQgaXQgcHJvYmFibHkgaGFzIGEgCnRlbmRlbmN5IHRv
IGhpZGUgdGhpcyBraW5kIG9mIGJ1Zy4gSSB3b25kZXIgaWYgd2Ugc2hvdWxkIGhhdmUgYSBkZWJ1
ZyAKbW9kZSB0aGF0IGZvcmNlcyBub24tY29udGlndW91cyBidWZmZXJzIHRvIGJlIGFjdHVhbGx5
IG5vbi1jb250aWd1b3VzLgoKUmVnYXJkcywKIMKgIEZlbGl4Cgo+ICsKPiArCQkJYW1kZ3B1X2Rl
dmljZV92cmFtX2FjY2VzcyhhZGV2LCBwb3MsICh1aW50MzJfdCAqKWJ1ZiwKPiArCQkJCQkJICBi
eXRlcywgd3JpdGUpOwo+ICAgCQl9Cj4gICAKPiAgIAkJcmV0ICs9IGJ5dGVzOwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
