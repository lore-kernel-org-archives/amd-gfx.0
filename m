Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E7DC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 22:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0104D20780
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 22:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uZ7vpb3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0104D20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABDB989FA7;
	Mon, 29 Jun 2020 22:46:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 408CC89FA7
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 22:46:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFuMkizXON2rbihhxcPKhbqvMbRPi+2UALRUUB8F3rhgpzvee+8nauxmxC2oRnGplfatsvAth7OtSf3bG8ToggowEV3PFUaPTTMg4z8MFadCrL+Rr5oenCBMTLwl6SjPUkaJqx/yHv4NbnAFHqqxSmZio/gOB8v27Tcx0Zump1+n8o7Hnbb5MsPxp/Md+2HEyRGsS/kmWnb9zU1KAEARzk5r686tO4QATT30q09wwHirzYj5zMdWN+p48lfzFb3f9uOpo3YEws7xEnwbyXMSZNB4ByNSLtm/4YiSC+9OsD9XONZr7yjNhq3CWCKZ+5iaPgnFCq2e1nnbrHqU4KY7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+CTuATPCl12JulB8JXTE6RBXEgXXLGXDQGobUXbMjc=;
 b=FQDMIWIK8ql2OU3iqrJEg10fKakBn6KpkJGcTKvTsy8vUkErbqn7fBv9abDTO/xvtZ9SuvaUPVYxf8Ts3IInQHdiAvOXs4v4gG+yKbuegVi9EJ09qOSWmSKssmidCxG0PX9XiW80eQe+7OOz3TRL2u2rwsJmMDGmv5HapNVqdsPJc+Vr64q33LhMWa9HNt5EKRGHitrZNNn8FBTrMoV2U4WoE5tF8aDlO/iv3BAug4vvlj1lh8j7sWqA//sYniSyVVd9oXsRxqt2VHEOoleVoycfrKb5sDaqXFEOShVnDyTPgP4aGjERz6vcn2SCPa6WWL6uN25M2s1JG0MwYcswhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+CTuATPCl12JulB8JXTE6RBXEgXXLGXDQGobUXbMjc=;
 b=uZ7vpb3vx6yO93qe/W2Q/WqqKvAxk53FD0w0n/SvfQEtSmLv5qmnohiwDW231a8h1yle15kr0bxFK0zlDYUIySTTPa4anIniwkhQD+iv1nUndJCJ+KNiuwJGaXnD4SjDi9uHD+weXW5rtQkx1Ow4mX4JjGJNxaiif+JOud9AZ1g=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3124.namprd12.prod.outlook.com (2603:10b6:408:41::12)
 by BN8PR12MB2931.namprd12.prod.outlook.com (2603:10b6:408:6d::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Mon, 29 Jun
 2020 22:46:06 +0000
Received: from BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::d0d4:708e:e217:fa27]) by BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::d0d4:708e:e217:fa27%3]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 22:46:06 +0000
Subject: Re: [PATCH] drm/amdgpu: Adding wait time before reading upll control
 register
To: christian.koenig@amd.com, Alex Jivin <alex.jivin@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200626161239.19762-1-alex.jivin@amd.com>
 <a3c7780c-d891-4cf6-f49b-e72692803615@gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <5b07670d-ad6e-2378-062e-c33e3a73f5c7@amd.com>
