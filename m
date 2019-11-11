Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2769FC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 14:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8008214E0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 14:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8008214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D626E91B;
	Mon, 11 Nov 2019 14:35:52 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790075.outbound.protection.outlook.com [40.107.79.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B616E91B
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 14:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGvbM6kyQYb1s6AxpwrL5bug92MArdYSM/lBf2wnczktesTp56K71ZfS4tIOj91w4kgniCvBjrH8oq5QRNjGLB/HN0QMCqVUhNNvYmvadP6BabUv2QNPtPjRAw9s7HMDy257dcdDyvxpl9rEbrjyrA3lujLcMwPAKNKLw8dbXW92a2QKJG0+Uh8+1BUA1VnagMwwe8k9vR1bgPw9NVpsAjEma/8z6zhcBscjZrfNt6VOyJJw/Ocqh4CQ8Goghr8F+X671njsCaiaR0Fom5BgoA/rdJlGVpAI29Sdxp1kDdl1xvMUQNd5O8QUt6fUUKVl9gyz/U+el+2DM/2VIcSRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpKV7zed5KHOkiUVReeGcUTvIx+qykZ0i4oxz6VYb8I=;
 b=OOIKSNnw/6QC6j6kPweYpS85c8ZlqGU9VdS7GFAuh5l2umGvgm8uOHG2f+qn1A9hD3IDnd8bHJLPrGPcp4wwcJztzCC5uZNykIyBatWHI3oOBhmP4IeTJUUFqeqF2PbP5hkGQBtW/lGtqLv1Bsd5xAdpiKbyrdVYV226ksG+AXtgeBoxaUjN6GsMcLznq2Q7Uuy6xLcr+yKJXgtq9Ox1Ae2XraBRCopIkZBenXgnZ8CGbPbSOclOokuHmzpd5ExRlmu5yNy0Cpd/2AtCRpog91Rn98+W3TLAUl/dJ7lLOIz8jFvM6vI6J9T/+4L07tMmYmZxs5dlFFo9cBSCx/XvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3525.namprd12.prod.outlook.com (20.179.94.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Mon, 11 Nov 2019 14:35:49 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26%7]) with mapi id 15.20.2408.025; Mon, 11 Nov 2019
 14:35:49 +0000
Subject: Re: AMDGPU bug
To: Subsentient <subsentient@universe2.us>, amd-gfx@lists.freedesktop.org
References: <8a4cb7112cf6ed44581c838e84306e9c@universe2.us>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <464fc90a-2d58-20e3-559f-9d8e2b9c11f7@amd.com>
Date: Mon, 11 Nov 2019 09:35:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <8a4cb7112cf6ed44581c838e84306e9c@universe2.us>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::19) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c33e5c24-a0e5-42aa-5c1e-08d766b4721f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3525:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Antispam-PRVS: <BYAPR12MB3525C4FFE501871937147DCFEC740@BYAPR12MB3525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(316002)(8676002)(81156014)(36756003)(8936002)(81166006)(66946007)(4001150100001)(25786009)(6666004)(58126008)(99286004)(2486003)(5660300002)(23676004)(52116002)(31696002)(66476007)(66556008)(3480700005)(6246003)(86362001)(229853002)(6506007)(53546011)(50466002)(186003)(6512007)(230700001)(221733001)(11346002)(446003)(7736002)(26005)(305945005)(7116003)(76176011)(478600001)(47776003)(2906002)(966005)(31686004)(14454004)(386003)(6486002)(3846002)(65806001)(65956001)(486006)(66066001)(6436002)(2616005)(476003)(6306002)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3525;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8RGF1ySOKQtHqDnJkz5VRzm+e3WJBDqYjkKKT9xOsOIk+8HNaeWO5zspgVXjCE1qyAyquo2ZR4Xfy7B9KiVu2rBm1xZwhm7mbKvD/Jb+0m9F40UMJLYYCS6HQ4XPSMwBZ8diH3M10LTzt3ni12mQJYABe24nCKFQLsmqRiSye1lz4J9CCEIl3f7hWUfmHSHcck0wI1tUKHoKy6CQ65kBCC6W7fEtTCd7k47Ivi7AT0QRBEEn8pd/7z1Jv4k8nlysc75AwhiurYVI4OSikkEDv4DeD4tZahr8XoDcb7biRfjVUcSROFqgN/kLVFfM90jsEYziYmNQn4IVdSpJAdlwBWWNocuTzba4p9BA+pHu/eExUIepUm1OO7ZINrWGSvAXKlC0CVah/MF0ViDF32ElamTT9HxsDRdMUp0g4V3JCMCuvDjiaD1e0GkVqPx45lRwzosiEBnXClCFZcpHmNeS1GIwLfXYks3EKG0661Hs1tg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33e5c24-a0e5-42aa-5c1e-08d766b4721f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 14:35:49.4027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGZu0PNwjZTQJBaUVFw6Has15JCKicyRbqRjlvL4Hp59WbprAFOPfC6uZcqWZbVeYKotSD2e6CMO1KD4cQrdAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpKV7zed5KHOkiUVReeGcUTvIx+qykZ0i4oxz6VYb8I=;
 b=MsTVy28dkLUtU83qZX+/x5deU/EIRnisrw+2jinF50OLjziqLfD0Zfzz2/IBYz7kVaebol6Lzmq5c/rbtb05UsfCcbEnbG/ZzwlteC5ZtQedyEb3pih/OAsjNiIZZt24Ge6Y0PE86T9842ui8YaV4xML1/1+2VbIWMhV1zZOayg=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111143545.I_K-d1O2M_zqt5HXXV4sVORZo4RjmOEIEYVJw3AKMO0@z>

