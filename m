Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE386C2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 16:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802D221835
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 16:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rUVJUhI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802D221835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D7E06F5F2;
	Wed, 22 Jan 2020 16:44:06 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690071.outbound.protection.outlook.com [40.107.69.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C40F96F5F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 16:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwRbtu557xdenLJK6ylAVcY1I6SIzn/46jk1VdGoirTjTMU1HFcPiHw2llcPabYEudkAwudMG3eOkbejYmuZSpkm60RyyQKblgamOxlNcy0pp+GEaVfpJo9N7VkwYAd0DGyYmcSUuJWaHOpFERGfjR6u/qXLlOw2xqRcCwoumylFsx5ykrEQRkKQn564Qh9/c4gk12wist/I2S/JJ75eziB55DTYKB4sEIHp7wy9fb/FZm9HYLPukssl9liMe2pWoDiOsgatrx69cGOtd2YQCNPk/JXOeCgGXVw2VvGRESdmehyGROQwlhwyxhSrcRN5KtJTEx58Lyad81kkMgfSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3Cl+noyfJtJdHwqL0K5IyZu/751Lu0EaZBQ7Pd6Zn4=;
 b=crnau+4ATcGSglqOV+xeKpZ5jupCDCpWHMsH4XTI2qRCWOKnjTOhrHEcCHps5QjbaWCEjD4d6JL1OJJAMvGtJ1T7BZwxZXycNz5aeNaPDmtxM0CHNHsBB1iSuQnbf3yOv07tAUyrv8igrKYymNhVIAEqWOl+zfvXFdbXnGmP9k92fx/Vb+naqZABAkoqDeun6TzfpV1+ErWLkLMqbuXiI+cPEGVBxjfyoX3T0usnUyPvtPwCjtbWE95MoKWk1nukBGFhqvJOlZwaCKUttrXhyDR0BKLL15vJmEkrDey09zBvEa/3c9K5J+MsqUrQhaD2tbKuhU4zqZcZxW4yG0welA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3Cl+noyfJtJdHwqL0K5IyZu/751Lu0EaZBQ7Pd6Zn4=;
 b=rUVJUhI4HEpl+5Kz5Blrq27bHbZTJnepocsljubonPQxKCK7JR7yxPTZ1uFmO2CORNgZqtk4UeR+nvcGzl1DsMbsiFxd3v9NBre0QqbvqZyekcbo6ZYXJWKNleVjaYsB5fBdeV0h0NLdGtAer6SucRxA4ynYodmx32stkD/8ZJI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Bhawanpreet.Lakha@amd.com; 
Received: from DM6PR12MB4236.namprd12.prod.outlook.com (10.141.184.142) by
 DM6PR12MB3385.namprd12.prod.outlook.com (20.178.198.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Wed, 22 Jan 2020 16:44:03 +0000
Received: from DM6PR12MB4236.namprd12.prod.outlook.com
 ([fe80::91ac:1f2d:b4ca:c0a4]) by DM6PR12MB4236.namprd12.prod.outlook.com
 ([fe80::91ac:1f2d:b4ca:c0a4%6]) with mapi id 15.20.2644.028; Wed, 22 Jan 2020
 16:44:03 +0000
Subject: Re: [PATCH 0/5] HDCP SRM interface
To: Alex Deucher <alexdeucher@gmail.com>, Harry Wentland <hwentlan@amd.com>
References: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
 <55a3fd2d-c2ed-4af0-543e-9850118b722a@amd.com>
 <CADnq5_NO49aT6eSDywE20h6XZSF_D4WvCyQo30cXwRMvU1YmoA@mail.gmail.com>
From: Bhawanpreet Lakha <Bhawanpreet.lakha@amd.com>
Message-ID: <7eca48bb-d1e8-a1c4-0812-665438a38ecb@amd.com>
Date: Wed, 22 Jan 2020 11:44:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <CADnq5_NO49aT6eSDywE20h6XZSF_D4WvCyQo30cXwRMvU1YmoA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::37) To DM6PR12MB4236.namprd12.prod.outlook.com
 (2603:10b6:5:212::14)
MIME-Version: 1.0
Received: from [172.29.2.119] (165.204.55.250) by
 YTXPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Wed, 22 Jan 2020 16:44:02 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a6344bb-6d28-4a4f-a4c1-08d79f5a49c3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3385:|DM6PR12MB3385:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB338571780FA5F511F98AB5DBF90C0@DM6PR12MB3385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(8936002)(31686004)(6636002)(6486002)(110136005)(54906003)(16576012)(66556008)(66476007)(66946007)(4326008)(26005)(16526019)(52116002)(186003)(8676002)(53546011)(956004)(2616005)(36756003)(45080400002)(966005)(81166006)(498600001)(5660300002)(86362001)(31696002)(2906002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3385;
 H:DM6PR12MB4236.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZelK1wdy8zrxDTaw1POwoVZhLfjc6taqwo1Z0KJd6tlIA+NedK3fsYBxW8Sbpjaa3XjW/gzQGzPSSMfhAf54Es/IST+BuN1gI8+QMSNJR1K+LbSHcYzGI/Ajwyn5EHBTSP3Xi/cOoRSCOPI0nHGSkvUO/pD0iwRRI1LKR+fXLo8yNlSZb62wzftBaT6ae7Mvl8iDeoCFg6YjH42ZpnBE48l1NMX76Y9Tan+BpEHpjXQZDzxumdy9BizGtAfV11Uvu6pHPVPM7d/fiXO3xSQPGLMfDEQHQaIkuK9fcyZfymAvEaBz+UFOokb4tAAPPsX/TBViBAMeAsLlhawoIe7oprxV32ag6tESLMFtYnZQuHgYG5/ht3Sf1A95S/pXTqBTxt5jjg0CF7a7/2e4ndGNTR4Iy7Ddk0V3gchqYGF33SPz+SW+v/FNbXamRvhu2mkG36DeXMZidYY68g+WiUDGCXkeST8g8KaAUT/OiDTQ9T4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6344bb-6d28-4a4f-a4c1-08d79f5a49c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 16:44:03.1647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Akcw1zP08hOUvk4GIMB6qsz7flI5Ojw6dNByTpqKt2+/kPmzcT3ZhxwfWPMjWGHd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3385
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
Cc: "Wentland, Harry" <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjAtMDEtMjIgMTE6MjMgYS5tLiwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IE9uIFdlZCwg
SmFuIDIyLCAyMDIwIGF0IDExOjEyIEFNIEhhcnJ5IFdlbnRsYW5kIDxod2VudGxhbkBhbWQuY29t
PiB3cm90ZToKPj4gT24gMjAyMC0wMS0xNiAzOjI5IHAubS4sIEJoYXdhbnByZWV0IExha2hhIHdy
b3RlOgo+Pj4gVGhlc2UgcGF0Y2hlcyBhZGRzIHN1cHBvcnQgZm9yIFNSTSBsb2FkaW5nLiBCeSBw
cm92aWRpbmcgYW4gaW50ZXJmYWNlIHRvIHRoZQo+Pj4gdXNlcm1vZGUKPj4+Cj4+PiBTUk0gaGFz
IHRvIGJlIHBlcnNpc3RlbnQgYW5kIHNpbmNlIHRoZSBrZXJuZWwgY2Fubm90IGRpcmVjdGx5IHdy
aXRlIHRvIHN5c3RlbQo+Pj4gc3RvcmFnZSB3ZSBuZWVkIHRvIHByb3ZpZGUgYW4gaW50ZXJmYWNl
IHNvIHRoYXQgdGhlIHVzZXJtb2RlIGNhbiBkbyBpdCBmb3IgdXMKPj4+Cj4+IFdlJ2xsIHdhbnQg
dG8gZWxhYm9yYXRlIGEgYml0IG1vcmUgb24gd2h5IGFuZCBob3cgdGhpcyBpcyBkb25lLiBBcwo+
PiBtZW50aW9uZWQgb24gbXkgcGF0Y2ggMiBjb21tZW50cyBJIHJlY29tbWVuZCB0byBkbyB0aGlz
IHRoZXJlIGFzIHRoZQo+PiBjb3ZlciBsZXR0ZXIgaXMgbG9zdCBhZnRlciBtZXJnZS4KPj4KPiBZ
b3UgbWlnaHQgYWxzbyB3YW50IHRvIGNjIGRyaS1kZXZlbCBpZiB5b3UgcmVzZW5kIHRvIGdldCBt
b3JlIHJldmlld3MuCj4gSSdtIGFsc28gbm90IGNyYXp5IGFib3V0IGhhdmluZyB0byB1cGRhdGUg
dGhlIGZpbGUgaW4gY2h1bmtzLCBidXQgSQo+IGRvbid0IGhhdmUgYW55IGJldHRlciBpZGVhcyBv
ZmYgaGFuZC4gIE1heWJlIGFuIGlvY3RsIHdvdWxkIGJlCj4gY2xlYW5lcj8KPgo+IEFsZXgKClRo
ZSBrZXJuZWwgY2FuIG9ubHkgc2VuZCBQQUdFX1NJWkUgKDRLQikgYXQgb25jZSwgc28gaWYgdGhl
IGZpbGUgaXMgCmJpZ2dlciB0aGFuIFBBR0VfU0laRSAobWF4IFNSTSBpcyA1S0IpIGl0IHdpbGwg
c2VuZCBpdCBhZ2FpbiB1bnRpbCBpdHMgCmZpbmlzaGVkICh1bmxlc3Mgd2UgaW5jcmVhc2UgdGhl
IHBhZ2Ugc2l6ZSkuCgogRnJvbSB0aGUgdXNlciBzcGFjZSBpdHMganVzdCBhIHNpbmdsZSBjb21t
YW5kIHRvIHJlYWQvd3JpdGUKCiDCoMKgwqAgc2F2ZSB0byBzdG9yYWdlIDogY2F0IC9zeXMvY2xh
c3MvZHJtL2NhcmQwL2RldmljZS9oZGNwX3NybSA+IGZpbGUKCiDCoMKgwqAgbG9hZCBmcm9tIHN0
b3JhZ2UgOiBjYXQgZmlsZT4gL3N5cy9jbGFzcy9kcm0vY2FyZDAvZGV2aWNlL2hkY3Bfc3JtCgpJ
IHdpbGwgc2VuZCBpdCB0byBkcmktZGV2ZWwgYWZ0ZXIgZml4aW5nIHdoYXQgSGFycnkgc3VnZ2Vz
dGVkLgoKVGhhbmtzCgpCaGF3YW4KCj4+IEhhcnJ5Cj4+Cj4+PiBCaGF3YW5wcmVldCBMYWtoYSAo
NSk6Cj4+PiAgICBkcm0vYW1kL2Rpc3BsYXk6IFBhc3MgYW1kZ3B1X2RldmljZSBpbnN0ZWFkIG9m
IHBzcF9jb250ZXh0Cj4+PiAgICBkcm0vYW1kL2Rpc3BsYXk6IHVwZGF0ZSBwc3AgaW50ZXJmYWNl
IGhlYWRlcgo+Pj4gICAgZHJtL2FtZC9kaXNwbGF5OiBBZGQgc3lzZnMgaW50ZXJmYWNlIGZvciBz
ZXQvZ2V0IHNybQo+Pj4gICAgZHJtL2FtZC9kaXNwbGF5OiBMb2FkIHNybSBiZWZvcmUgZW5hYmxp
bmcgSERDUAo+Pj4gICAgZHJtL2FtZC9kaXNwbGF5OiBjYWxsIHBzcCBzZXQvZ2V0IGludGVyZmFj
ZXMKPj4+Cj4+PiAgIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0u
YyB8ICAgMiArLQo+Pj4gICAuLi4vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZGNw
LmMgICAgfCAxODIgKysrKysrKysrKysrKysrKystCj4+PiAgIC4uLi9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtX2hkY3AuaCAgICB8ICAgOSArLQo+Pj4gICAuLi4vZHJtL2FtZC9kaXNw
bGF5L21vZHVsZXMvaGRjcC9oZGNwX3BzcC5oICAgfCAgMjYgKystCj4+PiAgIDQgZmlsZXMgY2hh
bmdlZCwgMjEyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4+Pgo+PiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxpbmcg
bGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL25hbTExLnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5m
cmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAy
JTdDMDElN0NCaGF3YW5wcmVldC5MYWtoYSU0MGFtZC5jb20lN0NlMTkwZDc3MDM5MmU0NjgyMjVj
MzA4ZDc5ZjU3NjU1ZCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAl
N0M2MzcxNTMwNzAwMzA4OTU4NzkmYW1wO3NkYXRhPTVtbElOVWxVR3o0YmtJY0sxaFVqdmVzOU4z
QnZpT2R0S3VMRlBmdG4xU1klM0QmYW1wO3Jlc2VydmVkPTAKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
