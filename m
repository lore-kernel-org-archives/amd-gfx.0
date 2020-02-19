Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCED9C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 16:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3A824654
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 16:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Zl4M661w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3A824654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 429676E837;
	Wed, 19 Feb 2020 16:34:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B96A6E837
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 16:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoBbaoRpTVRY63vIfHdKJI4JhQq3k0/T5ROPRcEhHFIXLDHzumE5lQwhUDLsqcwX4qsgY/9lnf+Pze/jEzJh8ROuGe0xpiBD0bqqqB1bwyvSOy8FDaRxiXfN0ajKES4mLdGVvyqs/GWMnAPjsiWF4q7OqX5U7GqyuxgLnxFPssV5XX8XgJgdETW002IPxV0XRm1YVvk2i+GCfFZeasSEqBDjuFhG/dwFjg00E60ulW/7Fc8CHusfpW+rALfyEpT3YEyqJoMdTgDZSoq5tMLu1AQsVr5A7mJbwxs5crVUiV+e6AqlmW9s3eM3wAAlPw5MscKMcGwJl2F53zoI6qwO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXW2jPgmt49DpzkjrKqxUiAuet6KkJ3Dzp4YVV043mU=;
 b=Gu1dAv1e5iZnPyl50SfaN2C/qoQjn9pDMPsv+BEddCCa33x/jcInDWLvLN/ocIWuKeeJy8io38ne3ge0Qd9fKsXyyDaJO4FXTbO3vRuMkNGbVDTGiTVGVXY85X9XewsjWD4/E2KGQJSxNarRohjI7JqzaChRLAIf+vabeu8X7XQ9lEv2pG9Y2nje6Ge4uS2esSnfTj4qpPWNBUYpvra4nfQEo5vhDVRmTJ5ccROzFMv7EyyY90T+oghEHZ6pJV+CR2Cl2X8QloVUq7dhQ40nVP0CUy7LfnInIP/Wi8pSZ99+UaGS3yWMqM1w4+TLTrmMvGdXv12368YqWcXj0USFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXW2jPgmt49DpzkjrKqxUiAuet6KkJ3Dzp4YVV043mU=;
 b=Zl4M661wWBej3SvDf0r1m4tBtpFE1DN1r5sn/SWQXRZ8CwHWlLKmRdYJGK0dQSNCtyU3VUWiCXJ4coZKoEG/KaDPe8nltZHRw4PDsi1TIbQ2WxYDiR7hrYxlXcqXTfwSFRj6QmZi3VZCDIU3iKS/fZZwhXWUi6jo99K6YyOY51Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1481.namprd12.prod.outlook.com (10.172.39.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 16:34:36 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2729.032; Wed, 19 Feb
 2020 16:34:36 +0000
Subject: Re: [PATCH] drm/amdgpu: add VM update fences back to the root PD v2
To: Tom St Denis <tom.stdenis@amd.com>, luben.tuikov@amd.com,
 Marek.Olsak@amd.com, Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org
References: <20200219150251.123917-1-christian.koenig@amd.com>
 <9af8bcf0-bfe6-d622-ec12-9bddba8e2d76@amd.com>
 <59eabaf0-a5b2-c43f-f4bb-491d9c6e655f@gmail.com>
 <a462df72-605a-1d9b-6825-59f5293c4a41@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0a11d92e-fc3d-28d9-82d9-1b645b4aa097@amd.com>
Date: Wed, 19 Feb 2020 17:34:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <a462df72-605a-1d9b-6825-59f5293c4a41@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0009.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::19) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0009.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend
 Transport; Wed, 19 Feb 2020 16:34:34 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2521f5f8-fd13-475c-9505-08d7b5599b4a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1481:|DM5PR12MB1481:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1481C314A5786FD38F45B4A983100@DM5PR12MB1481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(316002)(66574012)(15650500001)(66476007)(478600001)(66946007)(66556008)(6486002)(6666004)(2616005)(8676002)(186003)(5660300002)(2906002)(52116002)(8936002)(31686004)(31696002)(53546011)(86362001)(81166006)(81156014)(36756003)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1481;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hb2I/j/6LBY88bR/JOrpJ+WLPQw6XYnqnelf0GfvYcTIGZL6o3c8Yti5ejaH42lygQ9hCW40l764HsjGP/sLoKMLXajI41iIkEEiUvSWO1MpenF+JYWp9lVjfziUciH+5C1mCU14a4g2tM7jM83wyz/DLwE7o+Hm7TF9wud+xxv4vay9BtfwYctCuXJFnPfkaGy/0zql7AsrwC3FPUwIkifIN61NYHqQfSm+rf1in064yKNYmuXyQJ7+Oj5Qa/LqAEBUuPp2ii5IjjYtGnIIV1n0QniyQHnmn63D6HU2sDQAdQX/yy0H4ROgGH2/J2Yb8V1VNN116jG74ZhYISpkvRSTC3n457S0YaAHzUzQ8HN+1RWKcGL1ig0OJ22Wpw65qsoB+FPV2reKm6/Z2uhbeW0M0Gvc/vJTUfxBfRGHR0l70menETtsXL8g01DZOOOE
