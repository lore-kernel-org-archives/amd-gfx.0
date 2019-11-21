Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DBDC432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 13:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6702070A
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 13:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6702070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B99426E10D;
	Thu, 21 Nov 2019 13:47:58 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720044.outbound.protection.outlook.com [40.107.72.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB566E10D
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 13:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctr5QAoG1KzHj3X+LN7Qc80uhHkSlD1NWoqiK2/LOwy+J2+AMWOd5B+4dAwsEvx1B+FhcRXBLlTsng7Prn3DckY7YZHBhmUGnnm/Maufb7fFGLyyviPRXsCMW1AAdOAyN+Ihm+IyBpm1PJ1qrwsz3jhvDpY8VzH7VzvkasU+fvzEJtMOaZoAqS0gVVJKaFgQC1U3DThy11tJQZr5VhYim+MLrdtSYeDaXmjUfH9ALv2JSdqpYEcxPYnefKuLAJmNetybOD0veupjYU71MHAaEh/XVSP+Kjnx6IUchW4d2xFeBe0gUoadU31GCL/dR25l1hu3EJ6jtOrx/uyGWN0G/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH/tZRcRRDBWhl9xUQtU2zCl3eb6wZXf13bBabr1DlI=;
 b=SPIrONTV0+WXYIUOceQgQwjGhILqoaq0ZtrCUqtaLBhIJhUKJvpelPxTy91LoZHKX+EM/6F5kLJLnSTFz97965WyjpLqBT2x7lMXFN3LqGckrsYnWKvMOVQ4gDjVHZ8tPnGglNKLj278t0J9efd2YukMYb956cIprAPmEQAReWHhxmAVp6QW0yYZI/lKbg8QKY3yS0caVHo+zeSBgw80J+5jo90jNbbsxvIAAVyB1OWH1CNGpm3R2ivm1OYmocj98e+RHQz/xv1TKq6OkZHNcFuaDDZKFdXwHiIOQR9SxB/Lq6lRQFet1xENP1e5vCL3FrCzNnyTYX+GLt24ijklcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Thu, 21 Nov 2019 13:47:54 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0%7]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 13:47:54 +0000
Subject: Re: [PATCH v2] drm/amd/display: Fix Apple dongle cannot be
 successfully detected
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
To: "Li, Ching-shih (Louis)" <Ching-shih.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
References: <20191114034212.1106-1-Ching-shih.Li@amd.com>
 <MN2PR12MB406250AEB8A10A080050D952AA4E0@MN2PR12MB4062.namprd12.prod.outlook.com>
 <3c30b486-7062-ade2-0dbd-7288fbf595c1@amd.com>
