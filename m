Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11CFC3F2CD
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 15:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E31D20848
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 15:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xpuhvYZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E31D20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC8316E198;
	Wed,  4 Mar 2020 15:09:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B66EA6E1A5
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 15:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp46sf9Mpnh/9DvxGNVN+sKuVFekvJOEen8ZBsYxpq9r+t4/8WDpjjy3khGiO3KLUZiVw9MMhPBPs7Y9918XS8tZ/Scuq4+kooKejX1KMXr43jWAy40ig7Israq/LxnRYh3ZcgvNaJHiT+8kBegr2fLysrVlRP32ygYAgiBxqHNKomQMsFOldvNBYt/F3tZcQK/bBKbJMemHmOHbmewMcbsigpK0VxVpnKXwrYGWsA4A2Ty/x4f5Dx9sIclRKboT3jViAdQzmvTOZ01wKoDFE4VR/YQJsyZNWeYSpE3KsFd3ZmZMr4XK32ZaGhtxyktlMZKzq//vhvIy5SO4LXVG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzPYl7p3/bEikQFHEdTS4Ex0vW+WxETJyzriID5Zh98=;
 b=VLcSzs2D19EES7TJH5OsEJO8ja03YzkB73/AhntJ6WdtVI8jzq9ExnCLqk/tPy/wNsZ4L2XRljqe5lICau6NsqciyS+6JJnUbe0tfXQGaQd9HlvICuHTyyAMwg0nGMH/8OlLDCO8RKWrz6VkEBo+XFqRMKxWr4m5Kek/9pDf5istf+7duIC2dID39NV0OauAIpLj+DoKUWxhQig0gEamSbugLPZTIkkEJ3WPaGYSGjy/c84BAM6voowJaaeIi1za1Kma6PXpYa7CXsbz+3opmW6uzAIeYLrsoeci5g7WclD7ndvmb/zg4G1/MR8RsVSmntvOpEvajj6B1GuGLNA2bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzPYl7p3/bEikQFHEdTS4Ex0vW+WxETJyzriID5Zh98=;
 b=xpuhvYZn054McEE+etJwdCAh/FNBrMR0/kIq3kDIfgdjNHnMSxFD3tRAU2vHXuE86pOmoioJaeWfc/laHoqJN5kLCQiTmPX5Efykd2AO1cja7ioe9O+gUqtf4ajX27aJko9tn90OT8k25VhjdcNRVBIbufEfYMMLgMqvBaminM0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB2903.namprd12.prod.outlook.com (2603:10b6:a03:139::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 15:09:28 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 15:09:28 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu/vcn: fix race condition issue for vcn start
To: christian.koenig@amd.com, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
 <29c65b64-26d1-dfef-9da9-2563f291c2e8@gmail.com>
 <00b0a2df-a45c-43e6-9c7e-6567b0f86180@amd.com>
 <2ddda823-0edd-d4f9-560b-0c89b0157e9b@amd.com>
 <11274ae4-da5e-5c7d-ba1a-877f22daea24@amd.com>
 <6294bcbb-e663-79e5-371b-28eb3a47dbfb@amd.com>
 <a9902a9e-09d1-abc0-05d0-885bb9ac4bb3@gmail.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <88441802-0be6-00e3-2478-af435379d045@amd.com>
Date: Wed, 4 Mar 2020 10:09:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <a9902a9e-09d1-abc0-05d0-885bb9ac4bb3@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::37)
 To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.233.155] (165.204.55.251) by
 YT1PR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Wed, 4 Mar 2020 15:09:27 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 866afbae-e89f-4870-28e5-08d7c04e08c7
