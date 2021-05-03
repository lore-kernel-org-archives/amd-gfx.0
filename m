Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D9BC433B4
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 19:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB2CC6135F
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 19:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2CC6135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E9B6EA1F;
	Mon,  3 May 2021 19:13:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75CC36EA1F
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 19:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDRPbp9F4+3MZV7SP9Erpwus6ULwwJN4XHocHB1PknFGBi+fq3U+gA/i/QNlFr0hZmLd34AxkJBQ926nIao0WrKffVt8wPdTfvoud8tt4JFk4c8qV6aN/dvy63L5v+x2GttciFuni/snx9vo1Dy/j2JBV4C6n378Or5bx2sTyGQq8MB8wLew+Bna6B/uvEcMeHMn53pg1J9OYULipUecuyMYS3xD0TFBfcq2x6iWVTZSnPBjLRRgMqrRQ8brgfr0raXICEW/oZCxjCBu7zPFDMcfXmvkKXoWzlgS1U3x01ys8wtkWjdo9JvAI/mmUBV35uQxgWnPSh6tBSk5KMbnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Btuc5huBa8V4U5emPrm0dGtHcQ5xEsl0otUFhl/oT2Q=;
 b=ixtJx+9RYl2rM2ji4M/iF+g2Ysi2YSkp421UDHUU4f3QaqzwHxsyrrfwtdXyPoPR11HFUrX/vGbsZitAON5aE5E0NgVuCfWzUST6vhXtrMsoMXnszXWN/QiQNwQFvwtuZOp2Ig6CnL3DXZ0UGQOv+p7/zWPFHP7VVP2kd1D/herr9DIEu+uzxomYiL1QE82x3JGAqfW15QsWc6HFe6scYhCjJDf+xsNN97lRXKLojdbSPK6HiyP3OsWUUuEqTxfBrAdrPejPfds7kpI6NsrBVN7zkpBKa/m22XmmNf+rlm+qkR9Q9JjpGoqxk0jHwgA04mmXaM7KJ7Y7q41lb7DVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Btuc5huBa8V4U5emPrm0dGtHcQ5xEsl0otUFhl/oT2Q=;
 b=Rh4CUJHHZnO5mzBmYg5AYhct9nmY0tLHCWSd75D2QrF78ac+L6hiNtJWm+Rv/crIEHlnwOWAFxepOkylUnkJIExjaiw1EH9seML95iUOiNyKr83qS+7fXxzieXCD6jV2NBdJsFhi2iOyXE3UwP+GoDFH/maYbG1WYyg40YiQAEo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39; Mon, 3 May
 2021 19:13:39 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510%10]) with mapi id 15.20.4087.041; Mon, 3 May 2021
 19:13:38 +0000
Subject: Re: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
To: "Zeng, Oak" <Oak.Zeng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210428151154.28317-1-jinhuieric.huang@amd.com>
 <8E4089F8-92B0-4C10-86C1-B0F350E9CEE8@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <18989d26-b02d-0935-f976-563ca40e5784@amd.com>
Date: Mon, 3 May 2021 15:13:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <8E4089F8-92B0-4C10-86C1-B0F350E9CEE8@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2048:122:150d:2265:cbad:a5fb]
X-ClientProxiedBy: YTOPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::19) To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:150d:2265:cbad:a5fb]
 (2607:9880:2048:122:150d:2265:cbad:a5fb) by
 YTOPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.37 via Frontend
 Transport; Mon, 3 May 2021 19:13:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31f8f76a-6c3e-4190-b6ab-08d90e678e73
