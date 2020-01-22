Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F7DC2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 09:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F9D20704
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 09:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Nv0zTkfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F9D20704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15D5A6F42D;
	Wed, 22 Jan 2020 09:24:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C316F42D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 09:24:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KD5UxNQ2qD36n+5ap0Ui5ES1LAfnStgGnE9we7f0mHgTn8tIUbLmGxMIbxJTS5VB6KKPcQUkRInRPsQ106L3RwOIrEAxUONq/yKCOxJIleoIBiwPakbvcCdokZV9Z/U5+K3JAIZlDenLzU+TiUOIGHfJkIiJbrkgDvGXfJzNl3Q5q6fBPZyERuTIVkpIDl05pcU5u1jrjcJDnDD0+i7RvLMCqwQdY/L0Y2KDat6DPg/OpTgnCcuTVRZYBJkywtb2efUBDLRcOFB0xROmzHe/DPpz2IhMjTTO7d/zYwgti47QTnlS03xXDe5hL6GC6de+13POoqobOaRNmnTu56CQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDjDvgUSaWrYBGrW+GtrSEnrr1iDSyFag2A9TjiB7V0=;
 b=ibIZtwvkTcB6q5xGszn29IWiOmjyp6gi9ePPXR38yNtpR3S4LScjFC1/Riv2NSGKDrTPfATrS03pPToEjqMfJdQBskFTbMf4JajjaHWmeOws9IcuCxeHtfUw5qZ9XQvuhIZxflmWuj/PVQYX82Y31KfntWH8bJilwvFuJ2OJ+L8a6q+ymThRTXvIktP6hRALxuqFjGrAGJAq76bEojT6y/JWag3XOPQkFqASvziNTUyqcHm2Qkm3J6FAA4HBRkRIuwFakqMbZzcUo38GCCEKaVC7+b8o66foiCR3+sdpQfDQjEaUpGZ3xuM6j6KUyUdpEHw+NLdP9O02igZRzia1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDjDvgUSaWrYBGrW+GtrSEnrr1iDSyFag2A9TjiB7V0=;
 b=Nv0zTkfxtSrgg4zGsuzu4eDmu5Q6XCvb/4n6WrBA4wFQwrAC0ct27KR8TCjenUrFjGPuREr9Re7UAxMc6wHQB0jfdIAfHEfC8+z3k8sLGTe2J+2sMYEs6wOA6YasjjiycojCeWvimomyGV+F6+9nH1VawhWA2Agbs0pPtIaVwvU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1449.namprd12.prod.outlook.com (10.172.40.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Wed, 22 Jan 2020 09:24:22 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3%6]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 09:24:22 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: allocate entities on demand
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200121165002.3709-1-nirmoy.das@amd.com>
 <20200121165002.3709-2-nirmoy.das@amd.com>
 <50c72f0a-bc2d-3467-0312-edb0bb858fb4@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <d3a300b7-1516-b332-0e60-6acb36100a29@amd.com>
Date: Wed, 22 Jan 2020 10:25:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <50c72f0a-bc2d-3467-0312-edb0bb858fb4@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0101CA0057.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::25) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f29:5700:a0f:1fdb:bc5b:14d8]
 (2003:c5:8f29:5700:a0f:1fdb:bc5b:14d8) by
 AM4PR0101CA0057.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Wed, 22 Jan 2020 09:24:21 +0000
