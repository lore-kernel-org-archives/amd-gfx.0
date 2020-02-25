Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A01DC35DF5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 11:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED59A21556
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 11:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EzNG29TA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED59A21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E1FF6E8B7;
	Tue, 25 Feb 2020 11:00:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EF9F6E8B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 11:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKkvy8TEXmIe8j4mvb6coe/sWqzBVsCm/X5eUORklvR+tik0OVt6pcLdRDnxMatYcRcPZHIhe828S8KNZBsTxrXWxkx8dtpLAs80YLiGmLon5lmOV7YOYO8+Puzp9lTNdHZew84S/ewP1juaq2z6aZ5+55cNGU0r3Jp6Y4jLIfYWb/r2yEZnzo2Q0KU4X55rj7RQD1hAgKrKNjANHoAQcRZV4jBw7+Wuqvvc6ryraLv8TFjRZQCnCfRqYwYIvJXQyXWtmICgVVzDguybcsNSHbdo6NjmjRATTR/kFLE+oCUqxoVIW28QX29EX5owyUE926j9FXGI1gYpKrI8eJJQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqB3D3M72bpyl19RplZfwM0mSbMq5zj7P7YuSCEb0pU=;
 b=Y8oQB/ABg46JoaA+cwq33+s9jtlsircqF9KOE4IqY9fR3HSTXU/IUzEAJ2PKcMXMLbPiZ1Y4HWhBHOUdB0uGmh7GU5SsN6fhxofC6c4y0YCaTex/gSFuVuOnYA9TYGtp/DsUDn1XOZwT/MJMNxgHmmN137dfyJQ2tF9Po9Xd/vtkGPVf+mEOtgT2G2z9Gf3KJ99UcByrQkbA3xx46YKC6hX2e7gRU4zfrfaPn33v9GfGpw3HiloRGfa9EZXOinzZPxPyPyqPUz/Az2/S0Buc18S01MVZxvZxpcArQ1PvylGDbCdhmrmVFGTE8WQhg7nGJFInK6d+XXqKrDdOOLDoGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqB3D3M72bpyl19RplZfwM0mSbMq5zj7P7YuSCEb0pU=;
 b=EzNG29TAuFPWyuAnD48V3NZOufgKnu2y83vp5RWWPLV1Fnq6Royj3L/5djfKf/bsUmr4LNWvHLd+sNr9WvYERYnzWDi9zrxTDDiElL369Hl4y9SnPo7LC+7LvG0OWZ+Yr0pcG3a+ou18DjrQ6rASVfQia/N4YsOfFS4xeb3SsDE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1419.namprd12.prod.outlook.com (2603:10b6:3:77::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 11:00:35 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 11:00:34 +0000
Subject: Re: [PATCH] drm/amdgpu: do not modify ring before doing ring
 validation
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200225103919.10158-1-nirmoy.das@amd.com>
 <95fdc800-b9f1-c2a5-184b-0e80b4e284f6@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <b1a6103f-fa9e-34d6-4fad-1fa1fe5141da@amd.com>
Date: Tue, 25 Feb 2020 12:03:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <95fdc800-b9f1-c2a5-184b-0e80b4e284f6@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::26) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2c:dd00:254c:e011:75f7:66e4]
 (2003:c5:8f2c:dd00:254c:e011:75f7:66e4) by
 AM0PR01CA0085.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Tue, 25 Feb 2020 11:00:30 +0000
