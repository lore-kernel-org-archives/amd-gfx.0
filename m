Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1BCC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 08:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1212920774
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 08:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uqu3JVT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1212920774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B74789B9F;
	Wed, 12 Aug 2020 08:16:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A6AF6E075
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 08:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3OP2opgm2sphvyvtnWPc8x+s1HGmdS0bOqhE2sg7z3ROnJ8hYF+u/5/W2K6UzC5Iql55JGJCe6Z33moPt5tX/JdHQW1WvcekAVeAdnHZNAfxVdR9tduiFntucdVVkOW8TEyVGcntPbkN8p4V+foWxFg8XLiufDVAzMKN3S2lfVmGbtRVF6pS7KPIEP6GCK4BDUDEVyhOiAE6yAR3sNo+qAnsiCAzeiFon2wuG7vp6L7HZ3QIy2YXxZHmIXjgPup7KAHdXONtQzTM3jhKmsaPSKSp2c9MvN1FAYczGuE51yZ5FiHnMQZyfAMdrAeKveX7sP7cbrjOtr0ztxDUyhpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZnHK9ig7XeYNtz14P3PQN1J6M9TGk/nW5T3YY6szQY=;
 b=BKqaAp+bNV3iC6Jb+DF06bfiaCXO5Z5LTDIPKw6AhInJOQCPWq3WXBBAEqZxyFzoVG3ZaSVAY8xrvceZ7n/ATrj7p/iVycBEbHgIzSKOjDf2HBPYkk9x7920Wxzc7OUtZ/WrHDVjeakSh9biFAnoGZuYR0nQxpw27BrIhk9+RS+kDWCm+Rn8v2WlDvQd75rrtQl0Nsz7SL3VIYwn9RF8hiCVbbeQpsnRfFc39D1YVz21ZdVWfiENAuGNpb8Sq+aHOXIEMBrtlz+oThWrzve45zMQUoJfgm84YnLgsz9PZ9Vwz4aaQ+rFxhncvOGGMsa5KpjNboWCnydkTTbTjDacrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZnHK9ig7XeYNtz14P3PQN1J6M9TGk/nW5T3YY6szQY=;
 b=uqu3JVT1QwSuw5sf1Fq2k4zfZX1k52wS0Agnyc0QIIA3no/gaEz4UOUOESa6ia1SplNgaqWxy7xVOjbRUem/R3+K7/mQZZfLgYtJxsOpB0jJnmaEdEMyRnP6LPDjHNR+qLgSfI9LsnkhYjYNCX90awEAp9p+rmFoyFt0XkaJEKA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3133.namprd12.prod.outlook.com (2603:10b6:208:c7::16)
 by MN2PR12MB3038.namprd12.prod.outlook.com (2603:10b6:208:cb::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Wed, 12 Aug
 2020 08:16:05 +0000
Received: from MN2PR12MB3133.namprd12.prod.outlook.com
 ([fe80::e8a2:4158:cd66:470f]) by MN2PR12MB3133.namprd12.prod.outlook.com
 ([fe80::e8a2:4158:cd66:470f%6]) with mapi id 15.20.3261.026; Wed, 12 Aug 2020
 08:16:05 +0000
Subject: Re: [PATCH v3] drm/amdgpu: add new trace event for page table update
 v3
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20200812043336.127057-1-shashank.sharma@amd.com>
 <e32e6e5c-d808-44eb-7136-9b258c0201c1@gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <43f137f7-90cd-bb8b-f27f-a80a6c18aedc@amd.com>
Date: Wed, 12 Aug 2020 13:45:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
In-Reply-To: <e32e6e5c-d808-44eb-7136-9b258c0201c1@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: BM1PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:40::13) To MN2PR12MB3133.namprd12.prod.outlook.com
 (2603:10b6:208:c7::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.155.163] (165.204.158.249) by
 BM1PR01CA0119.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:40::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Wed, 12 Aug 2020 08:16:03 +0000
