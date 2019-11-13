Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41C4C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 13:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C58222BD
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 13:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C58222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E18C6ED10;
	Wed, 13 Nov 2019 13:51:06 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720080.outbound.protection.outlook.com [40.107.72.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 879856ED10
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 13:51:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Asx3HdbKEha3gq+FeEVAU2FDsz6X/0NNhvRqx6SHNV4Hjudlo99brRgomaEe95RcpTQXLuEjm2yvqqUegbwnL/6oQ0FSZpJdvnSzY5ULdvJV50JNVkWDdwX3EI4RJP0vO8gcxfIGBYZwHQaLoQxJt/NIvUSRrpkqW6b6+CEY9O4MVikDhflLRpz/r0NxEBvHTM6RlAWZiobV18rzqsAVK5jMyxd3k7V8AeOFWaPHCAJYidy3GmxHSgEvicFcrQpFYMHl1IN7CqlAQvdmwzbse/SCukK/pS8yRcgp74XYL8X3qsV8D+dC9u2qafpu8AJ6v3hGDEs+Ln9t/qeotA29dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/X2O24gxucPkAKVXlD+wuL8zV/qtT8KkOIJklaMSPM=;
 b=gd8ngyaXkrya32zSYeEh8H0gTRLPrcFaY+Sd4W4jEECXtViLxMl9w9FKoRyrPCDbe/GYFRWS3qJa3KRSHIgu9k+iBOvFgrfwRw6tcDOn54ecp2y8imJSzwWRRlT5UXap2CfjrrutsVE1r9mMPBZn7CKEI93Z+AwV8xkVnLTck5sdnPvPr/3UDv47T+V7M6j9BbOLn0YJKSxMZPsVmBsomD8mXPmB1hrVY07FtbFyNSvT07PFIpJAV2039bHAJAjfK6pAXFIxW9RFBrGThf0dWqBcvNi6r63lhXXy8rjgFfV9P7DjjUBGb7EIXj4QAM7wX4cjkYGzi3L7ZZvpLcGidg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1674.namprd12.prod.outlook.com (10.172.40.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Wed, 13 Nov 2019 13:51:01 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 13:51:01 +0000
Subject: Re: [PATCH 12/21] drm/amd/powerplay: add JPEG power control for Navi1x
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20191112180329.3927-1-leo.liu@amd.com>
 <20191112180329.3927-13-leo.liu@amd.com>
 <MN2PR12MB334438FF2957ED7C7C8E226FE4760@MN2PR12MB3344.namprd12.prod.outlook.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <23b6dccd-da81-5b02-4d27-1be119ff06b7@amd.com>
Date: Wed, 13 Nov 2019 08:50:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
In-Reply-To: <MN2PR12MB334438FF2957ED7C7C8E226FE4760@MN2PR12MB3344.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::17) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: af2e70c5-2c64-4a86-1e22-08d7684084ee
X-MS-TrafficTypeDiagnostic: DM5PR12MB1674:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB16741E5B6D6DA3563A23C73EE5760@DM5PR12MB1674.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0220D4B98D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(13464003)(199004)(189003)(2906002)(3846002)(66066001)(230700001)(47776003)(65806001)(66476007)(66556008)(66946007)(229853002)(6116002)(8936002)(8676002)(81156014)(81166006)(6246003)(31686004)(476003)(2616005)(65956001)(11346002)(446003)(486006)(25786009)(6436002)(44832011)(76176011)(6506007)(6486002)(386003)(23676004)(53546011)(52116002)(2486003)(36916002)(6512007)(6306002)(186003)(36756003)(14454004)(5660300002)(26005)(316002)(110136005)(58126008)(305945005)(7736002)(99286004)(31696002)(4001150100001)(966005)(50466002)(478600001)(2501003)(86362001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1674;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPqXMchb1jYCpR97K+WUP6aMviLj159pANTUuQex37JxdtuSxzXNmaObznqHkGZSiIwCHw7eCFHMNoWt7E+EUQEIJ2xb2egBU3ccSiTiukKeYROrSvcyFTRkLM/7eQgA496vb/rppWnrpe+N/InI0sG06KoBoL5mMPmw+W4xh7cR8pf0bcXUem7cnOlPiMXjAuAtzUZmeLjFZ2d5PmRtvAMCEgLprD8gddNHilw/nICY28KsyCzqlnuiA7EGm12Qg/s313o5DTqsh0bJu9df0CmL/DoO5KmTb04V0YCMfv1p9y1JiEalcAyrCuBEBUeutVTkn8XZDTuPrhTw+SseCGWWi/L1k4UeT3wZ4yvhppQHU32iq0713C4YoVP5Yu3cX/QVHptF4kaJI4PAhUNmFs/RnNizN5nSkR89kGY6CJYl1dEFL9Q02MUnSTlk0pqCWIjjhtB60G35w4tfdzjrd4U2RBf8Tpa8Ya3CFdgZZVo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2e70c5-2c64-4a86-1e22-08d7684084ee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 13:51:01.6796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 591zEcf2PkMCo3nqwd/camhJX09n8gEKnFE1Pb5fABvdOJrAywXlfgkRhA6kCn+B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1674
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/X2O24gxucPkAKVXlD+wuL8zV/qtT8KkOIJklaMSPM=;
 b=KFiNvdtDgsfcB51eyaRbCiHnusEYB6CDydLZoSlYH15GpMYovuauN9XTApyENdFVkETNMZsCzFf7sUCv9UP7zmLbm9b7dhivhmh1jnbzro6YiPcnUxIxw3L1MM5zdHPBkRiVYayChrvfjIp96dm5LoVNKV9ccdV+1Ta5TWOj8FI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
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
Message-ID: <20191113135059.C3b5iBlO48oqJwC0jnBYJcMDwfER1IG3AJ3787xaeag@z>

Ck9uIDIwMTktMTEtMTIgMTA6NTAgcC5tLiwgUXVhbiwgRXZhbiB3cm90ZToKPiBGb3IgTmF2aTEw
LCBTTVVfTVNHX1Bvd2VyVXBKcGVnIG1lc3NhZ2UgZG9lcyBub3QgbmVlZCBhbiBhcmd1bWVudC4K
ClRoZSBmaXhlcyBmb3IgdGhpcyBhbmQgb3RoZXJzIHdpbGwgYmUgaW4gdjIuIFRoYW5rcyBmb3Ig
cG9pbnRpbmcgdGhpcyBvdXQuCgpSZWdhcmRzLAoKTGVvCgoKPgo+PiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQo+PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgTGVvIExpdQo+PiBTZW50OiBXZWRuZXNkYXksIE5vdmVt
YmVyIDEzLCAyMDE5IDI6MDMgQU0KPj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cj4+IENjOiBMaXUsIExlbyA8TGVvLkxpdUBhbWQuY29tPgo+PiBTdWJqZWN0OiBbUEFUQ0ggMTIv
MjFdIGRybS9hbWQvcG93ZXJwbGF5OiBhZGQgSlBFRyBwb3dlciBjb250cm9sIGZvcgo+PiBOYXZp
MXgKPj4KPj4gQnkgc2VwYXJhdGluZyB0aGUgSlBFRyBwb3dlciBmZWF0dXJlLCBhbmQgdXNpbmcg
aXRzIG93biBQb3dlclVwIGFuZAo+PiBQb3dlckRvd24gbWVzc2FnZXMKPj4KPj4gU2lnbmVkLW9m
Zi1ieTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMgfCAzMiArKysrKysrKysrKysrKysrKysrKy0t
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0
LmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMKPj4gaW5k
ZXggYWViOWMxZTM0MWM3Li43NjA1NjhkZWJlNmMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMKPj4gQEAgLTM4NCw4ICszODQsMTAgQEAgbmF2aTEw
X2dldF9hbGxvd2VkX2ZlYXR1cmVfbWFzayhzdHJ1Y3QKPj4gc211X2NvbnRleHQgKnNtdSwKPj4g
ICAJCSoodWludDY0X3QgKilmZWF0dXJlX21hc2sgfD0KPj4gRkVBVFVSRV9NQVNLKEZFQVRVUkVf
QVRIVUJfUEdfQklUKTsKPj4KPj4gICAJaWYgKHNtdS0+YWRldi0+cGdfZmxhZ3MgJiBBTURfUEdf
U1VQUE9SVF9WQ04pCj4+IC0JCSoodWludDY0X3QgKilmZWF0dXJlX21hc2sgfD0KPj4gRkVBVFVS
RV9NQVNLKEZFQVRVUkVfVkNOX1BHX0JJVCkKPj4gLQkJCQl8IEZFQVRVUkVfTUFTSyhGRUFUVVJF
X0pQRUdfUEdfQklUKTsKPj4gKwkJKih1aW50NjRfdCAqKWZlYXR1cmVfbWFzayB8PQo+PiBGRUFU
VVJFX01BU0soRkVBVFVSRV9WQ05fUEdfQklUKTsKPj4gKwo+PiArCWlmIChzbXUtPmFkZXYtPnBn
X2ZsYWdzICYgQU1EX1BHX1NVUFBPUlRfSlBFRykKPj4gKwkJKih1aW50NjRfdCAqKWZlYXR1cmVf
bWFzayB8PQo+PiBGRUFUVVJFX01BU0soRkVBVFVSRV9KUEVHX1BHX0JJVCk7Cj4+Cj4+ICAgCS8q
IGRpc2FibGUgRFBNIFVDTEsgYW5kIERTIFNPQ0NMSyBvbiBuYXZpMTAgQTAgc2VjdXJlIGJvYXJk
ICovCj4+ICAgCWlmIChpc19hc2ljX3NlY3VyZShzbXUpKSB7Cj4+IEBAIC02NjUsNiArNjY3LDMx
IEBAIHN0YXRpYyBpbnQgbmF2aTEwX2RwbV9zZXRfdXZkX2VuYWJsZShzdHJ1Y3QKPj4gc211X2Nv
bnRleHQgKnNtdSwgYm9vbCBlbmFibGUpCj4+ICAgCXJldHVybiByZXQ7Cj4+ICAgfQo+Pgo+PiAr
c3RhdGljIGludCBuYXZpMTBfZHBtX3NldF9qcGVnX2VuYWJsZShzdHJ1Y3Qgc211X2NvbnRleHQg
KnNtdSwgYm9vbAo+PiArZW5hYmxlKSB7Cj4+ICsJc3RydWN0IHNtdV9wb3dlcl9jb250ZXh0ICpz
bXVfcG93ZXIgPSAmc211LT5zbXVfcG93ZXI7Cj4+ICsJc3RydWN0IHNtdV9wb3dlcl9nYXRlICpw
b3dlcl9nYXRlID0gJnNtdV9wb3dlci0+cG93ZXJfZ2F0ZTsKPj4gKwlpbnQgcmV0ID0gMDsKPj4g
Kwo+PiArCWlmIChlbmFibGUpIHsKPj4gKwkJaWYgKHNtdV9mZWF0dXJlX2lzX2VuYWJsZWQoc211
LAo+PiBTTVVfRkVBVFVSRV9KUEVHX1BHX0JJVCkpIHsKPj4gKwkJCXJldCA9IHNtdV9zZW5kX3Nt
Y19tc2dfd2l0aF9wYXJhbShzbXUsCj4+IFNNVV9NU0dfUG93ZXJVcEpwZWcsIDEpOwo+PiArCQkJ
aWYgKHJldCkKPj4gKwkJCQlyZXR1cm4gcmV0Owo+PiArCQl9Cj4+ICsJCXBvd2VyX2dhdGUtPmpw
ZWdfZ2F0ZWQgPSBmYWxzZTsKPj4gKwl9IGVsc2Ugewo+PiArCQlpZiAoc211X2ZlYXR1cmVfaXNf
ZW5hYmxlZChzbXUsCj4+IFNNVV9GRUFUVVJFX0pQRUdfUEdfQklUKSkgewo+PiArCQkJcmV0ID0g
c211X3NlbmRfc21jX21zZyhzbXUsCj4+IFNNVV9NU0dfUG93ZXJEb3duSnBlZyk7Cj4+ICsJCQlp
ZiAocmV0KQo+PiArCQkJCXJldHVybiByZXQ7Cj4+ICsJCX0KPj4gKwkJcG93ZXJfZ2F0ZS0+anBl
Z19nYXRlZCA9IHRydWU7Cj4+ICsJfQo+PiArCj4+ICsJcmV0dXJuIHJldDsKPj4gK30KPj4gKwo+
PiAgIHN0YXRpYyBpbnQgbmF2aTEwX2dldF9jdXJyZW50X2Nsa19mcmVxX2J5X3RhYmxlKHN0cnVj
dCBzbXVfY29udGV4dCAqc211LAo+PiAgIAkJCQkgICAgICAgZW51bSBzbXVfY2xrX3R5cGUgY2xr
X3R5cGUsCj4+ICAgCQkJCSAgICAgICB1aW50MzJfdCAqdmFsdWUpCj4+IEBAIC0xOTk2LDYgKzIw
MjMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBwdGFibGVfZnVuY3MgbmF2aTEwX3BwdF9mdW5j
cyA9Cj4+IHsKPj4gICAJLmdldF9hbGxvd2VkX2ZlYXR1cmVfbWFzayA9IG5hdmkxMF9nZXRfYWxs
b3dlZF9mZWF0dXJlX21hc2ssCj4+ICAgCS5zZXRfZGVmYXVsdF9kcG1fdGFibGUgPSBuYXZpMTBf
c2V0X2RlZmF1bHRfZHBtX3RhYmxlLAo+PiAgIAkuZHBtX3NldF91dmRfZW5hYmxlID0gbmF2aTEw
X2RwbV9zZXRfdXZkX2VuYWJsZSwKPj4gKwkuZHBtX3NldF9qcGVnX2VuYWJsZSA9IG5hdmkxMF9k
cG1fc2V0X2pwZWdfZW5hYmxlLAo+PiAgIAkuZ2V0X2N1cnJlbnRfY2xrX2ZyZXFfYnlfdGFibGUg
PQo+PiBuYXZpMTBfZ2V0X2N1cnJlbnRfY2xrX2ZyZXFfYnlfdGFibGUsCj4+ICAgCS5wcmludF9j
bGtfbGV2ZWxzID0gbmF2aTEwX3ByaW50X2Nsa19sZXZlbHMsCj4+ICAgCS5mb3JjZV9jbGtfbGV2
ZWxzID0gbmF2aTEwX2ZvcmNlX2Nsa19sZXZlbHMsCj4+IC0tCj4+IDIuMTcuMQo+Pgo+PiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1h
aWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
