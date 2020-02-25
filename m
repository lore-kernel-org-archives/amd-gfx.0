Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853BDC35DF9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 11:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C0221556
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 11:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m0qiKV6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C0221556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1142E6EA8F;
	Tue, 25 Feb 2020 11:10:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 478176EA8F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 11:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQj9sszaTxufnQIEchX62AjQawzGewxxCclP5shK8kgUCCD4oiEgGSY38m3DWrQQjI9ZEwk8Wi06p9R3ZTNEy2W3e0eXTCDNSi4DPrkr0ur5x4jIAV4T+Ic1A5sdhM1b5D2QV1+OhUXbPIdEj6p646TGGmBP61dHj9WMmd1l8GQfs5+4QhHEGZapyMf7l6OnhTS15jP6f+mpUxt4BeG2AmJWaND7KWRMQIL/W6pBdLAb0zlbfQHJQbnXUDRM0DAad49b3SzO9jIcJkpekhrE1mQW6zQ5z5RFqZOu80EthvRNCYLUR859pKP0LsA7cE8qWJtN4sh8rviCP/Ycl019zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdbibYnd0YEkAFU45TEi/mCPdO18bZ8WXKCCGLD/3cQ=;
 b=eY1gsrucq2p0NUJC0dqyfDPBQ7KDRkRqtiEpNQsCRiYeklgVbS+qkD9YLLJ0iO1hH+okiXf2bBoD1EC3hHurhCLps4E7XFlxpQRLugjJF9Lhc7jgPeuEpV3F9puKIdXE3P7rm+4XmnfeduL5LgvS0GZ9VH94YQUTZc/VD4FgWBP1hDI/IQ7aGDLzeas+mtTbjNVapLxnD0LTF2rYI590I6IRiWwtY7SB3T1xN099MyAMFDOIyHEPvu2FrY9rFJRjoq4g1kLQ1BNzM/1J3CiAkVG9aV5zG2R2sj8fQ5DPFiBtapN72yzS43J65YuZ4Sy2qKW3zc7AnLiX5cYhdn1cWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdbibYnd0YEkAFU45TEi/mCPdO18bZ8WXKCCGLD/3cQ=;
 b=m0qiKV6T5KLgrAl4Rp2h5vc7Sc1WBUQ25zEVdUBBRlYslydwz92Is4APHZS3Uu9SENupqAY15IN36Pyw5PlJG/pH1+GKVLLKRGaAD1gvOv/2NA9ye889JDfsIGMlYtE5HW44YtG7UkrQ5pjlueaKkyyzPDnTfXYwoJzOCmi4cNI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB2550.namprd12.prod.outlook.com (2603:10b6:4:b8::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Tue, 25 Feb 2020 11:10:43 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 11:10:42 +0000
Subject: Re: [PATCH] drm/amdgpu: do not modify ring before doing ring
 validation
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200225103919.10158-1-nirmoy.das@amd.com>
 <95fdc800-b9f1-c2a5-184b-0e80b4e284f6@amd.com>
 <b1a6103f-fa9e-34d6-4fad-1fa1fe5141da@amd.com>
 <89487929-42c1-e333-81d2-2bfea7c00a0d@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <fdbe3861-98d5-596b-8023-d0b57e5e308e@amd.com>
Date: Tue, 25 Feb 2020 12:13:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <89487929-42c1-e333-81d2-2bfea7c00a0d@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2c:dd00:254c:e011:75f7:66e4]
 (2003:c5:8f2c:dd00:254c:e011:75f7:66e4) by
 FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 11:10:41 +0000
