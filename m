Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849C4C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 14:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE2D2336E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 14:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE2D2336E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B610E6E255;
	Wed, 20 Jan 2021 14:16:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E6A06E255
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 14:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l77pb2ZDnP1gnK2xr+T5svCEY4l4lB2aDWGxhY3I1ivbuNHWwyhkBhjwx4cnXt0txoIgUY/gmV51PJRhT0WFYtYSEy/IJBM/+9Mj4W8Un/kNaK0ZA62X1hKhqepC91CfH4IkGmo8AFtJV1ZOmj1AE5h3bNb1A5+ANCBwEh8/vpf6hNaIKWNsbS6Qw7Xr2X5J/0IXmfPST5obVu7mhEtYtInfS0ydonCovONM2d2K/UBADleBxYdUCNeQ/duJUZOBHTu2yMt6zmQ5GgsKua7miHAt+Qy6YHXb3SsA8/naHK4uMRpY8qmVYrdNhAqJ0yNzJ5ILtguGTyYhpk+pdpN7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4DlX53y7pIpQiMt5TRUZ0Xeqt3D7xWywRjObIjzUBQ=;
 b=c7xD3HEtdnlAKa/8KtgnUix6imv+Bc4cgHi/cbw+6mNHb9ic3PLN0acIB/oaM1KZknQg0c2ydJQQv7Swj7agLheNMofxznTi4c0hD6/u3dtOQIbravIJgugv7QaDWjotCnYBy3EGe4NY3EdFfScn7fLzsVa2YLRiC0hTwefG+TXr1cARQtZOCWMNlFegWFi25QH+AibxFY8mIjdxgxLwyZpogjk6or1mDE+Bg38NO2ayb1hqT4HBlFuFpo6p/zSlRhKj+BpWleOjA/uCfOz2Yo9N223BR7M2OO9yszK/lzaCJu1wLWVauu9Ky52cXQXrmU8qBN2uxXqF5AFVysALog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4DlX53y7pIpQiMt5TRUZ0Xeqt3D7xWywRjObIjzUBQ=;
 b=oXmNOMzTGUe1ocf1rFhBVrTpszug4fAdxS+XSW9VjquQNZyukSkGs1DE59gZobXB2y/z+DyHiSM3w6XASvEbfk5/Bohff0+Au58X8DC+hsobJJzJKJRxYSXAvgDyvjN4QCyWcxCCIK57YJ9iltvB97bRO4kyKQH8R+SXkqZdv0o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Wed, 20 Jan
 2021 14:16:31 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::d475:3e33:bb03:8471]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::d475:3e33:bb03:8471%3]) with mapi id 15.20.3742.014; Wed, 20 Jan 2021
 14:16:31 +0000
Subject: Re: [PATCH] drm/amd/display: Implement functions to let DC allocate
 GPU memory
To: christian.koenig@amd.com, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 alexander.deucher@amd.com
References: <20210119204030.2794877-1-Bhawanpreet.Lakha@amd.com>
 <fab8baec-78fa-d816-3e05-ad94215c83f2@gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <557da931-da68-2867-6f0b-611e1c4cd70b@amd.com>
Date: Wed, 20 Jan 2021 09:16:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <fab8baec-78fa-d816-3e05-ad94215c83f2@gmail.com>
Content-Language: en-US
X-Originating-IP: [24.212.165.133]
X-ClientProxiedBy: YQXPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::47) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.180] (24.212.165.133) by
 YQXPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Wed, 20 Jan 2021 14:16:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 565087c0-d13d-4bc3-0943-08d8bd4dfc15
