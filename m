Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448FCC5ACBF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFBC20746
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2yQzDbbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFBC20746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF876E9CB;
	Fri, 13 Mar 2020 14:07:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E95616E9CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 14:07:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHWN4s6U8Ia2+REoJe+aZidkSqoFqh3S97ts6WK3BA3YfrQAfy+ePCu0H3JpqZKeJJaxQ6qp/iDoxE1GJOwiQasg/75+AJAg+aQPrTx4uCw7+dyyD81VIkuTOp3tzJZe+SNESfINpCRbovxbTKIi349DRxamSKK8jDFeY9w9qDjuignjdCcPBVZgvO2/0u8AiE/lz3BX41CT3dXHL5cCTqwN0jioiXcSteLVCcrvZA9C66QqN/+YfEm3CjkH2bllWwgBN0WW7H2EYiLbtoctMcw+lqbvpYVgu630msZk4ZgQFjKyEBdo0C4/UBDyLEyxCLAmCreiTP9iNVJ/wMMglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A65QSBTXdH0eY3s2QB34y8zNjKC5B03XcHEOJHAKxM=;
 b=fEtZ4YAh1yhz6h1+/d8rVmrlxyCFWtIjJXKq6gLN3u8zjrTbKWozGGq9Hn4tywoIW9lJ3xQ+xqBxs8IbGDUS9bcLB/kr9Zv12K7rxvO31/vw1xrGWE5L/dZ3K4Hs+E8wZndFicFk+P0g7fAT3304H+0S1g3RGUQe/33TRj2lbL1MmAp6EAr9nv/gQJW1Oy2qNw4UFwbZqe8Vi8r3y9/XXtwn9qvUtvXC9L3PCIqmjQ2P9ZPI2mKxXEeOsRxwtw99lc4eZoWUQITBFWPFOpK6ZR0BpBEfFSh0ZaIZ3jtGnUP3FVzHDUTZ8F3xVnWSNaztAY5USvgGM0zyB862nqyy4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A65QSBTXdH0eY3s2QB34y8zNjKC5B03XcHEOJHAKxM=;
 b=2yQzDbbz+f0ymibmpG7Rx9cYZZZAFloVen1HHOfR+/MfHq4OCGihdI1nlzSRWT8/MyG08NoKB/NFWMSHU3IfYpu/YezaE7dqPmJc2Fts9VTXusUvV5g/uCWS2JR56HbGTj4LzAxEwHG/0ujkGzoXGikp4SGj0u9Yh67FOZmFE8g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1769.namprd12.prod.outlook.com (2603:10b6:3:10f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Fri, 13 Mar 2020 14:07:38 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2814.018; Fri, 13 Mar 2020
 14:07:38 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: disable gpu_sched load balancer for vcn
 jobs
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200313135953.68418-1-nirmoy.das@amd.com>
 <20200313135953.68418-2-nirmoy.das@amd.com>
 <338f39d6-fd4c-0823-4da8-e81115ee9c60@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <2e4ebfe5-a0a5-025c-6af2-a5ab61620e89@amd.com>
Date: Fri, 13 Mar 2020 15:11:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <338f39d6-fd4c-0823-4da8-e81115ee9c60@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR07CA0014.eurprd07.prod.outlook.com
 (2603:10a6:205:1::27) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f29:a900:db15:8106:d933:a960]
 (2003:c5:8f29:a900:db15:8106:d933:a960) by
 AM4PR07CA0014.eurprd07.prod.outlook.com (2603:10a6:205:1::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.10 via Frontend Transport; Fri, 13 Mar 2020 14:07:36 +0000
X-Originating-IP: [2003:c5:8f29:a900:db15:8106:d933:a960]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 94ea9c82-1e2e-473d-1c15-08d7c757e306
X-MS-TrafficTypeDiagnostic: DM5PR12MB1769:|DM5PR12MB1769:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1769010DFDFD4DE80F78CAAF8BFA0@DM5PR12MB1769.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(199004)(478600001)(316002)(4326008)(5660300002)(2906002)(110136005)(81166006)(6666004)(52116002)(81156014)(53546011)(31686004)(6486002)(36756003)(31696002)(8676002)(66574012)(8936002)(186003)(66946007)(2616005)(66476007)(66556008)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1769;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59UU0x6MbWFZlc/Q4jHrdGW/xWqbTemfga1kmQA/0kAFk5dO9/79Oa1kN82vBJe5fitpv2ARJSpUlbmwQVcWXe/8uOS2NM7js20jDTGT1mBgMNLZQRg1PbsnMscqPzXCkKvcd8vYHLx2xEXFc38vKaEo4Dewpaw6lQcCAxhO9siGMToZOWGEZjteaWavNjkxuI1JH3LkcZ5/HYsFBZ+U5s02YnqhfeKLEdWSpU+YqvcXWLXOc1fBr2ohSYkNQ+Y0Kjl4+xoo3N3qzsuYql643j+7DlemC7rH/Kn+JAcHmbzNO5633msmPLRtXHp845zvsabekS5PbFHbi+cKY2Y51Wjslofvz2AFJFWelHfr0JpFOyaQnYaO2P1sIgTSZFI9y49wblry7wM3q6FKo//rwK2BBY7BK/umRh9YjvAkOh07eDWf4jZ0y5//RXk3Yo6M
X-MS-Exchange-AntiSpam-MessageData: 0Vt/Gg8C5icAHHtu4FlKCdnNPau6UCxG1M441zhFClQYcpVR/t5J8cvsLfHevoR8exBT1ApYY4Vz+VGSMvZhD1o+EB1NcsiFGoJUioBNfKsptMBPlO1iZnqa2/rIEqJVoC434gC686DndiQLTyWegSgcu0FCfpk9tswbMq2+jJmT/DMdKdsYCpPzGpqtG+xL6Kd3DVvSyVHcPxxJXQ6U5g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ea9c82-1e2e-473d-1c15-08d7c757e306
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 14:07:38.2774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC8XzJvakbt7S/C5qtp0aEq/nJjetklAfHPcXyoFefTzvYOvlIivfNA3L3UC2+CcrpwvDCLP5F2fPMzYxslBPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1769
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
Cc: alexander.deucher@amd.com, Boyuan.Zhang@amd.com, nirmoy.das@amd.com,
 Leo.Liu@amd.com, James.Zhu@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDMvMTMvMjAgMzowMyBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAxMy4wMy4y
MCB1bSAxNDo1OSBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IFZDTiBIVyBkb2Vzbid0IHN1cHBvcnQg
ZHluYW1pYyBsb2FkIGJhbGFuY2Ugb24gbXVsdGlwbGUgaW5zdGFuY2VzCj4+IGZvciBhIGNvbnRl
eHQuIFRoaXMgcGF0Y2ggaW5pdGlhbGl6ZXMgVk5DIGVudGl0aWVzIHdpdGggb25seSBvbmUKPj4g
ZHJtX2dwdV9zY2hlZHVsZXIgcGlja2VkIGJ5IGRybV9zY2hlZF9waWNrX2Jlc3QoKS4gUGlja2lu
ZyBhCj4+IGRybV9ncHVfc2NoZWR1bGVyIHVzaW5nIGRybV9zY2hlZF9waWNrX2Jlc3QoKSBlbnN1
cmVzIHRoYXQgd2UKPj4gZG8gbG9hZCBiYWxhbmNlIGFtb25nIG11bHRpcGxlIGNvbnRleHRzIGJ1
dCBub3QgYW1vbmcgbXVsdGlwbGUKPj4gam9icyBpbiBhIGNvbnRleHQuCj4+Cj4+IFNpZ25lZC1v
ZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyB8IDcgKysrKysrLQo+PiDCoCAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgCj4+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4+IGluZGV4IGZhNTc1YmRjMDNjOC4u
OGYxZTNjMDU4MTJlIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfY3R4LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0
eC5jCj4+IEBAIC0xMjEsMTIgKzEyMSwxNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jdHhfaW5pdF9l
bnRpdHkoc3RydWN0IAo+PiBhbWRncHVfY3R4ICpjdHgsIGNvbnN0IHUzMiBod19pcCwgY29uc3QK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnVtX3NjaGVkcyA9IDE7Cj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBBTURH
UFVfSFdfSVBfVkNOX0RFQzoKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2NoZWRzID0gYWRl
di0+dmNuLnZjbl9kZWNfc2NoZWQ7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9z
Y2hlZHMgPcKgIGFkZXYtPnZjbi5udW1fdmNuX2RlY19zY2hlZDsKPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc2NoZWQgPSBkcm1fc2NoZWRfcGlja19iZXN0KGFkZXYtPnZjbi52Y25fZGVjX3Nj
aGVkLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG51bV9zY2hlZHMpOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzY2hlZHMgPSAm
c2NoZWQ7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgY2FzZSBBTURHUFVfSFdfSVBfVkNOX0VOQzoKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc2NoZWRzID0gYWRldi0+dmNuLnZjbl9lbmNfc2NoZWQ7Cj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG51bV9zY2hlZHMgPcKgIGFkZXYtPnZjbi5udW1fdmNuX2VuY19zY2hl
ZDsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2NoZWQgPSBkcm1fc2NoZWRfcGlja19iZXN0
KGFkZXYtPnZjbi52Y25fZW5jX3NjaGVkLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9zY2hlZHMpOwo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzY2hlZHMgPSAmc2NoZWQ7Cj4KPiBudW1fc2NoZWRzIG5lZWQgdG8gYmUgc2V0
IHRvIDEgaGVyZSBhbmQgYWJvdmUuCgoKUmlnaHQgb3IgZWxzZSBpdCB3b3VsZCd2ZSBjYXVzZWQg
TlVMTCBleGNlcHRpb24uCgpUaGFua3MsCgpOaXJtb3kKCgo+Cj4gQW5kIG1heWJlIGFkZCBhIHNl
cGFyYXRlIHBhdGNoIHRvIGZpeCB0aGUgaW5kZW50YXRpb24gb2YgdGhlIGNhc2UgbGFiZWxzLgo+
Cj4gQ2hyaXN0aWFuLgo+Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBBTURHUFVfSFdfSVBfVkNOX0pQRUc6Cj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHNjaGVkcyA9IGFkZXYtPmpwZWcuanBlZ19zY2hlZDsKPgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
