Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C067CC4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 14:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FEEE2074B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 14:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AFQakR/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEEE2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AE1989BF0;
	Tue, 29 Sep 2020 14:37:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB0E89BF0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 14:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lScWQ0c0vmRXze8gxHNP7i5kTTGfXcFRVevai10fgAlkmjyohoC8yaUBohSpkjHbI8wOm/rsXJHw7Zwv6tBwczAgS/zmmCTzesAepGVUUpQtLqz1DEF4t+cxHdPesPNLlA1ZJbmGyvuLF9CTIBYWncthLJPROlaHvtUCUl9vjEYCtVHuZ6ueRKhVPifW/D38Xo/EJ2N7UZad7C1G/ig40NpxdzY1MraqJli/ruHU/BQDlfzWn8SMf/taZ8copP0qmIxSvDXAtTq0cw3kHJx7gD5Khlcyijj+Ocz8oB4/MOlWbQyUBOkYoYkzHivEwLbFI3QsX2d9NcsKBqJD6NWPEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTxT59CdjivYiYycK9C1lgJihynUvYPwdLxGQmCZpUs=;
 b=XyF3vAZFSqBCJMdzqCqsNJc1AlFDCn8FVBFZnpCg8OAavBlSdwno05l9JIu8Bx3vW0xMm5eAUJduiwyjrtUTUAswOB3zq9pYLvd1w9YtUEiAlgaL60mDGPBE2w1Nk1YYhfzGlXT8clKm7OL+2lgfWQh4+77qqSmMKf0du0sbyeJ1WaWV60BmIAw1DOrU2G8ztoDE3B5PoY6nn/5rxtwEUyHWHRWp8ArUl+2FagPxXseNi7afRPqPhCI0tE3jUbAVdAtjZrnkEAS78jXL1uNUPsuRQrP+QR1imhX1ADdfc6SYYBAwSCcrFdElzTa/Dg04o0RarfWiThXRWoycT4jFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTxT59CdjivYiYycK9C1lgJihynUvYPwdLxGQmCZpUs=;
 b=AFQakR/bjUvMmJpl5Vw7Vnsuxp/p35PXEkEEnBIqxFYwc5PMLK5oLG7svmGhUzimGwa8/S/0OM9jV8Zo1Xzr4tKrKrhm73FAO0wa5FwGGcJOVbGC+q8SN3abwnV6IGjjmgnNqyr4hgBhH2Nx8HSMsjMpm3vg+6c/hyOeiKLc57E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 14:37:29 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 14:37:29 +0000
