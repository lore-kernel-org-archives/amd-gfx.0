Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BBCC43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 15:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08656206F6
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 15:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d0yiakBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08656206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B01DB6E0AC;
	Wed,  1 Apr 2020 15:02:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E38F6E0AC
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 15:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOaaJQFIBgadsHvSZ2332vhvmJFI+5ANNBzKft/6LD7j96vBIZ8Sc2oO3aC73Ehp/gucBpWnDMvTK4adNDv0a3ly4VppdP8Q1ot0eaNmXg3f43PZ2GxyUejQbjbZYK0LDgMb2a2sfCMwzkq1h0bEpuecgSFs530wsqsnKgn9D6821GikGl/Mg12O5LLkxu442uB1mbjiLtzOLW1/n0Z7E8+676DISehOWSEpUCwtNg64+XrCyzPbzFnD4g04RaSjHspTlgbYnAanOecAxnE6CGefaeD24c64RHQnCQ/fwJGiRHQkk7wDml7rkVsXXa5lOBO3GH+stJhV3MFd2/DSTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRs2FvChMq+F2RvehfsDIJgpgCYs5g9H1RcySxHpBPs=;
 b=BdUxWcFoXwP+y1lOrN4UrPPfChAEMjvW8GPLWItdSrE0oMDPmz8B91KkLJ9l+WW7GVLXg6G4i6+kqWQNOR+HpFufrePwF768Wt1JAGH43r9UW/vJxSyiLrBWW9JSaFpW+6y9mK8TjEau9QR6SHqgC1Jrack7IFMmr2KOYw4GgO6QOhLU6haLbcKVzY2jcwnPivTaJ6lbhr1VPJXp+G/nCSHCK5Wz/5j4oJYuqdm/ipcXKbJZg0/RB1FYzikPWAwiNnoMad2XdsyU9G+oDdtljwx5ib8gZAlmZ4k6aIa6K4vKm6NVP5uNC0FybpWArkMgD/v9k/QKrwzo3IFqVUC4mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRs2FvChMq+F2RvehfsDIJgpgCYs5g9H1RcySxHpBPs=;
 b=d0yiakBFjXMO0jrG+N8d7f66OtOmv0+qBApWMxQeqI4rPvr9I3Qv1YWkSvcuIqOxQoq7MEqKg6lWESbdcKkcUJHNiUWRjyWX9clSp5/4MV9OGJG4vzX+2Kx4Hl4rPhL+8SjSI0GBGeiGxWL5fr1ESalP+1wXbmGhaB0lCg7x1Eo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Wed, 1 Apr
 2020 15:02:38 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 15:02:38 +0000
Subject: Re: [PATCH v3 1/1] drm/amdgpu: rework sched_list generation
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200330154909.51100-1-nirmoy.das@amd.com>
 <7ee60b3e-5c8b-9af3-499b-f2326c97da7d@amd.com>
 <63c075f4-dd81-6344-6eab-0545941028de@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <94cc257b-641a-44fa-21e1-28bba2e0854b@amd.com>
Date: Wed, 1 Apr 2020 11:02:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <63c075f4-dd81-6344-6eab-0545941028de@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::42) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.7] (108.162.131.176) by
 YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 15:02:37 +0000
