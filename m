Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF90C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 21:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 817C12196E
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 21:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817C12196E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38FD86EBF7;
	Tue, 12 Nov 2019 21:30:20 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700077.outbound.protection.outlook.com [40.107.70.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D056E6EBF7
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 21:30:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJobXlDwZjxwvmOq7ZZGJXeAkoXRQ9EivXG29zEL017FpXFAgjm0VBsCyNeChSFRvJ/o1vo1R0Bzk/w82cSuQeCEEkOlT80IarKxIyC+VrsJZk27PAFXmI0oOFNoqLvaWn+uJGeQn6TpLzZF39XwuF3j9EwXNTZt4jNOF6r+O51tz4BREAiKRei3qqN/ymlcMTm8pw55iDlLz4B6IF/J11/x3BJqcI+pB8p5wmbYS3izYIE0svV28qyffPH/ihGAKcgaIvn5xmG6xatIqUkArCb5WlLl8TifYB15lNi7dgZ3zhqjbIBfHrbO251cW/oYb1+lo3FjARqxs2/sAJ8Mjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxxqeqJhDK8Y7iPoNGttj3h84NMeoz0aGb92DrCjyNs=;
 b=MYEomUD7HBAULzVZgiJk8riqV/nIVWO4KzaOPjP+T5vDD22O6oEdmBR5hKZamCvROBMKi9mcMQ3bL0x+npWLKQ1yWRsoU7OJW9qxrUoZRXmcMP077iToy7d67ANx+ucuwPA5ErKcj6rnUXx96SqSNUGVQMoXYZ1EeIwNj19kwg+m9ZlWa+P5m5aIeAMhZk6siChmyxNE+zWfnQUU58kEbUCr3xgHnLo/mxg70+ROB20X4Yn1oabDTcFTas/cX5X5jg3XXZp46keL2ACjabWGDIQ2Kpuabqq2aYhfrChXnWBCMp1RaNo6Hn0l9+hXODOJT/ipP99rq+2fLxzbySs6Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (10.255.237.150) by
 MN2PR12MB3245.namprd12.prod.outlook.com (20.179.82.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 21:30:17 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::49f3:af31:eb8e:569b]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::49f3:af31:eb8e:569b%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 21:30:17 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: Stop using GFP_NOIO explicitly for GFX10
To: Yong Zhao <Yong.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191112212641.4643-1-Yong.Zhao@amd.com>
 <20191112212641.4643-2-Yong.Zhao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <4e5a3723-4b61-e76c-dc96-dafdec51f099@amd.com>
Date: Tue, 12 Nov 2019 16:30:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191112212641.4643-2-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::35) To MN2PR12MB3949.namprd12.prod.outlook.com
 (2603:10b6:208:167::22)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6dc31740-6873-4295-16c3-08d767b782d5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3245:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB324518ECDCCD4D50784C0D1692770@MN2PR12MB3245.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(199004)(189003)(186003)(11346002)(7736002)(26005)(6512007)(50466002)(58126008)(316002)(4001150100001)(230700001)(66476007)(66556008)(66946007)(31686004)(305945005)(446003)(476003)(2616005)(44832011)(486006)(3846002)(6116002)(6246003)(65806001)(65956001)(66066001)(229853002)(36756003)(14444005)(386003)(25786009)(14454004)(86362001)(8676002)(2486003)(76176011)(478600001)(36916002)(52116002)(6506007)(6436002)(47776003)(2906002)(81156014)(8936002)(81166006)(6486002)(31696002)(5660300002)(23676004)(99286004)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3245;
 H:MN2PR12MB3949.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0D6SWJ8yXi3s0zxeGWU9uLadS7aebf7rUmCrNLlD5IxX1Fg76bMxgdVk+8gmTD8+Xr1F5J2QPobBRaLEtF7MaUl+5kBy8N/jp+nsZIFuONLKXTqdGKZcoPx+fQXcNQ7UC7qIbrHsBwBOAxoXcghazeOyQxyUiy3UHJWCpJP7p7K1S8U7oYuboEl7DreA2IP/FiufSgZzendloj/XCD3PJdWPWowpuzi4Eriv2genK0QeCjpsjaAs9KuXtH7ECBtu9FTfH7bPeO56pDCqeL4Pw537zU/JQQb7FF+YBUlDjfyle86cP00zPEToqxNyszFekOVR54uP3+zHPEzKrKxAdl/4te9ixnJYujthvyDe8+1X5Sot3FD1+wnDBtfTETYelcg86U1fl6ilhdkE46Y0idvN2/GXK6AfDu5HXSdM4KHkqjvt7GQUggmfkLkYpHd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc31740-6873-4295-16c3-08d767b782d5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 21:30:17.0412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmQN1dPovKXNLExjHbiQff5S9OsSA4FRiNfHNSmhw/y0THz9JnQJCXKqm7+yiIjq+C1zzXVn7MRngTy8tGVGwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3245
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxxqeqJhDK8Y7iPoNGttj3h84NMeoz0aGb92DrCjyNs=;
 b=D2ZhUwwE5zY4KD8l/+OLSC4qiFRTlUN8bzYx1vKj7aUhu0zU5oo9e37V/7G0oKBrCR68MKoPheXiXMFcMfgAauSsjysxrPIafh4JdgJwWJXkie7G3GASeP2kOnt2TkEwiv8oBtEs0hzzBDGGW57nMnskQ6Ha1wAxooXJqjOsYhc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Message-ID: <20191112213015.-afTP2RmS3Geu8_savQtHjnOHUEcubHdql4Qwzq_Uxs@z>

