Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC06C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 12:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304CA20658
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 12:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="atEplID0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304CA20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC2236E5A4;
	Wed, 19 Feb 2020 12:01:23 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750051.outbound.protection.outlook.com [40.107.75.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E446E5A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 12:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9MwtDvGlxaz2NXoQxcP5l+0etqfrqJ+TgFSPIi9lWmatLkWGgOqRab8KXMIZYjpnLSaA97hO4zGtJZbpmhzUWwAS7zcwY07ac9CCIyVu42zglpd3L9Nf5d85Odpql+Wj/PMFcdQRCiaJZ89DYo0p++ysWVPGpeY7egKQgNYqImQJTzpWe3P1GGkDa0o7C23i85hptQEePm5jrJ9/SEA+5HkkrFub19SI2XL316/sqfwPmjv0bbE24XiINItv5LtA4gLUzC+B7gwaI8kCLbEmLpsnujL6hRpRSJYjvd5na0Vs4x0LI6eowDbriS+BbFTyCHNz13jKdIXpLhz9AWJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm1M7G7H9nK6PEfwvL3PJh97qcs0JAaRFg49LLv7tU4=;
 b=XXYuhBxHT5t++Qvo4jfOe5zmUP8B65dZT4iz6AzUgIvOm3Ha5tZhdIGdFcJv9T7vjnmP0pgo1DrAlXR2OSfkFuLJsbMqDjlh6GrnFj56g894zZtdnDa6W50zDxjeM2QjsOpAdfyFLb0PfGm+4D/vtv/6772ANPmsUO9211WSDckFppMO83blJRPogUWnZYhxrBrIZqlU9vkMSitQ+32zKn81sYgcmOOvNSfS2PL52IjoZkua3b7gOvIvGj0XzV9tGk98niGp1GXx+bivTYvPQDxV0TOnA+uLMBefC72ruupmkeYxL6Ilvu9Mjztw2etjTlvTZBPNozZruvhsNkLnrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm1M7G7H9nK6PEfwvL3PJh97qcs0JAaRFg49LLv7tU4=;
 b=atEplID0ktHZr+uZtfBuZj0Wt2IfUljJqRwUvnf2UjxNrbJx2Q3vco53arja2pXMS6imlHU4MKt+Ee+nAl4aOihaztpifNj1HT4VnQ6x7V2xG3IMElZ9rvUf17a3nTGiTpEzLISKg9J6S+DnU8DbmjXFpHbD4jrfpj60uYrogko=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (10.255.237.223) by
 MN2PR12MB4159.namprd12.prod.outlook.com (52.135.50.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 12:01:21 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c%5]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 12:01:21 +0000
Subject: Re: [PATCH umr v2] fix field names for INDIRECT_BUFFER_CONST/CIK for
 gfx9/gfx10
To: Xiaojie Yuan <xiaojie.yuan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200219115606.6612-1-xiaojie.yuan@amd.com>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <1ccbf336-8263-761b-40e9-eeeef02ad70a@amd.com>
Date: Wed, 19 Feb 2020 07:01:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200219115606.6612-1-xiaojie.yuan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::11) To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
Received: from localhost.localdomain (64.231.93.139) by
 YQBPR01CA0111.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 12:01:19 +0000
