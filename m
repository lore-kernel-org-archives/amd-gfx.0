Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21A4C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 14:38:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A33EB22472
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 14:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33EB22472
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D1466E2E6;
	Mon, 18 Jan 2021 14:38:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C005A6E39B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 14:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1PufIGSsWXwHQb48jair71aMgwhiLrBWLDwA57TYHy2Lz/ph6soWbOE7X2jKwClFizDOuz76JGC5IFj3d5w2QPeycRUH61GdmRQH4dKTlMRY1Z8MCu2XRbGU4p3xrDhUlUMnzFO2CBK0uwhb8yRYGbuoC2Pt0MhY7kWYLvfnzClSTrSaeRpeQuf+yfWEM8Ix6oDmnIO1ap4U9sxT5w3x56NdLUT+x45+rBaOPkBcVV7J4B1neHihpXNFnuZmBQflol+HkhivJ1SMsalUmJjEO31RIByoQ2wdbn6zHqFcwPqdTJaA1/lKIt1gU/Ys7/AFjmSVtwYz4tnQ19lEyWaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LZn3EW08VNGsUh+TG4A7rbNysVR4Xj6X780h8eCvFQ=;
 b=cj2XjRQSRGPGBARhW3xYt6ZdcI2nPbda+Q5qn3rQ2Be1uhxL82Li+3xraqQ3jfjJSIX1gnj1wAKK7iOnIaZShIldN/BS8tib0Cvye0huh8GcJPGuluh/6ljtIFbyW4HVVbjMV0DyRDVDDzRbcQeLHnjf4EtFCKjmA4v+xSBzSAH7M8Up+kFPLVmbXbhKV13hWfcqagplJAqzM/djSNph0UAHLqKq9zN+cgHgSFGSqUhcEXp73QFUKMJMzPoOqI8L1aWZDjmFNKOyBAxC8e1CRPLK+t4DyvP0rVd8Pv3NXQcMgzVkOzOsBC8jLGPp1TbMZBQPNXYs9m6c/ZWaFEi5lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LZn3EW08VNGsUh+TG4A7rbNysVR4Xj6X780h8eCvFQ=;
 b=VeKKaqnx9q1oZs3qCY7gESAdCcK/7/FVNfFijDKbLglmM+ZaIUrH9ZxEhUWQrvUSKli0T76DbovP7jRoy57idxZcZ5v8Xamg9fDHq38nftQA8zPEUqZqMSMzWT/o7i5VBCd2FvfBZPrq5sc8rJp4jf80DpKsb8F8a7vbc+dacKw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Mon, 18 Jan
 2021 14:37:59 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 14:37:59 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: Enable userptr support when KFD is enabled
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20210115182423.32368-1-Felix.Kuehling@amd.com>
 <a4af46c0-f33e-d93a-4eae-bee52892e8bf@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b94a787c-f7f2-1141-c7df-c0950f8d1904@amd.com>
