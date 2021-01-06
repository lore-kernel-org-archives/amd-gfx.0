Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1C7C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 07:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013172070C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 07:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013172070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4965A89D00;
	Wed,  6 Jan 2021 07:52:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16B289D00
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 07:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqp2IUhdpku1nzx//FZpiK//DpBl9P6K3oshsuD6Hd9rDGwOJCfqx2gm2u4arCJ3jbnyfaCMiasL0xNj7exDu6uTt23YTAIscjdI4oqUpDFSVm5IvyqGXanUj/BN3Mo6fV9wR05bCWPK7gNiiRSvtHNj9RfwZ1Rxp27hkxIGrFvCAocYPtHnb1nik676cuQGGI0G/cFo8g14GHkpRbdIqCE182DBEkmxpq+CSwvQuCuDKio+Ftu0EC9RQqDIgTxgwlg/+BSCBNHT3dkH3EJPgzv/J9qTRg2iwR36054qF2VI8GJqMZzJwsGJILrXfSDXFkqMtWFRZhYEyLe6ZwQcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ixBPOFn1b4RSVSsToekGkTh0Gs7X1PortANF8K04cM=;
 b=fdxc7I6aq21Knjr192G6Pu0i2jaod1HUp5Pjm3MbpQFlL2fk+3nvBZd4AhTs5NR9uyBS3kH35VSQ4JpcvAM7kFB6nhwl0RDyoX7iadiOLQyWTBX8OI1gwMrEsbSEf8v1bt6w6LptPskYwR1wQwO7WndJYTztsMpiyDoF9QzQMgXpA/JnSZskt+rNWLeXvWx085aIyG+db92jvXV0dLTeI1Tm9BywLo8L7Lat5x35a3xWPuYXnE1kKh16NbIT8aRQ9GSyM9q7ORNTz0AbLoxWulCQYzjbeSoYkg8rDTJN26D5dNBsKAm+TVnnguypg5bzkbhSEY2FFxeKkhe+PLCOEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ixBPOFn1b4RSVSsToekGkTh0Gs7X1PortANF8K04cM=;
 b=Nlb4QXQU17bSmkUm0IHlpg4VDHqhxlHb1R9l64uZRKIFFPg+gpB36+D69bJ+NAjoApy9v9caht++gW72ouFDGoEo2kXjK1d0ydzvOgtyPrsVa4uLyW075vAr3Eh8p5KmsAjoTEDecvHHBWv4y0GfGbSj5Ad0yTW+/Tcn7xkIzJk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2356.namprd12.prod.outlook.com (2603:10b6:207:4d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 07:52:11 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3742.006; Wed, 6 Jan 2021
 07:52:11 +0000
Subject: Re: [PATCH] drm/amdgpu: don't limit gtt size on apus
To: Joshua Ashton <joshua@froggi.es>, Alex Deucher <alexdeucher@gmail.com>
References: <20210105220359.1392555-1-joshua@froggi.es>
 <CADnq5_NcKG9H-dK0Kh2ksF8et+fnFkMdsejkg_RWrNeJ1JS4ng@mail.gmail.com>
 <6d6b0ae7-f732-167b-2bc1-6e517f6c8e99@froggi.es>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9902861e-77bd-d6dc-7284-0ad9bcf117b6@amd.com>
Date: Wed, 6 Jan 2021 08:52:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <6d6b0ae7-f732-167b-2bc1-6e517f6c8e99@froggi.es>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::38) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR07CA0025.eurprd07.prod.outlook.com (2603:10a6:208:ac::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.4 via Frontend Transport; Wed, 6 Jan 2021 07:52:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ef1aaa9-4d21-4508-955e-08d8b217f9be
X-MS-TrafficTypeDiagnostic: BL0PR12MB2356:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2356F5FEA66AAA0D1093B36683D00@BL0PR12MB2356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/v6wWndu/nkKwLRX9P3Rfmr62sTnx6FxpNaIJyJWQ4xneKs9Bj5aoJ2pk3lfMhbIHvz3mpDjkpThyOryf+ymwY22gsCibMMw/WC2xlPTN1ZnCcQ9aFMLoxLIrDBCfa9rVTJuvFbgyr24PlsKerqo7Foj/dTHQ/6gDVij3nC4mcSqw6JJQ8OO1lO2oYSCDsAj0KxfOZVYhYBlJmtK0IyotED4D3dnj4vANGdp2NRi/JV8CVy9qA2xmDSUWCKwq2pwjaAfFGD1rPPETL4cjROOlarz9TJDiPU+fL+JcJRZce22roXXYa1MW+HeU8rHP4drZgeaCousw+GB6uAQ/GW50bYI0wgzKjLlTt+MaHksyQAzDmTl2t1E6wNwvDH/6Pd6kiT46gL1iUg5rYyZAXSDb6BDbRLvwqzm7/BTlNGzL717cals3ZpRp7Lzf6IPbU0UVIdjHbORQqzlTsg13NCDdA8luDKhONfReopFW9+cZyMtwLc53wCKxSBglzfUvKwuZX+FK6kBLJDSZrImRQ31w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(53546011)(31686004)(966005)(186003)(52116002)(478600001)(110136005)(316002)(4326008)(83380400001)(31696002)(16526019)(6486002)(66556008)(6666004)(66946007)(66476007)(86362001)(45080400002)(2906002)(8936002)(2616005)(5660300002)(36756003)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z2J4cWNHREV2NU9wYXh1M0R6TXlqcXpId0daeXpQTXNmTm8rUjhnbUFGNXky?=
 =?utf-8?B?MVBEaWt4aW1IZlFYK2M3VHdtZ1p3R29pUkdHZ1dSU2paNG9mM3U2TVEwVFhP?=
 =?utf-8?B?ckJsSGNrc2xLS3E1dERqK2ZzNVhnb2szazlrOTN0Y2s4TmhtdGZhYzBoa0pY?=
 =?utf-8?B?VHNCVDNIcC9RMHMxdDM5NHpTc09WQkZNQUFLL3BCeGsycDQ0OWpkVWdhb05a?=
 =?utf-8?B?cnBnbG5xSWoydThDT0wxc1RZb1R5MmMyR0xXSWg4dVA5cXcwaCtFSkNyOTVY?=
 =?utf-8?B?Z1pzN2NlQXdab3p2SnRTMUx6RzVHRXhoay9aWlhhaVdCMkEySFVocXZJUXZn?=
 =?utf-8?B?ZlBWdjN6eEwxL2piSG9rUGFPdTRad25JWlozQkwvTHQzVW5MdlFpTFdSenBm?=
 =?utf-8?B?NkcwZFNHdzMvNXluZ2t2UWdXSDBKR05oQU9vNWlHc3ZVMXhGSENDVUN1a1R6?=
 =?utf-8?B?OUZ3dDNlc1ZGT1liWnBib2R0VDZBR1l1cFNVT0loUTA4eGc1cElQNVdMYXhK?=
 =?utf-8?B?WTdIMEltYnB4TU9wTW9IOVhiYjdVRTBtWTNKV3hnVk53M2ZhVHRCc2lkbUh2?=
 =?utf-8?B?M2pCcFYxbllIait2ZHA0UDZ2Z3pRdFBvSlEyVHdpd25sTXdwR0VsOTQrM2FN?=
 =?utf-8?B?MVhrbzBNV1ljdEhRSXZISWppeW41Y2xWQTBuQ3JVbFptL0oveDVEOXR2bm8y?=
 =?utf-8?B?c1ZKVTNUWmY4RmtYNHZLVitRd3FsSkplRlNrK2MyRGJPOGhzaHY3b0djWGxt?=
 =?utf-8?B?Z093ZU9UY0RlZzR0TTk5ZThIaEFHR0JpMXpVQjJ6WjMzRkoySXdweUtuaDNz?=
 =?utf-8?B?dDVrSmVUWWlGdFF5VE9JK25JS0kvQURQRWUrTThLTkhDTTl6VW96cU1Zd2NU?=
 =?utf-8?B?bDV0V3U0MFVsd0s1OGU5aWwxelZoWm9LMjBFeGsyRnVXK3RrS2ozODlkRUV0?=
 =?utf-8?B?V1hYdkhzYTlDT1Z1ZFJGdSticjFqNG5nUDB3clZ3WVJZVit4aUkvVWtOZzJ3?=
 =?utf-8?B?d2l0YWgzbFhrNDlDRnhBMHNVVUx4cEoxUHc4dVhCdXZ6c3BXbytSQURaQXdL?=
 =?utf-8?B?VEdibDBxZTJOVmVyT2krYWlHTkY0RE00TVQyU2NiTXd2dnhtbjdaSDlRcGRj?=
 =?utf-8?B?dUFEd2I2OURtRytkbmc1U2p2SVdYZGNkTTlFY3ZmLzNVSmdWRzNJa1N2clAz?=
 =?utf-8?B?VW9mN3dkRit3OHVWM25HeGg4Mmh5RUptK0FDQ0ZsUno4TFNIVzk2OWFQckZj?=
 =?utf-8?B?MGc0WFVTOUxLOVMxRkE0OEljS0puUUFsZlZjVml0d2NzZE1mVFJtdjBDcnBU?=
 =?utf-8?B?QnJSeVZGbU5pdGlBZlN6NzB0M2JtaFBLVVloQlM0VTYyS0ZLWlR3dEprYS9p?=
 =?utf-8?B?Q3dub2NxU2s4L1lIY0Q2TG9TNVhxUlFDb3BtNFJOUFJVYlIxNlhhKzlHaDVL?=
 =?utf-8?Q?trkhHkRB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 07:52:11.5234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef1aaa9-4d21-4508-955e-08d8b217f9be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GME533rGee0CuzESLM6ZvYYo79chsTyqj0WFuB9PrLaueHRrYn/uUm/BngYW+ZcG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2356
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

QW0gMDUuMDEuMjEgdW0gMjM6MzEgc2NocmllYiBKb3NodWEgQXNodG9uOgo+IE9uIDEvNS8yMSAx
MDoxMCBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+PiBPbiBUdWUsIEphbiA1LCAyMDIxIGF0IDU6
MDUgUE0gSm9zaHVhIEFzaHRvbiA8am9zaHVhQGZyb2dnaS5lcz4gd3JvdGU6Cj4+Pgo+Pj4gU2lu
Y2UgY29tbWl0IDI0NTYyNTIzNjg4YiAoIlJldmVydCAiZHJtL2FtZC9hbWRncHU6IHNldCBndHQg
c2l6ZQo+Pj4gYWNjb3JkaW5nIHRvIHN5c3RlbSBtZW1vcnkgc2l6ZSBvbmx5IiIpLCB0aGUgR1RU
IHNpemUgd2FzIGxpbWl0ZWQgYnkKPj4+IDNHaUIgb3IgVlJBTSBzaXplLgo+Pgo+PiBUaGUgY29t
bWl0IGluIHF1ZXN0aW9uIHdhcyB0byBmaXggYSBoYW5nIHdpdGggY2VydGFpbiB0ZXN0cyBvbiBB
UFVzLgo+PiBUaGF0IHNob3VsZCBiZSB0ZXN0ZWQgYWdhaW4gYmVmb3JlIHdlIHJlLWVuYWJsZSB0
aGlzLsKgIElmIGl0IGlzIGZpeGVkLAo+PiB3ZSBzaG91bGQganVzdCByZXZlcnQgdGhlIHJldmVy
dCByYXRoZXIgdGhhbiBzcGVjaWFsIGNhc2UgZEdQVXMuCj4+Cj4+IEFsZXgKPj4KPgo+IEkgdGhp
bmsgdGhlIGNvbW1pdCBiZWZvcmUgdGhlIHJldmVydCAoYmE4NTFlZWQ4OTVjKSBoYXMgc29tZSAK
PiBmdW5kYW1lbnRhbCBwcm9ibGVtczoKPgo+IEl0IHdhcyBhbHdheXMgc3BlY2lmeWluZyBtYXgo
M0dpQiwgMy80dGhzIFJBTSkgb2YgR1RULCBldmVuIGlmIHRoYXQgCj4gd291bGRuJ3QgZml0IGlu
dG8gc2F5LCAxR2lCIG9yIDJHaUIgb2YgYXZhaWxhYmxlIFJBTS4KPgo+IExpbWl0aW5nIEdUVCB0
byBtaW4obWF4KDNHaUIsIFZSQU0pLCAzLzR0aHMgUkFNKSBzaXplIG9uIGRHUFVzIG1ha2VzIAo+
IHNlbnNlIGFsc28gYW5kIGlzIGEgc2Vuc2libGUgbGltaXQgdG8gYXZvaWQgc2lsbHkgc2l0dWF0
aW9ucyB3aXRoIAo+IG92ZXJhbGxvY2F0aW9uIGFuZCBwb3RlbnRpYWwgT09NLgo+Cj4gVGhpcyBw
YXRjaCBzb2x2ZXMgYm90aCBvZiB0aG9zZSBpc3N1ZXMuCgpObywgQWxleCBpcyByaWdodCB0aGlz
IGFwcHJvYWNoIHdhcyBhbHJlYWR5IHRyaWVkIGFuZCBpdCBjYXVzZXMgcHJvYmxlbXMuCgpBZGRp
dGlvbmFsIHRvIHRoYXQgd2h5IHNob3VsZCB0aGlzIGJlIGFuIGlzc3VlPyBFdmVuIHdoZW4gVlJB
TSBpcyB2ZXJ5IApzbWFsbCBvbiBBUFVzIHdlIHN0aWxsIHVzZSAzR2lCIG9mIEdUVC4KClJlZ2Fy
ZHMsCkNocmlzdGlhbi4KCj4KPiAtIEpvc2hpZSDwn5C44pyoCj4KPj4KPj4+Cj4+PiBUaGlzIGlz
IHByb2JsZW1hdGljIG9uIEFQVXMsIGVzcGVjaWFsbHkgd2l0aCBhIHNtYWxsIGNhcnZlb3V0Cj4+
PiB3aGljaCBjYW4gYmUgYXMgbG93IGFzIGEgZml4ZWQgMTI4TWlCLCBhcyB0aGVyZSB3b3VsZCBi
ZSB2ZXJ5IGEgbGltaXRlZAo+Pj4gM0dpQiBhdmFpbGFibGUgZm9yIHZpZGVvIG1lbW9yeS4KPj4+
IFRoaXMgb2J2aW91c2x5IGRvZXMgbm90IG1lZXQgdGhlIGRlbWFuZHMgb2YgbW9kZXJuIGFwcGxp
Y2F0aW9ucy4KPj4+Cj4+PiBUaGlzIHBhdGNoIG1ha2VzIGl0IHNvIHRoZSBHVFQgc2l6ZSBoZXVy
aXN0aWMgYWx3YXlzIHVzZXMgMy80dGhzIG9mCj4+PiB0aGUgc3lzdGVtIG1lbW9yeSBzaXplIG9u
IEFQVXMgKGxpbWl0aW5nIHRoZSBzaXplIGJ5IDNHaUIvVlJBTSBzaXplCj4+PiBvbmx5IG9uIGRl
dmljZXMgd2l0aCBkZWRpY2F0ZWQgdmlkZW8gbWVtb3J5KS4KPj4+Cj4+PiBGaXhlczogMjQ1NjI1
MjM2ODhiICgiUmV2ZXJ0IGRybS9hbWQvYW1kZ3B1OiBzZXQgZ3R0IHNpemUgYWNjb3JkaW5nIHRv
Cj4+PiBzeXN0ZW0gbWVtb3J5IHNpemUgb25seSIpCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogSm9z
aHVhIEFzaHRvbiA8am9zaHVhQGZyb2dnaS5lcz4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHzCoCA1ICsrKy0tCj4+PiDCoCBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCAxMiArKysrKysrKystLS0KPj4+IMKgIDIg
ZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPj4+Cj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIAo+Pj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPj4+IGluZGV4IDcyZWZk
NTc5ZWM1ZS4uYTVhNDFlOTI3MmQ2IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMKPj4+IEBAIC0xOTIsOCArMTkyLDkgQEAgbW9kdWxlX3BhcmFtX25hbWVk
KGdhcnRzaXplLCBhbWRncHVfZ2FydF9zaXplLCAKPj4+IHVpbnQsIDA2MDApOwo+Pj4KPj4+IMKg
IC8qKgo+Pj4gwqDCoCAqIERPQzogZ3R0c2l6ZSAoaW50KQo+Pj4gLSAqIFJlc3RyaWN0IHRoZSBz
aXplIG9mIEdUVCBkb21haW4gaW4gTWlCIGZvciB0ZXN0aW5nLiBUaGUgZGVmYXVsdCAKPj4+IGlz
IC0xIChJdCdzIFZSQU0gc2l6ZSBpZiAzR0IgPCBWUkFNIDwgMy80IFJBTSwKPj4+IC0gKiBvdGhl
cndpc2UgMy80IFJBTSBzaXplKS4KPj4+ICsgKiBSZXN0cmljdCB0aGUgc2l6ZSBvZiBHVFQgZG9t
YWluIGluIE1pQiBmb3IgdGVzdGluZy4gVGhlIGRlZmF1bHQgCj4+PiBpcyAtMSAoT24gQVBVcyB0
aGlzIGlzIDMvNHRoCj4+PiArICogb2YgdGhlIHN5c3RlbSBtZW1vcnk7IG9uIGRHUFVzIHRoaXMg
aXMgM0dpQiBvciBWUkFNIHNpemVkLCAKPj4+IHdoaWNoZXZlciBpcyBiaWdnZXIsCj4+PiArICog
d2l0aCBhbiB1cHBlciBib3VuZCBvZiAzLzR0aCBvZiBzeXN0ZW0gbWVtb3J5Lgo+Pj4gwqDCoCAq
Lwo+Pj4gwqAgTU9EVUxFX1BBUk1fREVTQyhndHRzaXplLCAiU2l6ZSBvZiB0aGUgR1RUIGRvbWFp
biBpbiBtZWdhYnl0ZXMgKC0xIAo+Pj4gPSBhdXRvKSIpOwo+Pj4gwqAgbW9kdWxlX3BhcmFtX25h
bWVkKGd0dHNpemUsIGFtZGdwdV9ndHRfc2l6ZSwgaW50LCAwNjAwKTsKPj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgCj4+PiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+Pj4gaW5kZXggNGQ4ZjE5YWIxMDE0Li4y
OTRmMjZmNGYzMTAgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90
dG0uYwo+Pj4gQEAgLTE4NjUsOSArMTg2NSwxNSBAQCBpbnQgYW1kZ3B1X3R0bV9pbml0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3RydWN0IHN5c2luZm8gc2k7Cj4+Pgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc2lfbWVtaW5mbygmc2kpOwo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Z3R0X3NpemUgPSBtaW4obWF4KChBTURHUFVfREVGQVVMVF9HVFRfU0laRV9NQiA8PCAyMCksCj4+
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBhZGV2LT5nbWMubWNfdnJhbV9zaXplKSwKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgodWludDY0X3Qpc2kudG90YWxy
YW0gKiBzaS5tZW1fdW5pdCAKPj4+ICogMy80KSk7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBndHRfc2l6ZSA9ICh1aW50NjRfdClzaS50b3RhbHJhbSAqIHNpLm1lbV91bml0ICog
My80Owo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogSWYgd2UgaGF2ZSBkZWRp
Y2F0ZWQgbWVtb3J5LCBsaW1pdCBvdXIgR1RUIHNpemUgdG8KPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKiAzR2lCIG9yIFZSQU0gc2l6ZSwgd2hpY2hldmVyIGlzIGJpZ2dlcgo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgKCEoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKSkgewo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGd0dF9zaXplID0gCj4+
PiBtaW4obWF4KEFNREdQVV9ERUZBVUxUX0dUVF9TSVpFX01CIDw8IDIwLAo+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGV2
LT5nbWMubWNfdnJhbV9zaXplKSwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ3R0X3NpemUpOwo+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCB9Cj4+PiDCoMKgwqDCoMKg
wqDCoMKgIGVsc2UKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGd0dF9zaXpl
ID0gKHVpbnQ2NF90KWFtZGdwdV9ndHRfc2l6ZSA8PCAyMDsKPj4+IC0tIAo+Pj4gMi4zMC4wCj4+
Pgo+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+
IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJG
YW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDY2hyaXN0aWFuLmtvZW5pZyU0MGFtZC5jb20lN0Mw
ZGZlMGQ0YjZmNjk0ZWY0YmQzYzA4ZDhiMWM5YWIwYiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgy
ZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc0NTQ4MjcwMDUyMTQ3MDQlN0NVbmtub3duJTdDVFdGcGJH
WnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3
aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9ZVQwWG13TlB6QkMxbU9EWlFTZUhMbGNI
enFVMkR0ZmIxRTNnb0pFeTJsQSUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
