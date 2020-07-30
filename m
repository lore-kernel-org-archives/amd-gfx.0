Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8209CC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 11:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F78B2083E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 11:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ohE2CVSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F78B2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD326E8D3;
	Thu, 30 Jul 2020 11:00:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57F1A6E8D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 11:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQosQjXnGgN0fS7UjvWkAlztbWSdSk9Tg3ftHdana2y3gO5xjN5WqM7d/mrswYZGoprHsorP3e9D6XDq8IOtcRlYNHEaLaRBHGRSZr0pGt3WJmxtSZ8MpGElKHM7fuBv0WdDavBbfRSQg+ljvgkPZjQio1905/IlL64tdT+UEO00pK4/7i4oTixprHbwQ+qowKesVk8nXW6w+BthhK7uAbCg9rCZKALG5/k2jSnAKOZfPq3OjWLYD4bmLDk+PD0ELYtFYGDSVFlXYP5szIG0VJN9a6LRZ0gPoWNBUCLwpYxdSWVmrTnDI05DSQ3Es3fSS9eQiaJyz6Tf5/I4M5qjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+mLQ6igkHdSo63fQu2aNV0eD0mDrGahoGsWzwgOM5s=;
 b=TdaOEQf904yDW+fwdaMoRegYZx9z0AWMPAhzNSbnvy0uRg5q/1GKAmE3BLzG5hqQhmOep40S6sbhsyuBEqnCpKstBMs2kMEkphT2b2+0jbM7reJC7N6bcYtSyWYmPTt9/7CXy13cPKl/4ykRqP3q2VBMFdWrwx9hBFtDB5dnbbeRy/CjhXd1xKF/oX0diD/JvbVoebBw7Zq8Qk3JsDCx6NUmJTpFzc57kmfKY9ylO8rE2mNkWT0oe4QXtTL6uvRSnolz0klOjcCN/j+pZnoQDKvj2SoA3KFl7EKK2WOOAApl2X/JJtPmgiSfSp4L+r0Ug+fuKQaJ18GqAIpvJhTN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+mLQ6igkHdSo63fQu2aNV0eD0mDrGahoGsWzwgOM5s=;
 b=ohE2CVSglcpLZtB8LUZU4rycJdIsfZeyJ4lHRkit+id0fP0SQkxhqXCaZEzpT11fTTK0QudlJl6dxBgolnyUfU2k5lYnAPV0oiXvR4+Ju1TP3mA/MkaOmGBnJKKcYLv69CjcTgALi56y+SvzAwsBRNosAFrjdFH+HIGrPY43k54=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 30 Jul
 2020 11:00:06 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::d85e:c081:c3d:9db3]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::d85e:c081:c3d:9db3%4]) with mapi id 15.20.3216.033; Thu, 30 Jul 2020
 11:00:06 +0000
Subject: Re: [PATCH] drm/amdgpu: new ids flag for tmz
To: christian.koenig@amd.com,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200730102500.23479-1-pierre-eric.pelloux-prayer@amd.com>
 <b3a50466-04e1-29ef-b0f2-90d26a282805@gmail.com>
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Message-ID: <1cc3c73c-9f02-9e84-d1e6-03b96c83e9ca@amd.com>
Date: Thu, 30 Jul 2020 12:59:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <b3a50466-04e1-29ef-b0f2-90d26a282805@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: PR2P264CA0012.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::24)
 To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.243] (109.190.135.109) by
 PR2P264CA0012.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 11:00:05 +0000