X-MS-TrafficTypeDiagnostic: DM6PR12MB4332:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43327250BFD046D6C30EB3D5825B9@DM6PR12MB4332.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9QFZPQaGtJnPvKVaN5YlxOKfnP3l4Z4IWCgduiedFW8FrXwiqbSPmX8vbuGqf3WK4s5x3ZaHew97YfvZUJnhyQoDE/2S2Ti7/9+PBbSwQkx52pgRReIK1lyvn0K2dzAOlzj6EONQMorqQhWeBx7j1HzmQtcyuDT01A7vWnNooQAF5RZs1+QF4+urF3OfHQr0FIT7n2IWVacfcbo/n85SlfBuQdcE4lDFBY8l1KEurSuYY63oI9ta8MkMlZyjGGa7Ewk6nT6R4KZIzjhI+VZJ0E8ZzgCBDY1amT0UmFYj2o3KNBW+RbsNaHpz18BqvckMuaHD20XmchHZJeze84KKcvM6oql1Sz1+4hqPd6nIZ64bGx5Mqu+1aShKQ2olo1bYX50oLuhIkjebVE6OzWqdTDk+Wz3cKL06ZF0ZWlutiuhBiSzL8pTzwZgRW1+V/63WseYrhTJFCLPufWQwe7VLE1x0CqdqfE4AidaQfDGDzgSuBvIpdQEUVXK0pfyzmbjJal1lzeWBDwmsYTmKmLz+Xc9dRaxOc+hGvtG37JNLKVBUiyPUe9WUxpbs1SS/D7l2RG136FpGzRwi2ZxQFHpVDsMVha5TngoGeIanWkxez0dvfb+trM36Nnxesi1475RyyHdsD4BlkGBfLMbBs17ueJCpyaKaQyAcYLXfA+Fm9CZsO26lRWVbP8AYGNpYPeEWI5C8QPoQl0zSgvhONH1yXxFJfyTJOfPR14xQriIQM8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(39850400004)(136003)(376002)(186003)(2616005)(966005)(316002)(86362001)(66556008)(66476007)(16526019)(31696002)(2906002)(66946007)(53546011)(36756003)(110136005)(6486002)(38100700002)(4326008)(6666004)(45080400002)(5660300002)(8676002)(8936002)(83380400001)(31686004)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SG84WU14WnZaN2NzRFVRaGg5NTRIRlIzY29PZllTZXZlbmJUQTg4NS9FWFJw?=
 =?utf-8?B?S0ZJQ1hEelVzaUY4a1hVdzh0WUc3QUJWb010azJSeWtqQnppRjVKbFBXQk5I?=
 =?utf-8?B?QUhRSFloWWZ1M09JK1ZWaFlwbXpPcmdpK29Pak02QWRpQkZrYzE2L1E0QWxI?=
 =?utf-8?B?dnN4NTdMbld2RFhITDltczFIbHNMbzVYWVNtNzJaVlAzbFVaOEVWL1NrZUw1?=
 =?utf-8?B?MlAzdjlrTFAyeGhGOFdRM0tBVUE2aDhSNk9zdUJGUzhya3QwUC9tK1orU2l4?=
 =?utf-8?B?S3dWM0hEMTBWTmhHN0pGVHNJUk02bEZCeFM1amFVMkZ6UmtMTnBQZGN2bnB6?=
 =?utf-8?B?bWFGOE9uUHh6bE5QSElaZXNqK3lzdWdhVFl1eWlqc1R3bnBHemU1dUlGTFp0?=
 =?utf-8?B?N0FjREsvYkNnMmtUdFZWZTRKaDFFZXViMExmZFlVdVhpcTY3Q1d6eXBNZnZK?=
 =?utf-8?B?b3ZtZGUrNlhLZ1FGRGJ3MU50eGp5TU1vSXo1cS9GVkdKTVFUN1FQNitjRXJy?=
 =?utf-8?B?YURFUVhqRVJrSE5FL2pIbGQrb0dVcDlSNHc1RW1IVFhTYnIwYUJVWDBCck1Q?=
 =?utf-8?B?cTB6dnNqaS9ZblBPQ3hLZEVRYkxNZVhXeE1wQnUycmY4dUNQV0ZhVE5XV0lP?=
 =?utf-8?B?blIzajcrc0JJVmdDeDJHdGRyR3pFaXc0enh1VFluQjdkWHMwb3MwZlBQR05N?=
 =?utf-8?B?QXBHbVZuRm0rMlVveVpPUWgvbDdUalRZVXNhNitielhVZnM0dHJjdXVVOUFB?=
 =?utf-8?B?SzJxeDRDa3JzMFBRS3ZlWEJDYU1ZNDA2NzVCWHpkc0hzSTBQLzU5R1ZXUnZq?=
 =?utf-8?B?WEVSUXN5aTJpcXpKd0JVei96ak9kVFRycXdRcVk2WDVITlg5dlhRQkNIY2VP?=
 =?utf-8?B?OUgrMlZxVm9qNENWNGJBUTIzZEZPc3d6QVUrZU5SQWV6MGlqZzJVUzk1RGJv?=
 =?utf-8?B?dVcxd0dmRVRKejlXUFJWdjJXaUorWkxsd2liYTBwTlMxVEluMWZwMW5iNW1H?=
 =?utf-8?B?OXlrUU9wYjM0TW9iTi85YW9aL1lEN1g1OElmc2JzMU5DN1oyQXNJWEk5T3dh?=
 =?utf-8?B?VGQ2SFc1OWs4TmdFaEcxRkVCdnYxTkxpSlR5NTlPZEtiOFUvMDFsb3hsUTRL?=
 =?utf-8?B?QTl0R1ZLMWhqZ3FyZzBpYmRuUXVLbTJRRkxrSlBHTnZ0STYxLzErc255dkNq?=
 =?utf-8?B?MCt2TnQySWk0VDZoV2VQUWg4Mzlua2NaL3c4QXEwVGc3VVNYckw4djVyNGlF?=
 =?utf-8?B?ZEozZVBjZDF1Ny8wKzh6d05LWjdKNDhoZEJvZWsxN3RCYlZReVdRTEZaN1Js?=
 =?utf-8?B?SDZ4WHc3di9ZUHBNYVRYdGhNdGVjQkFHQTJNY3NKRmNaamRwbmJMZEcwUjYr?=
 =?utf-8?B?YVpVSWFSaDJwRjQ4MUpsbktxdTlyUm9seWdxR3NoQ2h3TUpvdzYzUk1jNXB1?=
 =?utf-8?B?R1NrcWZMemtaWXZFYUovT1owZWZGbHJZZ3Buem1veXVRTWczUDFvTHVYR29N?=
 =?utf-8?B?NE1jeTNXK3ZkN0hXVDE2emE0YTFRaWp5bVZZUVZSMGtiSmFPY29EK3Y5MUVo?=
 =?utf-8?B?T0FNRnpnTXhiMm9KWHlicHBuQjhXK1FFOVVIT1duUDVaOUdBQm16cFBUSGFV?=
 =?utf-8?B?SXRNa0tiMlZKeWxvMVM4WTc3YkU1OS9xY1h6dldNcFBkandETlM5RlZTOHo1?=
 =?utf-8?B?ZmVvUFBsWU1sdkpqdnFBVzBpN0RCZVFWT3VuZEdGeW5sUWtmc1pCUm9GVTNo?=
 =?utf-8?B?K21pNXpOOU9WT0h4QUZhcUtTTUgrOWRGOEUxTENEa0o3aG0yNjhtMmw2cGVF?=
 =?utf-8?B?Z2FHc3BLNDJydFZsMU02S1FsYlNSa2lRMEU0SXF5a25GbTBvZE1MZkNxcUlo?=
 =?utf-8?Q?U5IP9lBBnZEYx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f8f76a-6c3e-4190-b6ab-08d90e678e73
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 19:13:38.6743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejzR44JBrTp07VIN7m3BHpaN1UJtm4pstKSi7VM59MmVm+ROuwBadESktKmSPVlM0Vipi5Paz1f2NdklfUUJoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SW4gZHJpdmVycy9hY3BpL251bWEvc3JhdC5jLCB0aGUgZ2VuZXJpYyBDQ0QgcGFyc2luZyBpcyBm
b3IgdGhlIG1hcHBpbmcgCm9mIG51bWEgbm9kZSBhbmQgcHhtIGRvbWFpbiB0aGF0IGNyZWF0ZXMg
YXJyYXlzIG9mIHB4bV90b19ub2RlX21hcCBhbmQgCm5vZGVfdG9fcHhtX21hcC4gV2UgYXJlIGN1
cnJlbnRseSB1c2luZyBBUEkgcHhtX3RvX25vZGUoKSB0byBnZXQgdGhlIApjb3JyZXNwb25kaW5n
IGluZm9ybWF0aW9uLgoKRm9yIEdDRCBwYXJzaW5nLCB0aGUgcmVsYXRpb24gb2YgR0NEIHRvIEND
RCBpcyBkZWZpbmVkIGJ5IEFNRCwgZ2VuZXJpYyAKcGFyc2luZyBpbiBzcmF0LmMgaXMgY29uc2lk
ZXJpbmcgYSBHQ0QgYXMgYSBuZXcgbnVtYSBub2RlIHdoaWNoIGlzIG5vdCAKc3VpdGFibGUgZm9y
IG91ciBuZWVkLgoKUmVnYXJkcywKRXJpYwoKT24gMjAyMS0wNS0wMyAyOjQzIHAubS4sIFplbmcs
IE9hayB3cm90ZToKPiBJIGZlZWwgc3VjaCBwYXJzaW5nIHdvcmsgc2hvdWxkIGJlIHBhcnQgb2Yg
dGhlIEFDUEkgZ2VuZXJpYyB3b3JrIHNvIHNob3VsZCBiZSBkb25lIGluIGRyaXZlcnMvYWNwaS9u
dW0vc3JhdC5jIChzZWUgYWNwaV90YWJsZV9wYXJzZV9zcmF0KSBhbmQgdGhlIGFjcGkgc3Vic3lz
dGVtIHNob3VsZCBleHBvc2UgQVBJcyBmb3IgcmVzdCBkcml2ZXJzIHRvIHF1ZXJ5IHN1Y2ggbnVt
YSBpbmZvcm1hdGlvbi4KPgo+IFJlZ2FyZHMsCj4gT2FrCj4KPiAgIAo+Cj4g77u/T24gMjAyMS0w
NC0yOCwgMTE6MTIgQU0sICJhbWQtZ2Z4IG9uIGJlaGFsZiBvZiBFcmljIEh1YW5nIiA8YW1kLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZyBvbiBiZWhhbGYgb2YgSmluSHVpRXJpYy5I
dWFuZ0BhbWQuY29tPiB3cm90ZToKPgo+ICAgICAgSW4gTlBTNCBCSU9TIHdlIG5lZWQgdG8gZmlu
ZCB0aGUgY2xvc2VzdCBudW1hIG5vZGUgd2hlbiBjcmVhdGluZwo+ICAgICAgdG9wb2xvZ3kgaW8g
bGluayBiZXR3ZWVuIGNwdSBhbmQgZ3B1LCBpZiBQQ0kgZHJpdmVyIGRvZXNuJ3Qgc2V0Cj4gICAg
ICBpdC4KPgo+ICAgICAgU2lnbmVkLW9mZi1ieTogRXJpYyBIdWFuZyA8amluaHVpZXJpYy5odWFu
Z0BhbWQuY29tPgo+ICAgICAgLS0tCj4gICAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2NyYXQuYyB8IDk0ICsrKysrKysrKysrKysrKysrKysrKysrKysrLQo+ICAgICAgIDEgZmls
ZSBjaGFuZ2VkLCA5MSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gICAgICBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMKPiAgICAgIGluZGV4IDM4ZDQ1NzExNjc1Zi4u
NTc1MTgxMzZjN2Q3IDEwMDY0NAo+ICAgICAgLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2NyYXQuYwo+ICAgICAgKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X2NyYXQuYwo+ICAgICAgQEAgLTE3NTksNiArMTc1OSw4NyBAQCBzdGF0aWMgaW50IGtmZF9maWxs
X2dwdV9tZW1vcnlfYWZmaW5pdHkoaW50ICphdmFpbF9zaXplLAo+ICAgICAgIAlyZXR1cm4gMDsK
PiAgICAgICB9Cj4KPiAgICAgICsjaWZkZWYgQ09ORklHX0FDUEkKPiAgICAgICtzdGF0aWMgdm9p
ZCBrZmRfZmluZF9udW1hX25vZGVfaW5fc3JhdChzdHJ1Y3Qga2ZkX2RldiAqa2RldiwKPiAgICAg
ICsJCWludCAqbnVtYV9ub2RlKQo+ICAgICAgK3sKPiAgICAgICsJc3RydWN0IGFjcGlfdGFibGVf
aGVhZGVyICp0YWJsZV9oZWFkZXIgPSBOVUxMOwo+ICAgICAgKwlzdHJ1Y3QgYWNwaV9zdWJ0YWJs
ZV9oZWFkZXIgKnN1Yl9oZWFkZXIgPSBOVUxMOwo+ICAgICAgKwl1bnNpZ25lZCBsb25nIHRhYmxl
X2VuZCwgc3VidGFibGVfbGVuOwo+ICAgICAgKwl1MzIgcGNpX2lkID0gcGNpX2RvbWFpbl9ucihr
ZGV2LT5wZGV2LT5idXMpIDw8IDE2IHwKPiAgICAgICsJCQlwY2lfZGV2X2lkKGtkZXYtPnBkZXYp
Owo+ICAgICAgKwl1MzIgYmRmOwo+ICAgICAgKwlhY3BpX3N0YXR1cyBzdGF0dXM7Cj4gICAgICAr
CXN0cnVjdCBhY3BpX3NyYXRfY3B1X2FmZmluaXR5ICpjcHU7Cj4gICAgICArCXN0cnVjdCBhY3Bp
X3NyYXRfZ2VuZXJpY19hZmZpbml0eSAqZ3B1Owo+ICAgICAgKwlpbnQgcHhtID0gMCwgbWF4X3B4
bSA9IDA7Cj4gICAgICArCWJvb2wgZm91bmQgPSBmYWxzZTsKPiAgICAgICsKPiAgICAgICsJLyog
RmV0Y2ggdGhlIFNSQVQgdGFibGUgZnJvbSBBQ1BJICovCj4gICAgICArCXN0YXR1cyA9IGFjcGlf
Z2V0X3RhYmxlKEFDUElfU0lHX1NSQVQsIDAsICZ0YWJsZV9oZWFkZXIpOwo+ICAgICAgKwlpZiAo
c3RhdHVzID09IEFFX05PVF9GT1VORCkgewo+ICAgICAgKwkJcHJfd2FybigiU1JBVCB0YWJsZSBu
b3QgZm91bmRcbiIpOwo+ICAgICAgKwkJcmV0dXJuOwo+ICAgICAgKwl9IGVsc2UgaWYgKEFDUElf
RkFJTFVSRShzdGF0dXMpKSB7Cj4gICAgICArCQljb25zdCBjaGFyICplcnIgPSBhY3BpX2Zvcm1h
dF9leGNlcHRpb24oc3RhdHVzKTsKPiAgICAgICsJCXByX2VycigiU1JBVCB0YWJsZSBlcnJvcjog
JXNcbiIsIGVycik7Cj4gICAgICArCQlyZXR1cm47Cj4gICAgICArCX0KPiAgICAgICsKPiAgICAg
ICsJdGFibGVfZW5kID0gKHVuc2lnbmVkIGxvbmcpdGFibGVfaGVhZGVyICsgdGFibGVfaGVhZGVy
LT5sZW5ndGg7Cj4gICAgICArCj4gICAgICArCS8qIFBhcnNlIGFsbCBlbnRyaWVzIGxvb2tpbmcg
Zm9yIGEgbWF0Y2guICovCj4gICAgICArCj4gICAgICArCXN1Yl9oZWFkZXIgPSAoc3RydWN0IGFj
cGlfc3VidGFibGVfaGVhZGVyICopCj4gICAgICArCQkJKCh1bnNpZ25lZCBsb25nKXRhYmxlX2hl
YWRlciArCj4gICAgICArCQkJc2l6ZW9mKHN0cnVjdCBhY3BpX3RhYmxlX3NyYXQpKTsKPiAgICAg
ICsJc3VidGFibGVfbGVuID0gc3ViX2hlYWRlci0+bGVuZ3RoOwo+ICAgICAgKwo+ICAgICAgKwl3
aGlsZSAoKCh1bnNpZ25lZCBsb25nKXN1Yl9oZWFkZXIpICsgc3VidGFibGVfbGVuICA8IHRhYmxl
X2VuZCkgewo+ICAgICAgKwkJLyoKPiAgICAgICsJCSAqIElmIGxlbmd0aCBpcyAwLCBicmVhayBm
cm9tIHRoaXMgbG9vcCB0byBhdm9pZAo+ICAgICAgKwkJICogaW5maW5pdGUgbG9vcC4KPiAgICAg
ICsJCSAqLwo+ICAgICAgKwkJaWYgKHN1YnRhYmxlX2xlbiA9PSAwKSB7Cj4gICAgICArCQkJcHJf
ZXJyKCJTUkFUIGludmFsaWQgemVybyBsZW5ndGhcbiIpOwo+ICAgICAgKwkJCWJyZWFrOwo+ICAg
ICAgKwkJfQo+ICAgICAgKwo+ICAgICAgKwkJc3dpdGNoIChzdWJfaGVhZGVyLT50eXBlKSB7Cj4g
ICAgICArCQljYXNlIEFDUElfU1JBVF9UWVBFX0NQVV9BRkZJTklUWToKPiAgICAgICsJCQljcHUg
PSAoc3RydWN0IGFjcGlfc3JhdF9jcHVfYWZmaW5pdHkgKilzdWJfaGVhZGVyOwo+ICAgICAgKwkJ
CXB4bSA9ICooKHUzMiAqKWNwdS0+cHJveGltaXR5X2RvbWFpbl9oaSkgPDwgOCB8Cj4gICAgICAr
CQkJCQljcHUtPnByb3hpbWl0eV9kb21haW5fbG87Cj4gICAgICArCQkJaWYgKHB4bSA+IG1heF9w
eG0pCj4gICAgICArCQkJCW1heF9weG0gPSBweG07Cj4gICAgICArCQkJYnJlYWs7Cj4gICAgICAr
CQljYXNlIEFDUElfU1JBVF9UWVBFX0dFTkVSSUNfQUZGSU5JVFk6Cj4gICAgICArCQkJZ3B1ID0g
KHN0cnVjdCBhY3BpX3NyYXRfZ2VuZXJpY19hZmZpbml0eSAqKXN1Yl9oZWFkZXI7Cj4gICAgICAr
CQkJYmRmID0gKigodTE2ICopKCZncHUtPmRldmljZV9oYW5kbGVbMF0pKSA8PCAxNiB8Cj4gICAg
ICArCQkJCQkqKCh1MTYgKikoJmdwdS0+ZGV2aWNlX2hhbmRsZVsyXSkpOwo+ICAgICAgKwkJCWlm
IChiZGYgPT0gcGNpX2lkKSB7Cj4gICAgICArCQkJCWZvdW5kID0gdHJ1ZTsKPiAgICAgICsJCQkJ
Km51bWFfbm9kZSA9IHB4bV90b19ub2RlKGdwdS0+cHJveGltaXR5X2RvbWFpbik7Cj4gICAgICAr
CQkJfQo+ICAgICAgKwkJCWJyZWFrOwo+ICAgICAgKwkJZGVmYXVsdDoKPiAgICAgICsJCQlicmVh
azsKPiAgICAgICsJCX0KPiAgICAgICsKPiAgICAgICsJCWlmIChmb3VuZCkKPiAgICAgICsJCQli
cmVhazsKPiAgICAgICsKPiAgICAgICsJCXN1Yl9oZWFkZXIgPSAoc3RydWN0IGFjcGlfc3VidGFi
bGVfaGVhZGVyICopCj4gICAgICArCQkJCSgodW5zaWduZWQgbG9uZylzdWJfaGVhZGVyICsgc3Vi
dGFibGVfbGVuKTsKPiAgICAgICsJCXN1YnRhYmxlX2xlbiA9IHN1Yl9oZWFkZXItPmxlbmd0aDsK
PiAgICAgICsJfQo+ICAgICAgKwo+ICAgICAgKwkvKiB3b3JrYXJvdW5kIGJhZCBjcHUtZ3B1IGJp
bmRpbmcgY2FzZSAqLwo+ICAgICAgKwlpZiAoZm91bmQgJiYgKCpudW1hX25vZGUgPCAwIHx8ICpu
dW1hX25vZGUgPiBtYXhfcHhtKSkKPiAgICAgICsJCSpudW1hX25vZGUgPSAwOwo+ICAgICAgK30K
PiAgICAgICsjZW5kaWYKPiAgICAgICsKPiAgICAgICAvKiBrZmRfZmlsbF9ncHVfZGlyZWN0X2lv
X2xpbmsgLSBGaWxsIGluIGRpcmVjdCBpbyBsaW5rIGZyb20gR1BVCj4gICAgICAgICogdG8gaXRz
IE5VTUEgbm9kZQo+ICAgICAgICAqCUBhdmFpbF9zaXplOiBBdmFpbGFibGUgc2l6ZSBpbiB0aGUg
bWVtb3J5Cj4gICAgICBAQCAtMTc3NCw2ICsxODU1LDkgQEAgc3RhdGljIGludCBrZmRfZmlsbF9n
cHVfZGlyZWN0X2lvX2xpbmtfdG9fY3B1KGludCAqYXZhaWxfc2l6ZSwKPiAgICAgICAJCQl1aW50
MzJfdCBwcm94aW1pdHlfZG9tYWluKQo+ICAgICAgIHsKPiAgICAgICAJc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKilrZGV2LT5rZ2Q7Cj4gICAgICAr
I2lmZGVmIENPTkZJR19OVU1BCj4gICAgICArCWludCBudW1hX25vZGUgPSAwOwo+ICAgICAgKyNl
bmRpZgo+Cj4gICAgICAgCSphdmFpbF9zaXplIC09IHNpemVvZihzdHJ1Y3QgY3JhdF9zdWJ0eXBl
X2lvbGluayk7Cj4gICAgICAgCWlmICgqYXZhaWxfc2l6ZSA8IDApCj4gICAgICBAQCAtMTgwNSw5
ICsxODg5LDEzIEBAIHN0YXRpYyBpbnQga2ZkX2ZpbGxfZ3B1X2RpcmVjdF9pb19saW5rX3RvX2Nw
dShpbnQgKmF2YWlsX3NpemUsCj4KPiAgICAgICAJc3ViX3R5cGVfaGRyLT5wcm94aW1pdHlfZG9t
YWluX2Zyb20gPSBwcm94aW1pdHlfZG9tYWluOwo+ICAgICAgICNpZmRlZiBDT05GSUdfTlVNQQo+
ICAgICAgLQlpZiAoa2Rldi0+cGRldi0+ZGV2Lm51bWFfbm9kZSA9PSBOVU1BX05PX05PREUpCj4g
ICAgICAtCQlzdWJfdHlwZV9oZHItPnByb3hpbWl0eV9kb21haW5fdG8gPSAwOwo+ICAgICAgLQll
bHNlCj4gICAgICArCWlmIChrZGV2LT5wZGV2LT5kZXYubnVtYV9ub2RlID09IE5VTUFfTk9fTk9E
RSkgewo+ICAgICAgKyNpZmRlZiBDT05GSUdfQUNQSQo+ICAgICAgKwkJa2ZkX2ZpbmRfbnVtYV9u
b2RlX2luX3NyYXQoa2RldiwgJm51bWFfbm9kZSk7Cj4gICAgICArI2VuZGlmCj4gICAgICArCQlz
dWJfdHlwZV9oZHItPnByb3hpbWl0eV9kb21haW5fdG8gPSBudW1hX25vZGU7Cj4gICAgICArCQlz
ZXRfZGV2X25vZGUoJmtkZXYtPnBkZXYtPmRldiwgbnVtYV9ub2RlKTsKPiAgICAgICsJfSBlbHNl
Cj4gICAgICAgCQlzdWJfdHlwZV9oZHItPnByb3hpbWl0eV9kb21haW5fdG8gPSBrZGV2LT5wZGV2
LT5kZXYubnVtYV9ub2RlOwo+ICAgICAgICNlbHNlCj4gICAgICAgCXN1Yl90eXBlX2hkci0+cHJv
eGltaXR5X2RvbWFpbl90byA9IDA7Cj4gICAgICAtLQo+ICAgICAgMi4xNy4xCj4KPiAgICAgIF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gICAgICBhbWQt
Z2Z4IG1haWxpbmcgbGlzdAo+ICAgICAgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiAg
ICAgIGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUy
RmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q29hay56ZW5nJTQwYW1kLmNvbSU3Qzk2ODA4YTZh
YWI3YjQwODYxZWViMDhkOTBhNTgwNTI0JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4
M2QlN0MwJTdDMCU3QzYzNzU1MjE5NTQzNzEzOTI0OCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhl
eUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZD
STZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT12eDl3cUFlaEs3elVKeTJtVkFwOUtPVjN1NFpOdkUl
MkJtREdmR0dLJTJGOGNoVSUzRCZhbXA7cmVzZXJ2ZWQ9MAo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