X-Originating-IP: [64.231.93.139]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3119544-2764-4baf-c553-08d7b5336ea6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4159:|MN2PR12MB4159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4159F1FEB5438860B20ACFBAF7100@MN2PR12MB4159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:279;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(189003)(199004)(66946007)(478600001)(186003)(31686004)(6506007)(5660300002)(86362001)(16526019)(53546011)(52116002)(66476007)(2616005)(66556008)(956004)(81166006)(81156014)(316002)(8676002)(8936002)(26005)(36756003)(31696002)(6486002)(2906002)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4159;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgXZRWOsIgHc19Krx9u+arKAjJt/v9xZe8t/fmRZ/UxQN10BcJCrtQOXXPoLYAH8t5Xa175CAD1QOPwbD54br9b7SC9DMDq7542yMZAVSKQvg/Ljjc1Se+wGsFnecCr8Rm0yD4KS7XuoAs8ohJA6oLk9NF2uk7Szr6DjMMASodkdlb8uJ8QUJmaOsOVGxd7TbuuQRgLwPoJucn4Lqn6iM0E5EfT8lg0yGBB26X8nQ6EE644Tv3ud5IfrHwwAzxRrCPN1NDkYw7ncwL+C49QTiZ0en6iLmpcTCAVevE35Hxbw9zBmFEZ0dGl7V6q+YWs1NWefIwsHMmbVLfctZoWyKOi/XEd0kYTXCxEw3ogP9A42uYwcIH5fhAnnE+QiMvtaEucLlY4hXgnKPhySA6HAUEh+skACCWGbQfXWHYHCbFgVKuGTvdgG+6Rv+RC8Oe2/
X-MS-Exchange-AntiSpam-MessageData: ALfh4jSQeEfk652hrsVMfZ3u7zvdxrWkrzbTao13aR+XWx28w78KnOh9Z3E+g/CFNe8ADh13EmWx2QCH+9toBiCNgmG0NG/yuen7GBFE5/SmJWMXYVLOf1fM9zn/wAyFRqxSfrmp9KgptEb4qafO1A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3119544-2764-4baf-c553-08d7b5336ea6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 12:01:20.8972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dQd9z1jZbTGY+0mMLsjS2IuUtbIGs9gZK0TZQcCc8tRgRxYjcZeJNNv2s8TSXRVozhVdaYYmxbkAapCv4KKuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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

