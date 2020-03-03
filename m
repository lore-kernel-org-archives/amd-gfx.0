Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DB4C3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 22:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB0E2072A
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 22:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RPGyoJpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB0E2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BF806E978;
	Tue,  3 Mar 2020 22:48:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ADF86E978
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 22:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyJlwUIL7O+Gk794LA1k7Er90kcsEXumMAm7OKerYJnExCgRUdMbcjbmiMn7+C5ay1t9B23xvilD+oBIxfEgN0U4V7EzXCgI+7KubkRkELPOz4xsXexfzRtsAhsTu+TBUt/HsrY1n9DIeG51xJeN1O5RBjmcIO/hH9FISD8R16P3/3xNGT2xGNwy9sejNZ3Jo1b9roQhuJyQrhkbT1ro4YwF6DsFnrwC9FY28SADFbfA61zznCUJMIWx7rY8HwK0lciyxMMqXyIlWbNrPBhGXINmMMF6+wcAIxhxL8I5m7cT/CyzRGGhr6RRzV1/c45f6upC+Vr6jvWJSwHO57mneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7krGwHPXvly8BC4LPXUwtp0+SNjc9eySheCP2582yYw=;
 b=Yk9GscmKpHU6jzkDU+/F4L2N7otTbys84bss7Jis331l1A4J6mge23JHggUah7NgvZcX9B5R5HDx+fIqYCx6c8dIBfnHDoMlt5xdTPZwVipMQfddeZBXM2ussNI1MLfY/CBjxmPYYNNDu7aHa7A7xKtxVXNR34QFZyQDiX0ZVPuywm42MMSXLLxpSk+Ov4SfA85gKRBhOgDsJAxi6lXJUkhDSg56P68HXyPHuWtzc6rxqdztbjY2L4egYMjxxAxKbGmmtrKQlcqeN7Pvy2P/gMkNGex604ShxrDH8ciz0w0UsLxWza6FtWfAnLVKze4saTtw5PfyiOR+6aKMSGUp6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7krGwHPXvly8BC4LPXUwtp0+SNjc9eySheCP2582yYw=;
 b=RPGyoJpnQLckkfUQzS16bQT9pd0gADdkyUEhFAPwqJDnHbA4qYSLxOPZZnt1PVUxHkH66Fyw6UEiGBLnhXIr7kHgK61Ls06fBs6ZJ4Pmdf+sRW9qxKjLgdz5Hd9Qa9QPwS7g7eVhnFW7dXHKff9778tG6HjzafQzeZf3UBat7xY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3272.namprd12.prod.outlook.com (2603:10b6:a03:131::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 22:48:11 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 22:48:11 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu/vcn: fix race condition issue for vcn start
From: James Zhu <jamesz@amd.com>
To: christian.koenig@amd.com, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
 <29c65b64-26d1-dfef-9da9-2563f291c2e8@gmail.com>
 <00b0a2df-a45c-43e6-9c7e-6567b0f86180@amd.com>
Organization: AMD RTG
Message-ID: <2ddda823-0edd-d4f9-560b-0c89b0157e9b@amd.com>
Date: Tue, 3 Mar 2020 17:48:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <00b0a2df-a45c-43e6-9c7e-6567b0f86180@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::45) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.233.155] (165.204.55.251) by
 YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 22:48:10 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 886b1d85-0eb2-4c09-2429-08d7bfc4f30c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3272:|BYAPR12MB3272:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3272263A8504A581976B5DA8E4E40@BYAPR12MB3272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(189003)(199004)(8936002)(26005)(66946007)(66476007)(66556008)(36756003)(8676002)(66574012)(478600001)(2906002)(81156014)(81166006)(16526019)(186003)(2616005)(5660300002)(956004)(31686004)(31696002)(6486002)(52116002)(16576012)(316002)(53546011)(36916002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3272;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQXRl8OpH//JMk3oG/P5Xdu2iX4XoP9jnsqKJdYnQ/p6zYvFmsXWoOEUb9gzzPyT9BDbJKTg4Wh7KObBi3PvuWho41l5+Ny0Adp1OcMRhYgTL0dZu7/AxDXkavTbcWD1ES/86TPR9HuSJ6QwCsZJB0KCRB8dOBuXea9i5DjUjoXyctw1rUzR5iRmdakns+7JIQfruENYyPiaKNp6t2e6xtgkoKpkTYu+6L31NT4f7W7x0ZM0Dns3YAqumO3kJAuLbV9zVFc/n4IIiyA1WNxT7i5/1FCDStdS12DeLOhHto4I8LxDFoEa/VopTp4eWikel7hxKoFBXHlYLnLUpdqL3qP+1qdeM8ixLF64AZdakPxO3QaBUE4jOOI7lG8TycBcxMhN/oclqRWMBuCjICL3V8GIY/Ha7ePHHyfLipsutYZwP9syMx3oyRqGCwP2x9IM
X-MS-Exchange-AntiSpam-MessageData: u1I1gM3lm9hvcr8tb/8mP9TT4UeOFzB2IWVl4VYq2B9uCy3vo0qLgkvpRFVEA3S+bWwhcFuDLl/foBy+vusUscByretX1yjeDuoP5NMvU7PpfycLGHACM8KeYeWcze6ZmKYzUK8oNOyZ7HaMZTwtkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 886b1d85-0eb2-4c09-2429-08d7bfc4f30c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 22:48:11.0477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGjtkluJHWGttPIY5RX1u59Sh30nOvlKM8VNZfq3IDRi8gx+N6fVsaa7h1FxM4uT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3272
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

Ck9uIDIwMjAtMDMtMDMgMjowMyBwLm0uLCBKYW1lcyBaaHUgd3JvdGU6Cj4KPiBPbiAyMDIwLTAz
LTAzIDE6NDQgcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMDMuMDMuMjAgdW0g
MTk6MTYgc2NocmllYiBKYW1lcyBaaHU6Cj4+PiBGaXggcmFjZSBjb25kaXRpb24gaXNzdWUgd2hl
biBtdWx0aXBsZSB2Y24gc3RhcnRzIGFyZSBjYWxsZWQuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTog
SmFtZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jIHwgNCArKysrCj4+PiDCoCBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmggfCAxICsKPj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92Y24uYyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Zjbi5jCj4+PiBpbmRleCBmOTY0NjRlLi5hYTc2NjNmIDEwMDY0NAo+Pj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCj4+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4+IEBAIC02Myw2ICs2Myw3IEBAIGludCBh
bWRncHVfdmNuX3N3X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+PiDCoMKgwqDC
oMKgIGludCBpLCByOwo+Pj4gwqAgwqDCoMKgwqDCoCBJTklUX0RFTEFZRURfV09SSygmYWRldi0+
dmNuLmlkbGVfd29yaywgCj4+PiBhbWRncHVfdmNuX2lkbGVfd29ya19oYW5kbGVyKTsKPj4+ICvC
oMKgwqAgbXV0ZXhfaW5pdCgmYWRldi0+dmNuLnZjbl9wZ19sb2NrKTsKPj4+IMKgIMKgwqDCoMKg
wqAgc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKPj4+IMKgwqDCoMKgwqAgY2FzZSBDSElQX1JB
VkVOOgo+Pj4gQEAgLTIxMCw2ICsyMTEsNyBAQCBpbnQgYW1kZ3B1X3Zjbl9zd19maW5pKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4gwqDCoMKgwqDCoCB9Cj4+PiDCoCDCoMKgwqDCoMKg
IHJlbGVhc2VfZmlybXdhcmUoYWRldi0+dmNuLmZ3KTsKPj4+ICvCoMKgwqAgbXV0ZXhfZGVzdHJv
eSgmYWRldi0+dmNuLnZjbl9wZ19sb2NrKTsKPj4+IMKgIMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+
PiDCoCB9Cj4+PiBAQCAtMzIxLDYgKzMyMyw3IEBAIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2JlZ2lu
X3VzZShzdHJ1Y3QgCj4+PiBhbWRncHVfcmluZyAqcmluZykKPj4+IMKgwqDCoMKgwqAgc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Owo+Pj4gwqDCoMKgwqDCoCBib29sIHNl
dF9jbG9ja3MgPSAKPj4+ICFjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPnZjbi5pZGxl
X3dvcmspOwo+Pj4gwqAgK8KgwqDCoCBtdXRleF9sb2NrKCZhZGV2LT52Y24udmNuX3BnX2xvY2sp
Owo+Pgo+PiBUaGF0IHN0aWxsIHdvbid0IHdvcmsgY29ycmVjdGx5IGhlcmUuCj4+Cj4+IFRoZSB3
aG9sZSBpZGVhIG9mIHRoZSBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoKSBhbmQgCj4+IHNjaGVk
dWxlX2RlbGF5ZWRfd29yaygpIGRhbmNlIGlzIHRoYXQgeW91IGhhdmUgZXhhY3RseSBvbmUgdXNl
ciBvZiAKPj4gdGhhdC4gSWYgeW91IGhhdmUgbXVsdGlwbGUgcmluZ3MgdGhhdCB3aG9sZSB0aGlu
ZyB3b24ndCB3b3JrIGNvcnJlY3RseS4KPj4KPj4gVG8gZml4IHRoaXMgeW91IG5lZWQgdG8gY2Fs
bCBtdXRleF9sb2NrKCkgYmVmb3JlIAo+PiBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoKSBhbmQg
c2NoZWR1bGVfZGVsYXllZF93b3JrKCkgYmVmb3JlIAo+PiBtdXRleF91bmxvY2soKS4KPgo+IEJp
ZyBsb2NrIGRlZmluaXRlbHkgd29ya3MuIEkgYW0gdHJ5aW5nIHRvIHVzZSBhcyBzbWFsbGVyIGxv
Y2sgYXMgCj4gcG9zc2libGUgaGVyZS4gdGhlIHNoYXJlIHJlc291cmNlIHdoaWNoIG5lZWRzIHBy
b3RlY3QgaGVyZSBhcmUgcG93ZXIgCj4gZ2F0ZSBwcm9jZXNzIGFuZCBkcGcgbW9kZSBzd2l0Y2gg
cHJvY2Vzcy4KPgo+IGlmIHdlIG1vdmUgbXV0ZXhfdW5sb2NrKCkgYmVmb3JlIHNjaGVkdWxlX2Rl
bGF5ZWRfd29yayguIEkgYW0gCj4gd29uZGVyaW5nIHdoYXQgYXJlIHRoZSBvdGhlciBuZWNlc3Nh
cnkgcmVzb3VyY2VzIHdoaWNoIG5lZWQgcHJvdGVjdC4KCkJ5IHRoZSB3YXksIGNhbmNlbF9kZWxh
eWVkX3dvcmtfc3luYygpIHN1cHBvcnRzIG11bHRpcGxlIHRocmVhZCBpdHNlbGYsIApzbyBJIGRp
ZG4ndCBwdXQgaXQgaW50byBwcm90ZWN0aW9uIGFyZWEuwqAgcG93ZXLCoCBnYXRlIGlzIHNoYXJl
ZCBieSBhbGwgClZDTiBJUCBpbnN0YW5jZXMgYW5kIGRpZmZlcmVudCByaW5ncyAsIHNvIGl0wqAg
bmVlZHMgYmUgcHV0IGludG8gCnByb3RlY3Rpb24gYXJlYS4KCmVhY2ggcmluZydzIGpvYiBpdHNl
bGYgaXMgc2VyaWFsaXplZCBieSBzY2hlZHVsZXIuIGl0IGRvZXNuJ3QgbmVlZCBiZcKgIApwdXQg
aW50byB0aGlzIHByb3RlY3Rpb24gYXJlYS4KCj4KPiBUaGFua3MhCj4KPiBKYW1lcwo+Cj4+Cj4+
IFJlZ2FyZHMsCj4+IENocmlzdGlhbi4KPj4KPj4+IMKgwqDCoMKgwqAgaWYgKHNldF9jbG9ja3Mp
IHsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIGZhbHNl
KTsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfZGV2aWNlX2lwX3NldF9wb3dlcmdhdGlu
Z19zdGF0ZShhZGV2LCAKPj4+IEFNRF9JUF9CTE9DS19UWVBFX1ZDTiwKPj4+IEBAIC0zNDUsNiAr
MzQ4LDcgQEAgdm9pZCBhbWRncHVfdmNuX3JpbmdfYmVnaW5fdXNlKHN0cnVjdCAKPj4+IGFtZGdw
dV9yaW5nICpyaW5nKQo+Pj4gwqAgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZXYtPnZjbi5wYXVzZV9k
cGdfbW9kZShhZGV2LCByaW5nLT5tZSwgJm5ld19zdGF0ZSk7Cj4+PiDCoMKgwqDCoMKgIH0KPj4+
ICvCoMKgwqAgbXV0ZXhfdW5sb2NrKCZhZGV2LT52Y24udmNuX3BnX2xvY2spOwo+Pj4gwqAgfQo+
Pj4gwqAgwqAgdm9pZCBhbWRncHVfdmNuX3JpbmdfZW5kX3VzZShzdHJ1Y3QgYW1kZ3B1X3Jpbmcg
KnJpbmcpCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Zjbi5oIAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgKPj4+
IGluZGV4IDZmZTA1NzMuLjJhZTExMGQgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdmNuLmgKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92Y24uaAo+Pj4gQEAgLTIwMCw2ICsyMDAsNyBAQCBzdHJ1Y3QgYW1kZ3B1X3Zj
biB7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAKPj4+ICp2Y25fZGVj
X3NjaGVkW0FNREdQVV9NQVhfVkNOX0lOU1RBTkNFU107Cj4+PiDCoMKgwqDCoMKgIHVpbnQzMl90
wqDCoMKgwqDCoMKgwqDCoCBudW1fdmNuX2VuY19zY2hlZDsKPj4+IMKgwqDCoMKgwqAgdWludDMy
X3TCoMKgwqDCoMKgwqDCoMKgIG51bV92Y25fZGVjX3NjaGVkOwo+Pj4gK8KgwqDCoCBzdHJ1Y3Qg
bXV0ZXjCoMKgwqDCoMKgwqDCoMKgIHZjbl9wZ19sb2NrOwo+Pj4gwqAgwqDCoMKgwqDCoCB1bnNp
Z25lZMKgwqDCoCBoYXJ2ZXN0X2NvbmZpZzsKPj4+IMKgwqDCoMKgwqAgaW50ICgqcGF1c2VfZHBn
X21vZGUpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+PgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
