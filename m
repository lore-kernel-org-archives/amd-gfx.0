Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07E9C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 15:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7C620897
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 15:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D3qkXiJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7C620897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6489B6E512;
	Wed, 19 Aug 2020 15:28:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3351F6E507
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 15:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgkAwLzPm/1o581hfFIGqI2JMF2OEO/JOg3dgsNFvImrNGOTxohuLacyZyko4ipj1dOlRDrDlfzzIY24TIlPoFCey0RGBFHzS9c9fgJxHxU0le35lybqAaeL344wxdUJDg5cJ/nUCMMVriTDBAC3/wFbqcndKKlRxp/VcWj8OD/ML5lsre1tu/ab9u7tzQ3z1xA76STBbbcQ3FvmNC10f6Cxhi5UR9io5D+V+ebYTc1CiEorQENbuw0X0EF1i2ENyYl9TR2vv7xWrcwUzzgeCfEtDVRhdq/roqWam34cNJQJCFL/cT4pGx2Up12dbzq3nBy0bXUPMZTUFqsfLpEn7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmjsTGsO1ICeJ596chWOxCBaZGlYrvRGFRcEj3N0Ijc=;
 b=el90npWpuuBs4+jPjCadEXEzA/+5uD/BCplrqE4R0iEouG+LfRIfp5isRFWMmQCFm/R9gc5ofzOkg/MI6BKI+6yfddJzgWbdd/EnBEByV3OflsDniiRuePEU3XTXafd66CiflOjG6JdtwRDWWo8gYFQlE4qDcryD9XulwdVVUL7+oZyczOYtsUAB9RmR+dfejMZe0zDoMTRF1UAR9TC3/GyW73WMsNblxCngdddFEanrsVt1PTa2zR2fM2jHvwewLTsvEsu/Ljgp2s7v6dOSHRNlYtDOvfJ4kimap0qN5W8ZJ/OoRVy3DXh5WCtmRXjNF8Z3HWoFZnrlPFfC1dS+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmjsTGsO1ICeJ596chWOxCBaZGlYrvRGFRcEj3N0Ijc=;
 b=D3qkXiJspmAq/fVqVk3m5oU5DapbSEpN7gVDkNxKhqK1kACptBpPpiuGfEGSTlbheLemsA6nxl7W3ShwRPJWPET0DMujkQGLgvRd7iZJRe14yCayzxTCzqUBKRjgfhTjEttMM3K4MBa4+dFH7MzZtEnCEqw1JWiyE9oY0ORbiD8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Wed, 19 Aug
 2020 15:28:03 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3305.025; Wed, 19 Aug 2020
 15:28:03 +0000
Subject: Re: [PATCH] drm/amdgpu: remap hdp coherency registers for vi on
 carrizo
To: Huang Rui <ray.huang@amd.com>
References: <20200819142816.215812-1-ray.huang@amd.com>
 <197df017-d2a2-551a-7722-5f3c45de8544@amd.com>
 <20200819150132.GA215900@hr-amd>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <4120f130-f068-f90d-a76e-b5717ad22780@amd.com>
