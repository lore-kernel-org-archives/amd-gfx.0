Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350D7C433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080A02068E
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0mWlYDzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080A02068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F4C26E429;
	Tue,  1 Sep 2020 07:46:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C00B36E429
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 07:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2MCZdXwdHQaeUkTSoocmZHy6qeq7xBG52pLHLT/xGAOXKegAaiS1X2H6RJZaON9kKXq++t3cod+rQoyjibh2TaSG9mDGo1MbLfvrKd55tUcu2EQqWeu0JNKuW6weVqf2ZhqfGy/UvCKXmJN2TCwq62az2EDz5h53dzdDGU4cqPJWc8mKyaK/Y7rSpaX02gGIzbI89gcTa6XH/tffu5WSUlh9V5AS8J+wGPtI4cahLTxiTnSUVOzxBZMWb+s/i5tp+N7yvceH4AxKnRvWVo6NzJOOt1uk9ht/1n+wEIVtiJxLikzMWH3ISjvwoVQFdk705icviHtD5GTnV3k6xGDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+H6KscE7c8bkUIpLO1qgp0qCvcy6di2IWjIC9EbLIo=;
 b=Hhx/hNYXxegdd00oeki+TQ/qf1Di5C5+kBxlgVBGtrxxq7W7rjGWTpTwi752rVfwYEUrlBypDUPtrNPVYjFOMjiJmckzhzl39dNM9PI9splkaLkhlhtNejvQzHXftyUIkJVUomH+JkhBKMRx/pB5GgD6d6Alc3WOdeaZSoCeO1PEoBqxoFLzAZX93JeEWK896CiO1FKeZqVuZYc7eWezD6lSuLASVrYzrTekaXlbwuwTZjc5VGDpHd8KVgyU17dUzPYgxXV0IOh72fq12o/urkoZa5ht/p2OFV2xqpL72Hl+B+szVc/RyI8L1Q/rCpVvH7DrgmKhl6fbNQxaNo265A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+H6KscE7c8bkUIpLO1qgp0qCvcy6di2IWjIC9EbLIo=;
 b=0mWlYDzFJI3145UG9STTSyl4+pPuereOsU3ggdDErc1CzKrNGwj0Yubr6Sa7jGVyTusEuflsbOGMSbZmcpbyKnTIhdM4G0aFnojzTh4ZcZpY8hBndTWEbpbJ8lc7jJneBQxxjnM/k/GE/LfE8KsusT76hdgwchKc7Zc5BFtj5ys=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1419.namprd12.prod.outlook.com (2603:10b6:3:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Tue, 1 Sep
 2020 07:46:26 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 07:46:26 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: disable gpu-sched load balance for uvd
To: Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200831104553.10207-1-nirmoy.das@amd.com>
 <83ada1bd-ced4-8422-f90e-502c30477798@molgen.mpg.de>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <0206a4ad-3574-7c5a-00e1-1d541bc902f4@amd.com>
Date: Tue, 1 Sep 2020 09:50:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <83ada1bd-ced4-8422-f90e-502c30477798@molgen.mpg.de>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0302CA0017.eurprd03.prod.outlook.com
 (2603:10a6:205:2::30) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM4PR0302CA0017.eurprd03.prod.outlook.com (2603:10a6:205:2::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Tue, 1 Sep 2020 07:46:24 +0000
X-Originating-IP: [217.86.126.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3bd90ec4-0732-49cb-b0f2-08d84e4b211c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1419:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1419F9AA5024806324366B808B2E0@DM5PR12MB1419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:343;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ElZpJNVwqAvg4Nipf2cCYqKfKklccxR9C3hGJiQYjVPuhkCbqoMgeKsBsxywrE7yxu2GzX8+zjMimg6Bhizb+BVT0VkJ27e5yKX2FB6tmDXkike6ip0N78mrgpbFHhDGU5p0qjvznnAGVR9SExCohDIA7btPpAmJ9cR6zJm1yo+XO+AqgLIE4P+WvLUkkYu9RlXCMgScHuWcmbYZIzF8ia2up+JseudKZLYDIGym5oOMd0ybvDuR3ReNBskJmCeqqtA64HAntptBwfiUrLFDr4PTophPWC1mw0FpJC0kXNQe9cZUWH5qAMum2egU7QHMQN4r6gDgj2FhRlzsTGnfbD2hPGPM8RnY5eqMriv543FaS3nT/taP3QPwCG6fQsgC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(66556008)(31686004)(956004)(52116002)(186003)(26005)(54906003)(110136005)(2616005)(478600001)(5660300002)(16576012)(53546011)(316002)(6486002)(8676002)(31696002)(66946007)(2906002)(6666004)(8936002)(66476007)(83380400001)(36756003)(4326008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: tBJSimXqhTXRlvOYce0JHn98ugLUIkdsb74aBTBISBZy+itMq7Dai0cdYkXOgssJxeZOtvt5866DNE/t0hHPrk/d+yyGIg8QpENXFi54otK2jjrM3K10q8az+h/qY5s8AJqS24Jj28XA2vzGsZ7oTDGq2v6n1kR+8koupBwPF5Y8AFLgGKUNmP+On482DpGnsqs4RE0RBp8QPSj7UB7HSr9oIQWqLywH1Q/B09MjGLNmX12jspBftcIrEnhQPTcdagbXsXaogWLPiu7K7cTUBNRY0XyAFKl8BmIMNwIqHQ1/p5igIBdpQ0ypikLbUWr9g2Z65Q936M2xJLqmn11ZHjZ7wNEPtUJcBYOo1z9VBaaMP4XX7lDeFTppOxCgnl6uTILCPQIDhoaZXKYQfKhFplPf7IBaCt0gwHxSslI2Bvv7Oy2vZRe+QUbmk/qw3Yi4B3dcdx7oETu/dpiih0cFKRfNbRGIy3DjHP1nX1bXhbFGe2XdOyGEAKNZiPB2MVnQzA/yPgsthSKBzqWibNNis2dPNdNvJOD9dT0WnK8xpYithDJJpxgypZQpA8+eTKNiUPJonGr3d+9N0d15npgx3GmfMY0g23/wvE8H+Bo0ly4ju23GlE8SQWXoX1j1U5jUL8Pb71LOT53wGlvXoZ5a2A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd90ec4-0732-49cb-b0f2-08d84e4b211c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 07:46:26.1215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWIMMTLRq1V0RG2xxjCvufn2M0JrvKj0BfhPtr4wzJH3AQDVXH2XULZhzgM3rBvIENfp3y3PLay5yY+h5z5S/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1419
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Tianci Yin <Tianci.Yin@amd.com>, Leo Liu <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDkvMS8yMCA5OjA3IEFNLCBQYXVsIE1lbnplbCB3cm90ZToKPiBEZWFyIE5pcm1veSwKPgo+
Cj4gQW0gMzEuMDguMjAgdW0gMTI6NDUgc2NocmllYiBOaXJtb3kgRGFzOgo+PiBVVkQgZGVwZW5k
ZW50IGpvYnMgc2hvdWxkIHJ1biBvbiB0aGUgc2FtZSB1ZHYgaW5zdGFuY2UuCj4KPiBXaHk/IERh
dGFzaGVldD8gUGVyZm9ybWFuY2UgcmVhc29ucz8gV2hhdCBoYXBwZW5zIGlmIHRoZXkgZG8gbm90
IHJ1biAKPiBvbiB0aGUgVVZEIGluc3RhbmNlPyBBcmUgdGhlcmUgYnVnIHJlcG9ydHM/CgoKU29y
cnkgYWJvdXQgdGhhdCwgSSBzaG91bGQndmUgZWxhYm9yYXRlZCBtb3JlLiBJIHdpbGwgdGFrZSBj
YXJlIG9mIHRoYXQgCmluIG15IG5leHQgcGF0Y2guCgoKTmlybW95CgoKPgo+IEl04oCZZCBiZSBn
cmVhdCBpZiB5b3UgZXh0ZW5kZWQgdGhlIGNvbW1pdCBtZXNzYWdlLgo+Cj4+IFRoaXMgcGF0Y2gg
ZGlzYWJsZXMgZ3B1IHNjaGVkdWxlcidzIGxvYWQgYmFsYW5jZXIgZm9yCj4+IGEgY29udGV4dCB3
aGljaCBiaW5kcyBqb2JzIGZyb20gc2FtZSB0aGUgY29udGV4dCB0byBhIHVkdgo+PiBpbnN0YW5j
ZS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgo+
PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jIHwgNCAr
KystCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
Pj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHgu
YyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKPj4gaW5kZXgg
NTkwMzJjMjZmYzgyLi43Y2QzOThkMjU0OTggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfY3R4LmMKPj4gQEAgLTExNCw3ICsxMTQsOSBAQCBzdGF0aWMgaW50IGFtZGdw
dV9jdHhfaW5pdF9lbnRpdHkoc3RydWN0IAo+PiBhbWRncHVfY3R4ICpjdHgsIHUzMiBod19pcCwK
Pj4gwqDCoMKgwqDCoCBzY2hlZHMgPSBhZGV2LT5ncHVfc2NoZWRbaHdfaXBdW2h3X3ByaW9dLnNj
aGVkOwo+PiDCoMKgwqDCoMKgIG51bV9zY2hlZHMgPSBhZGV2LT5ncHVfc2NoZWRbaHdfaXBdW2h3
X3ByaW9dLm51bV9zY2hlZHM7Cj4+Cj4+IC3CoMKgwqAgaWYgKGh3X2lwID09IEFNREdQVV9IV19J
UF9WQ05fRU5DIHx8IGh3X2lwID09IAo+PiBBTURHUFVfSFdfSVBfVkNOX0RFQykgewo+PiArwqDC
oMKgIGlmIChod19pcCA9PSBBTURHUFVfSFdfSVBfVkNOX0VOQyB8fAo+PiArwqDCoMKgwqDCoMKg
wqAgaHdfaXAgPT0gQU1ER1BVX0hXX0lQX1ZDTl9ERUMgfHwKPj4gK8KgwqDCoMKgwqDCoMKgIGh3
X2lwID09IEFNREdQVV9IV19JUF9VVkQpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHNjaGVkID0g
ZHJtX3NjaGVkX3BpY2tfYmVzdChzY2hlZHMsIG51bV9zY2hlZHMpOwo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgc2NoZWRzID0gJnNjaGVkOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbnVtX3NjaGVkcyA9
IDE7Cj4KPgo+IEtpbmQgcmVnYXJkcywKPgo+IFBhdWwKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