X-MS-TrafficTypeDiagnostic: BY5PR12MB4163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4163BE4A48267EC62F371ADCECA20@BY5PR12MB4163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7uPcnOtInlA8qOCT/ogfO74pw3OlPKjvSa1EvrF7j/oJNNbgNEeDtwrgNiybTUR+G8BPdJ9kNk0GarJGUzoi0Jf6mczNwpy6QpbQTAHC/LfrJk0E1Thh5+zLn245+KPKoLkBvSoUBWyq3q7IY5zIy5/syEGKoEJ7ZlqKRXxmABsFmjYD8K28JJxFsTtiWvu5Mx+aCnWA+cB8MQVFFZjS4WKgNRYYCU8hy5D0lftX90aMjCoo0y3CbqGfnkWwkVPftLRgXQWS7dt9ytDoKB/FLRLd8EJpGQVjjq7Xz/3yWjCo5btmIOEmCHhQGYlQYWoPnE5+ZJs2IsoDQda2zf04fyUnFORmLM69CPzS77mzJwq+NQl73YUScOtBbw8AQOCWSJD6uiumurAQVl9AibPbnFGjzVqPER7CbhCUvy47FufKS4pm9qmmFtIYOrjEuv4srIikXkaFkOhkXrklkzlPDNVITNdzS7d5wCMZIHlsru6LFIHT0rasaLY8F5Ad7TvOE5B7Hol8CqnZvtf0s5GHgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(956004)(966005)(478600001)(36756003)(316002)(2906002)(2616005)(4326008)(6636002)(8676002)(8936002)(31686004)(45080400002)(16526019)(53546011)(66574015)(186003)(86362001)(66556008)(31696002)(26005)(16576012)(66476007)(52116002)(6486002)(6666004)(83380400001)(5660300002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cjRpQUs3bE8vT1hQOTIvaE84bFE4K1V6N0oyQkNoY082MTJQUjd0VTh6dXdw?=
 =?utf-8?B?a20ya0doWDNTajBnbVFYeTBZenkrVDFoMkIwYnMzWG9vNGVQVGtzb2Nta3g3?=
 =?utf-8?B?eHEwSHMzWVY5WEQvUzVIOVJTOUdsbDU2TU5BTkI5QVZ4NFpEeTFlNC9QRUYx?=
 =?utf-8?B?UWpLc21laXlubkJsNTVXR2RZTC9USSttbjgzSVBFSmcrMlVTZ2U3N1kwVURX?=
 =?utf-8?B?cjJTN3drazRRTFZIeEhyQU1mRjZYQUR1MWxhRkhyRTdGT0YwQXkrZjV3MEQ4?=
 =?utf-8?B?Y1dCVGJiWWF1Ym42bTRyYnc1ZnNkSXJwVThkbExSaU9wTTlwbUNzcWw2MUE5?=
 =?utf-8?B?R0FWQW1lcXFJUjBlVkxEWmpoK2JpSlc1RWRBRkdrVkFhWGxyYVhrdFZCekdh?=
 =?utf-8?B?WjJmSmw5V1YxTWFMUnhlUWhwcU9HK2psd09TcXBqbzRlb0R2K284T1MvSlhT?=
 =?utf-8?B?MkQzdzNWaXgvakc3WmJxQ3FJU0tncjZvemZDYStDYlJWNmh1TG9IMEhLOGZZ?=
 =?utf-8?B?bEoyYVpxMndGblNQUlF3L283aGRTaml6QzhFOGFFSmZTVWRHVlFFdzdkNFlC?=
 =?utf-8?B?cUNVOFJEcXhuSHZXNjl6TXV5U3hveFNnaENxZStzUWNLRmFPRzdlZi9VNFQy?=
 =?utf-8?B?eEpvNDJCbFBpVGVveGR3SUtyekdsWUdzQlRFVVBDcXJmelBaM2tDelFabXBr?=
 =?utf-8?B?QTJEcDVyZXRsMnMyQStoQklVTnlTeGFMMm5DWUN0UGkxQnNXZTY3SGxxc2Ry?=
 =?utf-8?B?NGxINmxVRnFUcDZWS0NHU3R2QStWeGtsN0xCaXJTOUd3VEp2SnJraWZja1ZL?=
 =?utf-8?B?K0Rjd0wvSzhEM25ZWHZESHNuS0FsZThkUnVheXRpcm42TjRSVjNFeC9vK2pQ?=
 =?utf-8?B?SVMzRC9VZDhxQzQ4N2FRNnNCZkw2ZVJrMm5sT2dGVi9ucEhlZVBUd0ozOGlh?=
 =?utf-8?B?L1I4UUVWMkpkTklqQXlwNUR2a1FpSW9vckR3TTdtNnhBUVQ4MUJMTXVpUHpF?=
 =?utf-8?B?anJjTmF0Qkt1Z2hqV0VjOHBlOUFxQkxyOXR4Qlpyc1ZrUkdsV1dUVThjbDI1?=
 =?utf-8?B?MXA3b29IK2dZSzJFQmltMWJ6WUxUS1laeE9aQUllNDR4eEV0ejBwWXF2cWhx?=
 =?utf-8?B?RVZpZjBQNDNjSjFqVVJOemVqTlZUZDNPUnJUSVlCaHF4MlQxR2d0TFJjcEFQ?=
 =?utf-8?B?SU9iRmNxaHhUWWJwRUYxcVlQamo5WVZuVEUvRWFFM0FvZEtXK3RmeGNNdE9n?=
 =?utf-8?B?ZmxVL2lrL3JianJteGtSNlluOXRMcnZGZm9iM3pyeTF6YmV4ait2QUZHQ01Z?=
 =?utf-8?Q?xefblxPh8egwKlhZ19NTVeP/gYUZ1Pfqga?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565087c0-d13d-4bc3-0943-08d8bd4dfc15
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 14:16:31.4702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHwTYt2p5afgUsK/0ZvzOXfmjoA+dv/G6CSUd8iLwitWvcwLOXJAoU+GdyHbcuKlrj1M3RfoZSsZtLGhV8EfEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
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
Cc: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMS0yMCA1OjI2IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTku
MDEuMjEgdW0gMjE6NDAgc2NocmllYiBCaGF3YW5wcmVldCBMYWtoYToKPj4gRnJvbTogSGFycnkg
V2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4+Cj4+IFtXaHldCj4+IERDIG5lZWRz
IHRvIGNvbW11bmljYXRlIHdpdGggUE0gRlcgdGhyb3VnaCBHUFUgbWVtb3J5LiBJbiBvcmRlcgo+
PiB0byBkbyBzbyB3ZSBuZWVkIHRvIGJlIGFibGUgdG8gYWxsb2NhdGUgbWVtb3J5IGZyb20gd2l0
aGluIERDLgo+Pgo+PiBbSG93XQo+PiBDYWxsIGFtZGdwdV9ib19jcmVhdGVfa2VybmVsIHRvIGFs
bG9jYXRlIEdQVSBtZW1vcnkgYW5kIHVzZSBhCj4+IGxpc3QgaW4gYW1kZ3B1X2Rpc3BsYXlfbWFu
YWdlciB0byB0cmFjayBvdXIgYWxsb2NhdGlvbnMgc28gd2UKPj4gY2FuIGNsZWFuIHRoZW0gdXAg
bGF0ZXIuCj4gCj4gV2VsbCB0aGF0IGxvb2tzIGxpa2UgY2xhc3NpYyBtaWQtbGF5ZXJpbmcgdG8g
bWUgd2l0aCBhIGhvcnJpYmxlIAo+IGltcGxlbWVudGF0aW9uIG9mIHRoZSBmcmVlIGZ1bmN0aW9u
Lgo+IAo+IENocmlzdGlhbi4KCkZXSVcgdGhpcyBpcyBvbmx5IHJlYWxseSB1c2VkIGR1cmluZyBk
ZXZpY2UgY3JlYXRpb24gYW5kIGRlc3RydWN0aW9uIHNvIAp0aGUgb3ZlcmhlYWQgb2YgdGhlIGZy
ZWUgZnVuY3Rpb24gaXNuJ3QgYSBjb25zaWRlcmFibGUgY29uY2Vybi4KCkRvZXMgQU1ER1BVIGFs
d2F5cyBuZWVkIHRvIGtub3cgdGhlIEdQVSBhZGRyZXNzIGZvciB0aGUgYWxsb2NhdGlvbiB0byAK
ZnJlZSBvciBzaG91bGQgd2Ugd29yayBvbiBmaXhpbmcgdGhlIGNhbGxzaXRlcyBmb3IgdGhpcyB0
byBwYXNzIGl0IGRvd24/CgpXZSBnZW5lcmFsbHkgc2VwYXJhdGUgdGhlIENQVS9HUFUgcG9pbnRl
ciBidXQgbWF5YmUgaXQnZCBiZSBiZXN0IHRvIGhhdmUgCnNvbWUgc29ydCBvZiBhbGxvY2F0aW9u
IG9iamVjdCBoZXJlIHRoYXQgaGFzIGJvdGggZm9yIERDJ3MgcHVycG9zZXMuCgpSZWdhcmRzLApO
aWNob2xhcyBLYXpsYXVza2FzCgo+IAo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBIYXJyeSBXZW50bGFu
ZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIC4uLi9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8wqAgMiArCj4+IMKgIC4uLi9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uaCB8wqAgOSArKysrKwo+PiDCoCAuLi4vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZWxwZXJzLmMgfCA0MCArKysrKysrKysrKysr
KysrKy0tCj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uYwo+PiBpbmRleCBlNDkwZmMyNDg2ZjcuLjgzZWM5MmE2OWNiYSAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbS5jCj4+IEBAIC0xMDE3LDYgKzEwMTcsOCBAQCBzdGF0aWMgaW50IGFtZGdwdV9kbV9pbml0
KHN0cnVjdCBhbWRncHVfZGV2aWNlIAo+PiAqYWRldikKPj4gwqDCoMKgwqDCoCBpbml0X2RhdGEu
c29jX2JvdW5kaW5nX2JveCA9IGFkZXYtPmRtLnNvY19ib3VuZGluZ19ib3g7Cj4+ICvCoMKgwqAg
SU5JVF9MSVNUX0hFQUQoJmFkZXYtPmRtLmRhX2xpc3QpOwo+PiArCj4+IMKgwqDCoMKgwqAgLyog
RGlzcGxheSBDb3JlIGNyZWF0ZS4gKi8KPj4gwqDCoMKgwqDCoCBhZGV2LT5kbS5kYyA9IGRjX2Ny
ZWF0ZSgmaW5pdF9kYXRhKTsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmggCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uaAo+PiBpbmRleCAzOGJjMGY4OGIyOWMuLjQ5MTM3OTI0
YTg1NSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uaAo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1
X2RtL2FtZGdwdV9kbS5oCj4+IEBAIC0xMzAsNiArMTMwLDEzIEBAIHN0cnVjdCBhbWRncHVfZG1f
YmFja2xpZ2h0X2NhcHMgewo+PiDCoMKgwqDCoMKgIGJvb2wgYXV4X3N1cHBvcnQ7Cj4+IMKgIH07
Cj4+ICtzdHJ1Y3QgZGFsX2FsbG9jYXRpb24gewo+PiArwqDCoMKgIHN0cnVjdCBsaXN0X2hlYWQg
bGlzdDsKPj4gK8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvICpibzsKPj4gK8KgwqDCoCB2b2lkICpj
cHVfcHRyOwo+PiArwqDCoMKgIHU2NCBncHVfYWRkcjsKPj4gK307Cj4+ICsKPj4gwqAgLyoqCj4+
IMKgwqAgKiBzdHJ1Y3QgYW1kZ3B1X2Rpc3BsYXlfbWFuYWdlciAtIENlbnRyYWwgYW1kZ3B1IGRp
c3BsYXkgbWFuYWdlciAKPj4gZGV2aWNlCj4+IMKgwqAgKgo+PiBAQCAtMzUwLDYgKzM1Nyw4IEBA
IHN0cnVjdCBhbWRncHVfZGlzcGxheV9tYW5hZ2VyIHsKPj4gwqDCoMKgwqDCoMKgICovCj4+IMKg
wqDCoMKgwqAgc3RydWN0IGFtZGdwdV9lbmNvZGVyIG1zdF9lbmNvZGVyc1tBTURHUFVfRE1fTUFY
X0NSVENdOwo+PiDCoMKgwqDCoMKgIGJvb2wgZm9yY2VfdGltaW5nX3N5bmM7Cj4+ICsKPj4gK8Kg
wqDCoCBzdHJ1Y3QgbGlzdF9oZWFkIGRhX2xpc3Q7Cj4+IMKgIH07Cj4+IMKgIGVudW0gZHNjX2Ns
b2NrX2ZvcmNlX3N0YXRlIHsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hlbHBlcnMuYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZWxwZXJzLmMKPj4gaW5kZXggMzI0NGE2
ZWE3YTY1Li41ZGM0MjZlNmU3ODUgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hlbHBlcnMuYwo+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZWxwZXJzLmMKPj4gQEAgLTY1
Miw4ICs2NTIsMzEgQEAgdm9pZCAqZG1faGVscGVyc19hbGxvY2F0ZV9ncHVfbWVtKAo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgc2l6ZV90IHNpemUsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBsb25nIGxv
bmcgKmFkZHIpCj4+IMKgIHsKPj4gLcKgwqDCoCAvLyBUT0RPCj4+IC3CoMKgwqAgcmV0dXJuIE5V
TEw7Cj4+ICvCoMKgwqAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBjdHgtPmRyaXZlcl9j
b250ZXh0Owo+PiArwqDCoMKgIHN0cnVjdCBkYWxfYWxsb2NhdGlvbiAqZGE7Cj4+ICvCoMKgwqAg
dTMyIGRvbWFpbiA9ICh0eXBlID09IERDX01FTV9BTExPQ19UWVBFX0dBUlQpID8KPj4gK8KgwqDC
oMKgwqDCoMKgIEFNREdQVV9HRU1fRE9NQUlOX0dUVCA6IEFNREdQVV9HRU1fRE9NQUlOX1ZSQU07
Cj4+ICvCoMKgwqAgaW50IHJldDsKPj4gKwo+PiArwqDCoMKgIGRhID0ga3phbGxvYyhzaXplb2Yo
c3RydWN0IGRhbF9hbGxvY2F0aW9uKSwgR0ZQX0tFUk5FTCk7Cj4+ICvCoMKgwqAgaWYgKCFkYSkK
Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBOVUxMOwo+PiArCj4+ICvCoMKgwqAgcmV0ID0gYW1k
Z3B1X2JvX2NyZWF0ZV9rZXJuZWwoYWRldiwgc2l6ZSwgUEFHRV9TSVpFLAo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRvbWFpbiwgJmRhLT5ibywKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmZGEtPmdwdV9hZGRyLCAm
ZGEtPmNwdV9wdHIpOwo+PiArCj4+ICvCoMKgwqAgKmFkZHIgPSBkYS0+Z3B1X2FkZHI7Cj4+ICsK
Pj4gK8KgwqDCoCBpZiAocmV0KSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBrZnJlZShkYSk7Cj4+ICvC
oMKgwqDCoMKgwqDCoCByZXR1cm4gTlVMTDsKPj4gK8KgwqDCoCB9Cj4+ICsKPj4gK8KgwqDCoCAv
KiBhZGQgZGEgdG8gbGlzdCBpbiBkbSAqLwo+PiArwqDCoMKgIGxpc3RfYWRkKCZkYS0+bGlzdCwg
JmFkZXYtPmRtLmRhX2xpc3QpOwo+PiArCj4+ICvCoMKgwqAgcmV0dXJuIGRhLT5jcHVfcHRyOwo+
PiDCoCB9Cj4+IMKgIHZvaWQgZG1faGVscGVyc19mcmVlX2dwdV9tZW0oCj4+IEBAIC02NjEsNSAr
Njg0LDE2IEBAIHZvaWQgZG1faGVscGVyc19mcmVlX2dwdV9tZW0oCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBlbnVtIGRjX2dwdV9tZW1fYWxsb2NfdHlwZSB0eXBlLAo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgdm9pZCAqcHZNZW0pCj4+IMKgIHsKPj4gLcKgwqDCoCAvLyBUT0RPCj4+ICvCoMKgwqAgc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBjdHgtPmRyaXZlcl9jb250ZXh0Owo+PiArwqDCoMKg
IHN0cnVjdCBkYWxfYWxsb2NhdGlvbiAqZGE7Cj4+ICsKPj4gK8KgwqDCoCAvKiB3YWxrIHRoZSBk
YSBsaXN0IGluIERNICovCj4+ICvCoMKgwqAgbGlzdF9mb3JfZWFjaF9lbnRyeShkYSwgJmFkZXYt
PmRtLmRhX2xpc3QsIGxpc3QpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChwdk1lbSA9PSBkYS0+
Y3B1X3B0cikgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfYm9fZnJlZV9rZXJu
ZWwoJmRhLT5ibywgJmRhLT5ncHVfYWRkciwgJmRhLT5jcHVfcHRyKTsKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbGlzdF9kZWwoJmRhLT5saXN0KTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAga2ZyZWUoZGEpOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4gK8KgwqDC
oMKgwqDCoMKgIH0KPj4gK8KgwqDCoCB9Cj4+IMKgIH0KPiAKPiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5v
cmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDElN0NuaWNo
b2xhcy5rYXpsYXVza2FzJTQwYW1kLmNvbSU3QzY1MDk2ZjFhMDViZjQzNzljMWNkMDhkOGJkMmRk
NWExJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzQ2NzM1
MTg2MjYyMzgxOCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxD
SlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtz
ZGF0YT1LcmYzZXBaJTJGc0FXT21IUmhVU3VrcUVqS0pKQkx3dEtORWU3R1dZS0JHMXclM0QmYW1w
O3Jlc2VydmVkPTAgCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