Subject: Re: [PATCH] drm/amdgpu: Use SKU instead of DID for FRU check
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200929113139.5069-1-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <83ef8e06-940d-dd0b-68d7-278cbd4b309c@amd.com>
Date: Tue, 29 Sep 2020 10:37:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200929113139.5069-1-kent.russell@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.113.11]
X-ClientProxiedBy: YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::46) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Tue, 29 Sep 2020 14:37:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f3048f7-2154-4f23-e2a9-08d864853104
X-MS-TrafficTypeDiagnostic: SA0PR12MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4592B4E4B165DA69219D936992320@SA0PR12MB4592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+2kqmODyS92FKMyY3SnGGMdtggWjdpZvBv+d3ybqkjECA1bGkmmOkJn0GthmobDeOQdgdR3o4SN+i6ifjzZZknradByykUAiqOX/zMUMavRsycoUI03ZxNjFzQTVQfgsGQ+Uljr2TGIOUzz0yaZegttsj9oUjSiY1BmMvNkKJdnAE3SiqtTDKTvAijFHaY+m+6vPABOuGhCLxEQxRf2cS3KPYd1NH8QWRfZ3McG4wcoUk78+NXxq67qw2rR07mWNgT+xOcJcHetr29sTj+5MfX3h0IjV4k/rJbmqqRpZG/2bnzzLzaY6mlSewnk/5Us2eR3tYzrhJVSG/KPIJuYpfebr9Q4HZlQJPuBKAsRjc0UYYNv92nFGVV+5b3E/I8IPqIN+u0kAuZzeaLqrlDevizbsEha/HSmuR7uPr35xkbwCQqKhdtBBijcdTjnPfbG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(52116002)(956004)(31686004)(16576012)(316002)(5660300002)(2616005)(36756003)(8936002)(8676002)(26005)(186003)(16526019)(44832011)(6486002)(86362001)(478600001)(31696002)(2906002)(83380400001)(66556008)(66946007)(66476007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Czdva78XaPtETPtVRI9I+3Cv00Lj/5EXEfx0roV8fplkERrBZ+L4LyuFs7qiL7UNLea1YFcop4kU1OKCPW0REWMvZOC6yIRykSewqEb7t9RazdT8pj5rBB6J8pOJelIamHRKYxN68YGDlSdpCxXfHNycDmymLlnzVbHy/5TGD+hugSYPeU6LyZ3RLx8dv332VkzO747HXV4veOTWptqCZxxpgw2LOlr5jmuqnBGmzZEprNTUy1hglPQm/A5O7iueOupnnfKyrgbN3r2BMVhgkC7g3zqq3QjmEwPCaJjjhBdsX2btcm2CCQuBCW6N1PjBVEqKFGub20SGPy1xOvBLMt+Bs2jKch1k41eeEHDuTDUXqM/wuwVlB9r2ZxNgppLfGbOGdwh2cOkty6BW+wEbI82epUTZoxFfnou4U8Yn2XUKSZtDBe/WYLoeTlOBVFKHkMlAYM8ZAWdk+wWmNWRxktHze1ZdqOm5wuO0TeeqRrHl8ywd0BsitjxRC0MCvtdNXBT++AI1rWzpd8fq3t7jeiZmghr37TAvzM0fcIMyNSon6Y64ZEZLnhuKmm5HCYrmUQlfu1zQh2qHisc0qoiPT+hsG69q5VHb5T3PjFo6TqvW9XDcKXofWBcHX2d/BNgO4y06Bf7QJoZCrcHn0ApHYQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3048f7-2154-4f23-e2a9-08d864853104
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 14:37:29.2194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXTBI7jSvHzM4k8m3VjOnrHWj9bTOX4AbDRL0a/7D9QQ5vm+uIQ4DLN6/dmhRX6pCefs4mAJUfhqARJywO17Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDIwMjAtMDktMjkgdW0gNzozMSBhLm0uIHNjaHJpZWIgS2VudCBSdXNzZWxsOgo+IFRoZSBW
RzIwIERJRHMgNjZhMCwgNjZhMSBhbmQgNjZhNCBhcmUgdXNlZCBmb3IgdmFyaW91cyBTS1VzIHRo
YXQgbWF5IG9yIG1heQo+IG5vdCBoYXZlIHRoZSBGUlUgRUVQUk9NIG9uIGl0LiBQYXJzZSB0aGUg
VkJJT1MgdG8gY2hlY2sgZm9yIHNlcnZlciBTS1UKPiB2YXJpYW50cyAoRDEzMSBvciBEMTM0KSB1
bnRpbCBhIG1vcmUgZ2VuZXJhbCBzb2x1dGlvbiBjYW4gYmUgZGV0ZXJtaW5lZC4KPgo+IFNpZ25l
ZC1vZmYtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFtZC5jb20+Cj4gLS0tCj4gIC4u
Li9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZydV9lZXByb20uYyAgICB8IDM3ICsrKysrKysr
KysrKystLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDExIGRlbGV0
aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9mcnVfZWVwcm9tLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2Vl
cHJvbS5jCj4gaW5kZXggZTgxMWZlY2M1NDBmLi44MjIwN2I3NTg4MDAgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZydV9lZXByb20uYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMKPiBAQCAtMzQsMTgg
KzM0LDMzIEBACj4gIAo+ICBzdGF0aWMgYm9vbCBpc19mcnVfZWVwcm9tX3N1cHBvcnRlZChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgewo+IC0JLyogVE9ETzogR2FtaW5nIFNLVXMgZG9u
J3QgaGF2ZSB0aGUgRlJVIEVFUFJPTS4KPiAtCSAqIFVzZSB0aGlzIGhhY2sgdG8gYWRkcmVzcyBo
YW5ncyBvbiBtb2Rwcm9iZSBvbiBnYW1pbmcgU0tVcwo+IC0JICogdW50aWwgYSBwcm9wZXIgc29s
dXRpb24gY2FuIGJlIGltcGxlbWVudGVkIGJ5IG9ubHkgc3VwcG9ydGluZwo+IC0JICogdGhlIGV4
cGxpY2l0IGNoaXAgSURzIGZvciBWRzIwIFNlcnZlciBjYXJkcwo+IC0JICoKPiAtCSAqIFRPRE86
IEFkZCBsaXN0IG9mIHN1cHBvcnRlZCBBcmN0dXJ1cyBESURzIG9uY2UgY29uZmlybWVkCj4gKwkv
KiBUT0RPOiBTZWUgaWYgd2UgY2FuIGZpZ3VyZSB0aGlzIG91dCBkeW5hbWljYWxseSBpbnN0ZWFk
IG9mCj4gKwkgKiBoYXZpbmcgdG8gcGFyc2UgVkJJT1MgdmVyc2lvbnMuCj4gIAkgKi8KPiAtCWlm
ICgoYWRldi0+YXNpY190eXBlID09IENISVBfVkVHQTIwICYmIGFkZXYtPnBkZXYtPmRldmljZSA9
PSAweDY2YTApIHx8Cj4gLQkgICAgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFR0EyMCAmJiBh
ZGV2LT5wZGV2LT5kZXZpY2UgPT0gMHg2NmExKSB8fAo+IC0JICAgIChhZGV2LT5hc2ljX3R5cGUg
PT0gQ0hJUF9WRUdBMjAgJiYgYWRldi0+cGRldi0+ZGV2aWNlID09IDB4NjZhNCkpCj4gLQkJcmV0
dXJuIHRydWU7Cj4gLQlyZXR1cm4gZmFsc2U7Cj4gKwlzdHJ1Y3QgYXRvbV9jb250ZXh0ICphdG9t
X2N0eCA9IGFkZXYtPm1vZGVfaW5mby5hdG9tX2NvbnRleHQ7Cj4gKwljaGFyIG1vZGVsWzNdOwo+
ICsJaW50IG1vZGVsbnVtOwo+ICsKPiArCS8qIFZCSU9TIGlzIG9mIHRoZSBmb3JtYXQgIyMjLURY
WFhYWVktWFguIFdlIG9ubHkgd2FudCB0aGUgZmlyc3QKCkknbSBub3Qgc3VyZSBJIHVuZGVyc3Rh
bmQgdGhlIGZvcm1hdCBoZXJlLiBUaGVyZSBhcmUgZm91ciBYLCBidXQgeW91Cm9ubHkgd2FudCB0
aGUgZmlyc3QgdGhyZWUgb2YgdGhlbT8KCldoYXQgYXJlIHRoZSB0d28gWCBpbiB0aGUgZW5kPyBh
cmUgdGhleSByZWxhdGVkIHRvIHRoZSBmaXJzdCBmb3VyIFg/CgoKPiArCSAqIDMgZGlnaXRzIGFm
dGVyIHRoZSBELCBhbmQgaWYgd2UgY29udmVydCBpdCB0byBhIGhleCBpbnRlZ2VyLAo+ICsJICog
d2UgY2FuIHVzZSBzd2l0Y2ggZm9yIGVhc2Uvc3BlZWQvcmVhZGFiaWxpdHkgYW5kIHBvdGVudGlh
bAo+ICsJICogZXhwYW5kYWJpbGl0eSBpZiByZXF1aXJlZAo+ICsJICovCj4gKwlzdHJuY3B5KG1v
ZGVsLCBhdG9tX2N0eC0+dmJpb3NfdmVyc2lvbiArIDUsIDMpOwoKVGhpcyBwcm9kdWNlcyBhIHN0
cmluZyBpbiBfbW9kZWxfIHRoYXQncyBub3QgMC10ZXJtaW5hdGVkLgoKCj4gKwltb2RlbG51bSA9
IHN0cnRvdWwobW9kZWwsIE5VTEwsIDE2KTsKClVzaW5nIHN0cnRvdWwgb24gYSBub24tdGVybWlu
YXRlZCBzdHJpbmcgaXMgbm90IHJlbGlhYmxlLgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+ICsJc3dp
dGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKPiArCWNhc2UgQ0hJUF9WRUdBMjA6Cj4gKwkJc3dpdGNo
IChtb2RlbG51bSkgewo+ICsJCS8qIFRoZXNlIGFyZSB0aGUgc2VydmVyIFZHMjAgU0tVcyAqLwo+
ICsJCWNhc2UgMHgxNjE6Cj4gKwkJY2FzZSAweDE2MzoKPiArCQkJcmV0dXJuIHRydWU7Cj4gKwkJ
ZGVmYXVsdDoKPiArCQkJcmV0dXJuIGZhbHNlOwo+ICsJCX0KPiArCWRlZmF1bHQ6Cj4gKwkJcmV0
dXJuIGZhbHNlOwo+ICsJfQo+ICB9Cj4gIAo+ICBzdGF0aWMgaW50IGFtZGdwdV9mcnVfcmVhZF9l
ZXByb20oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IGFkZHJwdHIsCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