T24gMjAxOS0xMS0xMiA0OjI2IHAubS4sIFlvbmcgWmhhbyB3cm90ZToKPiBBZGFwdCB0aGUgY2hh
bmdlIGZyb20gMWNkMTA2ZWNmYzFmMDQKPgo+IFRoZSBjaGFuZ2UgaXM6Cj4KPiAgICAgIGRybS9h
bWRrZmQ6IFN0b3AgdXNpbmcgR0ZQX05PSU8gZXhwbGljaXRseQo+Cj4gICAgICBUaGlzIGlzIG5v
IGxvbmdlciBuZWVkZWQgd2l0aCB0aGUgbWVtYWxsb2Nfbm9mc19zYXZlL3Jlc3RvcmUgaW4KPiAg
ICAgIGRxbV9sb2NrL3VubG9jawo+Cj4gQ2hhbmdlLUlkOiBJNDI0NTBiMmMxNDlkMmIxODQyYmU5
OWE4ZjM1NWM4MjlhMDA3OWU3Ywo+IFNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9uZy5aaGFv
QGFtZC5jb20+CgpUaGUgc2VyaWVzIGlzCgpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZl
bGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYyB8IDIgKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5jICB8IDIgKy0KPiAgIDIgZmlsZXMgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYwo+IGluZGV4IDQ2ZGRiMzNiNjI0YS4u
NTc5YzVmZmNmYTc5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9tcWRfbWFuYWdlcl92MTAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9tcWRfbWFuYWdlcl92MTAuYwo+IEBAIC0zOTMsNyArMzkzLDcgQEAgc3RydWN0IG1xZF9tYW5h
Z2VyICptcWRfbWFuYWdlcl9pbml0X3YxMChlbnVtIEtGRF9NUURfVFlQRSB0eXBlLAo+ICAgCWlm
IChXQVJOX09OKHR5cGUgPj0gS0ZEX01RRF9UWVBFX01BWCkpCj4gICAJCXJldHVybiBOVUxMOwo+
ICAgCj4gLQltcWQgPSBremFsbG9jKHNpemVvZigqbXFkKSwgR0ZQX05PSU8pOwo+ICsJbXFkID0g
a3phbGxvYyhzaXplb2YoKm1xZCksIEdGUF9LRVJORUwpOwo+ICAgCWlmICghbXFkKQo+ICAgCQly
ZXR1cm4gTlVMTDsKPiAgIAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfbXFkX21hbmFnZXJfdjkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9t
cWRfbWFuYWdlcl92OS5jCj4gaW5kZXggYmUyN2ZmMDFjZGI4Li4yMmE4MTljODg4ZDggMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYwo+
IEBAIC05Miw3ICs5Miw3IEBAIHN0YXRpYyBzdHJ1Y3Qga2ZkX21lbV9vYmogKmFsbG9jYXRlX21x
ZChzdHJ1Y3Qga2ZkX2RldiAqa2ZkLAo+ICAgCSAqIGluc3RlYWQgb2Ygc3ViLWFsbG9jYXRpb24g
ZnVuY3Rpb24uCj4gICAJICovCj4gICAJaWYgKGtmZC0+Y3dzcl9lbmFibGVkICYmIChxLT50eXBl
ID09IEtGRF9RVUVVRV9UWVBFX0NPTVBVVEUpKSB7Cj4gLQkJbXFkX21lbV9vYmogPSBremFsbG9j
KHNpemVvZihzdHJ1Y3Qga2ZkX21lbV9vYmopLCBHRlBfTk9JTyk7Cj4gKwkJbXFkX21lbV9vYmog
PSBremFsbG9jKHNpemVvZihzdHJ1Y3Qga2ZkX21lbV9vYmopLCBHRlBfS0VSTkVMKTsKPiAgIAkJ
aWYgKCFtcWRfbWVtX29iaikKPiAgIAkJCXJldHVybiBOVUxMOwo+ICAgCQlyZXR2YWwgPSBhbWRn
cHVfYW1ka2ZkX2FsbG9jX2d0dF9tZW0oa2ZkLT5rZ2QsCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
