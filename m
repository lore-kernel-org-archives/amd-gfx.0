Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4998C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 16:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF4520679
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 16:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF4520679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 590BF6EB69;
	Tue, 12 Nov 2019 16:08:24 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680051.outbound.protection.outlook.com [40.107.68.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A20A6EB69
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 16:08:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYLksZNI+jjsMTNiKEJcmPiIFWHfalZ3wG0Sn5rRacQjxn74bN88tD4b+r4e/l177bdKObWnz2Zur+wEvnetNtR6JS9AHH3Kpj/mzqvaSc/eWlSfFpCMWk3ubcVn4ZaZFxBbK/fN4eJ2pG3gLb+w0wcAT4heTETWPdxAVZLbYEsIjtwmjjFzL0n2Ks5Xgn4Oj9O0WSefzkpAI8yo+oNKXELqLH38LgpF/EUwaitihU486c25eBkjziqzEegSQ8wcHgSDni89b/P87vy+DE0dFeyAfF11cjOxq6nANhN4MvHYABgIjRyaE6+Ggn3lmq37OHcM9XMuWBHawYNOl7Er1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAGdSn72QM6AfQfH534ZJ+zG6O5RNVYzArSFYSeQMIY=;
 b=HwufcATXXx1KPXAo5eKDj2asZxs0gG91vpsIQlnQvireTvlKO07oQArz11sSoh5QGp6b2eLJXVmemVh+cEajQ0KXzpLMI5h4kSj6Voj8Mc8AOEkEx6QF/GY80bRosarkh5l4Hr+vOiXeIYpC/8R4I8CeGMB2F6l6QFb8xp1HjTx+DiFvaDCVKnF5mF+9ls5u6ZY9vbe6pjFT0jS0Z64NzroFv3CDqgtQeqViNwrxoX7ouvbIf+e4OTMa+4+ehugXTJjPDXYpyk5yoGK8SjPcu6QT9UZL2e3QI79wrCq2nDRTsCE9gyo0ARxf22uvZry24a/VZfHizXAg2ndibpwjoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3637.namprd12.prod.outlook.com (20.178.54.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 12 Nov 2019 16:08:21 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26%7]) with mapi id 15.20.2408.025; Tue, 12 Nov 2019
 16:08:21 +0000
Subject: Re: [PATCH 1/2] drm/amd/display: Return correct error value
To: mikita.lipski@amd.com, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com
References: <20191112151628.8267-1-mikita.lipski@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <f2eed143-4767-81b2-2de9-e89631c7bd5a@amd.com>
Date: Tue, 12 Nov 2019 11:08:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191112151628.8267-1-mikita.lipski@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::38) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ffb01df1-306b-470b-f85a-08d7678a89d0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB363783E4DC5DC15EE6C4A953EC770@BYAPR12MB3637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(199004)(189003)(54094003)(81156014)(8676002)(99286004)(81166006)(31686004)(2906002)(230700001)(5660300002)(476003)(2616005)(25786009)(11346002)(446003)(486006)(58126008)(66066001)(65956001)(65806001)(6116002)(3846002)(229853002)(316002)(8936002)(47776003)(6246003)(6512007)(66946007)(6636002)(478600001)(14454004)(76176011)(6486002)(2486003)(6436002)(23676004)(52116002)(4001150100001)(53546011)(386003)(50466002)(66476007)(66556008)(6506007)(31696002)(305945005)(7736002)(4326008)(186003)(6666004)(26005)(86362001)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3637;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uy0ng4CERwl/Zuud+H00EXQ/Lvh0N4xFa24edwyYd+pGTWgCQt45xpmIGGUTTNiLZzDWBleehGHECNyKUy6ObVpp7dPitsGUNOEjpUEVpTCCg0JTx/CfAjNLFcaIjWaSt+zczaUGJjuZPxcpfmpGWQAvbGyUNWU5w2hjczp5zrBK9CfZlnqhjv3k0kFEP8EP96Jk42RCRKpa1cgJFGK0B/GqC3ZVkQ5k63kn8E5qbpUemmQJK9lGBhkAimLYHX8Vwq3LQl5c4g7Nr+y7eFEC2ZCjqiRRdlg6/iKBPqbXjtiyxhrLkBG1A/iCu4cF04gw6ky+ES0SVp994bu38u/fkANzG1ElLXZGRFvC2sKdp9eUFbbfIA4ZAcs7EPvcS9BSAD9r9paH5bAjjOlxnOEFsD6hUTIQV0CysqNYITEYLBLci0LWFKap3dcrFP8a3yO8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb01df1-306b-470b-f85a-08d7678a89d0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 16:08:21.4254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +biI7qN97Julv9unN06Hm+0QU7bOPT1p2dVySZeW8DKV2TOZL9+ldS7vFeFI9m6SfoTYyAMK19NMcRMucseCOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3637
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAGdSn72QM6AfQfH534ZJ+zG6O5RNVYzArSFYSeQMIY=;
 b=s/T1U1JOuBOs3Gf9Wn81XcN3eOHG79xxOBFP3np/r2xvA7FYtJ3qV91KpG1eqVnmc9vrykhmA/xJgeK9VZQ/6X+zLGJZoxbRq64z3Wpf13/utQJ+UwM4ERiH047v1wDpYBN65qgST40S04VGPkRxaKisv0+1SQSfpO2G9Y46z3c=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112160818.emNqKeydhY2KqAc1fKLfXxJAdppvzCXGA1p_qPw22Nk@z>

