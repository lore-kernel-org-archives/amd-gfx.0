Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A1BC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 07:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA752073E
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 07:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QJivCtdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA752073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9792D89CE1;
	Tue, 23 Jun 2020 07:36:06 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700050.outbound.protection.outlook.com [40.107.70.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15A4289CE1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 07:36:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iA5piy/GrWt9bvVtVHQN88Lni/g6u73Bd/JRWg7weP5kTqsdCP3+fRaZkt+2LyOsiYvGtlRuc/IZynNifNlzDDuEE8+FFKOgiBOVFzUAbATUuv36It8x2gQX0LuYsFslKT81g9UiAM95lFJDKxqgslYp0RgwutZLpszD7brhIcVfSb23HEx9D0AGkxIEuhHwyJj4mMdShXTx76HqScVVq5Oe5KX/h+5g8HHTwMnCn/N1go0GoeVb8+WSBZR42dVLMLH3X6m8tXQVQ4OEghA9nJAYAbuhwydACX/q/X+f57GLxT66GErwlkBSxDmN9KSzb2bQ9fs3BMygrx3W2KXZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQZM5wrqSfT4b89Unh2/DmTBXAkRpZ8INtvrHJ7stuY=;
 b=ITR6X4UD5YWXV5CwlEUhbCeqZNr9Q2Aa1Vq0cWn92QqGw2GoZK+xCOGJonU28I85Nc+Wmn2KySwM2QdbKTnvRIdHjW3py96+7Gp+RIcbSPR4Wc9gj+JLCWCq8TrL/3P9vRLm4n76P1FD17Lyf2UyLQc1Kvi1ARVVDWsBrlObCaN8o1D+ZHUJRsmAxC5LxZ0cehnJQc5DO7CHwN3EYAKufueFKpzRceVeATpXaVKzYt9RIfwbcWoadlIgMry1TjSIFi4cYcpc2Fr0Jq45We6RuxLh8B3oSuvH+fGTCwGKWS0+6pn3He9xxpmhebhMTdKlENwQCSidqOIdCMD6UO/1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQZM5wrqSfT4b89Unh2/DmTBXAkRpZ8INtvrHJ7stuY=;
 b=QJivCtdT3g50ud9UNzw2+F2M5JMwNzRXkVf9Pei5O35rQGkwqw4H2eImXwABW3JexcTymGjxE6TdWkicDehoToppL1cLY5QvK6X9qpNo5vSYKxTM/IW0jZfVtpW0WOp0rtHnp+TlY+leivSgm7utgY8Nm4B0FVQV8tEDRnmI3Ms=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3915.namprd12.prod.outlook.com (2603:10b6:5:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 07:36:01 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1%9]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 07:36:01 +0000
Subject: Re: [PATCH v2 3/3] drm/amdgpu: Warn about disabled DPM
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20200619185009.12966-1-pmenzel@molgen.mpg.de>
 <20200619185009.12966-3-pmenzel@molgen.mpg.de>
 <fdcc2c10-26cd-3183-42c6-daf36d5df1e9@amd.com>
 <5916b5fa-cc2d-f8df-ca55-505034f09f58@molgen.mpg.de>
 <e4c8cbb6-1a36-bade-eec4-85a52b7a0275@amd.com>
 <a05589bc-b78c-09f7-e228-073d45a2a773@molgen.mpg.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c777fa7d-52cc-16cb-69c9-5ec75eb1d20e@amd.com>
Date: Tue, 23 Jun 2020 09:35:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <a05589bc-b78c-09f7-e228-073d45a2a773@molgen.mpg.de>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0902CA0015.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::25) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR0902CA0015.eurprd09.prod.outlook.com (2603:10a6:200:9b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Tue, 23 Jun 2020 07:36:00 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d73b54a-e86d-4bc0-3261-08d817481411
X-MS-TrafficTypeDiagnostic: DM6PR12MB3915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3915F2946FD279B8C3250CF083940@DM6PR12MB3915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9Quok9W0KLJmCndJ6o5DghsXLKm8uBRyZdfMevtNBh+AoeO0Oi5YCJeVlZtUWhZYoAxMSrutbq/nwF6c7BKMulj9mKm/Ge+bwIB7Fu7nNERiIsG905b3l7O2JZ5VQXs7kG9eHHlU0XyGTbzzNefA6Ue+34XRFRwyvKlUHG7N8H6wKMGLoC+R3a0iWAbCX9KuRUf9rffl38ZUWOiRjSAzXCzH5Wzg5L1zxZvWJ0NF7WZwXu4Fx+8zxaRIRLnYRSlc5EB19foerwxM8OjG9q/BwKLvkiJzETwESfhlQR6l6UbLT1/ykUFK4zp+emRRP8tCmED3ctP3h7HZOGvv7f7DpZN3WclqMO912TeflTjtnYevr5SdXAJYwIiHHrOIYsA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(346002)(376002)(136003)(366004)(396003)(4326008)(66946007)(52116002)(8676002)(66476007)(66556008)(2616005)(83380400001)(36756003)(86362001)(31686004)(478600001)(6666004)(6486002)(6636002)(316002)(110136005)(2906002)(5660300002)(31696002)(186003)(8936002)(16526019)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2HmGv/OLIIwoNQ4hUI+EK2gHkQA+BJkqVffSuSqEcFf8o9ZBTgmGUVBflmoXFzy4CDA/r8JQuFJ3TGI0H8Wx2LkYSQwcUVXAiHWwYPggr1j7h54Rpz6t5C26eYqycSGX2YkQNNwv0cR99h3rXh82xXDU/Kicd1zKlnkXurh8qC+ziwsufADoWegL1ATU56OfqjT6mEL8R8dDgmIjMaPo5/j+Zh3i2+7jk7kbodr18nsFuVXP6rQ3zb4sGQLD8/Vb5BF3k4sqPVBBK20IfGxAdCQM4kMJ5CioaBXEFwzRwAI9EC6xjYqkVOCyf3XvimTYKCsFit39XyloTefVugrjeaZ0J2jxXLyAWJ/xu779+y+aB9iJXVAcNHvniMXcGVxJ4KOxsdPW6rYbIduTcDtUAzHQAyfLU9gBFH1nqbZoeQe4/RPlxS/Ckj6Z8dfwXdueFWCvrzOmYWRpEG8n0JFtjAYD47BUkXy5xiPbBf1RNUnvc9uRexOjDl3D/5VXtT+Iq0YKip7Q9p5P98QJYnEMtb4enoyLE5J23Kl6Fp8dByRGUuIuTR+oxkd0TV7OE5gF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d73b54a-e86d-4bc0-3261-08d817481411
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 07:36:01.5775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/jnTia4w0XRLtWAAiJD7WI/TvF75CLSUDZiJJhGy2gv6tPLcsDxoWIvz2BsTubQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3915
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjIuMDYuMjAgdW0gMjM6NDEgc2NocmllYiBQYXVsIE1lbnplbDoKPiBbU05JUF0KPj4+IEZv
ciBleGFtcGxlLCBpZiB0aGUgdXNlciBhZGRlZCB0aGUgcGFyYW1ldGVyIGludGVudGlvbmFsbHks
IG1heWJlIAo+Pj4gdGhleSBtYWRlIGEgdHlwbywgYW5kIGl04oCZcyBhY3R1YWxseSBub3QgYXBw
bGllZC4gT3IgdGhlcmUgaXMgYSBidWcgCj4+PiBpbiB0aGUgcGFyYW1ldGVyIGhhbmRsaW5nLiBI
YXZpbmcgZXhwbGljaXQgbG9nIG1lc3NhZ2VzIGlzIGdvb2QgaW4gCj4+PiBteSBvcGluaW9uLgo+
Pj4KPj4+IFNlY29uZGx5LCB0aGUgcGFyYW1ldGVyIGNvdWxkIGhhdmUgYmVlbiBsZWZ0IHRoZXJl
IHVuaW50ZW50aW9uYWxseS4gCj4+PiBIYXZpbmcgdGhlIG1lc3NhZ2UgaW4gdGhlIGxvZ3MsIG1h
a2VzIHRoZSB1c2VyIGF3YXJlIG9mIHRoYXQuCj4+Cj4+IEFuZCBleGFjdGx5IGZvciB0aGlzIHJl
YXNvbiB0aGUga2VybmVsIGNvbW1hbmQgbGluZSBpcyBwcmludGVkIGFzIHRoZSAKPj4gc2Vjb25k
IGxpbmUgb2YgdGhlIGxvZ3MuCj4KPiBObywgSSBkaXNhZ3JlZS4gSGF2aW5nIHRoZSBwYXJhbWV0
ZXJzIGxpc3RlZCwgYW5kIGtub3dpbmcgdGhlIGFjdHVhbCAKPiBlZmZlY3RzIGFyZSB0d28gdG90
YWxseSBkaWZmZXJlbnQgdGhpbmdzLiBJdOKAmXMgdXNlciBpbnRlcmZhY2UgZGVzaWduIAo+IDEw
MSB0byBnaXZlIGNsZWFyIGZlZWRiYWNrLiBJIHRoaW5rLCB5b3UgYXJlIGxvb2tpbmcgdGhyb3Vn
aCB0aGUgCj4gZ2xhc3NlcyBvZiBhIGRldmVsb3BlciwgYW5kIG5vdCBvZiBhIG5vbi1kZXZlbG9w
ZXIuCgpXZWxsIG15IGpvYiBpcyB0byBzZWUgdGhpcyBhcyBhIG1haW50YWluZXIgYW5kIGtlZXAg
dGhlIGRyaXZlciBzaW1wbGUgCmFuZCBjbGVhbiBzbyB0aGF0IHdlIGNhbiBlYXNpbHkgbWFpbnRh
aW4gYW5kIGV4dGVuZCBpdCwgYnV0IGF0IHRoZSBzYW1lIAp0aW1lIGl0IHNob3VsZCBvYnZpb3Vz
bHkgZ2l2ZSB0aGUgYmVzdCBleHBlcmllbmNlIHRvIGVuZCB1c2Vycy4KClNvIEknbSBjZXJ0YWlu
bHkgd2VpZ2h0aW5nIHRoaXMsIGJ1dCBjdXJyZW50bHkgSSBkb24ndCBzZWUgYSBnb29kIAphcmd1
bWVudCB0byBhZGQgc29tZXRoaW5nIGxpa2UgdGhpcy4KClNlZSBlc3NlbnRpYWxseSB5b3UgYXJl
IHJlcXVlc3RpbmcgdGhhdCBhbiBpbnRlbmRlZCBiZWhhdmlvciBzaG91bGQgZ2l2ZSAKYSB3YXJu
aW5nLiBUaGF0IGlzIGxpa2UgdGVsbGluZyB0aGUgdXNlciB0byBub3QgZG8gc29tZXRoaW5nIGhl
IHdhbnRzLgoKSWYgYW4gdXNlciBkb2Vzbid0IGtuZXcgd2hhdCBoZSBpcyBkb2luZywgdGhhdCdz
IG9idmlvdXNseSBhIGJpZyBwcm9ibGVtIAphcyB3ZWxsLiBCdXQgSSB3b3VsZCBzYXkgaW4gdGhp
cyBjYXNlIHdlIHNob3VsZCBpbXByb3ZlIHRoZSBkb2N1bWVudGF0aW9uLgoKQWRkaW5nIGEgd2Fy
bmluZyB3b3VsZCBiZSBqdXN0aWZpZWQgZm9yIG9wdGlvbnMgbGlrZSBleHBlcmltZW50YWwgCmZl
YXR1cmVzIHdoaWNoIGNvdWxkIGRhbWFnZSB0aGUgaGFyZHdhcmUgYnkgZ29pbmcgYmV5b25kIHRo
ZSBkZXZpY2UgCmNhcGFiaWxpdGllcyBmb3IgZXhhbXBsZS4KCj4+IER1cGxpY2F0aW5nIHRoaXMg
aW4gZWFjaCBkcml2ZXIgaXMgbm90IG9ubHkgb3ZlcmtpbGwsIGJ1dCBhbHNvIHZlcnkgCj4+IGVy
cm9yIHByb25lLgo+Cj4gV2hhdCBkcml2ZXJzIGRvIHlvdSBtZWFuLCBhbmQgd2hhdCBpcyBlcnJv
ciBwcm9uZT8KCkluZGl2aWR1YWwgaGFyZHdhcmUgZHJpdmVycyBpbiBnZW5lcmFsLgoKPgo+PiBT
b3JyeSwgYnV0IHRoaXMgaXMgYWJzb2x1dGVseSBkb24ndCB0aGluayB0aGF0IHRoaXMgaXMgYSBn
b29kIGlkZWEuCj4KPiBEZXNwaXRlIG90aGVyIHN1YnN5c3RlbXMgYWN0dWFsbHkg4oCcc3BhbW1p
bmfigJ0gdGhlIGxvZ3MgZm9yIHBhcmFtZXRlcnMgCj4gZ2l2ZW4gb24gdGhlIGNvbW1hbmQgbGlu
ZSwgaGVyZSBpcyBteSBtb3RpdmF0aW9uLgo+Cj4gVW5mb3J0dW5hdGVseSwgdGhlcmUgaXMgYSBz
ZXJpb3VzIGlzc3VlIHdpdGggZmlyc3QoPykgZ2VuZXJhdGlvbiBSeXplbiAKPiBDUFVzLCBhbmQg
bWF5YmUgZXZlbiBleHRlcm5hbCBBTUQgZ3JhcGhpY3MgY2FyZHMgWzFdLiBJbiBjb21tZW50IDI5
IGl0IAo+IGlzIHN1Z2dlc3RlZCB0byB1c2UgYGFtZGdwdS5kcG09MGAgWzFdLCBhbmQgZnVydGhl
ciBpdOKAmXMgc2FpZCwgaXTigJlzIAo+IGRpc2FibGluZyBwb3dlciBtYW5hZ2VtZW50LiBSZWFk
aW5nIHRoZSBjb21tZW50cyBmdXJ0aGVyIFsyXSwgdGhlIHVzZXIgCj4gZ2V0cyB0aGUgaW1wcmVz
c2lvbiB0dXJuaW5nIG9mZiBwb3dlciBtYW5hZ2VtZW50IHdpbGwgY2F1c2UgdGhlIGRldmljZSAK
PiB0byBiZSBvcGVyYXRlZCBhdCB0aGUgaGlnaGVzdCBwZXJmb3JtYW5jZSBbM10uCj4KPiBUcnlp
bmcgdGhpcyBvcHRpb24sIEkgd2FzIHN1cnByaXNlZCBvZiB0aGUgZGVncmFkZWQgcGVyZm9ybWFu
Y2UsIGFuZCAKPiBvbmx5IGluICNyYWRlb25AaXJjLmZyZWVub2RlLm5ldCBteSBxdWVzdGlvbiB3
YXMgYW5zd2VyZWQsIHNheWluZyB0aGF0IAo+IGl04oCZcyBhY3R1YWxseSBkZXBlbmRpbmcgb24g
dGhlIHN5c3RlbSBmaXJtd2FyZSBob3cgY2xvY2tzIGFyZSBzZXQgdXAsIAo+IGFuZCBpdOKAmXMg
Y29tbW9uIHRvIHVzZSB0aGUgKmxvd2VzdCogY2xvY2tzLiBTbyB0aGUgd2FybmluZyBtZXNzYWdl
LCAKPiB3b3VsZCBoYXZlIGhlbHBlZCBtZSBhIGxvdC4KClllYWggb2ssIGJ1dCB0aGF0IGhhcmR3
YXJlIGZhbGxzIGJhY2sgdG8gdGhlIGxvd2VzdCBwb3NzaWJsZSBwZXJmb3JtYW5jZSAKc2V0dGlu
ZyBhcyBzYWZldHkgcHJlY2F1dGlvbiB3aGVuIHR1cm4gb2YgcG93ZXIgbWFuYWdlbWVudCBpcyBj
b21tb24gCmtub3dsZWRnZS4KCkluIG90aGVyIHdvcmRzIHlvdSBhcmUgd3JpdGluZyBvbiB0aGUg
Y3VwIG9mIGNvZmZlZSAiQmV3YXJlIGNvbnRlbnQgaXMgaG90Ii4KCj4KPiBTbywgZXNwZWNpYWxs
eSB3aXRoIHRoZXNlIG9wdGlvbiB1c2VkIGJ5IOKAnG5vcm1hbOKAnSB1c2VycywgaGF2aW5nIGNs
ZWFyIAo+IGZlZWRiYWNrIG9uIHNwZWNpZmllZCBvcHRpb24sIGVzcGVjaWFsbHkgdGhvc2UgZGVj
cmVhc2luZyBwZXJmb3JtYW5jZSwgCj4gaXMgdmVyeSBpbXBvcnRhbnQuCgpXZWxsLCB3aGF0IHdl
IGNvdWxkIGRvIGlzIGltcHJvdmUgdGhlIGRvY3VtZW50YXRpb24gb2YgdGhlIG1vZHVsZSBvcHRp
b24uCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4KPiBLaW5kIHJlZ2FyZHMsCj4KPiBQYXVsCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
