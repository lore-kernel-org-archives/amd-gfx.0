Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4082C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF959204FD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ugqPyVna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF959204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F386E4CA;
	Wed,  2 Sep 2020 18:10:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 089D26E489
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 18:10:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnQqn2QFwoSWpt0dAHZFZ8VtIE0f4yClLrUmdDPL7i1NSLURPvrO6iV8UbzcPOiGsJJ0KM8juhwC2AhCXWBt/1VZ2gGTzybiA4wJUTIgzKUUhf9dXUV/PRcdRLMnyM80fQdZ9JqPteFrQ+IhZVgD6DZ2Fxj0thc5UwwYj1EDb5GYTKyBADAwfImUEbpMKAtmjqydk9uV53GvvrSgiE7/NWczoykQHm+Z5cba/dSxwyeFtP/xJCmHdk2kidlbAbZzW8mx09nxHrCZ9+aGEJcj0xqTdzAYXIEcOsUe/iBaGLWhazBg71HikirRZfd4FMMCThtm7FdTas47lcMRbG533w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLtf2MXWO0yNDQM3WqI74HlzzS/lTX3/Ls9fF1CN9o0=;
 b=XpWyZs3BiaZ6zEqYY285KYYSIFzlKT57QKc0ZafRhkNrdTLxsw1644nECGyhDSnQB1ACcq6R6veYm8dftvYrT30BSFfHxIoQJ87CoP6sGgqIWvPOzZYSfctlG/63Ug36pdNF6pc2zmtuN2Z1hIXFTMyVVyTmR1K+HDAbUHFNlaGf0JRfKWPcQ/y2x4Jq7vmdwHOwiZX3LLhqMYJX9K4FQVy5xh5Zp/n5zA3hX0nG+aZVhibaDZIKunOX8KAxkHhk04sGrt57w8NPePyQwrVOyC7uzj8hcq1NaC9EAY1Rr1Mo29BHyQ/XFjQmSXxhnk8C2RBvk6Fz5eQzYqFf3cjsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLtf2MXWO0yNDQM3WqI74HlzzS/lTX3/Ls9fF1CN9o0=;
 b=ugqPyVnaskwaTesVLLCOFNkQhdDTBr/wVWBwAle57a5rdgK0zFolAsXGHzECnpXstQyjGMfwd7YqiV81ImmyZEYn1mRwe6wAzqq5fHrsfGAhJkm8Id21n66bGUkPePL4LsFBia0HYueYsLKYomuhn+aR5sVF+bPSNde8QbjPA3g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2637.namprd12.prod.outlook.com (2603:10b6:805:6b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Wed, 2 Sep
 2020 18:10:50 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 18:10:50 +0000
Subject: Re: [PATCH] drm/amdgpu: enable ih1 ih2 for Arcturus only
To: Alex Deucher <alexdeucher@gmail.com>, Alex Sierra <alex.sierra@amd.com>
References: <20200902170118.30751-1-alex.sierra@amd.com>
 <CADnq5_NRFr5vYfuwgMHQ5Y+19_UqXPoJYomBkwGMoWkvjpA_Fw@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a973acd3-e07a-2e81-c2f0-e1da707155f6@amd.com>
Date: Wed, 2 Sep 2020 14:10:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_NRFr5vYfuwgMHQ5Y+19_UqXPoJYomBkwGMoWkvjpA_Fw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::18) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTOPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Wed, 2 Sep 2020 18:10:49 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b92ca8b-ce84-4c17-66de-08d84f6b85eb
X-MS-TrafficTypeDiagnostic: SN6PR12MB2637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26374C1B6C0EDBB26EE9ECD6922F0@SN6PR12MB2637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fW67BtzLHdc/jvB+CruobWeyQnsXhgwlww6enVcf7IjVC2pFzLxHyN2bu94/yyzoyihJ/YfmtXGjHy4EHUycsgfXt1R3xQ66dmgVCyGFi0TVNhdumViHNaHvBJbPAtOAdwNXfayRys2KdwQfDSCwwLZ6HqELWR2pFv5oIF/x8Agnv0QY020iQnFloZYd14BYwHVmL/4LB9SvMLYPVxPq0fdQu6n370OQK+waWhCCm4fuqAC7HYxHKqM3Sl9CiF2nh3Gh+RbO1KsVeahNyLmG0vC3pSBIuC46rJGejK4kWY1eWPjhe1lnBa9eW+050AmcRmjRaljXbYYGJxC8L61T4i+vHjNM78FW7ypETdBXoTuL68TnGAsACOC27SuBLLoFILqhv7vIZAvihsRbz7D5PT+F02S7+t1xRq0fHoYPoR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(31686004)(44832011)(8936002)(31696002)(956004)(2616005)(8676002)(36756003)(53546011)(26005)(478600001)(4326008)(16576012)(110136005)(6486002)(83380400001)(966005)(66556008)(52116002)(66946007)(66476007)(186003)(6636002)(2906002)(5660300002)(316002)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4PFwOFtNG0tzeTG3GfpCSqiH9cY81CqsXOIuu1Yo/ats0Ylz8xLlvVcvwaT+T4+TLlaZeu/CjsPZjZGMzfJdiIVJcvc6o9QiQsEMGuQxAYTgkHnvJ6ii6bR4aRBDqd03PaSg2ibIEahp+4S0wogLKwK0XtL6ZTBK2bnrGj3jzE8pkdvrEwQ6KzGwT+9piANe0ynhTAwdjbnkzDSwHQQ/krPqYXK/1YJWL1NNyNip+DgcdHSCPiRCJ7ecPMtHUrEL8uNSBRyQQE7foSfrRDH89TTEKKANuhTcQS9jJgkFsqazLraqVOtqVPB76NT13xnG+JEH5B9/5+UWcLXDkfd5QANSRWTmThxfbTPTuQvNqz0k7yp3kskINBIPvdiXh0I2/zpiXWAkYYahCtBUlneCSOeiyPDXoLOsLhUbMwqz4n4M/oQbveYIebxKbJLGbG2Ker7Cje9tSgS0kEhUIkXV20x99YaYQipBVsRTSPD/L9oWgw5eXA0HmZ9Lea2zwllTr1h4dSZuwm58bOgq2ZSn2bhXvMoesTJeJOmfnFqHvDBPnFguuIAS5w185eXfm4LavWEivObrYoVQWED2p3el1eVAerrE4B5DU2XPEcIWGFHW71P+N0dYVh1xEFl0ICK3b6g8KtatrfqJpwtfoEYoEg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b92ca8b-ce84-4c17-66de-08d84f6b85eb
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 18:10:50.2035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5YqN1LvjqD8aFrw8yYWEJXJRwfBx00Z8bwk/yPpEQw1Cd+d1Zj0eNN9v/b3e/4OzlKWSauftlh8gtXLSnD0pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2637
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMC0wOS0wMiB1bSAyOjA4IHAubS4gc2NocmllYiBBbGV4IERldWNoZXI6Cj4gT24gV2Vk
LCBTZXAgMiwgMjAyMCBhdCAxOjAxIFBNIEFsZXggU2llcnJhIDxhbGV4LnNpZXJyYUBhbWQuY29t
PiB3cm90ZToKPj4gRW5hYmxlIG11bHRpLXJpbmcgaWgxIGFuZCBpaDIgZm9yIEFyY3R1cnVzIG9u
bHkuCj4+IEZvciBOYXZpMTAgZmFtaWx5IG11bHRpLXJpbmcgaGFzIGJlZW4gZGlzYWJsZWQuCj4+
IEFwcGFyZW50bHksIGhhdmluZyBtdWx0aS1yaW5nIGVuYWJsZWQgaW4gTmF2aSB3YXMgY2F1c2lu
Zwo+PiBjb250aW51cyBwYWdlIGZhdWx0IGludGVycnVwdHMuCj4+IEZ1cnRoZXIgaW52ZXN0aWdh
dGlvbiBpcyBuZWVkZWQgdG8gZ2V0IHRvIHRoZSByb290IGNhdXNlLgo+PiBSZWxhdGVkIGlzc3Vl
IGxpbms6Cj4+IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVz
LzEyNzkKPj4KPiBCZWZvcmUgY29tbWl0dGluZywgbGV0J3MgdmVyaWZ5IHRoYXQgaXQgZml4ZXMg
dGhhdCBpc3N1ZS4KCkhhcyBhbnlvbmUgcmVwcm9kdWNlZCB0aGlzIGluIEFNRD8gT3Igc2hvdWxk
IHdlIGFzayB0aGUgZ2l0bGFiIGlzc3VlCnJlcG9ydGVyIHRvIHRlc3QgdGhlIHBhdGNoPwoKVGhh
bmtzLArCoCBGZWxpeAoKCj4KPiBBbGV4Cj4KPgo+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IFNpZXJy
YSA8YWxleC5zaWVycmFAYW1kLmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9uYXZpMTBfaWguYyB8IDMwICsrKysrKysrKysrKysrKystLS0tLS0tLS0tCj4+ICAxIGZp
bGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9paC5jCj4+IGluZGV4IDM1MGYxYmYwNjNjNi4uNGQ3
Mzg2OTg3MGFiIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZp
MTBfaWguYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYwo+
PiBAQCAtMzA2LDcgKzMwNiw4IEBAIHN0YXRpYyBpbnQgbmF2aTEwX2loX2lycV9pbml0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQo+PiAgICAgICAgIH0gZWxzZSB7Cj4+ICAgICAgICAgICAg
ICAgICBXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX0NOVEwsIGloX3JiX2NudGwpOwo+
PiAgICAgICAgIH0KPj4gLSAgICAgICBuYXZpMTBfaWhfcmVyb3V0ZV9paChhZGV2KTsKPj4gKyAg
ICAgICBpZiAoYWRldi0+YXNpY190eXBlID09IENISVBfQVJDVFVSVVMpCj4+ICsgICAgICAgICAg
ICAgICBuYXZpMTBfaWhfcmVyb3V0ZV9paChhZGV2KTsKPj4KPj4gICAgICAgICBpZiAodW5saWtl
bHkoYWRldi0+ZmlybXdhcmUubG9hZF90eXBlID09IEFNREdQVV9GV19MT0FEX0RJUkVDVCkpIHsK
Pj4gICAgICAgICAgICAgICAgIGlmIChpaC0+dXNlX2J1c19hZGRyKSB7Cj4+IEBAIC02NjgsMTkg
KzY2OSwyNiBAQCBzdGF0aWMgaW50IG5hdmkxMF9paF9zd19pbml0KHZvaWQgKmhhbmRsZSkKPj4g
ICAgICAgICBhZGV2LT5pcnEuaWgudXNlX2Rvb3JiZWxsID0gdHJ1ZTsKPj4gICAgICAgICBhZGV2
LT5pcnEuaWguZG9vcmJlbGxfaW5kZXggPSBhZGV2LT5kb29yYmVsbF9pbmRleC5paCA8PCAxOwo+
Pgo+PiAtICAgICAgIHIgPSBhbWRncHVfaWhfcmluZ19pbml0KGFkZXYsICZhZGV2LT5pcnEuaWgx
LCBQQUdFX1NJWkUsIHRydWUpOwo+PiAtICAgICAgIGlmIChyKQo+PiAtICAgICAgICAgICAgICAg
cmV0dXJuIHI7Cj4+ICsgICAgICAgYWRldi0+aXJxLmloMS5yaW5nX3NpemUgPSAwOwo+PiArICAg
ICAgIGFkZXYtPmlycS5paDIucmluZ19zaXplID0gMDsKPj4KPj4gLSAgICAgICBhZGV2LT5pcnEu
aWgxLnVzZV9kb29yYmVsbCA9IHRydWU7Cj4+IC0gICAgICAgYWRldi0+aXJxLmloMS5kb29yYmVs
bF9pbmRleCA9IChhZGV2LT5kb29yYmVsbF9pbmRleC5paCArIDEpIDw8IDE7Cj4+ICsgICAgICAg
aWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX0FSQ1RVUlVTKSB7Cj4+ICsgICAgICAgICAgICAg
ICByID0gYW1kZ3B1X2loX3JpbmdfaW5pdChhZGV2LCAmYWRldi0+aXJxLmloMSwgUEFHRV9TSVpF
LCB0cnVlKTsKPj4gKyAgICAgICAgICAgICAgIGlmIChyKQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gcjsKPj4KPj4gLSAgICAgICByID0gYW1kZ3B1X2loX3JpbmdfaW5pdChhZGV2
LCAmYWRldi0+aXJxLmloMiwgUEFHRV9TSVpFLCB0cnVlKTsKPj4gLSAgICAgICBpZiAocikKPj4g
LSAgICAgICAgICAgICAgIHJldHVybiByOwo+PiArICAgICAgICAgICAgICAgYWRldi0+aXJxLmlo
MS51c2VfZG9vcmJlbGwgPSB0cnVlOwo+PiArICAgICAgICAgICAgICAgYWRldi0+aXJxLmloMS5k
b29yYmVsbF9pbmRleCA9Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAoYWRldi0+ZG9vcmJlbGxfaW5kZXguaWggKyAxKSA8PCAxOwo+PiArCj4+ICsgICAgICAgICAg
ICAgICByID0gYW1kZ3B1X2loX3JpbmdfaW5pdChhZGV2LCAmYWRldi0+aXJxLmloMiwgUEFHRV9T
SVpFLCB0cnVlKTsKPj4gKyAgICAgICAgICAgICAgIGlmIChyKQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gcjsKPj4KPj4gLSAgICAgICBhZGV2LT5pcnEuaWgyLnVzZV9kb29yYmVs
bCA9IHRydWU7Cj4+IC0gICAgICAgYWRldi0+aXJxLmloMi5kb29yYmVsbF9pbmRleCA9IChhZGV2
LT5kb29yYmVsbF9pbmRleC5paCArIDIpIDw8IDE7Cj4+ICsgICAgICAgICAgICAgICBhZGV2LT5p
cnEuaWgyLnVzZV9kb29yYmVsbCA9IHRydWU7Cj4+ICsgICAgICAgICAgICAgICBhZGV2LT5pcnEu
aWgyLmRvb3JiZWxsX2luZGV4ID0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIChhZGV2LT5kb29yYmVsbF9pbmRleC5paCArIDIpIDw8IDE7Cj4+ICsgICAgICAgfQo+
Pgo+PiAgICAgICAgIHIgPSBhbWRncHVfaXJxX2luaXQoYWRldik7Cj4+Cj4+IC0tCj4+IDIuMTcu
MQo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1n
ZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