Date: Mon, 29 Jun 2020 18:46:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <a3c7780c-d891-4cf6-f49b-e72692803615@gmail.com>
Content-Language: en-CA
X-ClientProxiedBy: BN8PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:408:70::29) To BN8PR12MB3124.namprd12.prod.outlook.com
 (2603:10b6:408:41::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN8PR04CA0016.namprd04.prod.outlook.com (2603:10b6:408:70::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Mon, 29 Jun 2020 22:46:05 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dacc64b4-1892-4dfc-6864-08d81c7e3543
X-MS-TrafficTypeDiagnostic: BN8PR12MB2931:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2931E24ECC0B7C51FBA1F8F7996E0@BN8PR12MB2931.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdZHpBUtQyNOMLfAd4irZw6kOcKjKcCaj/yXIw4swbau83khWPYPj0dmCCdzhyAFScApApQaCKQ2uj5D5zsM8Ozl+XE56Pn4bujHu4sZrAPCSRapKnkByc33ujAPQz9ANmnBt9JP80K8bChQVCc+1MZMGeWYyS8Jh2XxR7cqWqm3uOL14CnacH0I4284qfg8S5T2ojoc7cMSLrpJX5Ps6iP3cWSJCxI38xfF3iBpr60hzX6gvNaV6BrrQiyNoXPSP53javAJtgV3Ab8+dZsBgJJy7c0gdF7M9qYjldjGJOwE3FIK4yt1u67BvEXrA7iVSTuzX3XY83HJzn5h74PmBanUMkKbPx/ActXDUN/+E/TaAgNGjZji9VriuQrEjliM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(83380400001)(26005)(8676002)(8936002)(2616005)(44832011)(956004)(5660300002)(16526019)(186003)(478600001)(2906002)(6512007)(66476007)(66556008)(66946007)(66574015)(53546011)(6506007)(36756003)(316002)(6486002)(4326008)(52116002)(86362001)(31686004)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7qkJqhomT5XkGgr4egcUw4sIugsQu2Dc8NSkPRXqz9waYJwiwPsywhkGXVLcA/vJSZkdSKdoM/NWvp4EZYabJeGM9PXzBfT6T848Kdb3LBmVtzkdXSipkiviXaoPJLlNdaHOQv6hpM9cehN/GpPvkNoc1KBZCdRccWu7lwat8IHmS2hTMLoTsHHqPB2rwhAD/mjtQRaZ0gQ58q5GfanaskKA7RU3oTPSpDOkTYMxvFuKeFp7zRLfXe+mxPb+4dnEjBEBOd420yCz6NSnxI7aBwYJfgOQyC0gcw9EIQqaZvEpviYt+IeVz6AE7yfMlMp2FjBSKb0R6qrmp5k0j9LlZht/1XnJas0ozzEW43JQAKhNxd1V9NJy6itAr4MoFLmtOOiblzrrDUdR89KaQ8w1DFjrKVy8oXHZ79bWI6aFEpkR9D4X8u0QL3d4ZbbJkf7/JP07JuVydiQJ5bVYRtZJsqlZKMwT3XYpd0LDUhy1o9A=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dacc64b4-1892-4dfc-6864-08d81c7e3543
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 22:46:06.0041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBfA7UM5twH37eY6DfjirKt2O/jpIFPEjKsJCIApIWKHO/FqyC3LDeJ6OQrkf8Xs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2931
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wNi0yNiAxOjA0IHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjYu
MDYuMjAgdW0gMTg6MTIgc2NocmllYiBBbGV4IEppdmluOgo+PiBBZGRpbmcgYSBkZWxheSBiZXR3
ZWVuIHdyaXRpbmcgdG8gVVZEIGNvbnRyb2wgcmVnaXN0ZXIgYW5kIHJlYWRpbmcgZnJvbSBpdC4K
Pj4gVGhpcyBpcyB0byBhbGxvdyB0aGUgSFcgdG8gcHJvY2VzcyB0aGUgd3JpdGUgY29tbWFuZC4K
Pj4KPj4gU2lnbmVkLW9mZi1ieTogQWxleCBKaXZpbiA8YWxleC5qaXZpbkBhbWQuY29tPgo+PiBT
dWdnZXN0ZWQtQnk6IEx1YmVuIFR1a292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4KPj4gLS0tCj4+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2kuYyB8IDYgKysrKysrCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2kuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpLmMKPj4g
aW5kZXggOWQ3YjRjY2QxN2I4Li40MmNkYzE0ZmI3OWQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NpLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc2kuYwo+PiBAQCAtMTQzNSw2ICsxNDM1LDEyIEBAIHN0YXRpYyBpbnQgc2lfdXZkX3NlbmRf
dXBsbF9jdGxyZXEoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+ICAgCS8qIEFzc2VydCBV
UExMX0NUTFJFUSAqLwo+PiAgIAlXUkVHMzJfUChjZ191cGxsX2Z1bmNfY250bCwgVVBMTF9DVExS
RVFfTUFTSywgflVQTExfQ1RMUkVRX01BU0spOwo+PiAgIAo+PiArCS8qIFdhaXRpbmcgZm9yIEhX
IHRvIHByb2Nlc3MgdGhlIHByZXZpb3VzIHdyaXRlLgo+PiArCSAqIFRoaXMgaXMgdG8gZ2l2ZSBh
IGNoYW5jZSB0byBIVyB0byBhY3QgYmVmb3JlCj4+ICsJICogdGhlIGZpcnN0IHJlYWQgaXMgZG9u
ZS4KPj4gKwkgKi8KPj4gKwltZGVsYXkoMSk7Cj4+ICsKPiAKPiBNaG0sIHRoYXQgaXMgbW9zdCBs
aWtlbHkgbm90IGEgZ29vZCBpZGVhLgo+IAo+IFdlIG5lZWQgdG8gaXNzdWUgYSByZWFkIGFmdGVy
IHRoZSB3cml0ZSB0byBtYWtlIHN1cmUgdGhhdCB0aGUgc3R1ZmYgaXMgCj4gc2VuZCBvdXQgdG8g
dGhlIGhhcmR3YXJlLgoKVHJhY2luZyBkb3duIFdSRUczMl9QKCksIGl0IHNlZW1zIHRvIGJlIHdy
aXRpbmcgYW5kIHRoZW4gcmVhZGluZyB0aGUgcmVnaXN0ZXIsCmJhY2sgdG8gYmFjaywgdHdpY2Ug
b3Zlciwgd2hlbiBkZWZlcnJpbmcgdG8gUENJZSBzcGFjZSwgYW5kIGp1c3Qgd3JpdGVsKCkgd2hl
biBpbiBtbWlvCnNwYWNlLiAoVGhlcmUgaXMgc2VwYXJhdGUgdGhyZWFkIG9uIHRoaXMgYXMgaXQg
ZG9lc24ndCBzZWVtIGNvcnJlY3QuKQoKPiBBZGRpbmcgYSBkZWxheSBoZXJlIGlzIHByb2JhYmx5
IGp1c3QgcG9zdHBvbmluZyB0aGF0LiBEbyB3ZSBoYXZlIHNvbWUgCj4gbm90ZSBpbiB0aGUgZG9j
dW1lbnRhdGlvbiB0aGF0IHRoaXMgaXMgbmVjZXNzYXJ5PwoKRmx1c2hpbmcgdGhlIHdyaXRlIGJ1
ZmZlciAoYnkgaXNzdWluZyBhIHJlYWQgaWYgbmVjZXNzYXJ5KSBpcyBkaWZmZXJlbnQKdGhhbiB3
YWl0aW5nIGZvciB0aGUgaGFyZHdhcmUgdG8gcHJvY2VzcyB0aGUgcmVxdWVzdC4KClRoZSBjdXJy
ZW50IGNvZGUgZG9lcyBmbHVzaCB0aGUgd3JpdGUgYnVmZmVyIGJ5IHJlYWRpbmcgYmFjaywKYW5k
IHRoZW4gZGVsYXlpbmcgKGJvdGggaW4gdGhlIGxvb3ApLCB3aGljaCBkb2VzIGFjaGlldmUgdGhp
cywKYnV0IGl0IGxlYXZlcyBhIGNvcm5lciBjYXNlIGFzIEkgd3JvdGUgaW4gbXkgcmV2aWV3LgpU
aGUgY29ybmVyIGNhc2UgaXMgdGhhdCBpZiB0aGUgc3RhdHVzCnJlZ2lzdGVyIGNoYW5nZXMgdG8g
ImRvbmUiIHdoaWxlIGluIHRoZSBsYXN0ICJkZWxheSgpIgp3ZSB0aGVuIGNoZWNrIHRoZSBsb29w
IGludmFyaWFudCBhbmQgZXhpdCwgYXMgb3Bwb3NlZCB0byByZWFkaW5nCnRoZSByZWdpc3RlciBh
bmQgZGV0ZXJtaW5pbmcgdGhhdCBpdCBpcyBkb25lIHN1Y2Nlc3NmdWxseS4KCkN1cnJlbnQsIGFs
bCBpbiBwc2V1ZG8tY29kZToKCndyaXRlKCkKCmZvciAoY291bnQgPSAwOyBjb3VudCA8IE1BWF9D
T1VOVDsgY291bnQrKykgewoJcmVzID0gcmVhZCgpCglpZiAocmVzIGlzIHN1Y2Nlc3MpIGJyZWFr
CgltZGVsYXkoMTApICAgICAgICAgICAgICA8LS0gaWYgaXQgY2hhbmdlcyBoZXJlLCB3ZSBtaXNz
IGl0IG9uIHRoZSBsYXN0IGl0ZXJhdGlvbgp9CgpPcHRpbWFsOgoKd3JpdGUoKSAgIDsgYXNzdW1l
IHdyaXRlIGJ1ZmZlciBmbHVzaAptZGVsYXkoOSkKZG8gewoJbWRlbGF5KDEpCglyZXMgPSByZWFk
KCkKfSB3aGlsZSAocmVzICE9IHN1Y2Nlc3MgJiYgKytjb3VudCA8IE1BWF9DT1VOVCkKClRoaXMg
c29sdmVzIHRoZSBjb3JuZXIgY2FzZSwgYW5kIGVuc3VyZXMgYSB0aW1lIGRlbGF5IG9mIDEwIGZv
cgp0aGUgaGFyZHdhcmUgdG8gcHJvY2VzcyBpdHMgam9iLCBidXQgYSBkZWxheSBvZiAxIGZvciBw
b2xsaW5nCnRoZSBzdGF0dXMsIGFzIGl0IGNvdWxkIGJlIGRvbmUgImFueXRpbWUgbm93LiIKCkFz
c3VtaW5nIHRoYXQgV1JFRzMyX1AoKSBmbHVzaGVzIHRoZSB3cml0ZSBidWZmZXIsIGFzIGl0IHNl
ZW1zCnRoYXQgaXQgZG9lcywgdGhlIGlkZWEgaGVyZSBpcyB0byBnaXZlIHRoZSBoYXJkd2FyZSBz
b21lIHRpbWUgdG8gcHJvY2Vzcwp0aGUgcmVxdWVzdCAoZnJvbSB3cml0aW5nIGEgdmFsdWUgdG8g
aXQpLCBidXQgd2hlbiBwb2xsaW5nIHRvIHBvbGwKYSBzaG9ydGVyIGFtb3VudCBvZiB0aW1lLgoK
SSB3b3VsZCd2ZSBhbHNvIGxpa2VkIHRvIHNlZSB0aGUgbXV0ZXggYnVzaW5lc3MgZml4ZWQKYXMg
d2VsbCBmcm9tIG15IG9yaWdpbmFsIHBhdGNoIHJldmlldywgYXMgaXQgaXMgZWFzeSB0byBwcm92
ZQp0aGF0IGl0IGlzIGFsd2F5cyB0YWtlbiwgc28gbm8gbmVlZCB0byBlbWJlZCBpdCBpbnNpZGUg
dGhlIGlmKCkuCgpSZWdhcmRzLApMdWJlbgoKPiAKPiBDaHJpc3RpYW4uCj4gCj4+ICAgCS8qIFdh
aXQgZm9yIENUTEFDSyBhbmQgQ1RMQUNLMiB0byBnZXQgYXNzZXJ0ZWQgKi8KPj4gICAJZm9yIChp
ID0gMDsgaSA8IFNJX01BWF9DVExBQ0tTX0FTU0VSVElPTl9XQUlUOyArK2kpIHsKPj4gICAJCXVp
bnQzMl90IG1hc2sgPSBVUExMX0NUTEFDS19NQVNLIHwgVVBMTF9DVExBQ0syX01BU0s7Cj4gCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
