Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F57C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 13:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE02023A60
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 13:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE02023A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C617C6E40D;
	Thu, 14 Jan 2021 13:50:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4B56E332
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 13:50:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbI1b23jiU4ZA36l9c5xOP10B6+uEYZTsDfXRq1Yky/BwG6Q3rpImX8Aj9DYF38HcLIinLvhFmWSQOi8EBCtEVS0830y8Ocu6j79e/LEhih4DOWSKcjyW8YDMakBfVlDsLgC2Y/ZRTHl91ZIyEWOgOFaOeLzbdK3+DChQypwSkGovbbyZ0ekbrRdFqpcellvTZDlHip2hVp9ZKExiT68swx08joUTJ7n1YI8I+do26t0qIkyNfau/CfRA/sFw4QbF/IvwAH2d98noGdw33YTT+aO2RXXKqPqqqaiftOxSqJPZNFSfrOm2WW+L3yGJ0ufYS4x6TooCJ3+IksmfsP/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWLrev+A+mA4X+K0fa1P6Zo4uYiJwlLoLio703Ud50A=;
 b=H1CHGAK8g2EntOLhaNK4BsaYdxg/pchgUxJJ6W1O1AlAovWzbTkIRDkKOKDhfMHbBsfPtHXuWA3kNoxVpMHihyDVnF9Z2kL5syAghmACLYP0d08bGnZ5naDkows4c72KfoTbCYNt1rHaNuNk1UJtuxQCO+6wEuzbkqmaPmqVX9wIusiOd7m+6XxGmfsVwYrBXBE45gh4WHf5keMcgEgbru4aZWe6mRlbSOYHPtcFyCjOAyD46cYvOlT9tWsVfpbHlHEMaOms2aQVPTwEan1SOT/UgwV4xfYXNbdwNHA74Mz5UdGMOtiaZT6Xq+F428rWsWg9TFswkN62rtQ+L7a2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWLrev+A+mA4X+K0fa1P6Zo4uYiJwlLoLio703Ud50A=;
 b=thLYIwyLty59P2YTi+sgIT6x6nQ/vhJErIyDSa70qIBLu2YXZYQCJ5NHNv5fIZUUUg3EDRYrQiroGw5Ny61Cqx/OzWuLnfEDSAOLo77qYjeEU5lQ/mxVSONwx9xph9wsDFjTkjRGh2je8QHmbSphm03YjrznzqPSsbLNHUVmyEo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Thu, 14 Jan
 2021 13:50:03 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3763.011; Thu, 14 Jan 2021
 13:50:03 +0000
Subject: Re: [PATCH] drm/amdgpu: change the fence ring wait timeout
To: "Deng, Emily" <Emily.Deng@amd.com>, "Sun, Roy" <Roy.Sun@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210113063612.31468-1-Roy.Sun@amd.com>
 <318aa468-c009-8edf-d6bd-8408ee79c42e@gmail.com>
 <BY5PR12MB41152A0706EA9F1A7D0E88288FA80@BY5PR12MB4115.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <bf77173f-1c26-70bd-75c7-81178f1b3e70@amd.com>