X-MS-TrafficTypeDiagnostic: BYAPR12MB2903:|BYAPR12MB2903:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2903316734C727F44003B781E4E50@BYAPR12MB2903.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(199004)(189003)(26005)(186003)(36916002)(8936002)(956004)(16526019)(2616005)(316002)(478600001)(45080400002)(16576012)(2906002)(966005)(36756003)(52116002)(31696002)(81156014)(8676002)(6486002)(66574012)(81166006)(66946007)(53546011)(5660300002)(66476007)(66556008)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2903;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: viUX5jvFFGxK+ktoJj+Pz08/TKdV8dAdEsEskeN1ASWCnb5z0Akv/fiRw8/Wm8KKes93QfMn3weSTgEkLhPMLieQCbTOkwHdMlNXprOFDc2XcUgohF105xAerTBc7id5YJQNUSLHE0vKoNr6AdsvvQEwg2cesKrQZJphWiXjcqY8KPj9U/CJrwLXCE7cCQurCSIumLP4lEfpHVkk15CIc7Q4YjEbAm43l0z64tvkzW2By1zdx/tQmbnWFoxU8c3FBPtYFKqdYPtRXxzGkU/YqdyDza4AV46M8s9v243j/S/ywKRmM+2NdZEG8ESyr7qqhjC2Z1mA5BvJGtj0mYnNCClDngJv0ZC6ve/zN+xfiaBthJOqN2FMH1ZPfJbjeKhdJMrMtL6buaYZEhU3FvaoJOnjNLkiFGyUdMbhSbCp3mI9Qni/Zv5YJ6LjVTcQFMR/bUAjnIsJM47iqjJfciaklfTIZavi9RYXFUbUc1xY8js=
X-MS-Exchange-AntiSpam-MessageData: 0ZJeQM9+jo6WdT10bwH/ieFMC23urEAEda4CB72G5KucqubU0w4xmtBYYnHYeuiHIbEmSpVQ0D+UiOpXmKlmfN3JQ/Fuqbbi07x1o5n6xPAIDnWMw0M0Fb4SmJ6g1qvcahZsuZRtOGyA+Hrw1oXuRA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866afbae-e89f-4870-28e5-08d7c04e08c7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 15:09:28.5835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sQY/yG02lQ0mZ7ouUmVoLfPA6iM4O2qytfNHD8Cq58Jy3wQ5/ZHEIuOGMtsOVGA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2903
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

