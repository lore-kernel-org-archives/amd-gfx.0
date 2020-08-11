Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFAFC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 13:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3050120782
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 13:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cHhlUYL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3050120782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9063A6E370;
	Tue, 11 Aug 2020 13:08:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam07on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1257C6E370
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 13:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltDKYopiUilEc0zp0BYggT7Yy/RFVABvCeAVZxJu65V672bL8wmmZspmWVPuDT+rA30RuwzTVrzv19zpw8jGToyFmeZpiqbjWGsOhzuQkBdztu8wscApld5ewTMhdnaiH4p3SJWmcmFs2QpHyGnmU8+KWxmN/U+EQ9x0+HGLDExEAAPjGDZ29VxAgk+66PhDyNhYouuKnEu1Qcxg2oymjGFU4xdZShT7d00Tsg+ZFUMSX2PaG2WO9SWSQA/BB3jpHVK2gxvzd5hDM5cJqd6AH7kS/P86Ih7h+1TQTOsYH1/TlBi3Qe6uaXRwGIvIsURP9MkQAuhv8/yz8jMy0pWTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAjKZ8wWmQJCMB/YA5EVG4TNTLtzmYqlgkzV3k2O/bo=;
 b=R9M+/yHGCUCF2nIYoNDYsC+TznW1SGsE+DUZ/e5PqSt8iMxrjxem2v5sC3eSeUGgvh2B5mw7neRF3JYKBPwrqBgKrRZbeAv2QImndk58ngM0EcdKV7jQ1dxFA1C2/gfXDmYzF3l8PeHwqOejIV22zynfWv0bfwhwEOItZtutYvBgBdvnUnrZccX1X/C96YNc2HMtTXaOz5789OyfMsCUHI/gJ3qQ0HzVejSjdGBAOwII0kK0gnBH66UMz2mjA1y7/HbcWxgd0XYRE9TVpNx2E3svyhMYFsBQaf7pWpkFp6smdupG/pka+iszhhrCJH59HoZ6WZmj/wxdMKQ2NI262w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAjKZ8wWmQJCMB/YA5EVG4TNTLtzmYqlgkzV3k2O/bo=;
 b=cHhlUYL2wBZbDhjFk2lckxthRMS9T7nkvJ3wvZ3oyfPa5neRgOzl56tYgpaSV+cqm247OuMhYx3QN2/ARXqNI8c9wWtkvSY0ZIpqwe114WKoASIUO54we3F2Jm1FCLKEm28Vs7nJMReaetHsHDOKZlqZePkbu7TDEplUMN2cTCM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2407.namprd12.prod.outlook.com (2603:10b6:4:b4::24) by
 DM6PR12MB3451.namprd12.prod.outlook.com (2603:10b6:5:11d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Tue, 11 Aug 2020 13:08:26 +0000
Received: from DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::a0cf:1440:da79:9df5]) by DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::a0cf:1440:da79:9df5%7]) with mapi id 15.20.3283.015; Tue, 11 Aug 2020
 13:08:25 +0000
Subject: Re: [PATCH] drm/amdkfd: force raven as "dgpu" path
To: Huang Rui <ray.huang@amd.com>
References: <20200807082545.2382890-1-ray.huang@amd.com>
 <0ae61c8f-970c-417b-0ae4-639ea1a95f9a@amd.com>
 <20200811114554.GA2901283@hr-amd>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <739ac7e0-c8c5-b0ba-4fc5-49be99f931f4@amd.com>