Message-ID: <3ee8d870-c461-c68f-4a36-f2bf17e9e81f@amd.com>
Date: Thu, 21 Nov 2019 08:47:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <3c30b486-7062-ade2-0dbd-7288fbf595c1@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::21) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6dfd7527-7592-404c-ab26-08d76e896888
X-MS-TrafficTypeDiagnostic: BYAPR12MB3560:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3560A9538D73BE1F08CDDEA5EC4E0@BYAPR12MB3560.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0228DDDDD7
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(47660400002)(199004)(189003)(13464003)(6666004)(478600001)(6636002)(66556008)(66946007)(50466002)(81166006)(81156014)(966005)(99286004)(8936002)(2501003)(14454004)(2486003)(23676004)(6512007)(5660300002)(86362001)(31696002)(6246003)(316002)(66476007)(58126008)(110136005)(31686004)(3846002)(47776003)(11346002)(2906002)(25786009)(65956001)(66066001)(446003)(76176011)(6436002)(52116002)(386003)(65806001)(53546011)(4001150100001)(6506007)(6306002)(7736002)(14444005)(36756003)(305945005)(8676002)(6486002)(229853002)(26005)(6116002)(2616005)(186003)(2870700001)(46800400005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3560;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAt/itzI5hdUakV0eNZozXk2mtqJ8sLtU5hCoUkf8OtjJQGOwg02/Gqe+O2UMBJ1gBMyByzTB7hPQrjgjIdMPegx/0ddoFtt7HNBkm3IWwiU9yGdxKOXFEGoqS9sjtVzP6USu3CdORKjqTdSM4HE/U1msnZgHl9FpjFT86vsC0NE2cMu/msC34KlESjv3K6NZf5hNyIMvRWWGx7LJcXUvGZUM2GYSfI9xnhLohPWZ5Xmid5embHQn9zDc3fezHjxe73aQY/94aOH6lJr4z05isrK51RvTt5RdxXfhuIEssbIYc2Me9rYPQh2bU/NomCpS61VyVEpOVGwUJW4Mg36O6Zpgu+LuJ+kYvsb4RxzpY+JI6raxP88zRNxCr5P1m95ywu70nPPMZDlmlt7/ZlIAB56fiQxQ0MpSXvU/Wb8C80BFozRJnQLrQXxoyeaWjcW/grZejcdihUhe31uAZfttPBuKQwa9lUNICYALtOJpr8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfd7527-7592-404c-ab26-08d76e896888
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 13:47:54.1925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIwlPLvcto+CL59qXyU9CyrKwMMD1V/geiNsD4Sp2pF3XjRMQPhDth9bRlJK2OUIhgvzrDruRVAZIM2Nb8Kmnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3560
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH/tZRcRRDBWhl9xUQtU2zCl3eb6wZXf13bBabr1DlI=;
 b=YGIuhnfoPnboJGWQdB4p4IJIbXO7qHuaaolrGirNz7mbTu+qnr3ZTHeMjxV7WfJleD4ixziWtxyRBIexmkFKI9MQ5lw4KiSrfS9LT4nNLqtoRkXo6SV8Rnq8W/No4xtPCMt+5ZUHjCQh7COxpWtg3Etm3KIi/EBn7b69ejCPIXg=
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191121134750._UqH94GuJFyIKAMZjX2INN-f0xxF53DAMoJLLGkHiHE@z>

T24gMjAxOS0xMS0yMSA4OjQwIGEubS4sIEthemxhdXNrYXMsIE5pY2hvbGFzIHdyb3RlOgo+IE9u
IDIwMTktMTEtMjEgMzozMSBhLm0uLCBMaSwgQ2hpbmctc2hpaCAoTG91aXMpIHdyb3RlOgo+PiBI
aSByZXZpZXdlcnMsCj4+Cj4+IFdoYXQgaXMgdGhlIHJldmlldyByZXN1bHQgZm9yIHRoaXMgcGF0
Y2g/IEN1c3RvbWVyIGlzIHB1c2hpbmcgb24gdGhpcyAKPj4gY2hhbmdlIHRvIG1lcmdlLiBUS1Mg
Zm9yIHlvdXIgYXR0ZW50aW9uLgo+Pgo+PiBCUiwKPj4gTG91aXMKPj4KPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogTG91aXMgTGkgPENoaW5nLXNoaWguTGlAYW1kLmNvbT4K
Pj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDE0LCAyMDE5IDExOjQyIEFNCj4+IFRvOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBDYzogS2F6bGF1c2thcywgTmljaG9sYXMgPE5p
Y2hvbGFzLkthemxhdXNrYXNAYW1kLmNvbT47IFdlbnRsYW5kLCAKPj4gSGFycnkgPEhhcnJ5Lldl
bnRsYW5kQGFtZC5jb20+OyBMaSwgQ2hpbmctc2hpaCAoTG91aXMpIAo+PiA8Q2hpbmctc2hpaC5M
aUBhbWQuY29tPgo+PiBTdWJqZWN0OiBbUEFUQ0ggdjJdIGRybS9hbWQvZGlzcGxheTogRml4IEFw
cGxlIGRvbmdsZSBjYW5ub3QgYmUgCj4+IHN1Y2Nlc3NmdWxseSBkZXRlY3RlZAo+Pgo+PiBbV2h5
XQo+PiBFeHRlcm5hbCBtb25pdG9yIGNhbm5vdCBiZSBkaXNwbGF5ZWQgY29uc2lzdGVudGx5LCBp
ZiBjb25uZWN0aW5nIHZpYSAKPj4gdGhpcyBBcHBsZSBkb25nbGUgKEExNjIxLCBVU0IgVHlwZS1D
IHRvIEhETUkpLgo+PiBCeSBleHBlcmltZW50cywgaXQgaXMgY29uZmlybWVkIHRoYXQgdGhlIGRv
bmdsZSBuZWVkcyAyMDBtcyBhdCBsZWFzdCAKPj4gdG8gYmUgcmVhZHkgZm9yIGNvbW11bmljYXRp
b24sIGFmdGVyIGl0IHNldHMgSFBEIHNpZ25hbCBoaWdoLgo+Pgo+PiBbSG93XQo+PiBXaGVuIHJl
Y2VpdmluZyBIUEQgSVJRLCBkZWxheSAzMDBtcyBhdCB0aGUgYmVnaW5uaW5nIG9mIGhhbmRsZV9o
cGRfaXJxKCkuCj4+IFRoZW4gcnVuIHRoZSBvcmlnaW5hbCBwcm9jZWR1cmUuCj4+IFdpdGggdGhp
cyBwYXRjaCBhcHBsaWVkLCB0aGUgcHJvYmxlbSBjYW5ub3QgYmUgcmVwcm9kdWNlZC4KPj4gV2l0
aCBvdGhlciBkb25nbGVzLCB0ZXN0IHJlc3VsdHMgYXJlIFBBU1MuCj4+IFRlc3QgcmVzdWx0IGlz
IFBBU1MgdG8gcGx1ZyBpbiBIRE1JIGNhYmxlIHdoaWxlIHBsYXlpbmcgdmlkZW8sIGFuZCB0aGUg
Cj4+IHZpZGVvIGlzIGJlaW5nIHBsYXlpbmcgc21vb3RobHkuCj4+IFRlc3QgcmVzdWx0IGlzIFBB
U1MgYWZ0ZXIgc3lzdGVtIHJlc3VtZXMgZnJvbSBzdXNwZW5kLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5
OiBMb3VpcyBMaSA8Q2hpbmctc2hpaC5MaUBhbWQuY29tPgo+IAo+IFRoaXMgaXMgc3RpbGwgYSBO
QUsgZnJvbSBtZSBzaW5jZSB0aGUgbG9naWMgaGFzbid0IGNoYW5nZWQgZnJvbSB0aGUgCj4gZmly
c3QgcGF0Y2guCj4gCj4gU2xlZXBzIGRvbid0IGJlbG9uZyBpbiBJUlEgaGFuZGxlcnMuCj4gCj4g
UmVnYXJkcywKPiBOaWNob2xhcyBLYXpsYXVza2FzCgpBY3R1YWxseSwgdGhpcyBsaXZlcyBpbiB0
aGUgbG93IElSUSBjb250ZXh0IHdoaWNoIG1lYW5zIHRoYXQgaXQncyAKYWxyZWFkeSBiZWVuIHF1
ZXVlZCBvZmYgdG8gYSB3b3JrIHRocmVhZCBzbyBpdCdzIHNhZmUgdG8gc2xlZXAuCgpJJ20gbm90
IHN1cmUgd2Ugd2FudCBhIGdlbmVyYWwgMzAwbXMgc2xlZXAgKGV2ZW4gYnkgZXhwZXJpbWVudCB5
b3Ugc2FpZCAKdGhhdCBpdCBvbmx5IG5lZWRlZCAyMDBtcykgZm9yIGFsbCBjb25uZWN0b3JzLgoK
TmljaG9sYXMgS2F6bGF1c2thcwoKPiAKPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCA1ICsrKysrCj4+IMKgIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+PiBpbmRleCAwYWVmOTJiN2MwMzcuLjVi
ODQ0YjZhNWE1OSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG0uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4+IEBAIC0xMDI1LDYgKzEwMjUsMTEgQEAgc3RhdGljIHZv
aWQgaGFuZGxlX2hwZF9pcnEodm9pZCAqcGFyYW0pCj4+IMKgwqDCoMKgwqAgc3RydWN0IGRybV9k
ZXZpY2UgKmRldiA9IGNvbm5lY3Rvci0+ZGV2Owo+PiDCoMKgwqDCoMKgIGVudW0gZGNfY29ubmVj
dGlvbl90eXBlIG5ld19jb25uZWN0aW9uX3R5cGUgPSBkY19jb25uZWN0aW9uX25vbmU7Cj4+ICvC
oMKgwqAgLyogU29tZSBtb25pdG9ycy9kb25nbGVzIG5lZWQgYXJvdW5kIDIwMG1zIHRvIGJlIHJl
YWR5IGZvciAKPj4gY29tbXVuaWNhdGlvbgo+PiArwqDCoMKgwqAgKiBhZnRlciB0aG9zZSBkZXZp
Y2VzIGRyaXZlIEhQRCBzaWduYWwgaGlnaC4KPj4gK8KgwqDCoMKgICovCj4+ICvCoMKgwqAgbXNs
ZWVwKDMwMCk7Cj4+ICsKPj4gwqDCoMKgwqDCoCAvKiBJbiBjYXNlIG9mIGZhaWx1cmUgb3IgTVNU
IG5vIG5lZWQgdG8gdXBkYXRlIGNvbm5lY3RvciBzdGF0dXMgCj4+IG9yIG5vdGlmeSB0aGUgT1MK
Pj4gwqDCoMKgwqDCoMKgICogc2luY2UgKGZvciBNU1QgY2FzZSkgTVNUIGRvZXMgdGhpcyBpbiBp
dCdzIG93biBjb250ZXh0Lgo+PiDCoMKgwqDCoMKgwqAgKi8KPj4gLS0gCj4+IDIuMjEuMAo+Pgo+
IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1k
LWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