Date: Wed, 19 Aug 2020 11:28:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200819150132.GA215900@hr-amd>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 15:28:03 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: efd92d82-5e30-4d71-551a-08d8445476dd
X-MS-TrafficTypeDiagnostic: SA0PR12MB4525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4525C83D69912D149A58CEB7925D0@SA0PR12MB4525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKc18/GIDOidBvFuvcJMZuPc5PRtIPW7eFC8J0r5/iYV9Am665uHmSC4lgndLjl831e6FgTQiCCxYj0Ov362rNQVlNHf1Pg9M41Gp+j5XRmLrOWgFFxq3QF4uC0S4q907UujjZXlYfxpQ66VTbT/49BKbvCDASaUnNxa0k1hNS5ZAZ7herTjBXCVNhw90JtBQGLfAVXueBPQJuRDeyd9foxhJ0GOdeSXaL0d4CKtdcxmUaFy0G54RDxnBN1Hevx9h4YUxhMsJOHp55wiUQmwriW0rNybcV0YwrQUkVq0r11w7kEGMNgGDZvLZB7rV7/P4WQDHKz1sYzsabfbH+bWmDtlh6cgUNWsxtRFH09phsn3iGCuQWDlx4GEC/TJTUQKB5DV+fmEwYUn6QLUH2H/eclrsX8tg3UEcjLPM5xc2/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(31686004)(4326008)(52116002)(2906002)(110011004)(37006003)(66476007)(66946007)(86362001)(16576012)(54906003)(26005)(8936002)(956004)(83380400001)(186003)(6486002)(316002)(44832011)(36756003)(8676002)(2616005)(31696002)(6636002)(66556008)(6862004)(5660300002)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: YYgcxteGTRbXr01ZCYuXf1kUd0M7gVjuX8/Q+2YLGw6qCe/LD3leRdnJrCFeNmQjZiHJvDO0SoeFUYhoXI5azA1OMtGBYtLCd8444RQv72uShWK1wLsTujgGQQOYoBD0lthGKy5bzXOuNDHfnhDxZDYsoxOvS1nfWWI4OXmHI9Druox+gc8fFu9b5PeNYO4tbn4WGVPnOPgWOVZoTPJHy8ecNR2fGzUqskHtZ/1Ktl+x15HFFJ1gEQYNHqVK12lUHYAD5XGR4RYdfHuJSaEWdBpKgaHe2FP5FxDG4b5u8/K2Holq8A/uM05tXgnLxU78EL7kJ/VyRzyzA5+3LFF+bJYVg6B9y/PnelgWhFASJCQtCVg7lDAnXcHO0GYRwsYd7oxntb4+uSmP/EUz/92xb1BwuCOngNC7oFAqtP8tW3c68p3m0vTo5jONbyr5pF1uq9ZZG6ZozMkWkyQZXNmCkPZqW/aN4awW/ezWq99OGY19mQ9gaypJtk1hjS2hhTSJ8XEPDqvqAPuN6SeH4keCaD55a8OfCMWCm3CC50mnYigtsp+R1JmZIcDTI+OK/1ph5kwZF7rS1vowUyHjzxJxFAVamBsfdGwN+HSZTCX/MHsaGj4myzPuLLznq18zScWEkbwBJjt/s7ht57YeWSH2kA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd92d82-5e30-4d71-551a-08d8445476dd
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 15:28:03.7182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/4Bak/+bocvuUv8sANMZ1tCc7wwt5tftm+dy4OcJPqG2w7YJX5Rz75ppVPywjEUEu/28NAjfMGHhVv+D7VgwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMC0wOC0xOSB1bSAxMTowMSBhLm0uIHNjaHJpZWIgSHVhbmcgUnVpOgo+IE9uIFdlZCwg
QXVnIDE5LCAyMDIwIGF0IDEwOjM2OjA1UE0gKzA4MDAsIEt1ZWhsaW5nLCBGZWxpeCB3cm90ZToK
Pj4gSnVzdCBmb3IgQ2Fycml6bywgSERQIGZsdXNoaW5nIGRvZXNuJ3QgbWFrZSBhIGxvdCBvZiBz
ZW5zZSBiZWNhdXNlIHdlCj4+IGRvbid0IHVzZSBIRFAgdG8gYWNjZXNzIHRoZSBmcmFtZWJ1ZmZl
ci4KPiBPSywgc28gc29jMTUgYW5kIGxhdGVyIG5lZWQgdXNlIEhEUCB0byBhY2Nlc3MgdGhlIGZy
YW1lYnVmZmVyIGZyb20gdXNlcgo+IHNwYWNlLiBNYXkgSSBrbm93IHdoeT8KCk9uIGFsbCBkR1BV
cyB3ZSBhY2Nlc3MgZnJhbWVidWZmZXIgdGhyb3VnaCBIRFAuIE9uIEFQVXMgd2UgYWNjZXNzIHRo
ZQpjYXJ2ZS1vdXQgZGlyZWN0bHkgaW4gc3lzdGVtIG1lbW9yeSBhbmQgZG9uJ3QgZ28gdGhyb3Vn
aCB0aGUgUENJZSBCQVIKYW5kIEhEUC4KClRoZSBNTUlPLXJlbWFwcGluZyBpcyBkb25lIHRvIGFs
bG93IHVzZXIgbW9kZSB0byBpbml0aWF0ZSBIRFAgZmx1c2hlcy4gSQpkb24ndCByZW1lbWJlciB3
aHkgd2Ugb25seSBlbmFibGUgdGhpcyBvbiBTT0MxNS4gTWF5YmUgd2UgZGlkbid0IGtub3cKdGhp
cyB3YXMgYXZhaWxhYmxlIG9uIG9sZGVyIEFTSUNzLCBvciBtYXliZSB0aGUgdXNlciBtb2RlIGNv
ZGUgdG8gdXNlCnRoaXMgY2FwYWJpbGl0eSB3YXNuJ3QgaW1wbGVtZW50ZWQgb24gR0ZYdjguCgoK
Pgo+PiBUaGUgY29kZSB5b3UncmUgY2hhbmdpbmcgZG9lc24ndCBsb29rIENhcnJpem8tc3BlY2lm
aWMsIGJ1dCBWSS1zcGVjaWZpYy4KPj4gU28gaXQgd291bGQgYWZmZWN0IEZpamkgYW5kIFBvbGFy
aXMgYXMgd2VsbC4gV2UgYWxyZWFkeSBzdXBwb3J0IEZpamkgYW5kCj4+IFBvbGFyaXMgZEdQVXMg
d2l0aCBLRkQsIGFwcGFyZW50bHkgd2l0aG91dCByZW1hcHBpbmcgSERQIHJlZ2lzdGVycy4gV2h5
Cj4+IGlzIHRoaXMgY2hhbmdlIG5vdyBuZWVkZWQgZm9yIENhcnJpem8/Cj4gQmVjYXVzZSBJIGZv
dW5kIHRodW5rIHdpbGwgYWxsb2NhdGUgdGhlIG1lbW9yeSB3aXRoIGZsYWcKPiBLRkRfSU9DX0FM
TE9DX01FTV9GTEFHU19NTUlPX1JFTUFQIG9uY2UgSSBzZXQgaWdub3JlX2NyYXQuIFRoZW4gd2Ug
ZmFpbGVkCj4gdG8gYWxsb2NhdGUgdGhlIGJ1ZmZlci4KCkkgdGhpbmsgdGhlIHNhbWUgd291bGQg
aGFwcGVuIG9uIEZpamkgYW5kIFBvbGFyaXMuIENhbiB5b3UgY29uZmlybSB0aGlzPwoKSSdtIG5v
dCBvcHBvc2VkIHRvIHRoaXMgY2hhbmdlLCBidXQgdGhlIGp1c3RpZmljYXRpb24gc2hvdWxkIG5v
dCBiZQpDYXJyaXpvLCBidXQgYSBtb3JlIGdlbmVyYWwgR0ZYdjggc3RhdGVtZW50LgoKUmVnYXJk
cywKwqAgRmVsaXgKCgo+Cj4gVGhhbmtzLAo+IFJheQo+Cj4+IFJlZ2FyZHMsCj4+IMKgIEZlbGl4
Cj4+Cj4+IEFtIDIwMjAtMDgtMTkgdW0gMTA6MjggYS5tLiBzY2hyaWViIEh1YW5nIFJ1aToKPj4+
IENhcnJ6aW8gYWxzbyBuZWVkcyByZW1hcCBIRFBfTUVNX0NPSEVSRU5DWV9GTFVTSF9DTlRMIGFu
ZAo+Pj4gSERQX1JFR19DT0hFUkVOQ1lfRkxVU0hfQ05UTCB0byB0aGUgZW1wdHkgcGFnZSBpbiBt
bWlvIHNwYWNlLiBUaGVuIHVzZXIKPj4+IG1vZGUgaXMgYWJsZSB0byBkbyBmbHVzaCBoZHAgYXMg
d2VsbC4gSXQgd2lsbCB1c2VkIGZvciBmb3JjZSBkZ3B1IHBhdGgKPj4+IG9uIGNhcnJpem8uCj4+
Pgo+Pj4gU2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPj4+IC0t
LQo+Pj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMgfCAxOCArKysrKysrKysrKysr
KystLS0KPj4+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmkuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMKPj4+IGluZGV4IGFmODk4NmE1NTM1NC4u
YTU0MGZlN2NmZmM3IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dmkuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmkuYwo+Pj4gQEAgLTc4
LDYgKzc4LDcgQEAKPj4+ICAjaW5jbHVkZSAiZGNlX3ZpcnR1YWwuaCIKPj4+ICAjaW5jbHVkZSAi
bXhncHVfdmkuaCIKPj4+ICAjaW5jbHVkZSAiYW1kZ3B1X2RtLmgiCj4+PiArI2luY2x1ZGUgPHVh
cGkvbGludXgva2ZkX2lvY3RsLmg+Cj4+PiAgCj4+PiAgLyoKPj4+ICAgKiBJbmRpcmVjdCByZWdp
c3RlcnMgYWNjZXNzb3IKPj4+IEBAIC05NDQsMTAgKzk0NSwxMCBAQCBzdGF0aWMgdWludDMyX3Qg
dmlfZ2V0X3Jldl9pZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4+ICBzdGF0aWMgdm9p
ZCB2aV9mbHVzaF9oZHAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVf
cmluZyAqcmluZykKPj4+ICB7Cj4+PiAgCWlmICghcmluZyB8fCAhcmluZy0+ZnVuY3MtPmVtaXRf
d3JlZykgewo+Pj4gLQkJV1JFRzMyKG1tSERQX01FTV9DT0hFUkVOQ1lfRkxVU0hfQ05UTCwgMSk7
Cj4+PiAtCQlSUkVHMzIobW1IRFBfTUVNX0NPSEVSRU5DWV9GTFVTSF9DTlRMKTsKPj4+ICsJCVdS
RUczMigoYWRldi0+cm1taW9fcmVtYXAucmVnX29mZnNldCArIEtGRF9NTUlPX1JFTUFQX0hEUF9N
RU1fRkxVU0hfQ05UTCkgPj4gMiwgMSk7Cj4+PiArCQlSUkVHMzIoKGFkZXYtPnJtbWlvX3JlbWFw
LnJlZ19vZmZzZXQgKyBLRkRfTU1JT19SRU1BUF9IRFBfTUVNX0ZMVVNIX0NOVEwpID4+IDIpOwo+
Pj4gIAl9IGVsc2Ugewo+Pj4gLQkJYW1kZ3B1X3JpbmdfZW1pdF93cmVnKHJpbmcsIG1tSERQX01F
TV9DT0hFUkVOQ1lfRkxVU0hfQ05UTCwgMSk7Cj4+PiArCQlhbWRncHVfcmluZ19lbWl0X3dyZWco
cmluZywgKGFkZXYtPnJtbWlvX3JlbWFwLnJlZ19vZmZzZXQgKyBLRkRfTU1JT19SRU1BUF9IRFBf
TUVNX0ZMVVNIX0NOVEwpID4+IDIsIDEpOwo+Pj4gIAl9Cj4+PiAgfQo+Pj4gIAo+Pj4gQEAgLTEw
ODUsOCArMTA4NiwxMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9hc2ljX2Z1bmNzIHZp
X2FzaWNfZnVuY3MgPQo+Pj4gIAo+Pj4gIHN0YXRpYyBpbnQgdmlfY29tbW9uX2Vhcmx5X2luaXQo
dm9pZCAqaGFuZGxlKQo+Pj4gIHsKPj4+ICsjZGVmaW5lIE1NSU9fUkVHX0hPTEVfT0ZGU0VUICgw
eDgwMDAwIC0gUEFHRV9TSVpFKQo+Pj4gIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKPj4+ICAKPj4+ICsJYWRldi0+cm1taW9fcmVt
YXAucmVnX29mZnNldCA9IE1NSU9fUkVHX0hPTEVfT0ZGU0VUOwo+Pj4gKwlhZGV2LT5ybW1pb19y
ZW1hcC5idXNfYWRkciA9IGFkZXYtPnJtbWlvX2Jhc2UgKyBNTUlPX1JFR19IT0xFX09GRlNFVDsK
Pj4+ICAJaWYgKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSkgewo+Pj4gIAkJYWRldi0+c21jX3Jy
ZWcgPSAmY3pfc21jX3JyZWc7Cj4+PiAgCQlhZGV2LT5zbWNfd3JlZyA9ICZjel9zbWNfd3JlZzsK
Pj4+IEBAIC0xMzMyLDYgKzEzMzYsMTIgQEAgc3RhdGljIGludCB2aV9jb21tb25fc3dfZmluaSh2
b2lkICpoYW5kbGUpCj4+PiAgCXJldHVybiAwOwo+Pj4gIH0KPj4+ICAKPj4+ICtzdGF0aWMgdm9p
ZCB2aV9yZW1hcF9oZHBfcmVnaXN0ZXJzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4g
K3sKPj4+ICsJV1JFRzMyKG1tUkVNQVBfSERQX01FTV9GTFVTSF9DTlRMLCBhZGV2LT5ybW1pb19y
ZW1hcC5yZWdfb2Zmc2V0ICsgS0ZEX01NSU9fUkVNQVBfSERQX01FTV9GTFVTSF9DTlRMKTsKPj4+
ICsJV1JFRzMyKG1tUkVNQVBfSERQX1JFR19GTFVTSF9DTlRMLCBhZGV2LT5ybW1pb19yZW1hcC5y
ZWdfb2Zmc2V0ICsgS0ZEX01NSU9fUkVNQVBfSERQX1JFR19GTFVTSF9DTlRMKTsKPj4+ICt9Cj4+
PiArCj4+PiAgc3RhdGljIGludCB2aV9jb21tb25faHdfaW5pdCh2b2lkICpoYW5kbGUpCj4+PiAg
ewo+Pj4gIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqKWhhbmRsZTsKPj4+IEBAIC0xMzQyLDYgKzEzNTIsOCBAQCBzdGF0aWMgaW50IHZpX2NvbW1v
bl9od19pbml0KHZvaWQgKmhhbmRsZSkKPj4+ICAJdmlfcGNpZV9nZW4zX2VuYWJsZShhZGV2KTsK
Pj4+ICAJLyogZW5hYmxlIGFzcG0gKi8KPj4+ICAJdmlfcHJvZ3JhbV9hc3BtKGFkZXYpOwo+Pj4g
KwkvKiByZW1hcCBoZHAgcmVnaXN0ZXJzICovCj4+PiArCXZpX3JlbWFwX2hkcF9yZWdpc3RlcnMo
YWRldik7Cj4+PiAgCS8qIGVuYWJsZSB0aGUgZG9vcmJlbGwgYXBlcnR1cmUgKi8KPj4+ICAJdmlf
ZW5hYmxlX2Rvb3JiZWxsX2FwZXJ0dXJlKGFkZXYsIHRydWUpOwo+Pj4gIApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
