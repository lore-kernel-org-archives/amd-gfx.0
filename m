Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE203C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 21:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21D420707
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 21:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21D420707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C1E36FA97;
	Fri,  6 Dec 2019 21:52:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01ECF6FA97
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 21:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzBoKMcOxbv/AiGb9Hdc8NWGH+kbdCM0fgXOOsJGfCsHW3Tj6l3SqGmYWGoFhxR3FRu0QDhR0xsMgfNUCQ6DLOJGYpm1MsKSNOG1mYEf3iRq4E7eLVeaodyzzG2RSEOfM6bGPGE62p/Ef+u3gW1+y+ylUKQbTvJiywZ2XBLVHgszJxT7AJWZG4hJqb8T3rmxJaFFKrDJsfvUcPrKZdEjvJvC0g+ZtctWdQeRLhq39YLovwpIuaLnWVOCsazHx2AMagsHfjqQ6WDcH7lch5wsyVtuecFrsFtLHXi7yU1dX05QhjUr38g5mmzo0e2NMDmhP0C+e/BpvUUTscSE+aUGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xl/KJ/CUOlkiuMatgdECl3NTIGXG9dyixXvViUVw394=;
 b=ax9qx85Hr/A0Q8ZRFyrbvTTXBOksXvtSlrQnIJpvQvXF8R1HVDhD0pHf2lDHTRUxr+6JpQTdAVIZ//raw7UwuhlM+kCdqPFKZXGdvLDQeycMPIub8wCQiiLlqrskgGjN+KE4Smo3EmmXd2hfFFOWTx5JKg9WXa7bYYgsYjLTXmrurcPVP0rmpYUdmRXcFjSY6mQ5ge3Kt3ThwbVyOKF2MWa+LwkNMHrpCBk8elwty8XIxiJLcyUFEGi+isOyQ6JA+PIAl9kiUluinFaVy9gYVUf/TRUzJAryId59CmyeCWn3srI8razlJT7oVw5YiM9Nw8vt060AtyNy6FKurFpczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3083.namprd12.prod.outlook.com (20.178.31.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Fri, 6 Dec 2019 21:52:34 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::71fe:9848:c834:1cd6]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::71fe:9848:c834:1cd6%3]) with mapi id 15.20.2516.017; Fri, 6 Dec 2019
 21:52:34 +0000
Subject: Re: [PATCH 2/3] tests/amdgpu: Fix unused function warning
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <f57d33f459df0c733ef108b2beb889e844450542.1575606273.git.luben.tuikov@amd.com>
 <ef63cf555221724a49c7f926c57786cae559fe77.1575606273.git.luben.tuikov@amd.com>
 <BYAPR12MB2806E067D3B177DCE07A3AA0F15F0@BYAPR12MB2806.namprd12.prod.outlook.com>
 <054751d9-6a54-c15b-5066-7187125b06ea@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <781707c2-2e6f-4c16-7e17-bce268b52e67@amd.com>
