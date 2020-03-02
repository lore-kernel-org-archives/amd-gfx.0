Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D96C3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 20:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F9B21739
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 20:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3Q4+MN4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F9B21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4DA6E480;
	Mon,  2 Mar 2020 20:25:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68FF96E480
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 20:25:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0FjWTk7Ss0WcwxNuLsDxxb+6clhrrsmboeMZ52OyS+/6UhWD/gsqJfPttwn/dmkqOTH/RRSwVeZl4H6nGfY3PfzsN4v1mrASt5LYGcbWzC4tytTj65eB69g855SUbTBBvjTaWGORBC/Q6LsAePYiUrfSma6Ex845KAFrTg254y5Eu8pa+0w7hquTENfBgQ8rS0Kg6cvivmkL+DzEM8cbLZtuVVR7jWzpTT9r+94YMWPWDBEPx0X/JxWKbe2Cwb9Shbtpd5Im6q+BfuhKFJI+wb2ZWSDt4cb2HnOoDJ7oXUt3ym2YYr9lxVnrxeGBuxsgZI4Rw5AyOl4GBfLYUARfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3C6jDhtDsf9EMfGx4iqiPuguH1IdjsQ68fAEju3ckk=;
 b=WIRUs/fMyaqn+3ZGUj4TLH35mgOd4Ano+pZBYORN0SePE7Ap3eZydX87OypRykRWnyICncbvN3vGozp/eVgcGM/pN9pAIsuYolYcT0De5HEyixAjlmjjYZFx73Us87ACPTuOS1VQiDPivWacFGoPrON9evYlfNuVJvZwy3SeFpeDCT2GR8QjX4QlPrvarGzr8zvK3v/er98kL9/2TblS2ttZFnWZaQQLFVkWhVSQwxWzRhCdr/Eq+CI9Jr/U2dWdEWNVRj2oqC/SYfYkufZSZI031Q6FRtnX0P1ypTJPlYPz4gG4JOrZb6y0AEtglCh5LSvc9ApSzu+JTObk14eFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3C6jDhtDsf9EMfGx4iqiPuguH1IdjsQ68fAEju3ckk=;
 b=3Q4+MN4JfxedIoBL4qMfX1D+2t9bRAch09qruGNYbBSO8zsalY2E4YL/JDl+2Mg+KDdYvhBm+g8QqZX1cTCREO5mKKEBvdzCnaXYT73JKRxxFV9Y9HwQMDRvFDLBUzRMMWDyx9KiCvd14XceLOt7ZBfjdBJGXCS8tvBJWLo2cFE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3803.namprd12.prod.outlook.com (2603:10b6:5:1ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 20:25:38 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 20:25:38 +0000
Subject: Re: [RFC PATCH 1/3] drm/amdgpu: implement ring init_priority for
 compute ring
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200226203730.4621-1-nirmoy.das@amd.com>
 <20200226203730.4621-2-nirmoy.das@amd.com>
 <d76bc281-31e5-d0e2-47a5-6c41bc05c401@amd.com>
 <de34385b-8e9a-93d0-389d-7875d380293e@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <1e8ea668-ef6d-9933-0468-9d1f2a06cc1a@amd.com>
Date: Mon, 2 Mar 2020 15:25:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <de34385b-8e9a-93d0-389d-7875d380293e@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::45) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Mon, 2 Mar 2020 20:25:38 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57f971c2-e211-43be-3354-08d7bee7deff
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:|DM6PR12MB3803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38035A121C00F8690BA5CDCC99E70@DM6PR12MB3803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(26005)(4326008)(2906002)(6486002)(53546011)(6506007)(5660300002)(966005)(186003)(31686004)(16526019)(478600001)(45080400002)(31696002)(66574012)(2616005)(66476007)(66556008)(66946007)(44832011)(8936002)(8676002)(86362001)(81166006)(81156014)(6512007)(36756003)(52116002)(110136005)(956004)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3803;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tS+ZHXv6TN14g90yIw8M+FNnTM9kPvHUDWGRTRSXJAIN2pRZe+X/xF2pyBT0pRjLo2T9Q5PnGU0va0PRdRLHObVjQ+OIOqhzFGifwdr74rrLu4zZaQA0O4DwB3zTZQZr6wD3ZUS8DVLA/8aGoa3KtV9RxKz3fZBPi1CM3Q25Exv562mOKW2NV4VM2Nu/8eGgd9Zq5UV3tazF6CBvFCvMM6/7eoJg9khKsxMhxhLZmMFwlZgfvFjyutxjAFCBUKhPruLa+mBh1yfYD43jK/yKs7ttxQjiBq3Qa2VubG9TcERMmsKbGF3ZNvOlIwKPagfauYpKLs4ct1ksC+lSx6vc16Pmgb80+dX2A+Wqo6Fox7trr3NKnnP9Uyz/4+DISdxp3F9GtfWAondjnDD/dDJqcON3jAWZYgf67xYPZB3lxB2GyN2gQJYufO88S8SDm0K5MGWCd9r45E3ek6TFUXRoMlgYJEkfbHxW9lHK9hLRDDk=
X-MS-Exchange-AntiSpam-MessageData: 6xrTihQu+FegK02a8+DfgyIWVH9bfRT/Uw+Iotz+CYT3EulFIgQm2s9DtTel0VOswfMRdaGbIz8H3/ydVb2XE4krr92qEeHopVknAsD/huxQJf0E2NyP5ZatWGTzM0HYLBeU8URzzrPYFu6w4df/qQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f971c2-e211-43be-3354-08d7bee7deff
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 20:25:38.6892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5wA6L8uIZXICdyQkIO1noBlyMk5DAMNGwXXZydqpNdPgRWJ6RvryW6gAIpnhcFR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3803
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMi0yOCAyOjM4IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjgu
MDIuMjAgdW0gMDQ6Mjkgc2NocmllYiBMdWJlbiBUdWlrb3Y6Cj4+IE9uIDIwMjAtMDItMjYgMzoz
NyBwLm0uLCBOaXJtb3kgRGFzIHdyb3RlOgo+Pj4gaW5pdF9wcmlvcml0eSB3aWxsIHNldCBzZWNv
bmQgY29tcHV0ZSBxdWV1ZShnZng4IGFuZCBnZng5KSBvZiBhIHBpcGUgdG8gaGlnaCBwcmlvcml0
eQo+Pj4gYW5kIDFzdCBxdWV1ZSB0byBub3JtYWwgcHJpb3JpdHkuCj4+Pgo+Pj4gU2lnbmVkLW9m
Zi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgo+Pj4gLS0tCj4+PiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmggfCAgMSArCj4+PiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgICAgfCAxNCArKysrKysrKysrKysrKwo+Pj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jICAgIHwgMTMgKysrKysrKysr
KysrKwo+Pj4gICAzIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuaCBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmgKPj4+IGluZGV4IDI0Y2FmZjA4NWQw
MC4uYTEwOTM3M2I5ZmU4IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3JpbmcuaAo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3JpbmcuaAo+Pj4gQEAgLTE3MCw2ICsxNzAsNyBAQCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVu
Y3Mgewo+Pj4gICAJLyogcHJpb3JpdHkgZnVuY3Rpb25zICovCj4+PiAgIAl2b2lkICgqc2V0X3By
aW9yaXR5KSAoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+Pj4gICAJCQkgICAgICBlbnVtIGRy
bV9zY2hlZF9wcmlvcml0eSBwcmlvcml0eSk7Cj4+PiArCXZvaWQgKCppbml0X3ByaW9yaXR5KSAo
c3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKTsKPj4+ICAgCS8qIFRyeSB0byBzb2Z0IHJlY292ZXIg
dGhlIHJpbmcgdG8gbWFrZSB0aGUgZmVuY2Ugc2lnbmFsICovCj4+PiAgIAl2b2lkICgqc29mdF9y
ZWNvdmVyeSkoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCB1bnNpZ25lZCB2bWlkKTsKPj4+ICAg
CWludCAoKnByZWVtcHRfaWIpKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyk7Cj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKPj4+IGluZGV4IGZhMjQ1OTczZGUxMi4uMTRiYWI2
ZTA4YmQ2IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4
XzAuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwo+Pj4g
QEAgLTYzMzQsNiArNjMzNCwxOSBAQCBzdGF0aWMgdm9pZCBnZnhfdjhfMF9yaW5nX3NldF9wcmlv
cml0eV9jb21wdXRlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKPj4+ICAgCWdmeF92OF8wX3Bp
cGVfcmVzZXJ2ZV9yZXNvdXJjZXMoYWRldiwgcmluZywgYWNxdWlyZSk7Cj4+PiAgIH0KPj4+Cj4+
PiArc3RhdGljIHZvaWQgZ2Z4X3Y4XzBfcmluZ19pbml0X3ByaW9yaXR5X2NvbXB1dGUoc3RydWN0
IGFtZGdwdV9yaW5nICpyaW5nKQo+PiBXaHkgdHdvIHZlcmJzIGluIHRoaXMgZnVuY3Rpb246ICJp
bml0IiBhbmQgImNvbXB1dGUiPwo+IAo+IENvbXB1dGUgaXMgbm90IGEgdmVyYiBoZXJlIGJ1dCBy
YXRoZXIgdGhlIGRlc2NyaXB0aW9uIG9mIHRoZSByaW5nIHR5cGUuCj4gCj4+IENlcnRhaW5seSB0
aGVyZSBpcyBubyBuZWVkIGZvciAiY29tcHV0ZSIuCj4+IEp1c3QgY2FsbCBpdAo+Pgo+PiBnZnhf
YmxhaF9yaW5nX3ByaW9yaXR5X2luaXQoKQo+IAo+IEkgd291bGQgY2FsbCBpdCBnZnhfKl9pbml0
X2NvbXB1dGVfcmluZ19wcmlvcml0eSgpLgoKVGhhdCdzIGJldHRlci4gQ2FuIHdlIGFiYnJldmlh
dGUgaXQgc28gdGhhdCB0aGUgbmFtZQppc24ndCB0aGF0IGxvbmc/IFdlIGRvIGhhdmUgYWJicmV2
aWF0aW9ucyBhbGwgb3ZlciB0aGUgY29kZSwKc28gImNyIiBmb3IgImNvbXB1dGVfcmluZyIgd291
bGQgcHJvYmFibHkgYmUgb2theS4KVGhlbiB3ZSBjYW4gdXNlICJDUiIgaW4gY29tbWVudHMgYW5k
ICJjciIgaW4gY29kZSB0byBtZWFuCiJjb21wdXRlX3JpbmciLgoKZ2Z4XypfaW5pdF9jcl9wcmlv
KCkKClJlZ2FyZHMsCkx1YmVuCgo+IAo+Pgo+PiBQdXR0aW5nIHRoZSBvYmplY3QgZmlyc3QgYW5k
IHRoZSB2ZXJiIGxhc3QsIGFzIGlzIGNvbW1vbmx5IGRvbmUuCj4gCj4gV2UgbmVlZCB0byBtYWtl
IHN1cmUgdGhhdCB3ZSBub3RlIHRoYXQgdGhpcyBpcyBmb3IgdGhlIGNvbXB1dGUgcmluZ3MuCj4g
Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4gCj4+Cj4+PiArewo+Pj4gKwkvKiBzZXQgcGlwZSAw
IHRvIG5vcm1hbCBwcmlvcml0eSBhbmQgcGlwZSAxIHRvIGhpZ2ggcHJpb3JpdHkqLwo+Pj4gKwlp
ZiAocmluZy0+cXVldWUgPT0gMSkgewo+Pj4gKwkJZ2Z4X3Y4XzBfaHFkX3NldF9wcmlvcml0eShy
aW5nLT5hZGV2LCByaW5nLCB0cnVlKTsKPj4+ICsJCWdmeF92OF8wX3Jpbmdfc2V0X3BpcGVfcGVy
Y2VudChyaW5nLCB0cnVlKTsKPj4+ICsJfSBlbHNlIHsKPj4+ICsJCWdmeF92OF8wX2hxZF9zZXRf
cHJpb3JpdHkocmluZy0+YWRldiwgcmluZywgZmFsc2UpOwo+Pj4gKwkJZ2Z4X3Y4XzBfcmluZ19z
ZXRfcGlwZV9wZXJjZW50KHJpbmcsIGZhbHNlKTsKPj4+ICsJfQo+Pj4gKwo+Pj4gK30KPj4gQWdh
aW4uIE5vdGljZSB0aGF0IHRoZSBvbmx5IGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgdHdvIG91dGNv
bWVzCj4+IG9mIHRoZSBjb25kaXRpb25hbCBpcyB0aGUgbGFzdCBwYXJhbWV0ZXIgdG8gYm90aC4K
Pj4KPj4gU28geW91IGNvdWxkIHdyaXRlIHlvdXIgY29kZSBsaWtlIHRoaXM6Cj4+Cj4+IGdmeF92
OF8wX2hxZF9zZXRfcHJpb3JpdHkocmluZy0+YWRldiwgcmluZywgcmluZy0+cXVldWUgPT0gMSk7
Cj4+IGdmeF92OF8wX3Jpbmdfc2V0X3BpcGVfcGVyY2VudChyaW5nLCByaW5nLT5xdWV1ZSA9PSAx
KTsKPj4KPj4gRnVydGhlciBtb3JlIGlmICJwcmlvcml0eSIgaGFkIHRvIGJlIHZhcmlhYmxlIHZh
bHVlLAo+PiBJJ2QgcGFyYW1ldGVyaXplIGl0IGluIGEgbWFwIChpLmUuIGFycmF5KSBhbmQgdXNl
Cj4+IGEgY29tcHV0ZWQgaW5kZXggdG8gaW5kZXggdGhlIG1hcCBpbiBvcmRlciB0byByZXRyaWV2
ZQo+PiB0aGUgdmFyaWFibGVkICJwcmlvcml0eSIuIFRoaXMgZWxpbWluYXRlcyBpZi1jb25kaXRp
b25hbHMuCj4+Cj4+IE5vdGUgaW4gZ2VuZXJhbCB0aGF0IHdlIHdhbnQgbGVzcyBpZi1jb25kaXRp
b25hbHMsCj4+IGluIHRoZSBleGVjdXRpb24gcGF0aCBhbmQgbW9yZSBzdHJlYW1saW5lIGV4ZWN1
dGlvbi4KPj4KPj4+ICsKPj4+ICAgc3RhdGljIHZvaWQgZ2Z4X3Y4XzBfcmluZ19lbWl0X2ZlbmNl
X2NvbXB1dGUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+Pj4gICAJCQkJCSAgICAgdTY0IGFk
ZHIsIHU2NCBzZXEsCj4+PiAgIAkJCQkJICAgICB1bnNpZ25lZCBmbGFncykKPj4+IEBAIC02OTY3
LDYgKzY5ODAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzIGdmeF92
OF8wX3JpbmdfZnVuY3NfY29tcHV0ZSA9IHsKPj4+ICAgCS5pbnNlcnRfbm9wID0gYW1kZ3B1X3Jp
bmdfaW5zZXJ0X25vcCwKPj4+ICAgCS5wYWRfaWIgPSBhbWRncHVfcmluZ19nZW5lcmljX3BhZF9p
YiwKPj4+ICAgCS5zZXRfcHJpb3JpdHkgPSBnZnhfdjhfMF9yaW5nX3NldF9wcmlvcml0eV9jb21w
dXRlLAo+Pj4gKwkuaW5pdF9wcmlvcml0eSA9IGdmeF92OF8wX3JpbmdfaW5pdF9wcmlvcml0eV9j
b21wdXRlLAo+Pj4gICAJLmVtaXRfd3JlZyA9IGdmeF92OF8wX3JpbmdfZW1pdF93cmVnLAo+Pj4g
ICB9Owo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+Pj4gaW5kZXgg
MWM3YTE2YjkxNjg2Li4wYzY2NzQzZmI2ZjUgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jCj4+PiBAQCAtNTE0Myw2ICs1MTQzLDE4IEBAIHN0YXRpYyB2b2lkIGdm
eF92OV8wX3Jpbmdfc2V0X3ByaW9yaXR5X2NvbXB1dGUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5n
LAo+Pj4gICAJZ2Z4X3Y5XzBfcGlwZV9yZXNlcnZlX3Jlc291cmNlcyhhZGV2LCByaW5nLCBhY3F1
aXJlKTsKPj4+ICAgfQo+Pj4KPj4+ICtzdGF0aWMgdm9pZCBnZnhfdjlfMF9yaW5nX2luaXRfcHJp
b3JpdHlfY29tcHV0ZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4+IERpdHRvIGZvciB0aGlz
IG5hbWUgYXMgcGVyIGFib3ZlLgo+Pgo+Pj4gK3sKPj4+ICsJLyogc2V0IHBpcGUgMCB0byBub3Jt
YWwgcHJpb3JpdHkgYW5kIHBpcGUgMSB0byBoaWdoIHByaW9yaXR5Ki8KPj4+ICsJaWYgKHJpbmct
PnF1ZXVlID09IDEpIHsKPj4+ICsJCWdmeF92OV8wX2hxZF9zZXRfcHJpb3JpdHkocmluZy0+YWRl
diwgcmluZywgdHJ1ZSk7Cj4+PiArCQlnZnhfdjlfMF9yaW5nX3NldF9waXBlX3BlcmNlbnQocmlu
ZywgdHJ1ZSk7Cj4+PiArCX0gZWxzZSB7Cj4+PiArCQlnZnhfdjlfMF9ocWRfc2V0X3ByaW9yaXR5
KHJpbmctPmFkZXYsIHJpbmcsIGZhbHNlKTsKPj4+ICsJCWdmeF92OV8wX3Jpbmdfc2V0X3BpcGVf
cGVyY2VudChyaW5nLCB0cnVlKTsKPj4+ICsJfQo+Pj4gK30KPj4gTm90ZSBob3cgc2ltaWxhciB0
aGlzIGlzIHRvIHRoZSB2OCBhYm92ZT8KPj4gVGhvc2UgY291bGQgYmUgbWFkZSB0aGUgc2FtZSBh
bmQgaGUgdlggcGFyYW1ldGVyaXplZCB0bwo+PiB0aGUgY29ycmVjdCBpbXBsZW1lbnRhdGlvbi4K
Pj4KPj4gRm9yIGluc3RhbmNlLCBpZiB5b3UgcGFyYW1ldGVyaXplIHRoZSAiZ2Z4X3ZYXzBfaHFk
X3NldF9wcmlvcml0eSgpIgo+PiBhbmQgImdmeF92WF8wX3Jpbmdfc2V0X3BpcGVfcGVyY2VudCgp
Ii4gVGhlbiB5b3VyIGNvZGUgYmVjb21lcywKPj4gbGlrZSB0aGlzIHBzZXVkby1jb2RlOgo+Pgo+
PiByaW5nX2luaXRfc2V0X3ByaW9yaXR5KHJpbmcpCj4+IHsKPj4gICAgICBtYXAgPSByaW5nLT5w
cm9wZXJ0eVtyaW5nLT52ZXJzaW9uXTsKPj4KPj4gICAgICBtYXAtPmhxZF9wcmlvcml0eV9zZXQo
cmluZy0+YWRldiwgcmluZywgcmluZy0+cXVldWUgPT0gMSk7Cj4+ICAgICAgbWFwLT5yaW5nX3Bp
cGVfcGVyY2VudF9zZXQocmluZywgcmluZy0+cXVldWUgPT0gMSk7Cj4+IH0KPj4KPj4gUmVnYXJk
cywKPj4gTHViZW4KPj4KPj4KPj4+ICsKPj4+ICAgc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfcmluZ19z
ZXRfd3B0cl9jb21wdXRlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKPj4+ICAgewo+Pj4gICAJ
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Owo+Pj4gQEAgLTY1MTQsNiAr
NjUyNiw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3MgZ2Z4X3Y5XzBf
cmluZ19mdW5jc19jb21wdXRlID0gewo+Pj4gICAJLmluc2VydF9ub3AgPSBhbWRncHVfcmluZ19p
bnNlcnRfbm9wLAo+Pj4gICAJLnBhZF9pYiA9IGFtZGdwdV9yaW5nX2dlbmVyaWNfcGFkX2liLAo+
Pj4gICAJLnNldF9wcmlvcml0eSA9IGdmeF92OV8wX3Jpbmdfc2V0X3ByaW9yaXR5X2NvbXB1dGUs
Cj4+PiArCS5pbml0X3ByaW9yaXR5ID0gZ2Z4X3Y5XzBfcmluZ19pbml0X3ByaW9yaXR5X2NvbXB1
dGUsCj4+PiAgIAkuZW1pdF93cmVnID0gZ2Z4X3Y5XzBfcmluZ19lbWl0X3dyZWcsCj4+PiAgIAku
ZW1pdF9yZWdfd2FpdCA9IGdmeF92OV8wX3JpbmdfZW1pdF9yZWdfd2FpdCwKPj4+ICAgCS5lbWl0
X3JlZ193cml0ZV9yZWdfd2FpdCA9IGdmeF92OV8wX3JpbmdfZW1pdF9yZWdfd3JpdGVfcmVnX3dh
aXQsCj4+PiAtLQo+Pj4gMi4yNS4wCj4+Pgo+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+PiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
JTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDbHViZW4u
dHVpa292JTQwYW1kLmNvbSU3Q2ZiMGY3NjliNDhkYTRjM2MzOTAxMDhkN2JhZmI0ZTFiJTdDM2Rk
ODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE4MzQ2MDg0NTQ5NTA1
NiZhbXA7c2RhdGE9cXF6T2czVyUyRnZrT3JHMmVnbEJNN05tQnlTMVpyZVpBZmlnT0pXRmdBMUh3
JTNEJmFtcDtyZXNlcnZlZD0wCj4+Pgo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