X-Originating-IP: [165.204.158.249]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c629c6b9-00bf-4bb3-4463-08d83e97f568
X-MS-TrafficTypeDiagnostic: MN2PR12MB3038:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB30386F11F283B066C9E16D35F2420@MN2PR12MB3038.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sUhEqVOR1YPdAh3zo6GrbQwwZeIPdmNdgDMJGXIgCXrK+WTbjxS4O5FM0G3sdGeSS9jXxWmH/SFnZDMTxzC6whQ/HQwIZ05W+bTmvK+526Q6M2+QXbEC3zYWTh2L/kiw84lomhM2I+BpX0HzpZx6Z7AvwcPcgz6+tU+ASYn3tuwqbkeHgXn4BuzE8bfyPi0UZapgSOCs6Nxj/4bGG5/oXnIVIN3r+g58gHyHLF/H1R16fFuMJrH5S6vNWXWQ+iDp5TMrI/1mU84+R1s9QWj6WT43DHflN93Wx7v5GIRBEltjY1sroRNsOdRiRMs90ybr7+ykjZo5xLSzlSlkIFurVhzVpiA7ky0bF+HGSEDGMj0rmS2pGpmCtMJNKdn3rfTq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(44832011)(478600001)(53546011)(83380400001)(6486002)(186003)(66574015)(5660300002)(16526019)(4326008)(8676002)(6666004)(8936002)(66556008)(66946007)(66476007)(26005)(956004)(2616005)(31696002)(36756003)(15650500001)(316002)(31686004)(86362001)(52116002)(16576012)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: YE4g5Td5cpimZOHkp8sCBtep7t1Yy13PY+U/MKxpqPb7SBeJ7AOrjRM4TjUCEczqQ3otXexwhgWcZEdX0mXhjPg8BUEq3nfMGMEFp4mBdMWZRUec931pxrI6KAeoNTKeZf+0lSr5utvFAXttTdJmNLn0tQ6wVQtBXy9Od9pfL1NU4w4a9atObTbVoQ2UpE3uLuZ9VWHy2sW9qYzTHrmDpZ5mCNHtc0oaq1J3dc2Au5HdbzQhvHp645q7xgoIp+xX/TF1Mn9W2D9xqxe8tg+S0mmVxTJuseWzVo53iYIiN9B3eWfug4VBA4eqdAM2Ie7HeHqYIpaEYaUVF70n/AO1sWBPwcNru48aITb2hiCfP+M7nXJ+QiDriqiiYA04w5kPHPRC4qAkLJTtUD/KbhGOc1x0o14VxphEMBwcuQTWTtn11/eo9P79/XXe/X0mQ3sKAE5Qrc3/a8RJOLezck8P4GT72UpBRB2PgaJHN39eA2RuD9mfl/eXJnKxRkz+WvZnu6E8M/tTcWf/GTpOlWYDRUybKSDXb0ZsoNyqs7xWhsqKnBLTY49ukGxnzKTYVGHKXrVzrjQ4xFVt+RI5sT69JSP+rVVTSTX/ivokG3U7UUzOQUqddhivfV/JeWwG2KJImeYUep3s9/vhJZg2KjsiYA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c629c6b9-00bf-4bb3-4463-08d83e97f568
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 08:16:05.3438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFpBdRcC5Y/ZMxhfUiEEmTUDwFmL683+Uz2icuhQ4o/X1JH2qBLcMNvKTqcFHnZ50Qb7rg8dvZ2S7Jx6tNftlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3038
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGVsbG8gQ2hyaXN0aWFuLAoKT24gMTIvMDgvMjAgMTI6MTUgcG0sIENocmlzdGlhbiBLw7ZuaWcg
d3JvdGU6Cj4gQW0gMTIuMDguMjAgdW0gMDY6MzMgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+
IFRoaXMgcGF0Y2ggYWRkcyBhIG5ldyB0cmFjZSBldmVudCB0byB0cmFjayB0aGUgUFRFIHVwZGF0
ZQo+PiBldmVudHMuIFRoaXMgc3BlY2lmaWMgZXZlbnQgd2lsbCBwcm92aWRlIGluZm9ybWF0aW9u
IGxpa2U6Cj4+IC0gc3RhcnQgYW5kIGVuZCBvZiB2aXJ0dWFsIG1lbW9yeSBtYXBwaW5nCj4+IC0g
SFcgZW5naW5lIGZsYWdzIGZvciB0aGUgbWFwCj4+IC0gcGh5c2ljYWwgYWRkcmVzcyBmb3IgbWFw
cGluZwo+Pgo+PiBUaGlzIHdpbGwgYmUgcGFydGljdWxhcmx5IHVzZWZ1bCBmb3IgbWVtb3J5IHBy
b2ZpbGluZyB0b29scwo+PiAobGlrZSBSTVYpIHdoaWNoIGFyZSBtb25pdG9yaW5nIHRoZSBwYWdl
IHRhYmxlIHVwZGF0ZSBldmVudHMuCj4+Cj4+IFYyOiBBZGRlZCBwaHlzaWNhbCBhZGRyZXNzIGxv
b2t1cCBsb2dpYyBpbiB0cmFjZSBwb2ludAo+PiBWMzogc3dpdGNoIHRvIHVzZSBfX2R5bmFtaWNf
YXJyYXkKPj4gICAgICBhZGRlZCBucHRlcyBpbnQgdGhlIFRQcHJpbnQgYXJndW1lbnRzIGxpc3QK
Pj4gICAgICBhZGRlZCBwYWdlIHNpemUgaW4gdGhlIGFyZyBsaXN0Cj4+Cj4+IENjOiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+IENjOiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogU2hhc2hh
bmsgU2hhcm1hIDxzaGFzaGFuay5zaGFybWFAYW1kLmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmggfCAzOCArKysrKysrKysrKysrKysrKysr
KysrKwo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jICAgIHwgIDkg
KysrKy0tCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3RyYWNlLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+PiBp
bmRleCA2M2U3MzRhMTI1ZmIuLmI5YWFlNzk4M2I0YiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPj4gQEAgLTMyMSw2ICszMjEsNDQgQEAgREVGSU5F
X0VWRU5UKGFtZGdwdV92bV9tYXBwaW5nLCBhbWRncHVfdm1fYm9fY3MsCj4+ICAgCSAgICBUUF9B
UkdTKG1hcHBpbmcpCj4+ICAgKTsKPj4gICAKPj4gK1RSQUNFX0VWRU5UKGFtZGdwdV92bV91cGRh
dGVfcHRlcywKPj4gKwkgICAgVFBfUFJPVE8oc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1z
ICpwLAo+PiArCQkgICAgIHVpbnQ2NF90IHN0YXJ0LCB1aW50NjRfdCBlbmQsCj4+ICsJCSAgICAg
dW5zaWduZWQgaW50IG5wdGVzLCB1aW50NjRfdCBkc3QsCj4+ICsJCSAgICAgdWludDY0X3QgaW5j
ciwgdWludDY0X3QgZmxhZ3MpLAo+PiArCVRQX0FSR1MocCwgc3RhcnQsIGVuZCwgbnB0ZXMsIGRz
dCwgaW5jciwgZmxhZ3MpLAo+PiArCVRQX1NUUlVDVF9fZW50cnkoCj4+ICsJCQkgX19maWVsZCh1
NjQsIHN0YXJ0KQo+PiArCQkJIF9fZmllbGQodTY0LCBlbmQpCj4+ICsJCQkgX19maWVsZCh1NjQs
IGZsYWdzKQo+PiArCQkJIF9fZmllbGQodTY0LCBpbmNyKQo+PiArCQkJIF9fZmllbGQodW5zaWdu
ZWQgaW50LCBucHRlcykKPj4gKwkJCSBfX2R5bmFtaWNfYXJyYXkodTY0LCBkc3QsIG5wdGVzKQo+
PiArCSksCj4+ICsKPj4gKwlUUF9mYXN0X2Fzc2lnbigKPj4gKwkJCXVuc2lnbmVkIGludCBpOwo+
PiArCj4+ICsJCQlfX2VudHJ5LT5zdGFydCA9IHN0YXJ0Owo+PiArCQkJX19lbnRyeS0+ZW5kID0g
ZW5kOwo+PiArCQkJX19lbnRyeS0+ZmxhZ3MgPSBmbGFnczsKPj4gKwkJCV9fZW50cnktPmluY3Ig
PSBpbmNyOwo+PiArCQkJX19lbnRyeS0+bnB0ZXMgPSBucHRlczsKPj4gKwo+PiArCQkJZm9yIChp
ID0gMDsgaSA8IG5wdGVzOyArK2kpIHsKPj4gKwkJCQl1NjQgYWRkciA9IHAtPnBhZ2VzX2FkZHIg
PyBhbWRncHVfdm1fbWFwX2dhcnQoCj4+ICsJCQkJCXAtPnBhZ2VzX2FkZHIsIGRzdCkgOiBkc3Q7
Cj4+ICsKPj4gKwkJCQkoKHU2NCAqKV9fZ2V0X2R5bmFtaWNfYXJyYXkoZHN0KSlbaV0gPSBhZGRy
Owo+PiArCQkJCWRzdCArPSBpbmNyOwo+PiArCQkJfQo+PiArCSksCj4+ICsJVFBfcHJpbnRrKCJz
ZWc6MHglMDEwbGx4LTB4JTAxMGxseCwgZmxhZ3M6MHglbGx4LCBucHRyPSV1LCBwZ3N6OiVsbHUs
Igo+PiArCQkgICIgZHN0OlxuJXMiLCBfX2VudHJ5LT5zdGFydCwgX19lbnRyeS0+ZW5kLCBfX2Vu
dHJ5LT5mbGFncywKPj4gKwkJICBfX2VudHJ5LT5ucHRlcywgX19lbnRyeS0+aW5jciwKPiBUaGlz
IGlzIG5vdCBjb3JyZWN0LiBUaGUgaW5jcmVtZW50IGlzIE5PVCB0aGUgcGFnZSBzaXplLCBidXQg
cmF0aGVyIHRoZSAKPiBwYWdlIHNpemUgcm91bmRlZCBkb3duIHRvIGEgcG93ZXIgb2YgNTEyKzRL
Lgo+Cj4gSW4gb3RoZXIgd29yZHMgcGFnZSBzaXplIGNhbiBiZSA0SywgOEssIDE2SywgMzJLLCA2
NEsuLi4uMU0sIDJNLCAKPiA0TS4uLi41MTJNLCAxRywgMkcuLi4uCj4KPiBCdXQgdGhlIGluY3Jl
bWVudCBjYW4gb25seSBiZSA0SywgMk0sIDFHLi4uLgpVbmRlcnN0b29kLiBCdXQgSSB0aGluayB0
aGUgcmVxdWlyZW1lbnQgaGVyZSBpcyBmb3IgaW5jcmVtZW50LiBNeSB1bmRlcnN0YW5kaW5nIGlz
IHRoYXQgdGhlIHRvb2wgbmVlZHMgdG8gc2F2ZSB0aGUgcGFnZSBlbnRyaWVzLCBhbmQgZm9yIHRo
YXQsIGl0IHdpbGwgbmVlZCBzdGFydCBvZiB2aXJ0dWFsIG1lbSwgc3RhcnQgb2YgcGh5c2ljYWwg
bWVtLCBtYXBwaW5nIHNpemUgYW5kIHN0ZXAgdG8gaW5jcmVtZW50IHRoZSBlbnRyaWVzLiBJZiB0
aGF0J3Mgc28sIHdlIGNhbiByZS1sYWJlbCB0aGlzIGVudHJ5IGFzICJzdGVwIiBpbnN0ZWFkIG9m
ICJwYWdlIHNpemUiLiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IHRoaW5rIGl0J3MgdGhlIHJp
Z2h0IHRoaW5nIHRvIGRvLsKgCj4gQW5kIGRvIHdlIG5lZWQgdGhlIG5wdGVzIGhlcmU/IFdlIGp1
c3QgbmVlZCBpdCB0byBwcmludCB0aGUgY29ycmVjdCAKPiBudW1iZXIgb2YgZGVzdGluYXRpb24g
YWRkcmVzc2VzLgoKQWdyZWUsIHdlIGRvbid0IHJlYWxseSBuZWVkIG5wdGVzIGhlcmUsIEkgd2ls
bCByZW1vdmUgdGhhdCBhbmQgc2VuZCBWNC4KCi0gU2hhc2hhbmsKCj4KPiBSZWdhcmRzLAo+IENo
cmlzdGlhbi4KPgo+PiArCQkgIF9fcHJpbnRfYXJyYXkoX19nZXRfZHluYW1pY19hcnJheShkc3Qp
LCBfX2VudHJ5LT5ucHRlcywgOCkpCj4+ICspOwo+PiArCj4+ICAgVFJBQ0VfRVZFTlQoYW1kZ3B1
X3ZtX3NldF9wdGVzLAo+PiAgIAkgICAgVFBfUFJPVE8odWludDY0X3QgcGUsIHVpbnQ2NF90IGFk
ZHIsIHVuc2lnbmVkIGNvdW50LAo+PiAgIAkJICAgICB1aW50MzJfdCBpbmNyLCB1aW50NjRfdCBm
bGFncywgYm9vbCBkaXJlY3QpLAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
Ywo+PiBpbmRleCA3MWUwMDVjZjI5NTIuLmI1ZGJiNWU4YmM2MSAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gQEAgLTE1MTMsMTcgKzE1MTMsMjIgQEAgc3Rh
dGljIGludCBhbWRncHVfdm1fdXBkYXRlX3B0ZXMoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFy
YW1zICpwYXJhbXMsCj4+ICAgCQlkbyB7Cj4+ICAgCQkJdWludDY0X3QgdXBkX2VuZCA9IG1pbihl
bnRyeV9lbmQsIGZyYWdfZW5kKTsKPj4gICAJCQl1bnNpZ25lZCBucHRlcyA9ICh1cGRfZW5kIC0g
ZnJhZ19zdGFydCkgPj4gc2hpZnQ7Cj4+ICsJCQl1aW50NjRfdCB1cGRfZmxhZ3MgPSBmbGFncyB8
IEFNREdQVV9QVEVfRlJBRyhmcmFnKTsKPj4gICAKPj4gICAJCQkvKiBUaGlzIGNhbiBoYXBwZW4g
d2hlbiB3ZSBzZXQgaGlnaGVyIGxldmVsIFBEcyB0bwo+PiAgIAkJCSAqIHNpbGVudCB0byBzdG9w
IGZhdWx0IGZsb29kcy4KPj4gICAJCQkgKi8KPj4gICAJCQlucHRlcyA9IG1heChucHRlcywgMXUp
Owo+PiArCj4+ICsJCQl0cmFjZV9hbWRncHVfdm1fdXBkYXRlX3B0ZXMocGFyYW1zLCBmcmFnX3N0
YXJ0LCB1cGRfZW5kLAo+PiArCQkJCQkJICAgIG5wdGVzLCBkc3QsIGluY3IsCj4+ICsJCQkJCQkg
ICAgdXBkX2ZsYWdzKTsKPj4gICAJCQlhbWRncHVfdm1fdXBkYXRlX2ZsYWdzKHBhcmFtcywgcHQs
IGN1cnNvci5sZXZlbCwKPj4gICAJCQkJCSAgICAgICBwZV9zdGFydCwgZHN0LCBucHRlcywgaW5j
ciwKPj4gLQkJCQkJICAgICAgIGZsYWdzIHwgQU1ER1BVX1BURV9GUkFHKGZyYWcpKTsKPj4gKwkJ
CQkJICAgICAgIHVwZF9mbGFncyk7Cj4+ICAgCj4+ICAgCQkJcGVfc3RhcnQgKz0gbnB0ZXMgKiA4
Owo+PiAtCQkJZHN0ICs9ICh1aW50NjRfdClucHRlcyAqIEFNREdQVV9HUFVfUEFHRV9TSVpFIDw8
IHNoaWZ0Owo+PiArCQkJZHN0ICs9IG5wdGVzICogaW5jcjsKPj4gICAKPj4gICAJCQlmcmFnX3N0
YXJ0ID0gdXBkX2VuZDsKPj4gICAJCQlpZiAoZnJhZ19zdGFydCA+PSBmcmFnX2VuZCkgewpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