X-Originating-IP: [2003:c5:8f2c:dd00:254c:e011:75f7:66e4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5d085a8-caff-46c1-c1f1-08d7b9e35ab9
X-MS-TrafficTypeDiagnostic: DM5PR12MB2550:|DM5PR12MB2550:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB255061C469C454654DD2B0198BED0@DM5PR12MB2550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(189003)(199004)(31686004)(31696002)(36756003)(2616005)(6486002)(52116002)(2906002)(316002)(66574012)(4326008)(66556008)(5660300002)(8676002)(66476007)(8936002)(81166006)(81156014)(186003)(16526019)(66946007)(478600001)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2550;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBDhXLrT+CDlzfAzqeQj7Q+nuFE2Ps/HwlQbE7TwzHynCM5VERp1MW+tOKU3MJerL+9EMb7d9Zec4gCVvf4eCq4XXB76juCXvzGQJlQfUpqqGwPCuD0yEOaxjkrZkojoZZ5zhSOWCo1s85GGOSoRhdkBNa6rZLCtOLc5/h4gQQSPmjb5tBm9gf1PvH/UPEVXvtnSOyN99JKT3lyg3wqq+/dZPWu75AyC3uiag0EbSo2RNlMjnM9sLBBnblo7fNlK1WxSLtt1U2cuEOAnWU9Fkuui+RsiC1MR3e3Dj+8uOrYDo6XzLTsFbq5K6Z1IfUyz/obVzEn+ZTVf9GZ6BRBfRd18nNf92XAplBjb9rgn20MpXQ+S3q3ke0PRVIMQzWRAPmFNDc0MHHHy/z7EuOZUFVgqhERPyqCPGbyCInmkSSJVgol4xPyaFABPi/mM0wRs
X-MS-Exchange-AntiSpam-MessageData: tV9WexAtKaXDtacBeIS26UqE00qogah/K08OyIiGxajHkR7Naf1ksGNeIaVbnewPbtyQ9Cz1BhGbciRa/UD36miOYfEDzdkZLH5D2vHS1yR9OisbvlC80CR5j9KCkA2SZfu8yt2erHYnETLmNaENpjAjDt+08yGICvr0yP5E8D9+JGtzb1JXib66qDPiXLLRgyZijDar544FFKDGgsM4dQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d085a8-caff-46c1-c1f1-08d7b9e35ab9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 11:10:42.8781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wL+tpnHSwQ8ZEZovegT+vGee8ALhVcjhydpafwKAdxcCTvByJUlcynPnj/gRPJk3H9t3k4QHARRTg4hIsgPklQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2550
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIvMjUvMjAgMTI6MDggUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjUuMDIu
MjAgdW0gMTI6MDMgc2NocmllYiBOaXJtb3k6Cj4+Cj4+IE9uIDIvMjUvMjAgMTE6NTIgQU0sIENo
cmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAyNS4wMi4yMCB1bSAxMTozOSBzY2hyaWViIE5p
cm1veSBEYXM6Cj4+Pj4gY2hhbmdpbmcgcmluZy0+c2NoZWQucmVhZHkgc2hvdWxkIGJlIGRvbmUg
b25seSBpZiB0aGUgcmluZyBpcyAKPj4+PiBpbml0aWFsaXplZAo+Pj4KPj4+IEkgZG9uJ3QgdGhp
bmsgdGhhdCB0aGlzIG1ha2VzIG11Y2ggZGlmZmVyZW5jZS4gV2hlbiB0aGUgcmluZ3MgYXJlIAo+
Pj4gZnJlZWQgdGhlIGhhcmR3YXJlIGFuZCBzb2Z0d2FyZSBzdGFjayBuZWVkcyB0byBiZSBkaXNh
YmxlZCBxdWl0ZSAKPj4+IHNvbWUgdGltZSBiZWZvcmUuCj4+Cj4+IFllcyBpdCBkb2Vzbid0IG1h
a2UgYW55IGRpZmZlcmVuY2UuIEkgd2FudGVkIGFtZGdwdV9yaW5nX2ZpbmkoKSB0byAKPj4gbG9v
ayBiaXQgY2xlYW5lci4KPgo+IE9rLCB5b3Ugc2hvdWxkIG5vdGUgdGhhdCBpbiB0aGUgc3ViamVj
dCBhbmQgY29tbWl0IG1lc3NhZ2UuIFNvbWV0aGluZyAKPiBsaWtlICJjbGVhbnVwIGFtZGdwdV9y
aW5nX2ZpbmkiIC8gIkNoZWNrIHRoZSBwcmVyZXF1aXNpdGVzIGJlZm9yZSB0aGUgCj4gYWN0dWFs
IG9wZXJhdGlvbiIuCj4KPiBPdGhlcndpc2UgaWYgdGhhdCBpcyBub3QgY2xlYXJseSBzdGF0ZSBz
b21lYm9keSBtaWdodCB0aGluayB0aGF0IHRoaXMgCj4gaXMgYSBidWcgZml4IGFuZCBwaWNrIGl0
IHVwIGZvciBiYWNrcG9ydGluZyBhbmQgd2UgcHJvYmFibHkgZG9uJ3Qgd2FudCAKPiB0aGF0LgoK
U29ycnksIHRydWUgdGhlIHN1YmplY3QgbGluZSBpcyBjb25mdXNpbmcgd2l0aCB0aGUgYnVnIDop
LiBJIHdpbGwgbW9kaWZ5IAphbmQgcmVzZW5kLgoKClJlZ2FyZHMsCgpOaXJtb3kKCj4KPiBSZWdh
cmRzLAo+IENocmlzdGlhbi4KPgo+Pgo+Pgo+PiBSZWdhcmRzLAo+Pgo+PiBOaXJtb3kKPj4KPj4+
Cj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8
bmlybW95LmRhc0BhbWQuY29tPgo+Pj4+IC0tLQo+Pj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yaW5nLmMgfCAzICsrLQo+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jIAo+Pj4+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYwo+Pj4+IGluZGV4IDUzOWJlMTM4MjYwZS4uMThlMTFi
MGZkYzNlIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yaW5nLmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmlu
Zy5jCj4+Pj4gQEAgLTM0NCwxMiArMzQ0LDEzIEBAIGludCBhbWRncHVfcmluZ19pbml0KHN0cnVj
dCBhbWRncHVfZGV2aWNlIAo+Pj4+ICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCj4+
Pj4gwqDCoCAqLwo+Pj4+IMKgIHZvaWQgYW1kZ3B1X3JpbmdfZmluaShzdHJ1Y3QgYW1kZ3B1X3Jp
bmcgKnJpbmcpCj4+Pj4gwqAgewo+Pj4+IC3CoMKgwqAgcmluZy0+c2NoZWQucmVhZHkgPSBmYWxz
ZTsKPj4+PiDCoCDCoMKgwqDCoMKgIC8qIE5vdCB0byBmaW5pc2ggYSByaW5nIHdoaWNoIGlzIG5v
dCBpbml0aWFsaXplZCAqLwo+Pj4+IMKgwqDCoMKgwqAgaWYgKCEocmluZy0+YWRldikgfHwgIShy
aW5nLT5hZGV2LT5yaW5nc1tyaW5nLT5pZHhdKSkKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuOwo+Pj4+IMKgICvCoMKgwqAgcmluZy0+c2NoZWQucmVhZHkgPSBmYWxzZTsKPj4+PiArCj4+
Pj4gwqDCoMKgwqDCoCBhbWRncHVfZGV2aWNlX3diX2ZyZWUocmluZy0+YWRldiwgcmluZy0+cnB0
cl9vZmZzKTsKPj4+PiDCoMKgwqDCoMKgIGFtZGdwdV9kZXZpY2Vfd2JfZnJlZShyaW5nLT5hZGV2
LCByaW5nLT53cHRyX29mZnMpOwo+Pj4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