X-Originating-IP: [108.162.131.176]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5d83f31-a320-4ab0-db6b-08d7d64db804
X-MS-TrafficTypeDiagnostic: DM6PR12MB4420:|DM6PR12MB4420:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4420AC4C83C4860E80F0969299C90@DM6PR12MB4420.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(86362001)(53546011)(52116002)(55236004)(31686004)(478600001)(316002)(6486002)(110136005)(16576012)(31696002)(36756003)(66946007)(66476007)(66556008)(4326008)(44832011)(26005)(956004)(2616005)(16526019)(81166006)(8676002)(8936002)(81156014)(186003)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QyvxjfJvDtfuraCvfa4zsBc73rB/JGCQ5hh2kh7G+1O8bf4giJBdN3rfSa1nTjFiP33WzGRDLtDt//RRBXyhK5DUlX2T10Dn5yORyn0B9QJFfdAKN1m/eIkZbcqk/GirHFQoAQYtZVdTX7eefyk55AuWxbpafI4z6HEFBURr77gfM+C94iCxljBjIRhDUTkYGoGRgxvxdeuiRFzNIqCpwsVyxoh3cjimgfP8joHxbJhcURfSsjbkdbfQtAFTp6SWBSxVdJv7ZnX+EVy09+YH8i7MWF7LNpw8bNSSO5hE24/ujdyFZvPWoJhaSRs/ZLdwiFXqQ7jZ3B2CKjw06Y6wYo61Y6h8v6Vf71hTTxQPQPVgdqZQDoKBfHjpWZnxZUxk3xhn+TtnyOFLS53ti9woAsAMsw1FGiRwyQRtwVUeO0ZiwGicVYpx0mgoD2PeLrF2
X-MS-Exchange-AntiSpam-MessageData: w1nXiTYojtcvf0uixcuRl4RYHahX95Uui0hB2KIHOIZwD3Ai6ePeTL5Q2zes3Kgq+UwXeBYrTmEBZle/O1ahX9qKQbWYTdF2oxjqVZnowxHqKHqJqNjfp4v0UFvGX25nguy+LqLJaCn3eeHkoYLhQQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d83f31-a320-4ab0-db6b-08d7d64db804
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 15:02:38.7624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l07eZ2XgLa53Ry+A27pNjgsUt4jHPWu2wsw9OBbDUJZSRbfUSvP8BuuToyOI0oFh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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
Cc: alexander.deucher@amd.com, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 ray.huang@amd.com, nirmoy.das@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMy0zMSAwODo0NiwgTmlybW95IHdyb3RlOgo+IAo+IE9uIDMvMzEvMjAgMzowMSBB
TSwgTHViZW4gVHVpa292IHdyb3RlOgo+PiBUaGlzIHBhdGNoIHNlZW1zIHRvIGJlIHVzaW5nIERP
UyBsaW5lLWVuZGluZ3MuCj4gCj4gCj4gU3RyYW5nZSwgSSBkb24ndCBzZWUgdGhhdCBpbiBteSBs
b2NhbCBwYXRjaCBmaWxlLgo+IAoKTm90IHN1cmUgd2h5ICJnaXQgYW0iIGNvbXBsYWluZWQgYWJv
dXQgRE9TIGVuZGluZ3MKdGhlIGZpcnN0IHRpbWUgSSBkb3dubG9hZGVkIGl0LiBTZWNvbmQgdGlt
ZSB3YXMgZmluZS4KCltzbmlwXT4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAo+Pj4g
aW5kZXggMjlmMGE0MTAwOTFiLi4yN2FiYmRjNjAzZGQgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1LmgKPj4+IEBAIC03MjEsNiArNzIxLDExIEBAIHN0cnVjdCBhbWRfcG93
ZXJwbGF5IHsKPj4+ICAgCWNvbnN0IHN0cnVjdCBhbWRfcG1fZnVuY3MgKnBwX2Z1bmNzOwo+Pj4g
ICB9Owo+Pj4KPj4+ICtzdHJ1Y3QgYW1kZ3B1X3NjaGVkIHsKPj4+ICsJdWludDMyX3QJCQludW1f
c2NoZWRzOwo+Pj4gKwlzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIJKnNjaGVkW0hXSVBfTUFYX0lO
U1RBTkNFXTsKPj4+ICt9Owo+Pj4gKwo+Pj4gICAjZGVmaW5lIEFNREdQVV9SRVNFVF9NQUdJQ19O
VU0gNjQKPj4+ICAgI2RlZmluZSBBTURHUFVfTUFYX0RGX1BFUkZNT05TIDQKPj4+ICAgc3RydWN0
IGFtZGdwdV9kZXZpY2Ugewo+Pj4gQEAgLTg1OCw2ICs4NjMsOCBAQCBzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSB7Cj4+PiAgIAlzdHJ1Y3QgYW1kZ3B1X3JpbmcJCSpyaW5nc1tBTURHUFVfTUFYX1JJTkdT
XTsKPj4+ICAgCWJvb2wJCQkJaWJfcG9vbF9yZWFkeTsKPj4+ICAgCXN0cnVjdCBhbWRncHVfc2Ff
bWFuYWdlcglyaW5nX3RtcF9ib1tBTURHUFVfSUJfUE9PTF9NQVhdOwo+Pj4gKwkvKiBkcm0gc2No
ZWR1bGVyIGxpc3QgKi8KPj4+ICsJc3RydWN0IGFtZGdwdV9zY2hlZAkJZ3B1X3NjaGVkW0FNREdQ
VV9IV19JUF9OVU1dW0FNREdQVV9SSU5HX1BSSU9fTUFYXTsKPj4gVGhhdCdzIGEgMi1kaW1lbnNp
b25hbCBhcnJheSBvZiAic3RydWN0IGFtZGdwdV9zY2hlZCIuCj4+IEkgdGhpbmsgdGhhdCB0aGUg
Y29tbWVudCBzaG91bGQgYmUgcmVtb3ZlZCwgb3IgYXQgbGVhc3QKPj4gbm90IHNheSAiZHJtIHNj
aGVkdWxlciBsaXN0Ii4gKEkgY2FuIHNlZSB0aGUgc3RydWN0dXJlCj4+IGRlZmluaXRpb24gYWJv
dmUuKQo+IAo+IAo+IFllcyBJIHNob3VsZCByZW1vdmUgaXQuCj4gCj4gCj4+IElmIHRoaXMgaXMg
dGhlIHBhdGggeW91IHdhbnQgdG8gZ28sIGNvbnNpZGVyIHJlbW92aW5nCj4+ICJudW1fc2NoZWRz
IiBhbmQgY3JlYXRpbmcgYSB0aHJlZSBkaW1lbnNpb25hbCBhcnJheSwKPj4gd2hpY2ggd291bGQg
cmVhbGx5IGVzc2VudGlhbGl6ZSB0aGUgZGlyZWN0aW9uIHlvdSB3YW50Cj4+IHRvIGdvOgo+Pgo+
PiBzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKmdwdV9zY2hlZFtBTURHUFVfSFdfSVBfTlVNXVtB
TURHUFVfUklOR19QUklPX01BWF1bSFdJUF9NQVhfSU5TVEFOQ0VdOwo+Pgo+PiBOb3cgdGhhdCB0
aGlzIGFyY2hpdGVjdHVyZSBpcyBzdHJpcHBlZCBkb3duIHRvIGl0cyBlc3NlbnRpYWxzLAo+PiBw
ZXJoYXBzIHdlIGNhbiBzZWUgc29tZSBvcHRpbWl6YXRpb25zLi4uPwo+IAo+IAo+IElmIHlvdSBt
ZWFuIHdoZXRoZXIgd2Ugc2hvdWxkIHNlZSBhbnkgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgdGhl
biBpbW8gCj4gd2UgbWF5IG5vdCBzZWUgbXVjaAo+IAo+IGRpZmZlcmVuY2UgYXMgd2UgYXJlIHVz
aW5nIHByZXR0eSBtdWNoIHNhbWUgbnVtYmVyIG9mIG1lbW9yeSBhY2Nlc3MgcGx1cyAKPiBub3cg
d2UgaGF2ZSBleHRyYSBjb3N0IG9mIGFycmF5X2luZGV4X25vc3BlYygpLgo+IAo+IEFsc28gdGhp
cyBpc8KgIG5vdCBob3QgY29kZSBwYXRoLiBXZSBkbyBvbmx5IDEgCj4gYW1kZ3B1X2N0eF9pbml0
X2VudGl0eSgpL0hXX0lQL0NvbnRleHQuCgpObywgdGhpcyBoYXMgbm90aGluZyB0byBkbyB3aXRo
ICJwZXJmb3JtYW5jZSIuCkl0J3MgYWxsIGFib3V0IGFyY2hpdGVjdHVyZSBhbmQgZGVzaWduLgoK
WW91IHNlZW0gdG8gaGF2ZSBhcnJheS1hcnJheS1zdHJ1Y3Qgd2l0aCBhcnJheSBhbmQgaW50LAph
bmQgaXQgc2VlbXMgbXVjaCBjbGVhbmVyIHRvIGp1c3QgaGF2ZSBhcnJheS1hcnJheS1hcnJheS4K
SSB0aGluayB5b3UgZG9uJ3QgbmVlZCB0byBicmVhayB0aGUgY2hhaW4gd2l0aApzdHJ1Y3Qgb2Yg
aW50IGFuZCBhcnJheSwganVzdCBhcyBJIGRlc2NyaWJlZAppbiBteSBjb21tZW50IGJlbG93IHdo
aWNoIHlvdSBzbmlwcGVkIHdpdGhvdXQgYWRkcmVzc2luZyBpdC4KCklmIHlvdSdyZSBub3QgZ29p
bmcgdG8gYWRkcmVzcyBhIGNvbW1lbnQsIGRvbid0IGRlbGV0ZSBpdCwgbGVhdmUgaXQKZm9yIG90
aGVycyB0byBzZWUgdGhhdCBpdCBoYXNuJ3QgYmVlbiBhZGRyZXNzZWQuIE9ubHkKc25pcCBwcmV2
aW91c2x5IGFkZHJlc3NlZCBhbmQgcmVzb2x2ZWQgY29tbWVudHMgYW5kIHByZXZpb3VzbHkKc2Vl
biBwYXRjaCBpbmZvLCBsaWtlIGRpZmZzdGF0L2V0Yy4KCj4+IEFsc28gY29uc2lkZXIgdGhhdCBz
aW5jZSB5b3UncmUgY3JlYXRpbmcgYW4gYXJyYXkgb2YgcG9pbnRlcnMsCj4+IHlvdSBkb24ndCBu
ZWNlc3NhcmlseSBuZWVkIHRvIGtub3cgdGhlaXIgY291bnQuIFlvdXIgaG90LXBhdGgKPj4gYWxn
b3JpdGhtcyBzaG91bGQgbm90IG5lZWQgdG8ga25vdyBpdC4gSWYgeW91IG5lZWQgdG8gcHJpbnQK
Pj4gdGhlaXIgY291bnQsIHNheSBpbiBzeXNmcywgdGhlbiB5b3UgY2FuIGNvdW50IHRoZW0gdXAg
b24KPj4gYmVoYWxmIG9mIHRoZSB1c2VyLXNwYWNlIHByb2Nlc3MgY2F0LWluZyB0aGUgc3lzZnMg
ZW50cnkuCj4+Cgpbc25pcF0KCj4+PiArCj4+PiArCS8qIHNldCB0byBkZWZhdWx0IHByaW8gaWYg
c2NoZWRfbGlzdCBpcyBOVUxMICovCj4+PiArCWlmICghYWRldi0+Z3B1X3NjaGVkW2h3X2lwXVto
d19wcmlvXS5udW1fc2NoZWRzKQo+Pj4gKwkJaHdfcHJpbyA9IEFNREdQVV9SSU5HX1BSSU9fREVG
QVVMVDsKPj4gVGhhdCBjb21tZW50IGlzIGEgYml0IGNvbmZ1c2luZy0taXQgdGFsa3MgYWJvdXQg
YSBsaXN0Cj4+IG5vdCBiZWluZyBOVUxMLCB3aGlsZSB0aGUgY29uZGl0aW9uYWwgaW1wbGljaXRs
eSBjaGVja3MKPj4gYWdhaW5zdCAwLgo+IAo+IAo+IFllcywgdGhpcyBpcyB3cm9uZywgd2lsbCBy
ZW1vdmUgaXQuCj4gCj4gPHNuaXA+Cj4gCgpJIHdpc2ggeW91IGhhZG4ndCBzbmlwcGVkIG15IGNv
bW1lbnQgaGVyZSwgYnV0IGFkZHJlc3MgaXQKb25lIHdheSBvciB0aGUgb3RoZXIuIEl0IGlzOgoK
SSdkIG11Y2ggcmF0aGVyIHRoYXQgaW50ZWdlciBjb21wYXJpc29uIGJlIHBlcmZvcm1lZCBhZ2Fp
bnN0CmludGVnZXJzLCBhcyBvcHBvc2VkIHRvIHVzaW5nIGxvZ2ljYWwgTk9UIG9wZXJhdG9yICh3
aGljaCBpcwppbXBsaWNpdCBpbiBjb21wYXJpbmcgYWdhaW5zdCAwKSwgaS5lLiwKCmlmIChhZGV2
LT5ncHVfc2NoZWRbaHdfaXBdW2h3X3ByaW9dLm51bV9zY2hlZHMgPT0gMCkKCkFsc28sIGFyY2hp
dGVjdHVyYWxseSwgdGhlcmUgc2VlbXMgdG8gYmUgaW5mb3JtYXRpb25hbApyZWR1bmRhbmN5LCBp
biBrZWVwaW5nIGFuIGludGVnZXIgY291bnQgYW5kIGxpc3Qgb2YKb2JqZWN0cyBhdCB0aGUgc2Ft
ZSB0aW1lLCBhcyB0aGUgYWJvdmUgaWYtY29uZGl0aW9uYWwKZXhwb3NlczogdGhlIGNvbW1lbnQg
dGFsa3MgYWJvdXQgYSBsaXN0IGFuZCBOVUxMIGJ1dAp0aGUgaWYtY29uZGl0aW9uYWwgaW1wbGlj
aXRseSBjaGVja3MgZm9yIDAuCgpQZXJoYXBzLCB3ZSBkb24ndCBuZWVkICJudW1fc2NoZWRzIiBh
bmQgeW91IGNhbiBqdXN0CmNoZWNrIGlmIHRoZSBpbmRleCBpcyBOVUxMIGFuZCBhc3NpZ24gUFJJ
T19ERUZBVUxULgoKPj4gQEAgLTI1OCw2ICsyNzIsMTIgQEAgaW50IGFtZGdwdV9yaW5nX2luaXQo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKPj4g
ICAJcmluZy0+cHJpb3JpdHkgPSBEUk1fU0NIRURfUFJJT1JJVFlfTk9STUFMOwo+PiAgIAltdXRl
eF9pbml0KCZyaW5nLT5wcmlvcml0eV9tdXRleCk7Cj4+Cj4+ICsJaWYgKHJpbmctPmZ1bmNzLT50
eXBlICE9IEFNREdQVV9SSU5HX1RZUEVfS0lRKSB7Cj4+ICsJCWh3X2lwID0gYW1kZ3B1X3Jpbmdf
dHlwZV90b19kcm1faHdfaXBbcmluZy0+ZnVuY3MtPnR5cGVdOwo+PiArCQludW1fc2NoZWQgPSAm
YWRldi0+Z3B1X3NjaGVkW2h3X2lwXVtod19wcmlvXS5udW1fc2NoZWRzOwo+PiArCQlhZGV2LT5n
cHVfc2NoZWRbaHdfaXBdW2h3X3ByaW9dLnNjaGVkWygqbnVtX3NjaGVkKSsrXSA9ICZyaW5nLT5z
Y2hlZDsKPj4gKwl9Cj4+IFRoaXMgc2VlbXMgdW5uZWNlc3NhcmlseSBjb21wbGljYXRlZC4gUGVy
aGFwcyB3ZSBjYW4gcmVtb3ZlCj4+ICJudW1fc2NoZWRzIiwgYXMgcmVjb21tZW5kZWQgYWJvdmUs
IGFuZCBrZWVwIGEgcnVubmluZyBwb2ludGVyCj4+IHdoaWxlIGluaXRpYWxpemF0aW9uIGlzIGJl
aW5nIGRvbmUuLi4/Cj4gCj4gCj4gV2hhdCBkbyB5b3UgbWVhbiBieSBydW5uaW5nIHBvaW50ZXIg
PwoKQSAicnVubmluZyBwb2ludGVyIiBpcyBhIGxvY2FsIHBvaW50ZXIgeW91J3JlIHVzaW5nIHRl
bXBvcmFyaWx5CnRvIHRyYXZlcnNlIG1lbW9yeS4gSWYgeW91IHJlbW92ZSB0aGUgIm51bV9zY2hl
ZHMiLCBhcyBub3RlZCBpbiBteQpwcmV2aW91cyBjb21tZW50LCB0aGVuIHlvdSBjYW4gdXNlIGEg
cnVubmluZyBwb2ludGVyIHRvIGNvbnRhaW4KdGhlIG5leHQgZW50cnkgeW91J2QgaW5pdGlhbGl6
ZS4KClJlZ2FyZHMsCkx1YmVuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