Ck9uIDIwMjAtMDMtMDQgMTA6MDMgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAw
NC4wMy4yMCB1bSAxNTo1NyBzY2hyaWViIEphbWVzIFpodToKPj4KPj4gT24gMjAyMC0wMy0wNCAz
OjUzIGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAwMy4wMy4yMCB1bSAyMzo0
OCBzY2hyaWViIEphbWVzIFpodToKPj4+Pgo+Pj4+IE9uIDIwMjAtMDMtMDMgMjowMyBwLm0uLCBK
YW1lcyBaaHUgd3JvdGU6Cj4+Pj4+Cj4+Pj4+IE9uIDIwMjAtMDMtMDMgMTo0NCBwLm0uLCBDaHJp
c3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+Pj4gQW0gMDMuMDMuMjAgdW0gMTk6MTYgc2NocmllYiBK
YW1lcyBaaHU6Cj4+Pj4+Pj4gRml4IHJhY2UgY29uZGl0aW9uIGlzc3VlIHdoZW4gbXVsdGlwbGUg
dmNuIHN0YXJ0cyBhcmUgY2FsbGVkLgo+Pj4+Pj4+Cj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogSmFt
ZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4KPj4+Pj4+PiAtLS0KPj4+Pj4+PiDCoCBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgfCA0ICsrKysKPj4+Pj4+PiDCoCBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmggfCAxICsKPj4+Pj4+PiDCoCAyIGZp
bGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+Pj4+Pj4+Cj4+Pj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyAKPj4+Pj4+PiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+Pj4+Pj4+IGluZGV4IGY5NjQ2NGUu
LmFhNzY2M2YgMTAwNjQ0Cj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Zjbi5jCj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Zjbi5jCj4+Pj4+Pj4gQEAgLTYzLDYgKzYzLDcgQEAgaW50IGFtZGdwdV92Y25fc3dfaW5p
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAKPj4+Pj4+PiAqYWRldikKPj4+Pj4+PiDCoMKgwqDCoMKg
IGludCBpLCByOwo+Pj4+Pj4+IMKgIMKgwqDCoMKgwqAgSU5JVF9ERUxBWUVEX1dPUksoJmFkZXYt
PnZjbi5pZGxlX3dvcmssIAo+Pj4+Pj4+IGFtZGdwdV92Y25faWRsZV93b3JrX2hhbmRsZXIpOwo+
Pj4+Pj4+ICvCoMKgwqAgbXV0ZXhfaW5pdCgmYWRldi0+dmNuLnZjbl9wZ19sb2NrKTsKPj4+Pj4+
PiDCoCDCoMKgwqDCoMKgIHN3aXRjaCAoYWRldi0+YXNpY190eXBlKSB7Cj4+Pj4+Pj4gwqDCoMKg
wqDCoCBjYXNlIENISVBfUkFWRU46Cj4+Pj4+Pj4gQEAgLTIxMCw2ICsyMTEsNyBAQCBpbnQgYW1k
Z3B1X3Zjbl9zd19maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlIAo+Pj4+Pj4+ICphZGV2KQo+Pj4+
Pj4+IMKgwqDCoMKgwqAgfQo+Pj4+Pj4+IMKgIMKgwqDCoMKgwqAgcmVsZWFzZV9maXJtd2FyZShh
ZGV2LT52Y24uZncpOwo+Pj4+Pj4+ICvCoMKgwqAgbXV0ZXhfZGVzdHJveSgmYWRldi0+dmNuLnZj
bl9wZ19sb2NrKTsKPj4+Pj4+PiDCoCDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4+Pj4+IMKgIH0K
Pj4+Pj4+PiBAQCAtMzIxLDYgKzMyMyw3IEBAIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2JlZ2luX3Vz
ZShzdHJ1Y3QgCj4+Pj4+Pj4gYW1kZ3B1X3JpbmcgKnJpbmcpCj4+Pj4+Pj4gwqDCoMKgwqDCoCBz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHJpbmctPmFkZXY7Cj4+Pj4+Pj4gwqDCoMKgwqDC
oCBib29sIHNldF9jbG9ja3MgPSAKPj4+Pj4+PiAhY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZh
ZGV2LT52Y24uaWRsZV93b3JrKTsKPj4+Pj4+PiDCoCArwqDCoMKgIG11dGV4X2xvY2soJmFkZXYt
PnZjbi52Y25fcGdfbG9jayk7Cj4+Pj4+Pgo+Pj4+Pj4gVGhhdCBzdGlsbCB3b24ndCB3b3JrIGNv
cnJlY3RseSBoZXJlLgo+Pj4+Pj4KPj4+Pj4+IFRoZSB3aG9sZSBpZGVhIG9mIHRoZSBjYW5jZWxf
ZGVsYXllZF93b3JrX3N5bmMoKSBhbmQgCj4+Pj4+PiBzY2hlZHVsZV9kZWxheWVkX3dvcmsoKSBk
YW5jZSBpcyB0aGF0IHlvdSBoYXZlIGV4YWN0bHkgb25lIHVzZXIgCj4+Pj4+PiBvZiB0aGF0LiBJ
ZiB5b3UgaGF2ZSBtdWx0aXBsZSByaW5ncyB0aGF0IHdob2xlIHRoaW5nIHdvbid0IHdvcmsgCj4+
Pj4+PiBjb3JyZWN0bHkuCj4+Pj4+Pgo+Pj4+Pj4gVG8gZml4IHRoaXMgeW91IG5lZWQgdG8gY2Fs
bCBtdXRleF9sb2NrKCkgYmVmb3JlIAo+Pj4+Pj4gY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCkg
YW5kIHNjaGVkdWxlX2RlbGF5ZWRfd29yaygpIGJlZm9yZSAKPj4+Pj4+IG11dGV4X3VubG9jaygp
Lgo+Pj4+Pgo+Pj4+PiBCaWcgbG9jayBkZWZpbml0ZWx5IHdvcmtzLiBJIGFtIHRyeWluZyB0byB1
c2UgYXMgc21hbGxlciBsb2NrIGFzIAo+Pj4+PiBwb3NzaWJsZSBoZXJlLiB0aGUgc2hhcmUgcmVz
b3VyY2Ugd2hpY2ggbmVlZHMgcHJvdGVjdCBoZXJlIGFyZSAKPj4+Pj4gcG93ZXIgZ2F0ZSBwcm9j
ZXNzIGFuZCBkcGcgbW9kZSBzd2l0Y2ggcHJvY2Vzcy4KPj4+Pj4KPj4+Pj4gaWYgd2UgbW92ZSBt
dXRleF91bmxvY2soKSBiZWZvcmUgc2NoZWR1bGVfZGVsYXllZF93b3JrKC4gSSBhbSAKPj4+Pj4g
d29uZGVyaW5nIHdoYXQgYXJlIHRoZSBvdGhlciBuZWNlc3NhcnkgcmVzb3VyY2VzIHdoaWNoIG5l
ZWQgcHJvdGVjdC4KPj4+Pgo+Pj4+IEJ5IHRoZSB3YXksIGNhbmNlbF9kZWxheWVkX3dvcmtfc3lu
YygpIHN1cHBvcnRzIG11bHRpcGxlIHRocmVhZCAKPj4+PiBpdHNlbGYsIHNvIEkgZGlkbid0IHB1
dCBpdCBpbnRvIHByb3RlY3Rpb24gYXJlYS4KPj4+Cj4+PiBZZWFoLCBidXQgdGhhdCdzIGNvcnJl
Y3QgYnV0IGl0IHN0aWxsIHdvbid0IHdvcmtpbmcgY29ycmVjdGx5IDopCj4+Pgo+Pj4gU2VlIHRo
ZSBwcm9ibGVtIGlzIHRoYXQgb25seSBmb3IgdGhlIGZpcnN0IGNhbGxlciAKPj4+IGNhbmNlbF9k
ZWxheWVkX3dvcmtfc3luYygpIHJldHVybnMgdHJ1ZSBiZWNhdXNlIGl0IGNhbmNlbGVkIHRoZSAK
Pj4+IGRlbGF5ZWQgd29yay4KPj4KPj4gaWYgdGhlIDFzdCBjYWxsZXIgZ2V0cyB0cnVlLiB0aGUg
Mm5kIGNhbGxlciB1bmZvcnR1bmF0ZWx5IG1heSBtaXNzIAo+PiB0aGlzIHBlbmRpbmcgc3RhdHVz
LCBzbyBpdCB3aWxsIHVuZ2F0ZSB0aGUgcG93ZXIgd2hpY2ggaXMgdW5leHBlY3RlZC4KPj4KPj4g
QnV0IGluIHBvd2VyIGdhdGUvdW5nYXRlIGZ1bmN0aW9uLCBhIHBvd2VyIHN0YXRlIGlzIG1haW50
YWluZWQsIHNvIAo+PiB0aGlzIG1pc3Mgd29uJ3QgYmUgcmVhbGx5IHRyaWdnZXJlZCB0byB1bmdh
dGUgdGhlIHBvd2VyLgo+Pgo+PiBTbyBJIHRoaW5rIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygp
IC8gc2NoZWR1bGVfZGVsYXllZF93b3JrKCkgYXJlIAo+PiBub3QgbmVjZXNzYXJ5IGJlIHByb3Rl
Y3RlZCBoZXJlLgo+Cj4gT2sgdGhhdCBjb3VsZCB3b3JrIGFzIHdlbGwuCj4KPiBCdXQgaW4gdGhp
cyBjYXNlIEkgd291bGQgcmVtb3ZlIGNoZWNraW5nIHRoZSByZXR1cm4gdmFsdWUgb2YgCj4gY2Fu
Y2VsX2RlbGF5ZWRfd29ya19zeW5jKCkgYW5kIGp1c3QgYWx3YXlzIHVuZ2F0ZSB0aGUgcG93ZXIu
Cj4KPiBUaGlzIHdheSB3ZSBwcmV2ZW50IHVnbHkgYnVncyBmcm9tIGxlYWtpbmcgaW4gd2hlbiB0
aGlzIHJlYWxseSByYWNlcyAKPiBzb21ldGltZXMuCgpTdXJlLiBUaGFua3MhCgpKYW1lcwoKPgo+
IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+IEJlc3QgUmVnYXJkcyEKPj4KPj4gSmFtZXMK
Pj4KPj4+Cj4+PiBGb3IgYWxsIG90aGVycyBpdCByZXR1cm5zIGZhbHNlIGFuZCB0aG9zZSB3b3Vs
ZCB0aGVuIHRoaW5rIHRoYXQgdGhleSAKPj4+IG5lZWQgdG8gdW5nYXRlIHRoZSBwb3dlci4KPj4+
Cj4+PiBUaGUgb25seSBzb2x1dGlvbiBJIHNlZSBpcyB0byBlaXRoZXIgcHV0IGJvdGggdGhlIAo+
Pj4gY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCkgYW5kIHNjaGVkdWxlX2RlbGF5ZWRfd29yaygp
IHVuZGVyIHRoZSAKPj4+IHNhbWUgbXV0ZXggcHJvdGVjdGlvbiBvciBzdGFydCB0byB1c2UgYW4g
YXRvbWljIG9yIG90aGVyIGNvdW50ZXIgdG8gCj4+PiBub3RlIGNvbmN1cnJlbnQgcHJvY2Vzc2lu
Zy4KPj4+Cj4+Pj4gcG93ZXIgZ2F0ZSBpcyBzaGFyZWQgYnkgYWxsIFZDTiBJUCBpbnN0YW5jZXMg
YW5kIGRpZmZlcmVudCByaW5ncyAsIAo+Pj4+IHNvIGl0wqAgbmVlZHMgYmUgcHV0IGludG8gcHJv
dGVjdGlvbiBhcmVhLgo+Pj4+Cj4+Pj4gZWFjaCByaW5nJ3Mgam9iIGl0c2VsZiBpcyBzZXJpYWxp
emVkIGJ5IHNjaGVkdWxlci4gaXQgZG9lc24ndCBuZWVkIAo+Pj4+IGJlwqAgcHV0IGludG8gdGhp
cyBwcm90ZWN0aW9uIGFyZWEuCj4+Pgo+Pj4gWWVzLCB0aG9zZSBzaG91bGQgd29yayBhcyBleHBl
Y3RlZC4KPj4+Cj4+PiBSZWdhcmRzLAo+Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+Pgo+Pj4+Pgo+Pj4+
PiBUaGFua3MhCj4+Pj4+Cj4+Pj4+IEphbWVzCj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gUmVnYXJkcywK
Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Cj4+Pj4+Pj4gwqDCoMKgwqDCoCBpZiAoc2V0X2Nsb2Nr
cykgewo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYs
IGZhbHNlKTsKPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2RldmljZV9pcF9zZXRf
cG93ZXJnYXRpbmdfc3RhdGUoYWRldiwgCj4+Pj4+Pj4gQU1EX0lQX0JMT0NLX1RZUEVfVkNOLAo+
Pj4+Pj4+IEBAIC0zNDUsNiArMzQ4LDcgQEAgdm9pZCBhbWRncHVfdmNuX3JpbmdfYmVnaW5fdXNl
KHN0cnVjdCAKPj4+Pj4+PiBhbWRncHVfcmluZyAqcmluZykKPj4+Pj4+PiDCoCDCoMKgwqDCoMKg
wqDCoMKgwqAgYWRldi0+dmNuLnBhdXNlX2RwZ19tb2RlKGFkZXYsIHJpbmctPm1lLCAmbmV3X3N0
YXRlKTsKPj4+Pj4+PiDCoMKgwqDCoMKgIH0KPj4+Pj4+PiArwqDCoMKgIG11dGV4X3VubG9jaygm
YWRldi0+dmNuLnZjbl9wZ19sb2NrKTsKPj4+Pj4+PiDCoCB9Cj4+Pj4+Pj4gwqAgwqAgdm9pZCBh
bWRncHVfdmNuX3JpbmdfZW5kX3VzZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4+Pj4+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaCAKPj4+
Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaAo+Pj4+Pj4+IGlu
ZGV4IDZmZTA1NzMuLjJhZTExMGQgMTAwNjQ0Cj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCj4+Pj4+Pj4gQEAgLTIwMCw2ICsyMDAsNyBAQCBzdHJ1Y3Qg
YW1kZ3B1X3ZjbiB7Cj4+Pj4+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIg
Cj4+Pj4+Pj4gKnZjbl9kZWNfc2NoZWRbQU1ER1BVX01BWF9WQ05fSU5TVEFOQ0VTXTsKPj4+Pj4+
PiDCoMKgwqDCoMKgIHVpbnQzMl90wqDCoMKgwqDCoMKgwqDCoCBudW1fdmNuX2VuY19zY2hlZDsK
Pj4+Pj4+PiDCoMKgwqDCoMKgIHVpbnQzMl90wqDCoMKgwqDCoMKgwqDCoCBudW1fdmNuX2RlY19z
Y2hlZDsKPj4+Pj4+PiArwqDCoMKgIHN0cnVjdCBtdXRleMKgwqDCoMKgwqDCoMKgwqAgdmNuX3Bn
X2xvY2s7Cj4+Pj4+Pj4gwqAgwqDCoMKgwqDCoCB1bnNpZ25lZMKgwqDCoCBoYXJ2ZXN0X2NvbmZp
ZzsKPj4+Pj4+PiDCoMKgwqDCoMKgIGludCAoKnBhdXNlX2RwZ19tb2RlKShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKPj4+Pj4+Cj4+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9u
Lm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZt
YWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NKYW1lcy5aaHUl
NDBhbWQuY29tJTdDZTlmNWRjYjE2NGJjNGVmYWNkNzkwOGQ3YzA0ZDI1NGYlN0MzZGQ4OTYxZmU0
ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTg5MzA5ODkzOTU3NjkyJmFtcDtz
ZGF0YT1XY3dtR2VqdWFncDVUOW9qcFNQTGFVJTJCbWxIdWlka2g3U1AzakRBU3BVU0klM0QmYW1w
O3Jlc2VydmVkPTAgCj4+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
