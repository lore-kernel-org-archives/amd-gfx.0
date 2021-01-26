Return-Path: <SRS0=fKyo=G5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BECC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jan 2021 16:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47DFC20756
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jan 2021 16:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DFC20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8A6889C1F;
	Tue, 26 Jan 2021 16:15:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D91C89C1F
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 16:15:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwE4hHGa0einq7zUH6jjERd+8IPaJU+0jmnvfh5PUFqfaltiOHTQ3/efv38QTHbhYVa3PLk9WNaR+5H+oUWSRHxH9NJ8Ft69G4txow2p2+ps8h7L1S6CC7g48c86VN9+PXuosc2TnO5cTTFHlr5O8hvFTUTTcYR3KDvxHlp12gUpGJU5wJU4DV/QejRsGrZUi12DUTUJ14YTFjBTsMGrzbSqQKaygG+7ZjKFf69sSRE9YAHu/PdNbYTTBaiXhpOyCedvYGMlLDHxR3XVCz1vp6C8YX3rF4O8puX8+je1+Skd1dHl6NeaEk2JuBTx6TGAkG2LCQAB9QL4inn5W244Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyYa6snmj7dnVFDLIUrQKCeIeNS2ZtNnhkjZrV6sX2I=;
 b=DZyXCRxpO0VGhzQHTMTt/v9O58pH/vb/mfkOr4j2I5FVma02ZcO2M5MnZVcV5pAw9d8Ar9APNXzmPW8EjIHe/TCieiDMTf1Qbhf1D9LY38xeYeYBM5AUrlH0MQpjfFi3olzSqYWbqJbIKc8xAUrY0arG+QCqPboh4FCUwstDeBW4YVdM1E5HgkHABi3Wb7gIXFrVPxJgssOs6iBFvpiY3DOJ/Gr7lxzlqJGJt+0UgdBRXprV+I5pq9/OuVp4Tg+kWuusJvdTxaakZVKqaoKVf8GPQ9ZTr/k6knNrihNdUPVPH9WOxzcOdSyGSjoYlvsMnPileM6PAPc0O4quQ/e4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyYa6snmj7dnVFDLIUrQKCeIeNS2ZtNnhkjZrV6sX2I=;
 b=ofnX1HKosH3nQMO+taRgYSUBzjZ6HghXdsWz9I5L49tepCKOQ6s0vD2bcUgrtwVdUIOnHdrqJyQvNh+3Uy4A9qxVKM5OBLq6ptD0d1vgFgDiphSjGXv2jPU7l5ubUJP5Q4jUpFwMrp6O5z66dBmSyARy/SQjnINeozsorUewI0w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR12MB1424.namprd12.prod.outlook.com (2603:10b6:300:13::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Tue, 26 Jan
 2021 16:15:06 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::172:235e:14a4:bdc6]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::172:235e:14a4:bdc6%7]) with mapi id 15.20.3763.019; Tue, 26 Jan 2021
 16:15:06 +0000
Subject: Re: [PATCH] drm/amd/display: Add DC feature flag to disable audio
To: =?UTF-8?Q?Ernst_Sj=c3=b6strand?= <ernstp@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20210126143155.16479-1-ernstp@gmail.com>
 <CADnq5_MzCdBnmZ4e8PckzK7wjA7DdsRaQ35gqi=H=TJ7_OWcmw@mail.gmail.com>
 <CAD=4a=W-K1Zf64Bqhpzby-nX-iYYnuVZeX55w8JC0=F20x5Mtw@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <0115f891-d4a8-930c-7095-cbb45ec1df01@amd.com>
