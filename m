Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D3CC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 09:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35B32086A
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 09:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1tvT5yUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35B32086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 737F289BF5;
	Tue,  4 Aug 2020 09:29:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7122A89BF5
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 09:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUkxSSxFjRWlycU2w+skao9vFPIFcIXL1lux4dVgILOiHfvkYfTsX/G636zKFN8FHIOHG/3p92nA7MtNhaYghJ13VJwDgihG9IE4VGiLhYS2gCoumTKD4A9VT7+sQ0L/TQ8FakcMU0bcnZTU3S4QmNAowytzC7pvQ/JqOUhMBNB0oI/1bQDEXrMHLwwza7rll6Q0QdCioA0r2LdQoYCRl28za+z/SkyYqpceLmSxMg8q+GCstIN0yZj11Z+vWe1KOkbMtHq3iAYF/lPSHoNynd4fjbbuUuNjxJTSmCSaJJNBhTgxOD+oIE5SIXEm7+6ja0P7N/PEYBu9PIndWvdKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1o5puGV/G5T6vZSj1NjWkCDN1+udE9nJfmOCYlUPsY=;
 b=KhLqkRvQl3U7r6yPldMd3Z7/bNTe+PBD2OTZsDEUfMV0qzOFdIL481Ghv4jsVsYYMSwUvArDf+OoGKu+RFA680UX6Ot5+uUW8ldzacFqWfWbjq+YwFzoDkS+FTxKBF2clFGrRtTdkSiDjubWg9ZVyMf39dVYPhzQF33BBLPZXvVaICZtiMfBOEdTDDfiw8aNFdNVRj+NuzH2tvgc56ZrUNG3+RLaNMGBW0PFJ50GB0PGhHMq7O65D2KwETkf0EfHLGuXrdUGpRxPFj/dK7BmrDQpmw3T0rWFXLoskTvhH3mT3PjTiUxqW0z3hd2oeXH/F04g73Ba1ZI8KLL4voo9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1o5puGV/G5T6vZSj1NjWkCDN1+udE9nJfmOCYlUPsY=;
 b=1tvT5yUHYpgO6j82f3u8HhMw9SMNiWBCgcBbto9qH89uOrGPLc+p6Fy3AacxHoEWdb7NsEBM6wontcnz61hGZa/u8VqW7S0ZLgeo34bxfXrUa6pwCbuOYLET0QZTU2yGt1/61EdBMQhOy6URo4x/OWuBNilR+DCfk6hY/W2Ly8A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3725.namprd12.prod.outlook.com (2603:10b6:208:162::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Tue, 4 Aug
 2020 09:29:14 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 09:29:14 +0000
Subject: Re: Enabling AMDGPU by default for SI & CIK
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <CAP+8YyHwMPPTiPAEs0CV+K+NSWtQmKQ-1hL0CmoGvUjA=P_1+Q@mail.gmail.com>
 <6964a9dc-00dc-6e72-f3ad-b4c80c49ec68@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1d4b8d20-402f-9a43-920f-ff8ca5ea62cc@amd.com>
Date: Tue, 4 Aug 2020 11:29:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <6964a9dc-00dc-6e72-f3ad-b4c80c49ec68@daenzer.net>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.13 via Frontend Transport; Tue, 4 Aug 2020 09:29:13 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5dcf6e75-73b2-4557-6133-08d83858da5e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3725:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3725218CF4A871DED95C6F91834A0@MN2PR12MB3725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +O+VFOPeB/+ZfCiCSzb4u3lG5cF6HSe3I4W0oxgHduaJUTQTbrLEWahMrPUiE0JCqCquI0x5loKruJeNdlQOvBuEfeuHNRFIhfF9eDyL9wgrQsJgfKo6Pon7NAYRJNdIKcejniVWvTh3DoBNoNiL+uypDRlRL9jMLBRhn0X7hZ148+KaFepxNe2TQA7fNIR146e6Rxp7scf0TIqyUnFA7p95aueMSKLRahBO49FOHW8EuqgKul5mFeQFJyb2WITjXqlv/qufbE2+THEY1PppL1Bzo48GKrpILqYaZlArYs47l2xChsIFN2405dARwZaTUwBihBoqm0BkM9FOQYwWOJKl5pr1kaYQd9QQDO+mRsvrEBQTlLM4W+uoxUzToh9K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(36756003)(16526019)(478600001)(186003)(2906002)(86362001)(31686004)(83380400001)(4744005)(66946007)(5660300002)(2616005)(66556008)(66476007)(52116002)(6666004)(6486002)(8676002)(54906003)(316002)(8936002)(4326008)(110136005)(31696002)(53546011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1JCgaLV1H5ATurSrJ6AuBRT0Uzh3p/2g/tKJuRYLXFZPmoAvE1he/+clZh3BcB0G7AsN9/pqHEyq6wCVTV/rxoqb5V4G0QAr+l5Ta+CPGexGngAayOw9DwztadEIxotSc5o7kioO+iRsyUCaHFDGVGikDSjIVTUDM8myrxhwpnLCHyKHYetVsZHTFf1zStjkHDGDa5YzJAY16r4G63HRMGkN7F0cAej/F23JY3m72VGYbz7w6g0dIvKb8aN+v1s5IRpQjR9+rEeC24gnVxWx+C1gdEXI8oANbuAHsGPTcqXvoo6yZ+1SxAHfASAVpSQ+oKMpwnDfAZkGrzmOe0OOV6bgj6IejKBdm+z3q8e6c6izaA26O+Hnl4rmUJ4OZz9ReEyt1zk3pu4ghvaz38vv9Tpjh4QtJ7lPR3nzFVChin2ORx6zvIsy92oHLhR9A/DhGad6pJVieFhif6Yq4UsuhUwIUTuHu9LZVzIzNRxfqd75grqlcQSVr2VPNfNZVZFA27Qe60SxvCv7dKzwy36VyKIRlq+NCxA4+tUWSW3RzKcMuA76yPI0mjzOSGiENt0D34p5f9vKHzrV8/qslajjzDPyCYaO4iNBuQpiJzhGBgb7gLRPuGH33Vy08QaEt2J5Axp3a7VtbsBCc3hqvjf+3G3AHsOyd5EZhBVXe5b/Lo5vVLxwFGZEzrBlullSNcsqZX3Wq4WUWY89nTCVsJIG4Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcf6e75-73b2-4557-6133-08d83858da5e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 09:29:14.8329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDw0R3Cpe1aHtksu3uV9Nqp5nC27zbn5YABFdgTtrZ7BDn+P3q3oXJaQiv2Pu4pp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3725
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDQuMDguMjAgdW0gMTA6Mzcgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPiBPbiAyMDIwLTA4
LTAzIDE6NDUgYS5tLiwgQmFzIE5pZXV3ZW5odWl6ZW4gd3JvdGU6Cj4+IEhpIGFsbCwKPj4KPj4g
Tm93IHRoYXQgd2UgaGF2ZSByZWNlbnRseSBtYWRlIHNvbWUgcHJvZ3Jlc3Mgb24gZ2V0dGluZyBm
ZWF0dXJlIHBhcml0eQo+PiB3aXRoIHRoZSBSYWRlb24gZHJpdmVyIGZvciBTSSwgSSdtIHdvbmRl
cmluZyB3aGF0IGl0IHdvdWxkIHRha2UgdG8KPj4gbWFrZSBBTURHUFUgdGhlIGRlZmF1bHQgZHJp
dmVyIGZvciB0aGVzZSBnZW5lcmF0aW9ucy4KPj4KPj4gQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCBB
TURHUFUgaGFzIGhhZCB0aGVzZSBmZWF0dXJlcyBmb3IgQ0lLIGZvciBhCj4+IHdoaWxlIGFscmVh
ZHkgYnV0IGl0IGlzIHN0aWxsIG5vdCB0aGUgZGVmYXVsdCBkcml2ZXIuIFdoYXQgd291bGQgaXQK
Pj4gdGFrZSB0byBtYWtlIGl0IHRoZSBkZWZhdWx0PyBXaGF0IGlzIG1pc3NpbmcgYW5kL29yIGJy
b2tlbj8KPiBUaGUgbWFpbiBibG9ja2VycyBJJ20gYXdhcmUgb2YgZm9yIENJSyBhcmU6Cj4KPiAx
KSBMYWNrIG9mIGFuYWxvZ3VlIGNvbm5lY3RvciBzdXBwb3J0IHdpdGggREMKPiAyKSBMYWNrIG9m
IEhETUkvRFAgYXVkaW8gc3VwcG9ydCB3aXRob3V0IERDCj4KPgo+IDEpIG1heSBhcHBseSB0byBT
SSBhcyB3ZWxsLgoKWWVzLCBhbmFsb2cgY29ubmVjdG9yIHN1cHBvcnQgaXMgdGhlIGJpZ2dlc3Qg
cHJvYmxlbS4KCkhETUkvRFAgYXVkaW8gaXMganVzdCBsYWNraW5nIGEgZmV3IHJlZ2lzdGVyIHBy
b2dyYW1taW5nIGFzIGZhciBhcyBJIAprbm93LCBidXQgYW5hbG9nIHN1cHBvcnQgbmVlZHMgdG8g
YmUgc29tZWhvdyBhZGRlZCB0byB0aGUgREMgZGVzaWduLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
