Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93A8C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 18:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB4B216F4
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 18:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB4B216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747036E949;
	Fri, 29 Nov 2019 18:42:34 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800051.outbound.protection.outlook.com [40.107.80.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E49AC6E978
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 18:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJHOfUZunWQcZJD0FujeepgCXJoCtVPXPtgaTuxe9WQQzBm5+YIE/sBRdRdKeYbgdKPWRrjWrtnwa72w51dcN7uQn3Jm09XfeF6KBxc5z+3NTK0vgbNCrvl/TUjAhAcQMZ/cPvxQQ3u3sf8icGNJp8BiFbHvsJWpMqy3PHfz2s9V3A8s0j384Xq+tBIUgSFadLqnI33QmRy+kyCo7JW8NnLBnAMbDzP+x+aku85TDXIPfxA8MVdjA9HwXpyedv3/XVcBOzqZ/Zmc1DcL4CWwuzdEXMZQ6qWhuObq0acTUbZMBsjE2fXmzkwtrvm4ufBOl8DcYJo36qGk1AOBwpoKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aVHgPNgLcs6pJ85hfY67QxgX53AZCLnVXfcwWuwhrk=;
 b=JCnsu1dj8WOcQMibMVj0J8m9m4Q6qVWk6k143zumgjmsIkO7AQ/5Ek8dQ7OI4arc4CN49nzXcFK3xmK6sw0gLyLA7ODw9atbTuKousPfSGZmRWH70NqGox/nQE1j2/N+hLI0919Bu6163sdxYirIofgfjiMEnwRKgr2zInP7sFz4BzwGQcMv8RxOMcpE1EOm1rgvbM2k+fvKdol7+KJkaBGlmY+5PiOjL3pFoE4iiYzNYN4ZfL3v3R+pqmdlfARd01M9B+NrMZP2H2vuj8ZGR73dD8jGUhdxC2DUavy9K15axm17nsAah7AS8V43UtYjgRNdGaJVB6IAdSNHhboSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5SPR00MB238.namprd12.prod.outlook.com (10.173.136.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 18:42:29 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 18:42:29 +0000
Subject: Re: [RFC PATCH] drm/amdgpu: allocate entities on demand
To: Nirmoy <nirmodas@amd.com>, alexander.deucher@amd.com, kenny.ho@amd.com
References: <20191125231719.108949-1-nirmoy.das@amd.com>
 <2e514ab3-1582-6508-d81a-cbc2d12f42d7@amd.com>
 <74fd0faf-fd99-e33e-8d7a-95f9bb8be26a@gmail.com>
 <4954a31a-dfbb-1432-9ffe-42ad9f89073c@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b141b429-42ae-9640-d9eb-7ab243240ea2@amd.com>
Date: Fri, 29 Nov 2019 19:42:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <4954a31a-dfbb-1432-9ffe-42ad9f89073c@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR05CA0011.eurprd05.prod.outlook.com
 (2603:10a6:208:55::24) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f96912d5-685d-489c-0d58-08d774fbe327
X-MS-TrafficTypeDiagnostic: DM5SPR00MB238:|DM5SPR00MB238:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5SPR00MB2389F140C929E4A61B8F51E83460@DM5SPR00MB238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0236114672
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(199004)(189003)(8936002)(6436002)(5660300002)(305945005)(50466002)(76176011)(52116002)(229853002)(6506007)(23676004)(186003)(6246003)(65806001)(65956001)(2486003)(66946007)(386003)(66556008)(47776003)(66476007)(6512007)(8676002)(6486002)(53546011)(81156014)(6636002)(81166006)(2906002)(7736002)(478600001)(31686004)(25786009)(4326008)(316002)(99286004)(58126008)(6666004)(11346002)(2616005)(14454004)(31696002)(86362001)(6116002)(36756003)(446003)(46003)(2870700001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5SPR00MB238;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7L7uFIcWLU4cv5QOKJMkNBlLOyfSFuR296vmYz+R0vFs0KCfS1sI1Ldm5R5Bse9RT21imOjzY31/KJf5+8EsXi+Nc4z5Royug7Fnwapd/jEBguIfZDYYmUKVDjIQaOFI8Z5DZ2YJb2fYnzAkbaP3o4l6DdVElTjDHRjZP/cZkiq/faaAfs8cofPwSKG1q7XELyuX7IJkPDPK480Q/2ycDwMmJYRFEOfyJ3njPEfbx94lpRco/YeJElaKxhwPbKGtAP8GCdY6LAyIvuPhlbGgEBfvzWFMVPqw1XurRsOj3l+T/8zVW3vxFXxqG7ZAGMmxYxZDUO4g3TIlEHTFKeqQahe11g9eKdh8bQVdDgtVI+aDvVzPXDM+L55SPVlvprbD8FgCdKMUsM9WlOQ1NeolQWVu/gfzQTZQNZA1GUxozghvgbuDp125yNfy+6uHK8nd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96912d5-685d-489c-0d58-08d774fbe327
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2019 18:42:29.4714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eGGwOTGLyf/oe4jCRQnYkGkrkrIYoSxVdg/DJSYr7Ppd+6JmhAnTxIrABm7L56C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5SPR00MB238
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aVHgPNgLcs6pJ85hfY67QxgX53AZCLnVXfcwWuwhrk=;
 b=b2/vr7cGJlIx/nY30UnRdSDVHX/jAbZRnkxrzvcaNdivUn0O/REnIXDXGr5gdWhqB3elETtRrALuvA5o5yQL32ttWpgqEkd9tPh9X20HqZjWyy7K++FvFl46h19dLGxLuRUbOa1yO1FfPqcd81zNeRQD0WMJm4ihC2yeRfdRmdQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjkuMTEuMTkgdW0gMTU6Mjkgc2NocmllYiBOaXJtb3k6Cj4gSGkgQ2hyaXN0aWFuLAo+Cj4g
T24gMTEvMjYvMTkgMTA6NDUgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEl0IGxvb2tz
IGxpa2UgYSBzdGFydCwgYnV0IHRoZXJlIG51bWVyb3VzIHRoaW5ncyB3aGljaCBuZWVkcyB0byBi
ZSAKPj4gZml4ZWQuCj4+Cj4+IFF1ZXN0aW9uIG51bWJlciBvbmUgaXM6IFdoYXQncyB0aGF0IGdv
b2QgZm9yPyBFbnRpdGllcyBhcmUgbm90IHRoZSAKPj4gcHJvYmxlbSBoZXJlLiBUaGUgcmVhbCBp
c3N1ZSBpcyB0aGUgZmVuY2UgcmluZyBhbmQgdGhlIHJxX2xpc3QuCj4+Cj4+IFRoZSBycV9saXN0
IGNvdWxkIGFjdHVhbGx5IGJlIG1hZGUgY29uc3RhbnQgc2luY2UgaXQgc2hvdWxkIG5ldmVyIGJl
IAo+PiBjaGFuZ2VkIGJ5IHRoZSBlbnRpdHkuIEl0IGlzIG9ubHkgY2hhbmdlZCBmb3IgYmFja3dh
cmQgY29tcGF0aWJpbGl0eSAKPj4gaW4gZHJtX3NjaGVkX2VudGl0eV9zZXRfcHJpb3JpdHkoKS4K
Pj4KPj4gU28gSSB3b3VsZCBzdGFydCB0aGVyZSBhbmQgY2xlYW51cCB0aGUgCj4+IGRybV9zY2hl
ZF9lbnRpdHlfc2V0X3ByaW9yaXR5KCkgdG8gYWN0dWFsbHkganVzdCBzZXQgYSBuZXcgY29uc3Rh
bnQgCj4+IHJxIGxpc3QgaW5zdGVhZC4KPgo+IEkgYW0gbWlzc2luZyBzb21lIGNvbnRleHQgaGVy
ZS4gQ2FuIHlvdSBwbGVhc2UgZXhwbGFpbiBiaXQgbW9yZT8gSSAKPiBsb29rZWQgb3ZlciBhbmQg
b3ZlciBhZ2FpbiBidXQgSSBzdGlsbCBkb24ndCB1bmRlcnN0YW5kIHdoYXQgZG8geW91IAo+IG1l
YW4gYnnCoCBuZXcgY29uc3RhbnQgcnEgbGlzdCA6LwoKT2sgdGhhdCBuZWVkcyBhIGJpdCB3aWRl
ciBleHBsYW5hdGlvbi4KClRoZSBHUFUgc2NoZWR1bGVyIGNvbnNpc3RzIG1haW5seSBvZiBkcm1f
Z3B1X3NjaGVkdWxlciBpbnN0YW5jZXMuIEVhY2ggCm9mIHRob3NlIGluc3RhbmNlcyBjb250YWlu
IG11bHRpcGxlIHJ1bnF1ZXVlcyB3aXRoIGRpZmZlcmVudCBwcmlvcml0aWVzIAooNSBJSVJDKS4K
Ck5vdyBmb3IgZWFjaCBlbnRpdHkgd2UgZ2l2ZSBhIGxpc3Qgb2YgcnVucXVldWVzIHdoZXJlIHRo
aXMgZW50aXR5IGNhbiBiZSAKc2VydmVkIG9uLCBlLmcuIHdoZXJlIHRoZSBqb2JzIHdoaWNoIGFy
ZSBwdXNoZWQgdG8gdGhlIGVudGl0aWVzIGFyZSAKZXhlY3V0ZWQuCgpUaGUgZW50aXR5IGl0c2Vs
ZiBrZWVwcyBhIGNvcHkgb2YgdGhhdCBydW5xdWV1ZSBsaXN0IGJlY2F1c2Ugd2UgaGF2ZSB0aGUg
CmRybV9zY2hlZF9lbnRpdHlfc2V0X3ByaW9yaXR5KCkgd2hpY2ggbW9kaWZpZXMgdGhpcyBydW5x
dWV1ZSBsaXN0LgoKQnV0IGVzc2VudGlhbGx5IHRoYXQgaXMgY29tcGxldGUgb3ZlcmtpbGwsIHRo
ZSBydW5xdWV1ZSBsaXN0cyBhcmUgCmNvbnN0YW50IGZvciBlYWNoIGFtZGdwdSBkZXZpY2UsIGUu
Zy4gYWxsIGNvbnRleHRzIHNob3VsZCB1c2UgU0RNQTAgYW5kIApTRE1BMSBpbiB0aGUgc2FtZSB3
YXkuCgpJbiBvdGhlciB3b3JkcyBidWlsZGluZyB0aGUgbGlzdCBvbiBydW5xdWV1ZXMgc2hvdWxk
IGhhcHBlbiBvbmx5IG9uY2UgCmFuZCBub3QgZm9yIGVhY2ggY29udGV4dHMuCgpNdWx0aXBsZSBh
cHByb2FjaCB0byBmaXggdGhpcyB3b3VsZCBiZSBwb3NzaWJsZS4gT25lIHJhdGhlciBlbGVnYW50
IApzb2x1dGlvbiB3b3VsZCBiZSB0byBjaGFuZ2UgdGhlIHJxIGxpc3QgaW50byBhIHNjaGVkdWxl
ciBpbnN0YW5jZXMgbGlzdCAKKyBwcmlvcml0eS4KClRoaXMgd2F5IHdlIHdvdWxkIGFsc28gZml4
IHRoZSBhZ2Ugb2xkIGJ1ZyB0aGF0IGNoYW5naW5nIHRoZSBwcmlvcml0eSBvZiAKYSBjb250ZXh0
IGNvdWxkIGFjdHVhbGx5IG1lc3MgdXAgYWxyZWFkeSBzY2hlZHVsZWQgam9icy4KClRoZSBhbHRl
cm5hdGl2ZSBJIG5vdGVkIGJlZm9yZSB3b3VsZCBiZSB0byBkcm9wIApkcm1fc2NoZWRfZW50aXR5
X3NldF9wcmlvcml0eSgpIG9yIGNoYW5nZSBpdCBpbnRvIApkcm1fc2NoZWRfZW50aXR5X3NldF9y
dW5xdWV1ZXMoKS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPj4KPj4gVGhlbiB3ZSBjb3VsZCBl
bWJlZCB0aGUgZmVuY2VzIGluIGFtZGdwdV9jdHhfZW50aXR5IGFzIGR5bmFtaWMgYXJyYXkgCj4+
IGF0IHRoZSBlbmQgb2YgdGhlIHN0cnVjdHVyZS4KPj4KPj4gQW5kIGxhc3Qgd2UgY2FuIHN0YXJ0
IHRvIGR5bmFtaWMgYWxsb2NhdGUgYW5kIGluaXRpYWxpemUgdGhlIAo+PiBhbWRncHVfY3R4X2Vu
dGl0eSgpIHN0cnVjdHVyZXMuCj4+Cj4+IFJlZ2FyZHMsCj4+IENocmlzdGlhbi4KPj4KPj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