Date: Tue, 26 Jan 2021 11:15:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <CAD=4a=W-K1Zf64Bqhpzby-nX-iYYnuVZeX55w8JC0=F20x5Mtw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YTBPR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::35) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YTBPR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12 via Frontend Transport; Tue, 26 Jan 2021 16:15:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c848cd6-dfb0-4a78-2de3-08d8c2158b33
X-MS-TrafficTypeDiagnostic: MWHPR12MB1424:
X-Microsoft-Antispam-PRVS: <MWHPR12MB14249F325FBA844DC5D47EA08CBC9@MWHPR12MB1424.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5vDRFm0tihR+rp+QzFnAK72CmrWzCt5Dud84KOuY/b37lFlU/46ndScPSQlyvcgexAMGrFnXbnCOUeIGri4Le/JpRUqJFQqKkHuvaO8hzq8OgfS6x/ewBa0NJSKX77p90gW19dtiklZhoy6CLX4ZZ5AnlBJ0/rVzXQKq9bmBXaNbRF5dkbqoDPnhjqD3BU3oLwZBMd+2miYDHXEiOJrN7Qmjfs72WdGNCThLmpdxM2y3nca33NtlaeTbO10fHf8Pzrbrduk4B2lTAaK0XVmTGc6BUXDJk6e2CojF08KQrsty61MeKk+FOc6NofEdaqH2uVEyOPPow7zR3bhqYyZahi0k/Fd77Zuo+ZugyyCC6y0ApuALbAv8lCuxpCiaZMuoNQ52PXYhdqLI/W8e3usucDmOq5iHCtKbXauGjtcxxfzBuQR4/HcY2s45RkzbvKLHtNkvmWEjeTO1P0JoGNMn1rLame1fl/ykCDBCW1Szf2RHlHNxvPAfa1yiogjsjuFQCyGqOH/Onxon2n7cmoGgOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(26005)(110136005)(5660300002)(31696002)(86362001)(36756003)(6666004)(956004)(2616005)(66476007)(8936002)(16526019)(186003)(16576012)(31686004)(316002)(8676002)(83380400001)(966005)(2906002)(6486002)(53546011)(52116002)(478600001)(4326008)(45080400002)(66556008)(44832011)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ekRGSk5HL0cxNTFwYzJwVytodjIwWCtLcDdScFhwaWMrNklXUU1RRUNpS21T?=
 =?utf-8?B?ek5WWGN2MjkzSjRuVThZOGtORll0NlVyUnUyRnliS3lENnVrRlJPRElrREpY?=
 =?utf-8?B?Q28xZE8yRG5FSEpwTTNOWkdXVEFLOVhOUXg4eFV0akJtdkc5V0Fnc3VyRVVK?=
 =?utf-8?B?eHd6V3NheFJJb2lqUXRSVXRXTUU4SUh4N3NPQUFrWlpGeUZBWEJIdXVBbFBp?=
 =?utf-8?B?aTJMajRkS0hCNVpjek1Zc29QNE1pSE16REFFVnk2dWpUZFNCd2pWYUdwdlg4?=
 =?utf-8?B?eTRvM3NzUUxZU0tCL2NMcUFrMmVha0JOcGNkcHkzMmNLZGZMQTF4d2ZHS2dM?=
 =?utf-8?B?N0diR1pKTG5NV3ZUaXRMSnhRSzNrUUFnL092b0J0ekQwMU5SamxSamdwSXdP?=
 =?utf-8?B?UUIrSW1uWGN6cFU3eTZHYTRhN1AwV05tNFRvU0tLaW05NFpzODVqK1YxaVc4?=
 =?utf-8?B?cXBzd2pRRXlCb28yVkUxckVQVlg3dmdpS1JoSGlneERvRmhmdmROZFpVcUI0?=
 =?utf-8?B?dU1DR3BkN05vbi9aUnFPelMvcWNCRHhVRmI3VE45T0xxZHkvK20xNDloc2lh?=
 =?utf-8?B?RGEvbUZncWVTaUFyOGFWc0c1dXJ5WWFpbnRDMDl3UzBQaXVPaGZYOTd3aUxT?=
 =?utf-8?B?RFdvK05PYjlCVVRRNXo3MXlTdHVHWFFrS1RPVnJ5Q1dWdFNOTml2SzRVNU10?=
 =?utf-8?B?cWREcXcrakpvbWZucmwzcE9HaUMxbGdJREZEQUorZ3FsLzJPV1EzLzJlaS9t?=
 =?utf-8?B?eWtzMldZb3J3d3hhNU1DZnZxVDl1VWptd2U0ZStTTUN6bUxQVkRwbDlwcTNH?=
 =?utf-8?B?a0ltMm1rU05sbGk2djVhclErRDBhQ2IrUGV6SnBpMHI2THFQNk1pbWJXaVpE?=
 =?utf-8?B?NGQ5alFoVWhJeDNhS2ZQY21zQ1c4L2ZRYnkxUWJ4RURWaUZGZGM0QUlDYTkv?=
 =?utf-8?B?L2VFbkdTc1dBdk1aS0crVEh4eDdWaXQ4NDBaQlNLdjNBc2tMdjQ0dmhHN0h3?=
 =?utf-8?B?cXROY1QvaWV0MmkyaVpZN1lBSWVYcW82Qk5wZ3B3eGp4SFZOZ2lsZkNuVGlB?=
 =?utf-8?B?UG5YVUdYL3dOV2JNcW1TZXNCVURLOS9EMW0rVkY4aUZVd3J5YXRPeGEvOTRp?=
 =?utf-8?B?ek05M3FqZmlCVnN4azl3MXBBaTJlVkVqUHJTdzNTMC9ab0ltWjdmTUkxYzRS?=
 =?utf-8?B?Wk5UdFMrY2tjb3c0NHZUTnhwdjR2V3ZnY0ZReHhBQnUvSUZQenRiZjNCTFJl?=
 =?utf-8?B?MEZOMSs4S1QvQURGckFFd2gyYnhRTHhzYXBoeS82aERWQzBhTy9Tcy92RVN2?=
 =?utf-8?B?cUVlWCtIMWR3bnFpNUlPYnZJei9oWkhLK1ZGRFkreGxDcDI1cGd4QklXZTZQ?=
 =?utf-8?B?RGpUQjBHSFBianNaUkxCeE1ldE9PbmNXM0liWGJRWk1oZHpROGd3aXpWMjlZ?=
 =?utf-8?B?Zk9SV3FxcXNEUy9QZWY4REphdUszY0M3TVhQdVdBPT0=?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c848cd6-dfb0-4a78-2de3-08d8c2158b33
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 16:15:06.0106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcreDNSbwrtr8MikmskJpsINFGmtWpCC08R1rt4Z0g/Ogv3wlip7kAlIOUHcXD/wL5y1VKUADfen5ElKUMSGUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1424
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMS0yNiA5OjUxIGEubS4sIEVybnN0IFNqw7ZzdHJhbmQgd3JvdGU6Cj4gTm8gcHJv
YmxlbXMgd2l0aCBhbWRncHUsIGJ1dCB3aGVuIG15IGhlYWRwaG9uZSBwb3J0IGlzIGdsaXRjaGlu
ZyBJIG9mdGVuIAo+IGVuZCB1cCB3aXRoIHNvbWUgSERNSSBhdWRpbyBvdXRwdXQgc2VsZWN0ZWQg
aW5zdGVhZC4KPiAKCldvdWxkbid0IHRoaXMgYmUgYmV0dGVyIGZpeGVkIGluIHRoZSBhdWRpbyBt
YW5hZ2VtZW50IHNlcnZpY2UsIGxpa2UgClB1bHNlQXVkaW8/IEl0IHNvdW5kcyBsaWtlIGl0J3Mg
bm90IHJlbWVtYmVyaW5nIHlvdXIgcHJlZmVyZW5jZXMgY29ycmVjdGx5LgoKSGFycnkKCj4gSXQg
YWxzbyBjbGVhbnMgdXAgdGhlIGNsdXR0ZXIgaW4gdGhlIGF1ZGlvIHNlbGVjdGlvbiBsaXN0Lgo+
IAo+IC8vRQo+IAo+IERlbiB0aXMgMjYgamFuLiAyMDIxIGtsIDE1OjM0IHNrcmV2IEFsZXggRGV1
Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tIAo+IDxtYWlsdG86YWxleGRldWNoZXJAZ21haWwu
Y29tPj46Cj4gCj4gICAgIE9uIFR1ZSwgSmFuIDI2LCAyMDIxIGF0IDk6MzIgQU0gRXJuc3QgU2rD
tnN0cmFuZCA8ZXJuc3RwQGdtYWlsLmNvbQo+ICAgICA8bWFpbHRvOmVybnN0cEBnbWFpbC5jb20+
PiB3cm90ZToKPiAgICAgID4KPiAgICAgID4gV2l0aCB0aGUgcHJlLURDIHBhdGggeW91IGNvdWxk
IHNldCBhdWRpbz0wIHRvIGRpc2FibGUgYXVkaW8uCj4gICAgICA+IFRoaXMgYWRkcyBhIHNpbWls
YXIgZmVhdHVyZSBmb3IgdGhlIERDIHBhdGggd2l0aAo+ICAgICAgPiBhbWRncHUuZGNmZWF0dXJl
bWFzaz0weDEwLgo+ICAgICAgPgo+ICAgICAgPiBTaWduZWQtb2ZmLWJ5OiBFcm5zdCBTasO2c3Ry
YW5kIDxlcm5zdHBAZ21haWwuY29tCj4gICAgIDxtYWlsdG86ZXJuc3RwQGdtYWlsLmNvbT4+Cj4g
Cj4gICAgIElzIHRoZXJlIGEgcmVhc29uIHlvdSB3YW50IHRoaXM/wqAgSS5lLiwgaXMgYXVkaW8g
Y2F1c2luZyBwcm9ibGVtcwo+ICAgICBmb3IgeW91Pwo+IAo+ICAgICBBbGV4Cj4gCj4gICAgICA+
IC0tLQo+ICAgICAgPsKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1k
Z3B1X2RtLmMgfCAzICsrKwo+ICAgICAgPsKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9jb3JlL2RjX3Jlc291cmNlLmMgfCA3ICsrKystLS0KPiAgICAgID7CoCBkcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGMuaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCAxICsKPiAgICAg
ID7CoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5owqAgwqAgwqAgwqAg
wqAgfCAxICsKPiAgICAgID7CoCA0IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkKPiAgICAgID4KPiAgICAgID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiAgICAgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gICAgICA+IGluZGV4IGU0OTBm
YzI0ODZmNy4uMzIyZDk0MzliOWMyIDEwMDY0NAo+ICAgICAgPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gICAgICA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiAgICAgID4gQEAg
LTEwMTMsNiArMTAxMyw5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RtX2luaXQoc3RydWN0Cj4gICAg
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAgICA+wqAgwqAgwqAgwqAgwqBpZiAoYW1kZ3B1X2Rj
X2ZlYXR1cmVfbWFzayAmIERDX0RJU0FCTEVfRlJBQ1RJT05BTF9QV01fTUFTSykKPiAgICAgID7C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGluaXRfZGF0YS5mbGFncy5kaXNhYmxlX2ZyYWN0aW9u
YWxfcHdtID0gdHJ1ZTsKPiAgICAgID4KPiAgICAgID4gK8KgIMKgIMKgIMKgaWYgKGFtZGdwdV9k
Y19mZWF0dXJlX21hc2sgJiBEQ19ESVNBQkxFX0FVRElPKQo+ICAgICAgPiArwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpbml0X2RhdGEuZmxhZ3MuZGlzYWJsZV9hdWRpbyA9IHRydWU7Cj4gICAgICA+
ICsKPiAgICAgID7CoCDCoCDCoCDCoCDCoGluaXRfZGF0YS5mbGFncy5wb3dlcl9kb3duX2Rpc3Bs
YXlfb25fYm9vdCA9IHRydWU7Cj4gICAgICA+Cj4gICAgICA+wqAgwqAgwqAgwqAgwqBpbml0X2Rh
dGEuc29jX2JvdW5kaW5nX2JveCA9IGFkZXYtPmRtLnNvY19ib3VuZGluZ19ib3g7Cj4gICAgICA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNv
dXJjZS5jCj4gICAgIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVz
b3VyY2UuYwo+ICAgICAgPiBpbmRleCA2OGI2NWEwOTBkMTcuLjRjYzBkMjMwOGM5OCAxMDA2NDQK
PiAgICAgID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVz
b3VyY2UuYwo+ICAgICAgPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29y
ZS9kY19yZXNvdXJjZS5jCj4gICAgICA+IEBAIC0yMTQxLDkgKzIxNDEsMTAgQEAgZW51bSBkY19z
dGF0dXMgcmVzb3VyY2VfbWFwX3Bvb2xfcmVzb3VyY2VzKAo+ICAgICAgPsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgdHJ1ZSk7Cj4gICAgICA+Cj4gICAgICA+wqAgwqAgwqAgwqAgwqAvKiBUT0RP
OiBBZGQgY2hlY2sgaWYgQVNJQyBzdXBwb3J0IGFuZCBFRElEIGF1ZGlvICovCj4gICAgICA+IC3C
oCDCoCDCoCDCoGlmICghc3RyZWFtLT5jb252ZXJ0ZXJfZGlzYWJsZV9hdWRpbyAmJgo+ICAgICAg
PiAtwqAgwqAgwqAgwqAgwqAgwqBkY19pc19hdWRpb19jYXBhYmxlX3NpZ25hbChwaXBlX2N0eC0+
c3RyZWFtLT5zaWduYWwpICYmCj4gICAgICA+IC3CoCDCoCDCoCDCoCDCoCDCoHN0cmVhbS0+YXVk
aW9faW5mby5tb2RlX2NvdW50ICYmCj4gICAgIHN0cmVhbS0+YXVkaW9faW5mby5mbGFncy5hbGwp
IHsKPiAgICAgID4gK8KgIMKgIMKgIMKgaWYgKCFkYy0+Y29uZmlnLmRpc2FibGVfYXVkaW8gJiYK
PiAgICAgID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIXN0cmVhbS0+Y29udmVydGVyX2Rpc2Fi
bGVfYXVkaW8gJiYKPiAgICAgID4gKyAgICAgICAgICAgICAKPiAgICAgIMKgZGNfaXNfYXVkaW9f
Y2FwYWJsZV9zaWduYWwocGlwZV9jdHgtPnN0cmVhbS0+c2lnbmFsKSAmJgo+ICAgICAgPiArwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJlYW0tPmF1ZGlvX2luZm8ubW9kZV9jb3VudCAmJgo+ICAg
ICBzdHJlYW0tPmF1ZGlvX2luZm8uZmxhZ3MuYWxsKSB7Cj4gICAgICA+wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBwaXBlX2N0eC0+c3RyZWFtX3Jlcy5hdWRpbyA9IGZpbmRfZmlyc3RfZnJlZV9h
dWRpbygKPiAgICAgID7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZjb250ZXh0LT5yZXNfY3R4
LCBwb29sLAo+ICAgICBwaXBlX2N0eC0+c3RyZWFtX3Jlcy5zdHJlYW1fZW5jLT5pZCwgZGNfY3R4
LT5kY2VfdmVyc2lvbik7Cj4gICAgICA+Cj4gICAgICA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAo+ICAgICBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kYy5oCj4gICAgICA+IGluZGV4IDcxZDQ2YWRlMjRlNS4uMmFiNmQ3NzBjNjZiIDEw
MDY0NAo+ICAgICAgPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAo+
ICAgICAgPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAo+ICAgICAg
PiBAQCAtMjk3LDYgKzI5Nyw3IEBAIHN0cnVjdCBkY19jb25maWcgewo+ICAgICAgPsKgIMKgIMKg
IMKgIMKgYm9vbCBtdWx0aV9tb25fcHBfbWNsa19zd2l0Y2g7Cj4gICAgICA+wqAgwqAgwqAgwqAg
wqBib29sIGRpc2FibGVfZG1jdTsKPiAgICAgID7CoCDCoCDCoCDCoCDCoGJvb2wgZW5hYmxlXzR0
bzFNUEM7Cj4gICAgICA+ICvCoCDCoCDCoCDCoGJvb2wgZGlzYWJsZV9hdWRpbzsKPiAgICAgID7C
oCAjaWYgZGVmaW5lZChDT05GSUdfRFJNX0FNRF9EQ19EQ04pCj4gICAgICA+wqAgwqAgwqAgwqAg
wqBib29sIGNsYW1wX21pbl9kY2ZjbGs7Cj4gICAgICA+wqAgI2VuZGlmCj4gICAgICA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oCj4gICAgIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaAo+ICAgICAgPiBpbmRleCA5
Njc2MDE2YTM3Y2UuLjcyMDJkODE2YTk3ZSAxMDA2NDQKPiAgICAgID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaAo+ICAgICAgPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oCj4gICAgICA+IEBAIC0yMjAsNiArMjIwLDcg
QEAgZW51bSBEQ19GRUFUVVJFX01BU0sgewo+ICAgICAgPsKgIMKgIMKgIMKgIMKgRENfTVVMVElf
TU9OX1BQX01DTEtfU1dJVENIX01BU0sgPSAweDIsCj4gICAgICA+wqAgwqAgwqAgwqAgwqBEQ19E
SVNBQkxFX0ZSQUNUSU9OQUxfUFdNX01BU0sgPSAweDQsCj4gICAgICA+wqAgwqAgwqAgwqAgwqBE
Q19QU1JfTUFTSyA9IDB4OCwKPiAgICAgID4gK8KgIMKgIMKgIMKgRENfRElTQUJMRV9BVURJTyA9
IDB4MTAsCj4gICAgICA+wqAgfTsKPiAgICAgID4KPiAgICAgID7CoCBlbnVtIERDX0RFQlVHX01B
U0sgewo+ICAgICAgPiAtLQo+ICAgICAgPiAyLjI3LjAKPiAgICAgID4KPiAgICAgID4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiAgICAgID4gYW1kLWdm
eCBtYWlsaW5nIGxpc3QKPiAgICAgID4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcgPG1h
aWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4KPiAgICAgID4gaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cj4gICAgIDxodHRwczov
L25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYl
MkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmRh
dGE9MDQlN0MwMSU3Q0hBUlJZLldFTlRMQU5EJTQwYW1kLmNvbSU3QzczNjUzMmJmYmE1ZDRiOTZl
OWFjMDhkOGMyMDllOTlkJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdD
MCU3QzYzNzQ3MjY5NTEyMzUxNzc4OCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1D
NHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0Ql
N0MxMDAwJnNkYXRhPTFNV09mTWZhSWhkViUyQmNuSCUyQmVBQzBhUnFiOUJNVnJkdlJlWkJLRzJa
SlNjJTNEJnJlc2VydmVkPTA+Cj4gCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