T24gMjAxOS0xMS0xMCA3OjAwIHAubS4sIFN1YnNlbnRpZW50IHdyb3RlOgo+IEhpLCBJJ3ZlIGJl
ZW4gZXhwZXJpZW5jaW5nIGEgYnVnIG9uIGtlcm5lbHMgNS4yIGFuZCB1cCB0aGF0IGFwcGFyZW50
bHkgCj4gaXMgdW5jb21tb24gYW5kL29yIHVuaW1wb3J0YW50IGVub3VnaCB0byBoYXZlIGJvdGgg
dGhyZWFkcyBtZW50aW9uaW5nIGl0IAo+IGRpZS4KPiAKPiBPbiBhIFJ5emVuIDMgMjIwMEcsIHRo
ZSBhbWRncHUgZHJpdmVyIGZhaWxzIHVwb24gbGlnaHRkbSBsb2dpbjoKPiAKPiBodHRwczovL2J1
Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE3NTIxODgKPiAKPiBJIHRob3VnaHQg
SSdkIGJyaW5nIHRoaXMgdG8geW91ciBhdHRlbnRpb24gYXMgdGhlIG90aGVycyByZXBvcnRpbmcg
dGhpcyAKPiBidWcgaGF2ZSBzbyBmYXIgYmVlbiBtZXQgd2l0aCBzaWxlbmNlLCBhbmQgdGhpcyBo
YXMgdHJhcHBlZCBtZSBhbmQgCj4gb3RoZXJzIG9uIHRoZSB1bnN1cHBvcnRlZCBrZXJuZWwgNS4x
LjIxLgo+IAo+IFRoYW5rcyBmb3IgeW91ciB0aW1lLgo+IAo+IAo+IAo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QK
PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+IAoKSSdtIG5vdCBzdXJlIHRoYXQgdGhl
IGJhY2t0cmFjZSBsaXN0ZWQgaXMgcGFydGljdWxhcmx5IHJlbGV2YW50IGZvciAKZGVzY3JpYmlu
ZyB3aGF0IGlzc3VlIGlzIGFjdHVhbGx5IG9jY3VycmluZywgYnV0IGlmIEkgaGFkIHRvIHRha2Ug
YSAKZ3Vlc3MgYmFzZWQgb24gdGhlIEFTSUMgYW5kIGtlcm5lbCB2ZXJzaW9uIEkgd291bGQgaW1h
Z2luZSB0aGF0IGl0J3MgClJhdmVuJ3MgZGlzcGxheWFibGUgRENDIHN1cHBvcnQgdGhhdCdzIGNh
dXNpbmcgeW91IGlzc3Vlcy4KCkkgYmVsaWV2ZSB5b3UnZCBuZWVkIHRvIGJlIHJ1bm5pbmcgbWVz
YSwgeGY4Ni12aWRlby1hbWRncHUgYW5kIHJ1bm5pbmcgCndpdGhvdXQgYSBjb21wb3NpdG9yIGlu
IHlvdXIgZGVza3RvcCBtYW5hZ2VyLiBEb2VzIHRoaXMgZGVzY3JpYmUgeW91ciBzZXR1cD8KCklm
IHlvdSBjYW4gYmlzZWN0IHRoYXQgd291bGQgaGVscCBuYXJyb3cgdGhpbmdzIGRvd24gZnVydGhl
ci4gVGhlIGJpc2VjdCAKY29tbWl0IHdvdWxkIGxpa2VseSBiZSBvbmUgdGhhdCdzIGp1c3QgY2hh
bmdpbmcgdGhlIGFtZGdwdSB2ZXJzaW9uIApudW1iZXIgaWYgaXQncyBEQ0MgKHNpbmNlIG1lc2Eg
Y2hlY2tzIHRoYXQgYmVmb3JlIGRlY2lkaW5nIHRvIGVuYWJsZSAKZGlzcGxheWFibGUgRENDKS4K
Ck5pY2hvbGFzIEthemxhdXNrYXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