T24gMjAxOS0xMS0xMiAxMDoxNiBhLm0uLCBtaWtpdGEubGlwc2tpQGFtZC5jb20gd3JvdGU6Cj4g
RnJvbTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgo+IAo+IFt3aHldCj4g
VGhlIGZ1bmN0aW9uIGlzIGV4cGVjdGVkIHRvIHJldHVybiBpbnN0YW5jZSBvZiB0aGUgdGltaW5n
IGdlbmVyYXRvcgo+IHRoZXJlZm9yZSB3ZSBzaG91bGRuJ3QgYmUgcmV0dXJuaW5nIGJvb2xlYW4g
aW4gaW50ZWdlciBmdW5jdGlvbiwKPiBhbmQgd2Ugc2hvdWxkbid0IGJlIHJldHVybmluZyB6ZXJv
IHNvIGNoYW5naW5nIGl0IHRvIC0xLgo+IAo+IFNpZ25lZC1vZmYtYnk6IE1pa2l0YSBMaXBza2kg
PG1pa2l0YS5saXBza2lAYW1kLmNvbT4KCkkgd29uZGVyIGlmIHNvbWUgb2YgdGhlc2Ugd2VyZSBp
bnRlbnRpb25hbCBmb3IgcmV0dXJuaW5nIDAuIFRoZXNlIGxpbmVzIAp3ZXJlIG9yaWdpbmFsbHkg
aW50cm9kdWNlZCBmb3IgZW5hYmxpbmcgc2VhbWxlc3MgYm9vdCBzdXBwb3J0IHdpdGggZURQIAph
bmQgSSB0aGluayB5b3UncmUgZ3VhcmFudGVlZCB0byBoYXZlIHRob3NlIHJlc291cmNlcyBhcyBp
bnN0YW5jZSAwLgoKTmljaG9sYXMgS2F6bGF1c2thcwoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmMgfCA2ICsrKy0tLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3VyY2UuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmMKPiBpbmRleCA4
OWI1Zjg2Y2Q0MGIuLjc1Y2M1OGVjZjY0NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNvdXJjZS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3VyY2UuYwo+IEBAIC0xODY2LDcgKzE4NjYsNyBA
QCBzdGF0aWMgaW50IGFjcXVpcmVfcmVzb3VyY2VfZnJvbV9od19lbmFibGVkX3N0YXRlKAo+ICAg
CWluc3QgPSBsaW5rLT5saW5rX2VuYy0+ZnVuY3MtPmdldF9kaWdfZnJvbnRlbmQobGluay0+bGlu
a19lbmMpOwo+ICAgCj4gICAJaWYgKGluc3QgPT0gRU5HSU5FX0lEX1VOS05PV04pCj4gLQkJcmV0
dXJuIGZhbHNlOwo+ICsJCXJldHVybiAtMTsKPiAgIAo+ICAgCWZvciAoaSA9IDA7IGkgPCBwb29s
LT5zdHJlYW1fZW5jX2NvdW50OyBpKyspIHsKPiAgIAkJaWYgKHBvb2wtPnN0cmVhbV9lbmNbaV0t
PmlkID09IGluc3QpIHsKPiBAQCAtMTg3OCwxMCArMTg3OCwxMCBAQCBzdGF0aWMgaW50IGFjcXVp
cmVfcmVzb3VyY2VfZnJvbV9od19lbmFibGVkX3N0YXRlKAo+ICAgCj4gICAJLy8gdGdfaW5zdCBu
b3QgZm91bmQKPiAgIAlpZiAoaSA9PSBwb29sLT5zdHJlYW1fZW5jX2NvdW50KQo+IC0JCXJldHVy
biBmYWxzZTsKPiArCQlyZXR1cm4gLTE7Cj4gICAKPiAgIAlpZiAodGdfaW5zdCA+PSBwb29sLT50
aW1pbmdfZ2VuZXJhdG9yX2NvdW50KQo+IC0JCXJldHVybiBmYWxzZTsKPiArCQlyZXR1cm4gLTE7
Cj4gICAKPiAgIAlpZiAoIXJlc19jdHgtPnBpcGVfY3R4W3RnX2luc3RdLnN0cmVhbSkgewo+ICAg
CQlzdHJ1Y3QgcGlwZV9jdHggKnBpcGVfY3R4ID0gJnJlc19jdHgtPnBpcGVfY3R4W3RnX2luc3Rd
Owo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