Date: Fri, 6 Dec 2019 16:52:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
In-Reply-To: <054751d9-6a54-c15b-5066-7187125b06ea@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::39) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74d717dc-ae7b-4a55-c0d0-08d77a9699c7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3083:|DM6PR12MB3083:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB308349623BA72099273AEBB6995F0@DM6PR12MB3083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0243E5FD68
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(13464003)(199004)(189003)(2906002)(81166006)(81156014)(8676002)(2870700001)(478600001)(86362001)(966005)(8936002)(45080400002)(65956001)(31696002)(50466002)(229853002)(6486002)(99286004)(76176011)(52116002)(110136005)(58126008)(316002)(305945005)(36756003)(31686004)(4326008)(2616005)(44832011)(6512007)(5660300002)(26005)(6506007)(53546011)(66574012)(66556008)(186003)(66476007)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3083;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJ0fmGW5Y2UbWxZaRij9YCSPSV8K0kN22SdTAlFZ4/P3z4xIejEN69kl5DnFDR5sS5STbFlEH3HdkGEC/Ff+bNWc+1SRztfUVjsQ+ARdHItrWgvcy6rWX7ExhmC9lX1yP0rvUsHGtpqLUt/X/Ad7U4RIzBKmteMjrDBRN68IwLCdNJ9wVA0YZy+fGMWj3kZHRdKiYPAVvfG6ASUYcEBRY0JTrK9QR43YWWk96BHgl7FzNoIqdWwnK+MajLRRkB5blTcffV8VPDm33EFl2FoP9zbr2KHGmcNH1s8/IFDjA0eaTqRNuyXYvQnq/nNYqorVOyKNYhHEZ5hWWW9WhwvE2EHBWQRI/pkZz5UlMEErd8vXCLM3caPd5FXp47VO+XM9dWGCBLmaaVN/buPJZZCsCDFRAN4oLW1KtqeZ6FeKggoBytlz0tUkhcHbZ110fos8GV9Tf4J27XLCbWkz9iDgT6IaGWHDmgl5LPlLQ0mPwL40XDWkFxuVaI05/OSkHyUhLHTOToDdKKRXWzCqLIasBBSVgP6ZAiEFbPq6NROFoiM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d717dc-ae7b-4a55-c0d0-08d77a9699c7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 21:52:34.1301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzedywK0WtckEa3U+Ji9xtNNsoVvuyJ2mixCIY0492wnxlSMbZ8sI8Z0lH08+asa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xl/KJ/CUOlkiuMatgdECl3NTIGXG9dyixXvViUVw394=;
 b=uVH+FlMoIg5WYZAHkz48ReIU+nAuJT/fgtu4SBdN2dJ2UYghXEvEgp4dbNzg00tt63nuCHC+qOhYpTTd8jT+Teru+G2PURQE5x7XkGwZVXi/okjkqWePqcVE+319+Qx9Lqn04v2TSQBCOCJXrzRfdr/gKfgAAsZpaud1no/+bJY=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAxOS0xMi0wNiAzOjQ3IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMDYu
MTIuMTkgdW0gMDk6MDMgc2NocmllYiBDaGVuLCBHdWNodW46Cj4+IFtBTUQgT2ZmaWNpYWwgVXNl
IE9ubHkgLSBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0KPj4KPj4KPj4KPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEx1YmVuIFR1aWtvdgo+PiBTZW50OiBGcmlk
YXksIERlY2VtYmVyIDYsIDIwMTkgMTI6MzIgUE0KPj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+OyBUdWlrb3YsIEx1YmVuIDxMdWJlbi5UdWlrb3ZAYW1kLmNvbT47IEtvZW5pZywgQ2hy
aXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+Cj4+IFN1YmplY3Q6IFtQQVRDSCAyLzNd
IHRlc3RzL2FtZGdwdTogRml4IHVudXNlZCBmdW5jdGlvbiB3YXJuaW5nCj4+Cj4+IFRoaXMgcGF0
Y2ggZml4ZXM6Cj4+IC1XdW51c2VkLWZ1bmN0aW9uCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEx1YmVu
IFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+Cj4+IC0tLQo+PiAgIHRlc3RzL2FtZGdwdS9y
YXNfdGVzdHMuYyB8IDQgKysrLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2FtZGdwdS9yYXNfdGVzdHMu
YyBiL3Rlc3RzL2FtZGdwdS9yYXNfdGVzdHMuYyBpbmRleCBkNzE0YmU3My4uNGMzOTUzODIgMTAw
NjQ0Cj4+IC0tLSBhL3Rlc3RzL2FtZGdwdS9yYXNfdGVzdHMuYwo+PiArKysgYi90ZXN0cy9hbWRn
cHUvcmFzX3Rlc3RzLmMKPj4gQEAgLTcwOSw2ICs3MDksNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVf
cmFzX2Rpc2FibGVfdGVzdCh2b2lkKQo+PiAgIAl9Cj4+ICAgfQo+PiAgIAo+PiArI2lmZGVmIEFN
REdQVV9SQVNfVEVTVAo+PiBbR3VjaHVuXU1heWJlIGl0J3MgbW9yZSBmaW5lIHRvIG5hbWUgaXQg
dG8gQU1ER1BVX1JBU19FTkFCTEVfVEVTVD8gQU1ER1BVX1JBU19URVNUIGlzIG9uZSBtb3JlIGdl
bmVyaWMgbWFjcm8sIHdoaWNoIGNvdmVycyBhbGwgc3ViLXRlc3RzIGxpa2UgcXVlcnkvaW5qZWN0
L2VuYWJsZS9kaXNhYmxlIHRlc3QgLgo+IAo+IFdlbGwgbXkgcXVlc3Rpb24gaXMgbW9yZSB3aHkg
ZG8gd2h5IGRvIHdlIGhhdmUgdGhpcyBkZWZpbmUgaW4gdGhlIGZpcnN0IAo+IHBsYWNlPwo+IAo+
IFRlc3Qgc2hvdWxkIGFsd2F5cyBjb21waWxlIHJlZ2FyZGxlc3MgaWYgdGhlIGtlcm5lbCBzdXBw
b3J0cyB0aGUgZmVhdHVyZSAKPiBvciBub3QuCgoKT2theS4gSSdsbCByZW1vdmUgdGhlIG1hY3Jv
IHRvIHBlcm1hbmVudGx5CmVuYWJsZSB0aGUgdGVzdCwgYW5kIHJlc3VibWl0IHRoZSBwYXRjaCBz
ZXJpZXMuCgpUaGFuayB5b3UgZm9yIHJldmlld2luZyEKClJlZ2FyZHMsCkx1YmVuCgo+IAo+IFJl
Z2FyZHMsCj4gQ2hyaXN0aWFuLgo+IAo+Pgo+PiAgIHN0YXRpYyB2b2lkIGFtZGdwdV9yYXNfZW5h
YmxlX3Rlc3Qodm9pZCkgIHsKPj4gICAJaW50IGk7Cj4+IEBAIC03MTcsNiArNzE4LDcgQEAgc3Rh
dGljIHZvaWQgYW1kZ3B1X3Jhc19lbmFibGVfdGVzdCh2b2lkKQo+PiAgIAkJYW1kZ3B1X3Jhc19m
ZWF0dXJlc190ZXN0KDEpOwo+PiAgIAl9Cj4+ICAgfQo+PiArI2VuZGlmCj4+ICAgCj4+ICAgc3Rh
dGljIHZvaWQgX19hbWRncHVfcmFzX2lwX2luamVjdF90ZXN0KGNvbnN0IHN0cnVjdCByYXNfaW5q
ZWN0X3Rlc3RfY29uZmlnICppcF90ZXN0LAo+PiAgIAkJCQkJdWludDMyX3Qgc2l6ZSkKPj4gQEAg
LTg4MSw3ICs4ODMsNyBAQCBDVV9UZXN0SW5mbyByYXNfdGVzdHNbXSA9IHsKPj4gICAJeyAicmFz
IHF1ZXJ5IHRlc3QiLAlhbWRncHVfcmFzX3F1ZXJ5X3Rlc3QgfSwKPj4gICAJeyAicmFzIGluamVj
dCB0ZXN0IiwJYW1kZ3B1X3Jhc19pbmplY3RfdGVzdCB9LAo+PiAgIAl7ICJyYXMgZGlzYWJsZSB0
ZXN0IiwJYW1kZ3B1X3Jhc19kaXNhYmxlX3Rlc3QgfSwKPj4gLSNpZiAwCj4+ICsjaWZkZWYgQU1E
R1BVX1JBU19URVNUCj4+ICAgCXsgInJhcyBlbmFibGUgdGVzdCIsCWFtZGdwdV9yYXNfZW5hYmxl
X3Rlc3QgfSwKPj4gICAjZW5kaWYKPj4gICAJQ1VfVEVTVF9JTkZPX05VTEwsCj4+IC0tCj4+IDIu
MjQuMC4xNTUuZ2Q5ZjZmM2I2MTkKPj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5v
dXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFp
bG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDZ3VjaHVuLmNoZW4l
NDBhbWQuY29tJTdDNzQ3YzZkYjM2ZDFhNGNiZjUzNmMwOGQ3N2EwNTU1MmIlN0MzZGQ4OTYxZmU0
ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTEyMDM1NjcyMTU1MTE0JmFtcDtz
ZGF0YT05eFRlTnNDNWJMUERYb2d4VnVGbkpoUmxyQ3dJdUQ5Rm01MlgwMjN3Vng0JTNEJmFtcDty
ZXNlcnZlZD0wCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