SG1tIGl0IGRvZXNuJ3QgYXBwbHkgb24gdG9wIG9mIHRoZSB0aXAgb2YgbWFzdGVyLsKgIEknbGwg
anVzdCBtYW51YWxseSAKYXBwbHkgaXQuCgoKVG9tCgpPbiAyMDIwLTAyLTE5IDY6NTYgYS5tLiwg
WGlhb2ppZSBZdWFuIHdyb3RlOgo+IGZpZWxkIG5hbWVzIGZvciBJTkRJUkVDVF9CVUZGRVJfQ09O
U1QvQ0lLIG9mIGdmeDkvZ2Z4MTAgYXJlIHRoZSBzYW1lLgo+IGZpZWxkcyBsaWtlIE9GRkxPQURf
UE9MTElORyBhbmQgVkFMSUQgYXJlIGRlZmluZWQgaW4gbWVjJ3MKPiBJTkRJUkVDVF9CVUZGRVIg
cGFja2V0LCBzbyBub3QgYXBwbGljYWJsZSBoZXJlLgo+Cj4gdjI6IGZpeCB1bXJfcG00X2RlY29k
ZV9vcGNvZGVzLmMgYXMgd2VsbAo+Cj4gU2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZdWFuIDx4aWFv
amllLnl1YW5AYW1kLmNvbT4KPiAtLS0KPiAgIHNyYy9saWIvcmluZ19kZWNvZGUuYyAgICAgICAg
ICAgIHwgMjMgKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KPiAgIHNyYy9saWIvdW1yX3BtNF9kZWNv
ZGVfb3Bjb2Rlcy5jIHwgMjAgKysrKysrLS0tLS0tLS0tLS0tLS0KPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMTMgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3Jj
L2xpYi9yaW5nX2RlY29kZS5jIGIvc3JjL2xpYi9yaW5nX2RlY29kZS5jCj4gaW5kZXggMjUwZGZk
Ny4uZmE0NGYyNyAxMDA2NDQKPiAtLS0gYS9zcmMvbGliL3JpbmdfZGVjb2RlLmMKPiArKysgYi9z
cmMvbGliL3JpbmdfZGVjb2RlLmMKPiBAQCAtNjE3LDIyICs2MTcsMTMgQEAgc3RhdGljIHZvaWQg
cHJpbnRfZGVjb2RlX3BtNF9wa3QzKHN0cnVjdCB1bXJfYXNpYyAqYXNpYywgc3RydWN0IHVtcl9y
aW5nX2RlY29kZXIKPiAgIAkJCQljYXNlIDI6IHByaW50ZigiSUJfU0laRTolcyVsdSVzLCBWTUlE
OiAlcyVsdSVzIiwgQkxVRSwgQklUUyhpYiwgMCwgMjApLCBSU1QsIEJMVUUsIEJJVFMoaWIsIDI0
LCAyOCksIFJTVCk7Cj4gICAJCQkJCWRlY29kZXItPnBtNC5uZXh0X2liX3N0YXRlLmliX3NpemUg
PSBCSVRTKGliLCAwLCAyMCkgKiA0Owo+ICAgCQkJCQlkZWNvZGVyLT5wbTQubmV4dF9pYl9zdGF0
ZS5pYl92bWlkID0gZGVjb2Rlci0+bmV4dF9pYl9pbmZvLnZtaWQgPyBkZWNvZGVyLT5uZXh0X2li
X2luZm8udm1pZCA6IEJJVFMoaWIsIDI0LCAyOCk7Cj4gLQkJCQkJaWYgKGRlY29kZXItPnBtNC5j
dXJfb3Bjb2RlID09IDB4MzMpIHsKPiAtCQkJCQkJaWYgKGFzaWMtPmZhbWlseSA+PSBGQU1JTFlf
TlYpIHsKPiAtCQkJCQkJCXByaW50ZigiLCBDSEFJTjogJXMldSVzLCBQUkVfRU5BOiAlcyV1JXMs
IENBQ0hFX1BPTElDWTogJXMldSVzLCBQUkVfUkVTVU1FOiAlcyV1JXMgUFJJVjogJXMldSVzIiwK
PiAtCQkJCQkJCQkgICBCTFVFLCAodW5zaWduZWQpQklUUyhpYiwgMjAsIDIxKSwgUlNULAo+IC0J
CQkJCQkJCSAgIEJMVUUsICh1bnNpZ25lZClCSVRTKGliLCAyMSwgMjIpLCBSU1QsCj4gLQkJCQkJ
CQkJICAgQkxVRSwgKHVuc2lnbmVkKUJJVFMoaWIsIDI4LCAzMCksIFJTVCwKPiAtCQkJCQkJCQkg
ICBCTFVFLCAodW5zaWduZWQpQklUUyhpYiwgMzAsIDMxKSwgUlNULAo+IC0JCQkJCQkJCSAgIEJM
VUUsICh1bnNpZ25lZClCSVRTKGliLCAzMSwgMzIpLCBSU1QpOwo+IC0JCQkJCQl9IGVsc2UgaWYg
KGFzaWMtPmZhbWlseSA+PSBGQU1JTFlfQUkpIHsKPiAtCQkJCQkJCXByaW50ZigiLCBDSEFJTjog
JXMldSVzLCBPRkZMT0FEX1BPTExJTkc6ICVzJXUlcywgVkFMSUQ6ICVzJXUlcywgQ0FDSEVfUE9M
SUNZOiAlcyV1JXMgUFJJVjogJXMldSVzIiwKPiAtCQkJCQkJCQkgICBCTFVFLCAodW5zaWduZWQp
QklUUyhpYiwgMjAsIDIxKSwgUlNULAo+IC0JCQkJCQkJCSAgIEJMVUUsICh1bnNpZ25lZClCSVRT
KGliLCAyMSwgMjIpLCBSU1QsCj4gLQkJCQkJCQkJICAgQkxVRSwgKHVuc2lnbmVkKUJJVFMoaWIs
IDIzLCAyNCksIFJTVCwKPiAtCQkJCQkJCQkgICBCTFVFLCAodW5zaWduZWQpQklUUyhpYiwgMjgs
IDMwKSwgUlNULAo+IC0JCQkJCQkJCSAgIEJMVUUsICh1bnNpZ25lZClCSVRTKGliLCAzMSwgMzIp
LCBSU1QpOwo+IC0JCQkJCQl9Cj4gKwkJCQkJaWYgKGFzaWMtPmZhbWlseSA+PSBGQU1JTFlfQUkp
IHsKPiArCQkJCQkJcHJpbnRmKCIsIENIQUlOOiAlcyV1JXMsIFBSRV9FTkE6ICVzJXUlcywgQ0FD
SEVfUE9MSUNZOiAlcyV1JXMsIFBSRV9SRVNVTUU6ICVzJXUlcyBQUklWOiAlcyV1JXMiLAo+ICsJ
CQkJCQkJICAgQkxVRSwgKHVuc2lnbmVkKUJJVFMoaWIsIDIwLCAyMSksIFJTVCwKPiArCQkJCQkJ
CSAgIEJMVUUsICh1bnNpZ25lZClCSVRTKGliLCAyMSwgMjIpLCBSU1QsCj4gKwkJCQkJCQkgICBC
TFVFLCAodW5zaWduZWQpQklUUyhpYiwgMjgsIDMwKSwgUlNULAo+ICsJCQkJCQkJICAgQkxVRSwg
KHVuc2lnbmVkKUJJVFMoaWIsIDMwLCAzMSksIFJTVCwKPiArCQkJCQkJCSAgIEJMVUUsICh1bnNp
Z25lZClCSVRTKGliLCAzMSwgMzIpLCBSU1QpOwo+ICAgCQkJCQl9Cj4gICAJCQkJCWlmICghYXNp
Yy0+b3B0aW9ucy5ub19mb2xsb3dfaWIpIHsKPiAgIAkJCQkJCWlmICh1bXJfcmVhZF92cmFtKGFz
aWMsIGRlY29kZXItPnBtNC5uZXh0X2liX3N0YXRlLmliX3ZtaWQsCj4gZGlmZiAtLWdpdCBhL3Ny
Yy9saWIvdW1yX3BtNF9kZWNvZGVfb3Bjb2Rlcy5jIGIvc3JjL2xpYi91bXJfcG00X2RlY29kZV9v
cGNvZGVzLmMKPiBpbmRleCBkN2MxNDk1Li5hODIzZWNmIDEwMDY0NAo+IC0tLSBhL3NyYy9saWIv
dW1yX3BtNF9kZWNvZGVfb3Bjb2Rlcy5jCj4gKysrIGIvc3JjL2xpYi91bXJfcG00X2RlY29kZV9v
cGNvZGVzLmMKPiBAQCAtNDI5LDIwICs0MjksMTIgQEAgc3RhdGljIHZvaWQgZGVjb2RlX3BrdDMo
c3RydWN0IHVtcl9hc2ljICphc2ljLCBzdHJ1Y3QgdW1yX3BtNF9zdHJlYW1fZGVjb2RlX3VpICoK
PiAgIAkJCXVpLT5hZGRfZmllbGQodWksIGliX2FkZHIgKyA4LCBpYl92bWlkLCAiSUJfQkFTRV9I
SSIsIEJJVFMoc3RyZWFtLT53b3Jkc1sxXSwgMCwgMTYpLCBOVUxMLCAxNik7Cj4gICAJCQl1aS0+
YWRkX2ZpZWxkKHVpLCBpYl9hZGRyICsgMTIsIGliX3ZtaWQsICJJQl9TSVpFIiwgQklUUyhzdHJl
YW0tPndvcmRzWzJdLCAwLCAyMCksIE5VTEwsIDEwKTsKPiAgIAkJCXVpLT5hZGRfZmllbGQodWks
IGliX2FkZHIgKyAxMiwgaWJfdm1pZCwgIklCX1ZNSUQiLCBCSVRTKHN0cmVhbS0+d29yZHNbMl0s
IDI0LCAyOCksIE5VTEwsIDEwKTsKPiAtCQkJaWYgKHN0cmVhbS0+b3Bjb2RlID09IDB4MzMpIHsK
PiAtCQkJCWlmIChhc2ljLT5mYW1pbHkgPj0gRkFNSUxZX05WKSB7Cj4gLQkJCQkJdWktPmFkZF9m
aWVsZCh1aSwgaWJfYWRkciArIDEyLCBpYl92bWlkLCAiQ0hBSU4iLCBCSVRTKHN0cmVhbS0+d29y
ZHNbMl0sIDIwLCAyMSksIE5VTEwsIDEwKTsKPiAtCQkJCQl1aS0+YWRkX2ZpZWxkKHVpLCBpYl9h
ZGRyICsgMTIsIGliX3ZtaWQsICJQUkVfRU5BIiwgQklUUyhzdHJlYW0tPndvcmRzWzJdLCAyMSwg
MjIpLCBOVUxMLCAxMCk7Cj4gLQkJCQkJdWktPmFkZF9maWVsZCh1aSwgaWJfYWRkciArIDEyLCBp
Yl92bWlkLCAiQ0FDSEVfUE9MSUNZIiwgQklUUyhzdHJlYW0tPndvcmRzWzJdLCAyOCwgMzApLCBO
VUxMLCAxMCk7Cj4gLQkJCQkJdWktPmFkZF9maWVsZCh1aSwgaWJfYWRkciArIDEyLCBpYl92bWlk
LCAiUFJFX1JFU1VNRSIsIEJJVFMoc3RyZWFtLT53b3Jkc1syXSwgMzAsIDMxKSwgTlVMTCwgMTAp
Owo+IC0JCQkJCXVpLT5hZGRfZmllbGQodWksIGliX2FkZHIgKyAxMiwgaWJfdm1pZCwgIlBSSVYi
LCBCSVRTKHN0cmVhbS0+d29yZHNbMl0sIDMxLCAzMiksIE5VTEwsIDEwKTsKPiAtCQkJCX0gZWxz
ZSBpZiAoYXNpYy0+ZmFtaWx5ID49IEZBTUlMWV9BSSkgewo+IC0JCQkJCXVpLT5hZGRfZmllbGQo
dWksIGliX2FkZHIgKyAxMiwgaWJfdm1pZCwgIkNIQUlOIiwgQklUUyhzdHJlYW0tPndvcmRzWzJd
LCAyMCwgMjEpLCBOVUxMLCAxMCk7Cj4gLQkJCQkJdWktPmFkZF9maWVsZCh1aSwgaWJfYWRkciAr
IDEyLCBpYl92bWlkLCAiT0ZGTE9BRF9QT0xMSU5HIiwgQklUUyhzdHJlYW0tPndvcmRzWzJdLCAy
MSwgMjIpLCBOVUxMLCAxMCk7Cj4gLQkJCQkJdWktPmFkZF9maWVsZCh1aSwgaWJfYWRkciArIDEy
LCBpYl92bWlkLCAiVkFMSUQiLCBCSVRTKHN0cmVhbS0+d29yZHNbMl0sIDIzLCAyNCksIE5VTEws
IDEwKTsKPiAtCQkJCQl1aS0+YWRkX2ZpZWxkKHVpLCBpYl9hZGRyICsgMTIsIGliX3ZtaWQsICJD
QUNIRV9QT0xJQ1kiLCBCSVRTKHN0cmVhbS0+d29yZHNbMl0sIDI4LCAzMCksIE5VTEwsIDEwKTsK
PiAtCQkJCQl1aS0+YWRkX2ZpZWxkKHVpLCBpYl9hZGRyICsgMTIsIGliX3ZtaWQsICJQUklWIiwg
QklUUyhzdHJlYW0tPndvcmRzWzJdLCAzMSwgMzIpLCBOVUxMLCAxMCk7Cj4gLQkJCQl9Cj4gKwkJ
CWlmIChhc2ljLT5mYW1pbHkgPj0gRkFNSUxZX0FJKSB7Cj4gKwkJCQl1aS0+YWRkX2ZpZWxkKHVp
LCBpYl9hZGRyICsgMTIsIGliX3ZtaWQsICJDSEFJTiIsIEJJVFMoc3RyZWFtLT53b3Jkc1syXSwg
MjAsIDIxKSwgTlVMTCwgMTApOwo+ICsJCQkJdWktPmFkZF9maWVsZCh1aSwgaWJfYWRkciArIDEy
LCBpYl92bWlkLCAiUFJFX0VOQSIsIEJJVFMoc3RyZWFtLT53b3Jkc1syXSwgMjEsIDIyKSwgTlVM
TCwgMTApOwo+ICsJCQkJdWktPmFkZF9maWVsZCh1aSwgaWJfYWRkciArIDEyLCBpYl92bWlkLCAi
Q0FDSEVfUE9MSUNZIiwgQklUUyhzdHJlYW0tPndvcmRzWzJdLCAyOCwgMzApLCBOVUxMLCAxMCk7
Cj4gKwkJCQl1aS0+YWRkX2ZpZWxkKHVpLCBpYl9hZGRyICsgMTIsIGliX3ZtaWQsICJQUkVfUkVT
VU1FIiwgQklUUyhzdHJlYW0tPndvcmRzWzJdLCAzMCwgMzEpLCBOVUxMLCAxMCk7Cj4gKwkJCQl1
aS0+YWRkX2ZpZWxkKHVpLCBpYl9hZGRyICsgMTIsIGliX3ZtaWQsICJQUklWIiwgQklUUyhzdHJl
YW0tPndvcmRzWzJdLCAzMSwgMzIpLCBOVUxMLCAxMCk7Cj4gICAJCQl9Cj4gICAJCQlicmVhazsK
PiAgIAkJY2FzZSAweDM3OiAvLyBXUklURV9EQVRBCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