Date: Mon, 18 Jan 2021 09:37:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <a4af46c0-f33e-d93a-4eae-bee52892e8bf@gmail.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Mon, 18 Jan 2021 14:37:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d63f6cd-be6a-405e-05f1-08d8bbbea6ff
X-MS-TrafficTypeDiagnostic: MN2PR12MB4357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4357C8DE8E214BFD4B79B82492A40@MN2PR12MB4357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZ5bmDiEoK7Tt7ANtmavKYXGPp67ny39fqri2x0bkN5naVXpST9UU33NFqXDOMEDCYu/vOy8S9AeNGIbN5eVd+opvzX4Y8+nmmZderUqb8Kf1FjJ+GohzHWaVjG2A//ZjaR0gJ78m5oTvbxSUOV3+b3lNeCEPTeoUJcvmZwXTOpZwU5BbRqv6LB64rrnvYaY/eRSPlHlmoQmW+RVNz0HI8eNofusMJ9E8Yv37eMg82WuOXj7bLxvbHohlySyAhjPC8x+QNAOJ++l5/3y1q0RyK6FSsfGFkQ/hmX6bryHZ0qQYcBMYlfZHGWmBQSyw3hvHpfEVWQzSNIdvRuQCqimcKaXruX2bfV2ad+0Kd7dO8gmVBL5l4rV/aIbU4gB2wrXCYECozJt5HBMrgBaRnwBBcgAWlabAiEmXwELP95bqHTpyvk2Cr01/kBsiPy43Kk49KCXswED34bNtpQw2Z+sLtECfpDmt1V4cvjNhYzdZI0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(52116002)(8676002)(44832011)(16576012)(31696002)(2616005)(316002)(956004)(86362001)(66476007)(66556008)(36756003)(478600001)(8936002)(6486002)(5660300002)(2906002)(186003)(26005)(16526019)(31686004)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dlJobWowMlpDeUQzNmVxNVNjTW9ZZzYwSVcyVENBSjl2OXJQSjBUNXB4Uit1?=
 =?utf-8?B?emxFUUNDKzd5eGpKU1g1UGlEdnFjeHZQK2h4UC8wT0F4U3Z6SzNsd1pvUXhE?=
 =?utf-8?B?WTNBb1hHdlhQR0loQnBpNnB4bDM5QlRFOEdWaGtOcEwyeUErVkk5SXc1aTU3?=
 =?utf-8?B?TUFTTGtTK2dZSGxKT2F0Y1pmUlo3WHppbm9OeUJWSzNpRlowYjl6R3g4enNT?=
 =?utf-8?B?elpTL25Ud3lLNGNDT2o3cWxUY1h3bE9aUWVReDFacXhGWDRNcE5WclNvN2t1?=
 =?utf-8?B?akJheS96emMvUDJ2MkhHZnZlUElucVByQmFvbGFEL3licnJlWVlHQ1dkR0Qw?=
 =?utf-8?B?K1d1TnUrbGtVVUNFcWpLdWxIZVQrWG93WVBCNFdjMUJnRXhYYlhTdkd2a0Rj?=
 =?utf-8?B?bjdqQ0tDRFFFUDRDVXRjVC9Ma3MwbWhHSTlIY1BFV1NOVkw4a05nZmcra2d5?=
 =?utf-8?B?Ry9MZW8wYWczSitjQnJZY3dvL1dpVU01Uit5MFBhUlYvQ29YZGdqbWxDNDhU?=
 =?utf-8?B?S056UHF1QnBHUUtOTDlSQUFRS0ZyR3hDSkdmbmw0SXlOeTFlN2hkZlk5c1Vk?=
 =?utf-8?B?NDdJZG00cVBCUjB5WUN5M2VsL2xDYlBuSi9GTjN5Rmw1MzlxajlJVVdiak1Z?=
 =?utf-8?B?dVFJb3RHMGgrZE45a21CN1RSc3JpdUNUOCt3eHM2WXJPR3lJVTE3cnRkSDJN?=
 =?utf-8?B?aDZaM3dIQVRRUHpiUGVGT2dDdkI2ZDk2T1FrUG5lbEIzRjRla20zRG1iSU8w?=
 =?utf-8?B?aDNnL2c0WUZtMU82T09wMmJwbUZJNmpjVXg0dSs5eWxuYURCUG0yOFc1N0xL?=
 =?utf-8?B?WnVicHVBUyt0Y2UyRmlaZzQvcW5OeU9uWEhSTDNCUTM2aXVZaUhibENrTCs0?=
 =?utf-8?B?Q0p4bTZkaEZ0djZVOS9EbmpzZDZVMmpUMVllZHBieGh5SHppcE1Xck9HSGZV?=
 =?utf-8?B?aVlRK2FZYnFwcE1MdDFvdG11UlNvSk9jK2hkZWVZM25DdFFHQXpmWWdIYUdQ?=
 =?utf-8?B?eG5LVC92L2ZtV3ZlczdoYWVIR3kvUDBEbjk5MXJFSk9VUlFNTkJrUXhtSHNm?=
 =?utf-8?B?UkJlV29CMXVNd2ZqMkd0YjVoN2xnSXNjRXhYOThNcHhMUXlGaDl4dGlJSUp0?=
 =?utf-8?B?UzVZa0pMdEs3V2ZoWlJraUc2TDdNWUZYbmNtR1h0Z2k0MllGcGFCVjJMMWVF?=
 =?utf-8?B?ZUpSWXRDWkdhNXhBd2puRDRZT1IwMFlSZWJjZVNwdytkUW82OUE5Q2EvMktK?=
 =?utf-8?B?dklPcXpGVW5JVlBOZUwyYnhCK0lYL1IvWnRzYUtObVJ0YXpnVy8rVmJBTjNL?=
 =?utf-8?Q?ep+NTMgF0+gVbv7msR+775PFWoG2TEg2QV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d63f6cd-be6a-405e-05f1-08d8bbbea6ff
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 14:37:59.5295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0Z3uSyxj3wHKUPAo176kvZEP3dQqmMQrtBrymV88QWgcvsG5UdBQtyJDl5ciwR22apUJgyFuNA0RDJYzxsvUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wMS0xOCB1bSAyOjUzIGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFt
IDE1LjAxLjIxIHVtIDE5OjI0IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+IFJPQ20gdXNlciBt
b2RlIGRlcGVuZHMgb24gdXNlcnB0ciBzdXBwb3J0LiBXaXRob3V0IGl0LCBLRkQgaXMgYmFzaWNh
bGx5Cj4+IHVzZWxlc3MuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxp
eC5LdWVobGluZ0BhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQvS2NvbmZpZyB8IDEgKwo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPj4K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcKPj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9LY29uZmlnCj4+IGluZGV4IGU4ZmIxMGM0MWYxNi4u
MjgwMGIyYmIyNTIyIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9L
Y29uZmlnCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcKPj4gQEAg
LTgsNSArOCw2IEBAIGNvbmZpZyBIU0FfQU1ECj4+IMKgwqDCoMKgwqAgZGVwZW5kcyBvbiBEUk1f
QU1ER1BVICYmIChYODZfNjQgfHwgQVJNNjQgfHwgUFBDNjQpCj4+IMKgwqDCoMKgwqAgaW1wbHkg
QU1EX0lPTU1VX1YyIGlmIFg4Nl82NAo+PiDCoMKgwqDCoMKgIHNlbGVjdCBNTVVfTk9USUZJRVIK
Pj4gK8KgwqDCoCBzZWxlY3QgRFJNX0FNREdQVV9VU0VSUFRSCj4KPiBJIHRoaW5rIHdlIHNob3Vs
ZCByYXRoZXIgbWFrZSB0aGF0IGEgZGVwZW5kcyBvbi4gT3RoZXJ3aXNlIHdlIHNlbGVjdCBhCj4g
dmlzaWJsZSBjb25maWcgb3B0aW9uLgoKSSB3YXMgY29uc2lkZXJpbmcgdGhhdC4gVGhlIHByb2Js
ZW0gd2l0aCB0aGF0IGlzLCB0aGF0IHRoZSBIU0FfQU1ECm9wdGlvbiB3b24ndCBldmVuIHNob3cg
dXAgaW4gbWVudWNvbmZpZyB1bmxlc3MgRFJNX0FNREdQVV9VU0VSUFRSIGlzCnNlbGVjdGVkLiBJ
J2QgcmF0aGVyIGFsd2F5cyBzaG93IHRoZSBIU0FfQU1EIG9wdGlvbiBhbmQgc2VsZWN0IHdoYXQg
aXQKbmVlZHMuCgpJcyB0aGVyZSBhIGdvb2QgcmVhc29uIHdoeSBBTURHUFVfVVNFUlBUUiBpcyBh
ICJ2aXNpYmxlIiBjb25maWcgb3B0aW9uPwpXaGF0IHdvdWxkIGJlIGEgcmVhc29uIGZvciBhIHVz
ZXIgdG8gZGVsaWJlcmF0ZWx5IGRpc2FibGUgdGhpcz8KClJlZ2FyZHMsCsKgIEZlbGl4CgoKPgo+
IENocmlzdGlhbi4KPgo+PiDCoMKgwqDCoMKgIGhlbHAKPj4gwqDCoMKgwqDCoMKgwqAgRW5hYmxl
IHRoaXMgaWYgeW91IHdhbnQgdG8gdXNlIEhTQSBmZWF0dXJlcyBvbiBBTUQgR1BVIGRldmljZXMu
Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
