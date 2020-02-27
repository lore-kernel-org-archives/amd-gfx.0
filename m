Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ABAC4BA24
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 11:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7A924672
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 11:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kLlg8wmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7A924672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DC176EC92;
	Thu, 27 Feb 2020 11:35:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E3C6E857
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 11:35:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/KKqzJhEthxgqYxCvlNujEvyZB/9pWCKqpJuVd8hxS4TjKztXhxlUQBI/Y0LesPlvTrDltanC9a1ZRlnKE6gUGudJ7UU3NS+4GvQokWLOlPABlbAWyZkJUNSs2OWEg+EMVePChrGI4yrVFVQTlfDoOY91lvSM/XAW525Pf16JMY7sqRKU6sHq5UiC5kAycut/xVG2RHlWUX1CwXydneFVi+EjI1euE4Vk2nlhlDCP2GF+uz8gWal64Bh3YOZp0K45iwccDU5Oogrs59syemm5EXdw9xJ7i8L6oStwMWaspnH6bCSD/R+Fg8K5nAaat3vyQ0GIHnnGOO6U/NWBZAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QKIyqRIIkNim6mBZTDitp1hymfGcVuesH7qxpBSiMk=;
 b=TyPR29v7NlE5KVCd75JA8ICnrUMpV6Aah30Nz2DLOKfTS/RjfiLgmEEFqsfzSNg/Cp6rrtfij1nZM3JLnNQjt6zgME2yK5o6CElW/yaPMeXYX/L2DHryuq0gW3hQCwPxD+I6IGkpgutL52LJQwp3x/2AyfQd9w9HCgF31kjyAMLU3rjyNF0T4HYGhEOJziDPuTHKzTsXG2tzXO2jE+CA59O0h8z2xfBJ7xgp5OoMBAmrceMp0qS11BxqR1ioOvVDnCAe8yO4eD8m4VubT6KM3BlptE6pC5grskxubNa/NRSTuFGnvgF9PM+IbHbnNXyiFKlsiC4/Ph/HriZyB9zKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QKIyqRIIkNim6mBZTDitp1hymfGcVuesH7qxpBSiMk=;
 b=kLlg8wmStWnR3YWFgIonYT7+LIN0Qmw18YigZQJDue/0FqvGP5ciVPntYZAAgr5RnJrz3aA7pTVPwpHvpmE2hwkubKp77zHGf60UYE3dN//r0+99wmdEnO+plA2jDYXKc0y2Itq0QNui35DqxBCcqzhJAAslcPq4JNcgPrTgPeU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1177.namprd12.prod.outlook.com (2603:10b6:3:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 11:35:44 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2750.021; Thu, 27 Feb
 2020 11:35:43 +0000
Subject: Re: [RFC PATCH 2/3] drm/amdgpu: change hw sched list on ctx priority
 override
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200226203730.4621-1-nirmoy.das@amd.com>
 <20200226203730.4621-3-nirmoy.das@amd.com>
 <2c8957cf-f4b5-2b65-acb6-d366c2fbc656@amd.com>
 <112d864d-f182-9bd1-7c07-44f9d7034b77@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <72ccc4ee-8c37-a756-f23f-a45f637c07a5@amd.com>
