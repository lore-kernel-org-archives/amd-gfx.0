Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4D2C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 19:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74618204EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 19:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JYCcX+qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74618204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CDD06EA37;
	Fri, 22 May 2020 19:40:14 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690051.outbound.protection.outlook.com [40.107.69.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0D56EA37
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 19:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrNak9Qdm60cFSHuYoJygkzDmx3GA6S6iJf5rmnFCTK2ZlToGYg5IvG5N/2eenZHK2WaXNsYvFgvYU+mfmvYwfcXtgD769yzXSGMWdO5VhdpSOk7wmTXn5bwchAlxlIN7cjjIm+4oozqNCncvd5S/e28oIFyjsl0P80ukttDRY9q4tqiKMIv4LuqtAInDC1yHkI6kopkwU50i1PWpjTNpVCr3Oa/ThM0TyOB7J1E6yuP5xcCm5kNfO8v/H9e+hzTUpLJk/gWHhKhZvHzVG2wpu8Kn+rxv/ON7IFBf/Zj1yy61K6ezK52ew5tRxqNKdM7O5Bq5/90aVmAiivrakMpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQoKsjXHQttB0LrLx48J+sgBrMs3DfW1iGz9esKg/pQ=;
 b=kWIUp/KwYkIvjC5/EKgLnY1biEU6LbLqY0KiY3F41k/HO819H5h1aADhA4IEZNSkYTYqR/4z/r67+EJW9PT75iP12BlPIoliDUOnZXKs6Bd6/iPa4AtJ22XaJElO5hf9ngm+J50lFy2zlISVcYyDPEIVlLei8hQhSBk5J3yHg5leFuEfrZNImzQRH4G4IerKMNt7qai6cwODuvPynQIP7TQh0RtG62fHM8WpHRGloPZIeJFKBLHcxOa5VN9c0A2+VqITu0SQLAYQcf6Ld39rm6HGY/iCofHxzbjJv8OCmdW8i88vCLIcZVEMPrGb5LTTrGkT+fwmSdwix7bK6EwZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQoKsjXHQttB0LrLx48J+sgBrMs3DfW1iGz9esKg/pQ=;
 b=JYCcX+qz2BWab5oAmROkt5hAj7PM1Y7HBVcLlEhHD9NuCnkgFMs3zaMrptwNKse25GsaJfrJUB2bUCruba8R2l7SgRlV5cWId7B4OnKEFKxLfwF8dzqVRuVxdvOjtCkazxJPY/Dl7Narp8s+rn5S565TU5APNBNLEm1yC0NQrwo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2479.namprd12.prod.outlook.com (2603:10b6:802:29::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 22 May
 2020 19:40:08 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3000.034; Fri, 22 May 2020
 19:40:08 +0000
Subject: Re: drm/amdkfd: Change pasid's type to unsigned int
To: Fenghua Yu <fenghua.yu@intel.com>, Yong Zhao <Yong.Zhao@amd.com>
References: <20200522192554.GA39766@romley-ivt3.sc.intel.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <d6318005-4860-b82f-e2fc-21fa9f1c1683@amd.com>
Date: Fri, 22 May 2020 15:40:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200522192554.GA39766@romley-ivt3.sc.intel.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::14)
 To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YT1PR01CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24 via Frontend Transport; Fri, 22 May 2020 19:40:08 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a33da25-e32e-4207-8fb7-08d7fe87ef24
X-MS-TrafficTypeDiagnostic: SN1PR12MB2479:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24793DB01089443A0043C9D592B40@SN1PR12MB2479.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PoKa2YzyqXxw0P3NYwJlvWd4Jx9hkMjm8hBR8UtUeMH+aEA+poKrlrkDBYeyVx2mH5an+/qv781y42lzf0lkBe+GnK0YJc5+LSCTMLf18U44Zr5SBqJuT3SljYmM0AuUwvTgSNyhJ80Fu11shl9iB7XEy2zvSEqCyoTA05GOAWyR540qBwhsDjuWe+CiQFUWz9Tlzf0a7VdHiDV1sko9Ffq27lVsoXFKIqF2IUv8AculZqWrKRNx+1re2Da+bqJ60ih8f1aHLZsXHE+69seOGXFtzrhSyhQORVy7TGceJsQP+4s81UnVpkRO6zqlI498engUJJUTdH5LUtvyvLV3RsWZ9/x01BpAaomKv3cHX/pCtZxh5C9ho4C1v8O123RX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(44832011)(26005)(6486002)(31696002)(66946007)(86362001)(2906002)(52116002)(478600001)(66476007)(66556008)(2616005)(6636002)(4326008)(5660300002)(316002)(16576012)(36756003)(8676002)(110136005)(16526019)(956004)(8936002)(186003)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RCQ0O0FDg9IctY6hFhngC+7n+F7aSPPNrEU70E2dgWRb6trFrIAsxvbqRgk1geAfl9pgAHmPxB6hkFKg50RMPL6N9RMKJjps/uYcH1lC+gq+fRiS9LHz6SE8jQLShOvMqEqraOFocjvt976oal6POWanNTMkmCm31LJGhAT8Fw+UiFQD4qU+PyDrFbjpsBTfrBDYFD6Y2w4QBtZoxFMP7soAKbcHRtdj7d1SgDBcQV8QKTuUzus52E0JPI56hzC8R9Rc0MoIMIGt99gjLbWf3ITra1xYfiB9h73T2rNk+SmvHC3emyoWsJwQ1SKLHrEAhL4aSBhij7pobXNwZIcnP+CltKeZz9DF0LGjxsfzOoyxZTz0Fnq8PC1aTwnekB3qrm5YaL8EcqSUILJr1XZ8zuCD1emur5vq0DmojmxRAB/iVxIIVJEPbNr+4Nqr8UZ4DECV7sQcD73DIjhmN0sHTzU9Ot3Bfa9EqZJRwcok7Iotxy3RBM0GQzSl+NNrMr9Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a33da25-e32e-4207-8fb7-08d7fe87ef24
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 19:40:08.4544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVvSWpaUfNUlhbYBt7FCFsVHftJ8P9gBrHwEPaTrBDUsPU/0DFqYe7lUeQvsgtccCOdoBmnVtuy2TGfXfLK2Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2479
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgRmVuZ2h1YSwKClRoZSBQQVNJRCB3aWR0aCBpbiBLRkQgaXMgY3VycmVudGx5IGxpbWl0ZWQg
dG8gMTYgYml0cy4gSSBiZWxpZXZlIHRoaXMKcmVmbGVjdHMgd2hhdCBvdXIgaGFyZHdhcmUgY2Fu
IGhhbmRsZS4gS0ZEIHdpbGwgbmV2ZXIgYWxsb2NhdGUgYSBQQVNJRApiaWdnZXIgdGhhbiAxNiBi
aXRzLiBUaGF0IHNhaWQsIEknbSBPSyB3aXRoIGNoYW5naW5nIHRoaXMgZmllbGQgaW4gdGhlCmtm
ZF9wcm9jZXNzIHN0cnVjdHVyZSB0byB1bnNpZ25lZCBpbnQuIEdlbmVyYWxseSwgSSBmaW5kIHVp
bnQxNl90IGluCnN0cnVjdHVyZXMgbm90IHZlcnkgdXNlZnVsIGV4Y2VwdCBpbiB0aWdodGx5IHBh
Y2tlZCBzdHJ1Y3R1cmVzIHN1Y2ggYXMKcGFja2V0IGZvcm1hdHMgb3IgaW9jdGwgYXJndW1lbnRz
LgoKUmVnYXJkcywKwqAgRmVsaXgKCkFtIDIwMjAtMDUtMjIgdW0gMzoyNSBwLm0uIHNjaHJpZWIg
RmVuZ2h1YSBZdToKPiBIaSwgWW9uZywKPgo+IEluIGNvbW1pdDogNjAyN2IxYmY2MDcxZmM2MWE1
YWExMWI5OTIyYTJlMGU5MWJmZjFlYQo+ICAgICBkcm0vYW1ka2ZkOiBVc2UgaGV4IHByaW50IGZv
cm1hdCBmb3IgcGFzaWQKPgo+IHBhc2lkJ3MgdHlwZSB3YXMgY2hhbmdlIHRvICJ1aW50MTZfdCIg
ZnJvbSAidW5zaWduZWQgaW50IiBpbgo+IHN0cnVjdCBrZmRfcHJvY2Vzcy4KPgo+IEJ1dCwgcGFz
aWQgaXMgYSAyMC1iaXQgdmFsdWUgYWNjb3JkaW5nIHRvIFBDSWUgc3BlYyBhbmQgb3RoZXIgcGxh
Y2VzCj4gaW4gYW1ka2ZkIChwbHVzIG90aGVyIGlvbW11IGNvZGUpIGRlZmluZSBwYXNpZCBhcyAi
dW5zaWduZWQgaW50Ii4KPiBJZiBkZWZpbmVkIGFzIHVpbnQxNl90LCBwYXNpZCB3aWxsIG92ZXJm
bG93IGlmIGl0cyB2YWx1ZSBpcyBiaWdnZXIgdGhhbiAxNi1iaXQuCj4KPiBEaWQgSSBtaXNzIGFu
eXRoaW5nPyBTaG91bGQgd2UgY2hhbmdlIHBhc2lkJ3MgdHlwZSBiYWNrIHRvICJ1bnNpZ25lZCBp
bnQiPwo+Cj4gW2EgbGl0dGxlIGJhY2tncm91bmQ6IHBhc2lkIGlzIGRlZmluZWQgYXMgdmFyaW91
cyB0eXBlcyBpbmNsdWRpbmcgImludCIsCj4gInVuc2lnbmVkIGludCIsICJ1MzIiIGluIGlvbW11
LiBJJ20gY2hhbmdpbmcgcGFzaWQncyB0eXBlcyB0byAidW5zaWduZWQgaW50Igo+IHNvIHRoYXQg
dGhlIHR5cGVzIGFyZSBjb25zaXN0ZW50IGluIGlvbW11XQo+Cj4gVGhhbmtzLgo+Cj4gLUZlbmdo
dWEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
