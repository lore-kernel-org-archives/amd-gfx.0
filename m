Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC12FC433E6
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 20:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7342964DF3
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 20:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7342964DF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E6B6E0DB;
	Thu, 25 Feb 2021 20:05:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F096C6E0DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 20:05:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+BNDmuXbuQ7jMXQZlxEFTwrCZA7L1404Sh/6Zmi4AeVIrpvn5HexBcp3k1vWlqKnIh564xARrg4g8SIpa1t972k73RB76QaQybeBghCp5c7A1MC/aDiSe1k2DU9FgOwuINp64TB1T337Vw++uH7OFKexWkszXnmJq2+WZpGuJv4RT4NTml5tqa05L3JEgbwIM0YD9Cm5Cwy7uWKx1oEDdz2sIsa7hJ+Ty58L/j0yUuYlH2ifhKG6w/9N9+FvPa0nhMk0sDlw8JnOIpXvg66R3ZPoYi8LHij2o2HOROcCtxIk7WgBZs6B0RSMzdwFpmarEaBkc+HwO4FCjXpOjH7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5tR+sX3s+ZP8u0cJ6qqPqSZKrmzwXbCHnjtv/4Fanc=;
 b=b0bL7flT/aWtBDW2ZGdF3VdqJJg3EsgPDOZoXwwsXObY/qyz6qNrbwSUCmgWRmzgatB2gcwbjDGpvvvUk833A4hwAAHQh7DdIIJFB0N7uYnvS+qOG6UIyXNHMqXVZfXDfB589oP24xAtZBzOdNOTuhJRaBiFQjYGCld3rrJqYw1beO5//m7gQv2zYiao41KST2e5V6Tt7SsC/RLHpVrR7JBk18NVZuA9CKFtZZrraB/h92XQKM1sOVZ0GoPsHlRVJp3LXO71YFDBpI7l2kkFDDtW0c2aRbGloTIGt6rkVIOwoMdoxJYfUdte2uTPFHIxO6yaP8/kcXLY7MZi1ArojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5tR+sX3s+ZP8u0cJ6qqPqSZKrmzwXbCHnjtv/4Fanc=;
 b=tJsw04N6iI06Ojr+O1y0vte2ui+92g8pSDH2dnb0DKKGAQ9CZzWEBsClENNIck+0X23tW4mfFUowZ/EPVCzm1O6x4PR36EyzXU7OKWyAul2D+lmWYkxU7em+znuW9Bb7Ih9sb+SscOhVo7zDcvaMh55Em9hEGa/3/EO9tBvkZpk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Thu, 25 Feb
 2021 20:05:28 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 20:05:28 +0000
Subject: Re: [PATCH] drm/amdgpu: add ih call to process until checkpoint
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210223211026.116403-1-jonathan.kim@amd.com>
 <6d30f52e-7a7a-5662-a66f-db832b8386ae@amd.com>
 <DM5PR12MB4680F60D6590680E40A90AF5859F9@DM5PR12MB4680.namprd12.prod.outlook.com>
 <92ddf2b3-3ee7-d481-2794-b57daed40ef9@amd.com>
 <8650a46f-f40d-d627-42a5-d9d760400086@gmail.com>
 <00ce83e0-a000-913b-57a1-53c07fdfcdef@amd.com>
 <23f02e39-4ead-a20e-5c5c-749b00fd400f@amd.com>
 <ee8342b4-0af7-5c7f-1895-42582d79c4a4@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0f5f856f-33d9-0553-f3b6-a088c90b5e66@amd.com>