X-MS-Exchange-AntiSpam-MessageData: PVdlnWcqMnKHwugiNbPiBLQZz/U7OZ7g28WhgaVyjAPKaJsxMVHnsJrec1/HQilk00jaJaG17UYeiTkfpfD9N1Fn5pDrE5aJjVSNLsElb2hgzuMwiFF5g2ndLOMbJhvSS+E+zcrS7/jeSiTuz8GQAlS3NMcumdf/5pHbrYY08lUCVCPq6UDjYUBroZiVslVcbOyyxDvpTpsdvRSEY66Siw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2521f5f8-fd13-475c-9505-08d7b5599b4a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 16:34:35.9507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moJOnV85u4CL3tYm31fX30zJPWFsqZa0foVuKw8XpPDJbSuyBeZOtLy8OrATNaue
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1481
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rm9yIGFtZC1zdGFnaW5nLWRybS1uZXh0IHlvdSBuZWVkIHRoZSBmaXJzdCB2ZXJzaW9uIG9mIHRo
ZSBwYXRjaC4KCkZvciBkcm0tbWlzYy1uZXh0IG9yIGRybS1uZXh0IHlvdSBuZWVkIHRoZSBzZWNv
bmQgdmVyc2lvbiBvZiB0aGUgcGF0Y2guCgpXZSBwcm9iYWJseSBuZWVkIHRvIG1lcmdlIHRoZSBw
YXRjaCB0aHJvdWdoIGRybS1taXNjLW5leHQgYW55d2F5IHNpbmNlIAp0aGVyZSBpcyBhbHNvIHRo
ZSBwYXRjaCB3aGljaCBjYXVzZXMgdGhlIHByb2JsZW1zLgoKQ2hyaXN0aWFuLgoKQW0gMTkuMDIu
MjAgdW0gMTY6NDcgc2NocmllYiBUb20gU3QgRGVuaXM6Cj4gVGhlIHRpcCBvZiBvcmlnaW4vYW1k
LXN0YWdpbmctZHJtLW5leHQgZm9yIG1lIGlzOgo+Cj4gY29tbWl0IDdmZDNiNjMyZTE3ZTU1YzVm
ZmQwMDhmOWYwMjU3NTRlN2RhYTFiNjYKPiBSZWZzOiB7b3JpZ2luL2FtZC1zdGFnaW5nLWRybS1u
ZXh0fSwgdjUuNC1yYzctMjg0Ny1nN2ZkM2I2MzJlMTdlCj4gQXV0aG9yOsKgwqDCoMKgIE1vbmsg
TGl1IDxNb25rLkxpdUBhbWQuY29tPgo+IEF1dGhvckRhdGU6IFRodSBGZWIgNiAyMzo1NTo1OCAy
MDIwICswODAwCj4gQ29tbWl0OsKgwqDCoMKgIE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPgo+
IENvbW1pdERhdGU6IFdlZCBGZWIgMTkgMTM6MzM6MDIgMjAyMCArMDgwMAo+Cj4gwqDCoMKgIGRy
bS9hbWRncHU6IGZpeCBjb2xsaWRpbmcgb2YgcHJlZW1wdGlvbgo+Cj4gwqDCoMKgIHdoYXQ6Cj4g
wqDCoMKgIHNvbWUgb3MgcHJlZW1wdGlvbiBwYXRoIGlzIG1lc3NlZCB1cCB3aXRoIHdvcmxkIHN3
aXRjaCBwcmVlbXB0aW9uCj4KPiDCoMKgwqAgZml4Ogo+IMKgwqDCoCBjbGVhbnVwIHRob3NlIGxv
Z2ljcyBzbyBvcyBwcmVlbXB0aW9uIG5vdCBtaXhlZCB3aXRoIHdvcmxkIHN3aXRjaAo+Cj4gwqDC
oMKgIHRoaXMgcGF0Y2ggaXMgYSBnZW5lcmFsIGZpeCBmb3IgaXNzdWVzIGNvbWVzIGZyb20gU1JJ
T1YgTUNCUCwgYnV0Cj4gwqDCoMKgIHRoZXJlIGlzIHN0aWxsIFVNRCBzaWRlIGlzc3VlcyBub3Qg
cmVzb3ZsdmVkIHlldCwgc28gdGhpcyBwYXRjaAo+IMKgwqDCoCBjYW5ub3QgZml4IGFsbCB3b3Js
ZCBzd2l0Y2ggYnVnLgo+Cj4gwqDCoMKgIFNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxp
dUBhbWQuY29tPgo+IMKgwqDCoCBBY2tlZC1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFu
Z0BhbWQuY29tPgo+Cj4gV2hpY2ggSSBoYWQgZmV0Y2hlZCBqdXN0IGFuIGhvdXIgYWdvLgo+Cj4g
T24gMjAyMC0wMi0xOSAxMDo0MSBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBXZWxs
IHdoYXQgYnJhbmNoIGFyZSB5b3UgdHJ5aW5nIHRvIG1lcmdlIHRoYXQgaW50bz8KPj4KPj4gVGhl
IGNvbmZsaWN0IHJlc29sdXRpb24gc2hvdWxkIGJlIHNpbXBsZSwganVzdCBrZWVwIHRoZSAKPj4g
dm0tPnVwZGF0ZV9mdW5jcy0+cHJlcGFyZSguLi4pIGxpbmUgYXMgaXQgaXMgaW4geW91ciBicmFu
Y2guCj4+Cj4+IFdoZW4geW91IGdldCB0aG9zZSBlcnJvcnMgdGhlbiBzb21ldGhpbmcgd2VudCB3
cm9uZyBpbiB5b3VyIHJlYmFzZS4KPj4KPj4gQ2hyaXN0aWFuLgo+Pgo+PiBBbSAxOS4wMi4yMCB1
bSAxNjoxNCBzY2hyaWViIFRvbSBTdCBEZW5pczoKPj4+IERvZXNuJ3QgYnVpbGQgZXZlbiB3aXRo
IGNvbmZsaWN0IHJlc29sdmVkOgo+Pj4KPj4+IFtyb290QHJhdmVuIGxpbnV4XSMgbWFrZQo+Pj4g
wqAgQ0FMTMKgwqDCoCBzY3JpcHRzL2NoZWNrc3lzY2FsbHMuc2gKPj4+IMKgIENBTEzCoMKgwqAg
c2NyaXB0cy9hdG9taWMvY2hlY2stYXRvbWljcy5zaAo+Pj4gwqAgREVTQ0VORMKgIG9ianRvb2wK
Pj4+IMKgIENIS8KgwqDCoMKgIGluY2x1ZGUvZ2VuZXJhdGVkL2NvbXBpbGUuaAo+Pj4gwqAgQ0Mg
W01dwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLm8KPj4+IGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jOiBJbiBmdW5jdGlvbiAKPj4+IOKAmGFtZGdw
dV92bV9ib191cGRhdGVfbWFwcGluZ+KAmToKPj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jOjE2MTI6NDE6IGVycm9yOiDigJhvd25lcuKAmSAKPj4+IHVuZGVjbGFyZWQg
KGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQo+Pj4gwqAxNjEyIHzCoCByID0gdm0tPnVwZGF0
ZV9mdW5jcy0+cHJlcGFyZSgmcGFyYW1zLCBvd25lciwgZXhjbHVzaXZlKTsKPj4+IMKgwqDCoMKg
wqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5+fn5+Cj4+PiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYzoxNjEyOjQxOiBub3RlOiBlYWNoIAo+Pj4gdW5kZWNsYXJlZCBp
ZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCAKPj4+
IGFwcGVhcnMgaW4KPj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jOjE2
MTI6NDg6IGVycm9yOiDigJhleGNsdXNpdmXigJkgCj4+PiB1bmRlY2xhcmVkIChmaXJzdCB1c2Ug
aW4gdGhpcyBmdW5jdGlvbikKPj4+IMKgMTYxMiB8wqAgciA9IHZtLT51cGRhdGVfZnVuY3MtPnBy
ZXBhcmUoJnBhcmFtcywgb3duZXIsIGV4Y2x1c2l2ZSk7Cj4+PiDCoMKgwqDCoMKgIHwgXn5+fn5+
fn5+Cj4+PiBtYWtlWzRdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjY2OiAKPj4+IGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5vXSBFcnJvciAxCj4+PiBtYWtlWzNd
OiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NTA5OiAKPj4+IGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1XSBFcnJvciAyCj4+PiBtYWtlWzJdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVp
bGQ6NTA5OiBkcml2ZXJzL2dwdS9kcm1dIEVycm9yIDIKPj4+IG1ha2VbMV06ICoqKiBbc2NyaXB0
cy9NYWtlZmlsZS5idWlsZDo1MDk6IGRyaXZlcnMvZ3B1XSBFcnJvciAyCj4+PiBtYWtlOiAqKiog
W01ha2VmaWxlOjE2NDk6IGRyaXZlcnNdIEVycm9yIDIKPj4+Cj4+PiBTaG91bGQgSSBqdXN0IG1v
dmUgdG8gZHJtLW1pc2MtbmV4dD8KPj4+Cj4+PiB0b20KPj4+Cj4+PiBPbiAyMDIwLTAyLTE5IDEw
OjAyIGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4gQWRkIHVwZGF0ZSBmZW5jZXMg
dG8gdGhlIHJvb3QgUEQgd2hpbGUgbWFwcGluZyBCT3MuCj4+Pj4KPj4+PiBPdGhlcndpc2UgUERz
IGZyZWVkIGR1cmluZyB0aGUgbWFwcGluZyB3b24ndCB3YWl0IGZvcgo+Pj4+IHVwZGF0ZXMgdG8g
ZmluaXNoIGFuZCBjYW4gY2F1c2UgY29ycnVwdGlvbnMuCj4+Pj4KPj4+PiB2MjogcmViYXNlZCBv
biBkcm0tbWlzYy1uZXh0Cj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+Pj4gRml4ZXM6IDkwYjY5Y2RjNWYxNTkgZHJt
L2FtZGdwdTogc3RvcCBhZGRpbmcgVk0gdXBkYXRlcyBmZW5jZXMgdG8gCj4+Pj4gdGhlIHJlc3Yg
b2JqCj4+Pj4gLS0tCj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMgfCAxNCArKysrKysrKysrKystLQo+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIAo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMKPj4+PiBpbmRleCBkMTYyMzFkNmE3OTAuLmVmNzNmYTk0ZjM1NyAx
MDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+
Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+Pj4gQEAg
LTU4OCw4ICs1ODgsOCBAQCB2b2lkIGFtZGdwdV92bV9nZXRfcGRfYm8oc3RydWN0IGFtZGdwdV92
bSAqdm0sCj4+Pj4gwqAgewo+Pj4+IMKgwqDCoMKgwqAgZW50cnktPnByaW9yaXR5ID0gMDsKPj4+
PiDCoMKgwqDCoMKgIGVudHJ5LT50di5ibyA9ICZ2bS0+cm9vdC5iYXNlLmJvLT50Ym87Cj4+Pj4g
LcKgwqDCoCAvKiBPbmUgZm9yIFRUTSBhbmQgb25lIGZvciB0aGUgQ1Mgam9iICovCj4+Pj4gLcKg
wqDCoCBlbnRyeS0+dHYubnVtX3NoYXJlZCA9IDI7Cj4+Pj4gK8KgwqDCoCAvKiBUd28gZm9yIFZN
IHVwZGF0ZXMsIG9uZSBmb3IgVFRNIGFuZCBvbmUgZm9yIHRoZSBDUyBqb2IgKi8KPj4+PiArwqDC
oMKgIGVudHJ5LT50di5udW1fc2hhcmVkID0gNDsKPj4+PiDCoMKgwqDCoMKgIGVudHJ5LT51c2Vy
X3BhZ2VzID0gTlVMTDsKPj4+PiDCoMKgwqDCoMKgIGxpc3RfYWRkKCZlbnRyeS0+dHYuaGVhZCwg
dmFsaWRhdGVkKTsKPj4+PiDCoCB9Cj4+Pj4gQEAgLTE1OTEsNiArMTU5MSwxNiBAQCBzdGF0aWMg
aW50IAo+Pj4+IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJvcl91bmxvY2s7Cj4+Pj4g
wqDCoMKgwqDCoCB9Cj4+Pj4gwqAgK8KgwqDCoCBpZiAoZmxhZ3MgJiBBTURHUFVfUFRFX1ZBTElE
KSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm8gKnJvb3QgPSB2bS0+cm9v
dC5iYXNlLmJvOwo+Pj4+ICsKPj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFkbWFfZmVuY2VfaXNf
c2lnbmFsZWQodm0tPmxhc3RfZGlyZWN0KSkKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBh
bWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxhc3RfZGlyZWN0LCB0cnVlKTsKPj4+PiArCj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIGlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKHZtLT5sYXN0X2RlbGF5
ZWQpKQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9ib19mZW5jZShyb290LCB2
bS0+bGFzdF9kZWxheWVkLCB0cnVlKTsKPj4+PiArwqDCoMKgIH0KPj4+PiArCj4+Pj4gwqDCoMKg
wqDCoCByID0gdm0tPnVwZGF0ZV9mdW5jcy0+cHJlcGFyZSgmcGFyYW1zLCBvd25lciwgZXhjbHVz
aXZlKTsKPj4+PiDCoMKgwqDCoMKgIGlmIChyKQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3Rv
IGVycm9yX3VubG9jazsKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