X-Originating-IP: [2003:c5:8f29:5700:a0f:1fdb:bc5b:14d8]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: db486b5b-ec9e-4012-1400-08d79f1cdda8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:|DM5PR12MB1449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1449F0631DEDB5932164930C8B0C0@DM5PR12MB1449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(189003)(199004)(31696002)(186003)(2616005)(8936002)(6486002)(478600001)(16526019)(8676002)(81156014)(81166006)(5660300002)(36756003)(4326008)(6666004)(66476007)(2906002)(31686004)(316002)(66556008)(66946007)(52116002)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1449;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0NaHACLuhBGvuR+qJId7dSw4uRnOkqJlWdKZ1tVcw/PDXTEnZrKfJnlO8pxgDEicPcCGi34+i44B16lzQnChuxC0XhwVTlkd5kjB4hiTs6Fe2MSBSQvJFDwEyWf367tCrcHS3rwY9r8wCwtyied6Wd/0H6FwUBsInXJXuVhK0CpARw1LYJBbJYf+W2Y6vLkRer5Zyilqm1f4KJuH37kUvxeSDwgmNE7p9YzMGdC3o/QK6enR/dMKdAyWkV6R4+Npce52fMTpr3BAjqgGxAkJZP0WbII3HnlrZIR+pWWFz8hTbXXJ6C8JuznMbU984zYZtzWBbgyH9cDaQbmL83Suuvp0WHhYLp4wsfAi3RVOYSoolClPPY3KRGU8KUhXUkKnap7Zcaj8QfzXlYQOSkwuCXYk4cGwYP1iV2U7q5x0Zvce+c1Ctp0Pk0HYlfADYYf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db486b5b-ec9e-4012-1400-08d79f1cdda8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 09:24:22.5263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiWQp9Y6QfqOg4DTxFwZBvUUCeQeXQb4tFpznPJ3/EtuBB+qvkVoVwBqKElVTH02efxQCTuIl7SIaHOIbwDTbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgTHViZW4sCgpUaGFua3MgZm9yIHJldmlld2luZy7CoCBXYXMgZXhwZWN0aW5nIGxvdCBmcm9t
IHZpbSBhdXRvLWluZGVudCA6LwoKT24gMS8yMi8yMCAxOjA3IEFNLCBMdWJlbiBUdWlrb3Ygd3Jv
dGU6Cj4gT24gMjAyMC0wMS0yMSAxMTo1MCBhLm0uLCBOaXJtb3kgRGFzIHdyb3RlOgo+Cj4+IC0J
CXN3aXRjaCAoaSkgewo+PiArCXByaW9yaXR5ID0gKGN0eC0+b3ZlcnJpZGVfcHJpb3JpdHkgPT0g
RFJNX1NDSEVEX1BSSU9SSVRZX1VOU0VUKSA/Cj4+ICsJCQkJY3R4LT5pbml0X3ByaW9yaXR5IDog
Y3R4LT5vdmVycmlkZV9wcmlvcml0eTsKPiBZb3UgZG9uJ3QgbmVlZCBwYXJlbnRoZXNpcyBhcm91
bmQgdGhlIHJlbGF0aW9uYWwgZXF1YWxpdHkgb3BlcmF0b3IgdXNlZCBoZXJlLgo+IEl0IGhhcyBo
aWdoZXIgcHJlY2VkZW5jZSB0aGFuIHRoZSB0ZXJuYXJ5IGNvbmRpdGlvbmFsLCBpbiB3aGljaCBp
dCBpcyBlbWJlZGRlZC4KClBhcmVudGhlc2lzIG1ha2VzIGl0IG1vcmUgaHVtYW4gcmVhZGFibGUu
CgoKPj4gKwlpbnQgcjsKPj4gKwo+PiArCWlmIChwcmlvcml0eSA8IDAgfHwgcHJpb3JpdHkgPj0g
RFJNX1NDSEVEX1BSSU9SSVRZX01BWCkKPj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4gVGhpcyBzaG91
bGRuJ3QgYmUgcG9zc2libGUgc2luY2UgaXQgaXMgYW4gZW51bS4uLgpXaGF0IHNob3VsZCBub3Qg
YmUgcG9zc2libGUgPwo+IEJ1dCB3aHkgbm90IGRvIHRoaXMgY2hlY2sgaW4gImFtZGdwdV9jdHhf
cHJpb3JpdHlfcGVybWl0KCkiCj4gd2hpY2ggaXMgaW50cm9kdWNlZCBieSB0aGlzIHBhdGNoc2V0
IGFuZCB1c2VkIGluIHRoZSBpbWVkaWF0ZWx5Cj4gZm9sbG93aW5nIGxpbmU/Ck1ha2VzIHNlbnNl
Lgo+Cj4gT3IgcGVyaGFwcyBmaXggdXAgYW1kZ3B1X3RvX3NjaGVkX3ByaW9yaXR5KCkgd2hlcmUg
aXQgaXMgbWFzc2FnZWQKPiBmcm9tIHRoZSBpb2N0bCBhcmd1bWVudCB3aGljaCBpcyBhbiBpbnRl
Z2VyLgo+Cj4gT24gYSBzaWRlIG5vdGU6IEkgbm90aWNlZCB0aGF0IHRoZSBlbnVtIGRybV9zY2hl
ZF9wcmlvcml0eQo+IGhhcyBubyBEUk1fU0NIRURfUFJJT1JJVFlfTk9ORS4KPgo+IEkndmUgZm91
bmQgdmFsdWUgaW4gc2V0dGluZyB0aGUgZmlyc3QgdmFsdWUgb2YgYW4gZW51bSB0bwo+ICJfTk9O
RSIgKHVubGVzcyB6ZXJvIGFjdHVhbGx5IGhhcyBhIG1lYW5pbmcgYXMgc2V0IGJ5IEhXL2V0Yy4s
IGFueXdheSkuCj4gRW51bSBkcm1fc2NoZWRfcHJpb3JpdHkgc3RhcnRzIHdpdGggIl9NSU4iIGFu
ZCAiX0xPVyIgd2hpY2gKPiBhcmUgYm90aCBzZXQgdG8gdGhlIHNhbWUgKHplcm8pIHZhbHVlLgo+
Cj4gU28gaGF2aW5nIERSTV9TQ0hFRF9QUklPUklUWV9OT05FLCBjb3VsZCBiZSB1c2VkIHRvIGRl
bm90ZQo+IHRoYXQgbm8gcHJpb3JpdHkgd2FzIGdpdmVuIGFuZCBhbnkgaXMgZmluZSwgb3IgdG8g
bWVhbgo+IHRoYXQgaWYgdGhlIHByaW9yaXR5IHdhcyBnaXZlbiBvdXQgb2YgcmFuZ2UsIHNldCBp
dCB0byAibm9uZSIsCj4gdG8gbWVhbiBwaWNrIGFueS4KCk5vdCBzdXJlIGFib3V0IGlmIEhXIGFj
Y2VwdHMgMC4KCgpSZWdhcmRzLAoKTmlybW95CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