X-Originating-IP: [2003:c5:8f2c:dd00:254c:e011:75f7:66e4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 690c4b3b-6871-4352-d109-08d7b9e1f020
X-MS-TrafficTypeDiagnostic: DM5PR12MB1419:|DM5PR12MB1419:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB14190394ADCAB2950E5923D88BED0@DM5PR12MB1419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(189003)(199004)(6486002)(66574012)(316002)(66946007)(66476007)(31696002)(66556008)(478600001)(8936002)(53546011)(16526019)(2906002)(81156014)(81166006)(5660300002)(31686004)(186003)(36756003)(2616005)(4326008)(8676002)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1419;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MtLXk//XkNKD1d9vrbdtmfMK2hMmJQ2tFj55IAhj6pVP0CisriCRYxwZ67z8EZTQyTQMzVzDCgaMyYCUAtG6iMOZmkhgfxEmNB8kb+2QZSDN0JdILAxWLi/dLGvqFT4X26F4yyW5ZdefigWYT3ID3EN0i4GddtxuJZNm/ronVFaLqXaFvWG4OSgOip1ZhRpBObtNrMbi1C6D94RFZ8cUeP2RuwW0FsX4Vqj9Qszb5apekAlNjPOz3/swvN7I+y0Dj5AWnwYLMdUQ1725MNPYs9JZY3DaAxeisTagEEKn2a8IF0ygrc7w6Q0qA00LV9chKTt4yTrus6asRdLH0cWRGtQIRR80vcSOVBkzuYBXz2LeFCy5qdaueZNFjqOB4P9XBVzXjzIYA4GnvopBfyiqtUt1SlWsijcgC5OjCFmhZfEBCzUafgC+gN5vqHw47wP0
X-MS-Exchange-AntiSpam-MessageData: jfgrHLfcaFM46fCMorSe/+cDCPi3tZGErPrpiu15l3uzQj2njehYB3y14vxxaW5TvtUI+t4xKUWWNtqV7Ow9FCf3m+feqfMUd2dpPuMPHQ2xKYXYYZ9l+5SdBzDA6aIFVkgV7rdH7RjPtGPWOEewtVJXMpHVspttqUFdhGlxvUyUTZy9vY2I28+B99WZFA+AT/6lVkyNT6XWj7GycgO9og==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690c4b3b-6871-4352-d109-08d7b9e1f020
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 11:00:34.8014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6hVelwoFuErY198zCe8jYsI4TSByw5RBRI4D6bop7pCP/egy799Zz2Joh6F9jw+bRECs7ZAm4Ztj6rQxXfi8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1419
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

Ck9uIDIvMjUvMjAgMTE6NTIgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjUuMDIu
MjAgdW0gMTE6Mzkgc2NocmllYiBOaXJtb3kgRGFzOgo+PiBjaGFuZ2luZyByaW5nLT5zY2hlZC5y
ZWFkeSBzaG91bGQgYmUgZG9uZSBvbmx5IGlmIHRoZSByaW5nIGlzIAo+PiBpbml0aWFsaXplZAo+
Cj4gSSBkb24ndCB0aGluayB0aGF0IHRoaXMgbWFrZXMgbXVjaCBkaWZmZXJlbmNlLiBXaGVuIHRo
ZSByaW5ncyBhcmUgCj4gZnJlZWQgdGhlIGhhcmR3YXJlIGFuZCBzb2Z0d2FyZSBzdGFjayBuZWVk
cyB0byBiZSBkaXNhYmxlZCBxdWl0ZSBzb21lIAo+IHRpbWUgYmVmb3JlLgoKWWVzIGl0IGRvZXNu
J3QgbWFrZSBhbnkgZGlmZmVyZW5jZS4gSSB3YW50ZWQgYW1kZ3B1X3JpbmdfZmluaSgpIHRvIGxv
b2sgCmJpdCBjbGVhbmVyLgoKClJlZ2FyZHMsCgpOaXJtb3kKCj4KPiBDaHJpc3RpYW4uCj4KPj4K
Pj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgo+PiAtLS0K
Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYyB8IDMgKystCj4+
IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMgCj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYwo+PiBpbmRleCA1Mzli
ZTEzODI2MGUuLjE4ZTExYjBmZGMzZSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3JpbmcuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmluZy5jCj4+IEBAIC0zNDQsMTIgKzM0NCwxMyBAQCBpbnQgYW1kZ3B1X3Jpbmdf
aW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAKPj4gKmFkZXYsIHN0cnVjdCBhbWRncHVfcmluZyAq
cmluZywKPj4gwqDCoCAqLwo+PiDCoCB2b2lkIGFtZGdwdV9yaW5nX2Zpbmkoc3RydWN0IGFtZGdw
dV9yaW5nICpyaW5nKQo+PiDCoCB7Cj4+IC3CoMKgwqAgcmluZy0+c2NoZWQucmVhZHkgPSBmYWxz
ZTsKPj4gwqAgwqDCoMKgwqDCoCAvKiBOb3QgdG8gZmluaXNoIGEgcmluZyB3aGljaCBpcyBub3Qg
aW5pdGlhbGl6ZWQgKi8KPj4gwqDCoMKgwqDCoCBpZiAoIShyaW5nLT5hZGV2KSB8fCAhKHJpbmct
PmFkZXYtPnJpbmdzW3JpbmctPmlkeF0pKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+
PiDCoCArwqDCoMKgIHJpbmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7Cj4+ICsKPj4gwqDCoMKgwqDC
oCBhbWRncHVfZGV2aWNlX3diX2ZyZWUocmluZy0+YWRldiwgcmluZy0+cnB0cl9vZmZzKTsKPj4g
wqDCoMKgwqDCoCBhbWRncHVfZGV2aWNlX3diX2ZyZWUocmluZy0+YWRldiwgcmluZy0+d3B0cl9v
ZmZzKTsKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