X-Originating-IP: [109.190.135.109]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e79f03a-2837-422f-86d1-08d83477b7c6
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28583BAFB0FAC4061CB99F438D710@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pz1lAMc0aojoOa0Oj1aF84ySReJy2vyIzpbcgAuPdTfd1B/RWv/WDXeMoSLxYb64Xj3d0+8u3ju0cgbuG7+sz2cxUi8DNOcIMIrzEowqhPXs8WkdjrLwRCWqtfRt6jZshyFXnioQCw1+7Oiv1IHZsqNrSO0sL795e4+u2chRqdRFEKYfAdAakn53UwwxrfRbwtw1tqxHd0XoSfyR2TwGy3/0Rp96OzjdM+BYrS42AMfV41dYGPE0iSqHaGVU7Fie0PuYx2txcWrtlNv8Z9YD1Om0+l6i+Y1agaD+mOQYU5RdjoSbp+nm5Ui6DKay5PCZoBNQoefiSRSqUbFf8UDMRRLSyZ6c5OIF41P0tysiAHKo5NWwYcOKbPIoQ7l6olsJOnCejttzDOWPA9CGjRwkSOUMQ9QmdmZW4/OpWOEQ5V4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(8676002)(5660300002)(966005)(6486002)(956004)(2616005)(83380400001)(66574015)(55236004)(36756003)(8936002)(52116002)(31686004)(2906002)(26005)(31696002)(66476007)(16576012)(316002)(53546011)(186003)(16526019)(478600001)(66946007)(66556008)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: GdZuS8/ORODeJgMiUfyaZP26yAoNCoxE0NImOI4sJR+jXp4aE0iH+AQrtGU63hhEPaITJPEdOGMjlb1UeBCY5qmzTextllsGj9Trmph70WtudEKMH19DzsChW89HBlH44Gqorvn0L7CW2wxe7THevvV2FgL8kq0pNhIexh/mUgZ9Jbwp6vczSasKt9wMRL+sr0HODA5ZQL4/iGzRYyKRvxhg2JafsKwIUXXQNYrExxnUAecl70vLYde/Ze6mMjxZkt1fQ63zgfg2DFaHVvG96Eq0zsIEzl8+6ybjFSdbB4fo+UZYqnwrqd0Mg8TXCw/ADWxixtPgRFfnCUb9nJoGTYIgTLd0M+F1CnHopQUIo79NkLCVvqyRbgjIeDietxIOlX99/ddbqqWQLrbQm0rjnlE5fQ0Xo5RbTjKlLNBgbZpnc14+hTQbvvaFPkgU4qgaVCrHaaiJbaGUg4F13wPBL6HxbgB/afUlk1t0WvVfpiWhCpC0JPorrfR8fJYPuo5+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e79f03a-2837-422f-86d1-08d83477b7c6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 11:00:06.4277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7nqMCozhUzbJWwaVej8eb3dXYXGLNdR2mYfBOPf7DyGeyVWCw2N0O0ywMZGs/39ZjH8ltjpPpu1EcrKz9ddZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
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