Date: Thu, 25 Feb 2021 21:05:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <ee8342b4-0af7-5c7f-1895-42582d79c4a4@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:bcf6:4057:c09:be71]
X-ClientProxiedBy: AM0PR04CA0018.eurprd04.prod.outlook.com
 (2603:10a6:208:122::31) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:bcf6:4057:c09:be71]
 (2a02:908:1252:fb60:bcf6:4057:c09:be71) by
 AM0PR04CA0018.eurprd04.prod.outlook.com (2603:10a6:208:122::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Thu, 25 Feb 2021 20:05:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e9a70fc-984a-41fd-6043-08d8d9c8b22f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4254:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42545FBBF2B947FA33878DB5839E9@MN2PR12MB4254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SdGWhxJiYrIg/7AmOK2xt2DnvBabkF/OlEgx6W4TrlWDIvns0LV3k+ot6GU6zKJuTN9UzKwZDWpK8aXHmTW3HoeKoBUHemnhhXxqgTv3ZZtfyVAW+eJ0wOktLfARGj/z2DNfeEdvcMHLYUlMaJ3ARmrDB4oBV/r2A+v3Wktw/dSrFOHT0OhrmWgcf5x77ZaY/+S7ZFYtcThR0d8u7l/ek7qdLoW+i0TZc0csMRTYgAK1b8h0yVMsnLvA5VNOYZ1WUwtOqa28Yv1k+jcXkFPPKQMWHIkzD8h7Y5suDMdVnGsnXHE/8sr1nNzgChR1CF3K3AFvZZevlzE2wRYS58LUvqYdMM3APEO9fPjPYB4yVFRlAodgQA91AA5D7HukQFwpLE+7EJF3L1vvUC7j3Ppk8Rf5CBoMDXceMfB+BXHwVzhG4EyCVVOPIc79kY+A2zW7uSfxDyL2xtRSxFyX3fwfCWXGVF7Edvg0rDVTbF3z+1ygUtqAubfBlawQbVS9BWSeCRur+XkWzHdGS+BbDhbyoMQwazOWi1169SX+x6RDUEOaJSA00ib1NzJXF/V25RlUgvL8PBEkMzf2L6EDfr7x4LnJ290SIjkog2n1k4CYiTZIwtSzv/7t1flp26Qq3PO7AMgxSxCYgn8yfV7dnwapXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(6486002)(186003)(2616005)(83380400001)(36756003)(52116002)(6666004)(66946007)(16526019)(5660300002)(8676002)(45080400002)(4326008)(2906002)(966005)(478600001)(110136005)(66556008)(8936002)(66476007)(316002)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WEI5bTU1cjRvYU5wcmNVWUorV21mQjdKR293Vk8yejJ6RGJnMWppLzREVDZy?=
 =?utf-8?B?aWduTkxCNEtqOHh0T0JSQUxDclNFUWN4TVRRcGlQbnZuZ0dITFAwMGZJRUlD?=
 =?utf-8?B?Wm1tbjlPUllMK2d3Z2EzN3NtSFRBemVJcE9BdkV0SjZCcFJxNXZwcHdaVnZP?=
 =?utf-8?B?bjRRWFp1NnBQNU5FUlplbjdTS3VkVWp1UTUwNjl6OHZqVkdhSnk3emJzZHFj?=
 =?utf-8?B?RUdaQndQL24vOU5tU0VJclc3b3JPL1dGQnlYWUJ0YU8wMmN5SlBJSFlKTGFL?=
 =?utf-8?B?eHpqVFY2Q3c1T1lmTDNidEwyaVlmcGNzYTV3bWtxZVZkMXUyOTQ2cVdaWjFC?=
 =?utf-8?B?L0pGNjl0em9ycFhWQVkwODMwbmt0eFlSTlZoVjdBdGtBWWZheFVHeS9LcjZm?=
 =?utf-8?B?VStuWHArRHFnU21JbXVZR3JXUnk2M3BuS0QzKzgvc1pEMVhNbzJaSTFOUVZQ?=
 =?utf-8?B?NkdiK3d5MG5mYUNUYkh3bVM0Tk4vMkZuWlRxTFBWSnMzTkJ2Rlh1MmQ3em44?=
 =?utf-8?B?aVBrRElYWkw5VDgwQ1RVa05ZSUtkYzhTaCtFODFPRk5LQTFmNEZ0SzBXVk1h?=
 =?utf-8?B?T3pnMXpxQXQwK1Foc2J2VlVFcnZyT2hremhzZ1JPclFpcEx0c1NGTWd1YTNy?=
 =?utf-8?B?THluK2Y2akVhZ2VkbFZSRnBIR0tvTkJJWFpJT3l0Rndleit1ZUlMK3RGMVZX?=
 =?utf-8?B?UFB3Nm9vT3pvTkxnaCtXQW9adXp2WlpOUXY0NlBTU29IYXFIbm5QZUdvemtB?=
 =?utf-8?B?YnhGa1I1NGRTeTZ3dWd0U2hLTDBNeVJQSEY2TmNGeGlCMFErRG9NeTZGdndV?=
 =?utf-8?B?NDVYVEJjblZUeUZvRFJGbHNHN0I2RW4zaVBqNjN4YjkrOGRZS3FJeU1wRHpk?=
 =?utf-8?B?c0pvRHZKQ24xTkI2VzQxZnhCdUZ0eXo0TjI0U2V2S1lhbGplMGFldHY2d2N0?=
 =?utf-8?B?by9wZUJKTWxqZjdMcVp4bW5qaFBaekhVUDFUM1FOVEtLbndPVlJyWW9pZXJI?=
 =?utf-8?B?bU5tZHZrOVBKODRNQm5aZUREOG5kSlFZS0tnbXdmS0tIRDI4bXYwZm5janJZ?=
 =?utf-8?B?S3oyK2F2ejEvelNpK3NuZXc1cVBGcXhvVFNBMzNDNEtkbkxMdGY1dVhnaklK?=
 =?utf-8?B?MTZETko5Mit2a0xweTkxdWlQdm4xWGIyWDFSRC95REdhd3BaOEZBNi9Zb1Vq?=
 =?utf-8?B?cVJscDVlQUMwdmZINzVRMEJaWjNBQ0NqWjFFVHI3VW5CaHp4dmhzQTY3ZkNJ?=
 =?utf-8?B?R0cwejBqVmhEVmNCbmVFcXJ1eTBvc3BLQnN4dndZZ0dOQ3F4RjJvWG8rT2Ry?=
 =?utf-8?B?Q0ZtbjVTSlFBN0tpSG5UMnFKbUZmajhzbjN4SVFMVVhQbG1ZUkFBWnVRSTM5?=
 =?utf-8?B?MWN4bUNCajZSVlR5U3JraVJ5aDZJSHBYYTFpSExxamNlVDFDdVpmRGc0WEY0?=
 =?utf-8?B?RGxUUTdtQ0FGNmdjRjBMRUI3dnAvWHFUNVh4SXhTd0FoWlZnWkdkL3BTYWo5?=
 =?utf-8?B?OXhtTjdoSjB1akV4ZUtmZ1d4cmZVQysyQnNGNFRiZEkrVld0amZoTDhaTllk?=
 =?utf-8?B?YmpGRmhlR215VWRvWEQ0ZFNLWVdkdDRsMS94NnBtcFBOczR1RXhTeDhOZit0?=
 =?utf-8?B?V2t3bnBNbU9xQ05vZm5YUDdtSElaNTFKbUV1YzVEY3RUOCtONitrZEtkdGZH?=
 =?utf-8?B?RldZUUdPbGJBck5pMnlpVlNqVWUvNm5DcXNQSlhjcC9yZTFuV0lYUXNURzJ0?=
 =?utf-8?B?RXlWY1hreWRyWmhZTE5OUUxDVDlTVGpCY3A2Nyt0a0hhN0NpYWlseUp2NU9v?=
 =?utf-8?B?K3ZmT2lrWlBIVC9DQzd2N01jVTN5R25HL3FKbVNxdDA3RHR5OUVEdW5aUllw?=
 =?utf-8?Q?JRyTJtuXSQB7q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9a70fc-984a-41fd-6043-08d8d9c8b22f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 20:05:28.3528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fm1hl18ISAmSBdAPT1TIjxQe44BdFMjZxOi3c2vCxNV/j7igIMnROn5VmMeAx1tw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjUuMDIuMjEgdW0gMTk6MzMgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBbU05JUF0KPj4g
VGhpcyBpbiB0dXJuIGNhbiBsZWFkIHRvIHN0YXJ2YXRpb24gb2YgdGhlIHdvcmsgaGFuZGxlciBh
bmQgc28gYSBsaWZlCj4+IGxvY2sgYXMgd2VsbC4KPj4KPj4+Cj4+Pj4gSSB3b24ndCB0b3VjaCBy
cHRyIG9yIHdwdHIgYXQgYWxsIGZvciB0aGlzLgo+Pj4gTm90IHN1cmUgd2hhdCdzIHlvdXIgaWRl
YSBoZXJlLCB1c2luZyBpaC0+bG9jay4gSXMgaXQgdG8gY29tcGxldGVseQo+Pj4gZHJhaW4gYWxs
IElSUXMgdW50aWwgdGhlIElIIHJpbmcgaXMgY29tcGxldGVseSBlbXB0eT8KPj4gQ29ycmVjdC4K
Pj4KPj4+IFRoYXQgY2FuCj4+PiBsaXZlLWxvY2ssIGlmIHRoZSBHUFUgcHJvZHVjZXMgSVJRcyBm
YXN0ZXIgdGhhbiB0aGUga2VybmVsIGNhbiBwcm9jZXNzCj4+PiB0aGVtLiBUaGVyZWZvcmUgSSB3
YXMgbG9va2luZyBhdCBycHRyIGFuZCB3cHRyIHRvIGRyYWluIG9ubHkgSVJRcyB0aGF0Cj4+PiB3
ZXJlIGFscmVhZHkgaW4gdGhlIHF1ZXVlIHdoZW4gdGhlIGRyYWluIGNhbGwgd2FzIG1hZGUuIFRo
YXQgYWxzbwo+Pj4gZW5zdXJlcyB0aGF0IHRoZSB3YWl0IHRpbWUgaXMgYm91bmRlZCBhbmQgc2hv
dWxkIGJlIHNob3J0ICh1bmxlc3MgdGhlCj4+PiByaW5nIHNpemUgaXMgaHVnZSkuCj4+IENvcnJl
Y3QgYXMgd2VsbCwgYnV0IHRoZSBwcm9ibGVtIGhlcmUgaXMgdGhhdCBKb25hdGhhbidzCj4+IGlt
cGxlbWVudGF0aW9uIGlzIG5vdCBldmVuIHJlbW90ZWx5IGNvcnJlY3QuCj4+Cj4+IFNlZSB3aGVu
IHlvdSBsb29rIGF0IHRoZSBycHRyIGFuZCB3cHRyIHlvdSBjYW4ndCBiZSBzdXJlIHRoYXQgdGhl
eQo+PiBoYXZlbid0IHdyYXBwZWQgYXJvdW5kIGJldHdlZW4gdHdvIGxvb2tzLgo+Pgo+PiBXaGF0
IHlvdSBjb3VsZCBkbyBpcyBsb29rIGF0IGJvdGggdGhlIHJwdHIgYXMgd2VsbCBhcyB0aGUgb3Jp
Z2luYWwKPj4gd3B0ciwgYnV0IHRoYXQgaXMgdHJpY2t5Lgo+IFRoZSBjb2RlIGluIEpvbidzIHBh
dGNoIHdhcyBzdWdnZXN0ZWQgYnkgbWUuIEkgY2hlY2sgZm9yIHdyYXBwaW5nIGJ5Cj4gY29tcGFy
aW5nIHJwdHIgd2l0aCB0aGUgcnB0ciBmcm9tIHRoZSBwcmV2aW91cyBsb29wIGl0ZXJhdGlvbi4g
Q29tcGFyaW5nCj4gcnB0ciB3aXRoIHdwdHIgeW91IGNhbiBuZXZlciBiZSBzdXJlIHdoZXRoZXIg
cnB0ciBoYXMgYWxyZWFkeSBwYXNzZWQKPiB3cHRyLCBvciB3aGV0aGVyIHJwdHIgaGFzIHRvIHdy
YXAgZmlyc3QuCgpFeGFjdGx5IHRoYXQncyBteSBjb25jZXJuIGFzIHdlbGwuCgo+Cj4gSSBjb3Vs
ZCBzZWUgYSBjb21wcm9taXNlIHdoZXJlIHdlIHNsZWVwIGFuZCB3YWtlIHVwIHRoZSB3YWl0aW5n
IHRocmVhZHMgd2hlbgo+Cj4gICAxLiB0aGUgSUggcmluZyBpcyBlbXB0eQo+ICAgMi4gdGhlIElI
IHJwdHIgd3JhcHMKPgo+IFRoYXQgc2hvdWxkIGJlIGdvb2QgZW5vdWdoIHRvIGVuc3VyZSBhIHF1
aWNrIHJlc3BvbnNlIGluIHRoZSBjb21tb24gY2FzZQo+IChubyBpbnRlcnJ1cHQgc3Rvcm0pLCBh
bmQgYSByZWFzb25hYmxlIHJlc3BvbnNlIGluIHRoZSBpbnRlcnJ1cHQgc3Rvcm0gY2FzZS4KPgo+
IEJ1dCB0aGVuIGl0J3Mgc3RpbGwgbm90IGNsZWFyIHdoYXQncyB0aGUgY29ycmVjdCBjb25kaXRp
b24gZm9yIGNoZWNraW5nCj4gdGhhdCB0aGUgaW50ZXJydXB0cyB0aGUgY2FsbGVyIGNhcmVzIGFi
b3V0IGhhdmUgYmVlbiBkcmFpbmVkLiBMb29raW5nIGF0Cj4ganVzdCBycHRyIGFuZCB3cHRyIGlz
IGFsd2F5cyBhbWJpZ3VvdXMuIE1heWJlIHdlIGNvdWxkIHVzZSB0aW1lc3RhbXBzIG9mCj4gdGhl
IGxhc3QgcHJvY2Vzc2VkIGludGVycnVwdD8gVGhvc2UgNDgtYml0IHRpbWUgc3RhbXBzIHdyYXAg
bXVjaCBsZXNzCj4gZnJlcXVlbnRseS4gVGhlIGlkZWEgaXMgdGhpczoKPgo+ICAgICogQXQgdGhl
IHN0YXJ0IGdldCB0aGUgdGltZXN0YW1wIG9mIHRoZSBsYXN0IHdyaXR0ZW4gSUggcmluZyBlbnRy
eQo+ICAgICAgKGNoZWNrcG9pbnQpCj4gICAgKiBXYWl0IHVudGlsIHRoZSBsYXN0X3Byb2Nlc3Nl
ZCBJSCB0aW1lc3RhbXAgcGFzc2VzIHRoZSBjaGVja3BvaW50Ogo+ICAgICAgc2lnbl9leHRlbmQo
bGFzdF9wcm9jZXNzZWQgLSBjaGVja3BvaW50KSA+PSAwCgpZZWFoIHRoYXQgY291bGQgd29yay4g
QWx0ZXJuYXRpdmVseSB3ZSBjb3VsZCBqdXN0IGhhdmUgYSBycHRyIHdyYXAgCmFyb3VuZCBjb3Vu
dGVyLgoKVGhpcyB3YXkgeW91IGRvIHNvbWV0aGluZyBsaWtlIHRoaXM6CjEuIGdldCB0aGUgd3Jh
cCBhcm91bmQgY291bnRlci4KMi4gZ2V0IHdwdHIKMy4gZ2V0IHJwdHIKNC4gY29tcGFyZSB0aGUg
d3JhcCBhcm91bmQgY291bnRlciB3aXRoIHRoZSBvbGQgb25lLCBpZiBpdCBoYXMgY2hhbmdlZCAK
c3RhcnQgb3ZlciB3aXRoICMxCjUuIFVzZSB3cmFwIGFyb3VuZCBjb3VudGVyIGFuZCBycHRyL3dw
dHIgdG8gY29tZSB1cCB3aXRoIDY0Yml0IHZhbHVlcy4KNi4gQ29tcGFyZSB3cHRyIHdpdGggcnB0
ci93cmFwIGFyb3VuZCBjb3VudGVyIHVudGlsIHdlIGFyZSBzdXJlIHRoZSBJSHMgCmFyZSBwcm9j
ZXNzZWQuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gUmVnYXJkcywKPiAgwqAgRmVsaXgKPgo+
Cj4+IFJlZ2FyZHMsCj4+IENocmlzdGlhbi4KPj4KPj4+IFJlZ2FyZHMsCj4+PiAgwqDCoCBGZWxp
eAo+Pj4KPj4+Cj4+Pj4gUmVnYXJkcywKPj4+PiBDaHJpc3RpYW4uCj4+Pj4KPj4+Pj4gUmVnYXJk
cywKPj4+Pj4gIMKgwqAgRmVsaXgKPj4+Pj4KPj4+Pj4KPj4+Pj4+Pj4gU3VnZ2VzdGVkLWJ5OiBG
ZWxpeCBLdWVobGluZyA8ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4KPj4+Pj4+Pj4gU2lnbmVkLW9m
Zi1ieTogSm9uYXRoYW4gS2ltIDxqb25hdGhhbi5raW1AYW1kLmNvbT4KPj4+Pj4+Pj4gLS0tCj4+
Pj4+Pj4+ICDCoMKgwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmMgfCA0
Ngo+Pj4+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKystCj4+Pj4+Pj4+IGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oIHzCoCAyICsrCj4+Pj4+Pj4+ICDCoMKgwqAgMiBm
aWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pj4+Pj4+Cj4+
Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWgu
Ywo+Pj4+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5jCj4+Pj4+
Pj4+IGluZGV4IGRjODUyYWY0ZjNiNy4uY2FlNTBhZjk1NTlkIDEwMDY0NAo+Pj4+Pj4+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguYwo+Pj4+Pj4+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguYwo+Pj4+Pj4+PiBAQCAtMjIsNyAr
MjIsNyBAQAo+Pj4+Pj4+PiAgwqDCoMKgwqAgKi8KPj4+Pj4+Pj4KPj4+Pj4+Pj4gIMKgwqDCoCAj
aW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4KPj4+Pj4+Pj4gLQo+Pj4+Pj4+PiArI2luY2x1
ZGUgPGxpbnV4L3Byb2Nlc3Nvci5oPgo+Pj4+Pj4+PiAgwqDCoMKgICNpbmNsdWRlICJhbWRncHUu
aCIKPj4+Pj4+Pj4gIMKgwqDCoCAjaW5jbHVkZSAiYW1kZ3B1X2loLmgiCj4+Pj4+Pj4+Cj4+Pj4+
Pj4+IEBAIC0xNjAsNiArMTYwLDUwIEBAIHZvaWQgYW1kZ3B1X2loX3Jpbmdfd3JpdGUoc3RydWN0
Cj4+Pj4+Pj4gYW1kZ3B1X2loX3JpbmcgKmloLCBjb25zdCB1aW50MzJfdCAqaXYsCj4+Pj4+Pj4+
ICDCoMKgwqAgfQo+Pj4+Pj4+PiAgwqDCoMKgIH0KPj4+Pj4+Pj4KPj4+Pj4+Pj4gKy8qKgo+Pj4+
Pj4+PiArICogYW1kZ3B1X2loX3dhaXRfb25fY2hlY2twb2ludF9wcm9jZXNzIC0gd2FpdCB0byBw
cm9jZXNzIElWcwo+Pj4+Pj4+PiB1cCB0bwo+Pj4+Pj4+PiArY2hlY2twb2ludAo+Pj4+Pj4+PiAr
ICoKPj4+Pj4+Pj4gKyAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKPj4+Pj4+Pj4gKyAq
IEBpaDogaWggcmluZyB0byBwcm9jZXNzCj4+Pj4+Pj4+ICsgKgo+Pj4+Pj4+PiArICogVXNlZCB0
byBlbnN1cmUgcmluZyBoYXMgcHJvY2Vzc2VkIElWcyB1cCB0byB0aGUgY2hlY2twb2ludAo+Pj4+
Pj4+PiB3cml0ZQo+Pj4+Pj4+IHBvaW50ZXIuCj4+Pj4+Pj4+ICsgKi8KPj4+Pj4+Pj4gK2ludCBh
bWRncHVfaWhfd2FpdF9vbl9jaGVja3BvaW50X3Byb2Nlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2UK
Pj4+Pj4+PiAqYWRldiwKPj4+Pj4+Pj4gK3N0cnVjdCBhbWRncHVfaWhfcmluZyAqaWgpCj4+Pj4+
Pj4+ICt7Cj4+Pj4+Pj4+ICt1MzIgcHJldl9ycHRyLCBjdXJfcnB0ciwgY2hlY2twb2ludF93cHRy
Owo+Pj4+Pj4+PiArCj4+Pj4+Pj4+ICtpZiAoIWloLT5lbmFibGVkIHx8IGFkZXYtPnNodXRkb3du
KQo+Pj4+Pj4+PiArcmV0dXJuIC1FTk9ERVY7Cj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4gK2N1cl9ycHRy
ID0gUkVBRF9PTkNFKGloLT5ycHRyKTsKPj4+Pj4+Pj4gKy8qIE9yZGVyIHJlYWQgb2YgY3VycmVu
dCBycHRyIHdpdGggY2hlY2t0cG9pbnQgd3B0ci4gKi8KPj4+Pj4+Pj4gK21iKCk7Cj4+Pj4+Pj4+
ICtjaGVja3BvaW50X3dwdHIgPSBhbWRncHVfaWhfZ2V0X3dwdHIoYWRldiwgaWgpOwo+Pj4+Pj4+
PiArCj4+Pj4+Pj4+ICsvKiBhbGxvdyBycHRyIHRvIHdyYXAgYXJvdW5kwqAgKi8KPj4+Pj4+Pj4g
K2lmIChjdXJfcnB0ciA+IGNoZWNrcG9pbnRfd3B0cikgewo+Pj4+Pj4+PiArc3Bpbl9iZWdpbigp
Owo+Pj4+Pj4+PiArZG8gewo+Pj4+Pj4+PiArc3Bpbl9jcHVfcmVsYXgoKTsKPj4+Pj4+Pj4gK3By
ZXZfcnB0ciA9IGN1cl9ycHRyOwo+Pj4+Pj4+PiArY3VyX3JwdHIgPSBSRUFEX09OQ0UoaWgtPnJw
dHIpOwo+Pj4+Pj4+PiArfSB3aGlsZSAoY3VyX3JwdHIgPj0gcHJldl9ycHRyKTsKPj4+Pj4+Pj4g
K3NwaW5fZW5kKCk7Cj4+Pj4+Pj4gVGhhdCdzIGEgY2VydGFpbiBOQUsgc2luY2UgaXQgYnVzeSB3
YWl0cyBmb3IgSUggcHJvY2Vzc2luZy4gV2UgbmVlZAo+Pj4+Pj4+IHNvbWUKPj4+Pj4+PiBldmVu
dCB0byB0cmlnZ2VyIGhlcmUuCj4+Pj4+PiBUaGUgZnVuY3Rpb24gaXMgbWVhbnQgdG8gYmUganVz
dCBhIHdhaXRlciB1cCB0byB0aGUgY2hlY2twb2ludC4KPj4+Pj4+IFRoZXJlJ3MgYSBuZWVkIHRv
IGd1YXJhbnRlZSB0aGF0ICJzdGFsZSIgaW50ZXJydXB0cyBoYXZlIGJlZW4KPj4+Pj4+IHByb2Nl
c3NlZCBvbiBjaGVjayBiZWZvcmUgZG9pbmcgb3RoZXIgc3R1ZmYgYWZ0ZXIgY2FsbC4KPj4+Pj4+
IFRoZSBkZXNjcmlwdGlvbiBjb3VsZCBiZSBpbXByb3ZlZCB0byBjbGFyaWZ5IHRoYXQuCj4+Pj4+
Pgo+Pj4+Pj4gV291bGQgYnVzeSB3YWl0aW5nIG9ubHkgb24gYSBsb2NrZWQgcmluZyBoZWxwP8Kg
IEkgYXNzdW1lIGFuIHVubG9ja2VkCj4+Pj4+PiByaW5nIG1lYW5zIG5vdGhpbmcgdG8gcHJvY2Vz
cyBzbyBubyBuZWVkIHRvIHdhaXQgYW5kIHdlIGNhbiBleGl0Cj4+Pj4+PiBlYXJseS7CoCBPciBp
cyBpdCBiZXR0ZXIgdG8ganVzdCB0byBwcm9jZXNzIHRoZSBlbnRyaWVzIHVwIHRvIHRoZQo+Pj4+
Pj4gY2hlY2twb2ludCAobWF5YmUgYWRqdXN0IGFtZGdwdV9paF9wcm9jZXNzIGZvciB0aGlzIG5l
ZWQgbGlrZSBhZGRpbmcKPj4+Pj4+IGEgYm9vbCBhcmcgdG8gc2tpcCByZXN0YXJ0IG9yIHNvbWV0
aGluZyk/Cj4+Pj4+Pgo+Pj4+Pj4gVGhhbmtzLAo+Pj4+Pj4KPj4+Pj4+IEpvbgo+Pj4+Pj4KPj4+
Pj4+Pj4gK30KPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiArLyogd2FpdCBmb3IgcnB0ciB0byBjYXRjaCB1
cCB0byBvciBwYXNzIGNoZWNrcG9pbnQuICovCj4+Pj4+Pj4+ICtzcGluX2JlZ2luKCk7Cj4+Pj4+
Pj4+ICtkbyB7Cj4+Pj4+Pj4+ICtzcGluX2NwdV9yZWxheCgpOwo+Pj4+Pj4+PiArcHJldl9ycHRy
ID0gY3VyX3JwdHI7Cj4+Pj4+Pj4+ICtjdXJfcnB0ciA9IFJFQURfT05DRShpaC0+cnB0cik7Cj4+
Pj4+Pj4+ICt9IHdoaWxlIChjdXJfcnB0ciA+PSBwcmV2X3JwdHIgJiYgY3VyX3JwdHIgPCBjaGVj
a3BvaW50X3dwdHIpOwo+Pj4+Pj4+IFNhbWUgb2YgY291cnNlIGhlcmUuCj4+Pj4+Pj4KPj4+Pj4+
PiBDaHJpc3RpYW4uCj4+Pj4+Pj4KPj4+Pj4+Pj4gK3NwaW5fZW5kKCk7Cj4+Pj4+Pj4+ICsKPj4+
Pj4+Pj4gK3JldHVybiAwOwo+Pj4+Pj4+PiArfQo+Pj4+Pj4+PiArCj4+Pj4+Pj4+ICDCoMKgwqAg
LyoqCj4+Pj4+Pj4+ICDCoMKgwqDCoCAqIGFtZGdwdV9paF9wcm9jZXNzIC0gaW50ZXJydXB0IGhh
bmRsZXIKPj4+Pj4+Pj4gIMKgwqDCoMKgICoKPj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oCj4+Pj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2loLmgKPj4+Pj4+Pj4gaW5kZXggNmVkNGE4NWZjN2MzLi42ODE3
ZjBhODEyZDIgMTAwNjQ0Cj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9paC5oCj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9paC5oCj4+Pj4+Pj4+IEBAIC04Nyw2ICs4Nyw4IEBAIGludCBhbWRncHVfaWhfcmluZ19p
bml0KHN0cnVjdCBhbWRncHVfZGV2aWNlCj4+Pj4+Pj4+ICphZGV2LAo+Pj4+Pj4+IHN0cnVjdCBh
bWRncHVfaWhfcmluZyAqaWgsCj4+Pj4+Pj4+ICDCoMKgwqAgdm9pZCBhbWRncHVfaWhfcmluZ19m
aW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QKPj4+Pj4+PiBhbWRncHVfaWhf
cmluZyAqaWgpOwo+Pj4+Pj4+PiAgwqDCoMKgIHZvaWQgYW1kZ3B1X2loX3Jpbmdfd3JpdGUoc3Ry
dWN0IGFtZGdwdV9paF9yaW5nICppaCwgY29uc3QKPj4+Pj4+Pj4gdWludDMyX3QgKml2LAo+Pj4+
Pj4+PiAgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgbnVtX2R3KTsKPj4+Pj4+Pj4gK2ludCBhbWRn
cHVfaWhfd2FpdF9vbl9jaGVja3BvaW50X3Byb2Nlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2UKPj4+
Pj4+PiAqYWRldiwKPj4+Pj4+Pj4gK3N0cnVjdCBhbWRncHVfaWhfcmluZyAqaWgpOwo+Pj4+Pj4+
PiAgwqDCoMKgIGludCBhbWRncHVfaWhfcHJvY2VzcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwgc3RydWN0Cj4+Pj4+Pj4gYW1kZ3B1X2loX3JpbmcgKmloKTsKPj4+Pj4+Pj4gIMKgwqDCoCB2
b2lkIGFtZGdwdV9paF9kZWNvZGVfaXZfaGVscGVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAo+Pj4+Pj4+PiAgwqDCoMKgIHN0cnVjdCBhbWRncHVfaWhfcmluZyAqaWgsCj4+Pj4+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+Pj4+IGFtZC1nZngg
bWFpbGluZyBsaXN0Cj4+Pj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+Pj4+IGh0
dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUz
QSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1n
ZngmYW1wO2RhdGE9MDQlN0MwMSU3Q2ZlbGl4Lmt1ZWhsaW5nJTQwYW1kLmNvbSU3Qzg0ZDg1ZTU0
YmRjYjQ1OTNlMDdmMDhkOGQ5OTRiZTc3JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4
M2QlN0MwJTdDMCU3QzYzNzQ5ODU4MDE2NzMxMzE5MyU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhl
eUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZD
STZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1SdlJIQjlsNE8lMkJwYnBvZ1VGS1Vtbk1Ha3FLbmVj
d1FDWVJIcmt4SUNEcVUlM0QmYW1wO3Jlc2VydmVkPTAKPj4+Pj4KPj4+Pj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