Date: Thu, 14 Jan 2021 14:49:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <BY5PR12MB41152A0706EA9F1A7D0E88288FA80@BY5PR12MB4115.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM9P191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::24) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM9P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Thu, 14 Jan 2021 13:50:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 55b20222-5300-4029-c134-08d8b8934b34
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2353C32CA6E108D2C2DFFBE783A80@BL0PR12MB2353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfK/krAia6wl8K2RSbO+VJrWZG/lRB7nV/SgUweUNjL11Fad+AbyT0zOFY0B69v+MVbHpEnSxeJgGZvG0h2Da0/9XSBgsD0zJxLi1BHzzgh1dcs8AYDNwOvdAgfwpPlwQwrx5MKuXMmVoBnghrr34lzZOl2CyKuAlXCEOjECzIblJDORgpdBnQymZYVS0iqGa25qSnBHJ4DS8NnyU+7yUiVH+Vjjmw4npiHR1VUyR49S8RH0wi+lczrHOsJ/dVSit6gCUiFrTy+zyYSPIUBfBNIxVFHABavT/+2SlIHW/drNFZpaM+hO2AvHF2gkQzSdcZSI/1MMqPa2ok4DwWLAIg3CEP6MJLCACZHIHXNd3wcDaZKu4hQQmPhI3jbhlwi4Y/UMoy2bXYL8VIY6GV8TdnTiDXtpj13Io0ipmKc2m/pzNYSsBpGxmx8rOlQi4fzZZzeoD4dkuVosEEjMpAoIzTGO1zoj63kTyBKU07zdRcN2YqenmzRfLeqMg+5B1hdySrXoEEEACNyE5MWH8K6FeS3uIJrT+AbJRufrL6emOS9t8ybLke2FRc6HbpbeuyvE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(478600001)(110136005)(36756003)(966005)(6486002)(52116002)(31686004)(316002)(45080400002)(8936002)(6666004)(31696002)(8676002)(2616005)(53546011)(5660300002)(66946007)(16526019)(186003)(83380400001)(2906002)(66476007)(66556008)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QU4xeGhySnM1UFBRR0RZRE84MUdxZUFLNjNPRUZSVHNMN3dJaDZuVDBpcHNy?=
 =?utf-8?B?aFFzT3ZvSFNXZmVwNzI4SXJPd1NpaCtnNG5jZW9hU3dvTUxLbGZDL2NiU1Yv?=
 =?utf-8?B?NVJhek9UWWFOTTJBZ3pqNkF0NEV6TFJaS3BVSDVETWpDbFhmWVRQL3MzQ2g0?=
 =?utf-8?B?TEV6WlRRNDdIMXl4UHFuaVJsZkhpY0VVVE1aK0MyZ2pvemxXdFlZY0dDL09Z?=
 =?utf-8?B?TTVyanJCUk5ERmI2WkRGQUFoc3J2cFErUElzZk5HS3U2b21wVC9mSGFrc0Nm?=
 =?utf-8?B?L3FsdjdZRHp4T2hNNDRZRzFaMmNvc2tLOWR1dWVraDRvQVp2bkJ0MHYvMkRu?=
 =?utf-8?B?N2hMTUlBWkNHNHV5RXMvUFdXRkFHc0tlenBJdDZzRVM2RjhZeUsvVStaeUww?=
 =?utf-8?B?WVIweDlwVzZqbld5bjhTenhsVDlqendBVHJvcjJiWXZSenVjaXh5OStuamdm?=
 =?utf-8?B?cGs5OExOQ3ZNNlN3T2NTSENmRFdRTlU3VU1pd09yRnZwM0owOVJjUzhCb0U4?=
 =?utf-8?B?dmUxcGVkZWgwbUlQM1cxcmwyT1hDZHZMZUp2a0JRZnd3NVJIandmNENrN1hp?=
 =?utf-8?B?Nklkbm8xQ2d2WWhyWVVTRm1Wbk1kSkVlVmsyQklkZUI2ZGRkNjR0MWFyMlVa?=
 =?utf-8?B?QU53QVgxRlQ4SDVBZnlaNEJtcTErUmJZb09wMTlkQVFjcEViTXNKTm5vRzJ5?=
 =?utf-8?B?UkJ4MFZzT2czODRabXJwK0NGVmNLWmZOcnFvck1aSkN3UC9Tc1EwNE1DOUxP?=
 =?utf-8?B?U2swUEZKTS96dGN4TjdyUmNWQitUY0lzdW1zRFlOd2R5SkloZVBnaUV3YnYy?=
 =?utf-8?B?WllMMmkvSHkzSlU3cC80aTlCdEg0U0M4ZWFqRGV1UDBYMGRtdmU4VTFDK0lS?=
 =?utf-8?B?cS9yVnJDclR5ZXduMnJZMktSMXR4SUFHdDFmZWd1TXB6aHR4cnQ3MVIwZmY0?=
 =?utf-8?B?WkpNTFVHa3NheENaMm40M1pKUHBHNE9qQmRWb1R5Q09SL0JPRXV1RlRpeGx3?=
 =?utf-8?B?bGhxMFJHYXB2NnJZYzJZWHMzRVdoYmV6RmIrRUNUMkxibEVPTEFtYTZwZHdN?=
 =?utf-8?B?SzVFVllVbFlnSklxai8xOWpFWkRSZEVZUW1uWXgzZUhHblRrc2tnVFZqeWxh?=
 =?utf-8?B?SWNQOFllQjEyNmxtQjNpeDhTb09wcitERHZ5d1FRVkwza0x6QXpOenZXRVY5?=
 =?utf-8?B?MzVES2M0S0srN0JHMUlUeXE4NmNEaklnejdOamVQNHkwM2M3RlNqV0tHMFk2?=
 =?utf-8?B?djR3bDRsdmx2TkF1a21EQ2Rxcjd4QnE1WjZRWmtJUXNQUUtBTXJiVWdwM3V2?=
 =?utf-8?B?S1hGVFNDUHROMWgrWkpMS2NBYmdQRjg5bytMRVErZHlDVHFOVGoweUpubmdZ?=
 =?utf-8?B?ZHltWldOZ2VZR292UzZMUnl5aXB1dmZ6MWZsNWVyUU1qdHc1SUZVb2hoUy82?=
 =?utf-8?Q?R9y8ECJc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2021 13:50:03.2837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b20222-5300-4029-c134-08d8b8934b34
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWqrJauHz77TXKroP2D58kcfvJypBI3yHGnKNtLALzcAMnY0ZZOtIIhITmsydReu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2353
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