SGkgQ2hyaXN0aWFuLAoKT24gMzAvMDcvMjAyMCAxMjozMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90
ZToKPiBBbSAzMC4wNy4yMCB1bSAxMjoyNSBzY2hyaWViIFBpZXJyZS1FcmljIFBlbGxvdXgtUHJh
eWVyOgo+PiBBbGxvd3MgVU1EIHRvIGtub3cgaWYgVE1aIGlzIHN1cHBvcnRlZCBhbmQgZW5hYmxl
ZC4KPj4gVGhpcyBjb21taXQgYWxzbyBidW1wcyBLTVNfRFJJVkVSX01JTk9SIHNvIFVNRCBrbm93
cyBpZiBpdCBjYW4gcmVseSBvbgo+PiBBTURHUFVfSURTX0ZMQUdTX1RNWi4KPj4gLS0tCj4+IFBh
dGNoIGZvciB1c2luZyBpdCBpbiBNZXNhIGlzIGF0IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9w
Lm9yZy9tZXNhL21lc2EvLS9tZXJnZV9yZXF1ZXN0cy82MDQ5Cj4+IChhYy9ncHVfaW5mbzogYWRk
IGRldGVjdGlvbiBvZiBUTVogc3VwcG9ydCkuCj4+Cj4+IFBpZXJyZS1FcmljCj4+Cj4+IMKgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8IDMgKystCj4+IMKgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyB8IDIgKysKPj4gwqAgaW5jbHVkZS91
YXBpL2RybS9hbWRncHVfZHJtLmjCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEgKwo+PiDCoCAzIGZp
bGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4+IGluZGV4IDYyOTFmNWYwZDIyMy4uNmRj
YWIyNTkxNGNmIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZHJ2LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5j
Cj4+IEBAIC04OCw5ICs4OCwxMCBAQAo+PiDCoMKgICogLSAzLjM3LjAgLSBMMiBpcyBpbnZhbGlk
YXRlZCBiZWZvcmUgU0RNQSBJQnMsIG5lZWRlZCBmb3IgY29ycmVjdG5lc3MKPj4gwqDCoCAqIC0g
My4zOC4wIC0gQWRkIEFNREdQVV9JQl9GTEFHX0VNSVRfTUVNX1NZTkMKPj4gwqDCoCAqIC0gMy4z
OS4wIC0gRE1BQlVGIGltcGxpY2l0IHN5bmMgZG9lcyBhIGZ1bGwgcGlwZWxpbmUgc3luYwo+PiAr
ICogLSAzLjQwLjAgLSBBZGQgQU1ER1BVX0lEU19GTEFHU19UTVoKPj4gwqDCoCAqLwo+PiDCoCAj
ZGVmaW5lIEtNU19EUklWRVJfTUFKT1LCoMKgwqAgMwo+PiAtI2RlZmluZSBLTVNfRFJJVkVSX01J
Tk9SwqDCoMKgIDM5Cj4+ICsjZGVmaW5lIEtNU19EUklWRVJfTUlOT1LCoMKgwqAgNDAKPiAKPiBJ
IGRvbid0IHRoaW5rIHdlIG5lZWQgdGhpcy4gVW51c2VkIGlkc19mbGFncyBzaG91bGQgYmUgemVy
byBvbiBvbGRlciBrZXJuZWxzLgoKSWYgd2UgZG9uJ3QgaW5jcmVhc2UgS01TX0RSSVZFUl9NSU5P
UiB0aGVuOgoKICAgaWRzX2ZsYWdzICYgQU1ER1BVX0lEU19GTEFHU19UTVogPT0gMAoKaGFzIDIg
bWVhbmluZ3M6CiAgLSBUTVogaXMgbm90IGVuYWJsZWQKICAtIG9yIFRNWiBtaWdodCBiZSBlbmFi
bGVkIGJ1dCBpdCdzIG5vdCByZXBvcnRlZCBieSB0aGUga2VybmVsCgpJZiB5b3UgcHJlZmVyIG5v
dCBidW1waW5nIEtNU19EUklWRVJfTUlOT1IgdGhhdCdzIGZpbmUgdGhvdWdoLiBNZXNhIGNhbiBj
aGVjayBpZiBUTVogaXMgcmVhbGx5CmRpc2FibGVkIGJ5IHRyeWluZyB0byBhbGxvY2F0ZSBhIFRN
WiBidWZmZXIuCgpUaGFua3MsClBpZXJyZS1FcmljCgo+IAo+IFRoYXQncyB3aHkgd2UgaGF2ZSB0
aGlzIGluIHRoZSBmaXJzdCBwbGFjZS4KPiAKPiBDaHJpc3RpYW4uCj4gCj4+IMKgICNkZWZpbmUg
S01TX0RSSVZFUl9QQVRDSExFVkVMwqDCoMKgIDAKPj4gwqAgwqAgaW50IGFtZGdwdV92cmFtX2xp
bWl0ID0gMDsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9rbXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYwo+PiBpbmRl
eCBlZWJiZTIxMDNlMzIuLmQ5MmVlMzBiYzA2YyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9rbXMuYwo+PiBAQCAtNzM2LDYgKzczNiw4IEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X2luZm9faW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwgc3RydWN0
IGRybV9maWxlCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9pbmZvLmlkc19mbGFn
cyB8PSBBTURHUFVfSURTX0ZMQUdTX0ZVU0lPTjsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChh
bWRncHVfbWNicCB8fCBhbWRncHVfc3Jpb3ZfdmYoYWRldikpCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGRldl9pbmZvLmlkc19mbGFncyB8PSBBTURHUFVfSURTX0ZMQUdTX1BSRUVNUFRJ
T047Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoYWRldi0+Z21jLnRtel9lbmFibGVkKQo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfaW5mby5pZHNfZmxhZ3MgfD0gQU1ER1BVX0lEU19GTEFH
U19UTVo7Cj4+IMKgIMKgwqDCoMKgwqDCoMKgwqDCoCB2bV9zaXplID0gYWRldi0+dm1fbWFuYWdl
ci5tYXhfcGZuICogQU1ER1BVX0dQVV9QQUdFX1NJWkU7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB2
bV9zaXplIC09IEFNREdQVV9WQV9SRVNFUlZFRF9TSVpFOwo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS91YXBpL2RybS9hbWRncHVfZHJtLmggYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAo+
PiBpbmRleCA3NjVhOTRlYzQ0MjAuLmI4MjZmMmQ2ZWZlMSAxMDA2NDQKPj4gLS0tIGEvaW5jbHVk
ZS91YXBpL2RybS9hbWRncHVfZHJtLmgKPj4gKysrIGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVf
ZHJtLmgKPj4gQEAgLTY3Niw2ICs2NzYsNyBAQCBzdHJ1Y3QgZHJtX2FtZGdwdV9jc19jaHVua19k
YXRhIHsKPj4gwqDCoCAqLwo+PiDCoCAjZGVmaW5lIEFNREdQVV9JRFNfRkxBR1NfRlVTSU9OwqDC
oMKgwqDCoMKgwqDCoCAweDEKPj4gwqAgI2RlZmluZSBBTURHUFVfSURTX0ZMQUdTX1BSRUVNUFRJ
T07CoMKgwqDCoCAweDIKPj4gKyNkZWZpbmUgQU1ER1BVX0lEU19GTEFHU19UTVrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIDB4NAo+PiDCoCDCoCAvKiBpbmRpY2F0ZSBpZiBhY2NlbGVyYXRpb24gY2Fu
IGJlIHdvcmtpbmcgKi8KPj4gwqAgI2RlZmluZSBBTURHUFVfSU5GT19BQ0NFTF9XT1JLSU5HwqDC
oMKgwqDCoMKgwqAgMHgwMAo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