Date: Thu, 27 Feb 2020 12:35:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <112d864d-f182-9bd1-7c07-44f9d7034b77@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR04CA0139.eurprd04.prod.outlook.com (2603:10a6:207::23)
 To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR04CA0139.eurprd04.prod.outlook.com (2603:10a6:207::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Thu, 27 Feb 2020 11:35:42 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb21ba2d-2367-4b49-e812-08d7bb792e24
X-MS-TrafficTypeDiagnostic: DM5PR12MB1177:|DM5PR12MB1177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11777943D785F334832281E883EB0@DM5PR12MB1177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(189003)(199004)(16526019)(2616005)(81166006)(53546011)(36756003)(52116002)(4326008)(5660300002)(31686004)(81156014)(86362001)(6666004)(8936002)(8676002)(186003)(316002)(2906002)(6486002)(478600001)(66946007)(31696002)(66556008)(110136005)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1177;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfJMNb7cCYnQTkw3N2/ELBNcbA1kYcczfjMUW9E8EnaA8Es/3WyEdfOTvRDFUZQ3UCI8ClSM+HNptAjJ3+b7L29GA47Nj/VWIsOR3SZVS/pBjJRbQAHpK20cYtielbGat+o54bG7cL8OkQLBaeZngNxiI8lZk3HETGkHKScjHQA4HiTaF/edzNrPtwFsYl2ioo2O4t9wZkxf2W0rUWDjNz/YjW1TGlr1DHv+egYFKLFZTCcK5uXsM0PhO/tB3Db/sqZ1kBlmWYIjEFM0t/jasOwbAaEJ+QAevKcxvwz0YI1mG6Ho+NQi2HYSgVq/90Y3JBcd4VftwmULXrkpzxxlVpuRJeSeaxXwE/E96mqrZpEceIpv/Ife0WjbWxz8th+s5vQOaL3MJ1oXsvfwuC6Ce2rK0EQLKzh4IJv83oJ+6ZX2DkmivaGZnI7VJBY6dv3u
X-MS-Exchange-AntiSpam-MessageData: I7qUUjYWxX/8Vmc4uaO8uCao/qkDGAGeawnTGZYFOM2ECCFiWTzLJoD88IjJCJFg6TIgyjgnnuTmvtbmtjCEsC49hHCZLBdP+2TrAvcvmPrEcJiYR3CGkalB7jzIw54TL+wE2i2HWIW8H9+RT+Qrpj67YqTEN40tErSTdqRtwkUxYpCBn8ZwZvVhacMOLLeFDUUJYuykomPc7qmha/O/Cg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb21ba2d-2367-4b49-e812-08d7bb792e24
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 11:35:43.8430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8XyeMQqA/eAGjn48hD6eKRPQvSJuxe45bmrlcAyL01CY7Fx+9fdWl7Mc1brRT9B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1177
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjcuMDIuMjAgdW0gMTE6MjYgc2NocmllYiBOaXJtb3k6Cj4KPiBPbiAyLzI3LzIwIDExOjA4
IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc2NoZWRzID0gYWRldi0+c2RtYS5zZG1hX3NjaGVkOwo+Pj4gQEAgLTUwMiw2ICs1MDcs
MjQgQEAgc3RydWN0IGRtYV9mZW5jZSAqYW1kZ3B1X2N0eF9nZXRfZmVuY2Uoc3RydWN0IAo+Pj4g
YW1kZ3B1X2N0eCAqY3R4LAo+Pj4gwqDCoMKgwqDCoCByZXR1cm4gZmVuY2U7Cj4+PiDCoCB9Cj4+
PiDCoCArc3RhdGljIHZvaWQgYW1kZ3B1X2N0eF9od19wcmlvcml0eV9vdmVycmlkZShzdHJ1Y3Qg
YW1kZ3B1X2N0eCAqY3R4LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY29uc3QgdTMyIGh3X2lwLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW51bSBkcm1fc2NoZWRfcHJpb3JpdHkgcHJpb3JpdHkp
Cj4+PiArewo+Pj4gK8KgwqDCoCBpbnQgaTsKPj4+ICsKPj4+ICvCoMKgwqAgZm9yIChpID0gMDsg
aSA8IGFtZGdwdV9jdHhfbnVtX2VudGl0aWVzW2h3X2lwXTsgKytpKSB7Cj4+PiArwqDCoMKgwqDC
oMKgwqAgaWYgKCFjdHgtPmVudGl0aWVzW2h3X2lwXVtpXSkKPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNvbnRpbnVlOwo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qIFRPRE8gd2hhdCBo
YXBwZW5zIHdpdGggcHJldiBzY2hlZHVsZWQgam9icyAqLwo+Pgo+PiBJZiB3ZSBkbyBpdCByaWdo
dCwgdGhhdCBzaG91bGQgYmUgdW5wcm9ibGVtYXRpYy4KPj4KPj4gVGhlIGVudGl0eSBjaGFuZ2Vz
IHRoZSBycS9zY2hlZHVsZXIgaXQgc3VibWl0cyBzdHVmZiB0byBvbmx5IHdoZW4gaXQgCj4+IGlz
IGlkbGUsIGUuZy4gbm8gam9icyBvbiB0aGUgaGFyZHdhcmUgbm9yIHNvZnR3YXJlIHF1ZXVlLgo+
Pgo+PiBTbyBjaGFuZ2luZyB0aGUgcHJpb3JpdHkgd2hlbiB0aGVyZSBpcyBzdGlsbCB3b3JrIHNo
b3VsZCBiZSBvayAKPj4gYmVjYXVzZSBpdCB3b24ndCB0YWtlIGVmZmVjdCB1bnRpbCB0aGUgZW50
aXR5IGlzIGlkbGUuCj4gVGhhbmtzIGNsYXJpZnlpbmcgdGhhdC4KPj4KPj4gQ2FuIG9mIGNvdXJz
ZSBiZSB0aGF0IHVzZXJzcGFjZSB0aGVuIHdvbmRlcnMgd2h5IHRoZSBuZXcgcHJpb3JpdHkgCj4+
IGRvZXNuJ3QgdGFrZSBlZmZlY3QuIEJ1dCB3aGVuIHlvdSBzaG9vdCB5b3Vyc2VsZiBpbnRvIHRo
ZSBmb290IGl0IGlzIAo+PiBzdXBwb3NlZCB0byBodXJ0LCBkb2Vzbid0IGl0Pwo+IMKgOkQKPj4K
Pj4+ICsgZHJtX3NjaGVkX2VudGl0eV9kZXN0cm95KCZjdHgtPmVudGl0aWVzW2h3X2lwXVtpXS0+
ZW50aXR5KTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBhbWRncHVfY3R4X2ZpbmlfZW50aXR5KGN0eC0+
ZW50aXRpZXNbaHdfaXBdW2ldKTsKPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoCBhbWRncHVfY3R4
X2luaXRfZW50aXR5KGN0eCwgQU1ER1BVX0hXX0lQX0NPTVBVVEUsIGkpOwo+Pgo+PiBXZWxsLCB0
aGF0IGlzIG1vc3QgbGlrZWx5IE5PVCB0aGUgcmlnaHQgd2F5IG9mIGRvaW5nIGl0IDopIERlc3Ry
b3lpbmcgCj4+IHRoZSBlbnRpdHkgd2l0aCBmaW5pIGFuZCByZWluaXQgbWlnaHQgY2F1c2UgcXVp
dGUgYSBidW5jaCBvZiBwcm9ibGVtcy4KPj4KPj4gQ291bGQgYmUgdGhhdCB0aGlzIHdvcmtzIGFz
IHdlbGwsIGJ1dCBJIHdvdWxkIHJhdGhlciBqdXN0IGFzc2lnbiAKPj4gc2NoZWRfbGlzdCBhbmQg
bnVtX3NjaGVkX2xpc3QuCj4KPiBIb3cgYWJvdXQgZG9pbmcgdGhhdCB3aXRoIGEgbmV3IGZ1bmN0
aW9uIGxpa2UgCj4gZHJtX3NjaGVkX2VudGl0eV9tb2RpZnlfc2NoZWQoKSA/CgpZZXMsIHNvdW5k
cyBsaWtlIHRoZSBzYW5lc3QgdGhpbmcgdG8gYXMgd2VsbC4KCkNocmlzdGlhbi4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