QW0gMTQuMDEuMjEgdW0gMDM6MDAgc2NocmllYiBEZW5nLCBFbWlseToKPiBbQU1EIE9mZmljaWFs
IFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4KPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mCj4+IENocmlzdGlhbiBLw7ZuaWcKPj4gU2VudDog
V2VkbmVzZGF5LCBKYW51YXJ5IDEzLCAyMDIxIDEwOjAzIFBNCj4+IFRvOiBTdW4sIFJveSA8Um95
LlN1bkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogY2hhbmdlIHRoZSBmZW5jZSByaW5nIHdhaXQgdGltZW91
dAo+Pgo+PiBBbSAxMy4wMS4yMSB1bSAwNzozNiBzY2hyaWViIFJveSBTdW46Cj4+PiBUaGlzIGZp
eCBidWcgd2hlcmUgd2hlbiB0aGUgZW5naW5lIGhhbmcsIHRoZSBmZW5jZSByaW5nIHdpbGwgd2Fp
dAo+Pj4gd2l0aG91dCBxdWl0IGFuZCBjYXVzZSBrZXJuZWwgY3Jhc2gKPj4gTkFLLCB0aGlzIGJs
b2NraW5nIGlzIGludGVudGlvbmFsIHVubGltaXRlZCBiZWNhdXNlIG90aGVyd2lzZSB3ZSB3aWxs
IGNhdXNlIGEKPj4gbWVtb3J5IGNvcnJ1cHRpb24uCj4+Cj4+IFdoYXQgaXMgdGhlIGFjdHVhbCBi
dWcgeW91IGFyZSB0cnlpbmcgdG8gZml4IGhlcmU/Cj4gV2hlbiBzb21lIGVuZ2luZSBoYW5nIGR1
cmluZyBpbml0aWFsaXphdGlvbiwgdGhlIElCIHRlc3Qgd2lsbCBmYWlsLCBhbmQgZmVuY2Ugd2ls
bCBuZXZlciBjb21lIGJhY2ssIHRoZW4gbmV2ZXIgY291bGQgd2FpdCB0aGUgZmVuY2UgYmFjay4g
V2h5IHdlIG5lZWQgdG8gd2FpdCBoZXJlIGZvcmV2ZXI/IFdlJ2QgYmV0dGVyIG5vdCB1c2UgZm9y
ZXZlciB3YWl0IHdoaWNoCj4gd2lsbCBjYXVzZSBrZXJuZWwgY3Jhc2ggYW5kIGxvY2t1cC4gQW5k
IHdlIGhhdmUgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uIHdpbGwgbGV0IG1l
bW9yeSBmcmVlLiBXZSBzaG91bGQgcmVtb3ZlIGFsbCB0aG9zZSBmb3JldmVyIHdhaXQsIGFuZCBy
ZXBsYWNlIHRoZW0gd2l0aCBvbmUgdGltZW91dCwgIGFuZAo+IGRvIHRoZSBjb3JyZWN0IGVycm9y
IHByb2Nlc3MgaWYgdGltZW91dC4KClRoaXMgd2FpdCBoZXJlIGlzIHRvIG1ha2Ugc3VyZSB3ZSBu
ZXZlciBvdmVyd3JpdGUgdGhlIHNvZnR3YXJlIGZlbmNlIApyaW5nIGJ1ZmZlci4gV2l0aG91dCBp
dCB3ZSB3b3VsZCBub3Qgc2lnbmFsIGFsbCBmZW5jZXMgaW4gCmFtZGdwdV9mZW5jZV9kcml2ZXJf
Zm9yY2VfY29tcGxldGlvbigpIGFuZCBjYXVzZSBlaXRoZXIgbWVtb3J5IGxlYWsgb3IgCmNvcnJ1
cHRpb24uCgpXYWl0aW5nIGhlcmUgZm9yZXZlciBpcyB0aGUgcmlnaHQgdGhpbmcgdG8gZG8gZXZl
biB3aGVuIHRoYXQgbWVhbnMgdGhhdCAKdGhlIHN1Ym1pc3Npb24gdGhyZWFkIGdldHMgc3R1Y2sg
Zm9yZXZlciwgY2F1c2UgdGhhdCBpcyBzdGlsbCBiZXR0ZXIgCnRoYW4gbWVtb3J5IGNvcnJ1cHRp
b24uCgpCdXQgdGhpcyBzaG91bGQgbmV2ZXIgaGFwcGVuIGluIHByYWN0aWNlIGFuZCBpcyBvbmx5
IGhlcmUgZm9yIApwcmVjYXV0aW9uLiBTbyBkbyB5b3UgcmVhbGx5IHNlZSB0aGF0IGluIHByYWN0
aWNlPwoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+PiBSZWdhcmRzLAo+PiBDaHJpc3RpYW4uCj4+
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBSb3kgU3VuIDxSb3kuU3VuQGFtZC5jb20+Cj4+PiAtLS0KPj4+
ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jIHwgNDgKPj4gKysr
KysrKysrKysrKysrKysrKystLS0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA0MyBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYwo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZmVuY2UuYwo+Pj4gaW5kZXggNmIwYWVlZTYxYjhiLi43MzhlYTY1MDc3ZWEgMTAw
NjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYwo+
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPj4+IEBA
IC00MSw2ICs0MSw4IEBACj4+PiAgICAjaW5jbHVkZSAiYW1kZ3B1LmgiCj4+PiAgICAjaW5jbHVk
ZSAiYW1kZ3B1X3RyYWNlLmgiCj4+Pgo+Pj4gKyNkZWZpbmUgQU1ER1BVX0ZFTkNFX1RJTUVPVVQg
IG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkgI2RlZmluZQo+Pj4gK0FNREdQVV9GRU5DRV9HRlhfWEdN
SV9USU1FT1VUIG1zZWNzX3RvX2ppZmZpZXMoMjAwMCkKPj4+ICAgIC8qCj4+PiAgICAgKiBGZW5j
ZXMKPj4+ICAgICAqIEZlbmNlcyBtYXJrIGFuIGV2ZW50IGluIHRoZSBHUFVzIHBpcGVsaW5lIGFu
ZCBhcmUgdXNlZCBAQCAtMTA0LDYKPj4+ICsxMDYsMzggQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2Zl
bmNlX3dyaXRlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgdTMyCj4+IHNlcSkKPj4+ICAgICpk
cnYtPmNwdV9hZGRyID0gY3B1X3RvX2xlMzIoc2VxKTsKPj4+ICAgIH0KPj4+Cj4+PiArLyoqCj4+
PiArICogYW1kZ3B1X2ZlbmNlX3dhaXRfdGltZW91dCAtIGdldCB0aGUgZmVuY2Ugd2FpdCB0aW1l
b3V0Cj4+PiArICoKPj4+ICsgKiBAcmluZzogcmluZyB0aGUgZmVuY2UgaXMgYXNzb2NpYXRlZCB3
aXRoCj4+PiArICoKPj4+ICsgKiBSZXR1cm5zIHRoZSB2YWx1ZSBvZiB0aGUgZmVuY2Ugd2FpdCB0
aW1lb3V0Lgo+Pj4gKyAqLwo+Pj4gK2xvbmcgYW1kZ3B1X2ZlbmNlX3dhaXRfdGltZW91dChzdHJ1
Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpIHsKPj4+ICtsb25nIHRtb19nZngsIHRtb19tbSwgdG1vOwo+
Pj4gK3N0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gcmluZy0+YWRldjsKPj4+ICt0bW9fbW0g
PSB0bW9fZ2Z4ID0gQU1ER1BVX0ZFTkNFX1RJTUVPVVQ7Cj4+PiAraWYgKGFtZGdwdV9zcmlvdl92
ZihhZGV2KSkgewo+Pj4gK3Rtb19tbSA9IDggKiBBTURHUFVfRkVOQ0VfVElNRU9VVDsKPj4+ICt9
Cj4+PiAraWYgKGFtZGdwdV9zcmlvdl9ydW50aW1lKGFkZXYpKSB7Cj4+PiArdG1vX2dmeCA9IDgg
KiBBTURHUFVfRkVOQ0VfVElNRU9VVDsKPj4+ICt9IGVsc2UgaWYgKGFkZXYtPmdtYy54Z21pLmhp
dmVfaWQpIHsKPj4+ICt0bW9fZ2Z4ID0gQU1ER1BVX0ZFTkNFX0dGWF9YR01JX1RJTUVPVVQ7Cj4+
PiArfQo+Pj4gK2lmIChyaW5nLT5mdW5jcy0+dHlwZSA9PSBBTURHUFVfUklOR19UWVBFX1VWRCB8
fAo+Pj4gK3JpbmctPmZ1bmNzLT50eXBlID09IEFNREdQVV9SSU5HX1RZUEVfVkNFIHx8Cj4+PiAr
cmluZy0+ZnVuY3MtPnR5cGUgPT0gQU1ER1BVX1JJTkdfVFlQRV9VVkRfRU5DIHx8Cj4+PiArcmlu
Zy0+ZnVuY3MtPnR5cGUgPT0gQU1ER1BVX1JJTkdfVFlQRV9WQ05fREVDIHx8Cj4+PiArcmluZy0+
ZnVuY3MtPnR5cGUgPT0gQU1ER1BVX1JJTkdfVFlQRV9WQ05fRU5DIHx8Cj4+PiArcmluZy0+ZnVu
Y3MtPnR5cGUgPT0gQU1ER1BVX1JJTkdfVFlQRV9WQ05fSlBFRykKPj4+ICt0bW8gPSB0bW9fbW07
Cj4+PiArZWxzZQo+Pj4gK3RtbyA9IHRtb19nZng7Cj4+PiArcmV0dXJuIHRtbzsKPj4+ICt9Cj4+
PiArCj4+PiAgICAvKioKPj4+ICAgICAqIGFtZGdwdV9mZW5jZV9yZWFkIC0gcmVhZCBhIGZlbmNl
IHZhbHVlCj4+PiAgICAgKgo+Pj4gQEAgLTE2NiwxMCArMjAwLDEyIEBAIGludCBhbWRncHVfZmVu
Y2VfZW1pdChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCj4+IHN0cnVjdCBkbWFfZmVuY2UgKipm
LAo+Pj4gICAgcmN1X3JlYWRfdW5sb2NrKCk7Cj4+Pgo+Pj4gICAgaWYgKG9sZCkgewo+Pj4gLXIg
PSBkbWFfZmVuY2Vfd2FpdChvbGQsIGZhbHNlKTsKPj4+ICtsb25nIHRpbWVvdXQ7Cj4+PiArdGlt
ZW91dCA9IGFtZGdwdV9mZW5jZV93YWl0X3RpbWVvdXQocmluZyk7Cj4+PiArciA9IGRtYV9mZW5j
ZV93YWl0X3RpbWVvdXQob2xkLCBmYWxzZSwgdGltZW91dCk7Cj4+PiAgICBkbWFfZmVuY2VfcHV0
KG9sZCk7Cj4+PiAgICBpZiAocikKPj4+IC1yZXR1cm4gcjsKPj4+ICtyZXR1cm4gciA8IDAgPyBy
IDogMDsKPj4+ICAgIH0KPj4+ICAgIH0KPj4+Cj4+PiBAQCAtMzQzLDEwICszNzksMTIgQEAgaW50
IGFtZGdwdV9mZW5jZV93YWl0X2VtcHR5KHN0cnVjdAo+PiBhbWRncHVfcmluZyAqcmluZykKPj4+
ICAgIHJldHVybiAwOwo+Pj4gICAgfQo+Pj4gICAgcmN1X3JlYWRfdW5sb2NrKCk7Cj4+PiAtCj4+
PiAtciA9IGRtYV9mZW5jZV93YWl0KGZlbmNlLCBmYWxzZSk7Cj4+PiArCj4+PiArbG9uZyB0aW1l
b3V0Owo+Pj4gK3RpbWVvdXQgPSBhbWRncHVfZmVuY2Vfd2FpdF90aW1lb3V0KHJpbmcpOwo+Pj4g
K3IgPSBkbWFfZmVuY2Vfd2FpdF90aW1lb3V0KGZlbmNlLCBmYWxzZSwgdGltZW91dCk7Cj4+PiAg
ICBkbWFfZmVuY2VfcHV0KGZlbmNlKTsKPj4+IC1yZXR1cm4gcjsKPj4+ICtyZXR1cm4gciA8IDAg
PyByIDogMDsKPj4+ICAgIH0KPj4+Cj4+PiAgICAvKioKPj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZgo+PiByZWVkZXNr
dG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC0KPj4gZ2Z4JmFtcDtkYXRhPTA0JTdD
MDElN0NFbWlseS5EZW5nJTQwYW1kLmNvbSU3QzhiMTE2MjI5OTM4YjQ2Mwo+PiBkZjg3ZjA4ZDhi
N2NiZjYwNyU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlNwo+PiBD
NjM3NDYxNDMzOTM2MDQ5NTQ0JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xq
QXcKPj4gTURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0Ql
N0MxMDAwJmFtcDtzZGEKPj4gdGE9SE9jTEhtbWJsT1VIWEFURkJsNUhDNkxPbUZxMG9YZ2xBaDJH
RndkNnN1cyUzRCZhbXA7cmVzZXJ2ZQo+PiBkPTAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
