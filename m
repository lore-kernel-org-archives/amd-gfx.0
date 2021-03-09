Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910FDC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 17:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 506DD65238
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 17:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506DD65238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC1C4890A8;
	Tue,  9 Mar 2021 17:47:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E8B6E91E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 17:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDEbvznCvMa8/6Ry0Rq+fyFhCI+DAMtFY4mx92SSnVIreOUqbkgDR7mUIM0OOUtuYdpwvT7lcLMlenIqJcHLD90KnAbOkGH58FW57Phah+15wZPmKwXJ/9aF0XdBCq8hwn7Wx+86qDScpcHb1EVxmOfg9y0SF3dJHoPh6cxYbDLZK9Jk18/uX/o5K7/110m302AeE2t5i2zDxV1zTUeDzj8sLSLUiUUthY3Srm/y6Dj82ky1HODMwQnfDnZKQmfliOKVKRYXtyE2EOohN37bvcuYM55oCJ4pzo68kuhAb9fyHPv9wD8LjXb20cDEjc3T7GpMrdrb5Nl5YPhfTdibuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtOEN86Vpk49w3OKz2DDrMyBJaZ1OSF0lqvwvg5EGpU=;
 b=buC42hFqTJfmDqIjuG62kzjd6h6b3va+1nL5ygbi2pqvLXKn/EkDu9lXRW3H4uZbhoPMDbgNtJ1a2cZCpul24zha61ij6JkCKpZr1g6N5S61gk0s4owNvB9jLqJ4jOwqAw5k0RD4Rxp/m/Gi9VKFigAheQE35gCCUrdSLZWNNzHikxlbmCRckRGN5knMKHi1SQkzF8NYuBHO5xPWCPP35IzGpAk410X4s7DuMZujGoqfOezjGd1TERuZKWbWt171yRJ4QgCtu3w0gaSfFAhN960EpB9WqfmoJGBcfzAcHAJPbKfhPoxhvU2XuJutxrKL4OKVJLxEIHh6Kyg5EbIpQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtOEN86Vpk49w3OKz2DDrMyBJaZ1OSF0lqvwvg5EGpU=;
 b=HMCZh4Pe+iPRhugcH2qbVjWLqm5uOPaSwAHwwEev7yELTrnB/wdaA/s8jRc+fOv+Aiikf8XIonBypYwL/reYeaaCDqTI30jrMAry8TGVvnRuxTessM/PBEa/iOMh61jICP7FNapqTZ+NQXRiwc+YKFHM2Il0f7ThjOb17CGii3E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1830.namprd12.prod.outlook.com (2603:10b6:903:127::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 17:47:13 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3912.029; Tue, 9 Mar 2021
 17:47:13 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: add amdgpu_bo_destroy_user helper function
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>
References: <20210309165518.7721-1-nirmoy.das@amd.com>
 <9fdbd2cc-59d0-c776-2681-5adecc2f229c@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <3cfd01a3-a27b-2092-c722-8a11e7759fa5@amd.com>
Date: Tue, 9 Mar 2021 18:47:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <9fdbd2cc-59d0-c776-2681-5adecc2f229c@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.127.127]
X-ClientProxiedBy: AM0PR03CA0021.eurprd03.prod.outlook.com
 (2603:10a6:208:14::34) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.127.127) by
 AM0PR03CA0021.eurprd03.prod.outlook.com (2603:10a6:208:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 17:47:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6e27e68-7f5c-4351-ba95-08d8e3235f0a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1830:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB183009679D93338FC7E953AB8B929@CY4PR12MB1830.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KapANMbXyN8KT5utzJQ4G3fZDS2ZChn7TC8tTL8gLwe+riEvj7eSJ1rve1FE2HlgtIGUZeXuSmYgluUt/9PHexOeTsyGj87Fcht8yfGAO9TWPS1YjseQE6BEeXRZwER9U9M8Fkme6QXNL/jA1re8fOThE7A8V9o1AHf24qMj2HRTjc1OroB8DjnTmoea+csCjjiqFKHcZtYzKdx6xhIM+0nt3vwC6gU1CrcOylvCzIfO/dLX4uPOGTPBkS/DRM9W9205bb12l/xSor9jwAHPe/iTJtFSHKMb6uDugc6FSBi8bKodWxCjqIWA032q4WMOEfLwRBrvCVLBnfj3Sa+WSdcUlGgwPZ/HmOq/IcBaAQx6qFO5baIGAnAlo0NHiG85trP8oFxlFRSp+NdmlGursoch+gVr7VL1YAAhs+qSyqkmK/rbE2oyXet3kgxShUxR2Xo4z08aoxfiVLReRFZ4Yp46g5WfdyfEvR1d7cgTYkhuN1NwHqOjJwKcOB/sBRTWnXmOEpem0gxNuZwBEtvDO6lztqgmhZu1SGVsdZXy03j2tiKZC9xcO7Q0frei3p2LQtfztc7VM5uACuLfdIFITR/EtDVC7OLOpVZD3fZjkOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(8936002)(316002)(66556008)(66574015)(36756003)(31686004)(53546011)(478600001)(83380400001)(66946007)(4326008)(186003)(66476007)(8676002)(31696002)(16576012)(26005)(5660300002)(2906002)(956004)(6636002)(52116002)(6486002)(110136005)(2616005)(6666004)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?akQ5U1Jna1l2b3JNZGhaTWpGWHNqVVIzNjV0ZSswcHd5R0F2cWdoakhIMjNp?=
 =?utf-8?B?eUw2b2oycG1MamZJV1puTHBXMDNSbnMyT255bkg4amswU3AyYmlqNVJJdWJD?=
 =?utf-8?B?c2dlOXR3V2hGbjFOU3o1U2xhMnNNbDRWUlNCZkNwbUZNVlRHbjR0eTBUeDB2?=
 =?utf-8?B?WUxQWUxOYlBEb3JFbzNZWmdFWFdSUXhWWG5sdmNtVFFST0ZqNHZsRW9XV3FT?=
 =?utf-8?B?UU45ekwwbTBBUHAzc0lLdENtaEU4RmNROFB6WGZSRkZmeFhCNUFyUEZtZzQ1?=
 =?utf-8?B?MXJKY3V4dWZ3UFRFTU0xVGN0dlJkRjJ2bWNiME1XeE1lSmJYNjhTdkNsVXM0?=
 =?utf-8?B?NUtLbEJkQW9zUS9kTW1jZDQyZnVFbTM1VU1RVkNwVUxRbzZRMnZwY0doUkVS?=
 =?utf-8?B?VkRHQlk2bWI1ZW0vck11dkxneTF1a0M4OU16K1NHbG1SQ1BLRTRTaFNpR0Za?=
 =?utf-8?B?L29sdlFZK0h0WWZnZStLeDkrM2FCUDhYTURucVVBeFIxbGwwWHpCL25Cdlp2?=
 =?utf-8?B?ZGJJbGhyZGtheUtSY2JKNDhLbUNHNGdiYS9qTm5QZlhnSU5wYk0xQ3RTVU1V?=
 =?utf-8?B?UFRMU1dPb2Q4SHE4czFYVmxSbHFGOVVTbldjRmg1aXhpYlQ3WWFYall4U3RK?=
 =?utf-8?B?UjY0NldPQ1ZDM2xWa2xaamFRK05ZdUZBOGh5YkhybWZvZEJWSzE2d3pZUmNZ?=
 =?utf-8?B?NG5FbTh3aWt0NmFqNmZaYXZIa2s2Q0pFbkFhZW1XNGpRT2IrYTNhNVJWV3RD?=
 =?utf-8?B?K0tuaVVGQXZJTVpqNHJ5cUdjTkdKdER6ZTlCb1Z0Y0ZjdEFheDNraE5BMG9h?=
 =?utf-8?B?bElHRmF0c1ZqSHA1eGVzeFZKZHJvb1pYVHVpS201Qk1raVQrYkRyMTNscXR6?=
 =?utf-8?B?bDBPeGF0ZkxEcFhBbzZFTHhjZjI1U0hGQ01LZUNKekdsSng3NGJXRFAwbFJL?=
 =?utf-8?B?MUhmZThXUlNRMnZ1UDd1aWMyVUpuWU1TUHA4ODc0UkdCaWZDNE81STdEOW1V?=
 =?utf-8?B?YzFvK0JidEpIM21HcXd6QU5XVTZrYm5ZR3lERTRzYTFQSXFXWlM0L0Yxc3N2?=
 =?utf-8?B?Sm5ldjdtWmdJbWdWcUszcW1MTUwvdEdadlhDM296RGthaEQxc0p5L1JqbE5p?=
 =?utf-8?B?elhMWEVyMzF6MFZJUGk0dmtleGNKZnVLNVFMeUtNUU9vZzB2enB4TTl5RFZL?=
 =?utf-8?B?bE1sZkN3UndDMTdGK05kL2NjcWlXYWphNFcrcVJtRUx4dWc3WjVybEJmbmxo?=
 =?utf-8?B?TmJ3dFFiSzBocTBwbzZYenZUc2lmeVllU2h6S281Q1BMR2d4TUF1T2xPZ0ZX?=
 =?utf-8?B?d0t3cXVWWlFWQmJ3cVIxSG1ndEVSN3Fzc3pOZ3IvZSs3ZG5zc3BJelVEQ0JT?=
 =?utf-8?B?cmxUeTBlK2w4YUVDNDVwUXdnZDZqK090ZE03OTlPOTd5YUhuY1daaEhmajJD?=
 =?utf-8?B?TnNnaElUUDlTSUZhbUFvUUNBTUlNa05nbzNqeUt3QzRLVjkrSEl6N1dRR3lB?=
 =?utf-8?B?M3ZIL2NWL2ZldkRmbG9NL1hPQ0NmVFNKT05YdUJ0S004KzdzUXd4Y2o4L0ZH?=
 =?utf-8?B?NmZzUWFlMWpFZ2NiejJoZlhBMmkrOUExc2VlcFNJRVhIZERIalcwY1NsZ2Iy?=
 =?utf-8?B?WDErdXV6Qk1iU2xzYW96WXVtZU5kcXc2bGlPeURkUHhUV3FmSUpsYjJXTk51?=
 =?utf-8?B?REFLOElGYjhJeENZbUNRRlFlUVQwUk1MZzdsTkQycDJ0U0Ywc0ZsOGMyRkFM?=
 =?utf-8?Q?4R16/kUr31ejgjqCkMaxiPsT4UoXeMZbVK2RWAR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e27e68-7f5c-4351-ba95-08d8e3235f0a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 17:47:13.2373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aa2MxFtKUxxH77K7EVPkaXL/vNFPmbnzhBqUPz1pX3+SWNOT2XAlkf1ZzWvwWzoTH6lyOnPJ8951bw0XjwKz4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1830
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

Ck9uIDMvOS8yMSA2OjQzIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDA5LjAzLjIx
IHVtIDE3OjU1IHNjaHJpZWIgTmlybW95IERhczoKPj4gSW1wbGVtZW50IGFtZGdwdV9ib19kZXN0
cm95X3VzZXIoKSBoZWxwZXIgZnVuY3Rpb24gdG8gc2ltcGxpZnkKPj4gYW1kZ3B1X2JvX3VzZXIg
Y2xlYW51cC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQu
Y29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVj
dC5jIHwgMTkgKysrKysrKysrKysrKy0tLS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTMgaW5z
ZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPj4gaW5kZXggYWMwZTFjZDgzODU4Li5jZGQ1ZDAyZTdi
MjYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMK
Pj4gQEAgLTczLDExICs3MywyMiBAQCBzdGF0aWMgdm9pZCBhbWRncHVfYm9fc3VidHJhY3RfcGlu
X3NpemUoc3RydWN0IAo+PiBhbWRncHVfYm8gKmJvKQo+PiDCoMKgwqDCoMKgIH0KPj4gwqAgfQo+
PiDCoCArc3RhdGljIHZvaWQgYW1kZ3B1X2JvX2Rlc3Ryb3lfdXNlcihzdHJ1Y3QgYW1kZ3B1X2Jv
ICpibykKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvX3VzZXIgKnVibzsKPj4gKwo+
PiArwqDCoMKgIGlmIChiby0+dGJvLnR5cGUgIT0gdHRtX2JvX3R5cGVfZGV2aWNlKQo+PiArwqDC
oMKgwqDCoMKgwqAgcmV0dXJuOwo+PiArCj4+ICvCoMKgwqAgdWJvID0gdG9fYW1kZ3B1X2JvX3Vz
ZXIoYm8pOwo+PiArwqDCoMKgIGtmcmVlKHViby0+bWV0YWRhdGEpOwo+PiArCj4+ICt9Cj4KPiBU
aGF0IHdhcyBub3Qgd2hhdCBJIG1lYW50Lgo+Cj4gTXkgdGhpbmtpbmcgd2FzIHRoYXQgdGhlIHVz
ZXIgVFRNIEJPcyBoYXZlIGEgc2VwYXJhdGUgZGVzdHJveSBmdW5jdGlvbi4KCgpBaCBva2F5LiBJ
IHdpbGwga2VlcCBpdCBpbiBteSBtaW5kLgoKClRoYW5rcywKCk5pcm1veQoKCj4KPiBCdXQgdGhp
cyBjYW4gY29tZSBsYXRlciBvbiB3aGVuIHdlIHJlYWxseSBuZWVkIHRoaXMgZm9yIHRoZSBWTSBz
dWJzeXN0ZW0uCj4KPiBDaHJpc3RpYW4uCj4KPj4gKwo+PiDCoCBzdGF0aWMgdm9pZCBhbWRncHVf
Ym9fZGVzdHJveShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKnRibykKPj4gwqAgewo+PiDCoMKg
wqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gYW1kZ3B1X3R0bV9hZGV2KHRiby0+
YmRldik7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ibyAqYm8gPSB0dG1fdG9fYW1kZ3B1
X2JvKHRibyk7Cj4+IC3CoMKgwqAgc3RydWN0IGFtZGdwdV9ib191c2VyICp1Ym87Cj4+IMKgIMKg
wqDCoMKgwqAgaWYgKGJvLT50Ym8ucGluX2NvdW50ID4gMCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGFtZGdwdV9ib19zdWJ0cmFjdF9waW5fc2l6ZShibyk7Cj4+IEBAIC05NCwxMSArMTA1LDcgQEAg
c3RhdGljIHZvaWQgYW1kZ3B1X2JvX2Rlc3Ryb3koc3RydWN0IAo+PiB0dG1fYnVmZmVyX29iamVj
dCAqdGJvKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbXV0ZXhfdW5sb2NrKCZhZGV2LT5zaGFkb3df
bGlzdF9sb2NrKTsKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgwqDCoMKgwqAgYW1kZ3B1X2JvX3VucmVm
KCZiby0+cGFyZW50KTsKPj4gLQo+PiAtwqDCoMKgIGlmIChiby0+dGJvLnR5cGUgPT0gdHRtX2Jv
X3R5cGVfZGV2aWNlKSB7Cj4+IC3CoMKgwqDCoMKgwqDCoCB1Ym8gPSB0b19hbWRncHVfYm9fdXNl
cihibyk7Cj4+IC3CoMKgwqDCoMKgwqDCoCBrZnJlZSh1Ym8tPm1ldGFkYXRhKTsKPj4gLcKgwqDC
oCB9Cj4+ICvCoMKgwqAgYW1kZ3B1X2JvX2Rlc3Ryb3lfdXNlcihibyk7Cj4+IMKgIMKgwqDCoMKg
wqAga2ZyZWUoYm8pOwo+PiDCoCB9Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