Date: Tue, 11 Aug 2020 09:08:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200811114554.GA2901283@hr-amd>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::17) To DM5PR12MB2407.namprd12.prod.outlook.com
 (2603:10b6:4:b4::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YT1PR01CA0138.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19 via Frontend Transport; Tue, 11 Aug 2020 13:08:25 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 62321e3b-5435-4a5c-57a8-08d83df7a1b9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3451866A37E84CDEA106392C92450@DM6PR12MB3451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /5CJrVD9VNA7JfP9IZpoL/BVTgW6fbSRLyeCnzCdDD2SLRD5tdXh/CNsf6BWgO2tLBXh/GUR/Eof64V+6wheGQ1xzWrfNNQxpMN37190Js/oukz6t4f0qKln12rqc3LUKrpDWkLa1+gMt7Ey/1kZ/5E7kJmAHvcWQ0ZTJSNMM6YfCMdPtUV3PcYZSmlH7Zj+fMz5JNwTnKCoOcuF79Ruesuij075GTVk8OYrxioUeuSPzfIspniAHI3u3BuWejeObyAM/I5xLWljK+mpiCK++D4UIDzY53K4Za1k46zYNkiTHTbZEXdoCCsaD/81dLXGw2QApW0+V9PoszwU7FzYzodakJC0janvVBhfFXym7cap9TyDuhBGa7xMDmePLp81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2407.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(6486002)(8676002)(36756003)(83380400001)(31696002)(4326008)(52116002)(86362001)(26005)(66946007)(2616005)(44832011)(37006003)(16526019)(31686004)(186003)(6862004)(66556008)(956004)(478600001)(8936002)(6636002)(316002)(2906002)(16576012)(66476007)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: W0DcTuQePZ2hmXXIKw7wirlB/BQvuudPbGW2bxLKtnMQ3r4YfxMLTjqPIp12O2dCrQlSRLsJwXM5p3m1HuVH5/SloA1r1OMMLR2Qrn8S02vPOrzwxP5psepttB3oiAYt+HXLDHx0YxBAlGvi5bDI+qVhq4CnxX9Ql42P+qPmNcGcNt+DCQh/Je6xH0zmQKfg5xEX1EhSi0zEq0zNrHC/e+Vi68VFpPUrQ/tVA2K6bVPY5eW0mwAO2qfmwvRPCzKyAytp+5/w0B2fmVVpKhqBh/3SQu6sK/SYZwc6I9X0kUtnBMPDxiVPwDUlTWW3fAmZKXw7FFELQdUkAn56KLCGEpzLej/gebcoQ4U8lXdyLt+Z79jBRJQO8k9MtN2SsXfbUWzy2kExtV+GjMKHsjIlaKqiOG9WfUdrh9/pOje9cpLQbk+1oISid8RTpoM/W++nCZ5tlTlWXscZjwfzx+klIrUt8Hup3V2Y6+miybfF5v2bdxI/aE1H7e1Q+Jssvg+XbkGtfpvSSwQgqGdUuXI8axM/qcYhl/aRl0jtjSmu2VJ2j54oIPM33DcYYhc1yyn58D4P29hY6cKlK6mrDjKQWrMeFYtNhYp97iyf4Z4/3O0pWMVbHE5tmWg5z5f9ajQtAPqFpQgHA+bJeL5Wodusng==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62321e3b-5435-4a5c-57a8-08d83df7a1b9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 13:08:25.5248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrbGTZBueY6uuYYrkbYQFIEXnLfJ6St7R+Faqur2PzfyAjCwwHP7OEehoAS2vRP4fNcHuEIbU/dnnC0mlZo83g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3451
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDIwMjAtMDgtMTEgdW0gNzo0NSBhLm0uIHNjaHJpZWIgSHVhbmcgUnVpOgo+IE9uIEZyaSwg
QXVnIDA3LCAyMDIwIGF0IDExOjAwOjM4UE0gKzA4MDAsIEt1ZWhsaW5nLCBGZWxpeCB3cm90ZToK
Pj4gQW0gMjAyMC0wOC0wNyB1bSA0OjI1IGEubS4gc2NocmllYiBIdWFuZyBSdWk6Cj4+PiBXZSBz
dGlsbCBoYXZlIGEgZmV3IGlvbW11IGlzc3VlcyB3aGljaCBuZWVkIHRvIGFkZHJlc3MsIHNvIGZv
cmNlIHJhdmVuCj4+PiBhcyAiZGdwdSIgcGF0aCBmb3IgdGhlIG1vbWVudC4KPj4+Cj4+PiBXaWxs
IGVuYWJsZSBJT01NVXYyIHNpbmNlIHRoZSBpc3N1ZXMgYXJlIGZpeGVkLgo+PiBEbyB5b3UgbWVh
biAiX3doZW5fIHRoZSBpc3N1ZXMgYXJlIGZpeGVkIj8KPiBZZXMuCj4gIAo+PiBUaGUgY3VycmVu
dCBpb21tdXYyIHRyb3VibGVzIGFzaWRlLCBJIHRoaW5rIHRoaXMgY2hhbmdlIGJyZWFrcyBleGlz
dGluZwo+PiB1c2VyIG1vZGUuIFRoZSBleGlzdGluZyBUaHVuayBpcyBub3QgcHJlcGFyZWQgdG8g
c2VlIFJhdmVuIGFzIGEgZEdQVS4gU28KPj4gdGhpcyBpcyBub3Qgc29tZXRoaW5nIHdlIHdhbnQg
dG8gZG8gaW4gYW4gdXBzdHJlYW0gTGludXgga2VybmVsIGNoYW5nZS4KPiBEbyB5b3UgbWVhbiBp
dCBtYXkgYnJlYWsgdGhlIHRodW5rIHdpdGhvdXQgc2V0dGluZyAiaXNfZGdwdSIgZmxhZyBpbiB0
aGUKPiBoc2FfZ2Z4aXBfdGFibGUgZm9yIHJhdmVuPwoKRXhhY3RseS4gVHJ5IHJ1bm5pbmcgeW91
ciBtb2RpZmllZCBLRkQgYWdhaW5zdCBhbiB1bmNoYW5nZWQgVGh1bmsuIElmIGl0CmZhaWxzLCB5
b3UgY2Fubm90IG1ha2UgdGhhdCBrZXJuZWwgY2hhbmdlLgoKCj4KPj4gSSBzdWdnZXN0IHVzaW5n
IHRoZSBpZ25vcmVfY3JhdCBtb2R1bGUgcGFyYW1ldGVyIGZvciB0aGUgd29ya2Fyb3VuZAo+PiBp
bnN0ZWFkLiBZb3UgbWF5IG5lZWQgdG8gZHVwbGljYXRlIHRoZSByYXZlbl9kZXZpY2VfaW5mbyBh
bmQgcGljayB0aGUKPj4gcmlnaHQgb25lIGRlcGVuZGluZyBvbiB3aGV0aGVyIGl0IGlzIGEgZEdQ
VSBvciBhbiBBUFUuIFRoZSBvbmx5Cj4+IGRpZmZlcmVuY2Ugd291bGQgYmUgdGhlIG5lZWRfaW9t
bXVfZGV2aWNlIG9wdGlvbi4gSWYgaWdub3JlX2NyYXQgaXMgc2V0LAo+PiB5b3UgY2FuIHN1cHBv
cnQgUmF2ZW4gYXMgYSBkR1BVIGFuZCByZXF1aXJlIGEgY29ycmVzcG9uZGluZyBUaHVuayBjaGFu
Z2UKPj4gdGhhdCBjb25kaXRpb25hbGx5IHN1cHBvcnQgUmF2ZW4gYXMgYSBkR1BVLgo+Pgo+PiBJ
IHRoaW5rIHN1Y2ggYSBjaGFuZ2Ugd291bGQgYWxzbyBiZSB0aGUgcmlnaHQgZGlyZWN0aW9uIGZv
ciBzdXBwb3J0aW5nCj4+IFJhdmVuIG1vcmUgdW5pdmVyc2FsbHkgaW4gdGhlIGZ1dHVyZS4gSXQg
Y2FuIGJlIGV4dGVuZGVkIHRvCj4+IGNvbmRpdGlvbmFsbHkgdHJlYXQgUmF2ZW4gYXMgYSBkR1BV
IGF1dG9tYXRpY2FsbHkgaW4gc29tZSBzaXR1YXRpb25zOgo+Pgo+PiAgICogYnJva2VuIG9yIG1p
c3NpbmcgQ1JBVCB0YWJsZQo+PiAgICogSU9NTVV2MiBkaXNhYmxlZAo+Pgo+PiBUaG9zZSBhcmUg
YWxsIHNpdHVhdGlvbnMgd2hlcmUgdGhlIGN1cnJlbnQgZHJpdmVyIGlzIGJyb2tlbiBhbnl3YXkg
KGFuZAo+PiBhbHdheXMgaGFzIGJlZW4pLCBzbyBpdCB3b3VsZCBub3QgYmUgYSBrZXJuZWwgY2hh
bmdlIHRoYXQgYnJlYWtzCj4+IGV4aXN0aW5nIHVzZXIgbW9kZS4KPiBPSywgSSB0aGluayBJIHVu
ZGVyc3RhbmQgaXQuIFdlIHNob3VsZCB1c2UgYSBwYXJhbWV0ZXIvZmxhZyBzdWNoIGFzCj4gaWdu
b3JlX2NyYXQgb3Igc29tZXRoaW5nIGVsc2UgdG8gaW5mb3JtIHRoZSB1c2VyIG1vZGUgd2hpY2gg
cGF0aCB3ZSBzaG91bGQKPiBnbywgdHJlYXQgaXQgYXMgZGdwdSBvciBhcHUuIFRoZW4gdGh1bmsg
Y2FuIGRldGVjdCB0aGUgZmxhZyBmcm9tIGtlcm5lbCB0bwo+IGtub3cgaG93IHRvIGhhbmRsZSB0
aGUgY2FzZS4gQW0gSSByaWdodD8KClVzZXIgbW9kZSBzaG91bGQgbm90IGxvb2sgYXQgdGhlIGln
bm9yZV9jcmF0IHBhcmFtZXRlci4gSXQgaXMgbm90IHBhcnQKb2YgdGhlIHVzZXIta2VybmVsIEFQ
SS4gVGhlIGtlcm5lbCBwYXJhbWV0ZXIgaXMgdG8gY29udHJvbCBrZXJuZWwKYmVoYXZpb3VyLiBU
aGUgcG9pbnQgaXMsIHRoYXQgdGhlIGRlZmF1bHQgYmVoYXZpb3VyIHNob3VsZCBub3QgY2hhbmdl
LApiZWNhdXNlIHRoYXQgd291bGQgYnJlYWsgZXhpc3RpbmcgdXNlciBtb2RlLgoKQSBmaXhlZCB1
c2VyIG1vZGUgY2FuIHVzZSBleGlzdGluZyB0b3BvbG9neSBpbmZvcm1hdGlvbiB0byBmaWd1cmUg
b3V0CndoaWNoIHdheSB0byBnby4gSWYgdGhlIENVcyBhcmUgaW4gdGhlIENQVSBub2RlLCBpdCdz
IGFuIEFQVS4gT3RoZXJ3aXNlCml0J3MgYSBkR1BVLgoKCj4KPj4gSW4gYWRkaXRpb24gdGhlIFRo
dW5rIGNvdWxkIGJlIGNoYW5nZWQgdG8gZG93bmdyYWRlIGEgUmF2ZW4gQVBVIHRvIGRHUFUKPj4g
KGJ5IHNwbGl0dGluZyB0aGUgQVBVIG5vZGUgaW50byBhIHNlcGFyYXRlIENQVSBhbmQgZEdQVSBu
b2RlKSBpZiBvdGhlcgo+PiBkR1BVcyBhcmUgcHJlc2VudCBpbiB0aGUgc3lzdGVtcyB0byBkaXNh
YmxlIGFsbCB0aGUgQVBVLXNwZWNpZmljIGNvZGUKPj4gcGF0aHMgYW5kIGFsbG93IGFsbCB0aGUg
R1BVcyB0byB3b3JrIHRvZ2V0aGVyIHNlYW1sZXNzbHkgd2l0aCBTVk0uCj4gVGhhbmtzISBMZXQg
bWUgbG9vayBhdCB0aGUgdGh1bmsgYWdhaW4uCj4KPiBGb3Igbm93LCBiYXNlZCBvbiB5b3VyIGNv
bW1lbnRzLCBJIHdvdWxkIGxpa2UgdG8gdXBkYXRlIHBhdGNoIGFzOgo+Cj4gLSBNb2RpZnkgdGhl
IGlnbm9yZV9jcmF0IHBhcmFtZXRlciBhcyB0cmlzdGF0ZTogInVzZSIsICJpZ25vcmUiLCBhbmQK
PiAgICJhdXRvIi4gVXN1YWxseSwgYnkgZGVmYXVsdCBpcyAiYXV0byA9IHVzZSIsIGJ1dCBpbiBz
b21lIHNwZWNpYWwgY2FzZQo+ICAgc3VjaCBhcyBpb21tdSB2MiBicm9rZW4gb3Igbm8gaW9tbXUg
djIgc3VwcG9ydCB5ZXQgKFJlbm9pciksIHdlIGhhdmUgdG8KPiAgIHNldCAiYXV0byA9IGlnbm9y
ZSIuIFRoZW4gdHJlYXQgaXQgYXMgImRncHUiLiBBbmQgaWYgQ1JBVCB0YWJsZSBpcwo+ICAgYnJv
a2VuL21pc3NpbmcsIHdlIHdpbGwgZmFsbCBiYWNrIHRvIHRyZWF0IGl0IGFzICJkZ3B1IiBhcyB3
ZWxsLgo+Cj4gV2hhdCBkbyB5b3UgdGhpbmsgb2YgaXQ/CgpJZiB0aGUgQ1JBVCBpcyBicm9rZW4v
bWlzc2luZyBvciBJT01NVXYyIGlzIG5vdCBlbmFibGVkLCAidXNlIiBpcyBub3QgYQp2ZXJ5IHVz
ZWZ1bCBzZXR0aW5nLiBJIHRoaW5rIHlvdSBvbmx5IG5lZWQgdHdvIHN0YXRlczogImF1dG8iIGFu
ZAoiaWdub3JlIi4gVGhhdCdzIHByZXR0eSBtdWNoIHdoYXQgd2UgaGF2ZSBub3cuIEV4Y2VwdCB3
ZSBuZWVkIG1vcmUKY29uZGl0aW9ucyB0byBub3QgdXNlIHRoZSBDUkFUIGluIHRoZSAiYXV0byIg
Y2FzZS4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKPgo+IFRoYW5rcywKPiBSYXkKPgo+PiBSZWdhcmRz
LAo+PiDCoCBGZWxpeAo+Pgo+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVh
bmdAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9j
cmF0LmMgICB8IDYgKysrKysrCj4+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rl
dmljZS5jIHwgNCArKy0tCj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9jcmF0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jCj4+
PiBpbmRleCA2YTI1MGY4ZmNmYjguLjY2ZDlmNzI4MGZlOCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMKPj4+IEBAIC0yMiw2ICsyMiw3IEBACj4+PiAgCj4+PiAg
I2luY2x1ZGUgPGxpbnV4L3BjaS5oPgo+Pj4gICNpbmNsdWRlIDxsaW51eC9hY3BpLmg+Cj4+PiAr
I2luY2x1ZGUgPGFzbS9wcm9jZXNzb3IuaD4KPj4+ICAjaW5jbHVkZSAia2ZkX2NyYXQuaCIKPj4+
ICAjaW5jbHVkZSAia2ZkX3ByaXYuaCIKPj4+ICAjaW5jbHVkZSAia2ZkX3RvcG9sb2d5LmgiCj4+
PiBAQCAtNzgxLDYgKzc4MiwxMSBAQCBpbnQga2ZkX2NyZWF0ZV9jcmF0X2ltYWdlX2FjcGkodm9p
ZCAqKmNyYXRfaW1hZ2UsIHNpemVfdCAqc2l6ZSkKPj4+ICAJCXJldHVybiAtRU5PREFUQTsKPj4+
ICAJfQo+Pj4gIAo+Pj4gKwkvKiBSYXZlbiBzZXJpZXMgd2lsbCBnbyB3aXRoIHRoZSBmYWxsYmFj
ayBwYXRoIHRvIHVzZSB2aXJ0dWFsIENSQVQgKi8KPj4+ICsJaWYgKGJvb3RfY3B1X2RhdGEueDg2
X3ZlbmRvciA9PSBYODZfVkVORE9SX0FNRCAmJgo+Pj4gKwkgICAgYm9vdF9jcHVfZGF0YS54ODYg
PT0gMHgxNykKPj4+ICsJCXJldHVybiAtRU5PREFUQTsKPj4+ICsKPj4+ICAJcGNyYXRfaW1hZ2Ug
PSBrbWVtZHVwKGNyYXRfdGFibGUsIGNyYXRfdGFibGUtPmxlbmd0aCwgR0ZQX0tFUk5FTCk7Cj4+
PiAgCWlmICghcGNyYXRfaW1hZ2UpCj4+PiAgCQlyZXR1cm4gLUVOT01FTTsKPj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMKPj4+IGluZGV4IGQ1ZTc5MGYwNDZiNC4uOTMx
NzljOTI4MzcxIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X2RldmljZS5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNl
LmMKPj4+IEBAIC0xMTYsNiArMTE2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBrZmRfZGV2aWNl
X2luZm8gY2Fycml6b19kZXZpY2VfaW5mbyA9IHsKPj4+ICAJLm51bV94Z21pX3NkbWFfZW5naW5l
cyA9IDAsCj4+PiAgCS5udW1fc2RtYV9xdWV1ZXNfcGVyX2VuZ2luZSA9IDIsCj4+PiAgfTsKPj4+
ICsjZW5kaWYKPj4+ICAKPj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGtmZF9kZXZpY2VfaW5mbyBy
YXZlbl9kZXZpY2VfaW5mbyA9IHsKPj4+ICAJLmFzaWNfZmFtaWx5ID0gQ0hJUF9SQVZFTiwKPj4+
IEBAIC0xMjgsMTMgKzEyOSwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGtmZF9kZXZpY2VfaW5m
byByYXZlbl9kZXZpY2VfaW5mbyA9IHsKPj4+ICAJLm51bV9vZl93YXRjaF9wb2ludHMgPSA0LAo+
Pj4gIAkubXFkX3NpemVfYWxpZ25lZCA9IE1RRF9TSVpFX0FMSUdORUQsCj4+PiAgCS5zdXBwb3J0
c19jd3NyID0gdHJ1ZSwKPj4+IC0JLm5lZWRzX2lvbW11X2RldmljZSA9IHRydWUsCj4+PiArCS5u
ZWVkc19pb21tdV9kZXZpY2UgPSBmYWxzZSwKPj4+ICAJLm5lZWRzX3BjaV9hdG9taWNzID0gdHJ1
ZSwKPj4+ICAJLm51bV9zZG1hX2VuZ2luZXMgPSAxLAo+Pj4gIAkubnVtX3hnbWlfc2RtYV9lbmdp
bmVzID0gMCwKPj4+ICAJLm51bV9zZG1hX3F1ZXVlc19wZXJfZW5naW5lID0gMiwKPj4+ICB9Owo+
Pj4gLSNlbmRpZgo+Pj4gIAo+Pj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qga2ZkX2RldmljZV9pbmZv
IGhhd2FpaV9kZXZpY2VfaW5mbyA9IHsKPj4+ICAJLmFzaWNfZmFtaWx5ID0gQ0hJUF9IQVdBSUks
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
